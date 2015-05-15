# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.0

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
CMAKE_SOURCE_DIR = /home/rock/git/SmartTradePlatform

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/rock/git/SmartTradePlatform/build

# Include any dependencies generated for this target.
include SmartUtils/CMakeFiles/SmartUtils.dir/depend.make

# Include the progress variables for this target.
include SmartUtils/CMakeFiles/SmartUtils.dir/progress.make

# Include the compile flags for this target's objects.
include SmartUtils/CMakeFiles/SmartUtils.dir/flags.make

SmartUtils/CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.o: SmartUtils/CMakeFiles/SmartUtils.dir/flags.make
SmartUtils/CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.o: ../SmartUtils/Utils/EventNotifier.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/rock/git/SmartTradePlatform/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object SmartUtils/CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.o"
	cd /home/rock/git/SmartTradePlatform/build/SmartUtils && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.o -c /home/rock/git/SmartTradePlatform/SmartUtils/Utils/EventNotifier.cpp

SmartUtils/CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.i"
	cd /home/rock/git/SmartTradePlatform/build/SmartUtils && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/rock/git/SmartTradePlatform/SmartUtils/Utils/EventNotifier.cpp > CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.i

SmartUtils/CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.s"
	cd /home/rock/git/SmartTradePlatform/build/SmartUtils && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/rock/git/SmartTradePlatform/SmartUtils/Utils/EventNotifier.cpp -o CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.s

SmartUtils/CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.o.requires:
.PHONY : SmartUtils/CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.o.requires

SmartUtils/CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.o.provides: SmartUtils/CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.o.requires
	$(MAKE) -f SmartUtils/CMakeFiles/SmartUtils.dir/build.make SmartUtils/CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.o.provides.build
.PHONY : SmartUtils/CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.o.provides

SmartUtils/CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.o.provides.build: SmartUtils/CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.o

# Object files for target SmartUtils
SmartUtils_OBJECTS = \
"CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.o"

# External object files for target SmartUtils
SmartUtils_EXTERNAL_OBJECTS =

SmartUtils/libSmartUtils.so: SmartUtils/CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.o
SmartUtils/libSmartUtils.so: SmartUtils/CMakeFiles/SmartUtils.dir/build.make
SmartUtils/libSmartUtils.so: SmartUtils/CMakeFiles/SmartUtils.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX shared library libSmartUtils.so"
	cd /home/rock/git/SmartTradePlatform/build/SmartUtils && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/SmartUtils.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
SmartUtils/CMakeFiles/SmartUtils.dir/build: SmartUtils/libSmartUtils.so
.PHONY : SmartUtils/CMakeFiles/SmartUtils.dir/build

SmartUtils/CMakeFiles/SmartUtils.dir/requires: SmartUtils/CMakeFiles/SmartUtils.dir/Utils/EventNotifier.cpp.o.requires
.PHONY : SmartUtils/CMakeFiles/SmartUtils.dir/requires

SmartUtils/CMakeFiles/SmartUtils.dir/clean:
	cd /home/rock/git/SmartTradePlatform/build/SmartUtils && $(CMAKE_COMMAND) -P CMakeFiles/SmartUtils.dir/cmake_clean.cmake
.PHONY : SmartUtils/CMakeFiles/SmartUtils.dir/clean

SmartUtils/CMakeFiles/SmartUtils.dir/depend:
	cd /home/rock/git/SmartTradePlatform/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/rock/git/SmartTradePlatform /home/rock/git/SmartTradePlatform/SmartUtils /home/rock/git/SmartTradePlatform/build /home/rock/git/SmartTradePlatform/build/SmartUtils /home/rock/git/SmartTradePlatform/build/SmartUtils/CMakeFiles/SmartUtils.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : SmartUtils/CMakeFiles/SmartUtils.dir/depend
