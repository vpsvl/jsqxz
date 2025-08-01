
--周目增加属性
function ZM_Add(id,str)
	local zm = JY.Base['周目']
	local nd = JY.Base['难度']
	local fj = (7-JY.Base['分阶'])
	local Add_Max = 0
	local xs = 0
	local sw = 0
	if id ~= 591 then 
		--每周目增加20点系数，三围，武常
		if nd > 1 and  p ~= 591 then 
			xs = zm
			sw = zm*3
		end
		--每周目增加20点系数，三围，武常
		if nd > 1 then
			xs = xs + nd*5
			sw = sw + nd*5 
		end
		if nd >= 3 and JY.Person[p]["畅想分阶"] <= 3 then
			sw = sw + nd*zm
			xs = xs + nd*zm
		end	
		lib.Debug('三围 == '..sw)
		local a,b,c = split_into_three(sw)
		local sx1 = math.modf(zm*nd*fj*0.5)
		if str == '基础生命' then 
			Add_Max = sx1*10
		elseif str == '内力最大值' then 
			Add_Max = sx1*10
		elseif str == '攻击力' then 
			Add_Max = sx1
		elseif str == '防御力' then 
			Add_Max = sx1
		elseif str == '轻功' then 
			Add_Max = sx1
		elseif str == '医疗能力' then 
			--Add_Max = sx1
		elseif str == '用毒能力' then 
			--Add_Max = sx1
		elseif str == '暗器技巧' then 
			--Add_Max = sx1
		elseif str == '拳掌功夫' then 
			Add_Max = sx1
		elseif str =='指法技巧' then 
			Add_Max = sx1
		elseif str== '御剑能力' then
			Add_Max = sx1
		elseif str == '耍刀技巧' then 
			Add_Max = sx1
		elseif str== '特殊兵器' then 
			Add_Max = sx1
		end
	end
	return Add_Max
end

--判断人物武功等级
function KF_level(id,kf) 
	local level = 0
	for i = 1,JY.Base['武功数量'] do 
		if JY.Person[id]["武功" .. i] == kf then 
			local kflvl = JY.Person[id]["武功等级" .. i]
			if kflvl >= 999 then
				level = 11
			else
				level = math.modf(kflvl/100)+1
			end
		end
	end
	return level
end

--经脉奇穴激活条件
function JMQX_JH(id,qx)
	local R =JY.Person[id] 
	local pd = 0
	--指法
	if qx == 3 then 
		if R['指法技巧'] >= 100 then 
			pd = 1
		end
	end
	if qx == 6 then 
		if R['指法技巧'] >= 200 then 
			pd = 1
		end
	end
	if qx == 9 then 
		if R['指法技巧'] >= 400 then 
			pd = 1
		end
	end	

	--剑法
	if qx == 12 then 
		if R['御剑能力'] >= 100 then 
			pd = 1
		end
	end	
	if qx == 15 then 
		if R['御剑能力'] >= 200 then 
			pd = 1
		end
	end	
	if qx == 19 then 
		if R['御剑能力'] >= 400 then 
			pd = 1
		end
	end	

	--用毒
	if qx == 22 then 
		if R['用毒能力'] >= 100 then 
			pd = 1
		end
	end	
	if qx == 25 then 
		if R['用毒能力'] >= 200 then 
			pd = 1
		end
	end	
	if qx == 28 then 
		if R['用毒能力'] >= 400 then 
			pd = 1
		end
	end	

	--拳法
	if qx == 32 then 
		if R['拳掌功夫'] >= 100 then 
			pd = 1
		end
	end	
	if qx == 36 then 
		if R['拳掌功夫'] >= 200 then 
			pd = 1
		end
	end	
	if qx == 40 then 
		if R['拳掌功夫'] >= 400 then 
			pd = 1
		end
	end		

	--刀法
	if qx == 44 then 
		if R['耍刀技巧'] >= 100 then 
			pd = 1
		end
	end	
	if qx == 48 then 
		if R['耍刀技巧'] >= 200 then 
			pd = 1
		end
	end	
	if qx == 51 then 
		if R['耍刀技巧'] >= 400 then 
			pd = 1
		end
	end	

	--阳内
	if R['内力性质'] == 1 or R['内力性质'] == 3 then 
		if qx == 54 then 
			--少林九阳功/峨眉九阳功/武当九阳功到极
			if KF_level(id,241) >= 10 or KF_level(id,242)  >= 10 or KF_level(id,243) >= 10   then 
				pd = 1
			end
		end	
		if qx == 57 then 
			if R['内力最大值'] >= 5000 then 
				pd = 1
			end
		end	
		--天赋内功精通九阳神功
		if qx == 61 then 
			if R['天赋内功'] == 106 then 
				pd = 1
			end
		end	
	end

	--奇门
	if qx == 65 then 
		if R['特殊兵器'] >= 100 then 
			pd = 1
		end
	end	
	if qx == 69 then 
		if R['特殊兵器'] >= 200 then 
			pd = 1
		end
	end	
	if qx == 72 then 
		if R['特殊兵器'] >= 400 then 
			pd = 1
		end
	end	


	--阴内
	if R['内力性质'] == 0 or R['内力性质'] == 3 then 
		if qx == 76 then 
			--紫霞神功/寒冰真气到极
			if  KF_level(id,89) >= 10 or KF_level(id,216) >= 10   then 
				pd = 1
			end
		end	
		if qx == 80 then 
			if R['内力最大值'] >= 5000 then 
				pd = 1
			end
		end	
		--精通天赋内功九阴神功
		if qx == 83 then 
			if R['天赋内功'] == 107 then 
				pd = 1
			end
		end	
	end	

	--低资
	if qx == 87 then 
		--鲸息功/龙象般若功/蛤蟆功/龟息功/狮吼功到极
		if KF_level(id,103) >= 10 or KF_level(id,180) >= 10 or KF_level(id,92) >= 10 or KF_level(id,95) >= 10 or KF_level(id,227) >= 10then 
			pd = 1
		end
	end	
	if qx == 91 then 
		if R['内力最大值'] >= 6000 then 
			pd = 1
		end
	end	
	if qx == 95 then 
		--学会左右互搏
		if Pmiji(id,4) then 
			pd = 1
		end
	end	

	--轻功
	if qx == 99 then 
		if R['轻功'] >= 200 then 
			pd = 1
		end
	end	
	if qx == 103 then 
		if R['轻功'] >= 300 then 
			pd = 1
		end
	end	
	if qx == 106 then 
		if R['轻功'] >= 400 then 
			pd = 1
		end
	end	

	--回复系
	if qx == 110 then 
		--罗汉伏魔功/紫霞神功/混元功/枯荣禅功且到极
		if KF_level(id,89) >= 10 or KF_level(id,90) >= 10 or KF_level(id,96) >= 10 or KF_level(id,207) >= 10  then 
			pd = 1
		end
	end	
	if qx == 114 then 
		if R['内力最大值'] >= 5000 then 
			pd = 1
		end
	end	
	--精通长生诀/大长和诀/浑天气功/枯荣禅功
	if qx == 117 then 
		if R['天赋内功'] == 203 or R['天赋内功'] == 253 or R['天赋内功'] == 207 then 
			pd = 1
		end
	end	

	--调和内
	if R['内力性质'] == 2 or R['内力性质'] == 3 then 
		if qx == 121 then 
			--调和内且太虚剑意/忘情天书/小无相功到极
			if KF_level(id,98) >= 10 or  KF_level(id,152) >= 10 or KF_level(id,177) >= 10   then 
				pd = 1
			end
		end	
		if qx == 125 then 
			if R['内力最大值'] >= 5000 then 
				pd = 1
			end
		end	
		--调和内且精通易筋神功/阴阳无极功
		if qx == 129 then 
			if R['天赋内功'] == 108  or R['天赋内功'] == 221 then 
				pd = 1
			end
		end	
	end 
	

	--中资
	if qx == 132 then 
		--乾坤大挪移到极
		if KF_level(id,97) >= 10  then 
			pd = 1
		end
	end	
	if qx == 135 then 
		if R['内力最大值'] >= 5000 then 
			pd = 1
		end
	end	
	--学会中庸之道
	if qx == 139 then 
		if Pmiji(id,1) or Pmiji(id,2) then 
			pd = 1
		end
	end	


	--高资
	if qx == 142 then 
		--奇门五转/吸星大法/化功大法到极
		if KF_level(id,317) >= 10 or KF_level(id,87) >= 10 or KF_level(id,88) >= 10  then 
			pd = 1
		end
	end	
	--
	if qx == 145 then 
		if R['内力最大值'] >= 5000 then 
			pd = 1
		end
	end	
	--学会斗转星移
	if qx == 149 then 
		if Pmiji(id,3) then 
			pd = 1
		end
	end	

	if pd == 1 then
		--lib.Debug(qx..'判定条件满足'..pd) 
		return true
	else
		--lib.Debug(qx..'判定条件未满足'..pd)
		return false
	end
	
	return pd
end

--绝招条件
function JZ_lqz(id)
	local lqz = 100
	if (id == 37 or JY.Base['畅想'] == 37) then 		
		lqz = 60 
		--lib.Debug(JY.Person[id]['姓名']..'绝招使用条件判定'..lqz)
		--return true
	else 
		lqz = 100
	end 	
	return lqz
end


--门派武功数量
function MP_wgnum(id) 
	local wgnum = 0
	for i = 1,JY.Base['武功数量'] do 
		local wg = JY.Person[id]['武功'..i]
		if JY.Wugong[wg]['门派'] == JY.Person[id]['门派'] and wg > 0 then 
			wgnum = wgnum + 1
		end
	end
	return wgnum
end

--门派名字
function MP_name(pid)
	local name = nil
	local mp = JY.Person[pid]["门派"]
	local MPname = {
				"江湖","少林寺","武当派","逍遥派","日月神教","明教","天机宫","全真教","丐帮","华山派",
				"嵩山派","青城派","衡山派","恒山派","泰山派","五毒教","古墓派","血刀门","灵霄城","峨眉派",
				"崆峒派","昆仑派","桃花岛","白驼山庄","六扇门","八卦门","慕容世家","天龙寺","星宿派","密宗",
				"藏剑山庄",
				}
	if mp >= 0 then 
		name = MPname[mp+1]
	end
	return name 
end

--武功一脉
function KF_yimai(personid,wugongid)
	local yes = 1
	local okf = 0	
	local pd = 0	
	--local nkf = JY.Thing[wugongid]['练出武功']
	--少林、武当、峨眉九阳功一脉相承九阳，
	if wugongid == 106 then
		local n = {
					{241,"武当九阳功"},
					{242,"峨眉九阳功"},
					{243,"少林九阳功"}
				}
		local k;
		local d;
		local jy = 0
		for i = 1,JY.Base["武功数量"] do
			for j = 1,#n do
				if JY.Person[personid]["武功"..i] == n[j][1] then
					k = n[j][1]
					d = n[j][2]
					jy = 1
					break
				end						
			end
			if jy == 1 then
				break
			end
		end
		okf = k
	end
	--紫霞一脉相承五岳，面板有紫霞的可以无条件学五岳剑诀
	if wugongid == 175 then
		okf = 89
	end
	--血河天魔功一脉相承
	if wugongid == 160 then
		okf = 163
	end				
	--狮子吼金刚狮子吼一脉相承
	if wugongid == 91 then
		okf = 92
	end
	--蛤蟆功鲸息功一脉相承
	if wugongid == 180 then
		okf = 95
	end
	--神照长生一脉相承
	if wugongid == 203 then
		okf = 94
	end
	--玉女剑法 玉女素心剑 一脉相承
	if wugongid == 139 then
		okf = 42
	end
	--武当心法 太极神功一脉相承
	if wugongid == 171 then
		okf = 209
	end
	--少林心法 易筋经一脉相承
	if wugongid == 108 then
		okf = 208
	end
	--全真心法 先天功一脉相承
	if wugongid == 100 then
		okf = 210
	end
	--古墓心法 玉女心经 一脉相承
	if wugongid == 154 then
		okf = 211
	end
	--华山心法 紫霞神功 一脉相承
	if wugongid == 89 then
		okf = 212
	end
	--嵩山心法 寒冰真气 一脉相承
	if wugongid == 216 then
		okf = 213
	end
	--血刀心法 血河神鉴 一脉相承
	if wugongid == 163 then
		okf = 214	
	end											 											
	--丐帮莲花功 擒龙功 一脉相承
	if wugongid == 204 then
		okf = 215
	end
	--地火功 圣火神功 一脉相承
	if wugongid == 93 then
		okf = 217
	end
	--小周天功大周天功一脉相承
	if wugongid == 190 then
		okf = 225
	end
	--參合剑气 北斗剑法 一脉相承
	if wugongid == 265 then
		okf = 266	
	end
	--绕指柔剑 柔云剑法 一脉相承
	if wugongid == 36 then
		okf = 245	
	end								
	--罗汉拳 大金刚掌 一脉相承
	if wugongid == 22 then
		okf = 1
	end
	--一字电剑周公剑法一脉相承
	if wugongid == 271 then
		okf = 321	
	end		
	--天竺佛指无相劫指一脉相承
	if wugongid == 136 then
		okf = 122
	end
	--杨家枪岳家枪法一脉相承
	if wugongid == 200 then
		okf = 68
	end
	--柴刀 解牛 一脉相承
	if wugongid == 193 then
		okf = 50
	end		       		
	--龟息功 不老长春 一脉相承	标记修改
	if wugongid == 183 then
		okf = 227
	end
	return okf
end

--能量回复
function PNGHH_nl(id)
	for i = 1,JY.Base["武功数量"] do
		local wg = JY.Person[id]["武功"..i]
		if JY.Wugong[wg]["武功类型"] == 6 and  Curr_NG(id,wg) then 
			if  JY.Wugong[wg]["层级"] == 4 then 
				AddPersonAttrib(id,'能量',2)
			elseif JY.Wugong[wg]["层级"] == 3 then 
				local nl = math.random(1,2)
				AddPersonAttrib(id,'能量',nl)
			elseif	JY.Wugong[wg]["层级"] == 2  then
				AddPersonAttrib(id,'能量',1)
			elseif JY.Wugong[wg]["层级"] == 1 and JLSD(0, 50, id) then
				AddPersonAttrib(id,'能量',1)
			end
		end
	end
end

--门派特性
function MP_TX(mid)
    local str = ""
	if mid == 0 then --江湖
		str = "可在南岭山洞学习迷踪步。"
    elseif mid == 1 then  --少林
        str = "受到攻击概率进入防御状态，【易筋真谛】概率固定60%。"
    elseif mid == 2 then --武当
        str = "【太极奥义】固定概率60%触发，主运太极神功时序增加蓄力值，太极蓄力清除时只清除一半。使用太极拳和太极剑后自动防御。"
	elseif mid == 3 then --逍遥
		str = "天山折梅手和天山六阳掌概率追加【生死符】，被生死符击中的目标攻击时概率命中减少一半，行动时小概率随机行动。"
	elseif mid == 6 then -- 天机
		str = "天机六爻：15%概率免疫以自己为中心的九宫格内的敌人的攻击。"
	elseif mid == 8 then --丐帮	
		str = "使用打狗棒法能触发【打狗要诀】，30%概率触发【降龙三叠浪】。攻击中概率偷盗目标身上的金钱和药物。"	
	elseif mid == 9 then --华山
		str = "使用剑法概率三连击，且连击不减伤害，连击时命中提升20%。"
	elseif mid == 17 then --血刀
		str = "吸血后的血量超过最大生命值，溢出吸血量会回复自身的体力和内力，伤害防御随善恶值变化。"
	elseif mid == 27 then --天龙
		str = "六脉神剑可以触发六脉奥义，皇家血脉体质提高2点，增加耗内点数一半的真实伤害。"
	elseif mid == 28 then --星宿	
		str = "攻击带毒增加100点，自身免疫中毒，行动后概率对周边六格内目标上毒40-80点。"
	elseif mid == 29 then --密宗
		str = "不装备武器攻击力+20%，不装备防具防御+20%，不装备坐骑轻功+20%。对同一个目标不间断的攻击，伤害和命中会随攻击次数而增加。"
    else 
        str = "暂未更新"
    end
	str = str..'*修炼本门武功数量大于5个增加伤害10%,*修炼本门武功数量大于8个增加伤害20%,减少伤害20%。'
    return str 
end

--判断秘技
function MIJI_PD(personid,thingid,flag)
	local kfmenu = {}
	local menu = {}
	local menu1 = {}
	local kfget = {}
	for i = 1,JY.Base['武功数量'] do 
		if JY.Person[personid]['武功'..i] > 0 then 
			kfget[JY.Person[personid]['武功'..i]] = 1
		end
	end
	for w = 0,JY.TejiNum -1 do 
		if JY.Teji[w]['武功数量'] > 0 then
			for i = 1,JY.Teji[w]['武功数量'] do
				local zkf = JY.Teji[w]['组合武功'..i]
				if kfget[zkf] == 1 then
					menu[#menu+1] = w
				end
			end
		end
	end

	--[[改动注释
	for i = 1,JY.Base['武功数量'] do 
		local xkf = JY.Person[personid]['武功'..i]
		for w = 0,JY.TejiNum -1 do 
			for a = 1,5 do 
				local zkf = JY.Teji[w]['组合武功'..a]
				if JY.Teji[w]['武功数量'] > 0 and zkf > 0 then
					if xkf == zkf then 
						menu[#menu+1] = w
						--注释测试
			           -- lib.Debug('含有武功的秘技'..w)
					end
				end	 
			end
		end
	end

	]]

	for key, value in pairs(TableUnique(menu)) do
		menu1[#menu1+1] = value
	end		
	for w = 1,#menu1 do 
		for i = 1,5 do 
			kfmenu[#kfmenu+1] = {menu1[w],JY.Teji[menu1[w]]['组合武功'..1],JY.Teji[menu1[w]]['组合武功'..2],JY.Teji[menu1[w]]['组合武功'..3],JY.Teji[menu1[w]]['组合武功'..4],JY.Teji[menu1[w]]['组合武功'..5]}
			break
		end
	end	
	--找出秘技代号 判定成功	
	local mpd = false 
	local tid  = 0
	local mid = 0
	local kmemu = {}
	if thingid == 43 then 
		mid =3
		--break
	end
	for i = 1,#menu1 do 
		for w = 2,#kfmenu[i] do 
			local kfid = kfmenu[i][w]
			if thingid == KF_thing(kfid) then 
				mpd = true
				kmemu[#kmemu+1] = {menu1[i],i}
				break
			end
		end
	end
	if mpd == true then 
		for i = 1,#kmemu do 
			mid = kmemu[i][1]
			tid = kmemu[i][2]
			--注释测试
			--lib.Debug(mid..'已判定的秘技'..mid..' 第'..tid..'个')

			--removebyvalue(kfmenu,kfmenu[menu[tid]],kfmenu[menu[tid]])
			--lib.Debug(#kfmenu)
			--计算已经完成了秘技中的几个武功
			local znum = 0
			for w = 2,#kfmenu[tid] do 
				for i = 1,JY.Base['武功数量'] do 
					if JY.Person[personid]['武功'..i] > 0 then 
						if  kfmenu[tid][w] == JY.Person[personid]['武功'..i]  then 
							znum = znum + 1							
						end	
					end
				end
			end
			--注释测试
			--lib.Debug('有'..znum..'个武功')						
			if JY.Teji[mid]['武功数量'] - znum == 0 then 
				if flag == nil then 
					instruct_68(personid,mid,1)
				else
					instruct_68(personid,mid,1,0)
				end
				Cls()
		    end
	    end	
	end	
end					

--修炼秘技正确方式
function Usething_KF(personid,thingid)
	local jy = 0
	local full = 0
	local wugongid = 0
	local oldmiji = 0
	local yes, full,yes1,full1 = nil, nil, nil, nil
	local tnum = 0
	if JY.Thing[thingid]["练出武功"] >= 0 then
		yes = 0
		full = 1
		wugongid = JY.Thing[thingid]["练出武功"]
		for i = 1, JY.Base["武功数量"] do
			if JY.Person[personid]["武功" .. i] == JY.Thing[thingid]["练出武功"] then
				yes = 1
			else
				if JY.Person[personid]["武功" .. i] == 0 then
					full = 0
				end
			end
		end
	end
	if JY.Thing[thingid]["练出秘技"] > 0 then 
		----lib.Debug('判定练出的秘技是'..JY.Thing[thingid]["练出秘技"])
		yes1 = 0
		full1 = 1
		for i = 1,10 do
			if Pmiji(personid,JY.Thing[thingid]["练出秘技"]) then
				DrawStrBoxWaitKey(string.format("%s 已经领悟 %s", JY.Person[personid]["姓名"], JY.Teji[JY.Person[personid]["秘技" .. i]]["名称"]), C_ORANGE, CC.DefaultFont)
				yes1 = 1
				----lib.Debug('已学会')
				break
			else
				if JY.Person[personid]["秘技" .. i] == 0 then
					full1 = 0
					----lib.Debug('有格子可以学')
					break
				end						
			end 
		end
	end	

	if CanUseThing(thingid, personid) then
		--lib.Debug('可以使用物品')
		--武功
		--门派初中高阶武功一脉相承
		if JY.Thing[thingid]["类型"] == 2 and JY.Thing[thingid]['练出武功'] > 0 then
			local wugong = JY.Thing[thingid]['练出武功']
			local kfcj = JY.Wugong[wugong]['层级']
			local kflx = JY.Wugong[wugong]['武功类型']
			local mpmj = {}
			local pd = false 
			if JY.Wugong[wugong]['门派'] == JY.Person[personid]['门派'] and JY.Wugong[wugong]['门派'] > 0 then 
				mpmj[#mpmj+1] = thingid
			end	
			for j = 1,#mpmj do 
				if thingid == mpmj[j]  then 
					pd = true
				end
			end
			if pd == true then 
				for i = 1,JY.Base['武功数量'] do 
					local kfyes = JY.Person[personid]["武功" .. i]
					if kfyes > 0 then 
						if JY.Wugong[kfyes]['武功类型'] == kflx and (kfcj < 4 or JY.Wugong[kfyes]['武功类型'] == 7)  then 
							--lib.Debug(JY.Wugong[kfyes]['名称']..' 类型成功 '..JY.Wugong[wugong]['名称']..'  层级'..JY.Wugong[kfyes]['层级']..' '..kfcj)
							if 	JY.Wugong[kfyes]['层级'] < kfcj  then
								--lib.Debug(JY.Wugong[kfyes]['名称']..' 层级成功 '..JY.Wugong[wugong]['名称'])								
								if JY.Wugong[wugong]['门派'] == JY.Wugong[kfyes]['门派'] and JY.Wugong[wugong]['门派'] == JY.Person[personid]['门派'] then 
									--lib.Debug(JY.Wugong[kfyes]['名称']..' 门派成功 '..JY.Wugong[wugong]['名称'])
									if  PersonKF(personid, wugong) == false then 										
										if DrawStrBoxYesNo(-1, -1, MP_name(personid).."武功一脉相承，是否将"..JY.Wugong[kfyes]['名称']..'洗为'..JY.Wugong[wugong]['名称']..'?', C_WHITE, CC.DefaultFont) then
											--JY.Person[personid]["武功" .. i] = wugong
											--JY.Person[personid]["武功等级" .. i] = 50
											instruct_33(personid,wugong,50)
											if JY.Person[personid]["天赋内功"] == kfyes then
												JY.Person[personid]["天赋内功"] = wugong
											elseif JY.Person[personid]["天赋轻功"] == kfyes then
												JY.Person[personid]["天赋轻功"] = wugong
											elseif JY.Person[personid]["天赋外功1"] == kfyes then
												JY.Person[personid]["天赋外功1"] = wugong
											elseif JY.Person[personid]["天赋外功2"] == kfyes then
												JY.Person[personid]["天赋外功2"] = wugong
											end
											--instruct_2(thingid,-1)
											yes = 2
											break
										end
									end
								end
							end
						end
					end
				end
			end
		end			
		
		local okf = 0
		local nkf = JY.Thing[thingid]['练出武功']
		--少林、武当、峨眉九阳功一脉相承九阳，
		if thingid == 83 then
			local n = {
						{241,"武当九阳功"},
						{242,"峨眉九阳功"},
						{243,"少林九阳功"}
						}
			local k;
			local d;
			for i = 1,JY.Base["武功数量"] do
				for j = 1,#n do
					if JY.Person[personid]["武功"..i] == n[j][1] then
						k = n[j][1]
						d = n[j][2]
						jy = 1
						break
					end						
				end
				if jy == 1 then
					break
				end
			end
			okf = k
		end
		--紫霞一脉相承五岳，面板有紫霞的可以无条件学五岳剑诀
		if thingid == 299 then
			okf = 89
		end
		--罗汉一脉金刚
		if thingid == 90 then 
			okf = 1
		end
		--血河天魔功一脉相承
		if thingid == 327 then
			okf = 163
		end
		--狮子吼金刚狮子吼一脉相承
		if thingid == 385 then
			okf = 92
		end
		--蛤蟆功鲸息功一脉相承
		if thingid == 308 then
			okf = 95
		end
		--神照长生一脉相承
		if thingid == 342 then
			okf = 94
		end
		--玉女剑法 玉女素心剑 一脉相承
		if thingid == 350 then
			okf = 42
		end
		--武当心法一脉太极
		if thingid == 295 then 
			okf = 209
		end		
		--少林心法 易筋经一脉相承
		if thingid == 85 then
			okf = 208
		end
		--全真心法 先天功一脉相承
		if thingid == 77 then
			okf = 210
		end
		--莲花功一脉擒龙功
		if thingid == 351 then 
			okf= 217 
		end
		--古墓心法 玉女心经 一脉相承
		if thingid == 280 then
			okf = 211
		end
		--嵩山心法 寒冰真气 一脉相承
		if thingid == 366 then
			okf = 213
		end
		--地火功 圣火神功 一脉相承
		if thingid == 70 then
			okf = 217
		end
		--小周天功大周天功一脉相承
		if thingid == 328 then
			okf = 225
		end
		--一字电剑周公剑法一脉相承
		if thingid == 428 then
			okf = 321
		end
		--天竺佛指无相劫指一脉相承
		if thingid == 269 then
			okf = 122
		end
		--杨家枪岳家枪法一脉相承
		if thingid == 386 then
			okf = 68
		end
		--參合剑气 北斗剑法 一脉相承
		if thingid == 422 then
			okf = 266
		end
		--柴刀 解牛 一脉相承
		if thingid == 331 then
			okf = 50
		end
		--龟息功 不老长春 一脉相承	标记修改
		if thingid == 317 then
			okf = 227
		end
		--血刀心法 血河一脉相承
		if thingid == 285 then	
			okf = 214
		end

		if PersonKF(personid, okf) and PersonKF(personid, nkf) == false then
			if DrawStrBoxYesNo(-1, -1, JY.Wugong[nkf]['名称']..JY.Wugong[okf]['名称'].."一脉相承，是否将"..JY.Wugong[okf]['名称'].."洗为"..JY.Wugong[nkf]['名称'].."?", C_WHITE, CC.DefaultFont) then
				for i = 1, JY.Base["武功数量"] do
					if JY.Person[personid]["武功" .. i] == okf then
						JY.Person[personid]["武功" .. i] = nkf
						JY.Person[personid]["武功等级" .. i] = 50
						if JY.Person[personid]["天赋内功"] == okf then
							JY.Person[personid]["天赋内功"] = nkf								
						end
						if JY.Person[personid]["天赋轻功"] == okf then
							JY.Person[personid]["天赋轻功"] = nkf								
						end
						if JY.Person[personid]["天赋外功1"] == okf then
							JY.Person[personid]["天赋外功1"] = nkf								
						end
						if JY.Person[personid]["天赋外功2"] == okf then
							JY.Person[personid]["天赋外功2"] = nkf								
						end
						MIJI_PD(personid,thingid)
						yes = 2
						break
					end
				end
			end
		end
		--如果已经满武功并且选择的武功没有学会，则不可装备修炼
		if yes == 0 and full == 1 then
			DrawStrBoxWaitKey("修炼武功数已达本周目上限", C_WHITE, CC.DefaultFont)
			return 0
		end	
		--葵花点穴手
		if CC.Shemale2[thingid] == 1 then
			if personid == 0 and CC.TX["笑傲邪线"] == 2 then
				yes = 2
			elseif personid == 92 then
				say("……我还需要切吗？",92,1)
				return 0
			elseif JY.Person[personid]["性别"] == 0 and CanUseThing(thingid, personid) then
				Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
				if DrawStrBoxYesNo(-1, -1, "修炼此书必须先挥刀自宫，是否仍要修炼?", C_WHITE, CC.DefaultFont) == false then
					--instruct_2(93,1)
					return 0
				else
					lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_RED, 128)
					ShowScreen()
					lib.Delay(80)
					lib.ShowSlow(15, 1)
					Cls()
					lib.ShowSlow(50, 0)
					JY.Person[personid]["性别"] = 2
					local add, str = AddPersonAttrib(personid, "攻击力", -20)
					DrawStrBoxWaitKey(JY.Person[personid]["姓名"] .. str, C_ORANGE, CC.DefaultFont)
					add, str = AddPersonAttrib(personid, "防御力", -30)
					DrawStrBoxWaitKey(JY.Person[personid]["姓名"] .. str, C_ORANGE, CC.DefaultFont)
					if JY.Base["标准"] > 0 then
						JY.Person[0]["外号"] = "姑娘"
						JY.Person[0]["外号2"] = "丫头"
						local zddh = 227
						local js = JY.Base["标准"]
						local jsdz = JY.Person[0]["头像代号"]
						if js == 3 then
						jsdz = 228
						elseif js == 4 then
						jsdz = 229
						elseif js == 5 then
						jsdz = 230
						else
						jsdz = 227
						end
						JY.Person[0]["半身像"] = 555+JY.Base["标准"]
						local f_ani = {
						{0, 0, 0}, 
						{9, 9, 7}, 
						{8, 8, 6}, 
						{8, 8, 6}, 
						{9, 7, 7}}
						for i = 1, 5 do
							JY.Person[0]["出招动画帧数" .. i] = f_ani[i][1]
							JY.Person[0]["出招动画延迟" .. i] = f_ani[i][3]
							JY.Person[0]["武功音效延迟" .. i] = f_ani[i][2]
						end
					end
				end

			elseif JY.Person[personid]["性别"] == 1 then
				DrawStrBoxWaitKey("此人不适合修炼此物品", C_WHITE, CC.DefaultFont)
				return 0
			end
		end				
		--葵花宝典
		if CC.Shemale[thingid] == 1 then
			--lib.Debug('可以学葵花')
			--剑神可以直接学
			if (personid == 0 and JY.Base["标准"] == 3) or (personid == 0 and JY.Base["畅想"] == 652 ) or (personid == 0 and JY.Base["畅想"] == 189 ) then
				say("嗯……我看看，这套武功的精妙之处其实不在于是否自宫。看我如何以剑入道克服这个问题！",0,1)
				yes = 2
				--lib.Debug('剑神可以直接学')
			--主角打赢葵花尊者，可以直接学
			elseif personid == 0 and CC.TX["笑傲邪线"] == 2 then
				yes = 2
				--lib.Debug('笑傲邪线可以直接学')
			elseif personid == 92 then
				say("……我还需要切吗？",92,1)
				return 0
			elseif JY.Person[personid]["性别"] == 0 and CanUseThing(thingid, personid) then
				--lib.Debug('正常学葵花')
				Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
				if DrawStrBoxYesNo(-1, -1, "修炼此书必须先挥刀自宫，是否仍要修炼?", C_WHITE, CC.DefaultFont) == false then
					return 0
				else
					lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_RED, 128)
					ShowScreen()
					lib.Delay(80)
					lib.ShowSlow(15, 1)
					Cls()
					lib.ShowSlow(50, 0)
					JY.Person[personid]["性别"] = 2
					local add, str = AddPersonAttrib(personid, "攻击力", -20)
					DrawStrBoxWaitKey(JY.Person[personid]["姓名"] .. str, C_ORANGE, CC.DefaultFont)
					add, str = AddPersonAttrib(personid, "防御力", -30)
					DrawStrBoxWaitKey(JY.Person[personid]["姓名"] .. str, C_ORANGE, CC.DefaultFont)
					if JY.Base["标准"] > 0 then
						JY.Person[0]["外号"] = "姑娘"
						JY.Person[0]["外号2"] = "丫头"
						local zddh = 227
						local js = JY.Base["标准"]
						local jsdz = JY.Person[0]["头像代号"]
						if js == 3 then
						jsdz = 228
						elseif js == 4 then
						jsdz = 229
						elseif js == 5 then
						jsdz = 230
						else
						jsdz = 227
						end
						JY.Person[0]["半身像"] = 555+JY.Base["标准"]
						local f_ani = {
						{0, 0, 0}, 
						{9, 9, 7}, 
						{8, 8, 6}, 
						{8, 8, 6}, 
						{9, 7, 7}}
						for i = 1, 5 do
							JY.Person[0]["出招动画帧数" .. i] = f_ani[i][1]
							JY.Person[0]["出招动画延迟" .. i] = f_ani[i][3]
							JY.Person[0]["武功音效延迟" .. i] = f_ani[i][2]
						end
					end
				end

			elseif JY.Person[personid]["性别"] == 1 then
				DrawStrBoxWaitKey("此人不适合修炼此物品", C_WHITE, CC.DefaultFont)
				return 0
			end
		end	
		if JY.Thing[thingid]["类型"] == 2 and  JY.Thing[thingid]["练出武功"] < 1 and  JY.Thing[thingid]["练出秘技"] < 1  then	
			--lib.Debug(JY.Person[0]["姓名"].."修炼"..JY.Thing[thingid]["名称"].."成功")				
			AddPersonAttrib(personid, "内力最大值", JY.Thing[thingid]["加内力最大值"]*10)
			AddPersonAttrib(personid, "攻击力", JY.Thing[thingid]["加攻击力"]*10)
			AddPersonAttrib(personid, "轻功", JY.Thing[thingid]["加轻功"]*10)
			AddPersonAttrib(personid, "防御力", JY.Thing[thingid]["加防御力"]*10)
			AddPersonAttrib(personid, "医疗能力", JY.Thing[thingid]["加医疗能力"]*10)
			AddPersonAttrib(personid, "用毒能力", JY.Thing[thingid]["加用毒能力"]*10)
			AddPersonAttrib(personid, "解毒能力", JY.Thing[thingid]["加解毒能力"]*10)
			AddPersonAttrib(personid, "抗毒能力", JY.Thing[thingid]["加抗毒能力"]*10)
			DrawStrBoxWaitKey(JY.Person[personid]["姓名"].."修炼"..JY.Thing[thingid]["名称"].."成功", C_GOLD, CC.DefaultFont,nil, C_RED)
		end	
		--if yes == 2 then 
		--学会武功或激活秘技		
		if (yes == 0 or yes == 2) and full == 0  then
			local kfnum = nil
			local oldwugong = 0
			local oldmiji = 0
			local pid = personid
			local thingid = thingid
			local p = JY.Person[pid]
			--武功				
			for i = 1, JY.Base["武功数量"] do
				if JY.Person[personid]["武功" .. i] == JY.Thing[thingid]["练出武功"] then
					DrawStrBoxWaitKey(string.format("%s 已经学会 %s", JY.Person[personid]["姓名"], JY.Wugong[wugongid]["名称"]), C_ORANGE, CC.DefaultFont)
					oldwugong = 1
				end 
				if oldwugong == 0 then
					----lib.Debug('可以练武功')
					if JY.Person[personid]["武功" .. i] == 0 then
						JY.Person[personid]["武功" .. i] = wugongid
						JY.Person[personid]["武功等级" .. i] = 0;
						kfnum = i
						KF_zsset(personid,wugongid)
						--instruct_2(thingid,-1)
						--学会秘技斗转
						if thingid == 118 then 
							instruct_68(personid,3,1)
						end
						DrawStrBoxWaitKey(string.format("%s 学会了武功 %s ", JY.Person[personid]["姓名"], JY.Wugong[wugongid]["名称"]), C_ORANGE, CC.DefaultFont)
						MIJI_PD(personid,thingid)
						AddPersonAttrib(pid, "生命最大值", JY.Thing[thingid]["加生命最大值"])
						--修炼血刀减少生命
						--狄云不减
						if thingid == 139 and match_ID(pid, 37) == false then
							AddPersonAttrib(pid, "生命最大值", -15)
							AddPersonAttrib(pid, "生命", -15)
							if JY.Person[pid]["生命最大值"] < 1 then
							JY.Person[pid]["生命最大值"] = 1
							end
						end
						if JY.Person[pid]["生命"] < 1 then
							JY.Person[pid]["生命"] = 1
						end
						if JY.Thing[thingid]["改变内力性质"] == 2 and JY.Person[pid]["内力性质"] ~= 3 and match_ID(pid, 9987)==false then
							p["内力性质"] = 2
							if match_ID(pid, 9771) then
								JY.Person[pid]["内力性质"] = 1
							end
						end
					
						local xsbs = 1
						local swbs = 1	
						local bqz = 0
						local bqz1 = 0 					
						if match_ID(pid, 9928) or match_ID(pid, 9862) then		--冯衡 双倍属性值
							swbs = 2
						end
						if match_ID(pid, 9928) or match_ID(pid, 9863) then
							xsbs = 2
						end
						
						if match_ID(pid,9947) then
							for i = 1, JY.Base["武功数量"] do					  
								if JY.Thing[thingid]["练出武功"] == JY.Person[pid]["武功" .. i]  and JY.Wugong[wugongid]["武功类型"] == 6 then 
									bqz = bqz + 1						
								end	
							end	
							bqz1 = bqz*20
						end

						local qf = Pqfcz(pid)/100
						local zf = Pzfcz(pid)/100
						local jf = Pjfcz(pid)/100
						local df = Pdfcz(pid)/100
						local qm = Pqmcz(pid)/100
						qf = string.format("%.2f",qf)
						zf = string.format("%.2f",zf)
						jf = string.format("%.2f",jf)
						df = string.format("%.2f",df)
						qm = string.format("%.2f",qm)	
						
						AddPersonAttrib(pid, "攻击力", JY.Thing[thingid]["加攻击力"]*swbs)
						AddPersonAttrib(pid, "轻功", JY.Thing[thingid]["加轻功"]*swbs)
						AddPersonAttrib(pid, "防御力", JY.Thing[thingid]["加防御力"]*swbs)
						AddPersonAttrib(pid, "内力最大值", JY.Thing[thingid]["加内力最大值"])
						AddPersonAttrib(pid, "医疗能力", JY.Thing[thingid]["加医疗能力"])
						AddPersonAttrib(pid, "用毒能力", JY.Thing[thingid]["加用毒能力"])
						AddPersonAttrib(pid, "解毒能力", JY.Thing[thingid]["加解毒能力"])
						AddPersonAttrib(pid, "抗毒能力", JY.Thing[thingid]["加抗毒能力"])

						AddPersonAttrib(pid, "拳掌功夫", JY.Thing[thingid]["加拳掌功夫"]*xsbs*qf+bqz1)
						AddPersonAttrib(pid, "指法技巧", JY.Thing[thingid]["加指法技巧"]*xsbs*zf+bqz1)
						AddPersonAttrib(pid, "御剑能力", JY.Thing[thingid]["加御剑能力"]*xsbs*jf+bqz1)
						AddPersonAttrib(pid, "耍刀技巧", JY.Thing[thingid]["加耍刀技巧"]*xsbs*df+bqz1)
						AddPersonAttrib(pid, "特殊兵器", JY.Thing[thingid]["加特殊兵器"]*xsbs*qm+bqz1)
					
						AddPersonAttrib(pid, "暗器技巧", JY.Thing[thingid]["加暗器技巧"])
						AddPersonAttrib(pid, "武学常识", JY.Thing[thingid]["加武学常识"])
						--AddPersonAttrib(pid, "品德", JY.Thing[thingid]["加品德"])
						AddPersonAttrib(pid, "攻击带毒", JY.Thing[thingid]["加攻击带毒"])
						--桃花绝技
						break;
					end					
				end
			end
		end
		--if pmiji(personid,miji) then 
		if yes1 == 0 and full1 == 0 then
			local pid = personid
			local p = JY.Person[pid]
			--秘技					
			local pd = false
			local miji = JY.Thing[thingid]["练出秘技"]
			if thingid == 372 then
				----lib.Debug('判定修炼秘籍成功')
				if Pmiji(personid,1) or Pmiji(personid,2) then
					pd = true
					----lib.Debug('判定已会学')
				end																								
				if pd == false then		
					local r = LGMsgBox("请选择", "何为中庸之道？*一：天命之谓性*二：率性之谓道", {"一","二"}, 2, 189)		
					if r == 1  then							
						instruct_68(personid,1,1)
						return 1
					elseif r == 2  then								
						instruct_68(personid,2,1)
						return 1	
					end
				else
					DrawStrBoxWaitKey(string.format("%s 已经领悟 %s", JY.Person[personid]["姓名"], "中庸之道"), C_ORANGE, CC.DefaultFont)
					return 1
				end	
			else	
				AddPersonAttrib(personid, "内力最大值", JY.Thing[thingid]["加内力最大值"]*10)
				AddPersonAttrib(personid, "攻击力", JY.Thing[thingid]["加攻击力"]*10)
				AddPersonAttrib(personid, "轻功", JY.Thing[thingid]["加轻功"]*10)
				AddPersonAttrib(personid, "防御力", JY.Thing[thingid]["加防御力"]*10)
				AddPersonAttrib(personid, "医疗能力", JY.Thing[thingid]["加医疗能力"]*10)
				AddPersonAttrib(personid, "用毒能力", JY.Thing[thingid]["加用毒能力"]*10)
				AddPersonAttrib(personid, "解毒能力", JY.Thing[thingid]["加解毒能力"]*10)
				AddPersonAttrib(personid, "抗毒能力", JY.Thing[thingid]["加抗毒能力"]*10)
				AddPersonAttrib(personid, "拳掌功夫", JY.Thing[thingid]["加拳掌功夫"]*10)
				AddPersonAttrib(personid, "指法技巧", JY.Thing[thingid]["加指法技巧"]*10)
				AddPersonAttrib(personid, "御剑能力", JY.Thing[thingid]["加御剑能力"]*10)
				AddPersonAttrib(personid, "耍刀技巧", JY.Thing[thingid]["加耍刀技巧"]*10)
				AddPersonAttrib(personid, "特殊兵器", JY.Thing[thingid]["加特殊兵器"]*10)
				AddPersonAttrib(personid, "暗器技巧", JY.Thing[thingid]["加暗器技巧"]*10)
				AddPersonAttrib(personid, "命中", JY.Thing[thingid]["加命中"]*10)
				AddPersonAttrib(personid, "格档", JY.Thing[thingid]["加招架"]*10)
				AddPersonAttrib(personid, "攻击带毒", JY.Thing[thingid]["加攻击带毒"]*10)
				instruct_68(personid,JY.Thing[thingid]["练出秘技"],1)
				return 1
			end				
		end	
	else
		DrawStrBoxWaitKey("此人不适合修炼此物品", C_WHITE, CC.DefaultFont)
		return 0				
	end				
end

---无秘籍武功升级加属性
function KF_addsx(pid,lvkf)
	local wugonglx = JY.Wugong[lvkf]['武功类型']
	local wugonglv = JY.Wugong[lvkf]['层级']
	local xsbs,swbs,bqz,bqz1 = 1,1,0,0				
	if  match_ID(pid, 9928) or match_ID(pid, 9862) then		--冯衡 双倍属性值
		swbs = 2
	end
	if  match_ID(pid, 9928) or match_ID(pid, 9863) then
		xsbs = 2
	end
	local p = JY.Person[pid]
	if KF_thing(lvkf) == nil then 
	   if wugonglx == 1 then 
			AddPersonAttrib(pid,'攻击力',(wugonglv+1)*swbs)
			AddPersonAttrib(pid,'拳掌功夫',(wugonglv+1)*xsbs)
			--lib.Debug('增加拳掌功夫'..(wugonglv+1)*xsbs)
			--lib.Debug('增加攻击力'..(wugonglv+1)*swbs)
	   end 
	   if wugonglx == 2 then 
			AddPersonAttrib(pid,'攻击力',(wugonglv+1)*swbs)
			AddPersonAttrib(pid,'指法技巧',(wugonglv+1)*xsbs)
			--lib.Debug('增加指法技巧'..(wugonglv+1)*xsbs)
			--lib.Debug('增加攻击力'..(wugonglv+1)*swbs)
		end 
		if wugonglx == 3 then 
			AddPersonAttrib(pid,'攻击力',wugonglv*swbs)
			AddPersonAttrib(pid,'轻功',1*swbs)
			AddPersonAttrib(pid,'御剑能力',(wugonglv+1)*xsbs)
			--lib.Debug('增加御剑能力'..(wugonglv+1)*xsbs)
			--lib.Debug('增加攻击力'..wugonglv*swbs)
			--lib.Debug('增加轻功'..1*swbs)
		end 
		if wugonglx == 4 then 
			AddPersonAttrib(pid,'攻击力',(wugonglv+1)*swbs)
			AddPersonAttrib(pid,'耍刀技巧',(wugonglv+1)*xsbs)
			--lib.Debug('增加耍刀技巧'..(wugonglv+1)*xsbs)
			--lib.Debug('增加攻击力'..(wugonglv+1)*swbs)
		end 
		if wugonglx == 5 then 
			AddPersonAttrib(pid,'攻击力',wugonglv*swbs)
			AddPersonAttrib(pid,'防御力',1*swbs)
			AddPersonAttrib(pid,'特殊兵器 ',(wugonglv+1)*xsbs)
			--lib.Debug('增加特殊兵器'..(wugonglv+1)*xsbs)
			--lib.Debug('增加攻击力'..wugonglv*swbs)
			--lib.Debug('增加防御力'..1*swbs)
		end 
		if wugonglx == 6 then 
			AddPersonAttrib(pid,'攻击力',1*swbs)
			AddPersonAttrib(pid,'防御力',wugonglv*swbs)
			--lib.Debug('增加防御力'..wugonglv*xsbs)
			--lib.Debug('增加攻击力'..1*swbs)
		end 
		if wugonglx == 7 then 
			AddPersonAttrib(pid,'轻功',(wugonglv+1)*swbs)
			--lib.Debug('增加轻功'..(wugonglv+1)*swbs)
		end
	else 
		local thingid = KF_thing(lvkf)
		AddPersonAttrib(pid, "生命最大值", JY.Thing[thingid]["加生命最大值"])
		--修炼血刀减少生命
		--狄云不减
		if thingid == 139 and match_ID(pid, 37) == false then
			AddPersonAttrib(pid, "生命最大值", -15)
			AddPersonAttrib(pid, "生命", -15)
			if JY.Person[pid]["生命最大值"] < 1 then
				JY.Person[pid]["生命最大值"] = 1
			end
		end
		if JY.Person[pid]["生命"] < 1 then
			JY.Person[pid]["生命"] = 1
		end
		if JY.Thing[thingid]["改变内力性质"] == 2 and JY.Person[pid]["内力性质"] ~= 3 and match_ID(pid, 9987)==false then
			p["内力性质"] = 2
			if match_ID(pid, 9771) then
				JY.Person[pid]["内力性质"] = 1
			end
		end						

		if match_ID(pid,9947) then
			for i = 1, JY.Base["武功数量"] do					  
				if JY.Thing[thingid]["练出武功"] == JY.Person[pid]["武功" .. i]  and JY.Wugong[lvkf]["武功类型"] == 6 then 
				bqz = bqz + 1						
				end	
			end	
			bqz1 = bqz*20
		end
		local qf,zf,jf,df,qm = Pqfcz(pid)/100,Pzfcz(pid)/100,Pjfcz(pid)/100, Pdfcz(pid)/100,Pqmcz(pid)/100						
		AddPersonAttrib(pid, "攻击力", JY.Thing[thingid]["加攻击力"]*swbs)
		AddPersonAttrib(pid, "轻功", JY.Thing[thingid]["加轻功"]*swbs)
		AddPersonAttrib(pid, "防御力", JY.Thing[thingid]["加防御力"]*swbs)
		AddPersonAttrib(pid, "内力最大值", JY.Thing[thingid]["加内力最大值"])
		AddPersonAttrib(pid, "医疗能力", JY.Thing[thingid]["加医疗能力"])
		AddPersonAttrib(pid, "用毒能力", JY.Thing[thingid]["加用毒能力"])
		AddPersonAttrib(pid, "解毒能力", JY.Thing[thingid]["加解毒能力"])
		AddPersonAttrib(pid, "抗毒能力", JY.Thing[thingid]["加抗毒能力"])
		AddPersonAttrib(pid, "拳掌功夫", JY.Thing[thingid]["加拳掌功夫"]*xsbs*qf+bqz1)
		AddPersonAttrib(pid, "指法技巧", JY.Thing[thingid]["加指法技巧"]*xsbs*zf+bqz1)
		AddPersonAttrib(pid, "御剑能力", JY.Thing[thingid]["加御剑能力"]*xsbs*jf+bqz1)
		AddPersonAttrib(pid, "耍刀技巧", JY.Thing[thingid]["加耍刀技巧"]*xsbs*df+bqz1)
		AddPersonAttrib(pid, "特殊兵器", JY.Thing[thingid]["加特殊兵器"]*xsbs*qm+bqz1)		
		AddPersonAttrib(pid, "暗器技巧", JY.Thing[thingid]["加暗器技巧"])
		AddPersonAttrib(pid, "武学常识", JY.Thing[thingid]["加武学常识"])
		AddPersonAttrib(pid, "品德", JY.Thing[thingid]["加品德"])
		AddPersonAttrib(pid, "攻击带毒", JY.Thing[thingid]["加攻击带毒"])
	end
end

--队友互动设定
function Menu_duiyou(id)
    local bx,by = CC.WX,CC.HY
	local size =CC.DefaultFont
	local x,y = CC.ScreenW/2+size*2,CC.ScreenH/2-size*2
	local str
	local function rudui(id)
		if instruct_20(20,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label1
			instruct_10(id);   --  10(A):加入人物李文秀
			instruct_14();   --  14(E):场景变黑
			instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			if id == 49 then 
				instruct_3(-2,11,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			end
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_13();   --  13(D):重新显示场景
			do return; end
		end    --:Label1
		say("你的队伍已满，我无法加入。", id,0);
		instruct_0();   --  0(0)::空语句(清屏)
	end
	local function psay(id)
		local sm = ""
		if JY.Person[id]['性别'] == 1 then
			local ms = {"让我跟随你一起战斗,能提高我对你的好感度。","给我送礼也是能迅速提高好感的途径哦。","哎，天天闷在屋里太无聊了，不如你带我出出转转吧。","我只要饭管饱，好养活的很。"}
			sm = ms[math.random(#ms)]
		else
			sm = "有需要我帮忙的地方吗？"
		end
		say(sm,id,0)
	end
	local function plw(id)
        local lwlx 
        for i,v in ipairs(CC.AllPersonExit) do
            if v[1] == id  then
                lwlx = v[3]
                break
            end           
        end
        local thing = {}
        local thingnum = {}
        for i = 0, CC.MyThingNum - 1 do
            thing[i] = -1
            thingnum[i] = 0
        end
        local num = 0
        local thid = 0
        for i = 0, CC.MyThingNum - 1 do
            thid = JY.Base["物品" .. i + 1]
            if thid >= 0 then
                if JY.Thing[thid]["礼物类型"] == lwlx then
                    thing[num] = thid
                    thingnum[num] = JY.Base["物品数量" .. i + 1]
                    num = num + 1
                end	
            end
        end
        local r = SelectThing(thing, thingnum)
        if r > 0 then 
            local n = math.random(5,10)
            JY.Person[id]['好感'] = JY.Person[id]['好感'] + n
            DrawStrBoxWaitKey(JY.Person[id]['姓名']..'好感增加'..n..'点', C_WHITE, CC.DefaultFont)
            instruct_2(r,-1)
            Cls()
        end
        return 0
	end
	local function hun(id)
        local pd = 1 
        local pdmenu = {{57,56},{19,79},{55,626},{57,626},{250,582},{43,582},{165,81},{3,545}}
        for i = 1,#pdmenu do 
            if JY.Base['畅想'] == pdmenu[i][1] and id == pdmenu[i][2] then 
                pd = 0
            end
        end
		if id == 171 or id == 172 then 
			pd = 0 
		end
        if JY.Person[id]['好感'] >= 100 and JY.Person[0]['性别'] == 0 and pd == 1  then 
            say("君当作磐石，妾当作蒲苇；蒲苇韧如丝，磐石无转移。谷则异室，死则同穴。奴家余生就托于公子了。", id,0); 
            Cls()
            say("必不负姑娘此情。", 0,1); 
            Cls()           
            dark()
			instruct_40(0)
            stands()
            Cls()
            light() 
            --instruct_10(id)
            addevent(-2,128,1,nil,1,5101*2)
            My_Enter_SubScene(70,10,30,0)
            addevent(70,62,1,nil,1,8250)
            addevent(70,61,1,nil,1,5098)
            --instruct_19(10,30)

            say("两姓联姻，一堂缔约，良缘永结，匹配同称。看此日桃花灼灼，宜室宜家，卜他年瓜瓞绵绵，尔昌尔炽。谨以白头之约，书向鸿笺，好将红叶之盟，载明鸳谱。此证。",33, 0,"南贤")
            Cls()
            say("维鹊有巢，维鸠居之。之子于归，百两御之。维鹊有巢，维鸠方之。之子于归，百两将之。维鹊有巢，维鸠盈之。之子于归，百两成之。此证。",256, 0,"北丑")
            Cls()                    
            lib.LoadPNG(91,(307)*2,-1,-1,1)
            ShowScreen()
            lib.Delay(1000)
            lib.LoadPNG(91,(308)*2,-1,-1,1)
            ShowScreen()
            lib.Delay(1000)
            dark()
            addevent()
            null(70,62)
            null(70,128)
            null(70,61)           
            --addevent()
            light()
            JY.Base['妻子'] = id
            JY.Base['结婚时间'] = CC.Year
        else
            if pd == 0 then 
                say("...你也不想想你跟我的关系。", id,0); 
            elseif JY.Person[0]['性别'] == 0 then 
                say("...你还行吗？", id,0);
            else
		        say("我们的感情的还没有到那一步。", id,0); 
            end
        end
	end
	local function Est()
		return 0
	end	

	if JY.Person[id]['性别'] == 1 then
	  	str = {{"闲    聊","加入队伍","送    礼","求    婚","离    开"},{psay,rudui,plw,hun,Est}}
	else
	  	str = {{"闲    聊","加入队伍","离    开"},{psay,rudui,Est}}
	end
	local r = LGMsgBox("请选择", "请问有需要我帮忙的地方吗？", str[1], #str[1], id,1)
	if r > 0 then
		str[2][r](id)
	end
end

--成就
function LGCHENGJIU()
	local bx,by = CC.WX,CC.HY
	local menu = {	{"一骑当千","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。"},
					{"一骑当千","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。"},
					}				
	local size = CC.FontSmall2 
	local menu1 = nil 
	CC.CHENGJIU[1] = 1
	local color = C_WHITE1

	for i = 1,#CC.CHENGJIU do
		if CC.CHENGJIU[i] == nil then 
			menu1[#menu1+1] = i
		end
	end
	local px,py = -1,-1
	local n,m = 0,0	
	local pg = 1
	local num,numm = math.modf(#CC.Personcj/14)
	num = num + 1
	local lb = 14

	local tb = 1
	local xx,yy = CC.ScreenW/1.1673,CC.ScreenH/1.1674	
	local cid = 0	
	local cj = 0
	local tc = 1
	local tmenu = {'通关记录','成就集锦'}
	local cl = C_WHITE
	while true do
		if JY.Restart == 1 then
			break
		end
		Cls();
		local tx,ty =CC.ScreenW/23.8596,CC.ScreenH/7.68
		if cj == 0 then 
			lib.LoadPicture(CC.BG01File,-1,-1)
			for i = 1,#tmenu do 
				local fx = CC.ScreenW/2-string.len(tmenu[i])/4*size*2+(i-1)*size*12-bx*120
				local color = C_WHITE1		
				lib.Background(fx-bx*10,CC.ScreenH/2-by*10,fx+bx*180,CC.ScreenH/2+by*60,50)		
				if tc == i then 
					color = C_RED
					DrawBox(fx-bx*10,CC.ScreenH/2-by*10,fx+bx*180,CC.ScreenH/2+by*60,C_RED)
				end								
				DrawString(CC.ScreenW/2-string.len(tmenu[i])/4*size*2+(i-1)*size*12-bx*120,CC.ScreenH/2,tmenu[i],color,size*2,CC.FONT2)
			end
		
		elseif cj == 2 then  
			lib.LoadPNG(91,13*2,-1,-1,1)
			if num > 1 then 
				lib.LoadPNG(91,19*2,-1,-1,1)
				local pgmenu = {"上页","下页"}
				for i = 1,2 do 
					local cl = color 
					if tb == i then 
						cl = C_RED
					end
					lib.DrawStr(xx+size*1.4+(i-1)*size*3.6,CC.ScreenH/25.6,pgmenu[i], cl,size, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)
					lib.DrawStr(xx+size*3.95,CC.ScreenH/27,pg,C_WHITE,size*1.3, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)
				end
			end
			local cj = 0
			for i = 1,#CC.Personcj do
				if CC.Personcj[i][7] == 1 then 
					cj = cj + 1
				end
			end
			lib.DrawStr(tx+size*6,size*1.8,"已完成"..cj.."/总成就"..#CC.Personcj,C_WHITE,size*1,CONFIG.CurrentPath.."FONT/4.TTF",  0, 0)
			for f = 1,num do
				if pg == f then 
					if lb < #CC.Personcj then 
						lb = #CC.Personcj
					end
					if pg > 1 then
						if pg < num then 
							lb = 14
						elseif pg == num  then 
							lb = #CC.Personcj - 14*(num-1) 
						end
					end
					for i = 1,lb do 					
						cid = i+14*(pg-1)
						if CC.Personcj[i] ~= nil then 
							local h = size*4.5
							--local w = CC.ScreenW/11.294
							local w = CC.ScreenW/2
							local h1 = 0 
							local str
							local wjx = {"★","★★","★★★","★★★★","★★★★★",}
							local jlna = wjx[CC.Personcj[i][5]]
							lib.LoadPNG(91,(501)*2,tx+w*m,ty+size/2+n*h,1,0,CC.ScreenH/16)
							tjm(tx+CC.ScreenW/15.1111+w*m,CC.ScreenH/6.7368+n*h,CC.Personcj[cid][4],color,size,16,size)
							if CC.Personcj[cid][7] == 1 then
								lib.LoadPNG(91,62*2,tx+CC.ScreenW/2.931+w*m,ty+CC.ScreenH/40.421+n*h,1)
							else
								lib.LoadPNG(91,207*2,tx+CC.ScreenW/2.931+w*m,ty+CC.ScreenH/40.421+n*h,1)
							end
							DrawString(tx+CC.ScreenW/15.1111+w*m,ty+size*3+n*h,"...........................................................",color,size)
							tjm(tx+CC.ScreenW/272+w*m,CC.ScreenH/6.7368+n*h,CC.Personcj[cid][1],C_WHITE,size,2,size)	
							for j = 1,CC.Personcj[i][5] do 	
								DrawString(tx+CC.ScreenW/2.804+w*m+(j-1)*size/3*2,ty+n*h+ h1*size,"★",C_RED,size)														
							end
							if px > tx+CC.ScreenW/2.931+w*m and px < tx+CC.ScreenW/2.931+w*m + CC.ScreenW/15.1111 and py > ty+CC.ScreenH/40.421+n*h and  py < ty+CC.ScreenH/9.4815+n*h then 
								lib.LoadPNG(91,37*2,tx+CC.ScreenW/4.5333+w*m,ty+CC.ScreenH/40.421+n*h,1)
								if CC.Personcj[i][6] == 1 then 
									str = "永久增加"..CC.Personcj[i][2].."+".. CC.Personcj[i][3] 
								elseif 	CC.Personcj[i][6] == 2 then 
									str = "永久获得物品"..JY.Thing[CC.Personcj[i][2]]["名称"]
								end
							end
							n = n + 1 
							if n == 7 then 
								m = m + 1
								n = 0
							end	
						end
					end	
				end
			end
			n = 0
			m = 0
		elseif cj == 1 then 
			lib.LoadPicture(CC.BG01File,-1,-1)	
			local tgwz = "近期通关记录"
			lib.LoadPNG(91,140*2,CC.ScreenW/2-string.len(tgwz)/4*size*2-size,0,1,0,200)
			DrawString(CC.ScreenW/2-string.len(tgwz)/4*size*2-size,by*15," 近期通关记录",C_WHITE,size*2,CC.FONT2)
			
			DrawString(CC.ScreenW - 148,CC.ScreenH - 40,"按ESC键退出",LimeGreen,CC.FontSmall)
			
			local n = 0
			
			for i = #Achievements.pChar, 1, -1 do
				n = n + 1
				if n > 5 then
					break
				end
				local nd = Achievements.pChar[i].DiffLevel
				local zz = tostring(Achievements.pChar[i].CharZZ.."资")
				local ns = Achievements.pChar[i].CharNS
				local tp = Achievements.pChar[i].CharType
				local nm = Achievements.pChar[i].CharName
				local dt = Achievements.pChar[i].TimeCompleted
				DrawString(45,-10+110*n,string.format("%d周目",i),C_GOLD,CC.DefaultFont)
				DrawString(45,40+110*n,string.format("难%-d %-5s %-4s %-4s %-10s 通关时间 %s",nd, zz ,ns, tp, nm, dt),C_WHITE,CC.DefaultFont)
			end
		end
		ShowScreen()
		lib.Delay(CC.Frame)
		local key, ktype, mx, my = lib.GetKey();
		if mx ~= -1 and my ~= -1 then 
			px,py = mx,my
		end	
		if key == VK_ESCAPE or ktype == 4 then 
			if cj > 0 then 
				cj = 0
			else
				break
			end
		elseif key == VK_RETURN or key == VK_BACKSPACE then 
			if cj == 0 then 
				--if tc == 1 then 
				cj = tc 
			end
		elseif key == VK_RIGHT then
			if cj == 2 then 
				if num > 1 then 
					tb = tb + 1
					if tb > 2 then 
						tb = 2
					end
					pg = pg + 1
					if pg > num  then 
						pg = 1
					end
				end
			elseif cj == 0 then 
				tc = tc + 1
				if tc > #tmenu then 
					tc = 1
				end

			end
		elseif key ==VK_LEFT then
			if cj == 2 then 
				if num > 1 then 
					tb = tb - 1
					if tb < 1 then 
						tb = 1
					end
					pg = pg - 1
					if pg < 1 then 
						pg = num 
					end
				end
			elseif cj == 0 then 
				tc = tc - 1
				if tc < 1 then 
					tc = #tmenu
				end
			end
		else
			if cj == 2 then 
				local pd = false
				if num > 1 then 
					for i = 1,2 do 
						if mx > xx + (i-1)*CC.ScreenW/12.9523 and mx < xx + CC.ScreenW/19.4285 + (i-1)*CC.ScreenW/12.9523 and my > CC.ScreenH/25.6 and my < CC.ScreenH/25.6 + size  then 
							tb = i 
							pd = true
						end
					end
					if pd == true and ktype == 3 then 
						if tb == 1 then 
							pg = pg - 1
							if pg < 1 then 
								pg = num 
							end
						else
							pg = pg + 1
							if pg > num  then 
								pg = 1
							end
						end
					end
				end
			elseif cj == 0 then 
				local pd = false
				for i = 1,#tmenu do 
					local fx = CC.ScreenW/2-string.len(tmenu[i])/4*size*2+(i-1)*size*12-bx*120							
					if mx > fx-bx*10 and mx < fx+bx*180 and my > CC.ScreenH/2-by*10 and my < CC.ScreenH/2+by*60 then 
						pd = true 
						tc = i 
						break
					end
				end
				if pd == true and ktype == 3 then 
					cj = tc 
				end
			end
		end
	end
end 

--武功招式威力
function KF_zswl(pid,wg,choice)
	local n = 0
	local level = 0
	local wl = 0
	local n = 0	
	for i = 1,JY.Base["武功数量"] do
		if JY.Person[pid]["武功"..i] == wg then				
			level = math.modf(JY.Person[pid]["武功等级" .. i] / 100) + 1
		end
	end	
	if level > 10 then
		level = 10
	end

	wl = get_skill_power(pid, wg, level)
	if choice > 0 then
		local zh = choice
		if zh > 6 then
			zh = 6
		end
		n =  wl*(1+(zh-1)/10)
	end
	return n
end

--初始武功设定
function KfSet(p)
	--初始武功设定
	local pid = p
	local num = 0
	local ngmenu = {}
	local wgmenu = {}
	local qgmenu = {}
	local num1,num2 = 0,0 
	local wgnum = JY.Base["武功数量"] 
	local wglv = 0
	local mp = JY.Person[pid]['门派']
	----------------------------------------------
	----------------------------------------------
	--下面这个123有什么区别？？？
	if JY.Person[pid]['畅想分阶'] <= 2 then 
		wglv = 2
	end 
	if JY.Person[pid]['畅想分阶'] == 3 then 
		wglv = 2
	end  	
	----------------------------------------------
	----------------------------------------------
	--改动注释
	--如果有门派武学表格
	--判断已经学到第几个武功位置
	--判断已经学的武功
	local kfnext = 0
	local kfget = {}
	for i = 1, wgnum do
		if JY.Person[pid]['武功'..i] > 0 then 
			kfget[JY.Person[pid]['武功'..i]] = 1
		else
			kfnext = i
			break
		end
	end


	if CC.MpKf[mp] ~= nil then
		for i = 1,#CC.MpKf[mp] do
			local kf = CC.MpKf[mp][i]
			if kfnext <= 15 then
				if JY.Person[pid]['畅想分阶'] <= 3 then
					if kfget[kf] == nil and JY.Wugong[kf]['层级'] >= 2 then
						JY.Person[pid]['武功'..kfnext] = kf
						JY.Person[pid]['武功等级'..kfnext] = 999
						KF_addsx(pid,kf)
						kfnext = kfnext + 1
						kfget[kf] = 1
					end
				elseif JY.Person[pid]['畅想分阶'] > 3 and JY.Person[pid]['畅想分阶'] <= 5 then 
					if kfget[kf] == nil and JY.Wugong[kf]['层级'] < 1 then
						JY.Person[pid]['武功'..kfnext] = kf
						KF_addsx(pid,kf)
						kfnext = kfnext + 1
						kfget[kf] = 1
					end
				end
			else
				break
			end
		end
	end
	for i = 1, JY.Base["武功数量"] do
		if JY.Person[pid]["武功"..i] > 0 then 
			local wugonglvl = math.modf(JY.Person[pid]["武功等级" .. i] / 100) + 1
			local kfid = JY.Person[pid]["武功"..i]
			local wugongwl = get_skill_power(pid, kfid, wugonglvl)
			local kflx = JY.Wugong[kfid]['武功类型']
			if JY.Wugong[kfid]["武功类型"] < 6 and kfid > 0    then
				wgmenu[#wgmenu+1] = {kfid,wugongwl,kflx}
				num1 = num1 + 1	
			elseif JY.Wugong[kfid]["武功类型"] == 6 and kfid > 0 then
				num = num + 1
				ngmenu[#ngmenu+1] = {kfid,wugongwl}
			elseif JY.Wugong[kfid]["武功类型"] == 7 and kfid > 0 then
				num2 = num2 + 1
				local ms = JY.Wugong[kfid]["加闪避"] + JY.Wugong[kfid]["加命中"]
				qgmenu[#qgmenu+1] = {kfid,ms}	
			end
		end
	end
	--外功 
	if JY.Person[pid]['优先使用'] == 0 then 
		if num1 > 0 then
			local wgmenu1 = {}
			for i = 1,#wgmenu do
				wgmenu1[#wgmenu1+1] = wgmenu[i][2]
			end
			local key, max = 1, wgmenu1[1]
			for k, v in ipairs(wgmenu1) do
				if wgmenu1[k] > max then
					key, max = k, v
				end
			end
			local p_5x = {JY.Person[pid]['拳掌功夫'],JY.Person[pid]['指法技巧'],JY.Person[pid]['御剑能力'],JY.Person[pid]['耍刀技巧'],JY.Person[pid]['特殊兵器']}
			local key1,max1 = 1,p_5x[1]
			for k1,v1 in ipairs(p_5x) do 
				if p_5x[k1] > max1 then 
					key1,max1 = k1,v1 
				end
			end
			if wgmenu[key][3] == key1 then 			
				JY.Person[pid]["优先使用"] = wgmenu[key][1]
			else 
				local kfwg = {}
				local kfwg1 = {}
				for i = 1,#wgmenu do 
					if wgmenu[i][3] == key1 then 
						kfwg[#kfwg+1] = wgmenu[i][2]
						kfwg1[#kfwg1+1] =  wgmenu[i][1]
					end
				end
				local key2,max2 = 1,kfwg[1]
				for k1,v1 in ipairs(kfwg) do 
					if kfwg[k1] > max2 then 
						key2,max2 = k1,v1 
					end
				end
				JY.Person[pid]["优先使用"] = kfwg1[key2]
			end
		else
			local wgmenu1 = {}
			local wgmenu2 = {}
			local wgmenu3 = {}
			local wgmenu4 = {}
			for i = 0,JY.WugongNum - 1 do
				if JY.Wugong[i]['武功类型'] < 6  then
					if JY.Wugong[i]['层级'] == 1 then 
						wgmenu1[#wgmenu1+1] = i
					end
					if JY.Wugong[i]['层级'] == 2 then 
						wgmenu2[#wgmenu2+1] = i
					end
					if JY.Wugong[i]['层级'] == 3 then 
						wgmenu3[#wgmenu3+1] = i
					end
					if JY.Wugong[i]['层级'] == 4 then 
						wgmenu4[#wgmenu4+1] = i
					end																					
				end 
			end
			if JY.Person[pid]['畅想分阶'] > 4 then 
				local mpwg = {}
				local wu = {}
				wu = wgmenu1
				for i = 1,#wu do 				
					if JY.Wugong[wu[i]]['门派'] == JY.Person[pid]['门派'] then 
						mpwg[#mpwg+1] =wu[i] 
					end
				end
				if mpwg[1] ~= nil then 
					JY.Person[pid]['优先使用'] = mpwg[math.random(#mpwg)]
				else
					JY.Person[pid]['优先使用'] = wu[math.random(#wu)]
				end
			elseif JY.Person[pid]['畅想分阶'] == 3 or JY.Person[pid]['畅想分阶'] == 4 then 
				local mpwg = {}
				local wu = {}
				wu = wgmenu2
				for i = 1,#wu do 				
					if JY.Wugong[wu[i]]['门派'] == JY.Person[pid]['门派'] then 
						mpwg[#mpwg+1] =wu[i] 
					end
				end
				if mpwg[1] ~= nil then 
					JY.Person[pid]['优先使用'] = mpwg[math.random(#mpwg)]
				else
					JY.Person[pid]['优先使用'] = wu[math.random(#wu)]
				end
			elseif JY.Person[pid]['畅想分阶'] == 2 then 
				local mpwg = {}
				local wu = {}
				wu = wgmenu3
				for i = 1,#wu do 				
					if JY.Wugong[wu[i]]['门派'] == JY.Person[pid]['门派'] then 
						mpwg[#mpwg+1] =wu[i] 
					end
				end
				if mpwg[1] ~= nil then 
					JY.Person[pid]['优先使用'] = mpwg[math.random(#mpwg)]
				else
					JY.Person[pid]['优先使用'] = wu[math.random(#wu)]
				end
			elseif JY.Person[pid]['畅想分阶'] == 1 then 
				local mpwg = {}
				local wu = {}
				wu = wgmenu4
				for i = 1,#wu do 				
					if JY.Wugong[wu[i]]['门派'] == JY.Person[pid]['门派'] then 
						mpwg[#mpwg+1] =wu[i] 
					end
				end
				if mpwg[1] ~= nil then 
					JY.Person[pid]['优先使用'] = mpwg[math.random(#mpwg)]
				else
					JY.Person[pid]['优先使用'] = wu[math.random(#wu)]
				end
			end

		end
		if JY.Person[pid]["天赋外功1"] > 0 then
			JY.Person[pid]["优先使用"] = JY.Person[pid]["天赋外功1"]
		end
		if PersonKF(pid,JY.Person[pid]["天赋外功1"]) == false then 
			for u = 1,JY.Base['武功数量'] do 
				if JY.Person[pid]['武功'..15] > 0 then 
					JY.Person[pid]['武功'..1] = JY.Person[pid]["优先使用"]
					JY.Person[pid]['武功等级'..1] = 999
					break
				else	
					if JY.Person[pid]['武功'..u] == 0 then 
						JY.Person[pid]['武功'..u] = JY.Person[pid]["优先使用"]
						JY.Person[pid]['武功等级'..u] = 999
						break
					end
				end
			end
		end	
	end

	--内功
	--lib.Debug('设定内功的人物pid=='..pid)
	if JY.Person[pid]["主运内功"] == 0 then 		
		if num > 0 then
			--lib.Debug('有可设定的武功 设定内功的人物pid=='..pid..'')
			local ngmenu1 = {}
			for i = 1,#ngmenu do
				ngmenu1[#ngmenu1+1] = ngmenu[i][2]
			end
			local key, max = 1, ngmenu1[1]
			for k, v in ipairs(ngmenu1) do
				if ngmenu1[k] > max then
					key, max = k, v
				end
			end
			JY.Person[pid]["主运内功"] = ngmenu[key][1]			
		else
			--lib.Debug('没有可设定的武功 设定内功的人物pid=='..pid..'')
			local ngmenu4 = {}
			local ngmenu3 = {}
			local ngmenu2 = {}
			local ngmenu1 = {}
			for i = 0,JY.WugongNum - 1 do 
				if JY.Wugong[i]['武功类型'] == 6  then 
					if JY.Wugong[i]['层级'] <= 2 and i ~= 94 then 
						ngmenu2[#ngmenu2+1] = i  -- 
					end
					if JY.Wugong[i]['层级'] == 3  then 
						ngmenu3[#ngmenu3+1] = i 
					end
					if JY.Wugong[i]['层级'] == 4  then 
						ngmenu4[#ngmenu4+1] = i 
					end
				end
			end
			if (JY.Person[pid]["畅想分阶"] <= 3 or JY.Person['门派贡献'] == 5 )  then
				local mpwg = {}
				local wu = {}
				wu = ngmenu4
				for i = 1,#wu do 							
					if JY.Wugong[wu[i]]['门派'] == JY.Person[pid]['门派'] then 
						mpwg[#mpwg+1] =wu[i] 
					end
				end
				if mpwg[1] ~= nil then 
					JY.Person[pid]['主运内功'] = mpwg[math.random(#mpwg)]
				else
					if ngmenu3[1] ~= nil then 
						JY.Person[pid]['主运内功'] = ngmenu3[math.random(#ngmenu3)]
					elseif ngmenu2[1] ~= nil then 
						JY.Person[pid]['主运内功'] = ngmenu2[math.random(#ngmenu2)]					
					else
						JY.Person[pid]['主运内功'] = wu[math.random(#wu)]
					end
				end        
			elseif JY.Person[pid]["主运内功"] == 0 and JY.Person[pid]["畅想分阶"] == 4 then
				local mpwg = {}
				local wu = {}
				wu = ngmenu3
				for i = 1,#wu do 							
					if JY.Wugong[wu[i]]['门派'] == JY.Person[pid]['门派'] then 
						mpwg[#mpwg+1] =wu[i] 
					end
				end
				if mpwg[1] ~= nil then 
					JY.Person[pid]['主运内功'] = mpwg[math.random(#mpwg)]
				else
					local mpwg1 = {}
					for i = 1,#ngmenu2 do 							
						if JY.Wugong[ngmenu2[i]]['门派'] == JY.Person[pid]['门派'] then 
							mpwg1[#mpwg+1] =ngmenu2[i] 
						end
					end
					if mpwg1[1] ~= nil then 
						JY.Person[pid]['主运内功'] = mpwg1[math.random(#mpwg1)]
					else
						JY.Person[pid]['主运内功'] = wu[math.random(#wu)]
					end
				end	        
			elseif JY.Person[pid]["主运内功"] == 0 and JY.Person[pid]["畅想分阶"]  >= 5  then
				local mpwg = {}
				local wu = {}
				wu = ngmenu2
				for i = 1,#wu do 							
					if JY.Wugong[wu[i]]['门派'] == JY.Person[pid]['门派'] then 
						mpwg[#mpwg+1] =wu[i] 
					end
				end
				if mpwg[1] ~= nil then 
					JY.Person[pid]['主运内功'] = mpwg[math.random(#mpwg)]
				else
					JY.Person[pid]['主运内功'] = wu[math.random(#wu)]
				end
			end				
			if JY.Person[pid]["天赋内功"] > 0 then
				JY.Person[pid]["主运内功"] = JY.Person[pid]["天赋内功"]
			end
			for u = 1,JY.Base['武功数量'] do 
				if JY.Person[pid]['武功'..u] == 0 then 
					JY.Person[pid]['武功'..u] = JY.Person[pid]["主运内功"] 
					JY.Person[pid]['武功等级'..u] = 999
					break
				end
			end
		end
	end
	--轻功
	if JY.Person[pid]["主运轻功"] == 0 then 
		if num2 > 0 then 
			local qgmenu1 = {}
			for i = 1,#qgmenu do
				qgmenu1[#qgmenu+1] = qgmenu[i][2]
			end
			local key, max = 1, qgmenu1[1]
			for k, v in ipairs(qgmenu1) do
				if qgmenu1[k] > max then
					key, max = k, v
				end
			end
			JY.Person[pid]["主运轻功"] = qgmenu[key][1]
		else
			local ngmenu4 = {}
			local ngmenu3 = {}
			for i = 0,JY.WugongNum - 1 do 
				if JY.Wugong[i]['武功类型'] == 7  then 
					if JY.Wugong[i]['层级'] < 4  then 
						ngmenu3[#ngmenu3+1] = i 
					end
					if JY.Wugong[i]['层级'] == 4  then 
						ngmenu4[#ngmenu4+1] = i 
					end
				end
			end
			if JY.Person[pid]["主运轻功"] == 0 and ( JY.Person[pid]["畅想分阶"] <= 3 or JY.Person[pid]['门派贡献'] == 5)  then
				local mpwg = {}
				local wu = {}
				wu = ngmenu4
				for i = 1,#wu do 							
					if JY.Wugong[wu[i]]['门派'] == JY.Person[pid]['门派'] then 
						mpwg[#mpwg+1] =wu[i] 
					end
				end
				if mpwg[1] ~= nil then 
					JY.Person[pid]['主运轻功'] = mpwg[math.random(#mpwg)]
				else
					JY.Person[pid]['主运轻功'] = wu[math.random(#wu)]
				end
			elseif JY.Person[pid]["主运轻功"] == 0 and JY.Person[pid]["畅想分阶"] > 3  then
				local mpwg = {}
				local wu = {}
				wu = ngmenu3
				for i = 1,#wu do 							
					if JY.Wugong[wu[i]]['门派'] == JY.Person[pid]['门派'] then 
						mpwg[#mpwg+1] =wu[i] 
					end
				end
				if mpwg[1] ~= nil then 
					JY.Person[pid]['主运轻功'] = mpwg[math.random(#mpwg)]
				else
					JY.Person[pid]['主运轻功'] = wu[math.random(#wu)]
				end
			end
			if JY.Person[pid]["天赋轻功"] > 0 then
				JY.Person[pid]["主运轻功"] = JY.Person[pid]["天赋轻功"]
			end

			for s = 1,JY.Base['武功数量'] do 
				if JY.Person[pid]['武功'..s] == 0 then 
					JY.Person[pid]['武功'..s] = JY.Person[pid]["主运轻功"] 
					JY.Person[pid]['武功等级'..s] = 999
					break
				end
			end
		end
	end
end

--初始招式设定
function KF_zsset(personid,wugong)
    local fj = JY.Person[personid]["畅想分阶"]
    local bh = personid 
	if JY.Wugong[wugong]['武功类型'] < 7 then 
		for i = 1, JY.Base["武功数量"] do
			for p = 1,#CC.KFMove[wugong] do
				local zs = CC.WUGONGZS[i][p]
				local n = 0
				local zsn = 2
				if fj >= 4 then 
					n = 1
				end
				if fj == 3 then 
					n = 2
				end
				if fj == 2 then 
					n = 3
				end
				if fj == 1 then 
					n = 4
				end
				if wugong == JY.Person[personid]['天赋外功1']  or wugong == JY.Person[personid]['天赋外功2'] or wugong == JY.Person[personid]['天赋内功'] then 
					n = #CC.KFMove[wugong]
				end
				zsn = zsn + n
				if zsn > #CC.KFMove[wugong] then 
					zsn = #CC.KFMove[wugong]
				end
				if p <= zsn then 
					if JY.Person[personid]["武功招式"..zs] < 1 then
						JY.Person[personid]["武功招式"..zs] = 1
					end	
				end 
			end
		end
	end
end

--招式说明文字
function KF_zswz(kf,zs)
	local zswz1 = ""
	if JY.Wugong[kf]["武功类型"] == 1 then
		zswz1 = "造成目标内伤Ｇ"..(JY.Wugong[kf]["层级"]*5).."Ｗ点。"
	elseif JY.Wugong[kf]["武功类型"] == 2 then
		zswz1 = "对目标封穴Ｇ"..JY.Wugong[kf]["层级"].."~"..(JY.Wugong[kf]["层级"]*2+2).."Ｗ点。"
	elseif JY.Wugong[kf]["武功类型"] == 3 then
		zswz1 = "造成目标流血Ｇ"..(JY.Wugong[kf]["层级"]*10).."Ｗ点。"
	elseif JY.Wugong[kf]["武功类型"] == 4 then
		zswz1 = "造成目标外伤Ｇ"..(JY.Wugong[kf]["层级"]*10).."Ｗ点。"
	elseif JY.Wugong[kf]["武功类型"] == 5 then
		zswz1 = "造成目标内伤Ｇ"..(JY.Wugong[kf]["层级"]*5).."Ｗ点/对目标封穴Ｇ"..JY.Wugong[kf]["层级"].."~"..(JY.Wugong[kf]["层级"]*2+2).."Ｗ点/造成目标流血Ｇ"..(JY.Wugong[kf]["层级"]*10).."Ｗ点/造成目标灼烧Ｇ"..(JY.Wugong[kf]["层级"]*10).."Ｗ点。"	
	end
	if JY.Wugong[kf]["冰封系数"] == 1 then
		zswz1 = zswz1.."概率冰封。"
	end
	if JY.Wugong[kf]["灼烧系数"] == 1 then
		zswz1 = zswz1.."概率灼烧。"
	end
	if JY.Wugong[kf]["敌人中毒点数"] > 0 then
		zswz1 = zswz1.."对目标造成中毒Ｇ"..JY.Wugong[kf]["敌人中毒点数"].."Ｗ。"	
	end													
	if JY.Wugong[kf]["招式"..zs] > 0 then
		--1流血
		if JY.Wugong[kf]["招式"..zs] > 10 and JY.Wugong[kf]["招式"..zs] < 15 then
			zswz1 = zswz1.."额外造成目标流血Ｇ"..(JY.Wugong[kf]["层级"]*10).."Ｗ点。"
		--2封穴
		elseif JY.Wugong[kf]["招式"..zs] > 20 and JY.Wugong[kf]["招式"..zs] < 25 then
			zswz1 = zswz1.."额外造成目标封穴Ｇ"..JY.Wugong[kf]["层级"].."~"..(JY.Wugong[kf]["层级"]*2+1).."Ｗ点。"
		--3灼烧	
		elseif JY.Wugong[kf]["招式"..zs] > 30 and JY.Wugong[kf]["招式"..zs] < 35 then
			zswz1 = zswz1.."造成目标灼烧Ｇ"..(JY.Wugong[kf]["层级"]*5).."Ｗ点。"
		--4冰封		
		elseif JY.Wugong[kf]["招式"..zs] > 40 and JY.Wugong[kf]["招式"..zs] < 45 then
			zswz1 = zswz1.."造成目标冰封Ｇ"..(JY.Wugong[kf]["层级"]*10).."Ｗ点。"								
		--5内伤		
		elseif JY.Wugong[kf]["招式"..zs] > 50 and  JY.Wugong[kf]["招式"..zs] < 55 then
			zswz1 = zswz1.."造成目标内伤Ｇ"..(JY.Wugong[kf]["层级"]*10).."Ｗ点。"	
		--6中毒	
		elseif JY.Wugong[kf]["招式"..zs] > 60 and JY.Wugong[kf]["招式"..zs] < 65 then
			zswz1 = zswz1.."造成目标中毒Ｇ"..(JY.Wugong[kf]["层级"]*10).."Ｗ点。"	
		--7冻结
		elseif JY.Wugong[kf]["招式"..zs] > 70 and JY.Wugong[kf]["招式"..zs] < 75 then
			zswz1 = zswz1.."造成目标冻结Ｇ"..(JY.Wugong[kf]["层级"]*5).."Ｗ时序。"	
		--8点燃
		elseif JY.Wugong[kf]["招式"..zs] > 80 and JY.Wugong[kf]["招式"..zs] < 85 then
			zswz1 = zswz1.."造成目标点燃Ｇ"..(JY.Wugong[kf]["层级"]*2+3).."Ｗ时序。"
		--9巨毒
		elseif JY.Wugong[kf]["招式"..zs] > 90 and JY.Wugong[kf]["招式"..zs] < 95 then
			zswz1 = zswz1.."造成目标巨毒Ｇ"..JY.Wugong[kf]["层级"].."Ｗ回合,毒性发作效果双倍。"	
		--10眩晕
		elseif JY.Wugong[kf]["招式"..zs] > 100 and JY.Wugong[kf]["招式"..zs] < 105 then
			local jl = JY.Wugong[kf]["层级"]*20
			zswz1 = zswz1.."Ｇ"..jl.."%Ｗ造成目标眩晕1回合。"	
		--11撕裂		
		elseif JY.Wugong[kf]["招式"..zs] > 110 and JY.Wugong[kf]["招式"..zs] < 115 then
			local jl = JY.Wugong[kf]["招式"..zs]*20
			zswz1 = zswz1.."Ｇ"..jl.."%Ｗ造成目标撕裂10时序。"																						
		--12虚弱									
		elseif JY.Wugong[kf]["招式"..zs] > 120 and JY.Wugong[kf]["招式"..zs] < 125 then
			zswz1 = zswz1.."造成目标虚弱1回合，减少伤害和气攻Ｇ"..(JY.Wugong[kf]["层级"]*10+10).."%Ｗ。"
		--13破防								
		elseif JY.Wugong[kf]["招式"..zs] > 130 and JY.Wugong[kf]["招式"..zs] < 135 then
			zswz1 = zswz1.."减少目标防御Ｇ"..(JY.Wugong[kf]["层级"]*10).."%Ｗ。"	
		--14无视系数								
		elseif JY.Wugong[kf]["招式"..zs] > 140 and JY.Wugong[kf]["招式"..zs] < 145 then
			local xswz = {"拳法系数","指法系数","御剑系数","耍刀系数","奇门系数"}
			zswz1 = zswz1.."减少目标Ｇ"..xswz[JY.Wugong[kf]["武功类型"]]..(JY.Wugong[kf]["层级"]*10).."%Ｗ。"	
		--15固定伤害								
		elseif JY.Wugong[kf]["招式"..zs] > 150 and JY.Wugong[kf]["招式"..zs] < 155 then									
			zswz1 = zswz1.."附加额外伤害Ｇ"..(JY.Wugong[kf]["层级"]*50).."Ｗ点。"			
		--16吸血
		elseif JY.Wugong[kf]["招式"..zs] > 160 and JY.Wugong[kf]["招式"..zs] < 165 then	
			zswz1 = zswz1.."附加伤害20%吸血上限Ｇ"..(JY.Wugong[kf]["层级"]*50).."Ｗ点。"
		--17减防
		elseif JY.Wugong[kf]["招式"..zs] > 170 and JY.Wugong[kf]["招式"..zs] < 175 then	
			zswz1 = zswz1.."三回合内减少目标防御Ｇ"..(JY.Wugong[kf]["层级"]*5).."%Ｗ。"
		--18减攻
		elseif JY.Wugong[kf]["招式"..zs] > 180 and JY.Wugong[kf]["招式"..zs] < 185 then	
			zswz1 = zswz1.."三回合内减少目标攻击Ｇ"..(JY.Wugong[kf]["层级"]*5).."%Ｗ。"
		--19破气防
		elseif JY.Wugong[kf]["招式"..zs] > 190 and JY.Wugong[kf]["招式"..zs] < 195 then	
			zswz1 = zswz1.."Ｇ"..(JY.Wugong[kf]["层级"]*10).."%Ｗ概率无视气防。"
		--20增加范围
		elseif JY.Wugong[kf]["招式"..zs] > 200 and JY.Wugong[kf]["招式"..zs] < 205 then	
			zswz1 = zswz1.."Ｇ"..(JY.Wugong[kf]["层级"]*10).."%Ｗ造成大范围伤害。"
		--21再次行动
		elseif JY.Wugong[kf]["招式"..zs] > 210 and JY.Wugong[kf]["招式"..zs] < 215 then	
			zswz1 = zswz1.."Ｇ"..(JY.Wugong[kf]["层级"]*4).."%Ｗ概率再次行动。"
		--22加速
		elseif JY.Wugong[kf]["招式"..zs] > 220 and JY.Wugong[kf]["招式"..zs] < 225 then	
			zswz1 = zswz1.."下回合集气加速Ｇ"..(JY.Wugong[kf]["层级"]*10).."%Ｗ。"
		--23加连击
		elseif JY.Wugong[kf]["招式"..zs] > 230 and JY.Wugong[kf]["招式"..zs] < 235 then	
			zswz1 = zswz1.."Ｇ"..(JY.Wugong[kf]["层级"]*10).."%Ｗ概率增加连击1次。"
		--24加暴击
		elseif JY.Wugong[kf]["招式"..zs] > 240 and JY.Wugong[kf]["招式"..zs] < 245 then	
			zswz1 = zswz1.."Ｇ"..(JY.Wugong[kf]["层级"]*20+20).."%Ｗ暴击。"
		--25加暴伤
		elseif JY.Wugong[kf]["招式"..zs] > 250 and JY.Wugong[kf]["招式"..zs] < 255 then	
			zswz1 = zswz1.."增加暴击伤害Ｇ"..(JY.Wugong[kf]["层级"]*10).."%Ｗ。"
		--26必中
		elseif JY.Wugong[kf]["招式"..zs] > 260 and JY.Wugong[kf]["招式"..zs] < 265 then	
			zswz1 = zswz1.."Ｇ"..(JY.Wugong[kf]["层级"]*20+20).."%Ｗ概率必中。"
		--27防御
		elseif JY.Wugong[kf]["招式"..zs] > 270 and JY.Wugong[kf]["招式"..zs] < 275 then	
			zswz1 = zswz1.."Ｇ"..(JY.Wugong[kf]["层级"]*20+20).."%Ｗ下回合防御。"
		--28回气
		elseif JY.Wugong[kf]["招式"..zs] > 280 and JY.Wugong[kf]["招式"..zs] < 285 then	
			if JY.Wugong[kf]["层级"] == 1 then											
				zswz1 = zswz1.."回气Ｇ"..(JY.Wugong[kf]["层级"]*1).."Ｗ点。"
			else
				local hq = JY.Wugong[kf]["层级"]-1
				local hq1= JY.Wugong[kf]["层级"]
				zswz1 = zswz1.."回气Ｇ"..hq.."~"..hq1.."Ｗ点。"
			end
		--29锁足
		elseif JY.Wugong[kf]["招式"..zs] > 290 and JY.Wugong[kf]["招式"..zs] < 295 then	
			zswz1 = zswz1.."Ｇ"..(JY.Wugong[kf]["层级"]*15).."%Ｗ锁足1回合。"
		--30反击
		elseif JY.Wugong[kf]["招式"..zs] > 300 and JY.Wugong[kf]["招式"..zs] < 305 then	
			zswz1 = zswz1.."Ｇ"..(JY.Wugong[kf]["层级"]*10).."%Ｗ反击。"
		--31加格档
		elseif JY.Wugong[kf]["招式"..zs] > 310 and JY.Wugong[kf]["招式"..zs] < 315 then	
			zswz1 = zswz1.."增加格档Ｇ"..(JY.Wugong[kf]["层级"]*100).."Ｗ点。"
		--32加命中
		elseif JY.Wugong[kf]["招式"..zs] > 320 and JY.Wugong[kf]["招式"..zs] < 325 then	
			zswz1 = zswz1.."命中增加Ｇ"..(JY.Wugong[kf]["层级"]*100).."Ｗ点。"
		--33散功
		elseif JY.Wugong[kf]["招式"..zs] > 330 and JY.Wugong[kf]["招式"..zs] < 335 then	
			zswz1 = zswz1.."散功Ｇ"..(JY.Wugong[kf]["层级"]*5).."Ｗ时序。"	
		--34外伤
		elseif JY.Wugong[kf]["招式"..zs] > 340 and JY.Wugong[kf]["招式"..zs] < 345 then	
			zswz1 = zswz1.."重伤三回合，目标三围降低Ｇ"..	(5+JY.Wugong[kf]["层级"]*5).."%Ｗ。"	
		--35集气混乱
		elseif JY.Wugong[kf]["招式"..zs] > 350 and JY.Wugong[kf]["招式"..zs] < 355 then	
			zswz1 = zswz1.."集气混乱Ｇ"..(JY.Wugong[kf]["层级"]*5).."Ｗ时序。"	
		--36恐惧
		elseif JY.Wugong[kf]["招式"..zs] > 360 and JY.Wugong[kf]["招式"..zs] < 365 then	
			zswz1 = zswz1.."Ｇ"..(30+JY.Wugong[kf]["层级"]*10).."%Ｗ概率恐惧1回合。"	
		--37生命最大值伤害
		elseif JY.Wugong[kf]["招式"..zs] > 370 and JY.Wugong[kf]["招式"..zs] < 375 then	
			zswz1 = zswz1.."造成目标生命最大值Ｇ"..(1+JY.Wugong[kf]["层级"]).."%Ｗ伤害。"
		--38盲目
		elseif JY.Wugong[kf]["招式"..zs] > 380 and JY.Wugong[kf]["招式"..zs] < 385 then	
			zswz1 = zswz1.."Ｇ"..(JY.Wugong[kf]["层级"]*10).."%Ｗ概率致盲。"																												
		--39迟缓
		elseif JY.Wugong[kf]["招式"..zs] > 390 and JY.Wugong[kf]["招式"..zs] < 395 then	
			zswz1 = zswz1.."目标集气减少Ｇ"..(JY.Wugong[kf]["层级"]*3).."Ｗ点。"																												
		end
	end
	return zswz1
end

--内功说明文字
function KF_ngwz(kf,tx)
	local txwz = ""	
	local ngtx = JY.Wugong[kf]['特效'..tx]	
	local kflv = JY.Wugong[kf]["层级"]		
	local lv1 = {'壹级','貮级','叁级','肆级',}	
	local lv = lv1[kflv]	
	--local cl = RGB(188,189,171) 
	local function strcolor_switch(s)
		local Color_Switch={{"Ｒ",PinkRed},{"Ｇ",M_Wheat},{"Ｂ",C_BLACK},{"Ｗ",RGB(178,158,124)},{"Ｏ",C_ORANGE},{"Ｌ",LimeGreen},{"Ｄ",M_DeepSkyBlue},{"Ｚ",Violet}}
		for i = 1, 8 do
			if Color_Switch[i][1] == s then
				return Color_Switch[i][2]
			end
		end
	end			
			
	if ngtx > 0 then 
		------------------------------------
		------------------回复类------------------
		------------------------------------
		if ngtx >= 11 and ngtx <= 14 then 
			txwz = '◆Ｚ『时序回血◆'..lv..'』：Ｗ每3时序回复Ｄ'..kflv..'Ｗ点生命。'
		end
		if ngtx >= 15 and ngtx <= 19 then 
			local hx = kflv*100
			txwz = '◆Ｚ『回合回血◆'..lv..'』：Ｗ每回合回复Ｄ'..hx..'Ｗ点生命。'
		end
		if ngtx >= 21 and ngtx <= 24 then 
			local hn = kflv*2
			txwz = '◆Ｚ『时序回内◆'..lv..'』：Ｗ每3时序回复Ｄ'..hn..'Ｗ点内力。'
		end
		if ngtx >= 25 and ngtx <= 29 then 
			local hn = kflv*200
			txwz = '◆Ｚ『回合回内◆'..lv..'』：Ｗ每回合回复Ｄ'..hn..'Ｗ点内力。'
		end
		if ngtx >= 31 and ngtx <= 34 then 
			local hn = kflv
			txwz = '◆Ｚ『时序回体◆'..lv..'』：Ｗ每9时序回复Ｄ'..hn..'Ｗ点体力。'
		end	
		if ngtx >= 35 and ngtx <= 39 then 
			local hn = kflv
			txwz = '◆Ｚ『回合回体◆'..lv..'』：Ｗ每回合回复Ｄ'..hn..'Ｗ点体力。'
		end	
		if ngtx >= 41 and ngtx <= 44 then 
			local hn = kflv
			txwz = '◆Ｚ『时序回气◆'..lv..'』：Ｗ每50时序回复Ｄ'..hn..'Ｗ点气。'
		end	
		if ngtx >= 45 and ngtx <= 49 then 
			local hn = kflv
			txwz = '◆Ｚ『回合回气◆'..lv..'』：Ｗ每回合回复Ｄ'..hn..'Ｗ点气。'
		end	
		if ngtx >= 51 and ngtx <= 54 then 
			local hn = kflv*3
			txwz = '◆Ｚ『回春◆'..lv..'』：Ｗ每回合回复Ｄ'..hn..'%Ｗ生命。'
		end
		--回合回复百分比内力
		if ngtx >= 55 and ngtx <= 59 then 
			local hx = kflv
			txwz = '◆Ｚ『调息◆'..lv..'』：Ｗ每回合回复Ｄ'..hx..'%内力。'
		end	
		--回合回复百分比体力
		if ngtx >= 61 and ngtx <= 64 then 
			local hx = kflv
			txwz = '◆Ｚ『聚神◆'..lv..'』：Ｗ每回合回复Ｄ'..hx..'%Ｗ体力。'
		end	
		--回合回复百分比气
		if ngtx >= 65 and ngtx <= 69 then 
			local hx = kflv
			txwz = '◆Ｚ『气归◆'..lv..'』：Ｗ每回合回复Ｄ'..hx..'%Ｗ气。'
		end	
		--血内体气全回复
		if ngtx >= 71 and ngtx <= 74 then 
			local hx = kflv
			txwz = '◆Ｇ『奋怒◆'..lv..'』：Ｗ每回合回复Ｄ'..hx..'%Ｗ怒气。'
		end	
		--流血回复
		if ngtx >= 75 and ngtx <= 79 then 
			local hn = kflv
			txwz = '◆Ｚ『活血◆'..lv..'』：Ｗ每6时序回复Ｄ'..hn..'Ｗ点流血。'
		end			
		--流血回复
		if ngtx >= 81 and ngtx <= 84 then 
			local hn = kflv*5
			txwz = '◆Ｚ『包扎◆'..lv..'』：Ｗ每回合回复Ｄ'..hn..'Ｗ点流血。'
		end	
		--冰封回复
		if ngtx >= 85 and ngtx <= 89 then 
			local hn = kflv
			txwz = '◆Ｚ『复苏◆'..lv..'』：Ｗ每6时序回复Ｄ'..hn..'Ｗ点冰封。'
		end			
		--冰封回复
		if ngtx >= 91 and ngtx <= 94 then 
			local hn = kflv*5
			txwz = '◆Ｚ『阳春◆'..lv..'』：Ｗ每回合回复Ｄ'..hn..'Ｗ点冰封。'
		end			
		--点穴回复
		if ngtx >= 95 and ngtx <= 99 then 
			local hn = kflv
			txwz = '◆Ｚ『冲穴◆'..lv..'』：Ｗ每6时序回复Ｄ'..hn..'Ｗ点封穴。'
		end			
		--灼烧回复
		if ngtx >= 101 and ngtx <= 104 then 
			local hn = kflv
			txwz = '◆Ｚ『冰心◆'..lv..'』：Ｗ每6时序回复Ｄ'..hn..'Ｗ点灼烧。'
		end
		--灼烧回复
		if ngtx >= 105 and ngtx <= 109 then 
			local hn = kflv*5
			txwz = '◆Ｚ『冰敷◆'..lv..'』：Ｗ每回合回复Ｄ'..hn..'Ｗ点灼烧。'
		end	
		--中毒回复
		if ngtx >= 111 and ngtx <= 114 then 
			local hn = kflv
			txwz = '◆Ｚ『袪毒◆'..lv..'』：Ｗ每6时序回复Ｄ'..hn..'Ｗ点中毒。'
		end
		--中毒回复
		if ngtx >= 115 and ngtx <= 119 then 
			local hn = kflv*5
			txwz = '◆Ｚ『化毒◆'..lv..'』：Ｗ每回合回复Ｄ'..hn..'Ｗ点中毒。'
		end				
		--内伤回复
		if ngtx >= 121 and ngtx <= 124 then 
			local hn = kflv
			txwz = '◆Ｚ『疗伤◆'..lv..'』：Ｗ每6时序回复Ｄ'..hn..'Ｗ点内伤。'
		end	
		--内伤回复
		if ngtx >= 125 and ngtx <= 129 then 
			local hn = kflv*5
			txwz = '◆Ｚ『通脉◆'..lv..'』：Ｗ每回合回复Ｄ'..hn..'Ｗ点内伤。'
		end		
		------------------------------------
		------------------恢复类------------------	
		------------------------------------		
		--重伤恢复
		if ngtx >= 131 and ngtx <= 134 then 
			local hn = kflv*5
			txwz = '◆Ｚ『痊愈◆'..lv..'』：Ｗ每6时序Ｄ'..hn..'%Ｗ概率清除重伤，并免疫重伤Ｄ'..hn..'Ｗ时序。'
		end	
		--冻结恢复
		if ngtx >= 135 and ngtx <= 139 then 
			local hn = kflv*5
			txwz = '◆Ｚ『化冰◆'..lv..'』：Ｗ每6时序Ｄ'..hn..'%Ｗ概率清除冻结。并免疫冻结Ｄ'..hn..'Ｗ时序。'
		end	
		--虚弱恢复
		if ngtx >= 141 and ngtx <= 144 then 
			local hn = kflv*5
			txwz = '◆Ｚ『奋起◆'..lv..'』：Ｗ每6时序Ｄ'..hn..'%Ｗ概率清除虚弱。并免疫虚弱Ｄ'..hn..'Ｗ时序。'
		end		
		--封穴恢复
		if ngtx >= 145 and ngtx <= 149 then 
			local hn = kflv*5
			txwz = '◆Ｚ『移穴◆'..lv..'』：Ｗ每6时序Ｄ'..hn..'%Ｗ概率清除封穴。并免疫封穴Ｄ'..hn..'Ｗ时序。'
		end	
		--中毒恢复
		if ngtx >= 151 and ngtx <= 154 then 
			local hn = kflv*5
			txwz = '◆Ｚ『不侵◆'..lv..'』：Ｗ每6时序Ｄ'..hn..'%Ｗ概率清除中毒。并免疫中毒Ｄ'..hn..'Ｗ时序。'
		end		
		--恢复状态
		if ngtx >= 155 and ngtx <= 159 then 
			local hn = kflv*5
			txwz = '◆Ｚ『净化◆'..lv..'』：Ｗ每6时序Ｄ'..hn..'%Ｗ概率清除内伤、流血、冰封、灼烧、封穴。'
		end
		--恢复状态
		if ngtx >= 161 and ngtx <= 164 then 
			local hn = kflv*25
			txwz = '◆Ｚ『净化◆'..lv..'』：Ｗ每回合Ｄ'..hn..'%Ｗ概率清除内伤、流血、冰封、灼烧、封穴。'
		end	
		------------------------------------
		------------------常驻增益类------------------	
		------------------------------------
		--增加伤害
		if ngtx >= 165 and ngtx <= 169 then 
			local hn = kflv*5
			txwz = '◆Ｚ『勇猛◆'..lv..'』：Ｗ增加伤害Ｄ'..hn..'%Ｗ。'
		end	
		--增加连击率
		if ngtx >= 171 and ngtx <= 174 then 
			local hn = kflv*10
			txwz = '◆Ｚ『连击◆'..lv..'』：Ｗ增加连击率Ｄ'..hn..'%Ｗ。'
		end	
		--增加连击伤害
		if ngtx >= 175 and ngtx <= 179 then 
			local hn = kflv*5
			txwz = '◆Ｚ『连伤◆'..lv..'』：Ｗ增加连击伤害Ｄ'..hn..'%Ｗ。'
		end	
		--增加暴击率
		if ngtx >= 181 and ngtx <= 184 then 
			local hn = kflv*10
			txwz = '◆Ｚ『暴击◆'..lv..'』：Ｗ增加暴击率Ｄ'..hn..'%Ｗ。'
		end	
		--增加暴击伤害
		if ngtx >= 185 and ngtx <= 189 then 
			local hn = kflv*5
			txwz = '◆Ｚ『暴伤◆'..lv..'』：Ｗ增加暴击伤害Ｄ'..hn..'%Ｗ。'
		end	
		--增加攻击力
		if ngtx >= 191 and ngtx <= 194 then 
			local hn = kflv*50
			txwz = '◆Ｚ『大力◆'..lv..'』：Ｗ增加攻击力Ｄ'..hn..'Ｗ点。'
		end	
		--增加防御力
		if ngtx >= 195 and ngtx <= 199 then 
			local hn = kflv*50
			txwz = '◆Ｚ『健体◆'..lv..'』：Ｗ增加防御力Ｄ'..hn..'Ｗ点。'
		end	
		--增加轻功
		if ngtx >= 201 and ngtx <= 204 then 
			local hn = kflv*50
			txwz = '◆Ｚ『轻身◆'..lv..'』：Ｗ增加轻功Ｄ'..hn..'Ｗ点。'
		end	
		--增加气攻
		if ngtx >= 205 and ngtx <= 209 then 
			local hn = kflv*100
			txwz = '◆Ｚ『气攻◆'..lv..'』：Ｗ增加气攻Ｄ'..hn..'Ｗ点。'
		end
		--增加气防
		if ngtx >= 211 and ngtx <= 214 then 
			local hn = kflv*100
			txwz = '◆Ｚ『气防◆'..lv..'』：Ｗ增加气防Ｄ'..hn..'Ｗ点。'
		end		
		--增加怒气
		if ngtx >= 215 and ngtx <= 219 then 
			local hn = kflv
			txwz = '◆Ｚ『愤怒◆'..lv..'』：Ｗ每9时序回复Ｄ'..hn..'Ｗ点怒气。'
		end
		--增加气
		if ngtx >= 221 and ngtx <= 224 then 
			local hn = kflv
			txwz = '◆Ｚ『川流◆'..lv..'』：Ｗ行动前回复Ｄ'..hn..'Ｗ点气。'
		end
		--增加移动步数
		if ngtx >= 225 and ngtx <= 229 then 
			local hn = kflv
			txwz = '◆Ｚ『神行◆'..lv..'』：Ｗ增加移动步数Ｄ'..hn..'Ｗ。'
		end		
		--增加集气位置
		if ngtx >= 231 and ngtx <= 234 then 
			local hn = kflv*100
			txwz = '◆Ｚ『先发◆'..lv..'』：Ｗ战斗开始增加集气位置Ｄ'..hn..'Ｗ。'
		end	
		--增加集气速度
		if ngtx >= 235 and ngtx <= 239 then 
			local hn = kflv*2
			txwz = '◆Ｚ『迅捷◆'..lv..'』：Ｗ增加战斗集气速度Ｄ'..hn..'Ｗ点。'
		end
		--增加拳系武功威力
		if ngtx >= 241 and ngtx <= 244 then 
			local hn = kflv*100
			txwz = '◆Ｚ『拳罡◆'..lv..'』：Ｗ增加拳系武功威力Ｄ'..hn..'Ｗ点。'
		end
		--增加指系武功威力
		if ngtx >= 245 and ngtx <= 249 then 
			local hn = kflv*100
			txwz = '◆Ｚ『指劲◆'..lv..'』：Ｗ增加指系武功威力Ｄ'..hn..'Ｗ点。'
		end		
		--增加剑系武功威力
		if ngtx >= 251 and ngtx <= 254 then 
			local hn = kflv*100
			txwz = '◆Ｚ『剑气◆'..lv..'』：Ｗ增加剑系武功威力Ｄ'..hn..'Ｗ点。'
		end
		--增加刀系武功威力
		if ngtx >= 255 and ngtx <= 259 then 
			local hn = kflv*100
			txwz = '◆Ｚ『刀风◆'..lv..'』：Ｗ增加刀系武功威力Ｄ'..hn..'Ｗ点。'
		end
		--增加奇门武功威力
		if ngtx >= 261 and ngtx <= 264 then 
			local hn = kflv*100
			txwz = '◆Ｚ『器械◆'..lv..'』：Ｗ增加奇门武功威力Ｄ'..hn..'Ｗ点。'
		end
		--增加拳系武功威力百分比
		if ngtx >= 265 and ngtx <= 269 then 
			local hn = kflv*100
			txwz = '◆Ｚ『拳掌精通◆'..lv..'』：Ｗ增加拳系武功威力Ｄ'..hn..'%Ｗ。'
		end
		--增加指系武功威力百分比
		if ngtx >= 271 and ngtx <= 274 then 
			local hn = kflv*100
			txwz = '◆Ｚ『指腿精通◆'..lv..'』：Ｗ增加指系武功威力Ｄ'..hn..'%Ｗ。'
		end		
		--增加剑系武功威力百分比
		if ngtx >= 275 and ngtx <= 279 then 
			local hn = kflv*100
			txwz = '◆Ｚ『剑法精通◆'..lv..'』：Ｗ增加剑系武功威力Ｄ'..hn..'%Ｗ。'
		end
		--增加刀系武功威力百分比
		if ngtx >= 281 and ngtx <= 284 then 
			local hn = kflv*100
			txwz = '◆Ｚ『刀法精通◆'..lv..'』：Ｗ增加刀系武功威力Ｄ'..hn..'%Ｗ。。'
		end
		--增加奇门武功威力百分比
		if ngtx >= 285 and ngtx <= 289 then 
			local hn = kflv*100
			txwz = '◆Ｚ『奇门精通◆'..lv..'』：Ｗ增加奇门武功威力Ｄ'..hn..'%Ｗ。'
		end
		--增加破防点数
		if ngtx >= 291 and ngtx <= 294 then 
			local hn = kflv*100
			txwz = '◆Ｚ『破体◆'..lv..'』：Ｗ攻击时无视目标防御Ｄ'..hn..'Ｗ点。'
		end
		--增加破防百分比
		if ngtx >= 295 and ngtx <= 299 then 
			local hn = kflv*10
			txwz = '◆Ｚ『破甲◆'..lv..'』：Ｗ攻击时无视目标防御Ｄ'..hn..'%Ｗ。'
		end		
		--增加攻击力百分比
		if ngtx >= 301 and ngtx <= 304 then 
			local hn = kflv*10
			txwz = '◆Ｚ『神力◆'..lv..'』：Ｗ增加攻击力Ｄ'..hn..'%Ｗ。'
		end	
		--增加防御力百分比
		if ngtx >= 305 and ngtx <= 309 then 
			local hn = kflv*10
			txwz = '◆Ｚ『金汤◆'..lv..'』：Ｗ增加防御力Ｄ'..hn..'%Ｗ。'
		end	
		--增加轻功百分比
		if ngtx >= 311 and ngtx <= 314 then 
			local hn = kflv*10
			txwz = '◆Ｚ『矫健◆'..lv..'』：Ｗ增加轻功Ｄ'..hn..'%Ｗ。'
		end
		--增加三围点数
		if ngtx >= 315 and ngtx <= 319 then 
			local hn = kflv*50
			txwz = '◆Ｇ『凤雏◆'..lv..'』：Ｗ增加三围Ｄ'..hn..'点Ｗ。'
		end
		--增加三围百分比
		if ngtx >= 321 and ngtx <= 324 then 
			local hn = kflv*10
			txwz = '◆Ｇ『卧龙◆'..lv..'』：Ｗ增加三围Ｄ'..hn..'%Ｗ。'
		end
		--增加特效点数
		if ngtx >= 325 and ngtx <= 329 then 
			local hn = kflv*6
			txwz = '◆Ｇ『洛神◆'..lv..'』：Ｗ增加特效触发概率Ｄ'..hn..'%Ｗ。'
		end
		--增加暴击抗性
		if ngtx >= 331 and ngtx <= 334 then 
			local hn = kflv*100
			txwz = '◆Ｚ『防暴◆'..lv..'』：Ｗ增加抗暴点数Ｄ'..hn..'Ｗ点。'
		end		
		--增加冰封抗性
		if ngtx >= 335 and ngtx <= 339 then 
			local hn = kflv*100
			txwz = '◆Ｚ『火抗◆'..lv..'』：Ｗ增加冰封抗性Ｄ'..hn..'Ｗ点。'
		end	
		--增加灼烧抗性
		if ngtx >= 341 and ngtx <= 344 then 
			local hn = kflv*100
			txwz = '◆Ｚ『冰抗◆'..lv..'』：Ｗ增加灼烧抗性Ｄ'..hn..'Ｗ点。'
		end	
		--增加点穴抗性
		if ngtx >= 345 and ngtx <= 349 then 
			local hn = kflv*100
			txwz = '◆Ｚ『闭穴◆'..lv..'』：Ｗ增加封穴抗性Ｄ'..hn..'Ｗ点。'
		end	
		--增加流血抗性
		if ngtx >= 351 and ngtx <= 354 then 
			local hn = kflv*100
			txwz = '◆Ｚ『血抗◆'..lv..'』：Ｗ增加流血抗性Ｄ'..hn..'Ｗ点。'
		end			
		--增加中毒抗性
		if ngtx >= 355 and ngtx <= 359 then 
			local hn = kflv*100
			txwz = '◆Ｚ『毒抗◆'..lv..'』：Ｗ增加中毒抗性Ｄ'..hn..'Ｗ点。'
		end		
		
		
		-------------免疫状态---------------
		--免疫反击
		if ngtx >= 401 and ngtx <=404 then 
			local hn = kflv*25
			txwz = '◆Ｚ『免疫反伤◆'..lv..'』：Ｗ免疫反弹和反击概率Ｄ'..hn..'%Ｗ。'
		end
		--免疫流血
		if ngtx >= 405 and ngtx <=409 then 
			local hn = kflv*25
			txwz = '◆Ｚ『免疫流血◆'..lv..'』：Ｗ免疫流血概率Ｄ'..hn..'%Ｗ。'
		end
		--免疫中毒
		if ngtx >= 411 and ngtx <=414 then 
			local hn = kflv*25
			txwz = '◆Ｚ『免疫中毒◆'..lv..'』：Ｗ免疫中毒概率Ｄ'..hn..'%Ｗ。'
		end
		--免疫内伤
		if ngtx >= 415 and ngtx <=419 then 
			local hn = kflv*25
			txwz = '◆Ｚ『免疫内伤◆'..lv..'』：Ｗ免疫内伤概率Ｄ'..hn..'%Ｗ。'
		end	
		--免疫冰封
		if ngtx >= 421 and ngtx <=424 then 
			local hn = kflv*25
			txwz = '◆Ｚ『免疫冰封◆'..lv..'』：Ｗ免疫冰封概率Ｄ'..hn..'%Ｗ。'
		end	
		--免疫灼烧
		if ngtx >= 425 and ngtx <=429 then 
			local hn = kflv*25
			txwz = '◆Ｚ『免疫灼烧◆'..lv..'』：Ｗ免疫灼烧概率Ｄ'..hn..'%Ｗ。'
		end	
		--免疫虚弱
		if ngtx >= 431 and ngtx <=434 then 
			local hn = kflv*25
			txwz = '◆Ｚ『免疫虚弱◆'..lv..'』：Ｗ免疫虚弱概率Ｄ'..hn..'%Ｗ。'
		end		
		--免疫锁足
		if ngtx >= 435 and ngtx <=439 then 
			local hn = kflv*25
			txwz = '◆Ｚ『免疫锁足◆'..lv..'』：Ｗ免疫锁足和定身概率Ｄ'..hn..'%Ｗ。'
		end	
		--免疫暴击
		if ngtx >= 441 and ngtx <=444 then 
			local hn = kflv*25
			txwz = '◆Ｚ『免疫暴击◆'..lv..'』：Ｗ免疫暴击概率Ｄ'..hn..'%Ｗ。'
		end	
		--免疫必中
		if ngtx >= 445 and ngtx <=449 then 
			local hn = kflv*25
			txwz = '◆Ｚ『免疫必中◆'..lv..'』：Ｗ免疫必中概率Ｄ'..hn..'%Ｗ。'
		end	
		--免疫破绽
		if ngtx >= 451 and ngtx <=454 then 
			local hn = kflv*25
			txwz = '◆Ｚ『免疫破绽◆'..lv..'』：Ｗ免疫破绽概率Ｄ'..hn..'%Ｗ。'
		end	
		--免疫散功
		if ngtx >= 455 and ngtx <=459 then 
			local hn = kflv*25
			txwz = '◆Ｚ『免疫散功◆'..lv..'』：Ｗ免疫散功概率Ｄ'..hn..'%Ｗ。'
		end	
		--免疫杀气
		if ngtx >= 461 and ngtx <=464 then 
			local hn = kflv*25
			txwz = '◆Ｇ『天地独尊』：Ｗ免疫杀气概率Ｄ'..hn..'%Ｗ。'
		end		
		--免疫破防
		if ngtx >= 465 and ngtx <=469 then 
			local hn = kflv*25
			txwz = '◆Ｚ『免疫破防◆'..lv..'』：Ｗ免疫破防概率Ｄ'..hn..'%Ｗ。'
		end	
		--免疫缴械
		if ngtx >= 471 and ngtx <=474 then 
			local hn = kflv*25
			txwz = '◆Ｚ『免疫缴械◆'..lv..'』：Ｗ免疫缴械概率Ｄ'..hn..'%Ｗ。'
		end	
		--免疫死亡
		if ngtx >= 475 and ngtx <=479 then 
			local hn = kflv*25
			txwz = '◆Ｇ『逆水寒』：Ｗ免疫死亡Ｄ'..hn..'时序Ｗ。'
		end	
		--免疫伤害
		if ngtx >= 481 and ngtx <=484 then 
			local hn = kflv*25
			txwz = '◆Ｇ『霸体◆'..lv..'』：Ｗ免疫死亡Ｄ'..hn..'时序Ｗ。'
		end	
		--免疫冻结
		if ngtx >= 485 and ngtx <=489 then 
			local hn = kflv*25
			txwz = '◆Ｚ『免疫冻结◆'..lv..'』：Ｗ免疫冻结概率Ｄ'..hn..'%Ｗ。'
		end	
		--免疫点燃
		if ngtx >= 491 and ngtx <=494 then 
			local hn = kflv*25
			txwz = '◆Ｚ『免疫点燃◆'..lv..'』：Ｗ免疫点燃概率Ｄ'..hn..'%Ｗ。'
		end																			
		---------------------------------------------											
		-------------特殊效果--------------绝学才具备
		--------------------------------------------
		--浑天--
		if ngtx == 1001 then 
			txwz = '◆Ｇ『浑天』：Ｗ每次受到攻击，气防和防御增加1%+5点，最多增加999点。'
		end
		--血内体气全回复
		if ngtx >= 1002 then 
			local hx = kflv*2
			txwz = '◆Ｇ『普渡』：Ｗ每回合回复10%Ｗ生命、内力、体力、气。'
		end	
		--血内体气全回复
		if ngtx >= 1003 then 
			local hx = kflv*2
			txwz = '◆Ｇ『慈航』：Ｗ行动时生命、内力、体力、怒气其中之一满值，则全状态恢复。'
		end					
	end
	return txwz
end

--武功秘籍
function KF_thing(kf)
	local thingid 
	for j = 0, JY.ThingNum - 1 do  --读取物品
		if JY.Thing[j]["练出武功"] >= 0 and JY.Thing[j]["练出武功"] == kf then											
			thingid = j
			return thingid
		end	
	end
	--return thingid
end

--秘籍武功
function Thing_kf(thingid)
	local wugongid = 0
	if JY.Thing[thingid]['类型'] == 2 and JY.Thing[thingid]['练出武功'] > 0 then
		wugongid = JY.Thing[thingid]['练出武功']
	end
	return wugongid
end

--喜好设定
function Person_xihao(id)
    local n = ""
    local thingid = nil 
    local xihao = {[0]= '暂无', '酒','食物','药品','装备','暗器','拳法','指法','剑法','刀法','奇门','内功','轻功','杂学','宝物'}
    local xh 
    for i,v in ipairs(CC.AllPersonExit) do
        if v[1] == id  then
            xh = v[3]
            break
        end           
    end
    for i =1,#xihao do 
        n = xihao[xh]
    end
    return n
end



--开地图
function Opersmp()
	instruct_39(167) 	--打开
	instruct_39(166) 	--打开
	instruct_39(160) 	--打开	
	instruct_39(159) 	--打开	
	instruct_39(158) 	--打开
	instruct_39(157) 	--打开
	instruct_39(125) 	--打开
	instruct_39(156) 	--打开
	instruct_39(154) 	--打开
	instruct_39(153) 	--打开		
	instruct_39(152) 	--打开	    
	instruct_39(151) 	--打开	
	instruct_39(145) 	--打开
	instruct_39(144) 	--打开
	instruct_39(143) 	--打开
	instruct_39(142) 	--打开
	instruct_39(141) 	--打开
	instruct_39(140) 	--打开
	instruct_39(139) 	--打开
	instruct_39(138) 	--打开西夏皇宫	
	instruct_39(137) 	--打开岳王洞
	instruct_39(129) 	--打开襄阳	
	instruct_39(136) 	--打开凉州	
	instruct_39(135) 	--打开南少林			
	instruct_39(134) 	--打开六合塔			
	instruct_39(133) 	--打开杭州			
	instruct_39(127) 	--打开凤阳
	instruct_39(128) 	--打开场景衡阳
	instruct_39(25)  --打开场景
	instruct_39(120) 	--打开场景绿柳山庄
	instruct_39(112) 	--打开场景万兽山庄
	instruct_39(107)  	--打开场景北京城
	instruct_39(2)  	--打开场景雪山
	instruct_39(103)  	--打开场景药王庙
	instruct_39(101)  	--打开场景
	--instruct_39(102)  	--打开场景
	instruct_39(100)  	--打开场景
	instruct_39(98)  --打开场景
	instruct_39(97)  --打开场景
	instruct_39(96)  --打开场景
	instruct_39(95)  --打开场景
	instruct_39(94)  --打开场景
	instruct_39(99)  --打开场景
	instruct_39(92)  --打开场景
	instruct_39(83)  --打开场景
	instruct_39(82)  --打开场景
	instruct_39(81)  --打开场景
	instruct_39(80)  --打开场景
	--instruct_39(79)  --打开场景
	instruct_39(78)  --打开场景
	--instruct_39(77)  --打开场景
	instruct_39(76)  --打开场景
	instruct_39(75)  --打开场景
	instruct_39(74)  --打开场景
	instruct_39(73)  --打开场景
	instruct_39(71)  --打开场景
	instruct_39(69)  --打开场景
	instruct_39(68)  --打开场景
	instruct_39(66)  --打开场景
	instruct_39(65)  --打开场景
	instruct_39(64)  --打开场景
	instruct_39(63)  --打开场景
	instruct_39(62)  --打开场景
	instruct_39(61)  --打开场景
	instruct_39(60)  --打开场景
	instruct_39(59)  --打开场景
	instruct_39(58)  --打开场景
	instruct_39(57)  --打开场景
	instruct_39(56)  --打开场景
	instruct_39(55)  --打开场景
	instruct_39(54)  --打开场景
	instruct_39(53)  --打开场景
	instruct_39(52)  --打开场景
	instruct_39(51)  --打开场景
	instruct_39(50)  --打开场景
	instruct_39(49)  --打开场景
	instruct_39(48)  --打开场景
	instruct_39(47)  --打开场景
	instruct_39(46)  --打开场景
	--instruct_39(45)  --打开场景
	instruct_39(44)  --打开场景
	instruct_39(43)  --打开场景
	instruct_39(42)  --打开场景
	instruct_39(41)  --打开场景
	instruct_39(40)  --打开场景
	instruct_39(39)  --打开场景
	instruct_39(38)  --打开场景
	instruct_39(37)  --打开场景
	instruct_39(35)  --打开场景
	instruct_39(34)  --打开场景
	instruct_39(33)  --打开场景
	instruct_39(32)  --打开场景
	instruct_39(31)  --打开场景
	instruct_39(30)  --打开场景
	instruct_39(29)  --打开场景
	instruct_39(27)  --打开场景
	instruct_39(26)  --打开场景
	instruct_39(24)  --打开场景
	instruct_39(23)  --打开场景
	instruct_39(22)  --打开场景
	instruct_39(21)  --打开场景
	instruct_39(20)  --打开场景
	instruct_39(18)  --打开场景
	instruct_39(17)  --打开场景
	instruct_39(16)  --打开场景
	instruct_39(13)  --打开场景
	instruct_39(12)  --打开场景
	instruct_39(11)  --打开场景
	instruct_39(9)  --打开场景
	instruct_39(8)  --打开场景
	--instruct_39(7)  --打开场景
	instruct_39(6)  --打开场景
	instruct_39(3)  --打开场景
	instruct_39(2)  --打开场景
	instruct_39(1)  --打开场景
	--instruct_39(0)  --打开场景
end

--游戏商店
--1为物品ID,2为单价，3为数量，4为显示与否
function Shopmenu(menu,thingnum)
	lib.Debug("Shopmenu");
	local bx,by = CC.ScreenW/1360,CC.ScreenH/768		
	local size = CC.FontSmall2 
	local menu1 = {} 
	local color = C_WHITE1
	local newArray = {}
	--local thingnum = {}
	local gounum = {}
	local danjia = {}
	local SHUOMING = {}
	for i ,v in pairs(menu) do 
		if v ~= nil  then 
			menu1[i] = v[1]
			danjia[i] = v[2]
			SHUOMING[i] = JY.Thing[v[1]]['物品说明']
			gounum[i] = 0
		end
	end
	local w,h = lib.GetPNGXY(2,1*2)
	local x,y = (CC.ScreenW/2-w*7/8) - w/2 ,(CC.ScreenH/2 - h*9/7)
	local px,py = -1,-1
	local n,m = 0,0	
	local pgnum,numm = math.modf(#menu1/25)
	pgnum = pgnum + 1
	local lb = 25
	local tb = 1
	local tb1 = 0
	local pg = 1
	local thingid = 0
	local xx = w*13/12
	local yy = h*13/12
	local x1,y1 = lib.GetPNGXY(91,10*2)
	local tmenu1 = {}
	local tmenu2 = {}
	local tmenu3 = {}
	local tmenu4 = {}
	local tmenu5 = {}
	local tmenu6 = {}
	local goumenu = {}
	local wpnum = {}
	local zongjia = 0
	local w1,h1 = lib.GetPNGXY(91,21*2)
	local smwz = 0
	local sm = {'客官，本店商*品，一经结账*不退不换。','客官，您莫逗*小的乐子，本*店概不赊账。','客官，一次最*多可以购买*十三件商品。'}
	local size = CC.Fontsmall
	while true do
		if JY.Restart == 1 then 
			break 
		end
		Cls()
		lib.LoadPNG(91,10*2,0,0,1)
		lib.DrawStr(CC.ScreenW/2-w,h/5,'商     店',C_CYGOLD,size, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)

		if lb < #menu1 then
			lb = #menu1
		end
		if pg < pgnum then 
			lb = 25
		elseif pg == pgnum then 
			lb = #menu1 - 25*(pgnum-1) 
		end
		for j = 1,lb do 
			thingid = j + 25*(pg-1)
			if menu1[thingid] >= 0 then 
				local pic = menu1[thingid]
				lib.PicLoadCache(2, pic * 2, x+xx*(n-1),y+yy*(m-1)+h/3, 2,256)
				local x2,y2 = lib.GetPNGXY(91,70*2)
				lib.LoadPNG(91, 70*2, x+xx*(n-1)-x2/2,y+yy*(m-1)-y2/2+h/3, 1)
				if thingnum[thingid] > 1 then 
					lib.DrawStr(x+xx*(n-1)-w/2+w/10,y+yy*(m-1)-h/2+h/3,thingnum[thingid],C_CYGOLD,size*0.6, CONFIG.CurrentPath.."FONT/3.TTF",  0, 0)
				elseif thingnum[thingid] == 0 then 
					lib.LoadPNG(91, 222*2, x+xx*(n-1)-w/2,y+yy*(m-1)-h/2+h/3, 1,256)
				end
				if tb == j then 
					local x1,y1 = lib.GetPNGXY(91,50*2)
					lib.LoadPNG(91,50*2,x+xx*(n-1)-x1/2,y+yy*(m-1)-y1/2+h/3,1)				
					DrawString(CC.ScreenW/2.2-x1*2-bx*10,h-h/3,'物品名称: ',C_CYGOLD,size*0.9)
					DrawString(CC.ScreenW/2.2-x1*2+w,h-h/3,JY.Thing[menu1[thingid]]['名称'],M_DeepSkyBlue,size*0.9)
					DrawString(CC.ScreenW/2.2-x1*2+w*2,h-h/3,'       单价：',C_CYGOLD,size*0.9)
					DrawString(CC.ScreenW/2.2-x1*2+w*3+w/2,h-h/3,danjia[thingid],M_DeepSkyBlue,size*0.9)
					DrawString(CC.ScreenW/2.2-x1*2-bx*10,h,'效果： '..SHUOMING[thingid],C_RED,size*0.9)
					
				end
				n = n + 1 
				if n == 5 then 
					m = m + 1
					n = 0
				end
			end
			--lib.Debug('pg='..pg..' 时lb= '..lb..' j='..j..' 时='..JY.Thing[menu1[thingid]]['名称'])
		end
		n = 0
		m = 0

		lib.DrawStr(CC.ScreenW-x1-bx*30,CC.ScreenH-h,'存 款：'..zongjia..'/'..CC.Gold,C_WHITE,size*0.8, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)
		lib.DrawStr(CC.ScreenW-x1+w*3+w*2/3,CC.ScreenH-h,'页 数：'..pg..'/'..pgnum,C_WHITE,size*0.8, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)
		lib.Background(x1+w/10,y/10-y/15,CC.ScreenW-w/10,CC.ScreenH-h*2/3,98)
		lib.DrawStr(CC.ScreenW/2+w*4,h/5,'购 物 车',M_DeepSkyBlue,size*1.2, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)	
		lib.DrawStr(CC.ScreenW/2+w*5-w/2,h*6,'总 价：',M_DeepSkyBlue,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)	
		lib.DrawStr(CC.ScreenW-w-w/3,h*6,zongjia,C_RED,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)		
		for i = 1,#goumenu do 					
			DrawString(CC.ScreenW-w*4,h-h/3+(i)*h*4/10,JY.Thing[menu1[goumenu[i]]]['名称'],C_CYGOLD,size)
			DrawString(CC.ScreenW-w*2,h-h/3+(i)*h*4/10,gounum[goumenu[i]]/gounum[goumenu[i]],C_CYGOLD,size)
			DrawString(CC.ScreenW-w,h-h/3+(i)*h*4/10,danjia[goumenu[i]],C_CYGOLD,size)
		end
		for i = 1,2 do 
			local jzw = {"结账",'退出'}
			local cl = M_DeepSkyBlue
			if tb1 == i then 
				cl = C_RED
			end
			lib.LoadPNG(91,21*2,CC.ScreenW/2+w*5-w/2+w*(i-1)-w1/5,h*6+h/2-h1/13,1,0,100)
			lib.DrawStr(CC.ScreenW/2+w*5-w/2+w*(i-1),h*6+h/2,jzw[i],cl,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)	
		end
		local sayne = sm[1]
		local color = M_Pink
 		if smwz == 1 then 
			sayne = sm[2]
			color = C_RED
		 elseif smwz == 2 then 
			sayne = sm[3]
			color = C_RED
		end
		tjm(w/3,h-h/11,sayne,color,size*0.8,16,size)
		ShowScreen()
		lib.Delay(CC.Frame)	
		local key, ktype, mx, my = lib.GetKey();
		if key == VK_ESCAPE or ktype == 4 then 
			if smwz > 1 then 
				smwz = 0
			else
				break
			end
		elseif key == VK_RETURN or key == VK_SPACE then 
			thingid = tb + 25*(pg-1)
			if tb1 > 0 then 
				if tb1 == 1 then 
					if instruct_31(zongjia) ==false then 
						smwz = 1
					else
						CC.Gold = CC.Gold - zongjia
						for i = 1,#goumenu do 
							instruct_32(menu1[goumenu[i]],gounum[goumenu[i]])
						end
						break
					end
				elseif tb1 == 2 then 
					break
				end
			else
				if thingnum[thingid] ~= nil and thingnum[thingid] > 0 then 
					if #goumenu < 13 then 
						goumenu[#goumenu+1] = thingid
						thingnum[thingid] = thingnum[thingid] - 1
						gounum[thingid] = gounum[thingid] + 1
						if gounum[thingid] > 1 then 
							gounum[thingid]  = 1
						end
						zongjia = zongjia + danjia[thingid]
					else
						smwz = 2
					end
				end
			end
		elseif key == VK_RIGHT then
			tb = tb + 1
			if pg < pgnum then 
				if tb > lb then 
					tb = lb 
					tb1 = tb1 + 1
					if tb1 > 2 then 
						tb1 = 1
					end
				end
			else
				if tb > lb then 
					tb = lb
					tb1 = tb1 + 1
					if tb1 > 2 then 
						tb1 = 1
					end
				end
			end
		elseif key == VK_LEFT then
			if tb1 > 0 then 
				tb1 = tb1 - 1
				if tb1 < 1 then 
					tb1 = 0
					tb = lb - 1 
				end
			else
				tb = tb - 1
				if tb < 1 then 
					if pg > 1 then 
						pg = pg - 1
						tb = 25 
					else
						tb = lb 
					end
				end
			end
		elseif key == VK_DOWN or ktype == 7 then
			tb = tb + 5 
			if pg < pgnum then 
				if tb >= 25 then 
					pg = pg + 1
					tb = 1
				end
			else
				if tb  > lb then 
					tb = lb
				end
			end
		elseif key == VK_UP or ktype == 6 then 			
			if pg > 1 then 
				tb = tb - 5 
				if tb < 1 then 
					pg = pg - 1
					tb = 25
				end
			else
				if tb > 5 then 
					tb = tb - 5
					if tb < 1 then 
						tb = 1
					end
				end
			end
		else
			local pd = false
			for j = 1,lb do 
				thingid = j + 25*(pg-1)
				if mx >= x + xx*(n-1) -w/2 and mx < x + xx*(n-1) + w - w/2 and my >= y + yy*(m-1) -h/2+h/3 and my < y + yy*(m-1) + h-h/2+h/3 then 
					tb = j 
					pd = true 
					break
				end
				n = n + 1
				if n == 5 then 
					n = 0
					m = m + 1
				end
			end
			n = 0
			m = 0
			if pd == true and ktype == 3 then 
				if thingnum[thingid] ~= nil and thingnum[thingid] > 0 then 
					if #goumenu < 13 then 
						goumenu[#goumenu+1] = thingid
						thingnum[thingid] = thingnum[thingid] - 1

						gounum[thingid] = gounum[thingid] + 1
						if gounum[thingid] > 1 then 
							gounum[thingid]  = 1
						end
						zongjia = zongjia + danjia[thingid]
					else
						smwz = 2
					end
				end
			end
			local pd1 = false
			for i = 1,2 do 
				if mx >= CC.ScreenW/2+w*5-w/2+w*(i-1)-w1/5 and mx < CC.ScreenW/2+w*5-w/2+w*(i-1)-w1/5 + w1 and my >= h*6+h/2-h1/13 and my < h*6+h/2-h1/13 + h1 then 
					tb1 = i 
					pd1 = true
				end
			end
			if pd1 == true and ktype == 3 then 
				if tb1 == 1 then 
					if instruct_31(zongjia) ==false then 
						smwz = 1
					else
						CC.Gold = CC.Gold - zongjia
						for i = 1,#goumenu do 
							local thid = menu1[goumenu[i]]
							local thnum = gounum[goumenu[i]]
							local sh = nil
							instruct_32(thid,thnum)	
							local sid = nil 
							for s = 0, JY.ShopNum - 1 do
								if CC.ShopScene[s].sceneid == JY.SubScene then
									sid = s
								  --say(id,1,1)
								end
							end
							--lib.Debug('thid == '..thid)
							--lib.Debug('thnum == '..thnum)
							for s = 1, 6 do		
								local tid = JY.Shop[sid]["物品" .. s]
								--local tnum = JY.Shop[sid]["物品数量" .. s]
								if thid == tid then 
									JY.Shop[sid]["物品数量" .. s] = JY.Shop[sid]["物品数量" .. s] - thnum
									--lib.Debug('物品 '..tid..' 减少== '..thnum)
								end
							end					
						end

						break
					end
				elseif tb1 == 2 then 
					break
				end
			end
		end
	end
end

--游戏商店暂未使用
function YXshop()
	--lib.Debug("TitleSelection");
	local bx,by = CC.WX,CC.HY
	local menu = {}				
	local size = CC.FontSmall2 
	local menu1 = {} 
	local color = C_WHITE1
	local newArray = {}
	local thingnum = {}
	local gounum = {}
	local danjia = {}
	local SHUOMING = {}
	for k,v in pairs(CC.JLWP) do
	 	newArray[v] = {0,v} -- 可以赋任意值
	end
	for k,v in pairs(newArray) do
	 	table.insert(menu,k)
	end
	table.sort(menu)
	for i = 1,#menu do
		if menu[i] ~= nil and JY.Thing[menu[i]]['礼物类型'] > 0 then 
			menu1[#menu1+1] = menu[i]
			thingnum[#thingnum+1] = 99
			gounum[#gounum+1] = 0
			danjia[#danjia+1] = 10000
			SHUOMING[#SHUOMING+1] = JY.Thing[menu[i]]['物品说明']
		end
	end
	for i = 1,#menu1 do 
		if menu1[i] >= 14 and menu1[i] <= 17 then 
			danjia[i] = 30000
		end
		if menu1[i] == 27 then 
			danjia[i] = 30000
		end
	end
	local w,h = lib.GetPNGXY(2,1*2)
	local x,y = (CC.ScreenW/2-w*7/8) - w/2 ,(CC.ScreenH/2 - h*9/7)
	local px,py = -1,-1
	local n,m = 0,0	
	local pgnum,numm = math.modf(#menu1/25)
	pgnum = pgnum + 1
	local lb = 25
	local tb = 1
	local tb1 = 0
	local pg = 1
	local thingid = 0
	local xx = w*13/12
	local yy = h*13/12
	local x1,y1 = lib.GetPNGXY(91,10*2)
	local tmenu1 = {}
	local tmenu2 = {}
	local tmenu3 = {}
	local tmenu4 = {}
	local tmenu5 = {}
	local tmenu6 = {}
	local goumenu = {}
	local wpnum = {}
	local zongjia = 0
	local w1,h1 = lib.GetPNGXY(91,21*2)
	local smwz = 0
	local sm = {'客官，本店商*品，一经结账*不退不换。','客官，您莫逗*小的乐子，本*店概不赊账。','客官，一次最*多可以购买*十三件商品。'}
	local size = CC.Fontsmall
	while true do
		if JY.Restart == 1 then 
			break 
		end
		Cls()
		lib.LoadPNG(91,10*2,-1,-1,1)
		lib.DrawStr(CC.ScreenW/2-w/2,h/5,'礼 品 商 店',C_CYGOLD,size, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)

		if lb < #menu1 then
			lb = #menu1
		end
		if pg < pgnum then 
			lb = 25
		elseif pg == pgnum then 
			lb = #menu1 - 25*(pgnum-1) 
		end

		for j = 1,lb do 
			thingid = j + 25*(pg-1)
			lib.PicLoadCache(2, menu1[thingid] * 2, x+xx*(n-1),y+yy*(m-1), 2,256)
			lib.LoadPNG(91, 70*2, x+xx*(n-1),y+yy*(m-1), 2)
			lib.DrawStr(x+xx*(n-1)-w/2+w/10,y+yy*(m-1)-h/2,thingnum[thingid],C_CYGOLD,size*0.6, CONFIG.CurrentPath.."FONT/3.TTF",  0, 0)
			if tb == j then 
				lib.LoadPNG(91,50*2,x+xx*(n-1),y+yy*(m-1),2)				
				DrawString(CC.ScreenW-x1-h/3,h-h/3,'物品名称: ',C_CYGOLD,size*0.9)
				DrawString(CC.ScreenW-x1+w,h-h/3,JY.Thing[menu1[thingid]]['名称'],M_DeepSkyBlue,size*0.9)
				DrawString(CC.ScreenW-x1+w*2,h-h/3,'       单价：',C_CYGOLD,size*0.9)
				DrawString(CC.ScreenW-x1+w*3+w/2,h-h/3,danjia[thingid],M_DeepSkyBlue,size*0.9)
				DrawString(CC.ScreenW-x1-h/3,h,'效果： '..SHUOMING[thingid],C_RED,size*0.9)
			end
			n = n + 1 
			if n == 5 then 
				m = m + 1
				n = 0
			end
		end
		n = 0
		m = 0

		lib.DrawStr(CC.ScreenW-x1,h+h*5+h/2,'存 款：'..zongjia..'/'..CC.Gold,C_CYGOLD,size*0.8, CONFIG.CurrentPath.."FONT/3.TTF",  0, 0)
		lib.DrawStr(CC.ScreenW-x1+w*3+w*2/3,h+h*5+h/2,'页 数：'..pg..'/'..pgnum,C_CYGOLD,size*0.8, CONFIG.CurrentPath.."FONT/3.TTF",  0, 0)
		lib.Background(x1+w/10,y/10-y/15,CC.ScreenW-w/10,CC.ScreenH-h*2/3,98)
		lib.DrawStr(CC.ScreenW/2+w*4,h/5,'购 物 车',M_DeepSkyBlue,size*1.2, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)	
		lib.DrawStr(CC.ScreenW/2+w*5-w/2,h*6,'总 价：',M_DeepSkyBlue,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)	
		lib.DrawStr(CC.ScreenW-w-w/3,h*6,zongjia,C_RED,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)		
		for i = 1,#goumenu do 					
			DrawString(CC.ScreenW-w*4,h-h/3+(i-1)*h*4/10,JY.Thing[menu1[goumenu[i]]]['名称'],C_CYGOLD,size)
			DrawString(CC.ScreenW-w*2,h-h/3+(i-1)*h*4/10,gounum[goumenu[i]]/gounum[goumenu[i]],C_CYGOLD,size)
			DrawString(CC.ScreenW-w,h-h/3+(i-1)*h*4/10,danjia[goumenu[i]],C_CYGOLD,size)
		end
		for i = 1,2 do 
			local jzw = {"结账",'退出'}
			local cl = M_DeepSkyBlue
			if tb1 == i then 
				cl = C_RED
			end
			lib.LoadPNG(91,21*2,CC.ScreenW/2+w*5-w/2+w*(i-1)-w1/5,h*6+h/2-h1/13,1,0,100)
			lib.DrawStr(CC.ScreenW/2+w*5-w/2+w*(i-1),h*6+h/2,jzw[i],cl,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)	
		end
		local sayne = sm[1]
		local color = M_Pink
 		if smwz == 1 then 
			sayne = sm[2]
			color = C_RED
		 elseif smwz == 2 then 
			sayne = sm[3]
			color = C_RED
		end
		tjm(w/3,h-h/11,sayne,color,size*0.8,16,size)
		ShowScreen()
		lib.Delay(CC.Frame)	
		local key, ktype, mx, my = lib.GetKey();
		if key == VK_ESCAPE or ktype == 4 then 
			if smwz > 1 then 
				smwz = 0
			else
				break
			end
		elseif key == VK_RETURN or key == VK_SPACE then 
			thingid = tb + 25*(pg-1)
			if tb1 > 0 then 
				if tb1 == 1 then 
					if instruct_31(zongjia) ==false then 
						smwz = 1
					else
						CC.Gold = CC.Gold - zongjia
						for i = 1,#goumenu do 
							instruct_32(menu1[goumenu[i]],gounum[goumenu[i]])
						end
						break
					end
				elseif tb1 == 2 then 
					break
				end
			else
				if thingnum[thingid] ~= nil and thingnum[thingid] > 0 then 
					if #goumenu < 13 then 
						goumenu[#goumenu+1] = thingid
						thingnum[thingid] = thingnum[thingid] - 1
						gounum[thingid] = gounum[thingid] + 1
						if gounum[thingid] > 1 then 
							gounum[thingid]  = 1
						end
						zongjia = zongjia + danjia[thingid]
					else
						smwz = 2
					end
				end
			end
		elseif key == VK_RIGHT then
			tb = tb + 1
			if pg < pgnum then 
				if tb > lb then 
					tb = lb 
					tb1 = tb1 + 1
					if tb1 > 2 then 
						tb1 = 1
					end
				end
			else
				if tb > lb then 
					tb = lb
					tb1 = tb1 + 1
					if tb1 > 2 then 
						tb1 = 1
					end
				end
			end
		elseif key == VK_LEFT then
			if tb1 > 0 then 
				tb1 = tb1 - 1
				if tb1 < 1 then 
					tb1 = 0
					tb = lb - 1 
				end
			else
				tb = tb - 1
				if tb < 1 then 
					if pg > 1 then 
						pg = pg - 1
						tb = 25 
					else
						tb = lb 
					end
				end
			end
		elseif key == VK_DOWN or ktype == 7 then
			tb = tb + 5 
			if pg < pgnum then 
				if tb >= 25 then 
					pg = pg + 1
					tb = 1
				end
			else
				if tb  > lb then 
					tb = lb
				end
			end
		elseif key == VK_UP or ktype == 6 then 			
			if pg > 1 then 
				tb = tb - 5 
				if tb < 1 then 
					pg = pg - 1
					tb = 25
				end
			else
				if tb > 5 then 
					tb = tb - 5
					if tb < 1 then 
						tb = 1
					end
				end
			end
		else
			local pd = false
			for j = 1,lb do 
				thingid = j + 25*(pg-1)
				if mx >= x + xx*(n-1) -w/2 and mx < x + xx*(n-1) + w - w/2 and my >= y + yy*(m-1) -h/2 and my < y + yy*(m-1) + h-h/2 then 
					tb = j 
					pd = true 
					break
				end
				n = n + 1
				if n == 5 then 
					n = 0
					m = m + 1
				end
			end
			n = 0
			m = 0
			if pd == true and ktype == 3 then 
				if thingnum[thingid] ~= nil and thingnum[thingid] > 0 then 
					if #goumenu < 13 then 
						goumenu[#goumenu+1] = thingid
						thingnum[thingid] = thingnum[thingid] - 1
						gounum[thingid] = gounum[thingid] + 1
						if gounum[thingid] > 1 then 
							gounum[thingid]  = 1
						end
						zongjia = zongjia + danjia[thingid]
					else
						smwz = 2
					end
				end
			end
			local pd1 = false
			for i = 1,2 do 
				if mx >= CC.ScreenW/2+w*5-w/2+w*(i-1)-w1/5 and mx < CC.ScreenW/2+w*5-w/2+w*(i-1)-w1/5 + w1 and my >= h*6+h/2-h1/13 and my < h*6+h/2-h1/13 + h1 then 
					tb1 = i 
					pd1 = true
				end
			end
			if pd1 == true and ktype == 3 then 
				if tb1 == 1 then 
					if instruct_31(zongjia) ==false then 
						smwz = 1
					else
						CC.Gold = CC.Gold - zongjia
						for i = 1,#goumenu do 
							instruct_32(menu1[goumenu[i]],gounum[goumenu[i]])
						end
						break
					end
				elseif tb1 == 2 then 
					break
				end
			end
		end
	end
end

--周目商店
function ZmShop()
	--lib.Debug("ZmShop");
	local bx,by = CC.WX,CC.HY
	--local menu = {}				
	local size = CC.FontSmall2 
	local menu1 = {} 
	local color = C_WHITE1
	local newArray = {}
	local thingnum = {}
	local gounum = {}
	local danjia = {}
	local SHUOMING = {}
	local menu = CC.commodity
	for i = 1,#menu do
		menu1[#menu1+1] = menu[i][1]
		danjia[#danjia+1] = menu[i][2]
		thingnum[#thingnum+1] = menu[i][3]
		SHUOMING[#SHUOMING+1] = JY.Thing[menu[i][1]]['物品说明']
		gounum[#gounum+1] = 0		
	end
	
	local w,h = lib.GetPNGXY(2,1*2)
	local x,y = (CC.ScreenW/2-w*7/8) - w/2 ,(CC.ScreenH/2 - h*9/7)+CC.ScreenH/20
	local px,py = -1,-1
	local n,m = 0,0	
	local pg = 1
	local pgnum,numm = math.modf(#menu1/25)
	pgnum = pgnum + 1
	local lb = 25
	local tb = 1
	local tb1 = 0
	local pg = 1
	local thingid = 0
	local xx = w*13/12
	local yy = h*13/12
	local x1,y1 = lib.GetPNGXY(91,10*2)
	local x2,y2 = lib.GetPNGXY(91,50*2)
	local tmenu1 = {}
	local tmenu2 = {}
	local tmenu3 = {}
	local tmenu4 = {}
	local tmenu5 = {}
	local tmenu6 = {}
	local goumenu = {}
	local wpnum = {}
	local zongjia = 0
	local w1,h1 = lib.GetPNGXY(91,21*2)
	local smwz = 0
	local sm = {'客官，本店商*品，一经结账*不退不换。','客官，您莫逗*小的乐子，本*店概不赊账。','客官，一次最*多可以购买*十五件商品。'}
	local size = CC.Fontsmall
	--JY.Base['碎片'] = CC.Sp
	while true do
		if JY.Restart == 1 then 
			break 
		end
		Cls()
		lib.LoadPNG(91,10*2,0,0,1)
		lib.DrawStr(CC.ScreenW/2-w/2,h/5+h/50,'周 目 商 店',C_GOLD,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)

		if lb < #menu1 then
			lb = #menu1
		end
		if pg < pgnum then 
			lb = 25
		elseif pg == pgnum then 
			lb = #menu1 - 25*(pgnum-1) 
		end
		for j = 1,lb do 
			thingid = j + 25*(pg-1)
			lib.PicLoadCache(2, menu1[thingid] * 2, x+xx*(n-1),y+yy*(m-1), 2,256)
			lib.LoadPNG(91, 70 * 2, x+xx*(n-1),y+yy*(m-1), 2)
			lib.DrawStr(x+xx*(n-1)-w/2+w/10,y+yy*(m-1)-h/2,thingnum[thingid],C_CYGOLD,size*0.6, CONFIG.CurrentPath.."FONT/3.TTF",  0, 0)
			if tb == j then 
				
				lib.LoadPNG(91,50*2,x+xx*(n-1)-x2/2,y+yy*(m-1)-y2/2,1)				
				DrawString(CC.ScreenW-x1-h/3,h-h/3,'物品名称: ',C_CYGOLD,size*0.9)
				DrawString(CC.ScreenW-x1+w,h-h/3,JY.Thing[menu1[thingid]]['名称'],M_DeepSkyBlue,size*0.9)
				DrawString(CC.ScreenW-x1+w*2,h-h/3,'       单价：',C_CYGOLD,size*0.9)
				DrawString(CC.ScreenW-x1+w*3+w/2,h-h/3,danjia[thingid],M_DeepSkyBlue,size*0.9)
				DrawString(CC.ScreenW-x1-h/3,h,'效果： '..SHUOMING[thingid],C_RED,size*0.9)
			end
			n = n + 1 
			if n == 5 then 
				m = m + 1
				n = 0
			end
		end
		n = 0
		m = 0
		lib.DrawStr(CC.ScreenW-x1,h+h*5+h/2,'存 款：'..zongjia..'/'..JY.Base['碎片']..'(碎片)',C_CYGOLD,size*0.8, CONFIG.CurrentPath.."FONT/3.TTF",  0, 0)
		lib.DrawStr(CC.ScreenW-x1+w*3+w*2/3,h+h*5+h/2,'页数：'..pg..'/'..pgnum,C_CYGOLD,size*0.8, CONFIG.CurrentPath.."FONT/3.TTF",  0, 0)
		lib.Background(x1+w/10,y/10-y/15,CC.ScreenW-w/10,CC.ScreenH-h*2/3,98)
		lib.DrawStr(CC.ScreenW/2+w*4,h/5,'购 物 车',M_DeepSkyBlue,size*1.2, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)	
		lib.DrawStr(CC.ScreenW-w*4,h*6,'总 价：',M_DeepSkyBlue,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)	
		lib.DrawStr(CC.ScreenW-w*3,h*6,zongjia..'(碎片)',C_RED,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)		
		for i = 1,#goumenu do 					
			DrawString(CC.ScreenW-w*4,h-h/3+(i-1)*h*4/10,JY.Thing[menu1[goumenu[i]]]['名称'],C_CYGOLD,size)
			DrawString(CC.ScreenW-w*2,h-h/3+(i-1)*h*4/10,gounum[goumenu[i]]/gounum[goumenu[i]],C_CYGOLD,size)
			DrawString(CC.ScreenW-w,h-h/3+(i-1)*h*4/10,danjia[goumenu[i]],C_CYGOLD,size)
		end
		for i = 1,2 do 
			local jzw = {"结账",'退出'}
			local cl = M_DeepSkyBlue
			if tb1 == i then 
				cl = C_RED
			end
			lib.LoadPNG(91,21*2,CC.ScreenW/2+w*5-w/2+w*(i-1)-w1/5,h*6+h/2-h1/13,1,0,100)
			lib.DrawStr(CC.ScreenW/2+w*5-w/2+w*(i-1),h*6+h/2,jzw[i],cl,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)	
		end
		local sayne = sm[1]
		local color = M_Pink
 		if smwz == 1 then 
			sayne = sm[2]
			color = C_RED
		 elseif smwz == 2 then 
			sayne = sm[3]
			color = C_RED
		end
		tjm(w/3,h-h/11,sayne,color,size*0.8,16,size)
		ShowScreen()
		lib.Delay(CC.Frame)	
		local key, ktype, mx, my = lib.GetKey();
		if key == VK_ESCAPE or ktype == 4 then 
			if smwz > 1 then 
				smwz = 0
			else
				break
			end
		elseif key == VK_RETURN or key == VK_SPACE then 
			if tb1 > 0 then 
				if tb1 == 1 then 
					if instruct_31(zongjia) ==false then 
						smwz = 1
					else
						JY.Base['碎片'] = JY.Base['碎片'] - zongjia
						CC.Sp = JY.Base["碎片"]
						for i = 1,#goumenu do 
							instruct_32(menu1[goumenu[i]],gounum[goumenu[i]])
						end
						break
					end
				elseif tb1 == 2 then 
					break
				end
			else
				thingid = tb + 25*(pg-1)
                if thingnum[thingid] > 0 then 					
                    if #goumenu < 13  then                         
                        goumenu[#goumenu+1] = thingid
                        thingnum[thingid] = thingnum[thingid] - 1
                        gounum[thingid] = gounum[thingid] + 1
                        if gounum[thingid] > 1 then 
                            gounum[thingid]  = 1
                        end
                        zongjia = zongjia + danjia[thingid]
                    else
                        smwz = 2
                    end
                end
			end
		elseif key == VK_RIGHT then
			tb = tb + 1
			if pg < pgnum then 
				if tb > lb then 
					tb = lb 
					tb1 = tb1 + 1
					if tb1 > 2 then 
						tb1 = 1
					end
				end
			else
				if tb > lb then 
					tb = lb
					tb1 = tb1 + 1
					if tb1 > 2 then 
						tb1 = 1
					end
				end
			end
		elseif key == VK_LEFT then
			if tb1 > 0 then 
				tb1 = tb1 - 1
				if tb1 < 1 then 
					tb1 = 0
					tb = lb - 1 
				end
			else
				tb = tb - 1
				if tb < 1 then 
					if pg > 1 then 
						pg = pg - 1
						tb = 25 
					else
						tb = lb 
					end
				end
			end
		elseif key == VK_DOWN or ktype == 7 then
			tb = tb + 5 
			if pg < pgnum then 
				if tb >= 25 then 
					pg = pg + 1
					tb = 1
				end
			else
				if tb  > lb then 
					tb = lb
				end
			end
		elseif key == VK_UP or ktype == 6 then 			
			if pg > 1 then 
				tb = tb - 5 
				if tb < 1 then 
					pg = pg - 1
					tb = 25
				end
			else
				if tb > 5 then 
					tb = tb - 5
					if tb < 1 then 
						tb = 1
					end
				end
			end
		else
			local pd = false
			for j = 1,lb do 
				thingid = j + 25*(pg-1)
				if mx >= x + xx*(n-1) -w/2 and mx < x + xx*(n-1) + w - w/2 and my >= y + yy*(m-1) -h/2 and my < y + yy*(m-1) + h-h/2 then 
					if thingnum[thingid] > 0 then 
						tb = j 
						pd = true 
						break
					end
				end
				n = n + 1
				if n == 5 then 
					n = 0
					m = m + 1
				end
			end
			n = 0
			m = 0
			if pd == true and ktype == 3 then 
				if thingnum[thingid] ~= nil  then 
					if #goumenu < 13 then 
						goumenu[#goumenu+1] = thingid
						thingnum[thingid] = thingnum[thingid] - 1
						gounum[thingid] = gounum[thingid] + 1
						zongjia = zongjia + danjia[thingid]
					else
						smwz = 2
					end
				end
			end
			local pd1 = false
			for i = 1,2 do 
				if mx >= CC.ScreenW/2+w*5-w/2+w*(i-1)-w1/5 and mx < CC.ScreenW/2+w*5-w/2+w*(i-1)-w1/5 + w1 and my >= h*6+h/2-h1/13 and my < h*6+h/2-h1/13 + h1 then 
					tb1 = i 
					pd1 = true
				end
			end
			if pd1 == true and ktype == 3 then 
				if tb1 == 1 then 
					if JY.Base['碎片'] - zongjia < 0 then 
						smwz = 1
					else						
						JY.Base['碎片'] = JY.Base['碎片'] - zongjia 
						--CC.Sp = JY.Base['碎片']
						for i = 1,#goumenu do 
							instruct_32(menu1[goumenu[i]],gounum[goumenu[i]])
						end
						break
					end
				elseif tb1 == 2 then 
					break
				end
			end
		end
	end
end

--简易信息
function LGJYXX()
	--银两
	local bx,by = CC.WX,CC.HY 
	local size = CC.FontSmall2
	local yl = CC.Gold
	--天书
	local ts = JY.Base["天书数量"]..'本'
	
	--难度
	local tnd = MODEXZ2[JY.Base["难度"]]	
	--单通
	local yxms
	if JY.Base["单通"] == 0 then
		yxms = "普通"
	elseif JY.Base["单通"]==1 then
		yxms = "单通"
	else
		yxms = "娱乐"
	end	
	local yxzm = JY.Base['周目']
	local dd = JY.Person[0]['品德']
	local menu = {yl,ts,dd,yxms,tnd,yxzm}
	local menu1 = {'金钱：','天书：','道德:','模式:','难度:','周目:'}
	while true do
		local x = CC.ScreenW;
		local y = CC.ScreenH;
		lib.Background(0,y-y/20,x,y,98)
		local tx,ty = CC.ScreenW/21.5873,CC.ScreenH/2.96525
		local yh = CC.ScreenH/10.9714
		for i = 1,#menu do 
			DrawString(tx+size*2+(i-1)*size*8,y-y/25,menu[i],C_WHITE,size)
			lib.DrawStr(tx-size+(i-1)*size*8,y-y/25,menu1[i], C_GOLD,size, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)
		end	
		ShowScreen()
		lib.Delay(CC.Frame)
		local key, ktype, mx, my = lib.GetKey();
		if key == VK_ESCAPE or ktype == 4 then 
			return 0
		end
	end
end

--武功内力属性
function WGns(wgid)
	local r= 0
	local thid = nil
	for j = 0, JY.ThingNum - 1 do
		if JY.Thing[j]["练出武功"] == wgid then				
			r = JY.Thing[j]["需内力性质"] 
			break
		end		
	end
	return r;
end

--筛选表格 随机排序
function RandFetch(list,num,poolSize,pool) -- list 存放筛选结果，num 筛取个数，poolSize 筛取源大小，pool 筛取源
    pool = pool or {}
    math.randomseed( tonumber(tostring(os.time()):reverse():sub(1,6)))
    for i=1,num do
        local rand = math.random(i,poolSize)
        local tmp = pool[rand] or rand -- 对于第二个池子，序号跟id号是一致的
        pool[rand] = pool[i] or i
        pool[i] = tmp
        table.insert(list, tmp)
    end
end

--设置天赋，n == 1表示有，nil表示无
--新增天赋用表存起来
--判断人物是否已经有此天赋
function PersonTF(id,tf)
	for i = 1,5 do 
		if JY.Person[id]['天赋'..i] > 0 then 
			if JY.Person[id]['天赋'..i] == tf then 
				return true
			end
		elseif JY.Person[id]['天赋'..i] <= 0 then
			return false
		end
	end
end

--老顾天气
function LGWeather()
	--lib.Debug('LGWeather')
	local bx,by = CC.WX,CC.HY
	local size = CC.FontSmall2
	while true do 
		Cls()
		if JY.Restart == 1 then
			break
		end	
		ShowStatus()
		local str = CC.Weather[CC.weat][4] 
		lib.LoadPNG(91,37*2,CC.ScreenW/3.7777,0,1,0,CC.ScreenH/5.4857)
		tjm(CC.ScreenW/3.6266,CC.ScreenH/76.8,str,C_BLACK,size*0.85,8,size*0.85)  
		ShowScreen()
		lib.Delay(CC.Frame)
		local key, ktype, mx, my = lib.GetKey();
		if key == VK_ESCAPE or ktype == 4 then 
			return 0
		end
	end
	--lib.Debug('LGWeather')
end

--天赋
function SetPersonTF()
	local switch = '(效果已打开)'
	if CC.TX['战斗天气'] == 1 then
		switch = '(效果已关闭)'
	end 
    CC.Weather = {}	
	CC.Weather[1] = {0,"下雨",294,"下雨天伤口难以愈合。移动减-1步，攻击力-5%，无法点燃，封穴效果减半，流血效果翻倍。*".."Ｒ"..switch}	
	CC.Weather[2] = {0,"下雪",295,"下雪天行动缓慢。集气-3，轻功-5%，灼烧和点燃效果减半，冻结和冰冻效果翻倍。*".."Ｒ"..switch}	
	CC.Weather[3] = {0,"大雾",296,"有雾天人物视野受限。命中-10%。防御-5%，流血交果减半，封穴效果加倍。*".."Ｒ"..switch}
	CC.Weather[4] = {0,"晴朗",297,"晴天干燥异常，小心火烛。闪避-10%，冻结时序减半，冰封效果减半，灼烧和点燃效果翻倍。*".."Ｒ"..switch}
	CC.WeatherCD = 0
	CC.weat = 0
	--时间
    CC.Daytime = 0
	CC.Miao = 0
	CC.Shichen = 4	
	CC.Day = 1
	CC.Year = 1	
	CC.Month = 1
	--人物新增天赋储存
	CC.SetTF_add = {}
	for i = 1,999  do 
		CC.SetTF_add[i] = {}
	end
	CC.Teji_kf = {}
	for i = 1,99 do 
		CC.Teji_kf[i] = {}
	end

	CC.PTFSM = {}
	--表3为2时是专属天赋。表4为1时人物天赋，表4为2时是门派天赋
    CC.PTFSM[9999] ={'仁阳佛光','内力上限9999，可使用九阳神功攻击',1,1,3}
    CC.PTFSM[9998] ={'天域幻音','行动结束时友方行动结束清除流血、中毒、冰封、灼烧、内伤并回复最多200点生命值',1,1,3}
    CC.PTFSM[9997] ={'华山掌门','五岳剑诀自动运功，华山派武功可随意修炼。',1,1,3} 
    CC.PTFSM[9996] ={'闪电惊虹','初始集气值1000，每次攻击后自身集气+200。',1,1,3}
    CC.PTFSM[9995] ={'菩提金身','受到的连击伤害降低20%，受到暴击伤害减少20%',1,1,3}
    CC.PTFSM[9994] ={'无量禅震','使用伏魔杖法必定暴击，攻击如被闪避则追加一次攻击，伏魔伏法必暴击，追加内伤，并追加内伤值伤害。',1,1,4}
    CC.PTFSM[9993] ={'佛门无双','少林寺所有武功威力+300。',1,1,3}
    CC.PTFSM[9992] ={'圣火明尊','攻击必灼烧，灼烧大于25点必点燃。点燃后会造成小范围伤害',1,1,3}
    CC.PTFSM[9991] ={'魔道天行','我方全体攻击伤害×120％，敌方全体攻击伤害×90％。',1,1,3}
	CC.PTFSM[9990] = {'运转乾坤','乾坤大挪移反弹效果 强化至反弹40%伤害（无需运功），乾坤大挪移可同时反弹给两个人。 学会乾坤后，被攻击时，有（35+天书数）%的几率触发【逆转乾坤】，A.在两格范围内对敌方的攻击落点进行挪移（消耗300点内力），B.按ESC键取消挪移，本次被攻击必定发动乾坤反弹50%伤害（无需运功），触发『逆转乾坤』后，敌方的误伤伤害将大幅提高，怒气值100时，『逆转乾坤』触发几率提升10%。',2,1,3}
    CC.PTFSM[9989] ={'傲世神罡','攻击必暴击，拳掌武功必破防30%。',1,1,4}
    CC.PTFSM[9988] ={'玉面孟尝','战场上我方女性角色越多其伤害效果越高。',2,1,2} 
    CC.PTFSM[9987] ={'博通百家','修炼所有武功需求-20，修炼武功无视内力阴阳属性，命中值+200，格档值+200,闪避值+200。',1,1,4}
    CC.PTFSM[9986] ={'天佛降世','战斗中可以复活一次，复活后免疫内伤，免疫暴击伤害。',2,1,4}
    CC.PTFSM[9985] ={'诸行无常','可使用内功攻击，武功范围+1。',1,1,3}
    CC.PTFSM[9984] ={'诸法无我','每行动一次，自身伤害+5%,受到的伤害-5%。(上限30%)',1,1,3}
    CC.PTFSM[9983] ={'悲天佛怜','般若掌攻击范围变为点，威力翻倍。生命值低于50%时拥有绝对气防',1,1,3}
    CC.PTFSM[9982] ={'无我无剑','被攻击前先手反击，独孤求败先手反击后概率打断对方攻击。',2,1,4}
    CC.PTFSM[9981] ={'扑朔迷离','与主角同时在场时，主角集气速度增加2点，战斗开始后的前三次被攻击不受伤害（需主角7书觉醒后）。',1,1,3} 
    CC.PTFSM[9980] ={'无妄无我','每修炼一个武功练到极，伤害增加2%，受伤害降低2%',1,1,3}
    CC.PTFSM[9979] ={'九字真言','行动前概率触发九字真言其中的一种或多种，随天书跟实战的增加而增加触发最大数量*临-「不动根本印」：减伤50点*兵-「大金刚轮印」：破防40%*斗-「外狮子印」：气攻提升800*者-「内狮子印」：气防提升800*列-「外缚印」：击中移动减3*阵-「内缚印」：击中目标内力-200*在-「日轮印」：攻击必灼烧*前-「宝瓶印」：攻击范围扩大*皆-「智拳印」：必击中破绽。',2,1,4}
    CC.PTFSM[9978] ={'大唐双龙.冰','免疫冰封，攻击必冰封',2,1,3}
    CC.PTFSM[9977] ={'剑法无极','剑法攻击时无视目标10%防御，每学会一门剑法至极，剑法破防效果增加2％',1,1,4}
    CC.PTFSM[9976] ={'神游太虚','免疫正面90°角攻击，正面两侧30%概率免疫，暴怒时必定免疫；移动时有独立动画',2,1,4}
    CC.PTFSM[9975] ={'剑魔再临','剑法攻击时50%概率发动两种特效之一：天极剑渊：破防50%；破尽天下：无视气防，气攻增加800',1,1,4}
    CC.PTFSM[9974] ={'九剑真传','独孤九剑攻击时50%概率（独孤100%独发，令独冲觉醒100%触发）发动四种特效，荡剑式：集气+200，撩剑式：伤害+30%，倒剑式：强制杀气150，离剑式：伤害不随距离递减;被攻击时发动破X式，减少受到的伤害20%，攻击方下回合集气位置-200',1,1,4}
    CC.PTFSM[9973] ={'其疾如风','概率发动，攻击时发动后已方集气位置+100，自身集气位置+300',1,1,3}
    CC.PTFSM[9972] ={'侵略如火','概率发动，攻击气攻增加1000，必破气防。',1,1,3}
    CC.PTFSM[9971] ={'不动如山','概率发动，被攻击只受到伤害30点',1,1,3}
    CC.PTFSM[9970] ={'其徐如林','概率发动，被攻击增加自身集气，最多增加20点',1,1,3}
    CC.PTFSM[9969] ={'冠绝江左','敌方每5点冰封值减少攻击伤害1%,自带特技“麒麟不动”：每本天书可以幻化敌方的一门武功,进战100点封值，100点灼烧值，每次行动后自身增加10点冰封值，5点灼烧值,当冰封值与灼烧值为0时“火寒毒发作，”发动“偷天换日”：恢复生命/内力到最大值，冰封值增加100，灼烧值增加50，其它状态清零。每100时序发动一次。',2,1,4}
    CC.PTFSM[9968] ={'决胜千里','每回合50％几率触发，敌方集气-150，本方集气+150。',1,1,3}
    CC.PTFSM[9967] ={'绵里针','被攻击时20%几率通过四两拨千斤化解，并用暗器反击敌人。',1,1,3} 
    CC.PTFSM[9966] ={'氤氲紫气','受到的气攻与伤害减少30%，免疫连击。',2,1,4}
    CC.PTFSM[9965] ={'酒神八杯','羊脂白玉杯：此杯极为珍贵，可卖出2万两*犀角杯：战场中每次喝酒集气增加4点，下回合集气位置提升*古藤杯：战斗结束随机获得一颗（灵芝、地灵外）的药*青铜爵：战斗结束随机获得一坛酒*夜光杯：连击率大幅度降低，暴怒必定连击*琉璃杯：5%概率触发“酒神迷踪步”闪避，喝酒后概率增加30%*古瓷杯：被攻击时免疫破绽，暴怒必中破绽；攻击时无法出破绽，暴怒必中破绽*翡翠杯：免疫冰封灼烧',2,1,4}
    CC.PTFSM[9964] ={'飞云回转刀','8把飞刀在自身8x8格范围内随机移动，飞刀1x1范围内的敌方时序10点生命损失，飞刀重叠位置时序20点生命损失*Ｇ【BOSS状态】Ｗ同时存在16把飞刀',2,1,4}
    CC.PTFSM[9963] ={'一苇渡江','一苇渡江轻功自动运功。',2,1,3}
    CC.PTFSM[9962] ={'长风万里','移动距离增加2格,免疫锁足',1,1,2} 
    CC.PTFSM[9961] ={'金蛇缠丝手','攻击时30%造成锁足*Ｇ【BOSS状态】Ｗ每间隔30时序，将随机一名敌方目标拉至自身3x3范围内随机位置锁足',2,1,3}
	CC.PTFSM[9960] ={'拳法精通','拳拳威力+100，增加自身10%拳掌功夫的攻击力和防防御力。',1,1,2}
	CC.PTFSM[9959] ={'指法精通','指法威力+100，增加自身10%指法技巧的攻击力和防防御力。',1,1,2}
	CC.PTFSM[9958] ={'剑法精通','剑法威力+100，增加自身10%御剑能力的攻击力和防防御力。',1,1,2}
	CC.PTFSM[9957] ={'刀法精通','刀法威力+100，增加自身10%耍刀技巧的攻击力和防防御力。',1,1,2}
	CC.PTFSM[9956] ={'奇门精通','奇门威力+100，增加自身10%特殊兵器的攻击力和防防御力。',1,1,2}
	CC.PTFSM[9955] ={'神拳无敌','拳拳威力+200，增加自身20%拳掌功夫的攻击力和防防御力。',1,1,4}
	CC.PTFSM[9954] ={'千手神通','指法威力+200，增加自身20%指法技巧的攻击力和防防御力。',1,1,4}
	CC.PTFSM[9953] ={'剑术通神','剑法威力+200，增加自身20%御剑能力的攻击力和防防御力。',1,1,4}
	CC.PTFSM[9952] ={'傲世狂刀','刀法威力+200，增加自身20%耍刀技巧的攻击力和防防御力。',1,1,4}
	CC.PTFSM[9951] ={'奇门无双','奇门威力+200，增加自身40%特殊兵器的攻击力和防防御力。',1,1,4}
	CC.PTFSM[9950] ={'越战越勇','增加伤害和减少受到的伤害，气血越少增加的的越多。最少15%，最多减伤35%',1,1,3}
	CC.PTFSM[9949] ={'入魔','暴怒时有一定概率进入入魔状态，免疫封穴杀气，吸血20%（上限200）。且必连击概率三连击。暴怒结束入魔结束。',2,1,3}
	CC.PTFSM[9948] ={'傲寒六诀','使用刀法时周身10格范围敌人冰封20点，概率触发傲寒六诀冻结10时序，被敌人攻击概率冻结敌人。',2,1,4}		
	CC.PTFSM[9947] ={'化气成兵','每学一门内功，自身五系兵器值增加20点。',2,1,3}
	CC.PTFSM[9946] ={'浩然罡气','被动效果：每修炼一个内功气防+100，气攻+100。气攻10%转化为伤害。暴怒必破气防。主动效果：受到攻击概率发动"浩然罡气护体",减少受到的伤害与气攻（气防决定减少的数值）。内功攻击概率发动"浩然罡气"对目标追加部分气攻值的伤害，暴怒追加的伤害增加。',2,1,3}
	CC.PTFSM[9945] ={'御气纵横','时序触发攻击',2,1,4}
	CC.PTFSM[9944] ={'流云飞袖','被攻击30%概率招架，且进行反击，伤害为100%，不可与斗转同时触发。',2,1,3}	
	CC.PTFSM[9943] ={'玉堂飞燕','攻击附带轻功值2倍的杀气值，被攻击附带轻功值2倍的气防值，使用夫妻刀法攻击附加（轻功值/2）的固定伤害。',1,1,2} 
	CC.PTFSM[9942] ={'听声辩位','命中率+500。',1,1,3}			
	CC.PTFSM[9941] ={'剑神','进战集气位置1000,每个剑法到极减少伤害3%,每个剑法到极增加伤害3%。',1,1,4}
	CC.PTFSM[9940] ={'五蕴皆空','BOSS状态时：亦复如是：Ｗ被攻击时概率触发，把受到的伤害完全反弹给攻击方（包括暗器）。*受想行识：Ｗ行动前概率触发，敌方会随机获得DEBUFF。',2,1,4}			
	CC.PTFSM[9939] ={'毗婆舍那','达摩受到攻击不会产生怒气，但每时序增加1点怒气。,*攻击会减少目标的最大生命值。每攻击一次减少2%,*达摩每回合行动前内力、体力、怒气，生命只要其中一项恢复到满状态，生命、内力、体力随机一项恢复到满状态。',2,1,4}			
	CC.PTFSM[9938] ={'亦正亦邪','道德高于59，攻击效果提高20%；道德低于61，防御效果提高20% ',1,1,3} 
	CC.PTFSM[9937] ={'八卦洞玄','八卦刀法与八卦游身掌攻击后蓄力，威力+200。',1,1,2} 
	CC.PTFSM[9936] ={'丐帮帮主','学习打狗棒法与降龙十八掌无视内属与系数条件。',1,1,3} 
	CC.PTFSM[9935] ={'黯然销魂','资质大于30，触发黯然极意必出三叠浪，资质小等于30，触发黯然极意必定连击 ',1,1,3} 
	CC.PTFSM[9934] ={'连云七略','20%概率免疫爆击、连击时受到的伤害，50%概率反弹DEBUFF,每次反弹集气位置前进200。每次反弹50%概率增加一次连击次数，最多可增加3次,主动攻击后清除，每反弹三次必反弹全部伤害。',2,1,4} 
	CC.PTFSM[9933] ={'逆水寒','血量高于50%自身攻击伤害增加（实战/10）%，受到的伤害增加（20-（实战/50））%。血量低于50%自身攻击伤害减少（20-（实战/50））%，受到的伤害减少（实战/10）%。受到的单次伤害不会高于自身生命最大值的50%。生命低于50%，受到的单次伤害不过高于生命最大值25%。受到致命伤害时免疫本次伤害并立即行动且行动后回复10%生命。每5回合触发一次。',2,1,4} 
	CC.PTFSM[9932] ={'般若无相','蓄力状态下被攻击集气位置+100。',1,1,2} 
	CC.PTFSM[9931] ={'十龙十象','行劝前概率触发十龙十象，并使下一次的攻击附加昏迷效果。',2,1,4} 
	CC.PTFSM[9930] ={'黑级浮屠','战场三围属性提升60%，被攻击时40%几率完全免疫杀气和内伤。',2,1,4} 
	CC.PTFSM[9929] ={'万寿道藏','黄赏天赋内功是九阴真经自动运功*攻击时触发"天之道"附加目标生命最大值5%的伤害*九阴神爪极意必两连，40%机率三连，暴怒必三连。',2,1,4}	
	CC.PTFSM[9928] ={'易经洗髓','修炼武功获得双倍三围属性系数，主运易筋经提升武功威力，效果为250+天书数量X50',2,1,4}	
	CC.PTFSM[9927] ={'白首太玄','人物升级时按100点资质获得属性*太玄经主运时攻击防御敌我护甲都按30%计算',2,1,4}	
	CC.PTFSM[9926] ={'老汉推车','行动后扣除5点体力*回复25%损失内力',1,1,2}	
	CC.PTFSM[9925] ={'仁者无敌','特效机率二次判定，道德高于100时，免疫暴击、连击伤害',2,1,4}
	CC.PTFSM[9924] ={'冰肌玉骨','被攻击伤害减半。',1,1,3}	 
	CC.PTFSM[9923] ={'甘霖惠七省','行动结束时回复我方全体最多5%生命（最多100点生命值）',1,1,2}		
	CC.PTFSM[9922] ={'商家堡主','使用八卦掌后八卦刀追加300伤害*使用八卦刀后八卦掌必定三连',1,1,3}		
	CC.PTFSM[9921] ={'隔壁大王','八卦刀威力1.5倍，受到攻击后30%几率用八卦刀反击',1,1,3}		
	CC.PTFSM[9920] ={'隔壁二王','八卦掌威力1.5倍，受到攻击后30%几率用八卦掌反击',1,1,3}		
	CC.PTFSM[9919] ={'最强发型师','大剪刀威力提高567，追加567点气攻',1,1,3}		
	CC.PTFSM[9918] ={'以气运剪','使用大剪刀对目标追加部分气攻值的伤害',2,1,3}		
	CC.PTFSM[9917] ={'武当七侠','使用太极拳或太极剑攻击后自动进入防御状态。',2,1,2}		
	CC.PTFSM[9916] ={'三才归元','如果格档，免疫伤害并进行反击。',2,1,4}	
	CC.PTFSM[9915] ={'满洲勇士','满洲摔跤威力翻倍，概率使敌人无法移动一回合',1,1,3}		
	CC.PTFSM[9914] ={'韦陀双鹤','使用韦陀掌几率触发“鹤啸九天”*周身六格内目标概率混乱，被击的目标击集气位置倒退300',1,1,3}		
	CC.PTFSM[9913] ={'婆罗双树','被攻击概率吸收80%伤害，附加在下回合攻击中，攻击时概率吸收伤害的80%为自身增加护盾。爆怒后触发【金毗罗陀】清除范围所有敌人身上的怒气。',2,1,4}
	CC.PTFSM[9912] ={'幻阴魔相','攻击时50%概率使七格内敌人获集气混乱5时序。',1,1,3}
	CC.PTFSM[9911] ={'风中之神','轻功成长加倍，装备附加的轻功和集气加成双倍。',1,1,3}
	CC.PTFSM[9910] ={'精忠报国','生命低于50%减伤15%，生命低于25%减伤30%。',1,1,3}
	CC.PTFSM[9909] ={'千秋侠烈','生命值低于50%伤害1.25倍，低于25%伤害1.5倍。',1,1,3}
	CC.PTFSM[9908] ={'意假情真','暴怒后攻击怒气值概率只减少10~40。',1,1,3}
	CC.PTFSM[9907] ={'白驹过隙','15%概率闪避攻击并反击，生命越低，闪避率越高，最高35%闪避率。',1,1,4}
	CC.PTFSM[9906] ={'芙蓉金针','攻击附带暗器系数的真实伤害。',1,1,2}
	CC.PTFSM[9905] ={'水润珠华','误伤队友时恢复其血量。',1,1,2}
	CC.PTFSM[9904] ={'七心海棠','攻击时敌方全体中毒20点，给已方全体随机上一种药品BUFF。',1,1,3}
	CC.PTFSM[9903] ={'赤心连城','如本次攻击造成伤害低于150，则追加一次连击（一轮追加上限3次）。',1,1,3}
	CC.PTFSM[9902] ={'星宿老仙','连环腐尸毒必出极意，引爆目标身上毒素。',1,1,3}
	CC.PTFSM[9901] ={'三笑销魂散','回合结束时按中毒量扣除敌方生命。',1,1,2}
	CC.PTFSM[9900] ={'武中无相','无视限制条件修炼武学秘籍。',2,1,3}
	CC.PTFSM[9899] ={'御法绝尘','在场时，敌方非必触发特效触发概率下降5点，我方特效概率提升5点。',2,1,3}
	CC.PTFSM[9898] ={'南四奇','南四奇在场时，我方格挡和命中率提升400。',1,1,3}
	CC.PTFSM[9897] ={'少林掌门','无视限制条件修炼少林寺武学。',2,1,3} 
	CC.PTFSM[9896] ={'天南柱石','一灯在场，由一灯承担自身所受伤的一半。 ',1,1,2}
	CC.PTFSM[9895] ={'铁血大旗','修炼铁剑铁掌到极，三围各增加100。',1,1,3} 
	CC.PTFSM[9894] ={'罗汉伏魔','学有罗汉伏魔功，攻击时必出【罗汉伏魔】特效，效果增强10% ',1,1,2}
	CC.PTFSM[9893] ={'六脉玄机','使用六脉神剑触发四招绝招，几率随实战的增加每100实战增加5％ ',2,1,3}
	CC.PTFSM[9892] ={'绝处逢生','自身范围内一格15%概率免受攻击。',1,1,3}
	CC.PTFSM[9891] ={'松风剑神','华山觉醒后松风剑法威力翻倍，必连击，必暴击。',1,1,2}
	CC.PTFSM[9890] = {'潇湘夜雨','剑法攻击范围+1，攻击时机率发动【笑傲江湖曲】追加气攻。 ',2,1,3}
	CC.PTFSM[9889] ={'杀人名医','每击退一名敌人集气速度+3点、医疗能力+50（最多5个有效）。',1,1,3}
	CC.PTFSM[9888] ={'辟邪剑客','使用辟邪剑法招式无消耗。 ',1,1,2}
	CC.PTFSM[9887] ={'血海飘香','根据本轮造成的伤害提高下一轮的集气位置，上限400 ',1,1,3}
	CC.PTFSM[9886] ={'曼珠沙华','每击退一个敌方，自身气攻气防提高200点',1,1,2}
	CC.PTFSM[9885] ={'千年冰蚕','冰蚕毒掌随机附加1~3层“冰冻状态”，每层减缓1%集气速度，上限50层 ',1,1,3}
	CC.PTFSM[9884] ={'冰毒怪客','攻击时，如敌方身上的冰封大于50，则有60%几率将其冻结10时序 ',1,1,3}
	CC.PTFSM[9883] ={'福缘深厚','攻击时50%几率触发【福泽加护】，下回合集气+200 ',1,1,3}
	CC.PTFSM[9882] ={'离合参商','斗转星移发动几率100%，反击时无视兵器值需求必定发动离合参商 ',1,1,3}
	CC.PTFSM[9881] ={'六脉真传','使用六脉神剑时概率出绝招概率+20%，六脉神剑耗内降低50%（与天赋外功效果叠加，降低75%内力消耗） ',1,1,3}
	CC.PTFSM[9880] ={'一空到底','暴怒时使用掌法攻击使敌我双方集气倒退10时序 ',1,1,3}
	CC.PTFSM[9879] ={'毓秀灵姝','攻击时必定造成流血 ',1,1,1}
	CC.PTFSM[9878] ={'血海魅影','击杀敌方后，被击杀者满状态复活，行动后获得魅惑状态9999时序。',1,1,3}
	CC.PTFSM[9877] ={'魔神降临','每三回合进入魔神降临状态50时序，怒气值不减少。',1,1,3}
	CC.PTFSM[9876] ={'梦幻星辰','斗转反击时，无视兵器值需求必定发动离合参商反击两次。 ',1,1,3}
	CC.PTFSM[9875] ={'放下屠刀','攻击时30%的概率触发【放下屠刀】降低目标伤害30%，持续一回合，无法叠加 ',1,1,3} 
	CC.PTFSM[9874] ={'无形气墙','被攻击时概率触发不动如山，触发不动如山时，额外的伤害将转化为护盾。 ',1,1,4}
	CC.PTFSM[9873] ={'火焰密宗','火焰刀法【大轮密宗.火焰刀】发动几率100%。 ',1,1,3} 
	CC.PTFSM[9872] ={'珠落玉盘','行动后提升我方全体100集气 ',1,1,2}
	CC.PTFSM[9871] ={'吴侬软语','行动前提升我方全体100集气 ',1,1,2}
	CC.PTFSM[9870] ={'风月无间','对男性伤害提高20%，被女性伤害减少20% ',1,1,2}
	CC.PTFSM[9869] ={'不老长春','被攻击时恢复80点生命 ',1,1,2}
	CC.PTFSM[9868] ={'转瞬红颜','每过199时序，自动回满血内体并解除自身基础异常状态。 ',1,1,3}
	CC.PTFSM[9867] ={'雷霆万钧','被攻击时30%几率对周身九格范围内敌人释放雷电并终止连击，根据自身御剑提升雷电伤害。 ',1,1,3}
	CC.PTFSM[9866] ={'妙手回春','被攻击时，有10%几率将受到的伤害转化为回血 ',1,1,3}
	CC.PTFSM[9865] ={'侠之大者','使用降龙十八掌，增加40%几率发动【降龙.极意】，使用降龙十八掌发动连击时附加随机多重后劲，额外增加伤害和杀气（NPC固定10重）。 ',1,1,3}
	CC.PTFSM[9864] ={'带刺玫瑰','装备软猬甲时，反弹30%受到的攻击伤害 ',1,1,3}
	CC.PTFSM[9863] ={'兰心蕙质','修炼武功秘籍时，五系兵器值成长翻倍 ',1,1,3}
	CC.PTFSM[9862] ={'过目不忘','修炼武功秘籍时，三围属性值成长翻倍 ',1,1,3} 
	CC.PTFSM[9861] ={'狂龙天征','使用降龙十八掌，40%几率发动【降龙.三叠浪】，暴怒时必定发动 ',1,1,3}
	CC.PTFSM[9860] ={'碧海潮生','攻击时发动碧海潮生曲,第一击100%概率杀全体敌人内力500，连击时发动概率40% ',1,1,3}
	CC.PTFSM[9859] ={'大鹏展翅','移动格数+3,使用玄铁剑法时，攻击范围变为可移动。 ',1,1,2} 
	CC.PTFSM[9858] ={'走火入魔','集气时有小概率跳跃（集气值随机增加），学会逆运后，被攻击必定进入【真.逆运经脉-走火入魔】状态，走火状态攻击/防御效果提高10%，加力/护体/出招几率大幅提高，走火状态无法休息，如体力低于20点，则停止走火。 ',1,1,4}
	CC.PTFSM[9857] ={'蟾震九天','蛤蟆功.蟾震九天效果加强，会根据蓄力值追加伤害 ',1,1,2}
	CC.PTFSM[9856] ={'庖丁解牛','攻击时有50%几率无视敌方30%防御。 ',2,1,3}
	CC.PTFSM[9855] ={'不动明王','复活后，免疫连击伤害。',1,1,3}
	CC.PTFSM[9854] ={'空明武道','攻击时，有(25+实战/20)%几率使敌方无法触发内功护体 ',1,1,3}
	CC.PTFSM[9853] ={'先天一阳','战斗中首次被击退可复活一次，回复70%生命值，部分状态，并立即行动，复活后，集气速度+5。 ',1,1,3}
	CC.PTFSM[9852] ={'铁腿水上飘','移动步数+5 ',1,1,2}
	CC.PTFSM[9851] ={'一气化三清','消耗内力时，概率使少量内力转化为怒气值、体力、生命值。 ',1,1,3}
	CC.PTFSM[9850] ={'心秀天铃','使用奇门武功几率发动“心秀天铃·星月争辉”*追加800点气攻，如已有14本天书，则触发此特效必破气防 ',1,1,2}
	CC.PTFSM[9849] ={'青蟒剑','金蛇剑法伤害降低25% ',1,1,1}
	CC.PTFSM[9848] ={'一剑无血','攻击不会造成流血，攻击必暴击。 ',1,1,3}
    CC.PTFSM[9847] ={'否极泰来','每过100时序激活一次【否极泰来】，免疫死亡伤害10时序 ',1,1,3} 
	CC.PTFSM[9846] ={'豹胎易筋丸','在敌方要服用的药品中加入豹胎易筋丸，使其加血效果变为减血 ',1,1,2}
	CC.PTFSM[9845] ={'剑术通神','攻击和被攻击时，无论任何系，均按敌我御剑系数计算加成 ',1,1,3} --修改
	CC.PTFSM[9844] ={'无招胜有招','暴怒时，使用独孤九剑攻击，追加1000点气攻，和10时序的静止状态，可叠加 ',1,1,3}
	CC.PTFSM[9843] ={'七弦剑气','攻击时概率（使用持瑶琴必定）发动“七弦无形剑气”，对敌方全体造成50点伤害 ',1,1,2}
	CC.PTFSM[9842] ={'慧中灵剑','每修炼一门剑法，攻击效果提升5%，初始集气+50 ',1,1,3}
	CC.PTFSM[9841] ={'酒神迷踪','被攻击时有30%几率发动"酒神秘踪步"闪避 ',1,1,3}
	CC.PTFSM[9840] ={'夺命三仙','使用剑法连击时变为三连击 ',1,1,2}
	CC.PTFSM[9839] ={'狂风快剑','使用剑法攻击，下回合集气+100 ',1,1,2}
	CC.PTFSM[9838] ={'勇猛精进','我方全体攻击力提高10%。 ',1,1,2}
	CC.PTFSM[9837] ={'颠三倒四','攻击时概率集气位置跳跃-30~40。 ',1,1,2} 
	CC.PTFSM[9836] ={'连环迷踪腿','行动后50%几率使用“连环迷踪腿”攻击周身三格敌人，造成100点伤害 ',1,1,2}
	CC.PTFSM[9835] ={'虎爪绝户','暴怒时使用虎爪绝户手触发奥义，对男性造成毁灭性创伤 。',1,1,2}  
	CC.PTFSM[9834] ={'白无常','被攻击时受到伤害随机减少1%~25% ',1,1,2}
	CC.PTFSM[9833] ={'西狂之怒啸','攻击时附带“西狂之怒啸”，敌方全体集气倒退100点 ',1,1,2}
	CC.PTFSM[9832] ={'一片冰心','左右互搏发动几率70%。 ',1,1,2}
	CC.PTFSM[9831] ={'一言止杀','行动前如果满怒气值且体力大于25点触发，全体敌方50%概率一回合恐惧。',1,1,2}
	CC.PTFSM[9830] ={'外和内刚','生命值低于50%时，攻击效果提升20% ',1,1,2}
	CC.PTFSM[9829] ={'巾帼之力','每二个回合行动前，体力大于15内力大于500使我方全体集气+200。',1,1,2}
	CC.PTFSM[9828] ={'食神','攻击不消耗体力 ',1,1,2}
	CC.PTFSM[9827] ={'情为何物','每隔50时序，随机向敌人发射三枚冰魄银针 ',1,1,2}
	CC.PTFSM[9826] ={'冷面热心','攻击降低10%，防御增加10%。 ',1,1,2} 
	CC.PTFSM[9825] ={'赏善使者','道德高于59，行动后对周身五格范围内队友治疗 ',1,1,2}
	CC.PTFSM[9824] ={'罚恶使者','道德低于61，行动后对周身五格范围内敌人施毒 ',1,1,2}
	CC.PTFSM[9823] ={'气寒西北','攻击必冰封，冰封超过50冻结目标，追加冰封值的真实伤害，自身免疫冰封 ',1,1,3}
	CC.PTFSM[9822] ={'碧针清掌','行动后使用“碧针清掌”攻击周身七格敌人，造成100点伤害 ',1,1,3}
	CC.PTFSM[9821] ={'无根无形','被攻击几率发动无根无形减伤30% ',1,1,3} 
	CC.PTFSM[9820] ={'万法自然','攻击时几率下回合集气+500 ',1,1,3}
	CC.PTFSM[9819] ={'铁琴铮铮','攻击时，有60%几率给敌方附加1-3层琴音状态（上限20层），每层琴音状态降低敌方1%集气速度。',1,1,3} 
	CC.PTFSM[9818] ={'吸血蝙蝠','攻击时，恢复造成伤害10%的血量（单次攻击吸血上限200点） ',1,1,2}
	CC.PTFSM[9817] ={'紫衫龙王','每次行动都有20%几率魅惑敌人一回合 ',1,1,3}
	CC.PTFSM[9816] ={'志垂日月','暴击效果随天书数量提升 ',1,1,2}
	CC.PTFSM[9815] ={'折梅手','面板上每多一个武功到极，天山折梅手威力+50。 ',1,1,2}
	CC.PTFSM[9814] ={'纤纤铁手','使用五毒神掌攻击，随机2-5倍威力 ',1,1,2}
	CC.PTFSM[9813] ={'灭天绝地','使用任何武功高连击，必暴击，移动格数+3',1,1,3} 
	CC.PTFSM[9812] ={'剑芒初现','使用剑法攻击追加100点真实伤害，如装备武器，则此加成减半 ',1,1,2} 
	CC.PTFSM[9811] ={'鹰飞九天','鹰爪功必定内伤，轻功增加100点。 ',1,1,3} 
	CC.PTFSM[9810] ={'剑气护体','每行动一次，减伤效果提升5%。 最高提升30%。',1,1,3}
	CC.PTFSM[9809] ={'一龙一象','提升10%伤害，降低10%承受伤害 ',1,1,2}
	CC.PTFSM[9808] ={'机敏无双','战斗开始前50时序，受到的伤害不超过50点 ',1,1,4}
	CC.PTFSM[9807] ={'十三太保','免疫破绽，免疫杀气，受到伤害降低13% ',1,1,4}
	CC.PTFSM[9806] ={'天元剑气','使用剑系武功攻击时，敌方防御减少75%。 ',2,1,4}
	CC.PTFSM[9805] ={'定心圆气','时序回复气血/内力/体力，并额外回复冰封/灼烧/流血1点/时序" ',1,1,4} 
	CC.PTFSM[9804] ={'惊才绝艳','特效触发概率+8点。被攻击集气不会少于300。 ',1,1,3}
	CC.PTFSM[9803] ={'轻云蔽月','被攻击时必发动"轻云蔽月"，免疫攻击10时序，冷却时间50时序 ',2,1,4}
	CC.PTFSM[9802] ={'悬权而动','移动格数+3，攻击后可以再次移动 ',1,1,3}
	CC.PTFSM[9801] ={'北冥极渊','主动攻击触发北冥神功吸内时，概率吸取生命值。',2,1,4}
	CC.PTFSM[9800] ={'天子观气','敌方全体集气减半,命中减少20%。 ',2,1,4}
	CC.PTFSM[9799] ={'凤唳九霄','每次行动前有60%几率使敌方全体集气位置倒退150。',1,1,3}
	CC.PTFSM[9798] ={'秀若芝兰','面板上每个外功增加1点集气。 ',1,1,3}
	CC.PTFSM[9797] ={'红粉骷髅','对女性攻击伤害×120%，被女性攻击伤害×80% ',1,1,2}
	CC.PTFSM[9796] ={'天怒红颜','对男性攻击伤害×120%，被男性攻击伤害×80% ',1,1,2}
	CC.PTFSM[9795] ={'混元炁','混元功自动运功，混元功范围+1。 ',1,1,2} 
	CC.PTFSM[9794] ={'刀剑归真','暴怒攻击触发动刀剑归真绝技，必定连击首击出胡刀二击出苗剑绝技，大范围伤害杀气。。 ',1,1,4}
	CC.PTFSM[9793] ={'紫衣银鞭','每修炼一个奇门武功到极，减伤提高4%（上限7个） ',1,1,3}
	CC.PTFSM[9792] ={'何足道哉','气血越少连击、暴击越高 ',1,1,3}
	CC.PTFSM[9791] ={'逆流勇进','生命值低于50%时暴击率两倍，生命值低于25%时暴击率三倍 ',1,1,3}
	CC.PTFSM[9790] ={'千蛛万毒','攻击强制上毒20点，根据目标中毒值回复生命 ',1,1,2}
	CC.PTFSM[9789] ={'娇美人妻','被攻击时，消耗攻击方5-10点体力 ',1,1,2}
	CC.PTFSM[9788] ={'光明左使','每次攻击，使敌方受到的伤害提高2%，上限40% ',1,1,2}
	CC.PTFSM[9787] ={'重阳再现','战斗中首次被击退可复活一次,回复70%生命值，部分状态，并立即行动,复活后，集气速度+5。 ',1,2,3}
	CC.PTFSM[9786] ={'北斗七闪','复活后若干回合全程怒气爆发不减少，气攻值大幅增加。 ',1,2,3}
	CC.PTFSM[9785] ={'清露寒梦','攻击概率无视敌方防御15% ',1,1,3}
	CC.PTFSM[9784] ={'天仙锁魂','敌方每回合30%几率附加虚弱状态2回合 ',1,1,3}
	CC.PTFSM[9783] ={'勾魂夺魄','概率魅惑敌人。 ',1,1,2}
	CC.PTFSM[9782] ={'以暴制暴','受到暴击伤害，自身下次攻击必暴1次，受到连击伤害，下次攻击必连击1次。 ',1,1,2}
	CC.PTFSM[9781] ={'以眼还眼','生命值大于10%时，每次攻击减少自身5%的生命，受到攻击的目标也附加生命最大值5%的伤害。 ',1,1,2}
	CC.PTFSM[9780] ={'得意门生','被攻击时几率按自身暴击率的一半降低伤害。 ',1,1,2}
	CC.PTFSM[9779] ={'银钩铁划','攻击时几率按自身连击率的一半提高伤害。 ',1,1,2}
	CC.PTFSM[9778] ={'怡红公子','自带六如苍龙诀。 ',2,1,4}
	CC.PTFSM[9777] ={'春哥的自信','开局可以选择1个天赋，战斗死亡必复满血复活。 ',2,1,4}
	CC.PTFSM[9776] ={'雪羽宗主','内力9999，无视内属修炼武功，自运易水寒诀。 ',2,1}
	CC.PTFSM[9775] ={'不归三境','1书领悟第一境——不见归人：攻击必灼烧，灼烧大于80则点燃5时序，5书领悟第二境——不识归途：暴怒连击必三连击，且连击伤害不减，9书领悟第三境——不知归处：攻击暴击时，无视敌方防御50% ',2,1,3}
	CC.PTFSM[9774] ={'一通万法','每个武功到极，三围与五系+10 ',2,1,3}
	CC.PTFSM[9773] ={'长平眷恋','神行百变闪避/减伤几率提高。使用金蛇剑法时，生命值低于30%时，可触发金蛇奥义 ',1,1,3}
	CC.PTFSM[9772] ={'魂系一刀','胡家刀法到极增加10点耍刀技巧，增加胡家刀法极意40%。 ',1,1,3}
	CC.PTFSM[9771] ={'百年童男','纯阳无极功自动运功，永远保持阳内。 ',1,1,3}
	CC.PTFSM[9770] ={'通微显化','被攻击发动无根无形减伤30%，攻击时几率发动万法自然，下回合集气+500，移动格数至少为8格，攻击时几率触发化朽为奇，追加武功威力的气攻。 ',1,1,4}	
	CC.PTFSM[9769] = {'运转乾坤','乾坤大挪移反弹效果 强化至反弹40%伤害（无需运功）。 ',1,1,2}
	CC.PTFSM[9768] = {'狮王咆哮','攻击时概率消耗2000点内力和10点体力，使全场敌人进入恐惧状态20时序。 ',2,1,4}-- 表1天赋名称，表2天赋说明，表3为为1非专属2为专属，表4为1是非门天赋为2是门派天赋，表5为天赋等级(1蓝2紫3金4红)
	CC.PTFSM[9767] = {'倾国倾城','被攻击时概率由战场上随机参加人物替代伤害。 ',2,1,4}
	CC.PTFSM[9766] = {'群体治疗','体力大于15，内力大于300时攻击时概率对周围五格范围内的队友进行治疗，时序回内伤并按比例回血，持续20时序。 ',2,1,3}
	CC.PTFSM[9765] = {'群体上毒','体力大于15，内力大于300时攻击时概率对周围五格范围内的的敌人造成时序中毒，持续50时序。 ',2,1,3}
	CC.PTFSM[9764] = {'魔帝·吸星','【天关BOSS翻倍】每3时序恢复1点内伤，距离越远所受到的伤害与杀气越低（与原距离伤害衰减叠加），敌方与自身距离越近，集气速度越低（最远距离10格，超出10格则不受影响），攻击与被攻击时必定触发吸星大法，吸星大法效果固定增加200，当敌方内力不足时，则造成损失内力一半的生命损失，当自身满内时，吸收的内力的一半则化作真气护体，上限为自身最大生命30%。 ',2,1,4}
	CC.PTFSM[9763] = {'风云再起','集气速度提升6点，50机率追加一次连击(暴怒必追加)，连击时伤害、气攻不减。 ',2,1,3}
	CC.PTFSM[9762] = {'葵花秘法','葵花神功为天赋内功时自动运功且必刺目，真.葵花移形概率30%。葵花点穴手追加1000气攻，且必定造成封穴。 ',2,1,4}
	CC.PTFSM[9761] = {'真名神照','主运神照功时拥有绝对气防（一脉后主运长生诀同样有效）.神照功/长生诀复活无需运功，效果强化，回复百分比为100%，并且立即行动，使用武功绝招只需要60点怒气，轻功+20。 ',2,1,4}
	CC.PTFSM[9760] = {'名相皆无','内力上限9999，计算加力/护体/出招几率必定开启二次判定。 ',2,1,4}
	CC.PTFSM[9759] = {'混沌太玄','可使用太玄神功攻击，太玄神功耗内降低50%（与天赋外功效果叠加，降低75%内力消耗），无需挑战李白可解锁太玄神功的【太玄反震】或【混沌太玄】。 ',2,1,4}
	CC.PTFSM[9758] = {'四大恶人','暴击伤害效果提升50%。',2,1,4}
	CC.PTFSM[9757] = {'引盅','行动前50%概率使用盅毒刺激自身，自身每时序损失1%最大血量，状态下自身血量越低，伤害/集气越高。 ',2,1,4}
	CC.PTFSM[9756] = {'袋中乾坤','攻击敌人时，概率使敌人和自己同时获得定乾坤DEBUFF，停止行动且免疫一切伤害。 ',2,1,4} 
	CC.PTFSM[9755] = {'奋英雄怒','攻击时必定造成暴击并有红字特效，集气速度+8。 ',2,1,3}
	CC.PTFSM[9754] = {'逆流勇进','生命值低于50%时暴击率两倍，生命值低于25%时暴击率三倍，当生命值50%时，生命值每再降低1%，下回合集气位置+10点。 ',1,1,3}
	CC.PTFSM[9753] = {'七星聚会','七子中之一人每次行动后为其余六人增加集气位置200点。',2,1,3} 
	CC.PTFSM[9752] = {'含沙射影','暗器攻击范围提升至7×7方阵。',2,1,2} 
    CC.PTFSM[9751] = {'江南七怪','江南七怪每在场一人，我方攻击+50，防御+50，轻功+50。且彼此分摊伤害。',2,1,3} 
    CC.PTFSM[9750] = {'崆峒五老','七伤拳一震七伤反噬减少一半。',2,1,2} 
    CC.PTFSM[9749] = {'三十二身相','攻击时或被攻击时机率触发持续100时序“一合相”BUFF,减伤15%,“一合相”存在期间，才会发动以下身相：*【神鱼相】：攻击时机率追加一次连击，暴怒必连。*【白毫相】 ：免疫杀气。*【雀母相】：被攻击机率减伤50点。【大自在相】：被攻击机率+200集气。',2,1,4} 
    CC.PTFSM[9748] = {'破苍穹','攻击时发动“剑道化身.破苍穹”无视敌方防御50%。',1,1,4} 
    CC.PTFSM[9747] = {'化三清','被攻击发动“化三清”减少伤害30%。',1,1,4} 
    CC.PTFSM[9746] = {'剑心通明','剑法攻击必中。',1,1,4} 
    CC.PTFSM[9745] = {'亘天赤焰','攻击必发动赤焰给敌方造成灼烧，小概率直接点燃，每点灼烧值减少敌方防御1%，免疫流血，敌方人数越多，自身三围，五系越高。',1,1,3}
    CC.PTFSM[9744] = {'曲夕烟隙','30%概率触发“曲夕烟隙”混乱目标，使目标随机移动。',1,1,3}   
    CC.PTFSM[9743] = {'隔空点穴','造成封穴时，封穴增加10点，被攻击时对目标造成10点封穴。',1,1,3}
    CC.PTFSM[9742] = {'井月八法','每个刀法到极领悟一招，每一招加暴击伤害/暴击概率/加气攻(上限8个)。',1,1,4}
    CC.PTFSM[9741] = {'机灵古怪','自身集气位置概率前进30，暴怒时3倍，集气位置不会低于0。',1,1,3} 
    CC.PTFSM[9740] = {'千变万幻','挨打增加集气速度，集气上限80,集气不受基础异常状态影响。',1,1,4}
    CC.PTFSM[9739] = {'雪花神剑','雪山剑法威力翻倍,攻击时概率触发“雪花神剑”，增加杀气，暴怒必触发。',2,1,4}
    CC.PTFSM[9738] = {'剑廿三','自带1-14式圣灵剑法，使用剑法时随机出招增加气攻，15-22式需获得天书领悟，获得9本天书后满怒时使用剑法触发剑廿三大范围攻击并概率使目标昏迷1回合。',2,1,3}
    CC.PTFSM[9737] = {'金刚伏魔','造成伤害的回复队友或自己生命。额外追加200点伤害。',1,1,4}
    CC.PTFSM[9736] = {'机智多谋','在场时，我方全体获得如下光环：处于蓄力状态时，增加自身20%减伤（蓄力必定成功），处于防御状态时，有20%几率闪避。',1,1,3}
    CC.PTFSM[9735] = {'刀剑双绝','耍刀技巧的50%加成到御剑能力，御剑能力的50%加成到耍刀技巧，刀法与剑法武功威力+200。',1,1,3}
    CC.PTFSM[9734] = {'谁与争锋','装备『倚天剑』时，全部剑法威力+200，使用九阴白骨爪，攻击时无视敌方50%防御。',1,1,4}  
    CC.PTFSM[9733] = {'长春不老','减伤30%伤害并用双倍内力抵消伤害值。',1,1,3} 
    CC.PTFSM[9732] = {'星罗散手','用拳掌攻击时，必触发“星罗散手”给对方造成封穴。',1,1,3} 
    CC.PTFSM[9731] = {'谐之道','自身不会有破绽，暴怒时发动必中破绽,击中敌方破绽高机率造成敌方5时序集气暂停。',2,1,4} 
    CC.PTFSM[9730] = {'侠客行','【诗酒化行】：攻击后集气+200，*【十步杀一人】：击退敌人发动可再次行动。*【深藏身与名】：攻击后30时序内50%概率闪避攻击。',2,1,4} 
    CC.PTFSM[9729] = {'九阴神爪','九阴神爪极意必两连，40%机率三连，暴怒必三连。',2,1,3} 
    CC.PTFSM[9728] = {'翩若惊鸿','主运天罗地网，每次攻击增加1~2层“疾风”每层+2.5%集气，最多10层，被男性目标攻击伤害减少10%。',2,1,3} 
    CC.PTFSM[9727] = {'蓑羽凶鹤','暴怒时攻击附加随机负面状态，战斗中首次被击退可复活一次，立即行动。',2,1,4} 
    CC.PTFSM[9726] = {'漠北苟王','免疫男性非连击伤害，被女性攻击时追加666点伤害。',2,1,3} 
    CC.PTFSM[9725] = {'剑气飞纵','连击不减伤害，攻击范围+1，攻击时不随距离减伤害，目标距离越远，伤害越高。',2,1,4} 
	CC.PTFSM[9724] = {'苍龙再现','【门派主角专属】六书之后挑战苍龙七宿可以获得苍龙之力中的一种。',2,1,4}  --基主 角木蛟 亢金龙 房日兔 氐土貉 心月狐 尾火虎 箕水豹
	--CC.PTFSM[9724] = {'北冥真气','气防增加800。',1,1,2} 



	--人物称号--
    -- 表1天赋名称，表2天赋说明，表3为为1非专属2为专属，表4为1是非门天赋为2是门派天赋，表5为天赋等级(1蓝2紫3金4红)

    CC.PTFSM[757] = {'备用','免疫以自已为中心的九宫格内的敌人攻击。',1,1,4} 	 --春哥
    CC.PTFSM[756] = {'天刀','天刀九问必连必暴。',1,1,4} 	 --宋缺
    CC.PTFSM[755] = {'凌空一羽','免疫以自已为中心的九宫格内的敌人攻击。',1,1,4} 	 --云殊
    CC.PTFSM[754] = {'凌空一羽','免疫以自已为中心的九宫格内的敌人攻击。',1,1,4} 	 --公羊羽
    CC.PTFSM[753] = {'密宗高手','密宗武学连击率+20%，暴击率+20%。',1,1,2} 	 --胜谛
    CC.PTFSM[752] = {'青云之志','被击败后，如果有其他参战人物被击败，有一次机会概率再次回到战场。',1,1,4} 	 --顾惜朝
    CC.PTFSM[751] = {'天机传人','天机宫武学连击率+30，暴击率+30%。威力+300。',1,1,3} 	 --明镜
    CC.PTFSM[750] = {'药师菩萨','行动后给已方队伍中血百分比少的目标回复20%生命值。',1,1,3} 	 --花晓霜
    CC.PTFSM[749] = {'天机宫主','天机宫武学连击率+40，暴击率+40%。威力+400。',1,1,3} 	 --花无媸
    CC.PTFSM[748] = {'佛山一霸','被攻击概率让队友承担75%伤害。',1,1,2} 	 --凤天南
    CC.PTFSM[747] = {'钟氏三雄','攻击概率造成目标虚弱。',2,1,2} 	 --钟兆英
    CC.PTFSM[746] = {'钟氏三雄','攻击概率造成目标虚弱。',2,1,2} 	 --钟兆英
    CC.PTFSM[745] = {'钟氏三雄','攻击概率造成目标虚弱。',2,1,2} 	 --钟兆英
    CC.PTFSM[744] = {'九龙拳','拳法攻击概率减少目标内力值。',2,1,1} 	 --易吉
    CC.PTFSM[743] = {'八仙剑','八仙剑威力+400。',2,1,1} 	 --蓝秦
    CC.PTFSM[742] = {'韦陀派高手','韦陀掌威力+400。',2,1,1} 	 --刘鹤真
    CC.PTFSM[741] = {'八卦高手','八卦门武功连击率+20%，暴击率+20%。',2,1,2} 	 --王剑英
    CC.PTFSM[740] = {'八卦高手','八卦门武功连击率+20%，暴击率+20%。',2,1,2} 	 --王剑杰
    CC.PTFSM[739] = {'八卦高手','八卦门武功连击率+10%，暴击率+10%。',2,1,2} 	 --商宝震
    CC.PTFSM[738] = {'匪石之心','牺牲自己的全部生命，救回已经被击败的队友。',2,1,3} 	 --胡夫人
    CC.PTFSM[737] = {'八卦高手','八卦门武功连击率+20%，暴击率+20%，八卦刀造成敌方“虚弱”状态20时序。',2,1,2} 	 --商夫人
    CC.PTFSM[736] = {'神机营','集气速度-30%，攻击提升30%。',2,1,2} 	 --火枪兵
    CC.PTFSM[735] = {'神机营','集气速度-30%，攻击提升30%。',2,1,2} 	 --火枪兵
    CC.PTFSM[734] = {'神机营','集气速度-30%，攻击提升30%。',2,1,2} 	 --火枪兵
    CC.PTFSM[733] = {'神机营','集气速度-30%，攻击提升30%。',2,1,2} 	 --火枪兵
    CC.PTFSM[732] = {'御林军','已方人数越多，攻击力和防御力越高。',2,1,2} 	 --赛尚鄂
    CC.PTFSM[731] = {'汤大侠','攻击（100-道德）概率1.2倍伤害',1,1,2}	 --汤沛
    CC.PTFSM[730] = {'天龙门弟子','雷霆剑法气攻+300。',2,1,2}	 --天龙门弟子
    CC.PTFSM[729] = {'天龙门弟子','雷霆剑法气攻+300。',2,1,2}	 --天龙门弟子  
    CC.PTFSM[728] = {'天龙门弟子','雷霆剑法气攻+300。',2,1,2}	 --天龙门弟子
    CC.PTFSM[727] = {'天龙门弟子','雷霆剑法气攻+300。',2,1,2}	 --天龙门弟子
    CC.PTFSM[726] = {'武当高手','武当武学连击率+10%，暴击率+10%。',2,1,2}	 --天一道长
    CC.PTFSM[725] = {'灰鹞子','闪避+50。',2,1,1}	 --张飞雄
    CC.PTFSM[724] = {'腾龙剑','剑法气攻+300。',2,1,1}	 --曹云奇
    CC.PTFSM[723] = {'丐帮长老','丐帮武学连击率+20%，暴击率+20%。',2,1,2}	 --范汉兴
    CC.PTFSM[722] = {'八卦高手','八卦门武功连击率+20%，暴击率+20%，八卦掌造成敌方“散功”状态20时序。',2,1,3}	 --商剑鸣
    CC.PTFSM[721] = {'酒神','初始暗器200，暗器必定1倍伤害，喝酒buff有特殊攻击特效，休息时必定蓄力防御。*【福缘奇遇】得到辟邪剑谱，第一格洗辟邪剑法一级，并洗天外x笑傲正邪打败东方不败 第二格洗葵花宝典一级，并洗天内x可装备绣花针（必须接受惩罚）',2,1,3}	 --酒神
    CC.PTFSM[720] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[719] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[718] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[717] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[716] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[715] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[714] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[713] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[712] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[711] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[710] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[709] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[708] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[707] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[706] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[705] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[704] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[703] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[702] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[701] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[700] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[699] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[698] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[697] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[696] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[695] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[694] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[693] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[692] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[691] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[690] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[689] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[688] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[687] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[686] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[685] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[684] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[683] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[682] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[681] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[680] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[679] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[678] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[677] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[676] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[675] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[674] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[673] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[672] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[671] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[670] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[669] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[668] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[667] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[666] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[665] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[664] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[663] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[662] = {'备用','',2,1,3}	 --备用
    CC.PTFSM[661] = {'铁甲重骑','移动固定十格，防御提升100。',2,1,3}	 --铁甲重骑
    CC.PTFSM[660] = {'铁甲重骑','移动固定十格，防御提升100。',2,1,3}	 --铁甲重骑
    CC.PTFSM[659] = {'铁甲重骑','移动固定十格，防御提升100。',2,1,3}	 --铁甲重骑
    CC.PTFSM[658] = {'天池怪侠','被攻击时概率转移杀气值给攻击者，百花错拳威力+600。',2,1,3}	 --袁士宵
    CC.PTFSM[657] = {'少林长老','少林武学连击率+40%，暴击率+40%，少林武学威力+400。',2,2,3}	 --天虹 -- 少林门派天赋6
    CC.PTFSM[656] = {'少林高僧','少林武学连击率+30%，暴击率+30%。',2,1,2}	 --元伤
    CC.PTFSM[655] = {'少林堂主','少林武学连击率+30%，暴击率+30%。',2,2,2}	 --元悲 -- 少林门派天赋4
    CC.PTFSM[654] = {'铁甲重骑','移动固定十格，防御提升100。',2,1,3}	 --铁甲重骑
    CC.PTFSM[653] = {'少林高僧','少林武学连击率+20%，暴击率+20%。',2,1,2}	 --元痛
    CC.PTFSM[652] = {'神州大侠','修炼辟邪剑法与葵花宝典没有惩罚，自带忘情天书特效。*【绝技.惊天一剑】战胜三名剑术名家，暴怒时可使用“天剑”绝技，使用剑法无视敌方防御30%，无视闪避，追加200点伤害。',2,1,4}	 --萧秋水
    CC.PTFSM[651] = {'天地双尊','攻击与防御时敌方任何攻击系数都视为0。攻南时无视目标50%防御。（未实装）',2,1,4}	 --南贤
    CC.PTFSM[650] = {'小王爷','武功练到极，减少受到的5%杀气（上限25%）。',2,1,2}	 --杨康
    CC.PTFSM[649] = {'华山玉女','紫霞神功必发动紫霞剑气，剑法攻击必触发“玉女十九剑”增加自身连击率，暴怒必连。*【福缘际遇】获得五岳剑诀第二格洗五岳剑诀。',2,1,2}	 --宁中则
    CC.PTFSM[648] = {'玄冥二老','使用玄冥神掌，必定发动极意。',2,1,2}	 --鹤笔翁
    CC.PTFSM[647] = {'玄冥二老','使用玄冥神掌，必定发动极意。',2,1,2}	 --鹤笔翁
    CC.PTFSM[646] = {'千蛛万毒','攻击强制上毒20点，根据目标中毒值回复生命。',2,1,2}	 --殷离
    CC.PTFSM[645] = {'密宗高手','密宗武功连击率+20%，暴击率+20%。',2,1,2}	 --阿三
    CC.PTFSM[644] = {'密宗高手','密宗武功连击率+20%，暴击率+20%。',2,1,2}	 --阿二
    CC.PTFSM[643] = {'八臂神剑','使用剑法攻击概率提高威力30%。',2,1,3}	 --阿大
    CC.PTFSM[642] = {'星河真君','已方除自己外还有人员存活，则不受伤害。',2,1,4}	 --四大山
    CC.PTFSM[641] = {'魔道祖师','明教武功连击率+40%，暴击率+40%，武功威力+400。',2,1,4}	 --摩尼
    CC.PTFSM[640] = {'古墓后人','玉女心经特效机率增加，无需主运九阴神功可触发九阴白骨爪极意，华山觉醒九阴白骨爪威力+50%,7书九阴神爪极意40%三连，暴怒必三连。*【广寒清辉】华山后山觉醒后暴怒触发“广寒清辉”必冻结目标集气5时序。',2,1,4}	 --黄衫女  
    CC.PTFSM[639] = {'金蛇郎君','金蛇剑法威力1.5倍，金蛇锥3~5倍伤害，暴怒使用金蛇剑法必出金蛇奥义。',2,1,4}	 --夏雪宜
    CC.PTFSM[638] = {'九阳至尊','内力上限9999，九阳神功必加力护体，可使用九阳神功攻击，反震40%伤害。',2,1,4}	 --斗酒僧
    CC.PTFSM[637] = {'九阴至尊','九阴神功自动运功；*【易筋锻骨】：免疫封穴，免疫暴击伤害；【天之道】：攻击时触发“天之道”附加目标生命最大值5%的伤害；【大道归藏】(畅想专享)：无视条件修炼武功，所有武功可以到极。',2,1,4}	 --黄赏
    CC.PTFSM[636] = {'青莲剑仙','青莲剑法高连；*【谪仙之体】被攻击时防御值一定不少于对方攻击力，攻击时攻击力一定不少于对方防御值。*【青莲剑歌】华山后山觉醒后领悟，满怒剑法攻击发动大范围伤害附加御剑值伤害并给目标添加创伤',2,1,4}	 --李白
    CC.PTFSM[635] = {'西昆仑','主运鲸息功或使用碧海惊涛掌可以触发六大奇劲之一。灵鳌步和十步方加强。*【福缘际遇】灵鳌岛领悟鲸息功与碧海惊涛掌，第一格洗碧海惊涛掌，第二格洗鲸息功，第三格洗十方步十级。',2,1,4}	 --梁萧
    CC.PTFSM[634] = {'逍遥祖师','必发动“梅花三弄”特效之一，*梅花一弄：造成散功30时序，*梅花二弄：减少敌方当前内力值的5%，*梅花三弄：忽视绝对气防，*【福缘际遇】击败无崖子直接激活“逍遥御风”(不需学小无相/八荒/北冥)。',2,1,4}	 --逍遥子
    CC.PTFSM[633] = {'辽东大侠','天赋轻功自动主运,自身免疫冰封,装备冷月宝刀后胡家刀法威力+300,装备冷月刀攻击必冰封。*【福缘际遇】飞雪邪线杀苗/飞雪正线胜苗第二格洗苗剑1级，领悟刀剑归真绝技。',2,1,4}	 --胡一刀
    CC.PTFSM[632] = {'尖酸伶俐','受到伤害时，25%概率让已方队友承担一半伤害。',2,1,2}	 --丁敏君
    CC.PTFSM[631] = {'芷兰毓秀','*【福缘际遇】倚天邪线少林剧情，可选择洗第一格武功,倚天邪线少林剧情，洗第二格武功，天赋内功洗为九阴神功。',2,1,3}	 --周芷若
    CC.PTFSM[630] = {'灵獒王','。',2,1,2}	 --灵獒王
    CC.PTFSM[629] = {'长平公主','华山击败玉真子觉醒领悟：“凤鸣九霄”：满怒触发范围伤害。“凤凰涅槃”：机率触发杀气减999，伤害减99，“浴火重生”：机率复活一次。*【福缘际遇】获得“神行百变”第三格洗神百变1级。',2,1,4}	 --朱媺娖
    CC.PTFSM[628] = {'雕兄','使用玄铁剑法时，有几率发动重剑真传。',2,1,2}	 --神雕
    CC.PTFSM[627] = {'漠北天狼','我方轻功+10%，命中+10%。',2,1,3}	 --蒙哥
    CC.PTFSM[626] = {'小东邪','特色指令：玲珑，可自由切换第一格武功为弹指神通/玉萧剑法/落英神剑掌，不消耗回合。峨眉金顶觉醒后，身娇腰柔易推倒，内力变为天罡。',2,1,3}	 --郭襄
    CC.PTFSM[625] = {'绝情谷众','攻击概率锁足。',2,1,1}	 --绝情谷众
    CC.PTFSM[624] = {'绝情谷众','攻击概率锁足。',2,1,1}	 --绝情谷众
    CC.PTFSM[623] = {'绝情谷众','攻击概率锁足。',2,1,1}	 --绝情谷众
    CC.PTFSM[622] = {'绝情谷众','攻击概率锁足。',2,1,1}	 --绝情谷众
    CC.PTFSM[621] = {'绝情谷众','攻击概率锁足。',2,1,1}	 --绝情谷众
    CC.PTFSM[620] = {'绝情谷众','攻击概率锁足。',2,1,1}	 --绝情谷众    
    CC.PTFSM[619] = {'绝情谷众','攻击概率锁足。',2,1,1}	 --绝情谷众
    CC.PTFSM[618] = {'绝情谷众','攻击概率锁足。',2,1,1}	 --绝情谷众
    CC.PTFSM[617] = {'铁掌莲花','使用枣核钉必造成内伤，使用铁掌概率追加一枚枣核钉。',2,1,3}	 --裘千尺 
    CC.PTFSM[616] = {'绝情谷主','本方每阵亡一名队友，集气速度增加2点。受到的封穴降低50%。',2,1,3}	 --公孙止 
    CC.PTFSM[615] = {'欢喜冤家','与林玉龙同时在场，攻防轻增加50。',2,1,1}	 --任飞燕 
    CC.PTFSM[614] = {'欢喜冤家','任飞燕在场，攻防提各提升100。',2,1,1}	 --林玉龙 
    CC.PTFSM[613] = {'铁掌神鞭','震天铁掌威力翻倍，呼延十八鞭威力三倍，使用震天铁掌10%概率直接震晕目标，使用呼延十八鞭大概率造成封穴。',2,1,3}	 --卓天雄 
    CC.PTFSM[612] = {'铁鞭震八方','呼延十八鞭2~5倍威力。',2,1,3}	 --周维信 
    CC.PTFSM[611] = {'','',2,1,3}	 --备用 
    CC.PTFSM[610] = {'妙手仁心','只有暴怒状态才能攻击。药物使用效果双倍。',2,1,3}	 --花满楼 
    CC.PTFSM[609] = {'绍敏郡主','被攻击时，反弹30%受到的攻击伤害。*【福缘际遇】神雕邪线襄阳剧情，洗第二格武功，天赋内功洗为天魔功。',2,1,3}	 --赵敏 
    CC.PTFSM[608] = {'葵花尊者','攻击力、防御力1.5倍，攻击必发动葵花刺目，受到普通暗器攻击必定反击，葵花移形/真葵花移形/葵花概率提升，可以装备绣花针。',2,1,4}	 --葵花尊者 
    CC.PTFSM[607] = {'乱世浮萍','我方全体连击率提高10%。',2,1,3}	 --焦宛儿 
    CC.PTFSM[606] = {'西域战神','拥有专属坐骑毛驴,休息时自带蓄力兼防御效果。',2,1,3}	 --阿凡提 
    CC.PTFSM[605] = {'姑射仙姿','被攻击时必发动\"轻云蔽月\"，免疫攻击10时序，冷却时间50时序，攻击时几率发动\"流风回雪\"，本次攻击必定造成冰封。',2,1,4}	 --林朝英 
    CC.PTFSM[604] = {'越女剑仙','使用越女剑法攻击无误伤，每次行动前解除自身所有异常，自带“九霄仙息”护体，增加自身御剑系数×5点气防，战场中增加自身御剑系数点攻防值。',2,1,4}	 --阿青   
    CC.PTFSM[603] = {'巴图鲁','主运金刚不坏体，必定发动\"金刚不坏\"特效。',2,1,3}	 --鳌拜      
    CC.PTFSM[602] = {'阴阳怪气','使用化骨绵掌削弱敌方体力内力',2,1,2}	 --海大富  
    CC.PTFSM[601] = {'洪福齐天','特色指令：口才，使一名敌方进入沉睡状态，此状态无法集气，不会自行解除，受到攻击会醒来。*【福缘际遇】鹿鼎记鳌府密室剧情，洗第一、二格武功，能装备火枪。',2,1,3}	 --韦小宝  
    CC.PTFSM[600] = {'李秋水幻相','李秋水幻相。',2,1,3}	 --李秋水幻相  
    CC.PTFSM[599] = {'少林神僧','少林武学连击率+40%，暴击率+40%。',2,1,3}	 --渡难  
    CC.PTFSM[598] = {'少林神僧','少林武学连击率+40%，暴击率+40%。',2,1,3}	 --渡劫  
    CC.PTFSM[597] = {'少林护法','少林武学连击率+40%，暴击率+40%。',2,1,3}	 --渡厄  -- 少林门派天赋5
    CC.PTFSM[596] = {'无忧水镜','受伤害时的一半化为自身生命、内力、体力。',2,1,2}	 --谢无悠  
    CC.PTFSM[595] = {'血刀高手','血刀门武功连击率+20%，暴击率+20%。',2,1,2}	 --宝象  
    CC.PTFSM[594] = {'铁索横江','基础连击率大幅度提高,【闭气离墙.起死回生】，战斗中可以复活一次。',2,1,3}	 --戚长发  
    CC.PTFSM[593] = {'不戒和尚','特色指令：不戒,帮助队友自宫,每次开启消耗体力20，内力1000。',2,1,2}	 --不戒  
    CC.PTFSM[592] = {'料敌先机','先手反击必中，进入战斗的初始集气位置为1000，自身移动步数锁定为10格，免疫暗器。剑魔【BOSS状态】每次攻击自身剑势增加一层，最大十层，攻击人数随剑势而变化，每层剑势增加5%伤害和10%减伤（BOSS状态无减伤上限）被攻击时无法被连击，同一类型的武功无法重复造成伤害，被攻击时需按照指破拳、剑破指、刀破剑、奇破刀、拳破奇的顺序攻击，破招后造成的伤害增加20%，剑势降低一层，反之增加一层剑势，剑势十层时，攻击后恢复2000内力，50中毒。',2,1,4}	 --独孤求败
    CC.PTFSM[591] = {'武状元','遗落在历史长河中的尘埃。',2,1,2}	 --武状元
    CC.PTFSM[590] = {'白马侠女','装备白马时的集气加成效果翻倍，每修炼一个奇门武功到极，集气速度+2（上限7个）。',2,1,2}	 --李文秀
    CC.PTFSM[589] = {'铃剑侠女','使用连城剑法高连击。',2,1,2}	 --水苼
    CC.PTFSM[588] = {'岛主夫人','桃花岛武学威力+200,特效发动机率+10。*【福缘际遇】桃花岛招亲后，第2格洗九阴神功1级，天内洗九阴神功，射雕正线牛家村3格洗弹指神通，天外洗弹指神通，射雕邪线云岭山洞3格洗九阴白骨爪，天外洗九阴白骨爪。',2,1,4}	 --冯蘅
    CC.PTFSM[587] = {'紫色缁衣','*【福缘际遇】倚天正线光明顶胜灭绝第一格白莽鞭法，天外洗白莽鞭法,倚天邪线胜三渡第一格洗金刚伏魔圈,天外洗金刚伏魔圈,飞雪拿到飞天神行,第三格洗飞天神行1级,天轻洗飞天神行。',2,1,2}	 --袁紫衣
    CC.PTFSM[586] = {'昆仑三圣','琴音：攻击时为敌全体添加1~4层琴音BUFF,最多30层，棋势：攻击目标附带天数书量x10的伤害，百鸟朝凤：每攻击一次给自身添加1~3层曲风，曲风BUFF>20层,消耗20层曲风给敌全体造成附加琴音层数x10的伤害。*【福缘际遇】获得九阳神功，天内洗九阳神功，获得两仪剑法，第1格洗两仪剑法，获得两仪刀法，第2格洗两仪刀法。',2,1,4}	 --百晓
    CC.PTFSM[585] = {'峨眉长老','峨眉派武功连击率+20%，暴击率+20%。',2,1,2}	 --百晓
    CC.PTFSM[584] = {'不哭死神','排云掌：随天书数量增加领悟招式,使用拳掌时触发招式。招式气攻、伤害、破防（最大36%）随招式增加,第十到第十二式无视绝对气防与大概率破防。',2,1,3}	 --步惊云   
    CC.PTFSM[583] = {'小尼姑','被攻击伤害-15%，自身伤害-10%,*【福缘际遇】获得万花剑法 1格洗万花剑法1级。',2,1,3}	 --仪琳
    CC.PTFSM[582] = {'冰川天女','敌方全体集气-5,攻击必冰封，冰封超过50机率冻结目标,追加冰封值的真实伤害，自身免疫冰封。',2,1,3}	 --白绣
    CC.PTFSM[581] = {'丁丁当当','敌方全体集气-5，攻击必灼烧击败丁不三丁不四，金乌刀法威力增加300，只学金乌刀法可触发举火燎原。',2,1,3}	 --丁当
    CC.PTFSM[580] = {'银弧刀','攻击必造成流血,暴击率+30。程英居觉醒后免疫中毒。*【福缘际遇】蝴蝴谷帮胡青牛治好腿伤 轻功+50，获得玉女剑法 第2格洗玉女剑法1级，获得玉女心经 第3格洗玉女心经1级，天内洗玉女心经，获得天罗地网 第5格洗天罗地网1级，天轻洗天罗地网。',2,1,3}	 --陆无双
    CC.PTFSM[579] = {'盗王之王','可偷取目标身上特品，增加敌方存活人数x5的集气速度,行动后可再次移动。',2,1,4}	 --司空摘星
    CC.PTFSM[578] = {'大唐双龙','阳内攻击必灼伤，概率点燃,无视内属修炼刀法。',2,1,4}	 --寇仲
    CC.PTFSM[577] = {'万佛朝宗','拥有绝对气防,每五回合攻击时触发万佛朝宗附加目标当前生命值10%的伤害，并减少内力20%。',2,1,4}	 --达摩
    CC.PTFSM[576] = {'十三绝神僧','少林寺武学无条件修炼。',2,1,4}	 --玄澄
    CC.PTFSM[575] = {'仙剑神猿','等待时自动蓄力（无法触发龙象蓄力等效果），使用剑系武功攻击时必连击，猿公剑法威力+500。',2,1,4}	 --白猿
    CC.PTFSM[574] = {'寒露清梦','特色指令：云梦,可自由切换第一格武功为寒袖拂穴/白虹掌力。*【福缘际遇】灵鹫宫获得八荒六合功第三格洗小无相功。天内洗小无相功,灵鹫宫获得八荒六合功第四格洗八荒六合功。可以选择天内是否洗八荒六合功。',2,1,3}   --萧玲
    CC.PTFSM[573] = {'少林高僧','少林武功连击率+20%，暴击率+20%。',2,1,2}   --觉远
    CC.PTFSM[572] = {'镇远镖头','防御力提升80点。',2,1,2}   --韩文冲
    CC.PTFSM[571] = {'总舵主','我方每存活一人，增加+5%攻击力。',2,1,3}   --于万亭
    CC.PTFSM[570] = {'武当高手','武当派武功连击率+10%，连击率+10%。',2,1,3}   --陆菲青
    CC.PTFSM[569] = {'小魔女','敌方气攻伤害减少20%,敌方命中减10%。*【福缘际遇】获得柔云剑法/无极玄功拳，第一/二格洗对应武功,获得纯阳无极功第三格洗梯云纵，天轻洗梯云纵。',2,1,3}   --李沅芷  
    CC.PTFSM[568] = {'岳家将','岳家枪法和岳王散手威力+300。岳家枪法攻击必命中，必连击，岳王散手攻击必暴击，必封穴。',2,1,4}   --岳云   
    CC.PTFSM[567] = {'铁掌宗师','铁掌威力+500。',2,1,3}   --上官剑南
    CC.PTFSM[566] = {'白衣书生','萧中慧在场，攻防提各提升100,夫妻刀法威力增加300,闪避+300。*【福缘际遇】获得《夫妻刀法》第二格洗夫妻刀法。',2,1,3}   --袁冠南
    CC.PTFSM[565] = {'十里坡剑神','每行动一次，攻击效果提升1%',2,1,3}   --卓不凡  
    CC.PTFSM[564] = {'标主占用','',2,1,0}   --标主占用  
    CC.PTFSM[563] = {'标主占用','',2,1,0}   --标主占用      
    CC.PTFSM[562] = {'标主占用','',2,1,0}   --标主占用  
    CC.PTFSM[561] = {'标主占用','',2,1,0}   --标主占用  
    CC.PTFSM[560] = {'标主占用','',2,1,0}   --标主占用  
    CC.PTFSM[559] = {'标主占用','',2,1,0}   --标主占用  
    CC.PTFSM[558] = {'标主占用','',2,1,0}   --标主占用  
    CC.PTFSM[557] = {'标主占用','',2,1,0}   --标主占用  
    CC.PTFSM[556] = {'标主占用','',2,1,0}   --标主占用  
    CC.PTFSM[555] = {'标主占用','',2,1,0}   --标主占用  
    CC.PTFSM[554] = {'标主占用','',2,1,0}   --标主占用     
    CC.PTFSM[553] = {'标主占用','',2,1,0}   --标主占用  
    CC.PTFSM[552] = {'标主占用','',2,1,0}   --标主占用  
    CC.PTFSM[551] = {'标主占用','',2,1,0}   --标主占用  
    CC.PTFSM[550] = {'标主占用','',2,1,0}   --标主占用  
    CC.PTFSM[549] = {'标主占用','',2,1,0}   --标主占用  
    CC.PTFSM[548] = {'标主占用','',2,1,0}   --标主占用  
    CC.PTFSM[547] = {'标主占用','',2,1,0}   --标主占用  
    CC.PTFSM[546] = {'风中之神','轻功成长加倍，装备附加的轻功和集气加成双倍。',2,1,4}   --聂风  
    CC.PTFSM[545] = {'望雪颦愁','被男性攻击时，免疫连击伤害，免疫暴击增加的伤害。',2,1,3}   --苗若兰   
    CC.PTFSM[544] = {'少林高手','少林武学连击率+10%，暴击率+10%。',2,1,2}   --本因
    CC.PTFSM[543] = {'少林高手','少林武学连击率+10%，暴击率+10%。',2,1,2}   --本观
    CC.PTFSM[542] = {'少林高手','少林武学连击率+10%，暴击率+10%。',2,1,2}   --本相    
    CC.PTFSM[541] = {'少林高手','少林武学连击率+10%，暴击率+10%。',2,1,2}   --本参
    CC.PTFSM[540] = {'少林高手','少林武学连击率+10%，暴击率+10%。',2,1,2}   --本尘
    CC.PTFSM[539] = {'','',2,1,2}   --备用
    CC.PTFSM[538] = {'武当高手','武当派武功连击率+20%，暴击率+20%。',2,1,2}   --宋远桥
    CC.PTFSM[537] = {'武当高手','武当派武功连击率+20%，暴击率+20%。',2,1,2}   --俞莲舟
    CC.PTFSM[536] = {'武当高手','武当派武功连击率+20%，暴击率+20%。',2,1,2}   --俞岱巖
    CC.PTFSM[535] = {'武当高手','武当派武功连击率+20%，暴击率+20%。',2,1,2}   --张溪松
    CC.PTFSM[534] = {'武当高手','武当派武功连击率+20%，暴击率+20%。',2,1,2}   --张翠山
    CC.PTFSM[533] = {'武当高手','武当派武功连击率+20%，暴击率+20%。',2,1,2}   --殷梨亭
    CC.PTFSM[532] = {'武当高手','武当派武功连击率+20%，暴击率+20%。',2,1,2}   --莫声谷   
    CC.PTFSM[531] = {'','',2,1,0}   --川崎时盛
    CC.PTFSM[530] = {'','',2,1,0}   --上泉信纲
    CC.PTFSM[529] = {'','',2,1,0}   --钟卷自斋
    CC.PTFSM[528] = {'','',2,1,0}   --片山久安
    CC.PTFSM[527] = {'','',2,1,0}   --小野忠明
    CC.PTFSM[526] = {'','',2,1,0}   --小野善鬼
    CC.PTFSM[525] = {'华山弟子','华山派武功连击率+10%，暴击率+10%。可额外选择两个天赋。',2,1,1}   --华山主角   
    CC.PTFSM[524] = {'逍遥弟子','逍遥派武功连击率+10%，暴击率+10%。可额外选择两个天赋。',2,1,1}   --逍遥主角
    CC.PTFSM[523] = {'密宗弟子','密宗武功连击率+10%，暴击率+10%。可额外选择两个天赋。',2,1,1}   --密宗主角
    CC.PTFSM[522] = {'天机弟子','天机宫武功连击率+10%，暴击率+10%。可额外选择两个天赋。',2,1,1}   --天机主角
    CC.PTFSM[521] = {'星宿弟子','星宿派武功连击率+10%，暴击率+10%。可额外选择两个天赋。',2,1,1}   --星宿主角
    CC.PTFSM[520] = {'天龙弟子','天龙寺武功连击率+10%，暴击率+10%。可额外选择两个天赋。',2,1,1}   --天龙主角
    CC.PTFSM[519] = {'丐帮弟子','丐帮武功连击率+10%，暴击率+10%。可额外选择两个天赋。',2,1,1}   --丐帮主角
    CC.PTFSM[518] = {'血刀弟子','血刀门武功连击率+10%，暴击率+10%。可额外选择两个天赋。',2,1,1}   --血刀主角
    CC.PTFSM[517] = {'武当弟子','可额外选择两个天赋。',2,1,1}   --武当主角    
    CC.PTFSM[516] = {'少林弟子','少林派武功连击率+10%，暴击率+10%。完成师门任务可获得三个天赋。',2,1,3}   --少林主角 虚镜
    CC.PTFSM[515] = {'锅王之王','被攻击时25%几率免疫攻击，被攻击时25%几率由其他目标承受伤害，攻击时25%几率由电饭锅替目标承受伤害，烹饪料理可获得双倍食物。',2,1,4}   --电饭锅
    CC.PTFSM[514] = {'魔刀千刃','战斗中首次被击退可复活一次，变身首席暗影刺客，立即行动*第一格武功变为魔刀千刃，无视敌方50%防御和系数*如击退至少一名敌方，则可再次行动。',2,1,4}   --五六柒
    CC.PTFSM[513] = {'破剑八刀','每间隔50时序触发一次，反弹双倍伤害，持续50时序。',2,1,4}   --卫栖梧
    CC.PTFSM[512] = {'','',2,1,4}   --心魔
    CC.PTFSM[511] = {'盗圣','移动距离增加2格，攻击时随机窃取敌方一项可用状态，若为通用状态则可转给自身。拥有龟息功全部效果。',2,1,4}   --白展堂
    CC.PTFSM[510] = {'曲径通幽','30%持瑶琴威力翻倍，攻击时30%概率触发“曲径通幽”必中。',2,1,2}   --曲非烟
    CC.PTFSM[509] = {'少林高手','少林武学连击率+10%，暴击率+10%。',2,1,2}   --大痴
    CC.PTFSM[508] = {'琅琊公子','战斗中可以自由切换林殊/梅长苏两个身份。',2,1,3}   --林殊
    CC.PTFSM[507] = {'琅琊公子','战斗中可以自由切换林殊/梅长苏两个身份。',2,1,3}   --梅长苏
    CC.PTFSM[506] = {'天地双尊','攻击与防御时敌方任何攻击系数都视为0。攻南时无视目标50%防御。（未实装）',2,1,4}   --北丑
    CC.PTFSM[505] = {'佛道双修','武当少林的武功可无条件修炼。',2,1,3}   --徐子陵
    CC.PTFSM[504] = {'秘剑诡姬','剑术攻击概率不消耗能量。',2,1,2}   --诡剑
    CC.PTFSM[503] = {'武当弟子','武当派武学气攻追加500点。',2,1,3}   --清风 武当天赋1
    CC.PTFSM[502] = {'白衣书生','闪避+300。',2,1,3}   --备用
    CC.PTFSM[501] = {'东瀛剑魔','攻击的目标不会增加怒气。',2,1,3}   --谢云流
    CC.PTFSM[500] = {'剑道巅峰','击败谢云流领悟“剑道巅峰 五方行尽”，概率再行动一次。',2,1,4}   --西门吹雪
    CC.PTFSM[499] = {'剑绝天南','使用六脉神剑必触发【剑气碧烟横】，内力上限9999。',2,1,4}   --段思平   
    CC.PTFSM[498] = {'小李探花','敌人移动-1，自身移动+2,30%躲避攻击,战斗胜利获得暗器,7书领悟暗器为范围攻击。特色指令：【飞刀】100时序暗器攻击”暴击3~5倍，华山觉醒后20%暴击5倍~10倍，攻击必命中，每次开启消耗体力20，内力1000。',2,1,4}   --李寻欢 
    CC.PTFSM[497] = {'金刚门人','攻击时为自己添加一个100时序“金刚法相”增益BUFF，攻击机率触发大金刚神力，无视绝对气防+1000气攻。',2,1,4}   --陆渐    
    CC.PTFSM[496] = {'少林铜人','少林派武功连击率+20%，暴击率+20%。',2,1,2}   --少林铜人
    CC.PTFSM[495] = {'少林铜人','少林派武功连击率+20%，暴击率+20%。',2,1,2}   --少林铜人
    CC.PTFSM[494] = {'少林铜人','少林派武功连击率+20%，暴击率+20%。',2,1,2}   --少林铜人
    CC.PTFSM[493] = {'少林铜人','少林派武功连击率+20%，暴击率+20%。',2,1,2}   --少林铜人
    CC.PTFSM[492] = {'少林铜人','少林派武功连击率+20%，暴击率+20%。',2,1,2}   --少林铜人
    CC.PTFSM[491] = {'少林铜人','少林派武功连击率+20%，暴击率+20%。',2,1,2}   --少林铜人
    CC.PTFSM[490] = {'少林铜人','少林派武功连击率+20%，暴击率+20%。',2,1,2}   --少林铜人
    CC.PTFSM[489] = {'少林铜人','少林派武功连击率+20%，暴击率+20%。',2,1,2}   --少林铜人
    CC.PTFSM[488] = {'少林铜人','少林派武功连击率+20%，暴击率+20%。',2,1,2}   --少林铜人
    CC.PTFSM[487] = {'少林铜人','少林派武功连击率+20%，暴击率+20%。',2,1,2}   --少林铜人
    CC.PTFSM[486] = {'少林铜人','少林派武功连击率+20%，暴击率+20%。',2,1,2}   --少林铜人
    CC.PTFSM[485] = {'少林铜人','少林派武功连击率+20%，暴击率+20%。',2,1,2}   --少林铜人
    CC.PTFSM[484] = {'少林铜人','少林派武功连击率+20%，暴击率+20%。',2,1,2}   --少林铜人
    CC.PTFSM[483] = {'少林铜人','少林派武功连击率+20%，暴击率+20%。',2,1,2}   --少林铜人
    CC.PTFSM[482] = {'少林铜人','少林派武功连击率+20%，暴击率+20%。',2,1,2}   --少林铜人
    CC.PTFSM[481] = {'少林铜人','少林派武功连击率+20%，暴击率+20%。',2,1,2}   --少林铜人
    CC.PTFSM[480] = {'少林铜人','少林派武功连击率+20%，暴击率+20%。',2,1,2}   --少林铜人
    CC.PTFSM[479] = {'少林执事','少林派武功连击率+20%，暴击率+20%。',2,1,2}   --少林铜人 少林门派天赋3
    CC.PTFSM[478] = {'少林木人','少林派武功连击率+10%，暴击率+10%。',2,1,2}   --少林木人
    CC.PTFSM[477] = {'少林木人','少林派武功连击率+10%，暴击率+10%。',2,1,2}   --少林木人
    CC.PTFSM[476] = {'少林木人','少林派武功连击率+10%，暴击率+10%。',2,1,2}   --少林木人
    CC.PTFSM[475] = {'少林木人','少林派武功连击率+10%，暴击率+10%。',2,1,2}   --少林木人
    CC.PTFSM[474] = {'少林木人','少林派武功连击率+10%，暴击率+10%。',2,1,2}   --少林木人
    CC.PTFSM[473] = {'少林木人','少林派武功连击率+10%，暴击率+10%。',2,1,2}   --少林木人
    CC.PTFSM[472] = {'少林木人','少林派武功连击率+10%，暴击率+10%。',2,1,2}   --少林木人
    CC.PTFSM[471] = {'少林木人','少林派武功连击率+10%，暴击率+10%。',2,1,2}   --少林木人
	CC.PTFSM[470] = {'少林木人','少林派武功连击率+10%，暴击率+10%。',2,1,2}   --少林木人
    CC.PTFSM[469] = {'少林木人','少林派武功连击率+10%，暴击率+10%。',2,1,2}   --少林木人
    CC.PTFSM[468] = {'少林木人','少林派武功连击率+10%，暴击率+10%。',2,1,2}   --少林木人
    CC.PTFSM[467] = {'少林木人','少林派武功连击率+10%，暴击率+10%。',2,1,2}   --少林木人
    CC.PTFSM[466] = {'少林木人','少林派武功连击率+10%，暴击率+10%。',2,1,2}   --少林木人
    CC.PTFSM[465] = {'少林木人','少林派武功连击率+10%，暴击率+10%。',2,1,2}   --少林木人
    CC.PTFSM[464] = {'少林木人','少林派武功连击率+10%，暴击率+10%。',2,1,2}   --少林木人
    CC.PTFSM[463] = {'少林木人','少林派武功连击率+10%，暴击率+10%。',2,1,2}   --少林木人
    CC.PTFSM[462] = {'少林木人','少林派武功连击率+10%，暴击率+10%。',2,1,2}   --少林木人
    CC.PTFSM[461] = {'少林精英','少林派武功连击率+10%，暴击率+10%。',2,2,2}   --少林木人 少林门派天赋2
    CC.PTFSM[460] = {'王氏门人','五虎断门刀命中+100。',2,1,2}   --王氏门人   
    CC.PTFSM[459] = {'烈火燎原','降龙十八掌格档率+200。',2,1,2}   --史火龙
    CC.PTFSM[458] = {'风激云扬','降龙十八掌命中率+200。',2,1,2}   --解风
    CC.PTFSM[457] = {'剑中剑','剑法武功增加100%。',2,1,2}   --邱莫言
    CC.PTFSM[456] = {'赛西施','行动概率魅惑敌人。',2,1,2}   --金镶玉
    CC.PTFSM[455] = {'伞中剑','剑法武功增加100%。',2,1,2}   --周淮安
    CC.PTFSM[454] = {'青龙门掌门','奇门武功气攻+500',2,1,2}   --风良
    CC.PTFSM[453] = {'畔快刀掌门','使用刀法气攻+500',2,1,2}   --吕正平
    CC.PTFSM[452] = {'鹤笔门掌门','奇门武功气攻+500',2,1,2}   --范一飞
    CC.PTFSM[451] = {'万马庄主','坐骑附加的属性双倍。',2,1,2}   --高三娘
    CC.PTFSM[450] = {'追风锁命','每点轻功增加0.3点攻击力。',2,1,3}   --追命
    CC.PTFSM[449] = {'冷血人狼','不可闪避，必命中。',2,1,3}   --冷血
    CC.PTFSM[448] = {'千手神针','攻击必命中，距离越远伤害越高。',2,1,3}   --无情
    CC.PTFSM[447] = {'“一以贯之','攻击范围内只有一个目标时，伤害增加%50。',2,1,3}   --铁手
    CC.PTFSM[446] = {'御林军','已方人数越多，攻击力和防御力越高。',2,1,2}   --带刀官兵
    CC.PTFSM[445] = {'御林军','已方人数越多，攻击力和防御力越高。',2,1,2}   --带刀官兵
    CC.PTFSM[444] = {'御林军','已方人数越多，攻击力和防御力越高。',2,1,2}   --长枪官兵
    CC.PTFSM[443] = {'御林军','已方人数越多，攻击力和防御力越高。',2,1,2}   --御前侍卫
    CC.PTFSM[442] = {'御林军','已方人数越多，攻击力和防御力越高。',2,1,2}   --御前侍卫   
    CC.PTFSM[441] = {'御林军','已方人数越多，攻击力和防御力越高。',2,1,2}   --长枪官兵
    CC.PTFSM[440] = {'火蟾','攻击带毒+100，必灼烧。',2,1,3}   --火蟾
    CC.PTFSM[439] = {'采雪蛛','攻击带毒+100。',2,1,1}   --采雪蛛   
    CC.PTFSM[438] = {'采雪蛛','攻击带毒+100。',2,1,1}   --采雪蛛       
    CC.PTFSM[437] = {'采雪蛛','攻击带毒+100。',2,1,1}   --采雪蛛   
    CC.PTFSM[436] = {'采雪蛛','攻击带毒+100。',2,1,1}   --采雪蛛   
    CC.PTFSM[435] = {'采雪蛛','攻击带毒+100。',2,1,1}   --采雪蛛   
    CC.PTFSM[434] = {'采雪蛛','攻击带毒+100。',2,1,1}   --采雪蛛   
    CC.PTFSM[433] = {'采雪蛛','攻击带毒+100。',2,1,1}   --采雪蛛   
    CC.PTFSM[432] = {'采雪蛛','攻击带毒+100。',2,1,1}   --采雪蛛   
    CC.PTFSM[431] = {'采雪蛛','攻击带毒+100。',2,1,1}   --采雪蛛   
    CC.PTFSM[430] = {'采雪蛛','攻击带毒+100。',2,1,1}   --采雪蛛     
    CC.PTFSM[429] = {'大雪怪','攻击必冰封。免疫冰封。',2,1,2}   --大雪怪  
    CC.PTFSM[428] = {'大雪怪','攻击必冰封。免疫冰封。',2,1,2}   --大雪怪  
    CC.PTFSM[427] = {'大雪怪','攻击必冰封。免疫冰封。',2,1,2}   --大雪怪     
    CC.PTFSM[426] = {'大雪怪','攻击必冰封。免疫冰封。',2,1,2}   --大雪怪  
    CC.PTFSM[425] = {'大雪怪','攻击必冰封。免疫冰封。',2,1,2}   --大雪怪  
    CC.PTFSM[424] = {'大雪怪','攻击必冰封。免疫冰封。',2,1,2}   --大雪怪    
    CC.PTFSM[423] = {'大雪怪','攻击必冰封。免疫冰封。',2,1,2}   --大雪怪  
    CC.PTFSM[422] = {'大雪怪','攻击必冰封。免疫冰封。',2,1,2}   --大雪怪  
    CC.PTFSM[421] = {'大雪怪','攻击必冰封。免疫冰封。',2,1,2}   --大雪怪  
    CC.PTFSM[420] = {'千年雪怪','攻击必冰封。免疫冰封。',2,1,3}   --千年雪怪    
    CC.PTFSM[419] = {'大莽蛇','攻击带毒+200。',2,1,1}   --大莽蛇 
    CC.PTFSM[418] = {'毒蛇','攻击带毒+100。',2,1,1}   --毒蛇 
    CC.PTFSM[417] = {'毒蛇','攻击带毒+100。',2,1,1}   --毒蛇 
    CC.PTFSM[416] = {'毒蛇','攻击带毒+100。',2,1,1}   --毒蛇 
    CC.PTFSM[415] = {'毒蛇','攻击带毒+100。',2,1,1}   --毒蛇 
    CC.PTFSM[414] = {'毒蛇','攻击带毒+100。',2,1,1}   --毒蛇     
    CC.PTFSM[413] = {'毒蛇','攻击带毒+100。',2,1,1}   --毒蛇 
    CC.PTFSM[412] = {'毒蛇','攻击带毒+100。',2,1,1}   --毒蛇 
    CC.PTFSM[411] = {'毒蛇','攻击带毒+100。',2,1,1}   --毒蛇 
    CC.PTFSM[410] = {'毒蛇','攻击带毒+100。',2,1,1}   --毒蛇   
    CC.PTFSM[409] = {'少林弟子','少林武学气攻追加500点。',2,1,1}   --少林弟子
    CC.PTFSM[408] = {'少林弟子','少林武学气攻追加500点。',2,1,1}   --少林弟子
    CC.PTFSM[407] = {'少林弟子','少林武学气攻追加500点。',2,1,1}   --少林弟子
    CC.PTFSM[406] = {'少林弟子','少林武学气攻追加500点。',2,1,1}   --少林弟子
    CC.PTFSM[405] = {'少林弟子','少林武学气攻追加500点。',2,1,1}   --少林弟子
    CC.PTFSM[404] = {'少林弟子','少林武学气攻追加500点。',2,1,1}   --少林弟子
    CC.PTFSM[403] = {'少林弟子','少林武学气攻追加500点。',2,1,1}   --少林弟子
    CC.PTFSM[402] = {'少林弟子','少林武学气攻追加500点。',2,1,1}   --少林弟子
    CC.PTFSM[401] = {'少林弟子','少林武学气攻追加500点。',2,1,1}   --少林弟子
    CC.PTFSM[400] = {'少林弟子','少林武学气攻追加500点。',2,2,1}   --虚空 少林门派天赋1
    CC.PTFSM[399] = {'神龙弟子','',2,1,1}   --神龍教徒
    CC.PTFSM[398] = {'神龙弟子','',2,1,1}   --神龍教徒
    CC.PTFSM[397] = {'神龙弟子','',2,1,1}   --神龍教徒
    CC.PTFSM[396] = {'神龙弟子','',2,1,1}   --神龍教徒
    CC.PTFSM[395] = {'神龙弟子','',2,1,1}   --神龍教徒
    CC.PTFSM[394] = {'神龙弟子','',2,1,1}   --神龍教徒
    CC.PTFSM[393] = {'神龙弟子','',2,1,1}   --神龍教徒
    CC.PTFSM[392] = {'神龙弟子','',2,1,1}   --神龍教徒
    CC.PTFSM[391] = {'神龙弟子','',2,1,1}   --神龍教徒
    CC.PTFSM[390] = {'神龙弟子','',2,1,1}   --神龍教徒     
    CC.PTFSM[389] = {'恒山长老','恒山派武学连击率+20%,暴击率+20%。',2,1,1}   --定逸  
    CC.PTFSM[388] = {'恒山长老','恒山派武学连击率+20%,暴击率+20%。',2,1,1}   --定静  
    CC.PTFSM[387] = {'晓风残月','恒山派武学连击率+40%,暴击率+40%。恒山武学威力+500。',2,1,1}   --晓风师太  
    CC.PTFSM[386] = {'恒山长老','恒山派武学连击率+20%,暴击率+20%。',2,1,1}   --郑萼  
    CC.PTFSM[385] = {'恒山弟子','恒山武学气攻追加500点。',2,1,1}   --仪清  
    CC.PTFSM[384] = {'恒山弟子','恒山武学气攻追加500点。',2,1,1}   --仪光  
    CC.PTFSM[383] = {'恒山弟子','恒山武学气攻追加500点。',2,1,1}   --仪质  
    CC.PTFSM[382] = {'恒山弟子','恒山武学气攻追加500点。',2,1,1}   --仪敏  
    CC.PTFSM[381] = {'恒山弟子','恒山武学气攻追加500点。',2,1,1}   --仪文  
    CC.PTFSM[380] = {'恒山弟子','恒山武学气攻追加500点。',2,1,1}   --仪和    
    CC.PTFSM[379] = {'风歌气正','衡山派武学连击率+40%,暴击率+40%。衡山武学威力+500。',2,1,3}   --刘正风 
    CC.PTFSM[378] = {'衡山长老','衡山派武学连击率+20%,暴击率+20%。',2,1,2}   --鲁连荣 
    CC.PTFSM[377] = {'衡山长老','衡山派武学连击率+20%,暴击率+20%。',2,1,2}   --方千驹 
    CC.PTFSM[376] = {'衡山长老','衡山派武学连击率+20%,暴击率+20%。',2,1,2}   --萧阳山 
    CC.PTFSM[375] = {'衡山弟子','衡山武学气攻追加500点。',2,1,1}   --方千驹 
    CC.PTFSM[374] = {'衡山弟子','衡山武学气攻追加500点。',2,1,1}   --莫太冲 
    CC.PTFSM[373] = {'衡山弟子','衡山武学气攻追加500点。',2,1,1}   --莫小宝 
    CC.PTFSM[372] = {'衡山弟子','衡山武学气攻追加500点。',2,1,1}   --莫小贝 
    CC.PTFSM[371] = {'衡山弟子','衡山武学气攻追加500点。',2,1,1}   --向大年 
    CC.PTFSM[370] = {'衡山弟子','衡山武学气攻追加500点。',2,1,1}   --米为义 
    CC.PTFSM[369] = {'华山弟子','华山武学气攻追加500点。',2,1,1}   --梁发 
    CC.PTFSM[368] = {'华山弟子','华山武学气攻追加500点。',2,1,1}   --劳德诺 
    CC.PTFSM[367] = {'华山弟子','华山武学气攻追加500点。',2,1,1}   --施戴子 
    CC.PTFSM[366] = {'华山弟子','华山武学气攻追加500点。',2,1,1}   --高根明 
    CC.PTFSM[365] = {'华山弟子','华山武学气攻追加500点。',2,1,1}   --陆大有 
    CC.PTFSM[364] = {'华山弟子','华山武学气攻追加500点。',2,1,1}   --陶钧 
    CC.PTFSM[363] = {'华山弟子','华山武学气攻追加500点。',2,1,1}   --孙仲君 
    CC.PTFSM[362] = {'华山弟子','华山武学气攻追加500点。',2,1,1}   --归锺 
    CC.PTFSM[361] = {'华山弟子','华山武学气攻追加500点。',2,1,1}   --舒奇 
    CC.PTFSM[360] = {'华山弟子','华山武学气攻追加500点。',2,1,1}   --英白罗 
    CC.PTFSM[359] = {'崆峒掌门','崆峒派武学连击率+40%,暴击率+40%。崆峒武学威力+500。',2,1,3}   --木灵子   
    CC.PTFSM[358] = {'崆峒长老','崆峒派武学连击率+20%,暴击率+20%。',2,1,2}   --萧遥
    CC.PTFSM[357] = {'崆峒长老','崆峒派武学连击率+20%,暴击率+20%。',2,1,2}   --关能
    CC.PTFSM[356] = {'崆峒弟子','崆峒武学气攻追加500点。',2,1,1}   --简捷
    CC.PTFSM[355] = {'崆峒弟子','崆峒武学气攻追加500点。',2,1,1}   --冯远声
    CC.PTFSM[354] = {'崆峒弟子','崆峒武学气攻追加500点。',2,1,1}   --寇平
    CC.PTFSM[353] = {'崆峒弟子','崆峒武学气攻追加500点。',2,1,1}   --胡豹
    CC.PTFSM[352] = {'崆峒弟子','崆峒武学气攻追加500点。',2,1,1}   --欧阳后成
    CC.PTFSM[351] = {'崆峒弟子','崆峒武学气攻追加500点。',2,1,1}   --董禄堂
    CC.PTFSM[350] = {'崆峒弟子','崆峒武学气攻追加500点。',2,1,1}   --郭春萍
    CC.PTFSM[349] = {'昆仑高手','昆仑派武学连击率+20%,暴击率+20%。',2,1,3}   --白鹿子
    CC.PTFSM[348] = {'昆仑高手','昆仑派武学连击率+20%,暴击率+20%。',2,1,1}   --震山子
    CC.PTFSM[347] = {'昆仑高手','昆仑派武学连击率+20%,暴击率+20%。',2,1,1}   --玉虚道长
    CC.PTFSM[346] = {'昆仑高手','昆仑派武学连击率+20%,暴击率+20%。',2,1,1}   --谭迪人
    CC.PTFSM[345] = {'昆仑高手','昆仑派武学连击率+20%,暴击率+20%。',2,1,1}   --蒋立涛
    CC.PTFSM[344] = {'昆仑高手','昆仑派武学连击率+20%,暴击率+20%。',2,1,1}   --高则成
    CC.PTFSM[343] = {'昆化弟子','昆化派武学气攻追加500点。',2,1,1}   --卫四娘
    CC.PTFSM[342] = {'昆化弟子','昆化派武学气攻追加500点。',2,1,1}   --西华子
    CC.PTFSM[341] = {'昆化弟子','昆化派武学气攻追加500点。',2,1,1}   --苏习之
    CC.PTFSM[340] = {'昆化弟子','昆化派武学气攻追加500点。',2,1,1}   --詹春
    CC.PTFSM[339] = {'峨眉弟子','峨眉派武学气攻追加500点。',2,1,1}   --峨眉弟子
    CC.PTFSM[338] = {'峨眉弟子','峨眉派武学气攻追加500点。',2,1,1}   --峨眉弟子
    CC.PTFSM[337] = {'峨眉弟子','峨眉派武学气攻追加500点。',2,1,1}   --峨眉弟子
    CC.PTFSM[336] = {'峨眉弟子','峨眉派武学气攻追加500点。',2,1,1}   --峨眉弟子
    CC.PTFSM[335] = {'峨眉弟子','峨眉派武学气攻追加500点。',2,1,1}   --峨眉弟子
    CC.PTFSM[334] = {'峨眉弟子','峨眉派武学气攻追加500点。',2,1,1}   --峨眉弟子
    CC.PTFSM[333] = {'峨眉弟子','峨眉派武学气攻追加500点。',2,1,1}   --峨眉弟子
    CC.PTFSM[332] = {'峨眉弟子','峨眉派武学气攻追加500点。',2,1,1}   --峨眉弟子
    CC.PTFSM[331] = {'峨眉弟子','峨眉派武学气攻追加500点。',2,1,1}   --峨眉弟子
    CC.PTFSM[330] = {'峨眉弟子','峨眉派武学气攻追加500点。',2,1,1}   --峨眉弟子   
    CC.PTFSM[329] = {'武当弟子','武当派武学气攻追加500点。',2,1,1}   --武当弟子
    CC.PTFSM[328] = {'武当弟子','武当派武学气攻追加500点。',2,1,1}   --武当弟子
    CC.PTFSM[327] = {'武当弟子','武当派武学气攻追加500点。',2,1,1}   --武当弟子
    CC.PTFSM[326] = {'武当弟子','武当派武学气攻追加500点。',2,1,1}   --武当弟子
    CC.PTFSM[325] = {'武当弟子','武当派武学气攻追加500点。',2,1,1}   --武当弟子
    CC.PTFSM[324] = {'武当弟子','武当派武学气攻追加500点。',2,1,1}   --武当弟子
    CC.PTFSM[323] = {'武当弟子','武当派武学气攻追加500点。',2,1,1}   --武当弟子
    CC.PTFSM[322] = {'武当弟子','武当派武学气攻追加500点。',2,1,1}   --武当弟子
    CC.PTFSM[321] = {'武当弟子','武当派武学气攻追加500点。',2,1,1}   --武当弟子
    CC.PTFSM[320] = {'武当弟子','武当派武学气攻追加500点。',2,1,1}   --武当弟子
    CC.PTFSM[319] = {'关东六魔','攻击时概率直接给敌方造成撕裂效果。',2,1,2}   --阎世章
    CC.PTFSM[318] = {'关东六魔','攻击时概率直接给敌方造成撕裂效果。',2,1,2}   --阎世魁
    CC.PTFSM[317] = {'关东六魔','攻击时概率直接给敌方造成撕裂效果。',2,1,2}   --哈合台
    CC.PTFSM[316] = {'关东六魔','攻击时概率直接给敌方造成撕裂效果。',2,1,2}   --焦文期    
    CC.PTFSM[315] = {'关东六魔','攻击时概率直接给敌方造成撕裂效果。',2,1,2}   --顾金标
    CC.PTFSM[314] = {'关东六魔','攻击时概率直接给敌方造成撕裂效果。',2,1,2}   --滕一雷
    CC.PTFSM[313] = {'佛笑珈蓝','袈裟伏魔功攻击连击率+50%，暴击率+50%。',2,1,2}   --天镜
    CC.PTFSM[312] = {'天山双鹰','三分剑法必定三连，连击伤害降低15%,三分剑法威力+500',2,1,3}   --关明梅
    CC.PTFSM[311] = {'天山双鹰','三分剑法必定三连，连击伤害降低15%,三分剑法威力+500',2,1,3}   --陈正德
    CC.PTFSM[310] = {'五散人','明教武学和江湖武学连击率+20%，暴击率+20%。',2,1,2}   --说不得
    CC.PTFSM[309] = {'五散人','明教武学和江湖武学连击率+20%，暴击率+20%。',2,1,2}   --彭莹玉
    CC.PTFSM[308] = {'五散人','明教武学和江湖武学连击率+20%，暴击率+20%。战场可使用指令【天变】改变天气。',2,1,3}   --张中
    CC.PTFSM[307] = {'五散人','明教武学和江湖武学连击率+20%，暴击率+20%。',2,1,2}   --冷谦
    CC.PTFSM[306] = {'五散人','明教武学和江湖武学连击率+20%，暴击率+20%。',2,1,2}   --周颠    
    CC.PTFSM[305] = {'锐金旗使','明教武学和江湖武学气攻追加500点，攻击必流血。',2,1,2}   --庄铮  
    CC.PTFSM[304] = {'巨木旗使','明教武学和江湖武学气攻追加500点，免疫流血。',2,1,2}   --闻苍松  
    CC.PTFSM[303] = {'洪水旗使','明教武学和江湖武学气攻追加500点，免疫灼烧。',2,1,2}   --唐洋  
    CC.PTFSM[302] = {'烈火旗使','明教武学和江湖武学气攻追加500点，攻击必灼烧。',2,1,2}   --辛燃      
    CC.PTFSM[301] = {'厚土旗使','明教武学和江湖武学气攻追加500点，受到的伤害减少15%。',2,1,2}   --颜垣   
    CC.PTFSM[300] = {'全真弟子','全真教武学气攻追加500点。',2,1,1}   --全真弟子  
    CC.PTFSM[299] = {'全真弟子','全真教武学气攻追加500点。',2,1,1}   --全真弟子  
    CC.PTFSM[298] = {'全真弟子','全真教武学气攻追加500点。',2,1,1}   --全真弟子  
    CC.PTFSM[297] = {'全真弟子','全真教武学气攻追加500点。',2,1,1}   --全真弟子  
    CC.PTFSM[296] = {'全真弟子','全真教武学气攻追加500点。',2,1,1}   --全真弟子  
    CC.PTFSM[295] = {'全真弟子','全真教武学气攻追加500点。',2,1,1}   --全真弟子  
    CC.PTFSM[294] = {'全真弟子','全真教武学气攻追加500点。',2,1,1}   --全真弟子  
    CC.PTFSM[293] = {'全真弟子','全真教武学气攻追加500点。',2,1,1}   --全真弟子  
    CC.PTFSM[292] = {'全真弟子','全真教武学气攻追加500点。',2,1,1}   --全真弟子    
    CC.PTFSM[291] = {'全真弟子','全真教武学气攻追加500点。',2,1,1}   --姬清虚    
    CC.PTFSM[290] = {'铁掌帮众','铁掌气攻追加500点。',2,1,1}   --铁掌帮众
    CC.PTFSM[289] = {'铁掌帮众','铁掌气攻追加500点。',2,1,1}   --铁掌帮众
    CC.PTFSM[288] = {'铁掌帮众','铁掌气攻追加500点。',2,1,1}   --铁掌帮众
    CC.PTFSM[287] = {'铁掌帮众','铁掌气攻追加500点。',2,1,1}   --铁掌帮众
    CC.PTFSM[286] = {'铁掌帮众','铁掌气攻追加500点。',2,1,1}   --铁掌帮众
    CC.PTFSM[285] = {'铁掌帮众','铁掌气攻追加500点。',2,1,1}   --铁掌帮众
    CC.PTFSM[284] = {'铁掌帮众','铁掌气攻追加500点。',2,1,1}   --铁掌帮众
    CC.PTFSM[283] = {'铁掌帮众','铁掌气攻追加500点。',2,1,1}   --铁掌帮众
    CC.PTFSM[282] = {'铁掌帮众','铁掌气攻追加500点。',2,1,1}   --铁掌帮众
    CC.PTFSM[281] = {'铁掌帮众','铁掌气攻追加500点。',2,1,1}   --铁掌帮众
    CC.PTFSM[280] = {'丐帮副帮主','丐帮武学连击率+20%，暴击率+20%。',2,1,2}   --马大元
    CC.PTFSM[279] = {'丐帮长老','丐帮武学连击率+20%，暴击率+20%。',2,1,2}   --白世镜
    CC.PTFSM[278] = {'丐帮长老','丐帮武学连击率+20%，暴击率+20%。',2,1,2}   --奚山河
    CC.PTFSM[277] = {'丐帮长老','丐帮武学连击率+20%，暴击率+20%。',2,1,2}   --陈孤雁
    CC.PTFSM[276] = {'丐帮长老','丐帮武学连击率+20%，暴击率+20%。',2,1,2}   --吴长风
    CC.PTFSM[275] = {'丐帮长老','丐帮武学连击率+20%，暴击率+20%。',2,1,2}   --徐冲霄
    CC.PTFSM[274] = {'丐帮长老','丐帮武学连击率+20%，暴击率+20%。',2,1,2}   --方东白
    CC.PTFSM[273] = {'丐帮长老','丐帮武学连击率+20%，暴击率+20%。',2,1,2}   --黎生
    CC.PTFSM[272] = {'丐帮长老','丐帮武学连击率+20%，暴击率+20%。',2,1,2}   --吴六奇
    CC.PTFSM[271] = {'丐帮长老','丐帮武学连击率+20%，暴击率+20%。',2,1,2}   --全冠清
    CC.PTFSM[270] = {'星宿弟子','星宿武学追加500点杀气。',2,1,1}   --采花子
    CC.PTFSM[269] = {'星宿弟子','星宿武学追加500点杀气。',2,1,1}   --毒林子
    CC.PTFSM[268] = {'星宿弟子','星宿武学追加500点杀气。',2,1,1}   --出尘子
    CC.PTFSM[267] = {'星宿弟子','星宿武学追加500点杀气。',2,1,1}   --物林子
    CC.PTFSM[266] = {'星宿弟子','星宿武学追加500点杀气。',2,1,1}   --狮鼻子
    CC.PTFSM[265] = {'星宿弟子','星宿武学追加500点杀气。',2,1,1}   --追风子
    CC.PTFSM[264] = {'星宿弟子','星宿武学追加500点杀气。',2,1,1}   --摩云子
    CC.PTFSM[263] = {'星宿弟子','星宿武学追加500点杀气。',2,1,1}   --天狼子
    CC.PTFSM[262] = {'星宿弟子','星宿武学追加500点杀气。',2,1,1}   --狮吼子
    CC.PTFSM[261] = {'星宿弟子','星宿武学追加500点杀气。',2,1,1}   --摘星子
    CC.PTFSM[260] = {'密宗弟子','密宗武学追加500点杀气。',2,1,1}   --番僧 
    CC.PTFSM[259] = {'密宗弟子','密宗武学追加500点杀气。',2,1,1}   --番僧 
    CC.PTFSM[258] = {'密宗弟子','密宗武学追加500点杀气。',2,1,1}   --番僧 
    CC.PTFSM[257] = {'密宗弟子','密宗武学追加500点杀气。',2,1,1}   --番僧 
    CC.PTFSM[256] = {'密宗弟子','密宗武学追加500点杀气。',2,1,1}   --番僧 
    CC.PTFSM[255] = {'密宗弟子','密宗武学追加500点杀气。',2,1,1}   --番僧 
    CC.PTFSM[254] = {'密宗弟子','密宗武学追加500点杀气。',2,1,1}   --番僧 
    CC.PTFSM[253] = {'密宗弟子','密宗武学追加500点杀气。',2,1,1}   --番僧 
    CC.PTFSM[252] = {'密宗弟子','密宗武学追加500点杀气。',2,1,1}   --番僧 
    CC.PTFSM[251] = {'密宗弟子','密宗武学追加500点杀气。',2,1,1}   --番僧    
    CC.PTFSM[250] = {'雪山掌门','雪山派武功连击率+40%，暴击率+40%。武功威力+400。',2,1,3}   --白自在
    CC.PTFSM[249] = {'金乌翠鸣','金乌刀法威力+400，金乌刀法连击率+30%，暴击率爆+30%。',2,1,3}   --史婆婆
    CC.PTFSM[248] = {'雪山长老','雪山派武功连击率+20%，暴击率+20%。',2,1,2}   --成自学
    CC.PTFSM[247] = {'雪山长老','雪山派武功连击率+20%，暴击率+20%。',2,1,2}   --廖自励
    CC.PTFSM[246] = {'雪山长老','雪山派武功连击率+20%，暴击率+20%。',2,1,2}   --齐自勉
    CC.PTFSM[245] = {'雪山长老','雪山派武功连击率+20%，暴击率+20%。',2,1,2}   --梁自进
    CC.PTFSM[244] = {'雪山长老','雪山派武功连击率+20%，暴击率+20%。',2,1,2}   --封万里
    CC.PTFSM[243] = {'寒梅女侠','雪山派武功追加500点杀气值。',2,1,1}   --花万紫
    CC.PTFSM[242] = {'雪山弟子','雪山派武功追加500点杀气值。',2,1,1}   --耿万锺
    CC.PTFSM[241] = {'雪山弟子','雪山派武功追加500点杀气值。',2,1,1}   --柯万均
    CC.PTFSM[240] = {'魔琴','日月神教武学连击率+20%，暴击率+20%。',2,1,2}   --曲洋
    CC.PTFSM[239] = {'三丧娘','日月神教武学连击率+20%，暴击率+20%。',2,1,2}   --桑三娘
    CC.PTFSM[238] = {'雕侠','日月神教武学连击率+20%，暴击率+20%。',2,1,2}   --上官云
    CC.PTFSM[237] = {'黄面尊者','日月神教武学连击率+20%，暴击率+20%。',2,1,2}   --贾布
    CC.PTFSM[236] = {'风雷大熊','日月神教武学连击率+20%，暴击率+20%。',2,1,2}   --童白熊
    CC.PTFSM[235] = {'蓝砂手','日月神教武学连击率+20%，暴击率+20%。',2,1,2}   --鲍大楚
    CC.PTFSM[234] = {'天王老子','吸血10%,每时序流失3点生命。',2,1,3}   --向问天
    CC.PTFSM[233] = {'日月总管','日月神教武学连击率+20%，暴击率+20%。',2,1,2}   --杨莲亭
    CC.PTFSM[232] = {'色枪','日月神教武学连击率+20%，暴击率+20%。',2,1,2}   --秦伟邦
    CC.PTFSM[231] = {'泼墨长老','日月神教武学连击率+20%，暴击率+20%。',2,1,2}   --王诚
    CC.PTFSM[230] = {'五毒教徒','五毒教武学追加500点杀气值。',2,1,1}   --五毒教徒
    CC.PTFSM[229] = {'五毒教徒','五毒教武学追加500点杀气值。',2,1,1}   --五毒教徒
    CC.PTFSM[228] = {'五毒教徒','五毒教武学追加500点杀气值。',2,1,1}   --五毒教徒
    CC.PTFSM[227] = {'五毒教徒','五毒教武学追加500点杀气值。',2,1,1}   --五毒教徒
    CC.PTFSM[226] = {'五毒教徒','五毒教武学追加500点杀气值。',2,1,1}   --五毒教徒
    CC.PTFSM[225] = {'五毒教徒','五毒教武学追加500点杀气值。',2,1,1}   --五毒教徒
    CC.PTFSM[224] = {'五毒教徒','五毒教武学追加500点杀气值。',2,1,1}   --五毒教徒
    CC.PTFSM[223] = {'五毒教徒','五毒教武学追加500点杀气值。',2,1,1}   --五毒教徒
    CC.PTFSM[222] = {'五毒教徒','五毒教武学追加500点杀气值。',2,1,1}   --五毒教徒
    CC.PTFSM[221] = {'五毒教徒','五毒教武学追加500点杀气值。',2,1,1}   --五毒教徒
    CC.PTFSM[220] = {'青城掌门','青城派武学连击率+40%，暴击率+40%。武功威力+400',2,1,3}   --司马卫
    CC.PTFSM[219] = {'青城长老','青城派武学连击率+20%，暴击率+20%。',2,1,2}   --姜迟
    CC.PTFSM[218] = {'青城长老','青城派武学连击率+20%，暴击率+20%。',2,1,2}   --孟无疆
    CC.PTFSM[217] = {'青城弟子','青城派武学追加500点杀气值。',2,1,1}   --司马林
    CC.PTFSM[216] = {'青城弟子','青城派武学追加500点杀气值。',2,1,1}   --诸保昆
    CC.PTFSM[215] = {'青城弟子','青城派武学追加500点杀气值。',2,1,1}   --贾人达
    CC.PTFSM[214] = {'青城四秀','青城派武学连击率+10%，暴击率+10%。',2,1,2}	 --于人豪
    CC.PTFSM[213] = {'青城四秀','青城派武学连击率+10%，暴击率+10%。',2,1,2}	 --洪人雄
    CC.PTFSM[212] = {'青城四秀','青城派武学连击率+10%，暴击率+10%。',2,1,2}	 --罗人杰
    CC.PTFSM[211] = {'青城四秀','青城派武学连击率+10%，暴击率+10%。',2,1,2}	 --侯人英
    CC.PTFSM[210] = {'泰山长老','泰山派武学连击率+20%，暴击率+20%。',2,1,2}	 --玉几子
    CC.PTFSM[209] = {'泰山长老','泰山派武学连击率+20%，暴击率+20%。',2,1,2}	 --玉音子
    CC.PTFSM[208] = {'泰山长老','泰山派武学连击率+20%，暴击率+20%。',2,1,2}  --玉馨子   
    CC.PTFSM[207] = {'泰山长老','泰山派武学连击率+20%，暴击率+20%。',2,1,2}	 --玉锺子   
    CC.PTFSM[206] = {'泰山弟子','泰山派武学追加500点杀气值。',2,1,1}	 --天乙 
    CC.PTFSM[205] = {'泰山弟子','泰山派武学追加500点杀气值。',2,1,1}	 --天柏 
    CC.PTFSM[204] = {'泰山弟子','泰山派武学追加500点杀气值。',2,1,1}	 --建除 
    CC.PTFSM[203] = {'泰山弟子','泰山派武学追加500点杀气值。',2,1,1}	 --迟百城 
    CC.PTFSM[202] = {'泰山弟子','泰山派武学追加500点杀气值。',2,1,1}	 --东灵道长 
    CC.PTFSM[201] = {'泰山祖师','泰山派武学连击率+50%，暴击率+50%，威力+500。',2,1,3}	 --东灵道长  
    CC.PTFSM[200] = {'白头仙翁','嵩山派武功连击率+20%。',2,1,2}	 --卜沉
    CC.PTFSM[199] = {'大阴阳手','嵩山派武功连击率+20%。',2,1,2}	 --乐厚
    CC.PTFSM[198] = {'大嵩阳手','嵩山派武功连击率+20%。',2,1,2}	 --费彬
    CC.PTFSM[197] = {'托塔手','嵩山派武功连击率+20%。',2,1,2}	 --陆柏  
    CC.PTFSM[196] = {'铁阎王','嵩山派武功连击率+20%。',2,1,2}	 --汤英鳄
    CC.PTFSM[195] = {'托塔手','嵩山派武功连击率+20%。',2,1,2}	 --丁勉
    CC.PTFSM[194] = {'嵩山弟子','嵩山派武学追加500点杀气值。',2,1,1}	 --高克新
    CC.PTFSM[193] = {'嵩山弟子','嵩山派武学追加500点杀气值。',2,1,1}	 --邓八公
    CC.PTFSM[192] = {'嵩山弟子','嵩山派武学追加500点杀气值。',2,1,1}	 --沙天江
    CC.PTFSM[191] = {'嵩山弟子','嵩山派武学追加500点杀气值。',2,1,1}	 --种镇 
    CC.PTFSM[190] = {'万毒之王','免疫中毒 ，带毒200点。',2,1,3}	 --莽牯朱蛤 
    CC.PTFSM[189] = {'晋阳大侠','连击率与暴击率+50%，攻击时必触发“混元一气”造成敌全体内伤。增加1000气功。修炼葵花宝典没有惩罚，可以使用葵花神功攻击,笑邪击败葵花尊者天内洗葵花神功。',2,1,4}	 --萧半和 
    CC.PTFSM[188] = {'铜笔铁算盘','装备判官笔增加伤害5%，每超过一万两银子，受到的伤害减少10%，最多减少20%。',2,1,3}	 --黄真
    CC.PTFSM[187] = {'八面威风','所受气攻和伤害降低10%，防御+10%。',2,1,3}	 --冯难敌
    CC.PTFSM[186] = {'横行无忌','使用拳法攻击追加100点真实伤害，如未装备武器，则此加成翻倍。',2,1,3}	 --归辛树
    CC.PTFSM[185] = {'仙剑神猿','等待时自动蓄力（无法触发龙象蓄力等效果），使用剑系武功攻击时，必连击，装备白猿后猿公剑法威力+500。',2,1,4}	 --穆人清
    CC.PTFSM[184] = {'护国真人','命中和格档提高20%，轻功增加20%。',2,1,4}	 --玉真子
    CC.PTFSM[183] = {'没影子','轻功+50。',2,1,2}	 --梅剑和
    CC.PTFSM[182] = {'五丁手','指法和拳法连击率+20%。',2,1,2}	 --刘培生
    CC.PTFSM[181] = {'仙都传人','两仪剑法连击率+20%。',2,1,2}	 --闵子华
    CC.PTFSM[180] = {'仙都传人','两仪剑法连击率+20%。',2,1,2}	 --洞玄
    CC.PTFSM[179] = {'太白三英','休息时回复双倍。',2,1,2}	 --黎刚
    CC.PTFSM[178] = {'太白三英','休息时回复双倍。',2,1,2}	 --史秉文
    CC.PTFSM[177] = {'太白三英','休息时回复双倍。',2,1,2}	 --史秉光
    CC.PTFSM[176] = {'五毒圣姑','被攻击使攻击者中毒20点，降低攻击者5点体力，200点内力。',2,1,2}	 --何红药
    CC.PTFSM[175] = {'圣火三使','40%几率集气位置向前跳跃20~40。',2,1,3}	 --辉月使
    CC.PTFSM[174] = {'圣火三使','40%几率集气位置向前跳跃20~40。',2,1,3}	 --流云使
    CC.PTFSM[173] = {'圣火三使','40%几率集气位置向前跳跃20~40。',2,1,3}	 --妙风使
    CC.PTFSM[172] = {'苍龙之血','战斗中概率领悟出苍龙六如功。',2,1,4}	 --儿子..天明
    CC.PTFSM[171] = {'苍龙之血','战斗中概率领悟出苍龙六如功。',2,1,4}	 --女儿..月儿
    CC.PTFSM[170] = {'四大神僧','使用龙爪手时自动进入等待状态。',2,1,2}	 --空性
    CC.PTFSM[169] = {'四大神僧','使用大力金刚掌时自动进入蓄力状态。',2,1,2}	 --空闻
    CC.PTFSM[168] = {'崆峒长老','崆峒派武学连击率+20%,暴击率+20%。',2,1,2}	 --常敬之
    CC.PTFSM[167] = {'崆峒长老','崆峒派武学连击率+20%,暴击率+20%。',2,1,2}	 --宗维侠
    CC.PTFSM[166] = {'太上掌门','两仪剑法威力+200。',2,1,2}	 --班淑娴
    CC.PTFSM[165] = {'贪得无厌','每过五十时序，回复生命10%，每过一百时序，失去生命20%。',2,1,2}	 --朱长龄
    CC.PTFSM[164] = {'摩天居士','自带三枚玄铁令，令一：天下人负我,自身受到的伤害增加20%。令二:我负天下人，免疫一次伤害且回复所受伤害的血量。令三:行止由心，两次行动。行动时给自身添加一枚玄铁令效果。',2,1,4}	 --谢烟客
    CC.PTFSM[163] = {'一日不过四','敌方全体集气-3，与丁不四同时在场，敌方全体集气-3。',2,1,3}	 --丁不四
    CC.PTFSM[162] = {'一日不过三','敌方全体集气-3，与丁不四同时在场，敌方全体集气-4。',2,1,3}	 --丁不三
    CC.PTFSM[161] = {'赤练仙子','五毒神掌变为赤练神掌，追加70点伤害，并强制上毒20点，引爆目标身上毒素。*【福缘际遇】神雕邪线古墓密道剧情，洗第二、三格武功，天赋内功洗为玉女心经。',2,1,3}	 --李莫愁
    CC.PTFSM[160] = {'蒙古力士','特色指令：死战,锁定一名敌人，至其死亡之前，达尔巴对其的攻击效果提高50%，且必定命中,在目标死亡之前无法更换目标。',2,1,2}	 --达尔巴
    CC.PTFSM[159] = {'大力尊者','必定单击，伤害永久提高1.5倍（天赋外功与如雷的额外连击有效）。',2,1,2}	 --尼摩星
    CC.PTFSM[158] = {'波斯大贾','作为畅想主角时开局获得一万银两,行动时概率放出金钱镖对随机敌人造成伤害。',2,1,3}	 --尹克西
    CC.PTFSM[157] = {'湘西尸王','战场上每一个死亡的成员都将回复尸王200点气血。',2,1,2}	 --潇湘子
    CC.PTFSM[156] = {'黑无常','我方格档+200，命中+100。',2,1,2}	 --白无常 常伯志
    CC.PTFSM[155] = {'黑无常','敌方格档-200，命中-100。',2,1,2}	 --黑无常 常赫志
    CC.PTFSM[154] = {'鸳鸯刀客','使用夫妻刀法无误伤，我方全体命中+200。',2,1,2}	 --骆冰 
    CC.PTFSM[153] = {'千臂如来','初始暗器值200点，战斗胜利后随机获得暗器。',2,1,3}	 --赵半山   
    CC.PTFSM[152] = {'追魂夺命剑','生命值低于50%时连击率两倍，生命值低于25%时连击率三倍。',2,1,3}	 --无尘
    CC.PTFSM[151] = {'奔雷手','时序增加1怒气，半血时序增加2怒气，暴怒攻击概率触发雷动九天，为目标添加一层雷音BUFF，对大于等三层雷音BUFF的目标击晕一回合。',2,1,3}	 --文泰来
    CC.PTFSM[150] = {'一剑无血','攻击时对方必流血且造成双倍流血效果，如果敌方敌方有流血状态，直接结算伤害，且回复自身同等血量。',2,1,3}	 --冯锡范
    CC.PTFSM[149] = {'千手如来','使用拳法攻击时，攻击范围增加一格，自动运行易筋经，免疫敌方三大吸功的吸内效果。',2,1,3}	 --方证
    CC.PTFSM[148] = {'桃谷六仙','指法攻击封穴翻倍，且概率定身。',2,1,2}	 --桃实仙
    CC.PTFSM[147] = {'桃谷六仙','指法攻击封穴翻倍，且概率定身。',2,1,2}	 --桃花仙
    CC.PTFSM[146] = {'桃谷六仙','指法攻击封穴翻倍，且概率定身。',2,1,2}	 --桃叶仙    
    CC.PTFSM[145] = {'桃谷六仙','指法攻击封穴翻倍，且概率定身。',2,1,2}	 --桃枝仙
    CC.PTFSM[144] = {'桃谷六仙','指法攻击封穴翻倍，且概率定身。',2,1,2}	 --桃干仙
    CC.PTFSM[143] = {'桃谷六仙','指法攻击封穴翻倍，且概率定身。',2,1,2}	 --桃根仙
    CC.PTFSM[142] = {'狂风快剑','使用剑法攻击，下回合集气+100。',2,1,2}	 --封不平
    CC.PTFSM[141] = {'夺命三仙','使用剑法连击时变为三连击。',2,1,2}	 --成不忧
    CC.PTFSM[140] = {'剑道通神','初始集气位置+990，暴怒时，使用独孤九剑攻击，追加1000点气攻，和10时序的静止状态，可叠加。',2,1,4}	 --风清扬
    CC.PTFSM[139] = {'延平郡王','受到女性攻击的伤害减少5%，对女性造成伤害增加5%。',2,1,2}	 --郑克爽
    CC.PTFSM[138] = {'一指镇江南','指系武功威力增加200。',2,1,2}	 --瓦耳拉齐
    CC.PTFSM[137] = {'青蟒剑','金蛇剑法威力+200',2,1,2}	 --陈达海
    CC.PTFSM[136] = {'越女剑','使用剑法时命中+100',2,1,2}	 --韩小莹
    CC.PTFSM[135] = {'闹市侠隐','轻功增加100',2,1,2}	 --全金髮
    CC.PTFSM[134] = {'笑弥陀','防御力增加100',2,1,2}	 --張阿生
    CC.PTFSM[133] = {'南山樵子','攻击力增加100。',2,1,2}	 --南希仁
    CC.PTFSM[132] = {'马王神','坐骑增加双倍属性(集气和三围）。',2,1,2}	 --韩宝驹
    CC.PTFSM[131] = {'妙手书生','妙笔丹青威力+200',2,1,2}	 --朱聪
    CC.PTFSM[130] = {'飞天蝙蝠','自动主运飞天神行。',2,1,2}	 --柯镇恶
    CC.PTFSM[129] = {'中神通','全真武学威力翻倍，使用全真剑法，60%几率发动重阳剑气，追加777气攻，攻击时高几率造成封穴。攻击时概率给目标添加【同归】状态。',2,1,4}	 --王重阳
    CC.PTFSM[128] = {'清净散人','全真剑法威力翻倍。',2,1,2}	 --孙不二
    CC.PTFSM[127] = {'广宁子','全真剑法威力翻倍。',2,1,2}	 --郝大通
    CC.PTFSM[126] = {'玉阳子','全真剑法威力翻倍。',2,1,2}	 --王处一
    CC.PTFSM[125] = {'长生子','全真剑法威力翻倍。',2,1,2}	 --刘处玄
    CC.PTFSM[124] = {'长真子','全真剑法威力翻倍。',2,1,2}	 --谭处端
    CC.PTFSM[123] = {'丹阳子','全真剑法威力翻倍,先天功气血、内力回复翻倍。',2,1,3}	 --马钰
    CC.PTFSM[122] = {'苍山书生','轻功减少10%,攻击和防御增加10%。',2,1,2}	 --朱子柳
    CC.PTFSM[121] = {'儒玄双通','获取武学点数和修为点数的能力增加。',2,1,1}	 --武三通
    CC.PTFSM[120] = {'樵夫','力大无穷，攻击力提升100点。',2,1,2}	 --渔
    CC.PTFSM[119] = {'点苍渔隐','海叟钓法威力+300。',2,1,1}	 --点苍渔隐
    CC.PTFSM[118] = {'秋水无尘','自身集气速度不受基础异常状态影响。',2,1,2}	 --李秋水
    CC.PTFSM[117] = {'唯我独尊','八荒六合功特效必触发。',2,1,2}	 --天山童姥
    CC.PTFSM[116] = {'逍遥掌门','内力上限9999，被攻击时必定发动北冥真气护体。',2,1,4}	 --无崖子
    CC.PTFSM[115] = {'聪辩先生','命中提升20%。',2,1,3}	 --扫地
    CC.PTFSM[114] = {'天佛化生','内力上限9999，攻击无误伤，被攻击100%触发【天地独尊】，完全免疫杀气。',2,1,4}	 --扫地
    CC.PTFSM[113] = {'龙城血脉','斗转必命中。',2,1,3}	 --慕容博
    CC.PTFSM[112] = {'杀破狼','开场进入杀破狼状态，三回合内保持满怒，杀气提高2000。',2,1,4}	 --萧远山 
    CC.PTFSM[111] = {'聚贤庄主','奇门武功威力+150',2,1,1}	 --游驹 
    CC.PTFSM[110] = {'聚贤庄主','奇门武功威力+150',2,1,1}	 --游骥 
    CC.PTFSM[109] = {'神算子','两仪剑法威力+200。',2,1,1}	 --鲜于通 
    CC.PTFSM[108] = {'华山长老','反两仪刀法威力+300。',2,1,1}	 --高老者 
    CC.PTFSM[107] = {'华山长老','反两仪刀法威力+300。',2,1,1}	 --矮老者   
    CC.PTFSM[106] = {'五虎断魂','五虎断门刀威力+200',2,1,2}	 --王元霸    
    CC.PTFSM[105] = {'碧落情天','与慕容复同队，替慕容复承担所有伤害。',2,1,2}	 --阿碧   
    CC.PTFSM[104] = {'千面玲珑','使用指令【易容】只受到误伤。',2,1,2}	 --阿朱   
    CC.PTFSM[103] = {'大轮明王','学会小无相功后，再学习任何武功系数需求降低20。特色指令【幻化】使用小无相功模拟天下武学，必须要拥有对应的秘籍。',2,1,3}	 --鸠摩智
    CC.PTFSM[102] = {'天龙禅师','使用一阳指高几率连击，灼烧恢复能力加倍（时序恢复2点灼烧）。',2,1,2}	 --枯荣
    CC.PTFSM[101] = {'笔砚生','装备判官笔时，额外增加封穴点数。',2,1,2}	 --朱丹辰
    CC.PTFSM[100] = {'穷凶极恶','攻击女性时，恢复造成伤害10%的血量（单次攻击吸血上限100点）。',2,1,2}	 --云中鹤
    CC.PTFSM[99] = {'无恶不作','使用黄沙万里鞭必双击。',2,1,1}	 --叶二娘
    CC.PTFSM[98] = {'恶贯满盈','加力/护体/出招几率大幅提高，无法休息。',2,1,3}	 --段延庆
    CC.PTFSM[97] = {'血刀老祖','基础暴击率大幅度提高，初始集气位置900，且移动+3格。',2,1,3}	 --血刀老祖
    CC.PTFSM[96] = {'冷月剑','增加64点防御，被攻击时降低640点气攻。',2,1,2}	 --水岱
    CC.PTFSM[95] = {'柔云剑','被攻击时，将一半杀气转化为回血。',2,1,2}	 --刘乘风
	CC.PTFSM[94] = {'仁义刀','使用刀法必定单击，刀法威力1.5倍。',2,1,2}	 --陆天枢
	CC.PTFSM[93] = {'忠仆','已方中毒抗性+20。',2,1,2}	 --平阿四	
	CC.PTFSM[92] = {'喵仙人','攻击无误伤，在队伍中时，可以在战斗开始前布阵。特色指令【换装】使用后改变自身外形，并将获得不同的内功。',2,1,3}	 --喵太极	
	CC.PTFSM[91] = {'青青子衿','金蛇山洞拔出金蛇剑，洗第一格武功为金蛇剑法。',2,1,1}	 --温青青	
	CC.PTFSM[90] = {'毓秀灵姝','攻击时必定造成流血，闪电貂攻击时概率偷窃敌方携带的物品，并对其强制上毒50点。*【福缘际遇】找到闪电貂后可第一格武功洗闪电貂，天龙正线收段誉，洗第一格武功，天赋外功洗为六脉神剑。',2,1,3}	 --钟灵
	CC.PTFSM[89] = {'食神','攻击不消耗体力。',2,1,2}	 --人厨子
	CC.PTFSM[88] = {'酒神','被攻击时有30%几率发动【酒神秘踪步】闪避',2,1,2}	 --祖千秋
	CC.PTFSM[87] = {'媚眼如丝','敌方全体攻击效果降低10%。',2,1,2}	 --苏荃
	CC.PTFSM[86] = {'金枝玉叶','敌方全体防御力降低15%。',2,1,2}	 --阿珂
	CC.PTFSM[85] = {'老谋深算','每过999时序，自动回满血内体并解除自身基础异常状态。',2,1,2}	 --贝海石
	CC.PTFSM[84] = {'小王爷','武功练到极，减少受到的5%气攻（上限25%）。',2,1,2}	 --霍都
	CC.PTFSM[83] = {'五毒教主','被攻击无视毒抗使攻击者中毒45~50点，用毒能力上限500。',2,1,3}	 --何铁手
	CC.PTFSM[82] = {'武当精英','武当派武功连击率+10%，暴击率+10%。',2,1,2}	 --宋青书
	CC.PTFSM[81] = {'雪岭双姝','战场上可发现食材。',2,1,1}	 --朱九真
	CC.PTFSM[80] = {'火手判官','攻击必定内伤，所造成内伤效果加倍。*【福缘际遇】武当山偷太极三宝支线，洗第二、三格武功，修炼纯阳无极功与九阳神功一脉相承后，天赋内功变为九阳神功。',2,1,2}	 --张召重
	CC.PTFSM[79] = {'小师妹','笑傲福威镖局选择正邪剧情，洗第一、二、三、四、五格武功。',2,1,2}	 --岳灵珊
	CC.PTFSM[78] = {'铁尸魔煞','华山观武后，九阴白骨爪威力增加50%。',2,1,2}	 --梅超风
	CC.PTFSM[77] = {'鸳鸯刀客','使用夫妻刀法无误伤，可装备专属武器鸯刀。',2,1,2}	--萧中慧
	CC.PTFSM[76] = {'琅嬛仙子','在场时，我方全体攻击范围增加一格，获得凌波微步后，天赋轻功洗为凌波微步。',2,1,4}	--王语嫣
	CC.PTFSM[75] = {'天池红花','攻击时有30%几率直接击中破绽，20%概率击中敌人后减少敌人一格气力。',2,1,2} --陈家洛
	CC.PTFSM[74] = {'翠羽黄衫','在场时，我方全体增加基础防御20%。',2,1,2} --霍青桐
	CC.PTFSM[73] = {'日月圣姑','每时序回复自身5点中毒。',2,1,2} --任盈盈
	CC.PTFSM[72] = {'天龙掌门','无视兵器值需求装备『闯王军刀』,装备『闯王军刀』，攻击时必定附加流血效果。*【福缘际遇】狐邪线杀苗人凤后，洗第一、二格武功，天赋外功洗为胡刀苗剑。 ',2,1,3} --田归农
	CC.PTFSM[71] = {'神龙教主','使用任何武功高连击，高暴击。 ',2,1,2} --洪安通
	CC.PTFSM[70] = {'伏虎罗汉','阳内时防御力增加20%，阴内时攻击力增加20%，调和内时轻功增加20%。 ',2,1,3} --
	CC.PTFSM[69] = {'北丐','使用降龙十八掌，40%几率发动【降龙.极意】，使用降龙十八掌攻击无误伤。*【福缘际遇】华山绝顶支线剧情，洗第三格武功，天赋内功洗为九阴神功，内力属性转为阴内。 ',2,1,3} --洪七公
	CC.PTFSM[68] = {'长春子','华山观武后全真剑法威力翻倍。主运先天功，全真剑法变化七星剑法 增加150点伤害， ',2,1,2} --丘处机
	CC.PTFSM[67] = {'铁掌水上漂','使用任何武功高连击，高暴击,移动步数+5。 ',2,1,3} -- 
	CC.PTFSM[66] = {'波斯圣女','敌全体移动减三格,无视资质学习乾坤大挪移。 ',2,1,3}
	CC.PTFSM[65] = {'南帝','使用一阳指，给敌方追加“无明业火”状态，持续30时序，处于“无明业火”状态的人攻击时，会损失50%内力消耗量的生命，攻击时高几率造成封穴。',2,1,3}	
	CC.PTFSM[64] = {'顽童武痴','每行动一次，攻击效果提升5%，最高提升30%。',2,1,3}
	CC.PTFSM[63] = {'青箫落瑛','使用玉箫剑法攻击，可杀敌内力300点。*【福缘际遇】射雕正线牛家村剧情，洗第二、三格武功 ',2,1,2}
	CC.PTFSM[62] = {'元蒙帝师','任何攻击追加2000点气攻。*【福缘际遇】神雕重阳宫大战，领悟龙象般若，神正最终战，领悟十龙十象。 ',2,1,3}
	CC.PTFSM[61] = {'白驼少主','暴怒时，使用雪山白驼掌可触发灵蛇拳，击中的敌人集气进入波动状态20时序。 ',2,1,3}
	CC.PTFSM[60] = {'西毒','所有攻击无误伤，攻击时无视敌方毒抗强制上毒30点。*【福缘际遇】射雕明霞岛剧情后，洗第二格武功，天赋内功洗为逆运经脉,华山绝顶支线剧情，洗第三格武功。 ',2,1,3}
	CC.PTFSM[59] = {'冰心玉骨','左右互搏发动几率70%，使用玉女素心剑法高几率连击。 ',2,1,3}
	CC.PTFSM[58] = {'西狂','使用玄铁剑法时，有几率发动重剑真传,攻击时附带“西狂之怒啸”，敌方全体集气倒退100点,战斗中，当小龙女被击退时，杨过立即出手并发动【西狂之震怒·雷霆狂啸】,黯然极意概率提升。*【福缘际遇】独孤剑冢拿玄铁剑法时，洗第一格武功，解锁剑魔再临，神雕重阳宫大战后，洗第三格武功，可选择洗天赋内功，神雕百花谷剧情后，洗第二格武功，射雕牛家村支线，可选择洗第三格武功和天赋内功，华山绝顶支线剧情，可选择洗第五格武功',2,1,4}
	CC.PTFSM[57] = {'东邪','攻击时高几率造成封穴，集气速度+10，自身在场时，敌方人物25%概率随机移动，敌方移动步数-2。',2,1,3}
	CC.PTFSM[56] = {'奇门遁甲','战斗开始前可布置奇阵，不同颜色的地面有不同效果:红色——造成的伤害提高20%，绿色——受到的伤害减少20%，蓝色——攻击时追加400点气攻，紫色——被攻击时有30%几率闪避。',2,1,4}
	CC.PTFSM[55] = {'大器晚成','左右互搏发动几率固定为80%，作为队友时，最后10级的升级属性提高。*【福缘际遇】射雕桃花岛招亲剧情，洗第一、二、三格武功，射雕正线桃花岛收郭靖时，可重新选择内力属性。',2,1,3}
	CC.PTFSM[54] = {'碧血长风','击败敌人后可再次行动,使用金蛇锥三倍暴击。',2,1,3}
	CC.PTFSM[53] = {'磊落仁心','内力上限9999,无量山洞剧情。*【福缘际遇】洗第一、二格武功，天龙寺剧情，洗第三格武功。',2,1,3}
	CC.PTFSM[52] = {'中平神枪','使用中平枪法时，气攻+1000,行动前随机变化一个形象，获得相应天赋和第一格武功，行动后集气速度提高一点，上限八十一点。',2,1,3}
	CC.PTFSM[51] = {'姑苏慕容','修炼斗转星移无需兵器值条件，斗转星移触发概率+10%。*【福缘际遇】天龙八部邪线挑战扫地老僧胜利后第二格以及天赋内功洗易筋经，领悟黑级浮屠。',2,1,3}
	CC.PTFSM[50] = {'狂龙天征','使用降龙十八掌，必定发动【降龙.极意】，使用降龙十八掌，40%几率发动【降龙.三叠浪】，暴怒时必定发动，使用降龙十八掌攻击无误伤，降龙十八掌耗内降低50%（与天赋外功效果叠加，降低75%内力消耗）。*【福缘际遇】天龙八部正线挑战扫地老僧胜利后，可获得专属武器。',2,1,4}
	CC.PTFSM[49] = {'逍遥掌门','有特色指令:生死符。擂鼓山剧情后，自带北冥真气护体，天山折梅手修炼到极，资质变为50。*【福缘际遇】擂鼓山支线剧情，洗第一、二格武功，灵鹫宫拿八荒时，第三格洗为八荒六合功，拿天山白梅手第五格洗天山折梅手。',2,1,4}
	CC.PTFSM[48] = {'冰毒怪客','攻击带毒340点，冰蚕毒掌随机附加1~3层“冰冻状态”，每层减缓1%集气速度，上限50层，攻击时，如敌方身上的冰封大于50，则有60%几率将其冻结10时序。',2,1,4}
	CC.PTFSM[47] = {'曼珠沙华','每击退一个敌方，自身气攻气防提高200点。',2,1,2}
	CC.PTFSM[46] = {'星宿老怪','攻击时，追加等同于敌方中毒量的伤害，回合结束时按中毒量扣除敌方生命，连环腐尸毒必出极意，引爆目标身上毒素。',2,1,4}
	CC.PTFSM[45] = {'阎王敌','医疗上限500点，战斗中满血复活自己或者同伴一次。',2,1,2}
	CC.PTFSM[44] = {'南海鳄神','暴怒时大剪刀附带撕裂效果。',2,1,1}
	CC.PTFSM[43] = {'雪山掌门','雪山派武功连击率+40%，暴击率+40%。武功威力+400。',2,1,3}
	CC.PTFSM[42] = {'罚恶使者','道德低于61，行动后对周身五格范围内敌人施毒，攻击时高几率附带冰封。',2,1,3}
	CC.PTFSM[41] = {'赏善使者','道德高于59，行动后对周身五格范围内队友治疗，攻击时高几率附带灼烧。',2,1,3}
	CC.PTFSM[40] = {'侠客岛主','防御效果提升20%，使用任何武功高几率造成封穴，主运太玄神功不会触发太玄之轻。',2,1,3}
	CC.PTFSM[39] = {'侠客岛主','攻击效果提升20%，使用任何武功高几率造成封穴，主运太玄神功不会触发太玄之重。',2,1,3}
	CC.PTFSM[38] = {'石破天惊','觉醒后太玄消耗减半。学有罗汉伏魔功，攻击时必出【罗汉伏魔】特效且效果增强10%。*【福缘际遇】侠客正线挑战岛主剧情，洗第二格武功为太玄神功，天赋内功洗为太玄神功。',2,1,4}
	CC.PTFSM[37] = {'赤心连城','学会连城剑法必连击，如本次攻击造成伤害低于150，则追加一次连击（一轮追加上限3次），修炼血刀大法无惩罚，不会降低生命上限，学会血刀大法必暴击。*【福缘际遇】雪山剧情，洗第二、三格武功。',2,1,4}
	CC.PTFSM[36] = {'辟邪剑客','初始集气位置900,使用辟邪剑法招式无需气。*【福缘际遇】笑傲福威镖局选择正邪剧情，洗第一、二格武功,笑傲福威镖局选择正邪剧情，天赋内功洗为葵花神功。',2,1,4}
	CC.PTFSM[35] = {'九剑传人','被风清扬指点后，进入战斗初始集气值1000，移动格数+3;神雕山洞二次觉醒领悟【九剑真传】、【无我无剑】*【福缘际遇】笑傲思过崖剧情，洗第一格武功，天赋外功洗为独孤九剑，笑傲梅庄地牢剧情，洗第二格武功，天赋内功洗为吸星大法。',2,1,4}
	CC.PTFSM[34] = {'江南四友','华山观武后持摇琴威力翻倍。江南四友每多一人在场、气防+500。',2,1,1}
	CC.PTFSM[33] = {'江南四友','华山观武后棋盘招式威力翻倍。江南四友每多一人在场、气防+500。',2,1,1}
	CC.PTFSM[32] = {'江南四友','华山观武后妙笔丹青威力翻倍。江南四友每多一人在场、气防+500。',2,1,1}
	CC.PTFSM[31] = {'江南四友','华山观武后倚天屠龙功威力翻倍。江南四友每多一人在场、气防+500。',2,1,1}  
    --30为郭靖
    CC.PTFSM[30] = {'1','1',2,1,1}
	CC.PTFSM[29] = {'采花大盗','攻击女性时吸取内力体力。',2,1,4}  --田伯光
	CC.PTFSM[28] = {'杀人名医','每击退一名敌人集气速度+3点、医疗能力+50（最多5个有效），医疗能力上限500。',2,1,2}  --平一指
	CC.PTFSM[27] = {'唯我不败','自带绣花针，攻击无误伤，暴怒时触发，状态解除前不会受到伤害。',2,1,4}	--东方不败
	CC.PTFSM[26] = {'日月魔帝','吸星大法吸体力效果提高。使用任何武功高暴击，攻击时高几率造成封穴。 ',2,1,4}	--任我行
	CC.PTFSM[25] = {'五毒教主','攻击伤害提升10%，用毒能力上限400。 ',2,1,2}	--蓝凤凰
	CC.PTFSM[24] = {'青城掌门','松风剑法威力翻倍，华山觉醒后松风剑法威力翻倍，必连击，必暴击。 ',2,1,2}	 --余沧海
	CC.PTFSM[23] = {'泰山掌门','五岳剑诀自动运功。攻击时高几率附带灼烧。 ',2,1,2}	 --天门
	CC.PTFSM[22] = {'嵩山掌门','五岳剑诀自动运功，攻击时高几率附带冰封。 ',2,1,2}	  --左冷禅
	CC.PTFSM[21] = {'恒山掌门','恒山派武学连击率+40%，暴击率+40%，恒山派武学威力+500。五岳剑诀自动运功。 ',2,1,3}	 --定闲
	CC.PTFSM[20] = {'衡山掌门','衡山派武学连击率+40%，暴击率+40%，恒山派武学威力+500。五岳剑诀自动运功。 ',2,1,3}  --莫大
	CC.PTFSM[19] = {'君子剑','使用剑法概率三连击，华山觉醒后自带五岳剑诀。*【福缘际遇】笑傲福威镖局选择正邪剧情，洗第一、三格武功。 ',2,1,2} --岳不群
	CC.PTFSM[18] = {'混元霹雳手','集气速度+10点,使用任何武功高几率连击和高几率封穴。 ',2,1,3} --成昆
	CC.PTFSM[17] = {'蝶谷毒仙','用毒能力上限500,攻击时带毒10~50点。 ',2,1,2} --王难姑
	CC.PTFSM[16] = {'蝶谷医仙','医疗上限500,可向队友用药,全场友军使用药品效果上升30%。 ',2,1,2} --胡青牛
	CC.PTFSM[15] = {'紫衫龙王','每次行动都有20%几率魅惑敌人一回合。 ',2,1,2} --黛丽丝
	CC.PTFSM[14] = {'青翼蝠王','集气速度提升10点，华山观武后，寒冰绵掌威力增加50%。 ',2,1,2} --韦一笑
	CC.PTFSM[13] = {'金毛狮王','狮子吼发动条件放宽为敌方内力低于自身即可，受到的伤害减少15%，七伤拳一震七伤发动几率100%，且一震七伤额外造成7点内伤。 ',2,1,2} --谢逊
	CC.PTFSM[12] = {'白眉鹰王','鹰爪功威力增加50%。 ',2,1,1} --殷天正
	CC.PTFSM[11] = {'光明左使','每次攻击，使敌方受到的伤害提高2%，上限40%。 ',2,1,1} --杨逍
	CC.PTFSM[10] = {'光明右使','每次受到攻击，增加自身1%的减伤，上限20%。 ',2,1,1} --范遥
	CC.PTFSM[9] = {'九阳明尊','未触发内功加力，护体时，补偿九阳神功加力，护体。*【福缘际遇】朱府剧情后洗第一格武功，光明顶领悟仁阳佛光，光明顶密道拿到乾坤时，洗第二格武功，灵蛇岛剧情领悟圣火明尊，武当山见张三丰，洗第三、四格武功。 ',2,1,4} --张无忌
	CC.PTFSM[8] = {'崆峒掌门','崆峒派武学连击率+40%,暴击率+40%。崆峒武学威力+500.' ,2,1,3} --唐文亮
	CC.PTFSM[7] = {'昆仑掌门','特色指令【铁琴】使全场敌人受到其身上琴音层数×50点伤害，并清除其身上的琴音状态 。昆仑派武学连击率+40%,暴击率+40%，昆仑派武学威力+500。 ',2,1,3} --何太冲
	CC.PTFSM[6] = {'峨眉掌门','使用任何武功高连击，必暴击，移动格数+3。 ',2,1,2}  --灭绝
	CC.PTFSM[5] = {'太极宗师','连击伤害杀气借力打力不减伤害，攻击无误伤，太极拳连击时亦享受借力打力效果，太极奥义发动几率无视资质固定为85%，开太极触发不需要条件。 ',2,1,4} --张三丰
	CC.PTFSM[4] = {'跌打医生','医疗能力上限300，用毒能力上限300，让田归农的攻击中附加带毒，击退敌方后可获得银两。 ',2,1,1} --阎基
	CC.PTFSM[3] = {'金面佛','攻击时高几率附带灼烧，每100点御剑系数增加苗家剑法攻击范围1格，攻击时概率给目标造成散功10时序。*【福缘际遇】挑战苗人凤后第一格洗胡刀，雪山飞狐闯王宝藏剧情，可选择洗第二格武功及天赋轻功。 ',2,1,3} --苗人凤
	CC.PTFSM[2] = {'灵枢素问','医疗能力上限400，用毒能力上限500，攻击时即使杀死敌方，也不会中断连击 ',2,1,4} --程灵素
	CC.PTFSM[1] = {'雪山飞狐','集气速度提升8点，特色指令【飞狐】：无视障碍物移动，在战场上来去自如。*【福缘际遇】苗家庄挑战苗人凤后第一格洗胡刀。 ',2,1,3} -- 胡斐
	--CC.PTFSM[0] = {'苍龙再现','【门派主角专属】六书之后挑战苍龙七宿可以获得苍龙之力中的一种。',2,1,3}  --基主
    -- 表1天赋名称，表2天赋说明，表3为为1非专属2为专属，表4为1是非门天赋为2是门派天赋，表5为天赋等级(1蓝2紫3金4红)
    CC.Tiangtf = {}
	for i = 9725,9999 do 
		if CC.PTFSM[i][3] == 1 then 
			CC.Tiangtf[#CC.Tiangtf+1] = i
		end
	end

    --门派天赋
    local MPTF = {}
    MPTF[1] = {400,461,479,655,597,657}
    MPTF[2] = {400,461,479,655,597,657}

    CC.PTF = {}
    --前后对应一致的编号表示人物编号
    --比如CC.PTF[0] 和 [0] = 1 中的0都表示人物ID，
    --前后对应一致的编号表示人物编号
    --比如CC.PTF[0] 和 [0] = 1 中的0都表示人物ID，
    CC.PTF[0] = {[0] = 1}
    CC.PTF[1] = {[1] = 1,[9772] = 1,[9952] = 1}
    CC.PTF[2] = {[2] = 1}
    CC.PTF[3] = {[3] = 1}
    CC.PTF[4] = {[4] = 1}
    CC.PTF[5] = {[5] = 1,[9770] = 1,[9771] = 1}
    CC.PTF[6] = {[6] = 1,[9813] = 1,[9734] = 1}
    CC.PTF[7] = {[7] = 1,[9819] = 1}
    CC.PTF[8] = {[8] = 1,[9750] = 1}
    CC.PTF[9] = {[9] = 1,[9990] = 1}
    CC.PTF[10] = {[10] = 1}
    CC.PTF[11] = {[11] = 1}
    CC.PTF[12] = {[12] = 1}
    CC.PTF[13] = {[13] = 1,[9768] = 1}
    CC.PTF[14] = {[14] = 1,[9818] = 1}
    CC.PTF[15] = {[15] = 1,[66] = 1,[9767] = 1}
    CC.PTF[16] = {[16] = 1,[9766] = 1}
    CC.PTF[17] = {[17] = 1,[9765] = 1}
    CC.PTF[18] = {[18] = 1,[9912] = 1}
    CC.PTF[19] = {[19] = 1}
    CC.PTF[20] = {[20] = 1,[9843] = 1,[9890] = 1}
    CC.PTF[21] = {[21] = 1}
    CC.PTF[22] = {[22] = 1}
    CC.PTF[23] = {[23] = 1}
    CC.PTF[24] = {[24] = 1}
    CC.PTF[25] = {[25] = 1}
    CC.PTF[26] = {[26] = 1,[9764] = 1}
    CC.PTF[27] = {[27] = 1,[9763] = 1,[9762] = 1}
    CC.PTF[28] = {[28] = 1}
    CC.PTF[29] = {[29] = 1,[9962] = 1}
    CC.PTF[30] = {[30] = 1}
    CC.PTF[31] = {[31] = 1}
    CC.PTF[32] = {[32] = 1}
    CC.PTF[33] = {[33] = 1}
    CC.PTF[34] = {[34] = 1}
    CC.PTF[35] = {[35] = 1,[9774] = 1}
    CC.PTF[36] = {[36] = 1,[9887] = 1}
    CC.PTF[37] = {[37] = 1,[9761] = 1}
    CC.PTF[38] = {[38] = 1,[9760] = 1,[9759] = 1}
    CC.PTF[39] = {[39] = 1}
    CC.PTF[40] = {[40] = 1}
    CC.PTF[41] = {[41] = 1}
    CC.PTF[42] = {[42] = 1}
    CC.PTF[43] = {[43] = 1,[9823] = 1}
    CC.PTF[44] = {[44] = 1,[9758] = 1}
    CC.PTF[45] = {[45] = 1}
    CC.PTF[46] = {[46] = 1}
    CC.PTF[47] = {[47] = 1,[9757] = 1}
    CC.PTF[48] = {[48] = 1}
    CC.PTF[49] = {[49] = 1,[9815] = 1}
    CC.PTF[50] = {[50] = 1,[9950] = 1,[9755] = 1}
    CC.PTF[51] = {[51] = 1,[9882] = 1}
    CC.PTF[52] = {[52] = 1}
    CC.PTF[53] = {[53] = 1,[9881] = 1,[9893] = 1}
    CC.PTF[54] = {[54] = 1,[9773] = 1,[9816] = 1}
    CC.PTF[55] = {[55] = 1}
    CC.PTF[56] = {[56] = 1,[9863] = 1,[9864] = 1}
    CC.PTF[57] = {[57] = 1,[9860] = 1}
    CC.PTF[58] = {[58] = 1,[9975]= 1,[9754]=1}
    CC.PTF[59] = {[59] = 1}
    CC.PTF[60] = {[60] = 1,[9858] = 1,[9857] = 1}
    CC.PTF[61] = {[61] = 1}
    CC.PTF[62] = {[62] = 1,[9932] = 1,[9931] = 1}
    CC.PTF[63] = {[63] = 1,[9830] = 1}
    CC.PTF[64] = {[64] = 1,[9854] = 1}
    CC.PTF[65] = {[65] = 1,[9855] = 1,[9853] = 1}
    CC.PTF[66] = {[66] = 1}
    CC.PTF[67] = {[67] = 1}
    CC.PTF[68] = {[68] = 1,[9831] = 1,[9753] = 1}
    CC.PTF[69] = {[69] = 1,[9951] = 1}
    CC.PTF[70] = {[70] = 1,[9880] = 1}
    CC.PTF[71] = {[71] = 1,[9846] = 1}
    CC.PTF[72] = {[72] = 1}
    CC.PTF[73] = {[73] = 1,[9843] = 1}
    CC.PTF[74] = {[74] = 1,[9829] = 1}
    CC.PTF[75] = {[75] = 1,[9856] = 1}
    CC.PTF[76] = {[76] = 1,[9899] = 1,[9900] = 1}
    CC.PTF[77] = {[77] = 1,[9863] = 1}
    CC.PTF[78] = {[78] = 1}
    CC.PTF[79] = {[79] = 1,[9842] = 1}
    CC.PTF[80] = {[80] = 1,[9838] = 1}
    CC.PTF[81] = {[81] = 1}
    CC.PTF[82] = {[82] = 1,[9988] = 1}
    CC.PTF[83] = {[83] = 1,[9752] = 1}
    CC.PTF[84] = {[84] = 1,[9981] = 1}
    CC.PTF[85] = {[85] = 1,[9866] = 1}
    CC.PTF[86] = {[86] = 1}
    CC.PTF[87] = {[87] = 1}
    CC.PTF[88] = {[88] = 1}
    CC.PTF[89] = {[89] = 1}
    CC.PTF[90] = {[90] = 1}
    CC.PTF[91] = {[91] = 1,[9867] = 1}
    CC.PTF[92] = {[92] = 1,[9981] = 1}
    CC.PTF[93] = {[93] = 1}
    CC.PTF[94] = {[94] = 1,[9898] = 1}
    CC.PTF[95] = {[95] = 1,[9898] = 1}
    CC.PTF[96] = {[96] = 1,[9898] = 1}
    CC.PTF[97] = {[97] = 1,[9878] = 1}
    CC.PTF[98] = {[98] = 1,[9758] = 1}
    CC.PTF[99] = {[99] = 1,[9758] = 1}
    CC.PTF[100] = {[100] = 1}
    CC.PTF[101] = {[101] = 1}
    CC.PTF[102] = {[102] = 1}
    CC.PTF[103] = {[103] = 1,[9873] = 1}
    CC.PTF[104] = {[104] = 1,[9872] = 1}
    CC.PTF[105] = {[105] = 1,[9871] = 1}
    CC.PTF[106] = {[106] = 1}
    CC.PTF[107] = {[107] = 1}
    CC.PTF[108] = {[108] = 1}
    CC.PTF[109] = {[109] = 1}
    CC.PTF[110] = {[110] = 1}
    CC.PTF[111] = {[111] = 1}
    CC.PTF[112] = {[112] = 1,[9877] = 1}
    CC.PTF[113] = {[113] = 1,[9882] = 1,[9876] = 1}
    CC.PTF[114] = {[114] = 1,[9875] = 1,[9874] = 1}
    CC.PTF[115] = {[115] = 1}
    CC.PTF[116] = {[116] = 1,[9801] = 1,[9815] = 1}
    CC.PTF[117] = {[117] = 1,[9869] = 1,[9868] = 1}
    CC.PTF[118] = {[118] = 1,[9835] = 1}
    CC.PTF[119] = {[119] = 1,[9896] = 1}
    CC.PTF[120] = {[120] = 1,[9896] = 1}
    CC.PTF[121] = {[121] = 1,[9896] = 1}
    CC.PTF[122] = {[122] = 1,[9896] = 1}
    CC.PTF[123] = {[123] = 1,[9753] = 1}
    CC.PTF[124] = {[124] = 1,[9753] = 1}
    CC.PTF[125] = {[125] = 1,[9753] = 1}
    CC.PTF[126] = {[126] = 1,[9753] = 1}
    CC.PTF[127] = {[127] = 1,[9753] = 1}
    CC.PTF[128] = {[128] = 1,[9753] = 1}
    CC.PTF[129] = {[129] = 1,[9787] = 1,[9851] = 1}
    CC.PTF[130] = {[130] = 1,[9751] = 1}
    CC.PTF[131] = {[131] = 1,[9751] = 1}
    CC.PTF[132] = {[132] = 1,[9751] = 1}
    CC.PTF[133] = {[133] = 1,[9751] = 1}
    CC.PTF[134] = {[134] = 1,[9751] = 1}
    CC.PTF[135] = {[135] = 1,[9751] = 1}
    CC.PTF[136] = {[136] = 1,[9751] = 1}
    CC.PTF[137] = {[137] = 1}
    CC.PTF[138] = {[138] = 1}
    CC.PTF[139] = {[139] = 1}
    CC.PTF[140] = {[140] = 1,[9982] = 1,[9974]= 1}
    CC.PTF[141] = {[141] = 1}
    CC.PTF[142] = {[142] = 1}
    CC.PTF[143] = {[143] = 1}
    CC.PTF[144] = {[144] = 1}
    CC.PTF[145] = {[145] = 1}
    CC.PTF[146] = {[146] = 1}
    CC.PTF[147] = {[147] = 1}
    CC.PTF[148] = {[148] = 1}
    CC.PTF[149] = {[149] = 1,[9995]= 1,[9897] = 1}
    CC.PTF[150] = {[150] = 1}
    CC.PTF[151] = {[151] = 1,[9847] = 1}
    CC.PTF[152] = {[152] = 1,[9836] = 1,[9953] = 1}
    CC.PTF[153] = {[153] = 1}
    CC.PTF[154] = {[154] = 1}
    CC.PTF[155] = {[155] = 1}
    CC.PTF[156] = {[156] = 1}
    CC.PTF[157] = {[157] = 1}
    CC.PTF[158] = {[158] = 1}
    CC.PTF[159] = {[159] = 1}
    CC.PTF[160] = {[160] = 1}
    CC.PTF[161] = {[161] = 1,[9827] = 1}
    CC.PTF[162] = {[162] = 1}
    CC.PTF[163] = {[163] = 1}
    CC.PTF[164] = {[164] = 1,[9822] = 1}
    CC.PTF[165] = {[165] = 1}
    CC.PTF[166] = {[166] = 1}
    CC.PTF[167] = {[167] = 1,[9750] = 1}
    CC.PTF[168] = {[168] = 1,[9750] = 1}
    CC.PTF[169] = {[169] = 1}
    CC.PTF[170] = {[170] = 1}
    CC.PTF[171] = {[171] = 1}
    CC.PTF[172] = {[172] = 1}
    CC.PTF[173] = {[173] = 1}
    CC.PTF[174] = {[174] = 1}
    CC.PTF[175] = {[175] = 1}
    CC.PTF[176] = {[176] = 1}
    CC.PTF[177] = {[177] = 1}
    CC.PTF[178] = {[178] = 1}
    CC.PTF[179] = {[179] = 1}
    CC.PTF[180] = {[180] = 1}
    CC.PTF[181] = {[181] = 1}
    CC.PTF[182] = {[182] = 1}
    CC.PTF[183] = {[183] = 1,[9812] = 1}
    CC.PTF[184] = {[184] = 1,[9895] = 1}
    CC.PTF[185] = {[185] = 1,[9997] = 1}
    CC.PTF[186] = {[186] = 1,[9955] = 1}
    CC.PTF[187] = {[187] = 1,[9960] = 1}
    CC.PTF[188] = {[188] = 1}
    CC.PTF[189] = {[189] = 1,[9925] = 1,[9795] = 1}
    CC.PTF[190] = {[190] = 1}
    CC.PTF[191] = {[191] = 1}
    CC.PTF[192] = {[192] = 1}
    CC.PTF[193] = {[193] = 1}
    CC.PTF[194] = {[194] = 1}
    CC.PTF[195] = {[195] = 1}
    CC.PTF[196] = {[196] = 1}
    CC.PTF[197] = {[197] = 1}
    CC.PTF[198] = {[198] = 1}
    CC.PTF[199] = {[199] = 1}
    CC.PTF[200] = {[200] = 1}
    CC.PTF[201] = {[201] = 1}
    CC.PTF[202] = {[202] = 1}
    CC.PTF[203] = {[203] = 1}
    CC.PTF[204] = {[204] = 1}
    CC.PTF[205] = {[205] = 1}
    CC.PTF[206] = {[206] = 1}
    CC.PTF[207] = {[207] = 1}
    CC.PTF[208] = {[208] = 1}
    CC.PTF[209] = {[209] = 1}
    CC.PTF[210] = {[210] = 1}
    CC.PTF[211] = {[211] = 1}
    CC.PTF[212] = {[212] = 1}
    CC.PTF[213] = {[213] = 1}
    CC.PTF[214] = {[214] = 1}
    CC.PTF[215] = {[215] = 1}
    CC.PTF[216] = {[216] = 1}
    CC.PTF[217] = {[217] = 1}
    CC.PTF[218] = {[218] = 1}
    CC.PTF[219] = {[219] = 1}
    CC.PTF[220] = {[220] = 1}
    CC.PTF[221] = {[221] = 1}
    CC.PTF[222] = {[222] = 1}
    CC.PTF[223] = {[223] = 1}
    CC.PTF[224] = {[224] = 1}
    CC.PTF[225] = {[225] = 1}
    CC.PTF[226] = {[226] = 1}
    CC.PTF[227] = {[227] = 1}
    CC.PTF[228] = {[228] = 1}
    CC.PTF[229] = {[229] = 1}
    CC.PTF[230] = {[230] = 1}
    CC.PTF[231] = {[231] = 1}
    CC.PTF[232] = {[232] = 1}
    CC.PTF[233] = {[233] = 1}
    CC.PTF[234] = {[234] = 1,[9950] = 1}
    CC.PTF[235] = {[235] = 1}
    CC.PTF[236] = {[236] = 1}
    CC.PTF[237] = {[237] = 1}
    CC.PTF[238] = {[238] = 1}
    CC.PTF[239] = {[239] = 1}
    CC.PTF[240] = {[240] = 1}
    CC.PTF[241] = {[241] = 1}
    CC.PTF[242] = {[242] = 1}
    CC.PTF[243] = {[243] = 1}
    CC.PTF[244] = {[244] = 1}
    CC.PTF[245] = {[245] = 1}
    CC.PTF[246] = {[246] = 1}
    CC.PTF[247] = {[247] = 1}
    CC.PTF[248] = {[248] = 1}
    CC.PTF[249] = {[249] = 1}
    CC.PTF[250] = {[250] = 1,[9823] = 1}
    CC.PTF[251] = {[251] = 1}
    CC.PTF[252] = {[252] = 1}
    CC.PTF[253] = {[253] = 1}
    CC.PTF[254] = {[254] = 1}
    CC.PTF[255] = {[255] = 1}
    CC.PTF[256] = {[256] = 1}
    CC.PTF[257] = {[257] = 1}
    CC.PTF[258] = {[258] = 1}
    CC.PTF[259] = {[259] = 1}
    CC.PTF[260] = {[260] = 1}
    CC.PTF[261] = {[261] = 1}
    CC.PTF[262] = {[262] = 1}
    CC.PTF[263] = {[263] = 1}
    CC.PTF[264] = {[264] = 1}
    CC.PTF[265] = {[265] = 1}
    CC.PTF[266] = {[266] = 1}
    CC.PTF[267] = {[267] = 1}
    CC.PTF[268] = {[268] = 1}
    CC.PTF[269] = {[269] = 1}
    CC.PTF[270] = {[270] = 1}
    CC.PTF[271] = {[271] = 1}
    CC.PTF[272] = {[272] = 1}
    CC.PTF[273] = {[273] = 1}
    CC.PTF[274] = {[274] = 1}
    CC.PTF[275] = {[275] = 1}
    CC.PTF[276] = {[276] = 1}
    CC.PTF[277] = {[277] = 1}
    CC.PTF[278] = {[278] = 1}
    CC.PTF[279] = {[279] = 1}
    CC.PTF[280] = {[280] = 1}
    CC.PTF[281] = {[281] = 1}
    CC.PTF[282] = {[282] = 1}
    CC.PTF[283] = {[283] = 1}
    CC.PTF[284] = {[284] = 1}
    CC.PTF[285] = {[285] = 1}
    CC.PTF[286] = {[286] = 1}
    CC.PTF[287] = {[287] = 1}
    CC.PTF[288] = {[288] = 1}
    CC.PTF[289] = {[289] = 1}
    CC.PTF[290] = {[290] = 1}
    CC.PTF[291] = {[291] = 1}
    CC.PTF[292] = {[292] = 1}
    CC.PTF[293] = {[293] = 1}
    CC.PTF[294] = {[294] = 1}
    CC.PTF[295] = {[295] = 1}
    CC.PTF[296] = {[296] = 1}
    CC.PTF[297] = {[297] = 1}
    CC.PTF[298] = {[298] = 1}
    CC.PTF[299] = {[299] = 1}
    CC.PTF[300] = {[300] = 1}
    CC.PTF[301] = {[301] = 1}
    CC.PTF[302] = {[302] = 1}
    CC.PTF[303] = {[303] = 1}
    CC.PTF[304] = {[304] = 1}
    CC.PTF[305] = {[305] = 1}
    CC.PTF[306] = {[306] = 1,[9837] = 1}
    CC.PTF[307] = {[307] = 1,[9826] = 1}
    CC.PTF[308] = {[308] = 1}
    CC.PTF[309] = {[309] = 1,[9968] = 1}
    CC.PTF[310] = {[310] = 1,[9756] = 1}
    CC.PTF[311] = {[311] = 1,[9811] = 1}
    CC.PTF[312] = {[312] = 1}
    CC.PTF[313] = {[313] = 1,[9986] = 1,[9985] = 1}
    CC.PTF[314] = {[314] = 1}
    CC.PTF[315] = {[315] = 1}
    CC.PTF[316] = {[316] = 1}
    CC.PTF[317] = {[317] = 1}
    CC.PTF[318] = {[318] = 1}
    CC.PTF[319] = {[319] = 1}
    CC.PTF[320] = {[320] = 1}
    CC.PTF[321] = {[321] = 1}
    CC.PTF[322] = {[322] = 1}
    CC.PTF[323] = {[323] = 1}
    CC.PTF[324] = {[324] = 1}
    CC.PTF[325] = {[325] = 1}
    CC.PTF[326] = {[326] = 1}
    CC.PTF[327] = {[327] = 1}
    CC.PTF[328] = {[328] = 1}
    CC.PTF[329] = {[329] = 1}
    CC.PTF[330] = {[330] = 1}
    CC.PTF[331] = {[331] = 1}
    CC.PTF[332] = {[332] = 1}
    CC.PTF[333] = {[333] = 1}
    CC.PTF[334] = {[334] = 1}
    CC.PTF[335] = {[335] = 1}
    CC.PTF[336] = {[336] = 1}
    CC.PTF[337] = {[337] = 1}
    CC.PTF[338] = {[338] = 1}
    CC.PTF[339] = {[339] = 1}
    CC.PTF[340] = {[340] = 1}
    CC.PTF[341] = {[341] = 1}
    CC.PTF[342] = {[342] = 1}
    CC.PTF[343] = {[343] = 1}
    CC.PTF[344] = {[344] = 1}
    CC.PTF[345] = {[345] = 1}
    CC.PTF[346] = {[346] = 1}
    CC.PTF[347] = {[347] = 1}
    CC.PTF[348] = {[348] = 1}
    CC.PTF[349] = {[349] = 1}
    CC.PTF[350] = {[350] = 1}
    CC.PTF[351] = {[351] = 1}
    CC.PTF[352] = {[352] = 1}
    CC.PTF[353] = {[353] = 1}
    CC.PTF[354] = {[354] = 1}
    CC.PTF[355] = {[355] = 1}
    CC.PTF[356] = {[356] = 1}
    CC.PTF[357] = {[357] = 1,[9750] = 1}
    CC.PTF[358] = {[358] = 1,[9750] = 1}
    CC.PTF[359] = {[359] = 1,}
    CC.PTF[360] = {[360] = 1}
    CC.PTF[361] = {[361] = 1}
    CC.PTF[362] = {[362] = 1}
    CC.PTF[363] = {[363] = 1}
    CC.PTF[364] = {[364] = 1}
    CC.PTF[365] = {[365] = 1}
    CC.PTF[366] = {[366] = 1}
    CC.PTF[367] = {[367] = 1}
    CC.PTF[368] = {[368] = 1}
    CC.PTF[369] = {[369] = 1}
    CC.PTF[370] = {[370] = 1}
    CC.PTF[371] = {[371] = 1}
    CC.PTF[372] = {[372] = 1}
    CC.PTF[373] = {[373] = 1}
    CC.PTF[374] = {[374] = 1}
    CC.PTF[375] = {[375] = 1}
    CC.PTF[376] = {[376] = 1}
    CC.PTF[377] = {[377] = 1}
    CC.PTF[378] = {[378] = 1}
    CC.PTF[379] = {[379] = 1}
    CC.PTF[380] = {[380] = 1}
    CC.PTF[381] = {[381] = 1}
    CC.PTF[382] = {[382] = 1}
    CC.PTF[383] = {[383] = 1}
    CC.PTF[384] = {[384] = 1}
    CC.PTF[385] = {[385] = 1}
    CC.PTF[386] = {[386] = 1}
    CC.PTF[387] = {[387] = 1}
    CC.PTF[388] = {[388] = 1}
    CC.PTF[389] = {[389] = 1}
    CC.PTF[390] = {[390] = 1}
    CC.PTF[391] = {[391] = 1}
    CC.PTF[392] = {[392] = 1}
    CC.PTF[393] = {[393] = 1}
    CC.PTF[394] = {[394] = 1}
    CC.PTF[395] = {[395] = 1}
    CC.PTF[396] = {[396] = 1}
    CC.PTF[397] = {[397] = 1}
    CC.PTF[398] = {[398] = 1}
    CC.PTF[399] = {[399] = 1}
    CC.PTF[400] = {[400] = 1}
    CC.PTF[401] = {[401] = 1}
    CC.PTF[402] = {[402] = 1}
    CC.PTF[403] = {[403] = 1}
    CC.PTF[404] = {[404] = 1}
    CC.PTF[405] = {[405] = 1}
    CC.PTF[406] = {[406] = 1}
    CC.PTF[407] = {[407] = 1}
    CC.PTF[408] = {[408] = 1}
    CC.PTF[409] = {[409] = 1}
    CC.PTF[410] = {[410] = 1}
    CC.PTF[411] = {[411] = 1}
    CC.PTF[412] = {[412] = 1}
    CC.PTF[413] = {[413] = 1}
    CC.PTF[414] = {[414] = 1}
    CC.PTF[415] = {[415] = 1}
    CC.PTF[416] = {[416] = 1}
    CC.PTF[417] = {[417] = 1}
    CC.PTF[418] = {[418] = 1}
    CC.PTF[419] = {[419] = 1}
    CC.PTF[420] = {[420] = 1}
    CC.PTF[421] = {[421] = 1}
    CC.PTF[422] = {[422] = 1}
    CC.PTF[423] = {[423] = 1}
    CC.PTF[424] = {[424] = 1}
    CC.PTF[425] = {[425] = 1}
    CC.PTF[426] = {[426] = 1}
    CC.PTF[427] = {[427] = 1}
    CC.PTF[428] = {[428] = 1}
    CC.PTF[429] = {[429] = 1}
    CC.PTF[430] = {[430] = 1}
    CC.PTF[431] = {[431] = 1}
    CC.PTF[432] = {[432] = 1}
    CC.PTF[433] = {[433] = 1}
    CC.PTF[434] = {[434] = 1}
    CC.PTF[435] = {[435] = 1}
    CC.PTF[436] = {[436] = 1}
    CC.PTF[437] = {[437] = 1}
    CC.PTF[438] = {[438] = 1}
    CC.PTF[439] = {[439] = 1}
    CC.PTF[440] = {[440] = 1}
    CC.PTF[441] = {[441] = 1}
    CC.PTF[442] = {[442] = 1}
    CC.PTF[443] = {[443] = 1}
    CC.PTF[444] = {[444] = 1}
    CC.PTF[445] = {[445] = 1}
    CC.PTF[446] = {[446] = 1}
    CC.PTF[447] = {[447] = 1}
    CC.PTF[448] = {[448] = 1}
    CC.PTF[449] = {[449] = 1}
    CC.PTF[450] = {[450] = 1}
    CC.PTF[451] = {[451] = 1}
    CC.PTF[452] = {[452] = 1}
    CC.PTF[453] = {[453] = 1}
    CC.PTF[454] = {[454] = 1}
    CC.PTF[455] = {[455] = 1}
    CC.PTF[456] = {[456] = 1}
    CC.PTF[457] = {[457] = 1}
    CC.PTF[458] = {[458] = 1,[9936] = 1}
    CC.PTF[459] = {[459] = 1,[9936] = 1}
    CC.PTF[460] = {[460] = 1}
    CC.PTF[461] = {[461] = 1}
    CC.PTF[462] = {[462] = 1}
    CC.PTF[463] = {[463] = 1}
    CC.PTF[464] = {[464] = 1}
    CC.PTF[465] = {[465] = 1}
    CC.PTF[466] = {[466] = 1}
    CC.PTF[467] = {[467] = 1}
    CC.PTF[468] = {[468] = 1}
    CC.PTF[469] = {[469] = 1}
    CC.PTF[470] = {[470] = 1}
    CC.PTF[471] = {[471] = 1}
    CC.PTF[472] = {[472] = 1}
    CC.PTF[473] = {[473] = 1}
    CC.PTF[474] = {[474] = 1}
    CC.PTF[475] = {[475] = 1}
    CC.PTF[476] = {[476] = 1}
    CC.PTF[477] = {[477] = 1}
    CC.PTF[478] = {[478] = 1}
    CC.PTF[479] = {[479] = 1}
    CC.PTF[480] = {[480] = 1}
    CC.PTF[481] = {[481] = 1}
    CC.PTF[482] = {[482] = 1}
    CC.PTF[483] = {[483] = 1}
    CC.PTF[484] = {[484] = 1}
    CC.PTF[485] = {[485] = 1}
    CC.PTF[486] = {[486] = 1}
    CC.PTF[487] = {[487] = 1}
    CC.PTF[488] = {[488] = 1}
    CC.PTF[489] = {[489] = 1}
    CC.PTF[490] = {[490] = 1}
    CC.PTF[491] = {[491] = 1}
    CC.PTF[492] = {[492] = 1}
    CC.PTF[493] = {[493] = 1}
    CC.PTF[494] = {[494] = 1}
    CC.PTF[495] = {[495] = 1}
    CC.PTF[496] = {[496] = 1}
    CC.PTF[497] = {[497] = 1,[9749] = 1}
    CC.PTF[498] = {[498] = 1,[9804] = 1}
    CC.PTF[499] = {[499] = 1,[9913] = 1,[9893] = 1}
    CC.PTF[500] = {[500] = 1,[9941] = 1,[9748] = 1}
    CC.PTF[501] = {[501] = 1,[9953] = 1,[9975] = 1}
    CC.PTF[502] = {[502] = 1,[9907] = 1}
    CC.PTF[503] = {[503] = 1}
    CC.PTF[504] = {[504] = 1,[9977] = 1,[9976] = 1,}
    CC.PTF[505] = {[505] = 1,[9979] = 1,[9978] = 1}
    CC.PTF[506] = {[506] = 1,[9976] = 1,[9973] = 1,[9972] = 1,[9971] = 1,}
    CC.PTF[507] = {[507] = 1,[9969] = 1}
    CC.PTF[508] = {[508] = 1,[9745] = 1}
    CC.PTF[509] = {[509] = 1}
    CC.PTF[510] = {[510] = 1,[9744] = 1}
    CC.PTF[511] = {[511] = 1,[9743] = 1, [9887] = 1}
    CC.PTF[512] = {[512] = 1}
    CC.PTF[513] = {[513] = 1,[9961] = 1,[9962] = 1,[9964] = 1}
    CC.PTF[514] = {[514] = 1,[9918] = 1,[9919] = 1}
    CC.PTF[515] = {[515] = 1}
    CC.PTF[516] = {[516] = 1}
    CC.PTF[517] = {[517] = 1}
    CC.PTF[518] = {[518] = 1}
    CC.PTF[519] = {[519] = 1}
    CC.PTF[520] = {[520] = 1}
    CC.PTF[521] = {[521] = 1}
    CC.PTF[522] = {[522] = 1}
    CC.PTF[523] = {[523] = 1}
    CC.PTF[524] = {[524] = 1}
    CC.PTF[525] = {[525] = 1}
    CC.PTF[526] = {[526] = 1}
    CC.PTF[527] = {[527] = 1}
    CC.PTF[528] = {[528] = 1}
    CC.PTF[529] = {[529] = 1}
    CC.PTF[530] = {[530] = 1}
    CC.PTF[531] = {[531] = 1}
    CC.PTF[532] = {[532] = 1,[9917] = 1,[9782] = 1,[9781] = 1}
    CC.PTF[533] = {[533] = 1,[9917] = 1}
    CC.PTF[534] = {[534] = 1,[9917] = 1,[9780] = 1,[9779] = 1}
    CC.PTF[535] = {[535] = 1,[9917] = 1}
    CC.PTF[536] = {[536] = 1,[9917] = 1}
    CC.PTF[537] = {[537] = 1,[9917] = 1}
    CC.PTF[538] = {[538] = 1,[9917] = 1,[9835] = 1}
    CC.PTF[539] = {[539] = 1}
    CC.PTF[540] = {[540] = 1}
    CC.PTF[541] = {[541] = 1}
    CC.PTF[542] = {[542] = 1}
    CC.PTF[543] = {[543] = 1}
    CC.PTF[544] = {[544] = 1}
    CC.PTF[545] = {[545] = 1}
    CC.PTF[546] = {[546] = 1,[9949] = 1,[9948] = 1}
    CC.PTF[547] = {[547] = 1}
    CC.PTF[548] = {[548] = 1}
    CC.PTF[549] = {[549] = 1}
    CC.PTF[550] = {[550] = 1}
    CC.PTF[551] = {[551] = 1}
    CC.PTF[552] = {[552] = 1}
    CC.PTF[553] = {[553] = 1}
    CC.PTF[554] = {[554] = 1}
    CC.PTF[555] = {[555] = 1}
    CC.PTF[556] = {[556] = 1}
    CC.PTF[557] = {[557] = 1}
    CC.PTF[558] = {[558] = 1}
    CC.PTF[559] = {[559] = 1}
    CC.PTF[560] = {[560] = 1}
    CC.PTF[561] = {[561] = 1}
    CC.PTF[562] = {[562] = 1}
    CC.PTF[563] = {[563] = 1}
    CC.PTF[564] = {[564] = 1}
    CC.PTF[565] = {[565] = 1}
    CC.PTF[566] = {[566] = 1,[9907] = 1}
    CC.PTF[567] = {[567] = 1,[9989] = 1,[9909] = 1}
    CC.PTF[568] = {[568] = 1,[9968] = 1,[9910] = 1}
    CC.PTF[569] = {[569] = 1,[9906] = 1}
    CC.PTF[570] = {[570] = 1,[9967] = 1}
    CC.PTF[571] = {[571] = 1,[9878] = 1}
    CC.PTF[572] = {[572] = 1}
    CC.PTF[573] = {[573] = 1,[9998] = 1,[9999] = 1}
    CC.PTF[574] = {[574] = 1,[9785] = 1,[9784] = 1}
    CC.PTF[575] = {[575] = 1,[9953] = 1,[9996] = 1}
    CC.PTF[576] = {[576] = 1,[9995] = 1,[9994] = 1,[9993] = 1}
    CC.PTF[577] = {[577] = 1,[9995] = 1,[9940] = 1,[9939]=1,[9963] = 1}
    CC.PTF[578] = {[578] = 1,[9742] = 1,[9952] = 1}
    CC.PTF[579] = {[579] = 1,[9740] = 1}
    CC.PTF[580] = {[580] = 1}
    CC.PTF[581] = {[581] = 1,[9742] = 1}
    CC.PTF[582] = {[582] = 1,[9739] = 1}
    CC.PTF[583] = {[583] = 1,[9998] = 1}
    CC.PTF[584] = {[584] = 1,[9738] = 1}
    CC.PTF[585] = {[585] = 1}
    CC.PTF[586] = {[586] = 1,[9792] = 1}
    CC.PTF[587] = {[587] = 1,[9793] = 1}
    CC.PTF[588] = {[588] = 1,[9862] = 1}
    CC.PTF[589] = {[589] = 1,[9905] = 1}
    CC.PTF[590] = {[590] = 1,[9850] = 1}
    CC.PTF[591] = {[591] = 1}
    CC.PTF[592] = {[592] = 1,[9982]= 1,[9974]= 1,[9975]= 1}
    CC.PTF[593] = {[593] = 1}
    CC.PTF[594] = {[594] = 1,[9892] = 1}
    CC.PTF[595] = {[595] = 1,[9809] = 1}
    CC.PTF[596] = {[596] = 1,[9746] = 1,[9806] = 1}
    CC.PTF[597] = {[597] = 1,[9737] = 1}
    CC.PTF[598] = {[598] = 1,[9737] = 1}
    CC.PTF[599] = {[599] = 1,[9737] = 1}
    CC.PTF[600] = {[600] = 1}
    CC.PTF[601] = {[601] = 1,[9808] = 1}
    CC.PTF[602] = {[602] = 1}
    CC.PTF[603] = {[603] = 1,[9807] = 1,[9915] = 1}
    CC.PTF[604] = {[604] = 1,[9746] = 1,[9806] = 1}
    CC.PTF[605] = {[605] = 1,[9804] = 1}
    CC.PTF[606] = {[606] = 1,[9802] = 2,[9743] = 1}
    CC.PTF[607] = {[607] = 1}
    CC.PTF[608] = {[608] = 1,[9805] = 1,[9762] = 1}
    CC.PTF[609] = {[609] = 1,[9736] = 1}
    CC.PTF[610] = {[610] = 1,[9944] = 1,[9942] = 1}
    CC.PTF[611] = {[611] = 1}
    CC.PTF[612] = {[612] = 1}
    CC.PTF[613] = {[613] = 1}
    CC.PTF[614] = {[614] = 1,[9984] = 1}
    CC.PTF[615] = {[615] = 1,[9943] = 1}
    CC.PTF[616] = {[616] = 1,[9735] = 1}
    CC.PTF[617] = {[617] = 1}
    CC.PTF[618] = {[618] = 1}
    CC.PTF[619] = {[619] = 1}
    CC.PTF[620] = {[620] = 1}
    CC.PTF[621] = {[621] = 1}
    CC.PTF[622] = {[622] = 1}
    CC.PTF[623] = {[623] = 1}
    CC.PTF[624] = {[624] = 1}
    CC.PTF[625] = {[625] = 1}
    CC.PTF[626] = {[626] = 1,[9860] = 1,[9741] = 1}
    CC.PTF[627] = {[627] = 1,[9800] = 1}
    CC.PTF[628] = {[628] = 1,[9859] = 1}
    CC.PTF[629] = {[629] = 1,[9799] = 1}
    CC.PTF[630] = {[630] = 1}
    CC.PTF[631] = {[631] = 1}
    CC.PTF[632] = {[632] = 1}
    CC.PTF[633] = {[633] = 1,[9794] = 1,[9735] = 1}
    CC.PTF[634] = {[634] = 1,[9733] = 1}
    CC.PTF[635] = {[635] = 1,[9731] = 1,[9732] = 1}
    CC.PTF[636] = {[636] = 1,[9907] = 1,[9730] = 1}
    CC.PTF[637] = {[637] = 1,[9929] = 1,[9954] = 1}
    CC.PTF[638] = {[638] = 1,[9966] = 1}
    CC.PTF[639] = {[639] = 1,[9908] = 1}
    CC.PTF[640] = {[640] = 1,[9728] = 1,[9954] = 1}
    CC.PTF[641] = {[641] = 1,[9992] = 1,[9991] = 1,[9990] = 1}
    CC.PTF[642] = {[642] = 1}
    CC.PTF[643] = {[643] = 1}
    CC.PTF[644] = {[644] = 1}
    CC.PTF[645] = {[645] = 1}
    CC.PTF[646] = {[646] = 1}
    CC.PTF[647] = {[647] = 1,[9727] = 1}
    CC.PTF[648] = {[648] = 1,[9726] = 1}
    CC.PTF[649] = {[649] = 1,[9789] = 1}
    CC.PTF[650] = {[650] = 1}
    CC.PTF[651] = {[651] = 1,[9746] = 1,[9803] = 1,[9813] = 1,[9820] = 1}
    CC.PTF[652] = {[652] = 1,[9953] = 1,[9725] = 1}
    CC.PTF[653] = {[653] = 1}
    CC.PTF[654] = {[654] = 1}
    CC.PTF[655] = {[655] = 1}
    CC.PTF[656] = {[656] = 1}
    CC.PTF[657] = {[657] = 1,[9984] = 1,[9983] = 1}
    CC.PTF[658] = {[658] = 1,[9987] = 1,[9988] = 1}
    CC.PTF[659] = {[659] = 1}
    CC.PTF[660] = {[660] = 1}
    CC.PTF[661] = {[661] = 1}
    CC.PTF[670] = {[670] = 1,[9974] = 1,[9982] = 1}
    CC.PTF[721] = {[721] = 1,[9965] = 1,[9841] = 1}
    CC.PTF[722] = {[722] = 1,[9937] = 1}	--标记修改
    CC.PTF[723] = {[723] = 1}
    CC.PTF[724] = {[724] = 1}
    CC.PTF[725] = {[725] = 1}
    CC.PTF[726] = {[726] = 1}
    CC.PTF[727] = {[727] = 1}
    CC.PTF[728] = {[728] = 1}
    CC.PTF[729] = {[729] = 1}
    CC.PTF[730] = {[730] = 1}
    CC.PTF[731] = {[731] = 1,[9923] = 1}	--标记修改
    CC.PTF[732] = {[732] = 1,[9915] = 1}	--标记修改
    CC.PTF[733] = {[733] = 1}
    CC.PTF[734] = {[734] = 1}
    CC.PTF[735] = {[735] = 1}
    CC.PTF[736] = {[736] = 1}
    CC.PTF[737] = {[737] = 1,[9937] = 1}	--标记修改
    CC.PTF[738] = {[738] = 1,[9924] = 1}
    CC.PTF[739] = {[739] = 1,[9922] = 1}	--标记修改
    CC.PTF[740] = {[740] = 1,[9921] = 1}	--标记修改
    CC.PTF[741] = {[741] = 1,[9920] = 1}	--标记修改
    CC.PTF[742] = {[742] = 1,[9914] = 1}--标记修改
    CC.PTF[743] = {[743] = 1}
    CC.PTF[744] = {[744] = 1}
    CC.PTF[745] = {[745] = 1}
    CC.PTF[746] = {[746] = 1}
    CC.PTF[747] = {[747] = 1}
    CC.PTF[748] = {[748] = 1,[9916] = 1}
    CC.PTF[749] = {[749] = 1}
    CC.PTF[750] = {[750] = 1}
    CC.PTF[751] = {[751] = 1}
    CC.PTF[752] = {[752] = 1,[9934] = 1,[9933] = 1} 
    CC.PTF[753] = {[753] = 1}
    CC.PTF[754] = {[754] = 1,[9916] = 1,[9953] = 1}
    CC.PTF[755] = {[755] = 1}
    CC.PTF[756] = {[756] = 1}
    CC.PTF[757] = {[9777] = 1,[9778] = 1} 


    CC.Personcj = {}
    --1名称，2奖励名称，3奖励属性，4说明，5等级，6奖励类型（1为属性，2为物品，3为TF）,7获得成就为1未获得为0
    CC.Personcj[1] = {"一骑当千","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",4,1,1} 
    CC.Personcj[2] = {"成就二","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",4,1,0}
    CC.Personcj[3] = {"成就三","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",5,1,0}
    CC.Personcj[4] = {"成就四","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",2,1,0}
    CC.Personcj[5] = {"成就五","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",1,1,0}
    CC.Personcj[6] = {"成就六","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",2,1,0}
    CC.Personcj[7] = {"成就七","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",5,1,0}
    CC.Personcj[8] = {"成就八","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",4,1,0}
    CC.Personcj[9] = {"成就九","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",3,1,0}
    CC.Personcj[10] = {"成就十","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",3,1,0}
    CC.Personcj[11] = {"成就十一","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",3,1,0}
    CC.Personcj[12] = {"成就十二","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",4,1,0} 
    CC.Personcj[13] = {"成就十三","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",4,1,0}
    CC.Personcj[14] = {"成就十四","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",5,1,0}
    CC.Personcj[15] = {"成就十五","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",2,1,0}
    CC.Personcj[16] = {"成就十六","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",1,1,0}
    CC.Personcj[17] = {"成就十七","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",2,1,0}
    CC.Personcj[18] = {"成就十八","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",5,1,0}
    CC.Personcj[19] = {"成就十九","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",4,1,0}
    CC.Personcj[20] = {"成就二十","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",3,1,0}
    CC.Personcj[21] = {"成就二十一","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",3,1,0}
    CC.Personcj[22] = {"成就二十二","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",3,1,0}
    CC.Personcj[23] = {"一骑当千","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",4,1,0} 
    CC.Personcj[24] = {"成就二","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",4,1,0}
    CC.Personcj[25] = {"成就三","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",5,1,0}
    CC.Personcj[26] = {"成就四","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",2,1,0}
    CC.Personcj[27] = {"成就五","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",1,1,0}
    CC.Personcj[28] = {"成就六","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",2,1,0}
    CC.Personcj[29] = {"成就七","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",5,1,0}
    CC.Personcj[30] = {"成就八","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",4,1,0}
    CC.Personcj[31] = {"成就九","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",3,1,0}
    CC.Personcj[32] = {"成就十","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",3,1,0}
    CC.Personcj[33] = {"成就十一","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",3,1,0}
    CC.Personcj[34] = {"成就十二","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",4,1,0}
    CC.Personcj[35] = {"成就十三","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",4,1,0}
    CC.Personcj[36] = {"成就十四","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",5,1,0}
    CC.Personcj[37] = {"成就十五","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",2,1,0}
    CC.Personcj[38] = {"成就十六","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",1,1,0}
    CC.Personcj[39] = {"成就十七","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",2,1,0}
    CC.Personcj[40] = {"成就十八","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",5,1,0}
    CC.Personcj[41] = {"成就十九","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",4,1,0}
    CC.Personcj[42] = {"成就二十","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",3,1,0}
    CC.Personcj[43] = {"成就二十一","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",3,1,0}
    CC.Personcj[44] = {"成就二十二","攻击力",2,"在襄阳大战中，只上阵主角且三回合内击败蒙哥。",3,1,0}

end

--删除指定元素
function removebyvalue(array, value, removeadll)
	--    table中删除指定元素(非根据索引)
	--    array 要操作的容器
	--    value 删除value值
	--    removeadll 是否删除所有相同的值
	--    返回删除值的个数
    --    deleteNum用于接收/返回删除个数; i/max 构成控制while循环
    local deleteNum,i,max=0,1,#array
    while i<=max do
        if array[i] == value then
            --    通过索引操作表的删除元素
            table.remove(array,i)
            --    标记删除次数
            deleteNum = deleteNum+1 
            i = i-1
            --    控制while循环操作
            max = max-1
            --    判断是否删除所有相同的value值
			if not removeadll then 
				break 
			end
        end
        i= i+1
    end
    --    返回删除次数
    return deleteNum
end

--删除相当元素
function TableUnique(t)
    local check = {} 
    local n = {}
    for key, value in pairs(t) do
        if not check[value] then
            n[key] = value
            check[value] = value
        end
    end
    return n
end
-- 方法1：使用辅助表记录已出现的元素（适用于可哈希的元素）
function removeDuplicates(array)
    local seen = {}  -- 记录已出现的元素
    local result = {}
    
    for _, value in ipairs(array) do
        if not seen[value] then
            table.insert(result, value)
            seen[value] = true
        end
    end
    
    return result
end

--门派人物分类 喵姐
function MpRwfenlei()
	local s = CONFIG.CurrentPath.."门派人物分类"
	local file = io.open(s, "w");
	assert(file);
	local a = {}
	for i = 0,JY.PersonNum - 1 do 
		if JY.Person[i]['门派'] >= 0 then 
			local n = JY.Person[i]['门派']
			if a[n] == nil then 
				a[n] = {}
			end
			a[n][#a[n]+1] = i
		end
	end

	for i,v in pairs(a) do 
		if v ~= nil then 
			file:write(string.format('CC.MpRw[%d] = {',i))
			for j = 1,#v do
				file:write(v[j])
				if j < #v then 
					file:write(",")
				end
			end
			file:write("}")
			file:write("\n");
		end
	end
	file:close();
end

--门派武功分类 喵姐
function MpKffenlei()
	local s = CONFIG.CurrentPath.."门派武功分类"
	local file = io.open(s, "w");
	assert(file);
	local a = {}
	for i = 0,JY.WugongNum - 1 do 
		if JY.Wugong[i]['门派'] >= 0 and i > 0 then 
			local n = JY.Wugong[i]['门派']
			if a[n] == nil then 
				a[n] = {}
			end
			a[n][#a[n]+1] = i
		end
	end

	for i,v in pairs(a) do 
		if v ~= nil then 
			file:write(string.format('CC.MpKf[%d] = {',i))
			for j = 1,#v do
				file:write(v[j])
				if j < #v then 
					file:write(",")
				end
			end
			file:write("}")
			file:write("\n");
		end
	end
	file:close();
end

--老顾商店
function LgShop(menu,Currency,Currency_wz)
	--lib.Debug("ZmShop");
	local bx,by = CC.WX,CC.HY
	--local menu = {}				
	local size = CC.FontSmall2 
	local menu1 = {} 
	local color = C_WHITE1
	local newArray = {}
	local thingnum = {}
	local gounum = {}
	local danjia = {}
	local SHUOMING = {}
	--menu = CC.commodity
	for i = 1,#menu do
		menu1[#menu1+1] = menu[i][1]
		danjia[#danjia+1] = menu[i][2]
		thingnum[#thingnum+1] = menu[i][3]
		SHUOMING[#SHUOMING+1] = JY.Thing[menu[i][1]]['物品说明']
		gounum[#gounum+1] = 0		
	end
	
	local w,h = lib.GetPNGXY(2,1*2)
	local x,y = (CC.ScreenW/2-w*7/8) - w/2 ,(CC.ScreenH/2 - h*9/7)+CC.ScreenH/20
	local px,py = -1,-1
	local n,m = 0,0	
	local pg = 1
	local pgnum,numm = math.modf(#menu1/25)
	pgnum = pgnum + 1
	local lb = 25
	local tb = 1
	local tb1 = 0
	local pg = 1
	local thingid = 0
	local xx = w*13/12
	local yy = h*13/12
	local x1,y1 = lib.GetPNGXY(91,10*2)
	local x2,y2 = lib.GetPNGXY(91,50*2)
	local tmenu1 = {}
	local tmenu2 = {}
	local tmenu3 = {}
	local tmenu4 = {}
	local tmenu5 = {}
	local tmenu6 = {}
	local goumenu = {}
	local wpnum = {}
	local zongjia = 0
	local w1,h1 = lib.GetPNGXY(91,21*2)
	local smwz = 0
	local sm = {'客官，本店商*品，一经结账*不退不换。','客官，您莫逗*小的乐子，本*店概不赊账。','客官，一次最*多可以购买*十五件商品。'}
	local size = CC.Fontsmall
	while true do
		if JY.Restart == 1 then 
			break 
		end
		Cls()
		lib.LoadPNG(91,10*2,0,0,1)
		lib.DrawStr(CC.ScreenW/2-w/2,h/5+h/50,'周 目 商 店',C_GOLD,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)

		if lb < #menu1 then
			lb = #menu1
		end
		if pg < pgnum then 
			lb = 25
		elseif pg == pgnum then 
			lb = #menu1 - 25*(pgnum-1) 
		end

		for j = 1,lb do 
			thingid = j + 25*(pg-1)
			lib.PicLoadCache(2, menu1[thingid] * 2, x+xx*(n-1),y+yy*(m-1), 2,256)
			lib.LoadPNG(91, 70 * 2, x+xx*(n-1),y+yy*(m-1), 2)
			lib.DrawStr(x+xx*(n-1)-w/2+w/10,y+yy*(m-1)-h/2,thingnum[thingid],C_CYGOLD,size*0.6, CONFIG.CurrentPath.."FONT/3.TTF",  0, 0)
			if tb == j then 
				
				lib.LoadPNG(91,50*2,x+xx*(n-1)-x2/2,y+yy*(m-1)-y2/2,1)				
				DrawString(CC.ScreenW-x1-h/3,h-h/3,'物品名称: ',C_CYGOLD,size*0.9)
				DrawString(CC.ScreenW-x1+w,h-h/3,JY.Thing[menu1[thingid]]['名称'],M_DeepSkyBlue,size*0.9)
				DrawString(CC.ScreenW-x1+w*2,h-h/3,'       单价：',C_CYGOLD,size*0.9)
				DrawString(CC.ScreenW-x1+w*3+w/2,h-h/3,danjia[thingid],M_DeepSkyBlue,size*0.9)
				DrawString(CC.ScreenW-x1-h/3,h,'效果： '..SHUOMING[thingid],C_RED,size*0.9)
			end
			n = n + 1 
			if n == 5 then 
				m = m + 1
				n = 0
			end
		end
		n = 0
		m = 0
		lib.DrawStr(CC.ScreenW-x1,h+h*5+h/2,'存 款：'..zongjia..'/'..Currency..'('..Currency_wz..')',C_CYGOLD,size*0.8, CONFIG.CurrentPath.."FONT/3.TTF",  0, 0)
		lib.DrawStr(CC.ScreenW-x1+w*3+w*2/3,h+h*5+h/2,'页数：'..pg..'/'..pgnum,C_CYGOLD,size*0.8, CONFIG.CurrentPath.."FONT/3.TTF",  0, 0)
		lib.Background(x1+w/10,y/10-y/15,CC.ScreenW-w/10,CC.ScreenH-h*2/3,98)
		lib.DrawStr(CC.ScreenW/2+w*4,h/5,'购 物 车',M_DeepSkyBlue,size*1.2, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)	
		lib.DrawStr(CC.ScreenW-w*4,h*6,'总 价：',M_DeepSkyBlue,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)	
		lib.DrawStr(CC.ScreenW-w*3,h*6,zongjia..'('..Currency_wz..')',C_RED,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)		
		for i = 1,#goumenu do 					
			DrawString(CC.ScreenW-w*4,h-h/3+(i-1)*h*4/10,JY.Thing[menu1[goumenu[i]]]['名称'],C_CYGOLD,size)
			DrawString(CC.ScreenW-w*2,h-h/3+(i-1)*h*4/10,gounum[goumenu[i]]/gounum[goumenu[i]],C_CYGOLD,size)
			DrawString(CC.ScreenW-w,h-h/3+(i-1)*h*4/10,danjia[goumenu[i]],C_CYGOLD,size)
		end
		for i = 1,2 do 
			local jzw = {"结账",'退出'}
			local cl = M_DeepSkyBlue
			if tb1 == i then 
				cl = C_RED
			end
			lib.LoadPNG(91,21*2,CC.ScreenW/2+w*5-w/2+w*(i-1)-w1/5,h*6+h/2-h1/13,1,0,100)
			lib.DrawStr(CC.ScreenW/2+w*5-w/2+w*(i-1),h*6+h/2,jzw[i],cl,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)	
		end
		local sayne = sm[1]
		local color = M_Pink
 		if smwz == 1 then 
			sayne = sm[2]
			color = C_RED
		 elseif smwz == 2 then 
			sayne = sm[3]
			color = C_RED
		end
		tjm(w/3,h-h/11,sayne,color,size*0.8,16,size)
		ShowScreen()
		lib.Delay(CC.Frame)	
		local key, ktype, mx, my = lib.GetKey();
		if key == VK_ESCAPE or ktype == 4 then 
			if smwz > 1 then 
				smwz = 0
			else
				break
			end
		elseif key == VK_RETURN or key == VK_SPACE then 
			if tb1 > 0 then 
				if tb1 == 1 then 
					if instruct_31(zongjia) ==false then 
						smwz = 1
					else
						Currency = Currency - zongjia
						--CC.Sp = JY.Base["碎片"]
						for i = 1,#goumenu do 
							instruct_32(menu1[goumenu[i]],gounum[goumenu[i]])
						end
						break
					end
				elseif tb1 == 2 then 
					break
				end
			else
				thingid = tb + 25*(pg-1)
                if thingnum[thingid] > 0 then 					
                    if #goumenu < 13  then                         
                        goumenu[#goumenu+1] = thingid
                        thingnum[thingid] = thingnum[thingid] - 1
                        gounum[thingid] = gounum[thingid] + 1
                        if gounum[thingid] > 1 then 
                            gounum[thingid]  = 1
                        end
                        zongjia = zongjia + danjia[thingid]
                    else
                        smwz = 2
                    end
                end
			end
		elseif key == VK_RIGHT then
			tb = tb + 1
			if pg < pgnum then 
				if tb > lb then 
					tb = lb 
					tb1 = tb1 + 1
					if tb1 > 2 then 
						tb1 = 1
					end
				end
			else
				if tb > lb then 
					tb = lb
					tb1 = tb1 + 1
					if tb1 > 2 then 
						tb1 = 1
					end
				end
			end
		elseif key == VK_LEFT then
			if tb1 > 0 then 
				tb1 = tb1 - 1
				if tb1 < 1 then 
					tb1 = 0
					tb = lb - 1 
				end
			else
				tb = tb - 1
				if tb < 1 then 
					if pg > 1 then 
						pg = pg - 1
						tb = 25 
					else
						tb = lb 
					end
				end
			end
		elseif key == VK_DOWN or ktype == 7 then
			tb = tb + 5 
			if pg < pgnum then 
				if tb >= 25 then 
					pg = pg + 1
					tb = 1
				end
			else
				if tb  > lb then 
					tb = lb
				end
			end
		elseif key == VK_UP or ktype == 6 then 			
			if pg > 1 then 
				tb = tb - 5 
				if tb < 1 then 
					pg = pg - 1
					tb = 25
				end
			else
				if tb > 5 then 
					tb = tb - 5
					if tb < 1 then 
						tb = 1
					end
				end
			end
		else
			local pd = false
			for j = 1,lb do 
				thingid = j + 25*(pg-1)
				if mx >= x + xx*(n-1) -w/2 and mx < x + xx*(n-1) + w - w/2 and my >= y + yy*(m-1) -h/2 and my < y + yy*(m-1) + h-h/2 then 
					if thingnum[thingid] > 0 then 
						tb = j 
						pd = true 
						break
					end
				end
				n = n + 1
				if n == 5 then 
					n = 0
					m = m + 1
				end
			end
			n = 0
			m = 0
			if pd == true and ktype == 3 then 
				if thingnum[thingid] ~= nil  then 
					if #goumenu < 13 then 
						goumenu[#goumenu+1] = thingid
						thingnum[thingid] = thingnum[thingid] - 1
						gounum[thingid] = gounum[thingid] + 1
						zongjia = zongjia + danjia[thingid]
					else
						smwz = 2
					end
				end
			end
			local pd1 = false
			for i = 1,2 do 
				if mx >= CC.ScreenW/2+w*5-w/2+w*(i-1)-w1/5 and mx < CC.ScreenW/2+w*5-w/2+w*(i-1)-w1/5 + w1 and my >= h*6+h/2-h1/13 and my < h*6+h/2-h1/13 + h1 then 
					tb1 = i 
					pd1 = true
				end
			end
			if pd1 == true and ktype == 3 then 
				if tb1 == 1 then 
					if Currency - zongjia < 0 then 
						smwz = 1
					else						
						Currency = Currency - zongjia 
						for i = 1,#goumenu do 
							instruct_32(menu1[goumenu[i]],gounum[goumenu[i]])
						end
						break
					end
				elseif tb1 == 2 then 
					break
				end
			end
		end
	end
end

--闯天关天赋
function TGTF()
    local tb = 1
	local tb1 = 0
    local size = CC.DefaultFont*0.7
    local pg = 1
    local menu = {}
	local w1,h1 = lib.GetPNGXY(91,139*2)
    local w = math.modf(w1/size)
	local zm = JY.Base["周目"]
	local zmtf = math.ceil(zm/4)
	local lbnum = 54
	local rwnum = 6
	local hh1 = 0
	local lb = lbnum
	local tfid = 0
	local x,y = CC.ScreenW/4,CC.ScreenH/9
	local n,m = 0,0
	local x1 = x*2-x/3
	local y1 = y*3/2+y/3+y/10
	local yy = h1*3/2
	local xx = w1*8/7
	local fymenu = {'上一页','下一页','确  定','删  除','返  回'}
	local tfmax = 0
	local tfn = 0
	local xzmenu = 0
	local xzid = '无'
	local xzsm = ''
	local xztf = 0
	local xzme = {}
	local hnum = lbnum/rwnum
	local sme = 0
	local smenu = {}

	for i = 1,#CC.Tiangtf do
		menu[#menu+1] = {CC.Tiangtf[i],0}
	end	
	for i = 1,#menu do
		for j = 1,#CC.TGJL do 
			if CC.TGJL[j] == menu[i][1] then 
				menu[i][2] = 1
			end
		end
        --menu[#menu+1] = {CC.TGJL[i],1}
    end
    if #menu <= 0  then
        return   
    end

	local num = math.modf(#menu/lbnum)
	num = num + 1
    if #menu <= 0  then
        return   
    end
    while true do
	   if JY.Restart == 1 then
            break
       end	
        ClsN()
        lib.LoadPNG(91,24*2,-1,-1,1)
		local str = '天关天赋大全'
		DrawString(CC.ScreenW/2-string.len(str)/4*size*1.3,CC.ScreenH/768*20,str,C_WHITE1,size*1.3,CC.FONT1)
		
		if lb > #menu then 
			lb = #menu 
		end
		if pg < num then 
			lb = lbnum
		elseif pg == num then 
			lb = #menu - (num-1)*lbnum
		end
	   	for i = 1,lb do 
			local cl = C_WHITE1	
			if menu[i + (pg-1)*lbnum][2] == 0 then 
				cl = M_DimGray
			end
			if tb == i then 
				cl = C_RED
			end
			local sm = CC.PTFSM[menu[i + (pg-1)*lbnum][1]]
			lib.Background(x1+(n-1)*xx-w1/2,y1+(m-1)*yy-h1/2+hh1,x1+(n-1)*xx-w1/2+w1,y1+(m-1)*yy-h1/2+h1+hh1,98)
			DrawString(x1+(n-1)*xx-string.len(sm[1])/4*size,y1+(m-1)*yy-h1/3+hh1,sm[1],cl,size)
			n = n + 1
			if n == rwnum then 
				m = m + 1
				n = 0
			end
		end
        n = 0
		m = 0
		if #xzme == tfmax then 
			fymenu = {'上一页','下一页'}
		end
		for i = 1,#fymenu do 
			local cl = C_WHITE1	
			if tb1 == i  then 
				cl = C_RED
			end
			lib.Background(x1+(i-2)*xx-w1/2,y1+(hnum)*yy-h1/2+hh1,x1+(i-2)*xx-w1/2+w1,y1+(hnum)*yy-h1/2+h1+hh1,98)
			DrawString(x1+(i-2)*xx-string.len(fymenu[i])/4*size,y1+(hnum)*yy-h1/3+hh1,fymenu[i],cl,size)
		end
		DrawString(x1+(3-2)*xx-string.len(fymenu[1])/4*size,y1+(hnum)*yy-h1/3+hh1,'白色文字的是已获得的天赋，灰色是没有获得的天赋',M_LightBlue,size)
		local pgwz = '页数： '..pg..' / '..num 
		DrawString(x1+xx*3+-string.len(pgwz)/4*size,h1*2/3,pgwz,M_DeepSkyBlue,size)
		local tfh = 0
		local tfsm = 0
		--选择天赋查看
		local tfid = CC.PTFSM[menu[tb + (pg-1)*lbnum][1]]
		DrawString(x1/12,y1-yy-h1/3,'天赋名称： ',C_WHITE1,size)
		DrawString(x1/5-string.len(tfid[1])/4*size+size*4,y1-yy-h1/3,tfid[1],M_DeepSkyBlue,size)
		tfsm = tfsm + 1
		tfsm = tjm(x1/12,y1-yy+h1,tfid[2],C_WHITE,size,9,size)
		
		for i = 1,#xzme do
			if xzme[i] ~= nil then 
				local xid = xzme[i]
				local xidwz = CC.PTFSM[xid][1]
				DrawString(x1/12,y1-yy-h1/3+y1*2+size*3,'已选天赋： ',C_WHITE1,size)
				DrawString(x1/4-string.len(xidwz)/4*size,y1-yy-h1/3+y1*2+size*2+(i-1)*size*2+size*3,xidwz,M_DeepSkyBlue,size)
			end
		end	

		if sme == 1 then 
			DrawString(x1/12+size*9,CC.ScreenH-size*7,'无法选择更多天赋，请点击【下一步】进入游戏',C_RED,size*2)
		end
        ShowScreen()
        lib.Delay(CC.Frame)
        local X, ktype, mx, my = lib.GetKey();
		if X == VK_SPACE or X == VK_RETURN then
			PlayWavE(77)
			if tb1 == 1 then 
				if pg > 1 then 
					pg = pg - 1
				end 
			elseif tb1 == 2 then 
				if pg < num  then 
					pg = pg + 1
					tb = 1
				end
			end			
		elseif X == VK_ESCAPE or ktype == 4 then
			PlayWavE(77)
			if sme == 1 then 
				sme = 0
			else
				if tb1 > 0 then 
					tb1 = 0
				else
					break
				end	
			end		
		elseif X == VK_UP then
			if tb1 == 0 then 
				if tb - rwnum > 1 then 
					tb = tb - rwnum 
				end
			else
				tb = lb 
				tb1 = 0
			end
		elseif X == VK_DOWN then
			PlayWavE(77)
			if tb1 == 0 then 
				if tb + rwnum < lb then
					tb = tb + rwnum 
				else 
					tb1 = 1
				end	
			end	
		elseif X == VK_LEFT then
			PlayWavE(77)
			if tb1 == 0 then 
				tb = tb - 1
				if tb < 1 then 
					tb = 1
				end
			else
				tb1 = tb1 - 1
				if tb1 < 1 then 
					tb1 = #fymenu
				end
			end
		elseif X == VK_RIGHT then
			PlayWavE(77)
			if tb1 == 0 then 
				tb = tb + 1
				if tb > lb then 
					tb = lb 
				end
			else
				tb1 = tb1 + 1
				if tb1 > #fymenu then 
					tb1 = 1
				end
			end
        else
			local pd =false 
			for i = 1,lb do 
				--lib.Background(x1+(n-1)*xx-w1/2,y1+(m-1)*yy-h1/2,x1+(n-1)*xx-w1/2+w1,y1+(m-1)*yy-h1/2+h1,98)
				if mx >= x1+(n-1)*xx-w1/2 and mx < x1+(n-1)*xx-w1/2+w1 and my >= y1+(m-1)*yy-h1/2+hh1 and my < y1+(m-1)*yy-h1/2+h1+hh1 then 

					if tb1 == 0 then
						tb = i 
						pd = true
					end
					break
				end
				n = n + 1
				if n == rwnum then 
					n = 0
					m = m + 1
				end
			end
			n = 0
			m = 0
			if pd == true and ktype == 3 then
				tb1 = 1
				xztf = menu[tb + (pg-1)*lbnum][1]
			end	
			local pd1 = false
			for i = 1,#fymenu do 
				if mx >=x1+(i-2)*xx-w1/2 and mx < x1+(i-2)*xx-w1/2+w1 and my >= y1+(hnum)*yy-h1/2+hh1 and my < y1+(hnum)*yy-h1/2+h1+hh1 then 								
					tb1 = i 
					pd1 = true
					break
				end
			end
			if pd1 == true and ktype == 3 then 
				PlayWavE(77)
				if tb1 == 1 then 
					if pg > 1 then 
						pg = pg - 1
						tb = lb
					end 
				elseif tb1 == 2 then 
					if pg < num  then 
						pg = pg + 1
						tb = 1
					end
				end	
			end
        end
    end
end


--武功图鉴说明
function KF_sm(id,kf)
	local bx,by = CC.ScreenW/1360,CC.ScreenH/768
	local STARTH1,WGSTARTH,WGSTARTH1,Mstarth =0,0,0,0
	local FY1,h,h2,SHUOMING,xlsm,Mfy = 0,0,0,0,0,0
	local zsnum ,hg,sf,FY,WGFY,WGFY1= 0,40,0,0,0,0
	local size = CC.DefaultFont*0.9
	local wgzbx,wgzby = CC.ScreenW/3,CC.ScreenH/2 - size*6.5
	local jjwz = {"初窥门径", "初窥门径", "略有小成", "略有小成", "渐入佳境", "渐入佳境", "融会贯通", "融会贯通", "炉火纯青", "炉火纯青", "登峰造极"}
	local djwz = {"一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "极"}
	local pjwz = {"Ｗ".."初阶武功","Ｌ".."中阶武功","Ｒ".."高阶武功","Ｇ".."绝学武功"}	
	local zsh,zsw = size*1.5,size*1.1 --招式部分的文字坐标控制
	local smtb1 = 1
	local smtb2 = 0 
	local function wugong_info(thingID)
		----lib.Debug(thingID);
		local h1 = 0
		local me = {}
		local hs1 = 0
		local myh1 = 7
		local mm = 1
		if JY.Thing[thingID]["练出武功"] > 0 then
			mm = 2
		end		
		lib.LoadPNG(91,372*2,wgzbx-size*2,wgzby-CC.ScreenH/2.8,1)
		local function strcolor_switch(s)
			local Color_Switch={{"Ｒ",PinkRed},{"Ｇ",M_Wheat},{"Ｂ",C_BLACK},{"Ｗ",RGB(178,158,124)},{"Ｏ",C_ORANGE},{"Ｌ",LimeGreen},{"Ｄ",M_DeepSkyBlue},{"Ｚ",Violet}}
			for i = 1, 8 do
				if Color_Switch[i][1] == s then
					return Color_Switch[i][2]
				end
			end
		end
		if ItemInfo[thingID] ~=  nil  then
			for i = 1,#ItemInfo[thingID] do
				me[#me+1] =ItemInfo[thingID][i]
				if i == ItemInfo[thingID] then
					me[#me+1] = "Ｎ"
				end				
			end
		else
			me[#me+1] = ''
		end		
		for i = mm, #me do
			local smsize = CC.DefaultFont*0.75
			local tfstr = me[i]
			local color;
			color = strcolor_switch(string.sub(tfstr,1,2))
			tfstr = string.sub(tfstr,3,-1)
			if string.sub(tfstr,1,2) == "Ｎ" then
			--	hs1 = hs1 + 1
			else 
				h1 = tjm(size*0.8+wgzbx-size, wgzby + size*8 + smsize*1.1* (hs1-WGSTARTH), tfstr, C_WHITE, smsize,19,smsize*1.1,WGSTARTH-hs1,myh1+1-hs1+WGSTARTH)		
			end			
			hs1 = hs1 + h1
		end
		if hs1 > myh1 then
			FY = limitX(hs1-myh1-1,0)
		else
			FY = 0
		end	
		if 	FY > 0 then 
			lib.LoadPNG(91,124*2,wgzbx-size*1.9,wgzby+size*14,1,0,60) 
		end	
		if WGSTARTH > 0 then 
			lib.LoadPNG(91,127*2,wgzbx-size*1.9,wgzby+size*8,1,0,60) 
		end
	end	
	local function wugong_info1(kf)
		----lib.Debug(thingID);
		local h1 = 0
		local me = {}
		local hs1 = 0
		local myh1 = 6
		local mm = 1

		lib.LoadPNG(91,372*2,wgzbx-size*2,wgzby-CC.ScreenH/2.8,1)
		local function strcolor_switch(s)
			local Color_Switch={{"Ｒ",PinkRed},{"Ｇ",M_Wheat},{"Ｂ",C_BLACK},{"Ｗ",RGB(178,158,124)},{"Ｏ",C_ORANGE},{"Ｌ",LimeGreen},{"Ｄ",M_DeepSkyBlue},{"Ｚ",Violet}}
			for i = 1, 8 do
				if Color_Switch[i][1] == s then
					return Color_Switch[i][2]
				end
			end
		end
		for i =1,10 do 
			local kftx = JY.Wugong[kf]['特效'..i]
			if kftx > 0 then 
				me[#me+1] = NGTX_sm(kf,kftx) 
			end
		end
		for i = 1, #me do
			local smsize = CC.DefaultFont*0.65
			local tfstr = me[i]
			local color;
			color = strcolor_switch(string.sub(tfstr,1,2))
			--tfstr = string.sub(tfstr,3,-1)
			if string.sub(tfstr,1,2) == "Ｎ" then
			--	hs1 = hs1 + 1
			else 
				h1 = tjm(size*0.8+wgzbx-size, wgzby + size*8 + smsize*1.2* (hs1-WGSTARTH), tfstr, C_WHITE1, smsize,21,smsize*1.2,WGSTARTH-hs1,myh1+1-hs1+WGSTARTH,CC.FONT5)	
			end			
			hs1 = hs1 + h1
		end
		if hs1 > myh1 then
			FY = limitX(hs1-myh1-1,0)
		else
			FY = 0
		end			
		if 	FY > 0 then 
			lib.LoadPNG(91,124*2,wgzbx-size*1.9,wgzby+size*14,1,0,60) 
		end	
		if WGSTARTH > 0 then 
			lib.LoadPNG(91,127*2,wgzbx-size*1.9,wgzby+size*8,1,0,60) 
		end
	end	
	local kfsm = 1
	local color = C_WHITE
	local xzwz = {'',''}
	--local xzpic = 
	local mpgx = math.modf(JY.Person[id]['门派贡献']/200)+1
	local kfcj = JY.Wugong[kf]['层级']
	local jxkf = 2
	local cxfj = JY.Person[id]['畅想分阶']
	if cxfj == 1 or cxfj == 2 then 
		jxkf = 4
	elseif cxfj == 3  then 
		jxkf = 3
	elseif cxfj == 4   then 
		--jxkf = 2
	elseif  cxfj == 6 or cxfj == 5 then 
		--jxkf = 1
	end
	if CC.XKF == 1 then 		
		xzwz = {'学习','返回'}

	end
	CC.KFMove[kf][1][3] = 0
	local kf1 = kf 
	local leixing = {91,92,93,94,95,96}
	local lxpic = leixing[JY.Wugong[kf1]["武功类型"]]
	--物品说明显示
	local thid = KF_thing(kf)
	local myThing = JY.Thing[thid]
	local pwz5 = ''
	local pwz6 = ''
	local pwz7 = ''
	local pwz8 = ''

	while true do
		if JY.Restart == 1 then
			 break
		end
		Cls()
		if kfsm > 0 then												
			local cl = color	
			local me = JY.Wugong[kf1]["名称"]
			local wgmp =  MPname[JY.Wugong[kf1]["门派"] + 1]
			local level = 11
			local wugongwl = get_skill_power(id, kf1, level)
			local mz = JY.Wugong[kf1]["加命中"]
			local wz2 = {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15",}						
			if  kf1 > 0 then			
				cl = C_RED	
				local jg1 = size*1.1			
				--武功招式
				local wgbj = 0
				if 	JY.Wugong[kf1]["武功类型"] < 6 then
					wgbj = 286
				else
					wgbj = 287
				end
				if kfsm == 2 then 
					wgbj = 287 
				end
				--新武功说明背景图
				wgbj = 368
				local kfcj1 = JY.Wugong[kf1]["层级"]
				local wgcl = cl 
				if kfcj1 == 1 then
					wgcl = RGB(85,188,254)	
				end
				if kfcj1 == 2 then
					wgcl = M_Purple
				end 
				if kfcj1 == 3 then
					wgcl = Color_Hurt1
				end 
				if kfcj1 == 4 then
					wgcl = C_RED
				end 
				local pwz1,pwz2,pwz3,pwz4 = nil,nil,nil,nil
				lib.LoadPNG(91,wgbj*2,wgzbx-size*2,wgzby-size*10.5,1) 
				--if wlglx
				if JY.Wugong[kf1]['武功类型'] < 6  then 
					if kfsm == 1 then 
						lib.LoadPNG(91,369*2,wgzbx-size*2,wgzby-size*10.5,1)  -- 招式背景
						--lib.Background(wgzbx-size*2,wgzby-size*10.5,wgzbx-size*2+bx*400,wgzby-size*10.5+by*100,98)
						lib.LoadPNG(91,14*2,wgzbx+CC.ScreenW/2.9,wgzby+size*4,1,0,80)  -- 切换武功说明图片
					end
				end
				lib.LoadPNG(91,371*2,wgzbx+size*8,wgzby-size/2,1,0,90)  -- 武功名字背景
				lib.LoadPNG(91,(373+kfcj1)*2,wgzbx-size*2,wgzby-size/1.5,1,0,100)  -- 武功阶级图片		
				lib.DrawStr(wgzbx-string.len(JY.Wugong[kf1]["名称"])/4*size+size*11,wgzby,JY.Wugong[kf1]["名称"], wgcl,size*1.8, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)	--武功名称显示	
					
				local neishu = nil 
				if KF_thing(kf1) ~= nil then 
					 neishu = JY.Thing[KF_thing(kf1)]['需内力性质']
				else 
					neishu = 2
				end
				local neishuwz = {'阴','阳','调和'}
				local neishuwz1 = neishuwz[neishu+1]
				local wglx = {'●'..neishuwz1..'拳','●'..neishuwz1..'指','●'..neishuwz1..'剑','●'..neishuwz1..'刀','●'..neishuwz1..'奇','●'..neishuwz1..'内','●'..neishuwz1..'轻'}
				local wgsize = size*0.8
				local gdz = JY.Wugong[kf1]["层级"]*level
				local sm = JY.Wugong[kf1]["层级"]*100+wugongwl
				local hq = 0
				if JY.Wugong[kf1]["层级"] == 4 then
					hq = 2
				elseif JY.Wugong[kf1]["层级"] == 3 then
					hq = "1~2"
				elseif JY.Wugong[kf1]["层级"] == 2 then
					hq = 1
				elseif JY.Wugong[kf1]["层级"] == 1 then
					hq = "0~1"								
				end	
				if 	JY.Wugong[kf1]["武功类型"] < 6 then
					pwz1 = "威力"..":  "..math.modf(wugongwl)
					pwz2 = "命中"..":  "..mz
					pwz3 = "格档"..":  "..gdz
					pwz4 = ""
				elseif JY.Wugong[kf1]["武功类型"] == 6 then
					pwz1 = "生命"..":  "..sm
					pwz2 = "气防"..":  "..math.modf(wugongwl)
					pwz3 = "格档"..":  "..gdz
					pwz4 = "回气"..":  "..hq
				else
					pwz1 = "命中"..":  "..JY.Wugong[kf1]["加命中"]
					pwz2 = "闪避"..":  "..JY.Wugong[kf1]["加闪避"]
					pwz3 = "移动"..":  "..""
					pwz4 = "集气"..":  "..""
				end
				local function drawitem(ss,str,news)
					--local myThing = JY.Thing[kf_thing(kf)]
					local color = C_GOLD
					local mys
					local myflag = 1
					if str==nil then
						mys=ss
					elseif myThing[ss]~=0 then
						if news==nil then
							if myflag==0 then
								--无酒不欢：装备的数值随等级变化
								if myThing["装备位置"] > -1 then
									local attr_gain = 0;
									if myThing[ss] > 0 then
										attr_gain = myThing[ss]*10 + myThing[ss]*(myThing["装备等级"]-1)*2
									elseif myThing[ss] < 0 then
										attr_gain = myThing[ss]*10 - myThing[ss]*(myThing["装备等级"]-1)*2
									end
									if attr_gain ~= 0 then
										--mys=string.format(str..':%+d',attr_gain)
										mys = str..attr_gain
									end
								else
									--mys=string.format(str..':%+d',myThing[ss])
									mys = str..myThing[ss]
								end
							elseif myflag==1 then
								local id = KF_thing(kf)
								local wugong = JY.Thing[id]["练出武功"];
								--mys=string.format(str..':%d',myThing[ss])
								mys = str..myThing[ss]
							end
						else
							if myThing[ss]<0 then
								return
							end
							--mys=string.format(str..':%s',news[myThing[ss]])
							mys = str..news[myThing[ss]]
						end
						--内属颜色
						if myThing[ss]==1 and ss=="需内力性质" then
							color = RGB(236, 200, 40)
						elseif myThing[ss]==2 and ss=="需内力性质" then
							color = RGB(236, 236, 236)
						end
					elseif myThing[ss]==0 and ss=="需内力性质" then
						mys=string.format(str..':%s',news[myThing[ss]])
						mys = str..news[myThing[ss]]
						color = RGB(208, 152, 208)
					else
						return
					end
					--DrawString(mx+CC.MenuBorderPixel,my+CC.MenuBorderPixel+CC.ScreenH/1.5,mys,color,myfont)
					pwz5 = pwz5..' '..mys
				end
				if myThing['类型'] > 0 then
					if thid> 343 or thid < 348 then	--特殊药品不显示
						--DrawString(wgzbx, y3_2 + 2+CC.MenuBorderPixel+CC.ScreenH/1.5, " 效果:", LimeGreen, myfont)
						pwz6 = "属性："
					end	
					if myThing['加生命最大值'] > 0 then 
						pwz6 = pwz6..' '..'生命+'..myThing['加生命最大值']
					end
					if myThing['改变内力性质'] == 2 then 
						pwz6 = pwz6..' '..'内力属性变为调和'
					end
					if myThing['加攻击力'] > 0 then 
						pwz6 = pwz6..' '..'攻击+'..myThing['加攻击力']
					end
					if myThing['加防御力'] > 0 then 
						pwz6 = pwz6..' '..'防御+'..myThing['加防御力']
					end
					if myThing['加轻功'] > 0 then 
						pwz6 = pwz6..' '..'轻功+'..myThing['加轻功']
					end
					if myThing['加医疗能力'] > 0 then 
						pwz6 = pwz6..' '..'医疗+'..myThing['加医疗能力']
					end
					if myThing['加用毒能力'] > 0 then 
						pwz6 = pwz6..' '..'用毒+'..myThing['加用毒能力']
					end
					if myThing['加解毒能力'] > 0 then 
						pwz6 = pwz6..' '..'解毒+'..myThing['加解毒能力']
					end
					if myThing['加抗毒能力'] > 0 then 
						pwz6 = pwz6..' '..'抗毒+'..myThing['加抗毒能力']
					end
					if myThing['加拳掌功夫'] > 0 then 
						pwz6 = pwz6..' '..'拳掌+'..myThing['加拳掌功夫']
					end
					if myThing['加指法技巧'] > 0 then 
						pwz6 = pwz6..' '..'指腿+'..myThing['加指法技巧']
					end
					if myThing['加御剑能力'] > 0 then 
						pwz6 = pwz6..' '..'御剑+'..myThing['加御剑能力']
					end
					if myThing['加耍刀技巧'] > 0 then 
						pwz6 = pwz6..' '..'耍刀+'..myThing['加耍刀技巧']
					end
					if myThing['加特殊兵器'] > 0 then 
						pwz6 = pwz6..' '..'特殊兵器+'..myThing['加特殊兵器']
					end
					if myThing['加暗器技巧'] > 0 then 
						pwz6 = pwz6..' '..'暗器+'..myThing['加暗器技巧']
					end
					if myThing['加武学常识'] > 0 then 
						pwz6 = pwz6..' '..'武常+'..myThing['加武学常识']
					end
					if myThing['加攻击次数'] > 0 then 
						pwz6 = pwz6..' '..'左右+'..myThing['加攻击次数']
					end
					if myThing['加攻击带毒'] > 0 then 
						pwz6 = pwz6..' '..'带毒+'..myThing['加攻击带毒']
					end				
					--武器装备威力加成
					for i,v in ipairs(CC.ExtraOffense) do
						if v[1] == thid then
							--DrawString(mx+CC.MenuBorderPixel+CC.ScreenW/68.4,my+CC.MenuBorderPixel+CC.ScreenH/1.5,"威力强化:"..JY.Wugong[v[2]]["名称"].."+"..v[3],PinkRed,myfont)
						end
					end

				end
				--需求:
				if myThing['类型']==2 then
					pwz5 = '需求:'
					if myThing['仅修炼人物']>-1 then
						drawitem('仅限:'..JY.Person[myThing['仅修炼人物']]['姓名'])
					end
					drawitem('需内力性质','内属',{[0]='阴','阳','不限'})
					drawitem('需内力','内力')
					drawitem('需攻击力','攻击')
					drawitem('需轻功','轻功')
					drawitem('需用毒能力','用毒')
					drawitem('需医疗能力','医疗')
					drawitem('需拳掌功夫','拳掌')
					drawitem('需指法技巧','指法')
					drawitem('需御剑能力','御剑')
					drawitem('需耍刀技巧','耍刀')
					drawitem('需特殊兵器','特殊')
					drawitem('需暗器技巧','暗器')
					if thid == 372 then 
						drawitem('需80>资质>30')
					end
					--斗转的显示
					local exstr = ''
					if thid == 118 then
						exstr = "五系兵器值之和>=120 "						
					end
					--阴阳的显示
					if thid == 176 then
						exstr = "御剑/耍刀/特殊任一项>=70 "
					end
					pwz5 = pwz5..' '..exstr
					local wugong = JY.Thing[thid]["练出武功"]	
					drawitem('需资质','资质')
					--DrawString(dx+CC.MenuBorderPixel+CC.ScreenW/68.4,my2+CC.MenuBorderPixel+CC.ScreenH/1.5,' 需求:',LimeGreen,myfont)	
						
				end
				DrawString(wgzbx,wgzby,"门派"..":  "..wgmp..' '..wglx[JY.Wugong[kf1]['武功类型']],C_BLACK,wgsize)  --门派 第一排文字
				DrawString(wgzbx,wgzby+jg1,"修为"..":  "..jjwz[level].." ".."("..djwz[level]..")",C_BLACK,wgsize)  --修为 第二排文字
				DrawString(wgzbx,wgzby+jg1*2,pwz1,C_BLACK,wgsize) --第三排文字
				DrawString(wgzbx,wgzby+jg1*3,pwz2,C_BLACK,wgsize) --第四排文字
				DrawString(wgzbx,wgzby+jg1*4,pwz3..'   '..pwz4,C_BLACK,wgsize) --第五排文字
				DrawString(wgzbx,wgzby+jg1*5,pwz5,C_BLACK,wgsize) --第六排文字
				DrawString(wgzbx,wgzby+jg1*6,pwz6,C_BLACK,wgsize) --第七排文字
				--DrawString(wgzbx,wgzby+jg1*5,pwz4,C_WHITE,wgsize) --第四排文字
				local wglx2 = {'拳法','指法','剑法','刀法','奇门','内功','轻功',}
				local wgcj = {'初阶','中阶','高阶','绝学',}
				local lx3 = JY.Wugong[kf1]['武功类型']	
				local wgcj1 = wgcj[JY.Wugong[kf1]['层级']]
				local kfsmwz = wgmp..wgcj1..wglx2[lx3]
				local kfx,kfy = size*8,size*2	
				if KF_thing(kf1) ~= nil then 												
					--local size5 = CC.FONT2
					local row = 1
					local fy = 0
					local h = 0	
					if JY.Thing[KF_thing(kf1)]["物品说明"] ~= nil then
						--DrawString(wgzbx+kfx,wgzby+size*2.2,JY.Thing[KF_thing(kf1)]["物品说明"],C_WHITE,wgsize)
						h=tjm(wgzbx+kfx, wgzby +size*1.7 + size * (row-fy), '■'..JY.Thing[KF_thing(kf1)]["物品说明"], C_BLACK,wgsize*0.9,11,wgsize*1.7,fy-row,40)	
						row = row + h
					else
						--DrawString(wgzbx+kfx,wgzby+size*2.2,'■'..kfsmwz,color,wgsize)
						h=tjm(wgzbx+kfx, wgzby +size*1.7 + size * (row-fy), '■'..kfsmwz, C_BLACK,wgsize,9,wgsize*1.5,fy-row,40)	
						row = row + h
					end
				else 
					DrawString(wgzbx+kfx,wgzby+size*2.2,kfsmwz,C_BLACK,wgsize)
				end
				if kfsm == 1 then						
					if JY.Wugong[kf1]["武功类型"] < 6 then						
						for j = 1,#CC.KFMove[kf1]  do

							--lib.Debug('menu1[5]=='..menu1[5])
							local zsnum = CC.WUGONGZS[1][j]
							if JY.Person[id]["武功招式"..zsnum] == 0 then
								lib.LoadPNG(91,lxpic*2,wgzbx+(j-1)*CC.ScreenW/30-CC.ScreenW/80,wgzby+CC.ScreenH/2.2,1,0,90)
							else
								lib.LoadPNG(98,(500+kf1)*2,wgzbx+(j-1)*CC.ScreenW/30-CC.ScreenW/80,wgzby+CC.ScreenH/2.2,1,0,90)
							end
							local zssm = {}
							local CAOZSM = {}  
							local zsn = #CC.KFMove[kf1]
							local function Atk(id)
								local gj = 0
								gj = gj + JY.Person[id]['攻击力']
								----lib.Debug('人物攻击力'..gj)	
								local nlgj = limitX((JY.Person[id]['内力'] - JY.Person[id]['资质']*10)/60,0)
								----lib.Debug('内力加成攻击力'..nlgj)	
								gj  = gj + nlgj	
								gj = gj + FJGONGJ(id)
								----lib.Debug('装备加成攻击力'..FJGONGJ(id))	
								return gj
							end
							local atk = Atk(id)
							local zzz = smtb1
							if zzz > 6 then
								zzz = 6
							end
							local nnn =  wugongwl*(1+(zzz-1)/10)
							local sz = math.ceil(atk*(1+nnn/2000))
							local sznum = {"一","二","三","四","五","六","七","八","九","十"}
							local wz1 = "造成基础伤害"..'Ｇ'..sz.."Ｗ".."点。"
							--lib.Debug('kf1=='..kf1..' tb =='..tb..' #CC.KFMove[kf1]=='..#CC.KFMove[kf1])
							local zsname = CC.KFMove[kf1][j][1] 
							local zswz = nil
							local zswz1 = nil

							if smtb1 == j then
								lib.LoadPNG(91,88*2,wgzbx+(j-1)*CC.ScreenW/30-CC.ScreenW/80,wgzby+CC.ScreenH/2.2,1,0,95)
								tjm(zsw + wgzbx-size,zsh+wgzby+size*7,"Ｇ"..JY.Wugong[kf1]["名称"].."Ｗ第Ｄ"..sznum[smtb1].."Ｗ招:Ｄ"..zsname,C_WHITE,wgsize,30,wgsize)
								tjm(zsw + wgzbx+size*8,zsh+wgzby+size*7,"Ｗ    耗气 Ｄ"..CC.KFMove[kf1][j][3],C_WHITE,wgsize,30,wgsize)																								
								local hs = 0
								local ZUIDHS = 4   
								zswz1 = KF_zswz(kf1,smtb1)                               
								zswz1 = wz1..""..zswz1		
								
								h2 = tjm(zsw + wgzbx-size,zsh+wgzby+size*7.7+size* (hs-WGSTARTH1),zswz1, C_WHITE,wgsize*0.9,20,wgsize*0.8,WGSTARTH1-hs,ZUIDHS+1-hs+WGSTARTH1)			
								hs = hs + h2	
								if hs > ZUIDHS then
									WGFY1 = limitX(hs-ZUIDHS-1,0)
								else
									WGFY1 = 0
								end
							end
						end
					else
						if JY.Wugong[kf1]['特效1'] > 0 then
							--lib.Debug(kf1..'判定成功1') 
							wugong_info1(kf1)
						else
							if KF_thing(kf1) ~= nil then 
								--lib.Debug(kf1..'判定成功2') 
								wugong_info(KF_thing(kf1))
							end
						end
					end
				elseif  kfsm == 2 then 
					if JY.Wugong[kf1]['特效1'] > 0 then
						--lib.Debug(kf1..'判定成功1') 
						wugong_info1(kf1)
					else
						if KF_thing(kf1) ~= nil then 
							--lib.Debug(kf1..'判定成功2') 
							wugong_info(KF_thing(kf1))
						end
					end
				end					
				local r = 0
				if level <= 9 then
					if KF_thing(kf1) ~= nil then 
						r=math.modf((5-math.modf(25/25))*JY.Thing[KF_thing(kf1)]["需经验"]*(level+1)*0.05);
					else
						r=math.modf((5-math.modf(25/25))*200*(level+1)*0.05);
					end
				else
					r=math.huge;
				end
				
				if CC.XKF == 1 then 
					for i = 1,#xzwz do 
						local cl = C_WHITE1	
						local xzx = wgzbx+CC.ScreenW/30-CC.ScreenW/80+(i-1)*(bx*100)+bx*300
						local xzy = wgzby+CC.ScreenH/2.2+by*120
						DrawBox(xzx-bx*10,xzy-by*5,xzx+bx*70,xzy+by*35,cl,30,cl,99);
						if kfcj > mpgx or kfcj > jxkf then 
							cl = M_DimGray
						end						
						if smtb2 == i then 
							cl = C_RED
							DrawBox(xzx-bx*10,xzy-by*5,xzx+bx*70,xzy+by*35,cl,30,cl,99);
						end
						
						DrawString(xzx,xzy,xzwz[i],cl,size,CC.FONT0)
					end
				end
			end
		end  
        ShowScreen()
        lib.Delay(CC.Frame)
        local X, ktype, mx, my = lib.GetKey();
		if X == VK_ESCAPE or ktype == 4 then
			PlayWavE(77)
			return 1
		elseif X == VK_RETURN or X == VK_SPACE then
			PlayWavE(77)
			if kfsm > 0 then 
				if smtb2 == 1 then 
					if CC.XKF == 1 then 	
						if kfcj <= mpgx and kfcj <= jxkf then 				
							instruct_33(id,kf)
						else
						end 												
						return 2
					end
				elseif smtb2 == 2 then 
					return 1
				end
			end
		elseif X == VK_LEFT then
			PlayWavE(77)
			if CC.XKF == 1 then
				if smtb2 == 0 then 
					smtb1 = smtb1 - 1
					if smtb1 < 1 then 
						smtb1 = 1 
						smtb2 = #xzwz
					end 
				else
					smtb2 = smtb2 - 1
					if smtb2 < 1 then 
						smtb2 = 0
						smtb1 = #CC.KFMove[kf1]
					end
				end
			else
				smtb1 = smtb1 - 1
				if smtb1 < 1 then 
					smtb1 = #CC.KFMove[kf1]
				end
			end
		elseif X == VK_RIGHT then			
			PlayWavE(77)
			if CC.XKF == 1 then
				if smtb2 == 0 then 
					smtb1 = smtb1 + 1
					if smtb1 > #CC.KFMove[kf1] then 
						smtb1 = #CC.KFMove[kf1]
						smtb2 = 1
					end
				else
					smtb2 = smtb2 + 1
					if smtb2 > #xzwz then 
						smtb2 = 0
						smtb1 = 1
					end
				end
			else
				smtb1 = smtb1 + 1
				if smtb1 > #CC.KFMove[kf1] then 
					smtb1 = 1
				end
			end
		elseif X == VK_F1 then
			PlayWavE(77)
			if kfsm == 1 then 
				kfsm = 2
			else
				kfsm = 1
			end	
		elseif X == VK_DOWN or ktype == 7 then 
			PlayWavE(77)
			if kfsm > 0 then
				WGSTARTH  = WGSTARTH + 1
				if WGSTARTH > FY then
					WGSTARTH = FY 
				end
			end
		elseif X == VK_UP or ktype == 6 then 
			PlayWavE(77)
			if kfsm > 0 then
				WGSTARTH = WGSTARTH - 1
				if WGSTARTH < 0 then 
					WGSTARTH = 0
				end	
			end
		else
			--lib.LoadPNG(91,14*2,wgzbx+CC.ScreenW/2.9,wgzby+size*4,1,0,80)  -- 切换武功说明图片
			if mx > wgzbx+CC.ScreenW/2.9 and wgzbx+CC.ScreenW/2.9 < wgzbx+CC.ScreenW/2.9 + size*2 and my > wgzby+size*4 and my < wgzby+size*4 + size*5 and ktype == 3  then
				if  kfsm == 1 then 
					PlayWavE(77)
					kfsm = 2 
				else
					PlayWavE(77)
					kfsm = 1
				end
			end
			local pd1 = false 
			for j = 1,#CC.KFMove[kf1] do 
				--lib.LoadPNG(91,88*2,wgzbx+(j-1)*CC.ScreenW/30-CC.ScreenW/80,wgzby+CC.ScreenH/2.2,1,0,95)
				if mx > wgzbx+(j-1)*CC.ScreenW/30-CC.ScreenW/80 and mx < wgzbx+(j-1)*CC.ScreenW/30-CC.ScreenW/80 + bx*30 and my > wgzby+CC.ScreenH/2.2 and my < wgzby+CC.ScreenH/2.2+by*30 then 
					smtb1 = j 
					pd1 = true 
					break
				end
			end
			local pd = false 
			if CC.XKF == 1 then 	
				for i = 1,#xzwz do 
					local xzx = wgzbx+CC.ScreenW/30-CC.ScreenW/80+(i-1)*(bx*100)+bx*300
					local xzy = wgzby+CC.ScreenH/2.2+by*120
					if mx > xzx-bx*10 and mx < xzx+bx*70 and my > xzy-by*5 and my < xzy+by*35 then 						
						smtb2 = i 
						pd = true 
						break
					end
				end 
				if pd == true and ktype == 3 then 
					if smtb2 == 1 then 
						if kfcj <= mpgx and kfcj <= jxkf then				
							instruct_33(id,kf)
						else
						end 
					else
						return
					end												
					return 2
				end
			end
		end	
	end
end


--游戏说明
function Game_sm(tab,page,tab1)
	ClsN()
	--local bx,by = CC.WX/1360,CC.HY/768
	--local bx1,by1 = CC.ScreenW/1360,CC.ScreenH/768
	local bx =  CC.ScreenW/1360
	local by = CC.ScreenH/768
	local size = CC.DefaultFont
	local tx,ty = bx*380,by*70
	local ty1 = ty-by*65
	local ty2 = ty-by*2
	local tb = 1
	local tb1 = 1
	local tb2 = 1
	local tb3 = 1
	local tot = 0
	local pg = 0
	local Tmenu = {'剧    情','人    物','门    派','武    功','秘    技','物    品','状态说明','其    他'}
	local JQmenu = {'天书剧情','支线剧情','防坑指南'}
	--天书剧情图片张数 1,第一张，2第二张，3天书名称
	local tpic = {
	{381,387,'飞狐外传'},{388,389,'雪山飞狐'},{390,394,'连城诀'},{395,410,'天龙八部'},{411,422,'射雕英雄传'},{423,425,'白马啸西风'},{426,429,'鹿鼎记'},
	{430,440,'笑傲江湖'},{441,449,'书剑恩仇录'},{450,460,'神雕侠侣'},{461,466,'侠客行'},{467,481,'倚天屠龙记'},{482,487,'碧血剑'},{488,490,'鸳鸯刀'}
				} --天书剧情图片
	local fy = 5
	local tsname = ''
	local RWmenu ={'全人物','神话','宗师','豪侠','一流','二流','三流'}
	local KFmenu = {'拳掌','指法','剑法','刀法','奇门','内功','轻功'}
	local Thmenu ={'秘籍','装备','剧情','药品酒食'}
	local KFmenu= {"拳法","指法","剑法","刀法","奇门","内功","轻功"}
	local thmenu = {'剧情','装备','秘籍','药食','暗器'}
	local mpmenu = {'门派特性','门派外功','门派内功','门派人物'}
	local mpperson = {}
	--1，pg=1总项数，2，pg总数，3，pg=2总项数
	local pmax = {{14,3,3}, 		--剧情
					{0,1,1}, 			--人物
					{4,3,#MPname},		--门派
					{#KFmenu,2,#KFmenu},--武功
					{0,1,0},            --秘技
					{#thmenu,2,#thmenu},--物品
					{1,1,0},			--状态说明
					{0,0,0}} 			--其他
	local cl = C_BLACK
	if tab ~= nil then 
		tb = tab 
	end
	if tab1 ~= nil then 
		tb1 = tab1 
	end
	if page ~= nil then 
		pg = page 
	end
	--local fmenu = {#Tmenu,}
	local r = 1
	local page = 1
	local fy_max  = 0 
	CC.XKF = 2
	while true do 
		if JY.Restart == 1 then 
			break
			Cls()
		end	
		if pg == 1 and tb1 == 2 then 
			fy_max = 6
		elseif pg == 2 and tb1 == 1 then 
			fy_max = tpic[tb2][2] - tpic[tb2][1]+1
		end	
		local page = math.modf(tot/fy)+1	
		local tot_max = math.modf((fy_max-1)*fy)

		lib.LoadPNG(91,273*2,-1,-1,1)
		for i = 1,#Tmenu do 
			local cl1 = C_WHITE1
			DrawBox(CC.ScreenW/2-size*3,ty1+(i)*size*2,CC.ScreenW/2+size*3,ty2+(i)*size*2,cl) 
			if tb == i then 
				DrawBox(CC.ScreenW/2-size*3,ty1+(i)*size*2,CC.ScreenW/2+size*3,ty2+(i)*size*2,C_RED)
				cl1 = C_RED
			end
			DrawString(CC.ScreenW/2-string.len(Tmenu[i])/4*size,ty+(i-1)*size*2+by*20,Tmenu[i],cl1,size,CC.FONT1)
		end
		if tb == 1 then 			
			if pg > 0 then 
				for i = 1,#JQmenu do 	
					local cl1 = C_WHITE1				
					DrawString(CC.ScreenW/2-size*3+size*6.15,ty2+size*0.9,'>>',C_RED,size*0.5,CC.FONT1)
					DrawBox(CC.ScreenW/2-size*3+size*7,ty1+(i)*size*2,CC.ScreenW/2+size*3+size*7,ty2+(i)*size*2,cl) 
					if tb1 == i then 
						cl1 = C_RED
						DrawBox(CC.ScreenW/2-size*3+size*7,ty1+(i)*size*2,CC.ScreenW/2+size*3+size*7,ty2+(i)*size*2,C_RED)
					end				
					DrawString(CC.ScreenW/2+size*7-string.len(JQmenu[i])/4*size,ty+(i-1)*size*2+by*20,JQmenu[i],cl1,size,CC.FONT1)
				end
			end
			if pg == 2 then 
				if tb1 == 1 then 
					local n,m = 0,0
					for i = 1,#tpic do 
						local cl1 = C_WHITE1					
						DrawString(CC.ScreenW/2-size*3+size*13.2,ty2+size*0.9,'>>',C_RED,size*0.5,CC.FONT1)
						DrawBox(CC.ScreenW/2-size*3+size*14+m*size*4,ty1+(n+1)*size*2,CC.ScreenW/2+size*3+size*11+m*size*4,ty2+(n+1)*size*2,cl) 
						if tb2 == i then 
							cl1 = C_RED
							DrawBox(CC.ScreenW/2-size*3+size*14+m*size*4,ty1+(n+1)*size*2,CC.ScreenW/2+size*3+size*11+m*size*4,ty2+(n+1)*size*2,C_RED)
						end	
						tsname = string.sub(tpic[i][3],1,2)		
						DrawString(CC.ScreenW/2+size*12.5-string.len(tsname)/4*size+m*size*4,ty+(n)*size*2+by*20,tsname,cl1,size,CC.FONT1)
						n = n + 1
						if n == 7 then 
							n = 0 
							m = 1
						end
					end
					n = 0 
					m = 0
				elseif tb1 == 2 then
					for i = 1,fy_max do 
						lib.LoadPNG(91,(491+i-1)*2,0,(i-1)*CC.ScreenH - tot*CC.ScreenH/5,1)
					end
					local tb11 = 3
					if tot > 0 then 
						lib.LoadPNG(91,127*2,CC.ScreenW-size,size,1)	
					end
					if tot < tot_max then 
						lib.LoadPNG(91,124*2,CC.ScreenW-size,CC.ScreenH-size*1.5,1)
					end			
					DrawString(CC.ScreenW-size*3.5,size/2,page..'/'..fy_max..'页',C_BLACK,size,CC.FONT2)
				elseif tb1 == 3 then 
					fkwz()
					return Game_sm(1)
				end
			end
			if pg == 3 then 
				--lib.Debug('pg == 3 fy_max='..fy_max)							
				for i = 1,fy_max do 
					lib.LoadPNG(91,(tpic[tb2][1]+i-1)*2,0,(i-1)*CC.ScreenH - tot*CC.ScreenH/5,1)
				end	
				lib.LoadPNG(91,503*2,0,0,1)		
				DrawString(CC.ScreenW/2-string.len(tpic[tb2][3])/4*size,size/2,tpic[tb2][3],C_BLACK,size*1.1,CC.FONT2)
				if tot > 0 then 
					lib.LoadPNG(91,127*2,CC.ScreenW-size,size,1)	
				end
				if tot < tot_max then 
					lib.LoadPNG(91,124*2,CC.ScreenW-size,CC.ScreenH-size*1.5,1)
				end			
				DrawString(CC.ScreenW-size*3.5,size/2,page..'/'..fy_max..'页',C_BLACK,size,CC.FONT2)	
			end
		elseif tb == 2 then 
			if pg == 1 then 
				local menu = {}
				for i = 1, JY.PersonNum - 1 do
					if JY.Person[i]['姓名'] ~= '备用' and JY.Person[i]['姓名'] ~= '标主占用'  and JY.Person[i]['姓名'] ~= '门主占用' then 
						menu[#menu+1] = {JY.Person[i]['姓名'],nil,1,i} 
					end
				end 
				for i = 1,#menu do 
					local clone_choice = ShowMenu4(menu,#menu,8,-2,-2,-2,-2,-2,1,CC.DefaultFont*0.9,C_GOLD,C_WHITE,"请选择要要查看的人物",C_ORANGE, C_WHITE,15)	
					if clone_choice > 0 then 
						PersonCK(menu[clone_choice][4])
					else						
						return Game_sm()
					end
				end
			end
		elseif tb == 3 then 
			if pg > 0 then 
				local n,m = 0,0
				for i = 1,#MPname do 
					local cl1 = C_WHITE1				
					DrawString(CC.ScreenW/2-size*3+size*6.15,ty+(tb-1)*size*2+size*2.5,'>>',C_RED,size*0.5,CC.FONT1)
					DrawBox(CC.ScreenW/2-size*3+size*7+(m*size*5.5),ty1+(n+1)*size*1.9,CC.ScreenW/2+size*3+size*6+(m*size*5.5),ty2+(n+1)*size*1.9,cl) 
					if tb1 == i then 
						cl1 = C_RED
						DrawBox(CC.ScreenW/2-size*3+size*7+(m*size*5.5),ty1+(n+1)*size*1.9,CC.ScreenW/2+size*3+size*6+(m*size*5.5),ty2+(n+1)*size*1.9,C_RED)
					end				
					DrawString(CC.ScreenW/2+size*6.5-string.len(MPname[i])/4*size+(m*size*5.5),ty+(n)*size*1.9+by*20,MPname[i],cl1,size,CC.FONT0)
					n = n + 1
					if n == 11 then 
						n = 0
						m = m+1
					end
				end
				n =0
				m = 0
			end 
			if pg == 2 then 
				DrawBox(CC.ScreenW/5,CC.ScreenH/3,CC.ScreenW-CC.ScreenW/5,CC.ScreenH/3+CC.ScreenH/4,C_BLACK,90)
				for i = 1,#mpmenu do 
					local cl1 = C_WHITE1	
					local mpx = CC.ScreenW/3+(i-1)*size*5.5-bx*125
					local mpy = CC.ScreenH/2-size*2
					DrawBox(mpx,mpy,mpx+size*5,mpy+size*2,C_WHITE,150)
					if tb2 == i then 
						cl1 = C_RED
						DrawBox(mpx,mpy,mpx+size*5,mpy+size*2,cl1)
					end
					DrawString(mpx+size/2,mpy+size/2,mpmenu[i],cl1,size,CC.FONT1)
				end
			end
			if pg == 3 then 
				local tid = CC.MPSF[tb1]
				if tb2 == 1 then 
					local mplogo = 239+tb1
					lib.Background(CC.ScreenW/2-size*8,CC.ScreenH/2-size*4,CC.ScreenW/2+size*8,CC.ScreenH/2+size*8,40)
					DrawString(CC.ScreenW/2-size*6,CC.ScreenH/2-size*3.5,MPname[tb1],C_ORANGE,size,CC.FONT2)
					lib.LoadPNG(91,mplogo*2,CC.ScreenW/2-size*7.8,CC.ScreenH/2-size*3.8,1,0,60)
					--MP_TX(mid)
					local mptx = 0
					mptx = tjm(CC.ScreenW/2-size*7.5,CC.ScreenH/2-size*2,MP_TX(tb1-1),C_WHITE,size*0.9,15,size*1.3)	
				elseif tb2 == 2 then 					
					return MP_XueKf_WG(0,tid,2)
				elseif tb2 == 3 then 
					return MP_XueKf_NQ(0,tid,2)
				elseif tb2 == 4 then 
					local mp2 = {}
					for i = 1,#CC.MpRw[tb1-1] do 
						local pid = CC.MpRw[tb1-1][i]
						local name = JY.Person[pid]['姓名'] 
						if name ~= '备用' and name ~= '标主占用' and name ~= '门主占用' and name ~= '心魔' and name ~= '李秋水幻相' and pid ~= 591  and pid ~= 0  then 
							mp2[#mp2+1] = {name,nil,1,pid} 
						end
					end
					local clone_choice = ShowMenu4(mp2,#mp2,8,-2,-2,-2,-2,-2,1,CC.DefaultFont*0.9,C_GOLD,C_WHITE,MP_name(tid)..'人物查看',C_ORANGE, C_WHITE,15)	
					if clone_choice > 0 then 
						PersonCK(mp2[clone_choice][4])
					else
						return Game_sm(3,2,tb1)
					end
				end		
			end
		elseif tb == 4 then 
			if pg == 1 then 
				for i = 1,#KFmenu do 
					local cl1 = C_WHITE1				
					DrawString(CC.ScreenW/2-size*3+size*6.15,ty+(tb-1)*size*2+size*2.5,'>>',C_RED,size*0.5,CC.FONT1)
					DrawBox(CC.ScreenW/2-size*3+size*7,ty1+(i)*size*2,CC.ScreenW/2+size*3+size*7,ty2+(i)*size*2,cl) 
					if tb1 == i then 
						cl1 = C_RED
						DrawBox(CC.ScreenW/2-size*3+size*7,ty1+(i)*size*2,CC.ScreenW/2+size*3+size*7,ty2+(i)*size*2,C_RED)
					end				
					DrawString(CC.ScreenW/2+size*7-string.len(KFmenu[i])/4*size,ty+(i-1)*size*2+by*20,KFmenu[i],cl1,size,CC.FONT1)
				end
			end
			if pg == 2 then 
				local kflx = {'拳    法','指    法','剑    法','刀    法','特殊兵器','内    功','轻   功',}
				local slmenu = {}
				local kfmenu = {}
				local nexty = CC.ScreenH/2-CC.DefaultFont*4 + CC.SingleLineHeight
				for i = 1, JY.WugongNum - 1 do
					if  JY.Wugong[i]["武功类型"] == tb1  then
						slmenu[i] = {JY.Wugong[i]["名称"],nil,1}
						kfmenu[#kfmenu+1] = {i,1,JY.Wugong[i]['层级'],JY.Wugong[i]['攻击力10']}
					end
				end
				local function wg_px(a,b)
					return a[3] < b[3]
				end
				table.sort(kfmenu,wg_px)
				LGShowMenu_kf(kfmenu,6,8,kflx[tb1],1)
				return Game_sm(4)
			end
		elseif tb == 5 then 
			if pg == 1 then 
				local menu = {}		
				for i = 1,JY.TejiNum - 1 do 
					local kfname = JY.Teji[i]['名称']
					if kfname ~= '无' and kfname ~= '备用' then
						menu[i] = {kfname,nil,1,i}
					end
				end
				for i = 1,#menu do 
					local R = ShowMenu2(menu, #menu, 5, 17, CC.ScreenW/2-CC.DefaultFont*13, CC.ScreenH/2-CC.DefaultFont*10, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"秘技大全")
					if R > 0 then 
						MIKU(menu[R][4])
					else
						return Game_sm(5) 						
					end
				end
			end
		elseif tb == 6 then 
			if pg == 1 then 
				for i = 1,#thmenu do 
					local cl1 = C_WHITE1				
					DrawString(CC.ScreenW/2-size*3+size*6.15,ty+(tb-1)*size*2+size*2.5,'>>',C_RED,size*0.5,CC.FONT1)
					DrawBox(CC.ScreenW/2-size*3+size*7,ty1+(i)*size*2,CC.ScreenW/2+size*3+size*7,ty2+(i)*size*2,cl) 
					if tb1 == i then 
						cl1 = C_RED
						DrawBox(CC.ScreenW/2-size*3+size*7,ty1+(i)*size*2,CC.ScreenW/2+size*3+size*7,ty2+(i)*size*2,C_RED)
					end				
					DrawString(CC.ScreenW/2+size*7-string.len(thmenu[i])/4*size,ty+(i-1)*size*2+by*20,thmenu[i],cl1,size,CC.FONT1)
				end
			elseif pg == 2 then 
				local menu1 = {}
				local thingnum = {}
				local thnum = 0
				for i = 0, JY.ThingNum - 1 do
					local k = JY.Thing 
					--local thid = JY.Base["物品" .. i + 1]
					if i > 0 then 
						if k[i]["类型"] == tb1-1 then							
							menu1[thnum] = i
							thingnum[thnum] = 1
							thnum = thnum + 1
						end
					end					
				end
				local r = SelectThing(menu1, thingnum)
				if r >= 0 then
				else
					return Game_sm()
				end
				--end
			end
		elseif tb == 7 then
			if pg == 1 then 
				local n,m = 0,0
				lib.LoadPNG(91,273*2,-1,-1,1)
				local ztme = {'中毒','流血','冰封','灼烧','封穴','点燃','冻结','撕裂','巨毒','虚弱','巨毒','巨毒',}
				for i = 1,#ztme do 
					DrawString(CC.ScreenW/20+n*(bx*100),CC.ScreenH/20+m*size*2,ztme[i],C_ORANGE,size,CC.FONT1)
					n = n + 1
					if n == 10 then 
						n = 0 
						m = 1
					end
				end
				n = 0
				m = 0
			end 
		elseif tb == 8 then 
		end
		ShowScreen()
		lib.Delay(CC.Frame)
		local key,ktype,mx,my = lib.GetKey();
		if key == VK_ESCAPE or ktype == 4 then 
			--lib.Debug('sm退出判定'..'  r=='..r)
			pg = pg - 1 
			--if tb == 1 then 
				if pg == 1 then 				
					tot = 0	
					tb2 = 1
					tb1 = 1									
				elseif pg == 2 then 				
					--tb1 = 1
					tot = 0	
				end
			--end
			if pg < 0 then 
				break
			end
			--lib.Debug('VK_ESCAPE'..'pg =='..pg..'page =='..page..' tot=='..tot..' tb2=='..tb2..' tb1=='..tb1..' fy_max='..fy_max)
		elseif key == VK_RETURN or key == VK_SPACE then 
				pg = pg + 1
				if tb == 1 and tb1 == 2 then 
					if pg > 2 then 
						pg = 2
					end
				else
					if pg > pmax[tb][2] then 
						pg = pmax[tb][2]
					end
				end
		elseif key == VK_RIGHT then 
			if tb == 3 then 
				if pg == 2 then
					if pmax[tb][1] > 0 then --天书
						tb2 = tb2 + 1 
						if tb2 > pmax[tb][1] then 
							tb2 = 1
						end
					end
				end
			end
		elseif key == VK_LEFT then 	
			if tb == 3 then 
				if pg == 2 then 
					if pmax[tb][1] > 0 then 
						tb2 = tb2 - 1
						if tb2 < 1 then 
							tb2 = pmax[tb][1]
						end					
					end
				end
			end	
		elseif key == VK_DOWN then 
			if pg == 1 then 
				tb1 = tb1 + 1 
				if tb1 >pmax[tb][3] then 
					tb1 = 1
				end
			elseif pg == 2 then 
				if tb == 1 and tb1 == 2 then --支线剧情
					tot = tot + 1
					if tot > tot_max then 
						tot = tot_max
					end
				else
					if pmax[tb][1] > 0 then --天书
						tb2 = tb2 + 1 
						if tb2 > pmax[tb][1] then 
							tb2 = 1
						end
					end
				end				
			elseif pg == 3 then 
				if tb == 1  then --天书剧情
					tot = tot + 1
					if tot > tot_max then 
						tot = tot_max
					end
					--lib.Debug('VK_DOWN'..'pg =='..pg..'page =='..page..' tot=='..tot.. ' tot_max=='..tot_max)
				end
			elseif pg == 0 then 
				tb1 = 1
				tb2 = 1
				tb = tb + 1
				if tb > #Tmenu then 
					tb = 1
				end
			end
			--lib.Debug('VK_DOWN'..'pg =='..pg..'page =='..page..' tot=='..tot..' tb2=='..tb2..' tb1=='..tb1..' fy_max='..fy_max)
		elseif key == VK_UP then 
			if pg == 1 then 
				tb1 = tb1 - 1
				if tb1 < 1 then 
					tb1 = pmax[tb][3]
				end
			elseif pg == 2 then 
				if tb == 1 and tb1 == 2 then --支线剧情 
					tot = tot - 1 
					if tot < 0 then 
						tot = 0 
					end					
				else 						--主线剧情
					if pmax[tb][1] > 0 then 
						tb2 = tb2 - 1
						if tb2 < 1 then 
							tb2 = pmax[tb][1]
						end					
					end
				end
				--lib.Debug('VK_DOWN'..'pg =='..pg..'page =='..page..' tot=='..tot)
			elseif pg == 3 then 
				if tb == 1 and tb1 == 1 then 
					tot = tot - 1
					if tot < 0 then 
						tot = 0
					end
				end
				--lib.Debug('VK_DOWN'..'pg =='..pg..'page =='..page..' tot=='..tot..' tot_max=='..tot_max)
			elseif pg == 0 then 
				tb1 = 1
				tb2 = 1
				tb = tb - 1 
				if tb < 1 then 
					tb = #Tmenu
				end
			end
			--lib.Debug('VK_DOWN'..'pg =='..pg..'page =='..page..' tot=='..tot..' tb2=='..tb2..' tb1=='..tb1..' fy_max='..fy_max)
		elseif ktype == 6 then 
			if pg == 1 then 
				tb1 = tb1 - 1
				if tb1 < 1 then 
					tb1 = pmax[tb][3]
				end
			elseif pg == 2 then 
				if tb == 1 then --支线剧情
					if tb1 == 2 then 
						tot = tot - 1 
						if tot < 0 then 
							tot = 0 
						end					
					else 						--主线剧情
						if pmax[tb][1] > 0 then 
							tb2 = tb2 - 1
							if tb2 < 1 then 
								tb2 = pmax[tb][1]
							end					
						end
					end
				end
				--lib.Debug('VK_DOWN'..'pg =='..pg..'page =='..page..' tot=='..tot)
			elseif pg == 3 then 
				if tb == 1 and tb1 == 1 then 
					tot = tot - 1
					if tot < 0 then 
						tot = 0
					end
				end
				--lib.Debug('VK_DOWN'..'pg =='..pg..'page =='..page..' tot=='..tot..' tot_max=='..tot_max)
			elseif pg == 0 then 
				tb1 = 1
				tb2 = 1
				tb = tb - 1 
				if tb < 1 then 
					tb = #Tmenu
				end
			end 

		elseif ktype == 7 then
			if pg == 1 then 
				tb1 = tb1 + 1 
				if tb1 >pmax[tb][3] then 
					tb1 = 1
				end
			elseif pg == 2 then 
				if tb == 1 and tb1 == 2 then --支线剧情
					tot = tot + 1
					if tot > tot_max then 
						tot = tot_max
					end
				else
					if pmax[tb][1] > 0 then --天书
						tb2 = tb2 + 1 
						if tb2 > pmax[tb][1] then 
							tb2 = 1
						end
					end
				end
				--lib.Debug('VK_DOWN'..'pg =='..pg..'page =='..page..' tot=='..tot..' tb2=='..tb2)
			elseif pg == 3 then 
				if tb == 1  then --天书剧情
					tot = tot + 1
					if tot > tot_max then 
						tot = tot_max
					end
					--lib.Debug('VK_DOWN'..'pg =='..pg..'page =='..page..' tot=='..tot.. ' tot_max=='..tot_max)
				end
			elseif pg == 0 then 
				tb1 = 1
				tb2 = 1
				tb = tb + 1
				if tb > #Tmenu then 
					tb = 1
				end
			end
		else			
			if pg == 0 then 
				local pd = false
				for i = 1,#Tmenu do 
					if mx > CC.ScreenW/2-size*3 and mx < CC.ScreenW/2+size*3 and my > ty1+(i)*size*2 and my < ty2+(i)*size*2 then 
						tb = i 
						pd = true
						break
					end
				end
				if pd == true and ktype == 3 then 
					pg = 1
				end
			end
			if tb == 1 then				 
				if pg == 1 then 
					local pd = false
					for i = 1,#JQmenu do 
						if mx > CC.ScreenW/2-size*3+size*7 and mx < CC.ScreenW/2+size*3+size*7 and my > ty1+(i)*size*2 and my < ty2+(i)*size*2 then 
							pd = true
							tb1 = i
							break
						end
					end
					if pd == true and ktype == 3 then 
						pg = 2
					end
				elseif pg == 2 then 
					if tb1 == 1 then
						local pd = false 
						local n,m = 0,0
						for i = 1,#tpic do
							if mx >CC.ScreenW/2-size*3+size*14+m*size*4 and mx < CC.ScreenW/2+size*3+size*11+m*size*4 and my > ty1+(n+1)*size*2 and my < ty2+(n+1)*size*2 then 
								pd = true
								tb2 = i 
								n = n + 1
								break
							end 
							n = n + 1
							if n == 7 then 
								n = 0 
								m = 1
							end
						end
						n = 0 
						m = 0
						if pd == true and ktype == 3 then 
							pg = 3
						end
					else

					end
				end
			elseif tb == 3 then 
				local pd = false
				if pg == 1 then 
					local n,m = 0,0
					for i = 1,#MPname do 
						if mx > CC.ScreenW/2-size*3+size*7+(m*size*5.5) and mx < CC.ScreenW/2+size*3+size*6+(m*size*5.5) and my > ty1+(n+1)*size*1.9 and my < ty2+(n+1)*size*1.9 then 
							pd = true
							tb1 = i 
							n = n + 1
							break
						end 
						n = n + 1
						if n == 11 then 
							n = 0 
							m = m + 1
						end
					end
					n = 0 
					m = 0
					if pd == true and ktype == 3 then 
						pg = 2
					end
				elseif pg == 2 then 
					local pd = false
					for i = 1,#mpmenu do 
						local mpx = CC.ScreenW/3+(i-1)*size*5.5-bx*125
						local mpy = CC.ScreenH/2-size*2
						if mx > mpx and mx < mpx+size*5 and my > mpy and my < mpy+size*2 then 
							tb2 = i 
							pd = true 
							break
						end
					end
					if pd == true and ktype == 3 then 
						pg = 3
					end	
				end
			elseif tb == 4 then 
				local pd = false
				if pg == 1 then 
					for i = 1,#KFmenu do 
						if mx > CC.ScreenW/2-size*3+size*7 and mx < CC.ScreenW/2+size*3+size*7 and my > ty1+(i)*size*2 and my < ty2+(i)*size*2 then 
							tb1 = i 
							pd = true
							break
						end
					end
					if pd == true and ktype == 3 then 
						pg = 2
					end
				end
			elseif tb == 6 then 
				local pd = false
				if pg == 1 then 
					for i = 1,#thmenu do 
						if mx > CC.ScreenW/2-size*3+size*7 and mx < CC.ScreenW/2+size*3+size*7 and my > ty1+(i)*size*2 and my < ty2+(i)*size*2 then 
							tb1 = i 
							pd = true
							break
						end
					end
					if pd == true and ktype == 3 then 
						pg = 2
					end
					--lib.Debug(pg)
				end
			end			
		end
	end
end

function MP_XueKf_WG(id,tid,xkf)
	local mp = JY.Person[tid]['门派']
	local bx,by = CC.ScreenW/1360,CC.ScreenH/768
	local size = CC.DefaultFont*0.9
	local kfmenu = {}
	local kfmenu1 = {}
	local kfmenu2 = {}
	local kfmenu3 = {}
	local kfmenu4 = {}
	local kfmenu5 = {}
	local kfmenu6 = {}
	local kfmenu7 = {}
	local wgfl = {'拳法','指腿','剑法','刀法','奇门','内功','轻功'}

	local stx = bx*170 --背景开始坐标x
	local sty = by*70 --背景开始坐标y

	local pg = 1
	local tb = 1
	local tb1,tb2,tb3,tb4,tb5 = 0,0,0,0,0

	local wugong = 0
	local xs = 1
	local lb = 1
	local pxmenu = {}

	local function kf_cjpx(a,b)
		return a[3] < b[3]
	end
	local mpgx = math.modf(JY.Person[id]['门派贡献']/200)+1
	for i = 1,#CC.MpKf[mp] do 
		local kf = CC.MpKf[mp][i]
		local kfname = JY.Wugong[kf]['名称']
		local kflx = JY.Wugong[kf]['武功类型']
		local cj = JY.Wugong[kf]['层级']
		--kfmenu[#kfmenu+1] = {kf,kfname,kflx,xs}
		if kf > 0 and kf ~= 333 then 
			if kflx == 1 then 
				kfmenu1[#kfmenu1+1] = {kf,kfname,cj,xs}
				--按武功层级大小排序
				table.sort(kfmenu1, kf_cjpx)				
			end
			if kflx == 2 then 
				kfmenu2[#kfmenu2+1] = {kf,kfname,cj,xs}
				table.sort(kfmenu2, kf_cjpx)
			end
			if kflx == 3 then 
				kfmenu3[#kfmenu3+1] = {kf,kfname,cj,xs}
				table.sort(kfmenu3, kf_cjpx)
			end
			if kflx == 4 then 
				kfmenu4[#kfmenu4+1] = {kf,kfname,cj,xs}
				table.sort(kfmenu4, kf_cjpx)
			end
			if kflx == 5 then 
				kfmenu5[#kfmenu5+1] = {kf,kfname,cj,xs}
				table.sort(kfmenu5, kf_cjpx)
			end
		end
	end
	if JY.Person[tid]['门派'] == 1 then 
		if CC.TX['般若堂'] == 1 then 			
			resetTable(kfmenu3)
			resetTable(kfmenu4)
			resetTable(kfmenu5)
		elseif CC.TX['达摩院'] == 1 then 
			resetTable(kfmenu1)
			resetTable(kfmenu2)
			resetTable(kfmenu3)
		end
	end
	--lib.Debug('kfmenu3 = '..#kfmenu3)
	if kfmenu1[1]~= nil then 
		tb1 = 1
	elseif kfmenu2[1]~= nil then 
		tb2 = 1
	elseif kfmenu3[1]~= nil then 
		tb3 = 1 
	elseif kfmenu4[1]~= nil then 
		tb4 = 1
	elseif kfmenu5[1]~= nil then 
		tb5 = 1 
	end
	local kfnum = 0
	if xkf == nil then 
	else
		CC.XKF = xkf
	end
	local jxkf = 2
	local cxfj = JY.Person[id]['畅想分阶']
	if cxfj == 1 or cxfj == 2 then 
		jxkf = 4
	elseif cxfj == 3  then 
		jxkf = 3
	elseif cxfj == 4   then 
		--jxkf = 2
	elseif  cxfj == 6 or cxfj == 5 then 
		--jxkf = 1
	end
	while true do
		if JY.Restart == 1 then
			break
		end		
		--lib.Background(stx,sty,CC.ScreenW-stx,CC.ScreenH-sty,10)	
		lib.LoadPNG(91,(506+mp)*2,0,0,1,1,100)	
		local mpnm = MP_name(tid)..'武学'
		local mpnm1 = JY.Person[id]['姓名']..'正在学习...'
		DrawString(CC.ScreenW/2-string.len(mpnm)/4*size,by*28,mpnm,C_WHITE,size,CC.FONT1)
		DrawString(CC.ScreenW/2-size*4-string.len(mpnm)/4*size-string.len(mpnm1)/4*size,by*35,mpnm1,C_WHITE,size*0.9,CC.FONT3)
		local h = 0
		local n,m = 0,0 
		local n1,m1 = 0,0
		local x1,y1 = bx*120,by*40
		local w = bx*180
		local hg = by*50 --行高
		local hk = bx* 140 -- 行宽
		local y3 = sty+size
		local y4 = by*40
		--kfmenu = {kfmenu1,kfmenu2,kfmenu3,kfmenu4,kfmenu5,kfmenu6,kfmenu7}
		--lib.Debug(#kfmenu1)
		--如果表是空值，且
		if lb > 0 then 			
			--第一项
			if #kfmenu1 > 0 then 

				for i = 1,#kfmenu1 do 
					local cl = C_WHITE1
					if kfmenu1[i][3] > mpgx or kfmenu1[i][3] > jxkf  then 
						kfmenu1[i][4] = 0
					end 

					if kfmenu1[i][4] == 0 then 
						cl = M_DimGray
					end
					DrawBox(stx+x1+(n)*w-size,y3+m*hg+h*hg,stx+x1+(n)*w+hk,y3+m*hg+y1+h*hg,cl,30);					
					if tb1 == i then 
						cl = C_RED
						DrawBox(stx+x1+(n)*w-size,y3+m*hg+h*hg,stx+x1+(n)*w+hk,y3+m*hg+y1+h*hg,cl,30);
					end

					DrawString(stx+x1+size*2+(n)*w-string.len(kfmenu1[i][2])/4*size,y3+m*hg+h*hg+by*3,kfmenu1[i][2],cl,size,CC.FONT0)	
					n = n + 1
					if n == 5 then 
						n = 0
						m = m + 1 
					end
					kfnum = kfnum + 1
				end			
				local num,num1 = math.modf(#kfmenu1/5)
				if num1 == 0 then 
					m1 = m1 + 1
				end
				local name1 = string.sub(wgfl[1],1,2)
				local name2 = string.sub(wgfl[1],3,4)
				local name = {name1,name2}		
				DrawString(stx+size,y3+y1+size+(m-1)*hg-m1*hg-y4,name[1],C_WHITE1,size,CC.FONT1) 
				DrawString(stx+size,y3+y1+size+(m-1)*hg-m1*hg,name[2],C_WHITE1,size,CC.FONT1)	
				DrawBox(stx+bx*20,y3+y1+size+m*hg-m1*hg,stx+x1+bx*860,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --画横线
				DrawBox(stx+bx*70,y3,stx+bx*70,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --画竖线
				m = m + 1
				if num1 > 0 then 
					m = m + 1
				end
				n = 0
				m1 = 0
			end

			--第二项
			if #kfmenu2 > 0 then 
				for i = 1,#kfmenu2 do 
					local cl = C_WHITE1
					if kfmenu2[i][3] > mpgx or kfmenu2[i][3] > jxkf  then 
						kfmenu2[i][4] = 0
					end 
					if kfmenu2[i][4] == 0 then 
						cl = M_DimGray
					end
					DrawBox(stx+x1+(n)*w-size,y3+m*hg,stx+x1+(n)*w+hk,y3+m*hg+y1,cl,30);					
					if tb2 == i then 
						cl = C_RED
						DrawBox(stx+x1+(n)*w-size,y3+m*hg,stx+x1+(n)*w+hk,y3+m*hg+y1,C_RED,30);
					end
					DrawString(stx+x1+size*2+(n)*w-string.len(kfmenu2[i][2])/4*size,y3+m*hg+by*3,kfmenu2[i][2],cl,size,CC.FONT0)	
					n = n + 1
					if n == 5 then 
						n = 0
						m = m + 1 
					end
					kfnum = kfnum + 1
				end			
				local num,num1 = math.modf(#kfmenu2/5)
				if num1 == 0 then 
					m1 = m1 + 1
				end
				local name1 = string.sub(wgfl[2],1,2)
				local name2 = string.sub(wgfl[2],3,4)
				local name = {name1,name2}
				
				DrawString(stx+size,y3+y1+size+(m-1)*hg-m1*hg-y4,name[1],C_WHITE1,size,CC.FONT1) 
				DrawString(stx+size,y3+y1+size+(m-1)*hg-m1*hg,name[2],C_WHITE1,size,CC.FONT1)	
				DrawBox(stx+bx*20,y3+y1+size+m*hg-m1*hg,stx+x1+bx*860,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --画横线
				DrawBox(stx+bx*70,y3,stx+bx*70,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --画竖线
				m = m + 1
				if num1 > 0 then  
					m = m + 1
				end			
				n = 0
				m1 = 0
			end	
		
			--第三项
			if #kfmenu3 > 0 then 
				for i = 1,#kfmenu3 do 
					local cl = C_WHITE1
					if kfmenu3[i][3] > mpgx or kfmenu3[i][3] > jxkf then 
						kfmenu3[i][4] = 0
					end 
					if kfmenu3[i][4] == 0 then 
						cl = M_DimGray
					end
					DrawBox(stx+x1+(n)*w-size,y3+m*hg,stx+x1+(n)*w+hk,y3+m*hg+y1,cl,30);					
					if tb3 == i then 
						cl = C_RED
						DrawBox(stx+x1+(n)*w-size,y3+m*hg,stx+x1+(n)*w+hk,y3+m*hg+y1,C_RED,30);
					end
					DrawString(stx+x1+size*2+(n)*w-string.len(kfmenu3[i][2])/4*size,y3+m*hg+by*3,kfmenu3[i][2],cl,size,CC.FONT0)	
					n = n + 1
					if n == 5 then 
						n = 0
						m = m + 1 
					end
					kfnum = kfnum + 1
				end			
				local num,num1 = math.modf(#kfmenu3/5)
				if num1 == 0 then 
					m1 = m1 + 1
				end
				local name1 = string.sub(wgfl[3],1,2)
				local name2 = string.sub(wgfl[3],3,4)
				local name = {name1,name2}
				DrawString(stx+size,y3+y1+size+(m-1)*hg-m1*hg-y4,name[1],C_WHITE1,size,CC.FONT1) 
				DrawString(stx+size,y3+y1+size+(m-1)*hg-m1*hg,name[2],C_WHITE1,size,CC.FONT1)	
				DrawBox(stx+bx*20,y3+y1+size+m*hg-m1*hg,stx+x1+bx*860,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --画横线
				DrawBox(stx+bx*70,y3,stx+bx*70,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --画竖线
				m = m + 1
				if num1 > 0 then 
					m = m + 1
				end
				n = 0
				m1 = 0
			end	
		
			--第四项
			if #kfmenu4 > 0 then 
				for i = 1,#kfmenu4 do 
					local cl = C_WHITE1
					if kfmenu4[i][3] > mpgx or kfmenu4[i][3] > jxkf  then 
						kfmenu4[i][4] = 0
					end
					if kfmenu4[i][4] == 0 then 
						cl = M_DimGray
					end
					DrawBox(stx+x1+(n)*w-size,y3+m*hg,stx+x1+(n)*w+hk,y3+m*hg+y1,cl,30);					
					if tb4 == i then 
						cl = C_RED
						DrawBox(stx+x1+(n)*w-size,y3+m*hg,stx+x1+(n)*w+hk,y3+m*hg+y1,C_RED,30);
					end
					DrawString(stx+x1+size*2+(n)*w-string.len(kfmenu4[i][2])/4*size,y3+m*hg+by*3,kfmenu4[i][2],cl,size,CC.FONT0)	
					n = n + 1
					if n == 5 then 
						n = 0
						m = m + 1 
					end
					kfnum = kfnum + 1
				end			
				local num,num1 = math.modf(#kfmenu4/5)
				if num1 == 0 then 
					m1 = m1 + 1
				end
				local name1 = string.sub(wgfl[4],1,2)
				local name2 = string.sub(wgfl[4],3,4)
				local name = {name1,name2}
				DrawString(stx+size,y3+y1+size+(m-1)*hg-m1*hg-y4,name[1],C_WHITE1,size,CC.FONT1) 
				DrawString(stx+size,y3+y1+size+(m-1)*hg-m1*hg,name[2],C_WHITE1,size,CC.FONT1)	
				DrawBox(stx+bx*20,y3+y1+size+m*hg-m1*hg,stx+x1+bx*860,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --画横线
				DrawBox(stx+bx*70,y3,stx+bx*70,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --画竖线
				m = m + 1
				if num1 > 0 then 
					m = m + 1
				end
				n = 0
				m1 = 0
			end	
			
			--第五项
			if #kfmenu5 > 0 then 
				for i = 1,#kfmenu5 do 
					local cl = C_WHITE1
					if kfmenu5[i][3] > mpgx  or kfmenu5[i][3] > jxkf then 
						kfmenu5[i][4] = 0
					end
					if kfmenu5[i][4] == 0 then 
						cl = M_DimGray
					end
					DrawBox(stx+x1+(n)*w-size,y3+m*hg,stx+x1+(n)*w+hk,y3+m*hg+y1,cl,30);					
					if tb5 == i then 
						cl = C_RED
						DrawBox(stx+x1+(n)*w-size,y3+m*hg,stx+x1+(n)*w+hk,y3+m*hg+y1,C_RED,30);
					end
					DrawString(stx+x1+size*2+(n)*w-string.len(kfmenu5[i][2])/4*size,y3+m*hg+by*3,kfmenu5[i][2],cl,size,CC.FONT0)	
					n = n + 1
					if n == 5 then 
						n = 0
						m = m + 1 
					end
					kfnum = kfnum + 1
				end			
				local num,num1 = math.modf(#kfmenu5/5)
				if num1 == 0 then 
					m1 = m1 + 1
				end
				local name1 = string.sub(wgfl[5],1,2)
				local name2 = string.sub(wgfl[5],3,4)
				local name = {name1,name2}
				DrawString(stx+size,y3+y1+size+(m-1)*hg-m1*hg-y4,name[1],C_WHITE1,size,CC.FONT1) 
				DrawString(stx+size,y3+y1+size+(m-1)*hg-m1*hg,name[2],C_WHITE1,size,CC.FONT1)	
				--DrawBox(stx+bx*20,y3+y1+size+m*hg-m1*hg,stx+x1+bx*860,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --画横线
				DrawBox(stx+bx*70,y3,stx+bx*70,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --画竖线
				m = m + 1
				if num1 > 0 then 
					m = m + 1
				end			
				n = 0
				m1 = 0
			end
			m = 0
		end
		ShowScreen()
		lib.Delay(CC.Frame)
		local key,ktype,mx,my = lib.GetKey();
		if key == VK_ESCAPE or ktype == 4 then 
			PlayWavE(77)
			if CC.XKF == 2 then
				return Game_sm(3,2)
			else
				break
			end
		elseif key == VK_RETURN or key == VK_SPACE then 
			PlayWavE(77)
			if tb1 > 0 then 
				KF_sm(id,kfmenu1[tb1][1])
				--instruct_33(id,kfmenu1[tb1][1])
			elseif tb2 > 0 then 
				KF_sm(id,kfmenu2[tb2][1])
			elseif tb3 > 0 then 
				KF_sm(id,kfmenu3[tb3][1])
			elseif tb4 > 0 then 
				KF_sm(id,kfmenu4[tb4][1])
			elseif tb5 > 0 then 
				KF_sm(id,kfmenu5[tb5][1])
			end
		elseif key == VK_RIGHT then 
			PlayWavE(77)
			if #kfmenu1 > 0 and  tb1 > 0 then 
				tb1 = tb1 + 1 
				if tb1 > #kfmenu1 then 
					tb1 = 0
					if #kfmenu2 > 0 then 
						tb2 = 1
					elseif #kfmenu4 > 0 then 
						tb3 = 1
					elseif #kfmenu5 > 0 then 
						tb4 = 1
					elseif #kfmenu1 > 0 then 
						tb5 = 1
					else
						tb1 = 1
					end
				end
			elseif #kfmenu2 > 0 and  tb2 > 0 then 
				tb2 = tb2 + 1
				if tb2 > #kfmenu2 then 
					tb2 = 0
					if #kfmenu3 > 0 then 
						tb3 = 1
					elseif #kfmenu4 > 0 then 
						tb4 = 1
					elseif #kfmenu5 > 0 then 
						tb5 = 1
					elseif #kfmenu1 > 0 then 
						tb1 = 1
					else
						tb2 = 1
					end
				end
			elseif #kfmenu3 > 0 and  tb3 > 0 then 
				tb3 = tb3 + 1
				if tb3 > #kfmenu3 then 
					tb3 = 0
					if #kfmenu4 > 0 then 
						tb4 = 1
					elseif #kfmenu5 > 0 then 
						tb5 = 1
					elseif #kfmenu1 > 0 then 
						tb1 = 1
					elseif #kfmenu2 > 0 then 
						tb2 = 1
					else
						tb3 = 1
					end
				end
			elseif #kfmenu4 > 0 and  tb4 > 0 then 
				tb4 = tb4 + 1
				if tb4 > #kfmenu4 then 
					tb4 = 0
					if #kfmenu5 > 0 then 
						tb5 = 1
					elseif #kfmenu1 > 0 then 
						tb1 = 1
					elseif #kfmenu2 > 0 then 
						tb2 = 1
					elseif #kfmenu3 > 0 then 
						tb3 = 1
					else
						tb4 = 1
					end
				end
			elseif #kfmenu5 > 0 and  tb5 > 0 then 
				tb5 = tb5 + 1
				if tb5 > #kfmenu5 then 
					tb5 = 0
					if #kfmenu1 > 0 then 
						tb1 = 1
					elseif #kfmenu2 > 0 then 
						tb2 = 1
					elseif #kfmenu3 > 0 then 
						tb3 = 1
					elseif #kfmenu4 > 0 then 
						tb4 = 1
					else
						tb5 = 1
					end
				end
			end
		elseif key == VK_LEFT then 
			PlayWavE(77)
			if #kfmenu1 > 0 and  tb1 > 0 then 
				tb1 = tb1 - 1 
				if tb1 < 1 then 
					tb1 = 0
					if #kfmenu5 > 0 then 
						tb5 = #kfmenu5
					elseif #kfmenu4 > 0 then 
						tb4 = #kfmenu4
					elseif #kfmenu3 > 0 then 
						tb3 = #kfmenu3
					elseif #kfmenu2 > 0 then 
						tb2 = #kfmenu2
					else
						tb1 = #kfmenu1
					end
				end
			elseif #kfmenu2 > 0 and  tb2 > 0 then 
				tb2 = tb2 - 1 
				if tb2 < 1 then 
					tb2 = 0
					if #kfmenu1 > 0 then 
						tb1 = #kfmenu1
					elseif #kfmenu5 > 0 then 
						tb5 = #kfmenu5
					elseif #kfmenu4 > 0 then 
						tb4 = #kfmenu4
					elseif #kfmenu3 > 0 then 
						tb3 = #kfmenu3
					else
						tb2 = #kfmenu2
					end
				end
			elseif #kfmenu3 > 0 and  tb3 > 0 then 
				tb3 = tb3 - 1 
				if tb3 < 1 then 
					tb3 = 0
					if #kfmenu2 > 0 then 
						tb2 = #kfmenu2
					elseif #kfmenu1 > 0 then 
						tb1 = #kfmenu1
					elseif #kfmenu5 > 0 then 
						tb5 = #kfmenu5
					elseif #kfmenu4 > 0 then 
						tb4 = #kfmenu4
					else
						tb3 = #kfmenu3
					end
				end	
			elseif #kfmenu4 > 0 and tb4 > 0 then 
				tb4 = tb4 - 1 
				if tb4 < 1 then 
					tb4 = 0
					if #kfmenu3 > 0 then 
						tb3 = #kfmenu3 
					elseif kfmenu2 > 0 then 
						tb2 = #kfmenu2
					elseif #kfmenu1 > 0 then 
						tb1 = #kfmenu1
					elseif #kfmenu5 > 0 then 
						tb5 = #kfmenu5
					else
						tb4 = #kfmenu4
					end
				end	
			elseif #kfmenu5 > 0 and tb5 > 0 then 
				tb5 = tb5 - 1 
				if tb5 < 1 then 
					tb5 = 0
					if #kfmenu4 > 0 then 
						tb4 = #kfmenu4 
					elseif #kfmenu3 > 0 then 
						tb3 = #kfmenu3 
					elseif kfmenu2 > 0 then 
						tb2 = #kfmenu2
					elseif #kfmenu1 > 0 then 
						tb1 = #kfmenu1
					else 
						tb5 = #kfmenu5
					end
				end											
			end
		else
			local pd1 = false
			--第一项
			if #kfmenu1 > 0 then  
				for i = 1,#kfmenu1 do 
					if mx > stx+x1+(n)*w-size and mx < stx+x1+(n)*w+hk and my > y3+m*hg+h*hg and my < y3+m*hg+y1+h*hg then 
						tb1 = i 	
						tb2 = 0
						tb3 = 0
						tb4 = 0
						tb5 = 0
						pd1 = true				
						break
					end
					n = n + 1
					if n == 5 then 
						n = 0
						m = m + 1 
					end
				end	
				local num,num1 = math.modf(#kfmenu1/5)
				if num1 == 0 then 
					m1 = m1 + 1
				end
				m = m + 1
				if num1 > 0 then 
					m = m + 1
				end
				n = 0
				m1 = 0
				if pd1 == true and ktype == 3 then 
					KF_sm(id,kfmenu1[tb1][1])
				end	
			end	

			--第二项
			if #kfmenu2 > 0 then 
				local pd2 = false
				for i = 1,#kfmenu2 do 
					if mx > stx+x1+(n)*w-size and mx < stx+x1+(n)*w+hk and my > y3+m*hg+h*hg and my < y3+m*hg+y1+h*hg then 
						tb1 = 0 	
						tb2 = i
						tb3 = 0
						tb4 = 0
						tb5 = 0	
						pd2 = true				
						break
					end
					n = n + 1
					if n == 5 then 
						n = 0
						m = m + 1 
					end
				end	
				if pd2 == true and ktype == 3 then 
					KF_sm(id,kfmenu2[tb2][1])
				end	
				local num,num1 = math.modf(#kfmenu2/5)
				if num1 == 0 then 
					m1 = m1 + 1
				end
				m = m + 1
				if num1 > 0 then 
					m = m + 1
				end
				n = 0
				m1 = 0
			end

			--第三项
			if #kfmenu3 > 0 then 
				local pd3 = false
				for i = 1,#kfmenu3 do 
					if mx > stx+x1+(n)*w-size and mx < stx+x1+(n)*w+hk and my > y3+m*hg+h*hg and my < y3+m*hg+y1+h*hg then 
						tb1 = 0 	
						tb2 = 0
						tb3 = i
						tb4 = 0
						tb5 = 0	
						pd3 = true				
						break
					end
					n = n + 1
					if n == 5 then 
						n = 0
						m = m + 1 
					end
				end	
				if pd3 == true and ktype == 3 then 
					KF_sm(id,kfmenu3[tb3][1])
				end	
				local num,num1 = math.modf(#kfmenu3/5)
				if num1 == 0 then 
					m1 = m1 + 1
				end
				m = m + 1
				if num1 > 0 then 
					m = m + 1
				end
				n = 0
				m1 = 0
			end

			--第四项
			if #kfmenu4 > 0 then 
				local pd4 = false
				for i = 1,#kfmenu4 do 
					if mx > stx+x1+(n)*w-size and mx < stx+x1+(n)*w+hk and my > y3+m*hg+h*hg and my < y3+m*hg+y1+h*hg then 
						tb1 = 0 	
						tb2 = 0
						tb3 = 0
						tb4 = i
						tb5 = 0	
						pd4 = true				
						break
					end
					n = n + 1
					if n == 5 then 
						n = 0
						m = m + 1 
					end
				end	
				if pd4 == true and ktype == 3 then 
					KF_sm(id,kfmenu4[tb4][1])
				end	
				local num,num1 = math.modf(#kfmenu4/5)
				if num1 == 0 then 
					m1 = m1 + 1
				end
				m = m + 1
				if num1 > 0 then 
					m = m + 1
				end
				n = 0
				m1 = 0
			end
			--第五项
			if #kfmenu5 > 0 then 
				local pd5 = false
				for i = 1,#kfmenu5 do 
					if mx > stx+x1+(n)*w-size and mx < stx+x1+(n)*w+hk and my > y3+m*hg+h*hg and my < y3+m*hg+y1+h*hg then 
						tb1 = 0 	
						tb2 = 0
						tb3 = 0
						tb4 = 0
						tb5 = i	
						pd5 = true				
						break
					end
					n = n + 1
					if n == 5 then 
						n = 0
						m = m + 1 
					end
				end	
				if pd5 == true and ktype == 3 then 
					KF_sm(id,kfmenu5[tb5][1])
				end	
				local num,num1 = math.modf(#kfmenu5/5)
				if num1 == 0 then 
					m1 = m1 + 1
				end
				m = m + 1
				if num1 > 0 then 
					m = m + 1
				end
				n = 0
				m1 = 0					
			end	
			m = 0	
		end
	end
end

--门派学武功 内轻
function MP_XueKf_NQ(id,tid,xkf)
	local mp = JY.Person[tid]['门派']
	local bx,by = CC.ScreenW/1360,CC.ScreenH/768
	local size = CC.DefaultFont*0.9
	local kfmenu = {}
	local kfmenu6 = {}
	local kfmenu7 = {}
	local wgfl = {'内功','轻功','绝技'}
	local stx = bx*170 --背景开始坐标x
	local sty = by*50 --背景开始坐标y
	local mpgx = math.modf(JY.Person[id]['门派贡献']/200)+1
	local pg = 1
	local tb = 1
	local tb1,tb2,tb3,tb4,tb5 = 1,0,0,0,0
	local wugong = 0
	local xs = 1
	local lb = 1
	local pxmenu = {}
	local kfnum = 0
	local function kf_cjpx(a,b)
		return a[3] < b[3]
	end
	for i = 1,#CC.MpKf[mp] do 
		local kf = CC.MpKf[mp][i]
		local kfname = JY.Wugong[kf]['名称']
		local kflx = JY.Wugong[kf]['武功类型']
		local cj = JY.Wugong[kf]['层级']
		--kfmenu[#kfmenu+1] = {kf,kfname,kflx,xs}
		if kflx == 6 then 
			kfmenu6[#kfmenu6+1] = {kf,kfname,cj,xs}
			table.sort(kfmenu6, kf_cjpx)
		end
		if kflx == 7 then 
			kfmenu7[#kfmenu7+1] = {kf,kfname,cj,xs}
			table.sort(kfmenu7, kf_cjpx)
		end
	end
	if kfmenu6[1]~= nil then 
		tb1 = 1
	elseif kfmenu7[1]~= nil then 
		tb2 = 1
	end
	if xkf == nil then 
	else
		CC.XKF = xkf 
	end
	local jxkf = 2
	local cxfj = JY.Person[id]['畅想分阶']
	if cxfj == 1 or cxfj == 2 then 
		jxkf = 4
	elseif cxfj == 3  then 
		jxkf = 3
	elseif cxfj == 4   then 
		--jxkf = 2
	elseif  cxfj == 6 or cxfj == 5 then 
		--jxkf = 1
	end
	while true do
		if JY.Restart == 1 then
			break
		end		

		lib.Background(stx,sty,CC.ScreenW-stx,CC.ScreenH-sty,10)	
		lib.LoadPNG(91,506*2,0,0,1,1,100)	
		local mpnm = MP_name(tid)..'武学'
		local mpnm1 = JY.Person[id]['姓名']..'正在学习...'
		DrawString(CC.ScreenW/2-string.len(mpnm)/4*size,by*28,mpnm,C_WHITE,size,CC.FONT1)
		DrawString(CC.ScreenW/2-size*4-string.len(mpnm)/4*size-string.len(mpnm1)/4*size,by*35,mpnm1,C_WHITE,size*0.9,CC.FONT3)
		local h = 0
		local n,m = 0,0 
		local n1,m1 = 0,0
		local x1,y1 = bx*120,by*40
		local w = bx*180
		local hg = by*50 --行高
		local hk = bx* 140 -- 行宽
		local y3 = sty+size
		local y4 = by*40
		--如果表是空值，且
		if lb > 0 then 			
			--第一项
			if #kfmenu6 > 0 then 
				for i = 1,#kfmenu6 do 
					local cl = C_WHITE1
					if kfmenu6[i][3] > mpgx or kfmenu6[i][3] > jxkf then 
						kfmenu6[i][4] = 0
					end 
					if kfmenu6[i][4] == 0 then 
						cl = M_DimGray
					end
					DrawBox(stx+x1+(n)*w-size,y3+m*hg+h*hg,stx+x1+(n)*w+hk,y3+m*hg+y1+h*hg,cl,30);					
					if tb1 == i then 
						cl = C_RED
						DrawBox(stx+x1+(n)*w-size,y3+m*hg+h*hg,stx+x1+(n)*w+hk,y3+m*hg+y1+h*hg,cl,30);
					end
					DrawString(stx+x1+size*2+(n)*w-string.len(kfmenu6[i][2])/4*size,y3+m*hg+h*hg+by*3,kfmenu6[i][2],cl,size,CC.FONT0)	
					n = n + 1
					if n == 5 then 
						n = 0
						m = m + 1 
					end
					kfnum = kfnum + 1
				end			
				local num,num1 = math.modf(#kfmenu6/5)
				if num1 == 0 then 
					m1 = m1 + 1
				end
				local name1 = string.sub(wgfl[1],1,2)
				local name2 = string.sub(wgfl[1],3,4)
				local name = {name1,name2}		
				DrawString(stx+size,y3+y1+size+(m-1)*hg-m1*hg-y4,name[1],C_WHITE1,size,CC.FONT1) 
				DrawString(stx+size,y3+y1+size+(m-1)*hg-m1*hg,name[2],C_WHITE1,size,CC.FONT1)	
				DrawBox(stx+bx*20,y3+y1+size+m*hg-m1*hg,stx+x1+bx*860,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --画横线
				DrawBox(stx+bx*70,y3,stx+bx*70,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --画竖线
				m = m + 1
				if num1 > 0 then 
					m = m + 1
				end
				n = 0
				m1 = 0
			end

			--第二项
			if #kfmenu7 > 0 then 
				for i = 1,#kfmenu7 do 
					local cl = C_WHITE1
					if kfmenu7[i][3] > mpgx or kfmenu7[i][3] > jxkf then 
						kfmenu7[i][4] = 0
					end 
					if kfmenu7[i][4] == 0 then 
						cl = M_DimGray
					end
					DrawBox(stx+x1+(n)*w-size,y3+m*hg,stx+x1+(n)*w+hk,y3+m*hg+y1,cl,30);					
					if tb2 == i then 
						cl = C_RED
						DrawBox(stx+x1+(n)*w-size,y3+m*hg,stx+x1+(n)*w+hk,y3+m*hg+y1,C_RED,30);
					end
					DrawString(stx+x1+size*2+(n)*w-string.len(kfmenu7[i][2])/4*size,y3+m*hg+by*3,kfmenu7[i][2],cl,size,CC.FONT0)	
					n = n + 1
					if n == 5 then 
						n = 0
						m = m + 1 
					end
					kfnum = kfnum + 1
				end			
				local num,num1 = math.modf(#kfmenu7/5)
				if num1 == 0 then 
					m1 = m1 + 1
				end
				local name1 = string.sub(wgfl[2],1,2)
				local name2 = string.sub(wgfl[2],3,4)
				local name = {name1,name2}
				
				DrawString(stx+size,y3+y1+size+(m-1)*hg-m1*hg-y4,name[1],C_WHITE1,size,CC.FONT1) 
				DrawString(stx+size,y3+y1+size+(m-1)*hg-m1*hg,name[2],C_WHITE1,size,CC.FONT1)	
				DrawBox(stx+bx*20,y3+y1+size+m*hg-m1*hg,stx+x1+bx*860,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --画横线
				DrawBox(stx+bx*70,y3,stx+bx*70,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --画竖线
				m = m + 1
				if num1 > 0 then  
					m = m + 1
				end			
				n = 0
				m1 = 0
			end	
	
			m = 0
		end
		ShowScreen()
		lib.Delay(CC.Frame)
		local key,ktype,mx,my = lib.GetKey();
		if key == VK_ESCAPE or ktype == 4 then 
			if CC.XKF == 2 then
				return Game_sm(3,2)
			else
				break
			end
		elseif key == VK_RETURN or key == VK_SPACE then 
			if tb1 > 0 then 
				KF_sm(id,kfmenu6[tb1][1])
				--instruct_33(id,kfmenu1[tb1][1])
			elseif tb2 > 0 then 
				KF_sm(id,kfmenu7[tb2][1])
			end
		elseif key == VK_RIGHT then 
			if #kfmenu6 > 0 and  tb1 > 0 then 
				tb1 = tb1 + 1 
				if tb1 > #kfmenu6 then 
					tb1 = 0
					if #kfmenu7 > 0 then 
						tb2 = 1
					else
						tb1 = 1
					end
				end
			elseif #kfmenu7 > 0 and  tb2 > 0 then 
				tb2 = tb2 + 1
				if tb2 > #kfmenu7 then 
					tb2 = 0
					if #kfmenu6 > 0 then 
						tb1 = 1
					else
						tb2 = 1
					end
				end
			end	
		elseif key == VK_LEFT then 
			if #kfmenu6 > 0 and  tb1 > 0 then 
				tb1 = tb1 - 1 
				if tb1 < 1 then 
					tb1 = 0
					if #kfmenu7 > 0 then 
						tb2 = #kfmenu5
					else
						tb1 = #kfmenu6
					end
				end
			elseif #kfmenu7 > 0 and  tb2 > 0 then 
				tb2 = tb2 - 1 
				if tb2 < 1 then 
					tb2 = 0
					if #kfmenu6 > 0 then 
						tb1 = #kfmenu6
					else
						tb2 = #kfmenu7
					end
				end
			end	
		else
			local pd1 = false
			--第一项
			if #kfmenu6 > 0 then  
				for i = 1,#kfmenu6 do 
					if mx > stx+x1+(n)*w-size and mx < stx+x1+(n)*w+hk and my > y3+m*hg+h*hg and my < y3+m*hg+y1+h*hg then 
						tb1 = i 	
						tb2 = 0
						tb3 = 0
						tb4 = 0
						tb5 = 0
						pd1 = true				
						break
					end
					n = n + 1
					if n == 5 then 
						n = 0
						m = m + 1 
					end
				end	
				local num,num1 = math.modf(#kfmenu6/5)
				if num1 == 0 then 
					m1 = m1 + 1
				end
				m = m + 1
				if num1 > 0 then 
					m = m + 1
				end
				n = 0
				m1 = 0
				if pd1 == true and ktype == 3 then 
					KF_sm(id,kfmenu6[tb1][1])
				end	
			end	

			--第二项
			if #kfmenu7 > 0 then 
				local pd2 = false
				for i = 1,#kfmenu7 do 
					if mx > stx+x1+(n)*w-size and mx < stx+x1+(n)*w+hk and my > y3+m*hg+h*hg and my < y3+m*hg+y1+h*hg then 
						tb1 = 0 	
						tb2 = i
						tb3 = 0
						tb4 = 0
						tb5 = 0	
						pd2 = true				
						break
					end
					n = n + 1
					if n == 5 then 
						n = 0
						m = m + 1 
					end
				end	
				if pd2 == true and ktype == 3 then 
					KF_sm(id,kfmenu7[tb2][1])
				end	
				local num,num1 = math.modf(#kfmenu6/5)
				if num1 == 0 then 
					m1 = m1 + 1
				end
				m = m + 1
				if num1 > 0 then 
					m = m + 1
				end
				n = 0
				m1 = 0
			end
			m = 0	
		end
	end
end

--防坑指南
function fkwz()
	local bx,by = CC.ScreenW/1360,CC.ScreenH/768
	local size = CC.DefaultFont
	local cl = C_WHITE1

	local menu = {}
	for i = 1,#CC.NewGame_fkwz do
		menu[#menu+1] =CC.NewGame_fkwz[i]
	end
	local fymax = 0
	local fy = 0
	while true do 
		if JY.Restart == 1 then
			break
		end
		--lib.Background(0,0,CC.ScreenW,CC.ScreenH,90)
		lib.LoadPNG(91,24*2,0,0,1,0,CC.ScreenW/1360*100)
		--lib.LoadPNGPath(CC.HeadPath, 1, CC.HeadNum, 100)
		--lib.LoadPNGPath(CC.HeadPath, 1, CC.HeadNum, CC.SW/1360*100)

		local row = 0
		local maxh = 20
		for i = 1, #menu do
			local tfstr = menu[i]
			local h = 0
					
			h = tjm(bx*30, by*55 + size * (row-fy), tfstr, cl, size,math.modf((bx*1300)/size)-1,size,fy-row,maxh+1-row+fy)
			row = row + h
		end
		if row > maxh then
			fymax = limitX(row-maxh-1,0)
		else
			fymax = 0
		end
		if 	fymax > 0 then 
			lib.LoadPNG(91,124*2,CC.ScreenW-bx*25,CC.ScreenH-by*100,1,0,CC.ScreenW/1360*60) 
		end	
		if fy > 0 then 
			lib.LoadPNG(91,127*2,CC.ScreenW-bx*25,by*70,1,0,CC.ScreenW/1360*60) 
		end
		--lib.Debug('fy='..fy..' fy-row='..fy-row)
		ShowScreen()
		lib.Delay(CC.Frame)
		local keypress,ktype,mx,my = lib.GetKey()
		if keypress == VK_ESCAPE or ktype == 4 then
			break
		elseif keypress == VK_DOWN or ktype == 7 then 
			--lib.Debug('fy='..fy..' fy-row='..fy-row)
			fy = fy + 1
			if fy > fymax then
				fy = fymax 
			end
		elseif keypress == VK_UP or ktype == 6 then 
			--lib.Debug('fy='..fy..' fy-row='..fy-row)
			fy = fy - 1
			if fy < 0 then 
				fy = 0
			end	
		end
	end
end


--境界天赋选择
function JJ_TF(pid,tnum)
	local bx,by = CC.ScreenW/1360,CC.ScreenH/768
    local tb = 1
	local tb1 = 0
    local size = CC.DefaultFont*0.7
    local pg = 1
    local menu = {}
	local w1,h1 = lib.GetPNGXY(91,139*2)
    local w = math.modf(w1/size)
	local zm = JY.Base["周目"]
	local zmtf = math.ceil(zm/4)
	local lbnum = 54
	local rwnum = 6
	local hh1 = 0
	local lb = lbnum
	local tfid = 0
	local x,y = CC.ScreenW/4,CC.ScreenH/9
	local n,m = 0,0
	local x1 = x*2-x/3
	local y1 = y*3/2+y/3+y/10
	local yy = h1*3/2
	local xx = w1*8/7
	local fymenu = {'上一页','下一页','确  定','删  除','退  出'}
	local tfn = 0
	local xzmenu = 0
	local xzid = '无'
	local xzsm = ''
	local xztf = 0
	local xzme = {}
	local hnum = lbnum/rwnum
	local sme = 0
	local smenu = {}
	local jj = JY.Person[pid]['畅想分阶'] - 1
	local tffj = 0
	local tfmax = 1
	local cl = C_WHITE1
	if tnum == nil then 
		if jj == 5 or  jj == 4 then 
			tffj = 2
		end 
		if jj == 3 or jj == 2 then 
			tffj = 3
		end
		if jj == 1 or jj == 0 then 
			tffj = 4
		end  
	end
	local tfme = {}

	for i = 1,5 do 
		local ptf = JY.Person[pid]['天赋'..i]
		if ptf > 0 then 
			tfme[#tfme+1] = ptf 
		end
	end
	tfn = #tfme
	lib.Debug('tfn = '..tfn)
	if tfn >= 5 then 
		return
	end
	if tnum == nil then 
		if tffj - tfn < 0 then
			return 
		end
	end
	for i = 1,#CC.Tiangtf do 
		local tffc = CC.Tiangtf[i]
		if CC.PTFSM[tffc][5] ~= nil then 
			if CC.PTFSM[tffc][3] == 1 then
				if tnum ~= nil then 
					menu[#menu+1] = {tffc,1}
				else 	
					if CC.PTFSM[tffc][5] == tffj then
						menu[#menu+1] = {tffc,1}
					end
				end
			end
		end
	end
    if #menu <= 0  then
        return   
    end
	local tfmax = 1
	local num = math.modf(#menu/lbnum)
	num = num + 1
    while true do
	   if JY.Restart == 1 then
            break
       end	
        ClsN()
        lib.LoadPNG(91,24*2,-1,-1,1)
		local namewz = JY.Person[pid]['姓名']..'正在选择...'
		local tfwz = '天赋列表'
		DrawString(CC.ScreenW/2-string.len(tfwz)/4*size*1.2,by*25,tfwz,cl,size*1.2,CC.FONT1)
		DrawString(CC.ScreenW/2-size*4-string.len(namewz)/4*size-string.len(tfwz)/4*size*1.2,by*25,namewz,cl,size,CC.FONT3)
		if lb > #menu then 
			lb = #menu 
		end
		if pg < num then 
			lb = lbnum
		elseif pg == num then 
			lb = #menu - (num-1)*lbnum
		end
	   	for i = 1,lb do 
			local cl = C_WHITE1	
			if menu[i + (pg-1)*lbnum][2] == 0 then 
				cl = M_DimGray
			end
			if tb == i then 
				cl = C_RED
			end
			local sm = CC.PTFSM[menu[i + (pg-1)*lbnum][1]]
			lib.Background(x1+(n-1)*xx-w1/2,y1+(m-1)*yy-h1/2+hh1,x1+(n-1)*xx-w1/2+w1,y1+(m-1)*yy-h1/2+h1+hh1,98)
			DrawString(x1+(n-1)*xx-string.len(sm[1])/4*size,y1+(m-1)*yy-h1/3+hh1,sm[1],cl,size)
			n = n + 1
			if n == rwnum then 
				m = m + 1
				n = 0
			end
		end
        n = 0
		m = 0
		if #xzme == tfmax then 
			fymenu = {'上一页','下一页','确  定','删  除','下一步'}
		end
		for i = 1,#fymenu do 
			local cl = C_WHITE1	
			if tb1 == i  then 
				cl = C_RED
			end
			lib.Background(x1+(i-2)*xx-w1/2,y1+(hnum)*yy-h1/2+hh1,x1+(i-2)*xx-w1/2+w1,y1+(hnum)*yy-h1/2+h1+hh1,98)
			DrawString(x1+(i-2)*xx-string.len(fymenu[i])/4*size,y1+(hnum)*yy-h1/3+hh1,fymenu[i],cl,size)
		end
		local pgwz = '页数： '..pg..' / '..num 
		DrawString(x1+xx*3+-string.len(pgwz)/4*size,h1*2/3,pgwz,M_DeepSkyBlue,size)
		local tfh = 0
		local tfsm = 0
		--选择天赋查看
		local tfid = CC.PTFSM[menu[tb + (pg-1)*lbnum][1]]
		DrawString(x1/12,y1-yy-h1/3,'天赋名称： ',C_WHITE1,size)
		DrawString(x1/5-string.len(tfid[1])/4*size+size*4,y1-yy-h1/3,tfid[1],M_DeepSkyBlue,size)
		tfsm = tfsm + 1
		tfsm = tjm(x1/12,y1-yy+h1,tfid[2],C_WHITE,size,9,size)
		
		for i = 1,#xzme do
			if xzme[i] ~= nil then 
				local xid = xzme[i]
				local xidwz = CC.PTFSM[xid][1]
				DrawString(x1/12,y1-yy-h1/3+y1*2+size*3,'已选天赋： '..'可选择'..tfmax..'个天赋',C_WHITE1,size)
				DrawString(x1/4-string.len(xidwz)/4*size,y1-yy-h1/3+y1*2+size*2+(i-1)*size*2+size*3,xidwz,M_DeepSkyBlue,size)
			end
		end	

		if sme == 1 then 
			DrawString(x1/12+size*9,CC.ScreenH-size*7,'无法选择更多天赋，请点击【下一步】',C_RED,size*2)
		end
        ShowScreen()
        lib.Delay(CC.Frame)
        local X, ktype, mx, my = lib.GetKey();
		if X == VK_SPACE or X == VK_RETURN then
			PlayWavE(77)
			if tb1 == 1 then 
				if pg > 1 then 
					pg = pg - 1
				end 
			elseif tb1 == 2 then 
				if pg < num  then 
					pg = pg + 1
					tb = 1
				end
			elseif tb1 == 3 then 
				if #xzme >= tfmax then 						
					sme = 1
				else
					if menu[tb + (pg-1)*lbnum][2] > 0 then 
						tb1 = 0
						smenu[#smenu+1] = tb + (pg-1)*lbnum
						xzme[#xzme+1] = menu[tb + (pg-1)*lbnum][1]	
						menu[tb + (pg-1)*lbnum][2] = 0	
					end
				end
			elseif tb1 == 4 then 
				if #smenu > 0 then  
					menu[smenu[#smenu]][2] = 1
					removebyvalue(xzme,xzme[#xzme])												
					removebyvalue(smenu,smenu[#smenu])
				end
			elseif tb1 == 5 then 				
				if #xzme == 0 then 
					lib.Debug('1xzme = '..#xzme)
					break
				elseif #xzme >= tfmax then
					for i = 1,#xzme do 						
						SetTF(pid,xzme[i],1)	
						CC.TF_Start[#CC.TF_Start+1] = {pid,xzme[i]}									
					end
					DrawStrBoxWaitKey(JY.Person[pid]['姓名'].."获得新天赋"..CC.PTFSM[xzme[1]][1], C_GOLD, CC.DefaultFont,nil, C_RED)				
					break	
				end
			else  	
				tb1 = 1
				xztf = menu[tb + (pg-1)*lbnum][1]
			end			
		elseif X == VK_ESCAPE or ktype == 4 then
			PlayWavE(77)
			if sme == 1 then 
				sme = 0
			else
				if tb1 > 0 then 
					tb1 = 0
				else
					--return 1
				end	
			end		
		elseif X == VK_UP then
			if tb1 == 0 then 
				if tb - rwnum > 1 then 
					tb = tb - rwnum 
				end
			else
				tb = lb 
				tb1 = 0
			end
		elseif X == VK_DOWN then
			PlayWavE(77)
			if tb1 == 0 then 
				if tb + rwnum < lb then
					tb = tb + rwnum 
				else 
					tb1 = 1
				end	
			end	
		elseif X == VK_LEFT then
			PlayWavE(77)
			if tb1 == 0 then 
				tb = tb - 1
				if tb < 1 then 
					tb = 1
				end
			else
				tb1 = tb1 - 1
				if tb1 < 1 then 
					tb1 = #fymenu
				end
			end
		elseif X == VK_RIGHT then
			PlayWavE(77)
			if tb1 == 0 then 
				tb = tb + 1
				if tb > lb then 
					tb = lb 
				end
			else
				tb1 = tb1 + 1
				if tb1 > #fymenu then 
					tb1 = 1
				end
			end
        else
			local pd =false 
			for i = 1,lb do 
				--lib.Background(x1+(n-1)*xx-w1/2,y1+(m-1)*yy-h1/2,x1+(n-1)*xx-w1/2+w1,y1+(m-1)*yy-h1/2+h1,98)
				if mx >= x1+(n-1)*xx-w1/2 and mx < x1+(n-1)*xx-w1/2+w1 and my >= y1+(m-1)*yy-h1/2+hh1 and my < y1+(m-1)*yy-h1/2+h1+hh1 then 

					if tb1 == 0 then
						tb = i 
						pd = true
					end
					break
				end
				n = n + 1
				if n == rwnum then 
					n = 0
					m = m + 1
				end
			end
			n = 0
			m = 0
			if pd == true and ktype == 3 then
				tb1 = 1
				xztf = menu[tb + (pg-1)*lbnum][1]
			end	
			local pd1 = false
			for i = 1,#fymenu do 
				if mx >=x1+(i-2)*xx-w1/2 and mx < x1+(i-2)*xx-w1/2+w1 and my >= y1+(hnum)*yy-h1/2+hh1 and my < y1+(hnum)*yy-h1/2+h1+hh1 then 								
					tb1 = i 
					pd1 = true
					break
				end
			end
			if pd1 == true and ktype == 3 then 
				PlayWavE(77)
				if tb1 == 1 then 
					if pg > 1 then 
						pg = pg - 1
						tb = lb
					end 
				elseif tb1 == 2 then 
					if pg < num  then 
						pg = pg + 1
						tb = 1
					end
				elseif tb1 == 3 then 
					if #xzme >= tfmax then 						
						sme = 1
					else
						if menu[tb + (pg-1)*lbnum][2] > 0 then 
							tb1 = 0
							smenu[#smenu+1] = tb + (pg-1)*lbnum
							xzme[#xzme+1] = menu[tb + (pg-1)*lbnum][1]	
							menu[tb + (pg-1)*lbnum][2] = 0							
							pd1 = false			
						end
					end
				elseif tb1 == 4 then 
					if #smenu > 0 then  
						menu[smenu[#smenu]][2] = 1
						removebyvalue(xzme,xzme[#xzme])												
						removebyvalue(smenu,smenu[#smenu])
					end
				elseif tb1 == 5 then 
					if #xzme == 0 then 
						break
					elseif #xzme >= tfmax then
						for i = 1,#xzme do 						
							SetTF(pid,xzme[i],1)	
							CC.TF_Start[#CC.TF_Start+1] = {pid,xzme[i]}									
						end
						DrawStrBoxWaitKey(JY.Person[pid]['姓名'].."获得新天赋"..CC.PTFSM[xzme[1]][1], C_GOLD, CC.DefaultFont,nil, C_RED)				
						break					
					else
						tb1 = 0
					end
				end	
			end
        end
    end
end

--清空表格 当deaults为空值时清除表格t
function resetTable(t, defaults)
    -- 如果提供了默认值，则使用它们来填充表格
    if defaults then
        for k, v in pairs(defaults) do
            t[k] = v
        end
    else
        -- 否则，只是清空表格
        for k in pairs(t) do
            t[k] = nil
        end
    end
end

--人物外号
function Person_WH(id)
	if id == nil then 
		id = 0
	end
	local wh = JY.Person[id]['姓名']
	local name1 =string.sub(JY.Person[id]['姓名'],1,2)
	if JY.Person[id]['掌门'] > 0 or (inteam(id) == false ) then 
		wh = name1..MP_zw(id)
	elseif JY.Person[id]['畅想分阶'] <= 3 then
		if JY.Person[id]["性别"] == 0 then
			wh = name1..'大侠'
		else
			wh = name1..'女侠'
		end 
	else
		if JY.Person[id]["性别"] == 0 then
			wh = name1..'少侠'
		else
			wh = name1..'女侠'
		end
	end
	return wh
end

--内功特效 轻功特效
function NeiGong_tx(pid,tx,flag) 
	--lib.Debug('NeiGong_tx')
	local kf_ng = JY.Person[pid]['主运内功']
	local kf_qg = JY.Person[pid]['主运轻功']
	if flag == nil then
		if kf_ng == 0 then 
			return false 
		end
	else 
		if kf_qg == 0 then 
			return false 
		end
	end

	if JY.Status == GAME_WMAP then
		if WAR.PD['散功状态'][pid] ~= nil then 
			return false 
		end
	end

	for i = 1,10 do 
		if JY.Wugong[kf_ng]['特效'..i] == tx  then 
			return true
		end
	end
	for i = 1,10 do 
		if JY.Wugong[kf_qg]['特效'..i] == tx then 
			return true
		end
	end

	--自动运功
	local personid = pid
	local NGid = 0
	local pmenu ={	
					--下面是内功
					{637,107},--黄赏 九阴
					{27,105}, --东方 葵花
					{9795,90}, --
					{511,227}, --
					{60,95}, --
					{9771,99}, --
					{149,108}, --
					{9997,175}, --五岳
					{22,175},--五岳
					{21,175},--五岳
					{20,175},--五岳
					{23,175},--



	
				}

	for i = 1,#pmenu do 	
		if Curr_NG(pid,pmenu[i][2]) then 
			for w = 1,10 do 
				if JY.Wugong[pmenu[i][2]]['特效'..w] == tx  then 
					--lib.Debug('确定主运内功')
					return true
				end
			end
		end					
	end


	local pmenu_qg = {
					--轻功
					{9963,186}, --
					{130,145}, ---
					}

	for i = 1,#pmenu_qg do	
		if Curr_QG(pid,pmenu_qg[i][2]) then 
			for w = 1,10 do 
				if JY.Wugong[pmenu_qg[i][2]]['特效'..w] == tx  then 
					lib.Debug('确定主运轻功')
					return true
				end
			end
		end						
	end


	--内功特殊情况
	--忘情天书
	if match_ID(pid,752) or match_ID(pid,652) then 
		local ts = 0
		if pid == 0 and JY.Base["天书数量"] >= 7 and CC.TX["忘情天书"] == 1 then 
			ts = 1
		end
		if inteam(pid) == false then 
			ts = 1
		end
		if ts == 1 then 
			for w = 1,10 do 
				if JY.Wugong[177]['特效'..w] == tx then 
					return true
				end
			end
		end
	end
	-- 物转星移
	if PersonKF(pid, 43) and KF_level(pid, 43) > 10 and JY.Person[pid]['奇穴' .. 149] == 1  then
		for w = 1,10 do 
			if JY.Wugong[43]['特效'..w] == tx then 
				return true
			end
		end
	end

	--学会了九阴，九逆，如果主运九阴，则九逆也是主运
	if PersonKF(pid, 104) and PersonKF(pid, 107)  and JY.Person[pid]["主运内功"] == 107 then
		for w = 1,10 do 
			if JY.Wugong[104]['特效'..w] == tx then 
				return true
			end
		end
	end
	-- 天罡的判定
	if pid == 0 and JY.Person[pid]['内力性质'] == 3 then
		-- 如果是天内，并且已经学会，则自动主运
		if JY.Person[pid]["天赋内功"] == kf_ng and PersonKF(pid, kf_ng) then
			for w = 1,10 do 
				if JY.Wugong[kf_ng]['特效'..w] == tx then 
					return true
				end
			end
		end
	end

	--轻功特殊情况
	--胡一刀天赋轻功自动运功
	if match_ID(pid, 633) and kf_qg == JY.Person[pid]["天赋轻功"] and PersonKF(pid, kf_qg) then
		for w = 1,10 do 
			if JY.Wugong[kf_qg]['特效'..w] == tx then 
				return true
			end
		end
	end
	return false	
	
end

--剧情指引
function Game_Kdef()
	--Cls()
	local bx,by = CC.ScreenW/1360,CC.ScreenH/768
	local size = CC.DefaultFont
	local TSmenu = {'飞狐外传','雪山飞狐','连城诀','天龙八部','射雕英雄传','白马啸西风','鹿鼎记','笑傲江湖','书剑恩仇录','神雕侠侣','侠客行','倚天屠龙记','碧血剑','鸳鸯刀',}
	--飞狐外传
	local Fei = {
		{'（北部）沧州*触发战斗：*VS范兴汉',0,'奖励：*道德+1'},
		{'（北部）沧州 *深夜进入客栈后，触发剧情',1,'奖励：'},
		{'（北部）沧州 *左边房间找到阎基，触发剧情',2,'奖励：'},
		{'（北部）沧州 *替胡一刀送信，沧州右下角房间寻找苗人凤，触发剧情',3,'奖励：'},
		{'（北部）沧州 *客栈同胡一刀对话后返回自己房间（胡一刀房间对面）',4,'奖励：*道德+1'},
		{'（北部）沧州 *客栈大堂剧情后，触发战斗：*VS苗人凤（战胜或坚持200时序）',5,'奖励：'},
		{'（中原）商家堡 *进入商家堡后，触发战斗：*VS商剑鸣+商夫人',6,'奖励：'},
		{'（北部）沧州 *去沧州客栈大厅寻找胡一刀，触发剧情',7,'奖励：'},
		{'（北部）沧州 *客栈返回自己房间休息，剧情后触发战斗：*VS范兴汉+天龙门弟子x2+丐帮弟子x2',8,'奖励：'},
		{'（北部）沧州*客栈大堂剧情后，触发战斗：VS苗人凤（战胜或坚持200时序），*剧情后，触发战斗：VS阎基胜后得【千金方】',9,'奖励：*千金方[杂学]'},
		{'（北部）沧州*客栈回自己房间休息到第二天，然后再去客栈大堂寻找胡一刀对话触发剧情。',10,'奖励：'},
		{'（北部）沧州*客栈返回客栈自己房间后，再进入大堂，触发胡一刀中毒剧情,若队伍中是有三大神医之一（薛慕华、平一指、胡青牛）触发程灵素线，无三大神医触发袁紫衣线，*PS:袁紫衣线需开启闯王藏宝洞宝箱才能拿到飞狐外传',11,'奖励：'},
		{'【袁紫衣线】（北部）沧州*客栈后方对话苗人凤，',12,'奖励：'},
		{'【袁紫衣线】商家堡（中原）*进入商家堡，遇胡斐，剧情后：*VS 商夫人+商宝震，战斗胜利后，胡斐入队',13,'奖励：*胡斐入队[队友]'},
		{'【袁紫衣线】商家堡（中原）*进入商家堡大厅剧情后：*VS 王剑杰胜后得【八卦心法】【八卦刀法】【八卦掌】，',14,'奖励：*八卦心法[内功] *八卦刀法[刀法] *八卦掌[拳掌]'},
		{'【袁紫衣线】商家堡（中原）*被困商家堡，寻机机关开门（调查蒲团），剧情后：*VS 商夫人+商宝震，',15,'奖励：'},
		{'【袁紫衣线】佛山（江南）*佛山客栈触发剧情，剧情后前往地图右上方五虎门，对话看门人：*VS 五虎门人，',16,'奖励：道德+1'},
		{'【袁紫衣线】佛山（江南）*五虎门对话凤天南，触发剧情：*VS凤天南，',17,'奖励：*道德+2'},
		{'【袁紫衣线】佛山（江南）*五虎门出门后触发剧情：*胡斐VS 袁紫衣，*回五虎门剧情，再次回五虎门*胡斐VS御前侍卫x2+带刀官兵x2',18,'奖励：道德+1'},
		{'【袁紫衣线】衡阳（江南）*韦陀门触发剧情：*VS刘鹤真',19,'奖励：'},
		{'【袁紫衣线】衡阳（江南）*对话韦陀门外马，触发剧情：获得[绝群]袁紫衣入队，',20,'奖励：*绝群[坐骑] *袁紫衣入队[队友]'},
		{'【袁紫衣线】衡阳（江南）*袁紫衣在队，回雁楼触发剧情：VS 蓝秦+御前侍卫+带刀官兵胜利后获得【八仙剑法】剧情后袁紫衣离队，',21,'奖励：道德+2 *八仙剑法[剑法秘籍]'},
		{'【袁紫衣线】药王庙（中原）*追踪袁紫衣的踪迹，遇凤天南战斗：*VS袁紫衣+凤天南',22,'奖励：'},
		{'【袁紫衣线】北京（北部）*对话福康安府看门人，剧情后触发战斗：*主角+胡斐+袁紫衣VS 汤沛，继续剧情后触发战斗：*主角+胡斐+袁紫衣VS 汤沛+田归农+王剑杰+王剑英+范兴汉+赛尚鄂+一群官兵，',23,'奖励：道德+2 *八仙剑法[剑法秘籍]'},
		{'【袁紫衣线】北京（北部）*剧情后收袁紫衣入队,获得[闯王军刀] [冷月宝刀]，',24,'奖励：*闯王军刀[武器] *冷月宝刀[武器] *袁紫衣入队[队友]'},
		{'【程灵素线】（北部）沧州*客栈后方对话苗人凤，获得【苗家剑法】',26,'奖励：*苗家剑法[剑法秘籍]'},
		{'【程灵素线】商家堡（中原）*进入商家堡，遇胡斐，剧情后：*VS 商夫人+商宝震，战斗胜利后，胡斐入队，',27,'奖励：*胡斐入队[队友]'},
		{'【程灵素线】商家堡（中原）*进入商家堡，剧情后：*VS 王剑杰，胜后得【八卦心法】【八卦刀法】【八卦掌】',28,'奖励：*八卦心法[内功] *八卦刀法[刀法] *八卦掌[拳掌]'},
		{'【程灵素线】商家堡（中原）*剧情后被困商家堡，点击右侧蒲团开门，剧情后：*VS 商夫人+商宝震，',29,'奖励：'},
		{'【程灵素线】苗家庄（中原）*进入苗家庄，剧情后：*VS 御前侍卫x2+带刀官兵x2，战斗胜利后，过剧情',30,'奖励：道德+2'},
		{'【程灵素线】衡阳-药王庄（江南）* 与程灵素对话，程灵素会要求去找[七心海棠]，',31,'奖励：'},
		{'【程灵素线】阎基居（江南）*胡斐在队时，进入左上房间，触发剧情，我方全员中毒内力全失进入战斗*VS 阎基，胜后得[两页刀法][七心海棠] ，',32,'奖励：*道德+2 *两页刀法[剧情道具] *七心海棠[剧情道具] *千金方[医书] 阎基身上偷取'},
		{'【程灵素线】衡阳-药王庄（江南*） 与程灵素对话，给程灵素[七心海棠]，得到[苗人凤眼毒解药]，胡斐在队伍时，再次与程灵素对话，可邀请程灵素入队，获得【药王神篇】，',33,'奖励：*苗人凤眼毒解药[剧情道具] *药王神篇[医书] *程灵素[队友] 加入'},
		{'【程灵素线】苗家庄（中原） *给苗人凤[苗人凤眼毒解药]，剧情后胡斐离队。与胡斐对话，可收胡斐入队，',34,'奖励：*胡斐入队[队友]'},
		{'【程灵素线】苗家庄（中原） *胡斐在队再次与苗人凤对话，选是触发战斗：*VS 苗人凤，获得《飞狐外传》，',35,'奖励：*道德+2 *飞狐外传[十四天书之一]'},
		{'【程灵素线】北京（北部） *对话福康安府看门人触发剧情：*VS 汤沛，继续剧情后触发战斗：*VS 汤沛+田归农+王剑杰+王剑英+范兴汉+赛尚鄂+一群官兵， 北京城门口袁紫衣送[闯王军刀] [冷月宝刀]，袁紫衣入队[队友]',36,'奖励：*闯王军刀[武器] *冷月宝刀[武器] *袁紫衣入队[队友]'},
		{'已完成全部剧情',37},
	}
	--雪山飞狐
	local Xue = {
		{'完成飞狐外传触发',0,'奖励：道德+1'},
		{'玉笔山庄（北部） *左上山洞进入闯王藏宝洞一路往里走，遇到大雪怪触发战斗：*VS 一群大雪怪，身上有闯王军刀时，空格点击钥匙孔打开铁门，开启里面四个宝箱可获大量奖励（PS另一个山洞的雪人打了有一个千年人参）。',1,'奖励：*雪山飞狐[十四天书之一]*飞狐外传[十四天书之一]（飞狐外传袁紫衣线可获得）*鸳刀[武器]*银两2000*千年灵芝[丹药]*四象步法[轻功秘籍]*黑风指法[指法秘籍]*萧中慧在队萧中慧轻功+50 *袁紫衣在队第三格洗飞天神行，天赋轻功洗飞天神行'},
		{'已完成全部剧情',2},
	}
	--连城诀
	local Lian = {
		{'唐诗山洞（江南）*寻找狄云，狄云入队，获得[乌蚕衣]，开启狄云身后的箱子的[唐诗选集]',0,'奖励：*道德+2 *唐诗选集[剧情道具] *乌蚕衣[防具] *狄云[队友]'},
		{'破庙（北部）*狄云在队时，点击丁典的坟触发剧情后进入破庙里，触发战斗：*VS 宝象，胜后得【血刀心法】、[银两]200',1,'奖励：*银两200 *血刀心法[内功秘籍]'},
		{'龙门客栈（西部）*进入客栈后触发剧情，狄云被血刀老祖掳走',2,'奖励：'},
		{'雪山（北部）*剧情后选择正邪线。*选择『否』进入正线，触发战斗：*VS 血刀老祖，胜后得【鬼头刀法】，剧情后狄云神照功大成属性提升。*选择『是』进入邪线，触发战斗：*VS 落花流水+水笙，再战斗 *VS水笙,剧情后可选择是否收花铁干入队。',3,'奖励：*【正线】：*道德+2 *鬼头刀法[刀法秘籍]，*狄云奖励：*攻击+30、防御+30、轻功+30 *五系兵器值+10 狄云成血刀门掌门 *第二格武功洗血刀大法 1级 *【邪线】*道德-3 *中平枪法[奇门秘籍] *花铁干[队友] 加入'},
		{'【正线】雪山（北部）*与狄云对话后收狄云入队，得【血刀经】',4,'奖励：*血刀经[刀法秘籍] *狄云[队友] '},
		{'【正线】雪山（北部）*对着水盆使用[唐诗选集]，得知连城诀的秘密，狄云学会连城剑法，获得【连城剑法】',5,'奖励：*连城剑法[剑法秘籍] *狄云奖励： *第三格武功洗连城剑法 1级'},
		{'【正线】江陵-天宁寺（江南）*进入场景后触发战斗：*VS 一群喽啰',6,'奖励：'},
		{'【正线】江陵-天宁寺（江南）*触碰天宁寺内佛像机关，若狄云不在队或道德<80：获得《连城诀》*/若道德≥80且狄云在队：获得《连城诀》【神照经】',7,'奖励：*连城诀[十四天书之一] */道德+1 连城诀[十四天书之一] 神照经[内功秘籍]'},
		{'【正线】江陵-天宁寺（江南）*出门触发剧情，狄云被戚长发偷袭，进入战斗：*VS 戚长发',8,'奖励：'},
		{'【正线】雪山（北部）*狄云在队时，与水笙对话，可收水笙入队',9,'奖励：*水笙[队友] 加入'},
		{'已完成全部剧情',10},
		{'【邪线】雪山（北部）*与血刀老祖对话，血刀老祖给予【血刀经】，再次与其对话，选『是』触发战斗：*VS 血刀老祖，胜后获得[血刀]、【血河神鉴】',11,'奖励：*血刀经[刀法秘籍] *血刀[武器] *血河神鉴[内功秘籍]'},
		{'【邪线】雪山（北部）*对着水盆使用[唐诗选集]，得知连城诀的秘密',12,'奖励：*连城剑法[剑法秘籍]'},
		{'【邪线】江陵-天宁寺（江南）*进入场景后触发战斗：*VS 一群喽啰',13,'奖励：'},
		{'【邪线】江陵-天宁寺（江南）*天宁寺内佛像背后获得《连城诀》',14,'奖励：*连城诀[十四天书之一]'},
	}
	--天龙八部
	local Tian = {
		{'无量山（西部）*游历无量山触发剧情，战斗：*VS 神龙高手+神龙教徒，胜后可收钟灵入队，获得【万劫刀法】。*（PS:带钟灵去云岭洞找到闪电貂,钟灵领悟“灵貂”指令（偷窃敌方携带的物品并对其强制上毒50点）,如果钟灵不在队伍，调查闪电貂后，闪电貂会消失不见）',0,'奖励：*道德+1 *万劫刀法[刀法秘籍] *大蟠桃[丹药] 调查树*钟灵[队友] 加入'},
		{'无量山（西部）*进入左上的无量山洞,找到段誉（不带钟灵则无法获得凌波微步），剧情后出来在山洞出口处触发战斗：*VS 莽牯朱蛤 *胜后获得[莽牯朱蛤]',1,'奖励：莽牯朱蛤[丹药]'},
		{'无量山（西部）*无量山发现段誉正被四大恶人围住，触发战斗:*VS四大恶人 *胜后获得【鹤蛇八打】 [鳄皮护甲]',2,'奖励：*道德+1 *鹤蛇八打[奇门秘籍] *鳄皮护甲[防具] *大剪刀刀谱[奇门秘籍]偷岳老三 *大剪刀[武器]偷岳老三'},
		{'大理-天龙寺（西部）*进入天龙寺，遇见鸠摩智来抢六脉神剑，触发战斗：*VS 鸠摩智（可败）战斗后对话枯荣大师，获得【枯荣禅功】*两次对话左上房间僧人，可得到“长春不老谷”的信息',3,'奖励：*道德+1 *溪山行旅图[剧情道具] 房间宝箱 *火焰刀[刀法秘籍] 胜鸠摩智 *枯荣禅功[内功秘籍] 对话枯荣大师'},
		{'苏州-燕子坞（江南）*进入燕子坞右边房间，剧情后与慕容复对话，先给慕容复[玉玺](开局搜刮)，再给[大燕皇帝世袭图表](铁掌山宝箱)，触发正邪分支:*选『否』进入正线，临走时段誉送主角【北冥神功】*选『是』接受慕容复的请求，获得[带头大哥的书信]慕容复、王语嫣入队，虚竹在队则会永久离队*邪线开启后将不可收虚竹入队，需要天山六阳掌、小无相功、七宝指环的要提前去做完虚竹支线*邪线不要提前去少林寺拿【一苇渡江】，否则慕容复无法领悟黑级浮屠',4,'奖励：*【正线】北冥神功[内功秘籍]*【正线】道德+2 *【邪线】道德-8 *【邪线】斗转星移[特技]慕容复加入获得 *【邪线】慕容复[队友]加入 *【邪线】王语嫣[队友]加入'},
		{'【正线】丐帮（中原）*与看门弟子对话，触发战斗：*VS 丐帮打狗阵，胜后获得【莲花功】（此战可以提前来打），进入丐帮触发剧情，慕容复揭发乔峰身世，乔峰离开丐帮*ps:此时会提示是否体验翔实剧情，选择『否』则进入简易线，剧情跳至第七步：与丐帮弟子对话开启少林大战',5,'奖励：*莲花功[内功秘籍]'},
		{'【正线】天台山（中原）*点击调查智光大师的尸体，冲霄洞（西部）点击调查赵钱孙、谭公谭婆的尸体*需要海叟钓法需在丐帮剧情前来冲宵洞。',6,'奖励：'},
		{'【正线】洛阳城（中原）*进入洛阳城商店接到聚贤庄的英雄贴。',7,'奖励：'},
		{'【正线】聚贤庄（中原）*与乔峰一起对战天下群雄（其实就是一群喽罗）：*1、VS 游氏双雄 *2、VS 游氏双雄+薛慕华 *3、VS 游氏双雄+薛慕华+丐帮弟子 *4、VS 游氏双雄+薛慕华+各派弟子 *5、VS 游氏双雄+薛慕华+各派弟子。*五连战后主角被乔峰打出聚贤庄。',8,'奖励：*道德+5'},
		{'【正线】聚贤庄（中原）*聚贤庄与阿朱对话。*若身上有[七宝指环]可收薛慕华入队',9,'奖励：薛慕华入队【队友】（需要有七宝指环）'},
		{'【正线】丐帮（中原）*与看门弟子对话，得知新帮主去了少林',10,'奖励：*道德+5（简易线）'},
		{'【正线】少室山下（中原）*右上树下对话乔峰 获得【擒龙手】',11,'奖励：*擒龙手[指法秘籍]'},
		{'【正线】少室山下（中原）*由少室山下进入少林寺，剧情后触发战斗：*1、VS 游坦之 *2、VS 慕容复 *3、VS 游坦之+慕容复 *4、VS 游坦之+慕容复+鸠摩智，得【无相劫指法】 *5、VS 游坦之+慕容复+鸠摩智+慕容博+四大恶人+丐帮弟子 *剧情之后，乔峰给予【降龙十八掌】《天龙八部》',12,'奖励：*道德+3 *无相劫指[指法秘籍] *天龙八部[十四天书之一] *降龙十八掌[拳掌秘籍]'},
		{'【正线】少林寺（中原）*与段誉、王语嫣对话，剧情后段誉、王语嫣离开，*无量山（西部）进入无量山洞，与段誉、王语嫣对话，可邀请2人入队，回小村可收王语嫣、段誉入队',13,'奖励：*道德+2 *段誉[队友]加入 *王语嫣[队友]加入'},
		{'已完成全部剧情',14,'奖励：'},
		{'【邪线】丐帮（中原） *与看门弟子对话，触发战斗：*VS 丐帮打狗阵，胜后获得【莲花功】（此战可提前来打） *进入丐帮剧情后触发战斗（慕容复、王语嫣需在队伍）：*VS 丐帮打狗阵，胜利后获得【逍遥游】',15,'奖励：*莲花功[内功秘籍] *道德-5 *逍遥游[轻功秘籍]'},
		{'【邪线】聚贤庄（中原）*剧情后触发战斗：*VS 萧远山，胜利后获得【拈花指法】，若身上有[七宝指环]可收薛慕华入队',16,'奖励：*道德-3 *拈花指法[指法秘籍]'},
		{'【邪线】丐帮（中原）*进入丐帮触发剧情，剧情后*主角VS游坦之，战斗胜利后，获得【冰蚕毒掌】【神足经】，明王送【无相劫指法】，与阿紫对话，回小村可收游坦之和阿紫入队',17,'奖励：*道德-3 *冰蚕毒掌[拳掌秘籍] *神足经[内功秘籍] *无相劫指法[指法秘籍] *阿紫[队友]加入 *游坦之[队友]加入'},
		{'【邪线】少室山下-少林寺*进入少林寺(慕容复、游坦之、王语嫣必须在队)，乔峰抗着音响出场，剧情后触发战斗 *1、VS 乔峰 *2、VS 乔峰+段誉 *3、VS 乔峰+段誉+虚竹+萧远山 *战斗结束后鸠摩智送【火焰刀法】，获得《天龙八部》',16,'奖励：*道德-8 *主角五系兵器值+10 *天龙八部[十四天书之一] *火焰刀法[刀法秘籍] *天狼爪[武器]'},

	}
	--射雕英雄传
	local She = {
		{'蒙古包（北部）*与郭靖对话，收郭靖入队',0,'奖励：*郭靖[队友] 加入'},
		{'北京（北部）*郭靖在队时，与客栈门口的黄蓉对话，触发剧情，正邪分支*选『是』进入正线，触发战斗：*VS欧阳克*胜后，郭靖离队，获得【奇门五转】【兰花拂穴手】',1,'奖励：*正线*道德+2*奇门五转[内功秘籍]*兰花拂穴手[指法秘籍] *邪线*道德-2*透骨打穴[指法秘籍]'},
		{'【正线】洪七公居（中原）*进入场景触发剧情',2,'奖励：'},
		{'【正线】桃花岛（海外）*进入场景触发剧情，欧阳克、郭靖与主角比试：*1、VS 欧阳克（可败）*2、VS 郭靖（可败）*剧情后，众人离开，获得【落英神剑掌】【旋风扫叶腿】【灵鳖步】*剧情后记得去看下左上房间墙壁上的对联',3,'奖励：*神雕侠侣绝情谷剧情开启 *千年灵芝[丹药] 胜郭靖奖励 *落英神剑掌[拳掌秘籍] *旋风扫叶腿[指法秘籍]'},
		{'【正线】明霞岛（海外）*进入场景，剧情后触发战斗：*VS 欧阳锋',4,'奖励：*道德+1'},
		{'【正线】嘉兴-牛家村（江南）*进入小屋剧情后触发战斗：*1、VS 欧阳克 *2、VS 欧阳锋（可败）胜利后获得【蛤蟆功】 *3、VS 欧阳锋（可败）胜利后获得天山雪莲x2 *4、VS 欧阳锋,战斗结束剧情后获得【弹指神通】 ',5,'奖励：*道德+4 *张旭率意帖[剧情道具]剧情后开宝箱获得 *蛤蟆功法[内功秘籍] *天山雪莲[丹药]*2 *弹指神通[指法秘籍] *程英：第二格武功洗弹指神通1级 第三格武功洗落英神剑掌1级'},
		{'【正线】铁掌峰（江南）*剧情后触发战斗：*VS 裘千仞+铁掌帮众',6,'奖励：*道德+1'},
		{'【正线】一灯居（江南）*渔：给他[金娃娃](开局搜刮)可通过，道德+1,否则可以选择与其交手杀过去，道德-1*耕：西部农村选择教过小孩武功后并且不收银子可通过，道德+1,否则可以选择与其交手杀过去，道德-1*樵，道德≥75，攻击≥100直接通过，道德+1,否则可以选择与其交手杀过去，道德-1*读，桃花岛看过对联，可以通过，道德+1,奖励主角：拳指剑刀特五系兵器值可选其中一项+10,否则可以选择与其交手杀过去，道德-1,',7,'奖励：*五系兵器值任选其一+10点'},
		{'【正线】一灯居（江南）*进入房间，剧情后触发战斗：*VS 欧阳锋+裘千仞*胜后，一灯送主角【先天功秘籍】【一阳指法】',8,'奖励：*道德+8 *先天功秘籍[内功秘籍] *一阳指法[指法秘籍]'},
		{'【正线】洪七公居（中原）*与洪七公对话，得知天书在重阳宫',9,'奖励：'},
		{'【正线】重阳宫（中原）*与丘处机对话，触发剧情，欧阳锋出现：*VS 欧阳锋+裘千仞+蛇群*获得【瞬息千里】*战斗胜利后，王重阳出现吓跑欧阳锋',10,'奖励：*道德+8 *瞬息千里[轻功秘籍]'},
		{'【正线】重阳宫（中原）*与王重阳对话，选『是』：*主角VS王重阳（可败，可重复挑战）*胜后获得《射雕英雄传》',11,'奖励：*射雕英雄传[十四天书之一]'},
		{'【邪线】洪七公居（中原）*进入场景触发剧情后战斗：*VS 洪七公（可败）',12,'奖励：*胜洪七公奖励：五系兵器值任选其一+10点*瞬息千里[轻功秘籍]'},
		{'【邪线】桃花岛（海外）*进入场景触发剧情，欧阳克、郭靖与主角比试：*1、VS 欧阳克（可败）*2、VS 郭靖（可败）*剧情后，众人离开，获得【落英神剑掌】【旋风扫叶腿】*剧情后记得去看下左上房间墙壁上的对联',13,'奖励：*神雕侠侣绝情谷剧情开启*千年灵芝[丹药] 胜郭靖奖励*落英神剑掌[拳掌秘籍]*旋风扫叶腿[指法秘籍]'},
		{'【邪线】明霞岛（海外）*对话欧阳锋，剧情后，获得【白驼雪山掌】【蛤蟆功】',14,'奖励：*道德-1*白驼雪山掌[拳掌秘籍]*蛤蟆功[内功秘籍]'},
		{'【邪线】嘉兴-牛家村（江南）*剧情后触发战斗：*VS 欧阳克',16,'奖励：*道德-3 *张旭率意帖[剧情道具]剧情后开宝箱获得'},
		{'【邪线】铁掌峰（江南）*VS 看门喽啰 *进屋与裘千仞对话，获得【铁掌掌谱】',17,'奖励：*铁掌掌谱[拳掌秘籍]'},
		{'【邪线】一灯居（江南）*渔：给他[金娃娃](开局搜刮)可通过，道德+1/否则战斗，道德-1*耕：西部农村选择教过小孩武功后并且不收银子可通过，道德+1/否则战斗，道德-1*樵，道德≥75，攻击≥100直接通过，道德+1/否则战斗，道德-1*读，桃花岛看过对联，可以通过，道德+1/否则战斗，道德-1',18,'奖励：*读奖励*奖励主角：拳指剑刀特五系兵器值可选其中一项+10'},
		{'【邪线】一灯居（江南）*进入房间，剧情后触发战斗：*VS 一灯+渔樵耕读*胜后，获得[软猬甲]【一阳指法】',19,'奖励：*道德-10 *一阳指法[指法秘籍] *妙笔丹青[奇门秘籍]（朱子柳身上偷取） *软猬甲[防具]'},
		{'【邪线】重阳宫（中原）*与丘处机洪七公等人对话，触发战斗：*1、VS 全真七子+全真教徒 *2、VS 周伯通+全真七子+全真教徒 *3、VS 周伯通+东邪+北丐+全真七子+全真教徒 *第4战前出现是否化干戈为玉帛选项 *化干戈为玉帛：4、VS 王重阳+林朝英*不化干戈为玉帛：4、VS 王重阳+林朝英+周伯通+东邪+北丐+全真七子+全真教徒',20,'奖励：*道德-3*化干戈为玉帛：道德+3 《射雕英雄传》十四天书之一 九阴真经上卷[剧情道具] *不化干戈为玉帛：《射雕英雄传》十四天书之一 九阴真经上卷[剧情道具] 蛇行狸翻[轻功秘籍]'},
	}
	--白马啸西风
	local Bai = {
		{'破庙（北部）*触发剧情正邪选择，确定挺身而出选择正线触发战斗：VS 陈达海+铁掌帮众胜利后李文秀入队得[白马]、[手帕]、[黑血神针]x3,',0,'奖励：*道德+2 *手帕[剧情道具] *白马[坐骑] *[黑血神针]x3[暗器] *李文秀[队友]入队'},
		{'沙漠废墟（北部）*剧情后触发战斗：*VS 瓦尔拉齐+一群喽啰',2,'奖励：'},
		{'沙漠废墟（北部）*点击废墟内的柜子，开启密道进入高昌迷宫,',3,'奖励：道德+1'},
		{'沙漠废墟（北部）*身上有[玄铁剑]、[屠龙刀]、[倚天剑]三把兵器之一即可劈开石门,',4,'奖励：道德+1'},
		{'沙漠废墟（北部）*点击废墟内的柜子，开启密道进入高昌迷宫迷宫内开宝箱获得：*《白马啸西风》、[天山雪莲]、银两*1000、【玄虚刀法】',5,'奖励：*白马啸西风[十四天书之一] *天山雪莲[丹药] *银两*1000 *玄虚刀法[刀法秘籍]'},

	}
	--鹿鼎记
	local Lu = {
		{'扬州-天上人间（江南）*扬州天上人间寻找韦小宝，韦小宝入队，获得【一指禅】',0,'奖励：*韦小宝[队友] *一指禅[指法秘籍]'},
		{'沧州-有间客栈（北部）*韦小宝在队，触发剧情后进入战斗：*VS 海大富 （可败），胜利后获得【化骨绵掌】',1,'奖励：*化骨绵掌[拳掌秘籍]'},
		{'北京（北部）*左边房间进门触发剧情，进入战斗：*VS 大内高手',2,'奖励：'},
		{'北京（北部）*客栈对话钱老板，花500两购得[茯苓花雕猪]',3,'奖励：*茯苓花雕猪[剧情道具]'},
		{'北京（北部）*对禁卫使用[茯苓花雕猪]，进入皇宫',4,'奖励：'},
		{'北京（北部）-皇宫*皇宫右上房间，进门触发剧情，进入战斗：*VS 鳌拜（可败）剧情后获得[皇宫通行令]*对战鳌拜如果失败将无法进入秘道抄家，但不影响拿天书',5,'奖励：*皇宫通行令[剧情道具]'},
		{'台湾（海外）*韦小宝在队，进门触发剧情，进入战斗：*VS 冯锡范+阿珂+郑克爽，剧情后得[半部四十二章经]【凝血神爪】',6,'奖励：*半部四十二章经[剧情道具] *凝血神爪[指法秘籍]'},
		{'神龙教（海外）*与看门小兵对话触发战斗：*VS 神龙教徒，进入屋内触发战斗：*VS 洪教主+苏荃+神龙教众，胜后，韦小宝离队，获得[四十二章经]',7,'奖励：*四十二章经[剧情道具]'},
		{'小村（江南）*到北丑房间里的蜡烛处使用[四十二章经]，鹿鼎山开启',8,'奖励：'},
		{'鹿鼎山（北部）*山洞战斗*VS一大群大雪怪，开启宝箱获得：银两*1000、千年灵芝、【百胜刀法】《鹿鼎记》',9,'奖励：*银两*1000 *千年灵芝[丹药] *百胜刀法[刀法秘籍] *鹿鼎记[十四天书之一]'},
	}
	--笑傲江湖
	local Xiao = {
		{'福州（江南））*福州客栈结识林平之和令狐冲,剧情后触发战斗：VS 青城弟子x3',0,'奖励：道德+1'},
		{'福州（江南））*进入福威镖局，与镖师对话',1,'奖励：'},
		{'衡阳（江南）*进入客栈内，剧情后触发战斗：VS 青城弟子x4,胜利后剧情，获得【太岳三青峰】【华山心法】',2,'奖励：*道德+1 *华山心法[内功秘籍] *太岳三青峰[剑法秘籍]'},
		{'华山下-华山派（中原）*与岳灵珊对话，得知令狐冲在思过崖',3,'奖励：'},
		{'华山下-华山派（中原）*进入上方的思过崖，剧情后，令狐冲第一格武功洗为独孤九剑八级、攻击+50，与令狐冲对话选『是』与其挑战：*主角VS令狐冲（可败），战斗后会触发成不忧来华山捣乱事件，*此时可选是否体验完整剧情，选『否』则转到第七步：少室山下2',4,'奖励：*令狐冲奖励：攻击+50*第一格武功洗为 独孤九剑 八级'},
		{'华山下-华山派（中原）*华山派大堂触发剧情战斗：*令狐冲 VS 成不忧（观战模式），战斗后桃谷六仙捉住令狐冲往思过崖方向去了',5,'奖励：'},
		{'华山下-华山派（中原）*进入思过崖，剧情后，触发战斗：*VS 桃谷六仙，战斗结束后，与令狐冲对话可收其入队',6,'奖励：*道德+1 *令狐冲[队友] *令狐冲：生命上限-200 内力上限-200 轻功-50'},
		{'华山下-华山派（中原）*华山派，与陆大有对话，获得【紫霞秘籍】',7,'奖励：*紫霞秘籍[内功秘籍]'},
		{'药王庙（中原）*进入场景，剧情后触发战斗：*VS 封不平+嵩山弟子，剧情后令狐冲离队',8,'奖励：*狂风快剑[剑法秘籍]'},
		{'洛阳城（中原）*金刀门剧情后，去绿竹巷剧情后，与令狐冲对话',9,'奖励：'},
		{'洛阳城（中原）*洛阳绿竹巷剧情后，与令狐冲对话',10,'奖励：'},
		{'洛阳城（中原）*出洛阳城后，再次进入，与令狐冲对话，剧情后令狐冲加入，获得【持瑶琴】',11,'奖励：*持瑶琴[奇门秘籍] *令狐冲[队友]'},
		{'开封-平一指居（中原）*令狐冲在队与平一指对话，之后可去小村收平一指入队',12,'奖励：*子午针灸经[医书] *平一指[队友]'},
		{'少室山下（中原）*令狐冲在队时，进入场景触发剧情，令狐冲离队',13,'奖励：'},
		{'少室山下（中原）*出少室山后，再次进入，与令狐冲对话，剧情后触发战斗：*VS 大批武林人士，战斗胜利后剧情，与令狐冲对话，收令狐冲入队',14,'奖励：*令狐冲[队友]加入 *道德+1（简易线）*紫霞秘籍[内功秘籍]（简易线）*持瑶琴[奇门秘籍]（简易线）'},
		{'杭州-梅庄（江南）*令狐冲在队时，对丹青生使用[溪山旅行图]，触发战斗：*VS 丹青生',15,'奖励：*梨花酒[丹药] 丹青生旁边的酒坛'},
		{'杭州-梅庄（江南）*令狐冲在队时，对秃笔翁使用[张旭率意帖]，触发战斗：*VS秃笔翁',16,'奖励：*裴将军帖[奇门秘籍]'},
		{'杭州-梅庄（江南）*令狐冲在队时，对黑白子使用[刘仲甫呕血棋谱]，触发战斗*VS 黑白子，获得【玄天指】',17,'奖励：*玄天指[指法秘籍]'},
		{'杭州-梅庄（江南）*令狐冲在队时，对黄钟公使用[广陵散琴曲]，触发战斗：*VS 黄钟公',18,'奖励：'},
		{'杭州-梅庄（江南）*令狐冲在队时与黑白子对话，剧情后开启梅庄地牢',19,'奖励：'},
		{'杭州-梅庄（江南）*进入梅庄地牢，与任我行对话，剧情后触发战斗：*VS 任我行（可败），获得【吸星大法】',20,'奖励：*吸星大法[内功秘籍] *主角奖励：(胜任我行) 防御+10、轻功+10 *令狐冲奖励：第二格武功洗吸星大法8级'},
		{'杭州-梅庄（江南）*从地牢出来，剧情后触发战斗：*VS 梅庄四友，战斗后，令狐冲离队',21,'奖励：'},
		{'福州-福威镖局（江南）*进入中间房间触发剧情，正邪分支*选择『是』相信令狐冲，令狐冲加入*选择『否』进入邪线',22,'奖励：*正线:令狐冲[队友]加入 令狐冲奖励：轻功+40 内力硬上限恢复正常'},
		{'【正线】衡阳（江南）*令狐冲在队，进入客栈见莫大触发剧情',23,'奖励：'},
		{'【正线】少室山下-少林寺（中原）*令狐冲在队，与玄慈对话，触发战斗：*VS 方证+岳不群+左冷禅+慧聪+玄慈+空闻+空性+定闲+天门+莫大+少林弟子,胜得【大嵩阳掌】',24,'奖励：*大嵩阳掌【拳掌秘籍】'},--新增武功大嵩阳掌出处
		{'【正线】衡阳（江南）*令狐冲在队，进入客栈见莫大触发剧情',23,'奖励：'},
		{'【正线】衡阳（江南）*令狐冲在队，进入客栈见莫大触发剧情',23,'奖励：'},
		{'【正线】衡阳（江南）*令狐冲在队，进入客栈见莫大触发剧情',23,'奖励：'},
	}
	--书剑恩仇录
	local Shu = {
		{'凤阳城民居结识陈家洛',0,'奖励：道德+1'},
		{'后续还未完成，请等待更新',1,'奖励：道德+1'},
		{'后续还未完成，请等待更新',2,'奖励：道德+1'},
		{'后续还未完成，请等待更新',3,'奖励：道德+1'},
		{'后续还未完成，请等待更新',4,'奖励：道德+1'},
	}
	--神雕侠侣
	local Shen = {
		{'古墓派寻找小龙女',0,'奖励：道德+1'},
		{'后续还未完成，请等待更新',1,'奖励：道德+1'},
		{'后续还未完成，请等待更新',2,'奖励：道德+1'},
		{'后续还未完成，请等待更新',3,'奖励：道德+1'},
		{'后续还未完成，请等待更新',4,'奖励：道德+1'},
	}
	--侠客行
	local Xia = {
		{'龙门客栈寻找丁当对话',0,'奖励：道德+1'},
		{'后续还未完成，请等待更新',1,'奖励：道德+1'},
		{'后续还未完成，请等待更新',2,'奖励：道德+1'},
		{'后续还未完成，请等待更新',3,'奖励：道德+1'},
		{'后续还未完成，请等待更新',4,'奖励：道德+1'},
	}
	--倚三屠龙记
	local Yi = {
		{'朱府与张无忌和朱九真对话',0,'奖励：道德+1'},
		{'后续还未完成，请等待更新',1,'奖励：道德+1'},
		{'后续还未完成，请等待更新',2,'奖励：道德+1'},
		{'后续还未完成，请等待更新',3,'奖励：道德+1'},
		{'后续还未完成，请等待更新',4,'奖励：道德+1'},
	}
	--碧血剑
	local Bi = {
		{'大理与温青青对话',0,'奖励：道德+1'},
		{'后续还未完成，请等待更新',1,'奖励：道德+1'},
		{'后续还未完成，请等待更新',2,'奖励：道德+1'},
		{'后续还未完成，请等待更新',3,'奖励：道德+1'},
		{'后续还未完成，请等待更新',4,'奖励：道德+1'},
	}
	--鸳鸯刀
	local Yuan = {
		{'游历乌鞘岭',0,'奖励：道德+1'},
		{'后续还未完成，请等待更新',1,'奖励：道德+1'},
		{'后续还未完成，请等待更新',2,'奖励：道德+1'},
		{'后续还未完成，请等待更新',3,'奖励：道德+1'},
		{'后续还未完成，请等待更新',4,'奖励：道德+1'},
	}

	--小和尚历险记
	local xiaoyao = {
		{'天龙八部','小和尚历险记','龙门客栈（西部）在进入天龙邪线之前，道德≥75时，与虚竹对话，收虚竹入队，*直接带虚竹去少林寺，虚竹会永久离队，道德+10，获得【少林九阳功】*虚竹可随意修炼，邪线少林寺大战时的虚竹为固定属性和武功',0,'奖励：*虚竹[队友] 加入'},
		{'天龙八部','小和尚历险记','擂鼓山（中原）虚竹在队，与苏星河对话，剧情后无崖子传功虚竹',1,'奖励：'},
		{'天龙八部','小和尚历险记','擂鼓山（中原）虚竹对话，虚竹入队',2,'奖励：*天山六阳掌[拳掌秘籍]*小无相功[内功秘籍] *棋盘招式[奇门秘籍] *虚竹[队友]加入 *虚竹奖励：*资质+10，属性提高*第一格武功洗天山六阳掌4级*第二格武功洗小无相功4级*天赋增加：自带北冥真气增加800气防'},
		{'天龙八部','小和尚历险记','星宿海（西部）虚竹在队伍，触发战斗：*VS丁春秋+星宿门人胜后得【化功大法】【神木王鼎】【连环腐尸毒】',3,'奖励：*道德+5 *化功大法[内功秘籍] *连环腐尸毒[指法秘籍] *神木王鼎[剧情道具]'},
		{'天龙八部','小和尚历险记','擂鼓山（中原）与苏星河对话获得【七宝指环】',4,'奖励：*七宝指环[武器]'},
		{'天龙八部','小和尚历险记','恒山-恒山山麓（中原）进入场景，触发战斗：*VS 卓不凡等人，胜后得知天山童姥在西夏皇宫，虚竹离队',5,'奖励：'},
		{'天龙八部','小和尚历险记','凉州-西夏皇宫（北部）从凉州进入西夏皇宫，进入左侧房间触发战斗：*主角+虚竹VS李秋水，胜利后进入西夏皇宫右上角房间对话李清露，收李清露入队',6,'奖励：李清露[队友]加入*寒袖指穴[指法秘籍]*白虹掌力[拳掌秘籍]'},
		{'天龙八部','小和尚历险记','灵鹫宫（北部）李清露在队，进入场景触发战斗：*VS 卓不凡，胜后获得【剑华皈壹】【周公剑法】，虚竹加入获得【七宝指环】',7,'奖励：*剑华皈壹[内功秘籍] *周公剑法[剑法秘籍]*七宝指环[武器]*虚竹[队友]加入'},
		{'天龙八部','小和尚历险记','灵鹫宫（北部）进入灵鹫宫，练功房观看最后一张壁画，获得【八荒六合功】，右下房间调查书架可获得【天山折梅手】*不想虚竹洗武功、加资质可以把虚竹踢出队伍',8,'奖励：*山折梅手[拳掌秘籍]*八荒六合功[内功秘籍]*虚竹奖励：*资质+10 第三格武功八荒六合功1级（获得八荒时）*第五格武功洗天山折梅手1级，天山折梅手修炼到极后资质变为50（获得天山折梅手时）'},
		{'天龙八部','小和尚历险记','灵鹫宫（北部）学会【八荒六合功】 【北冥神功】【小无相功】灵鹫宫中间房子进去对雕像空格触发对战无崖子解锁【逍遥御风】',9,'奖励：*解锁秘技【逍遥御风】'},
	}

	--支线剧情
	local zhixian = {
		{'天龙八部','小和尚历险记','龙门客栈（西部）*在进入天龙邪线之前，道德≥75时，与虚竹对话，收虚竹入队，*直接带虚竹去少林寺，虚竹会永久离队，道德+10，获得【少林九阳功】*虚竹可随意修炼，邪线少林寺大战时的虚竹为固定属性和武功',0,'奖励：*虚竹[队友] 加入'},
		{'天龙八部','六脉神剑','大理-天龙寺（西部）*获得【天龙八部】后不带段誉，左上房间调查书架，触发战斗VS 段思平+枯荣挑战胜利可获得【六脉神剑】【地灵丹】【千年灵芝】挑战失败只可获得【六脉神剑】',0,'奖励：*六脉神剑[指法秘籍] *地灵丹[丹药]需挑战胜利 *千年灵芝[丹药]需挑战胜利 *段思平奖励：第一格武功洗六脉神剑一级需挑战胜利'},
		{'天龙八部','黑级浮屠','苏州-燕子坞（江南）天龙正线*（江南）带段誉和虚竹进屋触发战斗VS 慕容复（黑级浮屠）战胜后阿朱回小村',0,'奖励：*阿朱[队友] 加入'},
		{'天龙八部','扫地的考验','少室山下-少林寺（中原）天龙正线*拿到天书后与扫地僧对话，触发战斗*VS 扫地僧+玄慈+空闻+空性+少林弟子（此战可败）*畅想乔峰战胜后获得专属装备[音箱]',0,'奖励：*主角五系兵器值+10 *音箱[武器]（畅想乔峰专属）'},
		{'天龙八部','一苇渡江','少室山下-少林寺（中原）*与扫地僧对话，扫地左边书架空格触发战斗*VS 扫地僧',0,'奖励：*一苇渡江[轻功秘籍]'},
		{'天龙八部','易筋经','少室山下-少林寺（中原）*拿到一苇渡江，扫地右边书架空格触发战斗*VS 达摩（达摩50%血或撑过300时序即可）',0,'奖励：*易筋经[内功秘籍]'},
		{'天龙八部','慕容绝学','苏州-燕子坞（江南）*慕容复在队，去左下角房间书架上调查可获得【参合指法】【参合剑气】（身上有6000两才会触发开门剧情,开门剧情在第一次来燕子坞就可以触发，对话李青萝可以用残章换已获得的秘籍）',0,'奖励：*易筋经[内功秘籍]'},
		{'天龙八部','不老长春','长春不老谷（西部）*先去天龙寺对话左上房间僧人，得到“长春不老谷”的信息，持有七宝指，调查墓碑，逍遥子出现，VS 逍遥子（坚持2000时序亦可获胜）战胜后获得秘籍【不老长春功】【阳春白雪曲】',0,'奖励：*不老长春功[内功秘籍]*阳春白雪曲[奇门秘籍]'},
		{'天龙八部','北冥神功','【邪线】大理-天龙寺（西部）*进入天龙寺慕容复（需领悟黑级浮屠）在队，触发剧情，*VS 乔峰+段誉+虚竹+天龙寺众僧*战斗结束获得【北冥神功】，千年灵芝，地灵丹',0,'奖励：*道德-10 *北冥神功[内功秘籍] *地灵丹[丹药] *千年灵芝[丹药]'},
		{'天龙八部','凌婆微步','无量山-无量山洞（西部）*无量山洞见段誉后，山洞里点击雕像，剧情后触发战斗：*VS 逍遥三老（无崖子+天山童姥+李秋水）胜后获得【凌波微步】',0,'奖励：*凌波微步[轻功秘籍]*王语嫣奖励：天赋轻功洗为凌波微步'},
		{'射雕英雄传','南帝北丐','华山下-华山后山（中原）*拿到《射雕英雄传》后，华山后山旁的阶梯上去，一直往右，走过石碑，进入华山绝顶，触发剧情进入战斗：*VS 洪七公+欧阳锋，战后出现分支：*选择帮北丐则 VS 欧阳锋，胜利后得[打狗棒]、【打狗棒法】*选择帮西毒则 VS 洪七公，胜利后得[西毒蛇杖]、【灵蛇杖法】',0,'奖励：*道德+2*帮助北丐：打狗棒[武器] 打狗棒法[奇门秘籍]*帮助西毒：西毒蛇杖[武器] 灵蛇杖法[奇门秘籍]'},
		{'射雕英雄传','重阳赠礼','【正线】重阳宫（中原）*拿到【射雕英雄传】道德≥90时与丘处机对话，王重阳送【先天功秘籍】，道德≥99时与丘处机对话，王重阳送[九阴真经上卷]【蛇行狸翻】',0,'奖励：*先天功秘籍[内功秘籍] *九阴真经上卷[剧情道具] *蛇行狸翻[轻功秘籍]'},
		{'射雕英雄传','妙笔丹青','【正线】一灯居（江南）*与读对话猜谜，若程英在队伍，再次与其对话即可解谜',0,'奖励：*妙笔丹青[奇门秘籍]'},	
		{'射雕英雄传','侠之大者','【正线】桃花岛（海外）*道德≥80，与郭靖、黄蓉对话，回小村后可收郭靖、黄蓉入队',0,'奖励：*道德+1 *汗血宝马[坐骑] *软猬甲[防具]收黄蓉获得 *郭靖[队友]加入（可选内属）*黄蓉[队友]加入'},
		{'射雕英雄传','黑风双煞','【邪线】云岭洞（中原）*与梅超风对话，选『是』收其入队,*蒙古包（北部）*与柯镇恶对话，选择 『是』 与其交手*VS 江南七怪，*胜后获得 [汗血宝马]【九阴白骨爪】',0,'奖励：*梅超风[队友]*九阴白骨爪[指腿秘籍]*汗血宝马[坐骑]'},
		{'射雕英雄传','逆运真经','【邪线】嘉兴-牛家村（江南）*一灯居战斗过后，与欧阳锋对话，选『是』获得【逆运真经】',0,'奖励：*道德-1 *逆运真经[内功秘籍] *杨过福利：第三格洗逆运真经，天赋内功洗逆运真经'},
		{'鹿鼎记','齐人之福','扬州-天上人间（江南）*与韦小宝对话，可收韦小宝、阿珂、苏荃入队',0,'奖励：*韦小宝[队友] 加入 *阿珂[队友] 加入 *苏荃[队友] 加入'},--标记从此处未写
		{'鹿鼎记','鳌拜宝库','皇宫打赢鳌拜，北京（北部）*左上鳌拜府，对话椅子背后的柜子，发现秘道，秘室宝箱：*[银两]*5000 [火枪] [金丝背心]【金刚不坏体】【神行百变】',6,'奖励：*银两*5000 *金丝背心[防具] *金刚不坏体[内功秘籍] *火枪[武器] *神行百变[轻功秘籍] *韦小宝奖励：*第一格武功洗火枪极 第二格武功洗神行百变1级 *天赋外功洗为火枪 天赋轻功洗为神行百变'},
		{'笑傲江湖','蓝色凤凰','五毒教（西部）*获得笑傲天书之前，任盈盈在队时，与蓝凤凰对话，可收蓝凤凰入队',0,'奖励：*黄沙万里鞭[奇门秘籍] *蓝凤凰[队友] *令狐冲奖励：生命上限+100'},
		{'鸳鸯刀','支线一','少室山下-少林寺（中原）拿到一苇渡江，扫地右边书架空格触发战斗*VS 达摩（达摩50%血或撑过300时序即可）',0,'奖励：*易筋经[内功秘籍]'},
		{'鸳鸯刀','支线一','少室山下-少林寺（中原）拿到一苇渡江，扫地右边书架空格触发战斗*VS 达摩（达摩50%血或撑过300时序即可）',0,'奖励：*易筋经[内功秘籍]'},
		{'飞狐外传','男儿当自强','佛山（江南）客栈对话黄飞鸿，战斗：*VS黄飞鸿，胜利得【无影脚】',0,'奖励：*无影脚[指腿秘籍]'},
	}
	local Kend = '已完成全部剧情'
	local TS = {Fei,Xue,Lian,Tian,She,Bai,Lu,Xiao,Shu,Shen,Xia,Yi,Bi,Yuan}
	local tb = 1
	--lib.Background(bx*100,by*40,)
	local pw,ph = lib.GetPNGXY(91,506*2)

	local px,py = -1,-1
	local tsname = ''
	local line = 1
	local JUQING = {'天书剧情','支线剧情'}
	local tob = 1
	local cl = C_WHITE1
	local tb1 = 0
	local jnum = 0
	local lb = 0
	while true do 
		if JY.Restart == 1 then
			break
		end
		Cls()
		local zmenu = {}		
		lib.LoadPNG(91,506*2,CC.ScreenW/2-pw/2,CC.ScreenH/2-ph/2,1,0,CC.ScreenW/1360*100)
		lib.LoadPNG(91,539*2,CC.ScreenW/3-bx*70,CC.ScreenH/2-ph/2+by*50,1,0,CC.ScreenW/1360*100)
		local title = '剧情任务'
		DrawString(CC.ScreenW/2-string.len(title)/4*size*1.3,CC.ScreenH/2-ph/2+size/2,'剧情任务',M_DarkOrange,size*1.3,CC.FONT2)	
		local start = 0
		for i = 1,#zhixian do 
			if zhixian[i][1] == TSmenu[tb] then 
				zmenu[#zmenu+1] = zhixian[i]
			end
		end
		local jmax = #TSmenu-(#zmenu or 0)

		if tb > 5 and #zmenu + tb > 14 then 
			start = #zmenu
			jmax = #TSmenu
		elseif #zmenu + tb > 14 then 			
			start = tb - 1
			jmax = tb
		end 
		if tob == 1 then 
			local fx = bx*480
			for i = 1+start,jmax do 
				local cl = C_WHITE1	
				if tb == i then 
					cl = C_RED	
				end
				DrawString(bx*200,by*70+(line)*size*1.3,TSmenu[i],cl,size)		
				line = line + 1		
				if tb == i then 			
					for j = 1,#zmenu do 
						local cl = C_BLUE											
						if tb1 == j then 
							cl = C_ORANGE
						end
						DrawString(bx*230,by*70+(line)*size*1.3,zmenu[j][2],cl,size*0.9)
						line = line + 1
					end				
				end							
			end
			line = 0		
			if tb1 == 0 then 
				local maxh = 0
				tsname = string.sub(TSmenu[tb],1,2)
				local th = 0
				local num = TS[tb][CC.TX[tsname]+1]
				local num1 = num[2] + 1
				local num2 = num1..'.'
				local jq = num[1]
				local jl = num[3]
				if CC.TX[tsname] == 99 then
					jq = '已完成全部剧情' 
					jl = ''
					num2 = ''
				end
				th = tjm(bx*420,by*70+maxh*size*1.2,num2,cl,size*0.75,23,size,nil,nil,CC.FONT5)
				th = tjm(fx,by*70+maxh*size*1.2,jq,cl,size*0.75,27,size,nil,nil,CC.FONT5)
				maxh = maxh + th
				if maxh > 10 then 
					maxh = maxh - 1
				end
				if maxh < 10 then 
					maxh = maxh + 1
				end		
				if jl ~= nil then 
					th = tjm(fx,by*70+maxh*size*1.2,jl,cl,size*0.75,27,size,nil,nil,CC.FONT5)
					maxh = maxh + th
				end
			else
				local maxh = 0
				local th = 0
				if #zmenu > 0 then 
					local jq = zmenu[tb1][3]
					local jl = zmenu[tb1][5]
					local jqnum = zmenu[tb1][2]
					local num1 = 1
					local num = num1..'.'
					if CC.TX[jqnum] == 100 then
						jq = '已完成全部剧情' 
						jl = ''
						num = ''
					else 
						if tb == 4 and tb1 == 1 then 
							jq = xiaoyao[CC.TX[jqnum]+1][3]
							jl = xiaoyao[CC.TX[jqnum]+1][5]
							num1 = CC.TX[jqnum] + 1
							num = num1..'.'
						end
					end
					th = tjm(bx*420,by*70+maxh*size*1.2,num,cl,size*0.75,23,size,nil,nil,CC.FONT5)
					th = tjm(fx,by*70+maxh*size*1.2,jq,cl,size*0.75,27,size,nil,nil,CC.FONT5)
					maxh = maxh + th
					if maxh > 10 then 
						maxh = maxh - 1
					end
					if maxh < 10 then 
						maxh = maxh + 1
					end						
					if jl ~= nil then 						
						th = tjm(fx,by*70+maxh*size*1.2,jl,cl,size*0.75,27,size,nil,nil,CC.FONT5)
						maxh = maxh + th
					end
				end
			end
		elseif tob == 2 then 
		end

		ShowScreen()
		lib.Delay(CC.BattleDelay)
		local key, ktype, mx, my = lib.GetKey();
		if mx ~= -1 and my ~= -1 then 
			px,py = mx,my
		end	
		if key == VK_ESCAPE or ktype == 4 then 
			if tb1 > 0 then 
				tb1 = 0 
			else
				break
			end
		elseif key == VK_RETURN or key == VK_SPACE then 
			if #zmenu > 0 then 
				if tb1 == 0 then 
					tb1 = 1
				end
			end
		elseif key == VK_DOWN or ktype == 7 then			
			if  #zmenu > 0 and tb1 > 0 then 
				lb = 1
				tb1 = tb1 + 1
				if tb1 > #zmenu then 	
					tb1 = 0			
					tb = tb + 1
					if tb > #TSmenu then 
						tb = 1
					end
				end
			else				
				tb = tb + 1
				if tb > #TSmenu then 
					tb = 1
				end
			end			
		elseif key == VK_UP or ktype == 6 then			
			if  #zmenu > 0 and tb1 > 0 then 	
				lb = 1
				tb1 = tb1 - 1
				if tb1 < 1 then 
					tb1 = 0
					tb = tb - 1
					if tb < 1 then 
						tb = #TSmenu
					end	
				end
			else				
				tb = tb - 1
				if tb < 1 then 
					tb = #TSmenu
				end	
			end			
		else
		end
	end
end

	