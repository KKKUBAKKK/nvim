return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Define linters for each filetype
    lint.linters_by_ft = {
      -- C/C++
      -- c = { "clangtidy" }, -- Or "cpplint", "flawfinder", "cflow"
      -- cpp = { "clangtidy" }, -- Or "cpplint", "flawfinder"

      -- C#
      -- cs = { "dotnet_analyzer" }, -- Requires OmniSharp with Roslyn analyzers or a specific .NET linter

      -- Java
      -- java = { "checkstyle" }, -- Or "pmd", "spotbugs"

      -- Kotlin
      -- kotlin = { "ktlint" }, -- ktlint can act as both linter and formatter

      -- Python (ruff = fast linter; pyright handles type-checking via the LSP)
      python = { "ruff" },

      -- Bash: diagnostics come from bash-language-server, which runs shellcheck
      -- automatically when it's installed, so no separate nvim-lint entry is needed.

      -- Markdown (useful for documentation in any project)
      -- markdown = { "markdownlint" },
    }

    -- Autocommand group for linting
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    -- Trigger linting on these events
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    -- Keymap to manually trigger linting
    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
