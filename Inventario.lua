--| ( Serviços ) |--
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--| ( GUI ) |--
local screenGui = playerGui:FindFirstChild("MochilaGui")
if not screenGui then
	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MochilaGui"
	screenGui.Parent = playerGui
	screenGui.ResetOnSpawn = false
end

--| ( Interface ) |--
local inventario = Instance.new("Frame")
inventario.Name = "inventario"
inventario.Position = UDim2.new(0.350962, 0, 0.864353, 0)
inventario.Size = UDim2.new(0.297476, 0, 0.107256, 0)
inventario.BackgroundColor3 = Color3.new(0, 0, 0)
inventario.BackgroundTransparency = 0.6000000238418579
inventario.BorderSizePixel = 0
inventario.BorderColor3 = Color3.new(0, 0, 0)
inventario.Transparency = 0.6000000238418579
inventario.Visible = true
inventario.Parent = screenGui

local i1 = Instance.new("ImageButton")
i1.Name = "1"
i1.Position = UDim2.new(6.10352e-08, 0, 0, 0)
i1.Size = UDim2.new(0.112856, 0, 0.877168, 0)
i1.BackgroundColor3 = Color3.new(0, 0, 0)
i1.BackgroundTransparency = 0.6499999761581421
i1.BorderSizePixel = 0
i1.BorderColor3 = Color3.new(0, 0, 0)
i1.Transparency = 0.6499999761581421
i1.Parent = inventario

local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint.Parent = i1

local UIStroke = Instance.new("UIStroke")
UIStroke.Name = "UIStroke"
UIStroke.Color = Color3.new(0.443137, 0.443137, 0.443137)
UIStroke.Thickness = 3
UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = i1

local text = Instance.new("TextLabel")
text.Name = "text"
text.Position = UDim2.new(0.367129, 0, -0.173903, 0)
text.Size = UDim2.new(0.251194, 0, 0.386452, 0)
text.BackgroundColor3 = Color3.new(1, 1, 1)
text.BackgroundTransparency = 1
text.BorderSizePixel = 0
text.BorderColor3 = Color3.new(0, 0, 0)
text.Transparency = 1
text.Text = "1"
text.TextColor3 = Color3.new(1, 1, 1)
text.TextSize = 14
text.FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
text.TextScaled = true
text.TextWrapped = true
text.Parent = i1

local UIStroke2 = Instance.new("UIStroke")
UIStroke2.Name = "UIStroke"
UIStroke2.Color = Color3.new(0.443137, 0.443137, 0.443137)
UIStroke2.Thickness = 2
UIStroke2.Parent = text

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Name = "UIListLayout"
UIListLayout.Padding = UDim.new(0, 9)
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = inventario

local i2 = Instance.new("ImageButton")
i2.Name = "2"
i2.Position = UDim2.new(0.145884, 0, 0, 0)
i2.Size = UDim2.new(0.112856, 0, 0.877168, 0)
i2.BackgroundColor3 = Color3.new(0, 0, 0)
i2.BackgroundTransparency = 0.6499999761581421
i2.BorderSizePixel = 0
i2.BorderColor3 = Color3.new(0, 0, 0)
i2.Transparency = 0.6499999761581421
i2.Parent = inventario

local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint2.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint2.Parent = i2

local UIStroke3 = Instance.new("UIStroke")
UIStroke3.Name = "UIStroke"
UIStroke3.Color = Color3.new(0.443137, 0.443137, 0.443137)
UIStroke3.Thickness = 3
UIStroke3.LineJoinMode = Enum.LineJoinMode.Miter
UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke3.Parent = i2

local text2 = Instance.new("TextLabel")
text2.Name = "text"
text2.Position = UDim2.new(0.367129, 0, -0.173903, 0)
text2.Size = UDim2.new(0.251194, 0, 0.386452, 0)
text2.BackgroundColor3 = Color3.new(1, 1, 1)
text2.BackgroundTransparency = 1
text2.BorderSizePixel = 0
text2.BorderColor3 = Color3.new(0, 0, 0)
text2.Transparency = 1
text2.Text = "2"
text2.TextColor3 = Color3.new(1, 1, 1)
text2.TextSize = 14
text2.FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
text2.TextScaled = true
text2.TextWrapped = true
text2.Parent = i2

local UIStroke4 = Instance.new("UIStroke")
UIStroke4.Name = "UIStroke"
UIStroke4.Color = Color3.new(0.443137, 0.443137, 0.443137)
UIStroke4.Thickness = 2
UIStroke4.Parent = text2

local UIPadding = Instance.new("UIPadding")
UIPadding.Name = "UIPadding"
UIPadding.PaddingTop = UDim.new(0, 9)
UIPadding.PaddingLeft = UDim.new(0, 9)
UIPadding.Parent = inventario

local i3 = Instance.new("ImageButton")
i3.Name = "3"
i3.Position = UDim2.new(0.291769, 0, 0, 0)
i3.Size = UDim2.new(0.112856, 0, 0.877168, 0)
i3.BackgroundColor3 = Color3.new(0, 0, 0)
i3.BackgroundTransparency = 0.6499999761581421
i3.BorderSizePixel = 0
i3.BorderColor3 = Color3.new(0, 0, 0)
i3.Transparency = 0.6499999761581421
i3.Parent = inventario

local UIAspectRatioConstraint3 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint3.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint3.Parent = i3

local UIStroke5 = Instance.new("UIStroke")
UIStroke5.Name = "UIStroke"
UIStroke5.Color = Color3.new(0.443137, 0.443137, 0.443137)
UIStroke5.Thickness = 3
UIStroke5.LineJoinMode = Enum.LineJoinMode.Miter
UIStroke5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke5.Parent = i3

local text3 = Instance.new("TextLabel")
text3.Name = "text"
text3.Position = UDim2.new(0.367129, 0, -0.173903, 0)
text3.Size = UDim2.new(0.251194, 0, 0.386452, 0)
text3.BackgroundColor3 = Color3.new(1, 1, 1)
text3.BackgroundTransparency = 1
text3.BorderSizePixel = 0
text3.BorderColor3 = Color3.new(0, 0, 0)
text3.Transparency = 1
text3.Text = "3"
text3.TextColor3 = Color3.new(1, 1, 1)
text3.TextSize = 14
text3.FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
text3.TextScaled = true
text3.TextWrapped = true
text3.Parent = i3

local UIStroke6 = Instance.new("UIStroke")
UIStroke6.Name = "UIStroke"
UIStroke6.Color = Color3.new(0.443137, 0.443137, 0.443137)
UIStroke6.Thickness = 2
UIStroke6.Parent = text3

local i4 = Instance.new("ImageButton")
i4.Name = "4"
i4.Position = UDim2.new(0.437653, 0, 0, 0)
i4.Size = UDim2.new(0.112856, 0, 0.877168, 0)
i4.BackgroundColor3 = Color3.new(0, 0, 0)
i4.BackgroundTransparency = 0.6499999761581421
i4.BorderSizePixel = 0
i4.BorderColor3 = Color3.new(0, 0, 0)
i4.Transparency = 0.6499999761581421
i4.Parent = inventario

local UIAspectRatioConstraint4 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint4.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint4.Parent = i4

local UIStroke7 = Instance.new("UIStroke")
UIStroke7.Name = "UIStroke"
UIStroke7.Color = Color3.new(0.443137, 0.443137, 0.443137)
UIStroke7.Thickness = 3
UIStroke7.LineJoinMode = Enum.LineJoinMode.Miter
UIStroke7.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke7.Parent = i4

local text4 = Instance.new("TextLabel")
text4.Name = "text"
text4.Position = UDim2.new(0.367129, 0, -0.173903, 0)
text4.Size = UDim2.new(0.251194, 0, 0.386452, 0)
text4.BackgroundColor3 = Color3.new(1, 1, 1)
text4.BackgroundTransparency = 1
text4.BorderSizePixel = 0
text4.BorderColor3 = Color3.new(0, 0, 0)
text4.Transparency = 1
text4.Text = "4"
text4.TextColor3 = Color3.new(1, 1, 1)
text4.TextSize = 14
text4.FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
text4.TextScaled = true
text4.TextWrapped = true
text4.Parent = i4

local UIStroke8 = Instance.new("UIStroke")
UIStroke8.Name = "UIStroke"
UIStroke8.Color = Color3.new(0.443137, 0.443137, 0.443137)
UIStroke8.Thickness = 2
UIStroke8.Parent = text4

local i5 = Instance.new("ImageButton")
i5.Name = "5"
i5.Position = UDim2.new(0.583537, 0, 0, 0)
i5.Size = UDim2.new(0.112856, 0, 0.877168, 0)
i5.BackgroundColor3 = Color3.new(0, 0, 0)
i5.BackgroundTransparency = 0.6499999761581421
i5.BorderSizePixel = 0
i5.BorderColor3 = Color3.new(0, 0, 0)
i5.Transparency = 0.6499999761581421
i5.Parent = inventario

local UIAspectRatioConstraint5 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint5.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint5.Parent = i5

local UIStroke9 = Instance.new("UIStroke")
UIStroke9.Name = "UIStroke"
UIStroke9.Color = Color3.new(0.443137, 0.443137, 0.443137)
UIStroke9.Thickness = 3
UIStroke9.LineJoinMode = Enum.LineJoinMode.Miter
UIStroke9.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke9.Parent = i5

local text5 = Instance.new("TextLabel")
text5.Name = "text"
text5.Position = UDim2.new(0.367129, 0, -0.173903, 0)
text5.Size = UDim2.new(0.251194, 0, 0.386452, 0)
text5.BackgroundColor3 = Color3.new(1, 1, 1)
text5.BackgroundTransparency = 1
text5.BorderSizePixel = 0
text5.BorderColor3 = Color3.new(0, 0, 0)
text5.Transparency = 1
text5.Text = "5"
text5.TextColor3 = Color3.new(1, 1, 1)
text5.TextSize = 14
text5.FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
text5.TextScaled = true
text5.TextWrapped = true
text5.Parent = i5

local UIStroke10 = Instance.new("UIStroke")
UIStroke10.Name = "UIStroke"
UIStroke10.Color = Color3.new(0.443137, 0.443137, 0.443137)
UIStroke10.Thickness = 2
UIStroke10.Parent = text5

local i6 = Instance.new("ImageButton")
i6.Name = "6"
i6.Position = UDim2.new(0.729422, 0, 0, 0)
i6.Size = UDim2.new(0.112856, 0, 0.877168, 0)
i6.BackgroundColor3 = Color3.new(0, 0, 0)
i6.BackgroundTransparency = 0.6499999761581421
i6.BorderSizePixel = 0
i6.BorderColor3 = Color3.new(0, 0, 0)
i6.Transparency = 0.6499999761581421
i6.Parent = inventario

local UIAspectRatioConstraint6 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint6.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint6.Parent = i6

local UIStroke11 = Instance.new("UIStroke")
UIStroke11.Name = "UIStroke"
UIStroke11.Color = Color3.new(0.443137, 0.443137, 0.443137)
UIStroke11.Thickness = 3
UIStroke11.LineJoinMode = Enum.LineJoinMode.Miter
UIStroke11.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke11.Parent = i6

local text6 = Instance.new("TextLabel")
text6.Name = "text"
text6.Position = UDim2.new(0.367129, 0, -0.173903, 0)
text6.Size = UDim2.new(0.251194, 0, 0.386452, 0)
text6.BackgroundColor3 = Color3.new(1, 1, 1)
text6.BackgroundTransparency = 1
text6.BorderSizePixel = 0
text6.BorderColor3 = Color3.new(0, 0, 0)
text6.Transparency = 1
text6.Text = "6"
text6.TextColor3 = Color3.new(1, 1, 1)
text6.TextSize = 14
text6.FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
text6.TextScaled = true
text6.TextWrapped = true
text6.Parent = i6

local UIStroke12 = Instance.new("UIStroke")
UIStroke12.Name = "UIStroke"
UIStroke12.Color = Color3.new(0.443137, 0.443137, 0.443137)
UIStroke12.Thickness = 2
UIStroke12.Parent = text6

local i7 = Instance.new("ImageButton")
i7.Name = "7"
i7.Position = UDim2.new(0.875306, 0, 0, 0)
i7.Size = UDim2.new(0.112856, 0, 0.877168, 0)
i7.BackgroundColor3 = Color3.new(0, 0, 0)
i7.BackgroundTransparency = 0.6499999761581421
i7.BorderSizePixel = 0
i7.BorderColor3 = Color3.new(0, 0, 0)
i7.Transparency = 0.6499999761581421
i7.Parent = inventario

local UIAspectRatioConstraint7 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint7.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint7.Parent = i7

local UIStroke13 = Instance.new("UIStroke")
UIStroke13.Name = "UIStroke"
UIStroke13.Color = Color3.new(0.443137, 0.443137, 0.443137)
UIStroke13.Thickness = 3
UIStroke13.LineJoinMode = Enum.LineJoinMode.Miter
UIStroke13.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke13.Parent = i7

local text7 = Instance.new("TextLabel")
text7.Name = "text"
text7.Position = UDim2.new(0.367129, 0, -0.173903, 0)
text7.Size = UDim2.new(0.251194, 0, 0.386452, 0)
text7.BackgroundColor3 = Color3.new(1, 1, 1)
text7.BackgroundTransparency = 1
text7.BorderSizePixel = 0
text7.BorderColor3 = Color3.new(0, 0, 0)
text7.Transparency = 1
text7.Text = "7"
text7.TextColor3 = Color3.new(1, 1, 1)
text7.TextSize = 14
text7.FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
text7.TextScaled = true
text7.TextWrapped = true
text7.Parent = i7

local UIStroke14 = Instance.new("UIStroke")
UIStroke14.Name = "UIStroke"
UIStroke14.Color = Color3.new(0.443137, 0.443137, 0.443137)
UIStroke14.Thickness = 2
UIStroke14.Parent = text7

local i8 = Instance.new("ImageButton")
i8.Name = "8"
i8.Position = UDim2.new(1.02119, 0, 0, 0)
i8.Size = UDim2.new(0.112856, 0, 0.877168, 0)
i8.BackgroundColor3 = Color3.new(0, 0, 0)
i8.BackgroundTransparency = 0.6499999761581421
i8.BorderSizePixel = 0
i8.BorderColor3 = Color3.new(0, 0, 0)
i8.Transparency = 0.6499999761581421
i8.Parent = inventario

local UIAspectRatioConstraint8 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint8.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint8.Parent = i8

local UIStroke15 = Instance.new("UIStroke")
UIStroke15.Name = "UIStroke"
UIStroke15.Color = Color3.new(0.443137, 0.443137, 0.443137)
UIStroke15.Thickness = 3
UIStroke15.LineJoinMode = Enum.LineJoinMode.Miter
UIStroke15.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke15.Parent = i8

local text8 = Instance.new("TextLabel")
text8.Name = "text"
text8.Position = UDim2.new(0.367129, 0, -0.173903, 0)
text8.Size = UDim2.new(0.251194, 0, 0.386452, 0)
text8.BackgroundColor3 = Color3.new(1, 1, 1)
text8.BackgroundTransparency = 1
text8.BorderSizePixel = 0
text8.BorderColor3 = Color3.new(0, 0, 0)
text8.Transparency = 1
text8.Text = "8"
text8.TextColor3 = Color3.new(1, 1, 1)
text8.TextSize = 14
text8.FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
text8.TextScaled = true
text8.TextWrapped = true
text8.Parent = i8

local UIStroke16 = Instance.new("UIStroke")
UIStroke16.Name = "UIStroke"
UIStroke16.Color = Color3.new(0.443137, 0.443137, 0.443137)
UIStroke16.Thickness = 2
UIStroke16.Parent = text8

--| ( Sistema de Slots ) |--
local listaDeSlot = {i1, i2, i3, i4, i5, i6, i7, i8}

local function adicionarItem(nomeDoItem, imagemID)
	for _, slot in ipairs(listaDeSlot) do
		if slot.Image == "" or slot.Image == "rbxassetid://0" then
			slot.Image = imagemID
			print("não vou colocar emoji por que vai travar o meu pc mas item adicionado que se chama " .. nomeDoItem)
			return
		end
	end
end

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.E then
		inventario.Visible = not inventario.Visible
		print("num vo coloca emoji ):<, o teclado apareceu aqui ta o codigo ", inventario.Visible)
	end
end)

local evento = ReplicatedStorage:FindFirstChild("EventoColetarItem")
if evento then
	evento.OnClientEvent:Connect(adicionarItem)
	print("RAHHHH EMOJI NAUM. mas foi conectado o sistema do item bele?")
else
	warn("opa algo deu errado ( ! ) nos coiso de evento na linha 442 ou menor")
end
