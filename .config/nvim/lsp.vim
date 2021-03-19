autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()

lua require("lsp")

autocmd BufEnter * lua require'completion'.on_attach()
" Rust typehint on current line
"autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }
autocmd InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = ' » ', highlight = "NonText", enabled = {"ChainingHint"} }
