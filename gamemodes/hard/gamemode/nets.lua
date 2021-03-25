local NetList = {
	"UpdateRoundStatus",
	"openlobby",
	"closelobby",
	"UpdateLobbyTimer",
	"SendPlayersInLobby",
	"SendLobbyTimer",
	"UpdateReadyState",
	"UpdateLobbyState",
	"SendLobby",
	"textleaderboard"
}

for _, v in ipairs(NetList) do
	util.AddNetworkString(v)
end