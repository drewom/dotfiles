 "__   _(_)_ _ __ ,_ __ ___
 "\ \ / / | '.` .\| '__) __)
  "\ V /| | || || | | ( (__
"(_)\_/ |_|_||_||_|_|  \___)
  " Drew O'Malley

" Load Pathogen for plugins:
	execute pathogen#infect()
	execute pathogen#helptags()

" Basics
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8          " because we don't live in the dark ages
	set background=dark         " I use dark bg, tell vim for syntax hilighting
	set scrolloff=2             " keep cursor a few lines on screen
	set matchtime=2             " show matching pairs after 200ms
	set mouse=a                 " enable mouse
	set hidden                  " allow hiding buffers without writing all changes
	set sessionoptions-=options " don't save ':set' changes to session
	set laststatus=2            " show status bar always
	set autoread                " reload file on external edit
	set ttyfast                 " i use st which is not detected as fast
	set lazyredraw              " skip redraw during macros
	set showcmd                 " display commands as typed

" More basics
	set matchpairs+=<:>   " <> pairs like (), [] & {}
	set display+=lastline " show start of last line even if it doesn't fully fit
	set display+=uhex     " show <xx> for unprintables
	set breakat-=-        " avoid visual '-\n>' with &breakindent and &linebreak
	set formatoptions+=j  " remove '//' on joining comment lines
	set nrformats-=octal  " don't treat 010 as 8
	set incsearch         " incremental search and highlight

" Move block (flakey but sometimes useful)
	vmap <expr> <LEFT>  DVB_Drag('left')
	vmap <expr> <RIGHT> DVB_Drag('right')
	vmap <expr> <DOWN>  DVB_Drag('down')
	vmap <expr> <UP>    DVB_Drag('up')
	vmap <expr> D       DVB_Duplicate()

" Setup tab characters (tab for indent, space for alignment)
	set tabstop=3 shiftwidth=3 softtabstop=0 noexpandtab
	set cinoptions=l1 " fix case statement indent
	set cindent       " c language indent support
	set breakindent   " indent wrapped text to match previous indent
	set linebreak     " try and break on words, not min-word

" Relative numbers, no number to keep gutter 2 chars
	set relativenumber
	set numberwidth=2

" Switch cursor shape when changing modes
	if exists('$TMUX')
		 let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
		 let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
	else
		 let &t_SI = "\e[5 q"
		 let &t_EI = "\e[2 q"
	endif

" Change invisibles when list is set
	set list "show following symbols to highlight whitespace
	set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨
	let &showbreak='⟩' "show this symbol before broken line overflow
	highlight NonText ctermfg=237 guifg=#303030
	highlight SpecialKey ctermfg=237 guifg=#303030
	highlight MatchParen cterm=none ctermbg=238

" remap command mode to semi-colon
	nnoremap ; :
	nnoremap : ;
	vnoremap ; :
	vnoremap : ;

" map tab to tab only if not mid word
	function! CleverTab()
		if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
			return "\<Tab>"
		else
			return "\<C-N>"
		endif
	endfunction
	inoremap <Tab> <C-R>=CleverTab()<CR>

" toggle autosave feature
	function AutosaveToggle() " bind keys to this to enable autosave
		" if you are editing this function with autosave and autosource
		" you will get an error here!
		if !exists('b:autosave')
			let b:autosave = 0
		endif
		let name = expand('%')
		if filewritable(name) == 1
			if !b:autosave
				echom "+autosave: " . name
				let b:autosave = 1
				update
			else
				echom "-autosave: " . name
				let b:autosave = 0
			endif
		else
			echo "UNABLE TO AUTOSAVE, FILE NOT WRITABLE!"
		endif
	endfunction
	nnoremap <leader>a :call AutosaveToggle()<CR>
	function Autosave() " does the autosaving, called often
		let name = expand('%')
		if exists("b:autosave") && b:autosave && filewritable(name) == 1
			echo "save " . name
			update
		endif
	endfunction
	autocmd InsertLeave,TextChanged * :call Autosave() " only autosaves when

" status bar
	set statusline=
	set statusline +=%1*\ %n\ %*            "buffer number
	set statusline +=%5*%{&ff}%*            "file format
	set statusline +=%3*%y%*                "file type
	set statusline +=%4*\ %<%F%*            "full path
	"set statusline +=%{exists('b:autosave')&&b:autosave==1?' [AUTO]':''} "modified flag
	set statusline +=%2*%m%*                "modified flag
	set statusline +=%1*%=%5l%*             "current line
	set statusline +=%2*/%L%*               "total lines
	set statusline +=%1*%4v\ %*             "virtual column number
	set statusline +=%2*0x%04B\ %*          "character under cursor

" Display comments as italics
	"highlight Comment cterm=italic

" ctrl+s saves
	nnoremap <C-s> :w<cr>
	inoremap <C-s> <esc>:w<cr>a

" Splits open at the bottom and right:
	set splitbelow
	set splitright

" switch up and down to allow wrapped line navigation (make sure to us gj and
" gk when making macros etc.)
	noremap j gj
	noremap k gk
	noremap gj j
	noremap gk k

" Shortcutting split navigation, saving a keypress:
	noremap <C-h> <C-w>h
	noremap <C-j> <C-w>j
	noremap <C-k> <C-w>k
	noremap <C-l> <C-w>l

" QuickFix shortcuts
	nnoremap <C-n> <ESC>:cnext<CR>
	nnoremap <C-p> <ESC>:cprevious<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>
	vnoremap S :s//g<Left><Left>

" Recursive Globbing
	set path+=**

" Autocomplete settings
	set wildmenu
	set wildignore=*.o,*~
	"set wildmode=longest,list,full
	set complete=.,w,b,u,t,i,kspell

" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" Visual mode easy tab selection
	vnoremap <TAB> >gv
	vnoremap <S-TAB> <gv

" show window focus better
	highlight StatusLineNC cterm=bold ctermfg=white ctermbg=233
	augroup BgHighlight
		autocmd!
		autocmd WinEnter,FocusGained * setlocal relativenumber
		autocmd WinLeave,FocusLost   * setlocal norelativenumber
	augroup END

" ring bell when job is finished
	let g:asyncrun_bell = 1

" filetype specific abbreviate macros
	autocmd FileType c,cpp,objc,objcpp,h,hpp iabbr ccom /*<cr>/<up>
	autocmd FileType c,cpp,objc,objcpp,h,hpp iabbr ccase case : {<cr>}<up><cr>wi
" === Function keys ===
" Get line, word and character counts with F3:
	noremap <F3> :!wc <C-R>%<CR>

" Spell-check set to F6:
	noremap <F6> :setlocal spell! spelllang=en_gb<CR>

" build and run shortcuts
	set makeprg=bear\ make\ -j
	nnoremap <silent> <F5> <ESC>:update<CR>:!make debugger<CR>
	nnoremap <silent> <F9> <ESC>:update<CR>:make<CR>
	nnoremap <silent> <F10> <ESC>:update<CR>:make clean<CR>

" F10 to toggle quickfix window
	nnoremap <F12> :call asyncrun#quickfix_toggle(10)<cr>

" interactive keys that should switch back to normal mode
	imap <silent> <F1> <ESC><F1>
	imap <silent> <F2> <ESC><F2>
	imap <silent> <F3> <ESC><F3>
	imap <silent> <F4> <ESC><F4>
	imap <silent> <F5> <ESC><F5>
	imap <silent> <F6> <ESC><F6>
	imap <silent> <F7> <ESC><F7>
	imap <silent> <F8> <ESC><F8>
	imap <silent> <F9> <ESC><F9>
	imap <silent> <F10> <ESC><F10>
	imap <silent> <F11> <ESC><F11>
	imap <silent> <F12> <ESC><F12>

" NetRW setup
" <CR> -> hsplit, v -> vsplit, t -> tab
" See netrw-browse-maps for details
	let g:netrw_banner       = 0                       " no banner
	let g:netrw_browse_split = 0                       " open in prev window
	let g:netrw_altv         = 1                       " split to right
	let g:netrw_liststyle    = 3                       " tree style view
	let g:netrw_list_hide    = netrw_gitignore#Hide()  " ignore gitignored
	let g:netrw_list_hide   .= ',\(^\|\s\s\)\zs\.\S\+' " ignore .git

" YouCompleteMe intergration
	let g:ycm_server_python_interpreter='/usr/bin/python2'
	let g:ycm_global_ycm_extra_conf='/home/drew/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'

	let g:multi_cursor_use_default_mapping=0

" lsp clangd intergration
"	if executable('clangd')
"		 au User lsp_setup call lsp#register_server({
"			  \ 'name': 'clangd',
"			  \ 'cmd': {server_info->['clangd']},
"			  \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'h', 'hpp'],
"			  \ })
"		 autocmd FileType c,cpp,objc,objcpp,h,hpp setlocal omnifunc=lsp#complete
"	endif
"	let g:lsp_signs_enabled = 1         " enable signs
"	let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode

" auto source vimrc files on save (but not if autosaving)
	if has("autocmd")
		if !exists("b:autosave") || b:autosave == 0
			autocmd! BufWritePost .vimrc,vimrc source %
		endif
	endif
