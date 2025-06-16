CC=gcc
N := 9
EXP := $(shell echo "2^$(N)" | bc)
CFLAGS=-std=c11 -Wall -Wextra -Wno-unused-parameter -DND=$(EXP) -save-temps
LDFLAGS=
TARGETS=demo headless
SOURCES=$(shell echo *.c)
SOURCESCU=$(shell echo *.cu)
SOLVER=1
SOLVERFILE=solver.o
SHOW=false



ifeq ($(CC), icc)
	CFLAGS += -diag-disable=10441
else ifeq ($(CC), nvcc)
	CFLAGS = -std=c++11 -Xptxas -v -DND=$(EXP)
	SOLVERFILE = solver_gpu.o
endif

ifeq ($(O), 1)
	CFLAGS += -O1
else ifeq ($(O), 2)
	CFLAGS += -O3 -ffast-math
else ifeq ($(O), 3)
	CFLAGS += -O3 -ffast-math -march=native  
else ifeq ($(O), 4)
	CFLAGS += -O3 -ffast-math -march=native -ftree-vectorize -funsafe-math-optimizations
else ifeq ($(O), 5)
	CFLAGS += -O3 -ffast-math -march=native -ftree-vectorize -funsafe-math-optimizations -fopenmp
else ifeq ($(O), 6)
	CFLAGS += -O3 -ffast-math -fopenmp
endif



ifeq ($(SOLVER), 2)
	SOLVERFILE=solver_vect.o
else ifeq ($(SOLVER), 3)
	SOLVERFILE=solver_vect_openmp.o
endif	

ifeq ($(SHOW), true)
	CFLAGS+= -fopt-info
endif

COMMON_OBJECTS=$(SOLVERFILE) timing.o

all: $(TARGETS) 


ifeq ($(CC), nvcc)
demo: demo_gpu.o $(COMMON_OBJECTS)
	$(CC) $(CFLAGS) $^ -o demo $(LDFLAGS) -lGL -lGLU -lglut

headless: headless_gpu.o $(COMMON_OBJECTS)
	$(CC) $(CFLAGS) $^ -o headless $(LDFLAGS)
else
demo: demo.o $(COMMON_OBJECTS)
	$(CC) $(CFLAGS) $^ -o demo $(LDFLAGS) -lGL -lGLU -lglut

headless: headless.o $(COMMON_OBJECTS)
	$(CC) $(CFLAGS) $^ -o headless $(LDFLAGS)
endif

%.o: %.cu
	nvcc $(CFLAGS) -c $< -o $@

clean:
	rm -f $(TARGETS) *.o *.i *.s *.bc .depend *~

ifeq ($(CC), nvcc)
.depend: *.[ch]
	$(CC) -MM $(SOURCESCU) >.depend
else
.depend: *.[ch]
	$(CC) -MM $(SOURCES) >.depend
endif
-include .depend

.PHONY: clean all
