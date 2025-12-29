-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "docker_language_server", "lua_ls", "rust_analyzer", "ty" },
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    {
        'saghen/blink.cmp',
        version = '1.*',
        opts = {
            completion = { 
                trigger = { show_on_keyword = true },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                }

            },
            keymap = {preset = "enter"},
        },
        opts_extend = { "sources.default" }
    },
    {
    'nvim-telescope/telescope.nvim', tag = 'v0.2.0',
     dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { "tpope/vim-fugitive" },
    { "almo7aya/openingh.nvim" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 3

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.opt.undofile = true

vim.keymap.set('n', '<C-t>', ':tabnew<cr>')
vim.keymap.set('n', '<C-Left>', ':tabp<cr>')
vim.keymap.set('n', '<C-H>', ':tabp<cr>')
vim.keymap.set('n', '<C-Right>', ':tabn<cr>')
vim.keymap.set('n', '<C-L>', ':tabn<cr>')


-- Telescope settings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>h', builtin.oldfiles, { desc = 'Telescope history tags' })


vim.diagnostic.config({
  virtual_text = true,  -- show inline messages
  signs = true,         -- show signs in the gutter
  underline = true,     -- underline problematic text
  update_in_insert = false, -- don't update diagnostics while typing
  severity_sort = true,     -- sort diagnostics by severity
})
