-- Store Game PlaceId + Script links
local GameScripts = {
    [97777561575736] = "https://raw.githubusercontent.com/TURK2/HUB/main/Script-Game.lua/KayakRacing.lua", -- KayakRacing
    [662417684] = "https://raw.githubusercontent.com/TURK2/HUB/main/Script-Game.lua/LuckyBlock.lua", -- LuckyBlock
    -- Add more here
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId

if GameScripts[PlaceId] then
    -- If found, load script
    loadstring(game:HttpGet(GameScripts[PlaceId]))()
else
    -- If not found, kick player
    LocalPlayer:Kick("เกมนี้ไม่รองรับ ❌\nThis game is not supported ❌")
end
