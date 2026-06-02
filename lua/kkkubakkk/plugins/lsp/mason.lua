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
				-- Lua (used by lazydev when editing this config)
				"lua_ls",
				-- Python
				-- "pyright",
				-- Bash
				-- "bashls",
				-- Assembly
				-- "asm_lsp",
				-- Kotlin
				-- "kotlin_language_server",
				-- C/C++
				"clangd",
				-- C#
				-- "omnisharp",
				-- CMake
				"cmake",
				-- Markdown
				-- "marksman",
				-- XML
				-- "lemminx",
				-- Docker
				-- "dockerls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				-- C/C++
				"clang-format", -- formatter (used by conform)
				-- Lua
				"stylua",       -- formatter (used by conform)
				-- Python
				-- "debugpy",
				-- "ruff",
				-- "black",
				-- "isort",
				-- Bash
				-- "shellcheck",
				-- "shfmt",
				-- Assembly
				-- "asmfmt",
				-- Kotlin
				-- "kotlin-debug-adapter",
				-- "ktlint",
				-- "detekt",
				-- C/C++ debug adapter (cppdbg) is installed by mason-nvim-dap (see dap.lua).
				-- "codelldb", -- alternative LLDB-based adapter, not used (we standardise on cppdbg)
				-- "cpplint",
				-- C#
				-- "ast_grep",
				-- "netcoredbg",
				-- CMake
				-- "cmakelang",
				-- Markdown
				-- "markdownlint",
				-- "prettier",
				-- Docker
				-- "hadolint",
			},
		})
	end,
}
