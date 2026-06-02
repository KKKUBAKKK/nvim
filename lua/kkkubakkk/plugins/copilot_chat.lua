return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = { { "nvim-lua/plenary.nvim", branch = "master" }, },
        build = "make tiktoken",
        cmd = { "CopilotChat", "CopilotChatToggle" },
        keys = {
            { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
            -- Open chat with the whole current buffer as context.
            {
                "<leader>cb",
                function()
                    require("CopilotChat").open({
                        selection = require("CopilotChat.select").buffer,
                    })
                end,
                desc = "Copilot Chat: current buffer as context",
            },
            -- Open chat with the visual selection as context.
            {
                "<leader>cv",
                function()
                    require("CopilotChat").open({
                        selection = require("CopilotChat.select").visual,
                    })
                end,
                mode = "v",
                desc = "Copilot Chat: selection as context",
            },
            -- Tip: inside the chat prompt you can also pull in specific files with
            -- sticky context tokens, e.g. `#file:src/main.cu` or `#buffers` for all
            -- open buffers. These persist across messages in the same session.
        },
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
