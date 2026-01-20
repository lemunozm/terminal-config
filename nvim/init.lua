-- Loading Lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Required before loading lazy to mapping correctly
vim.g.mapleader = " "
vim.g.maplocalleader = "º"
require("lazy").setup(
  {
    -- IDE
    { dir = "/opt/homebrew/opt/fzf" },
    { "ibhagwan/fzf-lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      keys = {
        { "<C-s>", "<cmd>FzfLua files<cr>" },
        { "<C-x>", "<cmd>FzfLua grep_project<cr>" },
        { "<leader>s", "<cmd>FzfLua grep_cword<cr>" },
      },
      config = function()
        require("fzf-lua").setup({
          winopts = {
            height = 0.95,
            width = 0.9,
            preview = {
              layout = "vertical",
              vertical = "down:60%",
            },
          },
          fzf_opts = {
            ["--layout"] = "default",
            ["+i"] = "", -- case-sensitive match
          }
        })
      end
    },
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("lualine").setup({
          options = {
            theme = "catppuccin",
          },
          sections = {
            lualine_x = {"g:coc_status", "encoding", "fileformat", "filetype"},
          }
        })
      end
    },
    { "Yggdroot/indentLine",
      config = function()
        vim.g.indentLine_char = "┆"
        vim.g.indentLine_color_term = 234
        vim.g.indentLine_setConceal = 0
      end
    },
    { "guns/xterm-color-table.vim" },
    { "airblade/vim-rooter" },
    { "zefei/vim-wintabs",
      lazy = false,
      keys = {
        { "<C-h>", "<Plug>(wintabs_previous)" },
        { "<C-h>", "<Plug>(wintabs_previous)", mode = "i" },
        { "<C-l>", "<Plug>(wintabs_next)" },
        { "<C-l>", "<Plug>(wintabs_next)", mode = "i" },
        { "<C-c>", "<Plug>(wintabs_close)" },
        { "<C-t>", "<Plug>(wintabs_undo)" },
        { "<C-n>", "<Plug>(wintabs_move_left)" },
        { "<C-m>", "<Plug>(wintabs_move_right)" },
      },
      config = function()
        vim.g.wintabs_ui_sep_leftmost = ""
        vim.g.wintabs_ui_sep_inbetween = ""
        vim.g.wintabs_ui_sep_rightmost = ""
      end
    },
    { "hrsh7th/nvim-cmp",
      lazy = true,
      dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lua',
        'amarakon/nvim-cmp-lua-latex-symbols',
      },
      config = function()
        local cmp = require("cmp")
        local has_words_before = function()
          unpack = unpack or table.unpack
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end
        cmp.setup({
          mapping = cmp.mapping.preset.insert({
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                if #cmp.get_entries() == 1 then
                  cmp.confirm({ select = true })
                else
                  cmp.select_next_item()
                end
              elseif has_words_before() then
                cmp.complete()
                if #cmp.get_entries() == 1 then
                  cmp.confirm({ select = true })
                end
              else
                fallback()
              end
            end, { "i", "s" }),
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
          }),
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'buffer' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'nvim_lua' },
            { name = "lua-latex-symbols", option = { cache = true } },
          }),
        })
      end
    },
    { "neoclide/coc.nvim",
      ft = {"json", "rust", "c", "solidity"},
      branch = "release",
      config = function()
        vim.g.coc_global_extensions = {"coc-json", "coc-rust-analyzer", "@nomicfoundation/coc-solidity"}

        function _G.check_back_space()
            local col = vim.fn.col('.') - 1
            return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
        end

        function _G.show_docs()
            local cw = vim.fn.expand('<cword>')
            if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
                vim.api.nvim_command('h ' .. cw)
            elseif vim.api.nvim_eval('coc#rpc#ready()') then
                vim.fn.CocActionAsync('doHover')
            else
                vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
            end
        end

        local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
        local pum_next = 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()'
        local pum_prev = [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]]
        local pun_confirm = [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]]
        vim.keymap.set("i", "<TAB>", pum_next, opts)
        vim.keymap.set("i", "<S-TAB>", pum_prev, opts)
        vim.keymap.set("i", "<cr>", pun_confirm, opts)

        vim.keymap.set("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
        vim.keymap.set("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

        vim.keymap.set("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
        vim.keymap.set("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

        vim.keymap.set("n", "gd", "<Plug>(coc-definition)", {silent = true})
        vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
        vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", {silent = true})
        vim.keymap.set("n", "gr", "<Plug>(coc-references)", {silent = true})

        vim.keymap.set("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

        vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

        vim.keymap.set("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
        vim.keymap.set("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})

        vim.api.nvim_create_augroup("CocGroup", {})
        vim.api.nvim_create_autocmd("CursorHold", {
            group = "CocGroup",
            command = "silent call CocActionAsync('highlight')",
            desc = "Highlight symbol under cursor on CursorHold"
        })
        vim.api.nvim_create_autocmd("FileType", {
            group = "CocGroup",
            pattern = "typescript,json",
            command = "setl formatexpr=CocAction('formatSelected')",
            desc = "Setup formatexpr specified filetype(s)."
        })
        vim.api.nvim_create_autocmd("User", {
            group = "CocGroup",
            pattern = "CocJumpPlaceholder",
            command = "call CocActionAsync('showSignatureHelp')",
            desc = "Update signature help on jump placeholder"
        })

        local opts = {silent = true, nowait = true}
        vim.keymap.set("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
        vim.keymap.set("n", "<leader>a", "<Plug>(coc-codeaction)", opts)
        vim.keymap.set("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
        vim.keymap.set("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
        vim.keymap.set("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)
        vim.keymap.set("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
        vim.keymap.set("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
        vim.keymap.set("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
        vim.keymap.set("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)
        vim.keymap.set("n", "<leader>t", function()
          vim.fn.CocAction('runCommand', 'rust-analyzer.inlayHints.enable')
        end, {silent = true, desc = "Toggle Rust inlay hints"})

        vim.keymap.set("x", "if", "<Plug>(coc-funcobj-i)", opts)
        vim.keymap.set("o", "if", "<Plug>(coc-funcobj-i)", opts)
        vim.keymap.set("x", "af", "<Plug>(coc-funcobj-a)", opts)
        vim.keymap.set("o", "af", "<Plug>(coc-funcobj-a)", opts)
        vim.keymap.set("x", "ic", "<Plug>(coc-classobj-i)", opts)
        vim.keymap.set("o", "ic", "<Plug>(coc-classobj-i)", opts)
        vim.keymap.set("x", "ac", "<Plug>(coc-classobj-a)", opts)
        vim.keymap.set("o", "ac", "<Plug>(coc-classobj-a)", opts)

        local opts = {silent = true, nowait = true, expr = true}
        vim.keymap.set("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
        vim.keymap.set("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
        vim.keymap.set("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
        vim.keymap.set("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
        vim.keymap.set("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
        vim.keymap.set("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

        -- Choose keys that not overlap
        --vim.keymap.set("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
        --vim.keymap.set("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})

        vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
        vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})
        vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

        vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

        local opts = {silent = true, nowait = true}
        vim.keymap.set("n", "<localleader>a", ":<C-u>CocList diagnostics<cr>", opts)
        vim.keymap.set("n", "<localleader>e", ":<C-u>CocList extensions<cr>", opts)
        vim.keymap.set("n", "<localleader>c", ":<C-u>CocList commands<cr>", opts)
        vim.keymap.set("n", "<localleader>o", ":<C-u>CocList outline<cr>", opts)
        vim.keymap.set("n", "<localleader>s", ":<C-u>CocList -I symbols<cr>", opts)
        vim.keymap.set("n", "<localleader>j", ":<C-u>CocNext<cr>", opts)
        vim.keymap.set("n", "<localleader>k", ":<C-u>CocPrev<cr>", opts)
        vim.keymap.set("n", "<localleader>p", ":<C-u>CocListResume<cr>", opts)
      end
    },
    {
      "iamcco/markdown-preview.nvim",
      ft = { "markdown" },
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      build = "cd app && yarn install",
      init = function()
        vim.g.mkdp_filetypes = { "markdown" }
      end,
    },
    { "weirongxu/plantuml-previewer.vim",
      dependencies = { "tyru/open-browser.vim" },
    },

    -- Languages
    { "rust-lang/rust.vim", ft = "rust" },
    { 'mrcjkb/haskell-tools.nvim',
      ft = { "haskell" },
      version = '^6',
      dependencies = {
        'neovim/nvim-lspconfig',
      },
      init = function()
        -- Configure haskell-tools.nvim here
        vim.g.haskell_tools = {}
      end,

      config = function()
        local ht = require('haskell-tools')
        local opts = { noremap = true, silent = true, buffer = vim.api.nvim_get_current_buf(), }
        vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run, opts)
        vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
        vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)
        vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)
        vim.keymap.set('n', '<leader>rf', function() ht.repl.toggle(vim.api.nvim_buf_get_name(0)) end, opts)
        vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)
        vim.keymap.set("n", "gb", "<Plug>HaskellHoverActionDocs", opts)
        vim.keymap.set("n", "gd", "<Plug>HaskellHoverActionDefinition", opts)
        vim.keymap.set('n', '<space>a', '<Plug>HaskellHoverAction')

      end
    },
    { "ShinKage/idris2-nvim",
      ft = { "idris2", "ipkg" },
      dependencies = {
        'neovim/nvim-lspconfig',
        'MunifTanjim/nui.nvim',
        'hrsh7th/nvim-cmp',
      },
      config = function()
        require('idris2').setup({})
      end
    },
    {
      'Julian/lean.nvim',
      event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
      dependencies = {
        'neovim/nvim-lspconfig',
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
        'hrsh7th/nvim-cmp',
      },
      config = function()
        local function on_attach(_, bufnr)
          local function cmd(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { noremap = true, buffer = true })
          end

          -- Autocomplete using the Lean language server
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

          -- gd in normal mode will jump to definition
          cmd('n', 'gd', vim.lsp.buf.definition)
          -- K in normal mode will show the definition of what's under the cursor
          cmd('n', 'K', vim.lsp.buf.hover)

          -- <leader>n will jump to the next Lean line with a diagnostic message on it
          -- <leader>N will jump backwards
          cmd('n', '<leader>n', function() vim.diagnostic.goto_next{popup_opts = {show_header = false}} end)
          cmd('n', '<leader>N', function() vim.diagnostic.goto_prev{popup_opts = {show_header = false}} end)

          -- <leader>K will show all diagnostics for the current line in a popup window
          cmd('n', '<leader>K', function() vim.diagnostic.open_float(0, { scope = "line", header = false, focus = false }) end)

          -- <leader>q will load all errors in the current lean file into the location list
          -- (and then will open the location list)
          -- see :h location-list if you don't generally use it in other vim contexts
          cmd('n', '<leader>q', vim.diagnostic.setloclist)

          cmd('n', '<leader>r', "<CMD>LeanRestartFile<CR>")
        end

        require('lean').setup({
            abbreviations = { builtin = true },
            lsp = { on_attach = on_attach },
            mappings = true,
        })
      end
    },
    {
      "aklt/plantuml-syntax",
      event = { 'BufReadPre *.puml', 'BufNewFile *.puml' },
    },
    {
      'nvim-flutter/flutter-tools.nvim',
      ft = "dart",
      dependencies = {
          'nvim-lua/plenary.nvim',
          'stevearc/dressing.nvim', -- optional for vim.ui.select
          'hrsh7th/nvim-cmp',
      },
      config = function()
        local function on_attach(_, bufnr)
          local function cmd(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { noremap = true, buffer = true })
          end

          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

          cmd('n', 'gd', vim.lsp.buf.definition)
          cmd('n', 'K', vim.lsp.buf.hover)

          -- <leader>n will jump to the next Lean line with a diagnostic message on it
          -- <leader>N will jump backwards
          cmd('n', '<leader>n', function() vim.diagnostic.goto_next{popup_opts = {show_header = false}} end)
          cmd('n', '<leader>N', function() vim.diagnostic.goto_prev{popup_opts = {show_header = false}} end)

          -- <leader>K will show all diagnostics for the current line in a popup window
          cmd('n', '<leader>K', function() vim.diagnostic.open_float(0, { scope = "line", header = false, focus = false }) end)

          -- <leader>q will load all errors in the current lean file into the location list
          -- (and then will open the location list)
          -- see :h location-list if you don't generally use it in other vim contexts
          cmd('n', '<leader>q', vim.diagnostic.setloclist)

          --Show the message with <space>e
          cmd('n', '<leader>e', vim.diagnostic.open_float)

          -- disable virtual_text (inline) diagnostics and use floating window
          -- format the message such that it shows source, message and
          -- the error code.
          vim.diagnostic.config({
            virtual_text = false,
            signs = true,
            float = {
              border = "single",
              format = function(diagnostic)
                return string.format(
                  "%s (%s) [%s]",
                  diagnostic.message,
                  diagnostic.source,
                  diagnostic.code or diagnostic.user_data.lsp.code
                )
              end,
            },
          })
        end

        require('flutter-tools').setup({
          widget_guides = { enabled = true },
          lsp = { on_attach = on_attach },
          dev_log = {
            open_cmd = "15split",
          },
        })
      end
    },
    {
      "nvim-treesitter/nvim-treesitter",
      branch = 'master',
      lazy = false,
      build = ":TSUpdate",
      opts = {
        ensure_installed = { "haskell", "solidity" },
        highlight = { enable = true, additional_vim_regex_highlighting = false },
      },
      config = function(_, opts)
        require'nvim-treesitter.configs'.setup(opts)
      end,
    },
    {
      "greggh/claude-code.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim", -- Required for git operations
      },
      config = function()
        require("claude-code").setup()
      end
    },
    {
      "gruvw/strudel.nvim",
      build = "npm install",
      config = function()
        require("strudel").setup({
          update_on_save = true,
        })
      end
    },
    {
      "m00qek/baleia.nvim",
      branch = "main",
      config = function()
        -- Match Alacritty color scheme
        local colors = {
          [0]  = "#222222", -- black
          [1]  = "#C6351C", -- red
          [2]  = "#70A531", -- green
          [3]  = "#CAAF38", -- yellow
          [4]  = "#5079AF", -- blue
          [5]  = "#83678B", -- magenta
          [6]  = "#46A4A9", -- cyan
          [7]  = "#DDDED9", -- white
          [8]  = "#696A66", -- bright black
          [9]  = "#E25140", -- bright red
          [10] = "#A9E15E", -- bright green
          [11] = "#FBEB77", -- bright yellow
          [12] = "#8DAED4", -- bright blue
          [13] = "#B795B5", -- bright magenta
          [14] = "#73E3E6", -- bright cyan
          [15] = "#F2F1F0", -- bright white
        }
        vim.g.baleia = require("baleia").setup({ colors = colors })

        -- Command to colorize the current buffer
        vim.api.nvim_create_user_command("BaleiaColorize", function()
          vim.g.baleia.once(vim.api.nvim_get_current_buf())
        end, { bang = true })

        -- Command to show logs
        vim.api.nvim_create_user_command("BaleiaLogs", vim.g.baleia.logger.show, { bang = true })

        -- Automatically colorize .dump files
        vim.api.nvim_create_autocmd("BufReadPost", {
          pattern = "*.dump",
          callback = function()
            vim.g.baleia.once(vim.api.nvim_get_current_buf())
          end,
        })
      end,
    },

    -- Themes
    { "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      config = function()
        require("catppuccin").setup({
          flavour = "mocha",
          custom_highlights = function(colors)
            -- For ref: https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/syntax.lua
            return {
               Search = { fg = "#ffdf5f", style = { "underline" }, bg = colors.base},
               CurSearch = { fg = "#ffdf5f", style = { "underline", "bold" }, bg = colors.base },
               SpecialComment = { link = "Comment" },
               Type = { fg = colors.blue },
               idrisType = { fg = colors.blue },
               Function = { fg = colors.yellow },
               Identifier = { fg = "#bbc4fe" },
               Keyword = { fg = colors.mauve },
               Operator = { fg = "#ffffff" },
               Macro = { fg = colors.teal },
               rustSelf = { fg = colors.red },
               PreProc = { fg = colors.flamingo },
               Normal = { fg = "#fefefe" },
               TabLineSel = { bg = "#555555" },
            }
          end,
          color_overrides = {
            mocha = {
              base = "#000000"
            }
          }
        })

        -- General
        vim.cmd.colorscheme("catppuccin")
        vim.api.nvim_set_hl(0, "@type.builtin", { link = "Type" })

        -- Specific: Solidity
        vim.api.nvim_set_hl(0, "@function.solidity", { link = "@variable.parameter" })
        vim.api.nvim_set_hl(0, "@variable.parameter.solidity", { link = "@variable", bold = true })
        vim.api.nvim_set_hl(0, "@function.method.call.solidity", { link = "@variable", bold = true })
        vim.api.nvim_set_hl(0, "@keyword.operator.solidity", { link = "Keyword"})

      end
    },
  },
  {
    install = {
      missing = false,
    },
    ui = {
      border = "rounded",
    },
  }
)

-- Options
vim.opt.number = true         -- Show line numbers
vim.opt.signcolumn = "yes"    -- Show two kind of symbols per line
vim.opt.expandtab = true      -- Convert tab to space
vim.opt.tabstop = 4           -- Number of space write by a tab
vim.opt.shiftwidth = 4        -- Number of identation spaces (automatic identantion read this)
vim.opt.autoread = true       -- Refresh files that havent been edited by vim
vim.opt.hidden = true         -- Allows open tabs without safe the current one.
vim.opt.swapfile = false      -- No generate swap files
vim.opt.backup = false        -- Avoid creating backup files
vim.opt.writebackup = false   -- Avoid creating backup files
vim.opt.cmdheight = 1         -- Space to displaying messages
vim.opt.shortmess:append("c") -- Don't give ins-completion-menu messages when closing files
vim.opt.scrolloff = 8         -- min number of lines around your cursor (8 above, 8 below)
vim.opt.updatetime = 300      -- Each time the swap file is written on disk
vim.opt.termguicolors = true

-- Keys
vim.keymap.set("n", "<esc>", vim.cmd.nohlsearch)
vim.keymap.set("i", "jj", "<esc>")
vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>d", "\"+d")
vim.keymap.set("v", "<leader>p", "\"+p")
vim.keymap.set("v", "<leader>p", "\"+P")
vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>P", "\"+P")
vim.keymap.set("v", "y", "y`]", { silent = true })
vim.keymap.set("n", "<leader><leader>", "<C-^>")

-- Auto commands
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html,pug,javascript,css,sass,vue,dart,yaml,haskell,idris,lua,json",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end
})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local curpos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, curpos)
  end
})
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.sol",
  command = "silent !forge fmt %"
})

--LSP config
vim.diagnostic.config({
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

local float = { border = "rounded", source = "if_many" }
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)

local opts = { silent = true, noremap = true }
vim.keymap.set("n", "gl", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,   vim.tbl_extend("force", opts, { desc = "Prev diagnostic" }))
vim.keymap.set("n", "]d", vim.diagnostic.goto_next,   vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, { desc = "Quickfix diagnostics" }))

vim.o.updatetime = 200  -- CursorHold delay (ms)
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false, border = "rounded", scope = "cursor" })
  end,
})
