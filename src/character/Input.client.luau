local replicatedStorage=game:GetService("ReplicatedStorage")
local userInputService=game:GetService("UserInputService")
local runService=game:GetService("RunService")

local remotes=replicatedStorage:WaitForChild("Remotes")

runService.RenderStepped:Connect(function(deltaTime:number)
    if userInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        remotes.Attack:FireServer({})
    end
end)