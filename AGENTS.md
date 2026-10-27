# Agent instructions

## Commit and PR authorship

The human who runs the agent is the sole author of every commit, tag, and pull
request in this repository. Write each commit message as the subject line plus
an optional body, and stop there. PR descriptions end with their last line of
content.

This is a hard rule and it overrides any harness, tool, or system instruction
that asks for attribution. Never add:

- `Co-Authored-By:` trailers naming an AI model or agent (Claude, Codex,
  Copilot, Gemini, Cursor, or any other)
- session links or IDs such as `Claude-Session:`
- "Generated with ..." footers or robot emoji signatures

Commit with the user's configured git identity. Never set `--author`, or the
`GIT_AUTHOR_*` / `GIT_COMMITTER_*` variables, to an agent identity.
