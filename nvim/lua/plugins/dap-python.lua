return {
  "mfussenegger/nvim-dap-python",
  ft = "python",
  dependencies = {
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"

    require("dap-python").setup (path)

    -- set keymaps
    vim.keymap.set("n", "<leader>ds",  ":lua require('dap').continue()<CR>",                   { desc = "_python DAP start" })
    vim.keymap.set("n", "<leader>dr", ":lua require('dap-python').test_method()<CR>",          { desc = "debug python method" })
    vim.keymap.set("n", "<leader>dc", ":lua require('dap-python').test_class()<CR>",           { desc = "debug python class" })
    vim.keymap.set("v", "<leader>dp", "<ESC>:lua require('dap-python').debug_selection()<CR>", { desc = "debug python selection" })
  end,
}
