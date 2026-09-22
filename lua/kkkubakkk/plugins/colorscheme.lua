-- Predefined colorscheme presets. Only gruvbox loads eagerly (as a safe
-- default); the others are lazy and get loaded on demand by the theme
-- manager (`core/theme.lua`) when selected via <leader>ut/<leader>uc, or
-- when restoring the last-used theme at startup.
--
-- Switching themes/backgrounds is NOT done here — see core/theme.lua and
-- the <leader>ub/<leader>ut/<leader>uc keymaps in core/keymaps.lua.
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
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {},
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {},
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {},
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    opts = {},
  },
  {
    "sainnhe/everforest",
    name = "everforest",
    lazy = true,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    opts = {},
  },
  {
    "savq/melange-nvim",
    name = "melange",
    lazy = true,
  },
}
