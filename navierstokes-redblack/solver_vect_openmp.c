#include <stddef.h>
#include <immintrin.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include "solver.h"
#include "indices.h"
#include <omp.h>

#define IX(x,y) (rb_idx((x),(y),h, w))
#define SWAP(x0,x) {float * tmp=x0;x0=x;x=tmp;}

typedef enum { NONE = 0, VERTICAL = 1, HORIZONTAL = 2 } boundary;
typedef enum { RED, BLACK } grid_color;

static void add_source(unsigned int h, unsigned int w, float * x, const float * s, float dt)
{
    unsigned int size = h * w;
    for (unsigned int i = 0; i < size; i++) {
        x[i] += dt * s[i];
    }
}

static void set_bnd(unsigned int h, unsigned int w, boundary b, float * x, int block)
{
    if (block == 0) { // bloque inferior
        for (unsigned int i = 1; i <= w - 2; i++) {
            x[IX(i, 0)] = b == HORIZONTAL ? -x[IX(i, 1)] : x[IX(i, 1)];
        }
        
        x[IX(0, 0)]         = 0.5f * (x[IX(1, 0)]         + x[IX(0, 1)]);
        x[IX(w - 1, 0)]     = 0.5f * (x[IX(w - 2, 0)]     + x[IX(w - 1, 1)]);

    } else if (block == omp_get_num_threads() - 1) { // bloque superior
        for (unsigned int i = 1; i <= w - 2; i++) {
            x[IX(i, h-1)] = b == HORIZONTAL ? -x[IX(i, h-2)] : x[IX(i, h-2)];
        }
        x[IX(0 , h - 1)]     = 0.5f * (x[IX(1, h - 1)] + x[IX(0, h - 2)]);
        x[IX(w - 1, h - 1)] = 0.5f * (x[IX(w - 2, h - 1)] + x[IX(w - 1, h - 2)]);
    } 
    
    // laterales
    for (unsigned int i = 0; i <= h - 2; i++) {
        x[IX(0, i)]     = b == VERTICAL ? -x[IX(1, i)] : x[IX(1, i)];
        x[IX(w - 1, i)] = b == VERTICAL ? -x[IX(w - 2, i)] : x[IX(w - 2, i)];
    }

}

static void lin_solve_rb_step_vect(unsigned int h,
                              grid_color color,
                              unsigned int width,
                              float a,
                              float c,
                              const float * restrict same0,
                              const float * restrict neigh,
                              float * restrict same)
{
    
    int shift = color == RED ? 1 : -1;
    unsigned int start = color == RED ? 0 : 1;

    __m256 a_vec = _mm256_set1_ps(a);
    __m256 c_vec = _mm256_set1_ps(c);
    
    for (unsigned int y = 1; y <= h; ++y, shift = -shift, start = 1 - start) {
        for (unsigned int x = start; x < width - (1 - start); x+=8) {

            int index = idx(x, y, width);
            __m256 top = _mm256_loadu_ps(&neigh[index - width]);
            __m256 left = _mm256_loadu_ps(&neigh[index]);
            __m256 right = _mm256_loadu_ps(&neigh[index + shift]);
            __m256 down = _mm256_loadu_ps(&neigh[index + width]);
            __m256 same0_vec = _mm256_loadu_ps(&same0[index]);

            __m256 sum = _mm256_add_ps(_mm256_add_ps(top, left), _mm256_add_ps(right, down));
            __m256 result = _mm256_add_ps(same0_vec, _mm256_mul_ps(a_vec, sum));
            result = _mm256_div_ps(result, c_vec);
            _mm256_storeu_ps(&same[index], result);
        }
    }

}

static void lin_solve(unsigned int h, unsigned int w, boundary b,
                      float * restrict x,
                      const float * restrict x0,
                      float a, float c, int block)
{
    unsigned int color_size = h * (w / 2);
    const float * red0 = x0;
    const float * blk0 = x0 + color_size;
    float * red = x;
    float * blk = x + color_size;
    unsigned int width = w / 2;

    for (unsigned int k = 0; k < 20; ++k) {
	    lin_solve_rb_step_vect(h, RED,   width, a, c, red0, blk, red);
        lin_solve_rb_step_vect(h, BLACK, width, a, c, blk0, red, blk);
        set_bnd(h, w, b, x, block);
    }
}

static void diffuse(unsigned int h, unsigned int w, boundary b, float * x, const float * x0, float diff, float dt, int block)
{

    float a = dt * diff * w * w;
    lin_solve(h,w, b, x, x0, a, 1 + 4 * a,block);
}

static void advect(unsigned int h, unsigned int w, boundary b, float * d, const float * d0, const float * u, const float * v, float dt,int block)
{
    int i0, i1, j0, j1;
    float x, y, s0, t0, s1, t1;

    float dt0 = dt * (w - 2);
    for (unsigned int i = 1; i <= w - 2; i++) {
        for (unsigned int j = 1; j <= h - 2; j++) {
            x = i - dt0 * u[IX(i, j)];
            y = j - dt0 * v[IX(i, j)];
            if (x < 0.5f) {
                x = 0.5f;
            } else if (x > (w - 2) + 0.5f) {
                x = (w - 2) + 0.5f;
            }
            i0 = (int) x;
            i1 = i0 + 1;
            if (y < 0.5f) {
                y = 0.5f;
            } else if (y > h + 0.5f) {
                y = h + 0.5f;
            }
            j0 = (int) y;
            j1 = j0 + 1;
            s1 = x - i0;
            s0 = 1 - s1;
            t1 = y - j0;
            t0 = 1 - t1;
            d[IX(i, j)] = s0 * (t0 * d0[IX(i0, j0)] + t1 * d0[IX(i0, j1)]) +
                          s1 * (t0 * d0[IX(i1, j0)] + t1 * d0[IX(i1, j1)]);
        }
    }
    set_bnd(h ,w, b, d, block);
}

static void project(unsigned int h, unsigned int w, float *u, float *v, float *p, float *div, int block)
{
    for (unsigned int i = 1; i <= w - 2; i++) {
        for (unsigned int j = 1; j <= h - 2; j++) {
            div[IX(i, j)] = -0.5f * (u[IX(i + 1, j)] - u[IX(i - 1, j)] +
                                     v[IX(i, j + 1)] - v[IX(i, j - 1)]) / w - 2;
            p[IX(i, j)] = 0;
        }
    }
    set_bnd(h, w, NONE, div, block);
    set_bnd(h, w, NONE, p, block);

    lin_solve(h, w, NONE, p, div, 1, 4, block);

    for (unsigned int i = 1; i <= w - 2; i++) {
        for (unsigned int j = 1; j <= h - 2; j++) {
            u[IX(i, j)] -= 0.5f * (w - 2) * (p[IX(i + 1, j)] - p[IX(i - 1, j)]);
            v[IX(i, j)] -= 0.5f * (w - 2) * (p[IX(i, j + 1)] - p[IX(i, j - 1)]);
        }
    }
    set_bnd(h,w, VERTICAL, u,block);
    set_bnd(h,w, HORIZONTAL, v,block);
}

void dens_step(unsigned int h, unsigned int w, float *x, float *x0, float *u, float *v, float diff, float dt, int block)
{
    add_source(h,w, x, x0, dt);
    add_source(h,w,  x, x0, dt);
    SWAP(x0, x);
    diffuse(h,w,  NONE, x, x0, diff, dt,block);
    SWAP(x0, x);
    advect(h,w,  NONE, x, x0, u, v, dt,block);
    #pragma omp barrier
}

void vel_step(unsigned int h, unsigned int w, float *u, float *v, float *u0, float *v0, float visc, float dt, int block)
{
    add_source(h,w, u, u0, dt);
    add_source(h,w, v, v0, dt);
    diffuse(h,w, VERTICAL, u, u0, visc, dt,block);
    SWAP(u0, u);
    SWAP(v0, v);
    diffuse(h,w, HORIZONTAL, v, v0, visc, dt,block);
    project(h,w, u, v, u0, v0,block);
    SWAP(u0, u);
    SWAP(v0, v);
    advect(h,w, VERTICAL, u, u0, u0, v0, dt,block);
    advect(h,w, HORIZONTAL, v, v0, u0, v0, dt,block);
    project(h,w, u, v, u0, v0, block);
    #pragma omp barrier
}
