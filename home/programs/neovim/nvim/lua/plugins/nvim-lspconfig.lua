return {
  "neovim/nvim-lspconfig",
event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    vim.diagnostic.config({
      float = { border = "rounded" },
    })
  end,
}
