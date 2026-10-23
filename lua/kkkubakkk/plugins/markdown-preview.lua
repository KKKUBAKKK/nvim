-- markdown-preview: live preview of the current markdown file in a browser
-- (supports Mermaid diagrams and KaTeX math). It runs a small local web server
-- and opens the browser on the machine Neovim runs on.
--
-- Over SSH there is no browser on the remote, so instead of trying to open one
-- the URL is just printed. Forward the fixed port and open it on your host:
--   ssh -L 8890:localhost:8890 user@remote
--   (or `LocalForward 8890 localhost:8890` in ~/.ssh/config)
-- With cmdheight=0 the URL message may vanish quickly -- see :messages.
--
-- Keymaps (markdown buffers only):
--   <leader>mb  toggle browser preview
return {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    -- Downloads the prebuilt server binary (no node/yarn needed). A shell
    -- command rather than mkdp#util#install(): the autoload function isn't on
    -- the runtimepath yet when lazy runs the build for an ft-lazy plugin.
    build = "cd app && ./install.sh",
    keys = {
        {
            "<leader>mb",
            function()
                vim.cmd("MarkdownPreviewToggle")
                -- The plugin is silent on toggle; its per-buffer state flag tells us which way it went.
                if vim.b.MarkdownPreviewToggleBool == 1 then
                    vim.notify("Markdown preview started (port " .. vim.g.mkdp_port .. ")")
                else
                    vim.notify("Markdown preview stopped")
                end
            end,
            ft = "markdown",
            desc = "Markdown: toggle browser preview",
        },
    },
    init = function()
        -- mkdp reads these globals when it loads, so they must be set in init.
        vim.g.mkdp_port = "8890" -- fixed port so SSH forwarding is predictable
        vim.g.mkdp_echo_preview_url = 1 -- print the preview URL
        vim.g.mkdp_auto_close = 0 -- keep preview open when switching buffers

        if vim.env.SSH_CONNECTION then
            -- No browser on the remote: do nothing, the echoed URL is enough.
            vim.cmd([[
                function! MkdpNoBrowser(url)
                endfunction
            ]])
            vim.g.mkdp_browserfunc = "MkdpNoBrowser"
        end
    end,
}
