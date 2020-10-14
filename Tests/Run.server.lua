--- The Roblox test runner script.
-- This script can run within Roblox to perform automated tests.
--
-- @author LastTalon
-- @version 0.1.0, 2020-10-13
-- @since 0.2
--
-- @module TestRunner
-- @throws when the tests fail

-- Dependencies --
print("Runner: Loading dependencies...")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Tests = require(ReplicatedStorage:WaitForChild("Tests"):WaitForChild("Tests"))

-- Constants --
print("Runner: Initializing constants...")

--- The locations containing tests.
local Roots = {ReplicatedStorage.Tests}

-- Main --
print("Runner: Running...")

local completed, result = Tests(Roots)

if completed then
	if not result then
		error("Tests have failed.", 0)
	end
else
	error(result, 0)
end

-- End --
print("Runner: Done.")
