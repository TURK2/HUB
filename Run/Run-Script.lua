loadstring(game:HttpGet("https://raw.githubusercontent.com/TURK2/HUB/refs/heads/main/Run/Check-Game.lua"))()
for PlaceID, Execute in pairs(Games) do
    if PlaceID == game.PlaceId then
        loadstring(game:HttpGet(Execute))()
    end
end