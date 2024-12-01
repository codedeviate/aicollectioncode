# Variables
JAVAC = javac         # Java compiler
JAVA = java           # Java runtime
SOURCE = Hello.java   # Java source file
CLASS = Hello.class   # Compiled class file

# Default rule: compile the Java source file
all: build

# Build the Java program
build: $(CLASS)

$(CLASS): $(SOURCE)
	$(JAVAC) $(SOURCE)

# Run the compiled Java program
run: build
	$(JAVA) Hello

# Clean up: remove the compiled class files
clean:
	rm -f $(CLASS)

# Rebuild: clean and then compile again
rebuild: clean build

.PHONY: all build run clean rebuild
