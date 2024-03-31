return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- adapters
		"nvim-neotest/neotest-plenary",
		"nvim-neotest/neotest-go",
		"nvim-neotest/neotest-python",
		"rcasia/neotest-java",
	},
	config = function()
		-- get neotest namespace (api call creates or returns namespace)
		local neotest_ns = vim.api.nvim_create_namespace("neotest")
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
					return message
				end,
			},
		}, neotest_ns)

		require("neotest").setup({
			adapters = {
				require("neotest-plenary"),
				require("neotest-go")({
					experimental = {
						test_table = true,
					},
					recursive_run = true,
					args = {
						"-count=1",
						"-race",
					},
				}),
				require("neotest-python")({
					dap = { justMyCode = false },
					args = {
						"--log-level",
						"DEBUG",
					},
					runner = "pytest",
					-- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
					-- instances for files containing a parametrize mark (default: false)
					pytest_discover_instances = true,
				}),
				require("neotest-java")({
					ignore_wrapper = false, -- whether to ignore maven/gradle wrapper
				}),
			},
			library = {
				plugins = {
					"neotest",
				},
				types = true,
			},
			quickfix = {
				open = function()
					if LazyVim.has("trouble.nvim") then
						require("trouble").open({ mode = "quickfix", focus = false })
					else
						vim.cmd("copen")
					end
				end,
			},
		})

		vim.keymap.set("n", "<leader>tt", function()
			require("neotest").run.run(vim.fn.expand("%"))
		end, { desc = "Run File" })
		vim.keymap.set("n", "<leader>tT", function()
			require("neotest").run.run(vim.uv.cwd())
		end, { desc = "Run All Test Files" })
		vim.keymap.set("n", "<leader>tr", function()
			require("neotest").run.run()
		end, { desc = "Run Nearest" })
		vim.keymap.set("n", "<leader>tl", function()
			require("neotest").run.run_last()
		end, { desc = "Run Last" })
		vim.keymap.set("n", "<leader>ts", function()
			require("neotest").summary.toggle()
		end, { desc = "Toggle Summary" })
		vim.keymap.set("n", "<leader>to", function()
			require("neotest").output.open({ enter = true, auto_close = true })
		end, { desc = "Show Output" })
		vim.keymap.set("n", "<leader>tO", function()
			require("neotest").output_panel.toggle()
		end, { desc = "Toggle Output Panel" })
		vim.keymap.set("n", "<leader>tS", function()
			require("neotest").run.stop()
		end, { desc = "Stop" })
		vim.keymap.set("n", "<leader>td", function()
			require("neotest").run.run({ strategy = "dap" })
		end, { desc = "Debug Nearest" })
	end,
}
