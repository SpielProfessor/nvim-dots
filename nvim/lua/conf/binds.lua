--[ K E Y B I N D I N G S ]--
-- cfg by mrvollbart --

-- HELP MENU
function printhelp()
  local help = [[
+--------------------------+
|MrVollbart's neovim config|
+-----------------+--------+------------------------------------------+
|Ctrl+n           | File tree                                         |
|Shift+Tab        | Show buffers                                      |
|Space+t          | telescope                                         |
|Space+c          | change colorscheme                                |
|Ctrl+j           | Show errors/warnings/todos                        |
|Alt+v Al+h Alt+f | Show/hide vertical/horizontal/floating terminal   |
|Ctrl+a           | Toggle Aerial, a function/struct finder           |
|Ctrl+s           | Toggle undo tree                                  |
|Space+d          | Show docs                                         |
|?                | Show quick fixes                                  |
+-----------------+---------------------------------------------------+
|Buffer bar                                                           |
+-----------------+---------------------------------------------------+
|Alt + , .        | Select tab left or right                          |
|Alt + < >        | Move tab left or right                            |
|Alt + c          | Close tab                                         |
|Alt + p          | Pin tab                                           |
|Alt + 1-9        | Go to buffer                                      |
|Alt + 0          | Go to last buffer                                 |
|Alt + b          | Open new buffer                                   |
+-----------------+---------------------------------------------------+

To get new LSP servers, use the command ":Mason" and find the server of
your choice
]]
  print(help)
end
cfg = require("conf.config")
vim.keymap.set("n", "<leader>h", ":lua printhelp()\n")
vim.cmd("command! Helpcfg lua printhelp()")
-- make Control-n toggle file tree
vim.keymap.set("n", "<C-n>", vim.cmd.NvimTreeToggle)
-- make shift-tab open the buffers overview
vim.keymap.set("n", "<S-Tab>", ":Telescope buffers\n")
-- open telescope colorscheme with space-c and the basic telescope view with space-t
vim.keymap.set("n", "<leader>t", vim.cmd.Telescope)
vim.keymap.set("n", "<leader>c", ":Telescope colorscheme\n")
-- open todo trouble view with Ctrl-j
vim.keymap.set("n", "<C-j>", vim.cmd.TodoTrouble)
-- open vertical terminal
vim.keymap.set("n", "<A-v>", ":ToggleTerm direction=vertical size=50\n")
vim.keymap.set("n", "<A-h>", ":ToggleTerm direction=horizontal size=10\n")
vim.keymap.set("n", "<A-f>", ":ToggleTerm direction=float size=20\n")

-- open/close aerial with control-a
if cfg.outline == "aerial" then
  vim.keymap.set("n", "<C-a>", ":AerialToggle\n")
elseif cfg.outline == "lspsaga" then
  vim.keymap.set("n", "<C-a>", ":Lspsaga outline\n")
end
-- open/close undotree
vim.keymap.set("n", "<C-s>", ":UndotreeToggle\n")

-- [ T A B S  T O  T W O  S P A C E S ] --
-- Replace tabs with spaces
vim.o.expandtab = true

-- Set the number of spaces inserted for each tab
vim.o.shiftwidth = 2

-- Set the number of spaces used for <Tab> and <BS> operations
vim.o.softtabstop = 2

--change exit terminal keyboard shortcut
vim.keymap.set("t", "<A-v>", "<C-\\><C-n>", { silent = true })
vim.keymap.set("t", "<A-h>", "<C-\\><C-n>", { silent = true })
vim.keymap.set("t", "<A-f>", "<C-\\><C-n>", { silent = true })

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Tab bar
-- Move to previous/next
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
-- Re-order to previous/next
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
-- Goto buffer in position...
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
-- Pin/unpin buffer
map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
-- Close buffer
map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map("n", "<C-p>", "<Cmd>BufferPick<CR>", opts)
-- Sort automatically by...
map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
map("n", "<Space>bn", "<Cmd>BufferOrderByName<CR>", opts)
map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)

-- alt-b: open new buffer in new tab
map("n", "<A-b>", "<Cmd>tabe<CR>", opts)

-- make the ? button show code actions and the
vim.keymap.set("n", "<leader>d", ":Lspsaga hover_doc\n")
vim.keymap.set("n", "?", ":Lspsaga code_action\n")
