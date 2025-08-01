-- 0���� 1���� 2�䵱 3��ң 4���� 5���� 6��� 7ȫ�� 8ؤ�� 9��ɽ 10��ɽ 11��� 12��ɽ 13��ɽ 14̩ɽ 15�嶾 16��Ĺ 17Ѫ�� 18���� 19��ü 20��� 21���� 22�һ� 23���� 24������ 25���� 26Ľ�� 27������ 28���� 29���� 30�ؽ�
function IncludeFile()
    package.path = CONFIG.ScriptLuaPath; -- ���ü���·������Сд����Ҫһ��
    require("dkjson")
    require("jyconst") -- ���������ļ���ʹ��require�����ظ�����
    require("jywar")
    require("jyacvmts")
    require("kdef")
    require("ItemInfo")
    require("Pmiji_info")
    require("KF_info")
    require("jyptf")
    require("jymenu")
    require("tx")
	require("custom")
    --require("Menu")
end

function SetGlobal() -- ������Ϸ�ڲ�ʹ�õ�ȫ�̱���  
    JY = {};
    JY.HPDisplay = CONFIG.HPDisplay  --ս����Ѫ
    JY.BattleDelay= CONFIG.BattleDelay --ս���ٶ�
    JY.Operation = CONFIG.Operation
    JY.Status = GAME_INIT; -- ��Ϸ��ǰ״̬
    -- ����R������
    JY.Base = {}; -- ��������
    JY.PersonNum = 0; -- �������
    JY.Person = {}; -- ��������
    JY.ThingNum = 0 -- ��Ʒ����
    JY.Thing = {}; -- ��Ʒ����
    JY.SceneNum = 0 -- ��������
    JY.Scene = {}; -- ��������
    JY.WugongNum = 0 -- �书����
    JY.Wugong = {}; -- �书����
    JY.ShopNum = 0 -- �̵�����
    JY.Shop = {}; -- �̵�����
    JY.TejiNum = 0 -- �ؼ�����
    JY.Teji = {}; -- �ؼ�����

    JY.MyCurrentPic = 0 -- ���ǵ�ǰ��·��ͼ����ͼ�ļ���ƫ��
    JY.MyPic = 0 -- ���ǵ�ǰ��ͼ
    JY.Mytick = 0 -- ����û����·�ĳ���֡��
    JY.MyTick2 = 0 -- ��ʾ�¼������Ľ���
    JY.LOADTIME = 0
    JY.SAVETIME = 0
    JY.GTIME = 0 -- ��Ϸʱ��
    JY.GOLD = 0 -- ��Ϸ����

    JY.SubScene = -1; -- ��ǰ�ӳ������
    JY.SubSceneX = 0; -- �ӳ�����ʾλ��ƫ�ƣ������ƶ�ָ��ʹ��
    JY.SubSceneY = 0;
    JY.ThingUse = -1;
    JY.Darkness = 0; -- =0 ��Ļ������ʾ��=1 ����ʾ����Ļȫ��

    JY.CurrentD = -1; -- ��ǰ����D*�ı��
    JY.OldDPass = -1; -- �ϴδ���·���¼���D*���, �����δ���
    JY.CurrentEventType = -1 -- ��ǰ�����¼��ķ�ʽ 1 �ո� 2 ��Ʒ 3 ·��

    JY.CurrentThing = -1; -- ��ǰѡ����Ʒ�������¼�ʹ��

    JY.MmapMusic = -1; -- �л����ͼ���֣���������ͼʱ��������ã��򲥷Ŵ�����

    JY.CurrentMIDI = -1; -- ��ǰ���ŵ�����id�������ڹر�����ʱ��������id��
    JY.EnableMusic = 1; -- �Ƿ񲥷����� 1 ���ţ�0 ������
    JY.EnableSound = 1; -- �Ƿ񲥷���Ч 1 ���ţ�0 ������

    WAR = {}; -- ս��ʹ�õ�ȫ�̱��� ����ռ��λ�ã���Ϊ������治������ȫ�ֱ����ˡ�����������WarSetGlobal������

    AutoMoveTab = {
        [0] = 0
    }

    JY.Restart = 0 -- ������Ϸ��ʼ����
    JY.WalkCount = 0 -- ��·�Ʋ�

    IsViewingKungfuScrolls = 0

    Achievements = {}
    Achievements.pChar = {}

    YC = {}
    YC.ZJH = 0 -- ���������żһ�
    YC.GXZ = 0
end

function JY_Main() -- ���������
    os.remove("debug.txt"); -- �����ǰ��debug���
    os.remove("yltxt.txt");
    os.remove("ylname.txt");
    io.open("yltxt.txt", "w")
    io.open("ylname.txt", "w")


    xpcall(JY_Main_sub, myErrFun); -- ������ô���
end

function myErrFun(err) -- ��������ӡ������Ϣ
    lib.Debug(err); -- ���������Ϣ
    lib.Debug(debug.traceback()); -- ������ö�ջ��Ϣ
end

function JY_Main_sub() -- ��������Ϸ���������
    Ct = {};
    IncludeFile(); -- ��������ģ��
    SetGlobalConst(); -- ����ȫ�̱���CC, ����ʹ�õĳ���
    SetPersonTF()
    SetGlobal(); -- ����ȫ�̱���JY

    -- ��ֹ����ȫ�̱���
    setmetatable(_G, {
        __newindex = function(_, n)
            error("attempt read write to undeclared variable " .. n, 2);
        end,
        __index = function(_, n)
            error("attempt read read to undeclared variable " .. n, 2);
        end
    });

    lib.Debug("JY_Main start.");

    math.randomseed(os.time()); -- ��ʼ�������������

    JY.Status = GAME_START; -- �ı���Ϸ״̬

    lib.PicInit(CC.PaletteFile); -- ����ԭ����256ɫ��ɫ��

    lib.FillColor(0, 0, 0, 0, 0);

     --lib.PicLoadFile(CC.WMAPPicFile[1], CC.WMAPPicFile[2], 0)
     lib.LoadPNGPath(CC.HeadPath, 1, CC.HeadNum, limitX(CC.WX*100,0,100))	--���ö�ȡPNGͼƬ��·��
     --lib.PicLoadFile(CC.ThingPicFile[1], CC.ThingPicFile[2], 2, 100, 100)			--��Ʒ��ͼ���ڴ�����2
	 lib.LoadPNGPath(CC.ThingPath, 2, CC.ThingNum, limitX(CC.WX*100,0,100))	--��Ʒ��ͼ
     --lib.PicLoadFile(CC.EFTFile[1], CC.EFTFile[2], 3)								--��Ч��ͼ���ڴ�����3
     lib.LoadPNGPath(CC.BodyPath, 90, CC.BodyNum, limitX(CC.WX*100,0,100))	--������
     lib.LoadPNGPath(CC.XTPath, 91, CC.XTNum, limitX(CC.WX*100,0,100))	--XT	
     lib.PicLoadFile(CC.BJ[1], CC.BJ[2], 92)  --
     --lib.LoadPNGPath('./data/mmap',93,-1,100) --���ͼ
     --lib.LoadPNGPath('./data/smap',94,-1,100) --С��ͼ
     lib.LoadPNGPath(CC.PTPath, 95, CC.PTNum, limitX(CC.WX*100,0,100)) -- 
     lib.LoadPNGPath(CC.UIPath, 96, CC.UINum, limitX(CC.WX*100,0,100)) -- UI
	 lib.LoadPNGPath(CC.TFPath, 89, CC.TFNum, limitX(CC.WX * 100, 0, 100)) -- TF

    -- 97���ƶ䣬����ʹ��
     lib.LoadPNGPath(CC.IconPath, 98, CC.IconNum, limitX(CC.WX*100,0,100))	--״̬ͼ�꣬�ڴ�����98
     lib.LoadPNGPath(CC.HeadPath, 99, CC.HeadNum, 26.923076923) --����Сͷ�����ڼ��������ڴ�����99

    while true do
        if JY.Restart == 1 then
            JY.Restart = 0
            JY.Status = GAME_START;
        end
        if JY.Status == GAME_END then
            break
        end

        PlayMIDI(16);
        Cls();
        lib.ShowSlow(20, 0);

        local r = StartMenu();
        if r ~= nil then
            return;
        end

        lib.LoadPicture("", 0, 0);
        lib.GetKey();

        Game_Cycle();
    end
end

function TitleSelection()
    lib.Debug("TitleSelection");
    local bx, by = CC.WX, CC.HY
    local choice = 1
    local zb = {{188 + 200, 377 + 50, 132, 135}, {388 + 200, 377 + 50, 133, 136}, {588 + 200, 377 + 50, 134, 137}}
    local zb1 = {{188 + 200, 377 + 50, 3, 6}, {388 + 200, 377 + 50, 4, 7}, {588 + 200, 377 + 50, 5, 8}}
    local tb = 1
    local lb = 1
    local pc = 191
    local pc1 = 191
    local pc2 = 200
    local w, h = lib.GetPNGXY(91, 3 * 2)
    local x, y = (CC.ScreenW / 2) - ((w * 3) / 2), CC.ScreenH / 2
    local n = 0
    local tb = 1
    local mpNO = {28, 43, 166, 51, 16, 35, 156, 167, 12, 57}
    local mpx = {2, 5, 38, 10, 11, 17, 45, 20, 32, 22}
    local mpy = {14, 4, 18, 5, 39, 14, 50, 8, 12, 43}
    local MpScene = 0
    local mp = {1, 2, 17, 8, 27, 28, 6, 29, 3, 9}
    local smp = 0
    local mpmenu = {3005, 3023, 3028, 3031, 3025, 3033, 3035, 3037, 3039, 3041}
    local ptime = 0
    -- ģʽѡ��
    local function Moshixz()
        local zb = {{CC.ScreenW / 1.9057, CC.ScreenH / 1.6587}, {CC.ScreenW / 2.2666, CC.ScreenH / 1.6587},
                    {CC.ScreenW / 1.7107, CC.ScreenH / 1.6587}}
        local x, y = lib.GetPNGXY(91, 114 * 2)
        local x1, y1 = CC.ScreenW / 2 - x / 2, CC.ScreenH / 2 + y
        local tb = 1
        local picmenu = {{114, 116}, {115, 117}, {205, 206}}
        JY.Base["����"] = -1
        while true do
            if JY.Restart == 1 then
                break
            end
            ClsN()
            lib.LoadPNG(91, 84 * 2, -1, -1, 1)
            for i = 1, #zb do
                -- lib.LoadPNG(91,picmenu[i][1]*2,zb[i][1],zb[i][2],1)
                lib.LoadPNG(91, picmenu[i][1] * 2, x1 + (i - 2) * x, y1, 1)
                if tb == i then
                    -- lib.LoadPNG(91,picmenu[i][2]*2,zb[i][1],zb[i][2],1)
                    lib.LoadPNG(91, picmenu[i][2] * 2, x1 + (i - 2) * x, y1, 1)
                end
            end
            ShowScreen()
            lib.Delay(CC.Frame)
            local X, ktype, mx, my = lib.GetKey();
            if X == VK_ESCAPE or ktype == 4 then
                -- Cls()
                -- return TitleSelection()

                -- Menu_Exit()
            elseif X == VK_SPACE or X == VK_RETURN then
                if tb == 1 then
                    return Mpzjmenu()
                elseif tb == 2 then
                    return firstmenu()
                elseif tb == 3 then
                    return TSzjmenu()
                end
            elseif X == VK_LEFT or X == VK_UP then
                tb = tb - 1
                if tb < 1 then
                    tb = 3
                end
                JY.Base["����"] = tb - 1
            elseif X == VK_RIGHT or X == VK_DOWN then
                tb = tb + 1
                if tb > 3 then
                    tb = 1
                end
                JY.Base["����"] = tb - 1
            else
                local mxx = false
                for i = 1, #zb do
                    -- x1+(i-2)*x,y1
                    if mx >= x1 + (i - 2) * x and mx <= x1 + (i - 2) * x + x and my >= y1 and my <= y1 + y then
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
                    JY.Base["����"] = tb - 1
                end
            end
        end
    end

    while true do
        if JY.Restart == 1 then
            return
        end
        ClsN()
        lib.LoadPNG(91, (191 + math.modf(n)) * 2, -1, -1, 1)
        n = (n >= 12) and 0 or (n + 0.3)
        lib.LoadPNG(91, 204 * 2, -1, -1, 1)
        for i = 1, 3 do
            lib.LoadPNG(91, (132 + (i - 1)) * 2, x + ((i - 1) * w), y, 1)
            if tb == i then
                lib.LoadPNG(91, (135 + (tb - 1)) * 2, x + (tb - 1) * w, y, 1)
            else
                lib.LoadPNG(91, (135 + (tb - 1)) * 2, x + (tb - 1) * w, y, 1)
            end
        end

        -- �汾��
        DrawString(CC.WX * 15, CC.HY * 15, CC.Version, C_WHITE, CC.Fontsmall)
        ShowScreen()
        lib.Delay(CC.Frame)
        local keypress, ktype, mx, my = lib.GetKey()
        if keypress == VK_DOWN or keypress == VK_RIGHT then
            PlayWavE(77)
            if lb == 1 then
                tb = tb + 1
                if tb > #zb then
                    tb = 1
                end
            end
        elseif keypress == VK_ESCAPE or ktype == 4 then
            if lb == 2 then
                lb = 1
            end
        elseif keypress == VK_UP or keypress == VK_LEFT then
            PlayWavE(77)
            if lb == 1 then
                tb = tb - 1
                if tb < 1 then
                    tb = #zb
                end
            end
        elseif keypress == VK_RETURN or ktype == 3 then
            --[[if lb == 1 then
				if tb == 1 then		
					JY.Base["����"] = 0
					lb = 2
				elseif tb == 3 then
					JY.Status =GAME_END;	
					return -1					
				else
					
					JY.Base["����"] = 1
					NewGame();   		       --��������Ϸ����		
					if JY.Restart == 1 then
						do return end
					end		
					JY.SubScene = 162
					JY.Base["��X1"] = 44
					JY.Base["��Y1"] = 2
					instruct_40(3)					
					--�޾Ʋ�������Ů�����ж�
					if JY.Person[0]["�Ա�"] == 0 then
						JY.MyPic = CC.NewPersonPicM
					else
						JY.MyPic = CC.NewPersonPicF
					end
					JY.Status = GAME_SMAP
					JY.MmapMusic = -1
					CleanMemory()
					Init_SMap(0)
					lib.ShowSlow(20,0)				
					os.remove(CONFIG.DataPath..'WeeklyAwards')
					tgsave(1)					
					CC.TGJL = {}
					return -1	
								
				end	
				]]
            if lb == 1 then
                if tb == 1 then

                    -- LoadRecord(0)     --���¿�ʼ��Ϸ
                    JY.Base["����"] = 0 -- ��������Ϸ����		
                    Cls()
                    NewGame();
                    if JY.Restart == 1 then
                        do
                            return
                        end
                    end
                    for i = 1, #mp do
                        if JY.Person[0]['����'] == mp[i] then
                            MpScene = i
                            break
                        end
                    end
                    smp = mpNO[MpScene]
                    if JY.Person[0]['����'] == 1 then
                        smp = 93
                    end
                    if JY.Person[0]['����'] == 27 then
                        smp = 159
                    end
                    if JY.Person[0]['����'] == 9 then
                        smp = 152
                    end
                    -- ���������ʼ����
                    if JY.Base["����"] == 58 then
                        JY.SubScene = 18
                        JY.Base["��X"] = 144
                        JY.Base["��Y"] = 218
                        JY.Base["��X1"] = 30
                        JY.Base["��Y1"] = 32
                        -- elseif JY.Base["��׼"] == 1 then
                    elseif JY.Person[0]["����"] > 0 then
                        JY.SubScene = mpNO[MpScene]
                        JY.Base["��X1"] = mpx[MpScene]
                        JY.Base["��Y1"] = mpy[MpScene]
                        JY.Base["��X"] = JY.Scene[smp]["�⾰���X1"]
                        JY.Base["��Y"] = JY.Scene[smp]["�⾰���Y1"]
                    else
                        JY.SubScene = CC.NewGameSceneID
                        JY.Base["��X1"] = CC.NewGameSceneX
                        JY.Base["��Y1"] = CC.NewGameSceneY
                    end

                    -- �����¼�
                    if JY.Base["����"] == 58 then -- �������
                        CallCEvent(4187)
                    elseif JY.Person[0]["����"] > 0 then
                        CallCEvent(mpmenu[MpScene])
                    else -- ������
                        CallCEvent(691)
                    end

                    -- �޾Ʋ�������Ů�����ж�
                    if JY.Person[0]["�Ա�"] == 0 then
                        JY.MyPic = CC.NewPersonPicM
                    else
                        JY.MyPic = CC.NewPersonPicF
                    end
                    JY.Status = GAME_SMAP
                    JY.MmapMusic = -1
                    CleanMemory()
                    Init_SMap(0)
                    lib.ShowSlow(20, 0)
                    -- ���뿪�ֻ�������װ��
                    if JY.Base["����"] > 0 then
                        if JY.Person[0]["����"] ~= -1 and JY.Base["����"] ~= 27 then
                            instruct_2(JY.Person[0]["����"], 1)
                            JY.Person[0]["����"] = -1
                        end
                        if JY.Person[0]["����"] ~= -1 then
                            instruct_2(JY.Person[0]["����"], 1)
                            JY.Person[0]["����"] = -1
                        end
                        if JY.Person[0]["����"] ~= -1 then
                            instruct_2(JY.Person[0]["����"], 1)
                            JY.Person[0]["����"] = -1
                        end
                    end
                    -- �������������һ����
                    if JY.Base["����"] == 158 then
                        instruct_2(174, 10000)
                    end
                    -- ��׼���1����
                    if JY.Base["��׼"] > 0 then
                        --	instruct_2(174, 10000)
                    end
                    -- ������1����
                    if JY.Base["����"] > 0 then
                        --	instruct_2(174, 10000)
                    end
                    if JY.Base["����"] == 721 then
                        instruct_2(174, 20000)
                    end
                    -- ������Ѱ�����С��ɵ�
                    if JY.Base["����"] == 498 then
                        instruct_2(309, 1)
                    end
                    -- ������Ѱ�����С��ɵ�
                    if JY.Base["����"] == 498 then
                        instruct_2(29, 99)
                    end
                    -- �������������붴��Ǯѧϰ���ٲ�
                    if JY.Base["��׼"] > 0 then
                        addevent(41, 0, 1, 4144, 1, 8694)
                    end
                    -- ��Ŀ����

                    os.remove(CONFIG.DataPath .. 'WeeklyAwards')
                    for i = 1, #CC.commodity do
                        if CC.commodity[i][5] > 0 then
                            instruct_2(CC.commodity[i][1], CC.commodity[i][5])
                            CC.commodity[i][5] = 0
                        end
                    end
                    tgsave(1)
                    CC.TGJL = {}
                    return -1
                elseif tb == 2 then -- ����ɵĽ���	
                    JY.Base["����"] = 0
                    DrawStrBox(-1, CC.ScreenH * 1 / 6 - 20, "��ȡ����", LimeGreen, CC.Fontbig, C_GOLD);
                    DrawStrBox(bx * 281, by * CC.ScreenH * 1 / 6 + 26,
                        string.format("%-6s %-4s %-10s %-4s %-4s %-4s %-10s", "�浵��", "����", "����", "�Ѷ�",
                            "����", "����", "λ��"), C_ORANGE, CC.DefaultFont, C_GOLD);
                    local r = SaveList();
                    -- ESC ���·���ѡ��
                    if r < 1 then
                        local s = StartMenu();
                        return s;
                    end
                    DrawString(CC.ScreenW/2.1, CC.ScreenH/2, "���Ժ�......", C_WHITE, CC.DefaultFont, CC.FONT2)
                    ShowScreen();
                    local result = LoadRecord(r);
                    if result ~= nil then
                        return StartMenu();
                    end
                    if JY.Base["����"] ~= -1 then
                        if JY.SubScene < 0 then
                            CleanMemory()
                            -- lib.UnloadMMap()
                        end
                        -- lib.PicInit()
                        lib.ShowSlow(20, 1)
                        JY.Status = GAME_SMAP
                        JY.SubScene = JY.Base["����"]
                        JY.MmapMusic = -1
                        JY.MyPic = GetMyPic()

                        JY.Wugong[332]["�㼶"] = 1
                        JY.Wugong[266]["�㼶"] = 1
                        JY.Wugong[357]["�㼶"] = 2
                        JY.Wugong[265]["�㼶"] = 4
                        JY.Wugong[321]["�㼶"] = 1
                        JY.Wugong[282]["�㼶"] = 2
                        JY.Wugong[356]["�㼶"] = 2
                        JY.Wugong[341]["�㼶"] = 2
                        JY.Scene[17]["��ת��Y1"] = 1
                        JY.Scene[17]["��ת��Y2"] = 2
                        JY.Person[608]["�书2"] = 226
                        JY.Person[608]["�书�ȼ�2"] = 999
                        JY.Person[77]["Я����Ʒ1"] = -1
                        JY.Person[77]["Я����Ʒ����1"] = 0
                        Init_SMap(1)

                    else
                        JY.SubScene = -1
                        JY.Status = GAME_FIRSTMMAP
                    end
                    return -1
                elseif tb == 3 then
                    JY.Status = GAME_END
                    return -1
                end
            end
        else
            local md = false
            if lb == 1 then
                for i = 1, #zb do
                    if mx > x + ((i - 1) * w) and mx < x + ((i - 1) * w) + w and my > y and my < y + h then
                        md = true
                        tb = i
                        break
                    end
                end
                if md == true and ktype == 3 then
                    if tb == 1 then
                        JY.Base["����"] = 0
                        lb = 2
                    elseif tb == 3 then
                        JY.Status = GAME_END;
                        return -1
                    else
                        --[[
						Cls()
						JY.Base["����"] = 1
						NewGame();   		       --��������Ϸ����		
						if JY.Restart == 1 then
							do return end
						end		
						JY.SubScene = 162
						JY.Base["��X1"] = 44
						JY.Base["��Y1"] = 2
						instruct_40(3)					
						--�޾Ʋ�������Ů�����ж�
						if JY.Person[0]["�Ա�"] == 0 then
							JY.MyPic = CC.NewPersonPicM
						else
							JY.MyPic = CC.NewPersonPicF
						end
						JY.Status = GAME_SMAP
						JY.MmapMusic = -1
						CleanMemory()
						Init_SMap(0)
						lib.ShowSlow(20,0)				
						os.remove(CONFIG.DataPath..'WeeklyAwards')
						tgsave(1)					
						CC.TGJL = {}
						return -1	
						]]
                    end
                end
            elseif lb == 2 then
                Cls()
                for i = 1, #zb1 do
                    if mx >= bx * zb1[i][1] - bx * 65 and mx < bx * zb1[i][1] + bx * 65 + bx * 124 and my >= by *
                        zb1[i][2] and my <= by * zb1[i][2] + by * 66 then
                        md = true
                        choice = i
                        break
                    end
                end
                if md == true and ktype == 3 then
                    if lb == 1 then
                        if tb == 1 then -- ���¿�ʼ��Ϸ
                            JY.Base["����"] = 0 -- ��������Ϸ����		
                            Cls()

                            LoadRecord(0)
                            NewGame();
                            if JY.Restart == 1 then
                                do
                                    return
                                end
                            end
                            for i = 1, #mp do
                                if JY.Person[0]['����'] == mp[i] then
                                    MpScene = i
                                    break
                                end
                            end
                            if JY.Person[0]['����'] == 1 then
                                smp = 93
                            end
                            if JY.Person[0]['����'] == 27 then
                                smp = 159
                            end
                            if JY.Person[0]['����'] == 9 then
                                smp = 152
                            end
                            smp = mpNO[MpScene]

                            -- ���������ʼ����
                            if JY.Base["����"] == 58 then
                                JY.SubScene = 18
                                JY.Base["��X"] = 144
                                JY.Base["��Y"] = 218
                                JY.Base["��X1"] = 30
                                JY.Base["��Y1"] = 32
                                -- elseif JY.Base["��׼"] == 1 then
                            elseif JY.Person[0]["����"] > 0 then
                                JY.Base["��X1"] = mpx[MpScene]
                                JY.Base["��Y1"] = mpy[MpScene]
                                JY.Base["��X"] = JY.Scene[smp]["�⾰���X1"]
                                JY.Base["��Y"] = JY.Scene[smp]["�⾰���Y1"]
                            else
                                JY.SubScene = CC.NewGameSceneID
                                JY.Base["��X1"] = CC.NewGameSceneX
                                JY.Base["��Y1"] = CC.NewGameSceneY
                            end

                            -- �����¼�
                            if JY.Base["����"] == 58 then -- �������
                                CallCEvent(4187)
                            elseif JY.Person[0]["����"] > 0 then
                                local mpmenu = {3005, 3023, 3028, 3031, 3025, 3033, 3035, 3037, 3039, 3041}
                                CallCEvent(mpmenu[MpScene])
                            else -- ������
                                CallCEvent(691)
                            end

                            -- �޾Ʋ�������Ů�����ж�
                            if JY.Person[0]["�Ա�"] == 0 then
                                JY.MyPic = CC.NewPersonPicM
                            else
                                JY.MyPic = CC.NewPersonPicF
                            end
                            JY.Status = GAME_SMAP
                            JY.MmapMusic = -1
                            CleanMemory()
                            Init_SMap(0)
                            lib.ShowSlow(20, 0)

                            -- ���뿪�ֻ�������װ��
                            if JY.Base["����"] > 0 then
                                if JY.Person[0]["����"] ~= -1 and JY.Base["����"] ~= 27 then
                                    instruct_2(JY.Person[0]["����"], 1)
                                    JY.Person[0]["����"] = -1
                                end
                                if JY.Person[0]["����"] ~= -1 then
                                    instruct_2(JY.Person[0]["����"], 1)
                                    JY.Person[0]["����"] = -1
                                end
                                if JY.Person[0]["����"] ~= -1 then
                                    instruct_2(JY.Person[0]["����"], 1)
                                    JY.Person[0]["����"] = -1
                                end
                            end
                            -- �������������һ����
                            if JY.Base["����"] == 158 then
                                instruct_2(174, 10000)
                            end
                            -- ��׼���1����
                            if JY.Base["��׼"] > 0 then
                                --	instruct_2(174, 10000)
                            end
                            -- ������1����
                            if JY.Base["����"] > 0 then
                                --	instruct_2(174, 10000)
                            end
                            if JY.Base["����"] == 721 then
                                instruct_2(174, 20000)
                            end
                            -- ������Ѱ�����С��ɵ�
                            if JY.Base["����"] == 498 then
                                instruct_2(309, 1)
                            end
                            -- ������Ѱ�����С��ɵ�
                            if JY.Base["����"] == 498 then
                                instruct_2(29, 99)
                            end
                            -- �������������붴��Ǯѧϰ���ٲ�
                            if JY.Base["��׼"] > 0 then
                                addevent(41, 0, 1, 4144, 1, 8694)
                            end
                            -- ��Ŀ����

                            os.remove(CONFIG.DataPath .. 'WeeklyAwards')
                            for i = 1, #CC.commodity do
                                if CC.commodity[i][5] > 0 then
                                    instruct_2(CC.commodity[i][1], CC.commodity[i][5])
                                    CC.commodity[i][5] = 0
                                end
                            end
                            tgsave(1)
                            CC.TGJL = {}
                            return -1
                        elseif tb == 2 then -- ����ɵĽ���	
                            JY.Base["����"] = 0
                            DrawStrBox(-1, CC.ScreenH * 1 / 6 - 20, "��ȡ����", LimeGreen, CC.Fontbig, C_GOLD);
                            DrawStrBox(bx * 281, by * CC.ScreenH * 1 / 6 + 26,
                                string.format("%-6s %-4s %-10s %-4s %-4s %-4s %-10s", "�浵��", "����", "����",
                                    "�Ѷ�", "����", "����", "λ��"), C_ORANGE, CC.DefaultFont, C_GOLD);
                            local r = SaveList();
                            -- ESC ���·���ѡ��
                            if r < 1 then
                                local s = StartMenu();
                                return s;
                            end
                            DrawString(CC.MainSubMenuX2, CC.MainSubMenuY, "���Ժ�......", C_WHITE, CC.DefaultFont,
                                CC.FONT2)
                            ShowScreen();
                            local result = LoadRecord(r);
                            if result ~= nil then
                                return StartMenu();
                            end
                            if JY.Base["����"] ~= -1 then
                                if JY.SubScene < 0 then
                                    CleanMemory()
                                    -- lib.UnloadMMap()
                                end
                                -- lib.PicInit()
                                lib.ShowSlow(20, 1)
                                JY.Status = GAME_SMAP
                                JY.SubScene = JY.Base["����"]
                                JY.MmapMusic = -1
                                JY.MyPic = GetMyPic()
                                JY.Wugong[332]["�㼶"] = 1
                                JY.Wugong[266]["�㼶"] = 1
                                JY.Wugong[357]["�㼶"] = 2
                                JY.Wugong[265]["�㼶"] = 4
                                JY.Wugong[321]["�㼶"] = 1
                                JY.Wugong[282]["�㼶"] = 2
                                JY.Wugong[356]["�㼶"] = 2
                                JY.Wugong[341]["�㼶"] = 2
                                JY.Scene[17]["��ת��Y1"] = 1
                                JY.Scene[17]["��ת��Y2"] = 2
                                JY.Person[608]["�书2"] = 226
                                JY.Person[608]["�书�ȼ�2"] = 999
                                JY.Person[77]["Я����Ʒ1"] = -1
                                JY.Person[77]["Я����Ʒ����1"] = 0
                                Init_SMap(1)
                                return -1
                            else
                                JY.SubScene = -1
                                JY.Status = GAME_FIRSTMMAP
                            end
                            return -1
                        elseif tb == 3 then
                            JY.Status = GAME_END
                            return -1
                        end
                    end
                end
            end
        end
    end
end

function StartMenu()
    Cls()
    TitleSelection()

    Cls()
end

function CleanMemory() -- ����lua�ڴ�
    if CONFIG.CleanMemory == 1 then
        collectgarbage("collect");
    end
end
function NewGame() -- ѡ������Ϸ���������ǳ�ʼ����
    lib.Debug("NewGame");
    Cls();
    ShowScreen();
    LoadRecord(0); --  ��������Ϸ����
    -- PlayMIDI(77);

    CC.Week = 1
    CC.Gold = 0
    CC.MJCZ = 0
    CC.Sp = 0

    if existFile(CONFIG.DataPath .. 'WeeklyAwards') then
        tgload()
    end

    -- ִ�гɾ��ļ�
    if existFile(CC.Acvmts) then
        dofile(CC.Acvmts)
        -- һ��Ŀ
    else
        Achievements.Round = 1
        Achievements.pChar = {}
        Achievements.rdsCpltd = {}
        for i = 1, JY.PersonNum do
            Achievements.rdsCpltd[i] = {}
            Achievements.rdsCpltd[i].n = 0
            Achievements.rdsCpltd[i].lvlReached1 = 0
            Achievements.rdsCpltd[i].lvlReached2 = 0
        end
        Achievements.sp = 0
        Achievements.bonus = {}
        for i = 1, 7 do
            Achievements.bonus[i] = 0
        end
        -- �Ա����ʽ�������ļ�
        SaveTable(Achievements)
    end
    if CC.Week > 100 then
        CC.Week = 100
    end
    JY.Base["��Ŀ"] = 0
    JY.Base["��Ƭ"] = CC.Sp
    JY.Status = GAME_NEWNAME
    ClsN()

    if JY.Base["����"] == 0 then
        -- ѡ��������ǳ���
        lib.LoadPicture(CC.BG01File, -1, -1)
        -- 0224�޸�
        JY.Base["�书����"] = 15
        if JY.Base["�书����"] > 15 then
            JY.Base["�书����"] = 15
        end
        JY.Wugong[139]['�书����'] = 3
        for w = 0, JY.WugongNum - 1 do
            if JY.Wugong[w]["�书����"] < 7 and w ~= 0 then
                JY.Wugong[w]["������"] = math.modf(JY.Wugong[w]["������" .. 10] / 2)
                if JY.Wugong[w]["������"] < 700 then
                    JY.Wugong[w]["������"] = 700
                end
                JY.Wugong[w]["������"] = JY.Wugong[w]["������"] + JY.Wugong[w]["�㼶"] * 50
                if JY.Wugong[w]["�书����"] == 3 then
                    JY.Wugong[w]["������"] = math.modf(JY.Wugong[w]["������"] * 1.2)
                end
                if JY.Wugong[w]["������Χ"] == 3 then
                    JY.Wugong[w]["������"] = math.modf(JY.Wugong[w]["������"] * 0.8)
                end
                if JY.Wugong[w]["������"] > 1000 then
                    -- JY.Wugong[w]["������"] = 1000
                end
            end
        end
        CC.TX['��ʼ�츳'] = 1
        if CC.TX['��ʼ�츳'] == 1 then
            for p = 0, JY.PersonNum - 1 do
                if CC.PTF[p] ~= nil then
                    for i, v in pairs(CC.PTF[p]) do
                        if v == 1 then
                            SetTF(p, i, 1)
                            -- lib.Debug(JY.Person[p]['����']..'�츳='..i)
                        end
                    end
                end
            end
            CC.TX['��ʼ�츳'] = 0
        end
        lib.Debug(JY.Person[1]['����'] .. ' tf=' .. JY.Person[1]['�츳' .. 2])
        ClsN()
        Moshixz()
        ClsN()
        GAME_START1()
        ClsN()
        GAME_START2()
        ClsN()
        lib.LoadPicture(CC.BG01File, -1, -1)
        local cxn = JY.Base['����']
        JY.Person[30]['����'] = 6
        if JY.Person[0]['����'] > 1 then
            TF_table()
        elseif JY.Base["����"] == 757 then
            TF_table()
        elseif CC.PTF[cxn] ~= nil then
            local tfn = 0
            for i, v in pairs(CC.PTF[cxn]) do
                if v == 1 then
                    tfn = tfn + 1
                end
            end
            -- say(tfn,1)
            if tfn < 3 then
                TF_table()
            end
            ClsN()
        end

        ClsN()
        lib.LoadPicture(CC.BG01File, -1, -1)
        local waitwz = '��һ�ν�����Ϸ�����ڼ�����...'
        local size = CC.DefaultFont
        DrawString(CC.ScreenW - size * 14 - string.len(waitwz) / 4 * size, CC.ScreenH - size * 2 - size / 2, waitwz,
            C_WHITE, size)
        ShowScreen()

        if JY.Base["��׼"] == 6 then
            JY.Person[0]["��������"] = 3
        end

        -- ���������ʼ��
        for p = 0, JY.PersonNum - 1 do
            local P = JY.Person[p]
            local fj = JY.Person[p]["����ֽ�"]
            local nd = JY.Base["�Ѷ�"]
            local zm = limitX(JY.Base["��Ŀ"], 1, 100)
            if P['�������ֵ'] < 2500 then
                P['�������ֵ'] = 2500
                P['����'] = 2500
            end
            -- �з��ĳ�ʼ��
            if CC.PersonExit[p] == nil and p ~= 0 and p ~= 171 and p ~= 172 and p ~= 591 then
                for i = 1, JY.Base["�书����"] do
                    if JY.Person[p]["�书" .. i] > 0 then
                        -- ����10���ļӵ�10��
                        if JY.Person[p]["�书�ȼ�" .. i] < 900 then
                            JY.Person[p]["�书�ȼ�" .. i] = 900
                        end
                    end
                end
                if fj == 1 then
                    P['����'] = 15
                elseif fj == 2 then
                    P['����'] = 13
                elseif fj == 3 then
                    P['����'] = 12
                elseif fj == 4 then
                    P['����'] = 8
                end

                local cx = {{3000, 600}, {2500, 500}, {2000, 400}, {1500, 300}, {1000, 200}, {500, 100}}
                local fd = cx[fj][1]
                local gj = cx[fj][2]
                local fy = cx[fj][2]
                local qg = cx[fj][2]
                local gj1 = 0
                local fy1 = 0
                local qg1 = 0
                gj = gj + limitX(math.random(cx[fj][2]), cx[fj][2] / 3, cx[fj][2] - 1)
                fy = fy + limitX(math.random(cx[fj][2]), cx[fj][2] / 3, cx[fj][2] - 1)
                qg = qg + limitX(math.random(cx[fj][2]), cx[fj][2] / 3, cx[fj][2] - 1)
                local znum = fd - gj - fy - qg
                if znum > 0 then
                    gj = gj + math.modf(znum / 3)
                    fy = fy + math.modf(znum / 3)
                    qg = qg + math.modf(znum / 3)
                else
                    gj = gj - math.modf(-znum / 3)
                    fy = fy - math.modf(-znum / 3)
                    qg = qg - math.modf(-znum / 3)
                end
                local ndjc = (100 + (nd * 2 - 3) * 10) / 100
                if nd == 1 then
                    ndjc = 0.6
                elseif nd == 2 then
                    ndjc = 0.7
                elseif nd == 3 then
                    ndjc = 0.8
                elseif nd == 4 then
                    ndjc = 0.9
                end
                P["������"] = math.modf(gj * ndjc)
                P["������"] = math.modf(fy * ndjc)
                P["�Ṧ"] = math.modf(qg * ndjc)
                if JY.Person[p]["����"] > -1 then
                    JY.Thing[JY.Person[p]["����"]]["װ���ȼ�"] = 6
                end
                if JY.Person[p]["����"] > -1 then
                    JY.Thing[JY.Person[p]["����"]]["װ���ȼ�"] = 6
                end
                if JY.Person[p]["����"] > -1 then
                    JY.Thing[JY.Person[p]["����"]]["װ���ȼ�"] = 6
                end

                local xs = 0
                local wc = 0
                local sw = 0

                ---NPC��Ŀ��������
                -- ÿ��Ŀ����20��ϵ������Χ���䳣
                if nd > 1 and p ~= 591 then
                    xs = zm
                    wc = zm * 3
                    sw = zm * 3
                end
                -- ÿ��Ŀ����20��ϵ������Χ���䳣
                if nd > 1 and p ~= 591 then
                    xs = xs + nd * 5
                    sw = sw + nd * 5
                    wc = wc + nd * 5
                end
                if nd >= 3 and JY.Person[p]["����ֽ�"] <= 3 then
                    sw = sw + nd * zm
                    xs = xs + nd * zm
                    wc = wc + nd * zm
                end
                -- �޸ı��
                local fj = limitX(6 - JY.Person[p]["����ֽ�"], 1, 6)
                local sz = sw * fj
                local tt = 5
                local fx = math.random(4)
                while sz > 0 do
                    local n = math.random(3)
                    if fx == 1 and n == 1 then
                        tt = tt * 2
                    end
                    if fx == 2 and n == 2 then
                        tt = tt * 2
                    end
                    if fx == 3 and n == 3 then
                        tt = tt * 2
                    end
                    if sz < tt then
                        tt = sz
                    end
                    if n == 1 then
                        JY.Person[p]["������"] = JY.Person[p]["������"] + tt
                    elseif n == 2 then
                        JY.Person[p]["������"] = JY.Person[p]["������"] + tt
                    else
                        JY.Person[p]["�Ṧ"] = JY.Person[p]["�Ṧ"] + tt
                    end
                    sz = sz - tt
                end
                local zm_smnl = fj * fj * JY.Base['��Ŀ'] * JY.Base['�Ѷ�']
                JY.Person[p]["ȭ�ƹ���"] = JY.Person[p]["ȭ�ƹ���"] + xs
                JY.Person[p]["ָ������"] = JY.Person[p]["ָ������"] + xs
                JY.Person[p]["��������"] = JY.Person[p]["��������"] + xs
                JY.Person[p]["ˣ������"] = JY.Person[p]["ˣ������"] + xs
                JY.Person[p]["�������"] = JY.Person[p]["�������"] + xs
                JY.Person[p]["��ѧ��ʶ"] = JY.Person[p]["��ѧ��ʶ"] + wc
                JY.Person[p]["��������"] = zm_smnl
                JY.Person[p]["�������ֵ"] = JY.Person[p]["�������ֵ"] + zm_smnl * 2
                AddPersonAttrib(p, '����', math.huge)
                KfSet(p)
                Hp_Max(p)
                Mp_Max(p)
                AddPersonAttrib(p, '����', math.huge)
            else
                if p == 0 then
                    -- lib.Debug('���ǳ�ʼ�趨')
                    JY.Person[p]["����ֽ�"] = 6
                    JY.Person[p]["������"] = 40
                    JY.Person[p]["������"] = 40
                    JY.Person[p]["�Ṧ"] = 40
                    local p_zz = JY.Person[p]["����"];
                    local leveladd = 29
                    local ups = 0
                    if p_zz < 31 then -- 87*3 261   1/9
                        ups = 3
                    elseif p_zz >= 31 and p_zz <= 50 then -- 116*3 348  1/12
                        ups = 4
                    elseif p_zz >= 51 and p_zz <= 79 then -- 147*3 441  1/15
                        ups = 5
                    elseif p_zz >= 80 and p_zz <= 100 then -- 177*3 522  1/18
                        ups = 6
                    end
                    local nfqg = 0
                    if p == 0 and JY.Base['����'] == 546 then
                        nfqg = 3
                    end
                    if JY.Person[p]['ȭ���ɳ�'] < 50 then
                        JY.Person[p]['ȭ���ɳ�'] = 50
                    end
                    if JY.Person[p]['ָ���ɳ�'] < 50 then
                        JY.Person[p]['ָ���ɳ�'] = 50
                    end
                    if JY.Person[p]['�����ɳ�'] < 50 then
                        JY.Person[p]['�����ɳ�'] = 50
                    end
                    if JY.Person[p]['�����ɳ�'] < 50 then
                        JY.Person[p]['�����ɳ�'] = 50
                    end
                    if JY.Person[p]['���ųɳ�'] < 50 then
                        JY.Person[p]['���ųɳ�'] = 50
                    end
                    JY.Person[p]['����'] = JY.Person[p]['����'] + (6 - ups)
                    JY.Person[p]["������"] = JY.Person[p]["������"] + 29 * ups
                    JY.Person[p]["������"] = JY.Person[p]["������"] + 29 * ups
                    JY.Person[p]["�Ṧ"] = JY.Person[p]["�Ṧ"] + 29 * ups + nfqg
                else

                    local cx = {{3000, 600}, {2500, 500}, {2000, 400}, {1500, 300}, {1000, 200}, {500, 100}}
                    local fd = cx[fj][1]
                    local gj = cx[fj][2]
                    local fy = cx[fj][2]
                    local qg = cx[fj][2]
                    local gj1 = 0
                    local fy1 = 0
                    local qg1 = 0
                    gj = gj + limitX(math.random(cx[fj][2]), cx[fj][2] / 3, cx[fj][2] - 1)
                    fy = fy + limitX(math.random(cx[fj][2]), cx[fj][2] / 3, cx[fj][2] - 1)
                    qg = qg + limitX(math.random(cx[fj][2]), cx[fj][2] / 3, cx[fj][2] - 1)
                    local znum = fd - gj - fy - qg
                    if znum > 0 then
                        gj = gj + math.modf(znum / 3)
                        fy = fy + math.modf(znum / 3)
                        qg = qg + math.modf(znum / 3)
                    else
                        gj = gj - math.modf(-znum / 3)
                        fy = fy - math.modf(-znum / 3)
                        qg = qg - math.modf(-znum / 3)
                    end
                    local ndjc = (100 + (nd * 2 - 3) * 10) / 100
                    if nd == 1 then
                        ndjc = 0.6
                    elseif nd == 2 then
                        ndjc = 0.7
                    elseif nd == 3 then
                        ndjc = 0.8
                    elseif nd == 4 then
                        ndjc = 0.9
                    end
                    P["������"] = math.modf(gj * ndjc)
                    P["������"] = math.modf(fy * ndjc)
                    P["�Ṧ"] = math.modf(qg * ndjc)
                    -- KfSet(p)
                end

                if JY.Person[p]['ȭ���ɳ�'] < 50 then
                    JY.Person[p]['ȭ���ɳ�'] = 50
                end
                if JY.Person[p]['ָ���ɳ�'] < 50 then
                    JY.Person[p]['ָ���ɳ�'] = 50
                end
                if JY.Person[p]['�����ɳ�'] < 50 then
                    JY.Person[p]['�����ɳ�'] = 50
                end
                if JY.Person[p]['�����ɳ�'] < 50 then
                    JY.Person[p]['�����ɳ�'] = 50
                end
                if JY.Person[p]['���ųɳ�'] < 50 then
                    JY.Person[p]['���ųɳ�'] = 50
                end
                -- �޸�ҽ�ơ��ö����ⶾ��������ȼ��ҹ�������
                if JY.Person[p]["ҽ������"] >= 20 then
                    JY.Person[p]["ҽ������"] = JY.Person[p]["ҽ������"] + 29 * 2
                end
                if JY.Person[p]["�ö�����"] >= 20 then
                    JY.Person[p]["�ö�����"] = JY.Person[p]["�ö�����"] + 29 * 2
                end
                if JY.Person[p]["�ⶾ����"] >= 20 then
                    JY.Person[p]["�ⶾ����"] = JY.Person[p]["�ⶾ����"] + 29 * 2
                end
                if p == 0 and JY.Base["����"] == 75 then
                    JY.Person[p]["ȭ�ƹ���"] = JY.Person[p]["ȭ�ƹ���"] + 6 * 29
                    JY.Person[p]["ָ������"] = JY.Person[p]["ָ������"] + 6 * 29
                    JY.Person[p]["��������"] = JY.Person[p]["��������"] + 6 * 29
                    JY.Person[p]["ˣ������"] = JY.Person[p]["ˣ������"] + 6 * 29
                    JY.Person[p]["�������"] = JY.Person[p]["�������"] + 6 * 29
                end
                -- ��Ŀ��������
                local xs = 0
                local wc = 0
                local sw = 0

                ---NPC��Ŀ��������
                -- ÿ��Ŀ����20��ϵ������Χ���䳣
                if nd > 1 and p ~= 591 then
                    xs = zm
                    wc = zm * 3
                    sw = zm * 3
                end
                -- ÿ��Ŀ����20��ϵ������Χ���䳣
                if nd > 1 and p ~= 591 then
                    xs = xs + nd * 5
                    sw = sw + nd * 5
                    wc = wc + nd * 5
                end
                if nd >= 3 and JY.Person[p]["����ֽ�"] <= 3 then
                    sw = sw + nd * zm
                    xs = xs + nd * zm
                    wc = wc + nd * zm
                end
                -- �޸ı��
                local fj = limitX(6 - JY.Person[p]["����ֽ�"], 1, 6)
                local sz = sw * fj
                local tt = 5
                local fx = math.random(4)
                while sz > 0 do
                    local n = math.random(3)
                    if fx == 1 and n == 1 then
                        tt = tt * 2
                    end
                    if fx == 2 and n == 2 then
                        tt = tt * 2
                    end
                    if fx == 3 and n == 3 then
                        tt = tt * 2
                    end
                    if sz < tt then
                        tt = sz
                    end
                    if n == 1 then
                        JY.Person[p]["������"] = JY.Person[p]["������"] + tt
                    elseif n == 2 then
                        JY.Person[p]["������"] = JY.Person[p]["������"] + tt
                    else
                        JY.Person[p]["�Ṧ"] = JY.Person[p]["�Ṧ"] + tt
                    end
                    sz = sz - tt
                end
                local zm_smnl = fj * fj * JY.Base['��Ŀ'] * JY.Base['�Ѷ�']
                JY.Person[p]["ȭ�ƹ���"] = JY.Person[p]["ȭ�ƹ���"] + xs
                JY.Person[p]["ָ������"] = JY.Person[p]["ָ������"] + xs
                JY.Person[p]["��������"] = JY.Person[p]["��������"] + xs
                JY.Person[p]["ˣ������"] = JY.Person[p]["ˣ������"] + xs
                JY.Person[p]["�������"] = JY.Person[p]["�������"] + xs
                JY.Person[p]["��ѧ��ʶ"] = JY.Person[p]["��ѧ��ʶ"] + wc
                JY.Person[p]["��������"] = zm_smnl
                JY.Person[p]["�������ֵ"] = JY.Person[p]["�������ֵ"] + zm_smnl * 2
                AddPersonAttrib(p, '����', math.huge)
                Hp_Max(p)
                Mp_Max(p)
                AddPersonAttrib(p, '����', math.huge)
            end
            JY.Person[p]['�ø�'] = 0
            -- ��ʼ��ʽ����		
            for j = 1, JY.Base["�书����"] do
                local wugong = JY.Person[p]["�书" .. j]
                if wugong > 0 then
                    KF_zsset(p, wugong)
                end
            end
        end
        JY.Person[498]['����'] = 24
        JY.Base['����'] = -1
        JY.Base['����'] = -1
        JY.Wugong[52]['����'] = 17
        JY.Wugong[182]['�㼶'] = 4
        JY.Person[130]['����'] = 1
        JY.Person[78]['����'] = 1
        JY.Person[610]['����'] = 1
        JY.Person[0]['����'] = JY.Person[JY.Base['����']]['����']
        addevent(101, 13, 1, 3055, 1, 8696)
        -- �޾Ʋ���������һЩ��ʼ���趨
        -- ����ˮ��������ս��
        instruct_3(117, 23, 1, 0, 1170, 0, 0, 4902 * 2, 4902 * 2, 4902 * 2, 0, 26, 13)
        -- ��ɽ��ɽл����
        instruct_3(80, 17, 1, 0, 4105, 0, 0, 4133 * 2, 4133 * 2, 4133 * 2, 0, -2, -2)
        JY.Wugong[170]["�书����&��Ч"] = 39
        JY.Wugong[297]["�书����&��Ч"] = 39
        JY.Person[750]['������'] = 353
        addevent(166, 4, 1, 2002, 1, nil) -- Ѫ����ѧ
        addevent(156, 5, 1, 2005, 1, nil) -- �������ѧ	
        addevent(57, 5, 1, 1222, 1, 7018) -- ��ɽ����ɺ
        addevent(10, 25, 0, 3054, 3, 0)
        null(57, 6)
        if JY.Base['����'] == 51 or JY.Base['����'] == 113 then
            instruct_68(0, 3, 1, 0)
        end
        if JY.Base['����'] == 64 then
            instruct_68(0, 4, 1, 0)
        end

        -- ��������ͼ
        instruct_3(62, 4, 0, 0, 0, 0, 0, 9238, 9238, 9238, 0, 0, 0);
        -- �»�ɽ�۽��¼�
        addevent(80, 19, 1, 4141, 1, 4335 * 2) -- ��
        -- lib.PlayMPEG(CONFIG.DataPath .. "/avi/1.mp4",VK_ESCAPE) --��Ƶ�ļ�
        Cls()
        JY.Thing[372]["�����ؼ�"] = 1
        JY.Thing[235]["�����ؼ�"] = 4
        JY.Wugong[343]['������Χ'] = 1
        JY.Wugong[343]['�ƶ���Χ' .. 10] = 7
        JY.Wugong[343]['�书����&��Ч'] = 115
        JY.Wugong[343]['������' .. 10] = 1400
        JY.Wugong[345]['������' .. 10] = 1400
        JY.Person[64]['�ؼ�' .. 1] = 4
        JY.Person[113]['�ؼ�' .. 1] = 3
        JY.Person[51]['�ؼ�' .. 1] = 3
        JY.Wugong[202]["������" .. 10] = 700
        JY.Scene[24]['����'] = '���ׯ'
        JY.Teji[26]['����书' .. 1] = 96
        JY.Teji[26]['����书' .. 2] = 144
        JY.Teji[26]['�书����'] = 2
        JY.Teji[62]['����书' .. 1] = 55
        JY.Teji[62]['����书' .. 2] = 59
        JY.Teji[62]['�书����'] = 2
        JY.Teji[62]['����'] = '��������'
        null(151, 28)
        null(43, 30)
        null(43, 31)
        local name = JY.Person[0]['����']
        local name1 = string.sub(name, 1, 2)
        local name2 = string.sub(name, 3, 4)
        local name3 = string.sub(name, 5, 6)
        local name4 = string.sub(name, 7, 8)
        local nm = string.len(name)
        if nm < 8 then
            JY.Scene[70]['����'] = JY.Person[0]['����'] .. '��'
        else
            JY.Scene[70]['����'] = name1 .. name2 .. '��'
        end
    else
        for p = 0, JY.PersonNum - 1 do
            for i = 1, JY.Base["�书����"] do
                if JY.Person[p]["�书" .. i] > 0 then
                    if p < 191 then
                        -- JY.Person[p]["�书�ȼ�" .. i] = 999    --BOSS�书��Ϊ��
                    else
                        -- ����10���ļӵ�10��
                        if JY.Person[p]["�书�ȼ�" .. i] < 900 then
                            JY.Person[p]["�书�ȼ�" .. i] = 900
                        end
                    end
                else
                    break
                end
            end
            JY.Person[0]["������"] = 752
            if JY.Person[p]["����"] > -1 then
                JY.Person[p]["����"] = -1
            end
            if JY.Person[p]["����"] > -1 then
                JY.Person[p]["����"] = -1
            end
            if JY.Person[p]["����"] > -1 then
                JY.Person[p]["����"] = -1
            end
            -- ��������200�ļӵ�200
            if JY.Person[p]["�������ֵ"] < 200 then
                JY.Person[p]["�������ֵ"] = 200
                JY.Person[p]["����"] = JY.Person[p]["�������ֵ"]
            end

            -- ��������200�ļӵ�200
            if JY.Person[p]["�������ֵ"] < 200 then
                JY.Person[p]["�������ֵ"] = 200
                JY.Person[p]["����"] = JY.Person[p]["�������ֵ"]
            end
        end
    end
    -- �����书����
    for w = 0, JY.WugongNum - 1 do
        local wl = JY.Wugong[w]["������" .. 10]
        JY.Wugong[w]["������������"] = JY.Wugong[w]['�㼶']*100
    end
    for x = 1, JY.PersonNum - 1 do
        for i = 1, JY.Base['�书����'] do
            local kf = JY.Person[x]['�书' .. i]
            if kf > 0 then
                MIJI_PD(x, KF_thing(kf), 1)
            end
        end
    end
    lib.Debug('CC.kaijuwugong1' .. CC.kaijuwugong1)
    -- break
end

-- �޾Ʋ����������ж�����
function JLSD(s1, s2, dw)
    local s = math.random(100)
    local chance_up = 0;
    local kf_ng = JY.Person[dw]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf_ng]['�㼶']
    -- �۽���Ӯ�����ά��������+6
    -- ������ڶ����У�����+20
    if inteam(dw) == false then
        -- chance_up = chance_up + 10
    end
    if (JY.Base["��׼"] == 7 and dw == 0 and WAR.SEYB == 0) or match_ID(dw, 9925) then
        chance_up = chance_up + 5
    end
    -- ���������Ч
    if match_ID(dw, 588) then
        chance_up = chance_up + 5
    end
    -- ���ž���
    if match_ID(dw, 9804) then
        chance_up = chance_up + 8
    end
    -- ��������
    if JY.Status == GAME_WMAP then
        for wid = 0, WAR.PersonNum - 1 do
            -- ���ѷ����ӳ�
            if ZDGH(wid, 9899) then
                if WAR.Person[wid]["�ҷ�"] == true then
                    chance_up = chance_up + 5
                else
                    chance_up = chance_up - 5
                end
                break
            end
        end
    end
    -- lib.Debug("���"..s1.."  ���"..s2)
    --if Curr_NG(dw, 102) then
    --������Ч1024 
    if NeiGong_tx(dw,1024) then     
        chance_up = chance_up + (1+dkfcj_ng)
    end
    -- �ж��Ƿ�ɹ�
    if s1 < s and s <= s2 + chance_up then
        return true
    else
        return false
    end

end

-- ��Ϸ��ѭ��
function Game_Cycle()
    lib.Debug("Start game cycle");

    while JY.Status ~= GAME_END and JY.Status ~= GAME_START do
        if JY.Restart == 1 then
            break
        end
        local t1 = lib.GetTime();

        JY.Mytick = JY.Mytick + 1; -- 20�������޻����������Ǳ�Ϊվ��״̬
        if JY.Mytick % 20 == 0 then
            JY.MyCurrentPic = 0;
        end

        if JY.Mytick % 1000 == 0 then
            JY.MYtick = 0;
        end

        if JY.Status == GAME_FIRSTMMAP then -- �״���ʾ�����������µ�����������ͼ��������ʾ��Ȼ��ת��������ʾ
            CleanMemory()
            lib.ShowSlow(20, 1)
            JY.MmapMusic = 57
            JY.Status = GAME_MMAP
            Init_MMap()
            local sc = CC.Shichen
            if CC.TX['ҹĻ'] == 1 then
                --sc = 6
            end
            lib.DrawMMap(JY.Base["��X"], JY.Base["��Y"], GetMyPic(), sc)
            lib.ShowSlow(20, 0)
        elseif JY.Status == GAME_MMAP then
            Game_MMap();
        elseif JY.Status == GAME_SMAP then
            Game_SMap();
        end
        collectgarbage("step", 0)
        local t2 = lib.GetTime();
        if t2 - t1 < CC.Frame then
            lib.Delay(CC.Frame - (t2 - t1));
        end
    end
end

-- �������������� С��ͼ��Ϣ
function Game_SMap() -- ��������������
    if JY.Restart == 1 then
        return
    end
    DrawSMap();
    -- �޾Ʋ������·���ʾ	
    if CC.ShowXY == 1 then
        if JY.SubScene ~= 150 then
            -- lib.LoadPNG(91,43*2,CC.WX*136,CC.HY*142,2)
            -- DrawString(CC.WX*70,CC.HY*129,string.format("%s %d %d",JY.Scene[JY.SubScene]["����"],JY.Base["��X1"],JY.Base["��Y1"]) ,C_WHITE,CC.Fontsmall*0.8);
        else
            -- lib.LoadPNG(91,43*2,CC.WX*136,CC.HY*142,2)
            -- DrawString(CC.WX*70,CC.HY*129,string.format("%s %d %d","���"..8+JY.Base["���"].."��",JY.Base["��X1"],JY.Base["��Y1"]) ,C_WHITE,CC.Fontsmall*0.8);
        end
    end
    JYZTB(); -- ���ϽǼ�����Ϣ	
    DrawTimer(); -- ���Ͻ���Ϣ��ʾ
	--testMarquee()
    -- DrawTimerA()

    ShowScreen();
    lib.SetClip(0, 0, 0, 0)

    local d_pass = GetS(JY.SubScene, JY.Base["��X1"], JY.Base["��Y1"], 3); -- ��ǰ·���¼�
    if d_pass >= 0 then
        if d_pass ~= JY.OldDPass then -- �����ظ�����
            EventExecute(d_pass, 3); -- ·�������¼�
            JY.OldDPass = d_pass;
            JY.oldSMapX = -1;
            JY.oldSMapY = -1;
            JY.D_Valid = nil;
        end
        if JY.Status ~= GAME_SMAP then
            return;
        else
            JY.OldDPass = -1;
        end
    end
    local isout = 0; -- �Ƿ���������
    if (JY.Scene[JY.SubScene]["����X1"] == JY.Base["��X1"] and JY.Scene[JY.SubScene]["����Y1"] == JY.Base["��Y1"]) or
        (JY.Scene[JY.SubScene]["����X2"] == JY.Base["��X1"] and JY.Scene[JY.SubScene]["����Y2"] == JY.Base["��Y1"]) or
        (JY.Scene[JY.SubScene]["����X3"] == JY.Base["��X1"] and JY.Scene[JY.SubScene]["����Y3"] == JY.Base["��Y1"]) then
        isout = 1;
    end
    -- �������ͼ
    if isout == 1 then
        -- �޾Ʋ������޸���ֱ�ӷɽ�������������ڵ������������
        if JY.Base["��X"] == JY.Scene[JY.SubScene]["�⾰���X1"] and JY.Base["��Y"] ==
            JY.Scene[JY.SubScene]["�⾰���Y1"] then
            -- ѩɽҪ��������
            if JY.SubScene == 2 then
                JY.Base["��Y"] = JY.Base["��Y"] + 1
                -- �츮Ҫ��������
            elseif JY.SubScene == 92 then
                JY.Base["��X"] = JY.Base["��X"] + 1
            else
                if JY.Base["�˷���"] == 0 then
                    JY.Base["��Y"] = JY.Base["��Y"] - 1
                elseif JY.Base["�˷���"] == 1 then
                    JY.Base["��X"] = JY.Base["��X"] + 1
                elseif JY.Base["�˷���"] == 2 then
                    JY.Base["��X"] = JY.Base["��X"] - 1
                elseif JY.Base["�˷���"] == 3 then
                    JY.Base["��Y"] = JY.Base["��Y"] + 1
                end
            end
        end
        -- ���̵ص�Ҫ��������
        if JY.SubScene == 13 then
            JY.Base["��X"] = 68
            JY.Base["��Y"] = 397
        end
        -- �ɹŰ�Ҫ��������
        if JY.SubScene == 6 then
            JY.Base["��X"] = 49
            JY.Base["��Y"] = 111
        end
        JY.Status = GAME_MMAP
        -- lib.PicInit()
        CleanMemory()
        JY.MmapMusic = JY.Scene[JY.SubScene]["��������"]
        MMapName()
        -- ���û�����ó������ֵĻ�
        if JY.MmapMusic < 0 then
            JY.MmapMusic = 0
        end
        Init_MMap()
        JY.SubScene = -1
        JY.oldSMapX = -1
        JY.oldSMapY = -1
        local sc = CC.Shichen
        if CC.TX['ҹĻ'] == 1 then
            sc = 6
        end
        lib.DrawMMap(JY.Base["��X"], JY.Base["��Y"], GetMyPic(), sc)
        lib.GetKey()
        lib.ShowSlow(20, 0)
        return
    end
    -- �Ƿ���ת����������
    if JY.Scene[JY.SubScene]["��ת����"] >= 0 and JY.Base["��X1"] == JY.Scene[JY.SubScene]["��ת��X1"] and
        JY.Base["��Y1"] == JY.Scene[JY.SubScene]["��ת��Y1"] then
        local OldScene = JY.SubScene
        JY.SubScene = JY.Scene[JY.SubScene]["��ת����"]
        lib.ShowSlow(20, 1)
        if JY.Scene[OldScene]["�⾰���X1"] ~= 0 then
            JY.Base["��X1"] = JY.Scene[JY.SubScene]["���X"]
            JY.Base["��Y1"] = JY.Scene[JY.SubScene]["���Y"]
        else
            JY.Base["��X1"] = JY.Scene[JY.SubScene]["��ת��X2"]
            JY.Base["��Y1"] = JY.Scene[JY.SubScene]["��ת��Y2"]
        end
        Init_SMap(1)
        return
    end

    local x, y;
    local direct = -1;
    lib.WalkMode(1)
    local keypress, ktype, mx, my = lib.GetKey();
	lib.WalkMode(0)
	if JY.WalkTime == 0 then
		CC.WalkTime = socket.gettime() * 1000 + CC.WalkSkip 
	else
		JY.WalkTime = socket.gettime() * 1000
	end	
	local repeatkey = false
	local RepeatState = {}
	for i = VK_RIGHT,VK_UP do
		RepeatState[i] = lib.GetKeyState(i)
	end 
 if (JY.WalkTime == 0 or JY.WalkTime < CC.WalkTime) and CC.WalkSkip ~= 0 then
			if keypress==VK_UP then
				direct=0;
				JY.WalkCount = JY.WalkCount + 1
				JY.WalkTime = 0
			elseif keypress==VK_DOWN then
				direct=3;
				JY.WalkCount = JY.WalkCount + 1
				JY.WalkTime = 0
			elseif keypress==VK_LEFT then
				direct=2;
				JY.WalkCount = JY.WalkCount + 1
				JY.WalkTime = 0
			elseif keypress==VK_RIGHT then
				direct=1;
				JY.WalkCount = JY.WalkCount + 1
				JY.WalkTime = 0
			elseif RepeatState[VK_UP] ==0 and RepeatState[VK_DOWN] ==0 and RepeatState[VK_LEFT] ==0 and RepeatState[VK_RIGHT] ==0 then
				JY.WalkTime = 0	
			elseif JY.WalkTime < CC.WalkSkip then
				--JY.WalkTime = JY.WalkTime + 1
				JY.WalkTime = 1
			--else
				--JY.WalkCount = 0
				--JY.WalkTime = 0
			end
		else
			--�ȼ����ϴβ�ͬ�ķ����Ƿ񱻰���
			for i = VK_RIGHT,VK_UP do
				if i ~= CC.PrevKeypress and RepeatState[i] ~=0 then
					keypress = i
					repeatkey = true
				end
			end 
			--������ϴβ�ͬ�ķ���δ�����£��������ϴ���ͬ�ķ����Ƿ񱻰���
			if keypress==-1 and RepeatState[CC.PrevKeypress] and RepeatState[CC.PrevKeypress] ~=0 then
				keypress = CC.PrevKeypress
				repeatkey = true
			elseif repeatkey == false then
				for i = VK_RIGHT,VK_UP do
					if RepeatState[i] ~=0 then
						keypress = i
						repeatkey = true
						break
					end
				end
			end
			CC.PrevKeypress = keypress
			if keypress==VK_UP then
				direct=0;
				JY.WalkCount = JY.WalkCount + 1
			elseif keypress==VK_DOWN then
				direct=3;
				JY.WalkCount = JY.WalkCount + 1
			elseif keypress==VK_LEFT then
				direct=2;
				JY.WalkCount = JY.WalkCount + 1
			elseif keypress==VK_RIGHT then
				direct=1;
				JY.WalkCount = JY.WalkCount + 1
			else
				JY.WalkCount = 0
				JY.WalkTime = 0
			end
		end

    if ktype == 1 then
        JY.Mytick = 0;
        if keypress == VK_ESCAPE then
            Cls()
            -- MMenu();
            CMenu()
        elseif keypress == VK_SPACE or keypress == VK_RETURN then -- �ո񴥷��¼�
            if JY.Base["�˷���"] >= 0 then
                local d_num = GetS(JY.SubScene, JY.Base["��X1"] + CC.DirectX[JY.Base["�˷���"] + 1],
                    JY.Base["��Y1"] + CC.DirectY[JY.Base["�˷���"] + 1], 3);
                if d_num >= 0 then
                    EventExecute(d_num, 1);
                end
            end
            -- �޾Ʋ�����ȫ�׿�ݼ� 7-30
        elseif keypress == VK_S and JY.SubScene ~= 150 then -- �浵
            Menu_SaveRecord()
        elseif keypress == VK_L and JY.SubScene ~= 150 then -- ����
            Menu_ReadRecord()
        elseif keypress == VK_F1 then -- ��Ʒ
            Cls()
            Menu_Thing()
        elseif keypress == VK_Z then -- ״̬
            Cls()
            -- Duiwumb()
            LGJYXX()
        elseif keypress == VK_M then -- ������λ
            Cls()
            Game_sm()
        elseif keypress == VK_F3 then -- ������λ
            Cls()
            Menu_TZDY()
        elseif keypress == VK_F4 then -- ����
            Cls()
            Menu_WPZL()
        elseif keypress == VK_C then
            --Game_sm()
            CMenu()
        elseif keypress == VK_R then
            Game_Kdef()
        end
    elseif ktype == 3 then
        local bx, by = CC.WX, CC.HY
        local ffx, ffy = lib.GetPNGXY(91, 504 * 2)
        local h = 70
        local jhx,jhy = lib.GetPNGXY(91,556*2)
        if mx > 0 and mx < CC.WX * 100 and my > 0 and my < CC.HY * 100 then
            Cls()
            jiemian(1)
        elseif mx >= bx * 1171 and mx <= bx * 1255 and my >= by * 623 and by <= by * 706 and JY.Base["����"] == 1 then
            Cls()
            CHOUKA()
        elseif mx > CC.WX * 604 and mx < CC.WX * 604 + CC.WX * 72 and my > CC.HY * 3 and my < CC.HY * 77 then
            Cls()
            LGWeather()
        elseif mx > 0 and mx < ffx and my > CC.ScreenH / 6 and my < CC.ScreenH / 6 + h then -- ������Ϣ
            Cls()
            LGJYXX()
        elseif mx > 0 and mx < ffx and my > CC.ScreenH / 6 + h * 2 and my < CC.ScreenH / 6 + h * 3 then -- ���� ͼǩ 
            Cls()
            Game_sm()
        elseif mx > 0 and mx < ffx and my > CC.ScreenH / 6 + h * 3 and my < CC.ScreenH / 6 + h * 4 then -- ����
            Cls()
            Game_Kdef()
        elseif mx > CC.ScreenW - jhx and mx < CC.ScreenW and  my > CC.ScreenH/30 and my < CC.ScreenH/30 + jhy then --��������
            JH_Txt()
        else
            AutoMoveTab = {
                [0] = 0
            }
            local x0 = JY.Base["��X1"]
            local y0 = JY.Base["��Y1"]

            local px = x0
            local py = y0
            if CONFIG.Zoom == 100 then
                -- �޾Ʋ����������ڵ�ͼ�߽��Զ�Ѱ·���������
                px = limitX(x0, 13, 46)
                py = limitX(y0, 13, 46)
            else
                px = x0
                py = y0
            end

            mx = mx + (px - py) * CC.XScale - CC.ScreenW / 2
            my = my + (px + py) * CC.YScale - CC.ScreenH / 2

            local xx = (mx / CC.XScale + my / CC.YScale) / 2;
            local yy = (my / CC.YScale - mx / CC.XScale) / 2;

            if xx - math.modf(xx) > 0 then
                xx = math.modf(xx);
            end

            if yy - math.modf(yy) > 0 then
                yy = math.modf(yy);
            end

            if CONFIG.Zoom ~= 100 then -- �޾Ʋ�������֪��ʲôë�����������Ӿ�����ë��
                xx = xx + 1
                yy = yy + 1
            end

            if xx > 0 and xx < CC.SWidth and yy > 0 and yy < CC.SHeight then
                walkto(xx - x0, yy - y0)
            end
        end
    elseif ktype == 4 then
        JY.Mytick = 0;
        Cls()
        -- MMenu();
        CMenu()
    end

    if JY.Status ~= GAME_SMAP then
        return;
    end

    -- �޾Ʋ������б���¼����꣬���Զ��ߵ�ǰ��һ��Żᴥ���¼�
    if CC.AutoMoveEvent[1] ~= 0 and
        (JY.Base["��X1"] == CC.AutoMoveEvent[1] or JY.Base["��X1"] - 1 == CC.AutoMoveEvent[1] or JY.Base["��X1"] + 1 ==
            CC.AutoMoveEvent[1]) and
        (JY.Base["��Y1"] == CC.AutoMoveEvent[2] or JY.Base["��Y1"] - 1 == CC.AutoMoveEvent[2] or JY.Base["��Y1"] + 1 ==
            CC.AutoMoveEvent[2]) then
        CC.AutoMoveEvent[0] = 1 -- �����������¼�
    end

    if AutoMoveTab[0] ~= 0 then -- ����Զ��߶�
        if direct == -1 then
            direct = AutoMoveTab[AutoMoveTab[0]]
            AutoMoveTab[AutoMoveTab[0]] = nil
            AutoMoveTab[0] = AutoMoveTab[0] - 1
        end
    else
        AutoMoveTab = {
            [0] = 0
        }
        if CC.AutoMoveEvent[0] == 1 then
            EventExecute(GetS(JY.SubScene, CC.AutoMoveEvent[1], CC.AutoMoveEvent[2], 3), 1);
            CC.AutoMoveEvent[0] = 0;
            CC.AutoMoveEvent[1] = 0;
            CC.AutoMoveEvent[2] = 0;
        end
    end

    if direct ~= -1 then
        AddMyCurrentPic();
        x = JY.Base["��X1"] + CC.DirectX[direct + 1];
        y = JY.Base["��Y1"] + CC.DirectY[direct + 1];
        JY.Base["�˷���"] = direct;
        if JY.WalkCount == 1 then
            lib.Delay(CC.Frame)
        end
    else
        x = JY.Base["��X1"];
        y = JY.Base["��Y1"];
    end

    JY.MyPic = GetMyPic();
    DtoSMap();
    if SceneCanPass(x, y) == true then -- �µ���������߹�ȥ
        JY.Base["��X1"] = x;
        JY.Base["��Y1"] = y;
    end

    JY.Base["��X1"] = limitX(JY.Base["��X1"], 1, CC.SWidth - 2);
    JY.Base["��Y1"] = limitX(JY.Base["��Y1"], 1, CC.SHeight - 2);

    -- һЩ�µ��¼�
    NEvent(keypress)
end

-- ���ͼ��Ϣ
function Game_MMap() -- ����ͼ
    local bx, by = CC.ScreenW / 1360, CC.ScreenH / 768
    if JY.Restart == 1 then
        return
    end
    local direct = -1;
    local px, py = -1, -1
    local bx, by = CC.WX, CC.HY
    local jyxx = 0
	local repeatkey = false
	lib.WalkMode(1) --����������
    local keypress, ktype, mx, my = lib.GetKey();
	lib.WalkMode(0)
    if mx ~= -1 and my ~= -1 then
        px, py = mx, my
    end
	
	if JY.WalkTime == 0 then
		CC.WalkTime = socket.gettime() * 1000 + CC.WalkSkip 
	else
		JY.WalkTime = socket.gettime() * 1000
	end
	
	local RepeatState = {}
	for i = VK_RIGHT,VK_UP do
		RepeatState[i] = lib.GetKeyState(i)
	end 
	
    --�ȼ����ϴβ�ͬ�ķ����Ƿ񱻰���
		if (JY.WalkTime == 0 or JY.WalkTime < CC.WalkTime) and CC.WalkSkip ~= 0 then
			if keypress==VK_UP then
				direct=0;
				JY.WalkCount = JY.WalkCount + 1
				JY.WalkTime = 0
			elseif keypress==VK_DOWN then
				direct=3;
				JY.WalkCount = JY.WalkCount + 1
				JY.WalkTime = 0
			elseif keypress==VK_LEFT then
				direct=2;
				JY.WalkCount = JY.WalkCount + 1
				JY.WalkTime = 0
			elseif keypress==VK_RIGHT then
				direct=1;
				JY.WalkCount = JY.WalkCount + 1
				JY.WalkTime = 0
			elseif RepeatState[VK_UP] ==0 and RepeatState[VK_DOWN] ==0 and RepeatState[VK_LEFT] ==0 and RepeatState[VK_RIGHT] ==0 then
				JY.WalkTime = 0	
			elseif JY.WalkTime < CC.WalkSkip then
				JY.WalkTime = 1
			end
		else
			for i = VK_RIGHT,VK_UP do
				if i ~= CC.PrevKeypress and RepeatState[i] ~=0 then
					keypress = i
					repeatkey = true
				end
			end 
			if keypress==-1 and RepeatState[CC.PrevKeypress] and RepeatState[CC.PrevKeypress] ~=0 then
				keypress = CC.PrevKeypress
				repeatkey = true
			elseif repeatkey == false then
				for i = VK_RIGHT,VK_UP do
					if RepeatState[i] ~=0 then
						keypress = i
						repeatkey = true
						break
					end
				end
			end
			CC.PrevKeypress = keypress
			if keypress==VK_UP then
				direct=0;
				JY.WalkCount = JY.WalkCount + 1
			elseif keypress==VK_DOWN then
				direct=3;
				JY.WalkCount = JY.WalkCount + 1
			elseif keypress==VK_LEFT then
				direct=2;
				JY.WalkCount = JY.WalkCount + 1
			elseif keypress==VK_RIGHT then
				direct=1;
				JY.WalkCount = JY.WalkCount + 1
			else
				JY.WalkCount = 0
				JY.WalkTime = 0
			end
		end

    if ktype == 1 then
        JY.Mytick = 0;
        if keypress == VK_ESCAPE then
            Cls()
            -- MMenu();
            CMenu()
            if JY.Status ~= GAME_MMAP then
                return;
            end
        elseif keypress == VK_H then -- ��hֱ�ӻؼ�
            JY.Wugong[343]['������Χ'] = 1
            JY.Wugong[343]['�ƶ���Χ' .. 10] = 7
            JY.Wugong[343]['�书����&��Ч'] = 115
            JY.Wugong[343]['������' .. 10] = 1400
            JY.Wugong[345]['������' .. 10] = 1400
            JY.Person[64]['�ؼ�' .. 1] = 4
            JY.Person[113]['�ؼ�' .. 1] = 3
            JY.Person[51]['�ؼ�' .. 1] = 3
            JY.Wugong[202]["������" .. 10] = 700
            My_Enter_SubScene(70, 35, 31, 2);
            return;
            -- �޾Ʋ�����ȫ�׿�ݼ� 7-30
        elseif keypress == VK_S and JY.SubScene ~= 150 then -- �浵
            Menu_SaveRecord()
        elseif keypress == VK_L and JY.SubScene ~= 150 then -- ����
            Menu_ReadRecord()
            if JY.Status ~= GAME_MMAP then
                return;
            end
        elseif keypress == VK_F1 then -- ��Ʒ
            Cls()
            Menu_Thing()            
        elseif keypress == VK_Z then -- ״̬
            Cls()
            -- Duiwumb()
            LGJYXX()
        elseif keypress == VK_R then -- ��Ʒ
            Cls()
            Game_Kdef()
        elseif keypress == VK_M then -- ��	
            Cls()
            -- My_ChuangSong_Ex()
            CHUANSONG()
            if JY.Status ~= GAME_MMAP then
                return;
            end
        elseif keypress == VK_F3 then -- ������λ
            Cls()
            Menu_TZDY()
        elseif keypress == VK_F4 then -- ����
            Cls()
            Menu_WPZL()
        elseif keypress == VK_C then
            Cls()
            --Game_sm()
            CMenu()
        end
    elseif ktype == 2 or ktype == 3 then
        local tmpx, tmpy = mx, my
        mx = mx - CC.ScreenW / 2
        my = my - CC.ScreenH / 2
        mx = (mx) / CC.XScale
        my = (my) / CC.YScale
        mx, my = (mx + my) / 2, (my - mx) / 2
        if mx > 0 then
            mx = mx + 0.99
        else
            mx = mx - 0.01
        end
        if my > 0 then
            my = my + 0.99
        else
            mx = mx - 0.01
        end
        mx = math.modf(mx) + JY.Base["��X"];
        my = math.modf(my) + JY.Base["��Y"]

        -- ����ƶ�
        if ktype == 2 then
            if lib.GetMMap(mx, my, 3) > 0 then -- ����н������ж��Ƿ�ɽ���
                for i = 0, 4 do
                    for j = 0, 4 do
                        local xx, yy = mx - i, my - j;
                        local sid = CanEnterScene(xx, xx);
                        if sid < 0 then
                            xx, yy = mx + i, my + j;
                            sid = CanEnterScene(xx, yy);
                        end
                        if sid >= 0 then
                            CC.MMapAdress[0] = sid;
                            CC.MMapAdress[1] = tmpx;
                            CC.MMapAdress[2] = tmpy;
                            CC.MMapAdress[3] = xx;
                            CC.MMapAdress[4] = yy;
                            i = 5; -- �˳�ѭ��
                            break
                        end
                    end
                end
            else
                CC.MMapAdress[0] = nil;
            end
            -- ������
        elseif ktype == 3 then
            local ffx, ffy = lib.GetPNGXY(91, 504 * 2)
            local jhx,jhy = lib.GetPNGXY(91,556*2)
            if tmpx > 0 and tmpx < CC.WX * 100 and tmpy > 0 and tmpy < CC.HY * 100 then
                jiemian(1)
            elseif tmpx > CC.WX * 604 and tmpx < CC.WX * 604 + CC.WX * 72 and tmpy > CC.HY * 3 and tmpy < CC.HY * 77 then
                LGWeather()
            elseif tmpx > 0 and tmpx < ffx and tmpy > CC.ScreenH / 6 and tmpy < CC.ScreenH / 6 + ffy then -- ������Ϣ
                LGJYXX()
            elseif tmpx > 0 and tmpx < ffx and tmpy > CC.ScreenH / 4 and tmpy < CC.ScreenH / 4 + ffy then -- �򿪵�ͼ		
                CHUANSONG()
            elseif tmpx > 0 and tmpx < ffx and tmpy > CC.ScreenH / 3 and tmpy < CC.ScreenH / 3 + ffy * 1.2 then -- ���� ͼǩ 
                Game_sm()
            elseif tmpx > 0 and tmpx < ffx and tmpy > CC.ScreenH / 3 + ffy * 1.2 and tmpy < CC.ScreenH / 3 + ffy * 1.2 *
                2 then -- ���� ͼǩ 
                Game_Kdef()
            elseif tmpx > CC.ScreenW - jhx and tmpx < CC.ScreenW and  tmpy > CC.ScreenH/30 and tmpy < CC.ScreenH/30 + jhy then --��������
                JH_Txt()    
            else
                if CC.MMapAdress[0] ~= nil then
                    mx = CC.MMapAdress[3] - JY.Base["��X"];
                    my = CC.MMapAdress[4] - JY.Base["��Y"];
                    CC.MMapAdress[0] = nil;
                else
                    AutoMoveTab = {
                        [0] = 0
                    }
                    mx = mx - JY.Base["��X"]
                    my = my - JY.Base["��Y"]
                end
                walkto(mx, my)
            end
        end
    elseif ktype == 4 then
        JY.Mytick = 0;
        Cls()
        -- MMenu();
        CMenu()
        if JY.Status ~= GAME_MMAP then
            return;
        end
    end

    if AutoMoveTab[0] ~= 0 then
        if direct == -1 then
            direct = AutoMoveTab[AutoMoveTab[0]]
            AutoMoveTab[AutoMoveTab[0]] = nil
            AutoMoveTab[0] = AutoMoveTab[0] - 1
        end
    else
        AutoMoveTab = {
            [0] = 0
        }
    end

    local x, y; -- ���շ����Ҫ���������
    local CanMove = function(nd, nnd)
        local nx, ny = JY.Base["��X"] + CC.DirectX[nd + 1], JY.Base["��Y"] + CC.DirectY[nd + 1]
        if nnd ~= nil then
            nx, ny = nx + CC.DirectX[nnd + 1], ny + CC.DirectY[nnd + 1]
        end
        if CC.hx == nil and
            ((lib.GetMMap(nx, ny, 3) == 0 and lib.GetMMap(nx, ny, 4) == 0) or CanEnterScene(nx, ny) ~= -1) then
            return true
        else
            return false
        end
    end
    if direct ~= -1 then -- �����˹���
        AddMyCurrentPic(); -- ����������ͼ��ţ�������·Ч��
        x = JY.Base["��X"] + CC.DirectX[direct + 1];
        y = JY.Base["��Y"] + CC.DirectY[direct + 1];
        JY.Base["�˷���"] = direct;
        if JY.WalkCount == 1 then
            lib.Delay(CC.Frame)
        end
    else
        x = JY.Base["��X"];
        y = JY.Base["��Y"];

    end

    if direct ~= -1 then
        JY.SubScene = CanEnterScene(x, y); -- �ж��Ƿ�����ӳ���
    end

    if lib.GetMMap(x, y, 3) == 0 and lib.GetMMap(x, y, 4) == 0 then -- û�н��������Ե���
        JY.Base["��X"] = x;
        JY.Base["��Y"] = y;
    end
    JY.Base["��X"] = limitX(JY.Base["��X"], 10, CC.MWidth - 10); -- �������겻�ܳ�����Χ
    JY.Base["��Y"] = limitX(JY.Base["��Y"], 10, CC.MHeight - 10);

    if CC.MMapBoat[lib.GetMMap(JY.Base["��X"], JY.Base["��Y"], 0)] == 1 then
        JY.Base["�˴�"] = 1;
    else
        JY.Base["�˴�"] = 0;
    end
    local sc = CC.Shichen
    if CC.TX['ҹĻ'] == 1 then
        sc = 6
    end
    lib.DrawMMap(JY.Base["��X"], JY.Base["��Y"], GetMyPic(), sc); -- �滭����ͼ

    JYZTB(); -- ���ϽǼ�����Ϣ	
    --DrawTimer(); -- ���ϽǶ�̬��ʾ
    -- DrawTimerA()

    -- ��ʾ���ָ�еĳ�������
    if CC.MMapAdress[0] ~= nil then
        DrawStrBox(CC.MMapAdress[1] + 10, CC.MMapAdress[2], JY.Scene[CC.MMapAdress[0]]["����"], C_GOLD, CC.DefaultFont);
    end

    ShowScreen();

    if JY.SubScene >= 0 then -- �����ӳ���
        CleanMemory();
        -- lib.UnloadMMap();
        -- lib.PicInit();
        lib.ShowSlow(20, 1)

        JY.Status = GAME_SMAP;
        JY.MmapMusic = -1;

        JY.MyPic = GetMyPic();
        JY.Base["��X1"] = JY.Scene[JY.SubScene]["���X"]
        JY.Base["��Y1"] = JY.Scene[JY.SubScene]["���Y"]

        Init_SMap(1);
        return
    end
end

-- ������·
function walkto(xx, yy, x, y, flag)
    local x, y
    AutoMoveTab = {
        [0] = 0
    }
    if JY.Status == GAME_SMAP then
        x = x or JY.Base["��X1"]
        y = y or JY.Base["��Y1"]
    elseif JY.Status == GAME_MMAP then
        x = x or JY.Base["��X"]
        y = y or JY.Base["��Y"]
    end
    xx, yy = xx + x, yy + y
    if JY.Status == GAME_SMAP then
        CC.AutoMoveEvent[0] = 0;
        CC.AutoMoveEvent[1] = 0;
        CC.AutoMoveEvent[2] = 0;

        if SceneCanPass(xx, yy) == false then
            if GetS(JY.SubScene, xx, yy, 3) > 0 and GetD(JY.SubScene, GetS(JY.SubScene, xx, yy, 3), 2) > 0 then
                CC.AutoMoveEvent[1] = xx;
                CC.AutoMoveEvent[2] = yy;
                -- �޾Ʋ�����һ�����۵�ϸ���޸ģ��Զ������¼���վλ���ȼ�
                if x < xx then
                    if SceneCanPass(xx - 1, yy) then
                        xx = xx - 1;
                    elseif SceneCanPass(xx, yy + 1) then
                        yy = yy + 1;
                    elseif SceneCanPass(xx, yy - 1) then
                        yy = yy - 1;
                    elseif SceneCanPass(xx + 1, yy) then
                        xx = xx + 1;
                    else
                        return;
                    end
                else
                    if SceneCanPass(xx + 1, yy) then
                        xx = xx + 1;
                    elseif SceneCanPass(xx, yy + 1) then
                        yy = yy + 1;
                    elseif SceneCanPass(xx, yy - 1) then
                        yy = yy - 1;
                    elseif SceneCanPass(xx - 1, yy) then
                        xx = xx - 1;
                    else
                        return;
                    end
                end
            else
                return;
            end
        end

    end
    if JY.Status == GAME_MMAP and
        ((lib.GetMMap(xx, yy, 3) == 0 and lib.GetMMap(xx, yy, 4) == 0) or CanEnterScene(xx, yy) ~= -1) == false then
        return
    end
    local steparray = {};
    local stepmax;
    local xy = {}
    if JY.Status == GAME_SMAP then
        for i = 0, CC.SWidth - 1 do
            xy[i] = {}
        end
    elseif JY.Status == GAME_MMAP then
        for i = 0, 479 do
            xy[i] = {}
        end
    end
    if flag ~= nil then
        stepmax = 640
    else
        stepmax = 240
    end
    for i = 0, stepmax do
        steparray[i] = {};
        steparray[i].x = {};
        steparray[i].y = {};
    end
    local function canpass(nx, ny)
        if JY.Status == GAME_SMAP and (nx > CC.SWidth - 1 or ny > CC.SWidth - 1 or nx < 0 or ny < 0) then
            return false
        end
        if JY.Status == GAME_MMAP and (nx > 479 or ny > 479 or nx < 1 or ny < 1) then
            return false
        end
        if xy[nx][ny] == nil then
            if JY.Status == GAME_SMAP then
                if SceneCanPass(nx, ny) then
                    return true
                end
            elseif JY.Status == GAME_MMAP then
                if (lib.GetMMap(nx, ny, 3) == 0 and lib.GetMMap(nx, ny, 4) == 0) or CanEnterScene(nx, ny) ~= -1 then
                    return true
                end
            end
        end
        return false
    end

    local function FindNextStep(step)
        if step == stepmax then
            return
        end
        local step1 = step + 1
        local num = 0
        for i = 1, steparray[step].num do

            if steparray[step].x[i] == xx and steparray[step].y[i] == yy then
                return
            end

            if canpass(steparray[step].x[i] + 1, steparray[step].y[i]) then
                num = num + 1
                steparray[step1].x[num] = steparray[step].x[i] + 1
                steparray[step1].y[num] = steparray[step].y[i]
                xy[steparray[step1].x[num]][steparray[step1].y[num]] = step1
            end
            if canpass(steparray[step].x[i] - 1, steparray[step].y[i]) then
                num = num + 1
                steparray[step1].x[num] = steparray[step].x[i] - 1
                steparray[step1].y[num] = steparray[step].y[i]
                xy[steparray[step1].x[num]][steparray[step1].y[num]] = step1
            end
            if canpass(steparray[step].x[i], steparray[step].y[i] + 1) then
                num = num + 1
                steparray[step1].x[num] = steparray[step].x[i]
                steparray[step1].y[num] = steparray[step].y[i] + 1
                xy[steparray[step1].x[num]][steparray[step1].y[num]] = step1
            end
            if canpass(steparray[step].x[i], steparray[step].y[i] - 1) then
                num = num + 1
                steparray[step1].x[num] = steparray[step].x[i]
                steparray[step1].y[num] = steparray[step].y[i] - 1
                xy[steparray[step1].x[num]][steparray[step1].y[num]] = step1
            end
        end
        if num > 0 then
            steparray[step1].num = num
            FindNextStep(step1)
        end
    end

    steparray[0].num = 1;
    steparray[0].x[1] = x;
    steparray[0].y[1] = y;
    xy[x][y] = 0
    FindNextStep(0);

    local movenum = xy[xx][yy];

    if movenum == nil then
        return
    end
    AutoMoveTab[0] = movenum
    for i = movenum, 1, -1 do
        if xy[xx - 1][yy] == i - 1 then
            xx = xx - 1;
            AutoMoveTab[1 + movenum - i] = 1;
        elseif xy[xx + 1][yy] == i - 1 then
            xx = xx + 1;
            AutoMoveTab[1 + movenum - i] = 2;
        elseif xy[xx][yy - 1] == i - 1 then
            yy = yy - 1;
            AutoMoveTab[1 + movenum - i] = 3;
        elseif xy[xx][yy + 1] == i - 1 then
            yy = yy + 1;
            AutoMoveTab[1 + movenum - i] = 0;
        end
    end
end

function GetMyPic() -- �������ǵ�ǰ��ͼ
    local n;
    if JY.Status == GAME_MMAP and JY.Base["�˴�"] == 1 then
        if JY.MyCurrentPic >= 4 then
            JY.MyCurrentPic = 0
        end
    else
        if JY.MyCurrentPic > 6 then
            JY.MyCurrentPic = 1
        end
    end

    if JY.Base["�˴�"] == 0 then
        if JY.Base["����"] == 757 then
            n = CC.MyStartPicCG + JY.Base["�˷���"] * 7 + JY.MyCurrentPic;
        elseif JY.Base['����'] == 752 then 
            n = CC.MyStartPicLG + JY.Base["�˷���"] * 7 + JY.MyCurrentPic;
        elseif JY.Person[0]["�Ա�"] == 0 then
            n = CC.MyStartPicM + JY.Base["�˷���"] * 7 + JY.MyCurrentPic;
        else
            n = CC.MyStartPicF + JY.Base["�˷���"] * 7 + JY.MyCurrentPic;
        end
    else
        n = CC.BoatStartPic + JY.Base["�˷���"] * 4 + JY.MyCurrentPic;
    end
    return n;
end

-- ���ӵ�ǰ������·����֡, ����ͼ�ͳ�����ͼ��ʹ��
function AddMyCurrentPic()
    JY.MyCurrentPic = JY.MyCurrentPic + 1;
end

-- �����Ƿ�ɽ�
-- id ��������
-- x,y ��ǰ����ͼ����
-- ���أ�����id��-1��ʾû�г����ɽ�
function CanEnterScene(x, y) -- �����Ƿ�ɽ�
    for id = 0, JY.SceneNum - 1 do
        local scene = JY.Scene[id];
        if (x == scene["�⾰���X1"] and y == scene["�⾰���Y1"]) or
            (x == scene["�⾰���X2"] and y == scene["�⾰���Y2"]) then
            local e = scene["��������"];
            if e == 0 then -- �ɽ�
                return id;
            elseif e == 1 then -- ���ɽ�
                return -1
            end
        end
    end
    return -1;
end

-- ���˵�
function MMenu()
    local menu = {{"����", Menu_Teaminfo, 1}, {"��Ʒ", Menu_Thing, 1}, {"ҽ��", Menu_Doctor, 1},
                  {"�ⶾ", Menu_DecPoison, 1}, {"���", Menu_PersonExit, 1}, {"ϵͳ", Menu_System, 1}};

    ShowMenu(menu, 6, 0, CC.MainMenuX, CC.MainMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)
    local x1 = CC.ScreenH / 2
    local y1 = CC.ScreenW / 2
    -- lib.LoadPicture(CONFIG.DataPath.."body/999.png",x1,y1,CC.ScreenW/677*80)
end

-- ϵͳ�Ӳ˵�
function Menu_System()
    local menu = {{"��ȡ����", Menu_ReadRecord, 1}, {"�������", Menu_SaveRecord, 1},
                  {"�ر�����", Menu_SetMusic, 1}, {"�ر���Ч", Menu_SetSound, 1},
                  {"��Ʒ����", Menu_WPZL, 1}, -- {"ϵͳ����", Menu_Help, 1},
    {"ͨ�ؼ�¼", pastReview, 1}, {"�ҵĴ���", Menu_MYDIY, 1}, {"�뿪��Ϸ", Menu_Exit2, 1}}
    if JY.EnableMusic == 0 then
        menu[3][1] = "������"
    end
    if JY.EnableSound == 0 then
        menu[4][1] = "����Ч"
    end
    local r =
        ShowMenu(menu, #menu, 0, CC.MainSubMenuX, CC.MainSubMenuY, -1, -1, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)
    if r == 0 then
        return 0
    elseif r < 0 then
        return 1
    end
end

function Menu_MYDIY()
    local r = LGMsgBox("�ҵĴ���", "ִ���Զ������*ָ����script/DIY.lua�ļ�", {"ȷ��", "ȡ��"}, 2,
        0, 1);
    if r == 1 then
        --if instruct_18(312) then
            dofile(CONFIG.ScriptPath .. "DIY.lua");
        --end
    end
end

function Menu_Help()
    -- ��ʱȡ��
    --[[
	local title = "ϵͳ����";
	local str ="װ��˵�����鿴����װ����˵����"
						.."*�书˵�����鿴�����书��˵����"
						.."*���鹥�ԣ�����������÷����Լ���Ϸ�����ԡ�"
	local btn = {"װ��˵��","�书˵��","���鹥��"};
	local num = #btn;
	local r = LGMsgBox(title,str,btn,num,nil,1);

	if r == 1 then
		ZBInstruce();
	elseif r == 2 then
		WuGongIntruce();
	elseif r == 3 then
		TSInstruce();
	end]]
    return 1;
end

-- ���ֿ���
function Menu_SetMusic()
    if JY.EnableMusic == 0 then
        JY.EnableMusic = 1
        PlayMIDI(JY.CurrentMIDI)
    else
        JY.EnableMusic = 0
        lib.PlayMIDI("")
    end
    if JY.EnableSound == 0 then
        JY.EnableSound = 1
    else
        JY.EnableSound = 0
    end
    return 1
end

-- ��Ч����
function Menu_SetSound()
    if JY.EnableSound == 0 then
        JY.EnableSound = 1
    else
        JY.EnableSound = 0
    end
    return 1
end

--��Ϸ����
function Menu_Switch()
	local bx, by = CC.WX, CC.HY
	local size = CC.DefaultFont*0.9
    local yemu = CC.TX['ҹĻ']
	local chuansong = CC.TX['����']
	local yinyue = CC.TX['��������']
	local tianqi = CC.TX['ս������']
	local xinmo = CC.TX['��ħ']
	local w,h = lib.GetPNGXY(91,559*2) 
	local wz = {'��','��',
				'��ͼ','����',
				'��','��',
				'��','��',
				'��','��',
				'��','��',
				'��','��',
			}
	local n,m = 0,0
	local ww = bx*100
	local hh = by*86
	
	local tb = 1
	local tb1,tb2,tb3,tb4,tb5 = 0,0,0,0,0
	while true do 
		if JY.Restart == 1 then
            JY.Restart = 0
        end	
		Cls()

		local menu = {	{CC.TX['ҹĻ'],0,0,0,0}, --ҹĻ  --1�������� 2��������仯ֵ  3��������λ�� 4���� 5����ֵ
					{CC.TX['ҹĻ'],0,0,0,1}, --ҹĻ 
					{CC.TX['��'],2,1,0,0}, --����
					{CC.TX['��'],2,1,0,1}, --����
					{CC.TX['��ħ'],0,0,1,0}, --��ħ
					{CC.TX['��ħ'],0,0,1,1}, --��ħ
					{CC.TX['ս������'],2,1,1,0}, --ս������
					{CC.TX['ս������'],2,1,1,1}, --ս������
					{CC.TX['��������'],0,0,2,0}, --��������
					{CC.TX['��������'],0,0,2,1}, --��������
					{CC.TX['ս����Ѫ'],2,1,2,0}, --ս����Ѫ
					{CC.TX['ս����Ѫ'],2,1,2,1}, --ս����Ѫ
					{CC.TX['ս���ٶ�'],0,0,3,0}, --ս���ٶ�
					{CC.TX['ս���ٶ�'],0,0,3,1}, --ս���ٶ�

			}		
		local w2 = 0
		lib.LoadPNG(91, 559*2, CC.ScreenW / 2 - w/2, CC.ScreenH / 2 - h/2, 1)

		for i = 1,#wz do	
			local cl = C_WHITE
			if tb == i then 
				lib.LoadPNG(91,561*2,CC.ScreenW/2 - w/2 + size*5.5 + n*ww + w2,CC.ScreenH/2 - h/2 + size*1.8 + m*hh,1)
			end	

			--��ǰѡ��
			if menu[i][1] == menu[i][5] then 
				lib.LoadPNG(91,36*2,CC.ScreenW/2 - w/2 + size*5.3 + (menu[i][1] + menu[i][2])*ww + menu[i][3]*bx*190,CC.ScreenH/2 - h/2 + size*2.5 + menu[i][4]*hh,1,0,bx*20)
			end

			--�����б�
			DrawString(CC.ScreenW/2 - w/2 + size*5.5 + n*ww + w2,CC.ScreenH/2 - h/2 + size*2.5 + m*hh,wz[i],cl,size)
			n = n + 1
			if n == 2 or n == 3  then 
				w2 = bx*190
			else
				w2 = 0
			end
			if n == 4 then 
			   n = 0 
			   m = m + 1
			end
		end
		n = 0
		m = 0
		ShowScreen()
		lib.Delay(CC.Frame)
		local X,ktype,mx,my = lib.GetKey();
		if ktype == 4 or X == VK_ESCAPE then 
			PlayWavE(77)
			return 0
		elseif X == VK_RETURN or X == VK_SPACE then 
			PlayWavE(77)
			if tb == 1 then 
				CC.TX['ҹĻ'] = 0
			elseif tb == 2 then 
				CC.TX['ҹĻ'] = 1
			elseif tb == 3 then 
				CC.TX['��'] = 0
			elseif tb == 4 then 
				CC.TX['��'] = 1
			elseif tb == 5 then 
				CC.TX['��ħ'] = 0
			elseif tb == 6 then 
				CC.TX['��ħ'] = 1
			elseif tb == 7 then 
				CC.TX['ս������'] = 0
			elseif tb == 8 then 
				CC.TX['ս������'] = 1
			elseif tb == 9 then 
				CC.TX['��������'] = 0
			elseif tb == 10 then 
				CC.TX['��������'] = 1
			elseif tb == 11 then 
				CC.TX['ս����Ѫ'] = 0
			elseif tb == 12 then 
				CC.TX['ս����Ѫ'] = 1
			elseif tb == 13 then 
				CC.TX['ս���ٶ�'] = 0
			elseif tb == 14 then 
				CC.TX['ս���ٶ�'] = 1		
			end
		elseif X == VK_RIGHT then 
			PlayWavE(77)
			tb = tb + 1
			if tb > #wz then 
				tb = 1
			end
		elseif X == VK_DOWN then 
			PlayWavE(77)
			tb = tb + 4
			if tb > #wz then 
				tb = 1
			end			
		elseif X == VK_LEFT then 
			PlayWavE(77)
			tb = tb -1 
			if tb < 1 then 
				tb = #wz
			end
		elseif X == VK_UP then 
			PlayWavE(77)
			tb = tb - 4
			if tb < 1 then 
				tb = #wz
			end					
		else
			local mxx = false 
			w2 = 0
			for i = 1,#wz do 
 				if mx > CC.ScreenW/2 - w/2 + size*4.5 + n*ww + w2 and mx < CC.ScreenW/2 - w/2 + size*7 + n*ww + w2 and  my > CC.ScreenH/2 - h/2 + size*2 + m*hh and my < CC.ScreenH/2 - h/2 + size*4 + m*hh then 										
					PlayWavE(77)
					tb = i 
					mxx = true 					
					break
				end	
				n = n + 1
				if n == 2 or n == 3  then 
					w2 = bx*190
				else
					w2 = 0
				end
				if n == 4 then 
					n = 0 
					m = m + 1
				end
			end

			if mxx == true and ktype == 3 then 
				PlayWavE(77)
				if tb == 1 then 
					CC.TX['ҹĻ'] = 0
				elseif tb == 2 then 
					CC.TX['ҹĻ'] = 1
				elseif tb == 3 then 
					CC.TX['��'] = 0
				elseif tb == 4 then 
					CC.TX['��'] = 1
				elseif tb == 5 then 
					CC.TX['��ħ'] = 0
				elseif tb == 6 then 
					CC.TX['��ħ'] = 1
				elseif tb == 7 then 
					CC.TX['ս������'] = 0
				elseif tb == 8 then 
					CC.TX['ս������'] = 1
				elseif tb == 9 then 
					CC.TX['��������'] = 0
				elseif tb == 10 then 
					CC.TX['��������'] = 1
				elseif tb == 11 then 
					CC.TX['ս����Ѫ'] = 0
				elseif tb == 12 then 
					CC.TX['ս����Ѫ'] = 1
				elseif tb == 13 then 
					CC.TX['ս���ٶ�'] = 0
				elseif tb == 14 then 
					CC.TX['ս���ٶ�'] = 1				
				end
			end
			m = 0
			n = 0
		end
	end
end

-- ����˵�
function Menu_Teaminfo()
    local menu = {{"״̬�鿴", Menu_Status, 1}, {"��������", Menu_TZDY, 1}}

    ShowMenu(menu, 2, 0, CC.MainSubMenuX, CC.MainSubMenuY, -1, -1, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)
end

function Menu_Thing()
    local menu3 = {nil, 0, 1, 3, 4, 2}
    local bx, by = CC.WX, CC.HY
    local cont2 = 1
    local tb = 1
    while true do
        Cls()
        if JY.Restart == 1 then
            break
        end
        for i = 1, #menu3 do
            if i < 6 then
                lib.PicLoadCache(92, (15 + i) * 2, CC.ScreenW / 2 - ((#menu3 - 1) * bx * 120) / 2 + (i - 1) * bx * 120,
                    CC.ScreenH / 2 + by * 60, 2, 256, nil, bx * 100)
                if tb ~= i then
                    lib.PicLoadCache(92, (15 + i) * 2,
                        CC.ScreenW / 2 - ((#menu3 - 1) * bx * 120) / 2 + (i - 1) * bx * 120, CC.ScreenH / 2 + by * 60,
                        6, 150, nil, bx * 100)
                end
            else
                lib.PicLoadCache(92, 4 * 2, CC.ScreenW / 2 - ((#menu3 - 1) * bx * 120) / 2 + (i - 1) * bx * 120,
                    CC.ScreenH / 2 + by * 60, 2, 256, nil, bx * 100)
                if tb ~= i then
                    lib.PicLoadCache(92, 4 * 2, CC.ScreenW / 2 - ((#menu3 - 1) * bx * 120) / 2 + (i - 1) * bx * 120,
                        CC.ScreenH / 2 + by * 60, 6, 150, nil, bx * 100)
                end
            end
        end
        ShowScreen()
        lib.Delay(CC.Frame)
        local X, ktype, mx, my = lib.GetKey()
        if X == VK_SPACE or X == VK_RETURN then
            PlayWavE(77)
            if tb < 6 then
                ThingMenu(menu3[tb])
            else
                MJMenu()
            end
            if JY.ThingUse >= 0 then
                JY.ThingUse = 0
                return 1
            end
            if JY.Status == GAME_WMAP then
                return 1
            end
        elseif X == VK_ESCAPE or ktype == 4 then
            PlayWavE(77)
            break
            tb = 1
        elseif X == VK_LEFT then
            PlayWavE(77)
            tb = tb - 1
            if tb < 1 then
                tb = #menu3
            end
        elseif X == VK_RIGHT then
            PlayWavE(77)
            PlayWavE(77)
            tb = tb + 1
            if tb > #menu3 then
                tb = 1
            end
        else
            local mxx = false
            for i = 1, #menu3 do
                if mx >= CC.ScreenW / 2 - ((#menu3 - 1) * bx * 140) / 2 + (i - 1) * bx * 140 - bx * 50 and mx <=
                    CC.ScreenW / 2 - ((#menu3 - 1) * bx * 140) / 2 + (i - 1) * bx * 140 + bx * 50 and my >= CC.ScreenH /
                    2 + bx * 10 and my <= CC.ScreenH / 2 + bx * 110 then
                    tb = i
                    mxx = true
                    break
                end
            end
            if mxx == true and ktype == 3 then
                if tb < 6 then
                    ThingMenu(menu3[tb])
                else
                    MJMenu()
                end
                if JY.ThingUse >= 0 then
                    JY.ThingUse = 0
                    return 1
                end
                if JY.Status == GAME_WMAP then
                    return 1
                end
            end
        end
    end
end

-- ��ʾ��Ʒ�˵�
function SelectThing(thing, thingnum)
    local bx, by = CC.ScreenW / 1360, CC.ScreenH / 768
    local xnum = CC.MenuThingXnum;
    local ynum = CC.MenuThingYnum;

    local w = CC.ThingPicWidth * xnum + (xnum - 1) * CC.ThingGapIn + 2 * CC.ThingGapOut + CC.ScreenH / 2.021; -- ����bx
    local h = CC.ThingPicHeight * ynum + (ynum - 1) * CC.ThingGapIn + 2 * CC.ThingGapOut - CC.ScreenH / 96; -- ��Ʒ��by
	local dx = (CC.ScreenW - w) / 2;
    local dy = (CC.ScreenH - h - 2 * (CC.ThingFontSize + 2 * CC.MenuBorderPixel + 8)) / 2 - CC.ThingFontSize - CC.ScreenH / 69.818;
	local mjx = CC.ScreenW / 1.35  --980
	local mjy = CC.ScreenH / 4.7 --120
	local mjw = 22
	local mjh = 15
	local mjsize = CC.DefaultFont * 0.65
    local y1_1, y1_2, y2_1, y2_2, y3_1, y3_2; -- ���ƣ�˵����ͼƬ��Y����

    local cur_line = 0;
    local cur_x = 0;
    local cur_y = 0;
    local cur_thing = -1;
    local wpsm = 0
    local color = C_WHITE
    -- �޾Ʋ�������¼�������Ʒ
    local original_thing = {}
    local original_thingnum = {}
    if IsViewingKungfuScrolls == 1 then
        original_thing = thing
        original_thingnum = thingnum
    end
    local size = CC.ThingFontSize * 0.85
    local STARTH1, WGSTARTH, WGSTARTH1 = 0, 0, 0
    local FY1, h, h1, SHUOMING, xlsm = 0, 0, 0, 0, 0
    local FY, STARTH = 0, 0
    -- lib.Debug(' #thing = '..#thing)

    while true do
        if JY.Restart == 1 then
            break
        end
        Cls();
        y1_1 = dy;
        y1_2 = y1_1 + CC.ThingFontSize + 2 * CC.MenuBorderPixel;
        y2_1 = y1_2 + 5
        y2_2 = y2_1 + CC.ThingFontSize + 2 * CC.MenuBorderPixel
        y3_1 = y2_2 + 5;
        y3_2 = y3_1 + h;
        lib.LoadPNG(91, 9 * 2, -1, -1, 1)
        local function strcolor_switch(s)
            local Color_Switch = {{"��", PinkRed}, {"��", M_Wheat}, {"��", C_BLACK}, {"��", C_WHITE},
                                  {"��", C_ORANGE}, {"��", LimeGreen}, {"��", M_DeepSkyBlue}, {"��", Violet}}
            for i = 1, 8 do
                if Color_Switch[i][1] == s then
                    return Color_Switch[i][2]
                end
            end
        end

        for y = 0, ynum - 1 do
            for x = 0, xnum - 1 do
                local id = y * xnum + x + xnum * cur_line
                -- lib.Debug('id=='..id)
                local boxcolor;
                local thingID = thing[id]
                local function wugong_info(thingID)
                    -- lib.Debug(thingID);
                    local h1 = 0
                    local me = {}
                    local hs1 = 0
                    local myh1 = 7
                    local mm = 1
                    local function strcolor_switch(s)
                        local Color_Switch = {{"��", PinkRed}, {"��", M_Wheat}, {"��", C_BLACK},
                                              {"��", C_WHITE}, {"��", C_ORANGE}, {"��", LimeGreen},
                                              {"��", M_DeepSkyBlue}, {"��", Violet}}
                        for i = 1, 8 do
                            if Color_Switch[i][1] == s then
                                return Color_Switch[i][2]
                            end
                        end
                    end
                    if ItemInfo[thingID] ~= nil then
                        for i = 1, #ItemInfo[thingID] do
                            me[#me + 1] = ItemInfo[thingID][i]
                            if i == ItemInfo[thingID] then
                                me[#me + 1] = "��"
                            end
                        end
                    else
                        me[#me + 1] = ""
                    end
                    for i = mm, #me do
                        local smsize = mjsize
                        local tfstr = me[i]
                        local color;
                        color = strcolor_switch(string.sub(tfstr, 1, 2))
                        tfstr = string.sub(tfstr, 3, -1)
                        if string.sub(tfstr, 1, 2) == "��" then
                            --	hs1 = hs1 + 1
                        else
                            h1 = tjm(mjx, mjy + smsize * (hs1 - WGSTARTH),tfstr, color, smsize, 24, smsize, WGSTARTH - hs1, myh1 + 1 - hs1 + WGSTARTH)
                        end
                        hs1 = hs1 + h1
                    end
                    if hs1 > myh1 then
                        FY = limitX(hs1 - myh1 - 1, 0)
                    else
                        FY = 0
                    end
                end
                -- ѡ����Ʒ��ɫ 
                if x == cur_x and y == cur_y then
                    boxcolor = S_Yellow;
                    if thing[id] ~= nil and thing[id] >= 0 then
                        cur_thing = thing[id];
                        local str = JY.Thing[thing[id]]["����"];
                        -- װ���ȼ���ʾ
                        if JY.Thing[thing[id]]["װ��λ��"] > -1 then
                            str = str .. " LV" .. JY.Thing[thing[id]]["װ���ȼ�"]
                        end
                        if JY.Thing[thing[id]]["����"] == 1 or JY.Thing[thing[id]]["����"] == 2 then
                            if JY.Thing[thing[id]]["ʹ����"] >= 0 then
                                str = str .. "(" .. JY.Person[JY.Thing[thing[id]]["ʹ����"]]["����"] .. ")";
                            end
                        end

                        local myfont = CC.FontSmall
                        local mx, my = dx + 4 * myfont, y3_2 + 2
                        local myflag = 0
                        local myThing = JY.Thing[thing[id]]

                        local str2 = JY.Thing[thing[id]]["��Ʒ˵��"];
                        if thing[id] == 182 then
                            str2 = str2 .. string.format('(��%3d,%3d)', JY.Base['��X'], JY.Base['��Y'])
                        end
                        DrawString(dx + CC.ThingGapOut + CC.ScreenW / 68, y1_1 + CC.MenuBorderPixel + CC.ThingFontSize, str, C_GOLD, CC.ThingFontSize);
                        DrawString(dx + CC.ThingGapOut + CC.ScreenW / 68, y2_1 + CC.MenuBorderPixel + CC.ScreenH / 76.8, str2, C_ORANGE, CC.ThingFontSize * 0.9);

                        -- ��Ʒ˵����ʾ
                        local function drawitem(ss, str, news)
                            local color = C_GOLD
                            local mys
                            if str == nil then
                                mys = ss
                            elseif myThing[ss] ~= 0 then
                                if news == nil then
                                    if myflag == 0 then
                                        -- �޾Ʋ�����װ������ֵ��ȼ��仯
                                        if myThing["װ��λ��"] > -1 then
                                            local attr_gain = 0;
                                            if myThing[ss] > 0 then
                                                attr_gain = myThing[ss] * 10 + myThing[ss] *
                                                                (myThing["װ���ȼ�"] - 1) * 2
                                            elseif myThing[ss] < 0 then
                                                attr_gain = myThing[ss] * 10 - myThing[ss] *
                                                                (myThing["װ���ȼ�"] - 1) * 2
                                            end
                                            if attr_gain ~= 0 then
                                                mys = string.format(str .. ':%+d', attr_gain)
                                            end
                                        else
                                            mys = string.format(str .. ':%+d', myThing[ss])
                                        end
                                    elseif myflag == 1 then
                                        local id = thing[id]
                                        local wugong = JY.Thing[id]["�����书"];
                                        mys = string.format(str .. ':%d', myThing[ss])
                                    end
                                else
                                    if myThing[ss] < 0 then
                                        return
                                    end
                                    mys = string.format(str .. ':%s', news[myThing[ss]])
                                end
                                -- ������ɫ
                                if myThing[ss] == 1 and ss == "����������" then
                                    color = RGB(236, 200, 40)
                                elseif myThing[ss] == 2 and ss == "����������" then
                                    color = RGB(236, 236, 236)
                                end
                            elseif myThing[ss] == 0 and ss == "����������" then
                                mys = string.format(str .. ':%s', news[myThing[ss]])
                                color = RGB(208, 152, 208)
                            else
                                return
                            end

                            if mys ~= nil then
                                local mylen = myfont * string.len(mys) / 2 + 12
                                if CC.ScreenW - dx < mx + mylen then
                                    my = my + myfont + 10
                                    mx = dx + 4 * myfont
                                end
                                DrawString(mx + CC.MenuBorderPixel, my + CC.MenuBorderPixel + CC.ScreenH / 1.5, mys,  color, myfont)
                                mx = mx + mylen
                            end
                        end
                        -- �Ҳ���Ʒ˵�� 
                        local djwz = {"Ҽ��", "����", "����", "����", "�鼶", "½��"}
                        local WPlv = ""
                        local WPNA = "����: " .. myThing["����"]
                        local dj = myThing["װ���ȼ�"]
                        if dj > 0 then
                            --WPlv = "��    �ƣ�" .. myThing["����"] .. " " .. djwz[dj]
							WPlv = myThing["����"] .. " " .. djwz[dj]
                        else
                            --WPlv = "��    �ƣ�" .. myThing["����"]
							WPlv = myThing["����"]
                        end
                        local nswz = ""
                        local neshu = ""
                        local zbxb = ""
                        local zbxb1 = {'����', '����', '����'}
                        local wqlx = {'ȭ��', 'ָ��', '����', '����', '����'}
                        if JY.Thing[thing[id]]['װ��ϵ��'] > 0 and JY.Thing[thing[id]]['�����书'] == -1 then
                            zbxb = "�������" .. wqlx[JY.Thing[thing[id]]['װ��ϵ��']] .. '����'
                        elseif JY.Thing[thing[id]]['װ��λ��'] ~= nil and JY.Thing[thing[id]]['װ��λ��'] > 0 then
                            zbxb = "װ�����" .. zbxb1[JY.Thing[thing[id]]['װ��λ��']]
                        end
                        local kfname = ""
                        local kfh = 1
                        if myThing["�����书"] > 0 then
                            kfname = "�书��" .. JY.Wugong[myThing["�����书"]]["����"]
                            kfh = 2
							nswz = {'�ͼ�', '�н�', '�߽�','��ѧ'}
							neshu = "Ʒ�ף�" .. nswz[JY.Wugong[myThing["�����书"]]['�㼶']]
							zbxb = ''
							zbxb1 = {'����', '����', '����'}
							wqlx = {'ȭ��', 'ָ��', '����', '����', '����'}
                        end

                        -- lib.LoadPNG(2, thing[id] * 2,dx+CC.ScreenW/1.371, dy-CC.ScreenH/76.8, 1)
                        if myThing["�����书"] > 0 then
                            lib.LoadPNG(91, 554 * 2,  CC.ScreenW / 1.371, CC.ScreenH / 76.8, 1)
                        else
                            lib.LoadPNG(2, thing[id] * 2, CC.ScreenW / 1.351, CC.ScreenH / 50, 1)
                        end

                        DrawString(CC.ScreenW / 1.18, CC.ScreenH/30, WPlv, C_GOLD, size*1.2,CC.FONT5);
                        DrawString(dx + CC.ScreenW / 1.2436, dy + (kfh - 1) * size, kfname, C_GOLD, size);
                        kfh = kfh + 1
                        DrawString(dx + CC.ScreenW / 1.2436, dy + (kfh - 1) * size, neshu, C_GOLD, size);
                        kfh = kfh + 1
                        DrawString(dx + CC.ScreenW / 1.2436, dy + (kfh - 1) * size, zbxb, C_GOLD, size);

                        if myThing["�����书"] > 0 then
                            if JY.Wugong[myThing["�����书"]]["�书����"] < 6 then
                                Thing_info(thing[id], mjx, mjy, mjw, mjh, mjsize)
                            else
                                local txppd = 0
                                local ngtx = 0
                                local ZUIDHS1 = 4
                                local kf1 = myThing["�����书"]
                                for x = 1, 10 do
                                    if JY.Wugong[kf1]['��Ч' .. x] > 0 then
                                        txppd = 1
                                    end
                                end
                                -- if txppd > 0 then 
                                if kf1 == 264 then
                                    local smsize = CC.DefaultFont * 0.8
                                    local txppd = 0
                                    local ngtx = 0
                                    local hs = 0
                                    local ZUIDHS = 14
                                    local wgwl = '������' .. get_skill_power(0, kf1, 10)
                                    local wgqg = '������' .. get_skill_power(0, kf1, 10)
                                    -- local wgqf = '������'..get_skill_power(0, kf1, 10)
                                    if JY.Wugong[myThing["�����书"]]["�书����"] == 7 then
                                        wgwl = '���ܣ�' .. JY.Wugong[kf1]['������']
                                        wgqg = '���У�' .. JY.Wugong[kf1]['������']
                                    end
                                    DrawString(mjx, mjy - smsize / 1.5, '-----------------------', C_GOLD, size);
                                    h = tjm(mjx, mjy + smsize * (hs - WGSTARTH1), wgwl, color, size, 16, size,  WGSTARTH1 - hs, ZUIDHS + 1 - hs + WGSTARTH1)
                                    hs = hs + h
                                    h = tjm(mjx, mjy + smsize * (hs - WGSTARTH1), wgqg, color, size, 16, size,  WGSTARTH1 - hs, ZUIDHS + 1 - hs + WGSTARTH1)
                                    hs = hs + h
                                    for x = 1, 10 do
                                        ngtx = JY.Wugong[kf1]['��Ч' .. x]
                                        local ngtxwz = KF_ngwz(kf1, x)
                                        h = tjm(mjx, dy + CC.ScreenH / 7 + smsize * (hs - WGSTARTH1), ngtxwz, color, size * 0.8, 16, size * 0.8, WGSTARTH1 - hs, ZUIDHS + 1 - hs + WGSTARTH1)
                                        hs = hs + h
                                    end
                                else
                                    Thing_info(thing[id], mjx, mjy, mjw, mjh, mjsize)
                                end
                            end
                        else
                            Thing_info(thing[id], mjx, mjy, mjw, mjh, mjsize)
                        end
                        -- ����̩̹��ͬ�����϶�
                        if myThing["�����书"] > 0 then
                            DrawString(mx + CC.MenuBorderPixel, my + CC.MenuBorderPixel + CC.ScreenH / 1.5, kfname,  C_GOLD, myfont)
                            mx = mx + myfont * string.len(kfname) / 2 + 12
                        end

                        if myThing['����'] > 0 then
                            drawitem('������', '����')
                            drawitem('���������ֵ', '������ֵ')
                            drawitem('���ж��ⶾ', '�ж�')
                            drawitem('������', '����')
                            if myThing['�ı���������'] == 2 then
                                drawitem('�������Ա�Ϊ����')
                            end
                            drawitem('������', '����')
                            drawitem('���������ֵ', '������ֵ')
                            drawitem('�ӹ�����', '����')
                            drawitem('���Ṧ', '�Ṧ')
                            drawitem('�ӷ�����', '����')
                            drawitem('��ҽ������', 'ҽ��')
                            drawitem('���ö�����', '�ö�')
                            drawitem('�ӽⶾ����', '�ⶾ')
                            drawitem('�ӿ�������', '����')
                            drawitem('��ȭ�ƹ���', 'ȭ��')
                            drawitem('��ָ������', 'ָ��')
                            drawitem('����������', '����')
                            drawitem('��ˣ������', 'ˣ��')
                            drawitem('���������', '����')
                            drawitem('�Ӱ�������', '����')
                            drawitem('����ѧ��ʶ', '�䳣')
                            drawitem('��Ʒ��', 'Ʒ��')
                            drawitem('�ӹ�������', '����', { [0] = '��', '��' })
                            drawitem('�ӹ�������', '����')

                            if thing[id] == 14 then
                                drawitem('������������')
                            end

                            if thing[id] == 15 then
                                drawitem('���������������ֵ')
                            end
                            if thing[id] == 16 then
                                drawitem('���������������')
                            end
                            if thing[id] == 17 then
                                drawitem('���������������ֵ100��')
                            end
                            if thing[id] == 18 then
                                drawitem('���������������ֵ20��')
                            end
                            if thing[id] == 19 then
                                drawitem('�������������������ֵ30��')
                            end
                            if thing[id] == 20 then
                                drawitem('���������������ֵ50��')
                            end
                            if thing[id] == 316 then
                                drawitem('�ı�������������')
                            end
                            if thing[id] == 372 then
                                drawitem('������ӹ֮��')
                            end
                            -- ����װ�������ӳ�
                            for i, v in ipairs(CC.ExtraOffense) do
                                if v[1] == thing[id] then
                                    DrawString(mx + CC.MenuBorderPixel + CC.ScreenW / 68.4, my + CC.MenuBorderPixel + CC.ScreenH / 1.5, "����ǿ��:" .. JY.Wugong[v[2]]["����"] .. "+" .. v[3], PinkRed, myfont)
                                end
                            end

                            if mx ~= dx or my ~= y3_2 + 2 then
                                if thing[id] > 343 or thing[id] < 348 then -- ����ҩƷ����ʾ
                                    DrawString(dx + CC.MenuBorderPixel + CC.ScreenW / 68.4,  y3_2 + 2 + CC.MenuBorderPixel + CC.ScreenH / 1.5, " Ч��:", LimeGreen, myfont)
                                end

                            end
                        end

                        -- װ������ؼ���
                        if myThing['����'] == 1 or myThing['����'] == 2 then
                            if mx ~= dx then
                                mx = dx + 4 * myfont
                                my = my + myfont + 3
                            end
                            myflag = 1
                            local my2 = my
                            if myThing['����������'] > -1 then
                                drawitem('����:' .. JY.Person[myThing['����������']]['����'])
                            end
                            drawitem('����������', '����', { [0] = '��', '��', '����'  })
                            drawitem('������', '����')
                            drawitem('�蹥����', '����')
                            drawitem('���Ṧ', '�Ṧ')
                            drawitem('���ö�����', '�ö�')
                            drawitem('��ҽ������', 'ҽ��')
                            drawitem('��ȭ�ƹ���', 'ȭ��')
                            drawitem('��ָ������', 'ָ��')
                            drawitem('����������', '����')
                            drawitem('��ˣ������', 'ˣ��')
                            drawitem('���������', '����')
                            drawitem('�谵������', '����')
                            if thing[id] == 372 then
                                drawitem('��80>����>30')
                            end
                            -- ��ת����ʾ
                            if thing[id] == 118 then
                                local exstr = "��ϵ����ֵ֮��>=120 "
                                local mylen = myfont * string.len(exstr) / 2 + 12
                                DrawString(mx + CC.MenuBorderPixel + CC.ScreenW / 68.4, my + CC.MenuBorderPixel + CC.ScreenH / 1.5, exstr, C_GOLD, myfont)
                                mx = mx + mylen
                            end
                            -- ��������ʾ
                            if thing[id] == 176 then
                                local exstr = "����/ˣ��/������һ��>=70 "
                                local mylen = myfont * string.len(exstr) / 2 + 12
                                DrawString(mx + CC.MenuBorderPixel + CC.ScreenW / 68.4, my + CC.MenuBorderPixel + CC.ScreenH / 1.5, exstr, C_GOLD, myfont)
                                mx = mx + mylen
                            end
                            -- ��˿���׵���ʾ
                            if thing[id] == 239 then
                                local exstr = "ȭ�ƻ�ָ��>=70 "
                                local mylen = myfont * string.len(exstr) / 2 + 12
                                DrawString(mx + CC.MenuBorderPixel + CC.ScreenW / 68.4, my + CC.MenuBorderPixel + CC.ScreenH / 1.5, exstr, C_GOLD, myfont)
                                mx = mx + mylen
                            end
                            -- �߱�ָ������ʾ
                            if thing[id] == 200 then
                                local exstr = "ȭ�ƻ�ָ��>=200 "
                                local mylen = myfont * string.len(exstr) / 2 + 12
                                DrawString(mx + CC.MenuBorderPixel + CC.ScreenW / 68.4, my + CC.MenuBorderPixel + CC.ScreenH / 1.5, exstr, C_GOLD, myfont)
                                mx = mx + mylen
                            end
                            local wugong = JY.Thing[thing[id]]["�����书"]
                            if wugong >= 0 then
                                JY.Thing[thing[id]]["�辭��"] = JY.Wugong[wugong]["�㼶"] * 100
                            end
                            drawitem('������', '����')
                            drawitem('�辭��', '��������')
                            if mx ~= dx or my ~= my2 then
                                DrawString(dx + CC.MenuBorderPixel + CC.ScreenW / 68.4, my2 + CC.MenuBorderPixel + CC.ScreenH / 1.5, ' ����:', LimeGreen, myfont)
                            end
                        end
                        -- ��Ч˵��
                        if WPTX2[thing[id]] ~= nil then
                            if mx ~= dx then
                                mx = dx + 4 * myfont
                                my = my + myfont + 3
                            end
                            local my2 = my
                            if mx ~= dx or my ~= my2 then
                                DrawString(dx + CC.MenuBorderPixel + CC.ScreenW / 68.4, my2 + CC.MenuBorderPixel + CC.ScreenH / 1.5, ' Ч��:', C_RED, myfont)
                            end

                            DrawString(dx + CC.MenuBorderPixel + myfont * 3 + CC.ScreenW / 68.4, my2 + CC.MenuBorderPixel + CC.ScreenH / 1.5, WPTX2[thing[id]], M_DeepSkyBlue, myfont)
                        end
                        -- ��Ч˵��
                        if myThing['�Ƿ���Ч'] == 1 and
                            (WPTX[thing[id]][myThing['װ���ȼ�']] ~= nil or myThing['װ��λ��'] == -1) then
                            if mx ~= dx then
                                mx = dx + 4 * myfont
                                my = my + myfont + 3
                            end
                            local my2 = my
                            if mx ~= dx or my ~= my2 then
                                DrawString(dx + CC.MenuBorderPixel + CC.ScreenW / 68.4, my2 + CC.MenuBorderPixel + CC.ScreenH / 1.5, ' ��Ч:', C_RED, myfont)
                            end
                            if myThing['װ��λ��'] > -1 then
                                local TXstr = WPTX[thing[id]][myThing['װ���ȼ�']]
                                -- �����ָ���;ö�
                                if thing[id] == 303 then
                                    TXstr = TXstr .. "��ʣ��" .. JY.Person[651]["Ʒ��"] .. "�Σ�"
                                end
                                DrawString(dx + CC.MenuBorderPixel + myfont * 3 + CC.ScreenW / 68.4, my2 + CC.MenuBorderPixel + CC.ScreenH / 1.5, TXstr, M_DeepSkyBlue, myfont)
                            else
                                DrawString(dx + CC.MenuBorderPixel + myfont * 3 + CC.ScreenW / 68.4, my2 + CC.MenuBorderPixel + CC.ScreenH / 1.5, WPTX[thing[id]], M_DeepSkyBlue, myfont)
                            end
                        end
                    else
                        cur_thing = -1;
                    end
                else
                    boxcolor = C_BLACK;
                end

                local boxx = dx + CC.ThingGapOut + CC.ScreenW / 91.2 + x * (CC.ThingPicWidth + CC.ThingGapIn)
                local boxy = y3_1 + CC.ThingGapOut + y * (CC.ThingPicHeight + CC.ThingGapIn) - CC.ScreenH / 150

                if thing[id] ~= nil and thing[id] >= 0 then
                    local myThing = JY.Thing[thing[id]]
                    local lcwg = myThing["�����书"]
                    local lcwg = 0
                    lib.LoadPNG(91, 70 * 2, boxx, boxy, 1)
                    if myThing["�����书"] > 0 then
                        lib.LoadPNG(91, 545 * 2, boxx, boxy, 1)
                        lib.PicLoadCache(92, 45 * 2, boxx + CC.ScreenW / 200, boxy + CC.ScreenH / 50, 1, 100, nil, 80)
                        lib.PicLoadCache(92, (44 - JY.Wugong[myThing["�����书"]]['�㼶']) * 2, boxx + CC.ScreenW / 500, boxy + CC.ScreenH / 500, 1, 100, nil, 30)
                        lib.PicLoadCache(92, (46 + JY.Wugong[myThing["�����书"]]['�书����']) * 2, boxx + CC.ScreenW / 50, boxy + CC.ScreenH / 20, 1, 100, nil, 30)
                        lib.PicLoadCache(92, 44 * 2, boxx + CC.ScreenW / 22, boxy + CC.ScreenW / 80, 1, 100, nil, 40)
                        local wgname = JY.Thing[thing[id]]["����"]
                        local name1 = string.sub(wgname, 1, 2)
                        local name2 = string.sub(wgname, 3, 4)
                        local wzcl = C_WHITE
                        if JY.Thing[thing[id]]["����������"] == 0 then
                            wzcl = M_DeepSkyBlue
                        end
                        if JY.Thing[thing[id]]["����������"] == 1 then
                            wzcl = C_RED
                        end
                        if JY.Thing[thing[id]]["����������"] == 2 then
                            wzcl = C_WHITE
                        end
                        lib.DrawStr(boxx + CC.ScreenW / 20, boxy + CC.ScreenH / 30, name1, wzcl, CC.ThingFontSize, CONFIG.CurrentPath .. "FONT/2.ttf", 0, 0)
                        lib.DrawStr(boxx + CC.ScreenW / 20, boxy + CC.ScreenH / 30 + CC.ThingFontSize, name2, wzcl, CC.ThingFontSize, CONFIG.CurrentPath .. "FONT/2.ttf", 0, 0)

                    else
                        lib.LoadPNG(2, thing[id] * 2, boxx, boxy, 1)
                    end

                    local wpnum = 1
                    if thing[id] == 174 then
                        wpnum = CC.Gold
                    elseif thing[id] == 550 then
                        wpnum = CC.MJCZ
                    else
                        wpnum = thingnum[id]
                    end
                    if wpnum > 1 then
                        DrawString(boxx + CC.ScreenW / 273.6, boxy - CC.ScreenH / 384, wpnum, C_WHITE1, CC.ThingFontSize);
                    end
                end
                -- �޾Ʋ������޸�ѡ���
                if boxcolor == S_Yellow then
                    DrawSingleLine(boxx + 2, boxy + 1, boxx + CC.ThingPicWidth / 4, boxy + 1, boxcolor)
                    DrawSingleLine(boxx + 2 + CC.ThingPicWidth * 3 / 4, boxy + 1, boxx + CC.ThingPicWidth, boxy + 1,
                        boxcolor)
                    DrawSingleLine(boxx + 2, boxy + 1, boxx + 2, boxy + CC.ThingPicHeight / 4 - 1, boxcolor)
                    DrawSingleLine(boxx + CC.ThingPicWidth - 1, boxy + 2, boxx + CC.ThingPicWidth - 1,
                        boxy + CC.ThingPicHeight / 4 - 1, boxcolor)
                    DrawSingleLine(boxx + 2, boxy + 2 + CC.ThingPicHeight * 3 / 4, boxx + 2,
                        boxy + CC.ThingPicHeight - 1, boxcolor)
                    DrawSingleLine(boxx + CC.ThingPicWidth - 1, boxy + 2 + CC.ThingPicHeight * 3 / 4,
                        boxx + CC.ThingPicWidth - 1, boxy + CC.ThingPicHeight - 1, boxcolor)
                    DrawSingleLine(boxx + 1, boxy + CC.ThingPicHeight - 1, boxx + CC.ThingPicWidth / 4,
                        boxy + CC.ThingPicHeight - 1, boxcolor)
                    DrawSingleLine(boxx + 2 + CC.ThingPicWidth * 3 / 4, boxy + CC.ThingPicHeight - 1,
                        boxx + CC.ThingPicWidth - 1, boxy + CC.ThingPicHeight - 1, boxcolor)
                end
            end
        end

        DrawString(dx + CC.ScreenW / 1.9, y3_2 + 2 + CC.MenuBorderPixel + CC.ScreenH / 1.5, "����: " .. CC.MJCZ,  C_GOLD, CC.Fontsmall * 0.8)
        DrawString(dx + CC.ScreenW / 1.9, y3_2 + 2 + CC.MenuBorderPixel + CC.FontSmall * 1.2 + CC.ScreenH / 1.5,  "����: " .. CC.Gold, C_GOLD, CC.Fontsmall * 0.8)
        -- DrawString(bx*930,by*654+CC.FontSmall*2, "��F1�鿴��ϸ˵��", C_CYGOLD,CC.Fontsmall*0.8)
        if IsViewingKungfuScrolls > 0 then
            local list = {"1:ȫ��", "2:ȭ��", "3:ָ��", "4:����", "5:����", "6:����", "7:�ڹ�",
                          "8:�Ṧ", "9:��ѧ"}
            local space = 0
            local h = 0
            for i = 1, 9 do
                local color = C_GOLD
                if i == IsViewingKungfuScrolls then
                    color = C_RED
                end
                if i == 6 then
                    space = 0
                    h = 30
                end
                space = space + 81
                DrawString(space + CC.ScreenW / 3, by * 15 + h + by * 50, list[i], color, CC.Fontsmall * 0.9)
            end
        end

        ShowScreen();

        local keypress, ktype, mx, my = WaitKey(1)
        lib.Delay(CC.Frame);
        if keypress == VK_ESCAPE or ktype == 4 then
            cur_thing = -1;
            break
        elseif keypress == VK_RETURN or keypress == VK_SPACE then
            break
            -- ������Ʒ������˵��
        elseif keypress == VK_F1 and cur_thing ~= -1 then
            -- detailed_info(cur_thing)
            -- ����1 ȫ��
        elseif IsViewingKungfuScrolls > 0 and keypress == 49 then
            thing = original_thing
            thingnum = original_thingnum
            cur_line = 0
            cur_x = 0
            cur_y = 0
            cur_thing = -1
            IsViewingKungfuScrolls = 1
            -- ����2 ȭ��
        elseif IsViewingKungfuScrolls > 0 and keypress == 50 then
            local newThing = {}
            local newThingnum = {}
            for i = 0, CC.MyThingNum - 1 do
                newThing[i] = -1
                newThingnum[i] = 0
            end
            local c = -1
            for i = 0, #original_thing do
                if original_thing[i] == -1 then
                    break
                end
                local TSkill = JY.Thing[original_thing[i]]["�����书"]
                if TSkill > -1 and JY.Wugong[TSkill]["�书����"] == 1 then
                    c = c + 1
                    newThing[c] = original_thing[i]
                    newThingnum[c] = original_thingnum[i]
                end
            end
            thing = newThing
            thingnum = newThingnum
            cur_line = 0
            cur_x = 0
            cur_y = 0
            cur_thing = -1
            IsViewingKungfuScrolls = 2
            -- ����3 ָ��
        elseif IsViewingKungfuScrolls > 0 and keypress == 51 then
            local newThing = {}
            local newThingnum = {}
            for i = 0, CC.MyThingNum - 1 do
                newThing[i] = -1
                newThingnum[i] = 0
            end
            local c = -1
            for i = 0, #original_thing do
                if original_thing[i] == -1 then
                    break
                end
                local TSkill = JY.Thing[original_thing[i]]["�����书"]
                if TSkill > -1 and JY.Wugong[TSkill]["�书����"] == 2 then
                    c = c + 1
                    newThing[c] = original_thing[i]
                    newThingnum[c] = original_thingnum[i]
                end
            end
            thing = newThing
            thingnum = newThingnum
            cur_line = 0
            cur_x = 0
            cur_y = 0
            cur_thing = -1
            IsViewingKungfuScrolls = 3
            -- ����4 ����
        elseif IsViewingKungfuScrolls > 0 and keypress == 52 then
            local newThing = {}
            local newThingnum = {}
            for i = 0, CC.MyThingNum - 1 do
                newThing[i] = -1
                newThingnum[i] = 0
            end
            local c = -1
            for i = 0, #original_thing do
                if original_thing[i] == -1 then
                    break
                end
                local TSkill = JY.Thing[original_thing[i]]["�����书"]
                if TSkill > -1 and JY.Wugong[TSkill]["�书����"] == 3 then
                    c = c + 1
                    newThing[c] = original_thing[i]
                    newThingnum[c] = original_thingnum[i]
                end
            end
            thing = newThing
            thingnum = newThingnum
            cur_line = 0
            cur_x = 0
            cur_y = 0
            cur_thing = -1
            IsViewingKungfuScrolls = 4
            -- ����5 ����
        elseif IsViewingKungfuScrolls > 0 and keypress == 53 then
            local newThing = {}
            local newThingnum = {}
            for i = 0, CC.MyThingNum - 1 do
                newThing[i] = -1
                newThingnum[i] = 0
            end
            local c = -1
            for i = 0, #original_thing do
                if original_thing[i] == -1 then
                    break
                end
                local TSkill = JY.Thing[original_thing[i]]["�����书"]
                if TSkill > -1 and JY.Wugong[TSkill]["�书����"] == 4 then
                    c = c + 1
                    newThing[c] = original_thing[i]
                    newThingnum[c] = original_thingnum[i]
                end
            end
            thing = newThing
            thingnum = newThingnum
            cur_line = 0
            cur_x = 0
            cur_y = 0
            cur_thing = -1
            IsViewingKungfuScrolls = 5
            -- ����6 ����
        elseif IsViewingKungfuScrolls > 0 and keypress == 54 then
            local newThing = {}
            local newThingnum = {}
            for i = 0, CC.MyThingNum - 1 do
                newThing[i] = -1
                newThingnum[i] = 0
            end
            local c = -1
            for i = 0, #original_thing do
                if original_thing[i] == -1 then
                    break
                end
                local TSkill = JY.Thing[original_thing[i]]["�����书"]
                if TSkill > -1 and JY.Wugong[TSkill]["�书����"] == 5 then
                    c = c + 1
                    newThing[c] = original_thing[i]
                    newThingnum[c] = original_thingnum[i]
                end
            end
            thing = newThing
            thingnum = newThingnum
            cur_line = 0
            cur_x = 0
            cur_y = 0
            cur_thing = -1
            IsViewingKungfuScrolls = 6
            -- ����7 �ڹ�
        elseif IsViewingKungfuScrolls > 0 and keypress == 55 then
            local newThing = {}
            local newThingnum = {}
            for i = 0, CC.MyThingNum - 1 do
                newThing[i] = -1
                newThingnum[i] = 0
            end
            local c = -1
            for i = 0, #original_thing do
                if original_thing[i] == -1 then
                    break
                end
                local TSkill = JY.Thing[original_thing[i]]["�����书"]
                if TSkill > -1 and JY.Wugong[TSkill]["�书����"] == 6 then
                    c = c + 1
                    newThing[c] = original_thing[i]
                    newThingnum[c] = original_thingnum[i]
                end
            end
            thing = newThing
            thingnum = newThingnum
            cur_line = 0
            cur_x = 0
            cur_y = 0
            cur_thing = -1
            IsViewingKungfuScrolls = 7
            -- ����7 ����
        elseif IsViewingKungfuScrolls > 0 and keypress == 56 then
            local newThing = {}
            local newThingnum = {}
            for i = 0, CC.MyThingNum - 1 do
                newThing[i] = -1
                newThingnum[i] = 0
            end
            local c = -1
            for i = 0, #original_thing do
                if original_thing[i] == -1 then
                    break
                end
                local TSkill = JY.Thing[original_thing[i]]["�����书"]
                if TSkill > -1 and JY.Wugong[TSkill]["�书����"] == 7 then
                    c = c + 1
                    newThing[c] = original_thing[i]
                    newThingnum[c] = original_thingnum[i]
                end
            end
            thing = newThing
            thingnum = newThingnum
            cur_line = 0
            cur_x = 0
            cur_y = 0
            cur_thing = -1
            IsViewingKungfuScrolls = 8
            -- ����9 ��ѧ
        elseif IsViewingKungfuScrolls > 0 and keypress == 57 then
            local newThing = {}
            local newThingnum = {}
            for i = 0, CC.MyThingNum - 1 do
                newThing[i] = -1
                newThingnum[i] = 0
            end
            local c = -1
            for i = 0, #original_thing do
                if original_thing[i] == -1 then
                    break
                end
                local TSkill = JY.Thing[original_thing[i]]["�����书"]
                if TSkill == -1 then
                    c = c + 1
                    newThing[c] = original_thing[i]
                    newThingnum[c] = original_thingnum[i]
                end
            end
            thing = newThing
            thingnum = newThingnum
            cur_line = 0
            cur_x = 0
            cur_y = 0
            cur_thing = -1
            IsViewingKungfuScrolls = 9
        elseif keypress == VK_UP or ktype == 6 then
            if cur_y == 0 then
                if cur_line > 0 then
                    cur_line = cur_line - 1;
                end
            else
                cur_y = cur_y - 1;
            end
        elseif keypress == VK_DOWN or ktype == 7 then
            if cur_y == ynum - 1 then
                if cur_line < (math.modf(CC.MyThingNum / xnum) - ynum) then
                    cur_line = cur_line + 1;
                end
            else
                cur_y = cur_y + 1;
            end
        elseif keypress == VK_LEFT then
            if cur_x > 0 then
                cur_x = cur_x - 1;
            else
                cur_x = xnum - 1;
            end
        elseif keypress == VK_RIGHT then
            if cur_x == xnum - 1 then
                cur_x = 0;
            else
                cur_x = cur_x + 1;
            end
        elseif ktype == 2 or ktype == 3 then
            if mx > dx and my > dy and mx < CC.ScreenW - dx and my < CC.ScreenH - dy then
                cur_x = math.modf((mx - dx - CC.ThingGapOut / 2) / (CC.ThingPicWidth + CC.ThingGapIn))
                cur_y = math.modf((my - y3_1 - CC.ThingGapOut / 2) / (CC.ThingPicHeight + CC.ThingGapIn))

                if ktype == 3 then
                    break
                end
            end
        end
    end

    Cls();
    -- �޾Ʋ�����������ʾ����
    if IsViewingKungfuScrolls > 0 then
        IsViewingKungfuScrolls = 0
    end
    return cur_thing;
end

-- ��Ʒ����
function Menu_WPZL()
    local function swap(a, b)
        JY.Base["��Ʒ" .. a], JY.Base["��Ʒ" .. b] = JY.Base["��Ʒ" .. b], JY.Base["��Ʒ" .. a]
        JY.Base["��Ʒ����" .. a], JY.Base["��Ʒ����" .. b] = JY.Base["��Ʒ����" .. b],
            JY.Base["��Ʒ����" .. a]
    end

    local flag = 0;
    for i = 1, CC.MyThingNum do
        flag = 0;
        for j = 1, CC.MyThingNum - i + 1 do
            -- lib.Debug('JY.Base["��Ʒ"..j]'..JY.Base["��Ʒ"..j])
            -- lib.Debug('JY.Base["��Ʒ" .. j+1]'..JY.Base["��Ʒ" .. j+1])
            if JY.Base["��Ʒ" .. j] >= 0 and JY.Base["��Ʒ" .. j + 1] >= 0 then -- ���������Ʒ��Ч
                local wg1 = JY.Thing[JY.Base["��Ʒ" .. j]]["�����书"];
                local wg2 = JY.Thing[JY.Base["��Ʒ" .. j + 1]]["�����书"];
                if wg2 < 0 then -- ���������书�ĸ��ݱ������
                    if wg1 > 0 or (wg1 < 0 and JY.Base["��Ʒ" .. j] > JY.Base["��Ʒ" .. j + 1]) then
                        swap(j, j + 1);
                        flag = 1;
                    end
                elseif wg1 > 0 then -- �������书�ĸ��������������������ͬ���ٸ����书10����������                         
                    if JY.Wugong[wg1]["�书����"] > JY.Wugong[wg2]["�书����"] or
                        (JY.Wugong[wg1]["�书����"] == JY.Wugong[wg2]["�书����"] and JY.Wugong[wg1]["�㼶"] >
                            JY.Wugong[wg2]["�㼶"]) then
                        swap(j, j + 1);
                        flag = 1;
                    end
                end
            end
        end
        if flag == 0 then -- ���һ������û���κεĽ������϶������Ѿ��ź����ˣ�ֱ���˳�
            break
        end
    end
    Cls()
    -- DrawStrBoxWaitKey("�����������", C_WHITE, CC.DefaultFont)
end

-- ���̼�����Ʒ�˵�
function MenuDSJ()
    local menu = {'�������', '�书����', '�鵤��ҩ', '���˰���'}
    local r = LGMsgBox("ѡ��", " ��Ҫ����ʲô��Ʒ��", menu, #menu, 223)
    if r > 0 then
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
                if JY.Thing[id]["����"] == r then
                    thing[num] = id
                    thingnum[num] = JY.Base["��Ʒ����" .. i + 1]
                    num = num + 1
                end
                --[[
                if r == 1 then
                    thing[i] = id
                    thingnum[i] = JY.Base["��Ʒ����" .. i + 1]
                else
                    if JY.Thing[id]["����"] == r - 2 then
                        thing[num] = id
                        thingnum[num] = JY.Base["��Ʒ����" .. i + 1]
                        num = num + 1
                    end
                end
                ]]
            end
        end
        -- �޾Ʋ�����������ʾ����

        local r = SelectThing(thing, thingnum)
        if r >= 0 then
            return r
        end
    end
    return -1
end


-- ����ǿ����Ʒ�˵�
function MenuTJQH()
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
    local r = SelectThing(thing, thingnum)
    if r >= 0 then
        return r
    end
    return -1
end

-- ��Ӫ����
function Menu_HYZB()
    if JY.SubScene ~= 25 then
        JY.SubScene = 70
        JY.Base["��X1"] = 8
        JY.Base["��Y1"] = 28
        JY.Base["��X"] = 358
        JY.Base["��Y"] = 235
    end
end

-- �޾Ʋ������°�X�˵�
function Menu_Exit() -- �뿪�˵�
    lib.Debug('����δ֪����')
    local surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)

    lib.SetClip(0, 0, 0, 0)
    local bx = CC.WX
    local by = CC.HY
    local tb = 1
    local size = CC.DefaultFont
    local zb = {{468, 327}, {468, 387}, {468, 447}}
    local m = {"������Ϸ", "���س�ʼ", "�뿪��Ϸ"}

    while true do
        if JY.Restart == 1 then
            return
        end
        ClsN()
        lib.LoadPNG(91, 131 * 2, -1, -1, 1)
        for i = 1, #zb do
            local cl = M_SlateGray
            local s = m[i]
            if tb == i then
                cl = C_RED
            end
            DrawString(bx + 212 + bx * zb[i][1] - string.len(s) / 4 * size, by * 33 + by * zb[i][2] - size / 2, s, cl,
                size)
        end
        ShowScreen()
        lib.Delay(CC.Frame)
        local X, ktype, mx, my = lib.GetKey();
        if X == VK_ESCAPE or ktype == 4 then
            PlayWavE(77)
            break
        elseif X == VK_UP or X == VK_LEFT then
            PlayWavE(77)
            tb = tb - 1
            if tb < 1 then
                tb = #zb
            end
        elseif X == VK_DOWN or X == VK_RIGHT then
            PlayWavE(77)
            tb = tb + 1
            if tb > #zb then
                tb = 1
            end
        elseif X == VK_SPACE or X == VK_RETURN then
            PlayWavE(77)
            if tb == 3 then
                JY.Status = GAME_END;
                lib.FreeSur(surid)
                return 1;
            elseif tb == 2 then
                JY.Restart = 1
                JY.Status = GAME_START;
            end
            lib.LoadSur(surid, 0, 0)
            ShowScreen();
            lib.FreeSur(surid)
            return 0;
        else
            local mxx = false
            -- ���x�����м�λ���������ߵľ���
            local x_jl = bx * 47
            -- ���y�����м�λ���������ߵľ���
            local y_jl = by * 12
            local xs;
            local ys;
            local sb1;
            -- xh
            for i = 1, #zb do
                -- ���x�����м�λ��
                xs = bx * 212 + bx * zb[i][1]
                -- ���y�����м�λ��
                ys = by * 33 + by * zb[i][2]
                if mx >= xs - x_jl and mx <= xs + x_jl and my >= ys - y_jl and my <= ys + y_jl then
                    tb = i
                    mxx = true
                    break
                end
            end
            if mxx == true and ktype == 3 then
                PlayWavE(77)
                if tb == 3 then
                    JY.Status = GAME_END;
                    lib.FreeSur(surid)
                    return 1;
                elseif tb == 2 then
                    JY.Restart = 1
                    JY.Status = GAME_START;
                end
                lib.LoadSur(surid, 0, 0)
                ShowScreen();
                lib.FreeSur(surid)
                return 0;
            end
        end
    end
end

-- �뿪�˵�
function Menu_Exit2()
    Cls();
    if DrawStrBoxYesNo(-1, -1, "�Ƿ����Ҫ�뿪��Ϸ(Y/N)?", C_WHITE, CC.DefaultFont) == true then
        JY.Status = GAME_END;
        return 1;
    end
end

-- �������
function Menu_SaveRecord()
    Cls();
    CC.Save = 1
    local bx, by = CC.WX, CC.HY
    lib.LoadPNG(91, 131 * 2, -1, -1, 1)
    DrawStrBox(-1, CC.ScreenH * 1 / 6 - 20, "�������", LimeGreen, CC.Fontbig, C_GOLD);
    DrawStrBox(bx * 281, by * CC.ScreenH * 1 / 6 + 26,
        string.format("%-6s %-4s %-10s %-4s %-4s %-4s %-10s", "�浵��", "����", "����", "�Ѷ�", "����", "����", "λ��"), C_ORANGE, CC.DefaultFont, C_GOLD);
    local r = SaveList();
    if r > 0 then
        DrawString(CC.ScreenW/2, CC.ScreenH/2, "���Ժ�......", C_WHITE, CC.DefaultFont, CC.FONT2)
        ShowScreen();
        SaveRecord(r);
        Cls();
    end
    return 0;
end

-- ��ȡ����
function Menu_ReadRecord()
    CC.Save = 0
    Cls();
    local bx, by = CC.WX, CC.HY
    lib.LoadPNG(91, 131 * 2, -1, -1, 1)
    DrawStrBox(-1, CC.ScreenH * 1 / 6 - 20, "��ȡ����", LimeGreen, CC.Fontbig, C_GOLD);
    DrawStrBox(bx * 281, by * CC.ScreenH * 1 / 6 + 26,  string.format("%-6s %-4s %-10s %-4s %-4s %-4s %-10s", "�浵��", "����", "����", "�Ѷ�", "����", "����", "λ��"), C_ORANGE, CC.DefaultFont, C_GOLD);
    local r = SaveList();
    if r < 1 then
        return 0;
    end

    Cls();
    DrawString(CC.MainSubMenuX2, CC.MainSubMenuY, "���Ժ�......", C_WHITE, CC.DefaultFont, CC.FONT2)
    ShowScreen();
    local result = LoadRecord(r);
    if result ~= nil then
        return 0;
    end
    -- �ӳ���
    if JY.Base["����"] ~= -1 then
        if JY.SubScene < 0 then
            CleanMemory()
            -- lib.UnloadMMap()
        end
        -- lib.PicInit()
        lib.ShowSlow(20, 1)
        JY.Status = GAME_SMAP
        JY.SubScene = JY.Base["����"]
        JY.MmapMusic = -1
        JY.MyPic = GetMyPic()
        Init_SMap(1)
        -- ���ͼ
    else
        JY.SubScene = -1
        JY.Status = GAME_FIRSTMMAP
    end
    os.remove("yltxt.txt");
    os.remove("ylname.txt");
    io.open("yltxt.txt", "w")
    io.open("ylname.txt", "w")


    return 1;
end

-- ״̬�Ӳ˵�
function Menu_Status()
    -- �޾Ʋ�������״̬�¶�ӦX��

    local xcor = CC.MainSubMenuX + 2 * CC.MenuBorderPixel + 4 * CC.DefaultFont + 5
    if JY.Status == GAME_WMAP then
        xcor = CC.MainSubMenuX + 15
    end
    DrawStrBox(xcor, CC.MainSubMenuY, "Ҫ����˭��״̬", LimeGreen, CC.DefaultFont, C_GOLD);
    local nexty = CC.MainSubMenuY + CC.SingleLineHeight;

    local r = SelectTeamMenu(xcor, nexty);
    if r > 0 then
        ShowPersonStatus(r)
        return 1;
    else
        Cls(xcor, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH);
        return 0;
    end
end

-- ��Ӳ˵�
function Menu_PersonExit()
    DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "Ҫ��˭���", C_WHITE, CC.DefaultFont)
    local nexty = CC.MainSubMenuY + CC.SingleLineHeight
    local r = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if r == 1 then
        DrawStrBoxWaitKey("��Ǹ��û������Ϸ���в���ȥ", C_GOLD, CC.DefaultFont, nil, LimeGreen)
    else
        if JY.SubScene == 82 then
            do
                return
            end
        end
    end
    if r > 0 and JY.SubScene == 55 and JY.Base["����" .. r] == 35 then
        do
            return
        end
    end
    if r > 1 then
        local personid = JY.Base["����" .. r]
        if CC.PersonExit[personid] ~= nil then
            local v = CC.PersonExit[personid]
            CallCEvent(v)
        end
    end
    Cls()
    return 0
end

function Duiwumb()
    local bx = CC.WX
    local by = CC.HY
    local zuobiao = {10, 312}
    local tb = 1
    local lieshu = 9
    local pg = 0
    local jg = 20
    local liebiao = {}
    local cl = C_CYGOLD
    local size = CC.DefaultFont
    local id = -1
    local TB = 0
    while true do
        Cls()
        if JY.Restart == 1 then
            break
        end
        local i = 0
        lib.Background(0, CC.ScreenH / 2 - 50, CC.ScreenW, CC.ScreenH / 2 + 150, 98)

        for ii = 1, CC.TeamNum do
            if JY.Base['����' .. ii] >= 0 then
                liebiao[ii] = {JY.Person[JY.Base['����' .. ii]]['����'], JY.Base['����' .. ii]}
            end
        end
        if lieshu > #liebiao then
            lieshu = #liebiao
        end
        for ai = 1, lieshu do
            local tw = 0
            if CC.Png[JY.Person[liebiao[ai + pg][2]]['������']] ~= nil then
                tw = CC.Png[JY.Person[liebiao[ai + pg][2]]['������']]
            end
            local cl1 = C_CYGOLD
            local pc = 72
            local pc1 = 74
            local pc2 = 72
            if tb == ai then
                cl1 = C_RED
            end
            DrawString(bx * zuobiao[1] + bx * 62 - string.len(liebiao[ai + pg][1]) / 4 * size + (ai - 1) * bx * 152,
                by * zuobiao[2] + by * 150, liebiao[ai + pg][1], cl1, size)
            local headid = JY.Person[liebiao[ai + pg][2]]["������"]
            lib.PicLoadCache(92, 116 * 2, bx * zuobiao[1] + (ai - 1) * bx * 152, by * zuobiao[2], 1)
            lib.LoadPNG(1, headid * 2, bx * zuobiao[1] + (ai - 1) * bx * 152, by * zuobiao[2], 1)
            lib.PicLoadCache(92, 117 * 2, bx * zuobiao[1] + (ai - 1) * bx * 152, by * zuobiao[2], 1)
            if tb == ai then
                TB = ai + pg
                lib.LoadPNG(91, pc * 2, bx * zuobiao[1] + (ai - 1) * bx * 152, by * zuobiao[2], 1)
                pc = pc + 1
                if pc > pc1 then
                    pc = pc2
                end
            end
        end
        ShowScreen()
        lib.Delay(CC.Frame)
        local X, ktype, mx, my = lib.GetKey()
        if X == VK_ESCAPE or ktype == 4 then
            return pg
        elseif X == VK_SPACE or X == VK_RETURN then
            ShowPersonStatus(TB)
        elseif X == VK_RIGHT then
            tb = tb + 1
            if tb > lieshu then
                pg = pg + 1
                tb = lieshu
            end
            if tb + pg > #liebiao then
                tb = 1
                pg = 0
            end
        elseif X == VK_LEFT then
            if pg > 0 then
                if tb > 1 then
                    tb = tb - 1
                else
                    pg = pg - 1
                end
            else
                tb = tb - 1
                if tb < 1 then
                    tb = lieshu
                end
            end
        elseif X == VK_UP or ktype == 6 then
            pg = pg - lieshu
            tb = 1
            if pg < 0 then
                pg = 0
            end
        elseif X == VK_DOWN or ktype == 7 then
            pg = pg + lieshu
            if pg + lieshu > #liebiao then
                pg = #liebiao - lieshu
                tb = 1
            end
        else
            local mxx = false
            for j = 1, lieshu do
                if mx > bx * 10 + (j - 1) * bx * 152 and mx < bx * 152 + (j - 1) * bx * 152 and my > by * 300 and my <
                    by * 500 then
                    tb = j
                    mxx = true
                    break
                end
            end
            if mxx == true and ktype == 3 then
                ShowPersonStatus(TB)
            end
        end
    end
end

-- ����ѡ������˵�
function SelectTeamMenu(x, y)

    local menu = {};
    for i = 1, CC.TeamNum do
        menu[i] = {"", nil, 0};
        local id = JY.Base["����" .. i]
        if id >= 0 then
            if JY.Person[id]["����"] > 0 then
                menu[i][1] = JY.Person[id]["����"];
                menu[i][3] = 1;
            end
        end
    end
    return ShowMenu(menu, CC.TeamNum, 0, x, y, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE);
end

-- ���ɶ���ѡ������˵�
function TeamMenu_Mp(x, y, mp)
    local menu = {};
    for i = 1, CC.TeamNum do
        menu[i] = {"", nil, 0};
        local id = JY.Base["����" .. i]
        if id >= 0 then
            if JY.Person[id]['����'] == mp then
                if mp == 1 and id ~= 0 then
                    CC.TX['��ĦԺ'] = 1
                    CC.TX['������'] = 1
                end
                menu[i][1] = JY.Person[id]["����"];
                menu[i][3] = 1;
            end
        end
    end
    return ShowMenu(menu, CC.TeamNum, 0, x, y, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE);
end

-- ���㵱ǰ���Ѹ���
function GetTeamNum()
    local r = CC.TeamNum;
    for i = 1, CC.TeamNum do
        if JY.Base["����" .. i] < 0 then
            r = i - 1;
            break
        end
    end
    return r;
end

-- ̫��è����12����б��
function tjm12(x, y, x1, y1, color)
    if color == nil then
        color = M_Wheat
    end
    local xy = x - x1
    local yx = y - y1
    local ab = math.sqrt(xy ^ 2 + yx ^ 2) -- ����
    local xy1 = xy / ab
    local yx1 = yx / ab
    for i = 1, math.ceil(ab) do
        lib.DrawRect(x - xy1 * i, y - yx1 * i, x - xy1 * i, y - yx1 * i, color)
    end
end

-- �ɹ����ڹ�
function Neigong_attack()
    for j = 0, WAR.PersonNum - 1 do
        local id = WAR.Person[j]["������"]
        for i = 0, JY.WugongNum - 1 do
            local tmp = i
            if (match_ID(id, 36) or match_ID(id, 27) or match_ID(id, 189)) and tmp == 105 then
                return true
            elseif match_ID(id, 9759) and tmp == 102 then
                return true
            elseif match_ID(id, 9) and tmp == 106 then
                return true
            elseif (match_ID(id, 638) or match_ID(id, 9999)) and tmp == 106 then
                return true
            elseif match_ID(id, 37) and tmp == 94 then
                return true
            elseif (match_ID(id, 51) or match_ID(id, 679)) and tmp == 43 then
                return true
            elseif match_ID(id, 60) and tmp == 104 then
                return true
            elseif match_ID(id, 66) and tmp == 93 then
                return true
            end
        end
        break
    end
    return false
end

-- ����ְ��
function MP_zw(id)
    local n = nil
    local mmp = JY.Person[id]["����"]
    local m = JY.Person[id]["����ֽ�"] + 1
    -- ��������
    local zmxw = {205, 85, 236, 200, 93, 74, 335, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
    if inteam(id) == false then
        local mpcw = {"����", "����", "����", "����", "ִ��", "��Ӣ", "����"}

        if JY.Person[id]["���ɹ���"] == 5 then
            m = 1
        end
        if mmp == 2 then
            mpcw[1] = '����'
        end
        if mmp == 4 or mmp == 5 or mmp == 15 then
            mpcw[1] = "����"
        end
        if mmp == 8 then
            mpcw[1] = "����"
        end
        if mmp == 6 then
            mpcw[1] = "����"
        end
        if mmp == 22 then
            mpcw[1] = "����"
        end
        if mmp == 23 or mmp == 30 then
            mpcw[1] = "ׯ��"
        end
        if mmp == 24 then
            mpcw[1] = "����"
        end
        if mmp == 26 then
            mpcw[1] = "����"
        end
        if mmp > 0 then
            n = mpcw[m]
        else
            n = "ɢ��"
        end
    else
        local mpcw = {"����", "��Ӣ", "ִ��", "����", "����", "����", "����"}
        local zwnum = math.modf(JY.Person[id]['���ɹ���'] / 199)
        if JY.Person[id]['���ɹ���'] < 1 then
            zwnum = 0
        end
        if zwnum > 5 then
            zwnum = 5
        end
        if zwnum >= 5 then
            if JY.Person[id]['���ɹ���'] >= 1500 then
                if zmxw[mmp + 1] > 0 then
                    if instruct_18(zmxw[mmp + 1]) then
                        JY.Person[id]['����'] = mmp
                    end
                end
            else
            end
        end
        if JY.Person[id]['����'] == mmp then
            zwnum = 6
        end
        n = mpcw[zwnum + 1]

        if mmp == 0 then
            n = 'ɢ��'
        end
    end
    return n
end

-- ����
function Person_LV(id)
    local lv = nil
    local jj = {"��˵", "��ʦ", "����", "һ��", "����", "����"}
    if JY.Person[id]["����ֽ�"] > 6 then
        JY.Person[id]["����ֽ�"] = 6
    end
    local fjstr = jj[JY.Person[id]["����ֽ�"]]
    lv = jj[fjstr]
    return lv
end

-- �ؿ�
function MIKU(miji)
    local bx, by = CC.ScreenW / 1360, CC.ScreenH / 768
    local size = CC.DefaultFont * 0.9
    local WGSHUOMING = 1
    local kid = 1
    local id = 0
    local color = RGB(188, 189, 171)
    local tb, tb1, tb2, tb3, tb4, tb5 = 1, 1, 1, 1, 1, 1
    local zb5 = {{655 + 15, 564 + 4}, {752 + 15, 564 + 4}}
    local zsmenu = {}
    local zsnum, hg, sf, FY, WGFY, WGFY1 = 0, 40, 0, 0, 0, 0
    local STARTH1, WGSTARTH, WGSTARTH1 = 0, 0, 0
    local wzbx6, wzby6, wgzbx, wgzby = bx * 248, by * 162, bx * 80, by * 352
    local p2x = bx * 110
    local p2y = by * 115
    local n, m = 0, 0
    local FY1, h, h1, SHUOMING, xlsm = 0, 0, 0, 0, 0
    local function miji_info(mid)
        -- lib.Debug(thingID);
        local h1 = 0
        local me = {}
        local hs1 = 0
        local myh1 = 9
        local mm = 1
        local function strcolor_switch(s)
            local Color_Switch = {{"��", PinkRed}, {"��", M_Wheat}, {"��", C_BLACK}, {"��", RGB(178, 158, 124)},
                                  {"��", C_ORANGE}, {"��", LimeGreen}, {"��", M_DeepSkyBlue}, {"��", Violet}}
            for i = 1, 8 do
                if Color_Switch[i][1] == s then
                    return Color_Switch[i][2]
                end
            end
        end
        if Pmiji_info[mid] ~= nil then
            for i = 1, #Pmiji_info[mid] do
                me[#me + 1] = Pmiji_info[mid][i]
                if i == Pmiji_info[mid] then
                    me[#me + 1] = "��"
                end

            end
        else
            me[#me + 1] = ''
        end
        for i = mm, #me do
            local smsize = CC.DefaultFont * 0.6
            local tfstr = me[i]
            local color;
            color = strcolor_switch(string.sub(tfstr, 1, 2))
            tfstr = string.sub(tfstr, 3, -1)
            if string.sub(tfstr, 1, 2) == "��" then
                --	hs1 = hs1 + 1
            else
                h1 = tjm(wgzbx - size, by * 33 + by * 470 + smsize * (hs1 - WGSTARTH), tfstr, color, smsize, 24, smsize,WGSTARTH - hs1, myh1 + 1 - hs1 + WGSTARTH)
            end
            hs1 = hs1 + h1
        end
        if hs1 > myh1 then
            FY = limitX(hs1 - myh1 - 1, 0)
        else
            FY = 0
        end
    end
    while true do
        if JY.Restart == 1 then
            break
        end
        Cls()
        lib.LoadPNG(91, 24 * 2, CC.ScreenW / 2, CC.ScreenH / 2, 2)
        lib.LoadPNG(91, 274 * 2, CC.ScreenW / 2, CC.ScreenH / 2, 2)
        lib.LoadPNG(91, 311 * 2, CC.ScreenW / 2 + bx * 30, CC.ScreenH / 2, 2)
        local kname = JY.Teji[miji]['����']
        lib.LoadPNG(91, 281 * 2, CC.ScreenW / 2 + n * p2x, by * 360 + m * p2y, 2)
        lib.LoadPNG(98, (miji) * 2, CC.ScreenW / 2 + n * p2x, by * 360 + m * p2y, 2)
        DrawString(CC.ScreenW / 2 + n * p2x - string.len(kname) / 4 * size * 0.66, by * 395 + m * p2y, kname, C_WHITE,
            size * 0.68)
        lib.LoadPNG(91, 288 * 2, bx * 665 + n * p2x, by * 355 + m * p2y, 2, 0, 130)
        lib.LoadPNG(91, 287 * 2, -1, -1, 1)
        lib.DrawStr(CC.ScreenW / 10 - string.len(JY.Teji[miji]["����"]) / 4 * size, by * 353, JY.Teji[miji]["����"],
            M_Gray, size * 2, CONFIG.CurrentPath .. "FONT/2.TTF", 0, 0) -- �书������ʾ			
        lib.DrawStr(CC.ScreenW / 10 - string.len(JY.Teji[miji]["����"]) / 4 * size, by * 350, JY.Teji[miji]["����"],
            C_GOLD, size * 2, CONFIG.CurrentPath .. "FONT/2.TTF", 0, 0) -- �书������ʾ		
        miji_info(miji)
        ShowScreen()
        lib.Delay(CC.Frame)
        local X, ktype, mx, my = lib.GetKey();
        if X == VK_ESCAPE or ktype == 4 then
            break
        elseif X == VK_SPACE or X == VK_RETURN then
        elseif ktype == 6 then
            WGSTARTH = WGSTARTH - 1
            if WGSTARTH < 0 then
                WGSTARTH = 0
            end
        elseif ktype == 7 then
            WGSTARTH = WGSTARTH + 1
            if WGSTARTH > FY then
                WGSTARTH = FY
            end
        end
    end
end

-- ���
function WuKu(wugong)
    local bx, by = CC.ScreenW / 1360, CC.ScreenH / 768
    local size = CC.DefaultFont * 0.9
    local WGSHUOMING = 1
    local page = 2
    local kid = 1
    local id = 0
    local color = RGB(188, 189, 171)
    local tb, tb1, tb2, tb3, tb4, tb5 = 1, 1, 1, 1, 1, 1
    local zb5 = {{655 + 15, 564 + 4}, {752 + 15, 564 + 4}}
    local zsmenu = {}
    local zsnum, hg, sf, FY, WGFY, WGFY1 = 0, 40, 0, 0, 0, 0
    local STARTH1, WGSTARTH, WGSTARTH1 = 0, 0, 0
    local wzbx6, wzby6, wgzbx, wgzby = bx * 248, by * 162, bx * 80, by * 352
    local zszb = {{93, 443}, {137, 443}, {182, 443}, {226, 443}, {270, 443}, {314, 443}, {358, 443}, {402, 443},
                  {446, 443}, {490, 443}}
    local wz = {"�����ž�", "�����ž�", "����С��", "����С��", "����Ѿ�", "����Ѿ�",
                "�ڻ��ͨ", "�ڻ��ͨ", "¯����", "¯����", "�Ƿ��켫"}
    local djwz = {"һ", "��", "��", "��", "��", "��", "��", "��", "��", "ʮ", "��"}
    local pjwz = {"��" .. "�����书", "��" .. "�н��书", "��" .. "�߽��书", "��" .. "��ѧ�书"}
    local xj, yj, zsn = nil, 33, 28
    local FY1, h, h1, SHUOMING, xlsm = 0, 0, 0, 0, 0
    local function wugong_info(thingID)
        -- lib.Debug(thingID);
        local h1 = 0
        local me = {}
        local hs1 = 0
        local myh1 = 7
        local mm = 1
        if JY.Thing[thingID]["�����书"] > 0 then
            mm = 2
        end
        local function strcolor_switch(s)
            local Color_Switch = {{"��", PinkRed}, {"��", M_Wheat}, {"��", C_BLACK}, {"��", RGB(178, 158, 124)},
                                  {"��", C_ORANGE}, {"��", LimeGreen}, {"��", M_DeepSkyBlue}, {"��", Violet}}
            for i = 1, 8 do
                if Color_Switch[i][1] == s then
                    return Color_Switch[i][2]
                end
            end
        end
        if ItemInfo[thingID] ~= nil then
            for i = 1, #ItemInfo[thingID] do
                me[#me + 1] = ItemInfo[thingID][i]
                if i == ItemInfo[thingID] then
                    me[#me + 1] = "��"
                end

            end
        else
            me[#me + 1] = ""
        end
        for i = mm, #me do
            local smsize = CC.DefaultFont * 0.6
            local tfstr = me[i]
            local color;
            color = strcolor_switch(string.sub(tfstr, 1, 2))
            tfstr = string.sub(tfstr, 3, -1)
            if string.sub(tfstr, 1, 2) == "��" then
                --	hs1 = hs1 + 1
            else
                h1 = tjm(wgzbx - size + bx * 30, by * 33 + by * 470 + smsize * (hs1 - WGSTARTH), tfstr, color, smsize,
                    24, smsize, WGSTARTH - hs1, myh1 + 1 - hs1 + WGSTARTH)
            end
            hs1 = hs1 + h1
        end
        if hs1 > myh1 then
            FY = limitX(hs1 - myh1 - 1, 0)
        else
            FY = 0
        end
    end
    while true do
        if JY.Restart == 1 then
            -- break
        end
        -- Cls()	
        if page == 2 then
            lib.LoadPNG(91, 24 * 2, CC.ScreenW / 2, CC.ScreenH / 2, 2)
            lib.LoadPNG(91, 274 * 2, CC.ScreenW / 2, CC.ScreenH / 2, 2)
            lib.LoadPNG(91, (277 + page) * 2, CC.ScreenW / 2 + bx * 30, CC.ScreenH / 2, 2)
            local thingid = 0
            local n, m = 0, 0
            -- 925 684
            local jtzbx, jtzby = 925, 684
            local k = wugong
            local kname = JY.Wugong[k]['����']
            lib.LoadPNG(91, 281 * 2, bx * 675 + n * bx * 110 + bx * 30, by * 360 + m * bx * 115, 2)
            lib.LoadPNG(98, (500 + k) * 2, bx * 675 + n * bx * 110 + bx * 30, by * 360 + m * bx * 115, 2)
            DrawString(bx * 675 + bx * 30 + n * bx * 110 - string.len(kname) / 4 * size * 0.66, by * 395 + m * bx * 115,
                kname, C_WHITE, size * 0.68)
            -- �书˵��
            for j = 0, JY.ThingNum - 1 do -- ��ȡ��Ʒ
                if JY.Thing[j]["�����书"] >= 0 and JY.Thing[j]["�����书"] == wugong then
                    thingid = j
                end
            end
            local wgmenu = {}
            local name = JY.Wugong[wugong]["����"]
            wgmenu = {wugong, name, get_skill_power(id, wugong, 10), 10, 1, thingid} -- ��ţ����ƣ��������ȼ�,λ��,�ؼ�
            -- say(kid,0,0)                    
            -- ˵��
            if WGSHUOMING > 0 then
                local cl = color
                local menu1 = wgmenu
                local kf1 = wugong
                local me = JY.Wugong[kf1]["����"]
                local wgmp = MPname[JY.Wugong[kf1]["����"] + 1]
                local level = 10
                local wugongwl = get_skill_power(id, kf1, level)
                local mz = JY.Wugong[kf1]["������"]
                local wz2 = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"}
                if kf1 > 0 then
                    cl = C_RED
                    local jg1 = size * 0.9
                    local wgbj = 0
                    if JY.Wugong[kf1]["�书����"] < 6 then
                        wgbj = 286
                    else
                        wgbj = 287
                    end
                    if WGSHUOMING == 2 then
                        wgbj = 287
                    end
                    local wgcl = cl
                    if JY.Wugong[kf1]["�㼶"] == 1 then
                        wgcl = M_LightBlue
                    end
                    if JY.Wugong[kf1]["�㼶"] == 2 then
                        wgcl = M_Purple
                    end
                    if JY.Wugong[kf1]["�㼶"] == 3 then
                        wgcl = Color_Hurt1
                    end
                    if JY.Wugong[kf1]["�㼶"] == 3 then
                        wgcl = C_RED
                    end
                    local wlwz, mzwz = nil, nil
                    local p = JY.Person[0]
                    lib.LoadPNG(91, wgbj * 2, 0 + bx * 30, 0, 1, 0, 100)
                    lib.DrawStr(bx * 363 + bx * 30 - string.len(JY.Wugong[kf1]["����"]) / 4 * size, by * 353,
                        JY.Wugong[kf1]["����"], M_Gray, size * 2, CONFIG.CurrentPath .. "FONT/2.TTF", 0, 0) -- �书������ʾ			
                    lib.DrawStr(bx * 361 + bx * 30 - string.len(JY.Wugong[kf1]["����"]) / 4 * size, by * 350,
                        JY.Wugong[kf1]["����"], wgcl, size * 2, CONFIG.CurrentPath .. "FONT/2.TTF", 0, 0) -- �书������ʾ		
                    DrawString(wgzbx + bx * 30 - size * 1.5, wgzby - size * 1, wz2[menu1[5]], color, size * 0.9) -- �书���	
                    tjm(wgzbx + bx * 30, wgzby, "Ʒ��" .. ":" .. pjwz[JY.Wugong[kf1]["�㼶"]], color, size * 0.73,11, size * 0.8) -- Ʒ��
                    local wglx = {'�� ȭ', '�� ָ', '�� ��', '�� ��', '�� ��', '�� ��', '�� ��'}
                    DrawString(wgzbx + bx * 30, wgzby + jg1,
                        "����" .. ":  " .. wgmp .. ' ' .. wglx[JY.Wugong[kf1]['�书����']], color, size * 0.73) -- ����
                    DrawString(wgzbx + bx * 30, wgzby + jg1 * 2,
                        "��Ϊ" .. ":  " .. wz[level] .. " " .. "(" .. djwz[level] .. ")", color, size * 0.73) -- ��Ϊ
                    local gdz = JY.Wugong[kf1]["�㼶"] * level
                    local sm = math.modf(JY.Wugong[p["�����ڹ�"]]["�㼶"] * 100 + p["����"] * (wugongwl / 8))

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
                    if JY.Wugong[kf1]["�书����"] < 6 then
                        wlwz = "����" .. " " .. math.modf(wugongwl)
                        mzwz = "   ����" .. " " .. mz .. " " .. "      ��" .. " " .. gdz
                    elseif JY.Wugong[kf1]["�书����"] == 6 then
                        wlwz = "���� " .. sm .. "   ���� " .. math.modf(wugongwl)
                        mzwz = "           �� " .. gdz .. " " .. "     ���� " .. hq
                    else
                        wlwz = "���� " .. JY.Wugong[kf1]["������"] .. "    ���� " .. JY.Wugong[kf1]["������"]
                        mzwz = "           �ƶ� " .. " " .. " " .. "      ���� " .. ""
                    end
                    DrawString(wgzbx + bx * 30, wgzby + jg1 * 3.1 + by * 2, wlwz, C_WHITE, size * 0.73) -- ����
                    DrawString(wgzbx + bx * 30 + size * 5, wgzby + jg1 * 3.1 + by * 2, mzwz, C_WHITE, size * 0.73) -- ����											
                    -- �书��ʽ
                    if WGSHUOMING == 1 then
                        if JY.Wugong[kf1]["�书����"] < 6 then
                            for j = 1, #CC.KFMove[menu1[1]] do
                                local leixing = {91, 92, 93, 94, 95, 96}
                                local lxpic = leixing[JY.Wugong[kf1]["�书����"]]
                                local zsnum = CC.WUGONGZS[menu1[5]][j]
                                lib.LoadPNG(98, (500 + kf1) * 2, bx * zszb[j][1] + bx * 30, by * zszb[j][2] + by * 88,
                                    2, 0, 90)
                                local zssm = {}
                                local CAOZSM = {}
                                zsn = #CC.KFMove[kf1]
                                local function Atk(id)
                                    local gj = 0
                                    gj = gj + JY.Person[id]['������']
                                    -- lib.Debug('���﹥����'..gj)	
                                    local nlgj =
                                        limitX((JY.Person[id]['����'] - JY.Person[id]['����'] * 10) / 60, 0)
                                    -- lib.Debug('�����ӳɹ�����'..nlgj)	
                                    gj = gj + nlgj
                                    gj = gj + FJGONGJ(id)
                                    -- lib.Debug('װ���ӳɹ�����'..FJGONGJ(id))	
                                    return gj
                                end
                                local atk = Atk(id)
                                local zzz = tb4
                                if zzz > 6 then
                                    zzz = 6
                                end
                                local nnn = wugongwl * (1 + (zzz - 1) / 10)
                                local sz = math.ceil(atk * (1 + nnn / 2000))
                                local sznum = {"һ", "��", "��", "��", "��", "��", "��", "��", "��", "ʮ"}
                                local wz1 = "��ɻ����˺�" .. '��' .. sz .. "��" .. "�㡣"
                                local zsname = CC.KFMove[kf1][j][1]
                                local zswz = nil
                                local zswz1 = nil
                                if tb4 == j then
                                    lib.LoadPNG(91, 88 * 2, bx * zszb[j][1] - bx * 2 + bx * 30,
                                        zszb[j][2] - by * 2 + by * 88, 2, 0, 95)
                                    tjm(wgzbx - size + bx * 30, wgzby + size * 7, "��" .. JY.Wugong[kf1]["����"] ..
                                        "�ȵڣ�" .. sznum[tb4] .. "����:��" .. zsname, C_CYGOLD, size * 0.73, 30,
                                        size * 0.73)
                                    tjm(wgzbx + size * 8 + bx * 30, wgzby + size * 7,
                                        "��    ���� ��" .. CC.KFMove[kf1][j][3], C_CYGOLD, size * 0.73, 30,
                                        size * 0.73)
                                    local hs = 0
                                    local ZUIDHS = 4
                                    if JY.Wugong[kf1]["�书����"] == 1 then
                                        zswz1 = "���Ŀ�����ˣ�" .. (JY.Wugong[kf1]["�㼶"] * 5) .. "�ȵ㡣"
                                    elseif JY.Wugong[kf1]["�书����"] == 2 then
                                        zswz1 = "��Ŀ���Ѩ��" .. JY.Wugong[kf1]["�㼶"] .. "~" ..
                                                    (JY.Wugong[kf1]["�㼶"] * 2 + 2) .. "�ȵ㡣"
                                    elseif JY.Wugong[kf1]["�书����"] == 3 then
                                        zswz1 = "���Ŀ����Ѫ��" .. (JY.Wugong[kf1]["�㼶"] * 10) ..
                                                    "�ȵ㡣"
                                    elseif JY.Wugong[kf1]["�书����"] == 4 then
                                        zswz1 = "���Ŀ�����ˣ�" .. (JY.Wugong[kf1]["�㼶"] * 10) ..
                                                    "�ȵ㡣"
                                    elseif JY.Wugong[kf1]["�书����"] == 5 then
                                        zswz1 = "���Ŀ�����ˣ�" .. (JY.Wugong[kf1]["�㼶"] * 5) ..
                                                    "�ȵ�/��Ŀ���Ѩ��" .. JY.Wugong[kf1]["�㼶"] .. "~" ..
                                                    (JY.Wugong[kf1]["�㼶"] * 2 + 2) .. "�ȵ�/���Ŀ����Ѫ��" ..
                                                    (JY.Wugong[kf1]["�㼶"] * 10) .. "�ȵ�/���Ŀ�����գ�" ..
                                                    (JY.Wugong[kf1]["�㼶"] * 10) .. "�ȵ㡣"
                                    end
                                    if JY.Wugong[kf1]["����ϵ��"] == 1 then
                                        zswz1 = zswz1 .. "���ʱ��⡣"
                                    end
                                    if JY.Wugong[kf1]["����ϵ��"] == 1 then
                                        zswz1 = zswz1 .. "�������ա�"
                                    end
                                    if JY.Wugong[kf1]["�����ж�����"] > 0 then
                                        zswz1 = zswz1 .. "��Ŀ������ж���" ..
                                                    JY.Wugong[kf1]["�����ж�����"] .. "�ȡ�"
                                    end
                                    if JY.Wugong[kf1]["��ʽ" .. tb4] > 0 then
                                        -- 1��Ѫ
                                        if JY.Wugong[kf1]["��ʽ" .. tb4] > 10 and JY.Wugong[kf1]["��ʽ" .. tb4] < 15 then
                                            zswz1 = zswz1 .. "�������Ŀ����Ѫ��" ..
                                                        (JY.Wugong[kf1]["�㼶"] * 10) .. "�ȵ㡣"
                                            -- 2��Ѩ
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 20 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            25 then
                                            zswz1 =
                                                zswz1 .. "�������Ŀ���Ѩ��" .. JY.Wugong[kf1]["�㼶"] ..
                                                    "~" .. (JY.Wugong[kf1]["�㼶"] * 2 + 1) .. "�ȵ㡣"
                                            -- 3����	
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 30 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            35 then
                                            zswz1 =
                                                zswz1 .. "���Ŀ�����գ�" .. (JY.Wugong[kf1]["�㼶"] * 5) ..
                                                    "�ȵ㡣"
                                            -- 4����		
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 40 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            45 then
                                            zswz1 =
                                                zswz1 .. "���Ŀ������" .. (JY.Wugong[kf1]["�㼶"] * 10) ..
                                                    "�ȵ㡣"
                                            -- 5����		
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 50 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            55 then
                                            zswz1 =
                                                zswz1 .. "���Ŀ�����ˣ�" .. (JY.Wugong[kf1]["�㼶"] * 10) ..
                                                    "�ȵ㡣"
                                            -- 6�ж�	
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 60 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            65 then
                                            zswz1 =
                                                zswz1 .. "���Ŀ���ж���" .. (JY.Wugong[kf1]["�㼶"] * 10) ..
                                                    "�ȵ㡣"
                                            -- 7����
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 70 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            75 then
                                            zswz1 =
                                                zswz1 .. "���Ŀ�궳���" .. (JY.Wugong[kf1]["�㼶"] * 5) ..
                                                    "��ʱ��"
                                            -- 8��ȼ
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 80 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            85 then
                                            zswz1 = zswz1 .. "���Ŀ���ȼ��" ..
                                                        (JY.Wugong[kf1]["�㼶"] * 2 + 3) .. "��ʱ��"
                                            -- 9�޶�
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 90 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            95 then
                                            zswz1 = zswz1 .. "���Ŀ��޶���" .. JY.Wugong[kf1]["�㼶"] ..
                                                        "�Ȼغ�,���Է���Ч��˫����"
                                            -- 10ѣ��
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 100 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            105 then
                                            local jl = JY.Wugong[kf1]["�㼶"] * 5
                                            zswz1 = zswz1 .. "��" .. jl .. "%�����Ŀ��ѣ��1�غϡ�"
                                            -- 11˺��		
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 110 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            115 then
                                            local jl = JY.Wugong[kf1]["��ʽ" .. tb4] * 10
                                            zswz1 = zswz1 .. "��" .. jl .. "%�����Ŀ��˺��10ʱ��"
                                            -- 12����									
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 120 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            125 then
                                            zswz1 = zswz1 .. "���Ŀ������1�غϣ������˺���������" ..
                                                        (JY.Wugong[kf1]["�㼶"] * 10 + 10) .. "%�ȡ�"
                                            -- 13�Ʒ�								
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 130 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            135 then
                                            zswz1 =
                                                zswz1 .. "����Ŀ�������" .. (JY.Wugong[kf1]["�㼶"] * 10) ..
                                                    "%�ȡ�"
                                            -- 14����ϵ��								
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 140 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            145 then
                                            local xswz = {"ȭ��ϵ��", "ָ��ϵ��", "����ϵ��",
                                                          "ˣ��ϵ��", "����ϵ��"}
                                            zswz1 =
                                                zswz1 .. "����Ŀ���" .. xswz[JY.Wugong[kf1]["�书����"]] ..
                                                    (JY.Wugong[kf1]["�㼶"] * 10) .. "%�ȡ�"
                                            -- 15�̶��˺�								
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 150 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            155 then
                                            zswz1 =
                                                zswz1 .. "���Ӷ����˺���" .. (JY.Wugong[kf1]["�㼶"] * 50) ..
                                                    "�ȵ㡣"
                                            -- 16��Ѫ
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 160 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            165 then
                                            zswz1 = zswz1 .. "�����˺�20%��Ѫ���ޣ�" ..
                                                        (JY.Wugong[kf1]["�㼶"] * 50) .. "�ȵ㡣"
                                            -- 17����
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 170 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            175 then
                                            zswz1 = zswz1 .. "���غ��ڼ���Ŀ�������" ..
                                                        (JY.Wugong[kf1]["�㼶"] * 5) .. "%�ȡ�"
                                            -- 18����
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 180 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            185 then
                                            zswz1 = zswz1 .. "���غ��ڼ���Ŀ�깥����" ..
                                                        (JY.Wugong[kf1]["�㼶"] * 5) .. "%�ȡ�"
                                            -- 19������
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 190 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            195 then
                                            zswz1 = zswz1 .. "��" .. (JY.Wugong[kf1]["�㼶"] * 10) ..
                                                        "%�ȸ�������������"
                                            -- 20���ӷ�Χ
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 200 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            205 then
                                            zswz1 = zswz1 .. "��" .. (JY.Wugong[kf1]["�㼶"] * 10) ..
                                                        "%����ɴ�Χ�˺���"
                                            -- 21�ٴ��ж�
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 210 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            215 then
                                            zswz1 = zswz1 .. "��" .. (JY.Wugong[kf1]["�㼶"] * 4) ..
                                                        "%�ȸ����ٴ��ж���"
                                            -- 22����
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 220 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            225 then
                                            zswz1 = zswz1 .. "�»غϼ������٣�" ..
                                                        (JY.Wugong[kf1]["�㼶"] * 10) .. "%�ȡ�"
                                            -- 23������
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 230 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            235 then
                                            zswz1 = zswz1 .. "��" .. (JY.Wugong[kf1]["�㼶"] * 10) ..
                                                        "%�ȸ�����������1�Ρ�"
                                            -- 24�ӱ���
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 240 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            245 then
                                            zswz1 = zswz1 .. "��" .. (JY.Wugong[kf1]["�㼶"] * 20 + 20) ..
                                                        "%�ȱ�����"
                                            -- 25�ӱ���
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 250 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            255 then
                                            zswz1 =
                                                zswz1 .. "���ӱ����˺���" .. (JY.Wugong[kf1]["�㼶"] * 10) ..
                                                    "%�ȡ�"
                                            -- 26����
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 260 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            265 then
                                            zswz1 = zswz1 .. "��" .. (JY.Wugong[kf1]["�㼶"] * 20 + 20) ..
                                                        "%�ȸ��ʱ��С�"
                                            -- 27����
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 270 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            275 then
                                            zswz1 = zswz1 .. "��" .. (JY.Wugong[kf1]["�㼶"] * 20 + 20) ..
                                                        "%���»غϷ�����"
                                            -- 28����
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 280 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            285 then
                                            if JY.Wugong[kf1]["�㼶"] == 1 then
                                                zswz1 = zswz1 .. "������" .. (JY.Wugong[kf1]["�㼶"] * 1) ..
                                                            "�ȵ㡣"
                                            else
                                                local hq = JY.Wugong[kf1]["�㼶"] - 1
                                                local hq1 = JY.Wugong[kf1]["�㼶"]
                                                zswz1 = zswz1 .. "������" .. hq .. "~" .. hq1 .. "�ȵ㡣"
                                            end
                                            -- 29����
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 290 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            295 then
                                            zswz1 = zswz1 .. "��" .. (JY.Wugong[kf1]["�㼶"] * 15) ..
                                                        "%������1�غϡ�"
                                            -- 30����
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 300 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            305 then
                                            zswz1 = zswz1 .. "��" .. (JY.Wugong[kf1]["�㼶"] * 10) .. "%�ȷ�����"
                                            -- 31�Ӹ�
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 310 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            315 then
                                            zswz1 = zswz1 .. "���Ӹ񵵣�" .. (JY.Wugong[kf1]["�㼶"] * 100) ..
                                                        "�ȵ㡣"
                                            -- 32������
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 320 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            325 then
                                            zswz1 = zswz1 .. "�������ӣ�" .. (JY.Wugong[kf1]["�㼶"] * 100) ..
                                                        "�ȵ㡣"
                                            -- 33ɢ��
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 330 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            335 then
                                            zswz1 = zswz1 .. "ɢ����" .. (JY.Wugong[kf1]["�㼶"] * 5) ..
                                                        "��ʱ��"
                                            -- 34����
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 340 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            345 then
                                            zswz1 = zswz1 .. "�������غϣ�Ŀ����Χ���ͣ�" ..
                                                        (5 + JY.Wugong[kf1]["�㼶"] * 5) .. "%�ȡ�"
                                            -- 35��������
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 350 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            355 then
                                            zswz1 = zswz1 .. "�������ң�" .. (JY.Wugong[kf1]["�㼶"] * 5) ..
                                                        "��ʱ��"
                                            -- 36�־�
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 360 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            365 then
                                            zswz1 = zswz1 .. "��" .. (30 + JY.Wugong[kf1]["�㼶"] * 10) ..
                                                        "%�ȸ��ʿ־�1�غϡ�"
                                            -- 37�������ֵ�˺�
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 370 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            375 then
                                            zswz1 = zswz1 .. "���Ŀ���������ֵ��" ..
                                                        (1 + JY.Wugong[kf1]["�㼶"]) .. "%���˺���"
                                            -- 38äĿ
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 380 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            385 then
                                            zswz1 = zswz1 .. "��" .. (JY.Wugong[kf1]["�㼶"] * 10) ..
                                                        "%�ȸ�����ä��"
                                            -- 39�ٻ�
                                        elseif JY.Wugong[kf1]["��ʽ" .. tb4] > 390 and JY.Wugong[kf1]["��ʽ" .. tb4] <
                                            395 then
                                            zswz1 =
                                                zswz1 .. "Ŀ�꼯�����٣�" .. (JY.Wugong[kf1]["�㼶"] * 3) ..
                                                    "�ȵ㡣"
                                        end
                                        zswz1 = wz1 .. "" .. zswz1
                                        h = tjm(wgzbx - size + bx * 30, wgzby + size * 8 + size * (hs - WGSTARTH1),
                                            zswz1, color, size * 0.73, 20, size * 0.73, WGSTARTH1 - hs,
                                            ZUIDHS + 1 - hs + WGSTARTH1)
                                    else
                                        zswz1 = wz1 .. "" .. zswz1
                                        h = tjm(wgzbx - size + bx * 30, wgzby + size * 8 + size * (hs - WGSTARTH1),
                                            zswz1, color, size * 0.73, 20, size * 0.73, WGSTARTH1 - hs,
                                            ZUIDHS + 1 - hs + WGSTARTH1)
                                    end
                                    hs = hs + h
                                    if hs > ZUIDHS then
                                        WGFY1 = limitX(hs - ZUIDHS - 1, 0)
                                    else
                                        WGFY1 = 0
                                    end
                                end
                            end
                            if WGSHUOMING == 2 then
                                -- ��ȡ�书˵����� չʾ�书˵��	
                                wugong_info(menu1[6])
                            end
                        else
                            local txppd = 0
                            local ngtx = 0
                            local hs = 0
                            local ZUIDHS = 4
                            for x = 1, 10 do
                                if JY.Wugong[kf1]['��Ч' .. x] > 0 then
                                    txppd = 1
                                end
                            end
                            if txppd > 0 then
                                for x = 1, 10 do
                                    ngtx = JY.Wugong[kf1]['��Ч' .. x]
                                    local ngtxwz = KF_ngwz(kf1, x)
                                    -- if 
                                    h = tjm(wgzbx - size + bx * 25, wgzby + size * 5.2 + size * (hs - WGSTARTH1),
                                        ngtxwz, color, size * 0.65, 20, size * 0.65, WGSTARTH1 - hs,
                                        ZUIDHS + 1 - hs + WGSTARTH1)
                                    hs = hs + h
                                end
                            else
                                wugong_info(menu1[6])
                            end
                        end
                    end
                    if WGSHUOMING == 2 then
                        -- lib.LoadPNG(91,287*2,-1,-1,1,0,100)
                        wugong_info(menu1[6])
                    end
                    if JY.Thing[menu1[6]]["��Ʒ˵��"] ~= nil then
                        DrawString(wgzbx + bx * 30, wgzby + size * 4, JY.Thing[menu1[6]]["��Ʒ˵��"], C_WHITE,
                            size * 0.73)
                    else
                        DrawString(wgzbx + bx * 30, wgzby + size * 4, "�����е�������ѧ", color, size * 0.73)
                    end
                    local r = 0
                    if level <= 9 then
                        r = math.modf((5 - math.modf(25 / 25)) * JY.Thing[menu1[6]]["�辭��"] * (level + 1) * 0.05);
                    else
                        r = math.huge;
                    end
                    if level >= 10 then
                        r = "�D�D"
                    end
                end
            end
        end
        ShowScreen()
        lib.Delay(CC.Frame)
        local X, ktype, mx, my = lib.GetKey();
        if X == VK_ESCAPE or ktype == 4 then
            break
        elseif X == VK_SPACE or X == VK_RETURN then
        elseif ktype == 6 then
            if page == 2 then
                if WGSHUOMING > 0 then
                    WGSTARTH = WGSTARTH - 1
                    if WGSTARTH < 0 then
                        WGSTARTH = 0
                    end
                end
            end
        elseif ktype == 7 then
            if page == 2 then
                if WGSHUOMING > 0 then
                    WGSTARTH = WGSTARTH + 1
                    if WGSTARTH > FY then
                        WGSTARTH = FY
                    end
                end
            end
        elseif X == VK_F1 then
            if WGSHUOMING < 2 then
                WGSHUOMING = 2
            else
                WGSHUOMING = 1
            end
        else
            local mxxx = false
            local sm = 0
            -- �书
            if page == 2 then
                local n, m, wfy = 0, 0, 0
                if CC.KFMove[wugong] ~= nil then
                    for i = 1, #CC.KFMove[wugong] do
                        if mx > bx * zszb[i][1] - bx * 25 and mx < bx * zszb[i][1] + bx * 15 and my > by * zszb[i][2] +
                            by * 63 and my < by * zszb[i][2] + by * 63 + bx * 40 then
                            if tb4 ~= i then
                                tb4 = i
                                break
                            end
                        end
                    end
                end
            end
        end
    end
end

---��ʾ����״̬
-- ���Ҽ���ҳ�����¼�������
---��ʾ����״̬
-- ���Ҽ���ҳ�����¼�������
function ShowPersonStatus(teamid)
    local page = 1
    local pagenum = 4

    -- lib.LoadPNGPath(string.format('./data/fight/fight%03d',JY.Person[teamid]["ͷ�����"]), 89, -1, 100)   --ս����ͼ
    local teamnum = GetTeamNum()
    local istart = 0
    local AI_s1 = 1
    local AI_menu_selected = 0
    local WG_num = 0
    local NG_num = 0
    local QG_num = 0
    local AniFrame = 0
    local bx, by = CC.WX, CC.HY
    local fymax = 0
    local size = CC.DefaultFont
    local id = -1 -- JY.Base["����" .. teamid]

    if JY.Status == GAME_WMAP then
        id = WAR.Person[teamid]["������"]
    else
        id = JY.Base["����" .. teamid]
    end
    jiemian(teamid)
    if page == 1 then
        -- Mianban(id)
    elseif page == 2 then
        -- Wugongjm(id)
    elseif page == 3 then
        -- Tianfujm(id)	
    elseif page == 4 then
        -- Shezhijm(id)
    end

    -- ShowPersonStatus_sub(id, page, istart, tfid, max_row, nil, AI_s1, AI_s2, AI_menu_selected,AniFrame,dl)	
    -- end
end

-- �޾Ʋ����������������
-- case��nil=���������else�ӵ�
function ShowPersonStatus_sub(id, page, istart, tfid, max_row, case, AI_s1, AI_s2, AI_menu_selected, AniFrame, dl)

    if JY.Restart == 1 then
        do
            return
        end
    end
    local size = CC.FontSmall4
    local p = JY.Person[id]
    local p0 = JY.Person[0]
    local h = size + CC.PersonStateRowPixel
    local dx = (CC.ScreenW) / 936
    local dy = (CC.ScreenH) / 702
    local i = 1
    local x1, y1 = nil, nil
    -- ����ͼ
    -- lib.LoadPNG(91, 20 * 2 ,-1, -1, 1)
    -- �޾Ʋ�����������ʾ	
    jiemian(1)

end

-- �����ؼ�
function xlmj(id)
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
            if JY.Thing[thid]["����"] == 2 then
                thing[num] = thid
                thingnum[num] = JY.Base["��Ʒ����" .. i + 1]
                num = num + 1
            end
        end
    end
    IsViewingKungfuScrolls = 1
    local r = SelectThing(thing, thingnum)
    local oldwugong = 0
    local oldmiji = 0
    if r > 0 then
        local thingid = r
        local personid = id
        local yes, full, yes1, full1 = nil, nil, nil, nil -- yese=1�ظ��书 yese=2һ����� yese = 0 �������书  full= 0���������� 
        local wugongid = JY.Thing[thingid]["�����书"]
        if JY.Thing[thingid]["�����书"] >= 0 then
            yes = 0
            full = 1
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
        if JY.Thing[thingid]["�����ؼ�"] >= 1 or thingid == 372 then
            yes1 = 0
            full1 = 1
            for i = 1, 5 do
                if JY.Person[personid]["�ؼ�" .. i] == JY.Thing[thingid]["�����ؼ�"] then
                    yes1 = 1
                else
                    if JY.Person[personid]["�ؼ�" .. i] == 0 then
                        full1 = 0
                    end
                end
            end
        end
        Usething_KF(personid, thingid)
    end
    return 1
end

-- װ������
function Mianbanwq(id)

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
            if JY.Thing[thid]["����"] == 1 and JY.Thing[thid]["װ��λ��"] == 0 then
                thing[num] = thid
                thingnum[num] = JY.Base["��Ʒ����" .. i + 1]
                num = num + 1
            end
        end
    end
    if id == 202 and match_ID(id, 72) then
        say("�ٺ٣���ڱ����������������ŵı�����˭˵ˣ��������װ���ˣ�", 72, 0)
        if JY.Thing[thid]["ʹ����"] >= 0 then

            JY.Person[JY.Thing[thid]["ʹ����"]]["����"] = -1
        end
        if JY.Person[id]["����"] >= 0 then
            JY.Thing[JY.Person[id]["����"]]["ʹ����"] = -1
        end
        JY.Person[id]["����"] = id
        JY.Thing[thid]["ʹ����"] = id
        return 1
    end
    -- lib.Debug('��Ʒ������'..#thing)
    local r = SelectThing(thing, thingnum)
    if r >= 0 then
        if CanUseThing(r, id) then
            if JY.Thing[r]["װ��λ��"] == 0 then
                if JY.Thing[r]["ʹ����"] >= 0 then
                    JY.Person[JY.Thing[r]["ʹ����"]]["����"] = -1
                end
                if JY.Person[id]["����"] >= 0 then
                    JY.Thing[JY.Person[id]["����"]]["ʹ����"] = -1
                end
            end
            JY.Person[id]["����"] = r
            JY.Thing[JY.Person[id]["����"]]["ʹ����"] = id

        else
            DrawStrBoxWaitKey("���˲��ʺ��䱸����Ʒ", C_WHITE, CC.DefaultFont)
        end
    end

    return 0
end

-- װ������
function Mianbanfj(id)
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
            if JY.Thing[thid]["����"] == 1 and JY.Thing[thid]["װ��λ��"] == 1 then
                thing[num] = thid
                thingnum[num] = JY.Base["��Ʒ����" .. i + 1]
                num = num + 1
            end
        end
    end
    local r = SelectThing(thing, thingnum)
    if r >= 0 then
        if CanUseThing(r, id) then
            if JY.Thing[r]["װ��λ��"] == 1 then
                if JY.Thing[r]["ʹ����"] >= 0 then
                    JY.Person[JY.Thing[r]["ʹ����"]]["����"] = -1
                end
                if JY.Person[id]["����"] >= 0 then
                    JY.Thing[JY.Person[id]["����"]]["ʹ����"] = -1
                end
            end
            JY.Person[id]["����"] = r
            JY.Thing[JY.Person[id]["����"]]["ʹ����"] = id
        else
            DrawStrBoxWaitKey("���˲��ʺ��䱸����Ʒ", C_WHITE, CC.DefaultFont)
        end
    end
    return 0
end

-- װ������
function Mianbanzq(id)
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
            if JY.Thing[thid]["����"] == 1 and JY.Thing[thid]["װ��λ��"] == 2 then
                thing[num] = thid
                thingnum[num] = JY.Base["��Ʒ����" .. i + 1]
                num = num + 1
            end
        end
    end
    local r = SelectThing(thing, thingnum)
    if r >= 0 then
        if CanUseThing(r, id) then
            if JY.Thing[r]["װ��λ��"] == 2 then
                if JY.Thing[r]["ʹ����"] >= 0 then

                    JY.Person[JY.Thing[r]["ʹ����"]]["����"] = -1
                end
                if JY.Person[id]["����"] >= 0 then
                    JY.Thing[JY.Person[id]["����"]]["ʹ����"] = -1
                end
            end
            JY.Person[id]["����"] = r
            JY.Thing[JY.Person[id]["����"]]["ʹ����"] = id
        else
            DrawStrBoxWaitKey("���˲��ʺ��䱸����Ʒ", C_WHITE, CC.DefaultFont)
        end
    end
    return 0
end

-- �������������ɹ���Ҫ�ĵ���
-- id ����id
function TrainNeedExp(id) -- ��������������Ʒ�ɹ���Ҫ�ĵ���
    local thingid = JY.Person[id]["������Ʒ"];
    local r = 0;
    for i = 0, JY.ThingNum - 1 do
        local wugong = JY.Thing[i]["�����书"]
        if wugong >= 0 then
            JY.Thing[i]["�辭��"] = JY.Wugong[wugong]["�㼶"] * 100
            if JY.Wugong[wugong]["�㼶"] > 2 then
                JY.Thing[i]["�辭��"] = JY.Wugong[wugong]["�㼶"] * 300
            end
        end
    end
    if thingid >= 0 then
        if JY.Thing[thingid]["�����书"] >= 0 then
            local level = 0; -- �˴���level��ʵ��level-1������û���书�r������һ����һ���ġ�
            for i = 1, JY.Base["�书����"] do -- ���ҵ�ǰ�Ѿ������书�ȼ�
                if JY.Person[id]["�书" .. i] == JY.Thing[thingid]["�����书"] then
                    level = math.modf(JY.Person[id]["�书�ȼ�" .. i] / 100);
                    break
                end
            end
            if level < 9 then
                r = math.modf((5 - math.modf(JY.Person[id]["����"] / 25)) * JY.Thing[thingid]["�辭��"] *
                                  (level + 1) * 0.5);
            else
                r = math.huge;
            end
        else
            r = (5 - math.modf(JY.Person[id]["����"] / 25)) * JY.Thing[thingid]["�辭��"];
        end
    end
    return r;
end

-- ҽ�Ʋ˵�
function Menu_Doctor() -- ҽ�Ʋ˵�
    Cls()
    DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "˭Ҫʹ��ҽ��", C_WHITE, CC.DefaultFont);
    local nexty = CC.MainSubMenuY + CC.SingleLineHeight;
    DrawStrBox(CC.MainSubMenuX, nexty, "ҽ������", C_ORANGE, CC.DefaultFont);

    local menu1 = {};
    for i = 1, CC.TeamNum do
        menu1[i] = {"", nil, 0};
        local id = JY.Base["����" .. i]
        if id >= 0 then
            if JY.Person[id]["ҽ������"] >= 20 then
                menu1[i][1] = string.format("%-10s%4d", JY.Person[id]["����"], JY.Person[id]["ҽ������"]);
                menu1[i][3] = 1;
            end
        end
    end

    local id1, id2;
    nexty = nexty + CC.SingleLineHeight;
    local r = ShowMenu(menu1, CC.TeamNum, 0, CC.MainSubMenuX, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE);

    if r > 0 then
        id1 = JY.Base["����" .. r];
        Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH);
        DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "Ҫҽ��˭", C_WHITE, CC.DefaultFont);
        nexty = CC.MainSubMenuY + CC.SingleLineHeight;

        local menu2 = {};
        for i = 1, CC.TeamNum do
            menu2[i] = {"", nil, 0};
            local id = JY.Base["����" .. i]
            if id >= 0 then
                menu2[i][1] = string.format("%-10s%4d/%4d", JY.Person[id]["����"], JY.Person[id]["����"],
                    JY.Person[id]["�������ֵ"]);
                menu2[i][3] = 1;
            end
        end

        local r2 = ShowMenu(menu2, CC.TeamNum, 0, CC.MainSubMenuX, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE);

        if r2 > 0 then
            id2 = JY.Base["����" .. r2];
            local num = ExecDoctor(id1, id2);
            if num > 0 then
                AddPersonAttrib(id1, "����", -2);
            end
            DrawStrBoxWaitKey(string.format("%s �������� %d", JY.Person[id2]["����"], num), C_ORANGE,
                CC.DefaultFont);
        end
    end

    Cls();
    return 0;
end

-- �ⶾ
function Menu_DecPoison() -- �ⶾ
    DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "˭Ҫ���˽ⶾ", C_WHITE, CC.DefaultFont);
    local nexty = CC.MainSubMenuY + CC.SingleLineHeight;
    DrawStrBox(CC.MainSubMenuX, nexty, "�ⶾ����", C_ORANGE, CC.DefaultFont);

    local menu1 = {};
    for i = 1, CC.TeamNum do
        menu1[i] = {"", nil, 0};
        local id = JY.Base["����" .. i]
        if id >= 0 then
            if JY.Person[id]["�ⶾ����"] >= 20 then
                menu1[i][1] = string.format("%-10s%4d", JY.Person[id]["����"], JY.Person[id]["�ⶾ����"]);
                menu1[i][3] = 1;
            end
        end
    end

    local id1, id2;
    nexty = nexty + CC.SingleLineHeight;
    local r = ShowMenu(menu1, CC.TeamNum, 0, CC.MainSubMenuX, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE);

    if r > 0 then
        id1 = JY.Base["����" .. r];
        Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH);
        DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "��˭�ⶾ", C_WHITE, CC.DefaultFont);
        nexty = CC.MainSubMenuY + CC.SingleLineHeight;

        DrawStrBox(CC.MainSubMenuX, nexty, "�ж��̶�", C_WHITE, CC.DefaultFont);
        nexty = nexty + CC.SingleLineHeight;

        local menu2 = {};
        for i = 1, CC.TeamNum do
            menu2[i] = {"", nil, 0};
            local id = JY.Base["����" .. i]
            if id >= 0 then
                menu2[i][1] = string.format("%-10s%5d", JY.Person[id]["����"], JY.Person[id]["�ж��̶�"]);
                menu2[i][3] = 1;
            end
        end

        local r2 = ShowMenu(menu2, CC.TeamNum, 0, CC.MainSubMenuX, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE);
        if r2 > 0 then
            id2 = JY.Base["����" .. r2];
            local num = ExecDecPoison(id1, id2);
            DrawStrBoxWaitKey(string.format("%s �ж��̶ȼ��� %d", JY.Person[id2]["����"], num), C_ORANGE,
                CC.DefaultFont);
        end
    end
    Cls();
    ShowScreen();
    return 0;
end

-- �ⶾ
-- id1 �ⶾid2, ����id2�ж����ٵ���
function ExecDecPoison(id1, id2) -- ִ�нⶾ
    local add = JY.Person[id1]["�ⶾ����"];
    local value = JY.Person[id2]["�ж��̶�"];
    if value > add + 20 then
        return 0;
    end

    add = limitX(math.modf(add / 3) + Rnd(10) - Rnd(10), 0, value);
    return -AddPersonAttrib(id2, "�ж��̶�", -add);
end

function Thing_info(thingID, x, y, myh, numer, size) -- ��ƷID,����x,����Y��hs,��������ҳ����ʼ������starth������,��ҳ
    -- lib.Debug(thingID);
	local me = {}
	local wz = 0
	local hs = 0
	local fy = 0
	local starth = 0
	local WZ = 0
	local m = 1
    local function strcolor_switch(s)
        local Color_Switch = {{"��", PinkRed}, {"��", M_Wheat}, {"��", C_BLACK}, {"��", C_WHITE},
                              {"��", C_ORANGE}, {"��", LimeGreen}, {"��", M_DeepSkyBlue}, {"��", Violet}}
        for i = 1, 8 do
            if Color_Switch[i][1] == s then
                return Color_Switch[i][2]
            end
        end
    end
	if JY.Thing[thingID]['�����书'] > 0 and JY.Wugong[JY.Thing[thingID]['�����书']]['�书����'] >= 6 then 
		local kf = JY.Thing[thingID]['�����书']
		--lib.LoadPNG(91,372*2,wgzbx-size*2,wgzby-CC.ScreenH/2.8,1)
		for i =1,10 do 
			local kftx = JY.Wugong[kf]['��Ч'..i]
			if kftx > 0 then 
				me[#me+1] = NGTX_sm(kf,kftx) 
			end
		end
	else	
		if ItemInfo[thingID] ~= nil then
			for i = 1, #ItemInfo[thingID] do
				me[#me + 1] = ItemInfo[thingID][i]
				if i == ItemInfo[thingID] then
					me[#me + 1] = "��"
				end
			end
		end
	end
	for i = m, #me do
		local tfstr = me[i]
		local color;
		color = strcolor_switch(string.sub(tfstr, 1, 2))
		tfstr = string.sub(tfstr, 3, -1)
		if string.sub(tfstr, 1, 2) == "��" then
			--	hs1 = hs1 + 1
		else
			-- h1 = tjm(wgzbx-size, by*33+by*470 + smsize* (hs1-starth), tfstr, color, smsize,24,smsize,starth-hs1,myh1+1-hs1+starth)
			WZ = tjm(x, y + size *1.2* (hs - starth), tfstr, color, size, numer, size, starth - hs, myh + 1 - hs + starth)
		end
		hs = hs + WZ
	end
	if hs > myh then
		fy = limitX(hs - myh - 1, 0)
	else
		fy = 0
	end
	if 	fy > 0 then 
		--lib.LoadPNG(91,124*2,wgzbx-size*1.9,wgzby+size*14,1,0,60) 
	end	
	if starth > 0 then 
		--lib.LoadPNG(91,127*2,wgzbx-size*1.9,wgzby+size*8,1,0,60) 
	end
end

-- ��ʾ��Ʒ�˵�

function CHOUKA()
    local bx, by = CC.WX, CC.HY
    local x, y = bx * 213, by * 210
    local w, h = bx * 116.5, by * 119
    local menu = {}
    local dwmenu = {}
    local c = 8
    local menu1 = {}
    local menu2 = {}
    local tb = 1
    local pc = 150
    local pc1 = 150
    local pc2 = 164
    local fj = -1
    local headid = -1
    local name = nil
    local id = -1
    local dh = 0
    local size = CC.DefaultFont
    local cd, wg = -1, -1
    for p = 0, JY.PersonNum - 1 do
        local f = JY.Person[p]["����ֽ�"]
        if p ~= 0 and JY.Person[p]["����ֽ�"] < 7 then
            menu[#menu + 1] = {p, f, 1}
        end
    end
    RandFetch(menu1, c, #menu)
    for i = 1, #menu do
        menu2[i] = menu[menu1[i]]
    end
    while true do
        Cls()
        if JY.Restart == 1 then
            break
        end
        lib.LoadPNG(91, 143 * 2, bx * x - size, by * 203, 1, 0, 110)
        for i = 1, 8 do
            local x1, y1 = bx * 10, by * 10
            fj = JY.Person[menu2[i][1]]["����ֽ�"]
            cd = JY.Person[menu2[i][1]]["����"]
            wg = JY.Person[menu2[i][1]]["��ͨ�书"]
            headid = JY.Person[menu2[i][1]]["������"]
            name = JY.Person[menu2[i][1]]["����"]
            id = menu2[i][1]

            -- �ֽ�
            if fj == 1 then
                lib.LoadPNG(91, 188 * 2, bx * x + (i - 1) * w, by * y, 1, 0, 37)
                if menu2[i][3] == 2 then
                    lib.LoadPNG(90, 1068 * 2, bx * x + bx * (i - 1) * w + bx * 3, by * y + by * 6, 1, 0, 35)
                else
                    lib.LoadPNG(90, headid * 2, bx * x + bx * (i - 1) * w + bx * 3, by * y + by * 6, 1, 0, 35)
                end
                lib.PicLoadCache(92, 336 * 2, bx * x + (i - 1) * w, by * y, 1, 0, 0, -1, -1, 0, 0, 37)
                lib.LoadPNG(91, 185 * 2, bx * x + (i - 1) * w + x1, by * y + y1, 1, 0, 50)
            elseif fj == 2 then
                lib.LoadPNG(91, 186 * 2, bx * x + (i - 1) * w, by * y, 1, 0, 37)
                if menu2[i][3] == 2 then
                    lib.LoadPNG(90, 1068 * 2, bx * x + bx * (i - 1) * w + bx * 3, by * y + by * 6, 1, 0, 35)
                else
                    lib.LoadPNG(90, headid * 2, bx * x + bx * (i - 1) * w + bx * 3, by * y + by * 6, 1, 0, 35)
                end
                lib.PicLoadCache(92, 335 * 2, bx * x + (i - 1) * w, by * y, 1, 0, 0, -1, -1, 0, 0, 37)
                lib.LoadPNG(91, 184 * 2, bx * x + (i - 1) * w + x1, by * y + y1, 1, 0, 50)
            elseif fj == 3 or fj == 4 then
                lib.LoadPNG(91, 187 * 2, bx * x + (i - 1) * w, by * y, 1, 0, 37)
                if menu2[i][3] == 2 then
                    lib.LoadPNG(90, 1068 * 2, bx * x + bx * (i - 1) * w + bx * 3, by * y + by * 6, 1, 0, 35)
                else
                    lib.LoadPNG(90, headid * 2, bx * x + bx * (i - 1) * w + bx * 3, by * y + by * 6, 1, 0, 35)
                end
                lib.PicLoadCache(92, 334 * 2, bx * x + (i - 1) * w, by * y, 1, 0, 0, -1, -1, 0, 0, 37)
                lib.LoadPNG(91, 183 * 2, bx * x + (i - 1) * w + x1, by * y + y1, 1, 0, 50)
            elseif fj == 5 or fj == 6 then
                lib.LoadPNG(91, 138 * 2, bx * x + (i - 1) * w, by * y, 1, 0, 37)
                if menu2[i][3] == 2 then
                    lib.LoadPNG(90, 1068 * 2, bx * x + bx * (i - 1) * w + bx * 3, by * y + by * 6, 1, 0, 35)
                else
                    lib.LoadPNG(90, headid * 2, bx * x + bx * (i - 1) * w + bx * 3, by * y + by * 6, 1, 0, 35)
                end
                lib.PicLoadCache(92, 333 * 2, bx * x + (i - 1) * w, by * y, 1, 0, 0, -1, -1, 0, 0, 37)
                lib.LoadPNG(91, 182 * 2, bx * x + (i - 1) * w + x1, by * y + y1, 1, 0, 50)
            end
            local x2, y2 = x1 * 5, y1 * 2.5
            local wgx = bx * size / 3 * 2

            -- ����
            if cd == 1 or cd == 2 or cd == 6 or cd == 7 or cd == 9 or cd == 14 then
                lib.LoadPNG(91, 180 * 2, wgx + bx * x + (i - 1) * w + x2, by * y + by * 125 + y2, 1, 0, 120)
            elseif cd == 3 or cd == 8 or cd == 11 or cd == 13 then
                lib.LoadPNG(91, 179 * 2, wgx + bx * x + (i - 1) * w + x2, by * y + by * 125 + y2, 1, 0, 120)
            elseif cd == 4 or cd == 5 then
                lib.LoadPNG(91, 177 * 2, wgx + bx * x + (i - 1) * w + x2, by * y + by * 125 + y2, 1, 0, 120)
            elseif cd == 10 or cd == 12 then
                lib.LoadPNG(91, 178 * 2, wgx + bx * x + (i - 1) * w + x2, by * y + by * 125 + y2, 1, 0, 120)
            else
                lib.LoadPNG(91, 181 * 2, wgx + bx * x + (i - 1) * w + x2, by * y + by * 125 + y2, 1, 0, 120)
            end

            -- ��ͨ�书
            if wg == 1 then
                lib.LoadPNG(91, 170 * 2, wgx + bx * x + (i - 1) * w + x1, by * y + by * 125 + y2, 1, 0, 120)
            elseif wg == 2 then
                lib.LoadPNG(91, 171 * 2, wgx + bx * x + (i - 1) * w + x1, by * y + by * 125 + y2, 1, 0, 120)
            elseif wg == 3 then
                lib.LoadPNG(91, 172 * 2, wgx + bx * x + (i - 1) * w + x1, by * y + by * 125 + y2, 1, 0, 120)
            elseif wg == 4 then
                lib.LoadPNG(91, 173 * 2, wgx + bx * x + (i - 1) * w + x1, by * y + by * 125 + y2, 1, 0, 120)
            elseif wg == 5 then
                lib.LoadPNG(91, 174 * 2, wgx + bx * x + (i - 1) * w + x1, by * y + by * 125 + y2, 1, 0, 120)
            else
                lib.LoadPNG(91, 175 * 2, wgx + bx * x + (i - 1) * w + x1, by * y + by * 125 + y2, 1, 0, 120)
            end

            local cl = C_WHITE
            if tb == i then
                cl = C_RED
                lib.LoadPNG(91, pc * 2, bx * x + bx * (i - 1) * w, by * y, 1, 0, 37)
                pc = pc + 1
                if pc > pc2 then
                    pc = pc1
                end
            end
            DrawString(bx * x + bx * 75 + (i - 1) * w - string.len(name) / 4 * size, by * y + by * 125, name, cl,
                CC.DefaultFont * 0.7)
        end
        local dh = 0
        local zb = {{855, 379, 144}, {855, 471, 145}, {752, 587, 146}, {841, 584, 147}}
        for i = 1, #zb do
            lib.LoadPNG(91, zb[i][3] * 2, bx * 424 + bx * zb[i][1], by * 33 + by * zb[i][2], 1)
        end
        for i = 1, 10 do
            local x3 = bx * (i - 1) * 100
            lib.LoadPNG(91, 148 * 2, bx * 150 + bx * 30 + x3, by * 33 + by * 650, 1, 0, 100)
        end
        for j = 1, CC.TeamNum do
            local wz = 0
            local zs = 0
            local dl = 0
            local tid = nil
            if JY.Base['����' .. j] > 0 then
                tid = JY.Base["����" .. j]
            end
            if tid ~= nil then
                local pic = JY.Person[tid]['ͷ�����']
                for j = 1, 5 do
                    if JY.Person[tid]['���ж���֡��' .. j] > 0 then
                        if j > 1 then
                            zs = JY.Person[tid]['���ж���֡��' .. j]
                            break
                        end
                        dl = dl + JY.Person[tid]['���ж���֡��' .. j] * 4
                    end
                end
                local x4 = bx * (j - 2) * 100
                lib.PicLoadCache(pic + 101, (dl) * 2, bx * 212 + x4, by * 33 + by * 670)
                wz = wz + 1
                dh = dh + 1
                if dh == zs then
                    dh = 1
                end
            end
        end
        local cznum = JY.Person[0]["�ȼ�"] + 1
        ShowScreen()
        lib.Delay(CC.Frame)
        local X, ktype, mx, my = lib.GetKey()
        if X == VK_ESCAPE or ktype == 4 then
            return 0
        elseif X == VK_SPACE or X == VK_RETURN then
            if menu2[tb][3] == 1 then
                menu2[tb][3] = 2
                instruct_10(menu2[tb][1])
            end
        elseif X == VK_RIGHT then
            tb = tb + 1
            if tb > 8 then
                tb = 1
            end
        end
    end
end

-- ��������(x,y)�Ƿ����ͨ��
-- ����true,���ԣ�false����
function SceneCanPass(x, y) -- ��������(x,y)�Ƿ����ͨ��
    local ispass = true; -- �Ƿ����ͨ��

    if GetS(JY.SubScene, x, y, 1) > 0 then -- ������1����Ʒ������ͨ��
        ispass = false;
    end

    local d_data = GetS(JY.SubScene, x, y, 3); -- �¼���4
    if d_data >= 0 then
        if GetD(JY.SubScene, d_data, 0) ~= 0 then -- d*����Ϊ����ͨ��
            ispass = false;
        end
    end

    if CC.SceneWater[GetS(JY.SubScene, x, y, 0)] ~= nil then -- ˮ�棬���ɽ���
        ispass = false;
    end
    return ispass;
end

function DtoSMap() ---D*�е��¼����ݸ��Ƶ�S*�У�ͬʱ������Ч����
    for i = 0, CC.DNum - 1 do
        local x = GetD(JY.SubScene, i, 9);
        local y = GetD(JY.SubScene, i, 10);
        if x > 0 and y > 0 then
            SetS(JY.SubScene, x, y, 3, i);

            local p1 = GetD(JY.SubScene, i, 5);
            if p1 >= 0 then
                local p2 = GetD(JY.SubScene, i, 6);
                local p3 = GetD(JY.SubScene, i, 7);
                local delay = GetD(JY.SubScene, i, 8);
                if p3 <= p1 then -- ������ֹͣ
                    if JY.Mytick % 100 > delay then
                        p3 = p3 + 1;
                    end
                else
                    if JY.Mytick % 4 == 0 then -- 4�����Ķ�������һ��
                        p3 = p3 + 1;
                    end
                end
                if p3 > p2 then
                    p3 = p1;
                end
                SetD(JY.SubScene, i, 7, p3);
            end
        end
    end
end

function DrawSMap() -- �泡����ͼ
    local x0 = JY.SubSceneX + JY.Base["��X1"] - 1; -- ��ͼ���ĵ�
    local y0 = JY.SubSceneY + JY.Base["��Y1"] - 1;

    local x = limitX(x0, 12, 45) - JY.Base["��X1"];
    local y = limitX(y0, 12, 45) - JY.Base["��Y1"];
    local sc = CC.Shichen
    if CC.TX['ҹĻ'] == 1 then
        --sc = 6
    end
    if CONFIG.Zoom == 100 then
        lib.DrawSMap(JY.SubScene, JY.Base["��X1"], JY.Base["��Y1"], x, y, JY.MyPic, sc)
    else
        lib.DrawSMap(JY.SubScene, JY.Base["��X1"], JY.Base["��Y1"], JY.SubSceneX, JY.SubSceneY, JY.MyPic, sc)
    end
end

-- ��ȡ��Ϸ����
-- id=0 �½��ȣ�=1/2/3 ����
-- �������Ȱ����ݶ���Byte�����С�Ȼ���������Ӧ��ķ������ڷ��ʱ�ʱֱ�Ӵ�������ʡ�
-- ����ǰ��ʵ����ȣ����ļ��ж�ȡ�ͱ��浽�ļ���ʱ�������ӿ졣�����ڴ�ռ������
function LoadRecord(id) -- ��ȡ��Ϸ����
    local zipfile = string.format(CC.SavePath .. 'Save_%d'..'.sav', id)

    if id ~= 0 and (existFile(zipfile) == false) then
        QZXS("�˴浵���ݲ�ȫ�����ܶ�ȡ����ѡ�������浵�����¿�ʼ");
        return -1;
    end

    --Byte.unzip(zipfile, CC.SavePath .. 'r.grp', CC.SavePath .. 'd.grp', CC.SavePath .. 's.grp', CC.SavePath .. 'tjm')
	Byte.unzip_path(zipfile, CC.SavePath..'', 'r.grp','d.grp','s.grp','tjm','e.grp','a.grp')

    local t1 = lib.GetTime();

    -- ��ȡR*.idx�ļ�
    local data = Byte.create(7 * 4);
    Byte.loadfile(data, CC.R_IDXFilename[0], 0, 7 * 4);

    local idx = {};
    idx[0] = 0;
    for i = 1, 7 do
        idx[i] = Byte.get32(data, 4 * (i - 1));
    end

    local grpFile = CC.SavePath .. 'r.grp';
    local sFile = CC.SavePath .. 's.grp';
    local dFile = CC.SavePath .. 'd.grp';
	local msFile = CC.SavePath..'a.grp';
	local mdFile = CC.SavePath..'e.grp';
    local cx = JY.Base['����']
    if id == 0 then
        grpFile = CC.R_GRPFilename[id];
        sFile = CC.S_Filename[id];
        dFile = CC.D_Filename[id];
		msFile = CC.MMapFile[6];
		mdFile = CC.MMapFile[7];
    end

    -- ��ȡR*.grp�ļ�
    JY.Data_Base = Byte.create(idx[1] - idx[0]); -- ��������
    Byte.loadfile(JY.Data_Base, grpFile, idx[0], idx[1] - idx[0]);

    -- ���÷��ʻ������ݵķ����������Ϳ����÷��ʱ�ķ�ʽ�����ˡ������ðѶ���������ת��Ϊ����Լ����ʱ��Ϳռ�
    local meta_t = {
        __index = function(t, k)
            return GetDataFromStruct(JY.Data_Base, 0, CC.Base_S, k);
        end,

        __newindex = function(t, k, v)
            SetDataFromStruct(JY.Data_Base, 0, CC.Base_S, k, v);
        end
    }
    setmetatable(JY.Base, meta_t);

    JY.PersonNum = math.floor((idx[2] - idx[1]) / CC.PersonSize); -- ����

    JY.Data_Person = Byte.create(CC.PersonSize * JY.PersonNum);
    Byte.loadfile(JY.Data_Person, grpFile, idx[1], CC.PersonSize * JY.PersonNum);

    for i = 0, JY.PersonNum - 1 do
        JY.Person[i] = {};
        local meta_t = {
            __index = function(t, k)
                return GetDataFromStruct(JY.Data_Person, i * CC.PersonSize, CC.Person_S, k);
            end,

            __newindex = function(t, k, v)
                SetDataFromStruct(JY.Data_Person, i * CC.PersonSize, CC.Person_S, k, v);
            end
        }
        setmetatable(JY.Person[i], meta_t);
    end

    JY.ThingNum = math.floor((idx[3] - idx[2]) / CC.ThingSize); -- ��Ʒ
    JY.Data_Thing = Byte.create(CC.ThingSize * JY.ThingNum);
    Byte.loadfile(JY.Data_Thing, grpFile, idx[2], CC.ThingSize * JY.ThingNum);
    for i = 0, JY.ThingNum - 1 do
        JY.Thing[i] = {};
        local meta_t = {
            __index = function(t, k)
                return GetDataFromStruct(JY.Data_Thing, i * CC.ThingSize, CC.Thing_S, k);
            end,

            __newindex = function(t, k, v)
                SetDataFromStruct(JY.Data_Thing, i * CC.ThingSize, CC.Thing_S, k, v);
            end
        }
        setmetatable(JY.Thing[i], meta_t);
    end

    JY.SceneNum = math.floor((idx[4] - idx[3]) / CC.SceneSize); -- ����
    JY.Data_Scene = Byte.create(CC.SceneSize * JY.SceneNum);
    Byte.loadfile(JY.Data_Scene, grpFile, idx[3], CC.SceneSize * JY.SceneNum);
    for i = 0, JY.SceneNum - 1 do
        JY.Scene[i] = {};
        local meta_t = {
            __index = function(t, k)
                return GetDataFromStruct(JY.Data_Scene, i * CC.SceneSize, CC.Scene_S, k);
            end,

            __newindex = function(t, k, v)
                SetDataFromStruct(JY.Data_Scene, i * CC.SceneSize, CC.Scene_S, k, v);
            end
        }
        setmetatable(JY.Scene[i], meta_t);
    end

    JY.WugongNum = math.floor((idx[5] - idx[4]) / CC.WugongSize); -- �书
    JY.Data_Wugong = Byte.create(CC.WugongSize * JY.WugongNum);
    Byte.loadfile(JY.Data_Wugong, grpFile, idx[4], CC.WugongSize * JY.WugongNum);
    for i = 0, JY.WugongNum - 1 do
        JY.Wugong[i] = {};
        local meta_t = {
            __index = function(t, k)
                return GetDataFromStruct(JY.Data_Wugong, i * CC.WugongSize, CC.Wugong_S, k);
            end,

            __newindex = function(t, k, v)
                SetDataFromStruct(JY.Data_Wugong, i * CC.WugongSize, CC.Wugong_S, k, v);
            end
        }
        setmetatable(JY.Wugong[i], meta_t);
    end

    JY.ShopNum = math.floor((idx[6] - idx[5]) / CC.ShopSize); -- �����̵�
    JY.Data_Shop = Byte.create(CC.ShopSize * JY.ShopNum);
    Byte.loadfile(JY.Data_Shop, grpFile, idx[5], CC.ShopSize * JY.ShopNum);
    for i = 0, JY.ShopNum - 1 do
        JY.Shop[i] = {};
        local meta_t = {
            __index = function(t, k)
                return GetDataFromStruct(JY.Data_Shop, i * CC.ShopSize, CC.Shop_S, k);
            end,

            __newindex = function(t, k, v)
                SetDataFromStruct(JY.Data_Shop, i * CC.ShopSize, CC.Shop_S, k, v);
            end
        }
        setmetatable(JY.Shop[i], meta_t);
    end

    JY.TejiNum = math.floor((idx[7] - idx[6]) / CC.TejiSize); -- �ؼ�
    JY.Data_Teji = Byte.create(CC.TejiSize * JY.TejiNum);
    Byte.loadfile(JY.Data_Teji, grpFile, idx[6], CC.TejiSize * JY.TejiNum);
    for i = 0, JY.TejiNum - 1 do
        JY.Teji[i] = {};
        local meta_t = {
            __index = function(t, k)
                return GetDataFromStruct(JY.Data_Teji, i * CC.TejiSize, CC.Teji_S, k);
            end,

            __newindex = function(t, k, v)
                SetDataFromStruct(JY.Data_Teji, i * CC.TejiSize, CC.Teji_S, k, v);
            end
        }
        setmetatable(JY.Teji[i], meta_t);
    end

    lib.LoadSMap(sFile, CC.TempS_Filename, JY.SceneNum, CC.SWidth, CC.SHeight, dFile, CC.DNum, 11);
	lib.LoadMMapEvent(msFile,mdFile,CC.MWidth,CC.MHeight,CC.DNum,11);--���䣬��Ӵ��ͼ�¼�
    collectgarbage();

    lib.Debug(string.format("Loadrecord time=%d", lib.GetTime() - t1));

    JY.LOADTIME = lib.GetTime()



    rest()

    if id > 0 then
        tjmload(id)
        --loadStringTableFromJson(JHtxt.txt)
    end

    --local filer = io.open('JHtxt.txt', 'r')
    --local jsonText = filer:read('*a')
    --filer:close(filer)
    


    os.remove(CC.SavePath .. 'r.grp')
    os.remove(CC.SavePath .. 'd.grp')
    os.remove(CC.SavePath .. 's.grp')
	os.remove(CC.SavePath .. 'a.grp')
    os.remove(CC.SavePath .. 'e.grp')
    os.remove(CC.SavePath .. 'tjm');
end

-- д��Ϸ����
-- id=0 �½��ȣ�=1/2/3 ����
function SaveRecord(id) -- д��Ϸ����

    -- �ж��Ƿ����ӳ�������
    if JY.Status == GAME_SMAP then
        JY.Base["����"] = JY.SubScene
    else
        JY.Base["����"] = -1
    end

    -- ��ȡR*.idx�ļ�
    -- Catʱ���ʱ
    -------------------------------------
    -------------------------------------
    local t1 = lib.GetTime()
    JY.SAVETIME = lib.GetTime()
    CC.Miao = CC.Miao + math.modf((JY.SAVETIME - JY.LOADTIME) / 1000)
    JY.LOADTIME = lib.GetTime()
    -------------------------------------
    -------------------------------------

    local data = Byte.create(7 * 4);
    Byte.loadfile(data, CC.R_IDXFilename[0], 0, 7 * 4);

    local idx = {};
    idx[0] = 0;
    for i = 1, 7 do
        idx[i] = Byte.get32(data, 4 * (i - 1));
    end

    --local table = json.encode(CC.JHtxt)
    --if CC.JHtxt[1] ~= nil then 
    --    local file = io.open('JHtxt.txt', 'w')
    --    file:write(json.encode(table))
    --    file:close(file)
    --end
   
    -- os.remove('r.grp');
    -- дR*.grp�ļ�
    Byte.savefile(JY.Data_Base, CC.SavePath .. 'r.grp', idx[0], idx[1] - idx[0]);

    Byte.savefile(JY.Data_Person, CC.SavePath .. 'r.grp', idx[1], CC.PersonSize * JY.PersonNum);

    Byte.savefile(JY.Data_Thing, CC.SavePath .. 'r.grp', idx[2], CC.ThingSize * JY.ThingNum);

    Byte.savefile(JY.Data_Scene, CC.SavePath .. 'r.grp', idx[3], CC.SceneSize * JY.SceneNum);

    Byte.savefile(JY.Data_Wugong, CC.SavePath .. 'r.grp', idx[4], CC.WugongSize * JY.WugongNum);

    Byte.savefile(JY.Data_Shop, CC.SavePath .. 'r.grp', idx[5], CC.ShopSize * JY.ShopNum);

    Byte.savefile(JY.Data_Teji, CC.SavePath .. 'r.grp', idx[6], CC.TejiSize * JY.TejiNum);

    lib.SaveSMap(CC.SavePath .. 's.grp', CC.SavePath .. 'd.grp');
	lib.SaveMMap(CC.SavePath..'a.grp',CC.SavePath..'e.grp');
    tjmsave(id)
    --saveStringTableAsJson(JHtxt.txt,CC.JHtxt)

	local zipfile = string.format(CC.SavePath .. 'Save_%d'..'.sav', id)
    --Byte.zip(zipfile, CC.SavePath .. 'r.grp', CC.SavePath .. 'd.grp', CC.SavePath .. 's.grp', CC.SavePath .. 'a.grp', CC.SavePath .. 'e.grp', CC.SavePath .. 'tjm')
	Byte.zipfile(zipfile, CC.SavePath..'r.grp','r.grp', CC.SavePath..'s.grp','s.grp', CC.SavePath..'d.grp','d.grp', CC.SavePath..'a.grp','a.grp', CC.SavePath..'e.grp','e.grp', CC.SavePath..'tjm','tjm')
    os.remove(CC.SavePath .. 'r.grp')
    os.remove(CC.SavePath .. 'd.grp')
    os.remove(CC.SavePath .. 's.grp')
	os.remove(CC.SavePath .. 'a.grp')
	os.remove(CC.SavePath .. 'e.grp')
    os.remove(CC.SavePath .. 'tjm');
    lib.Debug(string.format("SaveRecord time=%d", lib.GetTime() - t1));
end

-------------------------------------------------------------------------------------
-----------------------------------ͨ�ú���-------------------------------------------

function filelength(filename) -- �õ��ļ�����
    local inp = io.open(filename, "rb");
    local l = inp:seek("end");
    inp:close();
    return l;
end

-- ��S������, (x,y) ���꣬level �� 0-5
function GetS(id, x, y, level) -- ��S������
    return lib.GetS(id, x, y, level);
end

-- дS��
function SetS(id, x, y, level, v) -- дS��
    lib.SetS(id, x, y, level, v);
end

-- ��D*
-- sceneid ������ţ�
-- id D*���
-- Ҫ���ڼ�������, 0-10
function GetD(Sceneid, id, i) -- ��D*
    return lib.GetD(Sceneid, id, i);
end

-- дD��
function SetD(Sceneid, id, i, v) -- дD��
    lib.SetD(Sceneid, id, i, v);
end

-- �����ݵĽṹ�з�������
-- data ����������
-- offset data�е�ƫ��
-- t_struct ���ݵĽṹ����jyconst���кܶඨ��
-- key  ���ʵ�key
function GetDataFromStruct(data, offset, t_struct, key) -- �����ݵĽṹ�з������ݣ�����ȡ����
    local t = t_struct[key];
    local r;
    if t[2] == 0 then
        r = Byte.get16(data, t[1] + offset);
    elseif t[2] == 1 then
        r = Byte.getu16(data, t[1] + offset);
    elseif t[2] == 2 then
        if CC.SrcCharSet == 0 then
            r = lib.CharSet(Byte.getstr(data, t[1] + offset, t[3]), 0);
        else
            r = Byte.getstr(data, t[1] + offset, t[3]);
        end
    end
    return r;
end

function SetDataFromStruct(data, offset, t_struct, key, v) -- �����ݵĽṹ�з������ݣ���������
    local t = t_struct[key];
    if t[2] == 0 then
        Byte.set16(data, t[1] + offset, v);
    elseif t[2] == 1 then
        Byte.setu16(data, t[1] + offset, v);
    elseif t[2] == 2 then
        local s;
        if CC.SrcCharSet == 0 then
            s = lib.CharSet(v, 1);
        else
            s = v;
        end
        Byte.setstr(data, t[1] + offset, t[3], s);
    end
end

-- ����t_struct ����Ľṹ�����ݴ�data�����ƴ��ж�����t��
function LoadData(t, t_struct, data) -- data�����ƴ��ж�����t��
    for k, v in pairs(t_struct) do
        if v[2] == 0 then
            t[k] = Byte.get16(data, v[1]);
        elseif v[2] == 1 then
            t[k] = Byte.getu16(data, v[1]);
        elseif v[2] == 2 then
            if CC.SrcCharSet == 0 then
                t[k] = lib.CharSet(Byte.getstr(data, v[1], v[3]), 0);
            else
                t[k] = Byte.getstr(data, v[1], v[3]);
            end
        end
    end
end

-- ����t_struct ����Ľṹ������д��data Byte�����С�
function SaveData(t, t_struct, data) -- ����д��data Byte�����С�
    for k, v in pairs(t_struct) do
        if v[2] == 0 then
            Byte.set16(data, v[1], t[k]);
        elseif v[2] == 1 then
            Byte.setu16(data, v[1], t[k]);
        elseif v[2] == 2 then
            local s;
            if CC.SrcCharSet == 0 then
                s = lib.CharSet(t[k], 1);
            else
                s = t[k];
            end
            Byte.setstr(data, v[1], v[3], s);
        end
    end
end

-- ����x�ķ�Χ
function limitX(x, minv, maxv)
    if x < minv then
        x = minv;
    end
    if maxv ~= nil and x > maxv then
        x = maxv;
    end
    return x
end

function RGB(r, g, b) -- ������ɫRGB
    return r * 65536 + g * 256 + b;
end

function GetRGB(color) -- ������ɫ��RGB����
    color = color % (65536 * 256);
    local r = math.floor(color / 65536);
    color = color % 65536;
    local g = math.floor(color / 256);
    local b = color % 256;
    return r, g, b
end

-- �ȴ���������
function WaitKey(flag)
    -- ktype  1�����̣�2������ƶ���3:��������4������Ҽ���5������м���6�������ϣ�7��������
    local key, ktype, mx, my = -1, -1, -1, -1;
    while true do
        if JY.Restart == 1 then
            break
        end
        key, ktype, mx, my = lib.GetKey();
        if ktype == nil then
            ktype, mx, my = -1, -1, -1;
        end
        if ktype ~= -1 or key ~= -1 then
            if (flag == nil or flag == 0) and ktype ~= 2 then
                break
            elseif flag ~= nil and flag ~= 0 then
                break
            end
        end
        lib.Delay(CC.Frame / 2);
    end
    return key, ktype, mx, my;
end

-- ����һ���������İ�ɫ�����Ľǰ���
function DrawBox(x1, y1, x2, y2, color)
    local s = 4
    lib.Background(x1 + 4, y1, x2 - 4, y1 + s, 88)
    lib.Background(x1 + 1, y1 + 1, x1 + s, y1 + s, 88)
    lib.Background(x2 - s, y1 + 1, x2 - 1, y1 + s, 88)
    lib.Background(x1, y1 + 4, x2, y2 - 4, 88)
    lib.Background(x1 + 1, y2 - s, x1 + s, y2 - 1, 88)
    lib.Background(x2 - s, y2 - s, x2 - 1, y2 - 1, 88)
    lib.Background(x1 + 4, y2 - s, x2 - 4, y2, 88)
    local r, g, b = GetRGB(color)
    DrawBox_1(x1 + 1, y1 + 1, x2, y2, RGB(math.modf(r / 2), math.modf(g / 2), math.modf(b / 2)))
    DrawBox_1(x1, y1, x2 - 1, y2 - 1, color)
end

-- ����һ���������İ�ɫ�����Ľǰ���
function DrawBox_1(x1, y1, x2, y2, color)
    local s = 4
    lib.DrawRect(x1 + s, y1, x2 - s, y1, color)
    lib.DrawRect(x1 + s, y2, x2 - s, y2, color)
    lib.DrawRect(x1, y1 + s, x1, y2 - s, color)
    lib.DrawRect(x2, y1 + s, x2, y2 - s, color)
    lib.DrawRect(x1 + 2, y1 + 1, x1 + s - 1, y1 + 1, color)
    lib.DrawRect(x1 + 1, y1 + 2, x1 + 1, y1 + s - 1, color)
    lib.DrawRect(x2 - s + 1, y1 + 1, x2 - 2, y1 + 1, color)
    lib.DrawRect(x2 - 1, y1 + 2, x2 - 1, y1 + s - 1, color)
    lib.DrawRect(x1 + 2, y2 - 1, x1 + s - 1, y2 - 1, color)
    lib.DrawRect(x1 + 1, y2 - s + 1, x1 + 1, y2 - 2, color)
    lib.DrawRect(x2 - s + 1, y2 - 1, x2 - 2, y2 - 1, color)
    lib.DrawRect(x2 - 1, y2 - s + 1, x2 - 1, y2 - 2, color)
end

-- ��ʾ��Ӱ�ַ���
function DrawString(x, y, str, color, size, ttf) -- ��ʾ��Ӱ�ַ���
    ttf = ttf or CC.FontName
    if x == -1 then
        local ll = #str;
        local w = size * ll / 2 + 2 * CC.MenuBorderPixel;
        x = (CC.ScreenW - size / 2 * ll - 2 * CC.MenuBorderPixel) / 2;
    end
    if y == -1 then
        y = (CC.ScreenH - size - 2 * CC.MenuBorderPixel) / 2
    end
    lib.DrawStr(x, y, str, color, size, ttf, CC.SrcCharSet, CC.OSCharSet);
end

-- ��ʾ������ַ���
-- (x,y) ���꣬�����Ϊ-1,������Ļ�м���ʾ
function DrawStrBox(x, y, str, color, size, boxcolor) -- ��ʾ������ַ���
    local ll = #str;
    local w = size * ll / 2 + 2 * CC.MenuBorderPixel;
    local h = size + 2 * CC.MenuBorderPixel;
    if boxcolor == nil then
        boxcolor = C_WHITE
    end
    if x == -1 then
        x = (CC.ScreenW - size / 2 * ll - 2 * CC.MenuBorderPixel) / 2;
    end
    if y == -1 then
        y = (CC.ScreenH - size - 2 * CC.MenuBorderPixel) / 2;
    end

    DrawBox(x, y, x + w - 1, y + h - 1, boxcolor);
    DrawString(x + CC.MenuBorderPixel, y + CC.MenuBorderPixel, str, color, size);
end

-- �޾Ʋ��������Ӷ���ɫת����֧��
function DrawStrBox3(x, y, s, color, size, flag) -- ��ʾ������ַ���
    local ll = #s - flag * 2;
    local w = size * ll / 2 + 2 * CC.MenuBorderPixel;
    local h = size + 2 * CC.MenuBorderPixel;
    local function strcolor_switch(s)
        local Color_Switch = {{"��", C_RED}, {"��", C_GOLD}, {"��", C_BLACK}, {"��", C_WHITE}, {"��", C_ORANGE}}
        local Numbers = {{"1", 10}, {"2", 15}, {"3", 15}, {"4", 15}, {"5", 15}, {"6", 15}, {"7", 15}, {"8", 15},
                         {"9", 15}, {"0", 15}}
        for i = 1, 5 do
            if Color_Switch[i][1] == s then
                return 1, Color_Switch[i][2]
            end
        end
        for i = 1, 10 do
            if Numbers[i][1] == s then
                return 2, Numbers[i][2]
            end
        end
        return 0
    end

    if x == -1 then
        x = (CC.ScreenW - size / 2 * ll - 2 * CC.MenuBorderPixel) / 2;
    end
    if y == -1 then
        y = (CC.ScreenH - size - 2 * CC.MenuBorderPixel) / 2;
    end

    -- �޾Ʋ�����������ɫ 7-31
    DrawBox(x, y, x + w - 1, y + h - 1, LimeGreen);
    local space = 0;
    while string.len(s) >= 1 do
        local str
        str = string.sub(s, 1, 1)
        if string.byte(s, 1, 1) > 127 then -- �жϵ�˫�ַ�
            str = string.sub(s, 1, 2)
            s = string.sub(s, 3, -1)
        else
            str = string.sub(s, 1, 1)
            s = string.sub(s, 2, -1)
        end
        local cs, cs2 = strcolor_switch(str)
        if cs == 1 then
            color = cs2
        elseif cs == 2 then
            DrawString(x + CC.MenuBorderPixel + space, y + CC.MenuBorderPixel, str, color, size);
            space = space + cs2;
        else
            DrawString(x + CC.MenuBorderPixel + space, y + CC.MenuBorderPixel, str, color, size);
            space = space + size;
        end
    end
end

-- ��ʾ��ѯ��Y/N��������Y���򷵻�true, N�򷵻�false
-- (x,y) ���꣬�����Ϊ-1,������Ļ�м���ʾ
-- ��Ϊ�ò˵�ѯ���Ƿ�
function DrawStrBoxYesNo(x, y, str, color, size, boxcolor)
    local size = CC.DefaultFont
    local bx, by = CC.WX, CC.HY
    if JY.Restart == 1 then
        return
    end
    local tb = 1
    lib.GetKey()
    local ll = #str
    local w = size * ll / 2 + 2 * CC.MenuBorderPixel
    local h = size + 2 * CC.MenuBorderPixel
    if x == -1 then
        x = (CC.ScreenW - size / 2 * ll - 2 * CC.MenuBorderPixel) / 2
    end
    if y == -1 then
        y = (CC.ScreenH - size - 2 * CC.MenuBorderPixel) / 2
    end

    local fx, fy = lib.GetPNGXY(91, 139 * 2)
    local tx, ty = lib.GetPNGXY(91, 28 * 2)
    local xx, yy = CC.ScreenW / 2 - tx / 2, CC.ScreenH / 2 - ty / 2
    local menu = {{"ȷ   ��", nil, 1}, {"ȡ   ��", nil, 2}}
    while true do
        if JY.Restart == 1 then
            break
        end
        Cls()
        lib.LoadPNG(91, 28 * 2, xx, yy, 1)
        tjm(xx + tx / 20, yy + ty / 15, str, color, size * 0.8, 9, size * 0.8)
        for i = 1, 2 do
            local cl = C_WHITE
            if tb == i then
                cl = C_RED
            end
            lib.LoadPNG(91, 139 * 2, xx + (i - 1) * fx, yy + ty + ty / 40, 1)
            DrawString(xx + fx / 6 + (i - 1) * fx, yy + ty + ty / 10, menu[i][1], cl, size * 0.8)
        end

        ShowScreen()
        lib.Delay(CC.Frame)
        local key, ktype, mx, my = lib.GetKey();
        if key == VK_SPACE or key == VK_RETURN or ktype == 3 then
            if tb == 1 then
                return true
            else
                return false
            end
        elseif key == VK_ESCAPE or ktype == 4 then
            break
        elseif key == VK_RIGHT then
            tb = tb + 1
            if tb > 2 then
                tb = 1
            end
        elseif key == VK_LEFT then
            tb = tb - 1
            if tb < 1 then
                tb = 2
            end
        else
            local pd = false
            -- 143 40
            for i = 1, 2 do
                if mx > xx + (i - 1) * fx and mx < xx + (i - 1) * fx + fx and my > yy + ty + ty / 40 and my < yy + ty +
                    ty / 40 + fy then
                    pd = true
                    tb = i
                end
            end
            if pd == true and ktype == 3 then
                if tb == 1 then
                    return true
                else
                    return false
                end
            end
        end
    end
end

-- ��ʾ�ַ������ȴ��������ַ���������ʾ����Ļ�м�
function DrawStrBoxWaitKey(s, color, size, flag, boxcolor)
    if JY.Restart == 1 then
        return
    end
    lib.GetKey();
    -- Cls();
    -- �޾Ʋ������ֿ�����
    if flag == nil then
        if boxcolor == nil then
            DrawStrBox(-1, -1, s, color, size);
        else
            DrawStrBox(-1, -1, s, color, size, boxcolor);
        end
    else
        DrawStrBox3(-1, -1, s, color, size, flag);
    end
    ShowScreen();
    WaitKey();
end

-- ��ʾ�ַ������ȴ��������ַ���������ʾ����Ļ�м�
function DrawStrBoxWaitKey1(s, color, size, flag, boxcolor)
    if JY.Restart == 1 then
        return
    end
    lib.GetKey();
    -- Cls();
    -- �޾Ʋ������ֿ�����
    if flag == nil then
        if boxcolor == nil then
            DrawStrBox(-1, -1, s, color, size);
        else
            DrawStrBox(-1, -1, s, color, size, boxcolor);
        end
    else
        DrawStrBox3(-1, -1, s, color, size, flag);
    end
    ShowScreen();
    WaitKey();
end

-- ���� [0 , i-1] �����������
function Rnd(i) -- �����
    local r = math.random(i);
    return r - 1;
end

-- �����������ԣ���������ֵ���ƣ���Ӧ�����ֵ���ơ���Сֵ������Ϊ0
-- id ����id
-- str�����ַ���
-- value Ҫ���ӵ�ֵ��������ʾ����
-- ����1,ʵ�����ӵ�ֵ
-- ����2���ַ�����xxx ����/���� xxxx��������ʾҩƷЧ��
function AddPersonAttrib(id, str, value)
    local oldvalue = JY.Person[id][str]
    local attribmax = math.huge
    local zm = JY.Base['��Ŀ']
    if str == "����" then
        attribmax = JY.Person[id]["�������ֵ"]
    elseif str == "����" then
        attribmax = JY.Person[id]["�������ֵ"]
    elseif CC.PersonAttribMax[str] ~= nil then
        attribmax = CC.PersonAttribMax[str]
        if inteam(id) == false then
            if str == "������" then
                attribmax = CC.PersonAttribMax[str] + JY.Base['��Ŀ'] * 10
            end
            if str == "������" then
                attribmax = CC.PersonAttribMax[str] + JY.Base['��Ŀ'] * 10
            end
            if str == "�Ṧ" then
                attribmax = CC.PersonAttribMax[str] + JY.Base['��Ŀ'] * 10
            end

            if str == "ȭ�ƹ���" or str == "ָ������" or str == "��������" or str == "ˣ������" or str ==
                "�������" then
                attribmax = CC.PersonAttribMax[str] + JY.Base['��Ŀ'] * JY.Base['�Ѷ�']
            end
            if str == "��������" then
                -- attribmax = (7-JY.Base['����ֽ�'])*JY.Base['�Ѷ�']*5  + JY.Base['��Ŀ']*100
                Hp_Max(id)
            end
            if str == "�������ֵ" then
                local p_zz = JY.Person[id]["����"];
                local zz = 100 - JY.Person[id]["����"]
                if isteam(id) then
                    attribmax = 1500
                    attribmax = attribmax + zz * 40
                else
                    attribmax = JY.Person[id]["�������ֵ"]
                end
                -- ������ɨ�أ�ʯ���죬������ ������ɮ
                if match_ID(id, 53) or match_ID(id, 114) or match_ID(id, 9760) or match_ID(id, 116) or match_ID(id, 638) or
                    match_ID(id, 499) or match_ID(id, 9999) then
                    attribmax = 9999
                end

                -- ѧһ���ڹ�����1000��������
                if NGnum(id) >= 1 then
                    local n = NGnum(id)
                    if n >= 3 then
                        n = 3
                    end
                    attribmax = attribmax + 1000 * NGnum(id)
                end
                -- ѧ�б�ڤ�����ǣ�+300
                for i = 1, JY.Base["�书����"] do
                    -- if JY.Person[id]["�书" .. i] == 85 or JY.Person[id]["�书" .. i] == 88 then
                    -- attribmax = attribmax + 300
                    -- break
                    -- end
                    local kf = JY.Person[id]["�书" .. i]
                    local kfnl = JY.Thing[KF_thing(kf)]['���������ֵ']
                    if kfnl > 0 then
                        attribmax = attribmax + kfnl
                        break
                    end
                end
                -- �������
                if JY.Person[id]['��Ѩ' .. 129] == 1 then
                    attribmax = attribmax + 500
                end
                -- ������������
                if match_ID(id, 58) then
                    attribmax = attribmax - JY.Person[300]["����"] * 1000
                end
                -- ��������2999������9999
                if attribmax < 2999 then
                    attribmax = 2999
                end
                if attribmax > 9999 then
                    -- attribmax = 9999 
                end
                local nd = JY.Base['�Ѷ�']
                local zm = JY.Base['��Ŀ']
                local fj = (6 - JY.Person[id]['����ֽ�'])
                local nl_max = 0
                if id == 0 and inteam(id) then
                    if attribmax > 9999 then
                        attribmax = 9999
                    end
                else
                    nl_max = nd * zm * fj * fj * 2
                    attribmax = attribmax + nl_max
                end
            end
        end
    end

    -- �٤�ܳ˼����������ֵ
    if str == "���˳̶�" then
        if PersonKF(id, 169) then
            attribmax = 50
        end
    end
    if str == '����' then
        attribmax = 20
    end
    if str == "�������ֵ" then

    end
    if str == "�������ֵ" then

    end

    -- �����أ������֣����ѹã��ö�500
    if str == "�ö�����" and (match_ID(id, 2) or match_ID(id, 83) or match_ID(id, 17)) then
        attribmax = 600
    end

    -- ����ˣ��ö�400
    if str == "�ö�����" and match_ID(id, 25) then
        attribmax = 500
    end
    -- ������Ѩ
    if str == "�ö�����" and JY.Person[id]['��Ѩ' .. 22] == 1 then
        attribmax = attribmax + 20
    end
    -- �Ѷ�����Ѩ
    if str == "�ö�����" and JY.Person[id]['��Ѩ' .. 25] == 1 then
        attribmax = attribmax + 30
        if Pmiji(id, 6) and Pmiji(id, 8) then
            attribmax = attribmax + 80
        end
    end

    -- ��ʴ����Ѩ1
    if str == "�ö�����" and JY.Person[id]['��Ѩ' .. 28] == 1 then
        attribmax = attribmax + 100
    end
    -- ����ţ��ƽһָ��ѦĽ��ҽ��500
    if str == "ҽ������" and (match_ID(id, 16) or match_ID(id, 28) or match_ID(id, 45)) then
        attribmax = 600
    end
    -- ����ʯ��������ҽ��400
    if str == "ҽ������" and (match_ID(id, 85) or match_ID(id, 2)) then
        attribmax = 500
    end
    -- ����ҽ����ҽ���ö��ⶾ����400
    if (str == "ҽ������" or str == "�ö�����" or str == "�ⶾ����") and id == 0 and JY.Base["��׼"] == 8 then
        attribmax = 500
    end
    -- �����������ö��ⶾ����500
    if (str == "�ö�����" or str == "�ⶾ����") and id == 0 and JY.Base["��׼"] == 9 then
        attribmax = 600
    end
    -- �ֻ���ҽ���ö�����300
    if (str == "ҽ������" or str == "�ö�����") and match_ID(id, 4) then
        attribmax = 400
    end
    -- ��Ѱ�����������ɶ���500
    if str == "��������" and match_ID(id, 498) then
        attribmax = 400
    end
    -- ս���н����޷��ָ��κ�״̬
    if JY.Status == GAME_WMAP then
        if str == '����' or str == '����' or str == '����' then
            if value > 0 and WAR.PD['����'][id] ~= nil then
                value = 0
            end
        end
        -- ����������
        if id == 0 and JY.Base['��׼'] == 9 and str == '�ж��̶�' then
            if value < 0 then
                value = 0
            end
        end
    end
    local newvalue = limitX(oldvalue + value, 0, attribmax)
    JY.Person[id][str] = newvalue

    local tf = {9960, 9959, 9958, 9957, 9956}
    local jc = {"ȭ�ƹ���", "ָ������", "��������", "ˣ������", "�������"}
    if str == 'ʵս' then
        if newvalue >= 500 then
            if CC.PTF[id] ~= nil then
                for j = 1, #tf do
                    if CC.PTF[id][tf[j]] == 1 then
                        if JY.Person[id][jc[j]] >= 300 then
                            SetTF(id, tf[j], nil)
                            SetTF(id, tf[j] - 5, 1)
                        end
                    end
                end
            end
        end
    end
    for j = 1, #jc do
        if str == jc[j] then
            if newvalue >= 300 and JY.Person[id]['ʵս'] >= 500 then
                if CC.PTF[id] ~= nil then
                    if CC.PTF[id][tf[j]] == 1 then
                        SetTF(id, tf[j], nil)
                        SetTF(id, tf[j] - 5, 1)
                    end
                end
            end
        end
    end

    local add = newvalue - oldvalue
    local showstr = ""
    if add > 0 then
        showstr = string.format("%s ���� %d", str, add)
    elseif add < 0 then
        showstr = string.format("%s ���� %d", str, -add)
    end
    return add, showstr
end

-- ����midi
function PlayMIDI(id) -- ����midi
    JY.CurrentMIDI = id;
    if JY.EnableMusic == 0 then
        return;
    end
    if id >= 0 then
        lib.PlayMIDI(string.format(CC.MIDIFile, id + 1));
    end
end

-- ������Чatk***
function PlayWavAtk(id) -- ������Чatk***
    if JY.EnableSound == 0 then
        return;
    end
    if id >= 0 then
        lib.PlayWAV(string.format(CC.ATKFile, id));
    end
end

-- ������Чe**
function PlayWavE(id) -- ������Чe**
    if JY.EnableSound == 0 then
        return;
    end
    if id >= 0 then
        lib.PlayWAV(string.format(CC.EFile, id));
    end
end

-- flag =0 or nil ȫ��ˢ����Ļ
-- 1 ��������εĿ���ˢ��
function ShowScreen(flag)
    if JY.Darkness == 0 then
        if flag == nil then
            flag = 0
        end
        lib.ShowSurface(flag)
    end
end

-- ͨ�ò˵�����
-- menuItem ��ÿ���һ���ӱ�����Ϊһ���˵���Ķ���
--          �˵����Ϊ  {   ItemName,     �˵��������ַ���
--                          ItemFunction, �˵����ú��������û����Ϊnil
--                          Visible       �Ƿ�ɼ�  0 ���ɼ� 1 �ɼ�, 2 �ɼ�����Ϊ��ǰѡ���ֻ����һ��Ϊ2��
--                                        ������ֻȡ��һ��Ϊ2�ģ�û�����һ���˵���Ϊ��ǰѡ���
--                                        ��ֻ��ʾ���ֲ˵�������´�ֵ��Ч��
--                                        ��ֵĿǰֻ�����Ƿ�˵�ȱʡ��ʾ������
--                       }
--          �˵����ú���˵����         itemfunction(newmenu,id)
--
--       ����ֵ
--              0 �������أ������˵�ѭ�� 1 ���ú���Ҫ���˳��˵��������в˵�ѭ��
--
-- numItem      �ܲ˵������
-- numShow      ��ʾ�˵���Ŀ������ܲ˵���ܶ࣬һ����ʾ���£�����Զ����ֵ
--                =0��ʾ��ʾȫ���˵���

-- (x1,y1),(x2,y2)  �˵���������ϽǺ����½����꣬���x2,y2=0,������ַ������Ⱥ���ʾ�˵����Զ�����x2,y2
-- isBox        �Ƿ���Ʊ߿�0 �����ƣ�1 ���ơ������ƣ�����(x1,y1,x2,y2)�ľ��λ��ư�ɫ���򣬲�ʹ�����ڱ����䰵
-- isEsc        Esc���Ƿ������� 0 �������ã�1������
-- Size         �˵��������С
-- color        �����˵�����ɫ����ΪRGB
-- selectColor  ѡ�в˵�����ɫ,
-- ;
-- ����ֵ  0 Esc����
--         >0 ѡ�еĲ˵���(1��ʾ��һ��)
--         <0 ѡ�еĲ˵�����ú���Ҫ���˳����˵�����������˳����˵�

function ShowMenu(menuItem, numItem, numShow, x1, y1, x2, y2, isBox, isEsc, size, color, selectColor)
    local w = 0
    local h = 0
    local i = 0
    local num = 0
    local newNumItem = 0
    lib.GetKey()
    local newMenu = {}
    for i = 1, numItem do
        if menuItem[i][3] > 0 then
            newNumItem = newNumItem + 1
            newMenu[newNumItem] = {menuItem[i][1], menuItem[i][2], menuItem[i][3], i}
        end
    end
    if newNumItem == 0 then
        return 0
    end
    if numShow == 0 or newNumItem < numShow then
        num = newNumItem
    else
        num = numShow
    end
    local maxlength = 0
    if x2 == 0 and y2 == 0 then
        for i = 1, newNumItem do
            if maxlength < string.len(newMenu[i][1]) then
                maxlength = string.len(newMenu[i][1])
            end
        end
        w = size * maxlength / 2 + 2 * CC.MenuBorderPixel
        h = (size + CC.RowPixel) * num + CC.MenuBorderPixel
    else
        w = x2 - x1
        h = y2 - y1
    end
    local start = 1
    local current = 1
    for i = 1, newNumItem do
        if newMenu[i][3] == 2 then
            current = i
        end
    end
    if numShow ~= 0 then
        current = 1
    end
    -- �޾Ʋ�����ս����ݼ�ʱ���ж�
    local In_Battle = false;
    if JY.Status == GAME_WMAP and numItem >= 8 and menuItem[8][1] == "�Զ�" then
        In_Battle = true
    end
    -- �޾Ʋ�����ս���˵��ж�
    local In_Tactics = false;
    if JY.Status == GAME_WMAP and numItem >= 3 and menuItem[3][1] == "�ȴ�" then
        In_Tactics = true
    end
    -- �����˵��ж�
    local In_Other = false;
    if JY.Status == GAME_WMAP and numItem >= 5 and menuItem[3][1] == "ҽ��" then
        In_Other = true
    end
    -- �޸�ս���˵�bx�Ա���ʾ��ݼ�
    if In_Battle == true or In_Tactics == true or In_Other == true then
        w = w + 15
    end
    local surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)
    local returnValue = 0
    if isBox == 1 then
        DrawBox(x1, y1, x1 + (w), y1 + (h), C_WHITE)
    end

    while true do
        lib.GetKey()
        if JY.Restart == 1 then
            break
        end
        if num ~= 0 then
            ClsN();
            lib.LoadSur(surid, 0, 0)
            if isBox == 1 then
                DrawBox(x1, y1, x1 + (w), y1 + (h), C_WHITE)
            end
        end
        for i = start, start + num - 1 do
            local drawColor = color
            if i == current then
                drawColor = selectColor
                lib.Background(x1 + CC.MenuBorderPixel, y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel),
                    x1 - CC.MenuBorderPixel + (w), y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + size,
                    128, color)
            end
            DrawString(x1 + CC.MenuBorderPixel, y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel),
                newMenu[i][1], drawColor, size)
            -- ��ݼ���ʾ��ʾ
            if In_Battle == true then
                if newMenu[i][1] == "����" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "A", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "�˹�" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "G", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "ս��" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "S", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "����" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "H", LimeGreen, CC.FontSmall)
                elseif newMenu[i][2] == War_TgrtsMenu then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "T", LimeGreen, CC.FontSmall)
                end
            end
            if In_Tactics == true then
                if newMenu[i][1] == "����" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "P", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "����" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "D", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "�ȴ�" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "W", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "����" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "J", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "��Ϣ" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "R", LimeGreen, CC.FontSmall)
                end
            end
            if In_Other == true then
                if newMenu[i][1] == "�ö�" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "V", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "�ⶾ" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "Q", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "ҽ��" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "F", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "��Ʒ" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "E", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "״̬" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "Z", LimeGreen, CC.FontSmall)
                end
            end
        end
        ShowScreen()
        lib.Delay(CC.Frame)
        local keyPress, ktype, mx, my = WaitKey(1)

        if keyPress == VK_ESCAPE or ktype == 4 then
            -- Esc �� �˳�
            if isEsc == 1 then
                break
                -- return 0
            end
        elseif keyPress == VK_DOWN or ktype == 7 then -- Down
            current = current + 1;
            if current > (start + num - 1) then
                start = start + 1;
            end
            if current > newNumItem then
                start = 1;
                current = 1;
            end
        elseif keyPress == VK_UP or ktype == 6 then -- Up
            current = current - 1;
            if current < start then
                start = start - 1;
            end
            if current < 1 then
                current = newNumItem;
                start = current - num + 1;
            end
        elseif keyPress == VK_RIGHT then
            current = current + 10
            if start + num - 1 < current then
                start = start + 10
            end
            if newNumItem < current + start then -- Alungky �޸�������ʱ��������BUG
                current = newNumItem
                start = current - num + 1
            end
        elseif keyPress == VK_LEFT then
            current = current - 10
            if current < start then
                start = start - 10
            end
            if current < 1 then
                start = 1
                current = 1
            elseif current < num then -- Alungky �޸�������ʱ��������BUG
                start = 1
            end
            -- �޾Ʋ�����ս����ݼ�
            -- ����
        elseif In_Battle == true and keyPress == VK_A and menuItem[2][3] == 1 then
            -- local r=War_FightMenu();
            -- local r=War_FightMenu1();
            -- if r==1 then
            -- returnValue= -2;
            -- break;
            -- end
            -- ClsN();
            -- lib.LoadSur(surid,0,0);
            -- if isBox==1 then
            --	DrawBox(x1,y1,x1+w,y1+h,C_WHITE);
            -- end
            -- 1-9ֱ�ӹ���
        elseif In_Battle == true and (keyPress >= 49 and keyPress <= 57) and menuItem[2][3] == 1 then
            local r = War_FightMenu(nil, nil, keyPress - 48);
            if r == 1 then
                returnValue = -2;
                break
            end
            ClsN();
            lib.LoadSur(surid, 0, 0);
            if isBox == 1 then
                DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
            end
            -- �˹�
        elseif In_Battle == true and keyPress == VK_G then
            local r = War_YunGongMenu();
            if r == 20 then
                returnValue = 20;
                break
            elseif r == 10 then
                returnValue = 10;
                break
            end
            ClsN();
            lib.LoadSur(surid, 0, 0);
            if isBox == 1 then
                DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
            end
            -- ս��
        elseif In_Battle == true and keyPress == VK_S then
            local r = War_TacticsMenu();
            if r == 1 then
                returnValue = -4;
                break
            elseif r == 20 then
                returnValue = 20;
                break
            end
            ClsN();
            lib.LoadSur(surid, 0, 0);
            if isBox == 1 then
                DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
            end
            -- ����
        elseif In_Battle == true and keyPress == VK_H then
            local r = War_OtherMenu();
            if r == 1 then
                returnValue = -4;
                break
            elseif r == 20 then
                returnValue = 20;
                break
            end
            ClsN();
            lib.LoadSur(surid, 0, 0);
            if isBox == 1 then
                DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
            end
            -- �ö�
        elseif (In_Battle == true or In_Other == true) and keyPress == VK_V and menuItem[5][3] == 1 then
            local r = War_PoisonMenu();
            if r == 1 then
                returnValue = -5;
                break
            end
            ClsN();
            lib.LoadSur(surid, 0, 0);
            if isBox == 1 then
                DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
            end
            -- �ⶾ
        elseif (In_Battle == true or In_Other == true) and keyPress == VK_Q and menuItem[5][3] == 1 then
            local r = War_DecPoisonMenu();
            if r == 1 then
                returnValue = -6;
                break
            end
            ClsN();
            lib.LoadSur(surid, 0, 0);
            if isBox == 1 then
                DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
            end
            -- ҽ��
        elseif (In_Battle == true or In_Other == true) and keyPress == VK_F and menuItem[5][3] == 1 then
            local r = War_DoctorMenu();
            if r == 1 then
                returnValue = -7;
                break
            end
            ClsN();
            lib.LoadSur(surid, 0, 0);
            if isBox == 1 then
                DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
            end
            -- ��Ʒ
        elseif (In_Battle == true or In_Other == true) and keyPress == VK_E and menuItem[5][3] == 1 then
            local r = War_ThingMenu();
            if r == 1 then
                returnValue = -8;
                break
            end
            ClsN();
            lib.LoadSur(surid, 0, 0);
            if isBox == 1 then
                DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
            end
            -- ״̬
        elseif (In_Battle == true or In_Other == true) and keyPress == VK_Z then
            local r = War_StatusMenu();
            if r == 1 then
                returnValue = -9;
                break
            end
            ClsN();
            lib.LoadSur(surid, 0, 0);
            if isBox == 1 then
                DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
            end
            -- ��Ϣ
        elseif (In_Battle == true or In_Tactics == true) and keyPress == VK_R then
            local r = War_RestMenu();
            if r == 1 then
                returnValue = -10;
                break
            end
            ClsN();
            lib.LoadSur(surid, 0, 0);
            if isBox == 1 then
                DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
            end
            -- ��ɫָ��
        elseif In_Battle == true and keyPress == VK_T and menuItem[6][3] == 1 then
            local r = War_TgrtsMenu();
            if r == 1 then
                returnValue = -11;
                break
            elseif r == 20 then
                returnValue = 20
                break
            end

            ClsN();
            lib.LoadSur(surid, 0, 0);
            if isBox == 1 then
                DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
            end
            -- C�鿴
        elseif In_Battle == true and keyPress == VK_C then
            local r = MapWatch();
            ClsN();
            lib.LoadSur(surid, 0, 0);
            if isBox == 1 then
                DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
            end
            -- ����
        elseif (In_Battle == true or In_Tactics == true) and keyPress == VK_P then
            local r = War_ActupMenu();
            if In_Battle == true then
                returnValue = -4;
            else
                returnValue = 5;
            end
            break
            ClsN();
            lib.LoadSur(surid, 0, 0);
            if isBox == 1 then
                DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
            end
            -- ����
        elseif (In_Battle == true or In_Tactics == true) and keyPress == VK_D then
            local r = War_DefupMenu();
            if In_Battle == true then
                returnValue = -4;
            else
                returnValue = 5;
            end
            break
            ClsN();
            lib.LoadSur(surid, 0, 0);
            if isBox == 1 then
                DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
            end
            -- �ȴ�
        elseif (In_Battle == true or In_Tactics == true) and keyPress == VK_W then
            local r = War_Wait();
            if In_Battle == true then
                returnValue = -4;
            else
                returnValue = 5;
            end
            break
            ClsN();
            lib.LoadSur(surid, 0, 0);
            if isBox == 1 then
                DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
            end
            -- ����
        elseif (In_Battle == true or In_Tactics == true) and keyPress == VK_J then
            War_Focus()
            if In_Battle == true then
                returnValue = 20;
            else
                returnValue = 6;
            end
            break
            ClsN();
            lib.LoadSur(surid, 0, 0);
            if isBox == 1 then
                DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
            end
        else
            local mk = false;
            if ktype == 2 or ktype == 3 then -- ѡ��
                if mx >= x1 and mx <= x1 + w and my >= y1 and my <= y1 + h then
                    current = start + math.modf((my - y1 - CC.MenuBorderPixel) / (size + CC.RowPixel))
                    mk = true;
                end
            end
            -- ѡ��ȷ��
            if keyPress == VK_SPACE or keyPress == VK_RETURN or ktype == 5 or (ktype == 3 and mk) then
                if newMenu[current][2] == nil then
                    returnValue = newMenu[current][4];
                    break
                elseif newMenu[current][2] == SelectNeiGongMenu then
                    local id = WAR.Person[WAR.CurID]["������"]
                    -- �˹���������
                    if JY.Person[id]["����"] < 2000 then
                        DrawStrBoxWaitKey("�������㣬�޷��˹�", C_RED, CC.DefaultFont, nil, LimeGreen)
                        -- �˹���������
                    elseif JY.Person[id]["����"] < 20 then
                        DrawStrBoxWaitKey("�������㣬�޷��˹�", C_RED, CC.DefaultFont, nil, LimeGreen)
                    else
                        local r = newMenu[current][2](newMenu, current);
                        -- ���������˵�ȫ������20��Ϊ�ж�����
                        if r == 20 then
                            returnValue = 20;
                            break
                        end
                        ClsN();
                        lib.LoadSur(surid, 0, 0);
                        if isBox == 1 then
                            DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
                        end
                    end
                elseif newMenu[current][2] == SelectQingGongMenu then
                    local id = WAR.Person[WAR.CurID]["������"]
                    -- �˹���������
                    if JY.Person[id]["����"] < 20 then
                        DrawStrBoxWaitKey("�������㣬�޷��˹�", M_DeepSkyBlue, CC.DefaultFont, nil, LimeGreen)
                    else
                        local r = newMenu[current][2](newMenu, current);
                        if r == 10 then
                            returnValue = 10;
                            break
                        end
                        ClsN();
                        lib.LoadSur(surid, 0, 0);
                        if isBox == 1 then
                            DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
                        end
                    end
                else
                    local r = newMenu[current][2](newMenu, current); -- ���ò˵�����

                    -- �޾Ʋ�������дһ������ķ����߼�����Ӧ�˹�
                    if r == 1 then
                        returnValue = -newMenu[current][4];
                        break
                        -- ���������˵�ȫ������20��Ϊ�ж�����
                    elseif In_Battle == true and r == 20 then
                        returnValue = 20;
                        break
                    elseif In_Battle == true and r == 10 then
                        returnValue = 10;
                        break
                    end
                    ClsN();
                    lib.LoadSur(surid, 0, 0);
                    if isBox == 1 then
                        DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
                    end
                end
            end
        end
    end
    lib.FreeSur(surid)
    return returnValue
end

-- ����������ShowMenuһ������һЩ�ر�Ľ�������˵��
-- menu ÿ����������ֵ��1���ƣ�2ִ�к�����3��ʾ��ʽ(0��ɫ��ѡ��1������ʾ��2����ʾ, 3��ɫ����ѡ��)
-- itemNum �˵��ĸ�����ͨ���ڵ��õ�ʱ�� #menu�Ϳ�����
-- numShow ÿ����ʾ�Ĳ˵�����
-- showRow һ��������ʾ������������������ʾ�˵������ﲻ��һ������������������Զ���Ӧ���ֵ
-- str �Ǳ�������֣���nil����ʾ
-- ѡ����
function ShowMenu2(menu, itemNum, numShow, showRow, x1, y1, x2, y2, isBox, isEsc, size, color, selectColor, str,
    selIndex) -- ͨ�ò˵�����
    local w = 0;
    local h = 0; -- �߿�Ŀ��
    local i, j = 0, 0;
    local col = 0; -- ʵ�ʵ���ʾ�˵���
    local row = 0; -- ����

    lib.GetKey();
    Cls();

    -- ��һ���µ�table
    local menuItem = {};
    local numItem = 0; -- ��ʾ������

    -- �ѿ���ʾ�Ĳ��ַŵ���table
    for i, v in pairs(menu) do
        if v[3] ~= 2 then
            numItem = numItem + 1;
            menuItem[numItem] = {v[1], v[2], v[3], i}; -- ע���4��λ�ã�����i��ֵ
        end
    end

    -- ����ʵ����ʾ�Ĳ˵�����
    if numShow == 0 or numShow > numItem then -- ���ÿ����ʾ�Ĳ˵�������0����ÿ����ʾ�Ĳ˵��������� >�˵�������
        col = numItem; -- ʵ����ʾ���� = ������
        row = 1; -- ��������1
    else
        col = numShow; -- ʵ����ʾ���� = ��ʾ���� 
        row = math.modf((numItem - 1) / col); -- ������ = ���ܲ˵����� - 1��/ʵ����ʾ����
    end

    if showRow > row + 1 then -- ������� > �������� + 1
        showRow = row + 1; -- �������  = ������ + 1
    end

    -- ����߿�ʵ�ʿ��
    local maxlength = 0;
    if x2 == 0 and y2 == 0 then
        for i = 1, numItem do
            if string.len(menuItem[i][1]) > maxlength then
                maxlength = string.len(menuItem[i][1]);
            end
        end
        w = (size * maxlength / 2 + CC.RowPixel) * col + 2 * CC.MenuBorderPixel;
        h = showRow * (size + CC.RowPixel) + 2 * CC.MenuBorderPixel;
    else
        w = x2 - x1;
        h = y2 - y1;
    end

    if x1 == -1 then
        x1 = (CC.ScreenW - w) / 2;
    end
    if y1 == -1 then
        y1 = (CC.ScreenH - h + size) / 2;
    end

    local start = 0; -- ��ʾ�ĵ�һ��

    local curx = 1; -- ��ǰѡ����
    local cury = 0;
    local current = curx + cury * numShow; -- ѡ���� = ��ǰѡ��+ҳ��*ÿ����ʾ�Ĳ˵�����

    -- Ĭ����ѡ��
    if selIndex ~= nil and selIndex > 0 then
        current = selIndex;
        curx = math.fmod((selIndex - 1), numShow) + 1;
        cury = (selIndex - curx) / numShow;
        if cury >= showRow / 2 then
            start = limitX(cury - showRow / 2, 0, row - showRow + 1);
        end
    end

    local returnValue = 0;
    if str ~= nil then
        DrawStrBox(-1, y1 - size - 2 * CC.MenuBorderPixel, str, color, size)
    end
    local surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)
    if isBox == 1 then
        DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
    end
    while true do
        lib.GetKey()
        if JY.Restart == 1 then
            break
        end
        if col ~= 0 then
            lib.LoadSur(surid, 0, 0)
            if isBox == 1 then
                DrawBox(x1, y1, x1 + (w), y1 + (h), C_WHITE)
            end
        end
        for i = start, showRow + start - 1 do
            for j = 1, col do
                local n = i * col + j;
                if n > numItem then
                    break
                end
                local drawColor = color; -- ���ò�ͬ�Ļ�����ɫ
                if menuItem[n][3] == 0 or menuItem[n][3] == 3 then
                    drawColor = M_DimGray
                end
                local xx = x1 + (j - 1) * (size * maxlength / 2 + CC.RowPixel) + CC.MenuBorderPixel
                local yy = y1 + (i - start) * (size + CC.RowPixel) + CC.MenuBorderPixel
                if n == current then
                    drawColor = selectColor;
                    lib.Background(xx, yy, xx + size * maxlength / 2, yy + size, 128, color)
                end
                DrawString(xx, yy, menuItem[n][1], drawColor, size);
            end
        end
        ShowScreen();
        local keyPress, ktype, mx, my = WaitKey(1)
        lib.Delay(CC.Frame);

        if keyPress == VK_ESCAPE or ktype == 4 then -- Esc �˳�
            if isEsc ~= nil and isEsc == 1 then
                cury = -2
                break
            else
                cury = -2
                break
            end
        elseif keyPress == VK_DOWN or ktype == 7 then -- Down
            if curx + (cury + 1) * col <= numItem then
                cury = cury + 1;
                if cury > row then
                    cury = row;
                elseif cury >= showRow / 2 and cury <= row - showRow / 2 + 1 and start <= row - showRow then
                    start = start + 1;
                end
            end
        elseif keyPress == VK_UP or ktype == 6 then -- Up
            cury = cury - 1;
            if cury < 0 then
                cury = 0;
            elseif cury >= showRow / 2 - 1 and cury < row - showRow / 2 and start > 0 then
                start = start - 1;
            end
        elseif keyPress == VK_RIGHT then -- RIGHT
            curx = curx + 1;
            if curx > col then
                curx = 1;
            elseif curx + cury * col > numItem then
                curx = 1;
            end
        elseif keyPress == VK_LEFT then -- LEFT
            curx = curx - 1;
            if curx < 1 then
                curx = col;
                if curx + cury * col > numItem then
                    curx = numItem - cury * col;
                end
            end
        else
            local mk = false;
            if ktype == 2 or ktype == 3 then -- ѡ��
                -- �޾Ʋ������Ӹ��߼��ж���ֹ����
                local re1, re2 = curx, cury;
                if mx >= x1 and mx <= x1 + w and my >= y1 and my <= y1 + h then
                    curx = math.modf((mx - x1 - CC.MenuBorderPixel) / (size * maxlength / 2 + CC.RowPixel)) + 1
                    cury = start + math.modf((my - y1 - CC.MenuBorderPixel) / (size + CC.RowPixel))
                    mk = true;
                end
                if (curx + cury * col) > #menuItem then
                    curx = re1
                    cury = re2
                    mk = false;
                end
            end

            if keyPress == VK_SPACE or keyPress == VK_RETURN or ktype == 5 or (ktype == 3 and mk) then
                current = curx + cury * col;
                if menuItem[current][3] == 3 then

                elseif menuItem[current][2] == nil then
                    returnValue = current;
                    break
                else
                    local r = menuItem[current][2](menuItem, current); -- ���ò˵�����
                    if r == 1 then
                        returnValue = -current;
                        break
                    else
                        lib.LoadSur(surid, 0, 0)
                        if isBox == 1 then
                            DrawBox(x1, y1, x1 + (w), y1 + (h), C_WHITE)
                        end
                    end
                end
            end
        end
        current = curx + cury * col;
    end
    lib.FreeSur(surid)

    -- ����ֵ�������ȡ��4��λ�õ�ֵ
    if returnValue > 0 then
        return menuItem[returnValue][4]
    else
        return returnValue
    end
end

-- �޾Ʋ����������ѡ��˵�
function ShowMenu3(menu, itemNum, numShow, showRow, x1, y1, size, color, selectColor)
    local w = 0;
    local h = 0; -- �߿�Ŀ��
    local i, j = 0, 0;
    local col = 0; -- ʵ�ʵ���ʾ�˵���
    local row = 0;

    lib.GetKey();
    Cls();

    -- ��һ���µ�table
    local menuItem = {};
    local numItem = 0; -- ��ʾ������

    -- �ѿ�ѡΪ��������ﱣ�浽�µ�table
    for i, v in pairs(menu) do
        if v[3] ~= 0 then
            numItem = numItem + 1;
            menuItem[numItem] = {v[1], v[2], v[3], i}; -- ע���4��λ�ã�����i��ֵ
        end
    end

    -- ����ʵ����ʾ�Ĳ˵�����
    if numShow == 0 or numShow > numItem then
        col = numItem;
        row = 1;
    else
        -- lieshu
        col = numShow;
        -- (��Ŀ����-1)/lieshu=����
        row = math.modf((numItem - 1) / col);
    end

    if showRow > row + 1 then
        showRow = row + 1;
    end

    -- ����߿�ʵ�ʿ��
    local maxlength = 0;

    for i = 1, numItem do
        if string.len(menuItem[i][1]) > maxlength then
            maxlength = string.len(menuItem[i][1]);
        end
    end
    w = (size * maxlength / 2 + CC.RowPixel * 2) * col + 2 * CC.MenuBorderPixel;
    h = showRow * (size + CC.RowPixel * 2) + 2 * CC.MenuBorderPixel;

    local start = 0; -- ��ʾ�ĵ�һ��

    local curx = 1; -- ��ǰѡ����
    local cury = 0;
    local current = curx + cury * numShow;

    local returnValue = 0;

    local surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)

    while true do
        lib.GetKey()
        if JY.Restart == 1 then
            break
        end
        if col ~= 0 then
            lib.LoadSur(surid, 0, 0)
        end
        -- ˵�����ڴ�
        -- DrawString(x1+(size+CC.RowPixel)*9-3,y1-(size+CC.RowPixel)*2-CC.RowPixel,"PgUp/PgDn/�����ַ�ҳ",LimeGreen,size);
        -- DrawString(x1+(size+CC.RowPixel)*8-50,y1-(size+CC.RowPixel)*1,"���ƻ�ɫΪһ�� ������ɫΪ�߽� ��ɫΪ����",LimeGreen,size);
        for i = start, showRow + start - 1 do
            for j = 1, col do
                local n = i * col + j;
                if n > numItem then
                    break
                end

                -- ���ò�ͬ�Ļ�����ɫ
                local drawColor = color;
                if menuItem[n][3] == 2 then
                    drawColor = M_DeepSkyBlue
                end
                if menuItem[n][1] == "�������" or menuItem[n][1] == "ɨ����ɮ" or menuItem[n][1] == "������" then
                    drawColor = C_RED
                end
                if menuItem[n][1] == "����" or menuItem[n][1] == "����" or menuItem[n][1] == "��Ѱ��" or
                    menuItem[n][1] == "���" or menuItem[n][1] == "����ɮ" or menuItem[n][1] == "����" or
                    menuItem[n][1] == "��ң��" or menuItem[n][1] == "��Ħ" or menuItem[n][1] == "½��" or
                    menuItem[n][1] == "����" or menuItem[n][1] == "˾��ժ��" or menuItem[n][1] == "������" or
                    menuItem[n][1] == "��޿" or menuItem[n][1] == "�żһ�" or menuItem[n][1] == "����ˮ" then
                    drawColor = M_Plum
                end
                local xx = x1 + (j - 1) * (size * maxlength / 2 + CC.RowPixel * 2) + CC.MenuBorderPixel
                local yy = y1 + (i - start) * (size + CC.RowPixel * 2) + CC.MenuBorderPixel
                if n == current then
                    drawColor = selectColor;
                    lib.Background(xx - 5, yy - 5, xx + size * maxlength / 2, yy + size + 5, 128, color)
                end
                DrawString(xx, yy, menuItem[n][1], drawColor, size);

            end
        end
        ShowScreen();
        local keyPress, ktype, mx, my = WaitKey(1)
        local mk = false;
        lib.Delay(CC.Frame);

        if keyPress == VK_DOWN then -- Down
            cury = cury + 1;
            if cury == showRow then
                cury = 0
            elseif curx + cury * col > numItem then
                cury = 15
            end
        elseif keyPress == VK_UP then -- Up
            if cury ~= 15 then
                cury = cury - 1;
                if cury < 0 then
                    cury = showRow - 1;
                end
            else
                if curx + row * col > numItem then
                    cury = row - 1
                else
                    cury = row
                end
            end
        elseif keyPress == VK_RIGHT then -- RIGHT
            curx = curx + 1;
            if curx > col then
                curx = 1;
            elseif curx + cury * col > numItem then
                curx = 1;
            end
        elseif keyPress == VK_LEFT then -- LEFT
            curx = curx - 1;
            if curx < 1 then
                curx = col;
                if curx + cury * col > numItem then
                    curx = numItem - cury * col;
                end
            end
        elseif keyPress == VK_PGUP or ktype == 6 then -- PgUp �� ��������
            if start == 15 then
                start = start - 15;
                curx = 1
                cury = 0
                mk = true;
            end
        elseif keyPress == VK_PGDN or ktype == 7 then -- PgDn �� ��������	
            if start == 0 then
                start = start + 15;
                curx = 1
                cury = 15
                mk = true;
            end
        else
            if ktype == 2 or ktype == 3 then -- ѡ��
                -- �޾Ʋ������Ӹ��߼��ж���ֹ����
                local re1, re2 = curx, cury;
                if mx >= x1 and mx <= x1 + w and my >= y1 and my <= y1 + h then
                    curx = math.modf((mx - x1 - CC.MenuBorderPixel) / (size * maxlength / 2 + CC.RowPixel * 2)) + 1
                    cury = start + math.modf((my - y1 - CC.MenuBorderPixel) / (size + CC.RowPixel * 2))
                    mk = true;
                end
                if (curx + cury * col) > #menuItem then
                    curx = re1
                    cury = re2
                    mk = false;
                end
            end
            -- �ո񣬻س���
            if keyPress == VK_SPACE or keyPress == VK_RETURN or ktype == 5 or (ktype == 3 and mk) then
                current = curx + cury * col;
                if menuItem[current][3] == 3 then

                elseif menuItem[current][2] == nil then
                    local ys = showCXStatic(menuItem[current][4])
                    if ys then
                        returnValue = current
                        break
                    end
                else
                    local r = menuItem[current][2](menuItem, current)
                    if r == 1 then
                        returnValue = -current;
                        break
                    else
                        lib.LoadSur(surid, 0, 0)
                    end
                end
            end
        end
        current = curx + cury * col;
    end
    lib.FreeSur(surid)

    -- ����ֵ�������ȡ��4��λ�õ�ֵ
    if returnValue > 0 then
        return menuItem[returnValue][4]
    else
        return returnValue
    end
end

function ShowMenu4(menu, menunum, rownum, x1, y1, x2, y2, isBox, isEsc, size, color, selectColor, Title1, color2,
    color3, linenum, flag)
    local w = 0
    local h = 0
    local i = 0
    local num = 0
    local bx = CC.ScreenW / 1360
    local by = CC.ScreenH / 768
    menunum = #menu
    lib.GetKey()
    local menu1 = {}
    for i = 1, menunum do
        if menu[i][3] > 0 then
            num = num + 1
            menu1[num] = {menu[i][1], menu[i][2], menu[i][3], i}
        end
    end
    if num == 0 then
        return 1
    end
    local maxlength = 0
    for i = 1, num do
        if maxlength < string.len(menu1[i][1]) then
            maxlength = string.len(menu1[i][1])
        end
    end
    if linenum == nil then
        linenum = math.modf((num - 1) / rownum + 1)
    end
    if x1 == -2 and y1 == -2 or x2 == -2 and y2 == -2 then
        w = (size * maxlength / 2 + CC.MenuBorderPixel) * rownum + CC.MenuBorderPixel
        if w < size * string.len(Title1 or "") / 2 + size / 2 + 2 * CC.MenuBorderPixel then
            w = size * string.len(Title1 or "") / 2 + size / 2 + 2 * CC.MenuBorderPixel
        end
        if Title1 == nil then
            h = (size + CC.MenuBorderPixel * 2 + by * 5) * linenum + CC.MenuBorderPixel
        else
            h = (size + CC.MenuBorderPixel * 2 + by * 5) * (linenum + 1) + CC.MenuBorderPixel + by * 10
        end
    else
        w = x2 - x1
        h = y2 - y1
    end
    if x1 == -2 and y1 == -2 and x2 == -2 and y2 == -2 then
        x1 = math.modf(CC.ScreenW / 2 - w / 2)
        y1 = math.modf(CC.ScreenH / 2 - h / 2)
    elseif x1 == -2 and y1 == -2 then
        x1 = x2 - w
        y1 = y2 - h
    end
    local xx = x1 + w / rownum / 2 - size * maxlength / 4
    local start = 1
    local tb = 1
    local keyPress = -1
    local tid = 0
    if isBox == 1 then
        -- DrawBox(x1,y1,x1+w,y1+h,C_WHITE)
    end
    local surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)
    while true do
        lib.GetKey()
        if JY.Restart == 1 then
            break
        end
        if flag ~= nil then
            Cls(x1, y1, x1 + w, y1 + h)
        else
            Cls()
        end
        lib.LoadSur(surid, 0, 0)
        lib.LoadPNG(91, 24 * 2, -1, -1, 1)
        lib.LoadPNG(91, 119 * 2, CC.ScreenW / 2 + bx * 20, by * 45, 2, 0, 80)
        local cx, cy = lib.GetPNGXY(91, 114 * 2)
        lib.LoadPNG(91, 140 * 2, CC.ScreenW / 2 - cx / 2, CC.DefaultFont - cy / 4, 1)
        if Title1 ~= nil then
            DrawString(-1, y1 + CC.MenuBorderPixel, Title1, selectColor, size)
        end

        local over = limitX(start + rownum * linenum - 1, start, num)
        local yy = y1 + size + 2 * CC.MenuBorderPixel + 15
        if Title1 == nil then
            yy = y1 + 10
        end
        for i = start, over do
            local colorS = color
            local row = rownum - 1
            if math.fmod(i, rownum) ~= 0 then
                row = math.fmod(i, rownum) - 1
            end
            if i == tb then
                colorS = selectColor
                lib.Background(xx + row * w / rownum - bx * 3, yy - 3, xx + row * w / rownum + maxlength * size / 2 + bx * 3, yy + size + by * 8, 128, color)
            end
            if menu1[i][3] == 2 and color2 ~= nil then
                colorS = color2
            end
            if menu1[i][3] == 3 and color3 ~= nil then
                colorS = color3
            end
            DrawString(xx + row * w / rownum, yy, menu1[i][1], colorS, size)
            if math.fmod(i, rownum) == 0 then
                yy = yy + size + CC.MenuBorderPixel * 2 + 5
            end
        end
        ShowScreen()
        lib.Delay(CC.Frame)
        local keyPress, ktype, mx, my = lib.GetKey();
        local moda = math.fmod(num, rownum)
        if moda == 0 then
            moda = rownum
        end
        local modc = math.fmod(tb, rownum)
        if modc == 0 then
            modc = rownum
        end
        -- if isEsc == 1 and keyPress==VK_ESCAPE then                  --Esc �˳�
        --	break;
        if keyPress == VK_ESCAPE or ktype == 4 then
            return 0
        elseif keyPress == VK_DOWN or ktype == 7 then -- Down
            tb = tb + rownum
            if tb > over and over < num then
                start = start + rownum
            elseif tb > num then
                start = 1
                tb = modc
            end
        elseif keyPress == VK_UP or ktype == 6 then -- Up
            tb = tb - rownum
            if tb < start and start > 1 then
                start = start - rownum
            elseif tb < 1 then
                start = limitX(num - (linenum - 1) * rownum - moda + 1, 1, num)
                if moda >= modc then
                    tb = num + modc - moda
                else
                    tb = num - moda - rownum + modc
                end
            end
        elseif keyPress == VK_RIGHT then
            tb = tb + 1
            if tb > over and over < num then
                start = start + rownum
            elseif tb > num then
                start = 1
                tb = 1
            end
        elseif keyPress == VK_LEFT then
            tb = tb - 1
            if tb < start and start > 1 then
                start = start - rownum
            elseif tb < 1 then
                start = limitX(num - (linenum - 1) * rownum - moda + 1, 1, num)
                tb = num
            end
        elseif keyPress == VK_SPACE or keyPress == VK_RETURN then
            if menu1[tb][2] == nil and menu1[tb][3] == 1 then
                tid = menu1[tb][4];
                break
            elseif menu1[tb][3] == 1 then
                local r = menu1[tb][2](menu1, tb); -- ���ò˵�����
                if r == 1 then
                    tid = -menu1[tb][4];
                    break
                else
                    Cls(x1, y1, x1 + w, y1 + h);
                    if isBox == 1 then
                        DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
                    end
                end
            end
        else
            local kind = 0
            local pd = false
            if mx > x1 and mx < x1 + w and my > y1 and my < y1 + h then
                pd = true
                if Title1 == nil and Title2 == nil then
                    tb = start - 1 + math.modf((mx - xx) / (w / rownum) + 1) + rownum *
                             math.modf((my - y1 - 10) / (size + CC.MenuBorderPixel * 2 + 5))
                else
                    tb = start - 1 + math.modf((mx - xx) / (w / rownum) + 1) + rownum *
                             math.modf(
                            (my - y1 - size - 2 * CC.MenuBorderPixel - 15) / (size + CC.MenuBorderPixel * 2 + 5))
                end
            end
            if pd == true and ktype == 3 then
                if menu1[tb][2] == nil and menu1[tb][3] == 1 then
                    tid = menu1[tb][4];
                    break
                elseif menu1[tb][3] == 1 then
                    local r = menu1[tb][2](menu1, tb); -- ���ò˵�����
                    if r == 1 then
                        tid = -menu1[tb][4];
                        break
                    else
                        Cls(x1, y1, x1 + w, y1 + h);
                        if isBox == 1 then
                            DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
                        end
                    end
                end
            end
        end
    end
    lib.FreeSur(surid)
    return tid
end

function ShowMenu5(menu, itemNum, numShow, showRow, str, r) -- ͨ�ò˵�����

    local bx, by = CC.ScreenW / 1360, CC.ScreenH / 768
    local w = 0;
    local h = 0; -- �߿�Ŀ��
    local i, j = 0, 0;
    local pnum = 0; -- ʵ�ʵ���ʾ�˵���
    local page = 0;
    local size = CC.DefaultFont * 0.9
    lib.GetKey();
    Cls();
    local x1, y1, x2, y2 = CC.ScreenW / 6, CC.ScreenH / 10, 0, 0
    local isBox = 0
    -- ��һ���µ�table
    local menu1 = {};
    local num = 0; -- ��ʾ������
    local isEsc = 1
    local color = C_WHITE1
    local selectColor = C_RED
    -- �ѿ���ʾ�Ĳ��ַŵ���table
    for i, v in pairs(menu) do
        if v[3] ~= 2 then
            num = num + 1;
            menu1[num] = {v[1], v[2], v[3], i}; -- ע���4��λ�ã�����i��ֵ
        end
    end

    -- ����ʵ����ʾ�Ĳ˵�����
    if numShow == 0 or numShow > num then
        pnum = num;
        page = 1;
    else
        pnum = numShow;
        page = math.modf((num - 1) / pnum);
    end

    if showRow > page + 1 then
        showRow = page + 1;
    end

    -- ����߿�ʵ�ʿ��
    local maxlength = 0;
    if x2 == 0 and y2 == 0 then
        for i = 1, num do
            if string.len(menu1[i][1]) > maxlength then
                maxlength = string.len(menu1[i][1]);
            end
        end
        w = (size * maxlength / 2 + CC.RowPixel) * pnum + 2 * CC.MenuBorderPixel;
        h = showRow * (size + CC.RowPixel) + 2 * CC.MenuBorderPixel;
    else
        w = x2 - x1;
        h = y2 - y1;
    end

    if x1 == -1 then
        x1 = (CC.ScreenW - w) / 2;
    end
    if y1 == -1 then
        y1 = (CC.ScreenH - h + size) / 2;
    end

    local start = 0; -- ��ʾ�ĵ�һ��

    local tb = 1; -- ��ǰѡ����
    local cury = 0;
    local cot = tb + cury * numShow;

    -- Ĭ����ѡ��
    if r ~= nil and r > 0 then
        cot = r;
        tb = math.fmod((r - 1), numShow) + 1;
        cury = (r - tb) / numShow;
        if cury >= showRow / 2 then
            start = limitX(cury - showRow / 2, 0, page - showRow + 1);
        end
    end

    local returnValue = 0;

    local surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)
    if isBox == 1 then
        DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
    end
    while true do
        lib.GetKey()
        if JY.Restart == 1 then
            break
        end
        lib.LoadPNG(91, 273 * 2, -1, -1, 1)
        if str ~= nil then
            DrawString(CC.ScreenW / 2 - string.len(str) / 4 * size * 1.5, by * 15, str, C_ORANGE, size * 1.5, CC.FONT1);
        end
        if pnum ~= 0 then
            if isBox == 1 then
                DrawBox(x1, y1, x1 + (w), y1 + (h), C_WHITE)
            end
        end

        for i = start, showRow + start - 1 do
            for j = 1, pnum do
                local n = i * pnum + j;

                if n > num then
                    break
                end
                local drawColor = color; -- ���ò�ͬ�Ļ�����ɫ
                if menu1[n][3] == 0 or menu1[n][3] == 3 then
                    drawColor = M_DimGray
                end
                local xx = x1 + (j - 1) * (size * maxlength / 2 + CC.RowPixel) * 1.15 + CC.MenuBorderPixel
                local yy = y1 + (i - start) * (size + CC.RowPixel) * 1.7 + CC.MenuBorderPixel
                lib.Background(xx - size * 2.7, yy, xx + size * 3, yy + size * 1.8, 50)
                local cl = C_WHITE
                if n == cot then
                    drawColor = selectColor;
                    -- lib.Background(xx-string.len(menu1[n][1])/4*size, yy, xx + size*maxlength/2, yy + size, 128, color)
                end

                DrawString(xx - string.len(menu1[n][1]) / 4 * size, yy + size / 2, menu1[n][1], drawColor, size);
            end
        end
        ShowScreen();
        local keyPress, ktype, mx, my = WaitKey(1)
        lib.Delay(CC.Frame);

        if keyPress == VK_ESCAPE or ktype == 4 then -- Esc �˳�
            if isEsc ~= nil and isEsc == 1 then
                cury = -2
                break
            else
                cury = -2
                break
            end
        elseif keyPress == VK_DOWN or ktype == 7 then -- Down
            if tb + (cury + 1) * pnum <= num then
                cury = cury + 1;
                if cury > page then
                    cury = page;
                elseif cury >= showRow / 2 and cury <= page - showRow / 2 + 1 and start <= page - showRow then
                    start = start + 1;
                end
            end
        elseif keyPress == VK_UP or ktype == 6 then -- Up
            cury = cury - 1;
            if cury < 0 then
                cury = 0;
            elseif cury >= showRow / 2 - 1 and cury < page - showRow / 2 and start > 0 then
                start = start - 1;
            end
        elseif keyPress == VK_RIGHT then -- RIGHT
            tb = tb + 1;
            if tb > pnum then
                tb = 1;
            elseif tb + cury * pnum > num then
                tb = 1;
            end
        elseif keyPress == VK_LEFT then -- LEFT
            tb = tb - 1;
            if tb < 1 then
                tb = pnum;
                if tb + cury * pnum > num then
                    tb = num - cury * pnum;
                end
            end
        else
            local mk = false;
            if ktype == 2 or ktype == 3 then -- ѡ��
                -- �޾Ʋ������Ӹ��߼��ж���ֹ����
                local re1, re2 = tb, cury;
                -- local y1 = y1-size
                local h = h
                if mx >= x1 and mx <= x1 + w and my >= y1 and my <= y1 + h then
                    -- tb = math.modf((mx-x1-CC.MenuBorderPixel)/(size*maxlength/2+CC.RowPixel)) + 1
                    -- cury = start + math.modf((my - y1 - CC.MenuBorderPixel) / (size + CC.RowPixel))
                    -- mk = true;
                end
                if (tb + cury * pnum) > #menu1 then
                    tb = re1
                    cury = re2
                    mk = false;
                end
            end

            if keyPress == VK_SPACE or keyPress == VK_RETURN or ktype == 5 or (ktype == 3 and mk) then
                cot = tb + cury * pnum;
                if menu1[cot][3] == 3 then
                elseif menu1[cot][2] == nil then
                    returnValue = cot;
                    break
                else
                    local r = menu1[cot][2](menu1, cot); -- ���ò˵�����
                    if r == 1 then
                        returnValue = -cot;
                        break
                    else
                        lib.LoadSur(surid, 0, 0)
                        if isBox == 1 then
                            DrawBox(x1, y1, x1 + (w), y1 + (h), C_WHITE)
                        end
                    end
                end
            end
        end
        cot = tb + cury * pnum;
    end
    lib.FreeSur(surid)
    -- ����ֵ�������ȡ��4��λ�õ�ֵ
    if returnValue > 0 then
        return menu1[returnValue][4]
    else
        return returnValue
    end
end
------------------------------------------------------------------------------------
--------------------------------------��Ʒʹ��---------------------------------------
-- ��Ʒʹ��ģ��
-- ��ǰ��Ʒid
-- ����1 ʹ������Ʒ�� 0 û��ʹ����Ʒ��������ĳЩԭ����ʹ��
function UseThing(id)
    return DefaultUseThing(id);
end

-- ȱʡ��Ʒʹ�ú�����ʵ��ԭʼ��ϷЧ��
-- id ��Ʒid
function DefaultUseThing(id) -- ȱʡ��Ʒʹ�ú���
    if JY.Thing[id]["����"] == 0 then
        return UseThing_Type0(id);
    elseif JY.Thing[id]["����"] == 1 then
        return UseThing_Type1(id);
    elseif JY.Thing[id]["����"] == 2 then
        return UseThing_Type2(id);
    elseif JY.Thing[id]["����"] == 3 then
        return UseThing_Type3(id);
    elseif JY.Thing[id]["����"] == 4 then
        return UseThing_Type4(id);
    end
end

-- ������Ʒ�������¼�
function UseThing_Type0(id)
    -- �ϲ�����
    if id == 286 then
        local jyzj = 0
        for j = 1, CC.MyThingNum do
            if JY.Base["��Ʒ" .. j] == 287 then
                jyzj = 1;
                break
            end
        end
        if jyzj == 1 then
            instruct_2(286, -1)
            instruct_2(287, -1)
            instruct_2(84, 1)
        end
        return 0;
    end
    if id == 287 then
        local jyzj = 0
        for j = 1, CC.MyThingNum do
            if JY.Base["��Ʒ" .. j] == 286 then
                jyzj = 1;
                break
            end
        end
        if jyzj == 1 then
            instruct_2(286, -1)
            instruct_2(287, -1)
            instruct_2(84, 1)
        end
        return 0;
    end
    if JY.SubScene >= 0 then
        local x = JY.Base["��X1"] + CC.DirectX[JY.Base["�˷���"] + 1];
        local y = JY.Base["��Y1"] + CC.DirectY[JY.Base["�˷���"] + 1];
        local d_num = GetS(JY.SubScene, x, y, 3)
        if d_num >= 0 then
            JY.CurrentThing = id;
            EventExecute(d_num, 2); -- ��Ʒ�����¼�
            JY.CurrentThing = -1;
            return 1;
        else
            return 0;
        end
    end
    -- �ϵ��鵤�¼�
    if id == 315 then
        local dld = 0
        for j = 1, CC.MyThingNum do
            if JY.Base["��Ʒ" .. j] == 314 and JY.Base["��Ʒ" .. j] == 231 and JY.Base["��Ʒ" .. j] == 26 then
                dld = 1;
                break
            end
        end
        if dld == 1 then
            instruct_2(314, -1)
            instruct_2(231, -1)
            instruct_2(26, -1)
            instruct_2(316, 1)
        end
        return 0;
    end
end

-- �ж�һ�����Ƿ����װ��������һ����Ʒ
-- ���� true����������false����
function CanUseThing(id, personid)
    local str = ""
    -- �żһԵ�ר��װ��
    if JY.Thing[id]["����������"] == 651 then
        if personid == 0 and JY.Base["����"] == 651 then
            return true
        else
            return false
        end
    end
    -- if ZhongYongZD(personid) and (id == 118 or id == 235) then 
    -- return true
    -- end
    -- �������࣬��������ؼ�
    if (match_ID(personid, 637) or match_ID(personid, 9900)) and JY.Thing[id]["����"] == 2 then
        return true
        -- ؤ���������������뽵��
    elseif match_ID(personid, 9936) and (id == 86 or id == 167) then
        return true
        -- ����ѧʥ��
    elseif id == 70 and personid == 0 then
        return true
        -- ���촩װ��
    elseif match_ID(personid, 104) and JY.Thing[id]["װ��λ��"] >= 0 then
        return true
        -- ��Գװ����Գ
    elseif match_ID(personid, 185) and id == 326 then
        return true
        -- ����װ���廨��
    elseif match_ID(personid, 721) and id == 349 then
        Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
        if DrawStrBoxYesNo(-1, -1, "װ������Ʒ��Ҫ�Թ����Ƿ����װ��?", C_WHITE, CC.DefaultFont) ==
            false then
            return 0
        else
            lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_RED, 128)
            ShowScreen()
            lib.Delay(80)
            lib.ShowSlow(15, 1)
            Cls()
            lib.ShowSlow(50, 0)
            JY.Person[personid]["�Ա�"] = 2
            JY.Person[personid]["������"] = 721
            JY.Person[personid]["ͷ�����"] = 322
            JY.Person[personid]["���ж���֡��2"] = 16
            JY.Person[personid]["���ж����ӳ�2"] = 14
            JY.Person[personid]["�书��Ч�ӳ�2"] = 14
            local add, str = AddPersonAttrib(personid, "������", -20)
            DrawStrBoxWaitKey(JY.Person[personid]["����"] .. str, C_ORANGE, CC.DefaultFont)
            add, str = AddPersonAttrib(personid, "������", -30)
            DrawStrBoxWaitKey(JY.Person[personid]["����"] .. str, C_ORANGE, CC.DefaultFont)
            return true
        end
        -- ��������������ѧ������ѧ ʮ������ɮ
    elseif JY.Wugong[Thing_kf(id)]["����"] == 1 and (match_ID(personid, 9897) or match_ID(personid, 576)) then
        return true
    elseif match_ID(personid, 505) and
        (JY.Wugong[Thing_kf(id)]["����"] == 1 or JY.Wugong[Thing_kf(id)]["����"] == 2) then
        return true
    elseif match_ID(personid, 9997) and JY.Wugong[Thing_kf(id)]["����"] == 9 then
        return true
        -- ����Ľ�����ӱ���������ת
    elseif match_ID(personid, 51) and id == 118 then
        return true
        -- ��˹ʥŮѧǬ����Ų��
    elseif match_ID(personid, 18) and id == 70 then
        return true
    else
        if JY.Thing[id]["����������"] >= 0 and JY.Thing[id]["����������"] ~= personid and
            (personid == 0 and JY.Thing[id]["����������"] == JY.Base["����"]) == false then
            return false
        end
        if JY.Thing[id]["����������"] ~= 2 and JY.Person[personid]["��������"] ~= 2 and
            JY.Person[personid]["��������"] ~= 3 and JY.Thing[id]["����������"] ~=
            JY.Person[personid]["��������"] then
            local cond = 1
            -- ���ڿ�����������ѧϰ ��ͨ�ټ� ����˫��֮��
            if match_ID(personid, 578) or match_ID(personid, 9987) or match_ID(personid, 9978) then
                cond = 2
                -- ؤ�����ѧ������������
            elseif id == 86 and personid == 9936 then
                cond = 2
                -- ؤ�����ѧ����������
            elseif id == 167 and personid == 9936 then
                cond = 2
            end
            if cond == 1 then
                return false
            end
        end
        if JY.Person[personid]["�������ֵ"] < JY.Thing[id]["������"] then
            return false
        end
        if JY.Person[personid]["������"] < JY.Thing[id]["�蹥����"] then
            return false
        end
        if JY.Person[personid]["�Ṧ"] < JY.Thing[id]["���Ṧ"] then
            return false
        end
        if JY.Person[personid]["�ö�����"] < JY.Thing[id]["���ö�����"] then
            return false
        end
        if JY.Person[personid]["ҽ������"] < JY.Thing[id]["��ҽ������"] then
            return false
        end
        -- ѧ��С���๦������ֵ����+10��
        local lv = 0;
        if PersonKF(personid, 98) then
            lv = 10
            if match_ID(personid, 103) then
                lv = 20
            end
        end
        -- ��ͨ�ټ�
        if match_ID(personid, 9987) then
            lv = lv + 20
        end
        -- �к�����ѧ�罣������-40
        if id == 117 and PersonKF(personid, 67) then
            lv = lv + 40
        end
        -- ���罣��ѧ����������-40
        if id == 136 and PersonKF(personid, 44) then
            lv = lv + 40
        end

        -- �һ�������ѧϰ����֮һ��ʣ���������������-10���ɵ���
        if id == 95 or id == 101 or id == 123 then
            for i = 1, JY.Base["�书����"] do
                if JY.Person[personid]["�书" .. i] == 12 or JY.Person[personid]["�书" .. i] == 18 or
                    JY.Person[personid]["�书" .. i] == 38 then
                    lv = lv + 10
                end
            end
        end
        -- ̫�����壬ѧϰ����֮һ��ʣ���������-10
        if id == 97 or id == 115 then
            for i = 1, JY.Base["�书����"] do
                if JY.Person[personid]["�书" .. i] == 46 or JY.Person[personid]["�书" .. i] == 16 then
                    lv = lv + 10
                end
            end
        end
        -- ��հ���-40
        if id == 291 or id == 90 or id == 324 then
            for i = 1, JY.Base["�书����"] do
                if JY.Person[personid]["�书" .. i] == 46 or JY.Person[personid]["�书" .. i] == 16 then
                    lv = lv + 10
                end
            end
        end
        -- �д򹷣�ѧ����-40
        if id == 86 and PersonKF(personid, 80) then
            if PersonKF(personid, 204) then
                lv = lv + 60
            else
                lv = lv + 40
            end
        end
        -- �н�����ѧ��-40
        if id == 167 and PersonKF(personid, 26) then
            if PersonKF(personid, 204) then
                lv = lv + 60
            else
                lv = lv + 40
            end
        end

        -- �оŽ���ѧ������-40
        if id == 180 and PersonKF(personid, 47) then
            lv = lv + 40
        end
        -- �г����٣�ѧ�Ž�-40
        if id == 114 and PersonKF(personid, 73) then
            lv = lv + 40
        end

        -- ������ǹ��ѧ����ɢ��-40
        if id == 337 and PersonKF(personid, 200) then
            lv = lv + 40
        end
        -- ������ɢ�֣�ѧ����ǹ-40
        if id == 386 and PersonKF(personid, 198) then
            lv = lv + 40
        end
        local xqz = JY.Thing[id]["��ȭ�ƹ���"]
        local xzf = JY.Thing[id]["��ָ������"]
        local xyj = JY.Thing[id]["����������"]
        local xsd = JY.Thing[id]["��ˣ������"]
        local xts = JY.Thing[id]["���������"]
        local xaq = JY.Thing[id]["�谵������"]
        local wugong = JY.Thing[id]["�����书"];
        -- if wugong >= 0 then
        --	local wugonglv = JY.Wugong[wugong]["�㼶"]
        --	if wugonglv > 2  then
        --		xqz = wugonglv*80
        --		xzf = wugonglv*80
        --		xyj = wugonglv*80
        --		xsd = wugonglv*80
        --		xts = wugonglv*80
        --		xaq = wugonglv*80
        --	elseif wugonglv == 2 then
        --		xqz = 100
        --		xzf =100
        --		xyj = 100
        --		xsd = 100
        --		xts = 100
        --		xaq = 100
        --	end
        -- end
        if JY.Person[personid]["ȭ�ƹ���"] + lv < xqz then
            return false
        end
        if JY.Person[personid]["ָ������"] + lv < xzf then
            return false
        end
        if JY.Person[personid]["��������"] + lv < xyj then
            return false
        end
        if JY.Person[personid]["ˣ������"] + lv < xsd then
            return false
        end
        if JY.Person[personid]["�������"] + lv < xts then
            return false
        end

        if JY.Person[personid]["��������"] < xaq then
            return false
        end

        if id == 372 then
            if JY.Person[personid]["����"] < 31 or JY.Person[personid]["����"] > 79 then
                return false
            end
        end

        if JY.Thing[id]["������"] >= 0 then
            if JY.Thing[id]["������"] > JY.Person[personid]["����"] then
                return false;
            end
        else
            if -JY.Thing[id]["������"] < JY.Person[personid]["����"] then
                return false;
            end
        end

    end

    -- ��ת����
    if id == 118 then
        local R = JY.Person[personid]
        local wp = R["ȭ�ƹ���"] + R["ָ������"] + R["��������"] + R["ˣ������"] + R["�������"]
        if wp < 120 then
            return false
        end
    end
    -- ��������
    if id == 176 then
        local R = JY.Person[personid]
        if R["��������"] >= 70 then
            return true
        elseif R["ˣ������"] >= 70 then
            return true
        elseif R["�������"] >= 70 then
            return true
        else
            return false
        end
    end
    -- �廨��
    if id == 349 then
        -- local R = JY.Person[personid]
        if match_ID(personid, 27) then
            return true
        else
            return false
        end
    end
    -- ԧ��
    if id == 217 then
        local R = JY.Person[personid]
        if R["�Ա�"] == 0 then
            return true
        else
            return false
        end
    end
    -- �쵶
    if id == 218 then
        local R = JY.Person[personid]
        if R["�Ա�"] == 1 then
            return true
        else
            return false
        end
    end
    -- ��˿��������
    if id == 239 then
        local R = JY.Person[personid]
        if R["ȭ�ƹ���"] >= 70 then
            return true
        elseif R["ָ������"] >= 70 then
            return true
        else
            return false
        end
    end
    -- �߱�ָ������
    if id == 200 then
        local R = JY.Person[personid]
        if R["ȭ�ƹ���"] >= 200 then
            return true
        elseif R["ָ������"] >= 200 then
            return true
        else
            return false
        end
    end
    return true
end

-- ҩƷʹ��ʵ��Ч��
-- id ��Ʒid��
-- personid ʹ����id
-- ����ֵ��0 ʹ��û��Ч������Ʒ����Ӧ�ò��䡣1 ʹ����Ч������ʹ�ú���Ʒ����Ӧ��-1
function UseThingEffect(id, personid, amount)
    -- ��ʹ��������Ĭ��Ϊʹ��1��
    if amount == nil then
        amount = 1
    end

    -- ����ҩƷ
    -- ���ڵ�
    if id == 343 then
        Cls() -- ����
        local k = JY.Wugong;
        local menu = {}

        local kftype = LGMsgBox("��ѡ��", "��ѡ��ϲ�����츳�ڹ�����", {"�ڹ�"}, 1, 347, 1)

        for i = 1, JY.WugongNum - 1 do
            local kfname = k[i]["����"]
            if string.len(kfname) == 8 then
                kfname = kfname .. "  "
            elseif string.len(kfname) == 6 then
                kfname = kfname .. "    "
            elseif string.len(kfname) == 4 then
                kfname = kfname .. "      "
            end
            menu[i] = {kfname, nil, 2}
            if k[i]["�书����"] == 6 then
                menu[i][3] = 1
            end
        end
        local nexty = CC.ScreenH / 2 - CC.DefaultFont * 4 + CC.SingleLineHeight
        local r = ShowMenu2(menu, #menu, 4, 8, CC.ScreenW / 2 - CC.DefaultFont * 10 - 20, nexty, 0, 0, 1, 1,
            CC.DefaultFont, C_ORANGE, C_WHITE, "�����츳�ڹ�")
        if r > 0 then
            SetTianNei(personid, r)
        end
        return 2
        -- ���ᵤ		
    elseif id == 344 then
        Cls() -- ����
        local k = JY.Wugong;
        local menu = {}

        local kftype = LGMsgBox("��ѡ��", "��ѡ��ϲ�����츳�Ṧ����", {"�Ṧ"}, 1, 347)

        for i = 1, JY.WugongNum - 1 do
            local kfname = k[i]["����"]
            if string.len(kfname) == 8 then
                kfname = kfname .. "  "
            elseif string.len(kfname) == 6 then
                kfname = kfname .. "    "
            elseif string.len(kfname) == 4 then
                kfname = kfname .. "      "
            end
            menu[i] = {kfname, nil, 2}
            if k[i]["�书����"] == 7 then
                menu[i][3] = 1
            end
        end
        local nexty = CC.ScreenH / 2 - CC.DefaultFont * 4 + CC.SingleLineHeight
        local r = ShowMenu2(menu, #menu, 4, 8, CC.ScreenW / 2 - CC.DefaultFont * 10 - 20, nexty, 0, 0, 1, 1,
            CC.DefaultFont, C_ORANGE, C_WHITE, "�����츳�Ṧ")

        if r > 0 then
            SetTianQing(personid, r)
        end
        return 2
        -- ���ⵤ	
    elseif id == 345 then
        Cls() -- ����
        local k = JY.Wugong;
        local menu = {}
        local kftype = LGMsgBox("��ѡ��", "��ѡ��ϲ�����츳�⹦����",
            {"ȭ��", "ָ��", "����", "����", "����"}, 5, 347)

        for i = 1, JY.WugongNum - 1 do
            local kfname = k[i]["����"]
            if string.len(kfname) == 8 then
                kfname = kfname .. "  "
            elseif string.len(kfname) == 6 then
                kfname = kfname .. "    "
            elseif string.len(kfname) == 4 then
                kfname = kfname .. "      "
            end
            menu[i] = {kfname, nil, 2}
            if k[i]["�书����"] == kftype then
                menu[i][3] = 1
            end
        end
        local nexty = CC.ScreenH / 2 - CC.DefaultFont * 4 + CC.SingleLineHeight
        local r = ShowMenu2(menu, #menu, 4, 8, CC.ScreenW / 2 - CC.DefaultFont * 10 - 20, nexty, 0, 0, 1, 1,
            CC.DefaultFont, C_ORANGE, C_WHITE, "�����츳�⹦")

        if r > 0 then
            local R = LGMsgBox("��ѡ��", "�����ѡ��������츳�⹦λ�á�",
                {"�츳�⹦һ", "�츳�⹦��"}, 2, 596)
            if R == 1 then
                if JY.Person[personid]["�츳�⹦2"] ~= r then
                    SetTianWai(personid, 1, r)
                else
                    DrawStrBoxWaitKey("�츳�⹦�����ظ���", C_ORANGE, CC.DefaultFont)
                    Cls()
                    instruct_2(345, 1)
                end
            elseif R == 2 then
                if JY.Person[personid]["�츳�⹦1"] ~= r then
                    SetTianWai(personid, 2, r)
                else
                    DrawStrBoxWaitKey("�츳�⹦�����ظ���", C_ORANGE, CC.DefaultFont)
                    Cls()
                    instruct_2(345, 1)
                end
            end
        end

        return 2
        -- ���ݵ����Ĵ�ɽ��	
    elseif id == 346 then
        Cls() -- ����
        JY.Person[0]["ͷ�����"] = JY.Person[642]["ͷ�����"]
        JY.Person[0]["������"] = JY.Person[642]["������"]
        JY.Person[0]["����"] = JY.Person[642]["����"]
        for i = 1, 5 do
            JY.Person[0]["���ж���֡��" .. i] = JY.Person[642]["���ж���֡��" .. i]
            JY.Person[0]["���ж����ӳ�" .. i] = JY.Person[642]["���ж����ӳ�" .. i]
            JY.Person[0]["�书��Ч�ӳ�" .. i] = JY.Person[642]["�书��Ч�ӳ�" .. i]
        end
        return 2
    elseif id == 348 then
        instruct_70(personid)
        return 2
    else
        local str = {}
        str[0] = string.format("ʹ�� %s �� %d", JY.Thing[id]["����"], amount)
        local strnum = 1
        local addvalue = nil
        if JY.Thing[id]["������"] > 0 then
            local add = JY.Thing[id]["������"]
            local smmax = JY.Person[personid]["�������ֵ"]

            if id == 0 or id == 1 or id == 2 or id == 7 or id == 8 then
                add = add + math.modf(JY.Thing[id]["������"] / 1000 * JY.Person[personid]["�������ֵ"])
            end
            -- lib.Debug(JY.Thing[id]['����']..'�������ֵ'..smmax..'��Ѫ��'..add)
            add = math.modf(add - add * JY.Person[personid]["���˳̶�"] / 200) + Rnd(5)
            -- ��ʵս����50%��ҩЧ��
            add = add + math.modf(JY.Person[personid]['ʵս'] / 1000 * add)
            -- ����ţ�ڶӣ���ҩЧ��Ϊ1.3��
            if JY.Status == GAME_WMAP and inteam(personid) and (inteam(16) or JY.Base["����"] == 16) then
                for w = 0, WAR.PersonNum - 1 do
                    if match_ID(WAR.Person[w]["������"], 16) and WAR.Person[w]["����"] == false and
                        WAR.Person[w]["�ҷ�"] then
                        add = math.modf(add * 1.3)
                        break
                    end
                end
            end
            if add <= 0 then
                add = 5 + Rnd(5)
            end
            add = math.modf(add)
            lib.Debug(JY.Thing[id]['����'] .. '��Ѫ��' .. add)
            -- �鰲ͨ�����˳�ҩ����Ѫ������Ѫ
            if JY.Status == GAME_WMAP then
                for w = 0, WAR.PersonNum - 1 do
                    if (match_ID(WAR.Person[w]["������"], 9846) or match_ID(WAR.Person[w]["������"], 9846)) and
                        WAR.Person[w]["����"] == false and WAR.Person[w]["�ҷ�"] ~= WAR.Person[WAR.CurID]["�ҷ�"] then
                        add = -add
                        break
                    end
                end
            end

            -- ���˳�ҩЧ���ӱ�
            if not inteam(personid) then
                -- add = add * 2;
            end
            -- ʵս���ҩЧ���ӱ�
            if inteam(personid) and JY.Person[0]["ʵս"] >= 500 then
                add = add * 1.1;
            end
            -- ��������
            if match_ID(personid, 9943) then
                add = add * 2;
            end
            if JY.Status == GAME_WMAP then
                WAR.Person[WAR.CurID]["���˵���"] = AddPersonAttrib(personid, "���˳̶�", -math.modf(add / 8))
            end

            addvalue, str[strnum] = AddPersonAttrib(personid, "����", add * amount)

            -- �����壺��ʾ��������
            if JY.Status == GAME_WMAP then
                WAR.Person[WAR.CurID]["��������"] = addvalue;
            end
            if addvalue ~= 0 then
                strnum = strnum + 1
            end
        end
        local function ThingAddAttrib(s)
            if JY.Thing[id]["��" .. s] ~= 0 then
                addvalue, str[strnum] = AddPersonAttrib(personid, s, JY.Thing[id]["��" .. s] * amount)
                if addvalue ~= 0 then
                    strnum = strnum + 1
                end
                -- �����壺��ʾ��������������
                if JY.Status == GAME_WMAP then
                    if s == "����" then
                        WAR.Person[WAR.CurID]["��������"] = addvalue;
                    elseif s == "����" then
                        WAR.Person[WAR.CurID]["��������"] = addvalue;
                    end
                end
            end
        end
        ThingAddAttrib("�������ֵ")
        if JY.Thing[id]["���ж��ⶾ"] < 0 then
            addvalue, str[strnum] = AddPersonAttrib(personid, "�ж��̶�",
                math.modf(JY.Thing[id]["���ж��ⶾ"] / 2) * amount)
            if addvalue ~= 0 then
                strnum = strnum + 1
            end
            -- �����壺��ʾ�нⶾ����
            if JY.Status == GAME_WMAP then
                if addvalue < 0 then
                    WAR.Person[WAR.CurID]["�ⶾ����"] = -addvalue;
                elseif addvalue > 0 then
                    WAR.Person[WAR.CurID]["�ж�����"] = addvalue;
                end
            end
        end
        ThingAddAttrib("����")
        if JY.Thing[id]["�ı���������"] == 2 then
            str[strnum] = "������·��Ϊ������һ"
            strnum = strnum + 1
        end
        ---
        if JY.Status == GAME_WMAP then
            if id == 25 then
                JY.Person[personid]['���˳̶�'] = 0
                JY.Person[personid]['�ж��̶�'] = 0
                JY.Person[personid]['���ճ̶�'] = 0
                JY.Person[personid]['����̶�'] = 0
                WAR.FXDS[personid] = nil
                WAR.LXZT[personid] = nil
                WAR.PD['�屦���۾�'][personid] = 100
            end
            if id == 24 then
                if WAR.LXZT[personid] ~= nil then
                    WAR.LXZT[personid] = WAR.LXZT[personid] - 50
                    if WAR.LXZT[personid] < 1 then
                        WAR.LXZT[personid] = nil
                    end
                end
                WAR.PD['��ī�Ͼ�'][personid] = 100
            end

            if id == 23 then
                AddPersonAttrib(personid, '���ճ̶�', -20)
                WAR.PD['��¶��'][personid] = 50
            end

            if id == 22 then
                AddPersonAttrib(personid, '����̶�', -50)
                WAR.PD['�滨��'][personid] = 50
            end

            if id == 11 then
                WAR.PD['��������'][personid] = 1
            end

            if id == 10 then
                WAR.PD['ţ��ѪЫ'][personid] = 50
            end

            if id == 9 then
                WAR.PD['�����ⶾ'][personid] = 50
            end

            if id == 3 then
                WAR.PD['�����ܵ�'][personid] = 200
            end

            if id == 8 then
                WAR.PD['��������'][personid] = 100
            end

            if id == 0 then
                WAR.PD['С����'][personid] = 50
            end
        else
            if id == 25 then
                JY.Person[personid]['���˳̶�'] = 0
                JY.Person[personid]['�ж��̶�'] = 0
                JY.Person[personid]['���ճ̶�'] = 0
                JY.Person[personid]['����̶�'] = 0
            end
        end

        ThingAddAttrib("����")
        ThingAddAttrib("�������ֵ")
        ThingAddAttrib("������")
        ThingAddAttrib("������")
        ThingAddAttrib("�Ṧ")
        ThingAddAttrib("ҽ������")
        ThingAddAttrib("�ö�����")
        ThingAddAttrib("�ⶾ����")
        ThingAddAttrib("��������")
        ThingAddAttrib("ȭ�ƹ���")
        ThingAddAttrib("��������")
        ThingAddAttrib("ˣ������")
        ThingAddAttrib("�������")
        ThingAddAttrib("��������")
        ThingAddAttrib("��ѧ��ʶ")
        ThingAddAttrib("��������")

        Cls()

        if strnum > 1 then
            local maxlength = 0
            for i = 0, strnum - 1 do
                if maxlength < #str[i] then
                    maxlength = #str[i]
                end
            end

            if JY.Status ~= GAME_WMAP then
                local ww = maxlength * CC.DefaultFont / 2 + CC.MenuBorderPixel * 2
                local hh = (strnum) * CC.DefaultFont + (strnum - 1) * CC.RowPixel + 2 * CC.MenuBorderPixel
                local x = (CC.ScreenW - ww) / 2
                local y = (CC.ScreenH - hh) / 2
                DrawBox(x, y, x + ww, y + hh, C_WHITE)
                DrawString(x + CC.MenuBorderPixel, y + CC.MenuBorderPixel, str[0], C_WHITE, CC.DefaultFont)
                for i = 1, strnum - 1 do
                    DrawString(x + CC.MenuBorderPixel, y + CC.MenuBorderPixel + (CC.DefaultFont + CC.RowPixel) * i,
                        str[i], C_ORANGE, CC.DefaultFont)
                end

                ShowScreen()
            else
                -- ��ʾʹ����Ʒ����
                DrawString(CC.MainMenuX, CC.ScreenH - (strnum + 2) * CC.Fontsmall,
                    JY.Person[WAR.Person[WAR.CurID]["������"]]["����"] .. " " .. str[0], C_WHITE, CC.Fontsmall);
                for i = 1, strnum - 1 do
                    DrawString(CC.MainMenuX, CC.ScreenH + (i - strnum - 2) * CC.Fontsmall, str[i], C_WHITE, CC.Fontsmall);
                end

                ShowScreen()
                -- ��ʾ����
                War_Show_Count(WAR.CurID);
                return 1;
            end
            return 1
        else
            DrawStrBox(-1, -1, str[0], C_WHITE, CC.DefaultFont)
            ShowScreen()
            return 1
        end
    end
end

-- װ����Ʒ
function UseThing_Type1(id)
    DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, string.format("˭Ҫ�䱸%s?", JY.Thing[id]["����"]), C_WHITE,
        CC.DefaultFont)
    local nexty = CC.MainSubMenuY + CC.SingleLineHeight
    local r = SelectTeamMenu(CC.MainSubMenuX, nexty)
    local pp1, pp2 = 0, 0
    if r > 0 then
        local personid = JY.Base["����" .. r]
        -- ���ũװ��������
        if id == 202 and match_ID(personid, 72) then
            say("�ٺ٣���ڱ����������������ŵı�����˭˵ˣ��������װ���ˣ�", 72, 0)
            if JY.Thing[id]["ʹ����"] >= 0 then

                JY.Person[JY.Thing[id]["ʹ����"]]["����"] = -1
            end
            if JY.Person[personid]["����"] >= 0 then
                JY.Thing[JY.Person[personid]["����"]]["ʹ����"] = -1
            end
            JY.Person[personid]["����"] = id
            JY.Thing[id]["ʹ����"] = personid
            return 1
        end

        if CanUseThing(id, personid) then
            if JY.Thing[id]["װ��λ��"] == 0 then
                if JY.Thing[id]["ʹ����"] >= 0 then

                    JY.Person[JY.Thing[id]["ʹ����"]]["����"] = -1
                end
                if JY.Person[personid]["����"] >= 0 then
                    JY.Thing[JY.Person[personid]["����"]]["ʹ����"] = -1
                end
                JY.Person[personid]["����"] = id

            elseif JY.Thing[id]["װ��λ��"] == 1 then
                if JY.Thing[id]["ʹ����"] >= 0 then

                    JY.Person[JY.Thing[id]["ʹ����"]]["����"] = -1
                end
                if JY.Person[personid]["����"] >= 0 then
                    JY.Thing[JY.Person[personid]["����"]]["ʹ����"] = -1
                end
                JY.Person[personid]["����"] = id
            elseif JY.Thing[id]["װ��λ��"] == 2 then
                if JY.Thing[id]["ʹ����"] >= 0 then

                    JY.Person[JY.Thing[id]["ʹ����"]]["����"] = -1
                end
                if JY.Person[personid]["����"] >= 0 then
                    JY.Thing[JY.Person[personid]["����"]]["ʹ����"] = -1
                end
                JY.Person[personid]["����"] = id

            end
            JY.Thing[id]["ʹ����"] = personid
        else
            DrawStrBoxWaitKey("���˲��ʺ��䱸����Ʒ", C_WHITE, CC.DefaultFont)
            return 0
        end
    end
    return 1
end

function UseThing_Type2(id)
    local wugongid = 0
    if JY.Thing[id]["�����书"] >= 0 then
        wugongid = JY.Thing[id]["�����书"]
    end
    local R = LGMsgBox("��ѡ��", "��ѡ����Ҫ�Ĳ���", {"����", "�鿴"}, 2, 0, 1)
    if R == 2 then
        if JY.Thing[id]["�����书"] >= 0 then
            KF_sm(0, Thing_kf(id))
            return MJMenu()
        end
    else
        if JY.Thing[id]["ʹ����"] >= 0 and
            DrawStrBoxYesNo(-1, -1, "����Ʒ�Ѿ������������Ƿ�������?", C_WHITE, CC.DefaultFont) ==
            false then
            Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
            ShowScreen()
            return 0
        end
        Cls()
        DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, string.format("˭Ҫ����%s?", JY.Thing[id]["����"]), C_WHITE, CC.DefaultFont)
        local nexty = CC.MainSubMenuY + CC.SingleLineHeight
        local r = SelectTeamMenu(CC.MainSubMenuX, nexty)

        local oldmiji = 0
        if r > 0 then
            local personid = JY.Base["����" .. r]
            local yes, full, yes1, full1 = nil, nil, nil, nil
            if JY.Thing[id]["�����书"] >= 0 then
                yes = 0
                full = 1
                wugongid = JY.Thing[id]["�����书"]
                for i = 1, JY.Base["�书����"] do
                    if JY.Person[personid]["�书" .. i] == JY.Thing[id]["�����书"] then
                        yes = 1
                    else
                        if JY.Person[personid]["�书" .. i] == 0 then
                            full = 0
                        end
                    end
                end
            end
            if JY.Thing[id]["�����ؼ�"] >= 1 or id == 372 then
                yes1 = 0
                full1 = 1
                for i = 1, 5 do
                    if JY.Person[personid]["�ؼ�" .. i] == JY.Thing[id]["�����ؼ�"] then
                        yes1 = 1
                    else
                        if JY.Person[id]["�ؼ�" .. i] == 0 then
                            full1 = 0
                        end
                    end
                end
            end
            Usething_KF(personid, id)
        end
        return MJMenu()
    end
end

-- �޾Ʋ�����ʹ��ҩƷ��ʳƷ
function UseThing_Type3(id)
    local usepersonid = -1
    local amount_use = 0
    Cls()
    if JY.Status == GAME_MMAP or JY.Status == GAME_SMAP then
        DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, string.format("˭Ҫʹ��%s?", JY.Thing[id]["����"]), C_WHITE,
            CC.DefaultFont)
        local nexty = CC.MainSubMenuY + CC.SingleLineHeight
        local r = SelectTeamMenu(CC.MainSubMenuX, nexty)
        if r > 0 then
            usepersonid = JY.Base["����" .. r]
            -- ��ս���п�������ʹ��
            local max_amount = 0
            for i = 1, CC.MyThingNum do
                if JY.Base["��Ʒ" .. i] == id then
                    max_amount = JY.Base["��Ʒ����" .. i]
                    break
                end
            end
            -- ����ҩƷ������ʹ��
            local tsyp = {343, 344, 345, 348}
            for i = 1, #tsyp do

            end
            if max_amount > 1 then
                amount_use = InputNum("ʹ������", 1, max_amount)
            else
                amount_use = 1
            end
        end
        -- ս����
    elseif JY.Status == GAME_WMAP then
        -- ����ţ�����������ҩ
        if match_ID(WAR.Person[WAR.CurID]["������"], 16) then
            War_CalMoveStep(WAR.CurID, 8, 1)
            local x, y = War_SelectMove()
            if x ~= nil then
                local emeny = GetWarMap(x, y, 2)
                if emeny >= 0 and WAR.Person[WAR.CurID]["�ҷ�"] == WAR.Person[emeny]["�ҷ�"] then
                    usepersonid = WAR.Person[emeny]["������"]
                end
            end
        else
            usepersonid = WAR.Person[WAR.CurID]["������"]
        end
    end
    -- ս���в���ʹ�ü�Ѫ�����޵���Ʒ
    if JY.Status == GAME_WMAP and (id >= 14 and id <= 21) then
        return 0
    end

    if usepersonid >= 0 then
        -- ��ս����ʹ����Ʒ
        if JY.Status == GAME_MMAP or JY.Status == GAME_SMAP then

            local r = UseThingEffect(id, usepersonid, amount_use)
            if r == 1 then
                instruct_32(id, -amount_use)
                WaitKey()
            elseif r == 2 then
                instruct_32(id, -amount_use)
            end

            -- ���鵤
            if id == 316 then
                JY.Thing[316]['����ѧ��ʶ'] = 0
                JY.Thing[316]['��Ʒ˵��'] = '�ɸı���������'
                local menu = {'����', '����', '����'}
                local R = LGMsgBox("ѡ��", " ��Ҫ�������ı�ɣ�", menu, #menu, usepersonid)
                if R == 1 then
                    JY.Person[usepersonid]["��������"] = 0
                elseif R == 2 then
                    JY.Person[usepersonid]["��������"] = 1
                elseif R == 3 then
                    JY.Person[usepersonid]["��������"] = 2
                end
            end
            -- ǧ����֥
            if id == 14 then
                local n = amount_use
                -- JY.Person[usepersonid]["����"] = JY.Person[usepersonid]["����"]+amount_use				
                Add(usepersonid, '����', amount_use)
                -- Add(usepersonid,'��������',amount_use*100)
                DrawStrBoxWaitKey(JY.Person[usepersonid]["����"] .. "��������" .. amount_use .. "��", C_ORANGE,
                    CC.DefaultFont)
                Hp_Max(usepersonid)
            end
            -- ǧ���˲�
            if id == 16 then
                local n = math.random(3) * amount_use
                if n == 1 then
                    -- JY.Person[usepersonid]["������"] = JY.Person[usepersonid]["������"] + 10 
                    Add(usepersonid, '������', 10)
                elseif n == 2 then
                    -- JY.Person[usepersonid]["������"] = JY.Person[usepersonid]["������"] + 10
                    Add(usepersonid, '������', 10)
                else
                    -- JY.Person[usepersonid]["�Ṧ"] = JY.Person[usepersonid]["�Ṧ"] + 10
                    Add(usepersonid, '�Ṧ', 10)
                end
                local nm = {'������', '������', '�Ṧ'}
                DrawStrBoxWaitKey(JY.Person[usepersonid]["����"] .. nm[n] .. "10��", C_ORANGE, CC.DefaultFont)
            end
            -- ��ɽѩ��
            if id == 17 then
                -- JY.Person[usepersonid]['��������'] = JY.Person[usepersonid]['��������']+200
                local n = 100 * amount_use
                Add(usepersonid, '��������', n)
                -- Hp_Max(usepersonid)
                DrawStrBoxWaitKey(JY.Person[usepersonid]["����"] .. "��������" .. n .. "��", C_ORANGE,
                    CC.DefaultFont)
                -- Hp_Max(usepersonid)
            end
            -- �л���
            if id == 18 then
                -- JY.Person[usepersonid]['��������'] = JY.Person[usepersonid]['��������']+200
                local n = 20 * amount_use
                Add(usepersonid, '��������', n)
                DrawStrBoxWaitKey(JY.Person[usepersonid]["����"] .. "��������" .. n .. "��", C_ORANGE,
                    CC.DefaultFont)
                -- Hp_Max(usepersonid)
            end
            -- ���˭������÷
            if id == 20 then
                -- JY.Person[usepersonid]['��������'] = JY.Person[usepersonid]['��������']+200
                local n = 50 * amount_use
                Add(usepersonid, '��������', n)
                DrawStrBoxWaitKey(JY.Person[usepersonid]["����"] .. "��������" .. n .. "��", C_ORANGE,
                    CC.DefaultFont)
                Hp_Max(usepersonid)
            end

            -- ս����ʹ����Ʒ
        elseif JY.Status == GAME_WMAP then
            if UseThingEffect(id, usepersonid) == 1 then
                instruct_32(id, -1)
                if id >= 22 and id <= 25 and match_ID(usepersonid, 9965) then
                    WAR.PD['�˾Ʊ�'][usepersonid] = (WAR.PD['�˾Ʊ�'][usepersonid] or 0) + 1
                    WAR.PD['����'][usepersonid] = (WAR.PD['����'][usepersonid] or 0) + 500
                    CurIDTXDH(WAR.CurID, 79, 1, "���񡤰˾Ʊ�", C_ORANGE);
                end
                -- ��ѪҩƷ�ĳɲ���ٷֱ�
                -- ����
                if id == 0 or id == 1 or id == 2 or id == 7 or id == 8 then
                    local heal_amount = JY.Thing[id]['������']
                    -- heal_amount = heal_amount + math.modf(JY.Thing[id]['������']/1000*JY.Person[usepersonid]['�������ֵ'])
                    -- AddPersonAttrib(id, "����", heal_amount)
                end
            end
        end
    else
        return 0
    end
    return 1
end

-- ������Ʒ
function UseThing_Type4(id)
    if JY.Status == GAME_WMAP then
        return War_UseAnqi(id)
    end
    return 0
end

--------------------------------------------------------------------------------
--------------------------------------�¼�����-----------------------------------

-- �¼����������
-- id��d*�еı��
-- flag 1 �ո񴥷���2����Ʒ������3��·������
function EventExecute(id, flag)
    JY.CurrentD = id;

    oldEventExecute(flag)

    JY.CurrentD = -1;
end

-- ����ԭ�е�ָ��λ�õĺ���
-- �ɵĺ������ָ�ʽΪ  oldevent_xxx();  xxxΪ�¼����
function oldEventExecute(flag)
    local eventnum = nil
    if flag == 1 then
        eventnum = GetD(JY.SubScene, JY.CurrentD, 2)
    elseif flag == 2 then
        eventnum = GetD(JY.SubScene, JY.CurrentD, 3)
    elseif flag == 3 then
        eventnum = GetD(JY.SubScene, JY.CurrentD, 4)
    end
    if eventnum > 0 then
        lib.Debug(eventnum .. "");
    end
    if eventnum > 0 then
        CallCEvent(eventnum)
    end
end

function existFile(filename)
    local f = io.open(filename)
    if f == nil then
        return false
    end
    io.close(f)
    return true
end

function CallCEvent(eventnum)
    if newkdef[eventnum] ~= nil then -- �����ж�����¼�����Ƿ����
        lib.Debug("new kdef " .. eventnum) -- ������ڣ���ִ���¼�ǰ����debug�ı����ӡ��  new kdef +�¼���ţ��Ա����ʱʹ��
        if eventnum > 0 then -- ����¼���Ŵ���0
            newkdef[eventnum]() -- ִ�и��¼�
        end
    end
end

-- �ı���ͼ���꣬�ӳ�����ȥ���ƶ�����Ӧ����
function ChangeMMap(x, y, direct) -- �ı���ͼ����
    JY.Base["��X"] = x;
    JY.Base["��Y"] = y;
    JY.Base["�˷���"] = direct;
end

-- �ı䵱ǰ����
function ChangeSMap(sceneid, x, y, direct) -- �ı䵱ǰ����
    JY.SubScene = sceneid;
    JY.Base["��X1"] = x;
    JY.Base["��Y1"] = y;
    JY.Base["�˷���"] = direct;
end

-- ���(x1,y1)-(x2,y2)�����ڵ����ֵȡ�
-- ���û�в����������������Ļ����
-- ע��ú�������ֱ��ˢ����ʾ��Ļ
function Cls(x1, y1, x2, y2) -- �����Ļ
    if x1 == nil then -- ��һ������Ϊnil,��ʾû�в�������ȱʡ
        x1 = 0;
        y1 = 0;
        x2 = CC.ScreenW;
        y2 = CC.ScreenH;
    end

    lib.SetClip(x1, y1, x2, y2);

    if JY.Status == GAME_START then
        lib.FillColor(0, 0, 0, 0, 0);
        lib.LoadPicture(CC.FirstFile, -1, -1);
    elseif JY.Status == GAME_MMAP then
        local sc = CC.Shichen
        if CC.TX['ҹĻ'] == 1 then
            --sc = 6
        end
        lib.DrawMMap(JY.Base["��X"], JY.Base["��Y"], GetMyPic(), sc); -- ��ʾ����ͼ
    elseif JY.Status == GAME_SMAP then
        DrawSMap();
    elseif JY.Status == GAME_WMAP then
        WarDrawMap(0);
    elseif JY.Status == GAME_DEAD then
        lib.FillColor(0, 0, 0, 0, 0);
        --lib.LoadPicture(CC.DeadFile, -1, -1);
    else
        lib.FillColor(0, 0, 0, 0, 0)
    end
    lib.SetClip(0, 0, CC.ScreenW, CC.ScreenH);
end

-- �����Ի���ʾ��Ҫ���ַ�������ÿ��n�������ַ���һ���Ǻ�
function GenTalkString(str, n) -- �����Ի���ʾ��Ҫ���ַ���
    local tmpstr = "";
    for s in string.gmatch(str .. "*", "(.-)%*") do -- ȥ���Ի��е�����*. �ַ���β����һ���Ǻţ������޷�ƥ��
        tmpstr = tmpstr .. s;
    end

    local newstr = "";
    while #tmpstr > 0 do
        local w = 0;
        while w < #tmpstr do
            local v = string.byte(tmpstr, w + 1); -- ��ǰ�ַ���ֵ
            if v >= 128 then
                w = w + 2;
            else
                w = w + 1;
            end
            if w >= 2 * n - 1 then -- Ϊ�˱����������ַ�
                break
            end
        end

        if w < #tmpstr then
            if w == 2 * n - 1 and string.byte(tmpstr, w + 1) < 128 then
                newstr = newstr .. string.sub(tmpstr, 1, w + 1) .. "*";
                tmpstr = string.sub(tmpstr, w + 2, -1);
            else
                newstr = newstr .. string.sub(tmpstr, 1, w) .. "*";
                tmpstr = string.sub(tmpstr, w + 1, -1);
            end
        else
            newstr = newstr .. tmpstr;
            break
        end
    end
    return newstr;
end

-- �����¶Ի�
function TalkEx(s, pid, flag, name)
    say(s, pid, flag, name)
end

-- ����ָ�ռλ����
function instruct_test(s)
    DrawStrBoxWaitKey(s, C_ORANGE, 24);
end

-- ����
function instruct_0() -- ����
    Cls();
end

function ReadTalk(id, flag)
    local tidx = Byte.create(id * 4 + 4)
    Byte.loadfile(tidx, CC.TDX, 0, id * 4 + 4)
    local idx1, idx2 = nil, nil
    if id < 1 then
        idx1 = 0
    else
        idx1 = Byte.get32(tidx, (id - 1) * 4)
    end
    idx2 = Byte.get32(tidx, id * 4)
    local len = idx2 - idx1
    local talk = Byte.create(len)
    Byte.loadfile(talk, CC.TRP, idx1, len)
    local str = ""
    for i = 0, len - 2 do
        local byte = Byte.getu16(talk, i)
        byte = 255 - math.fmod(byte, 256)
        str = str .. string.char(byte)
    end
    if flag == nil then
        str = lib.CharSet(str, 0)
        str = GenTalkString(str, 12)
    end
    return str
end

-- �Ի�
-- talkid: Ϊ���֣���Ϊ�Ի���ţ�Ϊ�ַ�������Ϊ�Ի�����
-- headid: ͷ��id
-- flag :�Ի���λ�ã�0 ��Ļ�Ϸ���ʾ, ���ͷ���ұ߶Ի�
--            1 ��Ļ�·���ʾ, ��߶Ի����ұ�ͷ��
--            2 ��Ļ�Ϸ���ʾ, ��߿գ��ұ߶Ի�
--            3 ��Ļ�·���ʾ, ��߶Ի����ұ߿�
--            4 ��Ļ�Ϸ���ʾ, ��߶Ի����ұ�ͷ��
--            5 ��Ļ�·���ʾ, ���ͷ���ұ߶Ի�
function instruct_1(talkid, headid, flag)
    local s = ReadTalk(talkid)
    if s == nil then
        return
    end
    TalkEx(s, headid, flag)
end

-- �õ���Ʒ
function instruct_2(thingid, num)
    if JY.Thing[thingid] == nil then
        return
    end
    instruct_32(thingid, num)
    if num > 0 then
        local name = 0
        -- DrawStrBoxWaitKey(string.format("�õ���Ʒ%sX%d", "����"..JY.Thing[thingid]["����"].."�ϡ�", num), C_ORANGE, CC.DefaultFont, 1)
        if JY.Thing[thingid]["�����书"] > 0 then
            if JY.Wugong[JY.Thing[thingid]["�����书"]]["�㼶"] == 3 then
                name = "��" .. JY.Thing[thingid]["����"] .. "X" .. num
            elseif JY.Wugong[JY.Thing[thingid]["�����书"]]["�㼶"] == 2 then
                name = "��" .. JY.Thing[thingid]["����"] .. "X" .. num
            elseif JY.Wugong[JY.Thing[thingid]["�����书"]]["�㼶"] == 1 then
                name = "��" .. JY.Thing[thingid]["����"] .. "X" .. num
            else
                name = "��" .. JY.Thing[thingid]["����"] .. "X" .. num
            end
        else
            name = "��" .. JY.Thing[thingid]["����"] .. "X" .. num
        end

        CC.JLWP[#CC.JLWP + 1] = thingid
        Cls()
        lib.LoadPNG(91, 121 * 2, CC.WX * 555, CC.HY * 373, 1)
        tjm(CC.WX * 625, CC.HY * 386, name, C_CYGOLD, CC.DefaultFont, 11, CC.DefaultFont)
        ShowScreen()
        WaitKey()
        Cls()
    else
        local name = 0
        if JY.Thing[thingid]["�����书"] > 0 then
            if JY.Wugong[JY.Thing[thingid]["�����书"]]["�㼶"] == 3 then
                name = "��" .. JY.Thing[thingid]["����"] .. "X" .. -num
            elseif JY.Wugong[JY.Thing[thingid]["�����书"]]["�㼶"] == 2 then
                name = "��" .. JY.Thing[thingid]["����"] .. "X" .. -num
            elseif JY.Wugong[JY.Thing[thingid]["�����书"]]["�㼶"] == 1 then
                name = "��" .. JY.Thing[thingid]["����"] .. "X" .. -num
            else
                name = "��" .. JY.Thing[thingid]["����"] .. "X" .. -num
            end
        else
            name = "��" .. JY.Thing[thingid]["����"] .. "X" .. -num
        end
        Cls()
        lib.LoadPNG(91, 122 * 2, CC.WX * 355, CC.HY * 373, 1)
        tjm(CC.WX * 425, CC.HY * 386, name, C_CYGOLD, CC.DefaultFont, 11, CC.DefaultFont)
        ShowScreen()
        WaitKey()
        Cls()
    end
    if thingid >= CC.BookStart and thingid < CC.BookStart + CC.BookNum then
        -- instruct_2(174, 5000)
    end
end

-- �޸�ָ������������¼�
function instruct_3(sceneid, id, v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10)
    if JY.Restart == 1 then
        return
    end
    if sceneid == -2 then
        sceneid = JY.SubScene
    end
    if id == -2 then
        id = JY.CurrentD
    end
    if v0 ~= -2 then
        SetD(sceneid, id, 0, v0)
    end
    if v1 ~= -2 then
        SetD(sceneid, id, 1, v1)
    end
    if v2 ~= -2 then
        SetD(sceneid, id, 2, v2)
    end
    if v3 ~= -2 then
        SetD(sceneid, id, 3, v3)
    end
    if v4 ~= -2 then
        SetD(sceneid, id, 4, v4)
    end
    if v5 ~= -2 then
        SetD(sceneid, id, 5, v5)
    end
    if v6 ~= -2 then
        SetD(sceneid, id, 6, v6)
    end
    if v7 ~= -2 then
        SetD(sceneid, id, 7, v7)
    end
    if v8 ~= -2 then
        SetD(sceneid, id, 8, v8)
    end
    if v9 ~= -2 and v10 ~= -2 and v9 > 0 and v10 > 0 then
        SetS(sceneid, GetD(sceneid, id, 9), GetD(sceneid, id, 10), 3, -1)
        SetD(sceneid, id, 9, v9)
        SetD(sceneid, id, 10, v10)
        SetS(sceneid, GetD(sceneid, id, 9), GetD(sceneid, id, 10), 3, id)
    end
end

function instruct_4(thingid)
    if JY.CurrentThing == thingid then
        JY.ThingUse = thingid
        return true
    else
        return false
    end
end

function instruct_5()
    return DrawStrBoxYesNo(-1, -1, "�Ƿ���֮����(Y/N)?", C_ORANGE, CC.DefaultFont)
end

function instruct_6(warid, tmp, tmp1, flag)
    return WarMain(warid, flag)
end

function instruct_7()
    instruct_test("ָ��7����")
end

function instruct_8(musicid)
    JY.MmapMusic = musicid
end

function instruct_9()
    return DrawStrBoxYesNo(-1, -1, "�Ƿ�Ҫ�����(Y/N)?", C_ORANGE, CC.DefaultFont)
end

-- ��Ӻ���
function instruct_10(personid)
    if JY.Person[personid] == nil then
        lib.Debug("instruct_10 error: person id not exist")
        return
    end
    local add = 0
    -- �޾Ʋ��������벻�����Լ�
    if personid ~= JY.Base["����"] then
        for i = 2, CC.TeamNum do
            if JY.Base["����" .. i] < 0 then
                JY.Base["����" .. i] = personid
                add = 1
                break
            end
        end
    end
    for i = 1, 4 do
        local id = JY.Person[personid]["Я����Ʒ" .. i]
        local n = JY.Person[personid]["Я����Ʒ����" .. i]
        if n < 0 then
            n = 0
        end
        if id >= 0 and n > 0 then
            instruct_2(id, n)
            JY.Person[personid]["Я����Ʒ" .. i] = -1
            JY.Person[personid]["Я����Ʒ����" .. i] = 0
        end
    end

    if add == 0 then
        lib.Debug("instruct_10 error: �����������")
        return
    end
end

function instruct_11()
    return DrawStrBoxYesNo(-1, -1, "�Ƿ�(Y/N)?", C_ORANGE, CC.DefaultFont)
end

-- ��Ϣ
function instruct_12(flag)
    for i = 1, CC.TeamNum do
        local id = JY.Base["����" .. i]
        if id >= 0 then
            JY.Person[id]["���˳̶�"] = 0
            JY.Person[id]["�ж��̶�"] = 0
            AddPersonAttrib(id, "����", math.huge)
            AddPersonAttrib(id, "����", math.huge)
            AddPersonAttrib(id, "����", math.huge)
        end
    end
end

-- dark
function instruct_13()
    if JY.Restart == 1 then
        return
    end
    Cls()
    JY.Darkness = 0
    lib.ShowSlow(20, 0)
    lib.GetKey()
end

-- light
function instruct_14()
    if JY.Restart == 1 then
        return
    end
    lib.ShowSlow(20, 1)
    JY.Darkness = 1
end

function instruct_15()
    JY.Status = GAME_DEAD
    Cls()
    DrawString(CC.GameOverX, CC.GameOverY, JY.Person[0]["����"], RGB(0, 0, 0), CC.DefaultFont)
    local x = CC.ScreenW - 9 * CC.DefaultFont
    DrawString(x, 10, os.date("%Y-%m-%d %H:%M"), RGB(216, 20, 24), CC.DefaultFont)
    DrawString(x, 10 + CC.DefaultFont + CC.RowPixel, "�ڵ����ĳ��", RGB(216, 20, 24), CC.DefaultFont)
    DrawString(x, 10 + (CC.DefaultFont + CC.RowPixel) * 2, "�����˿ڵ�ʧ����", RGB(216, 20, 24), CC.DefaultFont)
    DrawString(x, 10 + (CC.DefaultFont + CC.RowPixel) * 3, "�ֶ���һ�ʡ�����", RGB(216, 20, 24), CC.DefaultFont)
    local loadMenu = {{"ѡ�����", nil, 1}, {"�ؼ�˯��ȥ", nil, 1}}
    local y = CC.ScreenH - 4 * (CC.DefaultFont + CC.RowPixel) - 10
    local sl = ShowMenu(loadMenu, #loadMenu, 0, x, y, 0, 0, 0, 0, CC.DefaultFont, C_ORANGE, C_WHITE)
    if sl == 1 then
        local r = SaveList();
        if r < 1 then
            JY.Status = GAME_END
            return 0;
        end

        Cls();
        DrawString(CC.MainSubMenuX2, CC.MainSubMenuY, "���Ժ�......", C_WHITE, CC.DefaultFont, CC.FONT2)
        ShowScreen();
        local result = LoadRecord(r);
        if result ~= nil then
            instruct_15();
            return 0;
        end
        if JY.Base["����"] ~= -1 then
            JY.Status = GAME_SMAP
            JY.SubScene = JY.Base["����"]
            JY.MmapMusic = -1
            JY.MyPic = GetMyPic()
            Init_SMap(1)
        else
            JY.SubScene = -1
            JY.Status = GAME_FIRSTMMAP
        end
        ShowScreen()
        lib.LoadPicture("", 0, 0)
        lib.GetKey()
        Game_Cycle()
    else
        JY.Status = GAME_END
    end
end

function inteam(pid)
    return instruct_16(pid)
end

function instruct_16(personid)
    local r = false
    local xwperson; -- �ж�����
    -- ��ս���в���Ч�����ڴ���������ж�
    if personid == JY.Base["����"] and JY.Status ~= GAME_WMAP then
        xwperson = 0
    else
        xwperson = personid
    end
    for i = 1, CC.TeamNum do
        if xwperson == JY.Base["����" .. i] then
            r = true
            break
        end
    end
    return r
end

function instruct_17(sceneid, level, x, y, v)
    if sceneid == -2 then
        sceneid = JY.SubScene
    end
    SetS(sceneid, x, y, level, v)
end

function instruct_18(thingid)
    for i = 1, CC.MyThingNum do
        if JY.Base["��Ʒ" .. i] == thingid then
            return true
        end
    end
    return false
end

function instruct_19(x, y)
    JY.Base["��X1"] = x
    JY.Base["��Y1"] = y
    JY.SubSceneX = 0
    JY.SubSceneY = 0
end

function instruct_20()
    if JY.Base["����" .. CC.TeamNum] >= 0 then
        return true
    end
    return false
end

-- ��Ӻ���
function instruct_21(personid)
    if JY.Person[personid] == nil then
        lib.Debug("instruct_21 error: personid not exist")
        return
    end
    local j = 0
    for i = 1, CC.TeamNum do
        if personid == JY.Base["����" .. i] then
            j = i
        end
    end
    if j == 0 then
        return
    end
    for i = j + 1, CC.TeamNum do
        JY.Base["����" .. i - 1] = JY.Base["����" .. i]
    end
    JY.Base["����" .. CC.TeamNum] = -1
    if JY.Person[personid]["����"] >= 0 then
        JY.Thing[JY.Person[personid]["����"]]["ʹ����"] = -1
        JY.Person[personid]["����"] = -1
    end
    if JY.Person[personid]["����"] >= 0 then
        JY.Thing[JY.Person[personid]["����"]]["ʹ����"] = -1
        JY.Person[personid]["����"] = -1
    end
    if JY.Person[personid]["����"] >= 0 then
        JY.Thing[JY.Person[personid]["����"]]["ʹ����"] = -1
        JY.Person[personid]["����"] = -1
    end
    if JY.Person[personid]["������Ʒ"] >= 0 then
        JY.Thing[JY.Person[personid]["������Ʒ"]]["ʹ����"] = -1
        JY.Person[personid]["������Ʒ"] = -1
    end
    JY.Person[personid]["��Ʒ��������"] = 0
end

function instruct_22()
    for i = 1, CC.TeamNum do
        if JY.Base["����" .. i] >= 0 then
            JY.Person[JY.Base["����" .. i]]["����"] = 0
            JY.Person[JY.Base["����" .. i]]["�ж��̶�"] = 100
        end
    end
end

function instruct_23(personid, value)
    JY.Person[personid]["�ö�����"] = value
    AddPersonAttrib(personid, "�ö�����", 0)
end

function instruct_24()
    instruct_test("ָ��24����")
end

-- ��ͷ�ƶ�
function instruct_25(x1, y1, x2, y2)
    if JY.Restart == 1 then
        return
    end
    local sign = nil
    if y1 ~= y2 then
        if y2 < y1 then
            sign = -1
        else
            sign = 1
        end
        for i = y1 + sign, y2, sign do
            lib.GetKey()
            local t1 = lib.GetTime()
            JY.SubSceneY = JY.SubSceneY + sign
            DrawSMap()
            ShowScreen()
            local t2 = lib.GetTime()
            if t2 - t1 < CC.SceneMoveFrame then
                lib.Delay(CC.SceneMoveFrame - (t2 - t1))
            end
        end
    end
    if x1 ~= x2 then
        if x2 < x1 then
            sign = -1
        else
            sign = 1
        end
        for i = x1 + sign, x2, sign do
            lib.GetKey()
            local t1 = lib.GetTime()
            JY.SubSceneX = JY.SubSceneX + sign
            DrawSMap()
            ShowScreen()
            local t2 = lib.GetTime()
            if t2 - t1 < CC.SceneMoveFrame then
                lib.Delay(CC.SceneMoveFrame - (t2 - t1))
            end
        end
    end
end

function instruct_26(sceneid, id, v1, v2, v3)
    if sceneid == -2 then
        sceneid = JY.SubScene
    end
    local v = GetD(sceneid, id, 2)
    SetD(sceneid, id, 2, v + v1)
    v = GetD(sceneid, id, 3)
    SetD(sceneid, id, 3, v + v2)
    v = GetD(sceneid, id, 4)
    SetD(sceneid, id, 4, v + v3)
end

function instruct_27(id, startpic, endpic)
    local old1, old2, old3 = nil, nil, nil
    if id ~= -1 then
        old1 = GetD(JY.SubScene, id, 5)
        old2 = GetD(JY.SubScene, id, 6)
        old3 = GetD(JY.SubScene, id, 7)
    end
    for i = startpic, endpic, 2 do
        lib.GetKey()
        local t1 = lib.GetTime()
        if id == -1 then
            JY.MyPic = i / 2
        else
            SetD(JY.SubScene, id, 5, i)
            SetD(JY.SubScene, id, 6, i)
            SetD(JY.SubScene, id, 7, i)
        end
        DtoSMap()
        DrawSMap()
        ShowScreen()
        local t2 = lib.GetTime()
        if t2 - t1 < CC.AnimationFrame then
            lib.Delay(CC.AnimationFrame - (t2 - t1))
        end
    end
    if id ~= -1 then
        SetD(JY.SubScene, id, 5, old1)
        SetD(JY.SubScene, id, 6, old2)
        SetD(JY.SubScene, id, 7, old3)
    end
end

function instruct_28(personid, vmin, vmax)
    local v = JY.Person[personid]["Ʒ��"]
    if vmin <= v and v <= vmax then
        return true
    else
        return false
    end
end

function instruct_29(personid, vmin, vmax)
    local v = JY.Person[personid]["������"]
    if vmin <= v and v <= vmax then
        return true
    else
        return false
    end
end

-- �����Զ��ƶ�
function instruct_30(x1, y1, x2, y2)
    if JY.Restart == 1 then
        return
    end
    if x1 < x2 then
        for i = x1 + 1, x2 do
            local t1 = lib.GetTime()
            instruct_30_sub1(1)
            local t2 = lib.GetTime()
            if t2 - t1 < CC.PersonMoveFrame then
                lib.Delay(CC.PersonMoveFrame - (t2 - t1))
            end
        end
    elseif x2 < x1 then
        for i = x2 + 1, x1 do
            local t1 = lib.GetTime()
            instruct_30_sub1(2)
            local t2 = lib.GetTime()
            if t2 - t1 < CC.PersonMoveFrame then
                lib.Delay(CC.PersonMoveFrame - (t2 - t1))
            end
        end
    end
    if y1 < y2 then
        for i = y1 + 1, y2 do
            local t1 = lib.GetTime()
            instruct_30_sub1(3)
            local t2 = lib.GetTime()
            if t2 - t1 < CC.PersonMoveFrame then
                lib.Delay(CC.PersonMoveFrame - (t2 - t1))
            end
        end
    elseif y2 < y1 then
        for i = y2 + 1, y1 do
            local t1 = lib.GetTime()
            instruct_30_sub1(0)
            local t2 = lib.GetTime()
            if t2 - t1 < CC.PersonMoveFrame then
                lib.Delay(CC.PersonMoveFrame - (t2 - t1))
            end
        end
    end
end

function instruct_30_sub1(direct)
    local x, y = nil, nil
    AddMyCurrentPic()
    x = JY.Base["��X1"] + CC.DirectX[direct + 1]
    y = JY.Base["��Y1"] + CC.DirectY[direct + 1]
    JY.Base["�˷���"] = direct
    JY.MyPic = GetMyPic()
    DtoSMap()
    if SceneCanPass(x, y) == true then
        JY.Base["��X1"] = x
        JY.Base["��Y1"] = y
    end
    JY.Base["��X1"] = limitX(JY.Base["��X1"], 1, CC.SWidth - 2)
    JY.Base["��Y1"] = limitX(JY.Base["��Y1"], 1, CC.SHeight - 2)
    DrawSMap()
    ShowScreen()
    return 1
end

function instruct_30_sub(direct)
    local x, y = nil, nil
    local d_pass = GetS(JY.SubScene, JY.Base["��X1"], JY.Base["��Y1"], 3)

    if d_pass >= 0 and d_pass ~= JY.OldDPass then
        EventExecute(d_pass, 3)
        JY.OldDPass = d_pass
        JY.oldSMapX = -1
        JY.oldSMapY = -1
        JY.D_Valid = nil
    end

    JY.OldDPass = -1
    local isout = 0
    if (((JY.Scene[JY.SubScene]["����X1"] == JY.Base["��X1"] and JY.Scene[JY.SubScene]["����Y1"] ==
        JY.Base["��Y1"]) or JY.Scene[JY.SubScene]["����X2"] ~= JY.Base["��X1"] or JY.Scene[JY.SubScene]["����Y2"] ==
        JY.Base["��Y1"] or JY.Scene[JY.SubScene]["����X3"] == JY.Base["��X1"] and JY.Scene[JY.SubScene]["����Y3"] ==
        JY.Base["��Y1"])) then
        isout = 1
    end
    if isout == 1 then
        JY.Status = GAME_MMAP
        -- lib.PicInit()
        CleanMemory()
        lib.ShowSlow(20, 1)
        if JY.MmapMusic < 0 then
            JY.MmapMusic = JY.Scene[JY.SubScene]["��������"]
        end
        Init_MMap()
        JY.SubScene = -1
        JY.oldSMapX = -1
        JY.oldSMapY = -1
        local sc = CC.Shichen
        if CC.TX['ҹĻ'] == 1 then
            --sc = 6
        end
        lib.DrawMMap(JY.Base["��X"], JY.Base["��Y"], GetMyPic(), sc)
        lib.ShowSlow(20, 0)
        lib.GetKey()
        return
    end
    if JY.Scene[JY.SubScene]["��ת����"] >= 0 and JY.Base["��X1"] == JY.Scene[JY.SubScene]["��ת��X1"] and
        JY.Base["��Y1"] == JY.Scene[JY.SubScene]["��ת��Y1"] then
        JY.SubScene = JY.Scene[JY.SubScene]["��ת����"]
        lib.ShowSlow(20, 1)
        if JY.Scene[JY.SubScene]["�⾰���X1"] == 0 and JY.Scene[JY.SubScene]["�⾰���Y1"] == 0 then
            JY.Base["��X1"] = JY.Scene[JY.SubScene]["���X"]
            JY.Base["��Y1"] = JY.Scene[JY.SubScene]["���Y"]
        else
            JY.Base["��X1"] = JY.Scene[JY.SubScene]["��ת��X2"]
            JY.Base["��Y1"] = JY.Scene[JY.SubScene]["��ת��Y2"]
        end
        Init_SMap(1)
        return
    end
    AddMyCurrentPic()
    x = JY.Base["��X1"] + CC.DirectX[direct + 1]
    y = JY.Base["��Y1"] + CC.DirectY[direct + 1]
    JY.Base["�˷���"] = direct
    JY.MyPic = GetMyPic()
    DtoSMap()
    if SceneCanPass(x, y) == true then
        JY.Base["��X1"] = x
        JY.Base["��Y1"] = y
    end
    JY.Base["��X1"] = limitX(JY.Base["��X1"], 1, CC.SWidth - 2)
    JY.Base["��Y1"] = limitX(JY.Base["��Y1"], 1, CC.SHeight - 2)
    DrawSMap()
    ShowScreen()
    return 1
end

-- ����Ǯ�Ƿ��㹻
function instruct_31(num)
    local r = false
    if num <= CC.Gold then
        return true
    end
    return r
end

-- ���ӣ�������Ʒ�ĺ���
function instruct_32(thingid, num)
    local p = 1
    -- ���ȿ��ƻ�ȡ����������30000�Զ���30000
    for i = 1, CC.MyThingNum do
        if JY.Base["��Ʒ" .. i] == thingid then
            if thingid == 174 then
                -- JY.Base["��Ʒ����" .. i] = 0
                p = i
                break
            else
                -- �Ѿ���һ����������Ʒ��������֮�󳬹�30000����30000��
                if (JY.Base["��Ʒ����" .. i] + num) > 30000 then
                    JY.Base["��Ʒ����" .. i] = 30000
                else
                    JY.Base["��Ʒ����" .. i] = JY.Base["��Ʒ����" .. i] + num
                end
                p = i
                break
            end
        elseif JY.Base["��Ʒ" .. i] == -1 then
            if thingid == 174 then
                JY.Base["��Ʒ" .. i] = thingid
                -- JY.Base["��Ʒ����" .. i] = 0
                p = i
                break
            else
                JY.Base["��Ʒ" .. i] = thingid
                JY.Base["��Ʒ����" .. i] = num
                p = i
                break
            end
        end
    end

    -- ��ȡ������ʱ��ˢ��������ʾ
    if thingid == CC.MoneyID then
        CC.Gold = CC.Gold + num -- JY.Base["��Ʒ����" .. p]
        if CC.Gold < 0 then
            CC.Gold = 0
        end
    end
    -- ��ȡ���µ�ʱ��ˢ�²�����ʾ
    if thingid == CC.MJCZID then
        CC.MJCZ = CC.MJCZ + num -- JY.Base["��Ʒ����" .. p]
        if CC.MJCZ < 0 then
            CC.MJCZ = 0
        end
    end

    -- ������飬����15������
    -- ��õ�ʱ�������
    if num > 0 and thingid >= CC.BookStart and thingid < CC.BookStart + CC.BookNum then
        -- JY.Person[0]["����"] = JY.Person[0]["����"] + 15;
        JY.Base["��������"] = JY.Base["��������"] + 1
        -- �޾Ʋ�������520�������Ʒ���ж�����ժȡ���������
        -- �滻�������ͼ
        JY.Person[520]["Ʒ��"] = JY.Person[520]["Ʒ��"] + 1
        -- ���Ѿ��ֹ���������£�����������521�������Ʒ���ж��Ƿ��Ѵ��������¼�
        if JY.Person[521]["Ʒ��"] == 1 then
            addevent(70, 65, 1, 4119, 1, 2366 * 2)
        end

    end

    if JY.Base["��Ʒ����" .. p] <= 0 then
        if thingid == 174 then
            if CC.Gold <= 0 then
                for i = p + 1, CC.MyThingNum do
                    JY.Base["��Ʒ" .. i - 1] = JY.Base["��Ʒ" .. i]
                    JY.Base["��Ʒ����" .. i - 1] = JY.Base["��Ʒ����" .. i]
                end
                JY.Base["��Ʒ" .. CC.MyThingNum] = -1
                JY.Base["��Ʒ����" .. CC.MyThingNum] = 0
            end
        elseif thingid == 550 then
            if CC.MJCZ <= 0 then
                for i = p + 1, CC.MyThingNum do
                    JY.Base["��Ʒ" .. i - 1] = JY.Base["��Ʒ" .. i]
                    JY.Base["��Ʒ����" .. i - 1] = JY.Base["��Ʒ����" .. i]
                end
                JY.Base["��Ʒ" .. CC.MyThingNum] = -1
                JY.Base["��Ʒ����" .. CC.MyThingNum] = 0
            end
        else
            for i = p + 1, CC.MyThingNum do
                JY.Base["��Ʒ" .. i - 1] = JY.Base["��Ʒ" .. i]
                JY.Base["��Ʒ����" .. i - 1] = JY.Base["��Ʒ����" .. i]
            end
            JY.Base["��Ʒ" .. CC.MyThingNum] = -1
            JY.Base["��Ʒ����" .. CC.MyThingNum] = 0
        end
    end
    CC.JLWP[#CC.JLWP + 1] = thingid
end

-- ����ѧ���书
function instruct_33(personid, wugongid, flag)
    local xwperson; -- �ж�Ҫѧ�书����
    xwperson = personid
    if flag == nil then
        flag = 50
    end
    if personid == JY.Base["����"] or personid == 0 then
        xwperson = 0
    end
    local add = 0
    local dkfcj_ng = JY.Wugong[wugongid]['�㼶']
    local kflx = JY.Wugong[wugongid]['�书����']
    local yes = 1
    local okf = KF_yimai(personid, wugongid)
    if PersonKF(personid, wugongid) == true then
        DrawStrBoxWaitKey(
            string.format("%s�Ѿ�ѧ��%s", JY.Person[personid]["����"], JY.Wugong[wugongid]["����"]), C_ORANGE,
            CC.DefaultFont)
        return 1
    end
    if JY.Person[personid]['�书15'] > 0 then
        DrawStrBoxWaitKey(string.format("%s������ѧϰ�����书%s", JY.Person[personid]["����"], ''), C_ORANGE,
            CC.DefaultFont)
        return 1
    end
    local dkfcj_ng = JY.Wugong[wugongid]['�㼶']
    local kflx = JY.Wugong[wugongid]['�书����']
    local pd = false
    -- ���ɳ��и߽��书һ�����
    if JY.Wugong[wugongid]['����'] == JY.Person[personid]['����'] and PersonKF(personid, wugongid) == false and
        JY.Wugong[wugongid]['����'] > 0 then
        local pd = 0
        for i = 1, JY.Base['�书����'] do
            local kfyes = JY.Person[personid]["�书" .. i]
            if kfyes > 0 then
                if JY.Wugong[wugongid]['����'] == JY.Wugong[kfyes]['����'] then
                    lib.Debug(JY.Wugong[kfyes]['����'] .. ' ���ɳɹ� ' .. JY.Wugong[wugongid]['����'])
                    if JY.Wugong[kfyes]['�书����'] == kflx and (dkfcj_ng < 4 or JY.Wugong[kfyes]['�书����'] == 7) then
                        lib.Debug(JY.Wugong[kfyes]['����'] .. ' ���ͳɹ� ' .. JY.Wugong[wugongid]['����'] ..
                                      '  �㼶' .. JY.Wugong[kfyes]['�㼶'] .. ' ' .. dkfcj_ng)
                        if JY.Wugong[kfyes]['�㼶'] < dkfcj_ng then
                            lib.Debug(JY.Wugong[kfyes]['����'] .. ' �㼶�ɹ� ' .. JY.Wugong[wugongid]['����'])
                            if DrawStrBoxYesNo(-1, -1,
                                MP_name(personid) .. "�书һ����У��Ƿ�" .. JY.Wugong[kfyes]['����'] ..
                                    'ϴΪ' .. JY.Wugong[wugongid]['����'] .. '?', C_WHITE, CC.DefaultFont) then
                                JY.Person[personid]["�书" .. i] = wugongid
                                JY.Person[personid]["�书�ȼ�" .. i] = flag
                                if JY.Person[personid]["�츳�ڹ�"] == kfyes then
                                    JY.Person[personid]["�츳�ڹ�"] = wugongid
                                elseif JY.Person[personid]["�츳�Ṧ"] == kfyes then
                                    JY.Person[personid]["�츳�Ṧ"] = wugongid
                                elseif JY.Person[personid]["�츳�⹦1"] == kfyes then
                                    JY.Person[personid]["�츳�⹦1"] = wugongid
                                elseif JY.Person[personid]["�츳�⹦2"] == kfyes then
                                    JY.Person[personid]["�츳�⹦2"] = wugongid
                                end
                                yes = 2
                                Hp_Max(personid)
                                Mp_Max(personid)
                                MIJI_PD(personid, wugongid)
                                break
                            end
                        end
                    end
                end
            end
        end
    end
    local nkf = wugongid
    if PersonKF(personid, okf) and PersonKF(personid, nkf) == false then
        if DrawStrBoxYesNo(-1, -1,
            JY.Wugong[nkf]['����'] .. JY.Wugong[okf]['����'] .. "һ����У��Ƿ�" ..
                JY.Wugong[okf]['����'] .. "ϴΪ" .. JY.Wugong[nkf]['����'] .. "?", C_WHITE, CC.DefaultFont) then
            for i = 1, JY.Base["�书����"] do
                if JY.Person[personid]["�书" .. i] == okf then
                    JY.Person[personid]["�书" .. i] = nkf
                    JY.Person[personid]["�书�ȼ�" .. i] = flag
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
                    Hp_Max(personid)
                    Mp_Max(personid)
                    MIJI_PD(personid, wugongid)
                    break
                end
            end
            yes = 2
        end
    end

    if yes == 1 then
        -- lib.Debug('û��һ�����ж�')	
        for i = 1, JY.Base["�书����"] do
            if JY.Person[xwperson]["�书" .. i] == 0 then
                JY.Person[xwperson]["�书" .. i] = wugongid
                JY.Person[xwperson]["�书�ȼ�" .. i] = flag
                Hp_Max(personid)
                Mp_Max(personid)
                MIJI_PD(xwperson, KF_thing(wugongid))
                break
            end
        end

    end

    for i, v in pairs(CC.Copy) do
        if v == personid then
            xwperson = i
            personid = xwperson
            local add = 0
            if PersonKF(personid, okf) and PersonKF(personid, nkf) == false then
                if DrawStrBoxYesNo(-1, -1,
                    JY.Wugong[nkf]['����'] .. JY.Wugong[okf]['����'] .. "һ����У��Ƿ�" ..
                        JY.Wugong[okf]['����'] .. "ϴΪ" .. JY.Wugong[nkf]['����'] .. "?", C_WHITE, CC.DefaultFont) then
                    for i = 1, JY.Base["�书����"] do
                        if JY.Person[personid]["�书" .. i] == okf then
                            JY.Person[personid]["�书" .. i] = nkf
                            JY.Person[personid]["�书�ȼ�" .. i] = flag
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
                            Hp_Max(personid)
                            Mp_Max(personid)
                            MIJI_PD(personid, wugongid)
                            yes = 2
                            break
                        end
                    end
                end
            end
            if yes == 1 then
                for i = 1, JY.Base["�书����"] do
                    if JY.Person[xwperson]["�书" .. i] == 0 then
                        JY.Person[xwperson]["�书" .. i] = wugongid
                        JY.Person[xwperson]["�书�ȼ�" .. i] = flag
                        Hp_Max(xwperson)
                        Mp_Max(xwperson)
                        MIJI_PD(xwperson, KF_thing(wugongid))
                        break
                    end
                end
            end
            break
        end
    end
    -- if flag > 0 then
    DrawStrBoxWaitKey(string.format("%s ѧ���书 %s", JY.Person[xwperson]["����"], JY.Wugong[wugongid]["����"]),
        C_ORANGE, CC.DefaultFont)
    -- end	
    KF_addsx(personid, wugongid)
    KF_zsset(personid, wugongid)
    Hp_Max(xwperson)
    Mp_Max(xwperson)
end

-- �ı�����
function instruct_34(id, value)
    local xwperson; -- �ж�����
    if id == JY.Base["����"] then
        xwperson = 0
    else
        xwperson = id
    end
    local add, str = AddPersonAttrib(xwperson, "����", value)
    DrawStrBoxWaitKey(JY.Person[xwperson]["����"] .. str, C_ORANGE, CC.DefaultFont)
end

-- ϴ�书����
function instruct_35(personid, id, wugongid, wugonglevel)
    local xwperson; -- �ж�Ҫϴ�书����
    xwperson = personid
    -- ��ϴ�����书���Զ��б����
    if JY.Person[xwperson]["�书" .. id + 1] > 0 then
        if JY.Person[xwperson]["�书" .. id + 1] == JY.Person[xwperson]["����ʹ��"] then
            JY.Person[xwperson]["����ʹ��"] = 0
        elseif JY.Person[xwperson]["�书" .. id + 1] == JY.Person[xwperson]["�����ڹ�"] then
            JY.Person[xwperson]["�����ڹ�"] = 0
        elseif JY.Person[xwperson]["�书" .. id + 1] == JY.Person[xwperson]["�����Ṧ"] then
            JY.Person[xwperson]["�����Ṧ"] = 0
        end
    end
    if isteam(xwperson) then
        Hp_Max(xwperson)
        Mp_Max(xwperson)
    end
    local pd = 0
    for i = 1, JY.Base['�书����'] do
        if JY.Person[xwperson]['�书' .. i] == wugongid then
            pd = 1
        end
    end
    if pd == 0 then
        local owg = JY.Person[xwperson]["�书" .. id + 1]
        JY.Person[xwperson]["�书" .. id + 1] = wugongid
        JY.Person[xwperson]["�书�ȼ�" .. id + 1] = wugonglevel
        DrawStrBoxWaitKey(JY.Person[personid]["����"] .. '�����书' .. JY.Wugong[owg]['����'] ..
                              '���������书' .. JY.Wugong[wugongid]['����'], C_ORANGE, CC.DefaultFont)
        Hp_Max(xwperson)
        Mp_Max(xwperson)
    else
        say('�Ѿ�ѧ����' .. JY.Wugong[wugongid]['����'] ..
                '�������ٴ�ѧϰ����ϧ�����һ����ѧ�Ļ��ᡣ', personid, 1)
    end

    if JY.Base['����'] == xwperson then
        xwperson = 0
        -- ��ϴ�����书���Զ��б����
        if JY.Person[xwperson]["�书" .. id + 1] > 0 then
            if JY.Person[xwperson]["�书" .. id + 1] == JY.Person[xwperson]["����ʹ��"] then
                JY.Person[xwperson]["����ʹ��"] = 0
            elseif JY.Person[xwperson]["�书" .. id + 1] == JY.Person[xwperson]["�����ڹ�"] then
                JY.Person[xwperson]["�����ڹ�"] = 0
            elseif JY.Person[xwperson]["�书" .. id + 1] == JY.Person[xwperson]["�����Ṧ"] then
                JY.Person[xwperson]["�����Ṧ"] = 0
            end
        end
        if isteam(xwperson) then
            Hp_Max(xwperson)
            Mp_Max(xwperson)
        end
        local pd = 0
        for i = 1, JY.Base['�书����'] do
            if JY.Person[xwperson]['�书' .. i] == wugongid then
                pd = 1
            end
        end
        if pd == 0 then
            local owg = JY.Person[xwperson]["�书" .. id + 1]
            JY.Person[xwperson]["�书" .. id + 1] = wugongid
            JY.Person[xwperson]["�书�ȼ�" .. id + 1] = wugonglevel
            DrawStrBoxWaitKey(JY.Person[personid]["����"] .. '�����书' .. JY.Wugong[owg]['����'] ..
                                  '���������书' .. JY.Wugong[wugongid]['����'], C_ORANGE, CC.DefaultFont)
            Hp_Max(xwperson)
            Mp_Max(xwperson)
        else
            say('�Ѿ�ѧ����' .. JY.Wugong[wugongid]['����'] ..
                    '�������ٴ�ѧϰ����ϧ�����һ����ѧ�Ļ��ᡣ', personid, 1)
        end
    end

    for i, v in pairs(CC.Copy) do
        if v == personid then
            -- if CC.Copy[personid] ~= nil then 
            xwperson = i
            -- ��ϴ�����书���Զ��б����
            if JY.Person[xwperson]["�书" .. id + 1] > 0 then
                if JY.Person[xwperson]["�书" .. id + 1] == JY.Person[xwperson]["����ʹ��"] then
                    JY.Person[xwperson]["����ʹ��"] = 0
                elseif JY.Person[xwperson]["�书" .. id + 1] == JY.Person[xwperson]["�����ڹ�"] then
                    JY.Person[xwperson]["�����ڹ�"] = 0
                elseif JY.Person[xwperson]["�书" .. id + 1] == JY.Person[xwperson]["�����Ṧ"] then
                    JY.Person[xwperson]["�����Ṧ"] = 0
                end
            end
            local pd = 0
            for i = 1, JY.Base['�书����'] do
                if JY.Person[xwperson]['�书' .. i] == wugongid then
                    pd = 1
                end
            end
            if pd == 0 then
                local owg = JY.Person[xwperson]["�书" .. id + 1]
                JY.Person[xwperson]["�书" .. id + 1] = wugongid
                JY.Person[xwperson]["�书�ȼ�" .. id + 1] = wugonglevel
                DrawStrBoxWaitKey(JY.Person[personid]["����"] .. '�����书' .. JY.Wugong[owg]['����'] ..
                                      '���������书' .. JY.Wugong[wugongid]['����'], C_ORANGE, CC.DefaultFont)
                Hp_Max(xwperson)
                Mp_Max(xwperson)
            else
                say('�Ѿ�ѧ����' .. JY.Wugong[wugongid]['����'] ..
                        '�������ٴ�ѧϰ����ϧ�����һ����ѧ�Ļ��ᡣ', personid, 1)
            end
        end
    end
    MIJI_PD(xwperson, KF_thing(wugongid))
    KF_addsx(xwperson, wugongid)
    if JY.Base['����'] > 0 then
        KF_zsset(JY.Base['����'], wugongid)
    end
    KF_zsset(xwperson, wugongid)
end

function instruct_36(sex)
    if JY.Person[0]["�Ա�"] == sex then
        return true
    else
        return false
    end
end

-- �޾Ʋ������Ӽ�������ʾ
function instruct_37(v)
    AddPersonAttrib(0, "Ʒ��", v)
    if v < 0 then
        for i = 1, 15 do
            if JY.Restart == 1 then
                break
            end
            local y_off = i * 2 + CC.DefaultFont + CC.RowPixel
            DrawString(CC.ScreenW / 2 - CC.DefaultFont * 5, CC.ScreenH / 4 - CC.DefaultFont - CC.RowPixel + y_off,
                "��ĵ���ָ���½���" .. -v .. "��", M_DeepSkyBlue, CC.DefaultFont)
            ShowScreen()
            lib.Delay(50)
            Cls()
        end
    else
        for i = 1, 15 do
            if JY.Restart == 1 then
                break
            end
            local y_off = i * 2 + CC.DefaultFont + CC.RowPixel
            DrawString(CC.ScreenW / 2 - CC.DefaultFont * 5, CC.ScreenH / 4 + 30 + CC.DefaultFont + CC.RowPixel - y_off,
                "��ĵ���ָ��������" .. v .. "��", PinkRed, CC.DefaultFont)
            ShowScreen()
            lib.Delay(50)
            Cls()
        end
    end
end

function instruct_38(sceneid, level, oldpic, newpic)
    if sceneid == -2 then
        sceneid = JY.SubScene
    end
    for i = 0, CC.SWidth - 1 do
        for j = 1, CC.SHeight - 1 do
            if GetS(sceneid, i, j, level) == oldpic then
                SetS(sceneid, i, j, level, newpic)
            end
        end
    end
end

function instruct_39(sceneid)
    JY.Scene[sceneid]["��������"] = 0
end

function instruct_40(v)
    JY.Base["�˷���"] = v
    JY.MyPic = GetMyPic()
end

function instruct_41(personid, thingid, num)
    local k = 0
    for i = 1, 4 do
        if JY.Person[personid]["Я����Ʒ" .. i] == thingid then
            JY.Person[personid]["Я����Ʒ����" .. i] = JY.Person[personid]["Я����Ʒ����" .. i] + num
            k = i
            break
        end
    end
    if k > 0 and JY.Person[personid]["Я����Ʒ����" .. k] <= 0 then
        JY.Person[personid]["Я����Ʒ" .. k] = -1
    end
    if k == 0 then
        for i = 1, 4 do
            if JY.Person[personid]["Я����Ʒ" .. i] == -1 then
                JY.Person[personid]["Я����Ʒ" .. i] = thingid
                JY.Person[personid]["Я����Ʒ����" .. i] = num
                break
            end
        end
    end
end

function instruct_42()
    local r = false
    for i = 1, CC.TeamNum do
        if JY.Base["����" .. i] >= 0 and JY.Person[JY.Base["����" .. i]]["�Ա�"] == 1 then
            r = true
        end
    end
    return r
end

function instruct_43(thingid)
    return instruct_18(thingid)
end

function instruct_44(id1, startpic1, endpic1, id2, startpic2, endpic2)
    local old1 = GetD(JY.SubScene, id1, 5)
    local old2 = GetD(JY.SubScene, id1, 6)
    local old3 = GetD(JY.SubScene, id1, 7)
    local old4 = GetD(JY.SubScene, id2, 5)
    local old5 = GetD(JY.SubScene, id2, 6)
    local old6 = GetD(JY.SubScene, id2, 7)
    for i = startpic1, endpic1, 2 do
        lib.GetKey()
        local t1 = lib.GetTime()
        if id1 == -1 then
            JY.MyPic = i / 2
        else
            SetD(JY.SubScene, id1, 5, i)
            SetD(JY.SubScene, id1, 6, i)
            SetD(JY.SubScene, id1, 7, i)
        end
        if id2 == -1 then
            JY.MyPic = i / 2
        else
            SetD(JY.SubScene, id2, 5, i - startpic1 + startpic2)
            SetD(JY.SubScene, id2, 6, i - startpic1 + startpic2)
            SetD(JY.SubScene, id2, 7, i - startpic1 + startpic2)
        end
        DtoSMap()
        DrawSMap()
        ShowScreen()
        local t2 = lib.GetTime()
        if t2 - t1 < CC.AnimationFrame then
            lib.Delay(CC.AnimationFrame - (t2 - t1))
        end
    end
    SetD(JY.SubScene, id1, 5, old1)
    SetD(JY.SubScene, id1, 6, old2)
    SetD(JY.SubScene, id1, 7, old3)
    SetD(JY.SubScene, id2, 5, old4)
    SetD(JY.SubScene, id2, 6, old5)
    SetD(JY.SubScene, id2, 7, old6)
end

-- ����
function instruct_45(id, value)
    local xwperson; -- �ж�Ҫϴ�书����
    if id == JY.Base["����"] then
        xwperson = 0
    else
        xwperson = id
    end
    local add, str = AddPersonAttrib(xwperson, "�Ṧ", value)
end

-- ����
function instruct_46(id, value)
    local xwperson; -- �ж�Ҫϴ�书����
    if id == JY.Base["����"] then
        xwperson = 0
    else
        xwperson = id
    end
    local add, str = AddPersonAttrib(xwperson, "�������ֵ", value)
    AddPersonAttrib(xwperson, "����", 0)
end

-- �ӹ�
function instruct_47(id, value)
    local xwperson; -- �ж�Ҫϴ�书����
    if id == JY.Base["����"] then
        xwperson = 0
    else
        xwperson = id
    end
    local add, str = AddPersonAttrib(xwperson, "������", value)
end

-- �ӷ�
function add_deffense(id, value)
    local xwperson; -- �ж�Ҫϴ�书����
    if id == JY.Base["����"] then
        xwperson = 0
    else
        xwperson = id
    end
    local add, str = AddPersonAttrib(xwperson, "������", value)
end

-- ��Ѫ
function instruct_48(id, value)
    local xwperson; -- �ж�Ҫϴ�书����
    if id == JY.Base["����"] then
        xwperson = 0
    else
        xwperson = id
    end
    local add, str = AddPersonAttrib(xwperson, "�������ֵ", value)
    AddPersonAttrib(xwperson, "����", value)
end

-- ϴ����
function instruct_49(personid, value)
    local xwperson; -- �ж�Ҫϴ��������
    if personid == JY.Base["����"] then
        xwperson = 0
    else
        xwperson = personid
    end
    JY.Person[xwperson]["��������"] = value
    JY.Person[personid]["��������"] = value
    if match_ID(personid, 9771) then
        value = 1
    end
end

function instruct_50(id1, id2, id3, id4, id5)
    local num = 0
    if instruct_18(id1) == true then
        num = num + 1
    end
    if instruct_18(id2) == true then
        num = num + 1
    end
    if instruct_18(id3) == true then
        num = num + 1
    end
    if instruct_18(id4) == true then
        num = num + 1
    end
    if instruct_18(id5) == true then
        num = num + 1
    end
    if num == 5 then
        return true
    else
        return false
    end
end

function instruct_51()
    instruct_1(2547 + Rnd(18), 114, 0)
end

function instruct_52()
    DrawStrBoxWaitKey(string.format("�����ڵ�Ʒ��ָ��Ϊ: %d", JY.Person[0]["Ʒ��"]), C_ORANGE, CC.DefaultFont)
end

function instruct_53()
    -- DrawStrBoxWaitKey(string.format("�����ڵ�����ָ��Ϊ: %d", JY.Person[0]["����"]), C_ORANGE, CC.DefaultFont)
end

function instruct_54()
    for i = 0, JY.SceneNum - 1 do
        JY.Scene[i]["��������"] = 0
    end
    JY.Scene[2]["��������"] = 2
    JY.Scene[38]["��������"] = 2
    JY.Scene[75]["��������"] = 1
    JY.Scene[80]["��������"] = 1
end

function instruct_55(id, num)
    if GetD(JY.SubScene, id, 2) == num then
        return true
    else
        return false
    end
end

function instruct_56(v)
    -- JY.Person[0]["����"] = JY.Person[0]["����"] + v
    -- instruct_2_sub()
end

function instruct_57()
    instruct_27(-1, 7664, 7674)
    for i = 0, 56, 2 do
        local t1 = lib.GetTime()
        if JY.MyPic < 3844 then
            JY.MyPic = (7676 + i) / 2
        end
        SetD(JY.SubScene, 2, 5, i + 7690)
        SetD(JY.SubScene, 2, 6, i + 7690)
        SetD(JY.SubScene, 2, 7, i + 7690)
        SetD(JY.SubScene, 3, 5, i + 7748)
        SetD(JY.SubScene, 3, 6, i + 7748)
        SetD(JY.SubScene, 3, 7, i + 7748)
        SetD(JY.SubScene, 4, 5, i + 7806)
        SetD(JY.SubScene, 4, 6, i + 7806)
        SetD(JY.SubScene, 4, 7, i + 7806)
        DtoSMap()
        DrawSMap()
        ShowScreen()
        local t2 = lib.GetTime()
        if t2 - t1 < CC.AnimationFrame then
            lib.Delay(CC.AnimationFrame - (t2 - t1))
        end
    end
end

function instruct_58()
    local group = 5
    local num1 = 6
    local num2 = 3
    local startwar = 102
    local flag = {}
    for i = 0, group - 1 do
        for j = 0, num1 - 1 do
            flag[j] = 0
        end
        for j = 1, num2 do
            local r = nil
            while 1 do
                r = Rnd(num1)
                if flag[r] == 0 then
                    flag[r] = 1
                    do
                        break
                    end
                end
            end
            local warnum = r + i * num1
            WarLoad(warnum + startwar)
            instruct_1(2854 + warnum, WAR.Data["����1"], 0)
            instruct_0()
            if WarMain(warnum + startwar, 0) == true then
                instruct_0()
                instruct_13()
                TalkEx("������λǰ���ϴͽ̣�", 0, 1)
                instruct_0()
            else
                instruct_15()
                return
            end
        end
        if i < group - 1 then
            TalkEx(JY.Person[0]["���"] .. "����ս������*������Ϣ��ս��", 70, 0)
            instruct_0()
            instruct_14()
            lib.Delay(300)
            if JY.Person[0]["���˳̶�"] < 50 and JY.Person[0]["�ж��̶�"] <= 0 then
                JY.Person[0]["���˳̶�"] = 0
                AddPersonAttrib(0, "����", math.huge)
                AddPersonAttrib(0, "����", math.huge)
                AddPersonAttrib(0, "����", math.huge)
            end
            instruct_13()
            TalkEx("���Ѿ���Ϣ���ˣ�*��˭Ҫ���ϣ�", 0, 1)
            instruct_0()
        end
    end
    TalkEx("��������˭��**��������*��������***û��������", 0, 1)
    instruct_0()
    TalkEx("�����û����Ҫ��������λ*" .. JY.Person[0]["���"] ..
               "��ս���������书����*��һ֮������������֮λ��*������λ" ..
               JY.Person[0]["���"] ..
               "��ã�***������������*������������*������������*�ã���ϲ" ..
               JY.Person[0]["���"] .. "������������*֮λ����" .. JY.Person[0]["���"] ..
               "��ã������*���������ȡ�Ҳ���㱣�ܣ�", 70, 0)
    instruct_0()
    TalkEx("��ϲ" .. JY.Person[0]["���"] .. "��", 12, 0)
    instruct_0()
    TalkEx("С�ֵܣ���ϲ�㣡", 64, 4)
    instruct_0()
    TalkEx(
        "�ã���������ִ�ᵽ����*Բ��������ϣ�������λ��*��ͬ�����ٵ��һ�ɽһ�Σ�",
        19, 0)
    instruct_0()
    instruct_14()
    for i = 24, 72 do
        instruct_3(-2, i, 0, 0, -1, -1, -1, -1, -1, -1, -2, -2, -2)
    end
    instruct_0()
    instruct_13()
    TalkEx(
        "����ǧ����࣬����춴��*Ⱥ�ۣ��õ�����������֮λ*�����ȣ�*���ǡ�ʥ�á������أ�*Ϊʲ��û�˸����ң��ѵ���*�Ҷ���֪����*�������е����ˣ�",
        0, 1)
    instruct_0()
    instruct_2(143, 1)
end

-- ȫ���������
function instruct_59()
    for i = CC.TeamNum, 2, -1 do
        if JY.Base["����" .. i] >= 0 then
            instruct_21(JY.Base["����" .. i])
        end
    end
    for i, v in ipairs(CC.AllPersonExit) do
        instruct_3(v[1], v[2], 0, 0, -1, -1, -1, -1, -1, -1, 0, -2, -2)
    end
end

function instruct_60(sceneid, id, num)
    if sceneid == -2 then
        sceneid = JY.SubScene
    end
    if id == -2 then
        id = JY.CurrentD
    end
    if GetD(sceneid, id, 5) == num then
        return true
    else
        return false
    end
end

function instruct_61()
    for i = 11, 24 do
        if GetD(JY.SubScene, i, 5) ~= 4664 then
            return false
        end
    end
    return true
end

-- ͨ�غ���
function instruct_62(id1, startnum1, endnum1, id2, startnum2, endnum2)
    -- JY.MyPic = -1
    -- instruct_44(id1, startnum1, endnum1, id2, startnum2, endnum2)
    -- ShowScreen()
    lib.Delay(200)
    say("������Ϸ�͵������ˣ�ѡ�����¿�ʼ�ɽ�����һ��Ŀ����Ϸ��", 260, 5, "�޾Ʋ���")
    lib.PlayMPEG("ending.mp4", VK_ESCAPE)
    os.remove(CONFIG.DataPath .. 'WeeklyAwards')

    -- ������Ŀ
    local x = AddZM()
    if JY.Base["��Ŀ"] == CC.Week and CC.Jl == 0 then
        CC.Jl = 1
        CC.Sp = JY.Base["��Ƭ"] + x
        DrawStrBoxWaitKey("��á�����Ŀ��Ƭ�ϡ���" .. x, C_ORANGE, CC.DefaultFont, 2)
    end
    tgsave()
    Cls()
    lib.PlayMPEG(CONFIG.DataPath .. "/avi/2.mp4", VK_ESCAPE) -- ��Ƶ�ļ�
    Cls()
    -- lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_BLACK)
    --[[
	DrawString(350, 200, "Ƭβ�����Ĵ�ɽ��", C_WHITE, CC.DefaultFont)
	DrawString(375, 300, "�ݳ����Ϸ���", C_WHITE, CC.DefaultFont)
	ShowScreen()
  
	PlayMIDI(116)
	local stime = 0
	local a = 1
	local lyrics = {
	{530,"�� �����Сʱ ���Ĵ�ĥ"},
	{560,"����ϷΪ��ʲô��Ц��"},
	{590,"ǰ��Ԫ�Ϲ��������"},
	{610,"��Դ�������ֿɵ�"},
	{640,"�ҵ� �����˵� ȴ�κ� ������������"},
	{680,"�����Ѳ� ��ɵǮ�� ˭��������Ա���ʸ�"},
	{730,"��̳�� ����Ҫͳһ ��������ȥ"},
	{810,"���Ǯ��** �Ҽǵ��� ��������һ��"},
	{920,"���� ���� ��������"},
	{940,"��Ϯ���Ĵ�����Ĳ���"},
	{970,"���� ���� ��������"},
	{1000,"ֻҪ�������Ǿ����ҵ�"},
	{1030,"���� ���� ��������"},
	{1050,"������ɫ���ǵ�������"},
	{1070,"���� ���� ��������"},
	{1100,"���Ǯ���վ�Ҫ������"},
	{1220,"�� ��ı�ƻ��� ����̳����"},
	{1250,"������ Ӯ��ʲô ɾ���"},
	{1280,"����˭�� ԭ�������"},
	{1300,"��Դ�� �ұ��Ƴ�Ϯ"},
	{1320,"�ҵ���Ϸ���� ȴ�κ�"},
	{1350,"ͽ������һ��"},
	{1370,"û������ ��������"},
	{1390,"˭��������ҵ��ʸ�"},
	{1410,"С���� ��������ȥ �峺Ǯ����"},
	{1510,"���Ǯ��** �Ҽǵ��� �����Ļ���ȥ"},
	{1610,"���� ���� ��������"},
	{1630,"�������Ĵ������ʵ��"},
	{1660,"���� ���� ��������"},
	{1680,"������˵��û��������"},
	{1710,"���� ���� ��������"},
	{1730,"��������������������"},
	{1760,"���� ���� ��������"},
	{1780,"���Ǯ���վ�Ҫ������"},
	{2100,"���� ���� ��������"},
	{2120,"��Ϯ���Ĵ�����Ĳ���"},
	{2140,"���� ���� ��������"},
	{2170,"ֻҪ�������Ǿ����ҵ�"},
	{2190,"���� ���� ��������"},
	{2210,"������ɫ���ǵ�������"},
	{2240,"���� ���� ��������"},
	{2260,"���Ǯ���վ�Ҫ������"},
	{2310,"��̳�� ����Ҫͳһ ��������ȥ"},
	{2390,"���Ǯ��** �Ҽǵ��� ��������һ��"},
	{2700,"ȫ���� ��л֧��"},
	{2750," "}
	}
	while true do
		if JY.Restart == 1 then
			break
		end
		local key = lib.GetKey()
		lib.Delay(CC.Frame)
		stime = stime + 1
		if stime == lyrics[a][1] then
			local size = CC.DefaultFont
			Cls()
			lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_BLACK)
			DrawString(350, 200, "Ƭβ�����Ĵ�ɽ��", C_WHITE, size)
			DrawString(375, 300, "�ݳ����Ϸ���", C_WHITE, size)
			local align = CC.ScreenW/2 - (string.len(lyrics[a][2])/2*size)/2
			DrawString(align, 500, lyrics[a][2], C_WHITE, size)
			ShowScreen()
			a = a + 1
		end
		if a > #lyrics then
			break
		end
		if key == VK_ESCAPE then
			break
		end
	end
	]]
    Cls()

    JY.Status = GAME_END;
end

function instruct_63(personid, sex)
    JY.Person[personid]["�Ա�"] = sex
end

-- �޾Ʋ������̵�����
function instruct_64()
    local headid = 223
    local id = -1
    for i = 0, JY.ShopNum - 1 do
        if CC.ShopScene[i].sceneid == JY.SubScene then
            id = i
            -- say(id,1,1)
        end
    end
    if id < 0 then
        return
    end
    TalkEx("��λС�磬������ʲô��Ҫ�ģ�С�����Ķ�����Ǯ���Թ�����", headid, 0, "�̼�")
    -- lib.LoadPNG(91, 10 * 2 , -1, -1, 1)
    local menu = {}
    local thingnum = {}
    -- 0���� 1����  2���� 3���� 4����
    -- CC.ShopScene[0]={sceneid=153,d_shop=16,d_leave={17,18}, };
    -- CC.ShopScene[1]={sceneid=3,d_shop=14,d_leave={15,16}, };
    -- CC.ShopScene[2]={sceneid=40,d_shop=20,d_leave={21,22}, };
    -- CC.ShopScene[3]={sceneid=60,d_shop=16,d_leave={17,18}, };
    -- CC.ShopScene[4]={sceneid=159,d_shop=9,d_leave={10,11,12}, };
    -- JY.Shop[0]["��Ʒ" .. 4] = 13
    -- JY.Shop[0]["��Ʒ����" .. 4] = 1
    for i = 1, 6 do
        local thingid = JY.Shop[id]["��Ʒ" .. i]
        if thingid ~= -1 then
            menu[i] = {}
            menu[i][1] = thingid
            menu[i][2] = JY.Shop[id]["��Ʒ�۸�" .. i]
            menu[i][3] = JY.Shop[id]["��Ʒ����" .. i]
            thingnum[i] = JY.Shop[id]["��Ʒ����" .. i]
            if JY.Shop[id]["��Ʒ����" .. i] > 0 then
                menu[i][4] = 1
            else
                menu[i][4] = nil
            end
        end
    end
    -- 3����ǰû�л�Ԫ
    if JY.Base["��������"] < 3 and id == 0 then
        menu[6][4] = nil
    end
    Shopmenu(menu, thingnum)
    for i, v in ipairs(CC.ShopScene[id].d_leave) do
        instruct_3(-2, v, 0, -2, -1, -1, 939, -1, -1, -1, -2, -2, -2)
    end
end

function instruct_65()
    local id = -1
    for i = 0, JY.ShopNum - 1 do
        if CC.ShopScene[i].sceneid == JY.SubScene then
            id = i
        end
    end
    if id < 0 then
        return
    end
    instruct_3(-2, CC.ShopScene[id].d_shop, 0, -2, -1, -1, -1, -1, -1, -1, -2, -2, -2)
    for i, v in ipairs(CC.ShopScene[id].d_leave) do
        instruct_3(-2, v, 0, -2, -1, -1, -1, -1, -1, -1, -2, -2, -2)
    end
    local newid = id + 1
    if newid >= 5 then
        newid = 0
    end
    instruct_3(CC.ShopScene[newid].sceneid, CC.ShopScene[newid].d_shop, 1, -2, 938, -1, -1, 8256, 8256, 8256, -2, -2, -2)
end

function instruct_66(id)
    PlayMIDI(id)
end

function instruct_67(id)
    PlayWavAtk(id)
end

-- ѧ���ؼ�
function instruct_68(id, mj, flag, n) -- id�����ţ�mj�ؼ���ţ�flag = 0���� =1ѧ��,n = 1�Ѿ�ѧϰ = 0��ѧϰ
    local xue = 0
    local full = 0
    if flag == 1 then
        for i = 1, 10 do
            if JY.Person[id]['�ؼ�' .. i] == mj then
                xue = 1
                if n == nil then
                    DrawStrBoxWaitKey(string.format("%s�Ѿ�ѧ��%s", JY.Person[id]["����"], JY.Teji[mj]["����"]),
                        C_ORANGE, CC.DefaultFont)
                end
                break
            end
            if JY.Person[id]['�ؼ�' .. 10] > 0 then
                full = 1
                if n == nil then
                    DrawStrBoxWaitKey('������ѧϰ������ؼ���', C_ORANGE, CC.DefaultFont)
                end
                break
            end
            if xue == 0 and full == 0 then
                if JY.Person[id]['�ؼ�' .. i] == 0 then
                    JY.Person[id]['�ؼ�' .. i] = mj
                    if n == nil then
                        DrawStrBoxWaitKey(string.format("%s�������ؼ�%s", JY.Person[id]["����"],
                            JY.Teji[mj]["����"]), C_ORANGE, CC.DefaultFont)
                    end
                    break
                end
            end
        end
    end
    if flag == 0 then
        for i = 1, 5 do
            if JY.Person[id]['�ؼ�' .. i] == mj then
                JY.Person[id]['�ؼ�' .. i] = 0
                DrawStrBoxWaitKey(
                    string.format("%s�Ѿ������ؼ�%s", JY.Person[id]["����"], JY.Teji[mj]["����"]), C_ORANGE,
                    CC.DefaultFont)
                break
            end
        end
    end
    if JY.Base['����'] == id then
        id = 0
        if flag == 1 then
            for i = 1, 10 do
                if JY.Person[id]['�ؼ�' .. i] == mj then
                    xue = 1
                    if n == nil then
                        DrawStrBoxWaitKey(string.format("%s�Ѿ�ѧ��%s", JY.Person[id]["����"],
                            JY.Teji[mj]["����"]), C_ORANGE, CC.DefaultFont)
                    end
                    break
                end
                if JY.Person[id]['�ؼ�' .. 10] > 0 then
                    full = 1
                    if n == nil then
                        DrawStrBoxWaitKey('������ѧϰ������ؼ���', C_ORANGE, CC.DefaultFont)
                    end
                    break
                end
                if xue == 0 and full == 0 then
                    if JY.Person[id]['�ؼ�' .. i] == 0 then
                        JY.Person[id]['�ؼ�' .. i] = mj
                        -- ��ʴ����Ѩ2
                        if JY.Person[id]['��Ѩ' .. 25] == 1 then
                            if (mj == 6 and Pmiji(id, 8)) or (mj == 8 and Pmiji(id, 6)) then
                                AddPersonAttrib(id, '�ö�����', 80)
                            end
                        end
                        if n == nil then
                            DrawStrBoxWaitKey(string.format("%s�������ؼ�%s", JY.Person[id]["����"],
                                JY.Teji[mj]["����"]), C_ORANGE, CC.DefaultFont)
                        end
                        break
                    end
                end
            end
        end
        if flag == 0 then
            for i = 1, 5 do
                if JY.Person[id]['�ؼ�' .. i] == mj then
                    JY.Person[id]['�ؼ�' .. i] = 0
                    DrawStrBoxWaitKey(string.format("%s�Ѿ������ؼ�%s", JY.Person[id]["����"],
                        JY.Teji[mj]["����"]), C_ORANGE, CC.DefaultFont)
                    break
                end
            end
        end
    end
end

-- �Ƿ��ù���Ʒ
function instruct_69(thingid)
    for i = 1, #CC.JLWP do
        if CC.JLWP[i] == thingid then
            return true
        end
    end
    return false
end

-- ϴ�书
function instruct_70(pid)
    Cls()
    local menu = {}
    for i = 1, JY.Base['�书����'] do
        if JY.Person[pid]["�书" .. i] > 0 then
            local wg = JY.Person[pid]["�书" .. i]
            menu[#menu + 1] = {JY.Wugong[wg]["����"], nil, 1, wg, i}
        end
    end
    Cls()
    local r = ShowMenu2(menu, #menu, 3, 15, CC.ScreenW / 3, CC.ScreenH / 3, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE,
        C_WHITE, "ѡ��Ҫϴ�����书")
    local xsbs = 1
    local swbs = 1
    if match_ID(pid, 9928) or match_ID(pid, 9862) then -- ��� ˫������ֵ
        swbs = 2
    end
    if match_ID(pid, 9928) or match_ID(pid, 9863) then
        xsbs = 2
    end
    if r > 0 then
        local thingid = -1
        for i = 0, JY.ThingNum - 1 do
            if JY.Thing[i]["�����书"] > 0 and JY.Thing[i]["�����书"] == menu[r][4] then
                thingid = i
                local level = math.modf(JY.Person[pid]["�书�ȼ�" .. menu[r][5]] / 100) + 1
                AddPersonAttrib(pid, "�������ֵ", -JY.Thing[thingid]["���������ֵ"] * level)
                AddPersonAttrib(pid, "�������ֵ", -JY.Thing[thingid]["���������ֵ"] * level)
                AddPersonAttrib(pid, "������", -JY.Thing[thingid]["�ӹ�����"] * level * xsbs)
                AddPersonAttrib(pid, "�Ṧ", -JY.Thing[thingid]["���Ṧ"] * level * xsbs)
                AddPersonAttrib(pid, "������", -JY.Thing[thingid]["�ӷ�����"] * level * xsbs)
                AddPersonAttrib(pid, "ҽ������", -JY.Thing[thingid]["��ҽ������"] * xsbs * level)
                AddPersonAttrib(pid, "�ö�����", -JY.Thing[thingid]["���ö�����"] * xsbs * level)
                AddPersonAttrib(pid, "�ⶾ����", -JY.Thing[thingid]["�ӽⶾ����"] * xsbs * level)
                AddPersonAttrib(pid, "��������", -JY.Thing[thingid]["�ӿ�������"] * xsbs * level)
                AddPersonAttrib(pid, "ȭ�ƹ���", -JY.Thing[thingid]["��ȭ�ƹ���"] * xsbs * level)
                AddPersonAttrib(pid, "ָ������", -JY.Thing[thingid]["��ָ������"] * xsbs * level)
                AddPersonAttrib(pid, "��������", -JY.Thing[thingid]["����������"] * xsbs * level)
                AddPersonAttrib(pid, "ˣ������", -JY.Thing[thingid]["��ˣ������"] * xsbs * level)
                AddPersonAttrib(pid, "�������", -JY.Thing[thingid]["���������"] * xsbs * level)
                AddPersonAttrib(pid, "��������", -JY.Thing[thingid]["�Ӱ�������"] * xsbs * level)
                AddPersonAttrib(pid, "��ѧ��ʶ", -JY.Thing[thingid]["����ѧ��ʶ"] * xsbs * level)
                break
            end
        end
        for i = menu[r][5], #menu - 1 do
            JY.Person[pid]["�书" .. i] = JY.Person[pid]["�书" .. i + 1]
            JY.Person[pid]["�书�ȼ�" .. i] = JY.Person[pid]["�书�ȼ�" .. i + 1]
        end
        JY.Person[pid]["�书" .. #menu] = 0
        JY.Person[pid]["�书�ȼ�" .. #menu] = 0
        QZXS(JY.Person[pid]["����"] .. "�Ѿ�ϴ��" .. menu[r][1])
    end
end

function Add(id, i, num)
    AddPersonAttrib(id, i, num)
end
-- ѡ���ÿ��ѡ����߿�
-- title ����
-- str ���� *����
-- button ѡ��
-- num ѡ��ĸ�����һ��Ҫ��ѡ���Ӧ����
-- headid ��ʾ��������ߵ���ͼ���������ֵ����ʾ��ͼ
function JYMsgBox(title, str, button, num, headid, isEsc)
    if JY.Restart == 1 then
        return 1
    end
    local strArray = {}
    local xnum, ynum, width, height = nil, nil, nil, nil
    local picw, pich = 0, 0
    local x1, x2, y1, y2 = nil, nil, nil, nil
    local size = CC.DefaultFont;
    local xarr = {};

    local function between(x, select)
        for i = 1, num do
            if xarr[i] < x and x < xarr[i] + string.len(button[i]) * size / 2 then
                return i
            end
        end
        return select
    end
    if headid ~= nil then
        headid = headid * 2;
        -- picw, pich = lib.PicGetXY(1, headid)
        picw, pich = lib.GetPNGXY(1, headid)
        picw = picw + CC.MenuBorderPixel * 2
        pich = pich + CC.MenuBorderPixel * 2
    end
    ynum, strArray = Split(str, "*")
    xnum = 0
    for i = 1, ynum do
        local len = string.len(strArray[i])
        if xnum < len then
            xnum = len
        end
    end
    if xnum < 12 then
        xnum = 12
    end
    width = CC.MenuBorderPixel * 2 + math.modf(size * xnum / 2) + (picw)
    height = CC.MenuBorderPixel * 2 + (size + CC.MenuBorderPixel) * ynum
    if height < pich then
        height = pich
    end
    y2 = height
    height = height + CC.MenuBorderPixel * 2 + size * 2
    x1 = (CC.ScreenW - (width)) / 2 + CC.MenuBorderPixel
    x2 = x1 + (picw)
    y1 = (CC.ScreenH - (height)) / 2 + CC.MenuBorderPixel + 2 + size * 0.7
    y2 = y2 + (y1) - 5
    local select = 1

    Cls();

    DrawBoxTitle(width, height, title, C_GOLD)
    if headid ~= nil then
        -- lib.PicLoadCache(1, headid, x1, y1, 1, 0)
        lib.LoadPNG(1, headid, x1, y1, 1)
    end
    for i = 1, ynum do
        DrawString(x2, y1 + (CC.MenuBorderPixel + size) * (i - 1), strArray[i], C_WHITE, size)
    end

    local yczj = 0 -- ���������żһ�

    if title == "����ѡ��" then
        yczj = 1
    end

    local surid = lib.SaveSur((CC.ScreenW - (width)) / 2 - 4, (CC.ScreenH - (height)) / 2 - size,
        (CC.ScreenW + (width)) / 2 + 4, (CC.ScreenH + (height)) / 2 + 4)
    while true do
        if JY.Restart == 1 then
            break
        end
        Cls();
        lib.LoadSur(surid, (CC.ScreenW - (width)) / 2 - 4, (CC.ScreenH - (height)) / 2 - size)

        for i = 1, num do
            local color, bjcolor = nil, nil
            if i == select then
                color = M_Yellow
                bjcolor = M_DarkOliveGreen
            else
                color = M_DarkOliveGreen
            end
            xarr[i] = (CC.ScreenW - (width)) / 2 + (width) * i / (num + 1) - string.len(button[i]) * size / 4;
            DrawStrBox2(xarr[i], y2, button[i], color, size, bjcolor)
        end
        ShowScreen()

        local key, ktype, mx, my = WaitKey(1)
        lib.Delay(CC.Frame)
        if key == VK_ESCAPE or ktype == 4 then
            if isEsc ~= nil and isEsc == 1 then
                select = -2
                break
            end
        elseif key == VK_LEFT or ktype == 6 then
            select = select - 1
            if select < 1 then
                select = num
            end
            if yczj == 1 and key == VK_LEFT then
                YC_ZhangJiaHui(key)
            end
        elseif key == VK_RIGHT or ktype == 7 then
            select = select + 1
            if num < select then
                select = 1
            end
            if yczj == 1 and key == VK_RIGHT then
                YC_ZhangJiaHui(key)
            end
        elseif key == VK_UP then
            if yczj == 1 then
                YC_ZhangJiaHui(key)
            end
        elseif key == VK_DOWN then
            if yczj == 1 then
                YC_ZhangJiaHui(key)
            end
        elseif key >= VK_A and key <= VK_Z then
            if yczj == 1 then
                YC_ZhangJiaHui(key)
            end
        elseif key == VK_RETURN or key == VK_SPACE or ktype == 5 then
            break
        elseif ktype == 2 or ktype == 3 then
            if mx >= x1 and mx <= x1 + width and my >= y2 and my <= y2 + 2 * CC.MenuBorderPixel + size then
                -- �޾Ʋ���������pass in select��������ѡ�񲻵�������·��ز����ڵ�ѡ��
                select = between(mx, select);
                if select > 0 and select <= num and ktype == 3 then
                    break
                end
            end
        end
        -- ���������żһ�
        if yczj == 1 and YC.ZJH == 12 then
            YC.ZJH = 0
            lib.FreeSur(surid)
            return 3
        end
    end
    select = limitX(select, -2, num)
    lib.FreeSur(surid)

    Cls()
    return select
end

-- ��ʾ���߿������
function DrawBoxTitle(width, height, str, color)
    local s = 4
    local x1, y1, x2, y2, tx1, tx2 = nil, nil, nil, nil, nil, nil
    local fontsize = s + CC.DefaultFont
    local len = string.len(str) * fontsize / 2
    x1 = (CC.ScreenW - width) / 2
    x2 = (CC.ScreenW + width) / 2
    y1 = (CC.ScreenH - height) / 2
    y2 = (CC.ScreenH + height) / 2
    tx1 = (CC.ScreenW - len) / 2
    tx2 = (CC.ScreenW + len) / 2
    lib.Background(x1, y1 + s, x1 + s, y2 - s, 128)
    lib.Background(x1 + s, y1, x2 - s, y2, 128)
    lib.Background(x2 - s, y1 + s, x2, y2 - s, 128)
    lib.Background(tx1, y1 - fontsize / 2 + s, tx2, y1, 128)
    lib.Background(tx1 + s, y1 - fontsize / 2, tx2 - s, y1 - fontsize / 2 + s, 128)
    local r, g, b = GetRGB(color)
    DrawBoxTitle_sub(x1 + 1, y1 + 1, x2, y2, tx1 + 1, y1 - fontsize / 2 + 1, tx2, y1 + fontsize / 2,
        RGB(math.modf(r / 2), math.modf(g / 2), math.modf(b / 2)))
    DrawBoxTitle_sub(x1, y1, x2 - 1, y2 - 1, tx1, y1 - fontsize / 2, tx2 - 1, y1 + fontsize / 2 - 1, color)
    DrawString(tx1 + 2 * s, y1 - (fontsize - s) / 2, str, color, CC.DefaultFont)
end

function DrawBoxTitle_sub(x1, y1, x2, y2, tx1, ty1, tx2, ty2, color)
    local s = 4
    lib.DrawRect(x1 + s, y1, tx1, y1, color)
    lib.DrawRect(tx2, y1, x2 - s, y1, color)
    lib.DrawRect(x2 - s, y1, x2 - s, y1 + s, color)
    lib.DrawRect(x2 - s, y1 + s, x2, y1 + s, color)
    lib.DrawRect(x2, y1 + s, x2, y2 - s, color)
    lib.DrawRect(x2, y2 - s, x2 - s, y2 - s, color)
    lib.DrawRect(x2 - s, y2 - s, x2 - s, y2, color)
    lib.DrawRect(x2 - s, y2, x1 + s, y2, color)
    lib.DrawRect(x1 + s, y2, x1 + s, y2 - s, color)
    lib.DrawRect(x1 + s, y2 - s, x1, y2 - s, color)
    lib.DrawRect(x1, y2 - s, x1, y1 + s, color)
    lib.DrawRect(x1, y1 + s, x1 + s, y1 + s, color)
    lib.DrawRect(x1 + s, y1 + s, x1 + s, y1, color)
    DrawBox_1(tx1, ty1, tx2, ty2, color)
end

function Init_SMap(showname)
	lib.PicInit()
	LoadSMAP()--���¼��س���ͼ
	
	lib.PicLoadFile(CC.BJ[1], CC.BJ[2], 92)
    lib.LoadPNGPath('./data/bj',0,-1,100)
    lib.LoadPNGPath(CC.HeadPath, 1, CC.HeadNum, limitX(CC.WX*100,0,100))
    lib.LoadPNGPath(CC.BodyPath, 90, CC.BodyNum, limitX(CC.WX*100,0,100))	
    lib.LoadPNGPath(CC.PTPath, 95, CC.PTNum, limitX(CC.WX*100,0,100))
    lib.LoadPNGPath(CC.XTPath, 91, CC.XTNum, limitX(CC.WX*100,0,100))	--UI				
    lib.LoadPNGPath(CC.UIPath, 96, CC.UINum, limitX(CC.WX*100,0,100))	
	lib.LoadPNGPath(CC.ThingPath, 2, CC.ThingNum, limitX(CC.WX*100,0,100))	--��Ʒ��ͼ
    -- lib.LoadPNGPath('./data/thing',0,-1,100)
    lib.LoadPNGPath(CC.TFPath, 89, CC.TFNum, limitX(CC.WX * 100, 0, 100)) -- TF
    -- 97���ƶ䣬����ʹ��
    lib.LoadPNGPath(CC.IconPath, 98, CC.IconNum, limitX(CC.WX*100,0,100))	--״̬ͼ�꣬�ڴ�����98
    lib.LoadPNGPath(CC.HeadPath, 99, CC.HeadNum, 26.923076923) --����Сͷ�����ڼ��������ڴ�����99

    PlayMIDI(JY.Scene[JY.SubScene]["��������"])
    JY.oldSMapX = -1
    JY.oldSMapY = -1
    JY.SubSceneX = 0
    JY.SubSceneY = 0
    JY.OldDPass = -1
    JY.D_Valid = nil
    DrawSMap()
    lib.GetKey()
    if showname == 1 then
        local name = 0
        local bx = CC.WX
        local by = CC.HY
        local size = CC.DefaultFont * 1.2
        local zi = {}
        local tg = 8 + JY.Base['���']
        if JY.SubScene == 150 then
            name = "���" .. numberToChinese(tg) .. "��"
        else
            name = JY.Scene[JY.SubScene]["����"]
        end
        local namelen = string.len(name) / 2
        local stn = string.len(name) / 2
        local hsize = size*4 / stn
        lib.LoadPNG(91, 123 * 2, bx * 1228, by * 363, 1)
        draw3(name,CC.ScreenW/1.06, CC.ScreenH/1.6 - ((stn - 1) * hsize) / 2, C_WHITE, size, nil, hsize,CC.FONT2)
        ShowScreen()
        WaitKey()
        Cls();
    end

    AutoMoveTab = {
        [0] = 0
    }
end


-- �¶Ի���ʽ
-- ��������ַ�
-- ��ͣ����������������
-- ������ɫ��=red��=gold��=black��=white��=orange
-- �����ַ���ʾ�ٶȣ�,��,��,��,��,��,��,��,��,��
-- ����������ӣģ�
-- ���ƻ��У�   ��ҳ��
-- �δ����Լ����������

function MyDrawString(x1, x2, y, str, color, size)
    local len = math.modf(string.len(str) * size / 4)
    local x = math.modf((x1 + x2) / 2) - len
    DrawString(x, y, str, color, size)
end

-- �ָ��ַ���
-- szFullString�ַ���
-- szSeparator�ָ��
-- ��������,�ָ������
function Split(szFullString, szSeparator)
    local nFindStartIndex = 1
    local nSplitIndex = 1
    local nSplitArray = {}
    while true do
        local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
        if not nFindLastIndex then
            nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
            break
        else
            nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
            nFindStartIndex = nFindLastIndex + string.len(szSeparator)
            nSplitIndex = nSplitIndex + 1
        end
    end
    return nSplitIndex, nSplitArray
end

function DrawStrBox2(x, y, str, color, size, bjcolor)
    local strarray = {}
    local num, maxlen = nil, nil
    maxlen = 0
    num, strarray = Split(str, "*")
    for i = 1, num do
        local len = string.len(strarray[i])
        if maxlen < len then
            maxlen = len
        end
    end
    local w = size * maxlen / 2 + 2 * CC.MenuBorderPixel
    local h = 2 * CC.MenuBorderPixel + size * num
    if x == -1 then
        x = (CC.ScreenW - size / 2 * maxlen - 2 * CC.MenuBorderPixel) / 2
    end
    if y == -1 then
        y = (CC.ScreenH - size * num - 2 * CC.MenuBorderPixel) / 2
    end
    DrawBox2(x, y, x + w - 1, y + h - 1, C_WHITE, bjcolor)
    for i = 1, num do
        DrawString(x + CC.MenuBorderPixel, y + CC.MenuBorderPixel + size * (i - 1), strarray[i], color, size)
    end
end

-- ����һ���������İ�ɫ�����Ľǰ���
function DrawBox2(x1, y1, x2, y2, color, bjcolor)
    local s = 4
    if not bjcolor then
        bjcolor = 0
    end
    if bjcolor >= 0 then
        lib.Background(x1, y1 + s, x1 + s, y2 - s, 128, bjcolor)
        lib.Background(x1 + s, y1, x2 - s, y2, 128, bjcolor)
        lib.Background(x2 - s, y1 + s, x2, y2 - s, 128, bjcolor)
    end
    if color >= 0 then
        local r, g, b = GetRGB(color)
        DrawBox_2(x1 + 1, y1, x2, y2, RGB(math.modf(r / 2), math.modf(g / 2), math.modf(b / 2)))
        DrawBox_2(x1, y1, x2 - 1, y2 - 1, color)
    end
end

-- �����Ľǰ����ķ���
function DrawBox_2(x1, y1, x2, y2, color)
    local s = 4
    lib.DrawRect(x1 + s, y1, x2 - s, y1, color)
    lib.DrawRect(x2 - s, y1, x2 - s, y1 + s, color)
    lib.DrawRect(x2 - s, y1 + s, x2, y1 + s, color)
    lib.DrawRect(x2, y1 + s, x2, y2 - s, color)
    lib.DrawRect(x2, y2 - s, x2 - s, y2 - s, color)
    lib.DrawRect(x2 - s, y2 - s, x2 - s, y2, color)
    lib.DrawRect(x2 - s, y2, x1 + s, y2, color)
    lib.DrawRect(x1 + s, y2, x1 + s, y2 - s, color)
    lib.DrawRect(x1 + s, y2 - s, x1, y2 - s, color)
    lib.DrawRect(x1, y2 - s, x1, y1 + s, color)
    lib.DrawRect(x1, y1 + s, x1 + s, y1 + s, color)
    lib.DrawRect(x1 + s, y1 + s, x1 + s, y1, color)
end

-- ��ʼ������ͼ
function Init_MMap()
     lib.PicInit()
    lib.LoadMMap(CC.MMapFile[1], CC.MMapFile[2], CC.MMapFile[3], CC.MMapFile[4], CC.MMapFile[5], CC.MWidth, CC.MHeight,JY.Base["��X"], JY.Base["��Y"])
	LoadMMAP()
    -- lib.PicLoadFile(CC.MMAPPicFile[1], CC.MMAPPicFile[2], 0)
    -- lib.LoadPNGPath('./data/mmap',0,-1,100)
    lib.PicLoadFile(CC.BJ[1], CC.BJ[2], 92)
    --lib.LoadPNGPath('./data/BJ',0,-1,100)
    lib.LoadPNGPath(CC.HeadPath, 1, CC.HeadNum, limitX(CC.WX*100,0,100))
    lib.LoadPNGPath(CC.BodyPath, 90, CC.BodyNum, limitX(CC.WX*100,0,100))	
    lib.LoadPNGPath(CC.PTPath, 95, CC.PTNum, limitX(CC.WX*100,0,100))
    lib.LoadPNGPath(CC.XTPath, 91, CC.XTNum, limitX(CC.WX*100,0,100))	--UI		
    lib.LoadPNGPath(CC.UIPath, 96, CC.UINum, limitX(CC.WX*100,0,100))
    lib.LoadPNGPath(CC.TFPath, 89, CC.TFNum, limitX(CC.WX * 100, 0, 100)) -- TF
    -- 97���ƶ䣬����ʹ��
    lib.LoadPNGPath(CC.IconPath, 98, CC.IconNum, limitX(CC.WX*100,0,100))	--״̬ͼ�꣬�ڴ�����98
    lib.LoadPNGPath(CC.HeadPath, 99, CC.HeadNum, 26.923076923) --����Сͷ�����ڼ��������ڴ�����99
    -- lib.PicLoadFile(CC.ThingPicFile[1], CC.ThingPicFile[2], 2, 100, 100)
    -- lib.LoadPNGPath('./data/thing',0,-1,100)

    JY.EnterSceneXY = nil
    JY.oldMMapX = -1
    JY.oldMMapY = -1
    PlayMIDI(JY.MmapMusic)

    AutoMoveTab = {
        [0] = 0
    }
end

--�������
function LoadSMAP()
	lib.FreeSur(-1)--�������id�����׽����ʾ�쳣
	ButtonMode(0)
	if	existFile(CONFIG.DataPath..'smap.zip') then
		lib.Debug("1")
		lib.LoadPNGPath(CONFIG.DataPath..'smap', 94, -1, 100, "png");
	elseif	existFile(CC.SMAPPicFile[1]) then
		lib.Debug("2")
		lib.PicLoadFile(CC.SMAPPicFile[1], CC.SMAPPicFile[2], 94)	--�ӳ�����ͼ���ڴ�����
	end
	lib.Debug("3")
end

function LoadMMAP()
	lib.FreeSur(-1)--�������id�����׽����ʾ�쳣
	ButtonMode(1)
	if	existFile(CONFIG.DataPath..'mmap.zip') then
		lib.LoadPNGPath(CONFIG.DataPath..'mmap', 93, -1, 100, "png");
	elseif	existFile(CC.MMAPPicFile[1]) then
		lib.PicLoadFile(CC.MMAPPicFile[1], CC.MMAPPicFile[2], 93)	--���ͼ��ͼ���ڴ�����
	end
	lib.LoadPNGPath(CONFIG.DataPath..'cloud', 97, -1, 100, "png");--�ƶ�
end

function LoadWMAP()
	lib.FreeSur(-1)--�������id�����׽����ʾ�쳣
	ButtonMode(2)
	if existFile(CONFIG.DataPath..'wmap.zip') then
		lib.LoadPNGPath(CONFIG.DataPath..'wmap', 0, -1, 100, "png");
	elseif existFile(CC.WMAPPicFile[1]) then
		lib.PicLoadFile(CC.WMAPPicFile[1], CC.WMAPPicFile[2], 0)	--�ӳ�����ͼ���ڴ�����	
	end
	--lib.LoadPNGPath(CONFIG.DataPath..'eft', 3, -1, 100, "png");
end

function ButtonMode(flag)
	if CONFIG.MouseMode == 2 then
		if flag == nil then
			if JY.Status==GAME_SMAP then
				lib.ButtonMode(0)
			elseif JY.Status==GAME_WMAP then
				lib.ButtonMode(2)
			else
				lib.ButtonMode(1)
			end
		else
			lib.ButtonMode(flag)
		end
	end
end


-- �Զ���Ľ����ӳ����ĺ���
-- ��Ҫ������ӳ������
-- x�����ӳ����������X���꣬����-1��Ĭ��Ϊ���X
-- y�����ӳ����������Y���꣬����-1��Ĭ��Ϊ���Y
-- direct������Եķ���
function My_Enter_SubScene(sceneid, x, y, direct)
    -- �Ӵ��ͼ�����ӳ���ǰ�Զ����浽10�ŵ�
    if JY.Status == GAME_MMAP then
        JY.Base['������'] = JY.Base['������'] + 1
        if JY.Base['������'] > 3 then
            JY.Base['������'] = 1
        end
        SaveRecord(6 + JY.Base['������'])
    end
    JY.SubScene = sceneid;
    local flag = 1; -- �Ƿ��Զ����xy����, 0�ǣ�1��
    if x == -1 and y == -1 then
        JY.Base["��X1"] = JY.Scene[sceneid]["���X"];
        JY.Base["��Y1"] = JY.Scene[sceneid]["���Y"];
    else
        JY.Base["��X1"] = x;
        JY.Base["��Y1"] = y;
        flag = 0;
    end

    if direct > -1 then
        JY.Base["�˷���"] = direct;
    end

    if JY.Status == GAME_MMAP then
        CleanMemory();
        -- lib.UnloadMMap();
    end
    lib.ShowSlow(20, 1)

    JY.Status = GAME_SMAP; -- �ı�״̬
    JY.MmapMusic = -1;

    JY.Base["�˴�"] = 0;
    JY.MyPic = GetMyPic();

    -- �⾰����Ǹ��ѵ㣬��Щ�ӳ�����ͨ����ת�ķ�ʽ����ģ���Ҫ�ж�
    -- ����Ŀǰ���ֻ����һ���ӳ�����ת�����Բ���Ҫ����ѭ���ж�
    local sid = JY.Scene[sceneid]["��ת����"];

    if sid < 0 or (JY.Scene[sid]["�⾰���X1"] <= 0 and JY.Scene[sid]["�⾰���Y1"] <= 0) then
        JY.Base["��X"] = JY.Scene[sceneid]["�⾰���X1"]; -- �ı���ӳ������XY����
        JY.Base["��Y"] = JY.Scene[sceneid]["�⾰���Y1"];
    else
        JY.Base["��X"] = JY.Scene[sid]["�⾰���X1"]; -- �ı���ӳ������XY����
        JY.Base["��Y"] = JY.Scene[sid]["�⾰���Y1"];
    end
    Init_SMap(flag); -- ���³�ʼ����ͼ
    -- lib.LoadPNGPath('./data/smap',0,-1,100)
    if flag == 0 then -- ������Զ���λ�ã��ȴ��͵��Ǹ�λ�ã�����ʾ��������
        local name = 0
        local bx = CC.WX
        local by = CC.HY
        local size = CC.DefaultFont * 1.2
        local zi = {}
        local tg = 8 + JY.Base['���']
        if JY.SubScene == 150 then
            name = "���" .. numberToChinese(tg) .. "��"
        else
            name = JY.Scene[JY.SubScene]["����"]
        end
        local namelen = string.len(name) / 2
        local stn = string.len(name) / 2
        local hsize = size*4 / stn
        lib.LoadPNG(91, 123 * 2, bx * 1228, by * 363, 1)
        draw3(name,CC.ScreenW/1.06, CC.ScreenH/1.6 - ((stn - 1) * hsize) / 2, C_WHITE, size, nil, hsize,CC.FONT2)

        ShowScreen()
        WaitKey()
    end
    Cls();
end

-- ������Ϣ
function JYZTB(id, pid)
    ShowStatus()
end

function QZXS(s)
    DrawStrBoxWaitKey(s, C_GOLD, CC.DefaultFont)
end

-- ��ʾ�书������
function KungfuString(str, x, y, color, size, font, place)
    if str == nil then
        return
    end
    local w, h = size, size + 5
    local len = string.len(str) / 2
    x = x - len * w / 2
    y = y - h * place
    lib.DrawStr(x, y, str, color, size, font, 0, 0)
end

-- �����ͼ����
function ClsN(x1, y1, x2, y2)
    if x1 == nil then
        x1 = 0
        y1 = 0
        x2 = 0
        y2 = 0
    end
    lib.SetClip(x1, y1, x2, y2)
    lib.FillColor(0, 0, 0, 0, 0)
    lib.SetClip(0, 0, 0, 0)
end

---�Ծ��ν�����Ļ����
-- ���ؼ��ú�ľ��Σ����������Ļ�����ؿ�
function ClipRect(r)
    if CC.ScreenW <= r.x1 or r.x2 <= 0 or CC.ScreenH <= r.y1 or r.y2 <= 0 then
        return nil
    else
        local res = {}
        res.x1 = limitX(r.x1, 0, CC.ScreenW)
        res.x2 = limitX(r.x2, 0, CC.ScreenW)
        res.y1 = limitX(r.y1, 0, CC.ScreenH)
        res.y2 = limitX(r.y2, 0, CC.ScreenH)
        return res
    end
end

-- ������ͼ�ı��γɵ�Clip�ü�
-- (dx1,dy1) ����ͼ�ͻ�ͼ���ĵ������ƫ�ơ��ڳ����У��ӽǲ�ͬ�����Ƕ�ʱ�õ�
-- pic1 �ɵ���ͼ���
-- id1 ��ͼ�ļ����ر��
-- (dx2,dy2) ����ͼ�ͻ�ͼ���ĵ��ƫ��
-- pic2 �ɵ���ͼ���
-- id2 ��ͼ�ļ����ر��
-- ���أ��ü����� {x1,y1,x2,y2}
function Cal_PicClip(dx1, dy1, pic1, id1, dx2, dy2, pic2, id2)
    local w1, h1, x1_off, y1_off = lib.PicGetXY(id1, pic1 * 2)
    local old_r = {}
    old_r.x1 = CC.XScale * (dx1 - dy1) + CC.ScreenW / 2 - x1_off
    old_r.y1 = CC.YScale * (dx1 + dy1) + CC.ScreenH / 2 - y1_off
    old_r.x2 = old_r.x1 + w1
    old_r.y2 = old_r.y1 + h1
    local w2, h2, x2_off, y2_off = lib.PicGetXY(id2, pic2 * 2)
    local new_r = {}
    new_r.x1 = CC.XScale * (dx2 - dy2) + CC.ScreenW / 2 - x2_off
    new_r.y1 = CC.YScale * (dx2 + dy2) + CC.ScreenH / 2 - y2_off
    new_r.x2 = new_r.x1 + w2
    new_r.y2 = new_r.y1 + h2
    return MergeRect(old_r, new_r)
end

-- �ϲ�����
function MergeRect(r1, r2)
    local res = {}
    res.x1 = math.min(r1.x1, r2.x1)
    res.y1 = math.min(r1.y1, r2.y1)
    res.x2 = math.max(r1.x2, r2.x2)
    res.y2 = math.max(r1.y2, r2.y2)
    return res
end

-- ��ʾ��Ӱ�ַ���
-- ���x,y��-1����ô��ʾ����Ļ�м�
function NewDrawString(x, y, str, color, size)
    local ll = #str
    local w = size * ll / 2 + 2 * CC.MenuBorderPixel
    local h = size + 2 * CC.MenuBorderPixel
    if x == -1 then
        x = (CC.ScreenW - size / 2 * ll - 2 * CC.MenuBorderPixel) / 2
    else
        x = (x - size / 2 * ll - 2 * CC.MenuBorderPixel) / 2
    end
    if y == -1 then
        y = (CC.ScreenH - size - 2 * CC.MenuBorderPixel) / 2
    else
        y = (y - size - 2 * CC.MenuBorderPixel) / 2
    end
    lib.DrawStr(x, y, str, color, size, CC.FontName, CC.SrcCharSet, CC.OSCharSet)
end

function NewDrawString1(x, y, str, color, size)
    local ll = #str
    local w = size * ll / 2 + 2 * CC.MenuBorderPixel
    local h = size + 2 * CC.MenuBorderPixel
    if x == -1 then
        x = (CC.ScreenW - size / 2 * ll - 2 * CC.MenuBorderPixel) / 2
    else
        x = (x - size / 2 * ll - 2 * CC.MenuBorderPixel) / 2
    end
    if y == -1 then
        y = (CC.ScreenH - size - 2 * CC.MenuBorderPixel) / 2
    else
        y = (y - size - 2 * CC.MenuBorderPixel) / 2
    end
    lib.DrawStr(x, y, str, color, size, CC.FontName, CC.SrcCharSet, CC.OSCharSet)
end

-- �޾Ʋ�������������ATM������������UI
function InputNum(str, minNum, maxNum, isEsc)
    local size = CC.DefaultFont;
    local b_space = size + CC.RowPixel
    local x = (CC.ScreenW - size * 9 - 2 * CC.MenuBorderPixel) / 2;
    local y = (CC.ScreenH - size * 9 - 2 * CC.MenuBorderPixel) / 2;
    local w = size * 9 + 2 * CC.MenuBorderPixel;
    local h = (b_space + CC.RowPixel * 2) * 6;
    local functional_button = {{
        name = "ȷ��"
    }, {
        name = "���"
    }, {
        name = "���"
    }, {
        name = "ɾ��"
    }, {
        name = 0
    }, {
        name = 1
    }, {
        name = 2
    }, {
        name = 3
    }, {
        name = 4
    }, {
        name = 5
    }, {
        name = 6
    }, {
        name = 7
    }, {
        name = 8
    }, {
        name = 9
    }};
    local starting_y = 5;
    local starting_x = 1;

    for i = 1, #functional_button do
        functional_button[i].x1 = CC.ScreenW / 2 + (b_space + CC.RowPixel * 2) * starting_x - 11
        functional_button[i].y1 = y + (b_space + CC.RowPixel * 2) * starting_y
        if i <= 4 then
            functional_button[i].x2 = CC.ScreenW / 2 + (b_space + CC.RowPixel * 2) * starting_x - 11 + b_space * 2
            functional_button[i].y2 = y + (b_space + CC.RowPixel * 2) * starting_y + b_space
        else
            functional_button[i].x2 = CC.ScreenW / 2 + (b_space + CC.RowPixel * 2) * starting_x - 11 + b_space
            functional_button[i].y2 = y + (b_space + CC.RowPixel * 2) * starting_y + b_space
        end
        if i < 4 then
            starting_y = starting_y - 1
        elseif i == 4 then
            starting_y = 5
            starting_x = -1
        elseif i == 5 or i == 8 or i == 11 then
            starting_x = -2
            starting_y = starting_y - 1
        elseif i > 5 then
            starting_x = starting_x + 1
        end
    end

    local num = 0;
    if minNum ~= nil then
        num = minNum;
    end

    local selected_content = 0

    DrawBox(x, y, x + w - 1, y + h - 1, C_WHITE);
    DrawString(x + CC.MenuBorderPixel * 2, y + CC.MenuBorderPixel, str .. " " .. minNum .. " - " .. maxNum, C_WHITE,
        size);

    local sid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH);

    while true do
        if JY.Restart == 1 then
            break
        end
        DrawShades(CC.ScreenW / 2 - b_space * 3, y + b_space + CC.RowPixel * 2, CC.ScreenW / 2 + b_space * 3,
            y + b_space + CC.RowPixel * 2 + b_space)
        DrawString(CC.ScreenW / 2, y + b_space + CC.RowPixel * 2, string.format("%d", num), C_WHITE, size);

        for i = 1, #functional_button do
            local x_indent = 7
            local y_indent = 2
            if i > 4 then
                x_indent = 11
                y_indent = 0
            end
            local shade_color = nil;
            if i == selected_content then
                shade_color = C_GOLD
            end
            DrawShades(functional_button[i].x1, functional_button[i].y1, functional_button[i].x2,
                functional_button[i].y2, shade_color)
            DrawString(functional_button[i].x1 + x_indent, functional_button[i].y1 + y_indent,
                functional_button[i].name, C_GOLD, size);
        end

        ShowScreen()
        local key, ktype, mx, my = lib.GetKey();
        lib.Delay(CC.Frame)
        if (key == VK_ESCAPE or ktype == 4) and isEsc ~= nil then
            num = nil;
            break
        elseif key >= 49 and key <= 57 then
            num = num * 10
            num = num + key - 48
            if num > maxNum then
                num = maxNum
            end
        elseif key >= 1073741913 and key <= 1073741921 then
            num = num * 10
            num = num + key - 1073741912
            if num > maxNum then
                num = maxNum
            end
        elseif key == 48 or key == 1073741922 then
            num = num * 10
            if num > maxNum then
                num = maxNum
            end
        elseif key == VK_BACKSPACE then
            num = math.modf(num / 10)
        elseif key == VK_SPACE or key == VK_RETURN then
            if num >= minNum and num <= maxNum then
                break
            end
        elseif ktype == 2 or ktype == 3 then
            selected_content = 0
            if mx >= x and mx <= x + w - 1 and my >= y and my <= y + h - 1 then
                for k = 1, #functional_button do
                    if mx >= functional_button[k].x1 and mx <= functional_button[k].x2 and my >= functional_button[k].y1 and
                        my <= functional_button[k].y2 then
                        selected_content = k;
                        break
                    end
                end
            end
            if ktype == 3 then
                if selected_content == 1 then
                    if num >= minNum and num <= maxNum then
                        break
                    end
                elseif selected_content == 2 then
                    num = maxNum
                elseif selected_content == 3 then
                    num = 0
                elseif selected_content == 4 then
                    num = math.modf(num / 10)
                elseif selected_content > 4 then
                    num = num * 10
                    num = num + functional_button[selected_content].name
                    if num > maxNum then
                        num = maxNum
                    end
                end
            end
        end
        ClsN();
        lib.LoadSur(sid, 0, 0)
    end
    lib.FreeSur(sid);
    return num;
end

-- �����ַ������Ƿ�����ɫ��־
-- ��DrawTxt��������
function AnalyString(str)
    local tlen = 0;
    local strcolor = {}
    -- ����Ƿ�����ɫ��־
    local f1, f2 = string.find(str, "<[A-R]>");
    if f1 ~= nil then
        while 1 do
            if f1 > 1 then
                local s1 = string.sub(str, 1, f1 - 1)
                table.insert(strcolor, {s1, nil});
                tlen = tlen + #s1;
            end
            local match = string.match(str, "<([A-R])>");
            local f3, f4 = string.find(str, "</" .. match .. ">");
            if f3 ~= nil then
                local s2 = string.sub(str, f2 + 1, f3 - 1);
                table.insert(strcolor, {s2, CC.Color[match]});
                tlen = tlen + #s2;
                if f4 + 1 >= #str then
                    break
                end
                str = string.sub(str, f4 + 1, #str);
                f1, f2 = string.find(str, "<[A-R]>");
                -- ����Ѿ�û��������ɫ��־��ֱ�������˳�ѭ��
                if f1 == nil then
                    table.insert(strcolor, {str, nil});
                    break
                end
            else -- ����Ҳ���������־��ֱ�������˳�ѭ��
                str = string.sub(str, f2 + 1, #str);
                table.insert(strcolor, {str, CC.Color[match]});
                break
            end
        end
    else
        table.insert(strcolor, {str, nil});
    end
    return strcolor;
end

function Savemenu(menu)

    local bx, by = CC.ScreenW / CC.ScreenW, CC.ScreenH / CC.ScreenH
    local size = CC.DefaultFont * 0.7
    local fx = bx * 100
    local fy = by * 100
    local fx1 = bx * 385
    local fy1 = by * 183
    local cx = size * 7
    local cy = size * 1.3
    local tb = 1
    local cl = C_WHITE1
    local fx2 = bx * 20
    local fy2 = by * 20
    local cot = 0
    local num = 6
    local savewz = '�������'
    if CC.Save == 0 then
        savewz = '��ȡ����'
        num = 9
    end

    while true do
        if JY.Restart == 1 then
            break
        end
        Cls()
        lib.LoadPNG(91, 239 * 2, 0, 0, 1)
        DrawString(CC.ScreenW / 2 - string.len(savewz) / 4 * size * 2.5, by * 10, savewz, C_WHITE, size * 2.5, CC.FONT2)
        local m, n = 0, 0
        for i = 1, 9 do
            local cl = C_WHITE1
            lib.LoadPNG(91, 546 * 2, fx + (n) * fx1, fy + fy1 * (m), 1)
            if tb == i then
                cl = C_RED
            end
            DrawString(fx2 + fx + n * fx1, fy2 + fy + fy1 * m, menu[i][1], cl, size, CC.FONT5)
            DrawString(fx2 + fx + n * fx1, fy2 + fy + fy1 * m + cy, menu[i][2], cl, size, CC.FONT5)
            DrawString(fx2 + fx + n * fx1 + cx, fy2 + fy + fy1 * m, menu[i][3], cl, size, CC.FONT5)
            DrawString(fx2 + fx + n * fx1 + cx, fy2 + fy + fy1 * m + cy, menu[i][4], cl, size, CC.FONT5)
            DrawString(fx2 + fx + n * fx1, fy2 + fy + fy1 * m + cy * 2, menu[i][5], cl, size, CC.FONT5)
            DrawString(fx2 + fx + n * fx1 + cx, fy2 + fy + fy1 * m + cy * 2, menu[i][6], cl, size, CC.FONT5)
            DrawString(fx2 + fx + n * fx1, fy2 + fy + fy1 * m + cy * 3, menu[i][7], cl, size, CC.FONT5)
            DrawString(fx2 + fx + n * fx1, fy2 + fy + fy1 * m + cy * 4, menu[i][8], cl, size, CC.FONT5)
            n = n + 1
            if n == 3 then
                m = m + 1
                n = 0
            end
        end
        m = 0
        n = 0
        ShowScreen()
        lib.Delay(CC.BattleDelay)
        local key, ktype, mx, my = lib.GetKey()
        if key == VK_ESCAPE or ktype == 4 then
            break
        elseif key == VK_RETURN or key == VK_BACKSPACE then
            cot = menu[tb][10]
            break
        elseif key == VK_RIGHT then
            tb = tb + 1
            if tb > num then
                tb = 1
            end
        elseif key == VK_LEFT then
            tb = tb - 1
            if tb < 1 then
                tb = num
            end
        else
            local pd = true
            local m, n = 0, 0

            for i = 1, num do
                -- fx+(n)*fx1 ,fy+fy1*(m)
                if mx > fx + (n) * fx1 and mx < fx + (n) * fx1 + fx1 and my > fy + fy1 * (m) and my < fy + fy1 * (m) +
                    fy1 then
                    tb = i
                    pd = true
                    break
                end
                n = n + 1
                if n == 3 then
                    m = m + 1
                    n = 0
                end
            end
            n = 0
            m = 0
            if pd == true and ktype == 3 then
                cot = menu[tb][10]
                break
            end
        end
    end
    return cot
end

-- �浵�б�
function SaveList()
    -- ��ȡR*.idx�ļ�
    local idxData = Byte.create(24)
    Byte.loadfile(idxData, CC.R_IDXFilename[0], 0, 24)
    local idx = {}
    idx[0] = 0
    for i = 1, 6 do
        idx[i] = Byte.get32(idxData, 4 * (i - 1))
    end
    local time_details = os.date("*t")
    JY.Base['�浵��'] = time_details.month -- ��
    JY.Base['�浵��'] = time_details.day -- ��
    JY.Base['�浵ʱ'] = time_details.hour -- ʱ
    JY.Base['�浵��'] = time_details.min -- ��
    -- JY.Base['�浵��'] = os.time()

    local table_struct = {}
    table_struct["����"] = {idx[1] + 8, 2, 10}
    table_struct["����"] = {idx[1] + 122, 0, 2}

    table_struct["����"] = {idx[0] + 2, 0, 2}
    table_struct["�Ѷ�"] = {idx[0] + 24, 0, 2}

    table_struct["��׼"] = {idx[0] + 26, 0, 2}
    table_struct["����"] = {idx[0] + 28, 0, 2}
    table_struct["����"] = {idx[0] + 30, 0, 2}

    table_struct["��������"] = {idx[0] + 36, 0, 2}
    table_struct["�书����"] = {idx[0] + 38, 0, 2}
    table_struct["��������"] = {idx[3] + 2, 2, 10}
    table_struct["��Ƭ"] = {idx[0] + 40, 0, 2}
    table_struct["��ͨ"] = {idx[0] + 32, 0, 2}
    -- ���Ǳ��
    table_struct["����1"] = {idx[0] + 72, 0, 2}

    table_struct['�浵��'] = {idx[0] + 58, 0, 2}
    table_struct['�浵��'] = {idx[0] + 64, 0, 2}
    table_struct['�浵ʱ'] = {idx[0] + 68, 0, 2}
    table_struct['�浵��'] = {idx[0] + 70, 0, 2}

    table_struct['����'] = {idx[0] + 66, 0, 2}
    table_struct['��'] = {idx[0] + 20, 0, 2}
    table_struct['ʱ'] = {idx[0] + 18, 0, 2}
    table_struct['��'] = {idx[0] + 16, 0, 2}
    -- table_struct[WZ7]={idx[2]+88,0,2}

    -- ��ȡR*.grp�ļ�

    local len = filelength(CC.R_GRPFilename[0]);
    local data = Byte.create(len);

    -- ��ȡSMAP.grp
    local slen = filelength(CC.S_Filename[0]);
    local sdata = Byte.create(slen);
    local menu = {};

    -- time_details.year
    -- time_details.month
    -- time_details.day
    -- time_details.hour
    -- time_details.min
    for i = 1, CC.SaveNum do

        local name = "";
        -- local lv = "";
        local sname = "";
        local nd = "";
        local time = "";
        -- ��������
        local tssl = "";
        -- ��������
        local zjlx = "";
        -- ����
        local zz = "";
        local gametime = ''
        local moshi = ''
        if existFile(string.format(CC.SavePath .. 'Save_%d'..'.sav', i)) then
            --Byte.loadfilefromzip(data, string.format(CC.SavePath .. 'Save_%d', i), CC.SavePath .. 'r.grp', 0, len);
			Byte.loadfilefromzip(data, string.format(CC.SavePath .. 'Save_%d'..'.sav', i),'r.grp', 0, len);
            -- ����
            local pid = GetDataFromStruct(data, 0, table_struct, "����1");
            name = '������' .. GetDataFromStruct(data, pid * CC.PersonSize, table_struct, "����");
            zz = GetDataFromStruct(data, pid * CC.PersonSize, table_struct, "����");

            -- ����
            local lxid1 = GetDataFromStruct(data, 0, table_struct, "��׼");
            local lxid2 = GetDataFromStruct(data, 0, table_struct, "����");
            local lxid3 = GetDataFromStruct(data, 0, table_struct, "����");
            if lxid1 > 0 then
                zjlx = "���ͣ���׼"
            elseif lxid2 > 0 then
                zjlx = "���ͣ�����"
            elseif lxid3 > 0 then
                zjlx = "���ͣ�����"
            end

            -- �Ѷ�
            local wz = GetDataFromStruct(data, 0, table_struct, "�Ѷ�");
            nd = '�Ѷȣ�' .. MODEXZ2[wz]

            -- ģʽ
            local dt = GetDataFromStruct(data, 0, table_struct, "��ͨ");
            if dt == 0 then
                moshi = 'ģʽ����ͨ'
            elseif dt == 1 then
                moshi = 'ģʽ����ͨ'
            elseif dt == 2 then
                moshi = 'ģʽ������'
            end

            -- ����
            local wy = GetDataFromStruct(data, 0, table_struct, "����");
            if wy == -1 then
                sname = "���������ͼ";
            else
                sname = '������' .. GetDataFromStruct(data, wy * CC.SceneSize, table_struct, "��������") .. "";
            end

            -- ��Ϸʱ��		
            -- Byte.loadfile(sdata, string.format(CC.S_GRP,i), 0, slen);	
            local t = GetDataFromStruct(data, 0, table_struct, "��")
            local t1 = GetDataFromStruct(data, 0, table_struct, "��")
            local t2 = GetDataFromStruct(data, 0, table_struct, "ʱ")
            time = '��Ϸʱ�䣺' .. t2 .. 'ʱ' .. t1 .. '��' .. t .. '��'
            local t, gamet = gettime(i)
            local t1, t2, t3 = 0, 0, 0
            while t >= 60 do
                t = t - 60
                t1 = t1 + 1
                while t1 >= 60 do
                    t1 = t1 - 60
                    t2 = t2 + 1
                end
            end
            t3 = t

            time = '��Ϸʱ����' .. t2 .. 'ʱ' .. t1 .. '��' .. t3 .. '��'

            local gtime = os.date('*t', gamet)
            -- �浵ʱ��
            local time0 = gtime.year
            local time1 = gtime.month -- GetDataFromStruct(data, 0, table_struct, "�浵��")
            local time2 = gtime.day -- GetDataFromStruct(data, 0, table_struct, "�浵��")
            local time3 = gtime.hour -- GetDataFromStruct(data, 0, table_struct, "�浵ʱ")
            local time4 = gtime.min -- GetDataFromStruct(data, 0, table_struct, "�浵��")
            local time5 = gtime.sec
            gametime = '�浵ʱ�䣺' .. time1 .. '��' .. time2 .. '��' .. time3 .. 'ʱ' .. time4 .. '��'
            -- time0 = GetDataFromStruct(data, 0, table_struct, "�浵��")
        end
        local bwz = {'һ', '��', '��', '��', '��', '��', '��', '��', '��', 'ʮ'}
        local zd = bwz[i - 6]

        if i <= 6 then
            menu[i] = {'�浵' .. bwz[i], zjlx, name, nd, moshi, sname, time, gametime, 1, i}
        else
            menu[i] = {'�Զ���' .. zd, zjlx, name, nd, moshi, sname, time, gametime, 1, i}
        end
    end

    local menux = (CC.ScreenW - 24 * CC.DefaultFont - 2 * CC.MenuBorderPixel) / 2
    local menuy = (CC.ScreenH - 9 * (CC.DefaultFont + CC.RowPixel)) / 2

    -- local r=ShowMenu(menu,CC.SaveNum,10,menux,menuy,0,0,1,1,CC.DefaultFont,C_WHITE,C_GOLD)
    local r = Savemenu(menu)
    lib.Debug("SaveList")
    CleanMemory()
    return r;
end


function DrawTimer()
    if CC.OpenTimmerRemind ~= 1 then -- ��̬��ʾ�Ƿ��
        -- return;
    end
    -- CC.Timer={
    -- stime=0, -- ʱ��
    -- status=0, --״̬
    -- str='', --����
    -- len=0, --����1
    -- fun=demostr, --CD
    -- CC.RUNSTR --���ֱ��
    local t2 = lib.GetTime(); -- ϵͳʱ�� 

    if JY.Status == GAME_SMAP or JY.Status == GAME_MMAP then
        if CC.Timer.status == 0 then
            if CC.TX['�������'] > 0 then
                CC.Timer.stime = t2;
                CC.Timer.status = 1;
                CC.Timer.str = "��ﴫ�������ɾ����챦������"
                CC.Timer.len = string.len(CC.Timer.str) / 2;
                CC.TX['��ɫ'] = 1
            elseif CC.Day == 8 or CC.Day == 7 then
                -- lib.Debug('������ű���')
                CC.Timer.stime = t2;
                CC.Timer.status = 1;
                CC.Timer.str =
                    "��ｭ��Ǽ����ڳ����վ��б��䣬���·����ӻԾ���ڣ��������ش󽱡�"
                CC.Timer.len = string.len(CC.Timer.str) / 2;
                CC.TX['��ɫ'] = 2
            elseif CC.Day == 18 or CC.Day == 17 then
                -- lib.Debug('����ʮ�ű���')
                CC.Timer.stime = t2;
                CC.Timer.status = 1;
                CC.Timer.str =
                    "��ｭ��Ǽ�����ʮ���վ��б��䣬���·����ӻԾ���ڣ��������ش󽱡�"
                CC.Timer.len = string.len(CC.Timer.str) / 2;
                CC.TX['��ɫ'] = 3
            elseif CC.TX['��������'] > 0 then
                -- lib.Debug('�������̳���')
                CC.Timer.stime = t2;
                CC.Timer.status = 1;
                if CC.TX['��������'] < 1000 then
                    CC.Timer.str = "����������˼����뿪���ݡ�"
                else
                    CC.Timer.str = "����������������ݳ��֡�"
                end
                CC.Timer.len = string.len(CC.Timer.str) / 2;
                CC.TX['��ɫ'] = 4
            elseif t2 - CC.Timer.stime > 300 or CC.Timer.stime == 0 then
                -- lib.Debug('������Ϣ��ʾ')
                CC.Timer.stime = t2;
                CC.Timer.status = 1;
                CC.Timer.str = CC.RUNSTR[math.random(#CC.RUNSTR)];
                CC.Timer.len = string.len(CC.Timer.str) / 2;
            end
            -- lib.Debug('CC.Timer.stime'..CC.Timer.stime..' CC.Timer.status'..CC.Timer.status..' t2'..t2)
        else
            CC.Timer.fun(t2);
        end
    end
end

function demostr(t)
    local bx, by = CC.WX, CC.HY
    local tt = t - CC.Timer.stime;
    local cl = C_WHITE
    tt = math.modf(tt / 25) % (915 + CC.Timer.len * CC.Fontsmall);
    local pcw, pch = lib.GetPNGXY(91, 130 * 2);
    lib.SetClip(bx * 915, 0, bx * 1336, 0 + pch) -- �ü�
    if CC.TX['��ɫ'] > 0 then
        cl = C_RED
    end

    if runword(CC.Timer.str, cl, CC.Fontsmall, 1, tt) == 1 then
        CC.Timer.status = 0;
        CC.Timer.stime = t;
    end
end

function runword(str, color, size, place, offset)
    offset = CC.ScreenW - offset;
    local y1, y2
    if place == 0 then
        y1 = 0;
        y2 = size;
    elseif place == 1 then
        y1 = CC.ScreenH - size;
        y2 = CC.ScreenH;
    end
    local tt2 = 930 - (CC.Timer.len - 1) * size
    if offset < tt2 then
        return 1;
    end
    -- DrawString(955,0,offset..'/'..tt2,C_RED,CC.Fontsmall*0.7);
    DrawString(offset, 4, str, color, size * 0.7);
    return 0;
end

function dark()
    instruct_14()
end

function light()
    instruct_13()
end

-- �޾Ʋ���������¼�����
function addevent(sid, pid, pass, event, etype, pic, x, y)
    if JY.Restart == 1 then
        return
    end
    if x == nil then
        x = -2
    end
    if y == nil then
        y = -2
    end
    if pic == nil then
        pic = -2
    end
    if etype == nil then
        etype = 1
    end
    if event == nil then
        event = -2
    end
    if pass == nil then
        pass = -2
    end
    if etype == 1 then
        instruct_3(sid, pid, pass, 0, event, 0, 0, pic, pic, pic, -2, x, y)
    elseif etype == 2 then
        instruct_3(sid, pid, pass, 0, 0, event, 0, pic, pic, pic, -2, x, y)
    else
        instruct_3(sid, pid, pass, 0, 0, 0, event, pic, pic, pic, -2, x, y)
    end
end

-- �޾Ʋ�����ɾ���¼�����
function null(sid, pid)
    addevent(sid, pid, 0, 0, 0, 0)
end

-- �������
function showCXStatic(id)
    local bx, by = CC.WX * 210, CC.HY * 50
    if existFile(CC.Acvmts) then
        dofile(CC.Acvmts)
        local r = false
        local ndChn = {"��", "��ͨ", "����", "����"}
        local highLvl
        if Achievements.rdsCpltd[id].lvlReached2 > 0 then
            highLvl = Achievements.rdsCpltd[id].lvlReached1 .. "��" .. ndChn[Achievements.rdsCpltd[id].lvlReached2]
        else
            highLvl = "����"
        end
        while true do
            if JY.Restart == 1 then
                return
            end
            Cls()

            lib.LoadPNG(91, 30 * 2, bx, by, 3)

            DrawString(bx + CC.WX * 390, by + CC.HY * 10, JY.Person[id]["����"], C_GOLD, CC.FontBig * 0.9)

            DrawString(bx + CC.WX * 80, by + CC.HY * 130, "ͨ�ش�����" .. Achievements.rdsCpltd[id].n .. "��", C_WHITE, CC.DefaultFont)
            DrawString(bx + CC.WX * 80, by + CC.HY * 200, "���ͨ���Ѷȣ�" .. highLvl, C_WHITE, CC.DefaultFont)
            DrawString(CC.ScreenW / 2 - 160, CC.ScreenH - 40, "�س���ȷ�� ESC�����ϲ�", LimeGreen,CC.DefaultFont * 0.98)

            local keypress, ktype, mx, my = lib.GetKey()

            if keypress == VK_RETURN then
                r = true
                break
            elseif keypress == VK_ESCAPE or ktype == 4 then
                break
            end
            ShowScreen()
            lib.Delay(CC.Frame)
        end
        return r
    end
end

-- �޾Ʋ�������ȡ�书����
function get_skill_power(personid, wugongid, wugonglvl)
    local power;
    local p = JY.Person[personid]
    local lx = JY.Wugong[wugongid]['�书����']
    local mp = JY.Wugong[wugongid]['����']
    local dkfcj_ng = JY.Wugong[JY.Person[personid]['�����ڹ�']]['�㼶']
    local nglv = KF_level(personid, JY.Person[personid]['�����ڹ�'])
    -- �������书��10��������
    if wugonglvl == 11 then
        wugonglvl = 10
    end
    local spower = 0
    power = JY.Wugong[wugongid]["������" .. wugonglvl]
    spower = power
    -- �⹦����������+10%
    for i = 1, JY.Base['�书����'] do
        local level = math.modf(p["�书�ȼ�" .. i] / 100) + 1
        if p["�书�ȼ�" .. i] == 999 and JY.Wugong[wugongid]['�书����'] ~= 6 and wugongid == p['�书' .. i] then
            power = power * 1.1
            break
        end
    end
    -- ������Ч700
    if NeiGong_tx(personid, 700) then
        for i = 1, JY.Base['�书����'] do
            local kf = JY.Person[personid]['�书' .. i]
            if wugongid == kf then
                power = power + dkfcj_ng * 10 * nglv
            end
        end
    end
    if wugongid >= 109 and wugongid <= 112 then
        local xs = 0

        if lx == 1 then
            xs = TrueQZ(personid) -- JY.Person[personid]["ȭ�ƹ���"]
        elseif lx == 2 then
            xs = TrueZF(personid) -- JY.Person[personid]["ָ������"]
        elseif lx == 3 then
            xs = TrueYJ(personid) -- JY.Person[personid]["��������"]    
        elseif lx == 4 then
            xs = TrueSD(personid) -- JY.Person[personid]["ˣ������"]
        elseif lx == 5 then
            xs = TrueTS(personid) -- JY.Person[personid]["�������"]
        end
        if isteam(personid) then
            power = limitX(power + xs * 3, 300, 1500)
        else
            power = 1500
        end
    end
    -- ��������
    if Pmiji(personid, 77) then
        if wugongid == 8 or wugongid == 14 or wugongid == 201 or wugongid == 202 then
            power = power + 250
        end
    end
    -- ��ʯ
    if JY.Person[personid]["��Ѩ" .. 3] == 1 and lx == 2 then
        power = power + 200
    end
    -- ˫��˫��
    if match_ID(personid, 9735) and (lx == 3 or lx == 4) then
        power = power + 200
    end
    -- ����츳�ڹ�������
    if power < 1000 and Given_NG(personid, wugongid) then
        power = power + 100
        if power > 1000 then
            power = 1000
        end
    end
    -- ��ɽ���Ϸ����ǵ���
    if wugongid == 60 then
        if match_ID(personid, 108) or match_ID(personid, 107) then
            power = power + 200
        end
    end
    -- ��ɽ˫ӥ	
    if wugongid == 4 then
        if match_ID(personid, 311) or match_ID(personid, 312) then
            power = power + 500
        end
    end
    -- �廢�ϻ�
    if wugongid == 59 then
        if match_ID(personid, 106) then
            power = power + 200
        end
    end
    -- ѧ�˿���֮�󣬱�а������
    if wugongid == 48 and PersonKF(personid, 105) then
        power = power + 1000
    end
    -- ��������
    if wugongid == 142 then
        if match_ID(personid, 131) then
            power = power + 200
        end
    end
    -- Τ��˫��
    if match_ID(personid, 742) and wugongid == 347 then
        power = power + 400
    end
    -- ���ɽ�
    if match_ID(personid, 743) and wugongid == 326 then
        power = power + 400
    end
    -- ������ʦ
    if wugongid == 13 then
        if match_ID(personid, 567) then
            power = power + 500
        end
    end
    -- ���ҽ�
    if wugongid == 200 then
        if match_ID(personid, 568) then
            power = power + 300
        end
    end
    if wugongid == 198 then
        if match_ID(personid, 568) then
            power = power + 300
        end
    end
    -- ħ����ʦ
    if mp == 5 then
        if match_ID(personid, 641) then
            power = power + 400
        end
    end
    -- ̫������ 
    if wugongid == 37 then
        if match_ID(personid, 166) then
            power = power + 200
        end
    end
    -- ������˫
    if JY.Wugong[wugongid]['����'] == 1 then
        if match_ID(personid, 9993) then
            power = power + 500
        end
    end
    -- �������
    if JY.Wugong[wugongid]['����'] == 11 then
        if match_ID(personid, 220) then
            power = power + 500
        end
    end
    -- ��ɽ����
    if JY.Wugong[wugongid]['����'] == 12 then
        if match_ID(personid, 379) then
            power = power + 500
        end
    end
    -- ��ɽ���� �������
    if JY.Wugong[wugongid]['����'] == 13 then
        if match_ID(personid, 21) or match_ID(personid, 387) then
            power = power + 500
        end
    end
    -- ̩ɽ����
    if JY.Wugong[wugongid]['����'] == 14 then
        if match_ID(personid, 201) then
            power = power + 500
        end
    end
    -- ѩɽ����
    if JY.Wugong[wugongid]['����'] == 18 then
        if match_ID(personid, 250) or match_ID(personid, 43) then
            power = power + 500
        end
    end
    -- ��ü����
    if JY.Wugong[wugongid]['����'] == 19 then
        if match_ID(personid, 6) then
            power = power + 500
        end
    end
    -- �������
    if JY.Wugong[wugongid]['����'] == 20 then
        if match_ID(personid, 8) or match_ID(personid, 359) then
            power = power + 500
        end
    end
    -- ��������
    if JY.Wugong[wugongid]['����'] == 21 then
        if match_ID(personid, 7) then
            power = power + 500
        end
    end
    -- ���ڴ���
    if match_ID(personid, 249) and wugongid == 61 then
        power = power + 400
    end

    -- ���ӹ�
    if match_ID(personid, 34) and wugongid == 73 and JY.Person[0]["�������"] > 0 then
        power = power * 2
    end
    -- ���嵶������������
    if match_ID(personid, 94) and JY.Wugong[wugongid]["�书����"] == 4 then
        power = power * 2
    end
    -- �ڰ���
    if match_ID(personid, 33) and wugongid == 72 and JY.Person[0]["�������"] > 0 then
        power = power * 2
    end
    -- ͺ����
    if match_ID(personid, 32) and wugongid == 142 and JY.Person[0]["�������"] > 0 then
        power = power * 2
    end
    -- ������
    if match_ID(personid, 31) and wugongid == 84 and JY.Person[0]["�������"] > 0 then
        power = power * 2
    end
    -- �߶�����
    if match_ID(personid, 138) then
        if JY.Wugong[wugongid]["�书����"] == 2 then
            if JY.Base["����"] == personid then
                power = power + (50 * JY.Base["��������"])
            else
                power = power + 200
            end
        end
    end
    -- ����
    if match_ID(personid, 603) and wugongid == 119 then
        power = power * 2
    end
    -- ������
    if wugongid == 37 then
        if match_ID(personid, 109) then
            power = power + 200
        end
    end
    -- ����ׯ��
    if JY.Wugong[wugongid]["�书����"] == 5 then
        if match_ID(personid, 110) or match_ID(personid, 111) then
            power = power + 150
        end
    end
    -- ���Ѻ󷭱�������
    -- ������+ȫ�����ӣ�ȫ�潣��
    if wugongid == 39 then
        if match_ID(personid, 123) or match_ID(personid, 124) or match_ID(personid, 125) or match_ID(personid, 126) or
            match_ID(personid, 127) or match_ID(personid, 128) or match_ID(personid, 68) then
            power = power * 2
        end
    end
    if match_ID(personid, 129) and JY.Wugong[wugongid]["����"] == 7 then
        power = power * 2
    end

    -- ÷���磬����Ů�����׹�צ
    if wugongid == 11 and JY.Person[0]["�������"] > 0 and (match_ID(personid, 78) or match_ID(personid, 640)) then
        power = power * 1.5
    end
    -- �������
    if wugongid == 189 and (match_ID(personid, 9983) or JinGangBR(personid)) then
        power = power * 1.5
    end
    -- ������
    if (wugongid == 230 or wugongid == 231) and PersonKF(personid, 235) then
        power = power + 200
    end
    -- ���߽���
    if wugongid == 40 then
        -- ��ѩ��
        if match_ID(personid, 639) then
            power = power * 1.5
        end
        -- ��ç��
        if match_ID(personid, 137) then
            power = power + 200
        end
    end
    -- ���� ѩɽ����
    if wugongid == 35 and match_ID(personid, 9739) then
        power = power * 1.5
    end

    -- ΤһЦ����������
    if wugongid == 5 and JY.Person[0]["�������"] > 0 and match_ID(personid, 14) then
        power = power * 1.5
    end
    -- ��������ӥצ��
    if wugongid == 4 and match_ID(personid, 12) then
        power = power * 1.5
    end
    -- ��ϣ��ֽ�����
    if wugongid == 117 and JY.Person[0]["�������"] > 0 and match_ID(personid, 131) then
        power = power * 1.5
    end
    -- �����ź���ʮ�˱���������
    if match_ID(personid, 612) and wugongid == 206 and JY.Status == GAME_WMAP and WAR.ZWX > 0 then
        power = power * WAR.ZWX
    end
    -- ׿���ۺ���ʮ�˱���������
    if match_ID(personid, 613) and wugongid == 206 and JY.Status == GAME_WMAP and WAR.ZWX > 0 then
        power = power * WAR.ZWX
    end
    -- ׿��������������������
    if match_ID(personid, 613) and wugongid == 205 and JY.Status == GAME_WMAP and WAR.ZWX > 0 then
        power = power * WAR.ZWX
    end

    -- �����̳�������������
    if match_ID(personid, 510) and wugongid == 73 then
        power = power * 2
    end

    -- �쵶����
    if wugongid == 335 then
        power = power + JY.Base["��������"] * 100
    end

    -- ������ս�����嶾��������
    if (match_ID(personid, 83) or match_ID(personid, 9814)) and wugongid == 3 and JY.Status == GAME_WMAP and WAR.HTS > 0 then
        power = power * WAR.HTS
    end

    -- �ֳ�Ӣ�����ž���
    if match_ID(personid, 605) then
        power = power * 1.1
    end

    -- ��׺��ɷ罣������
    if wugongid == 27 and JY.Person[0]["�������"] > 0 and (match_ID(personid, 24) or match_ID(personid, 9891)) then
        power = power * 2
    end
    -- ���Ѻ���׺��ɷ罣������
    if wugongid == 27 and (match_ID(personid, 24) or match_ID(personid, 9891)) then
        power = power * 2
    end

    -- ����츳�⹦������
    if Given_WG(personid, wugongid) then
        power = power + 200
    end

    -- Ԭ���� ���޵��� 1.5��
    if wugongid == 62 and match_ID(personid, 566) then
        power = power + 300
    end

    -- Ԭ������������
    if match_ID(personid, 587) and (wugongid == 78 or wugongid == 164) then
        power = power + 300
    end

    -- ��ع���
    if match_ID(personid, 9988) and wugongid == 10 then
        power = power + 600
    end
    -- �߱�ָ���ӳ���ң���书
    if JY.Person[personid]["����"] == 200 then
        if mp == 3 then
            power = power + 100
        end
    end

    -- ̫����
    if (wugongid == 16 or wugongid == 46) and Curr_NG(personid, 171) then
        power = power + 200
    end

    -- �������� һ��ָ
    if wugongid == 17 and PersonKF(personid, 207) then
        power = power + 200
    end
    -- �ɽ���Գ
    if wugongid == 188 then
        if (match_ID(personid, 185) and JY.Person[personid]["����"] == 326) or match_ID(personid, 575) then
            power = power + 500
        end
    end
    -- ��ɽ��÷�֣�����ͯ�ѣ������ӣ�����ˮ���������
    if wugongid == 14 then
        if match_ID(personid, 9815) then
            for i = 1, JY.Base["�书����"] do
                if JY.Person[personid]["�书" .. i] ~= 14 and JY.Person[personid]["�书�ȼ�" .. i] == 999 then
                    power = power + 50
                end
            end
        end
    end
    -- ��ħ���� ��ħ�ȷ�
    if wugongid == 86 and JY.Person[personid]["����"] == 323 then
        power = power + 200
    end
    -- ��Գ Գ������
    if (wugongid == 188 or wugongid == 156) and JY.Person[personid]["����"] == 326 then
        power = power + 200
    end

    if wugongid == 110 and JY.Person[personid]["����"] == 55 then
        power = power + 200
    end
    if wugongid == 111 and JY.Person[personid]["����"] == 56 then
        power = power + 200
    end
    if wugongid == 112 and JY.Person[personid]["����"] == 57 then
        power = power + 200
    end

    -- ����ѩɽ����
    if wugongid == 35 then
        if match_ID_awakened(personid, 582, 1) then
            for i = 1, JY.Base["�书����"] do
                if JY.Person[personid]["�书" .. i] ~= 35 and JY.Person[personid]["�书�ȼ�" .. i] == 999 then
                    power = power + 100
                end
            end
        end
    end

    -- �������ڵ���
    if wugongid == 61 and match_ID_awakened(personid, 581, 1) then
        power = power + 300
    end
    -- ���������������
    if wugongid >= 30 and wugongid <= 34 then
        power = power + WuyueJFSL(personid) * 100
    end
    -- ��������+�����������������
    if wugongid >= 30 and wugongid <= 34 and PersonKF(personid, 175) then
        power = power + 200
    end
    -- ˫���ϱڣ��������
    if (wugongid == 39 or wugongid == 42 or wugongid == 139) and ShuangJianHB(personid) then
        power = power + 300
    end
    -- �����黭�������
    if (wugongid == 73 or wugongid == 72 or wugongid == 84 or wugongid == 142) and Pmiji(personid, 63) then
        power = power + 300
    end
    -- �һ������������
    if (wugongid == 12 or wugongid == 18 or wugongid == 38) and Pmiji(personid, 5) then
        power = power + 200
    end
    -- ��������������� ����޸�
    if (wugongid == 3 or wugongid == 120 or wugongid == 220 or wugongid == 295 or wugongid == 334) and
        Pmiji(personid, 8) then
        power = power + 500
    end
    -- ���������������
    if (wugongid == 5 or wugongid == 9 or wugongid == 21 or wugongid == 118) and Pmiji(personid, 6) then
        power = power + 300
    end
    -- ���������������
    if (wugongid == 8 or wugongid == 14 or wugongid == 201 or wugongid == 202) and Pmiji(personid, 7) then
        power = power + 250
    end
    -- �׽��ǿ������ѧ
    if JY.Wugong[wugongid]["����"] == 1 and PersonKF(personid, 108) then
        if Curr_NG(personid, 108) then
            power = power + 200
        else
            power = power + 100
        end
    end
    -- �����񹦶԰׹�צ�������
    if wugongid == 11 and PersonKF(personid, 107) then
        power = power + 200
    end
    -- ����װ�������ӳ�
    for i, v in ipairs(CC.ExtraOffense) do
        if v[1] == JY.Person[personid]["����"] and v[2] == wugongid then
            power = power + v[3]
        end
    end
    -- ֻ��ս���в��еļӳ�
    if JY.Status == GAME_WMAP then
        -- ̫��������
        -- ֻ��ս���в��еļӳ�
        if Curr_NG(personid, 171) and (wugongid == 16 or wugongid == 46) and WAR.tmp[3000 + personid] ~= nil and
            WAR.tmp[3000 + personid] > 0 then
            if wugongid == 16 then
                power = power + WAR.tmp[3000 + personid] * 1.5
            else
                power = power + WAR.tmp[3000 + personid]
            end
        end
        if WAR.PD['ѩ������'][personid] ~= nil and wugongid == 35 then
            power = power + spower * WAR.PD['ѩ������'][personid] * 0.5
        end
    end
    -- ˭������
    if match_ID(personid, 9734) then
        if JY.Person[personid]["����"] == 37 and lx == 3 then
            power = power + 200
        end
    end
    -- ȭ����ͨ
    if match_ID(personid, 9960) and JY.Wugong[wugongid]["�书����"] == 1 then
        power = power + 100
    end
    -- ָ����ͨ
    if match_ID(personid, 9959) and JY.Wugong[wugongid]["�书����"] == 2 then
        power = power + 100
    end
    -- ������ͨ
    if match_ID(personid, 9958) and JY.Wugong[wugongid]["�书����"] == 3 then
        power = power + 100
    end
    -- ������ͨ
    if match_ID(personid, 9957) and JY.Wugong[wugongid]["�书����"] == 4 then
        power = power + 100
    end
    -- ���ž�ͨ
    if match_ID(personid, 9956) and JY.Wugong[wugongid]["�书����"] == 5 then
        power = power + 100
    end
    -- ǧ����ͨ
    if match_ID(personid, 9954) and JY.Wugong[wugongid]["�书����"] == 2 then
        power = power + 200
    end
    -- ����ͨ��
    if match_ID(personid, 9953) and JY.Wugong[wugongid]["�书����"] == 3 then
        power = power + 200
    end
    -- ������
    if match_ID(personid, 9952) and JY.Wugong[wugongid]["�书����"] == 4 then
        power = power + 200
    end
    -- ������˫
    if match_ID(personid, 9951) and JY.Wugong[wugongid]["�书����"] == 5 then
        power = power + 200
    end
    -- ������˫
    if match_ID(personid, 9951) and JY.Wugong[wugongid]["�书����"] == 5 then
        power = power + 200
    end
    -- ��һ�� �ɶ�����
    if match_ID(personid, 633) and JY.Person[personid]["����"] == 45 and wugongid == 67 then
        power = power + 200
    end
    -- ��޿
    if match_ID(personid, 588) and (wugongid == 18 or wugongid == 38 or wugongid == 12 or wugongid == 126) then
        power = power + 200
    end
    -- ���Ե� ����޸�
    if match_ID(personid, 9921) and wugongid == 231 then
        power = power + 400
    end
    -- ������ ����޸�
    if match_ID(personid, 9920) and wugongid == 230 then
        power = power + 400
    end
    -- ������ ����޸�
    if match_ID(personid, 9919) and JY.Wugong[75]["����"] == "�����" and wugongid == 75 then
        power = power + 567
    end
    if match_ID(personid, 9919) and JY.Wugong[75]["����"] == "ħ��ǧ��" and wugongid == 75 then
        power = power + 1000
    end

    -- ِ�ж� ����޸�
    if match_ID(personid, 9915) and wugongid == 119 then
        power = power + 600
    end
    --�ڹ���Ч906
    if NeiGong_tx(personid,906) and lx == 1 then 
        power = power + dkfcj_ng*200
    end
    --�ڹ���Ч907
    if NeiGong_tx(personid,907) and lx == 2 then 
        power = power + dkfcj_ng*200
    end    
    --�ڹ���Ч908
    if NeiGong_tx(personid,908) and lx == 3 then 
        power = power + dkfcj_ng*200
    end
    --�ڹ���Ч909
    if NeiGong_tx(personid,909) and lx == 4 then 
        power = power + dkfcj_ng*200
    end
    --�ڹ���Ч910
    if NeiGong_tx(personid,910) and lx == 5 then 
        power = power + dkfcj_ng*200
    end        
    -- ����ְ���ǿ������ѧ����
    for i = 1, #MPname do
        local mp = JY.Person[personid]["����"]
        local zw = math.modf(JY.Person[personid]["���ɹ���"] / 200) + 1
        if mp == JY.Wugong[wugongid]["����"] then
            power = power + zw * 50
            break
        end
    end
    -- ���������ڹ���ǿ������ѧ����
    local zyng = JY.Person[personid]["�����ڹ�"]
    local mp = JY.Person[personid]["����"]
    if JY.Wugong[zyng]["����"] == mp then
        if JY.Wugong[wugongid]["����"] == mp then
            if JY.Person[personid]["����"] == mp then
                power = power + 50 * JY.Wugong[wugongid]["�㼶"]
            else
                power = power + 25 * JY.Wugong[wugongid]["�㼶"]
            end
        end
    end
    return power
end

-- �޾Ʋ������ж��츳�⹦�ĺ���
function Given_WG(personid, WGid)
    local tw = false;
    for i = 1, 2 do
        if JY.Person[personid]["�츳�⹦" .. i] == WGid then
            tw = true;
            break
        end

    end
    return tw;
end

-- �޾Ʋ������ж��츳�ڹ��ĺ���
function Given_NG(personid, NGid)
    local tw = false;
    if JY.Person[personid]["�츳�ڹ�"] == NGid then
        tw = true;
    end
    return tw;
end

-- ����ָ�վ��
function stands()
    JY.MyCurrentPic = 0
    if JY.Person[0]["�Ա�"] == 0 then
        JY.MyPic = CC.MyStartPicM + JY.Base["�˷���"] * 7 + JY.MyCurrentPic;
    else
        JY.MyPic = CC.MyStartPicF + JY.Base["�˷���"] * 7 + JY.MyCurrentPic;
    end
end

-- �޾Ʋ���������ѡ��˵�
function TeleportMenu(menu, color, selectColor)
    local bx, by = CC.ScreenW / 1360, CC.ScreenH / 768
    local x1 -- �˵���ʼX����
    local y1 -- �˵���ʼY����
    local w -- �˵�bx
    local h -- �˵�by
    local maxlength -- ��λ��󳤶�
    local size = CC.Fontsmall -- �����С

    x1 = CC.MainMenuX + bx * 210
    y1 = CC.MainMenuY + CC.Fontsmall * 2 + by * 30

    maxlength = 8
    local cx = size * maxlength / 2 + CC.RowPixel * 3
    local cy = size + CC.RowPixel * 2 - by * 1
    w = cx * 7 + CC.MenuBorderPixel -- 7Ϊlieshu
    h = cy * 15 + CC.MenuBorderPixel -- 16Ϊ�������

    lib.GetKey();
    Cls();
    local pw, ph = lib.GetPNGXY(91, 537 * 2)
    lib.LoadPNG(91, 537 * 2, CC.ScreenW / 2 - pw / 2, CC.ScreenH / 2 - ph / 2, 1, CC.ScreenW / 100 * 100) -- ����ͼ

    -- �����߸�������洢��ͬ���͵ĳ���
    local PType_1 = {};
    local PNum_1 = 0;
    local PType_2 = {};
    local PNum_2 = 0;
    local PType_3 = {};
    local PNum_3 = 0;
    local PType_4 = {};
    local PNum_4 = 0;
    local PType_5 = {};
    local PNum_5 = 0;
    local PType_6 = {};
    local PNum_6 = 0;
    local PType_7 = {};
    local PNum_7 = 0;

    -- v123�ֱ�Ϊ�������ƣ��ɷ���룬�������
    -- v2Ϊ0����ɽ��룬1�����ɽ���
    for i, v in pairs(menu) do
        if v[4] == 1 then
            PNum_1 = PNum_1 + 1
            PType_1[PNum_1] = {v[1], v[2], v[3]}
        elseif v[4] == 2 then
            PNum_2 = PNum_2 + 1
            PType_2[PNum_2] = {v[1], v[2], v[3]}
        elseif v[4] == 3 then
            PNum_3 = PNum_3 + 1
            PType_3[PNum_3] = {v[1], v[2], v[3]}
        elseif v[4] == 4 then
            PNum_4 = PNum_4 + 1
            PType_4[PNum_4] = {v[1], v[2], v[3]}
        elseif v[4] == 5 then
            PNum_5 = PNum_5 + 1
            PType_5[PNum_5] = {v[1], v[2], v[3]}
        elseif v[4] == 6 then
            PNum_6 = PNum_6 + 1
            PType_6[PNum_6] = {v[1], v[2], v[3]}
        elseif v[4] == 7 then
            PNum_7 = PNum_7 + 1
            PType_7[PNum_7] = {v[1], v[2], v[3]}
        end
    end

    -- ������Ϣ
    local P_inf = {
        {PType_1, PNum_1},
        {PType_2, PNum_2},
        {PType_3, PNum_3},
        {PType_4, PNum_4},
        {PType_5, PNum_5},
        {PType_6, PNum_6},
        {PType_7, PNum_7},
        [0] = {0, 0}
    }
    local PType_name = {"��ջ����", "��������", "�������", "�������", "��ɽ��", "ɽ������",
                        "���ೡ��"}

    -- ���ĳ�ʼλ��
    local cursor_x = 1
    local cursor_y = 1
    local tb = 1
    local start = 1

    -- ����ֵ
    local returnValue = -1;

    local surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)

    while true do
        if JY.Restart == 1 then
            break
        end
        lib.LoadSur(surid, 0, 0)
        -- DrawString(x1+10,y1-CC.RowPixel*4-7,"X:"..cursor_x.."��Y:"..cursor_y.."��tb:"..tb,LimeGreen,size);	--���������Ϣ
        local row = 15
        for i = 1, 7 do
            -- ��������
            for j = start, start + row - 1 do
                if j > P_inf[i][2] then
                    break
                end
                -- ȷ����ǰ��λ���
                local id = 0
                for jj = 1, i do
                    id = id + P_inf[jj - 1][2]
                end
                id = id + j
                -- �޷�����ĳ�������Ϊ��ɫ
                local drawColor = C_WHITE1;
                if P_inf[i][1][j][2] == 1 then
                    drawColor = M_DimGray
                end
                local xx = x1 + (i - 1) * (cx) + CC.MenuBorderPixel
                local yy = y1 + (j - start) * (cy)
                lib.Background(xx - bx * 5, yy - by * 5, xx + size * maxlength / 2, yy + size + by * 5, 80, C_BLACK)
                -- ����ǰѡ�еĵ�λ��ɫ
                if id == tb then
                    drawColor = C_RED;
                    -- lib.Background(xx-bx*5, yy-by*5, xx + size*maxlength/2, yy + size + by*5, 128, drawColor)
                    DrawBox(xx - bx * 5, yy - by * 5, xx + size * maxlength / 2, yy + size + by * 5, 128, drawColor)
                end
                -- ��ʾ��������
                local name = P_inf[i][1][j][1]
                DrawString(xx - string.len(name) / 4 * size + bx * 52, yy, P_inf[i][1][j][1], drawColor, size);
            end
        end

        ShowScreen();
        local keyPress, ktype, mx, my = WaitKey(1)

        lib.Delay(CC.Frame);

        -- ktype  1�����̣�2������ƶ���3:��������4������Ҽ���5������м���6�������ϣ�7��������
        if keyPress == VK_ESCAPE or ktype == 4 then
            PlayWavE(77)
            break
        elseif keyPress == VK_DOWN or ktype == 7 then
            -- PlayWavE(77)
            tb = tb + 1;
            if tb > (start + row - 1) then
                -- start=start+1;
            end
            if tb >= 3 then
                start = start + 1;
            end
            if P_inf[cursor_x][2] <= row then
                start = 1
                tb = 1;
            else

            end
            if tb > P_inf[cursor_x][2] then
                start = 1;
                tb = 1;
            end
            cursor_y = cursor_y + 1
            if cursor_y > P_inf[cursor_x][2] then
                cursor_y = 1
            end
        elseif keyPress == VK_UP or ktype == 6 then
            -- PlayWavE(77)
            tb = tb - 1;
            if tb < start then
                start = start - 1;
            end
            if tb < 1 then
                tb = P_inf[cursor_x][2];
                start = tb - row + 1;
            end
            cursor_y = cursor_y - 1
            if cursor_y < 1 then
                cursor_y = P_inf[cursor_x][2]
            end
        elseif keyPress == VK_RIGHT then
            PlayWavE(77)
            cursor_x = cursor_x + 1
            if cursor_x > 7 then
                cursor_x = 1
            end
            if cursor_y > P_inf[cursor_x][2] then
                cursor_y = 1
            end
        elseif keyPress == VK_LEFT then
            PlayWavE(77)
            cursor_x = cursor_x - 1
            if cursor_x < 1 then
                cursor_x = 7
            end
            if cursor_y > P_inf[cursor_x][2] then
                cursor_y = 1
            end
        else
            local mk = false;
            if ktype == 2 or ktype == 3 then
                -- PlayWavE(77)
                if mx >= x1 and mx <= x1 + w and my >= y1 and my <= y1 + h then
                    -- cursor_x =  math.modf((mx - x1 - CC.MenuBorderPixel)/(cx)) + 1
                    -- cursor_y = start+math.modf((my - y1 - CC.MenuBorderPixel) / (cy)) + 1
                    -- mk = true;
                end
                if cursor_y > P_inf[cursor_x][2] then
                    -- cursor_y = P_inf[cursor_x][2]
                    -- mk = false;
                end
            end
            if keyPress == VK_SPACE or keyPress == VK_RETURN or (ktype == 3 and mk) then
                PlayWavE(77)
                if P_inf[cursor_x][1][cursor_y][2] == 0 then
                    returnValue = P_inf[cursor_x][1][cursor_y][3];
                    break
                end
            end
        end
        tb = 0
        for i = 1, cursor_x do
            tb = tb + P_inf[i - 1][2]
        end
        tb = tb + cursor_y
    end
    lib.FreeSur(surid)
    -- ����ֵ
    return returnValue
end

-- ���͵�ַ�б�
function My_ChuangSong_List()
    local menu = {};
    JY.Scene[93]["��������"] = 2
    for i = 0, JY.SceneNum - 1 do
        -- ����ʾ�ĳ�������������1 3 ���̵ص����߲��Թ�+ɳĮ����3�� ������ ˼���� ÷ׯ���� �󹦷��ؽ� ����ɽ�� ¹��ɽ1 3 ���ֺ�ɽ �ʹ� �������� �������� ��ɽ���� ����ȵ� ��Ĺ�ܵ� ��ü�� ȵ�� ��ɽ���
        if (i == 0 or i == 1 or i == 5 or i == 13 or i == 14 or i == 15 or i == 28 or i == 38 or i == 42 or i == 44 or i ==
            46 or i == 49 or i == 55 or i == 57 or i == 58 or i == 61 or i == 67 or i == 69 or i == 70 or
            (i >= 80 and i <= 83) or i == 84 or i == 85 or i == 86 or i == 88 or i == 89 or i == 91 or i == 102 or i ==
            104 or i == 106 or i == 108 or i == 109 or i == 110 or i == 111 or i == 113 or i == 114 or i == 115 or i ==
            116 or i == 117 or i == 118 or i == 119 or i == 122 or i == 123 or i == 126 -- or i== 130
        or i == 131 or i == 132 or i == 134 or i == 137 or i == 138 or i == 140 or i == 141 or i == 142 or i == 143 or i ==
            144 or i == 145 or i == 146 or i == 147 or i == 148 or i == 149 or i == 150 or i == 155) or i == 161 or i ==
            162 or i == 164 or i == 165 and JY.Scene[i]["��������"] ~= 8 then
        else
            -- �޾Ʋ���������i��Ϊ�������
            menu[i + 1] = {JY.Scene[i]["����"], JY.Scene[i]["��������"], i, JY.Scene[i]["��������"]};
        end
    end
    -- ��ɫ����Ϊ������ɫ��ѡ����ɫ
    local r = TeleportMenu(menu, C_GOLD, C_WHITE);

    -- ����ֵС��0��ESC����ֱ�ӷ���
    if r < 0 then
        return 0;
    end
    -- ����ֵ���ڵ���0������ֵ��Ϊ�������
    if r >= 0 then
        local sid = r;
        My_Enter_SubScene(sid, -1, -1, -1);
    end
    return 1;
end

-- �޾Ʋ������ж϶����ǲ�����������λ
function More_than_2_vacant_slot()
    if JY.Base["����14"] == -1 and JY.Base["����15"] == -1 then
        return true
    end
    return false
end

-- �޾Ʋ��������˾���
function awakening(id, value)
    local xwperson; -- �ж�Ҫ���ѵ���
    if id == JY.Base["����"] then
        xwperson = 0
    else
        xwperson = id
    end

    JY.Person[xwperson]["���˾���"] = JY.Person[xwperson]["���˾���"] + value
end

-- �޾Ʋ����������䳣
function kungfu_knowledge(id, value)
    local xwperson; -- �ж�Ҫ�����䳣����
    if id == JY.Base["����"] then
        xwperson = 0
    else
        xwperson = id
    end
    JY.Person[xwperson]["��ѧ��ʶ"] = JY.Person[xwperson]["��ѧ��ʶ"] + value
end

-- �޾Ʋ������ж��Ƿ�Ϊָ��ID����������ж��Ƿ�ﵽָ�����Ѵ���
function match_ID_awakened(personid, id, awkntimes)

    if CC.Copy[personid] ~= nil then
        personid = CC.Copy[personid]
    end

    if personid == id then
        if JY.Person[personid]["���˾���"] >= awkntimes then
            return true
        else
            return false
        end
    elseif personid == 0 and JY.Base["����"] == id then
        if JY.Person[0]["���˾���"] >= awkntimes then
            return true
        else
            return false
        end
    elseif personid == 0 and JY.Base["��ͨ"] == 2 and instruct_16(id) then
        if JY.Person[0]["���˾���"] >= awkntimes then
            return true
        else
            return false
        end
    else
        return false
    end
end

-- ֱ���趨ָ�����������
function set_potential(id, value)
    local xwperson; -- �ж�Ҫָ�����ʵ���
    if id == JY.Base["����"] or (JY.Base["��ͨ"] == 2 and instruct_16(id)) then
        xwperson = 0
    else
        xwperson = id
    end
    JY.Person[xwperson]["����"] = value
end

-- �޾Ʋ������ж��ǲ�����ʾ�ؼ�
function secondary_wugong(wugongid)

    -- �Ϲ�
    -- if JY.Wugong[wugongid]["�书����"] == 8 then
    --	return true
    -- end		
    -- �Ṧ
    if JY.Wugong[wugongid]["�书����"] == 7 then
        return true
        -- ��������ղ������������� ��ɵ� ��������
    elseif wugongid == 85 or wugongid == 87 or wugongid == 88 or wugongid == 144 or wugongid == 175 or wugongid == 182 or
        wugongid == 199 or wugongid == 43 then
        return true
    end
    return false
end

-- �Ϲ�
function WGZHAOSHI(wugongid)
    if wugongid == 26 or wugongid == 25 or wugongid == 21 or wugongid == 45 or wugongid == 46 or wugongid == 48 or
        wugongid == 67 or wugongid == 66 or wugongid == 153 or wugongid == 80 or wugongid == 82 or wugongid == 81 or
        wugongid == 49 or wugongid == 138 or wugongid == 11 then
        return true
    end
    return false
end

-- �޾Ʋ������ж������ڹ��ĺ���
function Curr_NG(personid, NGid)
    if PersonKF(personid, NGid) then
        if JY.Person[personid]["�����ڹ�"] == NGid then
            return true
        end
    end
    -- ����ж�
    if personid == 0 and JY.Person[personid]['��������'] == 3 then
        -- ��������ڣ������Ѿ�ѧ�ᣬ���Զ�����
        if JY.Person[personid]["�츳�ڹ�"] == NGid and PersonKF(personid, NGid) then
            -- Hp_Max(personid)
            return true
        end
    end
    local pmenu = {
                    {9997,175}, --����
                    {22,175},--����
                    {21,175},--����
                    {20,175},--����
                    {23,175},--����
                    {637,107},--���� ����
                    {9929,107},--
                    {27,105},--
                    {9795,90},--
                    {511,227},--
                    {60,95},--
                    {9771,99},--
                    {149,108},--
                    

                    }
    for i = 1,#pmenu do 
        if match_ID(personid, pmenu[i][1]) and NGid == pmenu[i][2] and PersonKF(personid, pmenu[i][2]) then
            return true
        end
    end
    --��������
    -- ��ת����
    if PersonKF(personid, 43) and KF_level(personid, 43) > 10 and JY.Person[personid]['��Ѩ' .. 149] == 1 and NGid ==  43 then
        return true
    end
    -- �Ϲ�1209
    if PersonKF(personid, 177) and NGid == 177 then
        local ts = false
        if (personid == 752 or personid == 652) and (JY.Base["��������"] >= 7 or inteam(personid) == false) and  CC.TX["��������"] == 1 then
            ts = true
        end
        if ts == true then
            return true
        end
    end
    if PersonKF(personid, 104) and PersonKF(personid, 107) and NGid == 104 and JY.Person[personid]["�����ڹ�"] ==  107 then
        return true
    end
    return false
end

-- �޾Ʋ������ж������Ṧ�ĺ���
function Curr_QG(personid, QGid)
    if JY.Person[personid]["�����Ṧ"] == QGid and PersonKF(personid, QGid) then
        return true
    end
    if match_ID(personid, 9963) and QGid == 186 and PersonKF(personid, QGid) then
        return true
    end
    if match_ID(personid, 130) and QGid == 145 and PersonKF(personid, QGid) then
        return true
    end
    if match_ID(personid, 633) and QGid == JY.Person[personid]["�츳�Ṧ"] and PersonKF(personid, QGid) then
        return true
    end
    return false
end

-- �޾Ʋ������ж���������ϼ��ĸ���
function calc_mas_num(id)
    local mas_num = 0;
    for i = 1, JY.Base["�书����"] do
        if JY.Person[id]["�书�ȼ�" .. i] == 999 then
            mas_num = mas_num + 1;
        end
    end
    return mas_num
end

-- �޾Ʋ������ж��Ƿ�Ϊָ��ID����������츳���ж�
function match_ID(personid, id)

    for i = 1, 5 do
        if JY.Person[personid]['�츳' .. i] == id then
            return true
        end
    end
    if personid == 0 and JY.Base["����"] > 0 then
        personid = JY.Base["����"]
    end

    if (personid == 0 or personid == JY.Base["����"]) and JY.Base["��ͨ"] == 2 and instruct_16(id) then
        return true
    end

    if CC.Copy[personid] ~= nil then
        personid = CC.Copy[personid]
    end

    return false
end

-- �޾Ʋ���������������ѧ�ڹ�������
function NGnum(id)
    local num = 0
    for i = 1, JY.Base["�书����"] do
        local kfid = JY.Person[id]["�书" .. i]
        if JY.Wugong[kfid]["�书����"] == 6 then
            num = num + 1
        end
    end
    return num
end

function JFnum(id)
    local num = 0
    for i = 1, JY.Base["�书����"] do
        local kfid = JY.Person[id]["�书" .. i]
        if JY.Wugong[kfid]["�书����"] == 3 then
            num = num + 1
        end
    end
    return num
end

function DFnum(id)
    local num = 0
    for i = 1, JY.Base["�书����"] do
        local kfid = JY.Person[id]["�书" .. i]
        if JY.Wugong[kfid]["�书����"] == 4 then
            num = num + 1
        end
    end
    return num
end

function QZnum(id)
    local num = 0
    for i = 1, JY.Base["�书����"] do
        local kfid = JY.Person[id]["�书" .. i]
        if JY.Wugong[kfid]["�书����"] == 1 then
            num = num + 1
        end
    end
    return num
end

function ZFnum(id)
    local num = 0
    for i = 1, JY.Base["�书����"] do
        local kfid = JY.Person[id]["�书" .. i]
        if JY.Wugong[kfid]["�书����"] == 2 then
            num = num + 1
        end
    end
    return num
end

function QMnum(id)
    local num = 0
    for i = 1, JY.Base["�书����"] do
        local kfid = JY.Person[id]["�书" .. i]
        if JY.Wugong[kfid]["�书����"] == 5 then
            num = num + 1
        end
    end
    return num
end

function QGnum(id)
    local num = 0
    for i = 1, JY.Base["�书����"] do
        local kfid = JY.Person[id]["�书" .. i]
        if JY.Wugong[kfid]["�书����"] == 7 then
            num = num + 1
        end
    end
    return num
end

-- �޾Ʋ������ж�һ�������Ƿ�������������������

function WuyueJFSL(id)
    local num = 0
    local menu = {30, 31, 32, 33, 34}
    for i = 1, #menu do
        if PersonKF(id, menu[i]) then
            num = num + 1
        end
    end
    if (match_ID(id, 19) or match_ID(id, 20) or match_ID(id, 21) or match_ID(id, 22) or match_ID(id, 23)) and
        JY.Person[0]["�������"] > 0 then
        num = 5
    end
    if num > 4 then
        num = 7
    end
    return num
end

-- ����
function Person_JQ(id)  
	local JQ = 0
	local jqz = 0
	local jqz1 = 0
	local function getnewmove(x)
		if x <= 0 then 
			return 0
		end
		return math.sqrt(x)
	end
	--�Ϲ� ����
	local function getnewmove1(a, b)
		local x = (a * 2 + b) / 3
		if x > 7600 then
			return 4 + math.min((x - 5600) / 600, 3)
		elseif x > 3600 then
			return 3 + (x - 3600) / 600
		elseif x > 2000 then
			return 2 + (x - 2000) / 600
		elseif x > 800 then
			return 1 + (x - 800) / 600
		else
			return x / 400
		end
	end
	
	--�޾Ʋ��������˼������Ѷȱ仯
	local function NPCjiqimod(nd)
		local x;
		if nd == 1 then
			return 0.8
		elseif nd == 2 then
			return 1.6
		elseif nd == 3 then
			return 1.8
		elseif nd == 4 then
			return 2.0
		end
	end
	local  qg = JY.Person[id]['�Ṧ'] + FJQINGG(id)
	jqz = getnewmove(qg)
	--���˿����������ٶ�+20%
	--����;���
	if Curr_NG(id,105) or (match_ID_awakened(id, 189, 1) and Curr_NG(id, 105)) then
		jqz = math.modf(jqz * 1.2)
	end
	--���˷��죬����+10 ����޸�
	if Curr_QG(id,145) then
		jqz = jqz + 10
	end
	
	--�����츳�Ṧ
	if JY.Person[id]["�����Ṧ"] > 0 and JY.Person[id]["�����Ṧ"] == JY.Person[id]["�츳�Ṧ"] then
		jqz = jqz + 1
	end
	
	--��쳣��Ƿ壬����+8
	if match_ID(id, 1) or match_ID(id, 9755) or match_ID(id, 539) then
		jqz = jqz + 8
	end
	
	--�������𣬼���+6
	if match_ID(id, 9763) then
		jqz = jqz + 6
	end

	--�����ˣ�ÿ�ж�һ�Σ������ٶȼ�һ
	if id==0 and JY.Base["����"]==52 then
		jqz = jqz+WAR.HTG
	end	
	--�����۽���Ӯ��������+8
	if id == 0 and CC.TX["�������ܽ���"] == 1 then
		jqz = jqz + 8
	end
	local zqjq_jc = 0
	if JY.Person[id]["����"] > 0 then
		local fb = 1
		if match_ID(id,131) then 
			fb = 2
		end
		--װ������ 1����2������
		if JY.Person[id]["����"] == 230 then
			local zqjq_jc = 2*fb
			if JY.Thing[230]["װ���ȼ�"] >= 5 then
				zqjq_jc = 4*fb
			elseif JY.Thing[230]["װ���ȼ�"] >= 3 then
				zqjq_jc = 3*fb
			end
			--�������Ч������
			if match_ID(id, 590) then
				if match_ID(id,131) then 
					fb = 2
				end
				zqjq_jc = zqjq_jc * fb
			end
		end
		--װ��ë¿ �����ٶ�+10��
		if JY.Person[id]["����"] == 279 then
			--jqz = jqz + 10;
			zqjq_jc = 10* fb
		end
		--װ������ �����ٶ�+10��
		if JY.Person[id]["����"] == 264 then
			--jqz = jqz + 12;
			zqjq_jc = 12* fb
		end			
		--װ����¿ �����ٶ�+5��
		if JY.Person[id]["����"] == 339 then
			--jqz = jqz + 5;
			zqjq_jc = 5* fb
		end
		--װ����Ѫ���� �����ٶ�+5��
		if JY.Person[id]["����"] == 262 then
			--jqz = jqz + 8;
			zqjq_jc = 8* fb
		end			
		--�ݻ���Ѫ��Խ�ͼ���Խ�죬50%Ѫ+5��0Ѫ+10
		if JY.Person[id]["����"] == 284 and JY.Thing[284]["װ���ȼ�"] == 6 and JY.Person[id]["����"] < JY.Person[id]["�������ֵ"]/2 then
			local spd_add = 5;
			spd_add = spd_add + math.floor(JY.Person[id]["�������ֵ"]/2 - JY.Person[id]["����"]/100)
			--jqz = jqz + spd_add;
			zqjq_jc = spd_add* fb
		end	
		jqz = jqz  + zqjq_jc
		--����
		if match_ID(id, 546) or match_ID(id, 9911) then
			jqz = jqz  + zqjq_jc
		end
	end

	
	
	--����֥����ÿ���⹦+1����
	if  match_ID(id, 9798) then
		local zzr = 0
		for i = 1, JY.Base["�书����"] do
			if JY.Wugong[JY.Person[id]["�书" .. i]]["�书����"] < 6 then
				zzr = zzr + 1
			end
		end
		jqz = jqz + zzr
	end	

						
	--����ÿ������������+2����
	if JY.Base["��׼"] == 3 and id == 0 then
		local jsyx = 0
		for i = 1, JY.Base["�书����"] do
			if JY.Wugong[JY.Person[id]["�书" .. i]]["�书����"] == 3 and JY.Person[id]["�书�ȼ�" .. i] == 999 then
				jsyx = jsyx + 1
			end
		end
		if jsyx > 7 then
			jsyx = 7
		end
		jqz = jqz + jsyx*2
	end

	--�����㣬ÿ�����ŵ�����+2����
	if match_ID(id, 590) then
		local lwx = 0
		for i = 1, JY.Base["�书����"] do
			if JY.Wugong[JY.Person[id]["�书" .. i]]["�书����"] == 5 and JY.Person[id]["�书�ȼ�" .. i] == 999 then
				lwx = lwx + 1
			end
		end
		if lwx > 7 then
			lwx = 7
		end
		jqz = jqz + lwx*2
	end
	--��ѩ�켯��-3
	if  CC.Weather[2][1] > 0 then 
		if Curr_QG(id,394) then 
			jqz = jqz + 3
		else
			jqz = jqz - 3
		end
	end
	--���Ӫ
	if match_ID(id,733) or match_ID(id,735)  or match_ID(id,734)   or match_ID(id,736)  then 
		jqz = math.modf(jqz*0.7)  
	end 
	if id==0 and (JY.Base["����"]==68 or JY.Base["����"]==123) then
		jqz = jqz + 1
	end


	local dgqb = {}			--��¼������ܵ�����
	local max_jq = 0		--��¼ȫ����߼���	
	if JY.Status == GAME_WMAP then
		for j = 0, WAR.PersonNum - 1 do
			for i = 0, WAR.PersonNum - 1 do
				if not WAR.Person[i]["����"] then
					id = WAR.Person[i]["������"]			
					WAR.Person[i].TimeAdd = (getnewmove1(JY.Person[id]["����"], JY.Person[id]["�������ֵ"]) + JY.Person[id]["����"] / 30)
					
					WAR.Person[i].TimeAdd = math.modf(WAR.Person[i].TimeAdd)								
					--5�㼯������ JY.Person[id]["����"] == 61
					if WAR.Person[i].TimeAdd < 5 then
						WAR.Person[i].TimeAdd = 5
					end
					--����
					if WAR.ZDDH == 344 and isteam(id) == false then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + 10
					end	
					--��������ɳ����Ѫ��Խ�ͼ���Խ�죬100%Ѫ�޼ӳɣ�0Ѫ100%�ӳ�
					if match_ID(id, 9757) and WAR.PD["��ҩ״̬"][id]~=nil then
						local bonus_perctge = 0
						bonus_perctge = 2 - JY.Person[id]["����"] / JY.Person[id]["�������ֵ"]
						WAR.Person[i].TimeAdd = math.modf(WAR.Person[i].TimeAdd * bonus_perctge)
					end
					--����ȫ������-5
					for j = 0, WAR.PersonNum - 1 do
						if match_ID(WAR.Person[j]["������"], 582) and WAR.Person[j]["����"] == false and WAR.Person[j]["�ҷ�"] ~= WAR.Person[i]["�ҷ�"] then
							WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd - 5
							break	
						end
					end	
					--���ӹ���			
					if match_ID(WAR.Person[j]["������"], 9800) and WAR.Person[j]["����"] == false and WAR.Person[j]["�ҷ�"] ~= WAR.Person[i]["�ҷ�"] then
						jqz = math.modf(jqz*0.5 )
						break	
					end				
					--л�̿�ȫ������-10
					if match_ID(WAR.Person[j]["������"], 164) and WAR.Person[j]["����"] == false and WAR.Person[j]["�ҷ�"] ~= WAR.Person[i]["�ҷ�"] then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd - 10
						break	
					end
					--������ ������
					
					local bsbs = 0
					if match_ID(WAR.Person[j]["������"], 162) and WAR.Person[j]["����"] == false and WAR.Person[j]["�ҷ�"] ~= WAR.Person[i]["�ҷ�"] then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd - 3
						bsbs = bsbs + 1	
					end
					if match_ID(WAR.Person[j]["������"], 163) and WAR.Person[j]["����"] == false and WAR.Person[j]["�ҷ�"] ~= WAR.Person[i]["�ҷ�"] then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd - 4
						bsbs = bsbs + 1
					end
					if bsbs > 1 then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd - 7		
					end

					if WAR.PD['�˾Ʊ�'][id] ~= nil then 
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + WAR.PD['�˾Ʊ�'][id]*4
					end
					
					--ΤһЦ����������ҩʦ
					if match_ID(id, 14) or match_ID(id, 18) or match_ID(id, 57)  then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + 10
					end
					--һ�ƣ���������⼯���ٶ�+5
					if match_ID(id, 65) and WAR.PD["����"][id] ~= nil then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + 5
					end
		
					--����������������⼯���ٶ�+5
					if match_ID(id, 9787) and WAR.PD["����"][id] ~= nil then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + 5
					end
		
					if WAR.PD["��ʽ����������1"][id] ~= nil  then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd * 1.1
					end
					if WAR.PD["��ʽ����������2"][id] ~= nil  then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd * 1.2
					end
					if WAR.PD["��ʽ����������3"][id] ~= nil  then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd * 1.3
					end
					if WAR.PD["��ʽ����������4"][id] ~= nil  then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd * 1.4
					end
					--������� ��Խ�ټ���Խ��
					if match_ID(id, 9962)  then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + 20
						if WAR.Person[j]["����"] == false and WAR.Person[j]["�ҷ�"] == WAR.Person[i]["�ҷ�"] then
							WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd - 4
						end
					end
				
					--����ֹ���ҷ�ÿ����һ���ˣ������ٶ�+2
					if match_ID(id, 616) then
						if WAR.Person[j]["����"] == true and WAR.Person[j]["�ҷ�"] == WAR.Person[i]["�ҷ�"] then
							WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + 2
						end
					end
					
					--˾��ժ�ǣ��з���Խ�༯���ٶ�Խ��
					if match_ID(id, 579) then
						if WAR.Person[j]["����"] == false and WAR.Person[j]["�ҷ�"] ~= WAR.Person[i]["�ҷ�"] then
							WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + 5
						end
					end	
		
					--ʥ����ʹ��ͬʱ�ڳ�ʱ��ÿ�˼����ٶȶ���+20��
					if WAR.ZDDH == 14 and (id == 173 or id == 174 or id == 175) then
						local shz = 0
						if WAR.Person[j]["����"] == false and WAR.Person[j]["�ҷ�"] == WAR.Person[i]["�ҷ�"] then
							shz = shz + 1
						end
						
						if shz == 3 then
							WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + 20
						end
					end
				
					--�����壺������󣬼���+7
					if (id == 68 or id == 123 or id == 124 or id == 125 or id == 126 or id == 127 or id == 128) and WAR.Person[i]["�ҷ�"] == false then
						local s = 0
						if WAR.Person[j]["����"] == false and (WAR.Person[j]["������"] == 68 or WAR.Person[j]["������"] == 123 or WAR.Person[j]["������"] == 124 or WAR.Person[j]["������"] ==125 or WAR.Person[j]["������"] == 126 or WAR.Person[j]["������"] == 127 or WAR.Person[j]["������"] == 128) then
							s = s + 1
						end
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + s
					end			
					
					--�����壺�����߽��󣬼���+7
					if (id == 532 or id == 533 or id == 534 or id == 535 or id == 536 or id == 537 or id == 538) and WAR.Person[i]["�ҷ�"] == false then
						local s = 0
						if WAR.Person[j]["����"] == false and (WAR.Person[j]["������"] == 538 or WAR.Person[j]["������"] == 533 or WAR.Person[j]["������"] == 534 or WAR.Person[j]["������"] ==535 or WAR.Person[j]["������"] == 536 or WAR.Person[j]["������"] == 537 or WAR.Person[j]["������"] == 538) then
							s = s + 1
						end
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + s
					end
					
					--ɽ�����ø�����+2����
					if id == 0 then
						if WAR.Person[j]["������"] == 9981 and WAR.Person[j]["����"] == false and WAR.Person[j]["�ҷ�"] == WAR.Person[i]["�ҷ�"] then
							WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + 2
							break
						end
					end
					
					if WAR.PD['������'][id] ~= nil then 
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + WAR.PD['������'][id]
					end
					
					--����̫���񹦣�̫��֮�����Ӽ���
					if Curr_NG(id, 171) and WAR.PD["̫��֮��"][id] ~= nil then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + WAR.PD["̫��֮��"][id]
					end
					--˾��ժ�ǰ������Ӽ���
					if match_ID(id, 9740) and id == 0 and  WAR.SKZX[id] ~= nil then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + WAR.SKZX[id]
					end			
					if Curr_NG(id, 227) and WAR.Actup[id] ~= nil and WAR.Actup[id] > 0 then
						WAR.Person[i].TimeAdd = math.modf(WAR.Person[i].TimeAdd * 1.3)
					end
					--ƽһָ�������ٶȶ���ӳ�5*ɱ����
					if match_ID(id, 28) or match_ID(id, 9889) then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + WAR.PYZ * 5
					end
					
					jqz1 = WAR.Person[i].TimeAdd
				end
			end
		end
	end
	jqz = jqz + jqz1
	if inteam(id) == false then 
		local ND = JY.Base["�Ѷ�"]
		jqz = jqz*NPCjiqimod(ND)
	end
	--�����ӳɱ���
	local jqbs = 1
	--��������80��
	if jqz > 70 then
		if not match_ID(id,9740) then
			jqz = 70
		end
	end            
	if match_ID(id,9740) and jqz > 99 then
		jqz = 99
	end		

	--��������10��
	if jqz < 10 and id ~= 591  then
		jqz = 10
	end	  
	--ľ׮������
	if id == 591 and WAR.ZDDH == 226 then
		jqz = 0
	end					
	--����ˮ�������������
	if id == 600  then
		jqz = 0
	end

	jqz = math.modf(jqz)	
	--JQ = numberToString(jqz) --ת������
	JQ = jqz
	return JQ
end

-- �ƶ�����
function Person_YD(pid)
    --lib.Debug('Person_YD(pid)')
    local Value = 0
    local kf = JY.Person[pid]['�����Ṧ']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)
    local function getnewmove2(x, y)
        local mob = x + y
        if mob > 666 then
            return 6
        elseif mob > 398 then
            return 5
        elseif mob > 298 then
            return 4
        elseif mob > 168 then
            return 3
        else
            return 2
        end
    end
    local qg = JY.Person[pid]['�Ṧ'] + FJQINGG(pid)
    -- Value = (getnewmove2(qg, JY.Person[pid]["����"]) - JY.Person[pid]["�ж��̶�"]/50 - JY.Person[pid]["���˳̶�"]/50)
    Value = (getnewmove2(qg, 0))
    if pid == 5 and Value < 8 then
        Value = 8
    end
    -- ��Ѱ��ѧ����������ˮ���ƶ�+2
    if pid == 498 and Value < 8 then
        Value = 8
    end
    if kf > 0 then
        if dkfcj_ng >= 3 then
            Value = Value + 2
        else
            Value = Value + 1
        end
    end
    -- ̤ѩ�޺ۣ��ƶ�����10��
    if pid == 511 then
        Value = Value + 2
    end
    -- ����ˮ��Ʈ���ƶ�+5
    if pid == 67 then
        Value = Value + 5
    end
    if pid == 9962 then
        Value = Value + 2
    end
    if pid == 633 then
        Value = Value + 2
    end
    -- �¶���ܣ��ƶ�����10��
    if pid == 592 then
        Value = 10
    end
	Value = math.ceil(Value - JY.Person[pid]["����̶�"] / 25)
    if Value > 10 then
        Value = 10
    end

    if Value < 0 then
        Value = 0
    end
    return Value
end

-- ����
function Person_MZ(pid)
    local Value = 0
    local p = JY.Person[pid]
    local kf = JY.Person[pid]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)
    local MZ1 = p["����"]
    local MZ2 = p["�Ṧ"] * 0.5
    local MZ3, MZ4, MZ5 = 0, 0, 0
    MZ3 = JY.Wugong[p["����ʹ��"]]["������"]
    MZ4 = JY.Wugong[p["�����Ṧ"]]["������"]
    MZ5 = p["������"] * 0.1
    Value = MZ1 + MZ2 + MZ3 + MZ4 + MZ5
    if match_ID(pid, 115) then
        Value = Value * 1.2
    end
    -- ÷��
    if JY.Person[pid]['��Ѩ' .. 99] == 1 then
        Value = Value + p["����"] * 0.2
    end
    -- ԽŮ��
    if match_ID(pid, 136) and JY.Wugong[p["����ʹ��"]]["�书����"] == 3 then
        Value = Value + 100
    end
    if JY.Person[pid]['��Ѩ' .. 95] == 1 then
        Value = Value + Value * 0.2
    end
    -- ������Ч720
    if NeiGong_tx(pid, 720) then
        Value = Value + dkfcj_ng * 5 * level
    end
    -- ������Ч721
    if NeiGong_tx(pid, 721) then
        Value = Value + dkfcj_ng * 3 * level
    end
    -- ������Ч724
    if NeiGong_tx(pid, 724) then
        Value = Value + Value * (dkfcj_ng * 8 * level / 1000)
    end
    -- ������Ч725
    if NeiGong_tx(pid, 725) then
        Value = Value + Value * (dkfcj_ng * 5 * level / 1000)
    end
    Value = math.modf(Value)
    return Value
end

-- ����
function Person_SB(pid)
    local p = JY.Person[pid]
    local kf = JY.Person[pid]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)
    local Value = 0
    local SB2 = p["�Ṧ"] * 0.5
    local SB1 = 0
    local SB3 = 0
    SB1 = JY.Wugong[p["�����Ṧ"]]["������"]
    SB3 = p["������"] * 0.1
    Value = Value + SB2 + SB1
    if JY.Person[pid]['��Ѩ' .. 95] == 1 then
        Value = Value + Value * 0.2
    end
    -- ÷��
    if JY.Person[pid]['��Ѩ' .. 99] == 1 then
        Value = Value + Value * 0.2
    end
    -- ������Ч718
    if NeiGong_tx(pid, 718) then
        Value = Value + dkfcj_ng * 5 * level
    end
    -- ������Ч721
    if NeiGong_tx(pid, 721) then
        Value = Value + dkfcj_ng * 3 * level
    end
    -- ������Ч722
    if NeiGong_tx(pid, 722) then
        Value = Value + Value * (dkfcj_ng * 8 * level / 1000)
    end
    -- ������Ч725
    if NeiGong_tx(pid, 725) then
        Value = Value + Value * (dkfcj_ng * 5 * level / 1000)
    end
    Value = math.modf(Value)

    if Value < 0 then
        Value = 0
    end
    return Value
end

-- ��
function Person_GD(pid)
    local Value = 0
    local kf = JY.Person[pid]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)
    local GD1, GD2, GD3, GD4 = 0, 0, 0, 0
    local level = 0
    GD1 = GD1 + JY.Person[pid]["��"]
    GD2 = GD2 + JY.Person[pid]["������"] * 0.5
    for i = 1, JY.Base["�书����"] do
        level = math.modf(JY.Person[pid]["�书�ȼ�" .. i] / 100) + 1
        if level > 10 then
            level = 10
        end
        if JY.Person[pid]["�书" .. i] == JY.Person[pid]["�����ڹ�"] then
            GD3 = JY.Wugong[JY.Person[pid]["�����ڹ�"]]["�㼶"] * level
        end
        if JY.Person[pid]["�书" .. i] == JY.Person[pid]["����ʹ��"] then
            GD4 = JY.Wugong[JY.Person[pid]["����ʹ��"]]["�㼶"] * level
        end
    end
    Value = GD1 + GD2 + GD3 + GD4
    -- ������Ч719
    if NeiGong_tx(pid, 719) then
        Value = Value + dkfcj_ng * 5 * level
    end
    -- ������Ч721
    if NeiGong_tx(pid, 721) then
        Value = Value + dkfcj_ng * 3 * level
    end
    -- ʷ����
    if match_ID(pid, 459) then
        if JY.Person[pid]['����ʹ��'] == 26 then
            Value = Value + 200
        end
    end
    -- ������Ч724
    if NeiGong_tx(pid, 724) then
        Value = Value + Value * (dkfcj_ng * 8 * level / 1000)
    end
    -- ������Ч725
    if NeiGong_tx(pid, 725) then
        Value = Value + Value * (dkfcj_ng * 5 * level / 1000)
    end
    Value = math.modf(Value)
    return Value
end

-- ��������
function FJPerson_MZ(pid)
    local Value = 0
    local p = JY.Person[pid]
    local kf = JY.Person[pid]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)
    -- ս��������
    if JY.Status == GAME_WMAP then
        -- ������
        if CC.Weather[3][1] > 0 then
            Value = Value - Person_MZ(pid) * 0.1
        end
        for wid = 0, WAR.PersonNum - 1 do
            -------------------------------
            ---------ս���⻷����-----------		
            -- ���ѷ����ӳ�
            for i = 0, WAR.PersonNum - 1 do
                if WAR.Person[wid]['�ҷ�'] ~= WAR.Person[i]['�ҷ�'] and
                    match_ID(pid, WAR.Person[wid]['������']) then
                    -- ������
                    if ZDGH(wid, 9898) then
                        Value = Value + 400
                    end
                    -- ���޳�
                    if ZDGH(wid, 156) then
                        Value = Value + 100
                    end
                    -- Į������	
                    if ZDGH(wid, 627) then
                        Value = Value + Person_MZ(WAR.Person[wid]['������']) * 0.1
                    end
                    -- ���
                    if ZDGH(wid, 154) then
                        Value = Value + 200
                    end
                end
            end

            -------------------------------
            ---------ս���⻷����-----------
            for i = 0, WAR.PersonNum - 1 do
                if WAR.Person[i]['�ҷ�'] ~= WAR.Person[wid]['�ҷ�'] and match_ID(pid, WAR.Person[i]['������']) then
                    -- if  match_ID(WAR.Person[wid]['������'],155)  then
                    if match_ID(WAR.Person[wid]['������'], 155) then
                        Value = Value - 100
                    end
                    if match_ID(WAR.Person[wid]['������'], 569) then
                        Value = Value - 200
                    end
                    if match_ID(WAR.Person[wid]['������'], 9800) then
                        Value = Value - Person_MZ(WAR.Person[i]["������"]) * 0.2
                    end
                end
            end
        end
    end
    -- �����Ṧ+200 ��ѧ+300
    if JY.Person[pid]['����'] == JY.Wugong[p["�����Ṧ"]]['����'] and p["�����Ṧ"] > 0 then
        Value = Value + 200
        if JY.Wugong[p["�����Ṧ"]]['�㼶'] == 4 then
            Value = Value + 100
        end
    end
    -- ������λ
    if match_ID(pid, 9942) then
        Value = Value + 500
    end
    -- ��������
    if match_ID(pid, 184) then
        Value = Value + Person_MZ(pid) * 0.2
    end
    -- ʷ����
    if match_ID(pid, 459) then
        if JY.Person[pid]['����ʹ��'] == 26 then
            Value = Value + 200
        end
    end
    -- ��ͨ�ټ�
    if match_ID(pid, 9987) then
        Value = Value + 200
    end
    -- ��������
    if match_ID(pid, 460) then
        if JY.Person[pid]['����ʹ��'] == 59 then
            Value = Value + 100
        end
    end
    Value = math.modf(Value)
    return Value
end

-- ��������
function FJPerson_SB(pid)
    local Value = 0
    local kf = JY.Person[pid]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)
    -- ս��
    if JY.Status == GAME_WMAP then
        -- ����
        if CC.Weather[4][1] > 0 then
            Value = Value - Person_SB(pid) * 0.1
        end
    end
    -- ������
    if match_ID(pid, 724) then
        Value = Value + 50
    end
    -- ��������
    if match_ID(pid, 184) then
        Value = Value + Person_SB(pid) * 0.2
    end
    -- ��������
    if match_ID(pid, 566) then
        Value = Value + 300
    end
    -- ��ͨ�ټ�
    if match_ID(pid, 9987) then
        Value = Value + 200
    end
    Value = math.modf(Value)
    return Value
end

-- ���Ӹ�
function FJPerson_GD(pid)
    local Value = 0
    local kf = JY.Person[pid]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)

    -- ��ͨ�ټ�
    if match_ID(pid, 9987) then
        Value = Value + 200
    end
    if JY.Status == GAME_WMAP then
        for wid = 0, WAR.PersonNum - 1 do
            -------------------------------
            ---------ս���⻷����-----------		
            -- ���ѷ����ӳ�
            if WAR.Person[wid]['�ҷ�'] == true and match_ID(pid, WAR.Person[wid]['������']) then
                -- ������
                if ZDGH(wid, 9898) then
                    Value = Value + 400
                end
                -- ���޳�
                if ZDGH(wid, 156) then
                    Value = Value + 200
                end
            end

            -------------------------------
            ---------ս���⻷����-----------
            for i = 0, WAR.PersonNum - 1 do
                if WAR.Person[i]['�ҷ�'] ~= WAR.Person[wid]['�ҷ�'] and match_ID(pid, WAR.Person[i]['������']) then
                    -- if  match_ID(WAR.Person[wid]['������'],155)  then
                    if match_ID(WAR.Person[wid]['������'], 155) then
                        Value = Value - 100
                    end
                end
            end
        end
    end

    Value = math.modf(Value)
    return Value
end

-- �޾Ʋ������ж�������
function Person_LJ(pid)
    -- �����������ʼ������������
    local LJ1 = math.modf(JY.Person[pid]["�Ṧ"] / 18)
    local LJ2 = math.modf((JY.Person[pid]["�������ֵ"] + JY.Person[pid]["����"]) / 1000)
    local LJ3 = math.modf(JY.Person[pid]["����"] / 10)
    local Value = 0
    local kf = JY.Person[pid]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)
    Value = (LJ1 + LJ2 + LJ3) / 2
    -- ������Ч705
    if NeiGong_tx(pid, 705) then
        Value = Value + (100 - Value) * dkfcj_ng * 10 * level / 1000
    end
    -- �������ǧ�𡢺����������������͡��ݳ�������������֮��������+70%
    if match_ID(pid, 9813) or match_ID(pid, 67) or match_ID(pid, 71) or match_ID(pid, 18) or match_ID(pid, 594) or
        match_ID_awakened(pid, 35, 2) then
        Value = Value + (100 - Value) * 0.7
    end
    -- �������100%Ѫ�޼ӳɣ�0Ѫ100%�ӳ�
    if match_ID(pid, 9792) then
        local HZDLJ = 0
        HZDLJ = (1 - JY.Person[pid]["����"] / JY.Person[pid]["�������ֵ"]) * 100
        Value = Value + HZDLJ
    end
    if match_ID(pid, 152) and JY.Person[pid]["����"] < JY.Person[pid]["�������ֵ"] / 4 then
        Value = Value * 3
    elseif match_ID(pid, 152) and JY.Person[pid]["����"] < JY.Person[pid]["�������ֵ"] / 2 then
        Value = Value * 2
    end
    -- ���������+50% ���羪��
    if match_ID(pid, 189) then
        Value = Value + (100 - Value) * 0.5
    end
    -- �����޷�
    if Pmiji(pid, 35) then
        Value = Value + (100 - Value) * 0.3
    end
    -- �����书��ÿ������+2.5%
    -- �ٻ�����������Ů��̩ɽ��ԧ�죬�����ǣ����ǹ�����ţ����������ǣ�ȥ���գ��ڷ�, ����
    local ljup = {10, 15, 42, 31, 54, 60, 68, 76, 79, 114, 124, 131, 139}
    for i = 1, JY.Base["�书����"] do
        if JY.Person[pid]["�书" .. i] > 0 then
            for ii = 1, #ljup do
                if JY.Person[pid]["�书" .. i] == ljup[ii] then
                    Value = Value + (100 - Value) * 0.025
                end
            end
        else
            break
        end
    end
    -- ���¾Ž�����+5%   
    if PersonKF(pid, 47) then
        Value = Value + (100 - Value) * 0.05
    end

    -- �۽���Ӯ�ֳ�Ӣ����+50%
    if pid == 0 and CC.TX["�ֳ�Ӣ����"] == 1 then
        Value = Value + (100 - Value) * 0.5
    end

    -- ʵս��ÿ40��+1%
    local jp = JY.Person[pid]["ʵս"] / 4000
    Value = Value + (100 - Value) * jp

    -- ���˾���+50% 
    if Curr_NG(pid, 107) and (JY.Person[pid]["��������"] == 0 or JY.Person[pid]["��������"] == 3) then
        Value = Value + (100 - Value) * 0.5
    end
    -- ˫���ϱ� ������+30%
    if ShuangJianHB(pid) == true then
        Value = Value + (100 - Value) * 0.3
    end
    -- ���ǽ� ������+10%
    if JY.Person[pid]["����"] == 38 then
        Value = Value + (100 - Value) * (JY.Thing[38]["װ���ȼ�"] / 10 - 0.1)
    end

    -- ������ ��Ůʮ�Ž�������+30%
    if match_ID(pid, 649) and WAR.YLSJJ == 1 and JY.Status == GAME_WMAP then
        Value = Value + (100 - Value) * 0.3
    end

    -- ������ڳ���ȫ���10%
    if JY.Status == GAME_WMAP then
        for wid = 0, WAR.PersonNum - 1 do
            if match_ID(WAR.Person[wid]["������"], 607) and WAR.Person[wid]["����"] == false and
                WAR.Person[wid]["�ҷ�"] then
                Value = Value + (100 - Value) * 0.1
                break
            end
        end
    end

    -- �������ܡ�������
    if match_ID(pid, 27) then
        Value = 100
    end
    -- ���°˷�
    for i = 1, JY.Base["�书����"] do
        if JY.Person[pid]["�书" .. i] == 181 then
            local dfjc = 0
            for i = 1, JY.Base['�书����'] do
                if JY.Wugong[JY.Person[pid]['�书' .. i]]['�书����'] == 4 and JY.Person[pid]["�书�ȼ�" .. i] ==
                    999 then
                    dfjc = dfjc + 1
                end
                if dfjc >= 8 then
                    Value = Value + (100 - Value) * dfjc * 0.01
                    break
                end
            end
        end
    end

    if match_ID(pid, 9965) then
        Value = Value * 0.2
        if JY.Status == GAME_WMAP then
            if WAR.LQZ[pid] == 100 then
                Value = 100
            end
        end
    end

    -- ����������1
    if Value < 1 then
        Value = 1
    end

    -- ȡ��
    Value = math.modf(Value)

    return Value
end

-- �޾Ʋ������ж�������
function Person_BJ(pid)
    local kf = JY.Person[pid]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)
    -- �����ڹ������������������
    local BJ1 = math.modf(JY.Person[pid]["������"] / 18)
    local BJ2 = math.modf((JY.Person[pid]["�������ֵ"] + JY.Person[pid]["����"]) / 1000)
    local BJ3 = math.modf(JY.Person[pid]["����"] / 10)
    local Value = 0
    Value = (BJ1 + BJ2 + BJ3) / 2
    -- ������Ч706
    if NeiGong_tx(pid, 706) then
        Value = Value + (100 - Value) * dkfcj_ng * 10 * level / 1000
    end

    -- Ѫ�����桢��ǧ�𡢺�����������С������ӡ���������+70%�����
    if match_ID(pid, 97) or match_ID(pid, 67) or match_ID(pid, 71) or match_ID(pid, 26) or match_ID(pid, 184) or
        match_ID(pid, 9813) then
        Value = Value + (100 - Value) * 0.7
    end

    -- ���°˷�������+5%   
    if PersonKF(pid, 181) then
        local dfjc = 0
        for i = 1, JY.Base["�书����"] do
            if JY.Wugong[JY.Person[pid]['�书' .. i]]['�书����'] == 4 and JY.Person[pid]['�书�ȼ�' .. i] ==
                999 then
                dfjc = dfjc + 1
            end
        end
        if dfjc >= 8 then
            Value = Value + (100 - Value) * dfjc * 0.01
        end
    end
    -- �۽���Ӯ�ֳ�Ӣ����+50%
    if pid == 0 and CC.TX["�ֳ�Ӣ����"] == 1 then
        Value = Value + (100 - Value) * 0.5
    end
    -- Ԭ��־������� ������+50%
    if match_ID(pid, 54) or match_ID(pid, 189) then
        Value = Value + (100 - Value) * 0.5
    end
    -- ����ħ�������
    if ShiZunXM(pid) == true then
        Value = Value + (100 - Value) * 0.5
    end
    -- ½��˫ ������+30%
    if match_ID(pid, 580) then
        Value = Value + (100 - Value) * 0.3
    end
    -- �������100%Ѫ�޼ӳɣ�0Ѫ100%�ӳ�
    if match_ID(pid, 586) or match_ID(pid, 9792) then
        local HZDBJ = 0
        HZDBJ = (1 - JY.Person[pid]["����"] / JY.Person[pid]["�������ֵ"]) * 100
        Value = Value + HZDBJ
    end
    -- �����Ѫ�������ķ�֮һʱ������������3��
    if (match_ID(pid, 58) or match_ID(pid, 9791)) and JY.Person[pid]["����"] < JY.Person[pid]["�������ֵ"] / 4 then
        Value = Value * 3
        -- �����Ѫ�����ڶ���֮һ������������2��
    elseif (match_ID(pid, 58) or match_ID(pid, 9791)) and JY.Person[pid]["����"] < JY.Person[pid]["�������ֵ"] /
        2 then
        Value = Value * 2
    end

    -- �����书��ÿ������+2.5%
    -- ��ָ��������ȫ�棬���ߣ��������ţ�ȼľ���Ὣ������ɳ�����ߣ����ڣ���ڤ����ָ����һ��ָ
    local bjup = {18, 22, 39, 40, 56, 65, 71, 78, 74, 61, 21, 121, 17}
    for i = 1, JY.Base["�书����"] do
        if JY.Person[pid]["�书" .. i] > 0 then
            for ii = 1, #bjup do
                if JY.Person[pid]["�书" .. i] == bjup[ii] then
                    Value = Value + (100 - Value) * 0.025
                end
            end
        else
            break
        end
    end
    -- ʵս��ÿ40��+1%
    local jp = JY.Person[pid]["ʵս"] / 4000
    Value = Value + (100 - Value) * jp

    -- ��������+50%
    if Curr_NG(pid, 104) then
        Value = Value + (100 - Value) * 0.5
    elseif PersonKF(pid, 107) then
        Value = Value + (100 - Value) * 0.3
    end

    -- ����
    if match_ID(pid, 578) then
        local df = 0
        for i = 1, JY.Base["�书����"] do
            if JY.Wugong[JY.Person[0]["�书" .. i]]["�书����"] == 4 and JY.Person[0]["�书�ȼ�" .. i] == 999 then
                df = df + 1
                if df > 8 then
                    df = 8
                end
            end
            Value = Value + (100 - Value) * df * 0.05
        end
    end
    -- ���塢������ر���
    if match_ID(pid, 50) or match_ID(pid, 6) then
        Value = 100
    end

    -- ֻ��ս���в��еļӳ�
    if JY.Status == GAME_WMAP then
        -- ŷ���� ����״̬�±ر���
        if match_ID(pid, 60) and WAR.tmp[1000 + pid] == 1 then
            Value = 100
        end
    end

    -- ����������1
    if Value < 1 then
        Value = 1
    end

    -- ȡ��
    Value = math.modf(Value)

    return Value
end

-- ���ӹ���
function FJGONGJ(pid)
    -- ����
    local Value = 0
    local fb = 1
    local p = JY.Person[pid]
    local kf = JY.Person[pid]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)
    if match_ID(pid, 546) or match_ID(pid, 9911) then
        fb = 2
    end
    --������Ч1012
    if NeiGong_tx(pid,1011) and JY.Person[pid]['����'] == -1 then 
        Value = Value + dkfcj_ng*50
    end
    -- ��ת����
    if JY.Person[pid]['��Ѩ' .. 149] == 1 then
        Value = Value + JY.Person[pid]['������'] * 0.05
    end
    -- ��Ȼ����
    if JY.Person[pid]['��Ѩ' .. 139] == 1 then
        Value = Value + JY.Person[pid]['������'] * 0.05
    end
    -- ������
    if JY.Person[pid]["����"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "�ӹ�����"
        if JY.Person[pid]['��Ѩ' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["ʹ����"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    -- ׷��
    if match_ID(pid, 450) then
        Value = Value + JY.Person[pid]['�Ṧ'] * 0.3
    end
    -- ������
    if match_ID(pid, 121) then
        Value = Value + JY.Person[pid]['������'] * 0.1
    end
    -- ��������
    if match_ID(pid, 9826) then
        Value = Value - JY.Person[pid]['������'] * 0.1
    end
    -- ���Ӫ
    if match_ID(pid, 733) or match_ID(pid, 734) or match_ID(pid, 735) or match_ID(pid, 736) then
        Value = Value + JY.Person[pid]['������'] * 0.3
    end
    -- �Է�
    if match_ID(pid, 120) then
        Value = Value + 100
    end
    -- ��ɽ����
    if match_ID(pid, 133) then
        Value = Value + 100
    end
    -- ���ȷ�ħ�޺��������ӹ���
    if pid == 70 and JY.Person[pid]["��������"] == 0 then
        Value = Value + math.modf(JY.Person[pid]['������'] * 0.2)
    end
    -- ȭ����ͨ
    if match_ID(pid, 9960) then
        local n = JY.Person[pid]["ȭ�ƹ���"]
        Value = Value + n * 0.1
    end
    -- ָ����ͨ
    if match_ID(pid, 9959) then
        local n = JY.Person[pid]["ָ������"]
        Value = Value + n * 0.1
    end
    -- ������ͨ
    if match_ID(pid, 9958) then
        local n = JY.Person[pid]["��������"]
        Value = Value + n * 0.1
    end
    -- ������ͨ
    if match_ID(pid, 9957) then
        local n = JY.Person[pid]["ˣ������"]
        Value = Value + n * 0.1
    end
    -- ���ž�ͨ
    if match_ID(pid, 9956) then
        local n = JY.Person[pid]["�������"]
        Value = Value + n * 0.1
    end
    -- ��ȭ�޵�
    if match_ID(pid, 9955) then
        local n = JY.Person[pid]["ȭ�ƹ���"]
        Value = Value + n * 0.2
    end
    -- ǧ����ͨ
    if match_ID(pid, 9954) then
        local n = JY.Person[pid]["ָ������"]
        Value = Value + n * 0.2
    end
    -- ����ͨ��
    if match_ID(pid, 9953) then
        local n = JY.Person[pid]["��������"]
        Value = Value + n * 0.2
    end
    -- ������
    if match_ID(pid, 9952) then
        local n = JY.Person[pid]["ˣ������"]
        Value = Value + n * 0.2
    end
    -- ������˫
    if match_ID(pid, 9951) then
        local n = JY.Person[pid]["�������"]
        Value = Value + n * 0.2
    end
    -- һͨ��
    if match_ID(pid, 9774) then
        for i = 1, JY.Base['�书����'] do
            local wg = JY.Person[pid]['�书' .. i]
            if KF_level(pid, wg) > 10 then
                Value = Value + 10
            end
        end
    end
    if p["����"] > -1 then
        local wqfb = 1
        if JY.Thing[p["����"]]["�ӹ�����"] > 0 then
            Value = Value + JY.Thing[p["����"]]["�ӹ�����"] * 10 + JY.Thing[p["����"]]["�ӹ�����"] *
                        (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2
        elseif JY.Thing[p["����"]]["�ӹ�����"] < 0 then
            Value = Value + JY.Thing[p["����"]]["�ӹ�����"] * 10 - JY.Thing[p["����"]]["�ӹ�����"] *
                        (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2
        end
    else
        if p['����'] == 29 then
            Value = Value + p['������'] * 0.2
        end
    end
    if p["����"] > -1 then
        local zqfb = 1
        if match_ID(pid, 131) or match_ID(pid, 451) then
            zqfb = 2
        end

        if JY.Thing[p["����"]]["�ӹ�����"] > 0 then
            Value = Value + (JY.Thing[p["����"]]["�ӹ�����"] * 10 + JY.Thing[p["����"]]["�ӹ�����"] *
                        (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2) * zqfb
        elseif JY.Thing[p["����"]]["�ӹ�����"] < 0 then
            Value = Value + (JY.Thing[p["����"]]["�ӹ�����"] * 10 - JY.Thing[p["����"]]["�ӹ�����"] *
                        (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2) * zqfb
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["�ӹ�����"] > 0 then
            Value = Value + JY.Thing[p["����"]]["�ӹ�����"] * 10 + JY.Thing[p["����"]]["�ӹ�����"] *
                        (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2
        elseif JY.Thing[p["����"]]["�ӹ�����"] < 0 then
            Value = Value + JY.Thing[p["����"]]["�ӹ�����"] * 10 - JY.Thing[p["����"]]["�ӹ�����"] *
                        (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2
        end
    end

    -- �׽�ӳ�

    local qg = 0
    local fy = 0
    for i = 1, JY.Base["�书����"] do -- ���ҵ�ǰ�Ѿ������书�ȼ�
        if JY.Person[pid]["�书" .. i] == 108 then
            -- ������Ч1026
            if NeiGong_tx(pid, 1026) then
                level = math.modf(JY.Person[pid]["�书�ȼ�" .. i] / 100) + 1;
                if level >= 1 then
                    local gj = math.modf(JY.Person[pid]["������"] * (dkfcj_ng * 5 / 1000) * (level - 1))
                    Value = Value + gj
                    break
                end
            end
        end
    end
    -- ������Ч1025
    if NeiGong_tx(pid, 1025) then
        if level >= 1 then
            local qg = math.modf(dkfcj_ng * 5 * (level - 1))
            Value = Value + qg
        end
    end
    -- ������Ч702
    if NeiGong_tx(pid, 702) then
        local qg = dkfcj_ng * 6 * (level)
        Value = Value + qg
    end
    -- ������Ч715
    if NeiGong_tx(pid, 715) then
        local fy = math.modf(JY.Person[pid]["������"] * ((dkfcj_ng + 1) * 5 / 1000) * (level - 1))
        Value = Value + fy
    end
    if match_ID(pid, 9930) then -- �ڼ�����
        local gj = math.modf(JY.Person[pid]["������"] * 0.6)
        Value = Value + gj
    end
    if match_ID(pid, 604) then
        Value = Value + JY.Person[pid]["��������"]
    end
    -- ս���ӳ� 
    if JY.Status == GAME_WMAP then
        -- ����
        if CC.Weather[1][1] > 0 then
            Value = Value - JY.Person[pid]['������'] * 0.05
        end
        for wid = 0, WAR.PersonNum - 1 do
            -- �����߹�
            if ZDGH(wid, 9751) then
                if WAR.Person[wid]["����"] == false and match_ID(pid, 9751) then
                    Value = Value + 50
                end
            end
            -- �ܶ���
            if WAR.Person[wid]['����'] == false and WAR.Person[wid]["�ҷ�"] == true and
                match_ID(WAR.Person[wid]['������'], 571) then
                Value = Value + JY.Person[WAR.Person[wid]['������']]['������'] * 0.05
            end
            -- ���ѹ������ӳ�
            for i, v in pairs(CC.AddAtk) do
                if match_ID(pid, v[1]) then
                    if match_ID(WAR.Person[wid]["������"], v[2]) and WAR.Person[wid]["����"] == false then
                        Value = Value + v[3]
                    end
                end
            end
            -- ����з�������Խ�࣬����Խ��    
            if match_ID(pid, 9745) then
                if WAR.Person[wid]["����"] == false and WAR.Person[wid]["�ҷ�"] == false then
                    Value = Value + 10
                end
            end
            -- ���־�
            if match_ID(pid, 441) or match_ID(pid, 442) or match_ID(pid, 443) or match_ID(pid, 444) or
                match_ID(pid, 445) or match_ID(pid, 446) or match_ID(pid, 732) then
                if WAR.Person[wid]["����"] == false and WAR.Person[wid]["�ҷ�"] == true then
                    Value = Value + 10
                end
            end
        end
        -- ս���⻷
        for wid = 0, WAR.PersonNum - 1 do
            for i = 0, WAR.PersonNum - 1 do
                if WAR.Person[wid]['�ҷ�'] ~= WAR.Person[i]['�ҷ�'] and
                    match_ID(pid, WAR.Person[wid]['������']) then
                    -- ����ս���ӳ� ��ȫ�幥��-10%
                    if ZDGH(wid, 87) then
                        Value = Value - math.modf(JY.Person[pid]['������'] * 0.10)
                        break
                    end
                    -- ���;���
                    if ZDGH(wid, 9838) then
                        Value = Value + math.modf(JY.Person[pid]['������'] * 0.1)
                    end
                end
            end
        end
        if WAR.PD['���ϵ�������'][pid] ~= nil then
            Value = Value * 1.5
        end

        if WAR.PD["����״̬1"][pid] ~= nil then
            Value = gstr_gainj * 0.9
        end

        if WAR.PD["����״̬2"][pid] ~= nil then
            Value = Value * 0.85
        end

        if WAR.PD["����״̬3"][pid] ~= nil then
            Value = Value * 0.8
        end

        if WAR.PD["����״̬4"][pid] ~= nil then
            Value = Value * 0.75
        end
        --������Ч1032
        if NeiGong_tx(pid,1032) then 
            local sx = '������'
            local ld = JY.Person[pid][sx]*(50+dkfcj_ng*10)/100 - JY.Person[pid][sx]
            local ld1 = JY.Person[pid][sx]*0.2*(WAR.PD['�����ֻ�'][pid] or 0 )
            Value = Value + dkfcj_ng + ld1
        end
    end
    Value = math.modf(Value)
    return Value
end

-- ���ӷ���
function FJFANGY(pid)
    local Value = 0
    local fb = 1
    local p = JY.Person[pid]
    local kf = JY.Person[pid]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)
    --������Ч1010
    if NeiGong_tx(pid,1010) and JY.Person[pid]['����'] == -1 then 
        Value = Value + dkfcj_ng*50
    end
    -- ��ת����
    if JY.Person[pid]['��Ѩ' .. 149] == 1 then
        Value = Value + JY.Person[pid]['������'] * 0.05
    end
    -- ��Ȼ����
    if JY.Person[pid]['��Ѩ' .. 139] == 1 then
        Value = Value + JY.Person[pid]['������'] * 0.05
    end
    -- ������
    if JY.Person[pid]["����"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "�ӷ�����"
        if JY.Person[pid]['��Ѩ' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["ʹ����"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    -- һͨ��
    if match_ID(pid, 9774) then
        for i = 1, JY.Base['�书����'] do
            local wg = JY.Person[pid]['�书' .. i]
            if KF_level(pid, wg) > 10 then
                Value = Value + 10
            end
        end
    end
    -- ����֮��
    if JY.Person[pid]['��Ѩ' .. 61] == 1 then
        Value = Value + JY.Person[pid]['������'] * 0.1
    end
    -- ������
    if match_ID(pid, 121) then
        Value = Value + JY.Person[pid]['������'] * 0.1
    end
    -- ���ȷ�ħ�޺��������ӷ���
    if pid == 70 and JY.Person[pid]["��������"] == 1 then
        Value = Value + math.modf(JY.Person[pid]['������'] * 0.2)
    end
    -- Ц����
    if match_ID(pid, 134) then
        Value = Value + 100
    end
    -- ��Զ��ͷ
    if match_ID(pid, 572) then
        Value = Value + 80
    end
    -- ��������
    if match_ID(pid, 9826) then
        Value = Value + JY.Person[pid]['������'] * 0.1
    end
    -- ��������
    if match_ID(pid, 654) or match_ID(pid, 659) or match_ID(pid, 660) or match_ID(pid, 661) then
        Value = Value + 100
    end
    -- �˰�����
    if match_ID(pid, 187) then
        Value = Value + JY.Person[pid]['������'] * 0.1
    end
    -- ȭ����ͨ
    if match_ID(pid, 9960) then
        local n = JY.Person[pid]["ȭ�ƹ���"]
        Value = Value + n * 0.1
    end
    -- ָ����ͨ
    if match_ID(pid, 9959) then
        local n = JY.Person[pid]["ָ������"]
        Value = Value + n * 0.1
    end
    -- ������ͨ
    if match_ID(pid, 9958) then
        local n = JY.Person[pid]["��������"]
        Value = Value + n * 0.1
    end
    -- ������ͨ
    if match_ID(pid, 9957) then
        local n = JY.Person[pid]["ˣ������"]
        Value = Value + n * 0.1
    end
    -- ���ž�ͨ
    if match_ID(pid, 9956) then
        local n = JY.Person[pid]["�������"]
        Value = Value + n * 0.1
    end
    -- ��ȭ�޵�
    if match_ID(pid, 9955) then
        local n = JY.Person[pid]["ȭ�ƹ���"]
        Value = Value + n * 0.2
    end
    -- ǧ����ͨ
    if match_ID(pid, 9954) then
        local n = JY.Person[pid]["ָ������"]
        Value = Value + n * 0.2
    end
    -- ����ͨ��
    if match_ID(pid, 9953) then
        local n = JY.Person[pid]["��������"]
        Value = Value + n * 0.2
    end
    -- ������
    if match_ID(pid, 9952) then
        local n = JY.Person[pid]["ˣ������"]
        Value = Value + n * 0.2
    end
    -- ������˫
    if match_ID(pid, 9951) then
        local n = JY.Person[pid]["�������"]
        Value = Value + n * 0.2
    end

    if (PersonKF(pid, 37) and PersonKF(pid, 60)) or match_ID(pid, 96) then
        Value = Value + 64
    end

    if p["����"] > -1 then
        if JY.Thing[p["����"]]["�ӷ�����"] > 0 then
            Value = Value + JY.Thing[p["����"]]["�ӷ�����"] * 10 + JY.Thing[p["����"]]["�ӷ�����"] *
                        (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2
        elseif JY.Thing[p["����"]]["�ӷ�����"] < 0 then
            Value = Value + JY.Thing[p["����"]]["�ӷ�����"] * 10 - JY.Thing[p["����"]]["�ӷ�����"] *
                        (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2
        end
    end
    if p["����"] > -1 then
        local zqfb = 1
        if match_ID(pid, 131) or match_ID(pid, 451) then
            zqfb = 2
        end
        if JY.Thing[p["����"]]["�ӷ�����"] > 0 then
            Value = Value + (JY.Thing[p["����"]]["�ӷ�����"] * 10 + JY.Thing[p["����"]]["�ӷ�����"] *
                        (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2) * zqfb
        elseif JY.Thing[p["����"]]["�ӷ�����"] < 0 then
            Value = Value + (JY.Thing[p["����"]]["�ӷ�����"] * 10 - JY.Thing[p["����"]]["�ӷ�����"] *
                        (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2) * zqfb
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["�ӷ�����"] > 0 then
            Value = Value + JY.Thing[p["����"]]["�ӷ�����"] * 10 + JY.Thing[p["����"]]["�ӷ�����"] *
                        (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2
        elseif JY.Thing[p["����"]]["�ӷ�����"] < 0 then
            Value = Value + JY.Thing[p["����"]]["�ӷ�����"] * 10 - JY.Thing[p["����"]]["�ӷ�����"] *
                        (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2
        end
    else
        if p['����'] == 29 then
            Value = Value + p['������'] * 0.2
        end
    end
    -- �׽�ӳ�

    for i = 1, JY.Base["�书����"] do -- ���ҵ�ǰ�Ѿ������书�ȼ�
        if JY.Person[pid]["�书" .. i] == 108 then
            -- ������Ч1026
            if NeiGong_tx(pid, 1026) then
                level = math.modf(JY.Person[pid]["�书�ȼ�" .. i] / 100) + 1;
                if level >= 1 then
                    local fy = math.modf(JY.Person[pid]["������"] * (dkfcj_ng * 5 / 1000) * (level - 1))
                    Value = Value + fy
                    break
                end
            end
        end
    end
    -- ������Ч1025
    if NeiGong_tx(pid, 1025) then
        if KF_level(pid, kf) >= 1 then
            local qg = math.modf(dkfcj_ng * 5 * (level - 1))
            Value = Value + qg
        end
    end
    -- ������Ч703
    if NeiGong_tx(pid, 703) then
        local qg = dkfcj_ng * 6 * (level)
        Value = Value + qg
    end
    -- ������Ч716
    if NeiGong_tx(pid, 716) then
        local fy = math.modf(JY.Person[pid]["������"] * ((dkfcj_ng + 1) * 5 / 1000) * (level - 1))
        Value = Value + fy
    end
    if match_ID(pid, 9930) then -- �ڼ�����
        local fy = math.modf(JY.Person[pid]["������"] * 0.6)
        Value = Value + fy
    end
    if Curr_NG(pid, 199) then -- �������� ����޸�
        local sz = math.modf(JY.Person[pid]["ʵս"] / 2)
        if not inteam(pid) then
            sz = 100
        end
        Value = Value + sz
    end
    if match_ID(pid, 604) then
        Value = Value + JY.Person[pid]['��������']
    end

    -- ս��	
    if JY.Status == GAME_WMAP then
        -- ������
        if CC.Weather[3][1] > 0 then
            Value = Value - JY.Person[pid]["������"] * 0.05
        end

        for wid = 0, WAR.PersonNum - 1 do
            -- ���־�
            if match_ID(pid, 441) or match_ID(pid, 442) or match_ID(pid, 443) or match_ID(pid, 444) or
                match_ID(pid, 445) or match_ID(pid, 446) or match_ID(pid, 732) then
                if WAR.Person[wid]["����"] == false and WAR.Person[wid]["�ҷ�"] == true then
                    Value = Value + 10
                end
            end
            -- ����з�������Խ�࣬����Խ��    
            if match_ID(pid, 9745) then
                if WAR.Person[wid]["����"] == false and WAR.Person[wid]["�ҷ�"] == false then
                    Value = Value + 10
                end
            end
            -- ���ѷ������ӳ�
            for i, v in pairs(CC.AddDef) do
                if match_ID(pid, v[1]) then
                    if match_ID(WAR.Person[wid]["������"], v[2]) and WAR.Person[wid]["����"] == false then
                        Value = Value + v[3]
                    end
                end
            end
        end
        -- ս���⻷
        for wid = 0, WAR.PersonNum - 1 do
            for i = 0, WAR.PersonNum - 1 do
                if WAR.Person[wid]['�ҷ�'] ~= WAR.Person[i]['�ҷ�'] and
                    match_ID(pid, WAR.Person[wid]['������']) then
                    -- ����ͩս���ӳ� 
                    if ZDGH(wid, 74) then
                        Value = Value + math.modf(JY.Person[pid]['������'] * 0.2)
                        break
                    end
                    -- �����߹�
                    if ZDGH(wid, 9751) then
                        if WAR.Person[wid]["����"] == false and match_ID(pid, 9751) then
                            Value = Value + 50
                        end
                    end
                    -- ��������ӳ�
                    if ZDGH(wid, 86) then
                        Value = Value - math.modf(JY.Person[pid]['������'] * 0.15)
                    end
                end
            end
        end
        if WAR.PD['���ϵ�������'][pid] ~= nil then
            Value = Value * 1.5
        end

        if WAR.PD["����״̬1"][pid] ~= nil then
            Value = Value * 0.9
        end

        if WAR.PD["����״̬2"][pid] ~= nil then
            Value = Value * 0.85
        end

        if WAR.PD["����״̬3"][pid] ~= nil then
            Value = Value * 0.8
        end

        if WAR.PD["����״̬4"][pid] ~= nil then
            Value = Value * 0.75
        end
        --������Ч1032
        if NeiGong_tx(pid,1032) then 
            local sx = '������'
            local ld = JY.Person[pid][sx]*(50+dkfcj_ng*10)/100 - JY.Person[pid][sx]
            local ld1 = JY.Person[pid][sx]*0.2*(WAR.PD['�����ֻ�'][pid] or 0 )
            Value = Value + dkfcj_ng + ld1
        end
    end
    Value = math.modf(Value)
    return Value
end

-- �����Ṧ
function FJQINGG(pid)
    local Value = 0
    local fb = 1
    local p = JY.Person[pid]
    local kf = JY.Person[pid]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)
    --������Ч1011
    if NeiGong_tx(pid,1011) and JY.Person[pid]['����'] == -1 then 
        Value = Value + dkfcj_ng*50
    end
    -- ������
    if JY.Person[pid]["����"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "���Ṧ"
        if JY.Person[pid]['��Ѩ' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["ʹ����"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +(JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *(JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +(JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *(JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    -- һͨ��
    if match_ID(pid, 9774) then
        for i = 1, JY.Base['�书����'] do
            local wg = JY.Person[pid]['�书' .. i]
            if KF_level(pid, wg) > 10 then
                Value = Value + 10
            end
        end
    end
    -- ������
    if JY.Person[pid]['��Ѩ' .. 106] == 1 then
        Value = Value + JY.Person[pid]['�Ṧ'] * 0.1
    end
    -- ����
    if match_ID(pid, 546) or match_ID(pid, 9911) then
        fb = 2
    end
    -- ������
    if match_ID(pid, 121) then
        Value = Value - JY.Person[pid]['�Ṧ'] * 0.1
    end
    -- ӥ�ɾ���
    if match_ID(pid, 9811) then
        Value = Value + 100
    end
    -- ������
    if match_ID(pid, 135) then
        Value = Value + 100
    end

    -- ���ȷ�ħ�޺������������Ṧ
    if pid == 70 and JY.Person[pid]["��������"] == 2 then
        Value = Value + math.modf(JY.Person[pid]['�Ṧ'] * 0.2)
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["���Ṧ"] > 0 then
            Value = Value + JY.Thing[p["����"]]["���Ṧ"] * 10 * fb + JY.Thing[p["����"]]["���Ṧ"] *
                        (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["���Ṧ"] < 0 then
            Value = Value + JY.Thing[p["����"]]["���Ṧ"] * 10 * fb - JY.Thing[p["����"]]["���Ṧ"] *
                        (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if p["����"] > -1 then
        local zqfb = 1
        if match_ID(pid, 131) or match_ID(pid, 451) then
            zqfb = 2
        end
        if JY.Thing[p["����"]]["���Ṧ"] > 0 then
            Value = Value + (JY.Thing[p["����"]]["���Ṧ"] * 10 + JY.Thing[p["����"]]["���Ṧ"] *(JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2) * zqfb
        elseif JY.Thing[p["����"]]["���Ṧ"] < 0 then
            Value = Value + (JY.Thing[p["����"]]["���Ṧ"] * 10 - JY.Thing[p["����"]]["���Ṧ"] *(JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2) * zqfb
        end
    else
        if p['����'] == 29 then
            Value = Value + p['�Ṧ'] * 0.2
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["���Ṧ"] > 0 then
            Value = Value + JY.Thing[p["����"]]["���Ṧ"] * 10 * fb + JY.Thing[p["����"]]["���Ṧ"] *
                        (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["���Ṧ"] < 0 then
            Value = Value + JY.Thing[p["����"]]["���Ṧ"] * 10 * fb - JY.Thing[p["����"]]["���Ṧ"] *
                        (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    -- �׽�ӳ�

    for i = 1, JY.Base["�书����"] do -- ���ҵ�ǰ�Ѿ������书�ȼ�
        if JY.Person[pid]["�书" .. i] == 108 then
            -- ������Ч1026
            if NeiGong_tx(pid, 1026) then
                level = math.modf(JY.Person[pid]["�书�ȼ�" .. i] / 100) + 1;
                if level >= 1 then
                    local qg = math.modf(JY.Person[pid]["�Ṧ"] * (dkfcj_ng * 5 / 1000) * (level - 1))
                    Value = Value + qg
                    break
                end
            end
        end
    end
    -- ������Ч1025
    if NeiGong_tx(pid, 1025) then
        if KF_level(pid, kf) >= 1 then
            local qg = math.modf(dkfcj_ng * 5 * (level - 1))
            Value = Value + qg
        end
    end
    -- ������Ч704
    if NeiGong_tx(pid, 704) then
        local qg = dkfcj_ng * 6 * (level)
        Value = Value + qg
    end
    -- ������Ч717
    if NeiGong_tx(pid, 717) then
        local fy = math.modf(JY.Person[pid]["�Ṧ"] * ((dkfcj_ng + 1) * 5 / 1000) * (level - 1))
        Value = Value + fy
    end

    if match_ID(pid, 9930) then -- �ڼ�����
        local qg = math.modf(JY.Person[pid]["�Ṧ"] * 0.6)
        Value = Value + qg
    end
    -- ��ң��
    if Curr_QG(pid, 2) then
        Value = Value + 50
    end
    -- ûӰ��
    if match_ID(pid, 183) then
        Value = Value + 50
    end
    -- ��������
    if match_ID(pid, 184) then
        Value = Value + JY.Person[pid]["�Ṧ"] * 0.2
    end
    -- ���㹦
    if Curr_QG(pid, 223) then
        Value = Value + math.modf(JY.Person[pid]["�Ṧ"] * 0.2)
    end
    -- �����귭
    if Curr_QG(pid, 224) then
        Value = Value + math.modf(JY.Person[pid]["�Ṧ"] * 0.2)
    end
    -- ս���ӳ� 
    if JY.Status == GAME_WMAP then
        -- ��ѩ�� 
        if CC.Weather[2][1] > 0 then
            Value = Value - JY.Person[pid]["�Ṧ"] * 0.05
        end
        -- �����Ṧ�ӳ�
        for i, v in pairs(CC.AddSpd) do
            if match_ID(pid, v[1]) then
                for wid = 0, WAR.PersonNum - 1 do
                    if match_ID(WAR.Person[wid]["������"], v[2]) and WAR.Person[wid]["����"] == false then
                        Value = Value + v[3]
                    end
                end
            end
        end
        ---------ս���⻷����-----------		
        for wid = 0, WAR.PersonNum - 1 do
            for i = 0, WAR.PersonNum - 1 do
                if WAR.Person[wid]['�ҷ�'] ~= WAR.Person[i]['�ҷ�'] and
                    match_ID(pid, WAR.Person[wid]['������']) then
                    -- Į������	
                    if ZDGH(wid, 627) then
                        Value = Value + JY.Person[WAR.Person[wid]['������']]['�Ṧ'] * 0.1
                    end
                    if ZDGH(wid, 9751) then
                        Value = Value + 50
                    end
                end
            end
        end
        if WAR.PD['���ϵ�������'][pid] ~= nil then
            Value = Value * 1.5
        end

        if WAR.PD["����״̬1"][pid] ~= nil then
            Value = Value * 0.9
        end

        if WAR.PD["����״̬2"][pid] ~= nil then
            Value = Value * 0.85
        end

        if WAR.PD["����״̬3"][pid] ~= nil then
            Value = Value * 0.8
        end
        if WAR.PD["����״̬4"][pid] ~= nil then
            Value = Value * 0.75
        end
        --������Ч1032
        if NeiGong_tx(pid,1032) then 
            local sx = '�Ṧ'
            local ld = JY.Person[pid][sx]*(50+dkfcj_ng*10)/100 - JY.Person[pid][sx]
            local ld1 = JY.Person[pid][sx]*0.2*(WAR.PD['�����ֻ�'][pid] or 0 )
            Value = Value + dkfcj_ng + ld1
        end
    end
    Value = math.modf(Value)
    return Value
end

-- ����ҽ��
function FJYIL(pid)
    local Value = 0
    local p = JY.Person[pid]
    local fb = 1

    -- ������
    if JY.Person[pid]["����"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "��ҽ������"
        if JY.Person[pid]['��Ѩ' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["ʹ����"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["��ҽ������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["��ҽ������"] * 10 * fb +
                        JY.Thing[p["����"]]["��ҽ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["��ҽ������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["��ҽ������"] * 10 * fb -
                        JY.Thing[p["����"]]["��ҽ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["��ҽ������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["��ҽ������"] * 10 * fb +
                        JY.Thing[p["����"]]["��ҽ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["��ҽ������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["��ҽ������"] * 10 * fb -
                        JY.Thing[p["����"]]["��ҽ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["��ҽ������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["��ҽ������"] * 10 * fb +
                        JY.Thing[p["����"]]["��ҽ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["��ҽ������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["��ҽ������"] * 10 * fb -
                        JY.Thing[p["����"]]["��ҽ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if JY.Status == GAME_WMAP then
        for k, v in pairs(CC.AddDoc) do
            if match_ID(pid, v[1]) then
                for wid = 0, WAR.PersonNum - 1 do
                    if match_ID(WAR.Person[wid]["������"], v[2]) and WAR.Person[wid]["����"] == false then
                        -- DrawString(x,y, "+ "..v[3], color1, size)
                        Value = Value + v[3]
                        -- break
                    end
                end
            end
        end
    end
    return Value
end

-- �����ö�
function FJYONGD(pid)
    local Value = 0
    local p = JY.Person[pid]
    local kf = JY.Person[pid]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)
    -- ������
    if JY.Person[pid]["����"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "���ö�����"
        if JY.Person[pid]['��Ѩ' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["ʹ����"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    local fb = 1
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["���ö�����"] > 0 then
            Value = Value + JY.Thing[p["����"]]["���ö�����"] * 10 * fb +
                        JY.Thing[p["����"]]["���ö�����"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["���ö�����"] < 0 then
            Value = Value + JY.Thing[p["����"]]["���ö�����"] * 10 * fb -
                        JY.Thing[p["����"]]["���ö�����"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["���ö�����"] > 0 then
            Value = Value + JY.Thing[p["����"]]["���ö�����"] * 10 * fb +
                        JY.Thing[p["����"]]["���ö�����"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["���ö�����"] < 0 then
            Value = Value + JY.Thing[p["����"]]["���ö�����"] * 10 * fb -
                        JY.Thing[p["����"]]["���ö�����"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["���ö�����"] > 0 then
            Value = Value + JY.Thing[p["����"]]["���ö�����"] * 10 * fb +
                        JY.Thing[p["����"]]["���ö�����"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["���ö�����"] < 0 then
            Value = Value + JY.Thing[p["����"]]["���ö�����"] * 10 * fb -
                        JY.Thing[p["����"]]["���ö�����"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if JY.Status == GAME_WMAP then
        for k, v in pairs(CC.AddPoi) do
            if match_ID(pid, v[1]) then
                for wid = 0, WAR.PersonNum - 1 do
                    if match_ID(WAR.Person[wid]["������"], v[2]) and WAR.Person[wid]["����"] == false then
                        Value = Value + v[3]
                    end
                end
            end
        end
        -- ������Ч707
        if NeiGong_tx(pid, 707) then
            Value = Value + dkfcj_ng * 100
        end
    end
    return Value
end

-- ���ӽⶾ
function FJJIED(pid)
    local Value = 0
    local p = JY.Person[pid]
    local fb = 1
    local kf = JY.Person[pid]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)
    -- ������
    if JY.Person[pid]["����"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "�ӽⶾ����"
        if JY.Person[pid]['��Ѩ' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["ʹ����"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["�ӽⶾ����"] > 0 then
            Value = Value + JY.Thing[p["����"]]["�ӽⶾ����"] * 10 * fb +
                        JY.Thing[p["����"]]["�ӽⶾ����"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["�ӽⶾ����"] < 0 then
            Value = Value + JY.Thing[p["����"]]["�ӽⶾ����"] * 10 * fb -
                        JY.Thing[p["����"]]["�ӽⶾ����"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["�ӽⶾ����"] > 0 then
            Value = Value + JY.Thing[p["����"]]["�ӽⶾ����"] * 10 * fb +
                        JY.Thing[p["����"]]["�ӽⶾ����"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["�ӽⶾ����"] < 0 then
            Value = Value + JY.Thing[p["����"]]["�ӽⶾ����"] * 10 * fb -
                        JY.Thing[p["����"]]["�ӽⶾ����"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["�ӽⶾ����"] > 0 then
            Value = Value + JY.Thing[p["����"]]["�ӽⶾ����"] * 10 * fb +
                        JY.Thing[p["����"]]["�ӽⶾ����"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["�ӽⶾ����"] < 0 then
            Value = Value + JY.Thing[p["����"]]["�ӽⶾ����"] * 10 * fb -
                        JY.Thing[p["����"]]["�ӽⶾ����"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    return Value
end

-- ���Ӵ���
function FJDAID(pid)
    local Value = 0
    local p = JY.Person[pid]
    local kf = JY.Person[pid]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)
    if match_ID(pid, 190) then
        Value = Value + 200
    end
    local a = 0
    for i = 410, 418 do
        if match_ID(pid, i) then
            Value = Value + 100
        end
    end
    if match_ID(pid, 419) then
        Value = Value + 200
    end
    -- ��ѩ��
    for i = 430, 439 do
        if match_ID(pid, i) then
            Value = Value + 100
        end
    end
    -- ���
    if match_ID(pid, 440) then
        Value = Value + 100
    end
    if JY.Person[pid]['����'] == 28 then
        Value = Value + 100
    end
    Value = math.modf(Value)
    return Value
end

-- ���Ӱ���
function FJANQI(pid)
    local Value = 0
    local p = JY.Person[pid]
    local fb = 1
    local kf = JY.Person[pid]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)
    -- ������
    if JY.Person[pid]["����"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "�Ӱ�������"
        if JY.Person[pid]['��Ѩ' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["ʹ����"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["�Ӱ�������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["�Ӱ�������"] * 10 * fb +
                        JY.Thing[p["����"]]["�Ӱ�������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["�Ӱ�������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["�Ӱ�������"] * 10 * fb -
                        JY.Thing[p["����"]]["�Ӱ�������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["�Ӱ�������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["�Ӱ�������"] * 10 * fb +
                        JY.Thing[p["����"]]["�Ӱ�������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["�Ӱ�������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["�Ӱ�������"] * 10 * fb -
                        JY.Thing[p["����"]]["�Ӱ�������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["�Ӱ�������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["�Ӱ�������"] * 10 * fb +
                        JY.Thing[p["����"]]["�Ӱ�������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["�Ӱ�������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["�Ӱ�������"] * 10 * fb -
                        JY.Thing[p["����"]]["�Ӱ�������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    return Value
end

-- ����ȭ��
function FJQZ(pid)
    local Value = 0
    local kf = JY.Person[pid]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)

    -- ������
    if JY.Person[pid]["����"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "��ȭ�ƹ���"
        if JY.Person[pid]['��Ѩ' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["ʹ����"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    -- һͨ��
    if match_ID(pid, 9774) then
        for i = 1, JY.Base['�书����'] do
            if JY.Person[pid]["�书�ȼ�" .. i] == 999 and JY.Person[pid]['�书' .. i] > 0 then
                Value = Value + 10
            end
        end
    end
    -- ��˿����
    if JY.Person[pid]["����"] == 239 then
        local bonus = 0
        bonus = bonus + 10
        Value = Value + 10
        if JY.Thing[239]["װ���ȼ�"] >= 5 then
            Value = Value + 30
        elseif JY.Thing[239]["װ���ȼ�"] >= 4 then
            Value = Value + 25
        elseif JY.Thing[239]["װ���ȼ�"] >= 3 then
            Value = Value + 20
        elseif JY.Thing[239]["װ���ȼ�"] >= 2 then
            Value = Value + 15
        end
    end
    if match_ID(pid, 9947) then
        for i = 1, JY.Base["�书����"] do
            if JY.Wugong[JY.Person[pid]["�书" .. i]]["�书����"] == 6 then
                Value = Value + 20
            end
        end
    end
    local p = JY.Person[pid]
    local fb = 1
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["��ָ������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["��ָ������"] * 10 * fb +
                        JY.Thing[p["����"]]["��ָ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["��ָ������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["��ָ������"] * 10 * fb -
                        JY.Thing[p["����"]]["��ָ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["��ָ������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["��ָ������"] * 10 * fb +
                        JY.Thing[p["����"]]["��ָ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["��ָ������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["��ָ������"] * 10 * fb -
                        JY.Thing[p["����"]]["��ָ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["��ָ������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["��ָ������"] * 10 * fb +
                        JY.Thing[p["����"]]["��ָ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["��ָ������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["��ָ������"] * 10 * fb -
                        JY.Thing[p["����"]]["��ָ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    -- ����з�������Խ�࣬ϵ��Խ��   
    if JY.Status == GAME_WMAP then
        if match_ID(pid, 9745) then
            local jf = 0
            for j = 0, WAR.PersonNum - 1 do
                if WAR.Person[j]["����"] == false and WAR.Person[j]["�ҷ�"] == false then
                    jf = jf + 1
                end
            end
            Value = Value + jf * 5
        end
    end
    -- ������Ч709
    if NeiGong_tx(pid, 709) then
        Value = Value + dkfcj_ng * 10 / 100 * JY.Person[pid]['ȭ�ƹ���']
    end
    -- ������Ч714
    if NeiGong_tx(pid, 714) then
        Value = Value + (dkfcj_ng + 1) * 6 / 100 * JY.Person[pid]['ȭ�ƹ���']
    end
    return Value
end

-- ����ָ��
function FJZF(pid)
    local Value = 0
    local kf = JY.Person[pid]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)
    -- ������
    if JY.Person[pid]["����"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "��ָ������"
        if JY.Person[pid]['��Ѩ' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["ʹ����"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    -- һͨ��
    if match_ID(pid, 9774) then
        for i = 1, JY.Base['�书����'] do
            if JY.Person[pid]["�书�ȼ�" .. i] == 999 and JY.Person[pid]['�书' .. i] > 0 then
                Value = Value + 10
            end
        end
    end
    -- ��˿����
    if JY.Person[pid]["����"] == 239 then
        Value = Value + 10
        if JY.Thing[239]["װ���ȼ�"] >= 5 then
            Value = Value + 30
        elseif JY.Thing[239]["װ���ȼ�"] >= 4 then
            Value = Value + 25
        elseif JY.Thing[239]["װ���ȼ�"] >= 3 then
            Value = Value + 20
        elseif JY.Thing[239]["װ���ȼ�"] >= 2 then
            Value = Value + 15
        end
    end
    if match_ID(pid, 9947) then
        for i = 1, JY.Base["�书����"] do
            if JY.Wugong[JY.Person[pid]["�书" .. i]]["�书����"] == 6 then
                Value = Value + 20
            end
        end
    end
    local p = JY.Person[pid]
    local fb = 1
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["��ָ������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["��ָ������"] * 10 * fb +
                        JY.Thing[p["����"]]["��ָ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["��ָ������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["��ָ������"] * 10 * fb -
                        JY.Thing[p["����"]]["��ָ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["��ָ������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["��ָ������"] * 10 * fb +
                        JY.Thing[p["����"]]["��ָ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["��ָ������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["��ָ������"] * 10 * fb -
                        JY.Thing[p["����"]]["��ָ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["��ָ������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["��ָ������"] * 10 * fb +
                        JY.Thing[p["����"]]["��ָ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["��ָ������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["��ָ������"] * 10 * fb -
                        JY.Thing[p["����"]]["��ָ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    -- ����з�������Խ�࣬ϵ��Խ��    
    if JY.Status == GAME_WMAP then
        if match_ID(pid, 9745) then
            local jf = 0
            for j = 0, WAR.PersonNum - 1 do
                if WAR.Person[j]["����"] == false and WAR.Person[j]["�ҷ�"] == false then
                    jf = jf + 1
                end
            end
            Value = Value + jf * 5
        end
    end
    -- ������Ч710
    if NeiGong_tx(pid, 710) then
        Value = Value + dkfcj_ng * 10 / 100 * JY.Person[pid]['ָ������']
    end
    -- ������Ч714
    if NeiGong_tx(pid, 714) then
        Value = Value + (dkfcj_ng + 1) * 6 / 100 * JY.Person[pid]['ָ������']
    end
    return Value
end

-- ���ӽ���
function FJYJ(pid)
    local Value = 0
    local kf = JY.Person[pid]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)
    -- ������
    if JY.Person[pid]["����"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "����������"
        if JY.Person[pid]['��Ѩ' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["ʹ����"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    -- һͨ��
    if match_ID(pid, 9774) then
        for i = 1, JY.Base['�书����'] do
            if JY.Person[pid]["�书�ȼ�" .. i] == 999 and JY.Person[pid]['�书' .. i] > 0 then
                Value = Value + 10
            end
        end
    end
    -- ��������
    if WuyueJFSL(pid) > 0 then
        Value = Value + WuyueJFSL(pid) * 20
    end
    if match_ID(pid, 9947) then
        for i = 1, JY.Base["�书����"] do
            if JY.Wugong[JY.Person[pid]["�书" .. i]]["�书����"] == 6 then
                Value = Value + 20
            end
        end
    end
    local p = JY.Person[pid]
    local fb = 1
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["����������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["����������"] * 10 * fb +
                        JY.Thing[p["����"]]["����������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["����������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["����������"] * 10 * fb -
                        JY.Thing[p["����"]]["����������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["����������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["����������"] * 10 * fb +
                        JY.Thing[p["����"]]["����������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["����������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["����������"] * 10 * fb -
                        JY.Thing[p["����"]]["����������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["����������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["����������"] * 10 * fb +
                        JY.Thing[p["����"]]["����������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["����������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["����������"] * 10 * fb -
                        JY.Thing[p["����"]]["����������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    -- ����˫��
    if match_ID(pid, 9735) then
        Value = Value + JY.Person[pid]['ˣ������'] * 0.5
    end
    -- ս���еļӳ�
    if JY.Status == GAME_WMAP then
        -- �����ƽ��� ϵ��
        if match_ID(pid, 584) then
            local JF = 0
            for i = 1, JY.Base["�书����"] do
                if JY.Wugong[JY.Person[pid]["�书" .. i]]["�书����"] == 3 then
                    JF = JF + 1
                    break
                end
                Value = Value + math.modf(JF * 10)
            end
        end
        -- ����з�������Խ�࣬ϵ��Խ��    
        if match_ID(pid, 9745) then
            local jf = 0
            for j = 0, WAR.PersonNum - 1 do
                if WAR.Person[j]["����"] == false and WAR.Person[j]["�ҷ�"] == false then
                    jf = jf + 1
                end
            end
            Value = Value + jf * 5
        end
    end
    -- ������Ч711
    if NeiGong_tx(pid, 711) then
        Value = Value + dkfcj_ng * 10 / 100 * JY.Person[pid]['��������']
    end
    -- ������Ч714
    if NeiGong_tx(pid, 714) then
        Value = Value + (dkfcj_ng + 1) * 6 / 100 * JY.Person[pid]['��������']
    end
    Value = math.modf(Value)
    return Value
end

-- ���ӵ���
function FJDF(pid)
    local Value = 0
    local kf = JY.Person[pid]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)
    -- ������
    if JY.Person[pid]["����"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "��ˣ������"
        if JY.Person[pid]['��Ѩ' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["ʹ����"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    -- һͨ��
    if match_ID(pid, 9774) then
        for i = 1, JY.Base['�书����'] do
            if JY.Person[pid]["�书�ȼ�" .. i] == 999 and JY.Person[pid]['�书' .. i] > 0 then
                Value = Value + 10
            end
        end
    end
    if match_ID(pid, 9947) then
        for i = 1, JY.Base["�书����"] do
            if JY.Wugong[JY.Person[pid]["�书" .. i]]["�书����"] == 6 then
                Value = Value + 20
            end
        end
    end
    local p = JY.Person[pid]
    local fb = 1
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["��ˣ������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["��ˣ������"] * 10 * fb +
                        JY.Thing[p["����"]]["��ˣ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["��ˣ������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["��ˣ������"] * 10 * fb -
                        JY.Thing[p["����"]]["��ˣ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["��ˣ������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["��ˣ������"] * 10 * fb +
                        JY.Thing[p["����"]]["��ˣ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["��ˣ������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["��ˣ������"] * 10 * fb -
                        JY.Thing[p["����"]]["��ˣ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["��ˣ������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["��ˣ������"] * 10 * fb +
                        JY.Thing[p["����"]]["��ˣ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["��ˣ������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["��ˣ������"] * 10 * fb -
                        JY.Thing[p["����"]]["��ˣ������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    -- ����˫��
    if match_ID(pid, 9735) then
        Value = Value + JY.Person[pid]['��������'] * 0.5
    end
    -- ����з�������Խ�࣬ϵ��Խ��  
    if JY.Status == GAME_WMAP then
        if match_ID(pid, 9745) then
            local df = 0
            for j = 0, WAR.PersonNum - 1 do
                if WAR.Person[j]["����"] == false and WAR.Person[j]["�ҷ�"] == false then
                    df = df + 1
                end
            end
            Value = Value + df * 5
        end
    end
    -- ������Ч712
    if NeiGong_tx(pid, 712) then
        Value = Value + dkfcj_ng * 10 / 100 * JY.Person[pid]['ˣ������']
    end
    -- ������Ч714
    if NeiGong_tx(pid, 714) then
        Value = Value + (dkfcj_ng + 1) * 6 / 100 * JY.Person[pid]['ˣ������']
    end
    return Value
end

-- �������� �����������
function FJQM(pid)
    local Value = 0
    local kf = JY.Person[pid]['�����ڹ�']
    local dkfcj_ng = JY.Wugong[kf]['�㼶']
    local level = KF_level(pid, kf)
    -- ������
    if JY.Person[pid]["����"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "���������"
        if JY.Person[pid]['��Ѩ' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["ʹ����"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["װ���ȼ�"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    -- һͨ��
    if match_ID(pid, 9774) then
        for i = 1, JY.Base['�书����'] do
            if JY.Person[pid]["�书�ȼ�" .. i] == 999 and JY.Person[pid]['�书' .. i] > 0 then
                Value = Value + 10
            end
        end
    end
    if match_ID(pid, 9947) then
        for i = 1, JY.Base["�书����"] do
            if JY.Wugong[JY.Person[pid]["�书" .. i]]["�书����"] == 6 then
                Value = Value + 20
            end
        end
    end
    local p = JY.Person[pid]
    local fb = 1
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["���������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["���������"] * 10 * fb +
                        JY.Thing[p["����"]]["���������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["���������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["���������"] * 10 * fb -
                        JY.Thing[p["����"]]["���������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["���������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["���������"] * 10 * fb +
                        JY.Thing[p["����"]]["���������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["���������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["���������"] * 10 * fb -
                        JY.Thing[p["����"]]["���������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    if p["����"] > -1 then
        if JY.Thing[p["����"]]["���������"] > 0 then
            Value = Value + JY.Thing[p["����"]]["���������"] * 10 * fb +
                        JY.Thing[p["����"]]["���������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        elseif JY.Thing[p["����"]]["���������"] < 0 then
            Value = Value + JY.Thing[p["����"]]["���������"] * 10 * fb -
                        JY.Thing[p["����"]]["���������"] * (JY.Thing[p["����"]]["װ���ȼ�"] - 1) * 2 * fb
        end
    end
    -- ����з�������Խ�࣬ϵ��Խ�� 
    if JY.Status == GAME_WMAP then
        if match_ID(pid, 9745) then
            local df = 0
            for j = 0, WAR.PersonNum - 1 do
                if WAR.Person[j]["����"] == false and WAR.Person[j]["�ҷ�"] == false then
                    df = df + 1
                end
            end
            Value = Value + df * 5
        end
    end
    -- ������Ч713
    if NeiGong_tx(pid, 713) then
        Value = Value + dkfcj_ng * 10 / 100 * JY.Person[pid]['�������']
    end
    -- ������Ч714
    if NeiGong_tx(pid, 714) then
        Value = Value + (dkfcj_ng + 1) * 6 / 100 * JY.Person[pid]['�������']
    end
    return Value
end

-- ��ʵ����
-- �޾Ʋ�������ʵȭ���������ж�
function TrueQZ(id)
    local qz = JY.Person[id]["ȭ�ƹ���"]
    qz = qz + FJQZ(id)
    return qz
end

-- �޾Ʋ�������ʵָ���������ж�
function TrueZF(id)
    local zf = JY.Person[id]["ָ������"]
    zf = zf + FJZF(id)
    return zf
end

-- �޾Ʋ�������ʵ�����������ж�
function TrueYJ(id)
    local yj = JY.Person[id]["��������"]
    yj = yj + FJYJ(id)
    return yj
end

-- �޾Ʋ�������ʵˣ���������ж�
function TrueSD(id)
    local sd = JY.Person[id]["ˣ������"]
    sd = sd + FJDF(id)
    return sd
end

-- �޾Ʋ�������ʵ�����������ж�
function TrueTS(id)
    local ts = JY.Person[id]["�������"]
    ts = ts + FJQM(id)
    return ts
end

-- �޾Ʋ������ж�һ�������Ƿ����������黭������
function QinqiSH(id)
    if PersonKF(id, 73) and PersonKF(id, 72) and PersonKF(id, 84) and PersonKF(id, 142) then
        return true
    end
    return false
end

-- ���ƮҶ ��������˳��
function Menu_TZDY()
    local menu = {}
    local px = {}
    local m = 0
    -- ���ѳ���2�˲Ż���Ч
    if JY.Base["����" .. 3] > 0 then
        Cls()
        DrawStrBox(CC.MainMenuX, CC.MainSubMenuY, "��Ҫ����˭��λ��", LimeGreen, CC.DefaultFont, C_GOLD);
        local nexty = CC.MainSubMenuY + CC.SingleLineHeight;
        for i = 1, CC.TeamNum do
            menu[i] = {"", nil, 0};
            local id = JY.Base["����" .. i]
            if id > 0 then
                menu[i] = {"", nil, 0};
                if JY.Person[id]["����"] > 0 then
                    menu[i][1] = JY.Person[id]["����"];
                    menu[i][3] = 1;
                end
            end
        end

        local r = -1;
        while true do
            r = ShowMenu(menu, #menu, 0, CC.MainMenuX, CC.MainSubMenuY + CC.SingleLineHeight, 0, 0, 1, 1,
                CC.DefaultFont, C_ORANGE, C_WHITE)
            if px["������"] == nil and r > 1 then
                px["������"] = r
                menu[r] = {"", nil, 0}
                Cls()
                DrawStrBox(CC.MainMenuX, CC.MainSubMenuY,
                    JY.Person[JY.Base["����" .. r]]["����"] .. "��˭����λ��", LimeGreen, CC.DefaultFont,
                    C_GOLD);
            elseif r > 1 and px["������"] ~= nil and r ~= px["������"] then
                local m1 = JY.Base["����" .. r]
                local m2 = JY.Base["����" .. px["������"]]
                JY.Base["����" .. r] = m2
                JY.Base["����" .. px["������"]] = m1
                say("��" .. JY.Person[m2]["����"] .. "�� �� ��" .. JY.Person[m1]["����"] ..
                        "�� ������λ�á�", m2, 1)
                Cls()
                -- return
                break
                -- �޾Ʋ���������ESC�˳�����
            else
                break
            end
        end
    end
end

-- �޾Ʋ�������һ����
function DrawSingleLine(x1, y1, x2, y2, color)
    lib.DrawRect(x1 + 1, y1 + 1, x2, y2, color)
    lib.DrawRect(x1, y1, x2 - 1, y2 - 1, color)
end

-- �ı�����
function SetTianWai(personid, x, wugongid)
    JY.Person[personid]["�츳�⹦" .. x] = wugongid
    if personid == JY.Base["����"] then
        JY.Person[0]["�츳�⹦" .. x] = wugongid
    end
end

-- �ı�����
function SetTianNei(personid, wugongid)
    JY.Person[personid]["�츳�ڹ�"] = wugongid
    if personid == JY.Base["����"] then
        JY.Person[0]["�츳�ڹ�"] = wugongid
    end
end

-- �ı�����
function SetTianQing(personid, wugongid)
    JY.Person[personid]["�츳�Ṧ"] = wugongid
    if personid == JY.Base["����"] then
        JY.Person[0]["�츳�Ṧ"] = wugongid
    end
end

-- ����������ϵ����ֵ֮��
function Xishu_sum(id)
    local sum = 0
    sum = sum + TrueQZ(id)
    sum = sum + TrueZF(id)
    sum = sum + TrueYJ(id)
    sum = sum + TrueSD(id)
    sum = sum + TrueTS(id)
    return sum
end

-- ��������ϵ����ֵ��ߵ�һ��
function Xishu_max(id)
    local m = 0
    local xishu = {TrueQZ, TrueZF, TrueYJ, TrueSD, TrueTS}
    for i = 1, #xishu do
        local x = xishu[i](id)
        if x > m then
            m = x
        end
    end
    return m
end

-- ���ð汳��ͼ
function Clipped_BgImg(x1, y1, x2, y2, picnum)
    lib.SetClip(x1 + 2, y1 + 2, x2 - 1, y2 - 1)
    lib.LoadPNG(1, picnum * 2, -1, -1, 1)
    lib.SetClip(0, 0, 0, 0)
end

-- ��ʾ���߿������
function DrawBoxTitle(width, height, str, color)
    local s = 4
    local x1, y1, x2, y2, tx1, tx2 = nil, nil, nil, nil, nil, nil
    local fontsize = s + CC.DefaultFont
    local len = string.len(str) * fontsize / 2
    x1 = (CC.ScreenW - width) / 2
    x2 = (CC.ScreenW + width) / 2
    y1 = (CC.ScreenH - height) / 2
    y2 = (CC.ScreenH + height) / 2
    tx1 = (CC.ScreenW - len) / 2
    tx2 = (CC.ScreenW + len) / 2
    lib.Background(x1, y1 + s, x1 + s, y2 - s, 128)
    lib.Background(x1 + s, y1, x2 - s, y2, 128)
    lib.Background(x2 - s, y1 + s, x2, y2 - s, 128)
    lib.Background(tx1, y1 - fontsize / 2 + s, tx2, y1, 128)
    lib.Background(tx1 + s, y1 - fontsize / 2, tx2 - s, y1 - fontsize / 2 + s, 128)
    local r, g, b = GetRGB(color)
    DrawBoxTitle_sub(x1 + 1, y1 + 1, x2, y2, tx1 + 1, y1 - fontsize / 2 + 1, tx2, y1 + fontsize / 2,
        RGB(math.modf(r / 2), math.modf(g / 2), math.modf(b / 2)))
    DrawBoxTitle_sub(x1, y1, x2 - 1, y2 - 1, tx1, y1 - fontsize / 2, tx2 - 1, y1 + fontsize / 2 - 1, color)
    DrawString(tx1 + 2 * s, y1 - (fontsize - s) / 2, str, color, CC.DefaultFont)
end

-- ����һƬ�Ľǰ����ı���
function DrawShades(x1, y1, x2, y2, color)
    local s = 4;
    lib.Background(x1 + 4, y1, x2 - 4, y1 + s, 128, color);
    lib.Background(x1 + 1, y1 + 1, x1 + s, y1 + s, 128, color);
    lib.Background(x2 - s, y1 + 1, x2 - 1, y1 + s, 128, color);
    lib.Background(x1, y1 + 4, x2, y2 - 4, 128, color);
    lib.Background(x1 + 1, y2 - s, x1 + s, y2 - 1, 128, color);
    lib.Background(x2 - s, y2 - s, x2 - 1, y2 - 1, 128, color);
    lib.Background(x1 + 4, y2 - s, x2 - 4, y2, 128, color);
end

-- ��Ʒ��ϸ˵��
function detailed_info(thingID)
    local str = JY.Thing[thingID]["����"] .. JY.Thing[thingID]["����"]
    local str2 = JY.Thing[thingID]["��Ʒ˵��"]
    local str3 = JY.Thing[thingID]["����"]
    if ItemInfo[thingID] == nil then
        return
    end
    local info = {}
    info = ItemInfo[thingID]
    local function strcolor_switch(s)
        local Color_Switch = {{"��", PinkRed}, {"��", C_GOLD}, {"��", C_BLACK}, {"��", C_WHITE}, {"��", C_ORANGE},
                              {"��", LimeGreen}, {"��", M_DeepSkyBlue}, {"��", Violet}}
        for i = 1, 8 do
            if Color_Switch[i][1] == s then
                return Color_Switch[i][2]
            end
        end
    end
    local maxRowExisting = #info -- ��ǰ˵��������
    local maxRowDisplayable = 11 -- ����ҳ�������ʾ���������
    if maxRowDisplayable > maxRowExisting - 1 then
        maxRowDisplayable = maxRowExisting - 1
    end
    local startingRow = 1
    local size = CC.Fontsmall
    while true do
        if JY.Restart == 1 then
            break
        end
        Cls()
        lib.LoadPNG(91, 30 * 2, -1, -1, 1)
        DrawString(CC.ScreenW / 2, 14.5, str3, C_GOLD, CC.ThingFontSize)
        DrawString(22, 64.5, str2, C_ORANGE, CC.ThingFontSize)
        local row = 1
        for i = startingRow, startingRow + maxRowDisplayable do
            local tfstr = info[i]
            if string.sub(tfstr, 1, 2) == "��" then
                row = row + 1
            else
                local color;
                color = strcolor_switch(string.sub(tfstr, 1, 2))
                tfstr = string.sub(tfstr, 3, -1)
                DrawString(22, 80 + (size + CC.RowPixel * 2) * (row), tfstr, color, size)
                row = row + 1
            end
        end
        -- ���·��ļ�ͷ��ʾ
        if startingRow > 1 then
            DrawString(CC.ScreenW - 40, 110, "��", C_GOLD, size)
        end
        if startingRow + maxRowDisplayable < maxRowExisting then
            DrawString(CC.ScreenW - 40, CC.ScreenH - 140, "��", C_GOLD, size)
        end
        DrawString(CC.ScreenW - 220, CC.ScreenH - 40, "��F1������Ʒ�˵�", C_ORANGE, size)
        ShowScreen()
        local keypress, ktype, mx, my = WaitKey(1)
        if keypress == VK_ESCAPE or keypress == VK_RETURN or keypress == VK_F1 or ktype == 4 then
            return
        elseif keypress == VK_UP and startingRow > 1 then
            startingRow = startingRow - 1
        elseif keypress == VK_DOWN and startingRow + maxRowDisplayable < maxRowExisting then
            startingRow = startingRow + 1
        end
    end
end

function Pmiji(id, m)
    for i = 1, 10 do
        if JY.Person[id]["�ؼ�" .. i] == m then
            return true
        end
    end
    return false
end

-- ��װ
function Avatar_Switch(id)
    -- �ж��Ƿ���
    local Ani_id = id
    if id == 0 and JY.Base["����"] > 0 then
        Ani_id = JY.Base["����"]
    end
    if Avatar[Ani_id] == nil then
        return
    end
    local r = LGMsgBox("һ����װ", "��ѡ��" .. JY.Person[id]["����"] .. "������",
        {Avatar[Ani_id][1].name, Avatar[Ani_id][2].name}, #Avatar[Ani_id], id, 1)
    JY.Person[id]["ͷ�����"] = Avatar[Ani_id][r].num
    JY.Person[id]["������"] = Avatar[Ani_id][r].num2
    for i = 1, 5 do
        JY.Person[id]["���ж���֡��" .. i] = Avatar[Ani_id][r].frameNum[i]
        JY.Person[id]["���ж����ӳ�" .. i] = Avatar[Ani_id][r].frameDelay[i]
        JY.Person[id]["�书��Ч�ӳ�" .. i] = Avatar[Ani_id][r].soundDelay[i]
    end
end

function Teammember_View()

    local choice = 1

    while true do
        if JY.Restart == 1 then
            return
        end
        Cls()

        lib.LoadPNG(96, 1 * 2, -1, -1, 1)

        local x = 8
        for i = 1, 5 do
            if choice ~= i then
                lib.SetClip(x + 10, CC.ScreenH - 579 + 13, x + 184 - 10, CC.ScreenH - 579 + 575)
                lib.LoadPNG(95, i * 2, x - 90, CC.ScreenH - 579, 1)

                local h = 494
                local space = 35
                local color = C_WHITE

                local indent = 0

                if string.len(JY.Person[i]["����"]) == 8 then
                    indent = 29
                elseif string.len(JY.Person[i]["����"]) == 6 then
                    indent = 14
                end

                DrawString(x + 61 - indent, h, JY.Person[i]["����"], color, CC.DefaultFont)
                h = h + space

                DrawString(x + 58, h, "LV" .. JY.Person[i]["�ȼ�"], color, CC.Fontsmall)
                h = h + space

                DrawString(x + 41, h, "���� " .. JY.Person[i]["������"], color, CC.Fontsmall)
                h = h + space

                DrawString(x + 41, h, "���� " .. JY.Person[i]["������"], color, CC.Fontsmall)
                h = h + space

                DrawString(x + 41, h, "�Ṧ " .. JY.Person[i]["�Ṧ"], color, CC.Fontsmall)
                h = h + space
            end
            x = x + 184
        end

        lib.SetClip(0, 0, 0, 0)

        x = 8
        for i = 1, 5 do
            if choice == i then
                lib.LoadPNG(96, 3 * 2, x, CC.ScreenH - 579, 1)
            else
                lib.LoadPNG(96, 2 * 2, x, CC.ScreenH - 579, 1)
            end
            x = x + 184
        end

        x = 8
        for i = 1, 5 do
            if choice == i then
                lib.SetClip(x + 10, CC.ScreenH - 579 + 13, x + 184 - 10, CC.ScreenH - 579 + 575)
                lib.LoadPNG(95, i * 2, x - 90, CC.ScreenH - 579, 1)

                local h = 494
                local space = 35
                local color = LightYellow2

                local indent = 0

                if string.len(JY.Person[i]["����"]) == 8 then
                    indent = 29
                elseif string.len(JY.Person[i]["����"]) == 6 then
                    indent = 14
                end

                DrawString(x + 61 - indent, h, JY.Person[i]["����"], color, CC.DefaultFont)
                h = h + space

                DrawString(x + 58, h, "LV" .. JY.Person[i]["�ȼ�"], color, CC.Fontsmall)
                h = h + space

                DrawString(x + 41, h, "���� " .. JY.Person[i]["������"], color, CC.Fontsmall)
                h = h + space

                DrawString(x + 41, h, "���� " .. JY.Person[i]["������"], color, CC.Fontsmall)
                h = h + space

                DrawString(x + 41, h, "�Ṧ " .. JY.Person[i]["�Ṧ"], color, CC.Fontsmall)
                h = h + space
            end
            x = x + 184
        end

        local keypress, ktype, mx, my = lib.GetKey()

        if keypress == VK_LEFT then
            PlayWavE(77)
            choice = choice - 1
        elseif keypress == VK_RIGHT then
            PlayWavE(77)
            choice = choice + 1
        end

        ShowScreen()
        lib.Delay(CC.Frame)

    end

end

-- ѡ���żһԵ��ؼ�
-- ����������������BABA
function YC_ZhangJiaHui(key)
    local up, down, left, right = VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT
    local C, H, U, N, G, E = VK_C, VK_H, VK_U, VK_N, VK_G, VK_E
    local sequence = {C, H, U, N, G, E}
    if key == sequence[YC.ZJH + 1] then
        YC.ZJH = YC.ZJH + 1
    else
        YC.ZJH = 0
    end
end

function YC_GUXIZHAOWSC(key)
    local L, A, O, G, U = VK_L, VK_A, VK_O, VK_G, VK_U
    local sequence = {L, A, O, G, U}
    if key == sequence[YC.GXZ + 1] then
        YC.GXZ = YC.GXZ + 1
    else
        YC.GXZ = 0
    end
end

-- ���ݶ�����ͼ���㶯�����
function tjmdh(num)
    local a = 0
    for i = 0, #CC.Effect do
        a = CC.Effect[i] + a
        if num <= a then
            say(i, 0, 1)
            break
        end
        if i == #CC.Effect and num > a then
            say('������Χ', 0, 1)
            break
        end
    end
end

-- �Ϲ�����
-- ��������ҳ��
function firstmenu()
    local bx, by = CC.WX, CC.HY
    local size = CC.DefaultFont
    local tsmenu = {'��', 'ѩ', '��', '��', '��', '��', '¹', 'Ц', '��', '��', '��', '��', '��', 'ԧ'}
    local tsmenu1 = {'�ɺ��⴫', 'ѩɽ�ɺ�', '���Ǿ�', '�����˲�', '���Ӣ�۴�', '����Х����',
                     '¹����', 'Ц������', '�齣����¼', '�������', '������', '����������',
                     '��Ѫ��', 'ԧ�쵶'}
    local menu2 = {{1, 2, 3, 4, 72, 587, 731, 739, 740, 741, 742, 732, 748}, -- ��
    {633, 738, 545, 722}, -- ѩ
    {37, 589, 94, 95, 96, 97, 52, 594, 595}, -- ��
    {49, 50, 53, 51, 76, 47, 46, 48, 103, 113, 112, 114, 115, 116, 117, 118, 98, 99, 100, 104, 90, 105, 102, 70, 634,
     45, 574, 44, 565, 576, 499}, -- ��
    {55, 56, 57, 60, 61, 64, 65, 67, 68, 69, 78, 123, 128, 567, 568, 588, 130, 129, 605, 650, 604}, -- ��
    {590, 138, 137}, -- ��
    {601, 86, 87, 602, 603, 150, 71}, -- ¹
    {35, 36, 73, 79, 27, 19, 20, 21, 22, 23, 24, 25, 26, 28, 29, 88, 140, 141, 142, 149, 234, 458, 510, 593, 649, 583}, -- Ц
    {74, 75, 80, 151, 152, 153, 154, 155, 156, 311, 313, 570, 571, 569, 657, 658, 656, 655, 606}, -- ��
    {58, 59, 63, 626, 62, 84, 89, 580, 161, 616, 617, 160, 157, 158, 159, 592, 628, 627}, -- ��
    {38, 581, 582, 39, 40, 41, 42, 43, 85, 164, 162, 163, 636}, -- ��
    {9, 609, 631, 66, 646, 5, 6, 7, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 169, 170, 174, 81, 82, 640, 647, 648, 638,
     586, 573, 575, 597, 641, 532, 534, 308}, -- ��
    {54, 91, 629, 183, 184, 185, 186, 607, 83, 176, 639}, -- ��
    {77, 566, 189, 615, 614, 613, 612} -- ԧ
    }
    local tb = 1
    local lb = 1
    local rw, rw1 = 1, 0

    local fy, fymax, star = 0, 0, 1
    -- ����
    local cx, ts, zj, xb = 0, 0, 0, 0
    local tbx, tby = bx * 1225, by * 195
    local tsw, tsh = bx * 54, by * 45
    local dh = 0
    while true do
        if JY.Restart == 1 then
            break
        end
        -- ������棬��Ϊ�˵�������ѭ����״̬��������ʾ����ǰ����Ҫ���֮ǰ�Ļ��棬������ͼ���޵���
        ClsN()

        ---------------
        lib.LoadPNG(91, 24 * 2, -1, -1, 1)
        lib.LoadPNG(91, 25 * 2, -1, -1, 1)
        lib.LoadPNG(91, 26 * 2, -1, -1, 1)
        for i = 1, #tsmenu do
            local cl = C_BLACK
            local tsbx, tsby = bx * 1225, by * 195 -- ��ʼ����
            if i > 7 then
                tsbx, tsby = bx * 75, by * 195 -- ��ʼ����
            end
            local tsk = by * 68 * (i - 1)
            if tb == i then
                cl = C_RED
                if tb > 7 then
                    lib.LoadPNG(91, 22 * 2, tsbx - bx * 10, by * 68 + by * 68 * (tb - 6), 1, 0, 40)
                else
                    lib.LoadPNG(91, 22 * 2, tsbx - bx * 10, tsby + tsk, 1, 0, 40)
                end
            end
            if i > 7 then
                tsk = by * 68 * (i - 8)
            end
            lib.DrawStr(tsbx, tsby + tsk, tsmenu[i], cl, size * 2, CONFIG.CurrentPath .. "FONT/2.ttf", 0, 0)
            lib.DrawStr(bx * 644 - string.len(tsmenu1[tb]) * size / 4, by * 70, tsmenu1[tb], C_WHITE, size * 1.6, CONFIG.CurrentPath .. "FONT/2.ttf", 0, 0)

        end
        if lb == 1 or lb == 2 then
            for i = 1, 6 do
                local cl = C_WHITE
                local ii = rw1 + i
                if menu2[tb][ii] ~= nil then
                    local id = menu2[tb][ii]
                    local pic = JY.Person[id]["������"]
                    local name = JY.Person[id]["����"]
                    local rwx, rwy = bx * 276, by * 165
                    local rww, rwh = bx * 140, by * 110
                    if rw == i then
                        lib.LoadPNG(90, pic * 2, bx * 276, by * 410, 1, 0, 90)
                        lib.LoadPNG(91, 12 * 2, rwx + (rw - 1) * rww - bx * 5, rwy - by * 10, 1, 0, 116)
                        cl = C_RED
                        local me = {}
                        local row = 0
                        local maxh = 9
                        -- lib.Debug(name..' tf='..JY.Person[id]['�츳'..1])
                        for i = 1, 5 do
                            if JY.Person[id]['�츳' .. i] > 0 then
                                local tf = JY.Person[id]['�츳' .. i]
                                -- lib.Debug(name..' tf='..JY.Person[id]['�츳'..1])
                                if CC.PTFSM[tf] ~= nil then
                                    me[#me + 1] = '��' .. CC.PTFSM[tf][1]
                                    me[#me + 1] = '��' .. CC.PTFSM[tf][2]
                                    me[#me + 1] = "��"
                                end
                            end
                        end
                        for i = 1, #ZJZSJS do
                            me[#me + 1] = ZJZSJS[i]
                            if i == #ZJZSJS then
                                me[#me + 1] = "��"
                            end
                        end
                        for i = star, #me do
                            local tfstr = me[i]
                            local h = 0
                            if string.sub(tfstr, 1, 2) == "��" then
                                row = row + 1
                            else
                                h = tjm(bx * 550, by * 420 + size * 0.8 * (row - fy), tfstr, C_WHITE, size * 0.8,math.modf((bx * 554) / size / 0.8) - 1, size * 0.8, fy - row, maxh + 1 - row + fy)
                            end
                            row = row + h
                        end
                        if row > maxh then
                            fymax = limitX(row - maxh - 1, 0)
                        else
                            fymax = 0
                        end
                    end
                    lib.LoadPNG(91, 39 * 2, rwx + (i - 1) * rww - bx * 5, rwy, 1, 0, 50)
                    lib.LoadPNG(1, pic * 2, rwx + (i - 1) * rww, rwy, 1, 0, 90)
                    lib.DrawStr(rwx + size * 1.8 + (i - 1) * rww - string.len(name) * size / 4, rwy + size * 3.8, name,cl, size, CONFIG.CurrentPath .. "FONT/0.ttf", 0, 0)
                end
            end
            local zs = 0
            local dl = 0
            local dhid = menu2[tb][rw + rw1]
            for j = 1, 5 do
                if JY.Person[dhid]['���ж���֡��' .. j] > 0 then
                    if j > 1 then
                        zs = JY.Person[dhid]['���ж���֡��' .. j]
                        break
                    end
                    dl = dl + JY.Person[dhid]['���ж���֡��' .. j] * 4
                end
            end
            lib.PicLoadCache(JY.Person[dhid]["ͷ�����"] + 101, (dl + dh + zs * 3) * 2, bx * 290, by * 700)
            dh = dh + 1
            if dh == zs then
                dh = 0
            end
        end
        -- ��ʾ����
        ShowScreen()
        -- ѭ���ļ������ֵ���⣩
        lib.Delay(80)
        -- X�Ǽ��̲�����ktype����������ktype = 3 ���������4�����Ҽ���6�����ϣ�7������
        local X, ktype, mx, my = lib.GetKey()
        if X == VK_ESCAPE or ktype == 4 then
            if lb == 2 then
                lb = 1
            elseif lb == 1 then
                return Moshixz()
            end
        elseif X == VK_SPACE or X == VK_RETURN then
            if lb == 1 then
                lb = 2
            elseif lb == 2 then
                local zm = 0
                local nd = JY.Base["�Ѷ�"]
                local addkfnum
                JY.Base["����"] = menu2[tb][rw + rw1]
                local clone_choice = JY.Base["����"]
                JY.Person[0]["����"] = JY.Person[clone_choice]["����"]
                JY.Person[0]["ͷ�����"] = JY.Person[clone_choice]["ͷ�����"]
                JY.Person[0]["������"] = JY.Person[clone_choice]["������"]
                JY.Person[0]["����"] = JY.Person[clone_choice]["����"]
                if JY.Person[0]["����"] < 5 then
                    JY.Person[0]["����"] = 5
                end
                if JY.Person[0]["����"] > 12 then
                    JY.Person[0]["����"] = 12
                end
                JY.Person[0]["����"] = JY.Person[clone_choice]["����"]
                JY.Person[0]["���"] = JY.Person[clone_choice]["���"]
                JY.Person[0]["�Ա�"] = JY.Person[clone_choice]["�Ա�"]

                JY.Person[0]["����"] = -1
                JY.Person[0]["����"] = -1
                JY.Person[0]["����"] = -1
                for i = 1, 2 do
                    JY.Person[0]["�书" .. i] = JY.Person[clone_choice]["�书" .. i]
                    JY.Person[0]["�书�ȼ�" .. i] = JY.Person[clone_choice]["�书�ȼ�" .. i]
                end
                CC.kaijuwugong1 = JY.Person[0]["�书1"]
                CC.kaijuwugong2 = JY.Person[0]["�书2"]
                CC.kaijuwugong3 = JY.Person[0]["�书3"]
                CC.kaijuwugongx1 = JY.Person[0]["�书�ȼ�1"]
                CC.kaijuwugongx2 = JY.Person[0]["�书�ȼ�2"]
                CC.kaijuwugongx3 = JY.Person[0]["�书�ȼ�3"]
                for i = 1, 5 do
                    JY.Person[0]["���ж���֡��" .. i] = JY.Person[clone_choice]["���ж���֡��" .. i]
                    JY.Person[0]["���ж����ӳ�" .. i] = JY.Person[clone_choice]["���ж����ӳ�" .. i]
                    JY.Person[0]["�书��Ч�ӳ�" .. i] = JY.Person[clone_choice]["�书��Ч�ӳ�" .. i]
                end

                -- ���빥�������55
                JY.Person[0]["������"] = limitX(JY.Person[clone_choice]["������"] / 4, 55, 75)
                JY.Person[0]["������"] = limitX(JY.Person[clone_choice]["������"] / 4, 55, 75)
                JY.Person[0]["�Ṧ"] = limitX(JY.Person[clone_choice]["�Ṧ"] / 4, 55, 75)
                -- ҽ���ö��ⶾ���30
                JY.Person[0]["ҽ������"] = limitX(JY.Person[clone_choice]["ҽ������"], 30)
                JY.Person[0]["�ö�����"] = limitX(JY.Person[clone_choice]["�ö�����"], 30)
                JY.Person[0]["�ⶾ����"] = limitX(JY.Person[clone_choice]["�ⶾ����"], 30)
                JY.Person[0]["��������"] = limitX(JY.Person[clone_choice]["��������"], 30) + zm
                JY.Person[0]["��������"] = JY.Person[clone_choice]["��������"]
                JY.Person[0]["�����ڹ�"] = 0
                JY.Person[0]["�����Ṧ"] = 0

                if CC.PersonExit[clone_choice] ~= nil then

                    JY.Person[0]["ȭ�ƹ���"] = limitX(JY.Person[clone_choice]["ȭ�ƹ���"], 30, 70) + zm
                    JY.Person[0]["ָ������"] = limitX(JY.Person[clone_choice]["ָ������"], 30, 70) + zm
                    JY.Person[0]["��������"] = limitX(JY.Person[clone_choice]["��������"], 30, 70) + zm
                    JY.Person[0]["ˣ������"] = limitX(JY.Person[clone_choice]["ˣ������"], 30, 70) + zm
                    JY.Person[0]["�������"] = limitX(JY.Person[clone_choice]["�������"], 30, 70) + zm
                else

                    JY.Person[0]["ȭ�ƹ���"] = limitX(JY.Person[clone_choice]["ȭ�ƹ���"] / 3, 30, 70) + zm
                    JY.Person[0]["ָ������"] = limitX(JY.Person[clone_choice]["ָ������"] / 3, 30, 70) + zm
                    JY.Person[0]["��������"] = limitX(JY.Person[clone_choice]["��������"] / 3, 30, 70) + zm
                    JY.Person[0]["ˣ������"] = limitX(JY.Person[clone_choice]["ˣ������"] / 3, 30, 70) + zm
                    JY.Person[0]["�������"] = limitX(JY.Person[clone_choice]["�������"] / 3, 30, 70) + zm
                end

                JY.Person[0]["��ѧ��ʶ"] = JY.Person[clone_choice]["��ѧ��ʶ"]
                JY.Person[0]["��������"] = JY.Person[clone_choice]["��������"]
                for i = 1, 5 do
                    JY.Person[0]["�ؼ�" .. i] = JY.Person[clone_choice]["�ؼ�" .. i]
                end

                for i = 1, 4 do
                    JY.Person[0]["Я����Ʒ" .. i] = JY.Person[clone_choice]["Я����Ʒ" .. i]
                    JY.Person[0]["Я����Ʒ����" .. i] = JY.Person[clone_choice]["Я����Ʒ����" .. i]
                end

                for i = 1, 2 do
                    JY.Person[0]["�츳�⹦" .. i] = JY.Person[clone_choice]["�츳�⹦" .. i]
                end

                JY.Person[0]["�츳�ڹ�"] = JY.Person[clone_choice]["�츳�ڹ�"]
                JY.Person[0]["�츳�Ṧ"] = JY.Person[clone_choice]["�츳�Ṧ"]
                JY.Person[0]["����ֽ�"] = JY.Person[clone_choice]["����ֽ�"]
                JY.Person[0]["���2"] = JY.Person[clone_choice]["���2"]
                JY.Person[0]["��ɫָ��"] = JY.Person[clone_choice]["��ɫָ��"]
                JY.Person[0]["��ɫָ��"] = JY.Person[clone_choice]["��ɫָ��"]
                JY.Person[0]["ȭ���ɳ�"] = JY.Person[clone_choice]["ȭ���ɳ�"]
                JY.Person[0]["ָ���ɳ�"] = JY.Person[clone_choice]["ָ���ɳ�"]
                JY.Person[0]["�����ɳ�"] = JY.Person[clone_choice]["�����ɳ�"]
                JY.Person[0]["�����ɳ�"] = JY.Person[clone_choice]["�����ɳ�"]
                JY.Person[0]["���ųɳ�"] = JY.Person[clone_choice]["���ųɳ�"]
                for i = 1, 5 do
                    JY.Person[0]['�츳' .. i] = JY.Person[clone_choice]['�츳' .. i]
                    -- lib.Debug(i..'���������츳 = '..JY.Person[0]['�츳'..i])
                end

                -- ������ǧ��ͷ�����
                if JY.Base["����"] == 617 then
                    JY.Person[0]["ͷ�����"] = 353
                    JY.Person[0]["������"] = 353
                    JY.Person[0]["���ж���֡��3"] = 24
                    JY.Person[0]["���ж����ӳ�3"] = 22
                    JY.Person[0]["�书��Ч�ӳ�3"] = 22
                end
                -- �������ܳ���
                if JY.Base["����"] == 27 then
                    -- instruct_32(349,-1)
                end
                -- ���������ʼ��
                if JY.Base["����"] == 58 then
                    JY.Scene[19]["��������"] = 1
                    JY.Scene[101]["��������"] = 1
                    JY.Scene[36]["��������"] = 1
                    JY.Scene[28]["��������"] = 1
                    JY.Scene[93]["��������"] = 1
                    JY.Scene[105]["��������"] = 1
                    null(18, 6)
                    null(70, 87)
                    addevent(70, 95, 0, 4188, 3, 0)
                end
                -- ��ʼ����
                if JY.Base["����"] == 592 then
                    JY.Person[0]["�书2"] = 0
                    JY.Person[0]["�书�ȼ�2"] = 0
                    JY.Person[0]["ˣ������"] = 30 + zm
                    JY.Person[0]["�������"] = 30 + zm
                    JY.Person[0]["ָ������"] = 30 + zm
                    JY.Person[0]["ȭ�ƹ���"] = 30 + zm
                end

                if JY.Base["����"] == 721 then
                    JY.Person[0]["ˣ������"] = 50
                    JY.Person[0]["�������"] = 50
                    JY.Person[0]["ָ������"] = 50
                    JY.Person[0]["ȭ�ƹ���"] = 50
                    JY.Person[0]["��������"] = 200
                end
                Hp_Max(0)
                Mp_Max(0)
                break
            end
        elseif X == VK_DOWN then
            if lb == 1 then
                rw = 1
                rw1 = 0
                tb = tb + 1
                if tb > 14 then
                    tb = 1
                end
            elseif lb == 2 then
                fy = fy + 1
                if fy > fymax then
                    fy = fymax
                end
            end
        elseif X == VK_UP then
            if lb == 1 then
                rw = 1
                rw1 = 0
                tb = tb - 1
                if tb < 1 then
                    tb = 14
                end
            elseif lb == 2 then
                fy = fy - 1
                if fy < 0 then
                    fy = 0
                end
            end
        elseif X == VK_LEFT then
            dh = 0
            if lb == 1 then
                if tb < 8 then
                    tb = tb + 7
                end
            elseif lb == 2 then
                if rw > 1 then
                    rw = rw - 1
                elseif rw1 > 0 then
                    rw1 = rw1 - 1
                end
            end
        elseif X == VK_RIGHT then
            dh = 0
            if lb == 1 then
                if tb > 7 then
                    tb = tb - 7
                end
            elseif lb == 2 then
                if #menu2[tb] <= 6 then
                    if rw < #menu2[tb] then
                        rw = rw + 1
                    end
                else
                    if rw + rw1 < #menu2[tb] then
                        if rw < 6 then
                            rw = rw + 1
                        else
                            rw1 = rw1 + 1
                        end
                    end
                end
            end
        elseif X == VK_PGUP or ktype == 6 then
            PlayWavE(77)
            dh = 0
            if lb == 2 then
                if rw > 1 then
                    rw = rw - 1
                elseif rw1 > 0 then
                    rw1 = rw1 - 1
                end
            end
        elseif X == VK_PGDN or ktype == 7 then
            PlayWavE(77)
            dh = 0
            if lb == 2 then
                if #menu2[tb] <= 6 then
                    if rw < #menu2[tb] then
                        rw = rw + 1
                    end
                else
                    if rw + rw1 < #menu2[tb] then
                        if rw < 6 then
                            rw = rw + 1
                        else
                            rw1 = rw1 + 1
                        end
                    end
                end
            end
        else
            local cot = false
            local cot1 = false
            for i = 1, #tsmenu do
                local tsbx, tsby = bx * 1225, by * 195 -- ��ʼ����
                if i > 7 then
                    tsbx, tsby = bx * 75, by * 195 -- ��ʼ����
                end
                local tsk = by * 68 * (i - 1)
                if i > 7 then
                    tsk = by * 68 * (i - 8)
                end
                if mx >= tsbx and mx <= tsbx + tsw and my >= tsby + tsk and my <= tsby + tsk + tsh then
                    dh = 0
                    rw = 1
                    rw1 = 0
                    tb = i
                    cot = true
                    break
                end
            end
            if ktype == 3 and lb == 1 then
                lb = 2
            end
            if lb == 2 then
                for i = 1, 6 do
                    local rwx, rwy = bx * 276, by * 165
                    local rww, rwh = bx * 126, by * 172
                    local rwk = bx * (i - 1) * 140
                    local ii = rw1 + i
                    if menu2[tb][ii] ~= nil then
                        if mx >= rwx + rwk and mx < rwx + rwk + rww and my >= rwy and my <= rwy + rwh then
                            dh = 0
                            rw = i
                            cot1 = true
                            break
                        end
                    end
                end
                if cot1 == true and ktype == 3 then
                    local zm = JY.Base["��Ŀ"]
                    local nd = JY.Base["�Ѷ�"]
                    local addkfnum
                    JY.Base["����"] = menu2[tb][rw + rw1]
                    local clone_choice = JY.Base["����"]
                    JY.Person[0]["����"] = JY.Person[clone_choice]["����"]
                    JY.Person[0]["ͷ�����"] = JY.Person[clone_choice]["ͷ�����"]
                    JY.Person[0]["������"] = JY.Person[clone_choice]["������"]
                    JY.Person[0]["����"] = JY.Person[clone_choice]["����"]
                    if JY.Person[0]["����"] < 5 then
                        JY.Person[0]["����"] = 5
                    end
                    if JY.Person[0]["����"] > 12 then
                        JY.Person[0]["����"] = 12
                    end
                    JY.Person[0]["����"] = JY.Person[clone_choice]["����"]
                    JY.Person[0]["���"] = JY.Person[clone_choice]["���"]
                    JY.Person[0]["�Ա�"] = JY.Person[clone_choice]["�Ա�"]

                    JY.Person[0]["����"] = -1
                    JY.Person[0]["����"] = -1
                    JY.Person[0]["����"] = -1
                    for i = 1, 2 do
                        JY.Person[0]["�书" .. i] = JY.Person[clone_choice]["�书" .. i]
                        JY.Person[0]["�书�ȼ�" .. i] = JY.Person[clone_choice]["�书�ȼ�" .. i]
                    end
                    CC.kaijuwugong1 = JY.Person[0]["�书1"]
                    CC.kaijuwugong2 = JY.Person[0]["�书2"]
                    CC.kaijuwugong3 = JY.Person[0]["�书3"]
                    CC.kaijuwugongx1 = JY.Person[0]["�书�ȼ�1"]
                    CC.kaijuwugongx2 = JY.Person[0]["�书�ȼ�2"]
                    CC.kaijuwugongx3 = JY.Person[0]["�书�ȼ�3"]
                    for i = 1, 5 do
                        JY.Person[0]["���ж���֡��" .. i] = JY.Person[clone_choice]["���ж���֡��" .. i]
                        JY.Person[0]["���ж����ӳ�" .. i] = JY.Person[clone_choice]["���ж����ӳ�" .. i]
                        JY.Person[0]["�书��Ч�ӳ�" .. i] = JY.Person[clone_choice]["�书��Ч�ӳ�" .. i]
                    end
                    -- ���빥�������55
                    JY.Person[0]["������"] = limitX(JY.Person[clone_choice]["������"] / 4, 55, 75)
                    JY.Person[0]["������"] = limitX(JY.Person[clone_choice]["������"] / 4, 55, 75)
                    JY.Person[0]["�Ṧ"] = limitX(JY.Person[clone_choice]["�Ṧ"] / 4, 55, 75)
                    -- ҽ���ö��ⶾ���30
                    JY.Person[0]["ҽ������"] = limitX(JY.Person[clone_choice]["ҽ������"], 30)
                    JY.Person[0]["�ö�����"] = limitX(JY.Person[clone_choice]["�ö�����"], 30)
                    JY.Person[0]["�ⶾ����"] = limitX(JY.Person[clone_choice]["�ⶾ����"], 30)
                    JY.Person[0]["��������"] = limitX(JY.Person[clone_choice]["��������"], 30) + zm
                    JY.Person[0]["��������"] = JY.Person[clone_choice]["��������"]
                    JY.Person[0]["�����ڹ�"] = 0
                    JY.Person[0]["�����Ṧ"] = 0
                    JY.Person[0]["���˾���"] = 0
                    if CC.PersonExit[clone_choice] ~= nil then
                        JY.Person[0]["ȭ�ƹ���"] = limitX(JY.Person[clone_choice]["ȭ�ƹ���"], 30, 70) + zm
                        JY.Person[0]["ָ������"] = limitX(JY.Person[clone_choice]["ָ������"], 30, 70) + zm
                        JY.Person[0]["��������"] = limitX(JY.Person[clone_choice]["��������"], 30, 70) + zm
                        JY.Person[0]["ˣ������"] = limitX(JY.Person[clone_choice]["ˣ������"], 30, 70) + zm
                        JY.Person[0]["�������"] = limitX(JY.Person[clone_choice]["�������"], 30, 70) + zm
                    else
                        JY.Person[0]["ȭ�ƹ���"] = limitX(JY.Person[clone_choice]["ȭ�ƹ���"] / 3, 30, 70) + zm
                        JY.Person[0]["ָ������"] = limitX(JY.Person[clone_choice]["ָ������"] / 3, 30, 70) + zm
                        JY.Person[0]["��������"] = limitX(JY.Person[clone_choice]["��������"] / 3, 30, 70) + zm
                        JY.Person[0]["ˣ������"] = limitX(JY.Person[clone_choice]["ˣ������"] / 3, 30, 70) + zm
                        JY.Person[0]["�������"] = limitX(JY.Person[clone_choice]["�������"] / 3, 30, 70) + zm
                    end
                    JY.Person[0]["��ѧ��ʶ"] = JY.Person[clone_choice]["��ѧ��ʶ"]
                    JY.Person[0]["��������"] = JY.Person[clone_choice]["��������"]
                    for i = 1, 5 do
                        JY.Person[0]["�ؼ�" .. i] = JY.Person[clone_choice]["�ؼ�" .. i]
                    end
                    for i = 1, 4 do
                        JY.Person[0]["Я����Ʒ" .. i] = JY.Person[clone_choice]["Я����Ʒ" .. i]
                        JY.Person[0]["Я����Ʒ����" .. i] = JY.Person[clone_choice]["Я����Ʒ����" .. i]
                    end

                    for i = 1, 2 do
                        JY.Person[0]["�츳�⹦" .. i] = JY.Person[clone_choice]["�츳�⹦" .. i]
                    end
                    JY.Person[0]["�츳�ڹ�"] = JY.Person[clone_choice]["�츳�ڹ�"]
                    JY.Person[0]["�츳�Ṧ"] = JY.Person[clone_choice]["�츳�Ṧ"]
                    JY.Person[0]["����ֽ�"] = JY.Person[clone_choice]["����ֽ�"]
                    JY.Person[0]["���2"] = JY.Person[clone_choice]["���2"]
                    JY.Person[0]["��ɫָ��"] = JY.Person[clone_choice]["��ɫָ��"]
                    JY.Person[0]["ȭ���ɳ�"] = JY.Person[clone_choice]["ȭ���ɳ�"]
                    JY.Person[0]["ָ���ɳ�"] = JY.Person[clone_choice]["ָ���ɳ�"]
                    JY.Person[0]["�����ɳ�"] = JY.Person[clone_choice]["�����ɳ�"]
                    JY.Person[0]["�����ɳ�"] = JY.Person[clone_choice]["�����ɳ�"]
                    JY.Person[0]["���ųɳ�"] = JY.Person[clone_choice]["���ųɳ�"]
                    for i = 1, 5 do
                        JY.Person[0]['�츳' .. i] = JY.Person[clone_choice]['�츳' .. i]
                        -- lib.Debug(i..'���������츳 = '..JY.Person[0]['�츳'..i])
                    end
                    -- ������ǧ��ͷ�����
                    if JY.Base["����"] == 617 then
                        JY.Person[0]["ͷ�����"] = 353
                        JY.Person[0]["������"] = 353
                        JY.Person[0]["���ж���֡��3"] = 24
                        JY.Person[0]["���ж����ӳ�3"] = 22
                        JY.Person[0]["�书��Ч�ӳ�3"] = 22
                    end
                    -- �������ܳ���
                    if JY.Base["����"] == 27 then
                        -- instruct_32(349,-1)
                    end
                    -- ���������ʼ��
                    if JY.Base["����"] == 58 then
                        JY.Scene[19]["��������"] = 1
                        JY.Scene[101]["��������"] = 1
                        JY.Scene[36]["��������"] = 1
                        JY.Scene[28]["��������"] = 1
                        JY.Scene[93]["��������"] = 1
                        JY.Scene[105]["��������"] = 1
                        null(18, 6)
                        null(70, 87)
                        addevent(70, 95, 0, 4188, 3, 0)
                    end
                    -- ��ʼ����
                    if JY.Base["����"] == 592 then
                        JY.Person[0]["�书2"] = 0
                        JY.Person[0]["�书�ȼ�2"] = 0
                        JY.Person[0]["ˣ������"] = 30 + zm
                        JY.Person[0]["�������"] = 30 + zm
                        JY.Person[0]["ָ������"] = 30 + zm
                        JY.Person[0]["ȭ�ƹ���"] = 30 + zm
                    end
                    if JY.Base["����"] == 721 then
                        JY.Person[0]["ˣ������"] = 50
                        JY.Person[0]["�������"] = 50
                        JY.Person[0]["ָ������"] = 50
                        JY.Person[0]["ȭ�ƹ���"] = 50
                        JY.Person[0]["��������"] = 200
                    end
                    Hp_Max(0)
                    Mp_Max(0)
                    break
                end
            end
        end
    end
end

-- �Ϲ���������
function TSzjmenu()
    local bx, by = CC.WX, CC.HY
    local size = CC.DefaultFont
    local menu2 =
        {{752, 497, 578, 579, 652, 500, 498, 637, 577, 635, 501, 596, 504, 505, 507, 721, 546, 610, 514, 515} -- ����
        }
    local tb = 1
    local lb = 1
    local rw, rw1 = 1, 0
    local dh = 0
    local fy, fymax, star = 0, 0, 1
    -- ����
    local cx, ts, zj, xb = 0, 0, 0, 0
    local tbx, tby = bx * 1225, by * 195
    local tsw, tsh = bx * 54, by * 45
    while true do
        if JY.Restart == 1 then
            break
        end
        -- ������棬��Ϊ�˵�������ѭ����״̬��������ʾ����ǰ����Ҫ���֮ǰ�Ļ��棬������ͼ���޵���
        ClsN()
        ---------------
        lib.LoadPNG(91, 24 * 2, -1, -1, 1)
        lib.LoadPNG(91, 25 * 2, -1, -1, 1)
        lib.LoadPNG(91, 26 * 2, -1, -1, 1)
        local function inmenu()
            local zm = JY.Base["��Ŀ"]
            local nd = JY.Base["�Ѷ�"]
            local addkfnum

            local clone_choice = JY.Base["����"]
            JY.Person[0]["����"] = JY.Person[clone_choice]["����"]
            JY.Person[0]["ͷ�����"] = JY.Person[clone_choice]["ͷ�����"]
            JY.Person[0]["������"] = JY.Person[clone_choice]["������"]
            JY.Person[0]["����"] = JY.Person[clone_choice]["����"]
            if JY.Person[0]["����"] < 5 then
                JY.Person[0]["����"] = 5
            end
            if JY.Person[0]["����"] > 12 then
                JY.Person[0]["����"] = 12
            end
            JY.Person[0]["����"] = JY.Person[clone_choice]["����"]
            JY.Person[0]["���"] = JY.Person[clone_choice]["���"]
            JY.Person[0]["�Ա�"] = JY.Person[clone_choice]["�Ա�"]

            JY.Person[0]["����"] = -1
            JY.Person[0]["����"] = -1
            JY.Person[0]["����"] = -1
            for i = 1, 2 do
                JY.Person[0]["�书" .. i] = JY.Person[clone_choice]["�书" .. i]
                JY.Person[0]["�书�ȼ�" .. i] = JY.Person[clone_choice]["�书�ȼ�" .. i]
            end
            CC.kaijuwugong1 = JY.Person[0]["�书1"]
            CC.kaijuwugong2 = JY.Person[0]["�书2"]
            CC.kaijuwugong3 = JY.Person[0]["�书3"]
            CC.kaijuwugongx1 = JY.Person[0]["�书�ȼ�1"]
            CC.kaijuwugongx2 = JY.Person[0]["�书�ȼ�2"]
            CC.kaijuwugongx3 = JY.Person[0]["�书�ȼ�3"]
            for i = 1, 5 do
                JY.Person[0]["���ж���֡��" .. i] = JY.Person[clone_choice]["���ж���֡��" .. i]
                JY.Person[0]["���ж����ӳ�" .. i] = JY.Person[clone_choice]["���ж����ӳ�" .. i]
                JY.Person[0]["�书��Ч�ӳ�" .. i] = JY.Person[clone_choice]["�书��Ч�ӳ�" .. i]
            end

            -- ���빥�������55
            JY.Person[0]["������"] = limitX(JY.Person[clone_choice]["������"] / 4, 55, 75)
            JY.Person[0]["������"] = limitX(JY.Person[clone_choice]["������"] / 4, 55, 75)
            JY.Person[0]["�Ṧ"] = limitX(JY.Person[clone_choice]["�Ṧ"] / 4, 55, 75)
            -- ҽ���ö��ⶾ���30
            JY.Person[0]["ҽ������"] = limitX(JY.Person[clone_choice]["ҽ������"], 30)
            JY.Person[0]["�ö�����"] = limitX(JY.Person[clone_choice]["�ö�����"], 30)
            JY.Person[0]["�ⶾ����"] = limitX(JY.Person[clone_choice]["�ⶾ����"], 30)
            JY.Person[0]["��������"] = limitX(JY.Person[clone_choice]["��������"], 30) + zm
            JY.Person[0]["��������"] = JY.Person[clone_choice]["��������"]
            JY.Person[0]["�����ڹ�"] = 0
            JY.Person[0]["�����Ṧ"] = 0
            JY.Person[0]["���˾���"] = 0
            JY.Person[0]["����ʹ��"] = 0

            if CC.PersonExit[clone_choice] ~= nil then

                JY.Person[0]["ȭ�ƹ���"] = limitX(JY.Person[clone_choice]["ȭ�ƹ���"], 30, 70) + zm
                JY.Person[0]["ָ������"] = limitX(JY.Person[clone_choice]["ָ������"], 30, 70) + zm
                JY.Person[0]["��������"] = limitX(JY.Person[clone_choice]["��������"], 30, 70) + zm
                JY.Person[0]["ˣ������"] = limitX(JY.Person[clone_choice]["ˣ������"], 30, 70) + zm
                JY.Person[0]["�������"] = limitX(JY.Person[clone_choice]["�������"], 30, 70) + zm
            else

                JY.Person[0]["ȭ�ƹ���"] = limitX(JY.Person[clone_choice]["ȭ�ƹ���"] / 3, 30, 70) + zm
                JY.Person[0]["ָ������"] = limitX(JY.Person[clone_choice]["ָ������"] / 3, 30, 70) + zm
                JY.Person[0]["��������"] = limitX(JY.Person[clone_choice]["��������"] / 3, 30, 70) + zm
                JY.Person[0]["ˣ������"] = limitX(JY.Person[clone_choice]["ˣ������"] / 3, 30, 70) + zm
                JY.Person[0]["�������"] = limitX(JY.Person[clone_choice]["�������"] / 3, 30, 70) + zm
            end

            JY.Person[0]["��ѧ��ʶ"] = JY.Person[clone_choice]["��ѧ��ʶ"]
            JY.Person[0]["��������"] = JY.Person[clone_choice]["��������"]
            for i = 1, 5 do
                JY.Person[0]["�ؼ�" .. i] = JY.Person[clone_choice]["�ؼ�" .. i]
            end

            for i = 1, 4 do
                JY.Person[0]["Я����Ʒ" .. i] = JY.Person[clone_choice]["Я����Ʒ" .. i]
                JY.Person[0]["Я����Ʒ����" .. i] = JY.Person[clone_choice]["Я����Ʒ����" .. i]
            end

            for i = 1, 2 do
                JY.Person[0]["�츳�⹦" .. i] = JY.Person[clone_choice]["�츳�⹦" .. i]
            end

            JY.Person[0]["�츳�ڹ�"] = JY.Person[clone_choice]["�츳�ڹ�"]
            JY.Person[0]["�츳�Ṧ"] = JY.Person[clone_choice]["�츳�Ṧ"]
            JY.Person[0]["����ֽ�"] = JY.Person[clone_choice]["����ֽ�"]
            JY.Person[0]["���2"] = JY.Person[clone_choice]["���2"]
            JY.Person[0]["��ɫָ��"] = JY.Person[clone_choice]["��ɫָ��"]
            JY.Person[0]["ȭ���ɳ�"] = JY.Person[clone_choice]["ȭ���ɳ�"]
            JY.Person[0]["ָ���ɳ�"] = JY.Person[clone_choice]["ָ���ɳ�"]
            JY.Person[0]["�����ɳ�"] = JY.Person[clone_choice]["�����ɳ�"]
            JY.Person[0]["�����ɳ�"] = JY.Person[clone_choice]["�����ɳ�"]
            JY.Person[0]["���ųɳ�"] = JY.Person[clone_choice]["���ųɳ�"]
            for i = 1, 5 do
                JY.Person[0]['�츳' .. i] = JY.Person[clone_choice]['�츳' .. i]
                -- lib.Debug(i..'���������츳 = '..JY.Person[0]['�츳'..i])
            end
            -- ������ǧ��ͷ�����
            if JY.Base["����"] == 617 then
                JY.Person[0]["ͷ�����"] = 353
                JY.Person[0]["������"] = 353
                JY.Person[0]["���ж���֡��3"] = 24
                JY.Person[0]["���ж����ӳ�3"] = 22
                JY.Person[0]["�书��Ч�ӳ�3"] = 22
            end
            -- �������ܳ���
            if JY.Base["����"] == 27 then
                -- instruct_32(349,-1)
            end
            -- ���������ʼ��
            if JY.Base["����"] == 58 then
                JY.Scene[19]["��������"] = 1
                JY.Scene[101]["��������"] = 1
                JY.Scene[36]["��������"] = 1
                JY.Scene[28]["��������"] = 1
                JY.Scene[93]["��������"] = 1
                JY.Scene[105]["��������"] = 1
                null(18, 6)
                null(70, 87)
                addevent(70, 95, 0, 4188, 3, 0)
            end
            -- ��ʼ����
            if JY.Base["����"] == 592 then
                JY.Person[0]["�书2"] = 0
                JY.Person[0]["�书�ȼ�2"] = 0
                JY.Person[0]["ˣ������"] = 30 + zm
                JY.Person[0]["�������"] = 30 + zm
                JY.Person[0]["ָ������"] = 30 + zm
                JY.Person[0]["ȭ�ƹ���"] = 30 + zm
            end

            if JY.Base["����"] == 721 then
                JY.Person[0]["ˣ������"] = 50
                JY.Person[0]["�������"] = 50
                JY.Person[0]["ָ������"] = 50
                JY.Person[0]["ȭ�ƹ���"] = 50
                JY.Person[0]["��������"] = 200
            end
            Hp_Max(0)
            Mp_Max(0)
        end
        if lb == 1 then
            for i = 1, 6 do
                local cl = C_WHITE
                local ii = rw1 + i
                if menu2[tb][ii] ~= nil then
                    local id = menu2[tb][ii]
                    local pic = JY.Person[id]["������"]
                    local name = JY.Person[id]["����"]
                    local rwx, rwy = bx * 276, by * 165
                    local rww, rwh = bx * 140, by * 110
                    if rw == i then
                        lib.LoadPNG(90, pic * 2, bx * 276, by * 410, 1, 0, 90)
                        lib.LoadPNG(91, 12 * 2, rwx + (rw - 1) * rww - bx * 5, rwy - by * 10, 1, 0, 116)
                        cl = C_RED
                        local zs = 0
                        local dl = 0
                        for j = 1, 5 do
                            if JY.Person[id]['���ж���֡��' .. j] > 0 then
                                if j > 1 then
                                    zs = JY.Person[id]['���ж���֡��' .. j]
                                    break
                                end
                                dl = dl + JY.Person[id]['���ж���֡��' .. j] * 4
                            end
                        end
                        lib.PicLoadCache(JY.Person[id]["ͷ�����"] + 101, (dl + dh + zs * 3) * 2, bx * 290, by * 700)
                        dh = dh + 1
                        if dh == zs then
                            dh = 0
                        end
                        local me = {}
                        local row = 0
                        local maxh = 9
                        if TFJS[id] ~= nil then
                            local row = 0
                            local maxh = 15
                            for i = 1, #TFJS[id] do
                                me[#me + 1] = TFJS[id][i]
                                if i == #TFJS[id] then
                                    me[#me + 1] = "��"
                                end
                            end
                        end
                        if CC.PTF[id] ~= nil then
                            for i, v in pairs(CC.PTF[id]) do
                                if v == 1 then
                                    if PersonTF(id, i) == false then
                                        SetTF(id, i, 1)
                                    end
                                end
                            end
                        end
                        for i = 1, 5 do
                            if JY.Person[id]['�츳' .. i] > 0 then
                                local tf = JY.Person[id]['�츳' .. i]
                                if CC.PTFSM[tf] ~= nil then
                                    me[#me + 1] = '��' .. CC.PTFSM[tf][1]
                                    me[#me + 1] = '��' .. CC.PTFSM[tf][2]
                                    me[#me + 1] = "��"
                                end
                            end
                        end
                        for i = 1, #ZJZSJS do
                            me[#me + 1] = ZJZSJS[i]
                            if i == #ZJZSJS then
                                me[#me + 1] = "��"
                            end
                        end
                        for i = star, #me do
                            local tfstr = me[i]
                            local h = 0

                            if string.sub(tfstr, 1, 2) == "��" then
                                row = row + 1
                            else
                                h = tjm(bx * 550, by * 420 + size * 0.8 * (row - fy), tfstr, C_WHITE, size * 0.8, math.modf((bx * 554) / size / 0.8) - 1, size * 0.8, fy - row, maxh + 1 - row + fy)
                            end
                            row = row + h
                        end

                        if row > maxh then
                            fymax = limitX(row - maxh - 1, 0)
                        else
                            fymax = 0
                        end
                    end

                    lib.LoadPNG(91, 39 * 2, rwx + (i - 1) * rww - bx * 5, rwy, 1, 0, 50)
                    lib.LoadPNG(1, pic * 2, rwx + (i - 1) * rww, rwy, 1, 0, 90)

                    lib.DrawStr(rwx + size * 1.8 + (i - 1) * rww - string.len(name) * size / 4, rwy + size * 3.8, name,cl, size, CONFIG.CurrentPath .. "FONT/0.ttf", 0, 0)
                end
            end
        end
        -- ��ʾ����
        ShowScreen()
        -- ѭ���ļ������ֵ���⣩
        lib.Delay(CC.Frame)
        -- X�Ǽ��̲�����ktype����������ktype = 3 ���������4�����Ҽ���6�����ϣ�7������
        local X, ktype, mx, my = lib.GetKey()
        if X == VK_ESCAPE or ktype == 4 then
            if lb == 1 then
                return Moshixz()
                -- break
            end
        elseif X == VK_SPACE or X == VK_RETURN then
            if lb == 1 then
                JY.Base["����"] = menu2[tb][rw + rw1]
                inmenu()
                break
            end
        elseif X == VK_DOWN then
            fy = fy + 1
            if fy > fymax then
                fy = fymax
            end
        elseif X == VK_UP then
            fy = fy - 1
            if fy < 0 then
                fy = 0
            end
        elseif X == VK_LEFT then
            dh = 0
            if rw > 1 then
                rw = rw - 1
            elseif rw1 > 0 then
                rw1 = rw1 - 1
            end
        elseif X == VK_RIGHT then
            dh = 0
            if #menu2[tb] <= 6 then
                if rw < #menu2[tb] then
                    rw = rw + 1
                end
            else
                if rw + rw1 < #menu2[tb] then
                    if rw < 6 then
                        rw = rw + 1
                    else
                        rw1 = rw1 + 1
                    end
                end
            end
        elseif X == VK_PGUP or ktype == 6 then
            dh = 0
            PlayWavE(77)
            if rw > 1 then
                rw = rw - 1
            elseif rw1 > 0 then
                rw1 = rw1 - 1
            end
        elseif X == VK_PGDN or ktype == 7 then
            dh = 0
            PlayWavE(77)
            if lb == 1 then
                if #menu2[tb] <= 6 then
                    if rw < #menu2[tb] then
                        rw = rw + 1
                    end
                else
                    if rw + rw1 < #menu2[tb] then
                        if rw < 6 then
                            rw = rw + 1
                        else
                            rw1 = rw1 + 1
                        end
                    end
                end
            end
        elseif X >= VK_A and X <= VK_Z then
            YC_ZhangJiaHui(X)
            YC_GUXIZHAOWSC(X)
        else
            local cot = false
            local cot1 = false
            if lb == 1 then
                for i = 1, 6 do
                    local rwx, rwy = bx * 276, by * 165
                    local rww, rwh = bx * 126, by * 172
                    local rwk = bx * (i - 1) * 140
                    local ii = rw1 + i
                    if menu2[tb][ii] ~= nil then
                        if mx >= rwx + rwk and mx < rwx + rwk + rww and my >= rwy and my <= rwy + rwh then
                            dh = 0
                            rw = i
                            cot1 = true
                            break
                        end
                    end
                end
                if cot1 == true and ktype == 3 then
                    JY.Base["����"] = menu2[tb][rw + rw1]
                    inmenu()
                    break
                end
            end
        end
        if YC.ZJH == 6 then
            cx = 757
            JY.Base["����"] = 757
            YC.ZJH = 0
            inmenu()
            break
        end
        if YC.GXZ == 11 then
            cx = 752
            JY.Base["����"] = 752
            YC.GXZ = 0
            inmenu()
            break
        end

    end
end

function tjm(x, y, str, color, size, xnum, hnum, first, last, ttf)
    if xnum == nil then
        xnum = #str
    end
    ttf = ttf or CC.FontName
    if x == -1 then
        local ll = #str;
        local w = size * ll / 2 + 2 * CC.MenuBorderPixel;
        x = (CC.ScreenW - size / 2 * ll - 2 * CC.MenuBorderPixel) / 2;
    end
    if y == -1 then
        y = (CC.ScreenH - size - 2 * CC.MenuBorderPixel) / 2
    end

    local ynum = size
    local T2 = {};
    T2["��"] = PinkRed
    T2["��"] = LimeGreen
    T2["��"] = C_BLACK
    T2["��"] = C_WHITE
    T2["��"] = C_ORANGE
    T2["��"] = M_DeepSkyBlue
    T2["��"] = Violet
    T2['��'] = C_GOLD
    T2['��'] = RGB(188, 189, 171)
    local cx, cy = 0, 0;
    -- local sid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
    while string.len(str) >= 1 do
        if JY.Restart == 1 then
            break
        end
        local try = string.sub(str, 1, 1)
        local control = false;

        local hs = size + CC.RowPixel
        if hnum ~= nil then
            hs = hnum
        end
        if string.byte(try) > 127 then -- ����
            local s = string.sub(str, 1, 2);
            str = string.sub(str, 3, -1);

            if T2[s] ~= nil then
                color = T2[s]
                control = true;
            end

            if not control then
                if s == '*' then
                    -- cy = cy + 1 
                    --  cx = 0
                else
                    if first ~= nil then
                        if last ~= nil then
                            if cy >= first and cy < last then
                                lib.DrawStr(x + size * cx, y + (hs) * cy, s, color, size, ttf, CC.SrcCharSet,
                                    CC.OSCharSet);
                            end
                        else
                            if cy >= first then
                                lib.DrawStr(x + size * cx, y + (hs) * cy, s, color, size, ttf, CC.SrcCharSet,
                                    CC.OSCharSet);
                            end
                        end
                    else
                        if last ~= nil then
                            if cy < last then
                                lib.DrawStr(x + size * cx, y + (hs) * cy, s, color, size, ttf, CC.SrcCharSet,
                                    CC.OSCharSet);
                            end
                        else
                            lib.DrawStr(x + size * cx, y + (hs) * cy, s, color, size, ttf, CC.SrcCharSet, CC.OSCharSet);
                        end
                    end
                    cx = cx + 1;
                end
            end

        else
            local s = try
            str = string.sub(str, 2, -1);
            if s == '��' or s == '*' then
                cy = cy + 1
                cx = 0
            else
                if first ~= nil then
                    if last ~= nil then
                        if cy >= first and cy < last then
                            lib.DrawStr(x + size * cx, y + (hs) * cy, s, color, size, ttf, CC.SrcCharSet, CC.OSCharSet);
                        end
                    else
                        if cy >= first then
                            lib.DrawStr(x + size * cx, y + (hs) * cy, s, color, size, ttf, CC.SrcCharSet, CC.OSCharSet);
                        end
                    end
                else
                    if last ~= nil then
                        if cy < last then
                            lib.DrawStr(x + size * cx, y + (hs) * cy, s, color, size, ttf, CC.SrcCharSet, CC.OSCharSet);
                        end
                    else
                        lib.DrawStr(x + size * cx, y + (hs) * cy, s, color, size, ttf, CC.SrcCharSet, CC.OSCharSet);
                    end
                end
                cx = cx + 1;
            end

        end

        if not control then

            if cx > xnum then
                cx = 0;
                -- ����������ٽ�����һ��
                if string.len(str) >= 1 then
                    cy = cy + 1;
                end
            end
        end

    end

    -- lib.FreeSur(sid);
    return cy + 1
end

function tjmsave(id)
    CC.TJMSJ = {}
    CC.TJM = 0

    for i = 1, #CC.TXM do
        CC.TJMSJ[#CC.TJMSJ + 1] = CC.TX[CC.TXM[i]]
        CC.TJM = CC.TJM + 1
    end

    local tg = 0
    for i, v in pairs(CC.TG) do
        tg = tg + 1
    end

    CC.TJMSJ[#CC.TJMSJ + 1] = tg
    CC.TJM = CC.TJM + 1

    for i, v in pairs(CC.TG) do
        CC.TJMSJ[#CC.TJMSJ + 1] = i
        CC.TJM = CC.TJM + 1
    end

    --������־
    CC.TJMSJ[#CC.TJMSJ + 1] = #CC.JHtxt
    CC.TJM = CC.TJM + 1
    for i = 1, #CC.JHtxt do
        CC.TJMSJ[#CC.TJMSJ + 1] = CC.JHtxt[i]
        CC.TJM = CC.TJM + 1
    end


    --��������
    CC.TJMSJ[#CC.TJMSJ + 1] = #CC.JHtxt_ID
    CC.TJM = CC.TJM + 1
    for i = 1, #CC.JHtxt_ID do
        CC.TJMSJ[#CC.TJMSJ + 1] = CC.JHtxt_ID[i]
        CC.TJM = CC.TJM + 1
    end

    --��������
    CC.TJMSJ[#CC.TJMSJ + 1] = #CC.JHtxt_SCENE
    CC.TJM = CC.TJM + 1
    for i = 1, #CC.JHtxt_SCENE do
        CC.TJMSJ[#CC.TJMSJ + 1] = CC.JHtxt_SCENE[i]
        CC.TJM = CC.TJM + 1
    end

    --������������
    CC.TJMSJ[#CC.TJMSJ + 1] = #CC.JHtxt_ID1
    CC.TJM = CC.TJM + 1
    for i = 1, #CC.JHtxt_ID1 do
        CC.TJMSJ[#CC.TJMSJ + 1] = CC.JHtxt_ID1[i]
        CC.TJM = CC.TJM + 1
    end

    --�������ӵ���������
    CC.TJMSJ[#CC.TJMSJ + 1] = #CC.JHtxt_PSX
    CC.TJM = CC.TJM + 1
    for i = 1, #CC.JHtxt_PSX do
        CC.TJMSJ[#CC.TJMSJ + 1] = CC.JHtxt_PSX[i]
        CC.TJM = CC.TJM + 1
    end

    --�����������Եĵ���
    CC.TJMSJ[#CC.TJMSJ + 1] = #CC.JHtxt_POINTS
    CC.TJM = CC.TJM + 1
    for i = 1, #CC.JHtxt_POINTS do
        CC.TJMSJ[#CC.TJMSJ + 1] = CC.JHtxt_POINTS[i]
        CC.TJM = CC.TJM + 1
    end

    --������
    CC.TJMSJ[#CC.TJMSJ + 1] = #CC.JHtxt_YEAR
    CC.TJM = CC.TJM + 1
    for i = 1, #CC.JHtxt_YEAR do
        CC.TJMSJ[#CC.TJMSJ + 1] = CC.JHtxt_YEAR[i]
        CC.TJM = CC.TJM + 1
    end

    --������
    CC.TJMSJ[#CC.TJMSJ + 1] = #CC.JHtxt_MONTH
    CC.TJM = CC.TJM + 1
    for i = 1, #CC.JHtxt_MONTH do
        CC.TJMSJ[#CC.TJMSJ + 1] = CC.JHtxt_MONTH[i]
        CC.TJM = CC.TJM + 1
    end

    --������
    CC.TJMSJ[#CC.TJMSJ + 1] = #CC.JHtxt_DAY
    CC.TJM = CC.TJM + 1
    for i = 1, #CC.JHtxt_DAY do
        CC.TJMSJ[#CC.TJMSJ + 1] = CC.JHtxt_DAY[i]
        CC.TJM = CC.TJM + 1
    end

    CC.TJMSJ[#CC.TJMSJ + 1] = #CC.TGJL
    CC.TJM = CC.TJM + 1
    for i = 1, #CC.TGJL do
        CC.TJMSJ[#CC.TJMSJ + 1] = CC.TGJL[i]
        CC.TJM = CC.TJM + 1
    end

    CC.TJMSJ[#CC.TJMSJ + 1] = #CC.JLWP
    CC.TJM = CC.TJM + 1
    for i = 1, #CC.JLWP do
        CC.TJMSJ[#CC.TJMSJ + 1] = CC.JLWP[i]
        CC.TJM = CC.TJM + 1
    end

    CC.TJMSJ[#CC.TJMSJ + 1] = CC.Gold
    CC.TJM = CC.TJM + 1

    CC.TJMSJ[#CC.TJMSJ + 1] = CC.MJCZ
    CC.TJM = CC.TJM + 1

    CC.Sp = JY.Base["��Ƭ"]
    CC.TJMSJ[#CC.TJMSJ + 1] = CC.Sp
    CC.TJM = CC.TJM + 1
    CC.TJMSJ[#CC.TJMSJ + 1] = CC.Shichen
    CC.TJM = CC.TJM + 1
    CC.TJMSJ[#CC.TJMSJ + 1] = CC.Day
    CC.TJM = CC.TJM + 1
    CC.TJMSJ[#CC.TJMSJ + 1] = CC.Month
    CC.TJM = CC.TJM + 1
    CC.TJMSJ[#CC.TJMSJ + 1] = CC.Year
    CC.TJM = CC.TJM + 1
    CC.TJMSJ[#CC.TJMSJ + 1] = CC.weat
    CC.TJM = CC.TJM + 1
    CC.TJMSJ[#CC.TJMSJ + 1] = CC.WeatherCD
    CC.TJM = CC.TJM + 1

    CC.TJMSJ[#CC.TJMSJ + 1] = CC.Jl
    CC.TJM = CC.TJM + 1

    for i = 0, CC.PerNum do
        if CC.PTF[i] ~= nil then
            local n = CC.TJM + 1
            local m = 0
            CC.TJMSJ[#CC.TJMSJ + 1] = 0
            CC.TJM = CC.TJM + 1
            for j, k in pairs(CC.PTF[i]) do
                CC.TJMSJ[#CC.TJMSJ + 1] = j
                CC.TJM = CC.TJM + 1
                m = m + 1
            end
            CC.TJMSJ[n] = m
        else
            CC.TJMSJ[#CC.TJMSJ + 1] = 0
            CC.TJM = CC.TJM + 1
        end
    end


    local fp_tmp = io.open(CC.SavePath .. 'tjm', "w");

    -- Catʱ���ʱ
    -------------------------------------
    -------------------------------------
    if fp_tmp then
        fp_tmp:close();

        local data_header = Byte.create(4);
        Byte.set32(data_header, 0, CC.TJM);
        Byte.savefile(data_header, CC.SavePath .. 'tjm', 0, 4);

        local data_header = Byte.create(8);
        Byte.set32(data_header, 0, CC.Miao);
        Byte.savefile(data_header, CC.SavePath .. 'tjm', 4, 8);

        local data_header = Byte.create(8);
        Byte.set32(data_header, 0, os.time());
        Byte.savefile(data_header, CC.SavePath .. 'tjm', 12, 8);

        local data_keys = Byte.create(4 * CC.TJM);
        for i = 0, CC.TJM - 1 do
            Byte.set32(data_keys, i * 4, CC.TJMSJ[i + 1]);
        end
        Byte.savefile(data_keys, CC.SavePath .. 'tjm', 20, 4 * CC.TJM);
    end
    -------------------------------------
    -------------------------------------
    CC.TJMSJ = {}
    CC.TJM = 0
end

function tjmload(id)
    CC.TJMSJ = {}
    CC.TJM = 0
    local fp_tmp = io.open(CC.SavePath .. 'tjm', "r");
    if fp_tmp then
        fp_tmp:close();

        -- Catʱ���ʱ
        -------------------------------------
        -------------------------------------
        local data_header = Byte.create(4);
        Byte.loadfile(data_header, CC.SavePath .. 'tjm', 0, 4);
        CC.TJM = Byte.get32(data_header, 0);

        local data_header = Byte.create(8);
        Byte.loadfile(data_header, CC.SavePath .. 'tjm', 4, 8);
        CC.Miao = Byte.get32(data_header, 0);

        local data_keys = Byte.create(4 * CC.TJM);
        Byte.loadfile(data_keys, CC.SavePath .. 'tjm', 20, 4 * CC.TJM);
        for i = 0, CC.TJM - 1 do
            CC.TJMSJ[i + 1] = Byte.get32(data_keys, i * 4);
        end
        -------------------------------------
        -------------------------------------

        CC.TJM = 1
        -- ����Ч
        for i = 1, #CC.TXM do
            CC.TX[CC.TXM[i]] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end

        -- �����
        local tg = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1

        for i = 1, tg do
            local v = CC.TJMSJ[CC.TJM]
            CC.TG[v] = 1
            CC.TJM = CC.TJM + 1
        end

        -- ��������
        local yl = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, yl do
            CC.JHtxt[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end
        -- ������������
        local ylID = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, ylID do
            CC.JHtxt_ID[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end

        -- ��������
        local SCENE = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, SCENE do
            CC.JHtxt_SCENE[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end

         -- ������������
        local ID1 = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, ID1 do
            CC.JHtxt_ID1[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end

        -- �������ӵ���������
        local PSX = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, PSX do
            CC.JHtxt_PSX[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end

        -- �����������Եĵ���
        local POINTS = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, POINTS do
            CC.JHtxt_POINTS[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end

        -- ������
        local YLYEAR = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, YLYEAR do
            CC.JHtxt_YEAR[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end

        -- ������
        local YLMOTH = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, YLMOTH do
            CC.JHtxt_MONTH[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end

        -- ������
        local YLDAY = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, YLDAY do
            CC.JHtxt_DAY[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end        

        -- ��ؽ���
        local tgjl = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, tgjl do
            CC.TGJL[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end

        -- ������Ʒ
        local wp = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, wp do
            CC.JLWP[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end

        CC.Gold = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1

        CC.MJCZ = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1

        CC.Jl = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1

        CC.Shichen = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1

        CC.Day = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1

        CC.Month = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1

        CC.Year = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1

        CC.weat = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1

        CC.WeatherCD = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1

        CC.Sp = JY.Base["��Ƭ"]
        CC.Sp = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1

        for i = 0, CC.PerNum do
            local n = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
            CC.PTF[i] = {}
            for j = 1, n do
                local tf = CC.TJMSJ[CC.TJM]
                CC.TJM = CC.TJM + 1
                CC.PTF[i][tf] = 1
            end
        end
    end
    Weekload()
    CC.TJMSJ = {}
    CC.TJM = 0
end



-- �����츳��n == 1��ʾ�У�nil��ʾ��
-- �����츳�ñ������
-- �����츳�ñ������
-- �����츳�ñ������
function SetTF(id, tf, n)
    if CC.PTF[id] == nil then
        CC.PTF[id] = {}
    end
    local tf1 = nil
    if n == 1 then
        for i = 1, 5 do
            if PersonTF(id, tf) == false then
                if JY.Person[id]['�츳' .. i] == 0 then
                    JY.Person[id]['�츳' .. i] = tf
                    break
                end
            end
        end
    elseif n == 0 then
        for i = 1, 5 do
            if PersonTF(id, tf) then
                if JY.Person[id]['�츳' .. i] == tf then
                    JY.Person[id]['�츳' .. i] = 0
                    break
                end
            end
        end
    end
end

function ZZQmenu()
    local bx, by = CC.WX, CC.HY
    -- ���ִ�С
    local size = CC.DefaultFont * 0.6
    local zb = {{875, 379, 144}, {875, 471, 145}, {762, 617, 146}, {851, 617, 147}}
    local tb = 0
    while true do
        Cls()
        if JY.Restart == 1 then
            break
        end
        for i = 1, #zb do
            lib.LoadPNG(92, zb[i][3] * 2, bx * zb[i][1], by * zb[i][2], 1)
        end
        ShowScreen()
        lib.Delay(CC.Frame)
        local X, ktype, mx, my = lib.GetKey()
        if X == VK_ESCAPE or ktype == 4 then
            return 0
        elseif X == VK_F1 then
            -- if tb == 1 then
            --	ThingMenu(1)
            -- elseif tb == 2 then
            --	elseif tb == 3 then				
            -- elseif tb == 4 then
            -- CHOUKA()
            -- end
        end
    end
end

function laoguds(str)
    local size = 60
    local x = CC.ScreenW / 2;
    local y = CC.ScreenH / 2;
    local offx = (#str) * size / 4
    local offy = size / 2

    lib.Background(0, y - 50, CC.ScreenW, y + 50, 98)
    DrawString(x - offx, y - offy, str, M_DeepSkyBlue, size); -- ��ҹ˼
    ShowScreen();
    lib.Delay(1500);
end



function JL() -- ��������
    local xm = {"������", "������", "�Ṧ", "ȭ�ƹ���", "��������", "�������", "ˣ������"}
    local sz = {10, 10, 10, 5, 5, 5, 5}
    local jl = math.random(7)
    if GetS(92, 60, 27, 5) == 1 then
        local jl2 = math.random(1, sz[jl])
        JY.Person[0][xm[jl]] = JY.Person[0][xm[jl]] + jl2
        local n = math.random(10)
        if n < 4 then
            local m = math.random(3)
            local mc = {"ң��ɫ��", "���˿�", "����"}
            if m == 1 then
                JY.Person[318]["ҽ������"] = JY.Person[318]["ҽ������"] + 1
                DrawStrBoxWaitKey(string.format("�����������%s��һ��", mc[m]), C_GOLD, CC.DefaultFont);
            elseif m == 2 then
                JY.Person[318]["���˳̶�"] = JY.Person[318]["���˳̶�"] + 1
                DrawStrBoxWaitKey(string.format("�����������%s��һ��", mc[m]), C_GOLD, CC.DefaultFont);
            elseif m == 3 then
                JY.Person[318]["��������"] = JY.Person[318]["��������"] + 1
                DrawStrBoxWaitKey(string.format("�����������%s��һ��", mc[m]), C_GOLD, CC.DefaultFont);
            end
        end
        DrawStrBoxWaitKey(string.format("����%s��������%d", xm[jl], jl2), C_GOLD, CC.DefaultFont);

    elseif GetS(92, 60, 27, 5) == 2 then
        local jl3 = math.random(10, 20)
        local rb = {5, 6, 39, 50, 129, 116, 57, 64, 68, 69, 70, 65, 185, 140, 114, 164}
        local rw = rb[math.random(#rb)]
        JY.Person[rw][xm[jl]] = JY.Person[rw][xm[jl]] + jl3
        SetS(92, 60, 28, 5, rw);
        SetS(92, 60, 29, 5, jl3);
        SetS(92, 60, 30, 5, jl);
    end
    SetS(92, 60, 27, 5, 0);
end

function Cat(s, ...)
    if not Ct[s] then
        lib.Debug('����δ֪����')
    end
    return Ct[s](...)
end

function WUXIAO()
    return
end

function CMenu()
    local bx, by = CC.WX, CC.HY
    local cont = 1
    local cont2 = 1
    local cont3 = 1
    local cont4 = 1
    local cot4 = 0
    local page = 1
    local menu = {'����', '��Ʒ', MJMenu, '����'}
    local menu2 = {'״̬', '����', '���'}
    local menu3 = {nil, 0, 1, 3, 4}

    local menu4 = {Menu_ReadRecord, Menu_SaveRecord, Menu_SetMusic, Menu_Switch, Menu_WPZL, LGCHENGJIU, Menu_MYDIY,
                   Menu_Exit2}
    if JY.SubScene == 150 then
        menu4 = {WUXIAO, WUXIAO, Menu_SetMusic, Menu_Switch, Menu_WPZL, LGCHENGJIU, Menu_MYDIY, Menu_Exit2}
    end
    local jg = bx * 20

    while true do
        Cls()
        if JY.Restart == 1 then
            break
        end
        ShowStatus()
        for i = 1, #menu do
            lib.PicLoadCache(92, (1 + i) * 2, CC.ScreenW / 2 - ((#menu - 1) * bx * 140) / 2 + (i - 1) * bx * 140,
                CC.ScreenH / 2 - bx * 60, 2, 256, nil, bx * 120)
            if cont ~= i then
                lib.PicLoadCache(92, (1 + i) * 2, CC.ScreenW / 2 - ((#menu - 1) * bx * 140) / 2 + (i - 1) * bx * 140,
                    CC.ScreenH / 2 - bx * 60, 6, 150, nil, bx * 120)
            end
        end
        if page == 2 then
            for i = 1, #menu2 do
                lib.PicLoadCache(92, (5 + i) * 2, CC.ScreenW / 2 - ((#menu2 - 1) * bx * 140) / 2 + (i - 1) * bx * 140,
                    CC.ScreenH / 2 + bx * 60, 2, 256, nil, bx * 100)
                if cont2 ~= i then
                    lib.PicLoadCache(92, (5 + i) * 2,
                        CC.ScreenW / 2 - ((#menu2 - 1) * bx * 140) / 2 + (i - 1) * bx * 140, CC.ScreenH / 2 + bx * 60,
                        6, 150, nil, bx * 100)
                end
            end
        end
        if page == 3 then
            for i = 1, #menu3 do
                lib.PicLoadCache(92, (15 + i) * 2, CC.ScreenW / 2 - ((#menu3 - 1) * bx * 140) / 2 + (i - 1) * bx * 140,
                    CC.ScreenH / 2 + bx * 60, 2, 256, nil, bx * 100)
                if cont3 ~= i then
                    lib.PicLoadCache(92, (15 + i) * 2,
                        CC.ScreenW / 2 - ((#menu3 - 1) * bx * 140) / 2 + (i - 1) * bx * 140, CC.ScreenH / 2 + bx * 60,
                        6, 150, nil, bx * 100)
                end
            end
        end

        if page == 4 then
            for i = 1, 4 do
                for j = 1, 2 do
                    local tid = i + (j - 1) * 4
                    lib.PicLoadCache(92, (20 + tid) * 2,
                        CC.ScreenW / 2 - ((#menu4 / 2 - 1) * bx * 140) / 2 + (i - 1) * bx * 140,
                        CC.ScreenH / 2 + bx * 60 + (j - 1) * bx * 120, 2, 256, nil, bx * 100)
                    if cont4 + cot4 * 4 ~= tid then
                        lib.PicLoadCache(92, (20 + tid) * 2,
                            CC.ScreenW / 2 - ((#menu4 / 2 - 1) * bx * 140) / 2 + (i - 1) * bx * 140,
                            CC.ScreenH / 2 + bx * 60 + (j - 1) * bx * 120, 6, 150, nil, bx * 100)
                    end
                end
            end
        end
        ShowScreen()
        lib.Delay(CC.Frame)
        local X, ktype, mx, my = lib.GetKey()
        if X == VK_SPACE or X == VK_RETURN then
            PlayWavE(77)
            if page == 1 then
                if cont == 1 then
                    page = 2
                elseif cont == 2 then
                    page = 3
                elseif cont == 4 then
                    page = 4
                else
                    menu[cont]()
                end
            elseif page == 2 then
                Team({menu2[cont2]})
                -- Duiwumb()
            elseif page == 3 then
                ThingMenu(menu3[cont3])
                if JY.ThingUse >= 0 then
                    JY.ThingUse = 0
                    return 1
                end
                if JY.Status == GAME_WMAP then
                    return 1
                end
            elseif page == 4 then
                local r = menu4[cont4 + cot4 * 4]()
                if cont4 + cot4 * 4 == #menu4 or cont4 + cot4 * 4 == 1 then
                    if r == 1 then
                        break
                    end
                end
            end
        elseif X == VK_ESCAPE or ktype == 4 then
            PlayWavE(77)
            if page == 2 then
                page = 1
                cont2 = 1
            elseif page == 3 then
                page = 1
                cont3 = 1
            elseif page == 4 then
                page = 1
                cont4 = 1
                cot4 = 0
            else
                break
            end
        elseif X == VK_LEFT then
            PlayWavE(77)
            if page == 1 then
                cont = cont - 1
                if cont < 1 then
                    cont = #menu
                end
            elseif page == 2 then
                cont2 = cont2 - 1
                if cont2 < 1 then
                    cont2 = #menu2
                end
            elseif page == 3 then
                cont3 = cont3 - 1
                if cont3 < 1 then
                    cont3 = #menu3
                end
            elseif page == 4 then
                if cont4 > 1 then
                    cont4 = cont4 - 1
                else
                    if cot4 > 0 then
                        cot4 = cot4 - 1
                        cont4 = 4
                    else
                        cont4 = 4
                        cot4 = math.ceil((#menu4 - cont4) / 4)
                    end
                end
            end
        elseif X == VK_RIGHT then
            PlayWavE(77)
            if page == 1 then
                cont = cont + 1
                if cont > #menu then
                    cont = 1
                end
            elseif page == 2 then
                PlayWavE(77)
                cont2 = cont2 + 1
                if cont2 > #menu2 then
                    cont2 = 1
                end
            elseif page == 3 then
                PlayWavE(77)
                cont3 = cont3 + 1
                if cont3 > #menu3 then
                    cont3 = 1
                end
            elseif page == 4 then
                PlayWavE(77)
                if cont4 + cot4 * 4 < #menu4 then
                    if cont4 < 4 then
                        cont4 = cont4 + 1
                    else
                        cont4 = 1
                        cot4 = cot4 + 1
                    end
                else
                    cont4 = 1
                    cot4 = 0
                end
            end
        elseif X == VK_UP or ktype == 6 then
            PlayWavE(77)
            if page == 4 then
                if cot4 > 0 then
                    cot4 = cot4 - 1
                else
                    cot4 = math.ceil((#menu4) / 4) - 1
                end
            end
        elseif X == VK_DOWN or ktype == 7 then
            PlayWavE(77)
            if page == 4 then
                if cot4 < math.ceil((#menu4) / 4) - 1 then
                    cot4 = cot4 + 1
                else
                    cot4 = 0
                end
            end
        else
            local mxx = false
            if page == 1 then
                for i = 1, #menu do
                    if mx >= CC.ScreenW / 2 - ((#menu - 1) * bx * 140) / 2 + (i - 1) * bx * 140 - bx * 60 and mx <=
                        CC.ScreenW / 2 - ((#menu - 1) * bx * 140) / 2 + (i - 1) * bx * 140 + bx * 60 and my >=
                        CC.ScreenH / 2 - bx * 120 and my <= CC.ScreenH / 2 then
                        cont = i
                        mxx = true
                        break
                    end
                end
            elseif page == 2 then
                for i = 1, #menu2 do
                    if mx >= CC.ScreenW / 2 - ((#menu2 - 1) * bx * 140) / 2 + (i - 1) * bx * 140 - bx * 50 and mx <=
                        CC.ScreenW / 2 - ((#menu2 - 1) * bx * 140) / 2 + (i - 1) * bx * 140 + bx * 50 and my >=
                        CC.ScreenH / 2 + bx * 10 and my <= CC.ScreenH / 2 + bx * 110 then
                        cont2 = i
                        mxx = true
                        break
                    end
                end
            elseif page == 3 then
                for i = 1, #menu3 do
                    if mx >= CC.ScreenW / 2 - ((#menu3 - 1) * bx * 140) / 2 + (i - 1) * bx * 140 - bx * 50 and mx <=
                        CC.ScreenW / 2 - ((#menu3 - 1) * bx * 140) / 2 + (i - 1) * bx * 140 + bx * 50 and my >=
                        CC.ScreenH / 2 + bx * 10 and my <= CC.ScreenH / 2 + bx * 110 then
                        cont3 = i
                        mxx = true
                        break
                    end
                end
            elseif page == 4 then
                for i = 1, 4 do
                    for j = 1, 2 do
                        if mx >= CC.ScreenW / 2 - ((#menu4 / 2 - 1) * bx * 140) / 2 + (i - 1) * bx * 140 - bx * 50 and
                            mx <= CC.ScreenW / 2 - ((#menu4 / 2 - 1) * bx * 140) / 2 + (i - 1) * bx * 140 + bx * 50 and
                            my >= CC.ScreenH / 2 + bx * 10 + (j - 1) * bx * 120 and my <= CC.ScreenH / 2 + bx * 110 +
                            (j - 1) * bx * 120 then
                            cont4 = i
                            cot4 = j - 1
                            mxx = true
                            break
                        end
                    end
                end
            end
            if mxx == true and ktype == 3 then
                PlayWavE(77)
                if page == 1 then
                    if cont == 1 then
                        page = 2
                    elseif cont == 2 then
                        page = 3
                    elseif cont == 4 then
                        page = 4
                    else
                        menu[cont]()
                    end
                elseif page == 2 then
                    Team({menu2[cont2]})
                    -- Duiwumb()
                elseif page == 3 then
                    ThingMenu(menu3[cont3])
                    if JY.ThingUse >= 0 then
                        JY.ThingUse = 0
                        return 1
                    end
                    if JY.Status == GAME_WMAP then
                        return 1
                    end
                elseif page == 4 then
                    local r = menu4[cont4 + cot4 * 4]()
                    if cont4 + cot4 * 4 == #menu4 or cont4 + cot4 * 4 == 1 then
                        if r == 1 then
                            break
                        end
                    end
                end
            end
        end
    end
end

function MJMenu()

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
            if JY.Thing[id]["����"] == 2 then
                thing[num] = id
                thingnum[num] = JY.Base["��Ʒ����" .. i + 1]
                num = num + 1
            end
        end
    end

    IsViewingKungfuScrolls = 1

    local r = SelectThing(thing, thingnum)
    if r >= 0 then
        UseThing(r)
        return 1
    end
    return 0
end

function ThingMenu(flag)
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
            if flag == nil then
                if JY.Thing[id]["����"] ~= 2 then
                    thing[num] = id
                    thingnum[num] = JY.Base["��Ʒ����" .. i + 1]
                    num = num + 1
                end
            else
                if JY.Thing[id]["����"] == flag then
                    thing[num] = id
                    thingnum[num] = JY.Base["��Ʒ����" .. i + 1]
                    num = num + 1
                end
            end
        end
    end
    local r = SelectThing(thing, thingnum)
    if r >= 0 then
        UseThing(r)
        return 1
    end
    return 0
end

function Team(tab)
    local bx, by = CC.WX, CC.HY
    local size = CC.DefaultFont * 0.7
    local size1 = CC.DefaultFont * 0.6
    local size2 = CC.DefaultFont * 0.55
    local cont = 1
    local cont1 = 0
    local tru = 0
    local p = JY.Person
    local px = 0
    local zbx1, zby1 = 210, 40
    while true do
        Cls()
        if JY.Restart == 1 then
            break
        end
        local menu = {}
        local maxn = 4
        local i = 0
        for ii = 1, CC.TeamNum do
            if JY.Base['����' .. ii] >= 0 then
                menu[#menu + 1] = {p[JY.Base['����' .. ii]]['����'], JY.Base['����' .. ii]}
            end
        end
        if maxn > #menu then
            maxn = #menu
        end
        lib.PicLoadCache(92, 9 * 2, zbx1, zby1, 1, nil, nil, bx * 936)

        for ii = 1, maxn do
            local h = 0
            local pyx = 0
            if CC.Png[p[menu[ii + cont1][2]]['������']] ~= nil then
                pyx = CC.Png[p[menu[ii + cont1][2]]['������']]
            end

            local sm = p[menu[ii + cont1][2]]['����']
            local smmax = p[menu[ii + cont1][2]]['�������ֵ']
            local nl = p[menu[ii + cont1][2]]['����']
            local nlmax = p[menu[ii + cont1][2]]['�������ֵ']
            local tl = p[menu[ii + cont1][2]]['����']
            local tlmax = 100
            local x1, y1 = lib.GetPNGXY(99, 2 * 2)
            lib.SetClip(bx * 42 + (ii - 1) * bx * 220 + zbx1, 0, bx * 38 + (ii - 1) * bx * 220 + bx * 197 + zbx1, by * 768 + zby1) -- �˵�����ͼ
            lib.LoadPNG(90, p[menu[ii + cont1][2]]['������'] * 2, bx * 138 + (ii - 1) * bx * 220 - bx * pyx + zbx1 - x1 * 4, by * 250 + zby1 - y1 * 4.4, 1)--���䣬���ﲻ֪��ΪʲôҪ������
            lib.SetClip(0, 0, 0, 0)

            lib.PicLoadCache(92, 15 * 2, bx * 138 + (ii - 1) * bx * 220 + zbx1, by * 425 + zby1, 2, 256, nil, bx * 170)

            DrawString(bx * 138 + (ii - 1) * bx * 220 - string.len(menu[ii + cont1][1]) * size / 4 + zbx1, by * 440 + zby1, menu[ii + cont1][1], C_WHITE, size)
            if ii == cont or px == ii then
                lib.PicLoadCache(92, 10 * 2, bx * 138 + (ii - 1) * bx * 220 + zbx1, CC.ScreenH / 2 + zby1, 2, 256, nil, bx * 200) -- �˵�����ͼ
            end

            h = h + 1

            local tfid = menu[ii + cont1][2]
            if JY.Base['����'] > 0 and tfid == 0 then
                tfid = JY.Base['����']
            end
            if RWWH[tfid] ~= nil then
                DrawString(bx * 60 + (ii - 1) * bx * 220 + zbx1, by * 440 + h * by * 30 + zby1, '�ƺţ�' .. RWWH[tfid], LimeGreen, size)
            end

            h = h + 1

            if RWTFLB[tfid] ~= nil then
                DrawString(bx * 60 + (ii - 1) * bx * 220 + zbx1, by * 440 + h * by * 30 + zby1, '�츳��' .. RWTFLB[tfid], LimeGreen, size)
            end

            h = h + 1

            lib.PicLoadCache(92, 11 * 2, bx * 138 + (ii - 1) * bx * 220 + zbx1,
                by * 450 + h * by * 30 + size1 / 2 + zby1, 2, 256, nil, bx * 160)

            lib.SetClip(bx * 138 + (ii - 1) * bx * 220 - bx * 71 + zbx1, by * 450 + h * by * 30 + size1 / 2 - by * 12,
                bx * 138 + (ii - 1) * bx * 220 - bx * 71 + bx * 142 * (sm / smmax) + zbx1,
                by * 450 + h * by * 30 + size1 / 2 + by * 12 + zby1)
            lib.PicLoadCache(92, 12 * 2, bx * 138 + (ii - 1) * bx * 220 + zbx1,
                by * 450 + h * by * 30 + size1 / 2 + zby1, 2, 150, nil, bx * 160)
            lib.SetClip(0, 0, 0, 0)

            DrawString(bx * 70 + (ii - 1) * bx * 220 + zbx1, by * 450 + h * by * 30 + zby1,
                '��  ' .. p[menu[ii + cont1][2]]['����'], C_WHITE, size1)
            h = h + 1

            lib.PicLoadCache(92, 11 * 2, bx * 138 + (ii - 1) * bx * 220 + zbx1,
                by * 450 + h * by * 30 + size1 / 2 + zby1, 2, 256, nil, bx * 160)
            lib.SetClip(bx * 138 + (ii - 1) * bx * 220 - bx * 71 + zbx1, by * 450 + h * by * 30 + size1 / 2 - by * 12,
                bx * 138 + (ii - 1) * bx * 220 - bx * 71 + bx * 142 * (nl / nlmax) + zbx1,
                by * 450 + h * by * 30 + size1 / 2 + by * 12 + zby1)
            lib.PicLoadCache(92, 13 * 2, bx * 138 + (ii - 1) * bx * 220 + zbx1,
                by * 450 + h * by * 30 + size1 / 2 + zby1, 2, 150, nil, bx * 160)
            lib.SetClip(0, 0, 0, 0)

            DrawString(bx * 70 + (ii - 1) * bx * 220 + zbx1, by * 450 + h * by * 30 + zby1,
                '��  ' .. p[menu[ii + cont1][2]]['����'], C_WHITE, size1)
            h = h + 1

            lib.PicLoadCache(92, 11 * 2, bx * 138 + (ii - 1) * bx * 220 + zbx1,
                by * 450 + h * by * 30 + size1 / 2 + zby1, 2, 256, nil, bx * 160)
            lib.SetClip(bx * 138 + (ii - 1) * bx * 220 - bx * 71 + zbx1,
                by * 450 + h * by * 30 + size1 / 2 - by * 12 + zby1,
                bx * 138 + (ii - 1) * bx * 220 - bx * 71 + bx * 142 * (tl / tlmax) + zbx1,
                by * 450 + h * by * 30 + size1 / 2 + by * 12)
            lib.PicLoadCache(92, 14 * 2, bx * 138 + (ii - 1) * bx * 220 + zbx1,
                by * 450 + h * by * 30 + size1 / 2 + zby1, 2, 150, nil, bx * 160)
            lib.SetClip(0, 0, 0, 0)

            DrawString(bx * 70 + (ii - 1) * bx * 220 + zbx1, by * 450 + h * by * 30 + zby1,
                '��  ' .. p[menu[ii + cont1][2]]['����'], C_WHITE, size1)
        end

        ShowScreen()
        lib.Delay(CC.Frame)
        local X, ktype, mx, my = lib.GetKey()
        if X == VK_SPACE or X == VK_RETURN then
            PlayWavE(77)
            tru = cont + cont1
            local id = JY.Base['����' .. tru]
            if tab ~= nil then
                if tab[1] == '���' then
                    if tru > 1 then
                        if JY.SubScene == 55 and JY.Base["����" .. tru] == 35 then
                        elseif JY.SubScene == 82 then
                        else
                            local personid = JY.Base["����" .. tru]
                            if CC.PersonExit[personid] ~= nil then
                                local v = CC.PersonExit[personid]
                                CallCEvent(v)
                            end
                            cont = 1
                            cont1 = 0
                        end
                    end
                elseif tab[1] == '״̬' then
                    ShowPersonStatus(tru)
                elseif tab[1] == '����' then
                    if px == 0 then
                        if tru > 1 then
                            px = cont
                        end
                    else
                        if tru > 1 then
                            JY.Base['����' .. tru] = JY.Base['����' .. px + cont1]
                            JY.Base['����' .. px + cont1] = id
                            px = 0
                        end
                    end
                end
            else
                break
            end
        elseif X == VK_ESCAPE or ktype == 4 then
            PlayWavE(77)
            if tab ~= nil then
                if tab[1] == '���' then
                    return nil
                end
            end
            if px > 0 then
                px = 0
            else
                break
            end
        elseif X == VK_LEFT then
            PlayWavE(77)
            if cont1 > 0 then
                if cont > 1 then
                    cont = cont - 1
                else
                    cont1 = cont1 - 1
                end
            else
                cont = cont - 1
                if cont < 1 then
                    cont = maxn
                    cont1 = #menu - cont
                end
            end
        elseif X == VK_RIGHT then
            PlayWavE(77)
            cont = cont + 1
            if cont > maxn then
                cont = maxn
                cont1 = cont1 + 1
            end
            if cont1 + cont > #menu then
                cont1 = 0
                cont = 1
            end
        elseif X == VK_UP or ktype == 6 then
            PlayWavE(77)
            cont1 = cont1 - maxn
            cont = 1
            if cont1 < 0 then
                cont1 = 0
            end
        elseif X == VK_DOWN or ktype == 7 then
            PlayWavE(77)
            cont1 = cont1 + maxn
            cont = maxn
            if cont1 + cont > #menu then
                cont1 = #menu - cont
            end
        else
            local mxx = false
            for ii = 1, maxn do
                if mx >= bx * 33 + (ii - 1) * bx * 220 + zbx1 and mx <= bx * 30 + (ii - 1) * bx * 220 + bx * 197 + zbx1 and
                    my >= by * 55 + zby1 and my <= by * 710 + zby1 then
                    cont = ii
                    mxx = true
                    break
                end
            end
            if ktype == 3 and mxx == true then
                PlayWavE(77)
                tru = cont + cont1
                local id = JY.Base['����' .. tru]
                if tab ~= nil then
                    if tab[1] == '���' then
                        if tru > 1 then
                            if JY.SubScene == 55 and JY.Base["����" .. tru] == 35 then
                            elseif JY.SubScene == 82 then
                            else
                                local personid = JY.Base["����" .. tru]
                                if CC.PersonExit[personid] ~= nil then
                                    local v = CC.PersonExit[personid]
                                    CallCEvent(v)
                                end
                                cont = 1
                                cont1 = 0
                            end
                        end
                    elseif tab[1] == '״̬' then
                        ShowPersonStatus(tru)
                    elseif tab[1] == '����' then
                        if px == 0 then
                            if tru > 1 then
                                px = cont
                            end
                        else
                            if tru > 1 then
                                JY.Base['����' .. tru] = JY.Base['����' .. px + cont1]
                                JY.Base['����' .. px + cont1] = id
                                px = 0
                            end
                        end
                    end
                else
                    break
                end
            end
        end
    end
    return tru
end

function Mp_Max(id)
    local p = JY.Person[id]
    local kflvl = 0
    local wgwl = 0
    local wgwl1 = 0
    local wgwl2 = 0
    local jnl = 0
    local jnl1 = 0
    local wugong;
    local level;
    -- local �ؼ�;
    local ng = 0
    --[[
	for i = 1,JY.Base["�书����"] do
		wugong = p["�书"..i]
		kflvl = p["�书�ȼ�" .. i]
		if kflvl >= 1000 then
			level = 11
		else
			level = math.modf(kflvl/100)+1
		end
		if JY.Wugong[wugong]["�书����"] == 6 then
			ng = ng + 1
		end
		if ng > 3 then
			ng = 3
		end		
	end	
	local num = 0
	for i = 1, JY.Base["�书����"] do
		if JY.Person[id]["�书" .. i] == 85 or JY.Person[id]["�书" .. i] == 88 then
			num = 1
			break
		end
	end	
	if p["�����ڹ�"] > 0 then
        local zy = p["�����ڹ�"] 
		for j = 0,JY.ThingNum - 1 do
			if JY.Thing[j]["�����书"] >= 0  then
				if JY.Thing[j]["�����书"] == zy then
					jnl = level*JY.Thing[j]["���������ֵ"]
					break
				end	
			end
		end
		
        if id == 0 and (JY.Base["��׼"] == 6  or  JY.Base["����"] == 637 or  JY.Base["����"] == 27 or JY.Base["����"] == 189 ) then
			for i = 1, JY.Base["�书����"] do
				for j = 0,JY.ThingNum - 1 do
					if JY.Thing[j]["�����书"] >= 0  then
						if JY.Thing[j]["�����书"] == p["�书" .. i] then
							if p["�书" .. i]== p["�츳�ڹ�"] then
								jnl1 = level*JY.Thing[j]["���������ֵ"]
								break
							end
						end
					end										
				end
			end	
		end	       
		if jnl < jnl1 then
			jnl = jnl1
		end	
		p["�������ֵ"] = 999 + jnl + (130-p["����"])*35 + ng*1500 + p['��������']
		if match_ID(id, 53) or match_ID(id, 114) or match_ID(id, 38) or match_ID(id, 116)  or match_ID(id, 638) or match_ID(id, 499) or match_ID(id, 9999) then
			p["�������ֵ"] = 9999
		end
		if p["����"] >  p["�������ֵ"] then
         	p["����"] =  p["�������ֵ"]
		end
		if JY.Status ~= GAME_WMAP then
			AddPersonAttrib(id,'����',math.huge)
		else 
			p["����"] = limitX(p["����"],0,p["�������ֵ"])
		end	
	else
		p["�������ֵ"] = 999 + (130-p["����"])*35 + ng*1500 + p['��������']
		if match_ID(id, 53) or match_ID(id, 114) or match_ID(id, 38) or match_ID(id, 116)  or match_ID(id, 638) or match_ID(id, 499) or match_ID(id, 9999) then
			p["�������ֵ"] = 9999
		end 
		if JY.Status ~= GAME_WMAP then
			AddPersonAttrib(id,'����',math.huge)
		else 
			p["����"] = limitX(p["����"],0,p["�������ֵ"])
		end			
	end
	]]
end

function Hp_Max(id)
    local p = JY.Person[id]
    local kf = 0
    local tfkf = p["�츳�ڹ�"]
    local kflvl = 0
    local wgwl = 0
    local wgwl1 = 0
    local wgwl2 = 0
    local lv = 0
    lib.GetKey();
    Cls();
    if p["�����ڹ�"] > 0 then
        kf = p["�����ڹ�"]
        lv = KF_level(id, kf)
        if PersonKF(id, kf) == false then
            lv = 10
        end
        wgwl2 = get_skill_power(id, kf, lv) + JY.Wugong[kf]['�㼶'] * 100
        if id == 0 and (JY.Base["����"] == 637 or JY.Base["����"] == 27 or JY.Base["����"] == 189) then
            if tfkf > 0 and PersonKF(id, tfkf) then
                wgwl1 = get_skill_power(id, tfkf, KF_level(id, tfkf)) + JY.Wugong[tfkf]['�㼶'] * 100
                if wgwl2 < wgwl1 then
                    kf = tfkf
                    lv = KF_level(id, tfkf)
                end
            end
        end
        wgwl = get_skill_power(id, kf, lv) + JY.Wugong[kf]["�㼶"] * 100
        p["�������ֵ"] = p["����"] * 200 + (7 - p["����ֽ�"]) * 400 + p['��������'] + wgwl

    else
        p["�������ֵ"] = p["����"] * 200 + (7 - p["����ֽ�"]) * 400 + p['��������']
    end

    if p["�������ֵ"] > 9999 then
        -- p["�������ֵ"] = 9999
    end
    if p["����"] > p["�������ֵ"] then
        p["����"] = p["�������ֵ"]
    end
    if JY.Status ~= GAME_WMAP then
        AddPersonAttrib(id, '����', math.huge)
    else
        p["����"] = limitX(p["����"], 0, p["�������ֵ"])
    end
end

function tgsave(flag)

    local tgjl = 0
    local tg = 0
    local tgsize = 0
    if flag == nil then
        if CC.Week < 100 then
            if JY.Base["��Ŀ"] == CC.Week then
                CC.Week = CC.Week + 1
            end
        end
    end

    tg = #CC.TGJL

    tgjl = tgjl + tg

    tgjl = tgjl + #CC.commodity

    tgjl = tgjl + 4

    local size = (tgjl) * 4
    local data = Byte.create(size * 4)

    Byte.set32(data, 0, tgjl)
    Byte.set32(data, 4, CC.Sp)
    Byte.set32(data, 8, CC.Week)
    Byte.set32(data, 12, tg)
    tgsize = 16
    for i = 0, tg - 1 do
        Byte.set32(data, tgsize, CC.TGJL[i + 1]);
        tgsize = tgsize + 4
    end
    for i = 1, #CC.commodity do
        Byte.set32(data, tgsize, CC.commodity[i][3]);
        tgsize = tgsize + 4
        Byte.set32(data, tgsize, CC.commodity[i][5]);
        tgsize = tgsize + 4
    end
    Byte.savefile(data, CONFIG.DataPath .. 'WeeklyAwards', 0, size);

    CC.TJMSJ = {}
    CC.TJM = 0
end

function tgload()

    local tgjl = 0
    local tg = 0
    local size = 0
    local tgsize = 0
    local ew = 0
    local fp_tmp = io.open(CONFIG.DataPath .. 'WeeklyAwards', "r");
    if fp_tmp then
        fp_tmp:close();

        local data_tgjl = Byte.create(4);
        Byte.loadfile(data_tgjl, CONFIG.DataPath .. 'WeeklyAwards', 0, 4);
        tgjl = Byte.get32(data_tgjl, 0);
        size = (tgjl) * 4

        local data = Byte.create(size * 4);
        Byte.loadfile(data, CONFIG.DataPath .. 'WeeklyAwards', 0, size);
        CC.Sp = Byte.get32(data, 4);
        CC.Week = Byte.get32(data, 8);
        tg = Byte.get32(data, 12);
        tgsize = 16
        for i = 1, tg do
            CC.TGJL[i] = Byte.get32(data, tgsize);
            tgsize = tgsize + 4
        end
        --[[
		for i = 1,#CC.TGJLEW do
			CC.TGJLEW[i]=Byte.get32(data, tgsize);
			tgsize = tgsize + 4
		end
		--]]
        for i = 1, #CC.commodity do
            CC.commodity[i][3] = Byte.get32(data, tgsize);
            tgsize = tgsize + 4
            CC.commodity[i][5] = Byte.get32(data, tgsize);
            tgsize = tgsize + 4
        end

    end
end

function Weekload()
    local fp_tmp = io.open(CONFIG.DataPath .. 'WeeklyAwards', "r");
    if fp_tmp then
        fp_tmp:close();

        local data_Sp = Byte.create(4);
        Byte.loadfile(data_Sp, CONFIG.DataPath .. 'WeeklyAwards', 4, 4);
        CC.Sp = Byte.get32(data_Sp, 0);

        local data_Week = Byte.create(4);
        Byte.loadfile(data_Week, CONFIG.DataPath .. 'WeeklyAwards', 8, 4);
        CC.Week = Byte.get32(data_Week, 0);

    end
end

function GAME_START1()
    local bx = CC.WX
    local by = CC.HY
    local tb = 1
    local page = 1
    local size = CC.DefaultFont * 0.7
    JY.Base["�Ѷ�"] = 1
    local m = {{'��Ŀ', '�̵�'}, {'��ͨ', '��ͨ', '����'}, {'��', '��ͨ', '����', '����'},
               {'����'}, {'��һ��'}}
    local ax, ay = 210, 35
    local sz = {{582 + ax, 161 + ay, 180}, {556 + ax, 328 + ay, 120}, {518 + ax, 489 + ay, 105},
                {518 + ax, 600 + ay, 0}, {818 + ax, 656 + ay, 0} -- {938+ax,656+ay,0},
    }

    local sm =
        {'���ҷ����ѿ��Բμ�ս�����ҷ�ս���ϳ�����Ϊ6�ˣҡ���ʾ����ģʽΪ����ģʽ��һ���Դ�ģʽΪ��׼��',
         '������ս��ֻ�����ǿ��Բ�ս��֣����ʾ����ģʽΪ��Űģʽ����������޷���Ϸ�ĺ���������е���ģʽ����������ģʽ��������Ȩ������BB��',
         '������ս��ֻ�����ǿ��Բ�ս�������������ж�������ѵ������츳�ҡ���ʾ����ģʽΪ����ģʽ��������ҫ��'}
    local zmmax = CC.Week
    local w = math.modf(bx * 350 / size / 0.96)

    while true do
        if JY.Restart == 1 then
            break
        end
        ClsN()
        local name = JY.Person[0]['����']
        local zm = JY.Base["��Ŀ"] -- 267 443
        local cx, cy = bx * sz[1][1] - bx * 520, by * sz[1][2] + by * 203
        lib.LoadPNG(91, 48 * 2, -1, -1, 1)
        tjm(bx * 166, by * 551, sm[JY.Base["��ͨ"] + 1], C_WHITE, size * 0.96, w, size * 1.6)
        DrawString(cx - string.len(zm) / 4 * size, cy, zm, C_RED, size)
        DrawString(cx - string.len(zmmax) / 4 * size, cy + size * 1.6, zmmax, C_RED, size)
        DrawString(cx - size * 0.9, cy + size * 3.1, m[3][JY.Base["�Ѷ�"]], C_RED, size)
        DrawString(cx - size * 0.9, cy + size * 4.6, m[2][JY.Base["��ͨ"] + 1], C_RED, size)
        -- DrawString(cx-size*0.9,cy+size*4.6,m[4][1]..':'..m[4][2],C_RED,size)
        for i = 1, #m do
            for j = 1, #m[i] do
                local cl = M_Wheat
                local s = m[i][j]
                if page == i then
                    if tb == j then
                        cl = C_RED
                    end
                end
                lib.LoadPNG(91, 21 * 2, bx * sz[i][1] + (j - 1) * bx * sz[i][3] - bx * 44,
                    by * sz[i][2] - size / 2 - by * 5, 1)
                DrawString(bx * sz[i][1] - string.len(s) / 4 * size + (j - 1) * bx * sz[i][3], by * sz[i][2] - size / 2,
                    s, cl, size)
            end
        end
        DrawString(bx * sz[4][1] + bx * 50, by * sz[4][2] - size / 2, ': ' .. name, C_RED, size)
        ShowScreen()
        lib.Delay(CC.Frame)
        local X, ktype, mx, my = lib.GetKey();
        if X == VK_SPACE or X == VK_RETURN then
            PlayWavE(77)
            if page == 1 then
                if tb == 1 then
                    JY.Base["��Ŀ"] = InputNum("ѡ����Ŀ", 1, zmmax);
                else
                    ZmShop()
                end
            elseif page == 2 then
                JY.Base["��ͨ"] = tb - 1
            elseif page == 3 then
                JY.Base["�Ѷ�"] = tb
            elseif page == 4 then
                -- m[4][2] = Shurufa(10, 10)
                JY.Person[0]['����'] = InputText(-1,160,M_Wheat,CC.DefaultFont*0.8) --���뷨
                if JY.Person[0]['����'] == '' then 
                    JY.Person[0]['����'] = '����'
                end
                -- m[4][2] = Shurufa(10, 10)

            elseif page == 5 then
                break
            end
        elseif X == VK_ESCAPE or ktype == 4 then
            PlayWavE(77)

        elseif X == VK_UP then
            PlayWavE(77)
            page = page - 1
            if page < 1 then
                page = #m
            end
            tb = 1
        elseif X == VK_DOWN then
            PlayWavE(77)
            page = page + 1
            if page > #m then
                page = 1
            end
            tb = 1
        elseif X == VK_LEFT then
            PlayWavE(77)
            tb = tb - 1
            if tb < 1 then
                tb = #m[page]
            end
        elseif X == VK_RIGHT then
            PlayWavE(77)
            tb = tb + 1
            if tb > #m[page] then
                tb = 1
            end
        else
            local mxx = false -- 55 8
            local jh = 15
            for i = 1, 2 do
                if mx >= bx * sz[1][1] - bx * 55 + (i - 1) * sz[1][3] and mx <= bx * sz[1][1] + bx * 55 + (i - 1) *
                    sz[1][3] and my >= by * sz[1][2] - by * jh and my <= by * sz[1][2] + by * jh then
                    page = 1
                    tb = i
                    mxx = true
                    break
                end
            end
            for i = 1, 3 do
                if mx >= bx * sz[2][1] - bx * 55 + (i - 1) * sz[2][3] and mx <= bx * sz[2][1] + bx * 55 + (i - 1) *
                    sz[2][3] and my >= by * sz[2][2] - by * jh and my <= by * sz[2][2] + by * jh then
                    page = 2
                    tb = i
                    mxx = true
                    break
                end
            end
            for i = 1, 4 do
                if mx >= bx * sz[3][1] - bx * 55 + (i - 1) * sz[3][3] and mx <= bx * sz[3][1] + bx * 55 + (i - 1) *
                    sz[3][3] and my >= by * sz[3][2] - by * jh and my <= by * sz[3][2] + by * jh then
                    page = 3
                    tb = i
                    mxx = true
                    break
                end
            end
            if mx >= bx * sz[4][1] + bx * 50 and mx <= bx * sz[4][1] + bx * 200 and my >= by * sz[4][2] - by * jh and my <=
                by * sz[4][2] + by * jh then
                page = 4
                tb = 2
                mxx = true
                -- break
            end

            if mx >= bx * sz[5][1] - bx * 55 and mx <= bx * sz[5][1] + bx * 55 and my >= by * sz[5][2] - by * jh and my <=
                by * sz[5][2] + by * jh then
                page = 5
                tb = 1
                mxx = true
            end
            if mxx == true and ktype == 3 then
                PlayWavE(77)
                if page == 1 then
                    if tb == 1 then
                        JY.Base["��Ŀ"] = InputNum("ѡ����Ŀ", 1, zmmax);
                    else
                        ZmShop() -- zmStore()
                    end
                elseif page == 2 then
                    JY.Base["��ͨ"] = tb - 1
                elseif page == 3 then
                    JY.Base["�Ѷ�"] = tb
                elseif page == 4 then
                    -- m[4][2] = Shurufa(10, 10)
                    JY.Person[0]['����'] = InputText(CC.ScreenW*1.2,CC.ScreenH*1.6,C_RED,CC.DefaultFont*0.8) --���뷨
                    if JY.Person[0]['����'] == '' then 
                        JY.Person[0]['����'] = '����'
                    end
                    -- m[4][2] = Shurufa(10, 10)

                elseif page == 5 then
                    break
                end
            end
        end
    end

end

function GAME_START2()
    local bx = CC.WX
    local by = CC.HY
    -- local size = CC.DefaultFont
    local tb = 1
    local page = 1
    local size = CC.DefaultFont * 0.7
    local p = JY.Person[0]
    local m = {{'����', '����', '����'}, {'1-30', '31-50', '51-79', '80-100'}, {'���书', "���书"},
               {'��һ��'}}
    local sz = {{536, 170, 140}, -- {}
    {518, 325, 105}, {584, 473, 178}, {818, 648, 0}}
    local nlsm =
        {'���������ڹ�������������ʱ���Ѫ����������ͻ����*�����д�˵�������ڹ�֮��Ī�������񹦣����������߱������߱����˺���ֻҪ���ֱ��ö���û�л���֮���������������澭�����칦���������е��书�õ����޴ӷ�����*�Ƽ��ڹ��������񹦣������񹦣����칦����Ϣ������������*�Ƽ��Ṧ:�����귭�������ݣ���������',
         '���������ڷ��������ʤһ�ʱ����ڡ��ظ���Ѩ�������������������˵�����ͻ����*�����д�˵�������ڹ�֮��Ī�������񹦣��������٤�񹦣���������������㹦��Ǭ����Ų�Ƶ��÷�������������',
         '�������������߽���������ͣ������¾�ѧ�ڹ����׽���׽��ѹǣ�����������������Χ���ԣ����޺���ħ������ղ�����һ�����������ض����������������в��ױ��֡�'}

    local zzsm = {'�����书��̫���񹦣����һ���', '�����书�����һ���',
                  '������ѧ����ӹ֮��', '������ѧ��̫���񹦡���ת����'}
    p["��������"] = 0
    local w = math.modf(bx * 333 / size)
    while true do
        if JY.Restart == 1 then
            break
        end
        ClsN()
        local zz = JY.Person[0]["����"]
        local wg1
        local wg2
        -- JY.Wugong[wugong]["����"]
        for wg = 1, JY.Base["�书����"] do
            wg1 = JY.Wugong[JY.Person[0]["�书" .. 1]]["����"]
            wg2 = JY.Wugong[JY.Person[0]["�书" .. 2]]["����"]
        end

        lib.LoadPNG(91, 45 * 2, -1, -1, 1)
        for i = 1, #m do
            for j = 1, #m[i] do
                local cl = M_Wheat
                local s = m[i][j]
                if page == i then
                    if tb == j then
                        cl = C_RED
                    end
                end
                lib.LoadPNG(91, 21 * 2, bx * 212 + bx * sz[i][1] + (j - 1) * bx * sz[i][3], by * sz[i][2], 2)
                DrawString(bx * 212 + bx * sz[i][1] - string.len(s) / 4 * size + (j - 1) * bx * sz[i][3],
                    by * sz[i][2] - size / 2, s, cl, size)
            end
        end
        local n = 1
        DrawString(bx * 72 + size * 3, by * 99 + size, "�������ʣ�", C_WHITE, size)
        DrawString(bx * 70 + size * 5, by * 99 + size, "      " .. m[1][p["��������"] + 1], C_RED, size)
        DrawString(bx * 260 + size * 3, by * 97 + size, "����:", C_WHITE, size)
        DrawString(bx * 260 + size * 3, by * 97 + size, "      " .. zz, C_RED, size)
        n = n + 1

        if page == 1 then
            n = tjm(bx * 148, by * 130 + (n) * size, nlsm[tb], C_WHITE, size, w, size)
        else
            n = tjm(bx * 148, by * 130 + (n) * size, nlsm[p["��������"] + 1], C_WHITE, size, w, size)
        end
        n = n + 1
        for i = 1, #zzsm do
            DrawString(bx * 148, by * 130 + (n + i - 1) * size, zzsm[i], M_Wheat, size)
        end
        n = n + 1
        DrawString(bx * 148, by * 150 + (n + 3) * size, "��ʼ�书��", C_RED, size)
        n = n + 1
        DrawString(bx * 148, by * 150 + (n + 3) * size, wg1, M_Wheat, size)
        n = n + 1
        DrawString(bx * 148, by * 150 + (n + 3) * size, wg2, M_Wheat, size)
        n = n + 1

        ShowScreen()
        lib.Delay(CC.Frame)
        local X, ktype, mx, my = lib.GetKey();
        if X == VK_SPACE or X == VK_RETURN then
            PlayWavE(77)
            if page == 1 then
                p["��������"] = tb - 1
            elseif page == 2 then
                if tb == 1 then
                    JY.Person[0]["����"] = InputNum("��������", 1, 30)
                elseif tb == 2 then
                    JY.Person[0]["����"] = InputNum("��������", 31, 50)
                elseif tb == 3 then
                    JY.Person[0]["����"] = InputNum("��������", 51, 79)
                elseif tb == 4 then
                    JY.Person[0]["����"] = InputNum("��������", 80, 100)
                end
            elseif page == 3 then
                if tb == 1 then
                    JY.Person[0]["�书1"] = CC.kaijuwugong1
                    JY.Person[0]["�书2"] = CC.kaijuwugong2
                    JY.Person[0]["�书3"] = CC.kaijuwugong3
                    JY.Person[0]["�书�ȼ�1"] = CC.kaijuwugongx1
                    JY.Person[0]["�书�ȼ�2"] = CC.kaijuwugongx2
                    JY.Person[0]["�书�ȼ�3"] = CC.kaijuwugongx3
                elseif tb == 2 then
                    JY.Person[0]["�书1"] = 0
                    JY.Person[0]["�书2"] = 0
                end
            elseif page == 4 then
                break
            end
        elseif X == VK_ESCAPE or ktype == 4 then
            PlayWavE(77)

        elseif X == VK_UP then
            PlayWavE(77)
            page = page - 1
            if page < 1 then
                page = #m
            end
            tb = 1
        elseif X == VK_DOWN then
            PlayWavE(77)
            page = page + 1
            if page > #m then
                page = 1
            end
            tb = 1
        elseif X == VK_LEFT then
            PlayWavE(77)
            tb = tb - 1
            if tb < 1 then
                tb = #m[page]
            end
        elseif X == VK_RIGHT then
            PlayWavE(77)
            tb = tb + 1
            if tb > #m[page] then
                tb = 1
            end
        else
            local mxx = false
            local cx = bx * 90
            local cy = by * 34
            for i = 1, 3 do
                local tx = bx * 142 * (i - 1)
                if mx >= bx * 704 + tx and mx <= bx * cx + bx * 704 + tx and my >= by * 153 and my <= by * 185 then
                    page = 1
                    tb = i
                    mxx = true
                    break
                end
            end
            for i = 1, 4 do
                local tx = bx * 107 * (i - 1)
                if mx >= bx * 705 + tx and mx <= bx * 705 + tx + cx and my >= by * 308 and my <= by * 308 + cy then
                    page = 2
                    tb = i
                    mxx = true
                    break
                end
            end
            for i = 1, 2 do
                local tx = bx * 179 * (i - 1)
                if mx >= bx * 753 + tx and mx <= bx * 753 + tx + cx and my >= by * 456 and my <= by * 456 + cy then
                    page = 3
                    tb = i
                    mxx = true
                    break
                end
            end
            if mx >= bx * 986 and mx <= bx * 986 + cx and my >= by * 631 and my <= by * 631 + cy then
                page = 4
                tb = 1
                mxx = true
            end
            if mxx == true and ktype == 3 then
                PlayWavE(77)
                if page == 1 then
                    if tb == 1 then
                        p["��������"] = 0
                    elseif tb == 2 then
                        p["��������"] = 1
                    elseif tb == 3 then
                        p["��������"] = 2
                    end
                elseif page == 2 then
                    if tb == 1 then
                        p["����"] = InputNum("��������", 1, 30)
                    elseif tb == 2 then
                        p["����"] = InputNum("��������", 31, 50)
                    elseif tb == 3 then
                        p["����"] = InputNum("��������", 51, 79)
                    elseif tb == 4 then
                        p["����"] = InputNum("��������", 80, 100)
                    end
                elseif page == 3 then
                    if tb == 1 then
                        JY.Person[0]["�书1"] = CC.kaijuwugong1
                        JY.Person[0]["�书2"] = CC.kaijuwugong2
                        JY.Person[0]["�书3"] = CC.kaijuwugong3
                        JY.Person[0]["�书�ȼ�1"] = CC.kaijuwugongx1
                        JY.Person[0]["�书�ȼ�2"] = CC.kaijuwugongx2
                        JY.Person[0]["�书�ȼ�3"] = CC.kaijuwugongx3
                    elseif tb == 2 then
                        JY.Person[0]["�书1"] = 0
                        JY.Person[0]["�书2"] = 0
                        JY.Person[0]["�书3"] = 0
                    end
                elseif page == 4 then
                    break
                end
            end
        end
    end
end

function InputText(x,y,color,size,fontname) --�����뷨
	if x == -1 or x == nil then
		x = CC.ScreenW
	end
	if y == -1 or y == nil then
		y = CC.ScreenH
	end
	if color == nil then
		color = C_WHITE
	end
	if size == nil then
		size = CC.DefaultFont
	end
	if fontname == nil then
		fontname = CC.FontName
	end	
	if CONFIG.SrcCharSet == 2 then
		return lib.InputText(x,y,color,size,fontname)
	else
		return lib.utf8gbk(lib.InputText(x,y,color,size,fontname), false)
	end
end

function NpcWar()
    local n = 0
    local menu = {}
    for i = 1, JY.PersonNum - 1 do
        if JY.Person[i]['����'] ~= '����' and JY.Person[i]['����'] ~= '����ռ��' and JY.Person[i]['����'] ~=
            '����ռ��' then
            menu[#menu + 1] = {JY.Person[i]['����'], nil, 1, i}
        end
    end
    CC.HSLJ = {}
    while #CC.HSLJ < 50 do
        if JY.Restart == 1 then
            break
        end
        Cls()
        local r = ShowMenu4(menu, #menu, 8, -2, -2, -2, -2, 1, 1, CC.DefaultFont * 0.9, C_GOLD, C_WHITE, "A��ѡ����Ҫ�ϳ�����" .. #CC.HSLJ, C_ORANGE, C_WHITE, 15)
        if r <= 0 then
            break
        else
            CC.HSLJ[#CC.HSLJ + 1] = menu[r][4]
            table.remove(menu, r)
        end
        Cls()
    end

    if #CC.HSLJ == 0 then
        return
    end

    CC.HSLJ2 = {}
    while #CC.HSLJ2 < 50 do
        if JY.Restart == 1 then
            break
        end
        Cls()
        local r = ShowMenu4(menu, #menu, 8, -2, -2, -2, -2, 1, 1, CC.DefaultFont * 0.9, C_GOLD, C_WHITE,
            "B��ѡ����Ҫ�ϳ�����" .. #CC.HSLJ2, C_ORANGE, C_WHITE, 15)
        if r <= 0 then
            break
        else
            CC.HSLJ2[#CC.HSLJ2 + 1] = menu[r][4]
            table.remove(menu, r)
        end
        Cls()

    end

    if #CC.HSLJ2 == 0 then
        return
    end
    WarMain(354)
end

-- ��������
function LianGong(lx)
    JY.Person[591]["�ȼ�"] = 1
    JY.Person[591]["��������"] = lx
    local id = math.random(190)
    JY.Person[591]["ͷ�����"] = JY.Person[id]["ͷ�����"]
    for i = 1, 5 do
        JY.Person[591]["���ж���֡��" .. i] = JY.Person[id]["���ж���֡��" .. i]
        JY.Person[591]["���ж����ӳ�" .. i] = JY.Person[id]["���ж����ӳ�" .. i]
        JY.Person[591]["�书��Ч�ӳ�" .. i] = JY.Person[id]["�书��Ч�ӳ�" .. i]
    end
    JY.Person[591]["������"] = JY.Person[id]["������"]
    JY.Person[591]["�������ֵ"] = 9999
    JY.Person[591]["����"] = 9999
    JY.Person[591]["����"] = 0
    JY.Person[591]["������"] = 0
    JY.Person[591]["��������"] = 0
    JY.Person[591]["ָ������"] = 0
    JY.Person[591]["ȭ�ƹ���"] = 0
    JY.Person[591]["ˣ������"] = 0
    JY.Person[591]["�������"] = 0
    JY.Person[591]["��ѧ��ʶ"] = 0
    instruct_6(226, 8, 0, 1)
    JY.Person[591]["��������"] = 0
    light()
    -- return 1;
end

-- �书��Ч˵��
function WuGongIntruce()
    local menu = {};

    for i = 1, JY.WugongNum - 1 do
        menu[i] = {i .. JY.Wugong[i]["����"], nil, 0}
    end

    -- ӵ�е��ؼ�
    for i = 1, CC.MyThingNum do
        if JY.Base["��Ʒ" .. i] > -1 and JY.Base["��Ʒ����" .. i] > 0 then
            local wg = JY.Thing[JY.Base["��Ʒ" .. i]]["�����书"];
            if wg > 0 then
                menu[wg][3] = 1;
            end
        else
            break
        end
    end

    -- ѧ����书
    for i = 1, CC.TeamNum do
        if JY.Base["����" .. i] >= 0 then
            for j = 1, 10 do
                if JY.Person[JY.Base["����" .. i]]["�书" .. j] > 0 then
                    menu[JY.Person[JY.Base["����" .. i]]["�书" .. j]][3] = 1;
                else
                    break
                end
            end
        else
            break
        end
    end

    local r = -1;
    while true do
        Cls();

        r = ShowMenu2(menu, JY.WugongNum - 1, 4, 12, 10, (CC.ScreenH - 12 * (CC.DefaultFont + CC.RowPixel)) / 2 + 20, 0,
            0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE, "��ѡ��鿴���书", r);
        -- local r = ShowMenu(menu,n,15,CC.ScreenW/4,20,0,0,1,1,CC.DefaultFont,C_ORANGE, C_WHITE);

        if r > 0 and r < JY.WugongNum then
            InstruceWuGong(r);
        else
            break
        end
    end

end

-- ��ʾ�书���ڹ���Ч
function InstruceWuGong(id)
    if id < 0 or id >= JY.WugongNum then
        QZXS("�书δ֪�����޷��鿴");
        return;
    end
    local filename = string.format("%s%d.txt", CONFIG.WuGongPath, id)
    if existFile(filename) == false then
        QZXS("���书δ�����κ�˵������������ĥ");
        return;
    end
    DrawTxt(filename);
end

function TSInstruce()
    local filemenu = {};
    local n = 0;
    for i = 1, math.huge do
        if existFile(string.format("%s%d.txt", CONFIG.HelpPath, i)) then
            filemenu[i] = string.format("%s%d.txt", CONFIG.HelpPath, i);
            n = n + 1;
        else
            break
        end
    end

    local menu = {}
    local maxlen = 0;
    for i = 1, n do
        local file = io.open(filemenu[i], "r")
        local str = file:read("*l")

        if str == nil then
            str = " ";
        end

        if #str > maxlen then
            maxlen = #str;
        end

        menu[i] = {i .. str, nil, 1};

        file:close()
    end

    local size = CC.DefaultFont;

    while true do
        Cls();
        -- local r = ShowMenu(menu,n,10,x1,y1,0,0,1,1,size,C_ORANGE,C_WHITE);
        local r = ShowMenu2(menu, #menu, 2, 12, 20, (CC.ScreenH - 12 * (size + CC.RowPixel)) / 2 + 20, 0, 0, 1, 1, size,
            C_ORANGE, C_WHITE);
        if r > 0 then
            InstruceTS(r);
        else
            break
        end
    end
end

-- ��ʾ�书���ڹ���Ч
function InstruceTS(id)

    local filename = string.format("%s%d.txt", CONFIG.HelpPath, id)
    if existFile(filename) == false then
        QZXS("δ�ҵ���صĹ����ļ�");
        return;
    end

    DrawTxt(filename);
end

function DrawTxt(filename)
    Cls();

    -- ��ȡ�ļ�˵��
    local file = io.open(filename, "r")
    local str = file:read("*a")
    file:close()

    local size = CC.DefaultFont;
    local color = C_WHITE;

    local linenum = 50; -- ��ʾ����
    local maxlen = 14;
    local w = linenum * size / 2 + size;
    local h = maxlen * (size + CC.RowPixel) + 2 * CC.RowPixel;

    local bx = (CC.ScreenW - w) / 2;
    local by = (CC.ScreenH - h) / 2;
    DrawBox(bx, by, bx + w, by + h, C_WHITE); -- �ױ߿�
    local x = bx + CC.RowPixel;
    local y = by + CC.RowPixel;

    local surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)

    local strcolor = AnalyString(str)
    local l = 0
    local row = 0;

    for i, v in pairs(strcolor) do
        while 1 do
            if v[1] == nil then
                break
            end
            local index = string.find(v[1], "\n")

            if l + #v[1] < linenum and index == nil then -- ���δ�����У�û���ҵ�����
                DrawString(x + l * size / 2, y + row * (size + CC.RowPixel), v[1], v[2] or color, size);
                l = l + #v[1]

                if i == #strcolor then
                    -- ��ʾ����	ALungky:j �ĳ� j+1�����ĩβ������ʱ���޷���ʾ�����⡣
                    for j = 0, l do
                        lib.SetClip(x, y, x + (j + 1) * size / 2, y + size + row * (size + CC.RowPixel));
                        ShowScreen(1);
                    end
                    lib.SetClip(0, 0, 0, 0);
                end
                break
            else -- ����ﵽ����
                local tmp, pos1, pos2;
                if index == nil then
                    pos1 = linenum - l;
                    pos2 = pos1 + 1;
                else
                    pos1 = index - 1;
                    pos2 = pos1 + 2;

                    if pos1 > linenum - l then
                        index = nil;
                        pos1 = linenum - l;
                        pos2 = pos1 + 1;
                    end
                end

                -- ��������ж��Ƿ��Ѿ�����v[1]��������ݲ���
                if pos1 > #v[1] then
                    tmp = v[1];
                    v[1] = nil;
                else
                    tmp = string.sub(v[1], 1, pos1)
                    local flag = 0
                    for i = 1, pos1 do
                        if string.byte(tmp, i) <= 127 then
                            flag = flag + 1;
                        end
                    end

                    if math.fmod(flag, 2) == 1 and index == nil then -- ��������е��ַ�
                        if string.byte(tmp, -1) > 127 then
                            tmp = string.sub(v[1], 1, pos1 - 1);
                            pos2 = pos2 - 1
                        end
                    end

                    v[1] = string.sub(v[1], pos2);
                end

                DrawString(x + l * size / 2, y + row * (size + CC.RowPixel), tmp, v[2] or color, size);

                l = l + #tmp
                -- ��ʾ����
                for j = 0, l do
                    lib.SetClip(x, y, x + j * size / 2, y + size + row * (size + CC.RowPixel));
                    ShowScreen(1);
                end

                -- ����+1
                row = row + 1
                l = 0

            end

            lib.SetClip(0, 0, 0, 0);

            if row == maxlen then
                WaitKey();
                row = 0;
                Cls();
                lib.LoadSur(surid, 0, 0)

            end
        end
    end
    lib.SetClip(0, 0, 0, 0);
    WaitKey();
    lib.FreeSur(surid)
end

-- ��� ���˷����ҽ���
function NEvent3(keypress)
    if JY.SubScene == 24 and JY.Base["��X1"] == 18 and JY.Base["��Y1"] == 23 and JY.Base["�˷���"] == 2 and
        (keypress == VK_SPACE or keypress == VK_RETURN) and GetS(10, 0, 3, 0) ~= 1 and instruct_16(1) and
        instruct_18(145) then
        say("������������Ѿ��ҵ�ѩɽ�ɺ��Ȿ���ˡ�", 1, 0)
        say(
            "���ţ��ܺã�������ĺ��ҵ���Ҳ������¯�����ˣ��Ժ�Ľ����Ϳ�������Щ�����˵��ˣ��Ȿ��ҽ�������ȥ�ɣ�",
            3, 4)
        say("����л�������", 1, 0)
        instruct_35(1, 1, 44, 0)
        DrawStrBox(-1, -1, "���ѧ����ҽ���", C_ORANGE, CC.DefaultFont)
        ShowScreen()
        lib.Delay(800)
        Cls()
        instruct_2(117, 1)
        SetS(10, 0, 3, 0, 1)
    end
end

-- ��������
function NEvent4(keypress)
    if JY.SubScene == 7 and JY.Base["��X1"] == 34 and JY.Base["��Y1"] == 11 and JY.Base["�˷���"] == 2 then
        -- ������ڶӣ��оŽ��ؼ�
        if instruct_16(35) and instruct_18(114) and GetS(10, 1, 1, 0) ~= 1 and
            (keypress == VK_SPACE or keypress == VK_RETURN) then
            SetS(7, 34, 12, 3, 102)
            instruct_3(7, 102, 1, 0, 0, 0, 0, 7148, 7148, 7148, 0, 34, 12)
            say(
                "�����֣����������ʶһ�¶���ǰ���ķ�ɰ�������ܸо����ԾŽ������µ����򣬵��ֺ�ģ�������ܾ����ܽ������",
                35, 1)
            say("������������������ʱ���ˣ�", 140, 0)
            say("����̫ʦ�壡����", 35, 1)
            instruct_14()
            SetS(7, 33, 12, 3, 101)
            instruct_3(7, 101, 1, 0, 0, 0, 0, 5896, 5896, 5896, 0, 33, 12)
            instruct_13()
            PlayMIDI(24)
            lib.Delay(500)
            say(
                "�����������һ�𳪣��׺�һ��Ц����������������������ֻ�ǽ񳯡�����Ц���׷����ϳ���˭��˭ʤ����֪������ɽЦ������ң�������Ծ��쳾����֪���١����Ц���Ǽ��ȡ����黹ʣһ�����ա�����Ц�����ټ��ȡ��������ڳճ�ЦЦ",
                140, 0)
            say(
                "��������Ž��ļ�������������׸��У����Ѻú�ȥ���ɣ��Ϸ���Ը���ˣ��Ӵ�����ǣ�ң��ʹ�ȥҲ��������������",
                140, 0)
            say(
                "����л̫ʦ�崫���������˼Ҷౣ�أ��ţ������������Ž��İ���ɣ�������",
                35, 1)
            instruct_14()
            instruct_3(7, 101, 0, 0, 0, 0, 0, -1, -1, -1, 0, 33, 12)
            instruct_13()
            DrawStrBox(-1, -1, "���պ�", C_ORANGE, CC.DefaultFont)
            ShowScreen()
            lib.Delay(500)
            say(
                "�����ˣ�����������Ķ��¾Ž���������������ѧ������ǰ��֮�񼼣��򸴺κ���",
                35, 1)
            DrawStrBox(-1, -1, "���������Ž�֮�ش�", C_ORANGE, CC.DefaultFont)
            ShowScreen()
            lib.Delay(500)
            Cls()
            awakening(35, 2) -- �����ڶ��ξ���
            DrawStrBox(-1, -1, "�����ƺű��", C_ORANGE, CC.DefaultFont)
            ShowScreen()
            lib.Delay(500)
            Cls()
            SetS(10, 1, 1, 0, 1)
            instruct_3(7, 102, 0, 0, 0, 0, 0, -1, -1, -1, 0, 34, 12)
        end
    end
end

-- ɽ���¼�
function NEvent6(keypress)
    if JY.SubScene == 10 then
        SetD(10, 28, 4, -1)
        SetS(10, 23, 22, 1, 2)
        SetS(10, 22, 22, 1, 2)
    end
    if JY.SubScene == 59 then
        JY.SubSceneX = 0
        JY.SubSceneY = 0
    end
end

-- �������SYP�Զ�����
function NEvent10(keypress)
    if JY.SubScene == 25 and GetS(10, 0, 9, 0) ~= 1 then
        SetS(25, 9, 44, 3, 103)
        instruct_3(25, 103, 1, 0, 0, 0, 0, 4133 * 2, 4133 * 2, 4133 * 2, 0, -2, -2)
        if JY.Base["��X1"] == 10 and JY.Base["��Y1"] == 44 and JY.Base["�˷���"] == 2 and
            (keypress == VK_SPACE or keypress == VK_RETURN) and GetD(25, 82, 5) == 4662 then
            say("��һ·����������������ˣ������������ɡ�", 596, 0);
            instruct_14()
            for i = 79, 92 do
                instruct_3(25, i, 1, 0, 0, 0, 0, 4664, 4664, 4664, 0, -2, -2)
            end
            for ii = CC.BookStart, CC.BookStart + CC.BookNum - 1 do
                instruct_32(ii, -10)
            end
            -- JY.Base["��������"] = 15
            instruct_3(25, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2)
            instruct_3(25, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2)
            instruct_13()
            say("�����Ѿ��ź��ˣ���������ų�ȥ�ɡ�", 596, 0);
            SetS(10, 0, 9, 0, 1)
            instruct_3(25, 103, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2)

        end
    end
end

-- �󹦷� ��Ԭ��־�Ի��󣬽��߽��黹
function NEvent12(keypress)
    if JY.SubScene == 95 and GetD(95, 4, 5) ~= 0 and JY.Thing[40]["ʹ����"] ~= -1 then
        JY.Person[JY.Thing[40]["ʹ����"]]["����"] = -1
        JY.Thing[40]["ʹ����"] = -1
    end
end

-- ɽ��Ů���ǵľ���
function mm4R()
    local r = LGMsgBox("��ѡ��", "���������أ�", {"����", "����", "����"}, 3, 92)
    if r == 1 then
        JY.Person[92]["��������"] = 0
        Cls() -- ����
    elseif r == 2 then
        JY.Person[92]["��������"] = 1
        Cls() -- ����
    elseif r == 3 then
        JY.Person[92]["��������"] = 2
        Cls() -- ����
    end
    if JY.Person[0]["����"] == 50 then
        JY.Person[92]["����"] = 50
    else
        JY.Person[92]["����"] = 101 - JY.Person[0]["����"]
    end
end

-- �Զ����¼�
function NEvent(keypress)
    -- NEvent2(keypress)		--ʮ�ı�����֮��õ�5000����ϴ����
    NEvent3(keypress) -- ��� ���˷����ҽ���
    NEvent4(keypress) -- ��������
    NEvent6(keypress) -- ֩�붴 ������
    NEvent10(keypress) -- ���������
    NEvent12(keypress) -- �黹���߽�
end

function fzdy()
    lib.Debug("fzdy");
    local bx, by = CC.WX, CC.HY
    local size = CC.DefaultFont
    local x1, y1 = bx * 84, by * 163
    local jg = bx * 30
    local h = 20
    local cont = 1
    local cont1 = 0
    local cot = 1
    local cot1 = 0
    local cot2 = 0
    local fy = 0
    local maxh = 0
    local fymax = 0
    local menu = {{1, 0}, {2, 0}, {4, 0}, {9, 0}, {16, 0}, {17, 0}, {25, 0}, {28, 0}, {29, 0}}
    while true do
        if JY.Restart == 1 then
            break
        end
        Cls()
        lib.LoadPNG(91, 25 * 2, -1, -1, 1)
        local m = menu[cont + cont1 * 4][1]
        local id = cot + cot1 * 4
        local mid = menu[m][id]

        if mid ~= nil then
            local me = {}
            local row = 0
            local maxh = 15
            if TFJS[mid] ~= nil then
                local row = 0
                local maxh = 15
                for i = 1, #TFJS[mid] do
                    me[#me + 1] = TFJS[mid][i]
                    if i == #TFJS[mid] then
                        me[#me + 1] = "��"
                    end
                end
            end
            if CC.PTF[mid] ~= nil then
                for i, v in pairs(CC.PTF[mid]) do
                    if v == 1 then
                        if CC.PTFSM[i] ~= nil then
                            -- me[#me+1] = '��'..CC.PTFSM[i][1]
                            -- me[#me+1] = '��'..CC.PTFSM[i][2]
                            -- me[#me+1] = "��"
                        end
                    end
                end
            end
            for i = 1, 5 do
                if JY.Person[mid]['�츳' .. i] > 0 then
                    local tf = JY.Person[mid]['�츳' .. i]
                    if CC.PTFSM[tf] ~= nil then
                        me[#me + 1] = '��' .. CC.PTFSM[tf][1]
                        me[#me + 1] = '��' .. CC.PTFSM[tf][2]
                        me[#me + 1] = "��"
                    end
                end
            end
            for i = 1, #me do
                local tfstr = me[i]
                local h = 0

                if string.sub(tfstr, 1, 2) == "��" then
                    row = row + 1
                else
                    h = tjm(bx * 300, by * 280 + size * 0.8 * (row - fy), tfstr, C_WHITE, size * 0.8,
                        math.modf((bx * 600) / size / 0.8) - 1, size * 0.8, fy - row, maxh + 1 - row + fy)
                end
                row = row + h
            end

            if row > maxh then
                fymax = limitX(row - maxh - 1, 0)
            else
                fymax = 0
            end
        end
        for i = 1, 4 do
            for j = 1, 5 do
                local id = i + (j - 1 + cot2) * 4
                local mid = menu[m][id]
                if mid ~= nil then
                    local zx = (i - 1) * bx * 140
                    local zy = (j - 1) * size
                    local headid = JY.Person[mid]["������"]
                    lib.LoadPNG(91, headid * 2, zx, zy, 2)
                end
            end
        end
    end
    -- ��ʾ����
    ShowScreen()
    -- ѭ���ļ������ֵ���⣩
    -- lib.Delay(CC.Frame)
    -- X�Ǽ��̲�����ktype����������ktype = 3 ���������4�����Ҽ���6�����ϣ�7������
    local X, ktype, mx, my = lib.GetKey()
end

function fzdy1()
    local bx, by = CC.WX, CC.HY
    local size = CC.DefaultFont
    local xs = 0
    local id = 0
    local menu = {{1, 1}, {2, 0}, {4, 0}, {9, 0}, {16, 0}, {17, 0}, {25, 0}, {28, 0}, {29, 0}}
    while true do
        lib.LoadPNG(91, 63 * 2, -1, -1, 1)
        if JY.Restart == 1 then
            return
        end
        Cls()
        for i = 1, #menu do
            if menu[i][1] ~= nil then
                id = menu[i][1]
            end
        end
        local hd = JY.Person[id]["������"]
        lib.LoadPNG(1, hd * 2, bx * 40, by * 40, 2)
        ShowScreen();
    end
end
function Map_Deliver(menu)
	local bx = CC.WX
	local by = CC.HY
	-- ѡ��
	local tb = 1
	local size = CC.DefaultFont * 0.7
	local cl = C_CYGOLD
	-- ��ͼ���
	local BH;
	local sb;
	-- ��ͼ��ű�
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
			local s = JY.Scene[jn[i]]["����"]

			if JY.Scene[jn[i]]["��������"] == 1  then
				cl = M_DimGray
			end
			if CC.TX['����'] == 1 then 
			if JY.Scene[jn[i]]["��������"] ~= 1 then 
				cl = M_DimGray 
			end
			
			end
			if tb == i then
				cl = C_RED
				BH = jn[i]
				sb = i
			end
			-- ��ʾ��ͼ����
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
			if CC.TX['����'] == 1 and JY.Scene[jn[i]]["��������"] ~= 1  then 
				CC.Shichen = CC.Shichen + 6
				return My_Enter_SubScene(BH, -1, -1, -1);
			else 
				if JY.Scene[BH]["��������"] == 0 then
					CC.Shichen = CC.Shichen + 6
					return My_Enter_SubScene(BH, -1, -1, -1);
				else
					say("������Ŀǰ���ܽ���˳�����", 119, 5, "����");
					return 1
				end
			end
		else
			local mxx = false
			-- ���x�����м�λ���������ߵľ���
			local x_jl = 47
			-- ���y�����м�λ���������ߵľ���
			local y_jl = 12
			local xs;
			local ys;
			local sb1;
			-- xh
			for i = 1, #jnzb do
				-- ���x�����м�λ��
				xs = bx * 212 + bx * jnzb[i][1]
				-- ���y�����м�λ��
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
				if CC.TX['����'] == 1  then 
					if JY.Scene[BH]["��������"] == 1 then
						CC.Shichen = CC.Shichen + 6
						return My_Enter_SubScene(BH, -1, -1, -1);
					else
						say("������ֻ���������˵����ĳ���", 119, 5, "����");
						return 1
					end
				else 
					if JY.Scene[BH]["��������"] == 0 then
						CC.Shichen = CC.Shichen + 6
						return My_Enter_SubScene(BH, -1, -1, -1);
					else
						say("������Ŀǰ���ܽ���˳�����", 119, 5, "����");
						return 1
					end
				end
			end
		end
	end
	return 0
end

-- ��ԭ��ͼ	
function ZYDT()
    local bx = CC.WX
    local by = CC.HY
    -- ѡ��
    local tb = 1
    local size = CC.DefaultFont * 0.7
    local cl = C_CYGOLD
    -- ��ͼ���
    local BH;
    local sb;
    -- ��ͼ��ű�
    local jn = {}
    local jnzb = {}
    for i = 1, #CC.ZYDT do
        jn[i] = CC.ZYDT[i][1]
        jnzb[i] = {CC.ZYDT[i][2], CC.ZYDT[i][3]}
    end
    while true do
        if JY.Restart == 1 then
            break
        end
        ClsN()
        lib.PicLoadCache(92, 31 * 2, -1, -1, 1)
        local x, y = lib.GetPNGXY(91, 11 * 2)
        for i = 1, #jn do
            local cl = C_WHITE
            local s = JY.Scene[jn[i]]["����"]
            if JY.Scene[jn[i]]["��������"] == 1 then
                cl = M_DimGray
            end
            if tb == i then
                cl = C_RED
                BH = jn[i]
                sb = i
            end
            -- ��ʾ��ͼ����

            lib.LoadPNG(91, 11 * 2, bx * 212 + bx * jnzb[i][1] - x / 2, by * 33 + by * jnzb[i][2] - y / 2, 1)
            DrawString(bx * 212 + bx * jnzb[i][1] - string.len(s) / 4 * size, by * 33 + by * jnzb[i][2] - size / 2, s,
                cl, size)
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
            if JY.Scene[BH]["��������"] == 0 then
                CC.Shichen = CC.Shichen + 6
                return My_Enter_SubScene(BH, -1, -1, -1);
            else
                say("������Ŀǰ���ܽ���˳�����", 119, 5, "����");
                return 1
            end
        else
            local mxx = false
            -- ���x�����м�λ���������ߵľ���
            local x_jl = 47
            -- ���y�����м�λ���������ߵľ���
            local y_jl = 12
            local xs;
            local ys;
            local sb1;
            -- xh
            for i = 1, #jnzb do
                -- ���x�����м�λ��
                xs = bx * 212 + bx * jnzb[i][1]
                -- ���y�����м�λ��
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
                if JY.Scene[BH]["��������"] == 0 then
                    CC.Shichen = CC.Shichen + 6
                    return My_Enter_SubScene(BH, -1, -1, -1);
                else
                    say("������Ŀǰ���ܽ���˳�����", 119, 5, "����");
                    return 1
                end
            end
        end
    end
    return 0
end

-- ���ϵ�ͼ
function JNDT()
    local bx = CC.WX
    local by = CC.HY
    -- ѡ��
    local tb = 1
    local size = CC.DefaultFont * 0.7
    local cl = C_CYGOLD
    -- ��ͼ���
    local BH;
    local sb;
    -- ��ͼ��ű�
    local jn = {}
    local jnzb = {}
    for i = 1, #CC.JNDT do
        jn[i] = CC.JNDT[i][1]
        jnzb[i] = {CC.JNDT[i][2], CC.JNDT[i][3]}
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
            local s = JY.Scene[jn[i]]["����"]

            if JY.Scene[jn[i]]["��������"] == 1  then
                cl = M_DimGray
            end
            if CC.TX['����'] == 1 then 
               if JY.Scene[jn[i]]["��������"] ~= 1 then 
                 cl = M_DimGray 
               end
               
            end
            if tb == i then
                cl = C_RED
                BH = jn[i]
                sb = i
            end
            -- ��ʾ��ͼ����
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
            if CC.TX['����'] == 1 and JY.Scene[jn[i]]["��������"] ~= 1  then 
                CC.Shichen = CC.Shichen + 6
                return My_Enter_SubScene(BH, -1, -1, -1);
            else 
                if JY.Scene[BH]["��������"] == 0 then
                    CC.Shichen = CC.Shichen + 6
                    return My_Enter_SubScene(BH, -1, -1, -1);
                else
                    say("������Ŀǰ���ܽ���˳�����", 119, 5, "����");
                    return 1
                end
            end
        else
            local mxx = false
            -- ���x�����м�λ���������ߵľ���
            local x_jl = 47
            -- ���y�����м�λ���������ߵľ���
            local y_jl = 12
            local xs;
            local ys;
            local sb1;
            -- xh
            for i = 1, #jnzb do
                -- ���x�����м�λ��
                xs = bx * 212 + bx * jnzb[i][1]
                -- ���y�����м�λ��
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
                if CC.TX['����'] == 1  then 
                    if JY.Scene[BH]["��������"] == 1 then
                        CC.Shichen = CC.Shichen + 6
                        return My_Enter_SubScene(BH, -1, -1, -1);
                    else
                        say("������ֻ���������˵����ĳ���", 119, 5, "����");
                        return 1
                    end
                else 
                    if JY.Scene[BH]["��������"] == 0 then
                        CC.Shichen = CC.Shichen + 6
                        return My_Enter_SubScene(BH, -1, -1, -1);
                    else
                        say("������Ŀǰ���ܽ���˳�����", 119, 5, "����");
                        return 1
                    end
                end
            end
        end
    end
    return 0
end

-- ������ͼ
function XBDT()
    local bx = CC.WX
    local by = CC.HY
    -- ѡ��
    local tb = 1
    local size = CC.DefaultFont * 0.7
    local cl = C_CYGOLD
    -- ��ͼ���
    local BH;
    local sb;
    -- ��ͼ��ű�
    local jn = {}
    local jnzb = {}
    for i = 1, #CC.XBDT do
        jn[i] = CC.XBDT[i][1]
        jnzb[i] = {CC.XBDT[i][2], CC.XBDT[i][3]}
    end
    while true do
        if JY.Restart == 1 then
            break
        end
        ClsN()

        lib.PicLoadCache(92, 30 * 2, -1, -1, 1)
        local x, y = lib.GetPNGXY(91, 11 * 2)
        for i = 1, #jn do
            local cl = C_WHITE
            local s = JY.Scene[jn[i]]["����"]
            if JY.Scene[jn[i]]["��������"] == 1 then
                cl = M_DimGray
            end
            if tb == i then
                cl = C_RED
                BH = jn[i]
                sb = i
            end
            -- ��ʾ��ͼ����

            lib.LoadPNG(91, 11 * 2, bx * 212 + bx * jnzb[i][1] - x / 2, by * 33 + by * jnzb[i][2] - y / 2, 1)
            DrawString(bx * 212 + bx * jnzb[i][1] - string.len(s) / 4 * size, by * 33 + by * jnzb[i][2] - size / 2, s,
                cl, size)
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
            if JY.Scene[BH]["��������"] == 0 then
                CC.Shichen = CC.Shichen + 6
                return My_Enter_SubScene(BH, -1, -1, -1);
            else
                say("������Ŀǰ���ܽ���˳�����", 119, 5, "����");
                return 1
            end
        else
            local mxx = false
            -- ���x�����м�λ���������ߵľ���
            local x_jl = 47
            -- ���y�����м�λ���������ߵľ���
            local y_jl = 12
            local xs;
            local ys;
            local sb1;
            -- xh
            for i = 1, #jnzb do
                -- ���x�����м�λ��
                xs = bx * 212 + bx * jnzb[i][1]
                -- ���y�����м�λ��
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
                if JY.Scene[BH]["��������"] == 0 then
                    CC.Shichen = CC.Shichen + 6
                    return My_Enter_SubScene(BH, -1, -1, -1);
                else
                    say("������Ŀǰ���ܽ���˳�����", 119, 5, "����");
                    return 1
                end
            end
        end
    end
    return 0
end

-- ������ͼ
function BBDT()
    local bx = CC.WX
    local by = CC.HY
    -- ѡ��
    local tb = 1
    local size = CC.DefaultFont * 0.7
    local cl = C_WHITE
    -- ��ͼ���
    local BH;
    local sb;
    local jn = {}
    local jnzb = {}
    for i = 1, #CC.BBDT do
        jn[i] = CC.BBDT[i][1]
        jnzb[i] = {CC.BBDT[i][2], CC.BBDT[i][3]}
    end
    while true do
        if JY.Restart == 1 then
            break
        end
        ClsN()

        lib.PicLoadCache(92, 29 * 2, -1, -1, 1)
        local x, y = lib.GetPNGXY(91, 11 * 2)
        for i = 1, #jn do
            local cl = C_WHITE
            local s = JY.Scene[jn[i]]["����"]
            if JY.Scene[jn[i]]["��������"] == 1 then
                cl = M_DimGray
            end
            if tb == i then
                cl = C_RED
                BH = jn[i]
                sb = i
            end
            -- ��ʾ��ͼ����

            lib.LoadPNG(91, 11 * 2, bx * 212 + bx * jnzb[i][1] - x / 2, by * 33 + by * jnzb[i][2] - y / 2, 1)
            DrawString(bx * 212 + bx * jnzb[i][1] - string.len(s) / 4 * size, by * 33 + by * jnzb[i][2] - size / 2, s,
                cl, size)
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
            if JY.Scene[BH]["��������"] == 0 then
                CC.Shichen = CC.Shichen + 6
                return My_Enter_SubScene(BH, -1, -1, -1);
            else
                say("������Ŀǰ���ܽ���˳�����", 119, 5, "����");
                return 1
            end
        else
            local mxx = false
            -- ���x�����м�λ���������ߵľ���
            local x_jl = 47
            -- ���y�����м�λ���������ߵľ���
            local y_jl = 12
            local xs;
            local ys;
            local sb1;
            -- xh
            for i = 1, #jnzb do
                -- ���x�����м�λ��
                xs = bx * 212 + bx * jnzb[i][1]
                -- ���y�����м�λ��
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
                if JY.Scene[BH]["��������"] == 0 then
                    CC.Shichen = CC.Shichen + 6
                    return My_Enter_SubScene(BH, -1, -1, -1);
                else
                    say("������Ŀǰ���ܽ���˳�����", 119, 5, "����");
                    return 1
                end
            end
        end
    end
    return 0
end

-- �����ͼ
function HWDT()
    local bx = CC.WX
    local by = CC.HY
    -- ѡ��
    local tb = 1
    local size = CC.DefaultFont * 0.7
    local cl = C_CYGOLD
    -- ��ͼ���
    local BH;
    local sb;
    local jn = {}
    local jnzb = {}
    for i = 1, #CC.HWDT do
        jn[i] = CC.HWDT[i][1]
        jnzb[i] = {CC.HWDT[i][2], CC.HWDT[i][3]}
    end
    while true do
        if JY.Restart == 1 then
            break
        end
        ClsN()

        lib.PicLoadCache(92, 33 * 2, -1, -1, 1)
        local x, y = lib.GetPNGXY(91, 11 * 2)
        for i = 1, #jn do
            local cl = C_WHITE
            local s = JY.Scene[jn[i]]["����"]
            if JY.Scene[jn[i]]["��������"] == 1 then
                cl = M_DimGray
            end
            if tb == i then
                cl = C_RED
                BH = jn[i]
                sb = i
            end
            -- ��ʾ��ͼ����

            lib.LoadPNG(91, 11 * 2, bx * 212 + bx * jnzb[i][1] - x / 2, by * 33 + by * jnzb[i][2] - y / 2, 1)
            DrawString(bx * 212 + bx * jnzb[i][1] - string.len(s) / 4 * size, by * 33 + by * jnzb[i][2] - size / 2, s,
                cl, size)
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
            if JY.Scene[BH]["��������"] == 0 then
                CC.Shichen = CC.Shichen + 6
                return My_Enter_SubScene(BH, -1, -1, -1);

            else
                say("������Ŀǰ���ܽ���˳�����", 119, 5, "����");
                return 1
            end
        else
            local mxx = false
            -- ���x�����м�λ���������ߵľ���
            local x_jl = 47
            -- ���y�����м�λ���������ߵľ���
            local y_jl = 12
            local xs;
            local ys;
            local sb1;
            -- xh
            for i = 1, #jnzb do
                -- ���x�����м�λ��
                xs = bx * 212 + bx * jnzb[i][1]
                -- ���y�����м�λ��
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
                if JY.Scene[BH]["��������"] == 0 then
                    CC.Shichen = CC.Shichen + 6
                    return My_Enter_SubScene(BH, -1, -1, -1);
                else
                    say("������Ŀǰ���ܽ���˳�����", 119, 5, "����");
                    return 1
                end
            end
        end
    end
    return 0
end

-- ��ͼ�˵�
function NEWCS()

    local bx = CC.WX
    local by = CC.HY
    -- ѡ��
    local tb = 1
    local size = CC.DefaultFont * 0.7
    local cl = C_CYGOLD
    -- ��ͼ���
    local ddtx;
    local ddty;
    local sb;
    -- ��ͼ��ű�
    -- ��ͼ������ʾλ��
    local m1 = {"����", "����", "��ԭ", "����", "���⵺��"}
    local m2 = {BBDT, XBDT, ZYDT, JNDT, HWDT}
    local zb = {{212, 35}, -- bb
    {212, 267}, -- xb
    {525, 267}, -- zy
    {525.5, 505}, -- jn
    {837.5, 35} -- hw
    }
    local wzzb = {{381, 104}, {297, 351}, {567, 335}, {567, 529}, {938, 13}}
    while true do
        if JY.Restart == 1 then
            break
        end
        ClsN()
        lib.PicLoadCache(92, 39 * 2, -1, -1, 1)
        for j = 1, #m1 do
            local name = m1[j]
            local wzcl = RGB(202, 194, 38)
            local h = size * 4
            local name1 = string.sub(name, 1, 2)
            local name2 = string.sub(name, 3, 4)
            local name3 = string.sub(name, 5, 6)
            local name4 = string.sub(name, 7, 8)
            if j == 2 or j == 5 then
                lib.DrawStr(bx * wzzb[j][1], by * wzzb[j][2], name1, wzcl, size * 4, CONFIG.CurrentPath .. "FONT/2.ttf",
                    0, 0)
                lib.DrawStr(bx * wzzb[j][1], by * wzzb[j][2] + h, name2, wzcl, size * 4,
                    CONFIG.CurrentPath .. "FONT/2.ttf", 0, 0)
                lib.DrawStr(bx * wzzb[j][1], by * wzzb[j][2] + h * 2, name3, wzcl, size * 4,
                    CONFIG.CurrentPath .. "FONT/2.ttf", 0, 0)
                lib.DrawStr(bx * wzzb[j][1], by * wzzb[j][2] + h * 3, name4, wzcl, size * 4,
                    CONFIG.CurrentPath .. "FONT/2.ttf", 0, 0)
            else
                lib.DrawStr(bx * wzzb[j][1], by * wzzb[j][2], name, wzcl, size * 4, CONFIG.CurrentPath .. "FONT/2.ttf",
                    0, 0)
            end
            local yy = 33 + j
            if tb ~= j then
                lib.PicLoadCache(92, (yy) * 2, bx * zb[j][1], by * zb[j][2], 1)
            end
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
                tb = #m2
            end
        elseif X == VK_DOWN or X == VK_RIGHT then
            PlayWavE(77)
            tb = tb + 1
            if tb > #m2 then
                tb = 1
            end
        elseif X == VK_SPACE or X == VK_RETURN then
            PlayWavE(77)
            return m2[tb]()
        else
            local mxx = false
            if mx >= bx * 212 + bx * 0 and mx <= bx * 212 + bx * 624 and my >= 0 and my <= by * 33 + by * 232 then
                tb = 1
                mxx = true
            elseif mx >= bx * 212 + bx * 0 and mx <= bx * 212 + bx * 313 and my >= 233 and my <= by * 33 + by * 702 then
                tb = 2
                mxx = true
            elseif mx >= bx * 212 + bx * 313 and mx <= bx * 212 + bx * 623 and my >= 233 and my <= by * 33 + by * 470 then
                tb = 3
                mxx = true
            elseif mx >= bx * 212 + bx * 313 and mx <= bx * 212 + bx * 623 and my >= 471 and my <= by * 33 + by * 702 then
                tb = 4
                mxx = true
            elseif mx >= bx * 212 + bx * 624 and mx <= bx * 212 + bx * 936 and my >= 0 and my <= by * 33 + by * 702 then
                tb = 5
                mxx = true
            end
            if mxx == true and ktype == 3 then
                PlayWavE(77)
                return m2[tb]()
            end
        end
    end
    return 0
end

function CHUANSONG()
    if CC.TX['��'] == 0 then
        NEWCS()
    elseif CC.TX['��'] == 1 then
        My_ChuangSong_List()
    end
end

-- ״̬ҳװ��˵��
function wupin_info(thingID)
    local bx = CC.WX
    local by = CC.HY
    local str = JY.Thing[thingID]["����"] .. JY.Thing[thingID]["����"]
    local str2 = JY.Thing[thingID]["��Ʒ˵��"]
    local str3 = JY.Thing[thingID]["����"]
    if ItemInfo[thingID] == nil then
        return
    end
    local info = {}
    -- info = ItemInfo[thingID]
    info = ItemInfo[thingID]
    local function strcolor_switch(s)
        local Color_Switch = {{"��", PinkRed}, {"��", C_GOLD}, {"��", C_BLACK}, {"��", C_WHITE}, {"��", C_ORANGE},
                              {"��", LimeGreen}, {"��", M_DeepSkyBlue}, {"��", Violet}}
        for i = 1, 8 do
            if Color_Switch[i][1] == s then
                return Color_Switch[i][2]
            end
        end
    end
    local maxRowExisting = #info -- ��ǰ˵��������
    local maxRowDisplayable = 18 -- ����ҳ�������ʾ���������
    if maxRowDisplayable > maxRowExisting - 1 then
        maxRowDisplayable = maxRowExisting - 1
    end
    local startingRow = 1
    local size = CC.DefaultFont * 0.7
    local row = 1
    local fy = 0
    local fymax = 0
    local h = 0
    lib.PicLoadCache(92, 66 * 2, bx * 560, by * 114, 1)
    DrawString(bx * 566, by * 111, str3, C_GOLD, size)
    local row = 1
    for i = startingRow, startingRow + maxRowDisplayable do
        local tfstr = info[i]
        if string.sub(tfstr, 1, 2) == "��" then
            -- row = row + 1
        else
            local color;
            color = strcolor_switch(string.sub(tfstr, 1, 2))
            tfstr = string.sub(tfstr, 3, -1)
            h =
                tjm(bx * 566, by * 111 + size * 0.9 * (row - fy), tfstr, color, size * 0.9, 14, size * 0.9, fy - row, 20)
            row = row + h
        end
    end
    ShowScreen()
    local keypress, ktype, mx, my = WaitKey(1)
end

function DrawStrBoxYesNo1(x, y, str, color, size)
    local bx = CC.WX
    local by = CC.HY
    local ll = #str
    local w = size * ll / 2 + 2 * CC.MenuBorderPixel
    local h = size + 2 * CC.MenuBorderPixel
    local bx = CC.WX
    local by = CC.HY
    local zb = {{348, 386}, {433, 386}}
    local tb = 1
    local strArray = {}
    local xnum, ynum, width, height = nil, nil, nil, nil
    local x1, x2, y1, y2 = nil, nil, nil, nil
    local cx, cy = 0, 0;
    local lb = 0
    -- local color 
    lib.PicLoadCache(92, 42 * 2, bx * 288, by * 316, 1)
    while true do
        if JY.Restart == 1 then
            break
        end

        if x == -1 then
            x = (CC.ScreenW - size / 2 * ll - 2 * CC.MenuBorderPixel) / 2
        end
        if y == -1 then
            y = (CC.ScreenH - size - 2 * CC.MenuBorderPixel) / 2
        end

        ynum, strArray = Split(str, "*")
        xnum = 0
        width = CC.MenuBorderPixel * 2 + math.modf(size * xnum / 2)
        height = CC.MenuBorderPixel * 2 + (size + CC.MenuBorderPixel) * ynum

        y2 = height
        height = height + CC.MenuBorderPixel * 2 + size * 2
        x1 = (CC.ScreenW - (width)) / 2 + CC.MenuBorderPixel
        x2 = x1
        y1 = (CC.ScreenH - (height)) / 2 + CC.MenuBorderPixel + 2 + size * 0.7
        y2 = y2 + (y1) - 5
        for i = 1, ynum do
            local len = string.len(strArray[i])
            if xnum < len then
                xnum = len
            end
        end
        for i = 1, ynum do
            DrawString(bx * 400 + size - string.len(strArray[i]) / 4 * size, by * 327 + (i - 1) * size * 0.7,
                strArray[i], C_WHITE, size * 0.7)
        end
        -- tjm2(str,2)
        -- DrawString(x, y, str, color, size*0.7)
        local menu = {{"ȷ��", nil, 1}, {"ȡ��", nil, 2}}
        for i = 1, #menu do
            local cl = C_CYGOLD
            if tb == i then
                cl = C_RED
            end
            DrawString(bx * zb[i][1], by * zb[i][2], menu[i][1], cl, size * 0.8)
        end
        ShowScreen()
        lib.Delay(CC.Frame)
        local X, ktype, mx, my = lib.GetKey();
        -- if X == VK_ESCAPE or ktype == 4 then
        -- return 0
        if X == VK_UP or X == VK_LEFT then
            PlayWavE(77)
            tb = tb - 1
            if tb < 1 then
                tb = 2
            end
        elseif X == VK_DOWN or X == VK_RIGHT then
            PlayWavE(77)
            tb = tb + 1
            if tb > 2 then
                tb = 1
            end
        elseif X == VK_SPACE or X == VK_RETURN then
            PlayWavE(77)
            if tb == 1 then
                return true
            elseif tb == 2 then
                return false
            end
        else
            local mxx = false
            local jl = 35
            local xs;
            local ys;
            local sb1;
            -- xh
            for i = 1, #zb do
                xs = bx * zb[i][1]
                ys = by * zb[i][2]
                sb1 = zb[i]
                if mx >= xs - jl and mx <= xs + jl and my >= ys - jl and my <= ys + jl then
                    tb = i
                    mxx = true
                    break
                end
            end
            if mxx == true and ktype == 3 then
                PlayWavE(77)
                if tb == 1 then
                    return true
                else
                    return 0
                end
            end
        end
    end
end

function Pqfcz(id)
    local cz = 0
    local qz = JY.Person[id]["ȭ�ƹ���"]
    local rwfj = JY.Person[id]["ȭ���ɳ�"]
    cz = rwfj + qz / 5
    string.format("%.2f", cz)
    return cz
end

function Pzfcz(id)
    local cz = 0
    local qz = JY.Person[id]["ָ������"]
    local rwfj = JY.Person[id]["ָ���ɳ�"]
    cz = rwfj + qz / 5
    string.format("%.2f", cz)
    return cz
end

function Pjfcz(id)
    local cz = 0
    local qz = JY.Person[id]["��������"]
    local rwfj = JY.Person[id]["�����ɳ�"]
    cz = rwfj + qz / 5
    string.format("%.2f", cz)
    return cz
end

function Pdfcz(id)
    local cz = 0
    local qz = JY.Person[id]["ˣ������"]
    local rwfj = JY.Person[id]["�����ɳ�"]
    cz = rwfj + qz / 5
    string.format("%.2f", cz)
    return cz
end

function Pqmcz(id)
    local cz = 0
    local qz = JY.Person[id]["�������"]
    local rwfj = JY.Person[id]["���ųɳ�"]
    cz = rwfj + qz / 5
    string.format("%.2f", cz)
    return cz
end

function Paqcz(id)
    local cz = 0
    local qz = JY.Person[id]["��������"]
    local rwfj = JY.Person[id]["�����ɳ�"]
    cz = rwfj + qz / 5
    string.format("%.2f", cz)
    return cz
end

---����д������
function numberToString(szNum)
    ---����������ת���Ĵ�д
    local szChMoney = ""
    local iLen = 0
    local iNum = 0
    local iAddZero = 0
    local hzUnit = {"", "ʮ", "��", "ǧ", "��", "ʮ", "��", "ǧ", "��", "ʮ", "��", "ǧ", "��", "ʮ",
                    "��", "ǧ"}
    local hzNum = {"��", "һ", "��", "��", "��", "��", "��", "��", "��", "��"}
    if nil == tonumber(szNum) then
        return tostring(szNum)
    end
    iLen = string.len(szNum)
    if iLen > 10 or iLen == 0 or tonumber(szNum) < 0 then
        return tostring(szNum)
    end
    for i = 1, iLen do
        iNum = string.sub(szNum, i, i)
        if iNum == 0 and i ~= iLen then
            iAddZero = iAddZero + 1
        else
            if iAddZero > 0 then
                szChMoney = szChMoney .. hzNum[1]
            end
            szChMoney = szChMoney .. hzNum[iNum + 1] -- //ת��Ϊ��Ӧ������
            iAddZero = 0
        end
        if (iAddZero < 4) and (0 == (iLen - i) % 4 or 0 ~= tonumber(iNum)) then
            szChMoney = szChMoney .. hzUnit[iLen - i + 1]
        end
    end
    local function removeZero(num)
        -- ȥ��ĩβ����� ��
        num = tostring(num)
        local szLen = string.len(num)
        local zero_num = 0
        for i = szLen, 1, -3 do
            szNum = string.sub(num, i - 2, i)
            if szNum == hzNum[1] then
                zero_num = zero_num + 1
            else
                break
            end
        end
        num = string.sub(num, 1, szLen - zero_num * 3)
        szNum = string.sub(num, 1, 6)
        --- ��ͷ�� "һʮ" ת�� "ʮ" , �����˵Ķ���
        if szNum == hzNum[2] .. hzUnit[2] then
            num = string.sub(num, 4, string.len(num))
        end
        return num
    end
    return removeZero(szChMoney)
end

function Tianfu(teamid)
    lib.Debug("Tianfu")
    local bx = CC.WX
    local by = CC.HY
    local STARTH = 0
    local FY = 0
    local id = teamid
    local p = JY.Person[id]
    local lb = 1
    local SHUOMING = 0
    while true do
        if JY.Restart == 1 then
            break
        end
        Cls()
        lib.LoadPNG(91, 19 * 2, -1, -1, 1)

        local size = CC.FontSmall4
        local size1 = CC.DefaultFont * 0.9
        DrawString(bx * 212 + bx * 515 - string.len(JY.Person[id]["����"]) / 2 * size1, by * 73 + by * 33,
            JY.Person[id]["����"], C_CYGOLD, size1)
        local myh = 18
        local hs = 0
        local me = {}
        local bz = {'ȭ', 'ָ', '��', '��', '��', '�', '��', 'ҽ', '��'}
        -- �츳ID
        -- local tfid;
        -- �츳ID
        local tfid;
        -- ����
        if id == 0 then
            -- ����
            if JY.Base["��׼"] > 0 then
                tfid = 546 + JY.Base["��׼"]
                -- ����
            elseif JY.Base["����"] > 0 then
                tfid = ''
                -- ����
            else
                tfid = JY.Base["����"]
                -- ����Ԭ��־
                if tfid == 54 and JY.Person[id]["���˾���"] >= 1 then
                    tfid = "54-1"
                    -- ����ʯ����
                elseif tfid == 38 and JY.Person[id]["���˾���"] >= 1 then
                    tfid = "38-1"
                    -- �������
                elseif tfid == 626 and JY.Person[id]["���˾���"] >= 1 then
                    tfid = "626-1"
                end
            end
            -- ����
        else
            tfid = id
            -- Ԭ��־
            if id == 54 and JY.Person[id]["���˾���"] >= 1 then
                tfid = "54-1"
                -- ʯ����
            elseif id == 38 and JY.Person[id]["���˾���"] >= 1 then
                tfid = "38-1"
                -- ����
            elseif id == 626 and JY.Person[id]["���˾���"] >= 1 then
                tfid = "626-1"
            end
        end
        local mid = tfid
        local size = CC.DefaultFont
        if JY.Base["��׼"] > 0 and id == 0 then
            mid = bz[JY.Base["��׼"]]
        end
        if TFJS[mid] ~= nil then
            for i = 1, #TFJS[mid] do
                me[#me + 1] = TFJS[mid][i]
                if i == #TFJS[mid] then
                    me[#me + 1] = "��"
                end
            end
        end
        if id == 0 then
            if JY.Base["����"] > 0 then
                tfid = 0
            end
        end
    end
end

---------------------------���---------------------
-- �޾Ʋ������ж�һ�������Ƿ������һ�����������
function TaohuaJJ(id)
    -- �����Զ�����
    local pd = false
    if (PersonKF(id, 12) and PersonKF(id, 18) and PersonKF(id, 38)) or match_ID(id, 626) then
        return true
    end
    return false
end

-- �޾Ʋ������ж�һ�������Ƿ������������޵�����
function ZiqiTL(id)
    local pd = false
    if PersonKF(id, 5) and PersonKF(id, 9) and PersonKF(id, 21) and PersonKF(id, 118) then
        return true
    end
    return false
end

-- �޾Ʋ������ж�һ�������Ƿ������������ɵ�����
function WoYuCX(id)
    local pd = false
    if PersonKF(id, 8) and PersonKF(id, 14) and PersonKF(id, 201) and PersonKF(id, 202) then
        return true
    end
    return false
end

-- �޾Ʋ������ж�һ�������Ƿ����㶾�����ֵ�����
function DubuWL(id)
    local pd = false
    if PersonKF(id, 3) and PersonKF(id, 120) and PersonKF(id, 220) and PersonKF(id, 295) and PersonKF(id, 334) then
        return true
    end
    return false
end

-- �޾Ʋ������ж�һ�������Ƿ�����ȱ�Ϊ��������
function Cbwh(id)
    local pd = false
    if PersonKF(id, 57) and PersonKF(id, 346) then
        return true
    end
    return false
end

-- �޾Ʋ������ж�һ�������Ƿ�����������Ȼ�ڵ�����
function Tjyrz(id)
    local pd = false
    if PersonKF(id, 13) and PersonKF(id, 143) and PersonKF(id, 196) and Curr_NG(id, 196) then
        return true
    end
    return false
end

-- �޾Ʋ������ж�һ�������Ƿ������廢�ֶ���������
function Wuhu(id)
    local pd = false
    if PersonKF(id, 59) and PersonKF(id, 232) then
        return true
    end
    return false
end

-- �޾Ʋ������ж�һ�������Ƿ�����ʮ��̫������������
function Sstbhl(id)
    local pd = false
    if match_ID(id, 603) or match_ID(id, 9807) then
        return true
    end
    return false
end

-- �޾Ʋ������ж�һ�������Ƿ�����Ѫսɳ��������
function XueZhanShangChang(id)
    local pd = false
    if PersonKF(id, 200) and PersonKF(id, 198) and PersonKF(id, 199) then
        return true
    end
    return false
end

-- �޾Ʋ������ж�һ�������Ƿ�������������������
function SuZhiSanLian(id)
    local pd = false
    if PersonKF(id, 29) and PersonKF(id, 114) then
        return true
    end
    return false
end

-- ��հ���
function JinGangBR(id)
    local pd = false
    if PersonKF(id, 22) and PersonKF(id, 189) and PersonKF(id, 103) then
        return true
    end
    return false
end

-- �޾Ʋ������ж�һ�������Ƿ�������ɵ�������
function DaoKeDao(id)
    local pd = false
    if PersonKF(id, 64) and PersonKF(id, 236) then
        return true
    end
    return false
end

-- �޾Ʋ������ж�һ�������Ƿ�����糤��ǿ������
function CunChangCunQiang(id)
    local pd = false
    if PersonKF(id, 165) and PersonKF(id, 206) then
        return true
    end
    return false

end

-- �޾Ʋ������ж�һ�������Ƿ����㽣�����ĵ�����
function JiandanQX(id)
    local pd = false
    if PersonKF(id, 47) and PersonKF(id, 73) then
        return true
    end
    return false
end

-- �޾Ʋ������ٻ���ԭ������+ȼľ+���浶
function JuHuoLY(id)
    local pd = false
    if PersonKF(id, 61) and PersonKF(id, 65) and PersonKF(id, 66) then
        return true
    end
    return false
end

-- ����ħ ��ħ�� ��շ�ħȦ ��ħ�ȷ� �޺���ħ��
function ShiZunXM(id)
    local pd = false
    if PersonKF(id, 96) and PersonKF(id, 82) and PersonKF(id, 83) and PersonKF(id, 86) then
        return true
    end
    return false
end

-- ����ӳѩ
function JinwuYingXue(id)
    local pd = false
    if PersonKF(id, 35) and PersonKF(id, 61) then
        return true
    end
    return false
end

-- �����Ὥ
function TieSuoHengJiang(id)
    local pd = false
    if PersonKF(id, 76) and PersonKF(id, 79) then
        return true
    end
    if match_ID(id, 594) or match_ID(id, 9892) then
        return true
    end
    return false
end

-- ˫���ϱ� ȫ�潣�� + ��Ů��
function ShuangJianHB(id)
    if PersonKF(id, 39) and (PersonKF(id, 42) or PersonKF(id, 139)) and JY.Person[id]['���һ���'] == 1 then
        return true
    end
    return false
end

-- �޾Ʋ��������к��棬����+����+����
function LiRenHF(id)
    if PersonKF(id, 58) and PersonKF(id, 153) and PersonKF(id, 174) then
        return true
    end
    return false

end

-- ��ң���� and JY.Person[240]["Ʒ��"] == 50
function XiaoYaoYF(id)
    if ((PersonKF(id, 85) and PersonKF(id, 98) and PersonKF(id, 101)) or match_ID_awakened(id, 634, 1)) and
        (JY.Person[240]["Ʒ��"] == 80 or not isteam(id)) then
        return true
    end
    return false
end

-- �޺�����
function LuoHanJinShen(id)
    if PersonKF(id, 96) and PersonKF(id, 144) then
        return true
    end
    return false
end

-- �޾Ʋ�����̫��+���ƣ�����˸�
function YiRouKG(id)
    if PersonKF(id, 36) and PersonKF(id, 46) then
        return true
    end
    return false
end
-- �޾Ʋ������ж�һ�������Ƿ����������޷������
function TianYiWF(id)
    if PersonKF(id, 54) and PersonKF(id, 62) then
        return true
    end
    return false
end

-- ͬʱ��������Ҷָ/�����޶�ָ/�����ָ/�黨ָ����
function ChuQueSX(id)
    if PersonKF(id, 132) and PersonKF(id, 133) and PersonKF(id, 136) and PersonKF(id, 137) then
        return true
    end
    return false
end

function HuXiaoLY(id)
    if PersonKF(id, 244) and PersonKF(id, 187) then
        return true
    end
    return false
end

function Taikongxj(id)
    if PersonKF(id, 15) and PersonKF(id, 16) then
        return true
    end
    return false
end

function xm(id)
    if TaohuaJJ(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 5 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 5
                    break
                end
            end
        end
    end
    if ZiqiTL(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 6 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 6
                    break
                end
            end
        end
    end
    if WoYuCX(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 7 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 7
                    break
                end
            end
        end
    end
    if DubuWL(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 8 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 8
                    break
                end
            end
        end
    end
    if Cbwh(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 9 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 9
                    break
                end
            end
        end
    end
    if Tjyrz(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 10 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 10
                    break
                end
            end
        end
    end
    if Wuhu(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 11 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 11
                    break
                end
            end
        end
    end
    if Sstbhl(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 12 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 12
                    break
                end
            end
        end
    end
    if XueZhanShangChang(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 13 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 13
                    break
                end
            end
        end
    end
    if SuZhiSanLian(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 14 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 14
                    break
                end
            end
        end
    end
    if JinGangBR(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 15 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 15
                    break
                end
            end
        end
    end
    if DaoKeDao(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 16 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 16
                    break
                end
            end
        end
    end
    if CunChangCunQiang(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 17 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 17
                    break
                end
            end
        end
    end
    if JiandanQX(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 18 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 18
                    break
                end
            end
        end
    end
    if JuHuoLY(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 19 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 19
                    break
                end
            end
        end
    end
    if ShiZunXM(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 20 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 20
                    break
                end
            end
        end
    end
    if JinwuYingXue(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 21 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 21
                    break
                end
            end
        end
    end
    if TieSuoHengJiang(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 22 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 22
                    break
                end
            end
        end
    end
    if ShuangJianHB(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 23 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 23
                    break
                end
            end
        end
    end
    if LiRenHF(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 24 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 24
                    break
                end
            end
        end
    end
    if XiaoYaoYF(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 25 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 25
                    break
                end
            end
        end
    end
    if LuoHanJinShen(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 26 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 26
                    break
                end
            end
        end
    end
    if YiRouKG(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 27 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 27
                    break
                end
            end
        end
    end
    if TianYiWF(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 36 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 36
                    break
                end
            end
        end
    end
    if ChuQueSX(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 37 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 37
                    break
                end
            end
        end
    end
    if HuXiaoLY(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 38 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 38
                    break
                end
            end
        end
    end
    if Taikongxj(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["�ؼ�" .. i] == 39 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["�ؼ�" .. i] == 0 then
                    JY.Person[id]["�ؼ�" .. i] = 39
                    break
                end
            end
        end
    end
end

-- ����ż��
function IsOuNumber(num)
    local num1, num2 = math.modf(num / 2) -- ����������С������
    if (num2 == 0) then
        return true
    else
        return false
    end
end

-- �Ϲ��Զ���ȡ�ñ�������ֵ
-- tableParmater �� ���������������������Ϸ�������� nil
function GetTableMax(tableParmater)
    -- ����ʹ�þֲ��������ͷſռ�
    local returnMaxNumber = nil
    -- ������飨�����Ƿ���ȷ��
    if (type(tableParmater) ~= "table") then
        print("��������������ǺϷ�������")
        return nil
    end

    for i, j in pairs(tableParmater) do
        -- �������ֵ returnMaxNumber ������ֵ
        if (returnMaxNumber == nil) then
            returnMaxNumber = j
        end
        -- ȡ��������ֵ
        if (j > returnMaxNumber) then
            returnMaxNumber = j
        end
    end
    return returnMaxNumber
end

-- �书�˵�˵��
function LGShowMenu_kf(menu, maxh, maxw, title, r)
    local bx, by = CC.ScreenW / 1360, CC.ScreenH / 768
    local id = 0
    local cury = 0
    local wz = ''
    local bx = CC.ScreenW / 936
    local by = CC.ScreenH / 702
    local size2 = CC.DefaultFont * 0.7
    local size, size1 = CC.DefaultFont * 0.9, CC.DefaultFont -- �ֺ�
    local w1, h1 = lib.GetPNGXY(91, 139 * 2)
    local x, y = CC.ScreenW / 5.3, CC.ScreenH / 7
    local x1 = x * 2 - x / 3
    local y1 = y * 3 / 2 + y / 3 + y / 10
    local yy = h1 * 3 / 2
    local xx = w1 * 8 / 7
    local color = C_WHITE
    local page = 1
    local hh1 = 0
    local tob = 1
    local tb1 = 0
    local kfsm = 0
    local kf1 = 0
    local wgmenu = {}
    local kflx = 0
    local wgzbx, wgzby = CC.ScreenW / 3, CC.ScreenH / 2 - size * 6.5
    local jjwz = {"�����ž�", "�����ž�", "����С��", "����С��", "����Ѿ�", "����Ѿ�",
                  "�ڻ��ͨ", "�ڻ��ͨ", "¯����", "¯����", "�Ƿ��켫"}
    local djwz = {"һ", "��", "��", "��", "��", "��", "��", "��", "��", "ʮ", "��"}
    local pjwz = {"��" .. "�����书", "��" .. "�н��书", "��" .. "�߽��书", "��" .. "��ѧ�书"}
    local color = RGB(248, 248, 181)
    local zsh, zsw = size * 1.5, size * 1.1 -- ��ʽ���ֵ������������
    local tb4 = 1
    local STARTH1, WGSTARTH, WGSTARTH1, Mstarth = 0, 0, 0, 0
    local FY1, h, h2, SHUOMING, xlsm, Mfy = 0, 0, 0, 0, 0, 0
    local zsnum, hg, sf, FY, WGFY, WGFY1 = 0, 40, 0, 0, 0, 0
    local menu1 = 0
    if #menu <= 0 then
        return
    end
    -- menu[#menu+1] = -1
    local hs = math.ceil((#menu - 1) / 4)
    local rwnum = maxh
    local lbnum = maxh * maxw
    local lb = lbnum
    if hs > maxh then
        maxh = hs
    end

    local hnum = maxw

    local sme = 0
    if #menu <= 0 then
        return
    end

    local num = math.modf(#menu / lbnum)
    num = num + 1
    if #menu <= 0 then
        return
    end
    local n, m = 0, 0
    local px, py = -1, -1
    local FY, WGFY, WGSTARTH = 0, 0, 0
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
        lib.LoadPNG(91, 372 * 2, wgzbx - size * 2, wgzby - CC.ScreenH / 2.8, 1)
        local function strcolor_switch(s)
            local Color_Switch = {{"��", PinkRed}, {"��", M_Wheat}, {"��", C_BLACK}, {"��", RGB(178, 158, 124)},
                                  {"��", C_ORANGE}, {"��", LimeGreen}, {"��", M_DeepSkyBlue}, {"��", Violet}}
            for i = 1, 8 do
                if Color_Switch[i][1] == s then
                    return Color_Switch[i][2]
                end
            end
        end
        if ItemInfo[thingID] ~= nil then
            for i = 1, #ItemInfo[thingID] do
                me[#me + 1] = ItemInfo[thingID][i]
                if i == ItemInfo[thingID] then
                    me[#me + 1] = "��"
                end

            end
        else
            me[#me + 1] = ''
        end
        for i = mm, #me do
            local smsize = CC.DefaultFont * 0.75
            local tfstr = me[i]
            local color;
            color = strcolor_switch(string.sub(tfstr, 1, 2))
            tfstr = string.sub(tfstr, 3, -1)
            if string.sub(tfstr, 1, 2) == "��" then
                --	hs1 = hs1 + 1
            else
                h1 = tjm(size * 0.8 + wgzbx - size, wgzby + size * 8 + smsize * 1.1 * (hs1 - WGSTARTH), tfstr, C_WHITE,
                    smsize, 19, smsize * 1.1, WGSTARTH - hs1, myh1 + 1 - hs1 + WGSTARTH)
            end
            hs1 = hs1 + h1
        end
        if hs1 > myh1 then
            FY = limitX(hs1 - myh1 - 1, 0)
        else
            FY = 0
        end
        if FY > 0 then
            lib.LoadPNG(91, 124 * 2, wgzbx - size * 1.9, wgzby + size * 14, 1, 0, 60)
        end
        if WGSTARTH > 0 then
            lib.LoadPNG(91, 127 * 2, wgzbx - size * 1.9, wgzby + size * 8, 1, 0, 60)
        end
    end
    local function wugong_info1(kf)
        ----lib.Debug(thingID);
        local h1 = 0
        local me = {}
        local hs1 = 0
        local myh1 = 6
        local mm = 1

        lib.LoadPNG(91, 372 * 2, wgzbx - size * 2, wgzby - CC.ScreenH / 2.8, 1)
        local function strcolor_switch(s)
            local Color_Switch = {{"��", PinkRed}, {"��", M_Wheat}, {"��", C_BLACK}, {"��", RGB(178, 158, 124)},
                                  {"��", C_ORANGE}, {"��", LimeGreen}, {"��", M_DeepSkyBlue}, {"��", Violet}}
            for i = 1, 8 do
                if Color_Switch[i][1] == s then
                    return Color_Switch[i][2]
                end
            end
        end
        for i = 1, 10 do
            local kftx = JY.Wugong[kf]['��Ч' .. i]
            if kftx > 0 then
                me[#me + 1] = NGTX_sm(kf, kftx)
            end
        end
        for i = 1, #me do
            local smsize = CC.DefaultFont * 0.65
            local tfstr = me[i]
            local color;
            color = strcolor_switch(string.sub(tfstr, 1, 2))
            -- tfstr = string.sub(tfstr,3,-1)
            if string.sub(tfstr, 1, 2) == "��" then
                --	hs1 = hs1 + 1
            else
                h1 = tjm(size * 0.8 + wgzbx - size, wgzby + size * 8 + smsize * 1.2 * (hs1 - WGSTARTH), tfstr, C_WHITE1,
                    smsize, 21, smsize * 1.2, WGSTARTH - hs1, myh1 + 1 - hs1 + WGSTARTH, CC.FONT5)
            end
            hs1 = hs1 + h1
        end
        if hs1 > myh1 then
            FY = limitX(hs1 - myh1 - 1, 0)
        else
            FY = 0
        end
        if FY > 0 then
            lib.LoadPNG(91, 124 * 2, wgzbx - size * 1.9, wgzby + size * 14, 1, 0, 60)
        end
        if WGSTARTH > 0 then
            lib.LoadPNG(91, 127 * 2, wgzbx - size * 1.9, wgzby + size * 8, 1, 0, 60)
        end
    end
    for x = 1, #menu do
        local kf = menu[x][1]
        local name = JY.Wugong[kf]['����']
        local level = 11
        local kfwl = get_skill_power(0, kf, level)
        local kfi = x
        local kfth = KF_thing(kf)
        wgmenu[#wgmenu + 1] = {kf, name, kfwl, level, kfi, kfth, x} -- ��ţ����ƣ��������ȼ�,λ��,�ؼ�
        -- lib.Debug(kfi..' name=='..name..' kf='..kf)
    end
    if lb > #wgmenu then
        lb = #wgmenu
    end
    local surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)

    local pwz5 = ''
    local pwz6 = ''
    local pwz7 = ''
    local pwz8 = ''
    while true do
        if JY.Restart == 1 then
            break
        end
        lib.LoadPNG(91, 24 * 2, -1, -1, 1)

        if page < num then
            lb = lbnum
            -- lib.Debug('С��num lb=='..lb)
            for i = 1, lb do
                local kf = i + (page - 1) * lb
                local cl = C_WHITE1
                lib.Background(x1 + (n - 1) * xx - w1 / 2, y1 + (m - 1) * yy - h1 / 2 + hh1,x1 + (n - 1) * xx - w1 / 2 + w1, y1 + (m - 1) * yy - h1 / 2 + h1 + hh1, 50)
                -- lib.LoadPNG(91,378*2,x1+(n-1)*xx-w1/2,y1+(m-1)*yy-h1/2+hh1,1)
                if tob == i then
                    cl = C_RED
                    -- DrawBox(x1+(n-1)*xx-w1/2,y1+(m-1)*yy-h1/2+hh1,x1+(n-1)*xx-w1/2+w1,y1+(m-1)*yy-h1/2+h1+hh1, C_RED)		
                end
                kf1 = wgmenu[tob + (page - 1) * lb][1]
                local name = wgmenu[kf][2]
                -- lib.Debug('name=='..name..' i=='..i)
                DrawString(x1 + (n - 1) * xx - string.len(name) / 4 * size2, y1 + (m - 1) * yy - h1 / 3 + hh1, name, cl, size2)
                n = n + 1
                if n == rwnum then
                    m = m + 1
                    n = 0
                end
            end
            n = 0
            m = 0
        elseif page == num then
            lb = #wgmenu - (page - 1) * lbnum
            for i = 1, lb do
                local kf = i + (page - 1) * lbnum
                local cl = C_WHITE1

                lib.Background(x1 + (n - 1) * xx - w1 / 2, y1 + (m - 1) * yy - h1 / 2 + hh1,
                    x1 + (n - 1) * xx - w1 / 2 + w1, y1 + (m - 1) * yy - h1 / 2 + h1 + hh1, 50)
                if tob == i then
                    cl = C_RED
                end
                kf1 = wgmenu[tob + (page - 1) * lbnum][1]
                local name = wgmenu[kf][2]

                DrawString(x1 + (n - 1) * xx - string.len(name) / 4 * size2, y1 + (m - 1) * yy - h1 / 3 + hh1, name, cl,
                    size2)
                n = n + 1
                if n == rwnum then
                    m = m + 1
                    n = 0
                end
            end
            n = 0
            m = 0
        end
        local thid = KF_thing(kf1)
        local myThing = JY.Thing[thid]
        local tt = title .. ' [' .. page .. '/' .. num .. ']'
        DrawString(CC.ScreenW / 2 - string.len(tt) / 4 * size2 * 2, size2 * 3, tt, C_ORANGE, size2 * 2, CC.FONT1)
        if kfsm > 0 then
            local cl = color
            local me = JY.Wugong[kf1]["����"]
            local wgmp = MPname[JY.Wugong[kf1]["����"] + 1]
            local level = 11
            local wugongwl = get_skill_power(id, kf1, level)
            local mz = JY.Wugong[kf1]["������"]
            local wz2 = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"}

            if kf1 > 0 then
                cl = C_RED
                local jg1 = size * 1.1
                -- �书��ʽ
                local wgbj = 0
                if JY.Wugong[kf1]["�书����"] < 6 then
                    wgbj = 286
                else
                    wgbj = 287
                end
                if kfsm == 2 then
                    wgbj = 287
                end
                -- ���书˵������ͼ
                wgbj = 368
                local kfcj1 = JY.Wugong[kf1]["�㼶"]
                local wgcl = cl
                if kfcj1 == 1 then
                    wgcl = RGB(85, 188, 254)
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
                local pwz1, pwz2, pwz3, pwz4 = nil, nil, nil, nil
                lib.LoadPNG(91, wgbj * 2, wgzbx - size * 2, wgzby - size * 10.5, 1)
                -- if wlglx
                if JY.Wugong[kf1]['�书����'] < 6 then
                    if kfsm == 1 then
                        lib.LoadPNG(91, 369 * 2, wgzbx - size * 2, wgzby - size * 10.5, 1) -- ��ʽ����
                        lib.LoadPNG(91, 14 * 2, wgzbx + CC.ScreenW / 2.9, wgzby + size * 4, 1, 0, 80) -- �л��书˵��ͼƬ
                    end
                end
                lib.LoadPNG(91, 371 * 2, wgzbx + size * 8, wgzby - size / 2, 1, 0, 90) -- �书���ֱ���

                lib.LoadPNG(91, (373 + kfcj1) * 2, wgzbx - size * 2, wgzby - size / 1.5, 1, 0, 100) -- �书�׼�ͼƬ

                lib.DrawStr(wgzbx - string.len(JY.Wugong[kf1]["����"]) / 4 * size + size * 11, wgzby,
                    JY.Wugong[kf1]["����"], wgcl, size * 1.8, CONFIG.CurrentPath .. "FONT/2.TTF", 0, 0) -- �书������ʾ	

                local neishu = nil
                if KF_thing(kf1) ~= nil then
                    neishu = JY.Thing[KF_thing(kf1)]['����������']
                else
                    neishu = 2
                end
                local neishuwz = {'��', '��', '����'}
                local neishuwz1 = neishuwz[neishu + 1]
                local wglx = {'��' .. neishuwz1 .. 'ȭ', '��' .. neishuwz1 .. 'ָ', '��' .. neishuwz1 .. '��',
                              '��' .. neishuwz1 .. '��', '��' .. neishuwz1 .. '��', '��' .. neishuwz1 .. '��',
                              '��' .. neishuwz1 .. '��'}
                local wgsize = size * 0.8
                DrawString(wgzbx, wgzby, "����" .. ":  " .. wgmp .. ' ' .. wglx[JY.Wugong[kf1]['�书����']],
                    C_BLACK, wgsize) -- ����
                DrawString(wgzbx, wgzby + jg1, "��Ϊ" .. ":  " .. jjwz[level] .. " " .. "(" .. djwz[level] .. ")",
                    C_BLACK, wgsize) -- ��Ϊ
                local gdz = JY.Wugong[kf1]["�㼶"] * level
                local sm = JY.Wugong[kf1]["�㼶"] * 100 + wugongwl
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
                if JY.Wugong[kf1]["�书����"] < 6 then
                    pwz1 = "����" .. ":  " .. math.modf(wugongwl)
                    pwz2 = "����" .. ":  " .. mz
                    pwz3 = "��" .. ":  " .. gdz
                    pwz4 = ""
                elseif JY.Wugong[kf1]["�书����"] == 6 then
                    pwz1 = "����" .. ":  " .. sm
                    pwz2 = "����" .. ":  " .. math.modf(wugongwl)
                    pwz3 = "��" .. ":  " .. gdz
                    pwz4 = "����" .. ":  " .. hq
                else
                    pwz1 = "����" .. ":  " .. JY.Wugong[kf1]["������"]
                    pwz2 = "����" .. ":  " .. JY.Wugong[kf1]["������"]
                    pwz3 = "�ƶ�" .. ":  " .. ""
                    pwz4 = "����" .. ":  " .. ""
                end
                local function drawitem(ss, str, news)
                    -- local myThing = JY.Thing[kf_thing(kf)]
                    local color = C_GOLD
                    local mys
                    local myflag = 1
                    if str == nil then
                        mys = ss
                    elseif myThing[ss] ~= 0 then
                        if news == nil then
                            if myflag == 0 then
                                -- �޾Ʋ�����װ������ֵ��ȼ��仯
                                if myThing["װ��λ��"] > -1 then
                                    local attr_gain = 0;
                                    if myThing[ss] > 0 then
                                        attr_gain = myThing[ss] * 10 + myThing[ss] * (myThing["װ���ȼ�"] - 1) * 2
                                    elseif myThing[ss] < 0 then
                                        attr_gain = myThing[ss] * 10 - myThing[ss] * (myThing["װ���ȼ�"] - 1) * 2
                                    end
                                    if attr_gain ~= 0 then
                                        -- mys=string.format(str..':%+d',attr_gain)
                                        mys = str .. attr_gain
                                    end
                                else
                                    -- mys=string.format(str..':%+d',myThing[ss])
                                    mys = str .. myThing[ss]
                                end
                            elseif myflag == 1 then
                                -- mys=string.format(str..':%d',myThing[ss])
                                mys = str .. myThing[ss]
                            end
                        else
                            if myThing[ss] < 0 then
                                return
                            end
                            -- mys=string.format(str..':%s',news[myThing[ss]])
                            mys = str .. news[myThing[ss]]
                        end
                        -- ������ɫ
                        if myThing[ss] == 1 and ss == "����������" then
                            color = RGB(236, 200, 40)
                        elseif myThing[ss] == 2 and ss == "����������" then
                            color = RGB(236, 236, 236)
                        end
                    elseif myThing[ss] == 0 and ss == "����������" then
                        mys = string.format(str .. ':%s', news[myThing[ss]])
                        mys = str .. news[myThing[ss]]
                        color = RGB(208, 152, 208)
                    else
                        return
                    end
                    -- DrawString(mx+CC.MenuBorderPixel,my+CC.MenuBorderPixel+CC.ScreenH/1.5,mys,color,myfont)
                    pwz5 = pwz5 .. ' ' .. mys
                end
                if myThing['����'] > 0 then
                    if thid > 343 or thid < 348 then -- ����ҩƷ����ʾ
                        -- DrawString(wgzbx, y3_2 + 2+CC.MenuBorderPixel+CC.ScreenH/1.5, " Ч��:", LimeGreen, myfont)
                        pwz6 = "Ч����"
                    end
                    if myThing['���������ֵ'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '����+' .. myThing['���������ֵ']
                    end
                    if myThing['�ı���������'] == 2 then
                        pwz6 = pwz6 .. ' ' .. '�������Ա�Ϊ����'
                    end
                    if myThing['�ӹ�����'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '����+' .. myThing['�ӹ�����']
                    end
                    if myThing['�ӷ�����'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '����+' .. myThing['�ӷ�����']
                    end
                    if myThing['���Ṧ'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '�Ṧ+' .. myThing['���Ṧ']
                    end
                    if myThing['��ҽ������'] > 0 then
                        pwz6 = pwz6 .. ' ' .. 'ҽ��+' .. myThing['��ҽ������']
                    end
                    if myThing['���ö�����'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '�ö�+' .. myThing['���ö�����']
                    end
                    if myThing['�ӽⶾ����'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '�ⶾ+' .. myThing['�ӽⶾ����']
                    end
                    if myThing['�ӿ�������'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '����+' .. myThing['�ӿ�������']
                    end
                    if myThing['��ȭ�ƹ���'] > 0 then
                        pwz6 = pwz6 .. ' ' .. 'ȭ��+' .. myThing['��ȭ�ƹ���']
                    end
                    if myThing['��ָ������'] > 0 then
                        pwz6 = pwz6 .. ' ' .. 'ָ��+' .. myThing['��ָ������']
                    end
                    if myThing['����������'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '����+' .. myThing['����������']
                    end
                    if myThing['��ˣ������'] > 0 then
                        pwz6 = pwz6 .. ' ' .. 'ˣ��+' .. myThing['��ˣ������']
                    end
                    if myThing['���������'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '�������+' .. myThing['���������']
                    end
                    if myThing['�Ӱ�������'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '����+' .. myThing['�Ӱ�������']
                    end
                    if myThing['����ѧ��ʶ'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '�䳣+' .. myThing['����ѧ��ʶ']
                    end
                    if myThing['�ӹ�������'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '����+' .. myThing['�ӹ�������']
                    end
                    if myThing['�ӹ�������'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '����+' .. myThing['�ӹ�������']
                    end
                    -- ����װ�������ӳ�
                    for i, v in ipairs(CC.ExtraOffense) do
                        if v[1] == thid then
                            -- DrawString(mx+CC.MenuBorderPixel+CC.ScreenW/68.4,my+CC.MenuBorderPixel+CC.ScreenH/1.5,"����ǿ��:"..JY.Wugong[v[2]]["����"].."+"..v[3],PinkRed,myfont)
                        end
                    end

                end
                -- ����:
                if myThing['����'] == 2 then
                    pwz5 = '����:'
                    if myThing['����������'] > -1 then
                        drawitem('����:' .. JY.Person[myThing['����������']]['����'])
                    end
                    drawitem('����������', '����', {
                        [0] = '��',
                        '��',
                        '����'
                    })
                    drawitem('������', '����')
                    drawitem('�蹥����', '����')
                    drawitem('���Ṧ', '�Ṧ')
                    drawitem('���ö�����', '�ö�')
                    drawitem('��ҽ������', 'ҽ��')
                    drawitem('��ȭ�ƹ���', 'ȭ��')
                    drawitem('��ָ������', 'ָ��')
                    drawitem('����������', '����')
                    drawitem('��ˣ������', 'ˣ��')
                    drawitem('���������', '����')
                    drawitem('�谵������', '����')
                    if thid == 372 then
                        drawitem('��80>����>30')
                    end
                    -- ��ת����ʾ
                    local exstr = ''
                    if thid == 118 then
                        exstr = "��ϵ����ֵ֮��>=120 "
                    end
                    -- ��������ʾ
                    if thid == 176 then
                        exstr = "����/ˣ��/������һ��>=70 "
                    end
                    pwz5 = pwz5 .. ' ' .. exstr
                    local wugong = JY.Thing[thid]["�����书"]
                    drawitem('������', '����')
                    -- DrawString(dx+CC.MenuBorderPixel+CC.ScreenW/68.4,my2+CC.MenuBorderPixel+CC.ScreenH/1.5,' ����:',LimeGreen,myfont)	

                end
                DrawString(wgzbx, wgzby, "����" .. ":  " .. wgmp .. ' ' .. wglx[JY.Wugong[kf1]['�书����']],
                    C_BLACK, wgsize) -- ���� ��һ������
                DrawString(wgzbx, wgzby + jg1, "��Ϊ" .. ":  " .. jjwz[level] .. " " .. "(" .. djwz[level] .. ")",
                    C_BLACK, wgsize) -- ��Ϊ �ڶ�������
                DrawString(wgzbx, wgzby + jg1 * 2, pwz1, C_BLACK, wgsize) -- ����������
                DrawString(wgzbx, wgzby + jg1 * 3, pwz2, C_BLACK, wgsize) -- ����������
                DrawString(wgzbx, wgzby + jg1 * 4, pwz3 .. '   ' .. pwz4, C_BLACK, wgsize) -- ����������
                DrawString(wgzbx, wgzby + jg1 * 5, pwz5, C_BLACK, wgsize) -- ����������
                DrawString(wgzbx, wgzby + jg1 * 6, pwz6, C_BLACK, wgsize) -- ����������
                local wglx2 = {'ȭ��', 'ָ��', '����', '����', '����', '�ڹ�', '�Ṧ'}
                local wgcj = {'����', '�н�', '�߽�', '��ѧ'}
                local lx3 = JY.Wugong[kf1]['�书����']
                local wgcj1 = wgcj[JY.Wugong[kf1]['�㼶']]
                local kfsmwz = wgmp .. wgcj1 .. wglx2[lx3]
                local kfx, kfy = size * 8, size * 2
                if KF_thing(kf1) ~= nil then
                    -- local size5 = CC.FONT2
                    local row = 1
                    local fy = 0
                    local h = 0
                    if JY.Thing[KF_thing(kf1)]["��Ʒ˵��"] ~= nil then
                        -- DrawString(wgzbx+kfx,wgzby+size*2.2,JY.Thing[KF_thing(kf1)]["��Ʒ˵��"],C_WHITE,wgsize)
                        h = tjm(wgzbx + kfx, wgzby + size * 1.7 + size * (row - fy),
                            '��' .. JY.Thing[KF_thing(kf1)]["��Ʒ˵��"], C_BLACK, wgsize * 0.9, 11, wgsize * 1.7,
                            fy - row, 40)
                        row = row + h
                    else
                        -- DrawString(wgzbx+kfx,wgzby+size*2.2,'��'..kfsmwz,color,wgsize)
                        h = tjm(wgzbx + kfx, wgzby + size * 1.7 + size * (row - fy), '��' .. kfsmwz, C_BLACK, wgsize,
                            9, wgsize * 1.5, fy - row, 40)
                        row = row + h
                    end
                else
                    DrawString(wgzbx + kfx, wgzby + size * 2.2, kfsmwz, C_BLACK, wgsize)
                end
                if kfsm == 1 then
                    if JY.Wugong[kf1]["�书����"] < 6 then
                        for j = 1, #CC.KFMove[kf1] do
                            local leixing = {91, 92, 93, 94, 95, 96}
                            local lxpic = leixing[JY.Wugong[kf1]["�书����"]]
                            -- lib.Debug('menu1[5]=='..menu1[5])
                            local zsnum = CC.WUGONGZS[1][j]
                            if JY.Person[id]["�书��ʽ" .. zsnum] == 0 then
                                lib.LoadPNG(91, lxpic * 2, wgzbx + (j - 1) * CC.ScreenW / 30 - CC.ScreenW / 80,
                                    wgzby + CC.ScreenH / 2.2, 1, 0, 90)
                            else
                                lib.LoadPNG(98, (500 + kf1) * 2, wgzbx + (j - 1) * CC.ScreenW / 30 - CC.ScreenW / 80,
                                    wgzby + CC.ScreenH / 2.2, 1, 0, 90)
                            end
                            local zssm = {}
                            local CAOZSM = {}
                            local zsn = #CC.KFMove[kf1]
                            local function Atk(id)
                                local gj = 0
                                gj = gj + JY.Person[id]['������']
                                ----lib.Debug('���﹥����'..gj)	
                                local nlgj = limitX((JY.Person[id]['����'] - JY.Person[id]['����'] * 10) / 60, 0)
                                ----lib.Debug('�����ӳɹ�����'..nlgj)	
                                gj = gj + nlgj
                                gj = gj + FJGONGJ(id)
                                ----lib.Debug('װ���ӳɹ�����'..FJGONGJ(id))	
                                return gj
                            end
                            local atk = Atk(id)
                            local zzz = tb4
                            if zzz > 6 then
                                zzz = 6
                            end
                            local nnn = wugongwl * (1 + (zzz - 1) / 10)
                            local sz = math.ceil(atk * (1 + nnn / 2000))
                            local sznum = {"һ", "��", "��", "��", "��", "��", "��", "��", "��", "ʮ"}
                            local wz1 = "��ɻ����˺�" .. '��' .. sz .. "��" .. "�㡣"
                            -- lib.Debug('kf1=='..kf1..' tob =='..tob..' #CC.KFMove[kf1]=='..#CC.KFMove[kf1])
                            local zsname = CC.KFMove[kf1][j][1]
                            local zswz = nil
                            local zswz1 = nil

                            if tb4 == j then
                                lib.LoadPNG(91, 88 * 2, wgzbx + (j - 1) * CC.ScreenW / 30 - CC.ScreenW / 80,
                                    wgzby + CC.ScreenH / 2.2, 1, 0, 95)
                                -- DrawString(wgzbx-size,wgzby+size*7,JY.Wugong[kf1]["����"].."�ڣ�"..sznum[tb4].."����:��"..zsname.."     ����  ��"..CC.KFMove[kf1][j][3],C_CYGOLD,wgsize)	
                                tjm(zsw + wgzbx - size, zsh + wgzby + size * 7, "��" .. JY.Wugong[kf1]["����"] ..
                                    "�׵ڣ�" .. sznum[tb4] .. "����:��" .. zsname, C_WHITE, wgsize, 30, wgsize)
                                tjm(zsw + wgzbx + size * 8, zsh + wgzby + size * 7,
                                    "��    ���� ��" .. CC.KFMove[kf1][j][3], C_WHITE, wgsize, 30, wgsize)
                                local hs = 0
                                local ZUIDHS = 4
                                zswz1 = KF_zswz(kf1, tb4)
                                zswz1 = wz1 .. "" .. zswz1
                                h2 = tjm(zsw + wgzbx - size, zsh + wgzby + size * 7.7 + size * (hs - WGSTARTH1), zswz1, C_WHITE, wgsize * 0.9, 21, wgsize * 0.8, WGSTARTH1 - hs, ZUIDHS + 1 - hs + WGSTARTH1)
                                hs = hs + h2
                                if hs > ZUIDHS then
                                    WGFY1 = limitX(hs - ZUIDHS - 1, 0)
                                else
                                    WGFY1 = 0
                                end
                            end
                        end
                    else
                        if JY.Wugong[kf1]['��Ч1'] > 0 then
                            -- lib.Debug(kf1..'�ж��ɹ�1') 
                            wugong_info1(kf1)
                        else
                            if KF_thing(kf1) ~= nil then
                                -- lib.Debug(kf1..'�ж��ɹ�2') 
                                wugong_info(KF_thing(kf1))
                            end
                        end
                    end
                elseif kfsm == 2 then
                    if JY.Wugong[kf1]['��Ч1'] > 0 then
                        -- lib.Debug(kf1..'�ж��ɹ�1') 
                        wugong_info1(kf1)
                    else
                        if KF_thing(kf1) ~= nil then
                            -- lib.Debug(kf1..'�ж��ɹ�2') 
                            wugong_info(KF_thing(kf1))
                        end
                    end
                end
                local r = 0
                if level <= 9 then
                    if KF_thing(kf1) ~= nil then
                        r = math.modf((5 - math.modf(25 / 25)) * JY.Thing[KF_thing(kf1)]["�辭��"] * (level + 1) *
                                          0.05);
                    else
                        r = math.modf((5 - math.modf(25 / 25)) * 200 * (level + 1) * 0.05);
                    end
                else
                    r = math.huge;
                end
            end
        end
        ShowScreen()
        lib.Delay(CC.BattleDelay)
        local X, ktype, mx, my = lib.GetKey();

        if X == VK_SPACE or X == VK_RETURN then
            PlayWavE(77)
            if kfsm == 0 then
                kfsm = 1
            end

        elseif X == VK_ESCAPE or ktype == 4 then
            -- lib.Debug('�˳��ɹ�====')
            PlayWavE(77)
            -- Ĭ����ѡ��
            WGSTARTH = 0
            if kfsm > 0 then
                kfsm = 0
            else
                break
            end
        elseif X == VK_UP then
            if kfsm == 0 then
                if tob - rwnum >= 1 then
                    tob = tob - rwnum
                else
                    if page == 1 then
                    else
                        page = page - 1
                        tob = tob + rwnum * (maxw - 1)
                    end
                end
            else
                WGSTARTH = WGSTARTH - 1
                if WGSTARTH < 0 then
                    WGSTARTH = 0
                end
            end
        elseif X == VK_DOWN then
            if kfsm == 0 then
                PlayWavE(77)
                if tob + rwnum <= lb then
                    tob = tob + rwnum
                else
                    if page < num then
                        page = page + 1
                        tob = tob - rwnum * (maxw - 1)
                    end
                end
            else
                WGSTARTH = WGSTARTH + 1
                if WGSTARTH > FY then
                    WGSTARTH = FY
                end
            end
        elseif X == VK_LEFT then

            if kfsm == 0 then
                PlayWavE(77)
                tob = tob - 1
                if tob < 1 then
                    tob = 1
                end
            else
                PlayWavE(77)
                tb4 = tb4 - 1
                if tb4 < 1 then
                    tb4 = #CC.KFMove[kf1]
                end
            end
        elseif X == VK_RIGHT then

            if kfsm == 0 then
                PlayWavE(77)
                tob = tob + 1
                if tob > lb then
                    tob = lb
                end
            else
                PlayWavE(77)
                tb4 = tb4 + 1
                if tb4 > #CC.KFMove[kf1] then
                    tb4 = 1
                end
            end
        elseif ktype == 6 then
            PlayWavE(77)
            if kfsm == 0 then
                if tob - rwnum >= 1 then
                    tob = tob - rwnum
                else
                    if page == 1 then
                    else
                        page = page - 1
                        tob = tob + rwnum * (maxw - 1)
                    end
                end
            else
                WGSTARTH = WGSTARTH - 1
                if WGSTARTH < 0 then
                    WGSTARTH = 0
                end

            end
        elseif ktype == 7 then
            PlayWavE(77)
            if kfsm == 0 then
                if tob + rwnum <= lb then
                    tob = tob + rwnum
                else
                    if page < num then
                        page = page + 1
                        tob = tob - rwnum * (maxw - 1)
                    end
                end
            else
                WGSTARTH = WGSTARTH + 1
                if WGSTARTH > FY then
                    WGSTARTH = FY
                end
            end
        else
            local pd = false
            if kfsm == 0 then
                for i = 1, lb do
                    if mx >= x1 + (n - 1) * xx - w1 / 2 and mx < x1 + (n - 1) * xx - w1 / 2 + w1 and my >= y1 + (m - 1) *
                        yy - h1 / 2 + hh1 and my < y1 + (m - 1) * yy - h1 / 2 + h1 + hh1 then
                        if kfsm == 0 then
                            tob = i
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
                    PlayWavE(77)
                    kfsm = 1
                end

            else
                local kx = wgzbx + CC.ScreenW / 2.9
                local ky = wgzby + size * 4
                local pd1 = false
                if JY.Wugong[kf1]['�书����'] < 6 then
                    for i = 1, #CC.KFMove[kf1] do
                        local kx = wgzbx + (i - 1) * CC.ScreenW / 30 - CC.ScreenW / 80
                        local ky = wgzby + CC.ScreenH / 2.2
                        if mx > kx and mx < kx + size * 1.5 and my > ky and ky < ky + size * 2 then
                            tb4 = i
                            break
                        end
                    end
                    if mx > kx and mx < kx + size * 2 and my > ky and my < ky + size * 5 and ktype == 3 then
                        if kfsm == 1 then
                            kfsm = 2
                        else
                            kfsm = 1
                        end
                    end
                end
            end
        end
        lib.FreeSur(surid)
    end
end

-- �书�˵�˵��
function LGShowMenu_person(menu, maxh, maxw, title, r)
    local bx, by = CC.ScreenW / 1360, CC.ScreenH / 768
    local id = 0
    local cury = 0
    local wz = ''
    local bx = CC.ScreenW / 936
    local by = CC.ScreenH / 702
    local size2 = CC.DefaultFont * 0.7
    local size, size1 = CC.DefaultFont * 0.9, CC.DefaultFont -- �ֺ�
    local w1, h1 = lib.GetPNGXY(91, 139 * 2)
    local x, y = CC.ScreenW / 5.3, CC.ScreenH / 7
    local x1 = x * 2 - x / 3
    local y1 = y * 3 / 2 + y / 3 + y / 10
    local yy = h1 * 3 / 2
    local xx = w1 * 8 / 7
    local rwnum = maxh
    local lbnum = maxh * maxw
    local lb = lbnum
    local color = C_WHITE
    local page = 1
    local hh1 = 0
    local tob = 1
    local tb1 = 0
    local kfsm = 0
    local kf1 = 0
    local wgmenu = {}
    local kflx = 0
    local wgzbx, wgzby = CC.ScreenW / 3, CC.ScreenH / 2 - size * 6.5
    local jjwz = {"�����ž�", "�����ž�", "����С��", "����С��", "����Ѿ�", "����Ѿ�",
                  "�ڻ��ͨ", "�ڻ��ͨ", "¯����", "¯����", "�Ƿ��켫"}
    local djwz = {"һ", "��", "��", "��", "��", "��", "��", "��", "��", "ʮ", "��"}
    local pjwz = {"��" .. "�����书", "��" .. "�н��书", "��" .. "�߽��书", "��" .. "��ѧ�书"}
    local color = RGB(248, 248, 181)
    local zsh, zsw = size * 1.5, size * 1.1 -- ��ʽ���ֵ������������
    local tb4 = 1
    local STARTH1, WGSTARTH, WGSTARTH1, Mstarth = 0, 0, 0, 0
    local FY1, h, h2, SHUOMING, xlsm, Mfy = 0, 0, 0, 0, 0, 0
    local zsnum, hg, sf, FY, WGFY, WGFY1 = 0, 40, 0, 0, 0, 0
    local menu1 = 0
    if #menu <= 0 then
        return
    end
    -- menu[#menu+1] = -1
    local hs = math.ceil((#menu - 1) / 4)

    if hs > maxh then
        maxh = hs
    end

    local hnum = maxw

    local sme = 0
    if #menu <= 0 then
        return
    end

    local num = math.modf(#menu / lbnum)
    num = num + 1
    if #menu <= 0 then
        return
    end
    local n, m = 0, 0
    local px, py = -1, -1
    local FY, WGFY, WGSTARTH = 0, 0, 0

    for x = 1, #menu do
        local kf = menu[x][1]
        local name = JY.Wugong[kf]['����']
        local level = 11
        local kfwl = get_skill_power(0, kf, level)
        local kfi = x
        local kfth = KF_thing(kf)
        wgmenu[#wgmenu + 1] = {kf, name, kfwl, level, kfi, kfth, x} -- ��ţ����ƣ��������ȼ�,λ��,�ؼ�
        -- lib.Debug(kfi..' name=='..name..' kf='..kf)
    end
    if lb > #wgmenu then
        lb = #wgmenu
    end
    local surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)

    local pwz5 = ''
    local pwz6 = ''
    local pwz7 = ''
    local pwz8 = ''
    while true do
        if JY.Restart == 1 then
            break
        end
        lib.LoadPNG(91, 24 * 2, -1, -1, 1)

        if page < num then
            lb = lbnum
            -- lib.Debug('С��num lb=='..lb)
            for i = 1, lb do
                local kf = i + (page - 1) * lb
                local cl = C_WHITE1
                lib.Background(x1 + (n - 1) * xx - w1 / 2, y1 + (m - 1) * yy - h1 / 2 + hh1, x1 + (n - 1) * xx - w1 / 2 + w1, y1 + (m - 1) * yy - h1 / 2 + h1 + hh1, 50)
                -- lib.LoadPNG(91,378*2,x1+(n-1)*xx-w1/2,y1+(m-1)*yy-h1/2+hh1,1)
                if tob == i then
                    cl = C_RED
                    -- DrawBox(x1+(n-1)*xx-w1/2,y1+(m-1)*yy-h1/2+hh1,x1+(n-1)*xx-w1/2+w1,y1+(m-1)*yy-h1/2+h1+hh1, C_RED)		
                end
                kf1 = wgmenu[tob + (page - 1) * lb][1]
                local name = wgmenu[kf][2]
                -- lib.Debug('name=='..name..' i=='..i)
                DrawString(x1 + (n - 1) * xx - string.len(name) / 4 * size2, y1 + (m - 1) * yy - h1 / 3 + hh1, name, cl,  size2)
                n = n + 1
                if n == rwnum then
                    m = m + 1
                    n = 0
                end
            end
            n = 0
            m = 0
        elseif page == num then
            lb = #wgmenu - (page - 1) * lbnum
            for i = 1, lb do
                local kf = i + (page - 1) * lbnum
                local cl = C_WHITE1

                lib.Background(x1 + (n - 1) * xx - w1 / 2, y1 + (m - 1) * yy - h1 / 2 + hh1, x1 + (n - 1) * xx - w1 / 2 + w1, y1 + (m - 1) * yy - h1 / 2 + h1 + hh1, 50)
                if tob == i then
                    cl = C_RED
                end
                kf1 = wgmenu[tob + (page - 1) * lbnum][1]
                local name = wgmenu[kf][2]

                DrawString(x1 + (n - 1) * xx - string.len(name) / 4 * size2, y1 + (m - 1) * yy - h1 / 3 + hh1, name, cl, size2)
                n = n + 1
                if n == rwnum then
                    m = m + 1
                    n = 0
                end
            end
            n = 0
            m = 0
        end

        ShowScreen()
        lib.Delay(CC.BattleDelay)
        local X, ktype, mx, my = lib.GetKey();

        if X == VK_SPACE or X == VK_RETURN then
            PlayWavE(77)
            if kfsm == 0 then
                kfsm = 1
            end

        elseif X == VK_ESCAPE or ktype == 4 then
            -- lib.Debug('�˳��ɹ�====')
            PlayWavE(77)
            -- Ĭ����ѡ��
            WGSTARTH = 0
            if kfsm > 0 then
                kfsm = 0
            else
                break
            end
        elseif X == VK_UP then
            if kfsm == 0 then
                if tob - rwnum >= 1 then
                    tob = tob - rwnum
                else
                    if page == 1 then
                    else
                        page = page - 1
                        tob = tob + rwnum * (maxw - 1)
                    end
                end
            else
                WGSTARTH = WGSTARTH - 1
                if WGSTARTH < 0 then
                    WGSTARTH = 0
                end
            end
        elseif X == VK_DOWN then
            if kfsm == 0 then
                PlayWavE(77)
                if tob + rwnum <= lb then
                    tob = tob + rwnum
                else
                    if page < num then
                        page = page + 1
                        tob = tob - rwnum * (maxw - 1)
                    end
                end
            else
                WGSTARTH = WGSTARTH + 1
                if WGSTARTH > FY then
                    WGSTARTH = FY
                end
            end
        elseif X == VK_LEFT then

            if kfsm == 0 then
                PlayWavE(77)
                tob = tob - 1
                if tob < 1 then
                    tob = 1
                end
            else
                PlayWavE(77)
                tb4 = tb4 - 1
                if tb4 < 1 then
                    tb4 = #CC.KFMove[kf1]
                end
            end
        elseif X == VK_RIGHT then

            if kfsm == 0 then
                PlayWavE(77)
                tob = tob + 1
                if tob > lb then
                    tob = lb
                end
            else
                PlayWavE(77)
                tb4 = tb4 + 1
                if tb4 > #CC.KFMove[kf1] then
                    tb4 = 1
                end
            end
        elseif ktype == 6 then
            PlayWavE(77)
            if kfsm == 0 then
                if tob - rwnum >= 1 then
                    tob = tob - rwnum
                else
                    if page == 1 then
                    else
                        page = page - 1
                        tob = tob + rwnum * (maxw - 1)
                    end
                end
            else
                WGSTARTH = WGSTARTH - 1
                if WGSTARTH < 0 then
                    WGSTARTH = 0
                end

            end
        elseif ktype == 7 then
            PlayWavE(77)
            if kfsm == 0 then
                if tob + rwnum <= lb then
                    tob = tob + rwnum
                else
                    if page < num then
                        page = page + 1
                        tob = tob - rwnum * (maxw - 1)
                    end
                end
            else
                WGSTARTH = WGSTARTH + 1
                if WGSTARTH > FY then
                    WGSTARTH = FY
                end
            end
        else
            local pd = false
            if kfsm == 0 then
                for i = 1, lb do
                    if mx >= x1 + (n - 1) * xx - w1 / 2 and mx < x1 + (n - 1) * xx - w1 / 2 + w1 and my >= y1 + (m - 1) *
                        yy - h1 / 2 + hh1 and my < y1 + (m - 1) * yy - h1 / 2 + h1 + hh1 then
                        if kfsm == 0 then
                            tob = i
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
                    PlayWavE(77)
                    kfsm = 1
                end

            else
                local kx = wgzbx + CC.ScreenW / 2.9
                local ky = wgzby + size * 4
                local pd1 = false
                if JY.Wugong[kf1]['�书����'] < 6 then
                    for i = 1, #CC.KFMove[kf1] do
                        local kx = wgzbx + (i - 1) * CC.ScreenW / 30 - CC.ScreenW / 80
                        local ky = wgzby + CC.ScreenH / 2.2
                        if mx > kx and mx < kx + size * 1.5 and my > ky and ky < ky + size * 2 then
                            tb4 = i
                            break
                        end
                    end
                    if mx > kx and mx < kx + size * 2 and my > ky and my < ky + size * 5 and ktype == 3 then
                        if kfsm == 1 then
                            kfsm = 2
                        else
                            kfsm = 1
                        end
                    end
                end
            end
        end
        lib.FreeSur(surid)
    end
end
-- Catʱ���ʱ
-------------------------------------
-------------------------------------
function gettime(i)
    local t, t2 = 0, 0
    local zipfile = string.format(CC.SavePath .. 'Save_%d'..'.sav', i)
    --Byte.unzip(zipfile, CC.SavePath .. 'tjm')
	Byte.unzip_path(zipfile, CC.SavePath..'', 'tjm')
    local fp_tmp = io.open(CC.SavePath .. 'tjm', "r");
    if fp_tmp then
        fp_tmp:close();
        local data_header = Byte.create(16);
        Byte.loadfile(data_header, CC.SavePath .. 'tjm', 4, 16);
        t = Byte.get32(data_header, 0);
        t2 = Byte.get32(data_header, 8);
    end
    os.remove(CC.SavePath .. 'tjm');
    return t, t2
end
-------------------------------------
-------------------------------------

