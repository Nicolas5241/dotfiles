vim.keymap.set("n", "<leader>dd", "<cmd> lua vim.diagnostic.open_float() <CR>", {desc = "Floating diagnostic"})
vim.keymap.set("n", "<leader>ds", "<cmd> lua vim.lsp.buf.hover() <CR>", {desc = "Floating documentation"})

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-n>', '<C-w><C-n>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-i>', '<C-w><C-i>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-e>', '<C-w><C-e>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-u>', '<C-w><C-u>', { desc = 'Move focus to the upper window' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
