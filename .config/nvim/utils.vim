fun! TogglePanes()
  execute("Vista!!")
  execute("CHADopen")
endfun

" Panels
nnoremap <silent><leader>sf :CHADopen<cr>
nnoremap <silent><leader>sv :Vista!!<cr>
nnoremap <silent><leader>sa :call TogglePanes()<cr>
nnoremap <silent><leader>ag :Ag!<cr>
