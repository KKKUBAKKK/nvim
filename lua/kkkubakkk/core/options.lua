vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true         -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 4       -- 4 spaces for tabs (prettier default is 2)
opt.shiftwidth = 4    -- 4 spaces for indent width
opt.expandtab = true  -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
opt.termguicolors = true
opt.background = "dark" -- fallback until core/theme.lua restores the last-used theme/background
opt.signcolumn = "yes"  -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- swapfile
opt.swapfile = true

-- sessions (auto-session): include localoptions so filetype/highlighting
-- are restored correctly, as recommended by :checkhealth auto-session
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- auto-reload files changed outside Neovim (e.g. edits made by the Claude Code
-- CLI on disk). autoread alone only re-reads on certain triggers, so we also
-- run :checktime when regaining focus or the cursor goes idle.
opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    group = vim.api.nvim_create_augroup("AutoReadOnExternalChange", { clear = true }),
    callback = function()
        -- Don't clobber the command line while typing a command.
        if vim.fn.mode() ~= "c" and vim.fn.getcmdwintype() == "" then
            vim.cmd("checktime")
        end
    end,
})
-- Notify when a buffer was reloaded from a changed file on disk.
vim.api.nvim_create_autocmd("FileChangedShellPost", {
    group = "AutoReadOnExternalChange",
    callback = function()
        vim.notify("File changed on disk, buffer reloaded", vim.log.levels.WARN)
    end,
})
