script_test = {
   went_on_ship_in_TM = false,
   just_left_ship = false,
   sent_to_hopOnSpot = false 
}

--[[ we have these stepes while using the boat:
enter dock (area near ship)
go to baording spot (infront of ship)
board ship
go to center of ship
leave ship
leave dock
--]]

local function GetDistance2D(_1x, _1y, _2x, _2y)
	return math.sqrt((_1x - _2x)^2 + (_1y - _2y)^2)
end

function script_test:draw()    
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

function script_test:run()
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
	if self.sent_to_hopOnSpot == false and  -- if we didnt go to hopon spot yet
		GetMapID() == 15 and  -- we are in dustwallowmarsh
		my_x > -4004 and my_x < -3990 and -- in a square near the  flags
		my_y > -4729 and my_y < -4706 then 
			self.sent_to_hopOnSpot = true
			Move(-4004, -4726, 5) -- hop on spot
	end	
 
	-- theraMore ship boarding
	ToConsole(tostring(self.sent_to_hopOnSpot) .. ' sent_to_hopOnSpot' )
	if self.sent_to_hopOnSpot == true and -- did we go to the hop on spot ?
		TM_ship_back_isVis == false and TM_ship_front_isVis == false then
	-- when onboard the ship the coords cahnge and the move will b issued again
		if	self.went_on_ship_in_TM == false then -- if i am on TH boarding pos
		--deck coord in theramore coord
			Move(-4008.11, -4738.85,5)
			self.went_on_ship_in_TM = true
			--ToConsole(went_on_ship_in_TM)
		end
	end
	
	-- get to mid of ship
	--my xy to ship entered_xy, if mapid = 15 then todo
	if GetDistance2D(my_x,my_y,-5.15, -7.05) <= 1 and self.went_on_ship_in_TM == true then
		Move(-7, -2, 6) -- mid of ship
	end
	
	-- leave ship from TeraMore in MeneThil	
	if GetDistance2D(my_x,my_y,-7, -2) <= 1 and 
		GetMapID() == 11  and 
		self.sent_to_hopOnSpot == false and
		MT_ship_back_isVis == false and 
		MT_ship_front_isVis == false then 
			Move(0,15,6) --leave ship TM to MT in menehtil
			self.just_left_ship = true
	end
	 
	 -- leave ship from MeneThil in TeraMore 	
	if GetDistance2D(my_x,my_y,-7, -2) <= 1 and 
		GetMapID() == 15  and 
		TM_ship_back_isVis == false and 
		self.sent_to_hopOnSpot == false and -- did we just got sent to the ship?
		TM_ship_front_isVis == false then 
			Move(0,-14,6) --mene to tm get of xyz
			self.just_left_ship = true 
	end

	
	 
	 
	
end

function script_test:menu()
    if (CollapsingHeader("[Radar")) then
        wasClicked, self.showRadar = Checkbox("Draw the radar", self.showRadar);
        Separator();
        wasClicked, self.drawRadarFriendlyPlayer = Checkbox("Draw friendly players on radar", self.drawRadarFriendlyPlayer);
        wasClicked, self.drawRadarHostilePlayer = Checkbox("Draw hostile players on radar", self.drawRadarHostilePlayer);
        wasClicked, self.drawRadarMob = Checkbox("Draw mob on radar", self.drawRadarMob);
        Separator();
        wasClicked, self.drawNavFriendlyPlayers = Checkbox("Draw friendly players script_nav style", self.drawNavFriendlyPlayers);
        wasClicked, self.drawNavHostilePlayers = Checkbox("Draw hostile players script_nav style", self.drawNavHostilePlayers);
        wasClicked, self.drawNavMonsters = Checkbox("Draw monsters script_nav style", self.drawNavMonsters);
        self.radarOffsetX = SliderInt("radarOffsetX", 1, 1920, self.radarOffsetX);
        self.radarOffsetY = SliderInt("radarOffsetY", 1, 1080, self.radarOffsetY);
        self.radiusOne = SliderInt("radius #1", 1, 300, self.radiusOne);
        self.radiusTwo = SliderInt("radius #2", 1, 300, self.radiusTwo);
        self.radarScale = SliderInt("Scaling factor", 0, 300, self.radarScale);
    end
end