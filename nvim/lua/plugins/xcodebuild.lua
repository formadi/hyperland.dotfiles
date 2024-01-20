return {
  "wojciech-kulik/xcodebuild.nvim",
  event = "VeryLazy",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
  },


  config = function()
    local xb             = require("xcodebuild")
    local mason_registry = require("mason-registry")
    local codelldb       = mason_registry.get_package("codelldb")
    local extension_path = codelldb:get_install_path() .. "/extension/"
    local codelldb_path  = extension_path .. "adapter/codelldb"
    local liblldb_path   = extension_path .. "lldb/lib/liblldb.dylib"
    local dap            = require("dap")
    local xcodebuild     = require("xcodebuild.dap")

    dap.configurations.swift = {
      {
        name          = "macOS swift app Debugger",
        type          = "codelldb",
        request       = "launch", -- "attach",
        program       = xcodebuild.get_program_path,
        cwd           = "${workspaceFolder}",
        stopOnEntry   = false,
        waitFor       = true,
        runinTerminal = false,
      }
    }

    dap.configurations.objc = {
      {
        name          = "macOS objc app Debugger",
        type          = "codelldb",
        request       = "launch", -- "attach",
        program       = xcodebuild.get_program_path,
        cwd           = "${workspaceFolder}",
        stopOnEntry   = false,
        waitFor       = true,
        runinTerminal = false,
      }
    }


    dap.adapters.codelldb = {
      type       = "server",
      port       = "13000",
      host       = "127.0.0.1",
      executable = {
        command = codelldb_path,
        args    = {
          "--liblldb",
          liblldb_path,
          "--port",
          "13000"
        }
      }
    }

    xb.setup({
        -- put some options here or leave it empty to use default settings
        --
    })

    -- set keymaps
    local wk = require("which-key")
    wk.register({
      ["<leader>"] = {
        x = {
          name = "XcodeBuild",
          p = { "<cmd>XcodebuildPicker<CR>",                    "menu"             },
          d = { "<cmd>lua require('dap').continue()<CR>",       "debug"            },
          s = { "<cmd>XcodebuildSetup<CR>",                     "setup"            },
          b = { "<cmd>XcodebuildBuild<CR>",                     "build"            },
          r = { "<cmd>XcodebuildRun<CR>",                       "run"              },
          l = { "<cmd>XcodebuildSelectProject<CR>",             "select project"   },
          c = { "<cmd>XcodebuildShowConfig<CR>",                "show config"      },
        },
      },
    })
  end,
}
