-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
    },
  },
  -- per line commenting
  { import = "astrocommunity.comment.mini-comment" },
  { import = "astrocommunity.completion.cmp-cmdline" },
  { import = "astrocommunity.debugging.nvim-dap-repl-highlights" },
  { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
  { import = "astrocommunity.debugging.telescope-dap-nvim" },
  { import = "astrocommunity.editing-support.conform-nvim" },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<Leader>fc",
        function() require("conform").format { async = true, lsp_fallback = true } end,
        mode = "",
        desc = "[F]ormat [C]urrent Buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        go = { "gofumpt" },
        lua = { "stylua" },
        markdown = { "mdformat" },
        python = { "black" },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- Can use a sub-list to tell conform to run *until* a formatter is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  },
  { import = "astrocommunity.fuzzy-finder.telescope-zoxide" },
  { import = "astrocommunity.git.blame-nvim" },
  { import = "astrocommunity.indent.mini-indentscope" },
  { import = "astrocommunity.lsp.lsp-signature-nvim" },
  { import = "astrocommunity.lsp.nvim-lint" },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = {
        go = { "golangcilint" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function() require("lint").try_lint() end,
      })
    end,
  },
  { import = "astrocommunity.lsp.nvim-lsp-file-operations" },
  { import = "astrocommunity.markdown-and-latex.glow-nvim" },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  { import = "astrocommunity.media.codesnap-nvim" },
  {
    "mistricky/codesnap.nvim",
    config = function()
      require("codesnap").setup {
        mac_window_bar = true,
        save_path = "~/Desktop",
        code_font_family = "JetBrains Mono",
        watermark = "",
        bg_theme = "default",
        has_breadcrumbs = true,
        breadcrumbs_separator = "/",
      }
    end,
  },
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.harpoon" },
  { import = "astrocommunity.motion.mini-surround" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.go" },
  {
    "nvim-neotest/neotest-go",
    args = {
      "-count=1",
      "-race",
    },
  },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.proto" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.terraform" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.recipes.heirline-clock-statusline" },
  { import = "astrocommunity.recipes.heirline-mode-text-statusline" },
  { import = "astrocommunity.startup.mini-starter" },
  {
    "echasnovski/mini.starter",
    config = function(_, opts)
      local starter = require "mini.starter"
      starter.setup {
        header = table.concat({
          [[            __    __                             __]],
          [[            |  \  |  \                           |  \]],
          [[            | ▓▓\ | ▓▓ ______   ______  __     __ \▓▓______ ____]],
          [[            | ▓▓▓\| ▓▓/      \ /      \|  \   /  \  \      \    \]],
          [[            | ▓▓▓▓\ ▓▓  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\\▓▓\ /  ▓▓ ▓▓ ▓▓▓▓▓▓\▓▓▓▓\]],
          [[            | ▓▓\▓▓ ▓▓ ▓▓    ▓▓ ▓▓  | ▓▓ \▓▓\  ▓▓| ▓▓ ▓▓ | ▓▓ | ▓▓]],
          [[            | ▓▓ \▓▓▓▓ ▓▓▓▓▓▓▓▓ ▓▓__/ ▓▓  \▓▓ ▓▓ | ▓▓ ▓▓ | ▓▓ | ▓▓]],
          [[            | ▓▓  \▓▓▓\▓▓     \\▓▓    ▓▓   \▓▓▓  | ▓▓ ▓▓ | ▓▓ | ▓▓]],
          [[             \▓▓   \▓▓ \▓▓▓▓▓▓▓ \▓▓▓▓▓▓     \▓    \▓▓\▓▓  \▓▓  \▓▓]],
          [[]],
          [[                           Welcome back, Krzysztof!               ]],
        }, "\n"),
        footer = "",
        items = {
          starter.sections.telescope(),
          starter.sections.recent_files(),
          starter.sections.builtin_actions(),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(),
          starter.gen_hook.aligning("center", "center"),
        },
      }

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        desc = "Add dashboard footer",
        once = true,
        callback = function()
          local stats = require("lazy").stats()
          local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
          starter.config.footer = "Neovim loaded "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins  in "
            .. ms
            .. "ms"
          starter.refresh()
        end,
      })

      local go_home = function()
        local wins = vim.api.nvim_tabpage_list_wins(0)
        if #wins > 1 and vim.bo[vim.api.nvim_win_get_buf(wins[1])].filetype == "neo-tree" then
          vim.fn.win_gotoid(wins[2]) -- go to non-neo-tree window to toggle dashboard
        end
        starter.open()
      end
      vim.keymap.set("n", "<Leader>h", go_home, { desc = "Go [H]ome" })
    end,
  },
  { import = "astrocommunity.test.neotest" },
  { import = "astrocommunity.utility.mason-tool-installer-nvim" },
  { import = "astrocommunity.utility.telescope-live-grep-args-nvim" },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        black = {},
        ["golangci-lint"] = {},
        gofumpt = {},
        gopls = {
          analyses = {
            unusedvariable = true,
          },
        },
        ["lua_ls"] = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                library = {
                  "${3rd}/luv/library",
                  unpack(vim.api.nvim_get_runtime_file("", true)),
                },
              },
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = { disable = { "missing-fields" } },
              format = {
                enable = false,
              },
            },
          },
        },
        pyright = {},
        stylua = {},
      },
    },
  },
}
