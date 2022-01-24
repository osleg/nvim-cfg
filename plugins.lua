local packer = require("packer")
local use = packer.use

return require("packer").startup(
  function()
    -- packer itself
    use "wbthomason/packer.nvim"

    -- Vim stuff {
    use {'karb94/neoscroll.nvim',
         config = function ()
           require'neoscroll'.setup{
             easing_function = "cubic"
           }
         end}
    use "nvim-lua/plenary.nvim"
    use {'osleg/lightspeed.nvim',
         config = function()
          require('lightspeed').setup{
            override_x=false,
            override_s=true,
            override_motion=false}
         end
    }
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
            line_mapping = "<leader>c<space>",
            -- Visual/Operator mapping left hand side
            operator_mapping = "<leader>cc"
          }
        end
    }
    use "p00f/nvim-ts-rainbow"
    use {"lewis6991/gitsigns.nvim",
      config = function ()
        require('gitsigns').setup{}
      end
    }
    -- TODO: configure and set bindings through mapper
    use {"numtostr/FTerm.nvim",
        config = function()
            local map = vim.api.nvim_set_keymap
            local opts = { noremap = true, silent = true }

            map('n', '<leader>tt', '<CMD>lua require("FTerm").toggle()<CR>', opts)
            map('t', '<leader>tt', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
            require'FTerm'.setup({
              blend=18,
              dimensions={
                height=0.4,
                width=0.4,
                x=0.95,
                y=0.1
              }
            })
        end
    }
    use {"kyazdani42/nvim-tree.lua",
         config=function()
          require'nvim-tree'.setup{}
         end
    }
    use 'famiu/bufdelete.nvim'
    use {'nvim-lualine/lualine.nvim',
         config = function ()
           local gps = require'nvim-gps'
           require'lualine'.setup({
             sections = {
               lualine_c = {
                 {'filename'},
                 { gps.get_location, cond = gps.is_available }
               }
             }})
             --  sections = {
             --    lualine_a = {'mode'},
             --    lualine_b = {'branch', 'diff', 'diagnostics'},
             --    lualine_c = {'filename'},
             --    lualine_x = {'encoding', 'fileformat', 'filetype'},
             --    lualine_y = { function() return require'lsp-status'.status() end },
             --    lualine_z = {'progress', 'location'}
             --  },
             --  extensions = {}
         end
    }
    use {'simnalamburt/vim-mundo'}
    use {'windwp/nvim-autopairs',
         config = function ()
           require'nvim-autopairs'.setup{}
         end
    }
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
        telescope.load_extension("git_worktree")
        telescope.load_extension("dap")
        telescope.load_extension("fzf_writer")
        telescope.load_extension("frecency")
        telescope.load_extension("zk")
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
          -- DAP stuff {
            vim.api.nvim_set_keymap('n', '<leader>dtc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>', opts)
            vim.api.nvim_set_keymap('n', '<leader>dto', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>', opts)
            vim.api.nvim_set_keymap('n', '<leader>dtb', '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>', opts)
            vim.api.nvim_set_keymap('n', '<leader>dtv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>', opts)
            vim.api.nvim_set_keymap('n', '<leader>dtf', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>', opts)
          -- }
          -- Commands {
            vim.api.nvim_set_keymap("n", "<Leader><tab>", "<Cmd>lua require('telescope.builtin').commands()<CR>", opts)
          -- }
          -- ZK {
           local map = vim.api.nvim_set_keymap

           map('n', '<leader>zkl', "<cmd>lua require('telescope').extensions.zk.links()<CR>", opts)
           map('n', '<leader>zkt', "<cmd>lua require('telescope').extensions.zk.tags()<CR>", opts)
           map('n', '<leader>zkb', "<cmd>lua require('telescope').extensions.zk.backlinks()<CR>", opts)
           map('n', '<leader>zkn', "<cmd>lua require('telescope').extensions.zk.notes()<CR>", opts)
           map('n', '<leader>zkc', "<cmd>lua require('telescope').extensions.zk.new()<CR>", opts)
           map('n', '<leader>zko', "<cmd>lua require('telescope').extensions.zk.orphans()<CR>", opts)
           map('x', '<leader>zkC', "<cmd>lua require('telescope').extensions.zk.new_link()<CR>", opts)
          -- }
        -- }
      require"telescope".load_extension("frecency")
      end
    }
    --}

    -- lsp {
    -- use {"nvim-lua/lsp-status.nvim"}
    use {"simrat39/symbols-outline.nvim"}
    use "folke/lsp-colors.nvim"
    use {"jose-elias-alvarez/null-ls.nvim",
         config=function()
            local nls = require('null-ls')
            local sources = {
              nls.builtins.formatting.autopep8,
              nls.builtins.diagnostics.flake8,
              nls.builtins.diagnostics.mypy,
              nls.builtins.diagnostics.hadolint,
              nls.builtins.diagnostics.shellcheck,
              nls.builtins.formatting.isort,
            }
            nls.setup({sources = sources,
                       debounce = 150,
                       debug = false})
         end}
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
        -- {"nvim-lua/lsp-status.nvim"},
        {"ray-x/lsp_signature.nvim"},
        {"kosayoda/nvim-lightbulb"},
      },
      config = function ()
        local nvim_lsp = require('lspconfig')

        -- local lsp_status = require("lsp-status")
        -- lsp_status.register_progress()
        -- local capabilities = lsp_status.capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local capabilities = vim.tbl_extend('force', vim.lsp.protocol.make_client_capabilities(), capabilities)
        local capabilities = require'cmp_nvim_lsp'.update_capabilities(capabilities)

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
          buf_set_keymap('n', '<space>e',  '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
          buf_set_keymap('n', '[e',        '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
          buf_set_keymap('n', ']e',        '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
          buf_set_keymap('n', '<space>q',  '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
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
          -- lsp_status.on_attach(client, bufnr)
        end

        -- Use a loop to conveniently call 'setup' on multiple servers and
        -- map buffer local keybindings when the language server attaches
        local servers = { "rust_analyzer", "pyright", "yamlls", "ccls", "jsonls", "tsserver"}
        for _, lsp in ipairs(servers) do
          if lsp == "jsonls" then
            capabilities.textDocument.completion.completionItem.snippetSupport = true
          else
            capabilities.textDocument.completion.completionItem.snippetSupport = false
          end
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
              codelenses = {
                generate = true, -- show the `go generate` lens.
                gc_details = true, --  // Show a code lens toggling the display of gc's choices.
                tidy = true -- adding mod tidy
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              matcher = "fuzzy",
              experimentalDiagnosticsDelay = "500ms",
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
        local dap_install = require("dap-install")
        local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()

        dap_install.config("python", {})
        local dap_install = require "dap-install"
        local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()

        local overrides = {
          python = {
            adapters = {
              type = "executable",
              command = "python3",
              args = { "-m", "debugpy.adapter" },
            },
            configurations = {
              {
                type = "python",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                pythonPath = function()
                  local venv_path = os.getenv "VIRTUAL_ENV"
                  if venv_path then
                    local util_sys = require "dap-install.utils.sys"
                    if util_sys.is_windows() then
                      return venv_path .. "\\Scripts\\python.exe"
                    end
                    return venv_path .. "/bin/python"
                  end

                  local cwd = vim.fn.getcwd()
                  if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                    return cwd .. "/venv/bin/python"
                  elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                    return cwd .. "/.venv/bin/python"
                  else
                    return "/usr/bin/python3"
                  end
                end,
              },
            },
          },
        }

        for _, debugger in ipairs(dbg_list) do
          dap_install.config(debugger, overrides[debugger])
        end
        -- for _, debugger in ipairs(dbg_list) do
        --   dap_install.config(debugger)
        -- end
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
        {
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
        },
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
            -- open_on_start = true,
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
            -- open_on_start = true,
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
    -- use { "rcarriga/vim-ultest", 
    --       requires = {"vim-test/vim-test"},
    --       run = ":UpdateRemotePlugins" }
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
              init_selection = "<CR>",
              node_incremental = "<CR>",
              scope_incremental = "<Tab>",
              node_decremental = "<S-Tab>",
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
    use {"SmiteshP/nvim-gps",
      requires = "nvim-treesitter/nvim-treesitter",
      config = function ()
        require'nvim-gps'.setup{}
      end
    }
    -- }

    -- completion {
    use {"honza/vim-snippets"}
    use {"SirVer/ultisnips", config = function()
      vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
      vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
      vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
      vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
      vim.g.UltiSnipsRemoveSelectModeMappings = 0
    end}
    use {'hrsh7th/cmp-nvim-lsp'}
    use {'hrsh7th/cmp-buffer'}
    use {'hrsh7th/cmp-path'}
    use {'hrsh7th/cmp-cmdline'}
    use {'quangnguyen30192/cmp-nvim-ultisnips'}
    use {'hrsh7th/nvim-cmp', config = function()
      local t = function(str)
          return vim.api.nvim_replace_termcodes(str, true, true, true)
      end
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
        mapping = {
          ["<Tab>"] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    cmp.complete()
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                    vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
                else
                    fallback()
                end
            end,
            s = function(fallback)
                if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                    vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
                else
                    fallback()
                end
            end
        }),
          ["<S-Tab>"] = cmp.mapping({
              c = function()
                  if cmp.visible() then
                      cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                  else
                      cmp.complete()
                  end
              end,
              i = function(fallback)
                  if cmp.visible() then
                      cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                  elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                      return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
                  else
                      fallback()
                  end
              end,
              s = function(fallback)
                  if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                      return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
                  else
                      fallback()
                  end
              end
          }),
          ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
          ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
          ['<C-n>'] = cmp.mapping({
              c = function()
                  if cmp.visible() then
                      cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                  else
                      vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
                  end
              end,
              i = function(fallback)
                  if cmp.visible() then
                      cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                  else
                      fallback()
                  end
              end
          }),
          ['<C-p>'] = cmp.mapping({
              c = function()
                  if cmp.visible() then
                      cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                  else
                      vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
                  end
              end,
              i = function(fallback)
                  if cmp.visible() then
                      cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                  else
                      fallback()
                  end
              end
          }),
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
          ['<C-e>'] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
          ['<CR>'] = cmp.mapping({
              i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
              c = function(fallback)
                  if cmp.visible() then
                      cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                  else
                      fallback()
                  end
              end
          }),
        },
        sources = cmp.config.sources({
          { name = 'path' },
          { name = 'nvim_lsp' },
          { name = 'ultisnips' }, -- For ultisnips users.
        })
      })
      -- Use buffer source for `/`.
      cmp.setup.cmdline('/', {
          completion = { autocomplete = true },
          sources = {
              -- { name = 'buffer' }
              { name = 'buffer', opts = { keyword_pattern = [=[[^[:blank:]].*]=] } }
          }
      })

      -- Use cmdline & path source for ':'.
      cmp.setup.cmdline(':', {
          completion = { autocomplete = true },
          sources = cmp.config.sources({
              { name = 'cmdline' }
          })
      })
    end}
    -- }

    -- wiki {
    use 'vimwiki/vimwiki'
    use 'tbabej/taskwiki'
    use {"mickael-menu/zk-nvim",
         requires = { "neovim/nvim-lspconfig",
                      "nvim-telescope/telescope.nvim"},
         config = function ()
           require'zk'.setup()
         end
    }
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
          ft = {"clojure", "fennel"}
        }
      -- }

      -- Golang {
        use {"fatih/vim-go",
             ft = "go"}
      -- }
      -- Python {
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
