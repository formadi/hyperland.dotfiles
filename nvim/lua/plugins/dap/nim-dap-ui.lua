return {
  "rcarriga/nvim-dap-ui",
  requires = { "mfussenegger/nvim-dap"},
  config = function()

    require("dapui").setup ()

      local dap = require("dap")
      local dapui = require("dapui")

      dap.listeners.after.event_initialized["depui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["depui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

    -- set keymaps..
    local wk = require("which-key")
    wk.register({
      ["<leader>"] = {
        d = {
          name = "DAP",
          x = { "<cmd>:DapTerminate<CR>"                        , "exit"              },
          c = { "<cmd>lua require'dap'.continue()<CR>"          , "continue"          },
          -- o = { "<cmd>lua require'dap'.step_over()<CR>"         , "step over"         },
          -- i = { "<cmd>lua require'dap'.step_into()<CR>"         , "step into"         },
          -- t = { "<cmd>lua require'dap'.step_out()<CR>"          , "step out"          },
          -- b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>" , "toggle breakpoint" },
        },
      },
    })
  end,
}
