local function bufnr()
    return "b" .. vim.fn.bufnr("%")
end

local M = {
    { "nvim-lua/plenary.nvim" },
    {
        "folke/which-key.nvim",
        opts = { plugins = { spelling = { enabled = true, suggestions = 40 } } },
        config = function(opts)
            require("which-key").setup(opts)
            require("mapping").general()
        end,
    }, -- { "folke/neoconf.nvim", cmd = "Neoconf" },
    "folke/neodev.nvim", --
    --
    { "kyazdani42/nvim-web-devicons", name = "icons" },

    { "jose-elias-alvarez/null-ls.nvim" }, --
    -- Themes
    -- "folke/tokyonight.nvim",
    "ofirgall/ofirkai.nvim",
    {
        "EdenEast/nightfox.nvim",
        config = true,
        opts = { options = { transparent = true } },
    }, --
    --
    {
        "williamboman/mason.nvim",
        config = true,
        dependencies = { { "williamboman/mason-lspconfig.nvim", config = true } },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufRead",
        config = function()
            require("plugins.treesitter").ts()
        end,
    },
    {
        "mfussenegger/nvim-ts-hint-textobject",
        config = function()
            require("mapping").treehopper()
        end,
        dependencies = { "folke/which-key.nvim" },
    },
    {
        "andymass/vim-matchup",
        config = function()
            require("plugins.treesitter").matchup()
        end,
        enabled = false,
    },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = { theme = "tokyonight" },
    },
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        enabled = true,
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        version = "^1.0.0", -- optional: only update when a new 1.x version is released
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        enabled = false,
        opts = {
            options = { -- Optional, recommended
                themable = true, -- Must
                separator_style = "slant",
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "center",
                    },
                },
                show_buffer_icons = true,
                numbers = "ordinal",
                max_name_length = 40,
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        config = true,
        opts = {
            options = {
                theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
            },
            extensions = { "fugitive", "quickfix" },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress", bufnr },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = { bufnr },
                lualine_z = {},
            },
        },
    }, -- LSP
    {
        "neovim/nvim-lspconfig",
        module = "lspconfig",
        config = function()
            require("plugins.lspconfig")
        end,
        dependencies = { "williamboman/mason.nvim" },
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function()
            require("plugins.signature")
        end,
    }, -- Autocomplete
    { "rafamadriz/friendly-snippets", event = "InsertEnter" },
    {
        "hrsh7th/nvim-cmp",
        -- as = "cmp",
        config = function()
            require("plugins.cmp")
        end,
        dependencies = {
            "friendly-snippets",
            {
                "L3MON4D3/LuaSnip",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
            { "kdheepak/cmp-latex-symbols" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lua" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            {
                "uga-rosa/cmp-dictionary",
                config = function()
                    require("cmp_dictionary").setup({
                        dic = {
                            ["*"] = { "/usr/share/dict/words" },
                            -- ["lua"] = "path/to/lua.dic",
                            -- ["javascript,typescript"] = { "path/to/js.dic", "path/to/js2.dic" },
                            -- filename = {
                            -- 	["xmake.lua"] = { "path/to/xmake.dic", "path/to/lua.dic" },
                            -- },
                            -- filepath = {
                            -- 	["%.tmux.*%.conf"] = "path/to/tmux.dic"
                            -- },
                            -- spelllang = {
                            -- 	en = "path/to/english.dic",
                            -- },
                        },
                        -- The following are default values.
                        exact = 2,
                        first_case_insensitive = false,
                        document = false,
                        document_command = "wn %s -over",
                        async = false,
                        capacity = 5,
                        debug = false,
                    })
                end,
            },
            { "lukas-reineke/cmp-under-comparator" },
            { "onsails/lspkind-nvim" },
        },
    },
    {
        "windwp/nvim-autopairs",
        -- dependencies = {"cmp"},
        event = "InsertEnter",
        config = function()
            require("plugins.misc").autopairs()
        end,
    },
    {
        "numToStr/Comment.nvim",
        module = "Comment",
        config = true, -- function() require("Comment").setup() end,
    }, -- Git
    { "tpope/vim-fugitive", command = "G" },
    {
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        event = "BufRead",
        config = function()
            require("plugins.misc").gitsigns()
        end,
    },
    {
        "ggandor/leap.nvim",
        event = "BufRead",
        config = function()
            require("plugins.misc").leap()
            require("mapping").leap()
        end,
    },
    {
        "ggandor/flit.nvim",
        config = {
            keys = { f = "f", F = "F", t = "t", T = "T" },
            -- A string like "nv", "nvo", "o", etc.
            labeled_modes = "v",
            multiline = true,
            -- Like `leap`s similar argument (call-specific overrides).
            -- E.g.: opts = { equivalence_classes = {} }
            opts = {},
        },
    },
    {
        "kevinhwang91/nvim-fundo",
        dependencies = "kevinhwang91/promise-async",
        config = function()
            require("fundo").install()
        end,
    },
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        config = function()
            require("plugins.misc").bqf()
        end,
    },
    { "jghauser/mkdir.nvim" },
    { "drzel/vim-gui-zoom", cmd = { "ZoomIn", "ZoomOut" } }, -- Diagnostics
    {
        "folke/trouble.nvim",
        -- requires = "icons",
        cmd = "TroubleToggle",
        config = function()
            require("plugins.misc").trouble()
        end,
    },
    {
        "folke/todo-comments.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        -- cmd = { "TodoTelescope", "TodoTrouble", "TodoLocList", "TodoQuickFix" },
        -- event = "BufRead",
        config = function()
            require("plugins.misc").todo_comments()
        end,
    },

    {
        "lervag/vimtex",
        ft = "tex",
        config = function()
            require("plugins.tex")
        end,
    },
    { "willothy/flatten.nvim", config = true },
    { "goerz/jupytext.vim" },
    {
        "JellyApple102/easyread.nvim",
        config = {
            hlValues = {
                ["1"] = 1,
                ["2"] = 1,
                ["3"] = 2,
                ["4"] = 2,
                ["fallback"] = 0.4,
            },
            hlgroupOptions = { link = "Bold" },
            fileTypes = { "text" },
            saccadeInterval = 0,
            saccadeReset = false,
            updateWhileInsert = true,
        },
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons", "folke/which-key.nvim" },
        config = function()
            require("nvim-tree").setup()
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        config = function()
            require("plugins.telescope")
            require("mapping").telescope()
        end,
        dependencies = { "nvim-lua/plenary.nvim", "folke/which-key.nvim" },
    },
    {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
            "neovim/nvim-lspconfig",
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim",
        },
    },
    {
        "chrisgrieser/nvim-spider",
        lazy = true,
        config = function()
            -- Keymaps
            vim.keymap.set({ "n", "o", "x" }, "w", function()
                require("spider").motion("w")
            end, { desc = "Spider-w" })
            vim.keymap.set({ "n", "o", "x" }, "e", function()
                require("spider").motion("e")
            end, { desc = "Spider-e" })
            vim.keymap.set({ "n", "o", "x" }, "b", function()
                require("spider").motion("b")
            end, { desc = "Spider-b" })
            vim.keymap.set({ "n", "o", "x" }, "ge", function()
                require("spider").motion("ge")
            end, { desc = "Spider-ge" })
        end,
    },
    { "mbbill/undotree", cmd = "UndotreeToggle", lazy = true }, --
    -- Ipython
    {
        "hkupty/iron.nvim",
        ft = "python",
        config = function()
            require("plugins.iron")
        end,
        enabled = false,
    }, -- { "kana/vim-textobj-line", ft = "python" },
    --
    { "kana/vim-textobj-user", ft = "python", enabled = false },
    { "GCBallesteros/vim-textobj-hydrogen", ft = "python", enabled = false },
    { "github/copilot.vim", ft = { "python", "tex" }, enabled = false },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        -- event = "InsertEnter",
        config = true,
        opts = { suggestion = { enabled = true, auto_trigger = true } },
    }, -- TODO: Replace with final plugin
    { "kaarmu/typst.vim", ft = "typst", lazy = false },
    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        enabled = false,
        opts = {},
    },
    {
        dir = "/home/filip/Git/nvim-pylance/",
        dependencies = "nvim-lspconfig",
        enabled = false,
    },
    { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
}
return M
