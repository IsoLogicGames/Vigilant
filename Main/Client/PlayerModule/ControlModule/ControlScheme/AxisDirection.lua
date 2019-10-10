--- The axis direction enum
-- The directions are Up, and Down. These are used with an @{Input} and a
-- @{ControlScheme} to create an axis input from two binary inputs.
-- @module AxisDirection
-- @author LastTalon
-- @see ControlScheme
-- @see Input

Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("AxisDirection")

Console.log("Assembling script...")
Console.log("Initializing locals...")

local direction = {
	["Up"] = 1, -- The up or positive direction.
	["Down"] = 2, -- The down or negative direction.
}

Console.log("Initialized.")
Console.log("Assembled.")

return direction
