--- An input.
-- Represents an input that a player could provide. This input can be used to
-- cause a character to perform an action.
-- @module Input
-- @field Type the input type of the input. Should be a @{Enum.UserInputType}.
-- @field Code the code for the input. A code may not be necessary depending on
-- the type of input. Should be a @{Enum.KeyCode}.
-- @field Scheme the sub-scheme that is used to contruct this input from simpler
-- control methods.
-- @author LastTalon

Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Input")

Console.log("Assembling script...")
Console.log("Initializing locals...")

local Input = {}
Input.__index = Input

--- Constructor for a new input object.
-- Creates a new input object with a type and code.
-- @param type   the type of the new input
-- @param code   the code of the new input
-- @param offset the ofset of the new input
-- @return the new input
function Input.new(input, code, offset)
	local self = setmetatable({}, Input)
	if type(input) == "number" then
		self.Type = input
		self.Code = code
		self.Offset = offset
	elseif input ~= nil then
		self.Scheme = input
	end
	return self
end

Console.log("Initialized.")
Console.log("Assembled.")

return Input
