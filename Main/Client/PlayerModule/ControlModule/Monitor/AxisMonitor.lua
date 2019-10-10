Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Axis Monitor")

Console.log("Loading dependencies...")

Monitor = require(script.Parent)
BinaryMonitor = require(script.Parent:WaitForChild("BinaryMonitor"))
InputType = require(script.Parent.Parent:WaitForChild("InputType"))
Direction = require(script.Parent.Parent:WaitForChild("AxisDirection"))

Console.log("Loaded.")
Console.log("Assembling script...")
Console.log("Initializing globals...")

-- Direction floats
directional_value = {
	[Direction.Up] = 1.0,
	[Direction.Down] = -1.0
}

Console.log("Initialized.")
Console.log("Initializing locals...")

local AxisMonitor = Monitor.new()
AxisMonitor.__index = AxisMonitor

function AxisMonitor.new()
	local self = setmetatable({}, AxisMonitor)
	return self
end

function AxisMonitor:transformValue(input, value)
	local type = input.Type
	local offset = (input.Offset or 0)
	if type == InputType.None or type == InputType.Keyboard or type == InputType.MouseButton or type == InputType.GamepadButton then
		return ((value and 1) or 0) + offset, 1
	elseif type == InputType.MouseMovement or type == InputType.GamepadDirection then
		if input.Code == Enum.KeyCode.ButtonL2 or input.Code == Enum.KeyCode.ButtonR2 then
			return value.Z + offset, 1
		else
			return value.Y + offset, 1
		end
	elseif type = InputType.Scheme then
		local schemeValue = 0
		for id, enum in pairs(Direction) do
			local monitor = input.Code[id]
			schemeValue = schemeValue + ((monitor:Update() and directional_value[enum]) or 0)
		end
		return schemeValue + offset, 1
	end
	return 0, 1
end

function AxisMonitor:addValue(original, new)
	return original + new
end

function AxisMonitor:scaleValue(value, scale)
	return value / scale
end

function AxisMonitor:nullValue()
	return 0
end

function AxisMonitor:processEntry(entry)
	if entry.Type == InputType.Scheme then
		local scheme = entry.Code
		entry.Code = {}
		for id, _ in pairs(Direction) do
			if scheme.ControlSet[id] ~= nil then
				local monitor = BinaryMonitor.new()
				monitor:Bind(scheme.ControlSet[id])
				entry.Code[id] = monitor
			end
		end
	end
end

function AxisMonitor:clean()
end

Console.log("Initialized.")
Console.log("Assembled.")

return AxisMonitor.new()
