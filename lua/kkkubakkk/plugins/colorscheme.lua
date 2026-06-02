-- Gruvbox: warm, retro, low-blue colorscheme.
-- Tweak `contrast` to "hard" for a darker background or "soft" for a lighter
-- one. `background` is set to dark in core/options.lua; flip it to "light" there
-- (or with `:set background=light`) to use Gruvbox's light variant.
return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- load before other start plugins
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        contrast = "", -- "hard" | "soft" | "" (medium, default)
        bold = true,
        italic = {
          strings = false,
          comments = true,
        },
        transparent_mode = false,
      })
      vim.o.background = "dark"
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
}
