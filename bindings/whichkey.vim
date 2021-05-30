" Whichkey {{{
  " Global {{{
    let g:which_key_map = {'=': 'Even'}
    let g:which_key_lmap = {}
  " }}}
  " Whichkey mapping buffers {{{
    let g:which_key_map.b = {'name': '+Buffers',
          \ 'e': {'name': 'NerdTree'},
          \ 'T': {'name': 'Tagbar'},
          \ 'd': {'name': 'Kill Buffer'},
          \ 'f': {'name': 'Project Files' },
          \ 'F': {'name': 'All Files' },
          \ 'b': {'name': 'Buffers' },
          \ 'u': {'name': 'Undotree' },
          \ ' ': {'name': 'Buffers' },
          \ 'g': {'name': 'Search' },
          \ 'l': {'name': 'Buffer Lines' },
          \ 'L': {'name': 'Lines' },
          \ 't': {'name': 'Tags' },
          \ 'c': {'name': 'Commands' },
          \ 'p': {'name': 'Commits' },
          \ 'a': {'name': '+Accordion',
          \       's': {'name': 'Start'},
          \       'c': {'name': 'Cancel'},
          \       'i': {'name': 'Zoom In'},
          \       'o': {'name': 'Zoom Out'} },
          \ 'q': {'name': '+Quick',
          \       'q': 'Fix',
          \       'l': 'Loc' },
          \ 's': {'name': '+Split',
          \       'h': 'Horizontal',
          \       'v': 'Vertical'},
          \ 'v': {'name': '+View Settings',
          \       'l': 'Line Break' } }
  " }}}
  " Whichkey mappings git {{{
    let g:which_key_map.g = {'name': '+Git',
          \ 'l': {'name': 'Logs'},
          \ 'w': {'name': 'Write'},
          \ 's': {'name': 'Status'}}
  " }}}
  " Whichkey mappings code {{{
    let g:which_key_map.c = {
          \ 'name': '+Code',
          \ ' ': 'Comment Toggle' }
  " }}}
  " Whichkey mappings project {{{
    let g:which_key_map.p = {'name': '+Project',
          \ 's': {'name': '+Session',
          \       's': {'name': 'Save'},
          \       'l': {'name': 'Load'} } }
  " }}}
  " Whichkey mappings files {{{
    let g:which_key_map.f = {'name': '+File',
          \ 'e': {'name': '+Edit',
          \       'v': {'name': '+Vim',
          \             'c': 'Config',
          \             'b': 'Bindings',
          \             'p': 'Plugins'} },
          \ 'm': {'name': 'Modeline'},
          \ 'f': {'name': '+Fold'} }
  " }}}
" }}}

" vim: set ts=2 sw=2 tw=78 fdm=marker fmr={{{,}}} et ft=vim:
