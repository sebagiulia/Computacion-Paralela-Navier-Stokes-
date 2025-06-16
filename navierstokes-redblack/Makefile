CC=gcc
N := 9
EXP := $(shell echo "2^$(N)" | bc)
CFLAGS=-std=c11 -Wall -Wextra -Wno-unused-parameter -DND=$(EXP) -save-temps
LDFLAGS=
TARGETS=demo headless
SOURCES=$(shell echo *.c)
SOLVER=1
SOLVERFILE=solver.o
SHOW=false



ifeq ($(CC), icc)
	CFLAGS += -diag-disable=10441 
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

demo: demo.o $(COMMON_OBJECTS)
	$(CC) $(CFLAGS) $^ -o demo $(LDFLAGS) -lGL -lGLU -lglut

headless: headless.o $(COMMON_OBJECTS)
	$(CC) $(CFLAGS) $^ -o headless $(LDFLAGS)

clean:
	rm -f $(TARGETS) *.o *.i *.s *.bc .depend *~

.depend: *.[ch]
	$(CC) -MM $(SOURCES) >.depend

-include .depend

.PHONY: clean all
