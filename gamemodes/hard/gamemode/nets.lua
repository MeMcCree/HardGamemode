local NetList = {
	"UpdateRoundStatus",
	"openlobby",
	"closelobby",
	"UpdateLobbyTimer",
	"SendPlayersInLobby",
	"SendLobbyTimer",
	"UpdateReadyState",
	"UpdateLobbyState",
	"SendLobby"
}

for _, v in ipairs(NetList) do
	util.AddNetworkString(v)
end