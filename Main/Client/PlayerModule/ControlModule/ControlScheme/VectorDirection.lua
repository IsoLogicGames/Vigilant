--- A type for determining the orientation of a vector Input.
-- The directions are Vertical, and Horizontal. These are used with an Input
-- and a ControlScheme to create a vector Input from two axis Inputs.
--
-- @author LastTalon
-- @version 0.1.0, 2020-04-16
-- @since 0.1
--
-- @module VectorDirection
--
-- @see ControlScheme
-- @see Input

local Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("VectorDirection")

-- Constants --
Console.log("Initializing constants...")

--- The VectorDirection enum.
--
-- @field Vertical the vertical direction
-- @field Horizontal the horizontal direction
local Direciton = {
	["Vertical"] = 1,
	["Horizontal"] = 2
}

-- End --
Console.log("Done.")

return Direction
