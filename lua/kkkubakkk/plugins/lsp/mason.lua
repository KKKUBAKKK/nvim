return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				-- Lua
				"lua_ls",
				-- Python
				"pyright",
				-- Bash
				"bashls",
				-- Assembly
				-- "asm_lsp",
				-- Kotlin
				"kotlin_language_server",
				-- C/C++
				"clangd",
				-- C#
				-- "omnisharp",
				-- CMake
				"cmake",
				-- Markdown
				"marksman",
				-- XML
				-- "lemminx",
				-- Docker
				"dockerls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				-- Python
				"debugpy",
				"ruff",
				"black",
				"isort",
				-- Bash
				"shellcheck",
				"shfmt",
				-- Assembly
				-- "asmfmt",
				-- Kotlin
				"kotlin-debug-adapter",
				"ktlint",
				"detekt",
				-- C/C++
				"clang-format",
				"codelldb",
				"cpplint",
				-- C#
				-- "ast_grep",
				-- "netcoredbg",
				-- CMake
				"cmakelang",
				-- Markdown
				"markdownlint",
				"prettier",
				-- Docker
				-- "hadolint",
			},
		})
	end,
}
