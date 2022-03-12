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
cmd('let g:nvim_tree_width = 10')
cmd('set mouse=a')
cmd('set t_md=')

require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'kyazdani42/nvim-tree.lua'
    use 'w0ng/vim-hybrid'
    use 'mxw/vim-jsx'
    use 'neovim/nvim-lspconfig'
    use 'sainnhe/gruvbox-material'
    use 'akinsho/bufferline.nvim'

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

require('nvim-tree').setup {}

vim.o.termguicolors = true

-- colors for active , inactive uffer tabs
require "bufferline".setup {
    options = {
        buffer_close_icon = "",
        modified_icon = "●",
        left_trunc_marker = "",
        right_trunc_marker = "",
        separator = "  ",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 18,
        view = "multiwindow",
        show_buffer_close_icons = false,
        separator_style = "default"
    },
    highlights = {
        background = {
            guifg = comment_fg,
            guibg = "#212326"
        },
        fill = {
            guifg = comment_fg,
            guibg = "#212326"
        },
        buffer_selected = {
            guifg = normal_fg,
            guibg = "#383c40",
            gui = "bold"
        },
        buffer_visible = {
            guifg = "#383c40",
            guibg = "#212326"
        },
        separator_visible = {
            guifg = "#fff",
            guibg = "#212326"
        },
        separator_selected = {
            guifg = "#383c40",
            guibg = "#212326"
        },
        separator = {
            guifg = "#212326",
            guibg = "#212326"
        },
        indicator_selected = {
            guifg = "#383c40",
            guibg = "#383c40"
        },
        modified_selected = {
            guifg = string_fg,
            guibg = "#383c40"
        }
    }
}

local opt = {silent = true}

vim.g.mapleader = " "

--command that adds new buffer and moves to it
vim.api.nvim_command "com -nargs=? -complete=file_in_path New badd <args> | blast"
vim.api.nvim_set_keymap("n", "<S-b>", ":New ", opt)

--removing a buffer
vim.api.nvim_set_keymap("n", "<S-f>", [[<Cmd>bdelete<CR>]], opt)

-- tabnew and tabprev
vim.api.nvim_set_keymap("n", "<S-l>", [[<Cmd>BufferLineCycleNext<CR>]], opt)
vim.api.nvim_set_keymap("n", "<S-s>", [[<Cmd>BufferLineCyclePrev<CR>]], opt)

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

local servers = { 'rust_analyzer', 'tsserver', 'clangd' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

require'nvim-treesitter.configs'.setup {
  hi = {
    enable = true,              -- false will disable the whole extension
    disable = { "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate his.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_hiing = false,
  },
}

local coq = require('coq')

require ('statusline')
require('bufferline')
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

cmd "hi IndentBlanklineChar guifg=#212326"

vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_first_indent_level = false

cmd('colorscheme hybrid')

-- lsp
cmd('hi DiagnosticError guifg=#cc6666')
cmd('hi DiagnosticWarn guifg=#foc674')

-- general UI stuff
cmd('hi LineNr guifg=#383838 guibg=#1d1f21')
cmd('hi VertSplit guifg=#212326 guibg=NONE')
cmd('hi StatusLine guifg=#212326 guibg=#1d1f21')
cmd('hi StatusLineNC gui=underline guifg=#212326 guibg=#1d1f21')
cmd('hi clear CursorLine')
cmd('hi cursorlinenr guifg=#1d1f21')
cmd('hi Pmenu guibg=#212326')
cmd('hi PmenuSel guibg=#383838 guifg=#d8d8d8')
cmd('hi PmenuThumb guibg=#d8dee9')
cmd('hi SignColumn guibg=NONE guifg=#1d1f21')
cmd('hi Normal guibg=none ctermbg=NONE')

-- NvimTree
cmd('hi NvimTreeFolderIcon guifg=#81a2be')
cmd('hi NvimTreeRootFolder guifg=#b294bb')
cmd('hi NvimTreeGitStaged guifg=#8c9440')
cmd('hi NvimTreeGitDirty guifg=#cc6666')
cmd('hi NvimTreeSpecialFile guifg=#f0c674')
cmd('hi NvimTreeExecFile guifg=#8c9440')
cmd('hi NvimTreeGitDeleted guifg=#cc6666')
cmd('hi NvimTreeImageFile guifg=#b294bb')
cmd('hi NvimTreeSymlink guifg=#8abeb7')

-- TSX syntax highlighting
if(vim.bo.filetype == "typescriptreact")
then
    cmd('hi tsxTSType guifg=#f0c674')
    cmd('hi tsxTSTagDelimiter guifg=#f0c674')
    cmd('hi tsxTSTagAttribute guifg=#de395f')
    cmd('hi tsxTSConstructor guifg=#f0c674')
    cmd('hi tsxTSVariable guifg=#c5c8c6')
    cmd('hi tsxTSPunctBracket guifg=#c5c8c6')
    cmd('hi tsxTSPunctDelimiter guifg=#c5c8c6')
    cmd('hi tsxTSFunction guifg=#f0c674')
    cmd('hi tsxTSKeywordFunction guifg=#81a2be')
end
