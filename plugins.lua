local packer = require("packer")
local use = packer.use

return require("packer").startup(
  function()
    -- packer itself
    use "wbthomason/packer.nvim"

    -- Vim stuff {
    use "nvim-lua/plenary.nvim"
    use "junegunn/vim-easy-align"
    use "godlygeek/tabular"
    use {"folke/which-key.nvim",
      config = function ()
        require('which-key').setup{}
      end
    }
    use 'folke/tokyonight.nvim'
    use {"folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup {}
      end
    }
    use {"folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {
          auto_fold = true,
          auto_preview = false,
        }
      end
    }
    use {"terrortylor/nvim-comment",
      config = function ()
          require('nvim_comment').setup {
            -- Normal mode mapping left hand side
            line_mapping = "<leader>c ",
            -- Visual/Operator mapping left hand side
            operator_mapping = "<leader>c"
          }
        end
    }
    use {"windwp/nvim-autopairs",
      config = function() require('nvim-autopairs').setup() end
    }
    use "p00f/nvim-ts-rainbow"
    use {"lewis6991/gitsigns.nvim",
      config = function ()
        require('gitsigns').setup{}
      end
    }
    -- TODO: configure and set bindings through mapper
    -- use {"lazytanuki/nvim-mapper",
    --      config = function() require"nvim-mapper".setup {} end }
    use {"numtostr/FTerm.nvim",
        config = function()
            local map = vim.api.nvim_set_keymap
            local opts = { noremap = true, silent = true }

            map('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>', opts)
            map('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
        end
    }
    use 'kyazdani42/nvim-tree.lua'
    use 'famiu/bufdelete.nvim'
    use {'ojroques/nvim-hardline',
      config = function()
        require('hardline').setup {
          bufferline = false,  -- enable bufferline
          theme = 'nord',   -- change theme
          sections = {         -- define sections
            {class = 'mode', item = require('hardline.parts.mode').get_item},
            {class = 'high', item = require('hardline.parts.git').get_item, hide = 80},
            '%<',
            {class = 'med', item = require('hardline.parts.filename').get_item},
            {class = 'med', item ='%='},
            {class = 'mode', item = require('lsp-status').status},
            {class = 'low', item = require('hardline.parts.wordcount').get_item, hide = 80},
            {class = 'error', item = require('hardline.parts.lsp').get_error},
            {class = 'warning', item = require('hardline.parts.lsp').get_warning},
            {class = 'warning', item = require('hardline.parts.whitespace').get_item},
            {class = 'high', item = require('hardline.parts.filetype').get_item, hide = 80},
            {class = 'mode', item = require('hardline.parts.line').get_item}
          },
          bufferline_settings = {
            exclude_terminal = false,  -- don't show terminal buffers in bufferline
            show_index = false,        -- show buffer indexes (not the actual buffer numbers) in bufferline
          },
        }
      end
    }
    use {'simnalamburt/vim-mundo'}
    -- }

    -- Telescope {
    use {"nvim-telescope/telescope-fzf-writer.nvim"}
    use {"nvim-telescope/telescope-frecency.nvim",
         requires = {"tami5/sql.nvim"}}
    use {"nvim-telescope/telescope-dap.nvim"}
    use {"nvim-telescope/telescope.nvim",
      requires = {
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'},
        {'nvim-telescope/telescope-fzf-writer.nvim'},
        {"nvim-telescope/telescope-frecency.nvim"},
        {'ThePrimeagen/git-worktree.nvim'},
        {"nvim-telescope/telescope-dap.nvim"}
      },
      config = function()
        local trouble = require('trouble.providers.telescope')
        local telescope = require('telescope')
        telescope.setup{
          defaults = {
            mappings = {
              i = { ["<c-t>"] = trouble.open_with_trouble },
              n = { ["<c-t>"] = trouble.open_with_trouble },
            },
          },
          extensions = {
            fzf_writer = {
              minimum_grep_characters = 2,
              minimum_files_characters = 2,
              -- Disabled by default.
              -- Will probably slow down some aspects of the sorter, but can make color highlights.
              -- I will work on this more later.
              use_highlighter = true,
            }
          }
        }
        telescope.load_extension("git_worktree")
        telescope.load_extension("dap")
        telescope.load_extension("fzf_writer")
        telescope.load_extension("frecency")
        local opts = { noremap=true, silent=true }
        -- mappings {
          -- Buffer/file stuff {
            vim.api.nvim_set_keymap("n", "<Leader>bF", "<Cmd>lua require('telescope.builtin').find_files()<CR>", opts)
            vim.api.nvim_set_keymap("n", "<Leader>bf", "<Cmd>lua require('telescope.builtin').git_files()<CR>", opts)
            vim.api.nvim_set_keymap("n", "<Leader>bb", "<Cmd>lua require('telescope.builtin').buffers()<CR>", opts)
            vim.api.nvim_set_keymap("n", "<Leader>bt", "<Cmd>lua require('telescope.builtin').tags()<CR>", opts)
            vim.api.nvim_set_keymap("n", "<Leader>bo", "<Cmd>lua require('telescope.builtin').oldfiles()<CR>", opts)
            vim.api.nvim_set_keymap("n", "<Leader>bg", "<Cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
          -- }
          -- Git stuff {
            vim.api.nvim_set_keymap("n", "<Leader>gb", "<Cmd>lua require('telescope.builtin').git_branches()<CR>", opts)
            vim.api.nvim_set_keymap("n", "<Leader>gs", "<Cmd>lua require('telescope.builtin').git_status()<CR>", opts)
            vim.api.nvim_set_keymap("n", "<Leader>gS", "<Cmd>lua require('telescope.builtin').git_stash()<CR>", opts)
          -- }
          -- DAP Stuff {
            vim.api.nvim_set_keymap('n', '<leader>dcc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>', opts)
            vim.api.nvim_set_keymap('n', '<leader>dco', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>', opts)
            vim.api.nvim_set_keymap('n', '<leader>dlb', '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>', opts)
            vim.api.nvim_set_keymap('n', '<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>', opts)
            vim.api.nvim_set_keymap('n', '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>', opts)
          -- }
          -- Commands {
            vim.api.nvim_set_keymap("n", "<Leader><tab>", "<Cmd>lua require('telescope.builtin').commands()<CR>", opts)
          -- }
        -- }
      end
    }
    --}

    -- lsp {
    -- use {'doums/lsp_spinner.nvim',
    -- config= function()
    --     require'lsp_spinner'.setup {
    --     }
    --   end}
    use {"nvim-lua/lsp-status.nvim"}
    use {"simrat39/symbols-outline.nvim"}
    use "folke/lsp-colors.nvim"
    use {"ray-x/lsp_signature.nvim",}
    use {"rmagatti/goto-preview",
      config = function()
        require('goto-preview').setup {
          default_mappings = true,
          debug = false
        }
      end
    }
    use {"kosayoda/nvim-lightbulb",
    config = function()
      vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
    end}
    use {"neovim/nvim-lspconfig",
      requires = {
        {"nvim-lua/lsp-status.nvim"},
        {"ray-x/lsp_signature.nvim"},
        {"kosayoda/nvim-lightbulb"},
      },
      config = function ()
        local nvim_lsp = require('lspconfig')

        local lsp_status = require("lsp-status")
        lsp_status.register_progress()
        local capabilities = lsp_status.capabilities

        local capabilities = vim.tbl_extend('force', vim.lsp.protocol.make_client_capabilities(), capabilities)
        capabilities = require'coq'.lsp_ensure_capabilities(capabilities)

        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = function(client, bufnr)
          local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
          local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

          vim.api.nvim_command("autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()")
          --Enable completion triggered by <c-x><c-o>
          buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

          -- Mappings {
          local opts = { noremap=true, silent=true }


          -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
          -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
          -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
          -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',      opts)

          -- See `:help vim.lsp.*` for documentation on any of the below functions
          buf_set_keymap('n', 'gD',        '<Cmd>lua vim.lsp.buf.declaration()<CR>',      opts)
          buf_set_keymap('n', '<C-]>',     '<Cmd>lua vim.lsp.buf.definition()<CR>',       opts)
          buf_set_keymap('n', 'K',         '<Cmd>lua vim.lsp.buf.hover()<CR>',            opts)
          buf_set_keymap('n', '<C-k>',     '<cmd>lua vim.lsp.buf.signature_help()<CR>',   opts)
          buf_set_keymap('n', '<space>D',  '<cmd>lua vim.lsp.buf.type_definition()<CR>',  opts)
          buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>',           opts)
          buf_set_keymap('n', '<space>e',  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
          buf_set_keymap('n', '[e',        '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
          buf_set_keymap('n', ']e',        '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
          buf_set_keymap('n', '<space>q',  '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
          buf_set_keymap("n", "<space>,.", "<cmd>lua vim.lsp.buf.formatting()<CR>",       opts)
            -- Telescope {
            buf_set_keymap("n", "<leader>gr", "<Cmd>lua require('telescope.builtin').lsp_references(require'telescope.themes'.get_ivy { })<CR>", opts)
            buf_set_keymap("n", "<leader>ca", "<Cmd>lua require('telescope.builtin').lsp_code_actions(require'telescope.themes'.get_cursor { winblend = 10 })<CR>", opts)
            buf_set_keymap("v", "<leader>ca", "<Cmd>lua require('telescope.builtin').lsp_range_code_actions(require'telescope.themes'.get_cursor { winblend = 10 })<CR>", opts)
            buf_set_keymap("n", "<leader>gd", "<Cmd>lua require('telescope.builtin').lsp_definitions(require'telescope.themes'.get_ivy { })<CR>", opts)
            buf_set_keymap('n', '<leader>gi', "<Cmd>lua require('telescope.builtin').lsp_implementations(require'telescope.themes'.get_ivy { })<CR>",   opts)

            -- }
          -- }

          require'lsp_signature'.on_attach(client, bufnr)
          -- lsp_spinner.on_attach(client, bufnr)
          lsp_status.on_attach(client, bufnr)
        end

        -- Use a loop to conveniently call 'setup' on multiple servers and
        -- map buffer local keybindings when the language server attaches
        local servers = { "clojure_lsp", "rust_analyzer", "yamlls", "pylsp" }
        for _, lsp in ipairs(servers) do
          nvim_lsp[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
              debounce_text_changes = 150,
            }
          }
        end
        nvim_lsp['gopls'].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          filetypes = {"go", "gomod"},
          message_level = vim.lsp.protocol.MessageType.Error,
          cmd = {
            "gopls", -- share the gopls instance if there is one already
            "-remote=auto", --[[ debug options ]] --
            -- "-logfile=auto",
            -- "-debug=:0",
            "-remote.debug=:0"
            -- "-rpc.trace",
          },

          flags = {
            allow_incremental_sync = true,
            debounce_text_changes = 500
          },
          settings = {
            gopls = {
              -- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
              -- flags = {allow_incremental_sync = true, debounce_text_changes = 500},
              -- not supported
              analyses = {
                unusedparams = true,
                unreachable = true
              },
              -- codelenses = {
              --   generate = true, -- show the `go generate` lens.
              --   gc_details = true, --  // Show a code lens toggling the display of gc's choices.
              --   tidy = true -- adding mod tidy
              -- },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              matcher = "fuzzy",
              -- experimentalDiagnosticsDelay = "500ms",
              -- diagnosticsDelay = "500ms",
              -- experimentalWatchedFileDelay = "100ms",
              symbolMatcher = "fuzzy",
              gofumpt = false, -- true, -- turn on for new repos, gofmpt is good but also create code turmoils
              buildFlags = {"-tags", "integration"}
              -- buildFlags = {"-tags", "functional"}
            }
          }
        }
      end
    }
    use {"RishabhRD/popfix"}
    use({'weilbith/nvim-code-action-menu',
      cmd = 'CodeActionMenu',
    })
    use {"onsails/lspkind-nvim",
         config = function ()
           -- body
          require('lspkind').init({
              -- enables text annotations
              --
              -- default: true
              with_text = true,

              -- default symbol map
              -- can be either 'default' (requires nerd-fonts font) or
              -- 'codicons' for codicon preset (requires vscode-codicons font)
              --
              -- default: 'default'
              preset = 'default',

              -- override preset symbols
              --
              -- default: {}
              symbol_map = {},
          })
         end}
    use {"RishabhRD/nvim-lsputils",
         requires = {{"RishabhRD/popfix"}},
         config = function()
           local lsputil_ca = require('lsputil.codeAction')
           local lsputil_loc = require('lsputil.locations')
           local lsputil_sym = require('lsputil.symbols')
           vim.lsp.handlers['textDocument/codeAction'] = lsputil_ca.code_action_handler
           vim.lsp.handlers['textDocument/references'] = lsputil_loc.references_handler
           vim.lsp.handlers['textDocument/definition'] = lsputil_loc.definition_handler
           vim.lsp.handlers['textDocument/declaration'] = lsputil_loc.declaration_handler
           vim.lsp.handlers['textDocument/typeDefinition'] = lsputil_loc.typeDefinition_handler
           vim.lsp.handlers['textDocument/implementation'] = lsputil_loc.implementation_handler
           vim.lsp.handlers['textDocument/documentSymbol'] = lsputil_sym.document_handler
           vim.lsp.handlers['workspace/symbol'] = lsputil_sym.workspace_handler
         end}
    -- }

    -- debug {
    use {"theHamsta/nvim-dap-virtual-text"}
    use {"Pocco81/DAPInstall.nvim", 
      config = function()
        require'dap-install'.config("go_delve", {})
      end}
    use {"mfussenegger/nvim-dap",
      config = function ()
        local dap = require('dap')
        dap.adapters.lldb = {
          type = 'executable',
          command = '/Users/alexx/.cargo/bin/rust-lldb', -- adjust as needed
          name = "lldb"
        }
        dap.configurations.rust = {
            name = "Launch",
            type = "lldb",
            request = "launch",
            program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = {},

            runInTerminal = false,
        }
      end
    }
    use {"rcarriga/nvim-dap-ui",
      requires = {"mfussenegger/nvim-dap"},
      config = function()
        require("dapui").setup({
          icons = {
            expanded = "-",
            collapsed = "+"
          },
          mappings = {
            -- Use a table to apply multiple mappings
            expand = {"<CR>", "<2-LeftMouse>"},
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
          },
          sidebar = {
            elements = {
              -- You can change the order of elements in the sidebar
              "scopes",
              "breakpoints",
              "stacks",
              "watches"
            },
            position = "left" -- Can be "left" or "right"
          },
          tray = {
            elements = {
              "repl"
            },
            position = "bottom" -- Can be "bottom" or "top"
          },
          floating = {
            max_height = nil, -- These can be integers or a float between 0 and 1.
            max_width = nil   -- Floats will be treated as percentage of your screen.
          }
        })
      end
    }
    -- }

    -- treesitter {
    use {"nvim-treesitter/nvim-treesitter",
      config = function ()
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
      end
    }
    -- }

    -- completion {
    use {"honza/vim-snippets"}
    use {"SirVer/ultisnips"}
    use {"ms-jpq/coq_nvim",
         branch="coq",
         requires = {{"ms-jpq/coq.artifacts", branch="artifacts"}}}
--     use {"hrsh7th/nvim-compe",
--       config = function ()
--         require'compe'.setup {
--           enabled = true;
--           autocomplete = true;
--           debug = false;
--           min_length = 1;
--           preselect = 'enable';
--           throttle_time = 80;
--           source_timeout = 200;
--           resolve_timeout = 800;
--           incomplete_delay = 400;
--           max_abbr_width = 100;
--           max_kind_width = 100;
--           max_menu_width = 100;
--           documentation = {
--             border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
--             winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
--             max_width = 120,
--             min_width = 60,
--             --max_height = math.floor(vim.o.lines * 0.3),
--             min_height = 1,
--           };
-- 
--           source = {
--             path = true;
--             buffer = true;
--             calc = true;
--             nvim_lsp = true;
--             nvim_lua = true;
--             vsnip = false;
--             ultisnips = true;
--             luasnip = false;
--           };
--         }
--         local t = function(str)
--             return vim.api.nvim_replace_termcodes(str, true, true, true)
--         end
-- 
--         local check_back_space = function()
--             local col = vim.fn.col(".") - 1
--             if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
--                 return true
--             else
--                 return false
--             end
--         end
-- 
--         -- tab completion
--         _G.tab_complete = function()
--           if vim.fn.pumvisible() == 1 then
--             return t "<C-n>"
--           elseif vim.fn["UltiSnips#CanExpandSnippet"]() == 1 or vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
--             return t "<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>"
--           elseif check_back_space() then
--             return t "<Tab>"
--           else
--             return t " "-- vim.fn["compe#complete"]()
--           end
--         end
-- 
--         _G.s_tab_complete = function()
--           if vim.fn.pumvisible() == 1 then
--             return t "<C-p>"
--           elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
--             return t "<C-R>=UltiSnips#JumpBackwards()<CR>"
--           else
--             return t "<S-Tab>"
--           end
--         end
-- 
--         --  mappings
--         vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
--         vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
--         vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
--         vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- 
--         function _G.completions()
--             local npairs = require("nvim-autopairs")
--             if vim.fn.pumvisible() == 1 then
--                 if vim.fn.complete_info()["selected"] ~= -1 then
--                     return vim.fn["compe#confirm"]("<CR>")
--                 end
--             end
--             return npairs.check_break_line_char()
--         end
--         vim.api.nvim_set_keymap("i", "<CR>", "v:lua.completions()", {expr = true})
--       end
--     }
    -- magic, need OPENAI API kkey
    -- use({ 'jameshiew/nvim-magic',
    --      config = function()
    --        require('nvim-magic').setup()
    --      end,
    --      requires = {
    --        'nvim-lua/plenary.nvim',
    --        'MunifTanjim/nui.nvim'
    --      }
    --    })
    -- }

    -- wiki {
    use 'vimwiki/vimwiki'
    use 'tbabej/taskwiki'
    -- }

    -- git {
    use "sindrets/diffview.nvim"
    use {'TimUntersberger/neogit',
      requires = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim'
      },
      config = function()
        require'neogit'.setup{ integrations = { diffview = true}}
      end
    }
    use {'pwntester/octo.nvim', config=function()
      require"octo".setup()
    end}
    use {'tpope/vim-fugitive'}
    use {'junegunn/gv.vim'}
    use {'ThePrimeagen/git-worktree.nvim',
         config = function()
           require("git-worktree").setup{}
         end}
    -- }

    -- Languages {
      -- Rust {
        use {"simrat39/rust-tools.nvim",
            config = function() require'rust-tools'.setup{} end
        }
      -- }

      -- Clojure {
        use {"Olical/conjure",
          tag = "v4.22.1",
          ft = "clojure",
          config = function()
          vim.api.nvim_set_var("conjure#mapping#doc_word", false)
          end
        }
        use {"eraserhd/parinfer-rust",
          run = "cargo build --release",
          ft = "clojure"
        }
      -- }

      -- Golang {
        use {"fatih/vim-go"}
      -- }
    -- }

  end,
  {
    display = {
      border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"}
    }
  }
)



-- vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker nospell:
