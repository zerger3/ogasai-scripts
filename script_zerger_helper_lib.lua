script_zerger_helper_lib = {
 clicksTable = {},
 checkTime = 0,
 numNodes = 0,
}
--drawline: normal drawLline with worldToScreen check
--drawLineInfront/left/right: draws a line that is 'magnitude' long from the players xyz 
--drawLineInfrontAllObjects: magnitude = length of the line (if 0 then it is aggrorange), onlymoving: true or false
--drawAggroCircles: draws aggro circles around mobs
--playerCoord: my_x, my_y, my_z, my_angle
--targetCoord()
--Mobjecttable: table with: coords, aggro range, GUID, angle, speed, maxspeed, name 
--DrawCircles: circle with the paramter pointX,pointY,pointZ,radius, redVar, greenVar, blueVar, lineThickness, quality
--worldClickFlags: draws stuff into the world where you clicked, uncomment what you want (drawline, whitecane etc)

function script_zerger_helper_lib:drawLine(x1,y1,z1,x2,y2,z2,color)
	if color == nil then r =66; g= 223;b = 244 end;
	
	if color == red then r =244; g= 66;b = 66 end; 	
	if color == blue then r =66; g= 78;b = 244 end; 
	if color == green then r =66; g= 244;b = 78 end;
	if color == yellow then r =244; g= 229;b = 66 end;	
	
	if color == orange then r =244; g= 146;b = 66 end;
	if color == lightblue then r =66; g= 229;b = 244 end;
	if color == pink then r =244; g= 66;b = 229 end;
	
	local x1, y1, onScreen1 = WorldToScreen(x1, y1, z1)
	local x2, y2, onScreen2 = WorldToScreen(x2, y2, z2)
	if onScreen1 and onScreen2 then
		DrawLine(x1, y1, x2, y2, r, g, b, 2)
	end
end

	
function script_zerger_helper_lib:drawText(text,x,y,color)
	if color == nil then r =66; g= 223;b = 244 end 
	if color == color then r =66; g= 223;b = 244 end 
	
	if color == red then r =244; g= 66;b = 66 end; 	
	if color == blue then r =66; g= 78;b = 244 end; 
	if color == green then r =66; g= 244;b = 78 end;
	if color == yellow then r =244; g= 229;b = 66 end;	
	
	if color == orange then r =244; g= 146;b = 66 end;
	if color == lightblue then r =66; g= 229;b = 244 end;
	if color == pink then r =244; g= 66;b = 229 end;
	DrawText(text,x, y, r, g, b)
end



function script_zerger_helper_lib:drawLineInfront(magnitude)
	local x = GetLocalPlayer()
	local my_x, my_y, my_z = x:GetPosition();
	local my_angle = x:GetAngle()

	-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
	local x_to_add = magnitude*math.cos(my_angle)
	local y_to_add = magnitude*math.sin(my_angle)
	local infront_x = my_x + x_to_add
	local infront_y = my_y + y_to_add
	
	local x1, y1, onScreen1 = WorldToScreen(infront_x, infront_y, my_z)
	local x2, y2, onScreen2 = WorldToScreen(my_x, my_y, my_z)
	DrawLine(x1, y1, x2, y2, 200, 200, 200, 5)
	--draw coord
	DrawText(' ' .. floor(infront_x) .. '/' .. floor(infront_y)  .. '/' .. floor(my_z) .. ' '.. magnitude .. 'yard away', x1, y1, 200, 200, 200)
end

function script_zerger_helper_lib:drawLineRight(magnitude)
	local x = GetLocalPlayer()
	local my_x, my_y, my_z = x:GetPosition();
	local my_angle = x:GetAngle()
	local my_angle = my_angle - math.pi/2 -- my angle - 90°
	
	-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
	local x_to_add = magnitude*math.cos(my_angle)
	local y_to_add = magnitude*math.sin(my_angle)
	local right_x = my_x + x_to_add
	local right_y = my_y + y_to_add
	
	local x1, y1, onScreen1 = WorldToScreen(right_x, right_y, my_z)
	local x2, y2, onScreen2 = WorldToScreen(my_x, my_y, my_z)
	DrawLine(x1, y1, x2, y2, 200, 200, 200, 5)
	--draw coord
	DrawText(' ' .. floor(right_x) .. '/' .. floor(right_y)  .. '/' .. floor(my_z) .. ' '.. magnitude .. 'yard away', x1, y1, 200, 200, 200)
end

function script_zerger_helper_lib:drawLineLeft(magnitude)
	local x = GetLocalPlayer()
	local my_x, my_y, my_z = x:GetPosition();
	local my_angle = x:GetAngle()
	local my_angle = my_angle + math.pi/2 -- my angle + 90°
	
	-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
	local x_to_add = magnitude*math.cos(my_angle)
	local y_to_add = magnitude*math.sin(my_angle)
	local left_x = my_x + x_to_add
	local left_y = my_y + y_to_add
	
	local x1, y1, onScreen1 = WorldToScreen(left_x, left_y, my_z)
	local x2, y2, onScreen2 = WorldToScreen(my_x, my_y, my_z)
	DrawLine(x1, y1, x2, y2, 200, 200, 200, 5)
	--draw coord
	DrawText(' ' .. floor(left_x) .. '/' .. floor(left_y)  .. '/' .. floor(my_z) .. ' '.. magnitude .. 'yard away', x1, y1, 200, 200, 200)
end

function script_zerger_helper_lib:drawLineInfrontTarget(magnitude)
	local x = GetTarget()
	ToConsole(x)
	if x ~= nil and x ~= 0 then -- if we have a target 
		local target_x, target_y, target_z = x:GetPosition();
		local target_angle = x:GetAngle()

		-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
		local x_to_add = magnitude*math.cos(target_angle)
		local y_to_add = magnitude*math.sin(target_angle)
		local infront_x = target_x + x_to_add
		local infront_y = target_y + y_to_add
		
		local x1, y1, onScreen1 = WorldToScreen(infront_x, infront_y, target_z)
		local x2, y2, onScreen2 = WorldToScreen(target_x, target_y, target_z)
		if onScreen1 and onScreen2 then
			DrawLine(x1, y1, x2, y2, 244, 66, 66, 5)
		end
		--draw coord if you want
		--DrawText(' ' .. floor(infront_x) .. '/' .. floor(infront_y)  .. '/' .. floor(target_z) .. ' '.. magnitude .. 'yard away', x1, y1, 200, 200, 200)
	end	
end

function script_zerger_helper_lib:drawLineInfrontAllObjects(magnitude,onlymoving)

	script_zerger_helper_lib:mobjectTable();	
	
	--only moving
	if onlymoving == true then
		for i,v in pairs(objectTable) do
		if magnitude == 0 then
			magnitude = v.r
		end
		-- DRAW lines
			if 	v.type == 3	and i:CanAttack() == true and	i:IsDead() == false and i:IsCritter() == false and v.speed > 0 then		
				local x_to_add = magnitude*math.cos(v.angle)
				local y_to_add = magnitude*math.sin(v.angle)
				local infront_x = v.x + x_to_add
				local infront_y = v.y + y_to_add

				local x1, y1, onScreen1 = WorldToScreen(infront_x, infront_y, v.z)
				local x2, y2, onScreen2 = WorldToScreen(v.x, v.y, v.z)
				if onScreen1 and onScreen2 then
					DrawLine(x1, y1, x2, y2, 244, 66, 66, 2)
				end	
			end
		end
	else -- if onlymoving false
		for i,v in pairs(objectTable) do
		if magnitude == 0 then
			magnitude = v.r
		end
			-- DRAW lines
				if 	v.type == 3	and i:CanAttack() == true and	i:IsDead() == false and i:IsCritter() == false then		
					local x_to_add = magnitude*math.cos(v.angle)
					local y_to_add = magnitude*math.sin(v.angle)
					local infront_x = v.x + x_to_add
					local infront_y = v.y + y_to_add

					local x1, y1, onScreen1 = WorldToScreen(infront_x, infront_y, v.z)
					local x2, y2, onScreen2 = WorldToScreen(v.x, v.y, v.z)
					if onScreen1 and onScreen2 then
						DrawLine(x1, y1, x2, y2, 244, 66, 66, 2)
					end	
				end
			end
	end
end

function script_zerger_helper_lib:playerCoord()
	local localObj = GetLocalPlayer();
	local my_x, my_y, my_z = localObj:GetPosition();
	local my_angle = localObj:GetAngle();
	return my_x, my_y, my_z, my_angle
end

function script_zerger_helper_lib:targetCoord()
	local tarObj = GetTarget();
	local tar_x, tar_y, tar_z = tarObj:GetPosition();
	local tar_angle = tarObj:GetAngle();
	return tar_x, tar_y, tar_z, tar_angle
end



function script_zerger_helper_lib:mobjectTable()
	-- thx benjamin
	local me = GetLocalPlayer();
	objectTable = {};
	local obj_, type_ = GetFirstObject();
	while obj_ ~= 0 do
		if type_ == 3 or type_ == 4 then --- 3 is unit and 4 is player
			local objX, objY, objZ = obj_:GetPosition();
			-- objR is mob aggro range, i tested it  and it is at least 6 and maximum 46, on same lvl its 21
			local objR = obj_:GetLevel() - me:GetLevel() + 21
			if objR > 46 then objR = 46 end;
			if objR < 6 then objR = 6 end;
			local objGUID = obj_:GetGUID();
			local obj_angle = obj_:GetAngle();
			local obj_speed, obj_maxspeed  = obj_:GetSpeed();
			local objName = obj_:GetUnitName();
			objectTable[obj_] = {x = objX, y = objY, z = objZ, type = type_, r = objR, GUID = objGUID, name = objName, angle = obj_angle, speed = obj_speed, maxspeed = obj_maxspeed};
		end
		obj_, type_ = GetNextObject(obj_);
	end
end


function script_zerger_helper_lib:drawAggroCircles()
	script_zerger_helper_lib:mobjectTable()	
	for i,v in pairs(objectTable) do
	-- DRAW CIRCLES AROUND MOBS (AGGRO RANGE)
		if 
			v.type == 3
		and i:CanAttack() == true
		and	i:IsDead()  == false
			and i:IsCritter() == false 
			then
				script_zerger_helper_lib:DrawCircles(v.x,v.y,v.z,v.r, 255, 255, 0, 1, 30)
		end
	end
end


function script_zerger_helper_lib:DrawCircles(pointX,pointY,pointZ,radius, redVar, greenVar, blueVar, lineThickness, quality)
	-- thx benjamin
	local r = 255;
	local g = 2;
	local b = 233;
	-- position
	local x = 25;

	-- we will go by radians, not degrees
	local sqrt, sin, cos, PI, theta, points, point = math.sqrt, math.sin, math.cos,math.pi, 0, {}, 0;
	while theta <= 2*PI do
		point = point + 1 -- get next table slot, starts at 0 
		points[point] = { x = pointX + radius*cos(theta), y = pointY + radius*sin(theta) }
		theta = theta + 2*PI / quality -- get next theta
	end
	for i = 1, point do
		local firstPoint = i
		local secondPoint = i + 1
		if firstPoint == point then
			secondPoint = 1
		end
		if points[firstPoint] and points[secondPoint] then
			local x1, y1, onScreen1 = WorldToScreen(points[firstPoint].x, points[firstPoint].y, pointZ)
			
			local x2, y2, onScreen2 = WorldToScreen(points[secondPoint].x, points[secondPoint].y, pointZ)
			-- make boolean string so i can post it to console
			onScreen1String = tostring(onScreen1);
			
			--ToConsole('x1 inside draw cirlces: ' .. x1 .. 'onScreen1: ' .. onScreen1String .. y1 .. x2 .. y2 .. redVar .. greenVar .. blueVar .. lineThickness);
			if onScreen1 == true and onScreen2 == true then
				DrawLine(x1, y1, x2, y2, redVar, greenVar, blueVar, lineThickness)
				
			end
		end
	end
end

function script_zerger_helper_lib:worldClickFlags()
	--todo get clicksTable to current script to save xyz

	if self.checkTime <= GetTimeEX() then 
		GetTerrainClick_x, GetTerrainClick_y, GetTerrainClick_z, GetTerrainClick_time = GetTerrainClick()
		--ToConsole(GetTimeEX()..' +300')
		self.checkTime = GetTimeEX() + 300
		if GetTerrainClick_time ~= GetTerrainClick_time2 then
			--ToConsole('times have changed')
			self.numNodes = self.numNodes +1 
			self.clicksTable[self.numNodes] = {x = GetTerrainClick_x, y = GetTerrainClick_y, z = GetTerrainClick_z};
		end
		
		GetTerrainClick_time2 = GetTerrainClick_time
	end	
	
	for i,v in pairs(self.clicksTable) do -- DRAW lines
		local x1, y1, onScreen1 = WorldToScreen(v.x, v.y, v.z)
		local x2, y2, onScreen2 = WorldToScreen(v.x, v.y, v.z+5)
		if onScreen1 and onScreen2 then
			DrawLine(x1, y1, x2, y2, 244, 185, 66, 2)
			DrawText(' ' .. floor(v.x) .. '/' .. floor(v.y)  .. '/' .. floor(v.z), x2, y2, 200, 200, 200)
			script_zerger_helper_lib:DrawCircles(v.x,v.y,v.z,1, 65, 244, 196, 2, 8)
		
		end	
	end
	
	--https://stackoverflow.com/questions/31452871/table-getn-is-deprecated-how-can-i-get-the-length-of-an-array
    local count = 0
    for _, __ in pairs(self.clicksTable) do
        count = count + 1
    end
	DEFAULT_CHAT_FRAME:AddMessage('Number of clickNodes: ' ..count);
	
	--ToConsole('clear')
	-- run collWhiteCane between flags :D
	if count > 1 then
		for i,v in pairs(self.clicksTable) do -- DRAW lines
	
		 local x2 = self.clicksTable[i+1].x 
		 local y2 = self.clicksTable[i+1].y 
		 local z2 = self.clicksTable[i+1].z 
		 --script_zerger_helper_lib:drawLine2(v.x,v.y,v.z,x2,y2,z2)
		 --script_zerger_raycast_lib:whiteCane(v.x,v.y,v.z,x2,y2)
		--script_zerger_raycast_lib:collWhiteCane(v.x,v.y,v.z,x2,y2)
		end
	end

	--[[
	add this into the menu part if you want to save them to text file:
	
	if (CollapsingHeader("click flags - Options ")) then
	Text("save all flags to log file");
		if (Button("save")) then
			
				DEFAULT_CHAT_FRAME:AddMessage('saved');
				
				for i,v in pairs(self.clicksTable) do -- DRAW lines
					ToFile('x: ' .. v.x .. ', '.. 'y: ' .. v.y .. ', ' .. 'z: ' .. v.z .. ', ')
				end	
		end SameLine();
	end
	
	--]]


end




