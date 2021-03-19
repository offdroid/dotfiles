let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_latexmk = { 
        \ 'executable' : 'latexmk',
        \ 'options' : [ 
        \   '-xelatex',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}
nnoremap <leader>ll :VimtexCompile<cr>
nnoremap <leader>lc ?\\[^\s]\+{.\+}yf}}p:s/begin/end

" AirLatex
let g:AirLatexDomain="https://latex.tum.de"
let g:AirLatexCookieBrowser="firefox"
