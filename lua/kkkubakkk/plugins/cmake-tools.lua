-- CMake integration: configure, build, run and debug CMake/CUDA projects from
-- inside Neovim. Generates compile_commands.json so clangd indexes the project
-- correctly. Keymaps live under <leader>C to avoid clashing with the <leader>c
-- Copilot mappings.
return {
    "Civitasv/cmake-tools.nvim",
    ft = { "c", "cpp", "cuda", "cmake" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        cmake_command = "cmake",
        cmake_build_directory = "build",
        -- Export compile_commands.json and symlink it to the project root so
        -- clangd (with --background-index) picks it up automatically.
        cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" },
        cmake_soft_link_compile_commands = true,
        cmake_dap_configuration = {
            name = "cpp",
            type = "cppdbg", -- matches the adapter configured in dap.lua
            request = "launch",
            stopOnEntry = false,
            runInTerminal = true,
        },
    },
    keys = {
        { "<leader>Cg", "<cmd>CMakeGenerate<cr>",          desc = "CMake generate" },
        { "<leader>Cb", "<cmd>CMakeBuild<cr>",             desc = "CMake build" },
        { "<leader>Cr", "<cmd>CMakeRun<cr>",               desc = "CMake run" },
        { "<leader>Cd", "<cmd>CMakeDebug<cr>",             desc = "CMake debug (DAP)" },
        { "<leader>Ct", "<cmd>CMakeSelectBuildTarget<cr>", desc = "CMake select target" },
        { "<leader>Ck", "<cmd>CMakeSelectKit<cr>",         desc = "CMake select kit" },
        { "<leader>Cc", "<cmd>CMakeClean<cr>",             desc = "CMake clean" },
        { "<leader>Cx", "<cmd>CMakeStopRunner<cr>",        desc = "CMake stop runner" },
    },
}
