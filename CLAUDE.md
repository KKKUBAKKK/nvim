# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration written in Lua, managed by the [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager. It targets **Neovim 0.11+** (uses the native `vim.lsp.config`/`vim.lsp.enable` API and `vim.diagnostic.jump`, both of which replaced APIs deprecated in 0.11) and is tuned primarily for **C/C++/CUDA development** (clangd, CMake, cppdbg).

## User documentation

Human-facing guides live in `docs/` (start at `docs/README.md`): thematic guides for essentials, files/search, editing, LSP, git, debugging, C++/CMake, and AI tools, plus a full keybinding cheatsheet (`docs/09-cheatsheet.md`). Keep these in sync when you change keymaps or add plugins.

## Architecture

Entry point is `init.lua`, which loads two things in order:

1. `require("kkkubakkk.core")` — `lua/kkkubakkk/core/init.lua` pulls in `options.lua` (vim settings) and `keymaps.lua` (general, plugin-independent keymaps). Leader key is **space**, set in `keymaps.lua` and *must* be set before lazy.nvim loads so plugin `keys =` specs resolve correctly.
2. `require("kkkubakkk.lazy")` — bootstraps lazy.nvim and calls `require("lazy").setup(...)` with two import globs: `kkkubakkk.plugins` and `kkkubakkk.plugins.lsp`.

### Plugin specs

Every file under `lua/kkkubakkk/plugins/` (and `plugins/lsp/`) is a lazy.nvim plugin spec — each `return`s a table. lazy.nvim imports the whole directory automatically, so **adding a new plugin = adding a new file that returns a spec**; there is no central plugin list to edit. `plugins/init.lua` is the one exception: it returns a list of small dependency-only plugins (plenary, vim-tmux-navigator).

Plugins are lazy-loaded via `event` (e.g. `BufReadPre`/`BufNewFile`), `ft` (filetype), `keys`, or `VeryLazy`. Match this pattern when adding plugins rather than loading eagerly.

### LSP / tooling stack (the part that requires reading several files together)

The C/C++/CUDA toolchain is split across four cooperating files:

- `plugins/lsp/mason.lua` — installs LSP servers (`mason-lspconfig` `ensure_installed`: `lua_ls`, `clangd`, `cmake`) and CLI tools (`mason-tool-installer` `ensure_installed`: `clang-format`, `stylua`). Most entries are commented-out templates for other languages — uncomment to enable.
- `plugins/lsp/lspconfig.lua` — configures servers with the **Neovim 0.11 native API**: `vim.lsp.config(server, {...})`. mason-lspconfig v2 auto-enables installed servers, so there are **no `lspconfig[server].setup()` or `setup_handlers` calls** (removed in v2 — do not reintroduce them). LSP keymaps (`gd`, `gR`, `gi`, `K`, `<leader>ca`, `<leader>rn`, etc.) are set in a `LspAttach` autocmd. clangd is launched with CUDA-aware flags including `--query-driver` for nvcc.
- `plugins/formatting.lua` — conform.nvim, format-on-save (synchronous). `clang_format` for c/cpp/cuda, `stylua` for lua. Manual format: `<leader>mp`.
- `plugins/linting.lua` — nvim-lint, lints on `BufEnter`/`BufWritePost`/`InsertLeave`. All linters currently commented out. Manual: `<leader>l`.

Capabilities from `cmp-nvim-lsp` are broadcast to all servers via `vim.lsp.config("*", { capabilities })`.

### Build / debug (C/C++/CUDA)

- `plugins/cmake-tools.lua` — cmake-tools.nvim drives configure/build/run/debug. Builds into `build/`, exports `compile_commands.json` and soft-links it to the project root so clangd indexes correctly. Keymaps under **`<leader>C`** (capital C, to avoid clashing with `<leader>c` Copilot mappings).
- `plugins/dap.lua` — nvim-dap + dap-ui + virtual text. Uses the **`cppdbg`** adapter (`OpenDebugAD7`, installed via mason-nvim-dap), shared by `cmake-tools`. Keymaps under `<leader>d`. The DAP UI auto-opens/closes via `dap.listeners`.

### AI / Claude Code integration

- `plugins/claudecode.lua` — `coder/claudecode.nvim` (dep: `snacks.nvim`). Connects Neovim to the Claude Code CLI over its MCP socket. Send selections (`<leader>as` in visual), add the current buffer (`<leader>ab`) or a tree file (`<leader>as` in nvim-tree), toggle/focus the CLI (`<leader>ac`/`<leader>af`), and review Claude's proposed edits in a native diff (accept `<leader>aa`, deny `<leader>ad`). Requires the `claude` CLI on PATH.
- `core/options.lua` sets `autoread` + a `checktime` autocmd (group `AutoReadOnExternalChange`) so buffers reload when the Claude Code CLI edits files on disk.
- Copilot context: `plugins/copilot_chat.lua` adds `<leader>cb` (whole buffer as context) and `<leader>cv` (visual selection); CopilotChat also supports in-prompt sticky context like `#file:path` and `#buffers`.

### Reviewing changes

- `plugins/diffview.lua` — `sindrets/diffview.nvim` for full-file/multi-file diff review (your edits or Claude's): `<leader>gd` working-tree changes, `<leader>gh` current-file history, `<leader>gH` repo history, `<leader>gq` close. Per-hunk staging and inline blame remain in `plugins/gitsigns.lua` under `<leader>h`.

## Keymap conventions

Leader is space. Namespaces are intentional, watch for collisions when adding mappings (which-key shows group labels for these, configured in `plugins/which-key.lua`):

- `<leader>a…` — AI / Claude Code (claudecode.nvim)
- `<leader>C…` — CMake (capital C)
- `<leader>c…` — Copilot (incl. CopilotChat: `cc` toggle, `cb` buffer context, `cv` selection context)
- `<leader>d…` — DAP debugging
- `<leader>e…` — file explorer (nvim-tree)
- `<leader>f…` — find / Telescope (`fg` = live-grep with ripgrep glob args)
- `<leader>g…` — Git diff (Diffview)
- `<leader>h…` — Git hunks / blame (Gitsigns)
- `<leader>s…` — window splits
- `<leader>t…` — tabs
- `<leader>r…` — rename / restart LSP

## Common commands

This is config, not an app — there is no build/test step. Work happens inside Neovim:

- **Apply changes**: restart Neovim, or `:source %` / re-`require` (most plugin config needs a restart).
- **Manage plugins**: `:Lazy` (install/update/clean), `:Lazy sync`. `lazy-lock.json` pins versions — commit it after intentional updates; `checker.enabled = true` checks for updates but does not auto-apply.
- **Manage tools/servers**: `:Mason`. Servers/tools auto-install on startup from the `ensure_installed` lists.
- **Inspect LSP**: `:LspInfo`, `:checkhealth`. Restart a server with `<leader>rs` (`:LspRestart`).
- **Format manually**: `<leader>mp`. **Lint manually**: `<leader>l`.

## Adding language support

The mason/formatting/linting files are pre-seeded with commented templates per language. To enable a language: uncomment its server in `mason.lua` `ensure_installed`, add a `vim.lsp.config(...)` block in `lspconfig.lua` if it needs non-default settings, uncomment its formatter in `formatting.lua` (+ tool in `mason.lua`), and optionally its linter in `linting.lua`.
