return function()
	local Logger = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Logger"))

	describe("entries", function()
		it("should give an iterator", function()
			local log = Logger.new()
			expect(log:Entries()).to.be.a("function")
		end)
	end)
end
