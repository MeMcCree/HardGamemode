function player.GetAliveCount()
	local plys = player.GetAll()

	local count = 0
	for _, ply in ipairs(plys) do
		if(ply:Alive()) then
			count = count + 1
		end
	end

	return count
end