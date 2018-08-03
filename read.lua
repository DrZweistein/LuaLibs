-- -----------------------------
--Name: read.lua
--Programmer: DrZweistein (LUA)
--Version: 1.1
--updated: 23_03_2015
--Function: Read library and status informations
--Functions:  readlinesfrom(file)

-- -----------------------------





-- -----------------------------
--Name: function readlinesfrom(file)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 13_08_2014
--Function: Read all lines
--Input: file
--Output: lines
-- -----------------------------
-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function readlinesfrom(file)
  if not readfile_exists(file) then return {} end
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end--readlinesfrom

-- -----------------------------
--Name: function readfile_exists(file)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 13_08_2014
--Function: check if file exist
--Input: file
--Output:
-- -----------------------------
-- see if the file exists
function readfile_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end--readfile_exists

