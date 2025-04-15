//
// solver.h
//

#ifndef SOLVER_H_INCLUDED
#define SOLVER_H_INCLUDED

void dens_step(unsigned int n, float *x, float *x0, float *u, float *v, float diff, float dt);
void vel_step(unsigned int n, float *u, float *v, float *u0, float *v0, float visc, float dt);

#endif /* SOLVER_H_INCLUDED */
