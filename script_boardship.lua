script_boardship = {
   went_on_ship = false,
   just_left_ship = false,
   is_travel_done = false,
   sent_to_hopOnSpot = false 
}

--[[ we have these stepes while using the boat:
enter dock (area near ship)
go to baording spot (infront of ship)
board ship
go to center of ship
leave ship
leave dock
todo: do the check only if we are in "zone", randomize spots,timer so not all bots are move synchrone :d 
--]]

local function GetDistance2D(_1x, _1y, _2x, _2y)
	return math.sqrt((_1x - _2x)^2 + (_1y - _2y)^2)
end

function script_boardship:draw()    
--[[
	local localObj = GetLocalPlayer();
	local my_x, my_y, my_z = localObj:GetPosition();
	my_z =10
    	-- draw x axis + coord
	minus_my_x = my_x - 20
	plus_my_x  = my_x + 20
	local x1, y1, onScreen1 = WorldToScreen(minus_my_x, my_y, my_z)
	local x2, y2, onScreen2 = WorldToScreen(plus_my_x, my_y, my_z)
	DrawLine(x1, y1, x2, y2, 200, 200, 200, 5)
	--draw coord
	DrawText(' ' .. floor(minus_my_x) .. '/' .. floor(my_y) .. ' X-Axis', x1, y1, 200, 200, 200)
	DrawText(' ' .. floor(plus_my_x) .. '/' .. floor(my_y) .. ' X-Axis', x2, y2, 200, 200, 200)
	
	-- draw y axis + coord
	minus_my_y = my_y - 20
	plus_my_y  = my_y + 20
	local x1, y1, onScreen1 = WorldToScreen(my_x, minus_my_y, my_z)
	local x2, y2, onScreen2 = WorldToScreen(my_x, plus_my_y, my_z)
	DrawLine(x1, y1, x2, y2, 200, 200, 200, 5)
	--draw coord
	DrawText(' ' .. floor(my_x) .. '/' .. floor(minus_my_y) .. ' Y-Axis', x1, y1, 200, 200, 200)
	DrawText(' ' .. floor(my_x) .. '/' .. floor(plus_my_y) .. ' Y-Axis', x2, y2, 200, 200, 200)
	
	--minus_my_x my_y        my_x - minus_my_y
	--]]     
end

function script_boardship:run()
	PersistLoadingScreen(true)
	--+++++++++++++++++++++++++++++++ todo add mapid check
	--ToConsole('')
	local localObj = GetLocalPlayer();
	local my_x, my_y, my_z = localObj:GetPosition();
	--ToConsole(' my x ' .. my_x .. ' my y ' .. my_y .. ' my_z ' .. my_z )
	my_z = my_z
	
	--/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ boat checks start
	
	-- Theramore boat front check
	testx1 =  -3952
	testy1 =  -4758
	testz1 = 11
	testx2 =  -3972
	testy2 =  -4778
	testz2 = 11
	local TM_ship_front_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	--translates cyz of 3d into xy of 2d
	local x1, y1, onScreen1 = WorldToScreen(testx1, testy1, testz1)
	local x2, y2, onScreen2 = WorldToScreen(testx2, testy2, testz2)
	if onScreen1 and onScreen2 then
		--DrawLine(x1, y1, x2, y2, 200, 200, 200, 5)
	end
	--ToConsole(tostring(isVis) .. ' _hz is ' .. _hz)
	
	-- Theramore ship back check
	testx1 =  -4022
	testy1 =  -4690
	testz1 = 11
	testx2 =  -4042
	testy2 =  -4710
	testz2 = 11
	local TM_ship_back_isVis, _hx, _hy,  _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	--translates cyz of 3d into xy of 2d
	--local x1, y1, onScreen1 = WorldToScreen(testx1, testy1, testz1)
	--local x2, y2, onScreen2 = WorldToScreen(testx2, testy2, testz2)
	--DrawLine(x1, y1, x2, y2, 200, 200, 200, 5)
	--ToConsole(_hz)
	
		-- Menethil boat front check
	testx1 =  -3854
	testy1 =  -559
	testz1 = 11
	testx2 =  -3824
	testy2 =  -589
	testz2 = 11
	local MT_ship_front_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	--translates cyz of 3d into xy of 2d
	--local x1, y1, onScreen1 = WorldToScreen(testx1, testy1, testz1)
	--local x2, y2, onScreen2 = WorldToScreen(testx2, testy2, testz2)
	--if onScreen1 and onScreen2 then
		--DrawLine(x1, y1, x2, y2, 200, 200, 200, 5)
	--end
	--ToConsole(tostring(MT_ship_front_isVis) .. ' _hz is ' .. _hz)
	 
	-- Menethil boat back check
	testx1 =  -3937
	testy1 =  -611
	testz1 = 11
	testx2 =  -3907
	testy2 =  -641
	testz2 = 11
	local MT_ship_back_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	--translates cyz of 3d into xy of 2d
	--local x1, y1, onScreen1 = WorldToScreen(testx1, testy1, testz1)
	--local x2, y2, onScreen2 = WorldToScreen(testx2, testy2, testz2)
	--if onScreen1 and onScreen2 then
		--DrawLine(x1, y1, x2, y2, 200, 200, 200, 5)
	--end
	--ToConsole(tostring(MT_ship_back_isVis) .. ' _hz is ' .. _hz) 
	
	--/\/\/\/\/\/\/\/\/\/\/\//\/\/\/\/\/\/\/\/\\/\/\/\/\ boat checks end
	
	-- theraMore get ready to board
	if self.sent_to_hopOnSpot == false and self.just_left_ship == false then  
		local distance1 = GetDistance3D(-3980.27, -4718.19, 4.37,my_x, my_y, my_z) -- left measurement point 
		local distance2 = GetDistance3D(-3995.62, -4704.19, 4.39,my_x, my_y, my_z) -- right measurement point 
		if distance1 + distance2 < 21 then 
			self.sent_to_hopOnSpot = true
			Move(-4004, -4726, 5) -- hop on spot
		end
	end	
	
	-- Menethil get ready to board
	if self.sent_to_hopOnSpot == false and self.just_left_ship == false then  
		local distance1 = GetDistance3D( -3913.67, -625.02, 4.84,my_x, my_y, my_z) -- left measurement point 
		local distance2 = GetDistance3D( -3896.96, -627.26, 4.64,my_x, my_y, my_z) -- right measurement point 
		ToConsole(distance1+distance2)
		if distance1 + distance2 < 19 then 
			self.sent_to_hopOnSpot = true
			Move(-3896.06, -598.89, 5.43) -- hop on spot
		end
	end	
	
    --################# board ship
	
	-- theraMore ship boarding
	ToConsole(' sent_to_hopOnSpot ' .. tostring(self.sent_to_hopOnSpot) .. ' TM_ship_front_isVis ' .. tostring(self.TM_ship_front_isVis) .. ' went_on_ship ' .. tostring(self.went_on_ship)  )
	if self.sent_to_hopOnSpot == true and -- did we go to the hop on spot ?
		TM_ship_back_isVis == false and TM_ship_front_isVis == false then
	-- when onboard the ship the coords change 
		if	self.went_on_ship == false and GetDistance2D(my_x,my_y,-4004, -4726, 5) < 2 then -- if i am on TH boarding pos
		--deck coord in theramore coord
			Move(-4008.11, -4738.85,5)
			self.went_on_ship = true
			--ToConsole(went_on_ship)
		end
	end
		
	-- menethil ship boarding
	if self.sent_to_hopOnSpot == true and -- did we go to the hop on spot ?	
		MT_ship_back_isVis == false and MT_ship_front_isVis == false then
	-- when onboard the ship the coords change 
		if	self.went_on_ship == false and GetDistance2D(my_x,my_y,-3896, -598) < 2 then -- if i am on menethil boarding pos
		--deck coord in menethil coord
			Move( -3899.17, -595.03, 5.44)
			self.went_on_ship = true
			--ToConsole(went_on_ship)
		end
	end
	
	
	-- get to mid of ship
	-- from  theramore
	if GetDistance2D(my_x,my_y,-5.15, -7.05) <= 1 and self.went_on_ship == true then
		Move(-7, -2, 6) -- mid of ship
	end
	-- from menethil 
	if GetDistance2D(my_x,my_y,-1.58, 11.38, 6.09) <= 1 and self.went_on_ship == true then
		Move(-7, -2, 6) -- mid of ship
	end
	
	--################# leave ship
	
	-- leave ship from TeraMore in MeneThil	
	if GetDistance2D(my_x,my_y,-7, -2) <= 1 and 
		GetMapID() == 11  and 
		self.went_on_ship == false and
		MT_ship_back_isVis == false and 
		MT_ship_front_isVis == false then 
			Move(0,15,6) --leave ship TM to MT in menehtil
			self.just_left_ship = true
	end
	 
	 -- leave ship from MeneThil in TeraMore 	
	if GetDistance2D(my_x,my_y,-7, -2) <= 1 and 
		GetMapID() == 15  and 
		TM_ship_back_isVis == false and 
		self.went_on_ship == false and -- did we just got sent to the ship?
		TM_ship_front_isVis == false then 
			Move(0,-14,6) --mene to tm get of xyz
			self.just_left_ship = true 
	end
	
	--#################### finish  travel script
	
	--Theramore
	if self.just_left_ship == true and 
		GetDistance2D(my_x,my_y,-4007, -4730) < 2 and 
		GetMapID() == 15 then
		Move(-3981, -4704, 4.36)
		self.is_travel_done = true
	end 
	 
	-- reset all var
	if self.is_travel_done == true and GetDistance2D(my_x,my_y,-3981, -4704) < 2 then 
		self.went_on_ship = false
	   self.just_left_ship = false
	   self.is_travel_done = false
	  self. sent_to_hopOnSpot = false 
	   DEFAULT_CHAT_FRAME:AddMessage("Travel done");
	 end
	
		--menethil
	if self.just_left_ship == true and 
		GetDistance2D(my_x,my_y, -3898, -598) < 2 and 
		GetMapID() == 11 then
		Move(-3901, -641, 6)
		self.is_travel_done = true
	end 
	 
	-- reset all var
	if self.is_travel_done == true and GetDistance2D(my_x,my_y,-3901, -641) < 2 then 
		self.went_on_ship = false
		self.just_left_ship = false
		self.is_travel_done = false
		self.sent_to_hopOnSpot = false 
DEFAULT_CHAT_FRAME:AddMessage("Travel done");
	 end
	
	 
	
end

function script_boardship:menu()
   
end