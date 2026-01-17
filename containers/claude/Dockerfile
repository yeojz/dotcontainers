ARG NODE_TAG=24-slim
FROM dotcontainer-base-${NODE_TAG}

RUN npm install -g @anthropic-ai/claude-code@latest
RUN echo "Installed Claude Code version: $(claude --version)"

CMD ["claude"]