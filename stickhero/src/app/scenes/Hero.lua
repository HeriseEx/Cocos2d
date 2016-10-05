display.addSpriteFrames("image/anim/hero1.plist","image/anim/hero1.png")
display.addSpriteFrames("image/anim/hero2.plist","image/anim/hero2.png")
display.addSpriteFrames("image/anim/hero3.plist","image/anim/hero3.png")
display.addSpriteFrames("image/anim/hero4.plist","image/anim/hero4.png")
local UIHelper = require("app.UIHelper")
local Hero =class("Hero",function (type,posx,posy,ancx,ancy,parent,zorder)
	local hero =display.newSprite("image/hero"..type..".png")
	hero:setPosition(posx*display.width,posy*display.height)
	hero:setAnchorPoint(ancx,ancy)
	parent:addChild(hero,zorder)
	return hero 
end)

function Hero:ctor(type,posx,posy,ancx,ancy,parent,zorder)
	self.type = type
end

function Hero:getActionStay()
	local staypath="hero"..self.type.."stay%d.png"
	local heroStay = UIHelper:createAniame(staypath, 1, 5, 0.2)
	return heroStay
end

function Hero:getActionWalk()
	local walkpath="hero"..self.type.."walk%d.png"
	local heroWalk = UIHelper:createAniame(walkpath, 1, 5, 0.2)
	return heroWalk
end


return Hero


--action tag
--回调回调