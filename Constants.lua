
function LPT:initializeBoss()
	bosses = {
			  [61658] = true, [61657] = true, [107803] = true, --test

			  --Dungeon Bosses
			  [98205] = true,[98203] = true,[98207] = true,[98206] = true,[98208]= true,            --arcway
			  [104215] = true,[104217] = true,[104218] = true,                     --court of stars
			  [95884] = true,[96015] = true,[95886] = true,[95887] = true,[95888] = true,            --vault of the wardens
			  [96756] = true,[96754] = true,[96759] = true,                        --maw of souls
			  [98542] = true,[98696] = true,[98949] = true,[94923] = true,                  --black rook hold
			  [102617] = true,[102614] = true,[102615] = true,[102616] = true,[102618] = true,[102619] = true,--violet hold
			  [91003] = true,[91004] = true,[91005] = true,[91007] = true,                  --neltharions lair
			  [94960] = true,[95833] = true,[95674] = true,[95675] = true,[95676] = true,            --halls of valor
			  [91784] = true,[91789] = true,[91797] = true,[91808] = true,[96028] = true,            --eye of azshara
			  [96512] = true,[103344] = true,[99200] = true,[101403] = true,                --darkheart thicket
			  [114262] = true,[114328] = true,[114261] = true,[114284] = true,[114251] = true,[113971] = true,[114312] = true,[114247] = true,[114895] = true,[114350] = true,[116494] = true,[114790] = true,--karazhan
			  
			  --Raid Bosses
			  [102672] = true,[106087] = true,[105393] = true,[100497] = true,[102679] = true,[104636] = true,[103769] = true, -- EN
			  [114263] = true,[114344] = true,[114537] = true, -- ToV
			  [102263] = true,[101002] = true,[104415] = true,[104288] = true,[103758] = true,[105503] = true,[110965] = true,[107699] = true,[104528] = true,[103685] = true -- NH     
	}
end

function LPT:setIslandRares()

	if isleRares == null then
		isleRares = {}
	end
	
	if IsQuestFlaggedCompleted(46094) then --Potionmaster Gloop
		isleRares[117096] = false
	else
		isleRares[117096] = true
	end
	
	if IsQuestFlaggedCompleted(46313) then --Imp Mother Bruva
		isleRares[119718] = false
	else
		isleRares[119718] = true
	end
	
	if IsQuestFlaggedCompleted(47036) then --Duke Sithizi
		isleRares[121134] = false
	else
		isleRares[121134] = true
	end
	
	if IsQuestFlaggedCompleted(47001) then --Brother Badatin
		isleRares[121046] = false
	else
		isleRares[121046] = true
	end
	
	if IsQuestFlaggedCompleted(46951) then --Flllurlokkr
		isleRares[46951] = false
	else
		isleRares[46951] = true
	end
	
	if IsQuestFlaggedCompleted(47028) then --Somber Dawn
		isleRares[121112] = false
	else
		isleRares[121112] = true
	end
	
	if IsQuestFlaggedCompleted(46965) then --Brood Mother Nix
		isleRares[121029] = false
	else
		isleRares[121029] = true
	end
	
	if IsQuestFlaggedCompleted(47026) then --Lady Eldrathe
		isleRares[121107] = false
	else
		isleRares[121107] = true
	end
	
	if IsQuestFlaggedCompleted(46097) then --Doombringer Zar'thoz
		isleRares[117136] = false
	else
		isleRares[117136] = true
	end

	if IsQuestFlaggedCompleted(46102) then --Felcaller Zelthae
		isleRares[117103] = false
	else
		isleRares[117103] = true
	end
	
	if IsQuestFlaggedCompleted(46093) then --Emberfire
		isleRares[117086] = false
	else
		isleRares[117086] = true
	end
	
	if IsQuestFlaggedCompleted(46095) then --Felmaw Emberfiend
		isleRares[117091] = false
	else
		isleRares[117091] = true
	end
	
	if IsQuestFlaggedCompleted(46304) then --Lord Hel'Nurath
		isleRares[119629] = false
	else
		isleRares[119629] = true
	end
	
	if IsQuestFlaggedCompleted(46099) then --Felbringer Xar'thok
		isleRares[117093] = false
	else
		isleRares[117093] = true
	end
	
	if IsQuestFlaggedCompleted(46995) then --Grossir
		isleRares[121037] = false
	else
		isleRares[121037] = true
	end
	
	if IsQuestFlaggedCompleted(46096) then --Inquisitor Chillbane
		isleRares[117089] = false
	else
		isleRares[117089] = true
	end
	
	if IsQuestFlaggedCompleted(46098) then --Dreadblade Annihilator
		isleRares[117095] = false
	else
		isleRares[117095] = true
	end
	
	if IsQuestFlaggedCompleted(46090) then --Malgrazoth
		isleRares[117141] = false
	else
		isleRares[117141] = true
	end
	
	if IsQuestFlaggedCompleted(46953) then --Aqueux
		isleRares[121016] = false
	else
		isleRares[121016] = true
	end
	
	if IsQuestFlaggedCompleted(46091) then --Salethan the Broodwalker
		isleRares[117140] = false
	else
		isleRares[117140] = true
	end
	
	if IsQuestFlaggedCompleted(46202) then --Dreadeye
		isleRares[118993] = false
	else
		isleRares[118993] = true
	end
	
	if IsQuestFlaggedCompleted(46100) then --Xorogun the Flamecarver
		isleRares[117090] = false
	else
		isleRares[117090] = true
	end
	
	if IsQuestFlaggedCompleted(46092) then --Malorus the Soulkeeper
		isleRares[117094] = false
	else
		isleRares[117094] = true
	end
	
	if IsQuestFlaggedCompleted(47068) then --Eye of Gurgh
		isleRares[116166] = false
	else
		isleRares[116166] = true
	end
	
	if IsQuestFlaggedCompleted(46101) then --Corrupted Bonebreaker
		isleRares[116953] = false
	else
		isleRares[116953] = true
	end
end

world_bosses = {
          109943, --Ana-Mouz
          109331, --Calamir
          110378, --Drugon the Frostblood
          99929,  --Flotsam
          108879, --Humongris <The Wizard>
          108829, --Levantus
          110321, --Na'zak the Fiend
          107544, --Nithogg
          108678, --Shar'thos
          112350, --Withered J'im
          --The Soultakers
          106981, --Captain Hring
          106984, --Soultrapper Mevra
          106982 --Reaver Jdorn 
}
