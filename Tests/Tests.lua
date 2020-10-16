--- Provides a function to run tests.
-- The generic testing function can be run in whatever testing environtment is
-- being used, providing a layer of abstraction between the test suite and the
-- environment.
--
-- @author LastTalon
-- @version 0.1.0, 2020-10-13
-- @since 0.2
--
-- @module Tests
--
-- @see TestEZ

-- Dependencies --
print("Tests: Loading dependencies...")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TestEZ = require(ReplicatedStorage:WaitForChild("Tests"):WaitForChild("TestEZ"))

-- Functions --
print("Tests: Constructing functions...")

--- The testing function.
-- Accepts a list of roots, runs tests on them, then reports on test status.
--
-- @param roots a table of roots to find tests
-- @return whether the tests completed
-- @return true if the tests were successful, false if the tests were
-- unsuccessful, an error message if the tests were not completed
local function Tests(roots)
	print()
	local result xpcall(function()
		local results = TestEZ.TestBootstrap:run(roots)
		return results.failureCount == 0
	end, debug.traceback)
	print()
	return result
end

-- End --
print("Tests: Done.")

return Tests
