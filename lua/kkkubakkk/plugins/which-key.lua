return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    -- Group labels shown in the which-key popup (v3 spec format).
    spec = {
      { "<leader>a", group = "AI/Claude Code" },
      { "<leader>c", group = "Copilot" },
      { "<leader>d", group = "Debug (DAP)" },
      { "<leader>e", group = "Explorer (tree)" },
      { "<leader>f", group = "Find (Telescope)" },
      { "<leader>g", group = "Git diff (Diffview)" },
      { "<leader>h", group = "Git hunks (Gitsigns)" },
      { "<leader>r", group = "Rename / Restart LSP / Replace" },
      { "<leader>s", group = "Splits" },
      { "<leader>t", group = "Tabs" },
      { "<leader>u", group = "UI Toggle" },
      { "<leader>C", group = "CMake" },
    },
  },
}
