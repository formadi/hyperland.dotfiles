return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  -- set keymaps
  vim.keymap.set("n", "<leader>l", "<cmd>LazyGit<CR>", { desc = "lazygit" })
}
