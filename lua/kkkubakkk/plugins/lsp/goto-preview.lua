-- Peek at a definition/implementation/type in a small floating window
-- without leaving your cursor position (unlike gd/gi which jump).
return {
  "rmagatti/goto-preview",
  event = "LspAttach",
  opts = {
    default_mappings = false,
    width = 120,
    height = 20,
    border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" },
    post_open_hook = function(_, win)
      -- <q> or <Esc> closes the preview window, like Telescope/help windows.
      vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true, silent = true })
      vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", { buffer = true, silent = true })
    end,
  },
  keys = {
    {
      "gpd",
      function()
        require("goto-preview").goto_preview_definition()
      end,
      desc = "Peek definition (float, no jump)",
    },
    {
      "gpi",
      function()
        require("goto-preview").goto_preview_implementation()
      end,
      desc = "Peek implementation (float, no jump)",
    },
    {
      "gpt",
      function()
        require("goto-preview").goto_preview_type_definition()
      end,
      desc = "Peek type definition (float, no jump)",
    },
    {
      "gpc",
      function()
        require("goto-preview").close_all_win()
      end,
      desc = "Close all peek preview windows",
    },
  },
}
