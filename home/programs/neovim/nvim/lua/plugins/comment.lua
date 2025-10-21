return {
  'numToStr/Comment.nvim',
  keys = {
    { '<C-/>', '<Plug>(comment_toggle_linewise_visual)',  mode = 'v', desc = 'Toggle comment (visual)',  silent = true },
  },
  config = function()
    require('Comment').setup({})
  end,
}
