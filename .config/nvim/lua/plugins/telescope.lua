require'telescope'.setup {
    defaults = {
        mappings = {i = {['<esc>'] = require'telescope.actions'.close}},
        vimgrep_arguments = {
            'ag', '--nocolor', '--noheading', '--filename', '--number',
            '--column'
        }
    }
}
