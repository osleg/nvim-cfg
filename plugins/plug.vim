" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker nospell:

" Start plugin manager {{{
  call plug#begin('~/.config/nvim/plugins/plugged')
" }}}

" Plugins List {{{
  " Frameworks and tools {{{
    "  Keys helper
    Plug 'liuchengxu/vim-which-key'
    " Nice comments
    Plug 'scrooloose/nerdcommenter'
    " File browser
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeFocus' }
    " Tagbar...
    Plug 'majutsushi/tagbar', { 'on': 'TagbarOpen' }
    " Hex editor in VIM
    Plug 'Shougo/vinarise.vim', { 'on': 'Vinarise' }
    " Close buffer without ruining splits
    Plug 'moll/vim-bbye'
    " Help with surrounding '"([{ etc
    Plug 'tpope/vim-surround'
    " Show neat indent guides
    Plug 'nathanaelkane/vim-indent-guides'
    " Fuzzy Finder, you don't need anything else
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    " Shows content of registers
    Plug 'junegunn/vim-peekaboo'
    " Allow repeat of much more
    Plug 'tpope/vim-repeat'
    " Easy and simple session save/restore
    Plug 'vim-scripts/sessionman.vim', { 'on': ['SessionOpen','SessionSave','SessionList'] }
    " Save and restore cursor position
    Plug 'vim-scripts/restore_view.vim'
    " Easy align stuff
    Plug 'junegunn/vim-easy-align'
    " Like easy align but more powerful (and complicated)
    Plug 'godlygeek/tabular'
    " Visual marks
    Plug 'kshenoy/vim-signature'
    " Display nice [N/n] when searching
    Plug 'google/vim-searchindex'
    " Limit split width when there is too many
    Plug 'mattboehm/vim-accordion', { 'on': 'Accordion' }
    " Undo tree
    Plug 'mbbill/undotree', { 'on': 'UndoTreeToggle' }
    "Taskwarrior TUI
    Plug 'blindFS/vim-taskwarrior', { 'on': 'TW' }
    Plug 'vimwiki/vimwiki'
    Plug 'powerman/vim-plugin-AnsiEsc'
    Plug 'tbabej/taskwiki'
    " Databases connections
    Plug 'tpope/vim-dadbod'
  " }}}

  " Autocomplete {{{
    " CoC {{{
      Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " }}}
    " Nvim LSP {{{
      "Plug 'neovim/nvim-lsp'
      "Plug 'nvim-lua/completion-nvim'
      "Plug 'hrsh7th/vim-vsnip'
      "Plug 'hrsh7th/vim-vsnip-integ'
      "Plug 'nvim-lua/diagnostic-nvim'
    " }}}
  " }}}

  " Snippets {{{
    Plug 'honza/vim-snippets'
  " }}}

  " Languages {{{
    " Polyglot - Mega language pack, syntax hilight, ident and ftplugs only {{{
      Plug 'sheerun/vim-polyglot'
    " }}}

    " Go {{{
      Plug 'fatih/vim-go', {'for': 'go'}
    " }}}

    " Markdown {{{
      Plug 'plasticboy/vim-markdown'
    " }}}

    " HTML/JS {{{
      Plug 'mustache/vim-mustache-handlebars', {'for': ['js', 'ts', 'javascript', 'typescript']}
    " }}}

    " GoDot {{{
      Plug 'calviken/vim-gdscript3', {'for': 'gdscript'}
    " }}}

    " Clojure {{{
      Plug 'eraserhd/parinfer-rust', { 'do': 'cargo build --release', 'for': 'clojure' }
      "Plug 'Olical/conjure', { 'for': 'clojure', 'tag': 'v4.3.1' }
      "Plug 'bakpakin/fennel.vim', { 'for': ['clojure', 'fennel'] }
      " Folding for clojure
      Plug 'gberenfield/cljfold.vim', { 'for': 'clojure' }
      " Linting
      Plug 'fbeline/kibit-vim', { 'for': 'clojure' }
      " Rainbow parenthesis
      Plug 'luochen1990/rainbow', {'for': 'clojure'}
    " }}}
  " }}}

  " Theme {{{
    " Airline statusline
    Plug 'vim-airline/vim-airline'
    " Some themes for airline and bufferline
    Plug 'vim-airline/vim-airline-themes'
    " Themes for vim
    Plug 'flazz/vim-colorschemes'
    " Icons for filetypes
    Plug 'ryanoasis/vim-devicons'
    " OneDark theme
    Plug 'joshdick/onedark.vim'
  " }}}

  " Git {{{
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim'
    Plug 'jreybert/vimagit'
  " }}}

  " End Plugin {{{
    call plug#end()
  " }}}
" }}}

" Plugins Config {{{ 
  " Which Key {{{
    " Must be as soon as possible to prevent intervention with WhichKey
    nnoremap <Space> <nop>
    call which_key#register('<Space>', "g:which_key_map")
    call which_key#register('\', "g:which_key_lmap")
  " }}}
  " NERDTree {{{
    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$',
      \ '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeMouseMode=2
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
    let g:nerdtree_tabs_open_on_gui_startup=0
  " }}}
  " NERDCommenter {{{
    " Disable default mappings
    let NERDCreateDefaultMappings = 0
  " }}}
  " Rainbow {{{
    let g:rainbow_active=0
    augroup clojure
      au!
      au FileType clojure RainbowToggleOn
    augroup END
  " }}}
  " Airline {{{
    " settings
    let g:airline_highlighting_cache = 1
    " disable some extensions
    let g:airline#extensions#tabline#enabled = 0
    " extenstions settings {{{
      " branch
      let g:airline#extensions#branch#displayed_head_limit = 14
      let g:airline#extensions#branch#format = 2
      " hunk
      let g:airline#extensions#hunks#non_zero_only = 1
    " }}}
    " theme
    let g:airline_powerline_fonts = 1
    let g:airline_theme = 'onedark'
  " }}}
  " Tagbar {{{
    let g:tagbar_left = 1
  " }}}
  " Indent Guides {{{
    " Enable guides on vim startup
    let g:indent_guides_enable_on_vim_startup = 1
    " Set guides size to be slim
    let g:indent_guides_guide_size = 2
    " Disable guides for...
    let g:indent_guides_exclude_filetypes = ['help']
    " Disable indent guides mapping
    let g:indent_guides_default_mapping = 0
  " }}}
  " FZF {{{
    set rtp+=~/scoop/apps/fzf/current

    " [Buffers] Jump to the existing window if possible
    let g:fzf_buffers_jump = 1

    " Enable history C-P & C-N
    " Shadowing up and down, FIXME
    "let g:fzf_history_dir = '~/.local/share/fzf-history'

    " A bit of theming
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Background'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

    if has('nvim')
      let $FZF_DEFAULT_OPTS .= ' --border --margin=0,2'

      function! FloatingFZF()
        let width = float2nr(&columns * 0.9)
        let height = float2nr(&lines * 0.6)
        let opts = { 'relative': 'editor',
                   \ 'row': (&lines - height) / 2,
                   \ 'col': (&columns - width) / 2,
                   \ 'width': width,
                   \ 'height': height,
                   \ 'style': 'minimal'}

        let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
        call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
      endfunction

      let g:fzf_layout = { 'window': 'call FloatingFZF()' }
    endif
  " }}}
  " Golang {{{
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_types = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1
    let g:go_fmt_command = "goimports"
    let g:go_fmt_expiremental = 1
    let g:go_term_enabled = 1
  " }}}
  " Conjure {{{
    " Disable Shift+K Mapping
    "augroup conjure
      "" this one is which you're most likely to use?
      "au!
      "au BufEnter *.clj,*.cljc,*.cljs let g:conjure#mapping#doc_word = v:false
      "au BufEnter *.clj,*.cljc,*.cljs let g:conjure#mapping#def_word = v:false
    "augroup end
  " }}}
  " Theme {{{
    " OneDark {{{
      " Allow italic text in terminal
      let g:onedark_terminal_italics=1
      let g:onedark_termcolors = 16

    " }}}
    "Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    set background=dark                        " Set dark for transparent window
    set guifont=xos4\ Terminess\ Powerline:h20 " Set font
    set termguicolors                          " Set truecolor
    colorscheme  onedark                       " Nice color scheme
    " Transaprency {{{
      "highlight Normal ctermbg=NONE
      "highlight NonText ctermbg=NONE
      " Cursor line coloring
      "hi CursorLine ctermbg=16 ctermfg=None
    " }}}
  " }}}
" }}}
