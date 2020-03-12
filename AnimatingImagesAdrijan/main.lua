-----------------------------------------------------------------------------------------
--Name: Adrijan
--Class: ICS20
--This program has a backgroung, displays 3 images that all move, and some colored text.
-----------------------------------------------------------------------------------------

--Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

--------------------------------------------------------------
-- LOCAL VARIABLES
-------------------------------------------------------------

--Set the background
local backgroundImage = display.newImageRect( "Images/FamilyGuy.png", 1024, 1000)
backgroundImage.x = 512
backgroundImage.y = 359
backgroundImage.alpha = 1

--adding the next background
local barBackground = display.newImageRect("Images/Bar.png", 1024, 780)
barBackground.isVisible = false
barBackground.x = 512
barBackground.y = 390

--Making Peter
local Peter = display.newImageRect("Images/PeterPimp.png",100, 200)
Peter.x = 100
Peter.y = 600

--making Mike
local Mike = display.newImageRect("Images/Mike.png", 300, 500)
Mike.x = 880
Mike.y = 580

--Making Spongebob
local Spongebob = display.newImageRect("Images/Spongebob.png",100, 200)
Spongebob.x = 30
Spongebob.y = 670

--Making the Polygon/Lazer
local Lazer = display.newLine( 30, 670, 880, 450 )
Lazer.alpha = 1
Lazer.strokeWidth = 12
Lazer:setStrokeColor(255/255, 0/255, 0/255)

--Setting text size for all texts
local textSize = 45

--Creating the first text 
local zapText = display.newText("Mike finally found Spongebob and "
	.. "Peter, he tried to  \n zap him with his lazer but they just"
	.. " got away", 0, 0, Arial, textSize)
zapText.x = 525
zapText.y = 50
zapText:setFillColor(255/255, 0/255, 0/255)
zapText.alpha = 1

--Setting the scrollSpeed
scrollSpeed = -13

--Making the second text
local peterZapText = display.newText("Mike finally found Peter and zapped him with \n his shrink ray.", 0, 0, Arial, textSize )
peterZapText.x = 525
peterZapText.y = 50
peterZapText:setFillColor(255/255, 0/255, 0/255)
peterZapText.alpha = 0


--making mikescrollSpeed
local mikescrollSpeed = 1

--setting peterScrollSpeed
local peterScrollSpeed = 2

--add the zap noise
local zapNoise = audio.loadSound("Sounds/Zap.mp3")
local zapNoiseChannel
--------------------------------------------------------------
-- LOCAL FUNCTIONS
-------------------------------------------------------------
--function: MovingLeft
--Output: this function acceptsthe event listener
--input: none
--Description: It makes Mike move side to side 
MovingLeft = true

local function MoveLeft(event)
	if (movingLeft == true) then
		Mike.x = Mike.x - mikescrollSpeed
	else 
		Mike.x = Mike.x + mikescrollSpeed

	end

	if (Mike.x < 860) then
		movingLeft = false
	end

	if (Mike.x > 900) then
		movingLeft = true
	end
end

-- Function: MoveSponge
--Input: this function accepts an event listener
--Output: none 
--Description This function adds the scroll speed to the x-value of Spongebob
local function Zap(event)
    -- change the transparentcy of the lazer so it zaps Spongebob
	Lazer.alpha = Lazer.alpha - 0.1
	--display the writing
	zapText.alpha = zapText.alpha - 0.0000001
	zapNoiseChannel = audio.play( zapNoise, {duration=3000} )
	
end


--Function: MoveSponge
--Input: this function accepts an event listener
--Output: none
--Description: Spongebob gets moved Diagonally and spins after he gets zapped
local function MoveSponge (event)
    -- add the scroll speed to the x-value of the ship
	Spongebob.y = Spongebob.y + scrollSpeed	
	Spongebob.x = Spongebob.x - scrollSpeed
	Spongebob:rotate( 35 )
end

--Function: MovePeter
--Input: this function accepts an event listener
--Output: none
--Description: peter moves Diagonally and fades out 
local function MovePeter(event)
	Peter.x = Peter.x + peterScrollSpeed
	Peter.y = Peter.y + (peterScrollSpeed - 3)
	Peter.alpha = Peter.alpha - 0.001
end

--Function: MovePeterDelay
--Input: this function accepts an event listener
--Output: none
--Description: This sets MovePeter to happen with a delay 
local function MovePeterDelay()
	--MovePeter will be called over and over again
	Runtime:removeEventListener("enterFrame", Zap)
	Runtime:removeEventListener("enterFrame", MoveSponge)
	Runtime:addEventListener("enterFrame", MovePeter)
end


--Function: changeBackgroundDelay
--Input: this function accepts an event listener
--Output: none
--Description: this changes the background on queue,
-- and sets peter to position for the next scene
-- 
local function changeBackgroundDelay()
	--MovePeter will be called over and over again
	Runtime:removeEventListener("enterFrame", MovePeter)
	backgroundImage.isVisible = false
	barBackground.isVisible = true
	Peter.x = 200
	Peter.y = 600
	Peter.isVisible = true
	Peter.alpha = 1
	zapText.isVisible = false
end
--Function; zapPeter
--Input:this function accepts an event listener
--Output: none
--Description: this adds the lazer again,
-- shrinks peter, and set the position of Mike
local function zapPeter(event)
	Runtime:removeEventListener("enterFrame", MoveLeft)
	Mike.x = 880
	Mike.y = 580
	Lazer.isVisible = true
	Lazer.alpha = 1
	Peter.xScale = Peter.xScale - 0.5
	Peter.yScale = Peter.yScale - 0.5
	peterZapText.alpha = peterZapText.alpha + 1
	
end

	



--------------------------------------------------------------
-- FUNCTION CALLS
-------------------------------------------------------------
--Zap will be called over and over again
Runtime:addEventListener("enterFrame", Zap)

--MoveSponge will be called over and over again
Runtime:addEventListener("enterFrame", MoveSponge)

--MovePeterDelay will delay this Function by 1 second
timer.performWithDelay(1000, MovePeterDelay)

-- changeBackgroundDelay will delay the Function by 4 seconds 
timer.performWithDelay(4000, changeBackgroundDelay)

--zapPeter will play the Function with a delay of 5 seconds
timer.performWithDelay(5000, zapPeter)

--MoveLeft will be called over and over again
Runtime:addEventListener("enterFrame", MoveLeft)
