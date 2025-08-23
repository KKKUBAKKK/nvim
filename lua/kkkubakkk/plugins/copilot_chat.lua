return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        vim.keymap.set('n', '<leader>cc', ':CopilotChatToggle<CR>', { desc = 'Toggle Copilot Chat' }),
        dependencies = { { "nvim-lua/plenary.nvim", branch = "master" }, },
        build = "make tiktoken",
        opts = {
            model = 'gpt-4.1',       -- AI model to use
            temperature = 0.1,       -- Lower = focused, higher = creative
            window = {
                layout = 'vertical', -- 'float',
                width = 80,          -- Fixed width in columns
                -- height = 20,         -- Fixed height in rows
                border = 'rounded',  -- 'single', 'double', 'rounded', 'solid'
                title = 'Copilot Chat',
                zindex = 100,        -- Ensure window stays on top
            },
            auto_insert_mode = true, -- Enter insert mode when opening
            headers = {
                user = '🐉 You: ',
                assistant = '👾 Copilot: ',
                tool = '🔧 Tool: ',
            },
            separator = '━━',
            show_folds = false, -- Disable folding for cleaner look
        },
    },
}
