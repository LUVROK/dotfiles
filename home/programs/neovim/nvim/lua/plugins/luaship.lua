return {
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  build = (vim.fn.has("win32") == 0 and vim.fn.executable("make")) and "make install_jsregexp" or nil,
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip").filetype_extend("c", { "cdoc" })
  end,
}
