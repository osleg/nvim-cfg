local packer = require("packer")
local use = packer.use

return require("packer").startup(
  {
    function()
      -- packer itself
      use "wbthomason/packer.nvim"

      -- Vim stuff {
      use 'eandrju/cellular-automaton.nvim'
      use { 'mrjones2014/smart-splits.nvim',
        config = function()
          local map = vim.api.nvim_set_keymap
          local opts = { noremap = true, silent = true }

          -- resizing splits
          vim.api.nvim_set_keymap('n', '<A-h>', ':lua require("smart-splits").resize_left()<CR>', opts)
          vim.api.nvim_set_keymap('n', '<A-j>', ':lua require("smart-splits").resize_down()<CR>', opts)
          vim.api.nvim_set_keymap('n', '<A-k>', ':lua require("smart-splits").resize_up()<CR>', opts)
          vim.api.nvim_set_keymap('n', '<A-l>', ':lua require("smart-splits").resize_right()<CR>', opts)
          -- mapi.nvim_etw_oving een splits
          vim.api.nvim_set_keymap('n', '<C-h>', ':lua require("smart-splits").move_cursor_left()<CR>', opts)
          vim.api.nvim_set_keymap('n', '<C-j>', ':lua require("smart-splits").move_cursor_down()<CR>', opts)
          vim.api.nvim_set_keymap('n', '<C-k>', ':lua require("smart-splits").move_cursor_up()<CR>', opts)
          vim.api.nvim_set_keymap('n', '<C-l>', ':lua require("smart-splits").move_cursor_right()<CR>', opts)
        end }
      use "nvim-lua/plenary.nvim"
      use "junegunn/vim-easy-align"
      use { "tpope/vim-rsi" }
      use { "tpope/vim-surround" }
      use "godlygeek/tabular"
      use "folke/lsp-colors.nvim"
      use { "folke/which-key.nvim",
        config = function()
          require('which-key').setup {}
        end
      }
      use { 'folke/twilight.nvim',
        config = function()
          require("twilight").setup {}
        end }
      use { 'folke/zen-mode.nvim',
        config = function()
          require 'zen-mode'.setup {}
        end }
      use 'folke/tokyonight.nvim'
      use { "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
          require("todo-comments").setup {
            highlight = {
              pattern = [[.*<(KEYWORDS)\s*\(*\w*\)*:]],
            },
            search = {
              pattern = [[\b(KEYWORDS)\s*\(*\w*\)*:]],
            }
          }
        end
      }
      use { "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
          require("trouble").setup {
            auto_fold = true,
            auto_preview = false,
          }
        end
      }
      use { "terrortylor/nvim-comment",
        config = function()
          require('nvim_comment').setup {}
        end
      }
      use "p00f/nvim-ts-rainbow"
      -- TODO: configure and set bindings through mapper
      use { "numtostr/FTerm.nvim",
        config = function()
          local map = vim.api.nvim_set_keymap
          local opts = { noremap = true, silent = true }

          map('n', '<leader>tt', '<CMD>lua require("FTerm").toggle()<CR>', opts)
          map('t', '<leader>tt', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
          require 'FTerm'.setup({
            blend = 18,
            dimensions = {
              height = 0.4,
              width = 0.95,
              x = 0.3,
              y = 0.1
            }
          })
        end
      }
      use { "kyazdani42/nvim-tree.lua",
        config = function()
          require 'nvim-tree'.setup {}
        end
      }
      use 'famiu/bufdelete.nvim'
      use { 'nvim-lualine/lualine.nvim',
        config = function()
          local navic = require 'nvim-navic'
          require 'lualine'.setup({
            sections = {
              lualine_c = {
                { 'filename' },
                { navic.get_location, cond = navic.is_available }
              },
            },
            winbar = {
            },
            inactive_winbar = {}
          })
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
      use { "b0o/incline.nvim",
        config = function()
          require 'incline'.setup {}
        end
      }
      use { 'simnalamburt/vim-mundo' }
      use { 'windwp/nvim-autopairs',
        config = function()
          require 'nvim-autopairs'.setup {}
        end
      }
      use { "kevinhwang91/nvim-ufo",
        requires = { 'kevinhwang91/promise-async' },
        config = function()
          local handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = ('  %d '):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
              local chunkText = chunk[1]
              local chunkWidth = vim.fn.strdisplaywidth(chunkText)
              if targetWidth > curWidth + chunkWidth then
                table.insert(newVirtText, chunk)
              else
                chunkText = truncate(chunkText, targetWidth - curWidth)
                local hlGroup = chunk[2]
                table.insert(newVirtText, { chunkText, hlGroup })
                chunkWidth = vim.fn.strdisplaywidth(chunkText)
                -- str width returned from truncate() may less than 2nd argument, need padding
                if curWidth + chunkWidth < targetWidth then
                  suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                end
                break
              end
              curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, { suffix, 'MoreMsg' })
            return newVirtText
          end

          vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
          vim.o.foldcolumn = '0' -- '0' is not bad
          vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
          vim.o.foldlevelstart = 99
          vim.o.foldenable = true

          vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
          vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
          vim.keymap.set('n', 'zp', require('ufo').peekFoldedLinesUnderCursor)
          vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
          vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith)
          -- f+ / f-
          -- vim.keymap.set('n', '<leader>ff0', require('ufo').closeFoldsWith(0))

          local ftMap = {
            python = { 'treesitter' },
            git = '',
            go = 'lsp'
          }
          require('ufo').setup({
            open_fold_hl_timeout = 150,
            close_fold_kinds = { 'imports', 'comment' },
            fold_virt_text_handler = handler,
            provider_selector = function(bufnr, filetype, buftype)
              return ftMap[filetype] or { 'treesitter', 'indent' }
            end
          })
        end
      }
      -- }

      -- Telescope {
      -- use {"nvim-telescope/telescope-fzf-writer.nvim"}
      use { "nvim-telescope/telescope-frecency.nvim",
        requires = { "tami5/sqlite.lua" } }

      use { "nvim-telescope/telescope-dap.nvim" }
      use { "nvim-telescope/telescope.nvim",
        requires = {
          { 'nvim-lua/popup.nvim' },
          { 'nvim-lua/plenary.nvim' },
          { 'nvim-telescope/telescope-fzf-writer.nvim' },
          { "nvim-telescope/telescope-frecency.nvim" },
          { 'ThePrimeagen/git-worktree.nvim' },
          { "nvim-telescope/telescope-dap.nvim" }
        },
        config = function()
          local trouble = require('trouble.providers.telescope')
          local telescope = require('telescope')
          telescope.load_extension("git_worktree")
          telescope.load_extension("dap")
          -- telescope.load_extension("fzf_writer")
          telescope.load_extension("frecency")
          telescope.setup {
            defaults = {
              dynamic_preview_title = true,
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
          local opts = { noremap = true, silent = true }
          -- mappings {
          -- Buffer/file stuff {
          vim.api.nvim_set_keymap("n", "<Leader>bF", "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>",
            opts)
          vim.api.nvim_set_keymap("n", "<Leader>bf", "<Cmd>lua require('telescope.builtin').git_files()<CR>", opts)
          vim.api.nvim_set_keymap("n", "<Leader>bb", "<Cmd>lua require('telescope.builtin').buffers()<CR>", opts)
          vim.api.nvim_set_keymap("n", "<Leader>bo", "<Cmd>lua require('telescope.builtin').oldfiles()<CR>", opts)
          vim.api.nvim_set_keymap("n", "<Leader>bg", "<Cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
          -- }
          -- Git stuff {
          vim.api.nvim_set_keymap("n", "<Leader>gb", "<Cmd>lua require('telescope.builtin').git_branches()<CR>", opts)
          -- vim.api.nvim_set_keymap("n", "<Leader>gs", "<Cmd>lua require('telescope.builtin').git_status()<CR>", opts)
          -- vim.api.nvim_set_keymap("n", "<Leader>gS", "<Cmd>lua require('telescope.builtin').git_stash()<CR>", opts)
          -- }
          -- DAP stuff {
          vim.api.nvim_set_keymap('n', '<leader>dtc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>', opts)
          vim.api.nvim_set_keymap('n', '<leader>dto', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>',
            opts)
          vim.api.nvim_set_keymap('n', '<leader>dtb', '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>'
            ,
            opts)
          vim.api.nvim_set_keymap('n', '<leader>dtv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>', opts)
          vim.api.nvim_set_keymap('n', '<leader>dtf', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>', opts)
          -- }
          -- Commands {
          vim.api.nvim_set_keymap("n", "<Leader><tab>", "<Cmd>lua require('telescope.builtin').commands()<CR>", opts)
          -- }
          -- }
        end
      }
      --}

      -- lsp {
      use { "j-hui/fidget.nvim",
        config = function()
          require 'fidget'.setup {}
        end }
      use { "simrat39/symbols-outline.nvim",
        config = function()
          require 'symbols-outline'.setup {
            relative_width = false,
            width = 25,
            auto_close = true,
            autofold_depth = 1,
          }
          vim.api.nvim_set_keymap("n", "<Leader>bt", ":SymbolsOutline<CR>", {})
        end }
      use { "jose-elias-alvarez/null-ls.nvim",
        config = function()
          local nls = require('null-ls')
          local sources = {
            nls.builtins.formatting.autopep8,
            nls.builtins.diagnostics.flake8,
            nls.builtins.diagnostics.mypy,
            nls.builtins.diagnostics.hadolint,
            nls.builtins.diagnostics.shellcheck,
            nls.builtins.formatting.isort,
            nls.builtins.diagnostics.vale.with({ filetypes = { "vimwiki", "markdown", "tex", "asciidoc" } })
          }
          nls.setup({
            sources = sources,
            debounce = 150,
            debug = false
          })
        end }
      use { "ray-x/lsp_signature.nvim", }
      use { "rmagatti/goto-preview",
        config = function()
          require('goto-preview').setup {
            default_mappings = true,
            debug = false
          }
        end
      }
      use { "kosayoda/nvim-lightbulb",
        config = function()
          vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
        end }
      use { "neovim/nvim-lspconfig",
        requires = {
          { "ray-x/lsp_signature.nvim" },
          { "kosayoda/nvim-lightbulb" },
        },
        config = function()
          local nvim_lsp = require('lspconfig')

          -- local lsp_status = require("lsp-status")
          -- lsp_status.register_progress()
          -- local capabilities = lsp_status.capabilities
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          local capabilities = require 'cmp_nvim_lsp'.default_capabilities(capabilities)

          -- disable virtual text
          vim.diagnostic.config({
            virtual_text = true,
          })

          -- Use an on_attach function to only map the following keys
          -- after the language server attaches to the current buffer
          local on_attach = function(client, bufnr)

            -- define signs {{{
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
              local hl = "DiagnosticSign" .. type
              vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
            -- }}}

            -- Show diagnostic under cursor {{{
            -- vim.api.nvim_create_autocmd("CursorHold", {
            --   buffer = bufnr,
            --   callback = function()
            --     local opts = {
            --       focusable = false,
            --       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            --       border = 'rounded',
            --       source = 'always',
            --       prefix = ' ',
            --       scope = 'cursor',
            --     }
            --     vim.diagnostic.open_float(nil, opts)
            --   end
            -- })
            -- }}}
            local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

            local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

            vim.api.nvim_command("autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()")
            --Enable completion triggered by <c-x><c-o>
            -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Mappings {
            local opts = { noremap = true, silent = true }


            -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
            -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
            -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
            -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',      opts)

            -- See `:help vim.lsp.*` for documentation on any of the below functions
            buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
            buf_set_keymap('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
            buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
            buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
            buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
            buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
            buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
            buf_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
            buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
            buf_set_keymap("n", "<space>,.", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
            -- buf_set_keymap("n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
            -- buf_set_keymap("v", "<leader>ca", "<Cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
            -- Telescope {
            buf_set_keymap("n", "<leader>gr",
              "<Cmd>lua require('telescope.builtin').lsp_references(require'telescope.themes'.get_ivy { })<CR>", opts)
            buf_set_keymap("n", "<leader>gd",
              "<Cmd>lua require('telescope.builtin').lsp_definitions(require'telescope.themes'.get_ivy { })<CR>", opts)
            buf_set_keymap('n', '<leader>gi',
              "<Cmd>lua require('telescope.builtin').lsp_implementations(require'telescope.themes'.get_ivy { })<CR>",
              opts)

            -- }
            -- }

            require 'lsp_signature'.on_attach(client, bufnr)
            require 'nvim-navic'.attach(client, bufnr)
            -- lsp_spinner.on_attach(client, bufnr)
            -- lsp_status.on_attach(client, bufnr)
          end

          -- Use a loop to conveniently call 'setup' on multiple servers and
          -- map buffer local keybindings when the language server attaches
          local servers = { "rust_analyzer", "pyright", "yamlls", "ccls", "jsonls", "tsserver", 'terraformls', "luau_lsp" }
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
            filetypes = { "go", "gomod" },
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
                diagnosticsDelay = "500ms",
                -- diagnosticsDelay = "500ms",
                -- experimentalWatchedFileDelay = "100ms",
                symbolMatcher = "fuzzy",
                gofumpt = false, -- true, -- turn on for new repos, gofmpt is good but also create code turmoils
                buildFlags = { "-tags", "integration" }
                -- buildFlags = {"-tags", "functional"}
              }
            }
          }
          nvim_lsp.sumneko_lua.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
              debounce_text_changes = 150,
            },
            settings = {
              Lua = {
                runtime = {
                  -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                  version = 'LuaJIT',
                },
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = { 'vim' },
                },
                workspace = {
                  -- Make the server aware of Neovim runtime files
                  library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                  enable = false,
                },
              },
            },
          }
          --   nvim_lsp.ltex.setup {
          --     on_attach = on_attach,
          --     capabilities = capabilities,
          --     debounce_text_changes = 150,
          --     settings = {
          --       ltex = {
          --            additionalRules = {
          --              languageModel = '~/ngrams/',
          --            },
          --       },
          --     },
          --   }
        end
      }
      use { "RishabhRD/popfix" }
      use({ 'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
      })
      use { "onsails/lspkind-nvim" }
      use { "RishabhRD/nvim-lsputils",
        requires = { { "RishabhRD/popfix" } },
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
        end }
      -- }

      -- debug {
      use { "theHamsta/nvim-dap-virtual-text" }
      use { "Pocco81/DAPInstall.nvim",
        branch = "dev",
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
        end }
      use { "mfussenegger/nvim-dap",
        config = function()
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
      use { "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
          require("dapui").setup({
            icons = {
              expanded = "-",
              collapsed = "+"
            },
            mappings = {
              -- Use a table to apply multiple mappings
              expand = { "<CR>", "<2-LeftMouse>" },
              open = "o",
              remove = "d",
              edit = "e",
              repl = "r",
            },
            layouts = {
              {
                elements = {
                  -- You can change the order of elements in the sidebar
                  "scopes",
                  "breakpoints",
                  "stacks",
                  "watches"
                },
                size = 40,
                position = "left" -- Can be "left" or "right"
              },
              {
                elements = {
                  "repl",
                  "console"
                },
                position = "bottom", -- Can be "bottom" or "top"
                size = 10,
              }
            },
            floating = {
              max_height = nil, -- These can be integers or a float between 0 and 1.
              max_width = nil -- Floats will be treated as percentage of your screen.
            }
          })
        end
      }
      -- use { "rcarriga/vim-ultest",
      --       requires = {"vim-test/vim-test"},
      --       run = ":UpdateRemotePlugins" }
      -- }

      -- treesitter {
      use { "nvim-treesitter/nvim-treesitter",
        config = function()
          require 'nvim-treesitter.configs'.setup {
            ensure_installed = "all",
            -- Modules and its options go here
            highlight = {
              enable = true
            },
            incremental_selection = {
              enable = true,
              keymaps = {
                init_selection = "<C-CR>",
                node_incremental = "<CR>",
                scope_incremental = "<Tab>",
                node_decremental = "<S-CR>",
              }
            },
            indent = {
              enable = true,
              disable = { "python" }
            },
            rainbow = {
              enable = true,
              extended_mode = false,
              max_file_lines = 4000
            }
          }
        end
      }
      use { "SmiteshP/nvim-navic",
        requires = "nvim-treesitter/nvim-treesitter",
        config = function()
          require 'nvim-navic'.setup {}
        end
      }
      -- Just {{{
      use {
        "IndianBoy42/tree-sitter-just",
        config = function()
          require("nvim-treesitter.parsers").get_parser_configs().just = {
            install_info = {
              url = "https://github.com/IndianBoy42/tree-sitter-just", -- local path or git repo
              files = { "src/parser.c", "src/scanner.cc" },
              branch = "main",
              use_makefile = true -- this may be necessary on MacOS (try if you see compiler errors)
            },
            maintainers = { "@IndianBoy42" },
          }
        end
      }
      -- }}}
      -- }

      -- completion {
      use({ "jackMort/ChatGPT.nvim",
        config = function()
          require("chatgpt").setup({
            -- optional configuration
          })
        end,
        requires = {
          "MunifTanjim/nui.nvim",
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope.nvim"
        }
      })
      use { "MunifTanjim/nui.nvim" }
      use { "honza/vim-snippets" }
      use { "SirVer/ultisnips", config = function()
        vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
        vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
        vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
        vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
        vim.g.UltiSnipsRemoveSelectModeMappings = 0
      end }
      use { 'hrsh7th/cmp-nvim-lsp' }
      use { 'hrsh7th/cmp-buffer' }
      use { 'hrsh7th/cmp-path' }
      use { 'hrsh7th/cmp-cmdline' }
      use { 'quangnguyen30192/cmp-nvim-ultisnips' }
      use { 'hrsh7th/nvim-cmp', config = function()
        local t = function(str)
          return vim.api.nvim_replace_termcodes(str, true, true, true)
        end
        local cmp = require('cmp')
        local lspkind = require('lspkind')
        cmp.setup {
          formatting = {
            format = function(entry, vim_item)
              if vim.tbl_contains({ 'path' }, entry.source.name) then
                local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
                if icon then
                  vim_item.kind = icon
                  vim_item.kind_hl_group = hl_group
                  return vim_item
                end
              end
              return lspkind.cmp_format({ with_text = false })(entry, vim_item)
            end
          },
          completion = {
            keyword_length = 1
          },
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'ultisnips' }, -- For ultisnips users.
            { name = 'buffer' },
            { name = 'path' },
          }),
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
                  return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), 'm', true)
                else
                  fallback()
                end
              end,
              s = function(fallback)
                if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                  return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), 'm', true)
                else
                  fallback()
                end
              end
            }),
            ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
            ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
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
            ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
            ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
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
        }
        -- Use buffer source for `/`.
        cmp.setup.cmdline('/', {
          completion = { autocomplete = false },
          sources = {
            -- { name = 'buffer' }
            { name = 'buffer', opts = { keyword_pattern = [=[[^[:blank:]].*]=] } }
          }
        })

        -- Use cmdline & path source for ':'.
        cmp.setup.cmdline(':', {
          completion = { autocomplete = false },
          sources = cmp.config.sources({
            { name = 'path' }
          }, {
            { name = 'cmdline' }
          })
        })
      end
      }

      -- wiki {
      use 'vimwiki/vimwiki'
      use 'tbabej/taskwiki'
      use { "mickael-menu/zk-nvim",
        requires = { "neovim/nvim-lspconfig",
          "nvim-telescope/telescope.nvim" },
        config = function()
          require 'zk'.setup()
        end
      }
      -- }

      -- git {
      use {
        "sindrets/diffview.nvim",
        requires = 'nvim-lua/plenary.nvim'
      }
      use { 'TimUntersberger/neogit',
        requires = {
          'nvim-lua/plenary.nvim',
          'sindrets/diffview.nvim'
        },
        config = function()
          require 'neogit'.setup { integrations = { diffview = true } }
          local opts = { noremap = true, silent = true }
          vim.api.nvim_set_keymap("n", "<Leader>gn", "<Cmd>Neogit<CR>", opts)
        end
      }
      -- use { 'pwntester/octo.nvim', config = function()
      --   require "octo".setup()
      -- end }
      -- use {'tpope/vim-fugitive'}
      use { 'junegunn/gv.vim' }
      use { 'ThePrimeagen/git-worktree.nvim',
        config = function()
          require("git-worktree").setup {}
        end }
      use { "lewis6991/gitsigns.nvim",
        config = function()
          on_attach = function(bufnr)
            local opts = { noremap = true, silent = true }
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gs', '<cmd>lua require"gitsigns".stage_hunk()<CR>', opts)
          end
          require('gitsigns').setup {
            on_attach = on_attach
          }
        end
      }
      -- }

      -- Languages {
      -- Rust {
      use { "simrat39/rust-tools.nvim",
        config = function() require 'rust-tools'.setup {} end
      }
      -- }

      -- Clojure {
      use { "Olical/conjure",
        tag = "v4.22.1",
        ft = "clojure",
        config = function()
          vim.api.nvim_set_var("conjure#mapping#doc_word", false)
        end
      }
      use { "eraserhd/parinfer-rust",
        run = "cargo build --release",
        ft = { "clojure", "fennel" }
      }
      -- }

      -- Golang {
      -- use {"fatih/vim-go",
      --      ft = "go"}
      use { 'ray-x/go.nvim',
        requires = { 'ray-x/guihua.lua' },
        config = function()
          require 'go'.setup {}
        end
      }
      use { 'leoluz/nvim-dap-go',
        config = function()
          require 'dap-go'.setup {
            dap_configurations = {
              {
                type = "go",
                name = "Attach remote",
                mode = "remote",
                request = "attach",
              },
              {
                name = "Connect to external session",
                type = "go",
                debugAdapter = "dlv-dap", -- `legacy` by default
                request = "attach",
                mode = "remote",
                port = 38697,
                host = "", -- can skip for localhost
              },
            }
          }
        end
      }
      -- }
      -- Python {
      use { 'tmhedberg/SimpylFold' }
      -- }
      -- Markdown {
      use({ "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" }, })
      -- }
      -- }

      -- Database {
      use { "tpope/vim-dadbod" }
      -- }
    end,
    config = {
      display = {
        border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
      },
      max_jobs = 8,
      preview_updates = true
    }
  }
)



-- vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker nospell:
