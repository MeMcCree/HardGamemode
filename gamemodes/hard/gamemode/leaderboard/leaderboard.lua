print("ugly3") 

hook.Add("PlayerDeath", "checkuglys", leaderscore)

function CountAlive()
    local alive = 0

    for _, v in ipairs(player.GetAll()) do
        if(v:Alive() and v:Team() ~= TEAM_SPECTATOR) then alive = alive + 1 end
    end

    return alive
end

function leaderscore()
    if CountAlive() == 1 then
    print("last stand")  
    end
end
 
print("ugly2")

---text--- 

function DisplayMsg(msg, time)
  net.Start("message")  
  net.WriteString("Ugly Man")
  net.WriteBool(false)
net.Broadcast()

timer.Simple(3, function()
  net.Start("message") 
    net.WriteString("")
    net.WriteBool(true)
  net.Broadcast()
end)
end