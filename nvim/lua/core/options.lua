local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber  = false   -- show relative line numbers
opt.number          = true    -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop         = 2       -- 2 spaces for tabs (prettier default)
opt.shiftwidth      = 2       -- 2 spaces for indent width
opt.expandtab       = true    -- expand tab to spaces
opt.autoindent      = true    -- copy indent from current line when starting new one

-- enable mouse
opt.mouse           = "a"

-- line wrapping
opt.wrap            = false   -- disable line wrapping

-- search settings
opt.ignorecase      = true    -- ignore case when searching
opt.smartcase       = true    -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline      = true    -- highlight the current cursor line

-- turn off swapfile
opt.swapfile        = false

-- appearance
opt.termguicolors   = true
opt.background      = "dark"  -- colorschemes that can be light or dark will be made dark
opt.signcolumn      = "yes"   -- show sign column so that text doesn't shift

-- backspace
opt.backspace       = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright      = true    -- split vertical window to the right
opt.splitbelow      = true    -- split horizontal window to the bottom

-- fold setting
vim.o.foldlevel      = 99
vim.o.foldcolumn     = '1'
vim.wo.foldnestmax   = 10
vim.wo.conceallevel  = 2
vim.wo.foldminlines  = 2
vim.o.foldenable     = true
vim.o.foldlevelstart = 99
vim.o.fillchars      = [[eob: ,fold: ,foldopen:▽,foldsep: ,foldclose:▷]]  -- ┊
vim.o.foldtext       = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').' ... ' . '󱝁  ' . (v:foldend - v:foldstart + 1) . ' lines']]
vim.wo.foldmethod    = "indent"
vim.wo.foldexpr      = "nvim_treesitter#foldexpr()"
vim.cmd('highlight Folded     ctermbg=NONE guibg=NONE')
vim.cmd('highlight FoldColumn ctermfg=NONE guifg=NONE')


opt.signcolumn = "auto:3"


-- remove vim-signature mark "~"
vim.opt.shada = "!,'0,f0,<50,s10,h"

-- add hyprland syntax highlighting
vim.filetype.add {
  extension = { rasi = 'rasi' },
  pattern = {
    ['.*/waybar/config'] = 'jsonc',
    ['.*/mako/config'] = 'dosini',
    ['.*/kitty/*.conf'] = 'bash',
    ['.*/hypr/.*%.conf'] = 'hyprlang',
  },
}
