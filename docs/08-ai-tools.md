# AI tools

Three AI assistants are wired in:

- **Claude Code** (`<leader>a…`) — Anthropic's agentic CLI, integrated into the editor.
- **GitHub Copilot** (`<leader>c…`) — inline autocomplete suggestions.
- **Copilot Chat** (`<leader>cc`, `<leader>cb`, `<leader>cv`) — a chat sidebar.

---

## Claude Code — `<leader>a`

[claudecode.nvim](https://github.com/coder/claudecode.nvim) connects this editor to the **Claude Code CLI** over the same protocol as the official VS Code extension. Claude runs in a terminal split, can see your current file and selections in real time, and proposes edits that open as a **native Neovim diff** you accept or reject.

> **Requirement:** the `claude` CLI must be installed and on your `PATH`. (You're using it right now to read this.)

### Keybindings

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ac` | normal | Toggle the Claude terminal open/closed |
| `<leader>af` | normal | Focus the Claude window |
| `<leader>ar` | normal | Resume a previous Claude session |
| `<leader>aC` | normal | Continue the most recent conversation |
| `<leader>am` | normal | Select which Claude model to use |
| `<leader>ab` | normal | **Add the current buffer** to Claude's context |
| `<leader>as` | **visual** | **Send the selected text** to Claude |
| `<leader>as` | in the file tree | **Add the hovered file** to Claude's context |
| `<leader>aa` | normal | **Accept** Claude's proposed diff |
| `<leader>ad` | normal | **Deny** Claude's proposed diff |

### How to use it

**Start a chat:** `<leader>ac` opens Claude in a split. Type your request. Toggle it away with `<leader>ac` again, or jump back with `<leader>af`.

**Give Claude context (the important part):**
- Whole file you're in → `<leader>ab`.
- A specific region → select it in visual mode, then `<leader>as`.
- A file you're not in → open the tree (`<leader>ee`), hover the file, press `<leader>as`.
- Add several files this way and they all stay in context for the conversation.

**Review & apply edits:** when Claude proposes changes, they open in a side-by-side diff. Read it, then:
- **Accept:** `<leader>aa` (or just `:w` the diff buffer).
- **Reject:** `<leader>ad` (or `:q`).
- You can even edit Claude's suggestion in the diff before accepting.

**See everything Claude changed:** after a batch of edits, use Diffview's `<leader>gd` to review all modified files at once before committing (see [05-git.md](05-git.md)). Files Claude edits on disk auto-reload in your open buffers (the `autoread` setting in [01-essentials.md](01-essentials.md)).

---

## GitHub Copilot — inline suggestions

[copilot.vim](https://github.com/github/copilot.vim) shows greyed-out "ghost text" suggestions as you type in insert mode. Loads on first insert.

| Key | Mode | Action |
|-----|------|--------|
| `<S-Tab>` | insert | **Accept** the current ghost suggestion |
| `<leader>ce` | normal | **E**nable Copilot |
| `<leader>cd` | normal | **D**isable Copilot |
| `<leader>cp` | normal | Open the Copilot **p**anel (multiple suggestions) |
| `<leader>cf` | normal | **F**ix / refresh the current suggestion |
| `<leader>cg` | normal | **G**o to a suggestion |
| `<leader>cr` | normal | **R**eset the Copilot session |

First use: run `:Copilot setup` and sign in with your GitHub account. Markdown files have Copilot enabled; it's disabled in Telescope prompts and unnamed buffers.

> **`<S-Tab>` overlap:** the completion menu (nvim-cmp) also uses `<S-Tab>` to confirm an item (see [03-editing.md](03-editing.md)). When both a cmp menu and a Copilot ghost suggestion are visible they compete. Practical habit: confirm cmp items with `<CR>`, and use `<S-Tab>` for Copilot. Rebind either in `plugins/copilot.lua` / `plugins/nvim-cmp.lua` if you prefer.

---

## Copilot Chat — `<leader>cc`

[CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim) is a chat window (vertical split, 80 cols wide) backed by `gpt-4.1`. Good for explaining code, generating tests, or asking questions about a selection.

| Key | Mode | Action |
|-----|------|--------|
| `<leader>cc` | normal | Toggle the chat window |
| `<leader>cb` | normal | Open chat with the **whole current buffer** as context |
| `<leader>cv` | visual | Open chat with the **selection** as context |

### Adding files as context

Two ways:

1. **Keymaps above** — `<leader>cb` (current buffer) or `<leader>cv` (visual selection) pre-load context before you type your question.
2. **Sticky context tokens** — inside the chat prompt, reference files/buffers directly. These persist across messages in the session:
   - `#file:src/kernel.cu` — include a specific file.
   - `#buffers` — include all open buffers.
   - `#filenames` — include the list of files in the workspace.

Example prompt: `Explain the memory access pattern in #file:src/matmul.cu and suggest a tiling improvement.`

---

## Which AI for what?

- **Multi-file changes, refactors, "do this task for me"** → Claude Code (`<leader>a`), with files added as context and edits reviewed via its diff.
- **Line-by-line autocomplete while typing** → Copilot ghost text (`<S-Tab>`).
- **"Explain / ask about this code" in a chat** → Copilot Chat (`<leader>cc`).
