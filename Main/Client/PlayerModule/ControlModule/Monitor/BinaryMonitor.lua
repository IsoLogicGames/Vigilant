Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Binary Monitor")

Console.log("Loading dependencies...")

Monitor = require(script.Parent)
InputType = require(script.Parent.Parent:WaitForChild("InputType"))

Console.log("Loaded.")
Console.log("Assembling script...")
Console.log("Initializing locals...")

local BinaryMonitor = Monitor.new()
BinaryMonitor.__index = BinaryMonitor

--- The constructor for a binary monitor.
-- @return the new binary monitor
function BinaryMonitor.new()
	local self = setmetatable({}, BinaryMonitor)
	return self
end

function BinaryMonitor:transformValue(input, value)
	local type = input.Type
	if type == InputType.None or type == InputType.Keyboard or type == InputType.MouseButton or type == InputType.GamepadButton then
		return value, 0
	elseif type == InputType.MouseMovement or type == InputType.GamepadDirection then
		return value ~= Vector3.new(0, 0, 0), 0
	end
	return false, 0
end

function BinaryMonitor:addValue(original, new)
	return original or new
end

function BinaryMonitor:scaleValue(value, scale)
	return value
end

function BinaryMonitor:nullValue()
	return false
end

function BinaryMonitor:processEntry()
end

function BinaryMonitor:clean()
end

Console.log("Initialized.")
Console.log("Assembled.")

return BinaryMonitor.new()
