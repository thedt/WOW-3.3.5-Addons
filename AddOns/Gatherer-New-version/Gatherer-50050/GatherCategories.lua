﻿--[[
	Gatherable Nodes, type groupings definitions
	Gatherer Addon for World of Warcraft(tm).
	Version: 5.0.0 (<%codename%>)
	Revision: $Id: GatherCategories.lua 1131 2014-11-13 21:03:23Z esamynn $

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit licence to use this AddOn with these facilities
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat

	Note 2:
		This file is automatically generated from data collected at
		http://www.wowhead.com/
		If you want to help contribute, please go there, get the client
		and upload your data.
		Wowhead Client: http://www.wowhead.com/?client
]]

-- functions needed from the global environment
local pairs = pairs
local type = type
local Gatherer = Gatherer

-- redirect any other variable look ups to look for values
-- in the generated translations table
local Babylonian = LibStub("Babylonian")
assert(Babylonian, "Babylonian is not installed")
local babylonian = Babylonian(GathererLocalizations)
local metatable = { 
	__index = function( tbl, key )
		return babylonian:GetString(key, key)
	end
}
setmetatable( Gatherer.Categories, metatable )
setfenv(1, Gatherer.Categories)


-- Mapping of Object IDs to categories
ObjectCategories = {
	-- Ores
	[324] = "ORE_THORIUM", -- Small Thorium Vein
	[1610] = "ORE_INCENDICITE", -- Incendicite Mineral Vein
	[1731] = "ORE_COPPER", -- Copper Vein
	[1732] = "ORE_TIN", -- Tin Vein
	[1733] = "ORE_SILVER", -- Silver Vein
	[1734] = "ORE_GOLD", -- Gold Vein
	[1735] = "ORE_IRON", -- Iron Deposit
	[2040] = "ORE_MITHRIL", -- Mithril Deposit
	[2047] = "ORE_TRUESILVER", -- Truesilver Deposit
	[2653] = "ORE_BLOODSTONE", -- Lesser Bloodstone Deposit
	[73940] = "ORE_SILVER", -- Ooze Covered Silver Vein
	[73941] = "ORE_GOLD", -- Ooze Covered Gold Vein
	[123309] = "ORE_TRUESILVER", -- Ooze Covered Truesilver Deposit
	[123310] = "ORE_MITHRIL", -- Ooze Covered Mithril Deposit
	[123848] = "ORE_THORIUM", -- Ooze Covered Thorium Vein
	[165658] = "ORE_DARKIRON", -- Dark Iron Deposit
	[175404] = "ORE_RTHORIUM", -- Rich Thorium Vein
	[177388] = "ORE_RTHORIUM", -- Ooze Covered Rich Thorium Vein
	[181555] = "ORE_FELIRON", -- Fel Iron Deposit
	[181556] = "ORE_ADAMANTITE", -- Adamantite Deposit
	[181557] = "ORE_KHORIUM", -- Khorium Vein
	[181569] = "ORE_RADAMANTITE", -- Rich Adamantite Deposit
	[185877] = "ORE_NETHERCITE", -- Nethercite Deposit
	[189978] = "ORE_COBALT", -- Cobalt Deposit
	[189979] = "ORE_RCOBALT", -- Rich Cobalt Deposit
	[189980] = "ORE_SARONITE", -- Saronite Deposit
	[189981] = "ORE_RSARONITE", -- Rich Saronite Deposit
	[191133] = "ORE_TITANIUM", -- Titanium Vein
	[202736] = "ORE_OBSIDIUM", -- Obsidium Deposit
	[202737] = "ORE_PYRITE", -- Pyrite Deposit
	[202738] = "ORE_ELEMENTIUM", -- Elementium Vein
	[202739] = "ORE_ROBSIDIUM", -- Rich Obsidium Deposit
	[202740] = "ORE_RPYRITE", -- Rich Pyrite Deposit
	[202741] = "ORE_RELEMENTIUM", -- Rich Elementium Vein
	[209311] = "ORE_GHOSTIRON", -- Ghost Iron Deposit
	[209312] = "ORE_KYPARITE", -- Kyparite Deposit
	[209313] = "ORE_TRILLIUM", -- Trillium Vein
	[209328] = "ORE_RGHOSTIRON", -- Rich Ghost Iron Deposit
	[209329] = "ORE_RKYPARITE", -- Rich Kyparite Deposit
	[209330] = "ORE_RTRILLIUM", -- Rich Trillium Vein
	[228493] = "ORE_TRUEIRON", -- True Iron Deposit
	[228510] = "ORE_RTRUEIRON", -- Rich True Iron Deposit
	[228563] = "ORE_BLACKROCK", -- Blackrock Deposit
	[228564] = "ORE_RBLACKROCK", -- Rich Blackrock Deposit

	-- Herbs
	[1617] = "HERB_SILVERLEAF", -- Silverleaf
	[1618] = "HERB_PEACEBLOOM", -- Peacebloom
	[1619] = "HERB_EARTHROOT", -- Earthroot
	[1620] = "HERB_MAGEROYAL", -- Mageroyal
	[1621] = "HERB_BRIARTHORN", -- Briarthorn
	[1622] = "HERB_BRUISEWEED", -- Bruiseweed
	[1623] = "HERB_WILDSTEELBLOOM", -- Wild Steelbloom
	[1624] = "HERB_KINGSBLOOD", -- Kingsblood
	[1628] = "HERB_GRAVEMOSS", -- Grave Moss
	[2041] = "HERB_LIFEROOT", -- Liferoot
	[2042] = "HERB_FADELEAF", -- Fadeleaf
	[2043] = "HERB_KHADGARSWHISKER", -- Khadgar's Whisker
	[2044] = "HERB_WINTERSBITE", -- Dragon's Teeth
	[2045] = "HERB_STRANGLEKELP", -- Stranglekelp
	[2046] = "HERB_GOLDTHORN", -- Goldthorn
	[2866] = "HERB_FIREBLOOM", -- Firebloom
	[142140] = "HERB_PURPLELOTUS", -- Purple Lotus
	[142141] = "HERB_ARTHASTEAR", -- Arthas' Tears
	[142142] = "HERB_SUNGRASS", -- Sungrass
	[142143] = "HERB_BLINDWEED", -- Blindweed
	[142144] = "HERB_GHOSTMUSHROOM", -- Ghost Mushroom
	[142145] = "HERB_GROMSBLOOD", -- Gromsblood
	[176583] = "HERB_GOLDENSANSAM", -- Golden Sansam
	[176584] = "HERB_DREAMFOIL", -- Dreamfoil
	[176586] = "HERB_MOUNTAINSILVERSAGE", -- Mountain Silversage
	[176587] = "HERB_PLAGUEBLOOM", -- Sorrowmoss
	[176588] = "HERB_ICECAP", -- Icecap
	[176589] = "HERB_BLACKLOTUS", -- Black Lotus
	[181166] = "HERB_BLOODTHISTLE", -- Bloodthistle
	[181270] = "HERB_FELWEED", -- Felweed
	[181271] = "HERB_DREAMINGGLORY", -- Dreaming Glory
	[181275] = "HERB_RAGVEIL", -- Ragveil
	[181276] = "HERB_FLAMECAP", -- Flame Cap
	[181277] = "HERB_TEROCONE", -- Terocone
	[181278] = "HERB_ANCIENTLICHEN", -- Ancient Lichen
	[181279] = "HERB_NETHERBLOOM", -- Netherbloom
	[181280] = "HERB_NIGHTMAREVINE", -- Nightmare Vine
	[181281] = "HERB_MANATHISTLE", -- Mana Thistle
	[185881] = "HERB_NETHERDUST", -- Netherdust Bush
	[189973] = "HERB_GOLDCLOVER", -- Goldclover
	[190169] = "HERB_TIGERLILY", -- Tiger Lily
	[190170] = "HERB_TALANDRASROSE", -- Talandra's Rose
	[190171] = "HERB_LICHBLOOM", -- Lichbloom
	[190172] = "HERB_ICETHORN", -- Icethorn
	[190175] = "HERB_FROZENHERB", -- Frozen Herb
	[190176] = "HERB_FROSTLOTUS", -- Frost Lotus
	[191019] = "HERB_ADDERSTONGUE", -- Adder's Tongue
	[191303] = "HERB_FIRETHORN", -- Firethorn
	[202747] = "HERB_CINDERBLOOM", -- Cinderbloom
	[202748] = "HERB_STORMVINE", -- Stormvine
	[202749] = "HERB_AZSHARASVEIL", -- Azshara's Veil
	[202750] = "HERB_HEARTBLOSSOM", -- Heartblossom
	[202751] = "HERB_TWILIGHTJASMINE", -- Twilight Jasmine
	[202752] = "HERB_WHIPTAIL", -- Whiptail
	[209349] = "HERB_GREENTEALEAF", -- Green Tea Leaf
	[209350] = "HERB_SILKWEED", -- Silkweed
	[209351] = "HERB_SNOWLILY", -- Snow Lily
	[209353] = "HERB_RAINPOPPY", -- Rain Poppy
	[209354] = "HERB_GOLDENLOTUS", -- Golden Lotus
	[209355] = "HERB_FOOLSCAP", -- Fool's Cap
	[214510] = "HERB_SHATOUCHEDHERB", -- Sha-Touched Herb
	[228571] = "HERB_FROSTWEED", -- Frostweed
	[228572] = "HERB_FIREWEED", -- Fireweed
	[228573] = "HERB_GORGRONDFLYTRAP", -- Gorgrond Flytrap
	[228574] = "HERB_STARFLOWER", -- Starflower
	[228575] = "HERB_NAGRANDARROWBLOOM", -- Nagrand Arrowbloom
	[228576] = "HERB_TALADORORCHID", -- Talador Orchid

	-- Treasure
	[2039] = "TREASURE_CHEST", -- Hidden Strongbox
	[2744] = "TREASURE_CLAM", -- Giant Clam
	[2843] = "TREASURE_CHEST", -- Battered Chest
	[2844] = "TREASURE_CHEST", -- Tattered Chest
	[2850] = "TREASURE_CHEST", -- Solid Chest
	[3658] = "TREASURE_BARREL", -- Water Barrel
	[3659] = "TREASURE_BARREL", -- Barrel of Melon Juice
	[3660] = "TREASURE_CRATE", -- Armor Crate
	[3661] = "TREASURE_CRATE", -- Weapon Crate
	[3662] = "TREASURE_CRATE", -- Food Crate
	[3705] = "TREASURE_BARREL", -- Barrel of Milk
	[3706] = "TREASURE_BARREL", -- Barrel of Sweet Nectar
	[3714] = "TREASURE_CHEST", -- Alliance Strongbox
	[19019] = "TREASURE_BOX", -- Box of Assorted Parts
	[28604] = "TREASURE_CRATE", -- Scattered Crate
	[74447] = "TREASURE_CHEST", -- Large Iron Bound Chest
	[74448] = "TREASURE_CHEST", -- Large Solid Chest
	[75293] = "TREASURE_CHEST", -- Large Battered Chest
	[123330] = "TREASURE_FOOTLOCKER", -- Buccaneer's Strongbox
	[131978] = "TREASURE_CHEST", -- Large Mithril Bound Chest
	[142191] = "TREASURE_CRATE", -- Horde Supply Crate
	[157936] = "TREASURE_UNGOROSOIL", -- Un'Goro Dirt Pile
	[164658] = "TREASURE_POWERCRYST", -- Blue Power Crystal
	[164659] = "TREASURE_POWERCRYST", -- Green Power Crystal
	[164660] = "TREASURE_POWERCRYST", -- Red Power Crystal
	[164661] = "TREASURE_POWERCRYST", -- Yellow Power Crystal
	[164881] = "TREASURE_NIGHTDRAGON", -- Cleansed Night Dragon
	[164882] = "TREASURE_SONGFLOWER", -- Cleansed Songflower
	[164884] = "TREASURE_WINDBLOSSOM", -- Cleansed Windblossom
	[164958] = "TREASURE_BLOODPETAL", -- Bloodpetal Sprout
	[174622] = "TREASURE_WHIPPERROOT", -- Cleansed Whipper Root
	[176213] = "TREASURE_BLOODHERO", -- Blood of Heroes
	[176582] = "TREASURE_SHELLFISHTRAP", -- Shellfish Trap
	[178244] = "TREASURE_FOOTLOCKER", -- Practice Lockbox
	[179486] = "TREASURE_FOOTLOCKER", -- Battered Footlocker
	[179487] = "TREASURE_FOOTLOCKER", -- Waterlogged Footlocker
	[179492] = "TREASURE_FOOTLOCKER", -- Dented Footlocker
	[179493] = "TREASURE_FOOTLOCKER", -- Mossy Footlocker
	[179498] = "TREASURE_FOOTLOCKER", -- Scarlet Footlocker
	[181665] = "TREASURE_FOOTLOCKER", -- Burial Chest
	[181798] = "TREASURE_CHEST", -- Fel Iron Chest
	[181800] = "TREASURE_CHEST", -- Heavy Fel Iron Chest
	[181802] = "TREASURE_CHEST", -- Adamantite Bound Chest
	[181804] = "TREASURE_CHEST", -- Felsteel Chest
	[182053] = "TREASURE_GLOWCAP", -- Glowcap
	[184740] = "TREASURE_FOOTLOCKER", -- Wicker Chest
	[184793] = "TREASURE_FOOTLOCKER", -- Primitive Chest
	[184930] = "TREASURE_CHEST", -- Solid Fel Iron Chest
	[185915] = "TREASURE_EGG", -- Netherwing Egg
	[193997] = "TREASURE_EVERFROSTCHIP", -- Everfrost Chip
	[207472] = "TREASURE_CHEST", -- Silverbound Treasure Chest
	[207484] = "TREASURE_CHEST", -- Sturdy Treasure Chest
	[207498] = "TREASURE_CHEST", -- Dark Iron Treasure Chest
	[207512] = "TREASURE_CHEST", -- Silken Treasure Chest
	[207529] = "TREASURE_CHEST", -- Maplewood Treasure Chest
	[207533] = "TREASURE_CHEST", -- Runestone Treasure Chest
	[210565] = "TREASURE_DARKSOIL", -- Dark Soil
	[214945] = "TREASURE_ONYXEGG", -- Onyx Egg

	-- Archaeology
	[202655] = "ARCH_TROLL", -- Troll Archaeology Find
	[203071] = "ARCH_NIGHTELF", -- Night Elf Archaeology Find
	[203078] = "ARCH_NERUBIAN", -- Nerubian Archaeology Find
	[204282] = "ARCH_DWARF", -- Dwarf Archaeology Find
	[206836] = "ARCH_FOSSIL", -- Fossil Archaeology Find
	[207187] = "ARCH_ORC", -- Orc Archaeology Find
	[207188] = "ARCH_DRAENEI", -- Draenei Archaeology Find
	[207189] = "ARCH_VRYKUL", -- Vrykul Archaeology Find
	[207190] = "ARCH_TOLVIR", -- Tol'vir Archaeology Find
	[211163] = "ARCH_PANDAREN", -- Pandaren Archaeology Find
	[211174] = "ARCH_MOGU", -- Mogu Archaeology Find
	[218950] = "ARCH_MANTID", -- Mantid Archaeology Find
	[226521] = "ARCH_DRAENORCLANS", -- Draenor Clans Archaeology Find
	[234105] = "ARCH_ARAKKOA", -- Arakkoa Archaeology Find
	[234106] = "ARCH_OGRE", -- Ogre Archaeology Find
}


-- This table defines the object name which will be used by the UI
-- to refer to all objects of a specific category
-- The values in this table are translated into locale specific name
-- strings when this file is loaded
CategoryNames = {
	-- Ores
	["ORE_COPPER"] = ORE_COPPER,
	["ORE_BLOODSTONE"] = ORE_BLOODSTONE,
	["ORE_KHORIUM"] = ORE_KHORIUM,
	["ORE_NETHERCITE"] = ORE_NETHERCITE,
	["ORE_RTHORIUM"] = ORE_RTHORIUM,
	["ORE_ADAMANTITE"] = ORE_ADAMANTITE,
	["ORE_TIN"] = ORE_TIN,
	["ORE_DARKIRON"] = ORE_DARKIRON,
	["ORE_MITHRIL"] = ORE_MITHRIL,
	["ORE_SILVER"] = ORE_SILVER,
	["ORE_GOLD"] = ORE_GOLD,
	["ORE_RTHORIUM"] = ORE_RTHORIUM,
	["ORE_INCENDICITE"] = ORE_INCENDICITE,
	["ORE_THORIUM"] = ORE_THORIUM,
	["ORE_IRON"] = ORE_IRON,
	["ORE_GOLD"] = ORE_GOLD,
	["ORE_RADAMANTITE"] = ORE_RADAMANTITE,
	["ORE_TRUESILVER"] = ORE_TRUESILVER,
	["ORE_FELIRON"] = ORE_FELIRON,
	["ORE_MITHRIL"] = ORE_MITHRIL,
	["ORE_SILVER"] = ORE_SILVER,
	["ORE_TRUESILVER"] = ORE_TRUESILVER,
	["ORE_THORIUM"] = ORE_THORIUM,
	["ORE_COBALT"] = 189978, -- Cobalt Deposit
	["ORE_RCOBALT"] = 189979, -- Rich Cobalt Deposit
	["ORE_SARONITE"] = 189980, -- Saronite Deposit
	["ORE_RSARONITE"] = 189981, -- Rich Saronite Deposit
	["ORE_TITANIUM"] = 191133, -- Titanium Vein
	["ORE_OBSIDIUM"] = ORE_OBSIDIUM,
	["ORE_ROBSIDIUM"] = ORE_ROBSIDIUM,
	["ORE_ELEMENTIUM"] = ORE_ELEMENTIUM,
	["ORE_RELEMENTIUM"] = ORE_RELEMENTIUM,
	["ORE_PYRITE"] = ORE_PYRITE,
	["ORE_RPYRITE"] = ORE_RPYRITE,
	["ORE_GHOSTIRON"] = ORE_GHOSTIRON,
	["ORE_RGHOSTIRON"] = ORE_RGHOSTIRON,
	["ORE_KYPARITE"] = ORE_KYPARITE,
	["ORE_RKYPARITE"] = ORE_RKYPARITE,
	["ORE_TRILLIUM"] = ORE_TRILLIUM,
	["ORE_RTRILLIUM"] = ORE_RTRILLIUM,
	["ORE_BLACKROCK"] = ORE_BLACKROCK,
	["ORE_RBLACKROCK"] = ORE_RBLACKROCK,
	["ORE_TRUEIRON"] = ORE_TRUEIRON,
	["ORE_RTRUEIRON"] = ORE_RTRUEIRON,

	-- Herbs
	["HERB_BRIARTHORN"] = 1621, -- Briarthorn
	["HERB_GOLDENSANSAM"] = 176583, -- Golden Sansam
	["HERB_ANCIENTLICHEN"] = 181278, -- Ancient Lichen
	["HERB_GOLDTHORN"] = 2046, -- Goldthorn
	["HERB_BRUISEWEED"] = 1622, -- Bruiseweed
	["HERB_FADELEAF"] = 2042, -- Fadeleaf
	["HERB_DREAMFOIL"] = 176584, -- Dreamfoil
	["HERB_BLINDWEED"] = 142143, -- Blindweed
	["HERB_NETHERDUST"] = HERB_NETHERDUST,
	["HERB_GRAVEMOSS"] = 1628, -- Grave Moss
	["HERB_GROMSBLOOD"] = 142145, -- Gromsblood
	["HERB_MANATHISTLE"] = 181281, -- Mana Thistle
	["HERB_EARTHROOT"] = 1619, -- Earthroot
	["HERB_MOUNTAINSILVERSAGE"] = 176586, -- Mountain Silversage
	["HERB_WINTERSBITE"] = 2044, -- Dragon's Teeth
	["HERB_FIREBLOOM"] = 2866, -- Firebloom
	["HERB_PLAGUEBLOOM"] = 176587, -- Sorrowmoss
	["HERB_BLACKLOTUS"] = 176589, -- Black Lotus
	["HERB_WILDSTEELBLOOM"] = 1623, -- Wild Steelbloom
	["HERB_GHOSTMUSHROOM"] = 142144, -- Ghost Mushroom
	["HERB_NIGHTMAREVINE"] = 181280, -- Nightmare Vine
	["HERB_SUNGRASS"] = 142142, -- Sungrass
	["HERB_MAGEROYAL"] = 1620, -- Mageroyal
	["HERB_KINGSBLOOD"] = 1624, -- Kingsblood
	["HERB_ARTHASTEAR"] = 142141, -- Arthas' Tears
	["HERB_PURPLELOTUS"] = 142140, -- Purple Lotus
	["HERB_KHADGARSWHISKER"] = 2043, -- Khadgar's Whisker
	["HERB_FELWEED"] = 181270, -- Felweed
	["HERB_SILVERLEAF"] = 1617, -- Silverleaf
	["HERB_NETHERBLOOM"] = 181279, -- Netherbloom
	["HERB_FLAMECAP"] = 181276, -- Flame Cap
	["HERB_LIFEROOT"] = 2041, -- Liferoot
	["HERB_TEROCONE"] = 181277, -- Terocone
	["HERB_DREAMINGGLORY"] = 181271, -- Dreaming Glory
	["HERB_BLOODTHISTLE"] = 181166, -- Bloodthistle
	["HERB_ICECAP"] = 176588, -- Icecap
	["HERB_STRANGLEKELP"] = 2045, -- Stranglekelp
	["HERB_PEACEBLOOM"] = 1618, -- Peacebloom
	["HERB_RAGVEIL"] = 181275, -- Ragveil
	["HERB_GOLDCLOVER"] = 189973, -- Goldclover
	["HERB_FIRETHORN"] = 191303, -- Firethorn
	["HERB_TALANDRASROSE"] = 190170, -- Talandra's Rose
	["HERB_TIGERLILY"] = 190169, -- Tiger Lily
	["HERB_FROZENHERB"] = 190175, -- Frozen Herb
	["HERB_LICHBLOOM"] = 190171, -- Lichbloom
	["HERB_ADDERSTONGUE"] = 191019, -- Adder's Tongue
	["HERB_ICETHORN"] = 190172, -- Icethorn
	["HERB_FROSTLOTUS"] = HERB_FROSTLOTUS,
	["HERB_AZSHARASVEIL"] = HERB_AZSHARASVEIL,
	["HERB_CINDERBLOOM"] = HERB_CINDERBLOOM,
	["HERB_STORMVINE"] = HERB_STORMVINE,
	["HERB_HEARTBLOSSOM"] = HERB_HEARTBLOSSOM,
	["HERB_WHIPTAIL"] = HERB_WHIPTAIL,
	["HERB_TWILIGHTJASMINE"] = HERB_TWILIGHTJASMINE,
	["HERB_GREENTEALEAF"] = 209349, -- Green Tea Leaf
	["HERB_RAINPOPPY"] = 209353, -- Rain Poppy
	["HERB_SILKWEED"] = 209350, -- Silkweed
	["HERB_GOLDENLOTUS"] = 209354, -- Golden Lotus
	["HERB_SHATOUCHEDHERB"] = 214510, -- Sha-Touched Herb
	["HERB_SNOWLILY"] = 209351, -- Snow Lily
	["HERB_FOOLSCAP"] = 209355, -- Fool's Cap
	["HERB_FIREWEED"] = 228572, -- Fireweed
	["HERB_GORGRONDFLYTRAP"] = 228573, -- Gorgrond Flytrap
	["HERB_FROSTWEED"] = 228571, -- Frostweed
	["HERB_STARFLOWER"] = 228574, -- Starflower
	["HERB_NAGRANDARROWBLOOM"] = 228575, -- Nagrand Arrowbloom
	["HERB_TALADORORCHID"] = 228576, -- Talador Orchid

	-- Treasure
	["TREASURE_CHEST"] = TREASURE_CHEST,
	["TREASURE_CHEST"] = TREASURE_CHEST,
	["TREASURE_UNGOROSOIL"] = TREASURE_UNGOROSOIL,
	["TREASURE_WHIPPERROOT"] = TREASURE_WHIPPERROOT,
	["TREASURE_WINDBLOSSOM"] = TREASURE_WINDBLOSSOM,
	["TREASURE_NIGHTDRAGON"] = TREASURE_NIGHTDRAGON,
	["TREASURE_BARREL"] = TREASURE_BARREL,
	["TREASURE_CRATE"] = TREASURE_CRATE,
	["TREASURE_CHEST"] = TREASURE_CHEST,
	["TREASURE_FOOTLOCKER"] = TREASURE_FOOTLOCKER,
	["TREASURE_FOOTLOCKER"] = TREASURE_FOOTLOCKER,
	["TREASURE_GLOWCAP"] = TREASURE_GLOWCAP,
	["TREASURE_CHEST"] = TREASURE_CHEST,
	["TREASURE_CHEST"] = TREASURE_CHEST,
	["TREASURE_FOOTLOCKER"] = TREASURE_FOOTLOCKER,
	["TREASURE_CHEST"] = TREASURE_CHEST,
	["TREASURE_FOOTLOCKER"] = TREASURE_FOOTLOCKER,
	["TREASURE_FOOTLOCKER"] = TREASURE_FOOTLOCKER,
	["TREASURE_CRATE"] = TREASURE_CRATE,
	["TREASURE_CHEST"] = TREASURE_CHEST,
	["TREASURE_CRATE"] = TREASURE_CRATE,
	["TREASURE_FOOTLOCKER"] = TREASURE_FOOTLOCKER,
	["TREASURE_FOOTLOCKER"] = TREASURE_FOOTLOCKER,
	["TREASURE_SHELLFISHTRAP"] = TREASURE_SHELLFISHTRAP,
	["TREASURE_BARREL"] = TREASURE_BARREL,
	["TREASURE_POWERCRYST"] = TREASURE_POWERCRYST,
	["TREASURE_POWERCRYST"] = TREASURE_POWERCRYST,
	["TREASURE_POWERCRYST"] = TREASURE_POWERCRYST,
	["TREASURE_POWERCRYST"] = TREASURE_POWERCRYST,
	["TREASURE_EGG"] = TREASURE_EGG,
	["TREASURE_CHEST"] = TREASURE_CHEST,
	["TREASURE_FOOTLOCKER"] = TREASURE_FOOTLOCKER,
	["TREASURE_CHEST"] = TREASURE_CHEST,
	["TREASURE_CHEST"] = TREASURE_CHEST,
	["TREASURE_CRATE"] = TREASURE_CRATE,
	["TREASURE_BOX"] = TREASURE_BOX,
	["TREASURE_BLOODPETAL"] = TREASURE_BLOODPETAL,
	["TREASURE_BARREL"] = TREASURE_BARREL,
	["TREASURE_FOOTLOCKER"] = TREASURE_FOOTLOCKER,
	["TREASURE_BARREL"] = TREASURE_BARREL,
	["TREASURE_CRATE"] = TREASURE_CRATE,
	["TREASURE_FOOTLOCKER"] = TREASURE_FOOTLOCKER,
	["TREASURE_CHEST"] = TREASURE_CHEST,
	["TREASURE_CHEST"] = TREASURE_CHEST,
	["TREASURE_CLAM"] = TREASURE_CLAM,
	["TREASURE_CHEST"] = TREASURE_CHEST,
	["TREASURE_BLOODHERO"] = 176213, -- Blood of Heroes
	["TREASURE_SONGFLOWER"] = TREASURE_SONGFLOWER,
	["TREASURE_CHEST"] = TREASURE_CHEST,
	["TREASURE_EVERFROSTCHIP"] = TREASURE_EVERFROSTCHIP,
	["TREASURE_CHEST"] = TREASURE_CHEST,
	["TREASURE_CHEST"] = TREASURE_CHEST,
	["TREASURE_CHEST"] = TREASURE_CHEST,
	["TREASURE_CHEST"] = TREASURE_CHEST,
	["TREASURE_CHEST"] = TREASURE_CHEST,
	["TREASURE_CHEST"] = TREASURE_CHEST,
	["TREASURE_ONYXEGG"] = TREASURE_ONYXEGG,
	["TREASURE_DARKSOIL"] = 210565, -- Dark Soil

	-- Archaeology
	["ARCH_DRAENEI"] = ARCH_DRAENEI,
	["ARCH_DWARF"] = ARCH_DWARF,
	["ARCH_FOSSIL"] = ARCH_FOSSIL,
	["ARCH_NERUBIAN"] = ARCH_NERUBIAN,
	["ARCH_NIGHTELF"] = ARCH_NIGHTELF,
	["ARCH_ORC"] = ARCH_ORC,
	["ARCH_TOLVIR"] = ARCH_TOLVIR,
	["ARCH_TROLL"] = ARCH_TROLL,
	["ARCH_VRYKUL"] = ARCH_VRYKUL,
	["ARCH_PANDAREN"] = ARCH_PANDAREN,
	["ARCH_MOGU"] = ARCH_MOGU,
	["ARCH_MANTID"] = ARCH_MANTID,
	["ARCH_DRAENORCLANS"] = ARCH_DRAENORCLANS,
	["ARCH_ARAKKOA"] = ARCH_ARAKKOA,
	["ARCH_OGRE"] = ARCH_OGRE,
}

for category, id in pairs(CategoryNames) do
	if ( type(id) == "number" ) then
		for name, nodeId in pairs(Gatherer.Nodes.Names) do
			if ( id == nodeId ) then
				CategoryNames[category] = name
				break
			end
		end
	end
end
