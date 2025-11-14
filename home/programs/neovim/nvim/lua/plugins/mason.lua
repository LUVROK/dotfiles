return {
  "mason-org/mason.nvim",
  cmd = "Mason",
  opts = {
    ui = {
      border = "rounded",
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  },
  build = function()
    pcall(function()
      vim.cmd("MasonUpdate")
    end)
  end,
}
