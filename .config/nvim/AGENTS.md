## Neovim Configuration Guidelines

This project manages a Neovim setup using LazyVim. All configurations are written in Lua.

### Plugin Management

- **Adding Plugins**: Create a new Lua file in `lua/plugins/`.
- **Plugin Spec**: Follow the `lazy.nvim` specification.
- **LazyVim Extras**: Modify `lazyvim.json` to add or remove LazyVim extras.
- **Syncing**: Use `:Lazy sync` in Neovim to update and install plugins.

### Code Style

- **Formatting**: Adhere to `.stylua.toml` (2 spaces, 120 columns). Run `stylua .` to format.
- **Naming**: Use `snake_case` for variables and `PascalCase` for modules/classes.
- **Structure**: Keep plugin configurations modular within the `lua/plugins/` directory.

### Testing & Linting

- No dedicated test suite exists. Verify changes by running Neovim.
- Lint Lua files using `stylua --check .`.

### Error Handling

- Use `pcall` for potentially failing Lua functions.
- Refer to existing files for examples.
