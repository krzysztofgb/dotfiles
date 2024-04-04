# How to Add a New Language

## Common / Supported Languages

- See supported language packs [here](https://github.com/AstroNvim/astrocommunity/tree/main/lua/astrocommunity/pack)
- Simply add the language pack in [community.lua](./lua/community.lua)

## Uncommon / Unsupported Languages

### LSP

- See available language servers [here](https://github.com/mason-org/mason-registry/tree/main/packages)
- Add language server under mason-tool-installer's `opts.ensure_installed` in [community.lua](./lua/community.lua)

### Treesitter (Syntax Highlighting)

- Will be auto-installed if the `tree-sitter` CLI is installed! Otherwise...
- See available languages [here](https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages)
- Add language under `opts.ensure_installed` in [treesitter.lua](./lua/plugins/treesitter.lua)

### Linter

- See available linters [here](https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters)
- Add linter under `linters_by_ft` in [community.lua](./lua/community.lua)

### Formatter

#### Note: This is optional if your linter / LSP also does formatting

- See available formatters [here](https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters)
- Add formatter under `formatters_by_ft` in [community.lua](./lua/community.lua)

### Debugger

- See available adapters [here](https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua)
- Add apapter to mason-tool-installer's `ensure_installed` in [community.lua](./lua/community.lua)
- For more help, see [here](https://docs.astronvim.com/recipes/dap/)
