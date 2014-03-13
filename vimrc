" Modeline and Notes {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
"   This is the personal .vimrc file of Walter Di Carlo 
"   derived from the one of Steve Francia.
"
"   See more information about Steve Francia project at http://spf13.com
" }

" Environment {
    " Basics {
        set nocompatible        " must be first line
        set background=dark     " Assume a dark background
        ":silent! redir @p
        ":pwd
        ":redir END
        let g:vim_started_from_path=getcwd()
        set path=$PWD
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if has('win32') || has('win64')
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }
    "
    " Setup Bundle Support {
    " The next two lines ensure that the ~/.vim/bundle/ system works
        set rtp+=~/.vim/bundle/vundle
        call vundle#rc()
    " }

" }

" Bundles {
    " Brief help
    " :BundleList          - list configured bundles
    " :BundleInstall(!)    - install(update) bundles
    " :BundleSearch(!) foo - search(or refresh cache first) for foo
    " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
    "
    " see :h vundle for more details or wiki for FAQ
    " NOTE: comments after Bundle command are not allowed..
    " Deps
        Bundle 'gmarik/vundle'
        Bundle 'MarcWeber/vim-addon-mw-utils'
        Bundle 'tomtom/tlib_vim'
        if executable('ack')
            Bundle 'mileszs/ack.vim'
        endif

    " Use local bundles if available {
        if filereadable(expand("~/.vimrc.bundles.local"))
            source ~/.vimrc.bundles.local
        endif
    " }

    " In your .vimrc.bundles.local file"
    " list only the plugin groups you will use
    if !exists('g:wdc_bundle_groups')
        let g:wdc_bundle_groups=['general', 'programming', 'misc']
    endif

    " To override all the included bundles, put
    " g:override_spf13_bundles = 1
    " in your .vimrc.bundles.local file"
    if !exists("g:override_spf13_bundles")

    " General
        if count(g:wdc_bundle_groups, 'general')
            Bundle 'scrooloose/nerdtree'
            Bundle 'altercation/vim-colors-solarized'
            Bundle 'spf13/vim-colors'
            Bundle 'tpope/vim-surround'
            Bundle 'tpope/vim-markdown'
            Bundle 'AutoClose'
            Bundle 'kien/ctrlp.vim'
            Bundle 'vim-scripts/sessionman.vim'
            Bundle 'matchit.zip'
            "Bundle 'Lokaltog/vim-powerline'
            Bundle 'bling/vim-airline'
            Bundle 'Lokaltog/vim-easymotion'
            "Bundle 'godlygeek/csapprox'
            Bundle 'jistr/vim-nerdtree-tabs'
            Bundle 'flazz/vim-colorschemes'
            "Bundle 'corntrace/bufexplorer'

            Bundle 'L9'
            Bundle 'FuzzyFinder'
            "Bundle 'VimOutliner'
            "Bundle 'vimoutliner-colorscheme-fix'
            Bundle 'vimoutliner/vimoutliner'
            Bundle 'vim-indent-object'
            Bundle 'project.tar.gz'
            Bundle 'AsyncCommand'



            Bundle 'wdicarlo/vim-notebook'
        endif

    " General Programming
        if count(g:wdc_bundle_groups, 'programming')
            " Pick one of the checksyntax, jslint, or syntastic
            Bundle 'scrooloose/syntastic'
            Bundle 'garbas/vim-snipmate'
            Bundle 'spf13/snipmate-snippets'
            " Source support_function.vim to support snipmate-snippets.
            if filereadable(expand("~/.vim/bundle/snipmate-snippets/snippets/support_functions.vim"))
                source ~/.vim/bundle/snipmate-snippets/snippets/support_functions.vim
            endif

            Bundle 'tpope/vim-fugitive'
            Bundle 'scrooloose/nerdcommenter'
            Bundle 'godlygeek/tabular'
            if executable('ctags')
                Bundle 'majutsushi/tagbar'
            endif
            Bundle 'Shougo/neocomplcache'
            Bundle 'c.vim'
            "Bundle 'cscope_plus.vim'
            Bundle 'cscope.vim'
            Bundle 'CCTree'
        endif

    " Misc
        if count(g:wdc_bundle_groups, 'misc')
            Bundle 'spf13/vim-markdown'
            Bundle 'spf13/vim-preview'
            Bundle 'tpope/vim-cucumber'
        endif
    endif
" }

" General {
    set background=dark         " Assume a dark background
    if !has('gui')
        "set term=$TERM          " Make arrow and other keys work
    endif
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " syntax highlighting
    set mouse=a                 " automatically enable mouse usage
    scriptencoding utf-8
    if has("autocmd")
      " always switch to the current file directory.
      autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

      " In text files, always limit the width of text to 78 characters
      autocmd BufRead *.txt set tw=78

      " When editing a file, always jump to the last cursor position
      autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif

    endif

    " set autowrite                  " automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
    set virtualedit=onemore         " allow for cursor beyond last character
    set history=1000                " Store a ton of history (default is 20)
    set spell                       " spell checking on
    set hidden                      " allow buffer switching without saving
    set diffopt+=iwhite             " ignore spaces

    " cscope {
      set cscopeprg=cscope
      set cst
      set csto=0 " cscope DB first then tag file
      set cspc=1 " display last 3 compoenents of the file's path
      set cscopetag
      "set cscopequickfix=s-,c-,d-,i-,t-,e-
      ""if filereadable("cscope.out")
      ""    exec "cs add cscope.out"
      ""endif
    " }
    
    " Setting up the directories {
        set backup                      " backups are nice ...
        if has('persistent_undo')
            set undofile                "so is persistent undo ...
            set undolevels=1000         "maximum number of changes that can be undone
            set undoreload=10000        "maximum number lines to save for undo on a buffer reload
        endif
        " Could use * rather than *.*, but I prefer to leave .files unsaved
        au BufWinLeave *.* silent! mkview  "make vim save view (state) (folds, cursor, etc)
        au BufWinEnter *.* silent! loadview "make vim load view (state) (folds, cursor, etc)
    " }
" }

" Vim UI {
    set tabpagemax=15               " only show 15 tabs
    set showmode                    " display the current mode

    set cursorline                  " highlight current line

    if has('cmdline_info')
        set ruler                   " show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
        set showcmd                 " show partial commands in status line and
                                    " selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\    " Filename
        set statusline+=%w%h%m%r " Options
        if filereadable(expand("~/.vim/bundle/vim-fugitive"))
            set statusline+=%{fugitive#statusline()} "  Git Hotness
        endif
        set statusline+=\ [%{&ff}/%Y]            " filetype
        set statusline+=\ [%{getcwd()}]          " current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set nu                          " Line numbers on
    set showmatch                   " show matching brackets/parenthesis
    set incsearch                   " find as you type search
    set hlsearch                    " highlight search terms
    set winminheight=0              " windows can be 0 line high
    set ignorecase                  " case insensitive search
    set smartcase                   " case sensitive when uc present
    set wildmenu                    " show list instead of just completing
    set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
    set scrolljump=5                " lines to scroll when cursor leaves screen
    set scrolloff=3                 " minimum lines to keep above and below cursor
    set foldenable                  " auto fold code
    set list
    set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace

    " open new window at right or below the current one
    set splitright
    set splitbelow 


" }

" Formatting {
    set nowrap                      " wrap long lines
    set autoindent                  " indent at the same level of the previous line
    set shiftwidth=4                " use indents of 4 spaces
    set expandtab                   " tabs are spaces, not tabs
    set tabstop=4                   " an indentation every four columns
    set softtabstop=4               " let backspace delete indent
    "set matchpairs+=<:>                " match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
" }

" Key (re)Mappings {

    "The default leader is '\', but many people prefer ',' as it's in a standard
    "location
    let mapleader = '\'

    " Making it so ; works like : for commands. Saves typing and eliminates :W style typos due to lazy holding shift.
    nnoremap ; :

    " Go backward/forward
    nmap <a-left> :normal! <c-o><cr>
    nmap <a-right> :normal! <c-i><cr>

    " Easier moving in tabs and windows
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_

    nmap <C-t><up> :tabnew<CR>
    nmap <C-t><down> :tabclose<CR>
    nmap <C-t><right> :tabnext<CR>
    nmap <C-t><left> :tabprev<CR>
    nmap <C-t>n :tabnew<CR>
    nmap <c-t>q :windo exec "bd"<cr>
    nmap <c-t>qq :windo exec "bd!"<cr>
    nmap <tab> :tabnext<cr>
    nmap <s-tab> :tabprev<cr>

    " The following maps help with window resizing...
    nmap <C-up> <C-w>+
    nmap <C-down> <C-w>-
    nmap <C-left> <C-w><
    nmap <C-right> <C-w>>

    " scroll without moving the cursor
    nmap <s-j> <c-e>j
    nmap <s-k> <c-y>k

    " Wrapped lines goes down/up to next row, rather than next line in file.
    nnoremap j gj
    nnoremap k gk

    " The following two lines conflict with moving to top and bottom of the
    " screen
    " If you prefer that functionality, comment them out.
    map <S-H> gT
    map <S-L> gt

    " Stupid shift key fixes
    "map W w
    cmap WQ wq
    cmap wQ wq
    cmap WQ wq
    cmap Wq wq
    cmap Wqa wqa
    cmap Qa qa
    cmap qA qa
    cmap QA qa
    "cmap Q q
    cmap Tabe tabe

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    """ Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    "clearing highlighted search
    nmap <silent> <leader>/ :nohlsearch<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Fix home and end keybindings for screen, particularly on mac
    " - for some reason this fixes the arrow keys too. huh.
    map [F $
    imap [F $
    map [H g0
    imap [H g0

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=expand('%:h').'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Easier horizontal scrolling
    map zl zL
    map zh zH
    
    " Multi line tab indentation
    vmap <TAB> :><cr>gv
    vmap <S-TAB> :<<cr>gv

    " Edit vim files
    nmap <c-e>v :tabnew ~/.vimrc<CR>
    nmap <c-e>i :tabnew ~/.viminfo<CR>
    nmap <c-e>e :tabnew ~/.vim/doc/vim_tips.txt<CR>
    nmap <c-e>p :tabnew ~/.vim/bundle<CR>

    " Key maps to force cursor to center the selected line
    nmap <c-]> <c-]>zz
    nmap <c-t> <c-t>zz
    nmap <c-\>c <c-\>czz
    nmap [[ [[zz
    nmap ]] ]]zz
    nmap n nzzzO
    nmap N NzzzO

    " delete all duplicated lines
    :nno <leader>d2 :g/^/kl\|if search('^'.escape(getline('.'),'\.*[]^$/').'$','bW')\|'ld<CR>

    " grep 
    nmap g* :exec ":Shell grep -C 2 -rni ".expand("<cword>")." ".&path."/\\\*"<cr>
    nmap g** :call <SID>GrepProjectPaths(expand("<cword>"),0)<cr>
    nmap G** :call <SID>GrepProjectPaths(expand("<cword>"),1)<cr>
    nmap cd :exec ":cd ".&path<cr>

    nmap Gf <c-w><c-f>
    command! -bang -nargs=0 Q exec ":q"
    command! -bang -nargs=0 Wq exec ":wq"
" }

" Plugins {

    " PIV {
        let g:DisableAutoPHPFolding = 0
        let g:PIVAutoClose = 0
    " }

    " Misc {
        let g:NERDShutUp=1
        let b:match_ignorecase = 1
        let g:nerdtree_tabs_open_on_gui_startup = 0
    " }

    " OmniComplete {
        if has("autocmd") && exists("+omnifunc")
            autocmd Filetype *
                \if &omnifunc == "" |
                \setlocal omnifunc=syntaxcomplete#Complete |
                \endif
        endif

        hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

        " some convenient mappings
        inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
        inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
        inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
        inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

        " automatically open and close the popup menu / preview window
        au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        set completeopt=menu,preview,longest
    " }

    " Ctags {
        set tags=./tags;/,~/.vimtags
    " }

    " AutoCloseTag {
        " Make it so AutoCloseTag works for xml and xhtml files as well
        au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
        nmap <Leader>ac <Plug>ToggleAutoCloseMappings
    " }

    " SnipMate {
        " Setting the author var
        " If forking, please overwrite in your .vimrc.local file
        let g:snips_author = 'Steve Francia <steve.francia@gmail.com>'
    " }

    " NerdTree {
        map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
        map <leader>e :NERDTreeFind<CR>
        nmap <leader>nt :NERDTreeFind<CR>

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
    " }

    " Tabularize {
        if exists(":Tabularize")
          nmap <Leader>a= :Tabularize /=<CR>
          vmap <Leader>a= :Tabularize /=<CR>
          nmap <Leader>a: :Tabularize /:<CR>
          vmap <Leader>a: :Tabularize /:<CR>
          nmap <Leader>a:: :Tabularize /:\zs<CR>
          vmap <Leader>a:: :Tabularize /:\zs<CR>
          nmap <Leader>a, :Tabularize /,<CR>
          vmap <Leader>a, :Tabularize /,<CR>
          nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
          vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

          " The following function automatically aligns when typing a
          " supported character
          inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

          function! s:align()
              let p = '^\s*|\s.*\s|\s*$'
              if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
                  let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
                  let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
                  Tabularize/|/l1
                  normal! 0
                  call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
              endif
          endfunction

        endif
     " }

     " Session List {
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        nmap <leader>sl :SessionList<CR>
        nmap <leader>ss :SessionSave<CR>
     " }

     " Buffer explorer {
     "   nmap <leader>b :BufExplorer<CR>
     " }

     " Powerline {
        let g:Powerline_symbols = 'fancy'
     " }

     " ctrlp {
        let g:ctrlp_working_path_mode = 2
        nnoremap <silent> <D-t> :CtrlP<CR>
        nnoremap <silent> <D-r> :CtrlPMRU<CR>
        let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$' }
     "}

     " TagBar {
        nnoremap <silent> <c-\>tt :TagbarToggle<CR>
     "}

      " TagList {
        let Tlist_Auto_Open = 0
        let Tlist_Compact_Format = 1
        let Tlist_File_Fold_Auto_Close = 1
        let Tlist_Exit_OnlyWindow = 1
        let Tlist_WinWidth = 40
        if has("unix") 
          let Tlist_Ctags_Cmd = "/usr/bin/ctags"
        endif
      " }

     " Fugitive {
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
     "}

     " neocomplcache {
        let g:neocomplcache_enable_at_startup = 1
        let g:neocomplcache_enable_camel_case_completion = 1
        let g:neocomplcache_enable_smart_case = 1
        let g:neocomplcache_enable_underbar_completion = 1
        let g:neocomplcache_min_syntax_length = 3
        let g:neocomplcache_enable_auto_delimiter = 1

        " AutoComplPop like behavior.
        let g:neocomplcache_enable_auto_select = 0

        " SuperTab like snippets behavior.
        imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

        " Plugin key-mappings.
        imap <C-k>     <Plug>(neocomplcache_snippets_expand)
        smap <C-k>     <Plug>(neocomplcache_snippets_expand)
        inoremap <expr><C-g>     neocomplcache#undo_completion()
        inoremap <expr><C-l>     neocomplcache#complete_common_string()


        " <CR>: close popup
        " <s-CR>: close popup and save indent.
        inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "\<CR>"
        inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup() "\<CR>" : "\<CR>"
        " <TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y>  neocomplcache#close_popup()
        inoremap <expr><C-e>  neocomplcache#cancel_popup()

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
        let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
        let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

        " For snippet_complete marker.
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif

     " }

    " c support {
      let g:C_AuthorName      = 'W. Di Carlo'
      let g:C_AuthorRef       = ''
      let g:C_Email           = 'walter.dicarlo@di-carlo.it'
      let g:C_Company         = 'Walter Di Carlo'
    " }

    " VimOutline {
      if has("autocmd")
        autocmd BufRead *.otl
                    \ set filetype=vo_base |
        \ nmap <c-o>t :let @/ = '^\s*\[_\]'<CR> :exe "normal! n"<CR>    |
        \ nmap <c-o>T :let @/ = '^\s*\[X\]'<CR> :exe "normal! n"<CR>    |
        \ nmap <c-o>q :let @/ = '^\s*\[_\].*?'<CR> :exe "normal! n"<CR> |
        \ nmap <c-o>Q :let @/ = '^\s*\[X\].*?'<CR> :exe "normal! n"<CR> |
        \ nmap <c-o>r :let @/ = ' #r='<cr> :exe "normal! n"<cr>         |
        \ nmap <c-o>R :let @/ = ' #r='<cr> :exe "normal! N"<cr>         
      endif
    " }
    
    " Project {
    " let g:proj_flags="imst"
    let g:proj_flags="imstcgv"
    let g:proj_run1='Project $f'
    " }
    
    " Savever {
    " savever.vim settings
    "    
    "
    "    savevers_types     - This is a comma-separated list of filename
    "                         patterns.  Sets the types of files that
    "                         will have numbered versions.
    "                         Defaults to "*" (all files).
    "
    "    savevers_max       - Sets the maximum patchmode version.
    "                         Defaults to "9999".
    "
    "    savevers_purge     - Sets default value of [N] for the :Purge command
    "                         Defaults to "1".
    "
    "    savevers_dirs      - This is a comma-separated list of directories
    "                         that will be tried to store the patchmode files.
    "                         The first writable directory in this list is used.
    "                         This works much like the vim 'backupdir' option.
    "                         To set this to the same as 'backupdir', do
    "                            :let savevers_dirs = &backupdir
    "                         Defaults to '.', which puts all patchmode files
    "                         in the same directory as the original file.
    "
    "    versdiff_no_resize - Disables window resizing during ":VersDiff"
    "
    "    versdiff_max_cols  - Limits window resizing during ":VersDiff"
    "
    "    So, for example, if the user has in ~/.vimrc:
    "       let savevers_types = "*.c,*.h,*.vim"
    "       let savevers_max = 99
    "       let savevers_purge = 0
    "    then only "*.c", "*.h", and "*.vim" files will be numbered,
    "    and there will be a maximum of 99 versions saved.
    "    Also, the ":Purge" command will purge all numbered versions
    "    (instead of the default, which is to delete all but the oldest).
    "
    " HINTS:
    "    If you use GNU 'ls', then try adding "-I'*.clean'" (without the
    "    double quotes) to your 'ls' alias (assuming &patchmode==.clean)
    "
    "    It's also helpful to have the patchmode value in the backupskip,
    "    suffixes, and wildignore vim options:
    "
    "       :exe "set backupskip+=*" . &patchmode
    "       :exe "set suffixes+=" . &patchmode
    "       :exe "set wildignore+=*" . &patchmode
    "
    "    Also, here are some nice mappings that allow quick comparison
    "    of the current file with previous versions.  Pressing <F5>
    "    successively shows the diff with older versions.
    "
    "       " <F5> decrease version viewed in VersDiff window
    "       " <F6> increase version viewed in VersDiff window
    "       " <F7> do VersDiff with cvs version of current file
    "       " <F8> cancel VersDiff window
    " nmap <silent> <c-d>- :VersDiff -<cr>
    " nmap <silent> <c-d>+ :VersDiff +<cr>
    " " nmap <silent> <F7> :VersDiff -cvs<cr>
    " nmap <silent> <c-d>x :VersDiff -c<cr>
    "
    " -----------------------------------------------------------
    "
    " "set backupdir=~/backups/text/
    " set backupdir=.
    " set backup
    " set patchmode=.sav
    " let savevers_types = "*.txt,*.tst,*.lst,*.vim,*.otl,*.ini,.vimrc,*.c,*.h,*.hpp,*.cpp"
    " let savevers_dirs = &backupdir
    " } 

    " Solarize {
    if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
        color solarized                 " load a colorscheme
        let g:solarized_termtrans=1
        let g:solarized_termcolors=256
        let g:solarized_contrast="high"
        let g:solarized_visibility = "low"  " normal, low, high"
    endif
    " }

    " AsyncCommand {"  
      if filereadable("cscope.out")
        let g:cscope_database = "cscope.out"
        let g:cscope_relative_path = "."
      endif
    " }
" }

" GUI Settings {
    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T           " remove the toolbar
        set guioptions-=m           " remove menu bar
        set guioptions-=r           " remove right-hand scroll bar
        set lines=40                " 40 lines of text instead of 24,
        if has("gui_gtk2")
            set guifont=Andale\ Mono\ Regular\ 16,Menlo\ Regular\ 15,Consolas\ Regular\ 16,Courier\ New\ Regular\ 18
        else
            set guifont=Andale\ Mono\ Regular:h16,Menlo\ Regular:h15,Consolas\ Regular:h16,Courier\ New\ Regular:h18
        endif
        if has('gui_macvim')
            set transparency=5          " Make the window slightly transparent
        endif
    else
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256                 " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
            " " use an orange cursor in insert mode
            " let &t_SI = "\<Esc>]12;orange\x7"
            " " use a red cursor otherwise
            " let &t_EI = "\<Esc>]12;red\x7"
            " silent !echo -ne "\033]12;red\007"
            " " reset cursor when vim exits
            " autocmd VimLeave * silent !echo -ne "\033]112\007"
            " " use \003]12;gray\007 for gnome-terminal
            " " solid underscore
            " let &t_SI .= "\<Esc>[4 q"
            " " solid block
            " let &t_EI .= "\<Esc>[1 q"
            " " 1 or 0 -> blinking block
            " " 3 -> blinking underscore
        endif
        "set term=builtin_ansi       " Make arrow and other keys work
    endif
" }

" Functions {
    " Initialization {
    function! InitializeDirectories()
      let separator = "."
      let parent = $HOME
      let prefix = '.vim'
      let dir_list = {
            \ 'backup': 'backupdir',
            \ 'views': 'viewdir',
            \ 'swap': 'directory' }

      if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
      endif

      for [dirname, settingname] in items(dir_list)
        let directory = parent . '/' . prefix . dirname . "/"
        if exists("*mkdir")
          if !isdirectory(directory)
            call mkdir(directory)
          endif
        endif
        if !isdirectory(directory)
          echo "Warning: Unable to create backup directory: " . directory
          echo "Try: mkdir -p " . directory
        else
          let directory = substitute(directory, " ", "\\\\ ", "g")
          exec "set " . settingname . "=" . directory
        endif
      endfor
    endfunction
    call InitializeDirectories()
    " }

    " Grep {
        " TODO: create the plugin  ProjectGrep
        " ProjectGrep features:
        " * each grep is stored a different file
        " * load executed grep
        " * use g:grep_path global variable
        " * display result in a new window or tab
        " * commands to refresh the file or to repeat the grep
        " * use TailBundle to refresh the result file
        " * use relative paths
        function! s:GrepProjectPaths(pattern,mode)
            let patt=EscapeString(a:pattern)
            exec ":silent !echo > ~/temp.txt&"
            for p in g:grep_path
                let gp=&path."/".p
                let cmd =   ":silent !find ".gp." -type f -name \"\*\.[chS]\" \| xargs -n1 -I@ grep -iHn --color ".patt." @ \>\> ~\/temp.txt\&"
                exec ":silent !find ".gp." -type f -name \"\*\.[chS]\" | xargs -n1 -I@ grep -iHn --color ".patt." @ >> ~/temp.txt&"
            endfor
            redraw!
            if a:mode==0
                new ~/temp.txt
            else
                tabnew ~/temp.txt
            endif
            sleep 1
            exec ":setlocal autoread"
            "call search(patt)
            call matchadd('Search', patt)
            let @/="".patt
            normal! ggn
        endfunction
        command! -nargs=1 GrepProject call <SID>GrepProjectPaths('<args>',0)
    "}

    " NERDTree {
    function! NERDTreeInitAsNeeded()
      redir => bufoutput
      buffers!
      redir END
      let idx = stridx(bufoutput, "NERD_tree")
      if idx > -1
        NERDTreeMirror
        NERDTreeFind
        wincmd l
      endif
    endfunction
    " }

    " Search {
    " Escape special characters in a string for exact matching.
    " This is useful to copying strings from the file to the search tool
    " Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
    function! EscapeString (string)
      let string=a:string
      " Escape regex characters
      let string = escape(string, '^$.*\/~[]')
      " Escape the line endings
      let string = substitute(string, '\n', '\\n', 'g')
      return string
    endfunction

    " Get the current visual block for search and replaces
    " This function passed the visual block through a string escape function
    " Based on this - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
    function! GetVisual() range
      " Save the current register and clipboard
      let reg_save = getreg('"')
      let regtype_save = getregtype('"')
      let cb_save = &clipboard
      set clipboard&

      " Put the current visual selection in the " register
      normal! ""gvy
      let selection = getreg('"')

      " Put the saved registers and clipboards back
      call setreg('"', reg_save, regtype_save)
      let &clipboard = cb_save

      "Escape any special characters in the selection
      let escaped_selection = EscapeString(selection)

      return escaped_selection
    endfunction

    " Start the find and replace command across the entire file
    " vmap <leader>r <Esc>:%s/<c-r>=GetVisual()<cr>/
    " vmap <leader>g <Esc>:g/<c-r>=GetVisual()<cr><cr>
    vmap <c-f>r <Esc>:%s/<c-r>=GetVisual()<cr>/
    vmap <c-f>s <Esc>:g/<c-r>=GetVisual()<cr><cr>
    vmap <c-f>sl <Esc>:exec ":lvimgrep /".GetVisual()."/ %"<cr> :lopen<cr>
    vmap <c-f>p <Esc>:exec ":Shell find . \| grep ".GetVisual()<cr>
    nmap <c-f>p :exec ":Shell find . \| grep ".expand("<cword>")." \| grep -v \".svn\""<cr>
    nmap <c-f>s :exec ":g/".expand("<cword>")<cr>
    nmap <c-f>sl :exec ":lvimgrep /".expand("<cword>")."/ %"<cr> :lopen<cr>
    nmap <c-f>/ :exec ":g/".@/<cr>
    nmap <c-f>// :bufdo exec ":g/\.".@/<cr>
    " }

    " Highlithing {
    function! AddTextToHL (text,reset) 
      if a:reset == 1
        let @/=""
      endif

      if @/ != ""
        :let @/ = @/."\\|".a:text
      else
        :let @/ = a:text
      endif
    endfunction
    nmap + :call AddTextToHL ( expand("<cword>"), 0 )<cr>
    vmap + :call AddTextToHL ( GetVisual(), 0 )<cr>

    function! RemoveTextFromHL (text)
      let @/ = substitute( @/, a:text."\\\\|", "", "" )
      let @/ = substitute( @/, "\\\\|".a:text, "", "" )
      let @/ = substitute( @/, a:text, "", "" )
    endfunction
    nmap - :call RemoveTextFromHL ( expand("<cword>") )<CR>
    vmap - :call RemoveTextFromHL ( GetVisual() )<CR>

    nmap _ :let @/=""<CR>

    " Redirect all lines matching the last search pattern into a new buffer
    function! NewTabWithGlobalOfHL(all)
      " clear register a
      let @g = @_
      :redir @g
      if a:all == 0 
        exec "silent! :g/".@/
      else
        exec "silent! :bufdo exec \":g/\.".@/."\""
      endif
      :redir END
      :tabnew
      silent :put! g
      silent :%s/^\d\+
      set nomodified
      set readonly
      silent normal! gg
    endfunction
    "nmap <c-t>f :redir @a<CR>:g//<CR>:redir END<CR>:tabnew<CR>:put! a<CR>:%s/^\d\+//<CR><CR>
    nmap <c-t>/ :call NewTabWithGlobalOfHL(0)<cr>
    nmap <c-t>// :call NewTabWithGlobalOfHL(1)<cr>
    " }
    
    " Clipboard { 
    "<Ctrl-X> -- cut (goto visual mode and cut)
    " imap <C-X> <C-O>vgG
    " <C-X> "*x<Esc>i

    "<Ctrl-C> -- copy (goto visual mode and copy)
    " imap <C-C> <C-O>vgG
    " vmap <C-C> "*y<Esc>i

    "<Ctrl-A> -- copy all
    " imap <C-A> <C-O>gg<C-O>gH<C-O>G<Esc>
    " vmap <C-A> <ESC>gggH<C-O>G<Esc>i

    ""<Ctrl-V> -- paste
    " nm \\paste\\ "=@*.'xy'<CR>gPFx"_2x:echo<CR>
    " imap <C-V> x<Esc>\\paste\\"_s
    " vmap <C-V> "-cx<Esc>\\paste\\"_x


    " vmap <C-c> "*y
    " nmap <C-v> "*p
    " imap <C-v> <ESC>"*pa


    function! Getclip()
      let reg_save = @@
      let @@ = system('getclip')
      setlocal paste
      exe 'normal p'
      setlocal nopaste
      let @@ = reg_save
    endfunction


    function! Putclip(type, ...) range
      let sel_save = &selection
      let &selection = "inclusive"
      let reg_save = @@
      if a:type == 'n'
        silent exe a:firstline . "," . a:lastline . "y"
      elseif a:type == 'c'
        silent exe a:1 . "," . a:2 . "y"
      else
        silent exe "normal! `<" . a:type . "`>y"
      endif
      call system('putclip', @@)
      let &selection = sel_save
      let @@ = reg_save
    endfunction



    function! CutClip(type, ...) range
      let sel_save = &selection
      let &selection = "inclusive"
      let reg_save = @@

      if a:type == 'n'
        silent exe a:firstline . "," . a:lastline . "d"
      elseif a:type == 'c'
        silent exe a:1 . "," . a:2 . "d"
      else
        silent exe "normal! `<" . a:type . "`>d"
      endif
      call system('putclip', @@)

      let &selection = sel_save
      let @@ = reg_save
    endfunction

    vnoremap <silent> <leader>y :call Putclip(visualmode(), 1)<CR>
    nnoremap <silent> <leader>y :call Putclip('n', 1)<CR>
    nnoremap <silent> <leader>p :call Getclip()<CR>
    " Cut via \x in normal or visual mode.
    vnoremap <silent> <leader>x :call CutClip(visualmode(), 1)<CR>
    nnoremap <silent> <leader>x :call CutClip('n', 1)<CR>
    " }

    " Find {
    function! FindInput()
      let str = ":g/"
      let l:input = input(str)
      exec ":g/".l:input
    endfunction
    nmap <c-f> :call FindInput()<cr>

    function! FindAndReplaceWord() 
      let word = expand("<cword>")
      let cmdinput = "Replace word: ".word." with ? "
      let l:input = input(cmdinput)
      let cmd = ":%s:".word.":".l:input.":cg"
      :exe cmd
    endfunction

    nmap ;; :%s:::g<Left><Left><Left>
    vmap ;; <Esc>:%s:<c-r>=GetVisual()<cr>::cg<left><left><left>
    noremap ;w :call FindAndReplaceWord()<CR>
    noremap ;' :%s:::cg<Left><Left><Left><Left>
    " }

    " Shell {
    " Usage: :Shell ls -al
    " Only one window by command, if a window already exists for a command, it will be reused.
    " 
    " Possible to reexecute the command by typing <localleader>r in normal mode in a window opened by :Shell.
    " 
    " <localleader>g go to the previous window.
    " 
    " The command :Shell! reexecute the last command.
    " 
    " Last version available at https://svn.mageekbox.net/repositories/vim/trunk/.vimrc
    "

    " TODO: solve issue causing a crash of vim when using gf on a filename listed
    " in the generated buffer
    let s:_ = ''


    function! s:ExecuteInShell(command, bang)
      let _ = a:bang != '' ? s:_ : a:command == '' ? '' : join(map(split(a:command), 'expand(v:val)'))

      if (_ != '')
        let s:_ = _
        let bufnr = bufnr('%')
        let winnr = bufwinnr('^' . _ . '$')
        silent! execute  winnr < 0 ? 'new ' . fnameescape(_) : winnr . 'wincmd w'
        setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
        silent! :%d
        let message = 'Execute ' . _ . '...'
        call append(0, message)
        echo message
        silent! 2d | resize 1 | redraw
        silent! execute 'silent! %!'. _
        silent! execute 'resize ' . line('$')
        silent! execute 'syntax on'
        silent! execute 'autocmd BufUnload <buffer> execute bufwinnr(' . bufnr . ') . ''wincmd w'''
        silent! execute 'autocmd BufEnter <buffer> execute ''resize '' .  line(''$'')'
        silent! execute 'nnoremap <silent> <buffer> <CR> :call <SID>ExecuteInShell(''' . _ . ''', '''')<CR>'
        silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . _ . ''', '''')<CR>'
        silent! execute 'nnoremap <silent> <buffer> <LocalLeader>g :execute bufwinnr(' . bufnr . ') . ''wincmd w''<CR>'
        nnoremap <silent> <buffer> <C-W>_ :execute 'resize ' . line('$')<CR>
        silent! syntax on
      endif
    endfunction

    command! -complete=shellcmd -nargs=* -bang Shell call s:ExecuteInShell(<q-args>, '<bang>')
    cabbrev shell Shell


    " Alternative implementation
    :command! -nargs=* -complete=shellcmd Run new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>
    cabbrev run Run

    " Grep the visually selected text in the shell
    function! GrepSelectionInShell()
      " copy selection
      let selection= GetVisual()
      " build find command
      let cmd = 'grep -i --color "'.selection.'" '.expand("%").' | less -p "'.selection.'"'
      " execute command
      exec ":!".cmd
    endfunction
    vmap <c-g>g :call GrepSelectionInShell()<cr>

    " }
    
    " Files {
    " Create a scratch buffer with a list of files (full path names).
    " Argument is a specification like '*.c' to list *.c files (default is '*').
    " Can use '*.[ch]' to find *.c and *.h (see :help wildcard).
    " If command uses !, list includes matching files in all subdirectories.
    " If filespec contains a slash or backslash, the path in filespec is used;
    " otherwise, start searching in directory of current file.
    " Examples:
    " :Listfile                 " list all files in directory of current file
    " :Listfile!                " same, but also include subdirectories
    " :Listfile! *.c            " list all *.c files in tree of current file
    " :Listfile /my/path/*.c    " list *.c in given path
    " :Listfile! /my/path/*.c   " list *.c in given tree
    "
    "
    function! s:Listfiles(bang, filespec)
      if a:filespec =~ '[/\\]'  " if contains path separator (slash or backslash)
        let dir = fnamemodify(a:filespec, ':p:h')
        let fnm = fnamemodify(a:filespec, ':p:t')
      else
        let dir = expand('%:p:h')  " directory of current file
        let fnm = a:filespec
      endif
      if empty(fnm)
        let fnm = '*'
      endif
      if !empty(a:bang)
        let fnm = '**/' . fnm
      endif
      let files = filter(split(globpath(dir, fnm), '\n'), '!isdirectory(v:val)')
      echo 'dir=' dir ' fnm=' fnm ' len(files)=' len(files)
      if empty(files)
        echo 'No matching files'
        return
      endif
      new
      setlocal buftype=nofile bufhidden=hide noswapfile
      call append(line('$'), files)
      1d  " delete initial empty line
      " sort i  " sort, ignoring case
    endfunction
    command! -bang -nargs=? Listfiles call <SID>Listfiles('<bang>', '<args>')

    function! FileIncr(incr)
      let fn = expand("%:t")

      " TODO: generalize using pattern (\\d\\+\\_*)\\+ 
      " TODO: generalize sorting by pattern
      if match( fn, "\\d\\+") == -1
        echoerr "Filename without a number"
        return
      endif


      let curr = matchstr( fn, "\\d\\+" )
      let next = str2nr(curr) + a:incr
      if next < 0 
        return
      endif

      let nstr = printf("%03s",next)

      let path = expand("%:p:h")
      let filename = substitute(fn, "\\d\\+", nstr, "")
      let file = path."/".filename
      if !filereadable(file) 
        return
      endif 
      let nr = bufnr("%")
      exec ":e ".file
      exec ":bd! ".nr
    endfunction
    " TODO: activate only when filename contains a number
    nmap fn :call FileIncr(1)<cr>
    nmap fp :call FileIncr(-1)<cr>
    " }
    
    " Scroll bind {
    function! WinScrollBind()
      if &scrollbind
        silent exec ":windo set noscrollbind"
        echon "scrollbind off"
      else
        silent exec ":windo set scrollbind"
        echon "scrollbind on"
      endif
    endfunction
    nmap <c-w>sb :call WinScrollBind()<cr>
    " }
    
    " Jump to {
    function! JumpTo()
      :redir! @j
      :silent jumps
      :redir END
      let jumps = split(@j,"\\n")
      let i = 0
      let list = []
      for jump in jumps
        let list = add(list,"".i." ".jump)
        let i = i + 1
      endfor
      echo "Select:"
      let s = inputlist(list)
      if s >= 0 
        echo "Jumping to ".jumps[s]
      endif
    endfunction
    nmap <a-left><a-left> :call JumpTo()<cr>
    nmap <a-right><a-right> :call JumpTo()<cr>
    " } 
    
    " Buffers {
    command! -nargs=* CloseHiddenBuffers call CloseHiddenBuffers()
    function! CloseHiddenBuffers()
      " figure out which buffers are visible in any tab
      let visible = {}
      for t in range(1, tabpagenr('$'))
        for b in tabpagebuflist(t)
          let visible[b] = 1
        endfor
      endfor
      " close any buffer that are loaded and not visible
      let l:tally = 0
      for b in range(1, bufnr('$'))
        if bufloaded(b) && !has_key(visible, b)
          let l:tally += 1
          exe 'bw ' . b
        endif
      endfor
      echon "Deleted " . l:tally . " buffers"
    endfun
    " } 
    
    " C/C++ {
    " Disable code in visually selected area
    function! DelimitMyCodeWithIfDef()
      let adef="#ifdef DISABLED_CODE_BEGIN"
      let bdef="#endif /* DISABLED_CODE_END */"
      :'<put! =adef
      :'>put =bdef
    endfunction

    " TODO: activate only for c/c++ files
    vmap <leader>_ <esc>:call DelimitMyCodeWithIfDef()<cr>
    " } 
    
    " Location list {
    function! GrepWordInLocFile() 
      let word = expand("<cword>")
      let file = bufname('%')
      :silent exe ":lgrep! ".word." ".file
      :lopen
      :redraw!
    endfunction

    function! GrepAddWordInLocFile() 
      let word = expand("<cword>")
      let file = bufname('%')
      :silent exe ":lgrepadd! ".word." ".file
      :lopen
      :redraw!
    endfunction

    function! GrepStringInLocFile() 
      let l:token = GetVisual()
      let file = bufname('%')
      :silent exe ":lgrep! \"".l:token."\" ".file
      :lopen
      :redraw!
    endfunction

    vmap <c-g>s :call GrepStringInLocFile()<cr>
    nmap <c-g>a :call GrepAddWordInLocFile()<cr>
    nmap <c-g>s :call GrepWordInLocFile()<cr>
    nmap <c-g>c :lclose<cr>
    " }

    " DiffOrig {
    if !exists(":DiffOrig")
        command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                    \ | wincmd p | diffthis
    endif
    " }
" }

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }

" Use local gvimrc if available and gui is running {
    if has('gui_running')
        if filereadable(expand("~/.gvimrc.local"))
            source ~/.gvimrc.local
        endif
    endif
" }
