return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },

        border = "single",
        size = {
          width  = 0.8,
          height = 0.8,
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "tsserver",
        -- "html",
        -- "cssls",
        -- "tailwindcss",
        -- "svelte",
        "lua_ls",
        -- "codelldb",
        -- "prettierd",
        -- "clangd",
        "rust_analyzer",
        -- "graphql",
        -- "emmet_ls",
        -- "prismals",
        -- "debugpy",
        "ruff_lsp",
        -- "ruff",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        --"stylua", -- lua formatter
        --"isort",  -- python formatter
        --"black",  -- python formatter
        "codelldb",
        "ruff_lsp", -- python lsp
        "ruff",     -- python linter
        "debugpy",  -- python DAP
        "eslint_d", -- js linter
      },
    })
  end,
}
