return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine     = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count
    -- local utils       = require("core.utils")

    local colors = {
      blue        = "#65D1FF",
      green       = "#3EFFDC",
      violet      = "#FF61EF",
      yellow      = "#FFDA7B",
      red         = "#FF4A4A",
      fg          = "#d6d9d4",
      bg          = "#11293d",
      inactive_bg = "#2c3843",
    }

    local function getWords()
      return tostring(vim.fn.wordcount().words) .. "w"
    end

    local function neorg_workspace()
      local neorg_module_dirman = require("neorg").modules.get_module("core.dirman")
      local ws                  = neorg_module_dirman.get_current_workspace()
      return "  " .. ws[1]
    end

    local function zen_mode()
      if _G.zen_toggle == true then
        return "󰹞"
      else
        return "󰹟"
      end
    end

    local custom_theme = {
      normal = {
        a = { bg = colors.blue,   fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg,     fg = colors.fg },
        c = { bg = colors.bg,     fg = colors.fg },
      },
      insert = {
        a = { bg = colors.green,  fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg,     fg = colors.fg },
        c = { bg = colors.bg,     fg = colors.fg },
      },
      visual = {
        a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg,     fg = colors.fg },
        c = { bg = colors.bg,     fg = colors.fg },
      },
      command = {
        a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg,     fg = colors.fg },
        c = { bg = colors.bg,     fg = colors.fg },
      },
      replace = {
        a = { bg = colors.red,    fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg,     fg = colors.fg },
        c = { bg = colors.bg,     fg = colors.fg },
      },
      inactive = {
        a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
        b = { bg = colors.inactive_bg, fg = colors.semilightgray },
        c = { bg = colors.inactive_bg, fg = colors.semilightgray },
      },
    }

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        theme = custom_theme,
        component_separators = '|',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = {
          { 'mode', separator = { left = '' }, right_padding = 2 },
        },
        lualine_b = { 'filename', 'branch' },
        lualine_c = {}, -- { 'fileformat', { unix =" " } },
        lualine_x = {
          -- { "aerial" },
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          -- { "encoding" },
          { "fileformat", symbols = { unix =" " } },
        },
        lualine_y = {}, -- { 'filetype', 'progress' },
        lualine_z = {
          { 'location', separator = { right = '' }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
      tabline = {
        lualine_a = {
          'function',
          function ()
            local current_bufnr = vim.fn.bufnr('%')
            local buf_list      = vim.fn.getbufinfo({buflisted = 1})
            local current_buffer_index
            for i, buf_info in ipairs(buf_list) do
                if buf_info.bufnr == current_bufnr then
                    current_buffer_index = i
                    break
                end
            end
            return current_buffer_index .. "/" .. #buf_list
          end
        },
        lualine_b = {
          {
            "buffers",
            max_length = vim.o.columns*0.5,
          },
        }, -- { "filename" },
        lualine_c = {
          -- {
          --   require("noice").api.status.message.get_hl,
          --   cond = require("noice").api.status.message.has,
          -- },
        },
        lualine_x = { { 'aerial', sep=' | ' } },
        lualine_y = { neorg_workspace, getWords, 'filetype' },
        lualine_z = { zen_mode, 'progress'}
      },
      extensions = {},
    })

    require('lualine').hide({
      place = {'tabline'},
      unhide = false,
    })
  end,
}
