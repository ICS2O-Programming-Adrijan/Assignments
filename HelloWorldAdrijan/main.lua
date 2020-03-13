-----------------------------------------------------------------------------------------
----Name: Adrijn Vranjkovic
--Course: ICS20
--This program displays Hello, world on the ipad simulator and "Hellooooooo!" to the command terminal.



-----------------------------------------------------------------------------------------

-- print "Hello, world" to the command terminal
print ("***Helloooooooooooooo!")

--hide the status bar
display.setStatusBar(display.HiddenStatusBar)

--sets the background colour
display.setDefault("background", 124/255, 249/255, 199/255)

--create a local variable
local textObject

--displays text on the screen at position x=500 and y= 500 with a default font style and font size of 50
textObject = display.newText( " Hello, Adrijan!", 500, 500,nil, 50 )

--sets the color of the text 
textObject:setTextColor( 155/255, 42/255, 198/255)


