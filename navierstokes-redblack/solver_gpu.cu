#include <stddef.h>
#include <cuda_runtime.h>

#include "solver.h"

#define SWAP(x0,x) {float * tmp=x0;x0=x;x=tmp;}

typedef enum { NONE = 0, VERTICAL = 1, HORIZONTAL = 2 } boundary;
typedef enum { RED, BLACK } grid_color;

#define IX(x,y) (rb_idx((x),(y),(n+2)))

__device__ static inline size_t rb_idx(size_t x, size_t y, size_t dim) {
    size_t base = ((x % 2) ^ (y % 2)) * dim * (dim / 2);
    size_t offset = (x / 2) + y * (dim / 2);
    return base + offset;
}

__global__ static void add_source(unsigned int n, float * x, const float * s, float dt)
{
    size_t i = blockIdx.x * blockDim.x + threadIdx.x; 
    x[i] += dt * s[i];
}


__device__ static void set_bnd(unsigned int n, boundary b, float * x)
{
    for (unsigned int i = 1; i <= n; i++) {
        x[IX(0, i)]     = b == VERTICAL ? -x[IX(1, i)] : x[IX(1, i)];
        x[IX(n + 1, i)] = b == VERTICAL ? -x[IX(n, i)] : x[IX(n, i)];
        x[IX(i, 0)]     = b == HORIZONTAL ? -x[IX(i, 1)] : x[IX(i, 1)];
        x[IX(i, n + 1)] = b == HORIZONTAL ? -x[IX(i, n)] : x[IX(i, n)];
    }
    x[IX(0, 0)]         = 0.5f * (x[IX(1, 0)]     + x[IX(0, 1)]);
    x[IX(0, n + 1)]     = 0.5f * (x[IX(1, n + 1)] + x[IX(0, n)]);
    x[IX(n + 1, 0)]     = 0.5f * (x[IX(n, 0)]     + x[IX(n + 1, 1)]);
    x[IX(n + 1, n + 1)] = 0.5f * (x[IX(n, n + 1)] + x[IX(n + 1, n)]);
}

__device__ static void lin_solve_rb_step(grid_color color,
                              unsigned int n,
                              float a,
                              float c,
                              const float * __restrict__ same0,
                              const float * __restrict__ neigh,
                              float * __restrict__ same)
{
    size_t gid = blockIdx.x * blockDim.x + threadIdx.x; 
    
    int shift_color = color == RED ? 1 : -1;
    int shift_gid   = gid % 2 == 0 ? 1 : -1;
    int shift       = shift_color * shift_gid;

    unsigned int start = color == RED ? gid % 2 : (1 - (gid % 2));
    unsigned int width = (n + 2) / 2;
    unsigned int index = gid + width;
    //for (unsigned int y = 1; y <= n; ++y, shift = -shift, start = 1 - start) {
        //for (unsigned int x = start; x < width - (1 - start); ++x) {
            same[index] = (same0[index] + a * (neigh[index - width] +
                                               neigh[index] +
                                               neigh[index + shift] +
                                               neigh[index + width])) / c;
        //}
    //}
}

__global__ static void lin_solve(unsigned int n, boundary b,
                      float * __restrict__ x,
                      const float * __restrict__ x0,
                      float a, float c)
{
    size_t gid = blockIdx.x * blockDim.x + threadIdx.x; 
    
    unsigned int color_size = (n + 2) * ((n + 2) / 2);
    const float * red0 = x0;
    const float * blk0 = x0 + color_size;
    float * red = x;
    float * blk = x + color_size;
    for (unsigned int k = 0; k < 20; ++k) {
        lin_solve_rb_step(RED,   n, a, c, red0, blk, red);
        __syncthreads();
        lin_solve_rb_step(BLACK, n, a, c, blk0, red, blk);
	
	if (gid == 0)
	    set_bnd(n, b, x);
	
	__syncthreads();
    }
}


static void diffuse(unsigned int n, boundary b, float * x, const float * x0, float diff, float dt)
{
	float a = dt * diff * n * n;
	unsigned int block_size = 128;
	unsigned int active_cells = n * (n / 2);
	unsigned int num_blocks = (active_cells + block_size - 1) / block_size;

	lin_solve<<<num_blocks, block_size>>>(n, b, x, x0, a, 1 + 4 * a);
}

__global__ static void advect_kernel(unsigned int n, boundary b, float * d, const float * d0, const float * u, const float * v, float dt)
{
    int i0, i1, j0, j1, i, j;
    float x, y, s0, t0, s1, t1;
    float dt0 = dt * n;
    size_t gid = blockIdx.x * blockDim.x + threadIdx.x; 
    i = (gid / n) + 1; 
    j = (gid % n) + 1;
    x = i - dt0 * u[IX(i,j)];
    y = j - dt0 * v[IX(i,j)];
    if (x < 0.5f) {
	x = 0.5f;
    } else if (x > n + 0.5f) {
	x = n + 0.5f;
    }
    i0 = (int) x;
    i1 = i0 + 1;
    if (y < 0.5f) {
	y = 0.5f;
    } else if (y > n + 0.5f) {
	y = n + 0.5f;
    }
    j0 = (int) y;
    j1 = j0 + 1;
    s1 = x - i0;
    s0 = 1 - s1;
    t1 = y - j0;
    t0 = 1 - t1;
    d[IX(i,j)] = s0 * (t0 * d0[IX(i0, j0)] + t1 * d0[IX(i0, j1)]) +
		 s1 * (t0 * d0[IX(i1, j0)] + t1 * d0[IX(i1, j1)]);
    __syncthreads();
    if (gid == 0)
    	set_bnd(n, b, d);
}

static void advect(unsigned int n, boundary b, float * d, const float * d0, const float * u, const float * v, float dt)
{
    unsigned int block_size = 128;
    unsigned int num_blocks = n * n / block_size;
    advect_kernel<<<num_blocks,block_size>>>(n,b,d,d0,u,v,dt);
}

__global__ static void project_kernel1(unsigned int n, float *u, float *v, float *p, float *div)
{
    size_t gid = blockIdx.x * blockDim.x + threadIdx.x; 
    unsigned int i = (gid / n) + 1; 
    unsigned int j = (gid % n) + 1;
    div[IX(i, j)] = -0.5f * (u[IX(i + 1, j)] - u[IX(i - 1, j)] +
			     v[IX(i, j + 1)] - v[IX(i, j - 1)]) / n;
    p[IX(i, j)] = 0;
    __syncthreads();
    if (gid == 0)
    {
        set_bnd(n, NONE, div);
        set_bnd(n, NONE, p);
    }
}


__global__ static void project_kernel2(unsigned int n, float *u, float *v, float *p, float *div)
{
    size_t gid = blockIdx.x * blockDim.x + threadIdx.x; 
    unsigned int i = (gid / n) + 1; 
    unsigned int j = (gid % n) + 1;
    u[IX(i, j)] -= 0.5f * n * (p[IX(i + 1, j)] - p[IX(i - 1, j)]);
    v[IX(i, j)] -= 0.5f * n * (p[IX(i, j + 1)] - p[IX(i, j - 1)]);
    __syncthreads();
    if (gid == 0)
    {
	set_bnd(n, VERTICAL, u);
	set_bnd(n, HORIZONTAL, v);
    }
}

static void project(unsigned int n, float *u, float *v, float *p, float *div)
{
    unsigned int block_size = 128;
    unsigned int num_blocks = (n + 2) * ((n + 2) / 2) / block_size;
    unsigned int num_blocks_p = n * n / block_size;
    project_kernel1<<<num_blocks_p,block_size>>>(n, u, v, p, div);
    lin_solve<<<num_blocks,block_size>>>(n, NONE, p, div, 1, 4);
    project_kernel2<<<num_blocks_p,block_size>>>(n, u, v, p, div);
}

void dens_step(unsigned int n, float *x, float *x0, float *u, float *v, float diff, float dt)
{
    unsigned int block_size = 128;
    unsigned int num_blocks = n * n / block_size;
    add_source<<<num_blocks,block_size>>>(n, x, x0, dt);
    SWAP(x0, x);
    diffuse(n, NONE, x, x0, diff, dt);
    SWAP(x0, x);
    advect(n, NONE, x, x0, u, v, dt);
}

void vel_step(unsigned int n, float *u, float *v, float *u0, float *v0, float visc, float dt)
{
    unsigned int block_size = 128;
    unsigned int num_blocks = n * n / block_size;
    add_source<<<num_blocks,block_size>>>(n, u, u0, dt);
    add_source<<<num_blocks,block_size>>>(n, v, v0, dt);
    SWAP(u0, u);
    diffuse(n, VERTICAL, u, u0, visc, dt);
    SWAP(v0, v);
    diffuse(n, HORIZONTAL, v, v0, visc, dt);
    project(n, u, v, u0, v0);
    SWAP(u0, u);
    SWAP(v0, v);
    advect(n, VERTICAL, u, u0, u0, v0, dt);
    advect(n, HORIZONTAL, v, v0, u0, v0, dt);
    project(n, u, v, u0, v0);
}
