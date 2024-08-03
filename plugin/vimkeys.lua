-- Path          - .config/nvim/lua/vimkeys.lua
-- GitHub        - https://github.com/The-Repo-Club/
-- Author        - The-Repo-Club [wayne6324@gmail.com]
-- Start On      - Wed 26 January 2022, 06:02:53 pm (GMT)
-- Modified On   - Fri 28 January 2022, 04:56:39 pm (GMT)
-- Version=2022.01.26

-- Set options and add mapping such that Neovim behaves a lot like MS-Windows

-- Bail out if this isn't wanted.
if vim.g.skip_loading_mswin then
    return
end

-- set the 'cpoptions' to its Vim default
local save_cpo = vim.o.cpoptions
vim.cmd('set cpo&vim')

-- set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
vim.cmd('behave mswin')

-- backspace and cursor keys wrap to previous/next line
vim.o.backspace = 'indent,eol,start'
vim.o.whichwrap = vim.o.whichwrap .. '<,>,[,]'

-- backspace in Visual mode deletes selection
vim.api.nvim_set_keymap('v', '<BS>', 'd', { noremap = true })

if vim.fn.has('clipboard') == 1 then
    -- CTRL-X and SHIFT-Del are Cut
    vim.api.nvim_set_keymap('v', '<C-X>', '"+x', { noremap = true })
    vim.api.nvim_set_keymap('v', '<S-Del>', '"+x', { noremap = true })

    -- CTRL-C and CTRL-Insert are Copy
    vim.api.nvim_set_keymap('v', '<C-C>', '"+y', { noremap = true })
    vim.api.nvim_set_keymap('v', '<C-Insert>', '"+y', { noremap = true })

    -- CTRL-V and SHIFT-Insert are Paste
    vim.api.nvim_set_keymap('n', '<C-V>', '"+gP', { noremap = true })
    vim.api.nvim_set_keymap('n', '<S-Insert>', '"+gP', { noremap = true })
    vim.api.nvim_set_keymap('c', '<C-V>', '<C-R>+', { noremap = true })
    vim.api.nvim_set_keymap('c', '<S-Insert>', '<C-R>+', { noremap = true })
end

-- Pasting blockwise and linewise selections is not possible in Insert and
-- Visual mode without the +virtualedit feature. They are pasted as if they
-- were characterwise instead.
-- Uses the paste.vim autoload script.
-- Use CTRL-G u to have CTRL-Z only undo the paste.

vim.api.nvim_set_keymap('i', '<C-V>', '<C-G>u' .. vim.fn['paste#paste_cmd']('i'), { noremap = true, expr = true })
vim.api.nvim_set_keymap('v', '<C-V>', vim.fn['paste#paste_cmd']('v'), { noremap = true, expr = true })
vim.api.nvim_set_keymap('i', '<S-Insert>', '<C-V>', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-Insert>', '<C-V>', { noremap = true })

-- Use CTRL-Q to do what CTRL-V used to do
vim.api.nvim_set_keymap('', '<C-Q>', '<C-V>', { noremap = true })

-- Use CTRL-S for saving, also in Insert mode (<C-O> doesn't work well when
-- using completions).
vim.api.nvim_set_keymap('n', '<C-S>', ':w<CR>', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-S>', '<C-C>:w<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-S>', '<Esc>:w<CR>gi', { noremap = true })

-- For CTRL-V to work autoselect must be off.
-- On Unix we have two selections, autoselect can be used.
if vim.fn.has('unix') == 0 then
    vim.o.guioptions = vim.o.guioptions:gsub('a', '')
end

-- CTRL-Z is Undo; not in cmdline though
vim.api.nvim_set_keymap('n', '<C-Z>', 'u', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-Z>', '<C-O>u', { noremap = true })

-- CTRL-Y is Redo (although not repeat); not in cmdline though
vim.api.nvim_set_keymap('n', '<C-Y>', '<C-R>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-Y>', '<C-O><C-R>', { noremap = true })

-- Alt-Space is System menu
if vim.fn.has('gui') == 1 then
    vim.api.nvim_set_keymap('n', '<M-Space>', ':simalt ~<CR>', { noremap = true })
    vim.api.nvim_set_keymap('i', '<M-Space>', '<C-O>:simalt ~<CR>', { noremap = true })
    vim.api.nvim_set_keymap('c', '<M-Space>', '<C-C>:simalt ~<CR>', { noremap = true })
end

-- CTRL-A is Select all
vim.api.nvim_set_keymap('n', '<C-A>', 'gggH<C-O>G', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-A>', '<C-O>gg<C-O>gH<C-O>G', { noremap = true })
vim.api.nvim_set_keymap('c', '<C-A>', '<C-C>gggH<C-O>G', { noremap = true })
vim.api.nvim_set_keymap('o', '<C-A>', '<C-C>gggH<C-O>G', { noremap = true })
vim.api.nvim_set_keymap('s', '<C-A>', '<C-C>gggH<C-O>G', { noremap = true })
vim.api.nvim_set_keymap('x', '<C-A>', '<C-C>ggVG', { noremap = true })

-- CTRL-Tab is Next window
vim.api.nvim_set_keymap('n', '<C-Tab>', '<C-W>w', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-Tab>', '<C-O><C-W>w', { noremap = true })
vim.api.nvim_set_keymap('c', '<C-Tab>', '<C-C><C-W>w', { noremap = true })
vim.api.nvim_set_keymap('o', '<C-Tab>', '<C-C><C-W>w', { noremap = true })

-- CTRL-F4 is Close window
vim.api.nvim_set_keymap('n', '<C-F4>', '<C-W>c', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-F4>', '<C-O><C-W>c', { noremap = true })
vim.api.nvim_set_keymap('c', '<C-F4>', '<C-C><C-W>c', { noremap = true })
vim.api.nvim_set_keymap('o', '<C-F4>', '<C-C><C-W>c', { noremap = true })

if vim.fn.has('gui') == 1 then
    -- CTRL-F is the search dialog
    vim.api.nvim_set_keymap('n', '<C-F>', 'has("gui_running") ? ":promptfind<CR>" : "/"', { noremap = true, expr = true })
    vim.api.nvim_set_keymap('i', '<C-F>', 'has("gui_running") ? "\\<C-\\>\\<C-O>:promptfind<CR>" : "\\<C-\\>\\<C-O>/"', { noremap = true, expr = true })
    vim.api.nvim_set_keymap('c', '<C-F>', 'has("gui_running") ? "\\<C-\\>\\<C-C>:promptfind<CR>" : "\\<C-\\>\\<C-O>/"', { noremap = true, expr = true })

    -- CTRL-H is the replace dialog,
    -- but in console, it might be backspace, so don't map it there
    vim.api.nvim_set_keymap('n', '<C-H>', 'has("gui_running") ? ":promptrepl<CR>" : "\\<C-H>"', { noremap = true, expr = true })
    vim.api.nvim_set_keymap('i', '<C-H>', 'has("gui_running") ? "\\<C-\\>\\<C-O>:promptrepl<CR>" : "\\<C-H>"', { noremap = true, expr = true })
    vim.api.nvim_set_keymap('c', '<C-H>', 'has("gui_running") ? "\\<C-\\>\\<C-C>:promptrepl<CR>" : "\\<C-H>"', { noremap = true, expr = true })
end

-- restore 'cpoptions'
vim.cmd('set cpo&')
vim.o.cpoptions = save_cpo
