-- -- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- -- optionally enable 24-bit colour
-- vim.opt.termguicolors = true

vim.o.guicursor = "n-v-c-sm:ver25,i-ci-ve:ver25,r-cr-o:ver25"

vim.keymap.set('n', '<C-c>', '"+y', { noremap = true })
vim.keymap.set('v', '<C-c>', '"+y', { noremap = true })
vim.keymap.set('n', '<C-v>', '"+p', { noremap = true })
vim.keymap.set('i', '<C-v>', '<C-r>+', { noremap = true })
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true })
vim.keymap.set('n', '<C-z>', 'u', { noremap = true })
vim.keymap.set('n', '<C-y>', '<C-r>', { noremap = true })
