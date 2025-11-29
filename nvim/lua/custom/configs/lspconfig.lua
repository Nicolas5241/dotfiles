vim.lsp.config('zls', {
	cmd = { "zls" },
	filetypes = { "zig", "zir", "zon" },
})

vim.lsp.enable("zls")
