local DEFAULT_BUDGET_SECONDS = 1 / 10

local function createYieldIfNeeded(budgetSeconds)
	local budget = budgetSeconds or DEFAULT_BUDGET_SECONDS
	local sinceLastYield = os.clock()

	return function()
		local now = os.clock()
		if now - sinceLastYield > budget then
			task.wait()
			sinceLastYield = os.clock()
			return true
		end

		return false
	end
end

return createYieldIfNeeded