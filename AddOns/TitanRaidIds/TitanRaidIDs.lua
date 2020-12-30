-- TitanRaidIDs.lua
--
-- Color Info:
-----------------------
-- http://html-color-codes.info/ is a viable site to get color codes from, if you want to use colors you prefer versus ones I choose.
-- use the HTML Color Picker, copy the code in the bottom right-hand side, to use that code, place it inside this: "|cff------", the code 
-- replaces the dashes, make sure end result matches the format of the other codes used here, use them as a guide.

-- Visual Settings:
local END_COLOR = FONT_COLOR_CODE_CLOSE;	-- got sick of how long this reference was.   result Color is somewhat light gold.
											-- It closes a color tag and returns color to Titan/WoW default.
local GRAY_DARK_COLOR = "|cff808080";
local GRAY_SILVER_COLOR = "|cffDBD5CA";
local WHITE_BRIGHT_COLOR = "|cffFFFFFF";
local YELLOW_BRIGHTPALE_COLOR = "|cffEBFC07";
local YELLOW_NEON_COLOR = "|cffFCE308";
local BLUE_NEON_COLOR = "|cff08FAFA";
local GREEN_NEON_COLOR = "|cff35FA3B";
local GREEN_NEON_DIMMED_COLOR = "|cff4BC143";
local GREEN_NEON_DARK_COLOR = "|cff449F3E";
local GREEN_DARK_COLOR = "|cff3A8048";
local GREEN_SLATE_COLOR = "|cff7A9079";
local RED_SLATE_COLOR = "|cffA8577A";
local RED_NEON_PURPLEPINK_COLOR = "|cffFC046F";
local ORANGE_NEON_COLOR = "|cffFCBB08";
local ORANGE_DIM_COLOR = "|cffBD8F3E";
local ORANGE_LESSDIM_COLOR = "|cffDAAC41";

local color_defaultAltName = WHITE_BRIGHT_COLOR;
local color_defaultMainLockout = GREEN_NEON_DARK_COLOR;
local color_defaultMainRaidLockout = GREEN_NEON_COLOR;
local color_defaultAltLockout = ORANGE_DIM_COLOR;
local color_defaultAltRaidLockout = END_COLOR;
local color_defaultTime = WHITE_BRIGHT_COLOR;
local color_defaultTimeText = WHITE_BRIGHT_COLOR;
local color_defaultResetIn = WHITE_BRIGHT_COLOR;
local color_defaultDashLine = END_COLOR;

local color_compactAltName = WHITE_BRIGHT_COLOR;
local color_compactMainRaidLockout = GREEN_NEON_COLOR;
local color_compactMainLockout = GREEN_NEON_DARK_COLOR;
local color_compactAltRaidLockout = END_COLOR;
local color_compactAltLockout = ORANGE_DIM_COLOR;
local color_compactTime = WHITE_BRIGHT_COLOR;
local color_compactTimeText = GRAY_DARK_COLOR;
local color_compactResetIn = WHITE_BRIGHT_COLOR;
local color_compactDashLine = END_COLOR;

local border_compactAltName_left = " - ";
local border_compactAltName_right = " - ";
local prefixPlayerName = "[R.ID] ";			-- prefix to the logged-in Alt name shown on button label.
local shortRaid = "";										-- raid .
local shortHeroic = BLUE_NEON_COLOR .. "+" .. END_COLOR;	-- heroic.

local simpleLineBreak = "--------------------------"
local defaultLineBreak = color_defaultDashLine .. simpleLineBreak .. END_COLOR;
local compactLineBreak = color_compactDashLine .. simpleLineBreak .. END_COLOR;
local padDots = "...";
local padSpace = " ";				-- 1 space currently to trail raid/instance name.
local padLockout = "    ";			-- 8 spaces = what the " # days " uses, 8 will prevent collisions,
									-- most of the time no danger of that, just wastes alot of space
									-- 4 spaces seems a good balance for both views.
-- end Visual Settings

-- four control vars used to avoid missing a line break, or doubling them up needlessly.
-- or doing anything that would be silly, like spam loading saved settings.
local ignoreMain = false;
local showLine_AltAboveHasRaids = true;
local firstRunLoadedSettings = 0;
local defaultMainLockoutCode = false;

-- Misc important vars.
local RAIDIDS_ID = "RaidIDs";
local TITAN_RAIDIDS_ARTWORK_PATH = "Interface\\AddOns\\TitanRaidIDs\\";
local iconUsed = "Interface\\AddOns\\TitanRaidIDs\\TitanRaidIDs.tga";

local compactView = 0;			-- 0 = show default view, 1 = show compact view.
local shortDifficulty = false;	-- when true shorten the display of difficulty.
local toggleButtonLabel = 0;	-- cycles from 0 to 3, each displays a slightly different label on the button.
local switchLeftClickMode = 0; 	-- 0 = rotate label display, 1 = leftclick toggling hiding/showing of npc names.
local namesHidden = false;		-- used to avoid saving name display info if currently all names toggled to hidden values.
local dvDisplayResetIn = true;	-- display 'reset in' text on alts' lockouts.

local numSavedInstances = 0;
local currentPlayer = UnitName('player');	-- name of the logged-in Alt.
local currentRealm = GetRealmName();		-- current Realm we're on.

local debugTitanRaidIDs = 0;

-- vars to hold current settings on what names are visible and what names are hidden,  1 is on, 0 is off
local trUnitNameNPC = 1;
local trUnitNameNonCombatCreatureName = 0;

local trUnitNameFriendlyPlayerName = 1;
local trUnitNameFriendlyPetName = 0;
local trUnitNameFriendlyGuardianName = 0;
local trUnitNameFriendlyTotemName = 0;

local trUnitNameEnemyPlayerName = 1;
local trUnitNameEnemyPetName = 1;
local trUnitNameEnemyGuardianName = 0;
local trUnitNameEnemyTotemName = 0;

function TitanPanelRaidIDsButton_OnLoad(this)
	this.registry = {
		id = "RaidIDs",
		menuText = TITAN_RAIDIDS_MENU_TEXT,
		buttonTextFunction = "TitanPanelRaidIDsButton_GetButtonText",
		tooltipTitle = TITAN_RAIDIDS_TOOLTIP,
		tooltipCustomFunction = TitanPanelRaidIDsButton_SetTooltipText,
		icon = iconUsed,
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowCompView = 0,		-- 0 = shows default window style
			ShowShortDiff = false,	-- when true, display shortened difficulty.
			bLabelSelect = 0,		-- 1 = Show prefix + currentPlayer 	||  values range from 0 to 3
			toggleClkMode = 0,  	-- 0 = rotate labels on button, 1 = toggle npc names being shown or hidden (for screen shots)
			dvShowResetIn = true;
			trsSavedNameInfo = false;
			trsUnitNameNPC = 0,
			trsUnitNameNonCombatCreatureName = 0,
			trsUnitNameFriendlyPlayerName = 0,
			trsUnitNameFriendlyPetName = 0,
			trsUnitNameFriendlyGuardianName = 0,
			trsUnitNameFriendlyTotemName = 0,
			trsUnitNameEnemyPlayerName = 0,
			trsUnitNameEnemyPetName = 0,
			trsUnitNameEnemyGuardianName = 0,
			trsUnitNameEnemyTotemName = 0,
		}
	};
	
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
    this:RegisterEvent("UPDATE_INSTANCE_INFO");
    this:RegisterEvent("PLAYER_LEAVING_WORLD");
    this:RegisterEvent("RAID_INSTANCE_WELCOME");
    
    TitanPanelRaidIDs_UpdateInfo();
end

function TitanPanelRaidIDsButton_OnEvent(self, event, ...)
	if event == "UPDATE_INSTANCE_INFO" then
		numSavedInstances = GetNumSavedInstances();
		TitanPanelRaidIDs_NumIDs();
		TitanPanelRaidIDs_SaveRaids(); 
	else	
    	TitanPanelRaidIDs_UpdateInfo();	   	
	end		
	
	TitanPanelButton_UpdateButton("RaidIDs");	
	TitanPanelButton_UpdateTooltip(); 
end

function TitanPanelRaidIDs_NumIDs()
	local numIDs = 0;
	for i=1, numSavedInstances do
		local name, id, remain, difficulty = GetSavedInstanceInfo(i);
		if (remain > 0) then
			numIDs = numIDs + 1;
		end	
	end
	numSavedInstances = numIDs;
	-- tagging onto this function, every sensible place I tried to read saved data from fails
	-- all I get is nil values, which is useless, and reading this info mid display function, 
	-- while it works, makes it lag, won't update until you mouse out, and back over button, lame.
	if firstRunLoadedSettings == 0 then
		toggleButtonLabel = TitanGetVar(RAIDIDS_ID, "bLabelSelect");
		compactView = TitanGetVar(RAIDIDS_ID, "ShowCompView");
		switchLeftClickMode = TitanGetVar(RAIDIDS_ID, "toggleClkMode");
		shortDifficulty = TitanGetVar(RAIDIDS_ID, "ShowShortDiff");			-- if value is false it returns nil, evil titanpanel!
		dvDisplayResetIn = TitanGetVar(RAIDIDS_ID, "dvShowResetIn");
		if shortDifficulty == nil then
			shortDifficulty = false;
		end
		if dvDisplayResetIn == nil then
			dvDisplayResetIn = false;
		end
		
		local isNameInfoSaved = TitanGetVar(RAIDIDS_ID, "trsSavedNameInfo");
		if ( isNameInfoSaved == false or isNameInfoSaved == nil ) then
			UpdateNameDisplayInfo();			
		else
			-- load saved name display values to local vars
			trUnitNameNPC = TitanGetVar(RAIDIDS_ID, "trsUnitNameNPC");
			trUnitNameNonCombatCreatureName = TitanGetVar(RAIDIDS_ID, "trsUnitNameNonCombatCreatureName");
			trUnitNameFriendlyPlayerName = TitanGetVar(RAIDIDS_ID, "trsUnitNameFriendlyPlayerName");
			trUnitNameFriendlyPetName = TitanGetVar(RAIDIDS_ID, "trsUnitNameFriendlyPetName");
			trUnitNameFriendlyGuardianName = TitanGetVar(RAIDIDS_ID, "trsUnitNameFriendlyGuardianName");
			trUnitNameFriendlyTotemName = TitanGetVar(RAIDIDS_ID, "trsUnitNameFriendlyTotemName");
			trUnitNameEnemyPlayerName = TitanGetVar(RAIDIDS_ID, "trsUnitNameEnemyPlayerName");
			trUnitNameEnemyPetName = TitanGetVar(RAIDIDS_ID, "trsUnitNameEnemyPetName");
			trUnitNameEnemyGuardianName = TitanGetVar(RAIDIDS_ID, "trsUnitNameEnemyGuardianName");
			trUnitNameEnemyTotemName = TitanGetVar(RAIDIDS_ID, "trsUnitNameEnemyTotemName");
		end
		
		firstRunLoadedSettings = 1;	--only reading config data into variables once per session.
	end
end

function UpdateNameDisplayInfo()
	-- this is only run _IF_ the player hasn't hid any names from this addon's name toggle function.
	-- otherwise it would just update and save the values that hide all names, which isn't intended.
	
	-- read current name display values.
	if namesHidden == false then
		trUnitNameNPC = GetCVar("UnitNameNPC");
		trUnitNameNonCombatCreatureName = GetCVar("UnitNameNonCombatCreatureName");
		trUnitNameFriendlyPlayerName = GetCVar("UnitNameFriendlyPlayerName");
		trUnitNameFriendlyPetName = GetCVar("UnitNameFriendlyPetName");
		trUnitNameFriendlyGuardianName = GetCVar("UnitNameFriendlyGuardianName");
		trUnitNameFriendlyTotemName = GetCVar("UnitNameFriendlyTotemName");
		trUnitNameEnemyPlayerName = GetCVar("UnitNameEnemyPlayerName");
		trUnitNameEnemyPetName = GetCVar("UnitNameEnemyPetName");
		trUnitNameEnemyGuardianName = GetCVar("UnitNameEnemyGuardianName");
		trUnitNameEnemyTotemName = GetCVar("UnitNameEnemyTotemName");
		-- save them for later reference/use.
		TitanSetVar(RAIDIDS_ID, "trsUnitNameNPC", trUnitNameNPC);
		TitanSetVar(RAIDIDS_ID, "trsUnitNameNonCombatCreatureName", trUnitNameNonCombatCreatureName);
		TitanSetVar(RAIDIDS_ID, "trsUnitNameFriendlyPlayerName", trUnitNameFriendlyPlayerName);
		TitanSetVar(RAIDIDS_ID, "trsUnitNameFriendlyPetName", trUnitNameFriendlyPetName);
		TitanSetVar(RAIDIDS_ID, "trsUnitNameFriendlyGuardianName", trUnitNameFriendlyGuardianName);
		TitanSetVar(RAIDIDS_ID, "trsUnitNameFriendlyTotemName", trUnitNameFriendlyTotemName);
		TitanSetVar(RAIDIDS_ID, "trsUnitNameEnemyPlayerName", trUnitNameEnemyPlayerName);
		TitanSetVar(RAIDIDS_ID, "trsUnitNameEnemyPetName", trUnitNameEnemyPetName);
		TitanSetVar(RAIDIDS_ID, "trsUnitNameEnemyGuardianName", trUnitNameEnemyGuardianName);
		TitanSetVar(RAIDIDS_ID, "trsUnitNameEnemyTotemName", trUnitNameEnemyTotemName);
		TitanSetVar(RAIDIDS_ID, "trsSavedNameInfo", true);
	end
end

function TitanPanelRaidIDsButton_OnClick(self, button)
	if ( button == "LeftButton" ) then
		if switchLeftClickMode == 0 then
			--[[
			0 = default "Raid IDs:"
			1 = prefixPlayerName + currentPlayer
			2 = just currentPlayer
			3 = just prefixPlayerName
			]]--
			if toggleButtonLabel < 3 then
				toggleButtonLabel = toggleButtonLabel + 1;
			else -- 3+ gets set to zero
				toggleButtonLabel = 0
			end
			TitanSetVar(RAIDIDS_ID, "bLabelSelect", toggleButtonLabel);
			TitanPanelButton_UpdateButton("RaidIDs");
		elseif switchLeftClickMode == 1 then
			-- toggle hide/show of NPC + misc other names.
			local hideNpcNames = GetCVar("UnitNameNPC");	-- NPC Names.
			if hideNpcNames == "0" then						-- if NPC Names is off,
				SetCVar("UnitNameNPC", trUnitNameNPC);		-- restore saved values
				SetCVar("UnitNameNonCombatCreatureName", trUnitNameNonCombatCreatureName);
				SetCVar("UnitNameFriendlyPlayerName", trUnitNameFriendlyPlayerName);
				SetCVar("UnitNameFriendlyPetName", trUnitNameFriendlyPetName);
				SetCVar("UnitNameFriendlyGuardianName", trUnitNameFriendlyGuardianName);
				SetCVar("UnitNameFriendlyTotemName", trUnitNameFriendlyTotemName);
				SetCVar("UnitNameEnemyPlayerName", trUnitNameEnemyPlayerName);
				SetCVar("UnitNameEnemyPetName", trUnitNameEnemyPetName);
				SetCVar("UnitNameEnemyGuardianName", trUnitNameEnemyGuardianName);
				SetCVar("UnitNameEnemyTotemName", trUnitNameEnemyTotemName);
				SetCVar("UnitNameNPC", trUnitNameNPC);
				namesHidden = false;
			else											-- if NPC Names is on
				SetCVar("UnitNameNPC", 0);					-- turn them all off.
				SetCVar("UnitNameNonCombatCreatureName", 0);
				SetCVar("UnitNameFriendlyPlayerName", 0);
				SetCVar("UnitNameFriendlyPetName", 0);
				SetCVar("UnitNameFriendlyGuardianName", 0);
				SetCVar("UnitNameFriendlyTotemName", 0);
				SetCVar("UnitNameEnemyPlayerName", 0);
				SetCVar("UnitNameEnemyPetName", 0);
				SetCVar("UnitNameEnemyGuardianName", 0);
				SetCVar("UnitNameEnemyTotemName", 0);
				SetCVar("UnitNameNPC", 0);
				namesHidden = true;
			end
		end
	end
end

function TitanPanelRaidIDsButton_GetButtonText(id)
	local id = TitanUtils_GetButton(id, true);
	local currentPlayer_label = "";
	--[[
		0 = default "Raid IDs:"
		1 = prefixPlayerName + currentPlayer
		2 = just currentPlayer
		3 = just prefixPlayerName
	]]--
	if toggleButtonLabel == 0 then
		currentPlayer_label = TITAN_RAIDIDS_BUTTON_LABEL;
	elseif toggleButtonLabel == 1 then
		currentPlayer_label = prefixPlayerName .. currentPlayer .. ": ";
	elseif toggleButtonLabel == 2 then
		currentPlayer_label = currentPlayer .. ": ";
	elseif toggleButtonLabel == 3 then
		currentPlayer_label = prefixPlayerName;
	end	
	return currentPlayer_label, TitanUtils_GetGreenText(numSavedInstances);
end

function TitanPanelRightClickMenu_PrepareRaidIDsMenu()
	local info = {};
	
	-- menu item: Lockout View style.
	local tmpShowView = false;
	if compactView == 0 then
		tmpShowView = false;	-- was using Default view.
	elseif compactView == 1 then
		tmpShowView = true;		-- was using Compact view.
	end
	info.text = TITAN_RAIDIDS_OPTION_VIEW;		-- "Use Compact View"
		info.value = tmpShowView;
		info.checked = tmpShowView;
		info.func = function()
			TitanPanelRightClickMenu_ToggleVar(info.checked);
			if tmpShowView == false then
				compactView = 1;	-- use Compact View.
			else
				compactView = 0;	-- use Default view.
			end
			TitanSetVar(RAIDIDS_ID, "ShowCompView", compactView);
		end
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info);
	
	-- menu item: Enable/Disable condensed info.
	local tmpShowShortDiff = false;
	if shortDifficulty == false then
		tmpShowShortDiff = false;			-- was using long diff view.
	elseif shortDifficulty == true then
		tmpShowShortDiff = true;			-- was using short diff view.
	end
	info.text = TITAN_RAIDIDS_OPTION_INFO;	-- "Use condensed info"
		info.value = tmpShowShortDiff;
		info.checked = tmpShowShortDiff;
		info.func = function()
			TitanPanelRightClickMenu_ToggleVar(info.checked);
			if tmpShowShortDiff == false then
				shortDifficulty = true;		-- use short diff view.
			else
				shortDifficulty = false;	-- use long diff view.
			end
			TitanSetVar(RAIDIDS_ID, "ShowShortDiff", shortDifficulty);
		end
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info);
	
	-- menu item: Enable/Disable Reset in text on default view.
	local tmpDisplayResetIn = true;
	if dvDisplayResetIn == false then
		tmpDisplayResetIn = false;		-- was hiding reset in text.
	else
		tmpDisplayResetIn = true;		-- was showing reset in text.
	end
	info.text = TITAN_RAIDIDS_OPTION_RESETIN;	-- "Show 'Reset in' on default view"
		info.value = tmpDisplayResetIn;
		info.checked = tmpDisplayResetIn;
		info.func = function()
			TitanPanelRightClickMenu_ToggleVar(info.checked);
			if tmpDisplayResetIn == false then
				dvDisplayResetIn = true;	-- display reset in text.
			else
				dvDisplayResetIn = false;	-- hide reset in text.
			end
			TitanSetVar(RAIDIDS_ID, "dvShowResetIn", dvDisplayResetIn);
		end
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info);
	
	-- middle position default RC menu options for titanpanel elements.
    TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddToggleIcon(RAIDIDS_ID);
    TitanPanelRightClickMenu_AddToggleLabelText(RAIDIDS_ID);
	TitanPanelRightClickMenu_AddSpacer();
	
	-- menu item: Left Click action.
	local tmpEnableHideNpcNames = false;
	if switchLeftClickMode == 0 then	
		tmpEnableHideNpcNames = false;		-- was rotating button label styles.
	elseif switchLeftClickMode == 1 then
		tmpEnableHideNpcNames = true;		-- was hiding/showing Npc Names.
	end
	info = {};		-- reset to re-use.
	info.text = TITAN_RAIDIDS_OPTION_LEFTCLICK;		-- "LeftClick = Hide/Show Npc Names"
		info.value = tmpEnableHideNpcNames;
		info.checked = tmpEnableHideNpcNames;
		info.func = function()
			TitanPanelRightClickMenu_ToggleVar(info.checked);
			if tmpEnableHideNpcNames == false then
				switchLeftClickMode = 1; --enables hide/show npc names with leftclick.
			else
				switchLeftClickMode = 0; --enables rotating label text for button with leftclick.
			end
			TitanSetVar(RAIDIDS_ID, "toggleClkMode", switchLeftClickMode);
		end
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info);
		
	-- menu item: Update! [ Stored Name settings] (upon clicking this)
	info = {};		-- reset to re-use.
	info.text = GREEN_NEON_COLOR .. TITAN_RAIDIDS_OPTION_UPDATE .. END_COLOR .. TITAN_RAIDIDS_OPTION_STORED;
		info.checked = false;
		info.func = UpdateNameDisplayInfo();
		info.keepShownOnClick = 0;
		UIDropDownMenu_AddButton(info);
end

function TitanPanelRaidIDs_SaveRaids()
	if debugTitanRaidIDs == 1 then print("Saving Raid-IDs..."); end
	if TitanPanelRaidIDs_Storage == nil then
		TitanPanelRaidIDs_Storage = {};
	end
	if numSavedInstances > 0 then
		if TitanPanelRaidIDs_Storage[currentRealm] == nil then
			TitanPanelRaidIDs_Storage[currentRealm] = {};
		end	
		TitanPanelRaidIDs_Storage[currentRealm][currentPlayer] = {};
		TitanPanelRaidIDs_Storage[currentRealm][currentPlayer].savingTime = time();
		
		local saveThis = false;		-- only set to true when info we want to save is present.
		for i=1, numSavedInstances do
			local name, id, remain, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(i);
			local instStr = name;
			local shortNameVersion = name;
			local encounterInfoLong = " - [" .. encounterProgress .. "/" .. numEncounters .. "]";
			local encounterInfoShort = "  [" .. encounterProgress .. "/" .. numEncounters .. "]";
			if isRaid == true then
				-- catch raids and set them up to save first.
				-- show bosses slain / total boss count appended to difficultyName.
				if difficultyName ~= nil then
					-- 40m Blackwing Lair raid gets filtered to here, it has a filled-out difficultyName value too.
					-- difficultyName contains raid maxPlayers value and difficulty value, with built-in game localization applied.
					instStr = instStr .. " - " .. difficultyName .. encounterInfoLong;
					if difficulty > 1 then
						-- heroic difficulty raid
						shortNameVersion = shortNameVersion .. padDots .. shortRaid .. maxPlayers;
					else
						-- regular difficulty raid
						shortNameVersion = shortNameVersion .. padDots .. shortRaid .. maxPlayers .. encounterInfoShort;
					end
					saveThis = true;
				else
					-- lacked difficultyName info
					instStr = instStr .. " - " .. "missing diffName" .. encounterInfo;
					saveThis = true;
				end
				saveThis = true;
			else	-- not a raid, check for 5 man hero lockout
				if difficulty > 1 then	-- works like a hero instance / raid instance check, saving data only if one of those.
										-- Wrong.  It catches hero 5 mans, it may (need to test) catch northrend raids.
										-- it doesn't catch original wow raids, might catch or miss BC raids.
					instStr = instStr .. " - " .. difficultyName .. " ";
					shortNameVersion = shortNameVersion .. padDots .. maxPlayers;
					saveThis = true;
				end
			end
			if saveThis == true then
				if TitanPanelRaidIDs_Storage[currentRealm][currentPlayer][id] == nil then
					TitanPanelRaidIDs_Storage[currentRealm][currentPlayer][id] = {};
				end
				-- original saved info.
				TitanPanelRaidIDs_Storage[currentRealm][currentPlayer][id].name = instStr;
				TitanPanelRaidIDs_Storage[currentRealm][currentPlayer][id].remaining = remain;
				-- New values that are recorded.
				TitanPanelRaidIDs_Storage[currentRealm][currentPlayer][id].nameShort = shortNameVersion;
				TitanPanelRaidIDs_Storage[currentRealm][currentPlayer][id].instanceTag = name;	-- instance/raid name.
				TitanPanelRaidIDs_Storage[currentRealm][currentPlayer][id].isRaid = isRaid;
				TitanPanelRaidIDs_Storage[currentRealm][currentPlayer][id].maxPlayers = maxPlayers;
				TitanPanelRaidIDs_Storage[currentRealm][currentPlayer][id].difficulty = difficulty;
				TitanPanelRaidIDs_Storage[currentRealm][currentPlayer][id].difficultyName = difficultyName;	--localized string
				TitanPanelRaidIDs_Storage[currentRealm][currentPlayer][id].numEncounters = numEncounters;
				TitanPanelRaidIDs_Storage[currentRealm][currentPlayer][id].encounterProgress = encounterProgress;
				-- reset saveThis for next pass.
				saveThis = false;
			end
		end
	end
end

function TitanPanelRaidIDs_UpdateInfo()
    -- refresh the list of Raid-IDs
	RequestRaidInfo();    
end

function TitanPanelRaidIDsButton_OnEnter()
	TitanPanelRaidIDs_UpdateInfo();
end

function TitanPanelRaidIDsButton_SetTooltipText()
    -- Tooltip title
	GameTooltip:SetText(TITAN_RAIDIDS_TOOLTIP, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	
	-- default view
	if compactView == 0 then
		GameTooltip:AddLine(" ");
		defaultMainLockoutCode = true; -- some adjustments made for default view Main's lockouts display.
		for i=1, numSavedInstances do
			local name, id, remain, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(i);
			-- name is whatever the instance/raid is called
			local instStr = name;
			local shortNameVersion = name;
			local encounterInfoLong = " - [" .. encounterProgress .. "/" .. numEncounters .. "]";
			local encounterInfoShort = "  [" .. encounterProgress .. "/" .. numEncounters .. "]";
			-- catch raids to display first.
			if isRaid == true then
				if difficultyName ~= nil then
					-- 40m Blackwing Lair raid gets filtered to here, it has a filled-out difficultyName value too.
					instStr = instStr .. " - " .. difficultyName .. encounterInfoLong;
					if difficulty > 1 then
						-- heroic difficulty raid
						shortNameVersion = shortNameVersion .. padDots .. shortRaid .. maxPlayers;
					else
						-- regular difficulty raid
						shortNameVersion = shortNameVersion .. padDots .. shortRaid .. maxPlayers .. encounterInfoShort;
					end
					if remain > 0 then
						if shortDifficulty == false then
							-- display long difficulty localized string.
							GameTooltip:AddDoubleLine(color_defaultMainRaidLockout .. instStr .. END_COLOR, GRAY_DARK_COLOR .. id .. END_COLOR);
						else
							-- display shortened difficulty.
							if difficulty > 1 then
								-- hero raid gets marked with '+'.
								GameTooltip:AddDoubleLine(color_defaultMainRaidLockout .. shortNameVersion .. END_COLOR .. shortHeroic .. color_defaultMainRaidLockout .. encounterInfoShort .. END_COLOR, GRAY_DARK_COLOR .. id .. END_COLOR);
							else
								-- normal raid gets no special mark.
								GameTooltip:AddDoubleLine(color_defaultMainRaidLockout .. shortNameVersion .. END_COLOR, GRAY_DARK_COLOR .. id .. END_COLOR);
							end
						end
						GameTooltip:AddLine(" " .. TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain));
						GameTooltip:AddLine(" ");
					end
				end
			end
		end
		for i=1, numSavedInstances do
			local name, id, remain, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(i);
			-- name is whatever the instance/raid is called
			local instStr = name;
			local shortNameVersion = name;
			if isRaid == false then
				if difficulty > 1 then
					instStr = instStr .. " - " .. difficultyName .. " ";
					shortNameVersion = color_defaultMainLockout .. shortNameVersion .. padDots .. maxPlayers .. END_COLOR .. shortHeroic;
					if remain > 0 then
						if shortDifficulty == false then
							GameTooltip:AddDoubleLine(color_defaultMainLockout .. instStr .. END_COLOR, GRAY_DARK_COLOR .. id .. END_COLOR);
						else
							GameTooltip:AddDoubleLine(shortNameVersion, GRAY_DARK_COLOR .. id .. END_COLOR);
						end
						GameTooltip:AddLine(" " .. TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain));
						GameTooltip:AddLine(" ");
					end
				end
			end
		end
		defaultMainLockoutCode = false;
	else
		-- compact view, slightly different header setup.
		GameTooltip:AddDoubleLine(" ", WHITE_BRIGHT_COLOR .. "[  " .. TITAN_RAIDIDS_COOLDOWN_INFO[1] .. "  ]     " .. END_COLOR);
		GameTooltip:AddDoubleLine(compactLineBreak, compactLineBreak);
	end
	
	if TitanPanelRaidIDsButton_tcount(TitanPanelRaidIDs_Storage[currentRealm]) > 1 then		
		TitanPanelRaidIDsButton_LoadAltsIDs()
	end
end

function TitanPanelRaidIDsButton_LoadAltsIDs()
	showLine_AltAboveHasRaids = true; -- reset before displaying lockouts.
	if compactView == 0 then
		for name, raids in pairs(TitanPanelRaidIDs_Storage[currentRealm]) do
			if name ~= currentPlayer then
				TitanPanelRaidIDsButton_ShowAltRaids(name, raids);
			end
		end
	else
		-- display current logged-in character's lockouts just like Alts' lockouts are displayed.
		-- except now, display current logged-in player's lockouts first in the tooltip list.
		for name, raids in pairs(TitanPanelRaidIDs_Storage[currentRealm]) do
			if name == currentPlayer then
				ignoreMain = false;  -- reset check, this is just so 'Empty..' isn't duplicated on Alt pass of lockouts.
				TitanPanelRaidIDsButton_ShowAltRaids(name, raids);
			end
		end
		for name, raids in pairs(TitanPanelRaidIDs_Storage[currentRealm]) do
			if name ~= currentPlayer then
				TitanPanelRaidIDsButton_ShowAltRaids(name, raids);
			end
		end
	end
end

function TitanPanelRaidIDsButton_ShowAltRaids(name, raids)
	local countRaids = 0;
	if compactView == 0 then
		-- display default view of Alt Lockouts.
		if showLine_AltAboveHasRaids == true then
			GameTooltip:AddLine(defaultLineBreak); 
		else -- if false, we only want to skip the dash line  once, so the value is toggled here.
			showLine_AltAboveHasRaids = true;
		end
		GameTooltip:AddLine(color_defaultAltName .. name .. END_COLOR);
		GameTooltip:AddLine(defaultLineBreak);
		for id, raid in pairs(raids) do
			if tonumber(id) and (raids.savingTime + raid.remaining) > time() then
				if raid.isRaid == true then -- this check doesn't work if happens before 'tonumber' check.
											-- no idea why and that's not good.  It's like the IF check 
											-- changes or prepares the data to be read...
					local endTime = raids.savingTime + raid.remaining;
					local remain = endTime - time();
					if shortDifficulty == false then
						GameTooltip:AddDoubleLine(color_defaultAltRaidLockout .. raid.name .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain));
					else
						if raid.nameShort ~= nil then
							if raid.difficulty > 1 then
								local encounterInfoShort = "  [" .. raid.encounterProgress .. "/" .. raid.numEncounters .. "]";
								GameTooltip:AddDoubleLine(color_defaultAltRaidLockout .. raid.nameShort .. END_COLOR .. shortHeroic .. END_COLOR .. color_defaultAltRaidLockout .. encounterInfoShort .. END_COLOR .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain));
							else
								GameTooltip:AddDoubleLine(color_defaultAltRaidLockout .. raid.nameShort .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain));
							end
						else
							-- early run with new version, short diff version strings not created yet, use long diff display until those are created.
							GameTooltip:AddDoubleLine(color_defaultAltRaidLockout .. raid.name .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain));
						end
					end
					countRaids = countRaids + 1;
				end
			end
		end
		for id, raid in pairs(raids) do
			if tonumber(id) and (raids.savingTime + raid.remaining) > time() then
				if raid.isRaid == false then
					local endTime = raids.savingTime + raid.remaining;
					local remain = endTime - time();
					if shortDifficulty == false then
						GameTooltip:AddDoubleLine(color_defaultAltLockout .. raid.name .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain));
					else
						if raid.nameShort ~= nil then
							GameTooltip:AddDoubleLine(color_defaultAltLockout .. raid.nameShort .. END_COLOR .. shortHeroic .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain));
						else
							-- early run with new version, short diff version strings not created yet, use long diff display until those are created.
							GameTooltip:AddDoubleLine(color_defaultAltLockout .. raid.name .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain));
						end
					end
					countRaids = countRaids + 1;
				end
			end
		end
		if countRaids < 1 then
			showLine_AltAboveHasRaids = false;
		end
	else
		-- Compact listing of lockouts.
		if name ~= currentPlayer then
			-- color Alt names as usual.
			if showLine_AltAboveHasRaids == true then
				GameTooltip:AddLine(compactLineBreak); 
			else -- if false, we only want to skip the dash line  once, so the value is toggled here.
				showLine_AltAboveHasRaids = true;
			end
			GameTooltip:AddLine(color_compactAltName .. border_compactAltName_left .. name .. border_compactAltName_right .. END_COLOR);
			--GameTooltip:AddLine("--------------------------");		-- used to show dash line below name's lockouts, 
												-- but compact view shouldn't waste space on tooltip display.
		end
		for id, raid in pairs(raids) do
			if tonumber(id) and (raids.savingTime + raid.remaining) > time() then
				if raid.isRaid == true then
					local endTime = raids.savingTime + raid.remaining;
					local remain = endTime - time();
					if name ~= currentPlayer then
						-- colors Alt lockouts different from logged-in character.
						if shortDifficulty == false then
							GameTooltip:AddDoubleLine(color_compactAltRaidLockout .. raid.name .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain) .. END_COLOR);
						else
							if raid.nameShort ~= nil then
								if raid.difficulty > 1 then
									local encounterInfoShort = "  [" .. raid.encounterProgress .. "/" .. raid.numEncounters .. "]";
									GameTooltip:AddDoubleLine(color_compactAltRaidLockout .. raid.nameShort .. END_COLOR .. shortHeroic .. END_COLOR .. color_compactAltRaidLockout .. encounterInfoShort .. END_COLOR .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain));
								else
									GameTooltip:AddDoubleLine(color_compactAltRaidLockout .. raid.nameShort .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain) .. END_COLOR);
								end
							else
								-- early run with new version, short diff version strings not created yet, use long diff display until those are created.
								GameTooltip:AddDoubleLine(color_compactAltRaidLockout .. raid.name .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain) .. END_COLOR);
							end
						end
					else
						-- colors logged-in character's lockouts different from Alts.
						if shortDifficulty == false then
							GameTooltip:AddDoubleLine(color_compactMainRaidLockout .. raid.name .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain) .. END_COLOR);
						else
							if raid.nameShort ~= nil then
								if raid.difficulty > 1 then
									local encounterInfoShort = "  [" .. raid.encounterProgress .. "/" .. raid.numEncounters .. "]";
									GameTooltip:AddDoubleLine(color_compactMainRaidLockout .. raid.nameShort .. END_COLOR .. shortHeroic .. END_COLOR .. color_compactMainRaidLockout .. encounterInfoShort .. END_COLOR .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain));
								else
									GameTooltip:AddDoubleLine(color_compactMainRaidLockout .. raid.nameShort .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain) .. END_COLOR);
								end
							else
								-- early run with new version, short diff version strings not created yet, use long diff display until those are created.
								GameTooltip:AddDoubleLine(color_compactMainRaidLockout .. raid.name .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain) .. END_COLOR);
							end
						end
					end
				end
			elseif ignoreMain == false then
				if name == currentPlayer then
					if numSavedInstances < 1 then
						showLine_AltAboveHasRaids = false;
					end
					ignoreMain = true;
				end
			end
		end
		for id, raid in pairs(raids) do
			if tonumber(id) and (raids.savingTime + raid.remaining) > time() then
				if raid.isRaid == false then
					local endTime = raids.savingTime + raid.remaining;
					local remain = endTime - time();
					if name ~= currentPlayer then
						-- colors Alt lockouts different from logged-in character.
						if shortDifficulty == false then
							GameTooltip:AddDoubleLine(color_compactAltLockout .. raid.name .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain) .. END_COLOR);
						else
							if raid.nameShort ~= nil then
								GameTooltip:AddDoubleLine(color_compactAltLockout .. raid.nameShort .. END_COLOR .. shortHeroic .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain) .. END_COLOR);
							else
								-- early run with new version, short diff version strings not created yet, use long diff display until those are created.
								GameTooltip:AddDoubleLine(color_compactAltLockout .. raid.name .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain) .. END_COLOR);
							end
						end
					else
						-- colors logged-in character's lockouts different from Alts.
						if shortDifficulty == false then
							GameTooltip:AddDoubleLine(color_compactMainLockout .. raid.name .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain) .. END_COLOR);
						else
							if raid.nameShort ~= nil then
								GameTooltip:AddDoubleLine(color_compactMainLockout .. raid.nameShort .. END_COLOR .. shortHeroic .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain) .. END_COLOR);
							else
								-- early run with new version, short diff version strings not created yet, use long diff display until those are created.
								GameTooltip:AddDoubleLine(color_compactMainLockout .. raid.name .. padSpace .. END_COLOR, TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(remain) .. END_COLOR);
							end
						end
					end
				end
			elseif ignoreMain == false then
				if name == currentPlayer then
					if numSavedInstances < 1 then
						showLine_AltAboveHasRaids = false;
					end
					ignoreMain = true;
				end
			end
		end
	end
end

function TitanPanelRaidIDsButton_GetRemainingInstanceTimeText(seconds)
	local days = floor(seconds / 86400);
	seconds = seconds - days * 86400;
	local hours = floor(seconds / 3600);
	seconds = seconds - hours * 3600;
	local minutes = floor(seconds / 60);
	seconds = seconds - minutes * 60;
	local TIME_COLOR = "";
	local TIME_TEXT = "";
	local timeStr = " ";		-- one space just to pad slightly vs being too close to raid/instance name string.
	
	if compactView == 0 then
		-- default view's colors.
		-- uses 'Reset in' prefix (unless disabled in RC menu).
		if dvDisplayResetIn == true then
			timeStr = timeStr .. color_defaultResetIn .. TITAN_RAIDIDS_COOLDOWN_INFO[1] .. END_COLOR .. " ";
		end
		TIME_COLOR = color_defaultTime;
		TIME_TEXT = color_defaultTimeText;
	else 
		-- compact view's colors.
		-- moved "Reset in" text so that it's now above lockout time.
		TIME_COLOR = color_compactTime;
		TIME_TEXT = color_compactTimeText;
	end
	
	if days > 0 then
		-- pad by 1 space in case of super long raid/instance names.
		timeStr = timeStr .. TIME_COLOR .. days .. TIME_TEXT .. " " .. TITAN_RAIDIDS_COOLDOWN_INFO[2] .. END_COLOR .. " ";
	else
		-- to test days look when I'm not locked to a weekly raid.
		-- disable before posting this to curse.com.
		--timeStr = timeStr .. TIME_COLOR .. "5" .. TIME_TEXT .. " " .. TITAN_RAIDIDS_COOLDOWN_INFO[2] .. END_COLOR .. " ";
		-- 
		-- not test code.
		-- pad lockouts if it looks bad for all except defaultMainLockoutCode
		--[[
		if defaultMainLockoutCode ~= true then
			timeStr = padLockout .. timeStr;
		end
		]]--
	end
	
	if hours > 0 then
		timeStr = timeStr .. TIME_COLOR .. hours .. TIME_TEXT .. " " .. TITAN_RAIDIDS_COOLDOWN_INFO[3] .. END_COLOR .. " ";
	end
	if minutes then 
		timeStr = timeStr .. TIME_COLOR .. minutes .. TIME_TEXT .. " " .. TITAN_RAIDIDS_COOLDOWN_INFO[4] .. END_COLOR .. " ";
	end
	-- if you really want to see lockout seconds, uncomment the next 3 lines.
	--if seconds > 0 then
		--timeStr = timeStr .. TIME_COLOR .. seconds .. TIME_TEXT .. " " .. TITAN_RAIDIDS_COOLDOWN_INFO[5] .. END_COLOR;
	--end

	return timeStr;
end

-- tcount: count table members even if they're not indexed by numbers
function TitanPanelRaidIDsButton_tcount(tab)
	local n=0;
	if not tab then
		return 0 
	end
	for _ in pairs(tab) do
		n=n+1;
	end
	return n;
end 

function DebugToChatLog(msg)
	-- look up this API call and find out what parameters it takes.
	-- want to use this to track var values at different spots in the 
	-- code to make sure crazy odd things aren't happening, and to help
	-- when things you thought would work fail oddly and badly, to learn why.
    DEFAULT_CHAT_FRAME:AddMessage(msg, 1, 1, 1);
end