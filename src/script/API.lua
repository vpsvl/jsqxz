--��������
--PlayWavAtk(50) --ŮЦ



--�����ռ���

--1������ж�ս������
--2������ж��з�
--3
--���ɶ���
--local nexty = CC.MainSubMenuY + CC.SingleLineHeight
--local p = TeamMenu_Mp(CC.MainSubMenuX, nexty,1)
--local id = JY.Base["����" .. p] 

--�̶����ʣ�����������Ч���ʵļӳ�
lib.SetWarMap(x, y, level, v)
--local w, h = lib.GetPNGXY(91, 3* 2)
--��֮��Ů4100
--����  691
--4506 ��ͼ
--��ɫ��=red��=gold��=black  �� ��=white��=orange ��=��ɫ ��= ��ɫ "�̣ģ���"��  �� =��  ����
--SetS(id,x,y,level,v) /��1������������ID,/��2��������������X����, /��3��������������Y����, /��4���������㣬��Χ0-5���ֱ�Ϊ����㣬�����㣬���в㣬�¼��� �������Σ����к���, /��5���������޸ĵ�ֵ.
--GetS(id,x,y,level)? ?? ???--�����ȡֵ������SetS��Ӧ
--SetD(Sceneid,id,i,v)
------------------------
--SetD(Sceneid,id,i,v) /��1��������������ţ�-2��ʾ��ǰ����,/��2������������λ�ñ��,/��3���������¼��㣬��Χ0-10����Ӧ����instruct_3�����ĵ�3������-��13������,/��4����������Ҫ�޸ĵ�ֵ
--�Ƚϳ��õķ����������ж��¼��Ƿ��Ѿ�����
--if lib.GetPlatform()=="Android" then

--? ?? ??--?if GetD(70,65,2) > 0 then
--? ?? ?? --?? ?Talk(��С���ұߵ�ľ׮���ԶԻ������¼���,0);
--? ?? ??--?end
--? ?? ???Talk(GetD(70,4,2), 0);? ?? ???--����Ի��������¼�
--? ?? ???Talk(GetD(70,4,3), 0);? ?? ???--����ʹ����Ʒ�������¼�
--? ?? ???Talk(GetD(70,4,5), 0);? ?? ???--�������ͼ
-------------------------
--instruct_25(38,51,31,51)  --�����ƶ�
--instruct_40(0)  --���������� 0�� 1��  2 ��  3 ��
--DrawStrBoxWaitKey("��һ�����򵶽��������", C_GOLD, CC.DefaultFont,nil, C_RED)
--My_Enter_SubScene(110,28,32,0)  --������Ծ
--SetTF(id,tf,1) --�趨�츳
--SetTF(id,tf,nil) --ɾ�츳	local x0 = WAR.Person[WAR.CurID]["����X"]
	--local y0 = WAR.Person[WAR.CurID]["����Y"]
       --War_ShowFight(WAR.Person[WAR.CurID]["������"], 0, -1, 0, WAR.Person[WAR.CurID]["����X"], WAR.Person[WAR.CurID]["����Y"], 35)
--awakening(633, 1) --����
--"..JY.Person[0]["����"].."
--table.sort(table) -- ������ 
--0���� 1���� 2�䵱 3��ң 4���� 5���� 6��� 7ȫ�� 8ؤ�� 9��ɽ 10��ɽ 11��� 12��ɽ 13��ɽ 14̩ɽ 15�嶾 16��Ĺ 17Ѫ�� 
--18���� 19��ü 20��� 21���� 22�һ� 23���� 24������ 25���� 26Ľ�� 27������ 28���� 29���� 30�ؽ�
--һ {1,'��Ѫ'},{2,'��Ѩ'},{3,'����'},{4,'����'},{5,'����'},{6,'�ж�'}
--�� {23,'������'},{24,'�ӱ���'},{25,'�ӱ���'},{28,'����'},{31,'�Ӹ�'},{32,'������'} 
--�� {9,'�綾'},{12,'����'},{22,'����'},{27,'����'},{33,'ɢ��'},{34,'����'}
--�� {13,'�Ʒ�'},{14,'����ϵ��'},{15,'�̶��˺�'},{16,'��Ѫ'},{17,'����'},{18,'����'}
--�� {7,'����'},{8,'��ȼ'},{19,'������'},{20,'˫��'},{26,'����'},{29,'����'} 
--�� {11,'˺��'},{21,'�ٴ��ж�'},{30,'����'},{10,'ѣ��'},{35,'����'},{36,'�־�'},{37,'hp�˺�'}
--        --����������
--War_ShowFight(pid, wugong, JY.Wugong[wugong]["�书����"], level, x, y, dhxg, ZHEN_ID)	
if JY.Person[0]["�Ա�"] == 0 then
       TalkEx("ʲô���鷳�����Ұ������Ĵ�æ�Ŷԣ�", 77, 1)  --�Ի�
else
	TalkEx("ʲô���鷳�����Ұ������Ĵ�æ�Ŷԣ�", 77, 1)  --�Ի�
end
local size = 60
local offx = (#"�ڶ���")*size/4
local offy = size/2
local x = CC.ScreenW/2;
local y = CC.ScreenH/2;
lib.Background(0,y-y/4,CC.ScreenW,y+y/4,98)
DrawString(x-offx,y-offy,"�ڶ���",M_DeepSkyBlue,size);  --��ҹ˼
ShowScreen();
lib.Delay(1500);
Cls()

--1,����λ�ñ��
--2,�¼�λ�ñ��
--3,ͨ��/��ͨ��
--4,�¼��籾�ļ����
--5,�����¼���ʽ
--6,��ͼ

addevent(4, 3, 1, 1179, 1, 2366*2)


--jymain.lua �����б�


function IncludeFile()              --��������ģ��
function SetGlobal()   --������Ϸ�ڲ�ʹ�õ�ȫ�̱���
function JY_Main()        --���������
function myErrFun(err)      --��������ӡ������Ϣ
function JY_Main_sub()        --��������Ϸ���������
function NewGame()     --ѡ������Ϸ���������ǳ�ʼ����
local function DrawAttrib(str)    --�����ڲ�����
function Game_Cycle()       --��Ϸ��ѭ��
function Game_MMap()      --����ͼ
function GetMyPic()      --�������ǵ�ǰ��ͼ
function AddMyCurrentPic()        ---���ӵ�ǰ������·����֡,
function CanEnterScene(id,x,y)         --�����Ƿ�ɽ�
function MMenu()      --���˵�
function Menu_System()         --ϵͳ�Ӳ˵�
function Menu_Exit()      --�뿪�˵�
function Menu_SaveRecord()         --������Ȳ˵�
function Menu_ReadRecord()        --��ȡ���Ȳ˵�
function Menu_Status()           --״̬�Ӳ˵�
function Menu_PersonExit()        --���Exit
function SelectTeamMenu(x,y)          --����ѡ������˵�
function ShowPersonStatus(id)        --��ʾ��״̬
local function DrawAttrib(str,color1,color2,v)    --�����ڲ�����
function TrainNeedExp(id)         --��������������Ʒ�ɹ���Ҫ�ĵ���
function Menu_Doctor()       --ҽ�Ʋ˵�
function ExecDoctor(id1,id2)      --ִ��ҽ��
function Menu_DecPoison()         --�ⶾ
function ExecDecPoison(id1,id2)     --ִ�нⶾ
function Menu_Thing()       --��Ʒ�˵�
function SelectThing(thing,thingnum)        --��ʾ��Ʒ��ѡ��
function Game_SMap()         --��������������
function SceneCanPass(x,y)  --��������(x,y)�Ƿ����ͨ��
function DtoSMap()          ---D*�е��¼����ݸ��Ƶ�S*�У�ͬʱ������Ч����
function DrawSMap()       --�泡����ͼ
function LoadRecord(id)       -- ��ȡ��Ϸ����
function SaveRecord(id)         -- д��Ϸ����
function filelength(filename)         --�õ��ļ�����
function GetS(id,x,y,level)       --��S������
function SetS(id,x,y,level,v)       --дS��
function GetD(Sceneid,id,i)          --��D*
function SetD(Sceneid,id,i,v)         --дD��
function LoadData(t,t_struct,data)        --��ȡR������
function SaveData(t,t_struct,data)      --дR������
function limitX(x,minv,maxv)       --����x�ķ�Χ
function RGB(r,g,b)          --������ɫRGB
function GetRGB(color)      --������ɫ��RGB����
function WaitKey()       --�ȴ���������
function DrawBox(x1,y1,x2,y2,color)         --����һ���������İ�ɫ����
function DrawBox_1(x1,y1,x2,y2,color)       --�����Ľǰ����ķ���
function DrawString(x,y,str,color,size)         --��ʾ��Ӱ�ַ���
function DrawStrBox(x,y,str,color,size)         --��ʾ������ַ���
function DrawStrBoxYesNo(x,y,str,color,size)        --��ʾ�ַ�����ѯ��Y/N
function DrawStrBoxWaitKey(s,color,size)          --��ʾ�ַ������ȴ�����
function Rnd(i)           --�����
function AddPersonAttrib(id,str,value)            --������������
function PlayMIDI(id)             --����midi
function PlayWavAtk(id)             --������Чatk***
function PlayWavE(id)              --������Чe**
function ShowScreen()              --ˢ����Ļ��ʾ
function ShowMenu(menuItem,numItem,numShow,x1,y1,x2,y2,isBox,isEsc,size,color,selectColor)     --ͨ�ò˵�����
function UseThing(id)             --��Ʒʹ��
function DefaultUseThing(id)                --ȱʡ��Ʒʹ�ú���
function UseThing_Type0(id)              --������Ʒʹ��
function UseThing_Type1(id)            --װ����Ʒʹ��
function CanUseThing(id,personid)           --�ж�һ�����Ƿ����װ��������һ����Ʒ
function UseThing_Type2(id)               --�ؼ���Ʒʹ��
function UseThing_Type3(id)        --ҩƷ��Ʒʹ��
function UseThingEffect(id,personid)          --ҩƷʹ��ʵ��Ч��
local function ThingAddAttrib(s)     ---����ֲ������������ҩ����������
function UseThing_Type4(id)             --������Ʒʹ��
function EventExecute(id,flag)               --�¼����������
function oldEventExecute(flag)            --����ԭ�е�ָ��λ�õĺ���
function ChangeMMap(x,y,direct)          --�ı���ͼ����
function ChangeSMap(sceneid,x,y,direct)       --�ı䵱ǰ����
function Cls(x1,y1,x2,y2)                    --�����Ļ
function GenTalkString(str,n)              --�����Ի���ʾ��Ҫ���ַ���
function Talk(s,personid)            --��򵥰汾�Ի�
function TalkEx(s,headid,flag)          --���Ӱ汾�Ի�
function instruct_test(s)
function instruct_0()         --����
function instruct_1(talkid,headid,flag)        --�Ի�
function instruct_2(thingid,num)            --�õ���Ʒ
function instruct_2_sub()               --����>200�Լ�14�����õ�������
function instruct_3(sceneid,id,v0,v1,v2,v3,v4,v5,v6,v7,v8,v9,v10)     --�޸�D*
       -- �����Ķ��壺function instruct_3(sceneid,id,v0,v1,v2,v3,v4,v5,v6,v7,v8,v9,v10)
       -- ��ӵĺ������޸��¼����ݣ�D*�¼�����һ����13������
       -- ��1��������������ţ�-2��ʾ��ǰ����
       -- ��2������������λ�ñ��
       -- ��3���������Ƿ���ͨ����0����ͨ����1����ס�߲���
       -- ��4�������������ף�����д0
       -- ��5����������һ���¼���ţ��ո񴥷������봥��ֱ��д0
       -- ��6���������ڶ����¼���ţ�ʹ����Ʒ����
       -- ��7���������������¼���ţ��߹�ʱ�Զ�����
       -- ��8����������ʼ��ͼ��ţ�-2��ʾ��ͼ���䣬0��ʾ�����ͼ
       -- ��9��������������ͼ��ţ�-2��ʾ��ͼ���䣬0��ʾ�����ͼ
       -- ��10����������ʱ��ͼ��ţ�-2��ʾ��ͼ���䣬0��ʾ�����ͼ
       -- ��11�������������ӳ٣�-2��ʾ����
       -- ��12��������������X��-2��ʾ���䣬������λ��Ϊ0ʱ����XY������Ч
       -- ��13��������������Y��-2��ʾ����
function instruct_4(thingid)         --�Ƿ�ʹ����Ʒ����
function instruct_5()         --ѡ��ս��
function instruct_6(warid,tmp,tmp,flag)      --ս��
function instruct_7()                 --�Ѿ�����Ϊreturn��
function instruct_8(musicid)            --�ı�����ͼ����
function instruct_9()                --�Ƿ�Ҫ��������
function instruct_10(personid)            --�����Ա
function instruct_11()              --�Ƿ�ס��
function instruct_12()             --ס�ޣ��ظ�����
function instruct_13()            --��������
function instruct_14()             --�������
function instruct_15()          --game over
function instruct_16(personid)      --�������Ƿ���ĳ��
function instruct_17(sceneid,level,x,y,v)     --�޸ĳ���ͼ��
function instruct_18(thingid)           --�Ƿ���ĳ����Ʒ
function instruct_19(x,y)             --�ı�����λ��
function instruct_20()                 --�ж϶����Ƿ���
function instruct_21(personid)               --���
function instruct_22()            --������Ϊ0
function instruct_23(personid,value)           --�����ö�
function instruct_24()
function instruct_25(x1,y1,x2,y2)             --�����ƶ�
function instruct_26(sceneid,id,v1,v2,v3)           --����D*���
function instruct_27(id,startpic,endpic)           --��ʾ����
function instruct_28(personid,vmin,vmax)          --�ж�Ʒ��
function instruct_29(personid,vmin,vmax)           --�жϹ�����
function instruct_30(x1,y1,x2,y2)                --�����߶�
function instruct_30_sub(direct)            --�����߶�sub
function instruct_31(num)             --�ж��Ƿ�Ǯ
function instruct_32(thingid,num)           --������Ʒ
function instruct_33(personid,wugongid,flag)           --ѧ���书
function instruct_34(id,value)              --��������
function instruct_35(personid,id,wugongid,wugonglevel)         --�����书
function instruct_36(sex)               --�ж������Ա�
function instruct_37(v)              --����Ʒ��
function instruct_38(sceneid,level,oldpic,newpic)         --�޸ĳ���ĳ����ͼ
function instruct_39(sceneid)             --�򿪳���
function instruct_40(v)                --�ı����Ƿ��� 0���ң�1���£�2���ϣ�3����
function instruct_41(personid,thingid,num)        --������Ա������Ʒ
function instruct_42()          --�������Ƿ���Ů��
function instruct_43(thingid)        --�Ƿ���ĳ����Ʒ
function instruct_44(id1,startpic1,endpic1,id2,startpic2,endpic2)     --ͬʱ��ʾ��������
function instruct_45(id,value)        --�����Ṧ
function instruct_46(id,value)            --��������
function instruct_47(id,value)     --���ӹ�����
function instruct_48(id,value)         --��������
function instruct_49(personid,value)       --������������
function instruct_50(id1,id2,id3,id4,id5)       --�ж��Ƿ���5����Ʒ
function instruct_51()     --����������
function instruct_52()       --��Ʒ��
function instruct_53()        --������
function instruct_54()        --������������
function instruct_55(id,num)      --�ж�D*��ŵĴ����¼�
function instruct_56(v)             --��������
function instruct_57()       --�߲��Թ�����
function instruct_58()           --���������
function instruct_59()           --ȫ���Ա���
function instruct_60(sceneid,id,num)          --�ж�D*ͼƬ
function instruct_61()               --�ж��Ƿ����14����
function instruct_62(id1,startnum1,endnum1,id2,startnum2,endnum2)      --����ʱ�ջ�����������
function instruct_63(personid,sex)          --�����Ա�
function instruct_64()                 --С��������
function instruct_65()           --С��ȥ������ջ
function instruct_66(id)       --��������
function instruct_67(id)      --������Ч
function instruct_68(id,mj,flag,n) --ѧ���ؼ�id�����ţ�mj�ؼ���ţ�flag = 0���� =1ѧ��,n = 1�Ѿ�ѧϰ = 0��ѧϰ
function instruct_69(thingid)--�Ƿ��ù���Ʒ
function instruct_69(pid) --ϴ���书
function instruct_70(pid) --ϴ���书      
function WarSetGlobal()            --����ս��ȫ�̱���
function WarLoad(warid)               --ս��������
function WarMain(warid,isexp)
function War_PersonLostLife()             --����ս����ÿ�غ������ж������˶���Ѫ
function War_EndPersonData(isexp,warStatus)            --ս���Ժ������������
function War_AddPersonLevel(pid)      --�����Ƿ�����
function War_PersonTrainBook(pid)           --ս���������ؼ��Ƿ�ɹ�
function War_PersonTrainDrug(pid)         --ս�����Ƿ���������Ʒ
function War_isEnd()           --ս���Ƿ����
function WarSelectTeam()            --ѡ���ҷ���ս��
function WarSelectMenu(newmenu,newid)            --ѡ��ս���˲˵����ú���
function WarSelectEnemy()            --ѡ��з���ս��
function WarLoadMap(mapid)          --��ȡս����ͼ
function WarDrawMap(flag,movex,movey)            --��ս����ͼ
function WarDrawEffect(pic)           --��ʾ�书Ч��
function WarPersonSort()               --ս�����ﰴ�Ṧ����
function WarSetPerson()            --����ս������λ��
function WarCalPersonPic(id)       --����ս��������ͼ
function War_Manual()                --�ֶ�ս��
function WarShowHead()               --��ʾս����ͷ��
function War_MoveMenu()           --ִ���ƶ��˵�
function War_CalMoveStep(id,stepmax,flag)                   --������ƶ�����
function War_SelectMove()              ---ѡ���ƶ�λ��
function War_MovePerson(x,y)            --�ƶ����ﵽλ��x,y
function War_FightMenu()              --ִ�й����˵�
function War_Fight_Sub(id,wugongnum,x,y)          --ִ��ս��
function War_FightSelectType0(wugong,level,x1,y1)          --ѡ��㹥��
function War_FightSelectType1(wugong,level,x,y)            --ѡ���߹���
function War_FightSelectType2(wugong,level)                 --ѡ��ʮ�ֹ���
function War_FightSelectType3(wugong,level,x1,y1)            --ѡ���湥��
function War_Direct(x1,y1,x2,y2)             --�����˷���
function War_ShowFight(pid,wugong,wugongtype,eft)              --��ʾս������
function War_WugongHurtLife(emenyid,wugong,level)             --�����书�˺�����
function War_WugongHurtNeili(enemyid,wugong,level)           --�����书�˺�����
function War_PoisonMenu()              ---�ö��˵�
function War_PoisonHurt(pid,emenyid)     --��������ж�����
function War_DecPoisonMenu()          ---�ⶾ�˵�
function War_DoctorMenu()            ---ҽ�Ʋ˵�
function War_ExecuteMenu(flag,thingid)            ---ִ��ҽ�ƣ��ⶾ�ö�����
function War_ExecuteMenu_Sub(x1,y1,flag,thingid)     ---ִ��ҽ�ƣ��ⶾ�ö��������Ӻ������Զ�ҽ��Ҳ�ɵ���
function War_ThingMenu()            --ս����Ʒ�˵�
function War_UseAnqi(id)          ---ս��ʹ�ð���
function War_AnqiHurt(pid,emenyid,thingid)         --���㰵���˺�
function War_RestMenu()           --��Ϣ
function War_WaitMenu()            --�ȴ����ѵ�ǰս���˵�����β
function War_StatusMenu()          --ս������ʾ״̬
function War_AutoMenu()           --�����Զ�ս��
function War_Auto()             --�Զ�ս��������
function War_Think()           --˼�����ս��
function War_ThinkDrug(flag)             --�ܷ��ҩ���Ӳ���
function War_ThinkDoctor()          --�����Ƿ���Լ�ҽ��
function War_AutoFight()             ---ִ���Զ�ս��
function War_AutoSelectWugong()           --�Զ�ѡ����ʵ��书
function War_AutoSelectEnemy()             --ѡ��ս������
function War_AutoSelectEnemy_near()              --ѡ���������
function War_AutoMove(wugongnum)              --�Զ������˷����ƶ�
function War_GetCanFightEnemyXY(scope)             --�õ������ߵ����������˵����λ��
function War_AutoCalMaxEnemy(x,y,wugongid,level)       --�����(x,y)��ʼ��������ܹ����м�������
function War_AutoExecuteFight(wugongnum)            --�Զ�ִ��ս������ʾ��������
function War_AutoEscape()                --����
function War_AutoEatDrug(flag)          ---��ҩ�Ӳ���
function War_AutoDoctor()            --�Զ�ҽ��
       
       
-- 240����50����
-- 241����50����
-- 242����50����
-- 27��������
-- ���л۵�������
--64�ܲ�ͨ��������
--С�ѵ�������
--344Ʒ������
--658Ʒ������
--191 Ʒ�����ã�������
--192 Ʒ�����ã���а��
--JY.Person[193]["Ʒ��"] ==80����ӹ��
--JY.Person[194]["Ʒ��"] ==60��ԧ�쵶�����֣�