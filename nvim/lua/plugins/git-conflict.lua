-- Git conflict resolution with visual markers and quick keybindings
return {
  'akinsho/git-conflict.nvim',
  version = "*",
  event = 'BufReadPost',
  config = function()
    require('git-conflict').setup({
      default_mappings = true, -- Enable default keybindings
      default_commands = true, -- Enable default commands
      disable_diagnostics = false, -- Keep diagnostics enabled
      list_opener = 'copen', -- Open quickfix list with conflicts
      highlights = {
        incoming = 'DiffAdd',
        current = 'DiffText',
      }
    })
  end,
}
