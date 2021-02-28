function ShowLobby()

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

	for _, v in ipairs( player.GetAll() ) do
		local line = Lobby.PlayerList:AddLine( hg.uirolechar(v) .. v:Name(), "class", "rank", v:GetNWBool("Ready") )
		function line:Paint( w, h )
			surface.SetDrawColor(hg.uicolors.hr.r, hg.uicolors.hr.g, hg.uicolors.hr.b, 205)
			surface.DrawRect(0, 0, w, h)
		end

		for _, k in ipairs(line:GetChildren()) do
			k:SetContentAlignment(5)
			k:SetFont("hginfo")
			k:SetTextColor( hg.uicolors.txt.hr )
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

end

net.Receive("showlobby", ShowLobby)