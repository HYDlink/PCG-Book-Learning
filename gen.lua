strs = "startPos, endPos"

for a in string.gmatch(strs, "%w+") do
    print(string.format("self.%s = %s", a, a))
end