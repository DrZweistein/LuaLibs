require "UTask"

  -- -----------------------------
--Name: writeInFile(Content,Path)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 13_08_2014
--Function: build Velocity and Acceleration Parameters for any kind of Robot
--Input: Content,Path "need ask.lua => Function askFileName"
--Output: / if no output Value = nil
-- -----------------------------
function writeInFile(Content,Path)
  local f = io.open(Path, "a")
 f:write(Content)
  f:write("\n")
  f:close()
end

-- -----------------------------
--Name: writeInFile(Content,Path)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 13_08_2014
--Function: build Velocity and Acceleration Parameters for any kind of Robot
--Input: Content,Path "need ask.lua => Function askFileName"
--Output: / if no output Value = nil
-- -----------------------------
function writeNewLine(Path)
  local f = io.open(Path, "a")
  f:write("\n")
  f:close()
end

-- -----------------------------
--Name: writeInFile(Content,Path)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 04_11_2014
--Function: write end in File
--Input: Content,Path "need ask.lua => Function askFileName"
--Output: / if no output Value = nil
-- -----------------------------
function writeEnd(Path)
  local f = io.open(Path, "a")
  f:write("end\n")
  f:close()
end

 -- -----------------------------
--Name: writeHeadKuka(FileName,savePath,Base,VelAxisPtp,AccAxisPtp,VelCP,VelOri1,VelOri2,AccOri1,AccOri2,PosCrit,NameOfTool,NumberofTool)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 13_08_2014
--Function: Write Header for Kuka output
--Input: FileName,Base,Tool,VelAxisPtp,AccAxisPtp,VelCP,VelOri1,VelOri2,AccOri1,AccOri2,PosCrit,NameOfTool
--Output: / if no output Value = nil
-- -----------------------------
function writeHeadKuka(FileName,savePath,Base,StartPointPTP,VelAxisPtp,AccAxisPtp,VelCP,VelOri1,VelOri2,AccOri1,AccOri2,PosCrit,NameOfTool,NumberofTool,ExternProgs,InterrupProgs)
  local FileType = ".src"
  
    askFileNamewithend(FileName,FileType) 	-- Build Name and Filetype together
    askFileName(FileNameWithEnd,savePath)    -- Build Name and Path together
  
  local content = {}
  local contentLin = {}
  local contentDis = {}
  local contentTool = {}
  content[1] = "&ACCESS RVP"
  content[2] = "&REL 4\n&COMMENT UTRobots"
  content[3] = [[&PARAM TEMPLATE = C:\KRC\Roboter\Template\vorgabe]]
  content[4] = "&PARAM EDITMASK = *"
  content[5] = "DEF "..FileName.."( )"
  content[6] = "INT I"
  content[7] = "BAS (#INITMOV,0 )"
  content[8] = [[;----User adjustments for PTP motion----]]
  content[9] = [[;FOLD]]
  content[10] = [[;SET PTP $VEL_AXIS AND $ACC_AXIS]]
  content[11] = [[FOR I=1 TO 6]]
  content[12] = [[$VEL_AXIS[I]=]]..VelAxisPtp
  content[13] = [[$ACC_AXIS[I]=]]..AccAxisPtp
  content[14] = [[ENDFOR]]
  content[15] = [[;ENDFOLD (SET PTP $VEL_AXIS AND $ACC_AXIS)]]
  contentLin[1] = [[;---User adjustments for LIN & ARC motion----]]
  contentLin[2] = [[;FOLD]]
  contentLin[3] = [[;SET LIN AND ARC MOTION VARIABLES]]
  contentLin[4] = [[$VEL.CP=]]..VelCP
  contentLin[5] = [[$VEL.ORI1=]]..VelOri1
  contentLin[6] = [[$VEL.ORI2=]]..VelOri2
  contentLin[7] = [[$ACC.ORI1=]]..AccOri1
  contentLin[8] = [[$ACC.ORI2=]]..AccOri2
  contentLin[9] = [[;ENDFOLD (SET LIN AND ARC MOTION VARIABLES)]]
  contentDis[1] = [[;----Setting for Position----]]
  contentDis[2] = [[;FOLD]]
  contentDis[3] = [[;SET POSITIONING CRITERIA]]
  contentDis[4] = [[$APO.CDIS = ]]..PosCrit
  contentDis[5] = [[;ENDFOLD (SET POSITIONING CRITERIA)]]
  contentTool[1] = [[;FOLD]]
  contentTool[2] = [[;SET BASE_AND_TOOL]]
  contentTool[3] = [[$ACT_TOOL = ]]..NumberofTool.." ;Tool Name= "..NameOfTool
  contentTool[4] = "$TOOL=TOOL_DATA".."["..NumberofTool.."]"
  contentTool[5] = [[;ENDFOLD (SET BASE_AND_TOOL)]]
 
 Basepos = "$BASE=".."{"..Base.."}"
 PTPStart = "PTP ".."{"..StartPointPTP.."}"
  
 -- HeaderSection
  for i=1,5,1 do 
    writeInFile(content[i],pathname)
  end
    writeNewLine(pathname)
-- EXT Program

 if(ExternProgs ~= nil)then
   local CodeLengh = table.getn(ExternProgs) -- check how long is the reading file in Numbers
   
    for i=1,CodeLengh,1 do 
      writeInFile(ExternProgs[i],pathname)
    end
   writeNewLine(pathname)
 end
  
  for i=6,7,1 do 
    writeInFile(content[i],pathname)
    writeNewLine(pathname)
  end
 -- EXT Program and Interruptsektion
  if(InterrupProgs ~= nil)then
   local CodeLengh = table.getn(InterrupProgs) -- check how long is the reading file in Numbers
   
    for i=1,CodeLengh,1 do 
      writeInFile(InterrupProgs[i],pathname)
    end
   writeNewLine(pathname)
 end
 
 -- PTP Section
  for i=8,15,1 do 
    writeInFile(content[i],pathname)
  end
    writeNewLine(pathname)
 -- LIN Section
  for i=1,9,1 do 
    writeInFile(contentLin[i],pathname)
  end 
  writeNewLine(pathname)
  -- DIS Section
  for i=1,5,1 do 
    writeInFile(contentDis[i],pathname)
  end 
  writeNewLine(pathname)
  -- Tool Section
  for i=1,5,1 do 
    writeInFile(contentTool[i],pathname)
  end 
  writeNewLine(pathname)
  --Base
  writeInFile(Basepos,pathname)
  for i=1,2,1 do
  writeNewLine(pathname)
 	--first PTP Point
  end
  writeInFile(PTPStart,pathname)
end

-- -----------------------------
--Name: function writeCodeKuka(FileName,savePath,PointforX,PointforY,PointforZ,PointforA,PointforB,PointforC,G,ToolActivation,Velocity)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 14_08_2014
--Function: Write Code for Kuka output
--Input: PointforX,PointforY,PointforZ,PointforA,PointforB,PointforC,G,ToolActivation,Velocity
--Output: / if no output Value = nil
-- -----------------------------
function writeCodeKuka(FileName,savePath,PointforX,PointforY,PointforZ,PointforA,PointforB,PointforC,G,ToolActivation,Velocity)

askFileName(FileName,savePath) 

local MovementPTP="PTP"
local MovementLIN="LIN"
local Displace="C_DIS"

local estring= " "
local rbl="{"
local rbr="}"
local scomma = ","

local NameofX = "X "
local NameofY = "Y "
local NameofZ = "Z "
local NameofA = "A "
local NameofB = "B "
local NameofC = "C "

    if (G == 1 or G == 3) then
      Movement = MovementLIN
    end
    if (G == 0) then
      Movement = MovementPTP
    end
    
codecontent = Movement..estring..rbl..NameofX..PointforX..scomma..NameofY..PointforY..scomma..NameofZ..PointforZ..scomma..NameofA..PointforA..scomma..NameofB..PointforB..scomma..NameofC..PointforC..rbr..estring..Displace

--writing in File
writeInFile(codecontent,pathname)

end
-- -----------------------------
--Name: function WriteKukaToolChange(FileName,savePath,IO,Name,TrueOrFalseString)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 02_04_2015
--Function: Write Code Input line for Kuka
--Input: Write a new toolchange in file
--Output: / if no output Value = nil
-- -----------------------------
function WriteKukaToolChange(FileName,savePath,ToolNumber,ToolName) -- return WriteIOKuka (if false -1)
local codecontent
--build Name + Path
askFileName(FileName,savePath)
-- Check if Input or Output
      
codecontent = {"$ACT_TOOL = "..ToolNumber.." ;Tool Name= "..ToolName,"$TOOL=TOOL_DATA["..ToolNumber.."]"}

  for i=1,2,1 do
    writeInFile(codecontent[i],pathname)
  end
  --writeNewLine(pathname)
end --WriteKukaToolChange

-- -----------------------------
--Name: function WriteKukaStandartVel(FileName,savePath,Velocity)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 02_04_2015
--Function: Write Code Input line for Kuka
--Input: Write a new Velocity in code
--Output: / if no output Value = nil
-- -----------------------------
function WriteKukaStandartVel(FileName,savePath,Velocity) -- return WriteIOKuka (if false -1)
local codecontent
--build Name + Path
askFileName(FileName,savePath)
-- Check if Input or Output
      
codecontent = "$VEL.CP="..Velocity


    writeInFile(codecontent,pathname)

  --writeNewLine(pathname)
end --WriteKukaStandartVel
-- -----------------------------
--Name: function WriteKukaIO(FileName,savePath,IO,Name,TrueOrFalseString)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 18_03_2015
--Function: Write Code Input line for Kuka
--Input: "I" for input or "O" for Output and NameofTool or Number / TrueOrFalseString is f.e.: "true" or "false"
--Output: / if no output Value = nil
-- -----------------------------
function WriteKukaIO(FileName,savePath,IO,Name,TrueOrFalseString,Comment) -- return WriteIOKuka (if false -1)
local codecontent
  if(Comment == nil) then
    CommentString = "Switch ON/OFF"
  else
    CommentString = Comment
  end

--build Name + Path
askFileName(FileName,savePath)
-- Check if Input or Output
  if(IO == "I") or (IO == "O") then
    if(IO == "I")then
      codecontent = "$IN["..Name.."]="..TrueOrFalseString .." ;"..CommentString
    else
      codecontent = "$OUT["..Name.."]="..TrueOrFalseString .." ;"..CommentString
    end
  writeInFile(codecontent,pathname)
  else 
    WriteIOKuka =-1
end

return WriteIOKuka
end --WriteKukaIO

-- -----------------------------
--Name: function WriteKukaProgramWithIOs(FileName,savePath,IO,Name,TrueOrFalseString)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 18_03_2015
--Function: Write Code Input line for Kuka
--Input: "I" for input or "O" for Output and NameofTool or Number / TrueOrFalseString is f.e.: "true" or "false"
--Output: / if no output Value = nil
-- -----------------------------
function WriteKukaProgramWithIOs(FileName,savePath,OnOff,Name,Comment) -- return WriteIOKuka (if false -1)
local codecontent
  if(Comment == nil) then
    CommentString = "Switch ON/OFF"
  else
    CommentString = Comment
  end

--build Name + Path
askFileName(FileName,savePath)
-- Check if Input or Output
  if(OnOff == "ON") or (OnOff == "OFF") then
    if(OnOff == "ON")then
      codecontent = Name.."ein()".." ;"..CommentString
    else
      codecontent = Name.."aus()".." ;"..CommentString
    end
  writeInFile(codecontent,pathname)
  else 
    WriteIOKuka =-1
end

return WriteIOKuka
end --WriteKukaProgramWithIOs
-- -----------------------------
--Name: function writeKukaPTP(FileName,savePath,PTPString,Comment) 
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 18_03_2015
--Function: Write Code PTP line for Kuka
--Input: PTP
--Output: / if no output Value = nil
-- -----------------------------
function writeKukaPTP(FileName,savePath,PTPString,Comment)
    local CommentString
    
    if(Comment==nil)then
      CommentString = ";PTP Point"
    else
      CommentString = ";"..Comment
    end
    
  local codecontent = "PTP {"..PTPString.."}  "..CommentString
  askFileName(FileName,savePath)
  writeNewLine(pathname)
  writeInFile(codecontent,pathname)
  writeNewLine(pathname)
  
end --writeKukaPTP

-- -----------------------------
--Name: function writeKukaBase(FileName,savePath,Base,Comment) 
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 18_03_2015
--Function: Write Code PTP line for Kuka
--Input: PTP
--Output: / if no output Value = nil
-- -----------------------------
function writeKukaBase(FileName,savePath,Base,Comment)
    local CommentString
    
    if(Comment==nil)then
      CommentString = ";New Base"
    else
      CommentString = ";"..Comment
    end
    
  local codecontent = "$BASE={"..Base.."}  "..CommentString
  askFileName(FileName,savePath)
  writeNewLine(pathname)
  writeInFile(codecontent,pathname)
  writeNewLine(pathname)
  
end --writeKukaBase

-- -----------------------------
--Name: function writeCodeVrep(FileName,savePath,PointforX,PointforY,PointforZ,PointforA,PointforB,PointforC,G,ToolActivation,Velocity)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 14_08_2014
--Function: Write Code for Vrep output
--Input: PointforX,PointforY,PointforZ,PointforA,PointforB,PointforC,G,ToolActivation,Velocity
--Output: in file / if no output Value = nil
-- -----------------------------
function writeCodeVrep(FileName,savePath,PointforX,PointforY,PointforZ,PointforA,PointforB,PointforC,G,ToolActivation,Velocity)

askFileName(FileName,savePath) 

local MovementPTP="simMoveToJointPositions"
local MovementIk="ikDrivingJoints"
local linVelocity="linearVelocity"
local linAccel="linearAccel"
local angleToLinCoeff= "angleToLinearCoeff"

local rbl="{"
local rbr="}"
local bbl="("
local bbr=")"
local scomma = ","

local PI= "*math.pi/180"

codecontent = MovementPTP..bbl..MovementIk..scomma..rbl..PointforX..scomma..PointforY..scomma..PointforZ..scomma..PointforA..PI..scomma..PointforB..PI..scomma..PointforC..PI..rbr..scomma..linVelocity..scomma..linAccel..scomma..angleToLinCoeff..bbr

--writing in File
writeInFile(codecontent,pathname)

end
