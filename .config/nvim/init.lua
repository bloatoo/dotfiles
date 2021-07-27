local opt = vim.opt
local cmd = vim.cmd

cmd("filetype plugin indent on")
cmd("syntax on")
cmd("set noshowmode")
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.number = true
opt.termguicolors = true

require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'neovim/nvim-lspconfig'
    use 'glepnir/galaxyline.nvim'
    use 'shaunsingh/nord.nvim'
    use 'norcalli/nvim-base16.lua'
    use 'nvim-treesitter/nvim-treesitter'
    use 'hrsh7th/nvim-compe'
    use "lukas-reineke/indent-blankline.nvim"
end
)

local lsp = require('lspconfig')
lsp.rust_analyzer.setup{}
lsp.clangd.setup{}

-- require('nord').set()
require ('statusline')
require('nord').set()

vim.g.nord_disable_background = true
vim.g.nord_borders = true

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}

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
cmd('highlight StatusLineNC guifg=#2e3440 guibg=#22262e')
cmd('highlight VertSplit guifg=#2e3440')

cmd('hi clear CursorLine')
cmd('highlight cursorlinenr guifg=#22262e')

cmd('highlight Normal guibg=none ctermbg=NONE')
--cmd('autocmd ColorScheme hi LineNr guifg=#ffffff')
