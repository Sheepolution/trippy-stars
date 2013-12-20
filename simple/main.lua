function love.load()
	
	star = {
	x = 300,
	y = 300,
	pointNumber = 5,
	outSize = 300,
	inSize = 150,
	points = {}
	}

	for i=1,star.pointNumber do
		table.insert(star.points,star.x+math.cos((i*(360/star.pointNumber))/180*math.pi)*star.outSize)
		table.insert(star.points,star.y+math.sin((i*(360/star.pointNumber))/180*math.pi)*star.outSize)


		table.insert(star.points,star.x+math.cos((i*(360/star.pointNumber)+(180/star.pointNumber))/180*math.pi)*star.inSize)
		table.insert(star.points,star.y+math.sin((i*(360/star.pointNumber)+(180/star.pointNumber))/180*math.pi)*star.inSize)

	end

		table.insert(star.points,star.x+math.cos((1*(360/star.pointNumber))/180*math.pi)*star.outSize)
		table.insert(star.points,star.y+math.sin((1*(360/star.pointNumber))/180*math.pi)*star.outSize)



end

function love.draw()

	love.graphics.line(star.points)


end