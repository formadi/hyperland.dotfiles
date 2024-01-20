return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout    = true
    vim.o.timeoutlen = 500

    -- set keymaps..
    local wk = require("which-key")
    wk.register({
      ["<leader>"] = {
        w = {
          name = "Window",
          v = { "<C-w>v",             "sprit vertically"                     },
          h = { "<C-w>s",             "sprit horizontalliy"                  },
          e = { "<C-w>=",             "make  equal size"                     },
          x = { "<cmd>close<CR>",     "close cwd"                            },  -- exclusive main
          m = {
            name = "Move",
          },
          f = {
            name = "Focus",
          },
        },
        b = {
          name = "Buffer",
          c = { "<cmd>vnew<CR>",            "create new buffer"              },
          x = { "<cmd>bd<CR>",              "close buffer"                   },
          n = { "<cmd>bn<CR>",              "next buffer"                    },
          p = { "<cmd>bp<CR>",              "prev buffer"                    },
          b = { "<cmd>%bd | e# | bd#<CR>",  "close all but current"          },
        },
      },
    })
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    icons = {
      group = "",  -- eliminate +
    },
  },
}
