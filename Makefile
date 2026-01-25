CC = gcc

# -----------------------------
# Defaults
# -----------------------------
BUILD    ?= debug
COMPILER ?= gfortran

# -----------------------------
# Fortran compiler + flags
# -----------------------------
ifeq ($(COMPILER),ifx)
#ifx (prep.: source /opt/intel/oneapi/setvars.sh)

    FC = ifx

    ifeq ($(BUILD),debug)
        FFLAGS = -g -O0 -i8 \
                 -warn all,nointerfaces,noexternals,nounused,nodeclarations \
                 -debug all -traceback \
                 -nogen-interfaces \
                 -save
#                 -check uninit
#                 -check bounds
    else
        FFLAGS = -O1 -i8 \
                 -nogen-interfaces \
                 -save
    endif

else
    # -------- gfortran (default) --------
    FC = gfortran

    FFLAGS_COMMON = -finteger-4-integer-8 -std=legacy -fno-automatic

    ifeq ($(BUILD),debug)
        FFLAGS = -g -O0 $(FFLAGS_COMMON) \
                 -Wall -Wextra -Wuninitialized -Wno-argument-mismatch
#                 -fcheck=all \
#                 -fbacktrace \
#                 -ffpe-trap=invalid,zero,overflow \
#                 -finit-real=snan -finit-integer=-999999
#                 -fallow-argument-mismatch \
#                 -malign-double
    else
        FFLAGS = -O1 $(FFLAGS_COMMON) \
                 -Wno-argument-mismatch
#                 -fno-strict-aliasing \
#                 -fno-aggressive-loop-optimizations
    endif
endif

# -----------------------------
# Objects & targets
# -----------------------------
OBJS = spice.o

.PHONY: all debug release clean

all: spice

# Convenience targets
debug:
	$(MAKE) BUILD=debug

release:
	$(MAKE) BUILD=release

spice: $(OBJS)
	$(FC) $(OBJS) -o spice
#	$(FC) $(OBJS) -check uninit -o spice

%.o: %.f
	$(FC) -c $(FFLAGS) $< -o $@

clean:
	rm -f $(OBJS) spice
