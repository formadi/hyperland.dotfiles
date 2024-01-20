
-- for image.nvim
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

-- catppuccin ,  everforest  , nord , iceberg , vscode , poimandres , monochrome
_G.color_scheme_name = "catppuccin"
_G.color_scheme      = nil
_G.zen_toggle        = false
_G.working_directory = vim.fn.getcwd()
_G.neotree_open      = false

require("core")


vim.g.python3_host_prog    = "home/elsa/.config/venv/bin/python3"
vim.g.loaded_perl_provider = 0



-- If you need to verify whether image.nvim is functioning correctly
-- ------------------------------------------------------------------
-- vim.opt.number = true
-- vim.opt.conceallevel = 2
-- vim.opt.winbar = "image.nvim demo"
-- vim.opt.signcolumn = "yes:2"
-- local content = [[
-- # Hello World
--
-- ![This is a remote image](https://gist.ro/s/remote.png)
-- ]]
--
-- vim.schedule(function()
--   local buf = vim.api.nvim_create_buf(false, true)
--   vim.api.nvim_buf_set_lines(buf, 0, -1, true, vim.split(content, "\n"))
--   vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
--   vim.api.nvim_set_current_buf(buf)
--   vim.cmd("split")
-- end)


-- auto execute Neotree at nvim start
-- vim.cmd('autocmd VimEnter * Neotree')
