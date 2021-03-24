HGRoundActive = HGRoundActive or 0

function RoundStart()
	local alive = CountAlive()

	if(table.Count( player.GetAll() ) > 0) then
		HGRoundActive = 1
	end

	UnFreezeAllPlayers()
end

function RoundEndCheck()
	if(HGRoundActive == 0) then return end

	if(CountAlive() < 1) then
        RoundEnd()
    end
end

function UnFreezeAllPlayers()
	for _, ply in ipairs(player.GetAll()) do
		ply:Freeze(false)
	end
end

function RoundEnd()
	Cleanup()
	HGRoundActive = 0
end

function Cleanup()
	game.CleanUpMap(false, {})

	-- Setup Players Stuff
	SetupPlayers()
	--
end

function SetupPlayers()
	for _, v in ipairs(player.GetAll()) do
		if( v:Alive() ) then
			v:KillSilent()
		end
		v:Spawn()
	end
end

function CountAlive()
	local alive = 0

	for _, v in ipairs(player.GetAll()) do
		if(v:Alive() and v:Team() ~= TEAM_SPECTATOR) then alive = alive + 1 end
	end

	return alive
end

function GM:Initialize()
    RoundStart()
end

function GM:PlayerDeath(vid, inf, att)
    RoundEndCheck()
end

function GM:PlayerDeathThink(ply)
    if(HGRoundActive == 0) then
        ply:Spawn()
        return true
    else
        return false
    end
end