LPT = LibStub("AceAddon-3.0"):NewAddon("LPT", "AceConsole-3.0", "AceEvent-3.0")
Day = 86400
Week = 604800
LegILVLBase = 910
LegILVLMid = 940
LegILVL = 970


function LPT:OnEnable()
	--self:RegisterEvent("ADDON_LOADED")
    self:RegisterEvent("CHAT_MSG_LOOT")
    self:RegisterEvent("QUEST_TURNED_IN")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	--self:RegisterEvent("UNIT_SPELLCAST_STOP")
	self:RegisterEvent("CHALLENGE_MODE_COMPLETED")
	self:RegisterEvent("ENCOUNTER_END")
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
	if command == "print" or command == "show" then
		LPT:PrintEvents()
	end
	if command == "info" then
		if value == nil then
			printInfo =  not printInfo
		elseif value == "true" or value == "on" then
			printInfo = true
		elseif value == "false" or value == "off" then
			printInfo = false
		end
		if printInfo then
			self:Print("Informational prints on")
		else
			self:Print("Informational prints off")
		end
	end	
	
	if command == "save" then
		LPT:SaveHistory()
		LPT:PrintEvents()
		LPT:ResetChances()
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
	elseif bosses[14] == nil then
		LPT:initializeBoss()
	end
	
	if printInfo == nil then
		printInfo = true
	end
	
	if historical == nil then
		historical = {}
		historical.numLegs = 0
		historical.installedDate = time()
		historical.weekNum = LPT:GetWeek() 
	end
	
	if historical.weekNum == nil or historical.weekNum < LPT:GetWeek() then
		historical.weekNum = LPT:GetWeek()
		LPT:initializeBoss()
	end
	
	LPT:RegisterChatCommand('lpt', 'SlashCommands')
	LPT:setIslandRares()

end

function LPT:GetWeek()
	local LPTEpoch = 1502809200
	return (time() - LPTEpoch) / Week --Our "epoch" week is Aug 15th 2017
end
function LPT:SaveHistory()

	for event,value in pairs(lptEvents) do
		lastLegInfo[event] = value
	end
		lastLegInfo.date = time()
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
	if historical.numLegs == 0 then 
		self:Print("Reporting events since install")
	else
		self:Print("Reporting events since last legendary")
	end
	self:Print("Emissary Chests: " .. lptEvents.emissaryChest)
	--self:Print("Weekly Chest: " .. lptEvents.weeklyChest)
	self:Print("Paragon Chests: " .. lptEvents.paragonChest)
	--self:Print("Normal Mode Dungeons: " .. lptEvents.normalDungeon)
	--self:Print("Heroic Dungeons: " .. lptEvents.heroicDungeon)
	--self:Print("Island Chests: " .. lptEvents.islandChest)
	self:Print("Island Rares: " .. lptEvents.islandRare)
	--self:Print("Mythic 0 Dungeon Bosses: " .. lptEvents.mythicDungeon)
	self:Print("Mythic + Dungeons: " ..lptEvents.mPlusDungeon)
	self:Print("Raid bosses (LFR; Normal; Heroic; Mythic): " .. lptEvents.lfr .. "; " .. 
		lptEvents.normalRaid .. "; " .. lptEvents.heroicRaid .. "; " .. lptEvents.mythicRaid)
	--[[self:Print("LFR Bosses: " .. lptEvents.lfr)
	self:Print("Normal Raid Bosses: " .. lptEvents.normalRaid)
	self:Print("Heroic Raid Bosses: " .. lptEvents.heroicRaid)
	--self:Print("Mythic Raid Bosses: " .. lptEvents.mythicRaid)]]--
	self:Print("World Bosses: " .. lptEvents.worldBoss)
	--self:Print("Unimplemented pvp stuff: " .. lptEvents.pvp)
	self:Print("War Supplies Caches: " .. lptEvents.warSupplies)
	self:Print("Blingtron 6000: " .. lptEvents.blingtron)
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
function LPT:ENCOUNTER_END(event, id, _, difficulty, _, killed)

	if killed and bosses[difficulty] ~= nil and bosses[difficulty][id] then
		bosses[difficulty][id] = false
		LPT:BossComplete(difficulty)
	end
	

end
function LPT:CHAT_MSG_LOOT(event, message, _, _, _, looter)

	local _, _, item = string.find(message, '(|.+|r)')
	local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(item)
	if quality == 5 and (iLevel == LegILVL or iLevel == LegILVLBase or iLevel == LegILVLMid) and looter ~= GetUnitName("player") then
		self:Print("Congratulations on your legendary!!")
		self:Print("Let Kilwen know what ilvl this is " .. iLevel)
		LPT:SaveHistory()
		LPT:PrintEvents()
		LPT:ResetCounts()
	elseif name == "Blingtron 6000 Gift Package" then
		LPT:BlingtronComplete()
	end

end

function LPT:CHALLENGE_MODE_COMPLETED()

	LPT:MythicPlusCompleted()
	
end

function LPT:COMBAT_LOG_EVENT_UNFILTERED(eventName, timeStamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, argxx, destGuid, destName, destFlags, arg9, arg10, arg11, arg12, ...)
	--self:Print(eventName, timeStamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, argxx, destGuid, destName, destFlags, arg9, arg10, arg11, arg12)
	if string.match(event,"UNIT_DIED") then
		local mobID = LPT:GuidToID(destGuid, "mob")
		
		--if bosses[mobID] == true then
			--bosses[mobID] = false
		if isleRares[mobID] == true then
			LPT:IsleRareCompleted(mobID)
		end
	end
end

function LPT:QUEST_TURNED_IN(timestamp, questId, arg3, arg4)
	if questId == 42421 --nightfallen
		or questId == 42233 --highmountain
		or questId == 42234 --Valarjar
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
	elseif questId == 43512 --Ana-Mouz
		or questId == 47061 --Apocron
		or questId == 46947 --Brutallus
		or questId == 43193 --Calamir
		or questId == 43448 --Drugon
		or questId == 43985 --Flotsam
		or questId == 42819 --Humongris
		or questId == 43192 --Levantus
		or questId == 46948 --Malificus
		or questId == 43513 --Na'zak
		or questId == 42270 --Nithogg
		or questId == 42779 --Shar'thos
		or questId == 46945 --Si'vash
		or questId == 42269 --Soultakers
		or questId == 44287 --Jim
		then
		LPT:WorldBossCompleted()
	end
end