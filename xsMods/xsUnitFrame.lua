---------------------------------
-- xunshishi/豆豆大料 头像插件 --
---------------------------------

--------------------------
--[[	Namespace	]]
--------------------------
local AddOn=select(2,...);
AddOn.Options=AddOn.Options or {};

----------------------------------
--[[	Options Defaults	]]
----------------------------------
--AddOn.Options.TargetThreatPVP=true;


local addon, ns = ...
local fade = true					---头像渐隐开关，默认渐隐功能打开，不需要此功能的把true 改为false

-------------生成目标头像职业小图标材质-------------
local targeticon = CreateFrame("Button", "TargetClass", TargetFrame)
local y = GetHight
targeticon:Hide()
targeticon:SetWidth(32)
targeticon:SetHeight(32)
targeticon:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 118, -2)
local bg = targeticon:CreateTexture("TargetClassBackground", "BACKGROUND")
bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
bg:SetWidth(20)
bg:SetHeight(20)
bg:SetPoint("CENTER")
bg:SetVertexColor(0, 0, 0, 0.7)
local icon = targeticon:CreateTexture("TargetClassIcon", "ARTWORK")
icon:SetTexture("Interface\\WorldStateFrame\\Icons-Classes")
icon:SetWidth(20)
icon:SetHeight(20)
icon:SetPoint("CENTER")
local lay = targeticon:CreateTexture("TargetClassBorder", "OVERLAY")
lay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
lay:SetWidth(54)
lay:SetHeight(54)
lay:SetPoint("CENTER", 11, -12)
RaiseFrameLevel(targeticon)

targeticon:SetScript("OnUpdate", function(self)
	if (not UnitCanAttack("player","target") and UnitIsPlayer("target")) then
		targeticon:Enable()
		-- SetDesaturation(TargetClassIcon, false)
	else
		targeticon:Disable()
		-- SetDesaturation(TargetClassIcon, true)
	end
	
	

	
end)

-------------生成焦点头像职业小图标材质-------------
local frameicon = CreateFrame("Button", "FrameClass", FocusFrame)
local yf = GetHight
frameicon:Hide()
frameicon:SetWidth(32)
frameicon:SetHeight(32)
frameicon:SetPoint("TOPLEFT", FocusFrame, "TOPLEFT", 118, -2)
local bgf = frameicon:CreateTexture("FrameClassBackground", "BACKGROUND")
bgf:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
bgf:SetWidth(20)
bgf:SetHeight(20)
bgf:SetPoint("CENTER")
bgf:SetVertexColor(0, 0, 0, 0.7)
local iconf = frameicon:CreateTexture("FrameClassIcon", "ARTWORK")
iconf:SetTexture("Interface\\WorldStateFrame\\Icons-Classes")
iconf:SetWidth(20)
iconf:SetHeight(20)
iconf:SetPoint("CENTER")
local layf = frameicon:CreateTexture("FrameClassBorder", "OVERLAY")
layf:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
layf:SetWidth(54)
layf:SetHeight(54)
layf:SetPoint("CENTER", 11, -12)
RaiseFrameLevel(frameicon)

frameicon:SetScript("OnUpdate", function(self)
	if (not UnitCanAttack("player","focus") and UnitIsPlayer("focus")) then
		frameicon:Enable()
	else
		frameicon:Disable()
	end
end)

-------------绑定目标/焦点头像职业小图标-------------
hooksecurefunc("TargetFrame_Update", function()
	-- 目标
	if UnitIsPlayer("target") then
		local coord = CLASS_ICON_TCOORDS[select(2, UnitClass("target"))]
		TargetClassIcon:SetTexCoord(unpack(coord))
		targeticon:Show()
	else
		targeticon:Hide()
	end
	
	-- 焦点
	if UnitIsPlayer("focus") then
		local coord = CLASS_ICON_TCOORDS[select(2, UnitClass("focus"))]
		FrameClassIcon:SetTexCoord(unpack(coord))
		frameicon:Show()
	else
		frameicon:Hide()
	end
end)

-------------头像渐隐效果-------------
local 	Event = CreateFrame("Frame") 
		Event:RegisterEvent("UNIT_HEALTH")
		Event:RegisterEvent("UNIT_POWER_UPDATE")
		Event:RegisterEvent("PLAYER_ENTERING_WORLD",Update) 
		Event:RegisterEvent("PLAYER_REGEN_DISABLED",Update) 
		Event:RegisterEvent("PLAYER_REGEN_ENABLED") 
		Event:RegisterEvent("UNIT_TARGET",Update) 
		Event:RegisterEvent("PLAYER_TARGET_CHANGED")
Event:SetScript("OnEvent",function(self, event, ...) 
	if fade then
		local InCombat, Target = InCombatLockdown(),UnitExists("target")
		if event == "PLAYER_ENTERING_WORLD" and (UnitHealth("player") / UnitHealthMax("player") == 1) then 
		PlayerFrame:SetAlpha(0.5) ----登陆后满血头像透明度为0.5 
		end
		if (InCombat or Target) then
			PlayerFrame:SetAlpha(1) ----进入战斗有目标头像透明度为1 
		end
		if  (not InCombat or not Target) then 
			local _, class = UnitClass("player");
			if not (class == "ROGUE") or not (class == "WARRIOR") then
				if (UnitHealth("player") / UnitHealthMax("player") == 1) and (UnitPower("player") / UnitPowerMax("player") == 1) and ( not InCombat and not Target ) then 
					PlayerFrame:SetAlpha(0.5) ---满血满蓝无战斗无目标 头像透明度为0.5 
				else
					PlayerFrame:SetAlpha(1)	
				end
			end			
			if (class == "ROGUE") or (class == "WARRIOR") then
				if (UnitHealth("player") / UnitHealthMax("player") == 1) and ( not InCombat and  not Target ) then
					PlayerFrame:SetAlpha(0.5)  ---满血在战斗且无目标且血量满  头像透明度为0.5
				else
					PlayerFrame:SetAlpha(1)
				end
			end
		end
	end   
end)

-------------PVP仇恨(目标是自己变红)-------------

--目标--
local zt=CreateFrame("Frame",nil,TargetFrame);

zt:SetPoint("BOTTOM",TargetFrame,"TOP",-50,-22);
zt:SetSize(131,22);

zt:SetFrameLevel(1)
zt.t=zt:CreateTexture(nil,"BACKGROUND")
zt.t:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash");

zt.t:SetTexCoord(0,0.9453125,0,select(4,GetBuildInfo())<20000 and 0.181640625 or 0.7265625);
zt.t:SetPoint("TOPLEFT",-24,0);
zt.t:SetSize(242,93);
		
zt:Hide() 

--焦点--
local zf=CreateFrame("Frame",nil,FocusFrame);

zf:SetPoint("BOTTOM",FocusFrame,"TOP",-50,-22);
zf:SetSize(131,22);

zf:SetFrameLevel(1)
zf.t=zf:CreateTexture(nil,"BACKGROUND")
zf.t:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash");

zf.t:SetTexCoord(0,0.9453125,0,select(4,GetBuildInfo())<20000 and 0.181640625 or 0.7265625);
zf.t:SetPoint("TOPLEFT",-24,0);
zf.t:SetSize(242,93);
		
zf:Hide() 

--判断目标是否为玩家且开启pvp仇恨显示-- 
local function FrameOnUpdate(self) 
if (UnitAffectingCombat("target") and UnitCanAttack("player","target") and UnitIsPlayer("target"))then 
--判断是否为玩家-- 
--if (UnitAffectingCombat("target") and UnitCanAttack("player","target") and UnitIsPlayer("target") )then 
--不判断-- 
--if (UnitAffectingCombat("target") and UnitCanAttack("player","target"))then 
	self:Show() 
	else
	self:Hide() 
	end 
end

--判断焦点是否为玩家且开启pvp仇恨显示-- 
local function FrameOnUpdateFocus(fr) 
if (UnitAffectingCombat("focus") and UnitCanAttack("player","focus") and UnitIsPlayer("focus"))then 
	fr:Show() 
	else
	fr:Hide() 
	end 
end

local gt = CreateFrame("Frame") 
gt:SetScript("OnUpdate", function(self)
	if (UnitIsUnit("targettarget", "player")) then
		zt.t:SetVertexColor(1,0,0,1)
	else
		zt.t:SetVertexColor(0.8,0.8,0.8,1)
	end
FrameOnUpdate(zt)
end) 

local gf = CreateFrame("Frame") 
gf:SetScript("OnUpdate", function(self)
	if (UnitIsUnit("targettarget", "player")) then
		zf.t:SetVertexColor(1,0,0,1)
	else
		zf.t:SetVertexColor(0.8,0.8,0.8,1)
	end
FrameOnUpdateFocus(zf)
end) 


