if AZP == nil then AZP = {} end
if AZP.VersionControl == nil then AZP.VersionControl = {} end
if AZP.OnLoad == nil then AZP.OnLoad = {} end
if AZP.OnEvent == nil then AZP.OnEvent = {} end
if AZP.OnEvent == nil then AZP.OnEvent = {} end

AZP.VersionControl.EasierGreatVault = 5
AZP.EasierGreatVault = {}

local dash = " - "
local name = "Easier GreatVault"
local nameFull = ("AzerPUG " .. name)
local promo = (nameFull .. dash ..  AZP.VersionControl.EasierGreatVault)
local optionHeader = "|cFF00FFFFEasier GreatVault|r"
local AZPEGVSelfOptionPanel = nil


function AZP.EasierGreatVault:OnLoadSelf()
    local eventFrame = CreateFrame("Frame")
    eventFrame:SetScript("OnEvent", AZP.OnEvent.EasierGreatVault)
    eventFrame:RegisterEvent("ADDON_LOADED")

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
    AZP.Core:RegisterEvents("ADDON_LOADED", AZP.EasierGreatVault.eventOnOtherAddonLoaded)
    AZP.OptionsPanels:Generic("Easier Great Vault", optionHeader, function (frame)
        AZP.EasierGreatVault:FillOptionsPanel(frame)
    end)
end

function AZP.EasierGreatVault.eventOnOtherAddonLoaded(addon)
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


function AZP.OnEvent.EasierGreatVault(self, event, ...)
    if event == "ADDON_LOADED" then
        AZP.EasierGreatVault.eventOnOtherAddonLoaded(...)
    end
end

function AZP.EasierGreatVault:FillOptionsPanel(frameToFill)
    -- GreatVaultSubPanelPHTitle:Hide()
    -- GreatVaultSubPanelPHText:Hide()
    -- GreatVaultSubPanelPHTitle:SetParent(nil)
    -- GreatVaultSubPanelPHText:SetParent(nil)

    -- local GreatVaultSubPanelHeader = GreatVaultSubPanel:CreateFontString("GreatVaultSubPanelHeader", "ARTWORK", "GameFontNormalHuge")
    -- GreatVaultSubPanelHeader:SetText(promo)
    -- GreatVaultSubPanelHeader:SetWidth(GreatVaultSubPanel:GetWidth())
    -- GreatVaultSubPanelHeader:SetHeight(GreatVaultSubPanel:GetHeight())
    -- GreatVaultSubPanelHeader:SetPoint("TOP", 0, -10)

    -- local GreatVaultSubPanelText = GreatVaultSubPanel:CreateFontString("GreatVaultSubPanelText", "ARTWORK", "GameFontNormalLarge")
    -- GreatVaultSubPanelText:SetWidth(GreatVaultSubPanel:GetWidth())
    -- GreatVaultSubPanelText:SetHeight(GreatVaultSubPanel:GetHeight())
    -- GreatVaultSubPanelText:SetPoint("TOPLEFT", 0, -50)
    -- GreatVaultSubPanelText:SetText(
    --     "AzerPUG's Easier GreatVault' does not have options yet.\n" ..
    --     "For feature requests visit our Discord Server!"
    -- )
end

if not IsAddOnLoaded("AzerPUG's Core") then
    AZP.EasierGreatVault:OnLoadSelf()
end