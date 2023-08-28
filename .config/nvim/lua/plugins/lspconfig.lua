local M = {}
local lsp_utils = require("core.lsp")

local function with_defaults(server_opts)
    local merged = {
        on_attach = lsp_utils.on_attach,
        capabilities = lsp_utils.capabilities,
    }
    for k, v in pairs(server_opts) do
        merged[k] = v
    end
    return merged
end

local present_lspconfig, lspconfig = pcall(require, "lspconfig")
if present_lspconfig then
    -- Rust
    lspconfig.rust_analyzer.setup(with_defaults({
        cmd = {
            "/home/filip/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer",
        },
        settings = {
            ["rust-analyzer"] = {
                imports = { granularity = { group = "module" }, prefix = "self" },
                cargo = { buildScripts = { enable = true } },
                procMacro = { enable = true },
            },
        },
    }))

    -- Python
    lspconfig.ruff_lsp.setup(with_defaults({}))
    -- lspconfig.pyright.setup(with_defaults({}))
    lspconfig.pyright.setup(with_defaults({
        settings = {
            python = {
                analysis = {
                    inlayHints = {
                        variableTypes = true,
                        functionReturnTypes = true,
                        callArgumentNames = true,
                    },
                },
            },
        },
    }))
    lspconfig.pylyzer.setup(with_defaults({}))
    -- lspconfig.pylsp.setup(with_defaults({
    --     settings = {
    --         pylsp = {
    --             plugins = {
    --                 pylint = { enabled = true },
    --                 pycodestyle = { enabled = false },
    --                 pyflakes = { enabled = false }, -- Enabled by default
    --                 flake8 = { enabled = false },
    --                 -- jedi_hover = { enabled = false },
    --                 -- jedi_references = { enabled = false },
    --                 -- jedi_signature_help = { enabled = false },
    --                 -- jedi_symbols = { enabled = false },
    --                 -- jedi_definition = { enabled = false },
    --                 pydocstyle = { enabled = false },
    --                 -- rope_completion = { enabled = false },
    --                 yapf = { enabled = false },
    --             },
    --         },
    --     },
    -- }))
    -- Haskell
    lspconfig.hls.setup(with_defaults({}))

    -- Julia
    lspconfig.julials.setup(with_defaults({}))

    -- Lua
    lspconfig.lua_ls.setup(with_defaults({}))

    -- Web
    lspconfig.tsserver.setup(with_defaults({}))

    -- LaTeX
    lspconfig.texlab.setup(with_defaults({}))
    lspconfig.ltex.setup(with_defaults({}))

    -- Additional misc servers
    lspconfig.bashls.setup(with_defaults({}))
    lspconfig.dockerls.setup(with_defaults({}))
end

local exists, null_ls = pcall(require, "null-ls")
if exists then
    null_ls.setup({
        sources = {
            require("null-ls").builtins.formatting.black,
            require("null-ls").builtins.formatting.isort,
            require("null-ls").builtins.formatting.lua_format,
            -- require("null-ls").builtins.formatting.stylish_haskell,
            require("null-ls").builtins.formatting.stylua.with({
                args = { "--indent-type", "Spaces", "-" },
            }),
        },
        -- debug = true
    })
end

-- Lazy load if/when required
-- M.init_rust = function()
--     vim.cmd([[packadd rust-tools.nvim]])
--     require("plugins.rust")
-- end
-- -- TODO: Move to lua autocmds
-- vim.cmd([[
--         augroup rust_analyzer
--             autocmd!
--             autocmd FileType rust lua require"plugins.lspconfig".init_rust()
--         augroup END
--         ]])

return M
