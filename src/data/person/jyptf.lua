



--��Ŀ��������
function ZM_Add(id,str)
	local zm = JY.Base['��Ŀ']
	local nd = JY.Base['�Ѷ�']
	local fj = (7-JY.Base['�ֽ�'])
	local Add_Max = 0
	local xs = 0
	local sw = 0
	if id ~= 591 then 
		--ÿ��Ŀ����20��ϵ������Χ���䳣
		if nd > 1 and  p ~= 591 then 
			xs = zm
			sw = zm*3
		end
		--ÿ��Ŀ����20��ϵ������Χ���䳣
		if nd > 1 then
			xs = xs + nd*5
			sw = sw + nd*5 
		end
		if nd >= 3 and JY.Person[p]["����ֽ�"] <= 3 then
			sw = sw + nd*zm
			xs = xs + nd*zm
		end	
		lib.Debug('��Χ == '..sw)
		local a,b,c = split_into_three(sw)
		local sx1 = math.modf(zm*nd*fj*0.5)
		if str == '��������' then 
			Add_Max = sx1*10
		elseif str == '�������ֵ' then 
			Add_Max = sx1*10
		elseif str == '������' then 
			Add_Max = sx1
		elseif str == '������' then 
			Add_Max = sx1
		elseif str == '�Ṧ' then 
			Add_Max = sx1
		elseif str == 'ҽ������' then 
			--Add_Max = sx1
		elseif str == '�ö�����' then 
			--Add_Max = sx1
		elseif str == '��������' then 
			--Add_Max = sx1
		elseif str == 'ȭ�ƹ���' then 
			Add_Max = sx1
		elseif str =='ָ������' then 
			Add_Max = sx1
		elseif str== '��������' then
			Add_Max = sx1
		elseif str == 'ˣ������' then 
			Add_Max = sx1
		elseif str== '�������' then 
			Add_Max = sx1
		end
	end
	return Add_Max
end

--�ж������书�ȼ�
function KF_level(id,kf) 
	local level = 0
	for i = 1,JY.Base['�书����'] do 
		if JY.Person[id]["�书" .. i] == kf then 
			local kflvl = JY.Person[id]["�书�ȼ�" .. i]
			if kflvl >= 999 then
				level = 11
			else
				level = math.modf(kflvl/100)+1
			end
		end
	end
	return level
end

--������Ѩ��������
function JMQX_JH(id,qx)
	local R =JY.Person[id] 
	local pd = 0
	--ָ��
	if qx == 3 then 
		if R['ָ������'] >= 100 then 
			pd = 1
		end
	end
	if qx == 6 then 
		if R['ָ������'] >= 200 then 
			pd = 1
		end
	end
	if qx == 9 then 
		if R['ָ������'] >= 400 then 
			pd = 1
		end
	end	

	--����
	if qx == 12 then 
		if R['��������'] >= 100 then 
			pd = 1
		end
	end	
	if qx == 15 then 
		if R['��������'] >= 200 then 
			pd = 1
		end
	end	
	if qx == 19 then 
		if R['��������'] >= 400 then 
			pd = 1
		end
	end	

	--�ö�
	if qx == 22 then 
		if R['�ö�����'] >= 100 then 
			pd = 1
		end
	end	
	if qx == 25 then 
		if R['�ö�����'] >= 200 then 
			pd = 1
		end
	end	
	if qx == 28 then 
		if R['�ö�����'] >= 400 then 
			pd = 1
		end
	end	

	--ȭ��
	if qx == 32 then 
		if R['ȭ�ƹ���'] >= 100 then 
			pd = 1
		end
	end	
	if qx == 36 then 
		if R['ȭ�ƹ���'] >= 200 then 
			pd = 1
		end
	end	
	if qx == 40 then 
		if R['ȭ�ƹ���'] >= 400 then 
			pd = 1
		end
	end		

	--����
	if qx == 44 then 
		if R['ˣ������'] >= 100 then 
			pd = 1
		end
	end	
	if qx == 48 then 
		if R['ˣ������'] >= 200 then 
			pd = 1
		end
	end	
	if qx == 51 then 
		if R['ˣ������'] >= 400 then 
			pd = 1
		end
	end	

	--����
	if R['��������'] == 1 or R['��������'] == 3 then 
		if qx == 54 then 
			--���־�����/��ü������/�䵱����������
			if KF_level(id,241) >= 10 or KF_level(id,242)  >= 10 or KF_level(id,243) >= 10   then 
				pd = 1
			end
		end	
		if qx == 57 then 
			if R['�������ֵ'] >= 5000 then 
				pd = 1
			end
		end	
		--�츳�ڹ���ͨ������
		if qx == 61 then 
			if R['�츳�ڹ�'] == 106 then 
				pd = 1
			end
		end	
	end

	--����
	if qx == 65 then 
		if R['�������'] >= 100 then 
			pd = 1
		end
	end	
	if qx == 69 then 
		if R['�������'] >= 200 then 
			pd = 1
		end
	end	
	if qx == 72 then 
		if R['�������'] >= 400 then 
			pd = 1
		end
	end	


	--����
	if R['��������'] == 0 or R['��������'] == 3 then 
		if qx == 76 then 
			--��ϼ��/������������
			if  KF_level(id,89) >= 10 or KF_level(id,216) >= 10   then 
				pd = 1
			end
		end	
		if qx == 80 then 
			if R['�������ֵ'] >= 5000 then 
				pd = 1
			end
		end	
		--��ͨ�츳�ڹ�������
		if qx == 83 then 
			if R['�츳�ڹ�'] == 107 then 
				pd = 1
			end
		end	
	end	

	--����
	if qx == 87 then 
		--��Ϣ��/���������/��󡹦/��Ϣ��/ʨ�𹦵���
		if KF_level(id,103) >= 10 or KF_level(id,180) >= 10 or KF_level(id,92) >= 10 or KF_level(id,95) >= 10 or KF_level(id,227) >= 10then 
			pd = 1
		end
	end	
	if qx == 91 then 
		if R['�������ֵ'] >= 6000 then 
			pd = 1
		end
	end	
	if qx == 95 then 
		--ѧ�����һ���
		if Pmiji(id,4) then 
			pd = 1
		end
	end	

	--�Ṧ
	if qx == 99 then 
		if R['�Ṧ'] >= 200 then 
			pd = 1
		end
	end	
	if qx == 103 then 
		if R['�Ṧ'] >= 300 then 
			pd = 1
		end
	end	
	if qx == 106 then 
		if R['�Ṧ'] >= 400 then 
			pd = 1
		end
	end	

	--�ظ�ϵ
	if qx == 110 then 
		--�޺���ħ��/��ϼ��/��Ԫ��/���������ҵ���
		if KF_level(id,89) >= 10 or KF_level(id,90) >= 10 or KF_level(id,96) >= 10 or KF_level(id,207) >= 10  then 
			pd = 1
		end
	end	
	if qx == 114 then 
		if R['�������ֵ'] >= 5000 then 
			pd = 1
		end
	end	
	--��ͨ������/�󳤺;�/��������/��������
	if qx == 117 then 
		if R['�츳�ڹ�'] == 203 or R['�츳�ڹ�'] == 253 or R['�츳�ڹ�'] == 207 then 
			pd = 1
		end
	end	

	--������
	if R['��������'] == 2 or R['��������'] == 3 then 
		if qx == 121 then 
			--��������̫�齣��/��������/С���๦����
			if KF_level(id,98) >= 10 or  KF_level(id,152) >= 10 or KF_level(id,177) >= 10   then 
				pd = 1
			end
		end	
		if qx == 125 then 
			if R['�������ֵ'] >= 5000 then 
				pd = 1
			end
		end	
		--�������Ҿ�ͨ�׽���/�����޼���
		if qx == 129 then 
			if R['�츳�ڹ�'] == 108  or R['�츳�ڹ�'] == 221 then 
				pd = 1
			end
		end	
	end 
	

	--����
	if qx == 132 then 
		--Ǭ����Ų�Ƶ���
		if KF_level(id,97) >= 10  then 
			pd = 1
		end
	end	
	if qx == 135 then 
		if R['�������ֵ'] >= 5000 then 
			pd = 1
		end
	end	
	--ѧ����ӹ֮��
	if qx == 139 then 
		if Pmiji(id,1) or Pmiji(id,2) then 
			pd = 1
		end
	end	


	--����
	if qx == 142 then 
		--������ת/���Ǵ�/�����󷨵���
		if KF_level(id,317) >= 10 or KF_level(id,87) >= 10 or KF_level(id,88) >= 10  then 
			pd = 1
		end
	end	
	--
	if qx == 145 then 
		if R['�������ֵ'] >= 5000 then 
			pd = 1
		end
	end	
	--ѧ�ᶷת����
	if qx == 149 then 
		if Pmiji(id,3) then 
			pd = 1
		end
	end	

	if pd == 1 then
		--lib.Debug(qx..'�ж���������'..pd) 
		return true
	else
		--lib.Debug(qx..'�ж�����δ����'..pd)
		return false
	end
	
	return pd
end

--��������
function JZ_lqz(id)
	local lqz = 100
	if (id == 37 or JY.Base['����'] == 37) then 		
		lqz = 60 
		--lib.Debug(JY.Person[id]['����']..'����ʹ�������ж�'..lqz)
		--return true
	else 
		lqz = 100
	end 	
	return lqz
end


--�����书����
function MP_wgnum(id) 
	local wgnum = 0
	for i = 1,JY.Base['�书����'] do 
		local wg = JY.Person[id]['�书'..i]
		if JY.Wugong[wg]['����'] == JY.Person[id]['����'] and wg > 0 then 
			wgnum = wgnum + 1
		end
	end
	return wgnum
end

--��������
function MP_name(pid)
	local name = nil
	local mp = JY.Person[pid]["����"]
	local MPname = {
				"����","������","�䵱��","��ң��","�������","����","�����","ȫ���","ؤ��","��ɽ��",
				"��ɽ��","�����","��ɽ��","��ɽ��","̩ɽ��","�嶾��","��Ĺ��","Ѫ����","������","��ü��",
				"�����","������","�һ���","����ɽׯ","������","������","Ľ������","������","������","����",
				"�ؽ�ɽׯ",
				}
	if mp >= 0 then 
		name = MPname[mp+1]
	end
	return name 
end

--�书һ��
function KF_yimai(personid,wugongid)
	local yes = 1
	local okf = 0	
	local pd = 0	
	--local nkf = JY.Thing[wugongid]['�����书']
	--���֡��䵱����ü������һ����о�����
	if wugongid == 106 then
		local n = {
					{241,"�䵱������"},
					{242,"��ü������"},
					{243,"���־�����"}
				}
		local k;
		local d;
		local jy = 0
		for i = 1,JY.Base["�书����"] do
			for j = 1,#n do
				if JY.Person[personid]["�书"..i] == n[j][1] then
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
	--��ϼһ������������������ϼ�Ŀ���������ѧ��������
	if wugongid == 175 then
		okf = 89
	end
	--Ѫ����ħ��һ�����
	if wugongid == 160 then
		okf = 163
	end				
	--ʨ�Ӻ���ʨ�Ӻ�һ�����
	if wugongid == 91 then
		okf = 92
	end
	--��󡹦��Ϣ��һ�����
	if wugongid == 180 then
		okf = 95
	end
	--���ճ���һ�����
	if wugongid == 203 then
		okf = 94
	end
	--��Ů���� ��Ů���Ľ� һ�����
	if wugongid == 139 then
		okf = 42
	end
	--�䵱�ķ� ̫����һ�����
	if wugongid == 171 then
		okf = 209
	end
	--�����ķ� �׽һ�����
	if wugongid == 108 then
		okf = 208
	end
	--ȫ���ķ� ���칦һ�����
	if wugongid == 100 then
		okf = 210
	end
	--��Ĺ�ķ� ��Ů�ľ� һ�����
	if wugongid == 154 then
		okf = 211
	end
	--��ɽ�ķ� ��ϼ�� һ�����
	if wugongid == 89 then
		okf = 212
	end
	--��ɽ�ķ� �������� һ�����
	if wugongid == 216 then
		okf = 213
	end
	--Ѫ���ķ� Ѫ����� һ�����
	if wugongid == 163 then
		okf = 214	
	end											 											
	--ؤ�������� ������ һ�����
	if wugongid == 204 then
		okf = 215
	end
	--�ػ� ʥ���� һ�����
	if wugongid == 93 then
		okf = 217
	end
	--С���칦�����칦һ�����
	if wugongid == 190 then
		okf = 225
	end
	--���Ͻ��� �������� һ�����
	if wugongid == 265 then
		okf = 266	
	end
	--��ָ�ὣ ���ƽ��� һ�����
	if wugongid == 36 then
		okf = 245	
	end								
	--�޺�ȭ ������ һ�����
	if wugongid == 22 then
		okf = 1
	end
	--һ�ֵ罣�ܹ�����һ�����
	if wugongid == 271 then
		okf = 321	
	end		
	--���÷�ָ�����ָһ�����
	if wugongid == 136 then
		okf = 122
	end
	--���ǹ����ǹ��һ�����
	if wugongid == 200 then
		okf = 68
	end
	--�� ��ţ һ�����
	if wugongid == 193 then
		okf = 50
	end		       		
	--��Ϣ�� ���ϳ��� һ�����	����޸�
	if wugongid == 183 then
		okf = 227
	end
	return okf
end

--�����ظ�
function PNGHH_nl(id)
	for i = 1,JY.Base["�书����"] do
		local wg = JY.Person[id]["�书"..i]
		if JY.Wugong[wg]["�书����"] == 6 and  Curr_NG(id,wg) then 
			if  JY.Wugong[wg]["�㼶"] == 4 then 
				AddPersonAttrib(id,'����',2)
			elseif JY.Wugong[wg]["�㼶"] == 3 then 
				local nl = math.random(1,2)
				AddPersonAttrib(id,'����',nl)
			elseif	JY.Wugong[wg]["�㼶"] == 2  then
				AddPersonAttrib(id,'����',1)
			elseif JY.Wugong[wg]["�㼶"] == 1 and JLSD(0, 50, id) then
				AddPersonAttrib(id,'����',1)
			end
		end
	end
end

--��������
function MP_TX(mid)
    local str = ""
	if mid == 0 then --����
		str = "��������ɽ��ѧϰ���ٲ���"
    elseif mid == 1 then  --����
        str = "�ܵ��������ʽ������״̬�����׽����С����ʹ̶�60%��"
    elseif mid == 2 then --�䵱
        str = "��̫�����塿�̶�����60%����������̫����ʱ����������ֵ��̫���������ʱֻ���һ�롣ʹ��̫��ȭ��̫�������Զ�������"
	elseif mid == 3 then --��ң
		str = "��ɽ��÷�ֺ���ɽ�����Ƹ���׷�ӡ����������������������е�Ŀ�깥��ʱ�������м���һ�룬�ж�ʱС��������ж���"
	elseif mid == 6 then -- ���
		str = "�����س��15%�����������Լ�Ϊ���ĵľŹ����ڵĵ��˵Ĺ�����"
	elseif mid == 8 then --ؤ��	
		str = "ʹ�ô򹷰����ܴ�������Ҫ������30%���ʴ��������������ˡ��������и���͵��Ŀ�����ϵĽ�Ǯ��ҩ�"	
	elseif mid == 9 then --��ɽ
		str = "ʹ�ý��������������������������˺�������ʱ��������20%��"
	elseif mid == 17 then --Ѫ��
		str = "��Ѫ���Ѫ�������������ֵ�������Ѫ����ظ�������������������˺��������ƶ�ֵ�仯��"
	elseif mid == 27 then --����
		str = "�����񽣿��Դ����������壬�ʼ�Ѫ���������2�㣬���Ӻ��ڵ���һ�����ʵ�˺���"
	elseif mid == 28 then --����	
		str = "������������100�㣬���������ж����ж�����ʶ��ܱ�������Ŀ���϶�40-80�㡣"
	elseif mid == 29 then --����
		str = "��װ������������+20%����װ�����߷���+20%����װ�������Ṧ+20%����ͬһ��Ŀ�겻��ϵĹ������˺������л��湥�����������ӡ�"
    else 
        str = "��δ����"
    end
	str = str..'*���������书��������5�������˺�10%,*���������书��������8�������˺�20%,�����˺�20%��'
    return str 
end

--�ж��ؼ�
function MIJI_PD(personid,thingid,flag)
	local kfmenu = {}
	local menu = {}
	local menu1 = {}
	local kfget = {}
	for i = 1,JY.Base['�书����'] do 
		if JY.Person[personid]['�书'..i] > 0 then 
			kfget[JY.Person[personid]['�书'..i]] = 1
		end
	end
	for w = 0,JY.TejiNum -1 do 
		if JY.Teji[w]['�书����'] > 0 then
			for i = 1,JY.Teji[w]['�书����'] do
				local zkf = JY.Teji[w]['����书'..i]
				if kfget[zkf] == 1 then
					menu[#menu+1] = w
				end
			end
		end
	end

	--[[�Ķ�ע��
	for i = 1,JY.Base['�书����'] do 
		local xkf = JY.Person[personid]['�书'..i]
		for w = 0,JY.TejiNum -1 do 
			for a = 1,5 do 
				local zkf = JY.Teji[w]['����书'..a]
				if JY.Teji[w]['�书����'] > 0 and zkf > 0 then
					if xkf == zkf then 
						menu[#menu+1] = w
						--ע�Ͳ���
			           -- lib.Debug('�����书���ؼ�'..w)
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
			kfmenu[#kfmenu+1] = {menu1[w],JY.Teji[menu1[w]]['����书'..1],JY.Teji[menu1[w]]['����书'..2],JY.Teji[menu1[w]]['����书'..3],JY.Teji[menu1[w]]['����书'..4],JY.Teji[menu1[w]]['����书'..5]}
			break
		end
	end	
	--�ҳ��ؼ����� �ж��ɹ�	
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
			--ע�Ͳ���
			--lib.Debug(mid..'���ж����ؼ�'..mid..' ��'..tid..'��')

			--removebyvalue(kfmenu,kfmenu[menu[tid]],kfmenu[menu[tid]])
			--lib.Debug(#kfmenu)
			--�����Ѿ�������ؼ��еļ����书
			local znum = 0
			for w = 2,#kfmenu[tid] do 
				for i = 1,JY.Base['�书����'] do 
					if JY.Person[personid]['�书'..i] > 0 then 
						if  kfmenu[tid][w] == JY.Person[personid]['�书'..i]  then 
							znum = znum + 1							
						end	
					end
				end
			end
			--ע�Ͳ���
			--lib.Debug('��'..znum..'���书')						
			if JY.Teji[mid]['�书����'] - znum == 0 then 
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

--�����ؼ���ȷ��ʽ
function Usething_KF(personid,thingid)
	local jy = 0
	local full = 0
	local wugongid = 0
	local oldmiji = 0
	local yes, full,yes1,full1 = nil, nil, nil, nil
	local tnum = 0
	if JY.Thing[thingid]["�����书"] >= 0 then
		yes = 0
		full = 1
		wugongid = JY.Thing[thingid]["�����书"]
		for i = 1, JY.Base["�书����"] do
			if JY.Person[personid]["�书" .. i] == JY.Thing[thingid]["�����书"] then
				yes = 1
			else
				if JY.Person[personid]["�书" .. i] == 0 then
					full = 0
				end
			end
		end
	end
	if JY.Thing[thingid]["�����ؼ�"] > 0 then 
		----lib.Debug('�ж��������ؼ���'..JY.Thing[thingid]["�����ؼ�"])
		yes1 = 0
		full1 = 1
		for i = 1,10 do
			if Pmiji(personid,JY.Thing[thingid]["�����ؼ�"]) then
				DrawStrBoxWaitKey(string.format("%s �Ѿ����� %s", JY.Person[personid]["����"], JY.Teji[JY.Person[personid]["�ؼ�" .. i]]["����"]), C_ORANGE, CC.DefaultFont)
				yes1 = 1
				----lib.Debug('��ѧ��')
				break
			else
				if JY.Person[personid]["�ؼ�" .. i] == 0 then
					full1 = 0
					----lib.Debug('�и��ӿ���ѧ')
					break
				end						
			end 
		end
	end	

	if CanUseThing(thingid, personid) then
		--lib.Debug('����ʹ����Ʒ')
		--�书
		--���ɳ��и߽��书һ�����
		if JY.Thing[thingid]["����"] == 2 and JY.Thing[thingid]['�����书'] > 0 then
			local wugong = JY.Thing[thingid]['�����书']
			local kfcj = JY.Wugong[wugong]['�㼶']
			local kflx = JY.Wugong[wugong]['�书����']
			local mpmj = {}
			local pd = false 
			if JY.Wugong[wugong]['����'] == JY.Person[personid]['����'] and JY.Wugong[wugong]['����'] > 0 then 
				mpmj[#mpmj+1] = thingid
			end	
			for j = 1,#mpmj do 
				if thingid == mpmj[j]  then 
					pd = true
				end
			end
			if pd == true then 
				for i = 1,JY.Base['�书����'] do 
					local kfyes = JY.Person[personid]["�书" .. i]
					if kfyes > 0 then 
						if JY.Wugong[kfyes]['�书����'] == kflx and (kfcj < 4 or JY.Wugong[kfyes]['�书����'] == 7)  then 
							--lib.Debug(JY.Wugong[kfyes]['����']..' ���ͳɹ� '..JY.Wugong[wugong]['����']..'  �㼶'..JY.Wugong[kfyes]['�㼶']..' '..kfcj)
							if 	JY.Wugong[kfyes]['�㼶'] < kfcj  then
								--lib.Debug(JY.Wugong[kfyes]['����']..' �㼶�ɹ� '..JY.Wugong[wugong]['����'])								
								if JY.Wugong[wugong]['����'] == JY.Wugong[kfyes]['����'] and JY.Wugong[wugong]['����'] == JY.Person[personid]['����'] then 
									--lib.Debug(JY.Wugong[kfyes]['����']..' ���ɳɹ� '..JY.Wugong[wugong]['����'])
									if  PersonKF(personid, wugong) == false then 										
										if DrawStrBoxYesNo(-1, -1, MP_name(personid).."�书һ����У��Ƿ�"..JY.Wugong[kfyes]['����']..'ϴΪ'..JY.Wugong[wugong]['����']..'?', C_WHITE, CC.DefaultFont) then
											--JY.Person[personid]["�书" .. i] = wugong
											--JY.Person[personid]["�书�ȼ�" .. i] = 50
											instruct_33(personid,wugong,50)
											if JY.Person[personid]["�츳�ڹ�"] == kfyes then
												JY.Person[personid]["�츳�ڹ�"] = wugong
											elseif JY.Person[personid]["�츳�Ṧ"] == kfyes then
												JY.Person[personid]["�츳�Ṧ"] = wugong
											elseif JY.Person[personid]["�츳�⹦1"] == kfyes then
												JY.Person[personid]["�츳�⹦1"] = wugong
											elseif JY.Person[personid]["�츳�⹦2"] == kfyes then
												JY.Person[personid]["�츳�⹦2"] = wugong
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
		local nkf = JY.Thing[thingid]['�����书']
		--���֡��䵱����ü������һ����о�����
		if thingid == 83 then
			local n = {
						{241,"�䵱������"},
						{242,"��ü������"},
						{243,"���־�����"}
						}
			local k;
			local d;
			for i = 1,JY.Base["�书����"] do
				for j = 1,#n do
					if JY.Person[personid]["�书"..i] == n[j][1] then
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
		--��ϼһ������������������ϼ�Ŀ���������ѧ��������
		if thingid == 299 then
			okf = 89
		end
		--�޺�һ�����
		if thingid == 90 then 
			okf = 1
		end
		--Ѫ����ħ��һ�����
		if thingid == 327 then
			okf = 163
		end
		--ʨ�Ӻ���ʨ�Ӻ�һ�����
		if thingid == 385 then
			okf = 92
		end
		--��󡹦��Ϣ��һ�����
		if thingid == 308 then
			okf = 95
		end
		--���ճ���һ�����
		if thingid == 342 then
			okf = 94
		end
		--��Ů���� ��Ů���Ľ� һ�����
		if thingid == 350 then
			okf = 42
		end
		--�䵱�ķ�һ��̫��
		if thingid == 295 then 
			okf = 209
		end		
		--�����ķ� �׽һ�����
		if thingid == 85 then
			okf = 208
		end
		--ȫ���ķ� ���칦һ�����
		if thingid == 77 then
			okf = 210
		end
		--������һ��������
		if thingid == 351 then 
			okf= 217 
		end
		--��Ĺ�ķ� ��Ů�ľ� һ�����
		if thingid == 280 then
			okf = 211
		end
		--��ɽ�ķ� �������� һ�����
		if thingid == 366 then
			okf = 213
		end
		--�ػ� ʥ���� һ�����
		if thingid == 70 then
			okf = 217
		end
		--С���칦�����칦һ�����
		if thingid == 328 then
			okf = 225
		end
		--һ�ֵ罣�ܹ�����һ�����
		if thingid == 428 then
			okf = 321
		end
		--���÷�ָ�����ָһ�����
		if thingid == 269 then
			okf = 122
		end
		--���ǹ����ǹ��һ�����
		if thingid == 386 then
			okf = 68
		end
		--���Ͻ��� �������� һ�����
		if thingid == 422 then
			okf = 266
		end
		--�� ��ţ һ�����
		if thingid == 331 then
			okf = 50
		end
		--��Ϣ�� ���ϳ��� һ�����	����޸�
		if thingid == 317 then
			okf = 227
		end
		--Ѫ���ķ� Ѫ��һ�����
		if thingid == 285 then	
			okf = 214
		end

		if PersonKF(personid, okf) and PersonKF(personid, nkf) == false then
			if DrawStrBoxYesNo(-1, -1, JY.Wugong[nkf]['����']..JY.Wugong[okf]['����'].."һ����У��Ƿ�"..JY.Wugong[okf]['����'].."ϴΪ"..JY.Wugong[nkf]['����'].."?", C_WHITE, CC.DefaultFont) then
				for i = 1, JY.Base["�书����"] do
					if JY.Person[personid]["�书" .. i] == okf then
						JY.Person[personid]["�书" .. i] = nkf
						JY.Person[personid]["�书�ȼ�" .. i] = 50
						if JY.Person[personid]["�츳�ڹ�"] == okf then
							JY.Person[personid]["�츳�ڹ�"] = nkf								
						end
						if JY.Person[personid]["�츳�Ṧ"] == okf then
							JY.Person[personid]["�츳�Ṧ"] = nkf								
						end
						if JY.Person[personid]["�츳�⹦1"] == okf then
							JY.Person[personid]["�츳�⹦1"] = nkf								
						end
						if JY.Person[personid]["�츳�⹦2"] == okf then
							JY.Person[personid]["�츳�⹦2"] = nkf								
						end
						MIJI_PD(personid,thingid)
						yes = 2
						break
					end
				end
			end
		end
		--����Ѿ����书����ѡ����书û��ѧ�ᣬ�򲻿�װ������
		if yes == 0 and full == 1 then
			DrawStrBoxWaitKey("�����书���Ѵﱾ��Ŀ����", C_WHITE, CC.DefaultFont)
			return 0
		end	
		--������Ѩ��
		if CC.Shemale2[thingid] == 1 then
			if personid == 0 and CC.TX["Ц��а��"] == 2 then
				yes = 2
			elseif personid == 92 then
				say("�����һ���Ҫ����",92,1)
				return 0
			elseif JY.Person[personid]["�Ա�"] == 0 and CanUseThing(thingid, personid) then
				Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
				if DrawStrBoxYesNo(-1, -1, "������������Ȼӵ��Թ����Ƿ���Ҫ����?", C_WHITE, CC.DefaultFont) == false then
					--instruct_2(93,1)
					return 0
				else
					lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_RED, 128)
					ShowScreen()
					lib.Delay(80)
					lib.ShowSlow(15, 1)
					Cls()
					lib.ShowSlow(50, 0)
					JY.Person[personid]["�Ա�"] = 2
					local add, str = AddPersonAttrib(personid, "������", -20)
					DrawStrBoxWaitKey(JY.Person[personid]["����"] .. str, C_ORANGE, CC.DefaultFont)
					add, str = AddPersonAttrib(personid, "������", -30)
					DrawStrBoxWaitKey(JY.Person[personid]["����"] .. str, C_ORANGE, CC.DefaultFont)
					if JY.Base["��׼"] > 0 then
						JY.Person[0]["���"] = "����"
						JY.Person[0]["���2"] = "Ѿͷ"
						local zddh = 227
						local js = JY.Base["��׼"]
						local jsdz = JY.Person[0]["ͷ�����"]
						if js == 3 then
						jsdz = 228
						elseif js == 4 then
						jsdz = 229
						elseif js == 5 then
						jsdz = 230
						else
						jsdz = 227
						end
						JY.Person[0]["������"] = 555+JY.Base["��׼"]
						local f_ani = {
						{0, 0, 0}, 
						{9, 9, 7}, 
						{8, 8, 6}, 
						{8, 8, 6}, 
						{9, 7, 7}}
						for i = 1, 5 do
							JY.Person[0]["���ж���֡��" .. i] = f_ani[i][1]
							JY.Person[0]["���ж����ӳ�" .. i] = f_ani[i][3]
							JY.Person[0]["�书��Ч�ӳ�" .. i] = f_ani[i][2]
						end
					end
				end

			elseif JY.Person[personid]["�Ա�"] == 1 then
				DrawStrBoxWaitKey("���˲��ʺ���������Ʒ", C_WHITE, CC.DefaultFont)
				return 0
			end
		end				
		--��������
		if CC.Shemale[thingid] == 1 then
			--lib.Debug('����ѧ����')
			--�������ֱ��ѧ
			if (personid == 0 and JY.Base["��׼"] == 3) or (personid == 0 and JY.Base["����"] == 652 ) or (personid == 0 and JY.Base["����"] == 189 ) then
				say("�š����ҿ����������书�ľ���֮����ʵ�������Ƿ��Թ�����������Խ�����˷�������⣡",0,1)
				yes = 2
				--lib.Debug('�������ֱ��ѧ')
			--���Ǵ�Ӯ�������ߣ�����ֱ��ѧ
			elseif personid == 0 and CC.TX["Ц��а��"] == 2 then
				yes = 2
				--lib.Debug('Ц��а�߿���ֱ��ѧ')
			elseif personid == 92 then
				say("�����һ���Ҫ����",92,1)
				return 0
			elseif JY.Person[personid]["�Ա�"] == 0 and CanUseThing(thingid, personid) then
				--lib.Debug('����ѧ����')
				Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
				if DrawStrBoxYesNo(-1, -1, "������������Ȼӵ��Թ����Ƿ���Ҫ����?", C_WHITE, CC.DefaultFont) == false then
					return 0
				else
					lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_RED, 128)
					ShowScreen()
					lib.Delay(80)
					lib.ShowSlow(15, 1)
					Cls()
					lib.ShowSlow(50, 0)
					JY.Person[personid]["�Ա�"] = 2
					local add, str = AddPersonAttrib(personid, "������", -20)
					DrawStrBoxWaitKey(JY.Person[personid]["����"] .. str, C_ORANGE, CC.DefaultFont)
					add, str = AddPersonAttrib(personid, "������", -30)
					DrawStrBoxWaitKey(JY.Person[personid]["����"] .. str, C_ORANGE, CC.DefaultFont)
					if JY.Base["��׼"] > 0 then
						JY.Person[0]["���"] = "����"
						JY.Person[0]["���2"] = "Ѿͷ"
						local zddh = 227
						local js = JY.Base["��׼"]
						local jsdz = JY.Person[0]["ͷ�����"]
						if js == 3 then
						jsdz = 228
						elseif js == 4 then
						jsdz = 229
						elseif js == 5 then
						jsdz = 230
						else
						jsdz = 227
						end
						JY.Person[0]["������"] = 555+JY.Base["��׼"]
						local f_ani = {
						{0, 0, 0}, 
						{9, 9, 7}, 
						{8, 8, 6}, 
						{8, 8, 6}, 
						{9, 7, 7}}
						for i = 1, 5 do
							JY.Person[0]["���ж���֡��" .. i] = f_ani[i][1]
							JY.Person[0]["���ж����ӳ�" .. i] = f_ani[i][3]
							JY.Person[0]["�书��Ч�ӳ�" .. i] = f_ani[i][2]
						end
					end
				end

			elseif JY.Person[personid]["�Ա�"] == 1 then
				DrawStrBoxWaitKey("���˲��ʺ���������Ʒ", C_WHITE, CC.DefaultFont)
				return 0
			end
		end	
		if JY.Thing[thingid]["����"] == 2 and  JY.Thing[thingid]["�����书"] < 1 and  JY.Thing[thingid]["�����ؼ�"] < 1  then	
			--lib.Debug(JY.Person[0]["����"].."����"..JY.Thing[thingid]["����"].."�ɹ�")				
			AddPersonAttrib(personid, "�������ֵ", JY.Thing[thingid]["���������ֵ"]*10)
			AddPersonAttrib(personid, "������", JY.Thing[thingid]["�ӹ�����"]*10)
			AddPersonAttrib(personid, "�Ṧ", JY.Thing[thingid]["���Ṧ"]*10)
			AddPersonAttrib(personid, "������", JY.Thing[thingid]["�ӷ�����"]*10)
			AddPersonAttrib(personid, "ҽ������", JY.Thing[thingid]["��ҽ������"]*10)
			AddPersonAttrib(personid, "�ö�����", JY.Thing[thingid]["���ö�����"]*10)
			AddPersonAttrib(personid, "�ⶾ����", JY.Thing[thingid]["�ӽⶾ����"]*10)
			AddPersonAttrib(personid, "��������", JY.Thing[thingid]["�ӿ�������"]*10)
			DrawStrBoxWaitKey(JY.Person[personid]["����"].."����"..JY.Thing[thingid]["����"].."�ɹ�", C_GOLD, CC.DefaultFont,nil, C_RED)
		end	
		--if yes == 2 then 
		--ѧ���书�򼤻��ؼ�		
		if (yes == 0 or yes == 2) and full == 0  then
			local kfnum = nil
			local oldwugong = 0
			local oldmiji = 0
			local pid = personid
			local thingid = thingid
			local p = JY.Person[pid]
			--�书				
			for i = 1, JY.Base["�书����"] do
				if JY.Person[personid]["�书" .. i] == JY.Thing[thingid]["�����书"] then
					DrawStrBoxWaitKey(string.format("%s �Ѿ�ѧ�� %s", JY.Person[personid]["����"], JY.Wugong[wugongid]["����"]), C_ORANGE, CC.DefaultFont)
					oldwugong = 1
				end 
				if oldwugong == 0 then
					----lib.Debug('�������书')
					if JY.Person[personid]["�书" .. i] == 0 then
						JY.Person[personid]["�书" .. i] = wugongid
						JY.Person[personid]["�书�ȼ�" .. i] = 0;
						kfnum = i
						KF_zsset(personid,wugongid)
						--instruct_2(thingid,-1)
						--ѧ���ؼ���ת
						if thingid == 118 then 
							instruct_68(personid,3,1)
						end
						DrawStrBoxWaitKey(string.format("%s ѧ�����书 %s ", JY.Person[personid]["����"], JY.Wugong[wugongid]["����"]), C_ORANGE, CC.DefaultFont)
						MIJI_PD(personid,thingid)
						AddPersonAttrib(pid, "�������ֵ", JY.Thing[thingid]["���������ֵ"])
						--����Ѫ����������
						--���Ʋ���
						if thingid == 139 and match_ID(pid, 37) == false then
							AddPersonAttrib(pid, "�������ֵ", -15)
							AddPersonAttrib(pid, "����", -15)
							if JY.Person[pid]["�������ֵ"] < 1 then
							JY.Person[pid]["�������ֵ"] = 1
							end
						end
						if JY.Person[pid]["����"] < 1 then
							JY.Person[pid]["����"] = 1
						end
						if JY.Thing[thingid]["�ı���������"] == 2 and JY.Person[pid]["��������"] ~= 3 and match_ID(pid, 9987)==false then
							p["��������"] = 2
							if match_ID(pid, 9771) then
								JY.Person[pid]["��������"] = 1
							end
						end
					
						local xsbs = 1
						local swbs = 1	
						local bqz = 0
						local bqz1 = 0 					
						if match_ID(pid, 9928) or match_ID(pid, 9862) then		--��� ˫������ֵ
							swbs = 2
						end
						if match_ID(pid, 9928) or match_ID(pid, 9863) then
							xsbs = 2
						end
						
						if match_ID(pid,9947) then
							for i = 1, JY.Base["�书����"] do					  
								if JY.Thing[thingid]["�����书"] == JY.Person[pid]["�书" .. i]  and JY.Wugong[wugongid]["�书����"] == 6 then 
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
						
						AddPersonAttrib(pid, "������", JY.Thing[thingid]["�ӹ�����"]*swbs)
						AddPersonAttrib(pid, "�Ṧ", JY.Thing[thingid]["���Ṧ"]*swbs)
						AddPersonAttrib(pid, "������", JY.Thing[thingid]["�ӷ�����"]*swbs)
						AddPersonAttrib(pid, "�������ֵ", JY.Thing[thingid]["���������ֵ"])
						AddPersonAttrib(pid, "ҽ������", JY.Thing[thingid]["��ҽ������"])
						AddPersonAttrib(pid, "�ö�����", JY.Thing[thingid]["���ö�����"])
						AddPersonAttrib(pid, "�ⶾ����", JY.Thing[thingid]["�ӽⶾ����"])
						AddPersonAttrib(pid, "��������", JY.Thing[thingid]["�ӿ�������"])

						AddPersonAttrib(pid, "ȭ�ƹ���", JY.Thing[thingid]["��ȭ�ƹ���"]*xsbs*qf+bqz1)
						AddPersonAttrib(pid, "ָ������", JY.Thing[thingid]["��ָ������"]*xsbs*zf+bqz1)
						AddPersonAttrib(pid, "��������", JY.Thing[thingid]["����������"]*xsbs*jf+bqz1)
						AddPersonAttrib(pid, "ˣ������", JY.Thing[thingid]["��ˣ������"]*xsbs*df+bqz1)
						AddPersonAttrib(pid, "�������", JY.Thing[thingid]["���������"]*xsbs*qm+bqz1)
					
						AddPersonAttrib(pid, "��������", JY.Thing[thingid]["�Ӱ�������"])
						AddPersonAttrib(pid, "��ѧ��ʶ", JY.Thing[thingid]["����ѧ��ʶ"])
						--AddPersonAttrib(pid, "Ʒ��", JY.Thing[thingid]["��Ʒ��"])
						AddPersonAttrib(pid, "��������", JY.Thing[thingid]["�ӹ�������"])
						--�һ�����
						break;
					end					
				end
			end
		end
		--if pmiji(personid,miji) then 
		if yes1 == 0 and full1 == 0 then
			local pid = personid
			local p = JY.Person[pid]
			--�ؼ�					
			local pd = false
			local miji = JY.Thing[thingid]["�����ؼ�"]
			if thingid == 372 then
				----lib.Debug('�ж������ؼ��ɹ�')
				if Pmiji(personid,1) or Pmiji(personid,2) then
					pd = true
					----lib.Debug('�ж��ѻ�ѧ')
				end																								
				if pd == false then		
					local r = LGMsgBox("��ѡ��", "��Ϊ��ӹ֮����*һ������֮ν��*��������֮ν��", {"һ","��"}, 2, 189)		
					if r == 1  then							
						instruct_68(personid,1,1)
						return 1
					elseif r == 2  then								
						instruct_68(personid,2,1)
						return 1	
					end
				else
					DrawStrBoxWaitKey(string.format("%s �Ѿ����� %s", JY.Person[personid]["����"], "��ӹ֮��"), C_ORANGE, CC.DefaultFont)
					return 1
				end	
			else	
				AddPersonAttrib(personid, "�������ֵ", JY.Thing[thingid]["���������ֵ"]*10)
				AddPersonAttrib(personid, "������", JY.Thing[thingid]["�ӹ�����"]*10)
				AddPersonAttrib(personid, "�Ṧ", JY.Thing[thingid]["���Ṧ"]*10)
				AddPersonAttrib(personid, "������", JY.Thing[thingid]["�ӷ�����"]*10)
				AddPersonAttrib(personid, "ҽ������", JY.Thing[thingid]["��ҽ������"]*10)
				AddPersonAttrib(personid, "�ö�����", JY.Thing[thingid]["���ö�����"]*10)
				AddPersonAttrib(personid, "�ⶾ����", JY.Thing[thingid]["�ӽⶾ����"]*10)
				AddPersonAttrib(personid, "��������", JY.Thing[thingid]["�ӿ�������"]*10)
				AddPersonAttrib(personid, "ȭ�ƹ���", JY.Thing[thingid]["��ȭ�ƹ���"]*10)
				AddPersonAttrib(personid, "ָ������", JY.Thing[thingid]["��ָ������"]*10)
				AddPersonAttrib(personid, "��������", JY.Thing[thingid]["����������"]*10)
				AddPersonAttrib(personid, "ˣ������", JY.Thing[thingid]["��ˣ������"]*10)
				AddPersonAttrib(personid, "�������", JY.Thing[thingid]["���������"]*10)
				AddPersonAttrib(personid, "��������", JY.Thing[thingid]["�Ӱ�������"]*10)
				AddPersonAttrib(personid, "����", JY.Thing[thingid]["������"]*10)
				AddPersonAttrib(personid, "��", JY.Thing[thingid]["���м�"]*10)
				AddPersonAttrib(personid, "��������", JY.Thing[thingid]["�ӹ�������"]*10)
				instruct_68(personid,JY.Thing[thingid]["�����ؼ�"],1)
				return 1
			end				
		end	
	else
		DrawStrBoxWaitKey("���˲��ʺ���������Ʒ", C_WHITE, CC.DefaultFont)
		return 0				
	end				
end

---���ؼ��书����������
function KF_addsx(pid,lvkf)
	local wugonglx = JY.Wugong[lvkf]['�书����']
	local wugonglv = JY.Wugong[lvkf]['�㼶']
	local xsbs,swbs,bqz,bqz1 = 1,1,0,0				
	if  match_ID(pid, 9928) or match_ID(pid, 9862) then		--��� ˫������ֵ
		swbs = 2
	end
	if  match_ID(pid, 9928) or match_ID(pid, 9863) then
		xsbs = 2
	end
	local p = JY.Person[pid]
	if KF_thing(lvkf) == nil then 
	   if wugonglx == 1 then 
			AddPersonAttrib(pid,'������',(wugonglv+1)*swbs)
			AddPersonAttrib(pid,'ȭ�ƹ���',(wugonglv+1)*xsbs)
			--lib.Debug('����ȭ�ƹ���'..(wugonglv+1)*xsbs)
			--lib.Debug('���ӹ�����'..(wugonglv+1)*swbs)
	   end 
	   if wugonglx == 2 then 
			AddPersonAttrib(pid,'������',(wugonglv+1)*swbs)
			AddPersonAttrib(pid,'ָ������',(wugonglv+1)*xsbs)
			--lib.Debug('����ָ������'..(wugonglv+1)*xsbs)
			--lib.Debug('���ӹ�����'..(wugonglv+1)*swbs)
		end 
		if wugonglx == 3 then 
			AddPersonAttrib(pid,'������',wugonglv*swbs)
			AddPersonAttrib(pid,'�Ṧ',1*swbs)
			AddPersonAttrib(pid,'��������',(wugonglv+1)*xsbs)
			--lib.Debug('������������'..(wugonglv+1)*xsbs)
			--lib.Debug('���ӹ�����'..wugonglv*swbs)
			--lib.Debug('�����Ṧ'..1*swbs)
		end 
		if wugonglx == 4 then 
			AddPersonAttrib(pid,'������',(wugonglv+1)*swbs)
			AddPersonAttrib(pid,'ˣ������',(wugonglv+1)*xsbs)
			--lib.Debug('����ˣ������'..(wugonglv+1)*xsbs)
			--lib.Debug('���ӹ�����'..(wugonglv+1)*swbs)
		end 
		if wugonglx == 5 then 
			AddPersonAttrib(pid,'������',wugonglv*swbs)
			AddPersonAttrib(pid,'������',1*swbs)
			AddPersonAttrib(pid,'������� ',(wugonglv+1)*xsbs)
			--lib.Debug('�����������'..(wugonglv+1)*xsbs)
			--lib.Debug('���ӹ�����'..wugonglv*swbs)
			--lib.Debug('���ӷ�����'..1*swbs)
		end 
		if wugonglx == 6 then 
			AddPersonAttrib(pid,'������',1*swbs)
			AddPersonAttrib(pid,'������',wugonglv*swbs)
			--lib.Debug('���ӷ�����'..wugonglv*xsbs)
			--lib.Debug('���ӹ�����'..1*swbs)
		end 
		if wugonglx == 7 then 
			AddPersonAttrib(pid,'�Ṧ',(wugonglv+1)*swbs)
			--lib.Debug('�����Ṧ'..(wugonglv+1)*swbs)
		end
	else 
		local thingid = KF_thing(lvkf)
		AddPersonAttrib(pid, "�������ֵ", JY.Thing[thingid]["���������ֵ"])
		--����Ѫ����������
		--���Ʋ���
		if thingid == 139 and match_ID(pid, 37) == false then
			AddPersonAttrib(pid, "�������ֵ", -15)
			AddPersonAttrib(pid, "����", -15)
			if JY.Person[pid]["�������ֵ"] < 1 then
				JY.Person[pid]["�������ֵ"] = 1
			end
		end
		if JY.Person[pid]["����"] < 1 then
			JY.Person[pid]["����"] = 1
		end
		if JY.Thing[thingid]["�ı���������"] == 2 and JY.Person[pid]["��������"] ~= 3 and match_ID(pid, 9987)==false then
			p["��������"] = 2
			if match_ID(pid, 9771) then
				JY.Person[pid]["��������"] = 1
			end
		end						

		if match_ID(pid,9947) then
			for i = 1, JY.Base["�书����"] do					  
				if JY.Thing[thingid]["�����书"] == JY.Person[pid]["�书" .. i]  and JY.Wugong[lvkf]["�书����"] == 6 then 
				bqz = bqz + 1						
				end	
			end	
			bqz1 = bqz*20
		end
		local qf,zf,jf,df,qm = Pqfcz(pid)/100,Pzfcz(pid)/100,Pjfcz(pid)/100, Pdfcz(pid)/100,Pqmcz(pid)/100						
		AddPersonAttrib(pid, "������", JY.Thing[thingid]["�ӹ�����"]*swbs)
		AddPersonAttrib(pid, "�Ṧ", JY.Thing[thingid]["���Ṧ"]*swbs)
		AddPersonAttrib(pid, "������", JY.Thing[thingid]["�ӷ�����"]*swbs)
		AddPersonAttrib(pid, "�������ֵ", JY.Thing[thingid]["���������ֵ"])
		AddPersonAttrib(pid, "ҽ������", JY.Thing[thingid]["��ҽ������"])
		AddPersonAttrib(pid, "�ö�����", JY.Thing[thingid]["���ö�����"])
		AddPersonAttrib(pid, "�ⶾ����", JY.Thing[thingid]["�ӽⶾ����"])
		AddPersonAttrib(pid, "��������", JY.Thing[thingid]["�ӿ�������"])
		AddPersonAttrib(pid, "ȭ�ƹ���", JY.Thing[thingid]["��ȭ�ƹ���"]*xsbs*qf+bqz1)
		AddPersonAttrib(pid, "ָ������", JY.Thing[thingid]["��ָ������"]*xsbs*zf+bqz1)
		AddPersonAttrib(pid, "��������", JY.Thing[thingid]["����������"]*xsbs*jf+bqz1)
		AddPersonAttrib(pid, "ˣ������", JY.Thing[thingid]["��ˣ������"]*xsbs*df+bqz1)
		AddPersonAttrib(pid, "�������", JY.Thing[thingid]["���������"]*xsbs*qm+bqz1)		
		AddPersonAttrib(pid, "��������", JY.Thing[thingid]["�Ӱ�������"])
		AddPersonAttrib(pid, "��ѧ��ʶ", JY.Thing[thingid]["����ѧ��ʶ"])
		AddPersonAttrib(pid, "Ʒ��", JY.Thing[thingid]["��Ʒ��"])
		AddPersonAttrib(pid, "��������", JY.Thing[thingid]["�ӹ�������"])
	end
end

--���ѻ����趨
function Menu_duiyou(id)
    local bx,by = CC.WX,CC.HY
	local size =CC.DefaultFont
	local x,y = CC.ScreenW/2+size*2,CC.ScreenH/2-size*2
	local str
	local function rudui(id)
		if instruct_20(20,0) ==false then    --  20(14):�����Ƿ�����������ת��:Label1
			instruct_10(id);   --  10(A):��������������
			instruct_14();   --  14(E):�������
			instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			if id == 49 then 
				instruct_3(-2,11,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			end
			instruct_0();   --  0(0)::�����(����)
			instruct_13();   --  13(D):������ʾ����
			do return; end
		end    --:Label1
		say("��Ķ������������޷����롣", id,0);
		instruct_0();   --  0(0)::�����(����)
	end
	local function psay(id)
		local sm = ""
		if JY.Person[id]['�Ա�'] == 1 then
			local ms = {"���Ҹ�����һ��ս��,������Ҷ���ĺøжȡ�","��������Ҳ����Ѹ����ߺøе�;��Ŷ��","����������������̫�����ˣ���������ҳ���תת�ɡ�","��ֻҪ���ܱ���������ĺܡ�"}
			sm = ms[math.random(#ms)]
		else
			sm = "����Ҫ�Ұ�æ�ĵط���"
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
            thid = JY.Base["��Ʒ" .. i + 1]
            if thid >= 0 then
                if JY.Thing[thid]["��������"] == lwlx then
                    thing[num] = thid
                    thingnum[num] = JY.Base["��Ʒ����" .. i + 1]
                    num = num + 1
                end	
            end
        end
        local r = SelectThing(thing, thingnum)
        if r > 0 then 
            local n = math.random(5,10)
            JY.Person[id]['�ø�'] = JY.Person[id]['�ø�'] + n
            DrawStrBoxWaitKey(JY.Person[id]['����']..'�ø�����'..n..'��', C_WHITE, CC.DefaultFont)
            instruct_2(r,-1)
            Cls()
        end
        return 0
	end
	local function hun(id)
        local pd = 1 
        local pdmenu = {{57,56},{19,79},{55,626},{57,626},{250,582},{43,582},{165,81},{3,545}}
        for i = 1,#pdmenu do 
            if JY.Base['����'] == pdmenu[i][1] and id == pdmenu[i][2] then 
                pd = 0
            end
        end
		if id == 171 or id == 172 then 
			pd = 0 
		end
        if JY.Person[id]['�ø�'] >= 100 and JY.Person[0]['�Ա�'] == 0 and pd == 1  then 
            say("��������ʯ��檵�����έ����έ����˿����ʯ��ת�ơ��������ң�����ͬѨ��ū�����������ڹ����ˡ�", id,0); 
            Cls()
            say("�ز���������顣", 0,1); 
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

            say("����������һ�õ�Լ����Ե���ᣬƥ��ͬ�ơ��������һ����ƣ������˼ң������������࣬�������㡣���԰�ͷ֮Լ�������㣬�ý���Ҷ֮�ˣ�����ԧ�ס���֤��",33, 0,"����")
            Cls()
            say("άȵ�г���ά��֮��֮���ڹ飬������֮��άȵ�г���ά𯷽֮��֮���ڹ飬������֮��άȵ�г���ά�ӯ֮��֮���ڹ飬������֮����֤��",256, 0,"����")
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
            JY.Base['����'] = id
            JY.Base['���ʱ��'] = CC.Year
        else
            if pd == 0 then 
                say("...��Ҳ����������ҵĹ�ϵ��", id,0); 
            elseif JY.Person[0]['�Ա�'] == 0 then 
                say("...�㻹����", id,0);
            else
		        say("���ǵĸ���Ļ�û�е���һ����", id,0); 
            end
        end
	end
	local function Est()
		return 0
	end	

	if JY.Person[id]['�Ա�'] == 1 then
	  	str = {{"��    ��","�������","��    ��","��    ��","��    ��"},{psay,rudui,plw,hun,Est}}
	else
	  	str = {{"��    ��","�������","��    ��"},{psay,rudui,Est}}
	end
	local r = LGMsgBox("��ѡ��", "��������Ҫ�Ұ�æ�ĵط���", str[1], #str[1], id,1)
	if r > 0 then
		str[2][r](id)
	end
end

--�ɾ�
function LGCHENGJIU()
	local bx,by = CC.WX,CC.HY
	local menu = {	{"һ�ﵱǧ","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣"},
					{"һ�ﵱǧ","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣"},
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
	local tmenu = {'ͨ�ؼ�¼','�ɾͼ���'}
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
				local pgmenu = {"��ҳ","��ҳ"}
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
			lib.DrawStr(tx+size*6,size*1.8,"�����"..cj.."/�ܳɾ�"..#CC.Personcj,C_WHITE,size*1,CONFIG.CurrentPath.."FONT/4.TTF",  0, 0)
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
							local wjx = {"��","���","����","�����","������",}
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
								DrawString(tx+CC.ScreenW/2.804+w*m+(j-1)*size/3*2,ty+n*h+ h1*size,"��",C_RED,size)														
							end
							if px > tx+CC.ScreenW/2.931+w*m and px < tx+CC.ScreenW/2.931+w*m + CC.ScreenW/15.1111 and py > ty+CC.ScreenH/40.421+n*h and  py < ty+CC.ScreenH/9.4815+n*h then 
								lib.LoadPNG(91,37*2,tx+CC.ScreenW/4.5333+w*m,ty+CC.ScreenH/40.421+n*h,1)
								if CC.Personcj[i][6] == 1 then 
									str = "��������"..CC.Personcj[i][2].."+".. CC.Personcj[i][3] 
								elseif 	CC.Personcj[i][6] == 2 then 
									str = "���û����Ʒ"..JY.Thing[CC.Personcj[i][2]]["����"]
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
			local tgwz = "����ͨ�ؼ�¼"
			lib.LoadPNG(91,140*2,CC.ScreenW/2-string.len(tgwz)/4*size*2-size,0,1,0,200)
			DrawString(CC.ScreenW/2-string.len(tgwz)/4*size*2-size,by*15," ����ͨ�ؼ�¼",C_WHITE,size*2,CC.FONT2)
			
			DrawString(CC.ScreenW - 148,CC.ScreenH - 40,"��ESC���˳�",LimeGreen,CC.FontSmall)
			
			local n = 0
			
			for i = #Achievements.pChar, 1, -1 do
				n = n + 1
				if n > 5 then
					break
				end
				local nd = Achievements.pChar[i].DiffLevel
				local zz = tostring(Achievements.pChar[i].CharZZ.."��")
				local ns = Achievements.pChar[i].CharNS
				local tp = Achievements.pChar[i].CharType
				local nm = Achievements.pChar[i].CharName
				local dt = Achievements.pChar[i].TimeCompleted
				DrawString(45,-10+110*n,string.format("%d��Ŀ",i),C_GOLD,CC.DefaultFont)
				DrawString(45,40+110*n,string.format("��%-d %-5s %-4s %-4s %-10s ͨ��ʱ�� %s",nd, zz ,ns, tp, nm, dt),C_WHITE,CC.DefaultFont)
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

--�书��ʽ����
function KF_zswl(pid,wg,choice)
	local n = 0
	local level = 0
	local wl = 0
	local n = 0	
	for i = 1,JY.Base["�书����"] do
		if JY.Person[pid]["�书"..i] == wg then				
			level = math.modf(JY.Person[pid]["�书�ȼ�" .. i] / 100) + 1
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

--��ʼ�书�趨
function KfSet(p)
	--��ʼ�书�趨
	local pid = p
	local num = 0
	local ngmenu = {}
	local wgmenu = {}
	local qgmenu = {}
	local num1,num2 = 0,0 
	local wgnum = JY.Base["�书����"] 
	local wglv = 0
	local mp = JY.Person[pid]['����']
	----------------------------------------------
	----------------------------------------------
	--�������123��ʲô���𣿣���
	if JY.Person[pid]['����ֽ�'] <= 2 then 
		wglv = 2
	end 
	if JY.Person[pid]['����ֽ�'] == 3 then 
		wglv = 2
	end  	
	----------------------------------------------
	----------------------------------------------
	--�Ķ�ע��
	--�����������ѧ���
	--�ж��Ѿ�ѧ���ڼ����书λ��
	--�ж��Ѿ�ѧ���书
	local kfnext = 0
	local kfget = {}
	for i = 1, wgnum do
		if JY.Person[pid]['�书'..i] > 0 then 
			kfget[JY.Person[pid]['�书'..i]] = 1
		else
			kfnext = i
			break
		end
	end


	if CC.MpKf[mp] ~= nil then
		for i = 1,#CC.MpKf[mp] do
			local kf = CC.MpKf[mp][i]
			if kfnext <= 15 then
				if JY.Person[pid]['����ֽ�'] <= 3 then
					if kfget[kf] == nil and JY.Wugong[kf]['�㼶'] >= 2 then
						JY.Person[pid]['�书'..kfnext] = kf
						JY.Person[pid]['�书�ȼ�'..kfnext] = 999
						KF_addsx(pid,kf)
						kfnext = kfnext + 1
						kfget[kf] = 1
					end
				elseif JY.Person[pid]['����ֽ�'] > 3 and JY.Person[pid]['����ֽ�'] <= 5 then 
					if kfget[kf] == nil and JY.Wugong[kf]['�㼶'] < 1 then
						JY.Person[pid]['�书'..kfnext] = kf
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
	for i = 1, JY.Base["�书����"] do
		if JY.Person[pid]["�书"..i] > 0 then 
			local wugonglvl = math.modf(JY.Person[pid]["�书�ȼ�" .. i] / 100) + 1
			local kfid = JY.Person[pid]["�书"..i]
			local wugongwl = get_skill_power(pid, kfid, wugonglvl)
			local kflx = JY.Wugong[kfid]['�书����']
			if JY.Wugong[kfid]["�书����"] < 6 and kfid > 0    then
				wgmenu[#wgmenu+1] = {kfid,wugongwl,kflx}
				num1 = num1 + 1	
			elseif JY.Wugong[kfid]["�书����"] == 6 and kfid > 0 then
				num = num + 1
				ngmenu[#ngmenu+1] = {kfid,wugongwl}
			elseif JY.Wugong[kfid]["�书����"] == 7 and kfid > 0 then
				num2 = num2 + 1
				local ms = JY.Wugong[kfid]["������"] + JY.Wugong[kfid]["������"]
				qgmenu[#qgmenu+1] = {kfid,ms}	
			end
		end
	end
	--�⹦ 
	if JY.Person[pid]['����ʹ��'] == 0 then 
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
			local p_5x = {JY.Person[pid]['ȭ�ƹ���'],JY.Person[pid]['ָ������'],JY.Person[pid]['��������'],JY.Person[pid]['ˣ������'],JY.Person[pid]['�������']}
			local key1,max1 = 1,p_5x[1]
			for k1,v1 in ipairs(p_5x) do 
				if p_5x[k1] > max1 then 
					key1,max1 = k1,v1 
				end
			end
			if wgmenu[key][3] == key1 then 			
				JY.Person[pid]["����ʹ��"] = wgmenu[key][1]
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
				JY.Person[pid]["����ʹ��"] = kfwg1[key2]
			end
		else
			local wgmenu1 = {}
			local wgmenu2 = {}
			local wgmenu3 = {}
			local wgmenu4 = {}
			for i = 0,JY.WugongNum - 1 do
				if JY.Wugong[i]['�书����'] < 6  then
					if JY.Wugong[i]['�㼶'] == 1 then 
						wgmenu1[#wgmenu1+1] = i
					end
					if JY.Wugong[i]['�㼶'] == 2 then 
						wgmenu2[#wgmenu2+1] = i
					end
					if JY.Wugong[i]['�㼶'] == 3 then 
						wgmenu3[#wgmenu3+1] = i
					end
					if JY.Wugong[i]['�㼶'] == 4 then 
						wgmenu4[#wgmenu4+1] = i
					end																					
				end 
			end
			if JY.Person[pid]['����ֽ�'] > 4 then 
				local mpwg = {}
				local wu = {}
				wu = wgmenu1
				for i = 1,#wu do 				
					if JY.Wugong[wu[i]]['����'] == JY.Person[pid]['����'] then 
						mpwg[#mpwg+1] =wu[i] 
					end
				end
				if mpwg[1] ~= nil then 
					JY.Person[pid]['����ʹ��'] = mpwg[math.random(#mpwg)]
				else
					JY.Person[pid]['����ʹ��'] = wu[math.random(#wu)]
				end
			elseif JY.Person[pid]['����ֽ�'] == 3 or JY.Person[pid]['����ֽ�'] == 4 then 
				local mpwg = {}
				local wu = {}
				wu = wgmenu2
				for i = 1,#wu do 				
					if JY.Wugong[wu[i]]['����'] == JY.Person[pid]['����'] then 
						mpwg[#mpwg+1] =wu[i] 
					end
				end
				if mpwg[1] ~= nil then 
					JY.Person[pid]['����ʹ��'] = mpwg[math.random(#mpwg)]
				else
					JY.Person[pid]['����ʹ��'] = wu[math.random(#wu)]
				end
			elseif JY.Person[pid]['����ֽ�'] == 2 then 
				local mpwg = {}
				local wu = {}
				wu = wgmenu3
				for i = 1,#wu do 				
					if JY.Wugong[wu[i]]['����'] == JY.Person[pid]['����'] then 
						mpwg[#mpwg+1] =wu[i] 
					end
				end
				if mpwg[1] ~= nil then 
					JY.Person[pid]['����ʹ��'] = mpwg[math.random(#mpwg)]
				else
					JY.Person[pid]['����ʹ��'] = wu[math.random(#wu)]
				end
			elseif JY.Person[pid]['����ֽ�'] == 1 then 
				local mpwg = {}
				local wu = {}
				wu = wgmenu4
				for i = 1,#wu do 				
					if JY.Wugong[wu[i]]['����'] == JY.Person[pid]['����'] then 
						mpwg[#mpwg+1] =wu[i] 
					end
				end
				if mpwg[1] ~= nil then 
					JY.Person[pid]['����ʹ��'] = mpwg[math.random(#mpwg)]
				else
					JY.Person[pid]['����ʹ��'] = wu[math.random(#wu)]
				end
			end

		end
		if JY.Person[pid]["�츳�⹦1"] > 0 then
			JY.Person[pid]["����ʹ��"] = JY.Person[pid]["�츳�⹦1"]
		end
		if PersonKF(pid,JY.Person[pid]["�츳�⹦1"]) == false then 
			for u = 1,JY.Base['�书����'] do 
				if JY.Person[pid]['�书'..15] > 0 then 
					JY.Person[pid]['�书'..1] = JY.Person[pid]["����ʹ��"]
					JY.Person[pid]['�书�ȼ�'..1] = 999
					break
				else	
					if JY.Person[pid]['�书'..u] == 0 then 
						JY.Person[pid]['�书'..u] = JY.Person[pid]["����ʹ��"]
						JY.Person[pid]['�书�ȼ�'..u] = 999
						break
					end
				end
			end
		end	
	end

	--�ڹ�
	--lib.Debug('�趨�ڹ�������pid=='..pid)
	if JY.Person[pid]["�����ڹ�"] == 0 then 		
		if num > 0 then
			--lib.Debug('�п��趨���书 �趨�ڹ�������pid=='..pid..'')
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
			JY.Person[pid]["�����ڹ�"] = ngmenu[key][1]			
		else
			--lib.Debug('û�п��趨���书 �趨�ڹ�������pid=='..pid..'')
			local ngmenu4 = {}
			local ngmenu3 = {}
			local ngmenu2 = {}
			local ngmenu1 = {}
			for i = 0,JY.WugongNum - 1 do 
				if JY.Wugong[i]['�书����'] == 6  then 
					if JY.Wugong[i]['�㼶'] <= 2 and i ~= 94 then 
						ngmenu2[#ngmenu2+1] = i  -- 
					end
					if JY.Wugong[i]['�㼶'] == 3  then 
						ngmenu3[#ngmenu3+1] = i 
					end
					if JY.Wugong[i]['�㼶'] == 4  then 
						ngmenu4[#ngmenu4+1] = i 
					end
				end
			end
			if (JY.Person[pid]["����ֽ�"] <= 3 or JY.Person['���ɹ���'] == 5 )  then
				local mpwg = {}
				local wu = {}
				wu = ngmenu4
				for i = 1,#wu do 							
					if JY.Wugong[wu[i]]['����'] == JY.Person[pid]['����'] then 
						mpwg[#mpwg+1] =wu[i] 
					end
				end
				if mpwg[1] ~= nil then 
					JY.Person[pid]['�����ڹ�'] = mpwg[math.random(#mpwg)]
				else
					if ngmenu3[1] ~= nil then 
						JY.Person[pid]['�����ڹ�'] = ngmenu3[math.random(#ngmenu3)]
					elseif ngmenu2[1] ~= nil then 
						JY.Person[pid]['�����ڹ�'] = ngmenu2[math.random(#ngmenu2)]					
					else
						JY.Person[pid]['�����ڹ�'] = wu[math.random(#wu)]
					end
				end        
			elseif JY.Person[pid]["�����ڹ�"] == 0 and JY.Person[pid]["����ֽ�"] == 4 then
				local mpwg = {}
				local wu = {}
				wu = ngmenu3
				for i = 1,#wu do 							
					if JY.Wugong[wu[i]]['����'] == JY.Person[pid]['����'] then 
						mpwg[#mpwg+1] =wu[i] 
					end
				end
				if mpwg[1] ~= nil then 
					JY.Person[pid]['�����ڹ�'] = mpwg[math.random(#mpwg)]
				else
					local mpwg1 = {}
					for i = 1,#ngmenu2 do 							
						if JY.Wugong[ngmenu2[i]]['����'] == JY.Person[pid]['����'] then 
							mpwg1[#mpwg+1] =ngmenu2[i] 
						end
					end
					if mpwg1[1] ~= nil then 
						JY.Person[pid]['�����ڹ�'] = mpwg1[math.random(#mpwg1)]
					else
						JY.Person[pid]['�����ڹ�'] = wu[math.random(#wu)]
					end
				end	        
			elseif JY.Person[pid]["�����ڹ�"] == 0 and JY.Person[pid]["����ֽ�"]  >= 5  then
				local mpwg = {}
				local wu = {}
				wu = ngmenu2
				for i = 1,#wu do 							
					if JY.Wugong[wu[i]]['����'] == JY.Person[pid]['����'] then 
						mpwg[#mpwg+1] =wu[i] 
					end
				end
				if mpwg[1] ~= nil then 
					JY.Person[pid]['�����ڹ�'] = mpwg[math.random(#mpwg)]
				else
					JY.Person[pid]['�����ڹ�'] = wu[math.random(#wu)]
				end
			end				
			if JY.Person[pid]["�츳�ڹ�"] > 0 then
				JY.Person[pid]["�����ڹ�"] = JY.Person[pid]["�츳�ڹ�"]
			end
			for u = 1,JY.Base['�书����'] do 
				if JY.Person[pid]['�书'..u] == 0 then 
					JY.Person[pid]['�书'..u] = JY.Person[pid]["�����ڹ�"] 
					JY.Person[pid]['�书�ȼ�'..u] = 999
					break
				end
			end
		end
	end
	--�Ṧ
	if JY.Person[pid]["�����Ṧ"] == 0 then 
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
			JY.Person[pid]["�����Ṧ"] = qgmenu[key][1]
		else
			local ngmenu4 = {}
			local ngmenu3 = {}
			for i = 0,JY.WugongNum - 1 do 
				if JY.Wugong[i]['�书����'] == 7  then 
					if JY.Wugong[i]['�㼶'] < 4  then 
						ngmenu3[#ngmenu3+1] = i 
					end
					if JY.Wugong[i]['�㼶'] == 4  then 
						ngmenu4[#ngmenu4+1] = i 
					end
				end
			end
			if JY.Person[pid]["�����Ṧ"] == 0 and ( JY.Person[pid]["����ֽ�"] <= 3 or JY.Person[pid]['���ɹ���'] == 5)  then
				local mpwg = {}
				local wu = {}
				wu = ngmenu4
				for i = 1,#wu do 							
					if JY.Wugong[wu[i]]['����'] == JY.Person[pid]['����'] then 
						mpwg[#mpwg+1] =wu[i] 
					end
				end
				if mpwg[1] ~= nil then 
					JY.Person[pid]['�����Ṧ'] = mpwg[math.random(#mpwg)]
				else
					JY.Person[pid]['�����Ṧ'] = wu[math.random(#wu)]
				end
			elseif JY.Person[pid]["�����Ṧ"] == 0 and JY.Person[pid]["����ֽ�"] > 3  then
				local mpwg = {}
				local wu = {}
				wu = ngmenu3
				for i = 1,#wu do 							
					if JY.Wugong[wu[i]]['����'] == JY.Person[pid]['����'] then 
						mpwg[#mpwg+1] =wu[i] 
					end
				end
				if mpwg[1] ~= nil then 
					JY.Person[pid]['�����Ṧ'] = mpwg[math.random(#mpwg)]
				else
					JY.Person[pid]['�����Ṧ'] = wu[math.random(#wu)]
				end
			end
			if JY.Person[pid]["�츳�Ṧ"] > 0 then
				JY.Person[pid]["�����Ṧ"] = JY.Person[pid]["�츳�Ṧ"]
			end

			for s = 1,JY.Base['�书����'] do 
				if JY.Person[pid]['�书'..s] == 0 then 
					JY.Person[pid]['�书'..s] = JY.Person[pid]["�����Ṧ"] 
					JY.Person[pid]['�书�ȼ�'..s] = 999
					break
				end
			end
		end
	end
end

--��ʼ��ʽ�趨
function KF_zsset(personid,wugong)
    local fj = JY.Person[personid]["����ֽ�"]
    local bh = personid 
	if JY.Wugong[wugong]['�书����'] < 7 then 
		for i = 1, JY.Base["�书����"] do
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
				if wugong == JY.Person[personid]['�츳�⹦1']  or wugong == JY.Person[personid]['�츳�⹦2'] or wugong == JY.Person[personid]['�츳�ڹ�'] then 
					n = #CC.KFMove[wugong]
				end
				zsn = zsn + n
				if zsn > #CC.KFMove[wugong] then 
					zsn = #CC.KFMove[wugong]
				end
				if p <= zsn then 
					if JY.Person[personid]["�书��ʽ"..zs] < 1 then
						JY.Person[personid]["�书��ʽ"..zs] = 1
					end	
				end 
			end
		end
	end
end

--��ʽ˵������
function KF_zswz(kf,zs)
	local zswz1 = ""
	if JY.Wugong[kf]["�书����"] == 1 then
		zswz1 = "���Ŀ�����ˣ�"..(JY.Wugong[kf]["�㼶"]*5).."�׵㡣"
	elseif JY.Wugong[kf]["�书����"] == 2 then
		zswz1 = "��Ŀ���Ѩ��"..JY.Wugong[kf]["�㼶"].."~"..(JY.Wugong[kf]["�㼶"]*2+2).."�׵㡣"
	elseif JY.Wugong[kf]["�书����"] == 3 then
		zswz1 = "���Ŀ����Ѫ��"..(JY.Wugong[kf]["�㼶"]*10).."�׵㡣"
	elseif JY.Wugong[kf]["�书����"] == 4 then
		zswz1 = "���Ŀ�����ˣ�"..(JY.Wugong[kf]["�㼶"]*10).."�׵㡣"
	elseif JY.Wugong[kf]["�书����"] == 5 then
		zswz1 = "���Ŀ�����ˣ�"..(JY.Wugong[kf]["�㼶"]*5).."�׵�/��Ŀ���Ѩ��"..JY.Wugong[kf]["�㼶"].."~"..(JY.Wugong[kf]["�㼶"]*2+2).."�׵�/���Ŀ����Ѫ��"..(JY.Wugong[kf]["�㼶"]*10).."�׵�/���Ŀ�����գ�"..(JY.Wugong[kf]["�㼶"]*10).."�׵㡣"	
	end
	if JY.Wugong[kf]["����ϵ��"] == 1 then
		zswz1 = zswz1.."���ʱ��⡣"
	end
	if JY.Wugong[kf]["����ϵ��"] == 1 then
		zswz1 = zswz1.."�������ա�"
	end
	if JY.Wugong[kf]["�����ж�����"] > 0 then
		zswz1 = zswz1.."��Ŀ������ж���"..JY.Wugong[kf]["�����ж�����"].."�ס�"	
	end													
	if JY.Wugong[kf]["��ʽ"..zs] > 0 then
		--1��Ѫ
		if JY.Wugong[kf]["��ʽ"..zs] > 10 and JY.Wugong[kf]["��ʽ"..zs] < 15 then
			zswz1 = zswz1.."�������Ŀ����Ѫ��"..(JY.Wugong[kf]["�㼶"]*10).."�׵㡣"
		--2��Ѩ
		elseif JY.Wugong[kf]["��ʽ"..zs] > 20 and JY.Wugong[kf]["��ʽ"..zs] < 25 then
			zswz1 = zswz1.."�������Ŀ���Ѩ��"..JY.Wugong[kf]["�㼶"].."~"..(JY.Wugong[kf]["�㼶"]*2+1).."�׵㡣"
		--3����	
		elseif JY.Wugong[kf]["��ʽ"..zs] > 30 and JY.Wugong[kf]["��ʽ"..zs] < 35 then
			zswz1 = zswz1.."���Ŀ�����գ�"..(JY.Wugong[kf]["�㼶"]*5).."�׵㡣"
		--4����		
		elseif JY.Wugong[kf]["��ʽ"..zs] > 40 and JY.Wugong[kf]["��ʽ"..zs] < 45 then
			zswz1 = zswz1.."���Ŀ������"..(JY.Wugong[kf]["�㼶"]*10).."�׵㡣"								
		--5����		
		elseif JY.Wugong[kf]["��ʽ"..zs] > 50 and  JY.Wugong[kf]["��ʽ"..zs] < 55 then
			zswz1 = zswz1.."���Ŀ�����ˣ�"..(JY.Wugong[kf]["�㼶"]*10).."�׵㡣"	
		--6�ж�	
		elseif JY.Wugong[kf]["��ʽ"..zs] > 60 and JY.Wugong[kf]["��ʽ"..zs] < 65 then
			zswz1 = zswz1.."���Ŀ���ж���"..(JY.Wugong[kf]["�㼶"]*10).."�׵㡣"	
		--7����
		elseif JY.Wugong[kf]["��ʽ"..zs] > 70 and JY.Wugong[kf]["��ʽ"..zs] < 75 then
			zswz1 = zswz1.."���Ŀ�궳���"..(JY.Wugong[kf]["�㼶"]*5).."��ʱ��"	
		--8��ȼ
		elseif JY.Wugong[kf]["��ʽ"..zs] > 80 and JY.Wugong[kf]["��ʽ"..zs] < 85 then
			zswz1 = zswz1.."���Ŀ���ȼ��"..(JY.Wugong[kf]["�㼶"]*2+3).."��ʱ��"
		--9�޶�
		elseif JY.Wugong[kf]["��ʽ"..zs] > 90 and JY.Wugong[kf]["��ʽ"..zs] < 95 then
			zswz1 = zswz1.."���Ŀ��޶���"..JY.Wugong[kf]["�㼶"].."�׻غ�,���Է���Ч��˫����"	
		--10ѣ��
		elseif JY.Wugong[kf]["��ʽ"..zs] > 100 and JY.Wugong[kf]["��ʽ"..zs] < 105 then
			local jl = JY.Wugong[kf]["�㼶"]*20
			zswz1 = zswz1.."��"..jl.."%�����Ŀ��ѣ��1�غϡ�"	
		--11˺��		
		elseif JY.Wugong[kf]["��ʽ"..zs] > 110 and JY.Wugong[kf]["��ʽ"..zs] < 115 then
			local jl = JY.Wugong[kf]["��ʽ"..zs]*20
			zswz1 = zswz1.."��"..jl.."%�����Ŀ��˺��10ʱ��"																						
		--12����									
		elseif JY.Wugong[kf]["��ʽ"..zs] > 120 and JY.Wugong[kf]["��ʽ"..zs] < 125 then
			zswz1 = zswz1.."���Ŀ������1�غϣ������˺���������"..(JY.Wugong[kf]["�㼶"]*10+10).."%�ס�"
		--13�Ʒ�								
		elseif JY.Wugong[kf]["��ʽ"..zs] > 130 and JY.Wugong[kf]["��ʽ"..zs] < 135 then
			zswz1 = zswz1.."����Ŀ�������"..(JY.Wugong[kf]["�㼶"]*10).."%�ס�"	
		--14����ϵ��								
		elseif JY.Wugong[kf]["��ʽ"..zs] > 140 and JY.Wugong[kf]["��ʽ"..zs] < 145 then
			local xswz = {"ȭ��ϵ��","ָ��ϵ��","����ϵ��","ˣ��ϵ��","����ϵ��"}
			zswz1 = zswz1.."����Ŀ���"..xswz[JY.Wugong[kf]["�书����"]]..(JY.Wugong[kf]["�㼶"]*10).."%�ס�"	
		--15�̶��˺�								
		elseif JY.Wugong[kf]["��ʽ"..zs] > 150 and JY.Wugong[kf]["��ʽ"..zs] < 155 then									
			zswz1 = zswz1.."���Ӷ����˺���"..(JY.Wugong[kf]["�㼶"]*50).."�׵㡣"			
		--16��Ѫ
		elseif JY.Wugong[kf]["��ʽ"..zs] > 160 and JY.Wugong[kf]["��ʽ"..zs] < 165 then	
			zswz1 = zswz1.."�����˺�20%��Ѫ���ޣ�"..(JY.Wugong[kf]["�㼶"]*50).."�׵㡣"
		--17����
		elseif JY.Wugong[kf]["��ʽ"..zs] > 170 and JY.Wugong[kf]["��ʽ"..zs] < 175 then	
			zswz1 = zswz1.."���غ��ڼ���Ŀ�������"..(JY.Wugong[kf]["�㼶"]*5).."%�ס�"
		--18����
		elseif JY.Wugong[kf]["��ʽ"..zs] > 180 and JY.Wugong[kf]["��ʽ"..zs] < 185 then	
			zswz1 = zswz1.."���غ��ڼ���Ŀ�깥����"..(JY.Wugong[kf]["�㼶"]*5).."%�ס�"
		--19������
		elseif JY.Wugong[kf]["��ʽ"..zs] > 190 and JY.Wugong[kf]["��ʽ"..zs] < 195 then	
			zswz1 = zswz1.."��"..(JY.Wugong[kf]["�㼶"]*10).."%�׸�������������"
		--20���ӷ�Χ
		elseif JY.Wugong[kf]["��ʽ"..zs] > 200 and JY.Wugong[kf]["��ʽ"..zs] < 205 then	
			zswz1 = zswz1.."��"..(JY.Wugong[kf]["�㼶"]*10).."%����ɴ�Χ�˺���"
		--21�ٴ��ж�
		elseif JY.Wugong[kf]["��ʽ"..zs] > 210 and JY.Wugong[kf]["��ʽ"..zs] < 215 then	
			zswz1 = zswz1.."��"..(JY.Wugong[kf]["�㼶"]*4).."%�׸����ٴ��ж���"
		--22����
		elseif JY.Wugong[kf]["��ʽ"..zs] > 220 and JY.Wugong[kf]["��ʽ"..zs] < 225 then	
			zswz1 = zswz1.."�»غϼ������٣�"..(JY.Wugong[kf]["�㼶"]*10).."%�ס�"
		--23������
		elseif JY.Wugong[kf]["��ʽ"..zs] > 230 and JY.Wugong[kf]["��ʽ"..zs] < 235 then	
			zswz1 = zswz1.."��"..(JY.Wugong[kf]["�㼶"]*10).."%�׸�����������1�Ρ�"
		--24�ӱ���
		elseif JY.Wugong[kf]["��ʽ"..zs] > 240 and JY.Wugong[kf]["��ʽ"..zs] < 245 then	
			zswz1 = zswz1.."��"..(JY.Wugong[kf]["�㼶"]*20+20).."%�ױ�����"
		--25�ӱ���
		elseif JY.Wugong[kf]["��ʽ"..zs] > 250 and JY.Wugong[kf]["��ʽ"..zs] < 255 then	
			zswz1 = zswz1.."���ӱ����˺���"..(JY.Wugong[kf]["�㼶"]*10).."%�ס�"
		--26����
		elseif JY.Wugong[kf]["��ʽ"..zs] > 260 and JY.Wugong[kf]["��ʽ"..zs] < 265 then	
			zswz1 = zswz1.."��"..(JY.Wugong[kf]["�㼶"]*20+20).."%�׸��ʱ��С�"
		--27����
		elseif JY.Wugong[kf]["��ʽ"..zs] > 270 and JY.Wugong[kf]["��ʽ"..zs] < 275 then	
			zswz1 = zswz1.."��"..(JY.Wugong[kf]["�㼶"]*20+20).."%���»غϷ�����"
		--28����
		elseif JY.Wugong[kf]["��ʽ"..zs] > 280 and JY.Wugong[kf]["��ʽ"..zs] < 285 then	
			if JY.Wugong[kf]["�㼶"] == 1 then											
				zswz1 = zswz1.."������"..(JY.Wugong[kf]["�㼶"]*1).."�׵㡣"
			else
				local hq = JY.Wugong[kf]["�㼶"]-1
				local hq1= JY.Wugong[kf]["�㼶"]
				zswz1 = zswz1.."������"..hq.."~"..hq1.."�׵㡣"
			end
		--29����
		elseif JY.Wugong[kf]["��ʽ"..zs] > 290 and JY.Wugong[kf]["��ʽ"..zs] < 295 then	
			zswz1 = zswz1.."��"..(JY.Wugong[kf]["�㼶"]*15).."%������1�غϡ�"
		--30����
		elseif JY.Wugong[kf]["��ʽ"..zs] > 300 and JY.Wugong[kf]["��ʽ"..zs] < 305 then	
			zswz1 = zswz1.."��"..(JY.Wugong[kf]["�㼶"]*10).."%�׷�����"
		--31�Ӹ�
		elseif JY.Wugong[kf]["��ʽ"..zs] > 310 and JY.Wugong[kf]["��ʽ"..zs] < 315 then	
			zswz1 = zswz1.."���Ӹ񵵣�"..(JY.Wugong[kf]["�㼶"]*100).."�׵㡣"
		--32������
		elseif JY.Wugong[kf]["��ʽ"..zs] > 320 and JY.Wugong[kf]["��ʽ"..zs] < 325 then	
			zswz1 = zswz1.."�������ӣ�"..(JY.Wugong[kf]["�㼶"]*100).."�׵㡣"
		--33ɢ��
		elseif JY.Wugong[kf]["��ʽ"..zs] > 330 and JY.Wugong[kf]["��ʽ"..zs] < 335 then	
			zswz1 = zswz1.."ɢ����"..(JY.Wugong[kf]["�㼶"]*5).."��ʱ��"	
		--34����
		elseif JY.Wugong[kf]["��ʽ"..zs] > 340 and JY.Wugong[kf]["��ʽ"..zs] < 345 then	
			zswz1 = zswz1.."�������غϣ�Ŀ����Χ���ͣ�"..	(5+JY.Wugong[kf]["�㼶"]*5).."%�ס�"	
		--35��������
		elseif JY.Wugong[kf]["��ʽ"..zs] > 350 and JY.Wugong[kf]["��ʽ"..zs] < 355 then	
			zswz1 = zswz1.."�������ң�"..(JY.Wugong[kf]["�㼶"]*5).."��ʱ��"	
		--36�־�
		elseif JY.Wugong[kf]["��ʽ"..zs] > 360 and JY.Wugong[kf]["��ʽ"..zs] < 365 then	
			zswz1 = zswz1.."��"..(30+JY.Wugong[kf]["�㼶"]*10).."%�׸��ʿ־�1�غϡ�"	
		--37�������ֵ�˺�
		elseif JY.Wugong[kf]["��ʽ"..zs] > 370 and JY.Wugong[kf]["��ʽ"..zs] < 375 then	
			zswz1 = zswz1.."���Ŀ���������ֵ��"..(1+JY.Wugong[kf]["�㼶"]).."%���˺���"
		--38äĿ
		elseif JY.Wugong[kf]["��ʽ"..zs] > 380 and JY.Wugong[kf]["��ʽ"..zs] < 385 then	
			zswz1 = zswz1.."��"..(JY.Wugong[kf]["�㼶"]*10).."%�׸�����ä��"																												
		--39�ٻ�
		elseif JY.Wugong[kf]["��ʽ"..zs] > 390 and JY.Wugong[kf]["��ʽ"..zs] < 395 then	
			zswz1 = zswz1.."Ŀ�꼯�����٣�"..(JY.Wugong[kf]["�㼶"]*3).."�׵㡣"																												
		end
	end
	return zswz1
end

--�ڹ�˵������
function KF_ngwz(kf,tx)
	local txwz = ""	
	local ngtx = JY.Wugong[kf]['��Ч'..tx]	
	local kflv = JY.Wugong[kf]["�㼶"]		
	local lv1 = {'Ҽ��','�@��','����','����',}	
	local lv = lv1[kflv]	
	--local cl = RGB(188,189,171) 
	local function strcolor_switch(s)
		local Color_Switch={{"��",PinkRed},{"��",M_Wheat},{"��",C_BLACK},{"��",RGB(178,158,124)},{"��",C_ORANGE},{"��",LimeGreen},{"��",M_DeepSkyBlue},{"��",Violet}}
		for i = 1, 8 do
			if Color_Switch[i][1] == s then
				return Color_Switch[i][2]
			end
		end
	end			
			
	if ngtx > 0 then 
		------------------------------------
		------------------�ظ���------------------
		------------------------------------
		if ngtx >= 11 and ngtx <= 14 then 
			txwz = '���ڡ�ʱ���Ѫ��'..lv..'������ÿ3ʱ��ظ���'..kflv..'�׵�������'
		end
		if ngtx >= 15 and ngtx <= 19 then 
			local hx = kflv*100
			txwz = '���ڡ��غϻ�Ѫ��'..lv..'������ÿ�غϻظ���'..hx..'�׵�������'
		end
		if ngtx >= 21 and ngtx <= 24 then 
			local hn = kflv*2
			txwz = '���ڡ�ʱ����ڡ�'..lv..'������ÿ3ʱ��ظ���'..hn..'�׵�������'
		end
		if ngtx >= 25 and ngtx <= 29 then 
			local hn = kflv*200
			txwz = '���ڡ��غϻ��ڡ�'..lv..'������ÿ�غϻظ���'..hn..'�׵�������'
		end
		if ngtx >= 31 and ngtx <= 34 then 
			local hn = kflv
			txwz = '���ڡ�ʱ������'..lv..'������ÿ9ʱ��ظ���'..hn..'�׵�������'
		end	
		if ngtx >= 35 and ngtx <= 39 then 
			local hn = kflv
			txwz = '���ڡ��غϻ����'..lv..'������ÿ�غϻظ���'..hn..'�׵�������'
		end	
		if ngtx >= 41 and ngtx <= 44 then 
			local hn = kflv
			txwz = '���ڡ�ʱ�������'..lv..'������ÿ50ʱ��ظ���'..hn..'�׵�����'
		end	
		if ngtx >= 45 and ngtx <= 49 then 
			local hn = kflv
			txwz = '���ڡ��غϻ�����'..lv..'������ÿ�غϻظ���'..hn..'�׵�����'
		end	
		if ngtx >= 51 and ngtx <= 54 then 
			local hn = kflv*3
			txwz = '���ڡ��ش���'..lv..'������ÿ�غϻظ���'..hn..'%��������'
		end
		--�غϻظ��ٷֱ�����
		if ngtx >= 55 and ngtx <= 59 then 
			local hx = kflv
			txwz = '���ڡ���Ϣ��'..lv..'������ÿ�غϻظ���'..hx..'%������'
		end	
		--�غϻظ��ٷֱ�����
		if ngtx >= 61 and ngtx <= 64 then 
			local hx = kflv
			txwz = '���ڡ������'..lv..'������ÿ�غϻظ���'..hx..'%��������'
		end	
		--�غϻظ��ٷֱ���
		if ngtx >= 65 and ngtx <= 69 then 
			local hx = kflv
			txwz = '���ڡ������'..lv..'������ÿ�غϻظ���'..hx..'%������'
		end	
		--Ѫ������ȫ�ظ�
		if ngtx >= 71 and ngtx <= 74 then 
			local hx = kflv
			txwz = '���ǡ���ŭ��'..lv..'������ÿ�غϻظ���'..hx..'%��ŭ����'
		end	
		--��Ѫ�ظ�
		if ngtx >= 75 and ngtx <= 79 then 
			local hn = kflv
			txwz = '���ڡ���Ѫ��'..lv..'������ÿ6ʱ��ظ���'..hn..'�׵���Ѫ��'
		end			
		--��Ѫ�ظ�
		if ngtx >= 81 and ngtx <= 84 then 
			local hn = kflv*5
			txwz = '���ڡ�������'..lv..'������ÿ�غϻظ���'..hn..'�׵���Ѫ��'
		end	
		--����ظ�
		if ngtx >= 85 and ngtx <= 89 then 
			local hn = kflv
			txwz = '���ڡ����ա�'..lv..'������ÿ6ʱ��ظ���'..hn..'�׵���⡣'
		end			
		--����ظ�
		if ngtx >= 91 and ngtx <= 94 then 
			local hn = kflv*5
			txwz = '���ڡ�������'..lv..'������ÿ�غϻظ���'..hn..'�׵���⡣'
		end			
		--��Ѩ�ظ�
		if ngtx >= 95 and ngtx <= 99 then 
			local hn = kflv
			txwz = '���ڡ���Ѩ��'..lv..'������ÿ6ʱ��ظ���'..hn..'�׵��Ѩ��'
		end			
		--���ջظ�
		if ngtx >= 101 and ngtx <= 104 then 
			local hn = kflv
			txwz = '���ڡ����ġ�'..lv..'������ÿ6ʱ��ظ���'..hn..'�׵����ա�'
		end
		--���ջظ�
		if ngtx >= 105 and ngtx <= 109 then 
			local hn = kflv*5
			txwz = '���ڡ������'..lv..'������ÿ�غϻظ���'..hn..'�׵����ա�'
		end	
		--�ж��ظ�
		if ngtx >= 111 and ngtx <= 114 then 
			local hn = kflv
			txwz = '���ڡ�Р����'..lv..'������ÿ6ʱ��ظ���'..hn..'�׵��ж���'
		end
		--�ж��ظ�
		if ngtx >= 115 and ngtx <= 119 then 
			local hn = kflv*5
			txwz = '���ڡ�������'..lv..'������ÿ�غϻظ���'..hn..'�׵��ж���'
		end				
		--���˻ظ�
		if ngtx >= 121 and ngtx <= 124 then 
			local hn = kflv
			txwz = '���ڡ����ˡ�'..lv..'������ÿ6ʱ��ظ���'..hn..'�׵����ˡ�'
		end	
		--���˻ظ�
		if ngtx >= 125 and ngtx <= 129 then 
			local hn = kflv*5
			txwz = '���ڡ�ͨ����'..lv..'������ÿ�غϻظ���'..hn..'�׵����ˡ�'
		end		
		------------------------------------
		------------------�ָ���------------------	
		------------------------------------		
		--���˻ָ�
		if ngtx >= 131 and ngtx <= 134 then 
			local hn = kflv*5
			txwz = '���ڡ�Ȭ����'..lv..'������ÿ6ʱ���'..hn..'%�׸���������ˣ����������ˣ�'..hn..'��ʱ��'
		end	
		--����ָ�
		if ngtx >= 135 and ngtx <= 139 then 
			local hn = kflv*5
			txwz = '���ڡ�������'..lv..'������ÿ6ʱ���'..hn..'%�׸���������ᡣ�����߶����'..hn..'��ʱ��'
		end	
		--�����ָ�
		if ngtx >= 141 and ngtx <= 144 then 
			local hn = kflv*5
			txwz = '���ڡ������'..lv..'������ÿ6ʱ���'..hn..'%�׸������������������������'..hn..'��ʱ��'
		end		
		--��Ѩ�ָ�
		if ngtx >= 145 and ngtx <= 149 then 
			local hn = kflv*5
			txwz = '���ڡ���Ѩ��'..lv..'������ÿ6ʱ���'..hn..'%�׸��������Ѩ�������߷�Ѩ��'..hn..'��ʱ��'
		end	
		--�ж��ָ�
		if ngtx >= 151 and ngtx <= 154 then 
			local hn = kflv*5
			txwz = '���ڡ����֡�'..lv..'������ÿ6ʱ���'..hn..'%�׸�������ж����������ж���'..hn..'��ʱ��'
		end		
		--�ָ�״̬
		if ngtx >= 155 and ngtx <= 159 then 
			local hn = kflv*5
			txwz = '���ڡ�������'..lv..'������ÿ6ʱ���'..hn..'%�׸���������ˡ���Ѫ�����⡢���ա���Ѩ��'
		end
		--�ָ�״̬
		if ngtx >= 161 and ngtx <= 164 then 
			local hn = kflv*25
			txwz = '���ڡ�������'..lv..'������ÿ�غϣ�'..hn..'%�׸���������ˡ���Ѫ�����⡢���ա���Ѩ��'
		end	
		------------------------------------
		------------------��פ������------------------	
		------------------------------------
		--�����˺�
		if ngtx >= 165 and ngtx <= 169 then 
			local hn = kflv*5
			txwz = '���ڡ����͡�'..lv..'�����������˺���'..hn..'%�ס�'
		end	
		--����������
		if ngtx >= 171 and ngtx <= 174 then 
			local hn = kflv*10
			txwz = '���ڡ�������'..lv..'���������������ʣ�'..hn..'%�ס�'
		end	
		--���������˺�
		if ngtx >= 175 and ngtx <= 179 then 
			local hn = kflv*5
			txwz = '���ڡ����ˡ�'..lv..'���������������˺���'..hn..'%�ס�'
		end	
		--���ӱ�����
		if ngtx >= 181 and ngtx <= 184 then 
			local hn = kflv*10
			txwz = '���ڡ�������'..lv..'���������ӱ����ʣ�'..hn..'%�ס�'
		end	
		--���ӱ����˺�
		if ngtx >= 185 and ngtx <= 189 then 
			local hn = kflv*5
			txwz = '���ڡ����ˡ�'..lv..'���������ӱ����˺���'..hn..'%�ס�'
		end	
		--���ӹ�����
		if ngtx >= 191 and ngtx <= 194 then 
			local hn = kflv*50
			txwz = '���ڡ�������'..lv..'���������ӹ�������'..hn..'�׵㡣'
		end	
		--���ӷ�����
		if ngtx >= 195 and ngtx <= 199 then 
			local hn = kflv*50
			txwz = '���ڡ������'..lv..'���������ӷ�������'..hn..'�׵㡣'
		end	
		--�����Ṧ
		if ngtx >= 201 and ngtx <= 204 then 
			local hn = kflv*50
			txwz = '���ڡ������'..lv..'�����������Ṧ��'..hn..'�׵㡣'
		end	
		--��������
		if ngtx >= 205 and ngtx <= 209 then 
			local hn = kflv*100
			txwz = '���ڡ�������'..lv..'����������������'..hn..'�׵㡣'
		end
		--��������
		if ngtx >= 211 and ngtx <= 214 then 
			local hn = kflv*100
			txwz = '���ڡ�������'..lv..'����������������'..hn..'�׵㡣'
		end		
		--����ŭ��
		if ngtx >= 215 and ngtx <= 219 then 
			local hn = kflv
			txwz = '���ڡ���ŭ��'..lv..'������ÿ9ʱ��ظ���'..hn..'�׵�ŭ����'
		end
		--������
		if ngtx >= 221 and ngtx <= 224 then 
			local hn = kflv
			txwz = '���ڡ�������'..lv..'�������ж�ǰ�ظ���'..hn..'�׵�����'
		end
		--�����ƶ�����
		if ngtx >= 225 and ngtx <= 229 then 
			local hn = kflv
			txwz = '���ڡ����С�'..lv..'�����������ƶ�������'..hn..'�ס�'
		end		
		--���Ӽ���λ��
		if ngtx >= 231 and ngtx <= 234 then 
			local hn = kflv*100
			txwz = '���ڡ��ȷ���'..lv..'������ս����ʼ���Ӽ���λ�ã�'..hn..'�ס�'
		end	
		--���Ӽ����ٶ�
		if ngtx >= 235 and ngtx <= 239 then 
			local hn = kflv*2
			txwz = '���ڡ�Ѹ�ݡ�'..lv..'����������ս�������ٶȣ�'..hn..'�׵㡣'
		end
		--����ȭϵ�书����
		if ngtx >= 241 and ngtx <= 244 then 
			local hn = kflv*100
			txwz = '���ڡ�ȭ�'..lv..'����������ȭϵ�书������'..hn..'�׵㡣'
		end
		--����ָϵ�书����
		if ngtx >= 245 and ngtx <= 249 then 
			local hn = kflv*100
			txwz = '���ڡ�ָ����'..lv..'����������ָϵ�书������'..hn..'�׵㡣'
		end		
		--���ӽ�ϵ�书����
		if ngtx >= 251 and ngtx <= 254 then 
			local hn = kflv*100
			txwz = '���ڡ�������'..lv..'���������ӽ�ϵ�书������'..hn..'�׵㡣'
		end
		--���ӵ�ϵ�书����
		if ngtx >= 255 and ngtx <= 259 then 
			local hn = kflv*100
			txwz = '���ڡ������'..lv..'���������ӵ�ϵ�书������'..hn..'�׵㡣'
		end
		--���������书����
		if ngtx >= 261 and ngtx <= 264 then 
			local hn = kflv*100
			txwz = '���ڡ���е��'..lv..'���������������书������'..hn..'�׵㡣'
		end
		--����ȭϵ�书�����ٷֱ�
		if ngtx >= 265 and ngtx <= 269 then 
			local hn = kflv*100
			txwz = '���ڡ�ȭ�ƾ�ͨ��'..lv..'����������ȭϵ�书������'..hn..'%�ס�'
		end
		--����ָϵ�书�����ٷֱ�
		if ngtx >= 271 and ngtx <= 274 then 
			local hn = kflv*100
			txwz = '���ڡ�ָ�Ⱦ�ͨ��'..lv..'����������ָϵ�书������'..hn..'%�ס�'
		end		
		--���ӽ�ϵ�书�����ٷֱ�
		if ngtx >= 275 and ngtx <= 279 then 
			local hn = kflv*100
			txwz = '���ڡ�������ͨ��'..lv..'���������ӽ�ϵ�书������'..hn..'%�ס�'
		end
		--���ӵ�ϵ�书�����ٷֱ�
		if ngtx >= 281 and ngtx <= 284 then 
			local hn = kflv*100
			txwz = '���ڡ�������ͨ��'..lv..'���������ӵ�ϵ�书������'..hn..'%�ס���'
		end
		--���������书�����ٷֱ�
		if ngtx >= 285 and ngtx <= 289 then 
			local hn = kflv*100
			txwz = '���ڡ����ž�ͨ��'..lv..'���������������书������'..hn..'%�ס�'
		end
		--�����Ʒ�����
		if ngtx >= 291 and ngtx <= 294 then 
			local hn = kflv*100
			txwz = '���ڡ������'..lv..'�����׹���ʱ����Ŀ�������'..hn..'�׵㡣'
		end
		--�����Ʒ��ٷֱ�
		if ngtx >= 295 and ngtx <= 299 then 
			local hn = kflv*10
			txwz = '���ڡ��Ƽס�'..lv..'�����׹���ʱ����Ŀ�������'..hn..'%�ס�'
		end		
		--���ӹ������ٷֱ�
		if ngtx >= 301 and ngtx <= 304 then 
			local hn = kflv*10
			txwz = '���ڡ�������'..lv..'���������ӹ�������'..hn..'%�ס�'
		end	
		--���ӷ������ٷֱ�
		if ngtx >= 305 and ngtx <= 309 then 
			local hn = kflv*10
			txwz = '���ڡ�������'..lv..'���������ӷ�������'..hn..'%�ס�'
		end	
		--�����Ṧ�ٷֱ�
		if ngtx >= 311 and ngtx <= 314 then 
			local hn = kflv*10
			txwz = '���ڡ��ý���'..lv..'�����������Ṧ��'..hn..'%�ס�'
		end
		--������Χ����
		if ngtx >= 315 and ngtx <= 319 then 
			local hn = kflv*50
			txwz = '���ǡ������'..lv..'������������Χ��'..hn..'��ס�'
		end
		--������Χ�ٷֱ�
		if ngtx >= 321 and ngtx <= 324 then 
			local hn = kflv*10
			txwz = '���ǡ�������'..lv..'������������Χ��'..hn..'%�ס�'
		end
		--������Ч����
		if ngtx >= 325 and ngtx <= 329 then 
			local hn = kflv*6
			txwz = '���ǡ������'..lv..'������������Ч�������ʣ�'..hn..'%�ס�'
		end
		--���ӱ�������
		if ngtx >= 331 and ngtx <= 334 then 
			local hn = kflv*100
			txwz = '���ڡ�������'..lv..'���������ӿ���������'..hn..'�׵㡣'
		end		
		--���ӱ��⿹��
		if ngtx >= 335 and ngtx <= 339 then 
			local hn = kflv*100
			txwz = '���ڡ��𿹡�'..lv..'���������ӱ��⿹�ԣ�'..hn..'�׵㡣'
		end	
		--�������տ���
		if ngtx >= 341 and ngtx <= 344 then 
			local hn = kflv*100
			txwz = '���ڡ�������'..lv..'�������������տ��ԣ�'..hn..'�׵㡣'
		end	
		--���ӵ�Ѩ����
		if ngtx >= 345 and ngtx <= 349 then 
			local hn = kflv*100
			txwz = '���ڡ���Ѩ��'..lv..'���������ӷ�Ѩ���ԣ�'..hn..'�׵㡣'
		end	
		--������Ѫ����
		if ngtx >= 351 and ngtx <= 354 then 
			local hn = kflv*100
			txwz = '���ڡ�Ѫ����'..lv..'������������Ѫ���ԣ�'..hn..'�׵㡣'
		end			
		--�����ж�����
		if ngtx >= 355 and ngtx <= 359 then 
			local hn = kflv*100
			txwz = '���ڡ�������'..lv..'�����������ж����ԣ�'..hn..'�׵㡣'
		end		
		
		
		-------------����״̬---------------
		--���߷���
		if ngtx >= 401 and ngtx <=404 then 
			local hn = kflv*25
			txwz = '���ڡ����߷��ˡ�'..lv..'���������߷����ͷ������ʣ�'..hn..'%�ס�'
		end
		--������Ѫ
		if ngtx >= 405 and ngtx <=409 then 
			local hn = kflv*25
			txwz = '���ڡ�������Ѫ��'..lv..'������������Ѫ���ʣ�'..hn..'%�ס�'
		end
		--�����ж�
		if ngtx >= 411 and ngtx <=414 then 
			local hn = kflv*25
			txwz = '���ڡ������ж���'..lv..'�����������ж����ʣ�'..hn..'%�ס�'
		end
		--��������
		if ngtx >= 415 and ngtx <=419 then 
			local hn = kflv*25
			txwz = '���ڡ��������ˡ�'..lv..'�������������˸��ʣ�'..hn..'%�ס�'
		end	
		--���߱���
		if ngtx >= 421 and ngtx <=424 then 
			local hn = kflv*25
			txwz = '���ڡ����߱����'..lv..'���������߱�����ʣ�'..hn..'%�ס�'
		end	
		--��������
		if ngtx >= 425 and ngtx <=429 then 
			local hn = kflv*25
			txwz = '���ڡ��������ա�'..lv..'�������������ո��ʣ�'..hn..'%�ס�'
		end	
		--��������
		if ngtx >= 431 and ngtx <=434 then 
			local hn = kflv*25
			txwz = '���ڡ�����������'..lv..'�����������������ʣ�'..hn..'%�ס�'
		end		
		--��������
		if ngtx >= 435 and ngtx <=439 then 
			local hn = kflv*25
			txwz = '���ڡ����������'..lv..'��������������Ͷ�����ʣ�'..hn..'%�ס�'
		end	
		--���߱���
		if ngtx >= 441 and ngtx <=444 then 
			local hn = kflv*25
			txwz = '���ڡ����߱�����'..lv..'���������߱������ʣ�'..hn..'%�ס�'
		end	
		--���߱���
		if ngtx >= 445 and ngtx <=449 then 
			local hn = kflv*25
			txwz = '���ڡ����߱��С�'..lv..'���������߱��и��ʣ�'..hn..'%�ס�'
		end	
		--��������
		if ngtx >= 451 and ngtx <=454 then 
			local hn = kflv*25
			txwz = '���ڡ�����������'..lv..'�����������������ʣ�'..hn..'%�ס�'
		end	
		--����ɢ��
		if ngtx >= 455 and ngtx <=459 then 
			local hn = kflv*25
			txwz = '���ڡ�����ɢ����'..lv..'����������ɢ�����ʣ�'..hn..'%�ס�'
		end	
		--����ɱ��
		if ngtx >= 461 and ngtx <=464 then 
			local hn = kflv*25
			txwz = '���ǡ���ض��𡻣�������ɱ�����ʣ�'..hn..'%�ס�'
		end		
		--�����Ʒ�
		if ngtx >= 465 and ngtx <=469 then 
			local hn = kflv*25
			txwz = '���ڡ������Ʒ���'..lv..'�����������Ʒ����ʣ�'..hn..'%�ס�'
		end	
		--���߽�е
		if ngtx >= 471 and ngtx <=474 then 
			local hn = kflv*25
			txwz = '���ڡ����߽�е��'..lv..'���������߽�е���ʣ�'..hn..'%�ס�'
		end	
		--��������
		if ngtx >= 475 and ngtx <=479 then 
			local hn = kflv*25
			txwz = '���ǡ���ˮ������������������'..hn..'ʱ��ס�'
		end	
		--�����˺�
		if ngtx >= 481 and ngtx <=484 then 
			local hn = kflv*25
			txwz = '���ǡ������'..lv..'����������������'..hn..'ʱ��ס�'
		end	
		--���߶���
		if ngtx >= 485 and ngtx <=489 then 
			local hn = kflv*25
			txwz = '���ڡ����߶����'..lv..'���������߶�����ʣ�'..hn..'%�ס�'
		end	
		--���ߵ�ȼ
		if ngtx >= 491 and ngtx <=494 then 
			local hn = kflv*25
			txwz = '���ڡ����ߵ�ȼ��'..lv..'���������ߵ�ȼ���ʣ�'..hn..'%�ס�'
		end																			
		---------------------------------------------											
		-------------����Ч��--------------��ѧ�ž߱�
		--------------------------------------------
		--����--
		if ngtx == 1001 then 
			txwz = '���ǡ����졻����ÿ���ܵ������������ͷ�������1%+5�㣬�������999�㡣'
		end
		--Ѫ������ȫ�ظ�
		if ngtx >= 1002 then 
			local hx = kflv*2
			txwz = '���ǡ��նɡ�����ÿ�غϻظ�10%������������������������'
		end	
		--Ѫ������ȫ�ظ�
		if ngtx >= 1003 then 
			local hx = kflv*2
			txwz = '���ǡ��Ⱥ��������ж�ʱ������������������ŭ������֮һ��ֵ����ȫ״̬�ָ���'
		end					
	end
	return txwz
end

--�书�ؼ�
function KF_thing(kf)
	local thingid 
	for j = 0, JY.ThingNum - 1 do  --��ȡ��Ʒ
		if JY.Thing[j]["�����书"] >= 0 and JY.Thing[j]["�����书"] == kf then											
			thingid = j
			return thingid
		end	
	end
	--return thingid
end

--�ؼ��书
function Thing_kf(thingid)
	local wugongid = 0
	if JY.Thing[thingid]['����'] == 2 and JY.Thing[thingid]['�����书'] > 0 then
		wugongid = JY.Thing[thingid]['�����书']
	end
	return wugongid
end

--ϲ���趨
function Person_xihao(id)
    local n = ""
    local thingid = nil 
    local xihao = {[0]= '����', '��','ʳ��','ҩƷ','װ��','����','ȭ��','ָ��','����','����','����','�ڹ�','�Ṧ','��ѧ','����'}
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



--����ͼ
function Opersmp()
	instruct_39(167) 	--��
	instruct_39(166) 	--��
	instruct_39(160) 	--��	
	instruct_39(159) 	--��	
	instruct_39(158) 	--��
	instruct_39(157) 	--��
	instruct_39(125) 	--��
	instruct_39(156) 	--��
	instruct_39(154) 	--��
	instruct_39(153) 	--��		
	instruct_39(152) 	--��	    
	instruct_39(151) 	--��	
	instruct_39(145) 	--��
	instruct_39(144) 	--��
	instruct_39(143) 	--��
	instruct_39(142) 	--��
	instruct_39(141) 	--��
	instruct_39(140) 	--��
	instruct_39(139) 	--��
	instruct_39(138) 	--�����Ļʹ�	
	instruct_39(137) 	--��������
	instruct_39(129) 	--������	
	instruct_39(136) 	--������	
	instruct_39(135) 	--��������			
	instruct_39(134) 	--��������			
	instruct_39(133) 	--�򿪺���			
	instruct_39(127) 	--�򿪷���
	instruct_39(128) 	--�򿪳�������
	instruct_39(25)  --�򿪳���
	instruct_39(120) 	--�򿪳�������ɽׯ
	instruct_39(112) 	--�򿪳�������ɽׯ
	instruct_39(107)  	--�򿪳���������
	instruct_39(2)  	--�򿪳���ѩɽ
	instruct_39(103)  	--�򿪳���ҩ����
	instruct_39(101)  	--�򿪳���
	--instruct_39(102)  	--�򿪳���
	instruct_39(100)  	--�򿪳���
	instruct_39(98)  --�򿪳���
	instruct_39(97)  --�򿪳���
	instruct_39(96)  --�򿪳���
	instruct_39(95)  --�򿪳���
	instruct_39(94)  --�򿪳���
	instruct_39(99)  --�򿪳���
	instruct_39(92)  --�򿪳���
	instruct_39(83)  --�򿪳���
	instruct_39(82)  --�򿪳���
	instruct_39(81)  --�򿪳���
	instruct_39(80)  --�򿪳���
	--instruct_39(79)  --�򿪳���
	instruct_39(78)  --�򿪳���
	--instruct_39(77)  --�򿪳���
	instruct_39(76)  --�򿪳���
	instruct_39(75)  --�򿪳���
	instruct_39(74)  --�򿪳���
	instruct_39(73)  --�򿪳���
	instruct_39(71)  --�򿪳���
	instruct_39(69)  --�򿪳���
	instruct_39(68)  --�򿪳���
	instruct_39(66)  --�򿪳���
	instruct_39(65)  --�򿪳���
	instruct_39(64)  --�򿪳���
	instruct_39(63)  --�򿪳���
	instruct_39(62)  --�򿪳���
	instruct_39(61)  --�򿪳���
	instruct_39(60)  --�򿪳���
	instruct_39(59)  --�򿪳���
	instruct_39(58)  --�򿪳���
	instruct_39(57)  --�򿪳���
	instruct_39(56)  --�򿪳���
	instruct_39(55)  --�򿪳���
	instruct_39(54)  --�򿪳���
	instruct_39(53)  --�򿪳���
	instruct_39(52)  --�򿪳���
	instruct_39(51)  --�򿪳���
	instruct_39(50)  --�򿪳���
	instruct_39(49)  --�򿪳���
	instruct_39(48)  --�򿪳���
	instruct_39(47)  --�򿪳���
	instruct_39(46)  --�򿪳���
	--instruct_39(45)  --�򿪳���
	instruct_39(44)  --�򿪳���
	instruct_39(43)  --�򿪳���
	instruct_39(42)  --�򿪳���
	instruct_39(41)  --�򿪳���
	instruct_39(40)  --�򿪳���
	instruct_39(39)  --�򿪳���
	instruct_39(38)  --�򿪳���
	instruct_39(37)  --�򿪳���
	instruct_39(35)  --�򿪳���
	instruct_39(34)  --�򿪳���
	instruct_39(33)  --�򿪳���
	instruct_39(32)  --�򿪳���
	instruct_39(31)  --�򿪳���
	instruct_39(30)  --�򿪳���
	instruct_39(29)  --�򿪳���
	instruct_39(27)  --�򿪳���
	instruct_39(26)  --�򿪳���
	instruct_39(24)  --�򿪳���
	instruct_39(23)  --�򿪳���
	instruct_39(22)  --�򿪳���
	instruct_39(21)  --�򿪳���
	instruct_39(20)  --�򿪳���
	instruct_39(18)  --�򿪳���
	instruct_39(17)  --�򿪳���
	instruct_39(16)  --�򿪳���
	instruct_39(13)  --�򿪳���
	instruct_39(12)  --�򿪳���
	instruct_39(11)  --�򿪳���
	instruct_39(9)  --�򿪳���
	instruct_39(8)  --�򿪳���
	--instruct_39(7)  --�򿪳���
	instruct_39(6)  --�򿪳���
	instruct_39(3)  --�򿪳���
	instruct_39(2)  --�򿪳���
	instruct_39(1)  --�򿪳���
	--instruct_39(0)  --�򿪳���
end

--��Ϸ�̵�
--1Ϊ��ƷID,2Ϊ���ۣ�3Ϊ������4Ϊ��ʾ���
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
			SHUOMING[i] = JY.Thing[v[1]]['��Ʒ˵��']
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
	local sm = {'�͹٣�������*Ʒ��һ������*���˲�����','�͹٣���Ī��*С�����ӣ���*��Ų����ˡ�','�͹٣�һ����*����Թ���*ʮ������Ʒ��'}
	local size = CC.Fontsmall
	while true do
		if JY.Restart == 1 then 
			break 
		end
		Cls()
		lib.LoadPNG(91,10*2,0,0,1)
		lib.DrawStr(CC.ScreenW/2-w,h/5,'��     ��',C_CYGOLD,size, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)

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
					DrawString(CC.ScreenW/2.2-x1*2-bx*10,h-h/3,'��Ʒ����: ',C_CYGOLD,size*0.9)
					DrawString(CC.ScreenW/2.2-x1*2+w,h-h/3,JY.Thing[menu1[thingid]]['����'],M_DeepSkyBlue,size*0.9)
					DrawString(CC.ScreenW/2.2-x1*2+w*2,h-h/3,'       ���ۣ�',C_CYGOLD,size*0.9)
					DrawString(CC.ScreenW/2.2-x1*2+w*3+w/2,h-h/3,danjia[thingid],M_DeepSkyBlue,size*0.9)
					DrawString(CC.ScreenW/2.2-x1*2-bx*10,h,'Ч���� '..SHUOMING[thingid],C_RED,size*0.9)
					
				end
				n = n + 1 
				if n == 5 then 
					m = m + 1
					n = 0
				end
			end
			--lib.Debug('pg='..pg..' ʱlb= '..lb..' j='..j..' ʱ='..JY.Thing[menu1[thingid]]['����'])
		end
		n = 0
		m = 0

		lib.DrawStr(CC.ScreenW-x1-bx*30,CC.ScreenH-h,'�� �'..zongjia..'/'..CC.Gold,C_WHITE,size*0.8, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)
		lib.DrawStr(CC.ScreenW-x1+w*3+w*2/3,CC.ScreenH-h,'ҳ ����'..pg..'/'..pgnum,C_WHITE,size*0.8, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)
		lib.Background(x1+w/10,y/10-y/15,CC.ScreenW-w/10,CC.ScreenH-h*2/3,98)
		lib.DrawStr(CC.ScreenW/2+w*4,h/5,'�� �� ��',M_DeepSkyBlue,size*1.2, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)	
		lib.DrawStr(CC.ScreenW/2+w*5-w/2,h*6,'�� �ۣ�',M_DeepSkyBlue,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)	
		lib.DrawStr(CC.ScreenW-w-w/3,h*6,zongjia,C_RED,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)		
		for i = 1,#goumenu do 					
			DrawString(CC.ScreenW-w*4,h-h/3+(i)*h*4/10,JY.Thing[menu1[goumenu[i]]]['����'],C_CYGOLD,size)
			DrawString(CC.ScreenW-w*2,h-h/3+(i)*h*4/10,gounum[goumenu[i]]/gounum[goumenu[i]],C_CYGOLD,size)
			DrawString(CC.ScreenW-w,h-h/3+(i)*h*4/10,danjia[goumenu[i]],C_CYGOLD,size)
		end
		for i = 1,2 do 
			local jzw = {"����",'�˳�'}
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
								local tid = JY.Shop[sid]["��Ʒ" .. s]
								--local tnum = JY.Shop[sid]["��Ʒ����" .. s]
								if thid == tid then 
									JY.Shop[sid]["��Ʒ����" .. s] = JY.Shop[sid]["��Ʒ����" .. s] - thnum
									--lib.Debug('��Ʒ '..tid..' ����== '..thnum)
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

--��Ϸ�̵���δʹ��
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
	 	newArray[v] = {0,v} -- ���Ը�����ֵ
	end
	for k,v in pairs(newArray) do
	 	table.insert(menu,k)
	end
	table.sort(menu)
	for i = 1,#menu do
		if menu[i] ~= nil and JY.Thing[menu[i]]['��������'] > 0 then 
			menu1[#menu1+1] = menu[i]
			thingnum[#thingnum+1] = 99
			gounum[#gounum+1] = 0
			danjia[#danjia+1] = 10000
			SHUOMING[#SHUOMING+1] = JY.Thing[menu[i]]['��Ʒ˵��']
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
	local sm = {'�͹٣�������*Ʒ��һ������*���˲�����','�͹٣���Ī��*С�����ӣ���*��Ų����ˡ�','�͹٣�һ����*����Թ���*ʮ������Ʒ��'}
	local size = CC.Fontsmall
	while true do
		if JY.Restart == 1 then 
			break 
		end
		Cls()
		lib.LoadPNG(91,10*2,-1,-1,1)
		lib.DrawStr(CC.ScreenW/2-w/2,h/5,'�� Ʒ �� ��',C_CYGOLD,size, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)

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
				DrawString(CC.ScreenW-x1-h/3,h-h/3,'��Ʒ����: ',C_CYGOLD,size*0.9)
				DrawString(CC.ScreenW-x1+w,h-h/3,JY.Thing[menu1[thingid]]['����'],M_DeepSkyBlue,size*0.9)
				DrawString(CC.ScreenW-x1+w*2,h-h/3,'       ���ۣ�',C_CYGOLD,size*0.9)
				DrawString(CC.ScreenW-x1+w*3+w/2,h-h/3,danjia[thingid],M_DeepSkyBlue,size*0.9)
				DrawString(CC.ScreenW-x1-h/3,h,'Ч���� '..SHUOMING[thingid],C_RED,size*0.9)
			end
			n = n + 1 
			if n == 5 then 
				m = m + 1
				n = 0
			end
		end
		n = 0
		m = 0

		lib.DrawStr(CC.ScreenW-x1,h+h*5+h/2,'�� �'..zongjia..'/'..CC.Gold,C_CYGOLD,size*0.8, CONFIG.CurrentPath.."FONT/3.TTF",  0, 0)
		lib.DrawStr(CC.ScreenW-x1+w*3+w*2/3,h+h*5+h/2,'ҳ ����'..pg..'/'..pgnum,C_CYGOLD,size*0.8, CONFIG.CurrentPath.."FONT/3.TTF",  0, 0)
		lib.Background(x1+w/10,y/10-y/15,CC.ScreenW-w/10,CC.ScreenH-h*2/3,98)
		lib.DrawStr(CC.ScreenW/2+w*4,h/5,'�� �� ��',M_DeepSkyBlue,size*1.2, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)	
		lib.DrawStr(CC.ScreenW/2+w*5-w/2,h*6,'�� �ۣ�',M_DeepSkyBlue,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)	
		lib.DrawStr(CC.ScreenW-w-w/3,h*6,zongjia,C_RED,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)		
		for i = 1,#goumenu do 					
			DrawString(CC.ScreenW-w*4,h-h/3+(i-1)*h*4/10,JY.Thing[menu1[goumenu[i]]]['����'],C_CYGOLD,size)
			DrawString(CC.ScreenW-w*2,h-h/3+(i-1)*h*4/10,gounum[goumenu[i]]/gounum[goumenu[i]],C_CYGOLD,size)
			DrawString(CC.ScreenW-w,h-h/3+(i-1)*h*4/10,danjia[goumenu[i]],C_CYGOLD,size)
		end
		for i = 1,2 do 
			local jzw = {"����",'�˳�'}
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

--��Ŀ�̵�
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
		SHUOMING[#SHUOMING+1] = JY.Thing[menu[i][1]]['��Ʒ˵��']
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
	local sm = {'�͹٣�������*Ʒ��һ������*���˲�����','�͹٣���Ī��*С�����ӣ���*��Ų����ˡ�','�͹٣�һ����*����Թ���*ʮ�����Ʒ��'}
	local size = CC.Fontsmall
	--JY.Base['��Ƭ'] = CC.Sp
	while true do
		if JY.Restart == 1 then 
			break 
		end
		Cls()
		lib.LoadPNG(91,10*2,0,0,1)
		lib.DrawStr(CC.ScreenW/2-w/2,h/5+h/50,'�� Ŀ �� ��',C_GOLD,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)

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
				DrawString(CC.ScreenW-x1-h/3,h-h/3,'��Ʒ����: ',C_CYGOLD,size*0.9)
				DrawString(CC.ScreenW-x1+w,h-h/3,JY.Thing[menu1[thingid]]['����'],M_DeepSkyBlue,size*0.9)
				DrawString(CC.ScreenW-x1+w*2,h-h/3,'       ���ۣ�',C_CYGOLD,size*0.9)
				DrawString(CC.ScreenW-x1+w*3+w/2,h-h/3,danjia[thingid],M_DeepSkyBlue,size*0.9)
				DrawString(CC.ScreenW-x1-h/3,h,'Ч���� '..SHUOMING[thingid],C_RED,size*0.9)
			end
			n = n + 1 
			if n == 5 then 
				m = m + 1
				n = 0
			end
		end
		n = 0
		m = 0
		lib.DrawStr(CC.ScreenW-x1,h+h*5+h/2,'�� �'..zongjia..'/'..JY.Base['��Ƭ']..'(��Ƭ)',C_CYGOLD,size*0.8, CONFIG.CurrentPath.."FONT/3.TTF",  0, 0)
		lib.DrawStr(CC.ScreenW-x1+w*3+w*2/3,h+h*5+h/2,'ҳ����'..pg..'/'..pgnum,C_CYGOLD,size*0.8, CONFIG.CurrentPath.."FONT/3.TTF",  0, 0)
		lib.Background(x1+w/10,y/10-y/15,CC.ScreenW-w/10,CC.ScreenH-h*2/3,98)
		lib.DrawStr(CC.ScreenW/2+w*4,h/5,'�� �� ��',M_DeepSkyBlue,size*1.2, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)	
		lib.DrawStr(CC.ScreenW-w*4,h*6,'�� �ۣ�',M_DeepSkyBlue,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)	
		lib.DrawStr(CC.ScreenW-w*3,h*6,zongjia..'(��Ƭ)',C_RED,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)		
		for i = 1,#goumenu do 					
			DrawString(CC.ScreenW-w*4,h-h/3+(i-1)*h*4/10,JY.Thing[menu1[goumenu[i]]]['����'],C_CYGOLD,size)
			DrawString(CC.ScreenW-w*2,h-h/3+(i-1)*h*4/10,gounum[goumenu[i]]/gounum[goumenu[i]],C_CYGOLD,size)
			DrawString(CC.ScreenW-w,h-h/3+(i-1)*h*4/10,danjia[goumenu[i]],C_CYGOLD,size)
		end
		for i = 1,2 do 
			local jzw = {"����",'�˳�'}
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
						JY.Base['��Ƭ'] = JY.Base['��Ƭ'] - zongjia
						CC.Sp = JY.Base["��Ƭ"]
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
					if JY.Base['��Ƭ'] - zongjia < 0 then 
						smwz = 1
					else						
						JY.Base['��Ƭ'] = JY.Base['��Ƭ'] - zongjia 
						--CC.Sp = JY.Base['��Ƭ']
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

--������Ϣ
function LGJYXX()
	--����
	local bx,by = CC.WX,CC.HY 
	local size = CC.FontSmall2
	local yl = CC.Gold
	--����
	local ts = JY.Base["��������"]..'��'
	
	--�Ѷ�
	local tnd = MODEXZ2[JY.Base["�Ѷ�"]]	
	--��ͨ
	local yxms
	if JY.Base["��ͨ"] == 0 then
		yxms = "��ͨ"
	elseif JY.Base["��ͨ"]==1 then
		yxms = "��ͨ"
	else
		yxms = "����"
	end	
	local yxzm = JY.Base['��Ŀ']
	local dd = JY.Person[0]['Ʒ��']
	local menu = {yl,ts,dd,yxms,tnd,yxzm}
	local menu1 = {'��Ǯ��','���飺','����:','ģʽ:','�Ѷ�:','��Ŀ:'}
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

--�书��������
function WGns(wgid)
	local r= 0
	local thid = nil
	for j = 0, JY.ThingNum - 1 do
		if JY.Thing[j]["�����书"] == wgid then				
			r = JY.Thing[j]["����������"] 
			break
		end		
	end
	return r;
end

--ɸѡ��� �������
function RandFetch(list,num,poolSize,pool) -- list ���ɸѡ�����num ɸȡ������poolSize ɸȡԴ��С��pool ɸȡԴ
    pool = pool or {}
    math.randomseed( tonumber(tostring(os.time()):reverse():sub(1,6)))
    for i=1,num do
        local rand = math.random(i,poolSize)
        local tmp = pool[rand] or rand -- ���ڵڶ������ӣ���Ÿ�id����һ�µ�
        pool[rand] = pool[i] or i
        pool[i] = tmp
        table.insert(list, tmp)
    end
end

--�����츳��n == 1��ʾ�У�nil��ʾ��
--�����츳�ñ������
--�ж������Ƿ��Ѿ��д��츳
function PersonTF(id,tf)
	for i = 1,5 do 
		if JY.Person[id]['�츳'..i] > 0 then 
			if JY.Person[id]['�츳'..i] == tf then 
				return true
			end
		elseif JY.Person[id]['�츳'..i] <= 0 then
			return false
		end
	end
end

--�Ϲ�����
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

--�츳
function SetPersonTF()
    CC.Weather = {}	
	CC.Weather[1] = {0,"����",294,"�������˿��������ϡ��ƶ���-1����������-5%���޷���ȼ����ѨЧ�����룬��ѪЧ��������"}	
	CC.Weather[2] = {0,"��ѩ",295,"��ѩ���ж�����������-3���Ṧ-5%�����պ͵�ȼЧ�����룬����ͱ���Ч��������"}	
	CC.Weather[3] = {0,"����",296,"������������Ұ���ޡ�����-10%������-5%����Ѫ�������룬��ѨЧ���ӱ���"}
	CC.Weather[4] = {0,"����",297,"��������쳣��С�Ļ�������-10%������ʱ����룬����Ч�����룬���պ͵�ȼЧ��������"}
	CC.WeatherCD = 0
	CC.weat = 0
	--ʱ��
    CC.Daytime = 0
	CC.Miao = 0
	CC.Shichen = 4	
	CC.Day = 1
	CC.Year = 1	
	CC.Month = 1
	--���������츳����
	CC.SetTF_add = {}
	for i = 1,999  do 
		CC.SetTF_add[i] = {}
	end
	CC.Teji_kf = {}
	for i = 1,99 do 
		CC.Teji_kf[i] = {}
	end

	CC.PTFSM = {}
	--��3Ϊ2ʱ��ר���츳����4Ϊ1ʱ�����츳����4Ϊ2ʱ�������츳
    CC.PTFSM[9999] ={'�������','��������9999����ʹ�þ����񹦹���',1,1,3}
    CC.PTFSM[9998] ={'�������','�ж�����ʱ�ѷ��ж����������Ѫ���ж������⡢���ա����˲��ظ����200������ֵ',1,1,3}
    CC.PTFSM[9997] ={'��ɽ����','���������Զ��˹�����ɽ���书������������',1,1,3} 
    CC.PTFSM[9996] ={'���羪��','��ʼ����ֵ1000��ÿ�ι�����������+200��',1,1,3}
    CC.PTFSM[9995] ={'�������','�ܵ��������˺�����20%���ܵ������˺�����20%',1,1,3}
    CC.PTFSM[9994] ={'��������','ʹ�÷�ħ�ȷ��ض������������类������׷��һ�ι�������ħ�����ر�����׷�����ˣ���׷������ֵ�˺���',1,1,4}
    CC.PTFSM[9993] ={'������˫','�����������书����+300��',1,1,3}
    CC.PTFSM[9992] ={'ʥ������','���������գ����մ���25��ص�ȼ����ȼ������С��Χ�˺�',1,1,3}
    CC.PTFSM[9991] ={'ħ������','�ҷ�ȫ�幥���˺���120�����з�ȫ�幥���˺���90����',1,1,3}
	CC.PTFSM[9990] = {'��תǬ��','Ǭ����Ų�Ʒ���Ч�� ǿ��������40%�˺��������˹�����Ǭ����Ų�ƿ�ͬʱ�����������ˡ� ѧ��Ǭ���󣬱�����ʱ���У�35+��������%�ļ��ʴ�������תǬ������A.������Χ�ڶԵз��Ĺ���������Ų�ƣ�����300����������B.��ESC��ȡ��Ų�ƣ����α������ض�����Ǭ������50%�˺��������˹�������������תǬ�����󣬵з��������˺��������ߣ�ŭ��ֵ100ʱ������תǬ����������������10%��',2,1,3}
    CC.PTFSM[9989] ={'�������','�����ر�����ȭ���书���Ʒ�30%��',1,1,4}
    CC.PTFSM[9988] ={'�����ϳ�','ս�����ҷ�Ů�Խ�ɫԽ�����˺�Ч��Խ�ߡ�',2,1,2} 
    CC.PTFSM[9987] ={'��ͨ�ټ�','���������书����-20�������书���������������ԣ�����ֵ+200����ֵ+200,����ֵ+200��',1,1,4}
    CC.PTFSM[9986] ={'�����','ս���п��Ը���һ�Σ�������������ˣ����߱����˺���',2,1,4}
    CC.PTFSM[9985] ={'�����޳�','��ʹ���ڹ��������书��Χ+1��',1,1,3}
    CC.PTFSM[9984] ={'�����','ÿ�ж�һ�Σ������˺�+5%,�ܵ����˺�-5%��(����30%)',1,1,3}
    CC.PTFSM[9983] ={'�������','�����ƹ�����Χ��Ϊ�㣬��������������ֵ����50%ʱӵ�о�������',1,1,3}
    CC.PTFSM[9982] ={'�����޽�','������ǰ���ַ���������������ַ�������ʴ�϶Է�������',2,1,4}
    CC.PTFSM[9981] ={'��˷����','������ͬʱ�ڳ�ʱ�����Ǽ����ٶ�����2�㣬ս����ʼ���ǰ���α����������˺���������7����Ѻ󣩡�',1,1,3} 
    CC.PTFSM[9980] ={'��������','ÿ����һ���书���������˺�����2%�����˺�����2%',1,1,3}
    CC.PTFSM[9979] ={'��������','�ж�ǰ���ʴ��������������е�һ�ֻ���֣��������ʵս�����Ӷ����Ӵ����������*��-����������ӡ��������50��*��-��������ӡ�����Ʒ�40%*��-����ʨ��ӡ������������800*��-����ʨ��ӡ������������800*��-���⸿ӡ���������ƶ���3*��-���ڸ�ӡ��������Ŀ������-200*��-������ӡ��������������*ǰ-����ƿӡ����������Χ����*��-����ȭӡ�����ػ���������',2,1,4}
    CC.PTFSM[9978] ={'����˫��.��','���߱��⣬�����ر���',2,1,3}
    CC.PTFSM[9977] ={'�����޼�','��������ʱ����Ŀ��10%������ÿѧ��һ�Ž��������������Ʒ�Ч������2��',1,1,4}
    CC.PTFSM[9976] ={'����̫��','��������90��ǹ�������������30%�������ߣ���ŭʱ�ض����ߣ��ƶ�ʱ�ж�������',2,1,4}
    CC.PTFSM[9975] ={'��ħ����','��������ʱ50%���ʷ���������Ч֮һ���켫��Ԩ���Ʒ�50%���ƾ����£�������������������800',1,1,4}
    CC.PTFSM[9974] ={'�Ž��洫','���¾Ž�����ʱ50%���ʣ�����100%��������������100%����������������Ч������ʽ������+200���ý�ʽ���˺�+30%������ʽ��ǿ��ɱ��150���뽣ʽ���˺��������ݼ�;������ʱ������Xʽ�������ܵ����˺�20%���������»غϼ���λ��-200',1,1,4}
    CC.PTFSM[9973] ={'�伲���','���ʷ���������ʱ�������ѷ�����λ��+100��������λ��+300',1,1,3}
    CC.PTFSM[9972] ={'�������','���ʷ�����������������1000������������',1,1,3}
    CC.PTFSM[9971] ={'������ɽ','���ʷ�����������ֻ�ܵ��˺�30��',1,1,3}
    CC.PTFSM[9970] ={'��������','���ʷ������������������������������20��',1,1,3}
    CC.PTFSM[9969] ={'�ھ�����','�з�ÿ5�����ֵ���ٹ����˺�1%,�Դ��ؼ������벻������ÿ��������Իû��з���һ���书,��ս100���ֵ��100������ֵ��ÿ���ж�����������10�����ֵ��5������ֵ,������ֵ������ֵΪ0ʱ���𺮶���������������͵�컻�ա����ָ�����/���������ֵ������ֵ����100������ֵ����50������״̬���㡣ÿ100ʱ�򷢶�һ�Ρ�',2,1,4}
    CC.PTFSM[9968] ={'��ʤǧ��','ÿ�غ�50�����ʴ������з�����-150����������+150��',1,1,3}
    CC.PTFSM[9967] ={'������','������ʱ20%����ͨ��������ǧ�ﻯ�⣬���ð����������ˡ�',1,1,3} 
    CC.PTFSM[9966] ={'������','�ܵ����������˺�����30%������������',2,1,4}
    CC.PTFSM[9965] ={'����˱�','��֬���񱭣��˱���Ϊ��󣬿�����2����*Ϭ�Ǳ���ս����ÿ�κȾƼ�������4�㣬�»غϼ���λ������*���ٱ���ս������������һ�ţ���֥�������⣩��ҩ*��ͭ����ս������������һ̳��*ҹ�Ɑ�������ʴ���Ƚ��ͣ���ŭ�ض�����*��������5%���ʴ������������ٲ������ܣ��Ⱦƺ��������30%*�Ŵɱ���������ʱ������������ŭ��������������ʱ�޷�����������ŭ��������*��䱭�����߱�������',2,1,4}
    CC.PTFSM[9964] ={'���ƻ�ת��','8�ѷɵ�������8x8��Χ������ƶ����ɵ�1x1��Χ�ڵĵз�ʱ��10��������ʧ���ɵ��ص�λ��ʱ��20��������ʧ*�ǡ�BOSS״̬����ͬʱ����16�ѷɵ�',2,1,4}
    CC.PTFSM[9963] ={'һέ�ɽ�','һέ�ɽ��Ṧ�Զ��˹���',2,1,3}
    CC.PTFSM[9962] ={'��������','�ƶ���������2��,��������',1,1,2} 
    CC.PTFSM[9961] ={'���߲�˿��','����ʱ30%�������*�ǡ�BOSS״̬����ÿ���30ʱ�򣬽����һ���з�Ŀ����������3x3��Χ�����λ������',2,1,3}
	CC.PTFSM[9960] ={'ȭ����ͨ','ȭȭ����+100����������10%ȭ�ƹ���Ĺ������ͷ���������',1,1,2}
	CC.PTFSM[9959] ={'ָ����ͨ','ָ������+100����������10%ָ�����ɵĹ������ͷ���������',1,1,2}
	CC.PTFSM[9958] ={'������ͨ','��������+100����������10%���������Ĺ������ͷ���������',1,1,2}
	CC.PTFSM[9957] ={'������ͨ','��������+100����������10%ˣ�����ɵĹ������ͷ���������',1,1,2}
	CC.PTFSM[9956] ={'���ž�ͨ','��������+100����������10%��������Ĺ������ͷ���������',1,1,2}
	CC.PTFSM[9955] ={'��ȭ�޵�','ȭȭ����+200����������20%ȭ�ƹ���Ĺ������ͷ���������',1,1,4}
	CC.PTFSM[9954] ={'ǧ����ͨ','ָ������+200����������20%ָ�����ɵĹ������ͷ���������',1,1,4}
	CC.PTFSM[9953] ={'����ͨ��','��������+200����������20%���������Ĺ������ͷ���������',1,1,4}
	CC.PTFSM[9952] ={'������','��������+200����������20%ˣ�����ɵĹ������ͷ���������',1,1,4}
	CC.PTFSM[9951] ={'������˫','��������+200����������40%��������Ĺ������ͷ���������',1,1,4}
	CC.PTFSM[9950] ={'ԽսԽ��','�����˺��ͼ����ܵ����˺�����ѪԽ�����ӵĵ�Խ�ࡣ����15%��������35%',1,1,3}
	CC.PTFSM[9949] ={'��ħ','��ŭʱ��һ�����ʽ�����ħ״̬�����߷�Ѩɱ������Ѫ20%������200�����ұ�������������������ŭ������ħ������',2,1,3}
	CC.PTFSM[9948] ={'��������','ʹ�õ���ʱ����10��Χ���˱���20�㣬���ʴ���������������10ʱ�򣬱����˹������ʶ�����ˡ�',2,1,4}		
	CC.PTFSM[9947] ={'�����ɱ�','ÿѧһ���ڹ���������ϵ����ֵ����20�㡣',2,1,3}
	CC.PTFSM[9946] ={'��Ȼ���','����Ч����ÿ����һ���ڹ�����+100������+100������10%ת��Ϊ�˺�����ŭ��������������Ч�����ܵ��������ʷ���"��Ȼ�������",�����ܵ����˺��������������������ٵ���ֵ�����ڹ��������ʷ���"��Ȼ���"��Ŀ��׷�Ӳ�������ֵ���˺�����ŭ׷�ӵ��˺����ӡ�',2,1,3}
	CC.PTFSM[9945] ={'�����ݺ�','ʱ�򴥷�����',2,1,4}
	CC.PTFSM[9944] ={'���Ʒ���','������30%�����мܣ��ҽ��з������˺�Ϊ100%�������붷תͬʱ������',2,1,3}	
	CC.PTFSM[9943] ={'���÷���','���������Ṧֵ2����ɱ��ֵ�������������Ṧֵ2��������ֵ��ʹ�÷��޵����������ӣ��Ṧֵ/2���Ĺ̶��˺���',1,1,2} 
	CC.PTFSM[9942] ={'������λ','������+500��',1,1,3}			
	CC.PTFSM[9941] ={'����','��ս����λ��1000,ÿ���������������˺�3%,ÿ���������������˺�3%��',1,1,4}
	CC.PTFSM[9940] ={'���̽Կ�','BOSS״̬ʱ���ิ���ǣ��ױ�����ʱ���ʴ��������ܵ����˺���ȫ��������������������������*������ʶ�����ж�ǰ���ʴ������з���������DEBUFF��',2,1,4}			
	CC.PTFSM[9939] ={'��������','��Ħ�ܵ������������ŭ������ÿʱ������1��ŭ����,*���������Ŀ����������ֵ��ÿ����һ�μ���2%,*��Ħÿ�غ��ж�ǰ������������ŭ��������ֻҪ����һ��ָ�����״̬���������������������һ��ָ�����״̬��',2,1,4}			
	CC.PTFSM[9938] ={'������а','���¸���59������Ч�����20%�����µ���61������Ч�����20% ',1,1,3} 
	CC.PTFSM[9937] ={'���Զ���','���Ե�������������ƹ���������������+200��',1,1,2} 
	CC.PTFSM[9936] ={'ؤ�����','ѧϰ�򹷰����뽵��ʮ��������������ϵ��������',1,1,3} 
	CC.PTFSM[9935] ={'��Ȼ����','���ʴ���30��������Ȼ����س������ˣ�����С����30��������Ȼ����ض����� ',1,1,3} 
	CC.PTFSM[9934] ={'��������','20%�������߱���������ʱ�ܵ����˺���50%���ʷ���DEBUFF,ÿ�η�������λ��ǰ��200��ÿ�η���50%��������һ��������������������3��,���������������ÿ�������αط���ȫ���˺���',2,1,4} 
	CC.PTFSM[9933] ={'��ˮ��','Ѫ������50%�������˺����ӣ�ʵս/10��%���ܵ����˺����ӣ�20-��ʵս/50����%��Ѫ������50%�������˺����٣�20-��ʵս/50����%���ܵ����˺����٣�ʵս/10��%���ܵ��ĵ����˺�������������������ֵ��50%����������50%���ܵ��ĵ����˺����������������ֵ25%���ܵ������˺�ʱ���߱����˺��������ж����ж���ظ�10%������ÿ5�غϴ���һ�Ρ�',2,1,4} 
	CC.PTFSM[9932] ={'��������','����״̬�±���������λ��+100��',1,1,2} 
	CC.PTFSM[9931] ={'ʮ��ʮ��','��Ȱǰ���ʴ���ʮ��ʮ�󣬲�ʹ��һ�εĹ������ӻ���Ч����',2,1,4} 
	CC.PTFSM[9930] ={'�ڼ�����','ս����Χ��������60%��������ʱ40%������ȫ����ɱ�������ˡ�',2,1,4} 
	CC.PTFSM[9929] ={'���ٵ���','�����츳�ڹ��Ǿ����澭�Զ��˹�*����ʱ����"��֮��"����Ŀ���������ֵ5%���˺�*������צ�����������40%������������ŭ��������',2,1,4}	
	CC.PTFSM[9928] ={'�׾�ϴ��','�����书���˫����Χ����ϵ���������׽�����书������Ч��Ϊ250+��������X50',2,1,4}	
	CC.PTFSM[9927] ={'����̫��','��������ʱ��100�����ʻ������*̫��������ʱ�����������һ��׶���30%����',2,1,4}	
	CC.PTFSM[9926] ={'�Ϻ��Ƴ�','�ж���۳�5������*�ظ�25%��ʧ����',1,1,2}	
	CC.PTFSM[9925] ={'�����޵�','��Ч���ʶ����ж������¸���100ʱ�����߱����������˺�',2,1,4}
	CC.PTFSM[9924] ={'�������','�������˺����롣',1,1,3}	 
	CC.PTFSM[9923] ={'���ػ���ʡ','�ж�����ʱ�ظ��ҷ�ȫ�����5%���������100������ֵ��',1,1,2}		
	CC.PTFSM[9922] ={'�̼ұ���','ʹ�ð����ƺ���Ե�׷��300�˺�*ʹ�ð��Ե�������Ʊض�����',1,1,3}		
	CC.PTFSM[9921] ={'���ڴ���','���Ե�����1.5�����ܵ�������30%�����ð��Ե�����',1,1,3}		
	CC.PTFSM[9920] ={'���ڶ���','����������1.5�����ܵ�������30%�����ð����Ʒ���',1,1,3}		
	CC.PTFSM[9919] ={'��ǿ����ʦ','������������567��׷��567������',1,1,3}		
	CC.PTFSM[9918] ={'�����˼�','ʹ�ô������Ŀ��׷�Ӳ�������ֵ���˺�',2,1,3}		
	CC.PTFSM[9917] ={'�䵱����','ʹ��̫��ȭ��̫�����������Զ��������״̬��',2,1,2}		
	CC.PTFSM[9916] ={'���Ź�Ԫ','����񵵣������˺������з�����',2,1,4}	
	CC.PTFSM[9915] ={'������ʿ','����ˤ����������������ʹ�����޷��ƶ�һ�غ�',1,1,3}		
	CC.PTFSM[9914] ={'Τ��˫��','ʹ��Τ���Ƽ��ʴ�������Х���족*����������Ŀ����ʻ��ң�������Ŀ�������λ�õ���300',1,1,3}		
	CC.PTFSM[9913] ={'����˫��','��������������80%�˺����������»غϹ����У�����ʱ���������˺���80%Ϊ�������ӻ��ܡ���ŭ�󴥷����������ӡ������Χ���е������ϵ�ŭ����',2,1,4}
	CC.PTFSM[9912] ={'����ħ��','����ʱ50%����ʹ�߸��ڵ��˻�������5ʱ��',1,1,3}
	CC.PTFSM[9911] ={'����֮��','�Ṧ�ɳ��ӱ���װ�����ӵ��Ṧ�ͼ����ӳ�˫����',1,1,3}
	CC.PTFSM[9910] ={'���ұ���','��������50%����15%����������25%����30%��',1,1,3}
	CC.PTFSM[9909] ={'ǧ������','����ֵ����50%�˺�1.25��������25%�˺�1.5����',1,1,3}
	CC.PTFSM[9908] ={'�������','��ŭ�󹥻�ŭ��ֵ����ֻ����10~40��',1,1,3}
	CC.PTFSM[9907] ={'�׾Թ�϶','15%�������ܹ���������������Խ�ͣ�������Խ�ߣ����35%�����ʡ�',1,1,4}
	CC.PTFSM[9906] ={'ܽ�ؽ���','������������ϵ������ʵ�˺���',1,1,2}
	CC.PTFSM[9905] ={'ˮ���黪','���˶���ʱ�ָ���Ѫ����',1,1,2}
	CC.PTFSM[9904] ={'���ĺ���','����ʱ�з�ȫ���ж�20�㣬���ѷ�ȫ�������һ��ҩƷBUFF��',1,1,3}
	CC.PTFSM[9903] ={'��������','�籾�ι�������˺�����150����׷��һ��������һ��׷������3�Σ���',1,1,3}
	CC.PTFSM[9902] ={'��������','������ʬ���س����⣬����Ŀ�����϶��ء�',1,1,3}
	CC.PTFSM[9901] ={'��Ц����ɢ','�غϽ���ʱ���ж����۳��з�������',1,1,2}
	CC.PTFSM[9900] ={'��������','������������������ѧ�ؼ���',2,1,3}
	CC.PTFSM[9899] ={'��������','�ڳ�ʱ���з��Ǳش�����Ч���������½�5�㣬�ҷ���Ч��������5�㡣',2,1,3}
	CC.PTFSM[9898] ={'������','�������ڳ�ʱ���ҷ��񵲺�����������400��',1,1,3}
	CC.PTFSM[9897] ={'��������','������������������������ѧ��',2,1,3} 
	CC.PTFSM[9896] ={'������ʯ','һ���ڳ�����һ�Ƴе����������˵�һ�롣 ',1,1,2}
	CC.PTFSM[9895] ={'��Ѫ����','�����������Ƶ�������Χ������100��',1,1,3} 
	CC.PTFSM[9894] ={'�޺���ħ','ѧ���޺���ħ��������ʱ�س����޺���ħ����Ч��Ч����ǿ10% ',1,1,2}
	CC.PTFSM[9893] ={'��������','ʹ�������񽣴������о��У�������ʵս������ÿ100ʵս����5�� ',2,1,3}
	CC.PTFSM[9892] ={'��������','����Χ��һ��15%�������ܹ�����',1,1,3}
	CC.PTFSM[9891] ={'�ɷ罣��','��ɽ���Ѻ��ɷ罣���������������������ر�����',1,1,2}
	CC.PTFSM[9890] = {'����ҹ��','����������Χ+1������ʱ���ʷ�����Ц����������׷�������� ',2,1,3}
	CC.PTFSM[9889] ={'ɱ����ҽ','ÿ����һ�����˼����ٶ�+3�㡢ҽ������+50�����5����Ч����',1,1,3}
	CC.PTFSM[9888] ={'��а����','ʹ�ñ�а������ʽ�����ġ� ',1,1,2}
	CC.PTFSM[9887] ={'Ѫ��Ʈ��','���ݱ�����ɵ��˺������һ�ֵļ���λ�ã�����400 ',1,1,3}
	CC.PTFSM[9886] ={'����ɳ��','ÿ����һ���з������������������200��',1,1,2}
	CC.PTFSM[9885] ={'ǧ�����','���϶����������1~3�㡰����״̬����ÿ�����1%�����ٶȣ�����50�� ',1,1,3}
	CC.PTFSM[9884] ={'�����ֿ�','����ʱ����з����ϵı������50������60%���ʽ��䶳��10ʱ�� ',1,1,3}
	CC.PTFSM[9883] ={'��Ե���','����ʱ50%���ʴ���������ӻ������»غϼ���+200 ',1,1,3}
	CC.PTFSM[9882] ={'��ϲ���','��ת���Ʒ�������100%������ʱ���ӱ���ֵ����ض�������ϲ��� ',1,1,3}
	CC.PTFSM[9881] ={'�����洫','ʹ��������ʱ���ʳ����и���+20%�������񽣺��ڽ���50%�����츳�⹦Ч�����ӣ�����75%�������ģ� ',1,1,3}
	CC.PTFSM[9880] ={'һ�յ���','��ŭʱʹ���Ʒ�����ʹ����˫����������10ʱ�� ',1,1,3}
	CC.PTFSM[9879] ={'ع�����','����ʱ�ض������Ѫ ',1,1,1}
	CC.PTFSM[9878] ={'Ѫ����Ӱ','��ɱ�з��󣬱���ɱ����״̬����ж������Ȼ�״̬9999ʱ��',1,1,3}
	CC.PTFSM[9877] ={'ħ����','ÿ���غϽ���ħ����״̬50ʱ��ŭ��ֵ�����١�',1,1,3}
	CC.PTFSM[9876] ={'�λ��ǳ�','��ת����ʱ�����ӱ���ֵ����ض�������ϲ��̷������Ρ� ',1,1,3}
	CC.PTFSM[9875] ={'��������','����ʱ30%�ĸ��ʴ�������������������Ŀ���˺�30%������һ�غϣ��޷����� ',1,1,3} 
	CC.PTFSM[9874] ={'������ǽ','������ʱ���ʴ���������ɽ������������ɽʱ��������˺���ת��Ϊ���ܡ� ',1,1,4}
	CC.PTFSM[9873] ={'��������','���浶������������.���浶����������100%�� ',1,1,3} 
	CC.PTFSM[9872] ={'��������','�ж��������ҷ�ȫ��100���� ',1,1,2}
	CC.PTFSM[9871] ={'��ٯ����','�ж�ǰ�����ҷ�ȫ��100���� ',1,1,2}
	CC.PTFSM[9870] ={'�����޼�','�������˺����20%����Ů���˺�����20% ',1,1,2}
	CC.PTFSM[9869] ={'���ϳ���','������ʱ�ָ�80������ ',1,1,2}
	CC.PTFSM[9868] ={'ת˲����','ÿ��199ʱ���Զ�����Ѫ���岢�����������쳣״̬�� ',1,1,3}
	CC.PTFSM[9867] ={'�������','������ʱ30%���ʶ�����Ÿ�Χ�ڵ����ͷ��׵粢��ֹ�����������������������׵��˺��� ',1,1,3}
	CC.PTFSM[9866] ={'���ֻش�','������ʱ����10%���ʽ��ܵ����˺�ת��Ϊ��Ѫ ',1,1,3}
	CC.PTFSM[9865] ={'��֮����','ʹ�ý���ʮ���ƣ�����40%���ʷ���������.���⡿��ʹ�ý���ʮ���Ʒ�������ʱ����������غ󾢣����������˺���ɱ����NPC�̶�10�أ��� ',1,1,3}
	CC.PTFSM[9864] ={'����õ��','װ����⬼�ʱ������30%�ܵ��Ĺ����˺� ',1,1,3}
	CC.PTFSM[9863] ={'����ޥ��','�����书�ؼ�ʱ����ϵ����ֵ�ɳ����� ',1,1,3}
	CC.PTFSM[9862] ={'��Ŀ����','�����书�ؼ�ʱ����Χ����ֵ�ɳ����� ',1,1,3} 
	CC.PTFSM[9861] ={'��������','ʹ�ý���ʮ���ƣ�40%���ʷ���������.�����ˡ�����ŭʱ�ض����� ',1,1,3}
	CC.PTFSM[9860] ={'�̺�����','����ʱ�����̺�������,��һ��100%����ɱȫ���������500������ʱ��������40% ',1,1,3}
	CC.PTFSM[9859] ={'����չ��','�ƶ�����+3,ʹ����������ʱ��������Χ��Ϊ���ƶ��� ',1,1,2} 
	CC.PTFSM[9858] ={'�߻���ħ','����ʱ��С������Ծ������ֵ������ӣ���ѧ�����˺󣬱������ض����롾��.���˾���-�߻���ħ��״̬���߻�״̬����/����Ч�����10%������/����/���м��ʴ����ߣ��߻�״̬�޷���Ϣ������������20�㣬��ֹͣ�߻� ',1,1,4}
	CC.PTFSM[9857] ={'������','��󡹦.������Ч����ǿ�����������ֵ׷���˺� ',1,1,2}
	CC.PTFSM[9856] ={'�Ҷ���ţ','����ʱ��50%�������ӵз�30%������ ',2,1,3}
	CC.PTFSM[9855] ={'��������','��������������˺���',1,1,3}
	CC.PTFSM[9854] ={'�������','����ʱ����(25+ʵս/20)%����ʹ�з��޷������ڹ����� ',1,1,3}
	CC.PTFSM[9853] ={'����һ��','ս�����״α����˿ɸ���һ�Σ��ظ�70%����ֵ������״̬���������ж�������󣬼����ٶ�+5�� ',1,1,3}
	CC.PTFSM[9852] ={'����ˮ��Ʈ','�ƶ�����+5 ',1,1,2}
	CC.PTFSM[9851] ={'һ��������','��������ʱ������ʹ��������ת��Ϊŭ��ֵ������������ֵ�� ',1,1,3}
	CC.PTFSM[9850] ={'��������','ʹ�������书���ʷ������������塤�������ԡ�*׷��800��������������14�����飬�򴥷�����Ч�������� ',1,1,2}
	CC.PTFSM[9849] ={'������','���߽����˺�����25% ',1,1,1}
	CC.PTFSM[9848] ={'һ����Ѫ','�������������Ѫ�������ر����� ',1,1,3}
    CC.PTFSM[9847] ={'��̩��','ÿ��100ʱ�򼤻�һ�Ρ���̩���������������˺�10ʱ�� ',1,1,3} 
	CC.PTFSM[9846] ={'��̥�׽���','�ڵз�Ҫ���õ�ҩƷ�м��뱪̥�׽��裬ʹ���ѪЧ����Ϊ��Ѫ ',1,1,2}
	CC.PTFSM[9845] ={'����ͨ��','�����ͱ�����ʱ�������κ�ϵ��������������ϵ������ӳ� ',1,1,3} --�޸�
	CC.PTFSM[9844] ={'����ʤ����','��ŭʱ��ʹ�ö��¾Ž�������׷��1000����������10ʱ��ľ�ֹ״̬���ɵ��� ',1,1,3}
	CC.PTFSM[9843] ={'���ҽ���','����ʱ���ʣ�ʹ�ó����ٱض����������������ν��������Եз�ȫ�����50���˺� ',1,1,2}
	CC.PTFSM[9842] ={'�����齣','ÿ����һ�Ž���������Ч������5%����ʼ����+50 ',1,1,3}
	CC.PTFSM[9841] ={'��������','������ʱ��30%���ʷ���"�������ٲ�"���� ',1,1,3}
	CC.PTFSM[9840] ={'��������','ʹ�ý�������ʱ��Ϊ������ ',1,1,2}
	CC.PTFSM[9839] ={'���콣','ʹ�ý����������»غϼ���+100 ',1,1,2}
	CC.PTFSM[9838] ={'���;���','�ҷ�ȫ�幥�������10%�� ',1,1,2}
	CC.PTFSM[9837] ={'��������','����ʱ���ʼ���λ����Ծ-30~40�� ',1,1,2} 
	CC.PTFSM[9836] ={'����������','�ж���50%����ʹ�á����������ȡ���������������ˣ����100���˺� ',1,1,2}
	CC.PTFSM[9835] ={'��צ����','��ŭʱʹ�û�צ�����ִ������壬��������ɻ����Դ��� ��',1,1,2}  
	CC.PTFSM[9834] ={'���޳�','������ʱ�ܵ��˺��������1%~25% ',1,1,2}
	CC.PTFSM[9833] ={'����֮ŭХ','����ʱ����������֮ŭХ�����з�ȫ�弯������100�� ',1,1,2}
	CC.PTFSM[9832] ={'һƬ����','���һ�����������70%�� ',1,1,2}
	CC.PTFSM[9831] ={'һ��ֹɱ','�ж�ǰ�����ŭ��ֵ����������25�㴥����ȫ��з�50%����һ�غϿ־塣',1,1,2}
	CC.PTFSM[9830] ={'����ڸ�','����ֵ����50%ʱ������Ч������20% ',1,1,2}
	CC.PTFSM[9829] ={'����֮��','ÿ�����غ��ж�ǰ����������15��������500ʹ�ҷ�ȫ�弯��+200��',1,1,2}
	CC.PTFSM[9828] ={'ʳ��','�������������� ',1,1,2}
	CC.PTFSM[9827] ={'��Ϊ����','ÿ��50ʱ���������˷�����ö�������� ',1,1,2}
	CC.PTFSM[9826] ={'��������','��������10%����������10%�� ',1,1,2} 
	CC.PTFSM[9825] ={'����ʹ��','���¸���59���ж�����������Χ�ڶ������� ',1,1,2}
	CC.PTFSM[9824] ={'����ʹ��','���µ���61���ж�����������Χ�ڵ���ʩ�� ',1,1,2}
	CC.PTFSM[9823] ={'��������','�����ر��⣬���ⳬ��50����Ŀ�꣬׷�ӱ���ֵ����ʵ�˺����������߱��� ',1,1,3}
	CC.PTFSM[9822] ={'��������','�ж���ʹ�á��������ơ����������߸���ˣ����100���˺� ',1,1,3}
	CC.PTFSM[9821] ={'�޸�����','���������ʷ����޸����μ���30% ',1,1,3} 
	CC.PTFSM[9820] ={'����Ȼ','����ʱ�����»غϼ���+500 ',1,1,3}
	CC.PTFSM[9819] ={'������','����ʱ����60%���ʸ��з�����1-3������״̬������20�㣩��ÿ������״̬���͵з�1%�����ٶȡ�',1,1,3} 
	CC.PTFSM[9818] ={'��Ѫ����','����ʱ���ָ�����˺�10%��Ѫ�������ι�����Ѫ����200�㣩 ',1,1,2}
	CC.PTFSM[9817] ={'��������','ÿ���ж�����20%�����Ȼ����һ�غ� ',1,1,3}
	CC.PTFSM[9816] ={'־������','����Ч���������������� ',1,1,2}
	CC.PTFSM[9815] ={'��÷��','�����ÿ��һ���书��������ɽ��÷������+50�� ',1,1,2}
	CC.PTFSM[9814] ={'��������','ʹ���嶾���ƹ��������2-5������ ',1,1,2}
	CC.PTFSM[9813] ={'�������','ʹ���κ��书���������ر������ƶ�����+3',1,1,3} 
	CC.PTFSM[9812] ={'��â����','ʹ�ý�������׷��100����ʵ�˺�����װ����������˼ӳɼ��� ',1,1,2} 
	CC.PTFSM[9811] ={'ӥ�ɾ���','ӥצ���ض����ˣ��Ṧ����100�㡣 ',1,1,3} 
	CC.PTFSM[9810] ={'��������','ÿ�ж�һ�Σ�����Ч������5%�� �������30%��',1,1,3}
	CC.PTFSM[9809] ={'һ��һ��','����10%�˺�������10%�����˺� ',1,1,2}
	CC.PTFSM[9808] ={'������˫','ս����ʼǰ50ʱ���ܵ����˺�������50�� ',1,1,4}
	CC.PTFSM[9807] ={'ʮ��̫��','��������������ɱ�����ܵ��˺�����13% ',1,1,4}
	CC.PTFSM[9806] ={'��Ԫ����','ʹ�ý�ϵ�书����ʱ���з���������75%�� ',2,1,4}
	CC.PTFSM[9805] ={'����Բ��','ʱ��ظ���Ѫ/����/������������ظ�����/����/��Ѫ1��/ʱ��" ',1,1,4} 
	CC.PTFSM[9804] ={'���ž���','��Ч��������+8�㡣������������������300�� ',1,1,3}
	CC.PTFSM[9803] ={'���Ʊ���','������ʱ�ط���"���Ʊ���"�����߹���10ʱ����ȴʱ��50ʱ�� ',2,1,4}
	CC.PTFSM[9802] ={'��Ȩ����','�ƶ�����+3������������ٴ��ƶ� ',1,1,3}
	CC.PTFSM[9801] ={'��ڤ��Ԩ','��������������ڤ������ʱ��������ȡ����ֵ��',2,1,4}
	CC.PTFSM[9800] ={'���ӹ���','�з�ȫ�弯������,���м���20%�� ',2,1,4}
	CC.PTFSM[9799] ={'��া���','ÿ���ж�ǰ��60%����ʹ�з�ȫ�弯��λ�õ���150��',1,1,3}
	CC.PTFSM[9798] ={'����֥��','�����ÿ���⹦����1�㼯���� ',1,1,3}
	CC.PTFSM[9797] ={'�������','��Ů�Թ����˺���120%����Ů�Թ����˺���80% ',1,1,2}
	CC.PTFSM[9796] ={'��ŭ����','�����Թ����˺���120%�������Թ����˺���80% ',1,1,2}
	CC.PTFSM[9795] ={'��Ԫ��','��Ԫ���Զ��˹�����Ԫ����Χ+1�� ',1,1,2} 
	CC.PTFSM[9794] ={'��������','��ŭ������������������������ض������׻��������������罣��������Χ�˺�ɱ������ ',1,1,4}
	CC.PTFSM[9793] ={'��������','ÿ����һ�������书�������������4%������7���� ',1,1,3}
	CC.PTFSM[9792] ={'�������','��ѪԽ������������Խ�� ',1,1,3}
	CC.PTFSM[9791] ={'�����½�','����ֵ����50%ʱ����������������ֵ����25%ʱ���������� ',1,1,3}
	CC.PTFSM[9790] ={'ǧ����','����ǿ���϶�20�㣬����Ŀ���ж�ֵ�ظ����� ',1,1,2}
	CC.PTFSM[9789] ={'��������','������ʱ�����Ĺ�����5-10������ ',1,1,2}
	CC.PTFSM[9788] ={'������ʹ','ÿ�ι�����ʹ�з��ܵ����˺����2%������40% ',1,1,2}
	CC.PTFSM[9787] ={'��������','ս�����״α����˿ɸ���һ��,�ظ�70%����ֵ������״̬���������ж�,����󣬼����ٶ�+5�� ',1,2,3}
	CC.PTFSM[9786] ={'��������','��������ɻغ�ȫ��ŭ�����������٣�����ֵ������ӡ� ',1,2,3}
	CC.PTFSM[9785] ={'��¶����','�����������ӵз�����15% ',1,1,3}
	CC.PTFSM[9784] ={'��������','�з�ÿ�غ�30%���ʸ�������״̬2�غ� ',1,1,3}
	CC.PTFSM[9783] ={'�������','�����Ȼ���ˡ� ',1,1,2}
	CC.PTFSM[9782] ={'�Ա��Ʊ�','�ܵ������˺��������´ι����ر�1�Σ��ܵ������˺����´ι���������1�Ρ� ',1,1,2}
	CC.PTFSM[9781] ={'���ۻ���','����ֵ����10%ʱ��ÿ�ι�����������5%���������ܵ�������Ŀ��Ҳ�����������ֵ5%���˺��� ',1,1,2}
	CC.PTFSM[9780] ={'��������','������ʱ���ʰ��������ʵ�һ�뽵���˺��� ',1,1,2}
	CC.PTFSM[9779] ={'��������','����ʱ���ʰ����������ʵ�һ������˺��� ',1,1,2}
	CC.PTFSM[9778] ={'���칫��','�Դ������������ ',2,1,4}
	CC.PTFSM[9777] ={'���������','���ֿ���ѡ��1���츳��ս�������ظ���Ѫ��� ',2,1,4}
	CC.PTFSM[9776] ={'ѩ������','����9999���������������书��������ˮ������ ',2,1}
	CC.PTFSM[9775] ={'��������','1�������һ�������������ˣ����������գ����մ���80���ȼ5ʱ��5������ڶ���������ʶ��;����ŭ���������������������˺�������9�����������������֪�鴦����������ʱ�����ӵз�����50% ',2,1,3}
	CC.PTFSM[9774] ={'һͨ��','ÿ���书��������Χ����ϵ+10 ',2,1,3}
	CC.PTFSM[9773] ={'��ƽ����','���аٱ�����/���˼�����ߡ�ʹ�ý��߽���ʱ������ֵ����30%ʱ���ɴ������߰��� ',1,1,3}
	CC.PTFSM[9772] ={'��ϵһ��','���ҵ�����������10��ˣ�����ɣ����Ӻ��ҵ�������40%�� ',1,1,3}
	CC.PTFSM[9771] ={'����ͯ��','�����޼����Զ��˹�����Զ�������ڡ� ',1,1,3}
	CC.PTFSM[9770] ={'ͨ΢�Ի�','�����������޸����μ���30%������ʱ���ʷ�������Ȼ���»غϼ���+500���ƶ���������Ϊ8�񣬹���ʱ���ʴ�������Ϊ�棬׷���书������������ ',1,1,4}	
	CC.PTFSM[9769] = {'��תǬ��','Ǭ����Ų�Ʒ���Ч�� ǿ��������40%�˺��������˹����� ',1,1,2}
	CC.PTFSM[9768] = {'ʨ������','����ʱ��������2000��������10��������ʹȫ�����˽���־�״̬20ʱ�� ',2,1,4}-- ��1�츳���ƣ���2�츳˵������3ΪΪ1��ר��2Ϊר������4Ϊ1�Ƿ����츳Ϊ2�������츳����5Ϊ�츳�ȼ�(1��2��3��4��)
	CC.PTFSM[9767] = {'������','������ʱ������ս��������μ���������˺��� ',2,1,4}
	CC.PTFSM[9766] = {'Ⱥ������','��������15����������300ʱ����ʱ���ʶ���Χ���Χ�ڵĶ��ѽ������ƣ�ʱ������˲���������Ѫ������20ʱ�� ',2,1,3}
	CC.PTFSM[9765] = {'Ⱥ���϶�','��������15����������300ʱ����ʱ���ʶ���Χ���Χ�ڵĵĵ������ʱ���ж�������50ʱ�� ',2,1,3}
	CC.PTFSM[9764] = {'ħ�ۡ�����','�����BOSS������ÿ3ʱ��ָ�1�����ˣ�����ԽԶ���ܵ����˺���ɱ��Խ�ͣ���ԭ�����˺�˥�����ӣ����з����������Խ���������ٶ�Խ�ͣ���Զ����10�񣬳���10������Ӱ�죩�������뱻����ʱ�ض��������Ǵ󷨣����Ǵ�Ч���̶�����200�����з���������ʱ���������ʧ����һ���������ʧ������������ʱ�����յ�������һ�������������壬����Ϊ�����������30%�� ',2,1,4}
	CC.PTFSM[9763] = {'��������','�����ٶ�����6�㣬50����׷��һ������(��ŭ��׷��)������ʱ�˺������������� ',2,1,3}
	CC.PTFSM[9762] = {'�����ط�','������Ϊ�츳�ڹ�ʱ�Զ��˹��ұش�Ŀ����.�������θ���30%��������Ѩ��׷��1000�������ұض���ɷ�Ѩ�� ',2,1,4}
	CC.PTFSM[9761] = {'��������','�������չ�ʱӵ�о���������һ�������˳�����ͬ����Ч��.���չ�/���������������˹���Ч��ǿ�����ظ��ٷֱ�Ϊ100%�����������ж���ʹ���书����ֻ��Ҫ60��ŭ�����Ṧ+20�� ',2,1,4}
	CC.PTFSM[9760] = {'�������','��������9999���������/����/���м��ʱض����������ж��� ',2,1,4}
	CC.PTFSM[9759] = {'����̫��','��ʹ��̫���񹦹�����̫���񹦺��ڽ���50%�����츳�⹦Ч�����ӣ�����75%�������ģ���������ʱ����50%���ʴ���̫�����𣬶Թ��������10���Ѩ����30%���ʽ��ܵ����˺�ת��Ϊ�����Ѫ�� ',2,1,4}
	CC.PTFSM[9758] = {'�Ĵ����','�����˺�Ч������50%��',2,1,4}
	CC.PTFSM[9757] = {'����','�ж�ǰ50%����ʹ���Ѷ��̼���������ÿʱ����ʧ1%���Ѫ����״̬������Ѫ��Խ�ͣ��˺�/����Խ�ߡ� ',2,1,4}
	CC.PTFSM[9756] = {'����Ǭ��','��������ʱ������ʹ���˺��Լ�ͬʱ��ö�Ǭ��DEBUFF��ֹͣ�ж�������һ���˺��� ',2,1,4} 
	CC.PTFSM[9755] = {'��Ӣ��ŭ','����ʱ�ض���ɱ������к�����Ч�������ٶ�+8�� ',2,1,3}
	CC.PTFSM[9754] = {'�����½�','����ֵ����50%ʱ����������������ֵ����25%ʱ������������������ֵ50%ʱ������ֵÿ�ٽ���1%���»غϼ���λ��+10�㡣 ',1,1,3}
	CC.PTFSM[9753] = {'���Ǿۻ�','������֮һ��ÿ���ж���Ϊ�����������Ӽ���λ��200�㡣',2,1,3} 
	CC.PTFSM[9752] = {'��ɳ��Ӱ','����������Χ������7��7����',2,1,2} 
    CC.PTFSM[9751] = {'�����߹�','�����߹�ÿ�ڳ�һ�ˣ��ҷ�����+50������+50���Ṧ+50���ұ˴˷�̯�˺���',2,1,3} 
    CC.PTFSM[9750] = {'�������','����ȭһ�����˷��ɼ���һ�롣',2,1,2} 
    CC.PTFSM[9749] = {'��ʮ������','����ʱ�򱻹���ʱ���ʴ�������100ʱ��һ���ࡱBUFF,����15%,��һ���ࡱ�����ڼ䣬�Żᷢ���������ࣺ*�������ࡿ������ʱ����׷��һ����������ŭ������*���׺��ࡿ ������ɱ����*��ȸĸ�ࡿ�����������ʼ���50�㡣���������ࡿ������������+200������',2,1,4} 
    CC.PTFSM[9748] = {'�Ʋ��','����ʱ��������������.�Ʋ�񷡱���ӵз�����50%��',1,1,4} 
    CC.PTFSM[9747] = {'������','�����������������塱�����˺�30%��',1,1,4} 
    CC.PTFSM[9746] = {'����ͨ��','�����������С�',1,1,4} 
    CC.PTFSM[9745] = {'ب�����','�����ط���������з�������գ�С����ֱ�ӵ�ȼ��ÿ������ֵ���ٵз�����1%��������Ѫ���з�����Խ�࣬������Χ����ϵԽ�ߡ�',1,1,3}
    CC.PTFSM[9744] = {'��Ϧ��϶','30%���ʴ�������Ϧ��϶������Ŀ�꣬ʹĿ������ƶ���',1,1,3}   
    CC.PTFSM[9743] = {'���յ�Ѩ','��ɷ�Ѩʱ����Ѩ����10�㣬������ʱ��Ŀ�����10���Ѩ��',1,1,3}
    CC.PTFSM[9742] = {'���°˷�','ÿ��������������һ�У�ÿһ�мӱ����˺�/��������/������(����8��)��',1,1,4}
    CC.PTFSM[9741] = {'����Ź�','������λ�ø���ǰ��30����ŭʱ3��������λ�ò������0��',1,1,3} 
    CC.PTFSM[9740] = {'ǧ�����','�������Ӽ����ٶȣ���������80,�������ܻ����쳣״̬Ӱ�졣',1,1,4}
    CC.PTFSM[9739] = {'ѩ����','ѩɽ������������,����ʱ���ʴ�����ѩ���񽣡�������ɱ������ŭ�ش�����',2,1,4}
    CC.PTFSM[9738] = {'��إ��','�Դ�1-14ʽʥ�齣����ʹ�ý���ʱ�����������������15-22ʽ�����������򣬻��9���������ŭʱʹ�ý���������إ����Χ����������ʹĿ�����1�غϡ�',2,1,3}
    CC.PTFSM[9737] = {'��շ�ħ','����˺��Ļظ����ѻ��Լ�����������׷��200���˺���',1,1,4}
    CC.PTFSM[9736] = {'���Ƕ�ı','�ڳ�ʱ���ҷ�ȫ�������¹⻷����������״̬ʱ����������20%���ˣ������ض��ɹ��������ڷ���״̬ʱ����20%�������ܡ�',1,1,3}
    CC.PTFSM[9735] = {'����˫��','ˣ�����ɵ�50%�ӳɵ���������������������50%�ӳɵ�ˣ�����ɣ������뽣���书����+200��',1,1,3}
    CC.PTFSM[9734] = {'˭������','װ�������콣��ʱ��ȫ����������+200��ʹ�þ����׹�צ������ʱ���ӵз�50%������',1,1,4}  
    CC.PTFSM[9733] = {'��������','����30%�˺�����˫�����������˺�ֵ��',1,1,3} 
    CC.PTFSM[9732] = {'����ɢ��','��ȭ�ƹ���ʱ���ش���������ɢ�֡����Է���ɷ�Ѩ��',1,1,3} 
    CC.PTFSM[9731] = {'г֮��','����������������ŭʱ������������,���ез������߻�����ɵз�5ʱ������ͣ��',2,1,4} 
    CC.PTFSM[9730] = {'������','��ʫ�ƻ��С�����������+200��*��ʮ��ɱһ�ˡ������˵��˷������ٴ��ж���*���������������������30ʱ����50%�������ܹ�����',2,1,4} 
    CC.PTFSM[9729] = {'������צ','������צ�����������40%������������ŭ��������',2,1,3} 
    CC.PTFSM[9728] = {'��������','�������޵�����ÿ�ι�������1~2�㡰���硱ÿ��+2.5%���������10�㣬������Ŀ�깥���˺�����10%��',2,1,3} 
    CC.PTFSM[9727] = {'�����׺�','��ŭʱ���������������״̬��ս�����״α����˿ɸ���һ�Σ������ж���',2,1,4} 
    CC.PTFSM[9726] = {'Į������','�������Է������˺�����Ů�Թ���ʱ׷��666���˺���',2,1,3} 
    CC.PTFSM[9725] = {'��������','���������˺���������Χ+1������ʱ���������˺���Ŀ�����ԽԶ���˺�Խ�ߡ�',2,1,4} 
	CC.PTFSM[9724] = {'��������','����������ר��������֮����ս�������޿��Ի�ò���֮���е�һ�֡�',2,1,4}  --���� ��ľ�� ������ ������ ص���� ���º� β�� ��ˮ��
	--CC.PTFSM[9724] = {'��ڤ����','��������800��',1,1,2} 



	--����ƺ�--
    -- ��1�츳���ƣ���2�츳˵������3ΪΪ1��ר��2Ϊר������4Ϊ1�Ƿ����츳Ϊ2�������츳����5Ϊ�츳�ȼ�(1��2��3��4��)

    CC.PTFSM[757] = {'����','����������Ϊ���ĵľŹ����ڵĵ��˹�����',1,1,4} 	 --����
    CC.PTFSM[756] = {'�쵶','�쵶���ʱ����ر���',1,1,4} 	 --��ȱ
    CC.PTFSM[755] = {'���һ��','����������Ϊ���ĵľŹ����ڵĵ��˹�����',1,1,4} 	 --����
    CC.PTFSM[754] = {'���һ��','����������Ϊ���ĵľŹ����ڵĵ��˹�����',1,1,4} 	 --������
    CC.PTFSM[753] = {'���ڸ���','������ѧ������+20%��������+20%��',1,1,2} 	 --ʤ��
    CC.PTFSM[752] = {'����֮־','�����ܺ������������ս���ﱻ���ܣ���һ�λ�������ٴλص�ս����',1,1,4} 	 --��ϧ��
    CC.PTFSM[751] = {'�������','�������ѧ������+30��������+30%������+300��',1,1,3} 	 --����
    CC.PTFSM[750] = {'ҩʦ����','�ж�����ѷ�������Ѫ�ٷֱ��ٵ�Ŀ��ظ�20%����ֵ��',1,1,3} 	 --����˪
    CC.PTFSM[749] = {'�������','�������ѧ������+40��������+40%������+400��',1,1,3} 	 --������
    CC.PTFSM[748] = {'��ɽһ��','�����������ö��ѳе�75%�˺���',1,1,2} 	 --������
    CC.PTFSM[747] = {'��������','�����������Ŀ��������',2,1,2} 	 --����Ӣ
    CC.PTFSM[746] = {'��������','�����������Ŀ��������',2,1,2} 	 --����Ӣ
    CC.PTFSM[745] = {'��������','�����������Ŀ��������',2,1,2} 	 --����Ӣ
    CC.PTFSM[744] = {'����ȭ','ȭ���������ʼ���Ŀ������ֵ��',2,1,1} 	 --�׼�
    CC.PTFSM[743] = {'���ɽ�','���ɽ�����+400��',2,1,1} 	 --����
    CC.PTFSM[742] = {'Τ���ɸ���','Τ��������+400��',2,1,1} 	 --������
    CC.PTFSM[741] = {'���Ը���','�������书������+20%��������+20%��',2,1,2} 	 --����Ӣ
    CC.PTFSM[740] = {'���Ը���','�������书������+20%��������+20%��',2,1,2} 	 --������
    CC.PTFSM[739] = {'���Ը���','�������书������+10%��������+10%��',2,1,2} 	 --�̱���
    CC.PTFSM[738] = {'��ʯ֮��','�����Լ���ȫ���������Ȼ��Ѿ������ܵĶ��ѡ�',2,1,3} 	 --������
    CC.PTFSM[737] = {'���Ը���','�������书������+20%��������+20%�����Ե���ɵз���������״̬20ʱ��',2,1,2} 	 --�̷���
    CC.PTFSM[736] = {'���Ӫ','�����ٶ�-30%����������30%��',2,1,2} 	 --��ǹ��
    CC.PTFSM[735] = {'���Ӫ','�����ٶ�-30%����������30%��',2,1,2} 	 --��ǹ��
    CC.PTFSM[734] = {'���Ӫ','�����ٶ�-30%����������30%��',2,1,2} 	 --��ǹ��
    CC.PTFSM[733] = {'���Ӫ','�����ٶ�-30%����������30%��',2,1,2} 	 --��ǹ��
    CC.PTFSM[732] = {'���־�','�ѷ�����Խ�࣬�������ͷ�����Խ�ߡ�',2,1,2} 	 --���ж�
    CC.PTFSM[731] = {'������','������100-���£�����1.2���˺�',1,1,2}	 --����
    CC.PTFSM[730] = {'�����ŵ���','������������+300��',2,1,2}	 --�����ŵ���
    CC.PTFSM[729] = {'�����ŵ���','������������+300��',2,1,2}	 --�����ŵ���  
    CC.PTFSM[728] = {'�����ŵ���','������������+300��',2,1,2}	 --�����ŵ���
    CC.PTFSM[727] = {'�����ŵ���','������������+300��',2,1,2}	 --�����ŵ���
    CC.PTFSM[726] = {'�䵱����','�䵱��ѧ������+10%��������+10%��',2,1,2}	 --��һ����
    CC.PTFSM[725] = {'������','����+50��',2,1,1}	 --�ŷ���
    CC.PTFSM[724] = {'������','��������+300��',2,1,1}	 --������
    CC.PTFSM[723] = {'ؤ�ﳤ��','ؤ����ѧ������+20%��������+20%��',2,1,2}	 --������
    CC.PTFSM[722] = {'���Ը���','�������书������+20%��������+20%����������ɵз���ɢ����״̬20ʱ��',2,1,3}	 --�̽���
    CC.PTFSM[721] = {'����','��ʼ����200�������ض�1���˺����Ⱦ�buff�����⹥����Ч����Ϣʱ�ض�����������*����Ե�������õ���а���ף���һ��ϴ��а����һ������ϴ����xЦ����а��ܶ������� �ڶ���ϴ��������һ������ϴ����x��װ���廨�루������ܳͷ���',2,1,3}	 --����
    CC.PTFSM[720] = {'����','',2,1,3}	 --����
    CC.PTFSM[719] = {'����','',2,1,3}	 --����
    CC.PTFSM[718] = {'����','',2,1,3}	 --����
    CC.PTFSM[717] = {'����','',2,1,3}	 --����
    CC.PTFSM[716] = {'����','',2,1,3}	 --����
    CC.PTFSM[715] = {'����','',2,1,3}	 --����
    CC.PTFSM[714] = {'����','',2,1,3}	 --����
    CC.PTFSM[713] = {'����','',2,1,3}	 --����
    CC.PTFSM[712] = {'����','',2,1,3}	 --����
    CC.PTFSM[711] = {'����','',2,1,3}	 --����
    CC.PTFSM[710] = {'����','',2,1,3}	 --����
    CC.PTFSM[709] = {'����','',2,1,3}	 --����
    CC.PTFSM[708] = {'����','',2,1,3}	 --����
    CC.PTFSM[707] = {'����','',2,1,3}	 --����
    CC.PTFSM[706] = {'����','',2,1,3}	 --����
    CC.PTFSM[705] = {'����','',2,1,3}	 --����
    CC.PTFSM[704] = {'����','',2,1,3}	 --����
    CC.PTFSM[703] = {'����','',2,1,3}	 --����
    CC.PTFSM[702] = {'����','',2,1,3}	 --����
    CC.PTFSM[701] = {'����','',2,1,3}	 --����
    CC.PTFSM[700] = {'����','',2,1,3}	 --����
    CC.PTFSM[699] = {'����','',2,1,3}	 --����
    CC.PTFSM[698] = {'����','',2,1,3}	 --����
    CC.PTFSM[697] = {'����','',2,1,3}	 --����
    CC.PTFSM[696] = {'����','',2,1,3}	 --����
    CC.PTFSM[695] = {'����','',2,1,3}	 --����
    CC.PTFSM[694] = {'����','',2,1,3}	 --����
    CC.PTFSM[693] = {'����','',2,1,3}	 --����
    CC.PTFSM[692] = {'����','',2,1,3}	 --����
    CC.PTFSM[691] = {'����','',2,1,3}	 --����
    CC.PTFSM[690] = {'����','',2,1,3}	 --����
    CC.PTFSM[689] = {'����','',2,1,3}	 --����
    CC.PTFSM[688] = {'����','',2,1,3}	 --����
    CC.PTFSM[687] = {'����','',2,1,3}	 --����
    CC.PTFSM[686] = {'����','',2,1,3}	 --����
    CC.PTFSM[685] = {'����','',2,1,3}	 --����
    CC.PTFSM[684] = {'����','',2,1,3}	 --����
    CC.PTFSM[683] = {'����','',2,1,3}	 --����
    CC.PTFSM[682] = {'����','',2,1,3}	 --����
    CC.PTFSM[681] = {'����','',2,1,3}	 --����
    CC.PTFSM[680] = {'����','',2,1,3}	 --����
    CC.PTFSM[679] = {'����','',2,1,3}	 --����
    CC.PTFSM[678] = {'����','',2,1,3}	 --����
    CC.PTFSM[677] = {'����','',2,1,3}	 --����
    CC.PTFSM[676] = {'����','',2,1,3}	 --����
    CC.PTFSM[675] = {'����','',2,1,3}	 --����
    CC.PTFSM[674] = {'����','',2,1,3}	 --����
    CC.PTFSM[673] = {'����','',2,1,3}	 --����
    CC.PTFSM[672] = {'����','',2,1,3}	 --����
    CC.PTFSM[671] = {'����','',2,1,3}	 --����
    CC.PTFSM[670] = {'����','',2,1,3}	 --����
    CC.PTFSM[669] = {'����','',2,1,3}	 --����
    CC.PTFSM[668] = {'����','',2,1,3}	 --����
    CC.PTFSM[667] = {'����','',2,1,3}	 --����
    CC.PTFSM[666] = {'����','',2,1,3}	 --����
    CC.PTFSM[665] = {'����','',2,1,3}	 --����
    CC.PTFSM[664] = {'����','',2,1,3}	 --����
    CC.PTFSM[663] = {'����','',2,1,3}	 --����
    CC.PTFSM[662] = {'����','',2,1,3}	 --����
    CC.PTFSM[661] = {'��������','�ƶ��̶�ʮ�񣬷�������100��',2,1,3}	 --��������
    CC.PTFSM[660] = {'��������','�ƶ��̶�ʮ�񣬷�������100��',2,1,3}	 --��������
    CC.PTFSM[659] = {'��������','�ƶ��̶�ʮ�񣬷�������100��',2,1,3}	 --��������
    CC.PTFSM[658] = {'��ع���','������ʱ����ת��ɱ��ֵ�������ߣ��ٻ���ȭ����+600��',2,1,3}	 --Ԭʿ��
    CC.PTFSM[657] = {'���ֳ���','������ѧ������+40%��������+40%��������ѧ����+400��',2,2,3}	 --��� -- ���������츳6
    CC.PTFSM[656] = {'���ָ�ɮ','������ѧ������+30%��������+30%��',2,1,2}	 --Ԫ��
    CC.PTFSM[655] = {'��������','������ѧ������+30%��������+30%��',2,2,2}	 --Ԫ�� -- ���������츳4
    CC.PTFSM[654] = {'��������','�ƶ��̶�ʮ�񣬷�������100��',2,1,3}	 --��������
    CC.PTFSM[653] = {'���ָ�ɮ','������ѧ������+20%��������+20%��',2,1,2}	 --Ԫʹ
    CC.PTFSM[652] = {'���ݴ���','������а�������������û�гͷ����Դ�����������Ч��*������.����һ����սʤ�����������ң���ŭʱ��ʹ�á��콣��������ʹ�ý������ӵз�����30%���������ܣ�׷��200���˺���',2,1,4}	 --����ˮ
    CC.PTFSM[651] = {'���˫��','���������ʱ�з��κι���ϵ������Ϊ0������ʱ����Ŀ��50%��������δʵװ��',2,1,4}	 --����
    CC.PTFSM[650] = {'С��ү','�书�������������ܵ���5%ɱ��������25%����',2,1,2}	 --�
    CC.PTFSM[649] = {'��ɽ��Ů','��ϼ�񹦱ط�����ϼ���������������ش�������Ůʮ�Ž����������������ʣ���ŭ������*����Ե������������������ڶ���ϴ����������',2,1,2}	 --������
    CC.PTFSM[648] = {'��ڤ����','ʹ����ڤ���ƣ��ض��������⡣',2,1,2}	 --�ױ���
    CC.PTFSM[647] = {'��ڤ����','ʹ����ڤ���ƣ��ض��������⡣',2,1,2}	 --�ױ���
    CC.PTFSM[646] = {'ǧ����','����ǿ���϶�20�㣬����Ŀ���ж�ֵ�ظ�������',2,1,2}	 --����
    CC.PTFSM[645] = {'���ڸ���','�����书������+20%��������+20%��',2,1,2}	 --����
    CC.PTFSM[644] = {'���ڸ���','�����书������+20%��������+20%��',2,1,2}	 --����
    CC.PTFSM[643] = {'�˱���','ʹ�ý������������������30%��',2,1,3}	 --����
    CC.PTFSM[642] = {'�Ǻ����','�ѷ����Լ��⻹����Ա�������˺���',2,1,4}	 --�Ĵ�ɽ
    CC.PTFSM[641] = {'ħ����ʦ','�����书������+40%��������+40%���书����+400��',2,1,4}	 --Ħ��
    CC.PTFSM[640] = {'��Ĺ����','��Ů�ľ���Ч�������ӣ��������˾����񹦿ɴ��������׹�צ���⣬��ɽ���Ѿ����׹�צ����+50%,7�������צ����40%��������ŭ��������*���㺮��ԡ���ɽ��ɽ���Ѻ�ŭ�������㺮��ԡ��ض���Ŀ�꼯��5ʱ��',2,1,4}	 --����Ů  
    CC.PTFSM[639] = {'�����ɾ�','���߽�������1.5��������׶3~5���˺�����ŭʹ�ý��߽����س����߰��塣',2,1,4}	 --��ѩ��
    CC.PTFSM[638] = {'��������','��������9999�������񹦱ؼ������壬��ʹ�þ����񹦹���������40%�˺���',2,1,4}	 --����ɮ
    CC.PTFSM[637] = {'��������','�������Զ��˹���*���׽�͹ǡ������߷�Ѩ�����߱����˺�������֮����������ʱ��������֮��������Ŀ���������ֵ5%���˺����������ء�(����ר��)���������������书�������书���Ե�����',2,1,4}	 --����
    CC.PTFSM[636] = {'��������','��������������*������֮�塿������ʱ����ֵһ�������ڶԷ�������������ʱ������һ�������ڶԷ�����ֵ��*���������衿��ɽ��ɽ���Ѻ�������ŭ��������������Χ�˺���������ֵ�˺�����Ŀ����Ӵ���',2,1,4}	 --���
    CC.PTFSM[635] = {'������','���˾�Ϣ����ʹ�ñ̺������ƿ��Դ��������澢֮һ����������ʮ������ǿ��*����Ե����������������Ϣ����̺������ƣ���һ��ϴ�̺������ƣ��ڶ���ϴ��Ϣ����������ϴʮ����ʮ����',2,1,4}	 --����
    CC.PTFSM[634] = {'��ң��ʦ','�ط�����÷����Ū����Ч֮һ��*÷��һŪ�����ɢ��30ʱ��*÷����Ū�����ٵз���ǰ����ֵ��5%��*÷����Ū�����Ӿ���������*����Ե����������������ֱ�Ӽ����ң���硱(����ѧС����/�˻�/��ڤ)��',2,1,4}	 --��ң��
    CC.PTFSM[633] = {'�ɶ�����','�츳�Ṧ�Զ�����,�������߱���,װ�����±�������ҵ�������+300,װ�����µ������ر��⡣*����Ե��������ѩа��ɱ��/��ѩ����ʤ��ڶ���ϴ�罣1�������򵶽����������',2,1,4}	 --��һ��
    CC.PTFSM[632] = {'��������','�ܵ��˺�ʱ��25%�������ѷ����ѳе�һ���˺���',2,1,2}	 --������
    CC.PTFSM[631] = {'����ع��','*����Ե����������а�����־��飬��ѡ��ϴ��һ���书,����а�����־��飬ϴ�ڶ����书���츳�ڹ�ϴΪ�����񹦡�',2,1,3}	 --������
    CC.PTFSM[630] = {'������','��',2,1,2}	 --������
    CC.PTFSM[629] = {'��ƽ����','��ɽ���������Ӿ������򣺡���������������ŭ������Χ�˺�������������������ʴ���ɱ����999���˺���99����ԡ�������������ʸ���һ�Ρ�*����Ե��������á����аٱ䡱������ϴ��ٱ�1����',2,1,4}	 --�싉��
    CC.PTFSM[628] = {'����','ʹ����������ʱ���м��ʷ����ؽ��洫��',2,1,2}	 --���
    CC.PTFSM[627] = {'Į������','�ҷ��Ṧ+10%������+10%��',2,1,3}	 --�ɸ�
    CC.PTFSM[626] = {'С��а','��ɫָ����磬�������л���һ���书Ϊ��ָ��ͨ/��������/��Ӣ���ƣ������Ļغϡ���ü�𶥾��Ѻ����������Ƶ���������Ϊ���',2,1,3}	 --����
    CC.PTFSM[625] = {'�������','�����������㡣',2,1,1}	 --�������
    CC.PTFSM[624] = {'�������','�����������㡣',2,1,1}	 --�������
    CC.PTFSM[623] = {'�������','�����������㡣',2,1,1}	 --�������
    CC.PTFSM[622] = {'�������','�����������㡣',2,1,1}	 --�������
    CC.PTFSM[621] = {'�������','�����������㡣',2,1,1}	 --�������
    CC.PTFSM[620] = {'�������','�����������㡣',2,1,1}	 --�������    
    CC.PTFSM[619] = {'�������','�����������㡣',2,1,1}	 --�������
    CC.PTFSM[618] = {'�������','�����������㡣',2,1,1}	 --�������
    CC.PTFSM[617] = {'��������','ʹ����˶���������ˣ�ʹ�����Ƹ���׷��һö��˶���',2,1,3}	 --��ǧ�� 
    CC.PTFSM[616] = {'�������','����ÿ����һ�����ѣ������ٶ�����2�㡣�ܵ��ķ�Ѩ����50%��',2,1,3}	 --����ֹ 
    CC.PTFSM[615] = {'��ϲԩ��','��������ͬʱ�ڳ�������������50��',2,1,1}	 --�η��� 
    CC.PTFSM[614] = {'��ϲԩ��','�η����ڳ��������������100��',2,1,1}	 --������ 
    CC.PTFSM[613] = {'�������','����������������������ʮ�˱�����������ʹ����������10%����ֱ������Ŀ�꣬ʹ�ú���ʮ�˱޴������ɷ�Ѩ��',2,1,3}	 --׿���� 
    CC.PTFSM[612] = {'������˷�','����ʮ�˱�2~5��������',2,1,3}	 --��ά�� 
    CC.PTFSM[611] = {'','',2,1,3}	 --���� 
    CC.PTFSM[610] = {'��������','ֻ�б�ŭ״̬���ܹ�����ҩ��ʹ��Ч��˫����',2,1,3}	 --����¥ 
    CC.PTFSM[609] = {'��������','������ʱ������30%�ܵ��Ĺ����˺���*����Ե���������а���������飬ϴ�ڶ����书���츳�ڹ�ϴΪ��ħ����',2,1,3}	 --���� 
    CC.PTFSM[608] = {'��������','��������������1.5���������ط���������Ŀ���ܵ���ͨ���������ض���������������/���������/������������������װ���廨�롣',2,1,4}	 --�������� 
    CC.PTFSM[607] = {'������Ƽ','�ҷ�ȫ�����������10%��',2,1,3}	 --����� 
    CC.PTFSM[606] = {'����ս��','ӵ��ר������ë¿,��Ϣʱ�Դ����������Ч����',2,1,3}	 --������ 
    CC.PTFSM[605] = {'��������','������ʱ�ط���\"���Ʊ���\"�����߹���10ʱ����ȴʱ��50ʱ�򣬹���ʱ���ʷ���\"�����ѩ\"�����ι����ض���ɱ��⡣',2,1,4}	 --�ֳ�Ӣ 
    CC.PTFSM[604] = {'ԽŮ����','ʹ��ԽŮ�������������ˣ�ÿ���ж�ǰ������������쳣���Դ���������Ϣ�����壬������������ϵ����5��������ս����������������ϵ���㹥��ֵ��',2,1,4}	 --����   
    CC.PTFSM[603] = {'��ͼ³','���˽�ղ����壬�ض�����\"��ղ���\"��Ч��',2,1,3}	 --����      
    CC.PTFSM[602] = {'��������','ʹ�û������������з���������',2,1,2}	 --����  
    CC.PTFSM[601] = {'�鸣����','��ɫָ��ڲţ�ʹһ���з������˯״̬����״̬�޷��������������н�����ܵ�������������*����Ե������¹�����������Ҿ��飬ϴ��һ�������书����װ����ǹ��',2,1,3}	 --ΤС��  
    CC.PTFSM[600] = {'����ˮ����','����ˮ���ࡣ',2,1,3}	 --����ˮ����  
    CC.PTFSM[599] = {'������ɮ','������ѧ������+40%��������+40%��',2,1,3}	 --����  
    CC.PTFSM[598] = {'������ɮ','������ѧ������+40%��������+40%��',2,1,3}	 --�ɽ�  
    CC.PTFSM[597] = {'���ֻ���','������ѧ������+40%��������+40%��',2,1,3}	 --�ɶ�  -- ���������츳5
    CC.PTFSM[596] = {'����ˮ��','���˺�ʱ��һ�뻯Ϊ����������������������',2,1,2}	 --л����  
    CC.PTFSM[595] = {'Ѫ������','Ѫ�����书������+20%��������+20%��',2,1,2}	 --����  
    CC.PTFSM[594] = {'�����Ὥ','���������ʴ�������,��������ǽ.������������ս���п��Ը���һ�Ρ�',2,1,3}	 --�ݳ���  
    CC.PTFSM[593] = {'�������','��ɫָ�����,���������Թ�,ÿ�ο�����������20������1000��',2,1,2}	 --����  
    CC.PTFSM[592] = {'�ϵ��Ȼ�','���ַ������У�����ս���ĳ�ʼ����λ��Ϊ1000�������ƶ���������Ϊ10�����߰�������ħ��BOSS״̬��ÿ�ι�������������һ�㣬���ʮ�㣬���������潣�ƶ��仯��ÿ�㽣������5%�˺���10%���ˣ�BOSS״̬�޼������ޣ�������ʱ�޷���������ͬһ���͵��书�޷��ظ�����˺���������ʱ�谴��ָ��ȭ������ָ�����ƽ������Ƶ���ȭ�����˳�򹥻������к���ɵ��˺�����20%�����ƽ���һ�㣬��֮����һ�㽣�ƣ�����ʮ��ʱ��������ָ�2000������50�ж���',2,1,4}	 --�������
    CC.PTFSM[591] = {'��״Ԫ','��������ʷ�����еĳ�����',2,1,2}	 --��״Ԫ
    CC.PTFSM[590] = {'������Ů','װ������ʱ�ļ����ӳ�Ч��������ÿ����һ�������书�����������ٶ�+2������7������',2,1,2}	 --������
    CC.PTFSM[589] = {'�彣��Ů','ʹ�����ǽ�����������',2,1,2}	 --ˮƁ
    CC.PTFSM[588] = {'��������','�һ�����ѧ����+200,��Ч��������+10��*����Ե�������һ������׺󣬵�2��ϴ������1��������ϴ�����񹦣��������ţ�Ҵ�3��ϴ��ָ��ͨ������ϴ��ָ��ͨ�����а������ɽ��3��ϴ�����׹�צ������ϴ�����׹�צ��',2,1,4}	 --��޿
    CC.PTFSM[587] = {'��ɫ���','*����Ե�������������߹�����ʤ�����һ���ç�޷�������ϴ��ç�޷�,����а��ʤ���ɵ�һ��ϴ��շ�ħȦ,����ϴ��շ�ħȦ,��ѩ�õ���������,������ϴ��������1��,����ϴ�������С�',2,1,2}	 --Ԭ����
    CC.PTFSM[586] = {'������ʥ','����������ʱΪ��ȫ�����1~4������BUFF,���30�㣬���ƣ�����Ŀ�긽����������x10���˺������񳯷ÿ����һ�θ��������1~3�����磬����BUFF>20��,����20���������ȫ����ɸ�����������x10���˺���*����Ե��������þ����񹦣�����ϴ�����񹦣�������ǽ�������1��ϴ���ǽ�����������ǵ�������2��ϴ���ǵ�����',2,1,4}	 --����
    CC.PTFSM[585] = {'��ü����','��ü���书������+20%��������+20%��',2,1,2}	 --����
    CC.PTFSM[584] = {'��������','�����ƣ���������������������ʽ,ʹ��ȭ��ʱ������ʽ����ʽ�������˺����Ʒ������36%������ʽ����,��ʮ����ʮ��ʽ���Ӿ��������������Ʒ���',2,1,3}	 --������   
    CC.PTFSM[583] = {'С���','�������˺�-15%�������˺�-10%,*����Ե����������򻨽��� 1��ϴ�򻨽���1����',2,1,3}	 --����
    CC.PTFSM[582] = {'������Ů','�з�ȫ�弯��-5,�����ر��⣬���ⳬ��50���ʶ���Ŀ��,׷�ӱ���ֵ����ʵ�˺����������߱��⡣',2,1,3}	 --����
    CC.PTFSM[581] = {'��������','�з�ȫ�弯��-5�����������ջ��ܶ����������ģ����ڵ�����������300��ֻѧ���ڵ����ɴ����ٻ���ԭ��',2,1,3}	 --����
    CC.PTFSM[580] = {'������','�����������Ѫ,������+30����Ӣ�Ӿ��Ѻ������ж���*����Ե�����������Ȱ����ţ�κ����� �Ṧ+50�������Ů���� ��2��ϴ��Ů����1���������Ů�ľ� ��3��ϴ��Ů�ľ�1��������ϴ��Ů�ľ���������޵��� ��5��ϴ���޵���1��������ϴ���޵�����',2,1,3}	 --½��˫
    CC.PTFSM[579] = {'����֮��','��͵ȡĿ��������Ʒ�����ӵз��������x5�ļ����ٶ�,�ж�����ٴ��ƶ���',2,1,4}	 --˾��ժ��
    CC.PTFSM[578] = {'����˫��','���ڹ��������ˣ����ʵ�ȼ,������������������',2,1,4}	 --����
    CC.PTFSM[577] = {'�����','ӵ�о�������,ÿ��غϹ���ʱ��������ڸ���Ŀ�굱ǰ����ֵ10%���˺�������������20%��',2,1,4}	 --��Ħ
    CC.PTFSM[576] = {'ʮ������ɮ','��������ѧ������������',2,1,4}	 --����
    CC.PTFSM[575] = {'�ɽ���Գ','�ȴ�ʱ�Զ��������޷���������������Ч������ʹ�ý�ϵ�书����ʱ��������Գ����������+500��',2,1,4}	 --��Գ
    CC.PTFSM[574] = {'��¶����','��ɫָ�����,�������л���һ���书Ϊ�����Ѩ/�׺�������*����Ե���������չ���ð˻����Ϲ�������ϴС���๦������ϴС���๦,���չ���ð˻����Ϲ����ĸ�ϴ�˻����Ϲ�������ѡ�������Ƿ�ϴ�˻����Ϲ���',2,1,3}   --����
    CC.PTFSM[573] = {'���ָ�ɮ','�����书������+20%��������+20%��',2,1,2}   --��Զ
    CC.PTFSM[572] = {'��Զ��ͷ','����������80�㡣',2,1,2}   --���ĳ�
    CC.PTFSM[571] = {'�ܶ���','�ҷ�ÿ���һ�ˣ�����+5%��������',2,1,3}   --����ͤ
    CC.PTFSM[570] = {'�䵱����','�䵱���书������+10%��������+10%��',2,1,3}   --½����
    CC.PTFSM[569] = {'СħŮ','�з������˺�����20%,�з����м�10%��*����Ե������������ƽ���/�޼�����ȭ����һ/����ϴ��Ӧ�书,��ô����޼���������ϴ�����ݣ�����ϴ�����ݡ�',2,1,3}   --������  
    CC.PTFSM[568] = {'���ҽ�','����ǹ��������ɢ������+300������ǹ�����������У�������������ɢ�ֹ����ر������ط�Ѩ��',2,1,4}   --����   
    CC.PTFSM[567] = {'������ʦ','��������+500��',2,1,3}   --�Ϲٽ���
    CC.PTFSM[566] = {'��������','���л��ڳ��������������100,���޵�����������300,����+300��*����Ե��������á����޵������ڶ���ϴ���޵�����',2,1,3}   --Ԭ����
    CC.PTFSM[565] = {'ʮ���½���','ÿ�ж�һ�Σ�����Ч������1%',2,1,3}   --׿����  
    CC.PTFSM[564] = {'����ռ��','',2,1,0}   --����ռ��  
    CC.PTFSM[563] = {'����ռ��','',2,1,0}   --����ռ��      
    CC.PTFSM[562] = {'����ռ��','',2,1,0}   --����ռ��  
    CC.PTFSM[561] = {'����ռ��','',2,1,0}   --����ռ��  
    CC.PTFSM[560] = {'����ռ��','',2,1,0}   --����ռ��  
    CC.PTFSM[559] = {'����ռ��','',2,1,0}   --����ռ��  
    CC.PTFSM[558] = {'����ռ��','',2,1,0}   --����ռ��  
    CC.PTFSM[557] = {'����ռ��','',2,1,0}   --����ռ��  
    CC.PTFSM[556] = {'����ռ��','',2,1,0}   --����ռ��  
    CC.PTFSM[555] = {'����ռ��','',2,1,0}   --����ռ��  
    CC.PTFSM[554] = {'����ռ��','',2,1,0}   --����ռ��     
    CC.PTFSM[553] = {'����ռ��','',2,1,0}   --����ռ��  
    CC.PTFSM[552] = {'����ռ��','',2,1,0}   --����ռ��  
    CC.PTFSM[551] = {'����ռ��','',2,1,0}   --����ռ��  
    CC.PTFSM[550] = {'����ռ��','',2,1,0}   --����ռ��  
    CC.PTFSM[549] = {'����ռ��','',2,1,0}   --����ռ��  
    CC.PTFSM[548] = {'����ռ��','',2,1,0}   --����ռ��  
    CC.PTFSM[547] = {'����ռ��','',2,1,0}   --����ռ��  
    CC.PTFSM[546] = {'����֮��','�Ṧ�ɳ��ӱ���װ�����ӵ��Ṧ�ͼ����ӳ�˫����',2,1,4}   --����  
    CC.PTFSM[545] = {'��ѩ��','�����Թ���ʱ�����������˺������߱������ӵ��˺���',2,1,3}   --������   
    CC.PTFSM[544] = {'���ָ���','������ѧ������+10%��������+10%��',2,1,2}   --����
    CC.PTFSM[543] = {'���ָ���','������ѧ������+10%��������+10%��',2,1,2}   --����
    CC.PTFSM[542] = {'���ָ���','������ѧ������+10%��������+10%��',2,1,2}   --����    
    CC.PTFSM[541] = {'���ָ���','������ѧ������+10%��������+10%��',2,1,2}   --����
    CC.PTFSM[540] = {'���ָ���','������ѧ������+10%��������+10%��',2,1,2}   --����
    CC.PTFSM[539] = {'','',2,1,2}   --����
    CC.PTFSM[538] = {'�䵱����','�䵱���书������+20%��������+20%��',2,1,2}   --��Զ��
    CC.PTFSM[537] = {'�䵱����','�䵱���书������+20%��������+20%��',2,1,2}   --������
    CC.PTFSM[536] = {'�䵱����','�䵱���书������+20%��������+20%��',2,1,2}   --��᷎r
    CC.PTFSM[535] = {'�䵱����','�䵱���书������+20%��������+20%��',2,1,2}   --��Ϫ��
    CC.PTFSM[534] = {'�䵱����','�䵱���书������+20%��������+20%��',2,1,2}   --�Ŵ�ɽ
    CC.PTFSM[533] = {'�䵱����','�䵱���书������+20%��������+20%��',2,1,2}   --����ͤ
    CC.PTFSM[532] = {'�䵱����','�䵱���书������+20%��������+20%��',2,1,2}   --Ī����   
    CC.PTFSM[531] = {'','',2,1,0}   --����ʱʢ
    CC.PTFSM[530] = {'','',2,1,0}   --��Ȫ�Ÿ�
    CC.PTFSM[529] = {'','',2,1,0}   --�Ӿ���ի
    CC.PTFSM[528] = {'','',2,1,0}   --Ƭɽ�ð�
    CC.PTFSM[527] = {'','',2,1,0}   --СҰ����
    CC.PTFSM[526] = {'','',2,1,0}   --СҰ�ƹ�
    CC.PTFSM[525] = {'��ɽ����','��ɽ���书������+10%��������+10%���ɶ���ѡ�������츳��',2,1,1}   --��ɽ����   
    CC.PTFSM[524] = {'��ң����','��ң���书������+10%��������+10%���ɶ���ѡ�������츳��',2,1,1}   --��ң����
    CC.PTFSM[523] = {'���ڵ���','�����书������+10%��������+10%���ɶ���ѡ�������츳��',2,1,1}   --��������
    CC.PTFSM[522] = {'�������','������书������+10%��������+10%���ɶ���ѡ�������츳��',2,1,1}   --�������
    CC.PTFSM[521] = {'���޵���','�������书������+10%��������+10%���ɶ���ѡ�������츳��',2,1,1}   --��������
    CC.PTFSM[520] = {'��������','�������书������+10%��������+10%���ɶ���ѡ�������츳��',2,1,1}   --��������
    CC.PTFSM[519] = {'ؤ�����','ؤ���书������+10%��������+10%���ɶ���ѡ�������츳��',2,1,1}   --ؤ������
    CC.PTFSM[518] = {'Ѫ������','Ѫ�����书������+10%��������+10%���ɶ���ѡ�������츳��',2,1,1}   --Ѫ������
    CC.PTFSM[517] = {'�䵱����','�ɶ���ѡ�������츳��',2,1,1}   --�䵱����    
    CC.PTFSM[516] = {'���ֵ���','�������书������+10%��������+10%�����ʦ������ɻ�������츳��',2,1,3}   --�������� �龵
    CC.PTFSM[515] = {'����֮��','������ʱ25%�������߹�����������ʱ25%����������Ŀ������˺�������ʱ25%�����ɵ緹����Ŀ������˺����������ɻ��˫��ʳ�',2,1,4}   --�緹��
    CC.PTFSM[514] = {'ħ��ǧ��','ս�����״α����˿ɸ���һ�Σ�������ϯ��Ӱ�̿ͣ������ж�*��һ���书��Ϊħ��ǧ�У����ӵз�50%������ϵ��*���������һ���з�������ٴ��ж���',2,1,4}   --������
    CC.PTFSM[513] = {'�ƽ��˵�','ÿ���50ʱ�򴥷�һ�Σ�����˫���˺�������50ʱ��',2,1,4}   --������
    CC.PTFSM[512] = {'','',2,1,4}   --��ħ
    CC.PTFSM[511] = {'��ʥ','�ƶ���������2�񣬹���ʱ�����ȡ�з�һ�����״̬����Ϊͨ��״̬���ת������ӵ�й�Ϣ��ȫ��Ч����',2,1,4}   --��չ��
    CC.PTFSM[510] = {'����ͨ��','30%��������������������ʱ30%���ʴ���������ͨ�ġ����С�',2,1,2}   --������
    CC.PTFSM[509] = {'���ָ���','������ѧ������+10%��������+10%��',2,1,2}   --���
    CC.PTFSM[508] = {'������','ս���п��������л�����/÷����������ݡ�',2,1,3}   --����
    CC.PTFSM[507] = {'������','ս���п��������л�����/÷����������ݡ�',2,1,3}   --÷����
    CC.PTFSM[506] = {'���˫��','���������ʱ�з��κι���ϵ������Ϊ0������ʱ����Ŀ��50%��������δʵװ��',2,1,4}   --����
    CC.PTFSM[505] = {'���˫��','�䵱���ֵ��书��������������',2,1,3}   --������
    CC.PTFSM[504] = {'�ؽ��','�����������ʲ�����������',2,1,2}   --�
    CC.PTFSM[503] = {'�䵱����','�䵱����ѧ����׷��500�㡣',2,1,3}   --��� �䵱�츳1
    CC.PTFSM[502] = {'��������','����+300��',2,1,3}   --����
    CC.PTFSM[501] = {'��孽�ħ','������Ŀ�겻������ŭ����',2,1,3}   --л����
    CC.PTFSM[500] = {'�����۷�','����л�������򡰽����۷� �巽�о������������ж�һ�Ρ�',2,1,4}   --���Ŵ�ѩ
    CC.PTFSM[499] = {'��������','ʹ�������񽣱ش������������̺᡿����������9999��',2,1,4}   --��˼ƽ   
    CC.PTFSM[498] = {'С��̽��','�����ƶ�-1�������ƶ�+2,30%��ܹ���,ս��ʤ����ð���,7��������Ϊ��Χ��������ɫָ����ɵ���100ʱ��������������3~5������ɽ���Ѻ�20%����5��~10�������������У�ÿ�ο�����������20������1000��',2,1,4}   --��Ѱ�� 
    CC.PTFSM[497] = {'�������','����ʱΪ�Լ����һ��100ʱ�򡰽�շ��ࡱ����BUFF���������ʴ����������������Ӿ�������+1000������',2,1,4}   --½��    
    CC.PTFSM[496] = {'����ͭ��','�������书������+20%��������+20%��',2,1,2}   --����ͭ��
    CC.PTFSM[495] = {'����ͭ��','�������书������+20%��������+20%��',2,1,2}   --����ͭ��
    CC.PTFSM[494] = {'����ͭ��','�������书������+20%��������+20%��',2,1,2}   --����ͭ��
    CC.PTFSM[493] = {'����ͭ��','�������书������+20%��������+20%��',2,1,2}   --����ͭ��
    CC.PTFSM[492] = {'����ͭ��','�������书������+20%��������+20%��',2,1,2}   --����ͭ��
    CC.PTFSM[491] = {'����ͭ��','�������书������+20%��������+20%��',2,1,2}   --����ͭ��
    CC.PTFSM[490] = {'����ͭ��','�������书������+20%��������+20%��',2,1,2}   --����ͭ��
    CC.PTFSM[489] = {'����ͭ��','�������书������+20%��������+20%��',2,1,2}   --����ͭ��
    CC.PTFSM[488] = {'����ͭ��','�������书������+20%��������+20%��',2,1,2}   --����ͭ��
    CC.PTFSM[487] = {'����ͭ��','�������书������+20%��������+20%��',2,1,2}   --����ͭ��
    CC.PTFSM[486] = {'����ͭ��','�������书������+20%��������+20%��',2,1,2}   --����ͭ��
    CC.PTFSM[485] = {'����ͭ��','�������书������+20%��������+20%��',2,1,2}   --����ͭ��
    CC.PTFSM[484] = {'����ͭ��','�������书������+20%��������+20%��',2,1,2}   --����ͭ��
    CC.PTFSM[483] = {'����ͭ��','�������书������+20%��������+20%��',2,1,2}   --����ͭ��
    CC.PTFSM[482] = {'����ͭ��','�������书������+20%��������+20%��',2,1,2}   --����ͭ��
    CC.PTFSM[481] = {'����ͭ��','�������书������+20%��������+20%��',2,1,2}   --����ͭ��
    CC.PTFSM[480] = {'����ͭ��','�������书������+20%��������+20%��',2,1,2}   --����ͭ��
    CC.PTFSM[479] = {'����ִ��','�������书������+20%��������+20%��',2,1,2}   --����ͭ�� ���������츳3
    CC.PTFSM[478] = {'����ľ��','�������书������+10%��������+10%��',2,1,2}   --����ľ��
    CC.PTFSM[477] = {'����ľ��','�������书������+10%��������+10%��',2,1,2}   --����ľ��
    CC.PTFSM[476] = {'����ľ��','�������书������+10%��������+10%��',2,1,2}   --����ľ��
    CC.PTFSM[475] = {'����ľ��','�������书������+10%��������+10%��',2,1,2}   --����ľ��
    CC.PTFSM[474] = {'����ľ��','�������书������+10%��������+10%��',2,1,2}   --����ľ��
    CC.PTFSM[473] = {'����ľ��','�������书������+10%��������+10%��',2,1,2}   --����ľ��
    CC.PTFSM[472] = {'����ľ��','�������书������+10%��������+10%��',2,1,2}   --����ľ��
    CC.PTFSM[471] = {'����ľ��','�������书������+10%��������+10%��',2,1,2}   --����ľ��
	CC.PTFSM[470] = {'����ľ��','�������书������+10%��������+10%��',2,1,2}   --����ľ��
    CC.PTFSM[469] = {'����ľ��','�������书������+10%��������+10%��',2,1,2}   --����ľ��
    CC.PTFSM[468] = {'����ľ��','�������书������+10%��������+10%��',2,1,2}   --����ľ��
    CC.PTFSM[467] = {'����ľ��','�������书������+10%��������+10%��',2,1,2}   --����ľ��
    CC.PTFSM[466] = {'����ľ��','�������书������+10%��������+10%��',2,1,2}   --����ľ��
    CC.PTFSM[465] = {'����ľ��','�������书������+10%��������+10%��',2,1,2}   --����ľ��
    CC.PTFSM[464] = {'����ľ��','�������书������+10%��������+10%��',2,1,2}   --����ľ��
    CC.PTFSM[463] = {'����ľ��','�������书������+10%��������+10%��',2,1,2}   --����ľ��
    CC.PTFSM[462] = {'����ľ��','�������书������+10%��������+10%��',2,1,2}   --����ľ��
    CC.PTFSM[461] = {'���־�Ӣ','�������书������+10%��������+10%��',2,2,2}   --����ľ�� ���������츳2
    CC.PTFSM[460] = {'��������','�廢���ŵ�����+100��',2,1,2}   --��������   
    CC.PTFSM[459] = {'�һ���ԭ','����ʮ���Ƹ���+200��',2,1,2}   --ʷ����
    CC.PTFSM[458] = {'�缤����','����ʮ����������+200��',2,1,2}   --���
    CC.PTFSM[457] = {'���н�','�����书����100%��',2,1,2}   --��Ī��
    CC.PTFSM[456] = {'����ʩ','�ж������Ȼ���ˡ�',2,1,2}   --������
    CC.PTFSM[455] = {'ɡ�н�','�����书����100%��',2,1,2}   --�ܻ���
    CC.PTFSM[454] = {'����������','�����书����+500',2,1,2}   --����
    CC.PTFSM[453] = {'�Ͽ쵶����','ʹ�õ�������+500',2,1,2}   --����ƽ
    CC.PTFSM[452] = {'�ױ�������','�����书����+500',2,1,2}   --��һ��
    CC.PTFSM[451] = {'����ׯ��','���︽�ӵ�����˫����',2,1,2}   --������
    CC.PTFSM[450] = {'׷������','ÿ���Ṧ����0.3�㹥������',2,1,3}   --׷��
    CC.PTFSM[449] = {'��Ѫ����','�������ܣ������С�',2,1,3}   --��Ѫ
    CC.PTFSM[448] = {'ǧ������','���������У�����ԽԶ�˺�Խ�ߡ�',2,1,3}   --����
    CC.PTFSM[447] = {'��һ�Թ�֮','������Χ��ֻ��һ��Ŀ��ʱ���˺�����%50��',2,1,3}   --����
    CC.PTFSM[446] = {'���־�','�ѷ�����Խ�࣬�������ͷ�����Խ�ߡ�',2,1,2}   --�����ٱ�
    CC.PTFSM[445] = {'���־�','�ѷ�����Խ�࣬�������ͷ�����Խ�ߡ�',2,1,2}   --�����ٱ�
    CC.PTFSM[444] = {'���־�','�ѷ�����Խ�࣬�������ͷ�����Խ�ߡ�',2,1,2}   --��ǹ�ٱ�
    CC.PTFSM[443] = {'���־�','�ѷ�����Խ�࣬�������ͷ�����Խ�ߡ�',2,1,2}   --��ǰ����
    CC.PTFSM[442] = {'���־�','�ѷ�����Խ�࣬�������ͷ�����Խ�ߡ�',2,1,2}   --��ǰ����   
    CC.PTFSM[441] = {'���־�','�ѷ�����Խ�࣬�������ͷ�����Խ�ߡ�',2,1,2}   --��ǹ�ٱ�
    CC.PTFSM[440] = {'���','��������+100�������ա�',2,1,3}   --���
    CC.PTFSM[439] = {'��ѩ��','��������+100��',2,1,1}   --��ѩ��   
    CC.PTFSM[438] = {'��ѩ��','��������+100��',2,1,1}   --��ѩ��       
    CC.PTFSM[437] = {'��ѩ��','��������+100��',2,1,1}   --��ѩ��   
    CC.PTFSM[436] = {'��ѩ��','��������+100��',2,1,1}   --��ѩ��   
    CC.PTFSM[435] = {'��ѩ��','��������+100��',2,1,1}   --��ѩ��   
    CC.PTFSM[434] = {'��ѩ��','��������+100��',2,1,1}   --��ѩ��   
    CC.PTFSM[433] = {'��ѩ��','��������+100��',2,1,1}   --��ѩ��   
    CC.PTFSM[432] = {'��ѩ��','��������+100��',2,1,1}   --��ѩ��   
    CC.PTFSM[431] = {'��ѩ��','��������+100��',2,1,1}   --��ѩ��   
    CC.PTFSM[430] = {'��ѩ��','��������+100��',2,1,1}   --��ѩ��     
    CC.PTFSM[429] = {'��ѩ��','�����ر��⡣���߱��⡣',2,1,2}   --��ѩ��  
    CC.PTFSM[428] = {'��ѩ��','�����ر��⡣���߱��⡣',2,1,2}   --��ѩ��  
    CC.PTFSM[427] = {'��ѩ��','�����ر��⡣���߱��⡣',2,1,2}   --��ѩ��     
    CC.PTFSM[426] = {'��ѩ��','�����ر��⡣���߱��⡣',2,1,2}   --��ѩ��  
    CC.PTFSM[425] = {'��ѩ��','�����ر��⡣���߱��⡣',2,1,2}   --��ѩ��  
    CC.PTFSM[424] = {'��ѩ��','�����ر��⡣���߱��⡣',2,1,2}   --��ѩ��    
    CC.PTFSM[423] = {'��ѩ��','�����ر��⡣���߱��⡣',2,1,2}   --��ѩ��  
    CC.PTFSM[422] = {'��ѩ��','�����ر��⡣���߱��⡣',2,1,2}   --��ѩ��  
    CC.PTFSM[421] = {'��ѩ��','�����ر��⡣���߱��⡣',2,1,2}   --��ѩ��  
    CC.PTFSM[420] = {'ǧ��ѩ��','�����ر��⡣���߱��⡣',2,1,3}   --ǧ��ѩ��    
    CC.PTFSM[419] = {'��ç��','��������+200��',2,1,1}   --��ç�� 
    CC.PTFSM[418] = {'����','��������+100��',2,1,1}   --���� 
    CC.PTFSM[417] = {'����','��������+100��',2,1,1}   --���� 
    CC.PTFSM[416] = {'����','��������+100��',2,1,1}   --���� 
    CC.PTFSM[415] = {'����','��������+100��',2,1,1}   --���� 
    CC.PTFSM[414] = {'����','��������+100��',2,1,1}   --����     
    CC.PTFSM[413] = {'����','��������+100��',2,1,1}   --���� 
    CC.PTFSM[412] = {'����','��������+100��',2,1,1}   --���� 
    CC.PTFSM[411] = {'����','��������+100��',2,1,1}   --���� 
    CC.PTFSM[410] = {'����','��������+100��',2,1,1}   --����   
    CC.PTFSM[409] = {'���ֵ���','������ѧ����׷��500�㡣',2,1,1}   --���ֵ���
    CC.PTFSM[408] = {'���ֵ���','������ѧ����׷��500�㡣',2,1,1}   --���ֵ���
    CC.PTFSM[407] = {'���ֵ���','������ѧ����׷��500�㡣',2,1,1}   --���ֵ���
    CC.PTFSM[406] = {'���ֵ���','������ѧ����׷��500�㡣',2,1,1}   --���ֵ���
    CC.PTFSM[405] = {'���ֵ���','������ѧ����׷��500�㡣',2,1,1}   --���ֵ���
    CC.PTFSM[404] = {'���ֵ���','������ѧ����׷��500�㡣',2,1,1}   --���ֵ���
    CC.PTFSM[403] = {'���ֵ���','������ѧ����׷��500�㡣',2,1,1}   --���ֵ���
    CC.PTFSM[402] = {'���ֵ���','������ѧ����׷��500�㡣',2,1,1}   --���ֵ���
    CC.PTFSM[401] = {'���ֵ���','������ѧ����׷��500�㡣',2,1,1}   --���ֵ���
    CC.PTFSM[400] = {'���ֵ���','������ѧ����׷��500�㡣',2,2,1}   --��� ���������츳1
    CC.PTFSM[399] = {'��������','',2,1,1}   --������ͽ
    CC.PTFSM[398] = {'��������','',2,1,1}   --������ͽ
    CC.PTFSM[397] = {'��������','',2,1,1}   --������ͽ
    CC.PTFSM[396] = {'��������','',2,1,1}   --������ͽ
    CC.PTFSM[395] = {'��������','',2,1,1}   --������ͽ
    CC.PTFSM[394] = {'��������','',2,1,1}   --������ͽ
    CC.PTFSM[393] = {'��������','',2,1,1}   --������ͽ
    CC.PTFSM[392] = {'��������','',2,1,1}   --������ͽ
    CC.PTFSM[391] = {'��������','',2,1,1}   --������ͽ
    CC.PTFSM[390] = {'��������','',2,1,1}   --������ͽ     
    CC.PTFSM[389] = {'��ɽ����','��ɽ����ѧ������+20%,������+20%��',2,1,1}   --����  
    CC.PTFSM[388] = {'��ɽ����','��ɽ����ѧ������+20%,������+20%��',2,1,1}   --����  
    CC.PTFSM[387] = {'�������','��ɽ����ѧ������+40%,������+40%����ɽ��ѧ����+500��',2,1,1}   --����ʦ̫  
    CC.PTFSM[386] = {'��ɽ����','��ɽ����ѧ������+20%,������+20%��',2,1,1}   --֣��  
    CC.PTFSM[385] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --����  
    CC.PTFSM[384] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --�ǹ�  
    CC.PTFSM[383] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --����  
    CC.PTFSM[382] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --����  
    CC.PTFSM[381] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --����  
    CC.PTFSM[380] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --�Ǻ�    
    CC.PTFSM[379] = {'�������','��ɽ����ѧ������+40%,������+40%����ɽ��ѧ����+500��',2,1,3}   --������ 
    CC.PTFSM[378] = {'��ɽ����','��ɽ����ѧ������+20%,������+20%��',2,1,2}   --³���� 
    CC.PTFSM[377] = {'��ɽ����','��ɽ����ѧ������+20%,������+20%��',2,1,2}   --��ǧ�� 
    CC.PTFSM[376] = {'��ɽ����','��ɽ����ѧ������+20%,������+20%��',2,1,2}   --����ɽ 
    CC.PTFSM[375] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --��ǧ�� 
    CC.PTFSM[374] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --Ī̫�� 
    CC.PTFSM[373] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --ĪС�� 
    CC.PTFSM[372] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --ĪС�� 
    CC.PTFSM[371] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --����� 
    CC.PTFSM[370] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --��Ϊ�� 
    CC.PTFSM[369] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --���� 
    CC.PTFSM[368] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --�͵�ŵ 
    CC.PTFSM[367] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --ʩ���� 
    CC.PTFSM[366] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --�߸��� 
    CC.PTFSM[365] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --½���� 
    CC.PTFSM[364] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --�վ� 
    CC.PTFSM[363] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --���پ� 
    CC.PTFSM[362] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --���� 
    CC.PTFSM[361] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --���� 
    CC.PTFSM[360] = {'��ɽ����','��ɽ��ѧ����׷��500�㡣',2,1,1}   --Ӣ���� 
    CC.PTFSM[359] = {'�������','�������ѧ������+40%,������+40%�������ѧ����+500��',2,1,3}   --ľ����   
    CC.PTFSM[358] = {'��ἳ���','�������ѧ������+20%,������+20%��',2,1,2}   --��ң
    CC.PTFSM[357] = {'��ἳ���','�������ѧ������+20%,������+20%��',2,1,2}   --����
    CC.PTFSM[356] = {'��ἵ���','�����ѧ����׷��500�㡣',2,1,1}   --���
    CC.PTFSM[355] = {'��ἵ���','�����ѧ����׷��500�㡣',2,1,1}   --��Զ��
    CC.PTFSM[354] = {'��ἵ���','�����ѧ����׷��500�㡣',2,1,1}   --��ƽ
    CC.PTFSM[353] = {'��ἵ���','�����ѧ����׷��500�㡣',2,1,1}   --����
    CC.PTFSM[352] = {'��ἵ���','�����ѧ����׷��500�㡣',2,1,1}   --ŷ�����
    CC.PTFSM[351] = {'��ἵ���','�����ѧ����׷��500�㡣',2,1,1}   --��»��
    CC.PTFSM[350] = {'��ἵ���','�����ѧ����׷��500�㡣',2,1,1}   --����Ƽ
    CC.PTFSM[349] = {'���ظ���','��������ѧ������+20%,������+20%��',2,1,3}   --��¹��
    CC.PTFSM[348] = {'���ظ���','��������ѧ������+20%,������+20%��',2,1,1}   --��ɽ��
    CC.PTFSM[347] = {'���ظ���','��������ѧ������+20%,������+20%��',2,1,1}   --�������
    CC.PTFSM[346] = {'���ظ���','��������ѧ������+20%,������+20%��',2,1,1}   --̷����
    CC.PTFSM[345] = {'���ظ���','��������ѧ������+20%,������+20%��',2,1,1}   --������
    CC.PTFSM[344] = {'���ظ���','��������ѧ������+20%,������+20%��',2,1,1}   --�����
    CC.PTFSM[343] = {'��������','��������ѧ����׷��500�㡣',2,1,1}   --������
    CC.PTFSM[342] = {'��������','��������ѧ����׷��500�㡣',2,1,1}   --������
    CC.PTFSM[341] = {'��������','��������ѧ����׷��500�㡣',2,1,1}   --��ϰ֮
    CC.PTFSM[340] = {'��������','��������ѧ����׷��500�㡣',2,1,1}   --ղ��
    CC.PTFSM[339] = {'��ü����','��ü����ѧ����׷��500�㡣',2,1,1}   --��ü����
    CC.PTFSM[338] = {'��ü����','��ü����ѧ����׷��500�㡣',2,1,1}   --��ü����
    CC.PTFSM[337] = {'��ü����','��ü����ѧ����׷��500�㡣',2,1,1}   --��ü����
    CC.PTFSM[336] = {'��ü����','��ü����ѧ����׷��500�㡣',2,1,1}   --��ü����
    CC.PTFSM[335] = {'��ü����','��ü����ѧ����׷��500�㡣',2,1,1}   --��ü����
    CC.PTFSM[334] = {'��ü����','��ü����ѧ����׷��500�㡣',2,1,1}   --��ü����
    CC.PTFSM[333] = {'��ü����','��ü����ѧ����׷��500�㡣',2,1,1}   --��ü����
    CC.PTFSM[332] = {'��ü����','��ü����ѧ����׷��500�㡣',2,1,1}   --��ü����
    CC.PTFSM[331] = {'��ü����','��ü����ѧ����׷��500�㡣',2,1,1}   --��ü����
    CC.PTFSM[330] = {'��ü����','��ü����ѧ����׷��500�㡣',2,1,1}   --��ü����   
    CC.PTFSM[329] = {'�䵱����','�䵱����ѧ����׷��500�㡣',2,1,1}   --�䵱����
    CC.PTFSM[328] = {'�䵱����','�䵱����ѧ����׷��500�㡣',2,1,1}   --�䵱����
    CC.PTFSM[327] = {'�䵱����','�䵱����ѧ����׷��500�㡣',2,1,1}   --�䵱����
    CC.PTFSM[326] = {'�䵱����','�䵱����ѧ����׷��500�㡣',2,1,1}   --�䵱����
    CC.PTFSM[325] = {'�䵱����','�䵱����ѧ����׷��500�㡣',2,1,1}   --�䵱����
    CC.PTFSM[324] = {'�䵱����','�䵱����ѧ����׷��500�㡣',2,1,1}   --�䵱����
    CC.PTFSM[323] = {'�䵱����','�䵱����ѧ����׷��500�㡣',2,1,1}   --�䵱����
    CC.PTFSM[322] = {'�䵱����','�䵱����ѧ����׷��500�㡣',2,1,1}   --�䵱����
    CC.PTFSM[321] = {'�䵱����','�䵱����ѧ����׷��500�㡣',2,1,1}   --�䵱����
    CC.PTFSM[320] = {'�䵱����','�䵱����ѧ����׷��500�㡣',2,1,1}   --�䵱����
    CC.PTFSM[319] = {'�ض���ħ','����ʱ����ֱ�Ӹ��з����˺��Ч����',2,1,2}   --������
    CC.PTFSM[318] = {'�ض���ħ','����ʱ����ֱ�Ӹ��з����˺��Ч����',2,1,2}   --������
    CC.PTFSM[317] = {'�ض���ħ','����ʱ����ֱ�Ӹ��з����˺��Ч����',2,1,2}   --����̨
    CC.PTFSM[316] = {'�ض���ħ','����ʱ����ֱ�Ӹ��з����˺��Ч����',2,1,2}   --������    
    CC.PTFSM[315] = {'�ض���ħ','����ʱ����ֱ�Ӹ��з����˺��Ч����',2,1,2}   --�˽��
    CC.PTFSM[314] = {'�ض���ħ','����ʱ����ֱ�Ӹ��з����˺��Ч����',2,1,2}   --��һ��
    CC.PTFSM[313] = {'��Ц����','���ķ�ħ������������+50%��������+50%��',2,1,2}   --�쾵
    CC.PTFSM[312] = {'��ɽ˫ӥ','���ֽ����ض������������˺�����15%,���ֽ�������+500',2,1,3}   --����÷
    CC.PTFSM[311] = {'��ɽ˫ӥ','���ֽ����ض������������˺�����15%,���ֽ�������+500',2,1,3}   --������
    CC.PTFSM[310] = {'��ɢ��','������ѧ�ͽ�����ѧ������+20%��������+20%��',2,1,2}   --˵����
    CC.PTFSM[309] = {'��ɢ��','������ѧ�ͽ�����ѧ������+20%��������+20%��',2,1,2}   --��Ө��
    CC.PTFSM[308] = {'��ɢ��','������ѧ�ͽ�����ѧ������+20%��������+20%��ս����ʹ��ָ���䡿�ı�������',2,1,3}   --����
    CC.PTFSM[307] = {'��ɢ��','������ѧ�ͽ�����ѧ������+20%��������+20%��',2,1,2}   --��ǫ
    CC.PTFSM[306] = {'��ɢ��','������ѧ�ͽ�����ѧ������+20%��������+20%��',2,1,2}   --�ܵ�    
    CC.PTFSM[305] = {'�����ʹ','������ѧ�ͽ�����ѧ����׷��500�㣬��������Ѫ��',2,1,2}   --ׯ�  
    CC.PTFSM[304] = {'��ľ��ʹ','������ѧ�ͽ�����ѧ����׷��500�㣬������Ѫ��',2,1,2}   --�Ų���  
    CC.PTFSM[303] = {'��ˮ��ʹ','������ѧ�ͽ�����ѧ����׷��500�㣬�������ա�',2,1,2}   --����  
    CC.PTFSM[302] = {'�һ���ʹ','������ѧ�ͽ�����ѧ����׷��500�㣬���������ա�',2,1,2}   --��ȼ      
    CC.PTFSM[301] = {'������ʹ','������ѧ�ͽ�����ѧ����׷��500�㣬�ܵ����˺�����15%��',2,1,2}   --��ԫ   
    CC.PTFSM[300] = {'ȫ�����','ȫ�����ѧ����׷��500�㡣',2,1,1}   --ȫ�����  
    CC.PTFSM[299] = {'ȫ�����','ȫ�����ѧ����׷��500�㡣',2,1,1}   --ȫ�����  
    CC.PTFSM[298] = {'ȫ�����','ȫ�����ѧ����׷��500�㡣',2,1,1}   --ȫ�����  
    CC.PTFSM[297] = {'ȫ�����','ȫ�����ѧ����׷��500�㡣',2,1,1}   --ȫ�����  
    CC.PTFSM[296] = {'ȫ�����','ȫ�����ѧ����׷��500�㡣',2,1,1}   --ȫ�����  
    CC.PTFSM[295] = {'ȫ�����','ȫ�����ѧ����׷��500�㡣',2,1,1}   --ȫ�����  
    CC.PTFSM[294] = {'ȫ�����','ȫ�����ѧ����׷��500�㡣',2,1,1}   --ȫ�����  
    CC.PTFSM[293] = {'ȫ�����','ȫ�����ѧ����׷��500�㡣',2,1,1}   --ȫ�����  
    CC.PTFSM[292] = {'ȫ�����','ȫ�����ѧ����׷��500�㡣',2,1,1}   --ȫ�����    
    CC.PTFSM[291] = {'ȫ�����','ȫ�����ѧ����׷��500�㡣',2,1,1}   --������    
    CC.PTFSM[290] = {'���ư���','��������׷��500�㡣',2,1,1}   --���ư���
    CC.PTFSM[289] = {'���ư���','��������׷��500�㡣',2,1,1}   --���ư���
    CC.PTFSM[288] = {'���ư���','��������׷��500�㡣',2,1,1}   --���ư���
    CC.PTFSM[287] = {'���ư���','��������׷��500�㡣',2,1,1}   --���ư���
    CC.PTFSM[286] = {'���ư���','��������׷��500�㡣',2,1,1}   --���ư���
    CC.PTFSM[285] = {'���ư���','��������׷��500�㡣',2,1,1}   --���ư���
    CC.PTFSM[284] = {'���ư���','��������׷��500�㡣',2,1,1}   --���ư���
    CC.PTFSM[283] = {'���ư���','��������׷��500�㡣',2,1,1}   --���ư���
    CC.PTFSM[282] = {'���ư���','��������׷��500�㡣',2,1,1}   --���ư���
    CC.PTFSM[281] = {'���ư���','��������׷��500�㡣',2,1,1}   --���ư���
    CC.PTFSM[280] = {'ؤ�︱����','ؤ����ѧ������+20%��������+20%��',2,1,2}   --���Ԫ
    CC.PTFSM[279] = {'ؤ�ﳤ��','ؤ����ѧ������+20%��������+20%��',2,1,2}   --������
    CC.PTFSM[278] = {'ؤ�ﳤ��','ؤ����ѧ������+20%��������+20%��',2,1,2}   --��ɽ��
    CC.PTFSM[277] = {'ؤ�ﳤ��','ؤ����ѧ������+20%��������+20%��',2,1,2}   --�¹���
    CC.PTFSM[276] = {'ؤ�ﳤ��','ؤ����ѧ������+20%��������+20%��',2,1,2}   --�ⳤ��
    CC.PTFSM[275] = {'ؤ�ﳤ��','ؤ����ѧ������+20%��������+20%��',2,1,2}   --�����
    CC.PTFSM[274] = {'ؤ�ﳤ��','ؤ����ѧ������+20%��������+20%��',2,1,2}   --������
    CC.PTFSM[273] = {'ؤ�ﳤ��','ؤ����ѧ������+20%��������+20%��',2,1,2}   --����
    CC.PTFSM[272] = {'ؤ�ﳤ��','ؤ����ѧ������+20%��������+20%��',2,1,2}   --������
    CC.PTFSM[271] = {'ؤ�ﳤ��','ؤ����ѧ������+20%��������+20%��',2,1,2}   --ȫ����
    CC.PTFSM[270] = {'���޵���','������ѧ׷��500��ɱ����',2,1,1}   --�ɻ���
    CC.PTFSM[269] = {'���޵���','������ѧ׷��500��ɱ����',2,1,1}   --������
    CC.PTFSM[268] = {'���޵���','������ѧ׷��500��ɱ����',2,1,1}   --������
    CC.PTFSM[267] = {'���޵���','������ѧ׷��500��ɱ����',2,1,1}   --������
    CC.PTFSM[266] = {'���޵���','������ѧ׷��500��ɱ����',2,1,1}   --ʨ����
    CC.PTFSM[265] = {'���޵���','������ѧ׷��500��ɱ����',2,1,1}   --׷����
    CC.PTFSM[264] = {'���޵���','������ѧ׷��500��ɱ����',2,1,1}   --Ħ����
    CC.PTFSM[263] = {'���޵���','������ѧ׷��500��ɱ����',2,1,1}   --������
    CC.PTFSM[262] = {'���޵���','������ѧ׷��500��ɱ����',2,1,1}   --ʨ����
    CC.PTFSM[261] = {'���޵���','������ѧ׷��500��ɱ����',2,1,1}   --ժ����
    CC.PTFSM[260] = {'���ڵ���','������ѧ׷��500��ɱ����',2,1,1}   --��ɮ 
    CC.PTFSM[259] = {'���ڵ���','������ѧ׷��500��ɱ����',2,1,1}   --��ɮ 
    CC.PTFSM[258] = {'���ڵ���','������ѧ׷��500��ɱ����',2,1,1}   --��ɮ 
    CC.PTFSM[257] = {'���ڵ���','������ѧ׷��500��ɱ����',2,1,1}   --��ɮ 
    CC.PTFSM[256] = {'���ڵ���','������ѧ׷��500��ɱ����',2,1,1}   --��ɮ 
    CC.PTFSM[255] = {'���ڵ���','������ѧ׷��500��ɱ����',2,1,1}   --��ɮ 
    CC.PTFSM[254] = {'���ڵ���','������ѧ׷��500��ɱ����',2,1,1}   --��ɮ 
    CC.PTFSM[253] = {'���ڵ���','������ѧ׷��500��ɱ����',2,1,1}   --��ɮ 
    CC.PTFSM[252] = {'���ڵ���','������ѧ׷��500��ɱ����',2,1,1}   --��ɮ 
    CC.PTFSM[251] = {'���ڵ���','������ѧ׷��500��ɱ����',2,1,1}   --��ɮ    
    CC.PTFSM[250] = {'ѩɽ����','ѩɽ���书������+40%��������+40%���书����+400��',2,1,3}   --������
    CC.PTFSM[249] = {'���ڴ���','���ڵ�������+400�����ڵ���������+30%�������ʱ�+30%��',2,1,3}   --ʷ����
    CC.PTFSM[248] = {'ѩɽ����','ѩɽ���书������+20%��������+20%��',2,1,2}   --����ѧ
    CC.PTFSM[247] = {'ѩɽ����','ѩɽ���书������+20%��������+20%��',2,1,2}   --������
    CC.PTFSM[246] = {'ѩɽ����','ѩɽ���书������+20%��������+20%��',2,1,2}   --������
    CC.PTFSM[245] = {'ѩɽ����','ѩɽ���书������+20%��������+20%��',2,1,2}   --���Խ�
    CC.PTFSM[244] = {'ѩɽ����','ѩɽ���书������+20%��������+20%��',2,1,2}   --������
    CC.PTFSM[243] = {'��÷Ů��','ѩɽ���书׷��500��ɱ��ֵ��',2,1,1}   --������
    CC.PTFSM[242] = {'ѩɽ����','ѩɽ���书׷��500��ɱ��ֵ��',2,1,1}   --������
    CC.PTFSM[241] = {'ѩɽ����','ѩɽ���书׷��500��ɱ��ֵ��',2,1,1}   --�����
    CC.PTFSM[240] = {'ħ��','���������ѧ������+20%��������+20%��',2,1,2}   --����
    CC.PTFSM[239] = {'��ɥ��','���������ѧ������+20%��������+20%��',2,1,2}   --ɣ����
    CC.PTFSM[238] = {'����','���������ѧ������+20%��������+20%��',2,1,2}   --�Ϲ���
    CC.PTFSM[237] = {'��������','���������ѧ������+20%��������+20%��',2,1,2}   --�ֲ�
    CC.PTFSM[236] = {'���״���','���������ѧ������+20%��������+20%��',2,1,2}   --ͯ����
    CC.PTFSM[235] = {'��ɰ��','���������ѧ������+20%��������+20%��',2,1,2}   --�����
    CC.PTFSM[234] = {'��������','��Ѫ10%,ÿʱ����ʧ3��������',2,1,3}   --������
    CC.PTFSM[233] = {'�����ܹ�','���������ѧ������+20%��������+20%��',2,1,2}   --����ͤ
    CC.PTFSM[232] = {'ɫǹ','���������ѧ������+20%��������+20%��',2,1,2}   --��ΰ��
    CC.PTFSM[231] = {'��ī����','���������ѧ������+20%��������+20%��',2,1,2}   --����
    CC.PTFSM[230] = {'�嶾��ͽ','�嶾����ѧ׷��500��ɱ��ֵ��',2,1,1}   --�嶾��ͽ
    CC.PTFSM[229] = {'�嶾��ͽ','�嶾����ѧ׷��500��ɱ��ֵ��',2,1,1}   --�嶾��ͽ
    CC.PTFSM[228] = {'�嶾��ͽ','�嶾����ѧ׷��500��ɱ��ֵ��',2,1,1}   --�嶾��ͽ
    CC.PTFSM[227] = {'�嶾��ͽ','�嶾����ѧ׷��500��ɱ��ֵ��',2,1,1}   --�嶾��ͽ
    CC.PTFSM[226] = {'�嶾��ͽ','�嶾����ѧ׷��500��ɱ��ֵ��',2,1,1}   --�嶾��ͽ
    CC.PTFSM[225] = {'�嶾��ͽ','�嶾����ѧ׷��500��ɱ��ֵ��',2,1,1}   --�嶾��ͽ
    CC.PTFSM[224] = {'�嶾��ͽ','�嶾����ѧ׷��500��ɱ��ֵ��',2,1,1}   --�嶾��ͽ
    CC.PTFSM[223] = {'�嶾��ͽ','�嶾����ѧ׷��500��ɱ��ֵ��',2,1,1}   --�嶾��ͽ
    CC.PTFSM[222] = {'�嶾��ͽ','�嶾����ѧ׷��500��ɱ��ֵ��',2,1,1}   --�嶾��ͽ
    CC.PTFSM[221] = {'�嶾��ͽ','�嶾����ѧ׷��500��ɱ��ֵ��',2,1,1}   --�嶾��ͽ
    CC.PTFSM[220] = {'�������','�������ѧ������+40%��������+40%���书����+400',2,1,3}   --˾����
    CC.PTFSM[219] = {'��ǳ���','�������ѧ������+20%��������+20%��',2,1,2}   --����
    CC.PTFSM[218] = {'��ǳ���','�������ѧ������+20%��������+20%��',2,1,2}   --���޽�
    CC.PTFSM[217] = {'��ǵ���','�������ѧ׷��500��ɱ��ֵ��',2,1,1}   --˾����
    CC.PTFSM[216] = {'��ǵ���','�������ѧ׷��500��ɱ��ֵ��',2,1,1}   --���
    CC.PTFSM[215] = {'��ǵ���','�������ѧ׷��500��ɱ��ֵ��',2,1,1}   --���˴�
    CC.PTFSM[214] = {'�������','�������ѧ������+10%��������+10%��',2,1,2}	 --���˺�
    CC.PTFSM[213] = {'�������','�������ѧ������+10%��������+10%��',2,1,2}	 --������
    CC.PTFSM[212] = {'�������','�������ѧ������+10%��������+10%��',2,1,2}	 --���˽�
    CC.PTFSM[211] = {'�������','�������ѧ������+10%��������+10%��',2,1,2}	 --����Ӣ
    CC.PTFSM[210] = {'̩ɽ����','̩ɽ����ѧ������+20%��������+20%��',2,1,2}	 --����
    CC.PTFSM[209] = {'̩ɽ����','̩ɽ����ѧ������+20%��������+20%��',2,1,2}	 --������
    CC.PTFSM[208] = {'̩ɽ����','̩ɽ����ѧ������+20%��������+20%��',2,1,2}  --��ܰ��   
    CC.PTFSM[207] = {'̩ɽ����','̩ɽ����ѧ������+20%��������+20%��',2,1,2}	 --������   
    CC.PTFSM[206] = {'̩ɽ����','̩ɽ����ѧ׷��500��ɱ��ֵ��',2,1,1}	 --���� 
    CC.PTFSM[205] = {'̩ɽ����','̩ɽ����ѧ׷��500��ɱ��ֵ��',2,1,1}	 --��� 
    CC.PTFSM[204] = {'̩ɽ����','̩ɽ����ѧ׷��500��ɱ��ֵ��',2,1,1}	 --���� 
    CC.PTFSM[203] = {'̩ɽ����','̩ɽ����ѧ׷��500��ɱ��ֵ��',2,1,1}	 --�ٰٳ� 
    CC.PTFSM[202] = {'̩ɽ����','̩ɽ����ѧ׷��500��ɱ��ֵ��',2,1,1}	 --������� 
    CC.PTFSM[201] = {'̩ɽ��ʦ','̩ɽ����ѧ������+50%��������+50%������+500��',2,1,3}	 --�������  
    CC.PTFSM[200] = {'��ͷ����','��ɽ���书������+20%��',2,1,2}	 --����
    CC.PTFSM[199] = {'��������','��ɽ���书������+20%��',2,1,2}	 --�ֺ�
    CC.PTFSM[198] = {'��������','��ɽ���书������+20%��',2,1,2}	 --�ѱ�
    CC.PTFSM[197] = {'������','��ɽ���书������+20%��',2,1,2}	 --½��  
    CC.PTFSM[196] = {'������','��ɽ���书������+20%��',2,1,2}	 --��Ӣ��
    CC.PTFSM[195] = {'������','��ɽ���书������+20%��',2,1,2}	 --����
    CC.PTFSM[194] = {'��ɽ����','��ɽ����ѧ׷��500��ɱ��ֵ��',2,1,1}	 --�߿���
    CC.PTFSM[193] = {'��ɽ����','��ɽ����ѧ׷��500��ɱ��ֵ��',2,1,1}	 --�˰˹�
    CC.PTFSM[192] = {'��ɽ����','��ɽ����ѧ׷��500��ɱ��ֵ��',2,1,1}	 --ɳ�콭
    CC.PTFSM[191] = {'��ɽ����','��ɽ����ѧ׷��500��ɱ��ֵ��',2,1,1}	 --���� 
    CC.PTFSM[190] = {'��֮��','�����ж� ������200�㡣',2,1,3}	 --ç����� 
    CC.PTFSM[189] = {'��������','�������뱩����+50%������ʱ�ش�������Ԫһ������ɵ�ȫ�����ˡ�����1000������������������û�гͷ�������ʹ�ÿ����񹦹���,Ца���ܿ�����������ϴ�����񹦡�',2,1,4}	 --����� 
    CC.PTFSM[188] = {'ͭ��������','װ���йٱ������˺�5%��ÿ����һ�������ӣ��ܵ����˺�����10%��������20%��',2,1,3}	 --����
    CC.PTFSM[187] = {'��������','�����������˺�����10%������+10%��',2,1,3}	 --���ѵ�
    CC.PTFSM[186] = {'�����޼�','ʹ��ȭ������׷��100����ʵ�˺�����δװ����������˼ӳɷ�����',2,1,3}	 --������
    CC.PTFSM[185] = {'�ɽ���Գ','�ȴ�ʱ�Զ��������޷���������������Ч������ʹ�ý�ϵ�书����ʱ����������װ����Գ��Գ����������+500��',2,1,4}	 --������
    CC.PTFSM[184] = {'��������','���к͸����20%���Ṧ����20%��',2,1,4}	 --������
    CC.PTFSM[183] = {'ûӰ��','�Ṧ+50��',2,1,2}	 --÷����
    CC.PTFSM[182] = {'�嶡��','ָ����ȭ��������+20%��',2,1,2}	 --������
    CC.PTFSM[181] = {'�ɶ�����','���ǽ���������+20%��',2,1,2}	 --���ӻ�
    CC.PTFSM[180] = {'�ɶ�����','���ǽ���������+20%��',2,1,2}	 --����
    CC.PTFSM[179] = {'̫����Ӣ','��Ϣʱ�ظ�˫����',2,1,2}	 --���
    CC.PTFSM[178] = {'̫����Ӣ','��Ϣʱ�ظ�˫����',2,1,2}	 --ʷ����
    CC.PTFSM[177] = {'̫����Ӣ','��Ϣʱ�ظ�˫����',2,1,2}	 --ʷ����
    CC.PTFSM[176] = {'�嶾ʥ��','������ʹ�������ж�20�㣬���͹�����5��������200��������',2,1,2}	 --�κ�ҩ
    CC.PTFSM[175] = {'ʥ����ʹ','40%���ʼ���λ����ǰ��Ծ20~40��',2,1,3}	 --����ʹ
    CC.PTFSM[174] = {'ʥ����ʹ','40%���ʼ���λ����ǰ��Ծ20~40��',2,1,3}	 --����ʹ
    CC.PTFSM[173] = {'ʥ����ʹ','40%���ʼ���λ����ǰ��Ծ20~40��',2,1,3}	 --���ʹ
    CC.PTFSM[172] = {'����֮Ѫ','ս���и���������������繦��',2,1,4}	 --����..����
    CC.PTFSM[171] = {'����֮Ѫ','ս���и���������������繦��',2,1,4}	 --Ů��..�¶�
    CC.PTFSM[170] = {'�Ĵ���ɮ','ʹ����צ��ʱ�Զ�����ȴ�״̬��',2,1,2}	 --����
    CC.PTFSM[169] = {'�Ĵ���ɮ','ʹ�ô��������ʱ�Զ���������״̬��',2,1,2}	 --����
    CC.PTFSM[168] = {'��ἳ���','�������ѧ������+20%,������+20%��',2,1,2}	 --����֮
    CC.PTFSM[167] = {'��ἳ���','�������ѧ������+20%,������+20%��',2,1,2}	 --��ά��
    CC.PTFSM[166] = {'̫������','���ǽ�������+200��',2,1,2}	 --�����
    CC.PTFSM[165] = {'̰������','ÿ����ʮʱ�򣬻ظ�����10%��ÿ��һ��ʱ��ʧȥ����20%��',2,1,2}	 --�쳤��
    CC.PTFSM[164] = {'Ħ���ʿ','�Դ���ö�������һ�������˸���,�����ܵ����˺�����20%�����:�Ҹ������ˣ�����һ���˺��һظ������˺���Ѫ��������:��ֹ���ģ������ж����ж�ʱ���������һö������Ч����',2,1,4}	 --л�̿�
    CC.PTFSM[163] = {'һ�ղ�����','�з�ȫ�弯��-3���붡����ͬʱ�ڳ����з�ȫ�弯��-3��',2,1,3}	 --������
    CC.PTFSM[162] = {'һ�ղ�����','�з�ȫ�弯��-3���붡����ͬʱ�ڳ����з�ȫ�弯��-4��',2,1,3}	 --������
    CC.PTFSM[161] = {'��������','�嶾���Ʊ�Ϊ�������ƣ�׷��70���˺�����ǿ���϶�20�㣬����Ŀ�����϶��ء�*����Ե���������а�߹�Ĺ�ܵ����飬ϴ�ڶ��������书���츳�ڹ�ϴΪ��Ů�ľ���',2,1,3}	 --��Ī��
    CC.PTFSM[160] = {'�ɹ���ʿ','��ɫָ���ս,����һ�����ˣ���������֮ǰ������Ͷ���Ĺ���Ч�����50%���ұض�����,��Ŀ������֮ǰ�޷�����Ŀ�ꡣ',2,1,2}	 --�����
    CC.PTFSM[159] = {'��������','�ض��������˺��������1.5�����츳�⹦�����׵Ķ���������Ч����',2,1,2}	 --��Ħ��
    CC.PTFSM[158] = {'��˹���','��Ϊ��������ʱ���ֻ��һ������,�ж�ʱ���ʷų���Ǯ�ڶ������������˺���',2,1,3}	 --������
    CC.PTFSM[157] = {'����ʬ��','ս����ÿһ�������ĳ�Ա�����ظ�ʬ��200����Ѫ��',2,1,2}	 --������
    CC.PTFSM[156] = {'���޳�','�ҷ���+200������+100��',2,1,2}	 --���޳� ����־
    CC.PTFSM[155] = {'���޳�','�з���-200������-100��',2,1,2}	 --���޳� ����־
    CC.PTFSM[154] = {'ԧ�쵶��','ʹ�÷��޵��������ˣ��ҷ�ȫ������+200��',2,1,2}	 --��� 
    CC.PTFSM[153] = {'ǧ������','��ʼ����ֵ200�㣬ս��ʤ���������ð�����',2,1,3}	 --�԰�ɽ   
    CC.PTFSM[152] = {'׷�������','����ֵ����50%ʱ����������������ֵ����25%ʱ������������',2,1,3}	 --�޳�
    CC.PTFSM[151] = {'������','ʱ������1ŭ������Ѫʱ������2ŭ������ŭ�������ʴ����׶����죬ΪĿ�����һ������BUFF���Դ��ڵ���������BUFF��Ŀ�����һ�غϡ�',2,1,3}	 --��̩��
    CC.PTFSM[150] = {'һ����Ѫ','����ʱ�Է�����Ѫ�����˫����ѪЧ��������з��з�����Ѫ״̬��ֱ�ӽ����˺����һظ�����ͬ��Ѫ����',2,1,3}	 --������
    CC.PTFSM[149] = {'ǧ������','ʹ��ȭ������ʱ��������Χ����һ���Զ������׽�����ߵз���������������Ч����',2,1,3}	 --��֤
    CC.PTFSM[148] = {'�ҹ�����','ָ��������Ѩ�������Ҹ��ʶ���',2,1,2}	 --��ʵ��
    CC.PTFSM[147] = {'�ҹ�����','ָ��������Ѩ�������Ҹ��ʶ���',2,1,2}	 --�һ���
    CC.PTFSM[146] = {'�ҹ�����','ָ��������Ѩ�������Ҹ��ʶ���',2,1,2}	 --��Ҷ��    
    CC.PTFSM[145] = {'�ҹ�����','ָ��������Ѩ�������Ҹ��ʶ���',2,1,2}	 --��֦��
    CC.PTFSM[144] = {'�ҹ�����','ָ��������Ѩ�������Ҹ��ʶ���',2,1,2}	 --�Ҹ���
    CC.PTFSM[143] = {'�ҹ�����','ָ��������Ѩ�������Ҹ��ʶ���',2,1,2}	 --�Ҹ���
    CC.PTFSM[142] = {'���콣','ʹ�ý����������»غϼ���+100��',2,1,2}	 --�ⲻƽ
    CC.PTFSM[141] = {'��������','ʹ�ý�������ʱ��Ϊ��������',2,1,2}	 --�ɲ���
    CC.PTFSM[140] = {'����ͨ��','��ʼ����λ��+990����ŭʱ��ʹ�ö��¾Ž�������׷��1000����������10ʱ��ľ�ֹ״̬���ɵ��ӡ�',2,1,4}	 --������
    CC.PTFSM[139] = {'��ƽ����','�ܵ�Ů�Թ������˺�����5%����Ů������˺�����5%��',2,1,2}	 --֣��ˬ
    CC.PTFSM[138] = {'һָ����','ָϵ�书��������200��',2,1,2}	 --�߶�����
    CC.PTFSM[137] = {'������','���߽�������+200',2,1,2}	 --�´ﺣ
    CC.PTFSM[136] = {'ԽŮ��','ʹ�ý���ʱ����+100',2,1,2}	 --��СӨ
    CC.PTFSM[135] = {'��������','�Ṧ����100',2,1,2}	 --ȫ���
    CC.PTFSM[134] = {'Ц����','����������100',2,1,2}	 --������
    CC.PTFSM[133] = {'��ɽ����','����������100��',2,1,2}	 --��ϣ��
    CC.PTFSM[132] = {'������','��������˫������(��������Χ����',2,1,2}	 --������
    CC.PTFSM[131] = {'��������','��ʵ�������+200',2,1,2}	 --���
    CC.PTFSM[130] = {'��������','�Զ����˷������С�',2,1,2}	 --�����
    CC.PTFSM[129] = {'����ͨ','ȫ����ѧ����������ʹ��ȫ�潣����60%���ʷ�������������׷��777����������ʱ�߼�����ɷ�Ѩ������ʱ���ʸ�Ŀ����ӡ�ͬ�顿״̬��',2,1,4}	 --������
    CC.PTFSM[128] = {'�徻ɢ��','ȫ�潣������������',2,1,2}	 --�ﲻ��
    CC.PTFSM[127] = {'������','ȫ�潣������������',2,1,2}	 --�´�ͨ
    CC.PTFSM[126] = {'������','ȫ�潣������������',2,1,2}	 --����һ
    CC.PTFSM[125] = {'������','ȫ�潣������������',2,1,2}	 --������
    CC.PTFSM[124] = {'������','ȫ�潣������������',2,1,2}	 --̷����
    CC.PTFSM[123] = {'������','ȫ�潣����������,���칦��Ѫ�������ظ�������',2,1,3}	 --����
    CC.PTFSM[122] = {'��ɽ����','�Ṧ����10%,�����ͷ�������10%��',2,1,2}	 --������
    CC.PTFSM[121] = {'����˫ͨ','��ȡ��ѧ��������Ϊ�������������ӡ�',2,1,1}	 --����ͨ
    CC.PTFSM[120] = {'�Է�','�����������������100�㡣',2,1,2}	 --��
    CC.PTFSM[119] = {'�������','���ŵ�������+300��',2,1,1}	 --�������
    CC.PTFSM[118] = {'��ˮ�޳�','�������ٶȲ��ܻ����쳣״̬Ӱ�졣',2,1,2}	 --����ˮ
    CC.PTFSM[117] = {'Ψ�Ҷ���','�˻����Ϲ���Ч�ش�����',2,1,2}	 --��ɽͯ��
    CC.PTFSM[116] = {'��ң����','��������9999��������ʱ�ض�������ڤ�������塣',2,1,4}	 --������
    CC.PTFSM[115] = {'�ϱ�����','��������20%��',2,1,3}	 --ɨ��
    CC.PTFSM[114] = {'�����','��������9999�����������ˣ�������100%��������ض��𡿣���ȫ����ɱ����',2,1,4}	 --ɨ��
    CC.PTFSM[113] = {'����Ѫ��','��ת�����С�',2,1,3}	 --Ľ�ݲ�
    CC.PTFSM[112] = {'ɱ����','��������ɱ����״̬�����غ��ڱ�����ŭ��ɱ�����2000��',2,1,4}	 --��Զɽ 
    CC.PTFSM[111] = {'����ׯ��','�����书����+150',2,1,1}	 --�ξ� 
    CC.PTFSM[110] = {'����ׯ��','�����书����+150',2,1,1}	 --���� 
    CC.PTFSM[109] = {'������','���ǽ�������+200��',2,1,1}	 --����ͨ 
    CC.PTFSM[108] = {'��ɽ����','�����ǵ�������+300��',2,1,1}	 --������ 
    CC.PTFSM[107] = {'��ɽ����','�����ǵ�������+300��',2,1,1}	 --������   
    CC.PTFSM[106] = {'�廢�ϻ�','�廢���ŵ�����+200',2,1,2}	 --��Ԫ��    
    CC.PTFSM[105] = {'��������','��Ľ�ݸ�ͬ�ӣ���Ľ�ݸ��е������˺���',2,1,2}	 --����   
    CC.PTFSM[104] = {'ǧ������','ʹ��ָ����ݡ�ֻ�ܵ����ˡ�',2,1,2}	 --����   
    CC.PTFSM[103] = {'��������','ѧ��С���๦����ѧϰ�κ��书ϵ�����󽵵�20����ɫָ��û���ʹ��С���๦ģ��������ѧ������Ҫӵ�ж�Ӧ���ؼ���',2,1,3}	 --�Ħ��
    CC.PTFSM[102] = {'������ʦ','ʹ��һ��ָ�߼������������ջָ������ӱ���ʱ��ָ�2�����գ���',2,1,2}	 --����
    CC.PTFSM[101] = {'������','װ���йٱ�ʱ���������ӷ�Ѩ������',2,1,2}	 --�쵤��
    CC.PTFSM[100] = {'���׼���','����Ů��ʱ���ָ�����˺�10%��Ѫ�������ι�����Ѫ����100�㣩��',2,1,2}	 --���к�
    CC.PTFSM[99] = {'�޶���','ʹ�û�ɳ����ޱ�˫����',2,1,1}	 --Ҷ����
    CC.PTFSM[98] = {'�����ӯ','����/����/���м��ʴ����ߣ��޷���Ϣ��',2,1,3}	 --������
    CC.PTFSM[97] = {'Ѫ������','���������ʴ������ߣ���ʼ����λ��900�����ƶ�+3��',2,1,3}	 --Ѫ������
    CC.PTFSM[96] = {'���½�','����64�������������ʱ����640��������',2,1,2}	 --ˮ�
    CC.PTFSM[95] = {'���ƽ�','������ʱ����һ��ɱ��ת��Ϊ��Ѫ��',2,1,2}	 --���˷�
	CC.PTFSM[94] = {'���嵶','ʹ�õ����ض���������������1.5����',2,1,2}	 --½����
	CC.PTFSM[93] = {'����','�ѷ��ж�����+20��',2,1,2}	 --ƽ����	
	CC.PTFSM[92] = {'������','���������ˣ��ڶ�����ʱ��������ս����ʼǰ������ɫָ���װ��ʹ�ú�ı��������Σ�������ò�ͬ���ڹ���',2,1,3}	 --��̫��	
	CC.PTFSM[91] = {'��������','����ɽ���γ����߽���ϴ��һ���书Ϊ���߽�����',2,1,1}	 --������	
	CC.PTFSM[90] = {'ع�����','����ʱ�ض������Ѫ������������ʱ����͵�Եз�Я������Ʒ��������ǿ���϶�50�㡣*����Ե�������ҵ���������ɵ�һ���书ϴ�����������������ն�����ϴ��һ���书���츳�⹦ϴΪ�����񽣡�',2,1,3}	 --����
	CC.PTFSM[89] = {'ʳ��','����������������',2,1,2}	 --�˳���
	CC.PTFSM[88] = {'����','������ʱ��30%���ʷ������������ٲ�������',2,1,2}	 --��ǧ��
	CC.PTFSM[87] = {'������˿','�з�ȫ�幥��Ч������10%��',2,1,2}	 --����
	CC.PTFSM[86] = {'��֦��Ҷ','�з�ȫ�����������15%��',2,1,2}	 --����
	CC.PTFSM[85] = {'��ı����','ÿ��999ʱ���Զ�����Ѫ���岢�����������쳣״̬��',2,1,2}	 --����ʯ
	CC.PTFSM[84] = {'С��ү','�书�������������ܵ���5%����������25%����',2,1,2}	 --����
	CC.PTFSM[83] = {'�嶾����','���������Ӷ���ʹ�������ж�45~50�㣬�ö���������500��',2,1,3}	 --������
	CC.PTFSM[82] = {'�䵱��Ӣ','�䵱���书������+10%��������+10%��',2,1,2}	 --������
	CC.PTFSM[81] = {'ѩ��˫�','ս���Ͽɷ���ʳ�ġ�',2,1,1}	 --�����
	CC.PTFSM[80] = {'�����й�','�����ض����ˣ����������Ч���ӱ���*����Ե�������䵱ɽ͵̫������֧�ߣ�ϴ�ڶ��������书�����������޼����������һ����к��츳�ڹ���Ϊ�����񹦡�',2,1,2}	 --������
	CC.PTFSM[79] = {'Сʦ��','Ц�������ھ�ѡ����а���飬ϴ��һ�����������ġ�����书��',2,1,2}	 --����ɺ
	CC.PTFSM[78] = {'��ʬħɷ','��ɽ����󣬾����׹�צ��������50%��',2,1,2}	 --÷����
	CC.PTFSM[77] = {'ԧ�쵶��','ʹ�÷��޵��������ˣ���װ��ר�������쵶��',2,1,2}	--���л�
	CC.PTFSM[76] = {'�ŋ�����','�ڳ�ʱ���ҷ�ȫ�幥����Χ����һ�񣬻���貨΢�����츳�ṦϴΪ�貨΢����',2,1,4}	--������
	CC.PTFSM[75] = {'��غ컨','����ʱ��30%����ֱ�ӻ���������20%���ʻ��е��˺���ٵ���һ��������',2,1,2} --�¼���
	CC.PTFSM[74] = {'�������','�ڳ�ʱ���ҷ�ȫ�����ӻ�������20%��',2,1,2} --����ͩ
	CC.PTFSM[73] = {'����ʥ��','ÿʱ��ظ�����5���ж���',2,1,2} --��ӯӯ
	CC.PTFSM[72] = {'��������','���ӱ���ֵ����װ��������������,װ��������������������ʱ�ض�������ѪЧ����*����Ե��������а��ɱ���˷��ϴ��һ�������书���츳�⹦ϴΪ�����罣�� ',2,1,3} --���ũ
	CC.PTFSM[71] = {'��������','ʹ���κ��书���������߱����� ',2,1,2} --�鰲ͨ
	CC.PTFSM[70] = {'�����޺�','����ʱ����������20%������ʱ����������20%��������ʱ�Ṧ����20%�� ',2,1,3} --
	CC.PTFSM[69] = {'��ؤ','ʹ�ý���ʮ���ƣ�40%���ʷ���������.���⡿��ʹ�ý���ʮ���ƹ��������ˡ�*����Ե��������ɽ����֧�߾��飬ϴ�������书���츳�ڹ�ϴΪ�����񹦣���������תΪ���ڡ� ',2,1,3} --���߹�
	CC.PTFSM[68] = {'������','��ɽ�����ȫ�潣�������������������칦��ȫ�潣���仯���ǽ��� ����150���˺��� ',2,1,2} --�𴦻�
	CC.PTFSM[67] = {'����ˮ��Ư','ʹ���κ��书���������߱���,�ƶ�����+5�� ',2,1,3} -- 
	CC.PTFSM[66] = {'��˹ʥŮ','��ȫ���ƶ�������,��������ѧϰǬ����Ų�ơ� ',2,1,3}
	CC.PTFSM[65] = {'�ϵ�','ʹ��һ��ָ�����з�׷�ӡ�����ҵ��״̬������30ʱ�򣬴��ڡ�����ҵ��״̬���˹���ʱ������ʧ50%����������������������ʱ�߼�����ɷ�Ѩ��',2,1,3}	
	CC.PTFSM[64] = {'��ͯ���','ÿ�ж�һ�Σ�����Ч������5%���������30%��',2,1,3}
	CC.PTFSM[63] = {'��������','ʹ�����｣����������ɱ������300�㡣*����Ե�������������ţ�Ҵ���飬ϴ�ڶ��������书 ',2,1,2}
	CC.PTFSM[62] = {'Ԫ�ɵ�ʦ','�κι���׷��2000��������*����Ե�����������������ս�����������������������ս������ʮ��ʮ�� ',2,1,3}
	CC.PTFSM[61] = {'��������','��ŭʱ��ʹ��ѩɽ�����ƿɴ�������ȭ�����еĵ��˼������벨��״̬20ʱ�� ',2,1,3}
	CC.PTFSM[60] = {'����','���й��������ˣ�����ʱ���ӵз�����ǿ���϶�30�㡣*����Ե�����������ϼ�������ϴ�ڶ����书���츳�ڹ�ϴΪ���˾���,��ɽ����֧�߾��飬ϴ�������书�� ',2,1,3}
	CC.PTFSM[59] = {'�������','���һ�����������70%��ʹ����Ů���Ľ����߼��������� ',2,1,3}
	CC.PTFSM[58] = {'����','ʹ����������ʱ���м��ʷ����ؽ��洫,����ʱ����������֮ŭХ�����з�ȫ�弯������100��,ս���У���С��Ů������ʱ������������ֲ�����������֮��ŭ��������Х��,��Ȼ�������������*����Ե���������½�ڣ����������ʱ��ϴ��һ���书��������ħ���٣������������ս��ϴ�������书����ѡ��ϴ�츳�ڹ������ٻ��Ⱦ����ϴ�ڶ����书�����ţ�Ҵ�֧�ߣ���ѡ��ϴ�������书���츳�ڹ�����ɽ����֧�߾��飬��ѡ��ϴ������书',2,1,4}
	CC.PTFSM[57] = {'��а','����ʱ�߼�����ɷ�Ѩ�������ٶ�+10�������ڳ�ʱ���з�����25%��������ƶ����з��ƶ�����-2��',2,1,3}
	CC.PTFSM[56] = {'���Ŷݼ�','ս����ʼǰ�ɲ������󣬲�ͬ��ɫ�ĵ����в�ͬЧ��:��ɫ������ɵ��˺����20%����ɫ�����ܵ����˺�����20%����ɫ��������ʱ׷��400����������ɫ����������ʱ��30%�������ܡ�',2,1,4}
	CC.PTFSM[55] = {'�������','���һ����������ʹ̶�Ϊ80%����Ϊ����ʱ�����10��������������ߡ�*����Ե����������һ������׾��飬ϴ��һ�����������书����������һ����չ���ʱ��������ѡ���������ԡ�',2,1,3}
	CC.PTFSM[54] = {'��Ѫ����','���ܵ��˺���ٴ��ж�,ʹ�ý���׶����������',2,1,3}
	CC.PTFSM[53] = {'��������','��������9999,����ɽ�����顣*����Ե������ϴ��һ�������书�������¾��飬ϴ�������书��',2,1,3}
	CC.PTFSM[52] = {'��ƽ��ǹ','ʹ����ƽǹ��ʱ������+1000,�ж�ǰ����仯һ�����󣬻����Ӧ�츳�͵�һ���书���ж������ٶ����һ�㣬���ް�ʮһ�㡣',2,1,3}
	CC.PTFSM[51] = {'����Ľ��','������ת�����������ֵ��������ת���ƴ�������+10%��*����Ե�����������˲�а����սɨ����ɮʤ����ڶ����Լ��츳�ڹ�ϴ�׽������ڼ�������',2,1,3}
	CC.PTFSM[50] = {'��������','ʹ�ý���ʮ���ƣ��ض�����������.���⡿��ʹ�ý���ʮ���ƣ�40%���ʷ���������.�����ˡ�����ŭʱ�ض�������ʹ�ý���ʮ���ƹ��������ˣ�����ʮ���ƺ��ڽ���50%�����츳�⹦Ч�����ӣ�����75%�������ģ���*����Ե�����������˲�������սɨ����ɮʤ���󣬿ɻ��ר��������',2,1,4}
	CC.PTFSM[49] = {'��ң����','����ɫָ��:���������޹�ɽ������Դ���ڤ�������壬��ɽ��÷���������������ʱ�Ϊ50��*����Ե�������޹�ɽ֧�߾��飬ϴ��һ�������书�����չ��ð˻�ʱ��������ϴΪ�˻����Ϲ���',2,1,4}
	CC.PTFSM[48] = {'�����ֿ�','��������340�㣬���϶����������1~3�㡰����״̬����ÿ�����1%�����ٶȣ�����50�㣬����ʱ����з����ϵı������50������60%���ʽ��䶳��10ʱ��',2,1,4}
	CC.PTFSM[47] = {'����ɳ��','ÿ����һ���з������������������200�㡣',2,1,2}
	CC.PTFSM[46] = {'�����Ϲ�','����ʱ��׷�ӵ�ͬ�ڵз��ж������˺����غϽ���ʱ���ж����۳��з�������������ʬ���س����⣬����Ŀ�����϶��ء�',2,1,4}
	CC.PTFSM[45] = {'������','ҽ������500�㣬ս������Ѫ�����Լ�����ͬ��һ�Ρ�',2,1,2}
	CC.PTFSM[44] = {'�Ϻ�����','��ŭʱ���������˺��Ч����',2,1,1}
	CC.PTFSM[43] = {'ѩɽ����','ѩɽ���书������+40%��������+40%���书����+400��',2,1,3}
	CC.PTFSM[42] = {'����ʹ��','���µ���61���ж�����������Χ�ڵ���ʩ��������ʱ�߼��ʸ������⡣',2,1,3}
	CC.PTFSM[41] = {'����ʹ��','���¸���59���ж�����������Χ�ڶ������ƣ�����ʱ�߼��ʸ������ա�',2,1,3}
	CC.PTFSM[40] = {'���͵���','����Ч������20%��ʹ���κ��书�߼�����ɷ�Ѩ������̫���񹦲��ᴥ��̫��֮�ᡣ',2,1,3}
	CC.PTFSM[39] = {'���͵���','����Ч������20%��ʹ���κ��书�߼�����ɷ�Ѩ������̫���񹦲��ᴥ��̫��֮�ء�',2,1,3}
	CC.PTFSM[38] = {'ʯ���쾪','���Ѻ�̫�����ļ��롣ѧ���޺���ħ��������ʱ�س����޺���ħ����Ч��Ч����ǿ10%��*����Ե����������������ս�������飬ϴ�ڶ����书Ϊ̫���񹦣��츳�ڹ�ϴΪ̫���񹦡�',2,1,4}
	CC.PTFSM[37] = {'��������','ѧ�����ǽ������������籾�ι�������˺�����150����׷��һ��������һ��׷������3�Σ�������Ѫ�����޳ͷ������ή���������ޣ�ѧ��Ѫ���󷨱ر�����*����Ե������ѩɽ���飬ϴ�ڶ��������书��',2,1,4}
	CC.PTFSM[36] = {'��а����','��ʼ����λ��900,ʹ�ñ�а������ʽ��������*����Ե������Ц�������ھ�ѡ����а���飬ϴ��һ�������书,Ц�������ھ�ѡ����а���飬�츳�ڹ�ϴΪ�����񹦡�',2,1,4}
	CC.PTFSM[35] = {'�Ž�����','��������ָ��󣬽���ս����ʼ����ֵ1000���ƶ�����+3;���ɽ�����ξ������򡾾Ž��洫�����������޽���*����Ե������Ц��˼���¾��飬ϴ��һ���书���츳�⹦ϴΪ���¾Ž���Ц��÷ׯ���ξ��飬ϴ�ڶ����书���츳�ڹ�ϴΪ���Ǵ󷨡�',2,1,4}
	CC.PTFSM[34] = {'��������','��ɽ������ҡ��������������������ÿ��һ���ڳ�������+500��',2,1,1}
	CC.PTFSM[33] = {'��������','��ɽ�����������ʽ������������������ÿ��һ���ڳ�������+500��',2,1,1}
	CC.PTFSM[32] = {'��������','��ɽ�������ʵ���������������������ÿ��һ���ڳ�������+500��',2,1,1}
	CC.PTFSM[31] = {'��������','��ɽ���������������������������������ÿ��һ���ڳ�������+500��',2,1,1}  
    --30Ϊ����
    CC.PTFSM[30] = {'1','1',2,1,1}
	CC.PTFSM[29] = {'�ɻ����','����Ů��ʱ��ȡ����������',2,1,4}  --�ﲮ��
	CC.PTFSM[28] = {'ɱ����ҽ','ÿ����һ�����˼����ٶ�+3�㡢ҽ������+50�����5����Ч����ҽ����������500��',2,1,2}  --ƽһָ
	CC.PTFSM[27] = {'Ψ�Ҳ���','�Դ��廨�룬���������ˣ���ŭʱ������״̬���ǰ�����ܵ��˺���',2,1,4}	--��������
	CC.PTFSM[26] = {'����ħ��','���Ǵ�������Ч����ߡ�ʹ���κ��书�߱���������ʱ�߼�����ɷ�Ѩ�� ',2,1,4}	--������
	CC.PTFSM[25] = {'�嶾����','�����˺�����10%���ö���������400�� ',2,1,2}	--�����
	CC.PTFSM[24] = {'�������','�ɷ罣��������������ɽ���Ѻ��ɷ罣���������������������ر����� ',2,1,2}	 --��׺�
	CC.PTFSM[23] = {'̩ɽ����','���������Զ��˹�������ʱ�߼��ʸ������ա� ',2,1,2}	 --����
	CC.PTFSM[22] = {'��ɽ����','���������Զ��˹�������ʱ�߼��ʸ������⡣ ',2,1,2}	  --������
	CC.PTFSM[21] = {'��ɽ����','��ɽ����ѧ������+40%��������+40%����ɽ����ѧ����+500�����������Զ��˹��� ',2,1,3}	 --����
	CC.PTFSM[20] = {'��ɽ����','��ɽ����ѧ������+40%��������+40%����ɽ����ѧ����+500�����������Զ��˹��� ',2,1,3}  --Ī��
	CC.PTFSM[19] = {'���ӽ�','ʹ�ý�����������������ɽ���Ѻ��Դ�����������*����Ե������Ц�������ھ�ѡ����а���飬ϴ��һ�������书�� ',2,1,2} --����Ⱥ
	CC.PTFSM[18] = {'��Ԫ������','�����ٶ�+10��,ʹ���κ��书�߼��������͸߼��ʷ�Ѩ�� ',2,1,3} --����
	CC.PTFSM[17] = {'���ȶ���','�ö���������500,����ʱ����10~50�㡣 ',2,1,2} --���ѹ�
	CC.PTFSM[16] = {'����ҽ��','ҽ������500,���������ҩ,ȫ���Ѿ�ʹ��ҩƷЧ������30%�� ',2,1,2} --����ţ
	CC.PTFSM[15] = {'��������','ÿ���ж�����20%�����Ȼ����һ�غϡ� ',2,1,2} --����˿
	CC.PTFSM[14] = {'��������','�����ٶ�����10�㣬��ɽ����󣬺���������������50%�� ',2,1,2} --ΤһЦ
	CC.PTFSM[13] = {'��ëʨ��','ʨ�Ӻ𷢶������ſ�Ϊ�з��������������ɣ��ܵ����˺�����15%������ȭһ�����˷�������100%����һ�����˶������7�����ˡ� ',2,1,2} --лѷ
	CC.PTFSM[12] = {'��üӥ��','ӥצ����������50%�� ',2,1,1} --������
	CC.PTFSM[11] = {'������ʹ','ÿ�ι�����ʹ�з��ܵ����˺����2%������40%�� ',2,1,1} --����
	CC.PTFSM[10] = {'������ʹ','ÿ���ܵ���������������1%�ļ��ˣ�����20%�� ',2,1,1} --��ң
	CC.PTFSM[9] = {'��������','δ�����ڹ�����������ʱ�����������񹦼��������塣*����Ե�������츮�����ϴ��һ���书������������������⣬�������ܵ��õ�Ǭ��ʱ��ϴ�ڶ����书�����ߵ���������ʥ�������䵱ɽ�������ᣬϴ�������ĸ��书�� ',2,1,4} --���޼�
	CC.PTFSM[8] = {'�������','�������ѧ������+40%,������+40%�������ѧ����+500.' ,2,1,3} --������
	CC.PTFSM[7] = {'��������','��ɫָ����١�ʹȫ�������ܵ�����������������50���˺�������������ϵ�����״̬ ����������ѧ������+40%,������+40%����������ѧ����+500�� ',2,1,3} --��̫��
	CC.PTFSM[6] = {'��ü����','ʹ���κ��书���������ر������ƶ�����+3�� ',2,1,2}  --���
	CC.PTFSM[5] = {'̫����ʦ','�����˺�ɱ���������������˺������������ˣ�̫��ȭ����ʱ�����ܽ�������Ч����̫�����巢�������������ʹ̶�Ϊ85%����̫����������Ҫ������ ',2,1,4} --������
	CC.PTFSM[4] = {'����ҽ��','ҽ����������300���ö���������300�������ũ�Ĺ����и��Ӵ��������˵з���ɻ�������� ',2,1,1} --�ֻ�
	CC.PTFSM[3] = {'�����','����ʱ�߼��ʸ������գ�ÿ100������ϵ��������ҽ���������Χ1�񣬹���ʱ���ʸ�Ŀ�����ɢ��10ʱ��*����Ե������ѩɽ�ɺ��������ؾ��飬��ѡ��ϴ�ڶ����书���츳�Ṧ�� ',2,1,3} --���˷�
	CC.PTFSM[2] = {'��������','ҽ����������400���ö���������500������ʱ��ʹɱ���з���Ҳ�����ж����� ',2,1,4} --������
	CC.PTFSM[1] = {'ѩɽ�ɺ�','�����ٶ�����8�㣬��ɫָ��ɺ����������ϰ����ƶ�����ս������ȥ���硣*����Ե�������õ���ѩɽ�ɺ����������˷��ϴ�ڶ����书 ',2,1,3} -- ���
	--CC.PTFSM[0] = {'��������','����������ר��������֮����ս�������޿��Ի�ò���֮���е�һ�֡�',2,1,3}  --����
    -- ��1�츳���ƣ���2�츳˵������3ΪΪ1��ר��2Ϊר������4Ϊ1�Ƿ����츳Ϊ2�������츳����5Ϊ�츳�ȼ�(1��2��3��4��)
    CC.Tiangtf = {}
	for i = 9725,9999 do 
		if CC.PTFSM[i][3] == 1 then 
			CC.Tiangtf[#CC.Tiangtf+1] = i
		end
	end

    --�����츳
    local MPTF = {}
    MPTF[1] = {400,461,479,655,597,657}
    MPTF[2] = {400,461,479,655,597,657}

    CC.PTF = {}
    --ǰ���Ӧһ�µı�ű�ʾ������
    --����CC.PTF[0] �� [0] = 1 �е�0����ʾ����ID��
    --ǰ���Ӧһ�µı�ű�ʾ������
    --����CC.PTF[0] �� [0] = 1 �е�0����ʾ����ID��
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
    CC.PTF[722] = {[722] = 1,[9937] = 1}	--����޸�
    CC.PTF[723] = {[723] = 1}
    CC.PTF[724] = {[724] = 1}
    CC.PTF[725] = {[725] = 1}
    CC.PTF[726] = {[726] = 1}
    CC.PTF[727] = {[727] = 1}
    CC.PTF[728] = {[728] = 1}
    CC.PTF[729] = {[729] = 1}
    CC.PTF[730] = {[730] = 1}
    CC.PTF[731] = {[731] = 1,[9923] = 1}	--����޸�
    CC.PTF[732] = {[732] = 1,[9915] = 1}	--����޸�
    CC.PTF[733] = {[733] = 1}
    CC.PTF[734] = {[734] = 1}
    CC.PTF[735] = {[735] = 1}
    CC.PTF[736] = {[736] = 1}
    CC.PTF[737] = {[737] = 1,[9937] = 1}	--����޸�
    CC.PTF[738] = {[738] = 1,[9924] = 1}
    CC.PTF[739] = {[739] = 1,[9922] = 1}	--����޸�
    CC.PTF[740] = {[740] = 1,[9921] = 1}	--����޸�
    CC.PTF[741] = {[741] = 1,[9920] = 1}	--����޸�
    CC.PTF[742] = {[742] = 1,[9914] = 1}--����޸�
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
    --1���ƣ�2�������ƣ�3�������ԣ�4˵����5�ȼ���6�������ͣ�1Ϊ���ԣ�2Ϊ��Ʒ��3ΪTF��,7��óɾ�Ϊ1δ���Ϊ0
    CC.Personcj[1] = {"һ�ﵱǧ","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",4,1,1} 
    CC.Personcj[2] = {"�ɾͶ�","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",4,1,0}
    CC.Personcj[3] = {"�ɾ���","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",5,1,0}
    CC.Personcj[4] = {"�ɾ���","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",2,1,0}
    CC.Personcj[5] = {"�ɾ���","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",1,1,0}
    CC.Personcj[6] = {"�ɾ���","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",2,1,0}
    CC.Personcj[7] = {"�ɾ���","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",5,1,0}
    CC.Personcj[8] = {"�ɾͰ�","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",4,1,0}
    CC.Personcj[9] = {"�ɾ;�","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",3,1,0}
    CC.Personcj[10] = {"�ɾ�ʮ","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",3,1,0}
    CC.Personcj[11] = {"�ɾ�ʮһ","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",3,1,0}
    CC.Personcj[12] = {"�ɾ�ʮ��","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",4,1,0} 
    CC.Personcj[13] = {"�ɾ�ʮ��","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",4,1,0}
    CC.Personcj[14] = {"�ɾ�ʮ��","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",5,1,0}
    CC.Personcj[15] = {"�ɾ�ʮ��","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",2,1,0}
    CC.Personcj[16] = {"�ɾ�ʮ��","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",1,1,0}
    CC.Personcj[17] = {"�ɾ�ʮ��","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",2,1,0}
    CC.Personcj[18] = {"�ɾ�ʮ��","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",5,1,0}
    CC.Personcj[19] = {"�ɾ�ʮ��","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",4,1,0}
    CC.Personcj[20] = {"�ɾͶ�ʮ","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",3,1,0}
    CC.Personcj[21] = {"�ɾͶ�ʮһ","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",3,1,0}
    CC.Personcj[22] = {"�ɾͶ�ʮ��","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",3,1,0}
    CC.Personcj[23] = {"һ�ﵱǧ","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",4,1,0} 
    CC.Personcj[24] = {"�ɾͶ�","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",4,1,0}
    CC.Personcj[25] = {"�ɾ���","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",5,1,0}
    CC.Personcj[26] = {"�ɾ���","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",2,1,0}
    CC.Personcj[27] = {"�ɾ���","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",1,1,0}
    CC.Personcj[28] = {"�ɾ���","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",2,1,0}
    CC.Personcj[29] = {"�ɾ���","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",5,1,0}
    CC.Personcj[30] = {"�ɾͰ�","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",4,1,0}
    CC.Personcj[31] = {"�ɾ;�","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",3,1,0}
    CC.Personcj[32] = {"�ɾ�ʮ","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",3,1,0}
    CC.Personcj[33] = {"�ɾ�ʮһ","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",3,1,0}
    CC.Personcj[34] = {"�ɾ�ʮ��","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",4,1,0}
    CC.Personcj[35] = {"�ɾ�ʮ��","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",4,1,0}
    CC.Personcj[36] = {"�ɾ�ʮ��","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",5,1,0}
    CC.Personcj[37] = {"�ɾ�ʮ��","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",2,1,0}
    CC.Personcj[38] = {"�ɾ�ʮ��","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",1,1,0}
    CC.Personcj[39] = {"�ɾ�ʮ��","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",2,1,0}
    CC.Personcj[40] = {"�ɾ�ʮ��","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",5,1,0}
    CC.Personcj[41] = {"�ɾ�ʮ��","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",4,1,0}
    CC.Personcj[42] = {"�ɾͶ�ʮ","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",3,1,0}
    CC.Personcj[43] = {"�ɾͶ�ʮһ","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",3,1,0}
    CC.Personcj[44] = {"�ɾͶ�ʮ��","������",2,"��������ս�У�ֻ�������������غ��ڻ����ɸ硣",3,1,0}

end

--ɾ��ָ��Ԫ��
function removebyvalue(array, value, removeadll)
	--    table��ɾ��ָ��Ԫ��(�Ǹ�������)
	--    array Ҫ����������
	--    value ɾ��valueֵ
	--    removeadll �Ƿ�ɾ��������ͬ��ֵ
	--    ����ɾ��ֵ�ĸ���
    --    deleteNum���ڽ���/����ɾ������; i/max ���ɿ���whileѭ��
    local deleteNum,i,max=0,1,#array
    while i<=max do
        if array[i] == value then
            --    ͨ�������������ɾ��Ԫ��
            table.remove(array,i)
            --    ���ɾ������
            deleteNum = deleteNum+1 
            i = i-1
            --    ����whileѭ������
            max = max-1
            --    �ж��Ƿ�ɾ��������ͬ��valueֵ
			if not removeadll then 
				break 
			end
        end
        i= i+1
    end
    --    ����ɾ������
    return deleteNum
end

--ɾ���൱Ԫ��
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
-- ����1��ʹ�ø������¼�ѳ��ֵ�Ԫ�أ������ڿɹ�ϣ��Ԫ�أ�
function removeDuplicates(array)
    local seen = {}  -- ��¼�ѳ��ֵ�Ԫ��
    local result = {}
    
    for _, value in ipairs(array) do
        if not seen[value] then
            table.insert(result, value)
            seen[value] = true
        end
    end
    
    return result
end

--����������� ����
function MpRwfenlei()
	local s = CONFIG.CurrentPath.."mprw"
	local file = io.open(s, "w");
	assert(file);
	local a = {}
	for i = 0,JY.PersonNum - 1 do 
		if JY.Person[i]['����'] >= 0 then 
			local n = JY.Person[i]['����']
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

--�����书���� ����
function MpKffenlei()
	local s = CONFIG.CurrentPath.."mpkf"
	local file = io.open(s, "w");
	assert(file);
	local a = {}
	for i = 0,JY.WugongNum - 1 do 
		if JY.Wugong[i]['����'] >= 0 and i > 0 then 
			local n = JY.Wugong[i]['����']
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

--�Ϲ��̵�
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
		SHUOMING[#SHUOMING+1] = JY.Thing[menu[i][1]]['��Ʒ˵��']
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
	local sm = {'�͹٣�������*Ʒ��һ������*���˲�����','�͹٣���Ī��*С�����ӣ���*��Ų����ˡ�','�͹٣�һ����*����Թ���*ʮ�����Ʒ��'}
	local size = CC.Fontsmall
	while true do
		if JY.Restart == 1 then 
			break 
		end
		Cls()
		lib.LoadPNG(91,10*2,0,0,1)
		lib.DrawStr(CC.ScreenW/2-w/2,h/5+h/50,'�� Ŀ �� ��',C_GOLD,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)

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
				DrawString(CC.ScreenW-x1-h/3,h-h/3,'��Ʒ����: ',C_CYGOLD,size*0.9)
				DrawString(CC.ScreenW-x1+w,h-h/3,JY.Thing[menu1[thingid]]['����'],M_DeepSkyBlue,size*0.9)
				DrawString(CC.ScreenW-x1+w*2,h-h/3,'       ���ۣ�',C_CYGOLD,size*0.9)
				DrawString(CC.ScreenW-x1+w*3+w/2,h-h/3,danjia[thingid],M_DeepSkyBlue,size*0.9)
				DrawString(CC.ScreenW-x1-h/3,h,'Ч���� '..SHUOMING[thingid],C_RED,size*0.9)
			end
			n = n + 1 
			if n == 5 then 
				m = m + 1
				n = 0
			end
		end
		n = 0
		m = 0
		lib.DrawStr(CC.ScreenW-x1,h+h*5+h/2,'�� �'..zongjia..'/'..Currency..'('..Currency_wz..')',C_CYGOLD,size*0.8, CONFIG.CurrentPath.."FONT/3.TTF",  0, 0)
		lib.DrawStr(CC.ScreenW-x1+w*3+w*2/3,h+h*5+h/2,'ҳ����'..pg..'/'..pgnum,C_CYGOLD,size*0.8, CONFIG.CurrentPath.."FONT/3.TTF",  0, 0)
		lib.Background(x1+w/10,y/10-y/15,CC.ScreenW-w/10,CC.ScreenH-h*2/3,98)
		lib.DrawStr(CC.ScreenW/2+w*4,h/5,'�� �� ��',M_DeepSkyBlue,size*1.2, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)	
		lib.DrawStr(CC.ScreenW-w*4,h*6,'�� �ۣ�',M_DeepSkyBlue,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)	
		lib.DrawStr(CC.ScreenW-w*3,h*6,zongjia..'('..Currency_wz..')',C_RED,size, CONFIG.CurrentPath.."FONT/0.TTF",  0, 0)		
		for i = 1,#goumenu do 					
			DrawString(CC.ScreenW-w*4,h-h/3+(i-1)*h*4/10,JY.Thing[menu1[goumenu[i]]]['����'],C_CYGOLD,size)
			DrawString(CC.ScreenW-w*2,h-h/3+(i-1)*h*4/10,gounum[goumenu[i]]/gounum[goumenu[i]],C_CYGOLD,size)
			DrawString(CC.ScreenW-w,h-h/3+(i-1)*h*4/10,danjia[goumenu[i]],C_CYGOLD,size)
		end
		for i = 1,2 do 
			local jzw = {"����",'�˳�'}
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
						--CC.Sp = JY.Base["��Ƭ"]
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

--������츳
function TGTF()
    local tb = 1
	local tb1 = 0
    local size = CC.DefaultFont*0.7
    local pg = 1
    local menu = {}
	local w1,h1 = lib.GetPNGXY(91,139*2)
    local w = math.modf(w1/size)
	local zm = JY.Base["��Ŀ"]
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
	local fymenu = {'��һҳ','��һҳ','ȷ  ��','ɾ  ��','��  ��'}
	local tfmax = 0
	local tfn = 0
	local xzmenu = 0
	local xzid = '��'
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
		local str = '����츳��ȫ'
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
			fymenu = {'��һҳ','��һҳ'}
		end
		for i = 1,#fymenu do 
			local cl = C_WHITE1	
			if tb1 == i  then 
				cl = C_RED
			end
			lib.Background(x1+(i-2)*xx-w1/2,y1+(hnum)*yy-h1/2+hh1,x1+(i-2)*xx-w1/2+w1,y1+(hnum)*yy-h1/2+h1+hh1,98)
			DrawString(x1+(i-2)*xx-string.len(fymenu[i])/4*size,y1+(hnum)*yy-h1/3+hh1,fymenu[i],cl,size)
		end
		DrawString(x1+(3-2)*xx-string.len(fymenu[1])/4*size,y1+(hnum)*yy-h1/3+hh1,'��ɫ���ֵ����ѻ�õ��츳����ɫ��û�л�õ��츳',M_LightBlue,size)
		local pgwz = 'ҳ���� '..pg..' / '..num 
		DrawString(x1+xx*3+-string.len(pgwz)/4*size,h1*2/3,pgwz,M_DeepSkyBlue,size)
		local tfh = 0
		local tfsm = 0
		--ѡ���츳�鿴
		local tfid = CC.PTFSM[menu[tb + (pg-1)*lbnum][1]]
		DrawString(x1/12,y1-yy-h1/3,'�츳���ƣ� ',C_WHITE1,size)
		DrawString(x1/5-string.len(tfid[1])/4*size+size*4,y1-yy-h1/3,tfid[1],M_DeepSkyBlue,size)
		tfsm = tfsm + 1
		tfsm = tjm(x1/12,y1-yy+h1,tfid[2],C_WHITE,size,9,size)
		
		for i = 1,#xzme do
			if xzme[i] ~= nil then 
				local xid = xzme[i]
				local xidwz = CC.PTFSM[xid][1]
				DrawString(x1/12,y1-yy-h1/3+y1*2+size*3,'��ѡ�츳�� ',C_WHITE1,size)
				DrawString(x1/4-string.len(xidwz)/4*size,y1-yy-h1/3+y1*2+size*2+(i-1)*size*2+size*3,xidwz,M_DeepSkyBlue,size)
			end
		end	

		if sme == 1 then 
			DrawString(x1/12+size*9,CC.ScreenH-size*7,'�޷�ѡ������츳����������һ����������Ϸ',C_RED,size*2)
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


--�书ͼ��˵��
function KF_sm(id,kf)
	local bx,by = CC.ScreenW/1360,CC.ScreenH/768
	local STARTH1,WGSTARTH,WGSTARTH1,Mstarth =0,0,0,0
	local FY1,h,h2,SHUOMING,xlsm,Mfy = 0,0,0,0,0,0
	local zsnum ,hg,sf,FY,WGFY,WGFY1= 0,40,0,0,0,0
	local size = CC.DefaultFont*0.9
	local wgzbx,wgzby = CC.ScreenW/3,CC.ScreenH/2 - size*6.5
	local jjwz = {"�����ž�", "�����ž�", "����С��", "����С��", "����Ѿ�", "����Ѿ�", "�ڻ��ͨ", "�ڻ��ͨ", "¯����", "¯����", "�Ƿ��켫"}
	local djwz = {"һ", "��", "��", "��", "��", "��", "��", "��", "��", "ʮ", "��"}
	local pjwz = {"��".."�����书","��".."�н��书","��".."�߽��书","��".."��ѧ�书"}	
	local zsh,zsw = size*1.5,size*1.1 --��ʽ���ֵ������������
	local smtb1 = 1
	local smtb2 = 0 
	local function wugong_info(thingID)
		----lib.Debug(thingID);
		local h1 = 0
		local me = {}
		local hs1 = 0
		local myh1 = 7
		local mm = 1
		if JY.Thing[thingID]["�����书"] > 0 then
			mm = 2
		end		
		lib.LoadPNG(91,372*2,wgzbx-size*2,wgzby-CC.ScreenH/2.8,1)
		local function strcolor_switch(s)
			local Color_Switch={{"��",PinkRed},{"��",M_Wheat},{"��",C_BLACK},{"��",RGB(178,158,124)},{"��",C_ORANGE},{"��",LimeGreen},{"��",M_DeepSkyBlue},{"��",Violet}}
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
					me[#me+1] = "��"
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
			if string.sub(tfstr,1,2) == "��" then
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
			local Color_Switch={{"��",PinkRed},{"��",M_Wheat},{"��",C_BLACK},{"��",RGB(178,158,124)},{"��",C_ORANGE},{"��",LimeGreen},{"��",M_DeepSkyBlue},{"��",Violet}}
			for i = 1, 8 do
				if Color_Switch[i][1] == s then
					return Color_Switch[i][2]
				end
			end
		end
		for i =1,10 do 
			local kftx = JY.Wugong[kf]['��Ч'..i]
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
			if string.sub(tfstr,1,2) == "��" then
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
	local mpgx = math.modf(JY.Person[id]['���ɹ���']/200)+1
	local kfcj = JY.Wugong[kf]['�㼶']
	local jxkf = 2
	local cxfj = JY.Person[id]['����ֽ�']
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
		xzwz = {'ѧϰ','����'}

	end
	CC.KFMove[kf][1][3] = 0
	local kf1 = kf 
	local leixing = {91,92,93,94,95,96}
	local lxpic = leixing[JY.Wugong[kf1]["�书����"]]
	--��Ʒ˵����ʾ
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
			local me = JY.Wugong[kf1]["����"]
			local wgmp =  MPname[JY.Wugong[kf1]["����"] + 1]
			local level = 11
			local wugongwl = get_skill_power(id, kf1, level)
			local mz = JY.Wugong[kf1]["������"]
			local wz2 = {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15",}						
			if  kf1 > 0 then			
				cl = C_RED	
				local jg1 = size*1.1			
				--�书��ʽ
				local wgbj = 0
				if 	JY.Wugong[kf1]["�书����"] < 6 then
					wgbj = 286
				else
					wgbj = 287
				end
				if kfsm == 2 then 
					wgbj = 287 
				end
				--���书˵������ͼ
				wgbj = 368
				local kfcj1 = JY.Wugong[kf1]["�㼶"]
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
				if JY.Wugong[kf1]['�书����'] < 6  then 
					if kfsm == 1 then 
						lib.LoadPNG(91,369*2,wgzbx-size*2,wgzby-size*10.5,1)  -- ��ʽ����
						--lib.Background(wgzbx-size*2,wgzby-size*10.5,wgzbx-size*2+bx*400,wgzby-size*10.5+by*100,98)
						lib.LoadPNG(91,14*2,wgzbx+CC.ScreenW/2.9,wgzby+size*4,1,0,80)  -- �л��书˵��ͼƬ
					end
				end
				lib.LoadPNG(91,371*2,wgzbx+size*8,wgzby-size/2,1,0,90)  -- �书���ֱ���
				lib.LoadPNG(91,(373+kfcj1)*2,wgzbx-size*2,wgzby-size/1.5,1,0,100)  -- �书�׼�ͼƬ		
				lib.DrawStr(wgzbx-string.len(JY.Wugong[kf1]["����"])/4*size+size*11,wgzby,JY.Wugong[kf1]["����"], wgcl,size*1.8, CONFIG.CurrentPath.."FONT/2.TTF",  0, 0)	--�书������ʾ	
					
				local neishu = nil 
				if KF_thing(kf1) ~= nil then 
					 neishu = JY.Thing[KF_thing(kf1)]['����������']
				else 
					neishu = 2
				end
				local neishuwz = {'��','��','����'}
				local neishuwz1 = neishuwz[neishu+1]
				local wglx = {'��'..neishuwz1..'ȭ','��'..neishuwz1..'ָ','��'..neishuwz1..'��','��'..neishuwz1..'��','��'..neishuwz1..'��','��'..neishuwz1..'��','��'..neishuwz1..'��'}
				local wgsize = size*0.8
				local gdz = JY.Wugong[kf1]["�㼶"]*level
				local sm = JY.Wugong[kf1]["�㼶"]*100+wugongwl
				local hq = 0
				if JY.Wugong[kf1]["�㼶"] == 4 then
					hq = 2
				elseif JY.Wugong[kf1]["�㼶"] == 3 then
					hq = "1~2"
				elseif JY.Wugong[kf1]["�㼶"] == 2 then
					hq = 1
				elseif JY.Wugong[kf1]["�㼶"] == 1 then
					hq = "0~1"								
				end	
				if 	JY.Wugong[kf1]["�书����"] < 6 then
					pwz1 = "����"..":  "..math.modf(wugongwl)
					pwz2 = "����"..":  "..mz
					pwz3 = "��"..":  "..gdz
					pwz4 = ""
				elseif JY.Wugong[kf1]["�书����"] == 6 then
					pwz1 = "����"..":  "..sm
					pwz2 = "����"..":  "..math.modf(wugongwl)
					pwz3 = "��"..":  "..gdz
					pwz4 = "����"..":  "..hq
				else
					pwz1 = "����"..":  "..JY.Wugong[kf1]["������"]
					pwz2 = "����"..":  "..JY.Wugong[kf1]["������"]
					pwz3 = "�ƶ�"..":  "..""
					pwz4 = "����"..":  "..""
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
								--�޾Ʋ�����װ������ֵ��ȼ��仯
								if myThing["װ��λ��"] > -1 then
									local attr_gain = 0;
									if myThing[ss] > 0 then
										attr_gain = myThing[ss]*10 + myThing[ss]*(myThing["װ���ȼ�"]-1)*2
									elseif myThing[ss] < 0 then
										attr_gain = myThing[ss]*10 - myThing[ss]*(myThing["װ���ȼ�"]-1)*2
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
								local wugong = JY.Thing[id]["�����书"];
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
						--������ɫ
						if myThing[ss]==1 and ss=="����������" then
							color = RGB(236, 200, 40)
						elseif myThing[ss]==2 and ss=="����������" then
							color = RGB(236, 236, 236)
						end
					elseif myThing[ss]==0 and ss=="����������" then
						mys=string.format(str..':%s',news[myThing[ss]])
						mys = str..news[myThing[ss]]
						color = RGB(208, 152, 208)
					else
						return
					end
					--DrawString(mx+CC.MenuBorderPixel,my+CC.MenuBorderPixel+CC.ScreenH/1.5,mys,color,myfont)
					pwz5 = pwz5..' '..mys
				end
				if myThing['����'] > 0 then
					if thid> 343 or thid < 348 then	--����ҩƷ����ʾ
						--DrawString(wgzbx, y3_2 + 2+CC.MenuBorderPixel+CC.ScreenH/1.5, " Ч��:", LimeGreen, myfont)
						pwz6 = "���ԣ�"
					end	
					if myThing['���������ֵ'] > 0 then 
						pwz6 = pwz6..' '..'����+'..myThing['���������ֵ']
					end
					if myThing['�ı���������'] == 2 then 
						pwz6 = pwz6..' '..'�������Ա�Ϊ����'
					end
					if myThing['�ӹ�����'] > 0 then 
						pwz6 = pwz6..' '..'����+'..myThing['�ӹ�����']
					end
					if myThing['�ӷ�����'] > 0 then 
						pwz6 = pwz6..' '..'����+'..myThing['�ӷ�����']
					end
					if myThing['���Ṧ'] > 0 then 
						pwz6 = pwz6..' '..'�Ṧ+'..myThing['���Ṧ']
					end
					if myThing['��ҽ������'] > 0 then 
						pwz6 = pwz6..' '..'ҽ��+'..myThing['��ҽ������']
					end
					if myThing['���ö�����'] > 0 then 
						pwz6 = pwz6..' '..'�ö�+'..myThing['���ö�����']
					end
					if myThing['�ӽⶾ����'] > 0 then 
						pwz6 = pwz6..' '..'�ⶾ+'..myThing['�ӽⶾ����']
					end
					if myThing['�ӿ�������'] > 0 then 
						pwz6 = pwz6..' '..'����+'..myThing['�ӿ�������']
					end
					if myThing['��ȭ�ƹ���'] > 0 then 
						pwz6 = pwz6..' '..'ȭ��+'..myThing['��ȭ�ƹ���']
					end
					if myThing['��ָ������'] > 0 then 
						pwz6 = pwz6..' '..'ָ��+'..myThing['��ָ������']
					end
					if myThing['����������'] > 0 then 
						pwz6 = pwz6..' '..'����+'..myThing['����������']
					end
					if myThing['��ˣ������'] > 0 then 
						pwz6 = pwz6..' '..'ˣ��+'..myThing['��ˣ������']
					end
					if myThing['���������'] > 0 then 
						pwz6 = pwz6..' '..'�������+'..myThing['���������']
					end
					if myThing['�Ӱ�������'] > 0 then 
						pwz6 = pwz6..' '..'����+'..myThing['�Ӱ�������']
					end
					if myThing['����ѧ��ʶ'] > 0 then 
						pwz6 = pwz6..' '..'�䳣+'..myThing['����ѧ��ʶ']
					end
					if myThing['�ӹ�������'] > 0 then 
						pwz6 = pwz6..' '..'����+'..myThing['�ӹ�������']
					end
					if myThing['�ӹ�������'] > 0 then 
						pwz6 = pwz6..' '..'����+'..myThing['�ӹ�������']
					end				
					--����װ�������ӳ�
					for i,v in ipairs(CC.ExtraOffense) do
						if v[1] == thid then
							--DrawString(mx+CC.MenuBorderPixel+CC.ScreenW/68.4,my+CC.MenuBorderPixel+CC.ScreenH/1.5,"����ǿ��:"..JY.Wugong[v[2]]["����"].."+"..v[3],PinkRed,myfont)
						end
					end

				end
				--����:
				if myThing['����']==2 then
					pwz5 = '����:'
					if myThing['����������']>-1 then
						drawitem('����:'..JY.Person[myThing['����������']]['����'])
					end
					drawitem('����������','����',{[0]='��','��','����'})
					drawitem('������','����')
					drawitem('�蹥����','����')
					drawitem('���Ṧ','�Ṧ')
					drawitem('���ö�����','�ö�')
					drawitem('��ҽ������','ҽ��')
					drawitem('��ȭ�ƹ���','ȭ��')
					drawitem('��ָ������','ָ��')
					drawitem('����������','����')
					drawitem('��ˣ������','ˣ��')
					drawitem('���������','����')
					drawitem('�谵������','����')
					if thid == 372 then 
						drawitem('��80>����>30')
					end
					--��ת����ʾ
					local exstr = ''
					if thid == 118 then
						exstr = "��ϵ����ֵ֮��>=120 "						
					end
					--��������ʾ
					if thid == 176 then
						exstr = "����/ˣ��/������һ��>=70 "
					end
					pwz5 = pwz5..' '..exstr
					local wugong = JY.Thing[thid]["�����书"]	
					drawitem('������','����')
					--DrawString(dx+CC.MenuBorderPixel+CC.ScreenW/68.4,my2+CC.MenuBorderPixel+CC.ScreenH/1.5,' ����:',LimeGreen,myfont)	
						
				end
				DrawString(wgzbx,wgzby,"����"..":  "..wgmp..' '..wglx[JY.Wugong[kf1]['�书����']],C_BLACK,wgsize)  --���� ��һ������
				DrawString(wgzbx,wgzby+jg1,"��Ϊ"..":  "..jjwz[level].." ".."("..djwz[level]..")",C_BLACK,wgsize)  --��Ϊ �ڶ�������
				DrawString(wgzbx,wgzby+jg1*2,pwz1,C_BLACK,wgsize) --����������
				DrawString(wgzbx,wgzby+jg1*3,pwz2,C_BLACK,wgsize) --����������
				DrawString(wgzbx,wgzby+jg1*4,pwz3..'   '..pwz4,C_BLACK,wgsize) --����������
				DrawString(wgzbx,wgzby+jg1*5,pwz5,C_BLACK,wgsize) --����������
				DrawString(wgzbx,wgzby+jg1*6,pwz6,C_BLACK,wgsize) --����������
				--DrawString(wgzbx,wgzby+jg1*5,pwz4,C_WHITE,wgsize) --����������
				local wglx2 = {'ȭ��','ָ��','����','����','����','�ڹ�','�Ṧ',}
				local wgcj = {'����','�н�','�߽�','��ѧ',}
				local lx3 = JY.Wugong[kf1]['�书����']	
				local wgcj1 = wgcj[JY.Wugong[kf1]['�㼶']]
				local kfsmwz = wgmp..wgcj1..wglx2[lx3]
				local kfx,kfy = size*8,size*2	
				if KF_thing(kf1) ~= nil then 												
					--local size5 = CC.FONT2
					local row = 1
					local fy = 0
					local h = 0	
					if JY.Thing[KF_thing(kf1)]["��Ʒ˵��"] ~= nil then
						--DrawString(wgzbx+kfx,wgzby+size*2.2,JY.Thing[KF_thing(kf1)]["��Ʒ˵��"],C_WHITE,wgsize)
						h=tjm(wgzbx+kfx, wgzby +size*1.7 + size * (row-fy), '��'..JY.Thing[KF_thing(kf1)]["��Ʒ˵��"], C_BLACK,wgsize*0.9,11,wgsize*1.7,fy-row,40)	
						row = row + h
					else
						--DrawString(wgzbx+kfx,wgzby+size*2.2,'��'..kfsmwz,color,wgsize)
						h=tjm(wgzbx+kfx, wgzby +size*1.7 + size * (row-fy), '��'..kfsmwz, C_BLACK,wgsize,9,wgsize*1.5,fy-row,40)	
						row = row + h
					end
				else 
					DrawString(wgzbx+kfx,wgzby+size*2.2,kfsmwz,C_BLACK,wgsize)
				end
				if kfsm == 1 then						
					if JY.Wugong[kf1]["�书����"] < 6 then						
						for j = 1,#CC.KFMove[kf1]  do

							--lib.Debug('menu1[5]=='..menu1[5])
							local zsnum = CC.WUGONGZS[1][j]
							if JY.Person[id]["�书��ʽ"..zsnum] == 0 then
								lib.LoadPNG(91,lxpic*2,wgzbx+(j-1)*CC.ScreenW/30-CC.ScreenW/80,wgzby+CC.ScreenH/2.2,1,0,90)
							else
								lib.LoadPNG(98,(500+kf1)*2,wgzbx+(j-1)*CC.ScreenW/30-CC.ScreenW/80,wgzby+CC.ScreenH/2.2,1,0,90)
							end
							local zssm = {}
							local CAOZSM = {}  
							local zsn = #CC.KFMove[kf1]
							local function Atk(id)
								local gj = 0
								gj = gj + JY.Person[id]['������']
								----lib.Debug('���﹥����'..gj)	
								local nlgj = limitX((JY.Person[id]['����'] - JY.Person[id]['����']*10)/60,0)
								----lib.Debug('�����ӳɹ�����'..nlgj)	
								gj  = gj + nlgj	
								gj = gj + FJGONGJ(id)
								----lib.Debug('װ���ӳɹ�����'..FJGONGJ(id))	
								return gj
							end
							local atk = Atk(id)
							local zzz = smtb1
							if zzz > 6 then
								zzz = 6
							end
							local nnn =  wugongwl*(1+(zzz-1)/10)
							local sz = math.ceil(atk*(1+nnn/2000))
							local sznum = {"һ","��","��","��","��","��","��","��","��","ʮ"}
							local wz1 = "��ɻ����˺�"..'��'..sz.."��".."�㡣"
							--lib.Debug('kf1=='..kf1..' tb =='..tb..' #CC.KFMove[kf1]=='..#CC.KFMove[kf1])
							local zsname = CC.KFMove[kf1][j][1] 
							local zswz = nil
							local zswz1 = nil

							if smtb1 == j then
								lib.LoadPNG(91,88*2,wgzbx+(j-1)*CC.ScreenW/30-CC.ScreenW/80,wgzby+CC.ScreenH/2.2,1,0,95)
								tjm(zsw + wgzbx-size,zsh+wgzby+size*7,"��"..JY.Wugong[kf1]["����"].."�׵ڣ�"..sznum[smtb1].."����:��"..zsname,C_WHITE,wgsize,30,wgsize)
								tjm(zsw + wgzbx+size*8,zsh+wgzby+size*7,"��    ���� ��"..CC.KFMove[kf1][j][3],C_WHITE,wgsize,30,wgsize)																								
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
						if JY.Wugong[kf1]['��Ч1'] > 0 then
							--lib.Debug(kf1..'�ж��ɹ�1') 
							wugong_info1(kf1)
						else
							if KF_thing(kf1) ~= nil then 
								--lib.Debug(kf1..'�ж��ɹ�2') 
								wugong_info(KF_thing(kf1))
							end
						end
					end
				elseif  kfsm == 2 then 
					if JY.Wugong[kf1]['��Ч1'] > 0 then
						--lib.Debug(kf1..'�ж��ɹ�1') 
						wugong_info1(kf1)
					else
						if KF_thing(kf1) ~= nil then 
							--lib.Debug(kf1..'�ж��ɹ�2') 
							wugong_info(KF_thing(kf1))
						end
					end
				end					
				local r = 0
				if level <= 9 then
					if KF_thing(kf1) ~= nil then 
						r=math.modf((5-math.modf(25/25))*JY.Thing[KF_thing(kf1)]["�辭��"]*(level+1)*0.05);
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
			--lib.LoadPNG(91,14*2,wgzbx+CC.ScreenW/2.9,wgzby+size*4,1,0,80)  -- �л��书˵��ͼƬ
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


--��Ϸ˵��
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
	local Tmenu = {'��    ��','��    ��','��    ��','��    ��','��    ��','��    Ʒ','״̬˵��','��    ��'}
	local JQmenu = {'�������','֧�߾���','����ָ��'}
	--�������ͼƬ���� 1,��һ�ţ�2�ڶ��ţ�3��������
	local tpic = {
	{381,387,'�ɺ��⴫'},{388,389,'ѩɽ�ɺ�'},{390,394,'���Ǿ�'},{395,410,'�����˲�'},{411,422,'���Ӣ�۴�'},{423,425,'����Х����'},{426,429,'¹����'},
	{430,440,'Ц������'},{441,449,'�齣����¼'},{450,460,'�������'},{461,466,'������'},{467,481,'����������'},{482,487,'��Ѫ��'},{488,490,'ԧ�쵶'}
				} --�������ͼƬ
	local fy = 5
	local tsname = ''
	local RWmenu ={'ȫ����','��','��ʦ','����','һ��','����','����'}
	local KFmenu = {'ȭ��','ָ��','����','����','����','�ڹ�','�Ṧ'}
	local Thmenu ={'�ؼ�','װ��','����','ҩƷ��ʳ'}
	local KFmenu= {"ȭ��","ָ��","����","����","����","�ڹ�","�Ṧ"}
	local thmenu = {'����','װ��','�ؼ�','ҩʳ','����'}
	local mpmenu = {'��������','�����⹦','�����ڹ�','��������'}
	local mpperson = {}
	--1��pg=1��������2��pg������3��pg=2������
	local pmax = {{14,3,3}, 		--����
					{0,1,1}, 			--����
					{4,3,#MPname},		--����
					{#KFmenu,2,#KFmenu},--�书
					{0,1,0},            --�ؼ�
					{#thmenu,2,#thmenu},--��Ʒ
					{1,1,0},			--״̬˵��
					{0,0,0}} 			--����
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
					DrawString(CC.ScreenW-size*3.5,size/2,page..'/'..fy_max..'ҳ',C_BLACK,size,CC.FONT2)
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
				DrawString(CC.ScreenW-size*3.5,size/2,page..'/'..fy_max..'ҳ',C_BLACK,size,CC.FONT2)	
			end
		elseif tb == 2 then 
			if pg == 1 then 
				local menu = {}
				for i = 1, JY.PersonNum - 1 do
					if JY.Person[i]['����'] ~= '����' and JY.Person[i]['����'] ~= '����ռ��'  and JY.Person[i]['����'] ~= '����ռ��' then 
						menu[#menu+1] = {JY.Person[i]['����'],nil,1,i} 
					end
				end 
				for i = 1,#menu do 
					local clone_choice = ShowMenu4(menu,#menu,8,-2,-2,-2,-2,-2,1,CC.DefaultFont*0.9,C_GOLD,C_WHITE,"��ѡ��ҪҪ�鿴������",C_ORANGE, C_WHITE,15)	
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
						local name = JY.Person[pid]['����'] 
						if name ~= '����' and name ~= '����ռ��' and name ~= '����ռ��' and name ~= '��ħ' and name ~= '����ˮ����' and pid ~= 591  and pid ~= 0  then 
							mp2[#mp2+1] = {name,nil,1,pid} 
						end
					end
					local clone_choice = ShowMenu4(mp2,#mp2,8,-2,-2,-2,-2,-2,1,CC.DefaultFont*0.9,C_GOLD,C_WHITE,MP_name(tid)..'����鿴',C_ORANGE, C_WHITE,15)	
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
				local kflx = {'ȭ    ��','ָ    ��','��    ��','��    ��','�������','��    ��','��   ��',}
				local slmenu = {}
				local kfmenu = {}
				local nexty = CC.ScreenH/2-CC.DefaultFont*4 + CC.SingleLineHeight
				for i = 1, JY.WugongNum - 1 do
					if  JY.Wugong[i]["�书����"] == tb1  then
						slmenu[i] = {JY.Wugong[i]["����"],nil,1}
						kfmenu[#kfmenu+1] = {i,1,JY.Wugong[i]['�㼶'],JY.Wugong[i]['������10']}
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
					local kfname = JY.Teji[i]['����']
					if kfname ~= '��' and kfname ~= '����' then
						menu[i] = {kfname,nil,1,i}
					end
				end
				for i = 1,#menu do 
					local R = ShowMenu2(menu, #menu, 5, 17, CC.ScreenW/2-CC.DefaultFont*13, CC.ScreenH/2-CC.DefaultFont*10, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE,"�ؼ���ȫ")
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
					--local thid = JY.Base["��Ʒ" .. i + 1]
					if i > 0 then 
						if k[i]["����"] == tb1-1 then							
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
				local ztme = {'�ж�','��Ѫ','����','����','��Ѩ','��ȼ','����','˺��','�޶�','����','�޶�','�޶�',}
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
			--lib.Debug('sm�˳��ж�'..'  r=='..r)
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
					if pmax[tb][1] > 0 then --����
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
				if tb == 1 and tb1 == 2 then --֧�߾���
					tot = tot + 1
					if tot > tot_max then 
						tot = tot_max
					end
				else
					if pmax[tb][1] > 0 then --����
						tb2 = tb2 + 1 
						if tb2 > pmax[tb][1] then 
							tb2 = 1
						end
					end
				end				
			elseif pg == 3 then 
				if tb == 1  then --�������
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
				if tb == 1 and tb1 == 2 then --֧�߾��� 
					tot = tot - 1 
					if tot < 0 then 
						tot = 0 
					end					
				else 						--���߾���
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
				if tb == 1 then --֧�߾���
					if tb1 == 2 then 
						tot = tot - 1 
						if tot < 0 then 
							tot = 0 
						end					
					else 						--���߾���
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
				if tb == 1 and tb1 == 2 then --֧�߾���
					tot = tot + 1
					if tot > tot_max then 
						tot = tot_max
					end
				else
					if pmax[tb][1] > 0 then --����
						tb2 = tb2 + 1 
						if tb2 > pmax[tb][1] then 
							tb2 = 1
						end
					end
				end
				--lib.Debug('VK_DOWN'..'pg =='..pg..'page =='..page..' tot=='..tot..' tb2=='..tb2)
			elseif pg == 3 then 
				if tb == 1  then --�������
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
	local mp = JY.Person[tid]['����']
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
	local wgfl = {'ȭ��','ָ��','����','����','����','�ڹ�','�Ṧ'}

	local stx = bx*170 --������ʼ����x
	local sty = by*70 --������ʼ����y

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
	local mpgx = math.modf(JY.Person[id]['���ɹ���']/200)+1
	for i = 1,#CC.MpKf[mp] do 
		local kf = CC.MpKf[mp][i]
		local kfname = JY.Wugong[kf]['����']
		local kflx = JY.Wugong[kf]['�书����']
		local cj = JY.Wugong[kf]['�㼶']
		--kfmenu[#kfmenu+1] = {kf,kfname,kflx,xs}
		if kf > 0 and kf ~= 333 then 
			if kflx == 1 then 
				kfmenu1[#kfmenu1+1] = {kf,kfname,cj,xs}
				--���书�㼶��С����
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
	if JY.Person[tid]['����'] == 1 then 
		if CC.TX['������'] == 1 then 			
			resetTable(kfmenu3)
			resetTable(kfmenu4)
			resetTable(kfmenu5)
		elseif CC.TX['��ĦԺ'] == 1 then 
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
	local cxfj = JY.Person[id]['����ֽ�']
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
		local mpnm = MP_name(tid)..'��ѧ'
		local mpnm1 = JY.Person[id]['����']..'����ѧϰ...'
		DrawString(CC.ScreenW/2-string.len(mpnm)/4*size,by*28,mpnm,C_WHITE,size,CC.FONT1)
		DrawString(CC.ScreenW/2-size*4-string.len(mpnm)/4*size-string.len(mpnm1)/4*size,by*35,mpnm1,C_WHITE,size*0.9,CC.FONT3)
		local h = 0
		local n,m = 0,0 
		local n1,m1 = 0,0
		local x1,y1 = bx*120,by*40
		local w = bx*180
		local hg = by*50 --�и�
		local hk = bx* 140 -- �п�
		local y3 = sty+size
		local y4 = by*40
		--kfmenu = {kfmenu1,kfmenu2,kfmenu3,kfmenu4,kfmenu5,kfmenu6,kfmenu7}
		--lib.Debug(#kfmenu1)
		--������ǿ�ֵ����
		if lb > 0 then 			
			--��һ��
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
				DrawBox(stx+bx*20,y3+y1+size+m*hg-m1*hg,stx+x1+bx*860,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --������
				DrawBox(stx+bx*70,y3,stx+bx*70,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --������
				m = m + 1
				if num1 > 0 then 
					m = m + 1
				end
				n = 0
				m1 = 0
			end

			--�ڶ���
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
				DrawBox(stx+bx*20,y3+y1+size+m*hg-m1*hg,stx+x1+bx*860,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --������
				DrawBox(stx+bx*70,y3,stx+bx*70,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --������
				m = m + 1
				if num1 > 0 then  
					m = m + 1
				end			
				n = 0
				m1 = 0
			end	
		
			--������
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
				DrawBox(stx+bx*20,y3+y1+size+m*hg-m1*hg,stx+x1+bx*860,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --������
				DrawBox(stx+bx*70,y3,stx+bx*70,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --������
				m = m + 1
				if num1 > 0 then 
					m = m + 1
				end
				n = 0
				m1 = 0
			end	
		
			--������
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
				DrawBox(stx+bx*20,y3+y1+size+m*hg-m1*hg,stx+x1+bx*860,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --������
				DrawBox(stx+bx*70,y3,stx+bx*70,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --������
				m = m + 1
				if num1 > 0 then 
					m = m + 1
				end
				n = 0
				m1 = 0
			end	
			
			--������
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
				--DrawBox(stx+bx*20,y3+y1+size+m*hg-m1*hg,stx+x1+bx*860,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --������
				DrawBox(stx+bx*70,y3,stx+bx*70,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --������
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
			--��һ��
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

			--�ڶ���
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

			--������
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

			--������
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
			--������
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

--����ѧ�书 ����
function MP_XueKf_NQ(id,tid,xkf)
	local mp = JY.Person[tid]['����']
	local bx,by = CC.ScreenW/1360,CC.ScreenH/768
	local size = CC.DefaultFont*0.9
	local kfmenu = {}
	local kfmenu6 = {}
	local kfmenu7 = {}
	local wgfl = {'�ڹ�','�Ṧ','����'}
	local stx = bx*170 --������ʼ����x
	local sty = by*50 --������ʼ����y
	local mpgx = math.modf(JY.Person[id]['���ɹ���']/200)+1
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
		local kfname = JY.Wugong[kf]['����']
		local kflx = JY.Wugong[kf]['�书����']
		local cj = JY.Wugong[kf]['�㼶']
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
	local cxfj = JY.Person[id]['����ֽ�']
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
		local mpnm = MP_name(tid)..'��ѧ'
		local mpnm1 = JY.Person[id]['����']..'����ѧϰ...'
		DrawString(CC.ScreenW/2-string.len(mpnm)/4*size,by*28,mpnm,C_WHITE,size,CC.FONT1)
		DrawString(CC.ScreenW/2-size*4-string.len(mpnm)/4*size-string.len(mpnm1)/4*size,by*35,mpnm1,C_WHITE,size*0.9,CC.FONT3)
		local h = 0
		local n,m = 0,0 
		local n1,m1 = 0,0
		local x1,y1 = bx*120,by*40
		local w = bx*180
		local hg = by*50 --�и�
		local hk = bx* 140 -- �п�
		local y3 = sty+size
		local y4 = by*40
		--������ǿ�ֵ����
		if lb > 0 then 			
			--��һ��
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
				DrawBox(stx+bx*20,y3+y1+size+m*hg-m1*hg,stx+x1+bx*860,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --������
				DrawBox(stx+bx*70,y3,stx+bx*70,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --������
				m = m + 1
				if num1 > 0 then 
					m = m + 1
				end
				n = 0
				m1 = 0
			end

			--�ڶ���
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
				DrawBox(stx+bx*20,y3+y1+size+m*hg-m1*hg,stx+x1+bx*860,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --������
				DrawBox(stx+bx*70,y3,stx+bx*70,y3+y1+size+m*hg-m1*hg,C_WHITE1,30); --������
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
			--��һ��
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

			--�ڶ���
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

--����ָ��
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


--�����츳ѡ��
function JJ_TF(pid,tnum)
	local bx,by = CC.ScreenW/1360,CC.ScreenH/768
    local tb = 1
	local tb1 = 0
    local size = CC.DefaultFont*0.7
    local pg = 1
    local menu = {}
	local w1,h1 = lib.GetPNGXY(91,139*2)
    local w = math.modf(w1/size)
	local zm = JY.Base["��Ŀ"]
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
	local fymenu = {'��һҳ','��һҳ','ȷ  ��','ɾ  ��','��  ��'}
	local tfn = 0
	local xzmenu = 0
	local xzid = '��'
	local xzsm = ''
	local xztf = 0
	local xzme = {}
	local hnum = lbnum/rwnum
	local sme = 0
	local smenu = {}
	local jj = JY.Person[pid]['����ֽ�'] - 1
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
		local ptf = JY.Person[pid]['�츳'..i]
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
		local namewz = JY.Person[pid]['����']..'����ѡ��...'
		local tfwz = '�츳�б�'
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
			fymenu = {'��һҳ','��һҳ','ȷ  ��','ɾ  ��','��һ��'}
		end
		for i = 1,#fymenu do 
			local cl = C_WHITE1	
			if tb1 == i  then 
				cl = C_RED
			end
			lib.Background(x1+(i-2)*xx-w1/2,y1+(hnum)*yy-h1/2+hh1,x1+(i-2)*xx-w1/2+w1,y1+(hnum)*yy-h1/2+h1+hh1,98)
			DrawString(x1+(i-2)*xx-string.len(fymenu[i])/4*size,y1+(hnum)*yy-h1/3+hh1,fymenu[i],cl,size)
		end
		local pgwz = 'ҳ���� '..pg..' / '..num 
		DrawString(x1+xx*3+-string.len(pgwz)/4*size,h1*2/3,pgwz,M_DeepSkyBlue,size)
		local tfh = 0
		local tfsm = 0
		--ѡ���츳�鿴
		local tfid = CC.PTFSM[menu[tb + (pg-1)*lbnum][1]]
		DrawString(x1/12,y1-yy-h1/3,'�츳���ƣ� ',C_WHITE1,size)
		DrawString(x1/5-string.len(tfid[1])/4*size+size*4,y1-yy-h1/3,tfid[1],M_DeepSkyBlue,size)
		tfsm = tfsm + 1
		tfsm = tjm(x1/12,y1-yy+h1,tfid[2],C_WHITE,size,9,size)
		
		for i = 1,#xzme do
			if xzme[i] ~= nil then 
				local xid = xzme[i]
				local xidwz = CC.PTFSM[xid][1]
				DrawString(x1/12,y1-yy-h1/3+y1*2+size*3,'��ѡ�츳�� '..'��ѡ��'..tfmax..'���츳',C_WHITE1,size)
				DrawString(x1/4-string.len(xidwz)/4*size,y1-yy-h1/3+y1*2+size*2+(i-1)*size*2+size*3,xidwz,M_DeepSkyBlue,size)
			end
		end	

		if sme == 1 then 
			DrawString(x1/12+size*9,CC.ScreenH-size*7,'�޷�ѡ������츳����������һ����',C_RED,size*2)
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
					DrawStrBoxWaitKey(JY.Person[pid]['����'].."������츳"..CC.PTFSM[xzme[1]][1], C_GOLD, CC.DefaultFont,nil, C_RED)				
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
						DrawStrBoxWaitKey(JY.Person[pid]['����'].."������츳"..CC.PTFSM[xzme[1]][1], C_GOLD, CC.DefaultFont,nil, C_RED)				
						break					
					else
						tb1 = 0
					end
				end	
			end
        end
    end
end

--��ձ�� ��deaultsΪ��ֵʱ������t
function resetTable(t, defaults)
    -- ����ṩ��Ĭ��ֵ����ʹ�������������
    if defaults then
        for k, v in pairs(defaults) do
            t[k] = v
        end
    else
        -- ����ֻ����ձ��
        for k in pairs(t) do
            t[k] = nil
        end
    end
end

function Person_WH(id)
	if id == nil then 
		id = 0
	end
	local wh = JY.Person[id]['����']
	local name1 =string.sub(JY.Person[id]['����'],1,2)
	if JY.Person[id]['����'] > 0 or (inteam(id) == false ) then 
		wh = name1..MP_zw(id)
	elseif JY.Person[id]['����ֽ�'] <= 3 then
		if JY.Person[id]["�Ա�"] == 0 then
			wh = name1..'����'
		else
			wh = name1..'Ů��'
		end 
	else
		if JY.Person[id]["�Ա�"] == 0 then
			wh = name1..'����'
		else
			wh = name1..'Ů��'
		end
	end
	return wh
end

function NeiGong_tx(pid,tx,flag) 
	--lib.Debug('NeiGong_tx')
	local kf_ng = JY.Person[pid]['�����ڹ�']
	local kf_qg = JY.Person[pid]['�����Ṧ']
	if kf_ng == 0 then 
		return false 
	end	
	if flag == 1 then 
		if kf_qg == 0 then 
			return false
		end
	end

	if flag == nil then 
		for i = 1,10 do 
			if JY.Wugong[kf_ng]['��Ч'..i] == tx  then 
				return true
			end
		end
		for i = 1,10 do 
			if JY.Wugong[kf_qg]['��Ч'..i] == tx then 
				return true
			end
		end

		--�Զ��˹�
		local personid = pid
		local NGid = 0
		local pmenu ={	
						--�������ڹ�
						{637,107},--���� ����
						{27,105}, --���� ����
						{9795,90}, --
						{511,227}, --
						{60,95}, --
						{9771,99}, --
						{149,108}, --
						{9997,175}, --����
						{22,175},--����
						{21,175},--����
						{20,175},--����
						{23,175},--



	
					}

		for i = 1,#pmenu do 	
			if Curr_NG(pid,pmenu[i][2]) then 
				for w = 1,10 do 
					if JY.Wugong[pmenu[i][2]]['��Ч'..w] == tx  then 
						lib.Debug('ȷ�������ڹ�')
						return true
					end
				end
			end					
		end


		local pmenu_qg = {
						--�Ṧ
						{9963,186}, --
						{130,145}, ---
						}

		for i = 1,#pmenu_qg do	
			if Curr_QG(pid,pmenu_qg[i][2]) then 
				for w = 1,10 do 
					if JY.Wugong[pmenu_qg[i][2]]['��Ч'..w] == tx  then 
						lib.Debug('ȷ�������Ṧ')
						return true
					end
				end
			end						
		end


		--�ڹ��������
		--��������
		if match_ID(pid,752) or match_ID(pid,652) then 
			local ts = 0
			if pid == 0 and JY.Base["��������"] >= 7 and CC.TX["��������"] == 1 then 
				ts = 1
			end
			if inteam(pid) == false then 
				ts = 1
			end
			if ts == 1 then 
				for w = 1,10 do 
					if JY.Wugong[177]['��Ч'..w] == tx then 
						return true
					end
				end
			end
		end
		-- ��ת����
		if PersonKF(pid, 43) and KF_level(pid, 43) > 10 and JY.Person[pid]['��Ѩ' .. 149] == 1  then
			for w = 1,10 do 
				if JY.Wugong[43]['��Ч'..w] == tx then 
					return true
				end
			end
		end

		--ѧ���˾��������棬������˾����������Ҳ������
		if PersonKF(pid, 104) and PersonKF(pid, 107)  and JY.Person[pid]["�����ڹ�"] == 107 then
			for w = 1,10 do 
				if JY.Wugong[104]['��Ч'..w] == tx then 
					return true
				end
			end
		end
		-- ����ж�
		if pid == 0 and JY.Person[pid]['��������'] == 3 then
			-- ��������ڣ������Ѿ�ѧ�ᣬ���Զ�����
			if JY.Person[pid]["�츳�ڹ�"] == kf_ng and PersonKF(pid, kf_ng) then
				for w = 1,10 do 
					if JY.Wugong[kf_ng]['��Ч'..w] == tx then 
						return true
					end
				end
			end
		end

		--�Ṧ�������
		--��һ���츳�Ṧ�Զ��˹�
		if match_ID(pid, 633) and kf_qg == JY.Person[pid]["�츳�Ṧ"] and PersonKF(pid, kf_qg) then
			for w = 1,10 do 
				if JY.Wugong[kf_qg]['��Ч'..w] == tx then 
					return true
				end
			end
		end
	end	
	return false
end

--����ָ��
function Game_Kdef()
	--Cls()
	local bx,by = CC.ScreenW/1360,CC.ScreenH/768
	local size = CC.DefaultFont
	local TSmenu = {'�ɺ��⴫','ѩɽ�ɺ�','���Ǿ�','�����˲�','���Ӣ�۴�','����Х����','¹����','Ц������','�齣����¼','�������','������','����������','��Ѫ��','ԧ�쵶',}
	--�ɺ��⴫
	local Fei = {
		{'������������*����ս����*VS���˺�',0,'������*����+1'},
		{'������������ *��ҹ�����ջ�󣬴�������',1,'������'},
		{'������������ *��߷����ҵ��ֻ�����������',2,'������'},
		{'������������ *���һ�����ţ��������½Ƿ���Ѱ�����˷��������',3,'������'},
		{'������������ *��ջͬ��һ���Ի��󷵻��Լ����䣨��һ��������棩',4,'������*����+1'},
		{'������������ *��ջ���þ���󣬴���ս����*VS���˷սʤ����200ʱ��',5,'������'},
		{'����ԭ���̼ұ� *�����̼ұ��󣬴���ս����*VS�̽���+�̷���',6,'������'},
		{'������������ *ȥ���ݿ�ջ����Ѱ�Һ�һ������������',7,'������'},
		{'������������ *��ջ�����Լ�������Ϣ������󴥷�ս����*VS���˺�+�����ŵ���x2+ؤ�����x2',8,'������'},
		{'������������*��ջ���þ���󣬴���ս����VS���˷սʤ����200ʱ�򣩣�*����󣬴���ս����VS�ֻ�ʤ��á�ǧ�𷽡�',9,'������*ǧ��[��ѧ]'},
		{'������������*��ջ���Լ�������Ϣ���ڶ��죬Ȼ����ȥ��ջ����Ѱ�Һ�һ���Ի��������顣',10,'������'},
		{'������������*��ջ���ؿ�ջ�Լ�������ٽ�����ã�������һ���ж�����,������������������ҽ֮һ��ѦĽ����ƽһָ������ţ�������������ߣ���������ҽ����Ԭ�����ߣ�*PS:Ԭ�������迪�������ر�����������õ��ɺ��⴫',11,'������'},
		{'��Ԭ�����ߡ�������������*��ջ�󷽶Ի����˷',12,'������'},
		{'��Ԭ�����ߡ��̼ұ�����ԭ��*�����̼ұ�������쳣������*VS �̷���+�̱���ս��ʤ���󣬺�����',13,'������*������[����]'},
		{'��Ԭ�����ߡ��̼ұ�����ԭ��*�����̼ұ����������*VS ������ʤ��á������ķ��������Ե������������ơ���',14,'������*�����ķ�[�ڹ�] *���Ե���[����] *������[ȭ��]'},
		{'��Ԭ�����ߡ��̼ұ�����ԭ��*�����̼ұ���Ѱ�����ؿ��ţ��������ţ��������*VS �̷���+�̱���',15,'������'},
		{'��Ԭ�����ߡ���ɽ�����ϣ�*��ɽ��ջ�������飬�����ǰ����ͼ���Ϸ��廢�ţ��Ի������ˣ�*VS �廢���ˣ�',16,'����������+1'},
		{'��Ԭ�����ߡ���ɽ�����ϣ�*�廢�ŶԻ������ϣ��������飺*VS�����ϣ�',17,'������*����+2'},
		{'��Ԭ�����ߡ���ɽ�����ϣ�*�廢�ų��ź󴥷����飺*���VS Ԭ���£�*���廢�ž��飬�ٴλ��廢��*���VS��ǰ����x2+�����ٱ�x2',18,'����������+1'},
		{'��Ԭ�����ߡ����������ϣ�*Τ���Ŵ������飺*VS������',19,'������'},
		{'��Ԭ�����ߡ����������ϣ�*�Ի�Τ���������������飺���[��Ⱥ]Ԭ������ӣ�',20,'������*��Ⱥ[����] *Ԭ�������[����]'},
		{'��Ԭ�����ߡ����������ϣ�*Ԭ�����ڶӣ�����¥�������飺VS ����+��ǰ����+�����ٱ�ʤ�����á����ɽ����������Ԭ������ӣ�',21,'����������+2 *���ɽ���[�����ؼ�]'},
		{'��Ԭ�����ߡ�ҩ������ԭ��*׷��Ԭ���µ��ټ�����������ս����*VSԬ����+������',22,'������'},
		{'��Ԭ�����ߡ�������������*�Ի��������������ˣ�����󴥷�ս����*����+���+Ԭ����VS ���棬��������󴥷�ս����*����+���+Ԭ����VS ����+���ũ+������+����Ӣ+���˺�+���ж�+һȺ�ٱ���',23,'����������+2 *���ɽ���[�����ؼ�]'},
		{'��Ԭ�����ߡ�������������*�������Ԭ�������,���[��������] [���±���]��',24,'������*��������[����] *���±���[����] *Ԭ�������[����]'},
		{'���������ߡ�������������*��ջ�󷽶Ի����˷��á���ҽ�����',26,'������*��ҽ���[�����ؼ�]'},
		{'���������ߡ��̼ұ�����ԭ��*�����̼ұ�������쳣������*VS �̷���+�̱���ս��ʤ���󣬺����ӣ�',27,'������*������[����]'},
		{'���������ߡ��̼ұ�����ԭ��*�����̼ұ��������*VS �����ܣ�ʤ��á������ķ��������Ե������������ơ�',28,'������*�����ķ�[�ڹ�] *���Ե���[����] *������[ȭ��]'},
		{'���������ߡ��̼ұ�����ԭ��*��������̼ұ�������Ҳ����ſ��ţ������*VS �̷���+�̱���',29,'������'},
		{'���������ߡ����ׯ����ԭ��*�������ׯ�������*VS ��ǰ����x2+�����ٱ�x2��ս��ʤ���󣬹�����',30,'����������+2'},
		{'���������ߡ�����-ҩ��ׯ�����ϣ�* ������ضԻ��������ػ�Ҫ��ȥ��[���ĺ���]��',31,'������'},
		{'���������ߡ��ֻ��ӣ����ϣ�*����ڶ�ʱ���������Ϸ��䣬�������飬�ҷ�ȫԱ�ж�����ȫʧ����ս��*VS �ֻ���ʤ���[��ҳ����][���ĺ���] ��',32,'������*����+2 *��ҳ����[�������] *���ĺ���[�������] *ǧ��[ҽ��] �ֻ�����͵ȡ'},
		{'���������ߡ�����-ҩ��ׯ������*�� ������ضԻ�����������[���ĺ���]���õ�[���˷��۶���ҩ]������ڶ���ʱ���ٴ�������ضԻ����������������ӣ���á�ҩ����ƪ����',33,'������*���˷��۶���ҩ[�������] *ҩ����ƪ[ҽ��] *������[����] ����'},
		{'���������ߡ����ׯ����ԭ�� *�����˷�[���˷��۶���ҩ]�����������ӡ����쳶Ի������պ����ӣ�',34,'������*������[����]'},
		{'���������ߡ����ׯ����ԭ�� *����ڶ��ٴ������˷�Ի���ѡ�Ǵ���ս����*VS ���˷��á��ɺ��⴫����',35,'������*����+2 *�ɺ��⴫[ʮ������֮һ]'},
		{'���������ߡ������������� *�Ի��������������˴������飺*VS ���棬��������󴥷�ս����*VS ����+���ũ+������+����Ӣ+���˺�+���ж�+һȺ�ٱ��� �������ſ�Ԭ������[��������] [���±���]��Ԭ�������[����]',36,'������*��������[����] *���±���[����] *Ԭ�������[����]'},
		{'�����ȫ������',37},
	}
	--ѩɽ�ɺ�
	local Xue = {
		{'��ɷɺ��⴫����',0,'����������+1'},
		{'���ɽׯ�������� *����ɽ�����봳���ر���һ·�����ߣ�������ѩ�ִ���ս����*VS һȺ��ѩ�֣������д�������ʱ���ո���Կ�׿״����ţ����������ĸ�����ɻ����������PS��һ��ɽ����ѩ�˴�����һ��ǧ���˲Σ���',1,'������*ѩɽ�ɺ�[ʮ������֮һ]*�ɺ��⴫[ʮ������֮һ]���ɺ��⴫Ԭ�����߿ɻ�ã�*ԧ��[����]*����2000*ǧ����֥[��ҩ]*���󲽷�[�Ṧ�ؼ�]*�ڷ�ָ��[ָ���ؼ�]*���л��ڶ����л��Ṧ+50 *Ԭ�����ڶӵ�����ϴ�������У��츳�Ṧϴ��������'},
		{'�����ȫ������',2},
	}
	--���Ǿ�
	local Lian = {
		{'��ʫɽ�������ϣ�*Ѱ�ҵ��ƣ�������ӣ����[�ڲ���]�����������������ӵ�[��ʫѡ��]',0,'������*����+2 *��ʫѡ��[�������] *�ڲ���[����] *����[����]'},
		{'����������*�����ڶ�ʱ���������ķش��������������������ս����*VS ����ʤ��á�Ѫ���ķ�����[����]200',1,'������*����200 *Ѫ���ķ�[�ڹ��ؼ�]'},
		{'���ſ�ջ��������*�����ջ�󴥷����飬���Ʊ�Ѫ������°��',2,'������'},
		{'ѩɽ��������*�����ѡ����а�ߡ�*ѡ�񡺷񡻽������ߣ�����ս����*VS Ѫ�����棬ʤ��á���ͷ�������������������չ��������������*ѡ���ǡ�����а�ߣ�����ս����*VS �仨��ˮ+ˮ�ϣ���ս�� *VSˮ��,������ѡ���Ƿ��ջ�������ӡ�',3,'������*�����ߡ���*����+2 *��ͷ����[�����ؼ�]��*���ƽ�����*����+30������+30���Ṧ+30 *��ϵ����ֵ+10 ���Ƴ�Ѫ�������� *�ڶ����书ϴѪ���� 1�� *��а�ߡ�*����-3 *��ƽǹ��[�����ؼ�] *������[����] ����'},
		{'�����ߡ�ѩɽ��������*����ƶԻ����յ�����ӣ��á�Ѫ������',4,'������*Ѫ����[�����ؼ�] *����[����] '},
		{'�����ߡ�ѩɽ��������*����ˮ��ʹ��[��ʫѡ��]����֪���Ǿ������ܣ�����ѧ�����ǽ�������á����ǽ�����',5,'������*���ǽ���[�����ؼ�] *���ƽ����� *�������书ϴ���ǽ��� 1��'},
		{'�����ߡ�����-�����£����ϣ�*���볡���󴥷�ս����*VS һȺආ�',6,'������'},
		{'�����ߡ�����-�����£����ϣ�*�����������ڷ�����أ������Ʋ��ڶӻ����<80����á����Ǿ���*/�����¡�80�ҵ����ڶӣ���á����Ǿ��������վ���',7,'������*���Ǿ�[ʮ������֮һ] */����+1 ���Ǿ�[ʮ������֮һ] ���վ�[�ڹ��ؼ�]'},
		{'�����ߡ�����-�����£����ϣ�*���Ŵ������飬���Ʊ��ݳ���͵Ϯ������ս����*VS �ݳ���',8,'������'},
		{'�����ߡ�ѩɽ��������*�����ڶ�ʱ����ˮ�϶Ի�������ˮ�����',9,'������*ˮ��[����] ����'},
		{'�����ȫ������',10},
		{'��а�ߡ�ѩɽ��������*��Ѫ������Ի���Ѫ��������衾Ѫ���������ٴ�����Ի���ѡ���ǡ�����ս����*VS Ѫ�����棬ʤ����[Ѫ��]����Ѫ�������',11,'������*Ѫ����[�����ؼ�] *Ѫ��[����] *Ѫ�����[�ڹ��ؼ�]'},
		{'��а�ߡ�ѩɽ��������*����ˮ��ʹ��[��ʫѡ��]����֪���Ǿ�������',12,'������*���ǽ���[�����ؼ�]'},
		{'��а�ߡ�����-�����£����ϣ�*���볡���󴥷�ս����*VS һȺආ�',13,'������'},
		{'��а�ߡ�����-�����£����ϣ�*�������ڷ��񱳺��á����Ǿ���',14,'������*���Ǿ�[ʮ������֮һ]'},
	}
	--�����˲�
	local Tian = {
		{'����ɽ��������*��������ɽ�������飬ս����*VS ��������+������ͽ��ʤ�����������ӣ���á���ٵ�������*��PS:������ȥ���붴�ҵ�������,��������������ָ�͵�Եз�Я������Ʒ������ǿ���϶�50�㣩,������鲻�ڶ��飬����������������������ʧ������',0,'������*����+1 *��ٵ���[�����ؼ�] *�����[��ҩ] ������*����[����] ����'},
		{'����ɽ��������*�������ϵ�����ɽ��,�ҵ������������������޷�����貨΢����������������ɽ�����ڴ�����ս����*VS ç����� *ʤ����[ç�����]',1,'������ç�����[��ҩ]'},
		{'����ɽ��������*����ɽ���ֶ��������Ĵ����Χס������ս��:*VS�Ĵ���� *ʤ���á����߰˴� [��Ƥ����]',2,'������*����+1 *���߰˴�[�����ؼ�] *��Ƥ����[����] *���������[�����ؼ�]͵������ *�����[����]͵������'},
		{'����-�����£�������*���������£������Ħ�����������񽣣�����ս����*VS �Ħ�ǣ��ɰܣ�ս����Ի����ٴ�ʦ����á�����������*���ζԻ����Ϸ���ɮ�ˣ��ɵõ����������Ϲȡ�����Ϣ',3,'������*����+1 *Ϫɽ����ͼ[�������] ���䱦�� *���浶[�����ؼ�] ʤ�Ħ�� *��������[�ڹ��ؼ�] �Ի����ٴ�ʦ'},
		{'����-�����루���ϣ�*�����������ұ߷��䣬�������Ľ�ݸ��Ի����ȸ�Ľ�ݸ�[����](�����ѹ�)���ٸ�[����ʵ���Ϯͼ��](����ɽ����)��������а��֧:*ѡ���񡻽������ߣ�����ʱ���������ǡ���ڤ�񹦡�*ѡ���ǡ�����Ľ�ݸ������󣬻��[��ͷ��������]Ľ�ݸ�����������ӣ������ڶ�����������*а�߿����󽫲�����������ӣ���Ҫ��ɽ�����ơ�С���๦���߱�ָ����Ҫ��ǰȥ��������֧��*а�߲�Ҫ��ǰȥ�������á�һέ�ɽ���������Ľ�ݸ��޷�����ڼ�����',4,'������*�����ߡ���ڤ��[�ڹ��ؼ�]*�����ߡ�����+2 *��а�ߡ�����-8 *��а�ߡ���ת����[�ؼ�]Ľ�ݸ������� *��а�ߡ�Ľ�ݸ�[����]���� *��а�ߡ�������[����]����'},
		{'�����ߡ�ؤ���ԭ��*�뿴�ŵ��ӶԻ�������ս����*VS ؤ�����ʤ���á�������������ս������ǰ���򣩣�����ؤ�ﴥ�����飬Ľ�ݸ��ҷ��Ƿ��������Ƿ��뿪ؤ��*ps:��ʱ����ʾ�Ƿ�������ʵ���飬ѡ�񡺷����������ߣ������������߲�����ؤ����ӶԻ��������ִ�ս',5,'������*������[�ڹ��ؼ�]'},
		{'�����ߡ���̨ɽ����ԭ��*��������ǹ��ʦ��ʬ�壬�����������������������Ǯ�̷��̷�ŵ�ʬ��*��Ҫ���ŵ�������ؤ�����ǰ����������',6,'������'},
		{'�����ߡ������ǣ���ԭ��*�����������̵�ӵ�����ׯ��Ӣ������',7,'������'},
		{'�����ߡ�����ׯ����ԭ��*���Ƿ�һ���ս����Ⱥ�ۣ���ʵ����һȺ��ޣ���*1��VS ����˫�� *2��VS ����˫��+ѦĽ�� *3��VS ����˫��+ѦĽ��+ؤ����� *4��VS ����˫��+ѦĽ��+���ɵ��� *5��VS ����˫��+ѦĽ��+���ɵ��ӡ�*����ս�����Ǳ��Ƿ�������ׯ��',8,'������*����+5'},
		{'�����ߡ�����ׯ����ԭ��*����ׯ�밢��Ի���*��������[�߱�ָ��]����ѦĽ�����',9,'������ѦĽ����ӡ����ѡ�����Ҫ���߱�ָ����'},
		{'�����ߡ�ؤ���ԭ��*�뿴�ŵ��ӶԻ�����֪�°���ȥ������',10,'������*����+5�������ߣ�'},
		{'�����ߡ�����ɽ�£���ԭ��*�������¶Ի��Ƿ� ��á������֡�',11,'������*������[ָ���ؼ�]'},
		{'�����ߡ�����ɽ�£���ԭ��*������ɽ�½��������£�����󴥷�ս����*1��VS ��̹֮ *2��VS Ľ�ݸ� *3��VS ��̹֮+Ľ�ݸ� *4��VS ��̹֮+Ľ�ݸ�+�Ħ�ǣ��á������ָ���� *5��VS ��̹֮+Ľ�ݸ�+�Ħ��+Ľ�ݲ�+�Ĵ����+ؤ����� *����֮���Ƿ���衾����ʮ���ơ��������˲���',12,'������*����+3 *�����ָ[ָ���ؼ�] *�����˲�[ʮ������֮һ] *����ʮ����[ȭ���ؼ�]'},
		{'�����ߡ������£���ԭ��*������������̶Ի��������������������뿪��*����ɽ����������������ɽ����������������̶Ի���������2����ӣ���С����������̡��������',13,'������*����+2 *����[����]���� *������[����]����'},
		{'�����ȫ������',14,'������'},
		{'��а�ߡ�ؤ���ԭ�� *�뿴�ŵ��ӶԻ�������ս����*VS ؤ�����ʤ���á�������������ս����ǰ���� *����ؤ�����󴥷�ս����Ľ�ݸ������������ڶ��飩��*VS ؤ�����ʤ�����á���ң�Ρ�',15,'������*������[�ڹ��ؼ�] *����-5 *��ң��[�Ṧ�ؼ�]'},
		{'��а�ߡ�����ׯ����ԭ��*����󴥷�ս����*VS ��Զɽ��ʤ�����á��黨ָ��������������[�߱�ָ��]����ѦĽ�����',16,'������*����-3 *�黨ָ��[ָ���ؼ�]'},
		{'��а�ߡ�ؤ���ԭ��*����ؤ�ﴥ�����飬�����*����VS��̹֮��ս��ʤ���󣬻�á����϶��ơ������㾭���������͡������ָ�������밢�϶Ի�����С�������̹֮�Ͱ������',17,'������*����-3 *���϶���[ȭ���ؼ�] *���㾭[�ڹ��ؼ�] *�����ָ��[ָ���ؼ�] *����[����]���� *��̹֮[����]����'},
		{'��а�ߡ�����ɽ��-������*����������(Ľ�ݸ�����̹֮�������̱����ڶ�)���Ƿ忹���������������󴥷�ս�� *1��VS �Ƿ� *2��VS �Ƿ�+���� *3��VS �Ƿ�+����+����+��Զɽ *ս���������Ħ���͡����浶��������á������˲���',16,'������*����-8 *������ϵ����ֵ+10 *�����˲�[ʮ������֮һ] *���浶��[�����ؼ�] *����צ[����]'},

	}
	--���Ӣ�۴�
	local She = {
		{'�ɹŰ���������*������Ի����չ������',0,'������*����[����] ����'},
		{'������������*�����ڶ�ʱ�����ջ�ſڵĻ��ضԻ����������飬��а��֧*ѡ���ǡ��������ߣ�����ս����*VSŷ����*ʤ�󣬹�����ӣ���á�������ת����������Ѩ�֡�',1,'������*����*����+2*������ת[�ڹ��ؼ�]*������Ѩ��[ָ���ؼ�] *а��*����-2*͸�Ǵ�Ѩ[ָ���ؼ�]'},
		{'�����ߡ����߹��ӣ���ԭ��*���볡����������',2,'������'},
		{'�����ߡ��һ��������⣩*���볡���������飬ŷ���ˡ����������Ǳ��ԣ�*1��VS ŷ���ˣ��ɰܣ�*2��VS �������ɰܣ�*����������뿪����á���Ӣ���ơ�������ɨҶ�ȡ�������*�����ǵ�ȥ�������Ϸ���ǽ���ϵĶ���',3,'������*������¾���Ⱦ��鿪�� *ǧ����֥[��ҩ] ʤ�������� *��Ӣ����[ȭ���ؼ�] *����ɨҶ��[ָ���ؼ�]'},
		{'�����ߡ���ϼ�������⣩*���볡��������󴥷�ս����*VS ŷ����',4,'������*����+1'},
		{'�����ߡ�����-ţ�Ҵ壨���ϣ�*����С�ݾ���󴥷�ս����*1��VS ŷ���� *2��VS ŷ���棨�ɰܣ�ʤ�����á���󡹦�� *3��VS ŷ���棨�ɰܣ�ʤ��������ɽѩ��x2 *4��VS ŷ����,ս������������á���ָ��ͨ�� ',5,'������*����+4 *����������[�������]����󿪱����� *��󡹦��[�ڹ��ؼ�] *��ɽѩ��[��ҩ]*2 *��ָ��ͨ[ָ���ؼ�] *��Ӣ���ڶ����书ϴ��ָ��ͨ1�� �������书ϴ��Ӣ����1��'},
		{'�����ߡ����Ʒ壨���ϣ�*����󴥷�ս����*VS ��ǧ��+���ư���',6,'������*����+1'},
		{'�����ߡ�һ�ƾӣ����ϣ�*�棺����[������](�����ѹ�)��ͨ��������+1,�������ѡ�����佻��ɱ��ȥ������-1*��������ũ��ѡ��̹�С���书���Ҳ������ӿ�ͨ��������+1,�������ѡ�����佻��ɱ��ȥ������-1*�ԣ����¡�75��������100ֱ��ͨ��������+1,�������ѡ�����佻��ɱ��ȥ������-1*�����һ�����������������ͨ��������+1,�������ǣ�ȭָ��������ϵ����ֵ��ѡ����һ��+10,�������ѡ�����佻��ɱ��ȥ������-1,',7,'������*��ϵ����ֵ��ѡ��һ+10��'},
		{'�����ߡ�һ�ƾӣ����ϣ�*���뷿�䣬����󴥷�ս����*VS ŷ����+��ǧ��*ʤ��һ�������ǡ����칦�ؼ�����һ��ָ����',8,'������*����+8 *���칦�ؼ�[�ڹ��ؼ�] *һ��ָ��[ָ���ؼ�]'},
		{'�����ߡ����߹��ӣ���ԭ��*����߹��Ի�����֪������������',9,'������'},
		{'�����ߡ�����������ԭ��*���𴦻��Ի����������飬ŷ������֣�*VS ŷ����+��ǧ��+��Ⱥ*��á�˲Ϣǧ�*ս��ʤ������������������ŷ����',10,'������*����+8 *˲Ϣǧ��[�Ṧ�ؼ�]'},
		{'�����ߡ�����������ԭ��*���������Ի���ѡ���ǡ���*����VS���������ɰܣ����ظ���ս��*ʤ���á����Ӣ�۴���',11,'������*���Ӣ�۴�[ʮ������֮һ]'},
		{'��а�ߡ����߹��ӣ���ԭ��*���볡�����������ս����*VS ���߹����ɰܣ�',12,'������*ʤ���߹���������ϵ����ֵ��ѡ��һ+10��*˲Ϣǧ��[�Ṧ�ؼ�]'},
		{'��а�ߡ��һ��������⣩*���볡���������飬ŷ���ˡ����������Ǳ��ԣ�*1��VS ŷ���ˣ��ɰܣ�*2��VS �������ɰܣ�*����������뿪����á���Ӣ���ơ�������ɨҶ�ȡ�*�����ǵ�ȥ�������Ϸ���ǽ���ϵĶ���',13,'������*������¾���Ⱦ��鿪��*ǧ����֥[��ҩ] ʤ��������*��Ӣ����[ȭ���ؼ�]*����ɨҶ��[ָ���ؼ�]'},
		{'��а�ߡ���ϼ�������⣩*�Ի�ŷ���棬����󣬻�á�����ѩɽ�ơ�����󡹦��',14,'������*����-1*����ѩɽ��[ȭ���ؼ�]*��󡹦[�ڹ��ؼ�]'},
		{'��а�ߡ�����-ţ�Ҵ壨���ϣ�*����󴥷�ս����*VS ŷ����',16,'������*����-3 *����������[�������]����󿪱�����'},
		{'��а�ߡ����Ʒ壨���ϣ�*VS ����ආ� *��������ǧ��Ի�����á��������ס�',17,'������*��������[ȭ���ؼ�]'},
		{'��а�ߡ�һ�ƾӣ����ϣ�*�棺����[������](�����ѹ�)��ͨ��������+1/����ս��������-1*��������ũ��ѡ��̹�С���书���Ҳ������ӿ�ͨ��������+1/����ս��������-1*�ԣ����¡�75��������100ֱ��ͨ��������+1/����ս��������-1*�����һ�����������������ͨ��������+1/����ս��������-1',18,'������*������*�������ǣ�ȭָ��������ϵ����ֵ��ѡ����һ��+10'},
		{'��а�ߡ�һ�ƾӣ����ϣ�*���뷿�䣬����󴥷�ս����*VS һ��+���Ը���*ʤ�󣬻��[��⬼�]��һ��ָ����',19,'������*����-10 *һ��ָ��[ָ���ؼ�] *��ʵ���[�����ؼ�]������������͵ȡ�� *��⬼�[����]'},
		{'��а�ߡ�����������ԭ��*���𴦻����߹����˶Ի�������ս����*1��VS ȫ������+ȫ���ͽ *2��VS �ܲ�ͨ+ȫ������+ȫ���ͽ *3��VS �ܲ�ͨ+��а+��ؤ+ȫ������+ȫ���ͽ *��4սǰ�����Ƿ񻯸ɸ�Ϊ��ѡ�� *���ɸ�Ϊ�񲯣�4��VS ������+�ֳ�Ӣ*�����ɸ�Ϊ�񲯣�4��VS ������+�ֳ�Ӣ+�ܲ�ͨ+��а+��ؤ+ȫ������+ȫ���ͽ',20,'������*����-3*���ɸ�Ϊ�񲯣�����+3 �����Ӣ�۴���ʮ������֮һ �����澭�Ͼ�[�������] *�����ɸ�Ϊ�񲯣������Ӣ�۴���ʮ������֮һ �����澭�Ͼ�[�������] �����귭[�Ṧ�ؼ�]'},
	}
	--����Х����
	local Bai = {
		{'����������*����������аѡ��ȷ��ͦ�����ѡ�����ߴ���ս����VS �´ﺣ+���ư���ʤ������������ӵ�[����]��[����]��[��Ѫ����]x3,',0,'������*����+2 *����[�������] *����[����] *[��Ѫ����]x3[����] *������[����]���'},
		{'ɳĮ���棨������*����󴥷�ս����*VS �߶�����+һȺආ�',2,'������'},
		{'ɳĮ���棨������*��������ڵĹ��ӣ������ܵ�����߲��Թ�,',3,'����������+1'},
		{'ɳĮ���棨������*������[������]��[������]��[���콣]���ѱ���֮һ��������ʯ��,',4,'����������+1'},
		{'ɳĮ���棨������*��������ڵĹ��ӣ������ܵ�����߲��Թ��Թ��ڿ������ã�*������Х���硷��[��ɽѩ��]������*1000�������鵶����',5,'������*����Х����[ʮ������֮һ] *��ɽѩ��[��ҩ] *����*1000 *���鵶��[�����ؼ�]'},

	}
	--¹����
	local Lu = {
		{'����-�����˼䣨���ϣ�*���������˼�Ѱ��ΤС����ΤС����ӣ���á�һָ����',0,'������*ΤС��[����] *һָ��[ָ���ؼ�]'},
		{'����-�м��ջ��������*ΤС���ڶӣ�������������ս����*VS ���� ���ɰܣ���ʤ�����á��������ơ�',1,'������*��������[ȭ���ؼ�]'},
		{'������������*��߷�����Ŵ������飬����ս����*VS ���ڸ���',2,'������'},
		{'������������*��ջ�Ի�Ǯ�ϰ壬��500������[���߻�����]',3,'������*���߻�����[�������]'},
		{'������������*�Խ���ʹ��[���߻�����]������ʹ�',4,'������'},
		{'������������-�ʹ�*�ʹ����Ϸ��䣬���Ŵ������飬����ս����*VS ���ݣ��ɰܣ��������[�ʹ�ͨ����]*��ս�������ʧ�ܽ��޷������ص����ң�����Ӱ��������',5,'������*�ʹ�ͨ����[�������]'},
		{'̨�壨���⣩*ΤС���ڶӣ����Ŵ������飬����ս����*VS ������+����+֣��ˬ��������[�벿��ʮ���¾�]����Ѫ��צ��',6,'������*�벿��ʮ���¾�[�������] *��Ѫ��צ[ָ���ؼ�]'},
		{'�����̣����⣩*�뿴��С���Ի�����ս����*VS ������ͽ���������ڴ���ս����*VS �����+����+�������ڣ�ʤ��ΤС����ӣ����[��ʮ���¾�]',7,'������*��ʮ���¾�[�������]'},
		{'С�壨���ϣ�*�����󷿼��������ʹ��[��ʮ���¾�]��¹��ɽ����',8,'������'},
		{'¹��ɽ��������*ɽ��ս��*VSһ��Ⱥ��ѩ�֣����������ã�����*1000��ǧ����֥������ʤ��������¹���ǡ�',9,'������*����*1000 *ǧ����֥[��ҩ] *��ʤ����[�����ؼ�] *¹����[ʮ������֮һ]'},
	}
	--Ц������
	local Xiao = {
		{'���ݣ����ϣ���*���ݿ�ջ��ʶ��ƽ֮�������,����󴥷�ս����VS ��ǵ���x3',0,'����������+1'},
		{'���ݣ����ϣ���*���븣���ھ֣�����ʦ�Ի�',1,'������'},
		{'���������ϣ�*�����ջ�ڣ�����󴥷�ս����VS ��ǵ���x4,ʤ������飬��á�̫������塿����ɽ�ķ���',2,'������*����+1 *��ɽ�ķ�[�ڹ��ؼ�] *̫�������[�����ؼ�]'},
		{'��ɽ��-��ɽ�ɣ���ԭ��*������ɺ�Ի�����֪�������˼����',3,'������'},
		{'��ɽ��-��ɽ�ɣ���ԭ��*�����Ϸ���˼���£������������һ���书ϴΪ���¾Ž��˼�������+50���������Ի�ѡ���ǡ�������ս��*����VS����壨�ɰܣ���ս����ᴥ���ɲ�������ɽ�����¼���*��ʱ��ѡ�Ƿ������������飬ѡ������ת�����߲�������ɽ��2',4,'������*����影��������+50*��һ���书ϴΪ ���¾Ž� �˼�'},
		{'��ɽ��-��ɽ�ɣ���ԭ��*��ɽ�ɴ��ô�������ս����*����� VS �ɲ��ǣ���սģʽ����ս�����ҹ�����׽ס�������˼���·���ȥ��',5,'������'},
		{'��ɽ��-��ɽ�ɣ���ԭ��*����˼���£�����󣬴���ս����*VS �ҹ����ɣ�ս���������������Ի����������',6,'������*����+1 *�����[����] *����壺��������-200 ��������-200 �Ṧ-50'},
		{'��ɽ��-��ɽ�ɣ���ԭ��*��ɽ�ɣ���½���жԻ�����á���ϼ�ؼ���',7,'������*��ϼ�ؼ�[�ڹ��ؼ�]'},
		{'ҩ������ԭ��*���볡��������󴥷�ս����*VS �ⲻƽ+��ɽ���ӣ��������������',8,'������*���콣[�����ؼ�]'},
		{'�����ǣ���ԭ��*���ž����ȥ�����������������Ի�',9,'������'},
		{'�����ǣ���ԭ��*���������������������Ի�',10,'������'},
		{'�����ǣ���ԭ��*�������Ǻ��ٴν��룬�������Ի���������������룬��á������١�',11,'������*������[�����ؼ�] *�����[����]'},
		{'����-ƽһָ�ӣ���ԭ��*������ڶ���ƽһָ�Ի���֮���ȥС����ƽһָ���',12,'������*������ľ�[ҽ��] *ƽһָ[����]'},
		{'����ɽ�£���ԭ��*������ڶ�ʱ�����볡���������飬��������',13,'������'},
		{'����ɽ�£���ԭ��*������ɽ���ٴν��룬�������Ի�������󴥷�ս����*VS ����������ʿ��ս��ʤ������飬�������Ի�������������',14,'������*�����[����]���� *����+1�������ߣ�*��ϼ�ؼ�[�ڹ��ؼ�]�������ߣ�*������[�����ؼ�]�������ߣ�'},
		{'����-÷ׯ�����ϣ�*������ڶ�ʱ���Ե�����ʹ��[Ϫɽ����ͼ]������ս����*VS ������',15,'������*�滨��[��ҩ] �������Աߵľ�̳'},
		{'����-÷ׯ�����ϣ�*������ڶ�ʱ����ͺ����ʹ��[����������]������ս����*VSͺ����',16,'������*�Ὣ����[�����ؼ�]'},
		{'����-÷ׯ�����ϣ�*������ڶ�ʱ���Ժڰ���ʹ��[���ٸ�ŻѪ����]������ս��*VS �ڰ��ӣ���á�����ָ��',17,'������*����ָ[ָ���ؼ�]'},
		{'����-÷ׯ�����ϣ�*������ڶ�ʱ���Ի��ӹ�ʹ��[����ɢ����]������ս����*VS ���ӹ�',18,'������'},
		{'����-÷ׯ�����ϣ�*������ڶ�ʱ��ڰ��ӶԻ����������÷ׯ����',19,'������'},
		{'����-÷ׯ�����ϣ�*����÷ׯ���Σ��������жԻ�������󴥷�ս����*VS �����У��ɰܣ�����á����Ǵ󷨡�',20,'������*���Ǵ�[�ڹ��ؼ�] *���ǽ�����(ʤ������) ����+10���Ṧ+10 *����影�����ڶ����书ϴ���Ǵ�8��'},
		{'����-÷ׯ�����ϣ�*�ӵ��γ���������󴥷�ս����*VS ÷ׯ���ѣ�ս������������',21,'������'},
		{'����-�����ھ֣����ϣ�*�����м䷿�䴥�����飬��а��֧*ѡ���ǡ���������壬��������*ѡ�񡺷񡻽���а��',22,'������*����:�����[����]���� ����影�����Ṧ+40 ����Ӳ���޻ָ�����'},
		{'�����ߡ����������ϣ�*������ڶӣ������ջ��Ī�󴥷�����',23,'������'},
		{'�����ߡ�����ɽ��-�����£���ԭ��*������ڶӣ������ȶԻ�������ս����*VS ��֤+����Ⱥ+������+�۴�+����+����+����+����+����+Ī��+���ֵ���,ʤ�á��������ơ�',24,'������*�������ơ�ȭ���ؼ���'},--�����书�������Ƴ���
		{'�����ߡ����������ϣ�*������ڶӣ������ջ��Ī�󴥷�����',23,'������'},
		{'�����ߡ����������ϣ�*������ڶӣ������ջ��Ī�󴥷�����',23,'������'},
		{'�����ߡ����������ϣ�*������ڶӣ������ջ��Ī�󴥷�����',23,'������'},
	}
	--�齣����¼
	local Shu = {
		{'��������ӽ�ʶ�¼���',0,'����������+1'},
		{'������δ��ɣ���ȴ�����',1,'����������+1'},
		{'������δ��ɣ���ȴ�����',2,'����������+1'},
		{'������δ��ɣ���ȴ�����',3,'����������+1'},
		{'������δ��ɣ���ȴ�����',4,'����������+1'},
	}
	--�������
	local Shen = {
		{'��Ĺ��Ѱ��С��Ů',0,'����������+1'},
		{'������δ��ɣ���ȴ�����',1,'����������+1'},
		{'������δ��ɣ���ȴ�����',2,'����������+1'},
		{'������δ��ɣ���ȴ�����',3,'����������+1'},
		{'������δ��ɣ���ȴ�����',4,'����������+1'},
	}
	--������
	local Xia = {
		{'���ſ�ջѰ�Ҷ����Ի�',0,'����������+1'},
		{'������δ��ɣ���ȴ�����',1,'����������+1'},
		{'������δ��ɣ���ȴ�����',2,'����������+1'},
		{'������δ��ɣ���ȴ�����',3,'����������+1'},
		{'������δ��ɣ���ȴ�����',4,'����������+1'},
	}
	--����������
	local Yi = {
		{'�츮�����޼ɺ������Ի�',0,'����������+1'},
		{'������δ��ɣ���ȴ�����',1,'����������+1'},
		{'������δ��ɣ���ȴ�����',2,'����������+1'},
		{'������δ��ɣ���ȴ�����',3,'����������+1'},
		{'������δ��ɣ���ȴ�����',4,'����������+1'},
	}
	--��Ѫ��
	local Bi = {
		{'������������Ի�',0,'����������+1'},
		{'������δ��ɣ���ȴ�����',1,'����������+1'},
		{'������δ��ɣ���ȴ�����',2,'����������+1'},
		{'������δ��ɣ���ȴ�����',3,'����������+1'},
		{'������δ��ɣ���ȴ�����',4,'����������+1'},
	}
	--ԧ�쵶
	local Yuan = {
		{'����������',0,'����������+1'},
		{'������δ��ɣ���ȴ�����',1,'����������+1'},
		{'������δ��ɣ���ȴ�����',2,'����������+1'},
		{'������δ��ɣ���ȴ�����',3,'����������+1'},
		{'������δ��ɣ���ȴ�����',4,'����������+1'},
	}

	--С�������ռ�
	local xiaoyao = {
		{'�����˲�','С�������ռ�','���ſ�ջ���������ڽ�������а��֮ǰ�����¡�75ʱ��������Ի�����������ӣ�*ֱ�Ӵ�����ȥ�����£������������ӣ�����+10����á����־�������*���������������а�������´�սʱ������Ϊ�̶����Ժ��书',0,'������*����[����] ����'},
		{'�����˲�','С�������ռ�','�޹�ɽ����ԭ�������ڶӣ������ǺӶԻ�������������Ӵ�������',1,'������'},
		{'�����˲�','С�������ռ�','�޹�ɽ����ԭ������Ի����������',2,'������*��ɽ������[ȭ���ؼ�]*С���๦[�ڹ��ؼ�] *������ʽ[�����ؼ�] *����[����]���� *��������*����+10���������*��һ���书ϴ��ɽ������4��*�ڶ����书ϴС���๦4��*�츳���ӣ��Դ���ڤ��������800����'},
		{'�����˲�','С�������ռ�','���޺��������������ڶ��飬����ս����*VS������+��������ʤ��á������󷨡�����ľ��������������ʬ����',3,'������*����+5 *������[�ڹ��ؼ�] *������ʬ��[ָ���ؼ�] *��ľ����[�������]'},
		{'�����˲�','С�������ռ�','�޹�ɽ����ԭ�������ǺӶԻ���á��߱�ָ����',4,'������*�߱�ָ��[����]'},
		{'�����˲�','С�������ռ�','��ɽ-��ɽɽ´����ԭ�����볡��������ս����*VS ׿�������ˣ�ʤ���֪��ɽͯ�������Ļʹ����������',5,'������'},
		{'�����˲�','С�������ռ�','����-���Ļʹ��������������ݽ������Ļʹ���������෿�䴥��ս����*����+����VS����ˮ��ʤ����������Ļʹ����ϽǷ���Ի�����¶��������¶���',6,'����������¶[����]����*����ָѨ[ָ���ؼ�]*�׺�����[ȭ���ؼ�]'},
		{'�����˲�','С�������ռ�','���չ�������������¶�ڶӣ����볡������ս����*VS ׿������ʤ���á������Ҽ�����ܹ�����������������á��߱�ָ����',7,'������*�����Ҽ[�ڹ��ؼ�] *�ܹ�����[�����ؼ�]*�߱�ָ��[����]*����[����]����'},
		{'�����˲�','С�������ռ�','���չ����������������չ����������ۿ����һ�űڻ�����á��˻����Ϲ��������·��������ܿɻ�á���ɽ��÷�֡�*��������ϴ�书�������ʿ��԰������߳�����',8,'������*ɽ��÷��[ȭ���ؼ�]*�˻����Ϲ�[�ڹ��ؼ�]*��������*����+10 �������书�˻����Ϲ�1������ð˻�ʱ��*������书ϴ��ɽ��÷��1������ɽ��÷���������������ʱ�Ϊ50�������ɽ��÷��ʱ��'},
		{'�����˲�','С�������ռ�','���չ���������ѧ�᡾�˻����Ϲ��� ����ڤ�񹦡���С���๦�����չ��м䷿�ӽ�ȥ�Ե���ո񴥷���ս�����ӽ�������ң���硿',9,'������*�����ؼ�����ң���硿'},
	}

	--֧�߾���
	local zhixian = {
		{'�����˲�','С�������ռ�','���ſ�ջ��������*�ڽ�������а��֮ǰ�����¡�75ʱ��������Ի�����������ӣ�*ֱ�Ӵ�����ȥ�����£������������ӣ�����+10����á����־�������*���������������а�������´�սʱ������Ϊ�̶����Ժ��书',0,'������*����[����] ����'},
		{'�����˲�','������','����-�����£�������*��á������˲����󲻴����������Ϸ��������ܣ�����ս��VS ��˼ƽ+������սʤ���ɻ�á������񽣡������鵤����ǧ����֥����սʧ��ֻ�ɻ�á������񽣡�',0,'������*������[ָ���ؼ�] *���鵤[��ҩ]����սʤ�� *ǧ����֥[��ҩ]����սʤ�� *��˼ƽ��������һ���书ϴ������һ������սʤ��'},
		{'�����˲�','�ڼ�����','����-�����루���ϣ���������*�����ϣ���������������ݴ���ս��VS Ľ�ݸ����ڼ�������սʤ�����С��',0,'������*����[����] ����'},
		{'�����˲�','ɨ�صĿ���','����ɽ��-�����£���ԭ����������*�õ��������ɨ��ɮ�Ի�������ս��*VS ɨ��ɮ+����+����+����+���ֵ��ӣ���ս�ɰܣ�*�����Ƿ�սʤ����ר��װ��[����]',0,'������*������ϵ����ֵ+10 *����[����]�������Ƿ�ר����'},
		{'�����˲�','һέ�ɽ�','����ɽ��-�����£���ԭ��*��ɨ��ɮ�Ի���ɨ�������ܿո񴥷�ս��*VS ɨ��ɮ',0,'������*һέ�ɽ�[�Ṧ�ؼ�]'},
		{'�����˲�','�׽','����ɽ��-�����£���ԭ��*�õ�һέ�ɽ���ɨ���ұ���ܿո񴥷�ս��*VS ��Ħ����Ħ50%Ѫ��Ź�300ʱ�򼴿ɣ�',0,'������*�׽[�ڹ��ؼ�]'},
		{'�����˲�','Ľ�ݾ�ѧ','����-�����루���ϣ�*Ľ�ݸ��ڶӣ�ȥ���½Ƿ�������ϵ���ɻ�á��κ�ָ�������κϽ�������������6000���Żᴥ�����ž���,���ž����ڵ�һ����������Ϳ��Դ������Ի������ܿ����ò��»��ѻ�õ��ؼ���',0,'������*�׽[�ڹ��ؼ�]'},
		{'�����˲�','���ϳ���','�������Ϲȣ�������*��ȥ�����¶Ի����Ϸ���ɮ�ˣ��õ����������Ϲȡ�����Ϣ�������߱�ָ������Ĺ������ң�ӳ��֣�VS ��ң�ӣ����2000ʱ����ɻ�ʤ��սʤ�����ؼ������ϳ���������������ѩ����',0,'������*���ϳ�����[�ڹ��ؼ�]*������ѩ��[�����ؼ�]'},
		{'�����˲�','��ڤ��','��а�ߡ�����-�����£�������*����������Ľ�ݸ���������ڼ��������ڶӣ��������飬*VS �Ƿ�+����+����+��������ɮ*ս��������á���ڤ�񹦡���ǧ����֥�����鵤',0,'������*����-10 *��ڤ��[�ڹ��ؼ�] *���鵤[��ҩ] *ǧ����֥[��ҩ]'},
		{'�����˲�','����΢��','����ɽ-����ɽ����������*����ɽ����������ɽ���������񣬾���󴥷�ս����*VS ��ң���ϣ�������+��ɽͯ��+����ˮ��ʤ���á��貨΢����',0,'������*�貨΢��[�Ṧ�ؼ�]*�����̽������츳�ṦϴΪ�貨΢��'},
		{'���Ӣ�۴�','�ϵ۱�ؤ','��ɽ��-��ɽ��ɽ����ԭ��*�õ������Ӣ�۴����󣬻�ɽ��ɽ�ԵĽ�����ȥ��һֱ���ң��߹�ʯ�������뻪ɽ�����������������ս����*VS ���߹�+ŷ���棬ս����ַ�֧��*ѡ��ﱱؤ�� VS ŷ���棬ʤ�����[�򹷰�]�����򹷰�����*ѡ��������� VS ���߹���ʤ�����[��������]���������ȷ���',0,'������*����+2*������ؤ���򹷰�[����] �򹷰���[�����ؼ�]*������������������[����] �����ȷ�[�����ؼ�]'},
		{'���Ӣ�۴�','��������','�����ߡ�����������ԭ��*�õ������Ӣ�۴������¡�90ʱ���𴦻��Ի����������͡����칦�ؼ��������¡�99ʱ���𴦻��Ի�����������[�����澭�Ͼ�]�������귭��',0,'������*���칦�ؼ�[�ڹ��ؼ�] *�����澭�Ͼ�[�������] *�����귭[�Ṧ�ؼ�]'},
		{'���Ӣ�۴�','��ʵ���','�����ߡ�һ�ƾӣ����ϣ�*����Ի����գ�����Ӣ�ڶ��飬�ٴ�����Ի����ɽ���',0,'������*��ʵ���[�����ؼ�]'},	
		{'���Ӣ�۴�','��֮����','�����ߡ��һ��������⣩*���¡�80������������ضԻ�����С�����չ������������',0,'������*����+1 *��Ѫ����[����] *��⬼�[����]�ջ��ػ�� *����[����]���루��ѡ������*����[����]����'},
		{'���Ӣ�۴�','�ڷ�˫ɷ','��а�ߡ����붴����ԭ��*��÷����Ի���ѡ���ǡ��������,*�ɹŰ���������*������Ի���ѡ�� ���ǡ� ���佻��*VS �����߹֣�*ʤ���� [��Ѫ����]�������׹�צ��',0,'������*÷����[����]*�����׹�צ[ָ���ؼ�]*��Ѫ����[����]'},
		{'���Ӣ�۴�','�����澭','��а�ߡ�����-ţ�Ҵ壨���ϣ�*һ�ƾ�ս��������ŷ����Ի���ѡ���ǡ���á������澭��',0,'������*����-1 *�����澭[�ڹ��ؼ�] *���������������ϴ�����澭���츳�ڹ�ϴ�����澭'},
		{'¹����','����֮��','����-�����˼䣨���ϣ�*��ΤС���Ի�������ΤС�������桢�������',0,'������*ΤС��[����] ���� *����[����] ���� *����[����] ����'},--��ǴӴ˴�δд
		{'¹����','���ݱ���','�ʹ���Ӯ���ݣ�������������*�������ݸ����Ի����ӱ���Ĺ��ӣ������ص������ұ��䣺*[����]*5000 [��ǹ] [��˿����]����ղ����塿�����аٱ䡿',6,'������*����*5000 *��˿����[����] *��ղ�����[�ڹ��ؼ�] *��ǹ[����] *���аٱ�[�Ṧ�ؼ�] *ΤС��������*��һ���书ϴ��ǹ�� �ڶ����书ϴ���аٱ�1�� *�츳�⹦ϴΪ��ǹ �츳�ṦϴΪ���аٱ�'},
		{'Ц������','��ɫ���','�嶾�̣�������*���Ц������֮ǰ����ӯӯ�ڶ�ʱ��������˶Ի���������������',0,'������*��ɳ�����[�����ؼ�] *�����[����] *����影������������+100'},
		{'ԧ�쵶','֧��һ','����ɽ��-�����£���ԭ���õ�һέ�ɽ���ɨ���ұ���ܿո񴥷�ս��*VS ��Ħ����Ħ50%Ѫ��Ź�300ʱ�򼴿ɣ�',0,'������*�׽[�ڹ��ؼ�]'},
		{'ԧ�쵶','֧��һ','����ɽ��-�����£���ԭ���õ�һέ�ɽ���ɨ���ұ���ܿո񴥷�ս��*VS ��Ħ����Ħ50%Ѫ��Ź�300ʱ�򼴿ɣ�',0,'������*�׽[�ڹ��ؼ�]'},
		{'�ɺ��⴫','�ж�����ǿ','��ɽ�����ϣ���ջ�Ի��Ʒɺ裬ս����*VS�Ʒɺ裬ʤ���á���Ӱ�š�',0,'������*��Ӱ��[ָ���ؼ�]'},
	}
	local Kend = '�����ȫ������'
	local TS = {Fei,Xue,Lian,Tian,She,Bai,Lu,Xiao,Shu,Shen,Xia,Yi,Bi,Yuan}
	local tb = 1
	--lib.Background(bx*100,by*40,)
	local pw,ph = lib.GetPNGXY(91,506*2)

	local px,py = -1,-1
	local tsname = ''
	local line = 1
	local JUQING = {'�������','֧�߾���'}
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
		local title = '��������'
		DrawString(CC.ScreenW/2-string.len(title)/4*size*1.3,CC.ScreenH/2-ph/2+size/2,'��������',M_DarkOrange,size*1.3,CC.FONT2)	
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
					jq = '�����ȫ������' 
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
						jq = '�����ȫ������' 
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

	