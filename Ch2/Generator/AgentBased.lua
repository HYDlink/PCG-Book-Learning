local Corridor = require "DataType.Corridor"
local Room = require "DataType.Room"
local rooms = {}
local corridors = {}

local CONF = {
    ROOM_MIN = 3,
    ROOM_MAX = 7,
    AGENT_ROOM_INCPROB = 0.05,
    AGENT_CHNAGEDIR_INCPROB = 0.05,
    AGENT_ROOM_INITPROB = 0,
    AGENT_CHNAGEDIR_INITPROB = 0,
    MAX_ROOM_NUM = 3
}

local DIRS = {
    vector(0, 1),
    vector(0, -1),
    vector(-1, 0),
    vector(1, 0)
}

--- @class Agent
--- @field public pos vector
--- @field public dir vector
--- @field public lastpos vector
local Agent =
    Class {
    pos,
    dir,
    lastPos, -- 上一个转角的位置，用来展示 走廊的起点
    roomProb,
    turnDirProb
}

function Agent:init(pos)
    assert(vector.isvector(pos))
    self.pos = pos
    self.lastPos = pos
    self.roomProb = CONF.AGENT_ROOM_INITPROB
    self.turnDirProb = CONF.AGENT_CHNAGEDIR_INITPROB
    self:run()
end

local times = 0
local function largeEnough()
    return #rooms > CONF.MAX_ROOM_NUM
end

function Agent:run()
    self:changeDir()
    repeat
        if math.rolldice(self.roomProb) then
            self:createRoom()
        end
        if math.rolldice(self.turnDirProb) then
            self:changeDir()
        end
        self:dig()
        self.roomProb = self.roomProb + CONF.AGENT_ROOM_INCPROB
        self.turnDirProb = self.turnDirProb + CONF.AGENT_CHNAGEDIR_INCPROB
        -- print('dead loop run')
        times = times + 1
    until largeEnough()
end

function Agent:dig()
    self.pos = self.pos + self.dir * 2
end

function Agent:changeDir()
    local newDir
    repeat
        newDir = lume.randomchoice(DIRS)
    until newDir ~= self.dir
    self.dir = newDir
    self:createCorridor()
    self.turnDirProb = CONF.AGENT_CHNAGEDIR_INITPROB
    -- print("Changed Dir at ", self.pos)
end

function Agent:createCorridor()
    table.insert(corridors, Corridor(self.lastpos, self.pos))
    self.lastpos = self.pos
end

function Agent:createRoom()
    self:createCorridor()
    local size = vector(math.random(CONF.ROOM_MIN, CONF.ROOM_MAX), math.random(CONF.ROOM_MIN, CONF.ROOM_MAX))
    assert(vector.isvector(self.pos))
    assert(vector.isvector(size))
    table.insert(rooms, Room(self.pos, size))
    self.roomProb = CONF.AGENT_ROOM_INITPROB
    print("Create Room at ", self.pos, " in ", size)
end

function Agent:draw()
    lume.each(rooms, Room.draw)
    lume.each(corridors, Corridor.draw)
end

return Agent
