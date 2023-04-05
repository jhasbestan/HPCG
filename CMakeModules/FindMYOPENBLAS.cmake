
set(OPENBLAS_ROOT $ENV{OPENBLAS_DIR})
message("OPENBLAS direc ${OPENBLAS_ROOT}")
set(CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_STATIC_LIBRARY_SUFFIX} )

find_library(OPENBLAS_LIB 
             NAMES "openblas" 
             PATHS  ${OPENBLAS_ROOT}
             PATH_SUFFIXES "lib64"
             NO_DEFAULT_PATH)

find_path(OPENBLAS_INCLUDES
          NAMES "cblas.h"
          PATHS  ${OPENBLAS_ROOT}/include/openblas
          PATH_SUFFIXES "include"
          NO_DEFAULT_PATH)  
          
include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(MYOPENBLAS DEFAULT_MSG OPENBLAS_INCLUDES OPENBLAS_LIB)

