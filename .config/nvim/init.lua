local opt = vim.opt
local cmd = vim.cmd

cmd("filetype plugin indent on")
cmd("syntax on")
cmd("set noshowmode")
cmd("let g:gruvbox_material_background = 'hard'")
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.number = true
opt.termguicolors = true

require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'mxw/vim-jsx'
    use 'neovim/nvim-lspconfig'
    use 'sainnhe/gruvbox-material'
    use {
        'ms-jpq/coq_nvim', 
        branch='coq'
    }
    use 'glepnir/galaxyline.nvim'
    use 'shaunsingh/nord.nvim'
    use 'hrsh7th/nvim-compe'
    use 'nvim-treesitter/nvim-treesitter'
    use 'peitalin/vim-jsx-typescript'

    use "lukas-reineke/indent-blankline.nvim"

    use {
        'lewis6991/gitsigns.nvim',
        after = "plenary.nvim",
    }

    use {
        'nvim-lua/plenary.nvim',
        event = "BufRead"
    }

    use 'simrat39/rust-tools.nvim'
    use 'mfussenegger/nvim-dap'
end
)

local lsp = require('lspconfig')
local coq = require('coq')

lsp.clangd.setup{}
lsp.rust_analyzer.setup{}
-- lsp.denols.setup{}
lsp.tsserver.setup{}
lsp.hls.setup{}

require ('statusline')
require('nord').set()
--require("gitsigns").setup({
--    signcolumn = false,
--})

require('rust-tools').setup({})


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

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
vim.g.indentLine_enabled = 1
vim.g.indent_blankline_char = "▏"

cmd "hi IndentBlanklineChar guifg=#2e3440"

vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_first_indent_level = false

cmd('hi LineNr guifg=#2e3440')
cmd('highlight StatusLine guifg=#2e3440 guibg=#22262e')
cmd('highlight StatusLineNC gui=underline guifg=#2e3440 guibg=#1e222a')
cmd('highlight VertSplit guifg=#2e3440')

cmd('hi clear CursorLine')
cmd('highlight cursorlinenr guifg=#22262e')
cmd('highlight Pmenu guibg=#2e3440')
cmd('highlight PmenuSel guibg=#4c566a')
cmd('highlight PmenuThumb guibg=#d8dee9')
cmd('highlight SignColumn guibg=none guifg=#22262e')
--cmd('autocmd ColorScheme hi LineNr guifg=#ffffff')

cmd('highlight Normal guibg=none ctermbg=NONE')
