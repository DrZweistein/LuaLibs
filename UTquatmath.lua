-- Quaternionen Library
-- Programmer: DrZweistein (LUA)
-- Version: 1.0
-- Date: 03_11_2014
-- How to use : Main functions are MultiAngles(a,b)
------------------------------------------------------------


PI = math.acos(0)*2
DEG = 180 / PI 


-- -----------------------------
--Name: function quatmulquat(p,q)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 14_08_2014
--Function: multi quaternions
--Input: p,q as table
--Output: out as table
-- -----------------------------
function quatmulquat(a,b)
  out={}
  output={}
  local p={}
  local q={}
  qaw=a[1]
  qax=a[2]
  qay=a[3]
  qaz=a[4]
  
  qbw=b[1]
  qbx=b[2]
  qby=b[3]
  qbz=b[4]
  
   out[1] =qaw*qbw - qax*qbx - qay*qby - qaz*qbz --W
   out[2] =qax*qbw + qaw*qbx + qay*qbz - qaz*qby --X
   out[3] =qaw*qby - qax*qbz + qay*qbw + qaz*qbx --Y
   out[4] =qaw*qbz + qax*qby - qay*qbx + qaz*qbw --Z
  
   output[1] = out[1]
   output[2] = out[2]
   output[3] = out[3]
   output[4] = out[4]
     -- out[1] = p[1] * q[1] - p[2] * q[2] - p[3] * q[3] - p[4] * q[4]
     -- out[2] = p[1] * q[2] + p[2] * q[1] + p[3] * q[4] - p[4] * q[3]
     -- out[3] = p[1] * q[3] - p[2] * q[4] + p[3] * q[1] + p[4] * q[2]
     -- out[4] = p[1] * q[4] + p[2] * q[3] - p[3] * q[2] + p[4] * q[1] 
  return output
end

-- -----------------------------
--Name: function rotaxis_from_quat(q)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 14_08_2014
--Function: multipli quaternions
--Input: p,q as table
--Output: out as table
-- -----------------------------
function rotaxis_from_quat(q)
axis={}

	phi = math.cos(q[1]) --- Hier noch umrechenen @Patrick 
    if (phi == 0.0) then
      axis[0] = axis[1] == 0.0 
      axis[2] = 1.0
    else 
      s = 1.0 / math.sin(phi)
    end
	axis[1] = s * q[2]
	axis[2] = s * q[3]
	axis[3] = s * q[4]
	phi = 2.0
	angle = phi
  return angle, axis
end


-- -----------------------------
--Name: function rotaxis_from_quat(q)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 14_08_2014
--Function: multipli quaternions
--Input: axis
--Output: out as table
-- -----------------------------
function quat_from_rotaxis(axis,angle)
	phi = math.rad(angle)/2
  out = {}
	s = math.sin(phi)
	out[1] = math.cos(phi);
	out[2] = axis[1] * s
	out[3] = axis[2] * s
	out[4] = axis[3] * s
  return out
end
-- -----------------------------
--Name: function quat_from_euler(eul)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 15_08_2014
--Function: Euler in Quaternions Rule => Rzxy
--Input: eul
--Output: out as table
--more checked @patrick
-- -----------------------------
function quat_from_euler(eul)

  out = {}
	local x = ((eul[1])*PI/180) / 2
  local cx = math.cos(x)
  local sx = math.sin(x)
	local y = ((eul[2])*PI/180) / 2
  local cy = math.cos(y)
  local sy = math.sin(y)
	local z = ((eul[3])*PI/180) / 2
  local cz = math.cos(z)
  local sz = math.sin(z)

	--out[1] = cx * cy * cz - sx * sy * sz -- W
	--out[3] = sx * cy * cz + cx * sy * sz -- X  Y
	--out[4] = cx * sy * cz - sx * cy * sz -- Y  Z
	--out[2] = sx * sy * cz + cx * cy * sz -- Z  X
  
  local cxcy = cx*cy
	local sxsy = sx*sy
	out[1] = cxcy*cz - sxsy*sz
	out[2] = cxcy*sz + sxsy*cz
	out[3] = sx*cy*cz + cx*sy*sz
	out[4] = cx*sy*cz - sx*cy*sz
	--angle = 2 * math.acos(out[1]);
  
  
	--norm = out[1]*out[1]+out[2]*out[2]+out[3]*out[3] -- = 1
	--if (norm < 0.001) then  --when all euler angles are zero angle =0 so
                         --we can set axis to anything to avoid divide by zero
		--out[1]=1
		--out[2]=out[3]==0
	
  
  --else 
	--	norm = math.sqrt(norm)
  --  	out[1] = out[1]/norm
  --  	out[2] = out[2]/norm
  --  	out[3] = out[3]/norm
	
  --end
  return out
end

-- -----------------------------
--Name: function euler_from_quat(q)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 15_08_2014
--Function: multipli quaternions
--Input: q
--Output: out as table
-- -----------------------------
function euler_from_quat(q)
out={}
	
local check = (q[2]*q[3] + q[4]*q[1])  
local sqw = q[1]*q[1]
local sqx = q[2]*q[2]
local sqy = q[3]*q[3]
local sqz = q[4]*q[4]  
local unit = sqx + sqy + sqz + sqw
	if (check > 0.499*unit) then
    --singularity at north pole
		out[1] = 2 * math.atan2(q[2],q[4])
		out[2] = math.pi/2
		out[3] = 0
	end
	if (check < 0.499*unit) then
    --singularity at north pole
		out[1] = -2 * math.atan2(q[2],q[4])
		out[2] = -math.pi/2
		out[3] = 0
	end

out[1]= math.atan2((2*(q[3]*q[1])-2*(q[2]*q[4])) , (1 - 2*sqy - 2*sqz))
out[2]= math.asin(2*check/unit)
out[3]= math.atan2((2*q[2]*q[1]-2*q[3]*q[4]) , (1 - 2*sqx - 2*sqz))
return out

end

-- -----------------------------
--Name: function MultiAngles(a,b)
--Programmer: DrZweistein (LUA)
--Version: 1.0
--Date: 03_11_2014
--Function: multipli quaternions
--Input: a,b as tabel x y z
--Output: MultiAnglesOutRad as table in Rad / MultiAnglesOutDeg as table in Deg
-- -----------------------------

function MultiAngles(a,b)

--in quaternions
quat_from_euler(a)
local cout=out
quat_from_euler(b)
local dout=out
-- Multipi quats
quatmulquat(cout,dout)
local qout=out
--back in euler
euler_from_quat(qout) 
MultiAnglesOutRad = out
MultiAnglesOutDeg = {}
--Convert in Deg

  for i=1,3,1 do
    MultiAnglesOutDeg[i] = MultiAnglesOutRad[i] * DEG 
  end

return MultiAnglesOutRad, MultiAnglesOutDeg

end 

