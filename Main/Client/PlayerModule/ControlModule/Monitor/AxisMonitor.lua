Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Axis Monitor")

Console.log("Loading dependencies...")

ContextActionService = game:GetService("ContextActionService")
Monitor = require(script.Parent)
Method = require(script.Parent.Parent:WaitForChild("ControlScheme"):WaitForChild("Control"):WaitForChild("Method"))

Console.log("Loaded.")
Console.log("Assembling script...")
Console.log("Initializing globals...")

-- Direction enum
direction = {
	["Up"] = 1,
	["Down"] = 2
}

-- Direction floats
directional_float = {
	[direction.Up] = 1.0,
	[direction.Down] = -1.0
}

function update(object, inputState, inputObject, id)
	local action = object.actions[id]
	if inputObject.UserInputType == action.Type then
		local axis = 0.0
		if action.Monitor ~= nil then
			local monitor = action.Monitor
			if monitor:GetValue() then
				axis = directional_float[direction[monitor.Control.Name]] or axis
			end
		else
			axis = inputObject.Position.Z
			if action.Offset ~= nil then
				axis = axis - action.Offset
			end
		end
		action.Axis = axis
		axis = 0.0
		local piecewiseAxis = 0.0
		local pieces = 0
		for _, action in ipairs(object.actions) do
			if action.Monitor ~= nil then
				piecewiseAxis = piecewiseAxis + action.Axis
				pieces = pieces + 1
			else
				axis = axis + action.Axis
			end
		end
		axis = axis + (piecewiseAxis.Unit * (pieces / 2))
		object.value = axis
		object.updated = true
	end
	return Enum.ContextActionResult.Pass
end

Console.log("Initialized.")
Console.log("Initializing locals...")

local AxisMonitor = Monitor.new()
AxisMonitor.__index = AxisMonitor

function AxisMonitor.new()
	local self = setmetatable({}, AxisMonitor)
	self.actions = {}
	self.value = 0.0
	return self
end

function AxisMonitor:BindControl()
	if not self.bound and self.Control ~= nil and self.Control.Method == Method.Axis then
		for _, input in ipairs(self.Control.Inputs) do
			if input.Scheme ~= nil then
				local schemeName = self.SchemeName .. ":" .. self.Control.Name
				for _, control in pairs(input.Scheme.ControlSet) do
					local monitor = Monitor.spawn(control)
					monitor.SchemeName = schemeName
					for _, subInput in iparis(control.Inputs) do
						local name = self.inputName(schemeName, control.Name, tostring(subInput.Type), tostring(subInput.Code), "Axis")
						table.insert(self.actions, {["Name"] = name, ["Axis"] = 0.0, ["Type"] = subInput.Type, ["Offset"] = subInput.Offset, ["Monitor"] = monitor})
						ContextActionService:BindAction(name, function(actionName, inputState, inputObject) update(self, inputState, inputObject, #self.actions) end, false, subInput.Code)
					end
					monitor:BindControl()
				end 
			else
				local name = self.inputName(self.SchemeName, self.Control.Name, tostring(input.Type), tostring(input.Code), "Axis")
				table.insert(self.actions, {["Name"] = name, ["Axis"] = 0.0, ["Type"] = input.Type, ["Offset"] = input.Offset})
				ContextActionService:BindAction(name, function(actionName, inputState, inputObject) update(self, inputState, inputObject, #self.actions) end, false, input.Code)
			end
		end
		self.bound = true
	end
end

function AxisMonitor:UnbindControl()
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

return AxisMonitor.new()
