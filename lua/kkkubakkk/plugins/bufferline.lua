-- bufferline derives its colors by darkening the Normal background (by up to
-- 45%), which on gruvbox makes the tab bar look nearly black. Swap those
-- derived shades for the active colorscheme's own tab bar colors (TabLineFill
-- for the empty bar, TabLine for unselected tabs); the selected tab keeps the
-- Normal background. This re-runs on every ColorScheme change, so it follows
-- whichever theme core/theme.lua applies.
local function theme_tabline_highlights(defaults)
  local colors = require("bufferline.colors")
  local normal_bg = colors.get_color({ name = "Normal", attribute = "bg" })
  local fill_bg = colors.get_color({ name = "TabLineFill", attribute = "bg" })
  local tab_bg = colors.get_color({ name = "TabLine", attribute = "bg" })
  if not (normal_bg and fill_bg and tab_bg) then
    return {}
  end

  -- Same shading percentages bufferline uses in its derive_colors()
  local bright = colors.color_is_bright(normal_bg)
  local remap = {
    [colors.shade_color(normal_bg, bright and -20 or -45)] = fill_bg, -- empty bar + separators
    [colors.shade_color(normal_bg, bright and -12 or -25)] = tab_bg, -- unselected tabs
    [colors.shade_color(normal_bg, -8)] = tab_bg, -- visible (non-current) tabs
  }

  local overrides = {}
  for name, attrs in pairs(defaults.highlights) do
    for _, key in ipairs({ "fg", "bg", "sp" }) do
      local new = attrs[key] and remap[attrs[key]]
      if new then
        overrides[name] = overrides[name] or {}
        overrides[name][key] = new
      end
    end
  end
  return overrides
end

return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "tabs",
      separator_style = "slant",
    },
    highlights = theme_tabline_highlights,
  },
}
