if AZP == nil then AZP = {} end
if AZP.VersionControl == nil then AZP.VersionControl = {} end
if AZP.OnLoad == nil then AZP.OnLoad = {} end

AZP.VersionControl["Easier GreatVault"] = 8
if AZP.EasierGreatVault == nil then AZP.EasierGreatVault = {} end
if AZP.EasierGreatVault.Events == nil then AZP.EasierGreatVault.Events = {} end

local EventFrame, UpdateFrame = nil, nil
local HaveShowedUpdateNotification = false
local optionHeader = "|cFF00FFFFEasier GreatVault|r"
local AZPEGVSelfOptionPanel = nil

function AZP.EasierGreatVault:OnLoadSelf()
    C_ChatInfo.RegisterAddonMessagePrefix("AZPVERSIONS")
    EventFrame = CreateFrame("Frame")
    EventFrame:SetScript("OnEvent", function(...) AZP.EasierGreatVault:OnEvent(...) end)
    EventFrame:RegisterEvent("ADDON_LOADED")
    EventFrame:RegisterEvent("CHAT_MSG_ADDON")
    EventFrame:RegisterEvent("CHAT_MSG_ADDON")
    EventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")

    UpdateFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    UpdateFrame:SetPoint("CENTER", 0, 250)
    UpdateFrame:SetSize(400, 200)
    UpdateFrame:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 12,
        insets = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    UpdateFrame:SetBackdropColor(0.25, 0.25, 0.25, 0.80)
    UpdateFrame.header = UpdateFrame:CreateFontString("UpdateFrame", "ARTWORK", "GameFontNormalHuge")
    UpdateFrame.header:SetPoint("TOP", 0, -10)
    UpdateFrame.header:SetText("|cFFFF0000AzerPUG's Easier GreatVault is out of date!|r")

    UpdateFrame.text = UpdateFrame:CreateFontString("UpdateFrame", "ARTWORK", "GameFontNormalLarge")
    UpdateFrame.text:SetPoint("TOP", 0, -40)
    UpdateFrame.text:SetText("Error!")

    UpdateFrame:Hide()

    local UpdateFrameCloseButton = CreateFrame("Button", nil, UpdateFrame, "UIPanelCloseButton")
    UpdateFrameCloseButton:SetWidth(25)
    UpdateFrameCloseButton:SetHeight(25)
    UpdateFrameCloseButton:SetPoint("TOPRIGHT", UpdateFrame, "TOPRIGHT", 2, 2)
    UpdateFrameCloseButton:SetScript("OnClick", function() UpdateFrame:Hide() end )

    AZPEGVSelfOptionPanel = CreateFrame("FRAME", nil)
    AZPEGVSelfOptionPanel.name = optionHeader
    InterfaceOptions_AddCategory(AZPEGVSelfOptionPanel)
    AZPEGVSelfOptionPanel.header = AZPEGVSelfOptionPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge")
    AZPEGVSelfOptionPanel.header:SetPoint("TOP", 0, -10)
    AZPEGVSelfOptionPanel.header:SetText(optionHeader)

    AZPEGVSelfOptionPanel.footer = AZPEGVSelfOptionPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    AZPEGVSelfOptionPanel.footer:SetPoint("TOP", 0, -300)
    AZPEGVSelfOptionPanel.footer:SetText(
        "|cFF00FFFFAzerPUG Links:\n" ..
        "Website: www.azerpug.com\n" ..
        "Discord: www.azerpug.com/discord\n" ..
        "Twitch: www.twitch.tv/azerpug\n|r"
    )
    AZP.EasierGreatVault.FillOptionsPanel(AZPEGVSelfOptionPanel)
end

function AZP.EasierGreatVault:OnLoadCore()
    AZP.Core.AddOns.EGV.MainFrame:SetSize(150, 50)
    AZP.Core:RegisterEvents("ADDON_LOADED", function (...) AZP.EasierGreatVault.Events:AddonLoaded(...) end)
    AZP.OptionsPanels:RemovePanel("Easier GreatVault")
    AZP.OptionsPanels:Generic("Easier GreatVault", optionHeader, function(frame)
        AZP.EasierGreatVault:FillOptionsPanel(frame)
    end)
end

function AZP.EasierGreatVault.Events:AddonLoaded(addon)
    if addon == "Blizzard_GarrisonUI" or IsAddOnLoaded("Blizzard_GarrisonUI") then
        if GarrisonLandingPage ~= nil and GarrisonLandingPage.AZPGVCovButton == nil then
            GarrisonLandingPage.AZPGVCovButton = CreateFrame("Button", nil, GarrisonLandingPage, "UIPanelButtonTemplate")
            GarrisonLandingPage.AZPGVCovButton.contentText = GarrisonLandingPage.AZPGVCovButton:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
            GarrisonLandingPage.AZPGVCovButton.contentText:SetText("Great Vault!")
            GarrisonLandingPage.AZPGVCovButton:SetWidth("75")
            GarrisonLandingPage.AZPGVCovButton:SetHeight("25")
            GarrisonLandingPage.AZPGVCovButton.contentText:SetWidth("75")
            GarrisonLandingPage.AZPGVCovButton.contentText:SetHeight("25")
            GarrisonLandingPage.AZPGVCovButton:SetPoint("TOPLEFT", 100, -10)
            GarrisonLandingPage.AZPGVCovButton.contentText:SetPoint("CENTER", 0, -1)
            GarrisonLandingPage.AZPGVCovButton:SetScript("OnClick",
            function()
                LoadAddOn("Blizzard_WeeklyRewards")
                if WeeklyRewardsFrame:IsShown() then
                    WeeklyRewardsFrame:Hide()
                else
                    WeeklyRewardsFrame:Show()
                end
            end )
        end
    end
end

function AZP.EasierGreatVault:DelayedExecution(delayTime, delayedFunction)
    local frame = CreateFrame("Frame")
    frame.start_time = GetServerTime()
    frame:SetScript("OnUpdate",
        function(self)
            if GetServerTime() - self.start_time > delayTime then
                delayedFunction()
                self:SetScript("OnUpdate", nil)
                self:Hide()
            end
        end
    )
    frame:Show()
end

function AZP.EasierGreatVault:ShareVersion()    -- Change DelayedExecution to native WoW Function.
    local versionString = string.format("|EGV:%d|", AZP.VersionControl["Easier GreatVault"])
    AZP.EasierGreatVault:DelayedExecution(10, function()
        if UnitInBattleground("player") ~= nil then
            -- BG stuff?
        else
            if IsInGroup() then
                if IsInRaid() then
                    C_ChatInfo.SendAddonMessage("AZPVERSIONS", versionString ,"RAID", 1)
                else
                    C_ChatInfo.SendAddonMessage("AZPVERSIONS", versionString ,"PARTY", 1)
                end
            end
            if IsInGuild() then
                C_ChatInfo.SendAddonMessage("AZPVERSIONS", versionString ,"GUILD", 1)
            end
        end
    end)
end

function AZP.EasierGreatVault:ReceiveVersion(version)

    if version > AZP.VersionControl["Easier GreatVault"] then
        if (not HaveShowedUpdateNotification) then
            HaveShowedUpdateNotification = true
            UpdateFrame:Show()
            UpdateFrame.text:SetText(
                "Please download the new version through the CurseForge app.\n" ..
                "Or use the CurseForge website to download it manually!\n\n" .. 
                "Newer Version: v" .. version .. "\n" .. 
                "Your version: v" .. AZP.VersionControl["Easier GreatVault"]
            )
        end
    end
end

function AZP.EasierGreatVault:GetSpecificAddonVersion(versionString, addonWanted)
    local pattern = "|([A-Z]+):([0-9]+)|"
    local index = 1
    while index < #versionString do
        local _, endPos = string.find(versionString, pattern, index)
        local addon, version = string.match(versionString, pattern, index)
        index = endPos + 1
        if addon == addonWanted then
            return tonumber(version)
        end
    end
end

function AZP.EasierGreatVault:OnEvent(self, event, ...)
    if event == "CHAT_MSG_ADDON" then
        local prefix, payload, _, sender = ...
        if prefix == "AZPVERSIONS" then
            local version = AZP.EasierGreatVault:GetSpecificAddonVersion(payload, "EGV")
            if version ~= nil then
                AZP.EasierGreatVault:ReceiveVersion(version)
            end
        end
    elseif event == "ADDON_LOADED" then
        AZP.EasierGreatVault.Events:AddonLoaded(...)
    elseif event == "GROUP_ROSTER_UPDATE" then
        AZP.EasierGreatVault:ShareVersion()
    end
end

function AZP.EasierGreatVault:FillOptionsPanel(frameToFill)
end

if not IsAddOnLoaded("AzerPUGsCore") then
    AZP.EasierGreatVault:OnLoadSelf()
end

AZP.SlashCommands["EGV"] = function()
    LoadAddOn("Blizzard_WeeklyRewards")
    if WeeklyRewardsFrame ~= nil then WeeklyRewardsFrame:Show() end
end

AZP.SlashCommands["egv"] = AZP.SlashCommands["EGV"]
AZP.SlashCommands["vault"] = AZP.SlashCommands["EGV"]
AZP.SlashCommands["easier great vault"] = AZP.SlashCommands["EGV"]