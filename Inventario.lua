--| ( Serviços ) |--
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--| ( GUI ) |--
local screenGui = playerGui:FindFirstChild("MochilaGui") or Instance.new("ScreenGui", playerGui)
screenGui.Name = "MochilaGui"
--[[ if not screenGui then
	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MochilaGui"
	screenGui.Parent = playerGui
	screenGui.ResetOnSpawn = false
end ]]--

--| ( Interface ) |--
local inventario = Instance.new("Frame")
inventario.Name = "inventario"
inventario.Position = UDim2.new(0.350962, 0, 0.864353, 0)
inventario.Size = UDim2.new(0.297476, 0, 0.107256, 0)
inventario.BackgroundColor3 = Color3.new(0, 0, 0)
inventario.BackgroundTransparency = 0.6000000238418579
--[[ inventario.BorderSizePixel = 0
inventario.BorderColor3 = Color3.new(0, 0, 0)
inventario.Transparency = 0.6000000238418579
inventario.Visible = true ]]--
inventario.Parent = screenGui 

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 9)
UIListLayout.FillDirection = Enum. FillDirection.Horizontal
UIListLayout.Parent = inventario

local function criarSlot(num)
	local slot = Instance.new("ImageLabel")
	slot.Name = "Slot" .. num
	slot.Size = UDim2.new(0.112856, 0, 0.877168, 0)
	slot.BackgroundColor3 = Color3.new(0, 0, 0)
	slot.BackgroundTransparency = 0.65
	slot.Parent = inventario
	
	local txtNum = Instance.new("TextLabel")
	txtNum.Name = "NumeroIndicador"
	txtNum.Text = tostring(num)
	txtNum.Size = UDim2.new(0.251194, 0, 0.386452, 0)
	txtNum.Position = UDim2.new(0.367129, 0, -0.173903, 0)
	txtNum.BackgroundTransparency = 1
	txtNum.TextColor3 = Color3.new(1, 1, 1)
	txtNum.Font = Enum.Font.ArialBold
	txtNum.TextScaled = true
	txtNum.Parent = slot
	
	local txtQtd = Instance.new("TextLabel")
	txtQtd.Name = "QtdLabel"
	txtQtd.Text = ""
	txtQtd.Size = UDim2.new(0.4, 0, 0.4, 0)
	txtQtd.Position = UDim2.new(0.6, 0, 0.6, 0)
	txtQtd.BackgroundTransparency = 1
	txtQtd.TextColor3 = Color3.new(1, 1, 0)
	txtQtd.TextXAlignment = Enum.TextXAlignment.Right
	txtQtd.TextScaled = true
	txtQtd.Parent = slot
	
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Color = Color3.new(0.44, 0.44, 0.44)
	stroke.Parent = slot
	
	return slot
end

local i1 = criarSlot(1)
local i2 = criarSlot(2)
local i3 = criarSlot(3)
local i4 = criarSlot(4)
local i5 = criarSlot(5)
local i6 = criarSlot(6)
local i7 = criarSlot(7)
local i8 = criarSlot(8)

--| ( Sistema de Slots ) |--
local listaDeSlot = {i1, i2, i3, i4, i5, i6, i7, i8}

local function adicionarItem(nomeDoItem, imagemID)
	for _, slot in ipairs(listaDeSlot) do
		if slot.Image == imagemID then
			local qtdLabel = slot:FindFirstChild("QtdLabel")
			local valorAtual = tonumber(qtdLabel.Text:match("%d+")) or 1
			qtdLabel.Text = "x" .. (valorAtual + 1)
			print("não vou colocar emoji por que vai travar o meu pc mas item adicionado que se chama " .. nomeDoItem)
			return
		end
	end
	
	for _, slot in ipairs(listaDeSlot) do
		if slot.Image == "" or slot.Image == "rbxassetid://0" then
			slot.Image = imagemID
			slot:SetAttribute("ItemNome", nomeDoItem)
			slot.QtdLabel.Text = "x1"
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
evento.OnClientEvent:Connect(adicionarItem)
