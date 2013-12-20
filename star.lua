star = class:new()

function star:init(x,y,p,o,i,s,g,l,oc,ic,sc)

	self.x = x
	self.y = y
	self.pointNumber = p
	self.outSize = o
	self.inSize = i
	self.points = {}
	self.angle  = 0
	self.spinSpeed = s
	self.grow = g
	self.startOutSize = o
	self.startInSize = i
	self.oCircleColor = oc
	self.iCircleColor = ic
	self.starColor = sc
	self.lineWidth = l
end

function star:update(dt)

	self.points = {}
	self.angle = self.angle + self.spinSpeed * dt
	self.inSize = self.inSize - self.grow * dt
	self.outSize = self.outSize + self.grow * dt

	if (self.inSize>self.startOutSize) then
		self.grow = - self.grow
		self.inSize = self.startOutSize
	end
	if (self.inSize<self.startInSize) then
		self.grow = - self.grow
		self.inSize = self.startInSize
	end

	for i=1,self.pointNumber+1 do
		table.insert(self.points,self.x+math_cos((self.angle/180*math_pi)+(i*(360/self.pointNumber))/180*math_pi)*self.outSize)
		table.insert(self.points,self.y+math_sin((self.angle/180*math_pi)+(i*(360/self.pointNumber))/180*math_pi)*self.outSize)
		if (i~=self.pointNumber+1) then
			table.insert(self.points,self.x+math_cos((self.angle/180*math_pi)+(i*(360/self.pointNumber)+(180/self.pointNumber))/180*math_pi)*self.inSize)
			table.insert(self.points,self.y+math_sin((self.angle/180*math_pi)+(i*(360/self.pointNumber)+(180/self.pointNumber))/180*math_pi)*self.inSize)
		end
	end
	if (follow) then
		local radian = math_atan2(self.y-yMouse,self.x-xMouse)
		local sin = -math_sin(radian)
		local cos = -math_cos(radian)
		if (getDistance(self.x,xMouse)+getDistance(self.y,yMouse)>10) then
			self.x, self.y = self.x + (getDistance(self.x,xMouse)*2) * cos * dt, self.y + (getDistance(self.y,yMouse)*2) * sin * dt
		end
	end

end

function star:draw()
	if (blend) then
		love.graphics.setColor(0,0,0)
		love.graphics.setBlendMode("additive")
	else
		love.graphics.setColor(255,255,255)
		love.graphics.setBlendMode("alpha")
	end
	if (stableline) then
		love.graphics.setLineWidth(stablelineWidth)
	else
		love.graphics.setLineWidth(self.lineWidth)
	end
	love.graphics.setColor(self.oCircleColor[1],self.oCircleColor[2],self.oCircleColor[3])
	if (outline) then
		love.graphics.circle("line", self.x, self.y, self.outSize, 100)
	end
	love.graphics.setColor(self.iCircleColor[1],self.iCircleColor[2],self.iCircleColor[3])
	if (inline) then
		love.graphics.circle("line", self.x, self.y, self.inSize, 100)
	end
	love.graphics.setColor(self.starColor[1],self.starColor[2],self.starColor[3])
	if (stars) then
		love.graphics.line(self.points)
	end
end

