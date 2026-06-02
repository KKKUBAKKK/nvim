return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			-- Define formatters for each filetype
			formatters_by_ft = {
				-- C/C++/CUDA (uses .clang-format in your project if present)
				c = { "clang_format" },
				cpp = { "clang_format" },
				cuda = { "clang_format" },
				-- Lua (this config)
				lua = { "stylua" },
				-- C#
				-- cs = { "csharpier" },
				-- Java
				-- java = { "google_java_format" },
				-- Kotlin
				-- kotlin = { "ktlint" },
				-- Python
				-- python = { "isort", "black" },
				-- Bash
				-- sh = { "shfmt" },
				-- Config files
				-- json = { "prettier" },
				-- yaml = { "prettier" },
				-- markdown = { "prettier" },
			},
			-- Format on save (synchronous so the buffer is formatted before write).
			-- lsp_format = "fallback" replaces the deprecated lsp_fallback = true.
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 2000,
			},
		})

		-- Keymap for manual formatting (can be used in normal or visual mode)
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_format = "fallback",
				async = false,
				timeout_ms = 2000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
