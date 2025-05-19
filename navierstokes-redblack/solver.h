//
// solver.h
//

#ifndef SOLVER_H_INCLUDED
#define SOLVER_H_INCLUDED

void dens_step(unsigned int h, unsigned int w, float *x, float *x0, float *u, float *v, float diff, float dt,int block);
void vel_step(unsigned int h,unsigned int w, float *u, float *v, float *u0, float *v0, float visc, float dt,int block);

#endif /* SOLVER_H_INCLUDED */
