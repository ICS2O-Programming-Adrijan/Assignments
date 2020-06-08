-----------------------------------------------------------------------------------------
--
-- main_menu.lua
-- Created by: Adrijan Vranjkovic
-- Date: June, 4 2020
-- Description: This is the main menu, displaying the credits, instructions & play buttons to my game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "main_menu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

------------------------------------------------
--GLOBAL VARIABLES
----------------------------------------------------
soundOn = true

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
local background2 

local alphaSpeed = 0.01
local scrollSpeed = 5

local bkg_image
local playButton
local creditsButton
local instructionsButton

local muteButton
local unmuteButton



------------------------------------------------
--SOUNDS
local music = audio.loadSound("Sounds/Music.mp3")
local musicChannel
-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

local function Mute(touch)
    if (touch.phase == "ended") then
        --pause the sound
        audio.pause(music)
        -- set the boolean variable to be false( sound is now muted)
        soundOn = false
        -- hide the mute mute button 
        muteButton.isVisible = false
        -- make the unmute button visible 
        unmuteButton.isVisible = true
    end
end

local function Unmute(touch)
    if (touch.phase == "ended") then
        --pause the sound
        audio.resume(music)
        -- set the boolean variable to be true( sound is now umuted)
        soundOn = true
        -- hide the mute mute button 
        muteButton.isVisible = true
        -- make the unmute button visible 
        unmuteButton.isVisible = false
    end
end

-- Creating Transition Function to Credits Page
local function CreditsTransition( )       
    composer.gotoScene( "credits_screen", {effect = "fromTop", time = 500})
end 

local function Background2Fade()
    background2.alpha = background2.alpha + alphaSpeed
end

local function PlayMovement()
    playButton.isVisible = true
    playButton.y = playButton.y + scrollSpeed 
    if (playButton.y > 350) then
        playButton.y = 350
    end
end

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level1ScreenTransition( )
    muteButton.isVisible = false
    unmuteButton.isVisible = false
    composer.gotoScene( "level1_screen", {effect = "flipFadeOutIn", time = 700})
end    

-- Creating Transition to Instructions Screen
local function InstructionsTransition( )
    composer.gotoScene( "instructions_Screen", {effect = "flip", time = 500})
end    
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )
    background2 = display.newImage("Images/Background.2.png")
    background2.x = display.contentCenterX
    background2.y = display.contentCenterY
    background2.width = display.contentWidth
    background2.height = display.contentHeight
    background2.alpha = 0

    muteButton = display.newImageRect("Images/mute.png", 100, 100)
    muteButton.x = 50
    muteButton.y = 50
    muteButton.isVisible = true

    unmuteButton = display.newImageRect("Images/unmute.png", 100, 100)
    unmuteButton.x = 50
    unmuteButton.y = 50
    unmuteButton.isVisible = false

    sceneGroup:insert(background2)
    sceneGroup:insert(muteButton)
    sceneGroup:insert(unmuteButton)



    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/Background.1.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight


    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    playButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = 0,

            -- Insert the images here
            defaultFile = "Images/PlayPressed.png",
            overFile = "Images/Play.Unpressed.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition          
        } )

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*6.3/8,
            y = display.contentHeight*7/8,

            width = 100,
            heght = 80,
            -- Insert the images here
            defaultFile = "Images/CreditsButtonUnpressed.png",
            overFile = "Images/CreditsButtonPressed.png",

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
       } ) 
    
------------------------------------------------------------------------
     -- Creating instructions Button
    instructionsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1.5/8,
            y = display.contentHeight*7/8,

            width = 390,
            height = 190,

            -- Insert the images here
            defaultFile = "Images/InstructionsButton.png",
            overFile = "Images/InstructionsButtonPressed.png",

            -- When the button is released, call the Instructions transition function
            onRelease = InstructionsTransition
        } ) 

    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( instructionsButton )
    sceneGroup:insert( background2 )

    -- INSERT INSTRUCTIONS BUTTON INTO SCENE GROUP

end -- function scene:create( event )   



-----------------------------------------------------------------------------------------

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

    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    elseif ( phase == "did" ) then 
        
        muteButton:addEventListener("touch", Mute)
        unmuteButton:addEventListener("touch", Unmute)


        Runtime:addEventListener("enterFrame", PlayMovement)

        Runtime:addEventListener("enterFrame", Background2Fade)
        musicChannel = audio.play (music)
        if (soundOn == false) then
            audio.pause(musicChannel)
        end 
    end

end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        muteButton:removeEventListener("touch", Mute)
        unmuteButton:removeEventListener("touch", Unmute)
        Runtime:removeEventListener("enterFrame", PlayMovement)
        Runtime:removeEventListener("enterFrame", Background2Fade)
        -- Called immediately after scene goes off screen.
        audio.stop(musicChannel)
    end

end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

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
