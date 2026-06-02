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
			-- Recent nvim-lspconfig ships a `stylua` config (cmd `stylua --lsp`).
			-- mason-lspconfig v2 auto-enables every mason-installed server that has
			-- an lspconfig config, so it tries to start stylua as a language server.
			-- The mason build of stylua has no `--lsp` mode and exits immediately
			-- ("Client stylua quit with exit code 2"). stylua is a formatter only
			-- (used by conform in formatting.lua), so exclude it from auto-enable.
			automatic_enable = {
				exclude = { "stylua" },
			},
			-- list of servers for mason to install
			ensure_installed = {
				-- Lua (used by lazydev when editing this config)
				"lua_ls",
				-- Python
				"pyright",
				-- Bash
				"bashls",
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
				"ruff",         -- linter + formatter (used by conform & nvim-lint; replaces black/isort)
				-- "debugpy",
				-- Bash
				"shellcheck",   -- linter (bash-language-server uses it for diagnostics)
				"shfmt",        -- formatter (used by conform)
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
