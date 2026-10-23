-- render-markdown: render markdown *inside* the buffer (headings, code blocks,
-- tables, checkboxes, callouts) using treesitter. Pure terminal drawing, so it
-- works the same locally and over SSH. The line under the cursor is shown raw,
-- so you can keep editing while rendered.
--
-- Files open raw (code view) by default; the toggle is per buffer, so turning
-- rendering on in one file doesn't affect others.
--
-- Keymaps (markdown buffers only):
--   <leader>mr  toggle rendered / raw view
return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>mr", "<cmd>RenderMarkdown buf_toggle<cr>", ft = "markdown", desc = "Markdown: toggle render (in terminal)" },
    },
    opts = {
        enabled = false, -- start in raw view
    },
}
