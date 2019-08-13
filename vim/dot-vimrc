 "__   _(_)_ _ __ ,_ __ ___
 "\ \ / / | '.` .\| '__) __)
  "\ V /| | || || | | ( (__
"(_)\_/ |_|_||_||_|_|  \___)
  " Drew O'Malley

" Load Pathogen for plugins:
	"execute pathogen#infect()
	"execute pathogen#helptags()

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

" Set the dictonary
	set dictionary=/usr/share/dict/words

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
	highlight NonText ctermfg=240 guifg=#303030
	highlight SpecialKey ctermfg=240 guifg=#303030
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

" Make Y yank till end of line, excluding linebrake, like D and C
	nnoremap Y yg_

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
	nnoremap <C-N> <ESC>:cnext<CR>
	nnoremap <C-P> <ESC>:cprevious<CR>

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

" file-type specific abbreviate macros
	autocmd FileType c,cpp,objc,objcpp,h,hpp,js iabbr ccom /*<cr>/<up>

" === Function keys ===
" Get line, word and character counts with F3:
	noremap <F3> :!wc <C-R>%<CR>

" Spell-check set to F6:
	noremap <F6> :setlocal spell! spelllang=en_gb<CR>

" build and run shortcuts
	set makeprg=clear\ &&\ bear\ make\ -j
	nnoremap <silent> <F5> <ESC>:wa<CR>:!make debugger<CR>
	nnoremap <silent> <F9> <ESC>:wa<CR>:make<CR><CR>
	nnoremap <silent> <F10> <ESC>:wa<CR>:make clean<CR><CR>
	"nnoremap <silent> <F11> :sp tags<CR>:%s/^\([^	:]*:\)\=\([^	]*\).*/syntax keyword Tag \2/<CR>:wq! tags.vim<CR>/^<CR><F12>
	"nnoremap <silent> <F12>  :so tags.vim<CR>

" Stop %f:%l:%m matching "make: *** [..." with gnu make
	set errorformat^=%-Gmake:\ ***%m
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
	let g:loaded_youcompleteme = 1



" Clang code-completion support. This is somewhat experimental!

" A path to a clang executable.
let g:clang_path = "clang++"

" A list of options to add to the clang commandline, for example to add
" include paths, predefined macros, and language options.
let g:clang_opts = [
  \ "-x","c++",
  \ "-D__STDC_LIMIT_MACROS=1","-D__STDC_CONSTANT_MACROS=1",
  \ "-Iinclude" ]

function! ClangComplete(findstart, base)
   if a:findstart == 1
      " In findstart mode, look for the beginning of the current identifier.
      let l:line = getline('.')
      let l:start = col('.') - 1
      while l:start > 0 && l:line[l:start - 1] =~ '\i'
         let l:start -= 1
      endwhile
      return l:start
   endif

   " Get the current line and column numbers.
   let l:l = line('.')
   let l:c = col('.')

   " Build a clang commandline to do code completion on stdin.
   let l:the_command = shellescape(g:clang_path) .
                     \ " -cc1 -code-completion-at=-:" . l:l . ":" . l:c
   for l:opt in g:clang_opts
      let l:the_command .= " " . shellescape(l:opt)
   endfor

   " Copy the contents of the current buffer into a string for stdin.
   " TODO: The extra space at the end is for working around clang's
   " apparent inability to do code completion at the very end of the
   " input.
   " TODO: Is it better to feed clang the entire file instead of truncating
   " it at the current line?
   let l:process_input = join(getline(1, l:l), "\n") . " "

   " Run it!
   let l:input_lines = split(system(l:the_command, l:process_input), "\n")

   " Parse the output.
   for l:input_line in l:input_lines
      " Vim's substring operator is annoyingly inconsistent with python's.
      if l:input_line[:11] == 'COMPLETION: '
         let l:value = l:input_line[12:]

        " Chop off anything after " : ", if present, and move it to the menu.
        let l:menu = ""
        let l:spacecolonspace = stridx(l:value, " : ")
        if l:spacecolonspace != -1
           let l:menu = l:value[l:spacecolonspace+3:]
           let l:value = l:value[:l:spacecolonspace-1]
        endif

        " Chop off " (Hidden)", if present, and move it to the menu.
        let l:hidden = stridx(l:value, " (Hidden)")
        if l:hidden != -1
           let l:menu .= " (Hidden)"
           let l:value = l:value[:l:hidden-1]
        endif

        " Handle "Pattern". TODO: Make clang less weird.
        if l:value == "Pattern"
           let l:value = l:menu
           let l:pound = stridx(l:value, "#")
           " Truncate the at the first [#, <#, or {#.
           if l:pound != -1
              let l:value = l:value[:l:pound-2]
           endif
        endif

         " Filter out results which don't match the base string.
         if a:base != ""
            if l:value[:strlen(a:base)-1] != a:base
               continue
            end
         endif

        " TODO: Don't dump the raw input into info, though it's nice for now.
        " TODO: The kind string?
        let l:item = {
          \ "word": l:value,
          \ "menu": l:menu,
          \ "info": l:input_line,
          \ "dup": 1 }

        " Report a result.
        if complete_add(l:item) == 0
           return []
        endif
        if complete_check()
           return []
        endif

      elseif l:input_line[:9] == "OVERLOAD: "
         " An overload candidate. Use a crazy hack to get vim to
         " display the results. TODO: Make this better.
         let l:value = l:input_line[10:]
         let l:item = {
           \ "word": " ",
           \ "menu": l:value,
           \ "info": l:input_line,
           \ "dup": 1}

        " Report a result.
        if complete_add(l:item) == 0
           return []
        endif
        if complete_check()
           return []
        endif

      endif
   endfor


   return []
endfunction ClangComplete

" This to enables the somewhat-experimental clang-based
" autocompletion support.
set omnifunc=ClangComplete
