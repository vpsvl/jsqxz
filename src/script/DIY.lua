local size = CC.FontName
--MpKffenlei()

--SetTF(0,4,1)

--instruct_2(84,1)
--say(Thing_kf(93),1,1)
--tjmdh(1782)
--CC.TX['������'] = 1
--JY.Person[0]['���ɹ���'] = 200
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
--JY.Person[0]['��Ѩ'..139] = 1

--ShowScreen()
--lib.Delay(500)

--CC.Year = CC.Year + 1

for i = 1,149 do 
	--JY.Person[0]['��Ѩ'..i] = 0 
end

for i = 1,149 do 
	--JY.Person[0]['��Ѩ'..i] = 1 
end
--��Ϸ�̵�
--1Ϊ��ƷID,2Ϊ���ۣ�3Ϊ������4Ϊ��ʾ���
--���͵�ַ�б�
--�书˵��
--ϴ�书
--�书˵��
--��ʾ�ַ������ȴ��������ַ���������ʾ����Ļ�м�
--����ѧ�书 ����
--�޾Ʋ�����ʹ��ҩƷ��ʳƷ
--CC.TX['��'] = 19
--�����츳ѡ��
--�书ͼ��˵��
--�������
--����

--instruct_3(52,1,1,0,9601,0,0,8208,8208,8208,-2,-2,-2)  --�޸ĳ����¼�
--instruct_3(52,11,1,0,9601,0,0,9388,9388,9388,-2,-2,-2)  --�޸ĳ����¼�
--instruct_3(52,20,1,0,9601,0,0,6294,6294,6294,-2,-2,-2)  --�޸ĳ����¼�
for i = 1,149 do 
	--JY.Person[0]['��Ѩ'..i] = 1
end

---------------------------------------------------------------------------------------------------------
-----------------------------------------����������������д����--------------------------------------------
---------------------------------------------------------------------------------------------------------

--SetTF(0,9984,0)
--SetTF(0,9985,1)

--��������
-- �������˺�����
-- �������˺�����
--ѡ��˵� �Ϲ�
-- ״̬�˵� ������Ϣ

-- ����ƴ�����뷨
-- ����ƴ�����뷨����
-- ����ƴ�����뷨����
 -- ����ƴ�����뷨����
-- ����ƴ�����뷨����
-- �򻯰� Lua ƴ�����뷨


----------------------------------------------------
local diyid = JY.Base["����" .. 1]
local function wupingisgongType(wuid,typeId)
	local ggid = JY.Thing[wuid]["�����书"]
	if ggid < 0 then
		return false
	end
	return JY.Wugong[ggid]["�书����"] == typeId
end

local nexty = CC.ScreenH/2-CC.DefaultFont*4 + CC.SingleLineHeight
local menu = {}
menu[1]={"����ר��        ",nil,1}
menu[2]={"ϴ����        ",nil,1}
menu[3]={"ϴ����        ",nil,1}
menu[4]={"�����Ʒ      ",nil,1}
menu[5]={"�ı���������  ",nil,1}
menu[6]={"���������10��",nil,1}
menu[7]={"ʵս500       ",nil,1}
menu[8]={"ȫϵ������10  ",nil,1}
menu[9]={"�����н���    ",nil,1}
menu[10]={"���ù�����    ",nil,1}
menu[11]={"���õ���      ",nil,1}
menu[12]={"��������书  ",nil,1}
menu[13]={"�ܲ�ͨ��20����",nil,1}
menu[14]={"ϴ�书        ",nil,1}
menu[15]={"ȫ����Ʒ",nil,1}
menu[16]={"ȫ���书����  ",nil,1}
menu[17]={"����Ѫ�����ֵ",nil,1}
menu[18]={"�ı�����      ",nil,1}
menu[19]={"ѡ���츳      ",nil,1}
menu[20]={"ѧ���书      ",nil,1}
menu[21]={"��ý�Ǯ      ",nil,1}
menu[22]={"ѧ�����һ���  ",nil,1}
menu[23]={"�������      ",nil,1}
menu[24]={"�滻����      ",nil,1}
menu[25]={"�۽�����      ",nil,1}
menu[26]={"������Ŀ      ",nil,1}
menu[27]={"ѧ���ؼ�      ",nil,1}
menu[28]={"����ѧ������      ",nil,1}
menu[98]={"����ս��      ",nil,1}
menu[99]={"��Ʒ���      ",nil,1}
menu[100]={"װ������     ",nil,1}
menu[101]={"ֱ��ͨ��     ",nil,1}
menu[102]={"ȫ������     ",nil,1}
local xuan = ShowMenu2(menu, #menu, 3, 11, CC.ScreenW/2-CC.DefaultFont*10-20, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"��ѡ����Ҫ�Ĺ���")

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
		local kfname = JY.Teji[i]['����']
		if kfname ~= '��' and kfname ~= '����' then
			menu1[i] = {kfname,nil,1,i}
		end
	end
	for i = 1,#menu1 do 
		local R = ShowMenu2(menu1, #menu1, 5, 17, CC.ScreenW/2-CC.DefaultFont*13, CC.ScreenH/2-CC.DefaultFont*10, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"�ؼ���ȫ")
		if R > 0 then 
			local nexty = CC.MainSubMenuY + CC.SingleLineHeight
			local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
			if p > 0 then
				diyid = JY.Base["����" .. p]
				--SetHuBo(diyid)
				for j = 1,10 do 
					if JY.Person[diyid]['�ؼ�'..j] == 0 then 
						JY.Person[diyid]['�ؼ�'..j] = menu1[R][4]
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
		diyid = JY.Base["����" .. p]
		--SetHuBo(diyid)
        JY.Person[diyid]['��ѧ����'] = 5000
        JY.Person[diyid]['��Ʒ��������'] = 50000
	end
end

if xuan==25 then
	--local menu1 = {"�ܲ�ͨ","������","�ֳ�Ӣ","����","������","��������","ɨ��ɮ","������","������"}
	nexty=nexty+CC.SingleLineHeight;
    local menuzd = {}
	menuzd[1]={"�ܲ�ͨ  ",nil,1}
	menuzd[2]={"������  ",nil,1}
	menuzd[3]={"�ֳ�Ӣ  ",nil,1}
	menuzd[4]={"����  ",nil,1}
	menuzd[5]={"������  ",nil,1}
	menuzd[6]={"��������    ",nil,1}
	menuzd[7]={"ɨ��ɮ    ",nil,1}
	menuzd[8]={"������  ",nil,1}
	menuzd[9]={"������  ",nil,1}
	--menuzd[10]={"ս��������  ",nil,1}	
	local zd = ShowMenu2(menuzd, #menuzd, 4, 7, CC.ScreenW/2-CC.DefaultFont*10-20, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"��ѡ�۽�����")
	
	if zd == 1 then
		DrawStrBoxWaitKey("���⽱������������������ý�����50% ", LimeGreen, 36,nil, C_GOLD)
				JY.Person[64]["�۽�����"] = 1	
	elseif zd == 2 then
		DrawStrBoxWaitKey("���⽱��������˺������������20% ", LimeGreen, 36,nil, C_GOLD)
				JY.Person[129]["�۽�����"] = 1
	elseif zd == 3 then
		DrawStrBoxWaitKey("���⽱����������������������50% ", LimeGreen, 36,nil, C_GOLD)
				JY.Person[605]["�۽�����"] = 1
	elseif zd == 4 then
		DrawStrBoxWaitKey("���⽱��������������������800��", LimeGreen, 36,nil, C_GOLD)
				JY.Person[604]["�۽�����"] = 1
	elseif zd == 5 then
		if PersonKF(0, 47) then
					DrawStrBoxWaitKey("���⽱���������˶��¾Ž����洫", LimeGreen, 36,nil, C_GOLD)
					JY.Person[592]["�۽�����"] = 1
				else
					DrawStrBoxWaitKey("���ƺ������һ�������", LimeGreen, 36,nil, C_GOLD)
				end
	elseif zd == 6 then
		DrawStrBoxWaitKey("���⽱������ļ����ٶ����������8��", LimeGreen, 36,nil, C_GOLD)
				JY.Person[27]["�۽�����"] = 1
	elseif zd == 7 then
		DrawStrBoxWaitKey("���⽱���������ѧ��ʶ�����100��", LimeGreen, 36,nil, C_GOLD)
				JY.Person[114]["�۽�����"] = 1
				AddPersonAttrib(0, "��ѧ��ʶ", 100)
	elseif zd == 8 then
	    DrawStrBoxWaitKey("���⽱������Ĺ��������ϵ����ֵȫ�������", LimeGreen, 36,nil, C_GOLD)
				JY.Person[5]["�۽�����"] = 1
				AddPersonAttrib(0, "������", 30)
				AddPersonAttrib(0, "������", 30)
				AddPersonAttrib(0, "�Ṧ", 30)
				AddPersonAttrib(0, "ȭ�ƹ���", 20)
				AddPersonAttrib(0, "ָ������", 20)
				AddPersonAttrib(0, "��������", 20)
				AddPersonAttrib(0, "ˣ������", 20)
				AddPersonAttrib(0, "�������", 20)		
	elseif zd == 9 then
		DrawStrBoxWaitKey("���⽱���������˾������ֵ�����", LimeGreen, 36,nil, C_GOLD)
		JY.Person[606]["�۽�����"] = 1	
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
		if JY.Person[i]['����'] ~= '����' and JY.Person[i]['����'] ~= '����ռ��'  and JY.Person[i]['����'] ~= '����ռ��' then 
			menu[#menu+1] = {JY.Person[i]['����'],nil,1,i} 
		end
	end 
	for i = 1,#menu do 
		local xz = ShowMenu4(menu,#menu,8,-2,-2,-2,-2,-2,1,CC.DefaultFont*0.9,C_GOLD,C_WHITE,"��ѡ��Ҫ�滻������",C_ORANGE, C_WHITE,15)	
		if xz > 0 then 
			local clone_choice = menu[xz][4]
			JY.Base["����"] = clone_choice
			JY.Person[0]["ͷ�����"] = JY.Person[clone_choice]["ͷ�����"]
			JY.Person[0]["������"] = JY.Person[clone_choice]["������"]
			JY.Person[0]["����"] = JY.Person[clone_choice]["����"]
			JY.Person[0]["���"] = JY.Person[clone_choice]["���"]
			JY.Person[0]["��ɫָ��"] = JY.Person[clone_choice]["��ɫָ��"]
			JY.Person[0]["����"] = JY.Person[clone_choice]["����"]
			JY.Person[0]["�Ա�"] = JY.Person[clone_choice]["�Ա�"]
			for i=1,5 do
				JY.Person[0]["���ж���֡��" .. i]=JY.Person[clone_choice]["���ж���֡��" .. i]
				JY.Person[0]["���ж����ӳ�" .. i]=JY.Person[clone_choice]["���ж����ӳ�" .. i]
				JY.Person[0]["�书��Ч�ӳ�" .. i]=JY.Person[clone_choice]["�书��Ч�ӳ�" .. i]
			end
			--���빥�������25
			JY.Person[0]["������"]=limitX(JY.Person[clone_choice]["������"]/4,25)
			JY.Person[0]["������"]=limitX(JY.Person[clone_choice]["������"]/4,25)
			JY.Person[0]["�Ṧ"]=limitX(JY.Person[clone_choice]["�Ṧ"]/4,25)
			--ҽ���ö��ⶾ���30
			JY.Person[0]["ҽ������"]=limitX(JY.Person[clone_choice]["ҽ������"],30)
			JY.Person[0]["�ö�����"]=limitX(JY.Person[clone_choice]["�ö�����"],30)
			JY.Person[0]["�ⶾ����"]=limitX(JY.Person[clone_choice]["�ⶾ����"],30)

			JY.Person[0]["��������"]=JY.Person[clone_choice]["��������"]
			JY.Person[0]["ȭ�ƹ���"]=JY.Person[clone_choice]["ȭ�ƹ���"]
			JY.Person[0]["ָ������"]=JY.Person[clone_choice]["ָ������"]
			JY.Person[0]["��������"]=JY.Person[clone_choice]["��������"]
			JY.Person[0]["ˣ������"]=JY.Person[clone_choice]["ˣ������"]
			JY.Person[0]["�������"]=JY.Person[clone_choice]["�������"]
			--������������30
			JY.Person[0]["��������"]=limitX(JY.Person[clone_choice]["��������"],30)

			
			local wxcs=JY.Person[clone_choice]["��ѧ��ʶ"]-(JY.Base["��Ŀ"]-1)*20
			
			if wxcs>0 then
				JY.Person[0]["��ѧ��ʶ"]=JY.Person[clone_choice]["��ѧ��ʶ"]-(JY.Base["��Ŀ"]-1)*20
			else
				JY.Person[0]["��ѧ��ʶ"]=10
			end		
			JY.Person[0]["��������"]=JY.Person[clone_choice]["��������"]
			JY.Person[0]["���һ���"]=JY.Person[clone_choice]["���һ���"]
			for i=1,12 do
				JY.Person[0]["�书" .. i]=JY.Person[clone_choice]["�书" .. i]
				JY.Person[0]["�书�ȼ�" .. i]=JY.Person[clone_choice]["�书�ȼ�" .. i]
			end
			for i=1,2 do
				JY.Person[0]["�츳�⹦"..i]=JY.Person[clone_choice]["�츳�⹦"..i]
			end
			
			JY.Person[0]["�츳�ڹ�"]=JY.Person[clone_choice]["�츳�ڹ�"]
			JY.Person[0]["�츳�Ṧ"]=JY.Person[clone_choice]["�츳�Ṧ"]
			JY.Person[0]["����ֽ�"]=JY.Person[clone_choice]["����ֽ�"]
			JY.Person[0]["���2"]=JY.Person[clone_choice]["���2"]
			JY.Person[0]["��ɫָ��"] = JY.Person[clone_choice]["��ɫָ��"]
			JY.Person[0]["�ȼ�"]=JY.Person[clone_choice]["�ȼ�"]
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
		if JY.Person[i]['����'] ~= '����' and JY.Person[i]['����'] ~= '����ռ��' then
			menu[#menu+1] = {JY.Person[i]['����'],nil,1,i}
		end
	end		
	local clone_choice = ShowMenu4(menu,#menu,8,-2,-2,-2,-2,1,1,CC.DefaultFont*0.9,C_GOLD,C_WHITE,"��ѡ��Ҫ����Ķ���",C_ORANGE, C_WHITE,15)
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
	--JY.Base["��Ŀ"] =InputNum("ѡ����Ŀ", 1, 600,1);
end

if xuan ==22 then
	
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["����" .. p]
		--SetHuBo(diyid)
		JY.Person[diyid]["���һ���"] = 1
		instruct_68(diyid,4,1,0)
	end
	
	--instruct_2(174,30000)
	--AddZM()
	--JY.Base["��Ŀ"] =InputNum("ѡ����Ŀ", 1, 600,1);
end

if xuan == 5 then
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["����" .. p]
		local r1 = JYMsgBox("��ѡ��", "����Ҫת������������", {"����","����","����"}, 3, 122,1)
		if r1 == 1 then
			JY.Person[diyid]["��������"] = 0
		elseif r1==2 then
			JY.Person[diyid]["��������"] = 1
		elseif r1==3 then
			JY.Person[diyid]["��������"] = 2
		else
		end
	end
end	
	
if xuan==6 then
	local r2 = JYMsgBox("��ѡ��", "����������͵��书����Ȥ��", {"ȭ��","ָ��","����","����","����",}, 5, 122,1)
	if r2 == 1 then
		AddPersonAttrib(diyid, "ȭ�ƹ���", 10)
		DrawStrBoxWaitKey("���ȭ�ƹ�������������",C_GOLD,CC.DefaultFont,nil,LimeGreen)
		Cls()  --����
	elseif r2 == 2 then
		AddPersonAttrib(diyid, "ָ������", 10)
		DrawStrBoxWaitKey("���ָ�����ɵ����������",C_GOLD,CC.DefaultFont,nil,LimeGreen)
		Cls()  --����
	elseif r2 == 3 then
		AddPersonAttrib(diyid, "��������", 10)
		DrawStrBoxWaitKey("����������������������",C_GOLD,CC.DefaultFont,nil,LimeGreen)
		Cls()  --����
	elseif r2 == 4 then
		AddPersonAttrib(diyid, "ˣ������", 10)
		DrawStrBoxWaitKey("���ˣ�����ɵ����������",C_GOLD,CC.DefaultFont,nil,LimeGreen)
		Cls()  --����
	elseif r2 == 5 then
		AddPersonAttrib(diyid, "�������", 10)
		DrawStrBoxWaitKey("���������������������",C_GOLD,CC.DefaultFont,nil,LimeGreen)
		Cls()  --����
	end
end

if xuan==20 then
	local k = JY.Wugong;
	local menuwai = {}
	local menu  = {}	
	local kftype = JYMsgBox("��ѡ��", "��ѡ���书����                ", {"ȭ��","ָ��","����","����","����","�ڹ�","�Ṧ"}, 7, 347)	
	for i = 1, JY.WugongNum - 1 do
		local kfname = k[i]["����"]
		if string.len(kfname) == 8 then
			kfname = kfname.."  "
		elseif string.len(kfname) == 6 then
			kfname = kfname.."    "
		elseif string.len(kfname) == 4 then
			kfname = kfname.."      "
		end
		menuwai[i] = {kfname,nil,2}
		if k[i]["�书����"] == kftype then
			menuwai[i][3] = 1
		end
	end
	local nexty = CC.ScreenH/2-CC.DefaultFont*4 + CC.SingleLineHeight
	local r = ShowMenu2(menuwai, #menuwai, 3, 9, CC.ScreenW/2-CC.DefaultFont*10-20, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"ѡ���书")
	if r == 0 then
		return
	end	
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
	diyid = JY.Base["����" .. p]
	instruct_33(diyid,r,0)
end 

if xuan == 2 then
	local k = JY.Wugong;
	local menuwai = {}
	
	local kftype = JYMsgBox("��ѡ��", "��ѡ��ϲ�����츳�⹦����", {"ȭ��","ָ��","����","����","����"}, 5, 347)
	
	for i = 1, JY.WugongNum - 1 do
		local kfname = k[i]["����"]
		if string.len(kfname) == 8 then
			kfname = kfname.."  "
		elseif string.len(kfname) == 6 then
			kfname = kfname.."    "
		elseif string.len(kfname) == 4 then
			kfname = kfname.."      "
		end
		menuwai[i] = {kfname,nil,2}
		if k[i]["�书����"] == kftype then
			menuwai[i][3] = 1
		end
	end
	local nexty = CC.ScreenH/2-CC.DefaultFont*4 + CC.SingleLineHeight
	local r = ShowMenu2(menuwai, #menuwai, 3, 9, CC.ScreenW/2-CC.DefaultFont*10-20, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"�����츳�⹦")
	if r == 0 then
		return
	end
	
	local tianwai = JYMsgBox("��ѡ��", "ϴ�ڼ����츳�⹦��", {"����1","����2"}, 2, 347,1)
	if tianwai < 0 then
		return
	end
	if r > 0 then
		--��ʼ
		local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["����" .. p]
		SetTianWai(diyid, tianwai, r)
		
	end
		
		
		--����
		--SetTianWai(0, tianwai, r)
	end
	
end

if xuan == 3 then
	local k = JY.Wugong;
	local menunei = {}
	for i = 1, JY.WugongNum - 1 do
		local kfname = k[i]["����"]
		if string.len(kfname) == 8 then
			kfname = kfname.."  "
		elseif string.len(kfname) == 6 then
			kfname = kfname.."    "
		elseif string.len(kfname) == 4 then
			kfname = kfname.."      "
		end
		menunei[i] = {kfname,nil,2}
		if k[i]["�书����"] == 6 then
			menunei[i][3] = 1
		end
	end
	local nexty = CC.ScreenH/2-CC.DefaultFont*4 + CC.SingleLineHeight
	local r = ShowMenu2(menunei, #menunei, 3, 9, CC.ScreenW/2-CC.DefaultFont*10-20, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"�����츳�ڹ�")
	if r > 0 then
		--��ʼ
		local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["����" .. p]
		SetTianNei(diyid, r)
		
	end
		
		--����
		--SetTianNei(0, r)
	end
		
end
	
	
if xuan == 4 then
	local k = JY.Thing;
	local ceshi = {}
	local wutype = JYMsgBox("��ѡ��", "��Ʒ����                                       ", {"������Ʒ","�������","�书�ؼ�","�鵤��ҩ","���˰���"}, 5, 347,1)
	if wutype < 0  then
		return
	end
	local gongtype = 0
	if wutype-1 == 2 then
		gongtype = JYMsgBox("��ѡ��", "��ѡ���ؼ�����                    ", {"ȭ��","ָ��","����","����","����","�ڹ�","�Ṧ","����"}, 8, 347)
		if gongtype < 0 then
			return
		end
	end
	for i = 0, JY.ThingNum - 1 do
		local kfname = k[i]["����"]
		if string.len(kfname) == 8 then
			kfname = kfname.."  "
		elseif string.len(kfname) == 6 then
			kfname = kfname.."    "
		elseif string.len(kfname) == 4 then
			kfname = kfname.."      "
		end
		ceshi[i] = {kfname..k[i]["����"]..i,nil,2}
		if k[i]["����"] == wutype-1 then
			ceshi[i][3] = 1
			if wutype-1 == 2 and wupingisgongType(i,gongtype)~=true then
				ceshi[i][3] = 2
			end
			if wutype-1 == 2 and JY.Thing[i]["�����书"] < 0 and gongtype == 8 then
				ceshi[i][3] = 1
			end
		end
		
	end
	local nexty = CC.ScreenH/2-CC.DefaultFont*4 + CC.SingleLineHeight
	local r = 0
	r = ShowMenu2(ceshi, #ceshi, 3, 9, CC.ScreenW/2-CC.DefaultFont*10-20, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"��ѡ��")
	if r == 0 then
		return
	end
	if wutype-1 == 3 or r == 174 or wutype-1 == 4 then
		local nnnum = InputNum(JY.Thing[r]["����"], 1, 30000,1)
		if nnnum == nil or nnnum <= 0 then
			return
		end
		instruct_2(r,nnnum)
		return
	end
	instruct_2(r,1)
	
	
elseif xuan == 7 then
	DrawStrBoxWaitKey("���⽱��������ʵս500", C_RED, CC.DefaultFont,nil,C_GOLD)
	JY.Person[diyid]["ʵս"] = 500
	
	
elseif xuan == 8 then
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["����" .. p]
		DrawStrBoxWaitKey("���⽱������ϵ����ֵ����һ�ٵ�", C_RED, CC.DefaultFont,nil,C_GOLD)
		AddPersonAttrib(diyid, "ȭ�ƹ���", 100)
		AddPersonAttrib(diyid, "ָ������", 100)
		AddPersonAttrib(diyid, "��������", 100)
		AddPersonAttrib(diyid, "ˣ������", 100)
		AddPersonAttrib(diyid, "�������", 100)
	end
	
	
elseif xuan==9 then
	DrawStrBoxWaitKey("���������Ṧ������ʮ��", C_RED, CC.DefaultFont,nil,C_GOLD)
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["����" .. p]
		JY.Person[diyid]["������"] = JY.Person[diyid]["������"]+10
		JY.Person[diyid]["�Ṧ"] = JY.Person[diyid]["�Ṧ"]+10
	end
	
	
elseif xuan==10 then
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["����" .. p]
	end
	local shux = JYMsgBox("��ѡ��", "�����ĸ����ԣ�          ", {"������","������","�Ṧ"}, 3, 347,1)
	if shux < 0  then
		return
	end
	local nnnum = InputNum("��������ֵ", 1, 600,1)
	if nnnum == nil or nnnum <= 0 then
		return
	end
	local temp_shu = {"������","������","�Ṧ"}
	local temp_s = temp_shu[shux]
	JY.Person[diyid][temp_s] = nnnum
	
	
elseif xuan == 11 then
	local nnnum = InputNum("��������ֵ", 1, 200,1)
	if nnnum == nil or nnnum <= 0 then
		return
	end
	JY.Person[0]["Ʒ��"] = nnnum
	
	
elseif xuan == 12 then
	local k = JY.Wugong;
	local menuwai = {}
	local menu  = {}
	
	local kftype = JYMsgBox("��ѡ��", "��ѡ���书����                ", {"ȭ��","ָ��","����","����","����","�ڹ�","�Ṧ"}, 7, 347)
	
	for i = 1, JY.WugongNum - 1 do
		local kfname = k[i]["����"]
		if string.len(kfname) == 8 then
			kfname = kfname.."  "
		elseif string.len(kfname) == 6 then
			kfname = kfname.."    "
		elseif string.len(kfname) == 4 then
			kfname = kfname.."      "
		end
		menuwai[i] = {kfname,nil,2}
		if k[i]["�书����"] == kftype then
			menuwai[i][3] = 1
		end
	end
	local nexty = CC.ScreenH/2-CC.DefaultFont*4 + CC.SingleLineHeight
	local r = ShowMenu2(menuwai, #menuwai, 3, 9, CC.ScreenW/2-CC.DefaultFont*10-20, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"ѡ���书")
	if r == 0 then
		return
	end
	
	
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
	diyid = JY.Base["����" .. p]
	
	
	for j = 1, CC.Kungfunum do
        if JY.Person[diyid]["�书"..j] > 0 then
            local wg = JY.Person[diyid]["�书"..j]
            menu[#menu+1] = {JY.Wugong[wg]["����"], nil, 1, wg, j}
        end
	end   
	local geizi = ShowMenu2(menu, #menu, 3,10, CC.MainSubMenuX, CC.MainSubMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)
	if geizi < 0 then
		return
	end
	if r > 0 then
		JY.Person[diyid]["�书"..geizi] = r
		JY.Person[diyid]["�书�ȼ�"..geizi] = 999
	end
	
	
elseif xuan == 13 then
	DrawStrBoxWaitKey("������һ����������������20%,�������", LimeGreen, 36,nil, C_GOLD)
	JY.Person[64]["Ʒ��"] = 80
	
	
elseif xuan == 14 then	
	Cls()
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
	if p > 0 then
		local pid = JY.Base["����" .. p]
		local menu = {}
		for i = 1, CC.Kungfunum do
			if JY.Person[pid]["�书"..i] > 0 then
				local wg = JY.Person[pid]["�书"..i]
				menu[#menu+1] = {JY.Wugong[wg]["����"], nil, 1, wg, i}
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
				if JY.Thing[i]["�����书"] > 0 and JY.Thing[i]["�����书"] == menu[r][4] then
					thingid = i
					local level = math.modf(JY.Person[pid]["�书�ȼ�" .. menu[r][5]] / 100) + 1
					AddPersonAttrib(pid, "�������ֵ", -JY.Thing[thingid]["���������ֵ"] * level)
					AddPersonAttrib(pid, "�������ֵ", -JY.Thing[thingid]["���������ֵ"] * level)
					AddPersonAttrib(pid, "������", -JY.Thing[thingid]["�ӹ�����"] * level)
					AddPersonAttrib(pid, "�Ṧ", -JY.Thing[thingid]["���Ṧ"] * level)
					AddPersonAttrib(pid, "������", -JY.Thing[thingid]["�ӷ�����"] * level)        
					AddPersonAttrib(pid, "ҽ������", -JY.Thing[thingid]["��ҽ������"] * jjj * level)
					AddPersonAttrib(pid, "�ö�����", -JY.Thing[thingid]["���ö�����"] * jjj * level)
					AddPersonAttrib(pid, "�ⶾ����", -JY.Thing[thingid]["�ӽⶾ����"] * jjj * level)
					AddPersonAttrib(pid, "��������", -JY.Thing[thingid]["�ӿ�������"] * jjj * level)
					AddPersonAttrib(pid, "ȭ�ƹ���", -JY.Thing[thingid]["��ȭ�ƹ���"] * jjj * level)
					AddPersonAttrib(pid, "ָ������", -JY.Thing[thingid]["��ָ������"] * jjj * level)
					AddPersonAttrib(pid, "��������", -JY.Thing[thingid]["����������"] * jjj * level)
					AddPersonAttrib(pid, "ˣ������", -JY.Thing[thingid]["��ˣ������"] * jjj * level)
					AddPersonAttrib(pid, "�������", -JY.Thing[thingid]["���������"] * jjj * level)
					AddPersonAttrib(pid, "��������", -JY.Thing[thingid]["�Ӱ�������"] * jjj * level)
					AddPersonAttrib(pid, "��ѧ��ʶ", -JY.Thing[thingid]["����ѧ��ʶ"] * jjj * level)     										
					break
				end
			end
			for i = menu[r][5], #menu - 1 do
				JY.Person[pid]["�书"..i] = JY.Person[pid]["�书"..i+1]
				JY.Person[pid]["�书�ȼ�"..i] = JY.Person[pid]["�书�ȼ�"..i+1]
			end
			JY.Person[pid]["�书"..#menu] = 0
			JY.Person[pid]["�书�ȼ�"..#menu] = 0
			QZXS(JY.Person[pid]["����"].."�Ѿ�ϴ��"..menu[r][1])
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
        diyid = JY.Base["����" .. p]
		for i = 1, CC.Kungfunum do
			if JY.Person[diyid]["�书�ȼ�"..i] <=900 then
				JY.Person[diyid]["�书�ȼ�"..i] = 999
			end
		end
	end
	
elseif xuan == 17 then
    for i=1,CC.TeamNum do
		if JY.Base["����" .. i]>= 0 then
			diyid = JY.Base["����" .. i]
		end
		AddPersonAttrib(diyid, "�������ֵ", 999)
		AddPersonAttrib(diyid, "�������ֵ", 9999)
		JY.Person[diyid]["����"] = JY.Person[diyid]["�������ֵ"]
		JY.Person[diyid]["����"] = JY.Person[diyid]["�������ֵ"]
	end	
	DrawStrBoxWaitKey("���⽱�������������������ֵ", C_RED, CC.DefaultFont,nil,C_GOLD)
	
elseif xuan == 18 then
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["����" .. p]
		local nnnum = InputNum("����������", 1, 100,1)
		if nnnum == nil or nnnum <= 0 then
			return
		end
		JY.Person[diyid]["����"] = nnnum
	end			
	
elseif xuan == 19 then
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["����" .. p]
		JJ_TF(diyid,0)	
	end	
	
	
	
elseif xuan == 98 then
	nexty=nexty+CC.SingleLineHeight;
    local menuzd = {}
	menuzd[1]={"ս�ݳ���  ",nil,1}
	menuzd[2]={"սʮ����  ",nil,1}
	menuzd[3]={"ս��ʮ��  ",nil,1}
	menuzd[4]={"ս�������  ",nil,1}
	menuzd[5]={"սɨ��  ",nil,1}
	menuzd[6]={"ս�ɸ�    ",nil,1}
	menuzd[7]={"սŷ����    ",nil,1}
	menuzd[8]={"ս������  ",nil,1}
	menuzd[9]={"սͯ��  ",nil,1}
	menuzd[10]={"ս��������  ",nil,1}	
	menuzd[11]={"ս��̹֮  ",nil,1}
	menuzd[12]={"��Ħ  ",nil,1}
	local zd = ShowMenu2(menuzd, #menuzd, 4, 7, CC.ScreenW/2-CC.DefaultFont*10-20, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"��ѡ��ս��")
	
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
		local temppd = JY.Person[27]["Ʒ��"]
		JY.Person[27]["Ʒ��"] = 20
		WarMain(54, 0)	
		JY.Person[27]["Ʒ��"] = temppd
	elseif zd == 11 then
		WarMain(88)
	elseif zd == 12 then
		WAR.Data["����" .. 1] = 594
		WarMain(309)				
	end
	
	
elseif xuan == 99 then
	local k = JY.Thing;
	local ceshi = {}
	local kfname = 0 
	for i = 0, JY.ThingNum - 1 do
		kfname = k[i]["����"]
		if string.len(kfname) == 8 then
			kfname = kfname.."  "
		elseif string.len(kfname) == 6 then
			kfname = kfname.."    "
		elseif string.len(kfname) == 4 then
			kfname = kfname.."      "
		end
		ceshi[i] = {kfname..k[i]["����"],nil,2}
		local ggid = k[i]["�����书"]
		if k[i]["����"] == 2 and ggid >0 then
			ceshi[i] = {kfname..JY.Wugong[ggid]["�书����"],nil,2}
		end
		if true then
			ceshi[i][3] = 1
		end	
	end
elseif xuan == 100 then	
	for id = 0,CC.TeamNum-1 do
		if inteam(id) then
	        if JY.Person[id]["����"]~= nil then
		        for i = 1,JY.ThingNum - 1 do
			        if i == JY.Person[id]["����"] then
				       JY.Thing[i]["װ���ȼ�"] = 6
			        end
			        if i == JY.Person[id]["����"] then
				       JY.Thing[i]["װ���ȼ�"] = 6
			        end
			        if i == JY.Person[id]["����"] then
				       JY.Thing[i]["װ���ȼ�"] = 6
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
	--local r = ShowMenu2(ceshi, #ceshi, 3, 9, CC.ScreenW/2-CC.DefaultFont*10-20, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"��Ʒ���")
	--if r>0 then
	--	instruct_2(r,1)
	--end
	
elseif xuan == 102 then	
	local nexty = CC.MainSubMenuY + CC.SingleLineHeight
	local p = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if p > 0 then
		diyid = JY.Base["����" .. p]
		JY.Person[diyid]["������"] = 999
		JY.Person[diyid]["������"] = 999
		JY.Person[diyid]["�Ṧ"] = 999
		JY.Person[diyid]["ȭ�ƹ���"] = 500
		JY.Person[diyid]["ָ������"] = 500
		JY.Person[diyid]["��������"] = 500
		JY.Person[diyid]["ˣ������"] = 500
		JY.Person[diyid]["�������"] = 500
		JY.Person[diyid]["�������ֵ"] = 9999
		JY.Person[diyid]["��ѧ����"] = 30000
		JY.Person[diyid]["���ɹ���"] = 600
		JY.Person[diyid]["��Ʒ��������"] = 60000
		JY.Person[diyid]["����"] = 20
	end	
end
--]]

