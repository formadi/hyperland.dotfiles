return {
  "nvim-pack/nvim-spectre",
  config = function()
    require("spectre").setup ({

    })

    local wk = require("which-key")
    wk.register({
      ["<leader>"] = {
        s = {
          name = "Search",
          s = { "<cmd>Spectre<CR>",       "Spectre search"     },
        },
      },
    })
  end,
}
