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
include CMakeFiles/bar.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/bar.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/bar.dir/flags.make

CMakeFiles/bar.dir/examples/bar.cpp.o: CMakeFiles/bar.dir/flags.make
CMakeFiles/bar.dir/examples/bar.cpp.o: examples/bar.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/bar.dir/examples/bar.cpp.o"
	/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/bar.dir/examples/bar.cpp.o -c /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master/examples/bar.cpp

CMakeFiles/bar.dir/examples/bar.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/bar.dir/examples/bar.cpp.i"
	/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master/examples/bar.cpp > CMakeFiles/bar.dir/examples/bar.cpp.i

CMakeFiles/bar.dir/examples/bar.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/bar.dir/examples/bar.cpp.s"
	/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master/examples/bar.cpp -o CMakeFiles/bar.dir/examples/bar.cpp.s

# Object files for target bar
bar_OBJECTS = \
"CMakeFiles/bar.dir/examples/bar.cpp.o"

# External object files for target bar
bar_EXTERNAL_OBJECTS =

bin/bar: CMakeFiles/bar.dir/examples/bar.cpp.o
bin/bar: CMakeFiles/bar.dir/build.make
bin/bar: /usr/lib/x86_64-linux-gnu/libpython3.8.so
bin/bar: CMakeFiles/bar.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable bin/bar"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/bar.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/bar.dir/build: bin/bar

.PHONY : CMakeFiles/bar.dir/build

CMakeFiles/bar.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/bar.dir/cmake_clean.cmake
.PHONY : CMakeFiles/bar.dir/clean

CMakeFiles/bar.dir/depend:
	cd /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master /mnt/e/5th_term/FundamentalsOfCompiling/LabofCompiling/final/matplotlib-cpp-master/CMakeFiles/bar.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/bar.dir/depend

