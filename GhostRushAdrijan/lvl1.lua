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

-- End Walls 
local endWallL1
local endWallL2
local endWallL3
local endWallR1
local endWallR2
local endWallR3
local endGateR
local endGateL

--Walls numbers go from bottom to top
local wall1 
local wall2
local wall3
local wall4
local wall5
local wall6
local wall7
local wall8
local wall9
local wall11
local wall12
local wall13
local wall14
local wall14


-- Gate walls
local leftGateWall1
local leftGateWall2
local leftGateWall1
local leftGatewall2
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
    ghost1.y = ghost1.y + scrollSpeed5
    if (ghost1.y > 150) then
        ghost1.y = 150
        ghost1.x = ghost1.x + scrollSpeed5
    end

    if (ghost1.x > 812) then
        ghost1.x = 812
        ghost1.y = ghost1.y + scrollSpeed5
    end
    if (ghost1.y > 730) then
        ghost1.y = 730
    end
end 
local function AddPhysics()
    physics.addBody(ghost1, "static", {density=1, friction=0.3, bounce=0.2})
    physics.addBody(pacGuy, "static", { density=0, friction=0.5, bounce=0, rotation=0 } )
    physics.addBody(wall1, "static", { density=1, friction=0.3, bounce=0.2} )   
end  

local function RightToLeftGate()
    if ( pacGuy.x > 1024) then
        if (pacGuy.y > 415) then
            if (pacGuy.y < 500) then
                pacGuy.x = 20
            end
        end
    end
end

local function LeftToRightGate()
    if ( pacGuy.x < 0) then
        if (pacGuy.y > 415) then
            if (pacGuy.y < 500) then
                pacGuy.x = 1000
            end
        end
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
    pacGuy = display.newImageRect("Images/PacManOpen.png", 5, 5)
    pacGuy.x = 512
    pacGuy.y = 710
    pacGuy.width = 50
    pacGuy.height = 50

    ghost1 = display.newImageRect("Images/PacManClosed.png", 50, 50)
    ghost1.x = 512
    ghost1.y = 30

    startWall = display.newImageRect("Images/wall1.png", 200, 25)
    startWall.x = 512
    startWall.y = 768

    wall1 = display.newImageRect("Images/wall2.png", 25, 100)
    wall1.x = 600
    wall1.y = 500

    wall2 = display.newImageRect("Images/wall1.png", 100, 25)
    wall2.x = 512
    wall2.y = 650


    wall3 = display.newImageRect("Images/wall1.png", 150, 25)
    wall3.x = 537
    wall3.y = 460

    wall4 = display.newImageRect("Images/wall1.png", 100, 25)
    wall4.x = 537
    wall4.y = 370

    wall5 = display.newImageRect("Images/wall2.png", 25, 100)
    wall5.x = 580
    wall5.y = 333

    wall6 = display.newImageRect("Images/wall1.png", 190, 25)
    wall6.x = 662
    wall6.y = 295

    wall7 = display.newImageRect("Images/wall1.png", 100, 25)
    wall7.x = 900
    wall7.y = 260

    wall8 = display.newImageRect("Images/wall2.png", 25, 100)
    wall8.x = 870
    wall8.y = 640

    wall9 = display.newImageRect("Images/wall2.png", 25, 140)
    wall9.x = 880
    wall9.y = 341

   

    wall11 = display.newImageRect("Images/wall1.png", 100, 25)
    wall11.x = 730
    wall11.y = 450

    wall12 = display.newImageRect("Images/wall2.png", 25, 100)
    wall12.x = 730
    wall12.y = 600

    wall13 = display.newImageRect("Images/wall2.png", 25, 120)
    wall13.x = 870
    wall13.y = 125

    wall14 = display.newImageRect("Images/wall2.png", 25, 110)
    wall14.x = 745
    wall14.y = 253

   
    --END WALLS-----------------------------------------------
    endWallR1 = display.newImageRect("Images/wall1.png", 100, 25)
    endWallR1.x = 1000
    endWallR1.y = 50

    endWallR2 = display.newImageRect("Images/wall1.png", 100, 25)
    endWallR2.x = 860
    endWallR2.y = 50

    endWallR3 = display.newImageRect("Images/wall1.png", 100, 25)
    endWallR3.x = 720
    endWallR3.y = 50


    endWallL3 = display.newImageRect("Images/wall1.png", 100, 25)
    endWallL3.x = 304
    endWallL3.y = 50

    endWallL2 = display.newImageRect("Images/wall1.png", 100, 25)
    endWallL2.x = 164
    endWallL2.y = 50

    endWallR3 = display.newImageRect("Images/wall1.png", 100, 25)
    endWallR3.x = 24
    endWallR3.y = 50

    endGateL = display.newImageRect("Images/wall2.png", 25, 100)
    endGateL.x = 455
    endGateL.y = 10

    endGateR = display.newImageRect("Images/wall2.png", 25, 100)
    endGateR.x = 574
    endGateR.y = 10

    --Gate walls-----------------------------------------------------------
    leftGateWall1 = display.newImageRect("Images/wall1.png", 80, 25)
    leftGateWall1.x = 24
    leftGateWall1.y = 500

    leftGatewall2 = display.newImageRect("Images/wall1.png", 80, 25)
    leftGatewall2.x = 24
    leftGatewall2.y = 415

    rightGatewall1 = display.newImageRect("Images/wall1.png", 80, 25)
    rightGatewall1.x = 1000
    rightGatewall1.y = 500

    rightGatewall2 = display.newImageRect("Images/wall1.png", 80, 25)
    rightGatewall2.x = 1000
    rightGatewall2.y = 415


    


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

        physics.setGravity( 0, GRAVITY )
        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        AddPhysics()
        

        --add the respective listeners to each object
        Runtime:addEventListener("enterFrame", LeftToRightGate)
        Runtime:addEventListener("enterFrame", RightToLeftGate)
        Runtime:addEventListener("enterFrame", Ghost1Move)
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
