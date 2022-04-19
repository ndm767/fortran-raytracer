PNAME := raytracer

PFORTRANSRC := $(wildcard src/*.f90)

CC := gfortran

.PHONY: all clean

all:
	$(RM) image.ppm
	$(CC) $(PFORTRANSRC) -o $(PNAME)

clean:
	$(RM) image.ppm
	$(RM) $(PNAME)
	$(RM) *.mod