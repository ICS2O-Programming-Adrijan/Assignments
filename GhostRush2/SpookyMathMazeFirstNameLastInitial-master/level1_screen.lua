-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Ms Raffin
-- Date: Nov. 22nd, 2014
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )
local joystick = require( "joystick" )
local physics = require("physics") 


-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level1_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- DECLARATION LOCAL VARIABLES
-----------------------------------------------------------------------------------------
--Fire balls
local ball1L
local ball2L
local ball3L
local ball1R
local ball2R
local ball3R
local ballSetUp
local ghost1
local scrollSpeed5 = 5
local ghostSetUp
-- The local variables for this scene
userLives = 3
lvNumber = 1
restarted = 0
local bkg_image
local analogStick
local facingWhichDirection = "right"
local joystickPressed = false


--Walls
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
local wall15
local wall16
local wall17
local wall18
local wall19
local wall20
local wall21 
local wall22
local wall23 
local wall24


-- Gate walls
local leftGateWall1
local leftGateWall2
local leftGateWall1
local leftGateWall2
-----------------------------------------------------------------------------------------
-- L0CAL FUNCTIONS
-----------------------------------------------------------------------------------------
--Creating a function that teleports PacGuy tp the other side
local function RightToLeftGate()
    if ( pacGuy.x > 1024) then
        if (pacGuy.y > 400) then
            if (pacGuy.y < 500) then
                pacGuy.x = 30
            end
        end
    end
end

local function LeftToRightGate()
    if ( pacGuy.x < 30) then
        if (pacGuy.y > 400) then
            if (pacGuy.y < 500) then
                pacGuy.x = 1000
            end
        end
    end
end

local function WinGate()
    if (pacGuy.y < 0) then
        if (pacGuy.x < 574) then
            if (pacGuy.x > 455) then
                composer.gotoScene("you_Win")
            end
        end
    end
end
    ballSetUp = math.random(1, 4)

local function FireBallSetUp()
    if (ballSetUp == 1) then 
       --left side balls
        ball1L.x = 350
        ball1L.y = 600
        ball2L.x = 200
        ball2L.y = 450
        ball3L.x = 400
        ball3L.y = 280
        --right side balls
        ball1R.x = 800
        ball1R.y = 500
        ball2R.x = 600
        ball2R.y = 650
        ball3R.x = 700
        ball3R.y = 200
    elseif (ballSetUp == 2) then
        ball1L.x = 500
        ball1L.y = 200
        ball2L.x = 500
        ball2L.y = 400
        ball3L.x = 300
        ball3L.y = 500
        --------------
        ball1R.x = 650
        ball1R.y = 200
        ball2R.x = 900
        ball2R.y = 650
        ball3R.x = 800
        ball3R.y = 400
    elseif (ballSetUp == 3) then
        ball1L.x = 250
        ball1L.y = 500
        ball2L.x = 500
        ball2L.y = 600
        ball3L.x = 400
        ball3L.y = 380
        ----------------
        ball1R.x = 550
        ball1R.y = 400
        ball2R.x = 900
        ball2R.y = 100
        ball3R.x = 600
        ball3R.y = 700
    elseif (ballSetUp == 4) then
        ball1L.x = 100
        ball1L.y = 600
        ball2L.x = 400
        ball2L.y = 200
        ball3L.x = 300
        ball3L.y = 500
        --------------
        ball1R.x = 700
        ball1R.y = 400
        ball2R.x = 900
        ball2R.y = 200
        ball3R.x = 800
        ball3R.y = 600
    end
end


ghostSetUp = math.random(1,2)

movingLeft = true
local function Ghost1Move()
    
    if (ghostSetUp == 1) then
        if (movingLeft == true) then
            ghost1.x = ghost1.x - scrollSpeed5
        else 
            ghost1.x = ghost1.x + scrollSpeed5
        end

        if (ghost1.x < 350) then
            movingLeft = false
        end

        if (ghost1.x > 700) then
            movingLeft = true
        end

    elseif (ghostSetUp == 2) then

        if (movingLeft == true) then
            ghost1.y = ghost1.y - scrollSpeed5
        else 
            ghost1.y = ghost1.y + scrollSpeed5
        end

        if (ghost1.y < 30) then
            movingLeft = false
        end

        if (ghost1.y > 200) then
            movingLeft = true
        end
    end
end



-- Creating a function which limits the characters' movement to the visible screen

--local function ScreenLimit( character )   

    -- Checking if the the character is about to go off the right side of the screen
   -- if character.x > ( display.contentWidth - character.width / 2 ) then
            
       -- character.x = character.x - 7.5

    -- Checking if the character is about to go off the left side of the screen
   -- elseif character.x < ( character.width / 2 ) then

        --character.x = character.x + 7.5

    -----------------------------------------------------------------------------------------

    -- Checking if the character is about to go off the bottom of the screen
   -- elseif character.y > ( display.contentHeight - character.height / 2 ) then

       -- character.y = character.y - 7.5

    -- Checking if the character is about to off the top of the screen
   -- elseif character.y < ( character.height / 2 ) then

       -- character.y = character.y + 7.5

    --end
--end
 
local function RuntimeEvents( )

        -- Retrieving the properties of the joystick
        angle = analogStick:getAngle()
        distance = analogStick:getDistance() -- Distance from the center of the joystick background
        direction = analogStick.getDirection()

        -----------------------------------------------------------------------------------------

        -- Checking if the joystick is being held
        if joystickPressed == true then

            -- Applying the force of the joystick to move the flower
            analogStick:move( pacGuy, 0.55 )

        end

        -----------------------------------------------------------------------------------------

        -- Limiting each character's movement to the edge of the screen
        --ScreenLimit( pacGuy )

        -----------------------------------------------------------------------------------------

        -- Checking if the joystick is pointing the opposite direction of the character
        if facingWhichDirection == "left" then
            
            -- Checking if the joystick is pointing to the right
            if direction == 1 or direction == 2 or direction == 8 then

                -- Flipping the controlled charcter's direction
                --flower:scale( -1, 1 )

                -- Setting the status of the character's directions
                facingWhichDirection = "right"

            end
        end

        -----------------------------------------------------------------------------------------

        -- Checking if the joystick is pointing the opposite direction of the character
        if facingWhichDirection == "right" then


            -- Checking if the joystick is pointing to the right
            if direction == 4 or direction == 5 or direction == 6 then

                -- Flipping the controlled charcter's direction
                --flower:scale( -1, 1 )

                -- Setting the status of the character's directions
                facingWhichDirection = "left"

            end
        end

        -----------------------------------------------------------------------------------------

end -- local function RuntimeEvents( )

-----------------------------------------------------------------------------------
local function AddPhysicsBodies()

    physics.addBody(wall1, "static", {friction = 0})
    physics.addBody(wall2, "static", {friction = 0})
    physics.addBody(wall3, "static", {friction = 0})
    physics.addBody(wall4, "static", {friction = 0})
    physics.addBody(wall5, "static", {friction = 0})
    physics.addBody(wall6, "static", {friction = 0})
    physics.addBody(wall7, "static", {friction = 0})
    physics.addBody(wall8, "static", {friction = 0})
    physics.addBody(wall9, "static", {friction = 0})
    physics.addBody(wall11, "static", {friction = 0})
    physics.addBody(wall12, "static", {friction = 0})
    physics.addBody(wall13, "static", {friction = 0})
    physics.addBody(wall14, "static", {friction = 0})
    physics.addBody(wall15, "static", {friction = 0})
    physics.addBody(wall16, "static", {friction = 0})
    physics.addBody(wall17, "static", {friction = 0})
    physics.addBody(wall18, "static", {friction = 0})
    physics.addBody(wall19, "static", {friction = 0})
    physics.addBody(wall20, "static", {friction = 0})
    physics.addBody(wall21, "static", {friction = 0})
    physics.addBody(wall22, "static", {friction = 0})
    physics.addBody(wall23, "static", {friction = 0})
    physics.addBody(wall24, "static", {friction = 0})

    physics.addBody(startWall, "static", {friction = 0})
    physics.addBody(endWallR1, "static", {friction = 0})
    physics.addBody(endWallR2, "static", {friction = 0})
    physics.addBody(endWallR3, "static", {friction = 0})
    physics.addBody(endWallL1, "static", {friction = 0})
    physics.addBody(endWallL2, "static", {friction = 0})
    physics.addBody(endWallL3, "static", {friction = 0})
    physics.addBody(endGateL, "static", {friction = 0})
    physics.addBody(endGateR, "static", {friction = 0})
    physics.addBody(leftGateWall1, "static", {friction = 0})
    physics.addBody(leftGateWall2, "static", {friction = 0})
    physics.addBody(rightGateWall1, "static", {friction = 0})
    physics.addBody(rightGateWall2, "static", {friction = 0})
    physics.addBody(pacGuy, "dynamic", {friction = 0}) 
    physics.addBody(ball1L, "dynamic", {friction=1}) 
    physics.addBody(ball2L, "dynamic", {friction=1}) 
    physics.addBody(ball3L, "dynamic", {friction=1}) 
    physics.addBody(ghost1, "dynamic", {friction=1}) 
    physics.addBody(ball1R, "dynamic", {friction=1}) 
    physics.addBody(ball2R, "dynamic", {friction=1}) 
    physics.addBody(ball3R, "dynamic", {friction=1}) 

end

local function RemovePhysicsBodies()

    physics.removeBody(wall1)
    physics.removeBody(wall2)
    physics.removeBody(wall3)
    physics.removeBody(wall4)
    physics.removeBody(wall5)
    physics.removeBody(wall6)
    physics.removeBody(wall7)
    physics.removeBody(wall8)
    physics.removeBody(wall9)
    physics.removeBody(wall11)
    physics.removeBody(wall12)
    physics.removeBody(wall13)
    physics.removeBody(wall14)
    physics.removeBody(wall15)
    physics.removeBody(wall16)
    physics.removeBody(wall17)
    physics.removeBody(wall18)
    physics.removeBody(wall19)
    physics.removeBody(wall20)
    physics.removeBody(wall21)
    physics.removeBody(wall22)
    physics.removeBody(wall23)
    physics.removeBody(wall24)

    physics.removeBody(startWall)
    physics.removeBody(endWallL1)
    physics.removeBody(endWallL2)
    physics.removeBody(endWallL3)
    physics.removeBody(endWallR1)
    physics.removeBody(endWallR2)
    physics.removeBody(endWallR3)
    physics.removeBody(endGateR)
    physics.removeBody(endGateL)
    physics.removeBody(leftGateWall1)
    physics.removeBody(leftGateWall2)
    physics.removeBody(rightGateWall1)
    physics.removeBody(rightGateWall2)
    physics.removeBody(pacGuy)
    physics.removeBody(ball1L)
    physics.removeBody(ball2L)
    physics.removeBody(ball3L)
    physics.removeBody(ghost1)
    physics.removeBody(ball1R)
    physics.removeBody(ball2R)
    physics.removeBody(ball3R)

end

-- Creating Joystick function that determines whether or not joystick is pressed
local function Movement( touch )

    if touch.phase == "began" then

        -- Setting a boolean to true to simulate the holding of a button
        joystickPressed = true

    elseif touch.phase == "ended" then

        -- Setting a boolean to false to simulate the release of a held button
        joystickPressed = false
    end
end --local function Movement( touch )
-----------------------------------------------------------------------------------------









-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    

    userLives = 3
    -----------------------------------------------------------------------------------------

    -- Insert the background image
    bkg_image = display.newImageRect("Images/lvl1Bkg.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

   
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

    wall15 = display.newImageRect("Images/wall2.png", 25, 100)
    wall15.x = 375
    wall15.y = 700

    wall16 = display.newImageRect("Images/wall1.png", 100, 25)
    wall16.x = 400
    wall16.y = 550

    wall17 = display.newImageRect("Images/wall2.png", 25, 80)
    wall17.x = 230
    wall17.y = 650
   
    wall18 = display.newImageRect("Images/wall1.png", 80, 25)
    wall18.x = 178
    wall18.y = 678

    wall19 = display.newImageRect("Images/wall2.png", 25, 100)
    wall19.x = 360
    wall19.y = 400

    wall20 = display.newImageRect("Images/wall1.png", 90, 25)
    wall20.x = 328
    wall20.y = 442

    wall21 = display.newImageRect("Images/wall1.png", 100, 25)
    wall21.x = 200
    wall21.y = 370

    wall22 = display.newImageRect("Images/wall2.png", 25, 100)
    wall22.x = 164
    wall22.y = 309

    wall23 = display.newImageRect("Images/wall2.png", 25, 100)
    wall23.x = 250
    wall23.y = 130

    wall24 = display.newImageRect("Images/wall1.png", 150, 25)
    wall24.x = 400
    wall24.y = 250

    --END WALLS-----------------------------------------------
    endWallR1 = display.newImageRect("Images/wall1.png", 100, 25)
    endWallR1.x = 1000
    endWallR1.y = 50

    endWallR2 = display.newImageRect("Images/wall1.png", 100, 25)
    endWallR2.x = 860
    endWallR2.y = 50

    endWallR3 = display.newImageRect("Images/wall1.png", 150, 25)
    endWallR3.x = 700
    endWallR3.y = 50


    endWallL3 = display.newImageRect("Images/wall1.png", 150, 25)
    endWallL3.x = 330
    endWallL3.y = 50

    endWallL2 = display.newImageRect("Images/wall1.png", 100, 25)
    endWallL2.x = 164
    endWallL2.y = 50

    endWallL1 = display.newImageRect("Images/wall1.png", 100, 25)
    endWallL1.x = 20
    endWallL1.y = 50

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

    leftGateWall2 = display.newImageRect("Images/wall1.png", 80, 25)
    leftGateWall2.x = 24
    leftGateWall2.y = 400

    rightGateWall1 = display.newImageRect("Images/wall1.png", 80, 25)
    rightGateWall1.x = 1000
    rightGateWall1.y = 500

    rightGateWall2 = display.newImageRect("Images/wall1.png", 80, 25)
    rightGateWall2.x = 1000
    rightGateWall2.y = 400

    --BALLS---------------------------------------------
    ball1L = display.newImageRect("Images/fireBall.png", 40, 40)
    ball1L.x = 400
    ball1L.y = 600
    ball1L.myName = "ball1L"

    ball2L = display.newImageRect("Images/fireBall.png", 40, 40)
    ball2L.x = 150
    ball2L.y = 450
    ball2L.myName = "ball2L"

    ball3L = display.newImageRect("Images/fireBall.png", 40, 40)
    ball3L.x = 500
    ball3L.y = 300   
    ball1L.myName = "ball3L"

    ball1R = display.newImageRect("Images/fireBall.png", 40, 40)
    ball1R.x = 600
    ball1R.y = 200 
    ball1R.myName = "ball1R"

    ball2R = display.newImageRect("Images/fireBall.png", 40, 40)
    ball2R.x = 600
    ball2R.y = 200 
    ball2R.myName = "ball2R"

    ball3R = display.newImageRect("Images/fireBall.png", 40, 40)
    ball3R.x = 600
    ball3R.y = 200 
    ball3R.myName = "ball3R"

    -- Creating Joystick
    analogStick = joystick.new( 50, 75 ) 

    -- Setting Position
    analogStick.x = 125
    analogStick.y = display.contentHeight - 125

    -- Changing transparency
    analogStick.alpha = 0.5

-----------------------------------------------------------------
--Adding in the character.

    pacGuy = display.newImageRect("Images/PacManOpen.png", 50, 50)
    pacGuy.anchorX = 0
    pacGuy.anchorY = 0 
    pacGuy.x = 512
    pacGuy.y = 710

    ghost1 = display.newImageRect("Images/Ghost.png", 50, 50)
    ghost1.anchorX = 0
    ghost1.anchorY = 0 
    ghost1.x = 512
    ghost1.y = 80
    ghost1.myName = "ghost1"
    

-----------------------------------------------------------------
  

    -- add collision event listeners
    pacGuy.collision = onLocalCollision
    pacGuy:addEventListener( "collision", pacGuy)
    ball1L.collision = onLocalCollision
    ball1L:addEventListener( "collision", ball1L)
    ball2L.collision = onLocalCollision
    ball2L:addEventListener( "collision", ball2L)
    ball3L.collision = onLocalCollision
    ball3L:addEventListener( "collision", ball3L)
   
        
    -- Send the background image to the back layer so all other objects can be on top
    

        -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )
    sceneGroup:insert( analogStick )   
    sceneGroup:insert( wall1 )
    sceneGroup:insert( wall2 )
    sceneGroup:insert( wall3 )
    sceneGroup:insert( wall4 )
    sceneGroup:insert( wall5 )
    sceneGroup:insert( wall6 )
    sceneGroup:insert( wall7 )
    sceneGroup:insert( wall8 )
    sceneGroup:insert( wall9 )
    sceneGroup:insert( wall11 )
    sceneGroup:insert( wall12 )
    sceneGroup:insert( wall13 )
    sceneGroup:insert( wall14 )
    sceneGroup:insert( wall15 )
    sceneGroup:insert( wall16 )
    sceneGroup:insert( wall17 )
    sceneGroup:insert( wall18 )
    sceneGroup:insert( wall19 )
    sceneGroup:insert( wall20 )
    sceneGroup:insert( wall21 )
    sceneGroup:insert( wall22 )
    sceneGroup:insert( wall23 )
    sceneGroup:insert( wall24 )

    sceneGroup:insert( endGateR )
    sceneGroup:insert( endGateL )
    sceneGroup:insert( endWallL1 )
    sceneGroup:insert( endWallL2 )
    sceneGroup:insert( endWallL3 )
    sceneGroup:insert( endWallR1 )
    sceneGroup:insert( endWallR2 )
    sceneGroup:insert( endWallR3 )
    sceneGroup:insert( rightGateWall1 )
    sceneGroup:insert( leftGateWall1 )
    sceneGroup:insert( rightGateWall2 )
    sceneGroup:insert( leftGateWall2 )
    sceneGroup:insert( pacGuy )
    sceneGroup:insert( ball1L )
    sceneGroup:insert( ball2L )
    sceneGroup:insert( ball3L )
    sceneGroup:insert( ball1R )
    sceneGroup:insert( ball2R )
    sceneGroup:insert( ball3R )
    sceneGroup:insert( ghost1 )







end --function scene:create( event )
-----------------------------------------------------------------


-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------
--This function causes the pumpkins to move up then down.
-- Function to move top
--function movePumpkin1 ()
  --  timer.performWithDelay(800, movePumkin1Down) 
    --pumpkin1.y = pumpkin1.y - 2    
--end
  
--function movePumkin1Down()
  -- pumpkin1.y = pumpkin1.y + 2
--end   



-----------------------------------------------------------------------------------------------
-- The function called when the scene is issued to appear on screen
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        if (restarted == 1) then

            scene:create()
            restarted = 0
        end
        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.

        

        

       

        

               
        -- start the physics engine
        physics.start()
        physics.setGravity( 0, 0 )

        -- activate the joystick
        AddPhysicsBodies()
        analogStick:activate()
        -----------------------------------------------------------------------------------------
        -- EVENT LISTENERS
        -----------------------------------------------------------------------------------------

        -- Listening for the usage of the joystick
        analogStick:addEventListener( "touch", Movement )
        Runtime:addEventListener("enterFrame", RuntimeEvents)
        Runtime:addEventListener("enterFrame", LeftToRightGate)
        Runtime:addEventListener("enterFrame", RightToLeftGate)
        Runtime:addEventListener("enterFrame", WinGate)
        Runtime:addEventListener("enterFrame", FireBallSetUp)
        Runtime:addEventListener("enterFrame", Ghost1Move)
    end
end  --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase


    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.


        


    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.

                -- Deactivating the Analog Stick
        analogStick:deactivate()

        -- Stopping the Runtime Events
        Runtime:removeEventListener( "enterFrame", RuntimeEvents )
        Runtime:removeEventListener( "enterFrame", FireBallSetUp)
        Runtime:removeEventListener( "enterFrame", LeftToRightGate )
        Runtime:removeEventListener( "enterFrame", RightToLeftGate )
        Runtime:removeEventListener( "enterFrame", Ghost1Move )
        

        Runtime:removeEventListener( "enterFrame", WinGate)
        -- Removing the listener which listens for the usage of the joystick
        analogStick:removeEventListener( "touch", Movement )

        pacGuy:removeEventListener( "collision", pacGuy)
        
        RemovePhysicsBodies()
        -- start the physics engine
        physics.stop()   
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

--Runtime:addEventListener("enterFrame", CheckCollisions)
 --Runtime:addEventListener("enterFrame",  movePumpkin1 )




-----------------------------------------------------------------------------------------

return scene

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------