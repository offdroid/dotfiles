return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- LSP
    use {'neovim/nvim-lsp'}
    use {'neovim/nvim-lspconfig'}

    -- LSP integration/extensions
    use {
        'hrsh7th/nvim-compe', -- Autocomplete plugin
        requires = {{'hrsh7th/vim-vsnip'}}
    }
    use {'SirVer/ultisnips', requires = {{'honza/vim-snippets'}}}
    use {
        'simrat39/rust-tools.nvim', -- Collection of rust tools
        requires = {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'}
    }
    use {'ray-x/lsp_signature.nvim'} -- Show signature hints
    -- use {'nvim-lua/lsp_extensions.nvim'}
    use 'glepnir/lspsaga.nvim'

    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'romgrk/nvim-treesitter-context'
    use {
        'lewis6991/spellsitter.nvim',
        config = function() require('spellsitter').setup() end
    }

    -- Regex based highlighting plugins
    use {'tikhomirov/vim-glsl', ft = {'glsl'}}
    use {'plasticboy/vim-markdown', ft = {'markdown'}}

    -- Themes
    use {'offdroid/onevibrantdark.vim', branch = 'dev'}
    use {'liuchengxu/space-vim-theme'}

    -- Cosmentic
    use {'ryanoasis/vim-devicons'}
    use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use {
        'folke/lsp-trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require'trouble'.setup() end
    }
    -- use {
    -- 'folke/lsp-colors.nvim',
    -- config = function() require'lsp-colors'.setup() end
    -- }
    use 'folke/tokyonight.nvim'

    -- Navigation
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'}
    }
    use {'nvim-telescope/telescope.nvim'}
    use {'liuchengxu/vista.vim', requires = {'universal-ctags/ctags'}}
    use {'nacro90/numb.nvim', config = function() require('numb').setup() end} -- Peek at the line being entered

    -- Rust
    use 'rust-lang/rust.vim'

    -- TeX
    use {'lervag/vimtex', ft = {'tex', 'cls'}, opt = true}
    use 'da-h/AirLatex.vim'

    -- Comments
    use {'preservim/nerdcommenter'}

    -- SQL
    use {'tpope/vim-dadbod', ft = {'sql'}, opt = true}
    use {'jsborjesson/vim-uppercase-sql', ft = {'sql'}, opt = true}
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require('gitsigns').setup() end
    }
    use {'kevinhwang91/nvim-bqf'} -- Better quickfix windows

    -- Misc
    use 'tpope/vim-fugitive'
    use {'dhruvasagar/vim-dotoo'} -- Kinda org-mode
    use {'metakirby5/codi.vim', opt = true, cmd = {'Codi'}} -- In-place REPL
    use {
        'tpope/vim-dispatch',
        opt = true,
        cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
    }
end)
