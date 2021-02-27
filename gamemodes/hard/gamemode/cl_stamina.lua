local JumpLatch = 0

function CalcMovement(cmd)
	local ply = LocalPlayer()
	local MaxStamina = player_manager.RunClass( ply, "GetMaxStamina" )
	local RegenMul = player_manager.RunClass( ply, "GetStaminaRegen" )
	local DecayMul = player_manager.RunClass( ply, "GetStaminaDecayMul" )
	
	local NewButtons = cmd:GetButtons()

	local chg = FrameTime() * 5
	
	if not first then
		
		ply.Stamina = MaxStamina
		ply.NextRegen = 0
		
		first = true
		
	end

	print(ply.Stamina)

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