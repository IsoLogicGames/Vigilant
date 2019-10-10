--- The base class for all monitors.
-- This is meant to be an abstract class and should be used to inherit from in
-- other monitors.
-- @module Monitor
-- @author LastTalon

Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Monitor")

Console.log("Loading dependencies...")

UserInputService = game:GetService("UserInputService")
InputType = require(script.Parent:WaitForChild("InputType"))
DirectionMethod = require(script.Parent:WaitForChild("DirectionMethod"))

Console.log("Loaded.")
Console.log("Assembling script...")
Console.log("Initializing globals...")

function getDeviceInput(code, device)
	local inputs = UserInputService:GetGamepadState(device)
	for _, input in ipairs(inputs) do
		if input.KeyCode == code then
			return input
		end
	end
end

Console.log("Initialized.")
Console.log("Initializing locals...")

local Monitor = {}
Monitor.__index = Monitor

--- The constructor for a monitor.
-- @return the new monitor
function Monitor.new()
	local self = setmetatable({}, Monitor)
	self.bound = false
	self.inputs = {}
	return self
end

--- A method that tells if this monitor is currently bound.
-- @return true if bound, false otherwise
function Monitor:Bound()
	return self.bound
end

--- A method that accesses this monitor's value.
-- @return the value
function Monitor:GetValue()
	return self.value
end

function Monitor:Update()
	local value = self:nullValue()
	local scale = 0
	for _, input in ipairs(self.inputs) do
		local inputValue
		local inputScale
		local valid = true
		
		-- Get specific input
		if input.Type == InputType.None then
			inputValue = false
		elseif input.Type == InputType.Keyboard then
			inputValue = UserInputService:IsKeyDown(input.Code)
		elseif input.Type == InputType.MouseButton then
			inputValue = UserInputService:IsMouseButtonPressed(input.Code)
		elseif input.Type == InputType.MouseMovement then
			if input.Code == DirectionMethod.None then
				inputValue = false
			elseif input.Code == DirectionMethod.Absolute then
				inputValue = UserInputService:GetMouseLocation()
			elseif input.Code == DirectionMethod.Relative then
				inputValue = UserInputService:GetMouseDelta()
			else
				Console.error("Input has invalid direction method.")
				valid = false
			end
		elseif input.Type == InputType.GamepadButton then
			inputValue = UserInputService:IsGamepadButtonDown(input.Code, input.Device)
		elseif input.Type == InputType.GamepadDirection then
			if input.Code == DirectionMethod.None then
				inputValue = false
			elseif input.Code == DirectionMethod.Absolute then
				inputValue = getDeviceInput(input.Code, input.Device).Position
			elseif input.Code == DirectionMethod.Relative then
				inputValue = getDeviceInput(input.Code, input.Device).Delta
			else
				Console.error("Input has invalid direction method.")
				valid = false
			end
		elseif input.Type == InputType.Scheme then
			inputValue == input.Code
		else
			Console.error("Input has invalid type.")
			valid = false
		end
		
		if valid then
			inputValue, inputScale = self:transformValue(input, inputValue)
			value = self:addValue(value, inputValue)
			scale = scale + inputScale
		end
	end
	
	self.value = self:scaleValue(value, scale)
	return self:GetValue()
end

function Monitor:Bind(control)
	if not self:Bound() then
		for _, input in ipairs(control.inputs) do
			local entry = {}
			entry.Type = input.Type
			entry.Code = input.Code
			entry.Offset = input.Offset
			entry.Devices = input.Devices
			self:processEntry(entry)
			table.insert(self.inputs, entry)
		end
		self.bound = true
	end
end

function Monitor:Unbind()
	if self:Bound() then
		self.inputs = {}
		self:clean()
		self.bound = false
	end
end

function Monitor:transformValue()
	Console.warn("updateInput must be overridden and should not be called from Monitor.")
end

function Monitor:addValue()
	Console.warn("addValue must be overridden and should not be called from Monitor.")
end

function Monitor:scaleValue()
	Console.warn("scaleValue must be overridden and should not be called from Monitor.")
end

function Monitor:nullValue()
	Console.warn("nullValue must be overridden and should not be called from Monitor.")
end

function Monitor:processEntry()
	Console.warn("processEntry must be overridden and should not be called from Monitor.")
end

function Monitor:clean()
	Console.warn("clean must be overridden and should not be called from Monitor.")
end

Console.log("Initialized.")
Console.log("Assembled.")

return Monitor.new()
