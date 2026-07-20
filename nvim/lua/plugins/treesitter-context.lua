-- Sticky headers showing current function/class context
return {
  'nvim-treesitter/nvim-treesitter-context',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = "BufReadPost", -- Load after opening a file
  opts = {
    enable = true,
    max_lines = 3, -- How many lines of context to show
    min_window_height = 0, -- Minimum editor height to enable context
    line_numbers = true,
    multiline_threshold = 1, -- Maximum number of lines to show for a single context
    trim_scope = 'outer', -- Which context lines to discard if max_lines is exceeded
    mode = 'cursor', -- Line used to calculate context ('cursor' or 'topline')
    separator = nil, -- Separator between context and content (nil = none)
    zindex = 20, -- Z-index of the context window
    on_attach = function(buf)
      -- Disable for filetypes that cause parser errors with injected languages
      local dominated_filetypes = { 'markdown' }
      return not vim.tbl_contains(dominated_filetypes, vim.bo[buf].filetype)
    end,
  },
  keys = {
    {
      '<leader>ut',
      function()
        require('treesitter-context').toggle()
      end,
      desc = 'Toggle Treesitter Context',
    },
    {
      '[c',
      function()
        require('treesitter-context').go_to_context()
      end,
      desc = 'Jump to context (function/class start)',
    },
  },
}
