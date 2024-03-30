# How to Add a New Language

## LSP

- See available language servers [here](https://github.com/mason-org/mason-registry/tree/main/packages)
- Add language server under `servers` in [lsp.lua](./lua/plugins/lsp.lua)

## Treesitter (Syntax Highlighting)

- See available languages [here](https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages)
- Add language under `ensure_installed` in [treesitter.lua](./lua/plugins/treesitter.lua)

## Linter

- See available linters [here](https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters)
- Add linter under `linters_by_ft` in [lint.lua](./lua/plugins/lint.lua)

## Formatter

### Note: this is sometimes optional if your linter also does formatting

- See available formatters [here](https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters)
- Add formatter under `formatters_by_ft` in [conform.lua](./lua/plugins/conform.lua)

## Debugger

- See available adapters [here](https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua)
- Add apapter to `dependencies` in [debug.lua](./lua/plugins/debug.lua)
  - Add adapter (external) dependencies under `ensure_installed`
  - Make sure to setup the adapter at the bottom of the `config`
- For more help, see [here](https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go)
