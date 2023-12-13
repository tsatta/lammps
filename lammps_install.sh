#/bin/bash
 mkdir build
 cd build
cmake -D PKG_RIGID=yes -D PKG_MOLECULE=yes \
 -D PKG_KSPACE=yes -D PKG_MDI=yes \
 -D BUILD_SHARED_LIBS=yes -D LAMMPS_MACHINE=mpi \
 -D BUILD_MPI=no -D BUILD_OMP=no \
 -D CMAKE_BUILD_TYPE=Debug -D PKG_MC=yes -D PKG_MANYBODY=yes \
 -D PKG_EXTRA-DUMP=yes -D PKG_GRANULAR=yes \
../cmake
 cd build; make -j10

# bulding LATTE
# cd /home/tsatta/LDRD/lammps_local/lib/latte
# python Install.py --build -m gfortran

