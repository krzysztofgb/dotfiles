---@type LazySpec
return {
	"goolord/alpha-nvim",
	opts = function(_, opts)
		opts.section.header.val = {
			[[__    __                             __]],
			[[|  \  |  \                           |  \]],
			[[| ▓▓\ | ▓▓ ______   ______  __     __ \▓▓______ ____]],
			[[| ▓▓▓\| ▓▓/      \ /      \|  \   /  \  \      \    \]],
			[[| ▓▓▓▓\ ▓▓  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\\▓▓\ /  ▓▓ ▓▓ ▓▓▓▓▓▓\▓▓▓▓\]],
			[[| ▓▓\▓▓ ▓▓ ▓▓    ▓▓ ▓▓  | ▓▓ \▓▓\  ▓▓| ▓▓ ▓▓ | ▓▓ | ▓▓]],
			[[| ▓▓ \▓▓▓▓ ▓▓▓▓▓▓▓▓ ▓▓__/ ▓▓  \▓▓ ▓▓ | ▓▓ ▓▓ | ▓▓ | ▓▓]],
			[[| ▓▓  \▓▓▓\▓▓     \\▓▓    ▓▓   \▓▓▓  | ▓▓ ▓▓ | ▓▓ | ▓▓]],
			[[ \▓▓   \▓▓ \▓▓▓▓▓▓▓ \▓▓▓▓▓▓     \▓    \▓▓\▓▓  \▓▓  \▓▓]],
			[[]],
			[[               Welcome back, Krzysztof!               ]],
		}
		table.insert(opts.section.buttons.val, opts.button("q", "󰅚  Quit Neovim", ":qa<CR>"))
	end,
	config = function(_, opts)
		require("alpha").setup(opts.config)
	end,
}
