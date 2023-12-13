#!/bin/bash

# Unset all modules
module purge
source /opt/cray/pe/cpe/23.03/restore_lmod_system_defaults.sh

# Activate modules
module load craype-x86-milan
module load libfabric/1.15.2.0
module load craype-network-ofi
module load xpmem/2.5.2-2.4_3.45__gd0f7936.shasta
module load PrgEnv-gnu/8.3.3
module load cray-dsmml/0.2.2
module load cray-libsci/23.02.1.1
module load cray-mpich/8.1.25
module load craype/2.7.20
module load gcc/11.2.0
module load perftools-base/23.03.0
module load cpe/23.03
module load xalt/2.10.2
module load Nsight-Compute/2022.1.1
module load Nsight-Systems/2022.2.1
module load cudatoolkit/11.7
module load craype-accel-nvidia80
module load gpu/1.0
module load cray-python

# Deactivate conda
#source /global/common/software/nersc/pm-2022q3/sw/python/3.9-anaconda-2021.11/etc/profile.d/conda.sh
#conda deactivate

#git clone https://github.com/lammps/lammps.git build/lammps
mkdir -p build
cd build

cmake -DCMAKE_INSTALL_PREFIX=$PWD/../install_pm -D CMAKE_BUILD_TYPE=Release \
            -D CMAKE_Fortran_COMPILER=ftn -D CMAKE_C_COMPILER=cc -D CMAKE_CXX_COMPILER=CC \
            -D MPI_C_COMPILER=cc -D MPI_CXX_COMPILER=CC -D LAMMPS_EXCEPTIONS=ON \
            -D BUILD_SHARED_LIBS=ON -D PKG_KOKKOS=yes -D Kokkos_ARCH_AMPERE80=ON -D Kokkos_ENABLE_CUDA=yes \
            -D PKG_MANYBODY=ON -D PKG_MOLECULE=ON -D PKG_KSPACE=ON -D PKG_REPLICA=ON -D PKG_ASPHERE=ON \
            -D PKG_RIGID=ON -D PKG_MPIIO=ON -D PKG_MDI=yes -D PKG_MC=yes \
            -D CMAKE_POSITION_INDEPENDENT_CODE=ON -D CMAKE_EXE_FLAGS="-dynamic" ../cmake

make -j16
make install


#mkdir -p build
#cd build
#cmake -D PKG_RIGID=yes -D PKG_MOLECULE=yes -D PKG_KSPACE=yes -D PKG_MDI=yes -D BUILD_SHARED_LIBS=yes -D LAMMPS_MACHINE=mpi ../cmake
#make
