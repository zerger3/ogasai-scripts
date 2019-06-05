script_zerger_raycast_lib = {

}
-- h: 2.4379999637604, w: 0.77780002355576, s: 1, f: 4 nelf male
--  assumed collision for all races: Height 2.50 width 0.8, jump height  1.6
-- todo adjust doors for collision data
-- min distance between vertical raycasts: 0.1 (fences, signs, torches are detected)
-- walkable incline 0.115

function script_zerger_raycast_lib:myZupwards()
	-- size of the collision box? adjsut values
	local x, y, z, a = script_zerger_helper_lib:playerCoord()
	
	local _isVis, _hx, _hy, _hz = Raycast(x, y+0.4, z+1, x, y+0.4, z+100);
	--translates cyz of 3d into xy of 2d
	local x1, y1, onScreen1 = WorldToScreen(x, y+0.4, z)
	local x2, y2, onScreen2 = WorldToScreen(x, y+0.4, z+3)
	if onScreen1 then
		DrawLine(x1, y1, x2, y2, 200, 200, 200, 5)
	end
	ToConsole('my head colides at: ' .. _hz)
	ToConsole('my feet are at: ' .. z)
	ToConsole('so i must be at least: ' .. _hz-z .. ' yards tall')  
end



function script_zerger_raycast_lib:door()
	local my_x, my_y, my_z, my_angle = script_zerger_helper_lib:playerCoord()
	local distance_to_player_xyz = 2 -- eg 3 yards infront of the player
	local magnitude = 2.5 --magnitude of line/raycast

	--middle ray
	-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
	local x_to_add = distance_to_player_xyz*math.cos(my_angle)
	local y_to_add = distance_to_player_xyz*math.sin(my_angle)
	distant_to_playerxyz_x = my_x + x_to_add
	distant_to_playerxyz_y = my_y + y_to_add
script_zerger_helper_lib:drawLine(distant_to_playerxyz_x,distant_to_playerxyz_y,my_z,distant_to_playerxyz_x,distant_to_playerxyz_y,my_z+magnitude)
	local middle_isVis, _hx, _hy, _hz = Raycast(distant_to_playerxyz_x, distant_to_playerxyz_y, my_z, distant_to_playerxyz_x, distant_to_playerxyz_y, my_z+magnitude);
	
	--+++++++++++++++++++++++++++++++++++++++++++++++++++++++
	
	-- left ray
	local distance = 0.4 -- to the middle ray
	local magnitude = 2.5
	local angle = my_angle+math.pi/2 -- 90°to left
	-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
	local x_to_add = distance*math.cos(angle)
	local y_to_add = distance*math.sin(angle)
	left_distant_x = distant_to_playerxyz_x + x_to_add
	left_distant_y = distant_to_playerxyz_y + y_to_add
script_zerger_helper_lib:drawLine(left_distant_x,left_distant_y,my_z,left_distant_x,left_distant_y,my_z+magnitude)
	local left_isVis, _hx, _hy, _hz = Raycast(left_distant_x, left_distant_y, my_z, left_distant_x, left_distant_y, my_z+magnitude);
	
	--+++++++++++++++++++++++++++++++++++++++++++++++++++++++
	
	-- right ray
	local distance = 0.4 -- to the middle ray
	local magnitude = 2.5
	local angle = my_angle-math.pi/2 -- 90°to right
	
	-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
	local x_to_add = distance*math.cos(angle)
	local y_to_add = distance*math.sin(angle)
	right_distant_x = distant_to_playerxyz_x + x_to_add
	right_distant_y = distant_to_playerxyz_y + y_to_add
script_zerger_helper_lib:drawLine(right_distant_x,right_distant_y,my_z,right_distant_x,right_distant_y,my_z+magnitude)
	local right_isVis, _hx, _hy, _hz = Raycast(right_distant_x,right_distant_y,my_z,right_distant_x,right_distant_y,my_z+magnitude);
	
	--+++++++++++++++++++++++++++++++++++++++++++++++++++++++
	
	-- top ray
	script_zerger_helper_lib:drawLine(left_distant_x,left_distant_y,my_z+magnitude,right_distant_x,right_distant_y,my_z+magnitude)
	local top_isVis, _hx, _hy, _hz = Raycast(left_distant_x,left_distant_y,my_z+magnitude,right_distant_x,right_distant_y,my_z+magnitude);
	

	-- jump ray jump heoight at 1.6
	script_zerger_helper_lib:drawLine(left_distant_x,left_distant_y,my_z+1.6,right_distant_x,right_distant_y,my_z+1.6)
	local jump_isVis, _hx, _hy, top_hz = Raycast(left_distant_x,left_distant_y,my_z+1.6,right_distant_x,right_distant_y,my_z+1.6);
	
	-- bottom ray
	script_zerger_helper_lib:drawLine(left_distant_x,left_distant_y,my_z+1,right_distant_x,right_distant_y,my_z+1)
	 bottom_isVis, _hx, _hy, top_hz = Raycast(left_distant_x,left_distant_y,my_z+1,right_distant_x,right_distant_y,my_z+1);
	
	ToConsole(tostring(middle_isVis)..tostring(left_isVis)..tostring(right_isVis)..tostring(top_isVis)..tostring(jump_isVis)..tostring(bottom_isVis))
	return bottom_isVis;
end	

function script_zerger_raycast_lib:playerDoorsTo()
	--todo write func :D
	for i = 1,500 do
		local my_x, my_y, my_z, my_angle = script_zerger_helper_lib:playerCoord()
		local distance_to_player_xyz = 2+i*0.05 -- eg 3 yards infront of the player
		local magnitude = 2.5 --magnitude of line/raycast

		--middle ray
		-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
		local x_to_add = distance_to_player_xyz*math.cos(my_angle)
		local y_to_add = distance_to_player_xyz*math.sin(my_angle)
		distant_to_playerxyz_x = my_x + x_to_add
		distant_to_playerxyz_y = my_y + y_to_add
	script_zerger_helper_lib:drawLine(distant_to_playerxyz_x,distant_to_playerxyz_y,my_z,distant_to_playerxyz_x,distant_to_playerxyz_y,my_z+magnitude)
		local middle_isVis, _hx, _hy, _hz = Raycast(distant_to_playerxyz_x, distant_to_playerxyz_y, my_z, distant_to_playerxyz_x, distant_to_playerxyz_y, my_z+magnitude);
		
		--+++++++++++++++++++++++++++++++++++++++++++++++++++++++
		
		-- left ray
		local distance = 0.5 -- to the middle ray
		local magnitude = 2.5
		local angle = my_angle+math.pi/2 -- 90°to left
		-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
		local x_to_add = distance*math.cos(angle)
		local y_to_add = distance*math.sin(angle)
		left_distant_x = distant_to_playerxyz_x + x_to_add
		left_distant_y = distant_to_playerxyz_y + y_to_add
	script_zerger_helper_lib:drawLine(left_distant_x,left_distant_y,my_z,left_distant_x,left_distant_y,my_z+magnitude)
		local left_isVis, _hx, _hy, _hz = Raycast(left_distant_x, left_distant_y, my_z, left_distant_x, left_distant_y, my_z+magnitude);
		
		--+++++++++++++++++++++++++++++++++++++++++++++++++++++++
		
		-- right ray
		local distance = 0.5 -- to the middle ray
		local magnitude = 2.5
		local angle = my_angle-math.pi/2 -- 90°to right
		
		-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
		local x_to_add = distance*math.cos(angle)
		local y_to_add = distance*math.sin(angle)
		right_distant_x = distant_to_playerxyz_x + x_to_add
		right_distant_y = distant_to_playerxyz_y + y_to_add
	script_zerger_helper_lib:drawLine(right_distant_x,right_distant_y,my_z,right_distant_x,right_distant_y,my_z+magnitude)
		local right_isVis, _hx, _hy, _hz = Raycast(right_distant_x,right_distant_y,my_z,right_distant_x,right_distant_y,my_z+magnitude);
		
		--+++++++++++++++++++++++++++++++++++++++++++++++++++++++
		
		-- top ray
		script_zerger_helper_lib:drawLine(left_distant_x,left_distant_y,my_z+magnitude,right_distant_x,right_distant_y,my_z+magnitude)
		local top_isVis, _hx, _hy, _hz = Raycast(left_distant_x,left_distant_y,my_z+magnitude,right_distant_x,right_distant_y,my_z+magnitude);
		
		-- mid ray
		script_zerger_helper_lib:drawLine(left_distant_x,left_distant_y,my_z+magnitude/2,right_distant_x,right_distant_y,my_z+magnitude/2)
		local mid_isVis, _hx, _hy, _hz = Raycast(left_distant_x,left_distant_y,my_z+magnitude/2,right_distant_x,right_distant_y,my_z+magnitude/2);
		
		-- jump ray
		script_zerger_helper_lib:drawLine(left_distant_x,left_distant_y,my_z+magnitude/3,right_distant_x,right_distant_y,my_z+magnitude/3)
		local jump_isVis, _hx, _hy, top_hz = Raycast(left_distant_x,left_distant_y,my_z+magnitude/3,right_distant_x,right_distant_y,my_z+magnitude/3);
		
		-- bottom ray
		script_zerger_helper_lib:drawLine(left_distant_x,left_distant_y,my_z,right_distant_x,right_distant_y,my_z)
		local bottom_isVis, _hx, _hy, top_hz = Raycast(left_distant_x,left_distant_y,my_z,right_distant_x,right_distant_y,my_z);
		
		--ToConsole(tostring(middle_isVis)..tostring(left_isVis)..tostring(right_isVis)..tostring(top_isVis)..tostring(mid_isVis)..tostring(jump_isVis)..tostring(bottom_isVis))
	end	
end	

function script_zerger_raycast_lib:doorsFromAtoB(x1,y1,z1,x2,y2,z2)
	for i = 1,500 do --todo make from A not my 
		local my_x, my_y, my_z, my_angle = script_zerger_helper_lib:playerCoord()
		local distance_to_player_xyz = 2+i*0.05 -- eg 3 yards infront of the player
		local magnitude = 2.5 --magnitude of line/raycast

		--middle ray
		-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
		local x_to_add = x2
		local y_to_add = y2
		distant_to_originxyz_x = x1 + x_to_add
		distant_to_originxyz_y = y1 + y_to_add
	script_zerger_helper_lib:drawLine(distant_to_originxyz_x,distant_to_originxyz_y,my_z,distant_to_originxyz_x,distant_to_originxyz_y,my_z+magnitude)
		local middle_isVis, _hx, _hy, _hz = Raycast(distant_to_originxyz_x, distant_to_originxyz_y, my_z, distant_to_originxyz_x, distant_to_originxyz_y, my_z+magnitude);
		
		--+++++++++++++++++++++++++++++++++++++++++++++++++++++++
		
		-- left ray
		local distance = 0.5 -- to the middle ray
		local magnitude = 2.5
		local angle = my_angle+math.pi/2 -- 90°to left
		-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
		local x_to_add = distance*math.cos(angle)
		local y_to_add = distance*math.sin(angle)
		left_distant_x = distant_to_originxyz_x + x_to_add
		left_distant_y = distant_to_originxyz_y + y_to_add
	script_zerger_helper_lib:drawLine(left_distant_x,left_distant_y,my_z,left_distant_x,left_distant_y,my_z+magnitude)
		local left_isVis, _hx, _hy, _hz = Raycast(left_distant_x, left_distant_y, my_z, left_distant_x, left_distant_y, my_z+magnitude);
		
		--+++++++++++++++++++++++++++++++++++++++++++++++++++++++
		
		-- right ray
		local distance = 0.5 -- to the middle ray
		local magnitude = 2.5
		local angle = my_angle-math.pi/2 -- 90°to right
		
		-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
		local x_to_add = distance*math.cos(angle)
		local y_to_add = distance*math.sin(angle)
		right_distant_x = distant_to_originxyz_x + x_to_add
		right_distant_y = distant_to_originxyz_y + y_to_add
	script_zerger_helper_lib:drawLine(right_distant_x,right_distant_y,my_z,right_distant_x,right_distant_y,my_z+magnitude)
		local right_isVis, _hx, _hy, _hz = Raycast(right_distant_x,right_distant_y,my_z,right_distant_x,right_distant_y,my_z+magnitude);
		
		--+++++++++++++++++++++++++++++++++++++++++++++++++++++++
		
		-- top ray
		script_zerger_helper_lib:drawLine(left_distant_x,left_distant_y,my_z+magnitude,right_distant_x,right_distant_y,my_z+magnitude)
		local top_isVis, _hx, _hy, _hz = Raycast(left_distant_x,left_distant_y,my_z+magnitude,right_distant_x,right_distant_y,my_z+magnitude);
		
		-- mid ray
		script_zerger_helper_lib:drawLine(left_distant_x,left_distant_y,my_z+magnitude/2,right_distant_x,right_distant_y,my_z+magnitude/2)
		local mid_isVis, _hx, _hy, _hz = Raycast(left_distant_x,left_distant_y,my_z+magnitude/2,right_distant_x,right_distant_y,my_z+magnitude/2);
		
		-- jump ray
		script_zerger_helper_lib:drawLine(left_distant_x,left_distant_y,my_z+magnitude/3,right_distant_x,right_distant_y,my_z+magnitude/3)
		local jump_isVis, _hx, _hy, top_hz = Raycast(left_distant_x,left_distant_y,my_z+magnitude/3,right_distant_x,right_distant_y,my_z+magnitude/3);
		
		-- bottom ray
		script_zerger_helper_lib:drawLine(left_distant_x,left_distant_y,my_z,right_distant_x,right_distant_y,my_z)
		local bottom_isVis, _hx, _hy, top_hz = Raycast(left_distant_x,left_distant_y,my_z,right_distant_x,right_distant_y,my_z);
		
		--ToConsole(tostring(middle_isVis)..tostring(left_isVis)..tostring(right_isVis)..tostring(top_isVis)..tostring(mid_isVis)..tostring(jump_isVis)..tostring(bottom_isVis))
	end	
end	

function script_zerger_raycast_lib:myWhiteCane(white_cane_length)

	local my_x, my_y, my_z, my_angle = script_zerger_helper_lib:playerCoord()
	

	-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
	local x_to_add = white_cane_length*math.cos(my_angle)
	local y_to_add = white_cane_length*math.sin(my_angle)
	ten_yard_infront_x = my_x + x_to_add
	ten_yard_infront_y = my_y + y_to_add

	local x1 = my_x
	local y1 = my_y
	local x2 = ten_yard_infront_x
	local y2 = ten_yard_infront_y
	-- vector
	vector_x = x2-x1
	vector_y = y2-y1
	-- vector magnitude
	vectorMagnitude = math.sqrt(vector_x^2+vector_y^2)
	--unit vector
	unitVector_x = 1/vectorMagnitude*vector_x
	unitVector_y = 1/vectorMagnitude*vector_y
	
	-- table with xyz of all points between x1y1 and x2y2 with the distance of unitVector
	allXYZbetweenTwoPoints = {};

	for i= 1, math.floor((white_cane_length)*10),1 do --maximum needs to be a whole number

		local point_x = x1 + (unitVector_x*i*0.1);
		local point_y = y1 + (unitVector_y*i*0.1);
		local isVis, _hx, _hy, _hz = Raycast(point_x, point_y, my_z+3, point_x, point_y, my_z-2);
		script_zerger_helper_lib:drawLine(point_x, point_y, _hz+3, point_x, point_y, _hz)
		allXYZbetweenTwoPoints[i] = {x = point_x, y = point_y, z = _hz};

	end

	for k,v in ipairs(allXYZbetweenTwoPoints) do
		if k>1 then 
			DEFAULT_CHAT_FRAME:AddMessage((abs(v.z-allXYZbetweenTwoPoints[k-1].z)))
		end
	end
	DEFAULT_CHAT_FRAME:AddMessage('end of run');
	ToConsole('end of run');
end

function script_zerger_raycast_lib:myCollWhiteCane()
	local white_cane_length = 1000
	local magnitude = 0.4 -- how far away from the center of our char the left and right canes should be
	
	-- calc left ray 
	local my_x, my_y, my_z, my_angle = script_zerger_helper_lib:playerCoord()
	local left_angle = my_angle + math.pi/2 -- my angle + 90°
	
	-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
	local x_to_add = magnitude*math.cos(left_angle)
	local y_to_add = magnitude*math.sin(left_angle)
	local left_x = my_x + x_to_add
	local left_y = my_y + y_to_add
	
	--------------
	--normal mywhitecane logic with new start point 
	
	
	-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
	local x_to_add = white_cane_length*math.cos(my_angle)
	local y_to_add = white_cane_length*math.sin(my_angle)
	ten_yard_infront_x = left_x + x_to_add
	ten_yard_infront_y = left_y + y_to_add

	local x1 = left_x
	local y1 = left_y
	local x2 = ten_yard_infront_x
	local y2 = ten_yard_infront_y
	-- vector
	vector_x = x2-x1
	vector_y = y2-y1
	-- vector magnitude
	vectorMagnitude = math.sqrt(vector_x^2+vector_y^2)
	--unit vector
	unitVector_x = 1/vectorMagnitude*vector_x
	unitVector_y = 1/vectorMagnitude*vector_y
	
	-- table with xyz of all points between x1y1 and x2y2 with the distance of unitVector
	allXYZbetweenTwoPoints = {};

	for i= 1, math.floor(vectorMagnitude*2),1 do --maximum needs to be a whole number

		local point_x = x1 + (unitVector_x*i*0.1);
		local point_y = y1 + (unitVector_y*i*0.1);
		local isVis, _hx, _hy, _hz = Raycast(point_x, point_y, my_z+10, point_x, point_y, my_z-1);
		script_zerger_helper_lib:drawLine(point_x, point_y, _hz+3, point_x, point_y, _hz)
		allXYZbetweenTwoPoints[i] = {x = point_x, y = point_y, z = _hz};

	end

	for k,v in ipairs(allXYZbetweenTwoPoints) do
		if k>1 then 
			--ToConsole(abs(v.z-allXYZbetweenTwoPoints[k-1].z))
		end
	end

	--ToConsole('end of run');
	
	--/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
	
	-- calc right ray 
	local my_x, my_y, my_z, my_angle = script_zerger_helper_lib:playerCoord()
	local left_angle = my_angle - math.pi/2 -- my angle - 90°
	
	-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
	local x_to_add = magnitude*math.cos(left_angle)
	local y_to_add = magnitude*math.sin(left_angle)
	local right_x = my_x + x_to_add
	local right_y = my_y + y_to_add
	
	--------------
	--normal whitecane logic with new start point 
	
	
	-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
	local x_to_add = white_cane_length*math.cos(my_angle)
	local y_to_add = white_cane_length*math.sin(my_angle)
	ten_yard_infront_x = right_x + x_to_add
	ten_yard_infront_y = right_y + y_to_add

	local x1 = right_x
	local y1 = right_y
	local x2 = ten_yard_infront_x
	local y2 = ten_yard_infront_y
	-- vector
	vector_x = x2-x1
	vector_y = y2-y1
	-- vector magnitude
	vectorMagnitude = math.sqrt(vector_x^2+vector_y^2)
	--unit vector
	unitVector_x = 1/vectorMagnitude*vector_x
	unitVector_y = 1/vectorMagnitude*vector_y
	
	-- table with xyz of all points between x1y1 and x2y2 with the distance of unitVector
	allXYZbetweenTwoPoints = {};

	for i= 1, math.floor(vectorMagnitude*2),1 do --maximum needs to be a whole number

		local point_x = x1 + (unitVector_x*i*0.1);
		local point_y = y1 + (unitVector_y*i*0.1);
		local isVis, _hx, _hy, _hz = Raycast(point_x, point_y, my_z+10, point_x, point_y, my_z-1);
		script_zerger_helper_lib:drawLine(point_x, point_y, _hz+3, point_x, point_y, _hz)
		allXYZbetweenTwoPoints[i] = {x = point_x, y = point_y, z = _hz};

	end

	for k,v in ipairs(allXYZbetweenTwoPoints) do
		if k>1 then 
			--ToConsole(abs(v.z-allXYZbetweenTwoPoints[k-1].z))
		end
	end

	--ToConsole('end of run');
	
	--/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
	
	-- normal center whitecane
	
	-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
	local x_to_add = white_cane_length*math.cos(my_angle)
	local y_to_add = white_cane_length*math.sin(my_angle)
	ten_yard_infront_x = my_x + x_to_add
	ten_yard_infront_y = my_y + y_to_add

	local x1 = my_x
	local y1 = my_y
	local x2 = ten_yard_infront_x
	local y2 = ten_yard_infront_y
	-- vector
	vector_x = x2-x1
	vector_y = y2-y1
	-- vector magnitude
	vectorMagnitude = math.sqrt(vector_x^2+vector_y^2)
	--unit vector
	unitVector_x = 1/vectorMagnitude*vector_x
	unitVector_y = 1/vectorMagnitude*vector_y
	
	-- table with xyz of all points between x1y1 and x2y2 with the distance of unitVector
	allXYZbetweenTwoPoints = {};

	for i= 1, math.floor(vectorMagnitude*2),1 do --maximum needs to be a whole number

		local point_x = x1 + (unitVector_x*i*0.1);
		local point_y = y1 + (unitVector_y*i*0.1);
		local isVis, _hx, _hy, _hz = Raycast(point_x, point_y, my_z+10, point_x, point_y, my_z-1);
		script_zerger_helper_lib:drawLine(point_x, point_y, _hz+3, point_x, point_y, _hz)
		allXYZbetweenTwoPoints[i] = {x = point_x, y = point_y, z = _hz};

	end

	for k,v in ipairs(allXYZbetweenTwoPoints) do
		if k>1 then 
		--	ToConsole(abs(v.z-allXYZbetweenTwoPoints[k-1].z))
		end
	end

	--ToConsole('end of run');
	
end



function script_zerger_raycast_lib:whiteCane(x1,y1,z1,x2,y2)

	-- vector
	vector_x = x2-x1
	vector_y = y2-y1
	-- vector magnitude
	vectorMagnitude = math.sqrt(vector_x^2+vector_y^2)
	ToConsole(vectorMagnitude)
	--unit vector
	unitVector_x = 1/vectorMagnitude*vector_x
	unitVector_y = 1/vectorMagnitude*vector_y
	
	-- table with xyz of all points between x1y1 and x2y2 with the distance of unitVector
	allXYZbetweenTwoPoints = {};
	
	-- i max needs a whole number
	local imax = ( math.floor(vectorMagnitude) +1) * 10
	ToConsole(imax)
	--we want to raycast every 0.1 yards for vectorMagnitude but NOT shorter than vectorMagnitude
	for i= 1, imax,1 do 

		local point_x = x1 + (unitVector_x*i*0.1);
		local point_y = y1 + (unitVector_y*i*0.1);
		local isVis, _hx, _hy, _hz = Raycast(point_x, point_y, z1+10, point_x, point_y, z1-10);
		script_zerger_helper_lib:drawLine(point_x, point_y, _hz+3, point_x, point_y, _hz)
		allXYZbetweenTwoPoints[i] = {x = point_x, y = point_y, z = _hz};

	end

	for k,v in ipairs(allXYZbetweenTwoPoints) do
		if k>1 then 
			ToConsole(abs(v.z-allXYZbetweenTwoPoints[k-1].z))
		end
	end

	ToConsole('end of run');
end



function script_zerger_raycast_lib:collWhiteCane(x1,y1,z1,x2,y2)
	
	local magnitude = 0.4 -- how far away from the center ray 
	
	-- calc left ray: 
	-- x1y1 to x2 y2 angle
	local start_angle,_m = script_zerger_math_lib:convertCartToPolar(x1,y1,x2,y2)
	local left_angle = start_angle + math.pi/2 -- start_angle + 90°
	
	-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
	local x_to_add = magnitude*math.cos(left_angle)
	local y_to_add = magnitude*math.sin(left_angle)
	local left_x1 = x1 + x_to_add
	local left_y1 = y1 + y_to_add
	local left_x2 = x2 + x_to_add
	local left_y2 = y2 + y_to_add
	
	--normal mywhitecane logic with new start point 

	-- vector
	vector_x = left_x2-left_x1
	vector_y = left_y2-left_y1
	-- vector magnitude
	vectorMagnitude = math.sqrt(vector_x^2+vector_y^2)
	--unit vector
	unitVector_x = 1/vectorMagnitude*vector_x
	unitVector_y = 1/vectorMagnitude*vector_y
	
	-- table with xyz of all points between x1y1 and x2y2 with the distance of unitVector
	allXYZbetweenTwoPoints = {};
	
	-- i max needs a whole number
	local imax = ( math.floor(vectorMagnitude) +1) * 10
	
	--we want to raycast every 0.1 yards for vectorMagnitude but NOT shorter than vectorMagnitude
	
	for i= 1, math.floor(imax),1 do --maximum needs to be a whole number

		local point_x = left_x1 + (unitVector_x*i*0.1);
		local point_y = left_y1 + (unitVector_y*i*0.1);
		local isVis, _hx, _hy, _hz = Raycast(point_x, point_y, z1+10, point_x, point_y, z1-10);
		script_zerger_helper_lib:drawLine(point_x, point_y, _hz+3, point_x, point_y, _hz)
		allXYZbetweenTwoPoints[i] = {x = point_x, y = point_y, z = _hz};

	end

	for k,v in ipairs(allXYZbetweenTwoPoints) do
		if k>1 then 
			--ToConsole(abs(v.z-allXYZbetweenTwoPoints[k-1].z))
		end
	end

	--ToConsole('end of run');
	
	--/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
	
	-- calc right ray:
	
	-- x1y1 to x2 y2 angle
	local start_angle,_m = script_zerger_math_lib:convertCartToPolar(x1,y1,x2,y2)
	
	
	local right_angle = start_angle - math.pi/2 -- start_angle - 90°
	
	-- convert Polar coordinate system to Cartesian_coordinate_system (make radian to xy)
	local x_to_add = magnitude*math.cos(right_angle)
	local y_to_add = magnitude*math.sin(right_angle)
	local right_x = x1 + x_to_add
	local right_y = y1 + y_to_add
	local right_x2 = x2 + x_to_add
	local right_y2 = y2 + y_to_add

	--normal whitecane logic 

	-- vector
	vector_x = right_x2-right_x
	vector_y = right_y2-right_y
	-- vector magnitude
	vectorMagnitude = math.sqrt(vector_x^2+vector_y^2)-- how long is the vector, ie: distance x1y1 to x2y2
	--unit vector
	unitVector_x = 1/vectorMagnitude*vector_x
	unitVector_y = 1/vectorMagnitude*vector_y
	
	-- table with xyz of all points between x1y1 and x2y2 with the distance of unitVector
	allXYZbetweenTwoPoints = {};
	
	-- i max needs a whole number
	local imax = ( math.floor(vectorMagnitude) +1) * 10

	--we want to raycast every 0.1 yards for vectorMagnitude but NOT shorter than vectorMagnitude
	
	for i= 1, math.floor(imax),1 do --maximum needs to be a whole number

		local point_x = right_x + (unitVector_x*i*0.1);
		local point_y = right_y + (unitVector_y*i*0.1);
		local isVis, _hx, _hy, _hz = Raycast(point_x, point_y, z1+10, point_x, point_y, z1-10);
		script_zerger_helper_lib:drawLine(point_x, point_y, _hz+3, point_x, point_y, _hz)
		allXYZbetweenTwoPoints[i] = {x = point_x, y = point_y, z = _hz};

	end

	for k,v in ipairs(allXYZbetweenTwoPoints) do
		if k>1 then 
			--ToConsole(abs(v.z-allXYZbetweenTwoPoints[k-1].z))
		end
	end

	--ToConsole('end of run');
	
	--/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
	
	-- normal center whitecane
	
	
	-- vector
	vector_x = x2-x1
	vector_y = y2-y1
	-- vector magnitude
	vectorMagnitude = math.sqrt(vector_x^2+vector_y^2)
	--ToConsole(vectorMagnitude)
	--unit vector
	unitVector_x = 1/vectorMagnitude*vector_x
	unitVector_y = 1/vectorMagnitude*vector_y
	
	-- table with xyz of all points between x1y1 and x2y2 with the distance of unitVector
	allXYZbetweenTwoPoints = {};
	
	-- i max needs a whole number
	local imax = ( math.floor(vectorMagnitude) +1) * 10
	
	--we want to raycast every 0.1 yards for vectorMagnitude but NOT shorter than vectorMagnitude
	for i= 1, imax,1 do 

		local point_x = x1 + (unitVector_x*i*0.1);
		local point_y = y1 + (unitVector_y*i*0.1);
		local isVis, _hx, _hy, _hz = Raycast(point_x, point_y, z1+10, point_x, point_y, z1-10);
		script_zerger_helper_lib:drawLine(point_x, point_y, _hz+3, point_x, point_y, _hz)
		allXYZbetweenTwoPoints[i] = {x = point_x, y = point_y, z = _hz};

	end

	for k,v in ipairs(allXYZbetweenTwoPoints) do
		if k>1 then 
			--ToConsole(abs(v.z-allXYZbetweenTwoPoints[k-1].z))
		end
	end

	--ToConsole('end of run');
	
end