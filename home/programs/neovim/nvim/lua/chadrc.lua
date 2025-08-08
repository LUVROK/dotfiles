-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "everforest",
    transparency = true,
	changed_themes = {
		everforest = {
			base_30 = {
				grey_fg = "#000"
			}
		},
		-- chocolate = {
		--   base_30 = {
		--     grey_fg = "#B0C4DE"
		--   }
		-- }
	},

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
--}

M.ui = {
  statusline = {
    theme = "default",
    separator_style = "round"
  }
}

return M
