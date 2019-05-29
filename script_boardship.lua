script_boardship = {
   went_on_ship = false,
   just_left_ship = false,
   is_travel_done = false,
   sent_to_hopOnSpot = false,
   boarded_mapID = "0"
}

--[[ we have these stepes while using the boat:
Version 0.1 by zerger
enter dock (area near ship)
go to boarding spot (infront of ship)
board ship
go to center of ship
leave ship
leave dock
todo: do the check only if we are in "mapid", randomize spots,timer so not all bots move synchrone :d 
--]]

local function GetDistance2D(_1x, _1y, _2x, _2y)
	return math.sqrt((_1x - _2x)^2 + (_1y - _2y)^2)
end

function script_boardship:draw()    

end

function script_boardship:run()
	
	PersistLoadingScreen(true)
	--+++++++++++++++++++++++++++++++ todo add mapid check
	--ToConsole('')
	local localObj = GetLocalPlayer();
	local my_x, my_y, my_z = localObj:GetPosition();

	--/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ boat checks start
	
	-- Theramore to menehtil boat front check
	local TM_ship_front_isVis, _hx, _hy, _hz = Raycast(-3952,-4758, 11, -3972, -4778, 11);
	
	-- Theramore  to menehtil ship back check
	local TM_ship_back_isVis, _hx, _hy,  _hz = Raycast(-4022, -4690, 11, -4042, -4710, 11);
	
	-- Menethil to theramore boat front check
	testx1 =  -3854
	testy1 =  -559
	testz1 = 11
	testx2 =  -3824
	testy2 =  -589
	testz2 = 11
	local MT_ship_front_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);

	-- Menethil to theramore boat back check
	testx1 =  -3937
	testy1 =  -611
	testz1 = 11
	testx2 =  -3907
	testy2 =  -641
	testz2 = 11
	local MT_ship_back_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);

	
	-- Menethil to auberdine boat front check
	testx1 =  -3739.80
	testy1 =  -525.26
	testz1 = -1.77
	testx2 =  -3739.80
	testy2 =  -525.26
	testz2 = -1.77+20
	local MT2_ship_front_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);

	-- Menethil to auberdine boat back check
	testx1 =  -3690.05
	testy1 = -614.16
	testz1 = -1.59
	testx2 =  -3690.05
	testy2 =  -614.16
	testz2 = -1.59+10
	local MT2_ship_back_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	
	-- auberdine to Menethil boat front check
	testx1 =  6420.35
	testy1 = 869.97
	testz1 = -1.52
	testx2 =  6420.35
	testy2 =  869.97
	testz2 = -1.52+10
	local AUB_ship_front_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);

	-- auberdine to Menethil boat back check
	testx1 =  6392.20
	testy1 = 781.35
	testz1 = -1.58
	testx2 =  6392.20
	testy2 = 781.35
	testz2 = -1.58+10
	local AUB_ship_back_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	
	-- auberdine to darnassus boat front check
	testx1 =   6609.13
	testy1 = 816.42
	testz1 = -1.61
	testx2 =   6609.13
	testy2 =  816.42
	testz2 = -1.61+20
	local AUB2_ship_front_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);

	-- auberdine to darnassus boat back check
	testx1 =  6582.38
	testy1 = 717.27
	testz1 = -1.58
	testx2 =  6582.38
	testy2 = 717.27
	testz2 = -1.58+20
	local AUB2_ship_back_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	
	-- darnassus to auberdine boat front check
	testx1 =  8534.38
	testy1 =  967.19
	testz1 = -1.60
	testx2 =  8534.38
	testy2 =  967.19
	testz2 = -1.60+20
	local DAR_ship_front_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);

	-- darnassus to auberdine boat back check
	testx1 =  8533.19
	testy1 = 1068.95
	testz1 = -1.61
	testx2 =  8533.19
	testy2 = 1068.95
	testz2 = -1.61+20
	local DAR_ship_back_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	 	
	-- ratchet to bootybay boat front check
	testx1 =  -955.09
	testy1 =  -3869.60
	testz1 = -1.60
	testx2 =  -955.09
	testy2 =  -3869.60
	testz2 = -1.60+20
	local RAT_ship_front_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);

	-- ratchet to bootybay boat back check
	testx1 = -1044.60
	testy1 = -3820.80
	testz1 = -1.61
	testx2 = -1044.60
	testy2 = -3820.80
	testz2 = -1.61+20
	local RAT_ship_back_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);

	-- bootybay to ratchet boat front check
	testx1 =  -14222.22
	testy1 =  564.94
	testz1 = -1.60
	testx2 =  -14222.22
	testy2 =  564.94
	testz2 = -1.60+20
	local BB_ship_front_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);

	-- bootybay to ratchet  boat back check
	testx1 = -14319.50
	testy1 = 597.19
	testz1 = -1.61
	testx2 = -14319.50
	testy2 = 597.19
	testz2 = -1.61+20
	local BB_ship_back_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	
	--++ Zeppellins
	
	-- Undercity to Ogrimmar  Zeppellin front check
	testx1 = 2068.12 
	testy1 = 289.95
	testz1 = 97.53
	testx2 = 2068.8  
	testy2 = 293.89
	testz2 = 97.53
	local UC1_ship_front_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	
	-- Undercity to Ogrimmar  Zeppellin mid check
	testx1 = 2066.87     
	testy1 = 290.77
	testz1 = 97.53 
	testx2 = 2067.98     
	testy2 = 296.67
	testz2 = 97.53
	local UC1_ship_mid_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);	
	
	
	-- Undercity to Ogrimmar  Zeppellin back check
	testx1 = 2065.64  
	testy1 = 290.43
	testz1 = 97.53
	testx2 = 2066.17  
	testy2 = 294.4
	testz2 = 97.53
	local UC1_ship_back_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	
	-- Undercity to Gromgol  Zeppellin front check
	testx1 = 2057      
	testy1 = 238.25
	testz1 = 100.27
	testx2 = 2056.09      
	testy2 = 234.36
	testz2 = 100.27
	local UC2_ship_front_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	
	-- Undercity to Gromgol  Zeppellin mid check
	testx1 = 2057.87     
	testy1 = 237.41 
	testz1 = 100.27
	testx2 = 2056.93      
	testy2 = 231.48
	testz2 = 100.27
	local UC2_ship_mid_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	
	-- Undercity to Gromgol  Zeppellin back check
	testx1 = 2059.25      
	testy1 = 237.79
	testz1 = 100.27
	testx2 = 2058.74      
	testy2 = 233.82
	testz2 = 100.27
	local UC2_ship_back_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	
	-- Ogrimmar to Undercity   Zeppellin front check
	testx1 = 1321.59      
	testy1 = -4651.36
	testz1 = 54.36
	testx2 = 1315.65      
	testy2 = -4652.21
	testz2 = 54.36
	local OG1_ship_front_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	
	-- Ogrimmar to Undercity   Zeppellin mid check
	testx1 = 1321.01      
	testy1 = -4652.77
	testz1 = 54.37
	testx2 = 1315.02     
	testy2 = -4653.1
	testz2 = 54.37 
	local OG1_ship_mid_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	
	
	-- Ogrimmar to Undercity   Zeppellin back check
	testx1 = 1320.68      
	testy1 = -4654
	testz1 = 54.17
	testx2 = 1314.68      
	testy2 = -4654.19
	testz2 = 54.17
	local OG1_ship_back_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);

	-- Ogrimmar to Gromgol   Zeppellin front check
	testx1 = 1362.16    
	testy1 = -4638.04 
	testz1 =  54.38
	testx2 = 1366.95      
	testy2 = -4634.43
	testz2 = 54.38
	local OG2_ship_front_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);

	-- Ogrimmar to Gromgol   Zeppellin mid check
	testx1 = 1363.03      
	testy1 = -4635.89
	testz1 = 54.41 
	testx2 = 1367.74      
	testy2 = -4632.17
	testz2 =  54.41  
	local OG2_ship_mid_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	
	-- Ogrimmar to Gromgol   Zeppellin back check
	testx1 = 1360.98     
	testy1 = -4636.46 
	testz1 = 54.38
	testx2 = 1365.01     
	testy2 =  -4632.01
	testz2 = 54.38
	local OG2_ship_back_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);


	-- Gromgol to ogrimmar   Zeppellin front check
	testx1 = -12449.89      
	testy1 = 219.52
	testz1 = 32.12
	testx2 = -12454.73      
	testy2 = 223.07
	testz2 = 32.12
	local GG1_ship_front_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	
	-- Gromgol to ogrimmar   Zeppellin mid check
	testx1 = -12451.58     
	testy1 = 219.26 
	testz1 = 32.14
	testx2 = -12456.65   
	testy2 = 222.47
	testz2 = 32.14
	local GG1_ship_mid_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	
	-- Gromgol to ogrimmar   Zeppellin back check
	testx1 = -12451.29      
	testy1 = 217.85
	testz1 = 32.12
	testx2 = -12456.66     
	testy2 = 220.53
	testz2 = 32.12
	local GG1_ship_back_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	
	-- Gromgol to undercity   Zeppellin front check
	testx1 = -12409.18      
	testy1 = 205.49
	testz1 = 32.51
	testx2 = -12403.18   
	testy2 = 205.56 
	testz2 = 32.51
	local GG2_ship_front_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	
	-- Gromgol to undercity   Zeppellin mid check
	testx1 = -12407.67      
	testy1 =  206.7
	testz1 = 32.16
	testx2 = -12401.68      
	testy2 =  207.1
	testz2 = 32.16
	local GG2_ship_mid_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	
	-- Gromgol to undercity   Zeppellin back check
	testx1 = -12409.15      
	testy1 =  207.65
	testz1 = 32.11
	testx2 = -12403.17      
	testy2 =  208.14
	testz2 = 32.11
	local GG2_ship_back_isVis, _hx, _hy, _hz = Raycast(testx1, testy1, testz1, testx2, testy2, testz2);
	
	

	
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
	
	-- Menethil to theramore get ready to board
	if self.sent_to_hopOnSpot == false and self.just_left_ship == false then  
		local distance1 = GetDistance3D( -3913.67, -625.02, 4.84,my_x, my_y, my_z) -- left measurement point 
		local distance2 = GetDistance3D( -3896.96, -627.26, 4.64,my_x, my_y, my_z) -- right measurement point 
		--ToConsole(distance1+distance2)
		if distance1 + distance2 < 19 then 
			self.sent_to_hopOnSpot = true
			Move(-3896.06, -598.89, 5.43) -- hop on spot
		end
	end	
	
	-- Menethil to auberdine get ready to board
	if self.sent_to_hopOnSpot == false and self.just_left_ship == false then  
		local distance1 = GetDistance3D( -3738, -583, 6 ,my_x, my_y, my_z) -- left measurement point 
		local distance2 = GetDistance3D( -3720, -595, 6,my_x, my_y, my_z) -- right measurement point 
		--ToConsole(distance1+distance2)
		if distance1 + distance2 < 22 then 
			self.sent_to_hopOnSpot = true
			Move(-3723, -584, 6) -- hop on spot
		end
	end	

	-- auberdine to menehtil get ready to board
	if self.sent_to_hopOnSpot == false and self.just_left_ship == false then  
		local distance1 = GetDistance3D(6441, 819, 7,my_x, my_y, my_z) -- left measurement point 
		local distance2 = GetDistance3D(6437, 806, 6,my_x, my_y, my_z) -- right measurement point 
		--ToConsole(distance1+distance2)
		if distance1 + distance2 < 15 then 
			self.sent_to_hopOnSpot = true
			Move(6421, 820, 5) -- hop on spot
		end
	end		

	-- darnassus to auberdine get ready to board
	if self.sent_to_hopOnSpot == false and self.just_left_ship == false then  
		local distance1 = GetDistance3D( 8565, 1021, 6 ,my_x, my_y, my_z) -- left measurement point 
		local distance2 = GetDistance3D( 8565, 1016, 6,my_x, my_y, my_z) -- right measurement point 
		--ToConsole(distance1+distance2)
		if distance1 + distance2 < 6 then 
			self.sent_to_hopOnSpot = true
			Move(8548.30, 1022.54, 5.81) -- hop on spot
		end
	end	

	-- auberdine to darnassus get ready to board
	if self.sent_to_hopOnSpot == false and self.just_left_ship == false then  
		local distance1 = GetDistance3D(6559, 781, 7,my_x, my_y, my_z) -- left measurement point 
		local distance2 = GetDistance3D(6555, 768, 7,my_x, my_y, my_z) -- right measurement point 
		--ToConsole(distance1+distance2)
		if distance1 + distance2 < 14 then 
			self.sent_to_hopOnSpot = true
			Move(6579.57, 767.22, 5.76) -- hop on spot
		end
	end	

	-- ratchet to bootybay get ready to board
	if self.sent_to_hopOnSpot == false and self.just_left_ship == false then  
		local distance1 = GetDistance3D(-989, -3819, 5,my_x, my_y, my_z) -- left measurement point 
		local distance2 = GetDistance3D(-999, -3814, 5,my_x, my_y, my_z) -- right measurement point 
		--ToConsole(distance1+distance2)
		if distance1 + distance2 < 12 then 
			self.sent_to_hopOnSpot = true
			Move(-999.10, -3827.85, 5.42) -- hop on spot
		end
	end			

	-- bootybay to ratchet get ready to board
	if self.sent_to_hopOnSpot == false and self.just_left_ship == false then  
		local distance1 = GetDistance3D(-14277.68, 555.27, 8.90,my_x, my_y, my_z) -- left measurement point 
		local distance2 = GetDistance3D(-14290.90, 560.09, 8.86,my_x, my_y, my_z) -- right measurement point 
		--ToConsole(distance1+distance2)
		if distance1 + distance2 < 15 then 
			self.sent_to_hopOnSpot = true
			Move(-14283.92, 559.69, 8.73) -- hop on spot
		end
	end	

	-- undercity to ogrimmar get ready to board
	if self.sent_to_hopOnSpot == false and self.just_left_ship == false then  
		local distance1 = GetDistance3D(2063.01, 281.71, 98.07,my_x, my_y, my_z) -- left measurement point 
		local distance2 = GetDistance3D(2068.93, 280.47, 98.08,my_x, my_y, my_z) -- right measurement point 
		--ToConsole(distance1+distance2)
		if distance1 + distance2 < 7 then 
			self.sent_to_hopOnSpot = true
			Move(2067.30, 288.49, 97.03) -- hop on spot
		end
	end			


	-- undercity to gromgol get ready to board
	if self.sent_to_hopOnSpot == false and self.just_left_ship == false then  
		local distance1 = GetDistance3D( 2062.46, 244.95, 99.77,my_x, my_y, my_z) -- left measurement point 
		local distance2 = GetDistance3D(2054.83, 246.80, 99.77,my_x, my_y, my_z) -- right measurement point 
		--ToConsole(distance1+distance2)
		if distance1 + distance2 < 9 then 
			self.sent_to_hopOnSpot = true
			Move(2057.14, 239.00, 99.77) -- hop on spot
		end
	end

	-- gromgol to ogrimmar get ready to board
	if self.sent_to_hopOnSpot == false and self.just_left_ship == false then  
		local distance1 = GetDistance3D(-12445.39, 209.83, 31.29,my_x, my_y, my_z) -- left measurement point 
		local distance2 = GetDistance3D(-12437.36, 218.71, 31.29,my_x, my_y, my_z) -- right measurement point 
		--ToConsole(distance1+distance2)
		if distance1 + distance2 < 13 then 
			DEFAULT_CHAT_FRAME:AddMessage("Travel script started"); 
			self.sent_to_hopOnSpot = true
			Move(-12448.81, 217.54, 31.58) -- hop on spot
		end
	end			


	-- gromgol to undercity get ready to board
	if self.sent_to_hopOnSpot == false and self.just_left_ship == false then  
		local distance1 = GetDistance3D(-12417.53, 214.02, 32.08,my_x, my_y, my_z) -- left measurement point 
		local distance2 = GetDistance3D(-12417.15, 201.94, 31.91,my_x, my_y, my_z) -- right measurement point 
		--ToConsole(distance1+distance2)
		if distance1 + distance2 < 13 then 
			self.sent_to_hopOnSpot = true
			DEFAULT_CHAT_FRAME:AddMessage("Travel script started"); 
			Move(-12409.09, 206.67, 31.65) -- hop on spot
		end
	end		


	-- Ogrimmar to Undercity get ready to board
	if self.sent_to_hopOnSpot == false and self.just_left_ship == false then  
		local distance1 = GetDistance3D(1330.30, -4656.62, 53.54,my_x, my_y, my_z) -- left measurement point 
		local distance2 = GetDistance3D( 1332.33, -4644.69, 53.54,my_x, my_y, my_z) -- right measurement point 
		--ToConsole(distance1+distance2)
		if distance1 + distance2 < 12.5 then 
			DEFAULT_CHAT_FRAME:AddMessage("Travel script started"); 
			self.sent_to_hopOnSpot = true
			Move( 1321.63, -4653.06, 53.86) -- hop on spot
		end
	end	

	-- Ogrimmar to gromgol get ready to board
	if self.sent_to_hopOnSpot == false and self.just_left_ship == false then  
		local distance1 = GetDistance3D(1350.07, -4637.98, 53.54,my_x, my_y, my_z) -- left measurement point 
		local distance2 = GetDistance3D(1357.54, -4647.09, 53.54,my_x, my_y, my_z) -- right measurement point 
		--ToConsole(distance1+distance2)
		if distance1 + distance2 < 13 then 
			DEFAULT_CHAT_FRAME:AddMessage("Travel script started"); 
			self.sent_to_hopOnSpot = true
			Move(1360.08, -4638.41, 53.84) -- hop on spot
		end
	end			
    --######################### board ship
	
	-- theraMore ship boarding
	if self.sent_to_hopOnSpot == true and -- did we go to the hop on spot ?
		TM_ship_back_isVis == false and TM_ship_front_isVis == false then
	-- when onboard the ship the coords change 
		if	self.went_on_ship == false and GetDistance2D(my_x,my_y,-4004, -4726, 5) < 2 then -- if i am on TH boarding spot
		--deck coord in theramore coord
			Move(-4008.11, -4738.85,5)
			self.went_on_ship = true
			--ToConsole(went_on_ship)
		end
	end
		
	-- menethil to theramore ship boarding
	if self.sent_to_hopOnSpot == true and -- did we go to the hop on spot ?	
		MT_ship_back_isVis == false and MT_ship_front_isVis == false then
	-- when onboard the ship the coords change 
		if	self.went_on_ship == false and GetDistance2D(my_x,my_y,-3896, -598) < 2 then -- if i am at menethil boarding spot
		--deck coord in menethil coord
			Move( -3899.17, -595.03, 5.44)
			self.went_on_ship = true
			--ToConsole(went_on_ship)
		end
	end

	-- menethil to auberdine ship boarding
	if self.sent_to_hopOnSpot == true and -- did we go to the hop on spot ?	
		MT2_ship_back_isVis == false and MT2_ship_front_isVis == false then
	-- when onboard the ship the coords change 
		if	self.went_on_ship == false and GetDistance2D(my_x,my_y,-3723, -584) < 2 then -- if i am at menethil boarding spot
		--deck coord in menethil coord
			Move( -3718, -574, 6)
			self.went_on_ship = true
			ToConsole("1")
		end
	end	
	
	-- auberdine to menethil ship boarding
	if self.sent_to_hopOnSpot == true and -- did we go to the hop on spot ?	
		AUB_ship_back_isVis == false and AUB_ship_front_isVis == false then
	-- when onboard the ship the coords change 
		if	self.went_on_ship == false and GetDistance2D(my_x,my_y,6421, 820) < 2 then -- if i am at menethil boarding spot
		--deck coord in menethil coord
			Move( 6417, 821, 6)
			self.went_on_ship = true
			ToConsole("2")
		end
	end	
	
	-- darnassus to auberdine ship boarding
	if self.sent_to_hopOnSpot == true and -- did we go to the hop on spot ?	
		DAR_ship_back_isVis == false and DAR_ship_front_isVis == false then
	-- when onboard the ship the coords change 
		if	self.went_on_ship == false and GetDistance2D(my_x,my_y,8548.70, 1022.46) < 2 then -- if i am at darnassus boarding spot
		--deck coord in darnassus coord
			Move(8541, 1020, 6)
			self.boarded_mapID = GetMapID()
			self.went_on_ship = true
			ToConsole("1")
		end
	end	
	
	-- auberdine to darnassus ship boarding

	if self.sent_to_hopOnSpot == true and -- did we go to the hop on spot ?	
		AUB2_ship_back_isVis == false and AUB2_ship_front_isVis == false then
	-- when onboard the ship the coords change 
		if	self.went_on_ship == false and GetDistance2D(my_x,my_y,6579.57, 767.22) < 2 then -- if i am at darnassus boarding spot
		--deck coord in darnassus coord
			Move( 6588,766, 6)
			self.boarded_mapID = GetMapID()
			self.went_on_ship = true
			ToConsole("2")
		end
	end	
	
	-- ratchet to bootybay ship boarding
	if self.sent_to_hopOnSpot == true and -- did we go to the hop on spot ?	
		RAT_ship_back_isVis == false and RAT_ship_front_isVis == false then
	-- when onboard the ship the coords change 
		if	self.went_on_ship == false and GetDistance2D(my_x,my_y,-999.10, -3827.85) < 2 then -- if i am at ratchet boarding spot
		--deck coord in menethil coord
			Move( -998,-3838, 6)
			self.went_on_ship = true
		end
	end	

	
	-- bootybay to ratchet ship boarding
	if self.sent_to_hopOnSpot == true and -- did we go to the hop on spot ?	
		BB_ship_back_isVis == false and BB_ship_front_isVis == false then
	-- when onboard the ship the coords change 
		if	self.went_on_ship == false and GetDistance2D(my_x,my_y,-14283.92, 559.69) < 2 then -- if i am at ratchet boarding spot
		--deck coord in menethil coord
			Move( -14280,572,6)
			self.went_on_ship = true
		end
	end		
	
	-- Zeppellins
	
	-- undercity to ogrimmar ship boarding
	if self.sent_to_hopOnSpot == true and -- did we go to the hop on spot ?	
		UC1_ship_back_isVis == false and UC1_ship_front_isVis == false and  UC1_ship_mid_isVis == true then
	-- when onboard the ship the coords change 
		if	self.went_on_ship == false and GetDistance2D(my_x,my_y,2067.30, 288.49) < 2 then -- if i am at  boarding spot
		--deck coord in uc coord
			Move( 2068,294,97)
			self.went_on_ship = true
			self.boarded_mapID = GetMapID()
		end
	end	

	-- undercity to gromgol ship boarding
	if self.sent_to_hopOnSpot == true and -- did we go to the hop on spot ?	
		UC2_ship_back_isVis == false and UC2_ship_front_isVis == false and UC2_ship_mid_isVis == true then
	-- when onboard the ship the coords change 
		if	self.went_on_ship == false and GetDistance2D(my_x,my_y,2057.14, 239.00) < 2 then -- if i am at  boarding spot
		--deck coord in uc coord
			Move( 2057,232,99)
			self.went_on_ship = true
			self.boarded_mapID = GetMapID()
		end
	end	

	-- Ogrimmar to gromgol ship boarding
	if self.sent_to_hopOnSpot == true and -- did we go to the hop on spot ?	
		OG2_ship_back_isVis == false and OG2_ship_front_isVis == false and OG2_ship_mid_isVis == true then
	-- when onboard the ship the coords change 
		if	self.went_on_ship == false and GetDistance2D(my_x,my_y,1360.08, -4638.41) < 2 then -- if i am at  boarding spot
		--deck coord in uc coord
			Move( 1366,-4634,53)
			self.went_on_ship = true
			self.boarded_mapID = GetMapID()
		end
	end

	-- Ogrimmar to undercity  ship boarding
	if self.sent_to_hopOnSpot == true and -- did we go to the hop on spot ?	
		OG1_ship_back_isVis == false and OG1_ship_front_isVis == false and OG1_ship_mid_isVis == true then
	-- when onboard the ship the coords change 
		if	self.went_on_ship == false and GetDistance2D(my_x,my_y,1321.63, -4653.06) < 2 then -- if i am at  boarding spot
		--deck coord in uc coord
			Move(1314,-4653,53)
			self.went_on_ship = true
			self.boarded_mapID = GetMapID()
		end
	end	
	
	-- gromgol  to Ogrimmar ship boarding
	if self.sent_to_hopOnSpot == true and -- did we go to the hop on spot ?	
		GG1_ship_back_isVis == false and GG1_ship_front_isVis == false and GG1_ship_mid_isVis == true then
	-- when onboard the ship the coords change 
		if	self.went_on_ship == false and GetDistance2D(my_x,my_y,-12448.81, 217.54, 31.58) < 2 then -- if i am at  boarding spot
		--deck coord in uc coord
			Move(-12456,222,31 )
			self.went_on_ship = true
			self.boarded_mapID = GetMapID()
		end
	end

	-- Gromgol to undercity  ship boarding
	if self.sent_to_hopOnSpot == true and -- did we go to the hop on spot ?	
		GG2_ship_back_isVis == false and GG2_ship_front_isVis == false and GG2_ship_mid_isVis == true then
	-- when onboard the ship the coords change 
		if	self.went_on_ship == false and GetDistance2D(my_x,my_y,-12409.09, 206.67, 31.65) < 2 then -- if i am at  boarding spot
		--deck coord in uc coord
			Move(-12403,208,31)
			self.went_on_ship = true
			self.boarded_mapID = GetMapID()
		end
	end	
	

-- ################# get to mid of ship

	if GetDistance2D(my_x,my_y,-5.15, -7.05) <= 2 and self.went_on_ship == true and self.boarded_mapID == 148 and GetMapID() == 148 then
		Move(-7, -2, 6) -- mid of ship
		ToConsole("3")
	end
	--  
	if GetDistance2D(my_x,my_y,-1.58, 11.38, 6.09) <= 2 and self.went_on_ship == true and self.boarded_mapID == 141 and GetMapID() == 141  then
		Move(-7, -2, 6) -- mid of ship
		ToConsole("4")
	end

	-- 
	if GetDistance2D(my_x,my_y,-5.15, -7.05) <= 2 and self.went_on_ship == true and self.boarded_mapID ~= 148 and GetMapID() ~= 148 then
		Move(-7, -2, 6) -- mid of ship
		ToConsole("3")
	end
	-- 
	if GetDistance2D(my_x,my_y,-1.58, 11.38, 6.09) <= 2 and self.went_on_ship == true and self.boarded_mapID ~= 141 and GetMapID() ~= 141  then
		Move(-7, -2, 6) -- mid of ship
		ToConsole("4")
	end
	 	

	--ogrimmar to Gromgol zeppellin
	if GetDistance2D(my_x,my_y,-5.15,-2.3) <= 2 and 
	self.went_on_ship == true and 
	self.just_left_ship == false and 
	self.boarded_mapID ~= 33 and 
	OG2_ship_back_isVis == false and OG2_ship_front_isVis == false and OG2_ship_mid_isVis == true and -- add another for save measure  whic his faar away
	GetMapID() ~= 33  then 
		Move(-11.62,-7.69 ,-16.15) 
ToConsole('test')
	end

	--Gromgol to ogrimmar  zeppellin
	if GetDistance2D(my_x,my_y,-4.69,-11.97) <= 2 and 
	self.went_on_ship == true and self.boarded_mapID ~=  14 and 
	self.just_left_ship == false and 
	GetMapID() ~= 14  then
		Move(-11.62,-7.69 ,-16.15) -- mid of ship
	end

--################# leave ship
	
	-- leave ship from TeraMore in MeneThil	
	if GetDistance2D(my_x,my_y,-7, -2) <= 1 and 
		GetMapID() == 11  and 
		self.went_on_ship == false and
		MT_ship_back_isVis == false and 
		MT_ship_front_isVis == false then 
			Move(0,15,6) -- get of xyz
			self.just_left_ship = true
	end
	 
	 -- leave ship from MeneThil in TeraMore 	
	if GetDistance2D(my_x,my_y,-7, -2) <= 1 and 
		GetMapID() == 15  and 
		TM_ship_back_isVis == false and 
		self.went_on_ship == false and -- did we just got sent to the ship?
		TM_ship_front_isVis == false then 
			Move(0,-14,6) --get off xyz
			self.just_left_ship = true 
	end

	 -- leave ship from MeneThil in auberdine 	
	 
	if GetDistance2D(my_x,my_y,-7, -2) <= 1 and 
		GetMapID() == 148  and 
		AUB_ship_back_isVis == false and 
		self.went_on_ship == false and -- did we just got sent to the ship?
		AUB_ship_front_isVis == false then 
			Move(0,15,6) --get of xyz
			self.just_left_ship = true 
			ToConsole("6")
	end
	
	 -- leave ship from auberdine  in  MeneThil
	if GetDistance2D(my_x,my_y,-7, -2) <= 1 and 
		GetMapID() == 11  and 
		MT2_ship_back_isVis == false and 
		self.went_on_ship == false and -- did we just got sent to the ship?
		MT2_ship_front_isVis == false then 
			Move(-2,-15,6) --get off xyz
			self.just_left_ship = true 
			ToConsole("5")
	end

	-- leave ship from auberdine  in  darnassus
	if GetDistance2D(my_x,my_y,-7, -2) <= 1 and 
		GetMapID() == 141  and 
		DAR_ship_back_isVis == false and 
		--self.went_on_ship == false and -- did we just got sent to the ship? doesnt get reset becasue we dont have a lodaing screen
		self.boarded_mapID == 148 and
		DAR_ship_front_isVis == false then 
			Move(-2,-15,6) --get off xyz
			self.just_left_ship = true 
			ToConsole("5")
	end
	-- leave ship from darnassus in auberdine
	if GetDistance2D(my_x,my_y,-7, -2) <= 2 and 
		GetMapID() == 148  and 
		AUB2_ship_back_isVis == false and 
		--self.went_on_ship == false and -- did we just got sent to the ship? doesnt get reset becasue we dont have a lodaing screen
		self.boarded_mapID == 141 and
		AUB2_ship_front_isVis == false then 
			Move(-2,-15,6) --get off xyz
			self.just_left_ship = true 
			ToConsole("5")
	end
	
	-- leave ship from ratchet in bootybay	
	if GetDistance2D(my_x,my_y,-7, -2) <= 1 and 
		GetMapID() == 33  and 
		self.went_on_ship == false and
		BB_ship_back_isVis == false and 
		BB_ship_front_isVis == false then 
			Move(-2,15,6) -- get of xyz
			self.just_left_ship = true
	end

	-- leave ship from bootybay in ratchet	
	if GetDistance2D(my_x,my_y,-7, -2) <= 1 and 
		GetMapID() == 17  and 
		self.went_on_ship == false and
		RAT_ship_back_isVis == false and 
		RAT_ship_front_isVis == false then 
			Move(-2,-15,6) -- get of xyz
			self.just_left_ship = true
	end	
	
	-- leave zeppellin from undercity in ogrimar	
	if GetDistance2D(my_x,my_y,-5.37, -2.15) <= 1 and 
		GetMapID() == 14  and 
		self.went_on_ship == false and
		OG1_ship_back_isVis == false and 
		OG1_ship_mid_isVis == true and 
		OG1_ship_front_isVis == false then 
			Move(-6, 2, -17.8) -- get of xyz
			self.just_left_ship = true
	end	
	-- leave zeppellin from undercity in gromgol	
	if GetDistance2D(my_x,my_y,-4.88, -3.94) <= 2 and 
		GetMapID() == 33  and 
		--self.went_on_ship == false and -- did we just got sent to the ship? doesnt get reset becasue we dont have a lodaing screen
		self.boarded_mapID == 85 and
		GG2_ship_back_isVis == false and 
		GG2_ship_mid_isVis == true and 
		GG2_ship_front_isVis == false then 
			Move( -4.74, 5, -17.70) -- get of xyz
			self.just_left_ship = true
	end

	-- leave zeppellin from gromgol in undercity 
	if GetDistance2D(my_x,my_y,-5.88, -3.18, -17.68) <= 2 and 
		GetMapID() == 85  and 
		--self.went_on_ship == false and -- did we just got sent to the ship? doesnt get reset becasue we dont have a lodaing screen
		self.boarded_mapID == 33 and
		UC2_ship_back_isVis == false and 
		UC2_ship_mid_isVis == true and
		UC2_ship_front_isVis == false then 
			Move( -6, 2, -17.8) -- get of xyz
			self.just_left_ship = true
	end	

	-- leave zeppellin from gromgol in ogrimar	
	if GetDistance2D(my_x,my_y,-11.29, -7.96 ) <= 1 and 
		GetMapID() == 14  and 
		self.went_on_ship == false and
		OG2_ship_back_isVis == false and 
		OG2_ship_mid_isVis == true and
		OG2_ship_front_isVis == false then 
			Move(-2.91,  2.7 ,  -17.11) -- get of xyz
			self.just_left_ship = true
	end	

	-- leave zeppellin from ogrimar	 in undercity
	if GetDistance2D(my_x,my_y,-5.59, -3.79) <= 1 and 
		GetMapID() == 85  and 
		self.went_on_ship == false and
		UC1_ship_back_isVis == false and 
		UC1_ship_mid_isVis == true and
		UC1_ship_front_isVis == false then 
			Move(-6, 2, -17.8) -- get of xyz
			self.just_left_ship = true
	end		

	-- leave zeppellin from ogrimar	 in gromgol
	if GetDistance2D(my_x,my_y,-11.62 ,  -7.69) <= 1 and 
		GetMapID() == 33  and 
		self.went_on_ship == false and
		GG1_ship_back_isVis == false and 
		GG1_ship_mid_isVis == true and
		GG1_ship_front_isVis == false then 
			Move(-0.96,-20.27,-17.32) -- get of xyz
			self.just_left_ship = true
	end		

	--#################### finish  travel script
	
	--arrived in Theramore
	if self.just_left_ship == true and 
		GetDistance2D(my_x,my_y,-4007, -4730) < 2 and -- hop off spot
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
	
		--from menethil in theramore
	if self.just_left_ship == true and 
		GetDistance2D(my_x,my_y, -3898, -598) < 2 and -- hop off spot
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
	
		--from menethil in auberdine
	if self.just_left_ship == true and 
		GetDistance2D(my_x,my_y, 6420.21, 818.95) < 2 and -- hop off spot
		GetMapID() == 148 then
		Move(6446.01, 810.55, 6.55)
		self.is_travel_done = true
	end 
	 
	-- reset all var
	if self.is_travel_done == true and GetDistance2D(my_x,my_y,6446.01, 810.55) < 2 then --done spot
		self.went_on_ship = false
		self.just_left_ship = false
		self.is_travel_done = false
		self.sent_to_hopOnSpot = false 
		DEFAULT_CHAT_FRAME:AddMessage("Travel done");
	 end	
	
	--from auberdine in menethil
	if self.just_left_ship == true and 
		GetDistance2D(my_x,my_y, -3723.12, -580.58) < 2 and -- hop off spot
		GetMapID() == 11 then
		Move(-3735, -615, 7)
		self.is_travel_done = true
	end 
	 
	-- reset all var
	if self.is_travel_done == true and GetDistance2D(my_x,my_y,-3735, -615) < 2 then --done spot
		self.went_on_ship = false
		self.just_left_ship = false
		self.is_travel_done = false
		self.sent_to_hopOnSpot = false 
		DEFAULT_CHAT_FRAME:AddMessage("Travel done");
	 end		

	--from darnassus in auberdine
	if self.just_left_ship == true and 
		GetDistance2D(my_x,my_y, 6580.92, 765.72) < 2 and -- hop off spot
		GetMapID() == 148 then
		Move( 6549.93, 777.39, 6.68)
		self.is_travel_done = true
	end 
	 
	-- reset all var
	if self.is_travel_done == true and GetDistance2D(my_x,my_y, 6549.93, 777.39) < 2 then --done spot
		self.went_on_ship = false
		self.just_left_ship = false
		self.is_travel_done = false
		self.sent_to_hopOnSpot = false 
		DEFAULT_CHAT_FRAME:AddMessage("Travel done");
	 end	
	
	--from auberdine in darnassus
	if self.just_left_ship == true and 
		GetDistance2D(my_x,my_y, 8548.26, 1022.88) < 2 and -- hop off spot
		GetMapID() == 141 then
		Move(8574.57, 1017.54, 5.59)
		self.is_travel_done = true
	end 
	 
	-- reset all var
	if self.is_travel_done == true and GetDistance2D(my_x,my_y,8574.57, 1017.54) < 2 then --done spot
		self.went_on_ship = false
		self.just_left_ship = false
		self.is_travel_done = false
		self.sent_to_hopOnSpot = false 
		DEFAULT_CHAT_FRAME:AddMessage("Travel done");
	 end		

	--from ratchet in bootybay
	if self.just_left_ship == true and 
		GetDistance2D(my_x,my_y, -14280.47, 568.29) < 2 and -- hop off spot
		GetMapID() == 33 then
		Move(-14287.56, 551.72, 8.87)
		self.is_travel_done = true
	end 
	 
	-- reset all var
	if self.is_travel_done == true and GetDistance2D(my_x,my_y,-14287.56, 551.72) < 2 then --done spot
		self.went_on_ship = false
		self.just_left_ship = false
		self.is_travel_done = false
		self.sent_to_hopOnSpot = false 
		DEFAULT_CHAT_FRAME:AddMessage("Travel done");
	 end		
	 
	--from bootybay in ratchet
	if self.just_left_ship == true and 
		GetDistance2D(my_x,my_y, -996.52, -3830.04) < 2 and -- hop off spot
		GetMapID() == 17 then
		Move(-990.65, -3811.46, 5.40)
		self.is_travel_done = true
	end 
	 
	-- reset all var
	if self.is_travel_done == true and GetDistance2D(my_x,my_y,-990.65, -3811.46) < 2 then --done spot
		self.went_on_ship = false
		self.just_left_ship = false
		self.is_travel_done = false
		self.sent_to_hopOnSpot = false 
		DEFAULT_CHAT_FRAME:AddMessage("Travel done");
	 end	
	 
	
	--from undercity in ogrimar
	if self.just_left_ship == true and 
		GetDistance2D(my_x,my_y, 1319.77, -4652.07) < 2 and -- hop off spot
		GetMapID() == 14 then
		Move(1336.97,-4647.27, 54.04)
		self.is_travel_done = true
	end 
	 
	-- reset all var
	if self.is_travel_done == true and GetDistance2D(my_x,my_y,1336.97,-4647.27) < 2 then --done spot
		self.went_on_ship = false
		self.just_left_ship = false
		self.is_travel_done = false
		self.sent_to_hopOnSpot = false 
		DEFAULT_CHAT_FRAME:AddMessage("Travel done");
	 end
	
	--from undercity in gromgol
	if self.just_left_ship == true and 
		GetDistance2D(my_x,my_y, -12411.37, 206.96) < 2 and -- hop off spot
		GetMapID() == 33 then
		Move(-12421.59, 206.63, 31.29)
		self.is_travel_done = true
	end 
	 
	-- reset all var
	if self.is_travel_done == true and GetDistance2D(my_x,my_y,-12421.59, 206.63) < 2 then --done spot
		self.went_on_ship = false
		self.just_left_ship = false
		self.is_travel_done = false
		self.sent_to_hopOnSpot = false 
		DEFAULT_CHAT_FRAME:AddMessage("Travel done");
	 end	 	 

	--from Gromgol in ogrimmar
	if self.just_left_ship == true and 
		GetDistance2D(my_x,my_y,1360.59,-4635.27) < 2 and -- hop off spot
		GetMapID() == 14 then
		Move(1347.36,-4645.18,53.93)
		self.is_travel_done = true
	end 
	 
	-- reset all var
	if self.is_travel_done == true and GetDistance2D(my_x,my_y,1347.36,-4645.18) < 2 then --done spot
		self.went_on_ship = false
		self.just_left_ship = false
		self.is_travel_done = false
		self.sent_to_hopOnSpot = false 
		DEFAULT_CHAT_FRAME:AddMessage("Travel done");
	 end		 
	
	--from gromgol in undercity
	if self.just_left_ship == true and 
		GetDistance2D(my_x,my_y, 2057.15,238.15) < 2 and -- hop off spot
		GetMapID() == 85 then
		Move(2063.73, 272.18, 94.11)
		self.is_travel_done = true
	end 
	 
	-- reset all var
	if self.is_travel_done == true and GetDistance2D(my_x,my_y,2063.73, 272.18) < 2 then --done spot
		self.went_on_ship = false
		self.just_left_ship = false
		self.is_travel_done = false
		self.sent_to_hopOnSpot = false 
		DEFAULT_CHAT_FRAME:AddMessage("Travel done");
	 end	

	--from Ogrimmar in gromgol
	if self.just_left_ship == true and 
		GetDistance2D(my_x,my_y,-12449.24,220.18) < 2 and -- hop off spot
		GetMapID() == 33 then
		Move(-12433.89,215.79,31.79)
		self.is_travel_done = true
	end 
	 
	-- reset all var
	if self.is_travel_done == true and GetDistance2D(my_x,my_y,-12433.89,215.79) < 2 then --done spot
		self.went_on_ship = false
		self.just_left_ship = false
		self.is_travel_done = false
		self.sent_to_hopOnSpot = false 
		DEFAULT_CHAT_FRAME:AddMessage("Travel done");
	 end	
 
	--from Ogrimmar in Undercity
	if self.just_left_ship == true  and 
		GetDistance2D(my_x,my_y, 2067.73,289.9) < 2 and -- hop off spot
		GetMapID() == 85 then
		Move(2063.73, 272.18, 94.11)
		self.is_travel_done = true
	end 
	 
	-- reset all var
	if self.is_travel_done == true and GetDistance2D(my_x,my_y,2063.73, 272.18) < 2 then --done spot
		self.went_on_ship = false
		self.just_left_ship = false
		self.is_travel_done = false
		self.sent_to_hopOnSpot = false 
		DEFAULT_CHAT_FRAME:AddMessage("Travel done");
	 end	

end

function script_boardship:menu()
   
end