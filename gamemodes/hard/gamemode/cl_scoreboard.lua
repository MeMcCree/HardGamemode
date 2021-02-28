include( "uiconfig.lua" )

scoreboard = scoreboard or {}

function scoreboard:show()

	local SW, SH = ScrW(), ScrH()
	local FW, FH = SW / 1.9, SH / 1.35

	Scoreboard = vgui.Create("DPanel")
	Scoreboard:SetPos(SW / 2 - FW / 2, FH * 0.1)
	Scoreboard:SetSize(FW, FH)
	Scoreboard.Paint = function(pnl, w, h)
		surface.SetDrawColor(hg.uicolors.main.r, hg.uicolors.main.g, hg.uicolors.main.b, 155)
		surface.DrawRect(0, 0, w, h)
	end

	Scoreboard.header = Scoreboard:Add("DPanel")
	Scoreboard.header:Dock(TOP)
	Scoreboard.header:SetTall(hg.uisizes.hr.tall)
	Scoreboard.header.Paint = function(pnl, w, h)
		surface.SetDrawColor(hg.uicolors.hr.r, hg.uicolors.hr.g, hg.uicolors.hr.b, 155)
		surface.DrawRect(0, 0, w, h)	
	end

	Scoreboard.header.title = Scoreboard.header:Add("DLabel")
	Scoreboard.header.title:Dock(LEFT)
	Scoreboard.header.title:SetFont("hgtitle")
	Scoreboard.header.title:SetTextColor(hg.uicolors.txt.hr)
	Scoreboard.header.title:SetText("Scoreboard")
	Scoreboard.header.title:SetTextInset(16, 0)
	Scoreboard.header.title:SizeToContents()

	Scoreboard.PlayerList = Scoreboard:Add( "DListView" )
	Scoreboard.PlayerList:Dock( FILL )
	Scoreboard.PlayerList:SetMultiSelect( false )
	Scoreboard.PlayerList:AddColumn( "Nickname" )
	Scoreboard.PlayerList:AddColumn( "Class" )
	Scoreboard.PlayerList:AddColumn( "Score" )
	Scoreboard.PlayerList:AddColumn( "Rank" )
	Scoreboard.PlayerList:AddColumn( "Ping" )
	Scoreboard.PlayerList:SetHeaderHeight(hg.uisizes.info.tall)
	Scoreboard.PlayerList:SetDataHeight(hg.uisizes.infopl.tall)
	Scoreboard.PlayerList.Paint = nil

	for _, v in ipairs( player.GetAll() ) do
		local line = Scoreboard.PlayerList:AddLine( v:Name(), "10", "10", "10", v:Ping() )
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

	for _, v in ipairs(Scoreboard.PlayerList.Columns) do
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

	function scoreboard:hide()
		Scoreboard:Remove()
	end
end

function GM:ScoreboardShow()
	scoreboard:show()
end

function GM:ScoreboardHide()
	scoreboard:hide()
end