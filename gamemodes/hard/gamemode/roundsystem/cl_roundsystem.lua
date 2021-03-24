HG_RoundStatus = 0 -- 0 end 1 active

net.Receive("UpdateRoundStatus", function()
    HG_RoundStatus = net.ReadBool()
end)

function GetRoundStatus()

    return HG_RoundStatus

end