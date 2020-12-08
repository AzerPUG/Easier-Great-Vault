local GlobalAddonName, AIU = ...

local AZPIUGreatVaultVersion = 14
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
    ModuleStats["Frames"]["GreatVault"]:SetSize(110, 150)
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
end
