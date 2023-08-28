local M = {}

M.ts = function()
    local exists, configs = pcall(require, "nvim-treesitter.configs")
    if exists then
        configs.setup({
            ensure_installed = "all",
            sync_install = false,
            highlight = {
                enable = true,
                disable = { "latex" },
                additional_vim_regex_highlighting = false,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
            indent = {
                enable = true,
                disable = { "python" },
            },
            playground = {
                enable = true,
                disable = {},
                updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                persist_queries = false, -- Whether the query persists across vim sessions
                keybindings = {
                    toggle_query_editor = "o",
                    toggle_hl_groups = "i",
                    toggle_injected_languages = "t",
                    toggle_anonymous_nodes = "a",
                    toggle_language_display = "I",
                    focus_language = "f",
                    unfocus_language = "F",
                    update = "R",
                    goto_node = "<cr>",
                    show_help = "?",
                },
            },
        })
    end
end

M.rainbow = function()
    local exists, configs = pcall(require, "nvim-treesitter.configs")
    if exists then
        configs.setup({
            rainbow = {
                enable = false,
                -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                extended_mode = true, -- also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                max_file_lines = nil, -- do not enable for files with more than n lines, int
                -- colors = {}, -- table of hex strings
                -- termcolors = {} -- table of colour name strings
            },
        })
    end
end

M.matchup = function()
    local exists, configs = pcall(require, "nvim-treesitter.configs")
    if exists then
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
        configs.setup({
            matchup = {
                enable = true,
                -- disable = {},
            },
        })
    end
    -- vim.cmd([[
    -- augroup matchup_disable_ft
    -- autocmd!
    -- autocmd FileType TelescopePreviewerLoaded let [b:matchup_matchparen_enabled = 0]
    -- augroup END
    -- ]])
end

M.textsubjects = function()
    local exists, configs = pcall(require, "nvim-treesitter.configs")
    if exists then
        configs.setup({
            textsubjects = {
                enable = true,
                -- prev_selection = ",", -- (Optional) keymap to select the previous selection
                keymaps = {
                    ["."] = "textsubjects-smart",
                    [";"] = "textsubjects-container-outer",
                    ["i;"] = "textsubjects-container-inner",
                },
            },
        })
    end
end

M.context = function()
    local exists, context = pcall(require, "treesitter-context")
    if exists then
        context.setup({
            enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
            throttle = true, -- Throttles plugin updates (may improve performance)
            max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
            patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
                -- For all filetypes
                -- Note that setting an entry here replaces all other patterns for this entry.
                -- By setting the 'default' entry below, you can control which nodes you want to
                -- appear in the context window.
                default = {
                    "class",
                    "function",
                    "method",
                    -- 'for', -- These won't appear in the context
                    -- 'while',
                    -- 'if',
                    -- 'switch',
                    -- 'case',
                },
                -- Example for a specific filetype.
                -- If a pattern is missing, *open a PR* so everyone can benefit.
                --   rust = {
                --       'impl_item',
                --   },
            },
            exact_patterns = {
                -- Example for a specific filetype with Lua patterns
                -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
                -- exactly match "impl_item" only)
                -- rust = true,
            },
        })
        -- TODO: Uncomment highlight?
        -- vim.cmd("hi TreesitterContext gui=italic guibg=black")
    end
end

M.textobjects = function()
    local exists, configs = pcall(require, "nvim-treesitter.configs")
    if exists then
        configs.setup({
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = "@class.outer",
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                },
            },
        })
    end
end

return M
