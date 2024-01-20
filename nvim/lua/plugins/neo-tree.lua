local function hide_cursor(on_off)
  local hl = vim.api.nvim_get_hl(0,{name = 'Cursor'})
  if on_off == true then
    hl.blend = 100  -- hide
  else
    hl.blend = 0    -- show
  end
  vim.api.nvim_set_hl(0, 'Cursor', hl)
  vim.opt.guicursor:append('a:Cursor/lCursor')
end

-- -------------------------------------------------------------------------------------

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "main",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  init = function()
    vim.g.neo_tree_remove_legacy_commands = true
  end,
  config = function()
    require("neo-tree").setup({
      event_handlers = {
        -- neo_tree_popup_buffer_enter
        --neo_tree_window_after_open
        {
          event = "neo_tree_window_after_open",
          handler = function()
            -- hide_cursor(true)
            vim.cmd("setlocal nonumber")
            _G.neotree_open = true
          end
        },
        {
          event = "neo_tree_window_before_close",
          handler = function()
            _G.neotree_open = false
            -- hide_cursor(false)
          end
        },
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            -- hide_cursor(true)
            vim.cmd("setlocal nonumber")
            vim.cmd('normal! <C-r>')
          end
        },
        -- {
        --   event = "vim_buffer_added",
        --   handler = function()
        --     hide_cursor(false)
        --   end
        -- },
        -- {
        --   event = "neo_tree_buffer_leave",
        --   handler = function()
        --     hide_cursor(false)
        --   end
        -- },
        -- {
        --   event = "neo_tree_popup_buffer_enter",
        --   handler = function()
        --     hide_cursor(false)
        --   end
        -- },
        -- {
        --   event = "neo_tree_popup_buffer_leave",
        --   handler = function()
        --     hide_cursor(true)
        --   end
        -- },
      },

      default_component_configs = {
        modified = {
          symbol = "󰙏 ", --  ", -- 􀒋 ",
        },
      },

      filesystem = {
        filtered_items = {
          visible           = true,
          show_hidden_count = true,
          hide_dotfiles     = false,
          hide_gitignored   = true,
          never_show = {
            ".git",
            ".github",
            ".DS_Store",
            "thumbs.db",
          },
          never_show_by_pattern = {
            "*lock*",
          }
        },
      },

      window = {
        position = "left",      -- default mode
        popup = {               -- settings that apply to float position only
          size = { height = "25", width = "60" },
          position = "50%",     -- 50% means center it
        },
      },
    })

    -- set keymaps
    local wk = require("which-key")
    wk.register({
      ["<leader>"] = {
        e = {
          name = "Neotree",
          f = { "<cmd>Neotree float<CR>",  "float"  },
          l = { "<cmd>Neotree left<CR>",   "left"   },
          r = { "<cmd>Neotree right<CR>",  "right"  },
          e = { "<cmd>Neotree focus<CR>",  "focus"  },
          t = { "<cmd>Neotree toggle<CR>", "toggle" },
        },
      },
    })

    vim.keymap.set('n', '<leader>eb', function()
      local reveal_file = vim.fn.expand('%:p')
      if (reveal_file == '') then
        reveal_file = vim.fn.getcwd()
      else
        local f = io.open(tostring(reveal_file), "r")
        if (f) then
          f.close(f)
        else
          reveal_file = vim.fn.getcwd()
        end
      end
      require('neo-tree.command').execute({
        action           = "focus",          -- OPTIONAL, this is the default value
        source           = "filesystem",     -- OPTIONAL, this is the default value
        position         = "left",           -- OPTIONAL, this is the default value
        reveal_file      = reveal_file,      -- path to file or folder to reveal
        reveal_force_cwd = true,             -- change cwd without asking if needed
      })
    end,
    {desc = "buffer's directory"})

    vim.keymap.set('n', '<leader>ew', function()
      local command = "Neotree dir=" .. _G.working_directory
      vim.api.nvim_command(command)
    end,
    {desc = "working directory"})

    -- customize highlight color
    vim.cmd([[ hi NeoTreeDotfile  guifg=#808080 ]])
  end,
}
