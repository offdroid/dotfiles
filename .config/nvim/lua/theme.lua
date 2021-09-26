vim.cmd([[
    syntax on
    filetype on
    filetype plugin indent on
]])
if vim.fn.has('termguicolors') then vim.o.termguicolors = true end

vim.g.tokyonight_style = 'night'
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = {'quickfix', '__vista__', 'terminal'}

vim.g.material_style = 'darker' -- deep ocean
-- vim.cmd [[colorscheme material]]
-- vim.cmd [[colorscheme tokyonight]]

require'github-theme'.setup{
    theme_style = 'dark',
    function_style = 'italic',
    sidebars = {'terminal', 'packer', 'quickfix'},
}
