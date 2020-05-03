script_name("Krest")
script_version("1.0")
script_author("alexmarkel0v")

local inicfg = require 'inicfg'

local mainIni = inicfg.load({
    settings =
    {
      krest = true,
	  krestX = 500,
	  krestY = 100,
    }
}, 'krest.ini')

local krestenable = mainIni.settings.krest
local x = mainIni.settings.krestX
local y = mainIni.settings.krestY

local settings = "moonloader/config/krest.ini"
local settingsIni = inicfg.load(mainIni, settings)
if not doesFileExist('moonloader/config/krest.ini') then inicfg.save(mainIni, 'krest.ini') end

function main()
    while not isSampAvailable() do wait(50) end
	while not sampIsLocalPlayerSpawned() do wait(50) end
	
	sampRegisterChatCommand('krest', cmd_enablekrest)
	sampRegisterChatCommand('krest_pos', cmd_positionkrest)
	
	isLoaded = loadTextureDictionary('krest')
    if not isLoaded then sampAddChatMessage("[ Крест ]: Файл krest.txd не найден в папке moonloader/resource/txd", -1) return 
	elseif isLoaded then
		lua_thread.create(function()
            while true do
                wait(5000)
				sprite = loadSprite('krestnormal')
				return
			end
		end)
	end
	while true do 
		wait(0)
		if sprite ~= nil then
			if krestenable then
				ScreenX, ScreenY = getScreenResolution()
				drawSprite(sprite, ScreenX * (x / ScreenX), ScreenY * (y / ScreenY), ScreenX / 25, ScreenY / 10, 255, 255, 255, 255)
			end
		end
	end
end

function cmd_enablekrest()
	krestenable = not krestenable
	mainIni.settings.krest = krestenable
	inicfg.save(mainIni, settings)
end

function cmd_positionkrest()
	sampAddChatMessage("[ Крест ]: Переместите курсор влево, затем меняйте позицию с помощью курсора, чтобы сохранить нажмите ЛКМ.", -1)
	lua_thread.create(function()
		showCursor(true, true)
		while not isKeyDown(0x01) do wait(0) x,y = getCursorPos() end
		showCursor(false, false)
		mainIni.settings.krestX = x
		mainIni.settings.krestY = y
		inicfg.save(mainIni, settings)
	end)
end