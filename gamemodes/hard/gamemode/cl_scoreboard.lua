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

	Scoreboard.infotab = Scoreboard:Add("DPanel")
	Scoreboard.infotab:Dock(TOP)
	Scoreboard.infotab:DockMargin(hg.uisizes.info.margin[1],
								  hg.uisizes.info.margin[2], 
								  hg.uisizes.info.margin[3], 
								  hg.uisizes.info.margin[4]
								  )
	Scoreboard.infotab:SetTall(hg.uisizes.info.tall)
	Scoreboard.infotab.Paint = function(pnl, w, h)
		surface.SetDrawColor(hg.uicolors.main.r, hg.uicolors.main.g, hg.uicolors.main.b, 225)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(hg.uicolors.outline.r, hg.uicolors.outline.g, hg.uicolors.outline.b, 235)
		surface.DrawRect(0, h-3, w, 3)
	end

	Scoreboard.infotab.name = Scoreboard.infotab:Add("DLabel")
	Scoreboard.infotab.name:Dock(LEFT)
	Scoreboard.infotab.name:DockMargin(hg.uisizes.info.txtoffset,
									   0,
									   0,
									   0
									   )
	Scoreboard.infotab.name:SetFont("hginfoname")
	Scoreboard.infotab.name:SetTextColor(hg.uicolors.txt.hr)
	Scoreboard.infotab.name:SetText("Name:")
	Scoreboard.infotab.name:SetWide(hg.uisizes.info.txtwide)

	Scoreboard.infotab.class = Scoreboard.infotab:Add("DLabel")
	Scoreboard.infotab.class:Dock(LEFT)
	Scoreboard.infotab.class:DockMargin(hg.uisizes.info.txtoffset,
									   0,
									   0,
									   0
									   )
	Scoreboard.infotab.class:SetFont("hginfo")
	Scoreboard.infotab.class:SetTextColor(hg.uicolors.txt.hr)
	Scoreboard.infotab.class:SetText("Class:")
	Scoreboard.infotab.class:SetWide(hg.uisizes.info.txtwide)

	Scoreboard.infotab.score = Scoreboard.infotab:Add("DLabel")
	Scoreboard.infotab.score:Dock(LEFT)
	Scoreboard.infotab.score:DockMargin(hg.uisizes.info.txtoffset,
									   0,
									   0,
									   0
									   )
	Scoreboard.infotab.score:SetFont("hginfo")
	Scoreboard.infotab.score:SetTextColor(hg.uicolors.txt.hr)
	Scoreboard.infotab.score:SetText("Score:")
	Scoreboard.infotab.score:SetWide(hg.uisizes.info.txtwide)

	Scoreboard.infotab.rank = Scoreboard.infotab:Add("DLabel")
	Scoreboard.infotab.rank:Dock(LEFT)
	Scoreboard.infotab.rank:DockMargin(hg.uisizes.info.txtoffset,
									   0,
									   0,
									   0
									   )
	Scoreboard.infotab.rank:SetFont("hginfo")
	Scoreboard.infotab.rank:SetTextColor(hg.uicolors.txt.hr)
	Scoreboard.infotab.rank:SetText("Rank:")
	Scoreboard.infotab.rank:SetWide(hg.uisizes.info.txtwide)

	Scoreboard.infotab.ping = Scoreboard.infotab:Add("DLabel")
	Scoreboard.infotab.ping:Dock(LEFT)
	Scoreboard.infotab.ping:DockMargin(hg.uisizes.info.txtoffset,
									   0,
									   0,
									   0
									   )
	Scoreboard.infotab.ping:SetFont("hginfo")
	Scoreboard.infotab.ping:SetTextColor(hg.uicolors.txt.hr)
	Scoreboard.infotab.ping:SetText("Ping:")
	Scoreboard.infotab.ping:SetWide(hg.uisizes.info.txtwide)

	Scoreboard.PlayerList = Scoreboard:Add( "DScrollPanel" )
	Scoreboard.PlayerList:Dock( FILL )
	Scoreboard.PlayerList.Paint = nil
	Scoreboard.PlayerList.spacer = Scoreboard.PlayerList:Add("DPanel")
	Scoreboard.PlayerList.spacer:Dock(TOP)
	Scoreboard.PlayerList.spacer:SetTall(hg.uisizes.spacer.tall)
	Scoreboard.PlayerList.spacer.Paint = nil

	for k, ply in ipairs(player.GetAll()) do
		
		local plpanel = Scoreboard.PlayerList:Add("DPanel")
		plpanel:Dock(TOP)
		plpanel:DockMargin(hg.uisizes.infopl.margin[1],
						   hg.uisizes.infopl.margin[2], 
						   hg.uisizes.infopl.margin[3], 
						   hg.uisizes.infopl.margin[4]
						   )
		plpanel:SetTall(hg.uisizes.info.tall)
		plpanel.Paint = function(pnl, w, h)
			surface.SetDrawColor(hg.uicolors.main.r, hg.uicolors.main.g, hg.uicolors.main.b, 225)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(hg.uicolors.outline.r, hg.uicolors.outline.g, hg.uicolors.outline.b, 235)
			surface.DrawRect(0, h-2, w, 2)
		end
		hg.createinfo(plpanel, ply)
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