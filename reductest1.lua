-- MODE 2 MENIT - FINAL CLEAN
getgenv().Mode2Menit = false
task.wait(0.2)
getgenv().Mode2Menit = true

task.spawn(function()
    local plr = game.Players.LocalPlayer
    local durasi = 2 * 60 -- 2 menit

    print("⏳ MODE 2 MENIT AKTIF - Fase 1 Reduce Ringan")

    -- ANTI VOID STAY (dari awal)
    if workspace:FindFirstChild("AntiVoid") then workspace.AntiVoid:Destroy() end
    local plat = Instance.new("Part")
    plat.Name = "AntiVoid"
    plat.Size = Vector3.new(2000, 5, 2000)
    plat.Anchored = true
    plat.CanCollide = true
    plat.Transparency = 0.5
    plat.Color = Color3.fromRGB(20,20,20)
    plat.Parent = workspace

    task.spawn(function()
        while getgenv().Mode2Menit do
            task.wait(0.15)
            pcall(function()
                local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                if hrp then plat.Position = Vector3.new(hrp.Position.X, -10, hrp.Position.Z) end
            end)
        end
    end)

    -- REDUCE RINGAN FASE 1
    pcall(function()
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").FogEnd = 999999
        workspace.Terrain.WaterWaveSize = 0
        settings().Rendering.QualityLevel = 1
    end)

    -- COUNTDOWN 2 MENIT
    for i = durasi, 1, -1 do
        if not getgenv().Mode2Menit then return end
        if i == 120 then print("⏳ 2 menit lagi void") end
        if i == 60 then print("⏳ 1 menit lagi VOID TOTAL") end
        if i <= 10 then print("⏳ "..i.." detik lagi!") end
        task.wait(1)
    end

    -- FASE 2: VOID TOTAL + HAPUS SPOT
    print("💥 2 MENIT HABIS - VOID TOTAL SEKARANG!")
    pcall(function()
        workspace.Terrain:Clear() -- Clear 1x doang, gak spam
        workspace.Terrain.WaterTransparency = 1
        workspace.Terrain.WaterWaveSize = 0
    end)

    for _, v in pairs(workspace:GetChildren()) do
        if v.Name ~= "AntiVoid" and v.Name ~= "Terrain" and v.Name ~= "Camera" and not game.Players:FindFirstChild(v.Name) then
            if v:IsA("Model") or v:IsA("Folder") then pcall(function() v:Destroy() end) end
        end
    end

    workspace.ChildAdded:Connect(function(child)
        if not getgenv().Mode2Menit then return end
        if child.Name ~= "AntiVoid" and child.Name ~= "Terrain" and child.Name ~= "Camera" and not game.Players:FindFirstChild(child.Name) then
            if child:IsA("Model") or child:IsA("Folder") then 
                task.wait(0.5)
                pcall(function() child:Destroy() end) 
            end
        end
    end)
end)
