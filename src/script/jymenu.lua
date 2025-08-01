
--表中最大值和位置 
function Table_MaxValKey(tbl, key)
    -- 检查表是否为空
    if not tbl or #tbl == 0 then
        return nil, nil, nil
    end
    
    local maxVal
    local position = 1  -- 初始位置为第一个元素
    local maxItem = tbl[1]
    
    -- 确定初始最大值
    if key then
        -- 处理子表结构，比较指定键的值
        maxVal = tbl[1][key]
    else
        -- 处理简单数值表
        maxVal = tbl[1]
    end
    
    -- 遍历表查找最大值及其位置
    for i, item in ipairs(tbl) do
        local currentValue = key and item[key] or item
        
        -- 只比较数值类型
        if type(currentValue) == "number" then
            if currentValue > maxVal then
                maxVal = currentValue
                position = i  -- 更新位置为当前索引
                maxItem = item
            end
        end
    end
    return maxVal, position, maxItem
end

--地图传送模式整合
function Map_Deliver(menu)
	local bx = CC.WX
	local by = CC.HY
	-- 选项
	local tb = 1
	local size = CC.DefaultFont * 0.7
	local cl = C_CYGOLD
	-- 地图编号
	local BH;
	local sb;
	-- 地图编号表
	local jn = {}
	local jnzb = {}
	for i = 1, #menu do
		jn[i] = menu[i][1]
		jnzb[i] = {menu[i][2], menu[i][3]}
	end
	while true do
		if JY.Restart == 1 then
			break
		end
		ClsN()

		lib.PicLoadCache(92, 32 * 2, -1, -1, 1)
		local x, y = lib.GetPNGXY(91, 11 * 2)
		for i = 1, #jn do
			local cl = C_WHITE
			local s = JY.Scene[jn[i]]["名称"]

			if JY.Scene[jn[i]]["进入条件"] == 1  then
				cl = M_DimGray
			end
			if CC.TX['传送'] == 1 then 
			if JY.Scene[jn[i]]["场景类型"] ~= 1 then 
				cl = M_DimGray 
			end
			
			end
			if tb == i then
				cl = C_RED
				BH = jn[i]
				sb = i
			end
			-- 显示地图名称
			lib.LoadPNG(91, 11 * 2, bx * 212 + bx * jnzb[i][1] - x / 2, by * 33 + by * jnzb[i][2] - y / 2, 1)
			DrawString(bx * 212 + bx * jnzb[i][1] - string.len(s) / 4 * size, by * 33 + by * jnzb[i][2] - size / 2, s, cl, size)
		end
		ShowScreen()

		lib.Delay(CC.Frame)
		local X, ktype, mx, my = lib.GetKey();
		if X == VK_ESCAPE or ktype == 4 then
			PlayWavE(77)
			return 1
		elseif X == VK_UP or X == VK_LEFT then
			PlayWavE(77)
			tb = tb - 1
			if tb < 1 then
				tb = #jn
			end
		elseif X == VK_DOWN or X == VK_RIGHT then
			PlayWavE(77)
			tb = tb + 1
			if tb > #jn then
				tb = 1
			end
		elseif X == VK_SPACE or X == VK_RETURN then
			PlayWavE(77)
			if CC.TX['传送'] == 1 and JY.Scene[jn[i]]["场景类型"] ~= 1  then 
				CC.Shichen = CC.Shichen + 6
				return My_Enter_SubScene(BH, -1, -1, -1);
			else 
				if JY.Scene[BH]["进入条件"] == 0 then
					CC.Shichen = CC.Shichen + 6
					return My_Enter_SubScene(BH, -1, -1, -1);
				else
					say("１Ｒ您目前不能进入此场景。", 119, 5, "车夫");
					return 1
				end
			end
		else
			local mxx = false
			-- 鼠标x坐标中间位置左右两边的距离
			local x_jl = 47
			-- 鼠标y坐标中间位置左右两边的距离
			local y_jl = 12
			local xs;
			local ys;
			local sb1;
			-- xh
			for i = 1, #jnzb do
				-- 鼠标x坐标中间位置
				xs = bx * 212 + bx * jnzb[i][1]
				-- 鼠标y坐标中间位置
				ys = by * 33 + by * jnzb[i][2]
				sb1 = jnzb[i]
				sb = i
				if mx >= xs - x_jl and mx <= xs + x_jl and my >= ys - y_jl and my <= ys + y_jl then
					tb = sb
					mxx = true
					break
				end
			end
			if mxx == true and ktype == 3 then
				PlayWavE(77)
				if CC.TX['传送'] == 1  then 
					if JY.Scene[BH]["场景类型"] == 1 then
						CC.Shichen = CC.Shichen + 6
						return My_Enter_SubScene(BH, -1, -1, -1);
					else
						say("１Ｒ我只能送您到此地区的城镇。", 119, 5, "车夫");
						return 1
					end
				else 
					if JY.Scene[BH]["进入条件"] == 0 then
						CC.Shichen = CC.Shichen + 6
						return My_Enter_SubScene(BH, -1, -1, -1);
					else
						say("１Ｒ您目前不能进入此场景。", 119, 5, "车夫");
						return 1
					end
				end
			end
		end
	end
	return 0
end
--队友游历
function YouLi_Teammate()
    -- 游历 队友
	for i = 1, 5 do
		if CC.YOULI[i] > 0 then
			local personid = CC.YOULI[i]
			local id = personid
			if JY.Person[personid]['游历'] > 0 then
				JY.Person[personid]['游历'] = JY.Person[personid]['游历'] + 1
				if JY.Person[personid]['游历'] >= 30 then
					JY.Person[personid]['游历'] = 30
				end
				if JY.Person[personid]['游历'] == 30 then
					local psmenu = {{'攻击力', 10}, {'防御力', 10}, {'轻功', 10}, {'用毒能力', 10},
									{'暗器技巧', 10}, {'拳掌功夫', 10}, {'指法技巧', 10}, {'御剑能力', 10},
									{'耍刀技巧', 10}, {'特殊兵器', 10}, }
					local psmenu1 = {'结识人物', '获得物品'}

					--判断各项值中是否有达到上限
					
					--1判断经脉打通是不是已经到达上限				
					local qxnum = 0
					for w = 1, 149 do
						if JY.Person[id]['奇穴' .. w] == 1 then
							qxnum = qxnum + 1
						end
					end
					local qxmax = 0
					if qxnum == 149 then 
						qxmax = 1
					end
					--lib.Debug(JY.Person[id]['姓名']..'已打通经脉 ='..qxnum..' 经脉满 ='..qxmax)
					--2判断特技是否已经满了
					local tjmax = 0
					local tjnum = 0
					for w = 1,10 do 
						if JY.Person[id]['秘技'..w] > 0 then 
							tjnum = tjnum + 1
						end
					end
					if tjnum == 10 then 
						tjmax = 1
					end
					--lib.Debug(JY.Person[id]['姓名']..'已学会秘技 ='..tjnum..' 秘技满 ='..tjmax)
					--3判断天赋是否已经满了
					local tfmax = 0
					local tfnum = 0
					for w = 1,5 do 
						if JY.Person[id]['天赋'..w] > 0 then 
							tfnum = tfnum + 1
						end
					end
					if tfnum == 5 then 
						tfmax = 1
					end
					--lib.Debug(JY.Person[id]['姓名']..'已领悟天赋 ='..tfnum..' 天赋满 ='..tfmax)
					--4判断境界是否已经满了
					local jjmax = 0
					if JY.Person[id]['畅想分阶'] == 1 then 
						jjmax = 1
					end
					--lib.Debug(JY.Person[id]['姓名']..'境界已经达到 ='..JY.Person[id]['畅想分阶'])

					--计算游历种类概率
					local rnd = 1 
					local rmenu = {8 - cx, 10- cx,60 - cx} --游历类型概率
					local jjnum = 0
					if qxmax == 1 then  --计算游历中有哪几个类型满了，如果有一个满了就开始计算提升境界概率
						rmenu[3] = 0
						jjnum = jjnum + 1
					end
					if tjmax == 1 then 
						rmenu[2] = 0
						jjnum = jjnum + 1
					end
					if tfmax == 1 then 
						rmenu[1] = 0
						jjnum = jjnum + 1
					end

					local jjjl = 0
					if jjnum > 1 then 
						jjjl = jjjl + 5 
					end
					if jjjl > 0 and jjmax == 0 then 
						rnd = 5
					else
						if JLSD(0, rmenu[1], id) and tfmax == 0 then  
							rnd = 4                      --领悟天赋
						elseif JLSD(0, rmenu[2], id) and tjmax == 0 then  
							rnd = 3                      --学会秘技
						elseif JLSD(0, rmenu[3], id) and qxmax == 0 then  
							rnd = 2                       --打通经脉
						else
							rnd = 1       --增加属性
						end
					end
					lib.Debug(JY.Person[id]['姓名']..'游历类型 ='..rnd)
					 -- 增加属性
					if rnd == 1 then
						local rnd1 = math.random(#psmenu)
						local psx = psmenu[rnd1][1]
						local psx1 = math.random(psmenu[rnd1][2] / 2, psmenu[rnd1][2])
						local cj = math.random(0, 167)
						if (cj >= 143 and cj <= 150) then
							cj = 142
						end
						local cjname = JY.Scene[cj]["名称"]
						local yllx = {'游玩', '探险', '切磋武艺'}
						local yln = 1
						if JY.Scene[cj]["场景类型"] == 10 then
							yln = 2
						elseif JY.Scene[cj]["场景类型"] == 2 then
							yln = 3
						end
						local did = 1
						local sjmp = math.random(0, 30)
						local sjmpid = math.random(#CC.MpRw[sjmp])
						local drn1 = CC.MpRw[sjmp][sjmpid]
						local name1 = JY.Person[drn1]['姓名']
						if name1 == '备用' then
							name1 = '神秘人'
						end
						-- DrawStrBoxWaitKey(JY.Person[CC.YOULI[i]]['姓名']..'在'..cjname..'与'..name1..yllx[yln]..'，增加'..psx..' '..psx1..'点', C_WHITE, CC.DefaultFont)
						local yltxt = yltime..JY.Person[id]['姓名'] .. '在' .. cjname .. '与' .. name1 .. yllx[yln] .. '，增加' .. psx .. ' ' .. psx1 .. '点'

						-- lib.Debug(yltxt)
						local testPath = "yltxt.txt"
						local testPath1 = "ylname.txt"
						appendWithTimestamp(testPath, yltxt)
						appendWithTimestamp(testPath1,id )
						--AddPersonAttrib(id, psx, 10)
						CC.JHtxt[#CC.JHtxt+1] = 1  --游历类型
						CC.JHtxt_ID[#CC.JHtxt_ID+1] = id --游历人物
						CC.JHtxt_SCENE[#CC.JHtxt_SCENE+1] = cj --游历场景
						CC.JHtxt_ID1[#CC.JHtxt_ID1+1] = drn1  --游历交互人物
						CC.JHtxt_PSX[#CC.JHtxt_PSX+1] = rnd1  --增加的属性类型
						CC.JHtxt_POINTS[#CC.JHtxt_POINTS+1] = psx1 --增加属性的点数
						CC.JHtxt_YEAR[#CC.JHtxt_YEAR+1] = CC.Year
						CC.JHtxt_MONTH[#CC.JHtxt_MONTH+1] = CC.Month
						CC.JHtxt_DAY[#CC.JHtxt_DAY+1] = CC.Day
						JY.Person[id]['游历次数'] = JY.Person[id]['游历次数'] + 1
						-- break
						-- 打通经脉	
					elseif rnd == 2 then
						-- local jmme = {CC.TSJM_SSYIN,CC.TSJM_SSYANG,CC.TSJM_ZSYIN,CC.TSJM_ZSYANG,CC.TSJM_RENDU}
						local kf = JY.Person[id]['优先使用']
						local kflx = JY.Wugong[kf]['武功类型']
						
						local Jingmai =
							{CC.Sshaoyin, CC.Staiyin, CC.Sjueyin, CC.Sshaoyang, CC.Staiyang, CC.Syangming, -- 1指，2剑，3毒，4拳，5刀，6阳，
							CC.Zshaoyin, CC.Ztaiyin, CC.Zjueyin, CC.Zshaoyang, CC.Ztaiyang, CC.Zyangming, -- 7特，8阴，9低资，10轻，11医，12调和，
							CC.Renmai, CC.Dumai} -- 13中资，14高资
						local Jingmainm = {'手少阴经', '手太阴经', '手厥阴经', '手少阳经', '手太阳经',
										'手阳明经', '足少阴经', '足太阴经', '足厥阴经', '足少阳经',
										'足太阳经', '足阳明经', '任脉', '督脉'}
						local num = {}
						if kflx == 1 then
							num[#num + 1] = 1
						end
						if kflx == 2 then
							num[#num + 1] = 4
						end
						if kflx == 3 then
							num[#num + 1] = 2
						end
						if kflx == 4 then
							num[#num + 1] = 5
						end
						if kflx == 5 then
							num[#num + 1] = 7
						end
						if kflx == 6 then
							num[#num + 1] = 12
						end
						if JY.Person[id]['用毒能力'] > 100 then
							num[#num + 1] = 3
						end
						if JY.Person[id]['攻击带毒'] > 50 then
							num[#num + 1] = 3
						end
						if JY.Person[id]['医疗能力'] > 100 then
							num[#num + 1] = 11
						end

						if JY.Person[id]['资质'] >= 80 then
							num[#num + 1] = 14
						end
						if JY.Person[id]['资质'] > 30 and JY.Person[id]['资质'] < 80 then
							num[#num + 1] = 13
						end
						if JY.Person[id]['资质'] <= 30 then
							num[#num + 1] = 9
						end
						if JY.Person[id]['内力性质'] == 0 then
							num[#num + 1] = 8
						end
						if JY.Person[id]['内力性质'] == 1 then
							num[#num + 1] = 6
						end
						if JY.Person[id]['内力性质'] == 2 then
							num[#num + 1] = 12
						end
						num[#num + 1] = 10
						local pdqx = 0
						local jm = 0
						local qx = 0
						local jmmenu = {}
						local jmjd1 = 0
						local jmjd2 = 0
						local jmname = ''
						local qxname = ''

						for j = 1,#num do 
							local qx1 = num[j]
							lib.Debug('统计到的经脉有'..qx1)
							for w = 1,#Jingmai[qx1] do 
								local qx2 = Jingmai[qx1][w][8]
								--lib.Debug('计算经脉'..Jingmainm[qx1])
								if JY.Person[id]['奇穴'..qx2] == 0 then 
									jmmenu[#jmmenu+1] = {qx1,w}
									lib.Debug('相性统计到的经脉有'..qx1..' ='..Jingmainm[qx1]..' 奇穴 ='..Jingmai[qx1][w][8]..Jingmai[qx1][w][1])
								end
							end
						end
						if #jmmenu ~= nil then 
							local sjqx = math.random(#jmmenu) -- Jingmai[num[math.random(#num)]]  --从保存的经脉里随机抽取一个	
							jm = jmmenu[sjqx][1] --确定经脉
							qx = jmmenu[sjqx][2] --确定奇穴位置	
							jmjd1 = Jingmai[jm][qx][2]  --经脉增加属性名称
							jmjd2 = Jingmai[jm][qx][3]  --经脉增加属性值
							jmname = Jingmai[jm][qx][1] --经脉名字

							lib.Debug('随机到相性的经脉'..jm..' ='..Jingmainm[jm]..' 随机到相性的奇穴 ='..Jingmai[jm][qx][8]..Jingmai[jm][qx][1])
						else					
							for w = 1, 149 do
								if JY.Person[id]['奇穴' .. w] == 0 then
									jmmenu[#jmmenu + 1] = w
								end
							end
							local sjqx = jmmenu[math.random(#jmmenu)] --确定奇穴位置	
							for j = 1, #Jingmai do
								for w = 1, #Jingmai[j] do
									-- if CC.Sshaoyin[i][8] == jm then 
									if Jingmai[j][w][8] == sjqx then
										jm = j
										qx = w
										jmjd1 = Jingmai[jm][qx][2]  --经脉增加属性名称
										jmjd2 = Jingmai[jm][qx][3]  --经脉增加属性值
										jmname = Jingmai[jm][qx][1]	 --经脉名字		
									end
								end
							end
						end

						local yltxt = yltime..JY.Person[id]['姓名'] .. '闭关修炼打通了' .. jmname .. '，修为大增。'
						local testPath = "yltxt.txt"
						local testPath1 = "ylname.txt"                   
						-- lib.Debug(yltxt)
						local testPath = "yltxt.txt"
						local testPath1 = "ylname.txt"
						appendWithTimestamp(testPath, yltxt)
						appendWithTimestamp(testPath1,id )
						--AddPersonAttrib(id, psx, 10)
						CC.JHtxt[#CC.JHtxt+1] = 2  --1游历类型
						CC.JHtxt_ID[#CC.JHtxt_ID+1] = id --2游历人物
						CC.JHtxt_SCENE[#CC.JHtxt_SCENE+1] = -1 --3游历场景
						CC.JHtxt_ID1[#CC.JHtxt_ID1+1] = -1  --4游历交互人物
						CC.JHtxt_PSX[#CC.JHtxt_PSX+1] = qx + 100  --5增加的属性类型 奇穴定位 --
						CC.JHtxt_POINTS[#CC.JHtxt_POINTS+1] = jm+1000 --6增加属性的点数 --经脉定位
						CC.JHtxt_YEAR[#CC.JHtxt_YEAR+1] = CC.Year  --7
						CC.JHtxt_MONTH[#CC.JHtxt_MONTH+1] = CC.Month  --8
						CC.JHtxt_DAY[#CC.JHtxt_DAY+1] = CC.Day  --9
						JY.Person[id]['游历次数'] = JY.Person[id]['游历次数'] + 1

						JY.Person[id]['奇穴' .. jm] = 1
						local rwqx = jm
						if JMQX_JH(id, rwqx) then
							----lib.Debug('经脉奇穴判定成功')
							-- JY.Person[id][jmjd[2]] = JY.Person[id][jmjd[2]] + jmjd[3]  --增加人物属性
							AddPersonAttrib(id, jmjd1, jmjd2)
							if rwqx == 22 then
								AddPersonAttrib(id, "攻击带毒", 20)
								AddPersonAttrib(id, "用毒能力", 20)
							end
							if rwqx == 25 then
								AddPersonAttrib(id, "用毒能力", 30)
								if Pmiji(id, 6) and Pmiji(id, 8) then
									AddPersonAttrib(id, '用毒能力', 80)
								end
							end
							if rwqx == 28 then
								AddPersonAttrib(id, "用毒能力", 100)
							end
							if rwqx == 61 then
								local jsx = JY.Person[id]['防御力'] * 0.1
								AddPersonAttrib(id, "防御力", jsx)
							end
							if rwqx == 83 then
								local jsx = JY.Person[id]['攻击力'] * 0.1
								AddPersonAttrib(id, "攻击力", jsx)
							end
							if rwqx == 95 then
								local jsx = JY.Person[id]['基础生命'] * 0.1
								AddPersonAttrib(id, "基础生命", jsx)
							end
							if rwqx == 99 then
								local jsx = JY.Person[id]['生命最大值'] * 0.1
								AddPersonAttrib(id, "生命最大值", jsx)
							end
							if rwqx == 106 then
								local jsx = JY.Person[id]['轻功'] * 0.1
								AddPersonAttrib(id, "轻功", jsx)
							end
							if rwqx == 117 then
								local jsx = 5
								AddPersonAttrib(id, "体质", jsx)
							end
							if rwqx == 129 then
								local jsx = 1000
								AddPersonAttrib(id, "内力最大值", jsx)
							end
							if rwqx == 139 or rwqx == 149 then
								local jsx = JY.Person[id]['防御力'] * 0.05
								AddPersonAttrib(id, "防御力", jsx)
							end
							if rwqx == 139 or rwqx == 149 then
								local jsx = JY.Person[id]['攻击力'] * 0.05
								AddPersonAttrib(id, "攻击力", jsx)
							end
						end
						-- 贯通经脉属性加成
						for w = 1, #CC.qxnum do
							if CC.qxnum[w] == rwqx then
								if w == 1 or w == 4 or w == 7 or w == 10 then
									if JY.Person[id]["奇穴" .. CC.qxnum[w]] == 1 then
										-- JY.Person[id]['攻击力'] =  JY.Person[id]['攻击力'] + 50
										AddPersonAttrib(id, '攻击力', 50)
									end
								elseif w == 2 or w == 5 or w == 8 or w == 11 then
									if JY.Person[id]["奇穴" .. CC.qxnum[w]] == 1 then
										-- JY.Person[id]['防御力'] =  JY.Person[id]['防御力'] + 50
										AddPersonAttrib(id, '防御力', 50)
									end
								elseif w == 3 or w == 6 or w == 9 or w == 12 then
									if JY.Person[id]["奇穴" .. CC.qxnum[w]] == 1 then
										-- JY.Person[id]['轻功'] =  JY.Person[id]['轻功'] + 50
										AddPersonAttrib(id, '轻功', 50)
									end
								elseif w == 13 or w == 14 then
									if JY.Person[id]["奇穴" .. CC.qxnum[w]] == 1 then
										-- JY.Person[id]['轻功'] =  JY.Person[id]['轻功'] + 50
										AddPersonAttrib(id, '轻功', 50)
									end
									if JY.Person[id]["奇穴" .. CC.qxnum[w]] == 1 then
										-- JY.Person[id]['攻击力'] =  JY.Person[id]['攻击力'] + 50
										AddPersonAttrib(id, '攻击力', 50)
									end
									if JY.Person[id]["奇穴" .. CC.qxnum[w]] == 1 then
										-- JY.Person[id]['防御力'] =  JY.Person[id]['防御力'] + 50
										AddPersonAttrib(id, '防御力', 50)
									end
								end
							end
						end
						-- 领悟秘技	
					elseif rnd == 3 then
						local tjmen = {}
						for i = 1, JY.TejiNum - 1 do
							local TJname = JY.Teji[i]['名称']
							if TJname ~= '无' and TJname ~= '备用' then
								tjmen[i] = {TJname, nil, 1, i}
							end
						end
						local teji = math.random(#tjmen)
						for w = 1, 10 do
							if JY.Person[id]['秘技' .. w] == teji then
								break
							end
							if JY.Person[id]['秘技' .. w] == 0 then
								JY.Person[id]['秘技' .. w] = teji
								break
							end
						end
						local yltxt = yltime..JY.Person[id]['姓名'] .. '闭关修炼，领悟了秘技' .. tjmen[teji][1] .. '，甚是羡煞旁人'
						-- lib.Debug(yltxt)                
						-- lib.Debug(yltxt)
						local testPath = "yltxt.txt"
						local testPath1 = "ylname.txt"
						appendWithTimestamp(testPath, yltxt)
						appendWithTimestamp(testPath1,id )
						--AddPersonAttrib(id, psx, 10)
						CC.JHtxt[#CC.JHtxt+1] = 3  --1游历类型
						CC.JHtxt_ID[#CC.JHtxt_ID+1] = id --2游历人物
						CC.JHtxt_SCENE[#CC.JHtxt_SCENE+1] = -1 --3游历场景
						CC.JHtxt_ID1[#CC.JHtxt_ID1+1] = -1  --4游历交互人物
						CC.JHtxt_PSX[#CC.JHtxt_PSX+1] = -1  --5增加的属性类型
						CC.JHtxt_POINTS[#CC.JHtxt_POINTS+1] = teji+3000 --增加属性的点数
						CC.JHtxt_YEAR[#CC.JHtxt_YEAR+1] = CC.Year
						CC.JHtxt_MONTH[#CC.JHtxt_MONTH+1] = CC.Month
						CC.JHtxt_DAY[#CC.JHtxt_DAY+1] = CC.Day
						JY.Person[id]['游历次数'] = JY.Person[id]['游历次数'] + 1
						-- 领悟天赋	
					elseif rnd == 4 then
						local tfme = {}
						local tflv = 0
						if cx <= 2 then
							tflv = 4
						end
						if cx == 3 or cx == 4 then
							tflv = 3
						end
						if cx == 5 or cx == 6 then
							tflv = 2
						end

						for w = 1, #CC.Tiangtf do
							if CC.PTFSM[CC.Tiangtf[w]][5] == tflv then
								tfme[#tfme + 1] = CC.Tiangtf[w]
							end
						end
						local tf = tfme[math.random(#tfme)]

						for w = 1, 5 do
							if JY.Person[id]['天赋' .. w] == tf then
								break
							end
							if JY.Person[id]['天赋' .. w] == 0 then
								JY.Person[id]['天赋' .. w] = tf
								break
							end
						end
						local yltxt = yltime..JY.Person[id]['姓名'] .. '游戏江湖，观武切磋，领悟了天赋' .. CC.PTFSM[tf][1] .. '，已非吴下阿蒙'
						-- lib.Debug(yltxt)
						local testPath = "yltxt.txt"
						local testPath1 = "ylname.txt"
						appendWithTimestamp(testPath, yltxt)
						appendWithTimestamp(testPath1,id )
						--AddPersonAttrib(id, psx, 10)
						CC.JHtxt[#CC.JHtxt+1] = 4  --游历类型
						CC.JHtxt_ID[#CC.JHtxt_ID+1] = id --游历人物
						CC.JHtxt_SCENE[#CC.JHtxt_SCENE+1] = -1 --游历场景
						CC.JHtxt_ID1[#CC.JHtxt_ID1+1] = -1  --游历交互人物
						CC.JHtxt_PSX[#CC.JHtxt_PSX+1] = -1 --增加的属性类型
						CC.JHtxt_POINTS[#CC.JHtxt_POINTS+1] =tf+4000--增加属性的点数
						CC.JHtxt_YEAR[#CC.JHtxt_YEAR+1] = CC.Year
						CC.JHtxt_MONTH[#CC.JHtxt_MONTH+1] = CC.Month
						CC.JHtxt_DAY[#CC.JHtxt_DAY+1] = CC.Day
						JY.Person[id]['游历次数'] = JY.Person[id]['游历次数'] + 1
					elseif rnd == 5 then 
						cx = cx - 1
						local cxmenu = {'神话','宗师','豪侠','一流','二流','三流',}
						local yltxt = yltime..JY.Person[id]['姓名'] .. '闭关修炼，武学境阶提升到' ..cxmenu[cx].. '，名满江湖'
						-- lib.Debug(yltxt)
						local testPath = "yltxt.txt"
						local testPath1 = "ylname.txt"
						appendWithTimestamp(testPath, yltxt)
						appendWithTimestamp(testPath1,id )
						--AddPersonAttrib(id, psx, 10)
						CC.JHtxt[#CC.JHtxt+1] = 5  --游历类型
						CC.JHtxt_ID[#CC.JHtxt_ID+1] = id --游历人物
						CC.JHtxt_SCENE[#CC.JHtxt_SCENE+1] = -1 --游历场景
						CC.JHtxt_ID1[#CC.JHtxt_ID1+1] = -1  --游历交互人物
						CC.JHtxt_PSX[#CC.JHtxt_PSX+1] = cx + 1000 --增加的属性类型
						CC.JHtxt_POINTS[#CC.JHtxt_POINTS+1] = -1--增加属性的点数
						CC.JHtxt_YEAR[#CC.JHtxt_YEAR+1] = CC.Year
						CC.JHtxt_MONTH[#CC.JHtxt_MONTH+1] = CC.Month
						CC.JHtxt_DAY[#CC.JHtxt_DAY+1] = CC.Day
						JY.Person[id]['游历次数'] = JY.Person[id]['游历次数'] + 1
					end
					JY.Person[personid]['游历'] = 0
					CC.YOULI[i] = 0
					break
				end
			end
		end
	end
end

--npc游历
function YouLi()
	local yly = numberToChinese(CC.Year)..'年'
	local ylm = numberToChinese(CC.Month)..'月'
	local ylt = numberToChinese(CC.Day)..'日'
	--local yltime = '天书'..yly..ylm..ylt
	local yltime = ''
    -- 游历 NPC 
	for i = 1, 50 do
		local Npc_yl = math.random(757)
		local id = Npc_yl
		local cx = JY.Person[id]['畅想分阶']
		local pd = 0
		for w = 1, #CC.YOULI do
			if CC.YOULI[w] == id then
				pd = 1
			end
		end
		if  inteam(id) == false and cx <= 6 and JY.Person[id]['姓名'] ~= '备用' and JY.Person[id]['姓名'] ~= '标主占用' and JY.Person[id]['姓名'] ~= '门主占用' and pd == 0 and id ~= 591 and id ~= 600 then
			local psmenu = {{'攻击力', 10}, {'防御力', 10}, {'轻功', 10}, {'用毒能力', 10},
							{'暗器技巧', 10}, {'拳掌功夫', 10}, {'指法技巧', 10}, {'御剑能力', 10},
							{'耍刀技巧', 10}, {'特殊兵器', 10}, }
			local psmenu1 = {'结识人物', '获得物品'}

			--判断各项值中是否有达到上限
			
			--1判断经脉打通是不是已经到达上限				
			local qxnum = 0
			for w = 1, 149 do
				if JY.Person[id]['奇穴' .. w] == 1 then
					qxnum = qxnum + 1
				end
			end
			local qxmax = 0
			if qxnum == 149 then 
				qxmax = 1
			end
			--lib.Debug(JY.Person[id]['姓名']..'已打通经脉 ='..qxnum..' 经脉满 ='..qxmax)
			--2判断特技是否已经满了
			local tjmax = 0
			local tjnum = 0
			for w = 1,10 do 
				if JY.Person[id]['秘技'..w] > 0 then 
					tjnum = tjnum + 1
				end
			end
			if tjnum == 10 then 
				tjmax = 1
			end
			--lib.Debug(JY.Person[id]['姓名']..'已学会秘技 ='..tjnum..' 秘技满 ='..tjmax)
			--3判断天赋是否已经满了
			local tfmax = 0
			local tfnum = 0
			for w = 1,5 do 
				if JY.Person[id]['天赋'..w] > 0 then 
					tfnum = tfnum + 1
				end
			end
			if tfnum == 5 then 
				tfmax = 1
			end
			--lib.Debug(JY.Person[id]['姓名']..'已领悟天赋 ='..tfnum..' 天赋满 ='..tfmax)
			--4判断境界是否已经满了
			local jjmax = 0
			if JY.Person[id]['畅想分阶'] == 1 then 
				jjmax = 1
			end
			--lib.Debug(JY.Person[id]['姓名']..'境界已经达到 ='..JY.Person[id]['畅想分阶'])

			--计算游历种类概率
			local rnd = 1 
			local rmenu = {8 - cx, 10- cx,60 - cx} --游历类型概率
			local jjnum = 0
			if qxmax == 1 then  --计算游历中有哪几个类型满了，如果有一个满了就开始计算提升境界概率
				rmenu[3] = 0
				jjnum = jjnum + 1
			end
			if tjmax == 1 then 
				rmenu[2] = 0
				jjnum = jjnum + 1
			end
			if tfmax == 1 then 
				rmenu[1] = 0
				jjnum = jjnum + 1
			end

			local jjjl = 0
			if jjnum > 1 then 
				jjjl = jjjl + 5 
			end
			if jjjl > 0 and jjmax == 0 then 
				rnd = 5
			else
				if cx <= 4 then
					if JLSD(0, rmenu[1], id) and tfmax == 0 then  
						rnd = 4                      --领悟天赋
					elseif JLSD(0, rmenu[2], id) and tjmax == 0 then  
						rnd = 3                      --学会秘技
					elseif JLSD(0, rmenu[3], id) and qxmax == 0 then  
						rnd = 2                       --打通经脉
					else
						rnd = 1       --增加属性
					end
				end
			end
			lib.Debug(JY.Person[id]['姓名']..'游历类型 ='..rnd)
			-- 增加属性
			if rnd == 1 then
				local rnd1 = math.random(#psmenu)
				local psx = psmenu[rnd1][1]
				local psx1 = math.random(psmenu[rnd1][2] / 2, psmenu[rnd1][2])
				local cj = math.random(0, 167)
				if (cj >= 143 and cj <= 150) then
					cj = 142
				end
				local cjname = JY.Scene[cj]["名称"]
				local yllx = {'游玩', '探险', '切磋武艺'}
				local yln = 1
				if JY.Scene[cj]["场景类型"] == 10 then
					yln = 2
				elseif JY.Scene[cj]["场景类型"] == 2 then
					yln = 3
				end
				local did = 1
				local sjmp = math.random(0, 30)
				local sjmpid = math.random(#CC.MpRw[sjmp])
				local drn1 = CC.MpRw[sjmp][sjmpid]
				local name1 = JY.Person[drn1]['姓名']
				if name1 == '备用' then
					name1 = '神秘人'
				end
				-- DrawStrBoxWaitKey(JY.Person[CC.YOULI[i]]['姓名']..'在'..cjname..'与'..name1..yllx[yln]..'，增加'..psx..' '..psx1..'点', C_WHITE, CC.DefaultFont)
				local yltxt = yltime..JY.Person[id]['姓名'] .. '在' .. cjname .. '与' .. name1 .. yllx[yln] .. '，增加' .. psx .. ' ' .. psx1 .. '点'

				-- lib.Debug(yltxt)
				local testPath = "yltxt.txt"
				local testPath1 = "ylname.txt"
				appendWithTimestamp(testPath, yltxt)
				appendWithTimestamp(testPath1,id )
				--AddPersonAttrib(id, psx, 10)
				CC.JHtxt[#CC.JHtxt+1] = 1  --游历类型
				CC.JHtxt_ID[#CC.JHtxt_ID+1] = id --游历人物
				CC.JHtxt_SCENE[#CC.JHtxt_SCENE+1] = cj --游历场景
				CC.JHtxt_ID1[#CC.JHtxt_ID1+1] = drn1  --游历交互人物
				CC.JHtxt_PSX[#CC.JHtxt_PSX+1] = rnd1  --增加的属性类型
				CC.JHtxt_POINTS[#CC.JHtxt_POINTS+1] = psx1 --增加属性的点数
				CC.JHtxt_YEAR[#CC.JHtxt_YEAR+1] = CC.Year
				CC.JHtxt_MONTH[#CC.JHtxt_MONTH+1] = CC.Month
				CC.JHtxt_DAY[#CC.JHtxt_DAY+1] = CC.Day
				JY.Person[id]['游历次数'] = JY.Person[id]['游历次数'] + 1
				-- break
				-- 打通经脉	
			elseif rnd == 2 then
				-- local jmme = {CC.TSJM_SSYIN,CC.TSJM_SSYANG,CC.TSJM_ZSYIN,CC.TSJM_ZSYANG,CC.TSJM_RENDU}
				local kf = JY.Person[id]['优先使用']
				local kflx = JY.Wugong[kf]['武功类型']
				
				local Jingmai =
					{CC.Sshaoyin, CC.Staiyin, CC.Sjueyin, CC.Sshaoyang, CC.Staiyang, CC.Syangming, -- 1指，2剑，3毒，4拳，5刀，6阳，
					 CC.Zshaoyin, CC.Ztaiyin, CC.Zjueyin, CC.Zshaoyang, CC.Ztaiyang, CC.Zyangming, -- 7特，8阴，9低资，10轻，11医，12调和，
					 CC.Renmai, CC.Dumai} -- 13中资，14高资
				local Jingmainm = {'手少阴经', '手太阴经', '手厥阴经', '手少阳经', '手太阳经',
								   '手阳明经', '足少阴经', '足太阴经', '足厥阴经', '足少阳经',
								   '足太阳经', '足阳明经', '任脉', '督脉'}
				local num = {}
				if kflx == 1 then
					num[#num + 1] = 1
				end
				if kflx == 2 then
					num[#num + 1] = 4
				end
				if kflx == 3 then
					num[#num + 1] = 2
				end
				if kflx == 4 then
					num[#num + 1] = 5
				end
				if kflx == 5 then
					num[#num + 1] = 7
				end
				if kflx == 6 then
					num[#num + 1] = 12
				end
				if JY.Person[id]['用毒能力'] > 100 then
					num[#num + 1] = 3
				end
				if JY.Person[id]['攻击带毒'] > 50 then
					num[#num + 1] = 3
				end
				if JY.Person[id]['医疗能力'] > 100 then
					num[#num + 1] = 11
				end

				if JY.Person[id]['资质'] >= 80 then
					num[#num + 1] = 14
				end
				if JY.Person[id]['资质'] > 30 and JY.Person[id]['资质'] < 80 then
					num[#num + 1] = 13
				end
				if JY.Person[id]['资质'] <= 30 then
					num[#num + 1] = 9
				end
				if JY.Person[id]['内力性质'] == 0 then
					num[#num + 1] = 8
				end
				if JY.Person[id]['内力性质'] == 1 then
					num[#num + 1] = 6
				end
				if JY.Person[id]['内力性质'] == 2 then
					num[#num + 1] = 12
				end
				num[#num + 1] = 10
				local pdqx = 0
				local jm = 0
				local qx = 0
				local jmmenu = {}
				local jmjd1 = 0
				local jmjd2 = 0
				local jmname = ''
				local qxname = ''

				for j = 1,#num do 
					local qx1 = num[j]
					lib.Debug('统计到的经脉有'..qx1)
					for w = 1,#Jingmai[qx1] do 
						local qx2 = Jingmai[qx1][w][8]
						--lib.Debug('计算经脉'..Jingmainm[qx1])
						if JY.Person[id]['奇穴'..qx2] == 0 then 
							jmmenu[#jmmenu+1] = {qx1,w}
							lib.Debug('相性统计到的经脉有'..qx1..' ='..Jingmainm[qx1]..' 奇穴 ='..Jingmai[qx1][w][8]..Jingmai[qx1][w][1])
						end
					end
				end
				if #jmmenu ~= nil then 
					local sjqx = math.random(#jmmenu) -- Jingmai[num[math.random(#num)]]  --从保存的经脉里随机抽取一个	
					jm = jmmenu[sjqx][1] --确定经脉
					qx = jmmenu[sjqx][2] --确定奇穴位置	
					jmjd1 = Jingmai[jm][qx][2]  --经脉增加属性名称
					jmjd2 = Jingmai[jm][qx][3]  --经脉增加属性值
					jmname = Jingmai[jm][qx][1] --经脉名字

					lib.Debug('随机到相性的经脉'..jm..' ='..Jingmainm[jm]..' 随机到相性的奇穴 ='..Jingmai[jm][qx][8]..Jingmai[jm][qx][1])
				else					
					for w = 1, 149 do
						if JY.Person[id]['奇穴' .. w] == 0 then
							jmmenu[#jmmenu + 1] = w
						end
					end
					local sjqx = jmmenu[math.random(#jmmenu)] --确定奇穴位置	
					for j = 1, #Jingmai do
						for w = 1, #Jingmai[j] do
							-- if CC.Sshaoyin[i][8] == jm then 
							if Jingmai[j][w][8] == sjqx then
								jm = j
								qx = w
								jmjd1 = Jingmai[jm][qx][2]  --经脉增加属性名称
								jmjd2 = Jingmai[jm][qx][3]  --经脉增加属性值
								jmname = Jingmai[jm][qx][1]	 --经脉名字		
							end
						end
					end
				end

				local yltxt = yltime..JY.Person[id]['姓名'] .. '闭关修炼打通了' .. jmname .. '，修为大增。'
				local testPath = "yltxt.txt"
				local testPath1 = "ylname.txt"                   
				-- lib.Debug(yltxt)
				local testPath = "yltxt.txt"
				local testPath1 = "ylname.txt"
				appendWithTimestamp(testPath, yltxt)
				appendWithTimestamp(testPath1,id )
				--AddPersonAttrib(id, psx, 10)
				CC.JHtxt[#CC.JHtxt+1] = 2  --1游历类型
				CC.JHtxt_ID[#CC.JHtxt_ID+1] = id --2游历人物
				CC.JHtxt_SCENE[#CC.JHtxt_SCENE+1] = -1 --3游历场景
				CC.JHtxt_ID1[#CC.JHtxt_ID1+1] = -1  --4游历交互人物
				CC.JHtxt_PSX[#CC.JHtxt_PSX+1] = qx + 100  --5增加的属性类型 奇穴定位 --
				CC.JHtxt_POINTS[#CC.JHtxt_POINTS+1] = jm+1000 --6增加属性的点数 --经脉定位
				CC.JHtxt_YEAR[#CC.JHtxt_YEAR+1] = CC.Year  --7
				CC.JHtxt_MONTH[#CC.JHtxt_MONTH+1] = CC.Month  --8
				CC.JHtxt_DAY[#CC.JHtxt_DAY+1] = CC.Day  --9
				JY.Person[id]['游历次数'] = JY.Person[id]['游历次数'] + 1

				JY.Person[id]['奇穴' .. jm] = 1
				local rwqx = jm
				if JMQX_JH(id, rwqx) then
					----lib.Debug('经脉奇穴判定成功')
					-- JY.Person[id][jmjd[2]] = JY.Person[id][jmjd[2]] + jmjd[3]  --增加人物属性
					AddPersonAttrib(id, jmjd1, jmjd2)
					if rwqx == 22 then
						AddPersonAttrib(id, "攻击带毒", 20)
						AddPersonAttrib(id, "用毒能力", 20)
					end
					if rwqx == 25 then
						AddPersonAttrib(id, "用毒能力", 30)
						if Pmiji(id, 6) and Pmiji(id, 8) then
							AddPersonAttrib(id, '用毒能力', 80)
						end
					end
					if rwqx == 28 then
						AddPersonAttrib(id, "用毒能力", 100)
					end
					if rwqx == 61 then
						local jsx = JY.Person[id]['防御力'] * 0.1
						AddPersonAttrib(id, "防御力", jsx)
					end
					if rwqx == 83 then
						local jsx = JY.Person[id]['攻击力'] * 0.1
						AddPersonAttrib(id, "攻击力", jsx)
					end
					if rwqx == 95 then
						local jsx = JY.Person[id]['基础生命'] * 0.1
						AddPersonAttrib(id, "基础生命", jsx)
					end
					if rwqx == 99 then
						local jsx = JY.Person[id]['生命最大值'] * 0.1
						AddPersonAttrib(id, "生命最大值", jsx)
					end
					if rwqx == 106 then
						local jsx = JY.Person[id]['轻功'] * 0.1
						AddPersonAttrib(id, "轻功", jsx)
					end
					if rwqx == 117 then
						local jsx = 5
						AddPersonAttrib(id, "体质", jsx)
					end
					if rwqx == 129 then
						local jsx = 1000
						AddPersonAttrib(id, "内力最大值", jsx)
					end
					if rwqx == 139 or rwqx == 149 then
						local jsx = JY.Person[id]['防御力'] * 0.05
						AddPersonAttrib(id, "防御力", jsx)
					end
					if rwqx == 139 or rwqx == 149 then
						local jsx = JY.Person[id]['攻击力'] * 0.05
						AddPersonAttrib(id, "攻击力", jsx)
					end
				end
				-- 贯通经脉属性加成
				for w = 1, #CC.qxnum do
					if CC.qxnum[w] == rwqx then
						if w == 1 or w == 4 or w == 7 or w == 10 then
							if JY.Person[id]["奇穴" .. CC.qxnum[w]] == 1 then
								-- JY.Person[id]['攻击力'] =  JY.Person[id]['攻击力'] + 50
								AddPersonAttrib(id, '攻击力', 50)
							end
						elseif w == 2 or w == 5 or w == 8 or w == 11 then
							if JY.Person[id]["奇穴" .. CC.qxnum[w]] == 1 then
								-- JY.Person[id]['防御力'] =  JY.Person[id]['防御力'] + 50
								AddPersonAttrib(id, '防御力', 50)
							end
						elseif w == 3 or w == 6 or w == 9 or w == 12 then
							if JY.Person[id]["奇穴" .. CC.qxnum[w]] == 1 then
								-- JY.Person[id]['轻功'] =  JY.Person[id]['轻功'] + 50
								AddPersonAttrib(id, '轻功', 50)
							end
						elseif w == 13 or w == 14 then
							if JY.Person[id]["奇穴" .. CC.qxnum[w]] == 1 then
								-- JY.Person[id]['轻功'] =  JY.Person[id]['轻功'] + 50
								AddPersonAttrib(id, '轻功', 50)
							end
							if JY.Person[id]["奇穴" .. CC.qxnum[w]] == 1 then
								-- JY.Person[id]['攻击力'] =  JY.Person[id]['攻击力'] + 50
								AddPersonAttrib(id, '攻击力', 50)
							end
							if JY.Person[id]["奇穴" .. CC.qxnum[w]] == 1 then
								-- JY.Person[id]['防御力'] =  JY.Person[id]['防御力'] + 50
								AddPersonAttrib(id, '防御力', 50)
							end
						end
					end
				end
				-- 领悟秘技	
			elseif rnd == 3 then
				local tjmen = {}
				for i = 1, JY.TejiNum - 1 do
					local TJname = JY.Teji[i]['名称']
					if TJname ~= '无' and TJname ~= '备用' then
						tjmen[i] = {TJname, nil, 1, i}
					end
				end
				local teji = math.random(#tjmen)
				for w = 1, 10 do
					if JY.Person[id]['秘技' .. w] == teji then
						break
					end
					if JY.Person[id]['秘技' .. w] == 0 then
						JY.Person[id]['秘技' .. w] = teji
						break
					end
				end
				local yltxt = yltime..JY.Person[id]['姓名'] .. '闭关修炼，领悟了秘技' .. tjmen[teji][1] .. '，甚是羡煞旁人'
				-- lib.Debug(yltxt)                
				-- lib.Debug(yltxt)
				local testPath = "yltxt.txt"
				local testPath1 = "ylname.txt"
				appendWithTimestamp(testPath, yltxt)
				appendWithTimestamp(testPath1,id )
				--AddPersonAttrib(id, psx, 10)
				CC.JHtxt[#CC.JHtxt+1] = 3  --1游历类型
				CC.JHtxt_ID[#CC.JHtxt_ID+1] = id --2游历人物
				CC.JHtxt_SCENE[#CC.JHtxt_SCENE+1] = -1 --3游历场景
				CC.JHtxt_ID1[#CC.JHtxt_ID1+1] = -1  --4游历交互人物
				CC.JHtxt_PSX[#CC.JHtxt_PSX+1] = -1  --5增加的属性类型
				CC.JHtxt_POINTS[#CC.JHtxt_POINTS+1] = teji+3000 --增加属性的点数
				CC.JHtxt_YEAR[#CC.JHtxt_YEAR+1] = CC.Year
				CC.JHtxt_MONTH[#CC.JHtxt_MONTH+1] = CC.Month
				CC.JHtxt_DAY[#CC.JHtxt_DAY+1] = CC.Day
				JY.Person[id]['游历次数'] = JY.Person[id]['游历次数'] + 1
				-- 领悟天赋	
			elseif rnd == 4 then
				local tfme = {}
				local tflv = 0
				if cx <= 2 then
					tflv = 4
				end
				if cx == 3 or cx == 4 then
					tflv = 3
				end
				if cx == 5 or cx == 6 then
					tflv = 2
				end

				for w = 1, #CC.Tiangtf do
					if CC.PTFSM[CC.Tiangtf[w]][5] == tflv then
						tfme[#tfme + 1] = CC.Tiangtf[w]
					end
				end
				local tf = tfme[math.random(#tfme)]

				for w = 1, 5 do
					if JY.Person[id]['天赋' .. w] == tf then
						break
					end
					if JY.Person[id]['天赋' .. w] == 0 then
						JY.Person[id]['天赋' .. w] = tf
						break
					end
				end
				local yltxt = yltime..JY.Person[id]['姓名'] .. '游戏江湖，观武切磋，领悟了天赋' .. CC.PTFSM[tf][1] .. '，已非吴下阿蒙'
				-- lib.Debug(yltxt)
				local testPath = "yltxt.txt"
				local testPath1 = "ylname.txt"
				appendWithTimestamp(testPath, yltxt)
				appendWithTimestamp(testPath1,id )
				--AddPersonAttrib(id, psx, 10)
				CC.JHtxt[#CC.JHtxt+1] = 4  --游历类型
				CC.JHtxt_ID[#CC.JHtxt_ID+1] = id --游历人物
				CC.JHtxt_SCENE[#CC.JHtxt_SCENE+1] = -1 --游历场景
				CC.JHtxt_ID1[#CC.JHtxt_ID1+1] = -1  --游历交互人物
				CC.JHtxt_PSX[#CC.JHtxt_PSX+1] = -1 --增加的属性类型
				CC.JHtxt_POINTS[#CC.JHtxt_POINTS+1] =tf+4000--增加属性的点数
				CC.JHtxt_YEAR[#CC.JHtxt_YEAR+1] = CC.Year
				CC.JHtxt_MONTH[#CC.JHtxt_MONTH+1] = CC.Month
				CC.JHtxt_DAY[#CC.JHtxt_DAY+1] = CC.Day
				JY.Person[id]['游历次数'] = JY.Person[id]['游历次数'] + 1
			elseif rnd == 5 then 
				cx = cx - 1
				local cxmenu = {'神话','宗师','豪侠','一流','二流','三流',}
				local yltxt = yltime..JY.Person[id]['姓名'] .. '闭关修炼，武学境阶提升到' ..cxmenu[cx].. '，名满江湖'
				-- lib.Debug(yltxt)
				local testPath = "yltxt.txt"
				local testPath1 = "ylname.txt"
				appendWithTimestamp(testPath, yltxt)
				appendWithTimestamp(testPath1,id )
				--AddPersonAttrib(id, psx, 10)
				CC.JHtxt[#CC.JHtxt+1] = 5  --游历类型
				CC.JHtxt_ID[#CC.JHtxt_ID+1] = id --游历人物
				CC.JHtxt_SCENE[#CC.JHtxt_SCENE+1] = -1 --游历场景
				CC.JHtxt_ID1[#CC.JHtxt_ID1+1] = -1  --游历交互人物
				CC.JHtxt_PSX[#CC.JHtxt_PSX+1] = cx + 1000 --增加的属性类型
				CC.JHtxt_POINTS[#CC.JHtxt_POINTS+1] = -1--增加属性的点数
				CC.JHtxt_YEAR[#CC.JHtxt_YEAR+1] = CC.Year
				CC.JHtxt_MONTH[#CC.JHtxt_MONTH+1] = CC.Month
				CC.JHtxt_DAY[#CC.JHtxt_DAY+1] = CC.Day
				JY.Person[id]['游历次数'] = JY.Person[id]['游历次数'] + 1
			end
		end
	end
	--lib.LoadPNG(91, spic[]*2, -1, -1, 1)
end


--新npc游历，不确定有无错误
function YouLi()
    -- 预计算常量数据（只需初始化一次）
    local psmenu = {
        {'攻击力', 10}, {'防御力', 10}, {'轻功', 10}, {'用毒能力', 10},
        {'暗器技巧', 10}, {'拳掌功夫', 10}, {'指法技巧', 10}, {'御剑能力', 10},
        {'耍刀技巧', 10}, {'特殊兵器', 10}
    }
    local yllx = {'游玩', '探险', '切磋武艺'}
    local Jingmainm = {'手少阴经', '手太阴经', '手厥阴经', '手少阳经', '手太阳经',
                       '手阳明经', '足少阴经', '足太阴经', '足厥阴经', '足少阳经',
                       '足太阳经', '足阳明经', '任脉', '督脉'}
    local cxmenu = {'神话','宗师','豪侠','一流','二流','三流'}
    local Jingmai = {
        CC.Sshaoyin, CC.Staiyin, CC.Sjueyin, CC.Sshaoyang, CC.Staiyang, CC.Syangming,
        CC.Zshaoyin, CC.Ztaiyin, CC.Zjueyin, CC.Zshaoyang, CC.Ztaiyang, CC.Zyangming,
        CC.Renmai, CC.Dumai
    }
    local qxnum_list = CC.qxnum or {}

    -- 创建快速查找表（替代数组遍历）
    local youliSet = {}
    for _, id in ipairs(CC.YOULI) do
        youliSet[id] = true
    end

    -- 日期字符串
    local yltime = numberToChinese(CC.Year)..'年'..numberToChinese(CC.Month)..'月'..numberToChinese(CC.Day)..'日'

    -- 缓存常用全局数据（减少全局表访问）
    local Person = JY.Person
    local Scene = JY.Scene
    local Teji = JY.Teji
    local Tiangtf = CC.Tiangtf or {}
    local PTFSM = CC.PTFSM or {}
    local MpRw = CC.MpRw or {}

    -- 预筛选有效NPC（避免多次随机）
    local validNPCs = {}
    for id = 1, 757 do
        if not youliSet[id] 
           and id ~= 591 and id ~= 600
           and Person[id]['姓名'] ~= '备用'
           and Person[id]['姓名'] ~= '标主占用'
           and Person[id]['姓名'] ~= '门主占用'
           and Person[id]['畅想分阶'] <= 6
           and not inteam(id) then
            table.insert(validNPCs, id)
        end
    end
    
    -- 随机选择最多50个NPC（避免无效尝试）
    math.randomseed(os.time())
    local selectedNPCs = {}
    local count = math.min(50, #validNPCs)
    for i = 1, count do
        local idx = math.random(1, #validNPCs)
        table.insert(selectedNPCs, validNPCs[idx])
        table.remove(validNPCs, idx)
    end

    -- 处理选中的NPC
    for _, id in ipairs(selectedNPCs) do
        local cx = Person[id]['畅想分阶']
        
        -- 判断上限状态（优化：减少全局访问）
        -- 经脉状态
        local qxnum, qxmax = 0, false
        for w = 1, 149 do
            if Person[id]['奇穴'..w] == 1 then
                qxnum = qxnum + 1
            end
        end
        qxmax = (qxnum == 149)
        
        -- 特技状态
        local tjnum, tjmax = 0, false
        for w = 1, 10 do 
            if Person[id]['秘技'..w] > 0 then 
                tjnum = tjnum + 1
            end
        end
        tjmax = (tjnum == 10)
        
        -- 天赋状态
        local tfnum, tfmax = 0, false
        for w = 1, 5 do 
            if Person[id]['天赋'..w] > 0 then 
                tfnum = tfnum + 1
            end
        end
        tfmax = (tfnum == 5)
        
        -- 境界状态
        local jjmax = (cx == 1)
        
        -- 计算游历概率（优化：简化逻辑）
        local rmenu = {8 - cx, 10 - cx, 60 - cx}
        if qxmax then rmenu[3] = 0 end
        if tjmax then rmenu[2] = 0 end
        if tfmax then rmenu[1] = 0 end
        
        local rnd
        if (qxmax and tjmax) or (qxmax and tfmax) or (tjmax and tfmax) then
            rnd = (not jjmax) and 5 or 1
        elseif cx <= 4 then
            -- 概率选择逻辑
            if math.random(100) <= rmenu[1] and not tfmax then
                rnd = 4
            elseif math.random(100) <= rmenu[2] and not tjmax then
                rnd = 3
            elseif math.random(100) <= rmenu[3] and not qxmax then
                rnd = 2
            else
                rnd = 1
            end
        else
            rnd = 1
        end

        -- 处理事件类型
        if rnd == 1 then
            -- 增加属性
            local rnd1 = math.random(#psmenu)
            local psx = psmenu[rnd1][1]
            local psx1 = math.random(psmenu[rnd1][2] / 2, psmenu[rnd1][2])
            local cj = math.random(0, 167)
            if (cj >= 143 and cj <= 150) then cj = 142 end
            local cjname = Scene[cj]["名称"]
            
            local yln = 1
            if Scene[cj]["场景类型"] == 10 then
                yln = 2
            elseif Scene[cj]["场景类型"] == 2 then
                yln = 3
            end
            
            local sjmp = math.random(0, 30)
            local sjmpid = math.random(#MpRw[sjmp])
            local drn1 = MpRw[sjmp][sjmpid]
            local name1 = Person[drn1]['姓名'] == '备用' and '神秘人' or Person[drn1]['姓名']
            
            local yltxt = yltime..Person[id]['姓名']..'在'..cjname..'与'..name1..yllx[yln]..'，增加'..psx..' '..psx1..'点'
            
            -- 记录日志
            CC.JHtxt[#CC.JHtxt+1] = 1
            CC.JHtxt_ID[#CC.JHtxt_ID+1] = id
            CC.JHtxt_SCENE[#CC.JHtxt_SCENE+1] = cj
            CC.JHtxt_ID1[#CC.JHtxt_ID1+1] = drn1
            CC.JHtxt_PSX[#CC.JHtxt_PSX+1] = rnd1
            CC.JHtxt_POINTS[#CC.JHtxt_POINTS+1] = psx1
            CC.JHtxt_YEAR[#CC.JHtxt_YEAR+1] = CC.Year
            CC.JHtxt_MONTH[#CC.JHtxt_MONTH+1] = CC.Month
            CC.JHtxt_DAY[#CC.JHtxt_DAY+1] = CC.Day
            
        elseif rnd == 2 then
            -- 打通经脉
            local kf = Person[id]['优先使用']
            local kflx = JY.Wugong[kf]['武功类型']
            local num = {}
            
            -- 根据武功类型添加对应经脉
            local mapping = {
                [1] = 1, [2] = 4, [3] = 2, 
                [4] = 5, [5] = 7, [6] = 12
            }
            if mapping[kflx] then
                num[#num+1] = mapping[kflx]
            end
            
            -- 添加其他经脉
            if Person[id]['用毒能力'] > 100 or Person[id]['攻击带毒'] > 50 then
                num[#num+1] = 3
            end
            if Person[id]['医疗能力'] > 100 then
                num[#num+1] = 11
            end
            
            -- 资质相关
            local zz = Person[id]['资质']
            if zz >= 80 then
                num[#num+1] = 14
            elseif zz > 30 and zz < 80 then
                num[#num+1] = 13
            elseif zz <= 30 then
                num[#num+1] = 9
            end
            
            -- 内力性质
            local nl = Person[id]['内力性质']
            if nl == 0 then
                num[#num+1] = 8
            elseif nl == 1 then
                num[#num+1] = 6
            elseif nl == 2 then
                num[#num+1] = 12
            end
            
            num[#num+1] = 10
            
            -- 找到可打通的经脉
            local jmmenu = {}
            for j = 1, #num do 
                local qx1 = num[j]
                for w = 1, #Jingmai[qx1] do 
                    local qx2 = Jingmai[qx1][w][8]
                    if Person[id]['奇穴'..qx2] == 0 then 
                        jmmenu[#jmmenu+1] = {qx1, w}
                    end
                end
            end
            
            -- 随机选择经脉
            local jm, qx, jmname
            if #jmmenu > 0 then 
                local sjqx = math.random(#jmmenu)
                jm = jmmenu[sjqx][1]
                qx = jmmenu[sjqx][2]
                jmname = Jingmai[jm][qx][1]
            else
                -- 备用选择逻辑...
            end
            
            local yltxt = yltime..Person[id]['姓名']..'闭关修炼打通了'..jmname..'，修为大增。'
            
            -- 记录日志
            CC.JHtxt[#CC.JHtxt+1] = 2
            CC.JHtxt_ID[#CC.JHtxt_ID+1] = id
            CC.JHtxt_SCENE[#CC.JHtxt_SCENE+1] = -1
            CC.JHtxt_ID1[#CC.JHtxt_ID1+1] = -1
            CC.JHtxt_PSX[#CC.JHtxt_PSX+1] = qx + 100
            CC.JHtxt_POINTS[#CC.JHtxt_POINTS+1] = jm + 1000
            CC.JHtxt_YEAR[#CC.JHtxt_YEAR+1] = CC.Year
            CC.JHtxt_MONTH[#CC.JHtxt_MONTH+1] = CC.Month
            CC.JHtxt_DAY[#CC.JHtxt_DAY+1] = CC.Day
            
        elseif rnd == 3 then
            -- 领悟秘技
            local teji = math.random(1, JY.TejiNum - 1)
            local tjname = Teji[teji]['名称']
            if tjname ~= '无' and tjname ~= '备用' then
                for w = 1, 10 do
                    if Person[id]['秘技'..w] == 0 then
                        Person[id]['秘技'..w] = teji
                        break
                    end
                end
                
                local yltxt = yltime..Person[id]['姓名']..'闭关修炼，领悟了秘技'..tjname..'，甚是羡煞旁人'
                
                -- 记录日志
                CC.JHtxt[#CC.JHtxt+1] = 3
                CC.JHtxt_ID[#CC.JHtxt_ID+1] = id
                CC.JHtxt_SCENE[#CC.JHtxt_SCENE+1] = -1
                CC.JHtxt_ID1[#CC.JHtxt_ID1+1] = -1
                CC.JHtxt_PSX[#CC.JHtxt_PSX+1] = -1
                CC.JHtxt_POINTS[#CC.JHtxt_POINTS+1] = teji + 3000
                CC.JHtxt_YEAR[#CC.JHtxt_YEAR+1] = CC.Year
                CC.JHtxt_MONTH[#CC.JHtxt_MONTH+1] = CC.Month
                CC.JHtxt_DAY[#CC.JHtxt_DAY+1] = CC.Day
            end
            
        elseif rnd == 4 then
            -- 领悟天赋
            local tflv = (cx <= 2) and 4 or (cx <= 4) and 3 or 2
            local tfme = {}
            
            for w = 1, #Tiangtf do
                if PTFSM[Tiangtf[w]][5] == tflv then
                    tfme[#tfme + 1] = Tiangtf[w]
                end
            end
            
            if #tfme > 0 then
                local tf = tfme[math.random(#tfme)]
                for w = 1, 5 do
                    if Person[id]['天赋'..w] == 0 then
                        Person[id]['天赋'..w] = tf
                        break
                    end
                end
                
                local yltxt = yltime..Person[id]['姓名']..'游戏江湖，观武切磋，领悟了天赋'..PTFSM[tf][1]..'，已非吴下阿蒙'
                
                -- 记录日志
                CC.JHtxt[#CC.JHtxt+1] = 4
                CC.JHtxt_ID[#CC.JHtxt_ID+1] = id
                CC.JHtxt_SCENE[#CC.JHtxt_SCENE+1] = -1
                CC.JHtxt_ID1[#CC.JHtxt_ID1+1] = -1
                CC.JHtxt_PSX[#CC.JHtxt_PSX+1] = -1
                CC.JHtxt_POINTS[#CC.JHtxt_POINTS+1] = tf + 4000
                CC.JHtxt_YEAR[#CC.JHtxt_YEAR+1] = CC.Year
                CC.JHtxt_MONTH[#CC.JHtxt_MONTH+1] = CC.Month
                CC.JHtxt_DAY[#CC.JHtxt_DAY+1] = CC.Day
            end
            
        elseif rnd == 5 then 
            -- 提升境界
            cx = cx - 1
            local yltxt = yltime..Person[id]['姓名']..'闭关修炼，武学境阶提升到'..cxmenu[cx]..'，名满江湖'
            
            -- 记录日志
            CC.JHtxt[#CC.JHtxt+1] = 5
            CC.JHtxt_ID[#CC.JHtxt_ID+1] = id
            CC.JHtxt_SCENE[#CC.JHtxt_SCENE+1] = -1
            CC.JHtxt_ID1[#CC.JHtxt_ID1+1] = -1
            CC.JHtxt_PSX[#CC.JHtxt_PSX+1] = cx + 1000
            CC.JHtxt_POINTS[#CC.JHtxt_POINTS+1] = -1
            CC.JHtxt_YEAR[#CC.JHtxt_YEAR+1] = CC.Year
            CC.JHtxt_MONTH[#CC.JHtxt_MONTH+1] = CC.Month
            CC.JHtxt_DAY[#CC.JHtxt_DAY+1] = CC.Day
        end
        
        -- 更新游历次数
        if rnd then
            Person[id]['游历次数'] = (Person[id]['游历次数'] or 0) + 1
        end
    end
end

--江湖传闻
function JH_Txt()
	lib.Debug('JH_Txt()'); -- 输出错误信息
    -- local maxh = linesCount(testPath)
	local page = 1
	local tb = 1

    local size = CC.DefaultFont * 0.7
    local title = '江湖传闻'
	local menu = {}
	local menu2 = {}
	local menu3 = {}
	local menuID = {}
	local QueryID = {}
	
	local px,py = lib.GetPNGXY(91,555*2)
	local px1,py1 = lib.GetPNGXY(91,557*2)
	local surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)
	
	local n,m = 0,0

	
	local QueryName = ''
	local YMENU = {}
	for i = #CC.JHtxt, 1, -1 do
		YMENU[#YMENU+1] = {CC.JHtxt[i],CC.JHtxt_ID[i],CC.JHtxt_SCENE[i],CC.JHtxt_ID1[i],CC.JHtxt_PSX[i],CC.JHtxt_POINTS[i],CC.JHtxt_YEAR[i],CC.JHtxt_MONTH[i],CC.JHtxt_DAY[i]}
		--CC.JHtxt = {} -- 1游事件类类型 1获得属性 2打通经脉 3领悟秘技 4领悟天赋
		--CC.JHtxt_ID = {} --2游历人物ID
		--CC.JHtxt_SCENE = {}  --3游历场景
		--CC.JHtxt_EVENT = {} --3游历事件 类型一{1,'游玩', 2'探险', 3'切磋武艺'}, --类型二{4闭关修炼} ,--类型三{5领悟秘技},--类型四{6领悟天赋}
		--CC.JHtxt_ID1 = {} --4游历交互人物
		--CC.JHtxt_PSX = {}  --5增加的属性类型1  1攻击力,2防御力 3轻功 4用毒能力  5暗器技巧 6拳掌功夫 7指法技巧 8御剑能力 9耍刀技巧 10特殊兵器'
							--			类型2	经脉+100
		--CC.JHtxt_POINTS= {} --6增加属性的点数  1001'手少阴经', 1002'手太阴经', 1003'手厥阴经', 1004'手少阳经', 1005'手太阳经',1006'手阳明经', 
											--1007'足少阴经', 1008'足太阴经', 1009'足厥阴经', 1010'足少阳经', 1011'足太阳经', 1012'足阳明经', 
											--1013'任脉', 1014'督脉'
		--CC.JHtxt_TIME = {} --游历时间 7 8 9年月日
		--把存到游历各项表中的各种数值补充到一个表里
	end
	for i = 1,#YMENU do 
		local ylwz = ''
		--游历时间
		local yltime = '天书'..numberToChinese(YMENU[i][7])..'年'..numberToChinese(YMENU[i][8])..'月'..numberToChinese(YMENU[i][9])..'日'..' '
		--游历类型
		local lx = YMENU[i][1]
		--游历人物
		local id = YMENU[i][2]
		local name = JY.Person[id]['姓名']
		--场景
		local cj = ''
		local cjname = ''
		local yln = 1
		local yllx = {'游玩', '探险', '切磋武艺'}
		if YMENU[i][3] >= 0 then 
			cj = YMENU[i][3]
			cjname = JY.Scene[cj]["名称"]
			if JY.Scene[cj]["场景类型"] == 10 then
				yln = 2
			elseif JY.Scene[cj]["场景类型"] == 2 then
				yln = 3
			end		
		end

		--互动ID
		local did = ''
		local dname = ''
		if YMENU[i][4] > 0 then 
			did = YMENU[i][4]
			dname = JY.Person[did]['姓名']
		end
		--属性
		--CC.JHtxt_PSX = {}  --增加的属性类型1  1攻击力,2防御力 3轻功 4用毒能力  5暗器技巧 6拳掌功夫 7指法技巧 8御剑能力 9耍刀技巧 10特殊兵器'
						--				类型2	经脉+100
		local psx = ''
		local psx1 = ''
		local psmenu = {{'攻击力', 10}, {'防御力', 10}, {'轻功', 10}, {'用毒能力', 10},
		{'暗器技巧', 10}, {'拳掌功夫', 10}, {'指法技巧', 10}, {'御剑能力', 10},
		{'耍刀技巧', 10}, {'特殊兵器', 10}, }

		local Jingmainm = {'手少阴经', '手太阴经', '手厥阴经', '手少阳经', '手太阳经',
		'手阳明经', '足少阴经', '足太阴经', '足厥阴经', '足少阳经',
		'足太阳经', '足阳明经', '任脉', '督脉'}
		--颜色 Ｒ=red Ｇ=gold Ｂ=black  Ｒ Ｗ=whiteＯ=orange Ｌ=绿色 Ｚ= 紫色 "ＬＤ＜＞"Ｗ  Ｄ =蓝  ……
		local cl0 = 'Ｂ'
		local cl1 = 'Ｒ'  --1阶人物
		local cl2 = 'Ｇ'  --2阶人物	
		local cl3 = 'Ｚ'  --3阶人物
		local cl4 = 'Ｄ'  --4阶人物
		local cl5 = 'Ｌ'  --5阶人物
		local cl6 = 'Ｗ'  --6阶人物
		local cl7 = 'Ｏ'
		local cl8 = 'Ｂ'
		local cxfj = JY.Person[id]['畅想分阶']
		local colorme = {cl1,cl2,cl3,cl4,cl5,cl6}
		local fjcolor = colorme[cxfj]
		local Jingmai = {CC.Sshaoyin, CC.Staiyin, CC.Sjueyin, CC.Sshaoyang, CC.Staiyang, CC.Syangming, -- 1指，2剑，3毒，4拳，5刀，6阳，
						CC.Zshaoyin, CC.Ztaiyin, CC.Zjueyin, CC.Zshaoyang, CC.Ztaiyang, CC.Zyangming, -- 7特，8阴，9低资，10轻，11医，12调和，
						CC.Renmai, CC.Dumai} -- 13中资，14高资
		local jmname = ''
		if lx == 1 then 
			psx = psmenu[YMENU[i][5]][1]
			ylwz = yltime..fjcolor..name..cl0..'在'..cjname..'与'..dname..yllx[yln]..',增加'..cl6..psx..numberToChinese(YMENU[i][6])..cl0..'点'	
		elseif lx == 2 then 
			local n = YMENU[i][5] - 100
			local m = YMENU[i][6] - 1000
			--2 yltime..JY.Person[id]['姓名'] .. '闭关修炼打通了' .. jmname .. '，修为大增。'
			ylwz = yltime..fjcolor..name..cl0..'闭关修炼打通了'..cl1..Jingmainm[m] .. '的' .. Jingmai[m][n][1] ..cl0..'奇穴，修为大增。'
		elseif lx == 3 then 
			--3 yltime..JY.Person[id]['姓名'] .. '闭关修炼，领悟了秘技' .. tjmen[teji][1] .. '，甚是羡煞旁人'
			local tj = YMENU[i][6] - 3000
			ylwz = yltime..fjcolor..name..cl0..'闭关修炼，领悟了秘技'..cl1..JY.Teji[tj]['名称']..cl0..'，声名鹊起'
		elseif lx == 4 then 
			--yltime..JY.Person[id]['姓名'] .. '游戏江湖，观武切磋，领悟了天赋' .. CC.PTFSM[tf][1] .. '，已非吴下阿蒙'
			local tf = YMENU[i][6] - 4000
			ylwz = yltime..fjcolor..name ..cl0.. '观武切磋，领悟了天赋' ..cl1.. CC.PTFSM[tf][1] ..cl0.. '，名动江湖'
		elseif lx == 5 then 
			--local yltxt = yltime..JY.Person[id]['姓名'] .. '闭关修炼，武学境阶提升到' .. CC.PTFSM[tf][1] .. '，名满江湖'
			local pcx = YMENU[i][5] - 1000
			local cxmenu = {'神话','宗师','豪侠','一流','二流','三流'}
			ylwz = yltime..fjcolor..name ..cl0.. '闭关修炼，武学境阶提升到' ..cl1.. cxmenu[pcx] ..cl0.. '，威震武林'
		end	
		menu[#menu+1] = ylwz
	end

	local menu4 = {}
	for i = #CC.JHtxt_ID, 1, -1 do
		menuID[#menuID+1] = CC.JHtxt_ID[i]
	end
	for i = 1,JY.PersonNum - 1 do  
		--if JY.Person[i]['畅想分阶'] <= 4 and inteam(i) == false then 
			--Pmenu[#Pmenu+1] = i --收集一流及以上人物的编号
		--end
		for j = 1,#menuID do
			if menuID[j] == i then 
				menu2[#menu2+1] = menuID[j]
				menu4[#menu4+1] = {menuID[j],j}
				--lib.Debug(JY.Person[menuID[j]]['姓名']..'游历位置'..j)
			end
		end
	end
	--menu3 = tableunique(menu2,true,)
	--去重
	local menu0 =  removeDuplicates(menu2)
	for i,v in ipairs(menu0) do 
		menu3[#menu3+1] = v
		--lib.Debug('存到menu3中的值'..v)
	end
	
	local n,m,m1 = 0,0,0
	--计算
	local pw = 5
	local ph = 15

	local lb = 0 
	local pg = 1
	local pid = 0
	local maxh = 21
	local fy, fymax = 0, 0
	local Query = 0
    while true do
		if JY.Restart == 1 then
			break
		end
		ClsN()	
		local line = math.modf(#menu3/pw) --总行数
		local page1 = math.ceil(#menu3/(pw*ph)) --总页数
		
		lib.LoadSur(surid, 0, 0)
		lib.LoadPNG(91, 191 * 2, 0, 0, 1)
		lib.LoadPNG(91, 555 * 2, CC.ScreenW/2-px/2, CC.ScreenH/2-py/2, 1)
		lib.LoadPNG(91, 557 * 2,CC.ScreenW/2-px/2-px1,CC.ScreenH/2-py/2, 1)
		lib.LoadPNG(91, 38 * 2, CC.ScreenW/2-px/2, CC.ScreenH/2-py/2, 1)
		DrawString(CC.ScreenW / 2 -size*4 , CC.ScreenH/50, title, C_RED, size * 2)
		--DrawString(CC.ScreenW - size * 15, CC.ScreenH - size * 3, '*只显示最新的三十条信息', C_RED, size * 1.2)
		DrawString(CC.ScreenW /1.5,  CC.ScreenH/30, '★按ESC退出', C_WHITE, size * 1)
		if pg == 1 and page1 == pg then --如果页为1，总页数也为1
			lb = #menu3 				--列表数 = 表总数
			--lib.Debug('计些lb1')
		elseif pg > 1 and pg == page1 then  --如果当前页大于1，且当前页=总页数
			lb = #menu3 - pw*ph*(page1-1) --计算余数
			--lib.Debug('计些lb2')
		elseif pg >= 1 and pg < page1 then  --如果当前页打大于1，且当前页小于总页数
			lb = pw*ph				--列表数 = 行X宽	
			--lib.Debug('计些lb3')
		end
		
		local row = 1

		if page == 1 then 
			if Query == 0 then
				--lib.Debug('page=1 Query == 0 '..'#menu3 ='..#menu3..' lb='..lb..' pg ='..pg..' page1 ='..page1)
				local h = 0
				local linemax = 100
				if linemax > #menu then 
					linemax = #menu
				end
				for i = 1 , linemax do					
					h = tjm(CC.ScreenW/1.85-px/2, CC.ScreenH/30 + size*1.385 * (row - fy), menu[i], C_BLACK, size , 40, size, fy - row + 1, maxh + 1 - row + fy)
					row = row + h
				end
				QueryName = '全部'
				--lib.Debug('row=='..row)
			elseif Query == pid then 
				--lib.Debug('page=1 Query == pid '..'#menu3 ='..#menu3..' lb='..lb..' pg ='..pg..' page1 ='..page1)
				--lib.Debug('pid =='..pid)
				QueryName = JY.Person[pid]['姓名']
				for i = 1, #menu4 do	
					local yline = menu4[i][2]
					local h = 0
					if menu4[i][1] == pid then  				
						h = tjm(CC.ScreenW/1.85-px/2, CC.ScreenH/30 + size*1.385 * (row - fy), menu[yline], C_BLACK, size , 40, size, fy - row + 1, maxh + 1 - row + fy)
						row = row + h
						--lib.Debug('row1=='..row)
					end
				end
			end
			DrawString(CC.ScreenW / 1.8 -px/2 - string.len(QueryName)/4*size , CC.ScreenH/30, QueryName, C_RED, size*1.2)
		elseif page == 2 then 
			--lib.Debug('page=2 '..'#menu3 ='..#menu3..' lb='..lb..' pg ='..pg..' page1 ='..page1)
			--lib.Background(CC.ScreenW /2-px/2,CC.ScreenH/2-py/2,CC.ScreenW /2+px/2,CC.ScreenH/2+py/2,0)
			local star = 1
			lib.LoadPNG(91, 558 * 2, CC.ScreenW/2-px/2, CC.ScreenH/2-py/2, 1)
			for i = 1,lb do
				local color = C_WHITE1 
				if tb == i then 
					color = C_RED
				end
				local id = menu3[i+(pg-1)*lb]
				pid = menu3[tb + (pg - 1) * lb]
				--lib.Debug('pid='..pid)
				local pname = JY.Person[id]['姓名'] 
				lib.Background(CC.ScreenW /1.7-px/2 +size*6*(n)-size,CC.ScreenH/15 +size*2*(m)-size/2,CC.ScreenW /1.7-px/2 +size*6*(n)+size*4,CC.ScreenH/15 +size*2*(m)+size,0)
				DrawString(CC.ScreenW /1.7-px/2 +size*6*(n),  CC.ScreenH/17.5 +size*2*(m), pname, color, size * 1)
				if JY.Person[id]['游历次数'] > 0 then 
					DrawString(CC.ScreenW /1.7-px/2 +size*6*(n)-size,  CC.ScreenH/17.5 +size*2*(m)-size/3 , JY.Person[id]['游历次数'], M_DeepSkyBlue, size * 0.8)
				end
				n = n + 1
				if n == pw then 
					n = 0
					m = m + 1
				end
			end
			n = 0
			m = 0
		end
		if row > maxh then
			fymax = limitX(row - maxh - 1, 0)
		else
			fymax = 0
		end
		if 	fymax > 0  then 
			lib.LoadPNG(91,124*2,CC.ScreenW/1.95-px/2,CC.ScreenH/1.2,1) 
		end	
		if fy > 0 then 
			lib.LoadPNG(91,127*2,CC.ScreenW/1.95-px/2,CC.ScreenH/10,1) 
		end
    	ShowScreen()
		lib.Delay(CC.Frame)
		local keypress, ktype, mx, my = WaitKey(1)
		lib.Delay(CC.Frame);
		if keypress == VK_ESCAPE or ktype == 4 then
			if page == 2 then 
				page = 1
				fy = 0
				fymax = 0
			else
				if Query > 0 then 
					Query = 0
					fy = 0
					fymax = 0
					row = 0
				else
					return 0
				end
			end
		elseif keypress == VK_RETURN or keypress == VK_SPACE then 
			PlayWavE(77)
			if page == 1 then 
				page = 2
				row = 1
				fy = 0
				fymax = 0
			elseif page == 2 then 
				Query = pid
				page = 1
			end	
		elseif keypress == VK_UP or ktype == 6 then
			PlayWavE(77)
			if page == 1 then 
				fy = fy - 1
				if fy < 0 then
					fy = 0
				end	
			else
				if tb - pw >= 1 then
                    tb = tb - pw
                else
                    if pg > 1 then                    
                        pg = pg - 1
                        tb = tb + pw * (ph - 1)
                    end
                end
			end		
		elseif keypress == VK_DOWN or ktype == 7 then
			PlayWavE(77)
			if page == 1 then 
				fy = fy + 1
				if fy > fymax then
					fy = fymax
				end
			else
				if tb + pw <= lb then 
					tb = tb + pw 
				else
					if pg < page1 then 
						pg = pg + 1
						tb = tb - pw*(ph-1)
					end
				end
			end
		elseif keypress == VK_LEFT then
			PlayWavE(77)
			if page == 2 then 
				tb = tb - 1
				if tb < 1 then 
					tb = 1
				end
			end
		elseif keypress == VK_RIGHT then
			PlayWavE(77)
			if page == 2 then 
				tb = tb + 1
				if tb > lb then
					if pg < page1 then  
						pg = pg + 1
						tb = 1
					else
						tb = lb 
					end
				end
			end
		else
			if page == 1 then 
				local pd = false 
				--CC.ScreenW / 1.8 -px/2 - string.len(QueryName)/4*size , CC.ScreenH/30,
				--lib.LoadPNG(91, 557 * 2,CC.ScreenW/2-px/2-px1,CC.ScreenH/2-py/2, 1)
				if mx > CC.ScreenW/2-px/2-px1 and mx < CC.ScreenW/2-px/2 and my > CC.ScreenH/2-py/2 and my < CC.ScreenH/2-py/2 + py1 and ktype == 3 then 
					PlayWavE(77)					
					page = 2
					row = 1
					fy = 0
					fymax = 0
				end
			end
			if page == 2 then 
				local pd1 = false
				for i = 1,lb do
					--lib.Background(CC.ScreenW /1.7-px/2 +size*6*(n)-size,CC.ScreenH/15 +size*2*(m)-size/2,CC.ScreenW /1.7-px/2 +size*6*(n)+size*4,CC.ScreenH/15 +size*2*(m)+size,0)
					if mx > CC.ScreenW /1.7-px/2 +size*6*(n)-size and mx < CC.ScreenW /1.7-px/2 +size*6*(n)+size*4 and my > CC.ScreenH/15 +size*2*(m)-size/2 and my < CC.ScreenH/15 +size*2*(m)+size then 
						tb = i 
						pd1 = true 
						break
					end
					n = n + 1
                    if n == pw then
                        n = 0
                        m = m + 1
                    end
				end
				n = 0
                m = 0
				if pd1 == true and ktype == 3 then 
					PlayWavE(77)
					Query = pid
					page = 1
				end
			end
		end
	end
end

---阿拉伯数字转中文大写
function numberToChinese(num)
    -- 检查是否为数字
    if type(num) ~= "number" then
        return "输入不是有效的数字"
    end

    -- 处理负数
    local sign = ""
    if num < 0 then
        sign = "负"
        num = -num
    end

    -- 中文数字表
    local digits = {"零", "一", "二", "三", "四", "五", "六", "七", "八", "九"}
    -- 中文单位表（万以下）
    local units = {"", "十", "百", "千"}
    -- 中文节单位表（万以上）
    local sectionUnits = {"", "万", "亿", "兆", "京", "垓", "秭", "穰", "沟", "涧", "正", "载"}

    -- 处理整数部分
    local intPart = math.floor(num)
    -- 处理小数部分
    local decimalPart = math.floor((num - intPart) * 100 + 0.5) -- 保留两位小数

    -- 将数字按四位一节分割
    local function splitNumber(n)
        local sections = {}
        local str = tostring(n)
        local len = #str
        local pos = 1
        while pos <= len do
            local start = math.max(1, len - pos - 3 + 1)
            local section = tonumber(string.sub(str, start, len - pos + 1))
            table.insert(sections, 1, section)
            pos = pos + 4
        end
        return sections
    end

    -- 将四位数字转换为中文
    local function sectionToChinese(section)
        if section == 0 then
            return digits[0 + 1]
        end
        local result = ""
        local sectionStr = tostring(section)
        local len = #sectionStr
        local prevZero = false
        for i = 1, len do
            local digit = tonumber(string.sub(sectionStr, i, i))
            local pos = len - i
            if digit == 0 then
                if not prevZero and i < len then
                    result = result .. digits[digit + 1]
                    prevZero = true
                end
            else
                result = result .. digits[digit + 1] .. units[pos + 1]
                prevZero = false
            end
        end
        return result
    end

    -- 处理整数部分转换
    local intResult = ""
    if intPart == 0 then
        intResult = digits[0 + 1]
    else
        local sections = splitNumber(intPart)
        local sectionCount = #sections
        local prevZeroSection = false
        for i = 1, sectionCount do
            local section = sections[i]
            if section == 0 then
                if not prevZeroSection and i < sectionCount then
                    intResult = intResult .. digits[0 + 1]
                    prevZeroSection = true
                end
            else
                intResult = intResult .. sectionToChinese(section) .. sectionUnits[sectionCount - i + 1]
                prevZeroSection = false
            end
        end
    end

    -- 处理小数部分转换
    local decimalResult = ""
    if decimalPart > 0 then
        decimalResult = "点"
        local decimalStr = string.format("%02d", decimalPart)
        for i = 1, #decimalStr do
            local digit = tonumber(string.sub(decimalStr, i, i))
            decimalResult = decimalResult .. digits[digit + 1]
        end
    end

    return sign .. intResult .. decimalResult
end

function clearLogFile(filename)
    local success, err = os.remove(filename)
    if not success then
        lib.Debug("删除文件失败: " .. (err or "未知错误"))
        return false
    end
    return true
end


-- 1. 基础写入函数 (覆盖模式)
function writeToFile(filePath, content)
    local file, err = io.open(filePath, "w")
    if not file then 
		return false, err 
	end
    file:write(content)
    file:close()
    return true
end

-- 2. 基础读取函数
function readFromFile(filePath)
    local file, err = io.open(filePath, "r")
    if not file then 
		return nil, err 
	end
    local content = file:read("*a")
    file:close()
    return content
end

-- 3. 追加写入函数
function appendToFile(filePath, content)
    local file, err = io.open(filePath, "a")
    if not file then 
		return false, err 
	end
    file:write(content)
    file:close()
    return true
end

-- 4. 读取指定行数
function readLines(filePath, startLine, endLine)
    local lines = {}
    local file, err = io.open(filePath, "r")
    if not file then 
		return nil, err 
	end
    
    startLine = startLine or 1
    endLine = endLine or math.huge
    
    local currentLine = 0
    for line in file:lines() do
        currentLine = currentLine + 1
        if currentLine >= startLine and currentLine <= endLine then
            table.insert(lines, line)
        end
		--if endLine == 99 then 
		--	endLine = currentLine
		--end
        if currentLine > endLine then 
			break 
		end
    end
    
    file:close()
    return lines
end

-- 5. 按行写入
function writeLines(filePath, lines)
    local file, err = io.open(filePath, "w")
    if not file then return false, err end
    
    for _, line in ipairs(lines) do
        file:write(line, "\n")
    end
    
    file:close()
    return true
end

-- 6. 安全写入 (先写入临时文件再替换)
function safeWrite(filePath, content)
    local tempPath = filePath .. ".tmp"
    local success, err = writeToFile(tempPath, content)
    if not success then 
		return false, err 
	end
    
    os.remove(filePath)
    os.rename(tempPath, filePath)
    return true
end

-- 7. 带时间戳的追加写入
function appendWithTimestamp(filePath, content)
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")
	local yy = numberToChinese(CC.Year)..'年'
	local mm = numberToChinese(CC.Month)..'月'
	local tt = numberToChinese(CC.Day)..'日'
	local time = '天书'..yy..mm..tt
    local formattedContent = string.format("[%s] %s\n", time, content)	
    --return appendToFile(filePath, formattedContent)
	return appendToFile(filePath, formattedContent)
end

-- 8. 读取并过滤内容
function readAndFilter(filePath, pattern)
    local content, err = readFromFile(filePath)
    if not content then 
		return nil, err 
	end
    
    if not pattern then 
		return content 
	end
    local filtered = {}
    
    for line in content:gmatch("[^\n]+") do
        if line:match(pattern) then
            table.insert(filtered, line)
        end
    end
    
    return table.concat(filtered, "\n")
end

-- 9. 写入 JSON 格式
function writeJson(filePath, data)
    local json = require("json") -- 需要 JSON 库支持
    local content = json.encode(data)
    return writeToFile(filePath, content)
end

-- 10. 读取 JSON 格式
function readJson(filePath)
    local content, err = readFromFile(filePath)
    if not content then 
		return nil, err 
	end
    
    local json = require("json") -- 需要 JSON 库支持
    return json.decode(content)
end

--读取最大行行数
function linesCount(filePath)
    local file, err = io.open(filePath, "r")
    if not file then
        --print("无法打开文件: " .. (err or "未知错误"))
        return
    end

    local count = 0
    for _ in file:lines() do -- 逐行遍历，无需存储行内容
        count = count + 1
    end

    file:close()
    return count
end

--[[
-- 使用示例
local testPath = "example.txt"

-- 测试写入
writeToFile(testPath, "第一行内容\n第二行内容")

-- 测试追加
appendToFile(testPath, "\n追加的第三行")

-- 测试读取指定行
local lines = readLines(testPath, 2, 3)
for _, line in ipairs(lines) do
    lib.Debug("读取指定行:"..line)
end

-- 测试带时间戳的追加
appendWithTimestamp(testPath, "带时间戳的记录")

-- 测试过滤读取
local filtered = readAndFilter(testPath, "第三行")
lib.Debug("过滤结果:", filtered)
]]




-- 图片淡入淡出效果函数（独立实现，不依赖外部库）
-- 初始化淡入淡出效果
function imageFadeinit(imagePath, width, height)
    local imageData = assert(io.open(imagePath, "rb")):read("*a")
    return {
        data = imageData,
        width = width or 320,
        height = height or 240,
        alpha = 0,
        state = "fadeIn",
        duration = 1.0,
        timer = 0
    }
end

-- 更新淡入淡出状态
function imageFadeupdate(effect, dt)
    effect.timer = effect.timer + dt
    
    if effect.state == "fadeIn" then
        effect.alpha = math.min(1, effect.timer / effect.duration)
        if effect.alpha >= 1 then
            effect.state = "fadeOut"
            effect.timer = 0
        end
    elseif effect.state == "fadeOut" then
        effect.alpha = 1 - math.min(1, effect.timer / effect.duration)
        if effect.alpha <= 0 then
            effect.state = "fadeIn"
            effect.timer = 0
        end
    end
end

-- 渲染图片（模拟函数，实际需根据平台实现）
function imageFaderender(effect, x, y)
    -- 注意：此函数需要根据实际平台实现
    -- 这里仅作为示例，展示参数使用方式
    print(string.format(
        "Render image at (%d,%d) - Size: %dx%d, Alpha: %.2f",
        x or 0, y or 0, effect.width, effect.height, effect.alpha
    ))
end

-- 示例用法
function testFadeEffect()
    local effect = ImageFaderinit(CONFIG.PicturePath .. "bg01.png", 200, 150)
    
    -- 模拟30帧更新
    for i = 1, 30 do
        imageFade.update(effect, 1/30)
        imageFade.render(effect, 100, 100)
    end
end


--模式选择
function Moshixz()
	local zb  = {{CC.ScreenW/1.9057,CC.ScreenH/1.6587},{CC.ScreenW/2.2666,CC.ScreenH/1.6587},{CC.ScreenW/1.7107,CC.ScreenH/1.6587}}
	local x,y = lib.GetPNGXY(91,114*2)
	local x1,y1 = CC.ScreenW/2-x/2,CC.ScreenH/2+y
	local tb = 1
	local picmenu = {{114,116},{115,117},{205,206}}
	JY.Base["开局"] = -1
	while true do 
		if JY.Restart == 1 then
			break
		end
		ClsN()		
		lib.LoadPNG(91,84*2,-1,-1,1)
		for i = 1,#zb do
			--lib.LoadPNG(91,picmenu[i][1]*2,zb[i][1],zb[i][2],1)
			lib.LoadPNG(91,picmenu[i][1]*2,x1+(i-2)*x,y1,1)
			if tb == i then
				--lib.LoadPNG(91,picmenu[i][2]*2,zb[i][1],zb[i][2],1)
				lib.LoadPNG(91,picmenu[i][2]*2,x1+(i-2)*x,y1,1)
			end
		end
		ShowScreen()
		lib.Delay(CC.Frame)
		local X, ktype, mx, my = lib.GetKey();	
		if X == VK_ESCAPE or ktype == 4 then
			--Cls()
			--return TitleSelection()
			
			--Menu_Exit()
		elseif X == VK_SPACE or X == VK_RETURN then
			if tb == 1 then
				return Mpzjmenu() --门派主角
			elseif tb == 2 then
				return firstmenu() --天书畅想
			elseif tb == 3 then
				return TSzjmenu() --特殊主角
			end
		elseif X == VK_LEFT or X == VK_UP then
			tb = tb - 1
			if tb < 1 then
				tb = 3
			end
			JY.Base["开局"] = tb - 1
		elseif X== VK_RIGHT or X == VK_DOWN then
			tb = tb + 1
			if tb > 3 then
				tb = 1
			end
			JY.Base["开局"] = tb - 1
		else
			local 	mxx = false							
			for i = 1,#zb do
				 --x1+(i-2)*x,y1
				if mx >= x1+(i-2)*x and mx <= x1+(i-2)*x + x and my >= y1 and my <= y1 + y then	
					tb = i
					mxx = true
					break
				end
			end
			if mxx == true and ktype == 3 then
				if tb == 1 then
					return Mpzjmenu()
				elseif tb == 2 then
					return firstmenu()
				elseif tb == 3 then
					return TSzjmenu()
				end
				JY.Base["开局"] = tb - 1
			end
		end
	end
end	

--门派主角
function Mpzjmenu()
	local size = CC.DefaultFont	
	local mpwz = {"少林寺","武当派","血刀门","丐帮","天龙寺","星宿派","天机宫","密宗","逍遥派","华山派"}
	local mp = {1,2,17,8,27,28,6,29,3,9}
	local ax,ay =CC.ScreenW/3.1627,CC.ScreenH/25.6
	local mpzb = {
					{CC.ScreenW/2.2368+ax,CC.ScreenH/8.93+ay},{CC.ScreenW/2.0238+ax,CC.ScreenH/3.6226+ay},{CC.ScreenW/1.9738+ax,CC.ScreenH/2.2722+ay},{CC.ScreenW/2.0029+ax,CC.ScreenH/1.6552+ay},{CC.ScreenW/2.183+ax,CC.ScreenH/1.3+ay},
					{CC.ScreenW/5.18,CC.ScreenH/8.93+ay},{CC.ScreenW/6.1,CC.ScreenH/3.6226+ay},{CC.ScreenW/6.6,CC.ScreenH/2.2722+ay},{CC.ScreenW/6.3,CC.ScreenH/1.6552+ay},{CC.ScreenW/5.02,CC.ScreenH/1.3+ay},					
				}
	local bsx = {400,549,550,551,548,555,554,547,609,43} --男半身
	local bsx1 = {400,302,559,56,66,175,562,557,609,569} --女半身
	local tb = 1
	local lb = 1
	local tb1 = 1
	local tb2 = 1

	local fkx,fky = CC.ScreenW/46.9,CC.ScreenH/51.2		
	local fy = 0
	local fymax = 0
	local star = 1		
	local pg = 1
	local xb = JY.Person[0]["性别"]
	local zm = JY.Base["周目"]
	local xbzb = {{CC.ScreenW/2.54,CC.ScreenH/1.28},{CC.ScreenW/1.85,CC.ScreenH/1.28}}
	local xbzb1 ={{CC.ScreenW/2.35,CC.ScreenH/1.12},{CC.ScreenW/1.93,CC.ScreenH/1.12}}
	local bs1 = CC.ScreenH/7.68 
	local bw = 0
	local bs = CC.ScreenH/5.12
	local bh = 0
	local hx,hy = lib.GetPNGXY(90,2*2,bs)
	while true do 
		if JY.Restart == 1 then
			break
		end
		ClsN()
		lib.LoadPNG(91, 110 * 2 , -1,-1, 1)

		for i = 1,#mpwz do
			local cl = C_WHITE
			local pbs = CC.ScreenH/2.56
			if i < 6 then
				if JY.Person[0]["性别"] == 0 then
					lib.LoadPNG(99,bsx[i]*2,mpzb[i][1]+fkx*2.4,mpzb[i][2]-fky,1,0,pbs)
				else
					lib.LoadPNG(99,bsx1[i]*2,mpzb[i][1]+fkx*2.4,mpzb[i][2]-fky,1,0,pbs)
				end
			else
				if JY.Person[0]["性别"] == 0 then
					lib.LoadPNG(99,bsx[i]*2,mpzb[i][1]-fkx*4,mpzb[i][2]-fky,1,0,pbs)
				else
					lib.LoadPNG(99,bsx1[i]*2,mpzb[i][1]-fkx*4,mpzb[i][2]-fky,1,0,pbs)
				end
			end

			if tb == i then
				cl = C_RED
				if i < 6 then
					lib.LoadPNG(91,112*2,mpzb[i][1]-fkx ,mpzb[i][2]-fky,1,0,bs1)
				else
					lib.LoadPNG(91,112*2,mpzb[i][1]-fkx*6.4 + bw,mpzb[i][2]-fky,1,0,bs1)
				end
			end
			local mpnm = mpwz[i]
			local znm = {}
			local namelen  = string.len(mpnm) / 2
			for j = 1,namelen do
				znm[j] = string.sub(mpnm, j * 2 - 1, j * 2)								
				DrawString(mpzb[i][1],mpzb[i][2]+(j-1)*size*0.8,znm[j],cl,size*0.9)
			end
		end
		if lb > 1 then				
			if JY.Person[0]["性别"] == 0 then	
				lib.LoadPNG(90,bsx[tb]*2,CC.ScreenW/2-hx/2,CC.ScreenH-hy*3/2.158+bh*2,1,0,bs)
			elseif JY.Person[0]["性别"] == 1 then
				lib.LoadPNG(90,bsx1[tb]*2,CC.ScreenW/2-hx/2,CC.ScreenH-hy*3/2.158+bh*2,1,0,bs)
			end
			local tid = 516+(tb-1)
			local me = {}
			local row = 0
			local maxh = 18
			local id = tid
			for i = 1,5 do 
				if JY.Person[id]['天赋'..i] > 0 then 
					local tf = JY.Person[id]['天赋'..i]
					if CC.PTFSM[tf] ~= nil then
						me[#me+1] = 'Ｌ'..CC.PTFSM[tf][1]
						me[#me+1] = 'Ｗ'..CC.PTFSM[tf][2]
						me[#me+1] = "Ｎ"
					end
				end
			end	
			for i = 1, #ZJZSJS do
				me[#me+1] = ZJZSJS[i]
				if i == #ZJZSJS then 
					me[#me+1] = "Ｎ"
				end
			end
			if tb < 6 then	
				local x1 = CC.ScreenW/2;   --70 100 ~ 470 500
				local y1 = CC.ScreenH/2;  
				local w1 = CC.ScreenW/3.4
				local h1 = CC.ScreenH/1.92 -- 
				lib.Background(x1/8,y1/4,x1/8+w1,y1/4+h1,50)
			else
				local x1 = CC.ScreenW/2;
				local y1 = CC.ScreenH/2;
				local w1 = CC.ScreenW/3.4
				local h1 = CC.ScreenH/1.92 --
				lib.Background(x1*2-x1/8-w1,y1/4,x1*2-x1/8,y1/4+h1,50)
			end
			for i = star, #me do
				local tfstr = me[i]
				local h = 0						
				if string.sub(tfstr,1,2) == "Ｎ" then
					--row = row + 1
				else
					if tb < 6 then
						h = tjm(CC.ScreenW/11.826, CC.ScreenW/11.826 + size*0.7 * (row-fy), tfstr, C_WHITE, size*0.7,13,size*0.7,fy-row,maxh+1-row+fy)
					else
						h = tjm(CC.ScreenW/1.5, CC.ScreenW/11.826 + size*0.7 * (row-fy), tfstr, C_WHITE, size*0.7,13,size*0.7,fy-row,maxh+1-row+fy)
					end
				end
				row = row + h
			end
			
			if row > maxh then
				fymax = limitX(row-maxh-1,0)
			else
				fymax = 0
			end
			if lb == 2 then 
				local xbwz = {"少侠","女侠"}
				
				--{425,617}
				--lib.LoadPNG(91,47*2,462,552,1)	
				local x1 = CC.ScreenW/2;
				local y1 = CC.ScreenH/2;
				lib.Background(x1/2+x1/10,y1+y1/2,x1+x1/2-x1/10,y1*2-y1/10,98)
				for r = 1,2 do
					local cl = C_WHITE
					if tb1 == r then
						cl = C_RED
					end		
					if tb == 9 then 
						tb1 = 2
					elseif  tb == 1 then 
						tb1 = 1
					end		
					lib.DrawStr(xbzb[r][1],xbzb[r][2],xbwz[r],cl,size*1.5, CONFIG.CurrentPath.."FONT/2.ttf",  0, 0)
				end	
			elseif lb == 3 then 
				local xbwz1 = {"返回","下一步"}	
				for r = 1,2 do
					local cl = C_WHITE
					if tb2 == r then
						cl = C_RED
					end					
					DrawString(xbzb1[r][1],xbzb1[r][2],xbwz1[r],cl,size*0.9)
				end	
			end
		end

		local zwkf = 0
		if zwkf == 1 then
			--tjm(CC.WX*425,CC.HY*386,"暂未开放",C_CYGOLD,CC.DefaultFont,11,CC.DefaultFont)
		end
		ShowScreen()
		lib.Delay(CC.Frame)
		local X, ktype, mx, my = lib.GetKey();
		if X == VK_ESCAPE or ktype == 4 then
			PlayWavE(77)
			if lb > 1 then 
				lb = lb - 1
			end
			--[[
			if lb == 3 then 
				lb = 2
				tb2 = 1
			elseif lb == 2 then
				lb = 1
				tb1 = 1
				JY.Person[0]["性别"] = 0
			elseif lb == 1 then
				]]
				Cls()				
				--StartMenu()
				--return Moshixz()
			--end
			if zwkf == 1 then
				zwkf = 0
			end
		elseif X == VK_SPACE or X == VK_RETURN then
			PlayWavE(77)
			if lb == 1 then				
				lb = 2
				if tb == 9 then 
					tb1 = 2
					JY.Person[0]["性别"] = 1
				end
			elseif lb == 2 then 
				lb = 3
				JY.Person[0]["性别"] = tb1 - 1
			elseif lb == 3 then
				if tb2 == 1 then
					lb = 2
				elseif tb2 == 2 then
					Cls()
					JY.Person[0]["姓名"]=CC.NewPersonName;					  				
					local zm = JY.Base["周目"]
					local nd = JY.Base["难度"] 
					local addkfnum  
					if nd < 4 then 
						addkfnum = 12+math.modf(zm/2)
					else
						addkfnum = 12+math.modf(zm/1)
					end 
					JY.Base["武功数量"] = JY.Base["武功数量"] + addkfnum
					if JY.Base["武功数量"] > 15 then 
						JY.Base["武功数量"] = 15
					end		
					--门派主角
					if tb > 0 then       
						JY.Base["畅想"] = 516 + tb - 1
						if JY.Person[0]["性别"] == 0 then
							JY.Person[0]["头像代号"] = JY.Person[JY.Base["畅想"]]["头像代号"]
							JY.Person[0]["半身像"] = bsx[tb]
							for i = 1, 5 do
								JY.Person[0]["出招动画帧数" .. i] = JY.Person[JY.Base["畅想"]]["出招动画帧数" .. i]
								JY.Person[0]["出招动画延迟" .. i] = JY.Person[JY.Base["畅想"]]["出招动画延迟" .. i]
								JY.Person[0]["武功音效延迟" .. i] = JY.Person[JY.Base["畅想"]]["武功音效延迟" .. i]
							end
						else
							JY.Person[0]["外号"] = "姑娘"
							JY.Person[0]["外号2"] = "丫头"
							JY.Person[0]["头像代号"] = 228	
							JY.Person[0]["半身像"] = bsx1[tb]		
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
					JY.Person[0]["生命最大值"] = 50
					JY.Person[0]["内力最大值"] = 500
					JY.Person[0]["生命"] = JY.Person[0]["生命最大值"]
					JY.Person[0]["内力"] = JY.Person[0]["内力最大值"]
					JY.Person[0]["攻击力"] = 80
					JY.Person[0]["防御力"] = 80
					JY.Person[0]["轻功"] = 80
					JY.Person[0]["医疗能力"] = 30
					JY.Person[0]["用毒能力"] = 30
					JY.Person[0]["解毒能力"] = 30
					JY.Person[0]["抗毒能力"] = 0
					JY.Person[0]["拳掌功夫"] = 40
					JY.Person[0]["指法技巧"] = 40
					JY.Person[0]["御剑能力"] = 40
					JY.Person[0]["耍刀技巧"] = 40
					JY.Person[0]["特殊兵器"] = 40
					JY.Person[0]["暗器技巧"] = 40
					JY.Person[0]["拳掌功夫"] = 50+zm
					JY.Person[0]["指法技巧"] = 50+zm
					JY.Person[0]["耍刀技巧"] = 50+zm
					JY.Person[0]["特殊兵器"] = 50+zm
					JY.Person[0]["拳法成长"] = 90
					JY.Person[0]["指法成长"] = 80
					JY.Person[0]["剑法成长"] = 50
					JY.Person[0]["刀法成长"] = 80
					JY.Person[0]["奇门成长"] = 90
					JY.Person[0]["门派"] = mp[tb]
					CC.kaijuwugong1 = JY.Person[0]["武功1"]
					CC.kaijuwugong2 = JY.Person[0]["武功2"]
					CC.kaijuwugong3 = JY.Person[0]["武功3"]
					CC.kaijuwugongx1 = JY.Person[0]["武功等级1"]
					CC.kaijuwugongx2 = JY.Person[0]["武功等级2"]
					CC.kaijuwugongx3 = JY.Person[0]["武功等级3"] 		
					break
				end
			end
		elseif X == VK_UP then
			PlayWavE(77)
			if lb == 1 then
				tb = tb - 1
				if tb < 1 then
					tb = #mpwz
				end
			end
		elseif X == VK_DOWN  then
			PlayWavE(77)
			if lb == 1 then
				tb = tb + 1
				if tb > #mpwz then
					tb = 1 
				end
			end
		elseif X == VK_LEFT then
			PlayWavE(77)
			if lb == 1 then
				tb = tb + 5 
				if tb > #mpwz then
					tb = 1
				end
			elseif lb == 2 then
				tb1 = tb1 - 1
				if tb1 < 1 then
					tb1 = 2
				end
				if tb == 1 and tb1 == 2 then
					tb1 = 1
				end
				if tb == 9 and tb1 == 1 then
					tb1 = 2
				end
				JY.Person[0]["性别"] = tb1 - 1
			elseif lb == 3 then 
				tb2 = tb2 - 1
				if tb2 < 1 then 
					tb2 = 2
				end
			end	
		elseif X == VK_RIGHT then
			PlayWavE(77)
			if lb == 1 then
				tb = tb - 5 
				if tb < 1 then
					tb = #mpwz
				end
				if tb > 2  then
					tb = 1
				end
			elseif lb == 2 then
				tb1 = tb1 + 1
				if tb1 > 2 then 
					tb1 = 1
				end
				if tb == 1 and tb1 == 2 then
					tb1 = 1
				end
				if tb == 9 and tb1 == 1 then
					tb1 = 2
				end
				JY.Person[0]["性别"] = tb1 - 1
			elseif lb == 3 then 
				tb2 = tb2 + 1 
				if tb2 > 2 then 
					tb2 = 1
				end
			end	

		elseif X==VK_PGUP or ktype == 6 then
			PlayWavE(77)
			if lb == 2 then
				fy = fy - 1
				if fy < 0 then 
					fy = 0
				end	
			end
		elseif X==VK_PGDN or ktype == 7 then
			PlayWavE(77)
			if lb == 2 then
				fy = fy + 1
				if fy > fymax then
					fy = fymax 
				end
			end
		else
			local cot = false
			local cot1 = false
			if lb == 1 then
				for i = 1,10 do
				--for i = 1,#mpzb do
					local mbx = mpzb[i][1]
					local mby = mpzb[i][2]
					local mbw,mbh = CC.ScreenH/6.18, CC.ScreenH/8.44
					if i > 5 then					
						if mx >= mbx -  mbw and mx <= mbx  and my >= mby and my <= mby + mbh then
							cot = true
							tb = i
							break
						end
					else
						if mx >= mbx and mx <= 	mbx + mbw and my >= mby and my <= mby + mbh then
							cot = true
							tb = i
							break
						end
					end	
				end
				if cot == true and ktype == 3 then
					lb = 2 
				end
			elseif lb == 2 then 
				for i = 1,#xbzb do
					local xbbx = xbzb[i][1]
					local xbby = xbzb[i][2]
					local xbw,xbh = CC.ScreenW/17,CC.ScreenH/15
					if mx >= xbbx and mx <= xbbx + xbw and my >= xbby and my <= xbby + xbh then
						cot1 = true
						if tb == 9 then 
							tb1 = 2
						elseif tb == 1 then 
							tb1 = 1
						else
							tb1 = i
						end

						break
					end
				end 
				if cot1 == true and ktype == 3 then 
					if tb1 == 1 then
						JY.Person[0]["性别"] = 0 
						lb = 3
					elseif tb1 == 2 then
						JY.Person[0]["性别"] = 1	
						lb = 3
					end
				end
			elseif lb == 3 then
				local cot2 = false
				for i = 1,#xbzb1 do
					local xbbx = xbzb1[i][1]
					local xbby = xbzb1[i][2]
					local xbw,xbh = CC.ScreenW/19.15,CC.ScreenH/48
					if mx >= xbbx and mx <= xbbx + xbw and my >= xbby and my <= xbby + xbh then
						cot2 = true
						tb2 = i
						break
					end
				end
				if cot2 == true and ktype == 3 then
					if tb2 == 1 then
						lb = 2
					elseif tb2 == 2 then
						Cls()
						JY.Person[0]["姓名"]=CC.NewPersonName;					  				
						local zm = JY.Base["周目"]
						local nd = JY.Base["难度"] 
						local addkfnum  
						if nd < 4 then 
							addkfnum = 12+math.modf(zm/2)
						else
							addkfnum = 12+math.modf(zm/1)
						end 
						JY.Base["武功数量"] = JY.Base["武功数量"] + addkfnum
						if JY.Base["武功数量"] > 15 then 
							JY.Base["武功数量"] = 15
						end		
						--门派主角
						if tb > 0 then       
							JY.Base["畅想"] = 516 + tb - 1
							if JY.Person[0]["性别"] == 0 then
								JY.Person[0]["头像代号"] = JY.Person[JY.Base["畅想"]]["头像代号"]
								JY.Person[0]["半身像"] = bsx[tb]
								for i = 1, 5 do
									JY.Person[0]["出招动画帧数" .. i] = JY.Person[JY.Base["畅想"]]["出招动画帧数" .. i]
									JY.Person[0]["出招动画延迟" .. i] = JY.Person[JY.Base["畅想"]]["出招动画延迟" .. i]
									JY.Person[0]["武功音效延迟" .. i] = JY.Person[JY.Base["畅想"]]["武功音效延迟" .. i]
								end
							else
								JY.Person[0]["外号"] = "姑娘"
								JY.Person[0]["外号2"] = "丫头"
								JY.Person[0]["头像代号"] = 228	
								JY.Person[0]["半身像"] = bsx1[tb]		
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
						JY.Person[0]["生命最大值"] = 50
						JY.Person[0]["内力最大值"] = 500
						JY.Person[0]["生命"] = JY.Person[0]["生命最大值"]
						JY.Person[0]["内力"] = JY.Person[0]["内力最大值"]
						JY.Person[0]["攻击力"] = 80
						JY.Person[0]["防御力"] = 80
						JY.Person[0]["轻功"] = 80
						JY.Person[0]["医疗能力"] = 30
						JY.Person[0]["用毒能力"] = 30
						JY.Person[0]["解毒能力"] = 30
						JY.Person[0]["抗毒能力"] = 0
						JY.Person[0]["拳掌功夫"] = 40
						JY.Person[0]["指法技巧"] = 40
						JY.Person[0]["御剑能力"] = 40
						JY.Person[0]["耍刀技巧"] = 40
						JY.Person[0]["特殊兵器"] = 40
						JY.Person[0]["暗器技巧"] = 40
						JY.Person[0]["拳掌功夫"] = 50+zm
						JY.Person[0]["指法技巧"] = 50+zm
						JY.Person[0]["耍刀技巧"] = 50+zm
						JY.Person[0]["特殊兵器"] = 50+zm
						JY.Person[0]["拳法成长"] = 90
						JY.Person[0]["指法成长"] = 80
						JY.Person[0]["剑法成长"] = 50
						JY.Person[0]["刀法成长"] = 80
						JY.Person[0]["奇门成长"] = 90
						JY.Person[0]["门派"] = mp[tb]
						CC.kaijuwugong1 = 0
						CC.kaijuwugong2 = 0
						CC.kaijuwugong3 = 0
						CC.kaijuwugongx1 = 0
						CC.kaijuwugongx2 = 0
						CC.kaijuwugongx3 = 0	
						break
					end
				end
			end
		end
	end
end

--天赋列表
function TF_table(num)
    local tb = 1
	local tb1 = 0
    local size = CC.DefaultFont*0.7
    local pg = 1
    local menu = {}
	local w1,h1 = lib.GetPNGXY(91,139*2)
    local w = math.modf(w1/size)
	local zm = JY.Base["周目"]
	local hh1 = 0
	local zmtf = math.ceil(zm/4)
	local tfid = 0
	local x,y = CC.ScreenW/4,CC.ScreenH/9
	local n,m = 0,0
	local x1 = x*2-x/3
	local y1 = y*3/2+y/3+y/10
	local yy = h1*3/2
	local xx = w1*8/7
	local fymenu = {'上一页','下一页','确  定','删  除','返  回','跳 过'}
	local tfmax = 0
	local tfn = 0
	local cxn = JY.Base['畅想']
	if JY.Base["畅想"] == 757 then
		tfmax = 2
	elseif CC.PTF[cxn] ~= nil then 
		for i,v in pairs(CC.PTF[cxn]) do 
			if v == 1 then 
				tfn = tfn + 1
			end
		end
	end 
	if 3 - tfn > 0 then 
		tfmax =  3 - tfn
	end

	local xzmenu = 0
	local xzid = '无'
	local xzsm = ''
	local xztf = 0
	local xzme = {}
	
	local sme = 0
	local smenu = {}
	for i = 1,#CC.TGJL do
        menu[#menu+1] = {CC.TGJL[i],1}
    end
		
    if #menu <= 0  then
        return   
    end

	local lbnum = 54  --一页总数
	local rwnum = 6 --一行数总

	local lb = lbnum --第一页总数
	local hnum = lbnum/rwnum --一页几行	
	local num = math.modf(#menu/lbnum) --计算当前菜单一页总页数  

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

		if lb > #menu then --如果第一页容纳总数大于菜单总项数
			lb = #menu     --当前页面总数 = 菜单总项数
		end
		if pg < num then   --如果当前面 < 总页数
			lb = lbnum     --当前页容纳总数 = 第一页总数
		elseif pg == num then --如果当前面 = 总页数
			lb = #menu - (num-1)*lbnum --当前页面数 = 计算后的值
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
			fymenu = {'上一页','下一页','确  定','删  除','下一步','跳 过'}
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
			DrawString(x1/12+size*9,CC.ScreenH-size*7,'无法选择更多天赋，请点击【下一步】进入游戏',C_RED,size*2)
		end
        ShowScreen()
        lib.Delay(CC.BattleDelay)
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
				if #xzme >= tfmax then
					for i = 1,#xzme do 
						local rw = JY.Base['畅想']
						SetTF(rw,xzme[i],1)
						SetTF(0,xzme[i],1)														
					end	
					break	
				else
					tb1 = 0
				end
			elseif tb1 == 6 then 
				break
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
					if #xzme >= tfmax then 
						for i = 1,#xzme do 
							local rw = JY.Base['畅想']
							SetTF(rw,xzme[i],1)	
							SetTF(0,xzme[i],1)												
						end	
						break					
					else
						tb1 = 0
					end
				elseif tb1 == 6 then 
					break
				end	
			end
        end
    end
end

--个人新对话
function say(s,pid,flag,name)          
	if JY.Restart == 1 then
		return
	end
    local picw=130;       --最大头像图片宽高
	local pich=130;
	local talkxnum=24;         --对话一行字数
	local talkynum=3;          --对话行数
	local dx=CC.ScreenW/680;
	local dy=CC.ScreenH/384;
    local boxpicw=picw+CC.ScreenW/136;
	local boxpich=pich+CC.ScreenH/76.8;
	local boxtalkw=talkxnum*CC.DefaultFont+CC.ScreenW/136;
	local boxtalkh=boxpich-CC.ScreenH/28.44;
	local headid = pid;
	local mp = nil 
	local mplogo = nil 
	if pid < 800 then 
		 mp = MP_name(pid)..MP_zw(pid)	
		 mplogo = 240+JY.Person[pid]["门派"]
	else
		mp = "江湖闲人"
		mplogo = 240
	end

	if name == nil then 
		headid = JY.Person[pid]["半身像"] 
	end
	name=name or JY.Person[pid]["姓名"]
    local talkBorder=(pich-talkynum*CC.DefaultFont)/(talkynum+1)-5;
	--显示头像和对话的坐标
	local xy={ [0]={headx=dx,
					heady=dy,
					talkx=dx+boxpicw+2,
					talky=dy+27,
					namex=dx+boxpicw+2,
					namey=dy,
					showhead=1
					},--左上

				   {headx=CC.ScreenW-1-dx-boxpicw-CC.ScreenW/17,
				   	heady=CC.ScreenH-dy-boxpich+CC.ScreenH/19.2,
					talkx=CC.ScreenW-1-dx-boxpicw-boxtalkw-CC.ScreenW/9.5,
					talky= CC.ScreenH-dy-boxpich+CC.ScreenH/25.6,
					namex=CC.ScreenW-1-dx-boxpicw-CC.ScreenW/3.942,
					namey=CC.ScreenH-dy-boxpich-CC.ScreenH/25.6,
					showhead=1
					},--右下

				   {headx=dx,
				   	heady=dy,
				   	talkx=dx+boxpicw-CC.ScreenW/31.628,
				   	talky=dy+27,
					namex=dx+boxpicw+CC.ScreenW/680,
					namey=dy,
				   showhead=0
					},--上中 -- 
				   {headx=CC.ScreenW-1-dx-boxpicw,
				   	heady=CC.ScreenH-dy-boxpich,
					talkx=CC.ScreenW-1-dx-boxpicw-boxtalkw-2,
					talky= CC.ScreenH-dy-boxpich+27,
					namex=CC.ScreenW-1-dx-boxpicw-96,
					namey=CC.ScreenH-dy-boxpich,
					showhead=1
					},
				   {headx=CC.ScreenW-1-dx-boxpicw,
				   	heady=dy,
					talkx=CC.ScreenW-1-dx-boxpicw-boxtalkw-2,
					talky=dy+27,
					namex=CC.ScreenW-1-dx-boxpicw-96,
					namey=dy,
					showhead=1},--右上

				   {headx=dx+CC.ScreenW/20,
				   	heady=CC.ScreenH-dy-boxpich+CC.ScreenH/19.2,
					talkx=dx+boxpicw+2+CC.ScreenW/9.5,
					talky=CC.ScreenH-dy-boxpich+CC.ScreenH/25.6,
					namex=dx+boxpicw+CC.ScreenW/18.13333,
					namey=CC.ScreenH-dy-boxpich-CC.ScreenH/25.6,
				   	showhead=1
					}, --左下
			}
	if pid==0 then
	   if name ~= JY.Person[pid]["姓名"] then 
	      flag=1
	   else 
	      flag=5
	   end 
	else
	   flag=1
	end
	local tx = 0
	local ty = 0
	local bs = 100
	local bs1 = 60
	local tx,ty = lib.GetPNGXY(91,312*2)
	if xy[flag].showhead == 0 then
		headid = -1
	end

    lib.GetKey();

	local function readstr(str)
		local T1={"０","１","２","３","４","５","６","７","８","９"}
		local T2={{"Ｒ",C_RED},{"Ｇ",C_GOLD},{"Ｂ",C_BLACK},{"Ｗ",C_WHITE},{"Ｏ",C_ORANGE},{"Ｌ",LimeGreen},{"Ｄ",M_DeepSkyBlue},{"Ｚ",LightPurple}}
		local T3={{"Ｈ",CC.FontNameSong},{"Ｓ",CC.FontNameHei},{"Ｆ",CC.FontName}}
		--美观起见，针对不同字体同一行显示，需要微调ｙ坐标，以及字号
		--以默认的字体为标准，启体需下移，细黑需上移
		for i=0,9 do
			if T1[i+1]==str then return 1,i*50 end
		end
		for i=1,8 do
			if T2[i][1]==str then return 2,T2[i][2] end
		end
		for i=1,3 do
			if T3[i][1]==str then return 3,T3[i][2] end
		end
		return 0
	end

	local function mydelay(t)
		if t<=0 then return end
		lib.ShowSurface(0)
		lib.Delay(t)
	end
	
	local page, cy, cx = 0, 0, 0
	local color, t, font = C_WHITE, 0, CC.FontName

 
  	while string.len(s) >= 1 do
		lib.GetKey();
		if JY.Restart == 1 then
			break
		end
    	if page == 0 then
			  Cls()
			if headid >= 0 then
				local size = CC.FontSmall*1.5
				local w, h = lib.GetPNGXY(1, headid*2)
				local x = (picw - w) / 2
				local y = (pich - h) / 2
											
				lib.LoadPNG(90, headid*2, xy[flag].headx + x-CC.ScreenW/19.155, xy[flag].heady + y-CC.ScreenH/3.572, 1)
				lib.LoadPNG(91,312*2,CC.ScreenW/2-tx/2,CC.ScreenH-ty,1,0,bs)

				lib.LoadPNG(91,309*2,xy[flag].namex+CC.ScreenW/38.857,xy[flag].namey-CC.ScreenH/19.2,1,0,bs)	
				lib.LoadPNG(91,80*2,xy[flag].namex+CC.ScreenW/36.756,xy[flag].namey-CC.ScreenH/20.21,1,0,bs1)
				lib.LoadPNG(91,mplogo*2,xy[flag].namex+CC.ScreenW/36.756,xy[flag].namey-CC.ScreenH/20.21,1,0,bs1)

				lib.DrawStr(xy[flag].namex+size*4.5-string.len(mp)/4*size*0.7,xy[flag].namey-CC.ScreenH/21.943,mp,C_ORANGE,size*0.7,CC.FontName)	
				lib.DrawStr(xy[flag].namex+size*4.5-string.len(name)/4*size*0.75,xy[flag].namey-CC.ScreenH/51.2,name,M_DeepSkyBlue,size*0.75,CC.FontName)				
			end
			page = 1
		end
		local str
		str=string.sub(s,1,1)
		if str=='*' then
			--str='Ｈ'
			s=string.sub(s,2,-1)
		else
			if string.byte(s,1,1) > 127 then		--判断单双字符
				str=string.sub(s,1,2)
				s=string.sub(s,3,-1)
			else
				str=string.sub(s,1,1)
				s=string.sub(s,2,-1)
			end
		end
		--开始控制逻辑
		if str=='*' then
		elseif str=="Ｈ" then
			cx=0
			cy=cy+1
			if cy==3 then
				cy=0
				page=0
			end
		elseif str=="Ｐ" then
			cx=0
			cy=0
			page=0
		elseif str=="ｐ" then
			ShowScreen();
			--WaitKey();
			lib.Delay(50)
		elseif str=="ｗ" then
			ShowScreen();
			WaitKey();
			--lib.Delay(50)
		elseif str=="Ｎ" then
			s=JY.Person[pid]["姓名"]..s
		elseif str=="ｎ" then
			s=JY.Person[0]["姓名"]..s
		else
			local kz1,kz2=readstr(str)
			if kz1==1 then
				t=kz2
			elseif kz1==2 then
				color=kz2
			elseif kz1==3 then
				font=kz2
			else
				lib.DrawStr(xy[flag].talkx+CC.DefaultFont*cx+CC.ScreenW/272,
							xy[flag].talky+(CC.DefaultFont+talkBorder)*cy+talkBorder-CC.ScreenH/27.428,
							str,color,CC.DefaultFont,font,0,0, 305)
				mydelay(t)
				cx=cx+string.len(str)/2
				if cx==talkxnum then
					cx=0
					cy=cy+1
					if cy==talkynum then
						cy=0
						page=0
					end
				end
			end
		end
		--如果换页，则显示，等待按键
		if page==0 or string.len(s)<1 then
			ShowScreen();
			WaitKey();
			lib.Delay(CC.Frame)
		end

	end


	if JY.Restart == 1 then
		do return end
	end

	Cls();
end
function Yemu()
	if CC.TX['夜幕'] == 0 then 
		if CC.Shichen == 4 or CC.Shichen == 10 then 
			lib.LoadPNG(91,560*2,-1,-1,1)
		elseif CC.Shichen < 5 or CC.Shichen > 10  then 
			lib.LoadPNG(91,232*2,-1,-1,1)
		end
	end
end

--简易信息
function ShowStatus()
	--修改一些变量
	--lib.Debug('ShowStatus()'); -- 输出错误信息
	if CC.TX['战斗速度'] == 0 then 
		CC.BattleDelay = 30
	end
	if CC.TX['战斗速度'] == 1 then 
		CC.BattleDelay = 15
	end
	if CC.TX['战斗显血'] == 0 then 
		JY.HPDisplay = 1
	end	
	if CC.TX['战斗显血'] == 1 then 
		JY.HPDisplay = 0
	end
    -- JHtxt ()
    -- 比利
    -- 文字大小
    local size = CC.DefaultFont * 0.6
    -- 文字大小2
    local size2 = CC.DefaultFont * 0.55
    -- 生命坐标
    local x1, y1 = CC.ScreenW / 6.974, CC.ScreenH / 16.695
    -- 内力坐标
    local x2, y2 = CC.ScreenW / 6.974, CC.ScreenH / 16.695
    -- 头像坐标
    local x3, y3 = CC.ScreenW / 24.285, CC.ScreenH / 15.058
    -- 姓名坐标
    local x4, y4 = CC.ScreenW / 8.947, CC.ScreenH / 38.4
    -- 门派
    local x5, y5 = CC.ScreenW / 5.787, CC.ScreenH / 38.4
    -- 生命
    local sm = JY.Person[0]['生命']
    -- 内力
    local nl = JY.Person[0]['内力']
    -- 最大生命
    local smmax = JY.Person[0]['生命最大值']
    -- 最大内力
    local nlmax = JY.Person[0]['内力最大值']
    -- 头像标号
    local hid = JY.Person[0]['半身像']
    -- 姓名
    local name = JY.Person[0]['姓名']
    -- 门派
    local zm = JY.Person[0]['门派']
    -- 时间
    local weather = {{CC.Rain, "下雨", 294}, {CC.Snowy, "下雪", 295}, {CC.Foggy, "大雾", 296},
                     {CC.Sunny, "晴朗", 297}}
    local menu2 = {"一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"}
    local menu3 = {"初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十",
                   "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十",
                   "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"}
    local menu4 = {"一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二", "十三",
                   "十四", "十五", "十六", "十七", "十八", "十九", "二十", "廿一", "廿二", "廿三",
                   "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十", "三一", "三二", "三三",
                   "三四", "三五", "三六", "三七", "三八", "三九", "四十", "四一", "四二", "四三",
                   "四四", "四五", "四六", "四七", "四八", "四九", "五十", "六一", "六二", "六三",
                   "六四", "六五", "六六", "六一", "六一", "六一", "六一", "六一", "六一", "六一",
                   "六一", "六一", "六一", "六一", "六一", "六一"}
    local sc = {"子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"}
    local sc1 = {"一", "二", "三", "四"}
    local t = math.modf((lib.GetTime() - JY.LOADTIME) / 60000 + GetS(14, 2, 1, 4))
    local t1, t2, t3, t4, t5 = CC.Shichen, CC.Day, CC.Year, CC.Month, 1 -- 时，日，月,年，刻
    local tx, ty = CC.ScreenW / 2.229, CC.ScreenH / 30.72
    MMapName() -- 大地图场景名字
    if JY.Status == GAME_WMAP then
    else

    end
	Yemu()
    while t > 6 do -- 时
        t = t - 6
    end
    CC.JISHI = CC.JISHI + 1
    if CC.weat == 1 then
        lib.SetWeather(1)
    elseif CC.weat == 2 then
        lib.SetWeather(2)
    else
        lib.SetWeather(0)
    end
    if JY.Status == GAME_MMAP then
        if CC.JISHI > 60 then
            CC.JISHI = CC.JISHI - 60
            CC.Shichen = CC.Shichen + 1
			-- 游历 队友
			YouLi_Teammate()
        end
        if CC.WeatherCD > 0 then
            CC.WeatherCD = CC.WeatherCD - 10
            if CC.WeatherCD < 0 then
                CC.WeatherCD = 0
            end
        end
        if CC.TX['西域奇商'] > 0 then
            CC.TX['西域奇商'] = CC.TX['西域奇商'] - 10
            if CC.TX['西域奇商'] <= 0 then
                CC.TX['西域奇商'] = 0
                -- addevent(153,28,1,nil,1,nil)
                null(153, 28)
            end
        end
    else
        if CC.JISHI > 600 then
            CC.JISHI = CC.JISHI - 600
            CC.Shichen = CC.Shichen + 1
            -- 游历 队友
			YouLi_Teammate()
        end
        if CC.WeatherCD > 0 then
            CC.WeatherCD = CC.WeatherCD - 1
            if CC.WeatherCD < 0 then
                CC.WeatherCD = 0
            end
        end
        if CC.TX['西域奇商'] > 0 then
            CC.TX['西域奇商'] = CC.TX['西域奇商'] - 1
            if CC.TX['西域奇商'] <= 0 then
                CC.TX['西域奇商'] = 0
                null(153, 28)
            end
        end
    end
    if CC.Shichen < 12 and CC.Day == 1 and CC.WeatherCD == 0 then
        CC.weat = 4
        CC.WeatherCD = 7200
    end

    if CC.WeatherCD == 0 then -- 如果所有天气状态都是空值
        -- 春季
        if CC.Month == 1 or CC.Month == 2 or CC.Month == 3 then
            if Rnd(100) < 20 then
                CC.weat = 1
            elseif Rnd(100) < 40 then
                CC.weat = 2
            elseif Rnd(100) < 25 then
                CC.weat = 3
            else
                CC.weat = 4
            end
            -- 夏季
        elseif CC.Month == 4 or CC.Month == 5 or CC.Month == 6 then
            if Rnd(100) < 30 then
                CC.weat = 1
            elseif Rnd(100) < 20 then
                CC.weat = 3
            else
                CC.weat = 4
            end
            -- 秋季
        elseif CC.Month == 7 or CC.Month == 8 or CC.Month == 9 then
            if Rnd(100) < 20 then
                CC.weat = 1
            elseif Rnd(100) < 30 then
                CC.weat = 3
            else
                CC.weat = 4
            end
            -- 冬季	
        elseif CC.Month == 10 or CC.Month == 11 or CC.Month == 12 then
            if Rnd(100) < 20 then
                CC.weat = 1
            elseif Rnd(100) < 40 then
                CC.weat = 2
            elseif Rnd(100) < 25 then
                CC.weat = 3
            else
                CC.weat = 4
            end
        end
        CC.WeatherCD = math.random(5000, 8000)
    end
    while CC.Shichen > 12 do -- 日
        CC.Shichen = CC.Shichen - 12
        CC.Day = CC.Day + 1
		YouLi()
    end
    while CC.Day > 30 do -- 月
        CC.Day = CC.Day - 30
        CC.Month = CC.Month + 1
    end
    while CC.Month > 12 do -- 年
        CC.Month = CC.Month - 12
        CC.Year = CC.Year + 1
    end
    local YY = numberToChinese(CC.Year)
    local MM = menu2[CC.Month]
    local DD = menu3[CC.Day]
    local HH = sc[CC.Shichen]
    local Hwz = {"凌晨", "上午", "正午", "午后", "傍晚", "深夜"}
    if CC.Shichen == 3 then
        CC.Daytime = 1
    elseif CC.Shichen == 4 or CC.Shichen == 5 then
        CC.Daytime = 2
    elseif CC.Shichen == 6 or CC.Shichen == 7 then
        CC.Daytime = 3
    elseif CC.Shichen == 8 or CC.Shichen == 9 then
        CC.Daytime = 4
    elseif CC.Shichen == 10 then
        CC.Daytime = 5
    elseif CC.Shichen == 12 or CC.Shichen == 1 or CC.Shichen == 2 or CC.Shichen == 11 then
        CC.Daytime = 6
    end
    if CC.TX['西域奇商'] == 0 and CC.weat == 4 then
        if Rnd(100) < 30 then
            addevent(153, 28, 1, 3022, 1, 4421 * 2)
            local pn = math.random(3000, 5000)
            CC.TX['西域奇商'] = pn
        end
    end
    local Mmenu = {"春", "夏", "秋", "冬"}
    local Mwz = nil
    local scolor = C_WHITE
    if CC.Month == 1 or CC.Month == 2 or CC.Month == 3 then
        Mwz = Mmenu[1]
        scolor = M_SeaGreen
    elseif CC.Month == 4 or CC.Month == 5 or CC.Month == 6 then
        Mwz = Mmenu[2]
        scolor = C_RED
    elseif CC.Month == 7 or CC.Month == 8 or CC.Month == 9 then
        Mwz = Mmenu[3]
        scolor = C_ORANGE
    elseif CC.Month == 10 or CC.Month == 11 or CC.Month == 12 then
        Mwz = Mmenu[4]
    end
    local w1 = 0
    if JY.Status ~= GAME_WMAP then
        local sx = 0
        local sy = 0
        local mpbs = CC.ScreenH / 21.9428
        lib.LoadPNG(91, 40 * 2, -1, -1, 1)
        -- 天气
        if CC.weat > 0 and CC.WeatherCD > 0 then -- 如果有一个天气状态不是空值		
            CC.Weather[CC.weat][1] = CC.WeatherCD
            if CC.Weather[CC.weat][1] > 0 then
                lib.LoadPNG(91, 71 * 2, CC.ScreenW / 2 - CC.ScreenW / 17.5, CC.ScreenH / 200, 1)
                lib.LoadPNG(91, (CC.Weather[CC.weat][3]) * 2, CC.ScreenW / 2 - CC.ScreenW / 18.5, CC.ScreenH / 130, 1)
                DrawString(tx + w1 + sx, ty + size + sy * 2, CC.Weather[CC.weat][2], C_BLACK, size2)
            end
        end

        lib.DrawStr(tx + CC.ScreenW / 42.5 + w1 + sx, ty - CC.ScreenH / 153.6 + sy * 2, Mwz, scolor, size2 * 2,CONFIG.CurrentPath .. "FONT/2.ttf", 0, 0) -- 季节
        DrawString(tx + w1 + sx, ty + sy * 2, Hwz[CC.Daytime], C_BLACK, size2) -- 一天
        lib.LoadPNG(91, 130 * 2, CC.ScreenW / 2 + sx, -1, 1) -- 信息条GB
        DrawString(CC.ScreenW / 2 + size * 1.2 + sx * 2, CC.ScreenH / 153.6 + sy, "天书" .. YY .. "年" .. MM .. "月" .. DD .. "日" .. HH .. "时" .. "│", C_WHITE, size2) -- 时间		

        -- lib.LoadPNG(1, hid*2, CC.ScreenW/120, CC.ScreenH/100, 1,0,CC.ScreenW/1360*70)
        -- 头像贴图
        lib.LoadPNG(1, hid * 2, CC.ScreenW / 120, CC.ScreenH / 100, 1, 0, CC.ScreenW / 20)
        lib.LoadPNG(91, 63 * 2, -1, -1, 1) -- 头象背景
        local sw, sy = lib.GetPNGXY(91, 65 * 2)
        lib.LoadPNG(91, 505 * 2, 0, CC.ScreenH / 6, 1) -- 简易信息
        lib.LoadPNG(91, 504 * 2, 0, CC.ScreenH / 6 + sy + CC.ScreenH / 50, 1) -- 打开地图
        lib.LoadPNG(91, 65 * 2, 0, CC.ScreenH / 6 + (sy + CC.ScreenH / 50) * 2, 1) -- 图签 攻略
        lib.LoadPNG(91, 544 * 2, 0, CC.ScreenH / 6 + (sy + CC.ScreenH / 50) * 3, 1) -- 任务
		local jhx,jhy = lib.GetPNGXY(91,556*2)
		lib.LoadPNG(91,556*2,CC.ScreenW-jhx,CC.ScreenH/25,1) --江湖传闻

        local mplogo = 240 + JY.Person[0]["门派"]
        local mpn = nil

        if JY.Person[0]["门派"] >= 0 then
            for m = 1, #MPname do
                mpn = MPname[JY.Person[0]["门派"] + 1]
                if mpn == "日月神教" then
                    mpn = "日月"
                end
                if mpn == "藏剑山庄" then
                    mpn = "藏剑"
                end
            end
        end
        -- 游历人物显示
        DrawString(CC.ScreenW / 2 - string.len(name) / 4 * size + size * 2, y4 - size / 2 + size / 5 + size,
            '正在游历中队友：', C_GOLD, size * 1.2) -- 姓名
        for i = 1, 5 do
            if CC.YOULI[i] > 0 then
                local Yname = JY.Person[CC.YOULI[i]]['姓名']
                DrawString(CC.ScreenW / 2 - string.len(name) / 4 * size + size * 11 + size * 5 * (i - 1), y4 - size / 2 + size / 5 + size, Yname, C_WHITE, size * 1.1) -- 姓名
            end
        end
        -- 内力属性	
        local sx = {'阴', '阳', '调和', '天罡'}
        -- 内力属性
        local nlsx = sx[JY.Person[0]['内力性质'] + 1]
        -- 生命数字
        local smwz = sm .. '/' .. smmax
        -- 内力数字
        local nlwz = nl .. '/' .. nlmax .. '（' .. nlsx .. '）'
        lib.LoadPNG(91, mplogo * 2, CC.ScreenW / 14.7826, CC.ScreenH / 192, 1, 0, mpbs) -- 门派LOGO
        -- 姓名
        DrawString(x4 - string.len(name) / 4 * size + size * 4, y4 - size / 2 + size / 5, name, C_GOLD, size) -- 姓名
        -- 门派
        DrawString(x5 - string.len(mpn) / 4 * size2 - size * 4.1, y5 - size / 2 + size / 5, mpn, C_WHITE, size2) -- 门派

        DrawString(x1 - string.len(smwz) / 4 * size2, y1 - size2 / 2, smwz, C_WHITE, size2 * 0.9)
        -- 内力
        DrawString(x2 - string.len(nlwz) / 4 * size2, y1 + size / 3, nlwz, C_WHITE, size2 * 0.9)
        -- 当前XY坐标显示
        if CC.ShowXY == 1 then
            if JY.Status ~= GAME_SMAP then
                -- lib.LoadPNG(91,43*2,CC.WX*136,CC.HY*142,2)
                DrawString(CC.WX * 120, CC.HY * 70, string.format("%s %d %d", "", JY.Base["人X"], JY.Base["人Y"]),  C_WHITE1, CC.Fontsmall * 0.7);
            else
                if JY.SubScene ~= 150 then
                    -- lib.LoadPNG(91,43*2,CC.WX*136,CC.HY*142,2)
                    DrawString(CC.WX * 120, CC.HY * 72, string.format("%s %d %d", JY.Scene[JY.SubScene]["名称"], JY.Base["人X1"], JY.Base["人Y1"]), C_WHITE1, CC.Fontsmall * 0.7);
                else
                    -- lib.LoadPNG(91,43*2,CC.WX*136,CC.HY*142,2)
                    DrawString(CC.WX * 120, CC.HY * 72, string.format("%s %d %d",
                        "天关" .. 8 + JY.Base["天关"] .. "层", JY.Base["人X1"], JY.Base["人Y1"]), C_WHITE1, CC.Fontsmall * 0.7);
                end
            end
        end
        if JY.Base["剧情"] == 1 then
            local dh = 0
            local zb = {{CC.ScreenW / 1.5906, CC.ScreenH / 2.0263, 144},
                        {CC.ScreenW / 1.5906, CC.ScreenH / 1.6305, 145},
                        {CC.ScreenW / 1.8085, CC.ScreenH / 1.3083, 146}, {CC.ScreenW / 1.6171, CC.ScreenH / 1.315, 147}}
            for i = 1, #zb do
                lib.LoadPNG(91, zb[i][3] * 2, CC.ScreenW / 3.2075 + zb[i][1], CC.ScreenH / 27.2727 + zb[i][2], 1)
            end
            for i = 1, 10 do
                local x3 = (i - 1) * CC.ScreenW / 13.6
                lib.LoadPNG(91, 148 * 2, CC.ScreenW / 7.5555 + x3, CC.ScreenH / 1.1294, 1)
            end
            for j = 1, CC.TeamNum do
                local wz = 0
                local zs = 0
                local dl = 0
                local tid = nil
                if JY.Base['队伍' .. j] > 0 then
                    tid = JY.Base["队伍" .. j]
                end
                if tid ~= nil then
                    local pic = JY.Person[tid]['头像代号']
                    for j = 1, 5 do
                        if JY.Person[tid]['出招动画帧数' .. j] > 0 then
                            if j > 1 then
                                zs = JY.Person[tid]['出招动画帧数' .. j]
                                break
                            end
                            dl = dl + JY.Person[tid]['出招动画帧数' .. j] * 4
                        end
                    end
                    local x4 = (j - 2) * CC.ScreenW / 13.6
                    lib.PicLoadCache(pic + 101, (dl) * 2, CC.ScreenW / 6.415 + x4, CC.ScreenH / 1.0924)
                    wz = wz + 1
                    dh = dh + 1
                    if dh == zs then
                        dh = 1
                    end
                end
            end
        end
    end
end

--显示大地图建筑
function MMapName() 
	if JY.Status == GAME_MMAP then --游戏状态在大地图时
		for i = 0,JY.SceneNum - 1 do --循环所有场景
	 		if JY.Scene[i]["外景入口X1"] ~= 0 then --排除不在大地图上的，需要跳转的内场景
	 			if JY.Scene[i]["进入条件"] == 0 then --排除不能进的场景
	 				local sid = i
	 				if sid>=0 then
	 					local dx = JY.Scene[sid]["外景入口X1"] - JY.Base["人X"]
	 					local dy = JY.Scene[sid]["外景入口Y1"] - JY.Base["人Y"]
	 					local rx = CC.XScale * (dx - dy) + CC.ScreenW / 2
	 					local ry = CC.YScale * (dx + dy) + CC.ScreenH / 2	
						if math.abs(dx) <= 20 and math.abs(dy) <= 20 then --排除主角半径15步之外的场景--剩下的没有被过滤掉的就是我们需要显示的，主角半径15步内的场景	
	 						local name = JY.Scene[sid]["名称"]
	 						local size = CC.FontSmall*2
	 						local color = C_GOLD;
							local namelen = string.len(name) / 2
							local stn = string.len(name) / 2
							local hsize = CC.ScreenH/4.266/stn	
							local name1 = string.sub(name,1,2)
							local name2 = string.sub(name,3,4)
							local name3 = string.sub(name,5,6)
							local name4 = string.sub(name,7,8)	
							local nx = rx - #name*size/4 + size*0.9
							local ax,ay = 0,0
	
							local ny = ry - CC.YScale*8- ((stn-1)*hsize+size)/2 - size*0.2
							local size1 = CC.FONT2
							local cl = C_WHITE
							if 	stn <= 2 then					
								lib.LoadPNG(91,233*2,rx - #name*size/4+CC.ScreenW/45.333,ry - CC.YScale*8- ((stn-1)*hsize+size)/2+CC.ScreenH/76.8,1)
								lib.DrawStr(nx,ny+size*0.7,name1, cl,size*0.5, size1,  0, 0)
								lib.DrawStr(nx,ny+size*2*0.7,name2, cl,size*0.5, size1,  0, 0)
							elseif  stn < 4 then
								lib.LoadPNG(91,234*2,rx - #name*size/4+CC.ScreenW/45.333,ry - CC.YScale*8- ((stn-1)*hsize+size)/2+CC.ScreenH/76.8,1)
								lib.DrawStr(nx,ny+size*0.7,name1, cl,size*0.5, size1,  0, 0)
								lib.DrawStr(nx,ny+size*2*0.7,name2, cl,size*0.5,size1,  0, 0)
								lib.DrawStr(nx,ny+size*3*0.7,name3, cl,size*0.5, size1,  0, 0)
							elseif stn > 3 then
								lib.LoadPNG(91,234*2,rx - #name*size/4+CC.ScreenW/45.333,ry - CC.YScale*8- ((stn-1)*hsize+size)/2+CC.ScreenH/76.8,1)
								lib.DrawStr(nx,ny+size*0.6,name1, cl,size*0.5, size1,  0, 0)
								lib.DrawStr(nx,ny+size*2*0.6,name2, cl,size*0.5, size1,  0, 0)
								lib.DrawStr(nx,ny+size*3*0.6,name3, cl,size*0.5, size1,  0, 0)
								lib.DrawStr(nx,ny+size*4*0.6,name4, cl,size*0.5, size1,  0, 0)	
							end
	 					end
	 				end
				end
			end
		end
	end
end	

function LGMsgBox(title,str, button, num, id,isEsc,name,headid)
	--Cls()	
	
	local bx,by = CC.ScreenW/1360,CC.ScreenH/768
	local size =CC.DefaultFont*0.9
	local x,y = CC.ScreenW/2,CC.ScreenH/2
	local x1,y1 = lib.GetPNGXY(91,141*2)
	local x2,y2 = lib.GetPNGXY(91,139*2)
	local x3,y3 = x+x1/2,y-y1/2
	local tb = 1
	local n
	local pname= ""
	local fjstr = ""
	local picw,pich = bx*300,by*316	
	local picw1,pich1 = lib.GetPNGXY(91,538*2)
	local jj = {298,299,300,301,302,303}
	if id ~= nil then 
		headid = JY.Person[id]['半身像']
		pname = JY.Person[id]['姓名']
		fjstr =jj[JY.Person[id]["畅想分阶"]]
	else
		pname = name 
		fjstr =jj[1]
		if name == nil then 
			pname =  "神秘人"
		end
		fjstr =jj[1]
	end
	local bs = CC.ScreenH/6.4
	lib.LoadPNG(90,headid*2,CC.ScreenW/2-picw/2,CC.ScreenH/2-pich,1,0,CC.ScreenW/1360*100)
	DrawBox(CC.ScreenW/2-picw/2,CC.ScreenH/2-size*3,CC.ScreenW/2-picw/2+picw,CC.ScreenH/2,C_BLACK,10)
	local rnum = 10		
	tjm(CC.ScreenW/2-picw/2,CC.ScreenH/2-size*3,str,C_WHITE	, size*0.9,rnum,size*0.9)
	if CC.PersonExit[id] ~= nil then 
		tjm(CC.ScreenW/2-picw/2,CC.ScreenH/2-size,"Ｄ好感：Ｚ"..JY.Person[id]['好感'],C_WHITE1, size*0.8,10,size*0.8)
		tjm(CC.ScreenW/2-picw/2+size*4,CC.ScreenH/2-size,"Ｄ喜好：Ｚ"..Person_xihao(id),C_WHITE1, size*0.8,10,size*0.8)
	end
	local namelen = string.len(pname) / 2
	local stn = string.len(pname) / 2
	local hsize = bx*108/stn
	for i = 1,num do 
		lib.LoadPNG(91,538*2,CC.ScreenW/2-picw1/2,CC.ScreenH/2+(by*40)*(i-1),1)	
	end
	--lib.LoadPNG(91,fjstr*2,x+x2/5,y3+y1/15,1)
	--draw3(pname,x+x2*2/3+bx*20,y3+y1/5- ((stn-1)*hsize+size)/2, C_ORANGE, size,nil,hsize)
	local surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH) --截取当前屏幕并保存
	while true do 
		if JY.Restart == 1 then
			break
		end	
		--ClsN() --加了个这下面的循环就不会无限叠加
		--lib.LoadSur(surid, 0, 0) --读取截屏
		for i = 1,num do 
			local cl = C_GOLD
			if tb == i then 
				cl = C_RED
			end
			--lib.LoadPNG(91,538*2,CC.ScreenW/2-picw1/2,CC.ScreenH/2+(by*40)*(i-1),1)
			lib.DrawStr(CC.ScreenW/2-string.len(button[i])/4*size,CC.ScreenH/2+(by*40)*(i-1),button[i],cl,size,CC.FontName)		
		end
		ShowScreen()
		lib.Delay(CC.Frame)
		local key, ktype, mx, my = lib.GetKey();	
		if key == VK_ESCAPE or ktype == 4 then
			if isEsc ~= nil and isEsc == 1 then
				tb = -2
				return 0
			else
				tb = -2
				return 0
			end
		elseif key == VK_UP then
			tb = tb - 1
			if tb < 1 then 
				tb = num 
			end
		elseif key == VK_DOWN then
			tb = tb + 1 
			if tb > num then 
				tb = 1
			end
		elseif key == VK_RETURN or key == VK_SPACE or ktype == 5 then
			break	
		else
			local nx,ny = bx*143,by*37
			local pd = false
			for i = 1,num do
				if mx > CC.ScreenW/2-picw1/2 and mx < CC.ScreenW/2-picw1/2 + picw1  and my > CC.ScreenH/2+(by*40)*(i-1) and  my < CC.ScreenH/2+(by*40)*(i-1)+size*2 then 
					tb = i 
					pd = true
				end
			end
			if pd == true and ktype == 3  then 
				break
			end
		end
		--surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH) 
	end
	
	return tb 
end

--自动战斗设置
function AutoMenu()
	local bx,by = CC.WX,CC.HY
	local size2 = CC.Fontsmall*0.8
	local ax,ay = lib.GetPNGXY(91,562*2)
	lib.LoadPNG(91,CC.ScreenH/2-ax/2,CC.ScreenW/2-ay/2,1)
	while true do 
		if JY.Restart == 1 then
			break
		end
		ShowScreen()
		lib.Delay(CC.Frame)
		local X,ktype,mx,my = lib.GetKey();
		if X == VK_ESCAPE or ktype == 4 then 
			return 0	
		end
	end
end

--人物界面
function jiemian(did)
	----lib.Debug(jiemian())
	----lib.Debug('选择的是 '..JY.Person[JY.Base['队伍'..did]]['姓名'])
	local bx,by = CC.WX,CC.HY
	local size2 = CC.Fontsmall*0.8
	local team = {}
	local tid = did
	local tid2 = 0	--队伍按键
	for i = 1,CC.TeamNum do 
		if JY.Base['队伍'..i] >= 0 then 
			team[#team+1] = JY.Base['队伍'..i]
		end
	end
	if did ~= nil then 
		if did > 8 then 
			tid2 = did - 8*(math.modf(#team/8))
			tid = 8
		end	
	else
		return jiemian(1)
	end
	
	local page = 1
	local c_xy = {{0,0,1360,160,1,'人物'},{20,315,455,410,2,'天赋'}}
	local function c_true(x,y)
		for i = 1,#c_xy do 
			if x >= c_xy[i][1] and x <= c_xy[i][3] and y >= c_xy[i][2] and y <= c_xy[i][4] then
				return c_xy[i][5]
			end
		end
		return -1
	end
	local menu = {{212,217},{213,218},{214,219},{215,220},{216,221}}  --左侧经脉总表图片编号
	local ssanyin = {"手少阴经","手太阴经","手厥阴经"}  --手三阴经文字
	local ssanyang = {"手少阳经","手太阳经","手阳明经"}  --手三阳经文字
	local zsanyin = {"足少阴经","足太阴经","足厥阴经"}  --足三阴经文字
	local zsanyang = {"足少阳经","足太阳经","足阳明经"}  --足三阳经文字
	local renmai = {"任    脉","督    脉"}  --任督二脉文字
	local ssymenu = {CC.Sshaoyin,CC.Staiyin,CC.Sjueyin}   -- 手三阴表
	local ssyangmenu = {CC.Sshaoyang,CC.Staiyang,CC.Syangming}  --手三阳表
	local zsymenu = {CC.Zshaoyin,CC.Ztaiyin,CC.Zjueyin}  --足三阴表
	local zsyangmenu = {CC.Zshaoyang,CC.Ztaiyang,CC.Zyangming}  --足三阳表
	local renmaimenu = {CC.Renmai,CC.Dumai} --任督二脉表
	local jmmenu = {ssymenu,ssyangmenu,zsymenu,zsyangmenu,renmaimenu}
	local tb,tb1,tb4,tb5 =1,1,1,0  -- tb第一层表的按键，tb1-tb4第二层四个表的按键，
	local cot1 = 1--控制具体奇穴的按键
	local lb = 0 --页数
	local size,size1 = CC.DefaultFont*0.9,CC.DefaultFont --字号
	local zb = {{CC.ScreenW/2,CC.ScreenH/2},{CC.ScreenW/1.878,CC.ScreenH/2},{CC.ScreenW/1.768,CC.ScreenH/2},{CC.ScreenW/2,CC.ScreenH/1.846},{CC.ScreenW/1.878,CC.ScreenH/1.846},{CC.ScreenW/1.768,CC.ScreenH/1.846}}
	local QXSHUOMING,WGSHUOMING,TFSHUOMING,yxsm,ngsm,qgsm,qxsm,MJSHUOMING = 0,0,0,0,0,0,0,0
	local smwz = {"十二经脉与相应脏腑络属的主要特征。包括手三阴经、手三阳经、足三阴经、足三阳经，最少需要学会一门内功才可激活经脉。","任督两脉原属于奇经八脉，因具有明确穴位，医家将其与十二正经脉合称十四正经脉。最少需要学会一门内功才可激活经脉。"}
	local px,py = -1,-1
	local p_3x,p_3y = CC.ScreenW/6.098,CC.ScreenH/4.388   
	local tfid = 0	--天赋说明按键 
	local tfx,tfy = CC.ScreenW/13.05,CC.ScreenH/2.25  
	--武功
	local kid = 1
	local wgmenu,kfmenu,MJMenu = {},{},{}; --外功
	local zb0 = {{CC.ScreenW/8.09,190},{CC.ScreenW/8.09,240},{CC.ScreenW/8.09,290},{CC.ScreenW/8.09,340},{CC.ScreenW/8.09,390},{CC.ScreenW/8.09,440},{CC.ScreenW/8.09,490},{CC.ScreenW/8.09,540},{CC.ScreenW/8.09,590},}
	local zb1 = {{385,160},{547,160},{705,160}}	
	local zsw1,zsw2,zsw3 = by*550,bx*50,bx*60
	local zszb = {{zsw3,zsw1},{zsw3+50,zsw1},{zsw3+50*2,zsw1},{zsw3+50*3,zsw1},{zsw3+50*4,zsw1},{zsw3+50*5,zsw1},{zsw3+50*6,zsw1},{zsw3+50*7,zsw1},{zsw3+50*8,zsw1},{zsw3+50*9,zsw1},}	
	local wz = {"初窥门径", "初窥门径", "略有小成", "略有小成", "渐入佳境", "渐入佳境", "融会贯通", "融会贯通", "炉火纯青", "炉火纯青", "登峰造极"}
	local djwz = {"一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "极"}
	local pjwz = {"Ｗ".."初阶武功","Ｌ".."中阶武功","Ｒ".."高阶武功","Ｇ".."绝学武功"}		
	local color = RGB(248,248,181)
	local zsmenu = {}
	local zsnum ,hg,sf,FY,WGFY,WGSTARTH= 0,40,0,0,0,0	
	local STARTH1,WGFY1,WGSTARTH1,Mstarth =0,0,0,0
	local zb5 = {{CC.ScreenW/2.03,CC.ScreenH/1.352},{CC.ScreenW/1.773,CC.ScreenH/1.352}}
	local xj,yj,zsn = nil,33,28
	local FY1,h,h1,SHUOMING,xlsm,Mfy = 0,0,0,0,0,0
	local wzbx6,wzby6,wgzbx,wgzby = CC.ScreenW/5.484,CC.ScreenH/4.74,CC.ScreenW/25,CC.ScreenH/2 - size*2.5
	local id = -1
	local dh = 0	
	local lb1 = 1
	local p2x = bx*80 + bx*30
	local p2y = by*80 + by*30
	local rnum = 5
	local zmenu = {{'属 性',275,278,364},{'武 功',276,279,365},{'秘 技',277,311,366},{'经 脉',310,280,367},{'战 斗',563,562,564}} --名称，黄色亮图，菜单图，红色亮图
	local mid = 1
	local jmtx = 0
	local wgy1 = size2*1.2
	local zsh,zsw = size*1.5,size*1.1 --招式部分的文字坐标控制
	local zdpage,tb2 = 1,1
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
	local kf
	local function miji_info(md)
		----lib.Debug(thingID);
		local h1 = 0
		local me = {}
		local hs1 = 0
		local myh1 = 7
		local mm = 1		
		local function strcolor_switch(s)
			local Color_Switch={{"Ｒ",PinkRed},{"Ｇ",M_Wheat},{"Ｂ",C_BLACK},{"Ｗ",RGB(178,158,124)},{"Ｏ",C_ORANGE},{"Ｌ",LimeGreen},{"Ｄ",M_DeepSkyBlue},{"Ｚ",Violet}}
			for i = 1, 8 do
				if Color_Switch[i][1] == s then
					return Color_Switch[i][2]
				end
			end
		end
		if Pmiji_info[md] ~=  nil  then
			for i = 1,#Pmiji_info[md] do
				me[#me+1] =Pmiji_info[md][i]
				if i == Pmiji_info[md] then
					me[#me+1] = "Ｎ"
				end
				
			end
		else
			me[#me+1] = ''
		end		
		for i = mm, #me do
			local smsize = CC.DefaultFont*0.6
			local tfstr = me[i]
			local color;
			color = strcolor_switch(string.sub(tfstr,1,2))
			tfstr = string.sub(tfstr,3,-1)
			if string.sub(tfstr,1,2) == "Ｎ" then
			--	hs1 = hs1 + 1
			else 
				h1 = tjm(wgzbx, CC.ScreenH/2-size*1.3 + size*1.4* (hs1-Mstarth), tfstr, C_BLACK, smsize*1.2,20,size*1.48,Mstarth-hs1,myh1+1-hs1+Mstarth)		
			end			
			hs1 = hs1 + h1
		end
		if hs1 > myh1 then
			Mfy = limitX(hs1-myh1-1,0)
		else
			Mfy = 0
		end		
		if 	Mfy > 0 then 
			lib.LoadPNG(91,124*2,CC.ScreenW/2-size*4.2,CC.ScreenH/2+size*10,1,0,60) 
		end	
		if Mstarth > 0 then 
			lib.LoadPNG(91,127*2,CC.ScreenW/2-size*4.2,CC.ScreenH/2+size*4,1,0,60) 
		end	
	end	
	--招式方针
	local zdwz1 = {'一','二','三','四','五','六','七','八','九',}
	--攻击方针
	local zdwz2 = {
		{'移动攻击.单','原地攻击.单','原地防御.单','逃离防御.单','原地休息.单','移动攻击.全','原地攻击.全','原地防御.全','逃离防御.全','原地休息.全'},
		{'不施毒','自动施毒',},
		{'不使用暗器','自动暗器',},
	}	
	local zdwz3 = { 
		{'不吃生命药','命低于一成','命低于三成','命低于五成','命低于七成'},
		{'不吃内力药','内低于一成','内低于三成','内低于五成','内低于七成'},
		{'不吃体力药','体低于一成','体低于三成','体低于五成','体低于七成'},
	}	
	local zdwz4 = {
		{'不切换内功','命低于一成','命低于三成','命低于五成'},
		{'不喝酒','五宝花蜜酒','即墨老酒','梨花酒','自动喝酒'},
		{'不治疗','治疗自己','治疗他人','自动治疗',},
	}		
	local zh = by*77
	while true do 
		if JY.Restart == 1 then
			break
		end
		Cls()	
		lib.LoadPNG(91,273*2,-1,-1,1)
		lib.LoadPNG(91,283*2,-1,-1,1)
		--随便用个人物id收集这一段长代码
		local rwqx = 0
		for i = 1,8 do 
			local aid  = team[i+tid2]
			if aid ~= nil then 
				local headid = JY.Person[aid]["半身像"]
				lib.LoadPNG(1,headid*2,CC.ScreenW/17+(i-1)*CC.ScreenW/9.07,CC.ScreenH/40,1,0,CC.ScreenH/8)--适配*1.25				
				if tid == i then 
					lib.LoadPNG(91,22*2,CC.ScreenW/20+(i-1)*CC.ScreenW/9.07,CC.ScreenH/40,1,0,CC.ScreenH/8/1.28)
					local zs = 0
					local dl = 0
					for j =1,5 do
						if JY.Person[aid]['出招动画帧数'..j]>0 then
							if j>1 then
								zs = JY.Person[aid]['出招动画帧数'..j]
								break
							end
							dl = dl+JY.Person[aid]['出招动画帧数'..j]*4
						end
					end					
					lib.PicLoadCache(JY.Person[aid]["头像代号"]+101,(dl+dh+zs*3)*2,CC.ScreenW/3.4,CC.ScreenH/1.1)					
					dh = dh + 1
					if dh == zs then
						dh = 0
					end
				end
				lib.LoadPNG(91,(298+(JY.Person[aid]['畅想分阶']-1)) *2,CC.ScreenW/17+(i-1)*CC.ScreenW/9.07+size*3,CC.ScreenH/40+size*1.23,1,0,100)	
			else
				lib.LoadPNG(1,1512*2,CC.ScreenW/17+(i-1)*CC.ScreenW/9.07,CC.ScreenH/40,1,0,CC.ScreenH/8)
			end	
				
		end
		id = team[tid+tid2]
		lib.LoadPNG(90,JY.Person[id]["半身像"]*2,CC.ScreenW/20,CC.ScreenH-CC.ScreenH/2.2,1)		
		lib.DrawStr(CC.ScreenW/2-string.len(JY.Person[id]["姓名"])/4*size2*1.9,by*178,JY.Person[id]["姓名"],C_WHITE,size2*1.8,CC.FontName)
		local cpd = 0
		if page == 4 then 
			if lb > 0 then 
				cpd = 1
			end
		else
			if lb1 > 1 then 
				cpd = 1
			end
		end

		--菜单页背景
		if cpd == 1 then 
			lib.LoadPNG(91,zmenu[page][4]*2,-1,-1,1)
		else
			lib.LoadPNG(91,zmenu[page][2]*2,-1,-1,1)
		end
		lib.LoadPNG(91,zmenu[page][3]*2,-1,-1,1) 

		--页码
		local pwz = 0
		if page == 1 then 
			pwz = lb1..'/'..2
		elseif page < 4 or page == 5 then
			pwz = lb1..'/'..3
		elseif page == 4 then 
			pwz = (lb+1)..'/'..4
		end
		lib.LoadPNG(91,71*2,CC.ScreenW/1.1-size2/50,CC.ScreenH/2.69-size2/3,1,0,50) 

		lib.DrawStr(CC.ScreenW/1.1,CC.ScreenH/2.69,pwz,C_WHITE,size2,CC.FontName)

		local p = JY.Person[id]
		local x,y = CC.ScreenW/10,CC.ScreenH/1.52 --115 706
		local pcx,pcy,pcx1 = x-CC.FontSmall3,CC.ScreenH-CC.ScreenH/12,x-CC.FontSmall3- CC.RowPixel;
		local lifexs = "命 "..p["生命"].." / "..p["生命最大值"] --生命
		local nlxz = {'阴','阳','调和','天罡'}
		local nlxs = "内 "..p["内力"].." / "..p["内力最大值"]..'('..nlxz[p['内力性质']+1]..')'  --内力

		--生命条
		local pcw, pch = lib.GetPNGXY(91, 289 * 2);  
		lib.LoadPNG(91, 293 * 2 , pcx  , pcy-pch/2, 1)
		lib.SetClip(pcx1, pcy-pch/2, pcx1 + (p["生命"]/p["生命最大值"])*(pcw), pcy-pch/2 + pch)
		lib.LoadPNG(91, 289 * 2 , pcx  , pcy-pch/2, 1)
		pcy = pcy + CC.RowPixel + CC.FontSmall3 -CC.ScreenH/384
		lib.SetClip(0,0,0,0)
		DrawString(pcx, pcy-pch*1.15  , lifexs, C_WHITE, CC.FontSmall3)

		--内力条
		local hh = pch/4
		lib.LoadPNG(91, 293 * 2 , pcx  , pcy +hh-pch/2, 1)
		lib.SetClip(pcx1, pcy-pch/2 +hh, pcx1 + (p["内力"]/p["内力最大值"])*(pcw), pcy-pch/2 + pch +hh)
		lib.LoadPNG(91, 290 * 2 , pcx  , pcy+hh-pch/2, 1)
		pcy = pcy + CC.RowPixel + CC.FontSmall3 -2
		lib.SetClip(0,0,0,0)
		DrawString(pcx, pcy-pch*1.15+hh , nlxs, C_WHITE, CC.FontSmall3)
		
		--门派
		--local jj = {"传说","宗师","豪侠","一流","二流","三流"}
		local pergx = "" 
		if JY.Base['妻子'] > 0 then 
			if id == JY.Base['妻子'] then 
				pergx = '配偶 '..JY.Person[0]['姓名']
				if JY.Base['孩子'] > 0 then 
					pergx = pergx.."   "..'子女 '..JY.Person[JY.Base['孩子']]['姓名']
				end
			end 
		end
		if JY.Base['孩子'] > 0 then 
			if id == JY.Base['孩子'] then 
				pergx = '父母 '..JY.Person[0]['姓名']..' '..JY.Person[JY.Base['妻子']]['姓名']
			end 
		end
		if id == 0 then 
			if JY.Base['妻子'] > 0 then 
				pergx = '配偶 '..JY.Person[JY.Base['妻子']]['姓名']
				if JY.Base['孩子'] > 0 then 
					pergx = pergx.."   "..'子女 '..JY.Person[JY.Base['孩子']]['姓名']
				end
			end
		end
		local mpbs = CC.ScreenH/9.6
		-- 门派、职务、境界文字显示
		lib.LoadPNG(91, (240 + JY.Person[id]["门派"]) * 2, CC.ScreenW/6.8-CC.ScreenW/8.5, CC.ScreenH/3.2-CC.ScreenH/76.8,1,0,mpbs)
		DrawString(CC.ScreenW/6.8-size*2.5,CC.ScreenH/3.2+size*1.3,pergx,M_DeepSkyBlue,size2*1.4)
		DrawString(CC.ScreenW/6.8-size*2.5,CC.ScreenH/3.2+size*0.3,MP_name(id)..MP_zw(id),C_WHITE,size2*1.4)
		--35 240
		--点数
		DrawString(CC.ScreenW/68, CC.ScreenH/4.517, "修炼经验："..math.modf(JY.Person[id]["物品修炼点数"]), C_WHITE, size*0.75)
		DrawString(CC.ScreenW/68+size*7, CC.ScreenH/4.517, "武学点数："..JY.Person[id]["武学点数"], C_WHITE, size*0.75)
		DrawString(CC.ScreenW/68+size*7*2, CC.ScreenH/4.517, "门派贡献："..JY.Person[id]["门派贡献"], C_WHITE, size*0.75)
		DrawString(CC.ScreenW/68, CC.ScreenH/4.517+size, "实战："..JY.Person[id]["实战"], C_WHITE, size*0.75)
		--天赋		
		local tfme = {} --天赋编号表
		local tfname = -1 --表赋图标
		local tfsmn = {}  --天赋名称
		local tfsm = {}  --天赋说明
		local row = 0  
		local maxh = 10
		local fy ,fymax,star = 0 ,0 , 1
		local xcolor = M_Gray

		--存天赋编号
		for i = 1,5 do 
			if JY.Person[id]['天赋'..i] > 0 then 
				tfme[#tfme+1] = {JY.Person[id]['天赋'..i],CC.PTFSM[JY.Person[id]['天赋'..i]][5]}
				--removebyvalue(tfme,0, 0)
			end
		end
		local function wg_px(a,b)
			return a[2] < b[2]
		end
		table.sort(tfme,wg_px)
		--table.sort(tfme)
		--天赋图标显示
		--if CC.PTF[id] ~= nil then
		local tfbj = {543,542,541,540}		
		for t = 1,#tfme do
			tfname = tfme[t][1]
			local tfbj1 = CC.PTFSM[tfme[t][1]][5]
			if tfname >= 9000 then
				tfname = tfname-8000
			end
			lib.LoadPNG(96,tfname*2,tfx-CC.ScreenW/160+(t-1)*CC.ScreenW/19.15,tfy-CC.ScreenH/100,1,0,CC.ScreenW/1360*130)
			lib.LoadPNG(91,(tfbj[tfbj1])*2,tfx-CC.ScreenW/160+(t-1)*CC.ScreenW/19.15,tfy-CC.ScreenH/100,1,0,CC.ScreenW/1360*130)
			if tfid == t and lb1 == 2 then 
				lib.LoadPNG(91,36*2,tfx-CC.ScreenH/90.666+(t-1)*CC.ScreenW/19.2,tfy-by*10,1,0,CC.ScreenW/1360*30)
			end
		end
		--end
		--天赋名字
		local tfcl = M_LightBlue
		local ftnm2 = {}
		for i = 1,#tfme do	
			local tfnm = tfme[i][1]	
			--if CC.PTF[id] ~= nil then
				if CC.PTFSM[tfnm] ~= nil then
					ftnm2[#ftnm2+1] = CC.PTFSM[tfnm][1]
					if CC.PTFSM[tfnm][5] == 2 then
						tfcl = M_Purple
					elseif CC.PTFSM[tfnm][5] == 3 then
						tfcl = Color_Hurt1
					elseif CC.PTFSM[tfnm][5] == 4 then
						tfcl = C_RED
					end
				end
			--end	
			if ftnm2[i] ~= nil then
				if px >= tfx + (i-1)*CC.ScreenW/19.4285 and px <= tfx + (i)*CC.ScreenW/22.666 + (i-1)*CC.ScreenW/90.666 and py >= tfy and py <= tfy+CC.ScreenH/13.963  then
					lib.LoadPNG(91, 90 * 2 ,CC.ScreenW/8 + (i-1)*size*2.5 -string.len(ftnm2[i])/4*size2-size*2,CC.ScreenH/1.896, 1 )
					DrawString(CC.ScreenW/7.555 + (i-1)*size*2.5 -string.len(ftnm2[i])/4*size2-size*2,by*410,ftnm2[i],tfcl,size2*1)
				end
			end		
		end	

		--三神技秘技学会
		local mjcolor = M_Gray
		local mjwz = {{'中庸',2,123},{'斗转',3,118},{'左右',4,121}}
		if Pmiji(id,1) then 
			mjwz[1][1] = '中庸'
			mjwz[1][2] = 1
		end
		for i = 1,#mjwz do  
			local mjx = CC.ScreenW/50
			local mjy = CC.ScreenH/2+CC.ScreenH/25 + (i-1)*size*1.7
			if Pmiji(id,mjwz[i][2])  then 
				mjcolor = M_DeepSkyBlue
				lib.LoadPNG(98, (mjwz[i][3]+1) * 2,mjx,mjy , 1)
				DrawString(mjx, mjy, mjwz[i][1], mjcolor, size*0.8)
			else
				lib.LoadPNG(98, (mjwz[i][3]) * 2 ,  mjx, mjy, 1)
				DrawString(mjx, mjy, mjwz[i][1], mjcolor, size*0.8)
			end	
		end	

		--运功 
		local smenu = {JY.Person[id]["优先使用"],JY.Person[id]["主运内功"],JY.Person[id]["主运轻功"]}
		if JY.Person[id]["优先使用"] > 0   then
			lib.LoadPNG(98, (500+JY.Person[id]["优先使用"]) * 2 , CC.ScreenW/3.222, CC.ScreenH/1.57, 1)
		else
			lib.LoadPNG(91, 77 * 2 ,  CC.ScreenW/3.222, CC.ScreenH/1.57, 1)
		end	
		if JY.Person[id]["主运内功"] > 0  then
			lib.LoadPNG(98, (500+JY.Person[id]["主运内功"]) * 2 , CC.ScreenW/3.148,CC.ScreenH/1.383,1)
		else
			lib.LoadPNG(91, 76 * 2 ,CC.ScreenW/3.148,CC.ScreenH/1.383,1)
		end	
		if JY.Person[id]["主运轻功"] > 0  then
			lib.LoadPNG(98, (500+JY.Person[id]["主运轻功"]) * 2 ,CC.ScreenW/3.162,CC.ScreenH/1.224,1)
		else
			lib.LoadPNG(91, 78 * 2 ,CC.ScreenW/3.162,CC.ScreenH/1.224,1)
		end	
		lib.LoadPNG(91, 285 * 2 , -1,-1,1)

		--装备武学 主运武功
		local wxzb = {{CC.ScreenW/3.222,CC.ScreenH/1.57},{CC.ScreenW/3.148,CC.ScreenH/1.383},{CC.ScreenW/3.163,CC.ScreenH/1.225}}
		local wxname = {JY.Wugong[JY.Person[id]["优先使用"]]['名称'],JY.Wugong[JY.Person[id]["主运内功"]]['名称'],JY.Wugong[JY.Person[id]["主运轻功"]]['名称']	}
		local zbwxbs = CC.ScreenH/6.981
		for i = 1,3 do 
			local name = wxname[i]
			if smenu[i] > 0 then
				if px > wxzb[i][1] and px <  wxzb[i][1] + CC.ScreenW/28.333 and py > by*wxzb[i][2] and py < by*wxzb[i][2]+CC.ScreenH/16 then
					lib.LoadPNG(91, 90 * 2 , CC.ScreenW/4.459,CC.ScreenH/1.551+(i-1)*CC.ScreenH/11.294, 1,0,zbwxbs )
					DrawString(CC.ScreenW/3.24-string.len(name)/4*size2-size*2,CC.ScreenH/1.536+(i-1)*CC.ScreenH/11.294,name,C_WHITE,size2*1)
				end
			end
		end	

		--装备兵器防具坐骑
		local zbbs = CC.ScreenH/12.8
		local zbbs1 = CC.ScreenH/6.982
		--
		--	zbbs = zbbs/2
		--	zbbs1 = zbbs1/2
		--end
		for i = 1,3 do 
			local  zm = {"A","B","Z"}
			local p = JY.Person[id]
			local zb = {p["武器"],p["防具"],p["坐骑"]}
			local zbname = -1
			local lv = 1
			local lv1 = {"壹级","贰级","叁级","肆级","伍级","陆级"}
			if zb[i] > -1 then
				 zbname = JY.Thing[zb[i]]["名称"]
				 lv = JY.Thing[zb[i]]["装备等级"]
			else
				zbname = "无"
				lv1[lv] = ""
			end			
			lib.LoadPNG(91, 281 * 2 ,CC.ScreenW/75.555,CC.ScreenH/1.352+(i-1)*size*2.2, 1)
			if zb[i] > -1 then
				lib.PicLoadCache(2,zb[i] * 2,CC.ScreenW/75.555,by*570 +(i-1)*size*2.2 ,1,0,0,-1,-1,0,0,zbbs)
				if px >= CC.ScreenW/75.555 and px <= CC.ScreenW/75.555 + CC.ScreenW/22.666 and py >= by*570+(i-1)*size*2.2  and py <= by*570+by*60+(i-1)*size*2.2 then
					lib.LoadPNG(91, 90 * 2 , bx*85,by*585+(i-1)*size*2.2, 1,0,zbbs1 )
					DrawString(bx*200-string.len(zbname)/4*size2-size*2,by*590+(i-1)*size*2.2,zbname,C_WHITE,size2*1)
					if JY.Thing[zb[i]]["装备等级"] > 0 then 
						DrawString(bx*200-string.len(zbname)/4*size2-size*2,by*590+(i-1)*size*2.2,"         "..lv1[lv],C_ORANGE,size2*1)
					else
						DrawString(bx*200-string.len(zbname)/4*size2-size*2,by*590+(i-1)*size*2.2,"         ".."无",C_ORANGE,size2*1)	
					end		
				end				
			end	
			DrawString(CC.ScreenW/22.666,by*605+(i-1)*size*2.2,zm[i],C_WHITE,size2*1)		
		end

		--门派
		if px >= CC.ScreenW/39 and px < CC.ScreenW/39 + CC.ScreenW/19.4 and py >= CC.ScreenH/3.2 and py <CC.ScreenH/3.2 + CC.ScreenH/11 then 
			lib.LoadPNG(91,37*2,CC.ScreenW/39 + CC.ScreenW/18,CC.ScreenH/3.2,1,0,160)
			tjm(CC.ScreenW/30 + CC.ScreenW/18, CC.ScreenH/3.1,MP_TX(JY.Person[id]['门派']),C_BLACK,size*0.6,12,size*0.6)
		end
		--天赋说明
		if TFSHUOMING == 1 then
			lib.LoadPNG(91,282*2,-1,-1,1,0,100)
			if CC.PTFSM[tfme[tfid][1]] ~= nil then
				local tfcl = C_WHITE
				if CC.PTFSM[tfme[tfid][1]][5] == 2 then
					tfcl = M_Purple
				elseif CC.PTFSM[tfme[tfid][1]][5] == 3 then
					tfcl = Color_Hurt1
				elseif CC.PTFSM[tfme[tfid][1]][5] == 4 then
					tfcl = C_RED
				end
				tfsm[#tfsm+1] =CC.PTFSM[tfme[tfid][1]][2]
				tfsmn[#tfsmn+1] =  {CC.PTFSM[tfme[tfid][1]][1],tfcl}
			end
			for i = 1,#tfsmn do 
				DrawString(bx*310-string.len(tfsmn[i][1])/4*size2-size*2,by*420,tfsmn[i][1],tfsmn[i][2],size2*1.4)
			end
			for i = star, #tfsm do
				local tfstr = tfsm[i]
				local h = 0						
				if string.sub(tfstr,1,2)  == "Ｎ" then
					row = row + 1
				else
					h = tjm(bx*50, by*458 + size*0.8 * (row-fy), tfstr, C_WHITE, size*0.8,math.modf((bx*470)/size/0.8)-1,size*0.9,fy-row,maxh+1-row+fy)
				end
				row = row + h
			end
			if row > maxh then
				fymax = limitX(row-maxh-1,0)
			else
				fymax = 0
			end
		end	

		if page == 1 then
			local p_1 = {{'资质',p['资质'],nil,"影人物学习武功速度，内力最大值。"},{'体质',p['体质'],nil,"影响人物生命最大值。"},{'医疗',p['医疗能力'],FJYIL(id),"影响人物治疗量。"},
						{'用毒',p['用毒能力'],FJYONGD(id),"影响人物用毒能力。"},{'解毒',p['解毒能力'],FJJIED(id),"影响人物解毒能力。"},{'带毒',p['攻击带毒'],FJDAID(id),"影响攻击对敌方造成的中毒点数。"}}
			local p_2 = {{'攻击',p['攻击力'],FJGONGJ(id),"主要影响攻击伤害、人物命中。"},{'防御',p['防御力'],FJFANGY(id),"主要影响受到的伤害减少、格档值。少量影响人物闪避。"},{'轻功',p['轻功'],FJQINGG(id),"主要影响人物命中、闪避。"},
						{'格挡',Person_GD(id),FJPerson_GD(id),"主要影响人物格档概率。"},{'命中',Person_MZ(id),FJPerson_MZ(id),"主要影响人物命中概率。"},{'闪避',Person_SB(id),FJPerson_SB(id),"主要影响人物闪避概率。"},
						{'集气',Person_JQ(id),nil,"主要影响人物出手速度。"},{'连击',Person_LJ(id),nil,"主要影响人物连击概率。"},{'暴击',Person_BJ(id),nil,"主要影响人物暴击概率。"},}
			local p_3 = {
						{'拳掌',p['拳掌功夫'],FJQZ(id),"主要影响人物学习拳掌武功的能力。",Pqfcz(id)},{'指法',p['指法技巧'],FJZF(id),"主要影响人物学习指法武功的能力。",Pzfcz(id)},
						{'御剑',p['御剑能力'],FJYJ(id),"主要影响人物学习剑法武功的能力。",Pjfcz(id)},{'耍刀',p['耍刀技巧'],FJDF(id),"主要影响人物学习刀法武功的能力。",Pdfcz(id)},
						{'奇门',p['特殊兵器'],FJQM(id),"主要影响人物学习特殊武功的能力。",Pqmcz(id)},{'暗器',p['暗器技巧'],FJANQI(id),"主要影响人物使用暗器造成的伤害。",Paqcz(id)},
						}
			local n,m = 0,0
			local fj = 0
			for i = 1,#p_1 do
				if p_1[i][3] ~= nil and p_1[i][3] ~= 0 then
					local w = nil
					local cl = C_WHITE
					if p_1[i][3] > 0 then 
						w = "    ↑"
						cl = M_DeepSkyBlue
					else
						w = "    ↓"
						cl = C_RED
					end
					DrawString(bx*625+n*bx*230+size*2.8,by*475+m*bx*35, w,cl,size*0.7)
					DrawString(bx*625+n*bx*230+size*4,by*470+m*bx*35, "  "..p_1[i][3],C_WHITE1,size*0.9)
				end
				DrawString(bx*625+n*bx*230,by*340+m*bx*35,p_1[i][1]..' '..p_1[i][2],C_WHITE,size*0.9)
				local xx,yy = 53,20
				local smsize,h1,hs1,s1,smwz,myh1 = size*0.9,0,0,0,p_1[i][4],3
				if px > bx*625+n*bx*230 and px < bx*625+n*bx*230 + xx and py > by*340+m*bx*35 and py < by*340+m*bx*35 + yy then
					lib.LoadPNG(91,37 * 2 , bx*625+n*bx*230-bx*165, by*340+m*bx*35, 1)
					tjm(bx*635+n*bx*230-bx*165, by*350+m*bx*35,smwz,C_BLACK,size*0.6,7,size*0.6)
				end
				n = n + 1
				if n == 3 then 
					n = 0
					m = m + 1
				end
			end
			n = 0
			m = 0
			for i = 1,#p_1 do
				local xx,yy = 53,20
				local smsize,h1,hs1,s1,smwz,myh1 = size*0.9,0,0,0,p_1[i][4],3
				if px > bx*625+n*bx*230 and px < bx*625+n*bx*230 + xx and py > by*340+m*bx*35 and py < by*340+m*bx*35 + yy then
					lib.LoadPNG(91,37 * 2 , bx*625+n*bx*230-bx*165, by*340+m*bx*35, 1)
					tjm(bx*635+n*bx*230-bx*165, by*350+m*bx*35,smwz,C_WHITE,size*0.6,7,size*0.6)
				end
				n = n + 1
				if n == 3 then 
					n = 0
					m = m + 1
				end
			end
			n = 0
			m = 0
			for i = 1,#p_2 do 
				local s = '※'
				if p_2[i][2] ~= nil then
					s = p_2[i][2]
				end
				if p_2[i][3] ~= nil and p_2[i][3] ~= 0 then
					local w = nil
					local cl = C_WHITE
					if p_2[i][3] > 0 then 
						w = "    ↑"
						cl = M_DeepSkyBlue
					else
						w = "    ↓"
						cl = C_RED
					end
					DrawString(bx*625+n*bx*230+size*2.8,by*475+m*bx*35, w,cl,size*0.7)
					DrawString(bx*625+n*bx*230+size*4,by*470+m*bx*35, "  "..p_2[i][3],C_WHITE1,size*0.9)
				end
				DrawString(bx*625+n*bx*230,by*470+m*bx*35,p_2[i][1]..' '..s,C_WHITE,size*0.9)
				n = n + 1
				if n == 3 then 
					n = 0
					m = m + 1
				end
			end
			n = 0
			m = 0
			for i = 1,#p_2 do 
				local xx,yy = 53,20
				local smsize,h1,hs1,s1,smwz,myh1 = size*0.9,0,0,0,p_2[i][4],3
				if px > bx*625+n*bx*230 and px < bx*625+n*bx*230 + xx and py > by*470+m*bx*35 and py < by*470+m*bx*35 + yy then
					lib.LoadPNG(91,37 * 2 , bx*625+n*bx*230-bx*165, by*470+m*bx*35, 1)
					tjm(bx*635+n*bx*230-bx*165, by*475+m*bx*35,smwz,C_WHITE,size*0.6,7,size*0.6)
				end
				n = n + 1
				if n == 3 then 
					n = 0
					m = m + 1
				end
			end
			n = 0
			m = 0
			for i = 1,#p_3 do 
				local s = '※'
				local cz = p_3[i][5]
				if p_3[i][2] ~= nil then
					s = p_3[i][2]
				end
				if p_3[i][3] ~= nil and p_3[i][3] ~= 0 then
					local w = nil
					local cl = C_WHITE
					if p_3[i][3] > 0 then 
						w = "    ↑"
						cl = M_DeepSkyBlue
					else
						w = "    ↓"
						cl = C_RED
					end   
					DrawString(bx*625+n*bx*325+size*2.8,by*645+m*by*35, "           "..w,cl,size*0.7)
					DrawString(bx*625+n*bx*325+size*4,by*640+m*by*35, "           "..p_3[i][3],C_WHITE1,size*0.9)
				end			
				DrawString(bx*625+n*bx*325,by*640+m*by*35,p_3[i][1]..'           '..s,C_WHITE,size*0.9)
				if cz ~= nil then
					local czpic = 0
					if cz >= 90 then 
						czpic = 304
					elseif cz > 50 and cz < 90 then 
						czpic = 305
					else
						czpic = 306
					end
					lib.LoadPNG(91,czpic*2,bx*600+n*bx*325,by*643+m*bx*35,1,0,105)
					local top1 = 200
					local top2 = 400
					local HG = by*20
					local x1,y1 = bx*685+n*bx*325,by*650+m*bx*35
					local pcx = x1
					local pcy = y1
					local pcx1 = x1
					lib.LoadPNG(91, 235 * 2 , pcx  , pcy, 1)
					local pcw, pch = lib.GetPNGXY(91, 235 * 2);  
					lib.SetClip(pcx1, pcy, pcx1 + (cz/top1)*(pcw), pcy + pch)
					if cz <= 200 then
						lib.LoadPNG(91, 236 * 2 , pcx  , pcy, 1)
					else
						lib.LoadPNG(91, 237 * 2 , pcx  , pcy, 1)
					end
					lib.SetClip(0,0,0,0)
				end
				DrawString(bx*605+n*bx*325+size*3,by*642+m*by*35,cz,C_WHITE1,size*0.75,CC.FONT0)
				--tjm(bx*610+n*bx*325+size*4,by*628+m*by*35,cz,C_WHITE1,size*0.8,5,size*0.3,nil,nil,CC.FONT0)


				n = n + 1
				if n == 2 then
					n = 0
					m = m + 1
				end
			end
			n = 0 
			m = 0
			for i = 1,#p_3 do 
				local xx,yy = 53,20
				local smsize,h1,hs1,s1,smwz,myh1 = size*0.9,0,0,0,p_3[i][4],3
				if px > bx*625+n*bx*325 and px < bx*625+n*bx*325 + xx and py > by*640+m*bx*35 and py < by*640+m*bx*35 + yy then
					lib.LoadPNG(91,37 * 2 , bx*625+n*bx*325-bx*165, by*640+m*bx*35, 1)
					tjm(bx*635+n*bx*325-bx*165, by*645+m*bx*35,smwz,C_WHITE,size*0.6,7,size*0.6)
				end
				local x1,y1 = bx*685+n*bx*325,by*650+m*bx*35
				local pcw, pch = lib.GetPNGXY(91, 235 * 2);  
				if px > x1 and px < x1 + pcw and py > y1 and py < y1 + pch then 
					DrawString(bx*625+n*bx*325,by*640+m*bx*35,p_3[i][1]..'成长: '.. p_3[i][5],M_DarkOrange,size*0.9)
				end
				n = n + 1
				if n == 2 then
					n = 0
					m = m + 1
				end
			end
			n = 0
			m = 0	

		end
		if page == 2 then 			
			local n,m = 0,0		
			--925 684
			local jtzbx,jtzby = bx*925,by*684
			if px >= jtzbx and px <= jtzbx + CC.ScreenW/22.666 and py >= jtzby and py <= jtzby+by*60  then
				local jtwg = JY.Person[id]["天赋外功"..1]
				local jtname = JY.Wugong[jtwg]['名称']
				DrawString(jtzbx+size*3-string.len(jtname)/4*size2-size*2,jtzby-size*0.5,jtname,C_WHITE,size2)
			end
			if px >= jtzbx + bx*62 and px <= jtzbx + bx*110 and py >= jtzby and py <= jtzby+by*60  then
				local jtwg = JY.Person[id]["天赋外功"..2]
				local jtname = JY.Wugong[jtwg]['名称']
				DrawString(jtzbx+size*5-string.len(jtname)/4*size2-size*2,jtzby-size*0.5,jtname,C_WHITE,size2)
			end
			if px >= jtzbx + bx*120 and px <= jtzbx + bx*170 and py >= jtzby and py <= jtzby+by*60  then
				local jtwg = JY.Person[id]["天赋内功"]
				local jtname = JY.Wugong[jtwg]['名称']
				DrawString(jtzbx+size*7-string.len(jtname)/4*size2-size*2,jtzby-size*0.5,jtname,C_WHITE,size2)
			end
			if px >= jtzbx + bx*178 and px <= jtzbx + bx*230 and py >= jtzby and py <= jtzby+by*60  then
				local jtwg = JY.Person[id]["天赋轻功"]
				local jtname = JY.Wugong[jtwg]['名称']
				DrawString(jtzbx+size*9-string.len(jtname)/4*size2-size*2,jtzby-size*0.5,jtname,C_WHITE,size2)
			end
			--武功列表		
			for i = 1,JY.Base["武功数量"] do 
				if JY.Person[id]['武功'..i] > 0 then 
					local k = JY.Person[id]['武功'..i]
					local kname = JY.Wugong[k]['名称']							
					lib.LoadPNG(91,281*2,CC.ScreenW/2-CC.ScreenW/53 +n*p2x,wgy1 + CC.ScreenH/2.37+m*p2y,1)	--武功图标背景
					lib.LoadPNG(98,(500+k)*2,CC.ScreenW/2-CC.ScreenW/80 +n*p2x,wgy1 + CC.ScreenH/2.31+m*p2y,1) --武功图标
					DrawString(CC.ScreenW/2 +n*p2x-string.len(kname)/4*size*0.66,wgy1 + by*395+m*p2y,kname,C_WHITE,size*0.68)
					local zbwg = {JY.Person[id]["优先使用"],JY.Person[id]["主运内功"],JY.Person[id]["主运轻功"]}
					for z = 1,#zbwg do 
						if k == zbwg[z] then 
							lib.LoadPNG(91,99*2,CC.ScreenW/2 +n*p2x+CC.ScreenW/35,wgy1 + by*338+m*p2y,1)
						end
					end
					if kid == i then			
						lib.LoadPNG(91,288*2,CC.ScreenW/2-CC.ScreenW/53 +n*p2x,wgy1 + CC.ScreenH/2.37+m*p2y,1,0,130)						
					end
					n = n + 1
					if n == rnum then 
						n = 0
						m = m + 1
					end

					local level = KF_level(id,k)
					local wglx1 = JY.Wugong[k]["武功类型"]	
					local wugongwl = get_skill_power(id, k, level)
					local nn
					if JY.Wugong[k]["武功类型"] < 6 then 
						nn = 1
					end
					if JY.Wugong[k]["武功类型"] == 6 then 
						nn = 2
					end
					if JY.Wugong[k]["武功类型"] == 7 then 
						nn = 3
					end
					kfmenu[i] = {k,wugongwl,nn,level,i} --编号，威力，
				end
			end
			--精通武功 天赋武功
			local p_2 = {'天赋外功1','天赋外功2','天赋内功','天赋轻功'}
			for i=1,#p_2 do 
				if p[p_2[i]] > 0 then --936 696
					lib.LoadPNG(98,(500+p[p_2[i]] )*2,CC.ScreenW/1.46+(i-1)*bx*57,CC.ScreenH/1.105,1)
				end
			end
			--武功说明
			for i = 0, JY.ThingNum - 1 do
				local wugong = JY.Thing[i]["练出武功"]
				if wugong > 0 then
					JY.Thing[i]["需经验"] = JY.Wugong[wugong]["层级"]*100
					if JY.Wugong[wugong]["层级"] > 2 then
						JY.Thing[i]["需经验"] = JY.Wugong[wugong]["层级"]*300
					end
				end
			end
			for i = 1,#kfmenu do					
				local name = JY.Wugong[kfmenu[i][1]]["名称"]	
				wgmenu[i] = {kfmenu[i][1],name,kfmenu[i][4],kfmenu[i][2],kfmenu[i][5]} -- 编号，名称，威力，等级,位置,秘籍
			end
			--say(kid,0,0)                    
            --说明
			if WGSHUOMING > 0 then											
				local cl = color	
				local menu1 = wgmenu[kid]							
				local kf1 =menu1[1]
				local thid = KF_thing(kf1)
				local myThing = JY.Thing[thid]
				local me = JY.Wugong[kf1]["名称"]
				local wgmp =  MPname[JY.Wugong[kf1]["门派"] + 1]
				local level = menu1[3]
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
					if WGSHUOMING == 2 then 
						wgbj = 287 
					end
					--新武功说明背景图
					wgbj = 368
					local wgcl = cl 
					if JY.Wugong[kf1]["层级"] == 1 then
						wgcl = M_LightBlue
					end
					if JY.Wugong[kf1]["层级"] == 2 then
						wgcl = M_Purple
					end 
					if JY.Wugong[kf1]["层级"] == 3 then
						wgcl = Color_Hurt1
					end 
					if JY.Wugong[kf1]["层级"] == 4 then
						wgcl = C_RED
					end 
					local pwz1,pwz2,pwz3,pwz4,pwz5,pwz6 = nil,nil,nil,nil,nil,nil
					lib.LoadPNG(91,wgbj*2,-1,-1,1) 
					--if wlglx
					if JY.Wugong[kf1]['武功类型'] < 6  then 
						if WGSHUOMING == 1 then 
							lib.LoadPNG(91,369*2,-1,-1,1)  -- 招式背景
						end
					end
					lib.LoadPNG(91,371*2,CC.ScreenW/5,CC.ScreenH/2.6,1,0,90)  -- 武功名字背景
					if inteam(id) == false then
					else
						lib.LoadPNG(91,38*2,CC.ScreenW/3.3,CC.ScreenH-size*1.5,1,0,100)  -- 右下角确定键背景
					end
					lib.LoadPNG(91,14*2,size/3,CC.ScreenH/2-size*2.8,1,0,80)  -- 切换武功说明图片
					--DrawString(wgzbx-size*1.5 , wgzby-size*1,wz2[menu1[5]],color,size*0.9)--武功编号
					--lib.DrawStr(bx*363-string.len(JY.Wugong[kf1]["名称"])/4*size,by*310,JY.Wugong[kf1]["名称"], M_Gray,size*1.8, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)	--武功名称显示			
					lib.DrawStr(bx*361-string.len(JY.Wugong[kf1]["名称"])/4*size,by*305,JY.Wugong[kf1]["名称"], wgcl,size*1.8, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)	--武功名称显示	
						
					--tjm(wgzbx,wgzby,"品阶"..":"..pjwz[JY.Wugong[kf1]["层级"]],color,wgsize,11,size*0.8)  --品阶
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
									local id = KF_thing(kf1)
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
					DrawString(wgzbx,wgzby,"门派"..":  "..wgmp..' '..wglx[JY.Wugong[kf1]['武功类型']],C_BLACK,wgsize)    --门派 第一排文字
					DrawString(wgzbx,wgzby+jg1,"修为"..":  "..wz[level].." ".."("..djwz[level]..")",C_BLACK,wgsize)  --修为  --修为 第二排文字
					DrawString(wgzbx,wgzby+jg1*2,pwz1,C_BLACK,wgsize) --第三排文字
					DrawString(wgzbx,wgzby+jg1*3,pwz2,C_BLACK,wgsize) --第四排文字
					DrawString(wgzbx,wgzby+jg1*4,pwz3..'   '..pwz4,C_BLACK,wgsize) --第五排文字
					DrawString(wgzbx,wgzby+jg1*5,pwz5,C_BLACK,wgsize) --第六排文字
					DrawString(wgzbx,wgzby+jg1*6,pwz6,C_BLACK,wgsize) --第七排文字
					--DrawString(wgzbx,wgzby+jg1*5,pwz4,C_WHITE,wgsize) --第四排文字
					--DrawString(wgzbx,wgzby+jg1*5,pwz4,C_WHITE,wgsize) --第四排文字
					if WGSHUOMING == 1 then						
						if JY.Wugong[kf1]["武功类型"] < 6 then
							
							for j = 1,#CC.KFMove[menu1[1]]  do
								local leixing = {91,92,93,94,95,96}
								local lxpic = leixing[JY.Wugong[kf1]["武功类型"]]
								local zsnum = CC.WUGONGZS[menu1[5]][j]
								if JY.Person[id]["武功招式"..zsnum] == 0 then
									lib.LoadPNG(91,lxpic*2,bx*zszb[j][1]-CC.ScreenW/55,zsh+by*zszb[j][2]+by*64,1,0,90)
								else
									lib.LoadPNG(98,(500+kf1)*2,bx*zszb[j][1]-CC.ScreenW/55,zsh+by*zszb[j][2]+by*64,1,0,90)
								end
								local zssm = {}
								local CAOZSM = {}  
								zsn = #CC.KFMove[kf1]
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
								--local zzz = tb4
								if tb4 > 6 then
									tb4 = 6
								end
								local nnn =  wugongwl*(1+(tb4-1)/10)
								local sz = math.ceil(atk*(1+nnn/2000))
								local sznum = {"一","二","三","四","五","六","七","八","九","十"}
								--local wz1 = "造成基础伤害"..'Ｇ'..sz.."Ｗ".."点。"
								--local zsname = CC.KFMove[kf1][j][1] 
								--local zswz = nil
								--local zswz1 = nil

								if tb4 == j then
									lib.LoadPNG(91,88*2,bx*zszb[j][1]-CC.ScreenW/55,zsh+by*zszb[j][2]+by*64,1,0,95)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
									--DrawString(wgzbx-size,wgzby+size*7,JY.Wugong[kf1]["名称"].."第Ｇ"..sznum[tb4].."Ｈ招:Ｄ"..zsname.."     耗气  Ｄ"..CC.KFMove[kf1][j][3],C_CYGOLD,wgsize)	
									tjm(zsw + wgzbx-size,zsh+wgzby+size*7,"Ｇ"..JY.Wugong[kf1]["名称"].."Ｗ第Ｄ"..sznum[tb4].."Ｗ招:Ｄ"..CC.KFMove[kf1][j][1],C_WHITE,wgsize,30,wgsize)
									tjm(zsw + wgzbx+size*8,zsh+wgzby+size*7,"Ｗ    耗气 Ｄ"..CC.KFMove[kf1][j][3],C_WHITE,wgsize,30,wgsize)																								
									local hs = 0
									local ZUIDHS = 4   
									--zswz1 = KF_zswz(kf1,tb4)                               
									--zswz1 = wz1..""..zswz1		
									h = tjm(zsw + wgzbx-size,zsh+wgzby+size*7.7+size* (hs-WGSTARTH1),"造成基础伤害"..'Ｇ'..sz.."Ｗ".."点。"..''..KF_zswz(kf1,tb4), C_WHITE,wgsize*0.9,21,wgsize*0.8,WGSTARTH1-hs,ZUIDHS+1-hs+WGSTARTH1)			
									hs = hs + h	
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
					elseif  WGSHUOMING == 2 then 
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
					
					for p = 1,#zb5 do
						local cl1 = C_WHITE		
						local quxiao = 	"取消"	
						local yungong = "运功"
						local manji = "满级"
						local xiulian = "修炼"		
						if inteam (id) == true then 
							if JY.Wugong[JY.Person[id]["武功"..kid]]["武功类型"] < 6 then
								local yg = nil
								if  JY.Person[id]["优先使用"] > 0  then
									yg = quxiao
								else
									yg = yungong
								end
								if JY.Person[id]["优先使用"] > 0 and JY.Person[id]["优先使用"] ~= JY.Person[id]["武功"..kid] then
									yg = yungong
								end 
								local zbwz5 = {yg,xiulian}
								local zbwz6 = {yg,manji}
								if tb5 == p then
									cl1 = C_RED
								end
			
								if level < 10 then
									lib.DrawStr(bx*zb5[p][1]-wzbx6*0.99,by*zb5[p][2]+wzby6,zbwz5[p], cl1,size*0.9, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)	
								else
									lib.DrawStr(bx*zb5[p][1]-wzbx6*0.99,by*zb5[p][2]+wzby6,zbwz6[p], cl1,size*0.9, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)		
								end	
							end
							if JY.Wugong[JY.Person[id]["武功"..kid]]["武功类型"] == 6 then
								local yg = nil
								if  JY.Person[id]["主运内功"] > 0  then
									yg = quxiao
								else
									yg = yungong
								end
								if JY.Person[id]["主运内功"] > 0 and JY.Person[id]["主运内功"] ~= JY.Person[id]["武功"..kid] then
									yg = yungong
								end 
								local zbwz5 = {yg,xiulian}
								local zbwz6 = {yg,manji}
								if tb5 == p then
									cl1 = C_RED
									--lib.LoadPNG(91,120*2,bx*zb5[p][1]-wzbx6+size,by*zb5[p][2]+wzby6+size*0.5,zbwz5[p],1)
								end
			
								if level < 10 then
									--DrawString(bx*zb5[p][1]-wzbx6*0.99,by*zb5[p][2]+wzby6,zbwz5[p],cl1,size*0.9)
									lib.DrawStr(bx*zb5[p][1]-wzbx6*0.99,by*zb5[p][2]+wzby6,zbwz5[p], cl1,size*0.9, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)	
								else
									--DrawString(bx*zb5[p][1]-wzbx6*0.99,by*zb5[p][2]+wzby6,zbwz6[p],cl1,size*0.9)	
									lib.DrawStr(bx*zb5[p][1]-wzbx6*0.99,by*zb5[p][2]+wzby6,zbwz6[p], cl1,size*0.9, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)	
								end	
							end								
							if JY.Wugong[JY.Person[id]["武功"..kid]]["武功类型"] == 7 then
								local yg = nil
								if  JY.Person[id]["主运轻功"] > 0  then
									yg = quxiao
								else
									yg = yungong
								end
								if JY.Person[id]["主运轻功"] > 0 and JY.Person[id]["主运轻功"] ~= JY.Person[id]["武功"..kid] then
									yg = yungong
								end 
								local zbwz5 = {yg,xiulian}
								local zbwz6 = {yg,manji}
								if tb5 == p then
									cl1 = C_RED
									--lib.LoadPNG(91,120*2,bx*zb5[p][1]-wzbx6+size,by*zb5[p][2]+wzby6+size*0.5,zbwz5[p],1)
								end
			
								if level < 10 then
									lib.DrawStr(bx*zb5[p][1]-wzbx6*0.99,by*zb5[p][2]+wzby6,zbwz5[p], cl1,size*0.9, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)	
								else
									lib.DrawStr(bx*zb5[p][1]-wzbx6*0.99,by*zb5[p][2]+wzby6,zbwz6[p], cl1,size*0.9, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)	
								end	
							end	
						end	
					end	
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
					if level >= 10 then
						r = "――"
					end
					--升级经验
					--修炼经验
					DrawString(wgzbx-size, CC.ScreenH-size," 修炼点数： "..math.modf(JY.Person[id]["物品修炼点数"]).."    ".."升级需："..r, C_WHITE,wgsize)
				end
			end    
			if xlsm == 1 then 
				lib.LoadPNG(91, 90 * 2 , bx*382, by*540, 1,0,220 )
				DrawString(bx*382, by*559,"修炼点数不够",C_RED,size*1.4)
			end 
			if xlsm == 2 then 
				lib.LoadPNG(91, 90 * 2 , bx*382, by*540, 1,0,220 )
				DrawString(bx*382, by*559,"武功已修炼满级",C_RED,size*1.4)
			end        			
		end
		if page == 3 then 
			local n,m = 0,0	
			local x1,y1 = lib.GetPNGXY(98,1*2)	
			local x2,y2 = lib.GetPNGXY(91,281*2) 

			for i = 1,10 do 
				if JY.Person[id]['秘技'..i] > 0 then 
					MJMenu[i] = {JY.Person[id]['秘技'..i],i}
					----lib.Debug('秘技数量'..#MJMenu)
					local k = JY.Person[id]['秘技'..i]
					local kname = JY.Teji[k]['名称']						
					lib.LoadPNG(91,281*2,CC.ScreenW/2 +n*p2x-x2/2,by*400+m*p2y-y2/2,1)		
					lib.LoadPNG(98,(500+k)*2,CC.ScreenW/2 +n*p2x-x1/2,by*400+m*p2y-y1/2,1)
					DrawString(CC.ScreenW/2 +n*p2x-string.len(kname)/4*size*0.66,by*440+m*p2y,kname,C_WHITE,size*0.68)
					if mid == i then			
						lib.LoadPNG(91,288*2,CC.ScreenW/2 +n*p2x-size,by*400+m*p2y-size,1,0,130)												
					end
					n = n + 1
					if n == rnum then 
						n = 0
						m = m + 1
					end
				end
			end 

			if JY.Teji[JY.Person[id]['秘技'..mid]]["名称"] ~= '无' then 
				local mjname = JY.Teji[JY.Person[id]['秘技'..mid]]["名称"]
				if MJSHUOMING == 1 then
					lib.LoadPNG(91,368*2,-1,-1,1)
					lib.DrawStr(CC.ScreenW/10-string.len(mjname)/4*size-size,by*303,'■'..mjname..'■', M_Gray,size*1.2, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)	--秘技名称显示			
					lib.DrawStr(CC.ScreenW/10-string.len(mjname)/4*size-size,by*300,'■'..mjname..'■', C_RED,size*1.2, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)	--秘技名称显示						
					miji_info(JY.Person[id]['秘技'..mid])
				end
			end
		end
		if page == 4 then 
			if tb == 5 then
				tjm(bx*336+p_3x,by*150+p_3y,smwz[2],C_BLACK,size*0.8,29,size*0.8)
			else
				tjm(bx*336+p_3x,by*150+p_3y,smwz[1],C_BLACK,size*0.8,29,size*0.8)
			end
			for i = 1,#menu do
				local cl = color
				local smsize = CC.DefaultFont*0.6
				if tb == 1  then
					local menu1 = {}	
					local h1 = 0
					local me = {}
					local hs1 = 0
					local myh1 = 3
					for j = 1,#ssymenu do
						local cl = C_WHITE
						if tb1 == j  then
							cl =  C_RED
							lib.LoadPNG(91,225 * 2 , -1, -1, 1)					
							for p = 1,#ssymenu[j] do
								local qx = ssymenu[j]
								local name = qx[p][1]
								local stn = string.len(name) / 2
								local hsize = bx*40/stn
								local cl1 = C_WHITE1	
								local x,y = bx*qx[p][6]+p_3x,by*qx[p][7]+p_3y													
								if cot1 > 0 then
									rwqx = ssymenu[tb1][cot1][8]
								end
								local n = ssymenu[tb1][p][8]
								local jh = 0
								local jh1 = 0
								if j == 2  then
									jh = by*55
								elseif j == 1 or j == 3 then
									jh1 = by*35
								end
								local x1,y1 = bx*230+p_3x,by*230+p_3y						
								local ycolor;

								local x4,y4 = x-CC.ScreenW/272- size*0.7,y-CC.ScreenH/152- size*0.7 																
								--特殊经脉
								local TSJM = CC.TSJM_SSYIN 
								for pa =1, #TSJM do 
									if TSJM[pa][3]  == n  then 
										ycolor = 319+pa 
										lib.LoadPNG(91,ycolor * 2 ,x4, y4, 1,0,40)																				
										if JY.Person[id]["奇穴"..n] < 1  then
											lib.LoadPNG(91,362 * 2 ,x4, y4, 1,0,40)											
										end	
									end	
								end

								--经脉点文字和图片
								if JY.Person[id]["奇穴"..n] > 0  then	
									lib.LoadPNG(91,129 * 2 ,x4+size*0.7, y4+size*0.7, 1)									
									xcolor = C_RED
									if cot1 ~= p then
										cl1 = C_ORANGE
									else 
										cl1 = C_RED
									end
									if IsOuNumber(p) then
										draw3(name,x+bx*2,y- ((stn-1)*hsize+size*0.7)/2-by*40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,231 * 2 ,x-bx*14, y-by*70, 1)	
									else
										draw3(name,x+bx*2,y- ((stn-1)*hsize+size*0.7)/2+by*40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,230 * 2 ,x-bx*14, y+by*5, 1)	
									end	
									
								else
									lib.LoadPNG(91,128 * 2 ,x4+size*0.7, y4+size*0.7, 1)
									if IsOuNumber(p) then
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2-40, cl1, size*0.7,nil,hsize)
				 						lib.LoadPNG(91,231 * 2 ,x-bx*14, y-by*70, 1)	
									else
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2+40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,230 * 2 ,x-bx*14, y+by*5, 1)	
									end	
								end	 
								
								--选择经脉时
								if cot1 == p and lb == 3  then 
									
									--特殊经脉奇穴判定	
									local tsjmpd = 0
									for tt =1, #TSJM do 
										if  n == TSJM[tt][3]  then 
											tsjmpd = tt 
										end
									end
									lib.LoadPNG(91,209 * 2 ,CC.ScreenW/2+size,CC.ScreenH/2-size*5, 1) --特殊经脉条件背景 

									local cot1sm = ''
									if cot1 == 1 then 
										cot1sm = '，需要最少学会一门内功'
									end
									tjm(CC.ScreenW/2+size*3.1,CC.ScreenH/2-size*3.9,'需'..qx[p][5]..'点武学经验'..cot1sm,C_WHITE,size*0.8,11,size*0.9)

									lib.LoadPNG(91,208 * 2 ,CC.ScreenW-size*9.3, CC.ScreenH/2+size, 1) --经脉名字背景
									cl1 = C_RED
									lib.LoadPNG(91,67 * 2 ,x-CC.ScreenW/136, y-CC.ScreenH/76.8, 1) --选择图标

									tjm(bx*200+bx*710+p_3x,by*33+by*212+p_3y,name,cl1,size*0.9,11,size*0.9) --经脉名字
									tjm(bx*170+bx*700+p_3x,by*33+by*245+p_3y,qx[p][2].." +"..qx[p][3],M_Wheat,size*0.8,11,size*0.8) --属性
									

									if tsjmpd > 0 then 
										local tsy = size
										local h2,hs2,myh2,STARTH2 = 0,0,10,0
										
										lib.LoadPNG(91,363 * 2 ,CC.ScreenW-size*9.5, CC.ScreenH/2+size*3.5, 1)
										tjm(bx*200+bx*705+p_3x,tsy +size*1.4 + by*30+by*212+p_3y,TSJM[tsjmpd][1] ,C_WHITE,size*0.8,11,size*0.8)
										h2 = tjm(bx*197+bx*660+p_3x, tsy+by*3 + by*33+by*280 + smsize* (hs2-STARTH2)+p_3y, TSJM[tsjmpd][2], C_WHITE1, smsize,8,smsize,STARTH2-hs2,myh2+1-hs2+STARTH2)			
										hs2 = hs2 + h2	
										local h3,hs3,myh3 = 0,0,10										
										h3 = tjm(CC.ScreenW/2+size*3.1,CC.ScreenH/2-size*9 + size*0.8* (hs3-STARTH2)+p_3y, TSJM[tsjmpd][4], C_WHITE, size*0.8,11,size*0.8,STARTH2-hs3,myh3+1-hs3+STARTH2)	--条件文字		
										hs3 = hs3 + h3
										tsjmpd = 1
									end 
									if tsjmpd == 0 then 			
										h1 = tjm(bx*220+bx*660+p_3x, by*33+by*280 + smsize* (hs1-STARTH1)+p_3y, qx[cot1][4], C_WHITE1, smsize,7,smsize,STARTH1-hs1,myh1+1-hs1+STARTH1) --经脉百科			
										hs1 = hs1 + h1
										if hs1 > myh1 then
											FY1 = limitX(hs1-myh1-1,0)
										else
											FY1 = 0
										end	
									end
									if JY.Person[id]["奇穴"..n] == 0  then
										lib.LoadPNG(91,210 * 2 ,CC.ScreenW/2+size,CC.ScreenH/2-size*5, 1) --特殊经脉条件背景 2
									end
								end					
							end										
						end
						if lb > 1 then
							DrawString(bx*212+bx*145+p_3x,by*33+by*260+by*(j-1)*size*0.9+p_3y,ssanyin[j], cl,size*0.75)					
						end
					end
					if lb > 1 then
						if i > 1 then
							lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+by*80+p_3y,1)		
						end
					else
						lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
					end
					if tb == i then
						local n = menu[tb][2]
						lib.LoadPNG(91,n*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
						lib.LoadPNG(91,223*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
					end

				elseif tb == 2  then
					local menu1 = {}	
					local h1 = 0
					local me = {}
					local hs1 = 0
					local myh1 = 3
					for j = 1,#ssyangmenu do
						local cl = C_WHITE							
						if tb1 == j  then
							cl =  C_RED
							if tb1 ==1 or tb1 == 3 then 
								lib.LoadPNG(91,226 * 2 ,-1, -1, 1)
							else
								lib.LoadPNG(91,373 * 2 ,-1, -1, 1)
							end					
							for p = 1,#ssyangmenu[j] do
								local qx = ssyangmenu[j]
								local name = qx[p][1]
								local stn = string.len(name) / 2
								local hsize = bx*40/stn
								local cl1 = C_WHITE1	
								local x,y = bx*qx[p][6]+p_3x,by*qx[p][7]+p_3y													
								if cot1 > 0 then
									rwqx = ssyangmenu[tb1][cot1][8]
								end
								local n = ssyangmenu[tb1][p][8]
								local x1,y1 = bx*230+p_3x,by*230+p_3y
								local xcolor = M_Gray
								local ycolor;
														
								local x4,y4 = x-CC.ScreenW/272- size*0.7,y-CC.ScreenH/152- size*0.7 																
								--特殊经脉
								local TSJM = CC.TSJM_SSYANG 
								for pa =1, #TSJM do 
									if TSJM[pa][3]  == n  then 
										ycolor = 319+pa+9 
										lib.LoadPNG(91,ycolor * 2 ,x4, y4, 1,0,40)																				
										if JY.Person[id]["奇穴"..n] < 1  then
											lib.LoadPNG(91,362 * 2 ,x4, y4, 1,0,40)											
										end	
									end	
								end

								--经脉点文字和图片
								if JY.Person[id]["奇穴"..n] > 0  then	
									lib.LoadPNG(91,129 * 2 ,x4+size*0.7, y4+size*0.7, 1)									
									xcolor = C_RED
									if cot1 ~= p then
										cl1 = C_ORANGE
									else 
										cl1 = C_RED
									end
									if IsOuNumber(p) then
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2-40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,231 * 2 ,x-bx*14, y-by*70, 1)	
									else
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2+40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,230 * 2 ,x-bx*14, y+by*5, 1)	
									end	
									
								else
									lib.LoadPNG(91,128 * 2 ,x4+size*0.7, y4+size*0.7, 1)
									if IsOuNumber(p) then
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2-40, cl1, size*0.7,nil,hsize)
				 						lib.LoadPNG(91,231 * 2 ,x-bx*14, y-by*70, 1)	
									else
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2+40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,230 * 2 ,x-bx*14, y+by*5, 1)	
									end	
								end	 

								--选择经脉时
								if cot1 == p and lb == 3  then 
									
									--特殊经脉奇穴判定	
									local tsjmpd = 0
									for tt =1, #TSJM do 
										if  n == TSJM[tt][3]  then 
											tsjmpd = tt 
										end
									end
									lib.LoadPNG(91,209 * 2 ,CC.ScreenW/2+size,CC.ScreenH/2-size*5, 1) --特殊经脉条件背景 

									local cot1sm = ''
                                    if cot1 == 1 then 
                                        cot1sm = '，需要最少学会一门内功'
                                    end
                                    tjm(CC.ScreenW/2+size*3.1,CC.ScreenH/2-size*3.9,'需'..qx[p][5]..'点武学经验'..cot1sm,C_WHITE,size*0.8,11,size*0.9)
									lib.LoadPNG(91,208 * 2 ,CC.ScreenW-size*9.3, CC.ScreenH/2+size, 1) --经脉名字背景
									cl1 = C_RED
									lib.LoadPNG(91,67 * 2 ,x-CC.ScreenW/136, y-CC.ScreenH/76.8, 1) --选择图标

									tjm(bx*200+bx*710+p_3x,by*33+by*212+p_3y,name,cl1,size*0.9,11,size*0.9) --经脉名字
									tjm(bx*170+bx*700+p_3x,by*33+by*245+p_3y,qx[p][2].." +"..qx[p][3],M_Wheat,size*0.8,11,size*0.8) --属性
									

									if tsjmpd > 0 then 
										local tsy = size
										local h2,hs2,myh2,STARTH2 = 0,0,10,0
										
										lib.LoadPNG(91,363 * 2 ,CC.ScreenW-size*9.5, CC.ScreenH/2+size*3.5, 1)
										tjm(bx*200+bx*705+p_3x,tsy +size*1.4 + by*30+by*212+p_3y,TSJM[tsjmpd][1] ,C_WHITE,size*0.8,11,size*0.8)
										h2 = tjm(bx*197+bx*660+p_3x, tsy+by*3 + by*33+by*280 + smsize* (hs2-STARTH2)+p_3y, TSJM[tsjmpd][2], C_WHITE1, smsize,8,smsize,STARTH2-hs2,myh2+1-hs2+STARTH2)			
										hs2 = hs2 + h2	
										local h3,hs3,myh3 = 0,0,10										
										h3 = tjm(CC.ScreenW/2+size*3.1,CC.ScreenH/2-size*9 + size*0.8* (hs3-STARTH2)+p_3y, TSJM[tsjmpd][4], C_WHITE, size*0.8,11,size*0.8,STARTH2-hs3,myh3+1-hs3+STARTH2)	--条件文字		
										hs3 = hs3 + h3
										tsjmpd = 1
									end 
									if tsjmpd == 0 then 			
										h1 = tjm(bx*220+bx*660+p_3x, by*33+by*280 + smsize* (hs1-STARTH1)+p_3y, qx[cot1][4], C_WHITE1, smsize,7,smsize,STARTH1-hs1,myh1+1-hs1+STARTH1) --经脉百科			
										hs1 = hs1 + h1
										if hs1 > myh1 then
											FY1 = limitX(hs1-myh1-1,0)
										else
											FY1 = 0
										end	
									end
									if JY.Person[id]["奇穴"..n] == 0  then
										lib.LoadPNG(91,210 * 2 ,CC.ScreenW/2+size,CC.ScreenH/2-size*5, 1) --特殊经脉条件背景 2
									end
								end	
							end								
						end
						if lb > 1 then
							DrawString(bx*212+bx*145+p_3x,by*33+by*295+by*(j-1)*size*0.9+p_3y,ssanyang[j], cl,size*0.75)						
						end
					end
					if lb > 1 then
						if i > tb then
							lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+by*80+p_3y,1)	
						else
							lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
						end
					else
						lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
					end
					if tb == i then 
						local n = menu[tb][2]
						lib.LoadPNG(91,n*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
						lib.LoadPNG(91,223*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
					end	
				elseif tb == 3  then
					local menu1 = {}	
					local h1 = 0
					local me = {}
					local hs1 = 0
					local myh1 = 3
					for j = 1,#zsymenu do
						local cl = C_WHITE						
						if tb1 == j  then
							cl =  C_RED
							lib.LoadPNG(91,227*2,-1,-1,1)					
							for p = 1,#zsymenu[j] do
								local qx = zsymenu[j]
								local name = qx[p][1]
								local stn = string.len(name) / 2
								local hsize = bx*40/stn
								local cl1 = C_WHITE1
								local x,y = bx*qx[p][6]+p_3x,by*qx[p][7]+p_3y

								if cot1 > 0 then
									rwqx = zsymenu[tb1][cot1][8]
								end
								local n = zsymenu[tb1][p][8]
								local jh = 0
								local jh1 = 0
								if j == 2  then
									jh = by*55
								elseif j == 1 or j == 3 then
									jh1 = by*55
								end
								local x1,y1 = bx*230+p_3x,by*230+p_3y
								local xcolor = M_Gray
								local ycolor;

								local x4,y4 = x-CC.ScreenW/272- size*0.7,y-CC.ScreenH/152- size*0.7 																
								--特殊经脉
								local TSJM = CC.TSJM_ZSYIN 
								for pa =1, #TSJM do 
									if TSJM[pa][3]  == n  then 
										ycolor = 319+pa+9*2 
										lib.LoadPNG(91,ycolor * 2 ,x4, y4, 1,0,40)																				
										if JY.Person[id]["奇穴"..n] < 1  then
											lib.LoadPNG(91,362 * 2 ,x4, y4, 1,0,40)											
										end	
									end	
								end

								--经脉点文字和图片
								if JY.Person[id]["奇穴"..n] > 0  then	
									lib.LoadPNG(91,129 * 2 ,x4+size*0.7, y4+size*0.7, 1)									
									xcolor = C_RED
									if cot1 ~= p then
										cl1 = C_ORANGE
									else 
										cl1 = C_RED
									end
									if IsOuNumber(p) then
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2-40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,231 * 2 ,x-bx*14, y-by*70, 1)	
									else
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2+40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,230 * 2 ,x-bx*14, y+by*5, 1)	
									end	
									
								else
									lib.LoadPNG(91,128 * 2 ,x4+size*0.7, y4+size*0.7, 1)
									if IsOuNumber(p) then
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2-40, cl1, size*0.7,nil,hsize)
				 						lib.LoadPNG(91,231 * 2 ,x-bx*14, y-by*70, 1)	
									else
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2+40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,230 * 2 ,x-bx*14, y+by*5, 1)	
									end	
								end	 

								--选择经脉时
								if cot1 == p and lb == 3  then 									
									--特殊经脉奇穴判定	
									local tsjmpd = 0
									for tt =1, #TSJM do 
										if  n == TSJM[tt][3]  then 
											tsjmpd = tt 
										end
									end
									lib.LoadPNG(91,209 * 2 ,CC.ScreenW/2+size,CC.ScreenH/2-size*5, 1) --特殊经脉条件背景 
									
									local cot1sm = ''
                                    if cot1 == 1 then 
                                        cot1sm = '，需要最少学会一门内功'
                                    end
                                    tjm(CC.ScreenW/2+size*3.1,CC.ScreenH/2-size*3.9,'需'..qx[p][5]..'点武学经验'..cot1sm,C_WHITE,size*0.8,11,size*0.9)
									lib.LoadPNG(91,208 * 2 ,CC.ScreenW-size*9.3, CC.ScreenH/2+size, 1) --经脉名字背景
									cl1 = C_RED
									lib.LoadPNG(91,67 * 2 ,x-CC.ScreenW/136, y-CC.ScreenH/76.8, 1) --选择图标

									tjm(bx*200+bx*710+p_3x,by*33+by*212+p_3y,name,cl1,size*0.9,11,size*0.9) --经脉名字
									tjm(bx*170+bx*700+p_3x,by*33+by*245+p_3y,qx[p][2].." +"..qx[p][3],M_Wheat,size*0.8,11,size*0.8) --属性
									

									if tsjmpd > 0 then 
										local tsy = size
										local h2,hs2,myh2,STARTH2 = 0,0,10,0
										
										lib.LoadPNG(91,363 * 2 ,CC.ScreenW-size*9.5, CC.ScreenH/2+size*3.5, 1)
										tjm(bx*200+bx*705+p_3x,tsy +size*1.4 + by*30+by*212+p_3y,TSJM[tsjmpd][1] ,C_WHITE,size*0.8,11,size*0.8)
										h2 = tjm(bx*197+bx*660+p_3x, tsy+by*3 + by*33+by*280 + smsize* (hs2-STARTH2)+p_3y, TSJM[tsjmpd][2], C_WHITE1, smsize,8,smsize,STARTH2-hs2,myh2+1-hs2+STARTH2)			
										hs2 = hs2 + h2	
										local h3,hs3,myh3 = 0,0,10										
										h3 = tjm(CC.ScreenW/2+size*3.1,CC.ScreenH/2-size*9 + size*0.8* (hs3-STARTH2)+p_3y, TSJM[tsjmpd][4], C_WHITE, size*0.8,11,size*0.8,STARTH2-hs3,myh3+1-hs3+STARTH2)	--条件文字		
										hs3 = hs3 + h3
										tsjmpd = 1
									end 
									if tsjmpd == 0 then 			
										h1 = tjm(bx*220+bx*660+p_3x, by*33+by*280 + smsize* (hs1-STARTH1)+p_3y, qx[cot1][4], C_WHITE1, smsize,7,smsize,STARTH1-hs1,myh1+1-hs1+STARTH1) --经脉百科			
										hs1 = hs1 + h1
										if hs1 > myh1 then
											FY1 = limitX(hs1-myh1-1,0)
										else
											FY1 = 0
										end	
									end
									if JY.Person[id]["奇穴"..n] == 0  then
										lib.LoadPNG(91,210 * 2 ,CC.ScreenW/2+size,CC.ScreenH/2-size*5, 1) --特殊经脉条件背景 2
									end
								end	
							end								
						end
						if lb > 1 then
							DrawString(bx*212+bx*145+p_3x,by*33+by*340+by*(j-1)*size*0.9+p_3y,zsanyin[j], cl,size*0.75)						
						end

					end
					if lb > 1 then
						if i > tb then
							lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+by*80+p_3y,1)	
						else
							lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
						end	
					else
						lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
					end			
					if tb == i then 
						local n = menu[tb][2]
						lib.LoadPNG(91,n*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
						lib.LoadPNG(91,223*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
					end	
				elseif tb == 4  then
					local menu1 = {}	
					local h1 = 0
					local me = {}
					local hs1 = 0
					local myh1 = 3
					for j = 1,#zsyangmenu do
						local cl = C_WHITE							
						if tb1 == j  then
							cl =  C_RED
							lib.LoadPNG(91,228 * 2 ,-1, -1, 1)					
							for p = 1,#zsyangmenu[j] do
								local qx = zsyangmenu[j]
								local name = qx[p][1]
								local stn = string.len(name) / 2
								local hsize = bx*40/stn
								local cl1 = C_WHITE1
								local x,y = bx*qx[p][6]+p_3x,by*qx[p][7]+p_3y

								if cot1 > 0 then
									rwqx = zsyangmenu[tb1][cot1][8]
								end
								local n = zsyangmenu[tb1][p][8]
								local jh = 0
								local jh1 = 0
								if j == 2  then
									jh = by*55
								elseif j == 1 or j == 3 then
									jh1 = by*55
								end
								local x1,y1 = bx*230+p_3x,by*230+p_3y

								local xcolor = M_Gray
								local ycolor;

								local x4,y4 = x-CC.ScreenW/272- size*0.7,y-CC.ScreenH/152- size*0.7 																
								--特殊经脉
								local TSJM = CC.TSJM_ZSYANG 
								for pa =1, #TSJM do 
									if TSJM[pa][3]  == n  then 
										ycolor = 319+pa+9*3 
										lib.LoadPNG(91,ycolor * 2 ,x4, y4, 1,0,40)																				
										if JY.Person[id]["奇穴"..n] < 1  then
											lib.LoadPNG(91,362 * 2 ,x4, y4, 1,0,40)											
										end	
									end	
								end

								--经脉点文字和图片
								if JY.Person[id]["奇穴"..n] > 0  then	
									lib.LoadPNG(91,129 * 2 ,x4+size*0.7, y4+size*0.7, 1)									
									xcolor = C_RED
									if cot1 ~= p then
										cl1 = C_ORANGE
									else 
										cl1 = C_RED
									end
									if IsOuNumber(p) then
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2-40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,231 * 2 ,x-bx*14, y-by*70, 1)	
									else
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2+40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,230 * 2 ,x-bx*14, y+by*5, 1)	
									end	
									
								else
									lib.LoadPNG(91,128 * 2 ,x4+size*0.7, y4+size*0.7, 1)
									if IsOuNumber(p) then
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2-40, cl1, size*0.7,nil,hsize)
				 						lib.LoadPNG(91,231 * 2 ,x-bx*14, y-by*70, 1)	
									else
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2+40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,230 * 2 ,x-bx*14, y+by*5, 1)	
									end	
								end	 

								--选择经脉时
								if cot1 == p and lb == 3  then 
									
									--特殊经脉奇穴判定	
									local tsjmpd = 0
									for tt =1, #TSJM do 
										if  n == TSJM[tt][3]  then 
											tsjmpd = tt 
										end
									end
									lib.LoadPNG(91,209 * 2 ,CC.ScreenW/2+size,CC.ScreenH/2-size*5, 1) --特殊经脉条件背景 
									
									local cot1sm = ''
                                    if cot1 == 1 then 
                                        cot1sm = '，需要最少学会一门内功'
                                    end
                                    tjm(CC.ScreenW/2+size*3.1,CC.ScreenH/2-size*3.9,'需'..qx[p][5]..'点武学经验'..cot1sm,C_WHITE,size*0.8,11,size*0.9)
									lib.LoadPNG(91,208 * 2 ,CC.ScreenW-size*9.3, CC.ScreenH/2+size, 1) --经脉名字背景
									cl1 = C_RED
									lib.LoadPNG(91,67 * 2 ,x-CC.ScreenW/136, y-CC.ScreenH/76.8, 1) --选择图标

									tjm(bx*200+bx*710+p_3x,by*33+by*212+p_3y,name,cl1,size*0.9,11,size*0.9) --经脉名字
									tjm(bx*170+bx*700+p_3x,by*33+by*245+p_3y,qx[p][2].." +"..qx[p][3],M_Wheat,size*0.8,11,size*0.8) --属性
									

									if tsjmpd > 0 then 
										local tsy = size
										local h2,hs2,myh2,STARTH2 = 0,0,10,0
										
										lib.LoadPNG(91,363 * 2 ,CC.ScreenW-size*9.5, CC.ScreenH/2+size*3.5, 1)
										tjm(bx*200+bx*705+p_3x,tsy +size*1.4 + by*30+by*212+p_3y,TSJM[tsjmpd][1] ,C_WHITE,size*0.8,11,size*0.8)
										h2 = tjm(bx*197+bx*660+p_3x, tsy+by*3 + by*33+by*280 + smsize* (hs2-STARTH2)+p_3y, TSJM[tsjmpd][2], C_WHITE1, smsize,8,smsize,STARTH2-hs2,myh2+1-hs2+STARTH2)			
										hs2 = hs2 + h2	
										local h3,hs3,myh3 = 0,0,10										
										h3 = tjm(CC.ScreenW/2+size*3.1,CC.ScreenH/2-size*9 + size*0.8* (hs3-STARTH2)+p_3y, TSJM[tsjmpd][4], C_WHITE, size*0.8,11,size*0.8,STARTH2-hs3,myh3+1-hs3+STARTH2)	--条件文字		
										hs3 = hs3 + h3
										tsjmpd = 1
									end 
									if tsjmpd == 0 then 			
										h1 = tjm(bx*220+bx*660+p_3x, by*33+by*280 + smsize* (hs1-STARTH1)+p_3y, qx[cot1][4], C_WHITE1, smsize,7,smsize,STARTH1-hs1,myh1+1-hs1+STARTH1) --经脉百科			
										hs1 = hs1 + h1
										if hs1 > myh1 then
											FY1 = limitX(hs1-myh1-1,0)
										else
											FY1 = 0
										end	
									end
									if JY.Person[id]["奇穴"..n] == 0  then
										lib.LoadPNG(91,210 * 2 ,CC.ScreenW/2+size,CC.ScreenH/2-size*5, 1) --特殊经脉条件背景 2
									end
								end	
							end								
						end					
						if lb > 1 then
							DrawString(bx*212+bx*145+p_3x,by*33+by*380+by*(j-1)*size*0.9+p_3y,zsanyang[j], cl,size*0.75)							
						end
					end
					if lb > 1 then
						if i > tb then
							lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+by*80+p_3y,1)	
						else
							lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
						end	
					else
						lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
					end			
					if tb == i then 
						local n = menu[tb][2]
						lib.LoadPNG(91,n*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
						lib.LoadPNG(91,223*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
					end	
				elseif tb == 5  then
					local menu1 = {}	
					local h1 = 0
					local me = {}
					local hs1 = 0
					local myh1 = 3
					for j = 1,#renmaimenu do
						local cl = C_WHITE							
						if tb1 == j  then
							cl =  C_RED
							lib.LoadPNG(91,229 * 2 , -1, -1, 1)					
							for p = 1,#renmaimenu[j] do
								local qx = renmaimenu[j]
								local name = qx[p][1]
								local stn = string.len(name) / 2
								local hsize = bx*40/stn
								local cl1 = C_WHITE1
								local x,y = bx*qx[p][6]+p_3x,by*qx[p][7]+p_3y

								if cot1 > 0 then
									rwqx = renmaimenu[tb1][cot1][8]
								end
								local n = renmaimenu[tb1][p][8]
								local jh = 0
								local jh1 = 0
								if j == 2  then
									jh = by*55
								elseif j == 1 or j == 3 then
									jh1 = by*55
								end
								local x1,y1 = bx*230+p_3x,by*230+p_3y
								local x,y = bx*qx[p][6]+p_3x,by*qx[p][7]+p_3y
								local n1 = #renmaimenu[j]
								local xcolor = M_Gray
								local ycolor;


								local jx,jx1 = bx*10,bx*75
		
								if JY.Person[id]["奇穴"..n] > 0  then
									ycolor = 129
									if cot1 ~= p then
										cl1 = C_ORANGE
									end
									if IsOuNumber(p) then
										--draw3(name,x,y- ((stn-1)*hsize+size*0.7)/2+jh, cl1, size*0.7,nil,hsize)
										DrawString(x-string.len(name)/4*size2+size+jx,y-size*0.5,name,cl1,size*0.7)
										lib.LoadPNG(91,271 * 2 ,x+jx*0.5, y-size*0.6, 1)
									else
										--draw3(name,x,y- ((stn-1)*hsize+size*0.7)/2+jh1, cl1, size*0.7,nil,hsize)
										DrawString(x-string.len(name)/4*size2-size-jx,y-size*0.5,name,cl1,size*0.7)
										lib.LoadPNG(91,272 * 2 ,x-jx1*0.95, y-size*0.6, 1)
									end	
								else
									ycolor = 128
									if IsOuNumber(p) then
										--draw3(name,x,y- ((stn-1)*hsize+size*0.7)/2+jh, cl1, size*0.7,nil,hsize)
										DrawString(x-string.len(name)/4*size2+size+jx,y-size*0.5,name,cl1,size*0.7)
										lib.LoadPNG(91,271 * 2 ,x+jx*0.5, y-size*0.6, 1)
									else
										--draw3(name,x,y- ((stn-1)*hsize+size*0.7)/2+jh1, cl1, size*0.7,nil,hsize)
										DrawString(x-string.len(name)/4*size2-size-jx,y-size*0.5,name,cl1,size*0.7)
										lib.LoadPNG(91,272 * 2 ,x-jx1*0.95, y-size*0.6, 1)
									end	
								end
								lib.LoadPNG(91,ycolor * 2 ,x-CC.ScreenW/272, y-CC.ScreenH/152, 1)	

								local x4,y4 = x-CC.ScreenW/272- size*0.7,y-CC.ScreenH/152- size*0.7 																
								--特殊经脉
								local TSJM = CC.TSJM_RENDU 
								for pa =1, #TSJM do 
									if TSJM[pa][3]  == n  then 
										ycolor = 319+pa+9*4 
										lib.LoadPNG(91,ycolor * 2 ,x4, y4, 1,0,40)																				
										if JY.Person[id]["奇穴"..n] < 1  then
											lib.LoadPNG(91,362 * 2 ,x4, y4, 1,0,40)											
										end	
									end	
								end

								--经脉点文字和图片

								--选择经脉时
								if cot1 == p and lb == 3  then 
									
									--特殊经脉奇穴判定	
									local tsjmpd = 0
									for tt =1, #TSJM do 
										if  n == TSJM[tt][3]  then 
											tsjmpd = tt 
										end
									end
									lib.LoadPNG(91,209 * 2 ,CC.ScreenW/2+size,CC.ScreenH/2-size*5, 1) --特殊经脉条件背景 
									
									local cot1sm = ''
                                    if cot1 == 1 then 
                                        cot1sm = '，需要最少学会一门内功'
                                    end
                                    tjm(CC.ScreenW/2+size*3.1,CC.ScreenH/2-size*3.9,'需'..qx[p][5]..'点武学经验'..cot1sm,C_WHITE,size*0.8,11,size*0.9)
									lib.LoadPNG(91,208 * 2 ,CC.ScreenW-size*9.3, CC.ScreenH/2+size, 1) --经脉名字背景
									cl1 = C_RED
									lib.LoadPNG(91,67 * 2 ,x-CC.ScreenW/136, y-CC.ScreenH/76.8, 1) --选择图标

									tjm(bx*200+bx*710+p_3x,by*33+by*212+p_3y,name,cl1,size*0.9,11,size*0.9) --经脉名字
									tjm(bx*170+bx*700+p_3x,by*33+by*245+p_3y,qx[p][2].." +"..qx[p][3],M_Wheat,size*0.8,11,size*0.8) --属性
									

									if tsjmpd > 0 then 
										local tsy = size
										local h2,hs2,myh2,STARTH2 = 0,0,10,0
										
										lib.LoadPNG(91,363 * 2 ,CC.ScreenW-size*9.5, CC.ScreenH/2+size*3.5, 1)
										tjm(bx*200+bx*705+p_3x,tsy +size*1.4 + by*30+by*212+p_3y,TSJM[tsjmpd][1] ,C_WHITE,size*0.8,11,size*0.8)
										h2 = tjm(bx*197+bx*660+p_3x, tsy+by*3 + by*33+by*280 + smsize* (hs2-STARTH2)+p_3y, TSJM[tsjmpd][2], C_WHITE1, smsize,8,smsize,STARTH2-hs2,myh2+1-hs2+STARTH2)			
										hs2 = hs2 + h2	
										local h3,hs3,myh3 = 0,0,10										
										h3 = tjm(CC.ScreenW/2+size*3.1,CC.ScreenH/2-size*9 + size*0.8* (hs3-STARTH2)+p_3y, TSJM[tsjmpd][4], C_WHITE, size*0.8,11,size*0.8,STARTH2-hs3,myh3+1-hs3+STARTH2)	--条件文字		
										hs3 = hs3 + h3
										tsjmpd = 1
									end 
									if tsjmpd == 0 then 			
										h1 = tjm(bx*220+bx*660+p_3x, by*33+by*280 + smsize* (hs1-STARTH1)+p_3y, qx[cot1][4], C_WHITE1, smsize,7,smsize,STARTH1-hs1,myh1+1-hs1+STARTH1) --经脉百科			
										hs1 = hs1 + h1
										if hs1 > myh1 then
											FY1 = limitX(hs1-myh1-1,0)
										else
											FY1 = 0
										end	
									end
									if JY.Person[id]["奇穴"..n] == 0  then
										lib.LoadPNG(91,210 * 2 ,CC.ScreenW/2+size,CC.ScreenH/2-size*5, 1) --特殊经脉条件背景 2
									end
								end				
							end										
						end
						if lb > 1 then
							DrawString(bx*212+bx*145+p_3x,by*33+by*420+by*(j-1)*size*0.9+p_3y,renmai[j], cl,size*0.75)							
						end
					end
					lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
					if tb == i then 
						local n = menu[tb][2]
						lib.LoadPNG(91,n*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
						lib.LoadPNG(91,223*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
					end												
				end	
				local qxsmwz = {"前置经脉未激活","武学点数不够","未达到激活条件"}
				for j = 1,#qxsmwz do 
					local wz11 = qxsmwz[j]
					if qxsm == j then
						lib.LoadPNG(91, 90 * 2 , bx*382*2, by*550, 1,0,220 )
						DrawString(bx*382*2, by*559,wz11,C_RED,size*1.4)
						--DrawStrBoxWaitKey1(wz11, C_RED, CC.DefaultFont)
					end
				end
				if jmtx == 1 then 
					local jhwz = '激活经脉'..'成功'
					lib.LoadPNG(91, 90 * 2 , bx*382*2, by*550, 1,0,220 )
					DrawString(bx*382*2, by*559,jhwz,C_RED,size*1.4)
					--DrawStrBoxWaitKey1(jhwz, C_RED, CC.DefaultFont)					
				end
			end							

			if tb1 > 0 and tb > 0 then 
				local qx = jmmenu[tb][tb1]
				for ii = 1,#qx -1 do
					tjm12(bx*qx[ii][6]+p_3x,by*qx[ii][7]+p_3y,bx*qx[ii+1][6]+p_3x,by*qx[ii+1][7]+p_3y,C_WHITE)
				end	
			end
			if QXSHUOMING == 1 then
				lib.PicLoadCache(92,122*2,bx*212+bx*300+p_3x,by*33+by*226+p_3y,1)					
				local hs = 0
				local FY = 0
				local ZUIDHS = 15
				local h = 0
				local CAOZSM = {}  
				for z = 1,#CC.WGCZSM do
					CAOZSM[#CAOZSM+1] = CC.WGCZSM[z]
				end	
				h = tjm(bx*212+bx*454+p_3x, by*33+by*227+p_3y,CAOZSM[1], C_CYGOLD, size1*0.9,15,size1*0.9,FY-hs,ZUIDHS+1-hs+FY)	
				hs = hs + h							
				h = tjm(bx*212+bx*328+p_3x, by*33+by*260+p_3y,CAOZSM[2], C_WHITE, size1*0.7,15,size1*0.7,FY-hs,ZUIDHS+1-hs+FY)
				hs = hs + h
			end	
		end
		local zdmenu2 = {JY.Person[id]['行动方针'],JY.Person[id]['施毒方针'],JY.Person[id]['暗器方针']}	
		local zdmenu3 = {JY.Person[id]['吃红药方针'],JY.Person[id]['吃蓝药方针'],JY.Person[id]['吃黄药方针']}
		local zdmenu4 = {JY.Person[id]['复活方针'],JY.Person[id]['喝酒方针'],JY.Person[id]['备用方针1']}
		local zdxz = 1	
		if page == 5 then 
			--招式方式			
			for i = 1,#zdwz1 do 
				color = C_WHITE1
				if JY.Person[id]['招式方针'] == i then 
					lib.LoadPNG(91,36*2,bx*715+(i-1)*bx*34,by*385,1,0,bx*15) 
				end			
				if zdpage == 1 then 		
					if tb1 == i then 
						color = C_RED 
					end
				end
				DrawString(bx*717+(i-1)*bx*34,by*385,zdwz1[i],color,size2*1.2)
			end

			--攻击方针		
			for i = 1,3 do 			
				color = C_WHITE1
				zdxz = zdmenu2[i] + 1
				if zdpage == 2  then 	
					if lb1 == 2 then 
						if tb1 == i  then 
							color = C_RED
						end
					end	
				end 
				DrawString(bx*790-string.len(zdwz2[i][zdxz]) / 4 * size2*1.2 + (i-1)*165 ,by*461,zdwz2[i][zdxz],color,size2*1.2)
			end	
			--吃药方针				
			for i = 1,3 do 			
				color = C_WHITE1
				zdxz = zdmenu3[i] + 1
				if zdpage == 3  then 	
					if lb1 == 2 then 
						if tb1 == i  then 
							color = C_RED
						end
					end	
				end 
				DrawString(bx*790-string.len(zdwz3[i][zdxz]) / 4 * size2*1.2 + (i-1)*165 ,by*538,zdwz3[i][zdxz],color,size2*1.2)
			end	

			--其它方针				
			for i = 1,3 do 		
				color = C_WHITE1
				zdxz = zdmenu4[i] + 1
				if zdpage == 4  then 	
					if lb1 == 2 then 
						if tb1 == i  then 
							color = C_RED
						end
					end	
				end 
				DrawString(bx*790-string.len(zdwz4[i][zdxz]) / 4 * size2*1.2 + (i-1)*165 ,by*615,zdwz4[i][zdxz],color,size2*1.2)
			end	

			--第三层菜单
			if lb1 == 3 then 
				
				if zdpage == 2 then 
					lib.Background( bx*705 + (tb1-1)*165,by*490,bx*700 +bx*160+ (tb1-1)*165,by*461+(#zdwz2[tb1]+2)*size2*1.2,50)
					for j = 1,#zdwz2[tb1] do 
						color = C_WHITE1
						if tb2 == j  then 
							color = C_RED
						end					
						DrawString(bx*790-string.len(zdwz2[tb1][j]) / 4 * size2*1.2 + (tb1-1)*165,by*465+(j)*size2*1.2,zdwz2[tb1][j],color,size2*1.2)						
					end
				end
				if zdpage == 3 then 
					lib.Background( bx*705 + (tb1-1)*165,by*490+zh,bx*700 +bx*160+ (tb1-1)*165,by*461+(#zdwz3[tb1]+2)*size2*1.2+zh,50)
					for j = 1,#zdwz3[tb1] do 
						color = C_WHITE1
						if tb2 == j  then 
							color = C_RED
						end					
						DrawString(bx*790-string.len(zdwz3[tb1][j]) / 4 * size2*1.2 + (tb1-1)*165,by*465+(j)*size2*1.2+zh,zdwz3[tb1][j],color,size2*1.2)						
					end
				end
				if zdpage == 4 then 
					lib.Background( bx*705 + (tb1-1)*165,by*490+zh*2,bx*700 +bx*160+ (tb1-1)*165,by*461+(#zdwz4[tb1]+2)*size2*1.2+zh*2,50)
					for j = 1,#zdwz4[tb1] do 
						color = C_WHITE1
						if tb2 == j  then 
							color = C_RED
						end					
						DrawString(bx*790-string.len(zdwz4[tb1][j]) / 4 * size2*1.2 + (tb1-1)*165,by*465+(j)*size2*1.2+zh*2,zdwz4[tb1][j],color,size2*1.2)						
					end
				end
			end
		end
		ShowScreen()
		lib.Delay(CC.Frame)
		local X, ktype, mx, my = lib.GetKey();	
		if mx ~= -1 and my ~= -1 then 
			px,py = mx,my
		end
		if X == VK_ESCAPE or ktype == 4  then 	
			if page == 1 then
				lb1 = lb1 - 1 
				if lb1 < 1 then 
					lb1 = 1 
					break
				end 
				if TFSHUOMING == 1 then
					TFSHUOMING = 0
					tfid = 0
				end
			elseif page == 2 then 
				lb1 = lb1 - 1 
				if lb1 < 1 then 
					lb1 = 1 
					break
				end 
				if xlsm > 0 then 
					xlsm = 0
				end
				if lb1 == 2 then 
					WGSTARTH = 0 
				end
				if WGSHUOMING > 0 then
					WGSHUOMING = 0
				end
			elseif page == 3 then 
				lb1 = lb1 - 1
				if lb1 < 1 then 
					lb1 = 1 
					break
				end  
				if lb1 == 2 then 
					Mstarth = 0 
				end
				if MJSHUOMING > 0 then
					MJSHUOMING = 0				
				end	
			elseif page == 4 then 
				lb = lb - 1
				if lb < -1 then 
					lb = -1  
					break
				end
				if lb == 2 then
					tb1 = 1 
					cot1 = 1
				end
				if lb <= 1 then 
					tb1 = 1
					--tb = 1
				end
				if qxsm > 0 or jmtx > 0 then 
					qxsm = 0	
					jmtx = 0
				end	
			elseif page == 5 then 
				lb1 = lb1 - 1
				if lb1 < 1 then 
					lb1 = 1
					break
				end
			else
                break
			end			
			--lib.Debug('ESC当前所处lb='..lb..' 当前所处page='..page..' 当前所处lb1='..lb1)
		elseif X == VK_SPACE or X == VK_RETURN then	
			if page == 1 then 
				lb1 = lb1 + 1
				if lb1 > 2 then 				
					lb1 = 2
				end
				if lb1 == 2  then 
					tfid = 1
					TFSHUOMING = 1
				end
			elseif page == 2 then 
				lb1 = lb1 + 1 
				if lb1 > 3 then 				
					lb1 = 3
				end
				if lb1 == 3 then 
					WGSHUOMING = 1
				end 
				if WGSHUOMING == 1 then
					if inteam(id) == true then 
						if tb5 == 1 then	
							PlayWavE(77)
							if JY.Wugong[wgmenu[kid][1]]["武功类型"] < 6  then  --优先使用不等于当前选择								
								if  p["优先使用"] ~= wgmenu[kid][1] then
									----lib.Debug('外功有用')
									p["优先使用"] = wgmenu[kid][1]
								else
									p["优先使用"] = 0
								end
								Hp_Max(id)
								Mp_Max(id)
							elseif JY.Wugong[wgmenu[kid][1]]["武功类型"] == 6   then
								if  p["主运内功"] ~= wgmenu[kid][1] then
									--lib.Debug('内功有用')
									p["主运内功"] = wgmenu[kid][1]
									Hp_Max(id)
									Mp_Max(id)
								else
									p["主运内功"] = 0
									Hp_Max(id)
									Mp_Max(id)
								end
							elseif JY.Wugong[wgmenu[kid][1]]["武功类型"] == 7   then
								if  p["主运轻功"] ~= wgmenu[kid][1] then
									----lib.Debug('轻功有用')
									p["主运轻功"] = wgmenu[kid][1]
								else
									p["主运轻功"] = 0
								end
								Hp_Max(id)
								Mp_Max(id)
							end
						elseif tb5 == 2 then 	
							PlayWavE(77)
							local R = 0
							if wgmenu[kid][3] < 10 then
								if KF_thing(wgmenu[kid][1]) == nil then
									R = JY.Wugong[wgmenu[kid][1]]['层级']*80
								else
									R = math.modf((5-math.modf(25/25))*JY.Thing[KF_thing(wgmenu[kid][1])]["需经验"]*(wgmenu[kid][3]+1)*0.05);
								end
							end
							if wgmenu[kid][3] < 10   then
								if  p["物品修炼点数"] >= R then
									wgmenu[kid][3] = wgmenu[kid][3] + 1								
									JY.Person[id]["武功等级"..wgmenu[kid][5]] = JY.Person[id]["武功等级"..wgmenu[kid][5]] + 100
									KF_addsx(id,wgmenu[kid][1])
									p["物品修炼点数"] = p["物品修炼点数"] - R
									Hp_Max(id)
									Mp_Max(id)
								else
									xlsm = 1
								end
							else
								xlsm = 2
							end		
						end	
					end	
				end	
				if xlsm > 0 then 
					xlsm = 0
				end
			elseif page == 3 then 
				lb1 = lb1 + 1 
				if lb1 > 3 then 				
					lb1 = 3
				end
				if lb1 == 3 then 
					MJSHUOMING = 1
				end
			elseif page == 4 then 
				lb = lb + 1
				if lb > 3 then 
					lb  = 3 
				end 
				if lb == 3 then 
					if qxsm > 0 or jmtx > 0 then 
						qxsm = 0
						jmtx = 0						
					else	
						local pd = false	
						local jmjd =jmmenu[tb][tb1][cot1]
						local xhds = jmjd[5] 	
						if inteam(id) == true then 				
							if cot1 == 1  then							
								local ngn = {} 
								local ng0,ng1,ng2,ngdj = 0,0,0,0
								for w = 1,JY.Base["武功数量"] do 
									local wugong = JY.Person[id]["武功"..w]
									if wugong > 0 then
										if JY.Wugong[wugong]["武功类型"] == 6 then 
											ngn[#ngn+1] = wugong
										end
									end
								end
								--确定有学会合适的内功
								for j = 1,#ngn do 
									ngdj = JY.Wugong[ngn[j]]["层级"]
								end
								if  JY.Person[id]["奇穴"..rwqx] < 1 then
									if  ngdj >= 1   then 
										pd = true
									end
									if pd == true then 
										if JY.Person[id]["武学点数"] - jmjd[5] >= 0 then 
											JY.Person[id]["奇穴"..rwqx] = 1  --激活经脉
											jmtx = 1
											--JY.Person[id][jmjd[2]] = JY.Person[id][jmjd[2]] + jmjd[3]  --增加人物属性
											AddPersonAttrib(id,jmjd[2],jmjd[3])
											JY.Person[id]["武学点数"] = JY.Person[id]["武学点数"] - jmjd[5]
											--奇穴激活特效
										else
											qxsm = 2
										end
									else
										qxsm = 3	
									end
								end
							elseif cot1 > 1  then
								if JY.Person[id]["奇穴"..rwqx-1] > 0 then
									if  JY.Person[id]["奇穴"..rwqx] < 1 then 
										if JY.Person[id]["武学点数"] - xhds >= 0 then
											--特殊经脉
											local tsjme = {CC.TSJM_SSYIN,CC.TSJM_SSYANG,CC.TSJM_ZSYIN,CC.TSJM_ZSYANG,CC.TSJM_RENDU}
											local tsmenu = tsjme[tb]
											local tsqx = 0
											
											for t = 1,#tsmenu do 
												if tsmenu[t][3] == rwqx then 
													tsqx = 1
													--lib.Debug('判定成功 '..tsqx..'  经脉穴位== '..rwqx)
													break
												end
											end
											----lib.Debug('判定成功 '..tsqx..'  经脉穴位== '..rwqx)
											if  tsqx == 0  then 
												JY.Person[id]["奇穴"..rwqx] = 1  --激活经脉
												jmtx = 1
												--JY.Person[id][jmjd[2]] = JY.Person[id][jmjd[2]] + jmjd[3]  --增加人物属性
												AddPersonAttrib(id,jmjd[2],jmjd[3])
												JY.Person[id]["武学点数"] = JY.Person[id]["武学点数"] - xhds

											else
												if JMQX_JH(id,rwqx)  then 
													----lib.Debug('经脉奇穴判定成功')
													JY.Person[id]["奇穴"..rwqx] = 1  --激活经脉
													jmtx = 1 
													--JY.Person[id][jmjd[2]] = JY.Person[id][jmjd[2]] + jmjd[3]  --增加人物属性
													AddPersonAttrib(id,jmjd[2],jmjd[3])
													JY.Person[id]["武学点数"] = JY.Person[id]["武学点数"] - xhds
													if rwqx == 22 then 
														AddPersonAttrib(id, "攻击带毒", 20)
														AddPersonAttrib(id, "用毒能力", 20)														
													end
													if rwqx == 25 then 
														AddPersonAttrib(id, "用毒能力", 30)		
														if Pmiji(id,6) and Pmiji(id,8) then 
															AddPersonAttrib(id,'用毒能力',80)
														end												
													end													
													if rwqx == 28 then 
														AddPersonAttrib(id, "用毒能力", 100)														
													end
													if rwqx == 61 then 
														local jsx = JY.Person[id]['防御力']*0.1
														AddPersonAttrib(id, "防御力", jsx)														
													end
													if rwqx == 83 then 
														local jsx = JY.Person[id]['攻击力']*0.1
														AddPersonAttrib(id, "攻击力", jsx)														
													end		
													if rwqx == 95 then 
														local jsx = JY.Person[id]['基础生命']*0.1
														AddPersonAttrib(id, "基础生命", jsx)														
													end	
													if rwqx == 99 then 
														local jsx = JY.Person[id]['生命最大值']*0.1
														AddPersonAttrib(id, "生命最大值", jsx)														
													end	
													if rwqx == 106 then 
														local jsx = JY.Person[id]['轻功']*0.1
														AddPersonAttrib(id, "轻功", jsx)														
													end	
													if rwqx == 117 then 
														local jsx = 5
														AddPersonAttrib(id, "体质", jsx)														
													end		
													if rwqx == 129 then 
														local jsx = 1000
														AddPersonAttrib(id, "内力最大值", jsx)														
													end		
													if rwqx == 139 or rwqx == 149 then 
														local jsx = JY.Person[id]['防御力']*0.05
														AddPersonAttrib(id, "防御力", jsx)														
													end		
													if rwqx == 139 or rwqx == 149 then 
														local jsx = JY.Person[id]['攻击力']*0.05
														AddPersonAttrib(id, "攻击力", jsx)														
													end																																																																																
												else
													qxsm = 3
												end						
											end	
											--贯通经脉属性加成
											for i = 1,#CC.qxnum do 	
												if CC.qxnum[i] == rwqx then 
													if i == 1 or i == 4 or i == 7 or i == 10 then 										
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['攻击力'] =  JY.Person[id]['攻击力'] + 50
															AddPersonAttrib(id,'攻击力',50)
														end
													elseif i == 2 or i == 5 or i == 8 or i == 11 then 
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['防御力'] =  JY.Person[id]['防御力'] + 50
															AddPersonAttrib(id,'防御力',50)
														end
													elseif i == 3 or i == 6 or  i == 9  or i == 12 then 
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['轻功'] =  JY.Person[id]['轻功'] + 50
															AddPersonAttrib(id,'轻功',50)
														end
													elseif i == 13 or i == 14  then 
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['轻功'] =  JY.Person[id]['轻功'] + 50
															AddPersonAttrib(id,'轻功',50)
														end
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['攻击力'] =  JY.Person[id]['攻击力'] + 50
															AddPersonAttrib(id,'攻击力',50)
														end
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['防御力'] =  JY.Person[id]['防御力'] + 50
															AddPersonAttrib(id,'防御力',50)
														end										
													end												
												end
											end																							
										else
											qxsm = 2
										end			
									end
								else
									qxsm = 1
								end
							end
						end		
					end	
				end
			elseif page == 5  then 
				if inteam(id) then 
					lb1 = lb1 + 1
					if lb1 > 3 then 				
						lb1 = 3
					end			
					if zdpage == 1 then 
						if lb1 == 3 then 
							if JY.Person[id]['招式方针'] == tb1 then 
								JY.Person[id]['招式方针'] = 0
							else
								JY.Person[id]['招式方针'] = tb1
							end
						end
					elseif zdpage == 2 then 
						if lb1 == 3 then 
							if tb1 == 1 then 
								JY.Person[id]['行动方针'] = tb2 - 1
							elseif tb1 == 2 then 
								JY.Person[id]['施毒方针'] = tb2 - 1
							elseif tb1 == 3 then 
								JY.Person[id]['暗器方针'] = tb2 - 1
							end
						end
					elseif zdpage == 3 then 
						if lb1 == 3 then 
							if tb1 == 1 then 
								JY.Person[id]['吃红药方针'] = tb2 - 1
							elseif tb1 == 2 then 
								JY.Person[id]['吃蓝药方针'] = tb2 - 1
							elseif tb1 == 3 then 
								JY.Person[id]['吃黄药方针'] = tb2 - 1
							end
						end
					elseif zdpage == 4 then 
						if lb1 == 3 then 
							if tb1 == 1 then 
								JY.Person[id]['复活方针'] = tb2 - 1
							elseif tb1 == 2 then 
								JY.Person[id]['喝酒方针'] = tb2 - 1
							elseif tb1 == 3 then 
								JY.Person[id]['备用方针1'] = tb2 - 1
							end
						end					
					end
				end
			end					
			--lib.Debug('tb='..tb..' tb1='..tb1..' cot1='..cot1)
			--lib.Debug('SPACE当前所处lb='..lb..' 当前所处page='..page..' 当前所处lb1='..lb1)
		elseif X == VK_DOWN then
			local pdpage = 0
			if page == 1 then 
				if lb1 == 1 then 
					pdpage = 1 
					----lib.Debug('lb1页面判定'..pdpage)
				end
				if pdpage == 1 then 
					page = page + 1
					lb1 = 1
					lb = 0
					if page > #zmenu then 
						page = 1
					end	
				end
			elseif page == 2 then 
				if lb1 == 1 then 
					pdpage = 1 
					----lib.Debug('lb1页面判定'..pdpage)
				end
				if xlsm > 0 then 
					xlsm = 0
				end
				if pdpage == 1 then 
					page = page + 1
					lb1 = 1
					lb = 0
					if page > #zmenu then 
						page = 1
					end	
					for p = 1,#kfmenu do 
						if kfmenu[p] ~= nil then 
							kfmenu[p] = nil 
						end
					end
				end
				if lb1 == 3 then 
					if WGSHUOMING > 0 then
						WGSTARTH  = WGSTARTH + 1
						if WGSTARTH > FY then
							WGSTARTH = FY 
						end
					end
				end	
				if lb1 == 2 then 
					if kid + rnum >= 0 and kid +rnum <= #kfmenu then 
						kid = kid + rnum
					end

				end
			elseif page == 3 then 
				if lb1 == 1 then 
					pdpage = 1 
					----lib.Debug('lb1页面判定'..pdpage)
				end
				if pdpage == 1 then 
					page = page + 1
					lb1 = 1
					lb = 0
					if page > #zmenu then 
						page = 1
					end	
					for p1 = 1,#MJMenu do 
						if MJMenu[p1] ~= nil then 
							MJMenu[p1] = nil 
						end
					end
				end
				if lb1 == 3 then 
					if MJSHUOMING > 0 then 
						if MJSHUOMING > 0 then
							Mstarth  = Mstarth + 1
							if Mstarth > Mfy then
								Mstarth = Mfy 
							end
						end
					end
				end
				if lb1 == 2 then 
					if mid + rnum >= 0 and mid + rnum <= #MJMenu then 
						mid = mid + rnum 	
					end	
				end
			elseif page == 4 then 
				if lb == 0 then 
					pdpage = 1
					----lib.Debug('lb页面判定'..pdpage)
				end	
				if pdpage == 1 then 
					page = page + 1
					lb1 = 1
					lb = 0
					if page > #zmenu then 
						page = 1
					end	
				end
				if qxsm > 0 or jmtx > 0 then 
					qxsm = 0	
					jmtx = 0	
				end
				if lb == 3 then 
					if tb == 5 then 
						cot1 = cot1 - 1
						if cot1 < 1 then 
							cot1 = #jmmenu[tb][tb1]
						end
					end
				elseif lb == 2 then 
					--lb = 3
					--cot1 = 1
					tb1 = tb1 + 1 
					if tb < 5 then 
						if tb1 > 3 then 
							tb1 = 1
						end 
					else
						if tb1 > 2 then 
							tb1 = 1
						end
					end
				elseif lb == 1 then 
					--lb = 2
					--tb1 = 1
					tb = tb + 1
					if tb > #menu then 
						tb = 1
					end
				end
			elseif page == 5 then 
				if lb1 == 1 then 
					pdpage = 1
					----lib.Debug('lb页面判定'..pdpage)
				end					
				if pdpage == 1 then 
					page = page + 1
					lb1 = 1
					lb = 0
					if page > #zmenu then 
						page = 1
					end
				end

				if lb1 == 2 then 					
					zdpage = zdpage + 1
					tb1 = 1
					tb2 = 1
					if zdpage > 4 then 
						zdpage = 1
					end
				end
				if lb1 == 3 then 
					if zdpage == 2 then 
						tb2  = tb2 + 1
						if tb2 > #zdwz2[tb1] then 
							tb2 = 1
						end
					elseif zdpage == 3 then 
						tb2  = tb2 + 1
						if tb2 > #zdwz3[tb1] then 
							tb2 = 1
						end
					elseif zdpage == 4 then 
						tb2  = tb2 + 1
						if tb2 > #zdwz4[tb1] then 
							tb2 = 1
						end	
					else 
						zdpage = 2
						lb1 = 2
						tb1 = 1
					end
				end
			end

			--lib.Debug('down当前所处lb='..lb..' 当前所处page='..page..' 当前所处lb1='..lb1..' tb='..tb..' tb1='..tb1..' cot1='..cot1)
		elseif X == VK_UP then
			if lb1 == 1 and lb == 0 then 
				page = page - 1
				lb1 = 1
				lb = 0
				if page > #zmenu then 
					page = 1
				end		
				if page < 1 then 
					page = #zmenu
				end	
			end
			if page == 1 then 
			elseif page == 2 then 
				if  xlsm > 0 then
					xlsm = 0	
				end
				if lb1 == 3 then 
					if WGSHUOMING > 0 then
						WGSTARTH = WGSTARTH - 1
						if WGSTARTH < 0 then 
							WGSTARTH = 0
						end
					end
				end
				if lb1 == 2 then 
					if kid - rnum > 0 then 
						kid = kid - rnum 	
					end
				end
			elseif page == 3 then 
				if lb1 == 1 and lb == 0 then 
					for p1 = 1,#MJMenu do 
						if MJMenu[p1] ~= nil then 
							MJMenu[p1] = nil 
						end
					end
				end
				if lb1 == 3 then
					if MJSHUOMING > 0 then 
						Mstarth = Mstarth - 1
						if Mstarth < 0 then 
							Mstarth = 0
						end	
					end
				end
				if lb1 == 2 then 
					if mid - rnum > 0 then 
						mid = mid - rnum 
					end
				end
			elseif page == 4 then 
				if qxsm > 0 or jmtx > 0 then 
					qxsm = 0	
					jmtx = 0
				end
				if lb == 3 then 
					if tb == 5 then 
						cot1 = cot1 + 1 
						if cot1 > #jmmenu[tb][tb1] then 
							cot1 = 1
						end
					end
				elseif lb == 1 then 
					tb = tb - 1
					if tb < 1 then 
						tb = 5
					end
				elseif lb == 2 then 
					tb1 = tb1 - 1
					if tb < 5 then 
						if tb1 < 1 then 
							tb1 = 3
						end
					else
						if tb1 < 1 then 
							tb1 = 2
						end
					end
				end	
			elseif page == 5 then 
				if lb1 == 2 then 					
					zdpage = zdpage - 1
					tb1 = 1
					tb2 = 1
					if zdpage < 1 then 
						zdpage = 4
					end
				end
				if lb1 == 3 then 
					if zdpage == 2 then 
						tb2  = tb2 - 1
						if tb2 < 1 then 
							tb2 = #zdwz2[tb1] 
						end
					elseif zdpage == 3 then 
						tb2  = tb2 - 1
						if tb2 < 1  then 
							tb2 = #zdwz3[tb1]
						end
					elseif zdpage == 4 then 
						tb2  = tb2 - 1
						if tb2 < 1  then 
							tb2 = #zdwz4[tb1]
						end	
					else 
						lb1 = 2
						tb1 = 1
					end
				end	
			end
			----lib.Debug('up当前所处lb='..lb..' 当前所处page='..page..' 当前所处lb1='..lb1)
		elseif X == VK_LEFT then
			if page == 1 then 
				if lb1 == 1 and TFSHUOMING ~= 1 and lb == 0 then 
					if tid2 > 0 then
						tid2 = tid2 - 1	
						if tid2 < 1 then 
							tid2 = 0
						end
					else
						tid = tid - 1
						if tid < 1 then 
							tid = 1
						end
					end
				elseif TFSHUOMING == 1  then 
					tfid = tfid - 1
					if tfid < 1 then 
						tfid = #tfme
					end
				end
			elseif page == 2 then 
				if  xlsm > 0 then 	
					xlsm = 0
				end		
				if WGSHUOMING > 0  then 				
					if WGSHUOMING == 1 then 
						if JY.Wugong[JY.Person[id]["武功"..kid]]['武功类型'] < 6 then 
							if tb5 == 0 then 
								tb4 = tb4 - 1
								if tb4 < 1 then 
									--tb4 = #CC.KFMove[JY.Person[id]["武功"..kid]]
									tb4 = 0
									tb5 = 2
								end
							else
								tb5 = tb5 - 1
								if tb5 < 1 then 
									tb5 = 0
									tb4 = #CC.KFMove[JY.Person[id]["武功"..kid]]
								end
							end	
						else
							tb5 = tb5 - 1
							if tb5 < 1 then 
								tb5 = 2
							end
						end
					else
						tb5 = tb5 - 1
						if tb5 < 1 then 
							tb5 = 2
						end
					end
				end
				if lb1 == 2 then 
					WGSTARTH = 0
					if page == 2 then 
						kid = kid - 1
						if kid < 1 then 
							kid = #kfmenu
						end
					end
				end
			elseif page == 3 then 
				if lb1 == 2 then 
					mid = mid - 1
					if mid < 1 then 
						mid = #MJMenu
					end
				end
			elseif page == 4 then 
				if qxsm > 0 or jmtx > 0  then 
					qxsm = 0	
					jmtx = 0	
				end	
				if lb == 3 then
					if tb == 1  then 
						if tb1 == 2 or tb1 == 3 then 
							cot1 = cot1 + 1
							if cot1 > #jmmenu[tb][tb1] then
								cot1 = 1
							end
						elseif tb1 == 1 then 
							cot1 = cot1 - 1
							if cot1 < 1 then 
								cot1 = #jmmenu[tb][tb1]
							end
						end
					elseif tb == 2 then 
						if tb1 == 1 or tb1 == 3  then 
							cot1 = cot1 - 1
							if cot1 < 1 then 
								cot1 = #jmmenu[tb][tb1]
							end
						elseif tb1 == 2 then 
							cot1 = cot1 + 1 
							if cot1 >  #jmmenu[tb][tb1] then 
								cot1 = 1
							end
						end
					elseif tb == 3 then 
						if tb1 == 1 or tb1 == 2 then 
							cot1 = cot1 - 1
							if cot1 < 1 then 
								cot1 =  #jmmenu[tb][tb1]
							end
						elseif tb1 == 3 then 
							cot1 = cot1 + 1 
							if cot1 > #jmmenu[tb][tb1] then 
								cot1 = 1
							end
						end
					elseif tb == 4 then 
						cot1 = cot1 - 1
						if cot1 < 1 then 
							cot1 =  #jmmenu[tb][tb1]
						end
					end
				end	
			elseif page == 5 then 
				if zdpage == 1 then
					if lb1 == 3 then 
						lb1 = 2
					end
				end
				if lb1 == 2 then 
					if zdpage == 1 then 
						tb1 = tb1 - 1
						tb2 = 1
						if tb1 < 1 then 
							tb1 = #zdwz1
						end
					end
					if zdpage > 1 then 
						tb1 = tb1 - 1
						tb2 = 1
						if tb1 < 1 then 
							tb1 = 3
						end
					end	
				end
			end
			--lib.Debug('left当前所处lb='..lb..' 当前所处page='..page..' 当前所处lb1='..lb1)
		elseif X == VK_RIGHT then
			if page == 1 then 
				if lb1 == 1 and TFSHUOMING ~= 1 and lb == 0 then 
					if tid < 8 then
						tid = tid + 1
						if tid > #team then 
							tid = #team
						end
					else
						tid2 = tid2 + 1
						if tid2 + tid > #team then
							tid2 = 0
							tid = 1
						end
					end
				elseif TFSHUOMING == 1 then 
					tfid = tfid + 1
					if tfid > #tfme then 
						tfid = 1
					end	
				end
			elseif page == 2 then 
				if xlsm > 0 then 
					xlsm = 0
				end
				if WGSHUOMING > 0  then 
					if JY.Wugong[JY.Person[id]["武功"..kid]]['武功类型'] < 6 then 
						if tb5 == 0 then 
							tb4 = tb4 + 1 
							if tb4 > #CC.KFMove[JY.Person[id]["武功"..kid]] then 
								tb4 = 0
								tb5 = 1
							end
						else
							tb5 = tb5 + 1
							if tb5 > 2 then 
								tb4 = 1
								tb5 = 0
							end	
						end	
					else
						tb5 = tb5 + 1
						if tb5 > 2 then 
							tb5 = 1
						end
					end
				end
				if lb1 == 2 then 
					WGSTARTH = 0
					if page == 2 then 
						kid = kid + 1
						if kid > #kfmenu then 
							kid = 1
						end
					end
				end
			elseif page == 3 then 
				if lb1 == 2 then 
					mid = mid + 1
					if mid > #MJMenu then 
						mid = 1
					end
				end
			elseif page == 4 then 
				if qxsm > 0 or jmtx > 0  then 
					qxsm = 0	
					jmtx = 0	
				end
				
				if lb == 3 then 
					if tb == 1 then 
						if tb1 == 1 then 
							cot1 = cot1 + 1
							if cot1 > #jmmenu[tb][tb1] then 
								cot1 = 1
							end
						elseif tb1 == 2 or tb1 == 3 then 
							cot1 = cot1 - 1
							if cot1 < 1  then
								cot1 = #jmmenu[tb][tb1] 
							end
						end
					elseif tb == 2  then 
						if tb1 == 1 or tb1 == 3 then 
							cot1 = cot1 + 1
							if cot1 > #jmmenu[tb][tb1] then 
								cot1 = 1
							end
						elseif tb1 == 2 then 
							cot1 = cot1 - 1 
							if cot1 < 1  then 
								cot1 = #jmmenu[tb][tb1] 
							end					
						end
					elseif tb == 3 then 
						if tb1 == 1 or tb1 == 2 then 
							cot1 = cot1 + 1
							if cot1 > #jmmenu[tb][tb1] then 
								cot1 = 1
							end
						elseif tb1 == 3 then 
							cot1 = cot1 - 1
							if cot1 < 1 then 
								cot1 = #jmmenu[tb][tb1]
							end
						end	
					elseif tb == 4 then 
						cot1 = cot1 + 1
						if cot1 > #jmmenu[tb][tb1] then 
							cot1 = 1
						end
					end
				end	
			elseif page == 5 then
				if zdpage == 1 then
					if lb1 == 3 then 
						lb1 = 2
					end
				end
				if lb1 == 2 then 
					if zdpage == 1 then 
						tb1 = tb1 + 1
						tb2 = 1
						if tb1 > #zdwz1 then 
							tb1 = 1
						end
					end
					if zdpage > 1 then 
						tb1 = tb1 + 1
						tb2 = 1
						if tb1 > 3 then 
							tb1 = 1
						end
					end	
				end
			end
			--lib.Debug('right当前所处lb='..lb..' 当前所处page='..page..' 当前所处lb1='..lb1)					
		elseif X == VK_A then  
			if inteam(id) == true then 
				Mianbanwq(id)
			end
		elseif X == VK_B then
			if inteam(id) == true then 
				Mianbanfj(id)
			end
		elseif X == VK_Z then
			if inteam(id) == true then 
				Mianbanzq(id)		
			end				  				
		elseif X == VK_F1 then
			if WGSHUOMING ~= 2 then 
				WGSHUOMING = 2 
			else
				WGSHUOMING = 1
			end
		elseif	X == VK_X then		
			if inteam(id) == true then 
				if page == 2 and WGSHUOMING < 1 then
					xlmj(id)
					--return 1
				elseif page == 3 then 

				end
			end
		elseif ktype == 6 or X == VK_PGUP then
			if lb1 == 3 then 
				if WGSHUOMING > 0 then
					WGSTARTH = WGSTARTH - 1
					if WGSTARTH < 0 then 
						WGSTARTH = 0
					end	
				elseif MJSHUOMING > 0 then 
					Mstarth = Mstarth - 1
					if Mstarth < 0 then 
						Mstarth = 0
					end	
				end
			elseif c_true(px,py) == 1 then
				if tid2 > 0 then 
					tid2 = tid2 - 1
				end
			end
		elseif ktype == 7 or X == VK_PGDN then	
			if lb1 == 3 then 
				if WGSHUOMING > 0 then 
					if WGSHUOMING > 0 then
						WGSTARTH  = WGSTARTH + 1
						if WGSTARTH > FY then
							WGSTARTH = FY 
						end
					end
				elseif MJSHUOMING > 0 then 
					if MJSHUOMING > 0 then
						Mstarth  = Mstarth + 1
						if Mstarth > Mfy then
							Mstarth = Mfy 
						end
					end
				end
			elseif c_true(px,py) == 1 then
				if tid2 + tid < #team then
					if tid < 8 then
						tid = tid + 1
					else
						tid2 = tid2 + 1
					end
				end
			end
		else
			local mxxx = false
			local sm = 0
			--取消一些说明
			if mx > 0 then 
				if jmtx > 0 or qxsm > 0 or xlsm > 0  then 
					jmtx = 0
					qxsm = 0
					xlsm = 0
				end
			end
			
			--主菜单
			for i = 1,#zmenu do  
				if mx >= bx*1290 and mx <= bx*1360 and my >= by*175+(i-1)*p2x and my <= by*280+(i-1)*p2y then 
					if page ~= i and ktype == 3 then
						PlayWavE(77)
						page = i
						lb = 0
						tb = 1
						tb1 = 1
						cot1 = 1
						kid = 1
						mid = 1
						lb1 = 1
						break
					end
				end
			end

			--队友
			for i = 1,8 do 
				if mx >= bx*150+(i-1)*bx*150-bx*65 and mx <= bx*150+(i-1)*bx*150+bx*65 and my >= by*85-bx*65 and my <= by*85+bx*65 then 
					if team[i+tid2] ~= nil then
						if tid ~= i and ktype == 3 then
							PlayWavE(77)
							tid = i
							lb = 1
							tb = 1
							tb1 = 1
							cot1 = 1
							kid = 1
							mid = 1
							dh = 0
							break
						end
					end
				end
			end

			if page == 1 then 
				--天赋说明
				for i = 1,#tfme do		
					if WGSHUOMING < 1 then		
						if mx >= tfx + (i-1)*bx*70 and mx <= tfx + (i)*CC.ScreenW/22.666 + (i-1)*bx*15 and my >= tfy and my <= tfy+bx*55 and ktype == 3  then
							PlayWavE(77)
							tfid = i						
							TFSHUOMING = 1		
							lb1 = 2			
							break			
						end
					end
				end
				if TFSHUOMING == 1 and ktype == 4 then
					PlayWavE(77)
					TFSHUOMING = 0
					tfid = 0
				end	
				--装备
				--lib.LoadPNG(91, 281 * 2 , bx*18,by*568+(i-1)*size*2.2, 1,0,100 )
				for i = 1,3 do 
					if mx >= bx*18 and mx <= bx*18 + bx*55 and my >= by*568+(i-1)*size*2.2 and my <= by*568+(i-1)*size*2.2 + by*55 and WGSHUOMING < 1 and ktype == 3 then 
						if inteam(id) == true then 
							if i == 1 then 
								Mianbanwq(id)
							elseif i == 2 then
								Mianbanfj(id)
							elseif i == 3 then 
								Mianbanzq(id)
							end
						end
					end
				end	
			end	
			--武功
			if page == 2 then 
				local n,m,wfy = 0,0,0
			
				if mx >= bx*600 and mx <= bx*600+bx*70 and my >= by*700 and my <= by*700 + by*70 and ktype == 3 then
					if WGSHUOMING < 1 then	
						xlmj(id)
					end
				end
				for i = 1,JY.Base["武功数量"] do 
					if JY.Person[id]['武功'..i] > 0 then 
						
						if mx >= CC.ScreenW/2 +n*p2x - bx*32 and mx <= CC.ScreenW/2 +n*p2x + bx*32 and my >= by*360+m*p2y - bx*32 and my <= by*360+m*p2y + by*50 and WGSHUOMING < 1 then
							if kid ~= i then 
								PlayWavE(77)
							end
							lb1 = 2
							kid = i
							mxxx = true
							break
						end
						n = n + 1
						if n == rnum then 
							n = 0
							m = m + 1
						end
					end
				end
				
				if mxxx == true and ktype == 3 then
					lb1=3
					PlayWavE(77)
					--say(JY.Wugong[JY.Person[team[tid+tid2]]['武功'..kid]]['名称'],1)
					WGSHUOMING = 1
				end
				--bx*zszb[j][1]-CC.ScreenW/55,zsh+by*zszb[j][2]+by*64
				if lb1 == 3 then 
					--切换武功说明
					--lib.LoadPNG(91,14*2,size/3,CC.ScreenH/2-size*2.8,1,0,80)  -- 切换武功说明图片
					if WGSHUOMING > 0 then 
						local qhwg = false
						if mx > 0 and mx < size*1.8 and my > CC.ScreenH/2-size*2.8 and my < CC.ScreenH/2-size then 
							qhwg = true
						end
						if qhwg == true and ktype == 3 then 
							if WGSHUOMING == 1 then 
								WGSHUOMING = 2
							else
								WGSHUOMING = 1
							end
						end
					end

					if CC.KFMove[JY.Person[id]["武功"..kid]] ~= nil then
						for i = 1,#CC.KFMove[JY.Person[id]["武功"..kid]] do 
							if mx > bx*zszb[i][1]-CC.ScreenW/55  and mx < bx*zszb[i][1] + bx*15 and my > zsh+by*zszb[i][2]+by*64 and my < zsh+by*zszb[i][2]+by*63 + by*40 then
								if tb4 ~= i then									
									tb4 = i
									break
								end			
							end
						end
					end
					local mxxxx = false
					for i = 1,#zb5 do					
						if mx > bx*zb5[i][1]-wzbx6 and mx < bx*zb5[i][1]-wzbx6 + bx*67 and my >by*zb5[i][2]+wzby6-by*4 and my < by*zb5[i][2]+wzby6+by*25 and inteam(id) then
							tb5 = i
							--lb1=3
							mxxxx = true
							break
						end
					end
					if mxxxx == true and ktype == 3 and inteam(id) then					
						if page == 2 and wgmenu[kid][1] > 0 then
							if tb5 == 1 then	
								PlayWavE(77)
								if JY.Wugong[wgmenu[kid][1]]["武功类型"] < 6  then  --优先使用不等于当前选择
									if  p["优先使用"] ~= wgmenu[kid][1] then
										p["优先使用"] = wgmenu[kid][1]
									else
										p["优先使用"] = 0
									end
								elseif JY.Wugong[wgmenu[kid][1]]["武功类型"] == 6   then
									if  p["主运内功"] ~= wgmenu[kid][1] then
										p["主运内功"] = wgmenu[kid][1]
										Hp_Max(id)
										Mp_Max(id)
									else
										p["主运内功"] = 0
										Hp_Max(id)
										Mp_Max(id)
									end
								elseif JY.Wugong[wgmenu[kid][1]]["武功类型"] == 7   then
									if  p["主运轻功"] ~= wgmenu[kid][1] then
										p["主运轻功"] = wgmenu[kid][1]
									else
										p["主运轻功"] = 0
									end
								end
							else	
								PlayWavE(77)
								local R = 0
								
								if wgmenu[kid][3] < 10 then
									if KF_thing(wgmenu[kid][1]) == nil then
										R = JY.Wugong[wgmenu[kid][1]]['层级']*80
									else
										R = math.modf((5-math.modf(25/25))*JY.Thing[KF_thing(wgmenu[kid][1])]["需经验"]*(wgmenu[kid][3]+1)*0.05);
									end
								end
								if wgmenu[kid][3] < 10   then
									if  p["物品修炼点数"] >= R then
										wgmenu[kid][3] = wgmenu[kid][3] + 1								
										JY.Person[id]["武功等级"..wgmenu[kid][5]] = JY.Person[id]["武功等级"..wgmenu[kid][5]] + 100
										KF_addsx(id,wgmenu[kid][1])
										Hp_Max(id)
										Mp_Max(id)
										p["物品修炼点数"] = p["物品修炼点数"] - R
									else
										xlsm = 1
									end
								else
									xlsm = 2
								end		
							end
						end
					end	
				end			
			end
			--秘技
			if page == 3 then 
				local n,m,wfy = 0,0,0
				if mx >= bx*600 and mx <= bx*600+bx*70 and my >= by*700 and my <= by*700 + by*70 and ktype == 3 then
					--if WGSHUOMING < 1 then	
						--xlmj(id)
						--jiemian()
						--page = 3
					--end
				end 
				if MJSHUOMING < 1 then 
					for i = 1,10 do 
						if JY.Person[id]['秘技'..i] > 0 then 
							if mx >= CC.ScreenW/2 +n*p2x - bx*32 and mx <= CC.ScreenW/2 +n*p2x + bx*32 and my >= wgy1 + by*360+m*p2y  and my <= wgy1 + by*420+m*p2y*1.1 and WGSHUOMING < 1 then
								if kid ~= i then 
									PlayWavE(77)
								end
								mid = i
								mxxx = true
								lb1 = 2
								break
							end
							n = n + 1
							if n == rnum then 
								n = 0
								m = m + 1
							end
						end
					end				
					if mxxx == true and ktype == 3 then
						PlayWavE(77)
						--say(JY.Wugong[JY.Person[team[tid+tid2]]['武功'..kid]]['名称'],1)
						--WGSHUOMING = 1
						MJSHUOMING = 1
						lb1 = 3
					end	
				end		
			end	
			--经脉		
			if page == 4 then 
				local smmx = false
				if mx >= bx*212+bx*829+p_3x and mx <=bx*212+bx*849+p_3x and my >= by*33+by*76+p_3y and my <= by*33+by*102+p_3y then
					smmx = true
				end
				if smmx == true and ktype == 3 and inteam(id) then
					QXSHUOMING = 1
				end	
				if lb <= 1  then 
					--bx*212+bx*120,by*33+by*220+by*(i-1)*hg
					for i = 1,#menu do
						if mx >= bx*332+p_3x and mx <= bx*332 + bx*122+p_3x and my >= bx*253 +bx*(i-1)*hg+p_3y and my <= bx*253 + bx*36 +bx*(i-1)*hg+p_3y then 
							if tb ~= i then
								PlayWavE(77)
							end
							tb = i
							tb1 = 1
							mxxx = true
							break
						end
					end
				elseif lb == 2 then
					local jmmenu = {3,3,3,3,2}
					--bx*212+bx*145,by*33+by*260+by*(j-1)*size*0.9
					for i = 1,jmmenu[tb] do
						if mx >= bx*357+p_3x and mx <= bx*357 + size*3+p_3x and my >= bx*293 +bx*(tb-1)*hg + by*(i-1)*size*0.9+p_3y  and my <= bx*293 +bx*(tb-1)*hg + by*(i-1)*size*0.9+ size*0.75+p_3y then 
							if tb1 ~= i then
								PlayWavE(77)
							end
							tb1 = i
							mxxx = true
							break
						end
					end
				--奇穴	
				elseif lb == 3 then 		
					if tb1 < 1 then 
						tb1 = 1
					end			
					for i = 1,#jmmenu[tb][tb1] do 
						local i1 = jmmenu[tb][tb1][i][6]
						local i2 = jmmenu[tb][tb1][i][7]
						if mx >= i1 - bx*10+p_3x and mx <= i1 + bx*10+p_3x and my >= i2 - bx*10+p_3y and my <= i2 + bx*10+p_3y then 
							if cot1 ~= i then
								PlayWavE(77)
							end
							cot1 = i
							mxxx = true
							----lib.Debug('现有武学点'..JY.Person[id]["武学点数"]..' 奇穴 '..jmmenu[tb][tb1][cot1][1]	..' 需要武学点 '..jmmenu[tb][tb1][cot1][5])
							break
						end
					end
				end
				if mxxx == true and ktype == 3 and inteam(id)  then
					PlayWavE(77)
					if lb == 1 or lb == 0 then
						lb = 2
					elseif lb == 2 then
						lb = 3
						cot1 = 1
					elseif lb == 3 then
						local pd = false	
						local jmjd =jmmenu[tb][tb1][cot1]	
						local xhds = jmjd[5] 
						if inteam(id) == true then 				
							if cot1 == 1  then							
								local ngn = {} 
								local ng0,ng1,ng2,ngdj = 0,0,0,0
								for w = 1,JY.Base["武功数量"] do 
									local wugong = JY.Person[id]["武功"..w]
									if wugong > 0 then
										if JY.Wugong[wugong]["武功类型"] == 6 then 
											ngn[#ngn+1] = wugong
										end
									end
								end
								--确定有学会合适的内功
								for j = 1,#ngn do 
									if WGns(ngn[j]) == 0 then 
										ng0 = 1
									end
									if WGns(ngn[j]) == 1 then 
										ng1 = 1
									end
									if WGns(ngn[j]) == 2 then 
										ng2 = 1
									end
									ngdj = JY.Wugong[ngn[j]]["层级"]
								end
								if  JY.Person[id]["奇穴"..rwqx] < 1 then 
									
									if  ngdj >= 1   then 
										pd = true
									end
									if pd == true then
										if JY.Person[id]["武学点数"] - xhds >= 0 then 
											
											JY.Person[id]["奇穴"..rwqx] = 1  --激活经脉
											jmtx = 1
											JY.Person[id][jmjd[2]] = JY.Person[id][jmjd[2]] + jmjd[3]  --增加人物属性
											JY.Person[id]["武学点数"] = JY.Person[id]["武学点数"] - xhds
											--奇穴激活特效
										else
											qxsm = 2
										end
									else
										qxsm = 3	
									end
								end
							elseif cot1 > 1  then
								if JY.Person[id]["奇穴"..rwqx-1] > 0 then
									if  JY.Person[id]["奇穴"..rwqx] < 1 then 
										if JY.Person[id]["武学点数"] - xhds >= 0 then
											--特殊经脉
											local tsjme = {CC.TSJM_SSYIN,CC.TSJM_SSYANG,CC.TSJM_ZSYIN,CC.TSJM_ZSYANG,CC.TSJM_RENDU}
											local tsmenu = tsjme[tb]
											local tsqx = 0
											
											for t = 1,#tsmenu do 
												if tsmenu[t][3] == rwqx then 
													tsqx = 1
													--lib.Debug('判定成功 '..tsqx..'  经脉穴位== '..rwqx)
													break
												end
											end
											----lib.Debug('判定成功 '..tsqx..'  经脉穴位== '..rwqx)
											if  tsqx == 0  then 
												JY.Person[id]["奇穴"..rwqx] = 1  --激活经脉
												jmtx = 1
												--JY.Person[id][jmjd[2]] = JY.Person[id][jmjd[2]] + jmjd[3]  --增加人物属性
												AddPersonAttrib(id,jmjd[2],jmjd[3])
												JY.Person[id]["武学点数"] = JY.Person[id]["武学点数"] - xhds

											else
												if JMQX_JH(id,rwqx)  then 
													--lib.Debug('经脉奇穴判定成功')
													JY.Person[id]["奇穴"..rwqx] = 1  --激活经脉
													jmtx = 1 
													--JY.Person[id][jmjd[2]] = JY.Person[id][jmjd[2]] + jmjd[3]  --增加人物属性
													AddPersonAttrib(id,jmjd[2],jmjd[3])
													JY.Person[id]["武学点数"] = JY.Person[id]["武学点数"] - xhds
													if rwqx == 22 then 
														AddPersonAttrib(id, "攻击带毒", 20)
														AddPersonAttrib(id, "用毒能力", 20)														
													end
													if rwqx == 25 then 
														AddPersonAttrib(id, "用毒能力", 30)														
													end													
													if rwqx == 28 then 
														AddPersonAttrib(id, "用毒能力", 100)														
													end
													if rwqx == 95 then 
														AddPersonAttrib(id, "基础生命", 300)														
													end
													if rwqx == 117 then 
														AddPersonAttrib(id, "体质", 2)
													end
													if rwqx == 129 then 
														AddPersonAttrib(id, "内力最大值", 500)
													end													
												else
													qxsm = 3
												end						
											end
											--贯通经脉属性加成
											for i = 1,#CC.qxnum do 	
												if CC.qxnum[i] == rwqx then 
													if i == 1 or i == 4 or i == 7 or i == 10 then 										
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['攻击力'] =  JY.Person[id]['攻击力'] + 50
															AddPersonAttrib(id,'攻击力',50)
														end
													elseif i == 2 or i == 5 or i == 8 or i == 11 then 
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['防御力'] =  JY.Person[id]['防御力'] + 50
															AddPersonAttrib(id,'防御力',50)
														end
													elseif i == 3 or i == 6 or  i == 9  or i == 12 then 
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['轻功'] =  JY.Person[id]['轻功'] + 50
															AddPersonAttrib(id,'轻功',50)
														end
													elseif i == 13 or i == 14  then 
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['轻功'] =  JY.Person[id]['轻功'] + 50
															AddPersonAttrib(id,'轻功',50)
														end
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['攻击力'] =  JY.Person[id]['攻击力'] + 50
															AddPersonAttrib(id,'攻击力',50)
														end
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['防御力'] =  JY.Person[id]['防御力'] + 50
															AddPersonAttrib(id,'防御力',50)
														end										
													end												
												end
											end																								
										else
											qxsm = 2
										end			
									end
								else
									qxsm = 1
								end
							end
						end
					end	
				end	
			end
			--战斗
			if page == 5 then 
				local mxxx = false 
				if lb1 < 3 and inteam(id) then 
					for i = 1,4 do 
						if mx > CC.ScreenW/2 and mx < CC.ScreenW/2 + bx*400 and my > CC.ScreenH/2 + (i-1)*by*60 and my < CC.ScreenH + by*40 + (i-1)*by*60  and inteam(id) then							
							zdpage = i
						end
					end					
					--招式方针
					if zdpage == 1  then 
						for i = 1,#zdwz1 do 
							if mx > bx*717+(i-1)*bx*34 and mx < bx*717+(i-1)*bx*34 + size2*1.2 and my > by*385 and my < by*385+size2 then
								tb1 = i 
								lb1 = 2
								mxxx = true 
								break
							end
						end
						if mxxx == true and ktype == 3 then 
							if JY.Person[id]['优先使用'] == 0 then 
								say('还没给我装备外功哦',id,1)
							else
								if tb1 > #CC.KFMove[JY.Person[id]['优先使用']] then 
									say('使用的武功没有这么多招式哦',id,1)
								else
									if JY.Person[id]['招式方针'] == tb1 then 
										JY.Person[id]['招式方针'] = 0
									else
										JY.Person[id]['招式方针'] = tb1
									end
								end
							end
						end
					
					--攻击方针
					elseif zdpage == 2 then 
						for i = 1,3 do 
							if mx > bx*717 + (i-1)*160 and mx < bx*717 + (i-1)*160 + bx*145  and my > by*440 and my < by*440 + size2*2 then 
								tb1 = i 
								lb1 = 2
								mxxx = true 
								break
							end
						end	
						if mxxx == true and ktype == 3 then 
							lb1 = 3
						end
					elseif zdpage == 3 then 
						for i = 1,3 do 
							if mx > bx*717 + (i-1)*160 and mx < bx*717 + (i-1)*160 + bx*145  and my > by*440 + zh and my < by*440 + size2*2 + zh then 
								tb1 = i 
								lb1 = 2
								mxxx = true 
								break
							end
						end	
						if mxxx == true and ktype == 3 then 
							lb1 = 3
						end
					elseif zdpage == 4 then 
						for i = 1,3 do 
							if mx > bx*717 + (i-1)*160 and mx < bx*717 + (i-1)*160 + bx*145  and my > by*440 + zh*2 and my < by*440 + size2*2 + zh*2 then 
								tb1 = i 
								lb1 = 2
								mxxx = true 
								break
							end
						end	
						if mxxx == true and ktype == 3 then 
							lb1 = 3
						end	
					end
				else
					if zdpage == 2 then 	
						for i = 1,#zdwz2[tb1] do 
							if mx > bx*705 + (tb1-1)*165 and mx < bx*700 +bx*160+ (tb1-1)*165 and my > by*490 and my < by*490+(i)*size2*1.2 then 
								tb2 = i 
								mxxx = true 
								--lib.Debug(tb1)
								break
							end
						end
						if mxxx == true and ktype == 3  then 
							if tb1 == 1 then 
								JY.Person[id]['行动方针'] = tb2 - 1
							elseif tb1 == 2 then 
								JY.Person[id]['施毒方针'] = tb2 - 1
							elseif tb1 == 3 then 
								JY.Person[id]['暗器方针'] = tb2 - 1
							end
						end
					elseif zdpage == 3 then 
						--lib.Background( bx*705 + (tb1-1)*165,by*490+zh,bx*700 +bx*160+ (tb1-1)*165,by*461+(#zdwz3[tb1]+2)*size2*1.2+zh,50)
						for i = 1,#zdwz3[tb1] do 
							if mx > bx*705 + (tb1-1)*165 and mx < bx*700 +bx*160+ (tb1-1)*165 and my > by*490 + zh and my < by*490+(i)*size2*1.2 + zh then 
								tb2 = i 
								mxxx = true 
								--lib.Debug(tb1)
								break
							end
						end
						if mxxx == true and ktype == 3 then 
							if tb1 == 1 then 
								JY.Person[id]['吃红药方针'] = tb2 - 1
							elseif tb1 == 2 then 
								JY.Person[id]['吃蓝药方针'] = tb2 - 1
							elseif tb1 == 3 then 
								JY.Person[id]['吃黄药方针'] = tb2 - 1
							end
						end
					elseif zdpage == 4 then 
						for i = 1,#zdwz4[tb1] do 
							if mx > bx*705 + (tb1-1)*165 and mx < bx*700 +bx*160+ (tb1-1)*165 and my > by*490 + zh*1 and my < by*490+(i)*size2*1.2 + zh*2 then 
								tb2 = i 
								mxxx = true 
								--lib.Debug(tb1)
								break
							end
						end
						if mxxx == true and ktype == 3 then 
							if tb1 == 1 then 
								JY.Person[id]['复活方针'] = tb2 - 1 
							elseif tb1 == 2 then 
								JY.Person[id]['喝酒方针'] = tb2 - 1
							elseif tb1 == 3 then 
								JY.Person[id]['备用方针1'] = tb2 - 1
							end
						end
					end
				end
			end
		end
	end
end


--人物查看
function PersonCK(id)

	local bx,by = CC.WX,CC.HY
	local size2 = CC.Fontsmall*0.8

	local team = {}
	local tid,tid2 =1,0	--队伍按键
	team[#team+1] = id

	local page = 1
	local c_xy = {{0,0,1360,160,1,'人物'},{20,315,455,410,2,'天赋'}}
	local function c_true(x,y)
		for i = 1,#c_xy do 
			if x >= c_xy[i][1] and x <= c_xy[i][3] and y >= c_xy[i][2] and y <= c_xy[i][4] then
				return c_xy[i][5]
			end
		end
		return -1
	end
	local menu = {{212,217},{213,218},{214,219},{215,220},{216,221}}  --左侧经脉总表图片编号
	local ssanyin = {"手少阴经","手太阴经","手厥阴经"}  --手三阴经文字
	local ssanyang = {"手少阳经","手太阳经","手阳明经"}  --手三阳经文字
	local zsanyin = {"足少阴经","足太阴经","足厥阴经"}  --足三阴经文字
	local zsanyang = {"足少阳经","足太阳经","足阳明经"}  --足三阳经文字
	local renmai = {"任    脉","督    脉"}  --任督二脉文字
	local ssymenu = {CC.Sshaoyin,CC.Staiyin,CC.Sjueyin}   -- 手三阴表
	local ssyangmenu = {CC.Sshaoyang,CC.Staiyang,CC.Syangming}  --手三阳表
	local zsymenu = {CC.Zshaoyin,CC.Ztaiyin,CC.Zjueyin}  --足三阴表
	local zsyangmenu = {CC.Zshaoyang,CC.Ztaiyang,CC.Zyangming}  --足三阳表
	local renmaimenu = {CC.Renmai,CC.Dumai} --任督二脉表
	local jmmenu = {ssymenu,ssyangmenu,zsymenu,zsyangmenu,renmaimenu}
	local tb,tb1,tb4,tb5 =1,1,1,0  -- tb第一层表的按键，tb1-tb4第二层四个表的按键，
	local cot1 = 1--控制具体奇穴的按键
	local lb = 0 --页数
	local size,size1 = CC.DefaultFont*0.9,CC.DefaultFont --字号
	local zb = {{CC.ScreenW/2,CC.ScreenH/2},{CC.ScreenW/1.878,CC.ScreenH/2},{CC.ScreenW/1.768,CC.ScreenH/2},{CC.ScreenW/2,CC.ScreenH/1.846},{CC.ScreenW/1.878,CC.ScreenH/1.846},{CC.ScreenW/1.768,CC.ScreenH/1.846}}
	local QXSHUOMING,WGSHUOMING,TFSHUOMING,yxsm,ngsm,qgsm,qxsm,MJSHUOMING = 0,0,0,0,0,0,0,0
	local smwz = {"十二经脉与相应脏腑络属的主要特征。包括手三阴经、手三阳经、足三阴经、足三阳经，最少需要学会一门内功才可激活经脉。","任督两脉原属于奇经八脉，因具有明确穴位，医家将其与十二正经脉合称十四正经脉。最少需要学会一门内功才可激活经脉。"}
	local px,py = -1,-1
	local p_3x,p_3y = CC.ScreenW/6.098,CC.ScreenH/4.388   
	local tfid = 0	--天赋说明按键 
	local tfx,tfy = CC.ScreenW/13.05,CC.ScreenH/2.25  
	--武功
	local kid = 1
	local wgmenu,kfmenu,MJMenu = {},{},{}; --外功
	local zb0 = {{CC.ScreenW/8.09,190},{CC.ScreenW/8.09,240},{CC.ScreenW/8.09,290},{CC.ScreenW/8.09,340},{CC.ScreenW/8.09,390},{CC.ScreenW/8.09,440},{CC.ScreenW/8.09,490},{CC.ScreenW/8.09,540},{CC.ScreenW/8.09,590},}
	local zb1 = {{385,160},{547,160},{705,160}}	
	local zsw1,zsw2,zsw3 = by*550,bx*50,bx*60
	local zszb = {{zsw3,zsw1},{zsw3+50,zsw1},{zsw3+50*2,zsw1},{zsw3+50*3,zsw1},{zsw3+50*4,zsw1},{zsw3+50*5,zsw1},{zsw3+50*6,zsw1},{zsw3+50*7,zsw1},{zsw3+50*8,zsw1},{zsw3+50*9,zsw1},}	
	local wz = {"初窥门径", "初窥门径", "略有小成", "略有小成", "渐入佳境", "渐入佳境", "融会贯通", "融会贯通", "炉火纯青", "炉火纯青", "登峰造极"}
	local djwz = {"一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "极"}
	local pjwz = {"Ｗ".."初阶武功","Ｌ".."中阶武功","Ｒ".."高阶武功","Ｇ".."绝学武功"}		
	local color = RGB(248,248,181)
	local zsmenu = {}
	local zsnum ,hg,sf,FY,WGFY,WGSTARTH= 0,40,0,0,0,0	
	local STARTH1,WGFY1,WGSTARTH1,Mstarth =0,0,0,0
	local zb5 = {{CC.ScreenW/2.03,CC.ScreenH/1.352},{CC.ScreenW/1.773,CC.ScreenH/1.352}}
	local xj,yj,zsn = nil,33,28
	local FY1,h,h1,SHUOMING,xlsm,Mfy = 0,0,0,0,0,0
	local wzbx6,wzby6,wgzbx,wgzby = CC.ScreenW/5.484,CC.ScreenH/4.74,CC.ScreenW/25,CC.ScreenH/2 - size*2.5
	local id = -1
	local dh = 0	
	local lb1 = 1
	local p2x = bx*80 + bx*30
	local p2y = by*80 + by*30
	local rnum = 5
	local zmenu = {{'属 性',275,278,364},{'武 功',276,279,365},{'秘 技',277,311,366},{'经 脉',310,280,367},{'战 斗',563,562,564}} --名称，黄色亮图，菜单图，红色亮图
	local mid = 1
	local jmtx = 0
	local wgy1 = size2*1.2
	local zsh,zsw = size*1.5,size*1.1 --招式部分的文字坐标控制
	local zdpage,tb2 = 1,1
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
	local kf
	local function miji_info(md)
		----lib.Debug(thingID);
		local h1 = 0
		local me = {}
		local hs1 = 0
		local myh1 = 7
		local mm = 1		
		local function strcolor_switch(s)
			local Color_Switch={{"Ｒ",PinkRed},{"Ｇ",M_Wheat},{"Ｂ",C_BLACK},{"Ｗ",RGB(178,158,124)},{"Ｏ",C_ORANGE},{"Ｌ",LimeGreen},{"Ｄ",M_DeepSkyBlue},{"Ｚ",Violet}}
			for i = 1, 8 do
				if Color_Switch[i][1] == s then
					return Color_Switch[i][2]
				end
			end
		end
		if Pmiji_info[md] ~=  nil  then
			for i = 1,#Pmiji_info[md] do
				me[#me+1] =Pmiji_info[md][i]
				if i == Pmiji_info[md] then
					me[#me+1] = "Ｎ"
				end
				
			end
		else
			me[#me+1] = ''
		end		
		for i = mm, #me do
			local smsize = CC.DefaultFont*0.6
			local tfstr = me[i]
			local color;
			color = strcolor_switch(string.sub(tfstr,1,2))
			tfstr = string.sub(tfstr,3,-1)
			if string.sub(tfstr,1,2) == "Ｎ" then
			--	hs1 = hs1 + 1
			else 
				h1 = tjm(wgzbx, CC.ScreenH/2-size*1.3 + size*1.4* (hs1-Mstarth), tfstr, C_BLACK, smsize*1.2,20,size*1.48,Mstarth-hs1,myh1+1-hs1+Mstarth)		
			end			
			hs1 = hs1 + h1
		end
		if hs1 > myh1 then
			Mfy = limitX(hs1-myh1-1,0)
		else
			Mfy = 0
		end		
		if 	Mfy > 0 then 
			lib.LoadPNG(91,124*2,CC.ScreenW/2-size*4.2,CC.ScreenH/2+size*10,1,0,60) 
		end	
		if Mstarth > 0 then 
			lib.LoadPNG(91,127*2,CC.ScreenW/2-size*4.2,CC.ScreenH/2+size*4,1,0,60) 
		end	
	end	
	--招式方针
	local zdwz1 = {'一','二','三','四','五','六','七','八','九',}
	--攻击方针
	local zdwz2 = {
		{'移动攻击.单','原地攻击.单','原地防御.单','逃离防御.单','原地休息.单','移动攻击.全','原地攻击.全','原地防御.全','逃离防御.全','原地休息.全'},
		{'不施毒','自动施毒',},
		{'不使用暗器','自动暗器',},
	}	
	local zdwz3 = { 
		{'不吃生命药','命低于一成','命低于三成','命低于五成','命低于七成'},
		{'不吃内力药','内低于一成','内低于三成','内低于五成','内低于七成'},
		{'不吃体力药','体低于一成','体低于三成','体低于五成','体低于七成'},
	}	
	local zdwz4 = {
		{'不切换内功','命低于一成','命低于三成','命低于五成'},
		{'不喝酒','五宝花蜜酒','即墨老酒','梨花酒','自动喝酒'},
		{'不治疗','治疗自己','治疗他人','自动治疗',},
	}		
	local zh = by*77
	while true do 
		if JY.Restart == 1 then
			break
		end
		Cls()	
		lib.LoadPNG(91,273*2,-1,-1,1)
		lib.LoadPNG(91,283*2,-1,-1,1)
		--随便用个人物id收集这一段长代码
		local rwqx = 0
		for i = 1,8 do 
			local aid  = team[i+tid2]
			if aid ~= nil then 
				local headid = JY.Person[aid]["半身像"]
				lib.LoadPNG(1,headid*2,CC.ScreenW/17+(i-1)*CC.ScreenW/9.07,CC.ScreenH/40,1,0,CC.ScreenH/8)--适配*1.25				
				if tid == i then 
					lib.LoadPNG(91,22*2,CC.ScreenW/20+(i-1)*CC.ScreenW/9.07,CC.ScreenH/40,1,0,CC.ScreenH/8/1.28)
					local zs = 0
					local dl = 0
					for j =1,5 do
						if JY.Person[aid]['出招动画帧数'..j]>0 then
							if j>1 then
								zs = JY.Person[aid]['出招动画帧数'..j]
								break
							end
							dl = dl+JY.Person[aid]['出招动画帧数'..j]*4
						end
					end					
					lib.PicLoadCache(JY.Person[aid]["头像代号"]+101,(dl+dh+zs*3)*2,CC.ScreenW/3.4,CC.ScreenH/1.1)					
					dh = dh + 1
					if dh == zs then
						dh = 0
					end
				end
				lib.LoadPNG(91,(298+(JY.Person[aid]['畅想分阶']-1)) *2,CC.ScreenW/17+(i-1)*CC.ScreenW/9.07+size*3,CC.ScreenH/40+size*1.23,1,0,100)	
			else
				lib.LoadPNG(1,1512*2,CC.ScreenW/17+(i-1)*CC.ScreenW/9.07,CC.ScreenH/40,1,0,CC.ScreenH/8)
			end	
				
		end
		id = team[tid+tid2]
		lib.LoadPNG(90,JY.Person[id]["半身像"]*2,CC.ScreenW/20,CC.ScreenH-CC.ScreenH/2.2,1)		
		lib.DrawStr(CC.ScreenW/2-string.len(JY.Person[id]["姓名"])/4*size2*1.9,by*178,JY.Person[id]["姓名"],C_WHITE,size2*1.8,CC.FontName)
		local cpd = 0
		if page == 4 then 
			if lb > 0 then 
				cpd = 1
			end
		else
			if lb1 > 1 then 
				cpd = 1
			end
		end

		--菜单页背景
		if cpd == 1 then 
			lib.LoadPNG(91,zmenu[page][4]*2,-1,-1,1)
		else
			lib.LoadPNG(91,zmenu[page][2]*2,-1,-1,1)
		end
		lib.LoadPNG(91,zmenu[page][3]*2,-1,-1,1) 

		--页码
		local pwz = 0
		if page == 1 then 
			pwz = lb1..'/'..2
		elseif page < 4 or page == 5 then
			pwz = lb1..'/'..3
		elseif page == 4 then 
			pwz = (lb+1)..'/'..4
		end
		lib.LoadPNG(91,71*2,CC.ScreenW/1.1-size2/50,CC.ScreenH/2.69-size2/3,1,0,50) 

		lib.DrawStr(CC.ScreenW/1.1,CC.ScreenH/2.69,pwz,C_WHITE,size2,CC.FontName)

		local p = JY.Person[id]
		local x,y = CC.ScreenW/10,CC.ScreenH/1.52 --115 706
		local pcx,pcy,pcx1 = x-CC.FontSmall3,CC.ScreenH-CC.ScreenH/12,x-CC.FontSmall3- CC.RowPixel;
		local lifexs = "命 "..p["生命"].." / "..p["生命最大值"] --生命
		local nlxz = {'阴','阳','调和','天罡'}
		local nlxs = "内 "..p["内力"].." / "..p["内力最大值"]..'('..nlxz[p['内力性质']+1]..')'  --内力

		--生命条
		local pcw, pch = lib.GetPNGXY(91, 289 * 2);  
		lib.LoadPNG(91, 293 * 2 , pcx  , pcy-pch/2, 1)
		lib.SetClip(pcx1, pcy-pch/2, pcx1 + (p["生命"]/p["生命最大值"])*(pcw), pcy-pch/2 + pch)
		lib.LoadPNG(91, 289 * 2 , pcx  , pcy-pch/2, 1)
		pcy = pcy + CC.RowPixel + CC.FontSmall3 -CC.ScreenH/384
		lib.SetClip(0,0,0,0)
		DrawString(pcx, pcy-pch*1.15  , lifexs, C_WHITE, CC.FontSmall3)

		--内力条
		local hh = pch/4
		lib.LoadPNG(91, 293 * 2 , pcx  , pcy +hh-pch/2, 1)
		lib.SetClip(pcx1, pcy-pch/2 +hh, pcx1 + (p["内力"]/p["内力最大值"])*(pcw), pcy-pch/2 + pch +hh)
		lib.LoadPNG(91, 290 * 2 , pcx  , pcy+hh-pch/2, 1)
		pcy = pcy + CC.RowPixel + CC.FontSmall3 -2
		lib.SetClip(0,0,0,0)
		DrawString(pcx, pcy-pch*1.15+hh , nlxs, C_WHITE, CC.FontSmall3)
		
		--门派
		--local jj = {"传说","宗师","豪侠","一流","二流","三流"}
		local pergx = "" 
		if JY.Base['妻子'] > 0 then 
			if id == JY.Base['妻子'] then 
				pergx = '配偶 '..JY.Person[0]['姓名']
				if JY.Base['孩子'] > 0 then 
					pergx = pergx.."   "..'子女 '..JY.Person[JY.Base['孩子']]['姓名']
				end
			end 
		end
		if JY.Base['孩子'] > 0 then 
			if id == JY.Base['孩子'] then 
				pergx = '父母 '..JY.Person[0]['姓名']..' '..JY.Person[JY.Base['妻子']]['姓名']
			end 
		end
		if id == 0 then 
			if JY.Base['妻子'] > 0 then 
				pergx = '配偶 '..JY.Person[JY.Base['妻子']]['姓名']
				if JY.Base['孩子'] > 0 then 
					pergx = pergx.."   "..'子女 '..JY.Person[JY.Base['孩子']]['姓名']
				end
			end
		end
		local mpbs = CC.ScreenH/9.6
		-- 门派、职务、境界文字显示
		lib.LoadPNG(91, (240 + JY.Person[id]["门派"]) * 2, CC.ScreenW/6.8-CC.ScreenW/8.5, CC.ScreenH/3.2-CC.ScreenH/76.8,1,0,mpbs)
		DrawString(CC.ScreenW/6.8-size*2.5,CC.ScreenH/3.2+size*1.3,pergx,M_DeepSkyBlue,size2*1.4)
		DrawString(CC.ScreenW/6.8-size*2.5,CC.ScreenH/3.2+size*0.3,MP_name(id)..MP_zw(id),C_WHITE,size2*1.4)
		--35 240
		--点数
		DrawString(CC.ScreenW/68, CC.ScreenH/4.517, "修炼经验："..math.modf(JY.Person[id]["物品修炼点数"]), C_WHITE, size*0.75)
		DrawString(CC.ScreenW/68+size*7, CC.ScreenH/4.517, "武学点数："..JY.Person[id]["武学点数"], C_WHITE, size*0.75)
		DrawString(CC.ScreenW/68+size*7*2, CC.ScreenH/4.517, "门派贡献："..JY.Person[id]["门派贡献"], C_WHITE, size*0.75)
		DrawString(CC.ScreenW/68, CC.ScreenH/4.517+size, "实战："..JY.Person[id]["实战"], C_WHITE, size*0.75)
		--天赋		
		local tfme = {} --天赋编号表
		local tfname = -1 --表赋图标
		local tfsmn = {}  --天赋名称
		local tfsm = {}  --天赋说明
		local row = 0  
		local maxh = 10
		local fy ,fymax,star = 0 ,0 , 1
		local xcolor = M_Gray

		--存天赋编号
		for i = 1,5 do 
			if JY.Person[id]['天赋'..i] > 0 then 
				tfme[#tfme+1] = {JY.Person[id]['天赋'..i],CC.PTFSM[JY.Person[id]['天赋'..i]][5]}
				--removebyvalue(tfme,0, 0)
			end
		end
		local function wg_px(a,b)
			return a[2] < b[2]
		end
		table.sort(tfme,wg_px)
		--table.sort(tfme)
		--天赋图标显示
		--if CC.PTF[id] ~= nil then
		local tfbj = {543,542,541,540}		
		for t = 1,#tfme do
			tfname = tfme[t][1]
			local tfbj1 = CC.PTFSM[tfme[t][1]][5]
			if tfname >= 9000 then
				tfname = tfname-8000
			end
			lib.LoadPNG(96,tfname*2,tfx-CC.ScreenW/160+(t-1)*CC.ScreenW/19.15,tfy-CC.ScreenH/100,1,0,CC.ScreenW/1360*130)
			lib.LoadPNG(91,(tfbj[tfbj1])*2,tfx-CC.ScreenW/160+(t-1)*CC.ScreenW/19.15,tfy-CC.ScreenH/100,1,0,CC.ScreenW/1360*130)
			if tfid == t and lb1 == 2 then 
				lib.LoadPNG(91,36*2,tfx-CC.ScreenH/90.666+(t-1)*CC.ScreenW/19.2,tfy-by*10,1,0,CC.ScreenW/1360*30)
			end
		end
		--end
		--天赋名字
		local tfcl = M_LightBlue
		local ftnm2 = {}
		for i = 1,#tfme do	
			local tfnm = tfme[i][1]	
			--if CC.PTF[id] ~= nil then
				if CC.PTFSM[tfnm] ~= nil then
					ftnm2[#ftnm2+1] = CC.PTFSM[tfnm][1]
					if CC.PTFSM[tfnm][5] == 2 then
						tfcl = M_Purple
					elseif CC.PTFSM[tfnm][5] == 3 then
						tfcl = Color_Hurt1
					elseif CC.PTFSM[tfnm][5] == 4 then
						tfcl = C_RED
					end
				end
			--end	
			if ftnm2[i] ~= nil then
				if px >= tfx + (i-1)*CC.ScreenW/19.4285 and px <= tfx + (i)*CC.ScreenW/22.666 + (i-1)*CC.ScreenW/90.666 and py >= tfy and py <= tfy+CC.ScreenH/13.963  then
					lib.LoadPNG(91, 90 * 2 ,CC.ScreenW/8 + (i-1)*size*2.5 -string.len(ftnm2[i])/4*size2-size*2,CC.ScreenH/1.896, 1 )
					DrawString(CC.ScreenW/7.555 + (i-1)*size*2.5 -string.len(ftnm2[i])/4*size2-size*2,by*410,ftnm2[i],tfcl,size2*1)
				end
			end		
		end	

		--三神技秘技学会
		local mjcolor = M_Gray
		local mjwz = {{'中庸',2,123},{'斗转',3,118},{'左右',4,121}}
		if Pmiji(id,1) then 
			mjwz[1][1] = '中庸'
			mjwz[1][2] = 1
		end
		for i = 1,#mjwz do  
			local mjx = CC.ScreenW/50
			local mjy = CC.ScreenH/2+CC.ScreenH/25 + (i-1)*size*1.7
			if Pmiji(id,mjwz[i][2])  then 
				mjcolor = M_DeepSkyBlue
				lib.LoadPNG(98, (mjwz[i][3]+1) * 2,mjx,mjy , 1)
				DrawString(mjx, mjy, mjwz[i][1], mjcolor, size*0.8)
			else
				lib.LoadPNG(98, (mjwz[i][3]) * 2 ,  mjx, mjy, 1)
				DrawString(mjx, mjy, mjwz[i][1], mjcolor, size*0.8)
			end	
		end	

		--运功 
		local smenu = {JY.Person[id]["优先使用"],JY.Person[id]["主运内功"],JY.Person[id]["主运轻功"]}
		if JY.Person[id]["优先使用"] > 0   then
			lib.LoadPNG(98, (500+JY.Person[id]["优先使用"]) * 2 , CC.ScreenW/3.222, CC.ScreenH/1.57, 1)
		else
			lib.LoadPNG(91, 77 * 2 ,  CC.ScreenW/3.222, CC.ScreenH/1.57, 1)
		end	
		if JY.Person[id]["主运内功"] > 0  then
			lib.LoadPNG(98, (500+JY.Person[id]["主运内功"]) * 2 , CC.ScreenW/3.148,CC.ScreenH/1.383,1)
		else
			lib.LoadPNG(91, 76 * 2 ,CC.ScreenW/3.148,CC.ScreenH/1.383,1)
		end	
		if JY.Person[id]["主运轻功"] > 0  then
			lib.LoadPNG(98, (500+JY.Person[id]["主运轻功"]) * 2 ,CC.ScreenW/3.162,CC.ScreenH/1.224,1)
		else
			lib.LoadPNG(91, 78 * 2 ,CC.ScreenW/3.162,CC.ScreenH/1.224,1)
		end	
		lib.LoadPNG(91, 285 * 2 , -1,-1,1)

		--装备武学 主运武功
		local wxzb = {{CC.ScreenW/3.222,CC.ScreenH/1.57},{CC.ScreenW/3.148,CC.ScreenH/1.383},{CC.ScreenW/3.163,CC.ScreenH/1.225}}
		local wxname = {JY.Wugong[JY.Person[id]["优先使用"]]['名称'],JY.Wugong[JY.Person[id]["主运内功"]]['名称'],JY.Wugong[JY.Person[id]["主运轻功"]]['名称']	}
		local zbwxbs = CC.ScreenH/6.981
		for i = 1,3 do 
			local name = wxname[i]
			if smenu[i] > 0 then
				if px > wxzb[i][1] and px <  wxzb[i][1] + CC.ScreenW/28.333 and py > by*wxzb[i][2] and py < by*wxzb[i][2]+CC.ScreenH/16 then
					lib.LoadPNG(91, 90 * 2 , CC.ScreenW/4.459,CC.ScreenH/1.551+(i-1)*CC.ScreenH/11.294, 1,0,zbwxbs )
					DrawString(CC.ScreenW/3.24-string.len(name)/4*size2-size*2,CC.ScreenH/1.536+(i-1)*CC.ScreenH/11.294,name,C_WHITE,size2*1)
				end
			end
		end	

		--装备兵器防具坐骑
		local zbbs = CC.ScreenH/12.8
		local zbbs1 = CC.ScreenH/6.982
		--
		--	zbbs = zbbs/2
		--	zbbs1 = zbbs1/2
		--end
		for i = 1,3 do 
			local  zm = {"A","B","Z"}
			local p = JY.Person[id]
			local zb = {p["武器"],p["防具"],p["坐骑"]}
			local zbname = -1
			local lv = 1
			local lv1 = {"壹级","贰级","叁级","肆级","伍级","陆级"}
			if zb[i] > -1 then
				 zbname = JY.Thing[zb[i]]["名称"]
				 lv = JY.Thing[zb[i]]["装备等级"]
			else
				zbname = "无"
				lv1[lv] = ""
			end			
			lib.LoadPNG(91, 281 * 2 ,CC.ScreenW/75.555,CC.ScreenH/1.352+(i-1)*size*2.2, 1)
			if zb[i] > -1 then
				lib.PicLoadCache(2,zb[i] * 2,CC.ScreenW/75.555,by*570 +(i-1)*size*2.2 ,1,0,0,-1,-1,0,0,zbbs)
				if px >= CC.ScreenW/75.555 and px <= CC.ScreenW/75.555 + CC.ScreenW/22.666 and py >= by*570+(i-1)*size*2.2  and py <= by*570+by*60+(i-1)*size*2.2 then
					lib.LoadPNG(91, 90 * 2 , bx*85,by*585+(i-1)*size*2.2, 1,0,zbbs1 )
					DrawString(bx*200-string.len(zbname)/4*size2-size*2,by*590+(i-1)*size*2.2,zbname,C_WHITE,size2*1)
					if JY.Thing[zb[i]]["装备等级"] > 0 then 
						DrawString(bx*200-string.len(zbname)/4*size2-size*2,by*590+(i-1)*size*2.2,"         "..lv1[lv],C_ORANGE,size2*1)
					else
						DrawString(bx*200-string.len(zbname)/4*size2-size*2,by*590+(i-1)*size*2.2,"         ".."无",C_ORANGE,size2*1)	
					end		
				end				
			end	
			DrawString(CC.ScreenW/22.666,by*605+(i-1)*size*2.2,zm[i],C_WHITE,size2*1)		
		end

		--门派
		if px >= CC.ScreenW/39 and px < CC.ScreenW/39 + CC.ScreenW/19.4 and py >= CC.ScreenH/3.2 and py <CC.ScreenH/3.2 + CC.ScreenH/11 then 
			lib.LoadPNG(91,37*2,CC.ScreenW/39 + CC.ScreenW/18,CC.ScreenH/3.2,1,0,160)
			tjm(CC.ScreenW/30 + CC.ScreenW/18, CC.ScreenH/3.1,MP_TX(JY.Person[id]['门派']),C_BLACK,size*0.6,12,size*0.6)
		end
		--天赋说明
		if TFSHUOMING == 1 then
			lib.LoadPNG(91,282*2,-1,-1,1,0,100)
			if CC.PTFSM[tfme[tfid][1]] ~= nil then
				local tfcl = C_WHITE
				if CC.PTFSM[tfme[tfid][1]][5] == 2 then
					tfcl = M_Purple
				elseif CC.PTFSM[tfme[tfid][1]][5] == 3 then
					tfcl = Color_Hurt1
				elseif CC.PTFSM[tfme[tfid][1]][5] == 4 then
					tfcl = C_RED
				end
				tfsm[#tfsm+1] =CC.PTFSM[tfme[tfid][1]][2]
				tfsmn[#tfsmn+1] =  {CC.PTFSM[tfme[tfid][1]][1],tfcl}
			end
			for i = 1,#tfsmn do 
				DrawString(bx*310-string.len(tfsmn[i][1])/4*size2-size*2,by*420,tfsmn[i][1],tfsmn[i][2],size2*1.4)
			end
			for i = star, #tfsm do
				local tfstr = tfsm[i]
				local h = 0						
				if string.sub(tfstr,1,2)  == "Ｎ" then
					row = row + 1
				else
					h = tjm(bx*50, by*458 + size*0.8 * (row-fy), tfstr, C_WHITE, size*0.8,math.modf((bx*470)/size/0.8)-1,size*0.9,fy-row,maxh+1-row+fy)
				end
				row = row + h
			end
			if row > maxh then
				fymax = limitX(row-maxh-1,0)
			else
				fymax = 0
			end
		end	

		if page == 1 then
			local p_1 = {{'资质',p['资质'],nil,"影人物学习武功速度，内力最大值。"},{'体质',p['体质'],nil,"影响人物生命最大值。"},{'医疗',p['医疗能力'],FJYIL(id),"影响人物治疗量。"},
						{'用毒',p['用毒能力'],FJYONGD(id),"影响人物用毒能力。"},{'解毒',p['解毒能力'],FJJIED(id),"影响人物解毒能力。"},{'带毒',p['攻击带毒'],FJDAID(id),"影响攻击对敌方造成的中毒点数。"}}
			local p_2 = {{'攻击',p['攻击力'],FJGONGJ(id),"主要影响攻击伤害、人物命中。"},{'防御',p['防御力'],FJFANGY(id),"主要影响受到的伤害减少、格档值。少量影响人物闪避。"},{'轻功',p['轻功'],FJQINGG(id),"主要影响人物命中、闪避。"},
						{'格挡',Person_GD(id),FJPerson_GD(id),"主要影响人物格档概率。"},{'命中',Person_MZ(id),FJPerson_MZ(id),"主要影响人物命中概率。"},{'闪避',Person_SB(id),FJPerson_SB(id),"主要影响人物闪避概率。"},
						{'集气',Person_JQ(id),nil,"主要影响人物出手速度。"},{'连击',Person_LJ(id),nil,"主要影响人物连击概率。"},{'暴击',Person_BJ(id),nil,"主要影响人物暴击概率。"},}
			local p_3 = {
						{'拳掌',p['拳掌功夫'],FJQZ(id),"主要影响人物学习拳掌武功的能力。",Pqfcz(id)},{'指法',p['指法技巧'],FJZF(id),"主要影响人物学习指法武功的能力。",Pzfcz(id)},
						{'御剑',p['御剑能力'],FJYJ(id),"主要影响人物学习剑法武功的能力。",Pjfcz(id)},{'耍刀',p['耍刀技巧'],FJDF(id),"主要影响人物学习刀法武功的能力。",Pdfcz(id)},
						{'奇门',p['特殊兵器'],FJQM(id),"主要影响人物学习特殊武功的能力。",Pqmcz(id)},{'暗器',p['暗器技巧'],FJANQI(id),"主要影响人物使用暗器造成的伤害。",Paqcz(id)},
						}
			local n,m = 0,0
			local fj = 0
			for i = 1,#p_1 do
				if p_1[i][3] ~= nil and p_1[i][3] ~= 0 then
					local w = nil
					local cl = C_WHITE
					if p_1[i][3] > 0 then 
						w = "    ↑"
						cl = M_DeepSkyBlue
					else
						w = "    ↓"
						cl = C_RED
					end
					DrawString(bx*625+n*bx*230+size*2.8,by*475+m*bx*35, w,cl,size*0.7)
					DrawString(bx*625+n*bx*230+size*4,by*470+m*bx*35, "  "..p_1[i][3],C_WHITE1,size*0.9)
				end
				DrawString(bx*625+n*bx*230,by*340+m*bx*35,p_1[i][1]..' '..p_1[i][2],C_WHITE,size*0.9)
				local xx,yy = 53,20
				local smsize,h1,hs1,s1,smwz,myh1 = size*0.9,0,0,0,p_1[i][4],3
				if px > bx*625+n*bx*230 and px < bx*625+n*bx*230 + xx and py > by*340+m*bx*35 and py < by*340+m*bx*35 + yy then
					lib.LoadPNG(91,37 * 2 , bx*625+n*bx*230-bx*165, by*340+m*bx*35, 1)
					tjm(bx*635+n*bx*230-bx*165, by*350+m*bx*35,smwz,C_BLACK,size*0.6,7,size*0.6)
				end
				n = n + 1
				if n == 3 then 
					n = 0
					m = m + 1
				end
			end
			n = 0
			m = 0
			for i = 1,#p_1 do
				local xx,yy = 53,20
				local smsize,h1,hs1,s1,smwz,myh1 = size*0.9,0,0,0,p_1[i][4],3
				if px > bx*625+n*bx*230 and px < bx*625+n*bx*230 + xx and py > by*340+m*bx*35 and py < by*340+m*bx*35 + yy then
					lib.LoadPNG(91,37 * 2 , bx*625+n*bx*230-bx*165, by*340+m*bx*35, 1)
					tjm(bx*635+n*bx*230-bx*165, by*350+m*bx*35,smwz,C_WHITE,size*0.6,7,size*0.6)
				end
				n = n + 1
				if n == 3 then 
					n = 0
					m = m + 1
				end
			end
			n = 0
			m = 0
			for i = 1,#p_2 do 
				local s = '※'
				if p_2[i][2] ~= nil then
					s = p_2[i][2]
				end
				if p_2[i][3] ~= nil and p_2[i][3] ~= 0 then
					local w = nil
					local cl = C_WHITE
					if p_2[i][3] > 0 then 
						w = "    ↑"
						cl = M_DeepSkyBlue
					else
						w = "    ↓"
						cl = C_RED
					end
					DrawString(bx*625+n*bx*230+size*2.8,by*475+m*bx*35, w,cl,size*0.7)
					DrawString(bx*625+n*bx*230+size*4,by*470+m*bx*35, "  "..p_2[i][3],C_WHITE1,size*0.9)
				end
				DrawString(bx*625+n*bx*230,by*470+m*bx*35,p_2[i][1]..' '..s,C_WHITE,size*0.9)
				n = n + 1
				if n == 3 then 
					n = 0
					m = m + 1
				end
			end
			n = 0
			m = 0
			for i = 1,#p_2 do 
				local xx,yy = 53,20
				local smsize,h1,hs1,s1,smwz,myh1 = size*0.9,0,0,0,p_2[i][4],3
				if px > bx*625+n*bx*230 and px < bx*625+n*bx*230 + xx and py > by*470+m*bx*35 and py < by*470+m*bx*35 + yy then
					lib.LoadPNG(91,37 * 2 , bx*625+n*bx*230-bx*165, by*470+m*bx*35, 1)
					tjm(bx*635+n*bx*230-bx*165, by*475+m*bx*35,smwz,C_WHITE,size*0.6,7,size*0.6)
				end
				n = n + 1
				if n == 3 then 
					n = 0
					m = m + 1
				end
			end
			n = 0
			m = 0
			for i = 1,#p_3 do 
				local s = '※'
				local cz = p_3[i][5]
				if p_3[i][2] ~= nil then
					s = p_3[i][2]
				end
				if p_3[i][3] ~= nil and p_3[i][3] ~= 0 then
					local w = nil
					local cl = C_WHITE
					if p_3[i][3] > 0 then 
						w = "    ↑"
						cl = M_DeepSkyBlue
					else
						w = "    ↓"
						cl = C_RED
					end   
					DrawString(bx*625+n*bx*325+size*2.8,by*645+m*by*35, "           "..w,cl,size*0.7)
					DrawString(bx*625+n*bx*325+size*4,by*640+m*by*35, "           "..p_3[i][3],C_WHITE1,size*0.9)
				end			
				DrawString(bx*625+n*bx*325,by*640+m*by*35,p_3[i][1]..'           '..s,C_WHITE,size*0.9)
				if cz ~= nil then
					local czpic = 0
					if cz >= 90 then 
						czpic = 304
					elseif cz > 50 and cz < 90 then 
						czpic = 305
					else
						czpic = 306
					end
					lib.LoadPNG(91,czpic*2,bx*600+n*bx*325,by*643+m*bx*35,1,0,105)
					local top1 = 200
					local top2 = 400
					local HG = by*20
					local x1,y1 = bx*685+n*bx*325,by*650+m*bx*35
					local pcx = x1
					local pcy = y1
					local pcx1 = x1
					lib.LoadPNG(91, 235 * 2 , pcx  , pcy, 1)
					local pcw, pch = lib.GetPNGXY(91, 235 * 2);  
					lib.SetClip(pcx1, pcy, pcx1 + (cz/top1)*(pcw), pcy + pch)
					if cz <= 200 then
						lib.LoadPNG(91, 236 * 2 , pcx  , pcy, 1)
					else
						lib.LoadPNG(91, 237 * 2 , pcx  , pcy, 1)
					end
					lib.SetClip(0,0,0,0)
				end
				DrawString(bx*605+n*bx*325+size*3,by*642+m*by*35,cz,C_WHITE1,size*0.75,CC.FONT0)
				--tjm(bx*610+n*bx*325+size*4,by*628+m*by*35,cz,C_WHITE1,size*0.8,5,size*0.3,nil,nil,CC.FONT0)


				n = n + 1
				if n == 2 then
					n = 0
					m = m + 1
				end
			end
			n = 0 
			m = 0
			for i = 1,#p_3 do 
				local xx,yy = 53,20
				local smsize,h1,hs1,s1,smwz,myh1 = size*0.9,0,0,0,p_3[i][4],3
				if px > bx*625+n*bx*325 and px < bx*625+n*bx*325 + xx and py > by*640+m*bx*35 and py < by*640+m*bx*35 + yy then
					lib.LoadPNG(91,37 * 2 , bx*625+n*bx*325-bx*165, by*640+m*bx*35, 1)
					tjm(bx*635+n*bx*325-bx*165, by*645+m*bx*35,smwz,C_WHITE,size*0.6,7,size*0.6)
				end
				local x1,y1 = bx*685+n*bx*325,by*650+m*bx*35
				local pcw, pch = lib.GetPNGXY(91, 235 * 2);  
				if px > x1 and px < x1 + pcw and py > y1 and py < y1 + pch then 
					DrawString(bx*625+n*bx*325,by*640+m*bx*35,p_3[i][1]..'成长: '.. p_3[i][5],M_DarkOrange,size*0.9)
				end
				n = n + 1
				if n == 2 then
					n = 0
					m = m + 1
				end
			end
			n = 0
			m = 0	

		end
		if page == 2 then 			
			local n,m = 0,0		
			--925 684
			local jtzbx,jtzby = bx*925,by*684
			if px >= jtzbx and px <= jtzbx + CC.ScreenW/22.666 and py >= jtzby and py <= jtzby+by*60  then
				local jtwg = JY.Person[id]["天赋外功"..1]
				local jtname = JY.Wugong[jtwg]['名称']
				DrawString(jtzbx+size*3-string.len(jtname)/4*size2-size*2,jtzby-size*0.5,jtname,C_WHITE,size2)
			end
			if px >= jtzbx + bx*62 and px <= jtzbx + bx*110 and py >= jtzby and py <= jtzby+by*60  then
				local jtwg = JY.Person[id]["天赋外功"..2]
				local jtname = JY.Wugong[jtwg]['名称']
				DrawString(jtzbx+size*5-string.len(jtname)/4*size2-size*2,jtzby-size*0.5,jtname,C_WHITE,size2)
			end
			if px >= jtzbx + bx*120 and px <= jtzbx + bx*170 and py >= jtzby and py <= jtzby+by*60  then
				local jtwg = JY.Person[id]["天赋内功"]
				local jtname = JY.Wugong[jtwg]['名称']
				DrawString(jtzbx+size*7-string.len(jtname)/4*size2-size*2,jtzby-size*0.5,jtname,C_WHITE,size2)
			end
			if px >= jtzbx + bx*178 and px <= jtzbx + bx*230 and py >= jtzby and py <= jtzby+by*60  then
				local jtwg = JY.Person[id]["天赋轻功"]
				local jtname = JY.Wugong[jtwg]['名称']
				DrawString(jtzbx+size*9-string.len(jtname)/4*size2-size*2,jtzby-size*0.5,jtname,C_WHITE,size2)
			end
			--武功列表		
			for i = 1,JY.Base["武功数量"] do 
				if JY.Person[id]['武功'..i] > 0 then 
					local k = JY.Person[id]['武功'..i]
					local kname = JY.Wugong[k]['名称']							
					lib.LoadPNG(91,281*2,CC.ScreenW/2-CC.ScreenW/53 +n*p2x,wgy1 + CC.ScreenH/2.37+m*p2y,1)	--武功图标背景
					lib.LoadPNG(98,(500+k)*2,CC.ScreenW/2-CC.ScreenW/80 +n*p2x,wgy1 + CC.ScreenH/2.31+m*p2y,1) --武功图标
					DrawString(CC.ScreenW/2 +n*p2x-string.len(kname)/4*size*0.66,wgy1 + by*395+m*p2y,kname,C_WHITE,size*0.68)
					local zbwg = {JY.Person[id]["优先使用"],JY.Person[id]["主运内功"],JY.Person[id]["主运轻功"]}
					for z = 1,#zbwg do 
						if k == zbwg[z] then 
							lib.LoadPNG(91,99*2,CC.ScreenW/2 +n*p2x+CC.ScreenW/35,wgy1 + by*338+m*p2y,1)
						end
					end
					if kid == i then			
						lib.LoadPNG(91,288*2,CC.ScreenW/2-CC.ScreenW/53 +n*p2x,wgy1 + CC.ScreenH/2.37+m*p2y,1,0,130)						
					end
					n = n + 1
					if n == rnum then 
						n = 0
						m = m + 1
					end

					local level = KF_level(id,k)
					local wglx1 = JY.Wugong[k]["武功类型"]	
					local wugongwl = get_skill_power(id, k, level)
					local nn
					if JY.Wugong[k]["武功类型"] < 6 then 
						nn = 1
					end
					if JY.Wugong[k]["武功类型"] == 6 then 
						nn = 2
					end
					if JY.Wugong[k]["武功类型"] == 7 then 
						nn = 3
					end
					kfmenu[i] = {k,wugongwl,nn,level,i} --编号，威力，
				end
			end
			--精通武功 天赋武功
			local p_2 = {'天赋外功1','天赋外功2','天赋内功','天赋轻功'}
			for i=1,#p_2 do 
				if p[p_2[i]] > 0 then --936 696
					lib.LoadPNG(98,(500+p[p_2[i]] )*2,CC.ScreenW/1.46+(i-1)*bx*57,CC.ScreenH/1.105,1)
				end
			end
			--武功说明
			for i = 0, JY.ThingNum - 1 do
				local wugong = JY.Thing[i]["练出武功"]
				if wugong > 0 then
					JY.Thing[i]["需经验"] = JY.Wugong[wugong]["层级"]*100
					if JY.Wugong[wugong]["层级"] > 2 then
						JY.Thing[i]["需经验"] = JY.Wugong[wugong]["层级"]*300
					end
				end
			end
			for i = 1,#kfmenu do					
				local name = JY.Wugong[kfmenu[i][1]]["名称"]	
				wgmenu[i] = {kfmenu[i][1],name,kfmenu[i][4],kfmenu[i][2],kfmenu[i][5]} -- 编号，名称，威力，等级,位置,秘籍
			end
			--say(kid,0,0)                    
            --说明
			if WGSHUOMING > 0 then											
				local cl = color	
				local menu1 = wgmenu[kid]							
				local kf1 =menu1[1]
				local thid = KF_thing(kf1)
				local myThing = JY.Thing[thid]
				local me = JY.Wugong[kf1]["名称"]
				local wgmp =  MPname[JY.Wugong[kf1]["门派"] + 1]
				local level = menu1[3]
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
					if WGSHUOMING == 2 then 
						wgbj = 287 
					end
					--新武功说明背景图
					wgbj = 368
					local wgcl = cl 
					if JY.Wugong[kf1]["层级"] == 1 then
						wgcl = M_LightBlue
					end
					if JY.Wugong[kf1]["层级"] == 2 then
						wgcl = M_Purple
					end 
					if JY.Wugong[kf1]["层级"] == 3 then
						wgcl = Color_Hurt1
					end 
					if JY.Wugong[kf1]["层级"] == 4 then
						wgcl = C_RED
					end 
					local pwz1,pwz2,pwz3,pwz4,pwz5,pwz6 = nil,nil,nil,nil,nil,nil
					lib.LoadPNG(91,wgbj*2,-1,-1,1) 
					--if wlglx
					if JY.Wugong[kf1]['武功类型'] < 6  then 
						if WGSHUOMING == 1 then 
							lib.LoadPNG(91,369*2,-1,-1,1)  -- 招式背景
						end
					end
					lib.LoadPNG(91,371*2,CC.ScreenW/5,CC.ScreenH/2.6,1,0,90)  -- 武功名字背景
					if inteam(id) == false then
					else
						lib.LoadPNG(91,38*2,CC.ScreenW/3.3,CC.ScreenH-size*1.5,1,0,100)  -- 右下角确定键背景
					end
					lib.LoadPNG(91,14*2,size/3,CC.ScreenH/2-size*2.8,1,0,80)  -- 切换武功说明图片
					--DrawString(wgzbx-size*1.5 , wgzby-size*1,wz2[menu1[5]],color,size*0.9)--武功编号
					--lib.DrawStr(bx*363-string.len(JY.Wugong[kf1]["名称"])/4*size,by*310,JY.Wugong[kf1]["名称"], M_Gray,size*1.8, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)	--武功名称显示			
					lib.DrawStr(bx*361-string.len(JY.Wugong[kf1]["名称"])/4*size,by*305,JY.Wugong[kf1]["名称"], wgcl,size*1.8, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)	--武功名称显示	
						
					--tjm(wgzbx,wgzby,"品阶"..":"..pjwz[JY.Wugong[kf1]["层级"]],color,wgsize,11,size*0.8)  --品阶
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
									local id = KF_thing(kf1)
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
					DrawString(wgzbx,wgzby,"门派"..":  "..wgmp..' '..wglx[JY.Wugong[kf1]['武功类型']],C_BLACK,wgsize)    --门派 第一排文字
					DrawString(wgzbx,wgzby+jg1,"修为"..":  "..wz[level].." ".."("..djwz[level]..")",C_BLACK,wgsize)  --修为  --修为 第二排文字
					DrawString(wgzbx,wgzby+jg1*2,pwz1,C_BLACK,wgsize) --第三排文字
					DrawString(wgzbx,wgzby+jg1*3,pwz2,C_BLACK,wgsize) --第四排文字
					DrawString(wgzbx,wgzby+jg1*4,pwz3..'   '..pwz4,C_BLACK,wgsize) --第五排文字
					DrawString(wgzbx,wgzby+jg1*5,pwz5,C_BLACK,wgsize) --第六排文字
					DrawString(wgzbx,wgzby+jg1*6,pwz6,C_BLACK,wgsize) --第七排文字
					--DrawString(wgzbx,wgzby+jg1*5,pwz4,C_WHITE,wgsize) --第四排文字
					--DrawString(wgzbx,wgzby+jg1*5,pwz4,C_WHITE,wgsize) --第四排文字
					if WGSHUOMING == 1 then						
						if JY.Wugong[kf1]["武功类型"] < 6 then
							
							for j = 1,#CC.KFMove[menu1[1]]  do
								local leixing = {91,92,93,94,95,96}
								local lxpic = leixing[JY.Wugong[kf1]["武功类型"]]
								local zsnum = CC.WUGONGZS[menu1[5]][j]
								if JY.Person[id]["武功招式"..zsnum] == 0 then
									lib.LoadPNG(91,lxpic*2,bx*zszb[j][1]-CC.ScreenW/55,zsh+by*zszb[j][2]+by*64,1,0,90)
								else
									lib.LoadPNG(98,(500+kf1)*2,bx*zszb[j][1]-CC.ScreenW/55,zsh+by*zszb[j][2]+by*64,1,0,90)
								end
								local zssm = {}
								local CAOZSM = {}  
								zsn = #CC.KFMove[kf1]
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
								--local zzz = tb4
								if tb4 > 6 then
									tb4 = 6
								end
								local nnn =  wugongwl*(1+(tb4-1)/10)
								local sz = math.ceil(atk*(1+nnn/2000))
								local sznum = {"一","二","三","四","五","六","七","八","九","十"}
								--local wz1 = "造成基础伤害"..'Ｇ'..sz.."Ｗ".."点。"
								--local zsname = CC.KFMove[kf1][j][1] 
								--local zswz = nil
								--local zswz1 = nil

								if tb4 == j then
									lib.LoadPNG(91,88*2,bx*zszb[j][1]-CC.ScreenW/55,zsh+by*zszb[j][2]+by*64,1,0,95)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
									--DrawString(wgzbx-size,wgzby+size*7,JY.Wugong[kf1]["名称"].."第Ｇ"..sznum[tb4].."Ｈ招:Ｄ"..zsname.."     耗气  Ｄ"..CC.KFMove[kf1][j][3],C_CYGOLD,wgsize)	
									tjm(zsw + wgzbx-size,zsh+wgzby+size*7,"Ｇ"..JY.Wugong[kf1]["名称"].."Ｗ第Ｄ"..sznum[tb4].."Ｗ招:Ｄ"..CC.KFMove[kf1][j][1],C_WHITE,wgsize,30,wgsize)
									tjm(zsw + wgzbx+size*8,zsh+wgzby+size*7,"Ｗ    耗气 Ｄ"..CC.KFMove[kf1][j][3],C_WHITE,wgsize,30,wgsize)																								
									local hs = 0
									local ZUIDHS = 4   
									--zswz1 = KF_zswz(kf1,tb4)                               
									--zswz1 = wz1..""..zswz1		
									h = tjm(zsw + wgzbx-size,zsh+wgzby+size*7.7+size* (hs-WGSTARTH1),"造成基础伤害"..'Ｇ'..sz.."Ｗ".."点。"..''..KF_zswz(kf1,tb4), C_WHITE,wgsize*0.9,21,wgsize*0.8,WGSTARTH1-hs,ZUIDHS+1-hs+WGSTARTH1)			
									hs = hs + h	
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
					elseif  WGSHUOMING == 2 then 
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
					
					for p = 1,#zb5 do
						local cl1 = C_WHITE		
						local quxiao = 	"取消"	
						local yungong = "运功"
						local manji = "满级"
						local xiulian = "修炼"		
						if inteam (id) == true then 
							if JY.Wugong[JY.Person[id]["武功"..kid]]["武功类型"] < 6 then
								local yg = nil
								if  JY.Person[id]["优先使用"] > 0  then
									yg = quxiao
								else
									yg = yungong
								end
								if JY.Person[id]["优先使用"] > 0 and JY.Person[id]["优先使用"] ~= JY.Person[id]["武功"..kid] then
									yg = yungong
								end 
								local zbwz5 = {yg,xiulian}
								local zbwz6 = {yg,manji}
								if tb5 == p then
									cl1 = C_RED
								end
			
								if level < 10 then
									lib.DrawStr(bx*zb5[p][1]-wzbx6*0.99,by*zb5[p][2]+wzby6,zbwz5[p], cl1,size*0.9, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)	
								else
									lib.DrawStr(bx*zb5[p][1]-wzbx6*0.99,by*zb5[p][2]+wzby6,zbwz6[p], cl1,size*0.9, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)		
								end	
							end
							if JY.Wugong[JY.Person[id]["武功"..kid]]["武功类型"] == 6 then
								local yg = nil
								if  JY.Person[id]["主运内功"] > 0  then
									yg = quxiao
								else
									yg = yungong
								end
								if JY.Person[id]["主运内功"] > 0 and JY.Person[id]["主运内功"] ~= JY.Person[id]["武功"..kid] then
									yg = yungong
								end 
								local zbwz5 = {yg,xiulian}
								local zbwz6 = {yg,manji}
								if tb5 == p then
									cl1 = C_RED
									--lib.LoadPNG(91,120*2,bx*zb5[p][1]-wzbx6+size,by*zb5[p][2]+wzby6+size*0.5,zbwz5[p],1)
								end
			
								if level < 10 then
									--DrawString(bx*zb5[p][1]-wzbx6*0.99,by*zb5[p][2]+wzby6,zbwz5[p],cl1,size*0.9)
									lib.DrawStr(bx*zb5[p][1]-wzbx6*0.99,by*zb5[p][2]+wzby6,zbwz5[p], cl1,size*0.9, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)	
								else
									--DrawString(bx*zb5[p][1]-wzbx6*0.99,by*zb5[p][2]+wzby6,zbwz6[p],cl1,size*0.9)	
									lib.DrawStr(bx*zb5[p][1]-wzbx6*0.99,by*zb5[p][2]+wzby6,zbwz6[p], cl1,size*0.9, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)	
								end	
							end								
							if JY.Wugong[JY.Person[id]["武功"..kid]]["武功类型"] == 7 then
								local yg = nil
								if  JY.Person[id]["主运轻功"] > 0  then
									yg = quxiao
								else
									yg = yungong
								end
								if JY.Person[id]["主运轻功"] > 0 and JY.Person[id]["主运轻功"] ~= JY.Person[id]["武功"..kid] then
									yg = yungong
								end 
								local zbwz5 = {yg,xiulian}
								local zbwz6 = {yg,manji}
								if tb5 == p then
									cl1 = C_RED
									--lib.LoadPNG(91,120*2,bx*zb5[p][1]-wzbx6+size,by*zb5[p][2]+wzby6+size*0.5,zbwz5[p],1)
								end
			
								if level < 10 then
									lib.DrawStr(bx*zb5[p][1]-wzbx6*0.99,by*zb5[p][2]+wzby6,zbwz5[p], cl1,size*0.9, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)	
								else
									lib.DrawStr(bx*zb5[p][1]-wzbx6*0.99,by*zb5[p][2]+wzby6,zbwz6[p], cl1,size*0.9, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)	
								end	
							end	
						end	
					end	
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
					if level >= 10 then
						r = "――"
					end
					--升级经验
					--修炼经验
					DrawString(wgzbx-size, CC.ScreenH-size," 修炼点数： "..math.modf(JY.Person[id]["物品修炼点数"]).."    ".."升级需："..r, C_WHITE,wgsize)
				end
			end    
			if xlsm == 1 then 
				lib.LoadPNG(91, 90 * 2 , bx*382, by*540, 1,0,220 )
				DrawString(bx*382, by*559,"修炼点数不够",C_RED,size*1.4)
			end 
			if xlsm == 2 then 
				lib.LoadPNG(91, 90 * 2 , bx*382, by*540, 1,0,220 )
				DrawString(bx*382, by*559,"武功已修炼满级",C_RED,size*1.4)
			end        			
		end
		if page == 3 then 
			local n,m = 0,0	
			local x1,y1 = lib.GetPNGXY(98,1*2)	
			local x2,y2 = lib.GetPNGXY(91,281*2) 

			for i = 1,10 do 
				if JY.Person[id]['秘技'..i] > 0 then 
					MJMenu[i] = {JY.Person[id]['秘技'..i],i}
					----lib.Debug('秘技数量'..#MJMenu)
					local k = JY.Person[id]['秘技'..i]
					local kname = JY.Teji[k]['名称']						
					lib.LoadPNG(91,281*2,CC.ScreenW/2 +n*p2x-x2/2,by*400+m*p2y-y2/2,1)		
					lib.LoadPNG(98,(500+k)*2,CC.ScreenW/2 +n*p2x-x1/2,by*400+m*p2y-y1/2,1)
					DrawString(CC.ScreenW/2 +n*p2x-string.len(kname)/4*size*0.66,by*440+m*p2y,kname,C_WHITE,size*0.68)
					if mid == i then			
						lib.LoadPNG(91,288*2,CC.ScreenW/2 +n*p2x-size,by*400+m*p2y-size,1,0,130)												
					end
					n = n + 1
					if n == rnum then 
						n = 0
						m = m + 1
					end
				end
			end 

			if JY.Teji[JY.Person[id]['秘技'..mid]]["名称"] ~= '无' then 
				local mjname = JY.Teji[JY.Person[id]['秘技'..mid]]["名称"]
				if MJSHUOMING == 1 then
					lib.LoadPNG(91,368*2,-1,-1,1)
					lib.DrawStr(CC.ScreenW/10-string.len(mjname)/4*size-size,by*303,'■'..mjname..'■', M_Gray,size*1.2, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)	--秘技名称显示			
					lib.DrawStr(CC.ScreenW/10-string.len(mjname)/4*size-size,by*300,'■'..mjname..'■', C_RED,size*1.2, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)	--秘技名称显示						
					miji_info(JY.Person[id]['秘技'..mid])
				end
			end
		end
		if page == 4 then 
			if tb == 5 then
				tjm(bx*336+p_3x,by*150+p_3y,smwz[2],C_BLACK,size*0.8,29,size*0.8)
			else
				tjm(bx*336+p_3x,by*150+p_3y,smwz[1],C_BLACK,size*0.8,29,size*0.8)
			end
			for i = 1,#menu do
				local cl = color
				local smsize = CC.DefaultFont*0.6
				if tb == 1  then
					local menu1 = {}	
					local h1 = 0
					local me = {}
					local hs1 = 0
					local myh1 = 3
					for j = 1,#ssymenu do
						local cl = C_WHITE
						if tb1 == j  then
							cl =  C_RED
							lib.LoadPNG(91,225 * 2 , -1, -1, 1)					
							for p = 1,#ssymenu[j] do
								local qx = ssymenu[j]
								local name = qx[p][1]
								local stn = string.len(name) / 2
								local hsize = bx*40/stn
								local cl1 = C_WHITE1	
								local x,y = bx*qx[p][6]+p_3x,by*qx[p][7]+p_3y													
								if cot1 > 0 then
									rwqx = ssymenu[tb1][cot1][8]
								end
								local n = ssymenu[tb1][p][8]
								local jh = 0
								local jh1 = 0
								if j == 2  then
									jh = by*55
								elseif j == 1 or j == 3 then
									jh1 = by*35
								end
								local x1,y1 = bx*230+p_3x,by*230+p_3y						
								local ycolor;

								local x4,y4 = x-CC.ScreenW/272- size*0.7,y-CC.ScreenH/152- size*0.7 																
								--特殊经脉
								local TSJM = CC.TSJM_SSYIN 
								for pa =1, #TSJM do 
									if TSJM[pa][3]  == n  then 
										ycolor = 319+pa 
										lib.LoadPNG(91,ycolor * 2 ,x4, y4, 1,0,40)																				
										if JY.Person[id]["奇穴"..n] < 1  then
											lib.LoadPNG(91,362 * 2 ,x4, y4, 1,0,40)											
										end	
									end	
								end

								--经脉点文字和图片
								if JY.Person[id]["奇穴"..n] > 0  then	
									lib.LoadPNG(91,129 * 2 ,x4+size*0.7, y4+size*0.7, 1)									
									xcolor = C_RED
									if cot1 ~= p then
										cl1 = C_ORANGE
									else 
										cl1 = C_RED
									end
									if IsOuNumber(p) then
										draw3(name,x+bx*2,y- ((stn-1)*hsize+size*0.7)/2-by*40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,231 * 2 ,x-bx*14, y-by*70, 1)	
									else
										draw3(name,x+bx*2,y- ((stn-1)*hsize+size*0.7)/2+by*40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,230 * 2 ,x-bx*14, y+by*5, 1)	
									end	
									
								else
									lib.LoadPNG(91,128 * 2 ,x4+size*0.7, y4+size*0.7, 1)
									if IsOuNumber(p) then
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2-40, cl1, size*0.7,nil,hsize)
				 						lib.LoadPNG(91,231 * 2 ,x-bx*14, y-by*70, 1)	
									else
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2+40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,230 * 2 ,x-bx*14, y+by*5, 1)	
									end	
								end	 
								
								--选择经脉时
								if cot1 == p and lb == 3  then 
									
									--特殊经脉奇穴判定	
									local tsjmpd = 0
									for tt =1, #TSJM do 
										if  n == TSJM[tt][3]  then 
											tsjmpd = tt 
										end
									end
									lib.LoadPNG(91,209 * 2 ,CC.ScreenW/2+size,CC.ScreenH/2-size*5, 1) --特殊经脉条件背景 

									local cot1sm = ''
									if cot1 == 1 then 
										cot1sm = '，需要最少学会一门内功'
									end
									tjm(CC.ScreenW/2+size*3.1,CC.ScreenH/2-size*3.9,'需'..qx[p][5]..'点武学经验'..cot1sm,C_WHITE,size*0.8,11,size*0.9)

									lib.LoadPNG(91,208 * 2 ,CC.ScreenW-size*9.3, CC.ScreenH/2+size, 1) --经脉名字背景
									cl1 = C_RED
									lib.LoadPNG(91,67 * 2 ,x-CC.ScreenW/136, y-CC.ScreenH/76.8, 1) --选择图标

									tjm(bx*200+bx*710+p_3x,by*33+by*212+p_3y,name,cl1,size*0.9,11,size*0.9) --经脉名字
									tjm(bx*170+bx*700+p_3x,by*33+by*245+p_3y,qx[p][2].." +"..qx[p][3],M_Wheat,size*0.8,11,size*0.8) --属性
									

									if tsjmpd > 0 then 
										local tsy = size
										local h2,hs2,myh2,STARTH2 = 0,0,10,0
										
										lib.LoadPNG(91,363 * 2 ,CC.ScreenW-size*9.5, CC.ScreenH/2+size*3.5, 1)
										tjm(bx*200+bx*705+p_3x,tsy +size*1.4 + by*30+by*212+p_3y,TSJM[tsjmpd][1] ,C_WHITE,size*0.8,11,size*0.8)
										h2 = tjm(bx*197+bx*660+p_3x, tsy+by*3 + by*33+by*280 + smsize* (hs2-STARTH2)+p_3y, TSJM[tsjmpd][2], C_WHITE1, smsize,8,smsize,STARTH2-hs2,myh2+1-hs2+STARTH2)			
										hs2 = hs2 + h2	
										local h3,hs3,myh3 = 0,0,10										
										h3 = tjm(CC.ScreenW/2+size*3.1,CC.ScreenH/2-size*9 + size*0.8* (hs3-STARTH2)+p_3y, TSJM[tsjmpd][4], C_WHITE, size*0.8,11,size*0.8,STARTH2-hs3,myh3+1-hs3+STARTH2)	--条件文字		
										hs3 = hs3 + h3
										tsjmpd = 1
									end 
									if tsjmpd == 0 then 			
										h1 = tjm(bx*220+bx*660+p_3x, by*33+by*280 + smsize* (hs1-STARTH1)+p_3y, qx[cot1][4], C_WHITE1, smsize,7,smsize,STARTH1-hs1,myh1+1-hs1+STARTH1) --经脉百科			
										hs1 = hs1 + h1
										if hs1 > myh1 then
											FY1 = limitX(hs1-myh1-1,0)
										else
											FY1 = 0
										end	
									end
									if JY.Person[id]["奇穴"..n] == 0  then
										lib.LoadPNG(91,210 * 2 ,CC.ScreenW/2+size,CC.ScreenH/2-size*5, 1) --特殊经脉条件背景 2
									end
								end					
							end										
						end
						if lb > 1 then
							DrawString(bx*212+bx*145+p_3x,by*33+by*260+by*(j-1)*size*0.9+p_3y,ssanyin[j], cl,size*0.75)					
						end
					end
					if lb > 1 then
						if i > 1 then
							lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+by*80+p_3y,1)		
						end
					else
						lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
					end
					if tb == i then
						local n = menu[tb][2]
						lib.LoadPNG(91,n*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
						lib.LoadPNG(91,223*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
					end

				elseif tb == 2  then
					local menu1 = {}	
					local h1 = 0
					local me = {}
					local hs1 = 0
					local myh1 = 3
					for j = 1,#ssyangmenu do
						local cl = C_WHITE							
						if tb1 == j  then
							cl =  C_RED
							if tb1 ==1 or tb1 == 3 then 
								lib.LoadPNG(91,226 * 2 ,-1, -1, 1)
							else
								lib.LoadPNG(91,373 * 2 ,-1, -1, 1)
							end					
							for p = 1,#ssyangmenu[j] do
								local qx = ssyangmenu[j]
								local name = qx[p][1]
								local stn = string.len(name) / 2
								local hsize = bx*40/stn
								local cl1 = C_WHITE1	
								local x,y = bx*qx[p][6]+p_3x,by*qx[p][7]+p_3y													
								if cot1 > 0 then
									rwqx = ssyangmenu[tb1][cot1][8]
								end
								local n = ssyangmenu[tb1][p][8]
								local x1,y1 = bx*230+p_3x,by*230+p_3y
								local xcolor = M_Gray
								local ycolor;
														
								local x4,y4 = x-CC.ScreenW/272- size*0.7,y-CC.ScreenH/152- size*0.7 																
								--特殊经脉
								local TSJM = CC.TSJM_SSYANG 
								for pa =1, #TSJM do 
									if TSJM[pa][3]  == n  then 
										ycolor = 319+pa+9 
										lib.LoadPNG(91,ycolor * 2 ,x4, y4, 1,0,40)																				
										if JY.Person[id]["奇穴"..n] < 1  then
											lib.LoadPNG(91,362 * 2 ,x4, y4, 1,0,40)											
										end	
									end	
								end

								--经脉点文字和图片
								if JY.Person[id]["奇穴"..n] > 0  then	
									lib.LoadPNG(91,129 * 2 ,x4+size*0.7, y4+size*0.7, 1)									
									xcolor = C_RED
									if cot1 ~= p then
										cl1 = C_ORANGE
									else 
										cl1 = C_RED
									end
									if IsOuNumber(p) then
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2-40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,231 * 2 ,x-bx*14, y-by*70, 1)	
									else
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2+40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,230 * 2 ,x-bx*14, y+by*5, 1)	
									end	
									
								else
									lib.LoadPNG(91,128 * 2 ,x4+size*0.7, y4+size*0.7, 1)
									if IsOuNumber(p) then
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2-40, cl1, size*0.7,nil,hsize)
				 						lib.LoadPNG(91,231 * 2 ,x-bx*14, y-by*70, 1)	
									else
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2+40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,230 * 2 ,x-bx*14, y+by*5, 1)	
									end	
								end	 

								--选择经脉时
								if cot1 == p and lb == 3  then 
									
									--特殊经脉奇穴判定	
									local tsjmpd = 0
									for tt =1, #TSJM do 
										if  n == TSJM[tt][3]  then 
											tsjmpd = tt 
										end
									end
									lib.LoadPNG(91,209 * 2 ,CC.ScreenW/2+size,CC.ScreenH/2-size*5, 1) --特殊经脉条件背景 

									local cot1sm = ''
                                    if cot1 == 1 then 
                                        cot1sm = '，需要最少学会一门内功'
                                    end
                                    tjm(CC.ScreenW/2+size*3.1,CC.ScreenH/2-size*3.9,'需'..qx[p][5]..'点武学经验'..cot1sm,C_WHITE,size*0.8,11,size*0.9)
									lib.LoadPNG(91,208 * 2 ,CC.ScreenW-size*9.3, CC.ScreenH/2+size, 1) --经脉名字背景
									cl1 = C_RED
									lib.LoadPNG(91,67 * 2 ,x-CC.ScreenW/136, y-CC.ScreenH/76.8, 1) --选择图标

									tjm(bx*200+bx*710+p_3x,by*33+by*212+p_3y,name,cl1,size*0.9,11,size*0.9) --经脉名字
									tjm(bx*170+bx*700+p_3x,by*33+by*245+p_3y,qx[p][2].." +"..qx[p][3],M_Wheat,size*0.8,11,size*0.8) --属性
									

									if tsjmpd > 0 then 
										local tsy = size
										local h2,hs2,myh2,STARTH2 = 0,0,10,0
										
										lib.LoadPNG(91,363 * 2 ,CC.ScreenW-size*9.5, CC.ScreenH/2+size*3.5, 1)
										tjm(bx*200+bx*705+p_3x,tsy +size*1.4 + by*30+by*212+p_3y,TSJM[tsjmpd][1] ,C_WHITE,size*0.8,11,size*0.8)
										h2 = tjm(bx*197+bx*660+p_3x, tsy+by*3 + by*33+by*280 + smsize* (hs2-STARTH2)+p_3y, TSJM[tsjmpd][2], C_WHITE1, smsize,8,smsize,STARTH2-hs2,myh2+1-hs2+STARTH2)			
										hs2 = hs2 + h2	
										local h3,hs3,myh3 = 0,0,10										
										h3 = tjm(CC.ScreenW/2+size*3.1,CC.ScreenH/2-size*9 + size*0.8* (hs3-STARTH2)+p_3y, TSJM[tsjmpd][4], C_WHITE, size*0.8,11,size*0.8,STARTH2-hs3,myh3+1-hs3+STARTH2)	--条件文字		
										hs3 = hs3 + h3
										tsjmpd = 1
									end 
									if tsjmpd == 0 then 			
										h1 = tjm(bx*220+bx*660+p_3x, by*33+by*280 + smsize* (hs1-STARTH1)+p_3y, qx[cot1][4], C_WHITE1, smsize,7,smsize,STARTH1-hs1,myh1+1-hs1+STARTH1) --经脉百科			
										hs1 = hs1 + h1
										if hs1 > myh1 then
											FY1 = limitX(hs1-myh1-1,0)
										else
											FY1 = 0
										end	
									end
									if JY.Person[id]["奇穴"..n] == 0  then
										lib.LoadPNG(91,210 * 2 ,CC.ScreenW/2+size,CC.ScreenH/2-size*5, 1) --特殊经脉条件背景 2
									end
								end	
							end								
						end
						if lb > 1 then
							DrawString(bx*212+bx*145+p_3x,by*33+by*295+by*(j-1)*size*0.9+p_3y,ssanyang[j], cl,size*0.75)						
						end
					end
					if lb > 1 then
						if i > tb then
							lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+by*80+p_3y,1)	
						else
							lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
						end
					else
						lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
					end
					if tb == i then 
						local n = menu[tb][2]
						lib.LoadPNG(91,n*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
						lib.LoadPNG(91,223*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
					end	
				elseif tb == 3  then
					local menu1 = {}	
					local h1 = 0
					local me = {}
					local hs1 = 0
					local myh1 = 3
					for j = 1,#zsymenu do
						local cl = C_WHITE						
						if tb1 == j  then
							cl =  C_RED
							lib.LoadPNG(91,227*2,-1,-1,1)					
							for p = 1,#zsymenu[j] do
								local qx = zsymenu[j]
								local name = qx[p][1]
								local stn = string.len(name) / 2
								local hsize = bx*40/stn
								local cl1 = C_WHITE1
								local x,y = bx*qx[p][6]+p_3x,by*qx[p][7]+p_3y

								if cot1 > 0 then
									rwqx = zsymenu[tb1][cot1][8]
								end
								local n = zsymenu[tb1][p][8]
								local jh = 0
								local jh1 = 0
								if j == 2  then
									jh = by*55
								elseif j == 1 or j == 3 then
									jh1 = by*55
								end
								local x1,y1 = bx*230+p_3x,by*230+p_3y
								local xcolor = M_Gray
								local ycolor;

								local x4,y4 = x-CC.ScreenW/272- size*0.7,y-CC.ScreenH/152- size*0.7 																
								--特殊经脉
								local TSJM = CC.TSJM_ZSYIN 
								for pa =1, #TSJM do 
									if TSJM[pa][3]  == n  then 
										ycolor = 319+pa+9*2 
										lib.LoadPNG(91,ycolor * 2 ,x4, y4, 1,0,40)																				
										if JY.Person[id]["奇穴"..n] < 1  then
											lib.LoadPNG(91,362 * 2 ,x4, y4, 1,0,40)											
										end	
									end	
								end

								--经脉点文字和图片
								if JY.Person[id]["奇穴"..n] > 0  then	
									lib.LoadPNG(91,129 * 2 ,x4+size*0.7, y4+size*0.7, 1)									
									xcolor = C_RED
									if cot1 ~= p then
										cl1 = C_ORANGE
									else 
										cl1 = C_RED
									end
									if IsOuNumber(p) then
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2-40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,231 * 2 ,x-bx*14, y-by*70, 1)	
									else
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2+40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,230 * 2 ,x-bx*14, y+by*5, 1)	
									end	
									
								else
									lib.LoadPNG(91,128 * 2 ,x4+size*0.7, y4+size*0.7, 1)
									if IsOuNumber(p) then
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2-40, cl1, size*0.7,nil,hsize)
				 						lib.LoadPNG(91,231 * 2 ,x-bx*14, y-by*70, 1)	
									else
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2+40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,230 * 2 ,x-bx*14, y+by*5, 1)	
									end	
								end	 

								--选择经脉时
								if cot1 == p and lb == 3  then 									
									--特殊经脉奇穴判定	
									local tsjmpd = 0
									for tt =1, #TSJM do 
										if  n == TSJM[tt][3]  then 
											tsjmpd = tt 
										end
									end
									lib.LoadPNG(91,209 * 2 ,CC.ScreenW/2+size,CC.ScreenH/2-size*5, 1) --特殊经脉条件背景 
									
									local cot1sm = ''
                                    if cot1 == 1 then 
                                        cot1sm = '，需要最少学会一门内功'
                                    end
                                    tjm(CC.ScreenW/2+size*3.1,CC.ScreenH/2-size*3.9,'需'..qx[p][5]..'点武学经验'..cot1sm,C_WHITE,size*0.8,11,size*0.9)
									lib.LoadPNG(91,208 * 2 ,CC.ScreenW-size*9.3, CC.ScreenH/2+size, 1) --经脉名字背景
									cl1 = C_RED
									lib.LoadPNG(91,67 * 2 ,x-CC.ScreenW/136, y-CC.ScreenH/76.8, 1) --选择图标

									tjm(bx*200+bx*710+p_3x,by*33+by*212+p_3y,name,cl1,size*0.9,11,size*0.9) --经脉名字
									tjm(bx*170+bx*700+p_3x,by*33+by*245+p_3y,qx[p][2].." +"..qx[p][3],M_Wheat,size*0.8,11,size*0.8) --属性
									

									if tsjmpd > 0 then 
										local tsy = size
										local h2,hs2,myh2,STARTH2 = 0,0,10,0
										
										lib.LoadPNG(91,363 * 2 ,CC.ScreenW-size*9.5, CC.ScreenH/2+size*3.5, 1)
										tjm(bx*200+bx*705+p_3x,tsy +size*1.4 + by*30+by*212+p_3y,TSJM[tsjmpd][1] ,C_WHITE,size*0.8,11,size*0.8)
										h2 = tjm(bx*197+bx*660+p_3x, tsy+by*3 + by*33+by*280 + smsize* (hs2-STARTH2)+p_3y, TSJM[tsjmpd][2], C_WHITE1, smsize,8,smsize,STARTH2-hs2,myh2+1-hs2+STARTH2)			
										hs2 = hs2 + h2	
										local h3,hs3,myh3 = 0,0,10										
										h3 = tjm(CC.ScreenW/2+size*3.1,CC.ScreenH/2-size*9 + size*0.8* (hs3-STARTH2)+p_3y, TSJM[tsjmpd][4], C_WHITE, size*0.8,11,size*0.8,STARTH2-hs3,myh3+1-hs3+STARTH2)	--条件文字		
										hs3 = hs3 + h3
										tsjmpd = 1
									end 
									if tsjmpd == 0 then 			
										h1 = tjm(bx*220+bx*660+p_3x, by*33+by*280 + smsize* (hs1-STARTH1)+p_3y, qx[cot1][4], C_WHITE1, smsize,7,smsize,STARTH1-hs1,myh1+1-hs1+STARTH1) --经脉百科			
										hs1 = hs1 + h1
										if hs1 > myh1 then
											FY1 = limitX(hs1-myh1-1,0)
										else
											FY1 = 0
										end	
									end
									if JY.Person[id]["奇穴"..n] == 0  then
										lib.LoadPNG(91,210 * 2 ,CC.ScreenW/2+size,CC.ScreenH/2-size*5, 1) --特殊经脉条件背景 2
									end
								end	
							end								
						end
						if lb > 1 then
							DrawString(bx*212+bx*145+p_3x,by*33+by*340+by*(j-1)*size*0.9+p_3y,zsanyin[j], cl,size*0.75)						
						end

					end
					if lb > 1 then
						if i > tb then
							lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+by*80+p_3y,1)	
						else
							lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
						end	
					else
						lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
					end			
					if tb == i then 
						local n = menu[tb][2]
						lib.LoadPNG(91,n*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
						lib.LoadPNG(91,223*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
					end	
				elseif tb == 4  then
					local menu1 = {}	
					local h1 = 0
					local me = {}
					local hs1 = 0
					local myh1 = 3
					for j = 1,#zsyangmenu do
						local cl = C_WHITE							
						if tb1 == j  then
							cl =  C_RED
							lib.LoadPNG(91,228 * 2 ,-1, -1, 1)					
							for p = 1,#zsyangmenu[j] do
								local qx = zsyangmenu[j]
								local name = qx[p][1]
								local stn = string.len(name) / 2
								local hsize = bx*40/stn
								local cl1 = C_WHITE1
								local x,y = bx*qx[p][6]+p_3x,by*qx[p][7]+p_3y

								if cot1 > 0 then
									rwqx = zsyangmenu[tb1][cot1][8]
								end
								local n = zsyangmenu[tb1][p][8]
								local jh = 0
								local jh1 = 0
								if j == 2  then
									jh = by*55
								elseif j == 1 or j == 3 then
									jh1 = by*55
								end
								local x1,y1 = bx*230+p_3x,by*230+p_3y

								local xcolor = M_Gray
								local ycolor;

								local x4,y4 = x-CC.ScreenW/272- size*0.7,y-CC.ScreenH/152- size*0.7 																
								--特殊经脉
								local TSJM = CC.TSJM_ZSYANG 
								for pa =1, #TSJM do 
									if TSJM[pa][3]  == n  then 
										ycolor = 319+pa+9*3 
										lib.LoadPNG(91,ycolor * 2 ,x4, y4, 1,0,40)																				
										if JY.Person[id]["奇穴"..n] < 1  then
											lib.LoadPNG(91,362 * 2 ,x4, y4, 1,0,40)											
										end	
									end	
								end

								--经脉点文字和图片
								if JY.Person[id]["奇穴"..n] > 0  then	
									lib.LoadPNG(91,129 * 2 ,x4+size*0.7, y4+size*0.7, 1)									
									xcolor = C_RED
									if cot1 ~= p then
										cl1 = C_ORANGE
									else 
										cl1 = C_RED
									end
									if IsOuNumber(p) then
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2-40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,231 * 2 ,x-bx*14, y-by*70, 1)	
									else
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2+40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,230 * 2 ,x-bx*14, y+by*5, 1)	
									end	
									
								else
									lib.LoadPNG(91,128 * 2 ,x4+size*0.7, y4+size*0.7, 1)
									if IsOuNumber(p) then
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2-40, cl1, size*0.7,nil,hsize)
				 						lib.LoadPNG(91,231 * 2 ,x-bx*14, y-by*70, 1)	
									else
										draw3(name,x+2,y- ((stn-1)*hsize+size*0.7)/2+40, cl1, size*0.7,nil,hsize)
										lib.LoadPNG(91,230 * 2 ,x-bx*14, y+by*5, 1)	
									end	
								end	 

								--选择经脉时
								if cot1 == p and lb == 3  then 
									
									--特殊经脉奇穴判定	
									local tsjmpd = 0
									for tt =1, #TSJM do 
										if  n == TSJM[tt][3]  then 
											tsjmpd = tt 
										end
									end
									lib.LoadPNG(91,209 * 2 ,CC.ScreenW/2+size,CC.ScreenH/2-size*5, 1) --特殊经脉条件背景 
									
									local cot1sm = ''
                                    if cot1 == 1 then 
                                        cot1sm = '，需要最少学会一门内功'
                                    end
                                    tjm(CC.ScreenW/2+size*3.1,CC.ScreenH/2-size*3.9,'需'..qx[p][5]..'点武学经验'..cot1sm,C_WHITE,size*0.8,11,size*0.9)
									lib.LoadPNG(91,208 * 2 ,CC.ScreenW-size*9.3, CC.ScreenH/2+size, 1) --经脉名字背景
									cl1 = C_RED
									lib.LoadPNG(91,67 * 2 ,x-CC.ScreenW/136, y-CC.ScreenH/76.8, 1) --选择图标

									tjm(bx*200+bx*710+p_3x,by*33+by*212+p_3y,name,cl1,size*0.9,11,size*0.9) --经脉名字
									tjm(bx*170+bx*700+p_3x,by*33+by*245+p_3y,qx[p][2].." +"..qx[p][3],M_Wheat,size*0.8,11,size*0.8) --属性
									

									if tsjmpd > 0 then 
										local tsy = size
										local h2,hs2,myh2,STARTH2 = 0,0,10,0
										
										lib.LoadPNG(91,363 * 2 ,CC.ScreenW-size*9.5, CC.ScreenH/2+size*3.5, 1)
										tjm(bx*200+bx*705+p_3x,tsy +size*1.4 + by*30+by*212+p_3y,TSJM[tsjmpd][1] ,C_WHITE,size*0.8,11,size*0.8)
										h2 = tjm(bx*197+bx*660+p_3x, tsy+by*3 + by*33+by*280 + smsize* (hs2-STARTH2)+p_3y, TSJM[tsjmpd][2], C_WHITE1, smsize,8,smsize,STARTH2-hs2,myh2+1-hs2+STARTH2)			
										hs2 = hs2 + h2	
										local h3,hs3,myh3 = 0,0,10										
										h3 = tjm(CC.ScreenW/2+size*3.1,CC.ScreenH/2-size*9 + size*0.8* (hs3-STARTH2)+p_3y, TSJM[tsjmpd][4], C_WHITE, size*0.8,11,size*0.8,STARTH2-hs3,myh3+1-hs3+STARTH2)	--条件文字		
										hs3 = hs3 + h3
										tsjmpd = 1
									end 
									if tsjmpd == 0 then 			
										h1 = tjm(bx*220+bx*660+p_3x, by*33+by*280 + smsize* (hs1-STARTH1)+p_3y, qx[cot1][4], C_WHITE1, smsize,7,smsize,STARTH1-hs1,myh1+1-hs1+STARTH1) --经脉百科			
										hs1 = hs1 + h1
										if hs1 > myh1 then
											FY1 = limitX(hs1-myh1-1,0)
										else
											FY1 = 0
										end	
									end
									if JY.Person[id]["奇穴"..n] == 0  then
										lib.LoadPNG(91,210 * 2 ,CC.ScreenW/2+size,CC.ScreenH/2-size*5, 1) --特殊经脉条件背景 2
									end
								end	
							end								
						end					
						if lb > 1 then
							DrawString(bx*212+bx*145+p_3x,by*33+by*380+by*(j-1)*size*0.9+p_3y,zsanyang[j], cl,size*0.75)							
						end
					end
					if lb > 1 then
						if i > tb then
							lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+by*80+p_3y,1)	
						else
							lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
						end	
					else
						lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
					end			
					if tb == i then 
						local n = menu[tb][2]
						lib.LoadPNG(91,n*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
						lib.LoadPNG(91,223*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
					end	
				elseif tb == 5  then
					local menu1 = {}	
					local h1 = 0
					local me = {}
					local hs1 = 0
					local myh1 = 3
					for j = 1,#renmaimenu do
						local cl = C_WHITE							
						if tb1 == j  then
							cl =  C_RED
							lib.LoadPNG(91,229 * 2 , -1, -1, 1)					
							for p = 1,#renmaimenu[j] do
								local qx = renmaimenu[j]
								local name = qx[p][1]
								local stn = string.len(name) / 2
								local hsize = bx*40/stn
								local cl1 = C_WHITE1
								local x,y = bx*qx[p][6]+p_3x,by*qx[p][7]+p_3y

								if cot1 > 0 then
									rwqx = renmaimenu[tb1][cot1][8]
								end
								local n = renmaimenu[tb1][p][8]
								local jh = 0
								local jh1 = 0
								if j == 2  then
									jh = by*55
								elseif j == 1 or j == 3 then
									jh1 = by*55
								end
								local x1,y1 = bx*230+p_3x,by*230+p_3y
								local x,y = bx*qx[p][6]+p_3x,by*qx[p][7]+p_3y
								local n1 = #renmaimenu[j]
								local xcolor = M_Gray
								local ycolor;


								local jx,jx1 = bx*10,bx*75
		
								if JY.Person[id]["奇穴"..n] > 0  then
									ycolor = 129
									if cot1 ~= p then
										cl1 = C_ORANGE
									end
									if IsOuNumber(p) then
										--draw3(name,x,y- ((stn-1)*hsize+size*0.7)/2+jh, cl1, size*0.7,nil,hsize)
										DrawString(x-string.len(name)/4*size2+size+jx,y-size*0.5,name,cl1,size*0.7)
										lib.LoadPNG(91,271 * 2 ,x+jx*0.5, y-size*0.6, 1)
									else
										--draw3(name,x,y- ((stn-1)*hsize+size*0.7)/2+jh1, cl1, size*0.7,nil,hsize)
										DrawString(x-string.len(name)/4*size2-size-jx,y-size*0.5,name,cl1,size*0.7)
										lib.LoadPNG(91,272 * 2 ,x-jx1*0.95, y-size*0.6, 1)
									end	
								else
									ycolor = 128
									if IsOuNumber(p) then
										--draw3(name,x,y- ((stn-1)*hsize+size*0.7)/2+jh, cl1, size*0.7,nil,hsize)
										DrawString(x-string.len(name)/4*size2+size+jx,y-size*0.5,name,cl1,size*0.7)
										lib.LoadPNG(91,271 * 2 ,x+jx*0.5, y-size*0.6, 1)
									else
										--draw3(name,x,y- ((stn-1)*hsize+size*0.7)/2+jh1, cl1, size*0.7,nil,hsize)
										DrawString(x-string.len(name)/4*size2-size-jx,y-size*0.5,name,cl1,size*0.7)
										lib.LoadPNG(91,272 * 2 ,x-jx1*0.95, y-size*0.6, 1)
									end	
								end
								lib.LoadPNG(91,ycolor * 2 ,x-CC.ScreenW/272, y-CC.ScreenH/152, 1)	

								local x4,y4 = x-CC.ScreenW/272- size*0.7,y-CC.ScreenH/152- size*0.7 																
								--特殊经脉
								local TSJM = CC.TSJM_RENDU 
								for pa =1, #TSJM do 
									if TSJM[pa][3]  == n  then 
										ycolor = 319+pa+9*4 
										lib.LoadPNG(91,ycolor * 2 ,x4, y4, 1,0,40)																				
										if JY.Person[id]["奇穴"..n] < 1  then
											lib.LoadPNG(91,362 * 2 ,x4, y4, 1,0,40)											
										end	
									end	
								end

								--经脉点文字和图片

								--选择经脉时
								if cot1 == p and lb == 3  then 
									
									--特殊经脉奇穴判定	
									local tsjmpd = 0
									for tt =1, #TSJM do 
										if  n == TSJM[tt][3]  then 
											tsjmpd = tt 
										end
									end
									lib.LoadPNG(91,209 * 2 ,CC.ScreenW/2+size,CC.ScreenH/2-size*5, 1) --特殊经脉条件背景 
									
									local cot1sm = ''
                                    if cot1 == 1 then 
                                        cot1sm = '，需要最少学会一门内功'
                                    end
                                    tjm(CC.ScreenW/2+size*3.1,CC.ScreenH/2-size*3.9,'需'..qx[p][5]..'点武学经验'..cot1sm,C_WHITE,size*0.8,11,size*0.9)
									lib.LoadPNG(91,208 * 2 ,CC.ScreenW-size*9.3, CC.ScreenH/2+size, 1) --经脉名字背景
									cl1 = C_RED
									lib.LoadPNG(91,67 * 2 ,x-CC.ScreenW/136, y-CC.ScreenH/76.8, 1) --选择图标

									tjm(bx*200+bx*710+p_3x,by*33+by*212+p_3y,name,cl1,size*0.9,11,size*0.9) --经脉名字
									tjm(bx*170+bx*700+p_3x,by*33+by*245+p_3y,qx[p][2].." +"..qx[p][3],M_Wheat,size*0.8,11,size*0.8) --属性
									

									if tsjmpd > 0 then 
										local tsy = size
										local h2,hs2,myh2,STARTH2 = 0,0,10,0
										
										lib.LoadPNG(91,363 * 2 ,CC.ScreenW-size*9.5, CC.ScreenH/2+size*3.5, 1)
										tjm(bx*200+bx*705+p_3x,tsy +size*1.4 + by*30+by*212+p_3y,TSJM[tsjmpd][1] ,C_WHITE,size*0.8,11,size*0.8)
										h2 = tjm(bx*197+bx*660+p_3x, tsy+by*3 + by*33+by*280 + smsize* (hs2-STARTH2)+p_3y, TSJM[tsjmpd][2], C_WHITE1, smsize,8,smsize,STARTH2-hs2,myh2+1-hs2+STARTH2)			
										hs2 = hs2 + h2	
										local h3,hs3,myh3 = 0,0,10										
										h3 = tjm(CC.ScreenW/2+size*3.1,CC.ScreenH/2-size*9 + size*0.8* (hs3-STARTH2)+p_3y, TSJM[tsjmpd][4], C_WHITE, size*0.8,11,size*0.8,STARTH2-hs3,myh3+1-hs3+STARTH2)	--条件文字		
										hs3 = hs3 + h3
										tsjmpd = 1
									end 
									if tsjmpd == 0 then 			
										h1 = tjm(bx*220+bx*660+p_3x, by*33+by*280 + smsize* (hs1-STARTH1)+p_3y, qx[cot1][4], C_WHITE1, smsize,7,smsize,STARTH1-hs1,myh1+1-hs1+STARTH1) --经脉百科			
										hs1 = hs1 + h1
										if hs1 > myh1 then
											FY1 = limitX(hs1-myh1-1,0)
										else
											FY1 = 0
										end	
									end
									if JY.Person[id]["奇穴"..n] == 0  then
										lib.LoadPNG(91,210 * 2 ,CC.ScreenW/2+size,CC.ScreenH/2-size*5, 1) --特殊经脉条件背景 2
									end
								end				
							end										
						end
						if lb > 1 then
							DrawString(bx*212+bx*145+p_3x,by*33+by*420+by*(j-1)*size*0.9+p_3y,renmai[j], cl,size*0.75)							
						end
					end
					lib.LoadPNG(91,(212+i-1)*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
					if tb == i then 
						local n = menu[tb][2]
						lib.LoadPNG(91,n*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
						lib.LoadPNG(91,223*2,bx*212+bx*120+p_3x,by*33+by*220+by*(i-1)*hg+p_3y,1)
					end												
				end	
				local qxsmwz = {"前置经脉未激活","武学点数不够","未达到激活条件"}
				for j = 1,#qxsmwz do 
					local wz11 = qxsmwz[j]
					if qxsm == j then
						lib.LoadPNG(91, 90 * 2 , bx*382*2, by*550, 1,0,220 )
						DrawString(bx*382*2, by*559,wz11,C_RED,size*1.4)
						--DrawStrBoxWaitKey1(wz11, C_RED, CC.DefaultFont)
					end
				end
				if jmtx == 1 then 
					local jhwz = '激活经脉'..'成功'
					lib.LoadPNG(91, 90 * 2 , bx*382*2, by*550, 1,0,220 )
					DrawString(bx*382*2, by*559,jhwz,C_RED,size*1.4)
					--DrawStrBoxWaitKey1(jhwz, C_RED, CC.DefaultFont)					
				end
			end							

			if tb1 > 0 and tb > 0 then 
				local qx = jmmenu[tb][tb1]
				for ii = 1,#qx -1 do
					tjm12(bx*qx[ii][6]+p_3x,by*qx[ii][7]+p_3y,bx*qx[ii+1][6]+p_3x,by*qx[ii+1][7]+p_3y,C_WHITE)
				end	
			end
			if QXSHUOMING == 1 then
				lib.PicLoadCache(92,122*2,bx*212+bx*300+p_3x,by*33+by*226+p_3y,1)					
				local hs = 0
				local FY = 0
				local ZUIDHS = 15
				local h = 0
				local CAOZSM = {}  
				for z = 1,#CC.WGCZSM do
					CAOZSM[#CAOZSM+1] = CC.WGCZSM[z]
				end	
				h = tjm(bx*212+bx*454+p_3x, by*33+by*227+p_3y,CAOZSM[1], C_CYGOLD, size1*0.9,15,size1*0.9,FY-hs,ZUIDHS+1-hs+FY)	
				hs = hs + h							
				h = tjm(bx*212+bx*328+p_3x, by*33+by*260+p_3y,CAOZSM[2], C_WHITE, size1*0.7,15,size1*0.7,FY-hs,ZUIDHS+1-hs+FY)
				hs = hs + h
			end	
		end
		local zdmenu2 = {JY.Person[id]['行动方针'],JY.Person[id]['施毒方针'],JY.Person[id]['暗器方针']}	
		local zdmenu3 = {JY.Person[id]['吃红药方针'],JY.Person[id]['吃蓝药方针'],JY.Person[id]['吃黄药方针']}
		local zdmenu4 = {JY.Person[id]['复活方针'],JY.Person[id]['喝酒方针'],JY.Person[id]['备用方针1']}
		local zdxz = 1	
		if page == 5 then 
			--招式方式			
			for i = 1,#zdwz1 do 
				color = C_WHITE1
				if JY.Person[id]['招式方针'] == i then 
					lib.LoadPNG(91,36*2,bx*715+(i-1)*bx*34,by*385,1,0,bx*15) 
				end			
				if zdpage == 1 then 		
					if tb1 == i then 
						color = C_RED 
					end
				end
				DrawString(bx*717+(i-1)*bx*34,by*385,zdwz1[i],color,size2*1.2)
			end

			--攻击方针		
			for i = 1,3 do 			
				color = C_WHITE1
				zdxz = zdmenu2[i] + 1
				if zdpage == 2  then 	
					if lb1 == 2 then 
						if tb1 == i  then 
							color = C_RED
						end
					end	
				end 
				DrawString(bx*790-string.len(zdwz2[i][zdxz]) / 4 * size2*1.2 + (i-1)*165 ,by*461,zdwz2[i][zdxz],color,size2*1.2)
			end	
			--吃药方针				
			for i = 1,3 do 			
				color = C_WHITE1
				zdxz = zdmenu3[i] + 1
				if zdpage == 3  then 	
					if lb1 == 2 then 
						if tb1 == i  then 
							color = C_RED
						end
					end	
				end 
				DrawString(bx*790-string.len(zdwz3[i][zdxz]) / 4 * size2*1.2 + (i-1)*165 ,by*538,zdwz3[i][zdxz],color,size2*1.2)
			end	

			--其它方针				
			for i = 1,3 do 		
				color = C_WHITE1
				zdxz = zdmenu4[i] + 1
				if zdpage == 4  then 	
					if lb1 == 2 then 
						if tb1 == i  then 
							color = C_RED
						end
					end	
				end 
				DrawString(bx*790-string.len(zdwz4[i][zdxz]) / 4 * size2*1.2 + (i-1)*165 ,by*615,zdwz4[i][zdxz],color,size2*1.2)
			end	

			--第三层菜单
			if lb1 == 3 then 
				
				if zdpage == 2 then 
					lib.Background( bx*705 + (tb1-1)*165,by*490,bx*700 +bx*160+ (tb1-1)*165,by*461+(#zdwz2[tb1]+2)*size2*1.2,50)
					for j = 1,#zdwz2[tb1] do 
						color = C_WHITE1
						if tb2 == j  then 
							color = C_RED
						end					
						DrawString(bx*790-string.len(zdwz2[tb1][j]) / 4 * size2*1.2 + (tb1-1)*165,by*465+(j)*size2*1.2,zdwz2[tb1][j],color,size2*1.2)						
					end
				end
				if zdpage == 3 then 
					lib.Background( bx*705 + (tb1-1)*165,by*490+zh,bx*700 +bx*160+ (tb1-1)*165,by*461+(#zdwz3[tb1]+2)*size2*1.2+zh,50)
					for j = 1,#zdwz3[tb1] do 
						color = C_WHITE1
						if tb2 == j  then 
							color = C_RED
						end					
						DrawString(bx*790-string.len(zdwz3[tb1][j]) / 4 * size2*1.2 + (tb1-1)*165,by*465+(j)*size2*1.2+zh,zdwz3[tb1][j],color,size2*1.2)						
					end
				end
				if zdpage == 4 then 
					lib.Background( bx*705 + (tb1-1)*165,by*490+zh*2,bx*700 +bx*160+ (tb1-1)*165,by*461+(#zdwz4[tb1]+2)*size2*1.2+zh*2,50)
					for j = 1,#zdwz4[tb1] do 
						color = C_WHITE1
						if tb2 == j  then 
							color = C_RED
						end					
						DrawString(bx*790-string.len(zdwz4[tb1][j]) / 4 * size2*1.2 + (tb1-1)*165,by*465+(j)*size2*1.2+zh*2,zdwz4[tb1][j],color,size2*1.2)						
					end
				end
			end
		end
		ShowScreen()
		lib.Delay(CC.Frame)
		local X, ktype, mx, my = lib.GetKey();	
		if mx ~= -1 and my ~= -1 then 
			px,py = mx,my
		end
		if X == VK_ESCAPE or ktype == 4  then 	
			if page == 1 then
				lb1 = lb1 - 1 
				if lb1 < 1 then 
					lb1 = 1 
					break
				end 
				if TFSHUOMING == 1 then
					TFSHUOMING = 0
					tfid = 0
				end
			elseif page == 2 then 
				lb1 = lb1 - 1 
				if lb1 < 1 then 
					lb1 = 1 
					break
				end 
				if xlsm > 0 then 
					xlsm = 0
				end
				if lb1 == 2 then 
					WGSTARTH = 0 
				end
				if WGSHUOMING > 0 then
					WGSHUOMING = 0
				end
			elseif page == 3 then 
				lb1 = lb1 - 1
				if lb1 < 1 then 
					lb1 = 1 
					break
				end  
				if lb1 == 2 then 
					Mstarth = 0 
				end
				if MJSHUOMING > 0 then
					MJSHUOMING = 0				
				end	
			elseif page == 4 then 
				lb = lb - 1
				if lb < -1 then 
					lb = -1  
					break
				end
				if lb == 2 then
					tb1 = 1 
					cot1 = 1
				end
				if lb <= 1 then 
					tb1 = 1
					--tb = 1
				end
				if qxsm > 0 or jmtx > 0 then 
					qxsm = 0	
					jmtx = 0
				end	
			elseif page == 5 then 
				lb1 = lb1 - 1
				if lb1 < 1 then 
					lb1 = 1
					break
				end
			else
                break
			end			
			--lib.Debug('ESC当前所处lb='..lb..' 当前所处page='..page..' 当前所处lb1='..lb1)
		elseif X == VK_SPACE or X == VK_RETURN then	
			if page == 1 then 
				lb1 = lb1 + 1
				if lb1 > 2 then 				
					lb1 = 2
				end
				if lb1 == 2  then 
					tfid = 1
					TFSHUOMING = 1
				end
			elseif page == 2 then 
				lb1 = lb1 + 1 
				if lb1 > 3 then 				
					lb1 = 3
				end
				if lb1 == 3 then 
					WGSHUOMING = 1
				end 
				if WGSHUOMING == 1 then
					if inteam(id) == true then 
						if tb5 == 1 then	
							PlayWavE(77)
							if JY.Wugong[wgmenu[kid][1]]["武功类型"] < 6  then  --优先使用不等于当前选择								
								if  p["优先使用"] ~= wgmenu[kid][1] then
									----lib.Debug('外功有用')
									p["优先使用"] = wgmenu[kid][1]
								else
									p["优先使用"] = 0
								end
								Hp_Max(id)
								Mp_Max(id)
							elseif JY.Wugong[wgmenu[kid][1]]["武功类型"] == 6   then
								if  p["主运内功"] ~= wgmenu[kid][1] then
									--lib.Debug('内功有用')
									p["主运内功"] = wgmenu[kid][1]
									Hp_Max(id)
									Mp_Max(id)
								else
									p["主运内功"] = 0
									Hp_Max(id)
									Mp_Max(id)
								end
							elseif JY.Wugong[wgmenu[kid][1]]["武功类型"] == 7   then
								if  p["主运轻功"] ~= wgmenu[kid][1] then
									----lib.Debug('轻功有用')
									p["主运轻功"] = wgmenu[kid][1]
								else
									p["主运轻功"] = 0
								end
								Hp_Max(id)
								Mp_Max(id)
							end
						elseif tb5 == 2 then 	
							PlayWavE(77)
							local R = 0
							if wgmenu[kid][3] < 10 then
								if KF_thing(wgmenu[kid][1]) == nil then
									R = JY.Wugong[wgmenu[kid][1]]['层级']*80
								else
									R = math.modf((5-math.modf(25/25))*JY.Thing[KF_thing(wgmenu[kid][1])]["需经验"]*(wgmenu[kid][3]+1)*0.05);
								end
							end
							if wgmenu[kid][3] < 10   then
								if  p["物品修炼点数"] >= R then
									wgmenu[kid][3] = wgmenu[kid][3] + 1								
									JY.Person[id]["武功等级"..wgmenu[kid][5]] = JY.Person[id]["武功等级"..wgmenu[kid][5]] + 100
									KF_addsx(id,wgmenu[kid][1])
									p["物品修炼点数"] = p["物品修炼点数"] - R
									Hp_Max(id)
									Mp_Max(id)
								else
									xlsm = 1
								end
							else
								xlsm = 2
							end		
						end	
					end	
				end	
				if xlsm > 0 then 
					xlsm = 0
				end
			elseif page == 3 then 
				lb1 = lb1 + 1 
				if lb1 > 3 then 				
					lb1 = 3
				end
				if lb1 == 3 then 
					MJSHUOMING = 1
				end
			elseif page == 4 then 
				lb = lb + 1
				if lb > 3 then 
					lb  = 3 
				end 
				if lb == 3 then 
					if qxsm > 0 or jmtx > 0 then 
						qxsm = 0
						jmtx = 0						
					else	
						local pd = false	
						local jmjd =jmmenu[tb][tb1][cot1]
						local xhds = jmjd[5] 	
						if inteam(id) == true then 				
							if cot1 == 1  then							
								local ngn = {} 
								local ng0,ng1,ng2,ngdj = 0,0,0,0
								for w = 1,JY.Base["武功数量"] do 
									local wugong = JY.Person[id]["武功"..w]
									if wugong > 0 then
										if JY.Wugong[wugong]["武功类型"] == 6 then 
											ngn[#ngn+1] = wugong
										end
									end
								end
								--确定有学会合适的内功
								for j = 1,#ngn do 
									ngdj = JY.Wugong[ngn[j]]["层级"]
								end
								if  JY.Person[id]["奇穴"..rwqx] < 1 then
									if  ngdj >= 1   then 
										pd = true
									end
									if pd == true then 
										if JY.Person[id]["武学点数"] - jmjd[5] >= 0 then 
											JY.Person[id]["奇穴"..rwqx] = 1  --激活经脉
											jmtx = 1
											--JY.Person[id][jmjd[2]] = JY.Person[id][jmjd[2]] + jmjd[3]  --增加人物属性
											AddPersonAttrib(id,jmjd[2],jmjd[3])
											JY.Person[id]["武学点数"] = JY.Person[id]["武学点数"] - jmjd[5]
											--奇穴激活特效
										else
											qxsm = 2
										end
									else
										qxsm = 3	
									end
								end
							elseif cot1 > 1  then
								if JY.Person[id]["奇穴"..rwqx-1] > 0 then
									if  JY.Person[id]["奇穴"..rwqx] < 1 then 
										if JY.Person[id]["武学点数"] - xhds >= 0 then
											--特殊经脉
											local tsjme = {CC.TSJM_SSYIN,CC.TSJM_SSYANG,CC.TSJM_ZSYIN,CC.TSJM_ZSYANG,CC.TSJM_RENDU}
											local tsmenu = tsjme[tb]
											local tsqx = 0
											
											for t = 1,#tsmenu do 
												if tsmenu[t][3] == rwqx then 
													tsqx = 1
													--lib.Debug('判定成功 '..tsqx..'  经脉穴位== '..rwqx)
													break
												end
											end
											----lib.Debug('判定成功 '..tsqx..'  经脉穴位== '..rwqx)
											if  tsqx == 0  then 
												JY.Person[id]["奇穴"..rwqx] = 1  --激活经脉
												jmtx = 1
												--JY.Person[id][jmjd[2]] = JY.Person[id][jmjd[2]] + jmjd[3]  --增加人物属性
												AddPersonAttrib(id,jmjd[2],jmjd[3])
												JY.Person[id]["武学点数"] = JY.Person[id]["武学点数"] - xhds

											else
												if JMQX_JH(id,rwqx)  then 
													----lib.Debug('经脉奇穴判定成功')
													JY.Person[id]["奇穴"..rwqx] = 1  --激活经脉
													jmtx = 1 
													--JY.Person[id][jmjd[2]] = JY.Person[id][jmjd[2]] + jmjd[3]  --增加人物属性
													AddPersonAttrib(id,jmjd[2],jmjd[3])
													JY.Person[id]["武学点数"] = JY.Person[id]["武学点数"] - xhds
													if rwqx == 22 then 
														AddPersonAttrib(id, "攻击带毒", 20)
														AddPersonAttrib(id, "用毒能力", 20)														
													end
													if rwqx == 25 then 
														AddPersonAttrib(id, "用毒能力", 30)		
														if Pmiji(id,6) and Pmiji(id,8) then 
															AddPersonAttrib(id,'用毒能力',80)
														end												
													end													
													if rwqx == 28 then 
														AddPersonAttrib(id, "用毒能力", 100)														
													end
													if rwqx == 61 then 
														local jsx = JY.Person[id]['防御力']*0.1
														AddPersonAttrib(id, "防御力", jsx)														
													end
													if rwqx == 83 then 
														local jsx = JY.Person[id]['攻击力']*0.1
														AddPersonAttrib(id, "攻击力", jsx)														
													end		
													if rwqx == 95 then 
														local jsx = JY.Person[id]['基础生命']*0.1
														AddPersonAttrib(id, "基础生命", jsx)														
													end	
													if rwqx == 99 then 
														local jsx = JY.Person[id]['生命最大值']*0.1
														AddPersonAttrib(id, "生命最大值", jsx)														
													end	
													if rwqx == 106 then 
														local jsx = JY.Person[id]['轻功']*0.1
														AddPersonAttrib(id, "轻功", jsx)														
													end	
													if rwqx == 117 then 
														local jsx = 5
														AddPersonAttrib(id, "体质", jsx)														
													end		
													if rwqx == 129 then 
														local jsx = 1000
														AddPersonAttrib(id, "内力最大值", jsx)														
													end		
													if rwqx == 139 or rwqx == 149 then 
														local jsx = JY.Person[id]['防御力']*0.05
														AddPersonAttrib(id, "防御力", jsx)														
													end		
													if rwqx == 139 or rwqx == 149 then 
														local jsx = JY.Person[id]['攻击力']*0.05
														AddPersonAttrib(id, "攻击力", jsx)														
													end																																																																																
												else
													qxsm = 3
												end						
											end	
											--贯通经脉属性加成
											for i = 1,#CC.qxnum do 	
												if CC.qxnum[i] == rwqx then 
													if i == 1 or i == 4 or i == 7 or i == 10 then 										
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['攻击力'] =  JY.Person[id]['攻击力'] + 50
															AddPersonAttrib(id,'攻击力',50)
														end
													elseif i == 2 or i == 5 or i == 8 or i == 11 then 
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['防御力'] =  JY.Person[id]['防御力'] + 50
															AddPersonAttrib(id,'防御力',50)
														end
													elseif i == 3 or i == 6 or  i == 9  or i == 12 then 
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['轻功'] =  JY.Person[id]['轻功'] + 50
															AddPersonAttrib(id,'轻功',50)
														end
													elseif i == 13 or i == 14  then 
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['轻功'] =  JY.Person[id]['轻功'] + 50
															AddPersonAttrib(id,'轻功',50)
														end
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['攻击力'] =  JY.Person[id]['攻击力'] + 50
															AddPersonAttrib(id,'攻击力',50)
														end
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['防御力'] =  JY.Person[id]['防御力'] + 50
															AddPersonAttrib(id,'防御力',50)
														end										
													end												
												end
											end																							
										else
											qxsm = 2
										end			
									end
								else
									qxsm = 1
								end
							end
						end		
					end	
				end
			elseif page == 5  then 
				if inteam(id) then 
					lb1 = lb1 + 1
					if lb1 > 3 then 				
						lb1 = 3
					end			
					if zdpage == 1 then 
						if lb1 == 3 then 
							if JY.Person[id]['招式方针'] == tb1 then 
								JY.Person[id]['招式方针'] = 0
							else
								JY.Person[id]['招式方针'] = tb1
							end
						end
					elseif zdpage == 2 then 
						if lb1 == 3 then 
							if tb1 == 1 then 
								JY.Person[id]['行动方针'] = tb2 - 1
							elseif tb1 == 2 then 
								JY.Person[id]['施毒方针'] = tb2 - 1
							elseif tb1 == 3 then 
								JY.Person[id]['暗器方针'] = tb2 - 1
							end
						end
					elseif zdpage == 3 then 
						if lb1 == 3 then 
							if tb1 == 1 then 
								JY.Person[id]['吃红药方针'] = tb2 - 1
							elseif tb1 == 2 then 
								JY.Person[id]['吃蓝药方针'] = tb2 - 1
							elseif tb1 == 3 then 
								JY.Person[id]['吃黄药方针'] = tb2 - 1
							end
						end
					elseif zdpage == 4 then 
						if lb1 == 3 then 
							if tb1 == 1 then 
								JY.Person[id]['复活方针'] = tb2 - 1
							elseif tb1 == 2 then 
								JY.Person[id]['喝酒方针'] = tb2 - 1
							elseif tb1 == 3 then 
								JY.Person[id]['备用方针1'] = tb2 - 1
							end
						end					
					end
				end
			end					
			--lib.Debug('tb='..tb..' tb1='..tb1..' cot1='..cot1)
			--lib.Debug('SPACE当前所处lb='..lb..' 当前所处page='..page..' 当前所处lb1='..lb1)
		elseif X == VK_DOWN then
			local pdpage = 0
			if page == 1 then 
				if lb1 == 1 then 
					pdpage = 1 
					----lib.Debug('lb1页面判定'..pdpage)
				end
				if pdpage == 1 then 
					page = page + 1
					lb1 = 1
					lb = 0
					if page > #zmenu then 
						page = 1
					end	
				end
			elseif page == 2 then 
				if lb1 == 1 then 
					pdpage = 1 
					----lib.Debug('lb1页面判定'..pdpage)
				end
				if xlsm > 0 then 
					xlsm = 0
				end
				if pdpage == 1 then 
					page = page + 1
					lb1 = 1
					lb = 0
					if page > #zmenu then 
						page = 1
					end	
					for p = 1,#kfmenu do 
						if kfmenu[p] ~= nil then 
							kfmenu[p] = nil 
						end
					end
				end
				if lb1 == 3 then 
					if WGSHUOMING > 0 then
						WGSTARTH  = WGSTARTH + 1
						if WGSTARTH > FY then
							WGSTARTH = FY 
						end
					end
				end	
				if lb1 == 2 then 
					if kid + rnum >= 0 and kid +rnum <= #kfmenu then 
						kid = kid + rnum
					end

				end
			elseif page == 3 then 
				if lb1 == 1 then 
					pdpage = 1 
					----lib.Debug('lb1页面判定'..pdpage)
				end
				if pdpage == 1 then 
					page = page + 1
					lb1 = 1
					lb = 0
					if page > #zmenu then 
						page = 1
					end	
					for p1 = 1,#MJMenu do 
						if MJMenu[p1] ~= nil then 
							MJMenu[p1] = nil 
						end
					end
				end
				if lb1 == 3 then 
					if MJSHUOMING > 0 then 
						if MJSHUOMING > 0 then
							Mstarth  = Mstarth + 1
							if Mstarth > Mfy then
								Mstarth = Mfy 
							end
						end
					end
				end
				if lb1 == 2 then 
					if mid + rnum >= 0 and mid + rnum <= #MJMenu then 
						mid = mid + rnum 	
					end	
				end
			elseif page == 4 then 
				if lb == 0 then 
					pdpage = 1
					----lib.Debug('lb页面判定'..pdpage)
				end	
				if pdpage == 1 then 
					page = page + 1
					lb1 = 1
					lb = 0
					if page > #zmenu then 
						page = 1
					end	
				end
				if qxsm > 0 or jmtx > 0 then 
					qxsm = 0	
					jmtx = 0	
				end
				if lb == 3 then 
					if tb == 5 then 
						cot1 = cot1 - 1
						if cot1 < 1 then 
							cot1 = #jmmenu[tb][tb1]
						end
					end
				elseif lb == 2 then 
					--lb = 3
					--cot1 = 1
					tb1 = tb1 + 1 
					if tb < 5 then 
						if tb1 > 3 then 
							tb1 = 1
						end 
					else
						if tb1 > 2 then 
							tb1 = 1
						end
					end
				elseif lb == 1 then 
					--lb = 2
					--tb1 = 1
					tb = tb + 1
					if tb > #menu then 
						tb = 1
					end
				end
			elseif page == 5 then 
				if lb1 == 1 then 
					pdpage = 1
					----lib.Debug('lb页面判定'..pdpage)
				end					
				if pdpage == 1 then 
					page = page + 1
					lb1 = 1
					lb = 0
					if page > #zmenu then 
						page = 1
					end
				end

				if lb1 == 2 then 					
					zdpage = zdpage + 1
					tb1 = 1
					tb2 = 1
					if zdpage > 4 then 
						zdpage = 1
					end
				end
				if lb1 == 3 then 
					if zdpage == 2 then 
						tb2  = tb2 + 1
						if tb2 > #zdwz2[tb1] then 
							tb2 = 1
						end
					elseif zdpage == 3 then 
						tb2  = tb2 + 1
						if tb2 > #zdwz3[tb1] then 
							tb2 = 1
						end
					elseif zdpage == 4 then 
						tb2  = tb2 + 1
						if tb2 > #zdwz4[tb1] then 
							tb2 = 1
						end	
					else 
						zdpage = 2
						lb1 = 2
						tb1 = 1
					end
				end
			end

			--lib.Debug('down当前所处lb='..lb..' 当前所处page='..page..' 当前所处lb1='..lb1..' tb='..tb..' tb1='..tb1..' cot1='..cot1)
		elseif X == VK_UP then
			if lb1 == 1 and lb == 0 then 
				page = page - 1
				lb1 = 1
				lb = 0
				if page > #zmenu then 
					page = 1
				end		
				if page < 1 then 
					page = #zmenu
				end	
			end
			if page == 1 then 
			elseif page == 2 then 
				if  xlsm > 0 then
					xlsm = 0	
				end
				if lb1 == 3 then 
					if WGSHUOMING > 0 then
						WGSTARTH = WGSTARTH - 1
						if WGSTARTH < 0 then 
							WGSTARTH = 0
						end
					end
				end
				if lb1 == 2 then 
					if kid - rnum > 0 then 
						kid = kid - rnum 	
					end
				end
			elseif page == 3 then 
				if lb1 == 1 and lb == 0 then 
					for p1 = 1,#MJMenu do 
						if MJMenu[p1] ~= nil then 
							MJMenu[p1] = nil 
						end
					end
				end
				if lb1 == 3 then
					if MJSHUOMING > 0 then 
						Mstarth = Mstarth - 1
						if Mstarth < 0 then 
							Mstarth = 0
						end	
					end
				end
				if lb1 == 2 then 
					if mid - rnum > 0 then 
						mid = mid - rnum 
					end
				end
			elseif page == 4 then 
				if qxsm > 0 or jmtx > 0 then 
					qxsm = 0	
					jmtx = 0
				end
				if lb == 3 then 
					if tb == 5 then 
						cot1 = cot1 + 1 
						if cot1 > #jmmenu[tb][tb1] then 
							cot1 = 1
						end
					end
				elseif lb == 1 then 
					tb = tb - 1
					if tb < 1 then 
						tb = 5
					end
				elseif lb == 2 then 
					tb1 = tb1 - 1
					if tb < 5 then 
						if tb1 < 1 then 
							tb1 = 3
						end
					else
						if tb1 < 1 then 
							tb1 = 2
						end
					end
				end	
			elseif page == 5 then 
				if lb1 == 2 then 					
					zdpage = zdpage - 1
					tb1 = 1
					tb2 = 1
					if zdpage < 1 then 
						zdpage = 4
					end
				end
				if lb1 == 3 then 
					if zdpage == 2 then 
						tb2  = tb2 - 1
						if tb2 < 1 then 
							tb2 = #zdwz2[tb1] 
						end
					elseif zdpage == 3 then 
						tb2  = tb2 - 1
						if tb2 < 1  then 
							tb2 = #zdwz3[tb1]
						end
					elseif zdpage == 4 then 
						tb2  = tb2 - 1
						if tb2 < 1  then 
							tb2 = #zdwz4[tb1]
						end	
					else 
						lb1 = 2
						tb1 = 1
					end
				end	
			end
			----lib.Debug('up当前所处lb='..lb..' 当前所处page='..page..' 当前所处lb1='..lb1)
		elseif X == VK_LEFT then
			if page == 1 then 
				if lb1 == 1 and TFSHUOMING ~= 1 and lb == 0 then 
					if tid2 > 0 then
						tid2 = tid2 - 1	
						if tid2 < 1 then 
							tid2 = 0
						end
					else
						tid = tid - 1
						if tid < 1 then 
							tid = 1
						end
					end
				elseif TFSHUOMING == 1  then 
					tfid = tfid - 1
					if tfid < 1 then 
						tfid = #tfme
					end
				end
			elseif page == 2 then 
				if  xlsm > 0 then 	
					xlsm = 0
				end		
				if WGSHUOMING > 0  then 				
					if WGSHUOMING == 1 then 
						if JY.Wugong[JY.Person[id]["武功"..kid]]['武功类型'] < 6 then 
							if tb5 == 0 then 
								tb4 = tb4 - 1
								if tb4 < 1 then 
									--tb4 = #CC.KFMove[JY.Person[id]["武功"..kid]]
									tb4 = 0
									tb5 = 2
								end
							else
								tb5 = tb5 - 1
								if tb5 < 1 then 
									tb5 = 0
									tb4 = #CC.KFMove[JY.Person[id]["武功"..kid]]
								end
							end	
						else
							tb5 = tb5 - 1
							if tb5 < 1 then 
								tb5 = 2
							end
						end
					else
						tb5 = tb5 - 1
						if tb5 < 1 then 
							tb5 = 2
						end
					end
				end
				if lb1 == 2 then 
					WGSTARTH = 0
					if page == 2 then 
						kid = kid - 1
						if kid < 1 then 
							kid = #kfmenu
						end
					end
				end
			elseif page == 3 then 
				if lb1 == 2 then 
					mid = mid - 1
					if mid < 1 then 
						mid = #MJMenu
					end
				end
			elseif page == 4 then 
				if qxsm > 0 or jmtx > 0  then 
					qxsm = 0	
					jmtx = 0	
				end	
				if lb == 3 then
					if tb == 1  then 
						if tb1 == 2 or tb1 == 3 then 
							cot1 = cot1 + 1
							if cot1 > #jmmenu[tb][tb1] then
								cot1 = 1
							end
						elseif tb1 == 1 then 
							cot1 = cot1 - 1
							if cot1 < 1 then 
								cot1 = #jmmenu[tb][tb1]
							end
						end
					elseif tb == 2 then 
						if tb1 == 1 or tb1 == 3  then 
							cot1 = cot1 - 1
							if cot1 < 1 then 
								cot1 = #jmmenu[tb][tb1]
							end
						elseif tb1 == 2 then 
							cot1 = cot1 + 1 
							if cot1 >  #jmmenu[tb][tb1] then 
								cot1 = 1
							end
						end
					elseif tb == 3 then 
						if tb1 == 1 or tb1 == 2 then 
							cot1 = cot1 - 1
							if cot1 < 1 then 
								cot1 =  #jmmenu[tb][tb1]
							end
						elseif tb1 == 3 then 
							cot1 = cot1 + 1 
							if cot1 > #jmmenu[tb][tb1] then 
								cot1 = 1
							end
						end
					elseif tb == 4 then 
						cot1 = cot1 - 1
						if cot1 < 1 then 
							cot1 =  #jmmenu[tb][tb1]
						end
					end
				end	
			elseif page == 5 then 
				if zdpage == 1 then
					if lb1 == 3 then 
						lb1 = 2
					end
				end
				if lb1 == 2 then 
					if zdpage == 1 then 
						tb1 = tb1 - 1
						tb2 = 1
						if tb1 < 1 then 
							tb1 = #zdwz1
						end
					end
					if zdpage > 1 then 
						tb1 = tb1 - 1
						tb2 = 1
						if tb1 < 1 then 
							tb1 = 3
						end
					end	
				end
			end
			--lib.Debug('left当前所处lb='..lb..' 当前所处page='..page..' 当前所处lb1='..lb1)
		elseif X == VK_RIGHT then
			if page == 1 then 
				if lb1 == 1 and TFSHUOMING ~= 1 and lb == 0 then 
					if tid < 8 then
						tid = tid + 1
						if tid > #team then 
							tid = #team
						end
					else
						tid2 = tid2 + 1
						if tid2 + tid > #team then
							tid2 = 0
							tid = 1
						end
					end
				elseif TFSHUOMING == 1 then 
					tfid = tfid + 1
					if tfid > #tfme then 
						tfid = 1
					end	
				end
			elseif page == 2 then 
				if xlsm > 0 then 
					xlsm = 0
				end
				if WGSHUOMING > 0  then 
					if JY.Wugong[JY.Person[id]["武功"..kid]]['武功类型'] < 6 then 
						if tb5 == 0 then 
							tb4 = tb4 + 1 
							if tb4 > #CC.KFMove[JY.Person[id]["武功"..kid]] then 
								tb4 = 0
								tb5 = 1
							end
						else
							tb5 = tb5 + 1
							if tb5 > 2 then 
								tb4 = 1
								tb5 = 0
							end	
						end	
					else
						tb5 = tb5 + 1
						if tb5 > 2 then 
							tb5 = 1
						end
					end
				end
				if lb1 == 2 then 
					WGSTARTH = 0
					if page == 2 then 
						kid = kid + 1
						if kid > #kfmenu then 
							kid = 1
						end
					end
				end
			elseif page == 3 then 
				if lb1 == 2 then 
					mid = mid + 1
					if mid > #MJMenu then 
						mid = 1
					end
				end
			elseif page == 4 then 
				if qxsm > 0 or jmtx > 0  then 
					qxsm = 0	
					jmtx = 0	
				end
				
				if lb == 3 then 
					if tb == 1 then 
						if tb1 == 1 then 
							cot1 = cot1 + 1
							if cot1 > #jmmenu[tb][tb1] then 
								cot1 = 1
							end
						elseif tb1 == 2 or tb1 == 3 then 
							cot1 = cot1 - 1
							if cot1 < 1  then
								cot1 = #jmmenu[tb][tb1] 
							end
						end
					elseif tb == 2  then 
						if tb1 == 1 or tb1 == 3 then 
							cot1 = cot1 + 1
							if cot1 > #jmmenu[tb][tb1] then 
								cot1 = 1
							end
						elseif tb1 == 2 then 
							cot1 = cot1 - 1 
							if cot1 < 1  then 
								cot1 = #jmmenu[tb][tb1] 
							end					
						end
					elseif tb == 3 then 
						if tb1 == 1 or tb1 == 2 then 
							cot1 = cot1 + 1
							if cot1 > #jmmenu[tb][tb1] then 
								cot1 = 1
							end
						elseif tb1 == 3 then 
							cot1 = cot1 - 1
							if cot1 < 1 then 
								cot1 = #jmmenu[tb][tb1]
							end
						end	
					elseif tb == 4 then 
						cot1 = cot1 + 1
						if cot1 > #jmmenu[tb][tb1] then 
							cot1 = 1
						end
					end
				end	
			elseif page == 5 then
				if zdpage == 1 then
					if lb1 == 3 then 
						lb1 = 2
					end
				end
				if lb1 == 2 then 
					if zdpage == 1 then 
						tb1 = tb1 + 1
						tb2 = 1
						if tb1 > #zdwz1 then 
							tb1 = 1
						end
					end
					if zdpage > 1 then 
						tb1 = tb1 + 1
						tb2 = 1
						if tb1 > 3 then 
							tb1 = 1
						end
					end	
				end
			end
			--lib.Debug('right当前所处lb='..lb..' 当前所处page='..page..' 当前所处lb1='..lb1)					
		elseif X == VK_A then  
			if inteam(id) == true then 
				Mianbanwq(id)
			end
		elseif X == VK_B then
			if inteam(id) == true then 
				Mianbanfj(id)
			end
		elseif X == VK_Z then
			if inteam(id) == true then 
				Mianbanzq(id)		
			end				  				
		elseif X == VK_F1 then
			if WGSHUOMING ~= 2 then 
				WGSHUOMING = 2 
			else
				WGSHUOMING = 1
			end
		elseif	X == VK_X then		
			if inteam(id) == true then 
				if page == 2 and WGSHUOMING < 1 then
					xlmj(id)
					--return 1
				elseif page == 3 then 

				end
			end
		elseif ktype == 6 or X == VK_PGUP then
			if lb1 == 3 then 
				if WGSHUOMING > 0 then
					WGSTARTH = WGSTARTH - 1
					if WGSTARTH < 0 then 
						WGSTARTH = 0
					end	
				elseif MJSHUOMING > 0 then 
					Mstarth = Mstarth - 1
					if Mstarth < 0 then 
						Mstarth = 0
					end	
				end
			elseif c_true(px,py) == 1 then
				if tid2 > 0 then 
					tid2 = tid2 - 1
				end
			end
		elseif ktype == 7 or X == VK_PGDN then	
			if lb1 == 3 then 
				if WGSHUOMING > 0 then 
					if WGSHUOMING > 0 then
						WGSTARTH  = WGSTARTH + 1
						if WGSTARTH > FY then
							WGSTARTH = FY 
						end
					end
				elseif MJSHUOMING > 0 then 
					if MJSHUOMING > 0 then
						Mstarth  = Mstarth + 1
						if Mstarth > Mfy then
							Mstarth = Mfy 
						end
					end
				end
			elseif c_true(px,py) == 1 then
				if tid2 + tid < #team then
					if tid < 8 then
						tid = tid + 1
					else
						tid2 = tid2 + 1
					end
				end
			end
		else
			local mxxx = false
			local sm = 0
			--取消一些说明
			if mx > 0 then 
				if jmtx > 0 or qxsm > 0 or xlsm > 0  then 
					jmtx = 0
					qxsm = 0
					xlsm = 0
				end
			end
			
			--主菜单
			for i = 1,#zmenu do  
				if mx >= bx*1290 and mx <= bx*1360 and my >= by*175+(i-1)*p2x and my <= by*280+(i-1)*p2y then 
					if page ~= i and ktype == 3 then
						PlayWavE(77)
						page = i
						lb = 0
						tb = 1
						tb1 = 1
						cot1 = 1
						kid = 1
						mid = 1
						lb1 = 1
						break
					end
				end
			end

			--队友
			for i = 1,8 do 
				if mx >= bx*150+(i-1)*bx*150-bx*65 and mx <= bx*150+(i-1)*bx*150+bx*65 and my >= by*85-bx*65 and my <= by*85+bx*65 then 
					if team[i+tid2] ~= nil then
						if tid ~= i and ktype == 3 then
							PlayWavE(77)
							tid = i
							lb = 1
							tb = 1
							tb1 = 1
							cot1 = 1
							kid = 1
							mid = 1
							dh = 0
							break
						end
					end
				end
			end

			if page == 1 then 
				--天赋说明
				for i = 1,#tfme do		
					if WGSHUOMING < 1 then		
						if mx >= tfx + (i-1)*bx*70 and mx <= tfx + (i)*CC.ScreenW/22.666 + (i-1)*bx*15 and my >= tfy and my <= tfy+bx*55 and ktype == 3  then
							PlayWavE(77)
							tfid = i						
							TFSHUOMING = 1		
							lb1 = 2			
							break			
						end
					end
				end
				if TFSHUOMING == 1 and ktype == 4 then
					PlayWavE(77)
					TFSHUOMING = 0
					tfid = 0
				end	
				--装备
				--lib.LoadPNG(91, 281 * 2 , bx*18,by*568+(i-1)*size*2.2, 1,0,100 )
				for i = 1,3 do 
					if mx >= bx*18 and mx <= bx*18 + bx*55 and my >= by*568+(i-1)*size*2.2 and my <= by*568+(i-1)*size*2.2 + by*55 and WGSHUOMING < 1 and ktype == 3 then 
						if inteam(id) == true then 
							if i == 1 then 
								Mianbanwq(id)
							elseif i == 2 then
								Mianbanfj(id)
							elseif i == 3 then 
								Mianbanzq(id)
							end
						end
					end
				end	
			end	
			--武功
			if page == 2 then 
				local n,m,wfy = 0,0,0
			
				if mx >= bx*600 and mx <= bx*600+bx*70 and my >= by*700 and my <= by*700 + by*70 and ktype == 3 then
					if WGSHUOMING < 1 then	
						xlmj(id)
					end
				end
				for i = 1,JY.Base["武功数量"] do 
					if JY.Person[id]['武功'..i] > 0 then 
						
						if mx >= CC.ScreenW/2 +n*p2x - bx*32 and mx <= CC.ScreenW/2 +n*p2x + bx*32 and my >= by*360+m*p2y - bx*32 and my <= by*360+m*p2y + by*50 and WGSHUOMING < 1 then
							if kid ~= i then 
								PlayWavE(77)
							end
							lb1 = 2
							kid = i
							mxxx = true
							break
						end
						n = n + 1
						if n == rnum then 
							n = 0
							m = m + 1
						end
					end
				end
				
				if mxxx == true and ktype == 3 then
					lb1=3
					PlayWavE(77)
					--say(JY.Wugong[JY.Person[team[tid+tid2]]['武功'..kid]]['名称'],1)
					WGSHUOMING = 1
				end
				--bx*zszb[j][1]-CC.ScreenW/55,zsh+by*zszb[j][2]+by*64
				if lb1 == 3 then 
					--切换武功说明
					--lib.LoadPNG(91,14*2,size/3,CC.ScreenH/2-size*2.8,1,0,80)  -- 切换武功说明图片
					if WGSHUOMING > 0 then 
						local qhwg = false
						if mx > 0 and mx < size*1.8 and my > CC.ScreenH/2-size*2.8 and my < CC.ScreenH/2-size then 
							qhwg = true
						end
						if qhwg == true and ktype == 3 then 
							if WGSHUOMING == 1 then 
								WGSHUOMING = 2
							else
								WGSHUOMING = 1
							end
						end
					end

					if CC.KFMove[JY.Person[id]["武功"..kid]] ~= nil then
						for i = 1,#CC.KFMove[JY.Person[id]["武功"..kid]] do 
							if mx > bx*zszb[i][1]-CC.ScreenW/55  and mx < bx*zszb[i][1] + bx*15 and my > zsh+by*zszb[i][2]+by*64 and my < zsh+by*zszb[i][2]+by*63 + by*40 then
								if tb4 ~= i then									
									tb4 = i
									break
								end			
							end
						end
					end
					local mxxxx = false
					for i = 1,#zb5 do					
						if mx > bx*zb5[i][1]-wzbx6 and mx < bx*zb5[i][1]-wzbx6 + bx*67 and my >by*zb5[i][2]+wzby6-by*4 and my < by*zb5[i][2]+wzby6+by*25 and inteam(id) then
							tb5 = i
							--lb1=3
							mxxxx = true
							break
						end
					end
					if mxxxx == true and ktype == 3 and inteam(id) then					
						if page == 2 and wgmenu[kid][1] > 0 then
							if tb5 == 1 then	
								PlayWavE(77)
								if JY.Wugong[wgmenu[kid][1]]["武功类型"] < 6  then  --优先使用不等于当前选择
									if  p["优先使用"] ~= wgmenu[kid][1] then
										p["优先使用"] = wgmenu[kid][1]
									else
										p["优先使用"] = 0
									end
								elseif JY.Wugong[wgmenu[kid][1]]["武功类型"] == 6   then
									if  p["主运内功"] ~= wgmenu[kid][1] then
										p["主运内功"] = wgmenu[kid][1]
										Hp_Max(id)
										Mp_Max(id)
									else
										p["主运内功"] = 0
										Hp_Max(id)
										Mp_Max(id)
									end
								elseif JY.Wugong[wgmenu[kid][1]]["武功类型"] == 7   then
									if  p["主运轻功"] ~= wgmenu[kid][1] then
										p["主运轻功"] = wgmenu[kid][1]
									else
										p["主运轻功"] = 0
									end
								end
							else	
								PlayWavE(77)
								local R = 0
								
								if wgmenu[kid][3] < 10 then
									if KF_thing(wgmenu[kid][1]) == nil then
										R = JY.Wugong[wgmenu[kid][1]]['层级']*80
									else
										R = math.modf((5-math.modf(25/25))*JY.Thing[KF_thing(wgmenu[kid][1])]["需经验"]*(wgmenu[kid][3]+1)*0.05);
									end
								end
								if wgmenu[kid][3] < 10   then
									if  p["物品修炼点数"] >= R then
										wgmenu[kid][3] = wgmenu[kid][3] + 1								
										JY.Person[id]["武功等级"..wgmenu[kid][5]] = JY.Person[id]["武功等级"..wgmenu[kid][5]] + 100
										KF_addsx(id,wgmenu[kid][1])
										Hp_Max(id)
										Mp_Max(id)
										p["物品修炼点数"] = p["物品修炼点数"] - R
									else
										xlsm = 1
									end
								else
									xlsm = 2
								end		
							end
						end
					end	
				end			
			end
			--秘技
			if page == 3 then 
				local n,m,wfy = 0,0,0
				if mx >= bx*600 and mx <= bx*600+bx*70 and my >= by*700 and my <= by*700 + by*70 and ktype == 3 then
					--if WGSHUOMING < 1 then	
						--xlmj(id)
						--jiemian()
						--page = 3
					--end
				end 
				if MJSHUOMING < 1 then 
					for i = 1,10 do 
						if JY.Person[id]['秘技'..i] > 0 then 
							if mx >= CC.ScreenW/2 +n*p2x - bx*32 and mx <= CC.ScreenW/2 +n*p2x + bx*32 and my >= wgy1 + by*360+m*p2y  and my <= wgy1 + by*420+m*p2y*1.1 and WGSHUOMING < 1 then
								if kid ~= i then 
									PlayWavE(77)
								end
								mid = i
								mxxx = true
								lb1 = 2
								break
							end
							n = n + 1
							if n == rnum then 
								n = 0
								m = m + 1
							end
						end
					end				
					if mxxx == true and ktype == 3 then
						PlayWavE(77)
						--say(JY.Wugong[JY.Person[team[tid+tid2]]['武功'..kid]]['名称'],1)
						--WGSHUOMING = 1
						MJSHUOMING = 1
						lb1 = 3
					end	
				end		
			end	
			--经脉		
			if page == 4 then 
				local smmx = false
				if mx >= bx*212+bx*829+p_3x and mx <=bx*212+bx*849+p_3x and my >= by*33+by*76+p_3y and my <= by*33+by*102+p_3y then
					smmx = true
				end
				if smmx == true and ktype == 3 and inteam(id) then
					QXSHUOMING = 1
				end	
				if lb <= 1  then 
					--bx*212+bx*120,by*33+by*220+by*(i-1)*hg
					for i = 1,#menu do
						if mx >= bx*332+p_3x and mx <= bx*332 + bx*122+p_3x and my >= bx*253 +bx*(i-1)*hg+p_3y and my <= bx*253 + bx*36 +bx*(i-1)*hg+p_3y then 
							if tb ~= i then
								PlayWavE(77)
							end
							tb = i
							tb1 = 1
							mxxx = true
							break
						end
					end
				elseif lb == 2 then
					local jmmenu = {3,3,3,3,2}
					--bx*212+bx*145,by*33+by*260+by*(j-1)*size*0.9
					for i = 1,jmmenu[tb] do
						if mx >= bx*357+p_3x and mx <= bx*357 + size*3+p_3x and my >= bx*293 +bx*(tb-1)*hg + by*(i-1)*size*0.9+p_3y  and my <= bx*293 +bx*(tb-1)*hg + by*(i-1)*size*0.9+ size*0.75+p_3y then 
							if tb1 ~= i then
								PlayWavE(77)
							end
							tb1 = i
							mxxx = true
							break
						end
					end
				--奇穴	
				elseif lb == 3 then 		
					if tb1 < 1 then 
						tb1 = 1
					end			
					for i = 1,#jmmenu[tb][tb1] do 
						local i1 = jmmenu[tb][tb1][i][6]
						local i2 = jmmenu[tb][tb1][i][7]
						if mx >= i1 - bx*10+p_3x and mx <= i1 + bx*10+p_3x and my >= i2 - bx*10+p_3y and my <= i2 + bx*10+p_3y then 
							if cot1 ~= i then
								PlayWavE(77)
							end
							cot1 = i
							mxxx = true
							----lib.Debug('现有武学点'..JY.Person[id]["武学点数"]..' 奇穴 '..jmmenu[tb][tb1][cot1][1]	..' 需要武学点 '..jmmenu[tb][tb1][cot1][5])
							break
						end
					end
				end
				if mxxx == true and ktype == 3 and inteam(id)  then
					PlayWavE(77)
					if lb == 1 or lb == 0 then
						lb = 2
					elseif lb == 2 then
						lb = 3
						cot1 = 1
					elseif lb == 3 then
						local pd = false	
						local jmjd =jmmenu[tb][tb1][cot1]	
						local xhds = jmjd[5] 
						if inteam(id) == true then 				
							if cot1 == 1  then							
								local ngn = {} 
								local ng0,ng1,ng2,ngdj = 0,0,0,0
								for w = 1,JY.Base["武功数量"] do 
									local wugong = JY.Person[id]["武功"..w]
									if wugong > 0 then
										if JY.Wugong[wugong]["武功类型"] == 6 then 
											ngn[#ngn+1] = wugong
										end
									end
								end
								--确定有学会合适的内功
								for j = 1,#ngn do 
									if WGns(ngn[j]) == 0 then 
										ng0 = 1
									end
									if WGns(ngn[j]) == 1 then 
										ng1 = 1
									end
									if WGns(ngn[j]) == 2 then 
										ng2 = 1
									end
									ngdj = JY.Wugong[ngn[j]]["层级"]
								end
								if  JY.Person[id]["奇穴"..rwqx] < 1 then 
									
									if  ngdj >= 1   then 
										pd = true
									end
									if pd == true then
										if JY.Person[id]["武学点数"] - xhds >= 0 then 
											
											JY.Person[id]["奇穴"..rwqx] = 1  --激活经脉
											jmtx = 1
											JY.Person[id][jmjd[2]] = JY.Person[id][jmjd[2]] + jmjd[3]  --增加人物属性
											JY.Person[id]["武学点数"] = JY.Person[id]["武学点数"] - xhds
											--奇穴激活特效
										else
											qxsm = 2
										end
									else
										qxsm = 3	
									end
								end
							elseif cot1 > 1  then
								if JY.Person[id]["奇穴"..rwqx-1] > 0 then
									if  JY.Person[id]["奇穴"..rwqx] < 1 then 
										if JY.Person[id]["武学点数"] - xhds >= 0 then
											--特殊经脉
											local tsjme = {CC.TSJM_SSYIN,CC.TSJM_SSYANG,CC.TSJM_ZSYIN,CC.TSJM_ZSYANG,CC.TSJM_RENDU}
											local tsmenu = tsjme[tb]
											local tsqx = 0
											
											for t = 1,#tsmenu do 
												if tsmenu[t][3] == rwqx then 
													tsqx = 1
													--lib.Debug('判定成功 '..tsqx..'  经脉穴位== '..rwqx)
													break
												end
											end
											----lib.Debug('判定成功 '..tsqx..'  经脉穴位== '..rwqx)
											if  tsqx == 0  then 
												JY.Person[id]["奇穴"..rwqx] = 1  --激活经脉
												jmtx = 1
												--JY.Person[id][jmjd[2]] = JY.Person[id][jmjd[2]] + jmjd[3]  --增加人物属性
												AddPersonAttrib(id,jmjd[2],jmjd[3])
												JY.Person[id]["武学点数"] = JY.Person[id]["武学点数"] - xhds

											else
												if JMQX_JH(id,rwqx)  then 
													--lib.Debug('经脉奇穴判定成功')
													JY.Person[id]["奇穴"..rwqx] = 1  --激活经脉
													jmtx = 1 
													--JY.Person[id][jmjd[2]] = JY.Person[id][jmjd[2]] + jmjd[3]  --增加人物属性
													AddPersonAttrib(id,jmjd[2],jmjd[3])
													JY.Person[id]["武学点数"] = JY.Person[id]["武学点数"] - xhds
													if rwqx == 22 then 
														AddPersonAttrib(id, "攻击带毒", 20)
														AddPersonAttrib(id, "用毒能力", 20)														
													end
													if rwqx == 25 then 
														AddPersonAttrib(id, "用毒能力", 30)														
													end													
													if rwqx == 28 then 
														AddPersonAttrib(id, "用毒能力", 100)														
													end
													if rwqx == 95 then 
														AddPersonAttrib(id, "基础生命", 300)														
													end
													if rwqx == 117 then 
														AddPersonAttrib(id, "体质", 2)
													end
													if rwqx == 129 then 
														AddPersonAttrib(id, "内力最大值", 500)
													end													
												else
													qxsm = 3
												end						
											end
											--贯通经脉属性加成
											for i = 1,#CC.qxnum do 	
												if CC.qxnum[i] == rwqx then 
													if i == 1 or i == 4 or i == 7 or i == 10 then 										
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['攻击力'] =  JY.Person[id]['攻击力'] + 50
															AddPersonAttrib(id,'攻击力',50)
														end
													elseif i == 2 or i == 5 or i == 8 or i == 11 then 
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['防御力'] =  JY.Person[id]['防御力'] + 50
															AddPersonAttrib(id,'防御力',50)
														end
													elseif i == 3 or i == 6 or  i == 9  or i == 12 then 
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['轻功'] =  JY.Person[id]['轻功'] + 50
															AddPersonAttrib(id,'轻功',50)
														end
													elseif i == 13 or i == 14  then 
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['轻功'] =  JY.Person[id]['轻功'] + 50
															AddPersonAttrib(id,'轻功',50)
														end
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['攻击力'] =  JY.Person[id]['攻击力'] + 50
															AddPersonAttrib(id,'攻击力',50)
														end
														if JY.Person[id]["奇穴"..CC.qxnum[i]] == 1 then 
															--JY.Person[id]['防御力'] =  JY.Person[id]['防御力'] + 50
															AddPersonAttrib(id,'防御力',50)
														end										
													end												
												end
											end																								
										else
											qxsm = 2
										end			
									end
								else
									qxsm = 1
								end
							end
						end
					end	
				end	
			end
			--战斗
			if page == 5 then 
				local mxxx = false 
				if lb1 < 3 and inteam(id) then 
					for i = 1,4 do 
						if mx > CC.ScreenW/2 and mx < CC.ScreenW/2 + bx*400 and my > CC.ScreenH/2 + (i-1)*by*60 and my < CC.ScreenH + by*40 + (i-1)*by*60  and inteam(id) then							
							zdpage = i
						end
					end					
					--招式方针
					if zdpage == 1  then 
						for i = 1,#zdwz1 do 
							if mx > bx*717+(i-1)*bx*34 and mx < bx*717+(i-1)*bx*34 + size2*1.2 and my > by*385 and my < by*385+size2 then
								tb1 = i 
								lb1 = 2
								mxxx = true 
								break
							end
						end
						if mxxx == true and ktype == 3 then 
							if JY.Person[id]['优先使用'] == 0 then 
								say('还没给我装备外功哦',id,1)
							else
								if tb1 > #CC.KFMove[JY.Person[id]['优先使用']] then 
									say('使用的武功没有这么多招式哦',id,1)
								else
									if JY.Person[id]['招式方针'] == tb1 then 
										JY.Person[id]['招式方针'] = 0
									else
										JY.Person[id]['招式方针'] = tb1
									end
								end
							end
						end
					
					--攻击方针
					elseif zdpage == 2 then 
						for i = 1,3 do 
							if mx > bx*717 + (i-1)*160 and mx < bx*717 + (i-1)*160 + bx*145  and my > by*440 and my < by*440 + size2*2 then 
								tb1 = i 
								lb1 = 2
								mxxx = true 
								break
							end
						end	
						if mxxx == true and ktype == 3 then 
							lb1 = 3
						end
					elseif zdpage == 3 then 
						for i = 1,3 do 
							if mx > bx*717 + (i-1)*160 and mx < bx*717 + (i-1)*160 + bx*145  and my > by*440 + zh and my < by*440 + size2*2 + zh then 
								tb1 = i 
								lb1 = 2
								mxxx = true 
								break
							end
						end	
						if mxxx == true and ktype == 3 then 
							lb1 = 3
						end
					elseif zdpage == 4 then 
						for i = 1,3 do 
							if mx > bx*717 + (i-1)*160 and mx < bx*717 + (i-1)*160 + bx*145  and my > by*440 + zh*2 and my < by*440 + size2*2 + zh*2 then 
								tb1 = i 
								lb1 = 2
								mxxx = true 
								break
							end
						end	
						if mxxx == true and ktype == 3 then 
							lb1 = 3
						end	
					end
				else
					if zdpage == 2 then 	
						for i = 1,#zdwz2[tb1] do 
							if mx > bx*705 + (tb1-1)*165 and mx < bx*700 +bx*160+ (tb1-1)*165 and my > by*490 and my < by*490+(i)*size2*1.2 then 
								tb2 = i 
								mxxx = true 
								--lib.Debug(tb1)
								break
							end
						end
						if mxxx == true and ktype == 3  then 
							if tb1 == 1 then 
								JY.Person[id]['行动方针'] = tb2 - 1
							elseif tb1 == 2 then 
								JY.Person[id]['施毒方针'] = tb2 - 1
							elseif tb1 == 3 then 
								JY.Person[id]['暗器方针'] = tb2 - 1
							end
						end
					elseif zdpage == 3 then 
						--lib.Background( bx*705 + (tb1-1)*165,by*490+zh,bx*700 +bx*160+ (tb1-1)*165,by*461+(#zdwz3[tb1]+2)*size2*1.2+zh,50)
						for i = 1,#zdwz3[tb1] do 
							if mx > bx*705 + (tb1-1)*165 and mx < bx*700 +bx*160+ (tb1-1)*165 and my > by*490 + zh and my < by*490+(i)*size2*1.2 + zh then 
								tb2 = i 
								mxxx = true 
								--lib.Debug(tb1)
								break
							end
						end
						if mxxx == true and ktype == 3 then 
							if tb1 == 1 then 
								JY.Person[id]['吃红药方针'] = tb2 - 1
							elseif tb1 == 2 then 
								JY.Person[id]['吃蓝药方针'] = tb2 - 1
							elseif tb1 == 3 then 
								JY.Person[id]['吃黄药方针'] = tb2 - 1
							end
						end
					elseif zdpage == 4 then 
						for i = 1,#zdwz4[tb1] do 
							if mx > bx*705 + (tb1-1)*165 and mx < bx*700 +bx*160+ (tb1-1)*165 and my > by*490 + zh*1 and my < by*490+(i)*size2*1.2 + zh*2 then 
								tb2 = i 
								mxxx = true 
								--lib.Debug(tb1)
								break
							end
						end
						if mxxx == true and ktype == 3 then 
							if tb1 == 1 then 
								JY.Person[id]['复活方针'] = tb2 - 1 
							elseif tb1 == 2 then 
								JY.Person[id]['喝酒方针'] = tb2 - 1
							elseif tb1 == 3 then 
								JY.Person[id]['备用方针1'] = tb2 - 1
							end
						end
					end
				end
			end
		end
	end
end

function Season()
	local MM = 0
	if CC.Month == 1 or CC.Month == 2 or CC.Month == 3 then 
		MM = 1
	elseif CC.Month == 4 or CC.Month == 5 or CC.Month == 6 then 
		MM = 2
	elseif CC.Month == 7 or CC.Month == 8 or CC.Month == 9 then 
		MM = 3
	elseif CC.Month == 10 or CC.Month == 11 or CC.Month == 12 then 
		MM = 4	
	end	
	return MM
end