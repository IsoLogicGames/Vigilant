Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Vector Monitor")

Console.log("Loading dependencies...")

Monitor = require(script.Parent)
AxisMonitor = require(script.Parent:WaitForChild("AxisMonitor"))
InputType = require(script.Parent.Parent:WaitForChild("InputType"))
Direction = require(script.Parent.Parent:WaitForChild("VectorDirection"))

Console.log("Loaded.")
Console.log("Assembling script...")
Console.log("Initializing globals...")

-- Direction vectors
directional_value = {
	[Direction.Vertical] = Vector2.new(0, 1),
	[Direction.Horizontal] = Vector2.new(1, 0)
}

Console.log("Initialized.")
Console.log("Initializing locals...")

local VectorMonitor = Monitor.new()
VectorMonitor.__index = VectorMonitor

function VectorMonitor.new()
	local self = setmetatable({}, VectorMonitor)
	return self
end

function VectorMonitor:transformValue(input, value)
	local type = input.Type
	local offset = (input.Offset or Vector2.new(0, 0)))
	if type == InputType.None or type == InputType.Keyboard or type == InputType.MouseButton or type == InputType.GamepadButton then
		return ((value and Vector2.new(0, 1)) or Vector2.new(0, 0)) + offset, 1
	elseif type == InputType.MouseMovement or type == InputType.GamepadDirection then
		if input.Code == Enum.KeyCode.ButtonL2 or input.Code == Enum.KeyCode.ButtonR2 then
			return Vector2.new(0, value.Z) + offset, 1
		else
			return Vector2.new(value.X, value.Y) + offset, 1
		end
	elseif type = InputType.Scheme then
		local schemeValue = Vector2.new(0, 0)
		for id, enum in pairs(Direction) do
			local monitor = input.Code[id]
			schemeValue = schemeValue + (directional_value[enum] * monitor:Update())
		end
		return schemeValue + offset, 1
	end
	return Vector2.new(0, 0), 1
end

function VectorMonitor:addValue(original, new)
	return original + new
end

function VectorMonitor:scaleValue(value, scale)
	return value / scale
end

function VectorMonitor:nullValue()
	return Vector2.new(0, 0)
end

function VectorMonitor:processEntry(entry)
	if entry.Type == InputType.Scheme then
		local scheme = entry.Code
		entry.Code = {}
		for id, _ in pairs(Direction) do
			if scheme.ControlSet[id] ~= nil then
				local monitor = AxisMonitor.new()
				monitor:Bind(scheme.ControlSet[id])
				entry.Code[id] = monitor
			end
		end
	end
end

function VectorMonitor:clean()
end

Console.log("Initialized.")
Console.log("Assembled.")

return VectorMonitor.new()
