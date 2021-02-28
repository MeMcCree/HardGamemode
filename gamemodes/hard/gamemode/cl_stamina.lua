local JumpLatch = 0

function CalcMovement(cmd)
	local ply = LocalPlayer()
	local MaxStamina = player_manager.RunClass( ply, "GetMaxStamina" )
	local RegenMul = player_manager.RunClass( ply, "GetStaminaRegen" )
	local DecayMul = player_manager.RunClass( ply, "GetStaminaDecayMul" )

	if(MaxStamina == nil or RegenMul == nil or DecayMul == nil) then return end
	
	local NewButtons = cmd:GetButtons()

	local chg = FrameTime() * 5
	
	if not first then
		
		ply.Stamina = MaxStamina
		ply.NextRegen = 0
		
		first = true
		
	end

	if cmd:KeyDown(IN_SPEED) and ( cmd:KeyDown(IN_FORWARD) or cmd:KeyDown(IN_BACK) or cmd:KeyDown(IN_MOVELEFT) or cmd:KeyDown(IN_MOVERIGHT) ) and (ply:GetVelocity():Length() > 100) and ( ply:OnGround() or ply:WaterLevel() ~= 0 ) and !ply:InVehicle() then
	
		if ply.Stamina <= 0 then
		
			NewButtons = NewButtons - IN_SPEED

		else
			
			
			ply.Stamina = math.Clamp(ply.Stamina - chg * DecayMul, 0, MaxStamina)
			ply.NextRegen = CurTime() + 1

		end
		
	end

	if cmd:KeyDown(IN_JUMP) and ply:OnGround() and !ply:InVehicle() then
	
		if ply.Stamina <= 5 then
		
			NewButtons = NewButtons - IN_JUMP
			
		else

			if not JumpLatch then

				if cmd:KeyDown(IN_SPEED) and ( cmd:KeyDown(IN_FORWARD) or cmd:KeyDown(IN_BACK) or cmd:KeyDown(IN_MOVELEFT) or cmd:KeyDown(IN_MOVERIGHT) ) then
					ply.Stamina = math.Clamp(ply.Stamina - 25 * DecayMul, 0, MaxStamina)
				else
					ply.Stamina = math.Clamp(ply.Stamina - 5 * DecayMul, 0, MaxStamina)
				end

			end
			
			ply.NextRegen = CurTime() + 1.25
			
		end

		JumpLatch = true
		
	elseif not cmd:KeyDown(IN_JUMP) then
		JumpLatch = false
	end

	if ply.NextRegen then
	
		if ply.NextRegen < CurTime() then
			
			
			if (cmd:KeyDown(IN_FORWARD) or cmd:KeyDown(IN_BACK) or cmd:KeyDown(IN_MOVELEFT) or cmd:KeyDown(IN_MOVERIGHT)) then
					ply.Stamina = math.Clamp(ply.Stamina + ( chg * 0.1 * RegenMul ), 0, MaxStamina)
				else
					ply.Stamina = math.Clamp(ply.Stamina + ( chg * 0.5 * RegenMul ), 0, MaxStamina)
			end
			
		end
		
	end
	

	cmd:SetButtons(NewButtons)

end


hook.Add("CreateMove", "Stamina", CalcMovement)

local staminafade = 0

function DrawStaminaBar()
	local ply = LocalPlayer()
	local MaxStamina = player_manager.RunClass( ply, "GetMaxStamina" )
	if ply.Stamina == MaxStamina then
		staminafade = math.Clamp(staminafade - 0.005, 0, 1)
	else
		staminafade = math.Clamp(staminafade + 0.005, 0, 1)
	end

	local SW, SH = ScrW(), ScrH()
	local BW, BH = SW / 6, hg.uisizes.staminabar.tall

	local emptycolor = hg.uicolors.staminabarempty

	local fillcolor = hg.uicolors.staminabarfill

	surface.SetDrawColor(emptycolor.r, emptycolor.g, emptycolor.b, emptycolor.a * staminafade)
	surface.DrawRect(SW / 2 - BW / 2, SH - BH - 24, BW, BH)

	surface.SetDrawColor(fillcolor.r, fillcolor.g, fillcolor.b, fillcolor.a * staminafade)
	surface.DrawRect(SW / 2 - BW / 2 + hg.uisizes.staminabar.xinset,
					 SH - BH - 24 + hg.uisizes.staminabar.yinset,
					 BW * (ply.Stamina / 100) - hg.uisizes.staminabar.xinset * 2,
					 BH - hg.uisizes.staminabar.yinset * 2
					)
end

hook.Add("HUDPaint", "StaminaBar", DrawStaminaBar)