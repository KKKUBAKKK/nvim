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

## Markdown viewing — render-markdown & markdown-preview

Two ways to view a `.md` file rendered instead of as raw text (like VSCode's preview toggle). Files always open in raw (code) view; both keys only exist in markdown buffers.

| Key | Action |
|-----|--------|
| `<leader>mr` | **R**ender in the terminal — toggle between rendered and raw view |
| `<leader>mb` | Live preview in the **b**rowser — toggle |

- **`<leader>mr`** ([render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)) draws headings, code blocks, tables, checkboxes and callouts right in the buffer. The line under the cursor shows raw text, so you can edit while rendered. The toggle is per buffer — rendering one file doesn't render the others. It's pure terminal drawing, so it **works the same over SSH**. Icons need a Nerd Font in your (host) terminal.
- **`<leader>mb`** ([markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)) opens a live-updating page in your browser, with Mermaid diagrams and math. Locally it just opens your browser. A notification tells you whether the toggle **started** or **stopped** the preview (stopping shuts down the preview server, and the browser tab stops updating).

> **Browser preview over SSH:** the remote has no browser, so the config only prints the preview URL (check `:messages` if it disappears). The port is fixed at `8890`. Connect with `ssh -L 8890:localhost:8890 user@remote` (or add `LocalForward 8890 localhost:8890` to `~/.ssh/config`), then open the printed `http://localhost:8890/...` URL in your host browser.
