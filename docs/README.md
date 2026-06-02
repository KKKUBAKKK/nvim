# Neovim config — user guide

Personal Neovim setup, Lua + [lazy.nvim](https://github.com/folke/lazy.nvim), tuned for **C/C++/CUDA**. This `docs/` folder explains every tool and keybinding in it.

> **Leader key is `<Space>`.** Wherever you see `<leader>`, press the spacebar. Pause after pressing it and **which-key** pops up a menu of what comes next — you never have to memorise everything.

## Guides

| File | Covers |
|------|--------|
| [01-essentials.md](01-essentials.md) | Leader key, core options, windows / splits / tabs, sessions, tmux navigation |
| [02-files-and-search.md](02-files-and-search.md) | File explorer (nvim-tree), fuzzy finder (Telescope), regexp grep with include/exclude, buffer/tab line |
| [03-editing.md](03-editing.md) | Commenting, surround, substitute, autopairs, Treesitter selection, autocompletion, TODO comments |
| [04-lsp-and-diagnostics.md](04-lsp-and-diagnostics.md) | LSP (go-to, rename, hover, code actions), diagnostics, formatting, linting, Trouble, Mason |
| [05-git.md](05-git.md) | Gitsigns (hunks, blame), Diffview (review changes), LazyGit |
| [06-debugging.md](06-debugging.md) | DAP debugger — breakpoints, stepping, the debug UI |
| [07-cpp-cmake.md](07-cpp-cmake.md) | C/C++/CUDA workflow: CMake build/run/debug + clangd |
| [08-ai-tools.md](08-ai-tools.md) | Claude Code integration, GitHub Copilot, Copilot Chat |
| [09-cheatsheet.md](09-cheatsheet.md) | Every keybinding in one printable table |

## How the config is organised

```
init.lua                      -- entry point
lua/kkkubakkk/
  core/
    options.lua               -- vim settings (numbers, tabs, clipboard, auto-reload…)
    keymaps.lua               -- general keymaps (leader, splits, tabs)
  lazy.lua                    -- bootstraps the lazy.nvim plugin manager
  plugins/                    -- one file per plugin (auto-imported)
    lsp/                      -- LSP-specific plugins
```

Adding a plugin = adding a new file in `plugins/` that returns a spec table. There is no central list to edit.

## Managing plugins & tools (the commands you'll actually run)

| Command | What it does |
|---------|--------------|
| `:Lazy` | Open the plugin manager UI (install / update / clean / profile) |
| `:Lazy sync` | Install missing plugins + update existing ones to the lockfile |
| `:Lazy update` | Update plugins and refresh `lazy-lock.json` |
| `:Mason` | Manage LSP servers, formatters, linters, debug adapters |
| `:checkhealth` | Diagnose problems (LSP, providers, plugins) |
| `:LspInfo` | Show LSP servers attached to the current buffer |

After an intentional `:Lazy update`, **commit `lazy-lock.json`** so your plugin versions stay pinned and reproducible.

## First-time setup notes

- **C/C++ work** needs `clangd` (auto-installed by Mason). For accurate indexing, generate `compile_commands.json` — see [07-cpp-cmake.md](07-cpp-cmake.md).
- **Claude Code integration** needs the `claude` CLI on your `PATH`. See [08-ai-tools.md](08-ai-tools.md).
- **Telescope live grep** needs [ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`) installed on your system.
