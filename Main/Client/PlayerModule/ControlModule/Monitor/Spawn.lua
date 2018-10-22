Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Monitor Spawn")

Console.log("Loading dependencies...")

Method = require(script.Parent.Parent:WaitForChild("ControlScheme"):WaitForChild("Control"):WaitForChild("Method"))
BinaryMonitor = require(script.Parent:WaitForChild("BinaryMonitor"))
AxisMonitor = require(script.Parent:WaitForChild("AxisMonitor"))
VectorMonitor = require(script.Parent:WaitForChild("VectorMonitor"))

Console.log("Loaded.")
Console.log("Assembling script...")
Console.log("Initializing locals...")

local function Spawn(control)
	local monitor
	if control.Method == Method.Binary then
		monitor = BinaryMonitor.new()
	elseif control.Method == Method.Axis then
		monitor = AxisMonitor.new()
	elseif control.Method == Method.Vector then
		monitor = VectorMonitor.new()
	end
	if monitor ~= nil then
		monitor.Control = control
	end
	return monitor
end

Console.log("Initialized.")
Console.log("Assembled.")

return Spawn
