--- The direction method enum
-- The direction methods are None, Absolute, and Relative. These are used with
-- an Input to tell how to measure directional inputs using the
-- UserInputService.
-- @module DirectionMethod
-- @author LastTalon
-- @see Input

Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("InputType")

Console.log("Assembling script...")
Console.log("Initializing locals...")

local method = {
	["None"] = 1, -- The direction is not measured.
	["Absolute"] = 2, -- The direction is measured from the origin.
	["Relative"] = 3 -- The direction is measured relative to its last direction.
}

Console.log("Initialized.")
Console.log("Assembled.")

return method
