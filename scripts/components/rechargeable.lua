-- Unofficial Rechargeable component
local Rechargeable = Class(function(self, inst)
	self.inst         = inst
	self.bonus        = 1 -- Percent
	self.rechargetime = 0
	self._remaining   = 0
end)

function Rechargeable:GetPercent()
	return (self.rechargetime - self._remaining) / self.rechargetime
end

-- bonus param must be in [0, 1] range
function Rechargeable:AddBonus(bonus)
	self.bonus = self.bonus + bonus
end

function Rechargeable:GetRechargeTime()
	return self.rechargetime
end

function Rechargeable:Update()
	if self._remaining > 0 then
		self._remaining = self._remaining - (1 * self.bonus)
	end
end

function Rechargeable:SetRechargeTime(rechargetime)
	self.rechargetime = rechargetime
end

return Rechargeable