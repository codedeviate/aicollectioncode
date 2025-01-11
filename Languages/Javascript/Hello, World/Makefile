# Variables
NODE = node        # Node.js executable
DENO = deno        # Deno executable
BUN = bun          # Bun executable
SCRIPT = hello.js  # JavaScript file to run

# Default rule: run with Node.js
all: run-node

# Run the JavaScript program with Node.js
run-node:
	$(NODE) $(SCRIPT)

# Run the JavaScript program with Deno
run-deno:
	$(DENO) run $(SCRIPT)

# Run the JavaScript program with Bun
run-bun:
	$(BUN) $(SCRIPT)

# Clean up: Deno cache (if needed)
clean-deno:
	$(DENO) cache --reload $(SCRIPT)

# Clean up: Bun cache (if needed)
clean-bun:
	$(BUN) cache clean

# Rebuild: Not applicable but included for consistency
rebuild: clean

.PHONY: all run-node run-deno run-bun clean-deno clean-bun rebuild
