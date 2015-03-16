-- player.lua
player = {}

function player.load()
	player.state = "live" --live/win/lose
	player.x = 300
	player.y = 415
	player.speed = 200
end

function player.update(dt)
	local a
	if player.state == "live" then
		if love.keyboard.isDown("right") then
			if not (player.x + (player.speed * dt) > 640 - 32) then
				player.x = player.x + (player.speed * dt)
			else
				player.x = 640 - 32
			end
		end
		if love.keyboard.isDown("left") then
			if not (player.x - (player.speed * dt) < 0) then
				player.x = player.x - (player.speed * dt)
			else
				player.x = 0
			end
		end
		if love.keyboard.isDown(" ") then
			for a = 1, #projectile do
				if (projectile[a].owner == "player") and (projectile[a].enabled == true) then
					return
				end
			end
			projectile.new(player.x + 14, player.y, "player")
		end
	end
end

function player.draw()
	if player.state == "lose" then
		love.graphics.draw(imgplayer_pop, player.x, player.y)
	else
		love.graphics.draw(imgplayer, player.x, player.y)
	end
end