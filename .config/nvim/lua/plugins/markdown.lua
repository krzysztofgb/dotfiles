return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    keys = {
        {"<leader>ms", ":MarkdownPreview<CR>", desc = "[M]arkdown [S]tart", silent = true},
        {"<leader>mt", ":MarkdownPreviewStop<CR>", desc = "[M]arkdown [T]erminate", silent = true}
    }
}