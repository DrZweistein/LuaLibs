-- -----------------------------
--Name: function askFileName(name,path)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 13_08_2014
--Function: build name and path in one string
--Input: name = name ; path = (ex.: /users/library/)
--Output: pathname / if no output Value = nil
-- -----------------------------
function askFileName(name,path)
    if (name and path) then
      pathname = path..name
    end
  return pathname
end

-- -----------------------------
--Name: function askFileNamewithend(name,path)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 08_11_2014
--Function: build name and Datafile in one string
--Input: name = name ; path = (ex.: /users/library/)
--Output: pathname / if no output Value = nil
-- -----------------------------
function askFileNamewithend(name,fileend)
    if (name and fileend) then
      FileNameWithEnd = name..fileend
    end
  return FileNameWithEnd
end

-- -----------------------------
--Name: askToolName(Name,Robot,Number)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 13_08_2014
--Function: build Tool definition for any kind of Robot
--Input: name = name ; Robot = "Kuka","Staubli","Fanuc"
--Output: Tooloutput1..2..3 / if no output Value = nil
-- -----------------------------
function askToolName(Name,Robot,Number)
    if (Robot == "Kuka") then
      Tooloutput1 = "$ACT_TOOL = "..Number.." ;"..Name
      Tooloutput2 = "$TOOL=TOOL_DATA ".."["..Number.."]"
    end  
  return Tooloutput1, Tooloutput2 
 end 
 
 -- -----------------------------
--Name: askPtpParameter(Velocity,Acceleration,Robot)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 13_08_2014
--Function: build Velocity and Acceleration Parameters for any kind of Robot
--Input: name = name ; Robot = "Kuka","Staubli","Fanuc"
--Output: Veloutput ; Accoutput / if no output Value = nil
-- -----------------------------
function askPtpParameter(PtpVelocity,Acceleration,Robot)
    if (Velocity and Acceleration and (Robot == "Kuka")) then
      PtpVeloutput = "$VEL_AXIS[I]="..Velocity
      PtpAccoutput = "$ACC_AXIS[I]="..Acceleration
    end
  return PtpVeloutput, PtpAccoutput 
end 

 -- -----------------------------
--Name: askLinParameter(Velocity,Acceleration,Robot)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 13_08_2014
--Function: build Velocity and Acceleration Parameters for any kind of Robot
--Input: LinVelocity = Velocity ; LinAcceleration (standart 250); Robot = "Kuka","Staubli","Fanuc" ; Units "m/sec","mm/min"
--Output: LinVeloutput, LinVelOriantation1, LinVelOriantation2, LinAccOriantation1, LinAccOriantation2 / if no output Value = nil
-- -----------------------------
function askLinParameter(LinVelocity,LinAcceleration,Robot,Units)
    if (LinVelocity and LinAcceleration and (Robot == "Kuka")) then
        if(Units == "mm/min") then
          LinWithUnitsVelocity = LinVelocity / 100 / 60
        
        end
        if(Units == "m/sec") then
          LinWithUnitsVelocity = LinVelocity
        
        end    
      LinVeloutput = "$VEL.CP="..LinWithUnitsVelocity
      LinVelOriantation1 = "$VEL.ORI1="..LinAcceleration
      LinVelOriantation2 = "$VEL.ORI1="..LinAcceleration
      LinAccOriantation1 = "$ACC.ORI1="..LinAcceleration
      LinAccOriantation2 = "$ACC.ORI1="..LinAcceleration
    end
  return LinVeloutput, LinVelOriantation1, LinVelOriantation2, LinAccOriantation1, LinAccOriantation2
end 

-- -----------------------------
--Name: function askFileLengh(LinesInFile,codeLengh,codeBegin,MaxLinesInFile)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 08_11_2014
--Function: check the Filelengh for Number of files
--expInput: codeLengh - codeBegin = HowmuFile +1
--Output: HowmuFile , HowmuFileWithonemore
-- -----------------------------
function askFileLengh(codeLengh,codeBegin,MaxLinesInFile)
  if (codeLengh and codeBegin) then
        LinesInFile =  codeLengh - codeBegin
        HowmuFile = LinesInFile / MaxLinesInFile
        HowmuFileWithonemore = HowmuFile + 1
  end
  return HowmuFile, HowmuFileWithonemore
end
 