# shell-prompt

A custom zsh prompt.

Must be sourced from `.zshrc` — it cannot run standalone.

## Format

```
[CONNECTION⇢HOST] [MULTIPLEXER⇢ID] DIRECTORY ❯
```

- **Directory** — white bold, abbreviated based on depth (e.g. `~/.../<leaf>/`)
- **Root indicator** — shown in red if running as root
- **Connection prefix** — shown in red when not local: `SSH`, `MOSH`, `CONTAINER`, or `TUNNEL`
- **Multiplexer prefix** — shown in blue when inside `tmux` (with pane ID) or `screen`

At some point I will get around to bash support.
