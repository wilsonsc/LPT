LPT = LibStub("AceAddon-3.0"):NewAddon("LPT", "AceConsole-3.0", "AceEvent-3.0")
Day = 86400
LegILVL = 970

function LPT:OnEnable()
	--self:RegisterEvent("ADDON_LOADED")
    self:RegisterEvent("CHAT_MSG_LOOT")
    self:RegisterEvent("QUEST_TURNED_IN")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	--self:RegisterEvent("UNIT_SPELLCAST_STOP")
	self:RegisterEvent("CHALLENGE_MODE_COMPLETED")
end

function LPT:OnDisable()
    self:Print("disabling")
end

function LPT:GuidToID(guid, guidType)
	if not guid then return 1 end
	local _, _, _, _, itemid, mobid = strsplit("-", guid)
	if guidType == "mob" then
		return tonumber(mobid) or 1
	elseif guidType == "object" then
		return tonumber(itemid) or 1
	end
end

function LPT:SlashCommands(input)

	input = string.lower(input)

	local command,value,_ = strsplit(" ", input)
	if command == "print" then
		LPT:PrintEvents()
	end
	if command == "info" then
		if value == "true" or value == "on" then
			printInfo = true
			self:Print("Informational prints on")
		elseif value == "false" or value == "off" then
			printInfo = false
			self:Print("Informational prints off")
		end
	end	
		
end
function LPT:ADDON_LOADED(arg1, arg2)
	self:Print(arg2)
	
end

function LPT:OnInitialize()

	if lptEvents == nil then
    	LPT:ResetChances()
    end
	
	if lastLegInfo == nil then
		lastLegInfo = {}
	end
	
	if bosses == nil then
		LPT:initializeBoss()
	--RESET WEEK LATER
	end
	
	if printInfo == nil then
		printInfo = true
	end
	
	if historical == nil then
		historical = {}
		historical.numLegs = 0
		historical.installedDate = time()
	end
	
	LPT:RegisterChatCommand('lpt', 'SlashCommands')
	LPT:setIslandRares()

end

function LPT:SaveHistory()

	for event,value in pairs(lptEvents) do
		lastLegInfo[event] = value
	end
		lastLegInfo.date = date()
		historical.numLegs = historical.numLegs + 1
	
end

function LPT:ResetChances()
	--reset and initialize all counts to 0
	self:Print("Resetting event counts")
	lptEvents = {}
	lptEvents.emissaryChest = 0
	lptEvents.weeklyChest = 0
	lptEvents.paragonChest = 0
	lptEvents.normalDungeon = 0
	lptEvents.heroicDungeon = 0
	lptEvents.mythicDungeon = 0
	lptEvents.mPlusDungeon = 0
	lptEvents.lfr = 0
	lptEvents.normalRaid = 0
	lptEvents.heroicRaid = 0
	lptEvents.mythicRaid = 0
	lptEvents.worldBoss = 0
	lptEvents.pvp = 0
	lptEvents.islandRare = 0
	lptEvents.islandChest = 0
	lptEvents.warSupplies = 0
	lptEvents.blingtron = 0

end

function LPT:PrintEvents()
	
	self:Print("Reporting tracked events")
	self:Print("Emissary Chests: " .. lptEvents.emissaryChest)
	--self:Print("Weekly Chest: " .. lptEvents.weeklyChest)
	self:Print("Paragon Chests: " .. lptEvents.paragonChest)
	--self:Print("Normal Mode Dungeons: " .. lptEvents.normalDungeon)
	--self:Print("Heroic Dungeons: " .. lptEvents.heroicDungeon)
	--self:Print("Island Chests: " .. lptEvents.islandChest)
	self:Print("Island Rares: " .. lptEvents.islandRare)
	--self:Print("Mythic 0 Dungeon Bosses: " .. lptEvents.mythicDungeon)
	self:Print("Mythic + Dungeons Ran: " ..lptEvents.mPlusDungeon)
	--self:Print("LFR Bosses: " .. lptEvents.lfr)
	--self:Print("Normal Raid Bosses: " .. lptEvents.normalRaid)
	--self:Print("Heroic Raid Bosses: " .. lptEvents.heroicRaid)
	--self:Print("Mythic Raid Bosses: " .. lptEvents.mythicRaid)
	--self:Print("World Bosses: " .. lptEvents.worldBoss)
	--self:Print("Unimplemented pvp stuff: " .. lptEvents.pvp)
	self:Print("War Supplies Caches: " .. lptEvents.warSupplies)
	if historical.numLegs == 0 then 
	
		self:Print("Time since install of addon " .. tonumber(string.format("%.1f", (time() - historical.installedDate) / Day)) .. " days")
	else
		self:Print("Time since last legendary " .. tonumber(string.format("%.1f", (time() - lastLegInfo.date) / Day)) .. " days")
	end

end

--[[
function LPT:UNIT_SPELLCAST_SUCCEEDED(arg1, arg2, arg3, ...)
	self:Print(arg1)
	self:Print(arg2)
	self:Print(arg3)
end
]]--
--[[
function LPT:UNIT_SPELLCAST_STOP(arg1, arg2, arg3, arg4, arg5, ...)
	if LPT:GuidToID(arg5, "object") == 6478 then
		LPT:IslandChestCompleted()
	end
	
end
]]--

function LPT:CHAT_MSG_LOOT(...)

	--self:Print("You looted an item!")

	local event, message, _, _, _, looter = ...
	local _, _, lootedItem = string.find(message, '(|.+|r)')
	local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(lootedItem)
	
	if quality == 5 and iLevel == LegILVL and looter ~= GetUnitName("player") then
		self:Print("Congratulations on your legendary!!")
		LPT:SaveHistory()
		LPT:PrintEvents()
		LPT:ResetCounts()
	end

	--if we are getting a keystone, it means we may have picked up our weekly chest. 
	-- check that we are inside our order hall
	if name == "Mythic Keystone" then
		local _, type, diff = GetInstanceInfo()

		if name == "none" then
			lptEvents.weeklyChest = lptEvents.weeklyChest + 1
		end

	end
end

function LPT:CHALLENGE_MODE_COMPLETED()

	LPT:MythicPlusCompleted()
	
end

function LPT:COMBAT_LOG_EVENT_UNFILTERED(eventName, timeStamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, argxx, destGuid, destName, destFlags, arg9, arg10, arg11, arg12, ...)
	 
	if string.match(event,"UNIT_DIED") then
		local mobID = LPT:GuidToID(destGuid, "mob")
		
		if bosses[mobID] == true then
			bosses[mobID] = false
		elseif isleRares[mobID] == true then
			LPT:IsleRareCompleted(mobID)
		end
	end
end

function LPT:QUEST_TURNED_IN(timestamp, questId, arg3, arg4)
	if questId == 42421 --nightfallen
		or questId == 42233 --highmountain
		or questId == 42420 --court of farondis
		or questId == 42422 --wardens
		or questId == 42170 --dreamweavers
		or questId == 43179 --kirin tor
		then
		LPT:EmissaryCompleted()
	elseif questId == 46748 --Nightfallen Paragon
		or questId == 46743 --Highmountain Paragon
		or questId == 46746 --Valarjar Paragon
		or questId == 46745 --Court Paragon
		or questId == 46747 --Dreamweavers Paragon
		or questId == 46749 --Wardens Paragon
		or questId == 46777 --Legionfall Paragon
		then
		LPT:ParagonCompleted()
	elseif questId == 46735 --Command Center War Sup
		or questId == 46277 --Mage Tower War Sup
		or questId == 46736 --Nether Disruptor War Sup
		then
		LPT:WarSupCompleted()
	end
end