# Git

Three complementary tools: **Gitsigns** for inline, per-hunk work and blame; **Diffview** for reviewing whole-file / multi-file changes; **LazyGit** for a full terminal git UI.

## Gitsigns — hunks, staging & blame

Shows added/changed/removed lines in the sign column and lets you stage, reset, preview, and blame without leaving the buffer. A "hunk" is one contiguous block of changes.

### Navigate & preview

| Key | Action |
|-----|--------|
| `]h` | Jump to the next hunk |
| `[h` | Jump to the previous hunk |
| `<leader>hp` | **P**review the hunk under the cursor in a popup |

### Stage & reset

| Key | Mode | Action |
|-----|------|--------|
| `<leader>hs` | normal / visual | **S**tage the hunk (or the selected lines) |
| `<leader>hr` | normal / visual | **R**eset the hunk (discard changes) |
| `<leader>hS` | normal | Stage the **whole buffer** |
| `<leader>hR` | normal | Reset the **whole buffer** |
| `<leader>hu` | normal | **U**ndo the last stage-hunk |

### Blame (who changed this line, and when)

| Key | Action |
|-----|--------|
| `<leader>hb` | **B**lame the current line — full popup with commit, author, date, message |
| `<leader>hB` | Toggle persistent inline blame (virtual text) for **every** line as you move |

### Diff the current file

| Key | Action |
|-----|--------|
| `<leader>hd` | **D**iff this file against the index (staged version) |
| `<leader>hD` | Diff this file against the previous commit (`~`) |

### Hunk as a text object

| Key | Action |
|-----|--------|
| `ih` | (in operator/visual) Select the hunk — e.g. `vih` to visually select it, `dih` to delete it |

## Diffview — reviewing changes

[Diffview](https://github.com/sindrets/diffview.nvim) gives a side-by-side review surface for **all** your changes at once, and full file history. This is the best tool for **reviewing a batch of edits** — your own, or ones made by Claude Code — before committing.

| Key | Action |
|-----|--------|
| `<leader>gd` | Open Diffview — review **all uncommitted changes** vs HEAD, file-by-file |
| `<leader>gh` | History of the **current file** (scroll through past versions of it) |
| `<leader>gH` | History of the **whole repo** (commit log with diffs) |
| `<leader>gq` | Close Diffview |

**Inside Diffview:**

- Left panel lists changed files — `j`/`k` to move, `<CR>` to open a file's diff.
- `<Tab>` / `<S-Tab>` cycle to the next / previous file.
- In file-history view, pick a commit to see exactly what it changed.
- `g?` shows all Diffview mappings.

> Workflow for reviewing Claude's edits: after Claude modifies files, run `<leader>gd` to see everything it changed in one place, file by file, before you stage/commit. (For accepting/denying Claude's edits *as they're proposed*, see the diff keys in [08-ai-tools.md](08-ai-tools.md).)

## LazyGit — full git UI

[LazyGit](https://github.com/jesseduffield/lazygit) is a complete terminal git client (stage, commit, branch, rebase, push, resolve conflicts) in a floating window. Requires the `lazygit` binary installed on your system.

| Key | Action |
|-----|--------|
| `<leader>lg` | Open **L**azy**G**it for the current repo |

Inside LazyGit: it has its own keybindings — press `?` for help. Common ones: `<space>` stage, `c` commit, `P` push, `p` pull, `q` quit.

## Which tool when?

- **One hunk / one line** → Gitsigns (`<leader>h…`).
- **Review a set of changes, or a file's history** → Diffview (`<leader>g…`).
- **Commit, branch, rebase, push** → LazyGit (`<leader>lg`).
