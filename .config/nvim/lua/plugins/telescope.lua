return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = "^1.0.0",
    },
  },
  config = function(_, opts)
    require("telescope").setup {
      defaults = {
        initial_mode = "insert",
        path_display = {
          "smart",
        },
        sorting_strategy = "descending",
      },
      extensions = {
        file_browser = {
          hijack_netrw = true,
          depth = 5,
          hidden = { file_browser = true, folder_browser = true },
        },
      },
    }

    require("telescope").load_extension "live_grep_args"
    vim.keymap.set(
      "n",
      "<Leader>fg",
      ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
      { desc = "[F]ind with [G]rep" }
    )

    require("telescope").load_extension "file_browser"
    vim.keymap.set(
      "n",
      "<Leader>fe",
      ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
      { desc = "[F]ile [E]xplorer" }
    )
  end,
}
