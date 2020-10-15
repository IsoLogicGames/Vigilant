--- The Lemur test runner script.
-- This script can run with Lemur to perform automated tests.
--
-- @author LastTalon
-- @version 0.1.0, 2020-10-15
-- @since 0.2
--
-- @module LemurTestRunner
-- @throws when the tests fail

-- Dependencies --
print("LemurRunner: Loading dependencies...")

-- Add init.lua to path allowing Lemur (and other dependencies to load)
package.path = package.path .. ";?/init.lua"

local Lemur = require("lemur")
local Habitat = Lemur.Habitat.new()

-- Constants --
print("LemurRunner: Initializing constants...")

--- The source locations to load in lemur
local Source = { -- This can potentially be loaded from a project.json
	["Client"] = "StarterPlayer.StarterPlayerScripts",
	["Loading"] = "ReplicatedFirst.Scripts",
	["Server"] = "ServerScriptService",
	["Shared"] = "ReplicatedStorage.Scripts",
	["Tests"] = "ReplicatedStorage.Tests",
	["Modules/TestEZ"] = "ReplicatedStorage.Tests.TestEZ"
}

-- Functions --
print("LemurRunner: Constructing functions...")

--- Tokenizes a habitat path.
-- @param path the path to tokenize
-- @return a table of the tokens
local function tokenizePath(path)
	local tokens = {}
	for token in string.gmatch(path, "[^%.]+") do
		table.insert(tokens, token)
	end
	return tokens
end

-- Main --
print("LemurRunner: Running...")

-- Build the project in Lemur
for fsPath, habitatPath in pairs(Source) do
	local source = Habitat:loadFromFs(fsPath)
	local tokens = tokenizePath(habitatPath)
	local container = Habitat.game:GetService(tokens[1])
	local containerExists = false

	-- Find the object we're placing this source in
	if #tokens == 1 then
		containerExists = true
	else
		for i = 2, #tokens - 1 do
			container = container:FindFirstChild(tokens[i])
		end
		local object = container:FindFirstChild(tokens[#tokens])
		if object then
			container = object
			containerExists = true
		end
	end

	-- If the final container exists place everything inside.
	if containerExists then
		for _, object in source:GetChildren() do
			object.Parent = container
		end
		source:Destroy()
	else -- If it doesn't, replace it
		source.Name = tokens[#tokens]
		source.Parent = container
	end
end

-- Load variables dependent on the build
local ReplicatedStorage = Habitat.game:GetService("ReplicatedStorage")
local Tests = Habitat:require(ReplicatedStorage:WaitForChild("Tests"):WaitForChild("Tests"))
local Roots = {ReplicatedStorage.Tests}

-- Run tests and set up exit status
local completed, result = Tests(Roots)
local status = 0

-- Determine and report results
if completed then
	if not result then
		print("Tests have failed.")
		status = 1
	end
else
	print(result)
	status = 2
end

-- End --
print("LemurRunner: Done.")

os.exit(status)
