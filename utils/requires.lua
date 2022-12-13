function RequireAllObjects()
  local object_files = {}
  RecursiveEnumerate('objects', object_files)
  RequireFiles(object_files)
  return object_files
end

function RequireAllRooms()
  local object_files = {}
  RecursiveEnumerate('rooms', object_files)
  RequireFiles(object_files)
  return object_files
end

function RequireFiles(files)
  for _, fileName in ipairs(files) do
    require(fileName:sub(1, -5))
  end
end

function RecursiveEnumerate(folder, file_list)
  local items = love.filesystem.getDirectoryItems(folder)
  for _, item in ipairs(items) do
    local file = folder .. '/' .. item
    local info = love.filesystem.getInfo(file)
    if info.type == "file" then
      table.insert(file_list, file)
    elseif info.type == "directory" then
      RecursiveEnumerate(file, file_list)
    end
  end
end
