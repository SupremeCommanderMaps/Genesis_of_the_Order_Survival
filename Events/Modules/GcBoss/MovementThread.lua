-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

function Initialize(MainUnit, Stage, FinalPos, Pos1, Pos2, Pos3, Pos4, Pos5, Pos6)
    FinalDestination = FinalPos
    Location1 = Pos1
    Location2 = Pos2
    Location3 = Pos3
    Location4 = Pos4
    Location5 = Pos5
    Location6 = Pos6

	ForkThread(function()      --15 seconds AggresiveMove Eye Cannon Active. 10 seconds MoveOrder Ete Cannon Disabled.
		while true do 
			if MainUnit:IsDead() then
				break
			end
			if not MainUnit:IsDead() then
				local CurrentMoveLocation = MainUnit:GetCurrentMoveLocation()
				Weapon1 = MainUnit:GetWeapon(1) -- Eye Cannon
				Weapon1:SetWeaponEnabled(false)	-- turn it off 

				WaitSeconds(1)
				Locations = GetNewLocations(CurrentMoveLocation)
				IssueClearCommands({MainUnit})
				for i, Position in Locations do 
					IssueMove({MainUnit}, Position)
				end
			end
			WaitSeconds(5.0 * Stage) -- 
			if not MainUnit:IsDead() then
				local CurrentMoveLocation = MainUnit:GetCurrentMoveLocation()
				Weapon1 = MainUnit:GetWeapon(1) -- Eye Cannon
				Weapon1:SetWeaponEnabled(true)	-- turn it on 
				Weapon1:OnEnableWeapon(Weapon1:ResetTarget())
				
				WaitSeconds(1)
				Locations = GetNewLocations(CurrentMoveLocation)
				IssueClearCommands({MainUnit})
				for i, Position in Locations do 
					IssueAggressiveMove({MainUnit}, Position)
				end
			end
			WaitSeconds(7.5 * Stage)
		end
	end)
end

function GetNewLocations(CurrentMoveLocation)
	Progression = ComparePositions(CurrentMoveLocation)
	NewLocationTable = { }
	if Progression == 7 then 
		table.insert(NewLocationTable, FinalDestination)
		return NewLocationTable
	elseif Progression == 6 then
		table.insert(NewLocationTable, Location6)
		table.insert(NewLocationTable, FinalDestination)
		return NewLocationTable
	elseif Progression == 5 then
		table.insert(NewLocationTable, Location5)
		table.insert(NewLocationTable, Location6)
		table.insert(NewLocationTable, FinalDestination)
		return NewLocationTable
	elseif Progression == 4 then
		table.insert(NewLocationTable, Location4)
		table.insert(NewLocationTable, Location5)
		table.insert(NewLocationTable, Location6)
		table.insert(NewLocationTable, FinalDestination)
		return NewLocationTable
	elseif Progression == 3 then
		table.insert(NewLocationTable, Location3)
		table.insert(NewLocationTable, Location4)
		table.insert(NewLocationTable, Location5)
		table.insert(NewLocationTable, Location6)
		table.insert(NewLocationTable, FinalDestination)
		return NewLocationTable
	elseif Progression == 2 then
		table.insert(NewLocationTable, Location2)
		table.insert(NewLocationTable, Location3)
		table.insert(NewLocationTable, Location4)
		table.insert(NewLocationTable, Location5)
		table.insert(NewLocationTable, Location6)
		table.insert(NewLocationTable, FinalDestination)
		return NewLocationTable
	else
		table.insert(NewLocationTable, Location1)
		table.insert(NewLocationTable, Location2)
		table.insert(NewLocationTable, Location3)
		table.insert(NewLocationTable, Location4)
		table.insert(NewLocationTable, Location5)
		table.insert(NewLocationTable, Location6)
		table.insert(NewLocationTable, FinalDestination)
		return NewLocationTable
	end
end

function ComparePositions(CurrentMoveLocation)
	if CurrentMoveLocation[1] == nil then
		CurrentMoveLocation = Location1 
	end
	if CurrentMoveLocation[3] == nil then
		CurrentMoveLocation = Location1 
	end
	local RoundPosX = string.format("%.0f", CurrentMoveLocation[1])
	local RoundPosZ = string.format("%.0f", CurrentMoveLocation[3])
	if RoundPosX == string.format("%.0f", Location1[1]) and RoundPosZ == string.format("%.0f", Location1[3]) then
		return 1
	elseif	RoundPosX == string.format("%.0f", Location2[1]) and RoundPosZ == string.format("%.0f", Location2[3]) then
		return 2
	elseif	RoundPosX == string.format("%.0f", Location3[1]) and RoundPosZ == string.format("%.0f", Location3[3]) then
		return 3
	elseif	RoundPosX == string.format("%.0f", Location4[1]) and RoundPosZ == string.format("%.0f", Location4[3]) then
		return 4
	elseif	RoundPosX == string.format("%.0f", Location5[1]) and RoundPosZ == string.format("%.0f", Location5[3]) then
		return 5
	elseif	RoundPosX == string.format("%.0f", Location6[1]) and RoundPosZ == string.format("%.0f", Location6[3]) then
		return 6
	else
		return 7
	end
end