-- local exists, pairs = pcall(require, "mini.pairs")
-- if exists then
--     pairs.setup({})
-- end

local exists, surround = pcall(require, "mini.surround")
if exists then
    surround.setup({
        mappings = {
            add = "", -- Add surrounding
            delete = "", -- Delete surrounding
            find = "", -- Find surrounding (to the right)
            find_left = "", -- Find surrounding (to the left)
            highlight = "", -- Highlight surrounding
            replace = "", -- Replace surrounding
            update_n_lines = "", -- Update `n_lines`
        },
    })
end

local exists, indentscope = pcall(require, "mini.indentscope")
if exists then
    indentscope.setup({
        symbol = "│",
        draw = { animation = indentscope.gen_animation("none") },
    })
end
