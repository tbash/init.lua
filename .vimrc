"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible " not compatible with vi
set autoread " detect when a file is changed

" make backspace behave in a sane manner
set backspace=indent,eol,start

set history=100  " change history to 1000
set textwidth=120

" Tab control
set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=2 " the visible width of tabs
set softtabstop=2 " edit as if the tabs are 2 characters wide
set shiftwidth=2 " number of spaces to use for indent and unindent
set shiftround " round indent to a multiple of 'shiftwidth'
set expandtab " say no to tabs
set completeopt+=longest

if has('mouse')
  set mouse=a
endif

" allow copy to clipboard to equal yank
set clipboard=unnamed

" faster redrawing
set ttyfast

" highlight conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" code folding settings
set foldmethod=syntax " fold based on indent
set foldnestmax=10 " deepest fold is 10 levels
set nofoldenable " don't fold by default
set foldlevel=1

" set no indet for paste mode mapped to F10
set pastetoggle=<F10>

" Removes trailing whitespace on write (:w)
autocmd BufWritePre * :%s/\s\+$//e

" Silence error bells
set belloff=all

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set so=7 " set 7 lines to the cursors - when moving vertical
set wildmenu " enhanced command line completion
set hidden " current buffer can be put into background
set showcmd " show incomplete commands
set noshowmode " don't show which mode disabled for PowerLine
set wildmode=list:longest " complete files like a shell
set scrolloff=3 " lines of text around cursor
set shell=$SHELL
set cmdheight=1 " command bar height

set title " set terminal title

" Searching
set ignorecase " case insensitive searching
set smartcase " case-sensitive if expression contains a capital letter
set hlsearch
set incsearch " set incremental search, like modern browsers
set nolazyredraw " don't redraw while executing macros

set magic " Set magic on, for regex

set showmatch " show matching braces
set mat=2 " how many tenths of a second to blink

" switch syntax highlighting on
syntax on

" set relativenumber " show relative line numbers
set number " show the current line number"

set nowrap "turn on line wrapping
set wrapmargin=8 " wrap lines when coming within n characters from side
set linebreak " set soft wrapping
set showbreak=… " show ellipsis at breaking

set autoindent " automatically set indent of new line
set smartindent

" show my invisible chars
set list
set listchars=tab:⊨⇒,eol:¬

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups, and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set nobackup
" set nowritebackup
" set noswapfile
" set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => StatusLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2 " show the satus line all the time
set statusline+=%#warningmsg#
set statusline+=%*

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'dracula/vim'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'elixir-lang/vim-elixir'
Plug 'elmcast/elm-vim'
Plug 'purescript-contrib/purescript-vim'
Plug 'leafgarland/typescript-vim'
Plug 'mhinz/vim-mix-format'

call plug#end()

let g:dracula_italic = 0
colorscheme dracula

" Using the ripgrep in place of grep
" $ brew install ripgrep
if executable('rg')
  " Use rg over grep
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m

  " Use rg in ack.vim
  let g:ackprg = 'rg --vimgrep --no-heading'

  " Use rg with fzf.vim
  command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
        \   <bang>0 ? fzf#vim#with_preview('up:60%')
        \           : fzf#vim#with_preview('right:50%:hidden', '?'),
        \   <bang>0)

  nnoremap <C-p>a :Rg
endif

" bind K to ack word under cursor
nnoremap K :Ack<SPACE>-i<SPACE>! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \\ (backward slash) to ack shortcut
nnoremap \\ :Ack<SPACE>-i<SPACE>

let g:lightline = {
      \ 'colorscheme': 'Dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
      \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? "\ue0a2" : ''
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  return fname =~ 'NERD_tree' ? '' :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'NERD'  && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  return fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" ALE Stuff
let g:ale_pattern_options = {
  \ '\.elm$': { 'ale_fixers': []}
  \ }

let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']

let g:ale_fix_on_save = 1

" let g:elm_format_autosave=0

let g:mix_format_on_save = 1
let g:mix_format_options = '--check-equivalent'

" show hidden files in NERDTree
let NERDTreeShowHidden=1

" remove some files by extension
let NERDTreeIgnore = ['\.js.map$']

" map F2 key to toggle NERDTree
map <F2> :NERDTreeToggle <cr>

" Search ignore
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.tmp/*,*/node_modules/*,*.keep,*.DS_Store,*/.git/*

" Allow flow syntax highlighting
let g:javascript_plugin_flow = 1

" Allow .jsx syntax in .js files
let g:jsx_ext_required = 0

" fzf.vim keybindings
nmap ; :Buffers<CR>
nnoremap <c-p> :GFiles<cr>
