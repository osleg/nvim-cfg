" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker nospell:

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
  " Visual shifting (does not exit Visual mode)  {{{
    vnoremap < <gv
    vnoremap > >gv
  " }}}
  " Allow using the repeat operator with a visual selection (!)
  vnoremap . :normal .<CR>
  " Write the file with sudo
  cmap w!! w !sudo tee % > /dev/null
  " NVim Terminal emulator mappings {{{
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
      autocmd BufEnter * call Fterm_maps()
    augroup end
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
  " Adjust splits evenly
  map <Leader>= <C-w>=
  " Toggle Linebreaks and wraps
  nnoremap <silent><Leader> :set wrap!<CR> \| :set linebreak!<CR>
  " Clear search term (and it hilight :) )
  nmap <silent><Leader>/ :let @/=""<CR>
  " Add modeline to file
  nnoremap <silent> <Leader>am :call AppendModeline()<CR>
  " Fast splits
  nnoremap <silent> <leader>sv :vsplit<CR>
  nnoremap <silent> <leader>sh :split<CR>
" }}}

" NvimTree {{{
  nnoremap<silent> <leader>be :NvimTreeToggle<CR>
" }}}

" Easy Align {{{
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
" }}}
