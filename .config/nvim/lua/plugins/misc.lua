-- TODO: Collect setup helpers which are too small to put into their own modules
-- TODO: Add pcall to all requires
local M = {}

M.toggleterm = function()
    local exists, toggleterm = pcall(require, "toggleterm")
    if exists then
        toggleterm.setup({
            -- size can be a number or function which is passed the current terminal
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end, -- ]],
            open_mapping = [[<c-t>]],
            hide_numbers = true, -- hide the number column in toggleterm buffers
            shade_filetypes = {},
            shade_terminals = true,
            -- shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
            start_in_insert = true,
            insert_mappings = false, -- whether or not the open mapping applies in insert mode
            persist_size = true,
            direction = "float", -- | 'horizontal' | 'window' | 'float',
            close_on_exit = true, -- close the terminal window when the process exits
            shell = vim.o.shell, -- change the default shell
            -- This field is only relevant if direction is set to 'float'
            float_opts = {
                -- The border key is *almost* the same as 'nvim_open_win'
                -- see :h nvim_open_win for details on borders however
                -- the 'curved' border is a custom border type
                -- not natively supported but implemented in this plugin.
                border = "single",
                winblend = 3,
                highlights = { border = "Normal", background = "Normal" },
            },
        })
    end
end

M.trouble = function()
    local exists, trouble = pcall(require, "trouble")
    if exists then
        trouble.setup()
    end
end

M.todo_comments = function()
    local exists, todo = pcall(require, "todo-comments")
    if exists then
        todo.setup()
    end
end

M.stabilize = function()
    local exists, stabilize = pcall(require, "stabilize")
    if exists then
        stabilize.setup()
    end
end

M.bqf = function()
    local exists, bqf = pcall(require, "bqf")
    if exists then
        bqf.setup()
    end
end

M.rnvimr = function()
    -- vim.g.rnvimr_pick_enable = 1
    -- vim.g.rnvimr_enable_ex = 1
end

M.bufferline = function()
    require("bufferline").setup({})
end

M.gitsigns = function()
    require("gitsigns").setup()
end

M.fidget = function()
    require("fidget").setup({})
end

M.navigator = function()
    local exists, navigator = pcall(require, "navigator")
    if exists then
        navigator.setup({})
    end
end

M.autopairs = function()
    local exists, autopairs = pcall(require, "nvim-autopairs")
    if exists then
        autopairs.setup({})

        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
    end
end

M.dap_install = function()
    local exists, dap_install = pcall(require, "dap-install")
    if exists then
        dap_install.setup({
            installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
        })
        local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()
        for _, debugger in ipairs(dbg_list) do
            dap_install.config(debugger)
        end
    end
end

M.lsp_lines = function()
    local exists, lsp_lines = pcall(require, "lsp_lines")
    if exists then
        lsp_lines.register_lsp_virtual_lines()
        vim.diagnostic.config({
            virtual_lines = { prefix = "🔥" },
            virtual_text = false,
        })
    end
end

M.neogit = function()
    local exists, neogit = pcall(require, "neogit")
    if exists then
        neogit.setup({ integrations = { diffview = true } })
    end
end

M.diffview = function()
    local exists, diffview = pcall(require, "diffview")
    if exists then
        diffview.setup({})
    end
end

M.leap = function()
    local exists, leap = pcall(require, "leap")
    if exists then
        leap.setup({})
    end
end

M.tabout = function()
    local exists, tabout = pcall(require, "tabout")
    if exists then
        tabout.setup({})
    end
end

M.dressing = function()
    local exists, dressing = pcall(require, "dressing")
    if exists then
        dressing.setup({})
    end
end

M.notify = function()
    local exists, notify = pcall(require, "notify")
    if exists then
        -- notify.setup({})
        notify.setup({
            -- background_colour = "#000000",
            fps = 15,
            render = "minimal",
            stages = "static",
            timeout = 2500,
        })
        vim.notify = notify
    end
end

M.command_completion = function()
    local exists, completion = pcall(require, "command-completion")
    if exists then
        completion.setup({
            border = nil, -- What kind of border to use, passed through directly to `nvim_open_win()`,
            -- see `:help nvim_open_win()` for available options (e.g. 'single', 'double', etc.)
            max_col_num = 5, -- Maximum number of columns to display in the completion window
            min_col_width = 20, -- Minimum width of completion window columns
            use_matchfuzzy = true, -- Whether or not to use `matchfuzzy()` (see `:help matchfuzzy()`)
            -- to order completion results
            highlight_selection = true, -- Whether or not to highlight the currently
            -- selected item, not sure why this is an option tbh
            highlight_directories = true, -- Whether or not to higlight directories with
            -- the Directory highlight group (`:help hl-Directory`)
            tab_completion = true, -- Whether or not tab completion on displayed items is enabled
        })
    end
end

M.syntax_tree_surfer = function()
    vim.api.nvim_set_keymap(
        "n",
        "vd",
        '<cmd>lua require("syntax-tree-surfer").move("n", false)<cr>',
        { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
        "n",
        "vu",
        '<cmd>lua require("syntax-tree-surfer").move("n", true)<cr>',
        { noremap = true, silent = true }
    )
    -- .select() will show you what you will be swapping with .move(), you'll get used to .select() and .move() behavior quite soon!
    vim.api.nvim_set_keymap(
        "n",
        "vx",
        '<cmd>lua require("syntax-tree-surfer").select()<cr>',
        { noremap = true, silent = true }
    )
    -- .select_current_node() will select the current node at your cursor
    vim.api.nvim_set_keymap(
        "n",
        "vn",
        '<cmd>lua require("syntax-tree-surfer").select_current_node()<cr>',
        { noremap = true, silent = true }
    )

    -- NAVIGATION: Only change the keymap to your liking. I would not recommend changing anything about the .surf() parameters!
    vim.api.nvim_set_keymap(
        "x",
        "J",
        '<cmd>lua require("syntax-tree-surfer").surf("next", "visual")<cr>',
        { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
        "x",
        "K",
        '<cmd>lua require("syntax-tree-surfer").surf("prev", "visual")<cr>',
        { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
        "x",
        "H",
        '<cmd>lua require("syntax-tree-surfer").surf("parent", "visual")<cr>',
        { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
        "x",
        "L",
        '<cmd>lua require("syntax-tree-surfer").surf("child", "visual")<cr>',
        { noremap = true, silent = true }
    )

    -- SWAPPING WITH VISUAL SELECTION: Only change the keymap to your liking. Don't change the .surf() parameters!
    vim.api.nvim_set_keymap(
        "x",
        "<A-j>",
        '<cmd>lua require("syntax-tree-surfer").surf("next", "visual", true)<cr>',
        { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
        "x",
        "<A-k>",
        '<cmd>lua require("syntax-tree-surfer").surf("prev", "visual", true)<cr>',
        { noremap = true, silent = true }
    )
end

M.nvimtree = function()
    local exists, nvimtree = pcall(require, "nvim-tree")
    if exists then
        nvimtree.setup({
            hijack_netrw = false,
            renderer = {
                icons = {
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                    },
                    glyphs = {
                        -- default = "",
                        -- symlink = "",
                        -- bookmark = "",
                        -- folder = {
                        --     arrow_closed = "",
                        --     arrow_open = "",
                        --     default = "",
                        --     open = "",
                        --     empty = "",
                        --     empty_open = "",
                        --     symlink = "",
                        --     symlink_open = "",
                        -- },
                        git = {
                            unstaged = "✗",
                            staged = "✓",
                            -- unmerged = "",
                            -- renamed = "➜",
                            untracked = "○",
                            -- deleted = "",
                            -- ignored = "◌",
                        },
                    },
                },
            },
        })
    end
end

M.cybu = function()
    local exists, cybu = pcall(require, "cybu")
    if exists then
        cybu.setup()
    end
end

return M
