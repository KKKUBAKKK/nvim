return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    -- configure lualine to follow the active colorscheme (Gruvbox)
    lualine.setup({
      options = {
        theme = "gruvbox",
      },
      sections = {
        lualine_x = {
          -- cmdheight = 0 (core/options.lua) hides the "recording @q" message
          {
            function()
              return "recording @" .. vim.fn.reg_recording()
            end,
            cond = function()
              return vim.fn.reg_recording() ~= ""
            end,
            color = { fg = "#fe8019" },
          },
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
      },
    })
  end,
}
