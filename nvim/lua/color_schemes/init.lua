
local color_schemes = {
  -- catppuccin
  {
    "catppuccin/nvim",
    name     = "catppuccin",
    setup    = true,
    lualine  = true,
    priority = 1000,
  },

  -- everforest
  {
    "neanias/everforest-nvim",
    name     = "everforest",
    setup    = true,
    lualine  = true,
    priority = 1000,
  },

  -- iceberg
  {
    "oahlen/iceberg.nvim",
    name     = "iceberg",
    setup    = false,
    lualine  = false,
    priority = 1000,
  },

  -- nord
  {
    "nordtheme/vim",
    name     = "nord",
    setup    = false,
    lualine  = true,
    priority = 1000,
  },

  -- vscode
  {
    "Mofiqul/vscode.nvim",
    name     = "vscode",
    setup    = true,
    lualine  = false,
    priority = 1000,
  },

  -- monochrome
  {
    "fxn/vim-monochrome",
    name     = "monochrome",
    setup    = false,
    lualine  = true,
    priority = 1000,
  },

  -- poimandres
  {
    "olivercederborg/poimandres.nvim",
    name     = "poimandres",
    setup    = true,
    lualine  = false,
    priority = 1000,
  },
}


-- set the selected color theme according to _G.color_scheme
_G.color_scheme = nil
for _, scheme in ipairs(color_schemes) do
  if scheme.name == _G.color_scheme_name then
    _G.color_scheme       = scheme
    _G.color_scheme.event = "VeryLazy"
    break
  end
end

return { _G.color_scheme }
