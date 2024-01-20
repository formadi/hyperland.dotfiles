return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local lspconfig    = require("lspconfig")
    local util         = require("lspconfig.util")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap       = vim.keymap -- for conciseness
    local opts         = { noremap = true, silent = true }

    local on_attach = function(client, bufnr)

      opts.buffer = bufnr

      -- set keybinds
      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)               -- show definition, references

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)                           -- go to declaration

      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)                          -- jump to previous diagnostic in buffer

      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts)                          -- jump to next diagnostic in buffer

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts)                                  -- show documentation for what is under cursor

      opts.desc = "Show LSP definitions"
      keymap.set("n", "<leader>rd", "<cmd>Telescope lsp_definitions<CR>", opts)      -- show lsp definitions

      opts.desc = "Show LSP implementations"
      keymap.set("n", "<leader>ri", "<cmd>Telescope lsp_implementations<CR>", opts)  -- show lsp implementations

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "<leader>rt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>rc", vim.lsp.buf.code_action, opts)          -- see available code actions, in visual mode will apply to selection

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)                        -- smart rename

      opts.desc = "show buffer diagnostics"
      keymap.set("n", "<leader>rD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)  -- show  diagnostics for file

      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>rf", vim.diagnostic.open_float, opts)                 -- show diagnostics for line

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)                         -- mapping to restart lsp if necessary
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = "⬤", Warn = "⬤", Hint = "⬤", Info = "⬤" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = "" })
    -- vim.fn.sign_define("DiagnosticSignError", {text = " ", texthl = "DiagnosticSignError"})
    end

    -- configure html server
    -- lspconfig["html"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })

    -- configure typescript server with plugin
    -- lspconfig["tsserver"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })

    -- configure css server
    -- lspconfig["cssls"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })

    -- configure tailwindcss server
    -- lspconfig["tailwindcss"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })

    -- configure svelte server
    -- lspconfig["svelte"].setup({
    --   capabilities = capabilities,
    --   on_attach = function(client, bufnr)
    --     on_attach(client, bufnr)
    --
    --     vim.api.nvim_create_autocmd("BufWritePost", {
    --       pattern = { "*.js", "*.ts" },
    --       callback = function(ctx)
    --         if client.name == "svelte" then
    --           client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
    --         end
    --       end,
    --     })
    --   end,
    -- })

    -- configure prisma orm server
    -- lspconfig["prismals"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })

    -- configure graphql language server
    -- lspconfig["graphql"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    --   filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    -- })

    -- configure emmet language server
    -- lspconfig["emmet_ls"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    --   filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    -- })

    -- for python ruff
    -- configure python server
    lspconfig.ruff_lsp.setup({
      capabilities = capabilities,
      on_attach = on_attach, -- function (_, bufnr)
        -- set keymaps
      --   local wk = require("which-key")
      --   wk.register({
      --     ["<leader>"] = {
      --       r = {
      --         name = "Ruff",
      --       },
      --     },
      --   })
      --
      --   vim.keymap.set('n', '<space>re', vim.diagnostic.open_float,           { desc = "diagnostic float",        noremap=true, silent=true, buffer=bufnr } )
      --   vim.keymap.set('n', '<space>rq', vim.diagnostic.setloclist,           { desc = "diagnostic setloclist",   noremap=true, silent=true, buffer=bufnr } )
      --   vim.keymap.set('n', '<space>ra', vim.lsp.buf.add_workspace_folder,    { desc = "add workspace folder",    noremap=true, silent=true, buffer=bufnr } )
      --   vim.keymap.set('n', '<space>rr', vim.lsp.buf.remove_workspace_folder, { desc = "remove workspace folder", noremap=true, silent=true, buffer=bufnr } )
      --   vim.keymap.set('n', '<space>rd', vim.lsp.buf.type_definition,         { desc = "type definition",         noremap=true, silent=true, buffer=bufnr } )
      --   vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename,                  { desc = "rename",                  noremap=true, silent=true, buffer=bufnr } )
      --   vim.keymap.set('n', '<space>rc', vim.lsp.buf.code_action,             { desc = "code action",             noremap=true, silent=true, buffer=bufnr } )
      -- end,-- on_attach,
      init_options = {
        settings = {
          args = {
            "--config=~/.ruff.toml",
            "--fix",
          },
        }
      }
    })

    -- configure sourcekit lsp for swift
    lspconfig["sourcekit"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = { "/usr/bin/sourcekit-lsp" },
    })

    -- configure clangd server ,, c/c++ -> sourcekit
    -- lspconfig["clangd"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })

    -- configure lua server (with special settings)
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
  end,
}
