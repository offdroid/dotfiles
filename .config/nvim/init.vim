if &compatible
  set nocompatible
endif

let g:python3_host_prog = '/usr/bin/python3.9'

set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

if 0 && has('persistent_undo')
    let target_path = expand('~/.vim/undo/')
    " Create if undo dir if not exists
    if !isdirectory(target_path)
        call system('mkdir -p ' . target_path)
    endif
    let &undodir = target_path
    set undofile
endif

call dein#begin('$HOME/.cache/dein')
call dein#add('$HOME/.cache/dein/repos/github.com/Shougo/dein.vim')

" LSP
call dein#add('neovim/nvim-lsp')
call dein#add('neovim/nvim-lspconfig')
call dein#add('nvim-lua/completion-nvim')
call dein#add('gfanto/fzf-lsp.nvim')
call dein#add('kosayoda/nvim-lightbulb')
call dein#add('nvim-lua/lsp_extensions.nvim')
"call dein#add('hrsh7th/nvim-compe')

call dein#add('sheerun/vim-polyglot')

" Cosmetic
call dein#add('ryanoasis/vim-devicons')
call dein#add('joshdick/onedark.vim')
call dein#add('liuchengxu/space-vim-theme')
call dein#add('itchyny/lightline.vim')

" LaTeX
call dein#add('lervag/vimtex')
call dein#add('da-h/AirLatex.vim', {'do': ':UpdateRemotePlugins'})

" Navigation
call dein#add('ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'})
call dein#add('liuchengxu/vista.vim')

" Comments
call dein#add('preservim/nerdcommenter')

" Version control
call dein#add('tpope/vim-fugitive')
call dein#add('lewis6991/gitsigns.nvim')
call dein#add('nvim-lua/plenary.nvim') " Dependency for gitsigns

" Databases
call dein#add('tpope/vim-dadbod')
call dein#add('jsborjesson/vim-uppercase-sql')

" Misc
call dein#add('universal-ctags/ctags')
call dein#add('tpope/vim-dispatch')
call dein#add('lingnand/pandoc-preview.vim', {'lazy': 1, 'on_ft': ['md', 'markdown', 'pandoc', 'rst', 'restructuredtext']})
call dein#add('metakirby5/codi.vim', {'lazy': 1, 'on_cmd': 'Codi'})

call dein#end()
filetype plugin indent on
syntax enable

if (empty($TMUX))
  if (has("termguicolors"))
    set termguicolors
  endif
endif
colorscheme space_vim_theme
let g:lightline = {
      \ 'colorscheme': 'selenized_black',
      \ }

set mouse=a cursorline 
set rnu nu
set shiftwidth=4 expandtab
set foldmethod=syntax foldlevel=99
set clipboard=unnamedplus
set shortmess+=c
set updatetime=300
set signcolumn=yes
set splitbelow splitright
set incsearch inccommand=split ignorecase
set completeopt=menuone,noinsert,noselect

" Clear highlight on enter post search
nnoremap <silent><CR> :noh<CR>

" Leader key
nnoremap <SPACE> <Nop>
let mapleader=' '
let maplocalleader=' '

let s:init_vim_dir = expand('<sfile>:p:h')
for file in ["lsp.vim", "tex.vim", "utils.vim"]
    execute("source" . s:init_vim_dir . "/" . file)
endfor

" Insert a newline above the cursor
nmap <leader><S-Enter> O<Esc>j
" Insert a newline below the cursor
nmap <leader><CR> o<Esc>k
" Insert a space under the cursor
map -<leader>i <Esc>

let g:pandoc_preview_pdf_cmd = "zathura"

lua require('gitsigns').setup()
