CC=gcc -O3 -ffast-math -save-temps -DNG=1024
CFLAGS=-std=c11 -Wall -Wextra -Wno-unused-parameter
LDFLAGS=

TARGETS1= demo1 headless1
TARGETS2= demo2 headless2
TARGETS3= demo3 headless3
SOURCES=$(shell echo *.c)
COMMON_OBJECTS=solver.o wtime.o

o1: $(TARGETS1) 

demo1: demo.o $(COMMON_OBJECTS)
	$(CC) $(CFLAGS) $^ -o demo $(LDFLAGS) -lGL -lGLU -lglut

headless1: headless.o $(COMMON_OBJECTS)
	$(CC) $(CFLAGS) $^ -o headless $(LDFLAGS)

o2: $(TARGETS2) 

demo2: demo.o $(COMMON_OBJECTS)
	$(CC) $(CFLAGS) -O3 $^ -o demo $(LDFLAGS) -lGL -lGLU -lglut

headless2: headless.o $(COMMON_OBJECTS)
	$(CC) $(CFLAGS) -O3 $^ -o headless $(LDFLAGS)

o3: $(TARGETS3) 

demo3: demo.o $(COMMON_OBJECTS)
	$(CC) $(CFLAGS) -O3 -ffast-math -march=native $^ -o demo $(LDFLAGS) -lGL -lGLU -lglut

headless3: headless.o $(COMMON_OBJECTS)
	$(CC) $(CFLAGS) -O3 -ffast-math -march=native $^ -o headless $(LDFLAGS)

clean:
	rm -f $(TARGETS) *.o *.i *.s .depend *~

.depend: *.[ch]
	$(CC) -MM $(SOURCES) >.depend


-include .depend

.PHONY: clean all
