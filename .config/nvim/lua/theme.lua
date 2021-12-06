vim.cmd([[
    syntax on
    filetype on
    filetype plugin indent on
]])
if vim.fn.has('termguicolors') then vim.o.termguicolors = true end

vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_italic_variables = true
vim.g.tokyonight_dark_float = true
vim.g.tokyonight_sidebars = {'quickfix', '__vista__', 'terminal'}

if vim.fn.has('unix') and not vim.fn.exists('g:neovide') == 1 then
    local i3_processes = io.popen('pgrep -c -x i3'):read('*n')

    vim.g.tokyonight_transparent = i3_processes >= 1
    vim.g.tokyonight_transparent_sidebar = i3_processes >= 1
    vim.opt.cursorline = i3_processes >= 1
else
    local day_night_active = false
    vim.g.tokyonight_transparent = false
    vim.g.tokyonight_transparent_sidebar = false

    local hour = os.date('*t').hour
    if 6 <= hour and hour <= 16 and day_night_active then
        vim.g.tokyonight_day_brightness = 0.4
        vim.g.tokyonight_style = 'day'
    else
        vim.g.tokyonight_style = 'night'
    end
end
vim.g.tokyonight_lualine_bold = true
vim.g.tokyonight_hide_inactive_statusline = false

vim.cmd [[colorscheme tokyonight]]

vim.cmd(
    'highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080')
vim.cmd('highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6')
vim.cmd('highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6')
vim.cmd('highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE')
vim.cmd('highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE')
vim.cmd('highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE')
vim.cmd('highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0')
vim.cmd('highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0')
vim.cmd('highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4')
