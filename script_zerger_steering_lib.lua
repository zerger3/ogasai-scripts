script_zerger_steering_lib = {
	isSideChosen = false,
	calcSingleMobAvoidWaypoints_done = false,
	 
	is_WP1_set = false,
	is_WP2_set = false,
	at_WP1 = false,
	at_WP2 = false,
	avoidance_done = false,
	tx_temp = 0, -- we need those so we can save final destination and still use normal pathing func to avoid mobs
	tx_temp = 0,
	tz_temp = 0,
	willCollide = false,
	colSeconds = 0,
}

--[[
calcSingleMobAvoidWaypoints

if mobs are looking left and are stationary they are likly to turn around and patrol to the right
cccp(): calculates in 2D if 2 circles will collide based on their xyz, movementspeed and direction
--]]





function script_zerger_steering_lib:calcSingleMobAvoidWaypoints()
--[[ we noticed our next nav spot is too close to a mob so we need to find a new safer spot

 -calc distance to the dangerous mob -> use as base of the trapezoid	
 -calc xy of "X" with calcIntersections which will return 2 xy, one left and one right of the mob
 
--]]
	local localObj = GetLocalPlayer();
	local my_x, my_y, my_z = localObj:GetPosition();
	local safedistanceVar = 5 -- IMPORTANT!! the distance from the aggo cirlce which is considered safe
	local mob_radius = dangerMob_r + safedistanceVar  -- mobradius is NOT mob aggro range, (1 yard outside aggrorange should be safe)
		
	local triangleSideA = math.floor(math.sqrt((my_x-dangerMob_x)*(my_x-dangerMob_x)+(my_y-dangerMob_y)*(my_y-dangerMob_y)));
	local hypothenuse = math.floor(math.sqrt((triangleSideA)^2+mob_radius^2));
	
	-- this will find me two spots in an right angle from the mob (left and right side)
	-- rightPoint and leftPoint XY (they are the 'x' in the drawing)
	local rightPoint_x, rightPoint_y, leftPoint_x, leftPoint_y = script_zerger_steering_lib:calcIntersections(my_x,my_y,hypothenuse, dangerMob_x, dangerMob_y,mob_radius );
		
	--safedistance from mob is aggrorange + safedistanceVar
	--[[
		R = aggrorange (the real one ;) )
		
				 \Waypoint 3
				  \
				   \
					\
					 \
				      \
					   \  Waypoint 2
						|				!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
						|				!!!!!!!! MOB <-> X is (aggrorange + safedistanceVar) not R * something!!!!!!!!!!!!!!!!
						|   
			            |              (Waypoint 1 to Waypoint 2  is 1.5*R)
		MOB ------------X               "X" is our former triangle safespot and halfway between Waypoint 1 and 2 
						|				so Waypoint 1 <---> "X" is 1.5*R/2 or 0.75*R and we can calc MOB <---> WP
						|				MOB <---> WP1 = sqrRoot((R+safedistanceVar)^2+(0.75*R)^2) = MOB <---> WP2
						|				Put these values in our 'calcIntersections' and we get XY of WP1 and WP2
						|
					   / Waypoint 1	
					  /
				     /
				    /
				   /
				  /
				 /
				/
		Player /
	
		X _______ Waypoint           X <---> Waypoint is 0.75*R 
		 |		/					 X <---> MOB is R+safedistanceVar 
		 |     /					 hypothenuse^2  = (R+safedistanceVar)^2 + (0.75*R)^2
   sideA |    / hypothenuse
         |   /
		 |	/
		 | /
         |/
		 MOB
	
	--]]
	
	local hypothenuse = math.floor(math.sqrt((dangerMob_r + safedistanceVar)*(dangerMob_r + safedistanceVar)+(0.75*dangerMob_r)*(0.75*dangerMob_r)))
	
	-- this will find me two spots in an right angle from right side X (WP 1,2)
	rightPathWP1_x, rightPathWP1_y, rightPathWP2_x, rightPathWP2_y = script_zerger_steering_lib:calcIntersections(dangerMob_x,dangerMob_y,hypothenuse, rightPoint_x, rightPoint_y, 0.75*dangerMob_r );
	local isVis, _hx, _hy, _hz = Raycast(rightPathWP1_x, rightPathWP1_y, 10000, rightPathWP1_x, rightPathWP1_y, -10000)
	rightPathWP1_z = _hz
	local isVis, _hx, _hy, _hz = Raycast(rightPathWP2_x, rightPathWP2_y, 10000, rightPathWP2_x, rightPathWP2_y, -10000)
	rightPathWP2_z = _hz 
	
	-- this will find me two spots in an right angle from left side X (WP 1,2)
	leftPathWP2_x, leftPathWP2_y, leftPathWP1_x, leftPathWP1_y  = script_zerger_steering_lib:calcIntersections(dangerMob_x,dangerMob_y,hypothenuse, leftPoint_x, leftPoint_y, 0.75*dangerMob_r );
	local isVis, _hx, _hy, _hz = Raycast(leftPathWP1_x, leftPathWP1_y, 10000, leftPathWP1_x, leftPathWP1_y, -10000)
	leftPathWP1_z = _hz
	local isVis, _hx, _hy, _hz = Raycast(leftPathWP2_x, leftPathWP2_y, 10000, leftPathWP2_x, leftPathWP2_y, -10000)
	leftPathWP2_z = _hz




	-- we finised our wp calc
	self.calcSingleMobAvoidWaypoints_done = true
	
end

function script_zerger_steering_lib:calcIntersections(x1,y1,r1,x2,y2,r2) 
	--http://walter.bislins.ch/blog/index.asp?page=Schnittpunkte+zweier+Kreise+berechnen
	--https://translate.google.com/translate?sl=de&tl=en&u=http%3A%2F%2Fwalter.bislins.ch%2Fblog%2Findex.asp%3Fpage%3DSchnittpunkte%2Bzweier%2BKreise%2Bberechnen%2B(JavaScript)
	-- WAS used for triangle safespot, still used to calc a 3rd point in a triangle
	-- calculate the intersections of 2 circles -> "my circle" and "mob circle" which helps us find a safespot to nav from
	-- acutally we are using a right angle triangle where we have A) at mob and rightangle B) our xy and C) is the safespot
	-- so my circle has the hypothenuse as radius and mobradius is is the safedistance 
	-- data i take from other function: my_x,my_y,hypothenuse, dangerMob_x, dangerMob_y,mob_radius
	-- (var names are not great, relict from former version of the function)
	local my_x = x1
	local my_y = y1
	local a = r1
	local mob_x = x2
	local mob_y = y2
	local b = r2
	triangleSideA = (math.sqrt((my_x-mob_x)*(my_x-mob_x)+(my_y-mob_y)*(my_y-mob_y)));
	AB0 = (mob_x - my_x); --vector  (mobx - my x) 
	AB1 = mob_y - my_y ;  
	c = math.sqrt( AB0 * AB0 + AB1 * AB1 ); --distance between both cirlce centers so my sideA
	x = (a*a + c*c - b*b) / (2*c);-- )
	y = math.sqrt(a*a - x*x);--  sideC  mob <---> safespot
	ex0 = AB0 / c;
	ex1 = AB1 / c;
	ey0 = -ex1;
	ey1 = ex0;
	Q1x = my_x + x * ex0;
	Q1y = my_y + x * ex1;
	-- two intersections
	local intersection1_x = Q1x - y * ey0;
	local intersection1_y = Q1y - y * ey1;
	local intersection2_x = Q1x + y * ey0;
	local intersection2_y = Q1y + y * ey1; 
	return intersection1_x, intersection1_y, intersection2_x, intersection2_y;
	
end	

function script_zerger_steering_lib:calcMorePoints()	
	-- is crap?! come up with better solution
	--calc more than the 2 wp each side, additional 8 wp eac hside (inital wp12 are (atm) 5 yards from aggrorange) all additional waypoints are  3 yards further away
	
	_, _, _, rightUnitVector_x, rightUnitVector_y = vectorABcalculations(dangerMob_x,dangerMob_y,intersection1_x,intersection1_y)-- todo take better var than intersection1_x etc
	_, _, _, leftUnitVector_x, leftUnitVector_y = vectorABcalculations(dangerMob_x,dangerMob_y,intersection2_x,intersection2_y)
	
	-- 1 unitvector has a magnitude of 1 yard (is 1 yard long) 
	-- now we construct wp 3 & 4  = wp1_x  + 3 * unitvector_x etc
	rightPathWP3_x = rightPathWP1_x  + rightUnitVector_x * 3
	rightPathWP3_y = rightPathWP1_y  + rightUnitVector_y * 3
	leftPathWP3_x = leftPathWP1_x  + leftUnitVector_x * 3
	leftPathWP3_y = leftPathWP1_y  + leftUnitVector_y * 3
	
	rightPathWP4_x = rightPathWP2_x  + rightUnitVector_x * 3
	rightPathWP4_y = rightPathWP2_y  + rightUnitVector_y * 3
	leftPathWP4_x = leftPathWP2_x  + leftUnitVector_x * 3
	leftPathWP4_y = leftPathWP2_y  + leftUnitVector_y * 3
	
	
	--##############################
	
	rightPathWP5_x = rightPathWP1_x  + rightUnitVector_x * 6
	rightPathWP5_y = rightPathWP1_y  + rightUnitVector_y * 6
	leftPathWP5_x = leftPathWP1_x  + leftUnitVector_x * 6
	leftPathWP5_y = leftPathWP1_y  + leftUnitVector_y * 6
	
	rightPathWP6_x = rightPathWP2_x  + rightUnitVector_x * 6
	rightPathWP6_y = rightPathWP2_y  + rightUnitVector_y * 6
	leftPathWP6_x = leftPathWP2_x  + leftUnitVector_x * 6
	leftPathWP6_y = leftPathWP2_y  + leftUnitVector_y * 6
	
	
	--##############################
	
	rightPathWP7_x = rightPathWP1_x  + rightUnitVector_x * 9
	rightPathWP7_y = rightPathWP1_y  + rightUnitVector_y * 9
	leftPathWP7_x = leftPathWP1_x  + leftUnitVector_x * 9
	leftPathWP7_y = leftPathWP1_y  + leftUnitVector_y * 9
	
	rightPathWP8_x = rightPathWP2_x  + rightUnitVector_x * 9
	rightPathWP8_y = rightPathWP2_y  + rightUnitVector_y * 9
	leftPathWP8_x = leftPathWP2_x  + leftUnitVector_x * 9
	leftPathWP8_y = leftPathWP2_y  + leftUnitVector_y * 9
	
	
end	

function script_zerger_steering_lib:vectorABcalculations(Ax,Ay,Bx,By)
--returns the vector between two points AB, its magnitue and the unitvector of it
--1 2 3 4 5 returned results
	-- vector
	local vector_x = Bx-Ax
	local vector_y = By-Ay
	-- vector magnitude 
	local vectorMagnitude = math.sqrt(vector_x^2+vector_y^2)
	--unit vector has a magnitude of 1 (meaning its 1 yard long) 
	local unitVector_x = 1/vectorMagnitude*vector_x
	local unitVector_y = 1/vectorMagnitude*vector_y
	return vector_x,vector_y,vectorMagnitude,unitVector_x,unitVector_y
	
end





function script_zerger_steering_lib:setWP1()
	-- todo rework how we handle xyz set for move from one script to another
	if goLeft == true then
		tct('+++++++++++++++**********************+++++++++++we go left' .. leftPathWP1_x .. leftPathWP1_y .. leftPathWP1_z)
		-- we set wp1 as new genpath destination
		script_runner.tx = leftPathWP1_x
		script_runner.ty = leftPathWP1_y
		script_runner.tz = leftPathWP1_z
		
	    
	elseif goLeft == false then 
		tct('+++++++++++++++**********************+++++++++++we go right' .. rightPathWP1_x .. rightPathWP1_y .. rightPathWP1_z)
		-- we set wp1 as new genpath destination
		script_runner.tx = rightPathWP1_x
		script_runner.ty = rightPathWP1_y
		script_runner.tz = rightPathWP1_z
		
	end
	
	self.is_WP1_set = true
end

function script_zerger_steering_lib:setWP2()
	if goLeft == true then
		tct('+++++++++++++++**********************+++++++++++we go left' .. leftPathWP2_x .. leftPathWP2_y .. leftPathWP2_z)
		
		script_runner.tx = leftPathWP2_x
		script_runner.ty = leftPathWP2_y
		script_runner.tz = leftPathWP2_z
		
	    
	elseif goLeft == false then 
		tct('+++++++++++++++**********************+++++++++++we go right' .. rightPathWP2_x .. rightPathWP2_y .. rightPathWP2_z)
		-- we set wp2 as new genpath destination
		script_runner.tx = rightPathWP2_x
		script_runner.ty = rightPathWP2_y
		script_runner.tz = rightPathWP2_z
	end
	self.is_WP2_set = true
end

function script_zerger_steering_lib:are_we_at_WP1()

	local localObj = GetLocalPlayer();
	local    my_x, my_y, my_z = localObj:GetPosition();
	
	-- right path stuff
	if goLeft == false then	
		-- if we are at a wp	1 todo calc distance 
		if GetDistance3D(my_x, my_y, my_z, rightPathWP1_x, rightPathWP1_y, rightPathWP1_z) < 1 then
			self.at_WP1 = true
		end
	end	
	
	--- go left path stuff
	if goLeft == true then	
		-- if we are at a wp	1
		if GetDistance3D(my_x, my_y, my_z, leftPathWP1_x, leftPathWP1_y, leftPathWP1_z) < 1 then
			self.at_WP1 = true
		end
	end	
end

function script_zerger_steering_lib:are_we_at_WP2()

	local localObj = GetLocalPlayer();
	local    my_x, my_y, my_z = localObj:GetPosition();

	if goLeft == false then	
		-- if we are at a wp	2
		if GetDistance3D(my_x, my_y, my_z, rightPathWP2_x, rightPathWP2_y, rightPathWP2_z) < 1 then
			self.at_WP2 = true
		end
	end	
	
	--- go left path stuff
	if goLeft == true then	

		--are  we  at a wp	2
		if GetDistance3D(my_x, my_y, my_z, leftPathWP2_x, leftPathWP2_y, leftPathWP2_z) < 1 then
			self.at_WP2 = true
		end
	end	
	
end

function script_zerger_steering_lib:saveNormalPathingXYZ()
-- saves normal pathing destination xyz  var so we can set them again after we avoided the mob
	self.tx_temp = script_runner.tx 
	self.ty_temp = script_runner.ty
	self.tz_temp = script_runner.tz 
end

function script_zerger_steering_lib:chooseLeftorRight()
--is a side blocked?
--is a mob on the wp path?
--todo
--mobmovement vector
-- wp 1 only?


	local my_x,my_y,my_z,my_a = script_zerger_helper_lib:playerCoord()

	local relativeAngle = script_zerger_math_lib:relativeFacingDirection(my_a,dangerMob_angle)

-- if mob is moving pick side that is at his "back"; if standing pick side at his "front"
	if dangerMob_speed == 0 then
		if relativeAngle == "left" then
			self.isSideChosen = true
			goLeft = true
		elseif relativeAngle == "right" then
			self.isSideChosen = true
			goLeft = false
		end
	
	elseif  dangerMob_speed > 0 then	
		if relativeAngle == "left" then
		self.isSideChosen = true
			goLeft = false
		elseif relativeAngle == "right" then
			self.isSideChosen = true
			goLeft = true
		end
	end
end

	--[[ old calc just based on the closest wp to final destination
	-- calc direct distance for each wp 2 to final destination for now 
	local rightPathWP2toFinalDestination = GetDistance3D(self.tx,self.ty,self.tz,rightPathWP2_x,rightPathWP2_y,rightPathWP2_z)
	local leftPathWP2toFinalDestination = GetDistance3D(self.tx,self.ty,self.tz,leftPathWP2_x,leftPathWP2_y,leftPathWP2_z)
	tc1(rightPathWP2toFinalDestination .. ' / ' .. leftPathWP2toFinalDestination  .. ' right/left path wp2 distance to final destination')
	if rightPathWP2toFinalDestination > leftPathWP2toFinalDestination then
		 goLeft = true
		 tc2('left WP2 is closer')
	 elseif rightPathWP2toFinalDestination < leftPathWP2toFinalDestination then
		 goLeft = false
		  tc2('right WP2 is closer')
	 end
	self.isSideChosen = true
	--]]
	
	
function script_zerger_steering_lib:cccp(x1,y1,angle1,speed1,radius1,x2,y2,angle2,speed2,radius2)	
	--https://stackoverflow.com/questions/11369616/circle-circle-collision-prediction
	
	local Dax, Day = script_zerger_math_lib:convertPolarToCart(angle1,speed1)
	local Dbx, Dby = script_zerger_math_lib:convertPolarToCart(angle2,speed2)
	local Oax = x1
	local Oay = y1
	local Obx = x2
	local Oby = y2
	local ra = radius1
	local rb = radius2

	local a = Dax^2 + Dbx^2 + Day^2 + Dby^2 - (2 * Dax * Dbx) - (2 * Day * Dby)
	local b = (2 * Oax * Dax) - (2 * Oax * Dbx) - (2 * Obx * Dax) + (2 * Obx * Dbx)  + (2 * Oay * Day) - (2 * Oay * Dby) - (2 * Oby * Day) + (2 * Oby * Dby)
	local c = Oax^2 + Obx^2 + Oay^2 + Oby^2    - (2 * Oax * Obx) - (2 * Oay * Oby) - (ra + rb)^2
	
	-- collision occurs if (a != 0) && (b^2 >= 4ac)
	local x = (math.sqrt(b^2 - 4 * a* c) - b)/(2 *a) 
	local x2 = -(math.sqrt(b^2 - 4 * a * c) + b)/(2 *a) 
	
	
	if x == x and x > 0 and x2 >0 then -- to check for undefined calculations (1/0) ->  value ~= value, negativ numbers can occur but are irrelevant for us since we cant travel back in time :D
		self.willCollide = true 
		local colSeconds -- if the above conditions are true we have a collision at x and x2, when the circle first hit and when they leave each other after collision
		if x < x2 then
			colSeconds = x;
		else
			colSeconds = x2;
		end
		colSeconds = script_zerger_math_lib:roundDP(colSeconds, 2)
		if colSeconds == nil then colSeconds = 9999 end ;
		--ToConsole(tostring(self.willCollide)..colSeconds)
		return self.willCollide, colSeconds
	end
end

function script_zerger_steering_lib:wpToMobCCCP()
	--todo put wp into table and check table of wp
	if rightPathWP1_x ~= nil then
		local localObj = GetLocalPlayer();
		local tar_x, tar_y, tar_z, tar_a = script_zerger_helper_lib:targetCoord();
		local tarObj = GetTarget();
		local tar_speed = tarObj:GetSpeed();
		
		local tar_radius = tarObj:GetLevel() - localObj:GetLevel() + 21;
		if tar_radius > 46 then tar_radius = 46 end;
		if tar_radius < 6 then tar_radius = 6 end;

		local rwp1,t1 = script_zerger_steering_lib:cccp(rightPathWP1_x,rightPathWP1_y,1,0,0.1,tar_x,tar_y,tar_a,tar_speed,tar_radius)
		--ToConsole(tostring(rwp1)..t1)
		local rwp2,t2 = script_zerger_steering_lib:cccp(rightPathWP2_x,rightPathWP2_y,1,0,0.1,tar_x,tar_y,tar_a,tar_speed,tar_radius)
		local lwp1,t3 = script_zerger_steering_lib:cccp(leftPathWP1_x,leftPathWP1_y,1,0,0.1,tar_x,tar_y,tar_a,tar_speed,tar_radius)
		local lwp2,t4 = script_zerger_steering_lib:cccp(leftPathWP2_x,leftPathWP2_y,1,0,0.1,tar_x,tar_y,tar_a,tar_speed,tar_radius)

	if t1 ~= nil then ToConsole('right wp 1 '..t1..' seconds') end 
	if t2 ~= nil then ToConsole('right wp 2 '..t2..' seconds') end 
	if t3 ~= nil then ToConsole('left wp 1  '..t3..' seconds') end 
	if t4 ~= nil then ToConsole('left wp 2 '..t4..' seconds') end 
		
		
	if t1 ~= nil then script_zerger_helper_lib:drawText('right wp 1 '..t1..' seconds',300,310,red) end 
	if t2 ~= nil then script_zerger_helper_lib:drawText('right wp 2 '..t2..' seconds',300,320,red) end 
	if t3 ~= nil then script_zerger_helper_lib:drawText('left wp 1  '..t3..' seconds',300,330,red) end 
	if t4 ~= nil then script_zerger_helper_lib:drawText('left wp 2 '..t4..' seconds',300,340,red) end 
		
	end
--ToConsole('?'..rightPathWP1_x..tostring(rwp1)..t1)
	return rwp1,t1,rwp2,t2,lwp1,t3,lwp2,t4;
end







