cmake_minimum_required(VERSION 3.19)
project(cuda_cube CUDA)

set(CMAKE_CUDA_STANDARD 14 )
set(CMAKE_CUDA_FLAGS " -Xcicc -O3, -Xcompiler -O2, -Xptxas -O3 ")
#
add_executable(cuda_cube main.cu consts.cu consts.cuh)

set_target_properties(
        cuda_cube
        PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)