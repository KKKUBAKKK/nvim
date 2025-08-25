return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
    },
    event = "VeryLazy",
    config = function()
        require("mason").setup()
        require("mason-nvim-dap").setup({
            ensure_installed = { "cppdbg" },
            automatic_installation = true,
        })

        local dap = require("dap")
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
    },
}
