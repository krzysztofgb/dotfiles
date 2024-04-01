return {
	"folke/trouble.nvim",
	branch = "dev", -- IMPORTANT! (v3 is on dev currently)
	config = function()
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

		vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
		vim.keymap.set(
			"n",
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			{ desc = "Buffer Diagnostics (Trouble)" }
		)
		vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
		vim.keymap.set(
			"n",
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			{ desc = "LSP Definitions / references / ... (Trouble)" }
		)
		vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
		vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
	end,
}
