script_zerger_math_lib = {

}
--[[
todo:
https://stackoverflow.com/questions/5837572/generate-a-random-point-within-a-circle-uniformly

GetDistance2D: distance between x1y1 and x2y2
triAngleCentroid: 
intersections of cirlces:
vectorABcalculations(Ax,Ay,Bx,By): position vector of two points with its head at AxAy. vector_x,vector_y,vectorMagnitude,unitVector_x,unitVector_y(vector with the magnitude 1)
convertPolarToCart(angle,distance,x,y): results in unitvector! (has a magnitude of one)
targetFacingDirection: 
relativeFacingDirection(): returns if the angle_2 is poiting left or right relative to angle_1 
roundDP(number, decimals) rounds(floors) the number with given decimalplaces
		!!! func with numChildren doent work yet :( also need to fix func with '#' used
		nearestMultiple( number, multiple )
		lengthOf( a, b )
		rotateTo( point, degrees )
		rotateAboutPoint( point, centre, degrees, round )
		angleOfPoint( pt )
		angleBetweenPoints( a, b )
		angleOf( a, b )
		angleBetween( srcObj, dstObj )
		dotProduct( ax, ay, bx, by )
		extrudeToLen( origin, point, lenOrMin, max )
		smallestAngleDiff( target, source )
		angleAt( centre, first, second )
		isPointInAngle( centre, first, second, point )
		normalise(vector)
		dotProduct(a,b)
		dotProductByDimensions( a, b )
		dotProductByCos( a, b )
		crossProduct( a, b )
		b2CrossVectVect( a, b )
		b2CrossVectFloat( a, s )
		b2CrossFloatVect( s, a )
		fractionOf( a, b )
		percentageOf( a, b )
		midPoint( pts )
		midPointOfShape( pts )
		isOnRight( north, south, point )
		reflect( north, south, point )
		math.doLinesIntersect( a, b, c, d )
		GetClosestPoint( A,  B,  P, segmentClamp )
		polygonArea( points )
		pointInPolygon( points, dot )
		pointInPolygons( polygons, dot )
		isPolyClockwise( pointList )
		polygonFill( points, closed, perPixel, width, height, col )
		pixelFill( points, closed, perPixel, width, height )
		clamp( val, low, high )
		forcesByAngle(totalForce, angle)

--]]

function script_zerger_math_lib:GetDistance_2D(_1x, _1y, _2x, _2y)
	return math.sqrt((_1x - _2x)^_2 + (_1y - _2y)^_2)
end


function script_zerger_math_lib:GetTriAngleCentroid(x1,y1,x2,y2,x3,y3)
	--https://brilliant.org/wiki/triangles-centroid/
	local triAngleCentroid_x = (x1+x2+x3)/3 
	local triAngleCentroid_y = (y1+y2+y3)/3
	return triAngleCentroid_x, triAngleCentroid_y
end


function script_zerger_math_lib:vectorABcalculations(Ax,Ay,Bx,By)
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


function script_zerger_math_lib:convertPolarToCart(angle,radius)
	--https://en.wikipedia.org/wiki/Radian https://en.wikipedia.org/wiki/Cartesian_coordinate_system 
	--https://www.mathsisfun.com/polar-cartesian-coordinates.html
	local new_x = radius*math.cos(angle)
	local new_y = radius*math.sin(angle)

	return new_x,new_y;
end


function script_zerger_math_lib:convertCartToPolar(x1,y1,x2,y2)
	local x = x2-x1
	local y = y2-y1
	local magnitude = math.sqrt( x^2 + y^2 )
	local angle  = math.atan2(y, x)
	
	return angle,magnitude;
end

function script_zerger_math_lib:targetFacingDirection()
	--https://forum.unity.com/threads/left-right-test-function.31420/
	--https://math.stackexchange.com/questions/180874/convert-angle-radians-to-a-heading-vector
	my_x,my_y,my_z,my_a = script_zerger_helper_lib:playerCoord()
	tar_x,tar_y,tar_z,tar_a = script_zerger_helper_lib:targetCoord()
	
	local myUV_x = math.cos(my_a)
	local myUV_y = math.sin(my_a)
	
	local tarUV_x = math.cos(tar_a)
	local tarUV_y = math.sin(tar_a)
	
	local crossproduct = -myUV_x*tarUV_y+myUV_y*tarUV_x
	
DEFAULT_CHAT_FRAME:AddMessage('crossproduct '..crossproduct)

	
	if crossproduct < 0 then 
	DEFAULT_CHAT_FRAME:AddMessage('target is facing left')
	end
	
	if crossproduct > 0 then 
	DEFAULT_CHAT_FRAME:AddMessage('target is facing right')
	end
end


function script_zerger_math_lib:relativeFacingDirection(angle_1,angle_2)


	local relativeAngle
	local myUV_x = math.cos(angle_1)
	local myUV_y = math.sin(angle_1)
	
	local tarUV_x = math.cos(angle_2)
	local tarUV_y = math.sin(angle_2)
	
	local crossproduct = -myUV_x*tarUV_y+myUV_y*tarUV_x
	
DEFAULT_CHAT_FRAME:AddMessage('crossproduct '..crossproduct)

	
	if crossproduct < 0 then 
	DEFAULT_CHAT_FRAME:AddMessage('target is facing left')
	 relativeAngle = "left"
	end
	
	if crossproduct > 0 then 
	DEFAULT_CHAT_FRAME:AddMessage('target is facing right')
	 relativeAngle = "right"
	end
	
	return relativeAngle;
end

function script_zerger_math_lib:roundDP(num, numDecimalPlaces)
	--http://lua-users.org/wiki/SimpleRound
    local mult = 10^(numDecimalPlaces or 0)
    if num >= 0 then return math.floor(num * mult + 0.5) / mult
    else return math.ceil(num * mult - 0.5) / mult end
end

function script_zerger_math_lib:round(num)
    under = math.floor(num)
    upper = math.floor(num) + 1
    underV = -(under - num)
    upperV = upper - num
    if (upperV > underV) then
        return under
    else
        return upper
    end
end

-- the following functions are taken from https://gist.github.com/Xeoncross/9511295 

--[[
	Maths extension library for use in Corona SDK by Matthew Webster.
	All work derived from referenced sources.
	
	twitter: @horacebury
	blog: http://springboardpillow.blogspot.co.uk/2012/04/sample-code.html
	code exchange: http://code.coronalabs.com/search/node/HoraceBury
	github: https://gist.github.com/HoraceBury
]]--
 
--[[
	References:
		http://stackoverflow.com/questions/385305/efficient-maths-algorithm-to-calculate-intersections
		http://stackoverflow.com/questions/4543506/algorithm-for-intersection-of-2-lines
		http://community.topcoder.com/tc?module=Static&d1=tutorials&d2=geometry2#reflection
		http://gmc.yoyogames.com/index.php?showtopic=433577
		http://local.wasp.uwa.edu.au/~pbourke/geometry/
		http://alienryderflex.com/polygon/
		http://alienryderflex.com/polygon_fill/
		http://www.amazon.com/dp/1558607323/?tag=stackoverfl08-20
		http://www.amazon.co.uk/s/ref=nb_sb_noss_1?url=search-alias%3Daps&field-keywords=Real-Time+Collision+Detection
		http://en.wikipedia.org/wiki/Line-line_intersection
		http://developer.coronalabs.com/forum/2010/11/17/math-helper-functions-distancebetween-and-anglebetween
		http://www.mathsisfun.com/algebra/vectors-dot-product.html
		http://www.mathsisfun.com/algebra/vector-calculator.html
		http://lua-users.org/wiki/PointAndComplex
		http://www.math.ntnu.no/~stacey/documents/Codea/Library/Vec3.lua
		http://www.iforce2d.net/forums/viewtopic.php?f=4&t=79&sid=b9ecd62533361594e321de04b3929d4f
		http://rosettacode.org/wiki/Dot_product#Lua
		http://chipmunk-physics.net/forum/viewtopic.php?f=1&t=2215
		http://www.fundza.com/vectors/normalize/index.html
		http://www.mathopenref.com/coordpolygonarea2.html
		http://stackoverflow.com/questions/2705542/returning-the-nearest-multiple-value-of-a-number
		http://members.tripod.com/c_carleton/dotprod.html/
		http://www.1728.org/density.htm
]]--

--[[
	Functions:
		nearestMultiple = math.nearest( number, multiple )
		len = lengthOf( a, b )
		{x,y} = rotateTo( point, degrees )
		{x,y} = rotateAboutPoint( point, centre, degrees, round )
		angleOfPoint( pt )
		angleBetweenPoints( a, b )
		angleOf( a, b )
		angle = angleBetween( srcObj, dstObj )
		dot = dotProduct( ax, ay, bx, by )
		extrudeToLen( origin, point, lenOrMin, max )
		smallestAngleDiff( target, source )
		angleAt( centre, first, second )
		isPointInAngle( centre, first, second, point )
		len = normalise(vector)
		dot = dotProduct(a,b)
		dot = dotProductByDimensions( a, b )
		dot = dotProductByCos( a, b )
		cross = crossProduct( a, b )
		cross = b2CrossVectVect( a, b )
		{x,y} = b2CrossVectFloat( a, s )
		{x,y} = b2CrossFloatVect( s, a )
		fractionOf( a, b )
		percentageOf( a, b )
		midPoint( pts )
		midPointOfShape( pts )
		isOnRight( north, south, point )
		reflect( north, south, point )
		math.doLinesIntersect( a, b, c, d )
		GetClosestPoint( A,  B,  P, segmentClamp )
		area = polygonArea( points )
		pointInPolygon( points, dot )
		pointInPolygons( polygons, dot )
		isPolyClockwise( pointList )
		polygonFill( points, closed, perPixel, width, height, col )
		pixelFill( points, closed, perPixel, width, height )
		math.clamp( val, low, high )
		forcesByAngle(totalForce, angle)
]]--

--[[
	Deprecated (see revisions for code):
		rad = convertDegreesToRadians( degrees )
		deg = convertRadiansToDegrees( radians )
		polygonFill( points, closed, perPixel, width, height, col )
]]--

-- rounds up to the nearest multiple of the number
function script_zerger_math_lib:nearestMultiple( number, multiple )
	return script_zerger_math_lib:round( (number / multiple) ) * multiple
end

-- returns the distance between points a and b
-- b is optional. assumes distance from 0,0 if b is nil
function script_zerger_math_lib:lengthOf( a, b )
    if (b == nil) then
        b = {x=0,y=0}
    end
    local width, height = b.x-a.x, b.y-a.y
    return (width*width + height*height)^0.5 -- math.sqrt(width*width + height*height)
        -- nothing wrong with math.sqrt, but I believe the ^.5 is faster
end

-- rotates point around the centre by degrees
-- rounds the returned coordinates using math.round() if round == true
-- returns new coordinates object
function script_zerger_math_lib:rotateAboutPoint( point, degrees, center )
	local pt = { x=point.x - centre.x, y=point.y - centre.y }
	pt = script_zerger_math_lib:rotateTo( pt, degrees )
	pt.x, pt.y = pt.x + centre.x, pt.y + centre.y
	return pt
end

-- rotates a point around the (0,0) point by degrees
-- returns new point object
-- center: optional
function script_zerger_math_lib:rotateTo( point, degrees, center )
	if (center ~= nil) then
		return rotateAboutPoint( point, degrees, center )
	else
		local x, y = point.x, point.y

		local theta = math.rad( degrees )

		local pt = {
			x = x * math.cos(theta) - y * math.sin(theta),
			y = x * math.sin(theta) + y * math.cos(theta)
		}
		
		return pt
	end
end

local PI = (4*math.atan(1))
local quickPI = 180 / PI

-- returns the degrees between two points
-- note: 0 degrees is 'east'
function script_zerger_math_lib:angleBetweenPoints( a, b )
	local x, y = b.x - a.x, b.y - a.y
	return script_zerger_math_lib:angleOf( { x=x, y=y } )
end

-- returns the degrees between (0,0) and pt
-- note: 0 degrees is 'east'
-- center: optional
function script_zerger_math_lib:angleOf( center, pt )
	if (pt == nil) then
		pt = center
		local angle = math.atan2( pt.y, pt.x ) * quickPI -- 180 / PI -- math.pi
		if angle < 0 then angle = 360 + angle end
		return angle
	else
		return script_zerger_math_lib:angleBetweenPoints( center, pt )
	end
end

-- Brent Sorrentino
-- Returns the angle between the objects
function script_zerger_math_lib:angleBetween ( srcObj, dstObj )
        local xDist = dstObj.x - srcObj.x
        local yDist = dstObj.y - srcObj.y
        local angleBetween = math.deg( math.atan( yDist / xDist ) )
        if ( srcObj.x < dstObj.x ) then
                angleBetween = angleBetween + 90
        else
                angleBetween = angleBetween - 90
        end
        return angleBetween
end

--[[
	Description:
		Extends the point away from or towards the origin to the length of len.
	
	Params:
		max =
			If param max is nil then the lenOrMin value is the distance to calculate the point's location
			If param max is not nil then the lenOrMin value is the minimum clamping distance to extrude to
		lenOrMin = the length or the minimum length to extrude the point's distance to
		max = the maximum length to extrude to
	
	Returns:
		{x,y} = extruded point
]]--
function script_zerger_math_lib:extrudeToLen( origin, point, lenOrMin, max )
	local length = script_zerger_math_lib:lengthOf( origin, point )
	if (length == 0) then
		return origin.x, origin.y
	end
	local len = lenOrMin
	if (max ~= nil) then
		if (length < lenOrMin) then
			len = lenOrMin
		elseif (length > max) then
			len = max
		else -- the point is within the min/max clamping range
			return point.x, point.y
		end
	end
	local factor = len / length
	local x, y = (point.x - origin.x) * factor, (point.y - origin.y) * factor
	return x + origin.x, y + origin.y, x, y
end

-- returns the smallest angle between the two angles
-- ie: the difference between the two angles via the shortest distance
-- returned value is signed: clockwise is negative, anticlockwise is positve
-- returned value wraps at +/-180
-- Example code to rotate a display object by touch:
--[[
	-- called in the "moved" phase of touch event handler
	local a = mathlib.angleBetweenPoints( target, target.prevevent )
	local b = mathlib.angleBetweenPoints( target, event )
	local d = mathlib.smallestAngleDiff( a, b )
	target.prev = event
	target.rotation = target.rotation - d
]]--
function script_zerger_math_lib:smallestAngleDiff( target, source )
	local a = target - source

	if (a > 180) then
		a = a - 360
	elseif (a < -180) then
		a = a + 360
	end

	return a
end

-- Returns the angle in degrees between the first and second points, measured at the centre
-- Always a positive value
function script_zerger_math_lib:angleAt( centre, first, second )
	local a, b, c = centre, first, second
	local ab = script_zerger_math_lib:lengthOf( a, b )
	local bc = script_zerger_math_lib:lengthOf( b, c )
	local ac = script_zerger_math_lib:lengthOf( a, c )
	local angle = math.deg( math.acos( (ab*ab + ac*ac - bc*bc) / (2 * ab * ac) ) )
	return angle
end

-- Returns true if the point is within the angle at centre measured between first and second
function script_zerger_math_lib:isPointInAngle( centre, first, second, point )
	local range = angleAt( centre, first, second )
	local a = angleAt( centre, first, point )
	local b = angleAt( centre, second, point )
	-- print(range,a+b)
	return script_zerger_math_lib:round(range) >=script_zerger_math_lib:round(a + b)
end

--[[
	Performs unit normalisation of a vector.
	
	Description:
		Unit normalising is basically converting the length of a line to be a fraction of 1.0
		This function modified the vector value passed in and returns the length as returned by lengthOf()
	
	Note:
		Can also be performed like this:
		function Normalise(vector)
			local x,y = 	x/(x^2 + y^2)^(1/2), y/(x^2 + y^2)^(1/2)
			local unitVector = {x=x,y=y}
			return unitVector
		end
	
	Ref:
		http://www.fundza.com/vectors/normalize/index.html
]]--
function script_zerger_math_lib:normalise( vector )
	local len = script_zerger_math_lib:lengthOf( vector )
	vector.x = vector.x / len
	vector.y = vector.y / len
	return len
end

--[[
        Calculates the dot product of two lines. The lines are provided as {a,b}
        Each end point of the line objects are of the format {x,y}
        
        Params:
                a - first line, format: {a,b}
                b - second line, format: {a,b}
        
        Example:
                print(dotProduct(
                        {a={x=0,y=0},b={x=101,y=5}},
                        {a={x=0,y=0},b={x=51,y=10}}
                ))
        
        Ref:
                http://www.mathsisfun.com/algebra/vector-calculator.html
]]--
function script_zerger_math_lib:dotProduct( a, b )
        -- get dimensions
        local ax, ay = a.b.x-a.a.x, a.b.y-a.a.y
        local bx, by = b.b.x-b.a.x, b.b.y-b.a.y
        
        -- multiply the x's, multiply the y's, then add
        local dot = ax * bx + ay * by
        return dot
end

--[[
	Calculates the dot product of a pair of vectors.
	
	Example:
		local dot = dotProduct( {x=10,y=5}, {x=5,y=10} )
	
	Ref:
		http://rosettacode.org/wiki/Dot_product#Lua
]]--
function script_zerger_math_lib:dotProduct(a, b)
	--[[local ret = 0
	for i = 1, #a do
		ret = ret + a[i] * b[i]
	end
	return ret]]--
	return a.x*b.x + a.y*b.y + (a.z or 0)*(b.z or 0)
end

--[[
	Dot product of two lengths.
	
	Params:
		lenA - Length A
		lenB - Length B
		deg - Angle between points A and B in degrees
	
	Returns:
		Dot product.
	
	Ref:
		http://www.mathsisfun.com/algebra/vectors-dot-product.html
]]--
function script_zerger_math_lib:dotProductByLenAngle( lenA, lenB, deg )
	return lenA * lenB * math.cos(deg)
end

--[[
        Calculates the dot product of two lines. The lines are provided as {a,b}
        Each end point of the line objects are of the format {x,y}
        This function implements the simple form of the dot product calculation: a Â· b = ax Ã— bx + ay Ã— by
        
        Params:
                a - first line, format: {a,b}
                b - second line, format: {a,b}
        
        Example:
                print(dotProductByDimensions(
                        {a={x=0,y=0},b={x=101,y=5}},
                        {a={x=0,y=0},b={x=51,y=10}}
                ))
        
        Ref:
                http://www.mathsisfun.com/algebra/vectors-dot-product.html
                http://www.mathsisfun.com/algebra/vector-calculator.html
]]--
function script_zerger_math_lib:dotProductByDimensions( a, b )
        -- get dimensions
        local ax, ay = a.b.x-a.a.x, a.b.y-a.a.y
        local bx, by = b.b.x-b.a.x, b.b.y-b.a.y
        
        -- multiply the x's, multiply the y's, then add
        local dot = ax * bx + ay * by
        return dot
end
 
--[[
        Calculates the dot product of two vectors. The vectors are provided as {{x,y},{x,y}}
        Each end point of the line objects are of the format {x,y}
        This function implements the COS form of the dot product calculation: a Â· b = |a| Ã— |b| Ã— cos(?)
        
        Params:
                a - first vector, format: {x,y}
                b - second vector, format: {x,y}
        
        Example:
                print(dotProductByCos(
                        {a={x=10,y=5},b={x=5,y=10}}
                ))
        
        Ref:
                http://www.mathsisfun.com/algebra/vectors-dot-product.html
                http://www.mathsisfun.com/algebra/vector-calculator.html
]]--
function script_zerger_math_lib:dotProductByCos( a, b )
        -- define centre point
        local centre = {x=0,y=0}
        
        -- get angle at intersection
        local angle = angleAt( centre, a, b )
        
        -- get vectors (lengths from 0,0)
        local lena = script_zerger_math_lib:lengthOf( centre, a )
        local lenb = script_zerger_math_lib:lengthOf( centre, b )
        
        -- multiply the x's, multiply the y's, then add
        local dot = lena * lenb * math.cos( angle )
        return dot
end
 
--[[
        Description:
                Calculates the cross product of a vector.
        
        Ref:
                http://www.math.ntnu.no/~stacey/documents/Codea/Library/Vec3.lua
]]--
function script_zerger_math_lib:crossProduct( a, b )
        local x, y, z
        x = a.y * (b.z or 0) - (a.z or 0) * b.y
        y = (a.z or 0) * b.x - a.x * (b.z or 0)
        z = a.x * b.y - a.y * b.x
        return { x=x, y=y, z=z }
end
 
--[[
        Description:
                Perform the cross product on two vectors. In 2D this produces a scalar.
        
        Params:
                a: {x,y}
                b: {x,y}
        
        Ref:
                http://www.iforce2d.net/forums/viewtopic.php?f=4&t=79&sid=b9ecd62533361594e321de04b3929d4f
]]--
function script_zerger_math_lib:b2CrossVectVect( a, b )
        return a.x * b.y - a.y * b.x;
end
 
--[[
        Description:
                Perform the cross product on a vector and a scalar. In 2D this produces a vector.
        
        Params:
                a: {x,y}
                b: float
        
        Ref:
                http://www.iforce2d.net/forums/viewtopic.php?f=4&t=79&sid=b9ecd62533361594e321de04b3929d4f
]]--
function script_zerger_math_lib:b2CrossVectFloat( a, s )
        return { x = s * a.y, y = -s * a.x }
end
 
--[[
        Description:
                Perform the cross product on a scalar and a vector. In 2D this produces a vector.
        
        Params:
                a: float
                b: {x,y}
        
        Ref:
                http://www.iforce2d.net/forums/viewtopic.php?f=4&t=79&sid=b9ecd62533361594e321de04b3929d4f
]]--
function script_zerger_math_lib:b2CrossFloatVect( s, a )
        return { x = -s * a.y, y = s * a.x }
end
 
-- Returns b represented as a fraction of a.
-- Eg: If a is 1000 and b is 900 the returned value is 0.9
-- Often the returned value would be used in a multiplication of another value, usually a distance value.
function script_zerger_math_lib:fractionOf( a, b )
        return b / a
end
 
-- Returns b represented as a percentage of a.
-- Eg: If a is 1000 and b is 900 the returned value is 90
-- Use: This is useful in determining how far something should be moved to complete a certain distance.
-- Often the returned value would be used in a division of another value, usually a distance value.
function script_zerger_math_lib:percentageOf( a, b )
        return script_zerger_math_lib:fractionOf(a, b) * 100
end

--[[
        Description:
                Calculates the average of all the x's and all the y's and returns the average centre of all points.
                Works with a display group or table proceeding { {x,y}, {x,y}, ... }
        
        Params:
                pts = list of {x,y} points to get the average middle point from
        
        Returns:
                {x,y} = average centre location of all the points
]]--
function script_zerger_math_lib:midPoint( ... )
	local pts = arg
	
	--local x, y, c = 0, 0, #pts  todo fix error with # ...
	if (pts.numChildren and pts.numChildren > 0) then c = pts.numChildren end
	for i=1, c do
		x = x + pts[i].x
		y = y + pts[i].y
	end
	return { x=x/c, y=y/c }
end
 
--[[
        Description:
                Calculates the average of all the x's and all the y's and returns the average centre of all points.
                Works with a table proceeding {x,y,x,y,...} as used with display.newLine or physics.addBody
        
        Params:
                pts = table of x,y values in sequence
        
        Returns:
                x, y = average centre location of all points
]]--
function script_zerger_math_lib:midPointOfShape( pts )
       -- local x, y, c, t = 0, 0, #pts, #pts/2 todo fix error with # ...
        for i=1, c-1, 2 do
                x = x + pts[i]
                y = y + pts[i+1]
        end
        return x/t, y/t
end
 
-- returns true when the point is on the right of the line formed by the north/south points
function script_zerger_math_lib:isOnRight( north, south, point )
        local a, b, c = north, south, point
        local factor = (b.x - a.x)*(c.y - a.y) - (b.y - a.y)*(c.x - a.x)
        return factor > 0, factor
end
 
-- reflect point across line from north to south
function script_zerger_math_lib:reflect( north, south, point )
        local x1, y1, x2, y2 = north.x, north.y, south.x, south.y
        local x3, y3 = point.x, point.y
        local x4, y4 = 0, 0 -- reflected point
        local dx, dy, t, d
 
        dx = y2 - y1
        dy = x1 - x2
        t = dx * (x3 - x1) + dy * (y3 - y1)
        t = t / (dx * dx  +  dy * dy)
 
        x = x3 - 2 * dx * t
        y = y3 - 2 * dy * t
 
        return { x=x, y=y }
end
 
-- This is based off an explanation and expanded math presented by Paul Bourke:
-- It takes two lines as inputs and returns true if they intersect, false if they don't.
-- If they do, ptIntersection returns the point where the two lines intersect.
-- params a, b = first line
-- params c, d = second line
-- param ptIntersection: The point where both lines intersect (if they do)
-- http://local.wasp.uwa.edu.au/~pbourke/geometry/lineline2d/
-- http://paulbourke.net/geometry/pointlineplane/
function script_zerger_math_lib:doLinesIntersect( a, b, c, d )
        -- parameter conversion
        local L1 = {X1=a.x,Y1=a.y,X2=b.x,Y2=b.y}
        local L2 = {X1=c.x,Y1=c.y,X2=d.x,Y2=d.y}
        
        -- Denominator for ua and ub are the same, so store this calculation
        local d = (L2.Y2 - L2.Y1) * (L1.X2 - L1.X1) - (L2.X2 - L2.X1) * (L1.Y2 - L1.Y1)
        
        -- Make sure there is not a division by zero - this also indicates that the lines are parallel.
        -- If n_a and n_b were both equal to zero the lines would be on top of each
        -- other (coincidental).  This check is not done because it is not
        -- necessary for this implementation (the parallel check accounts for this).
        if (d == 0) then
                return false
        end
        
        -- n_a and n_b are calculated as seperate values for readability
        local n_a = (L2.X2 - L2.X1) * (L1.Y1 - L2.Y1) - (L2.Y2 - L2.Y1) * (L1.X1 - L2.X1)
        local n_b = (L1.X2 - L1.X1) * (L1.Y1 - L2.Y1) - (L1.Y2 - L1.Y1) * (L1.X1 - L2.X1)
        
        -- Calculate the intermediate fractional point that the lines potentially intersect.
        local ua = n_a / d
        local ub = n_b / d
        
        -- The fractional point will be between 0 and 1 inclusive if the lines
        -- intersect.  If the fractional calculation is larger than 1 or smaller
        -- than 0 the lines would need to be longer to intersect.
        if (ua >= 0 and ua <= 1 and ub >= 0 and ub <= 1) then
                local x = L1.X1 + (ua * (L1.X2 - L1.X1))
                local y = L1.Y1 + (ua * (L1.Y2 - L1.Y1))
                return true, {x=x, y=y}
        end
        
        return false
end
 
-- returns the closest point on the line between A and B from point P
function script_zerger_math_lib:GetClosestPoint( A,  B,  P, segmentClamp )
    local AP = { x=P.x - A.x, y=P.y - A.y }
    local AB = { x=B.x - A.x, y=B.y - A.y }
    local ab2 = AB.x*AB.x + AB.y*AB.y
    local ap_ab = AP.x*AB.x + AP.y*AB.y
    local t = ap_ab / ab2
 
    if (segmentClamp or true) then
         if (t < 0.0) then
                t = 0.0
         elseif (t > 1.0) then
                t = 1.0
         end
    end
 
    local Closest = { x=A.x + AB.x * t, y=A.y + AB.y * t }
 
    return Closest
end

-- calculates the area of a polygon
-- will not calculate area for self-intersecting polygons (where vertices cross each other)
-- points: table of {x,y} points
-- ref: http://www.mathopenref.com/coordpolygonarea2.html
function script_zerger_math_lib:polygonArea( points )
	--local count = #points todo fix error with # ...
	if (points.numChildren) then -- fix error in next line
		--count = "
	end
	
	local area = 0 -- Accumulates area in the loop
	local j = count -- The last vertex is the 'previous' one to the first
	
	for i=1, count do
		area = area +  (points[j].x + points[i].x) * (points[j].y - points[i].y)
		j = i -- j is previous vertex to i
	end
	
	return math.abs(area/2)
end

-- Returns true if the dot { x,y } is within the polygon defined by points table { {x,y},{x,y},{x,y},... }
function script_zerger_math_lib:pointInPolygon( points, dot )
       -- local i, j = #points, #points todo fix error with # ...
        local oddNodes = false
 
        --for i=1, #points do todo fix error with # ...
                if ((points[i].y < dot.y and points[j].y>=dot.y
                        or points[j].y< dot.y and points[i].y>=dot.y) and (points[i].x<=dot.x
                        or points[j].x<=dot.x)) then
                        if (points[i].x+(dot.y-points[i].y)/(points[j].y-points[i].y)*(points[j].x-points[i].x)<dot.x) then
                                oddNodes = not oddNodes
                        end
                end
                j = i
       -- end removed comment here when # issue is fixed
 
        return oddNodes
end

-- converts a table of {x,y,x,y,...} to points {x,y}
function script_zerger_math_lib:tableToPoints( tbl )
	local pts = {}
	
	--for i=1, #tbl-1, 2 do todo fix error with # ...
	--	pts[#pts+1] = { x=tbl[i], y=tbl[i+1] }
	--end
	
	return pts
end

-- converts a list of points {x,y} to a table of coords {x,y,x,y,...}
function script_zerger_math_lib:pointsToTable( pts )
	local tbl = {}
	
	--for i=1, #pts do todo fix error with # ...
		--tbl[#tbl+1] = pts[i].x
	--	tbl[#tbl+1] = pts[i].y
	--end
	
	return tbl
end

-- Return true if the dot { x,y } is within any of the polygons in the list
function script_zerger_math_lib:pointInPolygons( polygons, dot )
     --[[   for i=1, #polygons do
                if (pointInPolygon( polygons[i], dot )) then
                        return true
                end
        end
       --]] return false
end
 
-- Returns true if the points in the polygon wind clockwise
-- Does not consider that the vertices may intersect (lines between points might cross over)
function script_zerger_math_lib:isPolyClockwise( pointList )
        local area = 0
       --[[ 
        if (type(pointList[1]) == "number") then
        	pointList = math.convertCoordsToTable( pointList )
        	print("#pointList",#pointList)
        end
        
        for i = 1, #pointList-1 do
                local pointStart = { x=pointList[i].x - pointList[1].x, y=pointList[i].y - pointList[1].y }
                local pointEnd = { x=pointList[i + 1].x - pointList[1].x, y=pointList[i + 1].y - pointList[1].y }
                area = area + (pointStart.x * -pointEnd.y) - (pointEnd.x * -pointStart.y)
        end
        
        return (area < 0)
		--]]
end

-- return a value clamped between a range
function script_zerger_math_lib:clamp( val, low, high )
	if (val < low) then return low end
	if (val > high) then return high end
	return val
end
 
-- Forces to apply based on total force and desired angle
-- http://developer.anscamobile.com/code/virtual-dpadjoystick-template
function script_zerger_math_lib:forcesByAngle(totalForce, angle)
	local forces = {}
	local radians = -math.rad(angle)

	forces.x = math.cos(radians) * totalForce
	forces.y = math.sin(radians) * totalForce

	return forces
end

-- returns true if the middle point is concave when viewed as part of a polygon
-- a, b, c are {x,y} points
function script_zerger_math_lib:isPointConcave(a,b,c)
	local small = smallestAngleDiff( math.angleOf(b,a), math.angleOf(b,c) )

	if (small < 0) then
		return false
	else
		return true
	end
end

-- returns true if the polygon is concave
-- assumes points are {x,y} tables
-- returns nil if there are not enough points ( < 3 )
-- can accept a display group
function script_zerger_math_lib:isPolygonConcave( points )
	local count = points.numChildren
	if (count == nil) then
		--count = #points
	end
	
	if (count < 3) then
		return nil
	end
	
	local isConcave = true
	
	for i=1, count do
		if (i == 1) then
			isConcave = script_zerger_math_lib:isPointConcave( points[count],points[1],points[2] )
		elseif (i == count) then
			isConcave = script_zerger_math_lib:isPointConcave( points[count-1],points[count],points[1] )
		else
			isConcave = script_zerger_math_lib:isPointConcave( points[i-1], points[i], points[i+1] )
		end
		
		if (not isConcave) then
			return false
		end
	end
	
	return true
end

-- returns list of points where a polygon intersects with the line a,b
-- assumes polygon is standard display format: { x,y,x,y,x,y,x,y, ... }
-- returns collection of intersection points with the polygon line's index {x,y,lineIndex}
-- sort: true to sort the points into order from a to b
function script_zerger_math_lib:polygonLineIntersection( polygon, a, b, sort )
	local points = {}
	--[[
	for i=1, #polygon-3, 2 do
		local success, pt = math.doLinesIntersect( a, b, { x=polygon[i], y=polygon[i+1] }, { x=polygon[i+2], y=polygon[i+3] } )
		
		if (success) then
			pt.lineIndex = i
			points[ #points+1 ] = pt
		end
	end
	
	if (sort) then
		table.sort( points, function(a,b) return script_zerger_math_lib:lengthOf(e,a) > script_zerger_math_lib:lengthOf(e,b) end )
	end
	--]]
	return points
end
