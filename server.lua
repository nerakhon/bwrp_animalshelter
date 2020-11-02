-- Based on Malik's and Blue's animal shelters and vorp animal shelter --

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)
VORP = exports.vorp_core:vorpAPI()
local result2 = nil
local statusdog = nil

Citizen.CreateThread(function()
    local _source = source
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local playerid = Character.identifier
    local u_charid = Character.charIdentifier
    exports.ghmattimysql:execute( "SELECT * FROM dogs WHERE identifier = @identifier AND charidentifier = @charidentifier", {['identifier'] = playerid, ['charidentifier'] = u_charid}, function(result)
    if result[1] then 
        statusdog = result[1].dog
        end
        return false
    end)
    
        
end) 

local function GetAmmoutdogs( Player_ID )
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local playerid = Character.identifier
    local u_charid = Character.charIdentifier
    exports.ghmattimysql:execute( "SELECT * FROM dogs WHERE identifier = @identifier AND charidentifier = @charidentifier", {['identifier'] = playerid, ['charidentifier'] = u_charid}, function(result)
    if result[1] then 
       statusdog = result[1].dog
    end
       return false
    end)
    
end

RegisterServerEvent('bwrp:sellpet')
AddEventHandler('bwrp:sellpet', function()
    TriggerEvent("vorp:getCharacter", source, function(user)
        local User = VorpCore.getUser(source)
        local Character = User.getUsedCharacter
        local playerid = Character.identifier
        local u_charid = Character.charIdentifier
        local _src = source
        exports.ghmattimysql:execute("DELETE FROM dogs WHERE identifier = @identifier AND charidentifier = @charidentifier", {["identifier"] = playerid, ['charidentifier'] = u_charid})
        TriggerClientEvent('bwrp:removedog', _src)
    end)

end)


RegisterServerEvent('bwrp:buydog')
AddEventHandler( 'bwrp:buydog', function ( args )
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local _src   = source
    local _price = args['Price']
    local _model = args['Model']
    local skin = math.floor(math.random(0, 2))


	
    u_identifier = Character.identifier
    u_charid = Character.charIdentifier
    u_money = Character.money
    GetAmmoutdogs(u_identifier)
    


    if u_money <= _price then
        TriggerClientEvent( 'UI:DrawNotification', _src, Config.NoMoney )
        return
    end

    Character.removeCurrency(0, _price)


    TriggerClientEvent('bwrp:spawndog', _src, _model, skin, true)

    if statusdog == nil then
        local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid,  ['dog'] = _model, ['skin'] = skin}
        exports.ghmattimysql:execute("INSERT INTO dogs ( `identifier`,`charidentifier`,`dog`,`skin` ) VALUES ( @identifier,@charidentifier, @dog, @skin )", Parameters)
        TriggerClientEvent( 'UI:DrawNotification', _src, 'You bought a new pet' )
    elseif statusdog ~= nil then
        local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid,  ['dog'] = _model, ['skin'] = skin }
        exports.ghmattimysql:execute(" UPDATE dogs SET dog = @dog, skin = @skin WHERE identifier = @identifier AND charidentifier = @charidentifier", Parameters)
        TriggerClientEvent( 'UI:DrawNotification', _src, 'You replaced your old pet' )
    end

end)

RegisterServerEvent( 'bwrp:loaddog' )
AddEventHandler( 'bwrp:loaddog', function ( )
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local _src = source

	
    u_identifier = Character.identifier
    u_charid = Character.charIdentifier


    local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid }
    exports.ghmattimysql:execute( "SELECT * FROM dogs WHERE identifier = @identifier  AND charidentifier = @charidentifier", Parameters, function(result)

    if result[1] then
        local dog = result[1].dog
        local skin = result[1].skin
        print(dog)
        TriggerClientEvent("bwrp:spawndog", _src, dog, skin, false)
    end
end)
end )