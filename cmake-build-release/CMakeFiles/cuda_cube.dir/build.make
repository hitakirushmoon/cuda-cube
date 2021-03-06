# CMAKE generated file: DO NOT EDIT!
# Generated by "NMake Makefiles" Generator, CMake Version 3.20

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE
NULL=nul
!ENDIF
SHELL = cmd.exe

# The CMake executable.
CMAKE_COMMAND = C:\Users\PC\AppData\Local\JetBrains\Toolbox\apps\CLion\ch-0\212.5457.51\bin\cmake\win\bin\cmake.exe

# The command to remove a file.
RM = C:\Users\PC\AppData\Local\JetBrains\Toolbox\apps\CLion\ch-0\212.5457.51\bin\cmake\win\bin\cmake.exe -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = E:\Documents\CLionProjects\cuda-cube

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = E:\Documents\CLionProjects\cuda-cube\cmake-build-release

# Include any dependencies generated for this target.
include CMakeFiles\cuda_cube.dir\depend.make
# Include the progress variables for this target.
include CMakeFiles\cuda_cube.dir\progress.make

# Include the compile flags for this target's objects.
include CMakeFiles\cuda_cube.dir\flags.make

CMakeFiles\cuda_cube.dir\main.cu.obj: CMakeFiles\cuda_cube.dir\flags.make
CMakeFiles\cuda_cube.dir\main.cu.obj: ..\main.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=E:\Documents\CLionProjects\cuda-cube\cmake-build-release\CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CUDA object CMakeFiles/cuda_cube.dir/main.cu.obj"
	C:\PROGRA~1\NVIDIA~2\CUDA\v11.4\bin\nvcc.exe -forward-unknown-to-host-compiler $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -dc E:\Documents\CLionProjects\cuda-cube\main.cu -o CMakeFiles\cuda_cube.dir\main.cu.obj -Xcompiler=-FdCMakeFiles\cuda_cube.dir\,-FS

CMakeFiles\cuda_cube.dir\main.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/cuda_cube.dir/main.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles\cuda_cube.dir\main.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/cuda_cube.dir/main.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

CMakeFiles\cuda_cube.dir\consts.cu.obj: CMakeFiles\cuda_cube.dir\flags.make
CMakeFiles\cuda_cube.dir\consts.cu.obj: ..\consts.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=E:\Documents\CLionProjects\cuda-cube\cmake-build-release\CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CUDA object CMakeFiles/cuda_cube.dir/consts.cu.obj"
	C:\PROGRA~1\NVIDIA~2\CUDA\v11.4\bin\nvcc.exe -forward-unknown-to-host-compiler $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -dc E:\Documents\CLionProjects\cuda-cube\consts.cu -o CMakeFiles\cuda_cube.dir\consts.cu.obj -Xcompiler=-FdCMakeFiles\cuda_cube.dir\,-FS

CMakeFiles\cuda_cube.dir\consts.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/cuda_cube.dir/consts.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles\cuda_cube.dir\consts.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/cuda_cube.dir/consts.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

# Object files for target cuda_cube
cuda_cube_OBJECTS = \
"CMakeFiles\cuda_cube.dir\main.cu.obj" \
"CMakeFiles\cuda_cube.dir\consts.cu.obj"

# External object files for target cuda_cube
cuda_cube_EXTERNAL_OBJECTS =

CMakeFiles\cuda_cube.dir\cmake_device_link.obj: CMakeFiles\cuda_cube.dir\main.cu.obj
CMakeFiles\cuda_cube.dir\cmake_device_link.obj: CMakeFiles\cuda_cube.dir\consts.cu.obj
CMakeFiles\cuda_cube.dir\cmake_device_link.obj: CMakeFiles\cuda_cube.dir\build.make
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=E:\Documents\CLionProjects\cuda-cube\cmake-build-release\CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CUDA device code CMakeFiles\cuda_cube.dir\cmake_device_link.obj"
	C:\PROGRA~1\NVIDIA~2\CUDA\v11.4\bin\nvcc.exe -forward-unknown-to-host-compiler  -Xcicc -O3, -Xcompiler -O2, -Xptxas -O3  -Xcompiler="-O2 -Ob2" -DNDEBUG --generate-code=arch=compute_52,code=[compute_52,sm_52] -Xcompiler=-MD -Wno-deprecated-gpu-targets -shared -dlink $(cuda_cube_OBJECTS) $(cuda_cube_EXTERNAL_OBJECTS) -o CMakeFiles\cuda_cube.dir\cmake_device_link.obj  cudadevrt.lib cudart_static.lib kernel32.lib user32.lib gdi32.lib winspool.lib shell32.lib ole32.lib oleaut32.lib uuid.lib comdlg32.lib advapi32.lib  -Xcompiler=-FdE:\Documents\CLionProjects\cuda-cube\cmake-build-release\CMakeFiles\cuda_cube.dir\,-FS

# Rule to build all files generated by this target.
CMakeFiles\cuda_cube.dir\build: CMakeFiles\cuda_cube.dir\cmake_device_link.obj
.PHONY : CMakeFiles\cuda_cube.dir\build

# Object files for target cuda_cube
cuda_cube_OBJECTS = \
"CMakeFiles\cuda_cube.dir\main.cu.obj" \
"CMakeFiles\cuda_cube.dir\consts.cu.obj"

# External object files for target cuda_cube
cuda_cube_EXTERNAL_OBJECTS =

cuda_cube.exe: CMakeFiles\cuda_cube.dir\main.cu.obj
cuda_cube.exe: CMakeFiles\cuda_cube.dir\consts.cu.obj
cuda_cube.exe: CMakeFiles\cuda_cube.dir\build.make
cuda_cube.exe: CMakeFiles\cuda_cube.dir\cmake_device_link.obj
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=E:\Documents\CLionProjects\cuda-cube\cmake-build-release\CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CUDA executable cuda_cube.exe"
	C:\Users\PC\AppData\Local\JetBrains\Toolbox\apps\CLion\ch-0\212.5457.51\bin\cmake\win\bin\cmake.exe -E vs_link_exe --intdir=CMakeFiles\cuda_cube.dir --rc=C:\PROGRA~2\WI3CF2~1\10\bin\100190~1.0\x64\rc.exe --mt=C:\PROGRA~2\WI3CF2~1\10\bin\100190~1.0\x64\mt.exe --manifests -- C:\PROGRA~2\MICROS~2\2019\COMMUN~1\VC\Tools\MSVC\1428~1.299\bin\Hostx64\x64\link.exe /nologo $(cuda_cube_OBJECTS) $(cuda_cube_EXTERNAL_OBJECTS) CMakeFiles\cuda_cube.dir\cmake_device_link.obj @<<
 /out:cuda_cube.exe /implib:cuda_cube.lib /pdb:E:\Documents\CLionProjects\cuda-cube\cmake-build-release\cuda_cube.pdb /version:0.0 /INCREMENTAL:NO /subsystem:console  cudadevrt.lib cudart_static.lib kernel32.lib user32.lib gdi32.lib winspool.lib shell32.lib ole32.lib oleaut32.lib uuid.lib comdlg32.lib advapi32.lib  -LIBPATH:"C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.4/lib/x64" 
<<

# Rule to build all files generated by this target.
CMakeFiles\cuda_cube.dir\build: cuda_cube.exe
.PHONY : CMakeFiles\cuda_cube.dir\build

CMakeFiles\cuda_cube.dir\clean:
	$(CMAKE_COMMAND) -P CMakeFiles\cuda_cube.dir\cmake_clean.cmake
.PHONY : CMakeFiles\cuda_cube.dir\clean

CMakeFiles\cuda_cube.dir\depend:
	$(CMAKE_COMMAND) -E cmake_depends "NMake Makefiles" E:\Documents\CLionProjects\cuda-cube E:\Documents\CLionProjects\cuda-cube E:\Documents\CLionProjects\cuda-cube\cmake-build-release E:\Documents\CLionProjects\cuda-cube\cmake-build-release E:\Documents\CLionProjects\cuda-cube\cmake-build-release\CMakeFiles\cuda_cube.dir\DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles\cuda_cube.dir\depend

