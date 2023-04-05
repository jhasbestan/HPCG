
set(MPI_ROOT $ENV{MPI_DIR})

if(NOT MPI_ROOT)
set(MPI_ROOT $ENV{MPI_HOME})
endif()

message("mpi direc ${MPI_ROOT}")
set(CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_SHARED_LIBRARY_SUFFIX} )

find_library(MPI_LIB 
             NAMES "mpi" 
             PATHS  ${MPI_ROOT}
             PATH_SUFFIXES "lib" "lib64"
             NO_DEFAULT_PATH)

find_path(MPI_INCLUDES
          NAMES "mpi.h"
          PATHS  ${MPI_ROOT}
          PATH_SUFFIXES "include"
          NO_DEFAULT_PATH)  
          
include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(MYMPI DEFAULT_MSG MPI_INCLUDES MPI_LIB)

