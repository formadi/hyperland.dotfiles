return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    -- set keymaps
    local wk = require("which-key")
    wk.register({
      ["<leader>"] = {
        h = {
          name = "Harpoon",
        },
      },
    })

    vim.keymap.set("n", "<leader>ha", function() harpoon:list():append()                      end, {desc = "append"})
    vim.keymap.set("n", "<leader>hr", function() harpoon:list():remove()                      end, {desc = "remove"})
    vim.keymap.set("n", "<leader>hc", function() harpoon:list():clear()                       end, {desc = "clear (remove all)"})
    vim.keymap.set("n", "<leader>hn", function() harpoon:list():next()                        end, {desc = "jump  next"})
    vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev()                        end, {desc = "jump  prev"})
    vim.keymap.set("n", "<leader>hq", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "show  quick   menu"})
  end,
}
