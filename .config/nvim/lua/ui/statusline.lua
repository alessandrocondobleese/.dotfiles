local shared = require("shared")
local code = shared.code

local statusline = {}

local function color(highlight, content)
  return string.format("%%#%s#%s%%*", highlight, content)
end

local function mode_color()
  -- Colors defined in lua/plugins/theme.lua
  local mode_colors = {
    ["n"] = "StatuslineNormal",
    ["s"] = "StatuslineNormal",
    ["S"] = "StatuslineNormal",
    ["t"] = "StatuslineNormal",
    [code("<c-s>")] = "StatuslineNormal",
    ["i"] = "StatuslineInsert",
    ["R"] = "StatuslineReplace",
    ["v"] = "StatuslineVisual",
    ["V"] = "StatuslineVisual",
    [code("<c-v>")] = "StatuslineVisual",
    ["c"] = "StatuslineCommand",
  }

  local current_mode = vim.api.nvim_get_mode().mode
  return mode_colors[current_mode] or "StatuslineNormal"
end

local function mode()
  return color(mode_color(), "▎")
end

local function icon()
  local file = vim.fn.expand("%:p:t")
  local extension = vim.fn.expand("%:e")

  if #file == 0 then
    return color("StatuslineAccent", "")
  end

  local the_icon = require("nvim-web-devicons").get_icon(file, extension)
  return color(mode_color(), the_icon or "●")
end

local function filename()
  local file_path = '%{expand("%:p:h:t")}/%{expand("%:p:t")}'
  -- »
  return string.format("%s %%<%s %s", color("StatuslineAccent", ">"), file_path, color("StatuslineAccent", "<"))
end

local function file_modified()
  if vim.bo.modified then
    return color("StatuslineBoolean", "+")
  end

  return nil
end

local function file_read_only()
  if vim.bo.readonly then
    return color("StatuslineBoolean", "‼")
  end

  return nil
end

function _G.statusline()
  return table.concat({
    mode(),
    icon(),
    "",
    filename(),
    file_modified(),
    file_read_only(),
  }, " ")
end

function statusline.setup()
  vim.opt.laststatus = 3
  vim.o.statusline = "%!v:lua.statusline()"
end

statusline.setup()

return statusline
