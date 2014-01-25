-- constants
CELL_DIMENSION = 65

Character =  {}
Character.__index = Character

setmetatable(Character, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
	})

function Character.new(name, imagePath)
	local self = setmetatable({}, Character)
	self.name = name
	self.makeQuads(self, imagePath)
	return self
end

function Character:makeQuads(imagePath)
	self.image = love.graphics.newImage(imagePath)
	-- image is 640 x 320, so sprites are 64 x 64
	self.walkingQuads = {}
	for i=0, 3 do
		self.walkingQuads[i] = {}
		for j= 0, 640, 64 do
			local newQuad = love.graphics.newQuad(j, i*64, 64, 64, 640, 320)
			table.insert(self.walkingQuads[i], newQuad)
		end
	end

end


function moveCharacter(dt)
	if love.keyboard.isDown("left", "right", "up", "down") then
		frame = (frame % 10) + 1
	end 

    if love.keyboard.isDown("left") then
		x = x - 200 * dt
    	direction = 1
    end
    
    if love.keyboard.isDown("right") then
		x = x + 200 * dt
    	direction = 3
    end
    
    if love.keyboard.isDown("up") then
		y = y - 200 * dt
    	direction = 0
    end
    
    if love.keyboard.isDown("down") then
		y = y + 200 * dt
    	direction = 2
    end
end

function love.load()
	local f = love.graphics.newFont(love._vera_ttf, 14)
	characters = {}
	x, y = 500, 500
	frame = 1
	direction = 1
	love.graphics.setFont(f)
	character = Character("spider", 'gfx/spider10.png')
	love.mouse.setVisible(false)
end 

function love.update(dt)
	love.timer.sleep(0.05)
	moveCharacter(dt)
end

function love.draw()
	love.graphics.draw(character.image, character.walkingQuads[direction][frame], x, y)
end