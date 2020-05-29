unpack = table.unpack or unpack

function math.remap(src, a, b, x, y)
    return ((src - a) * (y - x) / (b - a)) + x
end

function math.randomFloat(a, b)
    return math.remap(math.random(), 0, 1, a, b)
end

function math.rolldice(prob)
    return math.random() < prob
end

function swap(a, b)
    local tmp = b
    b = a
    a = tmp
end