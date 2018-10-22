Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Vector Monitor")

Console.log("Loading dependencies...")

ContextActionService = game:GetService("ContextActionService")
Workspace = game:GetService("Workspace")
Monitor = require(script.Parent)
BinaryMonitor = require(script.Parent:WaitForChild("BinaryMonitor"))
Method = require(script.Parent.Parent:WaitForChild("ControlScheme"):WaitForChild("Control"):WaitForChild("Method"))

Console.log("Loaded.")
Console.log("Assembling script...")
Console.log("Initializing globals...")

-- Direction enum
direction = {
	["Up"] = 1,
	["Down"] = 2,
	["Left"] = 3,
	["Right"] = 4
}

-- Direction vectors
directional_vector = {
	[direction.Up] = Vector3.new(0, 0, 1),
	[direction.Down] = Vector3.new(0, 0, -1),
	[direction.Left] = Vector3.new(-1, 0, 0),
	[direction.Right] = Vector3.new(1, 0, 0)
}

function update(object, inputState, inputObject, id)
	local action = object.actions[id]
	if inputObject.UserInputType == action.Type then
		local vector = Vector3.new(0, 0, 0)
		if action.Monitor ~= nil then
			local monitor = action.Monitor
			if monitor:GetValue() then
				vector = directional_vector[direction[monitor.Control.Name]] or vector
			end
		else
			vector = inputObject.Position
			if action.Offset ~= nil then
				local viewport = Workspace.CurrentCamera.ViewportSize
				local offsetVector = Vector3.new(action.Offset.X.Offset + viewport.X * action.Offset.X.Scale, 0, action.Offset.Y.Offset + viewport.Y * action.Offset.Y.Scale)
				vector = vector + offsetVector
			end
		end
		action.Vector = vector
		vector = Vector3.new(0, 0, 0)
		local piecewiseVector = Vector3.new(0, 0, 0)
		local pieces = 0
		for _, action in ipairs(object.actions) do
			if action.Monitor ~= nil then
				piecewiseVector = piecewiseVector + action.Vector
				pieces = pieces + 1
			else
				vector = vector + action.Vector
			end
		end
		vector = vector + (piecewiseVector.Unit * (pieces / 4))
		object.value = vector.Unit
		object.updated = true
	end
	return Enum.ContextActionResult.Pass
end

Console.log("Initialized.")
Console.log("Initializing locals...")

local VectorMonitor = Monitor.new()
VectorMonitor.__index = VectorMonitor

function VectorMonitor.new()
	local self = setmetatable({}, VectorMonitor)
	self.actions = {}
	self.value = Vector3.new(0, 0, 0)
	return self
end

function VectorMonitor:BindControl()
	if not self.bound and self.Control ~= nil and self.Control.Method == Method.Vector then
		for _, input in ipairs(self.Control.Inputs) do
			if input.Scheme ~= nil then
				local schemeName = self.SchemeName .. ":" .. self.Control.Name
				for _, control in pairs(input.Scheme.ControlSet) do
					local monitor = BinaryMonitor.new()
					monitor.Control = control
					monitor.SchemeName = schemeName
					for _, subInput in ipairs(control.Inputs) do
						local name = self.inputName(schemeName, control.Name, tostring(subInput.Type), tostring(subInput.Code), "Vector")
						table.insert(self.actions, {["Name"] = name, ["Vector"] = Vector3.new(0, 0, 0), ["Type"] = subInput.Type, ["Offset"] = subInput.Offset, ["Monitor"] = monitor})
						ContextActionService:BindAction(name, function(actionName, inputState, inputObject) update(self, inputState, inputObject, #self.actions) end, false, subInput.Code)
					end
					monitor:BindControl()
				end 
			else
				local name = self.inputName(self.SchemeName, self.Control.Name, tostring(input.Type), tostring(input.Code), "Vector")
				table.insert(self.actions, {["Name"] = name, ["Vector"] = Vector3.new(0, 0, 0), ["Type"] = input.Type, ["Offset"] = input.Offset})
				ContextActionService:BindAction(name, function(actionName, inputState, inputObject) update(self, inputState, inputObject, #self.actions) end, false, input.Code)
			end
		end
		self.bound = true
	end
end

function VectorMonitor:UnbindControl()
	if self.bound then
		for _, action in ipairs(self.actions) do
			ContextActionService:UnbindAction(action.Name)
			if action.Monitor ~= nil then
				action.Monitor:UnbindControl()
			end
		end
		self.actions = {}
		self.bound = false
		self.value = Vector3.new(0, 0, 0)
	end
end

Console.log("Initialized.")
Console.log("Assembled.")

return VectorMonitor.new()
