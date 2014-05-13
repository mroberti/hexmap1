--
-- Project: HexBlog
-- Description: 
--
-- Version: 1.0
-- Managed with http://CoronaProjectManager.com
--
-- Copyright 2011 Mario Roberti. All Rights Reserved.
-- 
local mapWidth = 10
local mapHeight = 10
local yOffset = 115
local xOffset = 98

local function ClickHandler(event) 
	if(event.phase=="ended")then
		print("Clicked on "..event.target.name)
	end
	return true 
end 

-- Here's our text map, that we can parse out whilst
-- making our displayImages below
textMap = {}
textMap[1]="1111111111"
textMap[2]="1000000001"
textMap[3]="1000000001"
textMap[4]="1001111001"
textMap[5]="1111001001"
textMap[6]="1001001001"
textMap[7]="1001111001"
textMap[8]="1000000001"
textMap[9]="1000000001"
textMap[10]="1111111111"


myMap = {}
for y=1,mapHeight do
	myMap[y] = {}     -- create a new row
	for x=1,mapWidth do
		-- OK, we're making our actual object a table that we 
		-- can throw goodies in later on...
		myMap[y][x] = {}
		-- We'll assign the variable 'value' a text value so we can parse
		-- it later on
		
		-- Here's where we'll randomize it a little bit
		--local tempValue = math.random(0,1)
		
		-- Instead of randomizing it as above, we'll actually
		-- parse out our text map as made above. Remember, the hex
		-- based nature of the map will make things look a little
		-- wonky..:)
		
		
		local fileName = ""
		local tempValue = string.sub(textMap[y], x, x) -- This will go to the 'xth' place in the string and give us the character at 'x'
		if(tempValue=="0")then
			myMap[y][x].value = "0"
			fileName="ocean.png"
		elseif(tempValue=="1") then
			myMap[y][x].value = "1"	
			fileName="grass.png"
		else
			myMap[y][x].value = "2"	
			fileName="desert.png"
		end		
		-- We'll assign the variable 'graphic' a newImage value
		-- and we're loading from the fileName selected above
		-- depending on which random number we picked
		myMap[y][x].graphic = display.newImage(fileName)
		-- Let's name the graphic to return a name when
		-- it's clicked!
		myMap[y][x].graphic.name = x..","..y
		-- Add event handler to the graphic
		myMap[y][x].graphic:addEventListener("touch", ClickHandler )
		-- Handle the offset by using modulo to determine
		-- if we're on an even or odd column, and adjust the
		-- spacing accordingly
		if math.mod(x, 2) == 0 then
			--print("even")
			myMap[y][x].graphic.x = x*xOffset
			myMap[y][x].graphic.y = (y * yOffset)
		else
			--print("odd")
			myMap[y][x].graphic.x = x*xOffset
			myMap[y][x].graphic.y = (y * yOffset) - (yOffset / 2)
		end
	end
end
