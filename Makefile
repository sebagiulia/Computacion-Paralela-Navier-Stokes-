CC=gcc
N=512
CFLAGS=-std=c11 -Wall -Wextra -Wno-unused-parameter -DND=$(N) -save-temps
LDFLAGS=
COMMON_OBJECTS=solver.o wtime.o
TARGETS=demo headless
SOURCES=$(shell echo *.c)

ifeq ($(CC), icc)
	CFLAGS += -diag-disable=10441 
endif

ifeq ($(O), 1)
	CFLAGS += -O1
else ifeq ($(O), 2)
	CFLAGS += -O3
else ifeq ($(O), 3)
       	CFLAGS += -O3 -ffast-math -march=native  
else ifeq ($(O), 4)
       	CFLAGS += -O3 -ffast-math -march=native -ftree-vectorize -funsafe-math-optimizations
endif


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
