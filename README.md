# dotcontainers

A collection of my own development containers (like a dotfiles collection, but for containers)

**Note**: As this is like a dotfiles collection, it is tailored to my own workflow. You may need to modify it to suit your own needs.

## Gettings Started

```bash
# After cloning the repo, run:
make
```

In your project directory, you can create an `.env` file.
Feel free to name it anything you like, eg: `.container.env`

### Compulsory Settings

These are compulsory fields without defaults as I did not want unintended mount paths.

```bash
# .container.env
IMAGE=dotcontainer-claude-24-slim # Match your image option
REPO=/path/to/project/main # Your working repo
WORKTREES=/path/to/project/worktrees 
DOCS=/path/to/project/docs # Where plan files are placed
```

### Optional Settings

```bash
CLAUDE_SETTINGS=~/.claude/settings.json
AGENT_MD=/path/to/this/repo/files/AGENT.md
```

## Launching the instances

```bash
# "-p claude" defines the name. 
# Replace "claude" with your own naming convention. eg: <project>-<agent>
docker-compose -f /path/to/this/repo/containers/claude/docker-compose.yml \
    --env-file .container.env -p claude up

# Replace "claude" if renamed
docker exec -it claude-code-1 bash
```

## Assumptions

### Claude

- Your claude configurations are at `~/.claude`
- Your claude credentials in container are mapped to `~/.claude/docker.credentials.json` so that it will not conflict with the local credentials (if any)

### Opencode

- Your opencode configurations are at `~/.config/opencode`

## Attribution

References taken from [faileon/agent-containers](https://github.com/faileon/agent-containers)
