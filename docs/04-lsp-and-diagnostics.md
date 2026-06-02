# LSP, diagnostics, formatting & linting

The "IDE" layer: code intelligence from language servers, plus formatting, linting, and ways to browse problems.

## What is the LSP?

A **Language Server** understands your code semantically — it powers go-to-definition, find-references, rename, hover docs, completion, and diagnostics (errors/warnings). Servers are installed by **Mason** and configured in `plugins/lsp/lspconfig.lua` using Neovim 0.11's native `vim.lsp.config` API.

The LSP keymaps below are set **when a server attaches to a buffer** (so they only exist in files a server supports).

## LSP keymaps

| Key | Action |
|-----|--------|
| `gd` | Go to definition (via Telescope, so multiple defs are listed) |
| `gD` | Go to declaration |
| `gR` | Show references (Telescope) |
| `gi` | Go to implementations |
| `gt` | Go to type definition |
| `K` | **Hover** — show docs/signature for the symbol under the cursor |
| `<leader>ca` | **Code action** (quick-fixes, refactors). Works on a visual selection too |
| `<leader>rn` | **Rename** the symbol everywhere (project-wide) |
| `<leader>rs` | **R**e**s**tart the language server (if it gets stuck) |

> `gd`/`gR`/etc. open in Telescope — use `<C-j>/<C-k>` to move and `<CR>` to jump.

## Diagnostics (errors & warnings)

Diagnostics show as gutter signs (`E` `W` `H` `I`) and inline virtual text.

| Key | Action |
|-----|--------|
| `<leader>d` | Show the diagnostic for the **current line** in a float |
| `<leader>D` | List diagnostics for the **whole buffer** (Telescope) |
| `]d` | Jump to the next diagnostic |
| `[d` | Jump to the previous diagnostic |

> **Naming overlap to know about:** `<leader>d` (line diagnostics) shares its prefix with the DAP debugger group (`<leader>dc`, `<leader>db`, …). Pressing `<leader>d` and pausing triggers line diagnostics; typing a debugger key quickly (e.g. `<leader>db`) triggers DAP. If the wait bothers you, remap line diagnostics in `lspconfig.lua` (e.g. to `<leader>ld`).

## Browsing problems in bulk — Trouble

[Trouble](https://github.com/folke/trouble.nvim) is a pretty, navigable list panel for diagnostics, quickfix, references, and TODOs.

| Key | Action |
|-----|--------|
| `<leader>xw` | **W**orkspace diagnostics (whole project) |
| `<leader>xd` | **D**ocument diagnostics (current file only) |
| `<leader>xq` | **Q**uickfix list |
| `<leader>xl` | **L**ocation list |
| `<leader>xt` | **T**ODO comments |

Inside the panel: `<CR>` to jump, `q` to close.

## Formatting — conform.nvim

| Key | Mode | Action |
|-----|------|--------|
| *(automatic)* | — | **Format on save** is on (synchronous, falls back to LSP formatting) |
| `<leader>mp` | normal / visual | **M**anually format the file (or the selected range) |

Configured formatters: `clang-format` for C/C++/CUDA (respects a `.clang-format` file in your project if present), `stylua` for Lua. Add more in `plugins/formatting.lua` (there are commented templates).

## Linting — nvim-lint

Linting runs automatically on save / buffer-enter / leaving insert mode, surfacing issues as diagnostics.

| Key | Action |
|-----|--------|
| `<leader>l` | Manually trigger linting for the current file |

> All linters are currently **commented out** in `plugins/linting.lua` — for C/C++, clangd already provides clang-tidy diagnostics. Uncomment a linter there (and ensure its tool is installed via Mason) to enable extra linting.

## Managing servers & tools — Mason

| Command | What it does |
|---------|--------------|
| `:Mason` | Open the UI: install/update/remove LSP servers, formatters, linters, debug adapters |
| `:MasonUpdate` | Update the Mason registry |

Auto-installed on startup: `lua_ls`, `clangd`, `cmake` (servers) and `clang-format`, `stylua` (tools). The lists live in `plugins/lsp/mason.lua` and contain commented templates for many other languages — uncomment to enable, then restart.

- **`clangd`** is tuned for C/C++/CUDA (background indexing, clang-tidy, CUDA driver detection). See [07-cpp-cmake.md](07-cpp-cmake.md).
- **`lua_ls`** + lazydev gives full Neovim API completion when editing this config.
