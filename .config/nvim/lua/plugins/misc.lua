-- Taken from https://gist.github.com/mengwangk/a07a3d080ffdbc311bf055ad7edfa5d2#file-init-lua
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

if vim.fn.exists('g:neovide') == 1 then
    vim.o.guifont =
        'FiraCode Nerd Font Mono,DejaVu Sans Mono,Noto Color Emoji,Monospace:h12'
    vim.g.neovide_refresh_rate = 144
    vim.g.neovide_cursor_animation_length = 0.02
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_transparency = 0.8
end

map('n', '<c-s-v>', '"*p')
map('c', '<c-s-v>', '<c-r>*')

map('n', '<c-+>', ':ZoomIn<cr>')
map('n', '<c-->', ':ZoomOut<cr>')

-- Source a vimscript file from the base nvim-config directory
local function source(filename)
    local config_path = os.getenv('XDG_CONFIG_HOME')
    if config_path == nil then config_path = '~/.config' end
    vim.api.nvim_command('source ' .. config_path .. '/nvim/' .. filename)
end

-- pandoc-preview
vim.api.nvim_set_var('pandoc_preview_pdf_cmd', 'zathura')
