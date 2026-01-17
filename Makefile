.PHONY: all clean base claude opencode

# Determine container engine (podman or docker)
CONTAINER_ENGINE := $(shell which podman 2>/dev/null || which docker 2>/dev/null)

# UID/GID
HOST_UID := $(shell id -u)
HOST_GID := $(shell id -g)

# Node.js version (e.g., 20-slim, 22-slim, 24-slim)
NODE_TAG ?= 24-slim

# Tools to install in to the containers with apt-get
LOCAL_TOOLS := "git curl jq ripgrep vim nano make zip unzip ssh-client wget tree imagemagick build-essential python3 python3-pip"

# Ensure we have a container engine
ifeq ($(CONTAINER_ENGINE),)
$(error No container engine (podman/docker) found in PATH)
endif

all: base claude opencode

base:
	@echo "Building dotcontainer-base-$(NODE_TAG) image"
	$(CONTAINER_ENGINE) build \
		--build-arg NODE_TAG=$(NODE_TAG) \
		--build-arg HOST_UID=$(HOST_UID) \
		--build-arg HOST_GID=$(HOST_GID) \
		--build-arg LOCAL_TOOLS=$(LOCAL_TOOLS) \
		-t dotcontainer-base-$(NODE_TAG) \
		-f containers/base/Dockerfile containers/base

claude: base
	@echo "Building dotcontainer-claude-$(NODE_TAG)"
	$(CONTAINER_ENGINE) build \
		--build-arg NODE_TAG=$(NODE_TAG) \
		--no-cache \
		-t dotcontainer-claude-$(NODE_TAG) \
		-f containers/claude/Dockerfile containers/claude

opencode: base
	@echo "Building dotcontainer-opencode-$(NODE_TAG)"
	$(CONTAINER_ENGINE) build \
		--build-arg NODE_TAG=$(NODE_TAG) \
		--no-cache \
		-t dotcontainer-opencode-$(NODE_TAG) \
		-f containers/opencode/Dockerfile containers/opencode

clean:
	@echo "Removing container images"
	@for image in dotcontainer-opencode-$(NODE_TAG) dotcontainer-claude-$(NODE_TAG) dotcontainer-base-$(NODE_TAG); do \
		if $(CONTAINER_ENGINE) image inspect $$image > /dev/null 2>&1; then \
			echo "Removing $$image"; \
			$(CONTAINER_ENGINE) rmi -f $$image; \
		else \
			echo "Image $$image does not exist, skipping"; \
		fi; \
	done