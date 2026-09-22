# Essentials

The basics: the leader key, the editor options that shape day-to-day behaviour, and how to manage windows, splits, tabs, and sessions.

## The leader key & which-key

The **leader** is `<Space>`. Almost every custom command starts with it.

If you forget a binding, press `<Space>` and **wait ~0.5s** — [which-key](https://github.com/folke/which-key.nvim) shows a popup of every continuation, grouped by category:

| Prefix | Group |
|--------|-------|
| `<leader>a` | AI / Claude Code |
| `<leader>c` | Copilot (+ LSP code action `ca`) |
| `<leader>C` | CMake |
| `<leader>d` | Debug (DAP) — note: `<leader>d` alone = line diagnostics, see below |
| `<leader>e` | Explorer (file tree) |
| `<leader>f` | Find (Telescope) |
| `<leader>g` | Git diff (Diffview) |
| `<leader>h` | Git hunks (Gitsigns) |
| `<leader>r` | Rename / restart LSP / search & replace |
| `<leader>s` | Splits |
| `<leader>t` | Tabs |
| `<leader>u` | UI Toggle (theme) |
| `<leader>x` | Diagnostics list (Trouble) |
| `<leader>w` | Workspace sessions |

## Core options (set in `core/options.lua`)

| Behaviour | Setting |
|-----------|---------|
| Line numbers | Hybrid — absolute on the cursor line, relative elsewhere |
| Indentation | 4 spaces, expand tabs (`tabstop`/`shiftwidth` = 4) |
| Search | Case-insensitive, but case-sensitive if you type a capital (`smartcase`) |
| Clipboard | Shares the system clipboard (`unnamedplus`) — yank/paste works with other apps |
| Splits | New splits open to the **right** and **below** |
| Line wrap | Off |
| Cursor line | Highlighted |
| **Auto-reload** | `autoread` + a `checktime` autocmd reloads files changed on disk (e.g. by the Claude Code CLI) and notifies you |

## General keymaps (`core/keymaps.lua`)

| Key | Action |
|-----|--------|
| `<leader>nh` | Clear search highlights |
| `<leader>+` | Increment number under cursor |
| `<leader>-` | Decrement number under cursor |

## Windows & splits

| Key | Action |
|-----|--------|
| `<leader>sv` | Split **v**ertically |
| `<leader>sh` | Split **h**orizontally |
| `<leader>se` | Make all splits **e**qual size |
| `<leader>sx` | Close current split |
| `<leader>sm` | **M**aximize / restore current split (toggle) |

Move **between** splits (and tmux panes — see below) with `Ctrl` + a direction:

```
<C-h>  left      <C-j>  down      <C-k>  up      <C-l>  right
```

> `<leader>sm` (vim-maximizer) is great for temporarily zooming into one split — toggle it again to restore your layout.

## Tabs

This config shows **tabs** in the top bar (via bufferline). Manage them with:

| Key | Action |
|-----|--------|
| `<leader>to` | Open a new tab |
| `<leader>tx` | Close current tab |
| `<leader>tn` | Go to next tab |
| `<leader>tp` | Go to previous tab |
| `<leader>tf` | Open current file in its own new tab |

## Themes (`core/theme.lua`)

Eight predefined colorschemes — gruvbox, tokyonight, catppuccin, kanagawa, rose-pine, everforest, nightfox, melange — each with a matching dark and light variant. Only gruvbox loads eagerly at startup; the rest are loaded on demand the first time you switch to them.

| Key | Action |
|-----|--------|
| `<leader>ub` | Toggle **b**ackground (light/dark) for the current theme |
| `<leader>ut` | Open a picker to jump straight to a **t**heme |
| `<leader>uc` | **C**ycle to the next theme (keeps the current background) |

Whatever theme + background you land on is remembered (written to a state file under `stdpath("state")`) and restored automatically the next time you open Neovim.

## tmux integration

[vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) makes `<C-h/j/k/l>` cross the boundary between Neovim splits and tmux panes seamlessly — one set of keys to move anywhere. No extra config needed on the Neovim side; add the matching plugin to your tmux config for the tmux half.

## Sessions (per-directory workspaces)

[auto-session](https://github.com/rmagatti/auto-session) saves your open files/layout per working directory. Auto-restore is **off**, so you restore explicitly:

| Key | Action |
|-----|--------|
| `<leader>ws` | **S**ave session for the current directory |
| `<leader>wr` | **R**estore the saved session for the current directory |

You can also restore from the start screen (`<leader>wr` button on the Alpha dashboard).

## The start screen

Opening `nvim` with no file shows the **Alpha** dashboard with quick buttons: new file (`e`), toggle tree (`SPC ee`), find file (`SPC ff`), find word (`SPC fs`), restore session (`SPC wr`), quit (`q`).
