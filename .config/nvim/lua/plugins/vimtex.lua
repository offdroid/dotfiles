vim.api.nvim_set_var('vimtex_view_method', 'zathura')
vim.api.nvim_set_var('vimtex_compiler_latexmk', {
    executable = 'latexmk',
    build_dir = 'build',
    options = {
        '-lualatex', '-file-line-error', '-synctex=1',
        '-interaction=nonstopmode'
    }
})
