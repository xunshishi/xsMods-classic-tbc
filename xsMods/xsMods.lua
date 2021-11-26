-- alt+右键设置焦点 --
local modifier = "alt" --- 可修改为 shift, alt 或者 ctrl
local mouseButton = "2" --- 1 =鼠标左键, 2 = 鼠标右键, 3 = 鼠标滚轮按下, 4 and 5 = 高级鼠标……你们懂的

local function SetFocusHotkey(frame)
   frame:SetAttribute(modifier.."-type"..mouseButton,"focus")
end

local function CreateFrame_Hook(type, name, parent, template)
   if template == "SecureUnitButtonTemplate" then
      SetFocusHotkey(_G[name])
   end
end

hooksecurefunc("CreateFrame", CreateFrame_Hook)

-- Keybinding override so that models can be shift/alt/ctrl+clicked
local f = CreateFrame("CheckButton", "FocuserButton", UIParent, "SecureActionButtonTemplate")
f:SetAttribute("type1","macro")
f:SetAttribute("macrotext","/focus mouseover")
SetOverrideBindingClick(FocuserButton,true,modifier.."-BUTTON"..mouseButton,"FocuserButton")

-- Set the keybindings on the default unit frames since we won't get any CreateFrame notification about them
local duf = {
   PlayerFrame,
   PetFrame,
   PartyMemberFrame1,
   PartyMemberFrame2,
   PartyMemberFrame3,
   PartyMemberFrame4,
   PartyMemberFrame1PetFrame,
   PartyMemberFrame2PetFrame,
   PartyMemberFrame3PetFrame,
   PartyMemberFrame4PetFrame,
   TargetFrame,
   TargetofTargetFrame,
}

for i,frame in pairs(duf) do
   SetFocusHotkey(frame)
end

-- 框体移动 --
PlayerFrame:ClearAllPoints() 
TargetFrame:ClearAllPoints()
TargetFrameToT:ClearAllPoints()
PetFrame:ClearAllPoints()
FocusFrame:ClearAllPoints()

PlayerFrame:SetPoint("CENTER","WorldFrame","CENTER",-450,200)
--TargetFrame:SetPoint("TOPLEFT","PlayerFrame","BOTTOM",-5,45)
TargetFrame:SetPoint("LEFT","PlayerFrame","RIGHT",0,0)
TargetFrameToT:SetPoint("TOPLEFT","TargetFrame","BOTTOM",-10,35)
PetFrame:SetPoint("TOPLEFT","WorldFrame","TOPLEFT",0,0)
FocusFrame:SetPoint("CENTER","PlayerFrame","CENTER",0,300)

-- 框体隐藏 --
MainMenuBarLeftEndCap:Hide()
MainMenuBarRightEndCap:Hide()

-- 备份 --
--/script BuffFrame:ClearAllPoints()
--/script BuffFrame:SetPoint("CENTER","WorldFrame","CENTER",450,200)

