
	-- --传送地址列表
-- function My_ChuangSong_List()
	-- local menu = {};
	-- for i = 0, JY.SceneNum-1 do
		-- --不显示的场景：闯王宝藏1 3 明教地道，高昌迷宫+沙漠废墟3组 少林寺 思过崖 梅庄地牢 大功坊地窖 无量山洞 鹿鼎山1 3 少林后山 皇宫 北京郊外 鳌府密室 华山绝顶 绝情谷底 古墓密道 峨眉金顶 鹊桥 黑山大会
		-- --老祖居 万安寺顶 华山秘洞 不老长春谷 ?
		-- if i == 5 or i == 85 or i == 13 or i == 14 or i == 15 or i == 86 or i == 88 or i == 89 
		-- or i == 28 or (i >= 81 and i <= 83) or i == 42 or i == 67 or i == 91 or i == 106 
		-- or i == 108 or i == 109 or i == 110 or i == 111 or i == 113 or i == 114 or i == 116 
		-- or i == 117 or i == 104 or i == 119 or i == 102 or i == 122 or i == 123 or i == 124 or i == 125 or i == 127 then
		
		-- else
			-- --无酒不欢：这里i即为场景编号
			-- menu[i+1] = {JY.Scene[i]["名称"], JY.Scene[i]["进入条件"], i, JY.Scene[i]["场景类型"]};	
		-- end
	-- end

	-- --颜色依次为常规颜色和选中颜色
	-- local r = TeleportMenu(menu, C_GOLD, C_WHITE);
	
	-- --返回值小于0（ESC），直接返回
	-- if r < 0 then
		-- return 0;
	-- end
	
	-- --返回值大于等于0，返回值即为场景编号
	-- if r >= 0 then	
		-- local sid = r;

		-- if JY.Base["畅想"] == 5 and sid==43 then
			-- say("１Ｒ需要先通关黑山大会。", 119, 5, "车夫");	
			-- return 1;
		-- else
			-- My_Enter_SubScene(sid,-1,-1,-1);	
		-- end
	-- end
	-- return 1;
-- end

-- --加强版传送地址菜单
-- function My_ChuangSong_Ex()     
	-- local title = "雇佣马车";
	-- local str = JY.Person[0]["外号"].."想去什么地方？*路费纹银三两*再远也给您送到";
	-- local btn = {"指点江山", "激扬文字"};
	-- local num = #btn;
	-- local r = JYMsgBox(title,str,btn,num,119,1);
	-- if r == 1 then
		-- return My_ChuangSong_List();
	-- elseif r == 2 then
		-- Cls();
		-- local sid = InputNum("场景代码",0,JY.SceneNum-1,1);
		-- if sid ~= nil then			
			-- --标注几个不显示的：闯王宝藏1 3 明教地道，高昌迷宫+沙漠废墟3组 少林寺 思过崖 梅庄地牢 大功坊地窖 无量山洞 鹿鼎山1 3 鹊桥 不老长春谷 ?
			-- if sid == 5 or sid == 85 or sid == 13 or sid == 14 or sid == 15 or sid == 86 or sid == 88 or sid == 89 
			-- or sid == 28 or (sid >= 81 and sid <= 83) or sid == 42 or sid == 67 or sid == 91 or sid == 106 
			-- or sid == 108 or sid == 109 or sid == 110 or sid == 111 or sid == 113 or sid == 114 or sid == 104 or sid == 124 or sid == 125 or JY.Scene[sid]["进入条件"] == 1 then
				-- say("１Ｒ您目前不能进入此场景。", 119, 5, "车夫");
				-- return 1;
			-- elseif JY.Base["畅想"] == 5 and sid==43 then
			-- say("１Ｒ需要先通关黑山大会。", 119, 5, "车夫");	
				-- return 1;
			-- else
				-- My_Enter_SubScene(sid,-1,-1,-1);
			-- end
		-- end
	-- end
-- end

-- --进练功房
-- function LianGong(lx)
	-- JY.Person[591]["等级"] = 0
	-- JY.Person[591]["内力性质"] = lx
	-- JY.Person[591]["头像代号"] = math.random(190)
	-- JY.Person[591]["生命最大值"] = 10
	-- JY.Person[591]["生命"] = JY.Person[591]["生命最大值"]
	-- instruct_6(226, 8, 0, 1)
	-- JY.Person[591]["内力性质"] = 0
	-- light()
	-- --return 1;
-- end

-- --武功特效说明
-- function WuGongIntruce()
	-- local menu = {};
	
	-- for i = 1, JY.WugongNum-1 do
		-- menu[i] = {i..JY.Wugong[i]["名称"], nil, 0}
	-- end
	
	-- --拥有的秘籍
	-- for i = 1, CC.MyThingNum do
    -- if JY.Base["物品" .. i] > -1 and JY.Base["物品数量" .. i] > 0 then
    	-- local wg = JY.Thing[JY.Base["物品" .. i]]["练出武功"];
    	-- if wg > 0 then
    		-- menu[wg][3] = 1;
    	-- end
    -- else
    	-- break;
    -- end
  -- end
  
  -- --学会的武功
  -- for i=1, CC.TeamNum do
  	-- if JY.Base["队伍"..i] >= 0 then
  		-- for j=1, 10 do
  			-- if JY.Person[JY.Base["队伍"..i]]["武功"..j] > 0 then
  				-- menu[JY.Person[JY.Base["队伍"..i]]["武功"..j]][3] = 1;
  			-- else
  				-- break;
  			-- end
  		-- end
  	-- else
  		-- break;
  	-- end
  -- end
	
	-- local r = -1;
	-- while true do
		-- Cls();
		
		-- r = ShowMenu2(menu,JY.WugongNum-1,4,12,10,(CC.ScreenH-12*(CC.DefaultFont+CC.RowPixel))/2+20,0,0,1,1,CC.DefaultFont,C_ORANGE, C_WHITE, "请选择查看的武功", r);
		-- --local r = ShowMenu(menu,n,15,CC.ScreenW/4,20,0,0,1,1,CC.DefaultFont,C_ORANGE, C_WHITE);
		
		-- if r > 0 and r < JY.WugongNum then	
			-- InstruceWuGong(r);
		-- else
			-- break;
		-- end
	-- end
	
-- end

-- --显示武功或内功特效
-- function InstruceWuGong(id)
	-- if id < 0 or id >= JY.WugongNum then
		-- QZXS("武功未知错误，无法查看");
		-- return;
	-- end
	-- local filename = string.format("%s%d.txt", CONFIG.WuGongPath,id)
	-- if existFile(filename) == false then
		-- QZXS("此武功未包含任何说明，请自行琢磨");
		-- return;
	-- end
	-- DrawTxt(filename);
-- end

-- function TSInstruce()
	-- local filemenu = {};
	-- local n = 0;
	-- for i=1, math.huge do
		-- if existFile(string.format("%s%d.txt",CONFIG.HelpPath, i)) then
			-- filemenu[i] = string.format("%s%d.txt",CONFIG.HelpPath, i);
			-- n = n + 1;
		-- else
			-- break;
		-- end
	-- end
	
	-- local menu = {}
	-- local maxlen = 0;
	-- for i=1, n do
		-- local file = io.open(filemenu[i],"r")
		-- local str = file:read("*l")
		
		-- if str == nil then
			-- str = " ";
		-- end
		
		-- if #str > maxlen then
			-- maxlen = #str;
		-- end
		
		-- menu[i] = {i..str, nil, 1};
		
		-- file:close()
	-- end
	
	-- local size = CC.DefaultFont;
	
	-- while true do
		-- Cls();
		-- --local r = ShowMenu(menu,n,10,x1,y1,0,0,1,1,size,C_ORANGE,C_WHITE);
		-- local r = ShowMenu2(menu,#menu,2,12,20,(CC.ScreenH-12*(size+CC.RowPixel))/2+20,0,0,1,1,size,C_ORANGE,C_WHITE);
		-- if r > 0 then
			-- InstruceTS(r);
		-- else
			-- break;
		-- end
	-- end
-- end

-- --显示武功或内功特效
-- function InstruceTS(id)
		
	-- local filename = string.format("%s%d.txt", CONFIG.HelpPath,id)
	-- if existFile(filename) == false then
		-- QZXS("未找到相关的攻略文件");
		-- return;
	-- end
	
	-- DrawTxt(filename);
-- end

-- function DrawTxt(filename)
	-- Cls();
	
	-- --读取文件说明
	-- local file = io.open(filename,"r")
	-- local str = file:read("*a")
	-- file:close()
	
	-- local size = CC.DefaultFont;
	-- local color = C_WHITE;
	
	-- local linenum = 50;		--显示长度
	-- local maxlen = 14;
	-- local w = linenum*size/2 + size;
	-- local h = maxlen*(size+CC.RowPixel) + 2*CC.RowPixel;
	
	-- local bx = (CC.ScreenW-w)/2;
	-- local by = (CC.ScreenH-h)/2;
	-- DrawBox(bx,by,bx+w,by+h,C_WHITE);		--底边框
	-- local x = bx + CC.RowPixel;
	-- local y = by + CC.RowPixel;
	
	-- local surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)
	
	-- local strcolor = AnalyString(str)
	-- local l = 0
	-- local row = 0;


	-- for i,v in pairs(strcolor) do
		-- while 1 do
			-- if v[1] == nil then
				-- break;
			-- end
			-- local index = string.find(v[1], "\n")
			
			-- if l+#v[1] < linenum and index == nil then		--如果未到换行，没有找到换行
				-- DrawString(x + l*size/2, y + row*(size+CC.RowPixel), v[1], v[2] or color, size);
				-- l = l + #v[1]

				-- if i == #strcolor then
					-- --显示文字	ALungky:j 改成 j+1解决了末尾文字有时候无法显示的问题。
					-- for j=0, l do
						-- lib.SetClip(x,y,x+(j+1)*size/2,y+size+row*(size+CC.RowPixel));
						-- ShowScreen(1);
					-- end
					-- lib.SetClip(0,0,0,0);
				-- end
				-- break;
			-- else	--如果达到换行
				-- local tmp, pos1, pos2;
				-- if index == nil then
					-- pos1 = linenum-l;
					-- pos2 = pos1+1;
				-- else
					-- pos1 = index-1;
					-- pos2 = pos1+2;
					
					-- if pos1 > linenum-l then
						-- index = nil;
						-- pos1 = linenum-l;
						-- pos2 = pos1+1;
					-- end
				-- end
				
				-- --这个用于判断是否已经到达v[1]的最后内容部分
				-- if pos1 > #v[1] then
					-- tmp = v[1];
					-- v[1] = nil;
				-- else
					-- tmp = string.sub(v[1], 1, pos1)
					-- local flag = 0
					-- for i=1, pos1 do
						-- if string.byte(tmp, i) <= 127 then
							-- flag = flag + 1;
						-- end
					-- end
					
	
					-- if math.fmod(flag,2) == 1 and index == nil  then		--如果包含有单字符
							-- if string.byte(tmp, -1) > 127 then
								-- tmp = string.sub(v[1], 1, pos1-1);
								-- pos2 = pos2 - 1
							-- end
					-- end
	
					-- v[1] = string.sub(v[1], pos2);
				-- end
					
	
					-- DrawString(x + l*size/2, y + row*(size+CC.RowPixel), tmp, v[2] or color, size);
	
	
					-- l = l + #tmp
					-- --显示文字
					-- for j=0, l do
						-- lib.SetClip(x,y,x+j*size/2,y+size+row*(size+CC.RowPixel));
						-- ShowScreen(1);
					-- end
					
					-- --行数+1
					-- row = row + 1
					-- l = 0

				
			-- end

			-- lib.SetClip(0,0,0,0);
			
			-- if row == maxlen then
				-- WaitKey();
				-- row = 0;
				-- Cls();
				-- lib.LoadSur(surid, 0, 0)
				
			-- end
		-- end
	-- end
	-- lib.SetClip(0,0,0,0);
	-- WaitKey();
	-- lib.FreeSur(surid)
-- end

-- --十四本天书之后得到5000两
-- --修复自动洗四神技的BUG
-- function NEvent2(keypress)
	-- if JY.SubScene == 70 and GetD(70, 3, 0) == 0 and instruct_18(151) then
		-- instruct_3(70, 3, 1, 0, 0, 0, 0, 2610, 2610, 2610, 0, -2, -2)
	-- end
	-- if GetD(70, 3, 5) == 2610 and JY.SubScene == 70 and JY.Base["人X1"] == 8 and JY.Base["人Y1"] == 41 and JY.Base["人方向"] == 2 and (keypress == VK_SPACE or keypress == VK_RETURN) then
		-- say("１咦，有张纸条……Ｈ（"..JY.Person[0]["外号2"].."，这是留给你的五千两银子，好好准备一下吧）Ｈ哈，那老家伙还很够意思嘛！",0,1)
		-- instruct_2(174, 5000)
		-- SetS(10, 0, 17, 0, 1)
		-- SetD(83, 48, 4, 882)
	  -- if instruct_16(671) and PersonKF(0, 198) then
	    -- say("１经历了这么多，我仿佛有所感悟……",0,1)
		-- local s1 = JY.Wugong[JY.Person[0]["武功1"]]["名称"]
		-- local s2 = JY.Wugong[JY.Person[0]["武功2"]]["名称"]
		-- local s3 = JY.Wugong[JY.Person[0]["武功3"]]["名称"]
		-- local s4 = JY.Wugong[JY.Person[0]["武功4"]]["名称"]
	    -- local r = JYMsgBox("请选择", "选 择 第 一 到 第 四 个 武 功 领 悟 为【 剑 血 浮 生 】", {s1,s2,s3,s4,"放弃"}, 5, 20)
		-- if r == 1 then
			-- instruct_35(0, 0, 200, 999)
			-- DrawStrBoxWaitKey("你领悟了『Ｇ剑血浮生Ｏ』", C_ORANGE, CC.DefaultFont, 2)
		-- elseif r == 2 then
			-- instruct_35(0, 1, 200, 999)
			-- DrawStrBoxWaitKey("你领悟了『Ｇ剑血浮生Ｏ』", C_ORANGE, CC.DefaultFont, 2)
		-- elseif r == 3 then
			-- instruct_35(0, 2, 200, 999)
			-- DrawStrBoxWaitKey("你领悟了『Ｇ剑血浮生Ｏ』", C_ORANGE, CC.DefaultFont, 2)
		-- elseif r == 4 then
			-- instruct_35(0, 3, 200, 999)
			-- DrawStrBoxWaitKey("你领悟了『Ｇ剑血浮生Ｏ』", C_ORANGE, CC.DefaultFont, 2)
		-- end
		
	  -- else
		-- say("１这里还有一本秘籍，让我看一下……",0,1)
		-- local hid = 0
		-- if JY.Base["标准"] > 0 then
			-- if JY.Person[0]["性别"] == 0 then
				-- hid = 280 + JY.Base["标准"]
			-- else
				-- hid = 500 + JY.Base["标准"]
			-- end
		-- elseif JY.Base["特殊"] > 0 then
			-- if JY.Person[0]["性别"] == 0 then
				-- hid = 290
			-- else
				-- hid = 510
			-- end
		-- else
			-- hid = JY.Person[0]["头像代号"]
		-- end
		-- local r = JYMsgBox("请选择", "是否要洗第一格武功？*一：野球拳*二：神山剑法*三：西瓜刀法*四：犽月流空", {"一","二","三","四","放弃"}, 5, hid)
		-- if r == 1 then
			-- instruct_35(0, 0, 109, 999)
			-- DrawStrBoxWaitKey("你学会了『Ｇ野球拳Ｏ』", C_ORANGE, CC.DefaultFont, 2)
			-- JY.Person[0]["天赋外功4"] = 109
		-- elseif r == 2 then
			-- instruct_35(0, 0, 110, 999)
			-- DrawStrBoxWaitKey("你学会了『Ｇ神山剑法Ｏ』", C_ORANGE, CC.DefaultFont, 2)
			-- JY.Person[0]["天赋外功4"] = 110
			-- instruct_2(55, 1)
		-- elseif r == 3 then
			-- instruct_35(0, 0, 111, 999)
			-- DrawStrBoxWaitKey("你学会了『Ｇ西瓜刀法Ｏ』", C_ORANGE, CC.DefaultFont, 2)
			-- JY.Person[0]["天赋外功4"] = 111
			-- instruct_2(56, 1)
		-- elseif r == 4 then
			-- instruct_35(0, 0, 112, 999)
			-- DrawStrBoxWaitKey("你学会了『Ｇ犽月流空Ｏ』", C_ORANGE, CC.DefaultFont, 2)
			-- JY.Person[0]["天赋外功4"] = 112
			-- instruct_2(57, 1)
		-- end
	  -- end
		-- instruct_3(70, 3, 1, 0, 0, 0, 0, 2612, 2612, 2612, 0, -2, -2)
	-- end
-- end

-- --胡斐 苗人凤教苗家剑法
-- function NEvent3(keypress)
	-- if JY.SubScene == 24 and JY.Base["人X1"] == 18 and JY.Base["人Y1"] == 23 and JY.Base["人方向"] == 2 and (keypress == VK_SPACE or keypress == VK_RETURN) and GetS(10, 0, 3, 0) ~= 1 and instruct_16(1) and instruct_18(145) then
		-- say("１苗大侠，我已经找到雪山飞狐这本书了。", 1, 0)
		-- say("１嗯，很好！看来你的胡家刀法也已练得炉火纯青了，以后的江湖就看你们这些年轻人的了！这本苗家剑法你拿去吧！", 3,4)
		-- say("１多谢苗大侠！", 1, 0)
		-- instruct_35(1, 1, 44, 0)
		-- DrawStrBox(-1, -1, "胡斐学会苗家剑法", C_ORANGE, CC.DefaultFont)
		-- ShowScreen()
		-- lib.Delay(800)
		-- Cls()
		-- instruct_2(117, 1)
		-- SetS(10, 0, 3, 0, 1)
	-- end
-- end

-- --令狐冲变身
-- function NEvent4(keypress)
	-- if JY.SubScene == 7 and JY.Base["人X1"] == 34 and JY.Base["人Y1"] == 11 and JY.Base["人方向"] == 2 then
		-- --令狐冲在队，有九剑秘籍
		-- if instruct_16(35) and instruct_18(114) and GetS(10, 1, 1, 0) ~= 1 and (keypress == VK_SPACE or keypress == VK_RETURN) then
			-- SetS(7, 34, 12, 3, 102)
			-- instruct_3(7, 102, 1, 0, 0, 0, 0, 7148, 7148, 7148, 0, 34, 12)
			-- say("１雕兄－－，真想见识一下独孤前辈的风采啊！最近总感觉到对九剑有了新的领悟，但又很模糊，不能具体总结出来！", 35, 1)
			-- say("１哈哈－－－－，是时候了！", 140, 0)
			-- say("１风太师叔！！！", 35,1)
			-- instruct_14()
			-- SetS(7, 33, 12, 3, 101)
			-- instruct_3(7, 101, 1, 0, 0, 0, 0, 5896, 5896, 5896, 0, 33, 12)
			-- instruct_13()
			-- PlayMIDI(24)
			-- lib.Delay(500)
			-- say("１冲儿，跟我一起唱：沧海一声笑　滔滔两岸潮　浮沉随浪只记今朝　苍天笑　纷纷世上潮　谁负谁胜出天知晓　江山笑　烟雨遥　涛浪淘尽红尘俗事知多少　清风笑竟惹寂寥　豪情还剩一襟晚照　苍生笑　不再寂寥　豪情仍在痴痴笑笑", 140, 0)
			-- say("１冲儿，九剑的极意就隐藏在这首歌中，自已好好去体会吧！老夫心愿已了，从此再无牵挂，就此去也，哈哈－－－－", 140, 0)
			-- say("１多谢太师叔传剑，你老人家多保重！嗯，就在这里参悟九剑的奥义吧－－－－", 35, 1)
			-- instruct_14()
			-- instruct_3(7, 101, 0, 0, 0, 0, 0, -1, -1, -1, 0, 33, 12)
			-- instruct_13()
			-- DrawStrBox(-1, -1, "三日后", C_ORANGE, CC.DefaultFont)
			-- ShowScreen()
			-- lib.Delay(500)
			-- say("１成了！这才是真正的独孤九剑啊！此生有幸能学到独孤前辈之神技，夫复何憾！", 35, 1)
			-- DrawStrBox(-1, -1, "令狐冲领悟九剑之秘传", C_ORANGE, CC.DefaultFont)
			-- ShowScreen()
			-- lib.Delay(500)
			-- Cls()
			-- awakening(35, 1)	--令狐冲第二次觉醒
			-- DrawStrBox(-1, -1, "令狐冲称号变改", C_ORANGE, CC.DefaultFont)
			-- ShowScreen()
			-- lib.Delay(500)
			-- Cls()
			-- SetS(10, 1, 1, 0, 1)
			-- instruct_3(7, 102, 0, 0, 0, 0, 0, -1, -1, -1, 0, 34, 12)
		-- end
	-- end
-- end

-- --山洞事件
-- function NEvent6(keypress)
	-- if JY.SubScene == 10 then
		-- SetD(10, 28, 4, -1)
		-- SetS(10, 23, 22, 1, 2)
		-- SetS(10, 22, 22, 1, 2)
	-- end
	-- if JY.SubScene == 59 then
		-- JY.SubSceneX = 0
		-- JY.SubSceneY = 0
	-- end
-- end

-- --武道大会后，SYP自动放书
-- function NEvent10(keypress)
  -- if JY.SubScene == 25 and GetS(10, 0, 9, 0) ~= 1 then
    -- SetS(25, 9, 44, 3, 103)
    -- instruct_3(25, 103, 1, 0, 0, 0, 0, 4133*2, 4133*2, 4133*2, 0, -2, -2)
    -- if JY.Base["人X1"] == 10 and JY.Base["人Y1"] == 44 and JY.Base["人方向"] == 2 and (keypress == VK_SPACE or keypress == VK_RETURN) and GetD(25, 82, 5) == 4662 then
      -- say("１一路来到这里，真是辛苦了！我来帮你放书吧。",347,0,"谢无悠");
      -- instruct_14()
      -- for i = 79, 92 do
          -- instruct_3(25, i, 1, 0, 0, 0, 0, 4664, 4664, 4664, 0, -2, -2)
      -- end
      -- for ii = CC.BookStart, CC.BookStart + CC.BookNum -1 do
          -- instruct_32(ii, -10)
      -- end
	  -- JY.Base["天书数量"] = 15
      -- instruct_3(25, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2)
      -- instruct_3(25, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2)
      -- instruct_13()
      -- say("１书已经放好了，从上面的门出去吧。", 347,0,"谢无悠");
      -- SetS(10, 0, 9, 0, 1)
      -- instruct_3(25, 103, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2)
      
    -- end
  -- end
-- end

-- --大功坊 和袁承志对话后，金蛇剑归还
-- function NEvent12(keypress)
	-- if JY.SubScene == 95 and GetD(95, 4, 5) ~= 0 and JY.Thing[40]["使用人"] ~= -1 then
		-- JY.Person[JY.Thing[40]["使用人"]]["武器"] = -1
		-- JY.Thing[40]["使用人"] = -1
	-- end
-- end

-- --山洞女主角的剧情
-- function mm4R()
	-- say("１喵姐呢，出来接客了。", 0,0,JY.Person[0]["姓名"])
	-- say("１喵大山已经变成我的坐骑了，你换一个吧。", 290,1,"无酒不欢")
	-- say("１我就是饿死，从这跳下去，也不会要其他队友的！", 0,0,JY.Person[0]["姓名"])
	-- local player_type = JYMsgBox3("主角选择", "选择你想要的队友*", {"李逍遥","赵灵儿","林月如","阿奴","喵太极"}, 5, 290)
	-- ClsN()
	-- instruct_14()
	-- if player_type == 1 then
		-- if instruct_20(20, 0) == false then
    -- instruct_10(655)
		-- end
	-- instruct_13()
	-- say("１真香", 0,0,JY.Person[0]["姓名"])
	-- elseif player_type == 2 then
	-- instruct_14()
		-- if instruct_20(20, 0) == false then
    -- instruct_10(656)
		-- end
	-- instruct_13()
	-- say("１真香", 0,0,JY.Person[0]["姓名"])
	-- elseif player_type == 3 then
	-- instruct_14()
		-- if instruct_20(20, 0) == false then
    -- instruct_10(657)
		-- end
	-- instruct_13()
	-- say("１真香", 0,0,JY.Person[0]["姓名"])
	-- elseif player_type == 4 then
	-- instruct_14()
		-- if instruct_20(20, 0) == false then
    -- instruct_10(658)
		-- end
	-- instruct_13()
	-- say("１真香", 0,0,JY.Person[0]["姓名"])
	-- elseif player_type == 5 then
	-- PlayMIDI(121)
	-- instruct_14()
	-- instruct_13()
	-- say("１我今日就要带佢走，我睇下边个够胆拦我。", 0,0,JY.Person[0]["姓名"])
	-- if JY.Base["特殊"] == 1 then
	-- say("１很有我当年的风采，拿去吧。", 290,1,"无酒不欢")	
			-- if JY.Person[0]["性别"]==0 then
				-- instruct_2(321, 1)  --喵大山
			-- else
				-- instruct_2(322, 1)  --喵大山
			-- end
	-- else
	-- say("１只有强者才配拥有喵大山，就用一成功力陪你玩玩。", 290,1,"无酒不欢")
			-- JY.Person[596]["姓名"] = "无酒不欢"
			-- JY.Person[596]["头像代号"] = 355
			-- JY.Person[596]["生命最大值"]=5000
			-- JY.Person[596]["生命"]=5000
			-- JY.Person[596]["内力最大值"]=5000
			-- JY.Person[596]["内力"]=5000
			-- JY.Person[596]["攻击力"]=250
			-- JY.Person[596]["防御力"]=250
			-- JY.Person[596]["轻功"]=250
			-- JY.Person[596]["拳掌功夫"]=50
			-- JY.Person[596]["御剑能力"]=50
			-- JY.Person[596]["指法技巧"]=50
			-- JY.Person[596]["耍刀技巧"]=50
			-- JY.Person[596]["特殊兵器"]=50
			-- JY.Person[596]["防具"]=322
			-- JY.Person[596]["天赋内功"] = -1
			-- JY.Person[596]["天赋轻功"] = -1
			-- JY.Person[596]["武功2"]=0
			-- JY.Person[596]["武功等级2"]=999
		-- if WarMain(245) then
			-- light()
			-- say("１打的不错", 290,1,"无酒不欢")
			-- if JY.Person[0]["性别"]==0 then
				-- instruct_2(321, 1)  --喵大山
			-- else
				-- instruct_2(322, 1)  --喵大山
			-- end
		-- else
			-- light()
			-- say("１小小惩戒一下", 290,1,"无酒不欢")
			-- ShowScreen()
					-- lib.Delay(80)
					-- lib.ShowSlow(15, 1)
					-- Cls()
					-- lib.ShowSlow(50, 0)
					-- JY.Person[0]["性别"] = 2
					-- local add, str = AddPersonAttrib(0, "攻击力", -20)
					-- DrawStrBoxWaitKey(JY.Person[0]["姓名"] .. str, C_ORANGE, CC.DefaultFont)
					-- add, str = AddPersonAttrib(0, "防御力", -30)
					-- DrawStrBoxWaitKey(JY.Person[0]["姓名"] .. str, C_ORANGE, CC.DefaultFont)
						-- JY.Person[0]["外号"] = "姑娘"
						-- JY.Person[0]["外号2"] = "丫头"
						-- JY.Person[0]["头像代号"] = 303
						-- local f_ani = {
						-- {0, 0, 0}, 
						-- {0, 0, 0}, 
						-- {10, 8, 6}, 
						-- {0, 0, 0}, 
						-- {0, 0, 0}}
						-- for i = 1, 5 do
							-- JY.Person[0]["出招动画帧数" .. i] = f_ani[i][1]
							-- JY.Person[0]["出招动画延迟" .. i] = f_ani[i][3]
							-- JY.Person[0]["武功音效延迟" .. i] = f_ani[i][2]
						-- end
				-- end
		-- end
			-- JY.Person[596]["姓名"] = "谢无悠"
			-- JY.Person[596]["头像代号"] = 347
			-- JY.Person[596]["攻击力"]=500
			-- JY.Person[596]["防御力"]=500
			-- JY.Person[596]["轻功"]=500
			-- JY.Person[596]["生命最大值"]=9999
			-- JY.Person[596]["生命"]=9999
			-- JY.Person[596]["内力最大值"]=9999
			-- JY.Person[596]["内力"]=9999
			-- JY.Person[596]["拳掌功夫"]=100
			-- JY.Person[596]["御剑能力"]=100
			-- JY.Person[596]["指法技巧"]=100
			-- JY.Person[596]["耍刀技巧"]=100
			-- JY.Person[596]["特殊兵器"]=100
			-- JY.Person[596]["防具"]=-1
			-- JY.Person[596]["武功1"]=151
			-- JY.Person[596]["武功2"]=152
			-- JY.Person[596]["天赋内功"] = 152
			-- JY.Person[596]["天赋轻功"] = 179
			-- JY.Person[596]["武功2"]=152
			-- JY.Person[596]["武功等级2"]=999
	-- end
-- end	

--随机事件

function addthing(pp, num, flag)
	if num == nil then
		num = 1
	end
	if flag == 1 then
		instruct_32(pp, num)
	else
		instruct_2(pp, num)
	end
end

function randomthing()
	return (math.random(0, 35))
end

function randomwugong2(aa, bb, flag)
	aa = math.modf(aa * 100)
	bb = math.modf(bb * 100)		
	local thing = -1
	local lv = -1
	while true do
		thing = math.random(64, 390) --JY.ThingNum - 1
		if JY.Thing[thing]["练出武功"] > 0 then
			lv = JY.Wugong[JY.Thing[thing]["练出武功"]]["攻击力10"]
			if lv == 0 and flag == nil then
				lv = 1000
			end			
			if aa <= lv and lv <= bb then
				break
			end
		end
	end
	return thing
end

function randomPD(tt)
	local max = 0
	for i = 1, #tt do
		max = max + tt[i]
	end
	local event = math.random(max)
	local count = 0
	local result = 1
	for i = 1, #tt do
		if event > count and event <= tt[i] + count then
			result = i
			break
		end
		count = tt[i] + count
	end
	return result
end

function changeattrib(id, str, flag) -- flag 0 - random, 1 - +, 2 - -
	local change = 0
	local word = "增加"
	if math.random(50) <= 5 or flag == 2 then
		change = 1
		word = "减少"
	end
	if flag == 1 then
		change = 0
		word = "增加"
	end
	local number = math.random(0, 3)
	if str == "攻击力" or str == "轻功" or str == "防御力" then
		number = number + 2
	end
	if change == 1 then
		number = math.modf(number * -1)
	end	
	AddPersonAttrib(id, str, number)
	return JY.Person[id]["姓名"].."的"..str..word..math.abs(number).."点"
end

OEVENTLUA[30050] = function() --奇遇总汇
	local pd = math.modf((101 - JY.Person[0]["资质"]) * 0.1)
	if GetS(106, 63, 0, 0) >= math.modf(pd + 1 + 1 * JY.Base["天书数量"]) then
		do return end
	end
	local yes = 0
	if math.random(50) == 25 then
		yes = 1
	end
	if yes == 0 then
		do return end
	end
	if yes == 1 then
		local bonus = JY.Base["天书数量"]
		local bonus2 = math.modf((101 - JY.Person[0]["资质"]) * 0.1)
		local lv = randomPD({10, 9, 8, 7, 6, 5, 4, 3, 2, 1})
		local prob = {
			{70 - bonus - bonus2, 15, 10, 0, 0, 5, 0}, --1
			{60 - bonus - bonus2, 15, 10, 5, 0, 10, 0}, --2
			{50 - bonus - bonus2, 15, 10, 10, 5, 10, 0}, --3
			{50 - bonus, 15 + bonus2, 10, 10, 5, 10 + bonus2, 0}, --4
			{40 - bonus, 15, 10, 10 + bonus2, 10 + bonus2, 15 + bonus2, 0}, --5
			{30 - bonus, 15, 10, 15 + bonus2, 15 + bonus2, 15, 0}, --6
			{20 - bonus, 15, 10, 20 + bonus2, 20 + bonus2, 15, 0}, --7
			{20 - bonus, 15, 10, 20 + bonus2, 25 + bonus2, 5, 5 + bonus2}, --8
			{20 - bonus, 10, 0, 25 + bonus2, 35 + bonus2, 0, 10 + bonus2}, --9
			{15 - bonus, 10, 0, 25 + bonus2, 25 + bonus2, 0, 25 + bonus2}, --10
		}
		local qy = randomPD(prob[lv])
		--while qy == 3 do
		--	qy = randomPD(prob[lv]) -- 测试
		--end
		if qy == 1 then
			OEVENTLUA[30051](lv)
		elseif qy == 2 then
			local tmp = lv - 2
			if tmp <= 0 then
				tmp = 1
			end
			if lv > 11 then
				lv = 15
				tmp = 9
			end
			if lv == tmp then
				lv = lv + 1
			end
			OEVENTLUA[30052](tmp, lv)
		elseif qy == 3 then
			OEVENTLUA[30053]()
		elseif qy == 4 then
			OEVENTLUA[30054]()
		elseif qy == 5 then
			OEVENTLUA[30055]()
		elseif qy == 6 then
			OEVENTLUA[30056]()
		elseif qy == 7 then
			-- local tmp = lv
			-- if lv == 10 then
				-- lv = 15
			-- end
			--OEVENTLUA[30057](tmp, lv)	
			OEVENTLUA[30051](lv)
		end	
		SetS(106, 63, 0, 0, GetS(106, 63, 0, 0) + 1)
	end	
end

OEVENTLUA[30051] = function(aa) --捡物品
	Cls()
	say("咦？地上好像有什么东西....",0,4)
	local times = math.random(aa) + 1
	for i = 1, times do
		if math.random(100) <= 30 then
			addthing(174, math.random(100, 1000))		
		else
			local thing = randomthing()
			addthing(thing, math.random(1, 3))		
		end
	end
	say("哈哈！赚到了赚到了！",0,4)
end

OEVENTLUA[30052] = function(aa, bb) --捡武功
		Cls()
	say("咦？地上好像有什么东西....",0,4)
	local times = math.random(aa,bb) + 1
    addthing(174, math.random(1000,3000))
	instruct_2(210, times)
	instruct_2(209, times)
	say("哈哈！赚到了赚到了！",0,4)
end

OEVENTLUA[30053] = function() --挑战
	local teamnum = 1
	local enemy = -1
	local prot = -1
	for i = 2, CC.TeamNum do
		if JY.Base["队伍" .. i] > 0 then
			teamnum = teamnum + 1
		end
	end
	prot = JY.Base["队伍" .. math.random(teamnum)]
	Cls()
	say("站住！久闻"..JY.Person[prot]["姓名"].."大名，在下不才，倒想领教一番！", math.random(100, 200), 0, "江湖客")
	AddPersonAttrib(prot, "实战", 25)
	QZXS(JY.Person[prot]["姓名"].."实战增加25点！")
end

OEVENTLUA[30054] = function() --捡药
	local money = math.random(5) * 500
	local head = math.random(350, 360)
	Cls()
	say("这位少侠，我这里有秘制的灵丹，可以助你增进修为。现在只要"..money.."两银子。不知道你有没有兴趣？", head, 0, "商人")
	Cls()
	if DrawStrBoxYesNo(-1, -1, "要给钱么？", C_WHITE, 30) == false then	
		say("我看起来像是这么好骗的人吗？一边去！",0,4)	
		do return end
	end
	Cls()
	if instruct_31(money) == false then
		say("原来是个穷鬼，浪费我时间！", head, 0, "商人")
		do return end
	end
	Cls()
	say("我买了！",0,4)	
	instruct_2(174, -money)
	Cls()
	QZXS(changeattrib(0, "攻击力", 0))
	Cls()
	QZXS(changeattrib(0, "轻功", 0))
	Cls()
	QZXS(changeattrib(0, "防御力", 0))	
end

--[[
OEVENTLUA[30055] = function() --遇大侠
	local money = math.random(5) * 1000
	local head = math.random(350, 575)
	Cls()
	say("这位少侠，我正在开班授徒，只需要"..money.."两银子，你有兴趣吗？", head, 0, "大侠")
	Cls()
	if DrawStrBoxYesNo(-1, -1, "要给钱么？", C_WHITE, 30) == false then	
		say("我看起来像是这么好骗的人吗？一边去！")	
		do return end
	end
	Cls()
	if JY.GOLD < money then
		say("原来是个穷鬼，浪费我时间！", head, 0, "大侠")
		do return end
	end
	Cls()
	say("我要报名！")	
	instruct_2(174, -money)
	Cls()
	QZXS(changeattrib(0, "拳掌功夫", 0))
	Cls()
	QZXS(changeattrib(0, "御剑能力", 0))
	Cls()
	QZXS(changeattrib(0, "耍刀技巧", 0))		
	Cls()
	QZXS(changeattrib(0, "特殊兵器", 0))		
	Cls()
	QZXS(changeattrib(0, "暗器技巧", 0))			
end
]]

OEVENTLUA[30055] = function() --遇大侠
	local money = math.random(3) * 1000
	local head = math.random(350, 360)
	Cls()
	say("本大侠的补习班，只需要"..money.."两银子，有兴趣吗？", head, 0, "大侠")
	Cls()
	if DrawStrBoxYesNo(-1, -1, "要给钱么？", C_WHITE, 30) == false then	
		say("我看起来像是这么好骗的人吗？一边去！",0,4)	
		do return end
	end
	Cls()
	if instruct_31(money) == false then
		say("原来是个穷鬼，浪费我时间！", head, 0, "大侠")
		do return end
	end
	Cls()
	say("我要报名！",0,4)	
	instruct_2(174, -money)
	Cls()
    local x1 = CC.MainSubMenuX
    local y1 = CC.MainSubMenuY + CC.SingleLineHeight
    CC.DYRW = -1
    CC.DYRW2 = -1
	DrawStrBox(x1, y1, "想让谁跟大侠学习下呢？",C_WHITE, CC.DefaultFont);
	local menu = {}
	local menu2 = {}
	local id = -1
	for i = 1, CC.TeamNum do
		menu[i] = {"", nil, 0}
		id = JY.Base["队伍" .. i]	
		if id >= 0  then
			menu[i] = { JY.Person[id]["姓名"], nil, 1}
		end
	end
	local numItem = #menu;
	local size = CC.DefaultFont;
	local r = ShowMenu(menu,numItem,0,x1,y1+40,0,0,1,1,size,C_ORANGE,C_WHITE);	
        id = JY.Base["队伍" .. r]
	CC.DYRW = id
        local aa = math.random(1, 7)
        AddPersonAttrib(id, "拳掌功夫", aa)
	QZXS(JY.Person[id]["姓名"].."拳掌功夫增加".. aa.."点！")        
        local bb = math.random(1, 7)
        AddPersonAttrib(id, "御剑能力", bb)
	QZXS(JY.Person[id]["姓名"].."御剑能力增加".. bb.."点！")      
        local cc = math.random(1, 7)
        AddPersonAttrib(id, "耍刀技巧", cc)
	QZXS(JY.Person[id]["姓名"].."耍刀技巧增加".. cc.."点！")      
        local dd = math.random(1, 7)
        AddPersonAttrib(id, "特殊兵器", dd)
	QZXS(JY.Person[id]["姓名"].."特殊兵器增加".. dd.."点！")      
        local ee = math.random(1, 7)
        AddPersonAttrib(id, "指法技巧", ee)
	QZXS(JY.Person[id]["姓名"].."指法技巧增加".. ee.."点！")      
end

OEVENTLUA[30056] = function() --遇铁匠
	local money = math.random(3) * 500
	local head = math.random(350, 360)
	Cls()
	say("这位少侠，我可以帮你锻炼身上的神兵利器，只需要"..money.."两银子，你有兴趣吗？", head, 0, "铁匠")
	Cls()
	if DrawStrBoxYesNo(-1, -1, "要给钱么？", C_WHITE, 30) == false then	
		say("我看起来像是这么好骗的人吗？一边去！",0,4)	
		do return end
	end
	Cls()
	if instruct_31(money) == false then
		say("原来是个穷鬼，浪费我时间！", head, 0, "铁匠")
		do return end
	end
	Cls()
    local thing = {}
    local thingnum = {}
    for i = 0, CC.MyThingNum - 1 do
      thing[i] = -1
      thingnum[i] = 0
    end
    local num = 0
    for i = 0, CC.MyThingNum - 1 do
      local id = JY.Base["物品" .. i + 1]
      if id >= 0 then
		if JY.Thing[id]["类型"] == 1 then
		  thing[num] = id
		  thingnum[num] = JY.Base["物品数量" .. i + 1]
		  num = num + 1
		end
      end 
    end
    local r = 0
	r = SelectThing(thing, thingnum)	
	if r < 1 then
		Cls()
		say("不要就算了！", head, 0, "铁匠")
		do return end
	end
	
	Cls()
	say("那就拜托了。",0,4)	
	instruct_2(174, -money)
	Cls()
	local aa, bb
	aa = math.random(0, 2) * 1
	bb = aa
	JY.Thing[r]["加攻击力"] = JY.Thing[r]["加攻击力"] + aa
	QZXS(JY.Thing[r]["名称"].."增加攻击力".. bb.."点")
	aa = math.random(0, 2) * 1
	bb = aa
	JY.Thing[r]["加防御力"] = JY.Thing[r]["加防御力"] + aa
	QZXS(JY.Thing[r]["名称"].."增加防御力".. bb.."点")	
	aa = math.random(0, 2) * 1
	bb = aa
	JY.Thing[r]["加轻功"] = JY.Thing[r]["加轻功"] + aa
	QZXS(JY.Thing[r]["名称"].."增加轻功".. bb.."点")
end

OEVENTLUA[30057] = function(aa, bb) --洗武功
	local head = math.random(350, 360)
	Cls()
	say("糟糕....好像迷路了。啊，怎么又下起雨来了，怎么办....",0,4)	
	Cls()
	say("前面好像有个山洞，不管了，先进去避一避再说。",0,4)		
	Cls()
	say("这位少侠....", head, 0, "？？？")
	Cls()
	say("啊！吓我一跳....老前辈，你住在这里？",0,4)	
	Cls()
	say("我在此隐居多年，还从来没有人找到过这里。你我有缘，我传你一些武功如何？", head, 0, "？？？")	
	Cls()
	say("真的假的....山谷里的奇遇？我难道真的是主角？",0,4)	
	if DrawStrBoxYesNo(-1, -1, "要接受么？", C_WHITE, 30) == false then	
		Cls()
		say("多谢前辈，只是晚辈以为，武学之道贵精不贵多，前辈的好意晚辈心领了。",0,4)	
		Cls()
		say("也罢，你既然有此眼界，我也不勉强你了。", head, 0, "？？？")			
		do return end
	end
	Cls()
	say("让我看看你的基础如何。", head, 0, "？？？")
	local thing, wugong = -1
	local hasit = 1	
	local count = 0
	while hasit == 1 do
		thing = randomwugong2(aa, bb)
		wugong = JY.Thing[thing]["练出武功"]
		hasit = 0
		for i = 1, 12 do
			if JY.Person[0]["武功"..i] > 0 and JY.Person[0]["武功"..i] == wugong then
				hasit = 1			
			end
		end
		count = count + 1
		if count >= 100 then
			break
		end
	end
	if count >= 100 then
		Cls()
		say("你小小年纪，竟然已经练到如此境界。真是后生可畏。", head, 0, "？？？")	
		Cls()
		say("我没有东西可以教你了，你还是早日上路完成你的使命吧。", head, 0, "？？？")	
		do return end
	end
	Cls()
	say("基础不错，我就把这招"..JY.Wugong[wugong]["名称"].."传授给你，看好了。", head, 0, "？？？")		
	JY.Person[0]["武功1"] = wugong
	JY.Person[0]["武功等级1"] = 100 --math.random(750, 900) 武骧金星：取消这个没有意义的设置
	Cls()
	dark()
	light()
	QZXS(JY.Person[0]["姓名"].."领悟"..JY.Wugong[wugong]["名称"].."！")
	say("如何？看懂了吗？", head, 0, "？？？")	
	Cls()
	say("懂了。谢谢前辈指点。",0,4)	
	Cls()
	say("好，雨已经停了，你可以上路了。不要跟人说你见过我。", head, 0, "？？？")	
	Cls()
	say("是！前辈保重！",0,4)		
end


