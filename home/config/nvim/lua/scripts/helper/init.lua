-- Lua module for helper scripts
local Path = require 'plenary.path'

_G.HelperFunctions = {}

local function exists(file)
  -- https://stackoverflow.com/questions/1340230/check-if-directory-exists-in-lua
  -- ok, err, code
  local ok, _, _ = os.rename(file, file)
  if ok then
    return true
  end
  return false
end

local function create_dir(path)
  Path:new(path):mkdir()
end

function HelperFunctions.if_no_dir_create_dir(path)
  if not exists(path) then
    create_dir(path)
  end
end

return HelperFunctions
