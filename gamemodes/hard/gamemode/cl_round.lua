function DrawRoundState()
	if(GetGlobalBool("RoundState") == 0) then return end
	local SW, SH = ScrW(), ScrH()
	local BW, BH = ScrW() / 12, hg.uisizes.roundbar.tall

	local barcolor = hg.uicolors.roundbar

	local xoffset, yoffset = SW / 2 - BW / 2, 0

	surface.SetDrawColor(barcolor.r, barcolor.g, barcolor.b, barcolor.a)
	surface.DrawRect(xoffset, yoffset, BW, BH)

	draw.SimpleText(GetGlobalInt("RoundTime"),
					"hgroundtimer",
					xoffset + BW / 2, yoffset + 16,
					hg.uicolors.txt.roundtimer,
					1
					)
end

hook.Add("HUDPaint", "DrawRoundState", DrawRoundState)