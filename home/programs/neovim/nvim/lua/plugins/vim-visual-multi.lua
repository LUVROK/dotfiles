return {
  'mg979/vim-visual-multi',
  branch = 'master',
  keys = {
    { '<C-d>', desc = 'Add multicursor (nextb match)' },
    -- { '<C-f>', desc = 'Skip match' },
    { '<C-x>', desc = 'Remove current cursor' },
    { '<C-up>', desc = 'Add cursor up' },
    { '<C-down>', desc = 'Add cursor down' },
  },
  init = function()
    vim.g.VM_default_mappings = 0
    vim.g.VM_maps = {
      ['Find Under'] = '<C-d>',          -- добавить курсор на следующее совпадение
      ['Find Subword Under'] = '<C-d>',  -- то же, но для выделения
      -- ['Skip Region'] = '<C-f>',         -- пропустить совпадение
      ['Remove Region'] = '<C-x>',       -- удалить текущий курсор
      ['Add Cursor Down'] = '<C-Down>',  -- добавить курсор ниже
      ['Add Cursor Up'] = '<C-Up>',      -- добавить курсор выше
    }
    vim.g.VM_theme = 'sand'
  end,
}
