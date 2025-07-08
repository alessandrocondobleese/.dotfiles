local api = vim.api
local fn = vim.fn
local bo = vim.bo
local statusline_icons = require('core.icons').statusline_icons
local mini_icons = require 'mini.icons'

local path_widget = {}

---@type table<string, string>
local branch_cache = setmetatable({}, { __mode = 'k' })
---@type table<string, string>
local remote_cache = setmetatable({}, { __mode = 'k' })

--- Gets the root path of the current file based on predefined root items.
---@param file_path string The path to the file.
---@return string|nil The root path or nil if not found.
function path_widget.get_path_root(file_path)
  if file_path == '' then
    return
  end

  local root = vim.b.path_root
  if root then
    return root
  end

  local root_items = {
    '.git',
  }

  root = vim.fs.root(file_path, root_items)
  if root == nil then
    return nil
  end
  if root then
    vim.b.path_root = root
  end
  return root
end

--- Executes a git command and returns its stdout.
---@param root string The root directory for the git command.
---@param ... string Arguments for the git command.
---@return string|nil stdout or nil if an error occurred.
local function execute_git_command(root, ...)
  local job = vim.system({ 'git', '-C', root, ... }, { text = true }):wait()
  if job.code ~= 0 then
    return nil, job.stderr
  end
  return vim.trim(job.stdout)
end

--- Gets the remote name of the git repository.
---@param root string The root directory of the git repository.
---@return string|nil The remote name or nil if not found.
function path_widget.get_git_remote_name(root)
  if not root then
    return nil
  end
  if remote_cache[root] then
    return remote_cache[root]
  end

  local output =
    execute_git_command(root, 'config', '--get', 'remote.origin.url')
  if not output then
    return nil
  end

  output = output:gsub(':', '/'):gsub('%.git$', ''):match '([^/]+/[^/]+)$'

  remote_cache[root] = output
  return output
end

--- Gets the current git branch name.
---@param root string The root directory of the git repository.
---@return string|nil The branch name or nil if not found.
function path_widget.get_git_branch(root)
  if not root then
    return nil
  end
  if branch_cache[root] then
    return branch_cache[root]
  end

  local output = execute_git_command(root, 'rev-parse', '--abbrev-ref', 'HEAD')
  if output == 'HEAD' then
    local commit = execute_git_command(root, 'rev-parse', '--short', 'HEAD')
    commit = path_widget.highlight_string('Comment', '(' .. commit .. ')')
    output = string.format('%s %s', output, commit)
  end

  branch_cache[root] = output

  return output
end

--- Highlights a string with a given highlight group.
---@param highlight_group string The highlight group to use.
---@param text string The text to highlight.
---@return string The highlighted string.
function path_widget.highlight_string(highlight_group, text)
  return '%#' .. highlight_group .. '#' .. text .. '%*'
end

--- Escapes special characters in a string for use in patterns.
---@param text string The string to escape.
---@return string The escaped string.
local function escape_string(text)
  return text:gsub('([%(%)%%%+%-%*%?%[%]%^%$])', '%%%1')
end

--- Renders the path widget for the statusline.
---@param root_path string|nil The root path of the current file.
---@param file_name string The name of the current file.
---@return string The rendered path widget string.
function path_widget.render(root_path, file_name)
  local current_file_name = fn.fnamemodify(file_name, ':t')

  local path_icon, highlight_group
  path_icon, highlight_group = mini_icons.get('file', current_file_name)

  if file_name == '' then
    current_file_name = '[No Name]'
  end
  local formatted_path = path_widget.highlight_string(
    highlight_group,
    path_icon
  ) .. current_file_name

  if bo.buftype == 'help' then
    return path_widget.highlight_string(
      statusline_icons.file[1],
      statusline_icons.file[2]
    ) .. formatted_path
  end

  local directory_path = fn.fnamemodify(file_name, ':h') .. '/'
  if directory_path == './' then
    directory_path = ''
  end

  local remote_name = path_widget.get_git_remote_name(root_path)
  local branch_name = path_widget.get_git_branch(root_path)
  local repository_info = ''
  if remote_name and branch_name then
    directory_path =
      directory_path:gsub('^' .. escape_string(root_path) .. '/', '')
    repository_info = string.format(
      '%s %s @ %s ',
      path_widget.highlight_string(
        statusline_icons.branch[1],
        statusline_icons.branch[2]
      ),
      remote_name,
      branch_name
    )
  end

  local window_width = api.nvim_win_get_width(0)
  local required_width = #repository_info + #directory_path + #formatted_path
  if window_width < required_width + 5 then
    directory_path = ''
  end
  if window_width < required_width - #directory_path then
    repository_info = ''
  end

  return repository_info
    .. path_widget.highlight_string(
      statusline_icons.file[1],
      statusline_icons.file[2]
    )
    .. ' '
    .. directory_path
    .. formatted_path
    .. ' '
end

return path_widget
