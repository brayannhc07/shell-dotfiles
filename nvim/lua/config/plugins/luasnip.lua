local ls = require "luasnip";
local types = require "luasnip.util.types";

local M = {}

function M.setup()
  ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { "<- Choice", "Error" } },
        },
      },
    },
  }

  vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end, { silent = true })

  -- Note: no <C-l> jump-back mapping — it clashes with Windsurf's accept-line.
  -- <S-Tab> handles backward snippet jumps via blink.cmp.
end

return M
