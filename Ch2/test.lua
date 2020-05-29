Class = require "Libs.class"
local Rect = require "DataType.Rect"
local Node = require "Generator.BSP"
local Room = require "DataType.Room"
local Corridor = require "DataType.Corridor"

local test = {}

fullRect = Rect(0, 0, 640, 480)
bsp = Node.createRandomBSP(fullRect, 16, 64, 64, createCell)

local rooms = {}
local corridors = {}
function test.load()
    for i = 1, 10 do
        local room = Room(vector(i) * 2, vector(i) * 2)
        local corridor = Corridor(vector(i) * 2, vector(i * 2, i * 2 + 10))
        table.insert(rooms, room)
        table.insert(corridors, corridor)
    end
end
drawcorridor = true
function test.draw()
    if drawroom then
        for i = 1, #rooms do
            love.graphics.setColor(i / #rooms, i / #rooms, i / #rooms, 1)
            rooms[i]:draw()
        end
    end
    if drawcorridor then
        for i = 1, #corridors do
            love.graphics.setColor(i / #rooms, i / #rooms, i / #rooms, 1)
            corridors[i]:draw()
        end
    end
end

return test
