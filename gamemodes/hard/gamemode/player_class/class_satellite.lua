DEFINE_BASECLASS( "player_base" )
local PLAYER = {} 

PLAYER.WalkSpeed = 200
PLAYER.RunSpeed  = 350
PLAYER.MaxArmor = 100
PLAYER.MaxStamina = 100
PLAYER.StaminaRegen = 5
PLAYER.DecayMul = 1
 
function PLAYER:Loadout()
 
 	self.Player:RemoveAllAmmo()
 	
 	self.Player:Give( "weapon_crowbar" )
 	self.Player:Give( "weapon_stunstick" )
 	self.Player:Give( "weapon_fists" )
 	self.Player:Give( "weapon_alyxgun" )
 	self.Player:GiveAmmo(999, "AlyxGun")
end

function PLAYER:SetupDataTables()
	self.Player:NetworkVar( "String", 0, "Class" )
	self.Player:NetworkVar( "Int", 1, "Rank" )
	self.Player:NetworkVar( "Int", 2, "Score" )
end

function PLAYER:SetModel()
	self.Player:SetModel("models/player/Group02/male_02.mdl")
end

function PLAYER:GetMaxStamina()
	return self.MaxStamina
end

function PLAYER:GetStaminaRegen()
	return self.StaminaRegen
end

function PLAYER:GetStaminaDecayMul()
	return self.DecayMul
end

player_manager.RegisterClass( "class_satellite", PLAYER, "player_base" )