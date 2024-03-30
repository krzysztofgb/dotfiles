return {
  -- Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API
  'folke/neodev.nvim',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- "gc" to comment visual regions/lines
  'numToStr/Comment.nvim',

  -- Game to practice vim motions
  'ThePrimeagen/vim-be-good',

  -- Cool animations
  'eandrju/cellular-automaton.nvim',

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- Star installed plugins on GitHub :)
  {
    'jsongerber/thanks.nvim',
    opts = {
        plugin_manager = "lazy",
    }
  },
}