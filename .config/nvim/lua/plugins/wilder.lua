vim.cmd [[ call wilder#enable_cmdline_enter() ]]
vim.cmd [[ set wildcharm=<Tab> ]]
vim.cmd [[ cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>" ]]
vim.cmd [[ cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>" ]]
vim.cmd [[ call wilder#set_option('modes', ['/', '?', ':']) ]]

vim.cmd [[ call wilder#set_option('pipeline', [ wilder#branch( wilder#cmdline_pipeline({ 'fuzzy': 1, }), wilder#python_search_pipeline({ 'pattern': 'fuzzy', }),), ]) ]]

vim.cmd [[ let g:highlighters = [ wilder#pcre2_highlighter(), wilder#basic_highlighter(), ] ]]

-- Without experimental border
--[[ vim.cmd [[ call wilder#set_option('renderer', wilder#renderer_mux({ ':': wilder#popupmenu_renderer({ 'highlighter': g:highlighters, }), '/': wilder#wildmenu_renderer({ 'highlighter': g:highlighters, }), })) ]]
-- ]]
vim.cmd [[ call wilder#set_option('renderer', wilder#renderer_mux({ ':': wilder#popupmenu_renderer(wilder#popupmenu_border_theme({ 'highlighter': g:highlighters, 'highlights': { 'border': 'Normal', }, 'border': 'rounded', })), '/': wilder#wildmenu_renderer({ 'highlighter': g:highlighters, }), }))]]
