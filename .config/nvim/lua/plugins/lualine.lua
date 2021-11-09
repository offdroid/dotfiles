-- Setup LSP server statusline indicator with custom icon
local status = require 'lsp-status'
status.config {status_symbol = ' 力'}

-- local mytheme = require('lualine.themes.auto')
require'lualine'.setup {
    options = {
        theme = 'tokyonight',
        -- theme = mytheme,
        extensions = {'nvim-tree', 'fugitive'},
        section_separators = {left = '', right = ''},
        component_separators = {left = '', right = ''}
    },
    --[[ sections = {
        lualine_a = {
            'mode', {
                'diagnostics',
                -- table of diagnostic sources, available sources:
                sources = {'nvim_lsp'},
                color_error = '#ffffff',
                color_warn = '#ffffff',
                color_info = '#ffffff',
                color_hint = '#ffffff'
            }
        },
        lualine_c = {'filename', {status.status}}
    }, ]]
    inactive_sections = {
        lualine_a = {},
        lualine_b = {'filename'},
        lualine_c = {'filetype'},
        lualine_x = {'location'}
    }
}
