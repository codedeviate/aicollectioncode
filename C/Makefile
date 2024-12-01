# Define the compiler
CC = gcc

# Define the target executable
TARGET = main

# Define the source files
SRCS = main.c

# Define the object files
OBJS = $(SRCS:.c=.o)

# Define the compiler flags
CFLAGS = -Wall -Wextra -O2

# Define the linker flags
LDFLAGS =

# Default target
all: $(TARGET)

# Rule to build the target executable
$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^

# Rule to build the object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean up build files
clean:
	rm -f $(OBJS) $(TARGET)

# Phony targets
.PHONY: all clean
