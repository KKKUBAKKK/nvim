return {
    "github/copilot.vim",
    event = "InsertEnter", -- Load Copilot when entering insert mode
    config = function()
        vim.g.copilot_no_tab_map = false
        vim.api.nvim_set_keymap("i", "<S-Tab>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
        vim.g.copilot_filetypes = {
            ["TelescopePrompt"] = false,
            ["markdown"] = true,
            [""] = false,
        }
    end,
    keys = {
        {
            "<leader>ce",
            function()
                vim.cmd("Copilot enable")
                vim.notify("Copilot enabled", vim.log.levels.INFO)
            end,
            desc = "Enable Copilot"
        },
        {
            "<leader>cd",
            function()
                vim.cmd("Copilot disable")
                vim.notify("Copilot disabled", vim.log.levels.INFO)
            end,
            desc = "Disable Copilot"
        },
        { "<leader>cp", "<cmd>Copilot panel<cr>", desc = "Open Copilot Panel" },
        { "<leader>cf", "<cmd>Copilot fix<cr>",   desc = "Fix Copilot Suggestion" },
        { "<leader>cg", "<cmd>Copilot goto<cr>",  desc = "Go to Copilot Suggestion" },
        { "<leader>cr", "<cmd>Copilot reset<cr>", desc = "Reset Copilot Session" },
    },
}
