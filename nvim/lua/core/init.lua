require("core.keymaps")
require("core.options")

-- lazy & plugin
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

require("lazy").setup({
  { import = "plugins.dap"            },
  { import = "plugins"                },
  { import = "plugins.lsp"            },
  { import = "color_schemes"          },

  -- nvim 0.10.0 이상에서 사용가능 할때까지는 잠정적으로 사용을 중단한다.
  {
    -- install.. image.nvim
    "3rd/image.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
          require("nvim-treesitter.configs").setup({
            ensure_installed = { "markdown" },
            highlight = { enable = true },
          })
        end,
      },
    },
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled                     = true,
          clear_in_insert_mode        = false,
          download_remote_images      = true,
          only_render_image_at_cursor = false,
          filetypes                   = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
        },
        neorg = {
          enabled                     = true,
          clear_in_insert_mode        = false,
          download_remote_images      = true,
          only_render_image_at_cursor = false,
          filetypes                   = { "norg" },
        },
      },
      max_width                    = nil,
      max_height                   = nil,
      max_width_window_percentage  = nil,
      max_height_window_percentage = 70,
      kitty_method                 = "normal",
    },
  },
},

-- lazy configuration
{
  ui = {
    -- border =  { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		border = "single",
		-- window size 80%
    size = {
			width  = 0.8,
			height = 0.8,
		},
  },

  checker = {
    enabled = true,
    notify  = false,
  },
  change_detection = {
    notify = false,
  },
})


require("core.commands")
-- require("core.utils")
