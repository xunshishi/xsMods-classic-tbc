---------------------------------- alt+右键设置焦点 ----------------------------------
-- local modifier = "alt" --- 可修改为 shift, alt 或者 ctrl
-- local mouseButton = "2" --- 1 =鼠标左键, 2 = 鼠标右键, 3 = 鼠标滚轮按下, 4 and 5 = 高级鼠标……你们懂的

-- local function SetFocusHotkey(frame)
   -- frame:SetAttribute(modifier.."-type"..mouseButton,"focus")
-- end

-- local function CreateFrame_Hook(type, name, parent, template)
   -- if template == "SecureUnitButtonTemplate" then
      -- SetFocusHotkey(_G[name])
   -- end
-- end

-- hooksecurefunc("CreateFrame", CreateFrame_Hook)

-- Keybinding override so that models can be shift/alt/ctrl+clicked
-- local f = CreateFrame("CheckButton", "FocuserButton", UIParent, "SecureActionButtonTemplate")
-- f:SetAttribute("type1","macro")
-- f:SetAttribute("macrotext","/focus mouseover")
-- SetOverrideBindingClick(FocuserButton,true,modifier.."-BUTTON"..mouseButton,"FocuserButton")

-- Set the keybindings on the default unit frames since we won't get any CreateFrame notification about them
-- local duf = {
   -- PlayerFrame,
   -- PetFrame,
   -- PartyMemberFrame1,
   -- PartyMemberFrame2,
   -- PartyMemberFrame3,
   -- PartyMemberFrame4,
   -- PartyMemberFrame1PetFrame,
   -- PartyMemberFrame2PetFrame,
   -- PartyMemberFrame3PetFrame,
   -- PartyMemberFrame4PetFrame,
   -- TargetFrame,
   -- TargetofTargetFrame,
-- }

-- for i,frame in pairs(duf) do
   -- SetFocusHotkey(frame)
-- end

---------------------------------- 玩家/目标框体位置 ----------------------------------
-- 绑定事件后再移动,解决能量条消失的问题
hooksecurefunc("PlayerFrame_Update", function()
	PlayerFrame:ClearAllPoints() 
	TargetFrame:ClearAllPoints()
	TargetFrameToT:ClearAllPoints()
	PetFrame:ClearAllPoints()

	PlayerFrame:SetPoint("CENTER","WorldFrame","CENTER",-450,200)
	TargetFrame:SetPoint("LEFT","PlayerFrame","RIGHT",0,0)
	TargetFrameToT:SetPoint("TOPLEFT","TargetFrame","BOTTOM",-10,35)
	PetFrame:SetPoint("TOPLEFT","WorldFrame","TOPLEFT",0,0)
end)

---------------------------------- 焦点框体位置 ----------------------------------
local frame =  CreateFrame("Frame");
frame:RegisterEvent("PLAYER_FOCUS_CHANGED");
-- 玩家焦点改变事件回调
local function eventHandler(self, event, ...)
	print("Hello World! Hello " .. event);
	FocusFrame:ClearAllPoints()
	FocusFrame:SetPoint("CENTER","TargetFrame","CENTER",0,-220)
end
frame:SetScript("OnEvent", eventHandler);

-- 框体隐藏 --
MainMenuBarLeftEndCap:Hide()
MainMenuBarRightEndCap:Hide()

-- 备份 --
--/script BuffFrame:ClearAllPoints()
--/script BuffFrame:SetPoint("CENTER","WorldFrame","CENTER",450,200)

