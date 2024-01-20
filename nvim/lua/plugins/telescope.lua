return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
          n = {
            ["q"] = require("telescope.actions").close,
          },
        },
        prompt_prefix      = "   ",
        selection_caret    = "  ",
        entry_prefix       = "  ",
        initial_mode       = "insert",
        selection_strategy = "reset",
        sorting_strategy   = "ascending",
        layout_strategy    = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width   = 0.55,
            results_width   = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width          = 0.87,
          height         = 0.80,
          preview_cutoff = 120,
        },
        file_sorter            = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns   = { "node_modules" },
        generic_sorter         = require("telescope.sorters").get_generic_fuzzy_sorter,
        winblend               = 0,
        border                 = {},
        borderchars            = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons         = true,
        set_env                = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer         = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer         = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer       = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      },
      extensions = {
        fzf = {
          fuzzy                   = true,
          override_generic_sorter = true,
          override_file_sorter    = true,
          case_mode               = "smart_case",
        },
      },
    })

    telescope.load_extension("fzf")

    local wk = require("which-key")
    wk.register({
      ["<leader>"] = {
        f = {
          name = "Telescope",
          f = { "<cmd>Telescope find_files<CR>",   "find - files in cwd"          },
          r = { "<cmd>Telescope oldfiles<CR>",     "find - recent files"          },
          w = { "<cmd>Telescope live_grep<CR>",    "find - string in cwd (Live Grep)"   },
          c = { "<cmd>Telescope grep_string<CR>",  "find - string under cursor in cwd"  },  -- exclusive main
        },
      },
    })
  end,
}
