-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/alexx/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/alexx/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/alexx/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/alexx/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/alexx/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["FTerm.nvim"] = {
    config = { "\27LJ\2\nÅ\2\0\0\b\0\f\0\0226\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0005\1\6\0\18\2\0\0'\4\a\0'\5\b\0'\6\t\0\18\a\1\0B\2\5\1\18\2\0\0'\4\n\0'\5\b\0'\6\v\0\18\a\1\0B\2\5\1K\0\1\0005<C-\\><C-n><CMD>lua require(\"FTerm\").toggle()<CR>\6t+<CMD>lua require(\"FTerm\").toggle()<CR>\n<A-i>\6n\1\0\2\vsilent\2\fnoremap\2\20nvim_set_keymap\bapi\bvim\nsetup\nFTerm\frequire\0" },
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/FTerm.nvim"
  },
  ["bufdelete.nvim"] = {
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/bufdelete.nvim"
  },
  conjure = {
    config = { "\27LJ\2\nQ\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0+\3\1\0B\0\3\1K\0\1\0\29conjure#mapping#doc_word\17nvim_set_var\bapi\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/opt/conjure"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/diffview.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["goto-preview"] = {
    config = { "\27LJ\2\nZ\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\21default_mappings\2\ndebug\2\nsetup\17goto-preview\frequire\0" },
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/goto-preview"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  neogit = {
    config = { "\27LJ\2\n]\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\17integrations\1\0\0\1\0\1\rdiffview\2\nsetup\vneogit\frequire\0" },
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/neogit"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-comment"] = {
    config = { "\27LJ\2\nt\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\17line_mapping\15<leader>c \21operator_mapping\14<leader>c\nsetup\17nvim_comment\frequire\0" },
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/nvim-comment"
  },
  ["nvim-compe"] = {
    config = { "\27LJ\2\nF\0\1\a\0\3\0\b6\1\0\0009\1\1\0019\1\2\1\18\3\0\0+\4\2\0+\5\2\0+\6\2\0D\1\5\0\27nvim_replace_termcodes\bapi\bvim£\1\0\0\6\0\b\2\0306\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\23\0\0\0\b\0\1\0X\1\16Ä6\1\0\0009\1\1\0019\1\4\1'\3\3\0B\1\2\2\18\3\1\0009\1\5\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\6\1'\4\a\0B\1\3\2\15\0\1\0X\2\3Ä+\1\2\0L\1\2\0X\1\2Ä+\1\1\0L\1\2\0K\0\1\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\bvim\2\0£\2\0\0\3\2\t\1&6\0\0\0009\0\1\0009\0\2\0B\0\1\2\t\0\0\0X\0\4Ä-\0\0\0'\2\3\0D\0\2\0X\0\27Ä6\0\0\0009\0\1\0009\0\4\0B\0\1\2\b\0\0\0X\0\6Ä6\0\0\0009\0\1\0009\0\5\0B\0\1\2\t\0\0\0X\0\4Ä-\0\0\0'\2\6\0D\0\2\0X\0\vÄ-\0\1\0B\0\1\2\15\0\0\0X\1\4Ä-\0\0\0'\2\a\0D\0\2\0X\0\3Ä-\0\0\0'\2\b\0D\0\2\0K\0\1\0\0¿\1¿\6 \n<Tab>.<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>\30UltiSnips#CanJumpForwards\31UltiSnips#CanExpandSnippet\n<C-n>\15pumvisible\afn\bvim\2…\1\0\0\3\1\a\1\0246\0\0\0009\0\1\0009\0\2\0B\0\1\2\t\0\0\0X\0\4Ä-\0\0\0'\2\3\0D\0\2\0X\0\rÄ6\0\0\0009\0\1\0009\0\4\0B\0\1\2\t\0\0\0X\0\4Ä-\0\0\0'\2\5\0D\0\2\0X\0\3Ä-\0\0\0'\2\6\0D\0\2\0K\0\1\0\0¿\f<S-Tab>(<C-R>=UltiSnips#JumpBackwards()<CR>\31UltiSnips#CanJumpBackwards\n<C-p>\15pumvisible\afn\bvim\2“\1\0\0\4\0\n\2\0236\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1B\1\1\2\t\1\0\0X\1\fÄ6\1\2\0009\1\3\0019\1\5\1B\1\1\0029\1\6\1\b\1\1\0X\1\5Ä6\1\2\0009\1\3\0019\1\a\1'\3\b\0D\1\2\0009\1\t\0D\1\1\0\26check_break_line_char\t<CR>\18compe#confirm\rselected\18complete_info\15pumvisible\afn\bvim\19nvim-autopairs\frequire\2˛ˇˇˇ\31è\a\1\0\b\0#\0A6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\3=\3\a\0025\3\b\0=\3\t\2B\0\2\0013\0\n\0003\1\v\0006\2\f\0003\3\14\0=\3\r\0026\2\f\0003\3\16\0=\3\15\0026\2\17\0009\2\18\0029\2\19\2'\4\20\0'\5\21\0'\6\22\0005\a\23\0B\2\5\0016\2\17\0009\2\18\0029\2\19\2'\4\24\0'\5\21\0'\6\22\0005\a\25\0B\2\5\0016\2\17\0009\2\18\0029\2\19\2'\4\20\0'\5\26\0'\6\27\0005\a\28\0B\2\5\0016\2\17\0009\2\18\0029\2\19\2'\4\24\0'\5\26\0'\6\27\0005\a\29\0B\2\5\0016\2\f\0003\3\31\0=\3\30\0026\2\17\0009\2\18\0029\2\19\2'\4\20\0'\5 \0'\6!\0005\a\"\0B\2\5\0012\0\0ÄK\0\1\0\1\0\1\texpr\2\24v:lua.completions()\t<CR>\0\16completions\1\0\1\texpr\2\1\0\1\texpr\2\27v:lua.s_tab_complete()\f<S-Tab>\1\0\1\texpr\2\6s\1\0\1\texpr\2\25v:lua.tab_complete()\n<Tab>\6i\20nvim_set_keymap\bapi\bvim\0\19s_tab_complete\0\17tab_complete\a_G\0\0\vsource\1\0\b\rnvim_lsp\2\vbuffer\2\rnvim_lua\2\tcalc\2\tpath\2\nvsnip\1\14ultisnips\2\fluasnip\1\18documentation\vborder\1\0\4\15min_height\3\1\17winhighlightHNormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder\14max_width\3x\14min_width\3<\1\t\0\0\5\5\5\6 \5\5\5\6 \1\0\f\18throttle_time\3P\14preselect\venable\15min_length\3\1\17autocomplete\2\fenabled\2\19source_timeout\3»\1\19max_menu_width\3d\19max_kind_width\3d\19max_abbr_width\3d\21incomplete_delay\3ê\3\20resolve_timeout\3†\6\ndebug\1\nsetup\ncompe\frequire\0" },
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-dap"] = {
    config = { "\27LJ\2\ng\0\0\5\0\a\0\f6\0\0\0009\0\1\0009\0\2\0'\2\3\0006\3\0\0009\3\1\0039\3\4\3B\3\1\2'\4\5\0&\3\4\3'\4\6\0D\0\4\0\tfile\6/\vgetcwd\25Path to executable: \ninput\afn\bvim•\2\1\0\5\0\v\0\0166\0\0\0'\2\1\0B\0\2\0029\1\2\0005\2\4\0=\2\3\0019\1\5\0004\2\3\0005\3\a\0003\4\b\0=\4\t\0034\4\0\0=\4\n\3>\3\1\2=\2\6\1K\0\1\0\targs\fprogram\0\1\0\6\tname\vLaunch\ttype\tlldb\frequest\vlaunch\16stopOnEntry\1\bcwd\23${workspaceFolder}\18runInTerminal\1\trust\19configurations\1\0\3\fcommand&/Users/alexx/.cargo/bin/rust-lldb\tname\tlldb\ttype\15executable\tlldb\radapters\bdap\frequire\0" },
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    config = { "\27LJ\2\nÜ\3\0\0\5\0\19\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\a\0005\4\6\0=\4\b\3=\3\t\0025\3\n\0005\4\v\0=\4\f\3=\3\r\0025\3\14\0005\4\15\0=\4\f\3=\3\16\0025\3\17\0=\3\18\2B\0\2\1K\0\1\0\rfloating\1\0\0\ttray\1\2\0\0\trepl\1\0\3\rposition\vbottom\vheight\3\n\18open_on_start\2\fsidebar\relements\1\5\0\0\vscopes\16breakpoints\vstacks\fwatches\1\0\3\rposition\tleft\nwidth\3(\18open_on_start\2\rmappings\vexpand\1\0\4\topen\6o\trepl\6r\tedit\6e\vremove\6d\1\3\0\0\t<CR>\18<2-LeftMouse>\nicons\1\0\0\1\0\2\rexpanded\6-\14collapsed\6+\nsetup\ndapui\frequire\0" },
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/nvim-dap-ui"
  },
  ["nvim-hardline"] = {
    config = { "\27LJ\2\nÌ\6\0\0\b\0!\0S6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\n\0005\4\4\0006\5\0\0'\a\5\0B\5\2\0029\5\6\5=\5\a\4>\4\1\0035\4\b\0006\5\0\0'\a\t\0B\5\2\0029\5\6\5=\5\a\4>\4\2\0035\4\v\0006\5\0\0'\a\f\0B\5\2\0029\5\6\5=\5\a\4>\4\4\0035\4\r\0>\4\5\0035\4\14\0006\5\0\0'\a\15\0B\5\2\0029\5\16\5=\5\a\4>\4\6\0035\4\17\0006\5\0\0'\a\18\0B\5\2\0029\5\6\5=\5\a\4>\4\a\0035\4\19\0006\5\0\0'\a\20\0B\5\2\0029\5\21\5=\5\a\4>\4\b\0035\4\22\0006\5\0\0'\a\20\0B\5\2\0029\5\23\5=\5\a\4>\4\t\0035\4\24\0006\5\0\0'\a\25\0B\5\2\0029\5\6\5=\5\a\4>\4\n\0035\4\26\0006\5\0\0'\a\27\0B\5\2\0029\5\6\5=\5\a\4>\4\v\0035\4\28\0006\5\0\0'\a\29\0B\5\2\0029\5\6\5=\5\a\4>\4\f\3=\3\30\0025\3\31\0=\3 \2B\0\2\1K\0\1\0\24bufferline_settings\1\0\2\15show_index\1\21exclude_terminal\1\rsections\24hardline.parts.line\1\0\1\nclass\tmode\28hardline.parts.filetype\1\0\2\nclass\thigh\thide\3P\30hardline.parts.whitespace\1\0\1\nclass\fwarning\16get_warning\1\0\1\nclass\fwarning\14get_error\23hardline.parts.lsp\1\0\1\nclass\nerror\29hardline.parts.wordcount\1\0\2\nclass\blow\thide\3P\vstatus\15lsp-status\1\0\1\nclass\tmode\1\0\2\titem\a%=\nclass\bmed\28hardline.parts.filename\1\0\1\nclass\bmed\1\4\0\0\0\0\a%<\23hardline.parts.git\1\0\2\nclass\thigh\thide\3P\titem\rget_item\24hardline.parts.mode\1\0\1\nclass\tmode\1\0\2\15bufferline\1\ntheme\tnord\nsetup\rhardline\frequire\0" },
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/nvim-hardline"
  },
  ["nvim-lightbulb"] = {
    config = { "\27LJ\2\ns\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0Tautocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/nvim-lightbulb"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\nA\2\0\4\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\2\0\0G\3\0\0A\0\1\1K\0\1\0\1¿\24nvim_buf_set_keymap\bapi\bvimA\2\0\4\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\2\0\0G\3\0\0A\0\1\1K\0\1\0\1¿\24nvim_buf_set_option\bapi\bvim∫\r\1\2\v\1-\0z3\2\0\0003\3\1\0006\4\2\0009\4\3\0049\4\4\4'\6\5\0B\4\2\1\18\4\3\0'\6\6\0'\a\a\0B\4\3\0015\4\b\0\18\5\2\0'\a\t\0'\b\n\0'\t\v\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\f\0'\t\r\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\14\0'\t\15\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\16\0'\t\17\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\18\0'\t\19\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\20\0'\t\21\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\22\0'\t\23\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\24\0'\t\25\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\26\0'\t\27\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\28\0'\t\29\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\30\0'\t\31\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b \0'\t!\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\"\0'\t#\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b$\0'\t%\0\18\n\4\0B\5\5\1\18\5\2\0'\a&\0'\b$\0'\t'\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b(\0'\t)\0\18\n\4\0B\5\5\0016\5*\0'\a+\0B\5\2\0029\5,\5\18\a\0\0\18\b\1\0B\5\3\1-\5\0\0009\5,\5\18\a\0\0\18\b\1\0B\5\3\0012\0\0ÄK\0\1\0\1¿\14on_attach\18lsp_signature\frequiree<Cmd>lua require('telescope.builtin').lsp_definitions(require'telescope.themes'.get_ivy { })<CR>\15<leader>gd}<Cmd>lua require('telescope.builtin').lsp_range_code_actions(require'telescope.themes'.get_cursor { winblend = 10 })<CR>\6vw<Cmd>lua require('telescope.builtin').lsp_code_actions(require'telescope.themes'.get_cursor { winblend = 10 })<CR>\15<leader>cad<Cmd>lua require('telescope.builtin').lsp_references(require'telescope.themes'.get_ivy { })<CR>\15<leader>gr*<cmd>lua vim.lsp.buf.formatting()<CR>\14<space>,.2<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>\r<space>q0<cmd>lua vim.lsp.diagnostic.goto_next()<CR>\a]e0<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>\a[e<<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>\r<space>e&<cmd>lua vim.lsp.buf.rename()<CR>\14<space>rn/<cmd>lua vim.lsp.buf.type_definition()<CR>\r<space>D.<cmd>lua vim.lsp.buf.signature_help()<CR>\n<C-k>.<cmd>lua vim.lsp.buf.implementation()<CR>\agi%<Cmd>lua vim.lsp.buf.hover()<CR>\6K*<Cmd>lua vim.lsp.buf.definition()<CR>\n<C-]>+<Cmd>lua vim.lsp.buf.declaration()<CR>\agD\6n\1\0\2\vsilent\2\fnoremap\2\27v:lua.vim.lsp.omnifunc\romnifuncTautocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()\17nvim_command\bapi\bvim\0\0Ì\2\1\0\15\0\19\0%6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\1B\2\1\0019\2\4\0016\3\5\0009\3\6\3'\5\a\0006\6\5\0009\6\b\0069\6\t\0069\6\n\6B\6\1\2\18\a\2\0B\3\4\0023\4\v\0005\5\f\0006\6\r\0\18\b\5\0B\6\2\4X\t\bÄ8\v\n\0009\v\14\v5\r\15\0=\4\16\r=\3\4\r5\14\17\0=\14\18\rB\v\2\1E\t\3\3R\tˆ2\0\0ÄK\0\1\0\nflags\1\0\1\26debounce_text_changes\3ñ\1\14on_attach\1\0\0\nsetup\vipairs\1\3\0\0\16clojure_lsp\18rust_analyzer\0\29make_client_capabilities\rprotocol\blsp\nforce\15tbl_extend\bvim\17capabilities\22register_progress\15lsp-status\14lspconfig\frequire\0" },
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nÖ\3\0\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0005\4\a\0=\4\b\3=\3\t\0025\3\n\0005\4\v\0=\4\f\3=\3\r\0025\3\14\0=\3\15\2B\0\2\1K\0\1\0\frainbow\1\0\3\venable\2\19max_file_lines\3†\31\18extended_mode\1\vindent\fdisable\1\2\0\0\vpython\1\0\1\venable\2\26incremental_selection\fkeymaps\1\0\4\22scope_incremental\bgrc\19init_selection\bgnn\21node_decremental\bgrm\21node_incremental\bgrn\1\0\1\venable\2\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["octo.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\tocto\frequire\0" },
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/octo.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["parinfer-rust"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/opt/parinfer-rust"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["rust-tools.nvim"] = {
    config = { "\27LJ\2\n<\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\15rust-tools\frequire\0" },
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/rust-tools.nvim"
  },
  taskwiki = {
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/taskwiki"
  },
  ["telescope-fzf-writer.nvim"] = {
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/telescope-fzf-writer.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\nƒ\n\0\0\b\0+\0k6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0015\3\r\0005\4\v\0005\5\a\0005\6\5\0009\a\4\0=\a\6\6=\6\b\0055\6\t\0009\a\4\0=\a\6\6=\6\n\5=\5\f\4=\4\14\0035\4\16\0005\5\15\0=\5\17\4=\4\18\3B\1\2\0015\1\19\0006\2\20\0009\2\21\0029\2\22\2'\4\n\0'\5\23\0'\6\24\0\18\a\1\0B\2\5\0016\2\20\0009\2\21\0029\2\22\2'\4\n\0'\5\25\0'\6\26\0\18\a\1\0B\2\5\0016\2\20\0009\2\21\0029\2\22\2'\4\n\0'\5\27\0'\6\28\0\18\a\1\0B\2\5\0016\2\20\0009\2\21\0029\2\22\2'\4\n\0'\5\29\0'\6\30\0\18\a\1\0B\2\5\0016\2\20\0009\2\21\0029\2\22\2'\4\n\0'\5\31\0'\6 \0\18\a\1\0B\2\5\0016\2\20\0009\2\21\0029\2\22\2'\4\n\0'\5!\0'\6\"\0\18\a\1\0B\2\5\0016\2\20\0009\2\21\0029\2\22\2'\4\n\0'\5#\0'\6$\0\18\a\1\0B\2\5\0016\2\20\0009\2\21\0029\2\22\2'\4\n\0'\5%\0'\6&\0\18\a\1\0B\2\5\0016\2\20\0009\2\21\0029\2\22\2'\4\n\0'\5'\0'\6(\0\18\a\1\0B\2\5\0016\2\20\0009\2\21\0029\2\22\2'\4\n\0'\5)\0'\6*\0\18\a\1\0B\2\5\1K\0\1\0009<Cmd>lua require('telescope.builtin').commands()<CR>\18<Leader><tab>:<Cmd>lua require('telescope.builtin').git_stash()<CR>\15<Leader>gS;<Cmd>lua require('telescope.builtin').git_status()<CR>\15<Leader>gs=<Cmd>lua require('telescope.builtin').git_branches()<CR>\15<Leader>gbC<Cmd>lua require('telescope').extensions.fzf_writer.grep()<CR>\15<Leader>bg9<Cmd>lua require('telescope.builtin').oldfiles()<CR>\15<Leader>bo5<Cmd>lua require('telescope.builtin').tags()<CR>\15<Leader>bt8<Cmd>lua require('telescope.builtin').buffers()<CR>\15<Leader>bb:<Cmd>lua require('telescope.builtin').git_files()<CR>\15<Leader>bf;<Cmd>lua require('telescope.builtin').find_files()<CR>\15<Leader>bF\20nvim_set_keymap\bapi\bvim\1\0\2\vsilent\2\fnoremap\2\15extensions\15fzf_writer\1\0\0\1\0\3\28minimum_grep_characters\3\2\20use_highlighter\2\29minimum_files_characters\3\2\rdefaults\1\0\0\rmappings\1\0\0\6n\1\0\0\6i\1\0\0\n<c-t>\1\0\0\22open_with_trouble\nsetup\14telescope trouble.providers.telescope\frequire\0" },
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0" },
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/todo-comments.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\14auto_fold\2\17auto_preview\1\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  ultisnips = {
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-mundo"] = {
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/vim-mundo"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  vimwiki = {
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/vimwiki"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/Users/alexx/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\nƒ\n\0\0\b\0+\0k6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0015\3\r\0005\4\v\0005\5\a\0005\6\5\0009\a\4\0=\a\6\6=\6\b\0055\6\t\0009\a\4\0=\a\6\6=\6\n\5=\5\f\4=\4\14\0035\4\16\0005\5\15\0=\5\17\4=\4\18\3B\1\2\0015\1\19\0006\2\20\0009\2\21\0029\2\22\2'\4\n\0'\5\23\0'\6\24\0\18\a\1\0B\2\5\0016\2\20\0009\2\21\0029\2\22\2'\4\n\0'\5\25\0'\6\26\0\18\a\1\0B\2\5\0016\2\20\0009\2\21\0029\2\22\2'\4\n\0'\5\27\0'\6\28\0\18\a\1\0B\2\5\0016\2\20\0009\2\21\0029\2\22\2'\4\n\0'\5\29\0'\6\30\0\18\a\1\0B\2\5\0016\2\20\0009\2\21\0029\2\22\2'\4\n\0'\5\31\0'\6 \0\18\a\1\0B\2\5\0016\2\20\0009\2\21\0029\2\22\2'\4\n\0'\5!\0'\6\"\0\18\a\1\0B\2\5\0016\2\20\0009\2\21\0029\2\22\2'\4\n\0'\5#\0'\6$\0\18\a\1\0B\2\5\0016\2\20\0009\2\21\0029\2\22\2'\4\n\0'\5%\0'\6&\0\18\a\1\0B\2\5\0016\2\20\0009\2\21\0029\2\22\2'\4\n\0'\5'\0'\6(\0\18\a\1\0B\2\5\0016\2\20\0009\2\21\0029\2\22\2'\4\n\0'\5)\0'\6*\0\18\a\1\0B\2\5\1K\0\1\0009<Cmd>lua require('telescope.builtin').commands()<CR>\18<Leader><tab>:<Cmd>lua require('telescope.builtin').git_stash()<CR>\15<Leader>gS;<Cmd>lua require('telescope.builtin').git_status()<CR>\15<Leader>gs=<Cmd>lua require('telescope.builtin').git_branches()<CR>\15<Leader>gbC<Cmd>lua require('telescope').extensions.fzf_writer.grep()<CR>\15<Leader>bg9<Cmd>lua require('telescope.builtin').oldfiles()<CR>\15<Leader>bo5<Cmd>lua require('telescope.builtin').tags()<CR>\15<Leader>bt8<Cmd>lua require('telescope.builtin').buffers()<CR>\15<Leader>bb:<Cmd>lua require('telescope.builtin').git_files()<CR>\15<Leader>bf;<Cmd>lua require('telescope.builtin').find_files()<CR>\15<Leader>bF\20nvim_set_keymap\bapi\bvim\1\0\2\vsilent\2\fnoremap\2\15extensions\15fzf_writer\1\0\0\1\0\3\28minimum_grep_characters\3\2\20use_highlighter\2\29minimum_files_characters\3\2\rdefaults\1\0\0\rmappings\1\0\0\6n\1\0\0\6i\1\0\0\n<c-t>\1\0\0\22open_with_trouble\nsetup\14telescope trouble.providers.telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\14auto_fold\2\17auto_preview\1\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: octo.nvim
time([[Config for octo.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\tocto\frequire\0", "config", "octo.nvim")
time([[Config for octo.nvim]], false)
-- Config for: nvim-comment
time([[Config for nvim-comment]], true)
try_loadstring("\27LJ\2\nt\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\17line_mapping\15<leader>c \21operator_mapping\14<leader>c\nsetup\17nvim_comment\frequire\0", "config", "nvim-comment")
time([[Config for nvim-comment]], false)
-- Config for: nvim-compe
time([[Config for nvim-compe]], true)
try_loadstring("\27LJ\2\nF\0\1\a\0\3\0\b6\1\0\0009\1\1\0019\1\2\1\18\3\0\0+\4\2\0+\5\2\0+\6\2\0D\1\5\0\27nvim_replace_termcodes\bapi\bvim£\1\0\0\6\0\b\2\0306\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\23\0\0\0\b\0\1\0X\1\16Ä6\1\0\0009\1\1\0019\1\4\1'\3\3\0B\1\2\2\18\3\1\0009\1\5\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\6\1'\4\a\0B\1\3\2\15\0\1\0X\2\3Ä+\1\2\0L\1\2\0X\1\2Ä+\1\1\0L\1\2\0K\0\1\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\bvim\2\0£\2\0\0\3\2\t\1&6\0\0\0009\0\1\0009\0\2\0B\0\1\2\t\0\0\0X\0\4Ä-\0\0\0'\2\3\0D\0\2\0X\0\27Ä6\0\0\0009\0\1\0009\0\4\0B\0\1\2\b\0\0\0X\0\6Ä6\0\0\0009\0\1\0009\0\5\0B\0\1\2\t\0\0\0X\0\4Ä-\0\0\0'\2\6\0D\0\2\0X\0\vÄ-\0\1\0B\0\1\2\15\0\0\0X\1\4Ä-\0\0\0'\2\a\0D\0\2\0X\0\3Ä-\0\0\0'\2\b\0D\0\2\0K\0\1\0\0¿\1¿\6 \n<Tab>.<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>\30UltiSnips#CanJumpForwards\31UltiSnips#CanExpandSnippet\n<C-n>\15pumvisible\afn\bvim\2…\1\0\0\3\1\a\1\0246\0\0\0009\0\1\0009\0\2\0B\0\1\2\t\0\0\0X\0\4Ä-\0\0\0'\2\3\0D\0\2\0X\0\rÄ6\0\0\0009\0\1\0009\0\4\0B\0\1\2\t\0\0\0X\0\4Ä-\0\0\0'\2\5\0D\0\2\0X\0\3Ä-\0\0\0'\2\6\0D\0\2\0K\0\1\0\0¿\f<S-Tab>(<C-R>=UltiSnips#JumpBackwards()<CR>\31UltiSnips#CanJumpBackwards\n<C-p>\15pumvisible\afn\bvim\2“\1\0\0\4\0\n\2\0236\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1B\1\1\2\t\1\0\0X\1\fÄ6\1\2\0009\1\3\0019\1\5\1B\1\1\0029\1\6\1\b\1\1\0X\1\5Ä6\1\2\0009\1\3\0019\1\a\1'\3\b\0D\1\2\0009\1\t\0D\1\1\0\26check_break_line_char\t<CR>\18compe#confirm\rselected\18complete_info\15pumvisible\afn\bvim\19nvim-autopairs\frequire\2˛ˇˇˇ\31è\a\1\0\b\0#\0A6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\3=\3\a\0025\3\b\0=\3\t\2B\0\2\0013\0\n\0003\1\v\0006\2\f\0003\3\14\0=\3\r\0026\2\f\0003\3\16\0=\3\15\0026\2\17\0009\2\18\0029\2\19\2'\4\20\0'\5\21\0'\6\22\0005\a\23\0B\2\5\0016\2\17\0009\2\18\0029\2\19\2'\4\24\0'\5\21\0'\6\22\0005\a\25\0B\2\5\0016\2\17\0009\2\18\0029\2\19\2'\4\20\0'\5\26\0'\6\27\0005\a\28\0B\2\5\0016\2\17\0009\2\18\0029\2\19\2'\4\24\0'\5\26\0'\6\27\0005\a\29\0B\2\5\0016\2\f\0003\3\31\0=\3\30\0026\2\17\0009\2\18\0029\2\19\2'\4\20\0'\5 \0'\6!\0005\a\"\0B\2\5\0012\0\0ÄK\0\1\0\1\0\1\texpr\2\24v:lua.completions()\t<CR>\0\16completions\1\0\1\texpr\2\1\0\1\texpr\2\27v:lua.s_tab_complete()\f<S-Tab>\1\0\1\texpr\2\6s\1\0\1\texpr\2\25v:lua.tab_complete()\n<Tab>\6i\20nvim_set_keymap\bapi\bvim\0\19s_tab_complete\0\17tab_complete\a_G\0\0\vsource\1\0\b\rnvim_lsp\2\vbuffer\2\rnvim_lua\2\tcalc\2\tpath\2\nvsnip\1\14ultisnips\2\fluasnip\1\18documentation\vborder\1\0\4\15min_height\3\1\17winhighlightHNormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder\14max_width\3x\14min_width\3<\1\t\0\0\5\5\5\6 \5\5\5\6 \1\0\f\18throttle_time\3P\14preselect\venable\15min_length\3\1\17autocomplete\2\fenabled\2\19source_timeout\3»\1\19max_menu_width\3d\19max_kind_width\3d\19max_abbr_width\3d\21incomplete_delay\3ê\3\20resolve_timeout\3†\6\ndebug\1\nsetup\ncompe\frequire\0", "config", "nvim-compe")
time([[Config for nvim-compe]], false)
-- Config for: goto-preview
time([[Config for goto-preview]], true)
try_loadstring("\27LJ\2\nZ\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\21default_mappings\2\ndebug\2\nsetup\17goto-preview\frequire\0", "config", "goto-preview")
time([[Config for goto-preview]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: FTerm.nvim
time([[Config for FTerm.nvim]], true)
try_loadstring("\27LJ\2\nÅ\2\0\0\b\0\f\0\0226\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0005\1\6\0\18\2\0\0'\4\a\0'\5\b\0'\6\t\0\18\a\1\0B\2\5\1\18\2\0\0'\4\n\0'\5\b\0'\6\v\0\18\a\1\0B\2\5\1K\0\1\0005<C-\\><C-n><CMD>lua require(\"FTerm\").toggle()<CR>\6t+<CMD>lua require(\"FTerm\").toggle()<CR>\n<A-i>\6n\1\0\2\vsilent\2\fnoremap\2\20nvim_set_keymap\bapi\bvim\nsetup\nFTerm\frequire\0", "config", "FTerm.nvim")
time([[Config for FTerm.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\nA\2\0\4\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\2\0\0G\3\0\0A\0\1\1K\0\1\0\1¿\24nvim_buf_set_keymap\bapi\bvimA\2\0\4\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\2\0\0G\3\0\0A\0\1\1K\0\1\0\1¿\24nvim_buf_set_option\bapi\bvim∫\r\1\2\v\1-\0z3\2\0\0003\3\1\0006\4\2\0009\4\3\0049\4\4\4'\6\5\0B\4\2\1\18\4\3\0'\6\6\0'\a\a\0B\4\3\0015\4\b\0\18\5\2\0'\a\t\0'\b\n\0'\t\v\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\f\0'\t\r\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\14\0'\t\15\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\16\0'\t\17\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\18\0'\t\19\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\20\0'\t\21\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\22\0'\t\23\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\24\0'\t\25\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\26\0'\t\27\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\28\0'\t\29\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\30\0'\t\31\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b \0'\t!\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b\"\0'\t#\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b$\0'\t%\0\18\n\4\0B\5\5\1\18\5\2\0'\a&\0'\b$\0'\t'\0\18\n\4\0B\5\5\1\18\5\2\0'\a\t\0'\b(\0'\t)\0\18\n\4\0B\5\5\0016\5*\0'\a+\0B\5\2\0029\5,\5\18\a\0\0\18\b\1\0B\5\3\1-\5\0\0009\5,\5\18\a\0\0\18\b\1\0B\5\3\0012\0\0ÄK\0\1\0\1¿\14on_attach\18lsp_signature\frequiree<Cmd>lua require('telescope.builtin').lsp_definitions(require'telescope.themes'.get_ivy { })<CR>\15<leader>gd}<Cmd>lua require('telescope.builtin').lsp_range_code_actions(require'telescope.themes'.get_cursor { winblend = 10 })<CR>\6vw<Cmd>lua require('telescope.builtin').lsp_code_actions(require'telescope.themes'.get_cursor { winblend = 10 })<CR>\15<leader>cad<Cmd>lua require('telescope.builtin').lsp_references(require'telescope.themes'.get_ivy { })<CR>\15<leader>gr*<cmd>lua vim.lsp.buf.formatting()<CR>\14<space>,.2<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>\r<space>q0<cmd>lua vim.lsp.diagnostic.goto_next()<CR>\a]e0<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>\a[e<<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>\r<space>e&<cmd>lua vim.lsp.buf.rename()<CR>\14<space>rn/<cmd>lua vim.lsp.buf.type_definition()<CR>\r<space>D.<cmd>lua vim.lsp.buf.signature_help()<CR>\n<C-k>.<cmd>lua vim.lsp.buf.implementation()<CR>\agi%<Cmd>lua vim.lsp.buf.hover()<CR>\6K*<Cmd>lua vim.lsp.buf.definition()<CR>\n<C-]>+<Cmd>lua vim.lsp.buf.declaration()<CR>\agD\6n\1\0\2\vsilent\2\fnoremap\2\27v:lua.vim.lsp.omnifunc\romnifuncTautocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()\17nvim_command\bapi\bvim\0\0Ì\2\1\0\15\0\19\0%6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\1B\2\1\0019\2\4\0016\3\5\0009\3\6\3'\5\a\0006\6\5\0009\6\b\0069\6\t\0069\6\n\6B\6\1\2\18\a\2\0B\3\4\0023\4\v\0005\5\f\0006\6\r\0\18\b\5\0B\6\2\4X\t\bÄ8\v\n\0009\v\14\v5\r\15\0=\4\16\r=\3\4\r5\14\17\0=\14\18\rB\v\2\1E\t\3\3R\tˆ2\0\0ÄK\0\1\0\nflags\1\0\1\26debounce_text_changes\3ñ\1\14on_attach\1\0\0\nsetup\vipairs\1\3\0\0\16clojure_lsp\18rust_analyzer\0\29make_client_capabilities\rprotocol\blsp\nforce\15tbl_extend\bvim\17capabilities\22register_progress\15lsp-status\14lspconfig\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: rust-tools.nvim
time([[Config for rust-tools.nvim]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\15rust-tools\frequire\0", "config", "rust-tools.nvim")
time([[Config for rust-tools.nvim]], false)
-- Config for: nvim-dap-ui
time([[Config for nvim-dap-ui]], true)
try_loadstring("\27LJ\2\nÜ\3\0\0\5\0\19\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\a\0005\4\6\0=\4\b\3=\3\t\0025\3\n\0005\4\v\0=\4\f\3=\3\r\0025\3\14\0005\4\15\0=\4\f\3=\3\16\0025\3\17\0=\3\18\2B\0\2\1K\0\1\0\rfloating\1\0\0\ttray\1\2\0\0\trepl\1\0\3\rposition\vbottom\vheight\3\n\18open_on_start\2\fsidebar\relements\1\5\0\0\vscopes\16breakpoints\vstacks\fwatches\1\0\3\rposition\tleft\nwidth\3(\18open_on_start\2\rmappings\vexpand\1\0\4\topen\6o\trepl\6r\tedit\6e\vremove\6d\1\3\0\0\t<CR>\18<2-LeftMouse>\nicons\1\0\0\1\0\2\rexpanded\6-\14collapsed\6+\nsetup\ndapui\frequire\0", "config", "nvim-dap-ui")
time([[Config for nvim-dap-ui]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nÖ\3\0\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0005\4\a\0=\4\b\3=\3\t\0025\3\n\0005\4\v\0=\4\f\3=\3\r\0025\3\14\0=\3\15\2B\0\2\1K\0\1\0\frainbow\1\0\3\venable\2\19max_file_lines\3†\31\18extended_mode\1\vindent\fdisable\1\2\0\0\vpython\1\0\1\venable\2\26incremental_selection\fkeymaps\1\0\4\22scope_incremental\bgrc\19init_selection\bgnn\21node_decremental\bgrm\21node_incremental\bgrn\1\0\1\venable\2\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: nvim-lightbulb
time([[Config for nvim-lightbulb]], true)
try_loadstring("\27LJ\2\ns\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0Tautocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()\bcmd\bvim\0", "config", "nvim-lightbulb")
time([[Config for nvim-lightbulb]], false)
-- Config for: nvim-hardline
time([[Config for nvim-hardline]], true)
try_loadstring("\27LJ\2\nÌ\6\0\0\b\0!\0S6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\n\0005\4\4\0006\5\0\0'\a\5\0B\5\2\0029\5\6\5=\5\a\4>\4\1\0035\4\b\0006\5\0\0'\a\t\0B\5\2\0029\5\6\5=\5\a\4>\4\2\0035\4\v\0006\5\0\0'\a\f\0B\5\2\0029\5\6\5=\5\a\4>\4\4\0035\4\r\0>\4\5\0035\4\14\0006\5\0\0'\a\15\0B\5\2\0029\5\16\5=\5\a\4>\4\6\0035\4\17\0006\5\0\0'\a\18\0B\5\2\0029\5\6\5=\5\a\4>\4\a\0035\4\19\0006\5\0\0'\a\20\0B\5\2\0029\5\21\5=\5\a\4>\4\b\0035\4\22\0006\5\0\0'\a\20\0B\5\2\0029\5\23\5=\5\a\4>\4\t\0035\4\24\0006\5\0\0'\a\25\0B\5\2\0029\5\6\5=\5\a\4>\4\n\0035\4\26\0006\5\0\0'\a\27\0B\5\2\0029\5\6\5=\5\a\4>\4\v\0035\4\28\0006\5\0\0'\a\29\0B\5\2\0029\5\6\5=\5\a\4>\4\f\3=\3\30\0025\3\31\0=\3 \2B\0\2\1K\0\1\0\24bufferline_settings\1\0\2\15show_index\1\21exclude_terminal\1\rsections\24hardline.parts.line\1\0\1\nclass\tmode\28hardline.parts.filetype\1\0\2\nclass\thigh\thide\3P\30hardline.parts.whitespace\1\0\1\nclass\fwarning\16get_warning\1\0\1\nclass\fwarning\14get_error\23hardline.parts.lsp\1\0\1\nclass\nerror\29hardline.parts.wordcount\1\0\2\nclass\blow\thide\3P\vstatus\15lsp-status\1\0\1\nclass\tmode\1\0\2\titem\a%=\nclass\bmed\28hardline.parts.filename\1\0\1\nclass\bmed\1\4\0\0\0\0\a%<\23hardline.parts.git\1\0\2\nclass\thigh\thide\3P\titem\rget_item\24hardline.parts.mode\1\0\1\nclass\tmode\1\0\2\15bufferline\1\ntheme\tnord\nsetup\rhardline\frequire\0", "config", "nvim-hardline")
time([[Config for nvim-hardline]], false)
-- Config for: nvim-dap
time([[Config for nvim-dap]], true)
try_loadstring("\27LJ\2\ng\0\0\5\0\a\0\f6\0\0\0009\0\1\0009\0\2\0'\2\3\0006\3\0\0009\3\1\0039\3\4\3B\3\1\2'\4\5\0&\3\4\3'\4\6\0D\0\4\0\tfile\6/\vgetcwd\25Path to executable: \ninput\afn\bvim•\2\1\0\5\0\v\0\0166\0\0\0'\2\1\0B\0\2\0029\1\2\0005\2\4\0=\2\3\0019\1\5\0004\2\3\0005\3\a\0003\4\b\0=\4\t\0034\4\0\0=\4\n\3>\3\1\2=\2\6\1K\0\1\0\targs\fprogram\0\1\0\6\tname\vLaunch\ttype\tlldb\frequest\vlaunch\16stopOnEntry\1\bcwd\23${workspaceFolder}\18runInTerminal\1\trust\19configurations\1\0\3\fcommand&/Users/alexx/.cargo/bin/rust-lldb\tname\tlldb\ttype\15executable\tlldb\radapters\bdap\frequire\0", "config", "nvim-dap")
time([[Config for nvim-dap]], false)
-- Config for: neogit
time([[Config for neogit]], true)
try_loadstring("\27LJ\2\n]\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\17integrations\1\0\0\1\0\1\rdiffview\2\nsetup\vneogit\frequire\0", "config", "neogit")
time([[Config for neogit]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType clojure ++once lua require("packer.load")({'parinfer-rust', 'conjure'}, { ft = "clojure" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
