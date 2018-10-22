Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Binary Monitor")

Console.log("Loading dependencies...")

ContextActionService = game:GetService("ContextActionService")
Monitor = require(script.Parent)
Method = require(script.Parent.Parent:WaitForChild("ControlScheme"):WaitForChild("Control"):WaitForChild("Method"))

Console.log("Loaded.")
Console.log("Assembling script...")
Console.log("Initializing globals...")

function update(object, inputState, inputObject, id)
	if inputObject.UserInputType == object.actions[id].Type then
		if inputState == Enum.UserInputState.Begin then
			object.actions[id].Active = true
		elseif inputState == Enum.UserInputState.End or inputState == Enum.UserInputState.Cancel then
			object.actions[id].Active = false
		end
		object.value = false
		for _, action in ipairs(object.actions) do
			if action.Active then
				object.value = true
				break
			end
		end
		object.updated = true
	end
	return Enum.ContextActionResult.Pass
end

Console.log("Initialized.")
Console.log("Initializing locals...")

local BinaryMonitor = Monitor.new()
BinaryMonitor.__index = BinaryMonitor

--- The constructor for a binary monitor.
-- @return the new binary monitor
function BinaryMonitor.new()
	local self = setmetatable({}, BinaryMonitor)
	self.actions = {}
	self.value = false
	return self
end

function BinaryMonitor:BindControl()
	if not self.bound and self.Control ~= nil and self.Control.Method == Method.Binary then
		for _, input in ipairs(self.Control.Inputs) do
			local name = self.inputName(self.SchemeName, self.Control.Name, tostring(input.Type), tostring(input.Code), "Binary")
			table.insert(self.actions, {["Name"] = name, ["Active"] = false, ["Type"] = input.Type})
			ContextActionService:BindAction(name, function(actionName, inputState, inputObject) update(self, inputState, inputObject, #self.actions) end, false, input.Code)
		end
		self.bound = true
	end
end

function BinaryMonitor:UnbindControl()
	if self.bound then
		for _, action in ipairs(self.actions) do
			ContextActionService:UnbindAction(action.Name)
		end
		self.actions = {}
		self.bound = false
		self.value = false
	end
end

Console.log("Initialized.")
Console.log("Assembled.")

return BinaryMonitor.new()
