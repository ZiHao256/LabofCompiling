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
include CMakeFiles/xkcd.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/xkcd.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/xkcd.dir/flags.make

CMakeFiles/xkcd.dir/examples/xkcd.cpp.o: CMakeFiles/xkcd.dir/flags.make
CMakeFiles/xkcd.dir/examples/xkcd.cpp.o: examples/xkcd.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/xkcd.dir/examples/xkcd.cpp.o"
	/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/xkcd.dir/examples/xkcd.cpp.o -c /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master/examples/xkcd.cpp

CMakeFiles/xkcd.dir/examples/xkcd.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/xkcd.dir/examples/xkcd.cpp.i"
	/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master/examples/xkcd.cpp > CMakeFiles/xkcd.dir/examples/xkcd.cpp.i

CMakeFiles/xkcd.dir/examples/xkcd.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/xkcd.dir/examples/xkcd.cpp.s"
	/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master/examples/xkcd.cpp -o CMakeFiles/xkcd.dir/examples/xkcd.cpp.s

# Object files for target xkcd
xkcd_OBJECTS = \
"CMakeFiles/xkcd.dir/examples/xkcd.cpp.o"

# External object files for target xkcd
xkcd_EXTERNAL_OBJECTS =

bin/xkcd: CMakeFiles/xkcd.dir/examples/xkcd.cpp.o
bin/xkcd: CMakeFiles/xkcd.dir/build.make
bin/xkcd: /usr/lib/x86_64-linux-gnu/libpython3.8.so
bin/xkcd: CMakeFiles/xkcd.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable bin/xkcd"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/xkcd.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/xkcd.dir/build: bin/xkcd

.PHONY : CMakeFiles/xkcd.dir/build

CMakeFiles/xkcd.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/xkcd.dir/cmake_clean.cmake
.PHONY : CMakeFiles/xkcd.dir/clean

CMakeFiles/xkcd.dir/depend:
	cd /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master/CMakeFiles/xkcd.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/xkcd.dir/depend

