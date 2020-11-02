-- Based on Malik's and Blue's animal shelters and vorp animal shelter --

local keys = { ['G'] = 0x760A9C6F, ["B"] = 0x4CC0E2FE, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9, ["J"] = 0xF3830D8E }

local blips = {
    { name = 'Animal Shelter', sprite = -1646261997,x = -273.51, y = 689.26, z = 113.41 }
}

local pressTime = 0
local pressLeft = 0

local recentlySpawned = 0

local currentPetPed = nil;

local CurrentZoneActive = 0

local dogs = {
	
	{
		['Text'] = "$100 - Chesbay Retriever",
		['SubText'] = "",
		['Desc'] = "Level Required : ~pa~0",
		['Param'] = {
			['Price'] = 100,
			['Model'] = "A_C_DogChesBayRetriever_011",
			['Level'] = 2
		}
	},
	{
		['Text'] = "$500 - Husky",
		['SubText'] = "",
		['Desc'] = "Level Required : ~pa~0",
		['Param'] = {
			['Price'] = 500,
			['Model'] = "A_C_DogHusky_01",
			['Level'] = 2
		}
	},
	{
		['Text'] = "$100 - Labrador Retriever",
		['SubText'] = "",
		['Desc'] = "Level Required : ~pa~0",
		['Param'] = {
			['Price'] = 100,
			['Model'] = "A_C_DogLab_01",
			['Level'] = 2
		}
	},
	{
		['Text'] = "$100 - Rufus",
		['SubText'] = "",
		['Desc'] = "Level Required : ~pa~0",
		['Param'] = {
			['Price'] = 100,
			['Model'] = "A_C_DogRufus_01",
			['Level'] = 2
		}
	},
	{
		['Text'] = "$150 - Coon Hound",
		['SubText'] = "",
		['Desc'] = "Level Required : ~pa~0",
		['Param'] = {
			['Price'] = 150,
			['Model'] = "A_C_DogBluetickCoonhound_01",
			['Level'] = 2
		}
	},
	{
		['Text'] = "$200 - Border Collie",
		['SubText'] = "",
		['Desc'] = "Level Required : ~pa~0",
		['Param'] = {
			['Price'] = 200,
			['Model'] = "A_C_DogCollie_01",
			['Level'] = 2
		}
	},
	{
		['Text'] = "$100 - Ches Bay Retriever",
		['SubText'] = "",
		['Desc'] = "Level Required : ~pa~0",
		['Param'] = {
			['Price'] = 15,
			['Model'] = "A_C_DogChesBayRetriever_01",
			['Level'] = 2
		}
	},
	{
		['Text'] = "$200 - Foxhound",
		['SubText'] = "",
		['Desc'] = "Level Required : ~pa~0",
		['Param'] = {
			['Price'] = 100,
			['Model'] = "A_C_DogAmericanFoxhound_01",
			['Level'] = 2
		}
	},
	{
		['Text'] = "$100 - Cat",
		['SubText'] = "",
		['Desc'] = "Level Required : ~pa~0",
		['Param'] = {
			['Price'] = 15,
			['Model'] = "A_C_Cat_01",
			['Level'] = 2
		}
	},
	{
		['Text'] = "$100 - Bat",
		['SubText'] = "",
		['Desc'] = "Level Required : ~pa~0",
		['Param'] = {
			['Price'] = 100,
			['Model'] = "A_C_Bat_01",
			['Level'] = 2
		}
	},
	{
		['Text'] = "$10000 - Putther",
		['SubText'] = "",
		['Desc'] = "Level Required : ~pa~0",
		['Param'] = {
			['Price'] = 10000,
			['Model'] = "A_C_Bear_01",
			['Level'] = 2
		}
	},
	{
		['Text'] = "$10000 - Child",
		['SubText'] = "",
		['Desc'] = "Level Required : ~pa~0",
		['Param'] = {
			['Price'] = 10000,
			['Model'] = "CS_GERMANSON",
			['Level'] = 2
		}
	},
}

Citizen.CreateThread(function()
	for _, info in pairs(blips) do
        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
        SetBlipSprite(blip, info.sprite, 1)
		SetBlipScale(blip, 0.2)
		Citizen.InvokeNative(0x9CB1A1623062F402, blip, info.name)
    end  
end)

local function SetPetAttributes( entity )
    -- | SET_ATTRIBUTE_POINTS | --
    Citizen.InvokeNative( 0x09A59688C26D88DF, entity, 0, 1100 )
    Citizen.InvokeNative( 0x09A59688C26D88DF, entity, 1, 1100 )
    Citizen.InvokeNative( 0x09A59688C26D88DF, entity, 2, 1100 )
    -- | ADD_ATTRIBUTE_POINTS | --
    Citizen.InvokeNative( 0x75415EE0CB583760, entity, 0, 1100 )
    Citizen.InvokeNative( 0x75415EE0CB583760, entity, 1, 1100 )
    Citizen.InvokeNative( 0x75415EE0CB583760, entity, 2, 1100 )
    -- | SET_ATTRIBUTE_BASE_RANK | --
    Citizen.InvokeNative( 0x5DA12E025D47D4E5, entity, 0, 10 )
    Citizen.InvokeNative( 0x5DA12E025D47D4E5, entity, 1, 10 )
    Citizen.InvokeNative( 0x5DA12E025D47D4E5, entity, 2, 10 )
    -- | SET_ATTRIBUTE_BONUS_RANK | --
    Citizen.InvokeNative( 0x920F9488BD115EFB, entity, 0, 10 )
    Citizen.InvokeNative( 0x920F9488BD115EFB, entity, 1, 10 )
    Citizen.InvokeNative( 0x920F9488BD115EFB, entity, 2, 10 )
    -- | SET_ATTRIBUTE_OVERPOWER_AMOUNT | --
    Citizen.InvokeNative( 0xF6A7C08DF2E28B28, entity, 0, 5000.0, false )
    Citizen.InvokeNative( 0xF6A7C08DF2E28B28, entity, 1, 5000.0, false )
    Citizen.InvokeNative( 0xF6A7C08DF2E28B28, entity, 2, 5000.0, false )
end

local function IsNearZone ( location )

	local player = PlayerPedId()
	local playerloc = GetEntityCoords(player, 0)

	for i = 1, #location do
		if #(playerloc - location[i]) < 2.0 then
			Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, location[i].x, location[i].y, location[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 100, 1, 1, 190, false, true, 2, false, false, false, false)
			return true, i
		end
	end

end

local function DisplayHelp( _message, x, y, w, h, enableShadow, col1, col2, col3, a, centre )

	local str = CreateVarString(10, "LITERAL_STRING", _message, Citizen.ResultAsLong())

	SetTextScale(w, h)
	SetTextColor(col1, col2, col3, a)

	SetTextCentre(centre)

	if enableShadow then
		SetTextDropshadow(1, 0, 0, 0, 255)
	end

	Citizen.InvokeNative(0xADA9255D, 10);

	DisplayText(str, x, y)

end

local function ShowNotification( _message )
	local timer = 200
	while timer > 0 do
		DisplayHelp(_message, 0.50, 0.90, 0.6, 0.6, true, 161, 3, 0, 255, true, 10000)
		timer = timer - 1
		Citizen.Wait(0)
	end
end

Citizen.CreateThread( function()
	WarMenu.CreateMenu('id_dog', 'Animal Shelter')
	repeat
		if WarMenu.IsMenuOpened('id_dog') then
			if WarMenu.Button("Give away pet") then
				TriggerServerEvent('bwrp:sellpet')
				WarMenu.CloseMenu()
			end
			for i = 1, #dogs do
				if WarMenu.Button(dogs[i]['Text'], dogs[i]['SubText'], dogs[i]['Desc']) then
					TriggerServerEvent('bwrp:buydog', dogs[i]['Param'])
					WarMenu.CloseMenu()
				end
			end
			WarMenu.Display()
		end
		Citizen.Wait(0)
	until false
end)

Citizen.CreateThread(function()
	while true do

		local IsZone, IdZone = IsNearZone( Config.Coords )

		if IsZone then
			DisplayHelp(Config.Shoptext, 0.50, 0.95, 0.6, 0.6, true, 255, 255, 255, 255, true, 10000)
			if IsControlJustPressed(0, keys['E']) then
				WarMenu.OpenMenu('id_dog')
				CurrentZoneActive = IdZone
			end
		end

		if IsControlJustReleased(0, keys['G']) then
			pressLeft = GetGameTimer()
			pressTime = pressTime + 1
		end

		if pressLeft ~= nil and (pressLeft + 500) < GetGameTimer() and pressTime > 0 and pressTime < 1 then
			pressTime = 0
		end

		if pressTime == 1 then
			if recentlySpawned <= 0 then
				recentlySpawned = 10
				TriggerServerEvent('bwrp:loaddog')
			end
			pressTime = 0
		end

		Citizen.Wait(0)
	end
end)


-- | Notification | --

RegisterNetEvent('UI:DrawNotification')
AddEventHandler('UI:DrawNotification', function( _message )
	ShowNotification( _message )
end)

-- | Remove Dog | --

RegisterNetEvent( 'bwrp:removedog' )
AddEventHandler( 'bwrp:removedog', function (args)

	DeleteEntity(currentPetPed)
	ShowNotification( "you sold your pet" )

end)

-- | Spawn dog | --

function setPetBehavior (petPed)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), GetHashKey('PLAYER'))
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), 143493179)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -2040077242)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), 1222652248)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), 1077299173)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -887307738)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -1998572072)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -661858713)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), 1232372459)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -1836932466)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), 1878159675)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), 1078461828)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -1535431934)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), 1862763509)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -1663301869)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -1448293989)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -1201903818)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -886193798)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -1996978098)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), 555364152)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -2020052692)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), 707888648)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), 378397108)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -350651841)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -1538724068)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), 1030835986)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -1919885972)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -1976316465)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), 841021282)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), 889541022)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -1329647920)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -319516747)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -767591988)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -989642646)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), 1986610512)
	SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(petPed), -1683752762)
end

RegisterNetEvent( 'bwrp:spawndog' )
AddEventHandler( 'bwrp:spawndog', function ( dog, skin, isInShop )
	local player = PlayerPedId()

	local model = GetHashKey( dog )
	local x, y, z, heading, a, b

	-- Set initial pet location
	if isInShop then
		x, y, z, heading = -373.302, 786.904, 116.169, 273.18
	else
		x, y, z = table.unpack( GetOffsetFromEntityInWorldCoords( player, 0.0, -100.0, 0.3 ) )
		a, b = GetGroundZAndNormalFor_3dCoord( x, y, z + 10 )
	end

	RequestModel( model )

	while not HasModelLoaded( model ) do
		Wait(500)
	end

	if currentPetPed == nil then		

		currentPetPed = CreatePed( model, x, y, b, heading, 1, 1 )

		SET_PED_OUTFIT_PRESET( currentPetPed, skin )
		SET_BLIP_TYPE( currentPetPed )
		SetPetAttributes( currentPetPed )
		setPetBehavior(currentPetPed)

		SetPedAsGroupMember(currentPetPed, GetPedGroupIndex(PlayerPedId()))

		TaskGoToEntity( currentPetPed, player, -1, 1.5, 2.0, 0, 0 )
		while (GetScriptTaskStatus(currentPetPed, 0x4924437d) ~= 8) do
			Wait(1000)
		end
		Citizen.InvokeNative(0x489FFCCCE7392B55, currentPetPed, PlayerPedId()) --Follow
		return

	end

	if currentPetPed then

		if isInShop then

			local x, y, z, w = table.unpack( Config.Spawndog[CurrentZoneActive] )

			DeleteEntity(currentPetPed)

			currentPetPed = CreatePed( model, x, y, z, w, 1, 1 )

			SET_PED_OUTFIT_PRESET( currentPetPed, skin )
			SET_BLIP_TYPE( currentPetPed )
			SetPetAttributes( currentPetPed )
			setPetBehavior(currentPetPed)
			TaskGoToEntity( currentPetPed, player, -1, 1.5, 2.0, 0, 0 )
			while (GetScriptTaskStatus(currentPetPed, 0x4924437d) ~= 8) do
				Wait(500)
			end
			Citizen.InvokeNative(0x489FFCCCE7392B55, currentPetPed, PlayerPedId()) --Follow
			SetPedAsGroupMember(currentPetPed, GetPedGroupIndex(PlayerPedId()))

		else
			local EntityIsDead = IsEntityDead( currentPetPed )

			if EntityIsDead then
				ShowNotification( "dog was healed by a doctor" )
				DeleteEntity(currentPetPed)
				currentPetPed = CreatePed( model, x, y, b, heading, 1, 1 )
				SET_PED_OUTFIT_PRESET( currentPetPed, skin )
				SET_BLIP_TYPE( currentPetPed )
				SetPetAttributes( currentPetPed )
				setPetBehavior(currentPetPed)
				SetPedAsGroupMember(currentPetPed, GetPedGroupIndex(PlayerPedId()))

				TaskGoToEntity( currentPetPed, player, -1, 1.5, 2.0, 0, 0 )
				while (GetScriptTaskStatus(currentPetPed, 0x4924437d) ~= 8) do
					Wait(1000)
				end
				Citizen.InvokeNative(0x489FFCCCE7392B55, currentPetPed, PlayerPedId()) --Follow

			else

			local EntityPedCoord = GetEntityCoords( player )
			local EntitydogCoord = GetEntityCoords( currentPetPed )

			if #( EntityPedCoord - EntitydogCoord ) > 100.0 then
				DeleteEntity(currentPetPed)
				currentPetPed = CreatePed( model, x, y, b, heading, 1, 1 )
				
				SET_PED_OUTFIT_PRESET( currentPetPed, skin )
				SET_BLIP_TYPE( currentPetPed )

				SetPetAttributes(currentPetPed)
				setPetBehavior(currentPetPed)
				Citizen.InvokeNative(0x489FFCCCE7392B55, currentPetPed, PlayerPedId()) --Follow
				SetPedAsGroupMember(currentPetPed, GetPedGroupIndex(PlayerPedId()))

			end
			TaskGoToEntity(currentPetPed, player, -1, 1.5, 2.0, 0, 0 )
			while (GetScriptTaskStatus(currentPetPed, 0x4924437d) ~= 8) do
				Wait(1000)
			end
			Citizen.InvokeNative(0x489FFCCCE7392B55, currentPetPed, PlayerPedId()) --Follow

		end
		end

	end

end)

function SET_BLIP_TYPE ( animal )
	return Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, animal)
end

function SET_ANIMAL_TUNING_BOOL_PARAM ( animal, p1, p2 )
	return Citizen.InvokeNative( 0x9FF1E042FA597187, animal, p1, p2 )
end

function SET_PED_DEFAULT_OUTFIT ( dog )
	return Citizen.InvokeNative( 0x283978A15512B2FE, dog, true )
end

function SET_PED_OUTFIT_PRESET ( dog, preset )
	return Citizen.InvokeNative( 0x77FF8D35EEC6BBC4, dog, preset, 0 )
end

-- | Timer | --

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
		if recentlySpawned > 0 then
			recentlySpawned = recentlySpawned - 1
		end
    end
end)
