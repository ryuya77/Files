
"------------------------------------------------------------
"ʸ�������ɴط�������
"------------------------------------------------------------

if &encoding !=# 'utf-8'
	set encoding=japan
	set fileencoding=japan
endif
if has('iconv')
	let s:enc_euc = 'euc-jp'
	let s:enc_jis = 'iso-2022-jp'
"iconv��eucJP-ms���б����Ƥ��뤫�����å�
	if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'eucjp-ms'
		let s:enc_jis = 'iso-2022-jp-3'
"iconv��JISX0213���б����Ƥ��뤫�����å�
	elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'euc-jisx0213'
		let s:enc_jis = 'iso-2022-jp-3'
	endif
"fileencodings����
	if &encoding ==# 'utf-8'
		let s:fileencodings_default = &fileencodings
		let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
		let &fileencodings = &fileencodings .','. s:fileencodings_default
		unlet s:fileencodings_default
	else
		let &fileencodings = &fileencodings .','. s:enc_jis
		set fileencodings+=utf-8,ucs-2le,ucs-2
		if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
			set fileencodings+=cp932
			set fileencodings-=euc-jp
			set fileencodings-=euc-jisx0213
			set fileencodings-=eucjp-ms
			let &encoding = s:enc_euc
			let &fileencoding = s:enc_euc
		else
			let &fileencodings = &fileencodings .','. s:enc_euc
		endif
	endif
"������ʬ
	unlet s:enc_euc
	unlet s:enc_jis
endif
"���ܸ��ޤޤʤ�����fileencoding��encoding��Ȥ�
if has('autocmd')
	function! AU_ReCheck_FENC()
		if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
			let &fileencoding=&encoding
		endif
	endfunction
	autocmd BufReadPost * call AU_ReCheck_FENC()
endif
"���ԥ����ɤμ�ưǧ��
set fileformats=unix,dos,mac
"���Ȥ�����ʸ���ǥ������뤬����ʤ��褦�ˤ���
if exists('&ambiwidth')
	set ambiwidth=double
endif


"------------------------------------------------------------
"�Խ��ط�������
"------------------------------------------------------------
"�����ȥ���ǥ��
set autoindent

"�Хåե�����¸����¾�ΥХåե���ɽ��
set hidden

"���ޥ�ɥ饤����䴰
set wildmenu

"�Х��ʥ��Խ��⡼��(vim -b �Ǥε�ư)
augroup BinaryXXD
	autocmd!
	autocmd BufReadPre  *.bin let &binary =1
	autocmd BufReadPost * if &binary | silent %!xxd -g 1
	autocmd BufReadPost * set ft=xxd | endif
	autocmd BufWritePre * if &binary | %!xxd -r | endif
	autocmd BufWritePost * if &binary | silent %!xxd -g 1
	autocmd BufWritePost * set nomod | endif
augroup END


"------------------------------------------------------------
"�����ط�������
"------------------------------------------------------------
"����ʸ���󤬾�ʸ���ξ�硢��ʸ����ʸ������̤ʤ�����
set ignorecase

"����ʸ�������ʸ�����ޤޤ�Ƥ����硢���̤��Ƹ���
set smartcase

"�������˺Ǹ�ޤǹԤä���ǽ�����
set wrapscan

"����ʸ�������ϻ��˽缡�о�ʸ�����ҥåȤ����ʤ�
set noincsearch


"------------------------------------------------------------
"�����ط�
"------------------------------------------------------------
"���顼�������ޤ�����
"colorscheme wombat
colorscheme desert

"���󥿥å����ϥ��饤�Ȥ�ͭ��
if has("syntax")
	syntax on
endif

"���ֹ��ɽ��
set number

"���֤κ�¦�˥�������ɽ��
set listchars=tab:\ \ 
set list

"������������
set tabstop=4
set shiftwidth=4

"������Υ��ޥ�ɤ򥹥ơ�������ɽ��
set showcmd

"������ϻ����б�������ɽ��
set showmatch

"�������ʸ����Υϥ��饤�Ȥ�ͭ��
set hlsearch

"�������ȥ饤�����ɽ��
set laststatus=2

"���ơ������饤���ʸ�������ɤȲ��Ԥ�ɽ��
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set statusline=%f%=%<%m%r[%{(&fenc!=''?&fenc:&enc)}][%{&ff}][%Y][%v,%l/%L]


"------------------------------------------------------------
"�ޥåԥ�
"------------------------------------------------------------
"�����ޥå�
"	F2�����ΥХåե�
"	F3�����ΥХåե�
"	F4���Хåե����
map <F2> <ESC>:bp<CR>
map <F3> <ESC>:bn<CR>
map <F4> <ESC>:bw<CR>

"ɽ��ñ�̤ǹ԰�ư
nnoremap j gj
nnoremap k gk

"�ե졼�ॵ�������ѹ�
map <kPlus> <C-W>+
map <kMinus> <C-W>-


"------------------------------------------------------------
"buftabs.vim
"------------------------------------------------------------

if filereadable(expand('~/.vim/plugin/buftabs.vim'))
    let g:buftabs_only_basename=1
	" �Хåե����֤򥹥ơ������饤�����ɽ������
	let g:buftabs_in_statusline=1
	" ���ߤΥХåե���ϥ��饤��
	let g:buftabs_active_highlight_group="Visual"
	"let g:buftabs_separator = " "
	"let g:buftabs_marker_start = ""
	"let g:buftabs_marker_end = ""
	let g:buftabs_marker_modified = "+"
endif


"------------------------------------------------------------
"neocomplcache
"------------------------------------------------------------
"neocomplcache��ͭ���ˤ���
let g:neocomplcache_enable_at_startup = 1

"Sample������
	"Note: This option must set it in .vimrc(_vimrc). NOT IN .gvimrc(_gvimrc)!
	" Disable AutoComplPop.
	let g:acp_enableAtStartup = 0
	" Use neocomplcache.
	let g:neocomplcache_enable_at_startup = 1
	" Use smartcase.
	let g:neocomplcache_enable_smart_case = 1
	" Set minimum syntax keyword length.
	let g:neocomplcache_min_syntax_length = 3
	let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

	" Enable heavy features.
	" Use camel case completion.
	"let g:neocomplcache_enable_camel_case_completion = 1
	" Use underbar completion.
	"let g:neocomplcache_enable_underbar_completion = 1

	" Define dictionary.
	let g:neocomplcache_dictionary_filetype_lists = {
	    \ 'default' : '',
	    \ 'vimshell' : $HOME.'/.vimshell_hist',
	    \ 'scheme' : $HOME.'/.gosh_completions'
	        \ }

	" Define keyword.
	if !exists('g:neocomplcache_keyword_patterns')
	    let g:neocomplcache_keyword_patterns = {}
	endif
	let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

	" Plugin key-mappings.
	inoremap <expr><C-g>     neocomplcache#undo_completion()
	inoremap <expr><C-l>     neocomplcache#complete_common_string()

	" Recommended key-mappings.
	" <CR>: close popup and save indent.
	inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	function! s:my_cr_function()
	  return neocomplcache#smart_close_popup() . "\<CR>"
	  " For no inserting <CR> key.
	  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
	endfunction
	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><C-y>  neocomplcache#close_popup()
	inoremap <expr><C-e>  neocomplcache#cancel_popup()

	" For cursor moving in insert mode(Not recommended)
	"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
	"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
	"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
	"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
	" Or set this.
	"let g:neocomplcache_enable_cursor_hold_i = 1
	" Or set this.
	"let g:neocomplcache_enable_insert_char_pre = 1

	" AutoComplPop like behavior.
	"let g:neocomplcache_enable_auto_select = 1

	" Shell like behavior(not recommended).
	"set completeopt+=longest
	"let g:neocomplcache_enable_auto_select = 1
	"let g:neocomplcache_disable_auto_complete = 1
	"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

	" Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

	" Enable heavy omni completion.
	if !exists('g:neocomplcache_omni_patterns')
	  let g:neocomplcache_omni_patterns = {}
	endif
	let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
	"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
	let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
	let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
	let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

	" For perlomni.vim setting.
	" https://github.com/c9s/perlomni.vim
	let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'



