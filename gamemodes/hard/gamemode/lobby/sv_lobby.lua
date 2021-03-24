local _P = FindMetaTable("Player")

local HG_LOBBY = HG_LOBBY or {}

local HG_LOBBY_STATE = HG_LOBBY_STATE or 0 -- 0 means inactive

local HG_LOBBY_TIMER = HG_LOBBY_TIMER or 60

function GetLobbyState()
    return HG_LOBBY_STATE
end

function SetLobbyState(val)
    HG_LOBBY_STATE = val
end

function EndLobby()
    HG_LOBBY_STATE = 0

    DestroyLobbyTimer()
    LobbyClear()
    UpdateLobbyState()

    print("Lobby Ended")
    return true
end

function StartLobby()
    HG_LOBBY_STATE = 1

    StartLobbyTimer()
    PutAllPlayersInLobby()
    UpdateLobbyState()

    print("Lobby Started")
    return true
end

function LobbyClear()
    table.Empty(HG_LOBBY)

    SendLobby()
end

function PutAllPlayersInLobby()
    if(HG_LOBBY_STATE == 0) then return false end
    for _, v in ipairs(player.GetAll()) do
        v:JoinLobby()
    end
    return true
end

function _P:JoinLobby()
    if(HG_LOBBY[self] != nil) then return false end

    HG_LOBBY[self] = false

    print(self:Nick() .. " Joined lobby")

    SendLobby()
    return true
end

function _P:LeaveLobby()
    if(HG_LOBBY[self] == nil) then return false end

    HG_LOBBY[self] = nil

    SendLobby()
    return true
end

function StartLobbyTimer()
    if(HG_LOBBY_STATE == 0) then return false end
    if(timer.Exists("Lobby")) then return false end

    print("Timer Started")

    timer.Create("Lobby", 1, 0, LobbyTick)
    return true
end

function DestroyLobbyTimer()
    if(not timer.Exists("Lobby")) then return false end

    timer.Remove("Lobby")
    return true
end

function CheckRoundStart()
    if(HG_LOBBY_STATE == 0) then return false end

    if(HG_LOBBY_TIMER < 1) then
        EndLobby()
        RoundStart()
        return true
    end
end

function ReadyPercentage()
    local num_players = player.GetCount()

    local ready_players = 0

    for _, v in ipairs(player.GetAll()) do
        if(HG_LOBBY[v]) then ready_players = ready_players + 1 end
    end

    return ready_players / num_players
end

function LobbyTick()
    if(ReadyPercentage() > 0.5) then
        HG_LOBBY_TIMER = HG_LOBBY_TIMER - 1
        CheckRoundStart()
        UpdateLobbyTimer()
        return true
    end
end

function UpdateReadyTimer(val)
    if(val) then
        HG_LOBBY_TIMER = HG_LOBBY_TIMER + 15
    else
        HG_LOBBY_TIMER = HG_LOBBY_TIMER - 5
    end
end

function _P:ChangeReadyState()
    print('not funny')
    if(HG_LOBBY[self] == nil) then return false end

    print("funny")

    HG_LOBBY[self] = not HG_LOBBY[self]

    UpdateReadyTimer(HG_LOBBY[self])

    SendLobby()
    return true
end

function PrintLobby()
    for k, v in pairs(HG_LOBBY) do
        print(k, v)
    end
end

function UpdateLobbyState()
    net.Start("UpdateLobbyState")
        net.WriteBool(HG_LOBBY_STATE)
    net.Broadcast()
    return true
end

function UpdateLobbyTimer()
    net.Start("UpdateLobbyTimer")
        net.WriteInt(HG_LOBBY_TIMER, 16)
    net.Broadcast()
    return true
end

function SendLobby()
    net.Start("SendLobby")
        net.WriteTable(HG_LOBBY)
    net.Broadcast()
    return true
end

net.Receive("UpdateReadyState", function()
    local ply = net.ReadEntity()

    ply:ChangeReadyState()
end)