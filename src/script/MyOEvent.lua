
	-- --���͵�ַ�б�
-- function My_ChuangSong_List()
	-- local menu = {};
	-- for i = 0, JY.SceneNum-1 do
		-- --����ʾ�ĳ�������������1 3 ���̵ص����߲��Թ�+ɳĮ����3�� ������ ˼���� ÷ׯ���� �󹦷��ؽ� ����ɽ�� ¹��ɽ1 3 ���ֺ�ɽ �ʹ� �������� �������� ��ɽ���� ����ȵ� ��Ĺ�ܵ� ��ü�� ȵ�� ��ɽ���
		-- --����� ���¶� ��ɽ�ض� ���ϳ����� ?
		-- if i == 5 or i == 85 or i == 13 or i == 14 or i == 15 or i == 86 or i == 88 or i == 89 
		-- or i == 28 or (i >= 81 and i <= 83) or i == 42 or i == 67 or i == 91 or i == 106 
		-- or i == 108 or i == 109 or i == 110 or i == 111 or i == 113 or i == 114 or i == 116 
		-- or i == 117 or i == 104 or i == 119 or i == 102 or i == 122 or i == 123 or i == 124 or i == 125 or i == 127 then
		
		-- else
			-- --�޾Ʋ���������i��Ϊ�������
			-- menu[i+1] = {JY.Scene[i]["����"], JY.Scene[i]["��������"], i, JY.Scene[i]["��������"]};	
		-- end
	-- end

	-- --��ɫ����Ϊ������ɫ��ѡ����ɫ
	-- local r = TeleportMenu(menu, C_GOLD, C_WHITE);
	
	-- --����ֵС��0��ESC����ֱ�ӷ���
	-- if r < 0 then
		-- return 0;
	-- end
	
	-- --����ֵ���ڵ���0������ֵ��Ϊ�������
	-- if r >= 0 then	
		-- local sid = r;

		-- if JY.Base["����"] == 5 and sid==43 then
			-- say("������Ҫ��ͨ�غ�ɽ��ᡣ", 119, 5, "����");	
			-- return 1;
		-- else
			-- My_Enter_SubScene(sid,-1,-1,-1);	
		-- end
	-- end
	-- return 1;
-- end

-- --��ǿ�洫�͵�ַ�˵�
-- function My_ChuangSong_Ex()     
	-- local title = "��Ӷ��";
	-- local str = JY.Person[0]["���"].."��ȥʲô�ط���*·����������*��ԶҲ�����͵�";
	-- local btn = {"ָ�㽭ɽ", "��������"};
	-- local num = #btn;
	-- local r = JYMsgBox(title,str,btn,num,119,1);
	-- if r == 1 then
		-- return My_ChuangSong_List();
	-- elseif r == 2 then
		-- Cls();
		-- local sid = InputNum("��������",0,JY.SceneNum-1,1);
		-- if sid ~= nil then			
			-- --��ע��������ʾ�ģ���������1 3 ���̵ص����߲��Թ�+ɳĮ����3�� ������ ˼���� ÷ׯ���� �󹦷��ؽ� ����ɽ�� ¹��ɽ1 3 ȵ�� ���ϳ����� ?
			-- if sid == 5 or sid == 85 or sid == 13 or sid == 14 or sid == 15 or sid == 86 or sid == 88 or sid == 89 
			-- or sid == 28 or (sid >= 81 and sid <= 83) or sid == 42 or sid == 67 or sid == 91 or sid == 106 
			-- or sid == 108 or sid == 109 or sid == 110 or sid == 111 or sid == 113 or sid == 114 or sid == 104 or sid == 124 or sid == 125 or JY.Scene[sid]["��������"] == 1 then
				-- say("������Ŀǰ���ܽ���˳�����", 119, 5, "����");
				-- return 1;
			-- elseif JY.Base["����"] == 5 and sid==43 then
			-- say("������Ҫ��ͨ�غ�ɽ��ᡣ", 119, 5, "����");	
				-- return 1;
			-- else
				-- My_Enter_SubScene(sid,-1,-1,-1);
			-- end
		-- end
	-- end
-- end

-- --��������
-- function LianGong(lx)
	-- JY.Person[591]["�ȼ�"] = 0
	-- JY.Person[591]["��������"] = lx
	-- JY.Person[591]["ͷ�����"] = math.random(190)
	-- JY.Person[591]["�������ֵ"] = 10
	-- JY.Person[591]["����"] = JY.Person[591]["�������ֵ"]
	-- instruct_6(226, 8, 0, 1)
	-- JY.Person[591]["��������"] = 0
	-- light()
	-- --return 1;
-- end

-- --�书��Ч˵��
-- function WuGongIntruce()
	-- local menu = {};
	
	-- for i = 1, JY.WugongNum-1 do
		-- menu[i] = {i..JY.Wugong[i]["����"], nil, 0}
	-- end
	
	-- --ӵ�е��ؼ�
	-- for i = 1, CC.MyThingNum do
    -- if JY.Base["��Ʒ" .. i] > -1 and JY.Base["��Ʒ����" .. i] > 0 then
    	-- local wg = JY.Thing[JY.Base["��Ʒ" .. i]]["�����书"];
    	-- if wg > 0 then
    		-- menu[wg][3] = 1;
    	-- end
    -- else
    	-- break;
    -- end
  -- end
  
  -- --ѧ����书
  -- for i=1, CC.TeamNum do
  	-- if JY.Base["����"..i] >= 0 then
  		-- for j=1, 10 do
  			-- if JY.Person[JY.Base["����"..i]]["�书"..j] > 0 then
  				-- menu[JY.Person[JY.Base["����"..i]]["�书"..j]][3] = 1;
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
		
		-- r = ShowMenu2(menu,JY.WugongNum-1,4,12,10,(CC.ScreenH-12*(CC.DefaultFont+CC.RowPixel))/2+20,0,0,1,1,CC.DefaultFont,C_ORANGE, C_WHITE, "��ѡ��鿴���书", r);
		-- --local r = ShowMenu(menu,n,15,CC.ScreenW/4,20,0,0,1,1,CC.DefaultFont,C_ORANGE, C_WHITE);
		
		-- if r > 0 and r < JY.WugongNum then	
			-- InstruceWuGong(r);
		-- else
			-- break;
		-- end
	-- end
	
-- end

-- --��ʾ�书���ڹ���Ч
-- function InstruceWuGong(id)
	-- if id < 0 or id >= JY.WugongNum then
		-- QZXS("�书δ֪�����޷��鿴");
		-- return;
	-- end
	-- local filename = string.format("%s%d.txt", CONFIG.WuGongPath,id)
	-- if existFile(filename) == false then
		-- QZXS("���书δ�����κ�˵������������ĥ");
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

-- --��ʾ�书���ڹ���Ч
-- function InstruceTS(id)
		
	-- local filename = string.format("%s%d.txt", CONFIG.HelpPath,id)
	-- if existFile(filename) == false then
		-- QZXS("δ�ҵ���صĹ����ļ�");
		-- return;
	-- end
	
	-- DrawTxt(filename);
-- end

-- function DrawTxt(filename)
	-- Cls();
	
	-- --��ȡ�ļ�˵��
	-- local file = io.open(filename,"r")
	-- local str = file:read("*a")
	-- file:close()
	
	-- local size = CC.DefaultFont;
	-- local color = C_WHITE;
	
	-- local linenum = 50;		--��ʾ����
	-- local maxlen = 14;
	-- local w = linenum*size/2 + size;
	-- local h = maxlen*(size+CC.RowPixel) + 2*CC.RowPixel;
	
	-- local bx = (CC.ScreenW-w)/2;
	-- local by = (CC.ScreenH-h)/2;
	-- DrawBox(bx,by,bx+w,by+h,C_WHITE);		--�ױ߿�
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
			
			-- if l+#v[1] < linenum and index == nil then		--���δ�����У�û���ҵ�����
				-- DrawString(x + l*size/2, y + row*(size+CC.RowPixel), v[1], v[2] or color, size);
				-- l = l + #v[1]

				-- if i == #strcolor then
					-- --��ʾ����	ALungky:j �ĳ� j+1�����ĩβ������ʱ���޷���ʾ�����⡣
					-- for j=0, l do
						-- lib.SetClip(x,y,x+(j+1)*size/2,y+size+row*(size+CC.RowPixel));
						-- ShowScreen(1);
					-- end
					-- lib.SetClip(0,0,0,0);
				-- end
				-- break;
			-- else	--����ﵽ����
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
				
				-- --��������ж��Ƿ��Ѿ�����v[1]��������ݲ���
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
					
	
					-- if math.fmod(flag,2) == 1 and index == nil  then		--��������е��ַ�
							-- if string.byte(tmp, -1) > 127 then
								-- tmp = string.sub(v[1], 1, pos1-1);
								-- pos2 = pos2 - 1
							-- end
					-- end
	
					-- v[1] = string.sub(v[1], pos2);
				-- end
					
	
					-- DrawString(x + l*size/2, y + row*(size+CC.RowPixel), tmp, v[2] or color, size);
	
	
					-- l = l + #tmp
					-- --��ʾ����
					-- for j=0, l do
						-- lib.SetClip(x,y,x+j*size/2,y+size+row*(size+CC.RowPixel));
						-- ShowScreen(1);
					-- end
					
					-- --����+1
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

-- --ʮ�ı�����֮��õ�5000��
-- --�޸��Զ�ϴ���񼼵�BUG
-- function NEvent2(keypress)
	-- if JY.SubScene == 70 and GetD(70, 3, 0) == 0 and instruct_18(151) then
		-- instruct_3(70, 3, 1, 0, 0, 0, 0, 2610, 2610, 2610, 0, -2, -2)
	-- end
	-- if GetD(70, 3, 5) == 2610 and JY.SubScene == 70 and JY.Base["��X1"] == 8 and JY.Base["��Y1"] == 41 and JY.Base["�˷���"] == 2 and (keypress == VK_SPACE or keypress == VK_RETURN) then
		-- say("���ף�����ֽ�������ȣ�"..JY.Person[0]["���2"].."���������������ǧ�����ӣ��ú�׼��һ�°ɣ��ȹ������ϼһﻹ�ܹ���˼�",0,1)
		-- instruct_2(174, 5000)
		-- SetS(10, 0, 17, 0, 1)
		-- SetD(83, 48, 4, 882)
	  -- if instruct_16(671) and PersonKF(0, 198) then
	    -- say("����������ô�࣬�ҷ·��������򡭡�",0,1)
		-- local s1 = JY.Wugong[JY.Person[0]["�书1"]]["����"]
		-- local s2 = JY.Wugong[JY.Person[0]["�书2"]]["����"]
		-- local s3 = JY.Wugong[JY.Person[0]["�书3"]]["����"]
		-- local s4 = JY.Wugong[JY.Person[0]["�书4"]]["����"]
	    -- local r = JYMsgBox("��ѡ��", "ѡ �� �� һ �� �� �� �� �� �� �� �� Ϊ�� �� Ѫ �� �� ��", {s1,s2,s3,s4,"����"}, 5, 20)
		-- if r == 1 then
			-- instruct_35(0, 0, 200, 999)
			-- DrawStrBoxWaitKey("�������ˡ��ǽ�Ѫ�����ϡ�", C_ORANGE, CC.DefaultFont, 2)
		-- elseif r == 2 then
			-- instruct_35(0, 1, 200, 999)
			-- DrawStrBoxWaitKey("�������ˡ��ǽ�Ѫ�����ϡ�", C_ORANGE, CC.DefaultFont, 2)
		-- elseif r == 3 then
			-- instruct_35(0, 2, 200, 999)
			-- DrawStrBoxWaitKey("�������ˡ��ǽ�Ѫ�����ϡ�", C_ORANGE, CC.DefaultFont, 2)
		-- elseif r == 4 then
			-- instruct_35(0, 3, 200, 999)
			-- DrawStrBoxWaitKey("�������ˡ��ǽ�Ѫ�����ϡ�", C_ORANGE, CC.DefaultFont, 2)
		-- end
		
	  -- else
		-- say("�����ﻹ��һ���ؼ������ҿ�һ�¡���",0,1)
		-- local hid = 0
		-- if JY.Base["��׼"] > 0 then
			-- if JY.Person[0]["�Ա�"] == 0 then
				-- hid = 280 + JY.Base["��׼"]
			-- else
				-- hid = 500 + JY.Base["��׼"]
			-- end
		-- elseif JY.Base["����"] > 0 then
			-- if JY.Person[0]["�Ա�"] == 0 then
				-- hid = 290
			-- else
				-- hid = 510
			-- end
		-- else
			-- hid = JY.Person[0]["ͷ�����"]
		-- end
		-- local r = JYMsgBox("��ѡ��", "�Ƿ�Ҫϴ��һ���书��*һ��Ұ��ȭ*������ɽ����*�������ϵ���*�ģ���������", {"һ","��","��","��","����"}, 5, hid)
		-- if r == 1 then
			-- instruct_35(0, 0, 109, 999)
			-- DrawStrBoxWaitKey("��ѧ���ˡ���Ұ��ȭ�ϡ�", C_ORANGE, CC.DefaultFont, 2)
			-- JY.Person[0]["�츳�⹦4"] = 109
		-- elseif r == 2 then
			-- instruct_35(0, 0, 110, 999)
			-- DrawStrBoxWaitKey("��ѧ���ˡ�����ɽ�����ϡ�", C_ORANGE, CC.DefaultFont, 2)
			-- JY.Person[0]["�츳�⹦4"] = 110
			-- instruct_2(55, 1)
		-- elseif r == 3 then
			-- instruct_35(0, 0, 111, 999)
			-- DrawStrBoxWaitKey("��ѧ���ˡ������ϵ����ϡ�", C_ORANGE, CC.DefaultFont, 2)
			-- JY.Person[0]["�츳�⹦4"] = 111
			-- instruct_2(56, 1)
		-- elseif r == 4 then
			-- instruct_35(0, 0, 112, 999)
			-- DrawStrBoxWaitKey("��ѧ���ˡ��Ǡ������գϡ�", C_ORANGE, CC.DefaultFont, 2)
			-- JY.Person[0]["�츳�⹦4"] = 112
			-- instruct_2(57, 1)
		-- end
	  -- end
		-- instruct_3(70, 3, 1, 0, 0, 0, 0, 2612, 2612, 2612, 0, -2, -2)
	-- end
-- end

-- --��� ���˷����ҽ���
-- function NEvent3(keypress)
	-- if JY.SubScene == 24 and JY.Base["��X1"] == 18 and JY.Base["��Y1"] == 23 and JY.Base["�˷���"] == 2 and (keypress == VK_SPACE or keypress == VK_RETURN) and GetS(10, 0, 3, 0) ~= 1 and instruct_16(1) and instruct_18(145) then
		-- say("������������Ѿ��ҵ�ѩɽ�ɺ��Ȿ���ˡ�", 1, 0)
		-- say("���ţ��ܺã�������ĺ��ҵ���Ҳ������¯�����ˣ��Ժ�Ľ����Ϳ�������Щ�����˵��ˣ��Ȿ��ҽ�������ȥ�ɣ�", 3,4)
		-- say("����л�������", 1, 0)
		-- instruct_35(1, 1, 44, 0)
		-- DrawStrBox(-1, -1, "���ѧ����ҽ���", C_ORANGE, CC.DefaultFont)
		-- ShowScreen()
		-- lib.Delay(800)
		-- Cls()
		-- instruct_2(117, 1)
		-- SetS(10, 0, 3, 0, 1)
	-- end
-- end

-- --��������
-- function NEvent4(keypress)
	-- if JY.SubScene == 7 and JY.Base["��X1"] == 34 and JY.Base["��Y1"] == 11 and JY.Base["�˷���"] == 2 then
		-- --������ڶӣ��оŽ��ؼ�
		-- if instruct_16(35) and instruct_18(114) and GetS(10, 1, 1, 0) ~= 1 and (keypress == VK_SPACE or keypress == VK_RETURN) then
			-- SetS(7, 34, 12, 3, 102)
			-- instruct_3(7, 102, 1, 0, 0, 0, 0, 7148, 7148, 7148, 0, 34, 12)
			-- say("�����֣����������ʶһ�¶���ǰ���ķ�ɰ�������ܸо����ԾŽ������µ����򣬵��ֺ�ģ�������ܾ����ܽ������", 35, 1)
			-- say("������������������ʱ���ˣ�", 140, 0)
			-- say("����̫ʦ�壡����", 35,1)
			-- instruct_14()
			-- SetS(7, 33, 12, 3, 101)
			-- instruct_3(7, 101, 1, 0, 0, 0, 0, 5896, 5896, 5896, 0, 33, 12)
			-- instruct_13()
			-- PlayMIDI(24)
			-- lib.Delay(500)
			-- say("�����������һ�𳪣��׺�һ��Ц����������������������ֻ�ǽ񳯡�����Ц���׷����ϳ���˭��˭ʤ����֪������ɽЦ������ң�������Ծ��쳾����֪���١����Ц���Ǽ��ȡ����黹ʣһ�����ա�����Ц�����ټ��ȡ��������ڳճ�ЦЦ", 140, 0)
			-- say("��������Ž��ļ�������������׸��У����Ѻú�ȥ���ɣ��Ϸ���Ը���ˣ��Ӵ�����ǣ�ң��ʹ�ȥҲ��������������", 140, 0)
			-- say("����л̫ʦ�崫���������˼Ҷౣ�أ��ţ������������Ž��İ���ɣ�������", 35, 1)
			-- instruct_14()
			-- instruct_3(7, 101, 0, 0, 0, 0, 0, -1, -1, -1, 0, 33, 12)
			-- instruct_13()
			-- DrawStrBox(-1, -1, "���պ�", C_ORANGE, CC.DefaultFont)
			-- ShowScreen()
			-- lib.Delay(500)
			-- say("�����ˣ�����������Ķ��¾Ž���������������ѧ������ǰ��֮�񼼣��򸴺κ���", 35, 1)
			-- DrawStrBox(-1, -1, "���������Ž�֮�ش�", C_ORANGE, CC.DefaultFont)
			-- ShowScreen()
			-- lib.Delay(500)
			-- Cls()
			-- awakening(35, 1)	--�����ڶ��ξ���
			-- DrawStrBox(-1, -1, "�����ƺű��", C_ORANGE, CC.DefaultFont)
			-- ShowScreen()
			-- lib.Delay(500)
			-- Cls()
			-- SetS(10, 1, 1, 0, 1)
			-- instruct_3(7, 102, 0, 0, 0, 0, 0, -1, -1, -1, 0, 34, 12)
		-- end
	-- end
-- end

-- --ɽ���¼�
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

-- --�������SYP�Զ�����
-- function NEvent10(keypress)
  -- if JY.SubScene == 25 and GetS(10, 0, 9, 0) ~= 1 then
    -- SetS(25, 9, 44, 3, 103)
    -- instruct_3(25, 103, 1, 0, 0, 0, 0, 4133*2, 4133*2, 4133*2, 0, -2, -2)
    -- if JY.Base["��X1"] == 10 and JY.Base["��Y1"] == 44 and JY.Base["�˷���"] == 2 and (keypress == VK_SPACE or keypress == VK_RETURN) and GetD(25, 82, 5) == 4662 then
      -- say("��һ·����������������ˣ������������ɡ�",347,0,"л����");
      -- instruct_14()
      -- for i = 79, 92 do
          -- instruct_3(25, i, 1, 0, 0, 0, 0, 4664, 4664, 4664, 0, -2, -2)
      -- end
      -- for ii = CC.BookStart, CC.BookStart + CC.BookNum -1 do
          -- instruct_32(ii, -10)
      -- end
	  -- JY.Base["��������"] = 15
      -- instruct_3(25, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2)
      -- instruct_3(25, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2)
      -- instruct_13()
      -- say("�����Ѿ��ź��ˣ���������ų�ȥ�ɡ�", 347,0,"л����");
      -- SetS(10, 0, 9, 0, 1)
      -- instruct_3(25, 103, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2)
      
    -- end
  -- end
-- end

-- --�󹦷� ��Ԭ��־�Ի��󣬽��߽��黹
-- function NEvent12(keypress)
	-- if JY.SubScene == 95 and GetD(95, 4, 5) ~= 0 and JY.Thing[40]["ʹ����"] ~= -1 then
		-- JY.Person[JY.Thing[40]["ʹ����"]]["����"] = -1
		-- JY.Thing[40]["ʹ����"] = -1
	-- end
-- end

-- --ɽ��Ů���ǵľ���
-- function mm4R()
	-- say("�������أ������ӿ��ˡ�", 0,0,JY.Person[0]["����"])
	-- say("������ɽ�Ѿ�����ҵ������ˣ��㻻һ���ɡ�", 290,1,"�޾Ʋ���")
	-- say("���Ҿ��Ƕ�������������ȥ��Ҳ����Ҫ�������ѵģ�", 0,0,JY.Person[0]["����"])
	-- local player_type = JYMsgBox3("����ѡ��", "ѡ������Ҫ�Ķ���*", {"����ң","�����","������","��ū","��̫��"}, 5, 290)
	-- ClsN()
	-- instruct_14()
	-- if player_type == 1 then
		-- if instruct_20(20, 0) == false then
    -- instruct_10(655)
		-- end
	-- instruct_13()
	-- say("������", 0,0,JY.Person[0]["����"])
	-- elseif player_type == 2 then
	-- instruct_14()
		-- if instruct_20(20, 0) == false then
    -- instruct_10(656)
		-- end
	-- instruct_13()
	-- say("������", 0,0,JY.Person[0]["����"])
	-- elseif player_type == 3 then
	-- instruct_14()
		-- if instruct_20(20, 0) == false then
    -- instruct_10(657)
		-- end
	-- instruct_13()
	-- say("������", 0,0,JY.Person[0]["����"])
	-- elseif player_type == 4 then
	-- instruct_14()
		-- if instruct_20(20, 0) == false then
    -- instruct_10(658)
		-- end
	-- instruct_13()
	-- say("������", 0,0,JY.Person[0]["����"])
	-- elseif player_type == 5 then
	-- PlayMIDI(121)
	-- instruct_14()
	-- instruct_13()
	-- say("���ҽ��վ�Ҫ�����ߣ������±߸��������ҡ�", 0,0,JY.Person[0]["����"])
	-- if JY.Base["����"] == 1 then
	-- say("�������ҵ���ķ�ɣ���ȥ�ɡ�", 290,1,"�޾Ʋ���")	
			-- if JY.Person[0]["�Ա�"]==0 then
				-- instruct_2(321, 1)  --����ɽ
			-- else
				-- instruct_2(322, 1)  --����ɽ
			-- end
	-- else
	-- say("��ֻ��ǿ�߲���ӵ������ɽ������һ�ɹ����������档", 290,1,"�޾Ʋ���")
			-- JY.Person[596]["����"] = "�޾Ʋ���"
			-- JY.Person[596]["ͷ�����"] = 355
			-- JY.Person[596]["�������ֵ"]=5000
			-- JY.Person[596]["����"]=5000
			-- JY.Person[596]["�������ֵ"]=5000
			-- JY.Person[596]["����"]=5000
			-- JY.Person[596]["������"]=250
			-- JY.Person[596]["������"]=250
			-- JY.Person[596]["�Ṧ"]=250
			-- JY.Person[596]["ȭ�ƹ���"]=50
			-- JY.Person[596]["��������"]=50
			-- JY.Person[596]["ָ������"]=50
			-- JY.Person[596]["ˣ������"]=50
			-- JY.Person[596]["�������"]=50
			-- JY.Person[596]["����"]=322
			-- JY.Person[596]["�츳�ڹ�"] = -1
			-- JY.Person[596]["�츳�Ṧ"] = -1
			-- JY.Person[596]["�书2"]=0
			-- JY.Person[596]["�书�ȼ�2"]=999
		-- if WarMain(245) then
			-- light()
			-- say("����Ĳ���", 290,1,"�޾Ʋ���")
			-- if JY.Person[0]["�Ա�"]==0 then
				-- instruct_2(321, 1)  --����ɽ
			-- else
				-- instruct_2(322, 1)  --����ɽ
			-- end
		-- else
			-- light()
			-- say("��СС�ͽ�һ��", 290,1,"�޾Ʋ���")
			-- ShowScreen()
					-- lib.Delay(80)
					-- lib.ShowSlow(15, 1)
					-- Cls()
					-- lib.ShowSlow(50, 0)
					-- JY.Person[0]["�Ա�"] = 2
					-- local add, str = AddPersonAttrib(0, "������", -20)
					-- DrawStrBoxWaitKey(JY.Person[0]["����"] .. str, C_ORANGE, CC.DefaultFont)
					-- add, str = AddPersonAttrib(0, "������", -30)
					-- DrawStrBoxWaitKey(JY.Person[0]["����"] .. str, C_ORANGE, CC.DefaultFont)
						-- JY.Person[0]["���"] = "����"
						-- JY.Person[0]["���2"] = "Ѿͷ"
						-- JY.Person[0]["ͷ�����"] = 303
						-- local f_ani = {
						-- {0, 0, 0}, 
						-- {0, 0, 0}, 
						-- {10, 8, 6}, 
						-- {0, 0, 0}, 
						-- {0, 0, 0}}
						-- for i = 1, 5 do
							-- JY.Person[0]["���ж���֡��" .. i] = f_ani[i][1]
							-- JY.Person[0]["���ж����ӳ�" .. i] = f_ani[i][3]
							-- JY.Person[0]["�书��Ч�ӳ�" .. i] = f_ani[i][2]
						-- end
				-- end
		-- end
			-- JY.Person[596]["����"] = "л����"
			-- JY.Person[596]["ͷ�����"] = 347
			-- JY.Person[596]["������"]=500
			-- JY.Person[596]["������"]=500
			-- JY.Person[596]["�Ṧ"]=500
			-- JY.Person[596]["�������ֵ"]=9999
			-- JY.Person[596]["����"]=9999
			-- JY.Person[596]["�������ֵ"]=9999
			-- JY.Person[596]["����"]=9999
			-- JY.Person[596]["ȭ�ƹ���"]=100
			-- JY.Person[596]["��������"]=100
			-- JY.Person[596]["ָ������"]=100
			-- JY.Person[596]["ˣ������"]=100
			-- JY.Person[596]["�������"]=100
			-- JY.Person[596]["����"]=-1
			-- JY.Person[596]["�书1"]=151
			-- JY.Person[596]["�书2"]=152
			-- JY.Person[596]["�츳�ڹ�"] = 152
			-- JY.Person[596]["�츳�Ṧ"] = 179
			-- JY.Person[596]["�书2"]=152
			-- JY.Person[596]["�书�ȼ�2"]=999
	-- end
-- end	

--����¼�

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
		if JY.Thing[thing]["�����书"] > 0 then
			lv = JY.Wugong[JY.Thing[thing]["�����书"]]["������10"]
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
	local word = "����"
	if math.random(50) <= 5 or flag == 2 then
		change = 1
		word = "����"
	end
	if flag == 1 then
		change = 0
		word = "����"
	end
	local number = math.random(0, 3)
	if str == "������" or str == "�Ṧ" or str == "������" then
		number = number + 2
	end
	if change == 1 then
		number = math.modf(number * -1)
	end	
	AddPersonAttrib(id, str, number)
	return JY.Person[id]["����"].."��"..str..word..math.abs(number).."��"
end

OEVENTLUA[30050] = function() --�����ܻ�
	local pd = math.modf((101 - JY.Person[0]["����"]) * 0.1)
	if GetS(106, 63, 0, 0) >= math.modf(pd + 1 + 1 * JY.Base["��������"]) then
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
		local bonus = JY.Base["��������"]
		local bonus2 = math.modf((101 - JY.Person[0]["����"]) * 0.1)
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
		--	qy = randomPD(prob[lv]) -- ����
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

OEVENTLUA[30051] = function(aa) --����Ʒ
	Cls()
	say("�ף����Ϻ�����ʲô����....",0,4)
	local times = math.random(aa) + 1
	for i = 1, times do
		if math.random(100) <= 30 then
			addthing(174, math.random(100, 1000))		
		else
			local thing = randomthing()
			addthing(thing, math.random(1, 3))		
		end
	end
	say("������׬����׬���ˣ�",0,4)
end

OEVENTLUA[30052] = function(aa, bb) --���书
		Cls()
	say("�ף����Ϻ�����ʲô����....",0,4)
	local times = math.random(aa,bb) + 1
    addthing(174, math.random(1000,3000))
	instruct_2(210, times)
	instruct_2(209, times)
	say("������׬����׬���ˣ�",0,4)
end

OEVENTLUA[30053] = function() --��ս
	local teamnum = 1
	local enemy = -1
	local prot = -1
	for i = 2, CC.TeamNum do
		if JY.Base["����" .. i] > 0 then
			teamnum = teamnum + 1
		end
	end
	prot = JY.Base["����" .. math.random(teamnum)]
	Cls()
	say("վס������"..JY.Person[prot]["����"].."���������²��ţ��������һ����", math.random(100, 200), 0, "������")
	AddPersonAttrib(prot, "ʵս", 25)
	QZXS(JY.Person[prot]["����"].."ʵս����25�㣡")
end

OEVENTLUA[30054] = function() --��ҩ
	local money = math.random(5) * 500
	local head = math.random(350, 360)
	Cls()
	say("��λ�����������������Ƶ��鵤����������������Ϊ������ֻҪ"..money.."�����ӡ���֪������û����Ȥ��", head, 0, "����")
	Cls()
	if DrawStrBoxYesNo(-1, -1, "Ҫ��Ǯô��", C_WHITE, 30) == false then	
		say("�ҿ�����������ô��ƭ������һ��ȥ��",0,4)	
		do return end
	end
	Cls()
	if instruct_31(money) == false then
		say("ԭ���Ǹ�����˷���ʱ�䣡", head, 0, "����")
		do return end
	end
	Cls()
	say("�����ˣ�",0,4)	
	instruct_2(174, -money)
	Cls()
	QZXS(changeattrib(0, "������", 0))
	Cls()
	QZXS(changeattrib(0, "�Ṧ", 0))
	Cls()
	QZXS(changeattrib(0, "������", 0))	
end

--[[
OEVENTLUA[30055] = function() --������
	local money = math.random(5) * 1000
	local head = math.random(350, 575)
	Cls()
	say("��λ�����������ڿ�����ͽ��ֻ��Ҫ"..money.."�����ӣ�������Ȥ��", head, 0, "����")
	Cls()
	if DrawStrBoxYesNo(-1, -1, "Ҫ��Ǯô��", C_WHITE, 30) == false then	
		say("�ҿ�����������ô��ƭ������һ��ȥ��")	
		do return end
	end
	Cls()
	if JY.GOLD < money then
		say("ԭ���Ǹ�����˷���ʱ�䣡", head, 0, "����")
		do return end
	end
	Cls()
	say("��Ҫ������")	
	instruct_2(174, -money)
	Cls()
	QZXS(changeattrib(0, "ȭ�ƹ���", 0))
	Cls()
	QZXS(changeattrib(0, "��������", 0))
	Cls()
	QZXS(changeattrib(0, "ˣ������", 0))		
	Cls()
	QZXS(changeattrib(0, "�������", 0))		
	Cls()
	QZXS(changeattrib(0, "��������", 0))			
end
]]

OEVENTLUA[30055] = function() --������
	local money = math.random(3) * 1000
	local head = math.random(350, 360)
	Cls()
	say("�������Ĳ�ϰ�ֻ࣬��Ҫ"..money.."�����ӣ�����Ȥ��", head, 0, "����")
	Cls()
	if DrawStrBoxYesNo(-1, -1, "Ҫ��Ǯô��", C_WHITE, 30) == false then	
		say("�ҿ�����������ô��ƭ������һ��ȥ��",0,4)	
		do return end
	end
	Cls()
	if instruct_31(money) == false then
		say("ԭ���Ǹ�����˷���ʱ�䣡", head, 0, "����")
		do return end
	end
	Cls()
	say("��Ҫ������",0,4)	
	instruct_2(174, -money)
	Cls()
    local x1 = CC.MainSubMenuX
    local y1 = CC.MainSubMenuY + CC.SingleLineHeight
    CC.DYRW = -1
    CC.DYRW2 = -1
	DrawStrBox(x1, y1, "����˭������ѧϰ���أ�",C_WHITE, CC.DefaultFont);
	local menu = {}
	local menu2 = {}
	local id = -1
	for i = 1, CC.TeamNum do
		menu[i] = {"", nil, 0}
		id = JY.Base["����" .. i]	
		if id >= 0  then
			menu[i] = { JY.Person[id]["����"], nil, 1}
		end
	end
	local numItem = #menu;
	local size = CC.DefaultFont;
	local r = ShowMenu(menu,numItem,0,x1,y1+40,0,0,1,1,size,C_ORANGE,C_WHITE);	
        id = JY.Base["����" .. r]
	CC.DYRW = id
        local aa = math.random(1, 7)
        AddPersonAttrib(id, "ȭ�ƹ���", aa)
	QZXS(JY.Person[id]["����"].."ȭ�ƹ�������".. aa.."�㣡")        
        local bb = math.random(1, 7)
        AddPersonAttrib(id, "��������", bb)
	QZXS(JY.Person[id]["����"].."������������".. bb.."�㣡")      
        local cc = math.random(1, 7)
        AddPersonAttrib(id, "ˣ������", cc)
	QZXS(JY.Person[id]["����"].."ˣ����������".. cc.."�㣡")      
        local dd = math.random(1, 7)
        AddPersonAttrib(id, "�������", dd)
	QZXS(JY.Person[id]["����"].."�����������".. dd.."�㣡")      
        local ee = math.random(1, 7)
        AddPersonAttrib(id, "ָ������", ee)
	QZXS(JY.Person[id]["����"].."ָ����������".. ee.."�㣡")      
end

OEVENTLUA[30056] = function() --������
	local money = math.random(3) * 500
	local head = math.random(350, 360)
	Cls()
	say("��λ�������ҿ��԰���������ϵ����������ֻ��Ҫ"..money.."�����ӣ�������Ȥ��", head, 0, "����")
	Cls()
	if DrawStrBoxYesNo(-1, -1, "Ҫ��Ǯô��", C_WHITE, 30) == false then	
		say("�ҿ�����������ô��ƭ������һ��ȥ��",0,4)	
		do return end
	end
	Cls()
	if instruct_31(money) == false then
		say("ԭ���Ǹ�����˷���ʱ�䣡", head, 0, "����")
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
      local id = JY.Base["��Ʒ" .. i + 1]
      if id >= 0 then
		if JY.Thing[id]["����"] == 1 then
		  thing[num] = id
		  thingnum[num] = JY.Base["��Ʒ����" .. i + 1]
		  num = num + 1
		end
      end 
    end
    local r = 0
	r = SelectThing(thing, thingnum)	
	if r < 1 then
		Cls()
		say("��Ҫ�����ˣ�", head, 0, "����")
		do return end
	end
	
	Cls()
	say("�ǾͰ����ˡ�",0,4)	
	instruct_2(174, -money)
	Cls()
	local aa, bb
	aa = math.random(0, 2) * 1
	bb = aa
	JY.Thing[r]["�ӹ�����"] = JY.Thing[r]["�ӹ�����"] + aa
	QZXS(JY.Thing[r]["����"].."���ӹ�����".. bb.."��")
	aa = math.random(0, 2) * 1
	bb = aa
	JY.Thing[r]["�ӷ�����"] = JY.Thing[r]["�ӷ�����"] + aa
	QZXS(JY.Thing[r]["����"].."���ӷ�����".. bb.."��")	
	aa = math.random(0, 2) * 1
	bb = aa
	JY.Thing[r]["���Ṧ"] = JY.Thing[r]["���Ṧ"] + aa
	QZXS(JY.Thing[r]["����"].."�����Ṧ".. bb.."��")
end

OEVENTLUA[30057] = function(aa, bb) --ϴ�书
	local head = math.random(350, 360)
	Cls()
	say("���....������·�ˡ�������ô�����������ˣ���ô��....",0,4)	
	Cls()
	say("ǰ������и�ɽ���������ˣ��Ƚ�ȥ��һ����˵��",0,4)		
	Cls()
	say("��λ����....", head, 0, "������")
	Cls()
	say("��������һ��....��ǰ������ס�����",0,4)	
	Cls()
	say("���ڴ����Ӷ��꣬������û�����ҵ������������Ե���Ҵ���һЩ�书��Σ�", head, 0, "������")	
	Cls()
	say("��ļٵ�....ɽ��������������ѵ���������ǣ�",0,4)	
	if DrawStrBoxYesNo(-1, -1, "Ҫ����ô��", C_WHITE, 30) == false then	
		Cls()
		say("��лǰ����ֻ������Ϊ����ѧ֮���󾫲���࣬ǰ���ĺ����������ˡ�",0,4)	
		Cls()
		say("Ҳ�գ����Ȼ�д��۽磬��Ҳ����ǿ���ˡ�", head, 0, "������")			
		do return end
	end
	Cls()
	say("���ҿ�����Ļ�����Ρ�", head, 0, "������")
	local thing, wugong = -1
	local hasit = 1	
	local count = 0
	while hasit == 1 do
		thing = randomwugong2(aa, bb)
		wugong = JY.Thing[thing]["�����书"]
		hasit = 0
		for i = 1, 12 do
			if JY.Person[0]["�书"..i] > 0 and JY.Person[0]["�书"..i] == wugong then
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
		say("��СС��ͣ���Ȼ�Ѿ�������˾��硣���Ǻ�����η��", head, 0, "������")	
		Cls()
		say("��û�ж������Խ����ˣ��㻹��������·������ʹ���ɡ�", head, 0, "������")	
		do return end
	end
	Cls()
	say("���������ҾͰ�����"..JY.Wugong[wugong]["����"].."���ڸ��㣬�����ˡ�", head, 0, "������")		
	JY.Person[0]["�书1"] = wugong
	JY.Person[0]["�书�ȼ�1"] = 100 --math.random(750, 900) �������ǣ�ȡ�����û�����������
	Cls()
	dark()
	light()
	QZXS(JY.Person[0]["����"].."����"..JY.Wugong[wugong]["����"].."��")
	say("��Σ���������", head, 0, "������")	
	Cls()
	say("���ˡ�ллǰ��ָ�㡣",0,4)	
	Cls()
	say("�ã����Ѿ�ͣ�ˣ��������·�ˡ���Ҫ����˵������ҡ�", head, 0, "������")	
	Cls()
	say("�ǣ�ǰ�����أ�",0,4)		
end


