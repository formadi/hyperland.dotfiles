
local mason_registry = require("mason-registry")
local codelldb       = mason_registry.get_package("codelldb")
local extension_path = codelldb:get_install_path() .. "/extension/"
local codelldb_path  = extension_path .. "adapter/codelldb"
local liblldb_path   = extension_path .. "lldb/lib/liblldb.dylib"
local dap            = require("dap")


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


dap.configurations.c = {
  {
    name          = "c Debugger",
    type          = "codelldb",
    request       = "launch",
    program       = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd           = '${workspaceFolder}',
    stopOnEntry   = false,
  }
}


dap.configurations.cpp = {
  {
    name          = "cpp Debugger",
    type          = "codelldb",
    request       = "launch",
    program       = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd           = '${workspaceFolder}',
    stopOnEntry   = false,
  }
}
