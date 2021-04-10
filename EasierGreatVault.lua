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
local promo = (nameFull .. dash ..  AZPIUGreatVaultVersion)

local ModuleStats = AZP.IU.ModuleStats

function AZP.VersionControl:EasierGreatVault()
    return AZPIUGreatVaultVersion
end

function AZP.OnLoad:EasierGreatVault(self)
    ModuleStats["Frames"]["EasierGreatVault"]:SetSize(150, 50)
    addonMain:ChangeOptionsText()

    local AZPGVButton = CreateFrame("Button", nil, ModuleStats["Frames"]["EasierGreatVault"], "UIPanelButtonTemplate")
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

function AZP.OnEvent:EasierGreatVault(event, ...)
end

function AZP.EasierGreatVault:ChangeOptionsText()
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
        "AzerPUG's Easier GreatVault' does not have options yet.\n" ..
        "For feature requests visit our Discord Server!"
    )
end
