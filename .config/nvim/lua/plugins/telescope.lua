local exists, telescope = pcall(require, "telescope")
if not exists then
    vim.notify("No telescope")
    return
end

--https://github.com/NvChad/NvChad/blob/e77be17fe694de3fb779f84cfc73d6e29d3fb6e7/lua/plugins/configs/telescope.lua
telescope.setup({
    defaults = {
        preview = {
            filesize_hook = function(filepath, bufnr, opts)
                local max_bytes = 10000
                local cmd = { "head", "-c", max_bytes, filepath }
                require("telescope.previewers.utils").job_maker(cmd, bufnr, opts)
            end,
        },
        vimgrep_arguments = {
            "ag",
            "--nocolor",
            "--noheading",
            "--filename",
            "--number",
            "--column",
            "--smart-case",
        },
        -- prompt_prefix = "   ",
        -- selection_caret = "  ",
        -- entry_prefix = "  ",
        -- initial_mode = "insert",
        -- selection_strategy = "reset",
        -- sorting_strategy = "ascending",
        -- layout_strategy = "horizontal",
        -- layout_config = {
        --     horizontal = {
        --         prompt_position = "top",
        --         preview_width = 0.55,
        --         results_width = 0.8,
        --     },
        --     vertical = {
        --         mirror = false,
        --     },
        --     width = 0.99,
        --     height = 0.99,
        --     preview_cutoff = 120,
        -- },
        -- file_sorter = require("telescope.sorters").get_fuzzy_file,
        -- file_ignore_patterns = { "node_modules" },
        -- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        -- path_display = { "truncate" },
        -- winblend = 0,
        -- border = {},
        -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        media_files = {
            filetypes = { "png", "webp", "jpg", "jpeg" },
            find_cmd = "ag", -- find command (defaults to `fd`)
        },
        file_browser = {
            theme = "ivy",
            mappings = {
                ["i"] = {
                    -- your custom insert mode mappings
                },
                ["n"] = {
                    -- your custom normal mode mappings
                },
            },
        },
    },
})

-- local extensions = { "themes", "terms", "fzf", "file_browser" }
-- local packer_repos = [["extensions", "telescope-fzf-native.nvim"]]
--
-- if vim.fn.executable("ueberzug") == 1 then
--     table.insert(extensions, "media_files")
--     packer_repos = packer_repos .. ', "telescope-media-files.nvim"'
-- end
--
-- pcall(function()
--     for _, ext in ipairs(extensions) do
--         telescope.load_extension(ext)
--     end
-- end)
