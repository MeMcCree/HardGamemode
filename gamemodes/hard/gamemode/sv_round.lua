HG_ROUNDSTATE = 0
HG_ROUNDTIME = 0
HG_ROUNDNUMBER = 0

function StartRound()
	HG_ROUNDSTATE = 1
	SetGlobalBool("RoundState", HG_ROUNDSTATE)
	HG_ROUNDNUMBER = HG_ROUNDNUMBER + 1
	SetGlobalInt("RoundNumber", HG_ROUNDNUMBER)
	RoundInit()
end

function InitRoundUnFreezePlayers()

	for _, ply in ipairs(player.GetAll()) do
		ply:Freeze(false)
	end

end

function EndRound()
	HG_ROUNDSTATE = 0
	HG_ROUNDTIME = 0
	SetGlobalInt("RoundTime", HG_ROUNDTIME)
	SetGlobalBool("RoundState", HG_ROUNDSTATE)
	if(timer.Exists("RoundTimer")) then
		timer.Remove("RoundTimer")
	end
	//EndRoundFreezePlayers()
	net.Start("showlobby")
	net.Broadcast()
end

function EndRoundFreezePlayers()

	for _, ply in ipairs(player.GetAll()) do
		ply:Freeze(true)
	end

end

function RoundInit()
	RoundInitTimer()
	InitRoundUnFreezePlayers()
end

function RoundInitTimer()
	HG_ROUNDTIME = 0
	timer.Create("RoundTimer", 1, 0, function()
		HG_ROUNDTIME = HG_ROUNDTIME + 1
		SetGlobalInt("RoundTime", HG_ROUNDTIME)
	end)
end

function GM:PlayerDeath(vic, inf, att)
	if(player.GetAliveCount() < 1) then
		EndRound()
	else
		vic:SetObserverMode(0)
	end
end