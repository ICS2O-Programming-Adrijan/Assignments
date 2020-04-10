-----------------------------------------------------------------------------------------
--Name: Adrijan
-- main.lua
--ICS20
--This program will display a math
-- problem for the user to answer with a time limit
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

--set the background 
display.setDefault("background", 50/255, 175/255, 150/255)

---------------------------------------------------------------------
--LOCAL VARIABLES
---------------------------------------------------------------------

--creating the local variables
local thanos2
local questionObject
local correctObject
local numericField
local randomNumber1
local randomNumber2
local userAnswer
local correctText
local incorrectText
local points
local bowser
local corona
local mushroom
local plankton
local thanos
local liveNumber
local heart1
local heart2
local heart3
local gameOverObject
local winnerObject
local randomOperator
local correctAnswer
local thanosScrollSpeed
local randomNumber3
local totalSeconds = 10
local secondsLeft = 10
local clockText
local countDownTimer

-------------------------------------------------------------
--SOUNDS
--------------------------------------------------------------
--Uploading all the Sounds
local correctSound = audio.loadSound("Sounds/correct.mp3")
local correctSoundChannel

local winnerSound = audio.loadSound("Sounds/Winner.mp3")
local winnerSoundChannel

local gameOverSound = audio.loadSound("Sounds/Loser.mp3")
local gameOverSoundChannel

local wrongSound = audio.loadSound("Sounds/Wrong.mp3")
local wrongSoundChannel

----------------------------------------------------------------
--LOCAL FUNCTION
--------------------------------------------------------------------------
--Function: AskQuestion
--output:Asks the user a question
--input:None
--Description: This function displays a question for the user to answer 
local function askQuestion()

	-- pick a random number between 1 and 5
	randomOperator = math.random(1,7)

	if (randomOperator == 1) then
		--setting the random numbers if it is a addition question
		randomNumber1 = math.random(1,20)
		randomNumber2 = math.random(1,20)

		--setting the correct answer 
		correctAnswer = randomNumber1 + randomNumber2

		--asking the addition question
		questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "
	elseif (randomOperator == 2) then
		--set the new random numbers
		randomNumber1 = math.random(1,20)
		randomNumber2 = math.random(1,20)

		if (randomNumber1 > randomNumber2) then
			correctAnswer = randomNumber1 - randomNumber2
			questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "
		else correctAnswer = randomNumber2 - randomNumber1
			questionObject.text = randomNumber2 .. " - " .. randomNumber1 .. " = "
		end
	elseif (randomOperator == 3) then
		--set the random numbers
		randomNumber1 = math.random(1,10)
		randomNumber2 = math.random(1,10)

		--set the correct answer
		correctAnswer = randomNumber1 * randomNumber2

		--displaying the question
		questionObject.text = randomNumber1 .. " * " .. randomNumber2 .. " = "
	elseif (randomOperator == 4) then
		randomNumber1 = math.random(1,10)
		randomNumber2 = math.random(1,10)
		randomNumber3 = math.random(1,10)

		correctAnswer = randomNumber1 + randomNumber2 + randomNumber3

		questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " + " .. randomNumber3 .. " = "
	elseif (randomOperator == 5) then
		--setting the two numbers
		randomNumber1 = math.random(1,10)
		randomNumber2 = math.random(1,10)

		--setting the correctAnswer
		-- and changing randomNumber1 with correctAnswer
		correctAnswer = randomNumber1 * randomNumber2
		randomNumber3 = randomNumber1
		randomNumber1 = correctAnswer
		correctAnswer = randomNumber3

		--display the question 
		questionObject.text = randomNumber1 .. " / " .. randomNumber2 .. " = "
	elseif (randomOperator == 6) then
		--setting the values of correct
		-- answer and randomNumber3 so the next function works
		correctAnswer = 1
		randomNumber3 = 1
		randomNumber1 = math.random(1, 5)

		--this while statement makes the statement loops
		while (randomNumber3 <= randomNumber1) do
			correctAnswer = correctAnswer * randomNumber3
			randomNumber3 = randomNumber3 + 1
		end
		questionObject.text = randomNumber1 .. "!" .. " = "
	elseif (randomOperator == 7) then 
	  	--setting the correctAnswer
 	 	correctAnswer = math.random(1,20)
 	 	--setting the variables to ask the question
  		randomNumber1 = correctAnswer * correctAnswer
  		--asking the question
  		questionObject.text = " √ " .. randomNumber1 .. " = "
	end
end
--Funtion:numericFieldListener
--output:add the numericFieldListener
--input: none
--Description: This function decides if the user is right or wrong 
local function numericFieldListener(event)

	--user begins editing "numericField"
	if ( event.phase == "began" ) then

		--clear text field
		event.target.text = ""

	elseif event.phase == "submitted" then

		--when the answer is submitted (enter key is pressed) set user input to user's answer
		userAnswer = tonumber(event.target.text)

		--if the user answer and the correct answer are the same:
		if (userAnswer == correctAnswer) then
			secondsLeft = totalSeconds
			correctSoundChannel = audio.play(correctSound)
			--give the user a point if they get the correct answer
			points = points + 1
			incorrectText.isVisible = false
			correctText.isVisible = true
			timer.performWithDelay(1000, HideCorrect)
			event.target.text = ""
			askQuestion()
		else 
			secondsLeft = totalSeconds
			wrongSoundChannel = audio.play(wrongSound)
			-- taking away the hearts
			liveNumber = liveNumber - 1
			incorrectText.isVisible = true
			correctText.isVisible = false
			event.target.text = ""
			askQuestion()
		end
	end
end



--Funtion:MoveLeft
--Output: this function acceptsthe event listener
--input:None 
--Description: This function moves thanos side to side

movingLeft = true

local function MoveLeft(event)
	
	
	
	if (movingLeft == true) then
		thanos.x = thanos.x - scrollSpeed
	else 
		thanos.x = thanos.x + scrollSpeed

	end

	if (thanos.x < 180) then
		movingLeft = false
	end

	if (thanos.x > 220 ) then
		movingLeft = true
	end
end
--Funtion: heartNumber
--Output: this function acceptsthe event listener
--input:None
--Description:counts how many hearts and makes them disapear
local function heartNumber(event)
	

	if (liveNumber == 2) then
		heart1.isVisible = false
	elseif (liveNumber == 1) then
		heart1.isVisible = false
		heart2.isVisible = false
	elseif (liveNumber == 0) then
		clockText.isVisible = false
		gameOverSoundChannel = audio.play(gameOverSound)
		timer.cancel(countDownTimer)
		heart1.isVisible = false
		heart2.isVisible = false
		heart3.isVisible = false
		gameOverObject.isVisible = true	
		questionObject.isVisible = false
		numericField.isVisible = false
		correctText.isVisible = false
		incorrectText.isVisible = false
	end
end
--Funtion: pointsCounter
--Output: this function acceptsthe event listener
--input:None
--Description:counts how many points and makes the villains disapear
local function pointsCounter(event)
	if (points == 1) then
		bowser.y = bowser.y - bowserScrollSpeed
		bowser:rotate(25)
	elseif (points == 2) then
		corona.x = corona.x + bowserScrollSpeed
		corona.y = corona.y + bowserScrollSpeed
	elseif (points == 3) then
		mushroom.x = mushroom.x + bowserScrollSpeed
		mushroom.alpha = mushroom.alpha - 0.05

	elseif (points == 4) then
		plankton.xScale = plankton.xScale - 0.5
		plankton.yScale = plankton.yScale - 0.5
		plankton.alpha = plankton.alpha - 0.01
	elseif (points == 5) then
		clockText.isVisible = false
		winnerSoundChannel = audio.play(winnerSound)
		timer.cancel(countDownTimer)
		thanos.isVisible = false
		winnerObject.isVisible = true
		incorrectText.isVisible = false
		questionObject.isVisible = false
		numericField.isVisible = false
		correctText.isVisible = false
		heart3.isVisible = false
		heart1.isVisible = false
		heart2.isVisible = false
		thanos = display.newImageRect("Images/thanos2.png", 300, 500)
		thanos.x = 750
		thanos.y = 500
		thanos:rotate(45)
		display.setDefault("background", 255/255, 255/255, 255/255)
	end
end
--Function:UpdateTime
--Output: this function acceptsthe event listener
--input:None
--Description:This function controls the time
local function UpdateTime()
	
	-- decrement the number of seconds
	secondsLeft = secondsLeft - 1

	-- display the number of seconds in the clock object 
	clockText.text = secondsLeft .. ""

	if (secondsLeft == 0) then
		--reset the number of seconds left 
		secondsLeft = totalSeconds
		liveNumber = liveNumber - 1
		askQuestion()
	end
end
--Function: StartTimer
--Output: this function acceptsthe event listener
--input:None 
--Description:this Function starts the time
--function that calls the timer
local function StartTimer()
	--create a countDownTimer that loops infinetely
	countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end




------------------------------------------------------------------
--OBJECT CREATION
------------------------------------------------------------------

--display a question and sets the color
questionObject = display.newText("", display.contentWidth/3, display.contentHeight/2, arial, 100 )
questionObject:setTextColor(155/255, 42/255, 198/255)

--create the correct text object and make it invisible
correctText = display.newText( "Correct!", 700, 250, nil, 50 )
correctText:setTextColor(200/255, 250/255, 20/255)
correctText.isVisible = false

--making the incorrectText
incorrectText = display.newText("Incorrect!", 700, 300, nil, 50 )
incorrectText.isVisible = false
incorrectText:setTextColor(200/255, 250/255, 20/255)


--create numeric field
numericField = native.newTextField( 700, display.contentHeight/2, 200, 120 )
numericField.inputType = "decimal"
--set how many points the user starts with 
points = 0


-- creating heart1
heart1 = display.newImageRect("Images/heart.png", 200, 150)
heart1.x = 100
heart1.y = 100

-- creating heart2
heart2 = display.newImageRect("Images/heart.png", 200, 150)
heart2.x = 300
heart2.y = 100

-- creating heart3
heart3 = display.newImageRect("Images/heart.png", 200, 150)
heart3.x = 500
heart3.y = 100

-- creating the number of lives
liveNumber = 3

--creating the object that displays then the user loses the game 
gameOverObject = display.newImageRect("Images/gameOver.png", 700, 700)
gameOverObject.isVisible = false
gameOverObject.x = 500
gameOverObject.y = 400

--creating the object that displays when the user wins thr game 
winnerObject = display.newImageRect("Images/winner.png", 500, 500)
winnerObject.isVisible = false
winnerObject.x = display.contentHeight/2
winnerObject.y = display.contentWidth/4



--displaying the villains
bowser = display.newImageRect("Images/bowser.png", 200, 300)
bowser.x = 950
bowser.y = 620
bowser.isVisible = true

corona = display.newImageRect("Images/corona.png", 200, 200)
corona.x = 750
corona.y = 650
corona.isVisible = true

mushroom = display.newImageRect("Images/mushroom.png", 150, 230)
mushroom.x = 560
mushroom.y = 650
mushroom.isVisible = true

plankton = display.newImageRect("Images/plankton.png", 100, 200)
plankton.x = 400
plankton.y = 665
plankton.isVisible = true

thanos = display.newImageRect("Images/thanos.png", 200, 390)
thanos.x = 200
thanos.y = 610
thanos.isVisible = true

--setting all the scrollSpeeds needed 
scrollSpeed = 2

bowserScrollSpeed = 10

--creating the thanos that apears when the user wins
thanos2 = display.newImageRect("Images/thanos2.png", 300, 500)
thanos2.x = 750
thanos2.y = 200
thanos2.isVisible = false
--displaying the timer text 
clockText = display.newText("Time: " .. secondsLeft, 600, 600, nil, 70)
clockText.x = 700
clockText.y = 200

-------------------------------------------------------------------
--FUNCTION CALLS
--------------------------------------------------------------------

--call the function to ask the question
askQuestion()

--MoveLeft will be called over and over again
Runtime:addEventListener("enterFrame", MoveLeft)

--add the event listener for the numeric field
numericField:addEventListener( "userInput", numericFieldListener )

-- added event heartNumber
Runtime:addEventListener("enterFrame", heartNumber)

--added event pointsCounter
Runtime:addEventListener("enterFrame", pointsCounter)



--call the timer to start 
UpdateTime()

StartTimer()
