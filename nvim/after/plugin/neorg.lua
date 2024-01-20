
-- change neorg's workspace to main
-- -------------------------------------------------------------------------
local function change_ws_to_main ()
  vim.api.nvim_command("Neorg workspace main")
end


-- debug...
vim.keymap.set("n", "<Leader>nx", function()
  local all_buffers = vim.api.nvim_list_bufs()
  print("number of buffers in current window : ", #all_buffers)
end, { desc = "debug", noremap = true, silent = true })



-- keymaps... Neorg > journal > today
-- ---------------------------------------------------------------------------
vim.keymap.set("n", "<Leader>njt", function()
  local neorg_module_dirman = require("neorg").modules.get_module("core.dirman")
  local ws                  = neorg_module_dirman.get_current_workspace()

  if ws[1] ~= "main" then change_ws_to_main() end
  vim.api.nvim_command("Neorg journal today")
end, { desc = "journal today", noremap = true, silent = true })


-- keymap... Neorg > journal > yesterday
-- ---------------------------------------------------------------------------
vim.keymap.set("n", "<Leader>njy", function()
  local neorg_module_dirman = require("neorg").modules.get_module("core.dirman")
  local ws                  = neorg_module_dirman.get_current_workspace()

  if ws[1] ~= "main" then change_ws_to_main() end
  vim.api.nvim_command("Neorg journal yesterday")
end, { desc = "journal yesterday", noremap = true, silent = true })


-- keymap... Neorg > journal > tomorrow
-- ---------------------------------------------------------------------------
vim.keymap.set("n", "<Leader>njn", function()
  local neorg_module_dirman = require("neorg").modules.get_module("core.dirman")
  local ws                  = neorg_module_dirman.get_current_workspace()

  if ws[1] ~= "main" then change_ws_to_main() end
  vim.api.nvim_command("Neorg journal tomorrow")
end, { desc = "journal tommorow", noremap = true, silent = true })




-- keymap.. Noerg > concealer
-- ---------------------------------------------------------------------------
vim.keymap.set("n", "<Leader>nc", function()
  if vim.wo.conceallevel == 2 then
    vim.wo.concealcursor = ""
    vim.wo.conceallevel  = 0
  else
    vim.wo.concealcursor = "n"
    vim.wo.conceallevel  = 2
  end

  vim.api.nvim_command("Neorg toggle-concealer")
end, { desc = "journal tommorow", noremap = true, silent = true })



-- keymap.. Noerg > workspace
-- ---------------------------------------------------------------------------
vim.keymap.set("n", "<Leader>nw", function()
  function table.readdir(directory)
    local function explore(dir)
      local entries = vim.fn.readdir(dir)
      local result = {}

      for _, entry in ipairs(entries) do
        local full_path = dir .. '/' .. entry
        if vim.fn.isdirectory(full_path) == 1 then
          table.insert(result, full_path)
          -- 재귀적으로 디렉토리 탐색
          local subdirectories = explore(full_path)
          for _, subdirectory in ipairs(subdirectories) do
            table.insert(result, subdirectory)
          end
        end
      end
      return result
    end

    local full_directory = vim.fn.expand(directory)
    local directories    = explore(full_directory)
    -- remove up directory
    local base_length = #full_directory + 1
    for i, dir in ipairs(directories) do
      directories[i] = string.sub(dir, base_length)
    end
    -- change '/' to space in directiory name
    for i, dir in ipairs(directories) do
      directories[i] = dir:gsub("^/", " ")
    end
    -- add " main"
    table.insert(directories, 1, ' main')
    -- check current workspace
    local neorg_module_dirman = require("neorg").modules.get_module("core.dirman")
    local current_ws_table    = neorg_module_dirman.get_current_workspace()
    local current_ws          = current_ws_table[1]  -- table의 인텓스는 1부터 임.
    local ws                  = " " .. current_ws
    -- remove current workspace
    for i = #directories, 1, -1 do
      if directories[i] == ws then
        table.remove(directories, i)
      end
    end
    return directories
  end


  -- show workspace selection window
  -- ---------------------------------------------------------------------------
  local function show_directory_selector(directories)
    local lines = vim.fn.map(directories, 'v:val')
    local bufnr = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    local current_win = vim.fn.winnr()
    local win_width   = vim.fn.winwidth(current_win)
    local win_height  = vim.fn.winheight(current_win)
    -- position : current buffer's center
    local row = (win_height - #lines) / 2
    local col = (win_width - 30) / 2  -- 30은 창의 너비

    local neorg_module_dirman = require("neorg").modules.get_module("core.dirman")
    local current_ws_table    = neorg_module_dirman.get_current_workspace()
    local current_ws          = current_ws_table[1]

    local win_id = vim.api.nvim_open_win(bufnr, true, {
      -- setup window option
      relative = 'win',
      row      = row,
      col      = col,
      width    = 30,
      height   = #lines + 2,
      style    = 'minimal',
      border   = 'single',
      title    = " Select a workspace : " .. current_ws .. " "
    })

    -- activate cursorline
    vim.api.nvim_set_option_value( 'cursorline', true, {win = win_id} )
    local selected_directory = nil

    local function on_select()
      vim.api.nvim_win_close(win_id, true)  -- workspace 선택 창을 닫는다 .
      vim.api.nvim_command("Neorg workspace" .. selected_directory)
    end

    -- keymap <CR> : selection
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<CR>', ':lua _G.on_select()<CR>', { noremap = true, silent = true })
    -- keymap q : quit window
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', ':lua _G.on_quit()<CR>', { noremap = true, silent = true })

    _G.on_select = function()
      local selected_line = tonumber(vim.fn.line('.'))
      selected_directory = directories[selected_line]
      on_select()  -- call local function on_select()
    end

    _G.on_quit = function()
      vim.api.nvim_win_close(win_id, true)
    end
  end

  local result = table.readdir('/Volumes/Kali/neorg')
  show_directory_selector(result)

end, { desc = "change workspace", noremap = true, silent = true })



-- --------------------------------------------------------------------------------------------
function Norg_auto_indexing()
  -- async sleep
  local function sleep(ms, callback)
    vim.fn.timer_start(ms, function()
      callback()
    end)
  end

  vim.api.nvim_out_write("index.norg is opened.")

  local line_count         = vim.fn.line("$")
  local target_pattern     = "* Index"
  local target_line_number = nil
  local start_index        = 0

  for i = 1, line_count do
    local line_content = vim.fn.getline(i)
    local found_start  = string.find(tostring(line_content), target_pattern)
    if found_start then
      start_index        = found_start
      target_line_number = i
      break
    end
  end

  if target_line_number then
    print("해당 문자열이 포함된 라인:", target_line_number)
    vim.api.nvim_win_set_cursor(0, {target_line_number, start_index - 1})

    if line_count > target_line_number then
      -- down.
      vim.cmd('normal! j')
      -- change Visul Mode & select to buffer's end
      vim.cmd('normal! VG')
      -- delete selections
      vim.cmd('normal! d')
    end
    vim.cmd("Neorg generate-workspace-summary")
  -- not include "* Index"
  else
    print("해당 문자열이 포함된 라인이 없습니다.")
    -- move to line 9
    vim.api.nvim_win_set_cursor(0, {9, 0})
    -- insert a blank line
    vim.api.nvim_buf_set_lines(0, 9, 9, false, {''})
    -- delete all line from current to ens of the buffer
    vim.cmd('normal! j')
    vim.cmd('normal! VG')
    vim.cmd('normal! d')

    -- insert a blank line
    vim.api.nvim_buf_set_lines(0, line_count, line_count, false, {''})
    -- add "* Index" heading title
    vim.api.nvim_buf_set_lines(0, line_count + 1, line_count + 1, false, {'* Index'})
    -- move to Index & change to Normal mode
    vim.api.nvim_command('normal! Gk')

    vim.api.nvim_command("Neorg generate-workspace-summary")
  end

  -- save buffer after 200ms
  sleep(200, function()
    vim.cmd("w")
  end)

  -- remove all lines containing [index]
  line_count     = vim.fn.line("$")
  target_pattern = "%[Index%]"
  for i = line_count, 1, -1 do
    local line_content = vim.fn.getline(i)
    local index_start = string.find(tostring(line_content), target_pattern)
    if index_start then
      vim.api.nvim_buf_set_lines(0, i-1, i, false, {})
    end
  end
end


-- ------------------------------------------------------------------------
vim.cmd [[
augroup norg_auto_indexing
  autocmd!
  autocmd BufRead  index.norg lua Norg_auto_indexing()
augroup END
]]



-- if the file extension is .norg, number is hidden
-- -----------------------------------------------------------------------
function ShouldHideLineNumber()
  local file_extension = vim.fn.expand("%:e")
  return file_extension == "norg"
end

function ToggleLineNumber()
  if vim.bo.filetype == 'norg' then
    vim.wo.number = false
  else
    vim.wo.number = true
  end
end

vim.cmd(
  [[
  augroup HideLineNumber
    autocmd!
    autocmd BufReadPost * lua ToggleLineNumber()
  augroup END
  ]],
  false
)
