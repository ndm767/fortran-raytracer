PNAME := raytracer

PFORTRANSRC := $(wildcard src/*.f90)

LDLIBS += -llapack -lblas

CC := gfortran

.PHONY: all clean

all:
	$(RM) image.ppm
	$(CC) $(PFORTRANSRC) -o $(PNAME) $(LDLIBS)

clean:
	$(RM) image.ppm
	$(RM) $(PNAME)