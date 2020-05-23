--- BSP 节点的内容
--- 横向分割还是竖向分割，分割的百分比
--- 两个节点指针，当前节点的数据
local Rect = require "Rect"
local DIV = {"h", "v"}

---@class Node
---@field public rect Rect
local Node =
    Class {
    rect,
    division,
    divPercent,
    child1,
    child2
}

---@return boolean
function Node:isLeaf()
    if self.child1 == nil and self.child2 == nil then
        return true
    else
        return false
    end
    -- return (self.child1 or self.child2) and false or true
end

function Node:init(rect, division, divPercent, child1, child2)
    self.rect = rect
    self.division = division
    self.divPercent = divPercent
    self.child1 = child1
    self.child2 = child2
end

function Node:div(division, divPercent)
    self.division = division or self.division
    self.divPercent = divPercent or self.divPercent

    if not self.divPercent and not self.divPercent then
        return
    end

    local newRect1, newRect2
    local r = self.rect
    if "h" == self.division then
        local nw = math.floor(r.w * self.divPercent)
        newRect1 = Rect(r.x, r.y, nw, r.h)
        newRect2 = Rect(r.x + nw, r.y, r.w - nw, r.h)
    else
        local nh = math.floor(r.h * self.divPercent)
        newRect1 = Rect(r.x, r.y, r.w, nh)
        newRect2 = Rect(r.x, r.y + nh, r.w, r.h - nh)
    end
    assert(newRect1 and newRect2)
    assert(not Rect.intersect(newRect1, newRect2), newRect1:__tostring() .. newRect2:__tostring())
    self.child1 = Node(newRect1)
    self.child2 = Node(newRect2)
end

---@return Node
---@param rect Rect
---TODO create cell, hover on rect to show info, save rect dict
function Node.createRandomBSP(rect, depth, minW, minH, funcRectNode)
    if depth <= 0 or rect.w < minW or rect.h < minH then
        print(depth, rect)
        return nil
    end

    local div = DIV[math.random(1, 2)]
    -- 被 math.random(m, n) 摆了一套, 带参数, 得到的结果就一定是整数
    local divPercent = math.random() / 2 + 0.3
    print(depth, rect, div, divPercent)

    local node = Node(rect, div, divPercent)
    node:div()
    if funcRectNode then
        funcRectNode(rect, node)
    end

    node.child1 = Node.createRandomBSP(node.child1.rect, depth - 1, minW, minH, funcRectNode)
    node.child2 = Node.createRandomBSP(node.child2.rect, depth - 1, minW, minH, funcRectNode)

    return node
end

function Node:traverse(func, maxDepth, depth)
    func(self, maxDepth, depth)

    if self:isLeaf() then
        return
    else
        if self.child1 then
            self.child1:traverse(func, maxDepth, depth - 1)
        end
        if self.child2 then
            self.child2:traverse(func, maxDepth, depth - 1)
        end
    end
end

local MARGIN = 4
function Node:draw(maxDepth, depth)
    self:traverse(
        function(node, maxDepth, depth)
            if node:isLeaf() then
                local r = node.rect
                love.graphics.setColor(1, 0, 0, 1)
                love.graphics.rectangle("fill", r.x, r.y, r.w, r.h)

                local c = node.cell
                love.graphics.setColor(depth / maxDepth, depth / maxDepth, depth / maxDepth, 1)
                love.graphics.rectangle("fill", c.x, c.y, c.w, c.h)
            end
        end,
        maxDepth,
        depth
    )
end

return Node
