local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
    view = { entries = "custom" },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        -- ["<c-n>"] = cmp.mapping(cmp.select_next_item({ behavior = cmp.SelectBehavior.Select }), {"i", "c"}),
        ["<c-n>"] = function(_)
            if not cmp.visible() then
                cmp.complete()
            else
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            end
        end,
        ["<c-p>"] = function(_)
            if not cmp.visible() then
                cmp.complete()
            else
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            end
        end,
        ["<c-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<c-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<c-space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<c-y>"] = cmp.mapping.confirm({ select = true }),
        ["<c-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<cr>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer" },
        { name = "dictionary", keyword_length = 2 },
        {
            name = "latex_symbols",
            option = {
                strategy = 0, -- mixed
            },
        },
    }),
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require("cmp-under-comparator").under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    formatting = {
        format = lspkind.cmp_format({
            with_text = false, -- do not show text alongside icons
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            before = function(entry, vim_item)
                return vim_item
            end,
        }),
    },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = "buffer" } },
})

-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})
