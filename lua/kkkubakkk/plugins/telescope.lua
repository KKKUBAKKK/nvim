return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    -- Regexp search where you can pass ripgrep flags inline to include/exclude
    -- file types and directories (bound to <leader>fg below).
    "nvim-telescope/telescope-live-grep-args.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local lga_actions = require("telescope-live-grep-args.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            -- Send all results into Trouble instead: a persistent, file-grouped
            -- list you can walk through with preview, without re-running the
            -- search or losing your place (unlike picking one result at a time).
            ["<C-t>"] = function(...)
              require("lazy").load({ plugins = { "trouble.nvim" } })
              return require("trouble.sources.telescope").open(...)
            end,
          },
        },
      },
      extensions = {
        live_grep_args = {
          -- auto_quoting wraps the whole prompt in quotes; press the quote key
          -- below to close the quote after your pattern and type rg flags raw.
          auto_quoting = true,
          mappings = {
            i = {
              -- Quote the typed pattern and drop the cursor outside the quotes
              -- so the rest (e.g. --iglob *.cu) is parsed as ripgrep args.
              ["<C-y>"] = lga_actions.quote_prompt(),
              -- Same, but pre-fills ` --iglob ` ready for a glob.
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            },
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    local lga_shortcuts = require("telescope-live-grep-args.shortcuts")

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    -- Regexp grep with inline ripgrep args. Type the pattern, press <C-y> to
    -- quote it (or <C-i> to quote + start an --iglob), then type flags raw, e.g.
    --   foo<C-y> --iglob *.cu --iglob !build/**   to include/exclude paths.
    keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep_args<cr>", { desc = "Live grep with ripgrep args (include/exclude globs)" })
    keymap.set("v", "<leader>fg", lga_shortcuts.grep_visual_selection, { desc = "Live grep args: search visual selection" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
  end,
}
