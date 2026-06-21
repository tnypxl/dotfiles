# Domains

Domain references are optional, read-only context for a stem. A stem opts in by setting `domain: <name>` in its `notebook.md` frontmatter; `/lets` then resolves `<name>.md` against a cascade and reads the first hit when shaping deliverables (code style, citation format, document structure, naming conventions):

```
$PWD/.agents/domains/<name>.md          # project override — wins
~/dotfiles/.agents/domains/<name>.md    # the default floor
```

A project overrides the default by placing its own `<name>.md`; the files here are the floor. A reference describes the *standards a domain's deliverables follow* — not the work itself, and not the harness. The skill reads these; it never writes them.

The sibling dirs (`../workflows/`, `../documentation/`, `../assets/`) follow the same project→dotfiles cascade for whatever a domain or stem references.
