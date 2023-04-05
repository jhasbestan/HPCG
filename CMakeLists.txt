cmake_minimum_required(VERSION 3.14)

project(HPCG)

enable_language(C)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/CMakeModules/" )
message(${CMAKE_MODULE_PATH})

# read setup parameters
file(STRINGS ./config CONFIG_FILE ) 
while(CONFIG_FILE)
list(POP_FRONT CONFIG_FILE LINE)
string(CONCAT NAME "ENABLE_" ${LINE})
message("Read library as ${NAME}")
set(ENV{${NAME}} ON)
endwhile()

set(AVX512 mavx512f)
set(Common_C_FLAGS "${Common_C_FLAGS} -Wall -Wno-deprecated")
set(RELEASE_FLAGS "${Common_C_FLAGS} -O3 -march=skylake-avx512 -qopt-zmm-usage=high -fp-model fast=2 -no-prec-div")
set(RELEASE_FLAGS "${Common_C_FLAGS} -O3 -march=skylake-avx512 -fp-model fast=2 -no-prec-div")

find_package(MYMPI REQUIRED)
include_directories(${MPI_INCLUDES})

# auxil  blas  comm  grid  Makefile.am  Makefile.in  panel  pauxil  pfact  pgesv
##find_package(MYOPENBLAS REQUIRED)

if(DEFINED ENV{ENABLE_AOCL})
find_package(MYAOCL REQUIRED)
include_directories(${AOCL_INCLUDES}/include)
elseif(DEFINED ENV{ENABLE_OPENBLAS})
find_package(OPENBLAS REQUIRED)
include_directories(${OPENBLAS_INCLUDES}/openblas)
endif()

message("${CMAKE_SOURCE_DIR}")
include_directories(${CMAKE_SOURCE_DIR}/include/)

file(GLOB OBJ "${CMAKE_SOURCE_DIR}/src/*.cpp")  

add_executable(hpcg  ${OBJ} )
target_link_libraries(hpcg  ${MPI_LIB} ${OPENBLAS_LIB}  ${BLIS_LIB} ${BLISMT_LIB} -pthread -fopenmp)
target_include_directories(hpcg PUBLIC ${CMAKE_SOURCE_DIR}/include )

install(TARGETS hpcg DESTINATION ${CMAKE_SOURCE_DIR}/bin)






