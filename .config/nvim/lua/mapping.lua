M = {}

local exists, wk = pcall(require, "which-key")
if not exists then
    error("Which-key is missing in setup!")
end

M.general = function()
    wk.register({
        ["<leader>a"] = {
            name = "+windows",
            f = { ":NvimTreeToggle<cr>", "Toggle NvimTree" },
            t = { ":TroubleToggle<cr>", "Toggle Trouble" },
            u = { ":UndotreeToggle<cr>", "Toggle Undotree" },
            T = { ":TodoTrouble<cr>", "TODO Trouble" },
            v = { ":ToggleTerm direction=vertical<cr>", "Vertical term" },
            h = { ":ToggleTerm direction=horizontal<cr>", "Horizontal term" },
            d = {
                function()
                    require("dapui").toggle()
                end,
                "Toggle Dap UI",
            },
            c = {
                function()
                    require("notify").dismiss({ pending = true, silent = true })
                end,
                "Dismiss notifications",
            },
        },
        ["<c-+>"] = { ":ZoomIn<cr>", "Zoom in (GUI)" },
        ["<c-->"] = { ":ZoomOut<cr>", "Zoom out (GUI)" },
    })
end

M.telescope = function()
    local opts = require("telescope.themes").get_ivy({})
    wk.register({
        ["<leader>f"] = {
            name = "+telescope",
            f = {
                function()
                    require("telescope.builtin").find_files(opts)
                end,
                "Find files",
                silent = true,
            },
            F = {
                function()
                    require("telescope.builtin").current_buffer_fuzzy_find(opts)
                end,
                "Fuzzy in cur. buf",
                silent = true,
            },
            t = {
                function()
                    require("telescope.builtin").tags(opts)
                end,
                "Tags",
                silent = true,
            },
            T = {
                function()
                    require("telescope.builtin").current_buffer_tags(opts)
                end,
                "Tags in cur. buf",
                silent = true,
            },
            g = {
                function()
                    require("telescope.builtin").live_grep(opts)
                end,
                "Live grep",
            },
            ["<space>"] = {
                function()
                    require("telescope.builtin").resume(opts)
                end,
                "Resume last",
            },
            G = {
                function()
                    require("telescope.builtin").git_files(opts)
                end,
                "Git files",
            },
            c = {
                function()
                    require("telescope.builtin").git_commits(opts)
                end,
                "Git commits",
            },
            C = {
                function()
                    require("telescope.builtin").commands(opts)
                end,
                "Commands",
            },
            m = {
                function()
                    require("telescope.builtin").keymaps(opts)
                end,
                "Keymaps",
            },
            b = {
                function()
                    require("telescope.builtin").buffers(opts)
                end,
                "Buffers",
            },
            M = {
                function()
                    require("telescope.builtin").marks(opts)
                end,
                "Marks",
            },
            d = {
                function()
                    require("telescope.builtin").lsp_dynamic_workspace_symbols(opts)
                end,
                "Dynamic workspace symbols",
            },
            w = {
                function()
                    require("telescope.builtin").lsp_workspace_symbols(opts)
                end,
                "Workspace symbols",
            },
            e = {
                function()
                    require("telescope.builtin").lsp_document_symbols(opts)
                end,
                "Document symbols",
            },
            r = {
                function()
                    require("telescope.builtin").lsp_references(opts)
                end,
                "References",
            },
            s = {
                function()
                    require("telescope.builtin").treesitter(opts)
                end,
                "Treesitter",
            },
            l = {
                function()
                    require("telescope.builtin").reloader(opts)
                end,
                "Lua modules",
            },
            j = {
                function()
                    require("telescope.builtin").jumplist(opts)
                end,
                "Lua modules",
            },
            -- y = {
            --     function()
            --         require("telescope").extensions.file_browser.file_browser()
            --     end,
            --     "File browser",
            -- },
            D = {
                -- TODO: Remove?
                function()
                    require("py_trace").traceback()
                end,
                "Last traceback",
            },
            L = {
                function()
                    require("py_trace").traceback_qf()
                end,
                "Last traceback",
            },
            q = {
                function()
                    require("telescope.builtin").find_files({
                        cwd = require("telescope.utils").buffer_dir(),
                    })
                end,
                "Find files in cwd",
            },
            p = {
                function()
                    require("telescope.builtin").grep_string({
                        search = vim.fn.input("Grep > "),
                    })
                end,
                "Grep",
            },
        },
        -- ["<c-p>"] = {
        --     function()
        --         require("telescope.builtin").find_files({ previewer = false })
        --     end,
        --     "Find files",
        -- },
        ["<c-p>"] = { "<Plug>(CybuPrev)", "Find files" },
        ["<c-n>"] = { "<Plug>(CybuNext)", "Find files" },
        ["<c-z>"] = {
            function()
                require("telescope.builtin").oldfiles({ previewer = false })
            end,
            "Previous files",
        },
        -- ["<c-n>"] = { ":NvimTreeToggle<cr>", "Toggle NvimTree" },
    })
end

M.on_attach = function()
    -- Mappings
    local wk = require("which-key")
    wk.register({
        g = {
            name = "+lsp",
            D = {
                function()
                    vim.lsp.buf.declaration()
                end,
                "Go to declaration",
                noremap = true,
                silent = true,
            },
            d = {
                function()
                    vim.lsp.buf.definition()
                end,
                "Go to definition",
                noremap = true,
                silent = true,
            },
            i = {
                function()
                    vim.lsp.buf.implementation()
                end,
                "Go to implementation",
                noremap = true,
                silent = true,
            },
            a = {
                function()
                    vim.lsp.buf.code_action()
                end,
                "Code action",
                noremap = true,
                silent = true,
            },
            r = {
                function()
                    vim.lsp.buf.references()
                end,
                "Show references",
                noremap = true,
                silent = true,
            },
        },
        ["<leader>"] = {
            D = {
                function()
                    vim.lsp.buf.type_definition()
                end,
                "Go to type definition",
                noremap = true,
                silent = true,
            },
            rn = {
                function()
                    vim.lsp.buf.rename()
                end,
                "Rename",
                noremap = true,
                silent = true,
            },
            e = {
                function()
                    vim.diagnostic.open_float({ popup_opts = { border = "single" } })
                end,
                "Show line diagnostics",
                noremap = true,
                silent = true,
            },
            q = {
                function()
                    vim.diagnostic.setloclist()
                end,
                "Set loc list",
                noremap = true,
                silent = true,
            },
            t = {
                name = "+toggle",
                d = {
                    function()
                        vim.diagnostic.config({ virtual_text = false })
                    end,
                    "Disable virtual text diagnostic",
                },
                v = {
                    function()
                        vim.diagnostic.config({ virtual_text = true })
                    end,
                    "Enable virtual text diagnostic",
                },
            },
            w = {
                name = "+workspace",
                a = {
                    function()
                        vim.lsp.buf.add_workspace_folder()
                    end,
                    "Add workspace folder",
                    noremap = true,
                    silent = true,
                },
                d = {
                    function()
                        vim.lsp.buf.remove_workspace_folder()
                    end,
                    "Remove workspace folder",
                    noremap = true,
                    silent = true,
                },
                l = {
                    function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end,
                    "List workspace folders",
                    noremap = true,
                    silent = true,
                },
            },
        },
        ["[d"] = {
            function()
                vim.diagnostic.goto_prev()
            end,
            "Previous diagnostic",
            noremap = true,
            silent = true,
        },
        ["]d"] = {
            function()
                vim.diagnostic.goto_next()
            end,
            "Next diagnostic",
            noremap = true,
            silent = true,
        },
        K = {
            function()
                vim.lsp.buf.hover({ popup_opts = { border = "single" } })
            end,
            "Lsp hover",
            noremap = true,
            silent = true,
        },
        ["<c-k>"] = {
            function()
                vim.lsp.buf.signature_help()
            end,
            "Signature help",
            noremap = true,
            silent = true,
        },
    }, { buffer = 0 })
    return wk
end

M.goto_preview = function()
    local wk = require("which-key")
    wk.register({
        p = {
            name = "+preview",
            d = {
                function()
                    require("goto-preview").goto_preview_definition()
                end,
                "Preview definition",
                noremap = true,
                silent = true,
            },
            i = {
                function()
                    require("goto-preview").goto_preview_implementation()
                end,
                "review implementation",
                noremap = true,
                silent = true,
            },
            r = {
                function()
                    require("goto-preview").goto_preview_references()
                end,
                "Preview references",
                noremap = true,
                silent = true,
            },
        },
        P = {
            function()
                require("goto-preview").close_all_win()
            end,
            "Closs all preview wins",
            noremap = true,
            silent = true,
        },
    }, { buffer = 0, prefix = "g" })
    return wk
end

M.nabla = function()
    wk.register({
        p = {
            name = "+preview",
            a = {
                function()
                    require("nabla").action()
                end,
                "Conceal tex math",
                noremap = true,
                silent = true,
            },
            p = {
                function()
                    require("nabla").popup()
                end,
                "Preview tex math",
                noremap = true,
                silent = true,
            },
        },
    }, { prefix = "<leader>" })
end

M.dap = function()
    wk.register({
        ["<F5>"] = {
            function()
                require("dap").continue()
            end,
            "Continue",
        },
        ["<F10>"] = {
            function()
                require("dap").step_over()
            end,
            "Step over",
        },
        ["<F11>"] = {
            function()
                require("dap").step_into()
            end,
            "Step into",
        },
        ["<F12>"] = {
            function()
                require("dap").step_out()
            end,
            "Step out",
        },
        ["<leader>b"] = {
            name = "+breakpoint",
            b = {
                function()
                    require("dap").toggle_breakpoint()
                end,
                "Toggle breakpoint",
            },
            B = {
                function()
                    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
                end,
                "Conditional breakpoint",
            },
            l = {
                function()
                    require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
                end,
                "Log-point",
            },
        },
    })
end

M.treehopper = function()
    wk.register({
        m = {
            ":<C-U>lua require('tsht').nodes()<cr>",
            "TS Hint",
            mode = "o",
            noremap = true,
            silent = true,
        },
    })
    wk.register({
        m = {
            ":lua require('tsht').nodes()<cr>",
            "TS Hint",
            mode = "v",
            noremap = true,
            silent = true,
        },
    })
end

M.mini = function()
    -- Manual keymapping since the default binds visual mode mappings which
    -- conflict with other bindings
    wk.register({
        ys = {
            [[v:lua.MiniSurround.operator('add')]],
            "Surround",
            mode = "n",
            noremap = true,
            expr = true,
            silent = true,
        },
        cs = {
            [[v:lua.MiniSurround.operator('replace') . ' ']],
            "Replace",
            mode = "n",
            noremap = true,
            expr = true,
            silent = true,
        },
        ds = {
            [[v:lua.MiniSurround.operator('delete') . ' ']],
            "Surround",
            mode = "n",
            noremap = true,
            expr = true,
            silent = true,
        },
    })
end

M.leap = function()
    wk.register({
        ["<leader>s"] = { "<Plug>(leap-forward)", "Leap forward" },
        ["<leader>S"] = { "<Plug>(leap-backward)", "Leap backward" },
        ["<leader>x"] = { "<Plug>(leap-forward-x)", "Leap forward x" },
        ["<leader>X"] = { "<Plug>(leap-backward-x)", "Leap backward x" },
        ["gs"] = { "<Plug>(leap-omni)", "Leap omni dir" },
        ["gS"] = { "<Plug>(leap-cross-window)", "Leap cross-window" },
    })
end

return M
