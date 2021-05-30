" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker nospell:

so ~/.config/nvim/bindings/whichkey.vim
" Vim {{{
  " Disable EX mode
  nnoremap Q <nop>
  " Force j/k to move by wraps and lines {{{
    noremap j gj
    noremap k gk
  " }}}
  " I'm too fast for handling shift {{{
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
  " }}}
  " Fix yank defaults not yanking from cursor
  nnoremap Y y$
  " Code folding options {{{
    nmap <leader>ff0 :set foldlevel=0<CR>
    nmap <leader>ff1 :set foldlevel=1<CR>
    nmap <leader>ff2 :set foldlevel=2<CR>
    nmap <leader>ff3 :set foldlevel=3<CR>
    nmap <leader>ff4 :set foldlevel=4<CR>
    nmap <leader>ff5 :set foldlevel=5<CR>
    nmap <leader>ff6 :set foldlevel=6<CR>
    nmap <leader>ff7 :set foldlevel=7<CR>
    nmap <leader>ff8 :set foldlevel=8<CR>
    nmap <leader>ff9 :set foldlevel=9<CR>
    nmap <leader>ff- :set foldmethod=manual<CR>
    nmap <leader>ff= :set foldmethod=syntax<CR>
  " }}}
  " Visual shifting (does not exit Visual mode)  {{{
    vnoremap < <gv
    vnoremap > >gv
  " }}}
  " Allow using the repeat operator with a visual selection (!)
  vnoremap . :normal .<CR>
  " Write the file with sudo
  cmap w!! w !sudo tee % > /dev/null
  " NVim Terminal emulator mappings {{{
    if has('nvim')
      fun! Fterm_maps()
        if &ft =~ 'fzf' 
          return
        endif
        tnoremap <buffer><Esc> <C-\><C-n>
        tnoremap <buffer><C-h> <C-\><C-n><C-w>h
        tnoremap <buffer><C-j> <C-\><C-n><C-w>j
        tnoremap <buffer><C-k> <C-\><C-n><C-w>k
        tnoremap <buffer><C-l> <C-\><C-n><C-w>l
      endf
      augroup term_maps
        " this one is which you're most likely to use?
        autocmd BufEnter * call Fterm_maps()
      augroup end
    endif
  " }}}
  " Fast buffer switching {{{
    map <S-H> :bp<CR>
    map <S-L> :bn<CR>
  " }}}
  " Easy splits navigation {{{
    nnoremap <C-J> <C-W>j
    nnoremap <C-K> <C-W>k
    nnoremap <C-L> <C-W>l
    nnoremap <C-H> <C-W>h
  " }}}
  " Toggle loclist
  nmap <silent> <leader>bql :call ToggleList("Location List", 'l')<CR>
  " Toggle qfix
  nmap <silent> <leader>bqq :call ToggleList("Quickfix List", 'c')<CR>
  " Adjust splits evenly
  map <Leader>= <C-w>=
  " Toggle Linebreaks and wraps
  nnoremap <silent><Leader>bvl :set wrap!<CR> \| :set linebreak!<CR>
  " Clear search term (and it hilight :) )
  nmap <silent><Leader>/ :let @/=""<CR>
  " Fast access to vim settings
  nnoremap <silent> <leader>fevc :vsplit ~/.config/nvim/init.vim<CR>
  nnoremap <silent> <leader>fevb :vsplit ~/.config/nvim/bindings.vim<CR>
  nnoremap <silent> <leader>fevp :vsplit ~/.config/nvim/plugins/plug.nvim<CR>
  " Add modeline to file
  nnoremap <silent> <Leader>fm :call AppendModeline()<CR>
  " Fast splits
  nnoremap <silent> <leader>bsv :vsplit<CR>
  nnoremap <silent> <leader>bsh :split<CR>
" }}}
" Plugins {{{
  " Which Key {{{
    nnoremap <silent><leader> :WhichKey '<Space>'<CR>
    nnoremap <silent><localleader> :WhichKey '\'<CR>
  " }}}
  " Buffers {{{
    " NERDTree {{{
      nnoremap <silent><Leader>be :NERDTreeFocus<CR>
    " }}}
    " Tagbar {{{
      nnoremap <silent><Leader>bT :TagbarOpen fjc<CR>
    " }}}
    " BBye {{{
      nnoremap <silent> <leader>bd :Bdelete<CR>
    " }}}
    " FZF {{{
      nmap <leader><tab> <Plug>(fzf-maps-n)
      imap <leader><tab> <Plug>(fzf-maps-i)
      xmap <leader><tab> <Plug>(fzf-maps-x)
      nnoremap <Leader>bf :GFiles<CR>
      nnoremap <Leader>bF :Files<CR>
      nnoremap <Leader>bb :Buffers<CR>
      " fast buffers access
      nnoremap <Leader><Space> :Buffers<CR>
      nnoremap <Leader>bb :Buffers<CR>
      nnoremap <Leader>bg :Rg 
      nnoremap <Leader>bl :BLines<CR>
      nnoremap <Leader>bL :Lines<CR>
      nnoremap <Leader>bt :BTags<CR>
      nnoremap <Leader>bc :Commands<CR>
      nnoremap <Leader>bp :Commits<CR>
    " }}}
    " Sessionman {{{
      " Open session
      nmap <leader>psl :SessionList<CR>
      " Save session
      nmap <leader>pss :SessionSave<CR>
    " }}}
    " Accordion {{{
      " Start accordion with 3 splits by default
      nmap <silent><leader>bas :AccordionAll 3<CR>
      " Stop layout management
      nmap <silent><leader>bac :AccordionStop<CR>
      " -1 split visible
      nmap <silent><leader>bai :AccordionZoomIn<CR>
      " +1 split visible
      nmap <silent><leader>bao :AccordionZoomOut<CR>
    " }}}
    " Undotree {{{
      nnoremap <silent><leader>bu :UndotreeToggle<CR>:UndotreeFocus<CR>
    " }}}
  " }}}
  " Git {{{
    " Fugutive {{{
      " Stage file
      nmap <silent><Leader>gw :GWrite<CR>
      " Git status
      nmap <silent><Leader>gs :G<CR>
    " }}}
    " GV {{{
      nnoremap <silent><leader>gl :GV<CR>
    " }}}
  " }}}
  " Code {{{
    " NERDCommenter {{{
      " Map toggle comment
      map <silent><Leader>c<space> <Plug>NERDCommenterToggle
    " }}}
  " }}}
  " CoC {{{
    " General {{{
      " Extensions could be used for CoC to have more powerful features
      " Here is the list:
      " https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions << Explanation
      " https://www.npmjs.com/search?q=keywords%3Acoc.nvim << Actual list

      " use <tab> for trigger completion and navigate to next complete item
      function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
      endfunction

      " Next by Tab
      inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#rpc#request('doKeymap', ['snippets-expand', "\<TAB>"])

      " Previous by Tab
      inoremap <silent><expr><S-Tab>
            \ pumvisible() ? "\<C-p>" :
            \ <SID>check_back_space() ? "\<S-Tab>" :
            \ coc#rpc#request('doKeymap', ['snippets-expand', "\<S-Tab>"])

      " use <c-space>for trigger completion
      imap <silent><expr> <c-space> coc#refresh()

      " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
      " position. Coc only does snippet and additional edit on confirm.
      if has('patch8.1.1068')
        " Use `complete_info` if your (Neo)Vim version supports it.
        inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
      else
        inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
      endif

      " Use <C-j> to select text for visual text of snippet.
      vmap <C-j> <Plug>(coc-snippets-select)

      " Show doc
      function! s:show_doc()
        if (index(['vim','help'], &filetype) >= 0)
          execute 'h '.expand('<cword>')
        else
          call CocAction('doHover')
        endif
      endfunction

      fun! s:jump_definition()
        if (index(['vim', 'help'], &filetype) >= 0)
          execute 'tag '.expand('<cword>')
        else
          call CocAction('jumpDefinition', v:false)
        endif
      endf

      " Now jump usage
      nnoremap <silent> K :call <SID>show_doc()<CR>

      " GoTos
      nnoremap <silent><C-]> :call <SID>jump_definition()<CR>
      nnoremap <silent><leader>ld :call CocAction('jumpDeclaration', v:false)<CR>
      nnoremap <silent><leader>li :call CocAction('jumpImplementation', v:false)<CR>
      nnoremap <silent><leader>lr :call CocAction('jumpReferences', v:false)<CR>

      " Use `[g` and `]g` to navigate diagnostics
      nmap <silent> [e <Plug>(coc-diagnostic-prev)
      nmap <silent> ]e <Plug>(coc-diagnostic-next)
      " and qf to fix em (or try at least
      nmap <silent><leader>lqf <Plug>(coc-fix-current)
      " Add `:OR` command for organize imports of the current buffer.
      command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

      " Other helpful stuff
      nnoremap <silent><leader>gC :call CocAction('codeAction')<CR>
      nnoremap <silent><leader>gR :call CocAction('rename')<CR>
      nnoremap <silent><leader>gq :call CocAction('quickfixes')<CR>
      nnoremap <silent><leader>,. :call CocActionAsync('format')<CR>
      nnoremap <silent><leader>gL :CocList<CR>

    " }}}
  " }}}
" }}}
