return {
  "NvChad/nvim-colorizer.lua",
  event  = { "BufReadPre", "BufNewFile" },
  -- config = true,
  config = function()
    require('colorizer').setup ({
      user_default_options = {
        mode        = "virtualtext",
        virtualtext = "􀏄",
      },
    })
  end,

}
