/*
  ======================================================================
   demo.c --- protoype to show off the simple solver
  ----------------------------------------------------------------------
   Author : Jos Stam (jstam@aw.sgi.com)
   Creation Date : Jan 9 2003

   Description:

    This code is a simple prototype that demonstrates how to use the
    code provided in my GDC2003 paper entitles "Real-Time Fluid Dynamics
    for Games". This code uses OpenGL and GLUT for graphics and interface

  =======================================================================
*/

#include <stdlib.h>
#include <stdio.h>
#include <GL/glut.h>
#include "indices.h"
#include <cuda_runtime.h>
#include <cub/cub.cuh>

#include "solver.h"
#include "timing.h"

/* macros */

#define IX(x,y) (rb_idx((x),(y),(N+2)))

/* global variables */

static int N;
static float dt, diff, visc;
static float force, source;
static int dvel;

static float * u, * v, * u_prev, * v_prev;
static float * dens, * dens_prev;
static float * hu, * hv, * hu_prev, * hv_prev;
static float * hdens, * hdens_prev;

static int win_id;
static int win_x, win_y;
static int mouse_down[3];
static int omx, omy, mx, my;


/*
  ----------------------------------------------------------------------
   free/clear/allocate simulation data
  ----------------------------------------------------------------------
*/


static void free_data ( void )
{
	if ( hu ) free ( hu );
	if ( hv ) free ( hv );
	if ( hu_prev ) free ( hu_prev );
	if ( hv_prev ) free ( hv_prev );
	if ( hdens ) free ( hdens );
	if ( hdens_prev ) free ( hdens_prev );
	if ( u ) cudaFree ( u );
	if ( v ) cudaFree ( v );
	if ( u_prev ) cudaFree ( u_prev );
	if ( v_prev ) cudaFree ( v_prev );
	if ( dens ) cudaFree ( dens );
	if ( dens_prev ) cudaFree ( dens_prev );
}

static void clear_data ( void )
{
	int i, size=(N+2)*(N+2);
	for ( i=0 ; i<size ; i++ ) {
		hu[i] = hv[i] = hu_prev[i] = hv_prev[i] = hdens[i] = hdens_prev[i] = 0.0f;
	}
}

static int allocate_data ( void )
{
	int size = (N+2)*(N+2);

	cudaError_t ue = cudaMalloc((float **)&u, size*sizeof(float) );
	cudaError_t ve = cudaMalloc((float **)&v, size*sizeof(float) );
	cudaError_t dense = cudaMalloc((float **)&dens, size*sizeof(float) );
	cudaError_t upreve = cudaMalloc((float **)&u_prev, size*sizeof(float) );
	cudaError_t vpreve = cudaMalloc((float **)&v_prev, size*sizeof(float) );
	cudaError_t denspreve = cudaMalloc((float **)&dens_prev, size*sizeof(float) );

	if (ue != cudaSuccess ||
	    ve != cudaSuccess ||
	    dense != cudaSuccess ||
	    upreve != cudaSuccess ||
	    vpreve != cudaSuccess ||
	    denspreve != cudaSuccess)
	{
	    fprintf ( stderr, "cannot allocate gpu data\n" );
	    return ( 0 );
	}
	hu_prev	   = (float *) malloc ( size*sizeof(float) );
	hv_prev	   = (float *) malloc ( size*sizeof(float) );
	hdens_prev = (float *) malloc ( size*sizeof(float) );
	hu	   = (float *) malloc ( size*sizeof(float) );
	hv	   = (float *) malloc ( size*sizeof(float) );
	hdens      = (float *) malloc ( size*sizeof(float) );

	if ( !hu || !hv || !hu_prev || !hv_prev || !hdens || !hdens_prev ) {
		fprintf ( stderr, "cannot allocate data\n" );
		return ( 0 );
	}

	return ( 1 );
}

__global__ void compute_velocity2(const float* u, const float* v, float* velocity2, int size) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < size) {
        float ui = u[i];
        float vi = v[i];
        velocity2[i] = ui * ui + vi * vi;
    }
}


/*
  ----------------------------------------------------------------------
   OpenGL specific drawing routines
  ----------------------------------------------------------------------
*/

static void pre_display ( void )
{
	glViewport ( 0, 0, win_x, win_y );
	glMatrixMode ( GL_PROJECTION );
	glLoadIdentity ();
	gluOrtho2D ( 0.0, 1.0, 0.0, 1.0 );
	glClearColor ( 0.0f, 0.0f, 0.0f, 1.0f );
	glClear ( GL_COLOR_BUFFER_BIT );
}

static void post_display ( void )
{
	glutSwapBuffers ();
}

static void draw_velocity ( void )
{
	int i, j;
	float x, y, h;

	h = 1.0f/N;

	glColor3f ( 1.0f, 1.0f, 1.0f );
	glLineWidth ( 1.0f );

	glBegin ( GL_LINES );

		for ( i=1 ; i<=N ; i++ ) {
			x = (i-0.5f)*h;
			for ( j=1 ; j<=N ; j++ ) {
				y = (j-0.5f)*h;

				glVertex2f ( x, y );
				glVertex2f ( x+hu[IX(i,j)], y+hv[IX(i,j)] );
			}
		}

	glEnd ();
}

static void draw_density ( void )
{
	int i, j;
	float x, y, h, d00, d01, d10, d11;

	h = 1.0f/N;

	glBegin ( GL_QUADS );

		for ( i=0 ; i<=N ; i++ ) {
			x = (i-0.5f)*h;
			for ( j=0 ; j<=N ; j++ ) {
				y = (j-0.5f)*h;

				d00 = hdens[IX(i,j)];
				d01 = hdens[IX(i,j+1)];
				d10 = hdens[IX(i+1,j)];
				d11 = hdens[IX(i+1,j+1)];

				glColor3f ( d00, d00, d00 ); glVertex2f ( x, y );
				glColor3f ( d10, d10, d10 ); glVertex2f ( x+h, y );
				glColor3f ( d11, d11, d11 ); glVertex2f ( x+h, y+h );
				glColor3f ( d01, d01, d01 ); glVertex2f ( x, y+h );
			}
		}

	glEnd ();
}

/*
  ----------------------------------------------------------------------
   relates mouse movements to forces sources
  ----------------------------------------------------------------------
*/







static void react ( float * d_d, float * d_u, float * d_v )
{
    int size = (N + 2) * (N + 2);
    float max_velocity2, max_density;

    // --- Crear array temporal para velocity^2
    float* d_velocity2;
    cudaMalloc(&d_velocity2, size * sizeof(float));

    // --- 1. Calcular u^2 + v^2
    int blockSize = 256;
    int numBlocks = (size + blockSize - 1) / blockSize;
    compute_velocity2<<<numBlocks, blockSize>>>(d_u, d_v, d_velocity2, size);

    // --- 2. Usar CUB para obtener los máximos

    // 2.a max_density
    float* d_out_density;
    void* d_temp_storage_density = nullptr;
    size_t temp_storage_bytes_density = 0;
    cudaMalloc(&d_out_density, sizeof(float));
    cub::DeviceReduce::Max(nullptr, temp_storage_bytes_density, d_d, d_out_density, size);
    cudaMalloc(&d_temp_storage_density, temp_storage_bytes_density);
    cub::DeviceReduce::Max(d_temp_storage_density, temp_storage_bytes_density, d_d, d_out_density, size);

    // 2.b max_velocity2
    float* d_out_velocity2;
    void* d_temp_storage_velocity = nullptr;
    size_t temp_storage_bytes_velocity = 0;
    cudaMalloc(&d_out_velocity2, sizeof(float));
    cub::DeviceReduce::Max(nullptr, temp_storage_bytes_velocity, d_velocity2, d_out_velocity2, size);
    cudaMalloc(&d_temp_storage_velocity, temp_storage_bytes_velocity);
    cub::DeviceReduce::Max(d_temp_storage_velocity, temp_storage_bytes_velocity, d_velocity2, d_out_velocity2, size);

    // --- 3. Copiar máximos a host
    cudaMemcpy(&max_density, d_out_density, sizeof(float), cudaMemcpyDeviceToHost);
    cudaMemcpy(&max_velocity2, d_out_velocity2, sizeof(float), cudaMemcpyDeviceToHost);

    // --- 4. Resetear arrays a 0
    cudaMemset(d_u, 0, size * sizeof(float));
    cudaMemset(d_v, 0, size * sizeof(float));
    cudaMemset(d_d, 0, size * sizeof(float));

    // --- 5. Aplicar condiciones si hace falta
    int center = IX(N/2, N/2); 
    if (max_velocity2 < 0.0000005f) {
        float force_val = force * 10.0f;
        cudaMemcpy(&d_u[center], &force_val, sizeof(float), cudaMemcpyHostToDevice);
        cudaMemcpy(&d_v[center], &force_val, sizeof(float), cudaMemcpyHostToDevice);
    }
    if (max_density < 1.0f) {
        float source_val = source * 10.0f;
        cudaMemcpy(&d_d[center], &source_val, sizeof(float), cudaMemcpyHostToDevice);
    }

    // --- Cleanup
    cudaFree(d_velocity2);
    cudaFree(d_out_density);
    cudaFree(d_out_velocity2);
    cudaFree(d_temp_storage_density);
    cudaFree(d_temp_storage_velocity);
}


/*
  ----------------------------------------------------------------------
   GLUT callback routines
  ----------------------------------------------------------------------
*/

static void key_func ( unsigned char key, int x, int y )
{
	switch ( key )
	{
		case 'c':
		case 'C':
			clear_data ();
			break;

		case 'q':
		case 'Q':
			free_data ();
			exit ( 0 );
			break;

		case 'v':
		case 'V':
			dvel = !dvel;
			break;
	}
}

static void mouse_func ( int button, int state, int x, int y )
{
	omx = mx = x;
	omx = my = y;

	mouse_down[button] = state == GLUT_DOWN;
}

static void motion_func ( int x, int y )
{
	mx = x;
	my = y;
}

static void reshape_func ( int width, int height )
{
	glutSetWindow ( win_id );
	glutReshapeWindow ( width, height );

	win_x = width;
	win_y = height;
}

static void idle_func ( void )
{
static int size = (N+2)*(N+2);
	cudaError_t err_u         = cudaMemcpy(u, hu, size, cudaMemcpyHostToDevice);
	cudaError_t err_v         = cudaMemcpy(v, hv, size, cudaMemcpyHostToDevice);
	cudaError_t err_dens      = cudaMemcpy(dens, hdens, size, cudaMemcpyHostToDevice);
	cudaError_t err_u_prev    = cudaMemcpy(u_prev, hu_prev, size, cudaMemcpyHostToDevice);
	cudaError_t err_v_prev    = cudaMemcpy(v_prev, hv_prev, size, cudaMemcpyHostToDevice);
	cudaError_t err_dens_prev = cudaMemcpy(dens_prev, hdens_prev, size, cudaMemcpyHostToDevice);

	if (err_u != cudaSuccess ||
	    err_v != cudaSuccess ||
	    err_dens != cudaSuccess ||
	    err_u_prev != cudaSuccess ||
	    err_v_prev != cudaSuccess ||
	    err_dens_prev != cudaSuccess)
	{
	    fprintf(stderr, "Error al copiar memoria de host a device\n");
	    return;
	}
	static int times = 1;
        static double react_ns_p_cell = 0.0;
        static double vel_ns_p_cell = 0.0;
        static double dens_ns_p_cell = 0.0;
        static float  milliseconds;
        static cudaEvent_t start = nullptr, stop = nullptr, current = nullptr, one_second = nullptr;
        if (one_second == nullptr)
        {
            cudaEventCreate(&one_second);
            cudaEventRecord(one_second);
	    cudaEventCreate(&start);
	    cudaEventCreate(&stop);
	    cudaEventCreate(&current);
        }

        cudaEventRecord(start);
        react ( dens_prev, u_prev, v_prev );
        cudaEventRecord(stop);
	cudaEventSynchronize(stop);
        cudaEventElapsedTime(&milliseconds, start, stop);
        react_ns_p_cell += (N * N) / (1.0e3 * milliseconds);

        cudaEventRecord(start);
        vel_step ( N, u, v, u_prev, v_prev, visc, dt );
        cudaEventRecord(stop);
	cudaEventSynchronize(stop);
        cudaEventElapsedTime(&milliseconds, start, stop);
        vel_ns_p_cell += (N * N) / (1.0e3 * milliseconds);

        cudaEventRecord(start);
        dens_step ( N, dens, dens_prev, u, v, diff, dt );
        cudaEventRecord(stop);
	cudaEventSynchronize(stop);
        cudaEventElapsedTime(&milliseconds, start, stop);
        dens_ns_p_cell += (N * N) / (1.0e3 * milliseconds);

        cudaEventRecord(current);
	cudaEventSynchronize(current);
        cudaError_t salida = cudaEventElapsedTime(&milliseconds, one_second, current);
        if (salida == cudaErrorInvalidValue)
	{
		printf("Error al obtener tiempo entre current y one second\n");
		return;
	}
	if (1000.0f <= milliseconds) { /* at least 1s between stats */
                printf("%lf, %lf, %lf, %lf: ns per cell total, react, vel_step, dens_step\n",
                        (react_ns_p_cell+vel_ns_p_cell+dens_ns_p_cell)/times,
                        react_ns_p_cell/times, vel_ns_p_cell/times, dens_ns_p_cell/times);
                cudaEventRecord(one_second);
                react_ns_p_cell = 0.0;
                vel_ns_p_cell = 0.0;
                dens_ns_p_cell = 0.0;
                times = 1;
        } else {
                times++;
	}
	cudaDeviceSynchronize();
	err_u         = cudaMemcpy(hu, u, size, cudaMemcpyDeviceToHost);
	err_v         = cudaMemcpy(hv, v, size, cudaMemcpyDeviceToHost);
        err_dens      = cudaMemcpy(hdens, dens, size, cudaMemcpyDeviceToHost);
	err_u_prev    = cudaMemcpy(hu_prev, u_prev, size, cudaMemcpyDeviceToHost);
	err_v_prev    = cudaMemcpy(hv_prev, v_prev, size, cudaMemcpyDeviceToHost);
	err_dens_prev = cudaMemcpy(hdens_prev, dens_prev, size, cudaMemcpyDeviceToHost);
	if (err_u != cudaSuccess ||
	    err_v != cudaSuccess ||
	    err_dens != cudaSuccess ||
	    err_u_prev != cudaSuccess ||
	    err_v_prev != cudaSuccess ||
	    err_dens_prev != cudaSuccess)
	{
	    fprintf(stderr, "Error al copiar memoria de device a host\n");
	    return;
	}

		
	glutSetWindow ( win_id );
	glutPostRedisplay ();
}

static void display_func ( void )
{
	pre_display ();

		if ( dvel ) draw_velocity ();
		else		draw_density ();

	post_display ();
}


/*
  ----------------------------------------------------------------------
   open_glut_window --- open a glut compatible window and set callbacks
  ----------------------------------------------------------------------
*/

static void open_glut_window ( void )
{
	glutInitDisplayMode ( GLUT_RGBA | GLUT_DOUBLE );

	glutInitWindowPosition ( 0, 0 );
	glutInitWindowSize ( win_x, win_y );
	win_id = glutCreateWindow ( "Alias | wavefront" );

	glClearColor ( 0.0f, 0.0f, 0.0f, 1.0f );
	glClear ( GL_COLOR_BUFFER_BIT );
	glutSwapBuffers ();
	glClear ( GL_COLOR_BUFFER_BIT );
	glutSwapBuffers ();

	pre_display ();

	glutKeyboardFunc ( key_func );
	glutMouseFunc ( mouse_func );
	glutMotionFunc ( motion_func );
	glutReshapeFunc ( reshape_func );
	glutIdleFunc ( idle_func );
	glutDisplayFunc ( display_func );
}


/*
  ----------------------------------------------------------------------
   main --- main routine
  ----------------------------------------------------------------------
*/

int main ( int argc, char ** argv )
{
	glutInit ( &argc, argv );

	if ( argc != 1 && argc != 6 ) {
		fprintf ( stderr, "usage : %s N dt diff visc force source\n", argv[0] );
		fprintf ( stderr, "where:\n" );\
		fprintf ( stderr, "\t N      : grid resolution\n" );
		fprintf ( stderr, "\t dt     : time step\n" );
		fprintf ( stderr, "\t diff   : diffusion rate of the density\n" );
		fprintf ( stderr, "\t visc   : viscosity of the fluid\n" );
		fprintf ( stderr, "\t force  : scales the mouse movement that generate a force\n" );
		fprintf ( stderr, "\t source : amount of density that will be deposited\n" );
		exit ( 1 );
	}

#ifndef ND
    N = 128;
#else
    N = ND;
#endif
		dt = 0.1f;
		diff = 0.0f;
		visc = 0.0f;
		force = 5.0f;
		source = 100.0f;
		fprintf ( stderr, "Using defaults : N=%d dt=%g diff=%g visc=%g force = %g source=%g\n",
			N, dt, diff, visc, force, source );

	printf ( "\n\nHow to use this demo:\n\n" );
	printf ( "\t Add densities with the right mouse button\n" );
	printf ( "\t Add velocities with the left mouse button and dragging the mouse\n" );
	printf ( "\t Toggle density/velocity display with the 'v' key\n" );
	printf ( "\t Clear the simulation by pressing the 'c' key\n" );
	printf ( "\t Quit by pressing the 'q' key\n" );

	dvel = 0;

	if ( !allocate_data () ) exit ( 1 );
	clear_data ();

	win_x = 512;
	win_y = 512;
	open_glut_window ();

	glutMainLoop ();

	exit ( 0 );
}
