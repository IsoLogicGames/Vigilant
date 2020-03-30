--- A type for determining how to read a directional Input.
-- The DirectionMethods are None, Absolute, and Relative. These are used with
-- an Input to tell how to measure directional Inputs using the
-- UserInputService.
--
-- @author LastTalon
-- @version 0.1.0, 2020-04-16
-- @since 0.1
--
-- @module DirectionMethod
--
-- @see Input

Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("InputType")

-- Constants --
Console.log("Initializing constants...")

--- The DirectionMethod enum.
--
-- @field None the direction is not measured
-- @field Absolute the direction is measured from the origin
-- @field Relative the direction is measured relative to its last direction
local Method = {
	["None"] = 1,
	["Absolute"] = 2,
	["Relative"] = 3
}

-- End --
Console.log("Done.")

return Method
