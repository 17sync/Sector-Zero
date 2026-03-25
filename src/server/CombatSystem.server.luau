local debris=game:GetService("Debris")
local replicatedStorage=game:GetService("ReplicatedStorage")

local remotes=replicatedStorage:WaitForChild("Remotes")
local shared=replicatedStorage:WaitForChild("Shared")

remotes.Attack.OnServerEvent:Connect(function(player: Player, argumentData)
    local character=player.Character

    if character then
        local humanoid: Humanoid=character:FindFirstChild("Humanoid")
        if humanoid then
            if character:FindFirstChild("Attacking") then
                return
            end

            local attacking=Instance.new("BoolValue")
            attacking.Name="Attacking"
            attacking.Parent=character
            attacking.Value=true

            local hitboxClone=shared.HitboxTemplate:Clone()
            hitboxClone.Name="Hitbox"

            local weld=Instance.new("Weld")
            weld.Part0=hitboxClone
            weld.Part1=character:FindFirstChild("HumanoidRootPart")
            weld.C0=CFrame.new(0, .5, 3)
            weld.Parent=hitboxClone
            hitboxClone.Parent=workspace.Hitboxes

            task.spawn(function()
                local OverlappingParams=OverlapParams.new()
                OverlappingParams.FilterType=Enum.RaycastFilterType.Exclude
                OverlappingParams.FilterDescendantsInstances={character, workspace.Hitboxes}

                local alreadyHit={}

                while hitboxClone.Parent do
                    local partsDetected=workspace:GetPartsInPart(hitboxClone, OverlappingParams)
                    
                    for _, part in partsDetected do
                        if part.Parent and part.Parent:FindFirstChild("Humanoid") then
                            local target=part.Parent
                            
                            if alreadyHit[target] then
                                return
                            end
                            alreadyHit[target]=true

                            local targetHumanoid: Humanoid=target.Humanoid
                            targetHumanoid:TakeDamage(5)
                        end
                    end
                    
                    task.wait()
                end
            end)

            debris:AddItem(hitboxClone, .35)
            debris:AddItem(attacking, .5)

            print("Fierce attack from ".. player.Name.. "!")
        end
    end
end)
