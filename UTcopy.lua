--Name: Copy library
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 13_08_2014
--Function: Convert Codes in every filesystem
-- -----------------------------
require "UTcheck"


-- -----------------------------
--Name: function createDir (dirname)
--Programmer: DrZweistein (LUA)
--Version: 2.0
--Date: 28.04.2017
--Function: create a new directory
--Input: Path + new directory
-- -----------------------------

function createDir (dirname)
      os.execute("mkdir " .. dirname)
    end



-- -----------------------------
--Name: function copyFile( sourceName, sourcePath, dstName, dstPath, overwrite )
--Programmer: DrZweistein (LUA)
--Version: 2.0
--Date: 28.04.2017
--Function: copy file to another path
--Input:
--Output: --
-- -----------------------------
function copyFile(Source, Destination)
      local results = false

    local srcPath = Source
     
     PathExists = checkFile(srcPath)
    if ( PathExists < 0) then
        return nil  -- nil = source file not found
    end

    --copy the source file to the destination file
    local rfilePath = srcPath
    local wfilePath = Destination

    local rfh = io.open( rfilePath, "rb" )
    local wfh = io.open( wfilePath, "wb" )

    if not ( wfh ) then
        print( "writeFileName open error!" )
        return false
    else
        --read the file from 'system.ResourceDirectory' and write to the destination directory
        local data = rfh:read( "*a" )
        if not ( data ) then
            print( "read error!" )
            return false
        else
            if not ( wfh:write( data ) ) then
                print( "write error!" )
                return false
            end
        end
    end

    results = 2  -- 2 = file copied successfully!

    --clean up file handles
    rfh:close()
    wfh:close()

    return results
  
  end
--copy 'readme.txt' from the 'system.ResourceDirectory' to 'system.DocumentsDirectory'.



-- -----------------------------
--Name: function copyFilef( sourceName, sourcePath, dstName, dstPath, overwrite )
--Programmer: DrZweistein (LUA)
--Version: 2.0
--Date: 28.04.2017
--Function: copy file to another path
--Input:
--Output: --
-- -----------------------------
--
function copyFilef( sourceName, sourcePath, dstName, dstPath, overwrite )

    --check to see if destination file already exists
    if not ( overwrite ) then
        if ( fileLib.doesFileExist( dstName, dstPath ) ) then
            return 1  -- 1 = file already exists (don't overwrite)
        end
    end

copyFile( sourcePath..sourceName, dstPath..dstName)

end --copyFilef( sourceName, sourcePath, dstName, dstPath, overwrite )

--------------------------TESTING----------------------------------------------------------------
--To = "/Users/ls_pat/Desktop/Desktop/Software/Vrep Backup/Data/Post/"
--copi = "/Users/ls_pat/Desktop/Desktop/Software/Vrep Backup/Data/NC/"

--copyFilef( "readme.txt", copi, "readme.txt", To, true )
--copyFile( "/Users/ls_pat/Desktop/Desktop/Software/Vrep Backup/Data/NC/readme.txt","/Users/ls_pat/Desktop/Desktop/Software/Vrep Backup/Data/Post/lol.txt")
--createDir ("/Users/ls_pat/Desktop/Desktop/homo/Fucker/Data/")