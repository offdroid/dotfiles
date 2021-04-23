require 'plugins' -- ./lua/plugins.lua
local utils = require 'utils' -- ./lua/utils.lua
local opt = utils.opt
local map = utils.map

if vim.fn.has('persistent_undo') == 1 then
    local target_path = vim.fn.expand('~/.vim/undo')
    if not vim.fn.isdirectory(target_path) then
        os.execute("mkdir -p " .. target_path)
    end
    if vim.fn.isdirectory(target_path) then
        vim.o.undodir = target_path
        vim.o.undofile = true
    end
end

vim.cmd 'filetype plugin indent on'
vim.cmd 'syntax on'

opt('o', 'title', true)

-- Show line numbers
opt('w', 'number', true)
opt('w', 'relativenumber', true)
opt('w', 'signcolumn', 'yes')
-- Indicate current line
opt('w', 'cursorline', true)
-- Mouse support in all modes
opt('o', 'mouse', 'a')
-- Indentation
opt('o', 'autoindent', true)
opt('o', 'smartindent', true)
opt('b', 'shiftwidth', 4)
opt('b', 'expandtab', true)
-- Treesitter based folding
opt('w', 'foldlevel', 99)
opt('w', 'foldmethod', 'expr')
opt('w', 'foldexpr', 'nvim_treesitter#foldexpr()')
-- Combine system clipboard and the unnamed register
opt('o', 'clipboard', 'unnamed,unnamedplus')

opt('o', 'ignorecase', true)
-- Incremental search
opt('o', 'incsearch', true)
opt('o', 'inccommand', 'split')
opt('o', 'completeopt', 'menu,preview')

opt('o', 'splitbelow', true)
opt('o', 'splitright', true)
-- Set leader
vim.cmd 'nnoremap <SPACE> <Nop>'
vim.g.mapleader = ' '

if vim.fn.has('termguicolors') then vim.o.termguicolors = true end
vim.g.tokyonight_style = 'night'
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = {"quickfix", "__vista__", "terminal"}
vim.cmd 'colorscheme tokyonight' -- onedark

-- lsp and treesitter
require 'lsp' -- ./lua/lsp.lua
require 'treesitter' -- ./lua/treesitter.lua

-- compe
map('i', '<c-y>', [[compe#confirm('c-y')]], {silent = true, expr = true})
map('i', '<c-e>', [[compe#close('c-e')]], {silent = true, expr = true})
map('i', '<c-f>', [[compe#scroll({ 'delta': +4 })]],
    {silent = true, expr = true})
map('i', '<c-d>', [[compe#scroll({ 'delta': -4 })]],
    {silent = true, expr = true})

-- Ultisnips
vim.api
    .nvim_set_var('UltiSnipsSnippetDirectories', {'UltiSnips', 'my_snippets'})
vim.api.nvim_set_var('UltiSnipsJumpForwardTrigger', '<c-b>')
vim.api.nvim_set_var('UltiSnipsJumpBackwardTrigger', '<c-z>')

-- Lualine
require('lualine').setup {
    options = {theme = 'tokyonight', extensions = {'nvim-tree', 'fugitive'}}
}

-- pandoc-preview
vim.api.nvim_set_var('pandoc_preview_pdf_cmd', 'zathura')

-- indent-blankline
vim.api.nvim_set_var('indent_blankline_char', '┊')
vim.api.nvim_set_var('indent_blankline_show_first_indent_level', false)
vim.api.nvim_set_var('indent_blankline_show_end_of_line', true)
vim.api.nvim_set_var('indent_blankline_show_trailing_blankline_indent', false)

-- vista
map('n', '<leader>sv', ':Vista!!<cr>', {silent = true})

-- nvim-tree
vim.api.nvim_set_var('nvim_tree_disable_netrw', 0)
vim.api.nvim_set_var('nvim_tree_hijack_netrw', 0)
map('n', '<leader>sf', ':NvimTreeToggle<cr>')

-- telescope
map('n', '<leader>ff',
    [[<cmd>lua require('telescope.builtin').find_files()<cr>]], {silent = true})
map('n', '<leader>fg',
    [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], {silent = true})
map('n', '<leader>fG',
    [[<cmd>lua require('telescope.builtin').git_files()<cr>]], {silent = true})
map('n', '<leader>fc',
    [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], {silent = true})
map('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<cr>]],
    {silent = true})
map('n', '<leader>fm', [[<cmd>lua require('telescope.builtin').keymaps()<cr>]],
    {silent = true})
map('n', '<leader>fC', [[<cmd>lua require('telescope.builtin').commands()<cr>]],
    {silent = true})
map('n', '<c-p>', [[<cmd>lua require('telescope.builtin').find_files()<cr>]],
    {silent = true})
map('n', '<c-z>', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]],
    {silent = true})

require'telescope'.setup {
    defaults = {
        vimgrep_arguments = {
            'ag', '--nocolor', '--noheading', '--filename', '--number',
            '--column'
        }
    }
}

-- dispatch
map('n', '<leader>md', ':Dispatch<cr>')
map('n', '<leader>mm', ':Make<cr>')

-- Source a vimscript file from the base nvim-config directory
local function source(filename)
    local config_path = os.getenv("XDG_CONFIG_HOME")
    if config_path == nil then config_path = "~/.config" end
    vim.api.nvim_command('source ' .. config_path .. '/nvim/' .. filename)
end

source('tex.vim') -- ./tex.vim

vim.cmd [[autocmd FileType rust let b:dispatch = 'cargo run --color never']]
vim.cmd [[autocmd BufWritePre *.rs lua vim.lsp.buf.formatting()]]

vim.o.guifont = 'JetbrainsMono Nerd Font:h16'
