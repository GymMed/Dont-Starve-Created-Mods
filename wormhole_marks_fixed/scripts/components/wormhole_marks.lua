local Wormhole_Marks = Class(function(self, inst)
    self.inst = inst
	self.marked = false
	self.wormhole_number = nil
		
	local playercheck = GetPlayer()
	if playercheck then
		local character_name = playercheck.prefab
		print("Player character's name: " .. character_name)
	end
end)

function Wormhole_Marks:MarkEntrance()
	self:GetNumber()
	if self.wormhole_number <= 22 then 
		self.marked = true
		self.inst.MiniMapEntity:SetIcon("mark_"..self.wormhole_number..".tex")
	end
end

function Wormhole_Marks:MarkExit()
	self:GetNumber()
	if self.wormhole_number <= 22 then 
		self.marked = true
		self.inst.MiniMapEntity:SetIcon("mark_"..self.wormhole_number..".tex")
		GetWorld().components.wormhole_counter:Set()
	end
end

function Wormhole_Marks:GetNumber()
	local wormhole_counter = GetWorld().components.wormhole_counter
    if wormhole_counter then
        self.wormhole_number = wormhole_counter:Get()
    else
		local Wormhole_Counter_Class = require("components/wormhole_counter")
		GetWorld().components.wormhole_counter = Wormhole_Counter_Class()
        wormhole_counter = GetWorld().components.wormhole_counter
        self.wormhole_number = wormhole_counter:Get()
        -- Handle the case where the wormhole_counter component doesn't exist
        --self.wormhole_number = 1
		print("wormhole_number = Wormhole_Counter_Class")
    end
end

function Wormhole_Marks:CheckMark()
	return self.marked
end

function Wormhole_Marks:OnSave()
	local data = {}
	data.marked = self.marked
	data.wormhole_number = self.wormhole_number
	return data
end

function Wormhole_Marks:OnLoad(data)
	if data then
		self.marked = data.marked
		self.wormhole_number = data.wormhole_number
		if self.marked and self.wormhole_number then
		self.inst.entity:AddMiniMapEntity()
		self.inst.MiniMapEntity:SetIcon("mark_"..self.wormhole_number..".tex")
		end
	else
		self.marked = false
		self.wormhole_number = 0
	end
end

return Wormhole_Marks