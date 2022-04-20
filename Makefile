PNAME := raytracer

PFORTRANSRC := $(wildcard src/*.f90)
PFORTRANSRC += $(wildcard src/*.c)

LDLIBS += -lSDL2

CC := gfortran

.PHONY: all clean

all:
	$(CC) $(PFORTRANSRC) -o $(PNAME) $(LDLIBS)

clean:
	$(RM) $(PNAME)
	$(RM) *.mod