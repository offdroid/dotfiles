return require'packer'.startup(function(use)
    use 'wbthomason/packer.nvim'
    -- use 'lewis6991/impatient.nvim' -- Performance improvements
    use 'nvim-lua/plenary.nvim'

    -- LSP
    use {'neovim/nvim-lsp'}
    use {'neovim/nvim-lspconfig', requires = 'neovim/nvim-lsp'}

    -- LSP integration/extensions
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-vsnip', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-calc', 'hrsh7th/cmp-path', 'hrsh7th/vim-vsnip',
            'ray-x/cmp-treesitter', '/home/filip/Git/cmp-pandoc-references'
        },
        disable = false
    }
    use {
        'tzachar/cmp-tabnine',
        run = './install.sh',
        requires = 'hrsh7th/nvim-cmp',
        disable = true
    }
    use {'SirVer/ultisnips', requires = 'honza/vim-snippets'}
    use {'rrethy/vim-illuminate'}
    use {
        'simrat39/rust-tools.nvim', -- Collection of rust tools
        requires = {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'},
        disable = false
    }
    use {'brymer-meneses/grammar-guard.nvim', requires = 'nvim-lspconfig'}
    use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}
    use {'folke/lua-dev.nvim'}
    use {'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu'}
    use {'RishabhRD/nvim-lsputils', requires = {'RishabhRD/popfix'}}
    use {'ray-x/lsp_signature.nvim'} -- Show signature hints
    use {'nvim-lua/lsp_extensions.nvim'}
    use {'glepnir/lspsaga.nvim', opt = true, disable = true}
    use {
        'onsails/lspkind-nvim',
        config = function() require'lspkind'.init() end
    }

    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'romgrk/nvim-treesitter-context', opt = true} -- Code context
    use {'nvim-treesitter/playground', cmd = {'TSPlaygroundToggle'}}
    use {'David-Kunz/treesitter-unit'}
    use {'mfussenegger/nvim-ts-hint-textobject'}
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        config = function()
            require'nvim-treesitter.configs'.setup {
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                            ['it'] = '@block.outer'
                        }
                    }
                }
            }
        end,
        after = 'nvim-treesitter'
    }

    -- Regex based highlighting (plugins)
    use {'tikhomirov/vim-glsl', ft = {'glsl'}}
    use {'plasticboy/vim-markdown', ft = {'markdown'}}
    use {'davidgranstrom/nvim-markdown-preview', ft = {'markdown'}}
    use {'rhysd/vim-llvm', ft = {'llvm'}}

    -- Cosmetic
    use {'ryanoasis/vim-devicons', after = 'tokyonight.nvim'}
    use { -- Identation guides
        'lukas-reineke/indent-blankline.nvim',
        -- event = 'BufRead',
        after = 'tokyonight.nvim',
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

            vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
            require("indent_blankline").setup {
                space_char_blankline = " ",
                char_highlight_list = {
                    "IndentBlanklineIndent1", "IndentBlanklineIndent2",
                    "IndentBlanklineIndent3", "IndentBlanklineIndent4",
                    "IndentBlanklineIndent5", "IndentBlanklineIndent6"
                }
            }
        end
    }
    use { -- Status line
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', 'tokyonight.nvim'}
        -- Run setup after loading other statusline dependencies
    }
    use { -- Utility to get the LSP status for the status line
        'nvim-lua/lsp-status.nvim',
        after = 'tokyonight.nvim',
        requires = 'lualine.nvim',
        config = function()
            -- Maybe move over to init.lua
            require 'theme'
            require 'plugins/lualine'
        end
    }
    use { -- To-Do Highlights and query
        'folke/todo-comments.nvim',
        after = 'tokyonight.nvim',
        config = function() require'todo-comments'.setup() end,
        opt = false
    }
    use {'jeffkreeftmeijer/vim-numbertoggle'}
    -- Themes
    use {'folke/tokyonight.nvim', after = 'packer.nvim'}
    use {'RRethy/nvim-base16'}

    -- Navigation
    use {'nanotee/zoxide.vim'}
    use { -- Filebrowser
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require 'plugins/nvim-tree' end
    }
    use { -- (File) search
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/plenary.nvim'}
    }
    use {
        'nvim-telescope/telescope-media-files.nvim',
        requires = 'nvim-telescope/telescope.nvim',
        config = function()
            require'telescope'.load_extension('media_files')
        end
    }
    use { -- Helm like search
        'conweller/findr.vim',
        config = function()
            vim.api.nvim_set_var('findr_floating_window', 0)
        end
    }
    use {'kevinhwang91/rnvimr', cmd = {'RnvimrToggle'}}
    use {'gelguy/wilder.nvim', config = function() require 'plugins/wilder' end}
    use { -- ctags
        'universal-ctags/ctags'
    }
    use { -- Symbols overview and navigation.
        'liuchengxu/vista.vim',
        requires = {'universal-ctags/ctags'},
        disable = true
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
                x_mode_prefix_key = '<c-x>',
                substitute_chars = {['\r'] = '¬'},
                instant_repeat_fwd_key = nil,
                instant_repeat_bwd_key = nil,
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
        end,
        -- After surround.nvim to ensure that keybinds are set properly
        after = 'surround.nvim',
        disable = false
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
        'beauwilliams/focus.nvim',
        config = function() require'focus'.setup() end,
        cmd = {'FocusEnable', 'FocusToggle', 'FocusSplitNicely'}
    }
    use {
        'abecodes/tabout.nvim',
        config = function()
            require'tabout'.setup {
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
        requires = {'nvim-treesitter', 'nvim-cmp', 'ultisnips'}
    }

    -- Collaboration
    use {
        'jbyuki/instant.nvim',
        config = function() vim.g.instant_username = 'offdroid' end
    }

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
    -- json
    use {'gennaro-tedesco/nvim-jqx', ft = 'json'}

    -- Comments and surround
    use {
        'b3nj5m1n/kommentary',
        config = function()
            require'kommentary.config'.use_extended_mappings()
        end
    }
    use {
        'blackCauldron7/surround.nvim',
        config = function()
            require'surround'.setup {mappings_style = 'surround'}
        end
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
        requires = 'nvim-lua/plenary.nvim',
        config = function() require'gitsigns'.setup() end
    }
    use 'kevinhwang91/nvim-bqf' -- Better quickfix windows

    -- Handlebars
    use {'mustache/vim-mustache-handlebars', ft = 'handlebars'}

    -- Misc
    use {'tpope/vim-fugitive'} -- Git integration
    use {
        'tanvirtin/vgit.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require('vgit').setup() end,
        disable = true
    }
    use {
        'folke/which-key.nvim',
        config = function()
            require'which-key'.setup {
                plugins = {spelling = {enabled = true, suggestions = 20}}
            }
        end
    }
    use {'famiu/bufdelete.nvim'}
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
            require'nvim-treesitter.configs'.setup {autopairs = {enable = true}}
            local ts_conds = require 'nvim-autopairs.ts-conds'
            local Rule = require 'nvim-autopairs.rule'
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

    -- Leetcode integration
    use {
        'ianding1/leetcode.vim',
        -- cmd = {'LeetCodeList', 'LeetCodeSignIn'},
        config = function()
            vim.g.leetcode_browser = 'chrome'
            vim.g.leetcode_solution_filetype = 'rust'
        end,
        disable = true
    }

    -- Org mode (like)
    use {
        'vhyrro/neorg',
        config = function()
            require'neorg'.setup {
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
    }
    use {
        'kristijanhusak/orgmode.nvim',
        branch = 'tree-sitter',
        config = function()
            require('orgmode').setup {}
            vim.cmd [[autocmd FileType org setlocal nofoldenable]]
        end,
        disable = false
    }
    use {
        "akinsho/org-bullets.nvim",
        config = function() require('org-bullets').setup {} end,
        disable = false
    }
    use {
        'lukas-reineke/headlines.nvim',
        config = function()
            vim.cmd [[highlight Headline1 guibg=#1e2718]]
            vim.cmd [[highlight Headline2 guibg=#21262d]]
            vim.cmd [[highlight Headline3 guibg=#3e2e1e]]
            vim.cmd [[highlight CodeBlock guibg=#1c1c1c]]
            -- vim.cmd [[highlight Dash guibg=#D19A66 gui=bold]]
            vim.fn.sign_define('Headline1', {linehl = 'Headline1'})
            vim.fn.sign_define('Headline2', {linehl = 'Headline2'})
            vim.fn.sign_define('Headline3', {linehl = 'Headline3'})
            require('headlines').setup {
                org = {headline_signs = {"Headline1", "Headline2", "Headline3"}}
            }
        end,
        after = 'orgmode.nvim',
        disable = false
    }
end)
