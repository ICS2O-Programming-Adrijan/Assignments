-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL SOUNDS
-----------------------------------------------------------------------------------------

local logoSound = audio.loadSound("Sounds/logoSound.mp3")
local logoSoundChannel
----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local logoText

local centerTree

local leftTree

local rightTree

local bkg

local alphaSpeed = 0.01

local scrollSpeed = 4

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------
local function TreeMovement1()
    centerTree.isVisible = true
    centerTree.x = centerTree.x + 200
    centerTree.y = centerTree.y + 200
end

local function TreeMovement2()
    centerTree.x = centerTree.x + 600
    centerTree.y = centerTree.y + 500
end

local function TreeMovement3()
    centerTree.x = centerTree.x 
    centerTree.y = centerTree.y - 600
end

local function TreeMovement4()
    centerTree.x = centerTree.x - 700
    centerTree.y = centerTree.y + 500
end

local function TreeMovement5()
    centerTree.x = 512
    centerTree.y = 450
end

local function BkgRotation()
    bkg.alpha = bkg.alpha + alphaSpeed
    logoText:rotate(1.9)
end

local function LeftTreeMovement()
    leftTree.isVisible = true
    leftTree.x = leftTree.x - scrollSpeed 
    if leftTree.x >= 400 then
        leftTree.x = leftTree.x
    end
end

local function RightTreeMovement()
    rightTree.xScale = rightTree.xScale + 0.01
    rightTree.yScale = rightTree.yScale + 0.01
end









-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    

    -- set the background to be black
    display.setDefault("background", 0, 0, 0)

    

    --Creating all the rastorized images 
    rightTree = display.newImageRect("Images/rightTree.png", 200, 125)
    rightTree.x = 700
    rightTree.y = 450


    leftTree = display.newImageRect("Images/leftTree.png", 400, 250)
    leftTree.x = 1024
    leftTree.y = 450
    leftTree.isVisible = false

    centerTree = display.newImageRect("Images/centerTree.png", 400, 250)
    centerTree.x = 0
    centerTree.y = 0
    centerTree.isVisible = false

    bkg = display.newImageRect("Images/background.png", 700,500)
    bkg.x = 512
    bkg.y = 384
    bkg.alpha = 0

    logoText = display.newImageRect("Images/Text.png", 650, 400)
    logoText.x = 512
    logoText.y = 290    
end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        

        -- start the splash screen music
        logoSoundChannel = audio.play(logoSound )

        Runtime:addEventListener("enterFrame", RightTreeMovement)

        Runtime:addEventListener("enterFrame", LeftTreeMovement)

        timer.performWithDelay(500, TreeMovement1)
        timer.performWithDelay(1000, TreeMovement2)
        timer.performWithDelay(1500, TreeMovement3)
        timer.performWithDelay(2000, TreeMovement4)
        timer.performWithDelay(2500, TreeMovement5)

        Runtime:addEventListener("enterFrame", BkgRotation)

        



        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 3000, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        bkg.isVisible = false
        logoText.isVisible = false
        centerTree.isVisible = false
        leftTree.isVisible = false
        rightTree.isVisible = false

        -- stop the jungle sounds channel for this screen
        audio.stop(logoSoundChannel)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )




-----------------------------------------------------------------------------------------

return scene
