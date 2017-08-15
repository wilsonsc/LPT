--[[self:Print("Reporting tracked events")
	self:Print("Emissary Chest: " .. lptEvents.emissaryChest)
	self:Print("Weekly Chest: " .. lptEvents.weeklyChest)
	self:Print("Paragon Chests: " .. lptEvents.paragonChest)
	self:Print("Normal Mode Dungeons: " .. lptEvents.normalDungeon)
	self:Print("Heroic Dungeons: " .. lptEvents.heroicDungeon)
	self:Print("Island Chests: " .. lptEvents.islandChest)
	self:Print("Island Rares: " .. lptEvents.islandRare)
	self:Print("Mythic 0 Dungeon Bosses: " .. lptEvents.mythicDungeon)
	self:Print("Mythic + Dungeons Ran: " ..lptEvents.mPlusDungeon)
	self:Print("LFR Bosses: " .. lptEvents.lfr)
	self:Print("Normal Raid Bosses: " .. lptEvents.normalRaid)
	self:Print("Heroic Raid Bosses: " .. lptEvents.heroicRaid)
	self:Print("Mythic Raid Bosses: " .. lptEvents.mythicRaid)
	self:Print("World Bosses: " .. lptEvents.worldBoss)
	self:Print("Unimplemented pvp stuff: " .. lptEvents.pvp)
	self:Print("War Supplies Caches: " ..lptEvents.warSupplies)
	--]]

function LPT:PrintInfo(event, number)
	if printInfo then
		self:Print("Completed " .. event .. "! " .. number .. " total since last legendary")
	end
end

function LPT:EmissaryCompleted()
	lptEvents.emissaryChest = lptEvents.emissaryChest + 1
	LPT:PrintInfo("Emissary Cache", lptEvents.emissaryChest)
end

function LPT:ParagonCompleted()
	lptEvents.paragonChest = lptEvents.paragonChest + 1
	LPT:PrintInfo("Paragon Cache", lptEvents.paragonChest)
end

function LPT:IsleRareCompleted(mobID)
	isleRares[mobID] = false
	lptEvents.islandRare = lptEvents.islandRare + 1
	LPT:PrintInfo("Island Rare", lptEvents.islandRare)
end

function LPT:WarSupCompleted()
	lptEvents.warSupplies = lptEvents.warSupplies + 1
	LPT:PrintInfo("War Supply Turnin", lptEvents.warSupplies)
end

function LPT:IslandChestCompleted()
	lptEvents.islandChest = lptEvents.islandChest + 1
	LPT:PrintInfo("Veiled Chest", lptEvents.islandChest)
end

function LPT:MythicPlusCompleted()
	lptEvents.mPlusDungeon = lptEvents.mPlusDungeon + 1
	LPT:PrintInfo("Mythic + Dungeon", lptEvents.mPlusDungeon)
end