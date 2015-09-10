# ============================================================================
# Name        : Makefile
# Author      : valter oliveira
# Copyright   : Your copyright notice
# Description : Makefile for EDGAR to HDF5 in Fortran
# ============================================================================

#.PHONY: h5 clean edgar ctl
.PHONY: clean

include include.mk.$(OPT)

INCLUDES=$(NETCDF_INC)
# INCLUDES=$(NETCDF_INC) $(HDF5_INC)

LIBS=$(NETCDF_LIBS)
# LIBS=$(NETCDF_LIBS) $(HDF5_LIB)
F_COMMAND=$(F_COMP) -c $(F_OPTS) $(INCLUDES)

read: ./read_bsc.f90
	$(LOADER) $(LOADER_OPTS) \
		read_bsc.f90 -o read_bsc.x \
		$(INCLUDES) $(LIBS)

read_levels: ./read_bsc_levels.f90
	$(LOADER) $(LOADER_OPTS) \
		read_bsc_levels.f90 -o read_bsc_levels.x \
		$(INCLUDES) $(LIBS)

# read: ./EdgarToH5.f90
# 	$(LOADER) $(LOADER_OPTS) \
# 		EdgarToH5.f90 hdf5MOD.o -o edgar \
# 		$(INCLUDES) $(LIBS)

# ctl: ./create_ctl.f90
# 	$(LOADER) $(LOADER_OPTS) \
# 		create_ctl.f90 -o ctl \
# 		$(INCLUDES) $(LIBS)

# h5: ./hdf5MOD.f90
# 	$(LOADER) $(LOADER_OPTS) \
# 		hdf5MOD.f90 -c \
# 		$(INCLUDES) $(LIBS)

all: clean read read_levels

clean:
	rm -f *.mod *.o *.x
