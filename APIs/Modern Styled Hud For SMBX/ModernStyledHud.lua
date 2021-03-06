------------------------------------------------------------------------
--                                                                    --
--  Modern Styled Hud For SMBX                                        --
--  Made by Love Bodhi                                                --
--                                                                    --
--  This replaces Original SMW Styled Hud with a Modern Styled Hud.   --
--  Like NSMBWii,SMM,etc.                                             --
--                                                                    --
--  Documentation: https://pastebin.com/s7hFRG4U                      --
--                                                                    --
------------------------------------------------------------------------

local modernhud = {}

local timelimit = false

local timerApi = API.load("leveltimer")

modernhud.STYLE_SMB1 = 1
modernhud.STYLE_SMB2 = 2
modernhud.STYLE_SMB3 = 3
modernhud.STYLE_SMW = 4
modernhud.STYLE_CUSTOM = 5

local char1 = {Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB1/Char1.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB2/Char1.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB3/Char1.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMW/Char1.png")),Graphics.loadImage(Misc.resolveFile("Hud/Custom/Mario.png"))}
local char2 = {Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB1/Char2.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB2/Char2.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB3/Char2.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMW/Char2.png")),Graphics.loadImage(Misc.resolveFile("Hud/Custom/Luigi.png"))}
local char3 = {Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB1/Char3.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB2/Char3.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB3/Char3.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMW/Char3.png")),Graphics.loadImage(Misc.resolveFile("Hud/Custom/Peach.png"))}
local char4 = {Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB1/Char4.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB2/Char4.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB3/Char4.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMW/Char4.png")),Graphics.loadImage(Misc.resolveFile("Hud/Custom/Toad.png"))}
local char5 = {Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB1/Char5.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB2/Char5.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB3/Char5.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMW/Char5.png")),Graphics.loadImage(Misc.resolveFile("Hud/Custom/Link.png"))}
local coincounter = {Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB1/Coin.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB2/Coin.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB3/Coin.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMW/Coin.png")),Graphics.loadImage(Misc.resolveFile("Hud/Custom/Coin.png"))}
local starcounter = {Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB1/Star.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB2/Star.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB3/Star.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMW/Star.png")),Graphics.loadImage(Misc.resolveFile("Hud/Custom/Star.png"))}

local multiplier = {Graphics.loadImage(Misc.resolveFile("Hud/Preset/Multiplier.png")),Graphics.loadImage(Misc.resolveFile("Hud/Custom/Multiplier.png"))}
local reservebox = {Graphics.loadImage(Misc.resolveFile("Hud/Preset/ReserveBox.png")),
Graphics.loadImage(Misc.resolveFile("Hud/Custom/ReserveBox.png"))}

local heartbg = {Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB1/HeartBG.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB2/HeartBG.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB3/HeartBG.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMW/HeartBG.png")),Graphics.loadImage(Misc.resolveFile("Hud/Custom/HeartBG.png"))}
local heartfill = {Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB1/HeartFill.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB2/HeartFill.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMB3/HeartFill.png")),Graphics.loadImage(Misc.resolveFile("Hud/Preset/SMW/HeartFill.png")),Graphics.loadImage(Misc.resolveFile("Hud/Custom/HeartFill.png"))}
local timergfx = Graphics.loadImage(Misc.resolveFile("leveltimer/ui.png"))

modernhud.style = modernhud.STYLE_CUSTOM
modernhud.timecounter = 400
modernhud.usereserve = true
modernhud.showhud = true

function modernhud.onInitAPI()
registerEvent(modernhud,"onStart","onStart",true)
registerEvent(modernhud,"onTick","onTick",true)
registerEvent(modernhud,"onHUDDraw","onHUDDraw",true)
end

function modernhud.onStart()
timerApi.GUIPosition_NoStars = {x = 658, y = 47}
timerApi.GUIPosition_Stars = {x = 658, y = 47}
Graphics.activateHud(false)
end

function modernhud.onTick()
if not modernhud.usereserve then
player.reservePowerup = 0
end
end

function modernhud.onHUDDraw()
if modernhud.showhud then
modernhud.drawhud()
end
end

function modernhud.drawhud()
if not timelimit then
Graphics.drawImageWP(timergfx,658,47,5)
Text.printWP("0",1,702,48,5)
end
if (player.character == CHARACTER_MARIO) then
Graphics.drawImageWP(char1[modernhud.style],32,30,5)
end
if (player.character == CHARACTER_LUIGI) then
Graphics.drawImageWP(char2[modernhud.style],32,30,5)
end
if (player.character == CHARACTER_PEACH) then
Graphics.drawImageWP(char3[modernhud.style],32,30,5)
end
if (player.character == CHARACTER_TOAD) then
Graphics.drawImageWP(char4[modernhud.style],32,30,5)
end
if (player.character == CHARACTER_LINK) then
Graphics.drawImageWP(char5[modernhud.style],32,30,5)
end
Text.printWP(string.format("%08d",mem(0x00B2C8E4,FIELD_DWORD)),1,480,48,5)
Text.printWP(mem(0x00B2C5AC,FIELD_FLOAT),1,84,48,5)
Text.printWP(mem(0x00B2C5A8,FIELD_WORD),1,84,86,5)
Text.printWP(mem(0x00B251E0,FIELD_WORD),1,84,124,5)
Graphics.drawImageWP(coincounter[modernhud.style],32,68,5)
Graphics.drawImageWP(starcounter[modernhud.style],32,106,5)
if modernhud.style == modernhud.STYLE_CUSTOM then
Graphics.drawImageWP(multiplier[2],66,48,5)
Graphics.drawImageWP(multiplier[2],66,86,5)
Graphics.drawImageWP(multiplier[2],66,124,5)
else
Graphics.drawImageWP(multiplier[1],66,48,5)
Graphics.drawImageWP(multiplier[1],66,86,5)
Graphics.drawImageWP(multiplier[1],66,124,5)
end
if modernhud.usereserve and (player.character == CHARACTER_MARIO or player.character == CHARACTER_LUIGI) then
if modernhud.style == modernhud.STYLE_CUSTOM then
Graphics.drawImageWP(reservebox[2],372,30,3)
else
Graphics.drawImageWP(reservebox[1],372,30,3)
end
if player.reservePowerup > 0 then
local reservepower = Graphics.sprites.npc[player.reservePowerup].img
Graphics.draw{type = RTYPE_IMAGE,image = reservepower, x = 384, y = 42, sourceWidth = 32, sourceHeight = 32}
end
end
if (player.character == CHARACTER_PEACH) or (player.character == CHARACTER_TOAD) or (player.character == CHARACTER_LINK) then
Graphics.drawImageWP(heartbg[modernhud.style],357,38,4)
Graphics.drawImageWP(heartbg[modernhud.style],389,38,4)
Graphics.drawImageWP(heartbg[modernhud.style],421,38,4)
if (player:mem(0x16,FIELD_WORD)) == 1 then
Graphics.drawImageWP(heartfill[modernhud.style],357,38,5)
elseif (player:mem(0x16,FIELD_WORD)) == 2 then
Graphics.drawImageWP(heartfill[modernhud.style],357,38,5)
Graphics.drawImageWP(heartfill[modernhud.style],389,38,5)
elseif (player:mem(0x16,FIELD_WORD)) == 3 then
Graphics.drawImageWP(heartfill[modernhud.style],357,38,5)
Graphics.drawImageWP(heartfill[modernhud.style],389,38,5)
Graphics.drawImageWP(heartfill[modernhud.style],421,38,5)
end
end
end

function modernhud.timelimitOn()
timerApi.setTimerState(true)
timerApi.setSecondsLeft(modernhud.timecounter)
timelimit = true
end

function modernhud.timelimitOff()
timerApi.setTimerState(false)
timelimit = false
end

return modernhud