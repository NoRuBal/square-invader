-- inavder.lua 
invader = {}

function invader.load()
	local a
	for a = 1, 24 do
		invader[a] = {}
		invader[a].x = 47 * (a % 8) + 10
		invader[a].y = math.floor((a - 1) / 8) * 47 + 10
		if math.floor((a - 1) / 8) == 1 then
			invader[a].state = "live2" --live1/live2/baam/dead
		else
			invader[a].state = "live1" --live1/live2/baam/dead
		end
		
	end
	
	invader.timer = 0
	invader.speed = 0.5
	invader.count = 24
	invader.direction = "right"
	
	invader.lazercount = 2
end

function invader.update(dt)
	local a
	local direction
	local randominv
	local tmp
	
	invader.timer = invader.timer + dt
	if invader.timer >= invader.speed then --modify 0.5. it shuold proportional to invader.count
		invader.timer = invader.timer - invader.speed
		
		--move invaders
		direction = nil
		tmp = nil
		
		for a = 1, 24 do
			if invader[a].state == "live1" then
				invader[a].state = "live2"
			elseif invader[a].state == "live2" then
				invader[a].state = "live1"
			elseif invader[a].state == "baam" then
				invader[a].state = "dead"
			end
			
			if (invader[a].state == "live1") or (invader[a].state == "live2") then
				if invader.direction == "left" then
					invader[a].x = invader[a].x - 15
					if invader[a].x <= 15 then
						direction = "down"
					end
				elseif invader.direction == "right" then
					invader[a].x = invader[a].x + 15
					if invader[a].x >= 593 then
						direction = "down"
					end
				elseif invader.direction == "down" then
					invader[a].y = invader[a].y + 15
					if invader[a].x <= 15 then
						direction = "right"
					elseif invader[a].x >= 593 then
						direction = "left"
					end
					
					--check if invaders landed to earth
					if invader[a].y >= 415 - 32 then
						player.state = "lose"
					end
					
				end
			end
		end
		
		if not(direction == nil) then
			invader.direction = direction
		end
		
		--shoot lazer
		invader.lazercount = invader.lazercount - 1
		if invader.lazercount == 1 then
			invader.lazercount = 5
			
			randominv = love.math.random(1, 24)
			if (invader[randominv].state == "baam") or (invader[randominv].state == "dead") then
				tmp = "dupe"
			else
				tmp = nil
			end
			
			while (tmp == "dupe") do
				randominv = love.math.random(1, 24)
				if (invader[randominv].state == "baam") or (invader[randominv].state == "dead") then
					tmp = "dupe"
				else
					tmp = nil
				end
			end

			projectile.new(invader[randominv].x + 15, invader[randominv].y, "invader")
			
		end
	end
end

function invader.draw()
	for a = 1, 24 do
		if invader[a].state == "live1" then
			love.graphics.draw(imginvader[1], invader[a].x, invader[a].y)
		elseif invader[a].state == "live2" then
			love.graphics.draw(imginvader[2], invader[a].x, invader[a].y)
		elseif invader[a].state == "baam" then
			love.graphics.draw(imginvader[3], invader[a].x, invader[a].y)
		end
	end
end