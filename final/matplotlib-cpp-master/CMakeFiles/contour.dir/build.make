# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master

# Include any dependencies generated for this target.
include CMakeFiles/contour.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/contour.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/contour.dir/flags.make

CMakeFiles/contour.dir/examples/contour.cpp.o: CMakeFiles/contour.dir/flags.make
CMakeFiles/contour.dir/examples/contour.cpp.o: examples/contour.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/contour.dir/examples/contour.cpp.o"
	/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/contour.dir/examples/contour.cpp.o -c /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master/examples/contour.cpp

CMakeFiles/contour.dir/examples/contour.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/contour.dir/examples/contour.cpp.i"
	/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master/examples/contour.cpp > CMakeFiles/contour.dir/examples/contour.cpp.i

CMakeFiles/contour.dir/examples/contour.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/contour.dir/examples/contour.cpp.s"
	/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master/examples/contour.cpp -o CMakeFiles/contour.dir/examples/contour.cpp.s

# Object files for target contour
contour_OBJECTS = \
"CMakeFiles/contour.dir/examples/contour.cpp.o"

# External object files for target contour
contour_EXTERNAL_OBJECTS =

bin/contour: CMakeFiles/contour.dir/examples/contour.cpp.o
bin/contour: CMakeFiles/contour.dir/build.make
bin/contour: /usr/lib/x86_64-linux-gnu/libpython3.8.so
bin/contour: CMakeFiles/contour.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable bin/contour"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/contour.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/contour.dir/build: bin/contour

.PHONY : CMakeFiles/contour.dir/build

CMakeFiles/contour.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/contour.dir/cmake_clean.cmake
.PHONY : CMakeFiles/contour.dir/clean

CMakeFiles/contour.dir/depend:
	cd /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master/CMakeFiles/contour.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/contour.dir/depend

