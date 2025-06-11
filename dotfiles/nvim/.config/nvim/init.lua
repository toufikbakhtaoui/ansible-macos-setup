-- Set leader key to space
vim.g.mapleader = ' '

-- Basic editor settings
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- Relative line numbers
vim.opt.tabstop = 4           -- Number of spaces tabs count for
vim.opt.shiftwidth = 4        -- Size of an indent
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.smartindent = true    -- Auto indent on new lines
vim.opt.wrap = false          -- Don't wrap long lines
vim.opt.ignorecase = true     -- Case insensitive searching
vim.opt.smartcase = true      -- Case sensitive if uppercase present
vim.opt.termguicolors = true  -- Better color support
vim.opt.scrolloff = 8         -- Keep 8 lines above/below cursor
vim.opt.signcolumn = "yes"    -- Always show sign column
vim.opt.updatetime = 300      -- Faster completion