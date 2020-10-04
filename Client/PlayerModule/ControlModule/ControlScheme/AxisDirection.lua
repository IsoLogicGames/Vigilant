--- An enum for the direction of an axis.
-- The directions are Up, and Down. These are used with an Input and a
-- ControlScheme to create an axis input from two binary inputs.
--
-- @author LastTalon
-- @version 0.1.0, 2020-04-15
-- @since 0.1
--
-- @module AxisDirection
--
-- @see ControlScheme
-- @see Input

local Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("AxisDirection")

-- Constants --
Console.log("Initializing constants...")

--- The AxisDirection enum.
--
-- @field Up the up or positive direction
-- @field Down the down or negative direction
local Direction = {
	["Up"] = 1,
	["Down"] = 2
}

-- End --
Console.log("Done.")

return Direction
