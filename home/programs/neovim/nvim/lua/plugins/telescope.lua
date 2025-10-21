return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { 
    "nvim-lua/plenary.nvim",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  keys = {
    { "<C-p>", function() require("telescope.builtin").find_files() end, desc = "Find files" },
    { "<leader>p", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
    { "<C-f>", function()
        require("telescope.builtin").current_buffer_fuzzy_find(
          require("telescope.themes").get_ivy({ previewer = false })
        )
      end,
      desc = "Fuzzy find in current buffer"
    },
  },
  config = function()
    require("telescope").setup({})
  end
}
