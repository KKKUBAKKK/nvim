return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        -- import cmp-nvim-lsp plugin
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap -- for conciseness

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf, silent = true }

                -- set keybinds
                -- References/implementations use Trouble instead of Telescope: the
                -- list stays open in a sidebar as you jump between entries (a single
                -- result still jumps straight there), rather than closing after you
                -- pick one like a Telescope picker does.
                opts.desc = "Show LSP references"
                keymap.set("n", "gR", "<cmd>Trouble lsp_references toggle<CR>", opts) -- show usages, stays open to browse

                opts.desc = "Go to declaration"
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

                opts.desc = "Show LSP definitions"
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

                opts.desc = "Show LSP implementations"
                keymap.set("n", "gi", "<cmd>Trouble lsp_implementations toggle<CR>", opts) -- show implementations, stays open to browse

                opts.desc = "Show LSP type definitions"
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

                opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

                opts.desc = "Smart rename"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

                opts.desc = "Show buffer diagnostics"
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

                opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

                opts.desc = "Go to previous diagnostic"
                keymap.set("n", "[d", function()
                    vim.diagnostic.jump({ count = -1, float = true })
                end, opts) -- jump to previous diagnostic (vim.diagnostic.goto_prev was deprecated in 0.11)

                opts.desc = "Go to next diagnostic"
                keymap.set("n", "]d", function()
                    vim.diagnostic.jump({ count = 1, float = true })
                end, opts) -- jump to next diagnostic (vim.diagnostic.goto_next was deprecated in 0.11)

                opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
            end,
        })

        -- nvim-cmp capabilities, applied to every server below.
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Diagnostic UI: gutter signs + inline virtual text (Neovim 0.11 API).
        vim.diagnostic.config({
            virtual_text = true,
            severity_sort = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "E",
                    [vim.diagnostic.severity.WARN] = "W",
                    [vim.diagnostic.severity.HINT] = "H",
                    [vim.diagnostic.severity.INFO] = "I",
                },
            },
        })

        -- Neovim 0.11 native LSP: broadcast nvim-cmp capabilities to every server.
        -- mason-lspconfig v2 auto-enables installed servers (vim.lsp.enable), so we
        -- no longer call lspconfig[server].setup() or setup_handlers (removed in v2).
        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        -- clangd, tuned for C/C++/CUDA development.
        vim.lsp.config("clangd", {
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--function-arg-placeholders",
                "--fallback-style=llvm",
                -- Let clangd understand nvcc and host compilers so it can parse
                -- CUDA (.cu/.cuh) and cross-compiled translation units. Adjust the
                -- paths to match your toolchain if needed.
                "--query-driver=/usr/bin/nvcc,/usr/local/cuda*/bin/nvcc,/usr/bin/g++,/usr/bin/clang++",
            },
            init_options = {
                usePlaceholders = true,
                completeUnimported = true,
                clangdFileStatus = true,
            },
            -- Pin offset encoding to avoid clangd's "multiple offset encodings" warning.
            capabilities = vim.tbl_deep_extend("force", capabilities, {
                offsetEncoding = { "utf-16" },
            }),
        })

        -- lua_ls: recognise the `vim` global when editing this config.
        -- (lazydev.nvim supplies the Neovim runtime library types.)
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                    completion = { callSnippet = "Replace" },
                },
            },
        })
    end,
}
