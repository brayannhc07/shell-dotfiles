-- Snacks.nvim provides dashboard, smooth scrolling, and beautiful notifications
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- Enable smooth scrolling
    scroll = { enabled = true },

    -- Enable beautiful notifications
    notifier = {
      enabled = true,
      timeout = 3000,
    },

    -- Enable dashboard
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },

    -- Indent guides (replaces indent-blankline)
    indent = { enabled = true },

    -- Other useful features
    -- Treat files over 512KB as "big": disables treesitter/syntax/folds for
    -- them so huge generated files open instantly (default threshold is 1.5MB)
    bigfile = { enabled = true, size = 512 * 1024 },
    quickfile = { enabled = true },
    statuscolumn = { enabled = false }, -- Keep default statuscolumn
    words = { enabled = true },
  },
  keys = {
    { "<F1>", function() Snacks.terminal.toggle() end, mode = { "n", "t" }, desc = "Toggle Terminal" },
    { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>go", function() Snacks.gitbrowse() end, desc = "Git Browse (Open in Browser)" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
    { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log" },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.inlay_hints():map("<leader>uh")
      end,
    })
  end,
}
