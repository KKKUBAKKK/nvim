-- Project-wide regex search & replace with a live-updating result list you
-- can review before applying: search all occurrences, edit the replacement,
-- and sync one line, one file, or everything at once.
return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  opts = {},
  keys = {
    {
      "<leader>rr",
      function()
        require("grug-far").open({})
      end,
      desc = "Search & replace (project-wide, regex)",
    },
    {
      "<leader>rw",
      function()
        require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
      end,
      desc = "Search & replace: word under cursor",
    },
    {
      "<leader>rf",
      function()
        require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
      end,
      desc = "Search & replace: current file only",
    },
    {
      "<leader>rr",
      function()
        require("grug-far").open({ visualSelectionUsage = "auto-detect" })
      end,
      mode = "v",
      desc = "Search & replace: from selection",
    },
  },
}
