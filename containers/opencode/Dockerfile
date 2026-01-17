ARG NODE_TAG=24-slim
FROM dotcontainer-base-${NODE_TAG}

RUN npm install -g opencode-ai@latest
RUN echo "Installed Open Code version: $(opencode --version)"

CMD ["opencode"]