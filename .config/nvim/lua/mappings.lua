-- Taken from https://gist.github.com/mengwangk/a07a3d080ffdbc311bf055ad7edfa5d2#file-init-lua
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- jk-escape
vim.api.nvim_set_keymap('i', 'jk', '<esc>', {})

-- Vista
map('n', '<leader>av', ':Vista!!<cr>', {silent = true})

-- NVIM-tree
map('n', '<leader>af', ':NvimTreeToggle<cr>')
map('n', '<c-n>', ':NvimTreeToggle<cr>')

-- Telescope
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

-- Ultisnips
vim.api
    .nvim_set_var('UltiSnipsSnippetDirectories', {'UltiSnips', 'my_snippets'})
vim.api.nvim_set_var('UltiSnipsExpandTrigger', '<c-s>')
vim.api.nvim_set_var('UltiSnipsJumpForwardTrigger', '<c-b>')
vim.api.nvim_set_var('UltiSnipsJumpBackwardTrigger', '<c-z>')

-- Dispatch
map('n', '<leader>md', ':Dispatch<cr>')
map('n', '<leader>mm', ':Make<cr>')

-- Findr
map('n', '<c-c><c-f>', ':Findr<cr>')

-- dial.nvim
vim.api.nvim_set_keymap('n', '<c-a>', '<Plug>(dial-increment)', {})
vim.api.nvim_set_keymap('n', '<c-x>', '<Plug>(dial-decrement)', {})
vim.api.nvim_set_keymap('v', '<c-a>', '<Plug>(dial-increment)', {})
vim.api.nvim_set_keymap('v', '<c-x>', '<Plug>(dial-decrement)', {})
vim.api.nvim_set_keymap('v', 'g<c-a>', '<Plug>(dial-increment-additional)', {})
vim.api.nvim_set_keymap('v', 'g<c-x>', '<Plug>(dial-decrement-additional)', {})

-- Clear search with enter or esc
map('n', '<cr>', ':noh<cr>', {silent = true})
map('n', '<esc>', ':noh<cr>', {silent = true})

-- VimTex
map('n', '<leader>ll', ':VimtexCompile<cr>')

-- Winresizer
vim.api.nvim_set_var('winresizer_start_key', '<leader>r')

-- Sniprun
vim.api.nvim_set_keymap('n', '<leader>fr', ':%SnipRun<cr>', {silent = true})
vim.api.nvim_set_keymap('v', '<leader>f', '<Plug>SnipRun', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>f', '<Plug>SnipRunOperator',
                        {silent = true})
vim.api.nvim_set_keymap('n', '<leader>ff', '<Plug>SnipRun', {silent = true})

-- Treesitter Unit
map('v', 'x', ':lua require"treesitter-unit".select()<CR>')
map('o', 'x', ':<c-u>lua require"treesitter-unit".select()<CR>')

-- Tsht
map('o', 'm', ':<c-u>lua require"tsht".nodes()<cr>', {silent = true})
map('v', 'm', ':lua require"tsht".nodes()<cr>', {silent = false})

-- Lightspeed
vim.api.nvim_set_keymap('n', '<leader>s', "<Plug>Lightspeed_s", {})
vim.api.nvim_set_keymap('n', '<leader>S', "<Plug>Lightspeed_S", {})
vim.api.nvim_set_keymap('n', '<leader>f', "<Plug>Lightspeed_f", {})
vim.api.nvim_set_keymap('n', '<leader>F', "<Plug>Lightspeed_F", {})
vim.api.nvim_set_keymap('n', '<leader>t', "<Plug>Lightspeed_t", {})
vim.api.nvim_set_keymap('n', '<leader>T', "<Plug>Lightspeed_T", {})

-- Navigate to nvim config
vim.api.nvim_exec([[
function! Config()
  execute 'cd ~/.config/nvim/lua'
  lua require('telescope.builtin').find_files({search_dirs = {'~/.config/nvim/lua'}})
endfunction

command! -nargs=0 Config call Config()
]], false)

-- vim-illuminate
vim.api.nvim_set_keymap('n', '<a-n>',
                        '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>',
                        {noremap = true})
vim.api.nvim_set_keymap('n', '<a-p>',
                        '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
                        {noremap = true})

-- Insert mode navigation
map('i', '<c-b>', '<left>')
map('i', '<c-n>', '<down>')
map('i', '<c-p>', '<up>')
map('i', '<c-f>', '<right>')
map('c', '<c-b>', '<left>')
map('c', '<c-n>', '<down>')
map('c', '<c-p>', '<up>')
map('c', '<c-f>', '<right>')

-- NeoVim Code Action Menu
map('n', 'gA', ':CodeActionMenu<cr>')
