return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { '<C-n>', ':Neotree filesystem reveal left<CR>' },
    { '<leader>n', ':Neotree close<CR>' },
  },
  opts = {
    window = {
      position = "left",
      width = 40,
    },
    close_if_last_window = true,
    popup_border_style = "rounded",
    filesystem = {
      filtered_items = {
        visible = true,
        never_show = { ".git" },
      },
      window = {
        mappings = {
            ["u"] = "navigate_up",
            ["."] = "set_root",
        },
      },
      follow_current_file = { enabled = true },
      -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/998
      -- components = {
        -- icon = function(config, node, state)
          -- if node.type == 'file' or node.type == 'directory' then return {} end
          -- return require('neo-tree.sources.common.components').icon(config, node, state)
        -- end,
      -- },
    },
    default_component_configs = {
      git_status = {
        symbols = {
          added = "󰬈",
          modified = "󰬔",
          deleted = "󰬋",
          renamed = "󰬙",
          untracked = "󰬛",
          ignored = "󰬐",
          unstaged = "󰬜",
          staged = "󰬚",
          conflict = "󰬊",
        },
      },
    },
  },
}
