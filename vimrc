set nocompatible " must be the first line
set bs=2

set grepprg=grep\ -nH\ $*
set laststatus=2
" Statusline not needed in favor of air-line
" set statusline=%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P
syntax on
set nu




" **********
" Appearance
" **********

colorscheme dante
colorscheme vimbrant

" set background=dark
" colorscheme base16-monokai

"set term=linux
set mouse=a
set nowrap
set smarttab
"enabling visual mode to system clipboard
set clipboard^=autoselect
"get rid of scrollbars in Gvim
set guioptions-=r
set guioptions-=L

" Wrapping without linebreaks
set wrap
set linebreak
set nolist  " list disables linebreak

"git commit messages
au FileType gitcommit set tw=72
filetype indent plugin on

set nocompatible               " be iMproved
filetype off                   " required!



" ***************
" Vundle settings
" ***************


set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
" No idea why L9 is useful
Bundle 'L9'
Bundle 'FuzzyFinder'
" (HT|X)ml tool
Bundle 'ragtag.vim'
Bundle "mattn/emmet-vim"
" multi editting (use ctrl+n for everything)
Bundle "https://github.com/terryma/vim-multiple-cursors.git"
" Comment toggling (use gc to toggle in visual, gcc for line)
Bundle "https://github.com/tomtom/tcomment_vim.git"
" Git integration
Bundle 'airblade/vim-gitgutter'
Bundle "git://github.com/tpope/vim-fugitive.git"
Bundle 'chriskempson/base16-vim'
Bundle 'bling/vim-airline'
Bundle "The-NERD-tree"
Bundle 'jistr/vim-nerdtree-tabs'
let g:airline#extensions#tabline#enabled = 1
filetype plugin indent on     " required! 



" ******************
" Intendation tweaks
" ******************

" let g:smartindent
"
" Intendation for html
let g:html_indent_inctags = "html,body,head,tbody"
au FileType html setl sw=2 sts=2 et
"
" Brief help
" U :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..


" ***********
" FuzzyFinder
" ***********


" Ignore cabal-dev
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp)$|(^|[/\\])(\.(hg|git|bzr)|cabal-dev|dist)($|[/\\])'
" Most Recently Used files
nnoremap mru :FufMruFile<CR>
let g:fuf_modesDisable = []
"nnoremap <Leader>e :FuFFile <C-r>=fnamemodify(getcwd(), ':p')<CR><CR>
nnoremap <Leader>e :FufFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
nnoremap <Leader>ff :FufFile<CR>
nnoremap <Leader>, :FufBuffer<CR>
nnoremap <Leader>. :FufTag<CR>
nnoremap <C-h> :FufHelp<CR>



" ********************
" Nerd tree keymapping
" ********************


map <C-p> :NERDTreeTabsToggle <CR>
"automatically start nerdtree - not needed with nerdtreeTabs
" autocmd vimenter * NERDTree | " wincmd p

" forgot why, not needed with nerdtreeTabs
" autocmd vimenter * if !argc() | NERDTree | wincmd p | endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif

let fuf_abbrevMap  = {
			\   '\C^GVR' : [
			\     '$VIMRUNTIME/**/',
			\     '~/.vim/**/',
			\     '$VIM/.vim/**/',
			\     '$VIM/vimfiles/**/',
			\   ],
			\   '\C^VR' : [
			\     '~/.vim/**/',
			\   ],
			\   '\C^ZZ' : [
			\     '~/.vim/**/zz_',
			\   ],
			\ }

let g:tex_flavor='latex'

