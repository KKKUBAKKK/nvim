-- Claude Code <-> Neovim integration. Connects this editor to the Claude Code
-- CLI over its WebSocket MCP socket (same protocol as the official VS Code
-- extension), so Claude can see your current file/selection and propose edits
-- as a native Neovim diff that you accept or reject.
--
-- Keymaps live under <leader>a (the "AI" namespace, free of clashes with
-- Copilot <leader>c, DAP <leader>d and the file tree <leader>e). Requires the
-- `claude` CLI to be installed and on PATH.
return {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" }, -- enhanced terminal split for the CLI
    config = true,
    keys = {
        { "<leader>a",  nil,                              desc = "AI/Claude Code" },
        { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
        { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
        { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
        { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
        { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
        { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer to context" },
        { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        desc = "Send selection to Claude", mode = "v" },
        -- Press <leader>as on a file in the tree to add it to Claude's context.
        {
            "<leader>as",
            "<cmd>ClaudeCodeTreeAdd<cr>",
            desc = "Add file to context",
            ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
        },
        -- Diff review: Claude's proposed edits open in a native diff view.
        { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude's diff" },
        { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny Claude's diff" },
    },
}
