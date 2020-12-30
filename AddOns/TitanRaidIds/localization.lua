-- Titan RaidIDs Localization file
TITAN_RAIDIDS_MENU_TEXT = "Titan Raid-IDs"
TITAN_RAIDIDS_VERSION = "2.4.71"
TITAN_RAIDIDS_BUTTON_LABEL = "Raid-IDs: "
TITAN_RAIDIDS_BUTTON_TEXT = "%s %s";
TITAN_RAIDIDS_TOOLTIP = "Titan Raid-IDs"
TITAN_RAIDIDS_COOLDOWN_INFO = {};

-- maybe doing enUS doesn't make sense, but this works for me, so I don't see a good 
-- reason to default any locale text unless it isn't reasonable to find equiv words in other languages.
if ( GetLocale() == "enUS" ) then
	TITAN_RAIDIDS_OPTION_VIEW = "Use Compact View"
	TITAN_RAIDIDS_OPTION_INFO = "Use condensed info"
	TITAN_RAIDIDS_OPTION_RESETIN = "Show 'Reset in' on default view"
	TITAN_RAIDIDS_OPTION_UPDATE = "Update! "
	TITAN_RAIDIDS_OPTION_STORED = "[stored Name settings]"
	TITAN_RAIDIDS_OPTION_LEFTCLICK = "LeftClick = Hide/Show Names"
	TITAN_RAIDIDS_COOLDOWN_INFO[1] = "Reset in"
	TITAN_RAIDIDS_COOLDOWN_INFO[2] = "days"
	TITAN_RAIDIDS_COOLDOWN_INFO[3] = "hrs"
	TITAN_RAIDIDS_COOLDOWN_INFO[4] = "min"
	TITAN_RAIDIDS_COOLDOWN_INFO[5] = "sec"
end
-- German localization by Basster & CUDiLLA.
-- got one for "[stored Name settings]" from google translate.
if ( GetLocale() == "deDE" ) then
	TITAN_RAIDIDS_OPTION_VIEW = "benutze kurzgefasste Ansicht"
	TITAN_RAIDIDS_OPTION_INFO = "benutze Zusammengefasste Info"
	TITAN_RAIDIDS_OPTION_RESETIN = "Zeige 'Zur\195\188cksetzen in' in der Standard-Ansicht"
	TITAN_RAIDIDS_OPTION_UPDATE = "Aktualisierung! "
	TITAN_RAIDIDS_OPTION_STORED = "[Name gespeichert Einstellungen]"
	TITAN_RAIDIDS_OPTION_LEFTCLICK = "Linksklick = Verstecke/Zeige Namen"
	TITAN_RAIDIDS_COOLDOWN_INFO[1] = "Zur\195\188cksetzen in" 
	TITAN_RAIDIDS_COOLDOWN_INFO[2] = "Tage"
	TITAN_RAIDIDS_COOLDOWN_INFO[3] = "Std."
	TITAN_RAIDIDS_COOLDOWN_INFO[4] = "Min."
	TITAN_RAIDIDS_COOLDOWN_INFO[5] = "Sek."	
end
-- Latin American Spanish localization supplied by Valandris.
if ( GetLocale() == "esMX" ) then
	TITAN_RAIDIDS_OPTION_VIEW = "Use Compact View"
	TITAN_RAIDIDS_OPTION_INFO = "Use condensed info"
	TITAN_RAIDIDS_OPTION_RESETIN = "Show 'Reset in' on default view"
	TITAN_RAIDIDS_OPTION_UPDATE = "Update! "
	TITAN_RAIDIDS_OPTION_STORED = "[stored Name settings]"
	TITAN_RAIDIDS_OPTION_LEFTCLICK = "LeftClick = Hide/Show Names"
	TITAN_RAIDIDS_COOLDOWN_INFO[1] = "Reinicializa en"
	TITAN_RAIDIDS_COOLDOWN_INFO[2] = "D/195/173as"
	TITAN_RAIDIDS_COOLDOWN_INFO[3] = "Horas"
	TITAN_RAIDIDS_COOLDOWN_INFO[4] = "Min"
	TITAN_RAIDIDS_COOLDOWN_INFO[5] = "Seg" 
end 
-- French localization - framework only, unfinished.
if ( GetLocale() == "frFR" ) then
	TITAN_RAIDIDS_OPTION_VIEW = "Use Compact View"
	TITAN_RAIDIDS_OPTION_INFO = "Use condensed info"
	TITAN_RAIDIDS_OPTION_RESETIN = "Show 'Reset in' on default view"
	TITAN_RAIDIDS_OPTION_UPDATE = "Update! "
	TITAN_RAIDIDS_OPTION_STORED = "[stored Name settings]"
	TITAN_RAIDIDS_OPTION_LEFTCLICK = "LeftClick = Hide/Show Names"
	TITAN_RAIDIDS_COOLDOWN_INFO[1] = "Reset in"
	TITAN_RAIDIDS_COOLDOWN_INFO[2] = "days"
	TITAN_RAIDIDS_COOLDOWN_INFO[3] = "hrs"
	TITAN_RAIDIDS_COOLDOWN_INFO[4] = "min"
	TITAN_RAIDIDS_COOLDOWN_INFO[5] = "sec"
end
-- Korean localization - framework only, unfinished.
if ( GetLocale() == "koKR" ) then
	TITAN_RAIDIDS_OPTION_VIEW = "Use Compact View"
	TITAN_RAIDIDS_OPTION_INFO = "Use condensed info"
	TITAN_RAIDIDS_OPTION_RESETIN = "Show 'Reset in' on default view"
	TITAN_RAIDIDS_OPTION_UPDATE = "Update! "
	TITAN_RAIDIDS_OPTION_STORED = "[stored Name settings]"
	TITAN_RAIDIDS_OPTION_LEFTCLICK = "LeftClick = Hide/Show Names"
	TITAN_RAIDIDS_COOLDOWN_INFO[1] = "Reset in"
	TITAN_RAIDIDS_COOLDOWN_INFO[2] = "days"
	TITAN_RAIDIDS_COOLDOWN_INFO[3] = "hrs"
	TITAN_RAIDIDS_COOLDOWN_INFO[4] = "min"
	TITAN_RAIDIDS_COOLDOWN_INFO[5] = "sec"
end
-- Russian localization - framework only, unfinished.
if ( GetLocale() == "ruRU" ) then
	TITAN_RAIDIDS_OPTION_VIEW = "Use Compact View"
	TITAN_RAIDIDS_OPTION_INFO = "Use condensed info"
	TITAN_RAIDIDS_OPTION_RESETIN = "Show 'Reset in' on default view"
	TITAN_RAIDIDS_OPTION_UPDATE = "Update! "
	TITAN_RAIDIDS_OPTION_STORED = "[stored Name settings]"
	TITAN_RAIDIDS_OPTION_LEFTCLICK = "LeftClick = Hide/Show Names"
	TITAN_RAIDIDS_COOLDOWN_INFO[1] = "Reset in"
	TITAN_RAIDIDS_COOLDOWN_INFO[2] = "days"
	TITAN_RAIDIDS_COOLDOWN_INFO[3] = "hrs"
	TITAN_RAIDIDS_COOLDOWN_INFO[4] = "min"
	TITAN_RAIDIDS_COOLDOWN_INFO[5] = "sec"
end
-- Simplified Chinese localization - framework only, unfinished.
if ( GetLocale() == "zhCN" ) then
	TITAN_RAIDIDS_OPTION_VIEW = "Use Compact View"
	TITAN_RAIDIDS_OPTION_INFO = "Use condensed info"
	TITAN_RAIDIDS_OPTION_RESETIN = "Show 'Reset in' on default view"
	TITAN_RAIDIDS_OPTION_UPDATE = "Update! "
	TITAN_RAIDIDS_OPTION_STORED = "[stored Name settings]"
	TITAN_RAIDIDS_OPTION_LEFTCLICK = "LeftClick = Hide/Show Names"
	TITAN_RAIDIDS_COOLDOWN_INFO[1] = "Reset in"
	TITAN_RAIDIDS_COOLDOWN_INFO[2] = "days"
	TITAN_RAIDIDS_COOLDOWN_INFO[3] = "hrs"
	TITAN_RAIDIDS_COOLDOWN_INFO[4] = "min"
	TITAN_RAIDIDS_COOLDOWN_INFO[5] = "sec"
end
-- Spanish localization - framework only, unfinished.
if ( GetLocale() == "esES" ) then
	TITAN_RAIDIDS_OPTION_VIEW = "Use Compact View"
	TITAN_RAIDIDS_OPTION_INFO = "Use condensed info"
	TITAN_RAIDIDS_OPTION_RESETIN = "Show 'Reset in' on default view"
	TITAN_RAIDIDS_OPTION_UPDATE = "Update! "
	TITAN_RAIDIDS_OPTION_STORED = "[stored Name settings]"
	TITAN_RAIDIDS_OPTION_LEFTCLICK = "LeftClick = Hide/Show Names"
	TITAN_RAIDIDS_COOLDOWN_INFO[1] = "Reset in"
	TITAN_RAIDIDS_COOLDOWN_INFO[2] = "days"
	TITAN_RAIDIDS_COOLDOWN_INFO[3] = "hrs"
	TITAN_RAIDIDS_COOLDOWN_INFO[4] = "min"
	TITAN_RAIDIDS_COOLDOWN_INFO[5] = "sec"
end
-- Traditional Chinese localization - framework only, unfinished.
if ( GetLocale() == "zhTW" ) then
	TITAN_RAIDIDS_OPTION_VIEW = "Use Compact View"
	TITAN_RAIDIDS_OPTION_INFO = "Use condensed info"
	TITAN_RAIDIDS_OPTION_RESETIN = "Show 'Reset in' on default view"
	TITAN_RAIDIDS_OPTION_UPDATE = "Update! "
	TITAN_RAIDIDS_OPTION_STORED = "[stored Name settings]"
	TITAN_RAIDIDS_OPTION_LEFTCLICK = "LeftClick = Hide/Show Names"
	TITAN_RAIDIDS_COOLDOWN_INFO[1] = "Reset in"
	TITAN_RAIDIDS_COOLDOWN_INFO[2] = "days"
	TITAN_RAIDIDS_COOLDOWN_INFO[3] = "hrs"
	TITAN_RAIDIDS_COOLDOWN_INFO[4] = "min"
	TITAN_RAIDIDS_COOLDOWN_INFO[5] = "sec"
end