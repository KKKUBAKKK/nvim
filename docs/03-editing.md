# Editing

Text-manipulation plugins and autocompletion.

## Commenting — Comment.nvim

Treesitter-aware commenting (uses the right comment syntax per language).

| Key | Mode | Action |
|-----|------|--------|
| `gcc` | normal | Toggle comment on the current line |
| `gbc` | normal | Toggle **block** comment on the current line |
| `gc{motion}` | normal | Comment a motion, e.g. `gcap` (paragraph), `gc3j` (3 lines down) |
| `gc` | visual | Comment the selection |
| `gb` | visual | Block-comment the selection |
| `gcO` / `gco` | normal | Add a comment line above / below |
| `gcA` | normal | Add a comment at end of line |

## Surround — nvim-surround

Add/change/delete the pairs *around* text (quotes, brackets, tags…). Mnemonic: **s**urround.

| Key | Action |
|-----|--------|
| `ys{motion}{char}` | **Add** surround. e.g. `ysiw"` wraps the word in `"`, `yss)` wraps the line in `()` |
| `ds{char}` | **Delete** surround. e.g. `ds"` removes surrounding quotes |
| `cs{old}{new}` | **Change** surround. e.g. `cs"'` turns `"x"` into `'x'`, `cs)]` turns `(x)` into `[x]` |
| `S{char}` | (visual) Surround the selection |

Examples: `cs({` → `( x )` becomes `{ x }` · `ysiw<em>` wraps a word in an HTML tag.

## Substitute (replace with register) — substitute.nvim

Replaces text with the contents of a register in one motion — faster than `viw"0p`. **Note: this remaps `s`.**

| Key | Mode | Action |
|-----|------|--------|
| `s{motion}` | normal | Substitute the motion with the yanked register, e.g. `siw` replaces a word |
| `ss` | normal | Substitute the whole line |
| `S` | normal | Substitute to end of line |
| `s` | visual | Substitute the selection |

Typical flow: yank something with `yiw`, move elsewhere, `siw` to replace the target word with it.

## Autopairs

Brackets/quotes auto-close as you type, and it cooperates with completion (accepting a function adds `()`). Treesitter-aware, so it won't add pairs inside, e.g., Lua strings. No keys to learn — it just works.

## Treesitter — syntax & smart selection

[Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) provides accurate syntax highlighting and indentation for many languages (C, C++, CUDA, CMake, Lua, Python, and more are pre-installed; run `:TSUpdate` to refresh parsers).

**Incremental selection** — grow/shrink a selection by syntax node:

| Key | Action |
|-----|--------|
| `<C-space>` | Start selection / expand to the next bigger node (statement → block → function…) |
| `<BS>` | Shrink the selection to the previous node |

Great for "select this whole expression / block / function" without counting lines.

**Sticky scroll context** — [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) pins the enclosing class/function/block signature(s) to the top of the window as you scroll through their body, so you never lose track of what you're inside of.

| Key | Action |
|-----|--------|
| `<leader>us` | Toggle sticky scroll context on/off |
| `<leader>uj` | Jump the cursor up to the pinned context line |

## Autocompletion — nvim-cmp

The popup completion menu (LSP, snippets, buffer words, file paths). It appears as you type in insert mode.

| Key | Action |
|-----|--------|
| `<C-j>` | Next suggestion |
| `<C-k>` | Previous suggestion |
| `<CR>` | Confirm the **highlighted** suggestion (won't auto-pick if none selected) |
| `<S-Tab>` | Confirm, auto-selecting the first item |
| `<C-f>` / `<C-b>` | Scroll the documentation popup down / up |
| `<C-e>` | Abort / close the menu |

Sources, in priority order: Neovim Lua API (lazydev, when editing this config) → LSP → snippets → buffer text → file paths. Snippets come from [LuaSnip](https://github.com/L3MON4D3/LuaSnip) + friendly-snippets; icons via lspkind.

> **Heads-up — `<S-Tab>` overlap:** Copilot's inline suggestion accept is also bound to `<S-Tab>` (see [08-ai-tools.md](08-ai-tools.md)). When both the cmp menu and a Copilot ghost suggestion are visible, they compete for that key. If it ever feels ambiguous, accept cmp items with `<CR>` and let Copilot take `<S-Tab>`, or rebind one of them.

## TODO comments

Special comments like `TODO:`, `FIXME:`, `HACK:`, `NOTE:`, `WARN:`, `PERF:` are highlighted and searchable.

| Key | Action |
|-----|--------|
| `]t` | Jump to next TODO comment |
| `[t` | Jump to previous TODO comment |
| `<leader>ft` | List all TODOs in Telescope |
| `<leader>xt` | List all TODOs in the Trouble panel (see [04](04-lsp-and-diagnostics.md)) |
