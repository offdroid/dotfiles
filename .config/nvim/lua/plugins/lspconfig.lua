local nvim_lsp = require('lspconfig')

local tabnine = require('cmp_tabnine.config')
tabnine:setup({max_lines = 1000, max_num_results = 20, sort = true})

local cmp = require 'cmp'
local lspkind = require 'lspkind'
cmp.setup {
    snippet = {
        expand = function(args)
            -- You must install `vim-vsnip` if you use the following as-is.
            vim.fn['vsnip#anonymous'](args.body)
        end
    },

    -- You can set mapping if you want.
    mapping = {
        ['<c-p>'] = cmp.mapping.select_prev_item(),
        ['<c-n>'] = cmp.mapping.select_next_item(),
        ['<c-d>'] = cmp.mapping.scroll_docs(-4),
        ['<c-f>'] = cmp.mapping.scroll_docs(4),
        ['<c-Space>'] = cmp.mapping.complete(),
        ['<c-e>'] = cmp.mapping.close(),
        ['<cr>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
        ['<c-y>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        })
    },

    -- You should specify your *installed* sources.
    sources = {
        {name = 'nvim_lsp'}, {name = 'buffer'}, {name = 'path'},
        {name = 'calc'}, {name = 'crates'}, {name = 'vsnip'},
        {name = 'cmp_tabnine'}
    },
    formatting = {
        format = function(_entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " ..
                                vim_item.kind
            return vim_item
        end
    }
}

local function diagnostics_symbols(opts)
    -- Source: https://github.com/glepnir/lspsaga.nvim/blob/cb0e35d2e594ff7a9c408d2e382945d56336c040/lua/lspsaga/diagnostic.lua#L202-L228
    local group = {
        err_group = {
            highlight = 'LspDiagnosticsSignError',
            sign = opts.error_sign
        },
        warn_group = {
            highlight = 'LspDiagnosticsSignWarning',
            sign = opts.warn_sign
        },
        hint_group = {
            highlight = 'LspDiagnosticsSignHint',
            sign = opts.hint_sign
        },
        infor_group = {
            highlight = 'LspDiagnosticsSignInformation',
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
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    local opts = {noremap = true, silent = true}
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<cr>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<cr>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    -- Signature help
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>',
                   opts)
    -- buf_set_keymap('n', '<C-k>', [[<cmd>lua require('lspsaga.signaturehelp').signature_help()<cr>]], opts)
    buf_set_keymap('n', '<leader>wa',
                   '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
    buf_set_keymap('n', '<leader>wr',
                   '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
    buf_set_keymap('n', '<leader>wl',
                   '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>',
                   opts)
    buf_set_keymap('n', '<leader>D',
                   '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    -- Rename
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    -- buf_set_keymap('n', '<leader>rn', [[<cmd>lua require('lspsaga.rename').rename()<cr>]], opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    buf_set_keymap('n', '<leader>e',
                   '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>',
                   opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>',
                   opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>',
                   opts)
    buf_set_keymap('n', '<leader>q',
                   '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
    -- Code action
    buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    -- buf_set_keymap('n', 'ga', [[<cmd>lua require('lspsaga.codeaction').code_action()<cr>]], opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap('n', '<leader>gq',
                       '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap('n', '<leader>gq',
                       '<cmd>lua vim.lsp.buf.range_formatting()<cr>', opts)
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
    require'illuminate'.on_attach(client)
end

vim.g.Illuminate_delay = 100
vim.g.Illuminate_ftblacklist = {'nerdtree', 'Trouble', 'NvimTree', 'term'}
vim.g.Illuminate_ftwhitelist = {'rust', 'python', 'lua'}
vim.cmd [[autocmd InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = ' » ', highlight = "NonText", enabled = {"ChainingHint"} }]]
vim.cmd [[
autocmd FileType org lua require'cmp'.setup.buffer { sources = { { name = 'orgmode' }, { name = 'buffer' } }, }
]]

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = {
            -- prefix = '',
            prefix = '',
            spacing = 0
        },
        signs = true,
        underline = true,
        update_in_insert = true
    })

local function setup_servers(servers)
    -- Setup regular servers without specific config
    for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup {on_attach = on_attach, capabilities = capabilities}
    end
end

local function setup_grammar_guard()
    require'grammar-guard'.init()
    nvim_lsp.grammar_guard.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            ltex = {
                enabled = {"latex", "tex", "bib", "markdown"},
                language = "en",
                diagnosticSeverity = "information",
                setenceCacheSize = 2000,
                additionalRules = {enablePickyRules = true, motherTongue = "en"},
                trace = {server = "verbose"},
                dictionary = {},
                disabledRules = {},
                hiddenFalsePositives = {}
            }
        }
    }
end

local function setup_lua()
    local sumneko_binary = '/usr/bin/lua-language-server'
    local luadev = require('lua-dev').setup({
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

setup_servers {
    'texlab', 'clangd', 'julials', 'pylsp', 'pyright', 'rust_analyzer',
    'tsserver', 'html'
}
setup_lua()
setup_grammar_guard()
diagnostics_symbols {
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    infor_sign = ''
}

