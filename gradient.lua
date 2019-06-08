love.gradient = {}

love.gradient.types = {"linear", "radial", "angle", "rhombus", "square"}
love.gradient.images = {}

for i, v in ipairs(love.gradient.types) do
	if love.filesystem.getInfo("gradients/" .. v .. ".png") ~= nil then
		love.gradient.images[v] = love.graphics.newImage("gradients/" .. v .. ".png")
	else
		error("Gradient image \"" .. v .. "\" is missing. Make sure the folder is named \"gradients\" and that it's on the same level as \"main.lua\".")
	end
end

function love.gradient.draw(f, gr, cx, cy, w, h, c1, c2, a, sx, sy)
	local a = a or 0
	if a == 0 then a = 0 end --because -0 or something :S
	local sx = sx or 1
	local sy = sy or 1
	
	--Huge, detailed error handler
	--Just in case people are too lazy to read the "How-to-use" thing
	
	do --Except for using Np++'s collapsible tabs, this sounds useless...
		if type(f) ~= "function" then
			error("Gradient's argument #1 must be a drawing function.")
		end
		local s = false
		for i, v in ipairs(love.gradient.types) do
			if gr == v then
				s = true
				break
			end
		end
		if not s then
			s = "Gradient's argument #2 must be a gradient type ("
			for i = 1, #love.gradient.types do
				if i < #love.gradient.types then
					s = s .. v .. ", "
				end
			end
			error(s)
		end
		if type(cx) ~= "number" then
			error("Gradient's argument #3 must be a number (the central X point).")
		end
		if type(cy) ~= "number" then
			error("Gradient's argument #4 must be a number (the central Y point).")
		end
		if type(w) ~= "number" then
			error("Gradient's argument #5 must be a number (the gradient's width).")
		end
		if type(h) ~= "number" then
			error("Gradient's argument #6 must be a number (the gradient's height).")
		end
		if type(c1) ~= "table" or #c1 < 3 or #c1 > 4 then
			error("Gradient's argument #7 must be a color table.")
		end
		if type(c2) ~= "table" or #c2 < 3 or #c2 > 4 then
			error("Gradient's argument #8 must be a color table.")
		end
		if type(a) ~= "number" then
			error("Gradient's argument #9 must be a number (the gradient's angle) or nil (default: 0).")
		end
		if type(sx) ~= "number" then
			error("Gradient's argument #10 must be a number (the gradient's X scale) or nil (default: 1).")
		end
		if type(sy) ~= "number" then
			error("Gradient's argument #11 must be a number (the gradient's Y scale) or nil (default: 1).")
		end
	end
	
	local myStencil = function()
		f()
	end
	
	love.graphics.stencil(myStencil)
	love.graphics.push()
	--Let the games begin...
	local px, py = cx, cy
	love.graphics.translate(px, py)
	love.graphics.rotate(a)
	
	love.graphics.setColor(unpack(c2))
	love.graphics.rectangle("fill", -w/2, -h/2, w, h)
	love.graphics.setColor(unpack(c1))
	local i = love.gradient.images[gr]
	love.graphics.draw(i, -w/2, -h/2, 0, w*sx/i:getWidth(), h*sy/i:getHeight())
	
	love.graphics.pop()
	love.graphics.setStencilTest()
end
