AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_scoreboard.lua" )
AddCSLuaFile( "uiconfig.lua" )
AddCSLuaFile( "cl_stamina.lua" )
AddCSLuaFile( "cl_lobby.lua" )
AddCSLuaFile( "cl_round.lua" )

include( "shared.lua" )
include( "nets.lua" )
include( "sv_lobby.lua" )
include( "util.lua" )
include( "sv_round.lua" )

function GM:PlayerInitialSpawn( ply )
	player_manager.SetPlayerClass( ply, "class_satellite" )
	player_manager.RunClass( ply, "Loadout" )
	player_manager.RunClass( ply, "SetModel" )
	player_manager.RunClass( ply, "SetupDataTables" )
end

function GM:PlayerLoadout(ply)
	player_manager.RunClass( ply, "Loadout" )
	player_manager.RunClass( ply, "SetModel" )
end