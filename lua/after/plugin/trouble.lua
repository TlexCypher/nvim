require("trouble").setup()
vim.keymap.set("n", "<leader>tx", "<cmd>Trouble diagnostics toggle win.position=right<cr>",
    { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>tX", "<cmd>Trouble diagnostics toggle filter.buf=0 win.position=right<cr>",
    { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    { desc = "LSP Definitions / references" })
vim.keymap.set("n", "<leader>tL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>tQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List" })
