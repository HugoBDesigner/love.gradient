require "gradient"

love.graphics.setBackgroundColor(1, 1, 1)
function love.draw()

	-- Rectangle with square gradient
	local color1 = {1, 0, 0, 1} -- Red
	local color2 = {0, 1, 0, 1} -- Green

	local x, y = 40, 60
	local width, height = 300, 150

	love.gradient.draw(
		function()
			love.graphics.rectangle("fill", x, y, width, height)
		end, "square",
		x + width/2, y + height/2, width/2, height/2, color1, color2)


	-- Circle with radial gradient
	color1 = {0, 1, 1, 1} -- Cyan
	color2 = {1, 0, .5, 1} -- Fuchsia
	x, y = 600, 400
	local radius = 100

	love.gradient.draw(
		function()
			love.graphics.circle("fill", x, y, radius, 64)
			love.graphics.circle("line", x, y, radius, 64)
		end, "radial",
		x, y, radius, radius, color1, color2)
end
