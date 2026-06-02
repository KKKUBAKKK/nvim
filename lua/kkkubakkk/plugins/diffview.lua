-- Diffview: review changes across the whole working tree or the history of a
-- single file in a side-by-side UI. Complements gitsigns (which handles
-- per-hunk staging and inline blame under <leader>h) by giving a full-file /
-- multi-file review surface -- handy for looking over your own or Claude
-- Code's edits before committing.
--
-- Keymaps under <leader>g ("Git diff"):
--   <leader>gd  DiffviewOpen        -- all uncommitted changes vs HEAD
--   <leader>gh  file history (%)    -- git history of the current file
--   <leader>gH  repo history        -- git history of the whole repo
--   <leader>gq  DiffviewClose       -- close any diffview tab
return {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    keys = {
        { "<leader>gd", "<cmd>DiffviewOpen<cr>",          desc = "Diffview: open (working tree changes)" },
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: current file history" },
        { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",   desc = "Diffview: repo history" },
        { "<leader>gq", "<cmd>DiffviewClose<cr>",         desc = "Diffview: close" },
    },
    opts = {
        enhanced_diff_hl = true, -- clearer added/removed highlighting
    },
}
