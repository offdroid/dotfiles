local nvim_lsp = require 'lspconfig'

local cmp = require 'cmp'
local lspkind = require 'lspkind'
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
cmp.setup {
    snippet = {expand = function(args) vim.fn['vsnip#anonymous'](args.body) end},
    mapping = {
        ['<c-p>'] = cmp.mapping.select_prev_item(),
        ['<c-n>'] = cmp.mapping.select_next_item(),
        ['<c-d>'] = cmp.mapping.scroll_docs(-4),
        ['<c-f>'] = cmp.mapping.scroll_docs(4),
        ['<c-Space>'] = cmp.mapping.complete(),
        ['<c-e>'] = cmp.mapping.close(),
        ['<cr>'] = cmp.mapping.confirm({select = true}),
        ['<c-y>'] = cmp.mapping.confirm({select = true})
    },
    sources = {
        {name = 'nvim_lsp'}, {name = 'buffer'}, {name = 'path'},
        {name = 'calc'}, {name = 'crates'}, {name = 'vsnip'},
        {name = 'orgmode'}, {name = 'tag'}, {name = 'treesitter'},
        {name = 'pandoc_references'}
        -- {name = 'cmp_tabnine'},
    },
    formatting = {
        format = function(_, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind] .. ' ' ..
                                vim_item.kind
            return vim_item
        end
    }
}
cmp.event:on('confirm_done',
             cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))

local function diagnostics_symbols(opts)
    -- Source: https://github.com/glepnir/lspsaga.nvim/blob/cb0e35d2e594ff7a9c408d2e382945d56336c040/lua/lspsaga/diagnostic.lua#L202-L228
    local group = {
        err_group = {highlight = 'DiagnosticSignError', sign = opts.error_sign},
        warn_group = {
            highlight = 'DiagnosticSignWarning',
            sign = opts.warn_sign
        },
        hint_group = {highlight = 'DiagnosticSignHint', sign = opts.hint_sign},
        infor_group = {
            highlight = 'DiagnosticSignInformation',
            sign = opts.infor_sign
        }
    }

    for _, g in pairs(group) do
        vim.fn.sign_define(g.highlight, {
            text = g.sign,
            texthl = g.highlight,
            linehl = '',
            numhl = ''
        })
    end
end

local on_attach = function(client, bufnr)
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    local wk = require 'which-key'
    wk.register({
        g = {
            name = '+lsp',
            D = {
                function() vim.lsp.buf.declaration() end,
                'Go to declaration',
                noremap = true,
                silent = true
            },
            d = {
                function() vim.lsp.buf.definition() end,
                'Go to definition',
                noremap = true,
                silent = true
            },
            i = {
                function() vim.lsp.buf.implementation() end,
                'Go to implementation',
                noremap = true,
                silent = true
            },
            a = {
                function() vim.lsp.buf.code_action() end,
                'Code action',
                noremap = true,
                silent = true
            },
            r = {
                function() vim.lsp.buf.references() end,
                'Show references',
                noremap = true,
                silent = true
            }
        },
        ['<leader>'] = {
            D = {
                function() vim.lsp.buf.type_definition() end,
                'Go to type definition',
                noremap = true,
                silent = true
            },
            rn = {
                function() vim.lsp.buf.rename() end,
                'Rename',
                noremap = true,
                silent = true
            },
            e = {
                function()
                    vim.lsp.diagnostic.show_line_diagnostics()
                end,
                'Show line diagnostics',
                noremap = true,
                silent = true
            },
            q = {
                function() vim.lsp.diagnostic.set_loclist() end,
                'Set loc list',
                noremap = true,
                silent = true
            },
            w = {
                name = '+workspace',
                a = {
                    function()
                        vim.lsp.buf.add_workspace_folder()
                    end,
                    'Add workspace folder',
                    noremap = true,
                    silent = true
                },
                d = {
                    function()
                        vim.lsp.buf.remove_workspace_folder()
                    end,
                    'Remove workspace folder',
                    noremap = true,
                    silent = true
                },
                l = {
                    function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end,
                    'List workspace folders',
                    noremap = true,
                    silent = true
                }
            }
        },
        ['[d'] = {
            function() vim.lsp.diagnostic.goto_prev() end,
            'Previous diagnostic',
            noremap = true,
            silent = true
        },
        [']d'] = {
            function() vim.lsp.diagnostic.goto_next() end,
            'Next diagnostic',
            noremap = true,
            silent = true
        },
        K = {
            function() vim.lsp.buf.hover() end,
            'Lsp hover',
            noremap = true,
            silent = true
        },
        ['<c-k>'] = {
            function() vim.lsp.buf.signature_help() end,
            'Signature help',
            noremap = true,
            silent = true
        }
        --[[ ['<a-p>'] = {
            function()
                require'illuminate'.next_reference {reverse = true, wrap = true}
            end,
            'Prev reference',
            noremap = true
        },
        ['<a-n>'] = {
            function()
                require'illuminate'.next_reference {wrap = true}
            end,
            'Next reference',
            noremap = true
        } ]]
    }, {buffer = 0})

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        wk.register({
            ['<leader>gq'] = {function() vim.lsp.buf.formatting() end, 'Format'}
        }, {buffer = 0})
        -- vim.cmd [[autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)]]
    elseif client.resolved_capabilities.document_range_formatting then
        wk.register({
            ['<leader>gq'] = {
                function() vim.lsp.buf.range_formatting() end, 'Format'
            }
        }, {buffer = 0})
    end

    if client.resolved_capabilities.signature_help then
        require'lsp_signature'.on_attach({
            bind = true,
            doc_lines = 2,
            floating_window = true,
            hint_enable = true,
            hint_prefix = '🐼 ',
            hint_scheme = 'String',
            floating_window_above_cur_line = true,
            use_lspsaga = false,
            hi_parameter = 'Search',
            handler_opts = {border = 'single'},
            toggle_key = '<m-x>'
        })
    end
    -- require'illuminate'.on_attach(client)
end

vim.g.Illuminate_delay = 100
vim.g.Illuminate_ftblacklist = {'nerdtree', 'Trouble', 'NvimTree', 'term'}
vim.g.Illuminate_ftwhitelist = {'rust', 'python', 'lua'}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require'cmp_nvim_lsp'.update_capabilities(capabilities)

vim.diagnostic.config({
    signs = true,
    update_in_insert = true,
    virtual_text = {
        -- prefix = '',
        prefix = '',
        spacing = 0
    }
})

local function setup_servers(servers)
    -- Setup regular servers without specific config
    for _, lsp in ipairs(servers) do
        local settings = nil
        if type(lsp) == 'table' then
            settings = lsp[2]
            lsp = lsp[1]
        end
        nvim_lsp[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = settings
        }
    end
end

local function setup_lua()
    local sumneko_binary = '/usr/bin/lua-language-server'
    local ok, lua_dev = pcall(require, 'lua-dev')
    if ok then
        local luadev = lua_dev.setup({
            lspconfig = {
                on_attach = on_attach,
                cmd = {sumneko_binary},
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                            path = vim.split(package.path, ';')
                        },
                        diagnostics = {globals = {'vim'}},
                        workspace = {
                            library = {
                                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                                [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                            }
                        }
                    }
                }
            }
        })
        nvim_lsp.sumneko_lua.setup(luadev)
    end
end

setup_servers {
    'texlab', 'clangd', 'julials', {
        'pyright', {
            pyright = {disableLanguageServices = false},
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                    useLibraryCodeForTypes = true
                }
            }
        }
    }, {'pylsp', {pylsp = {plugins = {mccabe = {threshold = 19}}}}}, 'tsserver',
    'html', 'ltex', 'gopls'
}
if vim.fn.has('unix') == 1 then
    pcall(setup_lua)
    require('rust-tools').setup({
        server = {on_attach = on_attach, capabilities = capabilities}
    })
end

diagnostics_symbols {
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    infor_sign = ''
}

vim.lsp.handlers['textDocument/codeAction'] =
    require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] =
    require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] =
    require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] =
    require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] =
    require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] =
    require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] =
    require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] =
    require'lsputil.symbols'.workspace_handler
