local Room = Class {
    topLeft,
    bottomRight,
    size
}

--- @param center vector
--- @param size vector
function Room:init(center, size)
    local tl = center - vector(1, 1) - size / 2
    self.topLeft = vector(math.floor(tl.x), math.floor(tl.y))
    self.bottomRight = self.topLeft + size
    self.size = size
    print(self:__tostring())
end

function Room:draw()
    local x, y, w, h = self.topLeft.x, self.topLeft.y, self.size.x, self.size.y
    love.graphics.rectangle("fill", x, y, w, h)
end

function Room:__tostring()
    return string.format("Room: Topleft %s, Size %s", self.topLeft, self.size)
end

return Room