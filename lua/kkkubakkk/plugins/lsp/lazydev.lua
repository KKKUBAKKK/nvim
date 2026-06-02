-- Replaces the now-archived neodev.nvim. Provides proper LuaLS types for the
-- Neovim runtime / vim.uv when you edit this config (loads only for Lua files).
return {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = {
            -- Load luvit types when the `vim.uv` word is found in a file.
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    },
}
