local exists, signature = pcall(require, "lsp_signature")
if exists then
    signature.setup({
        bind = true,
        doc_lines = 10,
        floating_window = true,
        fix_pos = true,
        hint_enable = true,
        hint_prefix = "🐼 ",
        hint_scheme = "String",
        hi_parameter = "Search",
        max_height = 22,
        max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
        handler_opts = { border = "rounded" },
        zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
        padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
        toggle_key = "<m-x>",
    })
    --        bind = true,
    --        doc_lines = 2,
    --        floating_window = true,
    --        hint_enable = true,
    --        hint_prefix = " ",
    --        hint_scheme = "String",
    --        floating_window_above_cur_line = true,
    --        use_lspsaga = false,
    --        hi_parameter = "Search",
    --        handler_opts = { border = "single" },
    --        toggle_key = "<m-x>",
end
