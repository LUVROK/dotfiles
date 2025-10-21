return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  version = '^1.0.0',
  event = { "BufReadPre", "BufNewFile" },
  config = function ()
    require('barbar').setup({
      animation = false,
      auto_hide = 1,
      exclude_ft = { '' }, -- Hide empty buffers
      sidebar_filetypes = {
        ['neo-tree'] = {event = 'BufWipeout', text = "Explorer"}, -- TODO: for some reason doesnt work for now
      },
    })

    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
    map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)

    -- Close and pin
    map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
    map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)

    -- Pick mode (was <C-p>)
    map('n', '<A-P>', '<Cmd>BufferPick<CR>', opts)
    map('n', '<A-S-P>', '<Cmd>BufferPickDelete<CR>', opts) -- Alt+Shift+P

    -- Go to buffer by index
    map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
    map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
    map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
    map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
    map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
    map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
    map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
    map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
    map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
    map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

    -- Optional: close left/right buffer
    map('n', '<A-[>', '<Cmd>BufferCloseBuffersLeft<CR>', opts)
    map('n', '<A-]>', '<Cmd>BufferCloseBuffersRight<CR>', opts)
  end
}
