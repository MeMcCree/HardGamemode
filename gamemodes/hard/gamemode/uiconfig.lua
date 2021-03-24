hg = {}

hg.uicolors = {
	hr = Color(21, 26, 31),
	main = Color(24, 30, 37),
	outline = Color(179, 57, 57),
	staminabarfill = Color(255, 255, 117, 255),
	staminabarempty = Color(0, 0, 0, 100),
	roundbar = Color(0, 0, 0, 100),
	secondary = Color(30, 39, 46),
	bg = Color(21, 25, 33),

	txt = {
		hr = Color(230, 230, 240),
		roundtimer = Color(255, 255, 117, 255),
		readyon = Color(100, 255, 100),
		readyoff = Color(255, 100, 100),
	},
}

hg.uisizes = {
	hr = {tall = 64},
	info = {tall = 64, margin = {0, 0, 0, 0}},
	infopl = {tall = 48, margin = {0, 0, 0, 0}},
	staminabar = {tall = 24, yinset = 8, xinset = 8},
	roundbar = {tall = 64},
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

hg.uirolechar = function(ply)
	return string.upper(string.sub( ply:GetUserGroup(), 1, 1 )) .. ": "
end

hg.uifont("closebtn", 32, "Roboto", 500)
hg.uifont("title", 32, "Roboto", 400)
hg.uifont("info", 18, "Roboto", 400)
hg.uifont("infoname", 20, "Roboto", 550)
hg.uifont("roundtimer", 32, "Roboto", 500)