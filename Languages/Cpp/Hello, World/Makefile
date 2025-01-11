# Variables
CXX = g++              # C++ compiler
CXXFLAGS = -Wall -Werror -g # Compiler flags: warnings, errors, debugging
TARGET = main          # Output executable

# Default rule: build the executable
all: $(TARGET)

# Compile the C++ source file to create the executable
$(TARGET): main.cpp
	$(CXX) $(CXXFLAGS) -o $(TARGET) main.cpp

# Run the compiled program
run: $(TARGET)
	./$(TARGET)

# Clean up: remove the executable
clean:
	rm -f $(TARGET)

# Rebuild: clean and then build
rebuild: clean all

.PHONY: all run clean rebuild
