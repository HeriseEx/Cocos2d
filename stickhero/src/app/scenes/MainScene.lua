
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    cc.ui.UILabel.new({
            UILabelType = 2, text = "Hello", size = 64})
        :align(display.CENTER, display.cx, display.cy)
        :addTo(self)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

function MainScene:createPlan( ... )
	-- body
end

function MainScene:bgPic( ... )
	-- body
end

function MainScene:heroAnimaManage( ... )
	-- body
end

function MainScene:cacheAnimate( ... )
	-- body
end



return MainScene
