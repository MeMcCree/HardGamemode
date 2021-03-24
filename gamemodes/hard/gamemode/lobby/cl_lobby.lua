local HG_LOBBY = HG_LOBBY or {}

local HG_LOBBY_STATE = HG_LOBBY_STATE or 0 -- 0 means inactive

local HG_LOBBY_TIMER = HG_LOBBY_TIMER or 60

net.Receive("openlobby", function()
    
end)
net.Receive("closelobby", function()
    CloseLobby()
end)

net.Receive("SendLobby", function()
    HG_LOBBY = net.ReadTable()
    UpdateLobby()
end)

net.Receive("UpdateLobbyState", function()
    HG_LOBBY_STATE = net.ReadBool()
end)

net.Receive("UpdateLobbyTimer", function()
    HG_LOBBY_TIMER = net.ReadInt(16)
    UpdateLobbyTimer()
end)

function OpenLobby()
    local SW, SH = ScrW(), ScrH()
	local FW, FH = SW / 1.9, SH / 1.35

	Lobby = vgui.Create("DPanel")
	Lobby:SetPos(SW / 2 - FW / 2, FH * 0.1)
	Lobby:SetSize(FW, FH)
	Lobby.Paint = function(pnl, w, h)
		surface.SetDrawColor(hg.uicolors.main.r, hg.uicolors.main.g, hg.uicolors.main.b, 155)
		surface.DrawRect(0, 0, w, h)
	end

	Lobby.header = Lobby:Add("DPanel")
	Lobby.header:Dock(TOP)
	Lobby.header:SetTall(hg.uisizes.hr.tall)
	Lobby.header.Paint = function(pnl, w, h)
		surface.SetDrawColor(hg.uicolors.hr.r, hg.uicolors.hr.g, hg.uicolors.hr.b, 155)
		surface.DrawRect(0, 0, w, h)	
	end

	Lobby.header.title = Lobby.header:Add("DLabel")
	Lobby.header.title:Dock(LEFT)
	Lobby.header.title:SetFont("hgtitle")
	Lobby.header.title:SetTextColor(hg.uicolors.txt.hr)
	Lobby.header.title:SetText("Lobby")
	Lobby.header.title:SetTextInset(16, 0)
	Lobby.header.title:SizeToContents()

	Lobby.PlayerList = Lobby:Add( "DListView" )
	Lobby.PlayerList:Dock( FILL )
	Lobby.PlayerList:SetMultiSelect( false )
	Lobby.PlayerList:AddColumn( "Nickname" )
	Lobby.PlayerList:AddColumn( "Class" )
	Lobby.PlayerList:AddColumn( "Rank" )
	Lobby.PlayerList:AddColumn( "Ready" )
	Lobby.PlayerList:SetHeaderHeight(hg.uisizes.info.tall)
	Lobby.PlayerList:SetDataHeight(hg.uisizes.infopl.tall)
	Lobby.PlayerList.Paint = nil

    Lobby.BtnPanel = Lobby:Add("DPanel")
    Lobby.BtnPanel:Dock(BOTTOM)
    Lobby.BtnPanel.Paint = nil 
    Lobby.BtnPanel:SetTall(80)
    Lobby.BtnPanel.ReadyBtn = Lobby.BtnPanel:Add('DButton')
    Lobby.BtnPanel.ReadyBtn:Dock(RIGHT)
    Lobby.BtnPanel.ReadyBtn:SetWide(160)

    Lobby.BtnPanel.Timer = Lobby.BtnPanel:Add('DLabel')
    Lobby.BtnPanel.Timer:Dock(LEFT)
    Lobby.BtnPanel.Timer:SetWide(160)
    Lobby.BtnPanel.Timer:SetText(HG_LOBBY_TIMER)
    Lobby.BtnPanel.Timer:SetTextColor( hg.uicolors.txt.h1 )
    Lobby.BtnPanel.Timer:SetFont("hgtitle")

    function Lobby.UpdateContents()
        Lobby.PlayerList:Clear()
        for k, v in pairs( HG_LOBBY ) do
            local line = Lobby.PlayerList:AddLine( hg.uirolechar(k) .. k:Name(), "class", "rank", v )
            function line:Paint( w, h )
                surface.SetDrawColor(hg.uicolors.hr.r, hg.uicolors.hr.g, hg.uicolors.hr.b, 205)
                surface.DrawRect(0, 0, w, h)
            end

            for _, k in ipairs(line:GetChildren()) do
                k:SetContentAlignment(5)
                k:SetFont("hginfo")
                k:SetTextColor( v and hg.uicolors.txt.readyon or  hg.uicolors.txt.readyoff )
            end
        end

        for _, v in ipairs(Lobby.PlayerList.Columns) do
            function v.Header:Paint(w, h)
                surface.SetDrawColor(hg.uicolors.hr.r, hg.uicolors.hr.g, hg.uicolors.hr.b, 235)
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(hg.uicolors.outline.r, hg.uicolors.outline.g, hg.uicolors.outline.b, 235)
                surface.DrawRect(0, h-2, w, 2)
            end

            v.Header:SetContentAlignment(5)
            v.Header:SetFont("hginfo")
            v.Header:SetTextColor( hg.uicolors.txt.hr )
        end
        Lobby.BtnPanel.Ready = HG_LOBBY[LocalPlayer()] or false
        Lobby.BtnPanel.ReadyBtn:SetText(Lobby.BtnPanel.Ready and "Ready" or "Not ready")
        Lobby.BtnPanel.ReadyBtn:SetTextColor( Lobby.BtnPanel.Ready and hg.uicolors.txt.readyon or  hg.uicolors.txt.readyoff )
        Lobby.BtnPanel.ReadyBtn:SetFont("hginfo")
        Lobby.BtnPanel.ReadyBtn.Paint = function(me, w, h)
            local color = Lobby.BtnPanel.Ready and hg.uicolors.txt.readyon or  hg.uicolors.txt.readyoff
            surface.SetDrawColor(color.r, color.g, color.b, color.a)

            hg.uidrawoutline(0, 0, w, h, 1)
        end
        Lobby.BtnPanel.ReadyBtn.DoClick = function(me)
            net.Start("UpdateReadyState")
                net.WriteEntity(LocalPlayer())
            net.SendToServer()
        end
    end

    Lobby.UpdateContents()
end

function UpdateLobby()
    if(IsValid(Lobby)) then
        Lobby.UpdateContents()
    end
end

function UpdateLobbyTimer()
    if(IsValid(Lobby)) then
        Lobby.BtnPanel.Timer:SetText(HG_LOBBY_TIMER)
    end
end

function CloseLobby()
    if(IsValid(Lobby)) then
        Lobby:Remove()
    end
end