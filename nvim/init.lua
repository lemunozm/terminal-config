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
              hidden = "hidden",
            },
          }
        })
      end
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
    { "neoclide/coc.nvim",
      --ft = {"json, "rust"},
      branch = "release",
      config = function()
        vim.g.coc_global_extensions = {"coc-json", "coc-rust-analyzer"}

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
        vim.keymap.set("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
        vim.keymap.set("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
        vim.keymap.set("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
        vim.keymap.set("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)
        vim.keymap.set("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
        vim.keymap.set("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
        vim.keymap.set("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
        vim.keymap.set("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)

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

        vim.keymap.set("n", "<C-r>", "<Plug>(coc-range-select)", {silent = true})
        vim.keymap.set("x", "<C-r>", "<Plug>(coc-range-select)", {silent = true})

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

    -- Languages
    { "rust-lang/rust.vim", ft = "rust" },
    {
      'mrcjkb/haskell-tools.nvim',
      ft = { "haskell" },
      version = '^3',
      config = function()
        local ht = require('haskell-tools')
        local opts = { noremap = true, silent = true, buffer = vim.api.nvim_get_current_buf(), }
        vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run, opts)
        vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
        vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)
        vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)
        vim.keymap.set('n', '<leader>rf', function() ht.repl.toggle(vim.api.nvim_buf_get_name(0)) end, opts)
        vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)
      end
    },
    { "ShinKage/idris2-nvim",
      ft = { "idris2", "ipkg" },
      dependencies = {'neovim/nvim-lspconfig', 'MunifTanjim/nui.nvim'},
      config = function()
        require('idris2').setup({})
      end
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
               SpecialComment = { link = "Comment" },
            }
          end,
          color_overrides = {
            mocha = {
              base = "#000000"
            }
          }
        })
        vim.cmd.colorscheme("catppuccin")
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

-- Keys
vim.keymap.set("n", "<leader>", vim.cmd.nohlsearch)
vim.keymap.set("i", "jj", "<esc>")
vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>d", "\"+d")
vim.keymap.set("v", "<leader>p", "\"+p")
vim.keymap.set("v", "<leader>p", "\"+P")
vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>P", "\"+P")
vim.keymap.set("v", "y", "y`]", { silent = true })
vim.keymap.set("v", "<leader>y", "y`]", { silent = true })
vim.keymap.set("n", "<leader><leader>", "<C-^>")

-- Auto commands
vim.api.nvim_create_autocmd(
  "FileType",
  { pattern = "html,pug,javascript,css,sass,vue,dart,yaml,json,haskell,idris,lua",
    callback = function()
      vim.opt_local.shiftwidth = 2
      vim.opt_local.tabstop = 2
    end
  }
)
vim.api.nvim_create_autocmd(
  "BufWritePre",
  { pattern = "*",
    callback = function()
      local curpos = vim.api.nvim_win_get_cursor(0)
      vim.cmd([[keeppatterns %s/\s\+$//e]])
      vim.api.nvim_win_set_cursor(0, curpos)
    end
  }
)
