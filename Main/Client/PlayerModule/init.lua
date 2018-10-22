--- The main player module.
-- A singleton object responsible initializing and providing access other client
-- singletons.
-- @module ControlModule
-- @field Cameras the camera module singleton
-- @field Controls the control module singleton
-- @author LastTalon

Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Player Module")

Console.log("Loading dependencies...")

Cameras = require(script:WaitForChild("CameraModule"))
Controls = require(script:WaitForChild("ControlModule"))

Console.log("Loaded.")
Console.log("Assembling script...")
Console.log("Initializing locals...")

local PlayerModule = {}
PlayerModule.__index = PlayerModule

local instance

--- The contructor for the player module singleton.
-- Creates a new reference copy of the singleton. This is the same object you
-- get when you require the control module. The only use this has is for
-- inheritance or as a quick copy to pass around.
-- @return the singleton
function PlayerModule.new()
	if instance == nil then
		local self = setmetatable({}, PlayerModule)
		self.Cameras = Cameras
		self.Controls = Controls
		instance = self
	end
	return instance
end

Console.log("Initialized.")
Console.log("Assembled.")

return PlayerModule.new()
