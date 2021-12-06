-- Taken from https://gist.github.com/mengwangk/a07a3d080ffdbc311bf055ad7edfa5d2#file-init-lua
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
local wk = require 'which-key'

wk.register {
    ['<leader>f'] = {
        name = '+telescope',
        f = {
            function() require'telescope.builtin'.find_files() end,
            'Find files',
            silent = true
        },
        g = {function() require'telescope.builtin'.live_grep() end, 'Live grep'},
        G = {function() require'telescope.builtin'.git_files() end, 'Git files'},
        c = {
            function() require'telescope.builtin'.git_commits() end,
            'Git commits'
        },
        C = {function() require'telescope.builtin'.commands() end, 'Commands'},
        m = {function() require'telescope.builtin'.keymaps() end, 'Keymaps'},
        b = {function() require'telescope.builtin'.buffers() end, 'Buffers'}
    },
    ['<c-p>'] = {
        function()
            require'telescope.builtin'.find_files({previewer = false})
        end, 'Find files'
    },
    ['<c-z>'] = {
        function() require'telescope.builtin'.oldfiles() end, 'Previous files'
    },
    ['<c-n>'] = {':NvimTreeToggle<cr>', 'Toggle NvimTree'},
    ['<leader>a'] = {
        name = '+windows',
        f = {':NvimTreeToggle<cr>', 'Toggle NvimTree'},
        d = {function() require'dapui'.toggle() end, 'Toggle Dap UI'}
    },
    ['<leader>m'] = {
        name = '+dispatch',
        d = {':Dispatch<cr>', 'Dispatch'},
        m = {':Make<cr>', 'Make'},
        r = {function() require'dap'.repl.open() end, 'Repl open (dap)'},
        l = {function() require'dap'.run_last() end, 'Run last (dap)'}
    },
    ['<F5>'] = {function() require'dap'.continue() end, 'Continue'},
    ['<F10>'] = {function() require'dap'.step_over() end, 'Step over'},
    ['<F11>'] = {function() require'dap'.step_into() end, 'Step into'},
    ['<F12>'] = {function() require'dap'.step_out() end, 'Step out'},
    ['<leader>b'] = {
        name = '+breakpoint',
        b = {
            function() require'dap'.toggle_breakpoint() end, 'Toggle breakpoint'
        },
        B = {
            function()
                require'dap'.set_breakpoint(vim.fn.input(
                                                'Breakpoint condition: '))
            end, 'Conditional breakpoint'
        },
        l = {
            function()
                require'dap'.set_breakpoint(nil, nil,
                                            vim.fn.input('Log point message: '))
            end, 'Log-point'
        }
    }
}

map('i', 'jk', '<esc>', {silent = true, noremap = true})
map('n', '<cr>', ':noh<cr>', {silent = true, noremap = true})
map('n', '<esc>', ':noh<cr>', {silent = true, noremap = true})

-- dial.nvim
vim.api.nvim_set_keymap('n', '<c-a>', '<Plug>(dial-increment)', {})
vim.api.nvim_set_keymap('n', '<c-x>', '<Plug>(dial-decrement)', {})
vim.api.nvim_set_keymap('v', '<c-a>', '<Plug>(dial-increment)', {})
vim.api.nvim_set_keymap('v', '<c-x>', '<Plug>(dial-decrement)', {})
vim.api.nvim_set_keymap('v', 'g<c-a>', '<Plug>(dial-increment-additional)', {})
vim.api.nvim_set_keymap('v', 'g<c-x>', '<Plug>(dial-decrement-additional)', {})

wk.register({['<leader>ll'] = {':VimtexCompile<cr>', 'Compile (vimtex)'}})

-- Winresizer
vim.api.nvim_set_var('winresizer_start_key', '<leader>r')
wk.register({["<leader>r"] = {'Resize window'}})

-- Treesitter Unit
map('v', 'x', ':lua require"treesitter-unit".select()<CR>')
map('o', 'x', ':<c-u>lua require"treesitter-unit".select()<CR>')

-- Tsht
map('o', 'm', ':<c-u>lua require"tsht".nodes()<cr>', {silent = true})
map('v', 'm', ':lua require"tsht".nodes()<cr>', {silent = false})

-- Lightspeed
vim.api.nvim_set_keymap('n', '<leader>s', "<Plug>Lightspeed_s", {})
vim.api.nvim_set_keymap('n', '<leader>S', "<Plug>Lightspeed_S", {})
--[[ vim.api.nvim_set_keymap('n', '<leader>f', "<Plug>Lightspeed_f", {})
vim.api.nvim_set_keymap('n', '<leader>F', "<Plug>Lightspeed_F", {})
vim.api.nvim_set_keymap('n', '<leader>t', "<Plug>Lightspeed_t", {})
vim.api.nvim_set_keymap('n', '<leader>T', "<Plug>Lightspeed_T", {}) ]]

-- Insert mode navigation
map('c', '<c-b>', '<left>')
map('c', '<c-n>', '<down>')
map('c', '<c-p>', '<up>')
map('c', '<c-f>', '<right>')

-- NeoVim Code Action Menu
map('n', 'gA', ':CodeActionMenu<cr>')
