-- main.lua

require "player"
require "invader"
require "wall"
require "projectile"
require "collision"

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	
	fontcms = love.graphics.newFont("graphics/comic.ttf", 20)
	love.graphics.setFont(fontcms)
	
	imgplayer = love.graphics.newImage("graphics/player.png")
	imgplayer_pop = love.graphics.newImage("graphics/player_pop.png")
	
	imginvader = {}
	imginvader[1] = love.graphics.newImage("graphics/invader1.png")
	imginvader[2] = love.graphics.newImage("graphics/invader2.png")
	imginvader[3] = love.graphics.newImage("graphics/invader_pop.png")
	
	imgwall = {}
	imgwall[1] = love.graphics.newImage("graphics/wall1.png")
	imgwall[2] = love.graphics.newImage("graphics/wall2.png")
	imgwall[3] = love.graphics.newImage("graphics/wall3.png")
	imgwall[4] = love.graphics.newImage("graphics/wall4.png")
	imgwall[5] = love.graphics.newImage("graphics/wall5.png")
	
	imgprojectile = {}
	imgprojectile[1] = love.graphics.newImage("graphics/player_lazer.png")
	imgprojectile[2] = love.graphics.newImage("graphics/invader_lazer.png")
	
	player.load()
	invader.load()
	wall.load()
	projectile.load()
end

function love.update(dt)
	dt = math.min(dt, 1/30)
	
	if player.state == "live" then
		player.update(dt)
		invader.update(dt)
		projectile.update(dt)
	end
end

function love.draw()
	projectile.draw()
	wall.draw()
	player.draw()
	invader.draw()
	
	if player.state == "live" then
		love.graphics.print("Space:shoot        Arrow:move                             good luck, comrade!", 5, 450)
	elseif player.state == "win" then
		love.graphics.print("Great, great, you earthling! -you won.", 5, 450)
	elseif player.state == "lose" then
		love.graphics.print("All your base are belong to us. -you lose.", 5, 450)
	end
	
end