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

function LPT:BossComplete(difficultyId)
	if difficultyId == 14 then
		lptEvents.normalRaid = lptEvents.normalRaid + 1
		LPT:PrintInfo("Normal Raid Boss", lptEvents.normalRaid)
	elseif difficultyId == 15 then
		lptEvents.heroicRaid = lptEvents.heroicRaid + 1
		LPT:PrintInfo("Heroic Raid Boss", lptEvents.HeroicRaid)
	elseif difficultyId == 7 then
		lptEvents.lfr = lptEvents.lfr +1
		LPT:PrintInfo("LFR Boss", lptEvents.lfr)
	end
end

function LPT:BlingtronComplete()
	lptEvents.blingtron = lptEvents.blingtron + 1
	LPT:PrintInfo("Blingtron", lptEvents.blingtron)
end

function LPT:WorldBossCompleted()
	lptEvents.worldBoss = lptEvents.worldBoss + 1
	LPT:PrintInfo("World Boss", lptEvents.worldBoss)
end