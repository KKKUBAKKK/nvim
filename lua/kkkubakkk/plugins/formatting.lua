return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			-- Define formatters for each filetype
			formatters_by_ft = {
				-- C/C++
				-- c = { "clangformat" },
				-- cpp = { "clangformat" },
				-- C#
				-- cs = { "omnisharp" }, -- Assuming OmniSharp provides formatting, or use a specific C# formatter like `dotnet format` if integrated
				-- Java
				-- java = { "google_java_format" }, -- Or 'prettierd' if you have a Java Prettier plugin
				-- Kotlin
				-- kotlin = { "ktlint" },
				-- Python (already good, but keeping it for completeness)
				-- python = { "isort", "black" },
				-- Bash
				-- sh = { "shfmt" },
				-- Lua (keeping it as a common Neovim config language)
				-- lua = { "stylua" },
				-- General purpose formatters for config files, etc.
				-- json = { "prettier" }, -- Prettier can still be useful for JSON files
				-- yaml = { "prettier" }, -- Prettier can still be useful for YAML files
				-- markdown = { "prettier" }, -- Prettier can still be useful for Markdown
			},
			-- Configure format-after-save behavior
			format_after_save = {
				lsp_fallback = true, -- Allow LSP formatters to be used if Conform doesn't have one
				async = true, -- Format asynchronously to avoid blocking Neovim
				timeout_ms = 2000, -- Increase timeout for potentially longer formatting processes
			},
		})

		-- Keymap for manual formatting (can be used in normal or visual mode)
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 2000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
