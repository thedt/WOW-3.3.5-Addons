local Buddy_Caller = CreateFrame("Frame")
Buddy_Caller:RegisterEvent("QUEST_ACCEPTED")
--Buddy_Caller:RegisterEvent("QUEST_DETAIL")

--local Abandon_Quest_OnClick = function(...)
--	local title, level = GetQuestLogTitle(GetQuestLogSelection());
--	local qlink=GetQuestLink(GetQuestLogSelection());
--	SendChatMessage(string.format("[BuddyCheck]: Quest %s[%i] !!ABANDONED!!",qlink,level),"PARTY");
--end

Buddy_Caller:SetScript("OnEvent",

	function(self, event, ...)
		local arg1 = ...
		local title, level, tag, header = GetQuestLogTitle(arg1);
		local buddylink=GetQuestLink(arg1);
		--local QuestLogPopupDetailFrame = QuestLogPopupDetailFrame
		
		if(GetNumPartyMembers() > 0) then
		 SelectQuestLogEntry(arg1);
			if(GetQuestLogPushable()) then
				QuestLogPushQuest();
				SendChatMessage(string.format("[BuddyCheck]: Quest %s[%i] shared",buddylink,level),"PARTY");
			else
				SendChatMessage(string.format("[BuddyCheck]: Quest %s[%i] UNSHAREABLE",buddylink,level),"PARTY");
			end
			--QuestLogFrameAbandonButton:HookScript("OnClick", Abandon_Quest_OnClick);
			--QuestLogFrameAbandonButton:HookScript("OnClick", Abandon_Quest_OnClick);
		--SendChatMessage(string.format(".qc %s",buddylink),"CHANNEL",nil,1);
		end
	end
)