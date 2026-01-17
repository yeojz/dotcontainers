ARG NODE_TAG=24-slim
FROM node:${NODE_TAG}

ARG HOST_UID=1000
ARG HOST_GID=1000
# Combine all tools here. Note: added specific tools you listed for runtime
ARG LOCAL_TOOLS="git curl jq ripgrep vim nano make zip unzip ssh-client wget tree imagemagick ca-certificates gnupg procps"

# 1. Install System Dependencies (as root)
RUN apt-get update && \
    apt-get install -y --no-install-recommends ${LOCAL_TOOLS} && \
    rm -rf /var/lib/apt/lists/*

# Install Playwright system dependencies for Chromium (required by agent-browser)
RUN npx playwright install-deps chromium

# 2. Configure the existing 'node' user
# The node image usually creates the node user. We ensure it owns the workspaces dir.
WORKDIR /workspaces
RUN chown -R node:node /workspaces

# 3. Switch to 'node' user for config setup
USER node

# 4. Configure NPM global location for the 'node' user
# This allows npm install -g without root permissions
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$NPM_CONFIG_PREFIX/bin:$PATH

# Allows for pnpm to be used
ENV PNPM_HOME=/home/node/.local/share/pnpm
ENV PATH=$PNPM_HOME:$PATH

# Create required directories
RUN mkdir -p /home/node/.config && \
    mkdir -p /home/node/.local && \
    mkdir -p ${NPM_CONFIG_PREFIX} && \
    mkdir -p ${PNPM_HOME}

# Install pnpm globally
RUN npm install -g pnpm@8

CMD ["/bin/bash"]