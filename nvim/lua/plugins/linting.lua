return {
  "mfussenegger/nvim-lint",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript      = { "eslint_d" },
      typescript      = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte          = { "eslint_d" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    -- file save time lint..
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group    = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    -- live lint
    -- vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" }, {
    --   group = lint_augroup,
    --   callback = function()
    --     require("lint").try_lint()
    --   end,
    -- })


    -- set keymaps
    vim.keymap.set("n", "<leader>g", function() lint.try_lint() end, { desc = "trigger linting for current file" })
  end,
}
