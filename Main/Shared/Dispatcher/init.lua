Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Dispatcher")

Console.log("Loading dependencies...")

RunService = game:GetService("RunService")
Event = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Event"))

Console.log("Loaded.")
Console.log("Assembling script...")
Console.log("Initializing locals...")

local Dispatcher = {}
Dispatcher.__index = Dispatcher

function Dispatcher.new(event, bind)
	local self = setmetatable({}, Dispatcher)
	bind = bind or false
	self.remoteEvent = event
	self.localEvent = Event.New()
	self.commands = {}
	self.currentTick = 0
	self.OnCommand = self.localEvent.Registrar
	for _, commandModule in ipairs(script:WaitForChild("Command"):GetChildren()) do
		self:Add(require(commandModule))
	end
	if bind then
		self:Bind()
	end
	return self
end

function Dispatcher:update(time, step)
	local tick = math.floor(time * 30)
	if tick > self.currentTick then
		self.currentTick = tick
		for _, command in pairs(self.commands) do
			local activations = command:Update(tick)
			for _, arguments in ipairs(activations) do
				if self.remoteEvent ~= nil then
					if RunService:IsClient() then
						self.remoteEvent:FireServer(command.Name, tick, arguments)
					elseif RunService:IsServer() then
						self.remoteEvent:FireAllClients(command.Name, tick, arguments)
					end
				end
				self.localEvent:Fire(command.Name, tick, 0, nil, true, arguments)
			end
		end
		for _, command in ipairs(self.commandQueue) do
			self.localEvent:Fire(command.name, tick, tick - command.tick, command.player, false, command.arguments)
		end
		self.commandQueue = {}
	end
end

function Dispatcher:updateRemoteEvent(...)
	local args = {...}
	local command = {}
	if RunService:IsClient() then
		command.name = args[1]
		command.tick = args[2]
		command.arguments = args[3]
	elseif RunService:IsServer() then
		command.player = args[1]
		command.name = args[2]
		command.tick = args[3]
		command.arguments = args[4]
	end
	table.insert(self.commandQueue, command)
end

function Dispatcher:Bind()
	if self.remoteConnection == nil and self.remoteEvent ~= nil then
		self.commandQueue = {}
		if RunService:IsClient() then
			self.remoteConnection = self.remoteEvent.OnClientEvent:Connect(function(...) self:updateRemoteEvent(...) end)
		elseif RunService:IsServer() then
			self.remoteConnection = self.remoteEvent.OnServerEvent:Connect(function(...) self:updateRemoteEvent(...) end)
		end
	end
	if self.binding == nil then
		self.binding = RunService.Stepped:Connect(function(...) self:update(...) end)
	end
end

function Dispatcher:Unbind()
	if self.remoteConnection == nil then
		self.commandQueue = nil
		self.remoteConnection:Disconnect()
		self.remoteConnection = nil
	end
	if self.binding ~= nil then
		self.binding:Disconnect()
		self.binding = nil
	end
end

function Dispatcher:Add(command)
	self.commands[command.name] = command
	self.OnCommand:Connect(function(...) command:Listener(...) end)
end

function Dispatcher:Remove(command)
	self.commands[command.name] = nil
end

Console.log("Initialized.")
Console.log("Assembled.")

return Dispatcher
