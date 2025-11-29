require("telescope").setup({
	extensions = {
		file_browser = {
			hijack_netrw = true,
			mappings = {
				["i"] = {
				},
				["n"] = {
				},
			},
			hidden = true,
		},
	},
})

vim.keymap.set("n", "<leader>sb", ":Telescope file_browser<CR>", {
	desc = "File [B]rowser"
})

require("telescope").load_extension("file_browser")
