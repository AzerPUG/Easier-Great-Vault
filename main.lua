local GlobalAddonName, AIU = ...

local AZPIUGreatVaultVersion = 4
local dash = " - "
local name = "InstanceUtility" .. dash .. "GreatVault"
local nameFull = ("AzerPUG " .. name)
local promo = (nameFull .. dash ..  AZPIUGreatVaultVersion)

local addonMain = LibStub("AceAddon-3.0"):NewAddon("InstanceUtility-GreatVault", "AceConsole-3.0")

local ModuleStats = AZP.IU.ModuleStats

function AZP.IU.VersionControl:GreatVault()
    return AZPIUGreatVaultVersion
end

function AZP.IU.OnLoad:GreatVault(self)
    ModuleStats["Frames"]["GreatVault"]:SetSize(150, 50)
    addonMain:ChangeOptionsText()

    local AZPGVButton = CreateFrame("Button", nil, ModuleStats["Frames"]["GreatVault"], "UIPanelButtonTemplate")
    AZPGVButton.contentText = AZPGVButton:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    AZPGVButton.contentText:SetText("Open Great Vault!")
    AZPGVButton:SetWidth("100")
    AZPGVButton:SetHeight("25")
    AZPGVButton.contentText:SetWidth("100")
    AZPGVButton.contentText:SetHeight("15")
    AZPGVButton:SetPoint("TOPLEFT", 25, -10)
    AZPGVButton.contentText:SetPoint("CENTER", 0, -1)
    AZPGVButton:SetScript("OnClick", function()
        LoadAddOn("Blizzard_WeeklyRewards")
        if WeeklyRewardsFrame:IsShown() then
            WeeklyRewardsFrame:Hide()
        else
            WeeklyRewardsFrame:Show()
        end
    end )

    local AZPGVCovButton

    AZP.AddonHelper:DelayedExecution(10, 
    function()  
        AZPGVCovButton = CreateFrame("Button", nil, GarrisonLandingPage, "UIPanelButtonTemplate")
        AZPGVCovButton.contentText = AZPGVCovButton:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
        AZPGVCovButton.contentText:SetText("Great Vault!")
        AZPGVCovButton:SetWidth("75")
        AZPGVCovButton:SetHeight("25")
        AZPGVCovButton.contentText:SetWidth("75")
        AZPGVCovButton.contentText:SetHeight("25")
        AZPGVCovButton:SetPoint("TOPLEFT", 100, -10)
        AZPGVCovButton.contentText:SetPoint("CENTER", 0, -1)
        AZPGVCovButton:SetScript("OnClick",
        function()
            LoadAddOn("Blizzard_WeeklyRewards")
            if WeeklyRewardsFrame:IsShown() then
                WeeklyRewardsFrame:Hide()
            else
                WeeklyRewardsFrame:Show()
            end
        end )
    end)
end

function AZP.IU.OnEvent:GreatVault(event, ...)
end

function addonMain:ChangeOptionsText()
    GreatVaultSubPanelPHTitle:Hide()
    GreatVaultSubPanelPHText:Hide()
    GreatVaultSubPanelPHTitle:SetParent(nil)
    GreatVaultSubPanelPHText:SetParent(nil)

    local GreatVaultSubPanelHeader = GreatVaultSubPanel:CreateFontString("GreatVaultSubPanelHeader", "ARTWORK", "GameFontNormalHuge")
    GreatVaultSubPanelHeader:SetText(promo)
    GreatVaultSubPanelHeader:SetWidth(GreatVaultSubPanel:GetWidth())
    GreatVaultSubPanelHeader:SetHeight(GreatVaultSubPanel:GetHeight())
    GreatVaultSubPanelHeader:SetPoint("TOP", 0, -10)

    local GreatVaultSubPanelText = GreatVaultSubPanel:CreateFontString("GreatVaultSubPanelText", "ARTWORK", "GameFontNormalLarge")
    GreatVaultSubPanelText:SetWidth(GreatVaultSubPanel:GetWidth())
    GreatVaultSubPanelText:SetHeight(GreatVaultSubPanel:GetHeight())
    GreatVaultSubPanelText:SetPoint("TOPLEFT", 0, -50)
    GreatVaultSubPanelText:SetText(
        "AzerPUG-GameUtility-GreatVault does not have options yet.\n" ..
        "For feature requests visit our Discord Server!"
    )
end
