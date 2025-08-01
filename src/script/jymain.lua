-- 0江湖 1少林 2武当 3逍遥 4日月 5明教 6天机 7全真 8丐帮 9华山 10嵩山 11青城 12衡山 13恒山 14泰山 15五毒 16古墓 17血刀 18灵霄 19峨眉 20崆峒 21昆仑 22桃花 23白驼 24六扇门 25八卦 26慕容 27天龙寺 28星宿 29密宗 30藏剑
function IncludeFile()
    package.path = CONFIG.ScriptLuaPath; -- 设置加载路径，大小写建议要一致
    require("dkjson")
    require("jyconst") -- 加载其他文件，使用require避免重复加载
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

function SetGlobal() -- 设置游戏内部使用的全程变量  
    JY = {};
    JY.HPDisplay = CONFIG.HPDisplay  --战斗显血
    JY.BattleDelay= CONFIG.BattleDelay --战斗速度
    JY.Operation = CONFIG.Operation
    JY.Status = GAME_INIT; -- 游戏当前状态
    -- 保存R×数据
    JY.Base = {}; -- 基本数据
    JY.PersonNum = 0; -- 人物个数
    JY.Person = {}; -- 人物数据
    JY.ThingNum = 0 -- 物品数量
    JY.Thing = {}; -- 物品数据
    JY.SceneNum = 0 -- 场景数量
    JY.Scene = {}; -- 场景数据
    JY.WugongNum = 0 -- 武功数量
    JY.Wugong = {}; -- 武功数据
    JY.ShopNum = 0 -- 商店数量
    JY.Shop = {}; -- 商店数据
    JY.TejiNum = 0 -- 特技数量
    JY.Teji = {}; -- 特技数据

    JY.MyCurrentPic = 0 -- 主角当前走路贴图在贴图文件中偏移
    JY.MyPic = 0 -- 主角当前贴图
    JY.Mytick = 0 -- 主角没有走路的持续帧数
    JY.MyTick2 = 0 -- 显示事件动画的节拍
    JY.LOADTIME = 0
    JY.SAVETIME = 0
    JY.GTIME = 0 -- 游戏时间
    JY.GOLD = 0 -- 游戏银两

    JY.SubScene = -1; -- 当前子场景编号
    JY.SubSceneX = 0; -- 子场景显示位置偏移，场景移动指令使用
    JY.SubSceneY = 0;
    JY.ThingUse = -1;
    JY.Darkness = 0; -- =0 屏幕正常显示，=1 不显示，屏幕全黑

    JY.CurrentD = -1; -- 当前调用D*的编号
    JY.OldDPass = -1; -- 上次触发路过事件的D*编号, 避免多次触发
    JY.CurrentEventType = -1 -- 当前触发事件的方式 1 空格 2 物品 3 路过

    JY.CurrentThing = -1; -- 当前选择物品，触发事件使用

    JY.MmapMusic = -1; -- 切换大地图音乐，返回主地图时，如果设置，则播放此音乐

    JY.CurrentMIDI = -1; -- 当前播放的音乐id，用来在关闭音乐时保存音乐id。
    JY.EnableMusic = 1; -- 是否播放音乐 1 播放，0 不播放
    JY.EnableSound = 1; -- 是否播放音效 1 播放，0 不播放

    WAR = {}; -- 战斗使用的全程变量 这里占个位置，因为程序后面不允许定义全局变量了。具体内容在WarSetGlobal函数中

    AutoMoveTab = {
        [0] = 0
    }

    JY.Restart = 0 -- 返回游戏初始界面
    JY.WalkCount = 0 -- 走路计步

    IsViewingKungfuScrolls = 0

    Achievements = {}
    Achievements.pChar = {}

    YC = {}
    YC.ZJH = 0 -- 隐藏主角张家辉
    YC.GXZ = 0
end

function JY_Main() -- 主程序入口
    os.remove("debug.txt"); -- 清除以前的debug输出
    os.remove("yltxt.txt");
    os.remove("ylname.txt");
    io.open("yltxt.txt", "w")
    io.open("ylname.txt", "w")


    xpcall(JY_Main_sub, myErrFun); -- 捕获调用错误
end

function myErrFun(err) -- 错误处理，打印错误信息
    lib.Debug(err); -- 输出错误信息
    lib.Debug(debug.traceback()); -- 输出调用堆栈信息
end

function JY_Main_sub() -- 真正的游戏主程序入口
    Ct = {};
    IncludeFile(); -- 导入其他模块
    SetGlobalConst(); -- 设置全程变量CC, 程序使用的常量
    SetPersonTF()
    SetGlobal(); -- 设置全程变量JY

    -- 禁止访问全程变量
    setmetatable(_G, {
        __newindex = function(_, n)
            error("attempt read write to undeclared variable " .. n, 2);
        end,
        __index = function(_, n)
            error("attempt read read to undeclared variable " .. n, 2);
        end
    });

    lib.Debug("JY_Main start.");

    math.randomseed(os.time()); -- 初始化随机数发生器

    JY.Status = GAME_START; -- 改变游戏状态

    lib.PicInit(CC.PaletteFile); -- 加载原来的256色调色板

    lib.FillColor(0, 0, 0, 0, 0);

     --lib.PicLoadFile(CC.WMAPPicFile[1], CC.WMAPPicFile[2], 0)
     lib.LoadPNGPath(CC.HeadPath, 1, CC.HeadNum, limitX(CC.WX*100,0,100))	--设置读取PNG图片的路径
     --lib.PicLoadFile(CC.ThingPicFile[1], CC.ThingPicFile[2], 2, 100, 100)			--物品贴图，内存区域2
	 lib.LoadPNGPath(CC.ThingPath, 2, CC.ThingNum, limitX(CC.WX*100,0,100))	--物品贴图
     --lib.PicLoadFile(CC.EFTFile[1], CC.EFTFile[2], 3)								--特效贴图，内存区域3
     lib.LoadPNGPath(CC.BodyPath, 90, CC.BodyNum, limitX(CC.WX*100,0,100))	--半身象
     lib.LoadPNGPath(CC.XTPath, 91, CC.XTNum, limitX(CC.WX*100,0,100))	--XT	
     lib.PicLoadFile(CC.BJ[1], CC.BJ[2], 92)  --
     --lib.LoadPNGPath('./data/mmap',93,-1,100) --大地图
     --lib.LoadPNGPath('./data/smap',94,-1,100) --小地图
     lib.LoadPNGPath(CC.PTPath, 95, CC.PTNum, limitX(CC.WX*100,0,100)) -- 
     lib.LoadPNGPath(CC.UIPath, 96, CC.UINum, limitX(CC.WX*100,0,100)) -- UI
	 lib.LoadPNGPath(CC.TFPath, 89, CC.TFNum, limitX(CC.WX * 100, 0, 100)) -- TF

    -- 97是云朵，切勿使用
     lib.LoadPNGPath(CC.IconPath, 98, CC.IconNum, limitX(CC.WX*100,0,100))	--状态图标，内存区域98
     lib.LoadPNGPath(CC.HeadPath, 99, CC.HeadNum, 26.923076923) --人物小头像，用于集气条，内存区域99

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
    -- 模式选择
    local function Moshixz()
        local zb = {{CC.ScreenW / 1.9057, CC.ScreenH / 1.6587}, {CC.ScreenW / 2.2666, CC.ScreenH / 1.6587},
                    {CC.ScreenW / 1.7107, CC.ScreenH / 1.6587}}
        local x, y = lib.GetPNGXY(91, 114 * 2)
        local x1, y1 = CC.ScreenW / 2 - x / 2, CC.ScreenH / 2 + y
        local tb = 1
        local picmenu = {{114, 116}, {115, 117}, {205, 206}}
        JY.Base["开局"] = -1
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
                JY.Base["开局"] = tb - 1
            elseif X == VK_RIGHT or X == VK_DOWN then
                tb = tb + 1
                if tb > 3 then
                    tb = 1
                end
                JY.Base["开局"] = tb - 1
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
                    JY.Base["开局"] = tb - 1
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

        -- 版本号
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
					JY.Base["剧情"] = 0
					lb = 2
				elseif tb == 3 then
					JY.Status =GAME_END;	
					return -1					
				else
					
					JY.Base["剧情"] = 1
					NewGame();   		       --设置新游戏数据		
					if JY.Restart == 1 then
						do return end
					end		
					JY.SubScene = 162
					JY.Base["人X1"] = 44
					JY.Base["人Y1"] = 2
					instruct_40(3)					
					--无酒不欢：男女主角判定
					if JY.Person[0]["性别"] == 0 then
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

                    -- LoadRecord(0)     --重新开始游戏
                    JY.Base["剧情"] = 0 -- 设置新游戏数据		
                    Cls()
                    NewGame();
                    if JY.Restart == 1 then
                        do
                            return
                        end
                    end
                    for i = 1, #mp do
                        if JY.Person[0]['门派'] == mp[i] then
                            MpScene = i
                            break
                        end
                    end
                    smp = mpNO[MpScene]
                    if JY.Person[0]['门派'] == 1 then
                        smp = 93
                    end
                    if JY.Person[0]['门派'] == 27 then
                        smp = 159
                    end
                    if JY.Person[0]['门派'] == 9 then
                        smp = 152
                    end
                    -- 畅想杨过初始场景
                    if JY.Base["畅想"] == 58 then
                        JY.SubScene = 18
                        JY.Base["人X"] = 144
                        JY.Base["人Y"] = 218
                        JY.Base["人X1"] = 30
                        JY.Base["人Y1"] = 32
                        -- elseif JY.Base["标准"] == 1 then
                    elseif JY.Person[0]["门派"] > 0 then
                        JY.SubScene = mpNO[MpScene]
                        JY.Base["人X1"] = mpx[MpScene]
                        JY.Base["人Y1"] = mpy[MpScene]
                        JY.Base["人X"] = JY.Scene[smp]["外景入口X1"]
                        JY.Base["人Y"] = JY.Scene[smp]["外景入口Y1"]
                    else
                        JY.SubScene = CC.NewGameSceneID
                        JY.Base["人X1"] = CC.NewGameSceneX
                        JY.Base["人Y1"] = CC.NewGameSceneY
                    end

                    -- 开局事件
                    if JY.Base["畅想"] == 58 then -- 畅想杨过
                        CallCEvent(4187)
                    elseif JY.Person[0]["门派"] > 0 then
                        CallCEvent(mpmenu[MpScene])
                    else -- 其他人
                        CallCEvent(691)
                    end

                    -- 无酒不欢：男女主角判定
                    if JY.Person[0]["性别"] == 0 then
                        JY.MyPic = CC.NewPersonPicM
                    else
                        JY.MyPic = CC.NewPersonPicF
                    end
                    JY.Status = GAME_SMAP
                    JY.MmapMusic = -1
                    CleanMemory()
                    Init_SMap(0)
                    lib.ShowSlow(20, 0)
                    -- 畅想开局获得自身的装备
                    if JY.Base["畅想"] > 0 then
                        if JY.Person[0]["武器"] ~= -1 and JY.Base["畅想"] ~= 27 then
                            instruct_2(JY.Person[0]["武器"], 1)
                            JY.Person[0]["武器"] = -1
                        end
                        if JY.Person[0]["防具"] ~= -1 then
                            instruct_2(JY.Person[0]["防具"], 1)
                            JY.Person[0]["防具"] = -1
                        end
                        if JY.Person[0]["坐骑"] ~= -1 then
                            instruct_2(JY.Person[0]["坐骑"], 1)
                            JY.Person[0]["坐骑"] = -1
                        end
                    end
                    -- 畅想尹克西获得一万两
                    if JY.Base["畅想"] == 158 then
                        instruct_2(174, 10000)
                    end
                    -- 标准获得1万两
                    if JY.Base["标准"] > 0 then
                        --	instruct_2(174, 10000)
                    end
                    -- 畅想获得1万两
                    if JY.Base["畅想"] > 0 then
                        --	instruct_2(174, 10000)
                    end
                    if JY.Base["畅想"] == 721 then
                        instruct_2(174, 20000)
                    end
                    -- 畅想李寻欢获得小李飞刀
                    if JY.Base["畅想"] == 498 then
                        instruct_2(309, 1)
                    end
                    -- 畅想李寻欢获得小李飞刀
                    if JY.Base["畅想"] == 498 then
                        instruct_2(29, 99)
                    end
                    -- 标主可以在云岭洞花钱学习迷踪步
                    if JY.Base["标准"] > 0 then
                        addevent(41, 0, 1, 4144, 1, 8694)
                    end
                    -- 周目奖励

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
                elseif tb == 2 then -- 载入旧的进度	
                    JY.Base["剧情"] = 0
                    DrawStrBox(-1, CC.ScreenH * 1 / 6 - 20, "读取进度", LimeGreen, CC.Fontbig, C_GOLD);
                    DrawStrBox(bx * 281, by * CC.ScreenH * 1 / 6 + 26,
                        string.format("%-6s %-4s %-10s %-4s %-4s %-4s %-10s", "存档名", "主角", "姓名", "难度",
                            "资质", "天书", "位置"), C_ORANGE, CC.DefaultFont, C_GOLD);
                    local r = SaveList();
                    -- ESC 重新返回选项
                    if r < 1 then
                        local s = StartMenu();
                        return s;
                    end
                    DrawString(CC.ScreenW/2.1, CC.ScreenH/2, "请稍候......", C_WHITE, CC.DefaultFont, CC.FONT2)
                    ShowScreen();
                    local result = LoadRecord(r);
                    if result ~= nil then
                        return StartMenu();
                    end
                    if JY.Base["无用"] ~= -1 then
                        if JY.SubScene < 0 then
                            CleanMemory()
                            -- lib.UnloadMMap()
                        end
                        -- lib.PicInit()
                        lib.ShowSlow(20, 1)
                        JY.Status = GAME_SMAP
                        JY.SubScene = JY.Base["无用"]
                        JY.MmapMusic = -1
                        JY.MyPic = GetMyPic()

                        JY.Wugong[332]["层级"] = 1
                        JY.Wugong[266]["层级"] = 1
                        JY.Wugong[357]["层级"] = 2
                        JY.Wugong[265]["层级"] = 4
                        JY.Wugong[321]["层级"] = 1
                        JY.Wugong[282]["层级"] = 2
                        JY.Wugong[356]["层级"] = 2
                        JY.Wugong[341]["层级"] = 2
                        JY.Scene[17]["跳转口Y1"] = 1
                        JY.Scene[17]["跳转口Y2"] = 2
                        JY.Person[608]["武功2"] = 226
                        JY.Person[608]["武功等级2"] = 999
                        JY.Person[77]["携带物品1"] = -1
                        JY.Person[77]["携带物品数量1"] = 0
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
                        JY.Base["剧情"] = 0
                        lb = 2
                    elseif tb == 3 then
                        JY.Status = GAME_END;
                        return -1
                    else
                        --[[
						Cls()
						JY.Base["剧情"] = 1
						NewGame();   		       --设置新游戏数据		
						if JY.Restart == 1 then
							do return end
						end		
						JY.SubScene = 162
						JY.Base["人X1"] = 44
						JY.Base["人Y1"] = 2
						instruct_40(3)					
						--无酒不欢：男女主角判定
						if JY.Person[0]["性别"] == 0 then
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
                        if tb == 1 then -- 重新开始游戏
                            JY.Base["剧情"] = 0 -- 设置新游戏数据		
                            Cls()

                            LoadRecord(0)
                            NewGame();
                            if JY.Restart == 1 then
                                do
                                    return
                                end
                            end
                            for i = 1, #mp do
                                if JY.Person[0]['门派'] == mp[i] then
                                    MpScene = i
                                    break
                                end
                            end
                            if JY.Person[0]['门派'] == 1 then
                                smp = 93
                            end
                            if JY.Person[0]['门派'] == 27 then
                                smp = 159
                            end
                            if JY.Person[0]['门派'] == 9 then
                                smp = 152
                            end
                            smp = mpNO[MpScene]

                            -- 畅想杨过初始场景
                            if JY.Base["畅想"] == 58 then
                                JY.SubScene = 18
                                JY.Base["人X"] = 144
                                JY.Base["人Y"] = 218
                                JY.Base["人X1"] = 30
                                JY.Base["人Y1"] = 32
                                -- elseif JY.Base["标准"] == 1 then
                            elseif JY.Person[0]["门派"] > 0 then
                                JY.Base["人X1"] = mpx[MpScene]
                                JY.Base["人Y1"] = mpy[MpScene]
                                JY.Base["人X"] = JY.Scene[smp]["外景入口X1"]
                                JY.Base["人Y"] = JY.Scene[smp]["外景入口Y1"]
                            else
                                JY.SubScene = CC.NewGameSceneID
                                JY.Base["人X1"] = CC.NewGameSceneX
                                JY.Base["人Y1"] = CC.NewGameSceneY
                            end

                            -- 开局事件
                            if JY.Base["畅想"] == 58 then -- 畅想杨过
                                CallCEvent(4187)
                            elseif JY.Person[0]["门派"] > 0 then
                                local mpmenu = {3005, 3023, 3028, 3031, 3025, 3033, 3035, 3037, 3039, 3041}
                                CallCEvent(mpmenu[MpScene])
                            else -- 其他人
                                CallCEvent(691)
                            end

                            -- 无酒不欢：男女主角判定
                            if JY.Person[0]["性别"] == 0 then
                                JY.MyPic = CC.NewPersonPicM
                            else
                                JY.MyPic = CC.NewPersonPicF
                            end
                            JY.Status = GAME_SMAP
                            JY.MmapMusic = -1
                            CleanMemory()
                            Init_SMap(0)
                            lib.ShowSlow(20, 0)

                            -- 畅想开局获得自身的装备
                            if JY.Base["畅想"] > 0 then
                                if JY.Person[0]["武器"] ~= -1 and JY.Base["畅想"] ~= 27 then
                                    instruct_2(JY.Person[0]["武器"], 1)
                                    JY.Person[0]["武器"] = -1
                                end
                                if JY.Person[0]["防具"] ~= -1 then
                                    instruct_2(JY.Person[0]["防具"], 1)
                                    JY.Person[0]["防具"] = -1
                                end
                                if JY.Person[0]["坐骑"] ~= -1 then
                                    instruct_2(JY.Person[0]["坐骑"], 1)
                                    JY.Person[0]["坐骑"] = -1
                                end
                            end
                            -- 畅想尹克西获得一万两
                            if JY.Base["畅想"] == 158 then
                                instruct_2(174, 10000)
                            end
                            -- 标准获得1万两
                            if JY.Base["标准"] > 0 then
                                --	instruct_2(174, 10000)
                            end
                            -- 畅想获得1万两
                            if JY.Base["畅想"] > 0 then
                                --	instruct_2(174, 10000)
                            end
                            if JY.Base["畅想"] == 721 then
                                instruct_2(174, 20000)
                            end
                            -- 畅想李寻欢获得小李飞刀
                            if JY.Base["畅想"] == 498 then
                                instruct_2(309, 1)
                            end
                            -- 畅想李寻欢获得小李飞刀
                            if JY.Base["畅想"] == 498 then
                                instruct_2(29, 99)
                            end
                            -- 标主可以在云岭洞花钱学习迷踪步
                            if JY.Base["标准"] > 0 then
                                addevent(41, 0, 1, 4144, 1, 8694)
                            end
                            -- 周目奖励

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
                        elseif tb == 2 then -- 载入旧的进度	
                            JY.Base["剧情"] = 0
                            DrawStrBox(-1, CC.ScreenH * 1 / 6 - 20, "读取进度", LimeGreen, CC.Fontbig, C_GOLD);
                            DrawStrBox(bx * 281, by * CC.ScreenH * 1 / 6 + 26,
                                string.format("%-6s %-4s %-10s %-4s %-4s %-4s %-10s", "存档名", "主角", "姓名",
                                    "难度", "资质", "天书", "位置"), C_ORANGE, CC.DefaultFont, C_GOLD);
                            local r = SaveList();
                            -- ESC 重新返回选项
                            if r < 1 then
                                local s = StartMenu();
                                return s;
                            end
                            DrawString(CC.MainSubMenuX2, CC.MainSubMenuY, "请稍候......", C_WHITE, CC.DefaultFont,
                                CC.FONT2)
                            ShowScreen();
                            local result = LoadRecord(r);
                            if result ~= nil then
                                return StartMenu();
                            end
                            if JY.Base["无用"] ~= -1 then
                                if JY.SubScene < 0 then
                                    CleanMemory()
                                    -- lib.UnloadMMap()
                                end
                                -- lib.PicInit()
                                lib.ShowSlow(20, 1)
                                JY.Status = GAME_SMAP
                                JY.SubScene = JY.Base["无用"]
                                JY.MmapMusic = -1
                                JY.MyPic = GetMyPic()
                                JY.Wugong[332]["层级"] = 1
                                JY.Wugong[266]["层级"] = 1
                                JY.Wugong[357]["层级"] = 2
                                JY.Wugong[265]["层级"] = 4
                                JY.Wugong[321]["层级"] = 1
                                JY.Wugong[282]["层级"] = 2
                                JY.Wugong[356]["层级"] = 2
                                JY.Wugong[341]["层级"] = 2
                                JY.Scene[17]["跳转口Y1"] = 1
                                JY.Scene[17]["跳转口Y2"] = 2
                                JY.Person[608]["武功2"] = 226
                                JY.Person[608]["武功等级2"] = 999
                                JY.Person[77]["携带物品1"] = -1
                                JY.Person[77]["携带物品数量1"] = 0
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

function CleanMemory() -- 清理lua内存
    if CONFIG.CleanMemory == 1 then
        collectgarbage("collect");
    end
end
function NewGame() -- 选择新游戏，设置主角初始属性
    lib.Debug("NewGame");
    Cls();
    ShowScreen();
    LoadRecord(0); --  载入新游戏数据
    -- PlayMIDI(77);

    CC.Week = 1
    CC.Gold = 0
    CC.MJCZ = 0
    CC.Sp = 0

    if existFile(CONFIG.DataPath .. 'WeeklyAwards') then
        tgload()
    end

    -- 执行成就文件
    if existFile(CC.Acvmts) then
        dofile(CC.Acvmts)
        -- 一周目
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
        -- 以表格形式保存新文件
        SaveTable(Achievements)
    end
    if CC.Week > 100 then
        CC.Week = 100
    end
    JY.Base["周目"] = 0
    JY.Base["碎片"] = CC.Sp
    JY.Status = GAME_NEWNAME
    ClsN()

    if JY.Base["剧情"] == 0 then
        -- 选择标主还是畅想
        lib.LoadPicture(CC.BG01File, -1, -1)
        -- 0224修改
        JY.Base["武功数量"] = 15
        if JY.Base["武功数量"] > 15 then
            JY.Base["武功数量"] = 15
        end
        JY.Wugong[139]['武功类型'] = 3
        for w = 0, JY.WugongNum - 1 do
            if JY.Wugong[w]["武功类型"] < 7 and w ~= 0 then
                JY.Wugong[w]["加命中"] = math.modf(JY.Wugong[w]["攻击力" .. 10] / 2)
                if JY.Wugong[w]["加命中"] < 700 then
                    JY.Wugong[w]["加命中"] = 700
                end
                JY.Wugong[w]["加命中"] = JY.Wugong[w]["加命中"] + JY.Wugong[w]["层级"] * 50
                if JY.Wugong[w]["武功类型"] == 3 then
                    JY.Wugong[w]["加命中"] = math.modf(JY.Wugong[w]["加命中"] * 1.2)
                end
                if JY.Wugong[w]["攻击范围"] == 3 then
                    JY.Wugong[w]["加命中"] = math.modf(JY.Wugong[w]["加命中"] * 0.8)
                end
                if JY.Wugong[w]["加命中"] > 1000 then
                    -- JY.Wugong[w]["加命中"] = 1000
                end
            end
        end
        CC.TX['初始天赋'] = 1
        if CC.TX['初始天赋'] == 1 then
            for p = 0, JY.PersonNum - 1 do
                if CC.PTF[p] ~= nil then
                    for i, v in pairs(CC.PTF[p]) do
                        if v == 1 then
                            SetTF(p, i, 1)
                            -- lib.Debug(JY.Person[p]['姓名']..'天赋='..i)
                        end
                    end
                end
            end
            CC.TX['初始天赋'] = 0
        end
        lib.Debug(JY.Person[1]['姓名'] .. ' tf=' .. JY.Person[1]['天赋' .. 2])
        ClsN()
        Moshixz()
        ClsN()
        GAME_START1()
        ClsN()
        GAME_START2()
        ClsN()
        lib.LoadPicture(CC.BG01File, -1, -1)
        local cxn = JY.Base['畅想']
        JY.Person[30]['门派'] = 6
        if JY.Person[0]['门派'] > 1 then
            TF_table()
        elseif JY.Base["畅想"] == 757 then
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
        local waitwz = '第一次进入游戏，正在加载中...'
        local size = CC.DefaultFont
        DrawString(CC.ScreenW - size * 14 - string.len(waitwz) / 4 * size, CC.ScreenH - size * 2 - size / 2, waitwz,
            C_WHITE, size)
        ShowScreen()

        if JY.Base["标准"] == 6 then
            JY.Person[0]["内力性质"] = 3
        end

        -- 其他人物初始化
        for p = 0, JY.PersonNum - 1 do
            local P = JY.Person[p]
            local fj = JY.Person[p]["畅想分阶"]
            local nd = JY.Base["难度"]
            local zm = limitX(JY.Base["周目"], 1, 100)
            if P['内力最大值'] < 2500 then
                P['内力最大值'] = 2500
                P['内力'] = 2500
            end
            -- 敌方的初始化
            if CC.PersonExit[p] == nil and p ~= 0 and p ~= 171 and p ~= 172 and p ~= 591 then
                for i = 1, JY.Base["武功数量"] do
                    if JY.Person[p]["武功" .. i] > 0 then
                        -- 不到10级的加到10级
                        if JY.Person[p]["武功等级" .. i] < 900 then
                            JY.Person[p]["武功等级" .. i] = 900
                        end
                    end
                end
                if fj == 1 then
                    P['体质'] = 15
                elseif fj == 2 then
                    P['体质'] = 13
                elseif fj == 3 then
                    P['体质'] = 12
                elseif fj == 4 then
                    P['体质'] = 8
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
                P["攻击力"] = math.modf(gj * ndjc)
                P["防御力"] = math.modf(fy * ndjc)
                P["轻功"] = math.modf(qg * ndjc)
                if JY.Person[p]["武器"] > -1 then
                    JY.Thing[JY.Person[p]["武器"]]["装备等级"] = 6
                end
                if JY.Person[p]["防具"] > -1 then
                    JY.Thing[JY.Person[p]["防具"]]["装备等级"] = 6
                end
                if JY.Person[p]["坐骑"] > -1 then
                    JY.Thing[JY.Person[p]["坐骑"]]["装备等级"] = 6
                end

                local xs = 0
                local wc = 0
                local sw = 0

                ---NPC周目增加属性
                -- 每周目增加20点系数，三围，武常
                if nd > 1 and p ~= 591 then
                    xs = zm
                    wc = zm * 3
                    sw = zm * 3
                end
                -- 每周目增加20点系数，三围，武常
                if nd > 1 and p ~= 591 then
                    xs = xs + nd * 5
                    sw = sw + nd * 5
                    wc = wc + nd * 5
                end
                if nd >= 3 and JY.Person[p]["畅想分阶"] <= 3 then
                    sw = sw + nd * zm
                    xs = xs + nd * zm
                    wc = wc + nd * zm
                end
                -- 修改标记
                local fj = limitX(6 - JY.Person[p]["畅想分阶"], 1, 6)
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
                        JY.Person[p]["攻击力"] = JY.Person[p]["攻击力"] + tt
                    elseif n == 2 then
                        JY.Person[p]["防御力"] = JY.Person[p]["防御力"] + tt
                    else
                        JY.Person[p]["轻功"] = JY.Person[p]["轻功"] + tt
                    end
                    sz = sz - tt
                end
                local zm_smnl = fj * fj * JY.Base['周目'] * JY.Base['难度']
                JY.Person[p]["拳掌功夫"] = JY.Person[p]["拳掌功夫"] + xs
                JY.Person[p]["指法技巧"] = JY.Person[p]["指法技巧"] + xs
                JY.Person[p]["御剑能力"] = JY.Person[p]["御剑能力"] + xs
                JY.Person[p]["耍刀技巧"] = JY.Person[p]["耍刀技巧"] + xs
                JY.Person[p]["特殊兵器"] = JY.Person[p]["特殊兵器"] + xs
                JY.Person[p]["武学常识"] = JY.Person[p]["武学常识"] + wc
                JY.Person[p]["基础生命"] = zm_smnl
                JY.Person[p]["内力最大值"] = JY.Person[p]["内力最大值"] + zm_smnl * 2
                AddPersonAttrib(p, '内力', math.huge)
                KfSet(p)
                Hp_Max(p)
                Mp_Max(p)
                AddPersonAttrib(p, '生命', math.huge)
            else
                if p == 0 then
                    -- lib.Debug('主角初始设定')
                    JY.Person[p]["畅想分阶"] = 6
                    JY.Person[p]["攻击力"] = 40
                    JY.Person[p]["防御力"] = 40
                    JY.Person[p]["轻功"] = 40
                    local p_zz = JY.Person[p]["资质"];
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
                    if p == 0 and JY.Base['畅想'] == 546 then
                        nfqg = 3
                    end
                    if JY.Person[p]['拳法成长'] < 50 then
                        JY.Person[p]['拳法成长'] = 50
                    end
                    if JY.Person[p]['指法成长'] < 50 then
                        JY.Person[p]['指法成长'] = 50
                    end
                    if JY.Person[p]['剑法成长'] < 50 then
                        JY.Person[p]['剑法成长'] = 50
                    end
                    if JY.Person[p]['刀法成长'] < 50 then
                        JY.Person[p]['刀法成长'] = 50
                    end
                    if JY.Person[p]['奇门成长'] < 50 then
                        JY.Person[p]['奇门成长'] = 50
                    end
                    JY.Person[p]['体质'] = JY.Person[p]['体质'] + (6 - ups)
                    JY.Person[p]["攻击力"] = JY.Person[p]["攻击力"] + 29 * ups
                    JY.Person[p]["防御力"] = JY.Person[p]["防御力"] + 29 * ups
                    JY.Person[p]["轻功"] = JY.Person[p]["轻功"] + 29 * ups + nfqg
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
                    P["攻击力"] = math.modf(gj * ndjc)
                    P["防御力"] = math.modf(fy * ndjc)
                    P["轻功"] = math.modf(qg * ndjc)
                    -- KfSet(p)
                end

                if JY.Person[p]['拳法成长'] < 50 then
                    JY.Person[p]['拳法成长'] = 50
                end
                if JY.Person[p]['指法成长'] < 50 then
                    JY.Person[p]['指法成长'] = 50
                end
                if JY.Person[p]['剑法成长'] < 50 then
                    JY.Person[p]['剑法成长'] = 50
                end
                if JY.Person[p]['刀法成长'] < 50 then
                    JY.Person[p]['刀法成长'] = 50
                end
                if JY.Person[p]['奇门成长'] < 50 then
                    JY.Person[p]['奇门成长'] = 50
                end
                -- 修复医疗、用毒、解毒能力不与等级挂钩的问题
                if JY.Person[p]["医疗能力"] >= 20 then
                    JY.Person[p]["医疗能力"] = JY.Person[p]["医疗能力"] + 29 * 2
                end
                if JY.Person[p]["用毒能力"] >= 20 then
                    JY.Person[p]["用毒能力"] = JY.Person[p]["用毒能力"] + 29 * 2
                end
                if JY.Person[p]["解毒能力"] >= 20 then
                    JY.Person[p]["解毒能力"] = JY.Person[p]["解毒能力"] + 29 * 2
                end
                if p == 0 and JY.Base["畅想"] == 75 then
                    JY.Person[p]["拳掌功夫"] = JY.Person[p]["拳掌功夫"] + 6 * 29
                    JY.Person[p]["指法技巧"] = JY.Person[p]["指法技巧"] + 6 * 29
                    JY.Person[p]["御剑能力"] = JY.Person[p]["御剑能力"] + 6 * 29
                    JY.Person[p]["耍刀技巧"] = JY.Person[p]["耍刀技巧"] + 6 * 29
                    JY.Person[p]["特殊兵器"] = JY.Person[p]["特殊兵器"] + 6 * 29
                end
                -- 周目增加属性
                local xs = 0
                local wc = 0
                local sw = 0

                ---NPC周目增加属性
                -- 每周目增加20点系数，三围，武常
                if nd > 1 and p ~= 591 then
                    xs = zm
                    wc = zm * 3
                    sw = zm * 3
                end
                -- 每周目增加20点系数，三围，武常
                if nd > 1 and p ~= 591 then
                    xs = xs + nd * 5
                    sw = sw + nd * 5
                    wc = wc + nd * 5
                end
                if nd >= 3 and JY.Person[p]["畅想分阶"] <= 3 then
                    sw = sw + nd * zm
                    xs = xs + nd * zm
                    wc = wc + nd * zm
                end
                -- 修改标记
                local fj = limitX(6 - JY.Person[p]["畅想分阶"], 1, 6)
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
                        JY.Person[p]["攻击力"] = JY.Person[p]["攻击力"] + tt
                    elseif n == 2 then
                        JY.Person[p]["防御力"] = JY.Person[p]["防御力"] + tt
                    else
                        JY.Person[p]["轻功"] = JY.Person[p]["轻功"] + tt
                    end
                    sz = sz - tt
                end
                local zm_smnl = fj * fj * JY.Base['周目'] * JY.Base['难度']
                JY.Person[p]["拳掌功夫"] = JY.Person[p]["拳掌功夫"] + xs
                JY.Person[p]["指法技巧"] = JY.Person[p]["指法技巧"] + xs
                JY.Person[p]["御剑能力"] = JY.Person[p]["御剑能力"] + xs
                JY.Person[p]["耍刀技巧"] = JY.Person[p]["耍刀技巧"] + xs
                JY.Person[p]["特殊兵器"] = JY.Person[p]["特殊兵器"] + xs
                JY.Person[p]["武学常识"] = JY.Person[p]["武学常识"] + wc
                JY.Person[p]["基础生命"] = zm_smnl
                JY.Person[p]["内力最大值"] = JY.Person[p]["内力最大值"] + zm_smnl * 2
                AddPersonAttrib(p, '内力', math.huge)
                Hp_Max(p)
                Mp_Max(p)
                AddPersonAttrib(p, '生命', math.huge)
            end
            JY.Person[p]['好感'] = 0
            -- 初始招式计算		
            for j = 1, JY.Base["武功数量"] do
                local wugong = JY.Person[p]["武功" .. j]
                if wugong > 0 then
                    KF_zsset(p, wugong)
                end
            end
        end
        JY.Person[498]['门派'] = 24
        JY.Base['妻子'] = -1
        JY.Base['孩子'] = -1
        JY.Wugong[52]['门派'] = 17
        JY.Wugong[182]['层级'] = 4
        JY.Person[130]['健康'] = 1
        JY.Person[78]['健康'] = 1
        JY.Person[610]['健康'] = 1
        JY.Person[0]['健康'] = JY.Person[JY.Base['畅想']]['健康']
        addevent(101, 13, 1, 3055, 1, 8696)
        -- 无酒不欢：增加一些初始化设定
        -- 萧秋水忘情天书战斗
        instruct_3(117, 23, 1, 0, 1170, 0, 0, 4902 * 2, 4902 * 2, 4902 * 2, 0, 26, 13)
        -- 华山后山谢无悠
        instruct_3(80, 17, 1, 0, 4105, 0, 0, 4133 * 2, 4133 * 2, 4133 * 2, 0, -2, -2)
        JY.Wugong[170]["武功动画&音效"] = 39
        JY.Wugong[297]["武功动画&音效"] = 39
        JY.Person[750]['半身像'] = 353
        addevent(166, 4, 1, 2002, 1, nil) -- 血刀绝学
        addevent(156, 5, 1, 2005, 1, nil) -- 天机宫绝学	
        addevent(57, 5, 1, 1222, 1, 7018) -- 华山岳灵珊
        addevent(10, 25, 0, 3054, 3, 0)
        null(57, 6)
        if JY.Base['畅想'] == 51 or JY.Base['畅想'] == 113 then
            instruct_68(0, 3, 1, 0)
        end
        if JY.Base['畅想'] == 64 then
            instruct_68(0, 4, 1, 0)
        end

        -- 李文秀贴图
        instruct_3(62, 4, 0, 0, 0, 0, 0, 9238, 9238, 9238, 0, 0, 0);
        -- 新华山论剑事件
        addevent(80, 19, 1, 4141, 1, 4335 * 2) -- 羊
        -- lib.PlayMPEG(CONFIG.DataPath .. "/avi/1.mp4",VK_ESCAPE) --视频文件
        Cls()
        JY.Thing[372]["练出秘技"] = 1
        JY.Thing[235]["练出秘技"] = 4
        JY.Wugong[343]['攻击范围'] = 1
        JY.Wugong[343]['移动范围' .. 10] = 7
        JY.Wugong[343]['武功动画&音效'] = 115
        JY.Wugong[343]['攻击力' .. 10] = 1400
        JY.Wugong[345]['攻击力' .. 10] = 1400
        JY.Person[64]['秘技' .. 1] = 4
        JY.Person[113]['秘技' .. 1] = 3
        JY.Person[51]['秘技' .. 1] = 3
        JY.Wugong[202]["攻击力" .. 10] = 700
        JY.Scene[24]['名称'] = '苗家庄'
        JY.Teji[26]['组合武功' .. 1] = 96
        JY.Teji[26]['组合武功' .. 2] = 144
        JY.Teji[26]['武功数量'] = 2
        JY.Teji[62]['组合武功' .. 1] = 55
        JY.Teji[62]['组合武功' .. 2] = 59
        JY.Teji[62]['武功数量'] = 2
        JY.Teji[62]['名称'] = '虎虎生风'
        null(151, 28)
        null(43, 30)
        null(43, 31)
        local name = JY.Person[0]['姓名']
        local name1 = string.sub(name, 1, 2)
        local name2 = string.sub(name, 3, 4)
        local name3 = string.sub(name, 5, 6)
        local name4 = string.sub(name, 7, 8)
        local nm = string.len(name)
        if nm < 8 then
            JY.Scene[70]['名称'] = JY.Person[0]['姓名'] .. '居'
        else
            JY.Scene[70]['名称'] = name1 .. name2 .. '居'
        end
    else
        for p = 0, JY.PersonNum - 1 do
            for i = 1, JY.Base["武功数量"] do
                if JY.Person[p]["武功" .. i] > 0 then
                    if p < 191 then
                        -- JY.Person[p]["武功等级" .. i] = 999    --BOSS武功是为极
                    else
                        -- 不到10级的加到10级
                        if JY.Person[p]["武功等级" .. i] < 900 then
                            JY.Person[p]["武功等级" .. i] = 900
                        end
                    end
                else
                    break
                end
            end
            JY.Person[0]["半身像"] = 752
            if JY.Person[p]["武器"] > -1 then
                JY.Person[p]["武器"] = -1
            end
            if JY.Person[p]["防具"] > -1 then
                JY.Person[p]["防具"] = -1
            end
            if JY.Person[p]["坐骑"] > -1 then
                JY.Person[p]["坐骑"] = -1
            end
            -- 生命不足200的加到200
            if JY.Person[p]["生命最大值"] < 200 then
                JY.Person[p]["生命最大值"] = 200
                JY.Person[p]["生命"] = JY.Person[p]["生命最大值"]
            end

            -- 内力不足200的加到200
            if JY.Person[p]["内力最大值"] < 200 then
                JY.Person[p]["内力最大值"] = 200
                JY.Person[p]["内力"] = JY.Person[p]["内力最大值"]
            end
        end
    end
    -- 定义武功消耗
    for w = 0, JY.WugongNum - 1 do
        local wl = JY.Wugong[w]["攻击力" .. 10]
        JY.Wugong[w]["消耗内力点数"] = JY.Wugong[w]['层级']*100
    end
    for x = 1, JY.PersonNum - 1 do
        for i = 1, JY.Base['武功数量'] do
            local kf = JY.Person[x]['武功' .. i]
            if kf > 0 then
                MIJI_PD(x, KF_thing(kf), 1)
            end
        end
    end
    lib.Debug('CC.kaijuwugong1' .. CC.kaijuwugong1)
    -- break
end

-- 无酒不欢：机率判定函数
function JLSD(s1, s2, dw)
    local s = math.random(100)
    local chance_up = 0;
    local kf_ng = JY.Person[dw]['主运内功']
    local dkfcj_ng = JY.Wugong[kf_ng]['层级']
    -- 论剑打赢阿凡提奖励，几率+6
    -- 如果不在队伍中，几率+20
    if inteam(dw) == false then
        -- chance_up = chance_up + 10
    end
    if (JY.Base["标准"] == 7 and dw == 0 and WAR.SEYB == 0) or match_ID(dw, 9925) then
        chance_up = chance_up + 5
    end
    -- 冯衡增加特效
    if match_ID(dw, 588) then
        chance_up = chance_up + 5
    end
    -- 惊才绝艳
    if match_ID(dw, 9804) then
        chance_up = chance_up + 8
    end
    -- 御法绝尘
    if JY.Status == GAME_WMAP then
        for wid = 0, WAR.PersonNum - 1 do
            -- 队友防御加成
            if ZDGH(wid, 9899) then
                if WAR.Person[wid]["我方"] == true then
                    chance_up = chance_up + 5
                else
                    chance_up = chance_up - 5
                end
                break
            end
        end
    end
    -- lib.Debug("最低"..s1.."  最高"..s2)
    --if Curr_NG(dw, 102) then
    --内轻特效1024 
    if NeiGong_tx(dw,1024) then     
        chance_up = chance_up + (1+dkfcj_ng)
    end
    -- 判定是否成功
    if s1 < s and s <= s2 + chance_up then
        return true
    else
        return false
    end

end

-- 游戏主循环
function Game_Cycle()
    lib.Debug("Start game cycle");

    while JY.Status ~= GAME_END and JY.Status ~= GAME_START do
        if JY.Restart == 1 then
            break
        end
        local t1 = lib.GetTime();

        JY.Mytick = JY.Mytick + 1; -- 20个节拍无击键，则主角变为站立状态
        if JY.Mytick % 20 == 0 then
            JY.MyCurrentPic = 0;
        end

        if JY.Mytick % 1000 == 0 then
            JY.MYtick = 0;
        end

        if JY.Status == GAME_FIRSTMMAP then -- 首次显示主场景，重新调用主场景贴图，渐变显示。然后转到正常显示
            CleanMemory()
            lib.ShowSlow(20, 1)
            JY.MmapMusic = 57
            JY.Status = GAME_MMAP
            Init_MMap()
            local sc = CC.Shichen
            if CC.TX['夜幕'] == 1 then
                --sc = 6
            end
            lib.DrawMMap(JY.Base["人X"], JY.Base["人Y"], GetMyPic(), sc)
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

-- 场景处理主函数 小地图信息
function Game_SMap() -- 场景处理主函数
    if JY.Restart == 1 then
        return
    end
    DrawSMap();
    -- 无酒不欢：下方显示	
    if CC.ShowXY == 1 then
        if JY.SubScene ~= 150 then
            -- lib.LoadPNG(91,43*2,CC.WX*136,CC.HY*142,2)
            -- DrawString(CC.WX*70,CC.HY*129,string.format("%s %d %d",JY.Scene[JY.SubScene]["名称"],JY.Base["人X1"],JY.Base["人Y1"]) ,C_WHITE,CC.Fontsmall*0.8);
        else
            -- lib.LoadPNG(91,43*2,CC.WX*136,CC.HY*142,2)
            -- DrawString(CC.WX*70,CC.HY*129,string.format("%s %d %d","天关"..8+JY.Base["天关"].."层",JY.Base["人X1"],JY.Base["人Y1"]) ,C_WHITE,CC.Fontsmall*0.8);
        end
    end
    JYZTB(); -- 左上角简易信息	
    DrawTimer(); -- 右上角信息提示
	--testMarquee()
    -- DrawTimerA()

    ShowScreen();
    lib.SetClip(0, 0, 0, 0)

    local d_pass = GetS(JY.SubScene, JY.Base["人X1"], JY.Base["人Y1"], 3); -- 当前路过事件
    if d_pass >= 0 then
        if d_pass ~= JY.OldDPass then -- 避免重复触发
            EventExecute(d_pass, 3); -- 路过触发事件
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
    local isout = 0; -- 是否碰到出口
    if (JY.Scene[JY.SubScene]["出口X1"] == JY.Base["人X1"] and JY.Scene[JY.SubScene]["出口Y1"] == JY.Base["人Y1"]) or
        (JY.Scene[JY.SubScene]["出口X2"] == JY.Base["人X1"] and JY.Scene[JY.SubScene]["出口Y2"] == JY.Base["人Y1"]) or
        (JY.Scene[JY.SubScene]["出口X3"] == JY.Base["人X1"] and JY.Scene[JY.SubScene]["出口Y3"] == JY.Base["人Y1"]) then
        isout = 1;
    end
    -- 出到大地图
    if isout == 1 then
        -- 无酒不欢：修复马车直接飞进场景后出来会遮挡建筑物的问题
        if JY.Base["人X"] == JY.Scene[JY.SubScene]["外景入口X1"] and JY.Base["人Y"] ==
            JY.Scene[JY.SubScene]["外景入口Y1"] then
            -- 雪山要单独处理
            if JY.SubScene == 2 then
                JY.Base["人Y"] = JY.Base["人Y"] + 1
                -- 朱府要单独处理
            elseif JY.SubScene == 92 then
                JY.Base["人X"] = JY.Base["人X"] + 1
            else
                if JY.Base["人方向"] == 0 then
                    JY.Base["人Y"] = JY.Base["人Y"] - 1
                elseif JY.Base["人方向"] == 1 then
                    JY.Base["人X"] = JY.Base["人X"] + 1
                elseif JY.Base["人方向"] == 2 then
                    JY.Base["人X"] = JY.Base["人X"] - 1
                elseif JY.Base["人方向"] == 3 then
                    JY.Base["人Y"] = JY.Base["人Y"] + 1
                end
            end
        end
        -- 明教地道要单独处理
        if JY.SubScene == 13 then
            JY.Base["人X"] = 68
            JY.Base["人Y"] = 397
        end
        -- 蒙古包要单独处理
        if JY.SubScene == 6 then
            JY.Base["人X"] = 49
            JY.Base["人Y"] = 111
        end
        JY.Status = GAME_MMAP
        -- lib.PicInit()
        CleanMemory()
        JY.MmapMusic = JY.Scene[JY.SubScene]["出门音乐"]
        MMapName()
        -- 如果没有设置出门音乐的话
        if JY.MmapMusic < 0 then
            JY.MmapMusic = 0
        end
        Init_MMap()
        JY.SubScene = -1
        JY.oldSMapX = -1
        JY.oldSMapY = -1
        local sc = CC.Shichen
        if CC.TX['夜幕'] == 1 then
            sc = 6
        end
        lib.DrawMMap(JY.Base["人X"], JY.Base["人Y"], GetMyPic(), sc)
        lib.GetKey()
        lib.ShowSlow(20, 0)
        return
    end
    -- 是否跳转到其他场景
    if JY.Scene[JY.SubScene]["跳转场景"] >= 0 and JY.Base["人X1"] == JY.Scene[JY.SubScene]["跳转口X1"] and
        JY.Base["人Y1"] == JY.Scene[JY.SubScene]["跳转口Y1"] then
        local OldScene = JY.SubScene
        JY.SubScene = JY.Scene[JY.SubScene]["跳转场景"]
        lib.ShowSlow(20, 1)
        if JY.Scene[OldScene]["外景入口X1"] ~= 0 then
            JY.Base["人X1"] = JY.Scene[JY.SubScene]["入口X"]
            JY.Base["人Y1"] = JY.Scene[JY.SubScene]["入口Y"]
        else
            JY.Base["人X1"] = JY.Scene[JY.SubScene]["跳转口X2"]
            JY.Base["人Y1"] = JY.Scene[JY.SubScene]["跳转口Y2"]
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
			--先检测跟上次不同的方向是否被按下
			for i = VK_RIGHT,VK_UP do
				if i ~= CC.PrevKeypress and RepeatState[i] ~=0 then
					keypress = i
					repeatkey = true
				end
			end 
			--如果与上次不同的方向未被按下，则检测与上次相同的方向是否被按下
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
        elseif keypress == VK_SPACE or keypress == VK_RETURN then -- 空格触发事件
            if JY.Base["人方向"] >= 0 then
                local d_num = GetS(JY.SubScene, JY.Base["人X1"] + CC.DirectX[JY.Base["人方向"] + 1],
                    JY.Base["人Y1"] + CC.DirectY[JY.Base["人方向"] + 1], 3);
                if d_num >= 0 then
                    EventExecute(d_num, 1);
                end
            end
            -- 无酒不欢：全套快捷键 7-30
        elseif keypress == VK_S and JY.SubScene ~= 150 then -- 存档
            Menu_SaveRecord()
        elseif keypress == VK_L and JY.SubScene ~= 150 then -- 读档
            Menu_ReadRecord()
        elseif keypress == VK_F1 then -- 物品
            Cls()
            Menu_Thing()
        elseif keypress == VK_Z then -- 状态
            Cls()
            -- Duiwumb()
            LGJYXX()
        elseif keypress == VK_M then -- 队友排位
            Cls()
            Game_sm()
        elseif keypress == VK_F3 then -- 队友排位
            Cls()
            Menu_TZDY()
        elseif keypress == VK_F4 then -- 整理
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
        elseif mx >= bx * 1171 and mx <= bx * 1255 and my >= by * 623 and by <= by * 706 and JY.Base["剧情"] == 1 then
            Cls()
            CHOUKA()
        elseif mx > CC.WX * 604 and mx < CC.WX * 604 + CC.WX * 72 and my > CC.HY * 3 and my < CC.HY * 77 then
            Cls()
            LGWeather()
        elseif mx > 0 and mx < ffx and my > CC.ScreenH / 6 and my < CC.ScreenH / 6 + h then -- 简易信息
            Cls()
            LGJYXX()
        elseif mx > 0 and mx < ffx and my > CC.ScreenH / 6 + h * 2 and my < CC.ScreenH / 6 + h * 3 then -- 攻略 图签 
            Cls()
            Game_sm()
        elseif mx > 0 and mx < ffx and my > CC.ScreenH / 6 + h * 3 and my < CC.ScreenH / 6 + h * 4 then -- 任务
            Cls()
            Game_Kdef()
        elseif mx > CC.ScreenW - jhx and mx < CC.ScreenW and  my > CC.ScreenH/30 and my < CC.ScreenH/30 + jhy then --江湖传闻
            JH_Txt()
        else
            AutoMoveTab = {
                [0] = 0
            }
            local x0 = JY.Base["人X1"]
            local y0 = JY.Base["人Y1"]

            local px = x0
            local py = y0
            if CONFIG.Zoom == 100 then
                -- 无酒不欢：修正在地图边界自动寻路错误的问题
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

            if CONFIG.Zoom ~= 100 then -- 无酒不欢：不知道什么毛病，反正不加就是有毛病
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

    -- 无酒不欢：有标记事件坐标，且自动走到前面一格才会触发事件
    if CC.AutoMoveEvent[1] ~= 0 and
        (JY.Base["人X1"] == CC.AutoMoveEvent[1] or JY.Base["人X1"] - 1 == CC.AutoMoveEvent[1] or JY.Base["人X1"] + 1 ==
            CC.AutoMoveEvent[1]) and
        (JY.Base["人Y1"] == CC.AutoMoveEvent[2] or JY.Base["人Y1"] - 1 == CC.AutoMoveEvent[2] or JY.Base["人Y1"] + 1 ==
            CC.AutoMoveEvent[2]) then
        CC.AutoMoveEvent[0] = 1 -- 鼠标操作触发事件
    end

    if AutoMoveTab[0] ~= 0 then -- 鼠标自动走动
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
        x = JY.Base["人X1"] + CC.DirectX[direct + 1];
        y = JY.Base["人Y1"] + CC.DirectY[direct + 1];
        JY.Base["人方向"] = direct;
        if JY.WalkCount == 1 then
            lib.Delay(CC.Frame)
        end
    else
        x = JY.Base["人X1"];
        y = JY.Base["人Y1"];
    end

    JY.MyPic = GetMyPic();
    DtoSMap();
    if SceneCanPass(x, y) == true then -- 新的坐标可以走过去
        JY.Base["人X1"] = x;
        JY.Base["人Y1"] = y;
    end

    JY.Base["人X1"] = limitX(JY.Base["人X1"], 1, CC.SWidth - 2);
    JY.Base["人Y1"] = limitX(JY.Base["人Y1"], 1, CC.SHeight - 2);

    -- 一些新的事件
    NEvent(keypress)
end

-- 大地图信息
function Game_MMap() -- 主地图
    local bx, by = CC.ScreenW / 1360, CC.ScreenH / 768
    if JY.Restart == 1 then
        return
    end
    local direct = -1;
    local px, py = -1, -1
    local bx, by = CC.WX, CC.HY
    local jyxx = 0
	local repeatkey = false
	lib.WalkMode(1) --适配新引擎
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
	
    --先检测跟上次不同的方向是否被按下
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
        elseif keypress == VK_H then -- 按h直接回家
            JY.Wugong[343]['攻击范围'] = 1
            JY.Wugong[343]['移动范围' .. 10] = 7
            JY.Wugong[343]['武功动画&音效'] = 115
            JY.Wugong[343]['攻击力' .. 10] = 1400
            JY.Wugong[345]['攻击力' .. 10] = 1400
            JY.Person[64]['秘技' .. 1] = 4
            JY.Person[113]['秘技' .. 1] = 3
            JY.Person[51]['秘技' .. 1] = 3
            JY.Wugong[202]["攻击力" .. 10] = 700
            My_Enter_SubScene(70, 35, 31, 2);
            return;
            -- 无酒不欢：全套快捷键 7-30
        elseif keypress == VK_S and JY.SubScene ~= 150 then -- 存档
            Menu_SaveRecord()
        elseif keypress == VK_L and JY.SubScene ~= 150 then -- 读档
            Menu_ReadRecord()
            if JY.Status ~= GAME_MMAP then
                return;
            end
        elseif keypress == VK_F1 then -- 物品
            Cls()
            Menu_Thing()            
        elseif keypress == VK_Z then -- 状态
            Cls()
            -- Duiwumb()
            LGJYXX()
        elseif keypress == VK_R then -- 物品
            Cls()
            Game_Kdef()
        elseif keypress == VK_M then -- 马车	
            Cls()
            -- My_ChuangSong_Ex()
            CHUANSONG()
            if JY.Status ~= GAME_MMAP then
                return;
            end
        elseif keypress == VK_F3 then -- 队友排位
            Cls()
            Menu_TZDY()
        elseif keypress == VK_F4 then -- 整理
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
        mx = math.modf(mx) + JY.Base["人X"];
        my = math.modf(my) + JY.Base["人Y"]

        -- 鼠标移动
        if ktype == 2 then
            if lib.GetMMap(mx, my, 3) > 0 then -- 如果有建筑，判断是否可进入
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
                            i = 5; -- 退出循环
                            break
                        end
                    end
                end
            else
                CC.MMapAdress[0] = nil;
            end
            -- 鼠标左键
        elseif ktype == 3 then
            local ffx, ffy = lib.GetPNGXY(91, 504 * 2)
            local jhx,jhy = lib.GetPNGXY(91,556*2)
            if tmpx > 0 and tmpx < CC.WX * 100 and tmpy > 0 and tmpy < CC.HY * 100 then
                jiemian(1)
            elseif tmpx > CC.WX * 604 and tmpx < CC.WX * 604 + CC.WX * 72 and tmpy > CC.HY * 3 and tmpy < CC.HY * 77 then
                LGWeather()
            elseif tmpx > 0 and tmpx < ffx and tmpy > CC.ScreenH / 6 and tmpy < CC.ScreenH / 6 + ffy then -- 简易信息
                LGJYXX()
            elseif tmpx > 0 and tmpx < ffx and tmpy > CC.ScreenH / 4 and tmpy < CC.ScreenH / 4 + ffy then -- 打开地图		
                CHUANSONG()
            elseif tmpx > 0 and tmpx < ffx and tmpy > CC.ScreenH / 3 and tmpy < CC.ScreenH / 3 + ffy * 1.2 then -- 攻略 图签 
                Game_sm()
            elseif tmpx > 0 and tmpx < ffx and tmpy > CC.ScreenH / 3 + ffy * 1.2 and tmpy < CC.ScreenH / 3 + ffy * 1.2 *
                2 then -- 攻略 图签 
                Game_Kdef()
            elseif tmpx > CC.ScreenW - jhx and tmpx < CC.ScreenW and  tmpy > CC.ScreenH/30 and tmpy < CC.ScreenH/30 + jhy then --江湖传闻
                JH_Txt()    
            else
                if CC.MMapAdress[0] ~= nil then
                    mx = CC.MMapAdress[3] - JY.Base["人X"];
                    my = CC.MMapAdress[4] - JY.Base["人Y"];
                    CC.MMapAdress[0] = nil;
                else
                    AutoMoveTab = {
                        [0] = 0
                    }
                    mx = mx - JY.Base["人X"]
                    my = my - JY.Base["人Y"]
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

    local x, y; -- 按照方向键要到达的坐标
    local CanMove = function(nd, nnd)
        local nx, ny = JY.Base["人X"] + CC.DirectX[nd + 1], JY.Base["人Y"] + CC.DirectY[nd + 1]
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
    if direct ~= -1 then -- 按下了光标键
        AddMyCurrentPic(); -- 增加主角贴图编号，产生走路效果
        x = JY.Base["人X"] + CC.DirectX[direct + 1];
        y = JY.Base["人Y"] + CC.DirectY[direct + 1];
        JY.Base["人方向"] = direct;
        if JY.WalkCount == 1 then
            lib.Delay(CC.Frame)
        end
    else
        x = JY.Base["人X"];
        y = JY.Base["人Y"];

    end

    if direct ~= -1 then
        JY.SubScene = CanEnterScene(x, y); -- 判断是否进入子场景
    end

    if lib.GetMMap(x, y, 3) == 0 and lib.GetMMap(x, y, 4) == 0 then -- 没有建筑，可以到达
        JY.Base["人X"] = x;
        JY.Base["人Y"] = y;
    end
    JY.Base["人X"] = limitX(JY.Base["人X"], 10, CC.MWidth - 10); -- 限制坐标不能超出范围
    JY.Base["人Y"] = limitX(JY.Base["人Y"], 10, CC.MHeight - 10);

    if CC.MMapBoat[lib.GetMMap(JY.Base["人X"], JY.Base["人Y"], 0)] == 1 then
        JY.Base["乘船"] = 1;
    else
        JY.Base["乘船"] = 0;
    end
    local sc = CC.Shichen
    if CC.TX['夜幕'] == 1 then
        sc = 6
    end
    lib.DrawMMap(JY.Base["人X"], JY.Base["人Y"], GetMyPic(), sc); -- 绘画主地图

    JYZTB(); -- 左上角简易信息	
    --DrawTimer(); -- 右上角动态提示
    -- DrawTimerA()

    -- 显示鼠标指中的场景名称
    if CC.MMapAdress[0] ~= nil then
        DrawStrBox(CC.MMapAdress[1] + 10, CC.MMapAdress[2], JY.Scene[CC.MMapAdress[0]]["名称"], C_GOLD, CC.DefaultFont);
    end

    ShowScreen();

    if JY.SubScene >= 0 then -- 进入子场景
        CleanMemory();
        -- lib.UnloadMMap();
        -- lib.PicInit();
        lib.ShowSlow(20, 1)

        JY.Status = GAME_SMAP;
        JY.MmapMusic = -1;

        JY.MyPic = GetMyPic();
        JY.Base["人X1"] = JY.Scene[JY.SubScene]["入口X"]
        JY.Base["人Y1"] = JY.Scene[JY.SubScene]["入口Y"]

        Init_SMap(1);
        return
    end
end

-- 主角走路
function walkto(xx, yy, x, y, flag)
    local x, y
    AutoMoveTab = {
        [0] = 0
    }
    if JY.Status == GAME_SMAP then
        x = x or JY.Base["人X1"]
        y = y or JY.Base["人Y1"]
    elseif JY.Status == GAME_MMAP then
        x = x or JY.Base["人X"]
        y = y or JY.Base["人Y"]
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
                -- 无酒不欢：一处蛋疼的细节修改，自动触发事件的站位优先级
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

function GetMyPic() -- 计算主角当前贴图
    local n;
    if JY.Status == GAME_MMAP and JY.Base["乘船"] == 1 then
        if JY.MyCurrentPic >= 4 then
            JY.MyCurrentPic = 0
        end
    else
        if JY.MyCurrentPic > 6 then
            JY.MyCurrentPic = 1
        end
    end

    if JY.Base["乘船"] == 0 then
        if JY.Base["畅想"] == 757 then
            n = CC.MyStartPicCG + JY.Base["人方向"] * 7 + JY.MyCurrentPic;
        elseif JY.Base['畅想'] == 752 then 
            n = CC.MyStartPicLG + JY.Base["人方向"] * 7 + JY.MyCurrentPic;
        elseif JY.Person[0]["性别"] == 0 then
            n = CC.MyStartPicM + JY.Base["人方向"] * 7 + JY.MyCurrentPic;
        else
            n = CC.MyStartPicF + JY.Base["人方向"] * 7 + JY.MyCurrentPic;
        end
    else
        n = CC.BoatStartPic + JY.Base["人方向"] * 4 + JY.MyCurrentPic;
    end
    return n;
end

-- 增加当前主角走路动画帧, 主地图和场景地图都使用
function AddMyCurrentPic()
    JY.MyCurrentPic = JY.MyCurrentPic + 1;
end

-- 场景是否可进
-- id 场景代号
-- x,y 当前主地图坐标
-- 返回：场景id，-1表示没有场景可进
function CanEnterScene(x, y) -- 场景是否可进
    for id = 0, JY.SceneNum - 1 do
        local scene = JY.Scene[id];
        if (x == scene["外景入口X1"] and y == scene["外景入口Y1"]) or
            (x == scene["外景入口X2"] and y == scene["外景入口Y2"]) then
            local e = scene["进入条件"];
            if e == 0 then -- 可进
                return id;
            elseif e == 1 then -- 不可进
                return -1
            end
        end
    end
    return -1;
end

-- 主菜单
function MMenu()
    local menu = {{"队伍", Menu_Teaminfo, 1}, {"物品", Menu_Thing, 1}, {"医疗", Menu_Doctor, 1},
                  {"解毒", Menu_DecPoison, 1}, {"离队", Menu_PersonExit, 1}, {"系统", Menu_System, 1}};

    ShowMenu(menu, 6, 0, CC.MainMenuX, CC.MainMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)
    local x1 = CC.ScreenH / 2
    local y1 = CC.ScreenW / 2
    -- lib.LoadPicture(CONFIG.DataPath.."body/999.png",x1,y1,CC.ScreenW/677*80)
end

-- 系统子菜单
function Menu_System()
    local menu = {{"读取进度", Menu_ReadRecord, 1}, {"保存进度", Menu_SaveRecord, 1},
                  {"关闭音乐", Menu_SetMusic, 1}, {"关闭音效", Menu_SetSound, 1},
                  {"物品整理", Menu_WPZL, 1}, -- {"系统攻略", Menu_Help, 1},
    {"通关记录", pastReview, 1}, {"我的代码", Menu_MYDIY, 1}, {"离开游戏", Menu_Exit2, 1}}
    if JY.EnableMusic == 0 then
        menu[3][1] = "打开音乐"
    end
    if JY.EnableSound == 0 then
        menu[4][1] = "打开音效"
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
    local r = LGMsgBox("我的代码", "执行自定义代码*指定在script/DIY.lua文件", {"确定", "取消"}, 2,
        0, 1);
    if r == 1 then
        --if instruct_18(312) then
            dofile(CONFIG.ScriptPath .. "DIY.lua");
        --end
    end
end

function Menu_Help()
    -- 暂时取消
    --[[
	local title = "系统攻略";
	local str ="装备说明：查看各种装备的说明。"
						.."*武功说明：查看各种武功的说明。"
						.."*天书攻略：各种天书的拿法，以及游戏技攻略。"
	local btn = {"装备说明","武功说明","天书攻略"};
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

-- 音乐开关
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

-- 音效开关
function Menu_SetSound()
    if JY.EnableSound == 0 then
        JY.EnableSound = 1
    else
        JY.EnableSound = 0
    end
    return 1
end

--游戏设置
function Menu_Switch()
	local bx, by = CC.WX, CC.HY
	local size = CC.DefaultFont*0.9
    local yemu = CC.TX['夜幕']
	local chuansong = CC.TX['传送']
	local yinyue = CC.TX['怀旧音乐']
	local tianqi = CC.TX['战斗天气']
	local xinmo = CC.TX['心魔']
	local w,h = lib.GetPNGXY(91,559*2) 
	local wz = {'开','关',
				'地图','文字',
				'开','关',
				'开','关',
				'开','关',
				'开','关',
				'慢','快',
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

		local menu = {	{CC.TX['夜幕'],0,0,0,0}, --夜幕  --1变量名称 2横向变量变化值  3横向坐标位移 4行数 5变量值
					{CC.TX['夜幕'],0,0,0,1}, --夜幕 
					{CC.TX['马车'],2,1,0,0}, --传送
					{CC.TX['马车'],2,1,0,1}, --传送
					{CC.TX['心魔'],0,0,1,0}, --心魔
					{CC.TX['心魔'],0,0,1,1}, --心魔
					{CC.TX['战斗天气'],2,1,1,0}, --战斗天气
					{CC.TX['战斗天气'],2,1,1,1}, --战斗天气
					{CC.TX['怀旧音乐'],0,0,2,0}, --怀旧音乐
					{CC.TX['怀旧音乐'],0,0,2,1}, --怀旧音乐
					{CC.TX['战斗显血'],2,1,2,0}, --战斗显血
					{CC.TX['战斗显血'],2,1,2,1}, --战斗显血
					{CC.TX['战斗速度'],0,0,3,0}, --战斗速度
					{CC.TX['战斗速度'],0,0,3,1}, --战斗速度

			}		
		local w2 = 0
		lib.LoadPNG(91, 559*2, CC.ScreenW / 2 - w/2, CC.ScreenH / 2 - h/2, 1)

		for i = 1,#wz do	
			local cl = C_WHITE
			if tb == i then 
				lib.LoadPNG(91,561*2,CC.ScreenW/2 - w/2 + size*5.5 + n*ww + w2,CC.ScreenH/2 - h/2 + size*1.8 + m*hh,1)
			end	

			--当前选择
			if menu[i][1] == menu[i][5] then 
				lib.LoadPNG(91,36*2,CC.ScreenW/2 - w/2 + size*5.3 + (menu[i][1] + menu[i][2])*ww + menu[i][3]*bx*190,CC.ScreenH/2 - h/2 + size*2.5 + menu[i][4]*hh,1,0,bx*20)
			end

			--文字列表
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
				CC.TX['夜幕'] = 0
			elseif tb == 2 then 
				CC.TX['夜幕'] = 1
			elseif tb == 3 then 
				CC.TX['马车'] = 0
			elseif tb == 4 then 
				CC.TX['马车'] = 1
			elseif tb == 5 then 
				CC.TX['心魔'] = 0
			elseif tb == 6 then 
				CC.TX['心魔'] = 1
			elseif tb == 7 then 
				CC.TX['战斗天气'] = 0
			elseif tb == 8 then 
				CC.TX['战斗天气'] = 1
			elseif tb == 9 then 
				CC.TX['怀旧音乐'] = 0
			elseif tb == 10 then 
				CC.TX['怀旧音乐'] = 1
			elseif tb == 11 then 
				CC.TX['战斗显血'] = 0
			elseif tb == 12 then 
				CC.TX['战斗显血'] = 1
			elseif tb == 13 then 
				CC.TX['战斗速度'] = 0
			elseif tb == 14 then 
				CC.TX['战斗速度'] = 1		
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
					CC.TX['夜幕'] = 0
				elseif tb == 2 then 
					CC.TX['夜幕'] = 1
				elseif tb == 3 then 
					CC.TX['马车'] = 0
				elseif tb == 4 then 
					CC.TX['马车'] = 1
				elseif tb == 5 then 
					CC.TX['心魔'] = 0
				elseif tb == 6 then 
					CC.TX['心魔'] = 1
				elseif tb == 7 then 
					CC.TX['战斗天气'] = 0
				elseif tb == 8 then 
					CC.TX['战斗天气'] = 1
				elseif tb == 9 then 
					CC.TX['怀旧音乐'] = 0
				elseif tb == 10 then 
					CC.TX['怀旧音乐'] = 1
				elseif tb == 11 then 
					CC.TX['战斗显血'] = 0
				elseif tb == 12 then 
					CC.TX['战斗显血'] = 1
				elseif tb == 13 then 
					CC.TX['战斗速度'] = 0
				elseif tb == 14 then 
					CC.TX['战斗速度'] = 1				
				end
			end
			m = 0
			n = 0
		end
	end
end

-- 队伍菜单
function Menu_Teaminfo()
    local menu = {{"状态查看", Menu_Status, 1}, {"队伍排序", Menu_TZDY, 1}}

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

-- 显示物品菜单
function SelectThing(thing, thingnum)
    local bx, by = CC.ScreenW / 1360, CC.ScreenH / 768
    local xnum = CC.MenuThingXnum;
    local ynum = CC.MenuThingYnum;

    local w = CC.ThingPicWidth * xnum + (xnum - 1) * CC.ThingGapIn + 2 * CC.ThingGapOut + CC.ScreenH / 2.021; -- 总体bx
    local h = CC.ThingPicHeight * ynum + (ynum - 1) * CC.ThingGapIn + 2 * CC.ThingGapOut - CC.ScreenH / 96; -- 物品栏by
	local dx = (CC.ScreenW - w) / 2;
    local dy = (CC.ScreenH - h - 2 * (CC.ThingFontSize + 2 * CC.MenuBorderPixel + 8)) / 2 - CC.ThingFontSize - CC.ScreenH / 69.818;
	local mjx = CC.ScreenW / 1.35  --980
	local mjy = CC.ScreenH / 4.7 --120
	local mjw = 22
	local mjh = 15
	local mjsize = CC.DefaultFont * 0.65
    local y1_1, y1_2, y2_1, y2_2, y3_1, y3_2; -- 名称，说明和图片的Y坐标

    local cur_line = 0;
    local cur_x = 0;
    local cur_y = 0;
    local cur_thing = -1;
    local wpsm = 0
    local color = C_WHITE
    -- 无酒不欢：记录最初的物品
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
            local Color_Switch = {{"Ｒ", PinkRed}, {"Ｇ", M_Wheat}, {"Ｂ", C_BLACK}, {"Ｗ", C_WHITE},
                                  {"Ｏ", C_ORANGE}, {"Ｌ", LimeGreen}, {"Ｄ", M_DeepSkyBlue}, {"Ｚ", Violet}}
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
                        local Color_Switch = {{"Ｒ", PinkRed}, {"Ｇ", M_Wheat}, {"Ｂ", C_BLACK},
                                              {"Ｗ", C_WHITE}, {"Ｏ", C_ORANGE}, {"Ｌ", LimeGreen},
                                              {"Ｄ", M_DeepSkyBlue}, {"Ｚ", Violet}}
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
                                me[#me + 1] = "Ｎ"
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
                        if string.sub(tfstr, 1, 2) == "Ｎ" then
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
                -- 选中物品颜色 
                if x == cur_x and y == cur_y then
                    boxcolor = S_Yellow;
                    if thing[id] ~= nil and thing[id] >= 0 then
                        cur_thing = thing[id];
                        local str = JY.Thing[thing[id]]["名称"];
                        -- 装备等级显示
                        if JY.Thing[thing[id]]["装备位置"] > -1 then
                            str = str .. " LV" .. JY.Thing[thing[id]]["装备等级"]
                        end
                        if JY.Thing[thing[id]]["类型"] == 1 or JY.Thing[thing[id]]["类型"] == 2 then
                            if JY.Thing[thing[id]]["使用人"] >= 0 then
                                str = str .. "(" .. JY.Person[JY.Thing[thing[id]]["使用人"]]["姓名"] .. ")";
                            end
                        end

                        local myfont = CC.FontSmall
                        local mx, my = dx + 4 * myfont, y3_2 + 2
                        local myflag = 0
                        local myThing = JY.Thing[thing[id]]

                        local str2 = JY.Thing[thing[id]]["物品说明"];
                        if thing[id] == 182 then
                            str2 = str2 .. string.format('(人%3d,%3d)', JY.Base['人X'], JY.Base['人Y'])
                        end
                        DrawString(dx + CC.ThingGapOut + CC.ScreenW / 68, y1_1 + CC.MenuBorderPixel + CC.ThingFontSize, str, C_GOLD, CC.ThingFontSize);
                        DrawString(dx + CC.ThingGapOut + CC.ScreenW / 68, y2_1 + CC.MenuBorderPixel + CC.ScreenH / 76.8, str2, C_ORANGE, CC.ThingFontSize * 0.9);

                        -- 物品说明显示
                        local function drawitem(ss, str, news)
                            local color = C_GOLD
                            local mys
                            if str == nil then
                                mys = ss
                            elseif myThing[ss] ~= 0 then
                                if news == nil then
                                    if myflag == 0 then
                                        -- 无酒不欢：装备的数值随等级变化
                                        if myThing["装备位置"] > -1 then
                                            local attr_gain = 0;
                                            if myThing[ss] > 0 then
                                                attr_gain = myThing[ss] * 10 + myThing[ss] *
                                                                (myThing["装备等级"] - 1) * 2
                                            elseif myThing[ss] < 0 then
                                                attr_gain = myThing[ss] * 10 - myThing[ss] *
                                                                (myThing["装备等级"] - 1) * 2
                                            end
                                            if attr_gain ~= 0 then
                                                mys = string.format(str .. ':%+d', attr_gain)
                                            end
                                        else
                                            mys = string.format(str .. ':%+d', myThing[ss])
                                        end
                                    elseif myflag == 1 then
                                        local id = thing[id]
                                        local wugong = JY.Thing[id]["练出武功"];
                                        mys = string.format(str .. ':%d', myThing[ss])
                                    end
                                else
                                    if myThing[ss] < 0 then
                                        return
                                    end
                                    mys = string.format(str .. ':%s', news[myThing[ss]])
                                end
                                -- 内属颜色
                                if myThing[ss] == 1 and ss == "需内力性质" then
                                    color = RGB(236, 200, 40)
                                elseif myThing[ss] == 2 and ss == "需内力性质" then
                                    color = RGB(236, 236, 236)
                                end
                            elseif myThing[ss] == 0 and ss == "需内力性质" then
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
                        -- 右侧物品说明 
                        local djwz = {"壹级", "贰级", "叁级", "肆级", "伍级", "陆级"}
                        local WPlv = ""
                        local WPNA = "名称: " .. myThing["名称"]
                        local dj = myThing["装备等级"]
                        if dj > 0 then
                            --WPlv = "名    称：" .. myThing["名称"] .. " " .. djwz[dj]
							WPlv = myThing["名称"] .. " " .. djwz[dj]
                        else
                            --WPlv = "名    称：" .. myThing["名称"]
							WPlv = myThing["名称"]
                        end
                        local nswz = ""
                        local neshu = ""
                        local zbxb = ""
                        local zbxb1 = {'护甲', '坐骑', '护符'}
                        local wqlx = {'拳法', '指法', '剑法', '刀法', '特殊'}
                        if JY.Thing[thing[id]]['装备系别'] > 0 and JY.Thing[thing[id]]['练出武功'] == -1 then
                            zbxb = "武器类别：" .. wqlx[JY.Thing[thing[id]]['装备系别']] .. '兵器'
                        elseif JY.Thing[thing[id]]['装备位置'] ~= nil and JY.Thing[thing[id]]['装备位置'] > 0 then
                            zbxb = "装备类别：" .. zbxb1[JY.Thing[thing[id]]['装备位置']]
                        end
                        local kfname = ""
                        local kfh = 1
                        if myThing["练出武功"] > 0 then
                            kfname = "武功：" .. JY.Wugong[myThing["练出武功"]]["名称"]
                            kfh = 2
							nswz = {'低价', '中阶', '高阶','绝学'}
							neshu = "品阶：" .. nswz[JY.Wugong[myThing["练出武功"]]['层级']]
							zbxb = ''
							zbxb1 = {'护甲', '坐骑', '护符'}
							wqlx = {'拳法', '指法', '剑法', '刀法', '特殊'}
                        end

                        -- lib.LoadPNG(2, thing[id] * 2,dx+CC.ScreenW/1.371, dy-CC.ScreenH/76.8, 1)
                        if myThing["练出武功"] > 0 then
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

                        if myThing["练出武功"] > 0 then
                            if JY.Wugong[myThing["练出武功"]]["武功类型"] < 6 then
                                Thing_info(thing[id], mjx, mjy, mjw, mjh, mjsize)
                            else
                                local txppd = 0
                                local ngtx = 0
                                local ZUIDHS1 = 4
                                local kf1 = myThing["练出武功"]
                                for x = 1, 10 do
                                    if JY.Wugong[kf1]['特效' .. x] > 0 then
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
                                    local wgwl = '气攻：' .. get_skill_power(0, kf1, 10)
                                    local wgqg = '气防：' .. get_skill_power(0, kf1, 10)
                                    -- local wgqf = '气防：'..get_skill_power(0, kf1, 10)
                                    if JY.Wugong[myThing["练出武功"]]["武功类型"] == 7 then
                                        wgwl = '闪避：' .. JY.Wugong[kf1]['加闪避']
                                        wgqg = '命中：' .. JY.Wugong[kf1]['加命中']
                                    end
                                    DrawString(mjx, mjy - smsize / 1.5, '-----------------------', C_GOLD, size);
                                    h = tjm(mjx, mjy + smsize * (hs - WGSTARTH1), wgwl, color, size, 16, size,  WGSTARTH1 - hs, ZUIDHS + 1 - hs + WGSTARTH1)
                                    hs = hs + h
                                    h = tjm(mjx, mjy + smsize * (hs - WGSTARTH1), wgqg, color, size, 16, size,  WGSTARTH1 - hs, ZUIDHS + 1 - hs + WGSTARTH1)
                                    hs = hs + h
                                    for x = 1, 10 do
                                        ngtx = JY.Wugong[kf1]['特效' .. x]
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
                        -- 苍天泰坦：同样是老二
                        if myThing["练出武功"] > 0 then
                            DrawString(mx + CC.MenuBorderPixel, my + CC.MenuBorderPixel + CC.ScreenH / 1.5, kfname,  C_GOLD, myfont)
                            mx = mx + myfont * string.len(kfname) / 2 + 12
                        end

                        if myThing['类型'] > 0 then
                            drawitem('加生命', '生命')
                            drawitem('加生命最大值', '生命最值')
                            drawitem('加中毒解毒', '中毒')
                            drawitem('加体力', '体力')
                            if myThing['改变内力性质'] == 2 then
                                drawitem('内力属性变为调和')
                            end
                            drawitem('加内力', '内力')
                            drawitem('加内力最大值', '内力最值')
                            drawitem('加攻击力', '攻击')
                            drawitem('加轻功', '轻功')
                            drawitem('加防御力', '防御')
                            drawitem('加医疗能力', '医疗')
                            drawitem('加用毒能力', '用毒')
                            drawitem('加解毒能力', '解毒')
                            drawitem('加抗毒能力', '抗毒')
                            drawitem('加拳掌功夫', '拳掌')
                            drawitem('加指法技巧', '指法')
                            drawitem('加御剑能力', '御剑')
                            drawitem('加耍刀技巧', '耍刀')
                            drawitem('加特殊兵器', '特殊')
                            drawitem('加暗器技巧', '暗器')
                            drawitem('加武学常识', '武常')
                            drawitem('加品德', '品德')
                            drawitem('加攻击次数', '左右', { [0] = '否', '是' })
                            drawitem('加攻击带毒', '带毒')

                            if thing[id] == 14 then
                                drawitem('增加人物体质')
                            end

                            if thing[id] == 15 then
                                drawitem('增加人物内力最大值')
                            end
                            if thing[id] == 16 then
                                drawitem('随机增加人物属性')
                            end
                            if thing[id] == 17 then
                                drawitem('增加人物生命最大值100点')
                            end
                            if thing[id] == 18 then
                                drawitem('增加人物生命最大值20点')
                            end
                            if thing[id] == 19 then
                                drawitem('增加人物生命最大内力值30点')
                            end
                            if thing[id] == 20 then
                                drawitem('增加人物生命最大值50点')
                            end
                            if thing[id] == 316 then
                                drawitem('改变人物内力属性')
                            end
                            if thing[id] == 372 then
                                drawitem('领悟中庸之道')
                            end
                            -- 武器装备威力加成
                            for i, v in ipairs(CC.ExtraOffense) do
                                if v[1] == thing[id] then
                                    DrawString(mx + CC.MenuBorderPixel + CC.ScreenW / 68.4, my + CC.MenuBorderPixel + CC.ScreenH / 1.5, "威力强化:" .. JY.Wugong[v[2]]["名称"] .. "+" .. v[3], PinkRed, myfont)
                                end
                            end

                            if mx ~= dx or my ~= y3_2 + 2 then
                                if thing[id] > 343 or thing[id] < 348 then -- 特殊药品不显示
                                    DrawString(dx + CC.MenuBorderPixel + CC.ScreenW / 68.4,  y3_2 + 2 + CC.MenuBorderPixel + CC.ScreenH / 1.5, " 效果:", LimeGreen, myfont)
                                end

                            end
                        end

                        -- 装备类和秘籍类
                        if myThing['类型'] == 1 or myThing['类型'] == 2 then
                            if mx ~= dx then
                                mx = dx + 4 * myfont
                                my = my + myfont + 3
                            end
                            myflag = 1
                            local my2 = my
                            if myThing['仅修炼人物'] > -1 then
                                drawitem('仅限:' .. JY.Person[myThing['仅修炼人物']]['姓名'])
                            end
                            drawitem('需内力性质', '内属', { [0] = '阴', '阳', '不限'  })
                            drawitem('需内力', '内力')
                            drawitem('需攻击力', '攻击')
                            drawitem('需轻功', '轻功')
                            drawitem('需用毒能力', '用毒')
                            drawitem('需医疗能力', '医疗')
                            drawitem('需拳掌功夫', '拳掌')
                            drawitem('需指法技巧', '指法')
                            drawitem('需御剑能力', '御剑')
                            drawitem('需耍刀技巧', '耍刀')
                            drawitem('需特殊兵器', '特殊')
                            drawitem('需暗器技巧', '暗器')
                            if thing[id] == 372 then
                                drawitem('需80>资质>30')
                            end
                            -- 斗转的显示
                            if thing[id] == 118 then
                                local exstr = "五系兵器值之和>=120 "
                                local mylen = myfont * string.len(exstr) / 2 + 12
                                DrawString(mx + CC.MenuBorderPixel + CC.ScreenW / 68.4, my + CC.MenuBorderPixel + CC.ScreenH / 1.5, exstr, C_GOLD, myfont)
                                mx = mx + mylen
                            end
                            -- 阴阳的显示
                            if thing[id] == 176 then
                                local exstr = "御剑/耍刀/特殊任一项>=70 "
                                local mylen = myfont * string.len(exstr) / 2 + 12
                                DrawString(mx + CC.MenuBorderPixel + CC.ScreenW / 68.4, my + CC.MenuBorderPixel + CC.ScreenH / 1.5, exstr, C_GOLD, myfont)
                                mx = mx + mylen
                            end
                            -- 金丝手套的显示
                            if thing[id] == 239 then
                                local exstr = "拳掌或指法>=70 "
                                local mylen = myfont * string.len(exstr) / 2 + 12
                                DrawString(mx + CC.MenuBorderPixel + CC.ScreenW / 68.4, my + CC.MenuBorderPixel + CC.ScreenH / 1.5, exstr, C_GOLD, myfont)
                                mx = mx + mylen
                            end
                            -- 七宝指环的显示
                            if thing[id] == 200 then
                                local exstr = "拳掌或指法>=200 "
                                local mylen = myfont * string.len(exstr) / 2 + 12
                                DrawString(mx + CC.MenuBorderPixel + CC.ScreenW / 68.4, my + CC.MenuBorderPixel + CC.ScreenH / 1.5, exstr, C_GOLD, myfont)
                                mx = mx + mylen
                            end
                            local wugong = JY.Thing[thing[id]]["练出武功"]
                            if wugong >= 0 then
                                JY.Thing[thing[id]]["需经验"] = JY.Wugong[wugong]["层级"] * 100
                            end
                            drawitem('需资质', '资质')
                            drawitem('需经验', '修炼经验')
                            if mx ~= dx or my ~= my2 then
                                DrawString(dx + CC.MenuBorderPixel + CC.ScreenW / 68.4, my2 + CC.MenuBorderPixel + CC.ScreenH / 1.5, ' 需求:', LimeGreen, myfont)
                            end
                        end
                        -- 特效说明
                        if WPTX2[thing[id]] ~= nil then
                            if mx ~= dx then
                                mx = dx + 4 * myfont
                                my = my + myfont + 3
                            end
                            local my2 = my
                            if mx ~= dx or my ~= my2 then
                                DrawString(dx + CC.MenuBorderPixel + CC.ScreenW / 68.4, my2 + CC.MenuBorderPixel + CC.ScreenH / 1.5, ' 效果:', C_RED, myfont)
                            end

                            DrawString(dx + CC.MenuBorderPixel + myfont * 3 + CC.ScreenW / 68.4, my2 + CC.MenuBorderPixel + CC.ScreenH / 1.5, WPTX2[thing[id]], M_DeepSkyBlue, myfont)
                        end
                        -- 特效说明
                        if myThing['是否特效'] == 1 and
                            (WPTX[thing[id]][myThing['装备等级']] ~= nil or myThing['装备位置'] == -1) then
                            if mx ~= dx then
                                mx = dx + 4 * myfont
                                my = my + myfont + 3
                            end
                            local my2 = my
                            if mx ~= dx or my ~= my2 then
                                DrawString(dx + CC.MenuBorderPixel + CC.ScreenW / 68.4, my2 + CC.MenuBorderPixel + CC.ScreenH / 1.5, ' 特效:', C_RED, myfont)
                            end
                            if myThing['装备位置'] > -1 then
                                local TXstr = WPTX[thing[id]][myThing['装备等级']]
                                -- 复活戒指的耐久度
                                if thing[id] == 303 then
                                    TXstr = TXstr .. "（剩余" .. JY.Person[651]["品德"] .. "次）"
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
                    local lcwg = myThing["练出武功"]
                    local lcwg = 0
                    lib.LoadPNG(91, 70 * 2, boxx, boxy, 1)
                    if myThing["练出武功"] > 0 then
                        lib.LoadPNG(91, 545 * 2, boxx, boxy, 1)
                        lib.PicLoadCache(92, 45 * 2, boxx + CC.ScreenW / 200, boxy + CC.ScreenH / 50, 1, 100, nil, 80)
                        lib.PicLoadCache(92, (44 - JY.Wugong[myThing["练出武功"]]['层级']) * 2, boxx + CC.ScreenW / 500, boxy + CC.ScreenH / 500, 1, 100, nil, 30)
                        lib.PicLoadCache(92, (46 + JY.Wugong[myThing["练出武功"]]['武功类型']) * 2, boxx + CC.ScreenW / 50, boxy + CC.ScreenH / 20, 1, 100, nil, 30)
                        lib.PicLoadCache(92, 44 * 2, boxx + CC.ScreenW / 22, boxy + CC.ScreenW / 80, 1, 100, nil, 40)
                        local wgname = JY.Thing[thing[id]]["名称"]
                        local name1 = string.sub(wgname, 1, 2)
                        local name2 = string.sub(wgname, 3, 4)
                        local wzcl = C_WHITE
                        if JY.Thing[thing[id]]["需内力性质"] == 0 then
                            wzcl = M_DeepSkyBlue
                        end
                        if JY.Thing[thing[id]]["需内力性质"] == 1 then
                            wzcl = C_RED
                        end
                        if JY.Thing[thing[id]]["需内力性质"] == 2 then
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
                -- 无酒不欢：修改选择框
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

        DrawString(dx + CC.ScreenW / 1.9, y3_2 + 2 + CC.MenuBorderPixel + CC.ScreenH / 1.5, "残章: " .. CC.MJCZ,  C_GOLD, CC.Fontsmall * 0.8)
        DrawString(dx + CC.ScreenW / 1.9, y3_2 + 2 + CC.MenuBorderPixel + CC.FontSmall * 1.2 + CC.ScreenH / 1.5,  "银两: " .. CC.Gold, C_GOLD, CC.Fontsmall * 0.8)
        -- DrawString(bx*930,by*654+CC.FontSmall*2, "按F1查看详细说明", C_CYGOLD,CC.Fontsmall*0.8)
        if IsViewingKungfuScrolls > 0 then
            local list = {"1:全部", "2:拳法", "3:指法", "4:剑法", "5:刀法", "6:奇门", "7:内功",
                          "8:轻功", "9:杂学"}
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
            -- 增加物品的内置说明
        elseif keypress == VK_F1 and cur_thing ~= -1 then
            -- detailed_info(cur_thing)
            -- 数字1 全部
        elseif IsViewingKungfuScrolls > 0 and keypress == 49 then
            thing = original_thing
            thingnum = original_thingnum
            cur_line = 0
            cur_x = 0
            cur_y = 0
            cur_thing = -1
            IsViewingKungfuScrolls = 1
            -- 数字2 拳法
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
                local TSkill = JY.Thing[original_thing[i]]["练出武功"]
                if TSkill > -1 and JY.Wugong[TSkill]["武功类型"] == 1 then
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
            -- 数字3 指法
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
                local TSkill = JY.Thing[original_thing[i]]["练出武功"]
                if TSkill > -1 and JY.Wugong[TSkill]["武功类型"] == 2 then
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
            -- 数字4 剑法
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
                local TSkill = JY.Thing[original_thing[i]]["练出武功"]
                if TSkill > -1 and JY.Wugong[TSkill]["武功类型"] == 3 then
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
            -- 数字5 刀法
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
                local TSkill = JY.Thing[original_thing[i]]["练出武功"]
                if TSkill > -1 and JY.Wugong[TSkill]["武功类型"] == 4 then
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
            -- 数字6 奇门
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
                local TSkill = JY.Thing[original_thing[i]]["练出武功"]
                if TSkill > -1 and JY.Wugong[TSkill]["武功类型"] == 5 then
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
            -- 数字7 内功
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
                local TSkill = JY.Thing[original_thing[i]]["练出武功"]
                if TSkill > -1 and JY.Wugong[TSkill]["武功类型"] == 6 then
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
            -- 数字7 内轻
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
                local TSkill = JY.Thing[original_thing[i]]["练出武功"]
                if TSkill > -1 and JY.Wugong[TSkill]["武功类型"] == 7 then
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
            -- 数字9 杂学
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
                local TSkill = JY.Thing[original_thing[i]]["练出武功"]
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
    -- 无酒不欢：秘笈显示区分
    if IsViewingKungfuScrolls > 0 then
        IsViewingKungfuScrolls = 0
    end
    return cur_thing;
end

-- 物品整理
function Menu_WPZL()
    local function swap(a, b)
        JY.Base["物品" .. a], JY.Base["物品" .. b] = JY.Base["物品" .. b], JY.Base["物品" .. a]
        JY.Base["物品数量" .. a], JY.Base["物品数量" .. b] = JY.Base["物品数量" .. b],
            JY.Base["物品数量" .. a]
    end

    local flag = 0;
    for i = 1, CC.MyThingNum do
        flag = 0;
        for j = 1, CC.MyThingNum - i + 1 do
            -- lib.Debug('JY.Base["物品"..j]'..JY.Base["物品"..j])
            -- lib.Debug('JY.Base["物品" .. j+1]'..JY.Base["物品" .. j+1])
            if JY.Base["物品" .. j] >= 0 and JY.Base["物品" .. j + 1] >= 0 then -- 如果两个物品有效
                local wg1 = JY.Thing[JY.Base["物品" .. j]]["练出武功"];
                local wg2 = JY.Thing[JY.Base["物品" .. j + 1]]["练出武功"];
                if wg2 < 0 then -- 不可练出武功的根据编号排序
                    if wg1 > 0 or (wg1 < 0 and JY.Base["物品" .. j] > JY.Base["物品" .. j + 1]) then
                        swap(j, j + 1);
                        flag = 1;
                    end
                elseif wg1 > 0 then -- 可练出武功的根据类型排序，如果类型相同，再根据武功10级威力排序                         
                    if JY.Wugong[wg1]["武功类型"] > JY.Wugong[wg2]["武功类型"] or
                        (JY.Wugong[wg1]["武功类型"] == JY.Wugong[wg2]["武功类型"] and JY.Wugong[wg1]["层级"] >
                            JY.Wugong[wg2]["层级"]) then
                        swap(j, j + 1);
                        flag = 1;
                    end
                end
            end
        end
        if flag == 0 then -- 如果一轮下来没有任何的交换，肯定就是已经排好序了，直接退出
            break
        end
    end
    Cls()
    -- DrawStrBoxWaitKey("行囊整理完毕", C_WHITE, CC.DefaultFont)
end

-- 大商家卖物品菜单
function MenuDSJ()
    local menu = {'神兵宝甲', '武功秘笈', '灵丹妙药', '伤人暗器'}
    local r = LGMsgBox("选择", " 你要卖出什么物品？", menu, #menu, 223)
    if r > 0 then
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
                if JY.Thing[id]["类型"] == r then
                    thing[num] = id
                    thingnum[num] = JY.Base["物品数量" .. i + 1]
                    num = num + 1
                end
                --[[
                if r == 1 then
                    thing[i] = id
                    thingnum[i] = JY.Base["物品数量" .. i + 1]
                else
                    if JY.Thing[id]["类型"] == r - 2 then
                        thing[num] = id
                        thingnum[num] = JY.Base["物品数量" .. i + 1]
                        num = num + 1
                    end
                end
                ]]
            end
        end
        -- 无酒不欢：秘笈显示区分

        local r = SelectThing(thing, thingnum)
        if r >= 0 then
            return r
        end
    end
    return -1
end


-- 铁匠强化物品菜单
function MenuTJQH()
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
    local r = SelectThing(thing, thingnum)
    if r >= 0 then
        return r
    end
    return -1
end

-- 回营整备
function Menu_HYZB()
    if JY.SubScene ~= 25 then
        JY.SubScene = 70
        JY.Base["人X1"] = 8
        JY.Base["人Y1"] = 28
        JY.Base["人X"] = 358
        JY.Base["人Y"] = 235
    end
end

-- 无酒不欢：新版X菜单
function Menu_Exit() -- 离开菜单
    lib.Debug('错误：未知函数')
    local surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)

    lib.SetClip(0, 0, 0, 0)
    local bx = CC.WX
    local by = CC.HY
    local tb = 1
    local size = CC.DefaultFont
    local zb = {{468, 327}, {468, 387}, {468, 447}}
    local m = {"继续游戏", "返回初始", "离开游戏"}

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
            -- 鼠标x坐标中间位置左右两边的距离
            local x_jl = bx * 47
            -- 鼠标y坐标中间位置左右两边的距离
            local y_jl = by * 12
            local xs;
            local ys;
            local sb1;
            -- xh
            for i = 1, #zb do
                -- 鼠标x坐标中间位置
                xs = bx * 212 + bx * zb[i][1]
                -- 鼠标y坐标中间位置
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

-- 离开菜单
function Menu_Exit2()
    Cls();
    if DrawStrBoxYesNo(-1, -1, "是否真的要离开游戏(Y/N)?", C_WHITE, CC.DefaultFont) == true then
        JY.Status = GAME_END;
        return 1;
    end
end

-- 保存进度
function Menu_SaveRecord()
    Cls();
    CC.Save = 1
    local bx, by = CC.WX, CC.HY
    lib.LoadPNG(91, 131 * 2, -1, -1, 1)
    DrawStrBox(-1, CC.ScreenH * 1 / 6 - 20, "保存进度", LimeGreen, CC.Fontbig, C_GOLD);
    DrawStrBox(bx * 281, by * CC.ScreenH * 1 / 6 + 26,
        string.format("%-6s %-4s %-10s %-4s %-4s %-4s %-10s", "存档名", "主角", "姓名", "难度", "资质", "天书", "位置"), C_ORANGE, CC.DefaultFont, C_GOLD);
    local r = SaveList();
    if r > 0 then
        DrawString(CC.ScreenW/2, CC.ScreenH/2, "请稍候......", C_WHITE, CC.DefaultFont, CC.FONT2)
        ShowScreen();
        SaveRecord(r);
        Cls();
    end
    return 0;
end

-- 读取进度
function Menu_ReadRecord()
    CC.Save = 0
    Cls();
    local bx, by = CC.WX, CC.HY
    lib.LoadPNG(91, 131 * 2, -1, -1, 1)
    DrawStrBox(-1, CC.ScreenH * 1 / 6 - 20, "读取进度", LimeGreen, CC.Fontbig, C_GOLD);
    DrawStrBox(bx * 281, by * CC.ScreenH * 1 / 6 + 26,  string.format("%-6s %-4s %-10s %-4s %-4s %-4s %-10s", "存档名", "主角", "姓名", "难度", "资质", "天书", "位置"), C_ORANGE, CC.DefaultFont, C_GOLD);
    local r = SaveList();
    if r < 1 then
        return 0;
    end

    Cls();
    DrawString(CC.MainSubMenuX2, CC.MainSubMenuY, "请稍候......", C_WHITE, CC.DefaultFont, CC.FONT2)
    ShowScreen();
    local result = LoadRecord(r);
    if result ~= nil then
        return 0;
    end
    -- 子场景
    if JY.Base["无用"] ~= -1 then
        if JY.SubScene < 0 then
            CleanMemory()
            -- lib.UnloadMMap()
        end
        -- lib.PicInit()
        lib.ShowSlow(20, 1)
        JY.Status = GAME_SMAP
        JY.SubScene = JY.Base["无用"]
        JY.MmapMusic = -1
        JY.MyPic = GetMyPic()
        Init_SMap(1)
        -- 大地图
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

-- 状态子菜单
function Menu_Status()
    -- 无酒不欢：各状态下对应X轴

    local xcor = CC.MainSubMenuX + 2 * CC.MenuBorderPixel + 4 * CC.DefaultFont + 5
    if JY.Status == GAME_WMAP then
        xcor = CC.MainSubMenuX + 15
    end
    DrawStrBox(xcor, CC.MainSubMenuY, "要查阅谁的状态", LimeGreen, CC.DefaultFont, C_GOLD);
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

-- 离队菜单
function Menu_PersonExit()
    DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "要求谁离队", C_WHITE, CC.DefaultFont)
    local nexty = CC.MainSubMenuY + CC.SingleLineHeight
    local r = SelectTeamMenu(CC.MainSubMenuX, nexty)
    if r == 1 then
        DrawStrBoxWaitKey("抱歉！没有你游戏进行不下去", C_GOLD, CC.DefaultFont, nil, LimeGreen)
    else
        if JY.SubScene == 82 then
            do
                return
            end
        end
    end
    if r > 0 and JY.SubScene == 55 and JY.Base["队伍" .. r] == 35 then
        do
            return
        end
    end
    if r > 1 then
        local personid = JY.Base["队伍" .. r]
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
            if JY.Base['队伍' .. ii] >= 0 then
                liebiao[ii] = {JY.Person[JY.Base['队伍' .. ii]]['姓名'], JY.Base['队伍' .. ii]}
            end
        end
        if lieshu > #liebiao then
            lieshu = #liebiao
        end
        for ai = 1, lieshu do
            local tw = 0
            if CC.Png[JY.Person[liebiao[ai + pg][2]]['半身像']] ~= nil then
                tw = CC.Png[JY.Person[liebiao[ai + pg][2]]['半身像']]
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
            local headid = JY.Person[liebiao[ai + pg][2]]["半身像"]
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

-- 队伍选择人物菜单
function SelectTeamMenu(x, y)

    local menu = {};
    for i = 1, CC.TeamNum do
        menu[i] = {"", nil, 0};
        local id = JY.Base["队伍" .. i]
        if id >= 0 then
            if JY.Person[id]["生命"] > 0 then
                menu[i][1] = JY.Person[id]["姓名"];
                menu[i][3] = 1;
            end
        end
    end
    return ShowMenu(menu, CC.TeamNum, 0, x, y, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE);
end

-- 门派队伍选择人物菜单
function TeamMenu_Mp(x, y, mp)
    local menu = {};
    for i = 1, CC.TeamNum do
        menu[i] = {"", nil, 0};
        local id = JY.Base["队伍" .. i]
        if id >= 0 then
            if JY.Person[id]['门派'] == mp then
                if mp == 1 and id ~= 0 then
                    CC.TX['达摩院'] = 1
                    CC.TX['般若堂'] = 1
                end
                menu[i][1] = JY.Person[id]["姓名"];
                menu[i][3] = 1;
            end
        end
    end
    return ShowMenu(menu, CC.TeamNum, 0, x, y, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE);
end

-- 计算当前队友个数
function GetTeamNum()
    local r = CC.TeamNum;
    for i = 1, CC.TeamNum do
        if JY.Base["队伍" .. i] < 0 then
            r = i - 1;
            break
        end
    end
    return r;
end

-- 太极猫函数12，画斜线
function tjm12(x, y, x1, y1, color)
    if color == nil then
        color = M_Wheat
    end
    local xy = x - x1
    local yx = y - y1
    local ab = math.sqrt(xy ^ 2 + yx ^ 2) -- 开根
    local xy1 = xy / ab
    local yx1 = yx / ab
    for i = 1, math.ceil(ab) do
        lib.DrawRect(x - xy1 * i, y - yx1 * i, x - xy1 * i, y - yx1 * i, color)
    end
end

-- 可攻击内功
function Neigong_attack()
    for j = 0, WAR.PersonNum - 1 do
        local id = WAR.Person[j]["人物编号"]
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

-- 门派职务
function MP_zw(id)
    local n = nil
    local mmp = JY.Person[id]["门派"]
    local m = JY.Person[id]["畅想分阶"] + 1
    -- 掌门信物
    local zmxw = {205, 85, 236, 200, 93, 74, 335, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
    if inteam(id) == false then
        local mpcw = {"掌门", "长老", "护法", "堂主", "执事", "精英", "弟子"}

        if JY.Person[id]["门派贡献"] == 5 then
            m = 1
        end
        if mmp == 2 then
            mpcw[1] = '真人'
        end
        if mmp == 4 or mmp == 5 or mmp == 15 then
            mpcw[1] = "教主"
        end
        if mmp == 8 then
            mpcw[1] = "帮主"
        end
        if mmp == 6 then
            mpcw[1] = "宫主"
        end
        if mmp == 22 then
            mpcw[1] = "岛主"
        end
        if mmp == 23 or mmp == 30 then
            mpcw[1] = "庄主"
        end
        if mmp == 24 then
            mpcw[1] = "门主"
        end
        if mmp == 26 then
            mpcw[1] = "宗主"
        end
        if mmp > 0 then
            n = mpcw[m]
        else
            n = "散人"
        end
    else
        local mpcw = {"弟子", "精英", "执事", "堂主", "护法", "长老", "掌门"}
        local zwnum = math.modf(JY.Person[id]['门派贡献'] / 199)
        if JY.Person[id]['门派贡献'] < 1 then
            zwnum = 0
        end
        if zwnum > 5 then
            zwnum = 5
        end
        if zwnum >= 5 then
            if JY.Person[id]['门派贡献'] >= 1500 then
                if zmxw[mmp + 1] > 0 then
                    if instruct_18(zmxw[mmp + 1]) then
                        JY.Person[id]['掌门'] = mmp
                    end
                end
            else
            end
        end
        if JY.Person[id]['掌门'] == mmp then
            zwnum = 6
        end
        n = mpcw[zwnum + 1]

        if mmp == 0 then
            n = '散人'
        end
    end
    return n
end

-- 境界
function Person_LV(id)
    local lv = nil
    local jj = {"传说", "宗师", "豪侠", "一流", "二流", "三流"}
    if JY.Person[id]["畅想分阶"] > 6 then
        JY.Person[id]["畅想分阶"] = 6
    end
    local fjstr = jj[JY.Person[id]["畅想分阶"]]
    lv = jj[fjstr]
    return lv
end

-- 秘库
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
            local Color_Switch = {{"Ｒ", PinkRed}, {"Ｇ", M_Wheat}, {"Ｂ", C_BLACK}, {"Ｗ", RGB(178, 158, 124)},
                                  {"Ｏ", C_ORANGE}, {"Ｌ", LimeGreen}, {"Ｄ", M_DeepSkyBlue}, {"Ｚ", Violet}}
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
                    me[#me + 1] = "Ｎ"
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
            if string.sub(tfstr, 1, 2) == "Ｎ" then
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
        local kname = JY.Teji[miji]['名称']
        lib.LoadPNG(91, 281 * 2, CC.ScreenW / 2 + n * p2x, by * 360 + m * p2y, 2)
        lib.LoadPNG(98, (miji) * 2, CC.ScreenW / 2 + n * p2x, by * 360 + m * p2y, 2)
        DrawString(CC.ScreenW / 2 + n * p2x - string.len(kname) / 4 * size * 0.66, by * 395 + m * p2y, kname, C_WHITE,
            size * 0.68)
        lib.LoadPNG(91, 288 * 2, bx * 665 + n * p2x, by * 355 + m * p2y, 2, 0, 130)
        lib.LoadPNG(91, 287 * 2, -1, -1, 1)
        lib.DrawStr(CC.ScreenW / 10 - string.len(JY.Teji[miji]["名称"]) / 4 * size, by * 353, JY.Teji[miji]["名称"],
            M_Gray, size * 2, CONFIG.CurrentPath .. "FONT/2.TTF", 0, 0) -- 武功名称显示			
        lib.DrawStr(CC.ScreenW / 10 - string.len(JY.Teji[miji]["名称"]) / 4 * size, by * 350, JY.Teji[miji]["名称"],
            C_GOLD, size * 2, CONFIG.CurrentPath .. "FONT/2.TTF", 0, 0) -- 武功名称显示		
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

-- 武库
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
    local wz = {"初窥门径", "初窥门径", "略有小成", "略有小成", "渐入佳境", "渐入佳境",
                "融会贯通", "融会贯通", "炉火纯青", "炉火纯青", "登峰造极"}
    local djwz = {"一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "极"}
    local pjwz = {"Ｗ" .. "初阶武功", "Ｌ" .. "中阶武功", "Ｒ" .. "高阶武功", "Ｇ" .. "绝学武功"}
    local xj, yj, zsn = nil, 33, 28
    local FY1, h, h1, SHUOMING, xlsm = 0, 0, 0, 0, 0
    local function wugong_info(thingID)
        -- lib.Debug(thingID);
        local h1 = 0
        local me = {}
        local hs1 = 0
        local myh1 = 7
        local mm = 1
        if JY.Thing[thingID]["练出武功"] > 0 then
            mm = 2
        end
        local function strcolor_switch(s)
            local Color_Switch = {{"Ｒ", PinkRed}, {"Ｇ", M_Wheat}, {"Ｂ", C_BLACK}, {"Ｗ", RGB(178, 158, 124)},
                                  {"Ｏ", C_ORANGE}, {"Ｌ", LimeGreen}, {"Ｄ", M_DeepSkyBlue}, {"Ｚ", Violet}}
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
                    me[#me + 1] = "Ｎ"
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
            if string.sub(tfstr, 1, 2) == "Ｎ" then
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
            local kname = JY.Wugong[k]['名称']
            lib.LoadPNG(91, 281 * 2, bx * 675 + n * bx * 110 + bx * 30, by * 360 + m * bx * 115, 2)
            lib.LoadPNG(98, (500 + k) * 2, bx * 675 + n * bx * 110 + bx * 30, by * 360 + m * bx * 115, 2)
            DrawString(bx * 675 + bx * 30 + n * bx * 110 - string.len(kname) / 4 * size * 0.66, by * 395 + m * bx * 115,
                kname, C_WHITE, size * 0.68)
            -- 武功说明
            for j = 0, JY.ThingNum - 1 do -- 读取物品
                if JY.Thing[j]["练出武功"] >= 0 and JY.Thing[j]["练出武功"] == wugong then
                    thingid = j
                end
            end
            local wgmenu = {}
            local name = JY.Wugong[wugong]["名称"]
            wgmenu = {wugong, name, get_skill_power(id, wugong, 10), 10, 1, thingid} -- 编号，名称，威力，等级,位置,秘籍
            -- say(kid,0,0)                    
            -- 说明
            if WGSHUOMING > 0 then
                local cl = color
                local menu1 = wgmenu
                local kf1 = wugong
                local me = JY.Wugong[kf1]["名称"]
                local wgmp = MPname[JY.Wugong[kf1]["门派"] + 1]
                local level = 10
                local wugongwl = get_skill_power(id, kf1, level)
                local mz = JY.Wugong[kf1]["加命中"]
                local wz2 = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"}
                if kf1 > 0 then
                    cl = C_RED
                    local jg1 = size * 0.9
                    local wgbj = 0
                    if JY.Wugong[kf1]["武功类型"] < 6 then
                        wgbj = 286
                    else
                        wgbj = 287
                    end
                    if WGSHUOMING == 2 then
                        wgbj = 287
                    end
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
                    if JY.Wugong[kf1]["层级"] == 3 then
                        wgcl = C_RED
                    end
                    local wlwz, mzwz = nil, nil
                    local p = JY.Person[0]
                    lib.LoadPNG(91, wgbj * 2, 0 + bx * 30, 0, 1, 0, 100)
                    lib.DrawStr(bx * 363 + bx * 30 - string.len(JY.Wugong[kf1]["名称"]) / 4 * size, by * 353,
                        JY.Wugong[kf1]["名称"], M_Gray, size * 2, CONFIG.CurrentPath .. "FONT/2.TTF", 0, 0) -- 武功名称显示			
                    lib.DrawStr(bx * 361 + bx * 30 - string.len(JY.Wugong[kf1]["名称"]) / 4 * size, by * 350,
                        JY.Wugong[kf1]["名称"], wgcl, size * 2, CONFIG.CurrentPath .. "FONT/2.TTF", 0, 0) -- 武功名称显示		
                    DrawString(wgzbx + bx * 30 - size * 1.5, wgzby - size * 1, wz2[menu1[5]], color, size * 0.9) -- 武功编号	
                    tjm(wgzbx + bx * 30, wgzby, "品阶" .. ":" .. pjwz[JY.Wugong[kf1]["层级"]], color, size * 0.73,11, size * 0.8) -- 品阶
                    local wglx = {'● 拳', '● 指', '● 剑', '● 刀', '● 奇', '● 内', '● 轻'}
                    DrawString(wgzbx + bx * 30, wgzby + jg1,
                        "门派" .. ":  " .. wgmp .. ' ' .. wglx[JY.Wugong[kf1]['武功类型']], color, size * 0.73) -- 门派
                    DrawString(wgzbx + bx * 30, wgzby + jg1 * 2,
                        "修为" .. ":  " .. wz[level] .. " " .. "(" .. djwz[level] .. ")", color, size * 0.73) -- 修为
                    local gdz = JY.Wugong[kf1]["层级"] * level
                    local sm = math.modf(JY.Wugong[p["主运内功"]]["层级"] * 100 + p["体质"] * (wugongwl / 8))

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
                    if JY.Wugong[kf1]["武功类型"] < 6 then
                        wlwz = "威力" .. " " .. math.modf(wugongwl)
                        mzwz = "   命中" .. " " .. mz .. " " .. "      格档" .. " " .. gdz
                    elseif JY.Wugong[kf1]["武功类型"] == 6 then
                        wlwz = "生命 " .. sm .. "   气防 " .. math.modf(wugongwl)
                        mzwz = "           格档 " .. gdz .. " " .. "     回气 " .. hq
                    else
                        wlwz = "命中 " .. JY.Wugong[kf1]["加命中"] .. "    闪避 " .. JY.Wugong[kf1]["加闪避"]
                        mzwz = "           移动 " .. " " .. " " .. "      集气 " .. ""
                    end
                    DrawString(wgzbx + bx * 30, wgzby + jg1 * 3.1 + by * 2, wlwz, C_WHITE, size * 0.73) -- 威力
                    DrawString(wgzbx + bx * 30 + size * 5, wgzby + jg1 * 3.1 + by * 2, mzwz, C_WHITE, size * 0.73) -- 命中											
                    -- 武功招式
                    if WGSHUOMING == 1 then
                        if JY.Wugong[kf1]["武功类型"] < 6 then
                            for j = 1, #CC.KFMove[menu1[1]] do
                                local leixing = {91, 92, 93, 94, 95, 96}
                                local lxpic = leixing[JY.Wugong[kf1]["武功类型"]]
                                local zsnum = CC.WUGONGZS[menu1[5]][j]
                                lib.LoadPNG(98, (500 + kf1) * 2, bx * zszb[j][1] + bx * 30, by * zszb[j][2] + by * 88,
                                    2, 0, 90)
                                local zssm = {}
                                local CAOZSM = {}
                                zsn = #CC.KFMove[kf1]
                                local function Atk(id)
                                    local gj = 0
                                    gj = gj + JY.Person[id]['攻击力']
                                    -- lib.Debug('人物攻击力'..gj)	
                                    local nlgj =
                                        limitX((JY.Person[id]['内力'] - JY.Person[id]['资质'] * 10) / 60, 0)
                                    -- lib.Debug('内力加成攻击力'..nlgj)	
                                    gj = gj + nlgj
                                    gj = gj + FJGONGJ(id)
                                    -- lib.Debug('装备加成攻击力'..FJGONGJ(id))	
                                    return gj
                                end
                                local atk = Atk(id)
                                local zzz = tb4
                                if zzz > 6 then
                                    zzz = 6
                                end
                                local nnn = wugongwl * (1 + (zzz - 1) / 10)
                                local sz = math.ceil(atk * (1 + nnn / 2000))
                                local sznum = {"一", "二", "三", "四", "五", "六", "七", "八", "九", "十"}
                                local wz1 = "造成基础伤害" .. 'Ｇ' .. sz .. "Ｈ" .. "点。"
                                local zsname = CC.KFMove[kf1][j][1]
                                local zswz = nil
                                local zswz1 = nil
                                if tb4 == j then
                                    lib.LoadPNG(91, 88 * 2, bx * zszb[j][1] - bx * 2 + bx * 30,
                                        zszb[j][2] - by * 2 + by * 88, 2, 0, 95)
                                    tjm(wgzbx - size + bx * 30, wgzby + size * 7, "Ｇ" .. JY.Wugong[kf1]["名称"] ..
                                        "Ｈ第Ｄ" .. sznum[tb4] .. "Ｈ招:Ｄ" .. zsname, C_CYGOLD, size * 0.73, 30,
                                        size * 0.73)
                                    tjm(wgzbx + size * 8 + bx * 30, wgzby + size * 7,
                                        "Ｈ    耗气 Ｄ" .. CC.KFMove[kf1][j][3], C_CYGOLD, size * 0.73, 30,
                                        size * 0.73)
                                    local hs = 0
                                    local ZUIDHS = 4
                                    if JY.Wugong[kf1]["武功类型"] == 1 then
                                        zswz1 = "造成目标内伤Ｇ" .. (JY.Wugong[kf1]["层级"] * 5) .. "Ｈ点。"
                                    elseif JY.Wugong[kf1]["武功类型"] == 2 then
                                        zswz1 = "对目标封穴Ｇ" .. JY.Wugong[kf1]["层级"] .. "~" ..
                                                    (JY.Wugong[kf1]["层级"] * 2 + 2) .. "Ｈ点。"
                                    elseif JY.Wugong[kf1]["武功类型"] == 3 then
                                        zswz1 = "造成目标流血Ｇ" .. (JY.Wugong[kf1]["层级"] * 10) ..
                                                    "Ｈ点。"
                                    elseif JY.Wugong[kf1]["武功类型"] == 4 then
                                        zswz1 = "造成目标外伤Ｇ" .. (JY.Wugong[kf1]["层级"] * 10) ..
                                                    "Ｈ点。"
                                    elseif JY.Wugong[kf1]["武功类型"] == 5 then
                                        zswz1 = "造成目标内伤Ｇ" .. (JY.Wugong[kf1]["层级"] * 5) ..
                                                    "Ｈ点/对目标封穴Ｇ" .. JY.Wugong[kf1]["层级"] .. "~" ..
                                                    (JY.Wugong[kf1]["层级"] * 2 + 2) .. "Ｈ点/造成目标流血Ｇ" ..
                                                    (JY.Wugong[kf1]["层级"] * 10) .. "Ｈ点/造成目标灼烧Ｇ" ..
                                                    (JY.Wugong[kf1]["层级"] * 10) .. "Ｈ点。"
                                    end
                                    if JY.Wugong[kf1]["冰封系数"] == 1 then
                                        zswz1 = zswz1 .. "概率冰封。"
                                    end
                                    if JY.Wugong[kf1]["灼烧系数"] == 1 then
                                        zswz1 = zswz1 .. "概率灼烧。"
                                    end
                                    if JY.Wugong[kf1]["敌人中毒点数"] > 0 then
                                        zswz1 = zswz1 .. "对目标造成中毒Ｇ" ..
                                                    JY.Wugong[kf1]["敌人中毒点数"] .. "Ｈ。"
                                    end
                                    if JY.Wugong[kf1]["招式" .. tb4] > 0 then
                                        -- 1流血
                                        if JY.Wugong[kf1]["招式" .. tb4] > 10 and JY.Wugong[kf1]["招式" .. tb4] < 15 then
                                            zswz1 = zswz1 .. "额外造成目标流血Ｇ" ..
                                                        (JY.Wugong[kf1]["层级"] * 10) .. "Ｈ点。"
                                            -- 2封穴
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 20 and JY.Wugong[kf1]["招式" .. tb4] <
                                            25 then
                                            zswz1 =
                                                zswz1 .. "额外造成目标封穴Ｇ" .. JY.Wugong[kf1]["层级"] ..
                                                    "~" .. (JY.Wugong[kf1]["层级"] * 2 + 1) .. "Ｈ点。"
                                            -- 3灼烧	
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 30 and JY.Wugong[kf1]["招式" .. tb4] <
                                            35 then
                                            zswz1 =
                                                zswz1 .. "造成目标灼烧Ｇ" .. (JY.Wugong[kf1]["层级"] * 5) ..
                                                    "Ｈ点。"
                                            -- 4冰封		
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 40 and JY.Wugong[kf1]["招式" .. tb4] <
                                            45 then
                                            zswz1 =
                                                zswz1 .. "造成目标冰封Ｇ" .. (JY.Wugong[kf1]["层级"] * 10) ..
                                                    "Ｈ点。"
                                            -- 5内伤		
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 50 and JY.Wugong[kf1]["招式" .. tb4] <
                                            55 then
                                            zswz1 =
                                                zswz1 .. "造成目标内伤Ｇ" .. (JY.Wugong[kf1]["层级"] * 10) ..
                                                    "Ｈ点。"
                                            -- 6中毒	
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 60 and JY.Wugong[kf1]["招式" .. tb4] <
                                            65 then
                                            zswz1 =
                                                zswz1 .. "造成目标中毒Ｇ" .. (JY.Wugong[kf1]["层级"] * 10) ..
                                                    "Ｈ点。"
                                            -- 7冻结
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 70 and JY.Wugong[kf1]["招式" .. tb4] <
                                            75 then
                                            zswz1 =
                                                zswz1 .. "造成目标冻结Ｇ" .. (JY.Wugong[kf1]["层级"] * 5) ..
                                                    "Ｈ时序。"
                                            -- 8点燃
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 80 and JY.Wugong[kf1]["招式" .. tb4] <
                                            85 then
                                            zswz1 = zswz1 .. "造成目标点燃Ｇ" ..
                                                        (JY.Wugong[kf1]["层级"] * 2 + 3) .. "Ｈ时序。"
                                            -- 9巨毒
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 90 and JY.Wugong[kf1]["招式" .. tb4] <
                                            95 then
                                            zswz1 = zswz1 .. "造成目标巨毒Ｇ" .. JY.Wugong[kf1]["层级"] ..
                                                        "Ｈ回合,毒性发作效果双倍。"
                                            -- 10眩晕
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 100 and JY.Wugong[kf1]["招式" .. tb4] <
                                            105 then
                                            local jl = JY.Wugong[kf1]["层级"] * 5
                                            zswz1 = zswz1 .. "Ｇ" .. jl .. "%Ｈ造成目标眩晕1回合。"
                                            -- 11撕裂		
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 110 and JY.Wugong[kf1]["招式" .. tb4] <
                                            115 then
                                            local jl = JY.Wugong[kf1]["招式" .. tb4] * 10
                                            zswz1 = zswz1 .. "Ｇ" .. jl .. "%Ｈ造成目标撕裂10时序。"
                                            -- 12虚弱									
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 120 and JY.Wugong[kf1]["招式" .. tb4] <
                                            125 then
                                            zswz1 = zswz1 .. "造成目标虚弱1回合，减少伤害和气攻Ｇ" ..
                                                        (JY.Wugong[kf1]["层级"] * 10 + 10) .. "%Ｈ。"
                                            -- 13破防								
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 130 and JY.Wugong[kf1]["招式" .. tb4] <
                                            135 then
                                            zswz1 =
                                                zswz1 .. "减少目标防御Ｇ" .. (JY.Wugong[kf1]["层级"] * 10) ..
                                                    "%Ｈ。"
                                            -- 14无视系数								
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 140 and JY.Wugong[kf1]["招式" .. tb4] <
                                            145 then
                                            local xswz = {"拳法系数", "指法系数", "御剑系数",
                                                          "耍刀系数", "奇门系数"}
                                            zswz1 =
                                                zswz1 .. "减少目标Ｇ" .. xswz[JY.Wugong[kf1]["武功类型"]] ..
                                                    (JY.Wugong[kf1]["层级"] * 10) .. "%Ｈ。"
                                            -- 15固定伤害								
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 150 and JY.Wugong[kf1]["招式" .. tb4] <
                                            155 then
                                            zswz1 =
                                                zswz1 .. "附加额外伤害Ｇ" .. (JY.Wugong[kf1]["层级"] * 50) ..
                                                    "Ｈ点。"
                                            -- 16吸血
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 160 and JY.Wugong[kf1]["招式" .. tb4] <
                                            165 then
                                            zswz1 = zswz1 .. "附加伤害20%吸血上限Ｇ" ..
                                                        (JY.Wugong[kf1]["层级"] * 50) .. "Ｈ点。"
                                            -- 17减防
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 170 and JY.Wugong[kf1]["招式" .. tb4] <
                                            175 then
                                            zswz1 = zswz1 .. "三回合内减少目标防御Ｇ" ..
                                                        (JY.Wugong[kf1]["层级"] * 5) .. "%Ｈ。"
                                            -- 18减攻
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 180 and JY.Wugong[kf1]["招式" .. tb4] <
                                            185 then
                                            zswz1 = zswz1 .. "三回合内减少目标攻击Ｇ" ..
                                                        (JY.Wugong[kf1]["层级"] * 5) .. "%Ｈ。"
                                            -- 19破气防
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 190 and JY.Wugong[kf1]["招式" .. tb4] <
                                            195 then
                                            zswz1 = zswz1 .. "Ｇ" .. (JY.Wugong[kf1]["层级"] * 10) ..
                                                        "%Ｈ概率无视气防。"
                                            -- 20增加范围
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 200 and JY.Wugong[kf1]["招式" .. tb4] <
                                            205 then
                                            zswz1 = zswz1 .. "Ｇ" .. (JY.Wugong[kf1]["层级"] * 10) ..
                                                        "%Ｈ造成大范围伤害。"
                                            -- 21再次行动
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 210 and JY.Wugong[kf1]["招式" .. tb4] <
                                            215 then
                                            zswz1 = zswz1 .. "Ｇ" .. (JY.Wugong[kf1]["层级"] * 4) ..
                                                        "%Ｈ概率再次行动。"
                                            -- 22加速
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 220 and JY.Wugong[kf1]["招式" .. tb4] <
                                            225 then
                                            zswz1 = zswz1 .. "下回合集气加速Ｇ" ..
                                                        (JY.Wugong[kf1]["层级"] * 10) .. "%Ｈ。"
                                            -- 23加连击
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 230 and JY.Wugong[kf1]["招式" .. tb4] <
                                            235 then
                                            zswz1 = zswz1 .. "Ｇ" .. (JY.Wugong[kf1]["层级"] * 10) ..
                                                        "%Ｈ概率增加连击1次。"
                                            -- 24加暴击
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 240 and JY.Wugong[kf1]["招式" .. tb4] <
                                            245 then
                                            zswz1 = zswz1 .. "Ｇ" .. (JY.Wugong[kf1]["层级"] * 20 + 20) ..
                                                        "%Ｈ暴击。"
                                            -- 25加暴伤
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 250 and JY.Wugong[kf1]["招式" .. tb4] <
                                            255 then
                                            zswz1 =
                                                zswz1 .. "增加暴击伤害Ｇ" .. (JY.Wugong[kf1]["层级"] * 10) ..
                                                    "%Ｈ。"
                                            -- 26必中
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 260 and JY.Wugong[kf1]["招式" .. tb4] <
                                            265 then
                                            zswz1 = zswz1 .. "Ｇ" .. (JY.Wugong[kf1]["层级"] * 20 + 20) ..
                                                        "%Ｈ概率必中。"
                                            -- 27防御
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 270 and JY.Wugong[kf1]["招式" .. tb4] <
                                            275 then
                                            zswz1 = zswz1 .. "Ｇ" .. (JY.Wugong[kf1]["层级"] * 20 + 20) ..
                                                        "%Ｈ下回合防御。"
                                            -- 28回气
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 280 and JY.Wugong[kf1]["招式" .. tb4] <
                                            285 then
                                            if JY.Wugong[kf1]["层级"] == 1 then
                                                zswz1 = zswz1 .. "回气Ｇ" .. (JY.Wugong[kf1]["层级"] * 1) ..
                                                            "Ｈ点。"
                                            else
                                                local hq = JY.Wugong[kf1]["层级"] - 1
                                                local hq1 = JY.Wugong[kf1]["层级"]
                                                zswz1 = zswz1 .. "回气Ｇ" .. hq .. "~" .. hq1 .. "Ｈ点。"
                                            end
                                            -- 29锁足
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 290 and JY.Wugong[kf1]["招式" .. tb4] <
                                            295 then
                                            zswz1 = zswz1 .. "Ｇ" .. (JY.Wugong[kf1]["层级"] * 15) ..
                                                        "%Ｈ锁足1回合。"
                                            -- 30反击
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 300 and JY.Wugong[kf1]["招式" .. tb4] <
                                            305 then
                                            zswz1 = zswz1 .. "Ｇ" .. (JY.Wugong[kf1]["层级"] * 10) .. "%Ｈ反击。"
                                            -- 31加格档
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 310 and JY.Wugong[kf1]["招式" .. tb4] <
                                            315 then
                                            zswz1 = zswz1 .. "增加格档Ｇ" .. (JY.Wugong[kf1]["层级"] * 100) ..
                                                        "Ｈ点。"
                                            -- 32加命中
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 320 and JY.Wugong[kf1]["招式" .. tb4] <
                                            325 then
                                            zswz1 = zswz1 .. "命中增加Ｇ" .. (JY.Wugong[kf1]["层级"] * 100) ..
                                                        "Ｈ点。"
                                            -- 33散功
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 330 and JY.Wugong[kf1]["招式" .. tb4] <
                                            335 then
                                            zswz1 = zswz1 .. "散功Ｇ" .. (JY.Wugong[kf1]["层级"] * 5) ..
                                                        "Ｈ时序。"
                                            -- 34外伤
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 340 and JY.Wugong[kf1]["招式" .. tb4] <
                                            345 then
                                            zswz1 = zswz1 .. "重伤三回合，目标三围降低Ｇ" ..
                                                        (5 + JY.Wugong[kf1]["层级"] * 5) .. "%Ｈ。"
                                            -- 35集气混乱
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 350 and JY.Wugong[kf1]["招式" .. tb4] <
                                            355 then
                                            zswz1 = zswz1 .. "集气混乱Ｇ" .. (JY.Wugong[kf1]["层级"] * 5) ..
                                                        "Ｈ时序。"
                                            -- 36恐惧
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 360 and JY.Wugong[kf1]["招式" .. tb4] <
                                            365 then
                                            zswz1 = zswz1 .. "Ｇ" .. (30 + JY.Wugong[kf1]["层级"] * 10) ..
                                                        "%Ｈ概率恐惧1回合。"
                                            -- 37生命最大值伤害
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 370 and JY.Wugong[kf1]["招式" .. tb4] <
                                            375 then
                                            zswz1 = zswz1 .. "造成目标生命最大值Ｇ" ..
                                                        (1 + JY.Wugong[kf1]["层级"]) .. "%Ｈ伤害。"
                                            -- 38盲目
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 380 and JY.Wugong[kf1]["招式" .. tb4] <
                                            385 then
                                            zswz1 = zswz1 .. "Ｇ" .. (JY.Wugong[kf1]["层级"] * 10) ..
                                                        "%Ｈ概率致盲。"
                                            -- 39迟缓
                                        elseif JY.Wugong[kf1]["招式" .. tb4] > 390 and JY.Wugong[kf1]["招式" .. tb4] <
                                            395 then
                                            zswz1 =
                                                zswz1 .. "目标集气减少Ｇ" .. (JY.Wugong[kf1]["层级"] * 3) ..
                                                    "Ｈ点。"
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
                                -- 读取武功说明表格 展示武功说明	
                                wugong_info(menu1[6])
                            end
                        else
                            local txppd = 0
                            local ngtx = 0
                            local hs = 0
                            local ZUIDHS = 4
                            for x = 1, 10 do
                                if JY.Wugong[kf1]['特效' .. x] > 0 then
                                    txppd = 1
                                end
                            end
                            if txppd > 0 then
                                for x = 1, 10 do
                                    ngtx = JY.Wugong[kf1]['特效' .. x]
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
                    if JY.Thing[menu1[6]]["物品说明"] ~= nil then
                        DrawString(wgzbx + bx * 30, wgzby + size * 4, JY.Thing[menu1[6]]["物品说明"], C_WHITE,
                            size * 0.73)
                    else
                        DrawString(wgzbx + bx * 30, wgzby + size * 4, "江湖中的神秘武学", color, size * 0.73)
                    end
                    local r = 0
                    if level <= 9 then
                        r = math.modf((5 - math.modf(25 / 25)) * JY.Thing[menu1[6]]["需经验"] * (level + 1) * 0.05);
                    else
                        r = math.huge;
                    end
                    if level >= 10 then
                        r = "――"
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
            -- 武功
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

---显示队伍状态
-- 左右键翻页，上下键换队友
---显示队伍状态
-- 左右键翻页，上下键换队友
function ShowPersonStatus(teamid)
    local page = 1
    local pagenum = 4

    -- lib.LoadPNGPath(string.format('./data/fight/fight%03d',JY.Person[teamid]["头像代号"]), 89, -1, 100)   --战斗贴图
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
    local id = -1 -- JY.Base["队伍" .. teamid]

    if JY.Status == GAME_WMAP then
        id = WAR.Person[teamid]["人物编号"]
    else
        id = JY.Base["队伍" .. teamid]
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

-- 无酒不欢：人物属性面板
-- case：nil=正常浏览，else加点
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
    -- 背景图
    -- lib.LoadPNG(91, 20 * 2 ,-1, -1, 1)
    -- 无酒不欢：属性显示	
    jiemian(1)

end

-- 修练秘籍
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
        thid = JY.Base["物品" .. i + 1]
        if thid >= 0 then
            if JY.Thing[thid]["类型"] == 2 then
                thing[num] = thid
                thingnum[num] = JY.Base["物品数量" .. i + 1]
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
        local yes, full, yes1, full1 = nil, nil, nil, nil -- yese=1重复武功 yese=2一脉相承 yese = 0 可以练武功  full= 0还可以修炼 
        local wugongid = JY.Thing[thingid]["练出武功"]
        if JY.Thing[thingid]["练出武功"] >= 0 then
            yes = 0
            full = 1
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
        if JY.Thing[thingid]["练出秘技"] >= 1 or thingid == 372 then
            yes1 = 0
            full1 = 1
            for i = 1, 5 do
                if JY.Person[personid]["秘技" .. i] == JY.Thing[thingid]["练出秘技"] then
                    yes1 = 1
                else
                    if JY.Person[personid]["秘技" .. i] == 0 then
                        full1 = 0
                    end
                end
            end
        end
        Usething_KF(personid, thingid)
    end
    return 1
end

-- 装备武器
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
        thid = JY.Base["物品" .. i + 1]
        if thid >= 0 then
            if JY.Thing[thid]["类型"] == 1 and JY.Thing[thid]["装备位置"] == 0 then
                thing[num] = thid
                thingnum[num] = JY.Base["物品数量" .. i + 1]
                num = num + 1
            end
        end
    end
    if id == 202 and match_ID(id, 72) then
        say("嘿嘿，这口宝刀本来就是田掌门的兵器，谁说耍刀不够就装不了？", 72, 0)
        if JY.Thing[thid]["使用人"] >= 0 then

            JY.Person[JY.Thing[thid]["使用人"]]["武器"] = -1
        end
        if JY.Person[id]["武器"] >= 0 then
            JY.Thing[JY.Person[id]["武器"]]["使用人"] = -1
        end
        JY.Person[id]["武器"] = id
        JY.Thing[thid]["使用人"] = id
        return 1
    end
    -- lib.Debug('物品总数是'..#thing)
    local r = SelectThing(thing, thingnum)
    if r >= 0 then
        if CanUseThing(r, id) then
            if JY.Thing[r]["装备位置"] == 0 then
                if JY.Thing[r]["使用人"] >= 0 then
                    JY.Person[JY.Thing[r]["使用人"]]["武器"] = -1
                end
                if JY.Person[id]["武器"] >= 0 then
                    JY.Thing[JY.Person[id]["武器"]]["使用人"] = -1
                end
            end
            JY.Person[id]["武器"] = r
            JY.Thing[JY.Person[id]["武器"]]["使用人"] = id

        else
            DrawStrBoxWaitKey("此人不适合配备此物品", C_WHITE, CC.DefaultFont)
        end
    end

    return 0
end

-- 装备防具
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
        thid = JY.Base["物品" .. i + 1]
        if thid >= 0 then
            if JY.Thing[thid]["类型"] == 1 and JY.Thing[thid]["装备位置"] == 1 then
                thing[num] = thid
                thingnum[num] = JY.Base["物品数量" .. i + 1]
                num = num + 1
            end
        end
    end
    local r = SelectThing(thing, thingnum)
    if r >= 0 then
        if CanUseThing(r, id) then
            if JY.Thing[r]["装备位置"] == 1 then
                if JY.Thing[r]["使用人"] >= 0 then
                    JY.Person[JY.Thing[r]["使用人"]]["防具"] = -1
                end
                if JY.Person[id]["防具"] >= 0 then
                    JY.Thing[JY.Person[id]["防具"]]["使用人"] = -1
                end
            end
            JY.Person[id]["防具"] = r
            JY.Thing[JY.Person[id]["防具"]]["使用人"] = id
        else
            DrawStrBoxWaitKey("此人不适合配备此物品", C_WHITE, CC.DefaultFont)
        end
    end
    return 0
end

-- 装备坐骑
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
        thid = JY.Base["物品" .. i + 1]
        if thid >= 0 then
            if JY.Thing[thid]["类型"] == 1 and JY.Thing[thid]["装备位置"] == 2 then
                thing[num] = thid
                thingnum[num] = JY.Base["物品数量" .. i + 1]
                num = num + 1
            end
        end
    end
    local r = SelectThing(thing, thingnum)
    if r >= 0 then
        if CanUseThing(r, id) then
            if JY.Thing[r]["装备位置"] == 2 then
                if JY.Thing[r]["使用人"] >= 0 then

                    JY.Person[JY.Thing[r]["使用人"]]["坐骑"] = -1
                end
                if JY.Person[id]["坐骑"] >= 0 then
                    JY.Thing[JY.Person[id]["坐骑"]]["使用人"] = -1
                end
            end
            JY.Person[id]["坐骑"] = r
            JY.Thing[JY.Person[id]["坐骑"]]["使用人"] = id
        else
            DrawStrBoxWaitKey("此人不适合配备此物品", C_WHITE, CC.DefaultFont)
        end
    end
    return 0
end

-- 计算人物修炼成功需要的点数
-- id 人物id
function TrainNeedExp(id) -- 计算人物修炼物品成功需要的点数
    local thingid = JY.Person[id]["修炼物品"];
    local r = 0;
    for i = 0, JY.ThingNum - 1 do
        local wugong = JY.Thing[i]["练出武功"]
        if wugong >= 0 then
            JY.Thing[i]["需经验"] = JY.Wugong[wugong]["层级"] * 100
            if JY.Wugong[wugong]["层级"] > 2 then
                JY.Thing[i]["需经验"] = JY.Wugong[wugong]["层级"] * 300
            end
        end
    end
    if thingid >= 0 then
        if JY.Thing[thingid]["练出武功"] >= 0 then
            local level = 0; -- 此处的level是实际level-1。这样没有武功時和炼成一级是一样的。
            for i = 1, JY.Base["武功数量"] do -- 查找当前已经炼成武功等级
                if JY.Person[id]["武功" .. i] == JY.Thing[thingid]["练出武功"] then
                    level = math.modf(JY.Person[id]["武功等级" .. i] / 100);
                    break
                end
            end
            if level < 9 then
                r = math.modf((5 - math.modf(JY.Person[id]["资质"] / 25)) * JY.Thing[thingid]["需经验"] *
                                  (level + 1) * 0.5);
            else
                r = math.huge;
            end
        else
            r = (5 - math.modf(JY.Person[id]["资质"] / 25)) * JY.Thing[thingid]["需经验"];
        end
    end
    return r;
end

-- 医疗菜单
function Menu_Doctor() -- 医疗菜单
    Cls()
    DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "谁要使用医术", C_WHITE, CC.DefaultFont);
    local nexty = CC.MainSubMenuY + CC.SingleLineHeight;
    DrawStrBox(CC.MainSubMenuX, nexty, "医疗能力", C_ORANGE, CC.DefaultFont);

    local menu1 = {};
    for i = 1, CC.TeamNum do
        menu1[i] = {"", nil, 0};
        local id = JY.Base["队伍" .. i]
        if id >= 0 then
            if JY.Person[id]["医疗能力"] >= 20 then
                menu1[i][1] = string.format("%-10s%4d", JY.Person[id]["姓名"], JY.Person[id]["医疗能力"]);
                menu1[i][3] = 1;
            end
        end
    end

    local id1, id2;
    nexty = nexty + CC.SingleLineHeight;
    local r = ShowMenu(menu1, CC.TeamNum, 0, CC.MainSubMenuX, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE);

    if r > 0 then
        id1 = JY.Base["队伍" .. r];
        Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH);
        DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "要医治谁", C_WHITE, CC.DefaultFont);
        nexty = CC.MainSubMenuY + CC.SingleLineHeight;

        local menu2 = {};
        for i = 1, CC.TeamNum do
            menu2[i] = {"", nil, 0};
            local id = JY.Base["队伍" .. i]
            if id >= 0 then
                menu2[i][1] = string.format("%-10s%4d/%4d", JY.Person[id]["姓名"], JY.Person[id]["生命"],
                    JY.Person[id]["生命最大值"]);
                menu2[i][3] = 1;
            end
        end

        local r2 = ShowMenu(menu2, CC.TeamNum, 0, CC.MainSubMenuX, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE);

        if r2 > 0 then
            id2 = JY.Base["队伍" .. r2];
            local num = ExecDoctor(id1, id2);
            if num > 0 then
                AddPersonAttrib(id1, "体力", -2);
            end
            DrawStrBoxWaitKey(string.format("%s 生命增加 %d", JY.Person[id2]["姓名"], num), C_ORANGE,
                CC.DefaultFont);
        end
    end

    Cls();
    return 0;
end

-- 解毒
function Menu_DecPoison() -- 解毒
    DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "谁要帮人解毒", C_WHITE, CC.DefaultFont);
    local nexty = CC.MainSubMenuY + CC.SingleLineHeight;
    DrawStrBox(CC.MainSubMenuX, nexty, "解毒能力", C_ORANGE, CC.DefaultFont);

    local menu1 = {};
    for i = 1, CC.TeamNum do
        menu1[i] = {"", nil, 0};
        local id = JY.Base["队伍" .. i]
        if id >= 0 then
            if JY.Person[id]["解毒能力"] >= 20 then
                menu1[i][1] = string.format("%-10s%4d", JY.Person[id]["姓名"], JY.Person[id]["解毒能力"]);
                menu1[i][3] = 1;
            end
        end
    end

    local id1, id2;
    nexty = nexty + CC.SingleLineHeight;
    local r = ShowMenu(menu1, CC.TeamNum, 0, CC.MainSubMenuX, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE);

    if r > 0 then
        id1 = JY.Base["队伍" .. r];
        Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH);
        DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "替谁解毒", C_WHITE, CC.DefaultFont);
        nexty = CC.MainSubMenuY + CC.SingleLineHeight;

        DrawStrBox(CC.MainSubMenuX, nexty, "中毒程度", C_WHITE, CC.DefaultFont);
        nexty = nexty + CC.SingleLineHeight;

        local menu2 = {};
        for i = 1, CC.TeamNum do
            menu2[i] = {"", nil, 0};
            local id = JY.Base["队伍" .. i]
            if id >= 0 then
                menu2[i][1] = string.format("%-10s%5d", JY.Person[id]["姓名"], JY.Person[id]["中毒程度"]);
                menu2[i][3] = 1;
            end
        end

        local r2 = ShowMenu(menu2, CC.TeamNum, 0, CC.MainSubMenuX, nexty, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE);
        if r2 > 0 then
            id2 = JY.Base["队伍" .. r2];
            local num = ExecDecPoison(id1, id2);
            DrawStrBoxWaitKey(string.format("%s 中毒程度减少 %d", JY.Person[id2]["姓名"], num), C_ORANGE,
                CC.DefaultFont);
        end
    end
    Cls();
    ShowScreen();
    return 0;
end

-- 解毒
-- id1 解毒id2, 返回id2中毒减少点数
function ExecDecPoison(id1, id2) -- 执行解毒
    local add = JY.Person[id1]["解毒能力"];
    local value = JY.Person[id2]["中毒程度"];
    if value > add + 20 then
        return 0;
    end

    add = limitX(math.modf(add / 3) + Rnd(10) - Rnd(10), 0, value);
    return -AddPersonAttrib(id2, "中毒程度", -add);
end

function Thing_info(thingID, x, y, myh, numer, size) -- 物品ID,坐标x,坐标Y，hs,字数，换页，开始行数，starth，字体,翻页
    -- lib.Debug(thingID);
	local me = {}
	local wz = 0
	local hs = 0
	local fy = 0
	local starth = 0
	local WZ = 0
	local m = 1
    local function strcolor_switch(s)
        local Color_Switch = {{"Ｒ", PinkRed}, {"Ｇ", M_Wheat}, {"Ｂ", C_BLACK}, {"Ｗ", C_WHITE},
                              {"Ｏ", C_ORANGE}, {"Ｌ", LimeGreen}, {"Ｄ", M_DeepSkyBlue}, {"Ｚ", Violet}}
        for i = 1, 8 do
            if Color_Switch[i][1] == s then
                return Color_Switch[i][2]
            end
        end
    end
	if JY.Thing[thingID]['练出武功'] > 0 and JY.Wugong[JY.Thing[thingID]['练出武功']]['武功类型'] >= 6 then 
		local kf = JY.Thing[thingID]['练出武功']
		--lib.LoadPNG(91,372*2,wgzbx-size*2,wgzby-CC.ScreenH/2.8,1)
		for i =1,10 do 
			local kftx = JY.Wugong[kf]['特效'..i]
			if kftx > 0 then 
				me[#me+1] = NGTX_sm(kf,kftx) 
			end
		end
	else	
		if ItemInfo[thingID] ~= nil then
			for i = 1, #ItemInfo[thingID] do
				me[#me + 1] = ItemInfo[thingID][i]
				if i == ItemInfo[thingID] then
					me[#me + 1] = "Ｎ"
				end
			end
		end
	end
	for i = m, #me do
		local tfstr = me[i]
		local color;
		color = strcolor_switch(string.sub(tfstr, 1, 2))
		tfstr = string.sub(tfstr, 3, -1)
		if string.sub(tfstr, 1, 2) == "Ｎ" then
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

-- 显示物品菜单

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
        local f = JY.Person[p]["畅想分阶"]
        if p ~= 0 and JY.Person[p]["畅想分阶"] < 7 then
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
            fj = JY.Person[menu2[i][1]]["畅想分阶"]
            cd = JY.Person[menu2[i][1]]["天书"]
            wg = JY.Person[menu2[i][1]]["精通武功"]
            headid = JY.Person[menu2[i][1]]["半身像"]
            name = JY.Person[menu2[i][1]]["姓名"]
            id = menu2[i][1]

            -- 分阶
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

            -- 天书
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

            -- 精通武功
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
                local x4 = bx * (j - 2) * 100
                lib.PicLoadCache(pic + 101, (dl) * 2, bx * 212 + x4, by * 33 + by * 670)
                wz = wz + 1
                dh = dh + 1
                if dh == zs then
                    dh = 1
                end
            end
        end
        local cznum = JY.Person[0]["等级"] + 1
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

-- 场景坐标(x,y)是否可以通过
-- 返回true,可以，false不能
function SceneCanPass(x, y) -- 场景坐标(x,y)是否可以通过
    local ispass = true; -- 是否可以通过

    if GetS(JY.SubScene, x, y, 1) > 0 then -- 场景层1有物品，不可通过
        ispass = false;
    end

    local d_data = GetS(JY.SubScene, x, y, 3); -- 事件层4
    if d_data >= 0 then
        if GetD(JY.SubScene, d_data, 0) ~= 0 then -- d*数据为不能通过
            ispass = false;
        end
    end

    if CC.SceneWater[GetS(JY.SubScene, x, y, 0)] ~= nil then -- 水面，不可进入
        ispass = false;
    end
    return ispass;
end

function DtoSMap() ---D*中的事件数据复制到S*中，同时处理动画效果。
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
                if p3 <= p1 then -- 动画已停止
                    if JY.Mytick % 100 > delay then
                        p3 = p3 + 1;
                    end
                else
                    if JY.Mytick % 4 == 0 then -- 4个节拍动画增加一次
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

function DrawSMap() -- 绘场景地图
    local x0 = JY.SubSceneX + JY.Base["人X1"] - 1; -- 绘图中心点
    local y0 = JY.SubSceneY + JY.Base["人Y1"] - 1;

    local x = limitX(x0, 12, 45) - JY.Base["人X1"];
    local y = limitX(y0, 12, 45) - JY.Base["人Y1"];
    local sc = CC.Shichen
    if CC.TX['夜幕'] == 1 then
        --sc = 6
    end
    if CONFIG.Zoom == 100 then
        lib.DrawSMap(JY.SubScene, JY.Base["人X1"], JY.Base["人Y1"], x, y, JY.MyPic, sc)
    else
        lib.DrawSMap(JY.SubScene, JY.Base["人X1"], JY.Base["人Y1"], JY.SubSceneX, JY.SubSceneY, JY.MyPic, sc)
    end
end

-- 读取游戏进度
-- id=0 新进度，=1/2/3 进度
-- 这里是先把数据读入Byte数组中。然后定义访问相应表的方法，在访问表时直接从数组访问。
-- 与以前的实现相比，从文件中读取和保存到文件的时间显著加快。而且内存占用少了
function LoadRecord(id) -- 读取游戏进度
    local zipfile = string.format(CC.SavePath .. 'Save_%d'..'.sav', id)

    if id ~= 0 and (existFile(zipfile) == false) then
        QZXS("此存档数据不全，不能读取。请选择其它存档或重新开始");
        return -1;
    end

    --Byte.unzip(zipfile, CC.SavePath .. 'r.grp', CC.SavePath .. 'd.grp', CC.SavePath .. 's.grp', CC.SavePath .. 'tjm')
	Byte.unzip_path(zipfile, CC.SavePath..'', 'r.grp','d.grp','s.grp','tjm','e.grp','a.grp')

    local t1 = lib.GetTime();

    -- 读取R*.idx文件
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
    local cx = JY.Base['畅想']
    if id == 0 then
        grpFile = CC.R_GRPFilename[id];
        sFile = CC.S_Filename[id];
        dFile = CC.D_Filename[id];
		msFile = CC.MMapFile[6];
		mdFile = CC.MMapFile[7];
    end

    -- 读取R*.grp文件
    JY.Data_Base = Byte.create(idx[1] - idx[0]); -- 基本数据
    Byte.loadfile(JY.Data_Base, grpFile, idx[0], idx[1] - idx[0]);

    -- 设置访问基本数据的方法，这样就可以用访问表的方式访问了。而不用把二进制数据转化为表。节约加载时间和空间
    local meta_t = {
        __index = function(t, k)
            return GetDataFromStruct(JY.Data_Base, 0, CC.Base_S, k);
        end,

        __newindex = function(t, k, v)
            SetDataFromStruct(JY.Data_Base, 0, CC.Base_S, k, v);
        end
    }
    setmetatable(JY.Base, meta_t);

    JY.PersonNum = math.floor((idx[2] - idx[1]) / CC.PersonSize); -- 人物

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

    JY.ThingNum = math.floor((idx[3] - idx[2]) / CC.ThingSize); -- 物品
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

    JY.SceneNum = math.floor((idx[4] - idx[3]) / CC.SceneSize); -- 场景
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

    JY.WugongNum = math.floor((idx[5] - idx[4]) / CC.WugongSize); -- 武功
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

    JY.ShopNum = math.floor((idx[6] - idx[5]) / CC.ShopSize); -- 城镇商店
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

    JY.TejiNum = math.floor((idx[7] - idx[6]) / CC.TejiSize); -- 特技
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
	lib.LoadMMapEvent(msFile,mdFile,CC.MWidth,CC.MHeight,CC.DNum,11);--适配，添加大地图事件
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

-- 写游戏进度
-- id=0 新进度，=1/2/3 进度
function SaveRecord(id) -- 写游戏进度

    -- 判断是否在子场景保存
    if JY.Status == GAME_SMAP then
        JY.Base["无用"] = JY.SubScene
    else
        JY.Base["无用"] = -1
    end

    -- 读取R*.idx文件
    -- Cat时间计时
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
    -- 写R*.grp文件
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
-----------------------------------通用函数-------------------------------------------

function filelength(filename) -- 得到文件长度
    local inp = io.open(filename, "rb");
    local l = inp:seek("end");
    inp:close();
    return l;
end

-- 读S×数据, (x,y) 坐标，level 层 0-5
function GetS(id, x, y, level) -- 读S×数据
    return lib.GetS(id, x, y, level);
end

-- 写S×
function SetS(id, x, y, level, v) -- 写S×
    lib.SetS(id, x, y, level, v);
end

-- 读D*
-- sceneid 场景编号，
-- id D*编号
-- 要读第几个数据, 0-10
function GetD(Sceneid, id, i) -- 读D*
    return lib.GetD(Sceneid, id, i);
end

-- 写D×
function SetD(Sceneid, id, i, v) -- 写D×
    lib.SetD(Sceneid, id, i, v);
end

-- 从数据的结构中翻译数据
-- data 二进制数组
-- offset data中的偏移
-- t_struct 数据的结构，在jyconst中有很多定义
-- key  访问的key
function GetDataFromStruct(data, offset, t_struct, key) -- 从数据的结构中翻译数据，用来取数据
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

function SetDataFromStruct(data, offset, t_struct, key, v) -- 从数据的结构中翻译数据，保存数据
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

-- 按照t_struct 定义的结构把数据从data二进制串中读到表t中
function LoadData(t, t_struct, data) -- data二进制串中读到表t中
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

-- 按照t_struct 定义的结构把数据写入data Byte数组中。
function SaveData(t, t_struct, data) -- 数据写入data Byte数组中。
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

-- 限制x的范围
function limitX(x, minv, maxv)
    if x < minv then
        x = minv;
    end
    if maxv ~= nil and x > maxv then
        x = maxv;
    end
    return x
end

function RGB(r, g, b) -- 设置颜色RGB
    return r * 65536 + g * 256 + b;
end

function GetRGB(color) -- 分离颜色的RGB分量
    color = color % (65536 * 256);
    local r = math.floor(color / 65536);
    color = color % 65536;
    local g = math.floor(color / 256);
    local b = color % 256;
    return r, g, b
end

-- 等待键盘输入
function WaitKey(flag)
    -- ktype  1：键盘，2：鼠标移动，3:鼠标左键，4：鼠标右键，5：鼠标中键，6：滚动上，7：滚动下
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

-- 绘制一个带背景的白色方框，四角凹进
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

-- 绘制一个带背景的白色方框，四角凹进
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

-- 显示阴影字符串
function DrawString(x, y, str, color, size, ttf) -- 显示阴影字符串
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

-- 显示带框的字符串
-- (x,y) 坐标，如果都为-1,则在屏幕中间显示
function DrawStrBox(x, y, str, color, size, boxcolor) -- 显示带框的字符串
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

-- 无酒不欢：增加对颜色转换的支持
function DrawStrBox3(x, y, s, color, size, flag) -- 显示带框的字符串
    local ll = #s - flag * 2;
    local w = size * ll / 2 + 2 * CC.MenuBorderPixel;
    local h = size + 2 * CC.MenuBorderPixel;
    local function strcolor_switch(s)
        local Color_Switch = {{"Ｒ", C_RED}, {"Ｇ", C_GOLD}, {"Ｂ", C_BLACK}, {"Ｗ", C_WHITE}, {"Ｏ", C_ORANGE}}
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

    -- 无酒不欢：方框颜色 7-31
    DrawBox(x, y, x + w - 1, y + h - 1, LimeGreen);
    local space = 0;
    while string.len(s) >= 1 do
        local str
        str = string.sub(s, 1, 1)
        if string.byte(s, 1, 1) > 127 then -- 判断单双字符
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

-- 显示并询问Y/N，如果点击Y，则返回true, N则返回false
-- (x,y) 坐标，如果都为-1,则在屏幕中间显示
-- 改为用菜单询问是否
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
    local menu = {{"确   定", nil, 1}, {"取   消", nil, 2}}
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

-- 显示字符串并等待击键，字符串带框，显示在屏幕中间
function DrawStrBoxWaitKey(s, color, size, flag, boxcolor)
    if JY.Restart == 1 then
        return
    end
    lib.GetKey();
    -- Cls();
    -- 无酒不欢：分开多种
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

-- 显示字符串并等待击键，字符串带框，显示在屏幕中间
function DrawStrBoxWaitKey1(s, color, size, flag, boxcolor)
    if JY.Restart == 1 then
        return
    end
    lib.GetKey();
    -- Cls();
    -- 无酒不欢：分开多种
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

-- 返回 [0 , i-1] 的整形随机数
function Rnd(i) -- 随机数
    local r = math.random(i);
    return r - 1;
end

-- 增加人物属性，如果有最大值限制，则应用最大值限制。最小值则限制为0
-- id 人物id
-- str属性字符串
-- value 要增加的值，负数表示减少
-- 返回1,实际增加的值
-- 返回2，字符串：xxx 增加/减少 xxxx，用于显示药品效果
function AddPersonAttrib(id, str, value)
    local oldvalue = JY.Person[id][str]
    local attribmax = math.huge
    local zm = JY.Base['周目']
    if str == "生命" then
        attribmax = JY.Person[id]["生命最大值"]
    elseif str == "内力" then
        attribmax = JY.Person[id]["内力最大值"]
    elseif CC.PersonAttribMax[str] ~= nil then
        attribmax = CC.PersonAttribMax[str]
        if inteam(id) == false then
            if str == "攻击力" then
                attribmax = CC.PersonAttribMax[str] + JY.Base['周目'] * 10
            end
            if str == "防御力" then
                attribmax = CC.PersonAttribMax[str] + JY.Base['周目'] * 10
            end
            if str == "轻功" then
                attribmax = CC.PersonAttribMax[str] + JY.Base['周目'] * 10
            end

            if str == "拳掌功夫" or str == "指法技巧" or str == "御剑能力" or str == "耍刀技巧" or str ==
                "特殊兵器" then
                attribmax = CC.PersonAttribMax[str] + JY.Base['周目'] * JY.Base['难度']
            end
            if str == "基础生命" then
                -- attribmax = (7-JY.Base['畅想分阶'])*JY.Base['难度']*5  + JY.Base['周目']*100
                Hp_Max(id)
            end
            if str == "内力最大值" then
                local p_zz = JY.Person[id]["资质"];
                local zz = 100 - JY.Person[id]["资质"]
                if isteam(id) then
                    attribmax = 1500
                    attribmax = attribmax + zz * 40
                else
                    attribmax = JY.Person[id]["内力最大值"]
                end
                -- 段誉，扫地，石破天，无崖子 ，斗酒僧
                if match_ID(id, 53) or match_ID(id, 114) or match_ID(id, 9760) or match_ID(id, 116) or match_ID(id, 638) or
                    match_ID(id, 499) or match_ID(id, 9999) then
                    attribmax = 9999
                end

                -- 学一个内功开发1000内力上限
                if NGnum(id) >= 1 then
                    local n = NGnum(id)
                    if n >= 3 then
                        n = 3
                    end
                    attribmax = attribmax + 1000 * NGnum(id)
                end
                -- 学有北冥或吸星，+300
                for i = 1, JY.Base["武功数量"] do
                    -- if JY.Person[id]["武功" .. i] == 85 or JY.Person[id]["武功" .. i] == 88 then
                    -- attribmax = attribmax + 300
                    -- break
                    -- end
                    local kf = JY.Person[id]["武功" .. i]
                    local kfnl = JY.Thing[KF_thing(kf)]['加内力最大值']
                    if kfnl > 0 then
                        attribmax = attribmax + kfnl
                        break
                    end
                end
                -- 阴阳相济
                if JY.Person[id]['奇穴' .. 129] == 1 then
                    attribmax = attribmax + 500
                end
                -- 杨过吼过的内力
                if match_ID(id, 58) then
                    attribmax = attribmax - JY.Person[300]["声望"] * 1000
                end
                -- 内力下限2999，上限9999
                if attribmax < 2999 then
                    attribmax = 2999
                end
                if attribmax > 9999 then
                    -- attribmax = 9999 
                end
                local nd = JY.Base['难度']
                local zm = JY.Base['周目']
                local fj = (6 - JY.Person[id]['畅想分阶'])
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

    -- 瑜伽密乘减少受伤最大值
    if str == "受伤程度" then
        if PersonKF(id, 169) then
            attribmax = 50
        end
    end
    if str == '体质' then
        attribmax = 20
    end
    if str == "生命最大值" then

    end
    if str == "内力最大值" then

    end

    -- 程灵素，何铁手，王难姑，用毒500
    if str == "用毒能力" and (match_ID(id, 2) or match_ID(id, 83) or match_ID(id, 17)) then
        attribmax = 600
    end

    -- 蓝凤凰，用毒400
    if str == "用毒能力" and match_ID(id, 25) then
        attribmax = 500
    end
    -- 炼毒奇穴
    if str == "用毒能力" and JY.Person[id]['奇穴' .. 22] == 1 then
        attribmax = attribmax + 20
    end
    -- 盅毒降奇穴
    if str == "用毒能力" and JY.Person[id]['奇穴' .. 25] == 1 then
        attribmax = attribmax + 30
        if Pmiji(id, 6) and Pmiji(id, 8) then
            attribmax = attribmax + 80
        end
    end

    -- 万毒蚀体奇穴1
    if str == "用毒能力" and JY.Person[id]['奇穴' .. 28] == 1 then
        attribmax = attribmax + 100
    end
    -- 胡青牛，平一指，薛慕华医疗500
    if str == "医疗能力" and (match_ID(id, 16) or match_ID(id, 28) or match_ID(id, 45)) then
        attribmax = 600
    end
    -- 贝海石，程灵素医疗400
    if str == "医疗能力" and (match_ID(id, 85) or match_ID(id, 2)) then
        attribmax = 500
    end
    -- 标主医生，医疗用毒解毒都是400
    if (str == "医疗能力" or str == "用毒能力" or str == "解毒能力") and id == 0 and JY.Base["标准"] == 8 then
        attribmax = 500
    end
    -- 标主毒王，用毒解毒都是500
    if (str == "用毒能力" or str == "解毒能力") and id == 0 and JY.Base["标准"] == 9 then
        attribmax = 600
    end
    -- 阎基，医疗用毒都是300
    if (str == "医疗能力" or str == "用毒能力") and match_ID(id, 4) then
        attribmax = 400
    end
    -- 李寻欢，暗器技巧都是500
    if str == "暗器技巧" and match_ID(id, 498) then
        attribmax = 400
    end
    -- 战斗中禁疗无法恢复任何状态
    if JY.Status == GAME_WMAP then
        if str == '生命' or str == '内力' or str == '体力' then
            if value > 0 and WAR.PD['禁疗'][id] ~= nil then
                value = 0
            end
        end
        -- 毒王不会解读
        if id == 0 and JY.Base['标准'] == 9 and str == '中毒程度' then
            if value < 0 then
                value = 0
            end
        end
    end
    local newvalue = limitX(oldvalue + value, 0, attribmax)
    JY.Person[id][str] = newvalue

    local tf = {9960, 9959, 9958, 9957, 9956}
    local jc = {"拳掌功夫", "指法技巧", "御剑能力", "耍刀技巧", "特殊兵器"}
    if str == '实战' then
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
            if newvalue >= 300 and JY.Person[id]['实战'] >= 500 then
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
        showstr = string.format("%s 增加 %d", str, add)
    elseif add < 0 then
        showstr = string.format("%s 减少 %d", str, -add)
    end
    return add, showstr
end

-- 播放midi
function PlayMIDI(id) -- 播放midi
    JY.CurrentMIDI = id;
    if JY.EnableMusic == 0 then
        return;
    end
    if id >= 0 then
        lib.PlayMIDI(string.format(CC.MIDIFile, id + 1));
    end
end

-- 播放音效atk***
function PlayWavAtk(id) -- 播放音效atk***
    if JY.EnableSound == 0 then
        return;
    end
    if id >= 0 then
        lib.PlayWAV(string.format(CC.ATKFile, id));
    end
end

-- 播放音效e**
function PlayWavE(id) -- 播放音效e**
    if JY.EnableSound == 0 then
        return;
    end
    if id >= 0 then
        lib.PlayWAV(string.format(CC.EFile, id));
    end
end

-- flag =0 or nil 全部刷新屏幕
-- 1 考虑脏矩形的快速刷新
function ShowScreen(flag)
    if JY.Darkness == 0 then
        if flag == nil then
            flag = 0
        end
        lib.ShowSurface(flag)
    end
end

-- 通用菜单函数
-- menuItem 表，每项保存一个子表，内容为一个菜单项的定义
--          菜单项定义为  {   ItemName,     菜单项名称字符串
--                          ItemFunction, 菜单调用函数，如果没有则为nil
--                          Visible       是否可见  0 不可见 1 可见, 2 可见，作为当前选择项。只能有一个为2，
--                                        多了则只取第一个为2的，没有则第一个菜单项为当前选择项。
--                                        在只显示部分菜单的情况下此值无效。
--                                        此值目前只用于是否菜单缺省显示否的情况
--                       }
--          菜单调用函数说明：         itemfunction(newmenu,id)
--
--       返回值
--              0 正常返回，继续菜单循环 1 调用函数要求退出菜单，不进行菜单循环
--
-- numItem      总菜单项个数
-- numShow      显示菜单项目，如果总菜单项很多，一屏显示不下，则可以定义此值
--                =0表示显示全部菜单项

-- (x1,y1),(x2,y2)  菜单区域的左上角和右下角坐标，如果x2,y2=0,则根据字符串长度和显示菜单项自动计算x2,y2
-- isBox        是否绘制边框，0 不绘制，1 绘制。若绘制，则按照(x1,y1,x2,y2)的矩形绘制白色方框，并使方框内背景变暗
-- isEsc        Esc键是否起作用 0 不起作用，1起作用
-- Size         菜单项字体大小
-- color        正常菜单项颜色，均为RGB
-- selectColor  选中菜单项颜色,
-- ;
-- 返回值  0 Esc返回
--         >0 选中的菜单项(1表示第一项)
--         <0 选中的菜单项，调用函数要求退出父菜单，这个用于退出多层菜单

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
    -- 无酒不欢：战斗快捷键时机判定
    local In_Battle = false;
    if JY.Status == GAME_WMAP and numItem >= 8 and menuItem[8][1] == "自动" then
        In_Battle = true
    end
    -- 无酒不欢：战术菜单判定
    local In_Tactics = false;
    if JY.Status == GAME_WMAP and numItem >= 3 and menuItem[3][1] == "等待" then
        In_Tactics = true
    end
    -- 其它菜单判定
    local In_Other = false;
    if JY.Status == GAME_WMAP and numItem >= 5 and menuItem[3][1] == "医疗" then
        In_Other = true
    end
    -- 修改战斗菜单bx以便显示快捷键
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
            -- 快捷键提示显示
            if In_Battle == true then
                if newMenu[i][1] == "攻击" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "A", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "运功" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "G", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "战术" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "S", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "其它" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "H", LimeGreen, CC.FontSmall)
                elseif newMenu[i][2] == War_TgrtsMenu then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "T", LimeGreen, CC.FontSmall)
                end
            end
            if In_Tactics == true then
                if newMenu[i][1] == "蓄力" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "P", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "防御" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "D", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "等待" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "W", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "集中" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "J", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "休息" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "R", LimeGreen, CC.FontSmall)
                end
            end
            if In_Other == true then
                if newMenu[i][1] == "用毒" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "V", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "解毒" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "Q", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "医疗" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "F", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "物品" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "E", LimeGreen, CC.FontSmall)
                elseif newMenu[i][1] == "状态" then
                    DrawString(x1 + CC.MenuBorderPixel + size * 2,
                        y1 + CC.MenuBorderPixel + (i - start) * (size + CC.RowPixel) + 2, "Z", LimeGreen, CC.FontSmall)
                end
            end
        end
        ShowScreen()
        lib.Delay(CC.Frame)
        local keyPress, ktype, mx, my = WaitKey(1)

        if keyPress == VK_ESCAPE or ktype == 4 then
            -- Esc 或 退出
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
            if newNumItem < current + start then -- Alungky 修复看攻略时会跳出的BUG
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
            elseif current < num then -- Alungky 修复看攻略时会跳出的BUG
                start = 1
            end
            -- 无酒不欢：战斗快捷键
            -- 攻击
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
            -- 1-9直接攻击
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
            -- 运功
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
            -- 战术
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
            -- 其它
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
            -- 用毒
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
            -- 解毒
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
            -- 医疗
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
            -- 物品
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
            -- 状态
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
            -- 休息
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
            -- 特色指令
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
            -- C查看
        elseif In_Battle == true and keyPress == VK_C then
            local r = MapWatch();
            ClsN();
            lib.LoadSur(surid, 0, 0);
            if isBox == 1 then
                DrawBox(x1, y1, x1 + w, y1 + h, C_WHITE);
            end
            -- 蓄力
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
            -- 防御
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
            -- 等待
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
            -- 集中
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
            if ktype == 2 or ktype == 3 then -- 选中
                if mx >= x1 and mx <= x1 + w and my >= y1 and my <= y1 + h then
                    current = start + math.modf((my - y1 - CC.MenuBorderPixel) / (size + CC.RowPixel))
                    mk = true;
                end
            end
            -- 选中确认
            if keyPress == VK_SPACE or keyPress == VK_RETURN or ktype == 5 or (ktype == 3 and mk) then
                if newMenu[current][2] == nil then
                    returnValue = newMenu[current][4];
                    break
                elseif newMenu[current][2] == SelectNeiGongMenu then
                    local id = WAR.Person[WAR.CurID]["人物编号"]
                    -- 运功内力不足
                    if JY.Person[id]["内力"] < 2000 then
                        DrawStrBoxWaitKey("内力不足，无法运功", C_RED, CC.DefaultFont, nil, LimeGreen)
                        -- 运功体力不足
                    elseif JY.Person[id]["体力"] < 20 then
                        DrawStrBoxWaitKey("体力不足，无法运功", C_RED, CC.DefaultFont, nil, LimeGreen)
                    else
                        local r = newMenu[current][2](newMenu, current);
                        -- 连续两级菜单全部返回20作为判定参数
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
                    local id = WAR.Person[WAR.CurID]["人物编号"]
                    -- 运功体力不足
                    if JY.Person[id]["体力"] < 20 then
                        DrawStrBoxWaitKey("体力不足，无法运功", M_DeepSkyBlue, CC.DefaultFont, nil, LimeGreen)
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
                    local r = newMenu[current][2](newMenu, current); -- 调用菜单函数

                    -- 无酒不欢：重写一下这里的返回逻辑以适应运功
                    if r == 1 then
                        returnValue = -newMenu[current][4];
                        break
                        -- 连续两级菜单全部返回20作为判定参数
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

-- 基本参数和ShowMenu一样，有一些特别的进行着重说明
-- menu 每个数据三个值，1名称，2执行函数，3显示方式(0灰色可选择，1正常显示，2不显示, 3灰色不可选择)
-- itemNum 菜单的个数，通常在调用的时候 #menu就可以了
-- numShow 每行显示的菜单个数
-- showRow 一个版面显示的最大行数，如果可显示菜单个数达不到一个版面的数，函数会自动适应这个值
-- str 是标题的文字，传nil不显示
-- 选中项
function ShowMenu2(menu, itemNum, numShow, showRow, x1, y1, x2, y2, isBox, isEsc, size, color, selectColor, str,
    selIndex) -- 通用菜单函数
    local w = 0;
    local h = 0; -- 边框的宽高
    local i, j = 0, 0;
    local col = 0; -- 实际的显示菜单项
    local row = 0; -- 行数

    lib.GetKey();
    Cls();

    -- 建一个新的table
    local menuItem = {};
    local numItem = 0; -- 显示的总数

    -- 把可显示的部分放到新table
    for i, v in pairs(menu) do
        if v[3] ~= 2 then
            numItem = numItem + 1;
            menuItem[numItem] = {v[1], v[2], v[3], i}; -- 注意第4个位置，保存i的值
        end
    end

    -- 计算实际显示的菜单项数
    if numShow == 0 or numShow > numItem then -- 如果每行显示的菜单个数等0或者每行显示的菜单个数数量 >菜单总数量
        col = numItem; -- 实际显示数量 = 总数量
        row = 1; -- 总行数等1
    else
        col = numShow; -- 实际显示数量 = 显示数量 
        row = math.modf((numItem - 1) / col); -- 总行数 = （总菜单数量 - 1）/实际显示数量
    end

    if showRow > row + 1 then -- 最大行数 > 总数行数 + 1
        showRow = row + 1; -- 最大行数  = 总行数 + 1
    end

    -- 计算边框实际宽高
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

    local start = 0; -- 显示的第一项

    local curx = 1; -- 当前选择项
    local cury = 0;
    local current = curx + cury * numShow; -- 选中项 = 当前选项+页数*每行显示的菜单个数

    -- 默认有选中
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
                local drawColor = color; -- 设置不同的绘制颜色
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

        if keyPress == VK_ESCAPE or ktype == 4 then -- Esc 退出
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
            if ktype == 2 or ktype == 3 then -- 选中
                -- 无酒不欢：加个逻辑判定防止跳出
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
                    local r = menuItem[current][2](menuItem, current); -- 调用菜单函数
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

    -- 返回值，这个是取第4个位置的值
    if returnValue > 0 then
        return menuItem[returnValue][4]
    else
        return returnValue
    end
end

-- 无酒不欢：畅想的选择菜单
function ShowMenu3(menu, itemNum, numShow, showRow, x1, y1, size, color, selectColor)
    local w = 0;
    local h = 0; -- 边框的宽高
    local i, j = 0, 0;
    local col = 0; -- 实际的显示菜单项
    local row = 0;

    lib.GetKey();
    Cls();

    -- 建一个新的table
    local menuItem = {};
    local numItem = 0; -- 显示的总数

    -- 把可选为畅想的人物保存到新的table
    for i, v in pairs(menu) do
        if v[3] ~= 0 then
            numItem = numItem + 1;
            menuItem[numItem] = {v[1], v[2], v[3], i}; -- 注意第4个位置，保存i的值
        end
    end

    -- 计算实际显示的菜单项数
    if numShow == 0 or numShow > numItem then
        col = numItem;
        row = 1;
    else
        -- lieshu
        col = numShow;
        -- (项目总数-1)/lieshu=行数
        row = math.modf((numItem - 1) / col);
    end

    if showRow > row + 1 then
        showRow = row + 1;
    end

    -- 计算边框实际宽高
    local maxlength = 0;

    for i = 1, numItem do
        if string.len(menuItem[i][1]) > maxlength then
            maxlength = string.len(menuItem[i][1]);
        end
    end
    w = (size * maxlength / 2 + CC.RowPixel * 2) * col + 2 * CC.MenuBorderPixel;
    h = showRow * (size + CC.RowPixel * 2) + 2 * CC.MenuBorderPixel;

    local start = 0; -- 显示的第一项

    local curx = 1; -- 当前选择项
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
        -- 说明行在此
        -- DrawString(x1+(size+CC.RowPixel)*9-3,y1-(size+CC.RowPixel)*2-CC.RowPixel,"PgUp/PgDn/鼠标滚轮翻页",LimeGreen,size);
        -- DrawString(x1+(size+CC.RowPixel)*8-50,y1-(size+CC.RowPixel)*1,"名称黄色为一阶 名称蓝色为高阶 红色为顶阶",LimeGreen,size);
        for i = start, showRow + start - 1 do
            for j = 1, col do
                local n = i * col + j;
                if n > numItem then
                    break
                end

                -- 设置不同的绘制颜色
                local drawColor = color;
                if menuItem[n][3] == 2 then
                    drawColor = M_DeepSkyBlue
                end
                if menuItem[n][1] == "独孤求败" or menuItem[n][1] == "扫地老僧" or menuItem[n][1] == "张三丰" then
                    drawColor = C_RED
                end
                if menuItem[n][1] == "萧玲" or menuItem[n][1] == "梁萧" or menuItem[n][1] == "李寻欢" or
                    menuItem[n][1] == "李白" or menuItem[n][1] == "斗酒僧" or menuItem[n][1] == "黄裳" or
                    menuItem[n][1] == "逍遥子" or menuItem[n][1] == "达摩" or menuItem[n][1] == "陆渐" or
                    menuItem[n][1] == "寇仲" or menuItem[n][1] == "司空摘星" or menuItem[n][1] == "步惊云" or
                    menuItem[n][1] == "冯蘅" or menuItem[n][1] == "张家辉" or menuItem[n][1] == "萧秋水" then
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
        elseif keyPress == VK_PGUP or ktype == 6 then -- PgUp 或 鼠标滚轮上
            if start == 15 then
                start = start - 15;
                curx = 1
                cury = 0
                mk = true;
            end
        elseif keyPress == VK_PGDN or ktype == 7 then -- PgDn 或 鼠标滚轮下	
            if start == 0 then
                start = start + 15;
                curx = 1
                cury = 15
                mk = true;
            end
        else
            if ktype == 2 or ktype == 3 then -- 选中
                -- 无酒不欢：加个逻辑判定防止跳出
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
            -- 空格，回车，
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

    -- 返回值，这个是取第4个位置的值
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
        -- if isEsc == 1 and keyPress==VK_ESCAPE then                  --Esc 退出
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
                local r = menu1[tb][2](menu1, tb); -- 调用菜单函数
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
                    local r = menu1[tb][2](menu1, tb); -- 调用菜单函数
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

function ShowMenu5(menu, itemNum, numShow, showRow, str, r) -- 通用菜单函数

    local bx, by = CC.ScreenW / 1360, CC.ScreenH / 768
    local w = 0;
    local h = 0; -- 边框的宽高
    local i, j = 0, 0;
    local pnum = 0; -- 实际的显示菜单项
    local page = 0;
    local size = CC.DefaultFont * 0.9
    lib.GetKey();
    Cls();
    local x1, y1, x2, y2 = CC.ScreenW / 6, CC.ScreenH / 10, 0, 0
    local isBox = 0
    -- 建一个新的table
    local menu1 = {};
    local num = 0; -- 显示的总数
    local isEsc = 1
    local color = C_WHITE1
    local selectColor = C_RED
    -- 把可显示的部分放到新table
    for i, v in pairs(menu) do
        if v[3] ~= 2 then
            num = num + 1;
            menu1[num] = {v[1], v[2], v[3], i}; -- 注意第4个位置，保存i的值
        end
    end

    -- 计算实际显示的菜单项数
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

    -- 计算边框实际宽高
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

    local start = 0; -- 显示的第一项

    local tb = 1; -- 当前选择项
    local cury = 0;
    local cot = tb + cury * numShow;

    -- 默认有选中
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
                local drawColor = color; -- 设置不同的绘制颜色
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

        if keyPress == VK_ESCAPE or ktype == 4 then -- Esc 退出
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
            if ktype == 2 or ktype == 3 then -- 选中
                -- 无酒不欢：加个逻辑判定防止跳出
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
                    local r = menu1[cot][2](menu1, cot); -- 调用菜单函数
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
    -- 返回值，这个是取第4个位置的值
    if returnValue > 0 then
        return menu1[returnValue][4]
    else
        return returnValue
    end
end
------------------------------------------------------------------------------------
--------------------------------------物品使用---------------------------------------
-- 物品使用模块
-- 当前物品id
-- 返回1 使用了物品， 0 没有使用物品。可能是某些原因不能使用
function UseThing(id)
    return DefaultUseThing(id);
end

-- 缺省物品使用函数，实现原始游戏效果
-- id 物品id
function DefaultUseThing(id) -- 缺省物品使用函数
    if JY.Thing[id]["类型"] == 0 then
        return UseThing_Type0(id);
    elseif JY.Thing[id]["类型"] == 1 then
        return UseThing_Type1(id);
    elseif JY.Thing[id]["类型"] == 2 then
        return UseThing_Type2(id);
    elseif JY.Thing[id]["类型"] == 3 then
        return UseThing_Type3(id);
    elseif JY.Thing[id]["类型"] == 4 then
        return UseThing_Type4(id);
    end
end

-- 剧情物品，触发事件
function UseThing_Type0(id)
    -- 合并九阴
    if id == 286 then
        local jyzj = 0
        for j = 1, CC.MyThingNum do
            if JY.Base["物品" .. j] == 287 then
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
            if JY.Base["物品" .. j] == 286 then
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
        local x = JY.Base["人X1"] + CC.DirectX[JY.Base["人方向"] + 1];
        local y = JY.Base["人Y1"] + CC.DirectY[JY.Base["人方向"] + 1];
        local d_num = GetS(JY.SubScene, x, y, 3)
        if d_num >= 0 then
            JY.CurrentThing = id;
            EventExecute(d_num, 2); -- 物品触发事件
            JY.CurrentThing = -1;
            return 1;
        else
            return 0;
        end
    end
    -- 合地灵丹事件
    if id == 315 then
        local dld = 0
        for j = 1, CC.MyThingNum do
            if JY.Base["物品" .. j] == 314 and JY.Base["物品" .. j] == 231 and JY.Base["物品" .. j] == 26 then
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

-- 判断一个人是否可以装备或修炼一个物品
-- 返回 true可以修炼，false不可
function CanUseThing(id, personid)
    local str = ""
    -- 张家辉的专属装备
    if JY.Thing[id]["仅修炼人物"] == 651 then
        if personid == 0 and JY.Base["畅想"] == 651 then
            return true
        else
            return false
        end
    end
    -- if ZhongYongZD(personid) and (id == 118 or id == 235) then 
    -- return true
    -- end
    -- 武中无相，随便修炼秘籍
    if (match_ID(personid, 637) or match_ID(personid, 9900)) and JY.Thing[id]["类型"] == 2 then
        return true
        -- 丐帮帮主随便修炼打狗与降龙
    elseif match_ID(personid, 9936) and (id == 86 or id == 167) then
        return true
        -- 主角学圣火
    elseif id == 70 and personid == 0 then
        return true
        -- 阿朱穿装备
    elseif match_ID(personid, 104) and JY.Thing[id]["装备位置"] >= 0 then
        return true
        -- 白猿装备白猿
    elseif match_ID(personid, 185) and id == 326 then
        return true
        -- 无聊装备绣花针
    elseif match_ID(personid, 721) and id == 349 then
        Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
        if DrawStrBoxYesNo(-1, -1, "装备此物品需要自宫，是否继续装备?", C_WHITE, CC.DefaultFont) ==
            false then
            return 0
        else
            lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_RED, 128)
            ShowScreen()
            lib.Delay(80)
            lib.ShowSlow(15, 1)
            Cls()
            lib.ShowSlow(50, 0)
            JY.Person[personid]["性别"] = 2
            JY.Person[personid]["半身像"] = 721
            JY.Person[personid]["头像代号"] = 322
            JY.Person[personid]["出招动画帧数2"] = 16
            JY.Person[personid]["出招动画延迟2"] = 14
            JY.Person[personid]["武功音效延迟2"] = 14
            local add, str = AddPersonAttrib(personid, "攻击力", -20)
            DrawStrBoxWaitKey(JY.Person[personid]["姓名"] .. str, C_ORANGE, CC.DefaultFont)
            add, str = AddPersonAttrib(personid, "防御力", -30)
            DrawStrBoxWaitKey(JY.Person[personid]["姓名"] .. str, C_ORANGE, CC.DefaultFont)
            return true
        end
        -- 少林掌门无条件学少林武学 十三绝神僧
    elseif JY.Wugong[Thing_kf(id)]["门派"] == 1 and (match_ID(personid, 9897) or match_ID(personid, 576)) then
        return true
    elseif match_ID(personid, 505) and
        (JY.Wugong[Thing_kf(id)]["门派"] == 1 or JY.Wugong[Thing_kf(id)]["门派"] == 2) then
        return true
    elseif match_ID(personid, 9997) and JY.Wugong[Thing_kf(id)]["门派"] == 9 then
        return true
        -- 姑苏慕容无视兵器修炼斗转
    elseif match_ID(personid, 51) and id == 118 then
        return true
        -- 波斯圣女学乾坤大挪移
    elseif match_ID(personid, 18) and id == 70 then
        return true
    else
        if JY.Thing[id]["仅修炼人物"] >= 0 and JY.Thing[id]["仅修炼人物"] ~= personid and
            (personid == 0 and JY.Thing[id]["仅修炼人物"] == JY.Base["畅想"]) == false then
            return false
        end
        if JY.Thing[id]["需内力性质"] ~= 2 and JY.Person[personid]["内力性质"] ~= 2 and
            JY.Person[personid]["内力性质"] ~= 3 and JY.Thing[id]["需内力性质"] ~=
            JY.Person[personid]["内力性质"] then
            local cond = 1
            -- 天内可以无视阴阳学习 博通百家 大唐双龙之冰
            if match_ID(personid, 578) or match_ID(personid, 9987) or match_ID(personid, 9978) then
                cond = 2
                -- 丐帮帮主学降龙无视内力
            elseif id == 86 and personid == 9936 then
                cond = 2
                -- 丐帮帮主学打狗无视内力
            elseif id == 167 and personid == 9936 then
                cond = 2
            end
            if cond == 1 then
                return false
            end
        end
        if JY.Person[personid]["内力最大值"] < JY.Thing[id]["需内力"] then
            return false
        end
        if JY.Person[personid]["攻击力"] < JY.Thing[id]["需攻击力"] then
            return false
        end
        if JY.Person[personid]["轻功"] < JY.Thing[id]["需轻功"] then
            return false
        end
        if JY.Person[personid]["用毒能力"] < JY.Thing[id]["需用毒能力"] then
            return false
        end
        if JY.Person[personid]["医疗能力"] < JY.Thing[id]["需医疗能力"] then
            return false
        end
        -- 学有小无相功，兵器值视作+10点
        local lv = 0;
        if PersonKF(personid, 98) then
            lv = 10
            if match_ID(personid, 103) then
                lv = 20
            end
        end
        -- 博通百家
        if match_ID(personid, 9987) then
            lv = lv + 20
        end
        -- 有胡刀，学苗剑，需求-40
        if id == 117 and PersonKF(personid, 67) then
            lv = lv + 40
        end
        -- 有苗剑，学胡刀，需求-40
        if id == 136 and PersonKF(personid, 44) then
            lv = lv + 40
        end

        -- 桃花绝技，学习其中之一后，剩下两个的需求减少-10，可叠加
        if id == 95 or id == 101 or id == 123 then
            for i = 1, JY.Base["武功数量"] do
                if JY.Person[personid]["武功" .. i] == 12 or JY.Person[personid]["武功" .. i] == 18 or
                    JY.Person[personid]["武功" .. i] == 38 then
                    lv = lv + 10
                end
            end
        end
        -- 太极奥义，学习其中之一后，剩下需求减少-10
        if id == 97 or id == 115 then
            for i = 1, JY.Base["武功数量"] do
                if JY.Person[personid]["武功" .. i] == 46 or JY.Person[personid]["武功" .. i] == 16 then
                    lv = lv + 10
                end
            end
        end
        -- 金刚般若-40
        if id == 291 or id == 90 or id == 324 then
            for i = 1, JY.Base["武功数量"] do
                if JY.Person[personid]["武功" .. i] == 46 or JY.Person[personid]["武功" .. i] == 16 then
                    lv = lv + 10
                end
            end
        end
        -- 有打狗，学降龙-40
        if id == 86 and PersonKF(personid, 80) then
            if PersonKF(personid, 204) then
                lv = lv + 60
            else
                lv = lv + 40
            end
        end
        -- 有降龙，学打狗-40
        if id == 167 and PersonKF(personid, 26) then
            if PersonKF(personid, 204) then
                lv = lv + 60
            else
                lv = lv + 40
            end
        end

        -- 有九剑，学持瑶琴-40
        if id == 180 and PersonKF(personid, 47) then
            lv = lv + 40
        end
        -- 有持瑶琴，学九剑-40
        if id == 114 and PersonKF(personid, 73) then
            lv = lv + 40
        end

        -- 有岳家枪，学岳家散手-40
        if id == 337 and PersonKF(personid, 200) then
            lv = lv + 40
        end
        -- 有岳家散手，学岳家枪-40
        if id == 386 and PersonKF(personid, 198) then
            lv = lv + 40
        end
        local xqz = JY.Thing[id]["需拳掌功夫"]
        local xzf = JY.Thing[id]["需指法技巧"]
        local xyj = JY.Thing[id]["需御剑能力"]
        local xsd = JY.Thing[id]["需耍刀技巧"]
        local xts = JY.Thing[id]["需特殊兵器"]
        local xaq = JY.Thing[id]["需暗器技巧"]
        local wugong = JY.Thing[id]["练出武功"];
        -- if wugong >= 0 then
        --	local wugonglv = JY.Wugong[wugong]["层级"]
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
        if JY.Person[personid]["拳掌功夫"] + lv < xqz then
            return false
        end
        if JY.Person[personid]["指法技巧"] + lv < xzf then
            return false
        end
        if JY.Person[personid]["御剑能力"] + lv < xyj then
            return false
        end
        if JY.Person[personid]["耍刀技巧"] + lv < xsd then
            return false
        end
        if JY.Person[personid]["特殊兵器"] + lv < xts then
            return false
        end

        if JY.Person[personid]["暗器技巧"] < xaq then
            return false
        end

        if id == 372 then
            if JY.Person[personid]["资质"] < 31 or JY.Person[personid]["资质"] > 79 then
                return false
            end
        end

        if JY.Thing[id]["需资质"] >= 0 then
            if JY.Thing[id]["需资质"] > JY.Person[personid]["资质"] then
                return false;
            end
        else
            if -JY.Thing[id]["需资质"] < JY.Person[personid]["资质"] then
                return false;
            end
        end

    end

    -- 斗转限制
    if id == 118 then
        local R = JY.Person[personid]
        local wp = R["拳掌功夫"] + R["指法技巧"] + R["御剑能力"] + R["耍刀技巧"] + R["特殊兵器"]
        if wp < 120 then
            return false
        end
    end
    -- 阴阳限制
    if id == 176 then
        local R = JY.Person[personid]
        if R["御剑能力"] >= 70 then
            return true
        elseif R["耍刀技巧"] >= 70 then
            return true
        elseif R["特殊兵器"] >= 70 then
            return true
        else
            return false
        end
    end
    -- 绣花针
    if id == 349 then
        -- local R = JY.Person[personid]
        if match_ID(personid, 27) then
            return true
        else
            return false
        end
    end
    -- 鸳刀
    if id == 217 then
        local R = JY.Person[personid]
        if R["性别"] == 0 then
            return true
        else
            return false
        end
    end
    -- 鸯刀
    if id == 218 then
        local R = JY.Person[personid]
        if R["性别"] == 1 then
            return true
        else
            return false
        end
    end
    -- 金丝手套限制
    if id == 239 then
        local R = JY.Person[personid]
        if R["拳掌功夫"] >= 70 then
            return true
        elseif R["指法技巧"] >= 70 then
            return true
        else
            return false
        end
    end
    -- 七宝指环限制
    if id == 200 then
        local R = JY.Person[personid]
        if R["拳掌功夫"] >= 200 then
            return true
        elseif R["指法技巧"] >= 200 then
            return true
        else
            return false
        end
    end
    return true
end

-- 药品使用实际效果
-- id 物品id，
-- personid 使用人id
-- 返回值：0 使用没有效果，物品数量应该不变。1 使用有效果，则使用后物品数量应该-1
function UseThingEffect(id, personid, amount)
    -- 无使用数量则默认为使用1个
    if amount == nil then
        amount = 1
    end

    -- 特殊药品
    -- 天内丹
    if id == 343 then
        Cls() -- 清屏
        local k = JY.Wugong;
        local menu = {}

        local kftype = LGMsgBox("请选择", "请选择喜欢的天赋内功类型", {"内功"}, 1, 347, 1)

        for i = 1, JY.WugongNum - 1 do
            local kfname = k[i]["名称"]
            if string.len(kfname) == 8 then
                kfname = kfname .. "  "
            elseif string.len(kfname) == 6 then
                kfname = kfname .. "    "
            elseif string.len(kfname) == 4 then
                kfname = kfname .. "      "
            end
            menu[i] = {kfname, nil, 2}
            if k[i]["武功类型"] == 6 then
                menu[i][3] = 1
            end
        end
        local nexty = CC.ScreenH / 2 - CC.DefaultFont * 4 + CC.SingleLineHeight
        local r = ShowMenu2(menu, #menu, 4, 8, CC.ScreenW / 2 - CC.DefaultFont * 10 - 20, nexty, 0, 0, 1, 1,
            CC.DefaultFont, C_ORANGE, C_WHITE, "领悟天赋内功")
        if r > 0 then
            SetTianNei(personid, r)
        end
        return 2
        -- 天轻丹		
    elseif id == 344 then
        Cls() -- 清屏
        local k = JY.Wugong;
        local menu = {}

        local kftype = LGMsgBox("请选择", "请选择喜欢的天赋轻功类型", {"轻功"}, 1, 347)

        for i = 1, JY.WugongNum - 1 do
            local kfname = k[i]["名称"]
            if string.len(kfname) == 8 then
                kfname = kfname .. "  "
            elseif string.len(kfname) == 6 then
                kfname = kfname .. "    "
            elseif string.len(kfname) == 4 then
                kfname = kfname .. "      "
            end
            menu[i] = {kfname, nil, 2}
            if k[i]["武功类型"] == 7 then
                menu[i][3] = 1
            end
        end
        local nexty = CC.ScreenH / 2 - CC.DefaultFont * 4 + CC.SingleLineHeight
        local r = ShowMenu2(menu, #menu, 4, 8, CC.ScreenW / 2 - CC.DefaultFont * 10 - 20, nexty, 0, 0, 1, 1,
            CC.DefaultFont, C_ORANGE, C_WHITE, "领悟天赋轻功")

        if r > 0 then
            SetTianQing(personid, r)
        end
        return 2
        -- 天外丹	
    elseif id == 345 then
        Cls() -- 清屏
        local k = JY.Wugong;
        local menu = {}
        local kftype = LGMsgBox("请选择", "请选择喜欢的天赋外功类型",
            {"拳法", "指法", "剑法", "刀法", "奇门"}, 5, 347)

        for i = 1, JY.WugongNum - 1 do
            local kfname = k[i]["名称"]
            if string.len(kfname) == 8 then
                kfname = kfname .. "  "
            elseif string.len(kfname) == 6 then
                kfname = kfname .. "    "
            elseif string.len(kfname) == 4 then
                kfname = kfname .. "      "
            end
            menu[i] = {kfname, nil, 2}
            if k[i]["武功类型"] == kftype then
                menu[i][3] = 1
            end
        end
        local nexty = CC.ScreenH / 2 - CC.DefaultFont * 4 + CC.SingleLineHeight
        local r = ShowMenu2(menu, #menu, 4, 8, CC.ScreenW / 2 - CC.DefaultFont * 10 - 20, nexty, 0, 0, 1, 1,
            CC.DefaultFont, C_ORANGE, C_WHITE, "领悟天赋外功")

        if r > 0 then
            local R = LGMsgBox("请选择", "请谨慎选择领悟的天赋外功位置。",
                {"天赋外功一", "天赋外功二"}, 2, 596)
            if R == 1 then
                if JY.Person[personid]["天赋外功2"] ~= r then
                    SetTianWai(personid, 1, r)
                else
                    DrawStrBoxWaitKey("天赋外功不可重复。", C_ORANGE, CC.DefaultFont)
                    Cls()
                    instruct_2(345, 1)
                end
            elseif R == 2 then
                if JY.Person[personid]["天赋外功1"] ~= r then
                    SetTianWai(personid, 2, r)
                else
                    DrawStrBoxWaitKey("天赋外功不可重复。", C_ORANGE, CC.DefaultFont)
                    Cls()
                    instruct_2(345, 1)
                end
            end
        end

        return 2
        -- 易容丹（四大山）	
    elseif id == 346 then
        Cls() -- 清屏
        JY.Person[0]["头像代号"] = JY.Person[642]["头像代号"]
        JY.Person[0]["半身像"] = JY.Person[642]["半身像"]
        JY.Person[0]["姓名"] = JY.Person[642]["姓名"]
        for i = 1, 5 do
            JY.Person[0]["出招动画帧数" .. i] = JY.Person[642]["出招动画帧数" .. i]
            JY.Person[0]["出招动画延迟" .. i] = JY.Person[642]["出招动画延迟" .. i]
            JY.Person[0]["武功音效延迟" .. i] = JY.Person[642]["武功音效延迟" .. i]
        end
        return 2
    elseif id == 348 then
        instruct_70(personid)
        return 2
    else
        local str = {}
        str[0] = string.format("使用 %s × %d", JY.Thing[id]["名称"], amount)
        local strnum = 1
        local addvalue = nil
        if JY.Thing[id]["加生命"] > 0 then
            local add = JY.Thing[id]["加生命"]
            local smmax = JY.Person[personid]["生命最大值"]

            if id == 0 or id == 1 or id == 2 or id == 7 or id == 8 then
                add = add + math.modf(JY.Thing[id]["加生命"] / 1000 * JY.Person[personid]["生命最大值"])
            end
            -- lib.Debug(JY.Thing[id]['名称']..'生命最大值'..smmax..'回血量'..add)
            add = math.modf(add - add * JY.Person[personid]["受伤程度"] / 200) + Rnd(5)
            -- 满实战增加50%吃药效果
            add = add + math.modf(JY.Person[personid]['实战'] / 1000 * add)
            -- 胡青牛在队，吃药效果为1.3倍
            if JY.Status == GAME_WMAP and inteam(personid) and (inteam(16) or JY.Base["畅想"] == 16) then
                for w = 0, WAR.PersonNum - 1 do
                    if match_ID(WAR.Person[w]["人物编号"], 16) and WAR.Person[w]["死亡"] == false and
                        WAR.Person[w]["我方"] then
                        add = math.modf(add * 1.3)
                        break
                    end
                end
            end
            if add <= 0 then
                add = 5 + Rnd(5)
            end
            add = math.modf(add)
            lib.Debug(JY.Thing[id]['名称'] .. '加血量' .. add)
            -- 洪安通，敌人吃药不加血反而减血
            if JY.Status == GAME_WMAP then
                for w = 0, WAR.PersonNum - 1 do
                    if (match_ID(WAR.Person[w]["人物编号"], 9846) or match_ID(WAR.Person[w]["人物编号"], 9846)) and
                        WAR.Person[w]["死亡"] == false and WAR.Person[w]["我方"] ~= WAR.Person[WAR.CurID]["我方"] then
                        add = -add
                        break
                    end
                end
            end

            -- 敌人吃药效果加倍
            if not inteam(personid) then
                -- add = add * 2;
            end
            -- 实战后吃药效果加倍
            if inteam(personid) and JY.Person[0]["实战"] >= 500 then
                add = add * 1.1;
            end
            -- 妙手仁心
            if match_ID(personid, 9943) then
                add = add * 2;
            end
            if JY.Status == GAME_WMAP then
                WAR.Person[WAR.CurID]["内伤点数"] = AddPersonAttrib(personid, "受伤程度", -math.modf(add / 8))
            end

            addvalue, str[strnum] = AddPersonAttrib(personid, "生命", add * amount)

            -- 蓝烟清：显示生命点数
            if JY.Status == GAME_WMAP then
                WAR.Person[WAR.CurID]["生命点数"] = addvalue;
            end
            if addvalue ~= 0 then
                strnum = strnum + 1
            end
        end
        local function ThingAddAttrib(s)
            if JY.Thing[id]["加" .. s] ~= 0 then
                addvalue, str[strnum] = AddPersonAttrib(personid, s, JY.Thing[id]["加" .. s] * amount)
                if addvalue ~= 0 then
                    strnum = strnum + 1
                end
                -- 蓝烟清：显示体力，内力点数
                if JY.Status == GAME_WMAP then
                    if s == "体力" then
                        WAR.Person[WAR.CurID]["体力点数"] = addvalue;
                    elseif s == "内力" then
                        WAR.Person[WAR.CurID]["内力点数"] = addvalue;
                    end
                end
            end
        end
        ThingAddAttrib("生命最大值")
        if JY.Thing[id]["加中毒解毒"] < 0 then
            addvalue, str[strnum] = AddPersonAttrib(personid, "中毒程度",
                math.modf(JY.Thing[id]["加中毒解毒"] / 2) * amount)
            if addvalue ~= 0 then
                strnum = strnum + 1
            end
            -- 蓝烟清：显示中解毒点数
            if JY.Status == GAME_WMAP then
                if addvalue < 0 then
                    WAR.Person[WAR.CurID]["解毒点数"] = -addvalue;
                elseif addvalue > 0 then
                    WAR.Person[WAR.CurID]["中毒点数"] = addvalue;
                end
            end
        end
        ThingAddAttrib("体力")
        if JY.Thing[id]["改变内力性质"] == 2 then
            str[strnum] = "内力门路改为阴阳合一"
            strnum = strnum + 1
        end
        ---
        if JY.Status == GAME_WMAP then
            if id == 25 then
                JY.Person[personid]['受伤程度'] = 0
                JY.Person[personid]['中毒程度'] = 0
                JY.Person[personid]['灼烧程度'] = 0
                JY.Person[personid]['冰封程度'] = 0
                WAR.FXDS[personid] = nil
                WAR.LXZT[personid] = nil
                WAR.PD['五宝花蜜酒'][personid] = 100
            end
            if id == 24 then
                if WAR.LXZT[personid] ~= nil then
                    WAR.LXZT[personid] = WAR.LXZT[personid] - 50
                    if WAR.LXZT[personid] < 1 then
                        WAR.LXZT[personid] = nil
                    end
                end
                WAR.PD['即墨老酒'][personid] = 100
            end

            if id == 23 then
                AddPersonAttrib(personid, '灼烧程度', -20)
                WAR.PD['玉露酒'][personid] = 50
            end

            if id == 22 then
                AddPersonAttrib(personid, '冰封程度', -50)
                WAR.PD['梨花酒'][personid] = 50
            end

            if id == 11 then
                WAR.PD['六阳正气'][personid] = 1
            end

            if id == 10 then
                WAR.PD['牛黄血蝎'][personid] = 50
            end

            if id == 9 then
                WAR.PD['黄连解毒'][personid] = 50
            end

            if id == 3 then
                WAR.PD['白云熊胆'][personid] = 200
            end

            if id == 8 then
                WAR.PD['天王护命'][personid] = 100
            end

            if id == 0 then
                WAR.PD['小还丹'][personid] = 50
            end
        else
            if id == 25 then
                JY.Person[personid]['受伤程度'] = 0
                JY.Person[personid]['中毒程度'] = 0
                JY.Person[personid]['灼烧程度'] = 0
                JY.Person[personid]['冰封程度'] = 0
            end
        end

        ThingAddAttrib("内力")
        ThingAddAttrib("内力最大值")
        ThingAddAttrib("攻击力")
        ThingAddAttrib("防御力")
        ThingAddAttrib("轻功")
        ThingAddAttrib("医疗能力")
        ThingAddAttrib("用毒能力")
        ThingAddAttrib("解毒能力")
        ThingAddAttrib("抗毒能力")
        ThingAddAttrib("拳掌功夫")
        ThingAddAttrib("御剑能力")
        ThingAddAttrib("耍刀技巧")
        ThingAddAttrib("特殊兵器")
        ThingAddAttrib("暗器技巧")
        ThingAddAttrib("武学常识")
        ThingAddAttrib("攻击带毒")

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
                -- 显示使用物品文字
                DrawString(CC.MainMenuX, CC.ScreenH - (strnum + 2) * CC.Fontsmall,
                    JY.Person[WAR.Person[WAR.CurID]["人物编号"]]["姓名"] .. " " .. str[0], C_WHITE, CC.Fontsmall);
                for i = 1, strnum - 1 do
                    DrawString(CC.MainMenuX, CC.ScreenH + (i - strnum - 2) * CC.Fontsmall, str[i], C_WHITE, CC.Fontsmall);
                end

                ShowScreen()
                -- 显示点数
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

-- 装备物品
function UseThing_Type1(id)
    DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, string.format("谁要配备%s?", JY.Thing[id]["名称"]), C_WHITE,
        CC.DefaultFont)
    local nexty = CC.MainSubMenuY + CC.SingleLineHeight
    local r = SelectTeamMenu(CC.MainSubMenuX, nexty)
    local pp1, pp2 = 0, 0
    if r > 0 then
        local personid = JY.Base["队伍" .. r]
        -- 田归农装闯王军刀
        if id == 202 and match_ID(personid, 72) then
            say("嘿嘿，这口宝刀本来就是田掌门的兵器，谁说耍刀不够就装不了？", 72, 0)
            if JY.Thing[id]["使用人"] >= 0 then

                JY.Person[JY.Thing[id]["使用人"]]["武器"] = -1
            end
            if JY.Person[personid]["武器"] >= 0 then
                JY.Thing[JY.Person[personid]["武器"]]["使用人"] = -1
            end
            JY.Person[personid]["武器"] = id
            JY.Thing[id]["使用人"] = personid
            return 1
        end

        if CanUseThing(id, personid) then
            if JY.Thing[id]["装备位置"] == 0 then
                if JY.Thing[id]["使用人"] >= 0 then

                    JY.Person[JY.Thing[id]["使用人"]]["武器"] = -1
                end
                if JY.Person[personid]["武器"] >= 0 then
                    JY.Thing[JY.Person[personid]["武器"]]["使用人"] = -1
                end
                JY.Person[personid]["武器"] = id

            elseif JY.Thing[id]["装备位置"] == 1 then
                if JY.Thing[id]["使用人"] >= 0 then

                    JY.Person[JY.Thing[id]["使用人"]]["防具"] = -1
                end
                if JY.Person[personid]["防具"] >= 0 then
                    JY.Thing[JY.Person[personid]["防具"]]["使用人"] = -1
                end
                JY.Person[personid]["防具"] = id
            elseif JY.Thing[id]["装备位置"] == 2 then
                if JY.Thing[id]["使用人"] >= 0 then

                    JY.Person[JY.Thing[id]["使用人"]]["坐骑"] = -1
                end
                if JY.Person[personid]["坐骑"] >= 0 then
                    JY.Thing[JY.Person[personid]["坐骑"]]["使用人"] = -1
                end
                JY.Person[personid]["坐骑"] = id

            end
            JY.Thing[id]["使用人"] = personid
        else
            DrawStrBoxWaitKey("此人不适合配备此物品", C_WHITE, CC.DefaultFont)
            return 0
        end
    end
    return 1
end

function UseThing_Type2(id)
    local wugongid = 0
    if JY.Thing[id]["练出武功"] >= 0 then
        wugongid = JY.Thing[id]["练出武功"]
    end
    local R = LGMsgBox("请选择", "请选择需要的操作", {"修炼", "查看"}, 2, 0, 1)
    if R == 2 then
        if JY.Thing[id]["练出武功"] >= 0 then
            KF_sm(0, Thing_kf(id))
            return MJMenu()
        end
    else
        if JY.Thing[id]["使用人"] >= 0 and
            DrawStrBoxYesNo(-1, -1, "此物品已经有人修炼，是否换人修炼?", C_WHITE, CC.DefaultFont) ==
            false then
            Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
            ShowScreen()
            return 0
        end
        Cls()
        DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, string.format("谁要修炼%s?", JY.Thing[id]["名称"]), C_WHITE, CC.DefaultFont)
        local nexty = CC.MainSubMenuY + CC.SingleLineHeight
        local r = SelectTeamMenu(CC.MainSubMenuX, nexty)

        local oldmiji = 0
        if r > 0 then
            local personid = JY.Base["队伍" .. r]
            local yes, full, yes1, full1 = nil, nil, nil, nil
            if JY.Thing[id]["练出武功"] >= 0 then
                yes = 0
                full = 1
                wugongid = JY.Thing[id]["练出武功"]
                for i = 1, JY.Base["武功数量"] do
                    if JY.Person[personid]["武功" .. i] == JY.Thing[id]["练出武功"] then
                        yes = 1
                    else
                        if JY.Person[personid]["武功" .. i] == 0 then
                            full = 0
                        end
                    end
                end
            end
            if JY.Thing[id]["练出秘技"] >= 1 or id == 372 then
                yes1 = 0
                full1 = 1
                for i = 1, 5 do
                    if JY.Person[personid]["秘技" .. i] == JY.Thing[id]["练出秘技"] then
                        yes1 = 1
                    else
                        if JY.Person[id]["秘技" .. i] == 0 then
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

-- 无酒不欢；使用药品和食品
function UseThing_Type3(id)
    local usepersonid = -1
    local amount_use = 0
    Cls()
    if JY.Status == GAME_MMAP or JY.Status == GAME_SMAP then
        DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, string.format("谁要使用%s?", JY.Thing[id]["名称"]), C_WHITE,
            CC.DefaultFont)
        local nexty = CC.MainSubMenuY + CC.SingleLineHeight
        local r = SelectTeamMenu(CC.MainSubMenuX, nexty)
        if r > 0 then
            usepersonid = JY.Base["队伍" .. r]
            -- 非战斗中可以批量使用
            local max_amount = 0
            for i = 1, CC.MyThingNum do
                if JY.Base["物品" .. i] == id then
                    max_amount = JY.Base["物品数量" .. i]
                    break
                end
            end
            -- 特殊药品不批量使用
            local tsyp = {343, 344, 345, 348}
            for i = 1, #tsyp do

            end
            if max_amount > 1 then
                amount_use = InputNum("使用数量", 1, max_amount)
            else
                amount_use = 1
            end
        end
        -- 战斗中
    elseif JY.Status == GAME_WMAP then
        -- 胡青牛可以向队友用药
        if match_ID(WAR.Person[WAR.CurID]["人物编号"], 16) then
            War_CalMoveStep(WAR.CurID, 8, 1)
            local x, y = War_SelectMove()
            if x ~= nil then
                local emeny = GetWarMap(x, y, 2)
                if emeny >= 0 and WAR.Person[WAR.CurID]["我方"] == WAR.Person[emeny]["我方"] then
                    usepersonid = WAR.Person[emeny]["人物编号"]
                end
            end
        else
            usepersonid = WAR.Person[WAR.CurID]["人物编号"]
        end
    end
    -- 战斗中不可使用加血内上限的物品
    if JY.Status == GAME_WMAP and (id >= 14 and id <= 21) then
        return 0
    end

    if usepersonid >= 0 then
        -- 非战斗下使用物品
        if JY.Status == GAME_MMAP or JY.Status == GAME_SMAP then

            local r = UseThingEffect(id, usepersonid, amount_use)
            if r == 1 then
                instruct_32(id, -amount_use)
                WaitKey()
            elseif r == 2 then
                instruct_32(id, -amount_use)
            end

            -- 地灵丹
            if id == 316 then
                JY.Thing[316]['加武学常识'] = 0
                JY.Thing[316]['物品说明'] = '可改变内力性质'
                local menu = {'阴性', '阳性', '调和'}
                local R = LGMsgBox("选择", " 需要把内力改变成？", menu, #menu, usepersonid)
                if R == 1 then
                    JY.Person[usepersonid]["内力性质"] = 0
                elseif R == 2 then
                    JY.Person[usepersonid]["内力性质"] = 1
                elseif R == 3 then
                    JY.Person[usepersonid]["内力性质"] = 2
                end
            end
            -- 千年灵芝
            if id == 14 then
                local n = amount_use
                -- JY.Person[usepersonid]["体质"] = JY.Person[usepersonid]["体质"]+amount_use				
                Add(usepersonid, '体质', amount_use)
                -- Add(usepersonid,'基础生命',amount_use*100)
                DrawStrBoxWaitKey(JY.Person[usepersonid]["姓名"] .. "体质增长" .. amount_use .. "点", C_ORANGE,
                    CC.DefaultFont)
                Hp_Max(usepersonid)
            end
            -- 千年人参
            if id == 16 then
                local n = math.random(3) * amount_use
                if n == 1 then
                    -- JY.Person[usepersonid]["攻击力"] = JY.Person[usepersonid]["攻击力"] + 10 
                    Add(usepersonid, '攻击力', 10)
                elseif n == 2 then
                    -- JY.Person[usepersonid]["防御力"] = JY.Person[usepersonid]["防御力"] + 10
                    Add(usepersonid, '防御力', 10)
                else
                    -- JY.Person[usepersonid]["轻功"] = JY.Person[usepersonid]["轻功"] + 10
                    Add(usepersonid, '轻功', 10)
                end
                local nm = {'攻击力', '防御力', '轻功'}
                DrawStrBoxWaitKey(JY.Person[usepersonid]["姓名"] .. nm[n] .. "10点", C_ORANGE, CC.DefaultFont)
            end
            -- 天山雪莲
            if id == 17 then
                -- JY.Person[usepersonid]['基础生命'] = JY.Person[usepersonid]['基础生命']+200
                local n = 100 * amount_use
                Add(usepersonid, '基础生命', n)
                -- Hp_Max(usepersonid)
                DrawStrBoxWaitKey(JY.Person[usepersonid]["姓名"] .. "生命增加" .. n .. "点", C_ORANGE,
                    CC.DefaultFont)
                -- Hp_Max(usepersonid)
            end
            -- 叫化鸡
            if id == 18 then
                -- JY.Person[usepersonid]['基础生命'] = JY.Person[usepersonid]['基础生命']+200
                local n = 20 * amount_use
                Add(usepersonid, '基础生命', n)
                DrawStrBoxWaitKey(JY.Person[usepersonid]["姓名"] .. "生命增加" .. n .. "点", C_ORANGE,
                    CC.DefaultFont)
                -- Hp_Max(usepersonid)
            end
            -- 玉笛谁家听落梅
            if id == 20 then
                -- JY.Person[usepersonid]['基础生命'] = JY.Person[usepersonid]['基础生命']+200
                local n = 50 * amount_use
                Add(usepersonid, '基础生命', n)
                DrawStrBoxWaitKey(JY.Person[usepersonid]["姓名"] .. "生命增加" .. n .. "点", C_ORANGE,
                    CC.DefaultFont)
                Hp_Max(usepersonid)
            end

            -- 战斗中使用物品
        elseif JY.Status == GAME_WMAP then
            if UseThingEffect(id, usepersonid) == 1 then
                instruct_32(id, -1)
                if id >= 22 and id <= 25 and match_ID(usepersonid, 9965) then
                    WAR.PD['八酒杯'][usepersonid] = (WAR.PD['八酒杯'][usepersonid] or 0) + 1
                    WAR.PD['回气'][usepersonid] = (WAR.PD['回气'][usepersonid] or 0) + 500
                    CurIDTXDH(WAR.CurID, 79, 1, "酒神·八酒杯", C_ORANGE);
                end
                -- 补血药品改成补充百分比
                -- 黑玉
                if id == 0 or id == 1 or id == 2 or id == 7 or id == 8 then
                    local heal_amount = JY.Thing[id]['加生命']
                    -- heal_amount = heal_amount + math.modf(JY.Thing[id]['加生命']/1000*JY.Person[usepersonid]['生命最大值'])
                    -- AddPersonAttrib(id, "生命", heal_amount)
                end
            end
        end
    else
        return 0
    end
    return 1
end

-- 暗器物品
function UseThing_Type4(id)
    if JY.Status == GAME_WMAP then
        return War_UseAnqi(id)
    end
    return 0
end

--------------------------------------------------------------------------------
--------------------------------------事件调用-----------------------------------

-- 事件调用主入口
-- id，d*中的编号
-- flag 1 空格触发，2，物品触发，3，路过触发
function EventExecute(id, flag)
    JY.CurrentD = id;

    oldEventExecute(flag)

    JY.CurrentD = -1;
end

-- 调用原有的指定位置的函数
-- 旧的函数名字格式为  oldevent_xxx();  xxx为事件编号
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
    if newkdef[eventnum] ~= nil then -- 首先判断这个事件编号是否存在
        lib.Debug("new kdef " .. eventnum) -- 如果存在，在执行事件前，在debug文本里打印出  new kdef +事件标号，以便调试时使用
        if eventnum > 0 then -- 如果事件编号大于0
            newkdef[eventnum]() -- 执行该事件
        end
    end
end

-- 改变大地图坐标，从场景出去后移动到相应坐标
function ChangeMMap(x, y, direct) -- 改变大地图坐标
    JY.Base["人X"] = x;
    JY.Base["人Y"] = y;
    JY.Base["人方向"] = direct;
end

-- 改变当前场景
function ChangeSMap(sceneid, x, y, direct) -- 改变当前场景
    JY.SubScene = sceneid;
    JY.Base["人X1"] = x;
    JY.Base["人Y1"] = y;
    JY.Base["人方向"] = direct;
end

-- 清除(x1,y1)-(x2,y2)矩形内的文字等。
-- 如果没有参数，则清除整个屏幕表面
-- 注意该函数并不直接刷新显示屏幕
function Cls(x1, y1, x2, y2) -- 清除屏幕
    if x1 == nil then -- 第一个参数为nil,表示没有参数，用缺省
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
        if CC.TX['夜幕'] == 1 then
            --sc = 6
        end
        lib.DrawMMap(JY.Base["人X"], JY.Base["人Y"], GetMyPic(), sc); -- 显示主地图
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

-- 产生对话显示需要的字符串，即每隔n个中文字符加一个星号
function GenTalkString(str, n) -- 产生对话显示需要的字符串
    local tmpstr = "";
    for s in string.gmatch(str .. "*", "(.-)%*") do -- 去掉对话中的所有*. 字符串尾部加一个星号，避免无法匹配
        tmpstr = tmpstr .. s;
    end

    local newstr = "";
    while #tmpstr > 0 do
        local w = 0;
        while w < #tmpstr do
            local v = string.byte(tmpstr, w + 1); -- 当前字符的值
            if v >= 128 then
                w = w + 2;
            else
                w = w + 1;
            end
            if w >= 2 * n - 1 then -- 为了避免跨段中文字符
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

-- 个人新对话
function TalkEx(s, pid, flag, name)
    say(s, pid, flag, name)
end

-- 测试指令，占位置用
function instruct_test(s)
    DrawStrBoxWaitKey(s, C_ORANGE, 24);
end

-- 清屏
function instruct_0() -- 清屏
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

-- 对话
-- talkid: 为数字，则为对话编号；为字符串，则为对话本身。
-- headid: 头像id
-- flag :对话框位置：0 屏幕上方显示, 左边头像，右边对话
--            1 屏幕下方显示, 左边对话，右边头像
--            2 屏幕上方显示, 左边空，右边对话
--            3 屏幕下方显示, 左边对话，右边空
--            4 屏幕上方显示, 左边对话，右边头像
--            5 屏幕下方显示, 左边头像，右边对话
function instruct_1(talkid, headid, flag)
    local s = ReadTalk(talkid)
    if s == nil then
        return
    end
    TalkEx(s, headid, flag)
end

-- 得到物品
function instruct_2(thingid, num)
    if JY.Thing[thingid] == nil then
        return
    end
    instruct_32(thingid, num)
    if num > 0 then
        local name = 0
        -- DrawStrBoxWaitKey(string.format("得到物品%sX%d", "【Ｇ"..JY.Thing[thingid]["名称"].."Ｏ】", num), C_ORANGE, CC.DefaultFont, 1)
        if JY.Thing[thingid]["练出武功"] > 0 then
            if JY.Wugong[JY.Thing[thingid]["练出武功"]]["层级"] == 3 then
                name = "Ｒ" .. JY.Thing[thingid]["名称"] .. "X" .. num
            elseif JY.Wugong[JY.Thing[thingid]["练出武功"]]["层级"] == 2 then
                name = "Ｄ" .. JY.Thing[thingid]["名称"] .. "X" .. num
            elseif JY.Wugong[JY.Thing[thingid]["练出武功"]]["层级"] == 1 then
                name = "Ｌ" .. JY.Thing[thingid]["名称"] .. "X" .. num
            else
                name = "Ｇ" .. JY.Thing[thingid]["名称"] .. "X" .. num
            end
        else
            name = "Ｇ" .. JY.Thing[thingid]["名称"] .. "X" .. num
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
        if JY.Thing[thingid]["练出武功"] > 0 then
            if JY.Wugong[JY.Thing[thingid]["练出武功"]]["层级"] == 3 then
                name = "Ｒ" .. JY.Thing[thingid]["名称"] .. "X" .. -num
            elseif JY.Wugong[JY.Thing[thingid]["练出武功"]]["层级"] == 2 then
                name = "Ｄ" .. JY.Thing[thingid]["名称"] .. "X" .. -num
            elseif JY.Wugong[JY.Thing[thingid]["练出武功"]]["层级"] == 1 then
                name = "Ｌ" .. JY.Thing[thingid]["名称"] .. "X" .. -num
            else
                name = "Ｇ" .. JY.Thing[thingid]["名称"] .. "X" .. -num
            end
        else
            name = "Ｇ" .. JY.Thing[thingid]["名称"] .. "X" .. -num
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

-- 修改指定场景坐标的事件
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
    return DrawStrBoxYesNo(-1, -1, "是否与之过招(Y/N)?", C_ORANGE, CC.DefaultFont)
end

function instruct_6(warid, tmp, tmp1, flag)
    return WarMain(warid, flag)
end

function instruct_7()
    instruct_test("指令7测试")
end

function instruct_8(musicid)
    JY.MmapMusic = musicid
end

function instruct_9()
    return DrawStrBoxYesNo(-1, -1, "是否要求加入(Y/N)?", C_ORANGE, CC.DefaultFont)
end

-- 入队函数
function instruct_10(personid)
    if JY.Person[personid] == nil then
        lib.Debug("instruct_10 error: person id not exist")
        return
    end
    local add = 0
    -- 无酒不欢：畅想不能收自己
    if personid ~= JY.Base["畅想"] then
        for i = 2, CC.TeamNum do
            if JY.Base["队伍" .. i] < 0 then
                JY.Base["队伍" .. i] = personid
                add = 1
                break
            end
        end
    end
    for i = 1, 4 do
        local id = JY.Person[personid]["携带物品" .. i]
        local n = JY.Person[personid]["携带物品数量" .. i]
        if n < 0 then
            n = 0
        end
        if id >= 0 and n > 0 then
            instruct_2(id, n)
            JY.Person[personid]["携带物品" .. i] = -1
            JY.Person[personid]["携带物品数量" .. i] = 0
        end
    end

    if add == 0 then
        lib.Debug("instruct_10 error: 加入队伍已满")
        return
    end
end

function instruct_11()
    return DrawStrBoxYesNo(-1, -1, "是否(Y/N)?", C_ORANGE, CC.DefaultFont)
end

-- 休息
function instruct_12(flag)
    for i = 1, CC.TeamNum do
        local id = JY.Base["队伍" .. i]
        if id >= 0 then
            JY.Person[id]["受伤程度"] = 0
            JY.Person[id]["中毒程度"] = 0
            AddPersonAttrib(id, "体力", math.huge)
            AddPersonAttrib(id, "生命", math.huge)
            AddPersonAttrib(id, "内力", math.huge)
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
    DrawString(CC.GameOverX, CC.GameOverY, JY.Person[0]["姓名"], RGB(0, 0, 0), CC.DefaultFont)
    local x = CC.ScreenW - 9 * CC.DefaultFont
    DrawString(x, 10, os.date("%Y-%m-%d %H:%M"), RGB(216, 20, 24), CC.DefaultFont)
    DrawString(x, 10 + CC.DefaultFont + CC.RowPixel, "在地球的某处", RGB(216, 20, 24), CC.DefaultFont)
    DrawString(x, 10 + (CC.DefaultFont + CC.RowPixel) * 2, "当地人口的失踪数", RGB(216, 20, 24), CC.DefaultFont)
    DrawString(x, 10 + (CC.DefaultFont + CC.RowPixel) * 3, "又多了一笔。。。", RGB(216, 20, 24), CC.DefaultFont)
    local loadMenu = {{"选择读档", nil, 1}, {"回家睡觉去", nil, 1}}
    local y = CC.ScreenH - 4 * (CC.DefaultFont + CC.RowPixel) - 10
    local sl = ShowMenu(loadMenu, #loadMenu, 0, x, y, 0, 0, 0, 0, CC.DefaultFont, C_ORANGE, C_WHITE)
    if sl == 1 then
        local r = SaveList();
        if r < 1 then
            JY.Status = GAME_END
            return 0;
        end

        Cls();
        DrawString(CC.MainSubMenuX2, CC.MainSubMenuY, "请稍候......", C_WHITE, CC.DefaultFont, CC.FONT2)
        ShowScreen();
        local result = LoadRecord(r);
        if result ~= nil then
            instruct_15();
            return 0;
        end
        if JY.Base["无用"] ~= -1 then
            JY.Status = GAME_SMAP
            JY.SubScene = JY.Base["无用"]
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
    local xwperson; -- 判定人物
    -- 非战斗中才生效，用于触发剧情等判定
    if personid == JY.Base["畅想"] and JY.Status ~= GAME_WMAP then
        xwperson = 0
    else
        xwperson = personid
    end
    for i = 1, CC.TeamNum do
        if xwperson == JY.Base["队伍" .. i] then
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
        if JY.Base["物品" .. i] == thingid then
            return true
        end
    end
    return false
end

function instruct_19(x, y)
    JY.Base["人X1"] = x
    JY.Base["人Y1"] = y
    JY.SubSceneX = 0
    JY.SubSceneY = 0
end

function instruct_20()
    if JY.Base["队伍" .. CC.TeamNum] >= 0 then
        return true
    end
    return false
end

-- 离队函数
function instruct_21(personid)
    if JY.Person[personid] == nil then
        lib.Debug("instruct_21 error: personid not exist")
        return
    end
    local j = 0
    for i = 1, CC.TeamNum do
        if personid == JY.Base["队伍" .. i] then
            j = i
        end
    end
    if j == 0 then
        return
    end
    for i = j + 1, CC.TeamNum do
        JY.Base["队伍" .. i - 1] = JY.Base["队伍" .. i]
    end
    JY.Base["队伍" .. CC.TeamNum] = -1
    if JY.Person[personid]["武器"] >= 0 then
        JY.Thing[JY.Person[personid]["武器"]]["使用人"] = -1
        JY.Person[personid]["武器"] = -1
    end
    if JY.Person[personid]["防具"] >= 0 then
        JY.Thing[JY.Person[personid]["防具"]]["使用人"] = -1
        JY.Person[personid]["防具"] = -1
    end
    if JY.Person[personid]["坐骑"] >= 0 then
        JY.Thing[JY.Person[personid]["坐骑"]]["使用人"] = -1
        JY.Person[personid]["坐骑"] = -1
    end
    if JY.Person[personid]["修炼物品"] >= 0 then
        JY.Thing[JY.Person[personid]["修炼物品"]]["使用人"] = -1
        JY.Person[personid]["修炼物品"] = -1
    end
    JY.Person[personid]["物品修炼点数"] = 0
end

function instruct_22()
    for i = 1, CC.TeamNum do
        if JY.Base["队伍" .. i] >= 0 then
            JY.Person[JY.Base["队伍" .. i]]["内力"] = 0
            JY.Person[JY.Base["队伍" .. i]]["中毒程度"] = 100
        end
    end
end

function instruct_23(personid, value)
    JY.Person[personid]["用毒能力"] = value
    AddPersonAttrib(personid, "用毒能力", 0)
end

function instruct_24()
    instruct_test("指令24测试")
end

-- 镜头移动
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
    local v = JY.Person[personid]["品德"]
    if vmin <= v and v <= vmax then
        return true
    else
        return false
    end
end

function instruct_29(personid, vmin, vmax)
    local v = JY.Person[personid]["攻击力"]
    if vmin <= v and v <= vmax then
        return true
    else
        return false
    end
end

-- 人物自动移动
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
    x = JY.Base["人X1"] + CC.DirectX[direct + 1]
    y = JY.Base["人Y1"] + CC.DirectY[direct + 1]
    JY.Base["人方向"] = direct
    JY.MyPic = GetMyPic()
    DtoSMap()
    if SceneCanPass(x, y) == true then
        JY.Base["人X1"] = x
        JY.Base["人Y1"] = y
    end
    JY.Base["人X1"] = limitX(JY.Base["人X1"], 1, CC.SWidth - 2)
    JY.Base["人Y1"] = limitX(JY.Base["人Y1"], 1, CC.SHeight - 2)
    DrawSMap()
    ShowScreen()
    return 1
end

function instruct_30_sub(direct)
    local x, y = nil, nil
    local d_pass = GetS(JY.SubScene, JY.Base["人X1"], JY.Base["人Y1"], 3)

    if d_pass >= 0 and d_pass ~= JY.OldDPass then
        EventExecute(d_pass, 3)
        JY.OldDPass = d_pass
        JY.oldSMapX = -1
        JY.oldSMapY = -1
        JY.D_Valid = nil
    end

    JY.OldDPass = -1
    local isout = 0
    if (((JY.Scene[JY.SubScene]["出口X1"] == JY.Base["人X1"] and JY.Scene[JY.SubScene]["出口Y1"] ==
        JY.Base["人Y1"]) or JY.Scene[JY.SubScene]["出口X2"] ~= JY.Base["人X1"] or JY.Scene[JY.SubScene]["出口Y2"] ==
        JY.Base["人Y1"] or JY.Scene[JY.SubScene]["出口X3"] == JY.Base["人X1"] and JY.Scene[JY.SubScene]["出口Y3"] ==
        JY.Base["人Y1"])) then
        isout = 1
    end
    if isout == 1 then
        JY.Status = GAME_MMAP
        -- lib.PicInit()
        CleanMemory()
        lib.ShowSlow(20, 1)
        if JY.MmapMusic < 0 then
            JY.MmapMusic = JY.Scene[JY.SubScene]["出门音乐"]
        end
        Init_MMap()
        JY.SubScene = -1
        JY.oldSMapX = -1
        JY.oldSMapY = -1
        local sc = CC.Shichen
        if CC.TX['夜幕'] == 1 then
            --sc = 6
        end
        lib.DrawMMap(JY.Base["人X"], JY.Base["人Y"], GetMyPic(), sc)
        lib.ShowSlow(20, 0)
        lib.GetKey()
        return
    end
    if JY.Scene[JY.SubScene]["跳转场景"] >= 0 and JY.Base["人X1"] == JY.Scene[JY.SubScene]["跳转口X1"] and
        JY.Base["人Y1"] == JY.Scene[JY.SubScene]["跳转口Y1"] then
        JY.SubScene = JY.Scene[JY.SubScene]["跳转场景"]
        lib.ShowSlow(20, 1)
        if JY.Scene[JY.SubScene]["外景入口X1"] == 0 and JY.Scene[JY.SubScene]["外景入口Y1"] == 0 then
            JY.Base["人X1"] = JY.Scene[JY.SubScene]["入口X"]
            JY.Base["人Y1"] = JY.Scene[JY.SubScene]["入口Y"]
        else
            JY.Base["人X1"] = JY.Scene[JY.SubScene]["跳转口X2"]
            JY.Base["人Y1"] = JY.Scene[JY.SubScene]["跳转口Y2"]
        end
        Init_SMap(1)
        return
    end
    AddMyCurrentPic()
    x = JY.Base["人X1"] + CC.DirectX[direct + 1]
    y = JY.Base["人Y1"] + CC.DirectY[direct + 1]
    JY.Base["人方向"] = direct
    JY.MyPic = GetMyPic()
    DtoSMap()
    if SceneCanPass(x, y) == true then
        JY.Base["人X1"] = x
        JY.Base["人Y1"] = y
    end
    JY.Base["人X1"] = limitX(JY.Base["人X1"], 1, CC.SWidth - 2)
    JY.Base["人Y1"] = limitX(JY.Base["人Y1"], 1, CC.SHeight - 2)
    DrawSMap()
    ShowScreen()
    return 1
end

-- 计算钱是否足够
function instruct_31(num)
    local r = false
    if num <= CC.Gold then
        return true
    end
    return r
end

-- 增加，减少物品的函数
function instruct_32(thingid, num)
    local p = 1
    -- 首先控制获取数量，超过30000自动算30000
    for i = 1, CC.MyThingNum do
        if JY.Base["物品" .. i] == thingid then
            if thingid == 174 then
                -- JY.Base["物品数量" .. i] = 0
                p = i
                break
            else
                -- 已经有一定数量的物品，如果相加之后超过30000，按30000算
                if (JY.Base["物品数量" .. i] + num) > 30000 then
                    JY.Base["物品数量" .. i] = 30000
                else
                    JY.Base["物品数量" .. i] = JY.Base["物品数量" .. i] + num
                end
                p = i
                break
            end
        elseif JY.Base["物品" .. i] == -1 then
            if thingid == 174 then
                JY.Base["物品" .. i] = thingid
                -- JY.Base["物品数量" .. i] = 0
                p = i
                break
            else
                JY.Base["物品" .. i] = thingid
                JY.Base["物品数量" .. i] = num
                p = i
                break
            end
        end
    end

    -- 获取银两的时候刷新银两显示
    if thingid == CC.MoneyID then
        CC.Gold = CC.Gold + num -- JY.Base["物品数量" .. p]
        if CC.Gold < 0 then
            CC.Gold = 0
        end
    end
    -- 获取残章的时候刷新残章显示
    if thingid == CC.MJCZID then
        CC.MJCZ = CC.MJCZ + num -- JY.Base["物品数量" .. p]
        if CC.MJCZ < 0 then
            CC.MJCZ = 0
        end
    end

    -- 获得天书，增加15点声望
    -- 获得的时候才增加
    if num > 0 and thingid >= CC.BookStart and thingid < CC.BookStart + CC.BookNum then
        -- JY.Person[0]["声望"] = JY.Person[0]["声望"] + 15;
        JY.Base["天书数量"] = JY.Base["天书数量"] + 1
        -- 无酒不欢：用520号人物的品德判定可以摘取的蟠桃数量
        -- 替换蟠桃树贴图
        JY.Person[520]["品德"] = JY.Person[520]["品德"] + 1
        -- 在已经种过树的情况下，树会结果，用521号人物的品德判定是否已触发种树事件
        if JY.Person[521]["品德"] == 1 then
            addevent(70, 65, 1, 4119, 1, 2366 * 2)
        end

    end

    if JY.Base["物品数量" .. p] <= 0 then
        if thingid == 174 then
            if CC.Gold <= 0 then
                for i = p + 1, CC.MyThingNum do
                    JY.Base["物品" .. i - 1] = JY.Base["物品" .. i]
                    JY.Base["物品数量" .. i - 1] = JY.Base["物品数量" .. i]
                end
                JY.Base["物品" .. CC.MyThingNum] = -1
                JY.Base["物品数量" .. CC.MyThingNum] = 0
            end
        elseif thingid == 550 then
            if CC.MJCZ <= 0 then
                for i = p + 1, CC.MyThingNum do
                    JY.Base["物品" .. i - 1] = JY.Base["物品" .. i]
                    JY.Base["物品数量" .. i - 1] = JY.Base["物品数量" .. i]
                end
                JY.Base["物品" .. CC.MyThingNum] = -1
                JY.Base["物品数量" .. CC.MyThingNum] = 0
            end
        else
            for i = p + 1, CC.MyThingNum do
                JY.Base["物品" .. i - 1] = JY.Base["物品" .. i]
                JY.Base["物品数量" .. i - 1] = JY.Base["物品数量" .. i]
            end
            JY.Base["物品" .. CC.MyThingNum] = -1
            JY.Base["物品数量" .. CC.MyThingNum] = 0
        end
    end
    CC.JLWP[#CC.JLWP + 1] = thingid
end

-- 人物学会武功
function instruct_33(personid, wugongid, flag)
    local xwperson; -- 判定要学武功的人
    xwperson = personid
    if flag == nil then
        flag = 50
    end
    if personid == JY.Base["畅想"] or personid == 0 then
        xwperson = 0
    end
    local add = 0
    local dkfcj_ng = JY.Wugong[wugongid]['层级']
    local kflx = JY.Wugong[wugongid]['武功类型']
    local yes = 1
    local okf = KF_yimai(personid, wugongid)
    if PersonKF(personid, wugongid) == true then
        DrawStrBoxWaitKey(
            string.format("%s已经学会%s", JY.Person[personid]["姓名"], JY.Wugong[wugongid]["名称"]), C_ORANGE,
            CC.DefaultFont)
        return 1
    end
    if JY.Person[personid]['武功15'] > 0 then
        DrawStrBoxWaitKey(string.format("%s不能再学习更多武功%s", JY.Person[personid]["姓名"], ''), C_ORANGE,
            CC.DefaultFont)
        return 1
    end
    local dkfcj_ng = JY.Wugong[wugongid]['层级']
    local kflx = JY.Wugong[wugongid]['武功类型']
    local pd = false
    -- 门派初中高阶武功一脉相承
    if JY.Wugong[wugongid]['门派'] == JY.Person[personid]['门派'] and PersonKF(personid, wugongid) == false and
        JY.Wugong[wugongid]['门派'] > 0 then
        local pd = 0
        for i = 1, JY.Base['武功数量'] do
            local kfyes = JY.Person[personid]["武功" .. i]
            if kfyes > 0 then
                if JY.Wugong[wugongid]['门派'] == JY.Wugong[kfyes]['门派'] then
                    lib.Debug(JY.Wugong[kfyes]['名称'] .. ' 门派成功 ' .. JY.Wugong[wugongid]['名称'])
                    if JY.Wugong[kfyes]['武功类型'] == kflx and (dkfcj_ng < 4 or JY.Wugong[kfyes]['武功类型'] == 7) then
                        lib.Debug(JY.Wugong[kfyes]['名称'] .. ' 类型成功 ' .. JY.Wugong[wugongid]['名称'] ..
                                      '  层级' .. JY.Wugong[kfyes]['层级'] .. ' ' .. dkfcj_ng)
                        if JY.Wugong[kfyes]['层级'] < dkfcj_ng then
                            lib.Debug(JY.Wugong[kfyes]['名称'] .. ' 层级成功 ' .. JY.Wugong[wugongid]['名称'])
                            if DrawStrBoxYesNo(-1, -1,
                                MP_name(personid) .. "武功一脉相承，是否将" .. JY.Wugong[kfyes]['名称'] ..
                                    '洗为' .. JY.Wugong[wugongid]['名称'] .. '?', C_WHITE, CC.DefaultFont) then
                                JY.Person[personid]["武功" .. i] = wugongid
                                JY.Person[personid]["武功等级" .. i] = flag
                                if JY.Person[personid]["天赋内功"] == kfyes then
                                    JY.Person[personid]["天赋内功"] = wugongid
                                elseif JY.Person[personid]["天赋轻功"] == kfyes then
                                    JY.Person[personid]["天赋轻功"] = wugongid
                                elseif JY.Person[personid]["天赋外功1"] == kfyes then
                                    JY.Person[personid]["天赋外功1"] = wugongid
                                elseif JY.Person[personid]["天赋外功2"] == kfyes then
                                    JY.Person[personid]["天赋外功2"] = wugongid
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
            JY.Wugong[nkf]['名称'] .. JY.Wugong[okf]['名称'] .. "一脉相承，是否将" ..
                JY.Wugong[okf]['名称'] .. "洗为" .. JY.Wugong[nkf]['名称'] .. "?", C_WHITE, CC.DefaultFont) then
            for i = 1, JY.Base["武功数量"] do
                if JY.Person[personid]["武功" .. i] == okf then
                    JY.Person[personid]["武功" .. i] = nkf
                    JY.Person[personid]["武功等级" .. i] = flag
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
        -- lib.Debug('没有一脉的判定')	
        for i = 1, JY.Base["武功数量"] do
            if JY.Person[xwperson]["武功" .. i] == 0 then
                JY.Person[xwperson]["武功" .. i] = wugongid
                JY.Person[xwperson]["武功等级" .. i] = flag
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
                    JY.Wugong[nkf]['名称'] .. JY.Wugong[okf]['名称'] .. "一脉相承，是否将" ..
                        JY.Wugong[okf]['名称'] .. "洗为" .. JY.Wugong[nkf]['名称'] .. "?", C_WHITE, CC.DefaultFont) then
                    for i = 1, JY.Base["武功数量"] do
                        if JY.Person[personid]["武功" .. i] == okf then
                            JY.Person[personid]["武功" .. i] = nkf
                            JY.Person[personid]["武功等级" .. i] = flag
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
                for i = 1, JY.Base["武功数量"] do
                    if JY.Person[xwperson]["武功" .. i] == 0 then
                        JY.Person[xwperson]["武功" .. i] = wugongid
                        JY.Person[xwperson]["武功等级" .. i] = flag
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
    DrawStrBoxWaitKey(string.format("%s 学会武功 %s", JY.Person[xwperson]["姓名"], JY.Wugong[wugongid]["名称"]),
        C_ORANGE, CC.DefaultFont)
    -- end	
    KF_addsx(personid, wugongid)
    KF_zsset(personid, wugongid)
    Hp_Max(xwperson)
    Mp_Max(xwperson)
end

-- 改变资质
function instruct_34(id, value)
    local xwperson; -- 判定人物
    if id == JY.Base["畅想"] then
        xwperson = 0
    else
        xwperson = id
    end
    local add, str = AddPersonAttrib(xwperson, "资质", value)
    DrawStrBoxWaitKey(JY.Person[xwperson]["姓名"] .. str, C_ORANGE, CC.DefaultFont)
end

-- 洗武功函数
function instruct_35(personid, id, wugongid, wugonglevel)
    local xwperson; -- 判定要洗武功的人
    xwperson = personid
    -- 被洗掉的武功从自动列表清除
    if JY.Person[xwperson]["武功" .. id + 1] > 0 then
        if JY.Person[xwperson]["武功" .. id + 1] == JY.Person[xwperson]["优先使用"] then
            JY.Person[xwperson]["优先使用"] = 0
        elseif JY.Person[xwperson]["武功" .. id + 1] == JY.Person[xwperson]["主运内功"] then
            JY.Person[xwperson]["主运内功"] = 0
        elseif JY.Person[xwperson]["武功" .. id + 1] == JY.Person[xwperson]["主运轻功"] then
            JY.Person[xwperson]["主运轻功"] = 0
        end
    end
    if isteam(xwperson) then
        Hp_Max(xwperson)
        Mp_Max(xwperson)
    end
    local pd = 0
    for i = 1, JY.Base['武功数量'] do
        if JY.Person[xwperson]['武功' .. i] == wugongid then
            pd = 1
        end
    end
    if pd == 0 then
        local owg = JY.Person[xwperson]["武功" .. id + 1]
        JY.Person[xwperson]["武功" .. id + 1] = wugongid
        JY.Person[xwperson]["武功等级" .. id + 1] = wugonglevel
        DrawStrBoxWaitKey(JY.Person[personid]["姓名"] .. '遗忘武功' .. JY.Wugong[owg]['名称'] ..
                              '，并练出武功' .. JY.Wugong[wugongid]['名称'], C_ORANGE, CC.DefaultFont)
        Hp_Max(xwperson)
        Mp_Max(xwperson)
    else
        say('已经学会了' .. JY.Wugong[wugongid]['名称'] ..
                '，不可再次学习，可惜错过了一次重学的机会。', personid, 1)
    end

    if JY.Base['畅想'] == xwperson then
        xwperson = 0
        -- 被洗掉的武功从自动列表清除
        if JY.Person[xwperson]["武功" .. id + 1] > 0 then
            if JY.Person[xwperson]["武功" .. id + 1] == JY.Person[xwperson]["优先使用"] then
                JY.Person[xwperson]["优先使用"] = 0
            elseif JY.Person[xwperson]["武功" .. id + 1] == JY.Person[xwperson]["主运内功"] then
                JY.Person[xwperson]["主运内功"] = 0
            elseif JY.Person[xwperson]["武功" .. id + 1] == JY.Person[xwperson]["主运轻功"] then
                JY.Person[xwperson]["主运轻功"] = 0
            end
        end
        if isteam(xwperson) then
            Hp_Max(xwperson)
            Mp_Max(xwperson)
        end
        local pd = 0
        for i = 1, JY.Base['武功数量'] do
            if JY.Person[xwperson]['武功' .. i] == wugongid then
                pd = 1
            end
        end
        if pd == 0 then
            local owg = JY.Person[xwperson]["武功" .. id + 1]
            JY.Person[xwperson]["武功" .. id + 1] = wugongid
            JY.Person[xwperson]["武功等级" .. id + 1] = wugonglevel
            DrawStrBoxWaitKey(JY.Person[personid]["姓名"] .. '遗忘武功' .. JY.Wugong[owg]['名称'] ..
                                  '，并练出武功' .. JY.Wugong[wugongid]['名称'], C_ORANGE, CC.DefaultFont)
            Hp_Max(xwperson)
            Mp_Max(xwperson)
        else
            say('已经学会了' .. JY.Wugong[wugongid]['名称'] ..
                    '，不可再次学习，可惜错过了一次重学的机会。', personid, 1)
        end
    end

    for i, v in pairs(CC.Copy) do
        if v == personid then
            -- if CC.Copy[personid] ~= nil then 
            xwperson = i
            -- 被洗掉的武功从自动列表清除
            if JY.Person[xwperson]["武功" .. id + 1] > 0 then
                if JY.Person[xwperson]["武功" .. id + 1] == JY.Person[xwperson]["优先使用"] then
                    JY.Person[xwperson]["优先使用"] = 0
                elseif JY.Person[xwperson]["武功" .. id + 1] == JY.Person[xwperson]["主运内功"] then
                    JY.Person[xwperson]["主运内功"] = 0
                elseif JY.Person[xwperson]["武功" .. id + 1] == JY.Person[xwperson]["主运轻功"] then
                    JY.Person[xwperson]["主运轻功"] = 0
                end
            end
            local pd = 0
            for i = 1, JY.Base['武功数量'] do
                if JY.Person[xwperson]['武功' .. i] == wugongid then
                    pd = 1
                end
            end
            if pd == 0 then
                local owg = JY.Person[xwperson]["武功" .. id + 1]
                JY.Person[xwperson]["武功" .. id + 1] = wugongid
                JY.Person[xwperson]["武功等级" .. id + 1] = wugonglevel
                DrawStrBoxWaitKey(JY.Person[personid]["姓名"] .. '遗忘武功' .. JY.Wugong[owg]['名称'] ..
                                      '，并练出武功' .. JY.Wugong[wugongid]['名称'], C_ORANGE, CC.DefaultFont)
                Hp_Max(xwperson)
                Mp_Max(xwperson)
            else
                say('已经学会了' .. JY.Wugong[wugongid]['名称'] ..
                        '，不可再次学习，可惜错过了一次重学的机会。', personid, 1)
            end
        end
    end
    MIJI_PD(xwperson, KF_thing(wugongid))
    KF_addsx(xwperson, wugongid)
    if JY.Base['畅想'] > 0 then
        KF_zsset(JY.Base['畅想'], wugongid)
    end
    KF_zsset(xwperson, wugongid)
end

function instruct_36(sex)
    if JY.Person[0]["性别"] == sex then
        return true
    else
        return false
    end
end

-- 无酒不欢：加减道德显示
function instruct_37(v)
    AddPersonAttrib(0, "品德", v)
    if v < 0 then
        for i = 1, 15 do
            if JY.Restart == 1 then
                break
            end
            local y_off = i * 2 + CC.DefaultFont + CC.RowPixel
            DrawString(CC.ScreenW / 2 - CC.DefaultFont * 5, CC.ScreenH / 4 - CC.DefaultFont - CC.RowPixel + y_off,
                "你的道德指数下降了" .. -v .. "点", M_DeepSkyBlue, CC.DefaultFont)
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
                "你的道德指数提升了" .. v .. "点", PinkRed, CC.DefaultFont)
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
    JY.Scene[sceneid]["进入条件"] = 0
end

function instruct_40(v)
    JY.Base["人方向"] = v
    JY.MyPic = GetMyPic()
end

function instruct_41(personid, thingid, num)
    local k = 0
    for i = 1, 4 do
        if JY.Person[personid]["携带物品" .. i] == thingid then
            JY.Person[personid]["携带物品数量" .. i] = JY.Person[personid]["携带物品数量" .. i] + num
            k = i
            break
        end
    end
    if k > 0 and JY.Person[personid]["携带物品数量" .. k] <= 0 then
        JY.Person[personid]["携带物品" .. k] = -1
    end
    if k == 0 then
        for i = 1, 4 do
            if JY.Person[personid]["携带物品" .. i] == -1 then
                JY.Person[personid]["携带物品" .. i] = thingid
                JY.Person[personid]["携带物品数量" .. i] = num
                break
            end
        end
    end
end

function instruct_42()
    local r = false
    for i = 1, CC.TeamNum do
        if JY.Base["队伍" .. i] >= 0 and JY.Person[JY.Base["队伍" .. i]]["性别"] == 1 then
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

-- 加轻
function instruct_45(id, value)
    local xwperson; -- 判定要洗武功的人
    if id == JY.Base["畅想"] then
        xwperson = 0
    else
        xwperson = id
    end
    local add, str = AddPersonAttrib(xwperson, "轻功", value)
end

-- 加内
function instruct_46(id, value)
    local xwperson; -- 判定要洗武功的人
    if id == JY.Base["畅想"] then
        xwperson = 0
    else
        xwperson = id
    end
    local add, str = AddPersonAttrib(xwperson, "内力最大值", value)
    AddPersonAttrib(xwperson, "内力", 0)
end

-- 加攻
function instruct_47(id, value)
    local xwperson; -- 判定要洗武功的人
    if id == JY.Base["畅想"] then
        xwperson = 0
    else
        xwperson = id
    end
    local add, str = AddPersonAttrib(xwperson, "攻击力", value)
end

-- 加防
function add_deffense(id, value)
    local xwperson; -- 判定要洗武功的人
    if id == JY.Base["畅想"] then
        xwperson = 0
    else
        xwperson = id
    end
    local add, str = AddPersonAttrib(xwperson, "防御力", value)
end

-- 加血
function instruct_48(id, value)
    local xwperson; -- 判定要洗武功的人
    if id == JY.Base["畅想"] then
        xwperson = 0
    else
        xwperson = id
    end
    local add, str = AddPersonAttrib(xwperson, "生命最大值", value)
    AddPersonAttrib(xwperson, "生命", value)
end

-- 洗内属
function instruct_49(personid, value)
    local xwperson; -- 判定要洗内属的人
    if personid == JY.Base["畅想"] then
        xwperson = 0
    else
        xwperson = personid
    end
    JY.Person[xwperson]["内力性质"] = value
    JY.Person[personid]["内力性质"] = value
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
    DrawStrBoxWaitKey(string.format("你现在的品德指数为: %d", JY.Person[0]["品德"]), C_ORANGE, CC.DefaultFont)
end

function instruct_53()
    -- DrawStrBoxWaitKey(string.format("你现在的声望指数为: %d", JY.Person[0]["声望"]), C_ORANGE, CC.DefaultFont)
end

function instruct_54()
    for i = 0, JY.SceneNum - 1 do
        JY.Scene[i]["进入条件"] = 0
    end
    JY.Scene[2]["进入条件"] = 2
    JY.Scene[38]["进入条件"] = 2
    JY.Scene[75]["进入条件"] = 1
    JY.Scene[80]["进入条件"] = 1
end

function instruct_55(id, num)
    if GetD(JY.SubScene, id, 2) == num then
        return true
    else
        return false
    end
end

function instruct_56(v)
    -- JY.Person[0]["声望"] = JY.Person[0]["声望"] + v
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
            instruct_1(2854 + warnum, WAR.Data["敌人1"], 0)
            instruct_0()
            if WarMain(warnum + startwar, 0) == true then
                instruct_0()
                instruct_13()
                TalkEx("还有那位前辈肯赐教？", 0, 1)
                instruct_0()
            else
                instruct_15()
                return
            end
        end
        if i < group - 1 then
            TalkEx(JY.Person[0]["外号"] .. "已连战三场，*可先休息再战．", 70, 0)
            instruct_0()
            instruct_14()
            lib.Delay(300)
            if JY.Person[0]["受伤程度"] < 50 and JY.Person[0]["中毒程度"] <= 0 then
                JY.Person[0]["受伤程度"] = 0
                AddPersonAttrib(0, "体力", math.huge)
                AddPersonAttrib(0, "内力", math.huge)
                AddPersonAttrib(0, "生命", math.huge)
            end
            instruct_13()
            TalkEx("我已经休息够了，*有谁要再上？", 0, 1)
            instruct_0()
        end
    end
    TalkEx("接下来换谁？**．．．．*．．．．***没有人了吗？", 0, 1)
    instruct_0()
    TalkEx("如果还没有人要出来向这位*" .. JY.Person[0]["外号"] ..
               "挑战，那麽这武功天下*第一之名，武林盟主之位，*就由这位" ..
               JY.Person[0]["外号"] ..
               "夺得．***．．．．．．*．．．．．．*．．．．．．*好，恭喜" ..
               JY.Person[0]["外号"] .. "，这武林盟主*之位就由" .. JY.Person[0]["外号"] ..
               "获得，而这把*”武林神杖”也由你保管．", 70, 0)
    instruct_0()
    TalkEx("恭喜" .. JY.Person[0]["外号"] .. "！", 12, 0)
    instruct_0()
    TalkEx("小兄弟，恭喜你！", 64, 4)
    instruct_0()
    TalkEx(
        "好，今年的武林大会到此已*圆满结束，希望明年各位武*林同道能再到我华山一游．",
        19, 0)
    instruct_0()
    instruct_14()
    for i = 24, 72 do
        instruct_3(-2, i, 0, 0, -1, -1, -1, -1, -1, -1, -2, -2, -2)
    end
    instruct_0()
    instruct_13()
    TalkEx(
        "历经千辛万苦，我终於打败*群雄，得到这武林盟主之位*及神杖．*但是”圣堂”在那呢？*为什麽没人告诉我，难道大*家都不知道．*这会儿又有的找了．",
        0, 1)
    instruct_0()
    instruct_2(143, 1)
end

-- 全部队友离队
function instruct_59()
    for i = CC.TeamNum, 2, -1 do
        if JY.Base["队伍" .. i] >= 0 then
            instruct_21(JY.Base["队伍" .. i])
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

-- 通关函数
function instruct_62(id1, startnum1, endnum1, id2, startnum2, endnum2)
    -- JY.MyPic = -1
    -- instruct_44(id1, startnum1, endnum1, id2, startnum2, endnum2)
    -- ShowScreen()
    lib.Delay(200)
    say("本次游戏就到这里了，选择重新开始可进行下一周目的游戏！", 260, 5, "无酒不欢")
    lib.PlayMPEG("ending.mp4", VK_ESCAPE)
    os.remove(CONFIG.DataPath .. 'WeeklyAwards')

    -- 增加周目
    local x = AddZM()
    if JY.Base["周目"] == CC.Week and CC.Jl == 0 then
        CC.Jl = 1
        CC.Sp = JY.Base["碎片"] + x
        DrawStrBoxWaitKey("获得【Ｇ周目碎片Ｏ】×" .. x, C_ORANGE, CC.DefaultFont, 2)
    end
    tgsave()
    Cls()
    lib.PlayMPEG(CONFIG.DataPath .. "/avi/2.mp4", VK_ESCAPE) -- 视频文件
    Cls()
    -- lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_BLACK)
    --[[
	DrawString(350, 200, "片尾曲《四大山》", C_WHITE, CC.DefaultFont)
	DrawString(375, 300, "演唱：老凡总", C_WHITE, CC.DefaultFont)
	ShowScreen()
  
	PlayMIDI(116)
	local stime = 0
	local a = 1
	local lyrics = {
	{530,"吓 近万个小时 精心打磨"},
	{560,"做游戏为了什么冷笑着"},
	{590,"前辈元老功高又如何"},
	{610,"开源码我随手可得"},
	{640,"我的 加密了得 却奈何 赞助还不够多"},
	{680,"江湖难测 人傻钱多 谁争六级会员的资格"},
	{730,"论坛里 发帖要统一 否则请离去"},
	{810,"充过钱的** 我记得你 你再来充一笔"},
	{920,"抄抄 抄抄 抄抄抄抄"},
	{940,"抄袭来的代码真的不错"},
	{970,"我我 我我 我我我我"},
	{1000,"只要加密它们就是我的"},
	{1030,"作作 作作 作作作作"},
	{1050,"国产绿色益智单机大作"},
	{1070,"你你 你你 你你你你"},
	{1100,"你的钱包终究要属于我"},
	{1220,"吓 阴谋破坏者 在论坛等着"},
	{1250,"讲道理 赢了什么 删封沉"},
	{1280,"天下谁的 原创又如何"},
	{1300,"开源码 我辈善抄袭"},
	{1320,"我的游戏热门 却奈何"},
	{1350,"徒增虚名一个"},
	{1370,"没有赞助 都是辣鸡"},
	{1390,"谁争热心玩家的资格"},
	{1410,"小城里 岁月流过去 清澈钱包里"},
	{1510,"充过钱的** 我记得你 骄傲的活下去"},
	{1610,"抄抄 抄抄 抄抄抄抄"},
	{1630,"抄过来的代码真的实用"},
	{1660,"发发 发发 发发发发"},
	{1680,"不发帖说就没赞助收入"},
	{1710,"过过 过过 过过过过"},
	{1730,"过错软弱从来不属于我"},
	{1760,"你你 你你 你你你你"},
	{1780,"你的钱包终究要属于我"},
	{2100,"抄抄 抄抄 抄抄抄抄"},
	{2120,"抄袭来的代码真的不错"},
	{2140,"我我 我我 我我我我"},
	{2170,"只要加密它们就是我的"},
	{2190,"作作 作作 作作作作"},
	{2210,"国产绿色益智单机大作"},
	{2240,"你你 你你 你你你你"},
	{2260,"你的钱包终究要属于我"},
	{2310,"论坛里 发帖要统一 否则请离去"},
	{2390,"充过钱的** 我记得你 你再来充一笔"},
	{2700,"全剧终 感谢支持"},
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
			DrawString(350, 200, "片尾曲《四大山》", C_WHITE, size)
			DrawString(375, 300, "演唱：老凡总", C_WHITE, size)
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
    JY.Person[personid]["性别"] = sex
end

-- 无酒不欢：商店数据
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
    TalkEx("这位小哥，看看有什么需要的，小店卖的东西价钱绝对公道。", headid, 0, "商家")
    -- lib.LoadPNG(91, 10 * 2 , -1, -1, 1)
    local menu = {}
    local thingnum = {}
    -- 0扬州 1沧州  2洛阳 3龙门 4大理
    -- CC.ShopScene[0]={sceneid=153,d_shop=16,d_leave={17,18}, };
    -- CC.ShopScene[1]={sceneid=3,d_shop=14,d_leave={15,16}, };
    -- CC.ShopScene[2]={sceneid=40,d_shop=20,d_leave={21,22}, };
    -- CC.ShopScene[3]={sceneid=60,d_shop=16,d_leave={17,18}, };
    -- CC.ShopScene[4]={sceneid=159,d_shop=9,d_leave={10,11,12}, };
    -- JY.Shop[0]["物品" .. 4] = 13
    -- JY.Shop[0]["物品数量" .. 4] = 1
    for i = 1, 6 do
        local thingid = JY.Shop[id]["物品" .. i]
        if thingid ~= -1 then
            menu[i] = {}
            menu[i][1] = thingid
            menu[i][2] = JY.Shop[id]["物品价格" .. i]
            menu[i][3] = JY.Shop[id]["物品数量" .. i]
            thingnum[i] = JY.Shop[id]["物品数量" .. i]
            if JY.Shop[id]["物品数量" .. i] > 0 then
                menu[i][4] = 1
            else
                menu[i][4] = nil
            end
        end
    end
    -- 3书以前没有混元
    if JY.Base["天书数量"] < 3 and id == 0 then
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

-- 学会秘技
function instruct_68(id, mj, flag, n) -- id人物编号，mj秘技编号，flag = 0遗忘 =1学会,n = 1已经学习 = 0可学习
    local xue = 0
    local full = 0
    if flag == 1 then
        for i = 1, 10 do
            if JY.Person[id]['秘技' .. i] == mj then
                xue = 1
                if n == nil then
                    DrawStrBoxWaitKey(string.format("%s已经学会%s", JY.Person[id]["姓名"], JY.Teji[mj]["名称"]),
                        C_ORANGE, CC.DefaultFont)
                end
                break
            end
            if JY.Person[id]['秘技' .. 10] > 0 then
                full = 1
                if n == nil then
                    DrawStrBoxWaitKey('不能再学习更多的秘技了', C_ORANGE, CC.DefaultFont)
                end
                break
            end
            if xue == 0 and full == 0 then
                if JY.Person[id]['秘技' .. i] == 0 then
                    JY.Person[id]['秘技' .. i] = mj
                    if n == nil then
                        DrawStrBoxWaitKey(string.format("%s领悟了秘技%s", JY.Person[id]["姓名"],
                            JY.Teji[mj]["名称"]), C_ORANGE, CC.DefaultFont)
                    end
                    break
                end
            end
        end
    end
    if flag == 0 then
        for i = 1, 5 do
            if JY.Person[id]['秘技' .. i] == mj then
                JY.Person[id]['秘技' .. i] = 0
                DrawStrBoxWaitKey(
                    string.format("%s已经遗忘秘技%s", JY.Person[id]["姓名"], JY.Teji[mj]["名称"]), C_ORANGE,
                    CC.DefaultFont)
                break
            end
        end
    end
    if JY.Base['畅想'] == id then
        id = 0
        if flag == 1 then
            for i = 1, 10 do
                if JY.Person[id]['秘技' .. i] == mj then
                    xue = 1
                    if n == nil then
                        DrawStrBoxWaitKey(string.format("%s已经学会%s", JY.Person[id]["姓名"],
                            JY.Teji[mj]["名称"]), C_ORANGE, CC.DefaultFont)
                    end
                    break
                end
                if JY.Person[id]['秘技' .. 10] > 0 then
                    full = 1
                    if n == nil then
                        DrawStrBoxWaitKey('不能再学习更多的秘技了', C_ORANGE, CC.DefaultFont)
                    end
                    break
                end
                if xue == 0 and full == 0 then
                    if JY.Person[id]['秘技' .. i] == 0 then
                        JY.Person[id]['秘技' .. i] = mj
                        -- 万毒蚀体奇穴2
                        if JY.Person[id]['奇穴' .. 25] == 1 then
                            if (mj == 6 and Pmiji(id, 8)) or (mj == 8 and Pmiji(id, 6)) then
                                AddPersonAttrib(id, '用毒能力', 80)
                            end
                        end
                        if n == nil then
                            DrawStrBoxWaitKey(string.format("%s领悟了秘技%s", JY.Person[id]["姓名"],
                                JY.Teji[mj]["名称"]), C_ORANGE, CC.DefaultFont)
                        end
                        break
                    end
                end
            end
        end
        if flag == 0 then
            for i = 1, 5 do
                if JY.Person[id]['秘技' .. i] == mj then
                    JY.Person[id]['秘技' .. i] = 0
                    DrawStrBoxWaitKey(string.format("%s已经遗忘秘技%s", JY.Person[id]["姓名"],
                        JY.Teji[mj]["名称"]), C_ORANGE, CC.DefaultFont)
                    break
                end
            end
        end
    end
end

-- 是否获得过物品
function instruct_69(thingid)
    for i = 1, #CC.JLWP do
        if CC.JLWP[i] == thingid then
            return true
        end
    end
    return false
end

-- 洗武功
function instruct_70(pid)
    Cls()
    local menu = {}
    for i = 1, JY.Base['武功数量'] do
        if JY.Person[pid]["武功" .. i] > 0 then
            local wg = JY.Person[pid]["武功" .. i]
            menu[#menu + 1] = {JY.Wugong[wg]["名称"], nil, 1, wg, i}
        end
    end
    Cls()
    local r = ShowMenu2(menu, #menu, 3, 15, CC.ScreenW / 3, CC.ScreenH / 3, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE,
        C_WHITE, "选择要洗掉的武功")
    local xsbs = 1
    local swbs = 1
    if match_ID(pid, 9928) or match_ID(pid, 9862) then -- 冯衡 双倍属性值
        swbs = 2
    end
    if match_ID(pid, 9928) or match_ID(pid, 9863) then
        xsbs = 2
    end
    if r > 0 then
        local thingid = -1
        for i = 0, JY.ThingNum - 1 do
            if JY.Thing[i]["练出武功"] > 0 and JY.Thing[i]["练出武功"] == menu[r][4] then
                thingid = i
                local level = math.modf(JY.Person[pid]["武功等级" .. menu[r][5]] / 100) + 1
                AddPersonAttrib(pid, "生命最大值", -JY.Thing[thingid]["加生命最大值"] * level)
                AddPersonAttrib(pid, "内力最大值", -JY.Thing[thingid]["加内力最大值"] * level)
                AddPersonAttrib(pid, "攻击力", -JY.Thing[thingid]["加攻击力"] * level * xsbs)
                AddPersonAttrib(pid, "轻功", -JY.Thing[thingid]["加轻功"] * level * xsbs)
                AddPersonAttrib(pid, "防御力", -JY.Thing[thingid]["加防御力"] * level * xsbs)
                AddPersonAttrib(pid, "医疗能力", -JY.Thing[thingid]["加医疗能力"] * xsbs * level)
                AddPersonAttrib(pid, "用毒能力", -JY.Thing[thingid]["加用毒能力"] * xsbs * level)
                AddPersonAttrib(pid, "解毒能力", -JY.Thing[thingid]["加解毒能力"] * xsbs * level)
                AddPersonAttrib(pid, "抗毒能力", -JY.Thing[thingid]["加抗毒能力"] * xsbs * level)
                AddPersonAttrib(pid, "拳掌功夫", -JY.Thing[thingid]["加拳掌功夫"] * xsbs * level)
                AddPersonAttrib(pid, "指法技巧", -JY.Thing[thingid]["加指法技巧"] * xsbs * level)
                AddPersonAttrib(pid, "御剑能力", -JY.Thing[thingid]["加御剑能力"] * xsbs * level)
                AddPersonAttrib(pid, "耍刀技巧", -JY.Thing[thingid]["加耍刀技巧"] * xsbs * level)
                AddPersonAttrib(pid, "特殊兵器", -JY.Thing[thingid]["加特殊兵器"] * xsbs * level)
                AddPersonAttrib(pid, "暗器技巧", -JY.Thing[thingid]["加暗器技巧"] * xsbs * level)
                AddPersonAttrib(pid, "武学常识", -JY.Thing[thingid]["加武学常识"] * xsbs * level)
                break
            end
        end
        for i = menu[r][5], #menu - 1 do
            JY.Person[pid]["武功" .. i] = JY.Person[pid]["武功" .. i + 1]
            JY.Person[pid]["武功等级" .. i] = JY.Person[pid]["武功等级" .. i + 1]
        end
        JY.Person[pid]["武功" .. #menu] = 0
        JY.Person[pid]["武功等级" .. #menu] = 0
        QZXS(JY.Person[pid]["姓名"] .. "已经洗掉" .. menu[r][1])
    end
end

function Add(id, i, num)
    AddPersonAttrib(id, i, num)
end
-- 选择框，每个选项都带边框
-- title 标题
-- str 内容 *换行
-- button 选项
-- num 选项的个数，一定要和选项对应起来
-- headid 显示在内容左边的贴图，如果不传值则不显示贴图
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

    local yczj = 0 -- 隐藏主角张家辉

    if title == "主角选择" then
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
                -- 无酒不欢：这里pass in select，避免在选择不到的情况下返回不存在的选项
                select = between(mx, select);
                if select > 0 and select <= num and ktype == 3 then
                    break
                end
            end
        end
        -- 隐藏主角张家辉
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

-- 显示带边框的文字
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
	LoadSMAP()--重新加载场景图
	
	lib.PicLoadFile(CC.BJ[1], CC.BJ[2], 92)
    lib.LoadPNGPath('./data/bj',0,-1,100)
    lib.LoadPNGPath(CC.HeadPath, 1, CC.HeadNum, limitX(CC.WX*100,0,100))
    lib.LoadPNGPath(CC.BodyPath, 90, CC.BodyNum, limitX(CC.WX*100,0,100))	
    lib.LoadPNGPath(CC.PTPath, 95, CC.PTNum, limitX(CC.WX*100,0,100))
    lib.LoadPNGPath(CC.XTPath, 91, CC.XTNum, limitX(CC.WX*100,0,100))	--UI				
    lib.LoadPNGPath(CC.UIPath, 96, CC.UINum, limitX(CC.WX*100,0,100))	
	lib.LoadPNGPath(CC.ThingPath, 2, CC.ThingNum, limitX(CC.WX*100,0,100))	--物品贴图
    -- lib.LoadPNGPath('./data/thing',0,-1,100)
    lib.LoadPNGPath(CC.TFPath, 89, CC.TFNum, limitX(CC.WX * 100, 0, 100)) -- TF
    -- 97是云朵，切勿使用
    lib.LoadPNGPath(CC.IconPath, 98, CC.IconNum, limitX(CC.WX*100,0,100))	--状态图标，内存区域98
    lib.LoadPNGPath(CC.HeadPath, 99, CC.HeadNum, 26.923076923) --人物小头像，用于集气条，内存区域99

    PlayMIDI(JY.Scene[JY.SubScene]["进门音乐"])
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
        local tg = 8 + JY.Base['天关']
        if JY.SubScene == 150 then
            name = "天关" .. numberToChinese(tg) .. "层"
        else
            name = JY.Scene[JY.SubScene]["名称"]
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


-- 新对话方式
-- 加入控制字符
-- 暂停，任意键后继续，ｐ
-- 控制颜色Ｒ=redＧ=goldＢ=blackＷ=whiteＯ=orange
-- 控制字符显示速度０,１,２,３,４,５,６,７,８,９
-- 控制字体ＡＳＤＦ
-- 控制换行Ｈ   分页Ｐ
-- Ｎ代表自己ｎ代表主角

function MyDrawString(x1, x2, y, str, color, size)
    local len = math.modf(string.len(str) * size / 4)
    local x = math.modf((x1 + x2) / 2) - len
    DrawString(x, y, str, color, size)
end

-- 分割字符串
-- szFullString字符串
-- szSeparator分割符
-- 返回总数,分割后数组
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

-- 绘制一个带背景的白色方框，四角凹进
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

-- 绘制四角凹进的方框
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

-- 初始化主地图
function Init_MMap()
     lib.PicInit()
    lib.LoadMMap(CC.MMapFile[1], CC.MMapFile[2], CC.MMapFile[3], CC.MMapFile[4], CC.MMapFile[5], CC.MWidth, CC.MHeight,JY.Base["人X"], JY.Base["人Y"])
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
    -- 97是云朵，切勿使用
    lib.LoadPNGPath(CC.IconPath, 98, CC.IconNum, limitX(CC.WX*100,0,100))	--状态图标，内存区域98
    lib.LoadPNGPath(CC.HeadPath, 99, CC.HeadNum, 26.923076923) --人物小头像，用于集气条，内存区域99
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

--适配相关
function LoadSMAP()
	lib.FreeSur(-1)--清除所有id，彻底解决显示异常
	ButtonMode(0)
	if	existFile(CONFIG.DataPath..'smap.zip') then
		lib.Debug("1")
		lib.LoadPNGPath(CONFIG.DataPath..'smap', 94, -1, 100, "png");
	elseif	existFile(CC.SMAPPicFile[1]) then
		lib.Debug("2")
		lib.PicLoadFile(CC.SMAPPicFile[1], CC.SMAPPicFile[2], 94)	--子场景贴图，内存区域
	end
	lib.Debug("3")
end

function LoadMMAP()
	lib.FreeSur(-1)--清除所有id，彻底解决显示异常
	ButtonMode(1)
	if	existFile(CONFIG.DataPath..'mmap.zip') then
		lib.LoadPNGPath(CONFIG.DataPath..'mmap', 93, -1, 100, "png");
	elseif	existFile(CC.MMAPPicFile[1]) then
		lib.PicLoadFile(CC.MMAPPicFile[1], CC.MMAPPicFile[2], 93)	--大地图贴图，内存区域
	end
	lib.LoadPNGPath(CONFIG.DataPath..'cloud', 97, -1, 100, "png");--云朵
end

function LoadWMAP()
	lib.FreeSur(-1)--清除所有id，彻底解决显示异常
	ButtonMode(2)
	if existFile(CONFIG.DataPath..'wmap.zip') then
		lib.LoadPNGPath(CONFIG.DataPath..'wmap', 0, -1, 100, "png");
	elseif existFile(CC.WMAPPicFile[1]) then
		lib.PicLoadFile(CC.WMAPPicFile[1], CC.WMAPPicFile[2], 0)	--子场景贴图，内存区域	
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


-- 自定义的进入子场景的函数
-- 需要进入的子场景编号
-- x进入子场景后人物的X坐标，传入-1则默认为入口X
-- y进入子场景后人物的Y坐标，传入-1则默认为入口Y
-- direct人物面对的方向
function My_Enter_SubScene(sceneid, x, y, direct)
    -- 从大地图进入子场景前自动保存到10号档
    if JY.Status == GAME_MMAP then
        JY.Base['船方向'] = JY.Base['船方向'] + 1
        if JY.Base['船方向'] > 3 then
            JY.Base['船方向'] = 1
        end
        SaveRecord(6 + JY.Base['船方向'])
    end
    JY.SubScene = sceneid;
    local flag = 1; -- 是否自定义的xy坐标, 0是，1否
    if x == -1 and y == -1 then
        JY.Base["人X1"] = JY.Scene[sceneid]["入口X"];
        JY.Base["人Y1"] = JY.Scene[sceneid]["入口Y"];
    else
        JY.Base["人X1"] = x;
        JY.Base["人Y1"] = y;
        flag = 0;
    end

    if direct > -1 then
        JY.Base["人方向"] = direct;
    end

    if JY.Status == GAME_MMAP then
        CleanMemory();
        -- lib.UnloadMMap();
    end
    lib.ShowSlow(20, 1)

    JY.Status = GAME_SMAP; -- 改变状态
    JY.MmapMusic = -1;

    JY.Base["乘船"] = 0;
    JY.MyPic = GetMyPic();

    -- 外景入口是个难点，有些子场景是通过跳转的方式进入的，需要判断
    -- 由于目前最多只能有一个子场景跳转，所以不需要进行循环判断
    local sid = JY.Scene[sceneid]["跳转场景"];

    if sid < 0 or (JY.Scene[sid]["外景入口X1"] <= 0 and JY.Scene[sid]["外景入口Y1"] <= 0) then
        JY.Base["人X"] = JY.Scene[sceneid]["外景入口X1"]; -- 改变出子场景后的XY坐标
        JY.Base["人Y"] = JY.Scene[sceneid]["外景入口Y1"];
    else
        JY.Base["人X"] = JY.Scene[sid]["外景入口X1"]; -- 改变出子场景后的XY坐标
        JY.Base["人Y"] = JY.Scene[sid]["外景入口Y1"];
    end
    Init_SMap(flag); -- 重新初始化地图
    -- lib.LoadPNGPath('./data/smap',0,-1,100)
    if flag == 0 then -- 如果是自定义位置，先传送到那个位置，再显示场景名称
        local name = 0
        local bx = CC.WX
        local by = CC.HY
        local size = CC.DefaultFont * 1.2
        local zi = {}
        local tg = 8 + JY.Base['天关']
        if JY.SubScene == 150 then
            name = "天关" .. numberToChinese(tg) .. "层"
        else
            name = JY.Scene[JY.SubScene]["名称"]
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

-- 简易信息
function JYZTB(id, pid)
    ShowStatus()
end

function QZXS(s)
    DrawStrBoxWaitKey(s, C_GOLD, CC.DefaultFont)
end

-- 显示武功的文字
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

-- 清除贴图文字
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

---对矩形进行屏幕剪裁
-- 返回剪裁后的矩形，如果超出屏幕，返回空
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

-- 计算贴图改变形成的Clip裁剪
-- (dx1,dy1) 新贴图和绘图中心点的坐标偏移。在场景中，视角不同而主角动时用到
-- pic1 旧的贴图编号
-- id1 贴图文件加载编号
-- (dx2,dy2) 新贴图和绘图中心点的偏移
-- pic2 旧的贴图编号
-- id2 贴图文件加载编号
-- 返回，裁剪矩形 {x1,y1,x2,y2}
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

-- 合并矩形
function MergeRect(r1, r2)
    local res = {}
    res.x1 = math.min(r1.x1, r2.x1)
    res.y1 = math.min(r1.y1, r2.y1)
    res.x2 = math.max(r1.x2, r2.x2)
    res.y2 = math.max(r1.y2, r2.y2)
    return res
end

-- 显示阴影字符串
-- 如果x,y传-1，那么显示在屏幕中间
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

-- 无酒不欢：仿造提款机ATM画的数字输入UI
function InputNum(str, minNum, maxNum, isEsc)
    local size = CC.DefaultFont;
    local b_space = size + CC.RowPixel
    local x = (CC.ScreenW - size * 9 - 2 * CC.MenuBorderPixel) / 2;
    local y = (CC.ScreenH - size * 9 - 2 * CC.MenuBorderPixel) / 2;
    local w = size * 9 + 2 * CC.MenuBorderPixel;
    local h = (b_space + CC.RowPixel * 2) * 6;
    local functional_button = {{
        name = "确认"
    }, {
        name = "最大"
    }, {
        name = "清空"
    }, {
        name = "删除"
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

-- 分析字符串中是否有颜色标志
-- 被DrawTxt函数调用
function AnalyString(str)
    local tlen = 0;
    local strcolor = {}
    -- 检查是否有颜色标志
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
                -- 如果已经没有其它颜色标志，直接输入退出循环
                if f1 == nil then
                    table.insert(strcolor, {str, nil});
                    break
                end
            else -- 如果找不到结束标志，直接输入退出循环
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
    local savewz = '保存进度'
    if CC.Save == 0 then
        savewz = '读取进度'
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

-- 存档列表
function SaveList()
    -- 读取R*.idx文件
    local idxData = Byte.create(24)
    Byte.loadfile(idxData, CC.R_IDXFilename[0], 0, 24)
    local idx = {}
    idx[0] = 0
    for i = 1, 6 do
        idx[i] = Byte.get32(idxData, 4 * (i - 1))
    end
    local time_details = os.date("*t")
    JY.Base['存档月'] = time_details.month -- 月
    JY.Base['存档日'] = time_details.day -- 日
    JY.Base['存档时'] = time_details.hour -- 时
    JY.Base['存档分'] = time_details.min -- 分
    -- JY.Base['存档分'] = os.time()

    local table_struct = {}
    table_struct["姓名"] = {idx[1] + 8, 2, 10}
    table_struct["资质"] = {idx[1] + 122, 0, 2}

    table_struct["无用"] = {idx[0] + 2, 0, 2}
    table_struct["难度"] = {idx[0] + 24, 0, 2}

    table_struct["标准"] = {idx[0] + 26, 0, 2}
    table_struct["畅想"] = {idx[0] + 28, 0, 2}
    table_struct["特殊"] = {idx[0] + 30, 0, 2}

    table_struct["天书数量"] = {idx[0] + 36, 0, 2}
    table_struct["武功数量"] = {idx[0] + 38, 0, 2}
    table_struct["场景名称"] = {idx[3] + 2, 2, 10}
    table_struct["碎片"] = {idx[0] + 40, 0, 2}
    table_struct["单通"] = {idx[0] + 32, 0, 2}
    -- 主角编号
    table_struct["队伍1"] = {idx[0] + 72, 0, 2}

    table_struct['存档月'] = {idx[0] + 58, 0, 2}
    table_struct['存档日'] = {idx[0] + 64, 0, 2}
    table_struct['存档时'] = {idx[0] + 68, 0, 2}
    table_struct['存档分'] = {idx[0] + 70, 0, 2}

    table_struct['游历'] = {idx[0] + 66, 0, 2}
    table_struct['分'] = {idx[0] + 20, 0, 2}
    table_struct['时'] = {idx[0] + 18, 0, 2}
    table_struct['秒'] = {idx[0] + 16, 0, 2}
    -- table_struct[WZ7]={idx[2]+88,0,2}

    -- 读取R*.grp文件

    local len = filelength(CC.R_GRPFilename[0]);
    local data = Byte.create(len);

    -- 读取SMAP.grp
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
        -- 天书数量
        local tssl = "";
        -- 主角类型
        local zjlx = "";
        -- 资质
        local zz = "";
        local gametime = ''
        local moshi = ''
        if existFile(string.format(CC.SavePath .. 'Save_%d'..'.sav', i)) then
            --Byte.loadfilefromzip(data, string.format(CC.SavePath .. 'Save_%d', i), CC.SavePath .. 'r.grp', 0, len);
			Byte.loadfilefromzip(data, string.format(CC.SavePath .. 'Save_%d'..'.sav', i),'r.grp', 0, len);
            -- 姓名
            local pid = GetDataFromStruct(data, 0, table_struct, "队伍1");
            name = '姓名：' .. GetDataFromStruct(data, pid * CC.PersonSize, table_struct, "姓名");
            zz = GetDataFromStruct(data, pid * CC.PersonSize, table_struct, "资质");

            -- 类型
            local lxid1 = GetDataFromStruct(data, 0, table_struct, "标准");
            local lxid2 = GetDataFromStruct(data, 0, table_struct, "畅想");
            local lxid3 = GetDataFromStruct(data, 0, table_struct, "特殊");
            if lxid1 > 0 then
                zjlx = "类型：标准"
            elseif lxid2 > 0 then
                zjlx = "类型：畅想"
            elseif lxid3 > 0 then
                zjlx = "类型：特殊"
            end

            -- 难度
            local wz = GetDataFromStruct(data, 0, table_struct, "难度");
            nd = '难度：' .. MODEXZ2[wz]

            -- 模式
            local dt = GetDataFromStruct(data, 0, table_struct, "单通");
            if dt == 0 then
                moshi = '模式：普通'
            elseif dt == 1 then
                moshi = '模式：单通'
            elseif dt == 2 then
                moshi = '模式：娱乐'
            end

            -- 场景
            local wy = GetDataFromStruct(data, 0, table_struct, "无用");
            if wy == -1 then
                sname = "场景：大地图";
            else
                sname = '场景：' .. GetDataFromStruct(data, wy * CC.SceneSize, table_struct, "场景名称") .. "";
            end

            -- 游戏时间		
            -- Byte.loadfile(sdata, string.format(CC.S_GRP,i), 0, slen);	
            local t = GetDataFromStruct(data, 0, table_struct, "秒")
            local t1 = GetDataFromStruct(data, 0, table_struct, "分")
            local t2 = GetDataFromStruct(data, 0, table_struct, "时")
            time = '游戏时间：' .. t2 .. '时' .. t1 .. '分' .. t .. '秒'
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

            time = '游戏时长：' .. t2 .. '时' .. t1 .. '分' .. t3 .. '秒'

            local gtime = os.date('*t', gamet)
            -- 存档时间
            local time0 = gtime.year
            local time1 = gtime.month -- GetDataFromStruct(data, 0, table_struct, "存档月")
            local time2 = gtime.day -- GetDataFromStruct(data, 0, table_struct, "存档日")
            local time3 = gtime.hour -- GetDataFromStruct(data, 0, table_struct, "存档时")
            local time4 = gtime.min -- GetDataFromStruct(data, 0, table_struct, "存档分")
            local time5 = gtime.sec
            gametime = '存档时间：' .. time1 .. '月' .. time2 .. '日' .. time3 .. '时' .. time4 .. '分'
            -- time0 = GetDataFromStruct(data, 0, table_struct, "存档分")
        end
        local bwz = {'一', '二', '三', '四', '五', '六', '七', '八', '九', '十'}
        local zd = bwz[i - 6]

        if i <= 6 then
            menu[i] = {'存档' .. bwz[i], zjlx, name, nd, moshi, sname, time, gametime, 1, i}
        else
            menu[i] = {'自动档' .. zd, zjlx, name, nd, moshi, sname, time, gametime, 1, i}
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
    if CC.OpenTimmerRemind ~= 1 then -- 动态提示是否打开
        -- return;
    end
    -- CC.Timer={
    -- stime=0, -- 时间
    -- status=0, --状态
    -- str='', --内容
    -- len=0, --长度1
    -- fun=demostr, --CD
    -- CC.RUNSTR --文字表格
    local t2 = lib.GetTime(); -- 系统时间 

    if JY.Status == GAME_SMAP or JY.Status == GAME_MMAP then
        if CC.Timer.status == 0 then
            if CC.TX['昆仑蟠桃'] > 0 then
                CC.Timer.stime = t2;
                CC.Timer.status = 1;
                CC.Timer.str = "★★传闻昆仑仙境有异宝现世。"
                CC.Timer.len = string.len(CC.Timer.str) / 2;
                CC.TX['颜色'] = 1
            elseif CC.Day == 8 or CC.Day == 7 then
                -- lib.Debug('江陵初九比武')
                CC.Timer.stime = t2;
                CC.Timer.status = 1;
                CC.Timer.str =
                    "★★江陵城即将在初九日举行比武，请各路侠客踊跃参于，争夺神秘大奖。"
                CC.Timer.len = string.len(CC.Timer.str) / 2;
                CC.TX['颜色'] = 2
            elseif CC.Day == 18 or CC.Day == 17 then
                -- lib.Debug('金陵十九比武')
                CC.Timer.stime = t2;
                CC.Timer.status = 1;
                CC.Timer.str =
                    "★★江陵城即将在十九日举行比武，请各路侠客踊跃参于，争夺神秘大奖。"
                CC.Timer.len = string.len(CC.Timer.str) / 2;
                CC.TX['颜色'] = 3
            elseif CC.TX['西域奇商'] > 0 then
                -- lib.Debug('西域奇商出现')
                CC.Timer.stime = t2;
                CC.Timer.status = 1;
                if CC.TX['西域奇商'] < 1000 then
                    CC.Timer.str = "★★西域商人即将离开扬州。"
                else
                    CC.Timer.str = "★★西域商人在扬州出现。"
                end
                CC.Timer.len = string.len(CC.Timer.str) / 2;
                CC.TX['颜色'] = 4
            elseif t2 - CC.Timer.stime > 300 or CC.Timer.stime == 0 then
                -- lib.Debug('操作信息提示')
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
    lib.SetClip(bx * 915, 0, bx * 1336, 0 + pch) -- 裁剪
    if CC.TX['颜色'] > 0 then
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

-- 无酒不欢：添加事件函数
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

-- 无酒不欢：删除事件函数
function null(sid, pid)
    addevent(sid, pid, 0, 0, 0, 0)
end

-- 加入队友
function showCXStatic(id)
    local bx, by = CC.WX * 210, CC.HY * 50
    if existFile(CC.Acvmts) then
        dofile(CC.Acvmts)
        local r = false
        local ndChn = {"简单", "普通", "困难", "地狱"}
        local highLvl
        if Achievements.rdsCpltd[id].lvlReached2 > 0 then
            highLvl = Achievements.rdsCpltd[id].lvlReached1 .. "周" .. ndChn[Achievements.rdsCpltd[id].lvlReached2]
        else
            highLvl = "暂无"
        end
        while true do
            if JY.Restart == 1 then
                return
            end
            Cls()

            lib.LoadPNG(91, 30 * 2, bx, by, 3)

            DrawString(bx + CC.WX * 390, by + CC.HY * 10, JY.Person[id]["姓名"], C_GOLD, CC.FontBig * 0.9)

            DrawString(bx + CC.WX * 80, by + CC.HY * 130, "通关次数：" .. Achievements.rdsCpltd[id].n .. "次", C_WHITE, CC.DefaultFont)
            DrawString(bx + CC.WX * 80, by + CC.HY * 200, "最高通关难度：" .. highLvl, C_WHITE, CC.DefaultFont)
            DrawString(CC.ScreenW / 2 - 160, CC.ScreenH - 40, "回车键确认 ESC返回上层", LimeGreen,CC.DefaultFont * 0.98)

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

-- 无酒不欢：获取武功威力
function get_skill_power(personid, wugongid, wugonglvl)
    local power;
    local p = JY.Person[personid]
    local lx = JY.Wugong[wugongid]['武功类型']
    local mp = JY.Wugong[wugongid]['门派']
    local dkfcj_ng = JY.Wugong[JY.Person[personid]['主运内功']]['层级']
    local nglv = KF_level(personid, JY.Person[personid]['主运内功'])
    -- 到极的武功按10级威力算
    if wugonglvl == 11 then
        wugonglvl = 10
    end
    local spower = 0
    power = JY.Wugong[wugongid]["攻击力" .. wugonglvl]
    spower = power
    -- 外功到极，威力+10%
    for i = 1, JY.Base['武功数量'] do
        local level = math.modf(p["武功等级" .. i] / 100) + 1
        if p["武功等级" .. i] == 999 and JY.Wugong[wugongid]['武功类型'] ~= 6 and wugongid == p['武功' .. i] then
            power = power * 1.1
            break
        end
    end
    -- 内轻特效700
    if NeiGong_tx(personid, 700) then
        for i = 1, JY.Base['武功数量'] do
            local kf = JY.Person[personid]['武功' .. i]
            if wugongid == kf then
                power = power + dkfcj_ng * 10 * nglv
            end
        end
    end
    if wugongid >= 109 and wugongid <= 112 then
        local xs = 0

        if lx == 1 then
            xs = TrueQZ(personid) -- JY.Person[personid]["拳掌功夫"]
        elseif lx == 2 then
            xs = TrueZF(personid) -- JY.Person[personid]["指法技巧"]
        elseif lx == 3 then
            xs = TrueYJ(personid) -- JY.Person[personid]["御剑能力"]    
        elseif lx == 4 then
            xs = TrueSD(personid) -- JY.Person[personid]["耍刀技巧"]
        elseif lx == 5 then
            xs = TrueTS(personid) -- JY.Person[personid]["特殊兵器"]
        end
        if isteam(personid) then
            power = limitX(power + xs * 3, 300, 1500)
        else
            power = 1500
        end
    end
    -- 我欲成仙
    if Pmiji(personid, 77) then
        if wugongid == 8 or wugongid == 14 or wugongid == 201 or wugongid == 202 then
            power = power + 250
        end
    end
    -- 裂石
    if JY.Person[personid]["奇穴" .. 3] == 1 and lx == 2 then
        power = power + 200
    end
    -- 双剑双绝
    if match_ID(personid, 9735) and (lx == 3 or lx == 4) then
        power = power + 200
    end
    -- 提高天赋内功的威力
    if power < 1000 and Given_NG(personid, wugongid) then
        power = power + 100
        if power > 1000 then
            power = 1000
        end
    end
    -- 华山长老反两仪刀法
    if wugongid == 60 then
        if match_ID(personid, 108) or match_ID(personid, 107) then
            power = power + 200
        end
    end
    -- 天山双鹰	
    if wugongid == 4 then
        if match_ID(personid, 311) or match_ID(personid, 312) then
            power = power + 500
        end
    end
    -- 五虎断魂
    if wugongid == 59 then
        if match_ID(personid, 106) then
            power = power + 200
        end
    end
    -- 学了葵花之后，辟邪的威力
    if wugongid == 48 and PersonKF(personid, 105) then
        power = power + 1000
    end
    -- 妙手书生
    if wugongid == 142 then
        if match_ID(personid, 131) then
            power = power + 200
        end
    end
    -- 韦陀双鹤
    if match_ID(personid, 742) and wugongid == 347 then
        power = power + 400
    end
    -- 八仙剑
    if match_ID(personid, 743) and wugongid == 326 then
        power = power + 400
    end
    -- 铁掌宗师
    if wugongid == 13 then
        if match_ID(personid, 567) then
            power = power + 500
        end
    end
    -- 岳家将
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
    -- 魔道祖师
    if mp == 5 then
        if match_ID(personid, 641) then
            power = power + 400
        end
    end
    -- 太上掌门 
    if wugongid == 37 then
        if match_ID(personid, 166) then
            power = power + 200
        end
    end
    -- 佛门无双
    if JY.Wugong[wugongid]['门派'] == 1 then
        if match_ID(personid, 9993) then
            power = power + 500
        end
    end
    -- 青城掌门
    if JY.Wugong[wugongid]['门派'] == 11 then
        if match_ID(personid, 220) then
            power = power + 500
        end
    end
    -- 衡山掌门
    if JY.Wugong[wugongid]['门派'] == 12 then
        if match_ID(personid, 379) then
            power = power + 500
        end
    end
    -- 恒山掌门 晓风残月
    if JY.Wugong[wugongid]['门派'] == 13 then
        if match_ID(personid, 21) or match_ID(personid, 387) then
            power = power + 500
        end
    end
    -- 泰山掌门
    if JY.Wugong[wugongid]['门派'] == 14 then
        if match_ID(personid, 201) then
            power = power + 500
        end
    end
    -- 雪山掌门
    if JY.Wugong[wugongid]['门派'] == 18 then
        if match_ID(personid, 250) or match_ID(personid, 43) then
            power = power + 500
        end
    end
    -- 峨眉掌门
    if JY.Wugong[wugongid]['门派'] == 19 then
        if match_ID(personid, 6) then
            power = power + 500
        end
    end
    -- 崆峒掌门
    if JY.Wugong[wugongid]['门派'] == 20 then
        if match_ID(personid, 8) or match_ID(personid, 359) then
            power = power + 500
        end
    end
    -- 昆仑掌门
    if JY.Wugong[wugongid]['门派'] == 21 then
        if match_ID(personid, 7) then
            power = power + 500
        end
    end
    -- 金乌翠鸣
    if match_ID(personid, 249) and wugongid == 61 then
        power = power + 400
    end

    -- 黄钟公
    if match_ID(personid, 34) and wugongid == 73 and JY.Person[0]["六如觉醒"] > 0 then
        power = power * 2
    end
    -- 仁义刀刀法威力翻倍
    if match_ID(personid, 94) and JY.Wugong[wugongid]["武功类型"] == 4 then
        power = power * 2
    end
    -- 黑白子
    if match_ID(personid, 33) and wugongid == 72 and JY.Person[0]["六如觉醒"] > 0 then
        power = power * 2
    end
    -- 秃笔翁
    if match_ID(personid, 32) and wugongid == 142 and JY.Person[0]["六如觉醒"] > 0 then
        power = power * 2
    end
    -- 丹青生
    if match_ID(personid, 31) and wugongid == 84 and JY.Person[0]["六如觉醒"] > 0 then
        power = power * 2
    end
    -- 瓦耳拉齐
    if match_ID(personid, 138) then
        if JY.Wugong[wugongid]["武功类型"] == 2 then
            if JY.Base["畅想"] == personid then
                power = power + (50 * JY.Base["天书数量"])
            else
                power = power + 200
            end
        end
    end
    -- 鳌拜
    if match_ID(personid, 603) and wugongid == 119 then
        power = power * 2
    end
    -- 神算子
    if wugongid == 37 then
        if match_ID(personid, 109) then
            power = power + 200
        end
    end
    -- 聚贤庄主
    if JY.Wugong[wugongid]["武功类型"] == 5 then
        if match_ID(personid, 110) or match_ID(personid, 111) then
            power = power + 150
        end
    end
    -- 觉醒后翻倍的众人
    -- 王重阳+全真七子，全真剑法
    if wugongid == 39 then
        if match_ID(personid, 123) or match_ID(personid, 124) or match_ID(personid, 125) or match_ID(personid, 126) or
            match_ID(personid, 127) or match_ID(personid, 128) or match_ID(personid, 68) then
            power = power * 2
        end
    end
    if match_ID(personid, 129) and JY.Wugong[wugongid]["门派"] == 7 then
        power = power * 2
    end

    -- 梅超风，黄衫女九阴白骨爪
    if wugongid == 11 and JY.Person[0]["六如觉醒"] > 0 and (match_ID(personid, 78) or match_ID(personid, 640)) then
        power = power * 1.5
    end
    -- 悲天佛怜
    if wugongid == 189 and (match_ID(personid, 9983) or JinGangBR(personid)) then
        power = power * 1.5
    end
    -- 八卦套
    if (wugongid == 230 or wugongid == 231) and PersonKF(personid, 235) then
        power = power + 200
    end
    -- 金蛇剑法
    if wugongid == 40 then
        -- 夏雪宜
        if match_ID(personid, 639) then
            power = power * 1.5
        end
        -- 青莽剑
        if match_ID(personid, 137) then
            power = power + 200
        end
    end
    -- 阿秀 雪山剑法
    if wugongid == 35 and match_ID(personid, 9739) then
        power = power * 1.5
    end

    -- 韦一笑，寒冰绵掌
    if wugongid == 5 and JY.Person[0]["六如觉醒"] > 0 and match_ID(personid, 14) then
        power = power * 1.5
    end
    -- 殷天正，鹰爪功
    if wugongid == 4 and match_ID(personid, 12) then
        power = power * 1.5
    end
    -- 朱聪，分筋错骨手
    if wugongid == 117 and JY.Person[0]["六如觉醒"] > 0 and match_ID(personid, 131) then
        power = power * 1.5
    end
    -- 周威信呼延十八鞭威力翻倍
    if match_ID(personid, 612) and wugongid == 206 and JY.Status == GAME_WMAP and WAR.ZWX > 0 then
        power = power * WAR.ZWX
    end
    -- 卓天雄呼延十八鞭威力翻倍
    if match_ID(personid, 613) and wugongid == 206 and JY.Status == GAME_WMAP and WAR.ZWX > 0 then
        power = power * WAR.ZWX
    end
    -- 卓天雄震天铁掌威力翻倍
    if match_ID(personid, 613) and wugongid == 205 and JY.Status == GAME_WMAP and WAR.ZWX > 0 then
        power = power * WAR.ZWX
    end

    -- 曲非烟持瑶琴威力翻倍
    if match_ID(personid, 510) and wugongid == 73 then
        power = power * 2
    end

    -- 天刀九问
    if wugongid == 335 then
        power = power + JY.Base["天书数量"] * 100
    end

    -- 何铁手战斗中五毒威力翻倍
    if (match_ID(personid, 83) or match_ID(personid, 9814)) and wugongid == 3 and JY.Status == GAME_WMAP and WAR.HTS > 0 then
        power = power * WAR.HTS
    end

    -- 林朝英，惊才绝艳
    if match_ID(personid, 605) then
        power = power * 1.1
    end

    -- 余沧海松风剑法翻倍
    if wugongid == 27 and JY.Person[0]["六如觉醒"] > 0 and (match_ID(personid, 24) or match_ID(personid, 9891)) then
        power = power * 2
    end
    -- 觉醒后余沧海松风剑法翻倍
    if wugongid == 27 and (match_ID(personid, 24) or match_ID(personid, 9891)) then
        power = power * 2
    end

    -- 提高天赋外功的威力
    if Given_WG(personid, wugongid) then
        power = power + 200
    end

    -- 袁冠南 夫妻刀法 1.5倍
    if wugongid == 62 and match_ID(personid, 566) then
        power = power + 300
    end

    -- 袁紫衣威力翻倍
    if match_ID(personid, 587) and (wugongid == 78 or wugongid == 164) then
        power = power + 300
    end

    -- 天池怪侠
    if match_ID(personid, 9988) and wugongid == 10 then
        power = power + 600
    end
    -- 七宝指环加成逍遥派武功
    if JY.Person[personid]["武器"] == 200 then
        if mp == 3 then
            power = power + 100
        end
    end

    -- 太极套
    if (wugongid == 16 or wugongid == 46) and Curr_NG(personid, 171) then
        power = power + 200
    end

    -- 枯荣禅功 一阳指
    if wugongid == 17 and PersonKF(personid, 207) then
        power = power + 200
    end
    -- 仙剑神猿
    if wugongid == 188 then
        if (match_ID(personid, 185) and JY.Person[personid]["坐骑"] == 326) or match_ID(personid, 575) then
            power = power + 500
        end
    end
    -- 天山折梅手，虚竹，童姥，无崖子，李秋水，威力提高
    if wugongid == 14 then
        if match_ID(personid, 9815) then
            for i = 1, JY.Base["武功数量"] do
                if JY.Person[personid]["武功" .. i] ~= 14 and JY.Person[personid]["武功等级" .. i] == 999 then
                    power = power + 50
                end
            end
        end
    end
    -- 伏魔禅杖 伏魔杖法
    if wugongid == 86 and JY.Person[personid]["武器"] == 323 then
        power = power + 200
    end
    -- 白猿 猿公剑法
    if (wugongid == 188 or wugongid == 156) and JY.Person[personid]["坐骑"] == 326 then
        power = power + 200
    end

    if wugongid == 110 and JY.Person[personid]["武器"] == 55 then
        power = power + 200
    end
    if wugongid == 111 and JY.Person[personid]["武器"] == 56 then
        power = power + 200
    end
    if wugongid == 112 and JY.Person[personid]["武器"] == 57 then
        power = power + 200
    end

    -- 白秀雪山剑法
    if wugongid == 35 then
        if match_ID_awakened(personid, 582, 1) then
            for i = 1, JY.Base["武功数量"] do
                if JY.Person[personid]["武功" .. i] ~= 35 and JY.Person[personid]["武功等级" .. i] == 999 then
                    power = power + 100
                end
            end
        end
    end

    -- 丁当金乌刀法
    if wugongid == 61 and match_ID_awakened(personid, 581, 1) then
        power = power + 300
    end
    -- 五岳剑法威力提高
    if wugongid >= 30 and wugongid <= 34 then
        power = power + WuyueJFSL(personid) * 100
    end
    -- 五岳剑法+五岳剑诀，威力提高
    if wugongid >= 30 and wugongid <= 34 and PersonKF(personid, 175) then
        power = power + 200
    end
    -- 双剑合壁，威力提高
    if (wugongid == 39 or wugongid == 42 or wugongid == 139) and ShuangJianHB(personid) then
        power = power + 300
    end
    -- 琴棋书画威力提高
    if (wugongid == 73 or wugongid == 72 or wugongid == 84 or wugongid == 142) and Pmiji(personid, 63) then
        power = power + 300
    end
    -- 桃花绝技威力提高
    if (wugongid == 12 or wugongid == 18 or wugongid == 38) and Pmiji(personid, 5) then
        power = power + 200
    end
    -- 毒布武林威力提高 标记修改
    if (wugongid == 3 or wugongid == 120 or wugongid == 220 or wugongid == 295 or wugongid == 334) and
        Pmiji(personid, 8) then
        power = power + 500
    end
    -- 紫气天罗威力提高
    if (wugongid == 5 or wugongid == 9 or wugongid == 21 or wugongid == 118) and Pmiji(personid, 6) then
        power = power + 300
    end
    -- 我欲成仙威力提高
    if (wugongid == 8 or wugongid == 14 or wugongid == 201 or wugongid == 202) and Pmiji(personid, 7) then
        power = power + 250
    end
    -- 易筋加强少林武学
    if JY.Wugong[wugongid]["门派"] == 1 and PersonKF(personid, 108) then
        if Curr_NG(personid, 108) then
            power = power + 200
        else
            power = power + 100
        end
    end
    -- 九阴神功对白骨爪威力提高
    if wugongid == 11 and PersonKF(personid, 107) then
        power = power + 200
    end
    -- 武器装备威力加成
    for i, v in ipairs(CC.ExtraOffense) do
        if v[1] == JY.Person[personid]["武器"] and v[2] == wugongid then
            power = power + v[3]
        end
    end
    -- 只有战斗中才有的加成
    if JY.Status == GAME_WMAP then
        -- 太极神功蓄力
        -- 只有战斗中才有的加成
        if Curr_NG(personid, 171) and (wugongid == 16 or wugongid == 46) and WAR.tmp[3000 + personid] ~= nil and
            WAR.tmp[3000 + personid] > 0 then
            if wugongid == 16 then
                power = power + WAR.tmp[3000 + personid] * 1.5
            else
                power = power + WAR.tmp[3000 + personid]
            end
        end
        if WAR.PD['雪花六出'][personid] ~= nil and wugongid == 35 then
            power = power + spower * WAR.PD['雪花六出'][personid] * 0.5
        end
    end
    -- 谁与争锋
    if match_ID(personid, 9734) then
        if JY.Person[personid]["武器"] == 37 and lx == 3 then
            power = power + 200
        end
    end
    -- 拳法精通
    if match_ID(personid, 9960) and JY.Wugong[wugongid]["武功类型"] == 1 then
        power = power + 100
    end
    -- 指法精通
    if match_ID(personid, 9959) and JY.Wugong[wugongid]["武功类型"] == 2 then
        power = power + 100
    end
    -- 剑法精通
    if match_ID(personid, 9958) and JY.Wugong[wugongid]["武功类型"] == 3 then
        power = power + 100
    end
    -- 刀法精通
    if match_ID(personid, 9957) and JY.Wugong[wugongid]["武功类型"] == 4 then
        power = power + 100
    end
    -- 奇门精通
    if match_ID(personid, 9956) and JY.Wugong[wugongid]["武功类型"] == 5 then
        power = power + 100
    end
    -- 千手神通
    if match_ID(personid, 9954) and JY.Wugong[wugongid]["武功类型"] == 2 then
        power = power + 200
    end
    -- 剑术通神
    if match_ID(personid, 9953) and JY.Wugong[wugongid]["武功类型"] == 3 then
        power = power + 200
    end
    -- 傲世狂刀
    if match_ID(personid, 9952) and JY.Wugong[wugongid]["武功类型"] == 4 then
        power = power + 200
    end
    -- 奇门无双
    if match_ID(personid, 9951) and JY.Wugong[wugongid]["武功类型"] == 5 then
        power = power + 200
    end
    -- 奇门无双
    if match_ID(personid, 9951) and JY.Wugong[wugongid]["武功类型"] == 5 then
        power = power + 200
    end
    -- 胡一刀 辽东大侠
    if match_ID(personid, 633) and JY.Person[personid]["武器"] == 45 and wugongid == 67 then
        power = power + 200
    end
    -- 冯蘅
    if match_ID(personid, 588) and (wugongid == 18 or wugongid == 38 or wugongid == 12 or wugongid == 126) then
        power = power + 200
    end
    -- 八卦刀 标记修改
    if match_ID(personid, 9921) and wugongid == 231 then
        power = power + 400
    end
    -- 八卦掌 标记修改
    if match_ID(personid, 9920) and wugongid == 230 then
        power = power + 400
    end
    -- 五六七 标记修改
    if match_ID(personid, 9919) and JY.Wugong[75]["名称"] == "大剪刀" and wugongid == 75 then
        power = power + 567
    end
    if match_ID(personid, 9919) and JY.Wugong[75]["名称"] == "魔刀千刃" and wugongid == 75 then
        power = power + 1000
    end

    -- 賽尚鄂 标记修改
    if match_ID(personid, 9915) and wugongid == 119 then
        power = power + 600
    end
    --内功特效906
    if NeiGong_tx(personid,906) and lx == 1 then 
        power = power + dkfcj_ng*200
    end
    --内功特效907
    if NeiGong_tx(personid,907) and lx == 2 then 
        power = power + dkfcj_ng*200
    end    
    --内功特效908
    if NeiGong_tx(personid,908) and lx == 3 then 
        power = power + dkfcj_ng*200
    end
    --内功特效909
    if NeiGong_tx(personid,909) and lx == 4 then 
        power = power + dkfcj_ng*200
    end
    --内功特效910
    if NeiGong_tx(personid,910) and lx == 5 then 
        power = power + dkfcj_ng*200
    end        
    -- 门派职务加强门派武学威力
    for i = 1, #MPname do
        local mp = JY.Person[personid]["门派"]
        local zw = math.modf(JY.Person[personid]["门派贡献"] / 200) + 1
        if mp == JY.Wugong[wugongid]["门派"] then
            power = power + zw * 50
            break
        end
    end
    -- 主运门派内功加强门派武学威力
    local zyng = JY.Person[personid]["主运内功"]
    local mp = JY.Person[personid]["门派"]
    if JY.Wugong[zyng]["门派"] == mp then
        if JY.Wugong[wugongid]["门派"] == mp then
            if JY.Person[personid]["门派"] == mp then
                power = power + 50 * JY.Wugong[wugongid]["层级"]
            else
                power = power + 25 * JY.Wugong[wugongid]["层级"]
            end
        end
    end
    return power
end

-- 无酒不欢：判定天赋外功的函数
function Given_WG(personid, WGid)
    local tw = false;
    for i = 1, 2 do
        if JY.Person[personid]["天赋外功" .. i] == WGid then
            tw = true;
            break
        end

    end
    return tw;
end

-- 无酒不欢：判定天赋内功的函数
function Given_NG(personid, NGid)
    local tw = false;
    if JY.Person[personid]["天赋内功"] == NGid then
        tw = true;
    end
    return tw;
end

-- 人物恢复站定
function stands()
    JY.MyCurrentPic = 0
    if JY.Person[0]["性别"] == 0 then
        JY.MyPic = CC.MyStartPicM + JY.Base["人方向"] * 7 + JY.MyCurrentPic;
    else
        JY.MyPic = CC.MyStartPicF + JY.Base["人方向"] * 7 + JY.MyCurrentPic;
    end
end

-- 无酒不欢：马车的选择菜单
function TeleportMenu(menu, color, selectColor)
    local bx, by = CC.ScreenW / 1360, CC.ScreenH / 768
    local x1 -- 菜单起始X坐标
    local y1 -- 菜单起始Y坐标
    local w -- 菜单bx
    local h -- 菜单by
    local maxlength -- 单位最大长度
    local size = CC.Fontsmall -- 字体大小

    x1 = CC.MainMenuX + bx * 210
    y1 = CC.MainMenuY + CC.Fontsmall * 2 + by * 30

    maxlength = 8
    local cx = size * maxlength / 2 + CC.RowPixel * 3
    local cy = size + CC.RowPixel * 2 - by * 1
    w = cx * 7 + CC.MenuBorderPixel -- 7为lieshu
    h = cy * 15 + CC.MenuBorderPixel -- 16为最大行数

    lib.GetKey();
    Cls();
    local pw, ph = lib.GetPNGXY(91, 537 * 2)
    lib.LoadPNG(91, 537 * 2, CC.ScreenW / 2 - pw / 2, CC.ScreenH / 2 - ph / 2, 1, CC.ScreenW / 100 * 100) -- 背景图

    -- 建立七个表格来存储不同类型的场景
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

    -- v123分别为场景名称，可否进入，场景编号
    -- v2为0代表可进入，1代表不可进入
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

    -- 场景信息
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
    local PType_name = {"客栈城镇", "江湖帮派", "江湖帮会", "人物居所", "名山大川", "山洞岛屿",
                        "杂类场所"}

    -- 光标的初始位置
    local cursor_x = 1
    local cursor_y = 1
    local tb = 1
    local start = 1

    -- 返回值
    local returnValue = -1;

    local surid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)

    while true do
        if JY.Restart == 1 then
            break
        end
        lib.LoadSur(surid, 0, 0)
        -- DrawString(x1+10,y1-CC.RowPixel*4-7,"X:"..cursor_x.."，Y:"..cursor_y.."，tb:"..tb,LimeGreen,size);	--输出测试信息
        local row = 15
        for i = 1, 7 do
            -- 大类名称
            for j = start, start + row - 1 do
                if j > P_inf[i][2] then
                    break
                end
                -- 确定当前单位编号
                local id = 0
                for jj = 1, i do
                    id = id + P_inf[jj - 1][2]
                end
                id = id + j
                -- 无法进入的场景名称为灰色
                local drawColor = C_WHITE1;
                if P_inf[i][1][j][2] == 1 then
                    drawColor = M_DimGray
                end
                local xx = x1 + (i - 1) * (cx) + CC.MenuBorderPixel
                local yy = y1 + (j - start) * (cy)
                lib.Background(xx - bx * 5, yy - by * 5, xx + size * maxlength / 2, yy + size + by * 5, 80, C_BLACK)
                -- 区别当前选中的单位颜色
                if id == tb then
                    drawColor = C_RED;
                    -- lib.Background(xx-bx*5, yy-by*5, xx + size*maxlength/2, yy + size + by*5, 128, drawColor)
                    DrawBox(xx - bx * 5, yy - by * 5, xx + size * maxlength / 2, yy + size + by * 5, 128, drawColor)
                end
                -- 显示场景名称
                local name = P_inf[i][1][j][1]
                DrawString(xx - string.len(name) / 4 * size + bx * 52, yy, P_inf[i][1][j][1], drawColor, size);
            end
        end

        ShowScreen();
        local keyPress, ktype, mx, my = WaitKey(1)

        lib.Delay(CC.Frame);

        -- ktype  1：键盘，2：鼠标移动，3:鼠标左键，4：鼠标右键，5：鼠标中键，6：滚动上，7：滚动下
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
    -- 返回值
    return returnValue
end

-- 传送地址列表
function My_ChuangSong_List()
    local menu = {};
    JY.Scene[93]["场景类型"] = 2
    for i = 0, JY.SceneNum - 1 do
        -- 不显示的场景：闯王宝藏1 3 明教地道，高昌迷宫+沙漠废墟3组 少林寺 思过崖 梅庄地牢 大功坊地窖 无量山洞 鹿鼎山1 3 少林后山 皇宫 北京郊外 鳌府密室 华山绝顶 绝情谷底 古墓密道 峨眉金顶 鹊桥 黑山大会
        if (i == 0 or i == 1 or i == 5 or i == 13 or i == 14 or i == 15 or i == 28 or i == 38 or i == 42 or i == 44 or i ==
            46 or i == 49 or i == 55 or i == 57 or i == 58 or i == 61 or i == 67 or i == 69 or i == 70 or
            (i >= 80 and i <= 83) or i == 84 or i == 85 or i == 86 or i == 88 or i == 89 or i == 91 or i == 102 or i ==
            104 or i == 106 or i == 108 or i == 109 or i == 110 or i == 111 or i == 113 or i == 114 or i == 115 or i ==
            116 or i == 117 or i == 118 or i == 119 or i == 122 or i == 123 or i == 126 -- or i== 130
        or i == 131 or i == 132 or i == 134 or i == 137 or i == 138 or i == 140 or i == 141 or i == 142 or i == 143 or i ==
            144 or i == 145 or i == 146 or i == 147 or i == 148 or i == 149 or i == 150 or i == 155) or i == 161 or i ==
            162 or i == 164 or i == 165 and JY.Scene[i]["场景类型"] ~= 8 then
        else
            -- 无酒不欢：这里i即为场景编号
            menu[i + 1] = {JY.Scene[i]["名称"], JY.Scene[i]["进入条件"], i, JY.Scene[i]["场景类型"]};
        end
    end
    -- 颜色依次为常规颜色和选中颜色
    local r = TeleportMenu(menu, C_GOLD, C_WHITE);

    -- 返回值小于0（ESC），直接返回
    if r < 0 then
        return 0;
    end
    -- 返回值大于等于0，返回值即为场景编号
    if r >= 0 then
        local sid = r;
        My_Enter_SubScene(sid, -1, -1, -1);
    end
    return 1;
end

-- 无酒不欢：判断队伍是不是有两个空位
function More_than_2_vacant_slot()
    if JY.Base["队伍14"] == -1 and JY.Base["队伍15"] == -1 then
        return true
    end
    return false
end

-- 无酒不欢：个人觉醒
function awakening(id, value)
    local xwperson; -- 判定要觉醒的人
    if id == JY.Base["畅想"] then
        xwperson = 0
    else
        xwperson = id
    end

    JY.Person[xwperson]["个人觉醒"] = JY.Person[xwperson]["个人觉醒"] + value
end

-- 无酒不欢：增加武常
function kungfu_knowledge(id, value)
    local xwperson; -- 判定要增加武常的人
    if id == JY.Base["畅想"] then
        xwperson = 0
    else
        xwperson = id
    end
    JY.Person[xwperson]["武学常识"] = JY.Person[xwperson]["武学常识"] + value
end

-- 无酒不欢：判定是否为指定ID的人物，并且判定是否达到指定觉醒次数
function match_ID_awakened(personid, id, awkntimes)

    if CC.Copy[personid] ~= nil then
        personid = CC.Copy[personid]
    end

    if personid == id then
        if JY.Person[personid]["个人觉醒"] >= awkntimes then
            return true
        else
            return false
        end
    elseif personid == 0 and JY.Base["畅想"] == id then
        if JY.Person[0]["个人觉醒"] >= awkntimes then
            return true
        else
            return false
        end
    elseif personid == 0 and JY.Base["单通"] == 2 and instruct_16(id) then
        if JY.Person[0]["个人觉醒"] >= awkntimes then
            return true
        else
            return false
        end
    else
        return false
    end
end

-- 直接设定指定人物的资质
function set_potential(id, value)
    local xwperson; -- 判定要指定资质的人
    if id == JY.Base["畅想"] or (JY.Base["单通"] == 2 and instruct_16(id)) then
        xwperson = 0
    else
        xwperson = id
    end
    JY.Person[xwperson]["资质"] = value
end

-- 无酒不欢：判定是不是显示特技
function secondary_wugong(wugongid)

    -- 老顾
    -- if JY.Wugong[wugongid]["武功类型"] == 8 then
    --	return true
    -- end		
    -- 轻功
    if JY.Wugong[wugongid]["武功类型"] == 7 then
        return true
        -- 吸功，金刚不坏，五岳剑诀 李飞刀 武穆遗书
    elseif wugongid == 85 or wugongid == 87 or wugongid == 88 or wugongid == 144 or wugongid == 175 or wugongid == 182 or
        wugongid == 199 or wugongid == 43 then
        return true
    end
    return false
end

-- 老顾
function WGZHAOSHI(wugongid)
    if wugongid == 26 or wugongid == 25 or wugongid == 21 or wugongid == 45 or wugongid == 46 or wugongid == 48 or
        wugongid == 67 or wugongid == 66 or wugongid == 153 or wugongid == 80 or wugongid == 82 or wugongid == 81 or
        wugongid == 49 or wugongid == 138 or wugongid == 11 then
        return true
    end
    return false
end

-- 无酒不欢：判定主运内功的函数
function Curr_NG(personid, NGid)
    if PersonKF(personid, NGid) then
        if JY.Person[personid]["主运内功"] == NGid then
            return true
        end
    end
    -- 天罡的判定
    if personid == 0 and JY.Person[personid]['内力性质'] == 3 then
        -- 如果是天内，并且已经学会，则自动主运
        if JY.Person[personid]["天赋内功"] == NGid and PersonKF(personid, NGid) then
            -- Hp_Max(personid)
            return true
        end
    end
    local pmenu = {
                    {9997,175}, --五岳
                    {22,175},--五岳
                    {21,175},--五岳
                    {20,175},--五岳
                    {23,175},--五岳
                    {637,107},--黄赏 九阴
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
    --五岳掌门
    -- 物转星移
    if PersonKF(personid, 43) and KF_level(personid, 43) > 10 and JY.Person[personid]['奇穴' .. 149] == 1 and NGid ==  43 then
        return true
    end
    -- 老顾1209
    if PersonKF(personid, 177) and NGid == 177 then
        local ts = false
        if (personid == 752 or personid == 652) and (JY.Base["天书数量"] >= 7 or inteam(personid) == false) and  CC.TX["忘情天书"] == 1 then
            ts = true
        end
        if ts == true then
            return true
        end
    end
    if PersonKF(personid, 104) and PersonKF(personid, 107) and NGid == 104 and JY.Person[personid]["主运内功"] ==  107 then
        return true
    end
    return false
end

-- 无酒不欢：判定主运轻功的函数
function Curr_QG(personid, QGid)
    if JY.Person[personid]["主运轻功"] == QGid and PersonKF(personid, QGid) then
        return true
    end
    if match_ID(personid, 9963) and QGid == 186 and PersonKF(personid, QGid) then
        return true
    end
    if match_ID(personid, 130) and QGid == 145 and PersonKF(personid, QGid) then
        return true
    end
    if match_ID(personid, 633) and QGid == JY.Person[personid]["天赋轻功"] and PersonKF(personid, QGid) then
        return true
    end
    return false
end

-- 无酒不欢：判定人物面板上极的个数
function calc_mas_num(id)
    local mas_num = 0;
    for i = 1, JY.Base["武功数量"] do
        if JY.Person[id]["武功等级" .. i] == 999 then
            mas_num = mas_num + 1;
        end
    end
    return mas_num
end

-- 无酒不欢：判定是否为指定ID的人物，用作天赋等判定
function match_ID(personid, id)

    for i = 1, 5 do
        if JY.Person[personid]['天赋' .. i] == id then
            return true
        end
    end
    if personid == 0 and JY.Base["畅想"] > 0 then
        personid = JY.Base["畅想"]
    end

    if (personid == 0 or personid == JY.Base["畅想"]) and JY.Base["单通"] == 2 and instruct_16(id) then
        return true
    end

    if CC.Copy[personid] ~= nil then
        personid = CC.Copy[personid]
    end

    return false
end

-- 无酒不欢：返回人物所学内功的数量
function NGnum(id)
    local num = 0
    for i = 1, JY.Base["武功数量"] do
        local kfid = JY.Person[id]["武功" .. i]
        if JY.Wugong[kfid]["武功类型"] == 6 then
            num = num + 1
        end
    end
    return num
end

function JFnum(id)
    local num = 0
    for i = 1, JY.Base["武功数量"] do
        local kfid = JY.Person[id]["武功" .. i]
        if JY.Wugong[kfid]["武功类型"] == 3 then
            num = num + 1
        end
    end
    return num
end

function DFnum(id)
    local num = 0
    for i = 1, JY.Base["武功数量"] do
        local kfid = JY.Person[id]["武功" .. i]
        if JY.Wugong[kfid]["武功类型"] == 4 then
            num = num + 1
        end
    end
    return num
end

function QZnum(id)
    local num = 0
    for i = 1, JY.Base["武功数量"] do
        local kfid = JY.Person[id]["武功" .. i]
        if JY.Wugong[kfid]["武功类型"] == 1 then
            num = num + 1
        end
    end
    return num
end

function ZFnum(id)
    local num = 0
    for i = 1, JY.Base["武功数量"] do
        local kfid = JY.Person[id]["武功" .. i]
        if JY.Wugong[kfid]["武功类型"] == 2 then
            num = num + 1
        end
    end
    return num
end

function QMnum(id)
    local num = 0
    for i = 1, JY.Base["武功数量"] do
        local kfid = JY.Person[id]["武功" .. i]
        if JY.Wugong[kfid]["武功类型"] == 5 then
            num = num + 1
        end
    end
    return num
end

function QGnum(id)
    local num = 0
    for i = 1, JY.Base["武功数量"] do
        local kfid = JY.Person[id]["武功" .. i]
        if JY.Wugong[kfid]["武功类型"] == 7 then
            num = num + 1
        end
    end
    return num
end

-- 无酒不欢：判定一个人物是否满足五岳剑法的条件

function WuyueJFSL(id)
    local num = 0
    local menu = {30, 31, 32, 33, 34}
    for i = 1, #menu do
        if PersonKF(id, menu[i]) then
            num = num + 1
        end
    end
    if (match_ID(id, 19) or match_ID(id, 20) or match_ID(id, 21) or match_ID(id, 22) or match_ID(id, 23)) and
        JY.Person[0]["六如觉醒"] > 0 then
        num = 5
    end
    if num > 4 then
        num = 7
    end
    return num
end

-- 集气
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
	--老顾 集气
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
	
	--无酒不欢：敌人集气随难度变化
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
	local  qg = JY.Person[id]['轻功'] + FJQINGG(id)
	jqz = getnewmove(qg)
	--主运葵花，集气速度+20%
	--萧半和觉醒
	if Curr_NG(id,105) or (match_ID_awakened(id, 189, 1) and Curr_NG(id, 105)) then
		jqz = math.modf(jqz * 1.2)
	end
	--主运飞天，集气+10 标记修改
	if Curr_QG(id,145) then
		jqz = jqz + 10
	end
	
	--运行天赋轻功
	if JY.Person[id]["主运轻功"] > 0 and JY.Person[id]["主运轻功"] == JY.Person[id]["天赋轻功"] then
		jqz = jqz + 1
	end
	
	--胡斐，乔峰，集气+8
	if match_ID(id, 1) or match_ID(id, 9755) or match_ID(id, 539) then
		jqz = jqz + 8
	end
	
	--风云再起，集气+6
	if match_ID(id, 9763) then
		jqz = jqz + 6
	end

	--花铁杆，每行动一次，集气速度加一
	if id==0 and JY.Base["畅想"]==52 then
		jqz = jqz+WAR.HTG
	end	
	--主角论剑打赢东方奖励+8
	if id == 0 and CC.TX["东方不败奖励"] == 1 then
		jqz = jqz + 8
	end
	local zqjq_jc = 0
	if JY.Person[id]["坐骑"] > 0 then
		local fb = 1
		if match_ID(id,131) then 
			fb = 2
		end
		--装备白马 1级加2集气，
		if JY.Person[id]["坐骑"] == 230 then
			local zqjq_jc = 2*fb
			if JY.Thing[230]["装备等级"] >= 5 then
				zqjq_jc = 4*fb
			elseif JY.Thing[230]["装备等级"] >= 3 then
				zqjq_jc = 3*fb
			end
			--李文秀的效果翻倍
			if match_ID(id, 590) then
				if match_ID(id,131) then 
					fb = 2
				end
				zqjq_jc = zqjq_jc * fb
			end
		end
		--装备毛驴 集气速度+10点
		if JY.Person[id]["坐骑"] == 279 then
			--jqz = jqz + 10;
			zqjq_jc = 10* fb
		end
		--装备飞云 集气速度+10点
		if JY.Person[id]["坐骑"] == 264 then
			--jqz = jqz + 12;
			zqjq_jc = 12* fb
		end			
		--装备青驴 集气速度+5点
		if JY.Person[id]["坐骑"] == 339 then
			--jqz = jqz + 5;
			zqjq_jc = 5* fb
		end
		--装备汗血宝马 集气速度+5点
		if JY.Person[id]["坐骑"] == 262 then
			--jqz = jqz + 8;
			zqjq_jc = 8* fb
		end			
		--瘦黄马，血量越低集气越快，50%血+5，0血+10
		if JY.Person[id]["坐骑"] == 284 and JY.Thing[284]["装备等级"] == 6 and JY.Person[id]["生命"] < JY.Person[id]["生命最大值"]/2 then
			local spd_add = 5;
			spd_add = spd_add + math.floor(JY.Person[id]["生命最大值"]/2 - JY.Person[id]["生命"]/100)
			--jqz = jqz + spd_add;
			zqjq_jc = spd_add* fb
		end	
		jqz = jqz  + zqjq_jc
		--聂风
		if match_ID(id, 546) or match_ID(id, 9911) then
			jqz = jqz  + zqjq_jc
		end
	end

	
	
	--秀若芝兰，每个外功+1集气
	if  match_ID(id, 9798) then
		local zzr = 0
		for i = 1, JY.Base["武功数量"] do
			if JY.Wugong[JY.Person[id]["武功" .. i]]["武功类型"] < 6 then
				zzr = zzr + 1
			end
		end
		jqz = jqz + zzr
	end	

						
	--剑神，每个剑法到极，+2集气
	if JY.Base["标准"] == 3 and id == 0 then
		local jsyx = 0
		for i = 1, JY.Base["武功数量"] do
			if JY.Wugong[JY.Person[id]["武功" .. i]]["武功类型"] == 3 and JY.Person[id]["武功等级" .. i] == 999 then
				jsyx = jsyx + 1
			end
		end
		if jsyx > 7 then
			jsyx = 7
		end
		jqz = jqz + jsyx*2
	end

	--李文秀，每个奇门到极，+2集气
	if match_ID(id, 590) then
		local lwx = 0
		for i = 1, JY.Base["武功数量"] do
			if JY.Wugong[JY.Person[id]["武功" .. i]]["武功类型"] == 5 and JY.Person[id]["武功等级" .. i] == 999 then
				lwx = lwx + 1
			end
		end
		if lwx > 7 then
			lwx = 7
		end
		jqz = jqz + lwx*2
	end
	--下雪天集气-3
	if  CC.Weather[2][1] > 0 then 
		if Curr_QG(id,394) then 
			jqz = jqz + 3
		else
			jqz = jqz - 3
		end
	end
	--神机营
	if match_ID(id,733) or match_ID(id,735)  or match_ID(id,734)   or match_ID(id,736)  then 
		jqz = math.modf(jqz*0.7)  
	end 
	if id==0 and (JY.Base["畅想"]==68 or JY.Base["畅想"]==123) then
		jqz = jqz + 1
	end


	local dgqb = {}			--记录独孤求败的数据
	local max_jq = 0		--记录全场最高集气	
	if JY.Status == GAME_WMAP then
		for j = 0, WAR.PersonNum - 1 do
			for i = 0, WAR.PersonNum - 1 do
				if not WAR.Person[i]["死亡"] then
					id = WAR.Person[i]["人物编号"]			
					WAR.Person[i].TimeAdd = (getnewmove1(JY.Person[id]["内力"], JY.Person[id]["内力最大值"]) + JY.Person[id]["体力"] / 30)
					
					WAR.Person[i].TimeAdd = math.modf(WAR.Person[i].TimeAdd)								
					--5点集气集气 JY.Person[id]["防具"] == 61
					if WAR.Person[i].TimeAdd < 5 then
						WAR.Person[i].TimeAdd = 5
					end
					--打狗阵
					if WAR.ZDDH == 344 and isteam(id) == false then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + 10
					end	
					--阿紫曼珠沙华，血量越低集气越快，100%血无加成，0血100%加成
					if match_ID(id, 9757) and WAR.PD["禁药状态"][id]~=nil then
						local bonus_perctge = 0
						bonus_perctge = 2 - JY.Person[id]["生命"] / JY.Person[id]["生命最大值"]
						WAR.Person[i].TimeAdd = math.modf(WAR.Person[i].TimeAdd * bonus_perctge)
					end
					--白秀全场集气-5
					for j = 0, WAR.PersonNum - 1 do
						if match_ID(WAR.Person[j]["人物编号"], 582) and WAR.Person[j]["死亡"] == false and WAR.Person[j]["我方"] ~= WAR.Person[i]["我方"] then
							WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd - 5
							break	
						end
					end	
					--天子观气			
					if match_ID(WAR.Person[j]["人物编号"], 9800) and WAR.Person[j]["死亡"] == false and WAR.Person[j]["我方"] ~= WAR.Person[i]["我方"] then
						jqz = math.modf(jqz*0.5 )
						break	
					end				
					--谢烟客全场集气-10
					if match_ID(WAR.Person[j]["人物编号"], 164) and WAR.Person[j]["死亡"] == false and WAR.Person[j]["我方"] ~= WAR.Person[i]["我方"] then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd - 10
						break	
					end
					--丁不三 丁不四
					
					local bsbs = 0
					if match_ID(WAR.Person[j]["人物编号"], 162) and WAR.Person[j]["死亡"] == false and WAR.Person[j]["我方"] ~= WAR.Person[i]["我方"] then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd - 3
						bsbs = bsbs + 1	
					end
					if match_ID(WAR.Person[j]["人物编号"], 163) and WAR.Person[j]["死亡"] == false and WAR.Person[j]["我方"] ~= WAR.Person[i]["我方"] then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd - 4
						bsbs = bsbs + 1
					end
					if bsbs > 1 then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd - 7		
					end

					if WAR.PD['八酒杯'][id] ~= nil then 
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + WAR.PD['八酒杯'][id]*4
					end
					
					--韦一笑，成昆，黄药师
					if match_ID(id, 14) or match_ID(id, 18) or match_ID(id, 57)  then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + 10
					end
					--一灯，重生后额外集气速度+5
					if match_ID(id, 65) and WAR.PD["复活"][id] ~= nil then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + 5
					end
		
					--王重阳，重生后额外集气速度+5
					if match_ID(id, 9787) and WAR.PD["复活"][id] ~= nil then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + 5
					end
		
					if WAR.PD["招式·集气加速1"][id] ~= nil  then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd * 1.1
					end
					if WAR.PD["招式·集气加速2"][id] ~= nil  then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd * 1.2
					end
					if WAR.PD["招式·集气加速3"][id] ~= nil  then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd * 1.3
					end
					if WAR.PD["招式·集气加速4"][id] ~= nil  then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd * 1.4
					end
					--万里独行 人越少集气越快
					if match_ID(id, 9962)  then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + 20
						if WAR.Person[j]["死亡"] == false and WAR.Person[j]["我方"] == WAR.Person[i]["我方"] then
							WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd - 4
						end
					end
				
					--公孙止，我方每死亡一个人，集气速度+2
					if match_ID(id, 616) then
						if WAR.Person[j]["死亡"] == true and WAR.Person[j]["我方"] == WAR.Person[i]["我方"] then
							WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + 2
						end
					end
					
					--司空摘星，敌方人越多集气速度越快
					if match_ID(id, 579) then
						if WAR.Person[j]["死亡"] == false and WAR.Person[j]["我方"] ~= WAR.Person[i]["我方"] then
							WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + 5
						end
					end	
		
					--圣火三使，同时在场时，每人集气速度额外+20点
					if WAR.ZDDH == 14 and (id == 173 or id == 174 or id == 175) then
						local shz = 0
						if WAR.Person[j]["死亡"] == false and WAR.Person[j]["我方"] == WAR.Person[i]["我方"] then
							shz = shz + 1
						end
						
						if shz == 3 then
							WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + 20
						end
					end
				
					--蓝烟清：天罡北斗阵，集气+7
					if (id == 68 or id == 123 or id == 124 or id == 125 or id == 126 or id == 127 or id == 128) and WAR.Person[i]["我方"] == false then
						local s = 0
						if WAR.Person[j]["死亡"] == false and (WAR.Person[j]["人物编号"] == 68 or WAR.Person[j]["人物编号"] == 123 or WAR.Person[j]["人物编号"] == 124 or WAR.Person[j]["人物编号"] ==125 or WAR.Person[j]["人物编号"] == 126 or WAR.Person[j]["人物编号"] == 127 or WAR.Person[j]["人物编号"] == 128) then
							s = s + 1
						end
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + s
					end			
					
					--蓝烟清：真武七截阵，集气+7
					if (id == 532 or id == 533 or id == 534 or id == 535 or id == 536 or id == 537 or id == 538) and WAR.Person[i]["我方"] == false then
						local s = 0
						if WAR.Person[j]["死亡"] == false and (WAR.Person[j]["人物编号"] == 538 or WAR.Person[j]["人物编号"] == 533 or WAR.Person[j]["人物编号"] == 534 or WAR.Person[j]["人物编号"] ==535 or WAR.Person[j]["人物编号"] == 536 or WAR.Person[j]["人物编号"] == 537 or WAR.Person[j]["人物编号"] == 538) then
							s = s + 1
						end
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + s
					end
					
					--山洞妹妹给主角+2集气
					if id == 0 then
						if WAR.Person[j]["人物编号"] == 9981 and WAR.Person[j]["死亡"] == false and WAR.Person[j]["我方"] == WAR.Person[i]["我方"] then
							WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + 2
							break
						end
					end
					
					if WAR.PD['徐如林'][id] ~= nil then 
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + WAR.PD['徐如林'][id]
					end
					
					--主运太极神功，太极之形增加集气
					if Curr_NG(id, 171) and WAR.PD["太极之形"][id] ~= nil then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + WAR.PD["太极之形"][id]
					end
					--司空摘星挨打增加集气
					if match_ID(id, 9740) and id == 0 and  WAR.SKZX[id] ~= nil then
						WAR.Person[i].TimeAdd = WAR.Person[i].TimeAdd + WAR.SKZX[id]
					end			
					if Curr_NG(id, 227) and WAR.Actup[id] ~= nil and WAR.Actup[id] > 0 then
						WAR.Person[i].TimeAdd = math.modf(WAR.Person[i].TimeAdd * 1.3)
					end
					--平一指，集气速度额外加成5*杀人数
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
		local ND = JY.Base["难度"]
		jqz = jqz*NPCjiqimod(ND)
	end
	--集气加成倍数
	local jqbs = 1
	--集气上限80点
	if jqz > 70 then
		if not match_ID(id,9740) then
			jqz = 70
		end
	end            
	if match_ID(id,9740) and jqz > 99 then
		jqz = 99
	end		

	--集气下限10点
	if jqz < 10 and id ~= 591  then
		jqz = 10
	end	  
	--木桩不集气
	if id == 591 and WAR.ZDDH == 226 then
		jqz = 0
	end					
	--李秋水的无相分身不集气
	if id == 600  then
		jqz = 0
	end

	jqz = math.modf(jqz)	
	--JQ = numberToString(jqz) --转成中文
	JQ = jqz
	return JQ
end

-- 移动步数
function Person_YD(pid)
    --lib.Debug('Person_YD(pid)')
    local Value = 0
    local kf = JY.Person[pid]['主运轻功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
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
    local qg = JY.Person[pid]['轻功'] + FJQINGG(pid)
    -- Value = (getnewmove2(qg, JY.Person[pid]["体力"]) - JY.Person[pid]["中毒程度"]/50 - JY.Person[pid]["受伤程度"]/50)
    Value = (getnewmove2(qg, 0))
    if pid == 5 and Value < 8 then
        Value = 8
    end
    -- 李寻欢学会蜻蜓三大抄水后，移动+2
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
    -- 踏雪无痕，移动锁定10格
    if pid == 511 then
        Value = Value + 2
    end
    -- 铁腿水上飘，移动+5
    if pid == 67 then
        Value = Value + 5
    end
    if pid == 9962 then
        Value = Value + 2
    end
    if pid == 633 then
        Value = Value + 2
    end
    -- 孤独求败，移动锁定10格
    if pid == 592 then
        Value = 10
    end
	Value = math.ceil(Value - JY.Person[pid]["冰封程度"] / 25)
    if Value > 10 then
        Value = 10
    end

    if Value < 0 then
        Value = 0
    end
    return Value
end

-- 命中
function Person_MZ(pid)
    local Value = 0
    local p = JY.Person[pid]
    local kf = JY.Person[pid]['主运内功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
    local level = KF_level(pid, kf)
    local MZ1 = p["命中"]
    local MZ2 = p["轻功"] * 0.5
    local MZ3, MZ4, MZ5 = 0, 0, 0
    MZ3 = JY.Wugong[p["优先使用"]]["加命中"]
    MZ4 = JY.Wugong[p["主运轻功"]]["加命中"]
    MZ5 = p["攻击力"] * 0.1
    Value = MZ1 + MZ2 + MZ3 + MZ4 + MZ5
    if match_ID(pid, 115) then
        Value = Value * 1.2
    end
    -- 梅花
    if JY.Person[pid]['奇穴' .. 99] == 1 then
        Value = Value + p["命中"] * 0.2
    end
    -- 越女剑
    if match_ID(pid, 136) and JY.Wugong[p["优先使用"]]["武功类型"] == 3 then
        Value = Value + 100
    end
    if JY.Person[pid]['奇穴' .. 95] == 1 then
        Value = Value + Value * 0.2
    end
    -- 内轻特效720
    if NeiGong_tx(pid, 720) then
        Value = Value + dkfcj_ng * 5 * level
    end
    -- 内轻特效721
    if NeiGong_tx(pid, 721) then
        Value = Value + dkfcj_ng * 3 * level
    end
    -- 内轻特效724
    if NeiGong_tx(pid, 724) then
        Value = Value + Value * (dkfcj_ng * 8 * level / 1000)
    end
    -- 内轻特效725
    if NeiGong_tx(pid, 725) then
        Value = Value + Value * (dkfcj_ng * 5 * level / 1000)
    end
    Value = math.modf(Value)
    return Value
end

-- 闪避
function Person_SB(pid)
    local p = JY.Person[pid]
    local kf = JY.Person[pid]['主运内功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
    local level = KF_level(pid, kf)
    local Value = 0
    local SB2 = p["轻功"] * 0.5
    local SB1 = 0
    local SB3 = 0
    SB1 = JY.Wugong[p["主运轻功"]]["加闪避"]
    SB3 = p["防御力"] * 0.1
    Value = Value + SB2 + SB1
    if JY.Person[pid]['奇穴' .. 95] == 1 then
        Value = Value + Value * 0.2
    end
    -- 梅花
    if JY.Person[pid]['奇穴' .. 99] == 1 then
        Value = Value + Value * 0.2
    end
    -- 内轻特效718
    if NeiGong_tx(pid, 718) then
        Value = Value + dkfcj_ng * 5 * level
    end
    -- 内轻特效721
    if NeiGong_tx(pid, 721) then
        Value = Value + dkfcj_ng * 3 * level
    end
    -- 内轻特效722
    if NeiGong_tx(pid, 722) then
        Value = Value + Value * (dkfcj_ng * 8 * level / 1000)
    end
    -- 内轻特效725
    if NeiGong_tx(pid, 725) then
        Value = Value + Value * (dkfcj_ng * 5 * level / 1000)
    end
    Value = math.modf(Value)

    if Value < 0 then
        Value = 0
    end
    return Value
end

-- 格档
function Person_GD(pid)
    local Value = 0
    local kf = JY.Person[pid]['主运内功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
    local level = KF_level(pid, kf)
    local GD1, GD2, GD3, GD4 = 0, 0, 0, 0
    local level = 0
    GD1 = GD1 + JY.Person[pid]["格档"]
    GD2 = GD2 + JY.Person[pid]["防御力"] * 0.5
    for i = 1, JY.Base["武功数量"] do
        level = math.modf(JY.Person[pid]["武功等级" .. i] / 100) + 1
        if level > 10 then
            level = 10
        end
        if JY.Person[pid]["武功" .. i] == JY.Person[pid]["主运内功"] then
            GD3 = JY.Wugong[JY.Person[pid]["主运内功"]]["层级"] * level
        end
        if JY.Person[pid]["武功" .. i] == JY.Person[pid]["优先使用"] then
            GD4 = JY.Wugong[JY.Person[pid]["优先使用"]]["层级"] * level
        end
    end
    Value = GD1 + GD2 + GD3 + GD4
    -- 内轻特效719
    if NeiGong_tx(pid, 719) then
        Value = Value + dkfcj_ng * 5 * level
    end
    -- 内轻特效721
    if NeiGong_tx(pid, 721) then
        Value = Value + dkfcj_ng * 3 * level
    end
    -- 史火龙
    if match_ID(pid, 459) then
        if JY.Person[pid]['优先使用'] == 26 then
            Value = Value + 200
        end
    end
    -- 内轻特效724
    if NeiGong_tx(pid, 724) then
        Value = Value + Value * (dkfcj_ng * 8 * level / 1000)
    end
    -- 内轻特效725
    if NeiGong_tx(pid, 725) then
        Value = Value + Value * (dkfcj_ng * 5 * level / 1000)
    end
    Value = math.modf(Value)
    return Value
end

-- 附加命中
function FJPerson_MZ(pid)
    local Value = 0
    local p = JY.Person[pid]
    local kf = JY.Person[pid]['主运内功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
    local level = KF_level(pid, kf)
    -- 战场增减益
    if JY.Status == GAME_WMAP then
        -- 大雾天
        if CC.Weather[3][1] > 0 then
            Value = Value - Person_MZ(pid) * 0.1
        end
        for wid = 0, WAR.PersonNum - 1 do
            -------------------------------
            ---------战场光环增益-----------		
            -- 队友防御加成
            for i = 0, WAR.PersonNum - 1 do
                if WAR.Person[wid]['我方'] ~= WAR.Person[i]['我方'] and
                    match_ID(pid, WAR.Person[wid]['人物编号']) then
                    -- 南四奇
                    if ZDGH(wid, 9898) then
                        Value = Value + 400
                    end
                    -- 白无常
                    if ZDGH(wid, 156) then
                        Value = Value + 100
                    end
                    -- 漠北天狼	
                    if ZDGH(wid, 627) then
                        Value = Value + Person_MZ(WAR.Person[wid]['人物编号']) * 0.1
                    end
                    -- 骆冰
                    if ZDGH(wid, 154) then
                        Value = Value + 200
                    end
                end
            end

            -------------------------------
            ---------战场光环减益-----------
            for i = 0, WAR.PersonNum - 1 do
                if WAR.Person[i]['我方'] ~= WAR.Person[wid]['我方'] and match_ID(pid, WAR.Person[i]['人物编号']) then
                    -- if  match_ID(WAR.Person[wid]['人物编号'],155)  then
                    if match_ID(WAR.Person[wid]['人物编号'], 155) then
                        Value = Value - 100
                    end
                    if match_ID(WAR.Person[wid]['人物编号'], 569) then
                        Value = Value - 200
                    end
                    if match_ID(WAR.Person[wid]['人物编号'], 9800) then
                        Value = Value - Person_MZ(WAR.Person[i]["人物编号"]) * 0.2
                    end
                end
            end
        end
    end
    -- 门派轻功+200 绝学+300
    if JY.Person[pid]['门派'] == JY.Wugong[p["主运轻功"]]['门派'] and p["主运轻功"] > 0 then
        Value = Value + 200
        if JY.Wugong[p["主运轻功"]]['层级'] == 4 then
            Value = Value + 100
        end
    end
    -- 听声辩位
    if match_ID(pid, 9942) then
        Value = Value + 500
    end
    -- 护国真人
    if match_ID(pid, 184) then
        Value = Value + Person_MZ(pid) * 0.2
    end
    -- 史火龙
    if match_ID(pid, 459) then
        if JY.Person[pid]['优先使用'] == 26 then
            Value = Value + 200
        end
    end
    -- 博通百家
    if match_ID(pid, 9987) then
        Value = Value + 200
    end
    -- 王氏门人
    if match_ID(pid, 460) then
        if JY.Person[pid]['优先使用'] == 59 then
            Value = Value + 100
        end
    end
    Value = math.modf(Value)
    return Value
end

-- 附加闪避
function FJPerson_SB(pid)
    local Value = 0
    local kf = JY.Person[pid]['主运内功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
    local level = KF_level(pid, kf)
    -- 战场
    if JY.Status == GAME_WMAP then
        -- 晴天
        if CC.Weather[4][1] > 0 then
            Value = Value - Person_SB(pid) * 0.1
        end
    end
    -- 灰鹞子
    if match_ID(pid, 724) then
        Value = Value + 50
    end
    -- 护国真人
    if match_ID(pid, 184) then
        Value = Value + Person_SB(pid) * 0.2
    end
    -- 白衣书生
    if match_ID(pid, 566) then
        Value = Value + 300
    end
    -- 博通百家
    if match_ID(pid, 9987) then
        Value = Value + 200
    end
    Value = math.modf(Value)
    return Value
end

-- 附加格档
function FJPerson_GD(pid)
    local Value = 0
    local kf = JY.Person[pid]['主运内功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
    local level = KF_level(pid, kf)

    -- 博通百家
    if match_ID(pid, 9987) then
        Value = Value + 200
    end
    if JY.Status == GAME_WMAP then
        for wid = 0, WAR.PersonNum - 1 do
            -------------------------------
            ---------战场光环增益-----------		
            -- 队友防御加成
            if WAR.Person[wid]['我方'] == true and match_ID(pid, WAR.Person[wid]['人物编号']) then
                -- 南四奇
                if ZDGH(wid, 9898) then
                    Value = Value + 400
                end
                -- 白无常
                if ZDGH(wid, 156) then
                    Value = Value + 200
                end
            end

            -------------------------------
            ---------战场光环减益-----------
            for i = 0, WAR.PersonNum - 1 do
                if WAR.Person[i]['我方'] ~= WAR.Person[wid]['我方'] and match_ID(pid, WAR.Person[i]['人物编号']) then
                    -- if  match_ID(WAR.Person[wid]['人物编号'],155)  then
                    if match_ID(WAR.Person[wid]['人物编号'], 155) then
                        Value = Value - 100
                    end
                end
            end
        end
    end

    Value = math.modf(Value)
    return Value
end

-- 无酒不欢：判定连击率
function Person_LJ(pid)
    -- 根据内轻资质计算基础连击率
    local LJ1 = math.modf(JY.Person[pid]["轻功"] / 18)
    local LJ2 = math.modf((JY.Person[pid]["内力最大值"] + JY.Person[pid]["内力"]) / 1000)
    local LJ3 = math.modf(JY.Person[pid]["资质"] / 10)
    local Value = 0
    local kf = JY.Person[pid]['主运内功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
    local level = KF_level(pid, kf)
    Value = (LJ1 + LJ2 + LJ3) / 2
    -- 内轻特效705
    if NeiGong_tx(pid, 705) then
        Value = Value + (100 - Value) * dkfcj_ng * 10 * level / 1000
    end
    -- 灭绝、裘千仞、洪教主、成昆、萧半和、戚长发、令狐冲二觉之后，连击率+70%
    if match_ID(pid, 9813) or match_ID(pid, 67) or match_ID(pid, 71) or match_ID(pid, 18) or match_ID(pid, 594) or
        match_ID_awakened(pid, 35, 2) then
        Value = Value + (100 - Value) * 0.7
    end
    -- 何足道，100%血无加成，0血100%加成
    if match_ID(pid, 9792) then
        local HZDLJ = 0
        HZDLJ = (1 - JY.Person[pid]["生命"] / JY.Person[pid]["生命最大值"]) * 100
        Value = Value + HZDLJ
    end
    if match_ID(pid, 152) and JY.Person[pid]["生命"] < JY.Person[pid]["生命最大值"] / 4 then
        Value = Value * 3
    elseif match_ID(pid, 152) and JY.Person[pid]["生命"] < JY.Person[pid]["生命最大值"] / 2 then
        Value = Value * 2
    end
    -- 萧半和连击+50% 闪电惊鸿
    if match_ID(pid, 189) then
        Value = Value + (100 - Value) * 0.5
    end
    -- 天衣无缝
    if Pmiji(pid, 35) then
        Value = Value + (100 - Value) * 0.3
    end
    -- 连击武功，每个连击+2.5%
    -- 百花，空明，玉女，泰山，鸳鸯，反两仪，杨家枪，海叟，银锁，连城，去烦恼，黑风, 素心
    local ljup = {10, 15, 42, 31, 54, 60, 68, 76, 79, 114, 124, 131, 139}
    for i = 1, JY.Base["武功数量"] do
        if JY.Person[pid]["武功" .. i] > 0 then
            for ii = 1, #ljup do
                if JY.Person[pid]["武功" .. i] == ljup[ii] then
                    Value = Value + (100 - Value) * 0.025
                end
            end
        else
            break
        end
    end
    -- 独孤九剑连击+5%   
    if PersonKF(pid, 47) then
        Value = Value + (100 - Value) * 0.05
    end

    -- 论剑打赢林朝英奖励+50%
    if pid == 0 and CC.TX["林朝英奖励"] == 1 then
        Value = Value + (100 - Value) * 0.5
    end

    -- 实战，每40点+1%
    local jp = JY.Person[pid]["实战"] / 4000
    Value = Value + (100 - Value) * jp

    -- 主运九阴+50% 
    if Curr_NG(pid, 107) and (JY.Person[pid]["内力性质"] == 0 or JY.Person[pid]["内力性质"] == 3) then
        Value = Value + (100 - Value) * 0.5
    end
    -- 双剑合壁 连击率+30%
    if ShuangJianHB(pid) == true then
        Value = Value + (100 - Value) * 0.3
    end
    -- 流星剑 连击率+10%
    if JY.Person[pid]["武器"] == 38 then
        Value = Value + (100 - Value) * (JY.Thing[38]["装备等级"] / 10 - 0.1)
    end

    -- 宁中则 玉女十九剑连击率+30%
    if match_ID(pid, 649) and WAR.YLSJJ == 1 and JY.Status == GAME_WMAP then
        Value = Value + (100 - Value) * 0.3
    end

    -- 焦宛儿在场，全体加10%
    if JY.Status == GAME_WMAP then
        for wid = 0, WAR.PersonNum - 1 do
            if match_ID(WAR.Person[wid]["人物编号"], 607) and WAR.Person[wid]["死亡"] == false and
                WAR.Person[wid]["我方"] then
                Value = Value + (100 - Value) * 0.1
                break
            end
        end
    end

    -- 东方不败、必连击
    if match_ID(pid, 27) then
        Value = 100
    end
    -- 井月八法
    for i = 1, JY.Base["武功数量"] do
        if JY.Person[pid]["武功" .. i] == 181 then
            local dfjc = 0
            for i = 1, JY.Base['武功数量'] do
                if JY.Wugong[JY.Person[pid]['武功' .. i]]['武功类型'] == 4 and JY.Person[pid]["武功等级" .. i] ==
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

    -- 连击率下限1
    if Value < 1 then
        Value = 1
    end

    -- 取整
    Value = math.modf(Value)

    return Value
end

-- 无酒不欢：判定暴击率
function Person_BJ(pid)
    local kf = JY.Person[pid]['主运内功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
    local level = KF_level(pid, kf)
    -- 根据内攻体力计算基础暴击率
    local BJ1 = math.modf(JY.Person[pid]["攻击力"] / 18)
    local BJ2 = math.modf((JY.Person[pid]["内力最大值"] + JY.Person[pid]["内力"]) / 1000)
    local BJ3 = math.modf(JY.Person[pid]["体力"] / 10)
    local Value = 0
    Value = (BJ1 + BJ2 + BJ3) / 2
    -- 内轻特效706
    if NeiGong_tx(pid, 706) then
        Value = Value + (100 - Value) * dkfcj_ng * 10 * level / 1000
    end

    -- 血刀老祖、裘千仞、洪教主、任我行、玉真子、，暴击率+70%，灭绝
    if match_ID(pid, 97) or match_ID(pid, 67) or match_ID(pid, 71) or match_ID(pid, 26) or match_ID(pid, 184) or
        match_ID(pid, 9813) then
        Value = Value + (100 - Value) * 0.7
    end

    -- 井月八法暴击率+5%   
    if PersonKF(pid, 181) then
        local dfjc = 0
        for i = 1, JY.Base["武功数量"] do
            if JY.Wugong[JY.Person[pid]['武功' .. i]]['武功类型'] == 4 and JY.Person[pid]['武功等级' .. i] ==
                999 then
                dfjc = dfjc + 1
            end
        end
        if dfjc >= 8 then
            Value = Value + (100 - Value) * dfjc * 0.01
        end
    end
    -- 论剑打赢林朝英奖励+50%
    if pid == 0 and CC.TX["林朝英奖励"] == 1 then
        Value = Value + (100 - Value) * 0.5
    end
    -- 袁承志，萧半和 暴击率+50%
    if match_ID(pid, 54) or match_ID(pid, 189) then
        Value = Value + (100 - Value) * 0.5
    end
    -- 世尊降魔暴击提高
    if ShiZunXM(pid) == true then
        Value = Value + (100 - Value) * 0.5
    end
    -- 陆无双 暴击率+30%
    if match_ID(pid, 580) then
        Value = Value + (100 - Value) * 0.3
    end
    -- 何足道，100%血无加成，0血100%加成
    if match_ID(pid, 586) or match_ID(pid, 9792) then
        local HZDBJ = 0
        HZDBJ = (1 - JY.Person[pid]["生命"] / JY.Person[pid]["生命最大值"]) * 100
        Value = Value + HZDBJ
    end
    -- 杨过，血量少于四分之一时，基础暴击率3倍
    if (match_ID(pid, 58) or match_ID(pid, 9791)) and JY.Person[pid]["生命"] < JY.Person[pid]["生命最大值"] / 4 then
        Value = Value * 3
        -- 杨过，血量少于二分之一，基础暴击率2倍
    elseif (match_ID(pid, 58) or match_ID(pid, 9791)) and JY.Person[pid]["生命"] < JY.Person[pid]["生命最大值"] /
        2 then
        Value = Value * 2
    end

    -- 暴击武功，每个暴击+2.5%
    -- 弹指，大力，全真，金蛇，奇门三才，燃木，裴将军，黄沙，鹤蛇，金乌，玄冥，铁指诀，一阳指
    local bjup = {18, 22, 39, 40, 56, 65, 71, 78, 74, 61, 21, 121, 17}
    for i = 1, JY.Base["武功数量"] do
        if JY.Person[pid]["武功" .. i] > 0 then
            for ii = 1, #bjup do
                if JY.Person[pid]["武功" .. i] == bjup[ii] then
                    Value = Value + (100 - Value) * 0.025
                end
            end
        else
            break
        end
    end
    -- 实战，每40点+1%
    local jp = JY.Person[pid]["实战"] / 4000
    Value = Value + (100 - Value) * jp

    -- 主运逆运+50%
    if Curr_NG(pid, 104) then
        Value = Value + (100 - Value) * 0.5
    elseif PersonKF(pid, 107) then
        Value = Value + (100 - Value) * 0.3
    end

    -- 寇仲
    if match_ID(pid, 578) then
        local df = 0
        for i = 1, JY.Base["武功数量"] do
            if JY.Wugong[JY.Person[0]["武功" .. i]]["武功类型"] == 4 and JY.Person[0]["武功等级" .. i] == 999 then
                df = df + 1
                if df > 8 then
                    df = 8
                end
            end
            Value = Value + (100 - Value) * df * 0.05
        end
    end
    -- 萧峰、灭绝、必暴击
    if match_ID(pid, 50) or match_ID(pid, 6) then
        Value = 100
    end

    -- 只有战斗中才有的加成
    if JY.Status == GAME_WMAP then
        -- 欧阳锋 逆运状态下必暴击
        if match_ID(pid, 60) and WAR.tmp[1000 + pid] == 1 then
            Value = 100
        end
    end

    -- 暴击率下限1
    if Value < 1 then
        Value = 1
    end

    -- 取整
    Value = math.modf(Value)

    return Value
end

-- 附加攻击
function FJGONGJ(pid)
    -- 属性
    local Value = 0
    local fb = 1
    local p = JY.Person[pid]
    local kf = JY.Person[pid]['主运内功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
    local level = KF_level(pid, kf)
    if match_ID(pid, 546) or match_ID(pid, 9911) then
        fb = 2
    end
    --内轻特效1012
    if NeiGong_tx(pid,1011) and JY.Person[pid]['武器'] == -1 then 
        Value = Value + dkfcj_ng*50
    end
    -- 物转星移
    if JY.Person[pid]['奇穴' .. 149] == 1 then
        Value = Value + JY.Person[pid]['攻击力'] * 0.05
    end
    -- 浩然正气
    if JY.Person[pid]['奇穴' .. 139] == 1 then
        Value = Value + JY.Person[pid]['攻击力'] * 0.05
    end
    -- 兵器谱
    if JY.Person[pid]["武器"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "加攻击力"
        if JY.Person[pid]['奇穴' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["使用人"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    -- 追命
    if match_ID(pid, 450) then
        Value = Value + JY.Person[pid]['轻功'] * 0.3
    end
    -- 朱子柳
    if match_ID(pid, 121) then
        Value = Value + JY.Person[pid]['攻击力'] * 0.1
    end
    -- 冷面热心
    if match_ID(pid, 9826) then
        Value = Value - JY.Person[pid]['攻击力'] * 0.1
    end
    -- 神机营
    if match_ID(pid, 733) or match_ID(pid, 734) or match_ID(pid, 735) or match_ID(pid, 736) then
        Value = Value + JY.Person[pid]['攻击力'] * 0.3
    end
    -- 樵夫
    if match_ID(pid, 120) then
        Value = Value + 100
    end
    -- 南山樵子
    if match_ID(pid, 133) then
        Value = Value + 100
    end
    -- 玄慈伏魔罗汉阴内增加攻击
    if pid == 70 and JY.Person[pid]["内力性质"] == 0 then
        Value = Value + math.modf(JY.Person[pid]['攻击力'] * 0.2)
    end
    -- 拳法精通
    if match_ID(pid, 9960) then
        local n = JY.Person[pid]["拳掌功夫"]
        Value = Value + n * 0.1
    end
    -- 指法精通
    if match_ID(pid, 9959) then
        local n = JY.Person[pid]["指法技巧"]
        Value = Value + n * 0.1
    end
    -- 剑法精通
    if match_ID(pid, 9958) then
        local n = JY.Person[pid]["御剑能力"]
        Value = Value + n * 0.1
    end
    -- 刀法精通
    if match_ID(pid, 9957) then
        local n = JY.Person[pid]["耍刀技巧"]
        Value = Value + n * 0.1
    end
    -- 奇门精通
    if match_ID(pid, 9956) then
        local n = JY.Person[pid]["特殊兵器"]
        Value = Value + n * 0.1
    end
    -- 神拳无敌
    if match_ID(pid, 9955) then
        local n = JY.Person[pid]["拳掌功夫"]
        Value = Value + n * 0.2
    end
    -- 千手神通
    if match_ID(pid, 9954) then
        local n = JY.Person[pid]["指法技巧"]
        Value = Value + n * 0.2
    end
    -- 剑术通神
    if match_ID(pid, 9953) then
        local n = JY.Person[pid]["御剑能力"]
        Value = Value + n * 0.2
    end
    -- 傲世狂刀
    if match_ID(pid, 9952) then
        local n = JY.Person[pid]["耍刀技巧"]
        Value = Value + n * 0.2
    end
    -- 奇门无双
    if match_ID(pid, 9951) then
        local n = JY.Person[pid]["特殊兵器"]
        Value = Value + n * 0.2
    end
    -- 一通万法
    if match_ID(pid, 9774) then
        for i = 1, JY.Base['武功数量'] do
            local wg = JY.Person[pid]['武功' .. i]
            if KF_level(pid, wg) > 10 then
                Value = Value + 10
            end
        end
    end
    if p["武器"] > -1 then
        local wqfb = 1
        if JY.Thing[p["武器"]]["加攻击力"] > 0 then
            Value = Value + JY.Thing[p["武器"]]["加攻击力"] * 10 + JY.Thing[p["武器"]]["加攻击力"] *
                        (JY.Thing[p["武器"]]["装备等级"] - 1) * 2
        elseif JY.Thing[p["武器"]]["加攻击力"] < 0 then
            Value = Value + JY.Thing[p["武器"]]["加攻击力"] * 10 - JY.Thing[p["武器"]]["加攻击力"] *
                        (JY.Thing[p["武器"]]["装备等级"] - 1) * 2
        end
    else
        if p['门派'] == 29 then
            Value = Value + p['攻击力'] * 0.2
        end
    end
    if p["坐骑"] > -1 then
        local zqfb = 1
        if match_ID(pid, 131) or match_ID(pid, 451) then
            zqfb = 2
        end

        if JY.Thing[p["坐骑"]]["加攻击力"] > 0 then
            Value = Value + (JY.Thing[p["坐骑"]]["加攻击力"] * 10 + JY.Thing[p["坐骑"]]["加攻击力"] *
                        (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2) * zqfb
        elseif JY.Thing[p["坐骑"]]["加攻击力"] < 0 then
            Value = Value + (JY.Thing[p["坐骑"]]["加攻击力"] * 10 - JY.Thing[p["坐骑"]]["加攻击力"] *
                        (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2) * zqfb
        end
    end
    if p["防具"] > -1 then
        if JY.Thing[p["防具"]]["加攻击力"] > 0 then
            Value = Value + JY.Thing[p["防具"]]["加攻击力"] * 10 + JY.Thing[p["防具"]]["加攻击力"] *
                        (JY.Thing[p["防具"]]["装备等级"] - 1) * 2
        elseif JY.Thing[p["防具"]]["加攻击力"] < 0 then
            Value = Value + JY.Thing[p["防具"]]["加攻击力"] * 10 - JY.Thing[p["防具"]]["加攻击力"] *
                        (JY.Thing[p["防具"]]["装备等级"] - 1) * 2
        end
    end

    -- 易筋经加成

    local qg = 0
    local fy = 0
    for i = 1, JY.Base["武功数量"] do -- 查找当前已经炼成武功等级
        if JY.Person[pid]["武功" .. i] == 108 then
            -- 内轻特效1026
            if NeiGong_tx(pid, 1026) then
                level = math.modf(JY.Person[pid]["武功等级" .. i] / 100) + 1;
                if level >= 1 then
                    local gj = math.modf(JY.Person[pid]["攻击力"] * (dkfcj_ng * 5 / 1000) * (level - 1))
                    Value = Value + gj
                    break
                end
            end
        end
    end
    -- 内轻特效1025
    if NeiGong_tx(pid, 1025) then
        if level >= 1 then
            local qg = math.modf(dkfcj_ng * 5 * (level - 1))
            Value = Value + qg
        end
    end
    -- 内轻特效702
    if NeiGong_tx(pid, 702) then
        local qg = dkfcj_ng * 6 * (level)
        Value = Value + qg
    end
    -- 内轻特效715
    if NeiGong_tx(pid, 715) then
        local fy = math.modf(JY.Person[pid]["攻击力"] * ((dkfcj_ng + 1) * 5 / 1000) * (level - 1))
        Value = Value + fy
    end
    if match_ID(pid, 9930) then -- 黑级浮屠
        local gj = math.modf(JY.Person[pid]["攻击力"] * 0.6)
        Value = Value + gj
    end
    if match_ID(pid, 604) then
        Value = Value + JY.Person[pid]["御剑能力"]
    end
    -- 战场加成 
    if JY.Status == GAME_WMAP then
        -- 下雨
        if CC.Weather[1][1] > 0 then
            Value = Value - JY.Person[pid]['攻击力'] * 0.05
        end
        for wid = 0, WAR.PersonNum - 1 do
            -- 江南七怪
            if ZDGH(wid, 9751) then
                if WAR.Person[wid]["死亡"] == false and match_ID(pid, 9751) then
                    Value = Value + 50
                end
            end
            -- 总舵主
            if WAR.Person[wid]['死亡'] == false and WAR.Person[wid]["我方"] == true and
                match_ID(WAR.Person[wid]['人物编号'], 571) then
                Value = Value + JY.Person[WAR.Person[wid]['人物编号']]['攻击力'] * 0.05
            end
            -- 队友攻击力加成
            for i, v in pairs(CC.AddAtk) do
                if match_ID(pid, v[1]) then
                    if match_ID(WAR.Person[wid]["人物编号"], v[2]) and WAR.Person[wid]["死亡"] == false then
                        Value = Value + v[3]
                    end
                end
            end
            -- 林殊敌方人数人越多，攻击越高    
            if match_ID(pid, 9745) then
                if WAR.Person[wid]["死亡"] == false and WAR.Person[wid]["我方"] == false then
                    Value = Value + 10
                end
            end
            -- 御林军
            if match_ID(pid, 441) or match_ID(pid, 442) or match_ID(pid, 443) or match_ID(pid, 444) or
                match_ID(pid, 445) or match_ID(pid, 446) or match_ID(pid, 732) then
                if WAR.Person[wid]["死亡"] == false and WAR.Person[wid]["我方"] == true then
                    Value = Value + 10
                end
            end
        end
        -- 战场光环
        for wid = 0, WAR.PersonNum - 1 do
            for i = 0, WAR.PersonNum - 1 do
                if WAR.Person[wid]['我方'] ~= WAR.Person[i]['我方'] and
                    match_ID(pid, WAR.Person[wid]['人物编号']) then
                    -- 苏荃战场加成 敌全体攻击-10%
                    if ZDGH(wid, 87) then
                        Value = Value - math.modf(JY.Person[pid]['攻击力'] * 0.10)
                        break
                    end
                    -- 勇猛精进
                    if ZDGH(wid, 9838) then
                        Value = Value + math.modf(JY.Person[pid]['防御力'] * 0.1)
                    end
                end
            end
        end
        if WAR.PD['西瓜刀·天人'][pid] ~= nil then
            Value = Value * 1.5
        end

        if WAR.PD["外伤状态1"][pid] ~= nil then
            Value = gstr_gainj * 0.9
        end

        if WAR.PD["外伤状态2"][pid] ~= nil then
            Value = Value * 0.85
        end

        if WAR.PD["外伤状态3"][pid] ~= nil then
            Value = Value * 0.8
        end

        if WAR.PD["外伤状态4"][pid] ~= nil then
            Value = Value * 0.75
        end
        --内轻特效1032
        if NeiGong_tx(pid,1032) then 
            local sx = '攻击力'
            local ld = JY.Person[pid][sx]*(50+dkfcj_ng*10)/100 - JY.Person[pid][sx]
            local ld1 = JY.Person[pid][sx]*0.2*(WAR.PD['六道轮回'][pid] or 0 )
            Value = Value + dkfcj_ng + ld1
        end
    end
    Value = math.modf(Value)
    return Value
end

-- 附加防御
function FJFANGY(pid)
    local Value = 0
    local fb = 1
    local p = JY.Person[pid]
    local kf = JY.Person[pid]['主运内功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
    local level = KF_level(pid, kf)
    --内轻特效1010
    if NeiGong_tx(pid,1010) and JY.Person[pid]['防具'] == -1 then 
        Value = Value + dkfcj_ng*50
    end
    -- 物转星移
    if JY.Person[pid]['奇穴' .. 149] == 1 then
        Value = Value + JY.Person[pid]['攻击力'] * 0.05
    end
    -- 浩然正气
    if JY.Person[pid]['奇穴' .. 139] == 1 then
        Value = Value + JY.Person[pid]['防御力'] * 0.05
    end
    -- 兵器谱
    if JY.Person[pid]["武器"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "加防御力"
        if JY.Person[pid]['奇穴' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["使用人"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    -- 一通万法
    if match_ID(pid, 9774) then
        for i = 1, JY.Base['武功数量'] do
            local wg = JY.Person[pid]['武功' .. i]
            if KF_level(pid, wg) > 10 then
                Value = Value + 10
            end
        end
    end
    -- 至阳之体
    if JY.Person[pid]['奇穴' .. 61] == 1 then
        Value = Value + JY.Person[pid]['防御力'] * 0.1
    end
    -- 朱子柳
    if match_ID(pid, 121) then
        Value = Value + JY.Person[pid]['防御力'] * 0.1
    end
    -- 玄慈伏魔罗汉阳内增加防御
    if pid == 70 and JY.Person[pid]["内力性质"] == 1 then
        Value = Value + math.modf(JY.Person[pid]['防御力'] * 0.2)
    end
    -- 笑弥陀
    if match_ID(pid, 134) then
        Value = Value + 100
    end
    -- 镇远镖头
    if match_ID(pid, 572) then
        Value = Value + 80
    end
    -- 冷面热心
    if match_ID(pid, 9826) then
        Value = Value + JY.Person[pid]['防御力'] * 0.1
    end
    -- 铁甲重骑
    if match_ID(pid, 654) or match_ID(pid, 659) or match_ID(pid, 660) or match_ID(pid, 661) then
        Value = Value + 100
    end
    -- 八百威风
    if match_ID(pid, 187) then
        Value = Value + JY.Person[pid]['防御力'] * 0.1
    end
    -- 拳法精通
    if match_ID(pid, 9960) then
        local n = JY.Person[pid]["拳掌功夫"]
        Value = Value + n * 0.1
    end
    -- 指法精通
    if match_ID(pid, 9959) then
        local n = JY.Person[pid]["指法技巧"]
        Value = Value + n * 0.1
    end
    -- 剑法精通
    if match_ID(pid, 9958) then
        local n = JY.Person[pid]["御剑能力"]
        Value = Value + n * 0.1
    end
    -- 刀法精通
    if match_ID(pid, 9957) then
        local n = JY.Person[pid]["耍刀技巧"]
        Value = Value + n * 0.1
    end
    -- 奇门精通
    if match_ID(pid, 9956) then
        local n = JY.Person[pid]["特殊兵器"]
        Value = Value + n * 0.1
    end
    -- 神拳无敌
    if match_ID(pid, 9955) then
        local n = JY.Person[pid]["拳掌功夫"]
        Value = Value + n * 0.2
    end
    -- 千手神通
    if match_ID(pid, 9954) then
        local n = JY.Person[pid]["指法技巧"]
        Value = Value + n * 0.2
    end
    -- 剑术通神
    if match_ID(pid, 9953) then
        local n = JY.Person[pid]["御剑能力"]
        Value = Value + n * 0.2
    end
    -- 傲世狂刀
    if match_ID(pid, 9952) then
        local n = JY.Person[pid]["耍刀技巧"]
        Value = Value + n * 0.2
    end
    -- 奇门无双
    if match_ID(pid, 9951) then
        local n = JY.Person[pid]["特殊兵器"]
        Value = Value + n * 0.2
    end

    if (PersonKF(pid, 37) and PersonKF(pid, 60)) or match_ID(pid, 96) then
        Value = Value + 64
    end

    if p["武器"] > -1 then
        if JY.Thing[p["武器"]]["加防御力"] > 0 then
            Value = Value + JY.Thing[p["武器"]]["加防御力"] * 10 + JY.Thing[p["武器"]]["加防御力"] *
                        (JY.Thing[p["武器"]]["装备等级"] - 1) * 2
        elseif JY.Thing[p["武器"]]["加防御力"] < 0 then
            Value = Value + JY.Thing[p["武器"]]["加防御力"] * 10 - JY.Thing[p["武器"]]["加防御力"] *
                        (JY.Thing[p["武器"]]["装备等级"] - 1) * 2
        end
    end
    if p["坐骑"] > -1 then
        local zqfb = 1
        if match_ID(pid, 131) or match_ID(pid, 451) then
            zqfb = 2
        end
        if JY.Thing[p["坐骑"]]["加防御力"] > 0 then
            Value = Value + (JY.Thing[p["坐骑"]]["加防御力"] * 10 + JY.Thing[p["坐骑"]]["加防御力"] *
                        (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2) * zqfb
        elseif JY.Thing[p["坐骑"]]["加防御力"] < 0 then
            Value = Value + (JY.Thing[p["坐骑"]]["加防御力"] * 10 - JY.Thing[p["坐骑"]]["加防御力"] *
                        (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2) * zqfb
        end
    end
    if p["防具"] > -1 then
        if JY.Thing[p["防具"]]["加防御力"] > 0 then
            Value = Value + JY.Thing[p["防具"]]["加防御力"] * 10 + JY.Thing[p["防具"]]["加防御力"] *
                        (JY.Thing[p["防具"]]["装备等级"] - 1) * 2
        elseif JY.Thing[p["防具"]]["加防御力"] < 0 then
            Value = Value + JY.Thing[p["防具"]]["加防御力"] * 10 - JY.Thing[p["防具"]]["加防御力"] *
                        (JY.Thing[p["防具"]]["装备等级"] - 1) * 2
        end
    else
        if p['门派'] == 29 then
            Value = Value + p['防御力'] * 0.2
        end
    end
    -- 易筋经加成

    for i = 1, JY.Base["武功数量"] do -- 查找当前已经炼成武功等级
        if JY.Person[pid]["武功" .. i] == 108 then
            -- 内轻特效1026
            if NeiGong_tx(pid, 1026) then
                level = math.modf(JY.Person[pid]["武功等级" .. i] / 100) + 1;
                if level >= 1 then
                    local fy = math.modf(JY.Person[pid]["防御力"] * (dkfcj_ng * 5 / 1000) * (level - 1))
                    Value = Value + fy
                    break
                end
            end
        end
    end
    -- 内轻特效1025
    if NeiGong_tx(pid, 1025) then
        if KF_level(pid, kf) >= 1 then
            local qg = math.modf(dkfcj_ng * 5 * (level - 1))
            Value = Value + qg
        end
    end
    -- 内轻特效703
    if NeiGong_tx(pid, 703) then
        local qg = dkfcj_ng * 6 * (level)
        Value = Value + qg
    end
    -- 内轻特效716
    if NeiGong_tx(pid, 716) then
        local fy = math.modf(JY.Person[pid]["防御力"] * ((dkfcj_ng + 1) * 5 / 1000) * (level - 1))
        Value = Value + fy
    end
    if match_ID(pid, 9930) then -- 黑级浮屠
        local fy = math.modf(JY.Person[pid]["防御力"] * 0.6)
        Value = Value + fy
    end
    if Curr_NG(pid, 199) then -- 武穆遗书 标记修改
        local sz = math.modf(JY.Person[pid]["实战"] / 2)
        if not inteam(pid) then
            sz = 100
        end
        Value = Value + sz
    end
    if match_ID(pid, 604) then
        Value = Value + JY.Person[pid]['御剑能力']
    end

    -- 战场	
    if JY.Status == GAME_WMAP then
        -- 大雾天
        if CC.Weather[3][1] > 0 then
            Value = Value - JY.Person[pid]["防御力"] * 0.05
        end

        for wid = 0, WAR.PersonNum - 1 do
            -- 御林军
            if match_ID(pid, 441) or match_ID(pid, 442) or match_ID(pid, 443) or match_ID(pid, 444) or
                match_ID(pid, 445) or match_ID(pid, 446) or match_ID(pid, 732) then
                if WAR.Person[wid]["死亡"] == false and WAR.Person[wid]["我方"] == true then
                    Value = Value + 10
                end
            end
            -- 林殊敌方人数人越多，防御越高    
            if match_ID(pid, 9745) then
                if WAR.Person[wid]["死亡"] == false and WAR.Person[wid]["我方"] == false then
                    Value = Value + 10
                end
            end
            -- 队友防御力加成
            for i, v in pairs(CC.AddDef) do
                if match_ID(pid, v[1]) then
                    if match_ID(WAR.Person[wid]["人物编号"], v[2]) and WAR.Person[wid]["死亡"] == false then
                        Value = Value + v[3]
                    end
                end
            end
        end
        -- 战场光环
        for wid = 0, WAR.PersonNum - 1 do
            for i = 0, WAR.PersonNum - 1 do
                if WAR.Person[wid]['我方'] ~= WAR.Person[i]['我方'] and
                    match_ID(pid, WAR.Person[wid]['人物编号']) then
                    -- 霍青桐战场加成 
                    if ZDGH(wid, 74) then
                        Value = Value + math.modf(JY.Person[pid]['防御力'] * 0.2)
                        break
                    end
                    -- 江南七怪
                    if ZDGH(wid, 9751) then
                        if WAR.Person[wid]["死亡"] == false and match_ID(pid, 9751) then
                            Value = Value + 50
                        end
                    end
                    -- 阿珂防御加成
                    if ZDGH(wid, 86) then
                        Value = Value - math.modf(JY.Person[pid]['防御力'] * 0.15)
                    end
                end
            end
        end
        if WAR.PD['西瓜刀·天人'][pid] ~= nil then
            Value = Value * 1.5
        end

        if WAR.PD["外伤状态1"][pid] ~= nil then
            Value = Value * 0.9
        end

        if WAR.PD["外伤状态2"][pid] ~= nil then
            Value = Value * 0.85
        end

        if WAR.PD["外伤状态3"][pid] ~= nil then
            Value = Value * 0.8
        end

        if WAR.PD["外伤状态4"][pid] ~= nil then
            Value = Value * 0.75
        end
        --内轻特效1032
        if NeiGong_tx(pid,1032) then 
            local sx = '防御力'
            local ld = JY.Person[pid][sx]*(50+dkfcj_ng*10)/100 - JY.Person[pid][sx]
            local ld1 = JY.Person[pid][sx]*0.2*(WAR.PD['六道轮回'][pid] or 0 )
            Value = Value + dkfcj_ng + ld1
        end
    end
    Value = math.modf(Value)
    return Value
end

-- 附加轻功
function FJQINGG(pid)
    local Value = 0
    local fb = 1
    local p = JY.Person[pid]
    local kf = JY.Person[pid]['主运内功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
    local level = KF_level(pid, kf)
    --内轻特效1011
    if NeiGong_tx(pid,1011) and JY.Person[pid]['坐骑'] == -1 then 
        Value = Value + dkfcj_ng*50
    end
    -- 兵器谱
    if JY.Person[pid]["武器"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "加轻功"
        if JY.Person[pid]['奇穴' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["使用人"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +(JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *(JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +(JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *(JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    -- 一通万法
    if match_ID(pid, 9774) then
        for i = 1, JY.Base['武功数量'] do
            local wg = JY.Person[pid]['武功' .. i]
            if KF_level(pid, wg) > 10 then
                Value = Value + 10
            end
        end
    end
    -- 凌空虚渡
    if JY.Person[pid]['奇穴' .. 106] == 1 then
        Value = Value + JY.Person[pid]['轻功'] * 0.1
    end
    -- 聂风
    if match_ID(pid, 546) or match_ID(pid, 9911) then
        fb = 2
    end
    -- 朱子柳
    if match_ID(pid, 121) then
        Value = Value - JY.Person[pid]['轻功'] * 0.1
    end
    -- 鹰飞九天
    if match_ID(pid, 9811) then
        Value = Value + 100
    end
    -- 朱子柳
    if match_ID(pid, 135) then
        Value = Value + 100
    end

    -- 玄慈伏魔罗汉调和内增加轻功
    if pid == 70 and JY.Person[pid]["内力性质"] == 2 then
        Value = Value + math.modf(JY.Person[pid]['轻功'] * 0.2)
    end
    if p["武器"] > -1 then
        if JY.Thing[p["武器"]]["加轻功"] > 0 then
            Value = Value + JY.Thing[p["武器"]]["加轻功"] * 10 * fb + JY.Thing[p["武器"]]["加轻功"] *
                        (JY.Thing[p["武器"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["武器"]]["加轻功"] < 0 then
            Value = Value + JY.Thing[p["武器"]]["加轻功"] * 10 * fb - JY.Thing[p["武器"]]["加轻功"] *
                        (JY.Thing[p["武器"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if p["坐骑"] > -1 then
        local zqfb = 1
        if match_ID(pid, 131) or match_ID(pid, 451) then
            zqfb = 2
        end
        if JY.Thing[p["坐骑"]]["加轻功"] > 0 then
            Value = Value + (JY.Thing[p["坐骑"]]["加轻功"] * 10 + JY.Thing[p["坐骑"]]["加轻功"] *(JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2) * zqfb
        elseif JY.Thing[p["坐骑"]]["加轻功"] < 0 then
            Value = Value + (JY.Thing[p["坐骑"]]["加轻功"] * 10 - JY.Thing[p["坐骑"]]["加轻功"] *(JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2) * zqfb
        end
    else
        if p['门派'] == 29 then
            Value = Value + p['轻功'] * 0.2
        end
    end
    if p["防具"] > -1 then
        if JY.Thing[p["防具"]]["加轻功"] > 0 then
            Value = Value + JY.Thing[p["防具"]]["加轻功"] * 10 * fb + JY.Thing[p["防具"]]["加轻功"] *
                        (JY.Thing[p["防具"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["防具"]]["加轻功"] < 0 then
            Value = Value + JY.Thing[p["防具"]]["加轻功"] * 10 * fb - JY.Thing[p["防具"]]["加轻功"] *
                        (JY.Thing[p["防具"]]["装备等级"] - 1) * 2 * fb
        end
    end
    -- 易筋经加成

    for i = 1, JY.Base["武功数量"] do -- 查找当前已经炼成武功等级
        if JY.Person[pid]["武功" .. i] == 108 then
            -- 内轻特效1026
            if NeiGong_tx(pid, 1026) then
                level = math.modf(JY.Person[pid]["武功等级" .. i] / 100) + 1;
                if level >= 1 then
                    local qg = math.modf(JY.Person[pid]["轻功"] * (dkfcj_ng * 5 / 1000) * (level - 1))
                    Value = Value + qg
                    break
                end
            end
        end
    end
    -- 内轻特效1025
    if NeiGong_tx(pid, 1025) then
        if KF_level(pid, kf) >= 1 then
            local qg = math.modf(dkfcj_ng * 5 * (level - 1))
            Value = Value + qg
        end
    end
    -- 内轻特效704
    if NeiGong_tx(pid, 704) then
        local qg = dkfcj_ng * 6 * (level)
        Value = Value + qg
    end
    -- 内轻特效717
    if NeiGong_tx(pid, 717) then
        local fy = math.modf(JY.Person[pid]["轻功"] * ((dkfcj_ng + 1) * 5 / 1000) * (level - 1))
        Value = Value + fy
    end

    if match_ID(pid, 9930) then -- 黑级浮屠
        local qg = math.modf(JY.Person[pid]["轻功"] * 0.6)
        Value = Value + qg
    end
    -- 逍遥游
    if Curr_QG(pid, 2) then
        Value = Value + 50
    end
    -- 没影子
    if match_ID(pid, 183) then
        Value = Value + 50
    end
    -- 护国真人
    if match_ID(pid, 184) then
        Value = Value + JY.Person[pid]["轻功"] * 0.2
    end
    -- 金雁功
    if Curr_QG(pid, 223) then
        Value = Value + math.modf(JY.Person[pid]["轻功"] * 0.2)
    end
    -- 蛇行狸翻
    if Curr_QG(pid, 224) then
        Value = Value + math.modf(JY.Person[pid]["轻功"] * 0.2)
    end
    -- 战场加成 
    if JY.Status == GAME_WMAP then
        -- 下雪天 
        if CC.Weather[2][1] > 0 then
            Value = Value - JY.Person[pid]["轻功"] * 0.05
        end
        -- 队友轻功加成
        for i, v in pairs(CC.AddSpd) do
            if match_ID(pid, v[1]) then
                for wid = 0, WAR.PersonNum - 1 do
                    if match_ID(WAR.Person[wid]["人物编号"], v[2]) and WAR.Person[wid]["死亡"] == false then
                        Value = Value + v[3]
                    end
                end
            end
        end
        ---------战场光环增益-----------		
        for wid = 0, WAR.PersonNum - 1 do
            for i = 0, WAR.PersonNum - 1 do
                if WAR.Person[wid]['我方'] ~= WAR.Person[i]['我方'] and
                    match_ID(pid, WAR.Person[wid]['人物编号']) then
                    -- 漠北天狼	
                    if ZDGH(wid, 627) then
                        Value = Value + JY.Person[WAR.Person[wid]['人物编号']]['轻功'] * 0.1
                    end
                    if ZDGH(wid, 9751) then
                        Value = Value + 50
                    end
                end
            end
        end
        if WAR.PD['西瓜刀·天人'][pid] ~= nil then
            Value = Value * 1.5
        end

        if WAR.PD["外伤状态1"][pid] ~= nil then
            Value = Value * 0.9
        end

        if WAR.PD["外伤状态2"][pid] ~= nil then
            Value = Value * 0.85
        end

        if WAR.PD["外伤状态3"][pid] ~= nil then
            Value = Value * 0.8
        end
        if WAR.PD["外伤状态4"][pid] ~= nil then
            Value = Value * 0.75
        end
        --内轻特效1032
        if NeiGong_tx(pid,1032) then 
            local sx = '轻功'
            local ld = JY.Person[pid][sx]*(50+dkfcj_ng*10)/100 - JY.Person[pid][sx]
            local ld1 = JY.Person[pid][sx]*0.2*(WAR.PD['六道轮回'][pid] or 0 )
            Value = Value + dkfcj_ng + ld1
        end
    end
    Value = math.modf(Value)
    return Value
end

-- 附加医疗
function FJYIL(pid)
    local Value = 0
    local p = JY.Person[pid]
    local fb = 1

    -- 兵器谱
    if JY.Person[pid]["武器"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "加医疗能力"
        if JY.Person[pid]['奇穴' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["使用人"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    if p["武器"] > -1 then
        if JY.Thing[p["武器"]]["加医疗能力"] > 0 then
            Value = Value + JY.Thing[p["武器"]]["加医疗能力"] * 10 * fb +
                        JY.Thing[p["武器"]]["加医疗能力"] * (JY.Thing[p["武器"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["武器"]]["加医疗能力"] < 0 then
            Value = Value + JY.Thing[p["武器"]]["加医疗能力"] * 10 * fb -
                        JY.Thing[p["武器"]]["加医疗能力"] * (JY.Thing[p["武器"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if p["坐骑"] > -1 then
        if JY.Thing[p["坐骑"]]["加医疗能力"] > 0 then
            Value = Value + JY.Thing[p["坐骑"]]["加医疗能力"] * 10 * fb +
                        JY.Thing[p["坐骑"]]["加医疗能力"] * (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["坐骑"]]["加医疗能力"] < 0 then
            Value = Value + JY.Thing[p["坐骑"]]["加医疗能力"] * 10 * fb -
                        JY.Thing[p["坐骑"]]["加医疗能力"] * (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if p["防具"] > -1 then
        if JY.Thing[p["防具"]]["加医疗能力"] > 0 then
            Value = Value + JY.Thing[p["防具"]]["加医疗能力"] * 10 * fb +
                        JY.Thing[p["防具"]]["加医疗能力"] * (JY.Thing[p["防具"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["防具"]]["加医疗能力"] < 0 then
            Value = Value + JY.Thing[p["防具"]]["加医疗能力"] * 10 * fb -
                        JY.Thing[p["防具"]]["加医疗能力"] * (JY.Thing[p["防具"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if JY.Status == GAME_WMAP then
        for k, v in pairs(CC.AddDoc) do
            if match_ID(pid, v[1]) then
                for wid = 0, WAR.PersonNum - 1 do
                    if match_ID(WAR.Person[wid]["人物编号"], v[2]) and WAR.Person[wid]["死亡"] == false then
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

-- 附加用毒
function FJYONGD(pid)
    local Value = 0
    local p = JY.Person[pid]
    local kf = JY.Person[pid]['主运内功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
    local level = KF_level(pid, kf)
    -- 兵器谱
    if JY.Person[pid]["武器"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "加用毒能力"
        if JY.Person[pid]['奇穴' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["使用人"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    local fb = 1
    if p["武器"] > -1 then
        if JY.Thing[p["武器"]]["加用毒能力"] > 0 then
            Value = Value + JY.Thing[p["武器"]]["加用毒能力"] * 10 * fb +
                        JY.Thing[p["武器"]]["加用毒能力"] * (JY.Thing[p["武器"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["武器"]]["加用毒能力"] < 0 then
            Value = Value + JY.Thing[p["武器"]]["加用毒能力"] * 10 * fb -
                        JY.Thing[p["武器"]]["加用毒能力"] * (JY.Thing[p["武器"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if p["坐骑"] > -1 then
        if JY.Thing[p["坐骑"]]["加用毒能力"] > 0 then
            Value = Value + JY.Thing[p["坐骑"]]["加用毒能力"] * 10 * fb +
                        JY.Thing[p["坐骑"]]["加用毒能力"] * (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["坐骑"]]["加用毒能力"] < 0 then
            Value = Value + JY.Thing[p["坐骑"]]["加用毒能力"] * 10 * fb -
                        JY.Thing[p["坐骑"]]["加用毒能力"] * (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if p["防具"] > -1 then
        if JY.Thing[p["防具"]]["加用毒能力"] > 0 then
            Value = Value + JY.Thing[p["防具"]]["加用毒能力"] * 10 * fb +
                        JY.Thing[p["防具"]]["加用毒能力"] * (JY.Thing[p["防具"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["防具"]]["加用毒能力"] < 0 then
            Value = Value + JY.Thing[p["防具"]]["加用毒能力"] * 10 * fb -
                        JY.Thing[p["防具"]]["加用毒能力"] * (JY.Thing[p["防具"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if JY.Status == GAME_WMAP then
        for k, v in pairs(CC.AddPoi) do
            if match_ID(pid, v[1]) then
                for wid = 0, WAR.PersonNum - 1 do
                    if match_ID(WAR.Person[wid]["人物编号"], v[2]) and WAR.Person[wid]["死亡"] == false then
                        Value = Value + v[3]
                    end
                end
            end
        end
        -- 内轻特效707
        if NeiGong_tx(pid, 707) then
            Value = Value + dkfcj_ng * 100
        end
    end
    return Value
end

-- 附加解毒
function FJJIED(pid)
    local Value = 0
    local p = JY.Person[pid]
    local fb = 1
    local kf = JY.Person[pid]['主运内功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
    local level = KF_level(pid, kf)
    -- 兵器谱
    if JY.Person[pid]["武器"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "加解毒能力"
        if JY.Person[pid]['奇穴' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["使用人"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    if p["武器"] > -1 then
        if JY.Thing[p["武器"]]["加解毒能力"] > 0 then
            Value = Value + JY.Thing[p["武器"]]["加解毒能力"] * 10 * fb +
                        JY.Thing[p["武器"]]["加解毒能力"] * (JY.Thing[p["武器"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["武器"]]["加解毒能力"] < 0 then
            Value = Value + JY.Thing[p["武器"]]["加解毒能力"] * 10 * fb -
                        JY.Thing[p["武器"]]["加解毒能力"] * (JY.Thing[p["武器"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if p["坐骑"] > -1 then
        if JY.Thing[p["坐骑"]]["加解毒能力"] > 0 then
            Value = Value + JY.Thing[p["坐骑"]]["加解毒能力"] * 10 * fb +
                        JY.Thing[p["坐骑"]]["加解毒能力"] * (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["坐骑"]]["加解毒能力"] < 0 then
            Value = Value + JY.Thing[p["坐骑"]]["加解毒能力"] * 10 * fb -
                        JY.Thing[p["坐骑"]]["加解毒能力"] * (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if p["防具"] > -1 then
        if JY.Thing[p["防具"]]["加解毒能力"] > 0 then
            Value = Value + JY.Thing[p["防具"]]["加解毒能力"] * 10 * fb +
                        JY.Thing[p["防具"]]["加解毒能力"] * (JY.Thing[p["防具"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["防具"]]["加解毒能力"] < 0 then
            Value = Value + JY.Thing[p["防具"]]["加解毒能力"] * 10 * fb -
                        JY.Thing[p["防具"]]["加解毒能力"] * (JY.Thing[p["防具"]]["装备等级"] - 1) * 2 * fb
        end
    end
    return Value
end

-- 附加带毒
function FJDAID(pid)
    local Value = 0
    local p = JY.Person[pid]
    local kf = JY.Person[pid]['主运内功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
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
    -- 彩雪蛛
    for i = 430, 439 do
        if match_ID(pid, i) then
            Value = Value + 100
        end
    end
    -- 火蟾
    if match_ID(pid, 440) then
        Value = Value + 100
    end
    if JY.Person[pid]['门派'] == 28 then
        Value = Value + 100
    end
    Value = math.modf(Value)
    return Value
end

-- 附加暗器
function FJANQI(pid)
    local Value = 0
    local p = JY.Person[pid]
    local fb = 1
    local kf = JY.Person[pid]['主运内功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
    local level = KF_level(pid, kf)
    -- 兵器谱
    if JY.Person[pid]["武器"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "加暗器技巧"
        if JY.Person[pid]['奇穴' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["使用人"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    if p["武器"] > -1 then
        if JY.Thing[p["武器"]]["加暗器技巧"] > 0 then
            Value = Value + JY.Thing[p["武器"]]["加暗器技巧"] * 10 * fb +
                        JY.Thing[p["武器"]]["加暗器技巧"] * (JY.Thing[p["武器"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["武器"]]["加暗器技巧"] < 0 then
            Value = Value + JY.Thing[p["武器"]]["加暗器技巧"] * 10 * fb -
                        JY.Thing[p["武器"]]["加暗器技巧"] * (JY.Thing[p["武器"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if p["坐骑"] > -1 then
        if JY.Thing[p["坐骑"]]["加暗器技巧"] > 0 then
            Value = Value + JY.Thing[p["坐骑"]]["加暗器技巧"] * 10 * fb +
                        JY.Thing[p["坐骑"]]["加暗器技巧"] * (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["坐骑"]]["加暗器技巧"] < 0 then
            Value = Value + JY.Thing[p["坐骑"]]["加暗器技巧"] * 10 * fb -
                        JY.Thing[p["坐骑"]]["加暗器技巧"] * (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if p["防具"] > -1 then
        if JY.Thing[p["防具"]]["加暗器技巧"] > 0 then
            Value = Value + JY.Thing[p["防具"]]["加暗器技巧"] * 10 * fb +
                        JY.Thing[p["防具"]]["加暗器技巧"] * (JY.Thing[p["防具"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["防具"]]["加暗器技巧"] < 0 then
            Value = Value + JY.Thing[p["防具"]]["加暗器技巧"] * 10 * fb -
                        JY.Thing[p["防具"]]["加暗器技巧"] * (JY.Thing[p["防具"]]["装备等级"] - 1) * 2 * fb
        end
    end
    return Value
end

-- 附加拳掌
function FJQZ(pid)
    local Value = 0
    local kf = JY.Person[pid]['主运内功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
    local level = KF_level(pid, kf)

    -- 兵器谱
    if JY.Person[pid]["武器"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "加拳掌功夫"
        if JY.Person[pid]['奇穴' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["使用人"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    -- 一通万法
    if match_ID(pid, 9774) then
        for i = 1, JY.Base['武功数量'] do
            if JY.Person[pid]["武功等级" .. i] == 999 and JY.Person[pid]['武功' .. i] > 0 then
                Value = Value + 10
            end
        end
    end
    -- 金丝手套
    if JY.Person[pid]["武器"] == 239 then
        local bonus = 0
        bonus = bonus + 10
        Value = Value + 10
        if JY.Thing[239]["装备等级"] >= 5 then
            Value = Value + 30
        elseif JY.Thing[239]["装备等级"] >= 4 then
            Value = Value + 25
        elseif JY.Thing[239]["装备等级"] >= 3 then
            Value = Value + 20
        elseif JY.Thing[239]["装备等级"] >= 2 then
            Value = Value + 15
        end
    end
    if match_ID(pid, 9947) then
        for i = 1, JY.Base["武功数量"] do
            if JY.Wugong[JY.Person[pid]["武功" .. i]]["武功类型"] == 6 then
                Value = Value + 20
            end
        end
    end
    local p = JY.Person[pid]
    local fb = 1
    if p["武器"] > -1 then
        if JY.Thing[p["武器"]]["加指法技巧"] > 0 then
            Value = Value + JY.Thing[p["武器"]]["加指法技巧"] * 10 * fb +
                        JY.Thing[p["武器"]]["加指法技巧"] * (JY.Thing[p["武器"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["武器"]]["加指法技巧"] < 0 then
            Value = Value + JY.Thing[p["武器"]]["加指法技巧"] * 10 * fb -
                        JY.Thing[p["武器"]]["加指法技巧"] * (JY.Thing[p["武器"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if p["坐骑"] > -1 then
        if JY.Thing[p["坐骑"]]["加指法技巧"] > 0 then
            Value = Value + JY.Thing[p["坐骑"]]["加指法技巧"] * 10 * fb +
                        JY.Thing[p["坐骑"]]["加指法技巧"] * (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["坐骑"]]["加指法技巧"] < 0 then
            Value = Value + JY.Thing[p["坐骑"]]["加指法技巧"] * 10 * fb -
                        JY.Thing[p["坐骑"]]["加指法技巧"] * (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if p["防具"] > -1 then
        if JY.Thing[p["防具"]]["加指法技巧"] > 0 then
            Value = Value + JY.Thing[p["防具"]]["加指法技巧"] * 10 * fb +
                        JY.Thing[p["防具"]]["加指法技巧"] * (JY.Thing[p["防具"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["防具"]]["加指法技巧"] < 0 then
            Value = Value + JY.Thing[p["防具"]]["加指法技巧"] * 10 * fb -
                        JY.Thing[p["防具"]]["加指法技巧"] * (JY.Thing[p["防具"]]["装备等级"] - 1) * 2 * fb
        end
    end
    -- 林殊敌方人数人越多，系数越高   
    if JY.Status == GAME_WMAP then
        if match_ID(pid, 9745) then
            local jf = 0
            for j = 0, WAR.PersonNum - 1 do
                if WAR.Person[j]["死亡"] == false and WAR.Person[j]["我方"] == false then
                    jf = jf + 1
                end
            end
            Value = Value + jf * 5
        end
    end
    -- 内轻特效709
    if NeiGong_tx(pid, 709) then
        Value = Value + dkfcj_ng * 10 / 100 * JY.Person[pid]['拳掌功夫']
    end
    -- 内轻特效714
    if NeiGong_tx(pid, 714) then
        Value = Value + (dkfcj_ng + 1) * 6 / 100 * JY.Person[pid]['拳掌功夫']
    end
    return Value
end

-- 附加指法
function FJZF(pid)
    local Value = 0
    local kf = JY.Person[pid]['主运内功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
    local level = KF_level(pid, kf)
    -- 兵器谱
    if JY.Person[pid]["武器"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "加指法技巧"
        if JY.Person[pid]['奇穴' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["使用人"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    -- 一通万法
    if match_ID(pid, 9774) then
        for i = 1, JY.Base['武功数量'] do
            if JY.Person[pid]["武功等级" .. i] == 999 and JY.Person[pid]['武功' .. i] > 0 then
                Value = Value + 10
            end
        end
    end
    -- 金丝手套
    if JY.Person[pid]["武器"] == 239 then
        Value = Value + 10
        if JY.Thing[239]["装备等级"] >= 5 then
            Value = Value + 30
        elseif JY.Thing[239]["装备等级"] >= 4 then
            Value = Value + 25
        elseif JY.Thing[239]["装备等级"] >= 3 then
            Value = Value + 20
        elseif JY.Thing[239]["装备等级"] >= 2 then
            Value = Value + 15
        end
    end
    if match_ID(pid, 9947) then
        for i = 1, JY.Base["武功数量"] do
            if JY.Wugong[JY.Person[pid]["武功" .. i]]["武功类型"] == 6 then
                Value = Value + 20
            end
        end
    end
    local p = JY.Person[pid]
    local fb = 1
    if p["武器"] > -1 then
        if JY.Thing[p["武器"]]["加指法技巧"] > 0 then
            Value = Value + JY.Thing[p["武器"]]["加指法技巧"] * 10 * fb +
                        JY.Thing[p["武器"]]["加指法技巧"] * (JY.Thing[p["武器"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["武器"]]["加指法技巧"] < 0 then
            Value = Value + JY.Thing[p["武器"]]["加指法技巧"] * 10 * fb -
                        JY.Thing[p["武器"]]["加指法技巧"] * (JY.Thing[p["武器"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if p["坐骑"] > -1 then
        if JY.Thing[p["坐骑"]]["加指法技巧"] > 0 then
            Value = Value + JY.Thing[p["坐骑"]]["加指法技巧"] * 10 * fb +
                        JY.Thing[p["坐骑"]]["加指法技巧"] * (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["坐骑"]]["加指法技巧"] < 0 then
            Value = Value + JY.Thing[p["坐骑"]]["加指法技巧"] * 10 * fb -
                        JY.Thing[p["坐骑"]]["加指法技巧"] * (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if p["防具"] > -1 then
        if JY.Thing[p["防具"]]["加指法技巧"] > 0 then
            Value = Value + JY.Thing[p["防具"]]["加指法技巧"] * 10 * fb +
                        JY.Thing[p["防具"]]["加指法技巧"] * (JY.Thing[p["防具"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["防具"]]["加指法技巧"] < 0 then
            Value = Value + JY.Thing[p["防具"]]["加指法技巧"] * 10 * fb -
                        JY.Thing[p["防具"]]["加指法技巧"] * (JY.Thing[p["防具"]]["装备等级"] - 1) * 2 * fb
        end
    end
    -- 林殊敌方人数人越多，系数越高    
    if JY.Status == GAME_WMAP then
        if match_ID(pid, 9745) then
            local jf = 0
            for j = 0, WAR.PersonNum - 1 do
                if WAR.Person[j]["死亡"] == false and WAR.Person[j]["我方"] == false then
                    jf = jf + 1
                end
            end
            Value = Value + jf * 5
        end
    end
    -- 内轻特效710
    if NeiGong_tx(pid, 710) then
        Value = Value + dkfcj_ng * 10 / 100 * JY.Person[pid]['指法技巧']
    end
    -- 内轻特效714
    if NeiGong_tx(pid, 714) then
        Value = Value + (dkfcj_ng + 1) * 6 / 100 * JY.Person[pid]['指法技巧']
    end
    return Value
end

-- 附加剑法
function FJYJ(pid)
    local Value = 0
    local kf = JY.Person[pid]['主运内功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
    local level = KF_level(pid, kf)
    -- 兵器谱
    if JY.Person[pid]["武器"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "加御剑能力"
        if JY.Person[pid]['奇穴' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["使用人"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    -- 一通万法
    if match_ID(pid, 9774) then
        for i = 1, JY.Base['武功数量'] do
            if JY.Person[pid]["武功等级" .. i] == 999 and JY.Person[pid]['武功' .. i] > 0 then
                Value = Value + 10
            end
        end
    end
    -- 五岳剑法
    if WuyueJFSL(pid) > 0 then
        Value = Value + WuyueJFSL(pid) * 20
    end
    if match_ID(pid, 9947) then
        for i = 1, JY.Base["武功数量"] do
            if JY.Wugong[JY.Person[pid]["武功" .. i]]["武功类型"] == 6 then
                Value = Value + 20
            end
        end
    end
    local p = JY.Person[pid]
    local fb = 1
    if p["武器"] > -1 then
        if JY.Thing[p["武器"]]["加御剑能力"] > 0 then
            Value = Value + JY.Thing[p["武器"]]["加御剑能力"] * 10 * fb +
                        JY.Thing[p["武器"]]["加御剑能力"] * (JY.Thing[p["武器"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["武器"]]["加御剑能力"] < 0 then
            Value = Value + JY.Thing[p["武器"]]["加御剑能力"] * 10 * fb -
                        JY.Thing[p["武器"]]["加御剑能力"] * (JY.Thing[p["武器"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if p["坐骑"] > -1 then
        if JY.Thing[p["坐骑"]]["加御剑能力"] > 0 then
            Value = Value + JY.Thing[p["坐骑"]]["加御剑能力"] * 10 * fb +
                        JY.Thing[p["坐骑"]]["加御剑能力"] * (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["坐骑"]]["加御剑能力"] < 0 then
            Value = Value + JY.Thing[p["坐骑"]]["加御剑能力"] * 10 * fb -
                        JY.Thing[p["坐骑"]]["加御剑能力"] * (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if p["防具"] > -1 then
        if JY.Thing[p["防具"]]["加御剑能力"] > 0 then
            Value = Value + JY.Thing[p["防具"]]["加御剑能力"] * 10 * fb +
                        JY.Thing[p["防具"]]["加御剑能力"] * (JY.Thing[p["防具"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["防具"]]["加御剑能力"] < 0 then
            Value = Value + JY.Thing[p["防具"]]["加御剑能力"] * 10 * fb -
                        JY.Thing[p["防具"]]["加御剑能力"] * (JY.Thing[p["防具"]]["装备等级"] - 1) * 2 * fb
        end
    end
    -- 刀剑双绝
    if match_ID(pid, 9735) then
        Value = Value + JY.Person[pid]['耍刀技巧'] * 0.5
    end
    -- 战斗中的加成
    if JY.Status == GAME_WMAP then
        -- 步惊云剑法 系数
        if match_ID(pid, 584) then
            local JF = 0
            for i = 1, JY.Base["武功数量"] do
                if JY.Wugong[JY.Person[pid]["武功" .. i]]["武功类型"] == 3 then
                    JF = JF + 1
                    break
                end
                Value = Value + math.modf(JF * 10)
            end
        end
        -- 林殊敌方人数人越多，系数越高    
        if match_ID(pid, 9745) then
            local jf = 0
            for j = 0, WAR.PersonNum - 1 do
                if WAR.Person[j]["死亡"] == false and WAR.Person[j]["我方"] == false then
                    jf = jf + 1
                end
            end
            Value = Value + jf * 5
        end
    end
    -- 内轻特效711
    if NeiGong_tx(pid, 711) then
        Value = Value + dkfcj_ng * 10 / 100 * JY.Person[pid]['御剑能力']
    end
    -- 内轻特效714
    if NeiGong_tx(pid, 714) then
        Value = Value + (dkfcj_ng + 1) * 6 / 100 * JY.Person[pid]['御剑能力']
    end
    Value = math.modf(Value)
    return Value
end

-- 附加刀法
function FJDF(pid)
    local Value = 0
    local kf = JY.Person[pid]['主运内功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
    local level = KF_level(pid, kf)
    -- 兵器谱
    if JY.Person[pid]["武器"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "加耍刀技巧"
        if JY.Person[pid]['奇穴' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["使用人"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    -- 一通万法
    if match_ID(pid, 9774) then
        for i = 1, JY.Base['武功数量'] do
            if JY.Person[pid]["武功等级" .. i] == 999 and JY.Person[pid]['武功' .. i] > 0 then
                Value = Value + 10
            end
        end
    end
    if match_ID(pid, 9947) then
        for i = 1, JY.Base["武功数量"] do
            if JY.Wugong[JY.Person[pid]["武功" .. i]]["武功类型"] == 6 then
                Value = Value + 20
            end
        end
    end
    local p = JY.Person[pid]
    local fb = 1
    if p["武器"] > -1 then
        if JY.Thing[p["武器"]]["加耍刀技巧"] > 0 then
            Value = Value + JY.Thing[p["武器"]]["加耍刀技巧"] * 10 * fb +
                        JY.Thing[p["武器"]]["加耍刀技巧"] * (JY.Thing[p["武器"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["武器"]]["加耍刀技巧"] < 0 then
            Value = Value + JY.Thing[p["武器"]]["加耍刀技巧"] * 10 * fb -
                        JY.Thing[p["武器"]]["加耍刀技巧"] * (JY.Thing[p["武器"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if p["坐骑"] > -1 then
        if JY.Thing[p["坐骑"]]["加耍刀技巧"] > 0 then
            Value = Value + JY.Thing[p["坐骑"]]["加耍刀技巧"] * 10 * fb +
                        JY.Thing[p["坐骑"]]["加耍刀技巧"] * (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["坐骑"]]["加耍刀技巧"] < 0 then
            Value = Value + JY.Thing[p["坐骑"]]["加耍刀技巧"] * 10 * fb -
                        JY.Thing[p["坐骑"]]["加耍刀技巧"] * (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if p["防具"] > -1 then
        if JY.Thing[p["防具"]]["加耍刀技巧"] > 0 then
            Value = Value + JY.Thing[p["防具"]]["加耍刀技巧"] * 10 * fb +
                        JY.Thing[p["防具"]]["加耍刀技巧"] * (JY.Thing[p["防具"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["防具"]]["加耍刀技巧"] < 0 then
            Value = Value + JY.Thing[p["防具"]]["加耍刀技巧"] * 10 * fb -
                        JY.Thing[p["防具"]]["加耍刀技巧"] * (JY.Thing[p["防具"]]["装备等级"] - 1) * 2 * fb
        end
    end
    -- 刀剑双绝
    if match_ID(pid, 9735) then
        Value = Value + JY.Person[pid]['御剑能力'] * 0.5
    end
    -- 林殊敌方人数人越多，系数越高  
    if JY.Status == GAME_WMAP then
        if match_ID(pid, 9745) then
            local df = 0
            for j = 0, WAR.PersonNum - 1 do
                if WAR.Person[j]["死亡"] == false and WAR.Person[j]["我方"] == false then
                    df = df + 1
                end
            end
            Value = Value + df * 5
        end
    end
    -- 内轻特效712
    if NeiGong_tx(pid, 712) then
        Value = Value + dkfcj_ng * 10 / 100 * JY.Person[pid]['耍刀技巧']
    end
    -- 内轻特效714
    if NeiGong_tx(pid, 714) then
        Value = Value + (dkfcj_ng + 1) * 6 / 100 * JY.Person[pid]['耍刀技巧']
    end
    return Value
end

-- 附加奇门 附加特殊兵器
function FJQM(pid)
    local Value = 0
    local kf = JY.Person[pid]['主运内功']
    local dkfcj_ng = JY.Wugong[kf]['层级']
    local level = KF_level(pid, kf)
    -- 兵器谱
    if JY.Person[pid]["武器"] > 0 then
        local tmenu = {49, 50, 51, 52, 53, 54, 57, 243, 244, 276, 323, 349, 509, 511, 512, 513}
        local jsx = "加特殊兵器"
        if JY.Person[pid]['奇穴' .. 69] == 1 then
            for i = 1, #tmenu do
                local p = JY.Person[pid]
                local fb = 2
                local thid = tmenu[i]
                if thid ~= nil and thid > 0 then
                    if JY.Thing[thid]["使用人"] == -1 and CanUseThing(thid, pid) then
                        if JY.Thing[thid][jsx] > 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 + JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        elseif JY.Thing[thid][jsx] < 0 then
                            Value = Value +
                                        (JY.Thing[thid][jsx] * 10 - JY.Thing[thid][jsx] *
                                            (JY.Thing[thid]["装备等级"] - 1) * 2) / 2
                        end
                    end
                end
            end
        end
    end
    -- 一通万法
    if match_ID(pid, 9774) then
        for i = 1, JY.Base['武功数量'] do
            if JY.Person[pid]["武功等级" .. i] == 999 and JY.Person[pid]['武功' .. i] > 0 then
                Value = Value + 10
            end
        end
    end
    if match_ID(pid, 9947) then
        for i = 1, JY.Base["武功数量"] do
            if JY.Wugong[JY.Person[pid]["武功" .. i]]["武功类型"] == 6 then
                Value = Value + 20
            end
        end
    end
    local p = JY.Person[pid]
    local fb = 1
    if p["武器"] > -1 then
        if JY.Thing[p["武器"]]["加特殊兵器"] > 0 then
            Value = Value + JY.Thing[p["武器"]]["加特殊兵器"] * 10 * fb +
                        JY.Thing[p["武器"]]["加特殊兵器"] * (JY.Thing[p["武器"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["武器"]]["加特殊兵器"] < 0 then
            Value = Value + JY.Thing[p["武器"]]["加特殊兵器"] * 10 * fb -
                        JY.Thing[p["武器"]]["加特殊兵器"] * (JY.Thing[p["武器"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if p["坐骑"] > -1 then
        if JY.Thing[p["坐骑"]]["加特殊兵器"] > 0 then
            Value = Value + JY.Thing[p["坐骑"]]["加特殊兵器"] * 10 * fb +
                        JY.Thing[p["坐骑"]]["加特殊兵器"] * (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["坐骑"]]["加特殊兵器"] < 0 then
            Value = Value + JY.Thing[p["坐骑"]]["加特殊兵器"] * 10 * fb -
                        JY.Thing[p["坐骑"]]["加特殊兵器"] * (JY.Thing[p["坐骑"]]["装备等级"] - 1) * 2 * fb
        end
    end
    if p["防具"] > -1 then
        if JY.Thing[p["防具"]]["加特殊兵器"] > 0 then
            Value = Value + JY.Thing[p["防具"]]["加特殊兵器"] * 10 * fb +
                        JY.Thing[p["防具"]]["加特殊兵器"] * (JY.Thing[p["防具"]]["装备等级"] - 1) * 2 * fb
        elseif JY.Thing[p["防具"]]["加特殊兵器"] < 0 then
            Value = Value + JY.Thing[p["防具"]]["加特殊兵器"] * 10 * fb -
                        JY.Thing[p["防具"]]["加特殊兵器"] * (JY.Thing[p["防具"]]["装备等级"] - 1) * 2 * fb
        end
    end
    -- 林殊敌方人数人越多，系数越高 
    if JY.Status == GAME_WMAP then
        if match_ID(pid, 9745) then
            local df = 0
            for j = 0, WAR.PersonNum - 1 do
                if WAR.Person[j]["死亡"] == false and WAR.Person[j]["我方"] == false then
                    df = df + 1
                end
            end
            Value = Value + df * 5
        end
    end
    -- 内轻特效713
    if NeiGong_tx(pid, 713) then
        Value = Value + dkfcj_ng * 10 / 100 * JY.Person[pid]['特殊兵器']
    end
    -- 内轻特效714
    if NeiGong_tx(pid, 714) then
        Value = Value + (dkfcj_ng + 1) * 6 / 100 * JY.Person[pid]['特殊兵器']
    end
    return Value
end

-- 真实属性
-- 无酒不欢：真实拳掌能力的判定
function TrueQZ(id)
    local qz = JY.Person[id]["拳掌功夫"]
    qz = qz + FJQZ(id)
    return qz
end

-- 无酒不欢：真实指法能力的判定
function TrueZF(id)
    local zf = JY.Person[id]["指法技巧"]
    zf = zf + FJZF(id)
    return zf
end

-- 无酒不欢：真实御剑能力的判定
function TrueYJ(id)
    local yj = JY.Person[id]["御剑能力"]
    yj = yj + FJYJ(id)
    return yj
end

-- 无酒不欢：真实耍刀能力的判定
function TrueSD(id)
    local sd = JY.Person[id]["耍刀技巧"]
    sd = sd + FJDF(id)
    return sd
end

-- 无酒不欢：真实特殊能力的判定
function TrueTS(id)
    local ts = JY.Person[id]["特殊兵器"]
    ts = ts + FJQM(id)
    return ts
end

-- 无酒不欢：判定一个人物是否满足琴棋书画的条件
function QinqiSH(id)
    if PersonKF(id, 73) and PersonKF(id, 72) and PersonKF(id, 84) and PersonKF(id, 142) then
        return true
    end
    return false
end

-- 随风飘叶 调整队友顺序
function Menu_TZDY()
    local menu = {}
    local px = {}
    local m = 0
    -- 队友超过2人才会生效
    if JY.Base["队伍" .. 3] > 0 then
        Cls()
        DrawStrBox(CC.MainMenuX, CC.MainSubMenuY, "需要调整谁的位置", LimeGreen, CC.DefaultFont, C_GOLD);
        local nexty = CC.MainSubMenuY + CC.SingleLineHeight;
        for i = 1, CC.TeamNum do
            menu[i] = {"", nil, 0};
            local id = JY.Base["队伍" .. i]
            if id > 0 then
                menu[i] = {"", nil, 0};
                if JY.Person[id]["生命"] > 0 then
                    menu[i][1] = JY.Person[id]["姓名"];
                    menu[i][3] = 1;
                end
            end
        end

        local r = -1;
        while true do
            r = ShowMenu(menu, #menu, 0, CC.MainMenuX, CC.MainSubMenuY + CC.SingleLineHeight, 0, 0, 1, 1,
                CC.DefaultFont, C_ORANGE, C_WHITE)
            if px["交换人"] == nil and r > 1 then
                px["交换人"] = r
                menu[r] = {"", nil, 0}
                Cls()
                DrawStrBox(CC.MainMenuX, CC.MainSubMenuY,
                    JY.Person[JY.Base["队伍" .. r]]["姓名"] .. "和谁交换位置", LimeGreen, CC.DefaultFont,
                    C_GOLD);
            elseif r > 1 and px["交换人"] ~= nil and r ~= px["交换人"] then
                local m1 = JY.Base["队伍" .. r]
                local m2 = JY.Base["队伍" .. px["交换人"]]
                JY.Base["队伍" .. r] = m2
                JY.Base["队伍" .. px["交换人"]] = m1
                say("Ｇ" .. JY.Person[m2]["姓名"] .. "Ｗ 和 Ｇ" .. JY.Person[m1]["姓名"] ..
                        "Ｗ 交换了位置。", m2, 1)
                Cls()
                -- return
                break
                -- 无酒不欢：增加ESC退出功能
            else
                break
            end
        end
    end
end

-- 无酒不欢：画一条线
function DrawSingleLine(x1, y1, x2, y2, color)
    lib.DrawRect(x1 + 1, y1 + 1, x2, y2, color)
    lib.DrawRect(x1, y1, x2 - 1, y2 - 1, color)
end

-- 改变天外
function SetTianWai(personid, x, wugongid)
    JY.Person[personid]["天赋外功" .. x] = wugongid
    if personid == JY.Base["畅想"] then
        JY.Person[0]["天赋外功" .. x] = wugongid
    end
end

-- 改变天内
function SetTianNei(personid, wugongid)
    JY.Person[personid]["天赋内功"] = wugongid
    if personid == JY.Base["畅想"] then
        JY.Person[0]["天赋内功"] = wugongid
    end
end

-- 改变天轻
function SetTianQing(personid, wugongid)
    JY.Person[personid]["天赋轻功"] = wugongid
    if personid == JY.Base["畅想"] then
        JY.Person[0]["天赋轻功"] = wugongid
    end
end

-- 计算人物五系兵器值之和
function Xishu_sum(id)
    local sum = 0
    sum = sum + TrueQZ(id)
    sum = sum + TrueZF(id)
    sum = sum + TrueYJ(id)
    sum = sum + TrueSD(id)
    sum = sum + TrueTS(id)
    return sum
end

-- 求人物五系兵器值最高的一项
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

-- 剪裁版背景图
function Clipped_BgImg(x1, y1, x2, y2, picnum)
    lib.SetClip(x1 + 2, y1 + 2, x2 - 1, y2 - 1)
    lib.LoadPNG(1, picnum * 2, -1, -1, 1)
    lib.SetClip(0, 0, 0, 0)
end

-- 显示带边框的文字
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

-- 绘制一片四角凹进的背景
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

-- 物品详细说明
function detailed_info(thingID)
    local str = JY.Thing[thingID]["代号"] .. JY.Thing[thingID]["名称"]
    local str2 = JY.Thing[thingID]["物品说明"]
    local str3 = JY.Thing[thingID]["名称"]
    if ItemInfo[thingID] == nil then
        return
    end
    local info = {}
    info = ItemInfo[thingID]
    local function strcolor_switch(s)
        local Color_Switch = {{"Ｒ", PinkRed}, {"Ｇ", C_GOLD}, {"Ｂ", C_BLACK}, {"Ｗ", C_WHITE}, {"Ｏ", C_ORANGE},
                              {"Ｌ", LimeGreen}, {"Ｄ", M_DeepSkyBlue}, {"Ｚ", Violet}}
        for i = 1, 8 do
            if Color_Switch[i][1] == s then
                return Color_Switch[i][2]
            end
        end
    end
    local maxRowExisting = #info -- 当前说明总行数
    local maxRowDisplayable = 11 -- 当面页面可以显示的最大行数
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
            if string.sub(tfstr, 1, 2) == "Ｎ" then
                row = row + 1
            else
                local color;
                color = strcolor_switch(string.sub(tfstr, 1, 2))
                tfstr = string.sub(tfstr, 3, -1)
                DrawString(22, 80 + (size + CC.RowPixel * 2) * (row), tfstr, color, size)
                row = row + 1
            end
        end
        -- 上下翻的箭头显示
        if startingRow > 1 then
            DrawString(CC.ScreenW - 40, 110, "↑", C_GOLD, size)
        end
        if startingRow + maxRowDisplayable < maxRowExisting then
            DrawString(CC.ScreenW - 40, CC.ScreenH - 140, "↓", C_GOLD, size)
        end
        DrawString(CC.ScreenW - 220, CC.ScreenH - 40, "按F1返回物品菜单", C_ORANGE, size)
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
        if JY.Person[id]["秘技" .. i] == m then
            return true
        end
    end
    return false
end

-- 换装
function Avatar_Switch(id)
    -- 判断是否畅想
    local Ani_id = id
    if id == 0 and JY.Base["畅想"] > 0 then
        Ani_id = JY.Base["畅想"]
    end
    if Avatar[Ani_id] == nil then
        return
    end
    local r = LGMsgBox("一键换装", "请选择" .. JY.Person[id]["姓名"] .. "的造型",
        {Avatar[Ani_id][1].name, Avatar[Ani_id][2].name}, #Avatar[Ani_id], id, 1)
    JY.Person[id]["头像代号"] = Avatar[Ani_id][r].num
    JY.Person[id]["半身像"] = Avatar[Ani_id][r].num2
    for i = 1, 5 do
        JY.Person[id]["出招动画帧数" .. i] = Avatar[Ani_id][r].frameNum[i]
        JY.Person[id]["出招动画延迟" .. i] = Avatar[Ani_id][r].frameDelay[i]
        JY.Person[id]["武功音效延迟" .. i] = Avatar[Ani_id][r].soundDelay[i]
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

                if string.len(JY.Person[i]["姓名"]) == 8 then
                    indent = 29
                elseif string.len(JY.Person[i]["姓名"]) == 6 then
                    indent = 14
                end

                DrawString(x + 61 - indent, h, JY.Person[i]["姓名"], color, CC.DefaultFont)
                h = h + space

                DrawString(x + 58, h, "LV" .. JY.Person[i]["等级"], color, CC.Fontsmall)
                h = h + space

                DrawString(x + 41, h, "攻击 " .. JY.Person[i]["攻击力"], color, CC.Fontsmall)
                h = h + space

                DrawString(x + 41, h, "防御 " .. JY.Person[i]["防御力"], color, CC.Fontsmall)
                h = h + space

                DrawString(x + 41, h, "轻功 " .. JY.Person[i]["轻功"], color, CC.Fontsmall)
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

                if string.len(JY.Person[i]["姓名"]) == 8 then
                    indent = 29
                elseif string.len(JY.Person[i]["姓名"]) == 6 then
                    indent = 14
                end

                DrawString(x + 61 - indent, h, JY.Person[i]["姓名"], color, CC.DefaultFont)
                h = h + space

                DrawString(x + 58, h, "LV" .. JY.Person[i]["等级"], color, CC.Fontsmall)
                h = h + space

                DrawString(x + 41, h, "攻击 " .. JY.Person[i]["攻击力"], color, CC.Fontsmall)
                h = h + space

                DrawString(x + 41, h, "防御 " .. JY.Person[i]["防御力"], color, CC.Fontsmall)
                h = h + space

                DrawString(x + 41, h, "轻功 " .. JY.Person[i]["轻功"], color, CC.Fontsmall)
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

-- 选择张家辉的秘籍
-- 上上下下左右左右BABA
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

-- 根据动画贴图计算动画编号
function tjmdh(num)
    local a = 0
    for i = 0, #CC.Effect do
        a = CC.Effect[i] + a
        if num <= a then
            say(i, 0, 1)
            break
        end
        if i == #CC.Effect and num > a then
            say('超出范围', 0, 1)
            break
        end
    end
end

-- 老顾人物
-- 畅想人物页面
function firstmenu()
    local bx, by = CC.WX, CC.HY
    local size = CC.DefaultFont
    local tsmenu = {'飞', '雪', '连', '天', '射', '白', '鹿', '笑', '书', '神', '侠', '倚', '碧', '鸳'}
    local tsmenu1 = {'飞狐外传', '雪山飞狐', '连城诀', '天龙八部', '射雕英雄传', '白马啸西风',
                     '鹿鼎记', '笑傲江湖', '书剑恩仇录', '神雕侠侣', '侠客行', '倚天屠龙记',
                     '碧血剑', '鸳鸯刀'}
    local menu2 = {{1, 2, 3, 4, 72, 587, 731, 739, 740, 741, 742, 732, 748}, -- 飞
    {633, 738, 545, 722}, -- 雪
    {37, 589, 94, 95, 96, 97, 52, 594, 595}, -- 连
    {49, 50, 53, 51, 76, 47, 46, 48, 103, 113, 112, 114, 115, 116, 117, 118, 98, 99, 100, 104, 90, 105, 102, 70, 634,
     45, 574, 44, 565, 576, 499}, -- 天
    {55, 56, 57, 60, 61, 64, 65, 67, 68, 69, 78, 123, 128, 567, 568, 588, 130, 129, 605, 650, 604}, -- 射
    {590, 138, 137}, -- 白
    {601, 86, 87, 602, 603, 150, 71}, -- 鹿
    {35, 36, 73, 79, 27, 19, 20, 21, 22, 23, 24, 25, 26, 28, 29, 88, 140, 141, 142, 149, 234, 458, 510, 593, 649, 583}, -- 笑
    {74, 75, 80, 151, 152, 153, 154, 155, 156, 311, 313, 570, 571, 569, 657, 658, 656, 655, 606}, -- 书
    {58, 59, 63, 626, 62, 84, 89, 580, 161, 616, 617, 160, 157, 158, 159, 592, 628, 627}, -- 神
    {38, 581, 582, 39, 40, 41, 42, 43, 85, 164, 162, 163, 636}, -- 侠
    {9, 609, 631, 66, 646, 5, 6, 7, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 169, 170, 174, 81, 82, 640, 647, 648, 638,
     586, 573, 575, 597, 641, 532, 534, 308}, -- 倚
    {54, 91, 629, 183, 184, 185, 186, 607, 83, 176, 639}, -- 碧
    {77, 566, 189, 615, 614, 613, 612} -- 鸳
    }
    local tb = 1
    local lb = 1
    local rw, rw1 = 1, 0

    local fy, fymax, star = 0, 0, 1
    -- 畅想
    local cx, ts, zj, xb = 0, 0, 0, 0
    local tbx, tby = bx * 1225, by * 195
    local tsw, tsh = bx * 54, by * 45
    local dh = 0
    while true do
        if JY.Restart == 1 then
            break
        end
        -- 清除画面，因为菜单是无限循环的状态，所以显示画面前，需要清除之前的画面，否则贴图无限叠加
        ClsN()

        ---------------
        lib.LoadPNG(91, 24 * 2, -1, -1, 1)
        lib.LoadPNG(91, 25 * 2, -1, -1, 1)
        lib.LoadPNG(91, 26 * 2, -1, -1, 1)
        for i = 1, #tsmenu do
            local cl = C_BLACK
            local tsbx, tsby = bx * 1225, by * 195 -- 初始坐标
            if i > 7 then
                tsbx, tsby = bx * 75, by * 195 -- 初始坐标
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
                    local pic = JY.Person[id]["半身像"]
                    local name = JY.Person[id]["姓名"]
                    local rwx, rwy = bx * 276, by * 165
                    local rww, rwh = bx * 140, by * 110
                    if rw == i then
                        lib.LoadPNG(90, pic * 2, bx * 276, by * 410, 1, 0, 90)
                        lib.LoadPNG(91, 12 * 2, rwx + (rw - 1) * rww - bx * 5, rwy - by * 10, 1, 0, 116)
                        cl = C_RED
                        local me = {}
                        local row = 0
                        local maxh = 9
                        -- lib.Debug(name..' tf='..JY.Person[id]['天赋'..1])
                        for i = 1, 5 do
                            if JY.Person[id]['天赋' .. i] > 0 then
                                local tf = JY.Person[id]['天赋' .. i]
                                -- lib.Debug(name..' tf='..JY.Person[id]['天赋'..1])
                                if CC.PTFSM[tf] ~= nil then
                                    me[#me + 1] = 'Ｌ' .. CC.PTFSM[tf][1]
                                    me[#me + 1] = 'Ｗ' .. CC.PTFSM[tf][2]
                                    me[#me + 1] = "Ｎ"
                                end
                            end
                        end
                        for i = 1, #ZJZSJS do
                            me[#me + 1] = ZJZSJS[i]
                            if i == #ZJZSJS then
                                me[#me + 1] = "Ｎ"
                            end
                        end
                        for i = star, #me do
                            local tfstr = me[i]
                            local h = 0
                            if string.sub(tfstr, 1, 2) == "Ｎ" then
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
                if JY.Person[dhid]['出招动画帧数' .. j] > 0 then
                    if j > 1 then
                        zs = JY.Person[dhid]['出招动画帧数' .. j]
                        break
                    end
                    dl = dl + JY.Person[dhid]['出招动画帧数' .. j] * 4
                end
            end
            lib.PicLoadCache(JY.Person[dhid]["头像代号"] + 101, (dl + dh + zs * 3) * 2, bx * 290, by * 700)
            dh = dh + 1
            if dh == zs then
                dh = 0
            end
        end
        -- 显示画面
        ShowScreen()
        -- 循环的间隔（数值随意）
        lib.Delay(80)
        -- X是键盘操作，ktype是鼠标操作，ktype = 3 代表左键，4代表右键，6滚轮上，7滚轮下
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
                local nd = JY.Base["难度"]
                local addkfnum
                JY.Base["畅想"] = menu2[tb][rw + rw1]
                local clone_choice = JY.Base["畅想"]
                JY.Person[0]["代号"] = JY.Person[clone_choice]["代号"]
                JY.Person[0]["头像代号"] = JY.Person[clone_choice]["头像代号"]
                JY.Person[0]["半身像"] = JY.Person[clone_choice]["半身像"]
                JY.Person[0]["体质"] = JY.Person[clone_choice]["体质"]
                if JY.Person[0]["体质"] < 5 then
                    JY.Person[0]["体质"] = 5
                end
                if JY.Person[0]["体质"] > 12 then
                    JY.Person[0]["体质"] = 12
                end
                JY.Person[0]["姓名"] = JY.Person[clone_choice]["姓名"]
                JY.Person[0]["外号"] = JY.Person[clone_choice]["外号"]
                JY.Person[0]["性别"] = JY.Person[clone_choice]["性别"]

                JY.Person[0]["武器"] = -1
                JY.Person[0]["防具"] = -1
                JY.Person[0]["坐骑"] = -1
                for i = 1, 2 do
                    JY.Person[0]["武功" .. i] = JY.Person[clone_choice]["武功" .. i]
                    JY.Person[0]["武功等级" .. i] = JY.Person[clone_choice]["武功等级" .. i]
                end
                CC.kaijuwugong1 = JY.Person[0]["武功1"]
                CC.kaijuwugong2 = JY.Person[0]["武功2"]
                CC.kaijuwugong3 = JY.Person[0]["武功3"]
                CC.kaijuwugongx1 = JY.Person[0]["武功等级1"]
                CC.kaijuwugongx2 = JY.Person[0]["武功等级2"]
                CC.kaijuwugongx3 = JY.Person[0]["武功等级3"]
                for i = 1, 5 do
                    JY.Person[0]["出招动画帧数" .. i] = JY.Person[clone_choice]["出招动画帧数" .. i]
                    JY.Person[0]["出招动画延迟" .. i] = JY.Person[clone_choice]["出招动画延迟" .. i]
                    JY.Person[0]["武功音效延迟" .. i] = JY.Person[clone_choice]["武功音效延迟" .. i]
                end

                -- 畅想攻防轻最低55
                JY.Person[0]["攻击力"] = limitX(JY.Person[clone_choice]["攻击力"] / 4, 55, 75)
                JY.Person[0]["防御力"] = limitX(JY.Person[clone_choice]["防御力"] / 4, 55, 75)
                JY.Person[0]["轻功"] = limitX(JY.Person[clone_choice]["轻功"] / 4, 55, 75)
                -- 医疗用毒解毒最低30
                JY.Person[0]["医疗能力"] = limitX(JY.Person[clone_choice]["医疗能力"], 30)
                JY.Person[0]["用毒能力"] = limitX(JY.Person[clone_choice]["用毒能力"], 30)
                JY.Person[0]["解毒能力"] = limitX(JY.Person[clone_choice]["解毒能力"], 30)
                JY.Person[0]["暗器技巧"] = limitX(JY.Person[clone_choice]["暗器技巧"], 30) + zm
                JY.Person[0]["抗毒能力"] = JY.Person[clone_choice]["抗毒能力"]
                JY.Person[0]["主运内功"] = 0
                JY.Person[0]["主运轻功"] = 0

                if CC.PersonExit[clone_choice] ~= nil then

                    JY.Person[0]["拳掌功夫"] = limitX(JY.Person[clone_choice]["拳掌功夫"], 30, 70) + zm
                    JY.Person[0]["指法技巧"] = limitX(JY.Person[clone_choice]["指法技巧"], 30, 70) + zm
                    JY.Person[0]["御剑能力"] = limitX(JY.Person[clone_choice]["御剑能力"], 30, 70) + zm
                    JY.Person[0]["耍刀技巧"] = limitX(JY.Person[clone_choice]["耍刀技巧"], 30, 70) + zm
                    JY.Person[0]["特殊兵器"] = limitX(JY.Person[clone_choice]["特殊兵器"], 30, 70) + zm
                else

                    JY.Person[0]["拳掌功夫"] = limitX(JY.Person[clone_choice]["拳掌功夫"] / 3, 30, 70) + zm
                    JY.Person[0]["指法技巧"] = limitX(JY.Person[clone_choice]["指法技巧"] / 3, 30, 70) + zm
                    JY.Person[0]["御剑能力"] = limitX(JY.Person[clone_choice]["御剑能力"] / 3, 30, 70) + zm
                    JY.Person[0]["耍刀技巧"] = limitX(JY.Person[clone_choice]["耍刀技巧"] / 3, 30, 70) + zm
                    JY.Person[0]["特殊兵器"] = limitX(JY.Person[clone_choice]["特殊兵器"] / 3, 30, 70) + zm
                end

                JY.Person[0]["武学常识"] = JY.Person[clone_choice]["武学常识"]
                JY.Person[0]["攻击带毒"] = JY.Person[clone_choice]["攻击带毒"]
                for i = 1, 5 do
                    JY.Person[0]["秘技" .. i] = JY.Person[clone_choice]["秘技" .. i]
                end

                for i = 1, 4 do
                    JY.Person[0]["携带物品" .. i] = JY.Person[clone_choice]["携带物品" .. i]
                    JY.Person[0]["携带物品数量" .. i] = JY.Person[clone_choice]["携带物品数量" .. i]
                end

                for i = 1, 2 do
                    JY.Person[0]["天赋外功" .. i] = JY.Person[clone_choice]["天赋外功" .. i]
                end

                JY.Person[0]["天赋内功"] = JY.Person[clone_choice]["天赋内功"]
                JY.Person[0]["天赋轻功"] = JY.Person[clone_choice]["天赋轻功"]
                JY.Person[0]["畅想分阶"] = JY.Person[clone_choice]["畅想分阶"]
                JY.Person[0]["外号2"] = JY.Person[clone_choice]["外号2"]
                JY.Person[0]["特色指令"] = JY.Person[clone_choice]["特色指令"]
                JY.Person[0]["特色指令"] = JY.Person[clone_choice]["特色指令"]
                JY.Person[0]["拳法成长"] = JY.Person[clone_choice]["拳法成长"]
                JY.Person[0]["指法成长"] = JY.Person[clone_choice]["指法成长"]
                JY.Person[0]["剑法成长"] = JY.Person[clone_choice]["剑法成长"]
                JY.Person[0]["刀法成长"] = JY.Person[clone_choice]["刀法成长"]
                JY.Person[0]["奇门成长"] = JY.Person[clone_choice]["奇门成长"]
                for i = 1, 5 do
                    JY.Person[0]['天赋' .. i] = JY.Person[clone_choice]['天赋' .. i]
                    -- lib.Debug(i..'畅想主角天赋 = '..JY.Person[0]['天赋'..i])
                end

                -- 畅想裘千尺头像变美
                if JY.Base["畅想"] == 617 then
                    JY.Person[0]["头像代号"] = 353
                    JY.Person[0]["半身像"] = 353
                    JY.Person[0]["出招动画帧数3"] = 24
                    JY.Person[0]["出招动画延迟3"] = 22
                    JY.Person[0]["武功音效延迟3"] = 22
                end
                -- 东方不败初骀
                if JY.Base["畅想"] == 27 then
                    -- instruct_32(349,-1)
                end
                -- 畅想杨过初始化
                if JY.Base["畅想"] == 58 then
                    JY.Scene[19]["进入条件"] = 1
                    JY.Scene[101]["进入条件"] = 1
                    JY.Scene[36]["进入条件"] = 1
                    JY.Scene[28]["进入条件"] = 1
                    JY.Scene[93]["进入条件"] = 1
                    JY.Scene[105]["进入条件"] = 1
                    null(18, 6)
                    null(70, 87)
                    addevent(70, 95, 0, 4188, 3, 0)
                end
                -- 初始独孤
                if JY.Base["畅想"] == 592 then
                    JY.Person[0]["武功2"] = 0
                    JY.Person[0]["武功等级2"] = 0
                    JY.Person[0]["耍刀技巧"] = 30 + zm
                    JY.Person[0]["特殊兵器"] = 30 + zm
                    JY.Person[0]["指法技巧"] = 30 + zm
                    JY.Person[0]["拳掌功夫"] = 30 + zm
                end

                if JY.Base["畅想"] == 721 then
                    JY.Person[0]["耍刀技巧"] = 50
                    JY.Person[0]["特殊兵器"] = 50
                    JY.Person[0]["指法技巧"] = 50
                    JY.Person[0]["拳掌功夫"] = 50
                    JY.Person[0]["暗器技巧"] = 200
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
                local tsbx, tsby = bx * 1225, by * 195 -- 初始坐标
                if i > 7 then
                    tsbx, tsby = bx * 75, by * 195 -- 初始坐标
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
                    local zm = JY.Base["周目"]
                    local nd = JY.Base["难度"]
                    local addkfnum
                    JY.Base["畅想"] = menu2[tb][rw + rw1]
                    local clone_choice = JY.Base["畅想"]
                    JY.Person[0]["代号"] = JY.Person[clone_choice]["代号"]
                    JY.Person[0]["头像代号"] = JY.Person[clone_choice]["头像代号"]
                    JY.Person[0]["半身像"] = JY.Person[clone_choice]["半身像"]
                    JY.Person[0]["体质"] = JY.Person[clone_choice]["体质"]
                    if JY.Person[0]["体质"] < 5 then
                        JY.Person[0]["体质"] = 5
                    end
                    if JY.Person[0]["体质"] > 12 then
                        JY.Person[0]["体质"] = 12
                    end
                    JY.Person[0]["姓名"] = JY.Person[clone_choice]["姓名"]
                    JY.Person[0]["外号"] = JY.Person[clone_choice]["外号"]
                    JY.Person[0]["性别"] = JY.Person[clone_choice]["性别"]

                    JY.Person[0]["武器"] = -1
                    JY.Person[0]["防具"] = -1
                    JY.Person[0]["坐骑"] = -1
                    for i = 1, 2 do
                        JY.Person[0]["武功" .. i] = JY.Person[clone_choice]["武功" .. i]
                        JY.Person[0]["武功等级" .. i] = JY.Person[clone_choice]["武功等级" .. i]
                    end
                    CC.kaijuwugong1 = JY.Person[0]["武功1"]
                    CC.kaijuwugong2 = JY.Person[0]["武功2"]
                    CC.kaijuwugong3 = JY.Person[0]["武功3"]
                    CC.kaijuwugongx1 = JY.Person[0]["武功等级1"]
                    CC.kaijuwugongx2 = JY.Person[0]["武功等级2"]
                    CC.kaijuwugongx3 = JY.Person[0]["武功等级3"]
                    for i = 1, 5 do
                        JY.Person[0]["出招动画帧数" .. i] = JY.Person[clone_choice]["出招动画帧数" .. i]
                        JY.Person[0]["出招动画延迟" .. i] = JY.Person[clone_choice]["出招动画延迟" .. i]
                        JY.Person[0]["武功音效延迟" .. i] = JY.Person[clone_choice]["武功音效延迟" .. i]
                    end
                    -- 畅想攻防轻最低55
                    JY.Person[0]["攻击力"] = limitX(JY.Person[clone_choice]["攻击力"] / 4, 55, 75)
                    JY.Person[0]["防御力"] = limitX(JY.Person[clone_choice]["防御力"] / 4, 55, 75)
                    JY.Person[0]["轻功"] = limitX(JY.Person[clone_choice]["轻功"] / 4, 55, 75)
                    -- 医疗用毒解毒最低30
                    JY.Person[0]["医疗能力"] = limitX(JY.Person[clone_choice]["医疗能力"], 30)
                    JY.Person[0]["用毒能力"] = limitX(JY.Person[clone_choice]["用毒能力"], 30)
                    JY.Person[0]["解毒能力"] = limitX(JY.Person[clone_choice]["解毒能力"], 30)
                    JY.Person[0]["暗器技巧"] = limitX(JY.Person[clone_choice]["暗器技巧"], 30) + zm
                    JY.Person[0]["抗毒能力"] = JY.Person[clone_choice]["抗毒能力"]
                    JY.Person[0]["主运内功"] = 0
                    JY.Person[0]["主运轻功"] = 0
                    JY.Person[0]["个人觉醒"] = 0
                    if CC.PersonExit[clone_choice] ~= nil then
                        JY.Person[0]["拳掌功夫"] = limitX(JY.Person[clone_choice]["拳掌功夫"], 30, 70) + zm
                        JY.Person[0]["指法技巧"] = limitX(JY.Person[clone_choice]["指法技巧"], 30, 70) + zm
                        JY.Person[0]["御剑能力"] = limitX(JY.Person[clone_choice]["御剑能力"], 30, 70) + zm
                        JY.Person[0]["耍刀技巧"] = limitX(JY.Person[clone_choice]["耍刀技巧"], 30, 70) + zm
                        JY.Person[0]["特殊兵器"] = limitX(JY.Person[clone_choice]["特殊兵器"], 30, 70) + zm
                    else
                        JY.Person[0]["拳掌功夫"] = limitX(JY.Person[clone_choice]["拳掌功夫"] / 3, 30, 70) + zm
                        JY.Person[0]["指法技巧"] = limitX(JY.Person[clone_choice]["指法技巧"] / 3, 30, 70) + zm
                        JY.Person[0]["御剑能力"] = limitX(JY.Person[clone_choice]["御剑能力"] / 3, 30, 70) + zm
                        JY.Person[0]["耍刀技巧"] = limitX(JY.Person[clone_choice]["耍刀技巧"] / 3, 30, 70) + zm
                        JY.Person[0]["特殊兵器"] = limitX(JY.Person[clone_choice]["特殊兵器"] / 3, 30, 70) + zm
                    end
                    JY.Person[0]["武学常识"] = JY.Person[clone_choice]["武学常识"]
                    JY.Person[0]["攻击带毒"] = JY.Person[clone_choice]["攻击带毒"]
                    for i = 1, 5 do
                        JY.Person[0]["秘技" .. i] = JY.Person[clone_choice]["秘技" .. i]
                    end
                    for i = 1, 4 do
                        JY.Person[0]["携带物品" .. i] = JY.Person[clone_choice]["携带物品" .. i]
                        JY.Person[0]["携带物品数量" .. i] = JY.Person[clone_choice]["携带物品数量" .. i]
                    end

                    for i = 1, 2 do
                        JY.Person[0]["天赋外功" .. i] = JY.Person[clone_choice]["天赋外功" .. i]
                    end
                    JY.Person[0]["天赋内功"] = JY.Person[clone_choice]["天赋内功"]
                    JY.Person[0]["天赋轻功"] = JY.Person[clone_choice]["天赋轻功"]
                    JY.Person[0]["畅想分阶"] = JY.Person[clone_choice]["畅想分阶"]
                    JY.Person[0]["外号2"] = JY.Person[clone_choice]["外号2"]
                    JY.Person[0]["特色指令"] = JY.Person[clone_choice]["特色指令"]
                    JY.Person[0]["拳法成长"] = JY.Person[clone_choice]["拳法成长"]
                    JY.Person[0]["指法成长"] = JY.Person[clone_choice]["指法成长"]
                    JY.Person[0]["剑法成长"] = JY.Person[clone_choice]["剑法成长"]
                    JY.Person[0]["刀法成长"] = JY.Person[clone_choice]["刀法成长"]
                    JY.Person[0]["奇门成长"] = JY.Person[clone_choice]["奇门成长"]
                    for i = 1, 5 do
                        JY.Person[0]['天赋' .. i] = JY.Person[clone_choice]['天赋' .. i]
                        -- lib.Debug(i..'畅想主角天赋 = '..JY.Person[0]['天赋'..i])
                    end
                    -- 畅想裘千尺头像变美
                    if JY.Base["畅想"] == 617 then
                        JY.Person[0]["头像代号"] = 353
                        JY.Person[0]["半身像"] = 353
                        JY.Person[0]["出招动画帧数3"] = 24
                        JY.Person[0]["出招动画延迟3"] = 22
                        JY.Person[0]["武功音效延迟3"] = 22
                    end
                    -- 东方不败初骀
                    if JY.Base["畅想"] == 27 then
                        -- instruct_32(349,-1)
                    end
                    -- 畅想杨过初始化
                    if JY.Base["畅想"] == 58 then
                        JY.Scene[19]["进入条件"] = 1
                        JY.Scene[101]["进入条件"] = 1
                        JY.Scene[36]["进入条件"] = 1
                        JY.Scene[28]["进入条件"] = 1
                        JY.Scene[93]["进入条件"] = 1
                        JY.Scene[105]["进入条件"] = 1
                        null(18, 6)
                        null(70, 87)
                        addevent(70, 95, 0, 4188, 3, 0)
                    end
                    -- 初始独孤
                    if JY.Base["畅想"] == 592 then
                        JY.Person[0]["武功2"] = 0
                        JY.Person[0]["武功等级2"] = 0
                        JY.Person[0]["耍刀技巧"] = 30 + zm
                        JY.Person[0]["特殊兵器"] = 30 + zm
                        JY.Person[0]["指法技巧"] = 30 + zm
                        JY.Person[0]["拳掌功夫"] = 30 + zm
                    end
                    if JY.Base["畅想"] == 721 then
                        JY.Person[0]["耍刀技巧"] = 50
                        JY.Person[0]["特殊兵器"] = 50
                        JY.Person[0]["指法技巧"] = 50
                        JY.Person[0]["拳掌功夫"] = 50
                        JY.Person[0]["暗器技巧"] = 200
                    end
                    Hp_Max(0)
                    Mp_Max(0)
                    break
                end
            end
        end
    end
end

-- 老顾特殊人物
function TSzjmenu()
    local bx, by = CC.WX, CC.HY
    local size = CC.DefaultFont
    local menu2 =
        {{752, 497, 578, 579, 652, 500, 498, 637, 577, 635, 501, 596, 504, 505, 507, 721, 546, 610, 514, 515} -- 特殊
        }
    local tb = 1
    local lb = 1
    local rw, rw1 = 1, 0
    local dh = 0
    local fy, fymax, star = 0, 0, 1
    -- 畅想
    local cx, ts, zj, xb = 0, 0, 0, 0
    local tbx, tby = bx * 1225, by * 195
    local tsw, tsh = bx * 54, by * 45
    while true do
        if JY.Restart == 1 then
            break
        end
        -- 清除画面，因为菜单是无限循环的状态，所以显示画面前，需要清除之前的画面，否则贴图无限叠加
        ClsN()
        ---------------
        lib.LoadPNG(91, 24 * 2, -1, -1, 1)
        lib.LoadPNG(91, 25 * 2, -1, -1, 1)
        lib.LoadPNG(91, 26 * 2, -1, -1, 1)
        local function inmenu()
            local zm = JY.Base["周目"]
            local nd = JY.Base["难度"]
            local addkfnum

            local clone_choice = JY.Base["畅想"]
            JY.Person[0]["代号"] = JY.Person[clone_choice]["代号"]
            JY.Person[0]["头像代号"] = JY.Person[clone_choice]["头像代号"]
            JY.Person[0]["半身像"] = JY.Person[clone_choice]["半身像"]
            JY.Person[0]["体质"] = JY.Person[clone_choice]["体质"]
            if JY.Person[0]["体质"] < 5 then
                JY.Person[0]["体质"] = 5
            end
            if JY.Person[0]["体质"] > 12 then
                JY.Person[0]["体质"] = 12
            end
            JY.Person[0]["姓名"] = JY.Person[clone_choice]["姓名"]
            JY.Person[0]["外号"] = JY.Person[clone_choice]["外号"]
            JY.Person[0]["性别"] = JY.Person[clone_choice]["性别"]

            JY.Person[0]["武器"] = -1
            JY.Person[0]["防具"] = -1
            JY.Person[0]["坐骑"] = -1
            for i = 1, 2 do
                JY.Person[0]["武功" .. i] = JY.Person[clone_choice]["武功" .. i]
                JY.Person[0]["武功等级" .. i] = JY.Person[clone_choice]["武功等级" .. i]
            end
            CC.kaijuwugong1 = JY.Person[0]["武功1"]
            CC.kaijuwugong2 = JY.Person[0]["武功2"]
            CC.kaijuwugong3 = JY.Person[0]["武功3"]
            CC.kaijuwugongx1 = JY.Person[0]["武功等级1"]
            CC.kaijuwugongx2 = JY.Person[0]["武功等级2"]
            CC.kaijuwugongx3 = JY.Person[0]["武功等级3"]
            for i = 1, 5 do
                JY.Person[0]["出招动画帧数" .. i] = JY.Person[clone_choice]["出招动画帧数" .. i]
                JY.Person[0]["出招动画延迟" .. i] = JY.Person[clone_choice]["出招动画延迟" .. i]
                JY.Person[0]["武功音效延迟" .. i] = JY.Person[clone_choice]["武功音效延迟" .. i]
            end

            -- 畅想攻防轻最低55
            JY.Person[0]["攻击力"] = limitX(JY.Person[clone_choice]["攻击力"] / 4, 55, 75)
            JY.Person[0]["防御力"] = limitX(JY.Person[clone_choice]["防御力"] / 4, 55, 75)
            JY.Person[0]["轻功"] = limitX(JY.Person[clone_choice]["轻功"] / 4, 55, 75)
            -- 医疗用毒解毒最低30
            JY.Person[0]["医疗能力"] = limitX(JY.Person[clone_choice]["医疗能力"], 30)
            JY.Person[0]["用毒能力"] = limitX(JY.Person[clone_choice]["用毒能力"], 30)
            JY.Person[0]["解毒能力"] = limitX(JY.Person[clone_choice]["解毒能力"], 30)
            JY.Person[0]["暗器技巧"] = limitX(JY.Person[clone_choice]["暗器技巧"], 30) + zm
            JY.Person[0]["抗毒能力"] = JY.Person[clone_choice]["抗毒能力"]
            JY.Person[0]["主运内功"] = 0
            JY.Person[0]["主运轻功"] = 0
            JY.Person[0]["个人觉醒"] = 0
            JY.Person[0]["优先使用"] = 0

            if CC.PersonExit[clone_choice] ~= nil then

                JY.Person[0]["拳掌功夫"] = limitX(JY.Person[clone_choice]["拳掌功夫"], 30, 70) + zm
                JY.Person[0]["指法技巧"] = limitX(JY.Person[clone_choice]["指法技巧"], 30, 70) + zm
                JY.Person[0]["御剑能力"] = limitX(JY.Person[clone_choice]["御剑能力"], 30, 70) + zm
                JY.Person[0]["耍刀技巧"] = limitX(JY.Person[clone_choice]["耍刀技巧"], 30, 70) + zm
                JY.Person[0]["特殊兵器"] = limitX(JY.Person[clone_choice]["特殊兵器"], 30, 70) + zm
            else

                JY.Person[0]["拳掌功夫"] = limitX(JY.Person[clone_choice]["拳掌功夫"] / 3, 30, 70) + zm
                JY.Person[0]["指法技巧"] = limitX(JY.Person[clone_choice]["指法技巧"] / 3, 30, 70) + zm
                JY.Person[0]["御剑能力"] = limitX(JY.Person[clone_choice]["御剑能力"] / 3, 30, 70) + zm
                JY.Person[0]["耍刀技巧"] = limitX(JY.Person[clone_choice]["耍刀技巧"] / 3, 30, 70) + zm
                JY.Person[0]["特殊兵器"] = limitX(JY.Person[clone_choice]["特殊兵器"] / 3, 30, 70) + zm
            end

            JY.Person[0]["武学常识"] = JY.Person[clone_choice]["武学常识"]
            JY.Person[0]["攻击带毒"] = JY.Person[clone_choice]["攻击带毒"]
            for i = 1, 5 do
                JY.Person[0]["秘技" .. i] = JY.Person[clone_choice]["秘技" .. i]
            end

            for i = 1, 4 do
                JY.Person[0]["携带物品" .. i] = JY.Person[clone_choice]["携带物品" .. i]
                JY.Person[0]["携带物品数量" .. i] = JY.Person[clone_choice]["携带物品数量" .. i]
            end

            for i = 1, 2 do
                JY.Person[0]["天赋外功" .. i] = JY.Person[clone_choice]["天赋外功" .. i]
            end

            JY.Person[0]["天赋内功"] = JY.Person[clone_choice]["天赋内功"]
            JY.Person[0]["天赋轻功"] = JY.Person[clone_choice]["天赋轻功"]
            JY.Person[0]["畅想分阶"] = JY.Person[clone_choice]["畅想分阶"]
            JY.Person[0]["外号2"] = JY.Person[clone_choice]["外号2"]
            JY.Person[0]["特色指令"] = JY.Person[clone_choice]["特色指令"]
            JY.Person[0]["拳法成长"] = JY.Person[clone_choice]["拳法成长"]
            JY.Person[0]["指法成长"] = JY.Person[clone_choice]["指法成长"]
            JY.Person[0]["剑法成长"] = JY.Person[clone_choice]["剑法成长"]
            JY.Person[0]["刀法成长"] = JY.Person[clone_choice]["刀法成长"]
            JY.Person[0]["奇门成长"] = JY.Person[clone_choice]["奇门成长"]
            for i = 1, 5 do
                JY.Person[0]['天赋' .. i] = JY.Person[clone_choice]['天赋' .. i]
                -- lib.Debug(i..'畅想主角天赋 = '..JY.Person[0]['天赋'..i])
            end
            -- 畅想裘千尺头像变美
            if JY.Base["畅想"] == 617 then
                JY.Person[0]["头像代号"] = 353
                JY.Person[0]["半身像"] = 353
                JY.Person[0]["出招动画帧数3"] = 24
                JY.Person[0]["出招动画延迟3"] = 22
                JY.Person[0]["武功音效延迟3"] = 22
            end
            -- 东方不败初骀
            if JY.Base["畅想"] == 27 then
                -- instruct_32(349,-1)
            end
            -- 畅想杨过初始化
            if JY.Base["畅想"] == 58 then
                JY.Scene[19]["进入条件"] = 1
                JY.Scene[101]["进入条件"] = 1
                JY.Scene[36]["进入条件"] = 1
                JY.Scene[28]["进入条件"] = 1
                JY.Scene[93]["进入条件"] = 1
                JY.Scene[105]["进入条件"] = 1
                null(18, 6)
                null(70, 87)
                addevent(70, 95, 0, 4188, 3, 0)
            end
            -- 初始独孤
            if JY.Base["畅想"] == 592 then
                JY.Person[0]["武功2"] = 0
                JY.Person[0]["武功等级2"] = 0
                JY.Person[0]["耍刀技巧"] = 30 + zm
                JY.Person[0]["特殊兵器"] = 30 + zm
                JY.Person[0]["指法技巧"] = 30 + zm
                JY.Person[0]["拳掌功夫"] = 30 + zm
            end

            if JY.Base["畅想"] == 721 then
                JY.Person[0]["耍刀技巧"] = 50
                JY.Person[0]["特殊兵器"] = 50
                JY.Person[0]["指法技巧"] = 50
                JY.Person[0]["拳掌功夫"] = 50
                JY.Person[0]["暗器技巧"] = 200
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
                    local pic = JY.Person[id]["半身像"]
                    local name = JY.Person[id]["姓名"]
                    local rwx, rwy = bx * 276, by * 165
                    local rww, rwh = bx * 140, by * 110
                    if rw == i then
                        lib.LoadPNG(90, pic * 2, bx * 276, by * 410, 1, 0, 90)
                        lib.LoadPNG(91, 12 * 2, rwx + (rw - 1) * rww - bx * 5, rwy - by * 10, 1, 0, 116)
                        cl = C_RED
                        local zs = 0
                        local dl = 0
                        for j = 1, 5 do
                            if JY.Person[id]['出招动画帧数' .. j] > 0 then
                                if j > 1 then
                                    zs = JY.Person[id]['出招动画帧数' .. j]
                                    break
                                end
                                dl = dl + JY.Person[id]['出招动画帧数' .. j] * 4
                            end
                        end
                        lib.PicLoadCache(JY.Person[id]["头像代号"] + 101, (dl + dh + zs * 3) * 2, bx * 290, by * 700)
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
                                    me[#me + 1] = "Ｎ"
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
                            if JY.Person[id]['天赋' .. i] > 0 then
                                local tf = JY.Person[id]['天赋' .. i]
                                if CC.PTFSM[tf] ~= nil then
                                    me[#me + 1] = 'Ｌ' .. CC.PTFSM[tf][1]
                                    me[#me + 1] = 'Ｗ' .. CC.PTFSM[tf][2]
                                    me[#me + 1] = "Ｎ"
                                end
                            end
                        end
                        for i = 1, #ZJZSJS do
                            me[#me + 1] = ZJZSJS[i]
                            if i == #ZJZSJS then
                                me[#me + 1] = "Ｎ"
                            end
                        end
                        for i = star, #me do
                            local tfstr = me[i]
                            local h = 0

                            if string.sub(tfstr, 1, 2) == "Ｎ" then
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
        -- 显示画面
        ShowScreen()
        -- 循环的间隔（数值随意）
        lib.Delay(CC.Frame)
        -- X是键盘操作，ktype是鼠标操作，ktype = 3 代表左键，4代表右键，6滚轮上，7滚轮下
        local X, ktype, mx, my = lib.GetKey()
        if X == VK_ESCAPE or ktype == 4 then
            if lb == 1 then
                return Moshixz()
                -- break
            end
        elseif X == VK_SPACE or X == VK_RETURN then
            if lb == 1 then
                JY.Base["畅想"] = menu2[tb][rw + rw1]
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
                    JY.Base["畅想"] = menu2[tb][rw + rw1]
                    inmenu()
                    break
                end
            end
        end
        if YC.ZJH == 6 then
            cx = 757
            JY.Base["畅想"] = 757
            YC.ZJH = 0
            inmenu()
            break
        end
        if YC.GXZ == 11 then
            cx = 752
            JY.Base["畅想"] = 752
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
    T2["Ｒ"] = PinkRed
    T2["Ｌ"] = LimeGreen
    T2["Ｂ"] = C_BLACK
    T2["Ｗ"] = C_WHITE
    T2["Ｏ"] = C_ORANGE
    T2["Ｄ"] = M_DeepSkyBlue
    T2["Ｚ"] = Violet
    T2['Ｇ'] = C_GOLD
    T2['Ｈ'] = RGB(188, 189, 171)
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
        if string.byte(try) > 127 then -- 中文
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
            if s == 'Ｎ' or s == '*' then
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
                -- 字体结束不再进入下一行
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

    --游历日志
    CC.TJMSJ[#CC.TJMSJ + 1] = #CC.JHtxt
    CC.TJM = CC.TJM + 1
    for i = 1, #CC.JHtxt do
        CC.TJMSJ[#CC.TJMSJ + 1] = CC.JHtxt[i]
        CC.TJM = CC.TJM + 1
    end


    --游历人物
    CC.TJMSJ[#CC.TJMSJ + 1] = #CC.JHtxt_ID
    CC.TJM = CC.TJM + 1
    for i = 1, #CC.JHtxt_ID do
        CC.TJMSJ[#CC.TJMSJ + 1] = CC.JHtxt_ID[i]
        CC.TJM = CC.TJM + 1
    end

    --游历场景
    CC.TJMSJ[#CC.TJMSJ + 1] = #CC.JHtxt_SCENE
    CC.TJM = CC.TJM + 1
    for i = 1, #CC.JHtxt_SCENE do
        CC.TJMSJ[#CC.TJMSJ + 1] = CC.JHtxt_SCENE[i]
        CC.TJM = CC.TJM + 1
    end

    --游历交互人物
    CC.TJMSJ[#CC.TJMSJ + 1] = #CC.JHtxt_ID1
    CC.TJM = CC.TJM + 1
    for i = 1, #CC.JHtxt_ID1 do
        CC.TJMSJ[#CC.TJMSJ + 1] = CC.JHtxt_ID1[i]
        CC.TJM = CC.TJM + 1
    end

    --游历增加的属性类型
    CC.TJMSJ[#CC.TJMSJ + 1] = #CC.JHtxt_PSX
    CC.TJM = CC.TJM + 1
    for i = 1, #CC.JHtxt_PSX do
        CC.TJMSJ[#CC.TJMSJ + 1] = CC.JHtxt_PSX[i]
        CC.TJM = CC.TJM + 1
    end

    --游历增加属性的点数
    CC.TJMSJ[#CC.TJMSJ + 1] = #CC.JHtxt_POINTS
    CC.TJM = CC.TJM + 1
    for i = 1, #CC.JHtxt_POINTS do
        CC.TJMSJ[#CC.TJMSJ + 1] = CC.JHtxt_POINTS[i]
        CC.TJM = CC.TJM + 1
    end

    --游历年
    CC.TJMSJ[#CC.TJMSJ + 1] = #CC.JHtxt_YEAR
    CC.TJM = CC.TJM + 1
    for i = 1, #CC.JHtxt_YEAR do
        CC.TJMSJ[#CC.TJMSJ + 1] = CC.JHtxt_YEAR[i]
        CC.TJM = CC.TJM + 1
    end

    --游历月
    CC.TJMSJ[#CC.TJMSJ + 1] = #CC.JHtxt_MONTH
    CC.TJM = CC.TJM + 1
    for i = 1, #CC.JHtxt_MONTH do
        CC.TJMSJ[#CC.TJMSJ + 1] = CC.JHtxt_MONTH[i]
        CC.TJM = CC.TJM + 1
    end

    --游历日
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

    CC.Sp = JY.Base["碎片"]
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

    -- Cat时间计时
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

        -- Cat时间计时
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
        -- 存特效
        for i = 1, #CC.TXM do
            CC.TX[CC.TXM[i]] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end

        -- 存天关
        local tg = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1

        for i = 1, tg do
            local v = CC.TJMSJ[CC.TJM]
            CC.TG[v] = 1
            CC.TJM = CC.TJM + 1
        end

        -- 江湖游历
        local yl = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, yl do
            CC.JHtxt[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end
        -- 江湖游历人物
        local ylID = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, ylID do
            CC.JHtxt_ID[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end

        -- 游历场景
        local SCENE = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, SCENE do
            CC.JHtxt_SCENE[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end

         -- 游历交互人物
        local ID1 = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, ID1 do
            CC.JHtxt_ID1[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end

        -- 游历增加的属性类型
        local PSX = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, PSX do
            CC.JHtxt_PSX[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end

        -- 游历增加属性的点数
        local POINTS = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, POINTS do
            CC.JHtxt_POINTS[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end

        -- 游历年
        local YLYEAR = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, YLYEAR do
            CC.JHtxt_YEAR[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end

        -- 游历月
        local YLMOTH = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, YLMOTH do
            CC.JHtxt_MONTH[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end

        -- 游历日
        local YLDAY = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, YLDAY do
            CC.JHtxt_DAY[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end        

        -- 天关奖励
        local tgjl = CC.TJMSJ[CC.TJM]
        CC.TJM = CC.TJM + 1
        for i = 1, tgjl do
            CC.TGJL[i] = CC.TJMSJ[CC.TJM]
            CC.TJM = CC.TJM + 1
        end

        -- 奖励物品
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

        CC.Sp = JY.Base["碎片"]
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



-- 设置天赋，n == 1表示有，nil表示无
-- 新增天赋用表存起来
-- 新增天赋用表存起来
-- 新增天赋用表存起来
function SetTF(id, tf, n)
    if CC.PTF[id] == nil then
        CC.PTF[id] = {}
    end
    local tf1 = nil
    if n == 1 then
        for i = 1, 5 do
            if PersonTF(id, tf) == false then
                if JY.Person[id]['天赋' .. i] == 0 then
                    JY.Person[id]['天赋' .. i] = tf
                    break
                end
            end
        end
    elseif n == 0 then
        for i = 1, 5 do
            if PersonTF(id, tf) then
                if JY.Person[id]['天赋' .. i] == tf then
                    JY.Person[id]['天赋' .. i] = 0
                    break
                end
            end
        end
    end
end

function ZZQmenu()
    local bx, by = CC.WX, CC.HY
    -- 文字大小
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
    DrawString(x - offx, y - offy, str, M_DeepSkyBlue, size); -- 静夜思
    ShowScreen();
    lib.Delay(1500);
end



function JL() -- 奖励点数
    local xm = {"攻击力", "防御力", "轻功", "拳掌功夫", "御剑能力", "特殊兵器", "耍刀技巧"}
    local sz = {10, 10, 10, 5, 5, 5, 5}
    local jl = math.random(7)
    if GetS(92, 60, 27, 5) == 1 then
        local jl2 = math.random(1, sz[jl])
        JY.Person[0][xm[jl]] = JY.Person[0][xm[jl]] + jl2
        local n = math.random(10)
        if n < 4 then
            local m = math.random(3)
            local mc = {"遥控色子", "免伤卡", "福神卡"}
            if m == 1 then
                JY.Person[318]["医疗能力"] = JY.Person[318]["医疗能力"] + 1
                DrawStrBoxWaitKey(string.format("意外您获得了%s，一张", mc[m]), C_GOLD, CC.DefaultFont);
            elseif m == 2 then
                JY.Person[318]["受伤程度"] = JY.Person[318]["受伤程度"] + 1
                DrawStrBoxWaitKey(string.format("意外您获得了%s，一张", mc[m]), C_GOLD, CC.DefaultFont);
            elseif m == 3 then
                JY.Person[318]["抗毒能力"] = JY.Person[318]["抗毒能力"] + 1
                DrawStrBoxWaitKey(string.format("意外您获得了%s，一张", mc[m]), C_GOLD, CC.DefaultFont);
            end
        end
        DrawStrBoxWaitKey(string.format("您的%s，上升了%d", xm[jl], jl2), C_GOLD, CC.DefaultFont);

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
        lib.Debug('错误：未知函数')
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
    local menu = {'人物', '物品', MJMenu, '设置'}
    local menu2 = {'状态', '排序', '离队'}
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
        local id = JY.Base["物品" .. i + 1]
        if id >= 0 then
            if JY.Thing[id]["类型"] == 2 then
                thing[num] = id
                thingnum[num] = JY.Base["物品数量" .. i + 1]
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
        local id = JY.Base["物品" .. i + 1]
        if id >= 0 then
            if flag == nil then
                if JY.Thing[id]["类型"] ~= 2 then
                    thing[num] = id
                    thingnum[num] = JY.Base["物品数量" .. i + 1]
                    num = num + 1
                end
            else
                if JY.Thing[id]["类型"] == flag then
                    thing[num] = id
                    thingnum[num] = JY.Base["物品数量" .. i + 1]
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
            if JY.Base['队伍' .. ii] >= 0 then
                menu[#menu + 1] = {p[JY.Base['队伍' .. ii]]['姓名'], JY.Base['队伍' .. ii]}
            end
        end
        if maxn > #menu then
            maxn = #menu
        end
        lib.PicLoadCache(92, 9 * 2, zbx1, zby1, 1, nil, nil, bx * 936)

        for ii = 1, maxn do
            local h = 0
            local pyx = 0
            if CC.Png[p[menu[ii + cont1][2]]['半身像']] ~= nil then
                pyx = CC.Png[p[menu[ii + cont1][2]]['半身像']]
            end

            local sm = p[menu[ii + cont1][2]]['生命']
            local smmax = p[menu[ii + cont1][2]]['生命最大值']
            local nl = p[menu[ii + cont1][2]]['内力']
            local nlmax = p[menu[ii + cont1][2]]['内力最大值']
            local tl = p[menu[ii + cont1][2]]['体力']
            local tlmax = 100
            local x1, y1 = lib.GetPNGXY(99, 2 * 2)
            lib.SetClip(bx * 42 + (ii - 1) * bx * 220 + zbx1, 0, bx * 38 + (ii - 1) * bx * 220 + bx * 197 + zbx1, by * 768 + zby1) -- 菜单背景图
            lib.LoadPNG(90, p[menu[ii + cont1][2]]['半身像'] * 2, bx * 138 + (ii - 1) * bx * 220 - bx * pyx + zbx1 - x1 * 4, by * 250 + zby1 - y1 * 4.4, 1)--适配，这里不知道为什么要抵消掉
            lib.SetClip(0, 0, 0, 0)

            lib.PicLoadCache(92, 15 * 2, bx * 138 + (ii - 1) * bx * 220 + zbx1, by * 425 + zby1, 2, 256, nil, bx * 170)

            DrawString(bx * 138 + (ii - 1) * bx * 220 - string.len(menu[ii + cont1][1]) * size / 4 + zbx1, by * 440 + zby1, menu[ii + cont1][1], C_WHITE, size)
            if ii == cont or px == ii then
                lib.PicLoadCache(92, 10 * 2, bx * 138 + (ii - 1) * bx * 220 + zbx1, CC.ScreenH / 2 + zby1, 2, 256, nil, bx * 200) -- 菜单背景图
            end

            h = h + 1

            local tfid = menu[ii + cont1][2]
            if JY.Base['畅想'] > 0 and tfid == 0 then
                tfid = JY.Base['畅想']
            end
            if RWWH[tfid] ~= nil then
                DrawString(bx * 60 + (ii - 1) * bx * 220 + zbx1, by * 440 + h * by * 30 + zby1, '称号：' .. RWWH[tfid], LimeGreen, size)
            end

            h = h + 1

            if RWTFLB[tfid] ~= nil then
                DrawString(bx * 60 + (ii - 1) * bx * 220 + zbx1, by * 440 + h * by * 30 + zby1, '天赋：' .. RWTFLB[tfid], LimeGreen, size)
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
                '命  ' .. p[menu[ii + cont1][2]]['生命'], C_WHITE, size1)
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
                '内  ' .. p[menu[ii + cont1][2]]['内力'], C_WHITE, size1)
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
                '体  ' .. p[menu[ii + cont1][2]]['体力'], C_WHITE, size1)
        end

        ShowScreen()
        lib.Delay(CC.Frame)
        local X, ktype, mx, my = lib.GetKey()
        if X == VK_SPACE or X == VK_RETURN then
            PlayWavE(77)
            tru = cont + cont1
            local id = JY.Base['队伍' .. tru]
            if tab ~= nil then
                if tab[1] == '离队' then
                    if tru > 1 then
                        if JY.SubScene == 55 and JY.Base["队伍" .. tru] == 35 then
                        elseif JY.SubScene == 82 then
                        else
                            local personid = JY.Base["队伍" .. tru]
                            if CC.PersonExit[personid] ~= nil then
                                local v = CC.PersonExit[personid]
                                CallCEvent(v)
                            end
                            cont = 1
                            cont1 = 0
                        end
                    end
                elseif tab[1] == '状态' then
                    ShowPersonStatus(tru)
                elseif tab[1] == '排序' then
                    if px == 0 then
                        if tru > 1 then
                            px = cont
                        end
                    else
                        if tru > 1 then
                            JY.Base['队伍' .. tru] = JY.Base['队伍' .. px + cont1]
                            JY.Base['队伍' .. px + cont1] = id
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
                if tab[1] == '离队' then
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
                local id = JY.Base['队伍' .. tru]
                if tab ~= nil then
                    if tab[1] == '离队' then
                        if tru > 1 then
                            if JY.SubScene == 55 and JY.Base["队伍" .. tru] == 35 then
                            elseif JY.SubScene == 82 then
                            else
                                local personid = JY.Base["队伍" .. tru]
                                if CC.PersonExit[personid] ~= nil then
                                    local v = CC.PersonExit[personid]
                                    CallCEvent(v)
                                end
                                cont = 1
                                cont1 = 0
                            end
                        end
                    elseif tab[1] == '状态' then
                        ShowPersonStatus(tru)
                    elseif tab[1] == '排序' then
                        if px == 0 then
                            if tru > 1 then
                                px = cont
                            end
                        else
                            if tru > 1 then
                                JY.Base['队伍' .. tru] = JY.Base['队伍' .. px + cont1]
                                JY.Base['队伍' .. px + cont1] = id
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
    -- local 秘籍;
    local ng = 0
    --[[
	for i = 1,JY.Base["武功数量"] do
		wugong = p["武功"..i]
		kflvl = p["武功等级" .. i]
		if kflvl >= 1000 then
			level = 11
		else
			level = math.modf(kflvl/100)+1
		end
		if JY.Wugong[wugong]["武功类型"] == 6 then
			ng = ng + 1
		end
		if ng > 3 then
			ng = 3
		end		
	end	
	local num = 0
	for i = 1, JY.Base["武功数量"] do
		if JY.Person[id]["武功" .. i] == 85 or JY.Person[id]["武功" .. i] == 88 then
			num = 1
			break
		end
	end	
	if p["主运内功"] > 0 then
        local zy = p["主运内功"] 
		for j = 0,JY.ThingNum - 1 do
			if JY.Thing[j]["练出武功"] >= 0  then
				if JY.Thing[j]["练出武功"] == zy then
					jnl = level*JY.Thing[j]["加内力最大值"]
					break
				end	
			end
		end
		
        if id == 0 and (JY.Base["标准"] == 6  or  JY.Base["畅想"] == 637 or  JY.Base["畅想"] == 27 or JY.Base["畅想"] == 189 ) then
			for i = 1, JY.Base["武功数量"] do
				for j = 0,JY.ThingNum - 1 do
					if JY.Thing[j]["练出武功"] >= 0  then
						if JY.Thing[j]["练出武功"] == p["武功" .. i] then
							if p["武功" .. i]== p["天赋内功"] then
								jnl1 = level*JY.Thing[j]["加内力最大值"]
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
		p["内力最大值"] = 999 + jnl + (130-p["资质"])*35 + ng*1500 + p['基础内力']
		if match_ID(id, 53) or match_ID(id, 114) or match_ID(id, 38) or match_ID(id, 116)  or match_ID(id, 638) or match_ID(id, 499) or match_ID(id, 9999) then
			p["内力最大值"] = 9999
		end
		if p["内力"] >  p["内力最大值"] then
         	p["内力"] =  p["内力最大值"]
		end
		if JY.Status ~= GAME_WMAP then
			AddPersonAttrib(id,'内力',math.huge)
		else 
			p["内力"] = limitX(p["内力"],0,p["内力最大值"])
		end	
	else
		p["内力最大值"] = 999 + (130-p["资质"])*35 + ng*1500 + p['基础内力']
		if match_ID(id, 53) or match_ID(id, 114) or match_ID(id, 38) or match_ID(id, 116)  or match_ID(id, 638) or match_ID(id, 499) or match_ID(id, 9999) then
			p["内力最大值"] = 9999
		end 
		if JY.Status ~= GAME_WMAP then
			AddPersonAttrib(id,'内力',math.huge)
		else 
			p["内力"] = limitX(p["内力"],0,p["内力最大值"])
		end			
	end
	]]
end

function Hp_Max(id)
    local p = JY.Person[id]
    local kf = 0
    local tfkf = p["天赋内功"]
    local kflvl = 0
    local wgwl = 0
    local wgwl1 = 0
    local wgwl2 = 0
    local lv = 0
    lib.GetKey();
    Cls();
    if p["主运内功"] > 0 then
        kf = p["主运内功"]
        lv = KF_level(id, kf)
        if PersonKF(id, kf) == false then
            lv = 10
        end
        wgwl2 = get_skill_power(id, kf, lv) + JY.Wugong[kf]['层级'] * 100
        if id == 0 and (JY.Base["畅想"] == 637 or JY.Base["畅想"] == 27 or JY.Base["畅想"] == 189) then
            if tfkf > 0 and PersonKF(id, tfkf) then
                wgwl1 = get_skill_power(id, tfkf, KF_level(id, tfkf)) + JY.Wugong[tfkf]['层级'] * 100
                if wgwl2 < wgwl1 then
                    kf = tfkf
                    lv = KF_level(id, tfkf)
                end
            end
        end
        wgwl = get_skill_power(id, kf, lv) + JY.Wugong[kf]["层级"] * 100
        p["生命最大值"] = p["体质"] * 200 + (7 - p["畅想分阶"]) * 400 + p['基础生命'] + wgwl

    else
        p["生命最大值"] = p["体质"] * 200 + (7 - p["畅想分阶"]) * 400 + p['基础生命']
    end

    if p["生命最大值"] > 9999 then
        -- p["生命最大值"] = 9999
    end
    if p["生命"] > p["生命最大值"] then
        p["生命"] = p["生命最大值"]
    end
    if JY.Status ~= GAME_WMAP then
        AddPersonAttrib(id, '生命', math.huge)
    else
        p["生命"] = limitX(p["生命"], 0, p["生命最大值"])
    end
end

function tgsave(flag)

    local tgjl = 0
    local tg = 0
    local tgsize = 0
    if flag == nil then
        if CC.Week < 100 then
            if JY.Base["周目"] == CC.Week then
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
    JY.Base["难度"] = 1
    local m = {{'周目', '商店'}, {'普通', '单通', '娱乐'}, {'简单', '普通', '困难', '地狱'},
               {'姓名'}, {'下一步'}}
    local ax, ay = 210, 35
    local sz = {{582 + ax, 161 + ay, 180}, {556 + ax, 328 + ay, 120}, {518 + ax, 489 + ay, 105},
                {518 + ax, 600 + ay, 0}, {818 + ax, 656 + ay, 0} -- {938+ax,656+ay,0},
    }

    local sm =
        {'Ｗ我方队友可以参加战斗，我方战场上场人物为6人Ｒ【提示：此模式为正常模式，一切以此模式为基准】',
         'Ｗ所有战斗只有主角可以参战Ｒ郑重提示：此模式为自虐模式，若是造成无法游戏的后果，请自行调整模式。附：“此模式尔等无人权，请勿BB”',
         'Ｗ所有战斗只有主角可以参战，但是主角享有队伍里队友的所有天赋Ｒ【提示：此模式为娱乐模式，请勿炫耀】'}
    local zmmax = CC.Week
    local w = math.modf(bx * 350 / size / 0.96)

    while true do
        if JY.Restart == 1 then
            break
        end
        ClsN()
        local name = JY.Person[0]['姓名']
        local zm = JY.Base["周目"] -- 267 443
        local cx, cy = bx * sz[1][1] - bx * 520, by * sz[1][2] + by * 203
        lib.LoadPNG(91, 48 * 2, -1, -1, 1)
        tjm(bx * 166, by * 551, sm[JY.Base["单通"] + 1], C_WHITE, size * 0.96, w, size * 1.6)
        DrawString(cx - string.len(zm) / 4 * size, cy, zm, C_RED, size)
        DrawString(cx - string.len(zmmax) / 4 * size, cy + size * 1.6, zmmax, C_RED, size)
        DrawString(cx - size * 0.9, cy + size * 3.1, m[3][JY.Base["难度"]], C_RED, size)
        DrawString(cx - size * 0.9, cy + size * 4.6, m[2][JY.Base["单通"] + 1], C_RED, size)
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
                    JY.Base["周目"] = InputNum("选择周目", 1, zmmax);
                else
                    ZmShop()
                end
            elseif page == 2 then
                JY.Base["单通"] = tb - 1
            elseif page == 3 then
                JY.Base["难度"] = tb
            elseif page == 4 then
                -- m[4][2] = Shurufa(10, 10)
                JY.Person[0]['姓名'] = InputText(-1,160,M_Wheat,CC.DefaultFont*0.8) --输入法
                if JY.Person[0]['姓名'] == '' then 
                    JY.Person[0]['姓名'] = '无名'
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
                        JY.Base["周目"] = InputNum("选择周目", 1, zmmax);
                    else
                        ZmShop() -- zmStore()
                    end
                elseif page == 2 then
                    JY.Base["单通"] = tb - 1
                elseif page == 3 then
                    JY.Base["难度"] = tb
                elseif page == 4 then
                    -- m[4][2] = Shurufa(10, 10)
                    JY.Person[0]['姓名'] = InputText(CC.ScreenW*1.2,CC.ScreenH*1.6,C_RED,CC.DefaultFont*0.8) --输入法
                    if JY.Person[0]['姓名'] == '' then 
                        JY.Person[0]['姓名'] = '无名'
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
    local m = {{'阴性', '阳性', '调和'}, {'1-30', '31-50', '51-79', '80-100'}, {'带武功', "无武功"},
               {'下一步'}}
    local sz = {{536, 170, 140}, -- {}
    {518, 325, 105}, {584, 473, 178}, {818, 648, 0}}
    local nlsm =
        {'阴性内力在攻击方面得天独厚，时序回血、回体能力突出。*江湖中传说的阴性内功之最莫属九阴神功，高连击，高暴击，高暴击伤害，只要出手必让对手没有还手之力，搭配上逆运真经，先天功，飞天神行等武功让敌人无从防御。*推荐内功：九阴神功／逆运神功／先天功／鲸息功／长生诀。*推荐轻功:蛇行狸翻／梯云纵／飞天神行',
         '阳性内力在防御方面更胜一筹，时序回内、回复冲穴、免疫破绽、连击减伤等能力突出。*江湖中传说的阳性内功之最莫属九阳神功，搭配上瑜伽神功，龙象般若功，金雁功，乾坤大挪移等让防御固若金汤。',
         '调和内力是行走江湖的万金油，少林寺绝学内功《易筋经》易筋煅骨，不但能增加人物三围属性，与罗汉伏魔功、金刚不坏神功一起修炼更有特独妙处。攻击与防御都有不俗表现。'}

    local zzsm = {'特殊武功：太玄神功，左右互搏', '特殊武功：左右互搏',
                  '特殊武学：中庸之道', '特殊武学：太极神功、斗转星移'}
    p["内力性质"] = 0
    local w = math.modf(bx * 333 / size)
    while true do
        if JY.Restart == 1 then
            break
        end
        ClsN()
        local zz = JY.Person[0]["资质"]
        local wg1
        local wg2
        -- JY.Wugong[wugong]["名称"]
        for wg = 1, JY.Base["武功数量"] do
            wg1 = JY.Wugong[JY.Person[0]["武功" .. 1]]["名称"]
            wg2 = JY.Wugong[JY.Person[0]["武功" .. 2]]["名称"]
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
        DrawString(bx * 72 + size * 3, by * 99 + size, "内力性质：", C_WHITE, size)
        DrawString(bx * 70 + size * 5, by * 99 + size, "      " .. m[1][p["内力性质"] + 1], C_RED, size)
        DrawString(bx * 260 + size * 3, by * 97 + size, "资质:", C_WHITE, size)
        DrawString(bx * 260 + size * 3, by * 97 + size, "      " .. zz, C_RED, size)
        n = n + 1

        if page == 1 then
            n = tjm(bx * 148, by * 130 + (n) * size, nlsm[tb], C_WHITE, size, w, size)
        else
            n = tjm(bx * 148, by * 130 + (n) * size, nlsm[p["内力性质"] + 1], C_WHITE, size, w, size)
        end
        n = n + 1
        for i = 1, #zzsm do
            DrawString(bx * 148, by * 130 + (n + i - 1) * size, zzsm[i], M_Wheat, size)
        end
        n = n + 1
        DrawString(bx * 148, by * 150 + (n + 3) * size, "初始武功：", C_RED, size)
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
                p["内力性质"] = tb - 1
            elseif page == 2 then
                if tb == 1 then
                    JY.Person[0]["资质"] = InputNum("输入资质", 1, 30)
                elseif tb == 2 then
                    JY.Person[0]["资质"] = InputNum("输入资质", 31, 50)
                elseif tb == 3 then
                    JY.Person[0]["资质"] = InputNum("输入资质", 51, 79)
                elseif tb == 4 then
                    JY.Person[0]["资质"] = InputNum("输入资质", 80, 100)
                end
            elseif page == 3 then
                if tb == 1 then
                    JY.Person[0]["武功1"] = CC.kaijuwugong1
                    JY.Person[0]["武功2"] = CC.kaijuwugong2
                    JY.Person[0]["武功3"] = CC.kaijuwugong3
                    JY.Person[0]["武功等级1"] = CC.kaijuwugongx1
                    JY.Person[0]["武功等级2"] = CC.kaijuwugongx2
                    JY.Person[0]["武功等级3"] = CC.kaijuwugongx3
                elseif tb == 2 then
                    JY.Person[0]["武功1"] = 0
                    JY.Person[0]["武功2"] = 0
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
                        p["内力性质"] = 0
                    elseif tb == 2 then
                        p["内力性质"] = 1
                    elseif tb == 3 then
                        p["内力性质"] = 2
                    end
                elseif page == 2 then
                    if tb == 1 then
                        p["资质"] = InputNum("输入资质", 1, 30)
                    elseif tb == 2 then
                        p["资质"] = InputNum("输入资质", 31, 50)
                    elseif tb == 3 then
                        p["资质"] = InputNum("输入资质", 51, 79)
                    elseif tb == 4 then
                        p["资质"] = InputNum("输入资质", 80, 100)
                    end
                elseif page == 3 then
                    if tb == 1 then
                        JY.Person[0]["武功1"] = CC.kaijuwugong1
                        JY.Person[0]["武功2"] = CC.kaijuwugong2
                        JY.Person[0]["武功3"] = CC.kaijuwugong3
                        JY.Person[0]["武功等级1"] = CC.kaijuwugongx1
                        JY.Person[0]["武功等级2"] = CC.kaijuwugongx2
                        JY.Person[0]["武功等级3"] = CC.kaijuwugongx3
                    elseif tb == 2 then
                        JY.Person[0]["武功1"] = 0
                        JY.Person[0]["武功2"] = 0
                        JY.Person[0]["武功3"] = 0
                    end
                elseif page == 4 then
                    break
                end
            end
        end
    end
end

function InputText(x,y,color,size,fontname) --新输入法
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
        if JY.Person[i]['姓名'] ~= '备用' and JY.Person[i]['姓名'] ~= '标主占用' and JY.Person[i]['姓名'] ~=
            '门主占用' then
            menu[#menu + 1] = {JY.Person[i]['姓名'], nil, 1, i}
        end
    end
    CC.HSLJ = {}
    while #CC.HSLJ < 50 do
        if JY.Restart == 1 then
            break
        end
        Cls()
        local r = ShowMenu4(menu, #menu, 8, -2, -2, -2, -2, 1, 1, CC.DefaultFont * 0.9, C_GOLD, C_WHITE, "A请选择想要上场人物" .. #CC.HSLJ, C_ORANGE, C_WHITE, 15)
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
            "B请选择想要上场人物" .. #CC.HSLJ2, C_ORANGE, C_WHITE, 15)
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

-- 进练功房
function LianGong(lx)
    JY.Person[591]["等级"] = 1
    JY.Person[591]["内力性质"] = lx
    local id = math.random(190)
    JY.Person[591]["头像代号"] = JY.Person[id]["头像代号"]
    for i = 1, 5 do
        JY.Person[591]["出招动画帧数" .. i] = JY.Person[id]["出招动画帧数" .. i]
        JY.Person[591]["出招动画延迟" .. i] = JY.Person[id]["出招动画延迟" .. i]
        JY.Person[591]["武功音效延迟" .. i] = JY.Person[id]["武功音效延迟" .. i]
    end
    JY.Person[591]["半身像"] = JY.Person[id]["半身像"]
    JY.Person[591]["生命最大值"] = 9999
    JY.Person[591]["生命"] = 9999
    JY.Person[591]["内力"] = 0
    JY.Person[591]["防御力"] = 0
    JY.Person[591]["御剑能力"] = 0
    JY.Person[591]["指法技巧"] = 0
    JY.Person[591]["拳掌功夫"] = 0
    JY.Person[591]["耍刀技巧"] = 0
    JY.Person[591]["特殊兵器"] = 0
    JY.Person[591]["武学常识"] = 0
    instruct_6(226, 8, 0, 1)
    JY.Person[591]["内力性质"] = 0
    light()
    -- return 1;
end

-- 武功特效说明
function WuGongIntruce()
    local menu = {};

    for i = 1, JY.WugongNum - 1 do
        menu[i] = {i .. JY.Wugong[i]["名称"], nil, 0}
    end

    -- 拥有的秘籍
    for i = 1, CC.MyThingNum do
        if JY.Base["物品" .. i] > -1 and JY.Base["物品数量" .. i] > 0 then
            local wg = JY.Thing[JY.Base["物品" .. i]]["练出武功"];
            if wg > 0 then
                menu[wg][3] = 1;
            end
        else
            break
        end
    end

    -- 学会的武功
    for i = 1, CC.TeamNum do
        if JY.Base["队伍" .. i] >= 0 then
            for j = 1, 10 do
                if JY.Person[JY.Base["队伍" .. i]]["武功" .. j] > 0 then
                    menu[JY.Person[JY.Base["队伍" .. i]]["武功" .. j]][3] = 1;
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
            0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE, "请选择查看的武功", r);
        -- local r = ShowMenu(menu,n,15,CC.ScreenW/4,20,0,0,1,1,CC.DefaultFont,C_ORANGE, C_WHITE);

        if r > 0 and r < JY.WugongNum then
            InstruceWuGong(r);
        else
            break
        end
    end

end

-- 显示武功或内功特效
function InstruceWuGong(id)
    if id < 0 or id >= JY.WugongNum then
        QZXS("武功未知错误，无法查看");
        return;
    end
    local filename = string.format("%s%d.txt", CONFIG.WuGongPath, id)
    if existFile(filename) == false then
        QZXS("此武功未包含任何说明，请自行琢磨");
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

-- 显示武功或内功特效
function InstruceTS(id)

    local filename = string.format("%s%d.txt", CONFIG.HelpPath, id)
    if existFile(filename) == false then
        QZXS("未找到相关的攻略文件");
        return;
    end

    DrawTxt(filename);
end

function DrawTxt(filename)
    Cls();

    -- 读取文件说明
    local file = io.open(filename, "r")
    local str = file:read("*a")
    file:close()

    local size = CC.DefaultFont;
    local color = C_WHITE;

    local linenum = 50; -- 显示长度
    local maxlen = 14;
    local w = linenum * size / 2 + size;
    local h = maxlen * (size + CC.RowPixel) + 2 * CC.RowPixel;

    local bx = (CC.ScreenW - w) / 2;
    local by = (CC.ScreenH - h) / 2;
    DrawBox(bx, by, bx + w, by + h, C_WHITE); -- 底边框
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

            if l + #v[1] < linenum and index == nil then -- 如果未到换行，没有找到换行
                DrawString(x + l * size / 2, y + row * (size + CC.RowPixel), v[1], v[2] or color, size);
                l = l + #v[1]

                if i == #strcolor then
                    -- 显示文字	ALungky:j 改成 j+1解决了末尾文字有时候无法显示的问题。
                    for j = 0, l do
                        lib.SetClip(x, y, x + (j + 1) * size / 2, y + size + row * (size + CC.RowPixel));
                        ShowScreen(1);
                    end
                    lib.SetClip(0, 0, 0, 0);
                end
                break
            else -- 如果达到换行
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

                -- 这个用于判断是否已经到达v[1]的最后内容部分
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

                    if math.fmod(flag, 2) == 1 and index == nil then -- 如果包含有单字符
                        if string.byte(tmp, -1) > 127 then
                            tmp = string.sub(v[1], 1, pos1 - 1);
                            pos2 = pos2 - 1
                        end
                    end

                    v[1] = string.sub(v[1], pos2);
                end

                DrawString(x + l * size / 2, y + row * (size + CC.RowPixel), tmp, v[2] or color, size);

                l = l + #tmp
                -- 显示文字
                for j = 0, l do
                    lib.SetClip(x, y, x + j * size / 2, y + size + row * (size + CC.RowPixel));
                    ShowScreen(1);
                end

                -- 行数+1
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

-- 胡斐 苗人凤教苗家剑法
function NEvent3(keypress)
    if JY.SubScene == 24 and JY.Base["人X1"] == 18 and JY.Base["人Y1"] == 23 and JY.Base["人方向"] == 2 and
        (keypress == VK_SPACE or keypress == VK_RETURN) and GetS(10, 0, 3, 0) ~= 1 and instruct_16(1) and
        instruct_18(145) then
        say("１苗大侠，我已经找到雪山飞狐这本书了。", 1, 0)
        say(
            "１嗯，很好！看来你的胡家刀法也已练得炉火纯青了，以后的江湖就看你们这些年轻人的了！这本苗家剑法你拿去吧！",
            3, 4)
        say("１多谢苗大侠！", 1, 0)
        instruct_35(1, 1, 44, 0)
        DrawStrBox(-1, -1, "胡斐学会苗家剑法", C_ORANGE, CC.DefaultFont)
        ShowScreen()
        lib.Delay(800)
        Cls()
        instruct_2(117, 1)
        SetS(10, 0, 3, 0, 1)
    end
end

-- 令狐冲变身
function NEvent4(keypress)
    if JY.SubScene == 7 and JY.Base["人X1"] == 34 and JY.Base["人Y1"] == 11 and JY.Base["人方向"] == 2 then
        -- 令狐冲在队，有九剑秘籍
        if instruct_16(35) and instruct_18(114) and GetS(10, 1, 1, 0) ~= 1 and
            (keypress == VK_SPACE or keypress == VK_RETURN) then
            SetS(7, 34, 12, 3, 102)
            instruct_3(7, 102, 1, 0, 0, 0, 0, 7148, 7148, 7148, 0, 34, 12)
            say(
                "１雕兄－－，真想见识一下独孤前辈的风采啊！最近总感觉到对九剑有了新的领悟，但又很模糊，不能具体总结出来！",
                35, 1)
            say("１哈哈－－－－，是时候了！", 140, 0)
            say("１风太师叔！！！", 35, 1)
            instruct_14()
            SetS(7, 33, 12, 3, 101)
            instruct_3(7, 101, 1, 0, 0, 0, 0, 5896, 5896, 5896, 0, 33, 12)
            instruct_13()
            PlayMIDI(24)
            lib.Delay(500)
            say(
                "１冲儿，跟我一起唱：沧海一声笑　滔滔两岸潮　浮沉随浪只记今朝　苍天笑　纷纷世上潮　谁负谁胜出天知晓　江山笑　烟雨遥　涛浪淘尽红尘俗事知多少　清风笑竟惹寂寥　豪情还剩一襟晚照　苍生笑　不再寂寥　豪情仍在痴痴笑笑",
                140, 0)
            say(
                "１冲儿，九剑的极意就隐藏在这首歌中，自已好好去体会吧！老夫心愿已了，从此再无牵挂，就此去也，哈哈－－－－",
                140, 0)
            say(
                "１多谢太师叔传剑，你老人家多保重！嗯，就在这里参悟九剑的奥义吧－－－－",
                35, 1)
            instruct_14()
            instruct_3(7, 101, 0, 0, 0, 0, 0, -1, -1, -1, 0, 33, 12)
            instruct_13()
            DrawStrBox(-1, -1, "三日后", C_ORANGE, CC.DefaultFont)
            ShowScreen()
            lib.Delay(500)
            say(
                "１成了！这才是真正的独孤九剑啊！此生有幸能学到独孤前辈之神技，夫复何憾！",
                35, 1)
            DrawStrBox(-1, -1, "令狐冲领悟九剑之秘传", C_ORANGE, CC.DefaultFont)
            ShowScreen()
            lib.Delay(500)
            Cls()
            awakening(35, 2) -- 令狐冲第二次觉醒
            DrawStrBox(-1, -1, "令狐冲称号变改", C_ORANGE, CC.DefaultFont)
            ShowScreen()
            lib.Delay(500)
            Cls()
            SetS(10, 1, 1, 0, 1)
            instruct_3(7, 102, 0, 0, 0, 0, 0, -1, -1, -1, 0, 34, 12)
        end
    end
end

-- 山洞事件
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

-- 武道大会后，SYP自动放书
function NEvent10(keypress)
    if JY.SubScene == 25 and GetS(10, 0, 9, 0) ~= 1 then
        SetS(25, 9, 44, 3, 103)
        instruct_3(25, 103, 1, 0, 0, 0, 0, 4133 * 2, 4133 * 2, 4133 * 2, 0, -2, -2)
        if JY.Base["人X1"] == 10 and JY.Base["人Y1"] == 44 and JY.Base["人方向"] == 2 and
            (keypress == VK_SPACE or keypress == VK_RETURN) and GetD(25, 82, 5) == 4662 then
            say("１一路来到这里，真是辛苦了！我来帮你放书吧。", 596, 0);
            instruct_14()
            for i = 79, 92 do
                instruct_3(25, i, 1, 0, 0, 0, 0, 4664, 4664, 4664, 0, -2, -2)
            end
            for ii = CC.BookStart, CC.BookStart + CC.BookNum - 1 do
                instruct_32(ii, -10)
            end
            -- JY.Base["天书数量"] = 15
            instruct_3(25, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2)
            instruct_3(25, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2)
            instruct_13()
            say("１书已经放好了，从上面的门出去吧。", 596, 0);
            SetS(10, 0, 9, 0, 1)
            instruct_3(25, 103, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2)

        end
    end
end

-- 大功坊 和袁承志对话后，金蛇剑归还
function NEvent12(keypress)
    if JY.SubScene == 95 and GetD(95, 4, 5) ~= 0 and JY.Thing[40]["使用人"] ~= -1 then
        JY.Person[JY.Thing[40]["使用人"]]["武器"] = -1
        JY.Thing[40]["使用人"] = -1
    end
end

-- 山洞女主角的剧情
function mm4R()
    local r = LGMsgBox("请选择", "内力性质呢？", {"阴内", "阳内", "调和"}, 3, 92)
    if r == 1 then
        JY.Person[92]["内力性质"] = 0
        Cls() -- 清屏
    elseif r == 2 then
        JY.Person[92]["内力性质"] = 1
        Cls() -- 清屏
    elseif r == 3 then
        JY.Person[92]["内力性质"] = 2
        Cls() -- 清屏
    end
    if JY.Person[0]["资质"] == 50 then
        JY.Person[92]["资质"] = 50
    else
        JY.Person[92]["资质"] = 101 - JY.Person[0]["资质"]
    end
end

-- 自定义事件
function NEvent(keypress)
    -- NEvent2(keypress)		--十四本天书之后得到5000两，洗四神技
    NEvent3(keypress) -- 胡斐 苗人凤教苗家剑法
    NEvent4(keypress) -- 令狐冲变身
    NEvent6(keypress) -- 蜘蛛洞 金龙帮
    NEvent10(keypress) -- 武道大会放书
    NEvent12(keypress) -- 归还金蛇剑
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
                        me[#me + 1] = "Ｎ"
                    end
                end
            end
            if CC.PTF[mid] ~= nil then
                for i, v in pairs(CC.PTF[mid]) do
                    if v == 1 then
                        if CC.PTFSM[i] ~= nil then
                            -- me[#me+1] = 'Ｌ'..CC.PTFSM[i][1]
                            -- me[#me+1] = 'Ｗ'..CC.PTFSM[i][2]
                            -- me[#me+1] = "Ｎ"
                        end
                    end
                end
            end
            for i = 1, 5 do
                if JY.Person[mid]['天赋' .. i] > 0 then
                    local tf = JY.Person[mid]['天赋' .. i]
                    if CC.PTFSM[tf] ~= nil then
                        me[#me + 1] = 'Ｌ' .. CC.PTFSM[tf][1]
                        me[#me + 1] = 'Ｗ' .. CC.PTFSM[tf][2]
                        me[#me + 1] = "Ｎ"
                    end
                end
            end
            for i = 1, #me do
                local tfstr = me[i]
                local h = 0

                if string.sub(tfstr, 1, 2) == "Ｎ" then
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
                    local headid = JY.Person[mid]["半身像"]
                    lib.LoadPNG(91, headid * 2, zx, zy, 2)
                end
            end
        end
    end
    -- 显示画面
    ShowScreen()
    -- 循环的间隔（数值随意）
    -- lib.Delay(CC.Frame)
    -- X是键盘操作，ktype是鼠标操作，ktype = 3 代表左键，4代表右键，6滚轮上，7滚轮下
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
        local hd = JY.Person[id]["半身像"]
        lib.LoadPNG(1, hd * 2, bx * 40, by * 40, 2)
        ShowScreen();
    end
end
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

-- 中原地图	
function ZYDT()
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
            local s = JY.Scene[jn[i]]["名称"]
            if JY.Scene[jn[i]]["进入条件"] == 1 then
                cl = M_DimGray
            end
            if tb == i then
                cl = C_RED
                BH = jn[i]
                sb = i
            end
            -- 显示地图名称

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
            if JY.Scene[BH]["进入条件"] == 0 then
                CC.Shichen = CC.Shichen + 6
                return My_Enter_SubScene(BH, -1, -1, -1);
            else
                say("１Ｒ您目前不能进入此场景。", 119, 5, "车夫");
                return 1
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
    return 0
end

-- 江南地图
function JNDT()
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

-- 西部地图
function XBDT()
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
            local s = JY.Scene[jn[i]]["名称"]
            if JY.Scene[jn[i]]["进入条件"] == 1 then
                cl = M_DimGray
            end
            if tb == i then
                cl = C_RED
                BH = jn[i]
                sb = i
            end
            -- 显示地图名称

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
            if JY.Scene[BH]["进入条件"] == 0 then
                CC.Shichen = CC.Shichen + 6
                return My_Enter_SubScene(BH, -1, -1, -1);
            else
                say("１Ｒ您目前不能进入此场景。", 119, 5, "车夫");
                return 1
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
    return 0
end

-- 北部地图
function BBDT()
    local bx = CC.WX
    local by = CC.HY
    -- 选项
    local tb = 1
    local size = CC.DefaultFont * 0.7
    local cl = C_WHITE
    -- 地图编号
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
            local s = JY.Scene[jn[i]]["名称"]
            if JY.Scene[jn[i]]["进入条件"] == 1 then
                cl = M_DimGray
            end
            if tb == i then
                cl = C_RED
                BH = jn[i]
                sb = i
            end
            -- 显示地图名称

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
            if JY.Scene[BH]["进入条件"] == 0 then
                CC.Shichen = CC.Shichen + 6
                return My_Enter_SubScene(BH, -1, -1, -1);
            else
                say("１Ｒ您目前不能进入此场景。", 119, 5, "车夫");
                return 1
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
    return 0
end

-- 海外地图
function HWDT()
    local bx = CC.WX
    local by = CC.HY
    -- 选项
    local tb = 1
    local size = CC.DefaultFont * 0.7
    local cl = C_CYGOLD
    -- 地图编号
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
            local s = JY.Scene[jn[i]]["名称"]
            if JY.Scene[jn[i]]["进入条件"] == 1 then
                cl = M_DimGray
            end
            if tb == i then
                cl = C_RED
                BH = jn[i]
                sb = i
            end
            -- 显示地图名称

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
            if JY.Scene[BH]["进入条件"] == 0 then
                CC.Shichen = CC.Shichen + 6
                return My_Enter_SubScene(BH, -1, -1, -1);

            else
                say("１Ｒ您目前不能进入此场景。", 119, 5, "车夫");
                return 1
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
    return 0
end

-- 地图菜单
function NEWCS()

    local bx = CC.WX
    local by = CC.HY
    -- 选项
    local tb = 1
    local size = CC.DefaultFont * 0.7
    local cl = C_CYGOLD
    -- 地图编号
    local ddtx;
    local ddty;
    local sb;
    -- 地图编号表
    -- 地图名称显示位置
    local m1 = {"北部", "西部", "中原", "江南", "海外岛屿"}
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
    if CC.TX['马车'] == 0 then
        NEWCS()
    elseif CC.TX['马车'] == 1 then
        My_ChuangSong_List()
    end
end

-- 状态页装备说明
function wupin_info(thingID)
    local bx = CC.WX
    local by = CC.HY
    local str = JY.Thing[thingID]["代号"] .. JY.Thing[thingID]["名称"]
    local str2 = JY.Thing[thingID]["物品说明"]
    local str3 = JY.Thing[thingID]["名称"]
    if ItemInfo[thingID] == nil then
        return
    end
    local info = {}
    -- info = ItemInfo[thingID]
    info = ItemInfo[thingID]
    local function strcolor_switch(s)
        local Color_Switch = {{"Ｒ", PinkRed}, {"Ｇ", C_GOLD}, {"Ｂ", C_BLACK}, {"Ｗ", C_WHITE}, {"Ｏ", C_ORANGE},
                              {"Ｌ", LimeGreen}, {"Ｄ", M_DeepSkyBlue}, {"Ｚ", Violet}}
        for i = 1, 8 do
            if Color_Switch[i][1] == s then
                return Color_Switch[i][2]
            end
        end
    end
    local maxRowExisting = #info -- 当前说明总行数
    local maxRowDisplayable = 18 -- 当面页面可以显示的最大行数
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
        if string.sub(tfstr, 1, 2) == "Ｎ" then
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
        local menu = {{"确定", nil, 1}, {"取消", nil, 2}}
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
    local qz = JY.Person[id]["拳掌功夫"]
    local rwfj = JY.Person[id]["拳法成长"]
    cz = rwfj + qz / 5
    string.format("%.2f", cz)
    return cz
end

function Pzfcz(id)
    local cz = 0
    local qz = JY.Person[id]["指法技巧"]
    local rwfj = JY.Person[id]["指法成长"]
    cz = rwfj + qz / 5
    string.format("%.2f", cz)
    return cz
end

function Pjfcz(id)
    local cz = 0
    local qz = JY.Person[id]["御剑能力"]
    local rwfj = JY.Person[id]["剑法成长"]
    cz = rwfj + qz / 5
    string.format("%.2f", cz)
    return cz
end

function Pdfcz(id)
    local cz = 0
    local qz = JY.Person[id]["耍刀技巧"]
    local rwfj = JY.Person[id]["刀法成长"]
    cz = rwfj + qz / 5
    string.format("%.2f", cz)
    return cz
end

function Pqmcz(id)
    local cz = 0
    local qz = JY.Person[id]["特殊兵器"]
    local rwfj = JY.Person[id]["奇门成长"]
    cz = rwfj + qz / 5
    string.format("%.2f", cz)
    return cz
end

function Paqcz(id)
    local cz = 0
    local qz = JY.Person[id]["暗器技巧"]
    local rwfj = JY.Person[id]["暗器成长"]
    cz = rwfj + qz / 5
    string.format("%.2f", cz)
    return cz
end

---数字写成中文
function numberToString(szNum)
    ---阿拉伯数字转中文大写
    local szChMoney = ""
    local iLen = 0
    local iNum = 0
    local iAddZero = 0
    local hzUnit = {"", "十", "百", "千", "万", "十", "百", "千", "亿", "十", "百", "千", "万", "十",
                    "百", "千"}
    local hzNum = {"零", "一", "二", "三", "四", "五", "六", "七", "八", "九"}
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
            szChMoney = szChMoney .. hzNum[iNum + 1] -- //转换为相应的数字
            iAddZero = 0
        end
        if (iAddZero < 4) and (0 == (iLen - i) % 4 or 0 ~= tonumber(iNum)) then
            szChMoney = szChMoney .. hzUnit[iLen - i + 1]
        end
    end
    local function removeZero(num)
        -- 去掉末尾多余的 零
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
        --- 开头的 "一十" 转成 "十" , 贴近人的读法
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
        DrawString(bx * 212 + bx * 515 - string.len(JY.Person[id]["姓名"]) / 2 * size1, by * 73 + by * 33,
            JY.Person[id]["姓名"], C_CYGOLD, size1)
        local myh = 18
        local hs = 0
        local me = {}
        local bz = {'拳', '指', '剑', '刀', '奇', '罡', '仁', '医', '毒'}
        -- 天赋ID
        -- local tfid;
        -- 天赋ID
        local tfid;
        -- 主角
        if id == 0 then
            -- 标主
            if JY.Base["标准"] > 0 then
                tfid = 546 + JY.Base["标准"]
                -- 特殊
            elseif JY.Base["特殊"] > 0 then
                tfid = ''
                -- 畅想
            else
                tfid = JY.Base["畅想"]
                -- 畅想袁承志
                if tfid == 54 and JY.Person[id]["个人觉醒"] >= 1 then
                    tfid = "54-1"
                    -- 畅想石破天
                elseif tfid == 38 and JY.Person[id]["个人觉醒"] >= 1 then
                    tfid = "38-1"
                    -- 畅想郭襄
                elseif tfid == 626 and JY.Person[id]["个人觉醒"] >= 1 then
                    tfid = "626-1"
                end
            end
            -- 队友
        else
            tfid = id
            -- 袁承志
            if id == 54 and JY.Person[id]["个人觉醒"] >= 1 then
                tfid = "54-1"
                -- 石破天
            elseif id == 38 and JY.Person[id]["个人觉醒"] >= 1 then
                tfid = "38-1"
                -- 郭襄
            elseif id == 626 and JY.Person[id]["个人觉醒"] >= 1 then
                tfid = "626-1"
            end
        end
        local mid = tfid
        local size = CC.DefaultFont
        if JY.Base["标准"] > 0 and id == 0 then
            mid = bz[JY.Base["标准"]]
        end
        if TFJS[mid] ~= nil then
            for i = 1, #TFJS[mid] do
                me[#me + 1] = TFJS[mid][i]
                if i == #TFJS[mid] then
                    me[#me + 1] = "Ｎ"
                end
            end
        end
        if id == 0 then
            if JY.Base["畅想"] > 0 then
                tfid = 0
            end
        end
    end
end

---------------------------组合---------------------
-- 无酒不欢：判定一个人物是否满足桃花绝技的条件
function TaohuaJJ(id)
    -- 郭襄自动满足
    local pd = false
    if (PersonKF(id, 12) and PersonKF(id, 18) and PersonKF(id, 38)) or match_ID(id, 626) then
        return true
    end
    return false
end

-- 无酒不欢：判定一个人物是否满足紫气天罗的条件
function ZiqiTL(id)
    local pd = false
    if PersonKF(id, 5) and PersonKF(id, 9) and PersonKF(id, 21) and PersonKF(id, 118) then
        return true
    end
    return false
end

-- 无酒不欢：判定一个人物是否满足我欲成仙的条件
function WoYuCX(id)
    local pd = false
    if PersonKF(id, 8) and PersonKF(id, 14) and PersonKF(id, 201) and PersonKF(id, 202) then
        return true
    end
    return false
end

-- 无酒不欢：判定一个人物是否满足毒布武林的条件
function DubuWL(id)
    local pd = false
    if PersonKF(id, 3) and PersonKF(id, 120) and PersonKF(id, 220) and PersonKF(id, 295) and PersonKF(id, 334) then
        return true
    end
    return false
end

-- 无酒不欢：判定一个人物是否满足慈悲为怀的条件
function Cbwh(id)
    local pd = false
    if PersonKF(id, 57) and PersonKF(id, 346) then
        return true
    end
    return false
end

-- 无酒不欢：判定一个人物是否满足铁甲依然在的条件
function Tjyrz(id)
    local pd = false
    if PersonKF(id, 13) and PersonKF(id, 143) and PersonKF(id, 196) and Curr_NG(id, 196) then
        return true
    end
    return false
end

-- 无酒不欢：判定一个人物是否满足五虎闹东京的条件
function Wuhu(id)
    local pd = false
    if PersonKF(id, 59) and PersonKF(id, 232) then
        return true
    end
    return false
end

-- 无酒不欢：判定一个人物是否满足十三太保横练的条件
function Sstbhl(id)
    local pd = false
    if match_ID(id, 603) or match_ID(id, 9807) then
        return true
    end
    return false
end

-- 无酒不欢：判定一个人物是否满足血战沙场的条件
function XueZhanShangChang(id)
    local pd = false
    if PersonKF(id, 200) and PersonKF(id, 198) and PersonKF(id, 199) then
        return true
    end
    return false
end

-- 无酒不欢：判定一个人物是否满足素质三连的条件
function SuZhiSanLian(id)
    local pd = false
    if PersonKF(id, 29) and PersonKF(id, 114) then
        return true
    end
    return false
end

-- 金刚般若
function JinGangBR(id)
    local pd = false
    if PersonKF(id, 22) and PersonKF(id, 189) and PersonKF(id, 103) then
        return true
    end
    return false
end

-- 无酒不欢：判定一个人物是否满足道可道的条件
function DaoKeDao(id)
    local pd = false
    if PersonKF(id, 64) and PersonKF(id, 236) then
        return true
    end
    return false
end

-- 无酒不欢：判定一个人物是否满足寸长寸强的条件
function CunChangCunQiang(id)
    local pd = false
    if PersonKF(id, 165) and PersonKF(id, 206) then
        return true
    end
    return false

end

-- 无酒不欢：判定一个人物是否满足剑胆琴心的条件
function JiandanQX(id)
    local pd = false
    if PersonKF(id, 47) and PersonKF(id, 73) then
        return true
    end
    return false
end

-- 无酒不欢：举火燎原，金乌+燃木+火焰刀
function JuHuoLY(id)
    local pd = false
    if PersonKF(id, 61) and PersonKF(id, 65) and PersonKF(id, 66) then
        return true
    end
    return false
end

-- 世尊降魔 伏魔杵 金刚伏魔圈 伏魔杖法 罗汉伏魔功
function ShiZunXM(id)
    local pd = false
    if PersonKF(id, 96) and PersonKF(id, 82) and PersonKF(id, 83) and PersonKF(id, 86) then
        return true
    end
    return false
end

-- 金乌映雪
function JinwuYingXue(id)
    local pd = false
    if PersonKF(id, 35) and PersonKF(id, 61) then
        return true
    end
    return false
end

-- 铁锁横江
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

-- 双剑合壁 全真剑法 + 玉女剑
function ShuangJianHB(id)
    if PersonKF(id, 39) and (PersonKF(id, 42) or PersonKF(id, 139)) and JY.Person[id]['左右互搏'] == 1 then
        return true
    end
    return false
end

-- 无酒不欢：利刃寒锋，修罗+阴风+沧溟
function LiRenHF(id)
    if PersonKF(id, 58) and PersonKF(id, 153) and PersonKF(id, 174) then
        return true
    end
    return false

end

-- 逍遥御风 and JY.Person[240]["品德"] == 50
function XiaoYaoYF(id)
    if ((PersonKF(id, 85) and PersonKF(id, 98) and PersonKF(id, 101)) or match_ID_awakened(id, 634, 1)) and
        (JY.Person[240]["品德"] == 80 or not isteam(id)) then
        return true
    end
    return false
end

-- 罗汉金身
function LuoHanJinShen(id)
    if PersonKF(id, 96) and PersonKF(id, 144) then
        return true
    end
    return false
end

-- 无酒不欢：太极+柔云，以柔克刚
function YiRouKG(id)
    if PersonKF(id, 36) and PersonKF(id, 46) then
        return true
    end
    return false
end
-- 无酒不欢：判定一个人物是否满足天衣无缝的条件
function TianYiWF(id)
    if PersonKF(id, 54) and PersonKF(id, 62) then
        return true
    end
    return false
end

-- 同时修炼多罗叶指/大智无定指/无相劫指/拈花指到极
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
            if JY.Person[id]["秘技" .. i] == 5 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 5
                    break
                end
            end
        end
    end
    if ZiqiTL(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 6 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 6
                    break
                end
            end
        end
    end
    if WoYuCX(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 7 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 7
                    break
                end
            end
        end
    end
    if DubuWL(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 8 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 8
                    break
                end
            end
        end
    end
    if Cbwh(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 9 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 9
                    break
                end
            end
        end
    end
    if Tjyrz(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 10 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 10
                    break
                end
            end
        end
    end
    if Wuhu(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 11 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 11
                    break
                end
            end
        end
    end
    if Sstbhl(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 12 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 12
                    break
                end
            end
        end
    end
    if XueZhanShangChang(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 13 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 13
                    break
                end
            end
        end
    end
    if SuZhiSanLian(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 14 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 14
                    break
                end
            end
        end
    end
    if JinGangBR(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 15 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 15
                    break
                end
            end
        end
    end
    if DaoKeDao(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 16 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 16
                    break
                end
            end
        end
    end
    if CunChangCunQiang(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 17 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 17
                    break
                end
            end
        end
    end
    if JiandanQX(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 18 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 18
                    break
                end
            end
        end
    end
    if JuHuoLY(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 19 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 19
                    break
                end
            end
        end
    end
    if ShiZunXM(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 20 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 20
                    break
                end
            end
        end
    end
    if JinwuYingXue(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 21 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 21
                    break
                end
            end
        end
    end
    if TieSuoHengJiang(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 22 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 22
                    break
                end
            end
        end
    end
    if ShuangJianHB(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 23 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 23
                    break
                end
            end
        end
    end
    if LiRenHF(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 24 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 24
                    break
                end
            end
        end
    end
    if XiaoYaoYF(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 25 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 25
                    break
                end
            end
        end
    end
    if LuoHanJinShen(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 26 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 26
                    break
                end
            end
        end
    end
    if YiRouKG(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 27 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 27
                    break
                end
            end
        end
    end
    if TianYiWF(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 36 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 36
                    break
                end
            end
        end
    end
    if ChuQueSX(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 37 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 37
                    break
                end
            end
        end
    end
    if HuXiaoLY(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 38 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 38
                    break
                end
            end
        end
    end
    if Taikongxj(id) == true then
        local pd = false
        for i = 1, 5 do
            if JY.Person[id]["秘技" .. i] == 39 then
                pd = true
            end
            if pd == false then
                if JY.Person[id]["秘技" .. i] == 0 then
                    JY.Person[id]["秘技" .. i] = 39
                    break
                end
            end
        end
    end
end

-- 奇数偶数
function IsOuNumber(num)
    local num1, num2 = math.modf(num / 2) -- 返回整数和小数部分
    if (num2 == 0) then
        return true
    else
        return false
    end
end

-- 老顾自定义取得表中最大的值
-- tableParmater ： 表类型输入变量，如果不合法，则输出 nil
function GetTableMax(tableParmater)
    -- 建议使用局部变量、释放空间
    local returnMaxNumber = nil
    -- 参数检查（变量是否正确）
    if (type(tableParmater) ~= "table") then
        print("错误，输出参数不是合法的类型")
        return nil
    end

    for i, j in pairs(tableParmater) do
        -- 给最大数值 returnMaxNumber 变量赋值
        if (returnMaxNumber == nil) then
            returnMaxNumber = j
        end
        -- 取得最大的数值
        if (j > returnMaxNumber) then
            returnMaxNumber = j
        end
    end
    return returnMaxNumber
end

-- 武功菜单说明
function LGShowMenu_kf(menu, maxh, maxw, title, r)
    local bx, by = CC.ScreenW / 1360, CC.ScreenH / 768
    local id = 0
    local cury = 0
    local wz = ''
    local bx = CC.ScreenW / 936
    local by = CC.ScreenH / 702
    local size2 = CC.DefaultFont * 0.7
    local size, size1 = CC.DefaultFont * 0.9, CC.DefaultFont -- 字号
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
    local jjwz = {"初窥门径", "初窥门径", "略有小成", "略有小成", "渐入佳境", "渐入佳境",
                  "融会贯通", "融会贯通", "炉火纯青", "炉火纯青", "登峰造极"}
    local djwz = {"一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "极"}
    local pjwz = {"Ｗ" .. "初阶武功", "Ｌ" .. "中阶武功", "Ｒ" .. "高阶武功", "Ｇ" .. "绝学武功"}
    local color = RGB(248, 248, 181)
    local zsh, zsw = size * 1.5, size * 1.1 -- 招式部分的文字坐标控制
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
        if JY.Thing[thingID]["练出武功"] > 0 then
            mm = 2
        end
        lib.LoadPNG(91, 372 * 2, wgzbx - size * 2, wgzby - CC.ScreenH / 2.8, 1)
        local function strcolor_switch(s)
            local Color_Switch = {{"Ｒ", PinkRed}, {"Ｇ", M_Wheat}, {"Ｂ", C_BLACK}, {"Ｗ", RGB(178, 158, 124)},
                                  {"Ｏ", C_ORANGE}, {"Ｌ", LimeGreen}, {"Ｄ", M_DeepSkyBlue}, {"Ｚ", Violet}}
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
                    me[#me + 1] = "Ｎ"
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
            if string.sub(tfstr, 1, 2) == "Ｎ" then
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
            local Color_Switch = {{"Ｒ", PinkRed}, {"Ｇ", M_Wheat}, {"Ｂ", C_BLACK}, {"Ｗ", RGB(178, 158, 124)},
                                  {"Ｏ", C_ORANGE}, {"Ｌ", LimeGreen}, {"Ｄ", M_DeepSkyBlue}, {"Ｚ", Violet}}
            for i = 1, 8 do
                if Color_Switch[i][1] == s then
                    return Color_Switch[i][2]
                end
            end
        end
        for i = 1, 10 do
            local kftx = JY.Wugong[kf]['特效' .. i]
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
            if string.sub(tfstr, 1, 2) == "Ｎ" then
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
        local name = JY.Wugong[kf]['名称']
        local level = 11
        local kfwl = get_skill_power(0, kf, level)
        local kfi = x
        local kfth = KF_thing(kf)
        wgmenu[#wgmenu + 1] = {kf, name, kfwl, level, kfi, kfth, x} -- 编号，名称，威力，等级,位置,秘籍
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
            -- lib.Debug('小于num lb=='..lb)
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
            local me = JY.Wugong[kf1]["名称"]
            local wgmp = MPname[JY.Wugong[kf1]["门派"] + 1]
            local level = 11
            local wugongwl = get_skill_power(id, kf1, level)
            local mz = JY.Wugong[kf1]["加命中"]
            local wz2 = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"}

            if kf1 > 0 then
                cl = C_RED
                local jg1 = size * 1.1
                -- 武功招式
                local wgbj = 0
                if JY.Wugong[kf1]["武功类型"] < 6 then
                    wgbj = 286
                else
                    wgbj = 287
                end
                if kfsm == 2 then
                    wgbj = 287
                end
                -- 新武功说明背景图
                wgbj = 368
                local kfcj1 = JY.Wugong[kf1]["层级"]
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
                if JY.Wugong[kf1]['武功类型'] < 6 then
                    if kfsm == 1 then
                        lib.LoadPNG(91, 369 * 2, wgzbx - size * 2, wgzby - size * 10.5, 1) -- 招式背景
                        lib.LoadPNG(91, 14 * 2, wgzbx + CC.ScreenW / 2.9, wgzby + size * 4, 1, 0, 80) -- 切换武功说明图片
                    end
                end
                lib.LoadPNG(91, 371 * 2, wgzbx + size * 8, wgzby - size / 2, 1, 0, 90) -- 武功名字背景

                lib.LoadPNG(91, (373 + kfcj1) * 2, wgzbx - size * 2, wgzby - size / 1.5, 1, 0, 100) -- 武功阶级图片

                lib.DrawStr(wgzbx - string.len(JY.Wugong[kf1]["名称"]) / 4 * size + size * 11, wgzby,
                    JY.Wugong[kf1]["名称"], wgcl, size * 1.8, CONFIG.CurrentPath .. "FONT/2.TTF", 0, 0) -- 武功名称显示	

                local neishu = nil
                if KF_thing(kf1) ~= nil then
                    neishu = JY.Thing[KF_thing(kf1)]['需内力性质']
                else
                    neishu = 2
                end
                local neishuwz = {'阴', '阳', '调和'}
                local neishuwz1 = neishuwz[neishu + 1]
                local wglx = {'●' .. neishuwz1 .. '拳', '●' .. neishuwz1 .. '指', '●' .. neishuwz1 .. '剑',
                              '●' .. neishuwz1 .. '刀', '●' .. neishuwz1 .. '奇', '●' .. neishuwz1 .. '内',
                              '●' .. neishuwz1 .. '轻'}
                local wgsize = size * 0.8
                DrawString(wgzbx, wgzby, "门派" .. ":  " .. wgmp .. ' ' .. wglx[JY.Wugong[kf1]['武功类型']],
                    C_BLACK, wgsize) -- 门派
                DrawString(wgzbx, wgzby + jg1, "修为" .. ":  " .. jjwz[level] .. " " .. "(" .. djwz[level] .. ")",
                    C_BLACK, wgsize) -- 修为
                local gdz = JY.Wugong[kf1]["层级"] * level
                local sm = JY.Wugong[kf1]["层级"] * 100 + wugongwl
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
                if JY.Wugong[kf1]["武功类型"] < 6 then
                    pwz1 = "威力" .. ":  " .. math.modf(wugongwl)
                    pwz2 = "命中" .. ":  " .. mz
                    pwz3 = "格档" .. ":  " .. gdz
                    pwz4 = ""
                elseif JY.Wugong[kf1]["武功类型"] == 6 then
                    pwz1 = "生命" .. ":  " .. sm
                    pwz2 = "气防" .. ":  " .. math.modf(wugongwl)
                    pwz3 = "格档" .. ":  " .. gdz
                    pwz4 = "回气" .. ":  " .. hq
                else
                    pwz1 = "命中" .. ":  " .. JY.Wugong[kf1]["加命中"]
                    pwz2 = "闪避" .. ":  " .. JY.Wugong[kf1]["加闪避"]
                    pwz3 = "移动" .. ":  " .. ""
                    pwz4 = "集气" .. ":  " .. ""
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
                                -- 无酒不欢：装备的数值随等级变化
                                if myThing["装备位置"] > -1 then
                                    local attr_gain = 0;
                                    if myThing[ss] > 0 then
                                        attr_gain = myThing[ss] * 10 + myThing[ss] * (myThing["装备等级"] - 1) * 2
                                    elseif myThing[ss] < 0 then
                                        attr_gain = myThing[ss] * 10 - myThing[ss] * (myThing["装备等级"] - 1) * 2
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
                        -- 内属颜色
                        if myThing[ss] == 1 and ss == "需内力性质" then
                            color = RGB(236, 200, 40)
                        elseif myThing[ss] == 2 and ss == "需内力性质" then
                            color = RGB(236, 236, 236)
                        end
                    elseif myThing[ss] == 0 and ss == "需内力性质" then
                        mys = string.format(str .. ':%s', news[myThing[ss]])
                        mys = str .. news[myThing[ss]]
                        color = RGB(208, 152, 208)
                    else
                        return
                    end
                    -- DrawString(mx+CC.MenuBorderPixel,my+CC.MenuBorderPixel+CC.ScreenH/1.5,mys,color,myfont)
                    pwz5 = pwz5 .. ' ' .. mys
                end
                if myThing['类型'] > 0 then
                    if thid > 343 or thid < 348 then -- 特殊药品不显示
                        -- DrawString(wgzbx, y3_2 + 2+CC.MenuBorderPixel+CC.ScreenH/1.5, " 效果:", LimeGreen, myfont)
                        pwz6 = "效果："
                    end
                    if myThing['加生命最大值'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '生命+' .. myThing['加生命最大值']
                    end
                    if myThing['改变内力性质'] == 2 then
                        pwz6 = pwz6 .. ' ' .. '内力属性变为调和'
                    end
                    if myThing['加攻击力'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '攻击+' .. myThing['加攻击力']
                    end
                    if myThing['加防御力'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '防御+' .. myThing['加防御力']
                    end
                    if myThing['加轻功'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '轻功+' .. myThing['加轻功']
                    end
                    if myThing['加医疗能力'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '医疗+' .. myThing['加医疗能力']
                    end
                    if myThing['加用毒能力'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '用毒+' .. myThing['加用毒能力']
                    end
                    if myThing['加解毒能力'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '解毒+' .. myThing['加解毒能力']
                    end
                    if myThing['加抗毒能力'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '抗毒+' .. myThing['加抗毒能力']
                    end
                    if myThing['加拳掌功夫'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '拳掌+' .. myThing['加拳掌功夫']
                    end
                    if myThing['加指法技巧'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '指腿+' .. myThing['加指法技巧']
                    end
                    if myThing['加御剑能力'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '御剑+' .. myThing['加御剑能力']
                    end
                    if myThing['加耍刀技巧'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '耍刀+' .. myThing['加耍刀技巧']
                    end
                    if myThing['加特殊兵器'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '特殊兵器+' .. myThing['加特殊兵器']
                    end
                    if myThing['加暗器技巧'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '暗器+' .. myThing['加暗器技巧']
                    end
                    if myThing['加武学常识'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '武常+' .. myThing['加武学常识']
                    end
                    if myThing['加攻击次数'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '左右+' .. myThing['加攻击次数']
                    end
                    if myThing['加攻击带毒'] > 0 then
                        pwz6 = pwz6 .. ' ' .. '带毒+' .. myThing['加攻击带毒']
                    end
                    -- 武器装备威力加成
                    for i, v in ipairs(CC.ExtraOffense) do
                        if v[1] == thid then
                            -- DrawString(mx+CC.MenuBorderPixel+CC.ScreenW/68.4,my+CC.MenuBorderPixel+CC.ScreenH/1.5,"威力强化:"..JY.Wugong[v[2]]["名称"].."+"..v[3],PinkRed,myfont)
                        end
                    end

                end
                -- 需求:
                if myThing['类型'] == 2 then
                    pwz5 = '需求:'
                    if myThing['仅修炼人物'] > -1 then
                        drawitem('仅限:' .. JY.Person[myThing['仅修炼人物']]['姓名'])
                    end
                    drawitem('需内力性质', '内属', {
                        [0] = '阴',
                        '阳',
                        '不限'
                    })
                    drawitem('需内力', '内力')
                    drawitem('需攻击力', '攻击')
                    drawitem('需轻功', '轻功')
                    drawitem('需用毒能力', '用毒')
                    drawitem('需医疗能力', '医疗')
                    drawitem('需拳掌功夫', '拳掌')
                    drawitem('需指法技巧', '指法')
                    drawitem('需御剑能力', '御剑')
                    drawitem('需耍刀技巧', '耍刀')
                    drawitem('需特殊兵器', '特殊')
                    drawitem('需暗器技巧', '暗器')
                    if thid == 372 then
                        drawitem('需80>资质>30')
                    end
                    -- 斗转的显示
                    local exstr = ''
                    if thid == 118 then
                        exstr = "五系兵器值之和>=120 "
                    end
                    -- 阴阳的显示
                    if thid == 176 then
                        exstr = "御剑/耍刀/特殊任一项>=70 "
                    end
                    pwz5 = pwz5 .. ' ' .. exstr
                    local wugong = JY.Thing[thid]["练出武功"]
                    drawitem('需资质', '资质')
                    -- DrawString(dx+CC.MenuBorderPixel+CC.ScreenW/68.4,my2+CC.MenuBorderPixel+CC.ScreenH/1.5,' 需求:',LimeGreen,myfont)	

                end
                DrawString(wgzbx, wgzby, "门派" .. ":  " .. wgmp .. ' ' .. wglx[JY.Wugong[kf1]['武功类型']],
                    C_BLACK, wgsize) -- 门派 第一排文字
                DrawString(wgzbx, wgzby + jg1, "修为" .. ":  " .. jjwz[level] .. " " .. "(" .. djwz[level] .. ")",
                    C_BLACK, wgsize) -- 修为 第二排文字
                DrawString(wgzbx, wgzby + jg1 * 2, pwz1, C_BLACK, wgsize) -- 第三排文字
                DrawString(wgzbx, wgzby + jg1 * 3, pwz2, C_BLACK, wgsize) -- 第四排文字
                DrawString(wgzbx, wgzby + jg1 * 4, pwz3 .. '   ' .. pwz4, C_BLACK, wgsize) -- 第五排文字
                DrawString(wgzbx, wgzby + jg1 * 5, pwz5, C_BLACK, wgsize) -- 第六排文字
                DrawString(wgzbx, wgzby + jg1 * 6, pwz6, C_BLACK, wgsize) -- 第七排文字
                local wglx2 = {'拳法', '指法', '剑法', '刀法', '奇门', '内功', '轻功'}
                local wgcj = {'初阶', '中阶', '高阶', '绝学'}
                local lx3 = JY.Wugong[kf1]['武功类型']
                local wgcj1 = wgcj[JY.Wugong[kf1]['层级']]
                local kfsmwz = wgmp .. wgcj1 .. wglx2[lx3]
                local kfx, kfy = size * 8, size * 2
                if KF_thing(kf1) ~= nil then
                    -- local size5 = CC.FONT2
                    local row = 1
                    local fy = 0
                    local h = 0
                    if JY.Thing[KF_thing(kf1)]["物品说明"] ~= nil then
                        -- DrawString(wgzbx+kfx,wgzby+size*2.2,JY.Thing[KF_thing(kf1)]["物品说明"],C_WHITE,wgsize)
                        h = tjm(wgzbx + kfx, wgzby + size * 1.7 + size * (row - fy),
                            '■' .. JY.Thing[KF_thing(kf1)]["物品说明"], C_BLACK, wgsize * 0.9, 11, wgsize * 1.7,
                            fy - row, 40)
                        row = row + h
                    else
                        -- DrawString(wgzbx+kfx,wgzby+size*2.2,'■'..kfsmwz,color,wgsize)
                        h = tjm(wgzbx + kfx, wgzby + size * 1.7 + size * (row - fy), '■' .. kfsmwz, C_BLACK, wgsize,
                            9, wgsize * 1.5, fy - row, 40)
                        row = row + h
                    end
                else
                    DrawString(wgzbx + kfx, wgzby + size * 2.2, kfsmwz, C_BLACK, wgsize)
                end
                if kfsm == 1 then
                    if JY.Wugong[kf1]["武功类型"] < 6 then
                        for j = 1, #CC.KFMove[kf1] do
                            local leixing = {91, 92, 93, 94, 95, 96}
                            local lxpic = leixing[JY.Wugong[kf1]["武功类型"]]
                            -- lib.Debug('menu1[5]=='..menu1[5])
                            local zsnum = CC.WUGONGZS[1][j]
                            if JY.Person[id]["武功招式" .. zsnum] == 0 then
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
                                gj = gj + JY.Person[id]['攻击力']
                                ----lib.Debug('人物攻击力'..gj)	
                                local nlgj = limitX((JY.Person[id]['内力'] - JY.Person[id]['资质'] * 10) / 60, 0)
                                ----lib.Debug('内力加成攻击力'..nlgj)	
                                gj = gj + nlgj
                                gj = gj + FJGONGJ(id)
                                ----lib.Debug('装备加成攻击力'..FJGONGJ(id))	
                                return gj
                            end
                            local atk = Atk(id)
                            local zzz = tb4
                            if zzz > 6 then
                                zzz = 6
                            end
                            local nnn = wugongwl * (1 + (zzz - 1) / 10)
                            local sz = math.ceil(atk * (1 + nnn / 2000))
                            local sznum = {"一", "二", "三", "四", "五", "六", "七", "八", "九", "十"}
                            local wz1 = "造成基础伤害" .. 'Ｇ' .. sz .. "Ｗ" .. "点。"
                            -- lib.Debug('kf1=='..kf1..' tob =='..tob..' #CC.KFMove[kf1]=='..#CC.KFMove[kf1])
                            local zsname = CC.KFMove[kf1][j][1]
                            local zswz = nil
                            local zswz1 = nil

                            if tb4 == j then
                                lib.LoadPNG(91, 88 * 2, wgzbx + (j - 1) * CC.ScreenW / 30 - CC.ScreenW / 80,
                                    wgzby + CC.ScreenH / 2.2, 1, 0, 95)
                                -- DrawString(wgzbx-size,wgzby+size*7,JY.Wugong[kf1]["名称"].."第Ｇ"..sznum[tb4].."Ｈ招:Ｄ"..zsname.."     耗气  Ｄ"..CC.KFMove[kf1][j][3],C_CYGOLD,wgsize)	
                                tjm(zsw + wgzbx - size, zsh + wgzby + size * 7, "Ｇ" .. JY.Wugong[kf1]["名称"] ..
                                    "Ｗ第Ｄ" .. sznum[tb4] .. "Ｗ招:Ｄ" .. zsname, C_WHITE, wgsize, 30, wgsize)
                                tjm(zsw + wgzbx + size * 8, zsh + wgzby + size * 7,
                                    "Ｗ    耗气 Ｄ" .. CC.KFMove[kf1][j][3], C_WHITE, wgsize, 30, wgsize)
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
                        if JY.Wugong[kf1]['特效1'] > 0 then
                            -- lib.Debug(kf1..'判定成功1') 
                            wugong_info1(kf1)
                        else
                            if KF_thing(kf1) ~= nil then
                                -- lib.Debug(kf1..'判定成功2') 
                                wugong_info(KF_thing(kf1))
                            end
                        end
                    end
                elseif kfsm == 2 then
                    if JY.Wugong[kf1]['特效1'] > 0 then
                        -- lib.Debug(kf1..'判定成功1') 
                        wugong_info1(kf1)
                    else
                        if KF_thing(kf1) ~= nil then
                            -- lib.Debug(kf1..'判定成功2') 
                            wugong_info(KF_thing(kf1))
                        end
                    end
                end
                local r = 0
                if level <= 9 then
                    if KF_thing(kf1) ~= nil then
                        r = math.modf((5 - math.modf(25 / 25)) * JY.Thing[KF_thing(kf1)]["需经验"] * (level + 1) *
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
            -- lib.Debug('退出成功====')
            PlayWavE(77)
            -- 默认有选中
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
                if JY.Wugong[kf1]['武功类型'] < 6 then
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

-- 武功菜单说明
function LGShowMenu_person(menu, maxh, maxw, title, r)
    local bx, by = CC.ScreenW / 1360, CC.ScreenH / 768
    local id = 0
    local cury = 0
    local wz = ''
    local bx = CC.ScreenW / 936
    local by = CC.ScreenH / 702
    local size2 = CC.DefaultFont * 0.7
    local size, size1 = CC.DefaultFont * 0.9, CC.DefaultFont -- 字号
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
    local jjwz = {"初窥门径", "初窥门径", "略有小成", "略有小成", "渐入佳境", "渐入佳境",
                  "融会贯通", "融会贯通", "炉火纯青", "炉火纯青", "登峰造极"}
    local djwz = {"一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "极"}
    local pjwz = {"Ｗ" .. "初阶武功", "Ｌ" .. "中阶武功", "Ｒ" .. "高阶武功", "Ｇ" .. "绝学武功"}
    local color = RGB(248, 248, 181)
    local zsh, zsw = size * 1.5, size * 1.1 -- 招式部分的文字坐标控制
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
        local name = JY.Wugong[kf]['名称']
        local level = 11
        local kfwl = get_skill_power(0, kf, level)
        local kfi = x
        local kfth = KF_thing(kf)
        wgmenu[#wgmenu + 1] = {kf, name, kfwl, level, kfi, kfth, x} -- 编号，名称，威力，等级,位置,秘籍
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
            -- lib.Debug('小于num lb=='..lb)
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
            -- lib.Debug('退出成功====')
            PlayWavE(77)
            -- 默认有选中
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
                if JY.Wugong[kf1]['武功类型'] < 6 then
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
-- Cat时间计时
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

