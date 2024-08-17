script_name("PCSI TROLLING")
script_author("akmalshellby")

require("moonloader")
local imgui = require ("mimgui")
local encoding = require("encoding")
encoding.default = "CP1251"
u8 = encoding.UTF8
font = renderCreateFont("Arial", 20, 0x8)
local ev = require "lib.samp.events"
local new = imgui.new
local renderWindow = new.bool()
local sizeX, sizeY = getScreenResolution()
local vkladka = 1

local onfrv = new.bool()
local incrv = new.bool()
local orslide = new.int(5) -- Jarak onfoot dari player
local crslide = new.int(7) -- Jarak incar dari player
local lineesp = new.bool(true)
local cesp = new.bool(true)
local idcel = new.bool(true)
local trgcX, trgcY, trgZ = 1, 1, 1
local rvanka = false
local rvanka2 = false
local reloadingrv = false
local onfs = new.float(0.708) -- Kecepatan onfoot dari player
local incs = new.float(0.727) -- Kecepatan incar dari player
local startCheckbox = new.bool() -- Checkbox untuk tombol Start

function main()
    repeat wait(0) until isSampAvailable()
    sampRegisterChatCommand("akmal", function()
        renderWindow[0] = not renderWindow[0]
    end)
    
    wait(10000)
    sampAddChatMessage("{ff0000}[{ff0000}PCSI{ff0000}]:{FFFFFF} CHEAT BERHASIL DI AKTIFKAN )", -1)
    sampAddChatMessage("{ff0000}[{ff0000}PCSI{ff0000}]:{FFFFFF} KETIK /akmal UNTUK MEMUNCULKAN MENU", -1)
    sampAddChatMessage("{ff0000}[{ff0000}PCSI{ff0000}]:{FFFFFF} Jangan Lupa Subscribe YT PCSI dan follow ig @akmalshellby", -1)
    sampAddChatMessage("{ff0000}[{ff0000}PCSI{ff0000}]:{FFFFFF} member pcsi: Amon,Dapz,Vilz,Reno,Cecep,Juli,VictorSamp, dll)", -1)
    sampAddChatMessage("{ff0000}[{ff0000}PCSI{ff0000}]:{FFFFFF} WEBSITE PCSI : https://pcsi-samp.vercel.app)", -1)
    while true do
        if onfrv[0] then
            rvanka2 = true
        else
            rvanka2 = false
        end
        if onfrv[0] or incrv[0] then
            if onfrv[0] then
                if lineesp[0] then
                    local x,y,z = getCharCoordinates(PLAYER_PED)
                    local playerid = getClosestPlayerId1()
                    local res, chel = sampGetCharHandleBySampPlayerId(playerid)
                    if res then
                        local px, py, pz = getCharCoordinates(chel)
                        local wx, wy = convert3DCoordsToScreen(x, y, z)
                        local ex, ey = convert3DCoordsToScreen(px, py, pz)
                        if idcel[0] then printStringNow("Target: " .. playerid .. " ID", 100) end
                        if isCharOnScreen(chel) then
                            renderDrawLine(wx, wy, ex, ey, 4.0, 0xffffff0500)
                            if cesp[0] then Draw3DCircle(px, py, pz, 1) end
                        end
                    end
                end
                if isCharInAnyCar(PLAYER_PED) then
                    onfrv[0] = not onfrv[0]
                else
                    local victim = getClosestPlayerId1()
                    local mposX, mposY, mposZ = getCharCoordinates(PLAYER_PED)
                    if victim >= 0 then
                        local rvank, target = sampGetCharHandleBySampPlayerId(victim)
                        local vposX, vposY, vposZ = getCharCoordinates(target)
                        trgcX, trgcY, trgcZ = vposX, vposY, vposZ
                        local distt = getDistanceBetweenCoords3d(vposX, vposY, vposZ, mposX, mposY, mposZ)
                        local disttt = orslide[0]
                        if distt <= disttt then
                            sendPlayerSync(vposX, vposY, vposZ)
                        else
                            sendMySync(mposX, mposY, mposZ)
                        end
                    end
                end
            end
            if incrv[0] then
                if lineesp[0] and isCharInAnyCar(PLAYER_PED) then
                    local x,y,z = getCharCoordinates(PLAYER_PED)
                    local playerid = getClosestPlayerId2()
                    local res, chel = sampGetCharHandleBySampPlayerId(playerid)
                    if res then
                        local px, py, pz = getCharCoordinates(chel)
                        local wx, wy = convert3DCoordsToScreen(x, y, z)
                        local ex, ey = convert3DCoordsToScreen(px, py, pz)
                        if idcel[0] and reloadingrv then 
                            printStringNow("Reloading...", 200)
                        elseif idcel[0] then
                            printStringNow("Target: " .. playerid .. " ID", 100)
                        end   
                        if isCharOnScreen(chel) then
                            renderDrawLine(wx, wy, ex, ey, 4.0, 0xffffff0500)
                            if cesp[0] then Draw3DCircle(px, py, pz, 1) end
                        end
                    end
                end
                if isCharInAnyCar(PLAYER_PED) then
                    onfrv[0] = false
                    local victim = getClosestPlayerId2()
                    local mposX, mposY, mposZ = getCharCoordinates(PLAYER_PED)
                    if victim >= 0 then
                        local rvank, target = sampGetCharHandleBySampPlayerId(victim)
                        local vposX, vposY, vposZ = getCharCoordinates(target)
                        trgcX, trgcY, trgcZ = vposX, vposY, vposZ
                        local distt = getDistanceBetweenCoords3d(vposX, vposY, vposZ, mposX, mposY, mposZ)
                        local disttt = crslide[0]
                        if distt <= disttt then
                            rvanka = true
                            lua_thread.create(oncarrv)
                        else
                            rvanka = false
                            StopRv()
                        end
                    end
                end
            end
        end
        wait(0)
    end
end

local newFrame = imgui.OnFrame(
    function() return renderWindow[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(480, 380), imgui.Cond.FirstUseEver)
        imgui.Begin("MOD MENU PCSI V1 BY AKMALSHELLBY", renderWindow)
            imgui.Dummy(imgui.ImVec2(5, 5))
            imgui.Dummy(imgui.ImVec2(7, 0))
                imgui.SameLine()
            if imgui.Button(u8"MENU NGECIT", imgui.ImVec2(200, 50)) then
                vkladka = 1
            end
                imgui.SameLine()
            imgui.Dummy(imgui.ImVec2(20, 0))
                imgui.SameLine()
            if imgui.Button(u8"SETTINGS", imgui.ImVec2(200, 50)) then
                vkladka = 2
            end
            imgui.Separator()
            if vkladka == 1 then
                imgui.Dummy(imgui.ImVec2(0, 5))
                imgui.Dummy(imgui.ImVec2(7, 0))
                imgui.SameLine()
                imgui.Checkbox("MULAI SKEMA", onfrv)
                    imgui.SameLine()
                imgui.Dummy(imgui.ImVec2(18, 0))
                    imgui.SameLine()
                imgui.Checkbox("MULAI TROLL MOBIL", incrv)
                imgui.Dummy(imgui.ImVec2(7, 0))
                imgui.SameLine()
                imgui.Text(u8"     JARAK")
                    imgui.SameLine()
                imgui.Dummy(imgui.ImVec2(93, 0))
                    imgui.SameLine()
                imgui.Text(u8"         JARAK")
                imgui.PushItemWidth(170)
                imgui.Dummy(imgui.ImVec2(7, 0))
                imgui.SameLine()
                imgui.SliderInt("##1", orslide, 1, 30)
                    imgui.SameLine()
                imgui.Dummy(imgui.ImVec2(50, 0))
                    imgui.SameLine()
                    imgui.Dummy(imgui.ImVec2(2, 0))
                imgui.SameLine()
                imgui.SliderInt("##2", crslide, 1, 30)
                imgui.Dummy(imgui.ImVec2(7, 0))
                imgui.SameLine()
                imgui.Text(u8"     KECEPATAN SKEMA")
                imgui.SameLine()
                imgui.Dummy(imgui.ImVec2(100,0))
                imgui.SameLine()
                imgui.Text(u8"    KECEPATAN TROLL MOBIL")
                imgui.PopItemWidth()
                imgui.Dummy(imgui.ImVec2(7, 0))
                imgui.SameLine()
                imgui.PushItemWidth(170)
                imgui.SliderFloat("##3", onfs, 0.01, 1)
                imgui.PopItemWidth()
                imgui.SameLine()
                imgui.Dummy(imgui.ImVec2(57,0))
                imgui.PushItemWidth(170)
                imgui.SameLine()
                imgui.SliderFloat("##4", incs, 0.01,1)
                imgui.PopItemWidth()
                imgui.Dummy(imgui.ImVec2(0, 5))
                imgui.Dummy(imgui.ImVec2(75, 0))
                imgui.SameLine()
                if imgui.Button(u8"TELEPORT KE PLAYER", imgui.ImVec2(300, 50)) then
                    setCharCoordinates(PLAYER_PED, trgcX, trgcY, trgcZ)
                end
                imgui.Dummy(imgui.ImVec2(75, 0))
                imgui.Dummy(imgui.ImVec2(0, 5))
                imgui.SameLine()
                imgui.Checkbox("ANTI BAN (member vip)", startCheckbox) -- Checkbox untuk tombol Start
    imgui.Dummy(imgui.ImVec2(75, 0))
                imgui.Dummy(imgui.ImVec2(0, 5))
                imgui.SameLine()
                imgui.Checkbox("KICK PLAYER (member vip)", startCheckbox) -- Checkbox untuk tombol Start
    imgui.Dummy(imgui.ImVec2(75, 0))
                imgui.Dummy(imgui.ImVec2(0, 5))
                imgui.SameLine()
                imgui.Checkbox("HUJAN MOBIL (member vip)", startCheckbox) -- Checkbox untuk tombol Start
    imgui.Dummy(imgui.ImVec2(75, 0))
                imgui.Dummy(imgui.ImVec2(0, 5))
                imgui.SameLine()
                imgui.Checkbox("MASUK TANPA WL (member vip)", startCheckbox) -- Checkbox untuk tombol Start
    imgui.Dummy(imgui.ImVec2(75, 0))
                imgui.Dummy(imgui.ImVec2(0, 5))
                imgui.SameLine()
                imgui.Checkbox("SPAWN LEVEL (member vip)", startCheckbox) -- Checkbox untuk tombol Start
    imgui.Dummy(imgui.ImVec2(75, 0))
                imgui.Dummy(imgui.ImVec2(0, 5))
                imgui.SameLine()
                imgui.Checkbox("JADI ADMIN (member vip)", startCheckbox) -- Checkbox untuk tombol Start
    imgui.Dummy(imgui.ImVec2(75, 0))
                imgui.Dummy(imgui.ImVec2(0, 5))
                imgui.SameLine()
                imgui.Checkbox("HUJAN GEDUNG (member vip)", startCheckbox) -- Checkbox untuk tombol Start
    imgui.Dummy(imgui.ImVec2(75, 0))
                imgui.Dummy(imgui.ImVec2(0, 5))
                imgui.SameLine()
                imgui.Checkbox("JAIL PLAYER SEKITAR (member vip)", startCheckbox) -- Checkbox untuk tombol Start
    imgui.Dummy(imgui.ImVec2(75, 0))
                imgui.Dummy(imgui.ImVec2(0, 5))
                imgui.SameLine()
                imgui.Checkbox("KILL SEMUA PLAYER (member vip)", startCheckbox) -- Checkbox untuk tombol Start
            elseif vkladka == 2 then
                imgui.Dummy(imgui.ImVec2(0, 5))
                imgui.Checkbox(u8"ESP LINE", lineesp)
                    imgui.SameLine()
                imgui.Dummy(imgui.ImVec2(20, 0))
                    imgui.SameLine()
                imgui.Checkbox(u8"BYPASS", cesp)
                imgui.Dummy(imgui.ImVec2(0, 5))
                imgui.Checkbox(u8"TAMPILKAN ID PLAYER", idcel)
            end
        imgui.End()
    end
)

function getClosestPlayerId1()
    local minDist = orslide[0]
    local closestId = -1
    local x, y, z = getCharCoordinates(PLAYER_PED)
    for i = 0, 999 do
        local streamed, pedID = sampGetCharHandleBySampPlayerId(i)
        if streamed then
            local xi, yi, zi = getCharCoordinates(pedID)
            local dist = math.sqrt( (xi - x) ^ 2 + (yi - y) ^ 2 + (zi - z) ^ 2 )
            if dist < minDist then
                minDist = dist
                closestId = i
            end
        end
    end
    return closestId
end
function getClosestPlayerId2()
    local minDist = crslide[0]
    local closestId = -1
    local x, y, z = getCharCoordinates(PLAYER_PED)
    for i = 0, 999 do
        local streamed, pedID = sampGetCharHandleBySampPlayerId(i)
                if streamed then
            local xi, yi, zi = getCharCoordinates(pedID)
            local dist = math.sqrt( (xi - x) ^ 2 + (yi - y) ^ 2 + (zi - z) ^ 2 )
            if dist < minDist then
                minDist = dist
                closestId = i
            end
        end
    end
    return closestId
end

function Draw3DCircle(x, y, z, radius)
    local screen_x_line_old, screen_y_line_old;

    for rot=0, 360 do
        local rot_temp = math.rad(rot)
        local lineX, lineY, lineZ = radius * math.cos(rot_temp) + x, radius * math.sin(rot_temp) + y, z
        local screen_x_line, screen_y_line = convert3DCoordsToScreen(lineX, lineY, lineZ)
        if screen_x_line ~=nil and screen_x_line_old ~= nil then renderDrawLine(screen_x_line, screen_y_line, screen_x_line_old, screen_y_line_old, 3, 0xff0000) end
        screen_x_line_old, screen_y_line_old = screen_x_line, screen_y_line
    end
end

function sendPlayerSync(posX,posY,posZ)
    lua_thread.create(function()
        wait(25)
        local data = samp_create_sync_data("player")
        local move = onfs[0]
        for i = 0, 2 do data.quaternion[i] = 0 end
        data.quaternion[3] = tonumber("0"..math.random(001,999))
        data.position = {posX-0.7,posY-0.7,posZ-0.7}
        data.moveSpeed = {move,move,move}
        data.send()
    end)
end
    
function sendMySync()
     local mmX,mmY,mmZ = getCharCoordinates(PLAYER_PED)
     local data = samp_create_sync_data("player")
     for i = 0, 3 do data.quaternion[i] = 0 end
     move = 0
     data.position = {mmX,mmY,mmZ}
     data.moveSpeed = {move,move,move}
     data.send()
end

function samp_create_sync_data(sync_type, copy_from_player)
    local ffi = require 'ffi'
    local sampfuncs = require 'sampfuncs'
    local raknet = require 'samp.raknet'
    require 'samp.synchronization'
    copy_from_player = copy_from_player or true
    local sync_traits = {
        player = {'PlayerSyncData', raknet.PACKET.PLAYER_SYNC, sampStorePlayerOnfootData},
        vehicle = {'VehicleSyncData', raknet.PACKET.VEHICLE_SYNC, sampStorePlayerIncarData},
        passenger = {'PassengerSyncData', raknet.PACKET.PASSENGER_SYNC, sampStorePlayerPassengerData},
        aim = {'AimSyncData', raknet.PACKET.AIM_SYNC, sampStorePlayerAimData},
        trailer = {'TrailerSyncData', raknet.PACKET.TRAILER_SYNC, nil},
        unoccupied = {'UnoccupiedSyncData', raknet.PACKET.UNOCCUPIED_SYNC, nil},
        bullet = {'BulletSyncData', raknet.PACKET.BULLET_SYNC, nil},
        spectator = {'SpectatorSyncData', raknet.PACKET.SPECTATOR_SYNC, nil}
    }
    local sync_info = sync_traits[sync_type]
    local data_type = 'struct ' .. sync_info[1]
    local data = ffi.new(data_type, {})
    local raw_data_ptr = tonumber(ffi.cast('uintptr_t', ffi.new(data_type .. '*', data)))
    if copy_from_player then
        local copy_func = sync_info[3]
        if copy_func then
            local _, player_id
            if copy_from_player == true then
                _, player_id = sampGetPlayerIdByCharHandle(PLAYER_PED)
            else
                player_id = tonumber(copy_from_player)
            end
            copy_func(player_id, raw_data_ptr)
        end
    end
    local func_send = function()
        local bs = raknetNewBitStream()
        raknetBitStreamWriteInt8(bs, sync_info[2])
        raknetBitStreamWriteBuffer(bs, raw_data_ptr, ffi.sizeof(data))
        raknetSendBitStreamEx(bs, sampfuncs.HIGH_PRIORITY, sampfuncs.UNRELIABLE_SEQUENCED, 1)
        raknetDeleteBitStream(bs)
    end
    local mt = {
        __index = function(t, index)
            return data[index]
        end,
        __newindex = function(t, index, value)
            data[index] = value
        end
    }
    return setmetatable({send = func_send}, mt)
end

function oncarrv()
            local msp = 0.1
            for i = 0, 30 do 
                wait(15)
                local x, y, z = getCharCoordinates(PLAYER_PED)
                msp = msp + 0.05
                Speeds(x, y, z, msp)
                if msp >= 5 then break end
            end
            for i = 0, 10 do
                wait(100)
                CarRv()
            end
            wait(1000)
            StopRv()
            reloadingrv = true
            wait(400)
            reloadingrv = false
end

function CarRv()
    local id = getClosestPlayerId2()
    local res, chel = sampGetCharHandleBySampPlayerId(id)
    if res then
        local x,y,z = getCharCoordinates(chel)
        local move = incs[0]
        local data = samp_create_sync_data('vehicle')
        data.position = {x-0.7, y-0.7, z-0.7}
        for i = 0, 2 do data.quaternion[i] = 0 end
        data.quaternion[3] = tonumber("0."..math.random(0001, 9999))
        data.keysData = data.keysData + 8
        data.moveSpeed = {move, move, move}
        data.send()
    end
end

function Speeds(x,y,z,move)
    local data = samp_create_sync_data('vehicle')
    data.position = {x, y, z}
    data.moveSpeed = {move, move, move}
    data.send()
end

function StopRv()
    local pX,pY,pZ = getCharCoordinates(PLAYER_PED)
    local move = 0.0
    local data = samp_create_sync_data('vehicle')
    data.position = {pX,pY,pZ}
    for i = 0, 3 do data.quaternion[i] = 0 end
    data.moveSpeed = {move, move, move}
    data.send()
end

function ev.onSetVehicleVelocity(turn, pos)
    if rvanka2 then
        return false
    elseif rvanka then 
        return false
    end
end

function ev.onRemovePlayerFromVehicle()
    if rvanka2 then
        return false
    elseif rvanka then 
        return false
    end
end

function ev.onSetVehiclePosition(vid, pos)
    if rvanka2 then
        return false
    elseif rvanka then 
        return false
    end
end

function ev.onSendVehicleSync(data)
    if rvanka2 then
        return false
    elseif rvanka then 
        return false
    end
end

function ev.onSetPlayerPos(pos)
    if rvanka2 then
        return false
    elseif rvanka then 
        return false
    end
end

function ev.onSendPlayerSync(data)
    if rvanka2 then
        return false
    elseif rvanka then 
        return false
    end
end

imgui.OnInitialize(function()
    theme()
end)

function theme()
    imgui.SwitchContext()
    --==[ STYLE ]==--
    imgui.GetStyle().WindowPadding = imgui.ImVec2(5, 5)
    imgui.GetStyle().FramePadding = imgui.ImVec2(5, 5)
    imgui.GetStyle().ItemSpacing = imgui.ImVec2(5, 5)
    imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(2, 2)
    imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(0, 0)
    imgui.GetStyle().IndentSpacing = 0
    imgui.GetStyle().ScrollbarSize = 10
    imgui.GetStyle().GrabMinSize = 10

    --==[ BORDER ]==--
    imgui.GetStyle().WindowBorderSize = 1
    imgui.GetStyle().ChildBorderSize = 1
    imgui.GetStyle().PopupBorderSize = 1
    imgui.GetStyle().FrameBorderSize = 1
    imgui.GetStyle().TabBorderSize = 1

    --==[ ROUNDING ]==--
    imgui.GetStyle().WindowRounding = 5
    imgui.GetStyle().ChildRounding = 5
    imgui.GetStyle().FrameRounding = 5
    imgui.GetStyle().PopupRounding = 5
    imgui.GetStyle().ScrollbarRounding = 5
    imgui.GetStyle().GrabRounding = 5
    imgui.GetStyle().TabRounding = 5

    --==[ ALIGN ]==--
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().SelectableTextAlign = imgui.ImVec2(0.5, 0.5)
    
    --==[ COLORS ]==--
    imgui.GetStyle().Colors[imgui.Col.Text]                   = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TextDisabled]           = imgui.ImVec4(0.50, 0.50, 0.50, 1.00)
    imgui.GetStyle().Colors[imgui.Col.WindowBg]               = imgui.ImVec4(1.00, 0.00, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ChildBg]                = imgui.ImVec4(1.00, 0.00, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.PopupBg]                = imgui.ImVec4(1.00, 0.00, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.Border]                 = imgui.ImVec4(0.25, 0.25, 0.26, 0.54)
    imgui.GetStyle().Colors[imgui.Col.BorderShadow]           = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
    imgui.GetStyle().Colors[imgui.Col.FrameBg]                = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]         = imgui.ImVec4(1.0, 1.0, 1.0, 1.0)
    imgui.GetStyle().Colors[imgui.Col.FrameBgActive]          = imgui.ImVec4(1.0, 1.0, 1.0, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TitleBg]                = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TitleBgActive]          = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]       = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.MenuBarBg]              = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]            = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]          = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]   = imgui.ImVec4(0.41, 0.41, 0.41, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]    = imgui.ImVec4(0.51, 0.51, 0.51, 1.00)
    imgui.GetStyle().Colors[imgui.Col.CheckMark]              = imgui.ImVec4(1.00, 0.00, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
    imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
    imgui.GetStyle().Colors[imgui.Col.Button]                 = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = imgui.ImVec4(0.41, 0.41, 0.41, 1.00)
    imgui.GetStyle().Colors[imgui.Col.Header]                 = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = imgui.ImVec4(0.20, 0.20, 0.20, 1.00)
    imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = imgui.ImVec4(0.47, 0.47, 0.47, 1.00)
    imgui.GetStyle().Colors[imgui.Col.Separator]              = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ResizeGrip]             = imgui.ImVec4(1.00, 1.00, 1.00, 0.25)
    imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]      = imgui.ImVec4(1.00, 1.00, 1.00, 0.67)
    imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]       = imgui.ImVec4(1.00, 1.00, 1.00, 0.95)
    imgui.GetStyle().Colors[imgui.Col.Tab]                    = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TabHovered]             = imgui.ImVec4(0.28, 0.28, 0.28, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TabActive]              = imgui.ImVec4(0.30, 0.30, 0.30, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TabUnfocused]           = imgui.ImVec4(0.07, 0.10, 0.15, 0.97)
    imgui.GetStyle().Colors[imgui.Col.TabUnfocusedActive]     = imgui.ImVec4(0.14, 0.26, 0.42, 1.00)
    imgui.GetStyle().Colors[imgui.Col.PlotLines]              = imgui.ImVec4(0.61, 0.61, 0.61, 1.00)
    imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]       = imgui.ImVec4(1.00, 0.43, 0.35, 1.00)
    imgui.GetStyle().Colors[imgui.Col.PlotHistogram]          = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]   = imgui.ImVec4(1.00, 0.60, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]         = imgui.ImVec4(1.00, 0.00, 0.00, 0.35)
    imgui.GetStyle().Colors[imgui.Col.DragDropTarget]         = imgui.ImVec4(1.00, 1.00, 0.00, 0.90)
    imgui.GetStyle().Colors[imgui.Col.NavHighlight]           = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
    imgui.GetStyle().Colors[imgui.Col.NavWindowingHighlight]  = imgui.ImVec4(1.00, 1.00, 1.00, 0.70)
    imgui.GetStyle().Colors[imgui.Col.NavWindowingDimBg]      = imgui.ImVec4(0.80, 0.80, 0.80, 0.20)
    imgui.GetStyle().Colors[imgui.Col.ModalWindowDimBg]       = imgui.ImVec4(0.00, 0.00, 0.00, 0.70)
end
