return {
  "Selyss/mind.nvim",
  branch = 'v2.2',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, used for icons
  },

  config = function()
    require("mind").setup ({
      -- your configuration comes here
      persistence = {
        state_path = '/Volumes/Kali/minds/mind.json',
        data_dir   = '/Volumes/Kali/minds/data',
      },
      edit = {
        data_extension = '.norg',
      },
      ui = {
        width = 30,
      },
    })
  end,

  -- Hover actions
  vim.keymap.set("n", "<leader>om", "<cmd>MindOpenMain<CR>",              { desc = "open minds" })
}
