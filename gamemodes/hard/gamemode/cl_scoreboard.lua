scoreboard = scoreboard or {}

function scoreboard:show()

	local W, H = ScrW() / 3, ScrH() / 2
	local HeaderHeight = 60

	local Scoreboard = vgui.Create("DFrame")
	Scoreboard:SetPos(ScrW() / 2 - W * 0.75, -H)
	Scoreboard:SetSize( W, H ) 
	Scoreboard:SetTitle( "" ) 
	Scoreboard:SetVisible( true ) 
	Scoreboard:SetDraggable( false ) 
	Scoreboard:ShowCloseButton( false ) 
	Scoreboard:MakePopup()
	local isAnimating = false

	Scoreboard:MoveTo(ScrW() / 2 - W * 0.75, 0, 1, 0, 0.01, function()
		isAnimating = true
	end)

	function Scoreboard:Paint( w, h )
		draw.RoundedBox( 1, 0, 0, w, h, Color( 14,20,27 ) )
		draw.RoundedBox( 1, 0, 0, w, HeaderHeight, Color( 20,30,37 ) )
		draw.SimpleText("Scoreboard", "HudSelectionText", 5, HeaderHeight / 2 - 10, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end

	local scroll = Scoreboard:Add("DScrollPanel")
	scroll:Dock( FILL )

	local sbar = scroll:GetVBar()
	sbar.Paint = nil
	sbar.btnUp.Paint = nil
	sbar.btnDown.Paint = nil
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(8, 5, 0, w-5, h, Color(45, 45, 55))
	end

	for _, v in ipairs(player.GetAll()) do
		local PlayerPanel = scroll:Add( "DPanel" )
		PlayerPanel:Dock(TOP)
		PlayerPanel:DockMargin(15, HeaderHeight, 0, 0)
		PlayerPanel:SetTall(60)
		PlayerPanel:SetText("")
		PlayerPanel.Paint = function(me,w,h)
			draw.SimpleText(v:Name(), "HudHintTextLarge", 100, 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			draw.SimpleText(v:Frags(), "HudHintTextLarge", 190, 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			draw.SimpleText(v:Deaths(), "HudHintTextLarge", 280, 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			draw.SimpleText(v:Ping(), "HudHintTextLarge", 370, 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		end

		PlayerPanel.model = vgui.Create("DModelPanel", PlayerPanel)
		PlayerPanel.model:SetPos(25,0)
		PlayerPanel.model:SetModel( v:GetModel())
		PlayerPanel.model:SetSize(	50, 50 )
		PlayerPanel.model:SetCamPos( Vector( 40, 40, 60 ) )
		PlayerPanel.model:SetLookAt( Vector( 0, 0, 60 ) )
		PlayerPanel.model:SetFOV(30)
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