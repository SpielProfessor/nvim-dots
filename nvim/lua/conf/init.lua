-- [ N E O V I M  C O N F I G ] --
-- by mrvollbart --

--[[
--   L O A D I N G:
--   - just load it with require("conf") in the init.lua file and you should be good to go!
--]]
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`
require("conf.binds")
require("conf.lazy")
require("conf.cmp-conf")
cfg = require("conf.config")

vim.cmd("set undofile")
vim.cmd("set number")
vim.cmd([[colorscheme ]] .. cfg.colorscheme)
if cfg.enableScrollbar then
  require("scrollbar").setup()
end
if cfg.treeOnStartup then
  vim.cmd("NvimTreeToggle")
end
require("bufferline").setup({})

require("refactoring").setup({})

-- LSP
local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {},
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({})
    end,
  },
})

-- set up conform formatting
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    c = { "clang-format" },
    rust = { "rustfmt" },
  },
})
-- format on write
if cfg.formatOnWrite then
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
      require("conform").format({ bufnr = args.buf })
    end,
  })
end
-- custom formatters
require("conform").formatters.stylua = {
  prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
}
require("conform").formatters.rustfmt = {
  prepend_args = { "--config", "tab_spaces=2" },
}
require("nvim-lightbulb").setup({
  autocmd = { enabled = true },
})

-- outline
if cfg.outlineAutostart then
  if cfg.outline == "aerial" then
    vim.cmd("AerialOpen!")
  elseif cfg.outline == "lspsaga" then
    print("Sorry! Lspsaga cannot open automatically")
    --vim.cmd("Lspsaga outline")
  end
end
