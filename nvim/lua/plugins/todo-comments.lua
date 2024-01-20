return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup()

    -- keywords
    -- TODO , HACK, WARN, PREF, NOTE, TEST

    -- set keymaps
    vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "dind - todo (todo-comments)"})
  end,
}
