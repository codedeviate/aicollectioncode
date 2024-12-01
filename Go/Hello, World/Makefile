# Variables
GO = go            # Go compiler
TARGET = hello     # Output executable name

# Default rule: build the executable
all: build

# Build the Go program
build: $(TARGET)

$(TARGET): hello.go
	$(GO) build -o $(TARGET) hello.go

# Run the compiled program
run: build
	./$(TARGET)

# Clean up: remove the compiled executable
clean:
	rm -f $(TARGET)

# Rebuild: clean and then build
rebuild: clean build

.PHONY: all build run clean rebuild
