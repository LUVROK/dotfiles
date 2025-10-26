return {
  "rebelot/kanagawa.nvim",
  config = function()
    local kanagawa = require("kanagawa")
    kanagawa.setup({
      background = {
        dark = "dragon",
        light = "lotus",
      },
    })
    vim.cmd("colorscheme kanagawa")
  end,
}
