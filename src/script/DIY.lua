local size = CC.FontName
--MpKffenlei()

--SetTF(0,4,1)

--instruct_2(84,1)
--say(Thing_kf(93),1,1)
--tjmdh(1782)
--CC.TX['般若堂'] = 1
--JY.Person[0]['门派贡献'] = 200
--SetTF(0,9996,1)
--WarMain(278, 0)
--WarMain(82)
--My_Enter_SubScene(52,26,47,0)
--instruct_10(604)
--CC.Day = CC.Day + 7
--instruct_68(0,1,1,0)
MpKffenlei()
MpRwfenlei()
for i = 4,20 do 
	--instruct_68(0,i,1,0)
end
--JY.Person[0]['奇穴'..139] = 1

--ShowScreen()
--lib.Delay(500)

--CC.Year = CC.Year + 1

for i = 1,149 do 
	--JY.Person[0]['奇穴'..i] = 0 
end

for i = 1,149 do 
	--JY.Person[0]['奇穴'..i] = 1 
end
--游戏商店
--1为物品ID,2为单价，3为数量，4为显示与否
--传送地址列表
--武功说明
--洗武功
--武功说明
--显示字符串并等待击键，字符串带框，显示在屏幕中间
--门派学武功 内轻
--无酒不欢；使用药品和食品
--CC.TX['飞'] = 19
--境界天赋选择
--武功图鉴说明
--人物界面
--开关

--instruct_3(52,1,1,0,9601,0,0,8208,8208,8208,-2,-2,-2)  --修改场景事件
--instruct_3(52,11,1,0,9601,0,0,9388,9388,9388,-2,-2,-2)  --修改场景事件
--instruct_3(52,20,1,0,9601,0,0,6294,6294,6294,-2,-2,-2)  --修改场景事件
for i = 1,149 do 
	--JY.Person[0]['奇穴'..i] = 1
end

---------------------------------------------------------------------------------------------------------
-----------------------------------------可以在下面自行书写代码--------------------------------------------
---------------------------------------------------------------------------------------------------------

--SetTF(0,9984,0)
--SetTF(0,9985,1)

--江湖传闻
-- 防御方伤害计算
-- 防御方伤害计算
--选择菜单 老顾
-- 状态菜单 简易信息

-- 汉字拼音输入法
-- 汉字拼音输入法函数
-- 汉字拼音输入法函数
 -- 汉字拼音输入法函数
-- 汉字拼音输入法函数
-- 简化版 Lua 拼音输入法


----------------------------------------------------
local diyid = JY.Base["队伍" .. 1]
local function wupingisgongType(wuid,typeId)
	local ggid = JY.Thing[wuid]["练出武功"]
	if ggid < 0 then
		return false
	end
	return JY.Wugong[ggid]["武功类型"] == typeId
end

local nexty = CC.ScreenH/2-CC.DefaultFont*4 + CC.SingleLineHeight
local menu = {}
menu[1]={"测试专用        ",nil,1}
menu[2]={"洗天外        ",nil,1}
menu[3]={"洗天内        ",nil,1}
menu[4]={"获得物品      ",nil,1}
menu[5]={"改变内力性质  ",nil,1}
menu[6]={"单项兵器加10点",nil,1}
menu[7]={"实战500       ",nil,1}
menu[8]={"全系兵器加10  ",nil,1}
menu[9]={"任我行奖励    ",nil,1}
menu[10]={"设置攻防轻    ",nil,1}
menu[11]={"设置道德      ",nil,1}
menu[12]={"设置面板武功  ",nil,1}
menu[13]={"周伯通加20左右",nil,1}
menu[14]={"洗武功        ",nil,1}
menu[15]={"全部物品",nil,1}
menu[16]={"全部武功到极  ",nil,1}
menu[17]={"加满血内最大值",nil,1}
menu[18]={"改变资质      ",nil,1}
menu[19]={"选择天赋      ",nil,1}
menu[20]={"学会武功      ",nil,1}
menu[21]={"获得金钱      ",nil,1}
menu[22]={"学会左右互博  ",nil,1}
menu[23]={"加入队友      ",nil,1}
menu[24]={"替换主角      ",nil,1}
menu[25]={"论剑奖励      ",nil,1}
menu[26]={"增加周目      ",nil,1}
menu[27]={"学会秘技      ",nil,1}
menu[28]={"加武学修炼点      ",nil,1}
menu[98]={"测试战斗      ",nil,1}
menu[99]={"物品面板      ",nil,1}
menu[100]={"装备到极     ",nil,1}
menu[101]={"直接通关     ",nil,1}
menu[102]={"全属性满     ",nil,1}
local xuan = ShowMenu2(menu, #menu, 3, 11, CC.ScreenW/2-CC.DefaultFont*10-20, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"请选择你要的功能")

if xuan == 1 then
	--Duiwumb1()
	--CHOUKA1()
	--WuKu(1)
	--lgcesi()
	--jiemian()
	--Mpzjmenu()
	--LGCHENGJIU()
	--TF_table()
	--JH_Txt()
	--testmenu()
	AutoMenu()
end

if xuan== 27 then 
	local menu1 = {}
	for i = 1,JY.TejiNum - 1 do 
		local kfname = JY.Teji[i]['名称']
		if kfname ~= '无' and kfname ~= '备用' then
			menu1[i] = {kfname,nil,1,i}
		end
	end
	for i = 1,#menu1 do 
		local R = ShowMenu2(menu1, #menu1, 5, 17, CC.ScreenW/2-CC.DefaultFont*13, CC.ScreenH/2-CC.DefaultFont*10, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"秘技大全")
		if R > 0 then 
			local nexty = CC.MainSubMenuY + CC.SingleLineHeight
			local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
			if p > 0 then
				diyid = JY.Base["队伍" .. p]
				--SetHuBo(diyid)
				for j = 1,10 do 
					if JY.Person[diyid]['秘技'..j] == 0 then 
						JY.Person[diyid]['秘技'..j] = menu1[R][4]
						break
					end
				end
			end
		else
			return 0			
		end
	end
end

if xuan == 28 then 
    local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["队伍" .. p]
		--SetHuBo(diyid)
        JY.Person[diyid]['武学点数'] = 5000
        JY.Person[diyid]['物品修炼点数'] = 50000
	end
end

if xuan==25 then
	--local menu1 = {"周伯通","王重阳","林朝英","阿青","风清扬","东方不败","扫地僧","张三丰","阿凡提"}
	nexty=nexty+CC.SingleLineHeight;
    local menuzd = {}
	menuzd[1]={"周伯通  ",nil,1}
	menuzd[2]={"王重阳  ",nil,1}
	menuzd[3]={"林朝英  ",nil,1}
	menuzd[4]={"阿青  ",nil,1}
	menuzd[5]={"风清扬  ",nil,1}
	menuzd[6]={"东方不败    ",nil,1}
	menuzd[7]={"扫地僧    ",nil,1}
	menuzd[8]={"张三丰  ",nil,1}
	menuzd[9]={"阿凡提  ",nil,1}
	--menuzd[10]={"战葵花尊者  ",nil,1}	
	local zd = ShowMenu2(menuzd, #menuzd, 4, 7, CC.ScreenW/2-CC.DefaultFont*10-20, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"请选论剑奖励")
	
	if zd == 1 then
		DrawStrBoxWaitKey("特殊奖励：你的体内消耗永久降低了50% ", LimeGreen, 36,nil, C_GOLD)
				JY.Person[64]["论剑奖励"] = 1	
	elseif zd == 2 then
		DrawStrBoxWaitKey("特殊奖励：你的伤害量永久提高了20% ", LimeGreen, 36,nil, C_GOLD)
				JY.Person[129]["论剑奖励"] = 1
	elseif zd == 3 then
		DrawStrBoxWaitKey("特殊奖励：你的连击率永久提高了50% ", LimeGreen, 36,nil, C_GOLD)
				JY.Person[605]["论剑奖励"] = 1
	elseif zd == 4 then
		DrawStrBoxWaitKey("特殊奖励：你的气防永久提高了800点", LimeGreen, 36,nil, C_GOLD)
				JY.Person[604]["论剑奖励"] = 1
	elseif zd == 5 then
		if PersonKF(0, 47) then
					DrawStrBoxWaitKey("特殊奖励：你获得了独孤九剑的真传", LimeGreen, 36,nil, C_GOLD)
					JY.Person[592]["论剑奖励"] = 1
				else
					DrawStrBoxWaitKey("你似乎错过了一项奖励……", LimeGreen, 36,nil, C_GOLD)
				end
	elseif zd == 6 then
		DrawStrBoxWaitKey("特殊奖励：你的集气速度永久提高了8点", LimeGreen, 36,nil, C_GOLD)
				JY.Person[27]["论剑奖励"] = 1
	elseif zd == 7 then
		DrawStrBoxWaitKey("特殊奖励：你的武学常识提高了100点", LimeGreen, 36,nil, C_GOLD)
				JY.Person[114]["论剑奖励"] = 1
				AddPersonAttrib(0, "武学常识", 100)
	elseif zd == 8 then
	    DrawStrBoxWaitKey("特殊奖励：你的攻防轻和五系兵器值全面提高了", LimeGreen, 36,nil, C_GOLD)
				JY.Person[5]["论剑奖励"] = 1
				AddPersonAttrib(0, "攻击力", 30)
				AddPersonAttrib(0, "防御力", 30)
				AddPersonAttrib(0, "轻功", 30)
				AddPersonAttrib(0, "拳掌功夫", 20)
				AddPersonAttrib(0, "指法技巧", 20)
				AddPersonAttrib(0, "御剑能力", 20)
				AddPersonAttrib(0, "耍刀技巧", 20)
				AddPersonAttrib(0, "特殊兵器", 20)		
	elseif zd == 9 then
		DrawStrBoxWaitKey("特殊奖励：你获得了绝对先手的能力", LimeGreen, 36,nil, C_GOLD)
		JY.Person[606]["论剑奖励"] = 1	
	end
end

if xuan==26 then
	AddZM()
end

-- end
if xuan==24 then
	lib.LoadPNG(1, 1000 * 2 , 0 , 0, 1)
	local menu = {}
	for i = 1, JY.PersonNum - 1 do
		if JY.Person[i]['姓名'] ~= '备用' and JY.Person[i]['姓名'] ~= '标主占用'  and JY.Person[i]['姓名'] ~= '门主占用' then 
			menu[#menu+1] = {JY.Person[i]['姓名'],nil,1,i} 
		end
	end 
	for i = 1,#menu do 
		local xz = ShowMenu4(menu,#menu,8,-2,-2,-2,-2,-2,1,CC.DefaultFont*0.9,C_GOLD,C_WHITE,"请选择要替换的人物",C_ORANGE, C_WHITE,15)	
		if xz > 0 then 
			local clone_choice = menu[xz][4]
			JY.Base["畅想"] = clone_choice
			JY.Person[0]["头像代号"] = JY.Person[clone_choice]["头像代号"]
			JY.Person[0]["半身像"] = JY.Person[clone_choice]["半身像"]
			JY.Person[0]["代号"] = JY.Person[clone_choice]["代号"]
			JY.Person[0]["外号"] = JY.Person[clone_choice]["外号"]
			JY.Person[0]["特色指令"] = JY.Person[clone_choice]["特色指令"]
			JY.Person[0]["姓名"] = JY.Person[clone_choice]["姓名"]
			JY.Person[0]["性别"] = JY.Person[clone_choice]["性别"]
			for i=1,5 do
				JY.Person[0]["出招动画帧数" .. i]=JY.Person[clone_choice]["出招动画帧数" .. i]
				JY.Person[0]["出招动画延迟" .. i]=JY.Person[clone_choice]["出招动画延迟" .. i]
				JY.Person[0]["武功音效延迟" .. i]=JY.Person[clone_choice]["武功音效延迟" .. i]
			end
			--畅想攻防轻最低25
			JY.Person[0]["攻击力"]=limitX(JY.Person[clone_choice]["攻击力"]/4,25)
			JY.Person[0]["防御力"]=limitX(JY.Person[clone_choice]["防御力"]/4,25)
			JY.Person[0]["轻功"]=limitX(JY.Person[clone_choice]["轻功"]/4,25)
			--医疗用毒解毒最低30
			JY.Person[0]["医疗能力"]=limitX(JY.Person[clone_choice]["医疗能力"],30)
			JY.Person[0]["用毒能力"]=limitX(JY.Person[clone_choice]["用毒能力"],30)
			JY.Person[0]["解毒能力"]=limitX(JY.Person[clone_choice]["解毒能力"],30)

			JY.Person[0]["抗毒能力"]=JY.Person[clone_choice]["抗毒能力"]
			JY.Person[0]["拳掌功夫"]=JY.Person[clone_choice]["拳掌功夫"]
			JY.Person[0]["指法技巧"]=JY.Person[clone_choice]["指法技巧"]
			JY.Person[0]["御剑能力"]=JY.Person[clone_choice]["御剑能力"]
			JY.Person[0]["耍刀技巧"]=JY.Person[clone_choice]["耍刀技巧"]
			JY.Person[0]["特殊兵器"]=JY.Person[clone_choice]["特殊兵器"]
			--暗器技巧至少30
			JY.Person[0]["暗器技巧"]=limitX(JY.Person[clone_choice]["暗器技巧"],30)

			
			local wxcs=JY.Person[clone_choice]["武学常识"]-(JY.Base["周目"]-1)*20
			
			if wxcs>0 then
				JY.Person[0]["武学常识"]=JY.Person[clone_choice]["武学常识"]-(JY.Base["周目"]-1)*20
			else
				JY.Person[0]["武学常识"]=10
			end		
			JY.Person[0]["攻击带毒"]=JY.Person[clone_choice]["攻击带毒"]
			JY.Person[0]["左右互搏"]=JY.Person[clone_choice]["左右互搏"]
			for i=1,12 do
				JY.Person[0]["武功" .. i]=JY.Person[clone_choice]["武功" .. i]
				JY.Person[0]["武功等级" .. i]=JY.Person[clone_choice]["武功等级" .. i]
			end
			for i=1,2 do
				JY.Person[0]["天赋外功"..i]=JY.Person[clone_choice]["天赋外功"..i]
			end
			
			JY.Person[0]["天赋内功"]=JY.Person[clone_choice]["天赋内功"]
			JY.Person[0]["天赋轻功"]=JY.Person[clone_choice]["天赋轻功"]
			JY.Person[0]["畅想分阶"]=JY.Person[clone_choice]["畅想分阶"]
			JY.Person[0]["外号2"]=JY.Person[clone_choice]["外号2"]
			JY.Person[0]["特色指令"] = JY.Person[clone_choice]["特色指令"]
			JY.Person[0]["等级"]=JY.Person[clone_choice]["等级"]
		else
			return 0
		end
		break
	end
end

if xuan==23 then
	lib.LoadPNG(91, 24 * 2 , 0 , 0, 1)
	local menu = {}
	for i = 1, JY.PersonNum - 1 do
		if JY.Person[i]['姓名'] ~= '备用' and JY.Person[i]['姓名'] ~= '标主占用' then
			menu[#menu+1] = {JY.Person[i]['姓名'],nil,1,i}
		end
	end		
	local clone_choice = ShowMenu4(menu,#menu,8,-2,-2,-2,-2,1,1,CC.DefaultFont*0.9,C_GOLD,C_WHITE,"请选择要加入的队友",C_ORANGE, C_WHITE,15)
	if clone_choice > 0 then 		
		instruct_10(menu[clone_choice][4])
		table.remove(menu,clone_choice)
	else
		return 0 
	end	
end

if xuan ==21 then
	instruct_2(174,30000)
	--AddZM()
	--JY.Base["周目"] =InputNum("选择周目", 1, 600,1);
end

if xuan ==22 then
	
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["队伍" .. p]
		--SetHuBo(diyid)
		JY.Person[diyid]["左右互搏"] = 1
		instruct_68(diyid,4,1,0)
	end
	
	--instruct_2(174,30000)
	--AddZM()
	--JY.Base["周目"] =InputNum("选择周目", 1, 600,1);
end

if xuan == 5 then
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["队伍" .. p]
		local r1 = JYMsgBox("请选择", "你想要转换的内力性质", {"阴性","阳性","调和"}, 3, 122,1)
		if r1 == 1 then
			JY.Person[diyid]["内力性质"] = 0
		elseif r1==2 then
			JY.Person[diyid]["内力性质"] = 1
		elseif r1==3 then
			JY.Person[diyid]["内力性质"] = 2
		else
		end
	end
end	
	
if xuan==6 then
	local r2 = JYMsgBox("请选择", "你对哪种类型的武功感兴趣？", {"拳法","指法","剑法","刀法","奇门",}, 5, 122,1)
	if r2 == 1 then
		AddPersonAttrib(diyid, "拳掌功夫", 10)
		DrawStrBoxWaitKey("你对拳掌功夫的理解提升了",C_GOLD,CC.DefaultFont,nil,LimeGreen)
		Cls()  --清屏
	elseif r2 == 2 then
		AddPersonAttrib(diyid, "指法技巧", 10)
		DrawStrBoxWaitKey("你对指法技巧的理解提升了",C_GOLD,CC.DefaultFont,nil,LimeGreen)
		Cls()  --清屏
	elseif r2 == 3 then
		AddPersonAttrib(diyid, "御剑能力", 10)
		DrawStrBoxWaitKey("你对御剑能力的理解提升了",C_GOLD,CC.DefaultFont,nil,LimeGreen)
		Cls()  --清屏
	elseif r2 == 4 then
		AddPersonAttrib(diyid, "耍刀技巧", 10)
		DrawStrBoxWaitKey("你对耍刀技巧的理解提升了",C_GOLD,CC.DefaultFont,nil,LimeGreen)
		Cls()  --清屏
	elseif r2 == 5 then
		AddPersonAttrib(diyid, "特殊兵器", 10)
		DrawStrBoxWaitKey("你对特殊兵器的理解提升了",C_GOLD,CC.DefaultFont,nil,LimeGreen)
		Cls()  --清屏
	end
end

if xuan==20 then
	local k = JY.Wugong;
	local menuwai = {}
	local menu  = {}	
	local kftype = JYMsgBox("请选择", "请选择武功类型                ", {"拳法","指法","剑法","刀法","奇门","内功","轻功"}, 7, 347)	
	for i = 1, JY.WugongNum - 1 do
		local kfname = k[i]["名称"]
		if string.len(kfname) == 8 then
			kfname = kfname.."  "
		elseif string.len(kfname) == 6 then
			kfname = kfname.."    "
		elseif string.len(kfname) == 4 then
			kfname = kfname.."      "
		end
		menuwai[i] = {kfname,nil,2}
		if k[i]["武功类型"] == kftype then
			menuwai[i][3] = 1
		end
	end
	local nexty = CC.ScreenH/2-CC.DefaultFont*4 + CC.SingleLineHeight
	local r = ShowMenu2(menuwai, #menuwai, 3, 9, CC.ScreenW/2-CC.DefaultFont*10-20, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"选择武功")
	if r == 0 then
		return
	end	
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
	diyid = JY.Base["队伍" .. p]
	instruct_33(diyid,r,0)
end 

if xuan == 2 then
	local k = JY.Wugong;
	local menuwai = {}
	
	local kftype = JYMsgBox("请选择", "请选择喜欢的天赋外功类型", {"拳法","指法","剑法","刀法","奇门"}, 5, 347)
	
	for i = 1, JY.WugongNum - 1 do
		local kfname = k[i]["名称"]
		if string.len(kfname) == 8 then
			kfname = kfname.."  "
		elseif string.len(kfname) == 6 then
			kfname = kfname.."    "
		elseif string.len(kfname) == 4 then
			kfname = kfname.."      "
		end
		menuwai[i] = {kfname,nil,2}
		if k[i]["武功类型"] == kftype then
			menuwai[i][3] = 1
		end
	end
	local nexty = CC.ScreenH/2-CC.DefaultFont*4 + CC.SingleLineHeight
	local r = ShowMenu2(menuwai, #menuwai, 3, 9, CC.ScreenW/2-CC.DefaultFont*10-20, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"领悟天赋外功")
	if r == 0 then
		return
	end
	
	local tianwai = JYMsgBox("请选择", "洗第几个天赋外功？", {"天外1","天外2"}, 2, 347,1)
	if tianwai < 0 then
		return
	end
	if r > 0 then
		--开始
		local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["队伍" .. p]
		SetTianWai(diyid, tianwai, r)
		
	end
		
		
		--结束
		--SetTianWai(0, tianwai, r)
	end
	
end

if xuan == 3 then
	local k = JY.Wugong;
	local menunei = {}
	for i = 1, JY.WugongNum - 1 do
		local kfname = k[i]["名称"]
		if string.len(kfname) == 8 then
			kfname = kfname.."  "
		elseif string.len(kfname) == 6 then
			kfname = kfname.."    "
		elseif string.len(kfname) == 4 then
			kfname = kfname.."      "
		end
		menunei[i] = {kfname,nil,2}
		if k[i]["武功类型"] == 6 then
			menunei[i][3] = 1
		end
	end
	local nexty = CC.ScreenH/2-CC.DefaultFont*4 + CC.SingleLineHeight
	local r = ShowMenu2(menunei, #menunei, 3, 9, CC.ScreenW/2-CC.DefaultFont*10-20, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"领悟天赋内功")
	if r > 0 then
		--开始
		local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["队伍" .. p]
		SetTianNei(diyid, r)
		
	end
		
		--结束
		--SetTianNei(0, r)
	end
		
end
	
	
if xuan == 4 then
	local k = JY.Thing;
	local ceshi = {}
	local wutype = JYMsgBox("请选择", "物品类型                                       ", {"剧情物品","神兵宝甲","武功秘籍","灵丹妙药","伤人暗器"}, 5, 347,1)
	if wutype < 0  then
		return
	end
	local gongtype = 0
	if wutype-1 == 2 then
		gongtype = JYMsgBox("请选择", "请选择秘籍类型                    ", {"拳法","指法","剑法","刀法","奇门","内功","轻功","杂类"}, 8, 347)
		if gongtype < 0 then
			return
		end
	end
	for i = 0, JY.ThingNum - 1 do
		local kfname = k[i]["名称"]
		if string.len(kfname) == 8 then
			kfname = kfname.."  "
		elseif string.len(kfname) == 6 then
			kfname = kfname.."    "
		elseif string.len(kfname) == 4 then
			kfname = kfname.."      "
		end
		ceshi[i] = {kfname..k[i]["类型"]..i,nil,2}
		if k[i]["类型"] == wutype-1 then
			ceshi[i][3] = 1
			if wutype-1 == 2 and wupingisgongType(i,gongtype)~=true then
				ceshi[i][3] = 2
			end
			if wutype-1 == 2 and JY.Thing[i]["练出武功"] < 0 and gongtype == 8 then
				ceshi[i][3] = 1
			end
		end
		
	end
	local nexty = CC.ScreenH/2-CC.DefaultFont*4 + CC.SingleLineHeight
	local r = 0
	r = ShowMenu2(ceshi, #ceshi, 3, 9, CC.ScreenW/2-CC.DefaultFont*10-20, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"请选择")
	if r == 0 then
		return
	end
	if wutype-1 == 3 or r == 174 or wutype-1 == 4 then
		local nnnum = InputNum(JY.Thing[r]["名称"], 1, 30000,1)
		if nnnum == nil or nnnum <= 0 then
			return
		end
		instruct_2(r,nnnum)
		return
	end
	instruct_2(r,1)
	
	
elseif xuan == 7 then
	DrawStrBoxWaitKey("特殊奖励：主角实战500", C_RED, CC.DefaultFont,nil,C_GOLD)
	JY.Person[diyid]["实战"] = 500
	
	
elseif xuan == 8 then
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["队伍" .. p]
		DrawStrBoxWaitKey("特殊奖励：五系兵器值提升一百点", C_RED, CC.DefaultFont,nil,C_GOLD)
		AddPersonAttrib(diyid, "拳掌功夫", 100)
		AddPersonAttrib(diyid, "指法技巧", 100)
		AddPersonAttrib(diyid, "御剑能力", 100)
		AddPersonAttrib(diyid, "耍刀技巧", 100)
		AddPersonAttrib(diyid, "特殊兵器", 100)
	end
	
	
elseif xuan==9 then
	DrawStrBoxWaitKey("防御力和轻功各提升十点", C_RED, CC.DefaultFont,nil,C_GOLD)
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["队伍" .. p]
		JY.Person[diyid]["防御力"] = JY.Person[diyid]["防御力"]+10
		JY.Person[diyid]["轻功"] = JY.Person[diyid]["轻功"]+10
	end
	
	
elseif xuan==10 then
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["队伍" .. p]
	end
	local shux = JYMsgBox("请选择", "设置哪个属性？          ", {"攻击力","防御力","轻功"}, 3, 347,1)
	if shux < 0  then
		return
	end
	local nnnum = InputNum("请输入数值", 1, 600,1)
	if nnnum == nil or nnnum <= 0 then
		return
	end
	local temp_shu = {"攻击力","防御力","轻功"}
	local temp_s = temp_shu[shux]
	JY.Person[diyid][temp_s] = nnnum
	
	
elseif xuan == 11 then
	local nnnum = InputNum("请输入数值", 1, 200,1)
	if nnnum == nil or nnnum <= 0 then
		return
	end
	JY.Person[0]["品德"] = nnnum
	
	
elseif xuan == 12 then
	local k = JY.Wugong;
	local menuwai = {}
	local menu  = {}
	
	local kftype = JYMsgBox("请选择", "请选择武功类型                ", {"拳法","指法","剑法","刀法","奇门","内功","轻功"}, 7, 347)
	
	for i = 1, JY.WugongNum - 1 do
		local kfname = k[i]["名称"]
		if string.len(kfname) == 8 then
			kfname = kfname.."  "
		elseif string.len(kfname) == 6 then
			kfname = kfname.."    "
		elseif string.len(kfname) == 4 then
			kfname = kfname.."      "
		end
		menuwai[i] = {kfname,nil,2}
		if k[i]["武功类型"] == kftype then
			menuwai[i][3] = 1
		end
	end
	local nexty = CC.ScreenH/2-CC.DefaultFont*4 + CC.SingleLineHeight
	local r = ShowMenu2(menuwai, #menuwai, 3, 9, CC.ScreenW/2-CC.DefaultFont*10-20, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"选择武功")
	if r == 0 then
		return
	end
	
	
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
	diyid = JY.Base["队伍" .. p]
	
	
	for j = 1, CC.Kungfunum do
        if JY.Person[diyid]["武功"..j] > 0 then
            local wg = JY.Person[diyid]["武功"..j]
            menu[#menu+1] = {JY.Wugong[wg]["名称"], nil, 1, wg, j}
        end
	end   
	local geizi = ShowMenu2(menu, #menu, 3,10, CC.MainSubMenuX, CC.MainSubMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)
	if geizi < 0 then
		return
	end
	if r > 0 then
		JY.Person[diyid]["武功"..geizi] = r
		JY.Person[diyid]["武功等级"..geizi] = 999
	end
	
	
elseif xuan == 13 then
	DrawStrBoxWaitKey("你的左右互搏几率永久提高了20%,多次无用", LimeGreen, 36,nil, C_GOLD)
	JY.Person[64]["品德"] = 80
	
	
elseif xuan == 14 then	
	Cls()
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
	if p > 0 then
		local pid = JY.Base["队伍" .. p]
		local menu = {}
		for i = 1, CC.Kungfunum do
			if JY.Person[pid]["武功"..i] > 0 then
				local wg = JY.Person[pid]["武功"..i]
				menu[#menu+1] = {JY.Wugong[wg]["名称"], nil, 1, wg, i}
			end
		end        
		Cls()
		local r = ShowMenu2(menu, #menu, 3,10, CC.MainSubMenuX, CC.MainSubMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)
		local jjj = 1
		if match_ID(pid,56) or match_ID(pid,77) then
			jjj = 2
		end 
		if r > 0 then
			local thingid = -1
			for i = 0, JY.ThingNum - 1 do
				if JY.Thing[i]["练出武功"] > 0 and JY.Thing[i]["练出武功"] == menu[r][4] then
					thingid = i
					local level = math.modf(JY.Person[pid]["武功等级" .. menu[r][5]] / 100) + 1
					AddPersonAttrib(pid, "生命最大值", -JY.Thing[thingid]["加生命最大值"] * level)
					AddPersonAttrib(pid, "内力最大值", -JY.Thing[thingid]["加内力最大值"] * level)
					AddPersonAttrib(pid, "攻击力", -JY.Thing[thingid]["加攻击力"] * level)
					AddPersonAttrib(pid, "轻功", -JY.Thing[thingid]["加轻功"] * level)
					AddPersonAttrib(pid, "防御力", -JY.Thing[thingid]["加防御力"] * level)        
					AddPersonAttrib(pid, "医疗能力", -JY.Thing[thingid]["加医疗能力"] * jjj * level)
					AddPersonAttrib(pid, "用毒能力", -JY.Thing[thingid]["加用毒能力"] * jjj * level)
					AddPersonAttrib(pid, "解毒能力", -JY.Thing[thingid]["加解毒能力"] * jjj * level)
					AddPersonAttrib(pid, "抗毒能力", -JY.Thing[thingid]["加抗毒能力"] * jjj * level)
					AddPersonAttrib(pid, "拳掌功夫", -JY.Thing[thingid]["加拳掌功夫"] * jjj * level)
					AddPersonAttrib(pid, "指法技巧", -JY.Thing[thingid]["加指法技巧"] * jjj * level)
					AddPersonAttrib(pid, "御剑能力", -JY.Thing[thingid]["加御剑能力"] * jjj * level)
					AddPersonAttrib(pid, "耍刀技巧", -JY.Thing[thingid]["加耍刀技巧"] * jjj * level)
					AddPersonAttrib(pid, "特殊兵器", -JY.Thing[thingid]["加特殊兵器"] * jjj * level)
					AddPersonAttrib(pid, "暗器技巧", -JY.Thing[thingid]["加暗器技巧"] * jjj * level)
					AddPersonAttrib(pid, "武学常识", -JY.Thing[thingid]["加武学常识"] * jjj * level)     										
					break
				end
			end
			for i = menu[r][5], #menu - 1 do
				JY.Person[pid]["武功"..i] = JY.Person[pid]["武功"..i+1]
				JY.Person[pid]["武功等级"..i] = JY.Person[pid]["武功等级"..i+1]
			end
			JY.Person[pid]["武功"..#menu] = 0
			JY.Person[pid]["武功等级"..#menu] = 0
			QZXS(JY.Person[pid]["姓名"].."已经洗掉"..menu[r][1])
		end
	end
	
elseif xuan == 15 then
	for id = 0,JY.ThingNum - 1 do
        instruct_32(id,1)
	end	

   
elseif xuan == 16 then	
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
        diyid = JY.Base["队伍" .. p]
		for i = 1, CC.Kungfunum do
			if JY.Person[diyid]["武功等级"..i] <=900 then
				JY.Person[diyid]["武功等级"..i] = 999
			end
		end
	end
	
elseif xuan == 17 then
    for i=1,CC.TeamNum do
		if JY.Base["队伍" .. i]>= 0 then
			diyid = JY.Base["队伍" .. i]
		end
		AddPersonAttrib(diyid, "生命最大值", 999)
		AddPersonAttrib(diyid, "内力最大值", 9999)
		JY.Person[diyid]["生命"] = JY.Person[diyid]["生命最大值"]
		JY.Person[diyid]["内力"] = JY.Person[diyid]["内力最大值"]
	end	
	DrawStrBoxWaitKey("特殊奖励：加满生命内力最大值", C_RED, CC.DefaultFont,nil,C_GOLD)
	
elseif xuan == 18 then
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["队伍" .. p]
		local nnnum = InputNum("请输入资质", 1, 100,1)
		if nnnum == nil or nnnum <= 0 then
			return
		end
		JY.Person[diyid]["资质"] = nnnum
	end			
	
elseif xuan == 19 then
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["队伍" .. p]
		JJ_TF(diyid,0)	
	end	
	
	
	
elseif xuan == 98 then
	nexty=nexty+CC.SingleLineHeight;
    local menuzd = {}
	menuzd[1]={"战戚长发  ",nil,1}
	menuzd[2]={"战十五正  ",nil,1}
	menuzd[3]={"战二十大  ",nil,1}
	menuzd[4]={"战独孤求败  ",nil,1}
	menuzd[5]={"战扫地  ",nil,1}
	menuzd[6]={"战蒙哥    ",nil,1}
	menuzd[7]={"战欧阳克    ",nil,1}
	menuzd[8]={"战张三丰  ",nil,1}
	menuzd[9]={"战童姥  ",nil,1}
	menuzd[10]={"战葵花尊者  ",nil,1}	
	menuzd[11]={"战游坦之  ",nil,1}
	menuzd[12]={"达摩  ",nil,1}
	local zd = ShowMenu2(menuzd, #menuzd, 4, 7, CC.ScreenW/2-CC.DefaultFont*10-20, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"请选择战斗")
	
	if zd == 1 then
		
		WarMain(247, 0)	
	elseif zd == 2 then
		WarMain(134, 0)	
	elseif zd == 3 then
		WarMain(289, 0)	
	elseif zd == 4 then
		WarMain(291, 0)
	elseif zd == 5 then
		WarMain(115, 0)
	elseif zd == 6 then
		WarMain(278, 0)
	elseif zd == 7 then
		WarMain(69, 0)
	elseif zd == 8 then
	    WarMain(118, 0)					
	elseif zd == 9 then
		WarMain(303, 0)	
	elseif zd == 10 then
		local temppd = JY.Person[27]["品德"]
		JY.Person[27]["品德"] = 20
		WarMain(54, 0)	
		JY.Person[27]["品德"] = temppd
	elseif zd == 11 then
		WarMain(88)
	elseif zd == 12 then
		WAR.Data["敌人" .. 1] = 594
		WarMain(309)				
	end
	
	
elseif xuan == 99 then
	local k = JY.Thing;
	local ceshi = {}
	local kfname = 0 
	for i = 0, JY.ThingNum - 1 do
		kfname = k[i]["名称"]
		if string.len(kfname) == 8 then
			kfname = kfname.."  "
		elseif string.len(kfname) == 6 then
			kfname = kfname.."    "
		elseif string.len(kfname) == 4 then
			kfname = kfname.."      "
		end
		ceshi[i] = {kfname..k[i]["类型"],nil,2}
		local ggid = k[i]["练出武功"]
		if k[i]["类型"] == 2 and ggid >0 then
			ceshi[i] = {kfname..JY.Wugong[ggid]["武功类型"],nil,2}
		end
		if true then
			ceshi[i][3] = 1
		end	
	end
elseif xuan == 100 then	
	for id = 0,CC.TeamNum-1 do
		if inteam(id) then
	        if JY.Person[id]["武器"]~= nil then
		        for i = 1,JY.ThingNum - 1 do
			        if i == JY.Person[id]["武器"] then
				       JY.Thing[i]["装备等级"] = 6
			        end
			        if i == JY.Person[id]["防具"] then
				       JY.Thing[i]["装备等级"] = 6
			        end
			        if i == JY.Person[id]["坐骑"] then
				       JY.Thing[i]["装备等级"] = 6
			        end							
		        end
	        end
		end
    end
elseif xuan == 101 then	
	Duiwumb1()
	--instruct_62()
	--ceshi = {}
	--ceshi[1]={""..JY.ThingNum,nil,1}
	--local nexty = CC.ScreenH/2-CC.DefaultFont*4 + CC.SingleLineHeight
	--local r = ShowMenu2(ceshi, #ceshi, 3, 9, CC.ScreenW/2-CC.DefaultFont*10-20, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"物品面板")
	--if r>0 then
	--	instruct_2(r,1)
	--end
	
elseif xuan == 102 then	
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["队伍" .. p]
		JY.Person[diyid]["攻击力"] = 999
		JY.Person[diyid]["防御力"] = 999
		JY.Person[diyid]["轻功"] = 999
		JY.Person[diyid]["拳掌功夫"] = 500
		JY.Person[diyid]["指法技巧"] = 500
		JY.Person[diyid]["御剑能力"] = 500
		JY.Person[diyid]["耍刀技巧"] = 500
		JY.Person[diyid]["特殊兵器"] = 500
		JY.Person[diyid]["内力最大值"] = 9999
		JY.Person[diyid]["武学点数"] = 30000
		JY.Person[diyid]["门派贡献"] = 600
		JY.Person[diyid]["物品修炼点数"] = 60000
		JY.Person[diyid]["体质"] = 20
	end	
end
--]]

