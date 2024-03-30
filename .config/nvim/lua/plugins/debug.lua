-- Debugger
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "Breakpoint Condition" })
    vim.keymap.set('n', "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
    vim.keymap.set('n', "<leader>dc", function() require("dap").continue() end, { desc = "Continue" })
    vim.keymap.set('n', "<leader>da", function() require("dap").continue({ before = get_args }) end, { desc = "Run with Args" })
    vim.keymap.set('n', "<leader>dC", function() require("dap").run_to_cursor() end, { desc = "Run to Cursor" })
    vim.keymap.set('n', "<leader>dg", function() require("dap").goto_() end, { desc = "Go to Line (No Execute)" })
    vim.keymap.set('n', "<leader>di", function() require("dap").step_into() end, { desc = "Step Into" })
    vim.keymap.set('n', "<leader>dj", function() require("dap").down() end, { desc = "Down" })
    vim.keymap.set('n', "<leader>dk", function() require("dap").up() end, { desc = "Up" })
    vim.keymap.set('n', "<leader>dl", function() require("dap").run_last() end, { desc = "Run Last" })
    vim.keymap.set('n', "<leader>do", function() require("dap").step_out() end, { desc = "Step Out" })
    vim.keymap.set('n', "<leader>dO", function() require("dap").step_over() end, { desc = "Step Over" })
    vim.keymap.set('n', "<leader>dp", function() require("dap").pause() end, { desc = "Pause" })
    vim.keymap.set('n', "<leader>dr", function() require("dap").repl.toggle() end, { desc = "Toggle REPL" })
    vim.keymap.set('n', "<leader>ds", function() require("dap").session() end, { desc = "Session" })
    vim.keymap.set('n', "<leader>dt", function() require("dap").terminate() end, { desc = "Terminate" })
    vim.keymap.set('n', "<leader>dw", function() require("dap.ui.widgets").hover() end, { desc = "Widgets" })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup()
  end,
}