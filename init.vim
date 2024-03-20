" Modeline and Notes {{{
" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker nospell:

"          DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
"                     Version 2, December 2004
"
"   Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
"
"   Everyone is permitted to copy and distribute verbatim or modified
"   copies of this license document, and changing it is allowed as long
"   as the name is changed.
"
"             DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
"    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
"
"   0. You just DO WHAT THE FUCK YOU WANT TO.
" }}}

" Config {{{
  " Basic stuff/Editor Behavior {{{
    filetype plugin indent on                       " Automatically detect file types
    syntax on                                       " Syntax Highlight
    set autoread                                    " Re-read file if it was changed on disk
    set autowrite                                   " Write buffer on leave
    set shortmess=aoOtTc                            " Basically... truncate almost everything
    set viewoptions=cursor,folds,options            " What to write for mkview
    set virtualedit=onemore                         " Allow virtual editing everything
    set history=250                                 " Moar history!
    set hidden                                      " allow switching buffers without writing
    set lazyredraw                                  " Don't redraw on every sneeze
    set completeopt=menu,menuone,noselect           " Always show completion menu, don't auto-insert/select
    set noshowmode                                  " Don't show current mode in status line
    set laststatus=2                                " Use single status line
    " set foldtext=FoldText()                         " Folds text
    set nowrap                                      " Don't wrap lines
    set nolinebreak                                 " Don't break lines
    set autoindent                                  " Indent at the same level of the previous line
    set shiftwidth=2                                " Use indents of 2 spaces
    set expandtab                                   " Tabs are spaces, not tabs
    set tabstop=2                                   " An indentation every 2 columns
    set softtabstop=2                               " Let backspace delete indent
    set splitbelow                                  " Puts new vsplit windows to the bottom of the current
    set splitright                                  " Puts new vsplit windows to the right of the current
    set matchpairs+=<:>                             " Match, to be used with %
    set pastetoggle=<F11>                           " pastetoggle (sane indentation on pastes)
    set cursorline                                  " Highlight the line where cursor located
    set backspace=indent,eol,start                  " Better backspace navigation
    set nonu                                        " No Line numbers
    set nornu                                       " No RELATIVE line numbers
    set showmatch                                   " Show matching bracket/parenthesis
    set winminheight=1                              " allow buffers to be 1 line high
    set winminwidth=1                               " allow buffers to be 1 line wide
    set wildmenu                                    " Show list instead of just completing
    set wildmode=longest:full,full                  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,<,>,[,]                       " Backspace and cursor keys wrap too
    set foldenable                                  " Enable folding by default
    set list                                        " Enable showing tabs, spaces and trailings
    " Highlight problematic whitespace
    set listchars=tab:┆\ ,trail:•,extends:▶,precedes:◀,nbsp:.
    set signcolumn=yes:2                            " Always show signs column
    set scrolljump=-10                              " Lines to scroll when cursor leaves screen
    set scrolloff=3                                 " Minimum lines to keep above and below cursor
    set sidescroll=5                                " Columns to scroll when hitting horizontal end of screen
    set sidescrolloff=15                            " Minimum characters to show on horizontal scroll
    set nospell                                     " Enable spell checker
    set timeoutlen=500                              " Set shorter timeout for mappings
    set cmdheight=2                                 " Little bit more space for messages
    set updatetime=300                              " faster CursorHold action
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    set guifont=Hack\ Nerd\ Font\ Mono:11
   "set jumpoptions=stack
  " }}}

  " Search setup {{{
    set incsearch        " Find as you type
    set hlsearch         " Hilight search
    set ignorecase       " Case insensitive search
    set smartcase        " Case sensitive when uc present
    set inccommand=split " live substitute with  preview for offscreen items
  " }}}

  " Map leader and local leader keys to <space> and \ respectively {{{
    let mapleader=" "
    let localleader="\\"
  " }}}

  " Setting up the directories and backup {{{
  " fixes cocnvim stuff see https://github.com/neoclide/coc.nvim/issues/649
    set nobackup         " Backups are nice ... but screw em (
    set nowritebackup
    if has('persistent_undo')
      set undofile       " So is persistent undo ...
      set undolevels=250 " Maximum number of changes that can be undone
      set undoreload=500 " Maximum number lines to save for undo on a buffer reload
    endif
  " }}}

  " Mouse settings {{{
    set mouse=a   " Enable mouse
    set mousehide " Hide mouse cursor while typing
  " }}}

  " Set Encoding {{{
    scriptencoding utf-8
    set encoding=utf-8
  " }}}

  " Clipboard {{{
    if has('clipboard')       " There is a chance that CP is not available in nvim
        if has('unnamedplus') " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else                  " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif
  " }}}

  " Python interpreter {{{
    let g:python3_host_prog = '$HOME/.virtualenvs/nvim/bin/python'
  " }}}

" }}}

" Init plugins
so $HOME/.config/nvim/plugins.lua " Init bindings
so $HOME/.config/nvim/bindings/bindings.vim

" DAP {{{
  nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>
  nnoremap <silent> <leader>dl :lua require'dap'.step_over()<CR>
  nnoremap <silent> <leader>dj :lua require'dap'.step_into()<CR>
  nnoremap <silent> <leader>dk :lua require'dap'.step_out()<CR>
  nnoremap <silent> <leader>dbb :lua require'dap'.toggle_breakpoint()<CR>
  nnoremap <silent> <leader>dbc :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
  nnoremap <silent> <leader>dbl :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
  nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
  nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
  nnoremap <silent> <leader>dui :lua require'dapui'.toggle()<CR>
  nnoremap <silent> <leader>duf :lua require'dapui'.float_element()<CR>
" }}}"

" CodeActionMenu {{{
  nnoremap <silent> <leader>ca :lua require('actions-preview').code_actions()<CR>
  vnoremap <silent> <leader>ca :lua require('actions-preview').code_actions()<CR>
" }}}

" Theme {{{
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  set termguicolors
  colorscheme tokyonight
" }}}

" UltiSNips {{{
  let g:UltiSnipsExpandTrigger            =  "<nop>"
  let g:UltiSnipsListSnippets             =  "<nop>"
  let g:UltiSnipsJumpForwardTrigger       =  "<nop>"
  let g:UltiSnipsJumpBackwardTrigger      =  "<nop>"
" }}}"

" Trouble {{{
  nnoremap <silent> <leader>xx :TroubleToggle document_diagnostics<CR>
  nnoremap <silent> <leader>xw :TroubleToggle workspace_diagnostics<CR>
  nnoremap <silent> <leader>xt :TodoTrouble<CR>
" }}}

" Go {{{
  autocmd BufWritePre *.go :silent! lua require('go.format').gofmt() 
  autocmd BufWritePre (InsertLeave?) <buffer> lua vim.lsp.buf.formatting_sync(nil,500)
  let g:go_code_completion_enabled = 0
" }}}

" Python {{{
" }}}

" Functions {{{
" TODO: check what still needed, port to lua and remove obsolete
  " split separator {{{
    au WinEnter * setl winhl=WinSeparator:WinSeparatorA
    au WinLeave * setl winhl=WinSeparator:WinSeparator
  " }}}
  " Clojure thingeys {{{
  " TODO: Move it away
    function! Expand(exp) abort
      let l:result = expand(a:exp)
      return l:result ==# '' ? '' : "file://" . l:result
    endfunction
  " }}}
  " Fold text formatting {{{
    let defaults = {'placeholder': 'Ⱝ', 'line': 'ᚚ', 'whole': 'ᛈ',
    \       'level': 'ᛝ', 'division': '/', 'multiplication': '*',
    \       'epsilon': 'έ'}
    let defaults['denominator'] = 25
    let defaults['gap'] = 4

    if !exists('g:FoldText_placeholder')
      let g:FoldText_placeholder = defaults['placeholder']
    endif
    if !exists('g:FoldText_line')
      let g:FoldText_line = defaults['line']
    endif
    if !exists('g:FoldText_whole')
      let g:FoldText_whole = defaults['whole']
    endif
    if !exists('g:FoldText_level')
      let g:FoldText_level = defaults['level']
    endif
    if !exists('g:FoldText_division')
      let g:FoldText_division = defaults['division']
    endif
    if !exists('g:FoldText_multiplication')
      let g:FoldText_multiplication = defaults['multiplication']
    endif
    if !exists('g:FoldText_epsilon')
      let g:FoldText_epsilon = defaults['epsilon']
    endif
    if !exists('g:FoldText_denominator')
      let g:FoldText_denominator = defaults['denominator']
    endif
    if g:FoldText_denominator >= &maxfuncdepth
      let g:FoldText_denominator = &maxfuncdepth - 1
    endif
    if !exists('g:FoldText_gap')
      let g:FoldText_gap = defaults['gap']
    endif

    unlet defaults


    function! s:FractionsBetween(lo, hi, denominator)
      " Find all fractions between [a, b] and [c, d] with denominator equal
      " to `a:denominator'
      let lo = a:lo[0] / a:lo[1]
      let hi = a:hi[0] / a:hi[1]
      let fractions = []
      let n = 1.0
      while n < a:denominator
        let p = n / a:denominator
        if p > lo && p < hi
          call add(fractions, [n, a:denominator])
        endif
       let n += 1
      endwhile
        return fractions
    endfunction

    function! s:FractionSearch(proportion, denominator)
      " Search for the nearest fraction, used by s:FractionNearest().
      if a:denominator == 1
        return [[0.0, 1], [1.0, 1]]
      endif

      let [lo, hi] = s:FractionSearch(a:proportion, a:denominator - 1)
      let fractionsBetween = s:FractionsBetween(lo, hi, a:denominator)
      for fraction in fractionsBetween
        let f = fraction[0] / fraction[1]
        if a:proportion >= f
          let lo = fraction
        else
          let hi = fraction
          break
        endif
      endfor
      return [lo, hi]
    endfunction

    function! s:FractionNearest(proportion, maxDenominator)
      " Find the neareset fraction to `a:proportion' (which is a float),
      " but using fractions with denominator less than `a:maxDenominator'.
      let [lo, hi] = s:FractionSearch(a:proportion, a:maxDenominator)
      let mid = (lo[0] / lo[1] + hi[0] / hi[1]) / 2
      if a:proportion > mid
        return hi
      else
        return lo
      endif
    endfunction

    function! s:FractionFormat(fraction)
      " Format a fraction: [a, b] --> 'a/b'
      let [n, d] = a:fraction
      if n == 0.0
        return g:FoldText_epsilon
      endif
      if d != 1
        return printf("%.0f%s%d", n, g:FoldText_division, d)
      endif
      return printf("%.0f", n)
    endfunction

    function! FoldText()
      " Returns a line representing the folded text
      "
      " A fold across the following:
      "
      " fu! MyFunc()
      "    call Foo()
      "    echo Bar()
      " endfu
      "
      " should, in general, produce something like:
      "
      " fu! MyFunc() <...> endfu                    L*15 O*2/5 Z*2
      "
      " The folded line has the following components:
      "
      "   - <...>           the folded text, but squashed;
      "   - endfu           the last line (where applicable);
      "   - L*15            the number of lines folded (including first);
      "   - O*2/5           the fraction of the whole file folded;
      "   - Z*2             the fold level of the fold.
      "
      " You may also define any of the following strings:
      "
      " let g:FoldText_placeholder = '<...>'
      " let g:FoldText_line = 'L'
      " let g:FoldText_level = 'Z'
      " let g:FoldText_whole = 'O'
      " let g:FoldText_division = '/'
      " let g:FoldText_multiplication = '*'
      " let g:FoldText_epsilon = '0'
      " let g:FoldText_denominator = 25
      "
      let fs = v:foldstart
      while getline(fs) =~ '^\s*$'
        let fs = nextnonblank(fs + 1)
      endwhile
      if fs > v:foldend
        let line = getline(v:foldstart)
      else
        let spaces = repeat(' ', &tabstop)
        let line = substitute(getline(fs), '\t', spaces, 'g')
      endif

      let foldEnding = strpart(getline(v:foldend), indent(v:foldend), 3)

      let endBlockChars = ['end', '}', ']', ')']
      let endBlockRegex = printf('^\s*\(%s\);\?$', join(endBlockChars, '\|'))
      let endCommentRegex = '\s*\*/$'
      let startCommentBlankRegex = '\v^\s*/\*!?\s*$'

      if foldEnding =~ endBlockRegex
          let foldEnding = " " . g:FoldText_placeholder . " " . foldEnding
      elseif foldEnding =~ endCommentRegex
        if getline(v:foldstart) =~ startCommentBlankRegex
          let nextLine = substitute(getline(v:foldstart + 1), '\v\s*\*', '', '')
          let line = line . nextLine
        endif
        let foldEnding = " " . g:FoldText_placeholder . " " . foldEnding
      else
        let foldEnding = " " . g:FoldText_placeholder
      endif
      let foldColumnWidth = &foldcolumn ? 1 : 0
      let numberColumnWidth = &number ? strwidth(line('$')) : 0
      let width = winwidth(0) - foldColumnWidth - numberColumnWidth - g:FoldText_gap

      let foldSize = 1 + v:foldend - v:foldstart
      let foldSizeStr = printf("%s%s%s", g:FoldText_line, g:FoldText_multiplication, foldSize)

      let foldLevelStr = g:FoldText_level . g:FoldText_multiplication . v:foldlevel . " "

      let proportion = (foldSize * 1.0) / line("$")
      let foldFraction = s:FractionNearest(proportion, g:FoldText_denominator)
      let foldFractionStr = printf(" %s%s%s ", g:FoldText_whole, g:FoldText_multiplication, s:FractionFormat(foldFraction))
      let ending = foldSizeStr . foldFractionStr . foldLevelStr

      if strwidth(line . foldEnding . ending) >= width
        let line = strpart(line, 0, width - strwidth(foldEnding . ending))
      endif

      let expansionStr = repeat(" ", g:FoldText_gap + width - strwidth(line . foldEnding . ending) - 3)
      return line . foldEnding . expansionStr . ending
    endfunction
  " }}}
  " Add modeline {{{
    function! AppendModeline()
      let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d fdm=%s %set :",
        \ &tabstop, &shiftwidth, &textwidth, &fdm, &expandtab ? '' : 'no')
      let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
      call append(line("$"), l:modeline)
    endfunction
  "}}}
  " Strip whitespace {{{
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " autocmd BufWritePre * call StripTrailingWhitespace()
  " }}}
  " Init Directories (stolen from spf13) {{{
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif
        for [dirname, settingname] in items(dir_list)
            let directory = parent . '/.' . prefix . '/' . dirname . '/'
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
  " }}}
  " Pulse cursol line {{{
    function! PulseCursorLine()
      redir => old_hi
          silent execute 'hi CursorLine'
      redir END
      let old_hi = split(old_hi, '\n')[0]
      let old_hi = substitute(old_hi, 'xxx', '', '')

      hi CursorLine guibg=#3a3a3a
      redraw
      sleep 14m

      hi CursorLine guibg=#4a4a4a
      redraw
      sleep 10m

      hi CursorLine guibg=#3a3a3a
      redraw
      sleep 14m

      hi CursorLine guibg=#2a2a2a
      redraw
      sleep 10m

      execute 'hi ' . old_hi
    endfunction
    nnoremap <silent><leader>jkjk :call PulseCursorLine()<CR>
  " }}}
" }}}

" SymbolsOutline {{{
  autocmd FileType Outline setlocal signcolumn=no
" }}}
