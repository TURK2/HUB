-- โหลด Check-Game
local Games = loadstring(game:HttpGet("https://raw.githubusercontent.com/TURK2/HUB/main/Run/Check-Game.lua"))()

-- ตรวจสอบและรัน script ที่ตรงกับ game.PlaceId
for PlaceID, Execute in pairs(Games) do
    if PlaceID == game.PlaceId then
        loadstring(game:HttpGet(Execute))()
    end
end
-- ถ้าไม่เจอ PlaceId ใน Check-Game ให้เตะออก
if not found then
    game.Players.LocalPlayer:Kick("Game not supported!")
end
