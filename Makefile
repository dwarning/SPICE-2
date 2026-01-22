CC = gcc
CFLAGS = -g -O0 -Wno-error
FC = ifx
#FC = gfortran

ifeq ($(FC),ifx)
#ifx (prep.: source /opt/intel/oneapi/setvars.sh)
	FFLAGS = -g -O0 -i8 \
			-warn all,nointerfaces,noexternals,nounused,nodeclarations \
			-debug all -traceback \
			-nogen-interfaces \
			-save
#			-check uninit
#			-check bounds
else
#gfortran
	FFLAGS = -g -O0 -finteger-4-integer-8 -std=legacy \
			-Wall -Wextra -Wuninitialized -Wno-argument-mismatch \
			-fno-automatic
#			-fallow-argument-mismatch \
#			-fdec-char-conversions \
#			-malign-double
endif

OBJS = spice.o unix.o

all: spice

spice: $(OBJS)
	$(FC) $(OBJS) -o spice
#	$(FC) $(OBJS) -check uninit -o spice

%.o: %.f
	$(FC) -c $(FFLAGS) $*.f -o $*.o 

%.o: %.c
	$(CC) $(CFLAGS) -c $*.c -o $*.o

clean:
	rm -f $(OBJS) spice

