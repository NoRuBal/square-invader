-- projectile.lua
projectile = {}

function projectile.load()
	projectile.speed = 300
end

function projectile.new(x, y, owner)
	local a
	
	for a = 1, #projectile do
		if projectile[a].enabled == false then
			projectile[a].x = x
			projectile[a].y = y
			projectile[a].owner = owner
			projectile[a].enabled = true
			return
		end
	end
	
	projectile[#projectile + 1] = {}
	projectile[#projectile].x = x
	projectile[#projectile].y = y
	projectile[#projectile].owner = owner
	projectile[#projectile].enabled = true
end

function projectile.update(dt)
	local a
	local b
	for a = 1, #projectile do
		if projectile[a].enabled == true then
			if projectile[a].owner == "player" then
				projectile[a].y = projectile[a].y - (projectile.speed * dt)
				
				for b = 1, 24 do
					if (invader[b].state == "live1") or (invader[b].state == "live2") then
						if collcheck(projectile[a].x, projectile[a].y, 5, 32, invader[b].x, invader[b].y, 32, 32) == true then
							invader[b].state = "baam"
							projectile[a].enabled = false
							invader.count = invader.count - 1
							
							invader.speed = invader.speed - 0.01875
							
							if invader.count == 0 then
								player.state = "win"
							end
						end
					end
				end
				
				if projectile[a].y + 32 <= 0 then
					projectile[a].enabled = false
				end
			elseif projectile[a].owner == "invader" then
				projectile[a].y = projectile[a].y + (projectile.speed * dt)
				
				--check collision with wall
				for b = 1, 4 do
					if not (wall[b].crash == 6) then
						if collcheck(projectile[a].x, projectile[a].y, 5, 32, wall[b].x, wall[b].y, 64, 32) == true then
							wall[b].crash = wall[b].crash + 1
							projectile[a].enabled = false
						end
					end
				end
				
				--check collision with player
				if collcheck(projectile[a].x, projectile[a].y, 5, 32, player.x, player.y, 32, 32) == true then
					player.state = "lose"
					projectile[a].enabled = false
				end
				
				if projectile[a].y >= 480 then
					projectile[a].enabled = false
				end
			end
		end
	end
end

function projectile.draw()
	local a
	for a = 1, #projectile do
		if projectile[a].enabled == true then
			if projectile[a].owner == "player" then
				love.graphics.draw(imgprojectile[1], projectile[a].x, projectile[a].y)
			elseif projectile[a].owner == "invader" then
				love.graphics.draw(imgprojectile[2], projectile[a].x, projectile[a].y)
			end
		end
	end
end