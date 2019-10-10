--- The vector direction enum
-- The directions are Vertical, and Horizontal. These are used with an @{Input}
-- and a @{ControlScheme} to create a vector input from two axis inputs.
-- @module VectorDirection
-- @author LastTalon
-- @see ControlScheme
-- @see Input

Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("VectorDirection")

Console.log("Assembling script...")
Console.log("Initializing locals...")

local direction = {
	["Vertical"] = 1, -- The vertical direction.
	["Horizontal"] = 2, -- The horizontal direction.
}

Console.log("Initialized.")
Console.log("Assembled.")

return direction
