local Games = loadstring(game:HttpGet("https://raw.githubusercontent.com/TURK2/HUB/main/Run/Check-Game.lua"))()
print("📦 โหลดตารางเกมสำเร็จ:", Games)

for PlaceID, Execute in pairs(Games) do
    print("🔍 กำลังตรวจ:", PlaceID, Execute)
    if PlaceID == game.PlaceId then
        print("✅ ตรงกับ PlaceId! กำลังโหลด:", Execute)
        loadstring(game:HttpGet(Execute))()
    end
end
