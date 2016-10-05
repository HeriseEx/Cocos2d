
require("config")
require("cocos.init")
require("framework.init")

GameState=require("framework.cc.utils.GameState")

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)

    GameState.init(function(param)
    	local returnValue = nil
    	if param.errorCode then
    		print("errorCode:%d",param.errorCode)
    	else
    		if param.name=="save" then
    			local str = json.encode(param.values)
    			--table.key.key
    			
    			returnValue={data=str}

    		elseif param.name=="load" then
    			local str = param.values.data
    			returnValue=json.decode(str)
    		end
    	end
    	return returnValue
    end,"src/app/scenes/GameData.txt")

    GameData=GameState.load() or {score=0}
    GameState.save(GameData)
end

function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")
    self:enterScene("StartScene")
end

return MyApp
