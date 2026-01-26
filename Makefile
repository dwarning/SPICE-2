CC = gcc

# -----------------------------
# Defaults
# -----------------------------
BUILD    ?= debug
COMPILER ?= gfortran

# -----------------------------
# C flags
# -----------------------------
CFLAGS = -Wno-error

ifeq ($(BUILD),debug)
    CFLAGS += -g -O0
else
    CFLAGS += -O2
endif

# -----------------------------
# Fortran compiler + flags
# -----------------------------
ifeq ($(COMPILER),ifx)
#ifx (prep.: source /opt/intel/oneapi/setvars.sh)

    FC = ifx

    FFLAGS_COMMON = -i8 -save -nogen-interfaces

    ifeq ($(BUILD),debug)
        FFLAGS = -g -O0 $(FFLAGS_COMMON) \
                 -warn all,nointerfaces,noexternals,nounused,nodeclarations \
                 -debug all -traceback \
#                 -check uninit
#                 -check bounds
    else
        FFLAGS = -O1 $(FFLAGS_COMMON)
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
OBJS = spice.o unix.o

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

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

clean:
	rm -f $(OBJS) spice
