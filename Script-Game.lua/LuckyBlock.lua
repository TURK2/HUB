local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Window = Rayfield:CreateWindow({
   Name = "LuckyBlock Hub",
   LoadingTitle = "LuckyBlock Hub",
   LoadingSubtitle = "YT: TURKXSRCIPT",
   ConfigurationSaving = {
      Enabled = false
   }
})

-- Main Tab
local MainTab = Window:CreateTab("Main", 4483362458)

MainTab:CreateButton({
   Name = "Spawn LuckyBlock",
   Callback = function()
      ReplicatedStorage.SpawnLuckyBlock:FireServer()
   end,
})

MainTab:CreateButton({
   Name = "Spawn Super Block",
   Callback = function()
      ReplicatedStorage.SpawnSuperBlock:FireServer()
   end,
})

MainTab:CreateButton({
   Name = "Spawn Diamond Block",
   Callback = function()
      ReplicatedStorage.SpawnDiamondBlock:FireServer()
   end,
})

MainTab:CreateButton({
   Name = "Spawn Rainbow Block",
   Callback = function()
      ReplicatedStorage.SpawnRainbowBlock:FireServer()
   end,
})

MainTab:CreateButton({
   Name = "Spawn Galaxy Block",
   Callback = function()
      ReplicatedStorage.SpawnGalaxyBlock:FireServer()
   end,
})

-- About Tab
local AboutTab = Window:CreateTab("About", 4483362458)

AboutTab:CreateParagraph({
   Title = "Credits",
   Content = "YouTube: TURKXSRCIPT"
})

AboutTab:CreateButton({
   Name = "Copy Discord Link",
   Callback = function()
      setclipboard("https://discord.gg/yourlink")
      Rayfield:Notify({
         Title = "Copied!",
         Content = "Discord link copied to clipboard",
         Duration = 4,
      })
   end,
})