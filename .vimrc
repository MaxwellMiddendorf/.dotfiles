"{{{ Information
"# vim: set foldmethod=marker:
"
" @title	Vim Configurations
" @author 	Maxwell Middnedorf
" 
" @purpose	This file is intend to provide
" 		configuarations and plugins
" 		for Vim."
"}}}
"{{{ Plugins
"  .............................................................................

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
	" Fern File Explore
	Plug 'lambdalisue/fern.vim'
	" File Icon
	Plug 'ryanoasis/vim-devicons'
	Plug 'lambdalisue/nerdfont.vim'
	Plug 'lambdalisue/fern-renderer-nerdfont.vim'
	let g:fern#renderer = "nerdfont"
	" Close Deliminators 
	Plug 'Raimondi/delimitMate'
	" Methods and Variable Overview
	Plug 'preservim/tagbar'
	" Code Autocomplete
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	" Git
	Plug 'tpope/vim-fugitive'
	Plug 'lambdalisue/fern-git-status.vim'
	" Surround
	Plug 'tpope/vim-surround'
	Plug 'Matt-A-Bennett/vim-surround-funk'
	" Comment Out
	Plug 'tpope/vim-commentary'
	" AI Completion
	Plug '0xStabby/chatgpt-vim'
	" Databases
	Plug 'tpope/vim-dadbod'
	" Buffer Viewer
	Plug 'ap/vim-buftabline'
	" Smooth Scroll
	Plug 'psliwka/vim-smoothie'
	" Inset Blank line
	Plug 'tpope/vim-unimpaired'
	" Rust Plugins
	Plug 'rust-lang/rust.vim'
call plug#end()


"}}}
"{{{ Basic Settings
"  .............................................................................

" line numbers
set number
" Number Hybrid
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
" Hybrid Colors
highlight LineNrAbove ctermfg=red
highlight LineNRBelow ctermfg=green
" syntax coloring
syntax on
" Enable Auto-Completion Menu
filetype plugin on
set omnifunc=syntaxcomplete#Complete
" Inherit indentation from previous line
set autoindent
" Use Tabs for Indentation
set noexpandtab
" Enable Backspace
set backspace=indent,eol,start
" Disable Welcome Message
set shortmess=I
" Change Backups
set directory=$HOME/.vim/swapfiles//

" Wordwrap on End of Words
set linebreak
" Ignore capital letters during search.
set ignorecase
" Override the ignorecase option if searching for capital letters.
set smartcase
" Set the number of commands to save in history (default=20)
set history=1000
" Enable auto completion menu (TAB)
set wildmenu
" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest
" Disable Tildes
highlight EndOfBuffer ctermfg=Black ctermbg=Black
" Folding config
set foldmethod=syntax
function! MyFoldText()
    let line = getline(v:foldstart)
    let folded_line_num = v:foldend - v:foldstart
    let line_text = substitute(line, '^"{\+', '', 'g')
    let fillcharcount = 150 - len(line_text) - len(folded_line_num)
    return ' ' .  repeat(' ', indent(v:foldstart)) . '(+) ' . line_text . '    ' .  repeat('-', fillcharcount) . ' (' . folded_line_num . ' Lines)'
endfunction
set foldtext=MyFoldText()
set foldcolumn=1 " defines 1 col at window left, to indicate folding
highlight Folded term=italic ctermfg=14 ctermbg=NONE
highlight FoldColumn term=italic ctermfg=14 ctermbg=NONE
highlight SignColumn term=italic ctermfg=14 ctermbg=NONE
" Enable Mouse Scrolling
set mouse=a
" Enable Modelines
set modeline
set modelines=5
" Search Before Enter
set incsearch
" Automatically CD To Current Working Directory
set autochdir
" Hide Split Lines
set fillchars+=vert:\ 
set foldcolumn=2
let s:hidden_all = 0
highlight VertSplit ctermfg=Black
" Buffer Tabs Configurations
let g:buftabline_show=1
let g:buftabline_indicators=1
set virtualedit+=onemore


"}}}
"{{{ Navigation
"{{{ Use Delete in Normal mode
function! Delete_key(...)
	let line=getline (".")
	if line=~'^\s*$'  
		execute "normal dd"
		return
	endif
	let column = col(".")
	let line_len = strlen (line)
	let first_or_end=0
	if column == 1
		let first_or_end=1
	else
		if column == line_len
			let first_or_end=1
		endif
	endif
	execute "normal i\<DEL>\<Esc>"
	if first_or_end == 0
		execute "normal l"
	endif
endfunction
"}}}
"{{{ Use Backspace in Normal mode
function! Backspace_key(...)
	let line=getline (".")
	if line=~'^\s*$'  
		execute "normal dd"
		return
	endif
	let column = col(".")
	let line_len = strlen (line)
	let first_or_end=0
	if column == 1
		let first_or_end=1
	else
		if column == line_len
			let first_or_end=1
		endif
	endif
	execute "normal i\<backspace>\<Esc>"
	if first_or_end == 0
		execute "normal l"
	endif
endfunction
nnoremap <silent> <DEL> :call Delete_key()<CR>
nnoremap <silent> <backspace> :call Backspace_key()<CR>
"}}}
if (has("mac"))
	" Delete to beginning of word
	nmap <Esc><BS> dvb
	imap <Esc><BS> <C-o>dvb
	" Delete to end of word
	nmap <M-Del> de
	imap <M-Del> <C-o>de

	"TODO FIX
	" Previous Word
	nmap <M-Left> b
	imap <M-Left> <C-o>b
	" Next Word
	nnoremap <M-Right> w
	inoremap <M-Right> <C-o>w
	" Move to EoL
	map <End> g_l
	" Prev Buffer
	nmap <silent>J :bp<CR>
	" Next Buffer
	nmap <silent>K :bn<CR>
elseif (has("win64"))
	" Delete to beginning of word
	nmap <Esc><BS> dvb
	imap <Esc><BS> <C-o>dvb
	" Delete to end of word
	nmap <C-Del> de
	imap <C-Del> <C-o>de

	"TODO FIX
	" Previous Word
	nmap <C-Left> b
	imap <C-Left> <C-o>b
	" Next Word
	nnoremap <C-Right> w
	inoremap <C-Right> <C-o>w
endif
	" Move to EoL
	map <End> g_l
	" Prev Buffer
	nmap <silent>J :bp<CR>
	" Next Buffer
	nmap <silent>K :bn<CR>
"}}}
"{{{ Key Remapings
"  .............................................................................
" Open Command Line
" nnoremap ; :
nmap <space> :
" Remap Redo
nmap U <C-r>
nmap <leader>m :make<CR>
"}}}
"{{{ Auto-Complete Configurations
"  ..............................................................................
" Colors
highlight Cocfloating ctermbg=DarkGray
highlight CocSearch ctermfg=LightBlue ctermbg=NONE
highlight CocMenuSel cterm=underline,bold  ctermbg=NONE

set updatetime=300
" Enable Syntax in the Line Number
set signcolumn=yes
" Trigger Completion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"Accept Completion
inoremap <silent><expr> <c-@> coc#refresh() 
""}}}
"{{{ Language Configurations
" C
autocmd Filetype c setlocal makeprg=gcc\ %\ -o\ %<
" C++
autocmd Filetype cpp setlocal makeprg=g++\ %\ -o\ %<
" COBAL
autocmd Filetype cobal setlocal makeprg=cobc\ -xj\ %\
" Java
autocmd Filetype java setlocal makeprg=java\ %
" Javascript
autocmd Filetype javascript setlocal makeprg=bun\ %
" Typescript
autocmd Filetype typescript setlocal makeprg=bun\ %
" Python
autocmd Filetype python setlocal makeprg=python3\ %
" Rust
autocmd Filetype rust setlocal makeprg=cargo\ run\ %
autocmd Filetype rust setlocal tabstop=4 softtabstop=4 shiftwidth=0 noexpandtab
" LaTex
autocmd FileType tex setlocal makeprg=pdflatex\ %


"}}}
"{{{ TODO

" 	- Map Chat Gpt commands / comment prompts / copilot
" 	- Preview Buffer Fix
" 	- Snippets


"}}}
