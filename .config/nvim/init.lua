local opt = vim.opt
local cmd = vim.cmd
local g = vim.g

cmd("filetype plugin indent on")
cmd("syntax on")
cmd("set noshowmode")
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.number = true
opt.termguicolors = true

g.loaded_gzip         = 1
g.loaded_tar          = 1
g.loaded_tarPlugin    = 1
g.loaded_zipPlugin    = 1
g.loaded_2html_plugin = 1
g.loaded_netrw        = 1
g.loaded_netrwPlugin  = 1
g.loaded_matchit      = 1
g.loaded_matchparen   = 1
g.loaded_spec         = 1

cmd("autocmd FileType typescriptreact setlocal shiftwidth=2 softtabstop=2 expandtab")
cmd("autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2 expandtab")

cmd("let g:nvim_tree_width = 35")

cmd('nnoremap <C-n> <cmd>NvimTreeToggle<cr>')

require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'mxw/vim-jsx'
    use 'neovim/nvim-lspconfig'
    use 'kyazdani42/nvim-tree.lua'
    use {
        'ms-jpq/coq_nvim', 
        branch = 'coq'
    }
    use 'lewis6991/impatient.nvim'
    use 'glepnir/galaxyline.nvim'
    use 'hrsh7th/nvim-compe'
    use 'nvim-treesitter/nvim-treesitter'
    use 'peitalin/vim-jsx-typescript'
    use 'norcalli/nvim-base16.lua'
    use "lukas-reineke/indent-blankline.nvim"
    use 'lewis6991/gitsigns.nvim'
    use 'nvim-lua/plenary.nvim'
end
)

require('impatient')

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "typescriptreact" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

local lsp = require('lspconfig')
local coq = require('coq')

local base16 = require('base16')

base16(base16.themes["default-dark"])

lsp.clangd.setup{}
lsp.rust_analyzer.setup{}
-- lsp.denols.setup{}
lsp.tsserver.setup{}
lsp.hls.setup{}

require ('statusline')
-- require('nord').set()
require("gitsigns").setup({
    signcolumn = false,
})

vim.g.nord_disable_background = true
vim.g.nord_borders = true

require'compe'.setup({
    enabled = true,
    source = {
        path = true,
        buffer = true,
        nvim_lsp = true,
    },
})

vim.g.indentLine_enabled = 1
vim.g.indent_blankline_char = "▏"

cmd "hi IndentBlanklineChar guifg=#282828"

vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_first_indent_level = false

cmd('hi LineNr guifg=#383838 guibg=#181818')
cmd('highlight StatusLine guifg=#181818 guibg=NONE')
cmd('highlight StatusLineNC gui=underline guifg=#282828 guibg=#181818')
cmd('highlight VertSplit guifg=#181818 guibg=NONE')

cmd('hi clear CursorLine')
cmd('highlight cursorlinenr guifg=#181818')
cmd('highlight Pmenu guibg=#282828')
cmd('highlight PmenuSel guibg=#383838')
cmd('highlight PmenuThumb guibg=#d8dee9')
cmd('highlight SignColumn guibg=none guifg=#181818')
--cmd('autocmd ColorScheme hi LineNr guifg=#ffffff')

cmd('highlight Normal guibg=none ctermbg=NONE')
