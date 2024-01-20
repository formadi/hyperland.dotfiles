
return {
  "tomasky/bookmarks.nvim",
  event = "VimEnter",
  config = function()
    require("bookmarks").setup ({
      sign_priority = 1000,

      on_attach = function(bufnr)
        local bm = require "bookmarks"
        local map = vim.keymap.set
        map("n", "<leader>mt", bm.bookmark_toggle, { desc = "toggle" } )          -- add or remove bookmark at current line
        map("n", "<leader>ma", bm.bookmark_ann,    { desc = "add"    } )          -- add or edit mark annotation at current line
        map("n", "<leader>mc", bm.bookmark_clean,  { desc = "clean"  } )          -- clean all marks in local buffer
        map("n", "<leader>mn", bm.bookmark_next,   { desc = "next"   } )          -- jump to next mark in local buffer
        map("n", "<leader>mp", bm.bookmark_prev,   { desc = "prev"   } )          -- jump to previous mark in local buffer
        map("n", "<leader>ml", bm.bookmark_list,   { desc = "list"   } )          -- show marked file list in quickfix window
      end
    })

    -- set keymaps
    local wk = require("which-key")
    wk.register({
      ["<leader>"] = {
        m = {
          name = "Bookmarks",
        },
      },
    })


  end,
}
