local UIHelper = require("app.UIHelper")
local MainScene=require("app.scenes.MainScene")
local Hero=require("app.scenes.Hero")

local StartScene = class("StartScene", function()
    return display.newScene("StartScene")
end)
display.addSpriteFrames("image/anim/hero1.plist","image/anim/hero1.png")
display.addSpriteFrames("image/anim/hero2.plist","image/anim/hero2.png")
display.addSpriteFrames("image/anim/hero3.plist","image/anim/hero3.png")
display.addSpriteFrames("image/anim/hero4.plist","image/anim/hero4.png")
function StartScene:ctor()
	math.randomseed(os.time())
	self.planeTable={}
	self.stickTable={}
	self.planeWidth={}
	self.stickPositionX=100
	self.count=0
	self.stickLength=0
	self.planeX=50
    self.startButton=self:myCreateButton()
    self:createPlane()
    self:myBackground()
    self.heroAction_stay=self.hero:getActionStay()
	self.heroAction_walk=self.hero:getActionWalk()
	self.heroAction_stay:setTag(111)
	self.heroAction_walk:setTag(222)
    self.hero:runAction(self.heroAction_stay)
    print(self:getActionByTag(111))

--初始化场景
end

function StartScene:onEnter()
	self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, function(dt)
		self.count=self.count+1
		self.stickLength=self.stickLength+2
		self:stickUpdate()
		print(self.stickLength)

	end)

	self:setTouchEnabled(false)
	self:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)
	self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
		if event.name == "began" then
			-- self:initStick()
			self:createStick()
			self:scheduleUpdate()
			return true
		elseif event.name=="ended" then
			self:unscheduleUpdate()
			self.count=0
			self:judge()
		end
	end)
end
--触摸事件（更新棍子长度以及判定）

function StartScene:onExit()
end

function StartScene:myCreateButton()
	local  images={
	normal="image/uires_2.png",
	}
	local  button =cc.ui.UIPushButton.new(images)
	self:addChild(button,10)
	button:setPosition(display.width/2,display.height/2)
	button:onButtonClicked(function(event)	
		local callfunc = cc.CallFunc:create(function ()
			self:startGame(self.startButton)
		end)
		self.startButton:runAction(callfunc)
	end)

	return button
end

function StartScene:myBackground()
	local bg = {
	"image/bg/bg1.jpg",
	"image/bg/bg2.jpg",
	"image/bg/bg3.jpg",
	"image/bg/bg4.jpg",
	"image/bg/bg5.jpg"
	}

	-- local hero={
	-- "image/hero1.png",
	-- "image/hero2.png",
	-- "image/hero3.png",
	-- "image/hero4.png"
	-- }
	local i = math.random(1, 5) 
	i = math.random(1, 5) 

	self.j = math.random(1, 4)
	j = math.random(1, 4)
	UIHelper:createSprite(bg[i],0.5,0.5,1,1,0.5,0.5,self,0)
	self.title=UIHelper:createSprite("image/uires_1.png",0.5,0.8,1,1,0.5,0.5,self,1)
	-- self.hero=UIHelper:createSprite(hero[j],0.5,0.2,1,1,0.5,0,self,1)
	self.hero=Hero.new(j,0.5,0.2,0.5,0,self,5)
	self.heroType=j
end
--创建背景图片以及主角图片

function StartScene:startGame(button)
	button:removeFromParent()
	button.startButton=nil
	self.title:removeFromParent()
	self.titile=nil
	local planeMoveBy = cc.MoveBy:create(0.3,cc.p(-display.cx+100,0))
	local heroMoveBy = cc.MoveBy:create(0.3,cc.p(-display.cx+100,0))
	self.plane:runAction(planeMoveBy)
	self.hero:runAction(heroMoveBy)	
	self.score=0
	self.scoreLabel=UIHelper:createLabel(0.5,0.95,"score : "..self.score,80,self,1)
	self:createNewPlane()
	self:setTouchEnabled(true)
end
--开始游戏按钮事件
function StartScene:createPlane()
	self.plane=UIHelper:createSprite("image/stick1.png",0.6,0.2,50,150,1,1,self,1)
	table.insert(self.planeTable,self.plane)
	table.insert(self.planeWidth,self.planeX)
end
--开始场景背景平台
function StartScene:createNewPlane()
	self.planeX=math.random(15,50)
	self.plane=UIHelper:createSprite("image/stick1.png",1.2,0.2,self.planeX,150,1,1,self,1)
	self.plane:runAction(cc.MoveTo:create(0.5,cc.p(display.width*math.random(5,9)/10,display.height*0.2)))
	table.insert(self.planeTable,self.plane)
	table.insert(self.planeWidth,self.planeX)
end
--创建新平台

function StartScene:removePlane()
	local planeTemp=self.planeTable[1]
	table.remove(self.planeTable,1)
	planeTemp:removeFromParent()
	planeTemp=nil
	table.remove(self.planeWidth,1)
end
--删除平台
function StartScene:createStick()
	if self.stick ==nil then
	else
		self.stick:removeFromParent()
	end
	self.stick=display.newSprite("image/stick1.png")
	self.stick:setPosition(self.planeTable[1]:getPositionX()-self.plane:getContentSize().width,self.hero:getPositionY())
	self.stick:setAnchorPoint(0.5,0)
	self:addChild(self.stick,2)
	
end
--创建棍子

function StartScene:stickUpdate()
	self.stick:setScaleY(self.stickLength)
end
--棍子长度更新

function StartScene:heroMove()
	local rotate = cc.RotateTo:create(0.5,90)
	local callfunc1=cc.CallFunc:create(function()
		-- self.hero:stopActionByTag(111)
		self.hero:runAction(cc.MoveTo:create(0.5,cc.p(self.planeTable[2]:getPositionX()-self.planeWidth[2]*self.plane:getContentSize().width/2,self.planeTable[1]:getPositionY())))
		-- self.hero:runAction(self.heroAction_walk)
	end)

	local callfunc2=cc.CallFunc:create(function()
		-- self.hero:stopActionByTag(222)
		-- self.hero:runAction(self.heroAction_stay)
	end)


	local seq = cc.Sequence:create(rotate,callfunc1,cc.DelayTime:create(0.5),callfunc2)
	self.stick:runAction(seq)
	self.stickLength=0
end
--人物移动

function StartScene:heroMoveDown(droptype)
	print(droptype)
	local rotate = cc.RotateTo:create(0.5,90)
	local callfunc1=cc.CallFunc:create(function()
		self.hero:runAction(cc.MoveTo:create(0.5,cc.p(self.planeTable[1]:getPositionX()+self.stickLength*self.plane:getContentSize().width,self.planeTable[1]:getPositionY())))
	end)
	local callfunc2=cc.CallFunc:create(function ()
		self.hero:runAction(cc.MoveBy:create(0.5,cc.p(0,-1000)))
		self.stick:runAction(cc.RotateBy:create(0.5,90))
	end)
	local callfunc3=cc.CallFunc:create(function ()
		self.hero:runAction(cc.MoveBy:create(0.5,cc.p(0,-1000)))
	end)

	if droptype==1 then
	local seq = cc.Sequence:create(rotate,callfunc1,cc.DelayTime:create(1.5),callfunc2,cc.DelayTime:create(0.5))
	self.stick:runAction(seq)
	elseif droptype==2 then
	local seq = cc.Sequence:create(rotate,callfunc1,cc.DelayTime:create(1.5),callfunc3,cc.DelayTime:create(0.5))
	self.stick:runAction(seq)
	end
end
--人物坠落
function StartScene:judge()
	local planeDistence1 =self.planeTable[2]:getPositionX()- self.planeTable[1]:getPositionX()
	local planeDistence2 = self.planeTable[2]:getPositionX()- self.planeTable[1]:getPositionX()-self.planeWidth[2]*self.plane:getContentSize().width
	if self.stickLength*self.plane:getContentSize().width >=planeDistence2 and self.stickLength*self.plane:getContentSize().width<=planeDistence1 then
		local callfunc1 = cc.CallFunc:create(function ()
			self:heroMove()
			self:setTouchEnabled(false)
		end)
		local callfunc2 = cc.CallFunc:create(function ()
			self:scollScreen()
		end)

		local callfunc3 = cc.CallFunc:create(function ()
			self:removePlane()
			self:createNewPlane()
		end)

		local callfunc4 = cc.CallFunc:create(function ()
			self:setTouchEnabled(true)
		end)

		local seq=cc.Sequence:create(callfunc1,
			cc.DelayTime:create(1),
						callfunc2,
			cc.DelayTime:create(0.5),
						callfunc3,
			cc.DelayTime:create(0.8),
						callfunc4)

		self:runAction(seq)
		self.score=self.score+1
		self.scoreLabel:setString("score : "..self.score)
	else
		local callfunc1 = cc.CallFunc:create(function ()
			self:setTouchEnabled(false)
		end)

		local callfunc2=cc.CallFunc:create(function ()
			self:heroMoveDown(1)
		end)

		local callfunc3=cc.CallFunc:create(function ()
			self:heroMoveDown(2)
		end)
		local callfunc4=cc.CallFunc:create(function ()
			self:gameOver()
		end)

		if self.stickLength*self.plane:getContentSize().width >planeDistence1 then
			local seq=cc.Sequence:create(callfunc1,callfunc3,cc.DelayTime:create(2),callfunc4)
			self:runAction(seq)
			print("run1")
		else
			local seq=cc.Sequence:create(callfunc1,callfunc2,cc.DelayTime:create(2),callfunc4)
			self:runAction(seq)
			print("run2")
		end
	end
end
--移动或者坠落判定

function StartScene:gameOver()
	local images = {
	normal="image/uires_5.png"
	}

	self.endButton=cc.ui.UIPushButton.new(images)
	self:addChild(self.endButton,10)
	self.endButton:setPosition(display.width/2,display.height/2)
	self.endButton:onButtonClicked(function(event)	
		local callfunc = cc.CallFunc:create(function ()	
			local scene =require("app.scenes.StartScene")
			display.replaceScene(scene:new())
		end)
		self.endButton:runAction(callfunc)
	end)
end
--游戏结束
function StartScene:scollScreen()
	self.stick:setRotation(90)
	self.hero:runAction(cc.MoveBy:create(1,cc.p(-self.planeTable[2]:getPositionX()+150,0)))
	self.planeTable[1]:runAction(cc.MoveBy:create(1,cc.p(-self.planeTable[2]:getPositionX()+150,0)))
	self.planeTable[2]:runAction(cc.MoveBy:create(1,cc.p(-self.planeTable[2]:getPositionX()+150,0)))
	self.stick:runAction(cc.MoveBy:create(1,cc.p(-self.planeTable[2]:getPositionX()+150,0)))
end
--人物移动后屏幕滚动
return StartScene
