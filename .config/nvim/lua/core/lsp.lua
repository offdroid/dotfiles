local M = {}

local navbuddy = require("nvim-navbuddy")

M.on_attach = function(client, bufnr)
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    if client.name ~= "pylyzer" then
        navbuddy.attach(client, bufnr)
    end

    if client.name == "pylsp" or client.name == "pyright" or client.name == "sourcery" then
        -- client.resolved_capabilities.document_formatting = false
        client.server_capabilities.document_formatting = false
    end

    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint(bufnr, true)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Apply mappings
    local wk = require("mapping").on_attach()

    -- Set some keybinds depend on server capabilities
    local null_format_support = client.name == "pyright"
        or client.name == "pylsp"
        or client.name == "lua_ls"
        or client.name == "rust_analyzer"
        or client.name == "hls"
    if client.server_capabilities.document_formatting or null_format_support then
        wk.register({
            ["<leader>gq"] = {
                function()
                    vim.lsp.buf.format({ async = true })
                end,
                "Format",
            },
        }, { buffer = 0 })
        -- vim.cmd [[autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)]]
    elseif client.server_capabilities.document_range_formatting then
        wk.register({
            ["<leader>gq"] = {
                function()
                    vim.lsp.buf.range_formatting()
                end,
                "Format",
            },
        }, { buffer = 0 })
    end

    if client.resolved_capabilities.signature_help then
        require("lsp_signature").on_attach({
            bind = true,
            doc_lines = 2,
            floating_window = true,
            hint_enable = true,
            hint_prefix = "🐼 ",
            hint_scheme = "String",
            floating_window_above_cur_line = true,
            use_lspsaga = false,
            hi_parameter = "Search",
            handler_opts = { border = "single" },
            toggle_key = "<m-x>",
        })
    end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
-- Inline `update_capabilities` from `cmp-nvim-lsp`, because its much faster and doesn't break lazy loading
-- https://github.com/hrsh7th/cmp-nvim-lsp/blob/134117299ff9e34adde30a735cd8ca9cf8f3db81/lua/cmp_nvim_lsp/init.lua
local completionItem = M.capabilities.textDocument.completion.completionItem

completionItem.snippetSupport = true
completionItem.preselectSupport = true
completionItem.insertReplaceSupport = true
completionItem.labelDetailsSupport = true
completionItem.deprecatedSupport = true
completionItem.commitCharactersSupport = true
completionItem.tagSupport = { valueSet = { 1 } }
completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
}
M.capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

return M
