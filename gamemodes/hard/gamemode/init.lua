AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

-- Include Other Scripts

AddCSLuaFile( "cl_scoreboard.lua" )
AddCSLuaFile( "uiconfig.lua" )
AddCSLuaFile( "cl_stamina.lua" )
AddCSLuaFile( "roundsystem/cl_roundsystem.lua")
AddCSLuaFile( "lobby/cl_lobby.lua")
AddCSLuaFile( "musicsystem/cl_musicsystem.lua")
AddCSLuaFile( "leaderboard/cl_leaderboard.lua")

include( "roundsystem/sv_roundsystem.lua")
include( "lobby/sv_lobby.lua")
include( "musicsystem/sv_musicsystem.lua")
include( "nets.lua" )
include( "leaderboard/leaderboard.lua" )

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