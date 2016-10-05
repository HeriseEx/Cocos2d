display.addSpriteFrames("image/anim/hero1.plist","image/anim/hero1.png")
display.addSpriteFrames("image/anim/hero2.plist","image/anim/hero2.png")
display.addSpriteFrames("image/anim/hero3.plist","image/anim/hero3.png")
display.addSpriteFrames("image/anim/hero4.plist","image/anim/hero4.png")
local UIHelper=class("UIHelper",function ()
end)

function UIHelper:createLabelWithTag(x,y,label_text,label_size,parentsNode,zorder,tag)
	local label = cc.ui.UILabel.new({UIlabelType=2,text=label_text,size=label_size})
	label:setPosition(display.width*x,display.height*y)
	label:setAnchorPoint(0.5,0.5)
	parentsNode:addChild(label,zorder,tag)
	return label
end

function UIHelper:createLabel(x,y,label_text,label_size,parentsNode,zorder)
	local label = cc.ui.UILabel.new({UIlabelType=2,text=label_text,size=label_size})
	label:setPosition(display.width*x,display.height*y)
	label:setAnchorPoint(0.5,0.5)
	parentsNode:addChild(label,zorder)
	return label
end


function UIHelper:createAniame(path,start_num,end_num,delayTime)
	local frames = display.newFrames(path,start_num,end_num)
	local animation = display.newAnimation(frames,delayTime)
	local animate=cc.RepeatForever:create(cc.Animate:create(animation))
	-- display.setAnimationCache(tag,animate)
	return animate
end

function UIHelper:createSprite(path,x,y,scalex,scaley,arnchorx,arnchory,parentsNode,zorder)
	local  sprite = display.newSprite(path)
	sprite:setPosition(display.width*x,display.height*y)
	sprite:setAnchorPoint(arnchorx,arnchory)
	sprite:setScaleX(scalex)
	sprite:setScaleY(scaley)
	parentsNode:addChild(sprite,zorder)
	return sprite
end


function UIHelper:createSpriteWithTag(path,x,y,parentsNode,zorder,tag)
	local  sprite = display.newSprite(path)
	sprite:setPosition(display.width*x,display.height*y)
	sprite:setAnchorPoint(0.5,0.5)
	parentsNode:addChild(sprite,zorder,tag)
	return sprite
end
--创建各种node
return UIHelper