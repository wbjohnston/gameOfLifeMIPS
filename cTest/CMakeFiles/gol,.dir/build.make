# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.1

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
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.1.2/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.1.2/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = "/Users/Bonk/Documents/School/RIT 2014-2015/Semester Two/CSCI251-Concepts/Projects/gameOfLifeMIPS/cTest"

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = "/Users/Bonk/Documents/School/RIT 2014-2015/Semester Two/CSCI251-Concepts/Projects/gameOfLifeMIPS/cTest"

# Include any dependencies generated for this target.
include CMakeFiles/gol,.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/gol,.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/gol,.dir/flags.make

CMakeFiles/gol,.dir/gol.o: CMakeFiles/gol,.dir/flags.make
CMakeFiles/gol,.dir/gol.o: gol.c
	$(CMAKE_COMMAND) -E cmake_progress_report "/Users/Bonk/Documents/School/RIT 2014-2015/Semester Two/CSCI251-Concepts/Projects/gameOfLifeMIPS/cTest/CMakeFiles" $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object CMakeFiles/gol,.dir/gol.o"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/gol,.dir/gol.o   -c "/Users/Bonk/Documents/School/RIT 2014-2015/Semester Two/CSCI251-Concepts/Projects/gameOfLifeMIPS/cTest/gol.c"

CMakeFiles/gol,.dir/gol.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/gol,.dir/gol.i"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E "/Users/Bonk/Documents/School/RIT 2014-2015/Semester Two/CSCI251-Concepts/Projects/gameOfLifeMIPS/cTest/gol.c" > CMakeFiles/gol,.dir/gol.i

CMakeFiles/gol,.dir/gol.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/gol,.dir/gol.s"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S "/Users/Bonk/Documents/School/RIT 2014-2015/Semester Two/CSCI251-Concepts/Projects/gameOfLifeMIPS/cTest/gol.c" -o CMakeFiles/gol,.dir/gol.s

CMakeFiles/gol,.dir/gol.o.requires:
.PHONY : CMakeFiles/gol,.dir/gol.o.requires

CMakeFiles/gol,.dir/gol.o.provides: CMakeFiles/gol,.dir/gol.o.requires
	$(MAKE) -f CMakeFiles/gol,.dir/build.make CMakeFiles/gol,.dir/gol.o.provides.build
.PHONY : CMakeFiles/gol,.dir/gol.o.provides

CMakeFiles/gol,.dir/gol.o.provides.build: CMakeFiles/gol,.dir/gol.o

# Object files for target gol,
gol,_OBJECTS = \
"CMakeFiles/gol,.dir/gol.o"

# External object files for target gol,
gol,_EXTERNAL_OBJECTS =

gol,: CMakeFiles/gol,.dir/gol.o
gol,: CMakeFiles/gol,.dir/build.make
gol,: CMakeFiles/gol,.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking C executable gol,"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/gol,.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/gol,.dir/build: gol,
.PHONY : CMakeFiles/gol,.dir/build

CMakeFiles/gol,.dir/requires: CMakeFiles/gol,.dir/gol.o.requires
.PHONY : CMakeFiles/gol,.dir/requires

CMakeFiles/gol,.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/gol,.dir/cmake_clean.cmake
.PHONY : CMakeFiles/gol,.dir/clean

CMakeFiles/gol,.dir/depend:
	cd "/Users/Bonk/Documents/School/RIT 2014-2015/Semester Two/CSCI251-Concepts/Projects/gameOfLifeMIPS/cTest" && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" "/Users/Bonk/Documents/School/RIT 2014-2015/Semester Two/CSCI251-Concepts/Projects/gameOfLifeMIPS/cTest" "/Users/Bonk/Documents/School/RIT 2014-2015/Semester Two/CSCI251-Concepts/Projects/gameOfLifeMIPS/cTest" "/Users/Bonk/Documents/School/RIT 2014-2015/Semester Two/CSCI251-Concepts/Projects/gameOfLifeMIPS/cTest" "/Users/Bonk/Documents/School/RIT 2014-2015/Semester Two/CSCI251-Concepts/Projects/gameOfLifeMIPS/cTest" "/Users/Bonk/Documents/School/RIT 2014-2015/Semester Two/CSCI251-Concepts/Projects/gameOfLifeMIPS/cTest/CMakeFiles/gol,.dir/DependInfo.cmake" --color=$(COLOR)
.PHONY : CMakeFiles/gol,.dir/depend

