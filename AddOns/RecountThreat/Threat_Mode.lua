--[[
  Name: Recount Threat Module
  Heavily based on: Artiarc's SingleTarget.lua of Omen2 and Omen3 (Xinhuan?)
  Author: Antiarc (original), Elsia (modified plagirism)
  License: Don't use unless you asked Antiarc and Xinhuan and bribed him with 1-2 headless chickens, or in other words the same license as Omen2 and Omen3
]]

if not Recount then return end --  Forget about this if no Recount is present

local Recount = Recount

local RecountThreat = LibStub("AceAddon-3.0"):NewAddon("RecountThreat", "AceEvent-3.0", "AceTimer-3.0","AceConsole-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

-- Upvalues now take MOP compatibility into account
local GetNumRaidMembers = GetNumRaidMembers or GetNumGroupMembers
local GetNumPartyMembers = GetNumPartyMembers or GetNumSubgroupMembers

local oldmode = Recount.db.profile.MainWindowMode
local threatmode

local timers = {}
local math_abs = _G.math.abs
local L = LibStub("AceLocale-3.0"):GetLocale("RecountThreat")
--local L = LibStub("AceLocale-3.0"):GetLocale("RecountThreat")
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitIsPlayer = _G.UnitIsPlayer
local UnitPlayerControlled = _G.UnitPlayerControlled
local math_floor = _G.math.floor
local lastTargetSwitchTime = 0

RecountThreat.Version = tonumber(string.sub("$Revision: 64 $", 12, -3))

-- threat and GUID upvalues
local aggroThreat, aggroUnit, aggroGUID = 0, nil, "targettarget", nil
local hostileGUID, hostileUnit = nil, "target"
local threatUpdatedAt = 0

local members = 0;
local prefix;

if not Recount.GetModeIndex then
function Recount:GetModeIndex(modestring)
	for i=1,#Recount.MainWindowData do
		if Recount.MainWindowData[i][1] == modestring or Recount.MainWindowData[i][1] == L[modestring] then
			return i
		end
	end
end

end

local OriginalPutInCombat = Recount.PutInCombat
local OriginalLeaveCombat = Recount.LeaveCombat

function Recount:PutInCombat()
	if Recount.db.profile.togglethreat and Recount.db.profile.MainWindowMode ~= threatmode then
		oldmode = Recount.db.profile.MainWindowMode
		Recount:SetMainWindowMode(threatmode)
		Recount:FullRefreshMainWindow()
	end
	OriginalPutInCombat(self)
end


function Recount:LeaveCombat(time)
	if Recount.db.profile.togglethreat and Recount.db.profile.MainWindowMode == threatmode then
		Recount:SetMainWindowMode(oldmode)
		Recount:FullRefreshMainWindow()
	end

	OriginalLeaveCombat(self,time)
end

local HookedPutInCombat = Recount.PutInCombat
local HookedLeaveCombat = Recount.LeaveCombat


-- global OnInit function, only called once during addon loading
function RecountThreat:OnInitialize()

Recount.consoleOptions2.args.threat = {
			order = 32,
			name = L["Threat"],
			type = 'group',
			desc = L["Configure the Threat Module"],
			args = {
				toggle = {
					name = L["Toggle"],
					desc = L["Toggle Threat Mode when in Combat"],
					type = 'toggle',
			get = function(info) return Recount.db.profile.togglethreat end,
			set = function(info,v)
				Recount.db.profile.togglethreat = v end
				},
			}
		}
		
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("Recount Threat", Recount.consoleOptions2.args.threat)
	
	AceConfigDialog:AddToBlizOptions("Recount Threat", "Threat", "Recount")

end

-- global OnEnable, called everytime the user switches to the Threat Module
function RecountThreat:OnEnable()

	Recount.PutInCombat = HookedPutInCombat
	Recount.LeaveCombat = HookedLeaveCombat

	if not Recount then return end -- No recount found

	-- register callbacks and events
	self:RegisterEvent("UNIT_THREAT_LIST_UPDATE")
	self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("UNIT_TARGET")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED", "CheckParty")
	self:RegisterEvent("RAID_ROSTER_UPDATE", "CheckParty")
--	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	
	-- fill upvalues with meaningful data
	threatUpdatedAt = 0
	threatmode = Recount:GetModeIndex("Threat")
	Recount.ThreatTargetName = "GLOBAL"
	RecountThreat:ResetThreat()

	self:CheckParty()
	self:PLAYER_TARGET_CHANGED()
end

-- global OnDisable
-- unregisters all events and timers in the embeds automatically
function RecountThreat:OnDisable()
	-- unregister Threat callbacks
	
	-- unhook
	Recount.PutInCombat = OriginalPutInCombat
	Recount.LeaveCombat = OriginalLeaveCombat
	
	-- clear timer references so we end up in a clean state
	for k in pairs(timers) do
		timers[k] = nil
	end
end


local function isValidThreatTarget(unit)
	if not UnitExists(unit) or UnitIsPlayer(unit) or UnitPlayerControlled(unit) then
		return false 
	end
	return true
end

function RecountThreat:TargetTargetCheck()
	if not timers.TargetSwitch and UnitGUID(aggroUnit) ~= aggroGUID then
		self:UNIT_TARGET(nil, "target")
	end
end

function RecountThreat:PLAYER_TARGET_CHANGED()
	-- clear upvalues
	hostileGUID = nil
	hostileUnit = nil
	aggroGUID = nil
	aggroThreat = nil

	Recount.NewData = true
	
	-- stop our whacky unit timer
	if timers.TargetTargetCheck then
		self:CancelTimer(timers.TargetTargetCheck, true)
		timers.TargetTargetCheck = nil
	end
	
	-- now check which target to track - first directly "target" 
	if isValidThreatTarget("target") then
		hostileUnit = "target"
		aggroUnit = "targettarget"
	-- or for healers "targettarget"
	elseif isValidThreatTarget("targettarget") then
		hostileUnit = "targettarget"
		aggroUnit = "targettargettarget"
		-- this is a whacky update because we dont get events when our mob changes its target
		timers.TargetTargetCheck = self:ScheduleRepeatingTimer("TargetTargetCheck", 0.5)
	end
	
	-- if we didnt find a valid threat target, then just skip everything
	if not hostileUnit or UnitIsDead(hostileUnit) or not UnitCanAttack(hostileUnit,aggroUnit) or UnitIsPlayer(hostileUnit) then
	        Recount.ThreatTargetName = "GLOBAL"
	        RecountThreat:ResetThreat()
		return
	end
	
	-- get the GUIDs of our stuff
	hostileGUID = UnitGUID(hostileUnit) 
	aggroGUID = UnitGUID(aggroUnit)
	
	-- get the threat of our new target
	aggroThreat = RecountThreat:GetThreat(aggroUnit, hostileUnit) or 0
	--Recount:DPrint("aggro: "..aggroThreat.." "..aggroUnit.." "..hostileUnit)
	-- SetTitle here if needed
	RecountThreat:ResetThreat()
	Recount.ThreatTargetName= UnitName(hostileUnit)
	
	self:UNIT_TARGET(nil, "target")
end

function RecountThreat:ResetThreat()
	if not Recount.db2.combatants then return end

	Recount.NewData = true

	for k,v in pairs(Recount.db2.combatants) do
	   if v.Threat then v.Threat = nil end
	   if v.LastThreat then v.LastThreat = nil end
	   if v.ThreatTime then v.ThreatTime = nil end
	   if v.LastThreatTime then v.LastThreatTime = nil end
	end
	Recount:FullRefreshMainWindow()
end

-- With many thanks to ZThreatMeter some stuff here.

--[[function ZThreatMeter:PLAYER_TARGET_CHANGED()
	if (not UnitIsDead("target") and UnitCanAttack("player", "target") and not UnitIsPlayer("target")) then
		currentTarget = UnitGUID("target");
		self.title:SetText(UnitName("target"));
		ZThreatMeter:GetThreat("target");
	else
		self.title:SetText("ZThreatMeter");
		self:ClearTarget();
	end
end --]]


-- Straight from Omen3
local threatUnitIDFindList = {"target", "targettarget"}
--local threatUnitIDFindList2 = {"focus", "focustarget", "target", "targettarget"}
function RecountThreat:FindThreatMob()
	-- Figure out which mob to show threat on.
	-- It has to be attackable and not human controlled.
--	local t = --[db.UseFocus and threatUnitIDFindList2 or ]  threatUnitIDFindList
	local t = threatUnitIDFindList
	local name, name2
	for i = 1, #t do
		local mob = t[i]
		if UnitExists(mob) then
			name2 = UnitName(mob)
--			guidNameLookup[UnitGUID(mob)] = name2
			if not name then name = name2 end
			if not UnitIsPlayer(mob) and not UnitPlayerControlled(mob) and UnitCanAttack("player", mob) and UnitHealth(mob) > 0 then
				Recount.ThreatTargetName = name2
				hostileUnit = mob
				--Recount:DPrint("Found: "..name2)
				return mob
			end
		end
	end
	Recount.ThreatTargetName = "GLOBAL"
	RecountThreat:ResetThreat()
	hostileUnit = "target"
	
end

function RecountThreat:UNIT_THREAT_SITUATION_UPDATE(...)
	local mymob = RecountThreat:FindThreatMob()
	RecountThreat:GetThreat(mymob);
end


function RecountThreat:UNIT_THREAT_LIST_UPDATE(event, mob)
	if (mob) then
		local mymob = RecountThreat:FindThreatMob()
		RecountThreat:GetThreat(mymob);
	else
		--Recount:DPrint("No Mob Threat")
	end
end

function RecountThreat:CheckParty(event)
	local p = "raid";
	local m = 0;

	m = GetNumRaidMembers();

	if (m == 0) then
		m = GetNumPartyMembers();
		p = "party";
	end

	if (m > 0 and p == "party") then
		m = m + 1;
	elseif (m == 0) then
		m = 1;
		p = nil;
	end

	prefix = p;
	members = m;
	--Recount:DPrint("party: "..(p or "nil").." "..(m or "nil"))
end

--function RecountThreat:PLAYER_REGEN_ENABLED()
--end

function RecountThreat:GetThreat(mob)

	if not mob then mob = hostileUnit end
	
	if not mob then return end
	
	--Recount:DPrint("getting threat: "..(mob or "nil").." "..members)

    for i = 1, members do
    	local unit;
		local pet;

    	if (prefix) then
    		if (prefix == "party" and i == members) then
    			unit = "player";
    		else
    			unit = prefix..i;
    		end
    		pet = prefix.."pet"..i;
    	else
    		unit = "player";
	    	pet = "pet";
    	end

		--Recount:DPrint(unit.." "..mob)
    	local iT, _, sP, rP, tV = UnitDetailedThreatSituation(unit, mob);
		if iT then
			aggroThreat = tV/100
--			Recount:DPrint("it: "..(aggroThreat or "nil"))
		end
		if tV then
			local uname, urealm = UnitName(unit)
			if urealm then
				uname = uname .."-"..urealm -- Fix up cross-realm folks!
			end
			if Recount.db2.combatants and Recount.db2.combatants[uname] then
--					Recount:DPrint("Got threat: "..uname.." "..tV)
			        Recount.db2.combatants[uname].LastThreat = Recount.db2.combatants[uname].Threat
			        Recount.db2.combatants[uname].LastThreatTime = Recount.db2.combatants[uname].ThreatTime
			-- Threat can be negative due to temporary threat reduction effects such as Fade and Mirror Image (-410065408).
			if tV < 0 then
				tV = tV + 410065408 -- Stolen from Omen. Thanks Xinhuan.
--				negativeTable[guid] = true
			end
					
				Recount.db2.combatants[uname].Threat = tV/100
				Recount.db2.combatants[uname].ThreatTime = GetTime()
				--Recount:DPrint("setting thread of "..uname..": "..(tV or "nil"))
			end
		end
		if pet and not Recount.db.profile.MergePets then
            if UnitExists(pet) then
                local iT, _, sP, rP, tV = UnitDetailedThreatSituation(pet, mob);
		if iT then
			aggroThreat = tV/100
--			Recount:DPrint("it: "..(aggroThreat or "nil"))
		end
                if (tV) then
					local uname = UnitName(pet).." <"..UnitName(unit)..">"
					if Recount.db2.combatants and Recount.db2.combatants[uname] then
					        Recount.db2.combatants[uname].LastThreat = Recount.db2.combatants[uname].Threat
						Recount.db2.combatants[uname].LastThreatTime = Recount.db2.combatants[uname].ThreatTime
			if tV < 0 then
				tV = tV + 410065408 -- Stolen from Omen. Thanks Xinhuan.
--				negativeTable[guid] = true
			end
						Recount.db2.combatants[uname].Threat = tV/100
						Recount.db2.combatants[uname].ThreatTime = GetTime()
						--Recount:DPrint("setting thread of "..uname..": "..tV)
					end
                end
            end
		end
    end
end



function RecountThreat:SwitchAggroTarget()
	if not aggroUnit then return end
	local n = UnitName(aggroUnit)
	if n then
		aggroGUID = UnitGUID(aggroUnit)
		lastTargetSwitchTime = GetTime()
	end
	timers.TargetSwitch = nil
end

function RecountThreat:UNIT_TARGET(event, unit)
	-- we only care for data about our current target
	if unit ~= "target" then return end

	Recount.NewData = true
	
	-- logic for targettarget mode
	-- we target another player that didnt have a valid target before, now he switches target 
	if (not hostileUnit and isValidThreatTarget("targettarget")) or (hostileUnit == "targettarget" and hostileGUID ~= UnitGUID(hostileUnit)) then
		self:PLAYER_TARGET_CHANGED()
		return
	end
	if not hostileUnit then return end
	
	-- stop targetswitch timer
	if timers.TargetSwitch then
		self:CancelTimer(timers.TargetSwitch, true)
		timers.TargetSwitch = nil
	end
	-- and start a new timer (only if the target is not casting some spell)
	if not UnitCastingInfo(hostileUnit) or not aggroGUID then
		timers.TargetSwitch = self:ScheduleTimer("SwitchAggroTarget", 0.5)
	end
end

-- Threat Mode stuff

function RecountThreat:DataModesThreat(data)
	
local tps
	tps = 0
--	tps = data.GUID and hostileGUID and Threat:GetTPS(data.GUID, hostileGUID) or 0

	--	local threat = data.GUID and hostileGUID and Threat:GetThreat(data.GUID, hostileGUID) or 0
	local threat = data and data.Threat or 0

        if data.Threat and data.LastThreat and data.ThreatTime and data.LastThreatTime and data.Threat > data.LastThreat and data.ThreatTime > data.LastThreatTime and threat ~= 0 then
	   tps = (data.Threat - data.LastThreat) / (data.ThreatTime - data.LastThreatTime)
	end

	return threat, tps

--	if Recount.InCombat then
--		return (data.Fights[Recount.CurDataSet].Threat or 0), tps
--	end

--	return (data.Fights[Recount.CurDataSet].ThreatNonZero or 0), tps
end

function RecountThreat:SpecialTotalsThreat()
--	if Recount.ThreatActive then
--	Recount:DPrint("st: "..(aggroThreat or "nil"))
	return aggroThreat or 0 -- threat:GetMaxThreatOnTarget(Recount.ThreatTargetGUID)
--	end
--	return 1
end

function RecountThreat:TooltipFuncsThreat(name,data)
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
end

Recount:AddModeTooltip(L["Threat"],RecountThreat.DataModesThreat,RecountThreat.TooltipFuncsThreat,RecountThreat.SpecialTotalsThreat,{"THREAT",L["'s TPS"]}, function() if Recount.ThreatTargetName == "GLOBAL" then return L["Threat"] else return L["Threat on"].." "..Recount.ThreatTargetName end end, "Threat")
