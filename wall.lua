-- wall.lua 
wall = {}

function wall.load()
	local a
	for a = 1, 4 do
		wall[a] = {}
		wall[a].x = a * 76 + (a - 1) * 64
		wall[a].y = 360
		wall[a].crash = 1
	end
end

function wall.draw()
	local a
	for a = 1, 4 do
		if not (wall[a].crash == 6) then
			love.graphics.draw(imgwall[wall[a].crash], wall[a].x, wall[a].y)
		end
	end
end