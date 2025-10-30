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

require("lazy").setup( { 
  -- Vim stuff {
    {'folke/tokyonight.nvim',
      config = true
    },
    { "shortcuts/no-neck-pain.nvim" },
    { 'glacambre/firenvim',
      build = ":call firenvim#install(0)",
      config = function()
        vim.g.firenvim_config = {
          globalSettings = { alt = "all" },
          localSettings = {
            [".*"] = {
              takeover = "never"
            }
          }
        }
      end
    },
    "nvim-lua/plenary.nvim",
    "junegunn/vim-easy-align",
    { "tpope/vim-rsi" },
    { "tpope/vim-surround" },
    "godlygeek/tabular",
    { "folke/which-key.nvim",
        opts = {
        preset = "modern",
        triggers = {
          { "<auto>", mode = "nixsoc" },
        }
     }
    },
    { 'folke/twilight.nvim',   opts = {} },
    { 'folke/zen-mode.nvim',   opts = {} },
    { "folke/todo-comments.nvim",
      dependencies = "nvim-lua/plenary.nvim",
      opts = {
        highlight = {
          pattern = [[.*<(KEYWORDS)\s*\(*\w*\)*:]],
        },
        search = {
          pattern = [[\b(KEYWORDS)\s*\(*\w*\)*:]],
        },
        keywords = {
          FIXME = {
            icon = " ",
            color = "error",
            alt = { "FIX", "BUG", "FIXIT", "ISSUE" },
          }
        }
      }
    },
    { "folke/trouble.nvim",
      dependencies = "nvim-tree/nvim-web-devicons",
      opts = {
        auto_fold = true,
        auto_preview = false,
      },
      keys = {
        {
          "<leader>xw",
          "<cmd>Trouble diagnostics toggle focus=true<cr>",
          desc = "Diagnostics (Trouble)",
        },
        {
          "<leader>xx",
          "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
          desc = "Buffer Diagnostics (Trouble)",
        },
      }
    },
    -- "HiPhish/nvim-ts-rainbow2",
    'HiPhish/rainbow-delimiters.nvim',
    { "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      config = function()
        local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
        }
        local hooks = require "ibl.hooks"
        -- create the highlight groups in the highlight setup hook, so they are reset
        -- every time the colorscheme changes
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
        end)

        vim.g.rainbow_delimiters = { highlight = highlight }
        require("ibl").setup { scope = { highlight = highlight } }

        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
      end
    },
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
    -- { "stevearc/oil.nvim",
    --   opts = {} },
    { "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
        -- 'b0o/nvim-tree-preview.lua',
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
              {
                function()
                  return navic.get_location()
                end,
                cond = navic.is_available
              },
            },
            lualine_x = {
              {
                require("noice").api.statusline.mode.get,
                cond = require("noice").api.statusline.mode.has,
                color = { fg = "#ff9e64" },
              }, 'encoding', 'fileformat', 'filetype'
            }
          },
          winbar = {
          },
          inactive_winbar = {},
          extensions = {'aerial', 'nvim-dap-ui', 'trouble', 'mundo'}
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
        require("incline").setup({
          hide = {
            cursorline = true,
          }
        })
      end,
      event = "VeryLazy"
    },
    { 'simnalamburt/vim-mundo' },
    { 'windwp/nvim-autopairs',
      opts = {}
    },
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
        vim.o.foldcolumn = '0'   -- '0' is not bad
        vim.o.foldlevel = 99     -- Using ufo provider need a large value, feel free to decrease the value
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
          enable_get_fold_virt_text = true,
          close_fold_kinds_for_ft = { go = { 'imports', 'comment' } },
          fold_virt_text_handler = handler,
          -- provider_selector = function(bufnr, filetype, buftype)
          --   return ftMap[filetype] or { 'treesitter', 'indent' }
          -- end
        })
      end
    },
    "rcarriga/nvim-notify",
    "AndrewRadev/linediff.vim",
    { "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
        cmdline = {
          view = "cmdline",
        },
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = false, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      },
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      }
    },
    -- }

    -- Telescope {
    -- use {"nvim-telescope/telescope-fzf-writer.nvim"}
    -- { "nvim-telescope/telescope-frecency.nvim",
    --    dependencies = { "tami5/sqlite.lua" } },

    { "nvim-telescope/telescope-dap.nvim",
      config = function()
        require('telescope').load_extension('dap')
      end
    },
    { "nvim-telescope/telescope.nvim",
      dependencies = {
        { 'nvim-telescope/telescope-ui-select.nvim' },
        { 'nvim-lua/popup.nvim' },
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim' },
        { 'ThePrimeagen/git-worktree.nvim' },
        { "nvim-telescope/telescope-dap.nvim" },
        { "ibhagwan/fzf-lua" }, -- NOTE: this is dependency only because the binds are here 
      },
      config = function()-- {
        local trouble = require('trouble.sources.telescope')
        local aerial = require('aerial')
        local telescope = require('telescope')
        local actions = require('telescope.actions')

        telescope.load_extension("git_worktree")
        telescope.load_extension("dap")
        telescope.load_extension("aerial")
        telescope.load_extension("refactoring")
        telescope.load_extension('menufacture')
        telescope.load_extension('ui-select')

        telescope.setup {
          defaults = vim.tbl_extend(
            "force",
            require('telescope.themes').get_ivy(),
            {
              dynamic_preview_title = true,
              mappings = {
                i = { ["<c-t>"] = trouble.open },
                n = {
                  ["<c-t>"] = trouble.open,
                  ["<c-d>"] = actions.delete_buffer,
                },
              }
            }
          ),
          extensions = {
            fzf = {
              fuzzy = true,
              override_generic_sorter = true,
              override_file_sorter = true,
              case_mode = "smart_case",
            },
            aerial = {
              show_nesting = {
                ["_"] = true, -- This key will be the default
              },
            }
          }
        }
        local opts = { noremap = true, silent = true }
        -- mappings {
        vim.api.nvim_set_keymap("n", "<Leader>gg", "<Cmd>lua require('fzf-lua').resume()<CR>", opts)
        -- Buffer/file stuff {
        vim.api.nvim_set_keymap("n", "<Leader>bf", "<Cmd>lua require('fzf-lua').files()<CR>",
          opts)
        vim.api.nvim_set_keymap("n", "<Leader>bb", "<Cmd>lua require('fzf-lua').buffers()<CR>",
          opts)
        vim.api.nvim_set_keymap("n", "<Leader>bo", "<Cmd>lua require('telescope').extensions.menufacture.oldfiles()<CR>",
          opts)
        vim.api.nvim_set_keymap("n", "<Leader>bg", "<Cmd>lua require('fzf-lua').live_grep()<CR>",
          opts)
        vim.api.nvim_set_keymap("n", "<Leader>bt", "<Cmd>lua require('telescope').extensions.aerial.aerial()<CR>",
          opts)
        -- }
        -- Git stuff {
        vim.api.nvim_set_keymap("n", "<Leader>gb", "<Cmd>lua require('telescope.builtin').git_branches()<CR>",
          opts)
        vim.api.nvim_set_keymap("n", "<Leader>gws",
          "<Cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", opts)
        vim.api.nvim_set_keymap("n", "<Leader>gwc",
          "<Cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", opts)
        -- vim.api.nvim_set_keymap("n", "<Leader>gs", "<Cmd>lua require('telescope.builtin').git_status()<CR>", opts)
        -- vim.api.nvim_set_keymap("n", "<Leader>gS", "<Cmd>lua require('telescope.builtin').git_stash()<CR>", opts)
        -- }
        -- DAP stuff {
        -- vim.api.nvim_set_keymap('n', '<leader>dtc',
        --   '<cmd>lua require"telescope".extensions.dap.commands{}<CR>', opts)
        -- vim.api.nvim_set_keymap('n', '<leader>dto',
        --   '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>',
        --   opts)
        -- vim.api.nvim_set_keymap('n', '<leader>dtb',
        --   '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>'
        --   ,
        --   opts)
        -- vim.api.nvim_set_keymap('n', '<leader>dtv',
        --   '<cmd>lua require"telescope".extensions.dap.variables{}<CR>', opts)
        -- vim.api.nvim_set_keymap('n', '<leader>dtf', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>',
        --   opts)
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
      end-- }
    },
    { 'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    },
    { 'molecule-man/telescope-menufacture' },
    { "ibhagwan/fzf-lua",
      -- optional for icon support
      dependencies = { "nvim-tree/nvim-web-devicons" },
      -- or if using mini.icons/mini.nvim
      -- dependencies = { "echasnovski/mini.icons" },
      opts = {}
    },
    --}

    -- lsp {
    -- { "j-hui/fidget.nvim",
    --   lazy = false,
    --   cmd = "Fidget",
    --   config = function()
    --     require("fidget").setup {}
    --   end
    -- },
    { "stevearc/aerial.nvim",
      config = function()
        require('aerial').setup({
          on_attach = function(bufnr)
            -- Jump forwards/backwards with '{' and '}'
            vim.keymap.set("n", "t{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
            vim.keymap.set("n", "t}", "<cmd>AerialNext<CR>", { buffer = bufnr })
          end,
          backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
        })
        vim.keymap.set("n", "<Leader>bT", "<cmd>AerialToggle! right<CR>", {})
      end
    },
    { "nvimtools/none-ls.nvim",
      dependencies = {
        "gbprod/none-ls-shellcheck.nvim",
      },
      config = function()
        local nls = require('null-ls')
        nls.register(require('none-ls-shellcheck.diagnostics'))
        nls.register(require('none-ls-shellcheck.code_actions'))
        local sources = {
          -- nls.builtins.diagnostics.semgrep,
          -- nls.builtins.diagnostics.mypy.with({ prefer_local = true }),
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
      end
    },
    { "ray-x/lsp_signature.nvim", },
    { "rmagatti/goto-preview",
      dependencies = {
        'rmagatti/logger.nvim'
      },
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
      end
    },
    { "rachartier/tiny-inline-diagnostic.nvim",
      config = function()
        vim.diagnostic.config({
          virtual_text = false,
          virtual_lines = false,
        })
        require('tiny-inline-diagnostic').setup({
          preset = "minimal"
        })
        vim.keymap.set("n", ",t", function()
          require('tiny-inline-diagnostic').toggle()
        end, { desc = "Toggle inline diagnostics" })
      end
    },
    { "neovim/nvim-lspconfig",
      dependencies = {
        { "ray-x/lsp_signature.nvim" },
        { "kosayoda/nvim-lightbulb" },
      },
      config = function()
        local nvim_lsp = vim.lsp.config

        -- local lsp_status = require("lsp-status")
        -- lsp_status.register_progress()
        -- local capabilities = lsp_status.capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local capabilities = require 'cmp_nvim_lsp'.default_capabilities(capabilities)
        capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true
        }

        -- codelens refresh func {
        local function setup_codelens_refresh(client, bufnr)
          local status_ok, codelens_supported = pcall(function()
            return client:supports_method("textDocument/codeLens")
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
          local cb = function()
            if vim.api.nvim_buf_is_loaded(bufnr) then
              vim.lsp.codelens.refresh({ bufnr = 0 })
            end
          end
          vim.api.nvim_create_augroup(group, { clear = false })
          vim.api.nvim_create_autocmd(cl_events, {
            group = group,
            buffer = bufnr,
            callback = cb,
          })
        end

        -- }
        -- define signs {
        local signs = { Error = "⚠ ", Warn = " ", Hint = "¿ ", Info = " " }
        for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
        -- }
        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = function(client, bufnr)
          -- enable inlay hints {
          vim.lsp.inlay_hint.enable(true)
          -- }
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


          -- See `:help vim.lsp.*` for documentation on any of the below functions
          buf_set_keymap('n', ',h', '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>', opts)
          buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
          buf_set_keymap('n', '<C-]>', "<Cmd>lua vim.lsp.buf.definition(require'telescope.themes'.get_ivy { })<CR>",
            opts)
          buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
          buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
          buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
          -- buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
          -- buf_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
          buf_set_keymap('n', ',d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
          buf_set_keymap('n', ',i', '<cmd>lua vim.diagnostic.config({ virtual_text = false })<CR>', opts)
          buf_set_keymap('n', ',I', '<cmd>lua vim.diagnostic.config({ virtual_text = true })<CR>', opts)
          -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
          buf_set_keymap("n", ",.", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
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
          if client.server_capabilities.documentSymbolProvider then
            require 'nvim-navic'.attach(client, bufnr)
            require 'nvim-navbuddy'.attach(client, bufnr)
          end
          -- lsp_spinner.on_attach(client, bufnr)
          -- lsp_status.on_attach(client, bufnr)
        end

        -- Use a loop to conveniently call 'setup' on multiple servers and
        -- map buffer local keybindings when the language server attaches
        local servers = { "rust_analyzer", "yamlls", "jsonls", "ts_ls", 'terraformls',
          "luau_lsp", "bashls",  "marksman", "vacuum", "ruff" }
        -- "ruff",

        -- Add openapi filetypes for vacuum
        -- Anything that matches openapi.*.ya?ml or openapi.*.json
        vim.filetype.add {
          pattern = {
            ['openapi.*%.ya?ml'] = 'yaml.openapi',
            ['openapi.*%.json'] = 'json.openapi',
          },
        }
        for _, lsp in ipairs(servers) do
          if lsp == "jsonls" or lsp == "luau_lsp" then
            capabilities.textDocument.completion.completionItem.snippetSupport = true
          else
            capabilities.textDocument.completion.completionItem.snippetSupport = false
          end
          vim.lsp.config(lsp, {
            -- root_dir = require('lspconfig.util').find_git_ancestor,
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
              debounce_text_changes = 150,
            }
          })
          vim.lsp.enable(lsp)
        end
        vim.lsp.config('zuban', {
          root_dir = require('lspconfig.util').find_git_ancestor(),
          on_attach = on_attach,
          single_file_support = true,
          settings = {
            pyright = {
              disableLanguageServices = false,
              disableOrganizeImports = false
            },
            basedpyright = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true
              }
            },
            python = {
              analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = "workspace", -- openFilesOnly, workspace
                typeCheckingMode = "basic", -- off, basic, strict
                useLibraryCodeForTypes = true
              }
            },
          },
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 150,
          }
        })
        vim.lsp.enable('zuban')

        nvim_lsp('clangd', {
          on_attach = on_attach,
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 150,
          },
          cmd = {
            "clangd",
            "--offset-encoding=utf-16",
            "--limit-results=0",
          }
        })
        vim.lsp.enable('clangd')

        nvim_lsp('gopls', {
          on_attach = on_attach,
          capabilities = capabilities,
          filetypes = { "go", "gomod" },
          message_level = vim.lsp.protocol.MessageType.Error,
          cmd = {
            "gopls",                                -- share the gopls instance if there is one already
            "-remote=auto", --[[ debug options ]]   --
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
                gc_details=true,
                generate = true,
                regenerate_cgo = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              matcher = "Fuzzy",
              diagnosticsDelay = "500ms",
              -- diagnosticsDelay = "500ms",
              -- experimentalWatchedFileDelay = "100ms",
              symbolMatcher = "fuzzy",
              gofumpt = false,   -- true, -- turn on for new repos, gofmpt is good but also create code turmoils
              buildFlags = { "-tags", "integration" }
              -- buildFlags = {"-tags", "functional"}
            }
          }
        })
        vim.lsp.enable('gopls')

        nvim_lsp("lua_ls", {
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
        })
        vim.lsp.enable('lua_ls')
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
          virtual_lines = false,
        })
        -- }
      end
    },
    { "RishabhRD/popfix" },
    { "aznhe21/actions-preview.nvim",
      config = function()
        vim.keymap.set({ "v", "n" }, "<leader>ca", function()
          require("actions-preview").code_actions({context={only={"source"}}})
        end )
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
            Codeium = '',
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
      end
    },
    { "icholy/lsplinks.nvim",
       config = function()
        local lsplinks = require("lsplinks")
        lsplinks.setup()
        vim.keymap.set("n", "gx", lsplinks.gx)
       end
    },
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
    { "theHamsta/nvim-dap-virtual-text",
      config = function()
        require('nvim-dap-virtual-text').setup({
          enabled = true,
          highlight_changed_variables = true,
          highlight_new_as_changed = true,
          all_references = true,
          virt_text_pos = 'eol', -- 'eol' | 'inline' | 'right_align'
          commented = false,
          show_stop_reason = true,
          commented_string = "󰁂 ",
        })
      end
    },
    { "williamboman/mason.nvim",
      config = function()
        require('mason').setup {
          highlight = {
            enabled = true,
            colors = {
              red = "#ff0000",
              green = "#00ff00",
              blue = "#0000ff",
              yellow = "#ffff00",
              magenta = "#ff00ff",
              cyan = "#00ffff",
              white = "#ffffff",
              black = "#000000",
              orange = "#ff8000",
              violet = "#8000ff",
              pink = "#ff00ff",
              grey = "#808080",
              brown = "#804000",
            }
          }
        }
      end
    },
    { "mfussenegger/nvim-dap",
      config = function()
        local dap = require('dap')
        dap.adapters.lldb = {
          type = 'executable',
          command = 'lldb',   -- adjust as needed
          name = "lldb"
        }
        dap.adapters.codelldb = {
          type = 'server',
          port = "${port}",
          executable = {
            command = 'codelldb',
            args = {"--port", "${port}"},
          }
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
        dap.configurations.cpp = {
          {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            MIMode = 'lldb',
            cwd = '${workspaceFolder}/build/debug/bin',
            stopOnEntry = false,
            preRunCommands = {"breakpoint name configure --disable cpp_exception"},
            externalConsole = false,
          },
        }
      end
    },
    { "folke/lazydev.nvim",
      ft = "lua",
    },
    { "rcarriga/nvim-dap-ui",
      dependencies = {
        "mfussenegger/nvim-dap",
        "folke/lazydev.nvim",
        "nvim-neotest/nvim-nio"
      },
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
              position = "left"   -- Can be "left" or "right"
            },
            {
              elements = {
                "repl",
                "console"
              },
              position = "bottom",   -- Can be "bottom" or "top"
              size = 10,
            }
          },
          floating = {
            max_height = nil,   -- These can be integers or a float between 0 and 1.
            max_width = nil     -- Floats will be treated as percentage of your screen.
          }
        })
      end
    },
    { "nvim-neotest/neotest",
      dependencies = {
        "nvim-neotest/neotest-python",
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter"
      },
      config = function ()
        require("neotest").setup({
          adapters = {
            require("neotest-python")({
              dap = { justMyCode = false },
              default_strategy="dap",
            })
          }
        })

        vim.fn.sign_define('DapBreakpoint', {text=" ", texthl='', linehl='', numhl=''})
        vim.fn.sign_define('DapStopped', {text='󰁕 ', texthl='', linehl='', numhl=''})
        vim.fn.sign_define('DapBreakpointCondition', {text=" ", texthl='', linehl='', numhl=''})
        vim.fn.sign_define('DapLogPoint', {text=".󰁕", texthl='', linehl='', numhl=''})

        vim.keymap.set('n', '<leader>dtr', '<cmd>lua require("neotest").run.run({strategy="dap"})<CR>')
        vim.keymap.set('n', '<leader>dtR', '<cmd>lua require("neotest").run.run({vim.fn.expand("%"), strategy="dap"})<CR>')
        vim.keymap.set("n", "<leader>dwa", require'dapui'.elements.watches.add, { silent = true })
        -- panel
        vim.keymap.set('n', '<leader>dtp', require('neotest').output_panel.toggle)
        vim.keymap.set('n', '<leader>dtl', require('neotest').summary.toggle)
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
    { 'RRethy/vim-illuminate'},
    -- }

    -- Just {
    {
      "IndianBoy42/tree-sitter-just",
      config = function()
        require('tree-sitter-just').setup({})
      end
    },
    -- }

    -- completion {
    { "Exafunction/windsurf.nvim",
      config = function()
        require("codeium").setup({})
      end
    },
    { "CopilotC-Nvim/CopilotChat.nvim",
      branch = "main",
      config = function ()-- {
        local chat = require("CopilotChat")
          chat.setup({
          show_help = "yes",          -- Show help text for CopilotChatInPlace, default: yes
          debug = false,              -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
          disable_extra_info = 'no',  -- Disable extra information (e.g: system prompt) in the response.
          -- proxy = "socks5://127.0.0.1:3000", -- Proxies requests via https or socks.
        })
        local mcp = require("mcphub")
        mcp.on({ "servers_updated", "tool_list_changed", "resource_list_changed" }, function()
          local hub = mcp.get_hub_instance()
          if not hub then
            return
          end

          local async = require("plenary.async")
          local call_tool = async.wrap(function(server, tool, input, callback)
            hub:call_tool(server, tool, input, {
              callback = function(res, err)
                callback(res, err)
              end,
            })
          end, 4)

          local access_resource = async.wrap(function(server, uri, callback)
            hub:access_resource(server, uri, {
              callback = function(res, err)
                callback(res, err)
              end,
            })
          end, 3)

          for name, tool in pairs(chat.config.functions) do
            if tool.id and tool.id:sub(1, 3) == "mcp" then
              chat.config.functions[name] = nil
            end
          end
          local resources = hub:get_resources()
          for _, resource in ipairs(resources) do
            local name = resource.name:lower():gsub(" ", "_"):gsub(":", "")
            chat.config.functions[name] = {
              id = "mcp:" .. resource.server_name .. ":" .. name,
              uri = resource.uri,
              description = type(resource.description) == "string" and resource.description or "",
              resolve = function()
                local res, err = access_resource(resource.server_name, resource.uri)
                if err then
                  error(err)
                end

                res = res or {}
                local result = res.result or {}
                local content = result.contents or {}
                local out = {}

                for _, message in ipairs(content) do
                  if message.text then
                    table.insert(out, {
                      uri = message.uri,
                      data = message.text,
                      mimetype = message.mimeType,
                    })
                  end
                end

                return out
              end,
            }
          end

          local tools = hub:get_tools()
          for _, tool in ipairs(tools) do
            chat.config.functions[tool.name] = {
              id = "mcp:" .. tool.server_name .. ":" .. tool.name,
              group = tool.server_name,
              description = tool.description,
              schema = tool.inputSchema,
              resolve = function(input)
                local res, err = call_tool(tool.server_name, tool.name, input)
                if err then
                  error(err)
                end

                res = res or {}
                local result = res.result or {}
                local content = result.content or {}
                local out = {}

                for _, message in ipairs(content) do
                  if message.type == "text" then
                    table.insert(out, {
                      data = message.text,
                    })
                  elseif message.type == "resource" and message.resource and message.resource.text then
                    table.insert(out, {
                      uri = message.resource.uri,
                      data = message.resource.text,
                      mimetype = message.resource.mimeType,
                    })
                  end
                end

                return out
              end,
            }
          end
        end)
      end,-- }
      build = function()
        vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
      end,
      event = "VeryLazy",
      keys = {
        { "<leader>ccc", "<cmd>CopilotChat<cr>",   desc = "CopilotChat" },
        {
          "<leader>cce",
          ":CopilotChatExplain",
          mode = "x",
          desc = "CopilotChat - Open in vertical split",
        },
      },
    },
    { "olimorris/codecompanion.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "ravitemer/mcphub.nvim",
      },
      opts = {
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              -- MCP Tools 
              make_tools = true,              -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
              show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
              add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
              show_result_in_chat = true,      -- Show tool results directly in chat buffer
              format_tool = nil,               -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
              -- MCP Resources
              make_vars = true,                -- Convert MCP resources to #variables for prompts
              -- MCP Prompts 
              make_slash_commands = true,      -- Add MCP prompts as /slash commands
            }
          }
        },
        adapters = {
          http = {
            openai = function()
              return require("codecompanion.adapters.http").extend("openai", {
                env = {
                  api_key = "OPENAI_API_KEY",
                },
              })
            end,
          }
        },
        display = {
          chat = {
            icons = {
              chat_context = "📎️", -- You can also apply an icon to the fold
            },
            fold_context = true,
          },
        },
      },
      init = function()
        require("plugins.codecompanion.noice"):init()
      end
    },
    { "ravitemer/mcphub.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      build = "npm install -g mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
      config = function()
        require("mcphub").setup()
      end
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
      dependencies = { 
        "rafamadriz/friendly-snippets",
        'saadparwaiz1/cmp_luasnip',
        'ajilo297/vscode-swagger-snippets',
      },
      version = "v2.*",
      build = "make install_jsregexp",
      config = function()
        require("luasnip.loaders.from_snipmate").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load()
      end
    },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    -- { 'quangnguyen30192/cmp-nvim-ultisnips' },
    { "zbirenbaum/copilot.lua",
      config = function()
        require 'copilot'.setup {
          suggestion = { enabled = true },
        }
      end
    },
    { "zbirenbaum/copilot-cmp",
      dependencies = { "zbirenbaum/copilot.lua", "copilot.lua" },
      config = function()
        require("copilot_cmp").setup()
      end
    },
    { 'xzbdmw/colorful-menu.nvim',
      config = function()
        require('colorful-menu').setup()
      end
    },
    { 'hrsh7th/nvim-cmp',
      dependencies = {
        { "samiulsami/cmp-go-deep", dependencies = { "kkharji/sqlite.lua" } },
      },
      config = function()
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
          view = {
            entries = { name = "custom", selection_order = 'near_cursor' }
          },
          window = {
            completion = {
              winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
              col_offset = -3,
              side_padding = 0,
              border = "rounded"
            },
            documentation = cmp.config.window.bordered()
          },
          snippet = {
            expand = function(args)
              require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            end,
          },
          formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
              if vim.tbl_contains({ 'path' }, entry.source.name) then
                local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
                if icon then
                  vim_item.kind = icon
                  vim_item.kind_hl_group = hl_group
                  return vim_item
                end
              end

              local completion_item = entry:get_completion_item()
              local highlights_info = require('colorful-menu').cmp_highlights(entry)
              if highlights_info == nil then
                vim_item.abbr = completion_item.label
              else
                vim_item.abbr_hl_group = highlights_info.highlights
                vim_item.abbr = highlights_info.text
              end
              local kind = lspkind.cmp_format({ mode='symbol_text', max_width=50, with_text=true, show_labelDetail=true })(entry, vim_item)
              local strings = vim.split(kind.kind, "%s", { trimempty = true })
              kind.kind = " " .. (strings[1] or "") .. " "
              kind.menu = "    (" .. (strings[2] or "") .. ")"
              return vim_item
            end
          },
          completion = {
            keyword_length = 0
          },
          sources = cmp.config.sources({
            { name = 'luasnip', max_item_count=2, min_keyword_length=3 },
            { name = 'nvim_lsp' },
            { name = 'lazydev' },
            { name = 'copilot', priority = 0 },
            { name = 'codeium', priority = 1 },
            { name = 'go_deep', max_item_count=5, min_keyword_length=3, priority = 2 },
            { name = 'buffer' },
            { name = 'path' },
          }),
          mapping = {
            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
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
            ['<C-Space>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.complete()
              else
                vim.api.nvim_feedkeys(t('<C-Space>'), 'n', true)
              end
            end, { 'i', 'c' }),
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
        vim.api.nvim_set_keymap("v", "<leader>re",
          [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
          { noremap = true, silent = true, expr = false })
        vim.api.nvim_set_keymap("v", "<leader>rf",
          [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
          { noremap = true, silent = true, expr = false })
        vim.api.nvim_set_keymap("v", "<leader>rv",
          [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
          { noremap = true, silent = true, expr = false })
        vim.api.nvim_set_keymap("v", "<leader>ri",
          [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
          { noremap = true, silent = true, expr = false })

        -- Extract block doesn't need visual mode
        vim.api.nvim_set_keymap("n", "<leader>rebb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
          { noremap = true, silent = true, expr = false })
        vim.api.nvim_set_keymap("n", "<leader>rebf",
          [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
          { noremap = true, silent = true, expr = false })

        -- Inline variable can also pick up the identifier currently under the cursor without visual mode
        vim.api.nvim_set_keymap("n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
          { noremap = true, silent = true, expr = false })
      end

    },
    -- }

    -- wiki {
    -- }

    -- git {
    { "sindrets/diffview.nvim",
      dependencies = 'nvim-lua/plenary.nvim'
    },
    -- use { 'pwntester/octo.nvim', config = function()
    --   require "octo".setup()
    -- end }
    -- use {'tpope/vim-fugitive'}
    { 'junegunn/gv.vim' },
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
    { 'NeogitOrg/neogit',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim'
      },
      config = function()
        require 'neogit'.setup {
          disable_hint = true,
          console_timeout = 3000,
          graph_style = "kitty",
          process_spinner = false,
          integrations = {
            diffview = true,
            telescope = true,
          }
        }
        local opts = { noremap = true, silent = true }
        vim.api.nvim_set_keymap("n", "<Leader>gn", "<Cmd>Neogit<CR>", opts)
      end
    },
    -- { "harrisoncramer/gitlab.nvim",
    --   dependencies = {
    --     "MunifTanjim/nui.nvim",
    --     "folke/tokyonight.nvim",
    --     "nvim-lua/plenary.nvim",
    --     "sindrets/diffview.nvim",
    --     "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
    --     "nvim-tree/nvim-web-devicons" -- Recommended but not required. Icons in discussion tree.
    --   },
    --   enabled = true,
    --   build = function() require("gitlab.server").build(true) end, -- Builds the Go binary
    --   config = function()
    --     require("gitlab").setup({
    --       colors = {
    --         discussion_tree = {
    --           mention = "Normal", -- Use a different highlight group here, like "Normal" 
    --         }
    --       }
    --     })
    --   end,
    -- },
    -- }

    -- Languages {
    -- CSV {
    { 'cameron-wags/rainbow_csv.nvim',
      config = function()
        require 'rainbow_csv'.setup {}
      end,
      ft = {
          'csv',
          'tsv',
          'csv_semicolon',
          'csv_whitespace',
          'csv_pipe',
          'rfc_csv',
          'rfc_semicolon'
      },
      cmd = {
          'RainbowDelim',
          'RainbowDelimSimple',
          'RainbowDelimQuoted',
          'RainbowMultiDelim'
      }
    },
    -- }
    -- Rust {
    -- }
    -- CPP {
    { 'Civitasv/cmake-tools.nvim',
      config = function()
        require('cmake-tools').setup {}
      end
    },
    -- }
    -- Jenkins {
    {'ckipp01/nvim-jenkinsfile-linter'},
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
              debugAdapter = "dlv-dap",   -- `legacy` by default
              request = "attach",
              mode = "remote",
              port = 38697,
              host = "",   -- can skip for localhost
            },
          }
        }
      end
    },
    -- }
    -- Python {
    -- use { 'tmhedberg/SimpylFold' }
    { 'mfussenegger/nvim-dap-python',
      config = function()
        require 'dap-python'.setup()
          table.insert(require('dap').configurations.python, {
            type = 'python',
            request = 'launch',
            name = 'Run locally Prod',
            program = '${file}',
            justMyCode = false,
            cwd='${workspaceFolder}',
            env = {--PYTHONPATH=$(pwd),
              PYTHONPATH=vim.fn.getcwd() .. ':' .. vim.fn.getcwd() .. '/..',
              AWS_PROFILE='default',
              PYTHONUNBUFFERED='1',
              API_STAGE='prod',
              ZESTY_DISK_VERSION='v6',
              ZESTY_EMULATOR='False',
              ZESTY_END_TO_END_TEST='False'}
          })

          table.insert(require('dap').configurations.python, {
            type = 'python',
            request = 'launch',
            name = 'Run locally RND',
            program = '${file}',
            justMyCode = false,
            cwd='${workspaceFolder}',
            env = {
              PYTHONPATH=vim.fn.getcwd() .. ':' .. vim.fn.getcwd() .. '/..',
              AWS_PROFILE='rnd',
              PYTHONUNBUFFERED='1',
              API_STAGE='staging',
              ZESTY_DISK_VERSION='v6',
              ZESTY_EMULATOR='False',
              ZESTY_END_TO_END_TEST='False',
              ZESTY_LOGGER_CONSOLE_LEVEL='DEBUG'}
          })

          table.insert(require('dap').configurations.python, {
            type = 'python',
            request = 'launch',
            name = 'Run locally Staging',
            program = '${file}',
            justMyCode = false,
            cwd='${workspaceFolder}',
            env = {
              PYTHONPATH=vim.fn.getcwd() .. ':' .. vim.fn.getcwd() .. '/..',
              AWS_PROFILE='staging',
              PYTHONUNBUFFERED='1',
              API_STAGE='staging',
              ZESTY_DISK_VERSION='v6',
              ZESTY_EMULATOR='False',
              ZESTY_END_TO_END_TEST='False',
              ZESTY_LOGGER_CONSOLE_LEVEL='DEBUG'}
          })

          table.insert(require('dap').configurations.python, {
            type = 'python',
            request = 'launch',
            name = 'Run monitor.py Staging',
            program = 'src/monitor.py',
            justMyCode = false,
            cwd='/Users/alex.zaslavsky/Projects/zesty/ebs-autoscaler',
            env = {
              PYTHONPATH=vim.fn.getcwd() .. ':' .. vim.fn.getcwd() .. '/..',
              AWS_PROFILE='default',
              PYTHONUNBUFFERED='1',
              API_STAGE='staging',
              ZESTY_DISK_VERSION='v6',
              ZESTY_EMULATOR='False',
              ZESTY_END_TO_END_TEST='False',
              ZESTY_LOGGER_CONSOLE_LEVEL='DEBUG'}
          })

          table.insert(require('dap').configurations.python, {
            type = 'python',
            request = 'launch',
            name = 'pytest',
            program = 'pytest -s ${file} -k ${args}',
            justMyCode = false,
            cwd='${workspaceFolder}',
            env = {
              PYTHONPATH=vim.fn.getcwd() .. ':' .. vim.fn.getcwd() .. '/..',
              AWS_PROFILE='default',
              PYTHONUNBUFFERED='1',
              API_STAGE='dev',
              ZESTY_DISK_VERSION='v6',
              ZESTY_EMULATOR='False',
              ZESTY_END_TO_END_TEST='False'}
          })
      end
    },
    -- }
    -- Markdown {
    { "iamcco/markdown-preview.nvim",
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
      config = function()
        vim.api.nvim_create_autocmd("FileType",
          {
            pattern = { "sql", "mysql", "plsql" },
            command = [[lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })]]
          }
        )
      end
    },
    -- }
    -- YAML {
    { 'vinnymeller/swagger-preview.nvim',
      config = function ()
        require("swagger-preview").setup({
          -- The port to run the preview server on
          port = 8000,
          -- The host to run the preview server on
          host = "127.0.0.1",
        })
      end },
    -- }
    -- }
  }
)

-- Some additional stuff
vim.api.nvim_create_autocmd({'UIEnter'}, {
    callback = function(event)
        local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
        if client ~= nil and client.name == "Firenvim" then
          vim.print("Firenvim client connected")
          require('incline').disable()
        end
    end
})
-- DIE
vim.diagnostic.config { virtual_text = false }

-- vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={,} foldmethod=marker nospell:
