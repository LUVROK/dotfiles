return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    { '<C-/>', '<Cmd>ToggleTerm direction=horizontal<CR>', mode = { 'n', 't' }, desc = 'Toggle terminal' },
  },
  config = function()
    require('toggleterm').setup({})
  end,
}
