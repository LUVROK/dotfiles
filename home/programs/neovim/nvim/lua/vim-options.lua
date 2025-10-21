local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Tabs and indentation
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- UI and behavior
vim.g.have_nerd_font = false
vim.o.number = true
vim.o.mouse = 'a'
vim.o.showmode = false

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.background = "dark"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.opt.swapfile = false
vim.opt.fillchars:append({ eob = " " })
vim.opt.fillchars:append({ vert = " " })  -- заменяет линию на пробел
vim.opt.laststatus = 3                    -- чтобы статусбар был общий (красивее)

-- Undo / Redo в NORMAL режиме
map("n", "<C-z>", "u", { noremap = true, silent = true })
map("n", "<C-y>", "<C-r>", { noremap = true, silent = true })

-- Undo / Redo в INSERT режиме
map("i", "<C-z>", "<C-o>u", { noremap = true, silent = true })
map("i", "<C-y>", "<C-o><C-r>", { noremap = true, silent = true })

-- Window navigation
map('n', '<C-h>', '<C-w><C-h>', opts)
map('n', '<C-l>', '<C-w><C-l>', opts)
map('n', '<C-j>', '<C-w><C-j>', opts)
map('n', '<C-k>', '<C-w><C-k>', opts)

-- Clipboard
map({ "n", "x" }, "<C-c>", '"+y', opts)
map({ "n", "x" }, "<C-x>", '"+d', opts)
map({ "n", "x" }, "<C-v>", '"+p', opts)
map("i", "<C-v>", "<C-r>+", opts)

-- Buffers and tabs
map("n", "<C-t>", ":tabnew<CR>", opts)
map("n", "<C-w>", ":bd<CR>", opts)
map("n", "<A-Right>", ":bnext<CR>", opts)
map("n", "<A-Left>", ":bprevious<CR>", opts)

-- Search and diagnostics
map('n', '<Esc>', '<cmd>nohlsearch<CR>', opts)
map('n', '<leader>q', vim.diagnostic.setloclist, opts)

map({ "n", "i", "v" }, "<C-s>", function()
  vim.cmd("silent w")
end, opts)

