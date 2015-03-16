-- collision.lua

function collcheck(pic1x, pic1y, pic1width, pic1height, pic2x, pic2y, pic2width, pic2height)
-- check if pix1 and pix2 collide
-- usage: collcheck(blabla~) => true|false
    if (pic1x + pic1width) > pic2x and pic1x < (pic2x + pic2width) then
        if (pic1y + pic1height) > pic2y and pic1y < (pic2y + pic2height) then
            return true
        end
    end

	return false
end