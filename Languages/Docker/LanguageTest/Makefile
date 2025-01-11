# Variables
IMAGE_NAME = dev-container
CONTAINER_NAME = dev-container-instance
WORKDIR = $(shell pwd)/../../

# Build the Docker image
build:
	docker build -t $(IMAGE_NAME) .

# Run the Docker container with the parent directory mounted
run:
	docker run -it --rm -v $(WORKDIR):/workspace --name $(CONTAINER_NAME) $(IMAGE_NAME)

# Stop the container (useful if it's running in detached mode)
stop:
	docker stop $(CONTAINER_NAME) || true

# Remove the Docker image
clean:
	docker rmi $(IMAGE_NAME) || true

# Rebuild the Docker image (clean and build)
rebuild: clean build

.PHONY: build run stop clean rebuild
