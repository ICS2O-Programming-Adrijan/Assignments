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

--set the colour
myTriangle:setFillColor( 255/255, 0/255, 0/255)
myTriangle.strokeWidth = 10
myTriangle:setStrokeColor( 0/255, 0/255, 0/255)

-- making myRectangle's vertices, fillcolour, stroke colour and stroke size.
local myRectangle = display.newRect( 512, 360, 50, 150)
myRectangle.strokeWidth = 10
myRectangle:setFillColor( 150/255, 75/255, 0/255)
myRectangle:setStrokeColor( 84/255, 42/255, 0/255)

--making the vertices of my trapezoid
local trapezoidVertices = { 100,75, -100,75, -300,-50, 300,-50}

--drawing mytrapezoid
local myTrapezoid = display.newPolygon(512, 500, trapezoidVertices)
myTrapezoid.strokeWidth = 12
myTrapezoid:setFillColor(150/255, 75/255, 0/255)
myTrapezoid:setStrokeColor( 84/255, 42/255, 0/255)

-- making my myHexagon's vertices
local hexagonVertices = { -10,30, 10,30, 40,0, 10,-30, -10,-30, -40,0}

--making myHexagon
local myHexagon = display.newPolygon( 512,500, hexagonVertices)
myHexagon:setFillColor( 255/255, 248/255, 245/255)
myHexagon.strokeWidth = 10
myHexagon:setStrokeColor( 0/255, 0/255, 0/255)

--maikng my random shape 
local randomShapeVertices = {100,-40, 140,-80, 180,-40, 220,-80, 260,-40, 300,-80, 340,-40, 340,20, -340,20, -340,-40, -300,-80,-260,-40, -220,-80, -180,-40, -140,-80,-100,-40}
local myPolygon = display.newPolygon( 512, 550, randomShapeVertices)
local polygonGradient = {
	type = "gradient",
	color1 = { 124/255, 206/255, 247/255},
	color2 = { 22/255, 26/255, 43/255},
	direction = "down"
}

--setting the gradient to the polygon
myPolygon.fill = polygonGradient

--setting the border
myPolygon.strokeWidth = 8
myPolygon:setStrokeColor( 255/255, 255/255, 255/255)