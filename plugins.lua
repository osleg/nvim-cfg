local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
  {
      -- Vim stuff {
      -- use { "folke/noice.nvim",
      --   config = function()
      --     require("noice").setup({
      --       lsp = {
      --         -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      --         override = {
      --           ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      --           ["vim.lsp.util.stylize_markdown"] = true,
      --           ["cmp.entry.get_documentation"] = true,
      --         },
      --       },
      --       -- you can enable a preset for easier configuration
      --       presets = {
      --         bottom_search = true,         -- use a classic bottom cmdline for search
      --         command_palette = true,       -- position the cmdline and popupmenu together
      --         long_message_to_split = true, -- long messages will be sent to a split
      --         inc_rename = false,           -- enables an input dialog for inc-rename.nvim
      --         lsp_doc_border = false,       -- add a border to hover docs and signature help
      --       },
      --     })
      --   end,
      --   dependencies = {
      --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      --     "MunifTanjim/nui.nvim",
      --     -- OPTIONAL:
      --     --   `nvim-notify` is only needed, if you want to use the notification view.
      --     --   If not available, we use `mini` as the fallback
      --     "rcarriga/nvim-notify",
      --   }
      -- }
     { "shortcuts/no-neck-pain.nvim" },
     'eandrju/cellular-automaton.nvim',
     "nvim-lua/plenary.nvim",
     "junegunn/vim-easy-align",
     { "tpope/vim-rsi" },
     { "tpope/vim-surround" },
     "godlygeek/tabular",
     { "folke/lsp-colors.nvim", opts={} },
     { "folke/which-key.nvim", opts={} },
     { 'folke/twilight.nvim', opts={} },
     { 'folke/zen-mode.nvim', opts={} },
     'folke/tokyonight.nvim',
     { "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        opts = {
            highlight = {
              pattern = [[.*<(KEYWORDS)\s*\(*\w*\)*:]],
            },
            search = {
              pattern = [[\b(KEYWORDS)\s*\(*\w*\)*:]],
            }
          }
      },
     { "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = {
            auto_fold = true,
            auto_preview = false,
          }
      },
     { "terrortylor/nvim-comment",
       config = function()
         require('nvim_comment').setup()
       end
     },
     "HiPhish/nvim-ts-rainbow2",
      -- TODO: configure and set bindings through mapper
     { "numtostr/FTerm.nvim",
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
      },
      { "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
          "nvim-tree/nvim-web-devicons",
        },
        config = function()
          require("nvim-tree").setup {}
        end,
      },
     'famiu/bufdelete.nvim',
     { 'nvim-lualine/lualine.nvim',
        config = function()
          local navic = require 'nvim-navic'
          require 'lualine'.setup({
            sections = {
              lualine_c = {
                { "navic" }
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
      },
     { "b0o/incline.nvim",
      config = function()
        require("incline").setup()
      end,
      event = "VeryLazy"
     },
     { 'simnalamburt/vim-mundo' },
     { 'windwp/nvim-autopairs' },
     { "kevinhwang91/nvim-ufo",
        dependencies = { 'kevinhwang91/promise-async' },
        config = function()
          local handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (' 󰁂 %d '):format(endLnum - lnum)
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
          vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
          vim.o.foldlevelstart = 5
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
            enable_get_fold_virt_text = true,
            close_fold_kinds_for_fot = { go = {'imports', 'comment'} },
            fold_virt_text_handler = handler,
            provider_selector = function(bufnr, filetype, buftype)
              return ftMap[filetype] or { 'treesitter', 'indent' }
            end
          })
        end
      },
     "rcarriga/nvim-notify",
      -- }

      -- Telescope {
      -- use {"nvim-telescope/telescope-fzf-writer.nvim"}
     -- { "nvim-telescope/telescope-frecency.nvim",
     --    dependencies = { "tami5/sqlite.lua" } },

     { "nvim-telescope/telescope-dap.nvim" },
     { "nvim-telescope/telescope.nvim",
        dependencies = {
          { 'nvim-lua/popup.nvim' },
          { 'nvim-lua/plenary.nvim' },
          { 'nvim-telescope/telescope-fzf-writer.nvim' },
          { 'ThePrimeagen/git-worktree.nvim' },
          { "nvim-telescope/telescope-dap.nvim" }
        },
        config = function()
          local trouble = require('trouble.providers.telescope')
          local telescope = require('telescope')
          local actions = require('telescope.actions')
          telescope.load_extension("git_worktree")
          telescope.load_extension("dap")
          -- telescope.load_extension("fzf_writer")
          telescope.load_extension("refactoring")
          telescope.setup {
            defaults = {
              dynamic_preview_title = true,
              mappings = {
                i = { ["<c-t>"] = trouble.open_with_trouble },
                n = {
                  ["<c-t>"] = trouble.open_with_trouble,
                  ["<c-d>"] = actions.delete_buffer,
                },
              },
            },
            extensions = {
              fzf_writer = {
                minimum_grep_characters = 2,
                minimum_files_characters = 2,
                -- Disabled by default.
                -- Will probably slow down some aspects of the sorter, but can make color highlights.
                -- I will work on this more later.
              _highlighter = true,
              }
            }
          }
          local opts = { noremap = true, silent = true }
          -- mappings {
          vim.api.nvim_set_keymap("n", "<Leader>gg", "<Cmd>lua require('telescope.builtin').resume()<CR>", opts)
          -- Buffer/file stuff {
          vim.api.nvim_set_keymap("n", "<Leader>bf", "<Cmd>lua require('telescope.builtin').git_files()<CR>",
            opts)
          vim.api.nvim_set_keymap("n", "<Leader>bb", "<Cmd>lua require('telescope.builtin').buffers()<CR>",
            opts)
          vim.api.nvim_set_keymap("n", "<Leader>bo", "<Cmd>lua require('telescope.builtin').oldfiles()<CR>",
            opts)
          vim.api.nvim_set_keymap("n", "<Leader>bg", "<Cmd>lua require('telescope.builtin').live_grep()<CR>",
            opts)
          -- }
          -- Git stuff {
          vim.api.nvim_set_keymap("n", "<Leader>gb", "<Cmd>lua require('telescope.builtin').git_branches()<CR>",
            opts)
          vim.api.nvim_set_keymap("n", "<Leader>gws", "<Cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", opts)
          vim.api.nvim_set_keymap("n", "<Leader>gwc", "<Cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", opts)
          -- vim.api.nvim_set_keymap("n", "<Leader>gs", "<Cmd>lua require('telescope.builtin').git_status()<CR>", opts)
          -- vim.api.nvim_set_keymap("n", "<Leader>gS", "<Cmd>lua require('telescope.builtin').git_stash()<CR>", opts)
          -- }
          -- DAP stuff {
          vim.api.nvim_set_keymap('n', '<leader>dtc',
            '<cmd>lua require"telescope".extensions.dap.commands{}<CR>', opts)
          vim.api.nvim_set_keymap('n', '<leader>dto',
            '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>',
            opts)
          vim.api.nvim_set_keymap('n', '<leader>dtb',
            '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>'
            ,
            opts)
          vim.api.nvim_set_keymap('n', '<leader>dtv',
            '<cmd>lua require"telescope".extensions.dap.variables{}<CR>', opts)
          vim.api.nvim_set_keymap('n', '<leader>dtf', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>',
            opts)
          -- }
          -- Commands {
          vim.api.nvim_set_keymap("n", "<Leader><tab>", "<Cmd>lua require('telescope.builtin').commands()<CR>",
            opts)
          -- }
          -- Refactoring {
          -- remap to open the Telescope refactoring menu in visual mode
          vim.api.nvim_set_keymap(
            "v",
            "<leader>rr",
            "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
            { noremap = true }
          )
          -- }
          -- }
        end
      },
      --}

      -- lsp {
     { "j-hui/fidget.nvim", lazy=false, cmd="Fidget",
        config = function()
          require("fidget").setup {}
        end
     },
     { "simrat39/symbols-outline.nvim",
        config = function()
          require 'symbols-outline'.setup {
            relative_width = false,
            width = 25,
            auto_close = true,
            autofold_depth = 1,
          }
          vim.api.nvim_set_keymap("n", "<Leader>bt", ":SymbolsOutline<CR>", {})
        end },
     { "nvimtools/none-ls.nvim",
      dependencies = {
        "gbprod/none-ls-shellcheck.nvim",
      },
      config = function()
        local nls = require('null-ls')
        nls.register(require('none-ls-shellcheck.diagnostics'))
        nls.register(require('none-ls-shellcheck.code_actions'))
        local sources = {
          nls.builtins.diagnostics.semgrep,
          nls.builtins.diagnostics.mypy.with({ prefer_local = true }),
          nls.builtins.code_actions.refactoring,
          nls.builtins.diagnostics.hadolint,
          nls.builtins.formatting.isort,
          nls.builtins.diagnostics.vale.with({ filetypes = { "vimwiki", "markdown", "tex", "asciidoc" } })
        }
        nls.setup({
          sources = sources,
          debounce = 150,
          debug = false
        })
      end },
     { "ray-x/lsp_signature.nvim", },
     { "rmagatti/goto-preview",
        config = function()
          require('goto-preview').setup {
            default_mappings = true,
            debug = false
          }
        end
      },
     { "kosayoda/nvim-lightbulb",
        config = function()
          vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
        end },
      -- use { "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      --   config = function()
      --     require("lsp_lines").setup()
      --   end,
      -- }
     { "neovim/nvim-lspconfig",
        dependencies = {
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
          capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
          }

          -- codelens refresh func {{{
          local function setup_codelens_refresh(client, bufnr)
            local status_ok, codelens_supported = pcall(function()
                return client.supports_method("textDocument/codeLens")
            end)
            if not status_ok or not codelens_supported then
                return
            end
            local group = "lsp_code_lens_refresh"
            local cl_events = { "BufEnter", "InsertLeave" }
            local ok, cl_autocmds = pcall(vim.api.nvim_get_autocmds, {
                group = group,
                buffer = bufnr,
                event = cl_events,
            })
            if ok and #cl_autocmds > 0 then
                return
            end
            vim.api.nvim_create_augroup(group, { clear = false })
            vim.api.nvim_create_autocmd(cl_events, {
                group = group,
                buffer = bufnr,
                callback = vim.lsp.codelens.refresh,
            })
          end

          -- }}}
          -- Use an on_attach function to only map the following keys
          -- after the language server attaches to the current buffer
          local on_attach = function(client, bufnr)
            -- define signs {{{
            local signs = { Error = "⚠ ", Warn = " ", Hint = "¿ ", Info = " " }
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

            setup_codelens_refresh(client, bufnr)
            -- vim.api.nvim_command(
            --   "autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()")
            --Enable completion triggered by <c-x><c-o>
            -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Mappings {
            local opts = { noremap = true, silent = true }


            -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
            -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
            -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
            -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',      opts)
  
            -- disable/enable error lines
            -- buf_set_keymap('n', '<space>e', '<cmd>lua require"lsp_lines".toggle()<CR>', opts)

            -- See `:help vim.lsp.*` for documentation on any of the below functions
            buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
            buf_set_keymap('n', '<C-]>', "<Cmd>lua vim.lsp.buf.definition(require'telescope.themes'.get_ivy { })<CR>",
              opts)
            buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
            buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
            buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
            buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
            buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
            buf_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
            -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
            buf_set_keymap("n", "<space>,.", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
            -- buf_set_keymap("n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
            -- buf_set_keymap("v", "<leader>ca", "<Cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
            -- Telescope {
            buf_set_keymap("n", "<leader>gr",
              "<Cmd>lua require('telescope.builtin').lsp_references(require'telescope.themes'.get_ivy { })<CR>",
              opts)
            buf_set_keymap("n", "<leader>gd",
              "<Cmd>lua require('telescope.builtin').lsp_definitions(require'telescope.themes'.get_ivy { })<CR>",
              opts)
            buf_set_keymap('n', '<leader>gi',
              "<Cmd>lua require('telescope.builtin').lsp_implementations(require'telescope.themes'.get_ivy { })<CR>",
              opts)

            -- }
            -- }

            require 'lsp_signature'.on_attach(client, bufnr)
            require 'nvim-navic'.attach(client, bufnr)
            require 'nvim-navbuddy'.attach(client, bufnr)
            -- lsp_spinner.on_attach(client, bufnr)
            -- lsp_status.on_attach(client, bufnr)
          end

          -- Use a loop to conveniently call 'setup' on multiple servers and
          -- map buffer local keybindings when the language server attaches
          local servers = { "rust_analyzer", "yamlls", "ccls", "jsonls", "tsserver", 'terraformls',
            "luau_lsp", "pyright", "bashls", "ruff_lsp" }
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
          -- nvim_lsp['pylsp'].setup {
          --   on_attach = on_attach,
          --   capabilities = capabilities,
          --   flags = {
          --     debounce_text_changes = 150,
          --   },
          --   settings = {
          --     pylsp = {
          --       plugins = {
          --         rope_autoimport = {
          --           enabled = true
          --         }
          --       }
          --     }
          --   }
          -- }
          nvim_lsp['gopls'].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "go", "gomod" },
            message_level = vim.lsp.protocol.MessageType.Error,
            cmd = {
              "gopls",                              -- share the gopls instance if there is one already
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
                  generate = true,   -- show the `go generate` lens.
                  gc_details = true, --  // Show a code lens toggling the display of gc's choices.
                  tidy = true        -- adding mod tidy
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
          nvim_lsp.lua_ls.setup {
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
          -- disable virtual text {
          vim.diagnostic.config({
            virtual_text = false,
          })
          -- }
        end
      },
     { "RishabhRD/popfix" },
     { "aznhe21/actions-preview.nvim",
        config = function()
          vim.keymap.set({ "v", "n" }, "<leader>ca", require("actions-preview").code_actions)
        end,
      },
     { "onsails/lspkind-nvim",
        config = function()
          require('lspkind').init({
            symbol_map = {
              Text = '',
              Method = 'ƒ',
              Function = '',
              Constructor = '',
              Copilot = ''
            }
          })
        end
      },
     { "RishabhRD/nvim-lsputils",
        dependencies = { { "RishabhRD/popfix" } },
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
        end },
     { "SmiteshP/nvim-navbuddy",
        dependencies = {
          "neovim/nvim-lspconfig",
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
        },
        config = function()
          require 'nvim-navbuddy'.setup {}
        end
      },
      -- }

      -- debug {
     { "theHamsta/nvim-dap-virtual-text" },
     { "Pocco81/DAPInstall.nvim",
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
        end },
     { "mfussenegger/nvim-dap",
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
      },
     { "rcarriga/nvim-dap-ui",
        dependencies = {
          "mfussenegger/nvim-dap",
          "folke/neodev.nvim",
          "nvim-neotest/nvim-nio"
        },
        config = function()
          require("neodev").setup( {
            library = { plugins = { "nvim-dap-ui" }, types = true }
          })
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
              max_width = nil   -- Floats will be treated as percentage of your screen.
            }
          })
        end
      },
      -- use { "rcarriga/vim-ultest",
      --       dependencies = {"vim-test/vim-test"},
      --       build = ":UpdateRemotePlugins" }
      -- }

      -- treesitter {
     { "nvim-treesitter/nvim-treesitter",
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
            rainbow = { enable = true }
          }
        end
      },
     { "SmiteshP/nvim-navic",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
          require 'nvim-navic'.setup {}
        end
      },
      -- Just {
     {
        "IndianBoy42/tree-sitter-just",
        config = function()
          require('tree-sitter-just').setup({})
        end
      },
      -- }
      -- }

      -- completion {
     { "CopilotC-Nvim/CopilotChat.nvim",
       opts = {
         show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
         debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
         disable_extra_info = 'no', -- Disable extra information (e.g: system prompt) in the response.
         -- proxy = "socks5://127.0.0.1:3000", -- Proxies requests via https or socks.
       },
       build = function()
         vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
       end,
       event = "VeryLazy",
       keys = {
         { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
         { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
         {
           "<leader>ccv",
           ":CopilotChatVisual",
           mode = "x",
           desc = "CopilotChat - Open in vertical split",
         },
         {
           "<leader>ccx",
           ":CopilotChatInPlace<cr>",
           mode = "x",
           desc = "CopilotChat - Run in-place code",
         },
       },
     },
     { "MunifTanjim/nui.nvim" },
     { "honza/vim-snippets" },
     -- { "SirVer/ultisnips", 
     --  config = function()
     --    vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
     --    vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
     --    vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
     --    vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
     --    vim.g.UltiSnipsRemoveSelectModeMappings = 0
     --  end },
     { "L3MON4D3/LuaSnip",
      dependencies = { "rafamadriz/friendly-snippets",
                       'saadparwaiz1/cmp_luasnip' },
       run = "make install_jsregexp"
     },
     { 'hrsh7th/cmp-nvim-lsp' },
     { 'hrsh7th/cmp-buffer' },
     { 'hrsh7th/cmp-path' },
     { 'hrsh7th/cmp-cmdline' },
     -- { 'quangnguyen30192/cmp-nvim-ultisnips' },
     { "zbirenbaum/copilot.lua",
        config = function()
          require 'copilot'.setup {
            suggestion = { enabled = false },
          }
        end
      },
     { "zbirenbaum/copilot-cmp",
        dependencies = { "zbirenbaum/copilot.lua", "copilot.lua" },
        config = function()
          require("copilot_cmp").setup()
        end
      },
     { 'hrsh7th/nvim-cmp', config = function()
        local t = function(str)
          return vim.api.nvim_replace_termcodes(str, true, true, true)
        end
        local has_words_before = function()
          unpack = unpack or table.unpack
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local luasnip = require("luasnip")
        local cmp = require('cmp')
        local lspkind = require('lspkind')
        cmp.setup {
          formatting = {
            format = function(entry, vim_item)
              if vim.tbl_contains({ 'path' }, entry.source.name) then
                local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item()
                  .label)
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
            keyword_length = 0
          },
          sources = cmp.config.sources({
            { name = 'ultisnips' },
            { name = 'copilot' },
            { name = 'nvim_lsp' },
            { name = 'buffer' },
            { name = 'path' },
          }),
          snippet = {
            expand = function(args)
              vim.fn["UltiSnips#Anon"](args.body)
            end,
          },
          mapping = {
            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
              -- that way you will only jump inside the snippet region
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              elseif has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" }),
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
            ['<C-Space>'] = cmp.mapping.complete(),
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
            { name = 'buffer', option = { keyword_pattern = [=[[^[:blank:]].*]=] } }
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
      },
     { "ThePrimeagen/refactoring.nvim",
        dependencies = {
          { "nvim-lua/plenary.nvim" },
          { "nvim-treesitter/nvim-treesitter" }
        },
        config = function()
          require 'refactoring'.setup({
            -- prompt for return type
            prompt_func_return_type = {
              go = true,
              cpp = true,
              c = true,
              java = true,
            },
            -- prompt for function parameters
            prompt_func_param_type = {
              go = true,
              cpp = true,
              c = true,
              java = true,
            },
          })
          -- Remaps for the refactoring operations currently offered by the plugin
          vim.api.nvim_set_keymap("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
          vim.api.nvim_set_keymap("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], {noremap = true, silent = true, expr = false})
          vim.api.nvim_set_keymap("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], {noremap = true, silent = true, expr = false})
          vim.api.nvim_set_keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})

          -- Extract block doesn't need visual mode
          vim.api.nvim_set_keymap("n", "<leader>rebb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], {noremap = true, silent = true, expr = false})
          vim.api.nvim_set_keymap("n", "<leader>rebf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]], {noremap = true, silent = true, expr = false})

          -- Inline variable can also pick up the identifier currently under the cursor without visual mode
          vim.api.nvim_set_keymap("n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})
        end

      },
      -- }

      -- wiki {
      -- }

      -- git {
     { "sindrets/diffview.nvim",
        dependencies = 'nvim-lua/plenary.nvim'
      },
     { 'NeogitOrg/neogit',
        dependencies = {
          'nvim-lua/plenary.nvim',
          'sindrets/diffview.nvim'
        },
        config = function()
          require 'neogit'.setup { integrations = { diffview = true } }
          local opts = { noremap = true, silent = true }
          vim.api.nvim_set_keymap("n", "<Leader>gn", "<Cmd>Neogit<CR>", opts)
        end
      },
      -- use { 'pwntester/octo.nvim', config = function()
      --   require "octo".setup()
      -- end }
      -- use {'tpope/vim-fugitive'}
     { 'junegunn/gv.vim' },
     { 'ThePrimeagen/git-worktree.nvim',
        config = function()
          require("git-worktree").setup {}
        end },
     { "lewis6991/gitsigns.nvim",
        config = function()
          local on_attach = function(bufnr)
            local opts = { noremap = true, silent = true }
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gs', '<cmd>lua require"gitsigns".stage_hunk()<CR>',
              opts)
          end
          require('gitsigns').setup {
            on_attach = on_attach
          }
        end
      },
      -- }

      -- Languages {
      -- Rust {
     { "simrat39/rust-tools.nvim",
        config = function() require 'rust-tools'.setup {} end
      },
      -- }

     { "eraserhd/parinfer-rust",
        build = "cargo build --release",
        ft = { "clojure", "fennel" }
      },
      -- }

      -- Golang {
      -- use {"fatih/vim-go",
      --      ft = "go"}
     { 'ray-x/go.nvim',
        dependencies = { 'ray-x/guihua.lua' },
        config = function()
          require 'go'.setup {}
        end
      },
     { 'leoluz/nvim-dap-go',
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
      },
      -- }
      -- Python {
      -- use { 'tmhedberg/SimpylFold' }
      -- }
      -- Markdown {
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        init = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" },
      },
      -- }
      -- Database {
     { "tpope/vim-dadbod" },
     { "kristijanhusak/vim-dadbod-ui", 
        config = function()
          vim.g.db_ui_use_nerd_fonts = 1
        end
      },
     { "kristijanhusak/vim-dadbod-completion",
        config = function ()
          vim.api.nvim_create_autocmd("FileType",
            {
              pattern= {"sql" ,"mysql","plsql"},
              command=[[lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })]]
            }
          )
        end}
      -- }
    -- }
  }
)



-- vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker nospell:
