DEFINE_BASECLASS( "player_default" )
 
local PLAYER = {} 
 
 --
 -- See gamemodes/base/player_class/player_default.lua for all overridable variables
 --
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
 	self.Player:Give( "weapon_pistol" )
 	self.Player:Give( "weapon_357" )
 	self.Player:Give( "weapon_alyxgun" )
 	self.Player:Give( "weapon_smg1" )
 	self.Player:Give( "weapon_ar2" )
 	self.Player:Give( "weapon_shotgun" )
 	self.Player:Give( "weapon_annabelle" )
 	self.Player:Give( "weapon_crossbow" )
 	self.Player:Give( "weapon_frag" )
 	self.Player:Give( "weapon_slam" )
 	self.Player:Give( "weapon_rpg" )
 	self.Player:Give( "weapon_bugbait" )
 	self.Player:Give( "weapon_physcannon" )
 	self.Player:GiveAmmo(999, "AR2")
 	self.Player:GiveAmmo(999, "AR2AltFire")
 	self.Player:GiveAmmo(999, "Pistol")
 	self.Player:GiveAmmo(999, "SMG1")
 	self.Player:GiveAmmo(999, "357")
 	self.Player:GiveAmmo(999, "XBowBolt")
 	self.Player:GiveAmmo(999, "Buckshot")
 	self.Player:GiveAmmo(999, "RPG_Round")
 	self.Player:GiveAmmo(999, "Grenade")
 	self.Player:GiveAmmo(999, "slam")
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

player_manager.RegisterClass( "player_base", PLAYER, "player_default" )