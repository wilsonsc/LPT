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