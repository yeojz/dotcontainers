# Rules

## Git

- Squash-merge into `main` or `master` (no merge commits)

### Worktrees

- **ALWAYS** create in `/workspaces/worktrees`
- Naming: `<project-name>-<feature-name>`
- Clean up after merging: `git worktree remove <path>`

## Design Documents

Store in `/workspaces/docs/plans/` as `YYYY-MM-DD-<hhmm>-<topic>-<type>.md` (e.g., `2026-01-17-1518-auth-brainstorm.md`, `2026-01-17-1518-auth-plan.md`). The `YYYY-MM-DD` is the current date and `hhmm` is the current time in 24-hour format.
