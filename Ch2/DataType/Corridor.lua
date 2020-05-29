--- corridor 保存 连接的两个节点, 并且表明两者是 走廊 还是 房间
--- 同时 corridor 还要放在 BSP 中的父节点上

---@class Corridor
---@field public startPos vector
---@field public endPos vector
local Corridor =
    Class {
    startPos,
    endPos
}

function Corridor:init(startPos, endPos)
    self.startPos = startPos or vector.zero
    self.endPos = endPos or vector.zero
end

function Corridor:draw()
    if (self.startPos.x < self.endPos.x) then
        swap(self.startPos, self.endPos)
    end
    local delta = self.endPos - self.startPos
    love.graphics.rectangle("fill", self.startPos.x, self.startPos.y, (delta.x + 1), (delta.y + 1))
end

return Corridor