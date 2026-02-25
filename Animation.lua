local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local bannedAnimations = {
	"rbxassetid://27789359",
	"rbxassetid://30196114",
	"rbxassetid://248263260",
	"rbxassetid://45834924",
	"rbxassetid://33796059",
	"rbxassetid://28488254",
	"rbxassetid://52155728",
	"rbxassetid://3333432454",
	"rbxassetid://4555808220",
	"rbxassetid://4049037604",
	"rbxassetid://4555782893",
	"rbxassetid://10214311282",
	"rbxassetid://10714010337",
	"rbxassetid://10713981723",
	"rbxassetid://10714372526",
	"rbxassetid://10714076981",
	"rbxassetid://10714392151",
	"rbxassetid://11444443576",
	"rbxassetid://72042024", 
	"rbxassetid://698251653" 
}

local function banPlayer(player)
	local banConfig = {
		UserIds = {player.UserId},
		Duration = -1, 
		Reason = "\n[VHL GUARD]\nAcces restricționat permanent!\nMotiv: Animation\n\nPentru apel, deschide un ticket pe serverul nostru de Discord.",
		PrivateReason = "\n[VHL GUARD]\nAcces restricționat permanent!\nMotiv: Animation\n\nPentru apel, deschide un ticket pe serverul nostru de Discord.",
		ExcludeAltAccounts = false 
	}

	local success, err = pcall(function()
		return Players:BanAsync(banConfig)
	end)

	if not success then

	
		player:Kick("\n[VHL GUARD]\nAcces restricționat permanent!\nMotiv: Animation\n\nPentru apel, deschide un ticket pe serverul nostru de Discord.")
	end
end

local function checkAnimations(player)
	local char = player.Character
	if not char then return end
	local humanoid = char:FindFirstChildWhichIsA("Humanoid")
	if not humanoid then return end

	for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
		if track.Animation then
			for _, bannedId in ipairs(bannedAnimations) do
				if track.Animation.AnimationId == bannedId then
					banPlayer(player)
					return
				end
			end
		end
	end
end

RunService.Heartbeat:Connect(function()
	for _, player in ipairs(Players:GetPlayers()) do
		pcall(checkAnimations, player)
	end
end)
