# Variables
PROJECT_NAME = MainApp   # Name of the project directory

# Default rule: build the project
all: build

# Initialize the project if it doesn't exist
init:
	@if [ ! -d "$(PROJECT_NAME)" ]; then \
		dotnet new console -o $(PROJECT_NAME); \
		mv $(PROJECT_NAME)/Program.cs $(PROJECT_NAME)/main.cs; \
		echo "Project initialized"; \
	fi

# Build the C# project
build: init
	dotnet build $(PROJECT_NAME)

# Run the compiled program
run: build
	dotnet run --project $(PROJECT_NAME)

# Clean up: remove the compiled files and bin/obj directories
clean:
	rm -rf $(PROJECT_NAME)/bin $(PROJECT_NAME)/obj

# Rebuild: clean and then build
rebuild: clean build

.PHONY: all init build run clean rebuild
