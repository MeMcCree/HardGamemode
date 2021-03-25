local HUD_MSGTOSCREEN = ""
local HUD_MSGTOSCREENFADE = 0
local HUD_MSGINPROGRESS = false

net.Receive("urugly", function()
  local msg = net.ReadSting()
  local isend = net.ReadBool()

  HUD_MSGTOSCREEN = msg
  HUD_MSGINPROGRESS = isend
end)

hook.Add("HUDPaint", "HUD_MSGTOSCREEN", function()
  if(HUD_MSGTOSCREENFADE > 0) then
    local SW, SH = ScrW(), ScrH()
    surface.SetFont( "Trebuchet24" )
    local MX, MH = surface.GetTextSize( HUD_MSGTOSCREEN )
    MX = SW / 2 - MX / 2

    surface.SetTextPos( MX, MY )
    surface.DrawText( HUD_MSGTOSCREEN )
  end

  if(HUD_MSGINPROGRESS) then
    HUD_MSGTOSCREENFADE = math.Clamp(HUD_MSGTOSCREENFADE + 1, 0, 255)
  else
    HUD_MSGTOSCREENFADE = math.Clamp(HUD_MSGTOSCREENFADE - 1, 0, 255)
  end
end)