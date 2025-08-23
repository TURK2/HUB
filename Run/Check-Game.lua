-- เก็บ Game PlaceId + ลิ้ง Script
local GameScripts = {
    [97777561575736] = "https://raw.githubusercontent.com/TURK2/HUB/main/Script-Game.lua/KayakRacing.lua", -- KayakRacing
    [662417684] = "https://raw.githubusercontent.com/TURK2/HUB/main/Script-Game.lua/LuckyBlock.lua", -- LuckyBlock
    -- เพิ่มได้เรื่อยๆ
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId

-- ตรวจสอบว่ามี Script สำหรับเกมนี้ไหม
if GameScripts[PlaceId] then
    -- โหลด Script ถ้ามี
    loadstring(game:HttpGet(GameScripts[PlaceId]))()
else
    -- ถ้าไม่เจอ → เตะผู้เล่นทันที พร้อมสองภาษา
    LocalPlayer:Kick("เกมนี้ไม่รองรับ ❌\nThis game is not supported ❌")
end
