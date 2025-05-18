CC=gcc
N=512
CFLAGS=-std=c11 -Wall -Wextra -Wno-unused-parameter -DND=$(N) -save-temps
LDFLAGS=
TARGETS=demo headless
SOURCES=$(shell echo *.c)
SOLVER=1
SOLVERFILE=solver.o
SHOW=false



ifeq ($(CC), icc)
	CFLAGS += -diag-disable=10441 -xHost
endif


ifeq ($(O), 1)
	CFLAGS += -O3 -ffast-math -funsafe-math-optimizations  
else ifeq ($(O), 2)
	CFLAGS += -O3 -march=native
else ifeq ($(O), 3)
	CFLAGS += -O3 -ffast-math   
else ifeq ($(O), 4)
	CFLAGS += -O3 -ffast-math -march=native -ftree-vectorize -funsafe-math-optimizations
endif

ifeq ($(SOLVER), 2)
	SOLVERFILE=solver_block.o
endif	

ifeq ($(SHOW), true)
	CFLAGS+= -fopt-info
endif

COMMON_OBJECTS=$(SOLVERFILE) wtime.o

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
