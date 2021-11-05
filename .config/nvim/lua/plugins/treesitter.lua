require'nvim-treesitter.configs'.setup {
    ensure_installed = 'all',
    highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = {'org'}
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm'
        }
    },
    indent = {enable = true}
}

local parser_configs = require'nvim-treesitter.parsers'.get_parser_configs()
parser_configs.norg = {
    install_info = {
        url = 'https://github.com/vhyrro/tree-sitter-norg',
        files = {'src/parser.c', 'src/scanner.cc'},
        branch = 'main'
    }
}
parser_configs.org = {
    install_info = {
        url = 'https://github.com/milisims/tree-sitter-org',
        revision = 'main',
        files = {'src/parser.c', 'src/scanner.cc'}
    },
    filetype = 'org'
}
