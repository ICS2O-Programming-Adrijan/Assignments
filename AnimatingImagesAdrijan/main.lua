-----------------------------------------------------------------------------------------
--Name: Adrijan
--Class: ICS20
--This program has a backgroung, displays 3 images that all move, and some colored text.
-----------------------------------------------------------------------------------------

--Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

--Set the background
local backgroundImage = display.newImageRect( "Images/FamilyGuy.png", 1024, 1000)
backgroundImage.x = 512
backgroundImage.y = 359

local Peter = display.newImageRect("Images/PeterPimp.png",200, 400)
Peter.x = 