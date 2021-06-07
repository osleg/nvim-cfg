" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker nospell:

" Start plugin manager {{{
  call plug#begin('~/.config/nvim/plugins/plugged')
" }}}

" Plugins List {{{
  " Frameworks and tools {{{
    " vimtips
    Plug 'danilamihailov/vim-tips-wiki'
    " float Term
    Plug 'akinsho/nvim-toggleterm.lua'
    " color choser
    Plug 'mnishz/colorscheme-preview.vim'
    "  Keys helper
    Plug 'liuchengxu/vim-which-key'
    " which keu lua version"
    "Plug 'folke/which-key.nvim'
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
    "Plug 'lukas-reineke/indent-blankline.nvim'
    "Plug 'nathanaelkane/vim-indent-guides'
    Plug 'Yggdroot/indentLine'
    " Fuzzy Finder, you don't need anything else
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'antoinemadec/coc-fzf'
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
    Plug 'mbbill/undotree'
    "Taskwarrior TUI
    Plug 'blindFS/vim-taskwarrior', { 'on': 'TW' }
    Plug 'vimwiki/vimwiki'
    Plug 'powerman/vim-plugin-AnsiEsc'
    Plug 'tbabej/taskwiki'
    " Databases connections
    Plug 'tpope/vim-dadbod'
    " RESTFul client
    Plug 'diepm/vim-rest-console'
    " treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
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
    " DAP {{{
      Plug 'mfussenegger/nvim-dap'
      Plug 'theHamsta/nvim-dap-virtual-text'
    " }}}
  " }}}

  " Snippets {{{
    Plug 'honza/vim-snippets'
  " }}}

  " Languages {{{
    " Polyglot - Mega language pack, syntax hilight, ident and ftplugs only {{{
      "Plug 'sheerun/vim-polyglot'
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
      Plug 'Olical/conjure', { 'for': 'clojure', 'tag': 'v4.19.0'}
      "Plug 'bakpakin/fennel.vim', { 'for': ['clojure', 'fennel'] }
      " Folding for clojure
      Plug 'gberenfield/cljfold.vim', { 'for': 'clojure' }
      " Linting
      Plug 'fbeline/kibit-vim', { 'for': 'clojure' }
      " Rainbow parenthesis
      "Plug 'luochen1990/rainbow', {'for': 'clojure'}
      Plug 'p00f/nvim-ts-rainbow'
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
    " Ayu theme
    Plug 'ayu-theme/ayu-vim'
    " Tmux stuff
    Plug 'edkolev/tmuxline.vim'
    Plug 'christoomey/vim-tmux-navigator'
    " TokyoNight
    Plug 'folke/tokyonight.nvim'
    " For airline theme
    Plug 'ghifarit53/tokyonight-vim'
  " }}}

  " Git {{{
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'lewis6991/gitsigns.nvim'
    "Plug 'jreybert/vimagit'
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
    "let g:rainbow_active=0
    "augroup clojure
      "au!
      "au FileType clojure RainbowToggleOn
    "augroup END
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
    "let g:airline_theme = 'ayu_mirage'
    let g:airline_theme = 'tokyonight'
    " default shor signs from help
    let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : 'C',
      \ 'i'      : 'I',
      \ 'ic'     : 'I',
      \ 'ix'     : 'I',
      \ 'n'      : 'N',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'      : 'S',
      \ ''     : 'S',
      \ 't'      : 'T',
      \ 'v'      : 'V',
      \ 'V'      : 'V',
      \ ''     : 'V',
      \ }
    let g:airline_exclude_preview = 0
  " }}}
  " Tagbar {{{
    let g:tagbar_left = 1
  " }}}
  " Indent Guides {{{
    let g:indentLine_char_list = ['|', '¦', '┆', '┊'] 
   " Enable guides on vim startup
    "let g:indent_guides_enable_on_vim_startup = 1
    " Set guides size to be slim
    "let g:indent_guides_guide_size = 2
    " Disable guides for...
    "let g:indent_guides_exclude_filetypes = ['help']
    " Disable indent guides mapping
    "let g:indent_guides_default_mapping = 0
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

      "let g:fzf_layout = { 'window': {'width': 0.9, 'height': 0.6, 'style': 'minimal' } }
      let g:fzf_layout = { 'window': 'call FloatingFZF()' }
    endif
  " }}}
  " Coc-FZF/Preview {{{
    " Coc-FZF {{{
      let g:coc_fzf_opts = []
      let g:coc_fzf_preview = ''
    " }}}
    " Coc-FZF-Preview {{{
      let g:fzf_preview_default_fzf_options = { '--preview-window': 'wrap' }
    " }}}
  " }}}
  " Golang {{{
    let g:go_code_completion_enabled = 1
    let g:go_fmt_command = "gopls"
    let g:go_doc_keywordprg_enabled = 1
    let g:go_def_mapping_enabled = 1
    let g:go_term_enabled = 1
  " }}}
  " Conjure {{{
    let g:conjure#mapping#doc_word = v:false
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
    " onedark.vim override: Don't set a background color when running in a terminal;
    " just use the terminal's background color
    " `gui` is the hex color code used in GUI mode/nvim true-color mode
    " `cterm` is the color code used in 256-color mode
    " `cterm16` is the color code used in 16-color mode
    "if (has("autocmd") && !has("gui_running"))
      "augroup colorset
        "autocmd!
        "let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
        "autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
      "augroup END
    "endif
    autocmd CursorHold * silent call CocActionAsync('highlight')
    "Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    set background=dark                        " Set dark for transparent window
    set guifont=Hack\ Nerd\ Font:h20 " Set font
    set termguicolors                          " Set truecolor
    let ayucolor="mirage"
    colorscheme   tokyonight "                        Nice color scheme

    " ayu has some shitty bracket highlight colors, this is to fix it
    hi MatchParen guifg=white guibg=NONE
    hi CocHighlightText cterm=undercurl term=undercurl gui=undercurl
    " Transaprency {{{
      "highlight Normal ctermbg=NONE
      "highlight NonText ctermbg=NONE
      " Cursor line coloring
      "hi CursorLine ctermbg=16 ctermfg=None
    " }}}
  " }}}
  " TreeSitter {{{
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  -- Modules and its options go here
  highlight = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    }
  },
  indent = {
    enable = true,
    disable = {"python"}
  },
  rainbow = {
    enable = true,
    extended_mode = false,
    max_file_lines = 4000
  }
}
EOF
  " }}}
  " gitsigns {{{
    lua require('gitsigns').setup()
  " }}}
  " toggleterm {{{
lua <<EOF
    require('toggleterm').setup{
      open_mapping = [[≈]],
      direction = 'vertical',
      close_on_exit = true,
      size = 120,
    }
EOF
  " }}}
  " WhichKey Lua {{{
"lua <<EOF
    "require('which-key').setup{}
"EOF
  " }}}
  " DAP {{{
    let g:dap_virtual_text = v:true
  " }}}
" }}}
