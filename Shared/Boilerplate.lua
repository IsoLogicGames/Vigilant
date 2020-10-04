--- A short description of the script.
-- A more detailed and in-depth description of the script. It should explain
-- what this script does.
--
-- @author The Author
-- @version 0.1.0, 2020-03-29
-- @since 0.1
--
-- @module ModuleName
-- @field Field a description of the field
-- @throws Error when the error happens
--
-- @see Reference
-- @deprecated only if it shouldn't be used anymore

local Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Boilerplate")

-- Dependencies --
Console.log("Loading dependencies...")

-- Load all services and require all scripts here unless they must be loaded
-- elsewhere or at a different time.

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RequiredScript = require(script.Parent)
local IncludedObject = require(ReplicatedStorage:WaitForChild("Object"))

-- Constants --
Console.log("Initializing constants...")

-- Declare, initialize, and construct all constant, or readonly names here.

--- A short description of the constant.
-- A more detailed and in-depth description of the constant. This is often not
-- necessary for most constants.
--
-- @since 0.1 only if different than the module
--
-- @see Reference
-- @deprecated only if it shouldn't be used anymore
local NumericConstant = 4

--- A short description of the enum.
-- A more detailed and in-depth description of the enum.
--
-- @since 0.1 only if different than the module
--
-- @field First a description of the field
-- @field Second a description of the field
-- @field Third a description of the field
--
-- @see Reference
-- @deprecated only if it shouldn't be used anymore
local LocalEnum = {
	["First"] = 1,
	["Second"] = 2,
	["Third"] = 3
}

-- Functions --
Console.log("Constructing functions...")

-- Declare, initialize, and construct all local functions here.

--- A short description of the function.
-- A more detailed and in-depth description of the function. This should
-- explain what the function does.
--
-- @since 0.1 only if different than the module
--
-- @param param a description of the parameter
-- @return a description of what is returned
-- @throws error when the error happens
--
-- @see Reference
-- @deprecated only if it shouldn't be used anymore
local function localFunction(param)
	return param + 1
end

-- Variables --
Console.log("Initializing variables...")

-- Declare and initialize all local variables here.

local Module = {}
local numericValue = 0

--- A short description of the object.
-- A more detailed and in-depth description of the object. This should explain
-- what the object does.
--
-- @since 0.1 only if different than the module
--
-- @field list a description of the field
-- @throws Error when the error happens
--
-- @see Reference
-- @deprecated only if it shouldn't be used anymore
local AccessoryObject = {}

-- Local Objects --
Console.log("Constructing objects...")

-- Construct any objects being created locally here including any main object
-- of the module.

Module.__index = {}

--- A short description of the method.
-- A more detailed and in-depth description of the method. This should
-- explain what the method does.
--
-- @since 0.1 only if different than the module
--
-- @return a description of what is returned
-- @throws error when the error happens
--
-- @see Reference
-- @deprecated only if it shouldn't be used anymore
function Module.new()
	local self = setmetatable({}, Module)
	return self
end

--- A short description of the method.
-- A more detailed and in-depth description of the method. This should
-- explain what the method does.
--
-- @since 0.1 only if different than the module
--
-- @throws error when the error happens
--
-- @see Reference
-- @deprecated only if it shouldn't be used anymore
function Module:Actiavte()
	AccessoryObject:Run(true)
end

AccessoryObject.list = {}

--- A short description of the method.
-- A more detailed and in-depth description of the method. This should
-- explain what the method does.
--
-- @since 0.1 only if different than the module
--
-- @param param a description of the parameter
-- @return a description of what is returned
-- @throws error when the error happens
--
-- @see Reference
-- @deprecated only if it shouldn't be used anymore
function AccessoryObject:Run(param)
	table.insert(self.list, param)
	return #self.list
end

-- Main --
Console.log("Running...")

-- Execute the main operation of the script here. For many modules (such as
-- those that create objects) this may be empty.

-- End --
Console.log("Done.")

-- This section should only deconstruct objects and return.

return Module.new()
