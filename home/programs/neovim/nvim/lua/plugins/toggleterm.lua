return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    { '<C-S-/>', '<Cmd>ToggleTerm direction=horizontal<CR>', mode = { 'n', 't', 'i' }, desc = 'Toggle terminal' },
  },
  config = function()
    require('toggleterm').setup({})

    function _G.set_terminal_keymaps()
      local opts = { buffer = 0, noremap = true, silent = true }
      vim.keymap.set("t", "<C-BS>", [[<C-w>]], opts)
    end

    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
  end,
}
