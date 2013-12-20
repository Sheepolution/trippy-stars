--[[
Made by Daniël Haazen with the LÖVE engine

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

You are free:

to Share — to copy, distribute and transmit the work
to Remix — to adapt the work

Under the following conditions:
Attribution — You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
Noncommercial — You may not use this work for commercial purposes.
Share Alike — If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.

With the understanding that:
Waiver — Any of the above conditions can be waived if you get permission from the copyright holder.
Public Domain — Where the work or any of its elements is in the public domain under applicable law, that status is in no way affected by the license.
Other Rights — In no way are any of the following rights affected by the license:
	Your fair dealing or fair use rights, or other applicable copyright exceptions and limitations;
	The author's moral rights;
	Rights other persons may have either in the work itself or in how the work is used, such as publicity or privacy rights.
Notice — For any reuse or distribution, you must make clear to others the license terms of this work. The best way to do this is with a link to this web page.


http://creativecommons.org/licenses/by-nc-sa/3.0/
]]
require "class"
require "star"

function love.load()
	math.randomseed(os.time()+love.mouse.getX()+love.mouse.getY())
	math_random = math.random
	math_rad = math.rad
	math_cos = math.cos
	math_sin = math.sin
	math_floor = math.floor
	math_ceil = math.ceil
	math_pi = math.pi
	math_squirtle = math.sqrt
	math_sin = math.sin
	math_cos = math.cos
	math_atan2 = math.atan2

	if love.filesystem.exists("randomvalues.txt") then 
      	fileRandomValues = love.filesystem.read("randomvalues.txt") 
    else
      	love.filesystem.newFile("randomvalues.txt")
      	fileRandomValues = "25,25,5,610,200,-100,200,500,10"
      	love.filesystem.write("randomvalues.txt", fileRandomValues)
    end
    values = {}
   	local index = 1
   	for value in string.gmatch(fileRandomValues,"%w+") do 
    	values[index] = tonumber(value)
    	index = index + 1
	end

	if (love.filesystem.exists("settings.txt")) then
		filesettings = love.filesystem.read("settings.txt")
	else
		love.filesystem.newFile("settings.txt")
      	filesettings = "1024,768"
      	love.filesystem.write("settings.txt", filesettings)
    end
    settings = {}
    local index = 1
   	for value in string.gmatch(filesettings,"%w+") do 
    	settings[index] = tonumber(value)
    	index = index + 1
	end

	sWidth = settings[1]
	sHeight = settings[2]
	if (sWidth~=1024 and sHeight~=768) then
		love.graphics.setMode(sWidth, sHeight)
	end

	listOfStars = {}
	listOfSavedStars = {}
	stars = true
	outline = true
	inline = true
	stableline = false
	stablelineWidth = 1
	follow = false
	blend = false
	slow = false
	help = true

end

function love.update(dt)
	dt = math.min(dt,0.016666667)
	if (slow) then
		dt = dt/4
	end
	xMouse,yMouse = love.mouse.getX(),love.mouse.getY()
	for i,v in ipairs(listOfStars) do
		v:update(dt)
	end
end

function love.draw()

	for i,v in ipairs(listOfStars) do
		v:draw()
	end

	if (help) then
		love.graphics.setBlendMode("alpha")
		love.graphics.setColor(0,0,0)
		love.graphics.rectangle("fill", 0, sHeight-190, 150, sHeight)
		love.graphics.setColor(255,255,255)
		love.graphics.print("F1 - Toggle Help", 5, sHeight-180)
		love.graphics.print("A - Toggle Stars", 5, sHeight-165)
		love.graphics.print("C - Toggle Circles", 5, sHeight-150)
		love.graphics.print("L - Toggle Linewidth", 5, sHeight-135)
		love.graphics.print("F - Toggle Following", 5, sHeight-120)
		love.graphics.print("B - Toggle Blending", 5, sHeight-105)
		love.graphics.print("S - Toggle Slowmotion", 5, sHeight-90)
		love.graphics.print("R - Remove all stars", 5, sHeight-75)
		love.graphics.print("G - Generate stars", 5, sHeight-60)
		love.graphics.print("Q - Reset all settings", 5, sHeight-45)
		love.graphics.print("Scroll for linewidth", 5, sHeight-30)
		love.graphics.print("Space - Fullscreen", 5, sHeight-15)
	end
end

function love.mousepressed(x,y,button)

	if (button == "l") then
		
		table.insert(listOfStars,createStar(x,y))
	end

	if (button == "r") then
		table.remove(listOfStars,#listOfStars)
	end

	if (button == "wu") then
		stablelineWidth = stablelineWidth + 1
	end
	if (button == "wd") then
		if (stablelineWidth>0) then
			stablelineWidth = stablelineWidth - 1
		end

	end

end

function love.keypressed(key)
	
	if (key==" ") then
		love.graphics.toggleFullscreen()
	end
	if (key == "a") then
		stars = not stars
	end
	if (key == "c") then
		outline = not outline
		inline = not inline
	end
	if (key == "l") then
		stableline = not stableline
	end
	if (key == "f") then
		follow = not follow
	end
	if (key == "g") then
		listOfStars = {}
		for i=1,30 do
			listOfStars[i]=createStar(sWidth/2,sHeight/2)
		end
		stars = true
		outline = randomBool()
		inline = outline
		stableline = randomBool()
		blend = randomBool()
		slow = randomBool()
		stablelineWidth = math.random(10)
	end
	if (key == "b") then
		blend = not blend
	end
	if (key == "s") then
		slow = not slow
	end
	if (key == "r") then
		if (#listOfSavedStars>0 and #listOfStars == 0) then
			listOfStars = listOfSavedStars
			listOfSavedStars = {}
		else
			listOfSavedStars = listOfStars
			listOfStars = {}
		end
		

	end
	if (key == "f1") then
		help = not help
	end
	if (key == "q") then
		stars = true
		outline = true
		inline = true
		stableline = false
		stablelineWidth = 1
		follow = false
		blend = false
		slow = false
	end
end


function getDistance(a,b)
	return math.abs(a-b)
end

function randomBool()
	local a = math.random(100)
	return a>50
end

function createStar(x,y)
	local a = values[3] + math_random(values[4])
	local b = a + math_random(values[4]+values[3]-a+math_random(values[5]))
	return star:new(x,y,values[1]+math_random(values[2]),b,a,-values[6]+math_random(values[7]),math_random(values[8]),math_random(values[9]),{math_random(255),math_random(255),math_random(255)},{math_random(255),math_random(255),math_random(255)},{math_random(255),math_random(255),math_random(255)})
end