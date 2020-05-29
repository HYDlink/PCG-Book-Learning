require 'Libs.util'
require 'conf'
vector = require 'Libs.vector'
lume = require 'Libs.lume'
Class = require "Libs.class"
Rect = require "DataType.Rect"
local Node = require "Generator.BSP"
local Agent = require "Generator.AgentBased"
local test = require 'test'

local fullRect
local bsp
local agent
function love.load()
    local w, h = 64, 48
    love.window.setMode(w * TILE_WIDTH, h * TILE_WIDTH)
    fullRect = Rect(0, 0, w, h)

    bsp = Node.createRandomCells(fullRect, 16, 4, 4)
    -- agent = Agent(vector(w / 2, h / 2))
    test.load()
end

function love.draw()
    love.graphics.scale(TILE_WIDTH, TILE_WIDTH)
    
    -- bsp:draw(16, 16)
    -- agent:draw()
    test.draw()
end
