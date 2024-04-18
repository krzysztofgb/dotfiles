---@type LazySpec
return {
	"andweeb/presence.nvim",
	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",
	-- Game to practice vim motions
	"ThePrimeagen/vim-be-good",
	-- Cool animations
	"eandrju/cellular-automaton.nvim",
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").setup()
		end,
	},
	{
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		config = function()
			vim.keymap.set("n", "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>")
			vim.keymap.set("n", "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>")
			vim.keymap.set("n", "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>")
			vim.keymap.set("n", "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>")
			vim.keymap.set("n", "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>")
		end,
	},
}
