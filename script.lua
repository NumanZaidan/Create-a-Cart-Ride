
-- Instances:

local e = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local Titile = Instance.new("TextLabel")
local UICorner_2 = Instance.new("UICorner")
local Status = Instance.new("TextLabel")

--Properties:

e.Name = "Magnets"
e.Parent = game:WaitForChild("CoreGui")
e.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = e
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.035373386, 0, 0.443076909, 0)
Main.Size = UDim2.new(0, 273, 0, 101)

UICorner.CornerRadius = UDim.new(0.100000001, 0)
UICorner.Parent = Main

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(52, 52, 52)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(66, 66, 66))}
UIGradient.Parent = Main

Titile.Name = "Titile"
Titile.Parent = Main
Titile.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Titile.BorderColor3 = Color3.fromRGB(0, 0, 0)
Titile.BorderSizePixel = 0
Titile.Size = UDim2.new(0, 273, 0, 34)
Titile.Font = Enum.Font.LuckiestGuy
Titile.LineHeight = 0.000
Titile.Text = "Magnet"
Titile.TextColor3 = Color3.fromRGB(255, 255, 255)
Titile.TextScaled = true
Titile.TextSize = 14.000
Titile.TextWrapped = true

UICorner_2.CornerRadius = UDim.new(0.100000001, 0)
UICorner_2.Parent = Titile

Status.Name = "Status"
Status.Parent = Main
Status.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
Status.BorderColor3 = Color3.fromRGB(0, 0, 0)
Status.BorderSizePixel = 0
Status.Position = UDim2.new(0.0276823491, 0, 0.413612604, 0)
Status.Size = UDim2.new(0, 258, 0, 50)
Status.Font = Enum.Font.LuckiestGuy
Status.Text = "Status Magnet: N/A"
Status.TextColor3 = Color3.fromRGB(255, 255, 255)
Status.TextScaled = true
Status.TextSize = 14.000
Status.TextWrapped = true

--! THIS SCRIPT GIVES YOU MAGNITIZED WHEELS FOR THE TRACKS
--! THIS SCRIPT ALSO REMOVES ALL KILL PARTS

--! WHILE HOLDING THE "KeyToReleaseRailMagnet" KEY, THE YFORCE WILL BE 0

YForce = YForce or -12000;
KeyToReleaseRailMagnet = KeyToReleaseRailMagnet or Enum.KeyCode.D;

local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local Player = Players.LocalPlayer;

local HoldingKey = false;

local function GetMyCart()
	for Int, Cart in pairs(workspace.ActiveCarts:GetChildren()) do
		if Cart.Owner.Value == Player then
			return Cart;
		end;
	end;
	return nil;
end;

UserInputService.InputBegan:Connect(function(Input, GameProcessed)
	if GameProcessed == false and Input.KeyCode == KeyToReleaseRailMagnet then
		HoldingKey = true;
		if GetMyCart() ~= nil and GetMyCart():FindFirstChild("Base") ~= nil then
			if GetMyCart().Base:FindFirstChild("BodyThrust") ~= nil then
				Status.Text = "Status Magnet: false"
				GetMyCart().Base:FindFirstChild("BodyThrust"):Remove();
			end;
		end;
	end;
end);
UserInputService.InputEnded:Connect(function(Input, GameProcessed)
	if GameProcessed == false and Input.KeyCode == KeyToReleaseRailMagnet then
		HoldingKey = false;
		if GetMyCart() ~= nil and GetMyCart():FindFirstChild("Base") ~= nil then
			if GetMyCart().Base:FindFirstChild("BodyThrust") == nil then
				Status.Text = "Status Magnet: true"
				Instance.new("BodyThrust", GetMyCart().Base).Force = Vector3.new(0, YForce, 0);
			end;
		end;
	end;
end);

coroutine.resume(coroutine.create(function()
	while wait(1) do
		if GetMyCart() ~= nil and GetMyCart():FindFirstChild("Wheels") ~= nil then
			for Int, Wheel in pairs(GetMyCart().Wheels:GetChildren()) do
				Wheel.Transparency = 0.2;
			end;
			if HoldingKey == false and GetMyCart().Base:FindFirstChild("BodyThrust") == nil then
				Instance.new("BodyThrust", GetMyCart().Base).Force = Vector3.new(0, YForce, 0);
				Status.Text = "Status Magnet: true"
			end;
		end;
		for Int, Value in pairs(workspace.CartRideWorkspace.Objects:GetChildren()) do
			if Value.Name == "DamagePart" then
				Value:Remove();
			end;
		end;
	end;
end));
