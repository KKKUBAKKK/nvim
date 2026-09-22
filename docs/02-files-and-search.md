# Files & search

How to move around the project: the file tree, the fuzzy finder, and powerful grep with include/exclude filters.

## File explorer — nvim-tree

A sidebar file tree.

| Key | Action |
|-----|--------|
| `<leader>ee` | Toggle the file explorer open/closed |
| `<leader>ef` | Toggle the explorer **focused on the current file** (reveals where you are) |
| `<leader>ec` | Collapse the whole tree |
| `<leader>er` | Refresh the tree |

**Inside the tree** (default nvim-tree keys, press `g?` in the tree for the full list):

| Key | Action |
|-----|--------|
| `<CR>` / `o` | Open file / expand folder |
| `a` | Create a new file (end with `/` to make a folder) |
| `d` | Delete · `r` rename · `x` cut · `c` copy · `p` paste |
| `H` | Toggle hidden files · `R` refresh |
| `<C-v>` / `<C-x>` | Open in vertical / horizontal split |

> Git status is shown in the tree (changed/added files are marked). The `.DS_Store` file is filtered out.

You can also **add a tree file to Claude Code's context** with `<leader>as` while hovering it — see [08-ai-tools.md](08-ai-tools.md).

## Fuzzy finder — Telescope

[Telescope](https://github.com/nvim-telescope/telescope.nvim) is the search hub. All pickers open a floating window with a live-updating list.

| Key | Action |
|-----|--------|
| `<leader>ff` | **F**ind **f**iles by name in the project |
| `<leader>fr` | **R**ecent files (oldfiles) |
| `<leader>fs` | Live grep — **s**earch file contents across the project |
| `<leader>fg` | Live grep **with ripgrep args** — search + include/exclude filters (see below) |
| `<leader>fc` | Grep the word **under the cursor** |
| `<leader>ft` | Find **t**ODO/FIXME comments |

**Inside any picker:**

| Key | Action |
|-----|--------|
| `<C-j>` / `<C-k>` | Next / previous result |
| `<CR>` | Open the selection |
| `<C-v>` / `<C-x>` | Open in a vertical / horizontal split |
| `<C-q>` | Send all results to the (built-in) quickfix list |
| `<C-t>` | Send all results straight into **Trouble** — a persistent, file-grouped list with preview you can walk through with `<CR>`/`j`/`k` without re-searching or losing your place |
| `<C-/>` (insert) / `?` (normal) | Show all mappings for the current picker |
| `<Esc>` | Close the picker |

Fuzzy matching is powered by `fzf-native` (compiled), so it's fast even on large repos.

> **One search, many results to browse:** run `<leader>fg` (search + ripgrep filters) or `<leader>fs`/`<leader>fc`, then press `<C-t>` instead of picking a result — everything lands in a Trouble panel (see [04-lsp-and-diagnostics.md](04-lsp-and-diagnostics.md)) grouped by file, and stays open as you jump from one match to the next.

## Regexp search with include/exclude — `<leader>fg`

`<leader>fg` uses [telescope-live-grep-args](https://github.com/nvim-telescope/telescope-live-grep-args.nvim): you type a search pattern **and** raw [ripgrep](https://github.com/BurntSushi/ripgrep) flags in the same prompt. This is the tool for "search everything, but only/except these files or folders."

The pattern is a regex by default. Add flags after it:

| Goal | Type in the prompt |
|------|--------------------|
| Plain regexp search | `cudaMalloc\w+` |
| Only CUDA files | `kernel --iglob *.cu --iglob *.cuh` |
| Only C/C++ headers | `class\s+\w+ --iglob *.hpp --iglob *.h` |
| **Exclude** a directory | `TODO --iglob !build/** --iglob !third_party/**` |
| Case-sensitive | `MyClass --case-sensitive` |
| Search by file type shorthand | `foo --type cpp` |
| Include normally-ignored files | `secret --no-ignore` |
| Whole word only | `foo --word-regexp` |

Useful prompt keys while in `<leader>fg`:

- `--iglob` = case-insensitive glob; prefix the glob with `!` to **exclude**. Repeat `--iglob` as many times as you like.
- In **visual mode**, `<leader>fg` searches the highlighted text directly.

> Tip: `--iglob` globs are relative to the search root. `*.cu` matches anywhere; `!build/**` excludes the whole `build/` tree.

## Search & replace — grug-far.nvim

[grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) is a dedicated project-wide **find-and-replace** tool: regex search with a live, editable list of every match, and fine-grained control over what actually gets changed and when.

| Key | Mode | Action |
|-----|------|--------|
| `<leader>rr` | normal | Open search & replace (project-wide) |
| `<leader>rw` | normal | Open, pre-filled with the **w**ord under the cursor |
| `<leader>rf` | normal | Open, scoped to the current **f**ile only |
| `<leader>rr` | visual | Open, pre-filled with the selection |

This opens a buffer with **Search** / **Replace** / **Files filter** input fields at the top and the live match list below (regex by default; ripgrep flags work in the Files filter field, same as `<leader>fg`). Edit the Replace field and the preview updates as you type — nothing is changed on disk until you sync.

**Inside the grug-far buffer** (all default binds, prefixed with `<localleader>`, i.e. `\` unless you've changed `maplocalleader`):

| Key | Action |
|-----|--------|
| `\l` | Sync just the **occurrence on the current line** |
| `\n` / `\p` | Sync current occurrence, then jump to next / previous |
| `\v` | Sync every occurrence in the current **file** |
| `\s` | Sync **all** occurrences everywhere (whole-codebase replace) |
| `<down>` / `<up>` | Move to next / previous match without syncing |
| `<enter>` | Jump to the match under the cursor in its real file |
| `\q` | Send the match list to the quickfix list |
| `\f` | Refresh (re-run the search) |
| `\c` | Close |
| `g?` | Show all keymaps |

Since nothing is written until you sync, you can freely delete lines you don't want touched (or edit the Replace text per-section) before running `\v` (file) or `\s` (everywhere) — or just walk through with `\n`/`\l` one occurrence at a time.

## Buffer / tab line

[bufferline](https://github.com/akinsho/bufferline.nvim) renders your **tabs** in a styled bar at the top. Switch tabs with `<leader>tn` / `<leader>tp` (see [01-essentials.md](01-essentials.md)). The status line at the bottom (lualine) shows mode, git branch, diagnostics, file info, and a marker when plugin updates are available.
