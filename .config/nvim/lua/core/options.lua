vim.opt.title = true
vim.opt.hidden = true

vim.opt.background = "dark"

-- Show line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
-- Indicate current line
vim.opt.cursorline = true
-- Mouse support in all modes
vim.opt.mouse = "a"
-- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- Treesitter based folding
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- Combine system clipboard and the unnamed register
vim.opt.clipboard = "unnamed,unnamedplus"

vim.opt.fileformat = "unix"

vim.opt.ignorecase = true
-- Incremental search
vim.opt.incsearch = true
vim.opt.inccommand = "split"
-- vim.opt.completeopt = "menu,noselect"
vim.opt.completeopt = "menuone,noinsert,noselect"

vim.opt.updatetime = 250

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 4

vim.opt.laststatus = 3
vim.opt.winbar = "%f%m b%n"
vim.opt.laststatus = 3

vim.api.nvim_exec("set fillchars+=diff:╱", false)
-- Set leader
vim.cmd("nnoremap <space> <nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Persistent undo
if vim.fn.has("persistent_undo") == 1 then
    local target_path = vim.fn.expand("~/.vim/undo")
    if not vim.fn.isdirectory(target_path) then
        os.execute("mkdir -p " .. target_path)
    end
    if vim.fn.isdirectory(target_path) then
        vim.o.undodir = target_path
        vim.o.undofile = true
    end
end

local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    -- "netrw",
    -- "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "matchparen",
    "tar",
    "tarPlugin",
    "tutor_mode_plugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
    "fzf",
}
for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

if vim.fn.has("termguicolors") then
    vim.o.termguicolors = true
end
