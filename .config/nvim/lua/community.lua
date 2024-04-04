-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
	"AstroNvim/astrocommunity",
	-- available plugins can be found at https://github.com/AstroNvim/astrocommunity
	{ import = "astrocommunity.bars-and-lines.lualine-nvim" },
	{ import = "astrocommunity.colorscheme.tokyonight-nvim" },
	{
		"folke/tokyonight.nvim",
		opts = {
			style = "night",
		},
	},
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
				"<leader>fc",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
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
				python = { "black" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- Can use a sub-list to tell conform to run *until* a formatter is found.
				-- javascript = { { "prettierd", "prettier" } },
			},
		},
	},
	{ import = "astrocommunity.file-explorer.telescope-file-browser-nvim" },
	{ import = "astrocommunity.fuzzy-finder.telescope-zoxide" },
	{ import = "astrocommunity.git.blame-nvim" },
	{ import = "astrocommunity.indent.mini-indentscope" },
	{ import = "astrocommunity.lsp.lsp-signature-nvim" },
	{ import = "astrocommunity.lsp.nvim-lint" },
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				go = { "golangcilint" },
				markdown = { "markdownlint" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
	{ import = "astrocommunity.lsp.nvim-lsp-file-operations" },
	{ import = "astrocommunity/markdown-and-latex/glow-nvim" },
	{ import = "astrocommunity/markdown-and-latex/markdown-preview-nvim" },
	{ import = "astrocommunity.motion.flash-nvim" },
	{ import = "astrocommunity.motion.harpoon" },
	{ import = "astrocommunity.motion.mini-surround" },
	{ import = "astrocommunity.pack.bash" },
	{ import = "astrocommunity.pack.docker" },
	{ import = "astrocommunity.pack.lua" },
	{ import = "astrocommunity.pack.go" },
	-- AstroNvim is tring to install "clang_format" instead of "clang-format"
	-- which is causing errors. A fix will come in a future release of
	-- astrocommunity.pack.java
	-------------------------------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = function(_, opts)
			if opts.ensure_installed ~= "all" then
				opts.ensure_installed =
					require("astrocore").list_insert_unique(opts.ensure_installed, { "java", "html" })
			end
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed =
				require("astrocore").list_insert_unique(opts.ensure_installed, { "jdtls", "lemminx" })
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "clang-format" })
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed =
				require("astrocore").list_insert_unique(opts.ensure_installed, { "javadbg", "javatest" })
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = require("astrocore").list_insert_unique(
				opts.ensure_installed,
				{ "jdtls", "lemminx", "clang-format", "java-debug-adapter", "java-test" }
			)
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		ft = { "java" },
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			{
				"AstroNvim/astrolsp",
				optional = true,
				---@type AstroLSPOpts
				opts = {
					---@diagnostic disable: missing-fields
					handlers = { jdtls = false },
				},
			},
		},
		opts = function(_, opts)
			local utils = require("astrocore")
			-- use this function notation to build some variables
			local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".project" }
			local root_dir = require("jdtls.setup").find_root(root_markers)
			-- calculate workspace dir
			local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
			local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
			vim.fn.mkdir(workspace_dir, "p")

			-- validate operating system
			if not (vim.fn.has("mac") == 1 or vim.fn.has("unix") == 1 or vim.fn.has("win32") == 1) then
				utils.notify("jdtls: Could not detect valid OS", vim.log.levels.ERROR)
			end

			return utils.extend_tbl({
				cmd = {
					"java",
					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dlog.protocol=true",
					"-Dlog.level=ALL",
					"-javaagent:" .. vim.fn.expand("$MASON/share/jdtls/lombok.jar"),
					"-Xms1g",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",
					"-jar",
					vim.fn.expand("$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher.jar"),
					"-configuration",
					vim.fn.expand("$MASON/share/jdtls/config"),
					"-data",
					workspace_dir,
				},
				root_dir = root_dir,
				settings = {
					java = {
						eclipse = { downloadSources = true },
						configuration = { updateBuildConfiguration = "interactive" },
						maven = { downloadSources = true },
						implementationsCodeLens = { enabled = true },
						referencesCodeLens = { enabled = true },
					},
					signatureHelp = { enabled = true },
					completion = {
						favoriteStaticMembers = {
							"org.hamcrest.MatcherAssert.assertThat",
							"org.hamcrest.Matchers.*",
							"org.hamcrest.CoreMatchers.*",
							"org.junit.jupiter.api.Assertions.*",
							"java.util.Objects.requireNonNull",
							"java.util.Objects.requireNonNullElse",
							"org.mockito.Mockito.*",
						},
					},
					sources = {
						organizeImports = {
							starThreshold = 9999,
							staticStarThreshold = 9999,
						},
					},
				},
				init_options = {
					bundles = {
						vim.fn.expand("$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"),
						-- unpack remaining bundles
						(table.unpack or unpack)(vim.split(vim.fn.glob("$MASON/share/java-test/*.jar"), "\n", {})),
					},
				},
				handlers = {
					["$/progress"] = function() end, -- disable progress updates.
				},
				filetypes = { "java" },
				on_attach = function(...)
					require("jdtls").setup_dap({ hotcodereplace = "auto" })
					local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
					if astrolsp_avail then
						astrolsp.on_attach(...)
					end
				end,
			}, opts)
		end,
		config = function(_, opts)
			-- setup autocmd on filetype detect java
			vim.api.nvim_create_autocmd("Filetype", {
				pattern = "java", -- autocmd to start jdtls
				callback = function()
					if opts.root_dir and opts.root_dir ~= "" then
						require("jdtls").start_or_attach(opts)
					else
						require("astrocore").notify(
							"jdtls: root_dir not found. Please specify a root marker",
							vim.log.levels.ERROR
						)
					end
				end,
			})
			-- create autocmd to load main class configs on LspAttach.
			-- This ensures that the LSP is fully attached.
			-- See https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
			vim.api.nvim_create_autocmd("LspAttach", {
				pattern = "*.java",
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					-- ensure that only the jdtls client is activated
					if client.name == "jdtls" then
						require("jdtls.dap").setup_dap_main_class_configs()
					end
				end,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				java = { "clang-format" },
			},
		},
	},
	-------------------------------------------------------------------------
	{ import = "astrocommunity.pack.json" },
	{ import = "astrocommunity.pack.markdown" },
	{ import = "astrocommunity.pack.proto" },
	{ import = "astrocommunity.pack.python" },
	{ import = "astrocommunity.pack.rust" },
	{ import = "astrocommunity.pack.sql" },
	{ import = "astrocommunity.pack.terraform" },
	{ import = "astrocommunity.pack.toml" },
	{ import = "astrocommunity.pack.yaml" },
	{ import = "astrocommunity/recipes/disable-tabline" },
	{ import = "astrocommunity.test.neotest" },
	{ import = "astrocommunity/utility/mason-tool-installer-nvim" },
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
				markdownlint = {},
				pyright = {},
				stylua = {},
			},
		},
	},
	{ import = "astrocommunity/workflow/hardtime-nvim" },
}
