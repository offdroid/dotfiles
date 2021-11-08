vim.cmd([[
    syntax off
    filetype off
    filetype plugin indent off
]])

vim.opt.title = true
vim.opt.hidden = true

-- Show line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
-- Indicate current line
vim.opt.cursorline = true
-- Mouse support in all modes
vim.opt.mouse = 'a'
-- Indentation
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- Treesitter based folding
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- Combine system clipboard and the unnamed register
vim.opt.clipboard = 'unnamed,unnamedplus'

vim.opt.fileformat = 'unix'
vim.opt.shellslash = true

vim.opt.ignorecase = true
-- Incremental search
vim.opt.incsearch = true
vim.opt.inccommand = 'split'
vim.opt.completeopt = 'menu,noselect'

vim.opt.updatetime = 250

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.api.nvim_exec('set fillchars+=diff:╱', false)
-- Set leader
vim.cmd 'nnoremap <SPACE> <Nop>'
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Persistent undo
if vim.fn.has('persistent_undo') == 1 then
    local target_path = vim.fn.expand('~/.vim/undo')
    if not vim.fn.isdirectory(target_path) then
        os.execute('mkdir -p ' .. target_path)
    end
    if vim.fn.isdirectory(target_path) then
        vim.o.undodir = target_path
        vim.o.undofile = true
    end
end
