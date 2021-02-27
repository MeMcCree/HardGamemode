hg = {}

hg.uicolors = {
	hr = Color(21, 26, 31),
	main = Color(24, 30, 37),
	outline = Color(179, 57, 57),

	txt = {
		hr = Color(230, 230, 240),
	}
}

hg.uisizes = {
	hr = {tall = 64},
	info = {tall = 64, margin = {0, 0, 0, 0}, txtoffset = ScrW() / 19.8, txtwide = ScrW() / 19.8},
	infopl = {tall = 64, margin = {0, 2, 0, 0}, txtoffset = ScrW() / 19.8, txtwide = ScrW() / 19.8},
	spacer = {tall = 8},
}

hg.uifont = function(name, size, font, weight)
	surface.CreateFont("hg" .. name, 
	{
		font = font or "Arial",
		size = size or 16,
		weight = weight or 500
	})
end

hg.uidrawoutline = function(x, y, w, h, outwidth)
	for i = 0, outwidth do
		
		surface.DrawOutlinedRect(x + i, y + i, w - i * 2, h - i * 2)

	end
end

hg.createinfo = function(pnl, ply)
	if ply == nil or pnl == nil then return false end
	pnl.name = pnl:Add("DLabel")
	pnl.name:Dock(LEFT)
	pnl.name:DockMargin(hg.uisizes.info.txtoffset,
									   0,
									   0,
									   0
									   )
	pnl.name:SetFont("hginfoplayer")
	pnl.name:SetTextColor(hg.uicolors.txt.hr)
	pnl.name:SetText(ply:Nick())
	pnl.name:SetWide(hg.uisizes.info.txtwide)

	pnl.class = pnl:Add("DLabel")
	pnl.class:Dock(LEFT)
	pnl.class:DockMargin(hg.uisizes.info.txtoffset,
									   0,
									   0,
									   0
									   )
	pnl.class:SetFont("hginfoplayer")
	pnl.class:SetTextColor(hg.uicolors.txt.hr)
	pnl.class:SetText("placeholder")
	pnl.class:SetWide(hg.uisizes.info.txtwide)

	pnl.score = pnl:Add("DLabel")
	pnl.score:Dock(LEFT)
	pnl.score:DockMargin(hg.uisizes.info.txtoffset,
									   0,
									   0,
									   0
									   )
	pnl.score:SetFont("hginfoplayer")
	pnl.score:SetTextColor(hg.uicolors.txt.hr)
	pnl.score:SetText("Placeholder")
	pnl.score:SetWide(hg.uisizes.info.txtwide)

	pnl.rank = pnl:Add("DLabel")
	pnl.rank:Dock(LEFT)
	pnl.rank:DockMargin(hg.uisizes.info.txtoffset,
									   0,
									   0,
									   0
									   )
	pnl.rank:SetFont("hginfoplayer")
	pnl.rank:SetTextColor(hg.uicolors.txt.hr)
	pnl.rank:SetText("Placeholder")
	pnl.rank:SetWide(hg.uisizes.info.txtwide)

	pnl.ping = pnl:Add("DLabel")
	pnl.ping:Dock(LEFT)
	pnl.ping:DockMargin(hg.uisizes.info.txtoffset,
									   0,
									   0,
									   0
									   )
	pnl.ping:SetFont("hginfoplayer")
	pnl.ping:SetTextColor(hg.uicolors.txt.hr)
	pnl.ping:SetText(ply:Ping())
	pnl.ping:SetWide(hg.uisizes.info.txtwide)
end

hg.uifont("closebtn", 32, "Roboto", 500)
hg.uifont("title", 32, "Roboto", 400)
hg.uifont("info", 20, "Roboto", 400)
hg.uifont("infoplayer", 20, "Roboto", 400)