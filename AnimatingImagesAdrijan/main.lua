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

--Making Peter
local Peter = display.newImageRect("Images/PeterPimp.png",100, 200)
Peter.x = 100
Peter.y = 600

--making Mike
local Mike = display.newImageRect("Images/Mike.png", 300, 500)
Mike.x = 880
Mike.y = 580

local Spongebob = display.newImageRect("Images/Spongebob.png",100, 200)
Spongebob.x = 30
Spongebob.y = 670

--Making the Polygon/Lazer
local Lazer = display.newLine( 30, 670, 880, 450 )
Lazer.alpha = 1
Lazer.strokeWidth = 12
Lazer:setStrokeColor(255/255, 0/255, 0/255)

local textSize = 45

--Create text
local zapText = display.newText("Mike finally found Spongebob and "
	.. "Peter, he tried to  \n zap him with his lazer but they just"
	.. " got away", 0, 0, Arial, textSize)
zapText.x = 525
zapText.y = 50
zapText:setFillColor(255/255, 0/255, 0/255)
zapText.alpha = 1

--global variable
scrollSpeed = -10

--adding the next background
local barBackground = display.newImageRect("Images/Bar.png", 1024, 780)
barBackground.isVisible = false
barBackground.x = 512
barBackground.y = 390

--setting peterScrollSpeed
local peterScrollSpeed = 2

--------------------------------------------------------------
-- LOCAL FUNCTIONS
-------------------------------------------------------------

-- Function: MoveSponge
--Input: this function accepts an event listener
--Output: none 
--Description This function adds the scroll speed to the x-value of Spongebob
local function Zap(event)
    -- change the transparentcy of the lazer so it zaps Spongebob
	Lazer.alpha = Lazer.alpha - 0.1
	--display the writing
	zapText.alpha = zapText.alpha - 0.00001
	
end

local function MoveSponge (event)
    -- add the scroll speed to the x-value of the ship
	Spongebob.y = Spongebob.y + scrollSpeed	
	Spongebob:rotate( 20 )
end

local function MovePeter(event)
	Peter.x = Peter.x + peterScrollSpeed
	Peter.y = Peter.y + (peterScrollSpeed - 3)
	Peter.alpha = Peter.alpha - 0.001
end

local function MovePeterDelay()
	--MovePeter will be called over and over again
	Runtime:removeEventListener("enterFrame", Zap)
	Runtime:removeEventListener("enterFrame", MoveSponge)
	Runtime:addEventListener("enterFrame", MovePeter)
end



local function changeBackgroundDelay()
	--MovePeter will be called over and over again
	Runtime:removeEventListener("enterFrame", MovePeter)
	backgroundImage.isVisible = false
	barBackground.isVisible = true
end

--------------------------------------------------------------
-- FUNCTION CALLS
-------------------------------------------------------------
--Zap will be called over and over again
Runtime:addEventListener("enterFrame", Zap)

--MoveSponge will be called over and over again
Runtime:addEventListener("enterFrame", MoveSponge)

timer.performWithDelay(1000, MovePeterDelay)


timer.performWithDelay(4000, changeBackgroundDelay)