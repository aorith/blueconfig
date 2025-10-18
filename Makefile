SHELL = bash

IMAGE_NAME ?= blueconfig
REGISTRY ?= localhost:5000
IMAGE_FULL := $(REGISTRY)/$(IMAGE_NAME)

.PHONY: registry build push clean help

help:
	@echo "Available targets:"
	@echo "  registry    - Start local container registry on port 5000"
	@echo "  build       - Build the container image"
	@echo "  push        - Push image to local registry"
	@echo "  clean       - Stop registry container"
	@echo ""
	@echo "Variables:"
	@echo "  IMAGE_NAME  = $(IMAGE_NAME)"
	@echo "  REGISTRY    = $(REGISTRY)"
	@echo "  IMAGE_FULL  = $(IMAGE_FULL)"

registry:
	@echo "Starting local registry on port 5000..."
	podman run --rm -p 5000:5000 registry:2

build:
	@echo "Building image: $(IMAGE_FULL)"
	podman build . -t $(IMAGE_FULL)

push:
	@echo "Pushing image: $(IMAGE_FULL)"
	podman push --tls-verify=false $(IMAGE_FULL)

clean:
	@echo "Stopping registry containers..."
	@podman ps -a --filter ancestor=registry:2 --format "{{.ID}}" | xargs -r podman stop

