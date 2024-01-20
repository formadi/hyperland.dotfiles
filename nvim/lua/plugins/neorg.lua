return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  run = ":Neorg sync-parsers",
  dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-neorg/neorg-telescope" } },
  config = function()
    require("neorg").setup ({
      load = {
        ["core.defaults"]    = {}, -- Loads default behaviour
        ["core.integrations.telescope"] = {},
        ["core.ui"]          = {},
        ["core.syntax"]      = {},
				-- ["core.ui.calendar"] = {},
        ["core.keybinds"]    = {},
        ["core.concealer"]   = { -- Adds pretty icons to your documents
          config = {
            icons = {
              code_block = {
                conceal = true
              },
            },
          },
        },
        ['core.journal']     = {
          config = {
            -- workspace = "journal",
            strategy  = "flat",
          },
        },
        ['core.esupports.metagen'] = {
          config = {
            type = "auto", -- generates metadata if it is not present
          },
        },
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              main    = "/Volumes/Kali/neorg",
              journal = "/Volumes/Kali/neorg/journal",
              notes   = "/Volumes/Kali/neorg/notes",
              rust    = "/Volumes/Kali/neorg/rust",
              blog    = "/Volumes/Kali/neorg/blog"
            },
            default_workspace = "main",
          },
        },
        ["core.esupports.indent"] = {
          config = {
            formet_on_enter = false,
            format_on_escape = false,
          },
        },
        ["core.summary"] = {
          config = {
            strategy = "default",
          },
        },
        ["core.integrations.treesitter"] = {},
      },
    })

    -- set keymaps..
    local wk = require("which-key")
    wk.register({
      ["<leader>"] = {
        n = {
          name = "Neorg",
          p = { "<cmd>Neorg<CR>",                                                    "show popup-menu"     },
          -- c = { "<cmd>Neorg toggle-concealer<CR>",                                   "toggle concealer"    },
          i = { "<cmd>Neorg index<CR>",                                              "show index"          },
          l = { "<cmd>Neorg keybind all core.looking-glass.magnify-code-block<CR>",  "run looking-glass"   },
          n = { "<cmd>Neorg keybind all core.dirman.new.note<CR>",                   "create new note"     },
          d = { "<cmd>Neorg keybind all core.tempus.insert-date-insert-mode<CR>",    "insert date"         },
          t = { "<cmd>Neorg toc<CR>",                                                "show toc"            },
          s = {
            name = "Search",
            l = { "<cmd>Neorg keybind all core.integrations.telescope.find_linkable<CR>",   "linkable"  },
            f = { "<cmd>Neorg keybind all core.integrations.telescope.find_norg_files<CR>", "files"     },
            h = { "<cmd>Neorg keybind all core.integrations.telescope.find_headings<CR>",   "headings"  },
            -- f = { "<cmd>Neorg keybind all core.integrations.telescope.find_headings<CR>",   "headings"  },
          },
          k = {
            name = "Keybind",
            t = { "<cmd>Neorg keybind all core.pivot.toggle-list-type<CR>",          "list type toggle"    },
          },
          j = {
            -- 해당 keymap에 대한 상세 기능은 after/plugin/neorg.lua를 참조
            name = "Journal",
            -- t = { "<cmd>Neorg journal today<CR>"    ,                                "journal 'today'"     },
            -- y = { "<cmd>Neorg journal yesterday<CR>",                                "journal 'yesterday'" },
            -- n = { "<cmd>Neorg journal tomorrow<CR>" ,                                "journal 'tomorrow'"  },
          },
          m = {
            name = "Metagen",
            i = { "<cmd>Neorg inject-metadata<CR>" ,                                 "inject metadata"     },
            u = { "<cmd>Neorg update-metadata<CR>" ,                                 "update metadata"     },
          },
        },
      },
    })

    -- 이걸 하지 않으면, norg 파일을 열었을 때, 링크가 제대로 표시되지 않음.
    vim.wo.concealcursor = "n"
    vim.wo.conceallevel  = 2


  end,
}
