{ pkgs, ... }:

with pkgs;
let
  luaPlugin = pkg: {
    type = "lua";
    plugin = pkg;
  };
in 
{
  # home.file.".config/nvim" = {
  #   source = (pkgs.callPackage ./nvchad.nix {}).nvchad;
  #   # This copies the files, making them writable
  # };

  # home.file.".config/nvim/init.lua" = {
  #   text = ''
      
  #   '';
  # };

  programs.vim = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaConfig = builtins.readFile ./plugins/lua/config.lua;

    plugins = with pkgs.vimPlugins; [
      # --------------------------------------------------------------------------------
      # General
      # --------------------------------------------------------------------------------

      {
        plugin = nvim-web-devicons;
        type = "lua";
        config =
          ''
            require("nvim-web-devicons").setup({
              color_icons = true,
              default = true,
              strict = false,

              override_by_filename = {
                [".gitignore"] = {
                  icon = "",
                  color = "#f1502f",
                  name = "Gitignore",
                },
              },

              override_by_extension = {
                ["log"] = {
                  icon = "",
                  color = "#81e043",
                  name = "Log",
                },
              },

              override = {
                zsh = {
                    icon = "",
                    color = "#428850",
                    cterm_color = "65",
                    name = "Zsh",
                },
                rs = {
                    icon = "󱘗",
                    color = "#C58C6E",
                    cterm_color = "65",
                    name = "Rust",
                },
                go = {
                    icon = "󰟓",
                    color = "#0034BA",
                    cterm_color = "65",
                    name = "Go",
                },
              },
            })
          '';
      }

      {
        plugin = nvim-tree-lua;
        type = "lua";
        config =
          ''
            local function natural_cmp(left, right)
            -- Directories before files
            if left.type == "directory" and right.type ~= "directory" then
              return true
            elseif left.type ~= "directory" and right.type == "directory" then
              return false
            end

            left = left.name:lower()
            right = right.name:lower()

            if left == right then
              return false
            end

            for i = 1, math.max(string.len(left), string.len(right)), 1 do
              local l = string.sub(left, i, -1)
              local r = string.sub(right, i, -1)

              if type(tonumber(string.sub(l, 1, 1))) == "number" and type(tonumber(string.sub(r, 1, 1))) == "number" then
                local l_number = tonumber(string.match(l, "^[0-9]+"))
                local r_number = tonumber(string.match(r, "^[0-9]+"))

                if l_number ~= r_number then
                  return l_number < r_number
                end
              elseif string.sub(l, 1, 1) ~= string.sub(r, 1, 1) then
                return l < r
              end
            end
          end

          require("nvim-tree").setup {
            view = {
              width = 45,
            },
            trash = {
              cmd = "rm -rf",
            },
            renderer = {
              add_trailing = true,
              group_empty = false,
            },
            update_focused_file = {
              enable = true,
            },
            sort_by = function(nodes)
              table.sort(nodes, natural_cmp)
            end,
            filters = {
              git_ignored = false,
            },
          }

          vim.keymap.set('n', '<S-T>', function()
            require("nvim-tree.api").tree.toggle {
              find_file = true,
            }
          end, {})
        '';
      }

      # --------------------------------------------------------------------------------
      # Languages
      # --------------------------------------------------------------------------------

      (luaPlugin nvim-treesitter-parsers.bash)
      (luaPlugin nvim-treesitter-parsers.c)
      (luaPlugin nvim-treesitter-parsers.comment)
      (luaPlugin nvim-treesitter-parsers.cpp)
      (luaPlugin nvim-treesitter-parsers.diff)
      (luaPlugin nvim-treesitter-parsers.git_config)
      (luaPlugin nvim-treesitter-parsers.git_rebase)
      (luaPlugin nvim-treesitter-parsers.gitattributes)
      (luaPlugin nvim-treesitter-parsers.gitignore)
      (luaPlugin nvim-treesitter-parsers.go)
      (luaPlugin nvim-treesitter-parsers.gomod)
      (luaPlugin nvim-treesitter-parsers.gosum)
      (luaPlugin nvim-treesitter-parsers.gowork)
      (luaPlugin nvim-treesitter-parsers.html)
      (luaPlugin nvim-treesitter-parsers.kotlin)
      (luaPlugin nvim-treesitter-parsers.javascript)
      (luaPlugin nvim-treesitter-parsers.javascript)
      (luaPlugin nvim-treesitter-parsers.json)
      (luaPlugin nvim-treesitter-parsers.json5)
      (luaPlugin nvim-treesitter-parsers.lua)
      (luaPlugin nvim-treesitter-parsers.markdown)
      (luaPlugin nvim-treesitter-parsers.nix)
      (luaPlugin nvim-treesitter-parsers.ocaml)
      (luaPlugin nvim-treesitter-parsers.proto)
      (luaPlugin nvim-treesitter-parsers.python)
      (luaPlugin nvim-treesitter-parsers.sql)
      (luaPlugin nvim-treesitter-parsers.templ)
      (luaPlugin nvim-treesitter-parsers.terraform)
      (luaPlugin nvim-treesitter-parsers.tsx)
      (luaPlugin nvim-treesitter-parsers.vim)
      (luaPlugin nvim-treesitter-parsers.vimdoc)
      (luaPlugin nvim-treesitter-parsers.xml)
      (luaPlugin nvim-treesitter-parsers.yaml)

      {
        type = "lua";
        plugin = nvim-treesitter;
        config = ''
          require('nvim-treesitter.configs').setup({
            highlight = {
              enable = true,
              additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            matchup = { enable = true },
          })

          vim.filetype.add({
            extension = {
              templ = 'templ',
            },
          })
        '';
      }
      neoterm

      # javasctipt

      # Nix
      vim-nix

      # --------------------------------------------------------------------------------
      # Colorschemes
      # --------------------------------------------------------------------------------

      {
        plugin = gruvbox-nvim;
        type = "lua";
        config = ''
          require("gruvbox").setup{}
          vim.cmd[[colorscheme gruvbox]]
          vim.api.nvim_set_hl(0, "Normal", { bg = "#171717" })
        '';
      }
    ];
  };
}
