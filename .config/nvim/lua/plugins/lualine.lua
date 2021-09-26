-- Setup LSP server statusline indicator with custom icon
local status = require 'lsp-status'
status.config {status_symbol = ' 力'}

-- Temporary fix for https://github.com/projekt0n/github-nvim-theme/issues/83
local gh_theme = require('lualine.themes.github')
local gh_colors = require('github-theme.colors').setup()
gh_theme.inactive.a.fg = gh_colors.white
gh_theme.inactive.b.fg = gh_colors.white
gh_theme.inactive.c.fg = gh_colors.white
require'lualine'.setup {
    options = {
        theme = 'github',
        -- theme = 'material-nvim',
        -- theme = 'tokyonight',
        extensions = {'nvim-tree', 'fugitive'},
        section_separators = {'', ''},
        component_separators = {'', ''}
    },
    sections = {
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
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {'filename'},
        lualine_c = {'filetype'},
        lualine_x = {'location'}
    }
}
