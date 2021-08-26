return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'

    -- LSP
    use {'neovim/nvim-lsp'}
    use {'neovim/nvim-lspconfig', requires = 'neovim/nvim-lsp'}

    -- LSP integration/extensions
    use {
        'hrsh7th/nvim-compe', -- Autocomplete
        requires = {{'hrsh7th/vim-vsnip'}}
    }
    use {'SirVer/ultisnips', requires = 'honza/vim-snippets'}
    use {
        'simrat39/rust-tools.nvim', -- Collection of rust tools
        requires = {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'},
        disable = true
    }
    use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}
    use 'folke/lua-dev.nvim'

    use {'ray-x/lsp_signature.nvim'} -- Show signature hints
    use {'nvim-lua/lsp_extensions.nvim'}
    use {'glepnir/lspsaga.nvim', opt = true, disable = true}
    use {
        'onsails/lspkind-nvim',
        config = function() require('lspkind').init() end,
        after = 'nvim-lspconfig',
        opt = true
    }

    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'romgrk/nvim-treesitter-context', opt = true, disable = false} -- Code context
    use 'nvim-treesitter/playground'
    use 'David-Kunz/treesitter-unit'
    use 'mfussenegger/nvim-ts-hint-textobject'
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        config = function()
            require'nvim-treesitter.configs'.setup {
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["it"] = "@block.outer"
                        }
                    }
                }
            }
        end
    }
    use { -- Spellchecking
        'lewis6991/spellsitter.nvim',
        config = function() require('spellsitter').setup() end,
        requires = 'nvim-treesitter/nvim-treesitter',
        opt = true,
        disable = true
    }

    -- Regex based highlighting (plugins)
    use {'tikhomirov/vim-glsl', ft = {'glsl'}}
    use {'plasticboy/vim-markdown', ft = {'markdown'}}
    use {'davidgranstrom/nvim-markdown-preview', ft = {'markdown'}}

    -- Cosmetic
    use {'ryanoasis/vim-devicons', after = 'default_theme'}
    use { -- Identation guides
        'lukas-reineke/indent-blankline.nvim',
        -- event = 'BufRead',
        after = 'default_theme',
        config = function()
            -- indent-blankline
            vim.api.nvim_set_var('indent_blankline_char', '┊')
            vim.api.nvim_set_var('indent_blankline_show_first_indent_level',
                                 false)
            vim.api.nvim_set_var('indent_blankline_show_end_of_line', true)
            vim.api.nvim_set_var(
                'indent_blankline_show_trailing_blankline_indent', false)

            vim.g.indentLine_enabled = 1
            vim.g.indent_blankline_filetype_exclude = {
                'help', 'terminal', 'dashboard'
            }
            vim.g.indent_blankline_buftype_exclude = {'terminal'}
        end
    }
    use { -- Status line
        'hoob3rt/lualine.nvim',
        -- after = 'default_theme',
        requires = {'kyazdani42/nvim-web-devicons'}
    }
    use { -- Utility to get the LSP status for the status line
        'nvim-lua/lsp-status.nvim',
        requires = 'lualine.nvim',
        config = function() require 'plugins/lualine' end
    }
    use { -- To-Do Highlights and query
        'folke/todo-comments.nvim',
        after = 'default_theme',
        config = function() require'todo-comments'.setup() end,
        opt = false
    }
    use {'yamatsum/nvim-cursorline', disable = true}
    -- Themes
    -- use {'offdroid/onevibrantdark.vim', branch = 'dev', opt = true}
    -- use {'liuchengxu/space-vim-theme', opt = true}
    use {
        'folke/tokyonight.nvim',
        as = 'default_theme',
        after = 'packer.nvim',
        config = function() require 'theme' end
    }
    -- use 'tiagovla/tokyodark.nvim'
    -- use {'marko-cerovac/material.nvim', opt = true}

    -- Navigation
    use {'nanotee/zoxide.vim'}
    use { -- Filebrowser
        'kyazdani42/nvim-tree.lua',
        cmd = {'NvimTreeToggle', 'NvimTreeClose', 'NvimTreeOpen'},
        requires = {'kyazdani42/nvim-web-devicons'},
        config = function() require 'plugins/nvim-tree' end
    }
    use { -- (File) search
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'}
    }
    use {
        'nvim-telescope/telescope-media-files.nvim',
        requires = 'nvim-telescope/telescope.nvim',
        config = function()
            require('telescope').load_extension('media_files')
        end
    }
    use { -- Helm like search
        'conweller/findr.vim',
        config = function()
            vim.api.nvim_set_var('findr_floating_window', 0)
        end
    }
    use {'gelguy/wilder.nvim', config = function() require 'plugins/wilder' end}
    use { -- Symbols overview and navigation
        'liuchengxu/vista.vim',
        requires = {'universal-ctags/ctags'},
        opt = true
    }
    use { -- Symbols overview and navigation based on LSP
        'simrat39/symbols-outline.nvim',
        config = function() require'symbols-outline'.setup() end
    }
    use { -- LSP dignaositcs overview and navigation
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require'trouble'.setup() end
    }
    use { -- Line peeking
        'nacro90/numb.nvim',
        config = function() require('numb').setup() end
    }
    use {
        'ggandor/lightspeed.nvim',
        config = function()
            require'lightspeed'.setup {
                jump_to_first_match = true,
                jump_on_partial_input_safety_timeout = 400,
                highlight_unique_chars = false,
                grey_out_search_area = true,
                match_only_the_start_of_same_char_seqs = true,
                limit_ft_matches = 5,
                full_inclusive_prefix_key = '<c-x>',
                labels = nil,
                cycle_group_fwd_key = nil,
                cycle_group_bwd_key = nil
            }
            -- Disable default behavior lightspeed-disable-default-mappings
            pcall(vim.api.nvim_del_keymap, 'n', 's')
            pcall(vim.api.nvim_del_keymap, 'n', 'S')
            pcall(vim.api.nvim_del_keymap, 'n', 'f')
            pcall(vim.api.nvim_del_keymap, 'n', 'F')
            pcall(vim.api.nvim_del_keymap, 'n', 't')
            pcall(vim.api.nvim_del_keymap, 'n', 'T')
        end
    }
    use {
        'andymass/vim-matchup',
        config = function()
            require'nvim-treesitter.configs'.setup {
                matchup = {enable = true, disable = {'rust'}}
            }
            vim.api.nvim_set_var('matchup_matchparen_deferred', 1)
            vim.api.nvim_set_var('matchup_matchparen_hi_surround_always', 1)
            vim.api.nvim_set_var('matchup_matchparen_deferred_show_delay', 200)
        end,
        event = 'CursorMoved',
        disable = true
    }
    use { -- Window resizing
        'simeji/winresizer'
    }
    use {
        'abecodes/tabout.nvim',
        config = function()
            require('tabout').setup {
                tabkey = '<tab>',
                backwards_tabkey = '<s-tab>',
                act_as_tab = true,
                act_as_shift_tab = false,
                enable_backwards = true,
                completion = true,
                tabouts = {
                    {open = "'", close = "'"}, {open = '"', close = '"'},
                    {open = '`', close = '`'}, {open = '(', close = ')'},
                    {open = '[', close = ']'}, {open = '{', close = '}'}
                },
                ignore_beginning = true,
                exclude = {}
            }
        end,
        opt = false,
        requires = {'nvim-treesitter', 'nvim-compe', 'ultisnips'}
    }

    -- Collaboration
    use {
        'jbyuki/instant.nvim',
        config = function() vim.g.instant_username = 'nice' end
        --[[ cmd = {
'InstantStartServer', 'InstantStartSingle', 'InstantJoinSingle',
'InstantStartSession', 'InstantJoinSession'
        } ]]
    }

    -- Debug
    -- use {'mfussenegger/nvim-dap', opt = true}
    -- use {
    -- 'rcarriga/nvim-dap-ui',
    -- opt = true,
    -- requires = {'mfussenegger/nvim-dap'},
    -- config = function() require('dapui').setup() end
    -- }

    -- Rust
    use {'rust-lang/rust.vim', ft = 'rust', opt = true, disable = true}
    use {
        'mhinz/vim-crates',
        config = function()
            vim.cmd [[autocmd BufRead Cargo.toml call crates#toggle()]]
        end
    }
    use {
        'akinsho/dependency-assist.nvim',
        config = function() require 'dependency_assist' end
    }
    -- Julia
    use 'JuliaEditorSupport/julia-vim'
    use {
        'ahmedkhalf/jupyter-nvim',
        run = ':UpdateRemotePlugins',
        ft = 'json',
        config = function() require('jupyter-nvim').setup {} end,
        disable = true
    }
    use {
        'michaelb/sniprun',
        run = 'bash ./install.sh',
        config = function()
            require'sniprun'.setup({
                selected_interpreters = {'Julia_jupyter', 'Python3_jupyter'},
                repl_enable = {},
                repl_disable = {},
                interpreter_options = {
                    Python3_original = {
                        intepreter = 'python3.9',
                        venv = {'/home/filip/Git/dass/dass-env'}
                    }
                },
                display = {
                    'Classic', 'VirtualTextOk', 'VirtualTextErr',
                    'TempFloatingWindow'
                    -- 'LongTempFloatingWindow', 'Terminal'
                }
            })
        end
    }

    -- TeX
    use {
        'lervag/vimtex',
        ft = {'tex', 'cls'},
        opt = true,
        config = function() require 'plugins/vimtex' end
    }
    use {'da-h/AirLatex.vim', opt = true, disable = true}

    -- Comments and surround
    use {
        'b3nj5m1n/kommentary',
        config = function()
            require('kommentary.config').use_extended_mappings()
        end
    }
    use {
        'blackCauldron7/surround.nvim',
        config = function()
            vim.g.surround_prefix = '<m-k>'
            require'surround'.setup {}
        end,
        keys = {{'n', 'ys'}, '<m-k>'}
    }

    -- SQL
    use {'tpope/vim-dadbod', ft = {'sql'}, opt = true, disable = true}
    use {
        'jsborjesson/vim-uppercase-sql',
        ft = {'sql'},
        opt = true,
        disable = true
    }
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require('gitsigns').setup() end
    }
    use 'kevinhwang91/nvim-bqf' -- Better quickfix windows

    -- Handlebars
    use {'mustache/vim-mustache-handlebars', ft = 'handlebars'}

    -- Misc
    use 'tpope/vim-fugitive' -- Git integration
    use {
        'folke/which-key.nvim',
        config = function()
            require'which-key'.setup {
                plugins = {spelling = {enabled = true, suggestions = 20}}
            }
        end,
        disable = true
    }
    use {
        'vhyrro/neorg',
        config = function()
            require('neorg').setup {
                -- Tell Neorg what modules to load
                load = {
                    ['core.defaults'] = {},
                    ['core.norg.concealer'] = {},
                    ['core.norg.dirman'] = {
                        config = {workspaces = {my_workspace = '~/neorg'}}
                    }
                }
            }
        end,
        requires = 'nvim-lua/plenary.nvim'
    } -- Kinda org-mode
    use {'metakirby5/codi.vim', opt = true, cmd = {'Codi'}} -- In-place REPL
    use {'hkupty/iron.nvim', opt = true, disable = true}
    use {
        'tpope/vim-dispatch',
        opt = true,
        cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
    } -- Async make
    use 'drzel/vim-gui-zoom' -- Dynamic zoom support for neovide
    use 'Jorengarenar/vim-MvVis'

    use {
        'jbyuki/nabla.nvim',
        keys = {{'n', '<F5>'}},
        config = function()
            vim.cmd [[nnoremap <F5> :lua require('nabla').action()<CR>]]
        end,
        disable = true
    }
    use {'kristijanhusak/vim-carbon-now-sh', cmd = {'CarbonNowSh'}, opt = true}

    use {
        'windwp/nvim-autopairs',
        config = function()
            local npairs = require 'nvim-autopairs'
            npairs.setup({
                disable_filetype = {'TelescopePrompt', 'vim'},
                check_ts = true
            })
            require('nvim-autopairs.completion.compe').setup({
                map_cr = true,
                map_complete = true
            })
            require('nvim-treesitter.configs').setup {
                autopairs = {enable = true}
            }
            local ts_conds = require('nvim-autopairs.ts-conds')
            local Rule = require('nvim-autopairs.rule')
            npairs.add_rules({
                Rule('%', '%', 'lua'):with_pair(
                    ts_conds.is_ts_node({'string', 'comment'})),
                Rule('$', '$', 'lua'):with_pair(
                    ts_conds.is_not_ts_node({'function'}))
            })
        end
    }
    use {
        'monaqa/dial.nvim',
        config = function()
            local dial = require 'dial'
            dial.augends['custom#boolean'] =
                dial.common.enum_cyclic {
                    name = 'boolean',
                    strlist = {'true', 'false'}
                }
            table.insert(dial.config.searchlist.normal, 'custom#boolean')
        end
    }
end)
