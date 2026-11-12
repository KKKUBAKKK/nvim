return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
        "cpp",
        "cmake",
        "make",
        "c_sharp",
        "cuda",
        "python",
        "java",
        "kotlin",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })

    -- OpenCL C is a C dialect: reuse the C parser for highlighting,
    -- indentation and incremental selection in *.cl buffers.
    vim.treesitter.language.register("c", "opencl")

    -- The C parser leaves OpenCL qualifiers (__kernel, __global, ...) as ERROR
    -- nodes and knows nothing of OpenCL builtins, so also run the Vim regex
    -- syntax (after/syntax/opencl.vim) underneath tree-sitter for opencl.
    -- (additional_vim_regex_highlighting can't do this: it matches the parser
    -- name "c", which would turn regex syntax on for every C file.)
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("OpenCLRegexSyntax", { clear = true }),
      pattern = "opencl",
      callback = function(args)
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(args.buf) then
            vim.bo[args.buf].syntax = "opencl"
          end
        end)
      end,
    })
  end,
}
