-----------------------------------------------------------------------------------------
-- Title: Drawing shpapes
-- Name: Adrijan
--Course: ICS20
-- This program displays 4 different polygons
-----------------------------------------------------------------------------------------

local myTriangle
local mytrapezoid
local myHexagon
local myPolygon
local myRectangle

-- set the background colour of my screen. Remember that colors are between 0 and 1.
display.setDefault("background", 52/255, 152/255, 219/255)

-- create the vertices for the myTriangle
local verticesTriangle = { -0, -60, -200, 120, 200, 120}

-- Draw the myTriangle
myTriangle = display.newPolygon(display.contentWidth/2, display.contentHeight/4, verticesTriangle)

-- set fill colour.
myTriangle:setFillColor( 255/255, 0/255, 0/255)

-- create the vertices for myRectangle
local verticesRectangle = { 5, 100, -5, 100, 5, -100, -5, -100}

--create myRectangle
myRectangle = display.newRect (512, 288, verticesRectangle)
