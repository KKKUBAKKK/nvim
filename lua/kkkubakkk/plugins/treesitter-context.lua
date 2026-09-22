-- Sticky scroll: pins the enclosing class/function/block signature to the
-- top of the window as you scroll through its body.
return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    max_lines = 4, -- cap how many context lines can stack up
    multiline_threshold = 1,
  },
  keys = {
    { "<leader>us", "<cmd>TSContext toggle<CR>", desc = "Toggle sticky scroll context" },
    -- Note: intentionally not remapping [c/]c (diff-mode change navigation,
    -- used by Diffview) even though upstream docs often suggest [c for this.
    {
      "<leader>uj",
      function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end,
      desc = "Jump to sticky context above",
    },
  },
}
