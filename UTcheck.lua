-- -----------------------------
--Name: check.lua
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 15_03_2015
-- -----------------------------

-- -----------------------------
--Name: checkFile(Path)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 15_03_2015
--Function: Check If Files Exist and give the filesize
--Input: Path = /Users/bla/NameofFile.end
--Output: If it cannot find something == "FileNotAvailable" as String / or gives a SizeofFile as number
-- -----------------------------
function checkFile(Path)--return size
 -- local path = system.pathForFile(fileToDL, system.DocumentsDirectory )
local f = io.open(Path, "r") 

  --check if filesize
  if(f ~= nil)then 
    size = f:seek("end")
    f:close()
  else
    size = -1
    print("FileNotAvailable")
    --Massage box here
  end
   
return size
end

-- -----------------------------
--Name: checkFileAndRemove(Path)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 15_03_2015
--Function: Check If Files Exist and Remove if > as 0 Kb
--Input: Path = /Users/bla/NameofFile.end
--Output: If it cannot find something == "FileNotAvailable" as String / or gives a SizeofFile as number
-- -----------------------------
function checkFileAndRemove(Path)
  checkFile(Path)
  if(size >= 0)then
    os.remove(Path)
    --print("Can Check File or Remove")
  else
    print("Cannot Check File or Remove")
    --Massage box here
  end
  
  
end

-- -----------------------------
--Name: checkUserParameter(InputParameter,Parameter,Mode)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 28_04_2015
--Function: Check If User give correct Parameters

--Input: InputParameter is the UserParameter 
--/ / Parameter is the Parameter who compare
--/ / Mode 1 = Compare together 
--/ / Mode 2 = Search content in String input 
--/ / Mode 3 = Search for Table Input

--Output: NotRight: checkUserParameter = -1
-- -----------------------------
function checkUserParameter(InputParameter,Parameter,Mode)
  
  if (Mode == 1)then
    
    if(InputParameter == Parameter)then -- Parameter compare
      checkUserParameter = 1
    else
      checkUserParameter = -1
    end
    
  elseif (Mode == 2)then -- String find
    
    if(string.find(InputParameter,Parameter))then
      checkUserParameter = 1
    else
      checkUserParameter = -1 
    end
    
  elseif (Mode == 3)then -- String find
    checkUserParameter = {}
    
    CodeLengh = table.getn(InputParameter) 
    for i=1,CodeLengh,1 do
      if(string.find(InputParameter[i],Parameter))then
        checkUserParameter[i] = 1
      else
        checkUserParameter[i] = -1 
      end
    end --for 
    
  end --Mode end
  
  return checkUserParameter
end -- checkUserParameter

-- -----------------------------
--Name: checkMaxCodeLengh()
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 10.01.2015
--Function: checkMaxCodeLengh
-- -----------------------------
function checkMaxCodeLengh(InputParameter)
  MaxCodeLengh = table.getn(InputParameter) 
  return MaxCodeLengh
end

--checkUserParameter({"lol","hart.nc"},".nc",3)
--print(checkUserParameter[1].." "..checkUserParameter[2])
--checkFileAndRemove("/Users/ls_pat/".."NCTest4.src")
--print(size)
--os.remove(path)

-- -----------------------------
--Name: checklinesFromFile(File)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 10.01.2017
--Function: checklinesFromFile(file)
-- -----------------------------

function checklinesFromFile(file)
  
 if not checkFileExists(file) then return {} end
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
  
end

-- -----------------------------
--Name: function checkFileExists(file)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 13_08_2014
--Function: check if file exist
--Input: file
--Output:
-- -----------------------------
-- see if the file exists
function checkFileExists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

