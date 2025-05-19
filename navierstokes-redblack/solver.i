# 0 "solver.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 0 "<command-line>" 2
# 1 "solver.c"
# 1 "/usr/lib/gcc/x86_64-linux-gnu/11/include/stddef.h" 1 3 4
# 143 "/usr/lib/gcc/x86_64-linux-gnu/11/include/stddef.h" 3 4

# 143 "/usr/lib/gcc/x86_64-linux-gnu/11/include/stddef.h" 3 4
typedef long int ptrdiff_t;
# 209 "/usr/lib/gcc/x86_64-linux-gnu/11/include/stddef.h" 3 4
typedef long unsigned int size_t;
# 321 "/usr/lib/gcc/x86_64-linux-gnu/11/include/stddef.h" 3 4
typedef int wchar_t;
# 415 "/usr/lib/gcc/x86_64-linux-gnu/11/include/stddef.h" 3 4
typedef struct {
  long long __max_align_ll __attribute__((__aligned__(__alignof__(long long))));
  long double __max_align_ld __attribute__((__aligned__(__alignof__(long double))));
# 426 "/usr/lib/gcc/x86_64-linux-gnu/11/include/stddef.h" 3 4
} max_align_t;
# 2 "solver.c" 2

# 1 "solver.h" 1








# 8 "solver.h"
void dens_step(unsigned int h, unsigned int w, float *x, float *x0, float *u, float *v, float diff, float dt,int block);
void vel_step(unsigned int h,unsigned int w, float *u, float *v, float *u0, float *v0, float visc, float dt,int block);
# 4 "solver.c" 2
# 1 "indices.h" 1
       
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-function"

static inline size_t rb_idx(size_t x, size_t y, size_t dimy, size_t dimx) {
    size_t base = ((x % 2) ^ (y % 2)) * dimy * (dimx / 2);
    size_t offset = (x / 2) + y * (dimx / 2);
    return base + offset;
}

static inline size_t idx(size_t x, size_t y, size_t stride) {
    return x + y * stride;
}

#pragma GCC diagnostic pop
# 5 "solver.c" 2




typedef enum { NONE = 0, VERTICAL = 1, HORIZONTAL = 2 } boundary;
typedef enum { RED, BLACK } grid_color;

static void add_source(unsigned int n, float * x, const float * s, float dt)
{
    unsigned int size = (n + 2) * (n + 2);
    for (unsigned int i = 0; i < size; i++) {
        x[i] += dt * s[i];
    }
}

static void set_bnd(unsigned int n, boundary b, float * x)
{
    for (unsigned int i = 1; i <= n; i++) {
        x[(rb_idx((0),(i),(n+2)))] = b == VERTICAL ? -x[(rb_idx((1),(i),(n+2)))] : x[(rb_idx((1),(i),(n+2)))];
        x[(rb_idx((n + 1),(i),(n+2)))] = b == VERTICAL ? -x[(rb_idx((n),(i),(n+2)))] : x[(rb_idx((n),(i),(n+2)))];
        x[(rb_idx((i),(0),(n+2)))] = b == HORIZONTAL ? -x[(rb_idx((i),(1),(n+2)))] : x[(rb_idx((i),(1),(n+2)))];
        x[(rb_idx((i),(n + 1),(n+2)))] = b == HORIZONTAL ? -x[(rb_idx((i),(n),(n+2)))] : x[(rb_idx((i),(n),(n+2)))];
    }
    x[(rb_idx((0),(0),(n+2)))] = 0.5f * (x[(rb_idx((1),(0),(n+2)))] + x[(rb_idx((0),(1),(n+2)))]);
    x[(rb_idx((0),(n + 1),(n+2)))] = 0.5f * (x[(rb_idx((1),(n + 1),(n+2)))] + x[(rb_idx((0),(n),(n+2)))]);
    x[(rb_idx((n + 1),(0),(n+2)))] = 0.5f * (x[(rb_idx((n),(0),(n+2)))] + x[(rb_idx((n + 1),(1),(n+2)))]);
    x[(rb_idx((n + 1),(n + 1),(n+2)))] = 0.5f * (x[(rb_idx((n),(n + 1),(n+2)))] + x[(rb_idx((n + 1),(n),(n+2)))]);
}

static void lin_solve_rb_step(grid_color color,
                              unsigned int n,
                              float a,
                              float c,
                              const float * restrict same0,
                              const float * restrict neigh,
                              float * restrict same)
{
    int shift = color == RED ? 1 : -1;
    unsigned int start = color == RED ? 0 : 1;

    unsigned int width = (n + 2) / 2;

    for (unsigned int y = 1; y <= n; ++y, shift = -shift, start = 1 - start) {
        for (unsigned int x = start; x < width - (1 - start); ++x) {
            int index = idx(x, y, width);
            same[index] = (same0[index] + a * (neigh[index - width] +
                                               neigh[index] +
                                               neigh[index + shift] +
                                               neigh[index + width])) / c;
        }
    }
}

static void lin_solve(unsigned int n, boundary b,
                      float * restrict x,
                      const float * restrict x0,
                      float a, float c)
{
    unsigned int color_size = (n + 2) * ((n + 2) / 2);
    const float * red0 = x0;
    const float * blk0 = x0 + color_size;
    float * red = x;
    float * blk = x + color_size;

    for (unsigned int k = 0; k < 20; ++k) {
        lin_solve_rb_step(RED, n, a, c, red0, blk, red);
        lin_solve_rb_step(BLACK, n, a, c, blk0, red, blk);
        set_bnd(n, b, x);
    }
}

static void diffuse(unsigned int n, boundary b, float * x, const float * x0, float diff, float dt)
{
    float a = dt * diff * n * n;
    lin_solve(n, b, x, x0, a, 1 + 4 * a);
}

static void advect(unsigned int n, boundary b, float * d, const float * d0, const float * u, const float * v, float dt)
{
    int i0, i1, j0, j1;
    float x, y, s0, t0, s1, t1;

    float dt0 = dt * n;
    for (unsigned int i = 1; i <= n; i++) {
        for (unsigned int j = 1; j <= n; j++) {
            x = i - dt0 * u[(rb_idx((i),(j),(n+2)))];
            y = j - dt0 * v[(rb_idx((i),(j),(n+2)))];
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
            d[(rb_idx((i),(j),(n+2)))] = s0 * (t0 * d0[(rb_idx((i0),(j0),(n+2)))] + t1 * d0[(rb_idx((i0),(j1),(n+2)))]) +
                          s1 * (t0 * d0[(rb_idx((i1),(j0),(n+2)))] + t1 * d0[(rb_idx((i1),(j1),(n+2)))]);
        }
    }
    set_bnd(n, b, d);
}

static void project(unsigned int n, float *u, float *v, float *p, float *div)
{
    for (unsigned int i = 1; i <= n; i++) {
        for (unsigned int j = 1; j <= n; j++) {
            div[(rb_idx((i),(j),(n+2)))] = -0.5f * (u[(rb_idx((i + 1),(j),(n+2)))] - u[(rb_idx((i - 1),(j),(n+2)))] +
                                     v[(rb_idx((i),(j + 1),(n+2)))] - v[(rb_idx((i),(j - 1),(n+2)))]) / n;
            p[(rb_idx((i),(j),(n+2)))] = 0;
        }
    }
    set_bnd(n, NONE, div);
    set_bnd(n, NONE, p);

    lin_solve(n, NONE, p, div, 1, 4);

    for (unsigned int i = 1; i <= n; i++) {
        for (unsigned int j = 1; j <= n; j++) {
            u[(rb_idx((i),(j),(n+2)))] -= 0.5f * n * (p[(rb_idx((i + 1),(j),(n+2)))] - p[(rb_idx((i - 1),(j),(n+2)))]);
            v[(rb_idx((i),(j),(n+2)))] -= 0.5f * n * (p[(rb_idx((i),(j + 1),(n+2)))] - p[(rb_idx((i),(j - 1),(n+2)))]);
        }
    }
    set_bnd(n, VERTICAL, u);
    set_bnd(n, HORIZONTAL, v);
}

void dens_step(unsigned int n, float *x, float *x0, float *u, float *v, float diff, float dt)
{
    add_source(n, x, x0, dt);
    {float * tmp=x0;x0=x;x=tmp;};
    diffuse(n, NONE, x, x0, diff, dt);
    {float * tmp=x0;x0=x;x=tmp;};
    advect(n, NONE, x, x0, u, v, dt);
}

void vel_step(unsigned int n, float *u, float *v, float *u0, float *v0, float visc, float dt)
{
    add_source(n, u, u0, dt);
    add_source(n, v, v0, dt);
    {float * tmp=u0;u0=u;u=tmp;};
    diffuse(n, VERTICAL, u, u0, visc, dt);
    {float * tmp=v0;v0=v;v=tmp;};
    diffuse(n, HORIZONTAL, v, v0, visc, dt);
    project(n, u, v, u0, v0);
    {float * tmp=u0;u0=u;u=tmp;};
    {float * tmp=v0;v0=v;v=tmp;};
    advect(n, VERTICAL, u, u0, u0, v0, dt);
    advect(n, HORIZONTAL, v, v0, u0, v0, dt);
    project(n, u, v, u0, v0);
}
