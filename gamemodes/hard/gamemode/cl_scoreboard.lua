scoreboard = scoreboard or {}

function scoreboard:show()

	local Scoreboard = vgui.Create("DFrame")
	Scoreboard:SetPos(ScrW()/4,0)
	Scoreboard:SetSize( 200, 200 ) 
	Scoreboard:SetTitle( "" ) 
	Scoreboard:SetVisible( true ) 
	Scoreboard:SetDraggable( false ) 
	Scoreboard:ShowCloseButton( false ) 
	Scoreboard:MakePopup()

	local sizeW , sizeH, time, delay, ease = ScrW()/2 , ScrH()/1.5, 1, 0, .15
	local isAnimating = true
	Scoreboard:SizeTo( sizeW, sizeH, time, delay, ease ,function()
		local isAnimating = false
	end)

	function Scoreboard:Paint( w, h )
		draw.RoundedBox( 1, 0, 0, w, h, Color( 14,20,27 ) )
		draw.RoundedBox( 1, 0, 0, w, 30, Color( 20,30,37 ) )
		draw.SimpleText("Scoreboard", "HudSelectionText", 5, 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end

	local DScrollPanel = vgui.Create( "DScrollPanel", Scoreboard )
	DScrollPanel:Dock( FILL )

	local sbar = DScrollPanel:GetVBar()
	function sbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnUp:Paint(w, h)	
	end
	function sbar.btnDown:Paint(w, h)
	end

	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(8, 5, 0, w-5, h, Color(45, 45, 55))
	end

	for _,v in ipairs(team.GetAllTeams()) do
		if v.Joinable then
			local TeamIndex = table.KeyFromValue(team.GetAllTeams(), v)
			local TeamPanel = DScrollPanel:Add( "DPanel" )
			TeamPanel:Dock(TOP)
			TeamPanel:DockMargin(15, 10,15,0)
			TeamPanel:SetTall(35)
			TeamPanel:SetText("")
			TeamPanel.Paint = function(me,w,h)
				draw.RoundedBox(0, 0, 0, w, h, v.Color)
				draw.SimpleText(v.Name, "HudHintTextLarge", 10, 10, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

				draw.SimpleText("Name", "HudHintTextLarge", 100, 10, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

				draw.SimpleText("Frags", "HudHintTextLarge", 190, 10, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

				draw.SimpleText("Deaths", "HudHintTextLarge", 280, 10, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

				draw.SimpleText("Ping", "HudHintTextLarge", 370, 10, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			end

			for _,k in ipairs(team.GetPlayers(TeamIndex)) do
				local PlayerPanel = DScrollPanel:Add( "DPanel" )
				PlayerPanel:Dock(TOP)
				PlayerPanel:DockMargin(15, 5,0,0)
				PlayerPanel:SetTall(55)
				PlayerPanel:SetText("")
				PlayerPanel.Paint = function(me,w,h)
					draw.SimpleText(k:Name(), "HudHintTextLarge", 100, 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

					draw.SimpleText(k:Frags(), "HudHintTextLarge", 190, 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

					draw.SimpleText(k:Deaths(), "HudHintTextLarge", 280, 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

					draw.SimpleText(k:Ping(), "HudHintTextLarge", 370, 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				
					draw.SimpleText(k:GetMoney(), "HudHintTextLarge", 460, 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

					draw.SimpleText(k:GetLvl(), "HudHintTextLarge", 550, 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				end

				PlayerPanel.model = vgui.Create("DModelPanel", PlayerPanel)
				PlayerPanel.model:SetPos(25,0)
				PlayerPanel.model:SetModel( k:GetModel())
				PlayerPanel.model:SetSize(	50, 50 )
				PlayerPanel.model:SetCamPos( Vector( 40, 40, 60 ) )
				PlayerPanel.model:SetLookAt( Vector( 0, 0, 60 ) )
				PlayerPanel.model:SetFOV(30)
			end
			
		end
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