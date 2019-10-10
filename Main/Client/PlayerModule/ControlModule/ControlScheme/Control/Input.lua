--- An input.
-- Represents an input that a player could provide. This input can be used to
-- cause a character to perform an action.
-- @module Input
-- @field Type the input type of this input. Should be a @{InputType}.
-- @field Code the code for this input. A code may not be necessary depending on
-- the input type. Should be a @{Enum.KeyCode}, @{ControlScheme},
-- @{Enum.UserInputType}, @{DirectionMethod}, or nil.
-- @field Offset the offset to displace this input by. Should be a @{UDim},
-- @{UDim2} or nil.
-- @field Devices the array of devices this input should trigger for. Should be
-- an array of @{Enum.UserInputType}.
-- @author LastTalon

Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Input")

Console.log("Assembling script...")
Console.log("Initializing locals...")

local Input = {}
Input.__index = Input

--- Constructor for a new input object.
-- Creates a new input object with a type and code.
-- @param type    the type of the new input
-- @param code    the code of the new input
-- @param offset  the offset of the new input
-- @param devices the array of devices of the new input
-- @return the new input
function Input.new(type, code, offset, devices)
	local self = setmetatable({}, Input)
	if type(type) == "number" then
		self.Type = type
		self.Code = code
		self.Offset = offset
		self.Devices = devices
	end
	return self
end

Console.log("Initialized.")
Console.log("Assembled.")

return Input
