return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        -- visual debugger UI + inline variable values
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio", -- required by nvim-dap-ui
        "theHamsta/nvim-dap-virtual-text",
    },
    event = "VeryLazy",
    config = function()
        require("mason").setup()
        require("mason-nvim-dap").setup({
            ensure_installed = { "cppdbg" },
            automatic_installation = true,
        })

        local dap = require("dap")
        local dapui = require("dapui")

        -- Debug UI + inline virtual text for variable values.
        dapui.setup()
        require("nvim-dap-virtual-text").setup()

        -- Open the UI automatically when a session starts, close it when it ends.
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        dap.adapters.cppdbg = {
            id = 'cppdbg',
            type = 'executable',
            command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
        }

        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "cppdbg",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopAtEntry = true,
            },
        }
        dap.configurations.c = dap.configurations.cpp
        dap.configurations.objcpp = dap.configurations.cpp
    end,
    keys = {
        { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>",          desc = "DAP Continue" },
        { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "DAP Toggle Breakpoint" },
        { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>",         desc = "DAP Step Over" },
        { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>",         desc = "DAP Step Into" },
        { "<leader>dr", "<cmd>lua require'dap'.repl.open()<cr>",         desc = "DAP REPL" },
        { "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>",          desc = "DAP Toggle UI" },
        { "<leader>de", "<cmd>lua require'dapui'.eval()<cr>",            desc = "DAP Eval",       mode = { "n", "v" } },
        { "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>",         desc = "DAP Terminate" },
    },
}
