vim.api.nvim_set_var('nvim_tree_icons', {
    default = '',
    symlink = '',
    git = {
        unstaged = '✗',
        staged = '✓',
        unmerged = '',
        renamed = '➜',
        untracked = '',
        deleted = '',
        ignored = ''
    },
    folder = {
        arrow_open = '',
        arrow_closed = '',
        default = '',
        open = '',
        empty = '',
        empty_open = '',
        symlink = '',
        symlink_open = ''
    },
    lsp = {hint = '', info = '', warning = '', error = ''}
})
require'nvim-tree'.setup {update_cwd = true}
