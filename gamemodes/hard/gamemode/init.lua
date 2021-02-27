AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_scoreboard.lua" )
AddCSLuaFile( "uiconfig.lua" )
AddCSLuaFile( "cl_stamina.lua" )

include( "shared.lua" )
include( "nets.lua" )

function GM:PlayerInitialSpawn( ply )
	player_manager.SetPlayerClass( ply, "player_base" )
	player_manager.RunClass( ply, "Loadout" )
	player_manager.RunClass( ply, "SetModel" )
	player_manager.RunClass( ply, "SetupDataTables" )
end


function GM:PlayerLoadout(ply)
	player_manager.RunClass( ply, "Loadout" )
	player_manager.RunClass( ply, "SetModel" )
end