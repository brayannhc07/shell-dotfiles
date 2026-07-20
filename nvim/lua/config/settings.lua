vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wildmode = 'longest:full,full'
vim.opt.completeopt = 'menuone,longest,preview'

vim.opt.title = true
vim.opt.mouse = 'a'

vim.opt.termguicolors = true

vim.opt.spell = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·' }
vim.opt.fillchars:append({ eob = ' ' })

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.confirm = true

vim.opt.signcolumn = 'yes:2'

vim.opt.undofile = true
-- vim.opt.backup = true
-- vim.opt.backupdir:remove('')
vim.opt.colorcolumn = '100,120'
vim.opt.synmaxcol = 500

vim.opt.wildignore:append({"*/node_modules/*"})

-- Disable treesitter for markdown (bundled parser in Neovim 0.12 causes errors)
local disabled_langs = { markdown = true, markdown_inline = true }

local original_ts_start = vim.treesitter.start
vim.treesitter.start = function(bufnr, lang, opts)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    lang = lang or vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
    if disabled_langs[lang] then return end
    return original_ts_start(bufnr, lang, opts)
end

local original_get_parser = vim.treesitter.get_parser
vim.treesitter.get_parser = function(bufnr, lang, opts)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    lang = lang or vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
    if disabled_langs[lang] then return nil end
    return original_get_parser(bufnr, lang, opts)
end
