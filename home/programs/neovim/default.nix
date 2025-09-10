{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (plugins: with plugins; [
        tree-sitter-bash
        tree-sitter-nix
        tree-sitter-lua
        tree-sitter-vim
        tree-sitter-json
        tree-sitter-markdown
        tree-sitter-c
        tree-sitter-cpp
      ]))
      telescope-nvim
      telescope-fzf-native-nvim
      nvim-web-devicons
      plenary-nvim
      project-nvim
      oil-nvim
    ];

    extraPackages = with pkgs; [ 
      lua-language-server 
      nil 
      nodePackages.bash-language-server 
      nodePackages.prettier 
      gopls 
      pyright 
      clang 
    ];


    extraConfig = ''
      lua << EOF
      -- NvChad-like configuration

      -- Leader keys
      vim.g.mapleader = ' '
      vim.g.maplocalleader = ' '

      -- Options
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.mouse = 'a'
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.hlsearch = false
      vim.opt.wrap = false
      vim.opt.breakindent = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
      vim.opt.termguicolors = true
      vim.opt.guicursor = ""

      -- Lazy.nvim setup
      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
          "git",
          "clone",
          "--filter=blob:none",
          "https://github.com/folke/lazy.nvim.git",
          "--branch=stable", -- latest stable release
          lazypath,
        })
      end
      vim.opt.rtp:prepend(lazypath)

      -- Plugin setup
      require("lazy").setup({
        {
          "catppuccin/nvim",
          name = "catppuccin",
          priority = 1000,
          config = function()
            vim.cmd.colorscheme "catppuccin"
          end,
        },
        { "nvim-tree/nvim-tree.lua",            config = function() require("nvim-tree").setup() end },
        { "nvim-lualine/lualine.nvim",          config = function() require("lualine").setup() end },
        { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
        { "NvChad/nvim-colorizer.lua",          config = function() require("colorizer").setup() end },
        { "folke/which-key.nvim",               config = function() require("which-key").setup() end },
        { "lewis6991/gitsigns.nvim",            config = function() require("gitsigns").setup() end },
        { "windwp/nvim-autopairs",              config = function() require("nvim-autopairs").setup() end },
        { "numToStr/Comment.nvim",              config = function() require("Comment").setup() end },
        {
          "nvim-telescope/telescope.nvim",
          dependencies = { "nvim-lua/plenary.nvim" },
          config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
          end,
        },
        {
          "neovim/nvim-lspconfig",
          config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            lspconfig.lua_ls.setup({ capabilities = capabilities })
            lspconfig.nil_ls.setup({ capabilities = capabilities })
            lspconfig.bashls.setup({ capabilities = capabilities })
            lspconfig.gopls.setup({ capabilities = capabilities })
            lspconfig.pyright.setup({ capabilities = capabilities })
            lspconfig.clangd.setup({ capabilities = capabilities })
          end,
        },
        {
          "hrsh7th/nvim-cmp",
          dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline" },
          config = function()
            local cmp = require("cmp")
            cmp.setup({
              snippet = {
                expand = function(args)
                  -- no snippet engine
                end,
              },
              mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
              }),
              sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "buffer" },
              }),
            })
          end,
        },
        {
          "williamboman/mason.nvim",
          config = function() require("mason").setup() end,
        },
        {
          "williamboman/mason-lspconfig.nvim",
          config = function() require("mason-lspconfig").setup() end,
        },
        {
          "stevearc/conform.nvim",
          config = function()
            require("conform").setup({
              formatters_by_ft = {
                lua = { "stylua" },
                nix = { "nixpkgs-fmt" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                markdown = { "prettier" },
                go = { "gofmt" },
                python = { "black" },
                c = { "clang-format" },
                cpp = { "clang-format" },
              },
            })
          end,
        },
      })

      -- Keybindings
      local map = vim.keymap.set
      -- General
      map("n", "<Space>ch", ":Telescope help_tags<CR>")
      map("n", "<Space>th", ":Telescope themes<CR>")

      -- NvimTree
      map("n", "<C-n>", ":NvimTreeToggle<CR>")
      map("n", "<leader>e", ":NvimTreeToggle<CR>")

      -- Buffers
      map("n", "<S-l>", ":bnext<CR>")
      map("n", "<S-h>", ":bprevious<CR>")
      map("n", "<Space>x", ":bdelete<CR>")

      -- Telescope
      map("n", "<leader>ff", ":Telescope find_files<CR>")
      map("n", "<leader>fg", ":Telescope live_grep<CR>")
      map("n", "<leader>fb", ":Telescope buffers<CR>")
      map("n", "<leader>fh", ":Telescope help_tags<CR>")

      -- Formatting
      map("n", "<leader>fm", function()
        require("conform").format()
      end)

      EOF
    '';
  };
}