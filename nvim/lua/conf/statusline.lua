if require("conf.config").panelProvider == "lualine" then
  local theme = require("lualine.themes.everforest")
  local bg = "#272e33"
  local fg = "#d3c6aa"
  theme.normal.c.bg = bg
  theme.insert.c.bg = bg
  theme.visual.c.bg = bg
  theme.replace.c.bg = bg
  theme.command.c.bg = bg
  theme.inactive.c.bg = bg
  theme.normal.a.bg = "#3c4841"
  theme.normal.a.fg = fg
  theme.insert.a.fg = fg
  theme.insert.a.bg = "#384b55"
  theme.visual.a.fg = fg
  theme.visual.a.fg = "#493b40"
  theme.command.a.fg = fg
  theme.command.a.bg = "#4f5b58"
  local function play()
    return [[]]
  end
  local function play_project()
    return [[󰴊]]
  end
  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = theme,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    },
    sections = {
      lualine_a = {
        "mode",
      },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = {
        {
          play,
          on_click = function()
            vim.cmd("RunFile\n")
          end,
        },
        {
          play_project,
          on_click = function()
            vim.cmd("RunProject\n")
          end,
        },
        "filetype",
      },
      lualine_y = {
        "os.date('%c')",
      },
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  })
end
