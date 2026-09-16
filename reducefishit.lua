-- 2 FASE FINAL - REDUCE LANGSUNG + VOID + AIR HILANG SETELAH 5 MENIT
getgenv().TwoPhase = true

task.spawn(function()
    local plr = game.Players.LocalPlayer
    local delayMenit = 2

    print("✅ FASE 1: REDUCE RINGAN LANGSUNG AKTIF")

    -- SETTING RINGAN FASE 1
    pcall(function()
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").FogEnd = 999999
        game:GetService("Lighting").Brightness = 0
        workspace.Terrain.WaterWaveSize = 0
        workspace.Terrain.WaterWaveSpeed = 0
        workspace.Terrain.WaterReflectance = 0
        settings().Rendering.QualityLevel = 1
        for _, v in pairs(game:GetService("Lighting"):GetChildren()) do
            if v:IsA("BlurEffect") or v:IsA("SunRays") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                v.Enabled = false
            end
        end
    end)

    -- ANTI VOID DARI AWAL
    if workspace:FindFirstChild("AntiVoid") then workspace.AntiVoid:Destroy() end
    local plat = Instance.new("Part")
    plat.Name = "AntiVoid"
    plat.Size = Vector3.new(300, 2, 300)
    plat.Anchored = true
    plat.CanCollide = true
    plat.Color = Color3.fromRGB(30,30,30)
    plat.Transparency = 0.5
    plat.Parent = workspace
    
    task.spawn(function()
        while getgenv().TwoPhase do
            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                plat.Position = plr.Character.HumanoidRootPart.Position - Vector3.new(0,6,0)
            end
            task.wait(0.05)
        end
    end)

    -- FUNGSI REDUCE RINGAN FASE 1
    local function reduceRingan()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("PointLight") or v:IsA("SpotLight") then
                pcall(function() v:Destroy() end)
            elseif v:IsA("Decal") or v:IsA("Texture") then
                pcall(function() v.Transparency = 1 end)
            end
        end
    end

    reduceRingan()

    -- COUNTDOWN 5 MENIT
    for i = delayMenit*60, 1, -1 do
        if not getgenv().TwoPhase then return end
        if i % 60 == 0 then print("⏳ FASE 1 - Sisa "..(i/60).." menit ke VOID TOTAL + HAPUS AIR") end
        if i == 60 then print("⏳ 1 menit lagi VOID + AIR HILANG!") end
        if i <= 10 then print("⏳ "..i.." detik lagi!") end
        if i % 30 == 0 then reduceRingan() end
        task.wait(1)
    end

    -- FASE 2: VOID TOTAL + AIR HILANG
    print("💥 FASE 2: VOID TOTAL + AIR HILANG SEKARANG!")
    
    pcall(function()
        workspace.Terrain:Clear()
        workspace.Terrain.WaterTransparency = 1
        workspace.Terrain.WaterWaveSize = 0
        workspace.Terrain.WaterReflectance = 0
    end)

    plat.Transparency = 0
    plat.Size = Vector3.new(500,2,500)

    local function hajarTotal(obj)
        if obj.Name == "AntiVoid" or obj.Name == "Terrain" or obj.Name == "Camera" then return end
        if game.Players:FindFirstChild(obj.Name) then return end
        if obj.Parent ~= workspace then return end
        if obj:IsA("Model") or obj:IsA("Folder") then
            pcall(function() obj:Destroy() end)
        end
    end

    for _, v in pairs(workspace:GetChildren()) do hajarTotal(v) end

    workspace.ChildAdded:Connect(function(child)
        if not getgenv().TwoPhase then return end
        task.wait(0.2)
        hajarTotal(child)
    end)

    while getgenv().TwoPhase do
        task.wait(2)
        pcall(function() 
            workspace.Terrain:Clear()
            workspace.Terrain.WaterTransparency = 1 
        end)
        for _, v in pairs(workspace:GetChildren()) do
            if v.Name ~= "AntiVoid" and v.Name ~= "Terrain" and v.Name ~= "Camera" and not game.Players:FindFirstChild(v.Name) then
                if v:IsA("Model") or v:IsA("Folder") then pcall(function() v:Destroy() end) end
            end
        end
    end
end)
