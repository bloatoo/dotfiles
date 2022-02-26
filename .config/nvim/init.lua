local opt = vim.opt
local cmd = vim.cmd
local g = vim.g

cmd("filetype plugin indent on")
cmd("syntax on")
cmd("set noshowmode")
cmd("let g:gruvbox_material_background = 'hard'")
vim.g.mapleader = "<Space>"
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
cmd("autocmd TermOpen * setlocal nonumber norelativenumber")

cmd('nnoremap <C-n> <cmd>NvimTreeToggle<cr>')
cmd('let g:nvim_tree_width = 35')
cmd('set mouse=a')
cmd('set t_md=')

require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'w0ng/vim-hybrid'
    use 'mxw/vim-jsx'
    use 'neovim/nvim-lspconfig'
    use 'sainnhe/gruvbox-material'
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
    use "lukas-reineke/indent-blankline.nvim"
    use 'lewis6991/gitsigns.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'rust-lang/rust.vim'
end
)

require('impatient')

require('nvim-tree').setup {}

cmd('let g:rustfmt_autosave = 1')

local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'clangd' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "typescriptreact", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

local coq = require('coq')

require ('statusline')
require("gitsigns").setup({
    signcolumn = false,
})

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

--cmd('hi LineNr guifg=#2e3440')
--cmd('highlight StatusLine guifg=#2e3440 guibg=#22262e')
--cmd('highlight StatusLineNC gui=underline guifg=#2e3440 guibg=#1e222a'):
--cmd('highlight VertSplit guifg=#2e3440')

--cmd('hi clear CursorLine')
--cmd('highlight cursorlinenr guifg=#22262e')
--cmd('highlight Pmenu guibg=#2e3440')
--cmd('highlight PmenuSel guibg=#4c566a')
--cmd('highlight PmenuThumb guibg=#d8dee9')
--cmd('highlight SignColumn guibg=none guifg=#22262e')
--cmd('autocmd ColorScheme hi LineNr guifg=#ffffff')

--cmd('highlight Normal guibg=none ctermbg=NONE')


cmd('colorscheme hybrid')

cmd('highlight DiagnosticError guifg=#cc6666')
cmd('highlight DiagnosticWarn guifg=#foc674')

cmd('hi LineNr guifg=#383838 guibg=#1d1f21')
-- cmd('highlight StatusLine guifg=#1d1f21 guibg=NONE')
-- cmd('highlight StatusLineNC gui=underline guifg=#282828 guibg=#1d1f21')
cmd('highlight VertSplit guifg=#282828 guibg=NONE')
cmd('highlight StatusLine guifg=#282828 guibg=#1d1f21')
cmd('highlight StatusLineNC gui=underline guifg=#282828 guibg=#1d1f21')

cmd('hi clear CursorLine')
cmd('highlight cursorlinenr guifg=#1d1f21')
cmd('highlight Pmenu guibg=#282828')
cmd('highlight PmenuSel guibg=#383838 guifg=#d8d8d8')
cmd('highlight PmenuThumb guibg=#d8dee9')
cmd('highlight SignColumn guibg=NONE guifg=#1d1f21')
cmd('highlight Normal guibg=none ctermbg=NONE')

cmd('highlight NvimTreeFolderIcon guifg=#81a2be')
cmd('highlight NvimTreeRootFolder guifg=#b294bb')
cmd('highlight NvimTreeGitStaged guifg=#8c9440')
cmd('highlight NvimTreeGitDirty guifg=#cc6666')
cmd('highlight NvimTreeSpecialFile guifg=#f0c674')
cmd('highlight NvimTreeExecFile guifg=#8c9440')
cmd('highlight NvimTreeGitDeleted guifg=#cc6666')
cmd('highlight NvimTreeImageFile guifg=#b294bb')
cmd('highlight NvimTreeSymlink guifg=#8abeb7')
