-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )
local physics = require("physics")

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level1_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------



local scrollSpeed15 = 15
local scrollSpeed5 = 5
local scrollSpeed10 = 10

-- The local variables for this scene
local bkg_image

local pacGuy 

local alreadyTouchedPacGuy = false

local ghost1 
--------------------------------------------------------
--ALL WALLS
----------------------------------------------------------
local startWall 



local wall1 

---------------------------------------------------------
--LOCAL FUNCTIONS
---------------------------------------------------------
--Function: PacGuyListener
--Input: touch listener
--output: none
--Desription: when Blue girl is touched, move her
local function PacGuyListener(touch)

   if (touch.phase == "began") then 
        alreadyTouchedPacGuy = true
   end
    if ( (touch.phase == "moved")) and (alreadyTouchedPacGuy == true) then
      pacGuy.x = touch.x
        pacGuy.y = touch.y
    end

    if (touch.phase == "ended") then
     alreadyTouchedPacGuy = false
    end
end

local function Ghost1Move()
    ghost1.y = ghost1.y + scrollSpeed15
    if (ghost1.y > 150) then
        ghost1.y = 150
        ghost1.x = ghost1.x + scrollSpeed5
    end

    if (ghost1.x > 812) then
        ghost1.x = 812
        ghost1.y = ghost1.y + scrollSpeed10
    end
    if (ghost1.y > 730) then
        ghost1.y = 730
    end
end   


      
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
   --Creating my characters ans walls
    pacGuy = display.newImage("Images/PacManOpen.png", 5, 5)
    pacGuy.x = 512
    pacGuy.y = 740
    pacGuy.width = 50
    pacGuy.height = 50

    ghost1 = display.newImageRect("Images/PacManClosed.png", 50, 50)
    ghost1.x = 512
    ghost1.y = 30

    startWall = display.newImageRect("Images/wall1.png", 200, 25)
    startWall.x = 512
    startWall.y = 650

    wall1 = display.newImageRect("Images/wall2.png", 25, 200)
    wall1.x = 600
    wall1.y = 530

    


    -- Insert the background image
    bkg_image = display.newImageRect("Images/lvl1Bkg.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

        -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )    

end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- start physics
        physics.start()
        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        Runtime:addEventListener("enterFrame", Ghost1Move)

        --add the respective listeners to each object
        pacGuy:addEventListener("touch", PacGuyListener)
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        Runtime:removeEventListener("enterFrame", Ghost1Move)

        --add the respective listeners to each object
        pacGuy:removeEventListener("touch", PacGuyListener)
        -- Called immediately after scene goes off screen.
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
