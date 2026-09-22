-- Theme manager: switches between a few predefined colorschemes, toggles
-- light/dark for whichever one is active, and remembers the last choice
-- across restarts (state file under stdpath("state")).
--
-- Colorschemes are lazy-loaded on demand via lazy.nvim, so only the one
-- actually in use ever gets `setup()`-ed / parsed.
local M = {}

-- `dark`/`light` are the concrete `:colorscheme` names to use for each
-- background. `plugin` is the lazy.nvim plugin name to load on demand.
M.themes = {
  { name = "gruvbox", plugin = "gruvbox.nvim", dark = "gruvbox", light = "gruvbox" },
  { name = "tokyonight", plugin = "tokyonight.nvim", dark = "tokyonight-moon", light = "tokyonight-day" },
  { name = "catppuccin", plugin = "catppuccin", dark = "catppuccin-mocha", light = "catppuccin-latte" },
  { name = "kanagawa", plugin = "kanagawa.nvim", dark = "kanagawa-wave", light = "kanagawa-lotus" },
  { name = "rose-pine", plugin = "rose-pine", dark = "rose-pine-moon", light = "rose-pine-dawn" },
  { name = "everforest", plugin = "everforest", dark = "everforest", light = "everforest" },
  { name = "nightfox", plugin = "nightfox.nvim", dark = "nightfox", light = "dawnfox" },
  { name = "melange", plugin = "melange", dark = "melange", light = "melange" },
}

local state_file = vim.fn.stdpath("state") .. "/theme_state.json"

local function find_theme(name)
  for _, theme in ipairs(M.themes) do
    if theme.name == name then
      return theme
    end
  end
end

local function read_state()
  local f = io.open(state_file, "r")
  if not f then
    return nil
  end
  local content = f:read("*a")
  f:close()
  local ok, decoded = pcall(vim.json.decode, content)
  if ok and decoded and find_theme(decoded.name) then
    return decoded
  end
end

local function write_state(state)
  local f = io.open(state_file, "w")
  if not f then
    return
  end
  f:write(vim.json.encode(state))
  f:close()
end

M.state = read_state() or { name = "gruvbox", background = "dark" }

-- Highlight tweaks that should hold regardless of which colorscheme is
-- active. Gitsigns' current-line-blame text is very dim by default in most
-- themes; borrow whatever the active theme uses for DiagnosticWarn (usually
-- a strong yellow/orange, not otherwise used by treesitter groups) so it
-- stays legible everywhere.
local function apply_custom_highlights()
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = "DiagnosticWarn", link = false })
  local fg = (ok and hl.fg) and string.format("#%06x", hl.fg) or "#fe8019"
  vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = fg, italic = true })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = apply_custom_highlights,
})

--- Apply a theme + background, load its plugin on demand, and persist it.
function M.apply(name, background)
  local theme = find_theme(name)
  if not theme then
    vim.notify("Unknown theme: " .. tostring(name), vim.log.levels.WARN)
    return
  end

  require("lazy").load({ plugins = { theme.plugin } })

  vim.o.background = background
  vim.cmd.colorscheme(background == "light" and theme.light or theme.dark)

  M.state = { name = theme.name, background = background }
  write_state(M.state)
end

--- Re-apply whatever was last saved (called once at startup).
function M.apply_saved()
  M.apply(M.state.name, M.state.background)
end

--- Flip light/dark for the current theme.
function M.toggle_background()
  M.apply(M.state.name, M.state.background == "dark" and "light" or "dark")
end

--- Step to the next theme in `M.themes`, keeping the current background.
function M.cycle()
  local idx = 1
  for i, theme in ipairs(M.themes) do
    if theme.name == M.state.name then
      idx = i
      break
    end
  end
  local next_theme = M.themes[(idx % #M.themes) + 1]
  M.apply(next_theme.name, M.state.background)
end

--- Open a picker to jump straight to a theme by name.
function M.pick()
  vim.ui.select(
    vim.tbl_map(function(theme)
      return theme.name
    end, M.themes),
    { prompt = "Select theme" },
    function(choice)
      if choice then
        M.apply(choice, M.state.background)
      end
    end
  )
end

return M
