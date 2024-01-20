return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  event = "VeryLazy",
  config = function()
    require("noice").setup({
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"]                = true,
          ["cmp.entry.get_documentation"]                  = true,
        },
        hover         = { enabled = true },
        signature     = { enabled = true },
        progress      = {
          enabled     = true,
          format      = "lsp_progress",
          format_done = "lsp_progress_done",
          throttle    = 1000 / 30, -- frequency to update lsp progress message
          view        = "mini",
        },
      },
      presets = {
        bottom_search         = false,  -- use a classic bottom cmdline for search
        command_palette       = false,  -- position the cmdline and popupmenu together
        long_message_to_split = true,   -- long messages will be sent to a split
        inc_rename            = false,  -- enables an input dialog for inc-rename.nvim
        lsp_doc_border        = true,   -- add a border to hover docs and signature help
      },

      messages = {
        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
        -- This is a current Neovim limitation.
        enabled      = true, -- enables the Noice messages UI
        view         = "notify", -- default view for messages
        view_error   = "notify", -- view for errors
        view_warn    = "notify", -- view for warnings
        view_history = "messages", -- view for :messages
        view_search  = "virtualtext", -- view for search count messages. Set to `false` to disable
      },

      commands = {
        history = {
          view = "popup",
        },
      },
    })

    vim.notify = require("notify")
    require("notify").setup({
      background_colour = "Normal",
      fps = 60,
      icons = {
        DEBUG = " ",
        ERROR = " ",
        INFO  = "􁊈 ",
        TRACE = "✎",
        WARN  = " ",
      },
      level         = 2, -- display level
      minimum_width = 50,
      maximum_width = 50,
      render        = "default",
      stages        = "slide",
      timeout       = 6000,
    })

    -- set keymaps
    local wk = require("which-key")
    wk.register({
      ["<leader>"] = {
        N = {
          name = "Noice",
        },
      },
    })

    vim.keymap.set("n", "<leader>Nl", function() require("noice").cmd("last")    end, { desc = "show last" })
    vim.keymap.set("n", "<leader>Nh", function() require("noice").cmd("history") end, { desc = "show history"})
  end,
}
