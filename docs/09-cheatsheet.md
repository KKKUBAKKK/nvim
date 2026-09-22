# Cheatsheet — every keybinding

Leader = `<Space>`. Forgot one? Press `<leader>` and wait for the which-key popup.

## General

| Key | Action |
|-----|--------|
| `<leader>nh` | Clear search highlights |
| `<leader>+` / `<leader>-` | Increment / decrement number under cursor |

## Windows, splits & tabs

| Key | Action |
|-----|--------|
| `<leader>sv` / `<leader>sh` | Split vertically / horizontally |
| `<leader>se` | Equalize split sizes |
| `<leader>sx` | Close split |
| `<leader>sm` | Maximize / restore split (toggle) |
| `<C-h/j/k/l>` | Move between splits & tmux panes |
| `<leader>to` / `<leader>tx` | New tab / close tab |
| `<leader>tn` / `<leader>tp` | Next / previous tab |
| `<leader>tf` | Open current file in a new tab |

## Sessions

| Key | Action |
|-----|--------|
| `<leader>ws` / `<leader>wr` | Save / restore session for cwd |

## Themes

| Key | Action |
|-----|--------|
| `<leader>ub` | Toggle light/dark background for the current theme |
| `<leader>ut` | Pick a theme (gruvbox, tokyonight, catppuccin, kanagawa, rose-pine, everforest, nightfox, melange) |
| `<leader>uc` | Cycle to the next theme |

## File explorer (nvim-tree)

| Key | Action |
|-----|--------|
| `<leader>ee` | Toggle tree |
| `<leader>ef` | Toggle tree on current file |
| `<leader>ec` / `<leader>er` | Collapse / refresh tree |

## Find (Telescope)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fs` | Live grep (contents) |
| `<leader>fg` | Live grep + ripgrep args (include/exclude globs); visual = grep selection |
| `<leader>fc` | Grep word under cursor |
| `<leader>ft` | Find TODOs |
| *(in picker)* `<C-j>/<C-k>` | Next / prev result |
| *(in picker)* `<C-q>` | Send results to quickfix |
| *(in picker)* `<C-t>` | Send results into Trouble (browsable, file-grouped, no re-search) |
| *(in picker)* `<C-v>/<C-x>` | Open in vertical / horizontal split |

## Search & replace (grug-far)

| Key | Action |
|-----|--------|
| `<leader>rr` | Open search & replace (project-wide) |
| `<leader>rw` | Open, pre-filled with word under cursor |
| `<leader>rf` | Open, scoped to current file |
| `<leader>rr` (visual) | Open, pre-filled with selection |
| *(in buffer)* `\l` / `\n` / `\p` | Sync current occurrence / then next / then prev |
| *(in buffer)* `\v` | Sync whole current file |
| *(in buffer)* `\s` | Sync everywhere (whole codebase) |
| *(in buffer)* `\c` | Close |

## Editing

| Key | Action |
|-----|--------|
| `gcc` / `gc{motion}` / `gc` (visual) | Toggle comment line / motion / selection |
| `gbc` / `gb` (visual) | Block comment |
| `ys{motion}{c}` | Add surround |
| `ds{c}` | Delete surround |
| `cs{old}{new}` | Change surround |
| `S` (visual) | Surround selection |
| `s{motion}` / `ss` / `S` | Substitute with register (motion / line / to-eol) |
| `s` (visual) | Substitute selection |
| `<C-space>` / `<BS>` | Treesitter: expand / shrink selection |
| `]t` / `[t` | Next / previous TODO comment |
| `<leader>us` | Toggle sticky scroll context (treesitter-context) |
| `<leader>uj` | Jump up to the pinned sticky context line |

## Completion menu (nvim-cmp, insert)

| Key | Action |
|-----|--------|
| `<C-j>` / `<C-k>` | Next / previous suggestion |
| `<CR>` | Confirm highlighted item |
| `<S-Tab>` | Confirm (auto-select first) — *overlaps Copilot accept* |
| `<C-f>` / `<C-b>` | Scroll docs down / up |
| `<C-e>` | Abort |

## LSP

| Key | Action |
|-----|--------|
| `gd` / `gD` | Go to definition / declaration |
| `gR` | References (Trouble — stays open to browse) |
| `gi` / `gt` | Implementations (Trouble) / type definitions |
| `gpd` / `gpi` / `gpt` | Peek definition / implementation / type in a float, no jump |
| `gpc` | Close peek preview floats |
| `K` | Hover docs |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>rs` | Restart LSP |

## Diagnostics

| Key | Action |
|-----|--------|
| `<leader>d` | Line diagnostic (float) |
| `<leader>D` | Buffer diagnostics (Telescope) |
| `]d` / `[d` | Next / previous diagnostic |
| `<leader>xw` | Workspace diagnostics (Trouble) |
| `<leader>xd` | Document diagnostics (Trouble) |
| `<leader>xq` / `<leader>xl` | Quickfix / location list (Trouble) |
| `<leader>xt` | TODOs (Trouble) |

## Format & lint

| Key | Action |
|-----|--------|
| `<leader>mp` | Format file / selection |
| `<leader>l` | Lint current file |
| *(on save)* | Auto-format |

## Git — Gitsigns

| Key | Action |
|-----|--------|
| `]h` / `[h` | Next / previous hunk |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk (normal & visual) |
| `<leader>hS` / `<leader>hR` | Stage / reset whole buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line (full) |
| `<leader>hB` | Toggle inline blame |
| `<leader>hd` / `<leader>hD` | Diff vs index / vs previous commit |
| `ih` | Hunk text object (e.g. `vih`, `dih`) |

## Git — Diffview & LazyGit

| Key | Action |
|-----|--------|
| `<leader>gd` | Open Diffview (working-tree changes) |
| `<leader>gh` / `<leader>gH` | File history / repo history |
| `<leader>gq` | Close Diffview |
| `<leader>lg` | Open LazyGit |

## Debugging (DAP)

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue / start |
| `<leader>do` / `<leader>di` | Step over / into |
| `<leader>dr` | Open REPL |
| `<leader>du` | Toggle debug UI |
| `<leader>de` | Evaluate (normal & visual) |
| `<leader>dt` | Terminate |

## CMake (C/C++/CUDA)

| Key | Action |
|-----|--------|
| `<leader>Cg` | Generate / configure |
| `<leader>Cb` / `<leader>Cr` | Build / run |
| `<leader>Cd` | Debug |
| `<leader>Ct` / `<leader>Ck` | Select target / kit |
| `<leader>Cc` | Clean |
| `<leader>Cx` | Stop runner |

## AI — Claude Code

| Key | Action |
|-----|--------|
| `<leader>ac` / `<leader>af` | Toggle / focus Claude |
| `<leader>ar` / `<leader>aC` | Resume / continue session |
| `<leader>am` | Select model |
| `<leader>ab` | Add current buffer to context |
| `<leader>as` (visual) | Send selection |
| `<leader>as` (tree) | Add file to context |
| `<leader>aa` / `<leader>ad` | Accept / deny diff |

## AI — Copilot & Copilot Chat

| Key | Action |
|-----|--------|
| `<S-Tab>` (insert) | Accept Copilot ghost suggestion |
| `<leader>ce` / `<leader>cd` | Enable / disable Copilot |
| `<leader>cp` | Copilot panel |
| `<leader>cf` / `<leader>cg` / `<leader>cr` | Fix / goto / reset suggestion |
| `<leader>cc` | Toggle Copilot Chat |
| `<leader>cb` | Chat with current buffer as context |
| `<leader>cv` (visual) | Chat with selection as context |

## Known overlaps to be aware of

- **`<S-Tab>`** — both Copilot accept and cmp confirm. Habit: use `<CR>` for cmp, `<S-Tab>` for Copilot.
- **`<leader>d`** — line diagnostic (LSP) shares the prefix with the DAP group (`<leader>db`, `<leader>dc`, …). Pause after `<leader>d` for the diagnostic; type the next key quickly for DAP.
- **`s`** — remapped to substitute-with-register (not the default "substitute character"). Use `c` to change characters instead.
