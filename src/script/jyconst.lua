
--设置全局变量CC，保存游戏中使用的常数
function SetGlobalConst()
	--无酒不欢：基本完整的SDL2键码，便于设置快捷键
	VK_ESCAPE=27
	VK_SPACE=32				--注意这里的空格实际上不需要定义，因为底层会自动把空格转换成回车
	VK_RETURN=13
	VK_F1=1073741882
	VK_F2=1073741883
	VK_F3=1073741884
	VK_F4=1073741885
	VK_A = 97
	VK_B = 98 
	VK_C = 99 
	VK_D = 100 
	VK_E = 101
	VK_F = 102 
	VK_G = 103
	VK_H = 104 
	VK_I = 105
	VK_J = 106 
	VK_K = 107
	VK_L = 108 
	VK_M = 109
	VK_N = 110 
	VK_O = 111
	VK_P = 112 
	VK_Q = 113
	VK_R = 114 
	VK_S = 115
	VK_T = 116 
	VK_U = 117
	VK_V = 118 
	VK_W = 119
	VK_X = 120 
	VK_Y = 121
	VK_Z = 122 
	
	VK_BACKSPACE = 8

	VK_UP=1073741906
	VK_DOWN=1073741905
	VK_LEFT=1073741904
	VK_RIGHT=1073741903
	VK_PGUP=1073741899
	VK_PGDN=1073741902
		
	-- 游戏中颜色定义
	C_WHITE1 = RGB(188,189,171)
	C_GRAY22 = RGB(68, 68, 68)
	C_BLUE = RGB(7, 99, 219) --4阶
	C_WSTM = RGB(0, 0, 0)  --属性面板用	
	C_CYGOLD = RGB(216, 214, 175)  --属性面板用
	--金黄色 = RGB(216, 214, 175)  --属性面板用
	C_STARTMENU = RGB(132, 0, 4)
	C_RED = RGB(216, 20, 24) --红
	--大红色 = RGB(216, 20, 24) --红
	C_WHITE = RGB(236, 236, 236) --白
	--白色 = RGB(236, 236, 236)
	C_ORANGE = RGB(252, 148, 16) --橘色
	C_GOLD = RGB(236, 200, 40) --金
	C_BLACK = RGB(0, 0, 0) --黑色
	M_Black = RGB(0, 0, 0) --黑色
	M_Sienna = RGB(160, 82, 45) --褐色
	M_DarkOliveGreen = RGB(85, 107, 47)--深绿 
	M_DarkGreen = RGB(0, 100, 0) --深绿 --5阶
	M_DarkSlateBlue = RGB(72, 61, 139) --板岩暗蓝灰色
	M_Navy = RGB(0, 0, 128) --海军蓝
	M_Indigo = RGB(75, 0, 130) --靓蓝色
	M_DarkSlateGray = RGB(47, 79, 79) --深青色
	M_DarkRed = RGB(139, 0, 0) -- 深红
	M_DarkOrange = RGB(255, 140, 0) --深橘色
	M_Olive = RGB(128, 128, 0) --橄榄色
	M_Green = RGB(0, 128, 0) --绿
	M_Teal = RGB(0, 128, 128) --水绿
	M_Blue = RGB(0, 0, 255) --蓝
	M_SlateGray = RGB(112, 128, 144) --灰石
	M_DimGray = RGB(105, 105, 105) --暗灰
	M_Red = RGB(255, 0, 0) --红
	M_SandyBrown = RGB(244, 164, 96) --黄褐色
	M_YellowGreen = RGB(154, 205, 50) --黄绿
	M_SeaGreen = RGB(46, 139, 87) --海绿
	M_MediumTurquoise = RGB(72, 209, 204) --宝石绿
	M_RoyalBlue = RGB(65, 105, 225) --宝蓝色
	M_Purple = RGB(128, 0, 128) -- 紫
	M_Gray = RGB(128, 128, 128) --灰
	M_Magenta = RGB(255, 0, 255) --洋红
	M_Orange = RGB(255, 165, 0) --橘色
	M_Yellow = RGB(255, 255, 0) --黄
	M_Lime = RGB(0, 255, 0)  --石灰
	M_Cyan = RGB(0, 255, 255) --青色/蓝绿
	M_DeepSkyBlue = RGB(0, 191, 255) --深天蓝
	M_DarkOrchid = RGB(153, 50, 204) --深兰花紫 
	M_Silver = RGB(192, 192, 192) --银色
	M_Pink = RGB(255, 192, 203) -- 粉
	M_Wheat = RGB(245, 222, 179) --小麦色
	M_Wheat2 = RGB(205, 182, 139) --小麦色
	M_LemonChiffon = RGB(255, 250, 205) --柠檬色
	M_PaleGreen = RGB(152, 251, 152) -- 苍绿
	M_PaleTurquoise = RGB(175, 238, 238) -- 宝石绿
	M_LightBlue = RGB(173, 216, 230)   --浅蓝
	M_Plum = RGB(221, 160, 221) --紫红葡萄
	M_White = RGB(255, 255, 255) --白
	MilkWhite =RGB(255, 255, 204)  --奶白
	LimeGreen = RGB(100,200, 90) -- 灰灰绿
	Lime = RGB(0,255,0) --石灰
	LightGreen = RGB(144,238,144)  --浅绿 --6阶
	LightSkyBlue = RGB(135,206,250) --深空蓝
	green1 = RGB(145, 235, 45)  --绿色1
	OliveDrab = RGB(107, 142, 35) --绿褐色
	Snow3 = RGB(205, 201, 201) --雪银
	grey21 = RGB(54, 54, 54)  --灰
	LightSlateBlue = RGB(132, 112, 255) -- 浅石蓝
	Violet = RGB(208, 152, 208) -- 紫罗兰
	PinkRed = RGB(255, 102, 102) --粉红
	LightPurple = RGB(165, 28, 218) --深紫
	Color_Hurt1 = RGB(255, 215, 0) --金
	TG_Red = RGB(216, 20, 24) --红色
	TG_Red_Bright = RGB(248, 40, 44) --亮红
	Dark_Gold = RGB(216, 180, 20) -- 黑金
	S_Yellow = RGB(245, 215, 15) --深黄
	LightYellow = RGB(255, 242, 204)  --浅黄
	LightYellow2 = RGB(255, 229, 153)  --浅黄
	LightYellow3 = RGB(255, 217, 102)  --浅黄2

	-- 游戏状态定义
    GAME_START =0       --开始画面
    GAME_FIRSTMMAP = 1  --第一次显示主地图
    GAME_MMAP =2;       --主地图
    GAME_FIRSTSMAP = 3  --第一次显示主地图
    GAME_SMAP =4;       --场景地图
    GAME_WMAP =5;       --战斗地图
	GAME_DEAD =6;       --死亡画面
    GAME_END  =7;       --结束
    GAME_NEWNAME = 8;		--开启新游戏
	
	
	--游戏数据全局变量
	CC={};				--定义游戏中使用的常量，这些可以在修改游戏时修改之

	--实际的屏幕宽度与高度
	CC.ScreenW=lib.GetScreenW();		--显示窗口宽高
	--CC.窗口宽度=lib.GetScreenW();		--显示窗口宽高
   -- CC.窗口高度=lib.GetScreenH();
	CC.ScreenH=lib.GetScreenH();
	CC.FONT0 = CONFIG.CurrentPath.."FONT/0.ttf"
	CC.FONT1 = CONFIG.CurrentPath.."FONT/1.ttf"
	CC.FONT2 = CONFIG.CurrentPath.."FONT/2.ttf"
	CC.FONT3 = CONFIG.CurrentPath.."FONT/3.ttf"
	CC.FONT4 = CONFIG.CurrentPath.."FONT/4.ttf"
	CC.FONT5 = CONFIG.CurrentPath.."FONT/5.ttf"

	CC.SrcCharSet=0;					--源代码的字符集 0 gb  1 big5，用于转换R×。 如果源码被转换为big5，则应设为1
	CC.RCharSet=1;					--R文件字符集，0为GBK，1为BIG5
	CC.OSCharSet=CONFIG.CharSet;		--OS 字符集，-1 系统判断，0 GB, 1 Big5
	CC.FontName=CONFIG.FontName;		--显示字体
	CC.WX = CC.ScreenW/CC.ScreenW;
	CC.HY = CC.ScreenH/CC.ScreenH;
	--定义记录文件名。S和D由于是固定大小，因此不再定义idx了。
	CC.R_IDXFilename = {[0] = CONFIG.DataPath .. "ranger.idx"}
	CC.R_GRPFilename = {[0] = CONFIG.DataPath .. "ranger.grp"}
	CC.S_Filename = {[0] = CONFIG.DataPath .. "allsin.grp"}
	CC.D_Filename = {[0] = CONFIG.DataPath .. "alldef.grp"}
	
	CC.SavePath = CONFIG.CurrentPath .. "save/";
	CC.R_GRP = CC.SavePath.."r%d.grp"
	CC.S_GRP = CC.SavePath.."s%d.grp"
	CC.D_GRP = CC.SavePath.."d%d.grp"
	CC.CS = CC.SavePath.."tjm"
	CC.SaveNum = 10;			--存档数量为10

	CC.TempS_Filename=CONFIG.DataPath .. "allsinbk.grp";

	CC.PaletteFile=CONFIG.DataPath .. "mmap.col";
   
    CC.GAMESTARTFile = CONFIG.PicturePath .. "GAMESTAR.png";
    CC.SayBoxNMFile=CONFIG.PicturePath .. "sayboxnm.png";  
    CC.SayBoxFile=CONFIG.PicturePath .. "saybox.png";
	CC.BG01File=CONFIG.PicturePath .. "bg01.png";
	CC.FirstFile=CONFIG.PicturePath .. "title.png";
	CC.DeadFile=CONFIG.PicturePath .. "dead.png";
    CC.JYXXFile=CONFIG.PicturePath .. "jyxx.png";
	CC.MMapFile={CONFIG.DataPath .. "earth.002",
				CONFIG.DataPath .. "surface.002",
				CONFIG.DataPath .. "building.002",
		        CONFIG.DataPath .. "buildx.002",
				CONFIG.DataPath .. "buildy.002",
				CONFIG.DataPath .. "addition.002",
				CONFIG.DataPath .. "event.002",
				};			
	CC.PTGIF1 = CONFIG.PicturePath .. "191.png";
	CC.PTGIF2 = CONFIG.PicturePath .. "192.png";
	CC.PTGIF3 = CONFIG.PicturePath .. "193.png";
	CC.PTGIF4 = CONFIG.PicturePath .. "194.png";
	CC.PTGIF5 = CONFIG.PicturePath .. "195.png";
	CC.PTGIF6 = CONFIG.PicturePath .. "196.png";
	--各种贴图文件名。这里只给出文件名，扩展名必须为idx/grp
	CC.MMAPPicFile = {CONFIG.DataPath .. "mmap.idx", CONFIG.DataPath .. "mmap.grp"}
	CC.SMAPPicFile = {CONFIG.DataPath .. "smap.idx", CONFIG.DataPath .. "smap.grp"}
	CC.WMAPPicFile = {CONFIG.DataPath .. "wmap.idx", CONFIG.DataPath .. "wmap.grp"}
	CC.EFTFile = {CONFIG.DataPath .. "eft.idx", CONFIG.DataPath .. "eft.grp"}
	CC.BJ = {CONFIG.DataPath .. "bj.idx", CONFIG.DataPath .. "bj.grp"}
	CC.FightPicFile = {CONFIG.DataPath .. "fight/fight%03d.idx", CONFIG.DataPath .. "fight/fight%03d.grp"}

	CC.BodyPath = CONFIG.DataPath .. "body";
	CC.BodyNum = 1110;
	CC.HeadPath = CONFIG.DataPath .. "head";
	CC.HeadNum = 1600;
	CC.ThingPicFile = {CONFIG.DataPath .. "thing.idx", CONFIG.DataPath .. "thing.grp"}
	CC.ThingPath = CONFIG.DataPath .. "thing";
	CC.ThingNum = 1000;
	CC.IconPath = CONFIG.DataPath .. "icons";
	CC.IconNum = 1010;
  	CC.XTPath = CONFIG.DataPath .. "xt";  
	CC.XTNum = 1100;	
	CC.UIPath = CONFIG.DataPath .. "ui";
	CC.UINum = 2000;
	CC.TFPath = CONFIG.DataPath .. "tf";
	CC.TFNum = 1900;

	CC.PTPath = CONFIG.DataPath .. "portrait";
    CC.PTNum = 1100;
    
	CC.kaijuwugong1 = 0
	CC.kaijuwugong2 = 0
	CC.kaijuwugong3 = 0
	CC.kaijuwugongx1 = 0
	CC.kaijuwugongx2 = 0
	CC.kaijuwugongx3 = 0
	--开局开赋选择
	CC.TF_Start = {}

    --人物总数量
    CC.PerNum = 1000;
    
	if CONFIG.MP3 == 1 then
		CC.MIDIFile=CONFIG.SoundPath .. "game%02d.mp3";
	else
		CC.MIDIFile=CONFIG.SoundPath .. "game%02d.mid";
	end
	CC.OGGFile=CONFIG.SoundPath .. "game%02d.ogg";
	CC.ATKFile=CONFIG.SoundPath .. "atk%02d.wav";
	CC.EFile=CONFIG.SoundPath .. "e%02d.wav";

	CC.WarFile=CONFIG.DataPath .. "war.sta";
	CC.WarMapFile={CONFIG.DataPath .. "warfld.idx",
                  CONFIG.DataPath .. "warfld.grp"};

	CC.TRP = CONFIG.DataPath.."talk.grp"
	CC.TDX = CONFIG.DataPath.."talk.idx"
	
	CC.Acvmts = CONFIG.DataPath .. "achievements"
	--CC.Qixue = CONFIG.DataPath .. "Qixue"

	--定义记录文件R×结构。  lua不支持结构，无法直接从二进制文件中读取，因此需要这些定义，用table中不同的名字来仿真结构。
	CC.TeamNum=15;          --队伍人数
	--CC.队伍人数 = 15        --队伍人数
	CC.MyThingNum=900      --主角物品数量
	--CC.已有物品数理=600      --主角物品数量
	CC.Week = 1
	--CC.ItemInfoPath = CONFIG.ScriptPath .. "ItemInfo/"
	CC.TJMSJ = {} 
	CC.TJM = 0
    CC.HSLJ = {}
	CC.HSLJ2 = {}	
	
	CC.CHENGJIU = {}
	CC.CHENGJIUNUM = 0
	CC.CHUANSONG = 1
	--游历人物
	CC.YOULI = {}
	for i = 1,5 do 
		CC.YOULI[i] = 0
	end
	CC.YOULI_1 = 0
	CC.YOULI_2 = 0
	CC.YOULI_3 = 0
	CC.YOULI_4 = 0
	CC.YOULI_5 = 0
	CC.JHtxt = {} -- 游事件类类型 1获得属性 2打通经脉 3领悟秘技 4领悟天赋
	CC.JHtxt_ID = {} --游历事件ID
	CC.JHtxt_EVENT = {} --游历事件 类型一{1,'游玩', 2'探险', 3'切磋武艺'}, --类型二{4闭关修炼} ,--类型三{5领悟秘技},--类型四{6领悟天赋}
	CC.JHtxt_ID1 = {} --游历交互人物
	CC.JHtxt_SCENE = {}  --游历场景
	CC.JHtxt_TIME = {} --游历时间
	CC.JHtxt_PSX = {}  --增加的属性类型  1攻击力,2防御力 3轻功 4用毒能力  5暗器技巧 6拳掌功夫 7指法技巧 8御剑能力 9耍刀技巧 10特殊兵器'
						--				20 
						--
	CC.JHtxt_POINTS= {} --增加属性的点数  1001'手少阴经', 1002'手太阴经', 1003'手厥阴经', 1004'手少阳经', 1005'手太阳经',1006'手阳明经', 
										--1007'足少阴经', 1008'足太阴经', 1009'足厥阴经', 1010'足少阳经', 1011'足太阳经', 1012'足阳明经', 
										--1013'任脉', 1014'督脉'
	CC.JHtxt_YEAR = {}
	CC.JHtxt_MONTH = {}
	CC.JHtxt_DAY = {}								

	--版本号
	CC.Version="版本 1.07正式版V2.3"
	local Color_Switch={{"Ｒ",PinkRed},{"Ｇ",M_Wheat},{"Ｂ",C_BLACK},{"Ｗ",RGB(178,158,124)},{"Ｏ",C_ORANGE},{"Ｌ",LimeGreen},{"Ｄ",M_DeepSkyBlue},{"Ｚ",Violet}}
	local T3={{"Ｈ",CC.FontNameSong},{"Ｓ",CC.FontNameHei},{"Ｆ",CC.FontName}} 

	--动态显示提示
	CC.Timer={
						stime=0,
						status=0,
						str='',
						len=0,
						fun=demostr,
					};
	--动态显示的内容
	CC.RUNSTR={
		'快捷键 R-任务 C-图签攻略 Z游戏信息 F1-地图 F1-读档 F2-存档 F3-队列 F4-整理物品 H-回家',
		'多培养一些队友，可以让你后面的战斗更轻松',
		'千年灵芝是能增加体质的药品，人物体质跟主运内功决定人物生命最大值，一般人体质最多可以提升到12点',
		'更新下载问题反馈请加 QQ群号：198045761',
		'小村的厨灶和炼丹炉可以制作药品',
		'听说还施水阁有人想用武功秘籍换秘籍残章',
		'主运内功能给同门派的外功加成威力，获得更高的门派贡献也能增加门派武功的威力。',
		'双儿处可以切换地图传送/文字传送，还可以开关地图城镇传送，周目商店中有出售珍贵物品。',
		'每月的初九和十九在江陵有比武举行。西域商人会不定期出现在扬州，出售获得的过的物品。',
		'心魔和夜幕在神秘少女处可以开关。'
		};
	rest()
	




	CC.Base_S={};         --保存基本数据的结构，以便以后存取
	CC.Base_S["乘船"]={0,0,2}   -- 起始位置(从0开始)，数据类型(0有符号 1无符号，2字符串)，长度
	CC.Base_S["无用"]={2,0,2}; --判定大地图小地图场景
	CC.Base_S["人X"]={4,0,2};
	CC.Base_S["人Y"]={6,0,2};
	CC.Base_S["人X1"]={8,0,2};
	CC.Base_S["人Y1"]={10,0,2};
	CC.Base_S["人方向"]={12,0,2};
	CC.Base_S["船X"]={14,0,2};
	CC.Base_S["秒"]={16,0,2};
	CC.Base_S["时"]={18,0,2};
	CC.Base_S["分"]={20,0,2};
	CC.Base_S["船方向"]={22,0,2}; --用于自动存档计算
	CC.Base_S["难度"]={24,0,2};
	CC.Base_S["标准"]={26,0,2};
	CC.Base_S["畅想"]={28,0,2};
	CC.Base_S["特殊"]={30,0,2};
	CC.Base_S["单通"]={32,0,2};
	CC.Base_S["周目"]={34,0,2};
	CC.Base_S["天书数量"]={36,0,2};
	CC.Base_S["武功数量"]={38,0,2};
	CC.Base_S["碎片"]={40,0,2};	
	CC.Base_S["游戏模式"]={42,0,2};	
	CC.Base_S["天关"]={44,0,2};	
	CC.Base_S["开局"]={46,0,2};	
	CC.Base_S["剧情"]={48,0,2};	
	CC.Base_S["妻子"]={50,0,2};	
	CC.Base_S["孩子"]={52,0,2};
	CC.Base_S["结婚时间"]={54,0,2};
	CC.Base_S["生子时间"]={56,0,2};
	CC.Base_S["存档月"]={58,0,2}; --存档时间月
	CC.Base_S["天气"]={60,0,2};
	CC.Base_S["天气持续"]={62,0,2};
	CC.Base_S["存档日"]={64,0,2}; ----存档时间日
	CC.Base_S["备用2"]={66,0,2}; --游戏时间
	CC.Base_S["存档时"]={68,0,2};--存档时间时
	CC.Base_S["存档分"]={70,0,2};--存档时间分
	for i=1,CC.TeamNum do
		CC.Base_S["队伍" .. i]={72+2*(i-1),0,2};
	end

	for i=1,CC.MyThingNum do
		CC.Base_S["物品" .. i]={102+4*(i-1),0,2};
		CC.Base_S["物品数量" .. i]={102+4*(i-1)+2,0,2};
	end

	--人物	
   CC.PersonSize=1278;   --每个人物数据占用字节
    CC.Person_S={};      --保存人物数据的结构，以便以后存取
	CC.Person_S["代号"]={0,0,2}
	--CC.代号={0,0,2}
    CC.Person_S["头像代号"]={2,0,2}
    CC.Person_S["体质"]={4,0,2}
    CC.Person_S["无用"]={6,0,2}
    CC.Person_S["姓名"]={8,2,10}
    CC.Person_S["外号"]={18,2,10}
    CC.Person_S["性别"]={28,0,2}
    CC.Person_S["等级"]={30,0,2}
    CC.Person_S["经验"]={32,1,2}
    CC.Person_S["生命"]={34,0,2}
    CC.Person_S["生命最大值"]={36,0,2}
    CC.Person_S["受伤程度"]={38,0,2}
    CC.Person_S["中毒程度"]={40,0,2}
    CC.Person_S["体力"]={42,0,2}
    CC.Person_S["物品修炼点数"]={44,1,2}
    CC.Person_S["武器"]={46,0,2}
    CC.Person_S["防具"]={48,0,2}

	for i=1,5 do
		CC.Person_S["出招动画帧数" .. i]={50+2*(i-1),0,2};
        CC.Person_S["出招动画延迟" .. i]={60+2*(i-1),0,2};
        CC.Person_S["武功音效延迟" .. i]={70+2*(i-1),0,2};
	end

    CC.Person_S["内力性质"]={80,0,2}
    CC.Person_S["内力"]={82,0,2}
    CC.Person_S["内力最大值"]={84,0,2}
    CC.Person_S["攻击力"]={86,0,2}
    CC.Person_S["轻功"]={88,0,2}
    CC.Person_S["防御力"]={90,0,2}
    CC.Person_S["医疗能力"]={92,0,2}
    CC.Person_S["用毒能力"]={94,0,2}
    CC.Person_S["解毒能力"]={96,0,2}
    CC.Person_S["抗毒能力"]={98,0,2}
    CC.Person_S["拳掌功夫"]={100,0,2}
	CC.Person_S["指法技巧"]={102,0,2}
    CC.Person_S["御剑能力"]={104,0,2}
    CC.Person_S["耍刀技巧"]={106,0,2}
    CC.Person_S["特殊兵器"]={108,0,2}
    CC.Person_S["暗器技巧"]={110,0,2}
    CC.Person_S["武学常识"]={112,0,2}
    CC.Person_S["品德"]={114,0,2}
    CC.Person_S["攻击带毒"]={116,0,2}
    CC.Person_S["左右互搏"]={118,0,2}
    CC.Person_S["声望"]={120,0,2}
    CC.Person_S["资质"]={122,0,2}
    CC.Person_S["修炼物品"]={124,0,2}
    CC.Person_S["修炼点数"]={126,0,2}

    for i=1,15 do
       CC.Person_S["武功" .. i]={128+2*(i-1),0,2};
        CC.Person_S["武功等级" .. i]={158+2*(i-1),0,2};
    end

    for i=1,4 do
        CC.Person_S["携带物品" .. i]={188+2*(i-1),0,2};
        CC.Person_S["携带物品数量" .. i]={196+2*(i-1),0,2};
    end
	
	for i=1,2 do
		CC.Person_S["天赋外功"..i]={204+2*(i-1),0,2};
	end
	CC.Person_S["属性点数"]={208,0,2}
	CC.Person_S["武学点数"]={210,0,2}
	CC.Person_S["天赋内功"]={212,0,2}
	CC.Person_S["天赋轻功"]={214,0,2}
	CC.Person_S["实战"]={216,0,2}
	CC.Person_S["出战"]={218,0,2}
	CC.Person_S["命中"]={220,0,2}
	CC.Person_S["主运内功"]={222,0,2}
	CC.Person_S["主运轻功"]={224,0,2}
	CC.Person_S["六如觉醒"]={226,0,2}
	CC.Person_S["个人觉醒"]={228,0,2}
	CC.Person_S["畅想分阶"]={230,0,2}
	CC.Person_S["外号2"]={232,2,10}
	CC.Person_S["冰封程度"]={242,0,2}
	CC.Person_S["好感"]={244,0,2}
	CC.Person_S["闪避"]={246,0,2}
	CC.Person_S["灼烧程度"]={248,0,2}
	CC.Person_S["行为模式"]={250,0,2}
	CC.Person_S["优先使用"]={252,0,2}
	CC.Person_S["是否吃药"]={254,0,2}
	CC.Person_S["能量"]={256,0,2}
	CC.Person_S["格档"]={258,0,2}
	CC.Person_S["特色指令"]={260,0,2}
	CC.Person_S["坐骑"]={262,0,2}
	CC.Person_S["中庸"]={264,0,2}
	CC.Person_S["半身像"]={266,0,2}
	CC.Person_S["门派贡献"]={268,0,2}
	CC.Person_S["门派"]={270,0,2}
	CC.Person_S["心魔"]={272,0,2}
	CC.Person_S["拳法成长"]={274,0,2}		
	CC.Person_S["指法成长"]={276,0,2}	
	CC.Person_S["剑法成长"]={278,0,2}
	CC.Person_S["刀法成长"]={280,0,2}
	CC.Person_S["奇门成长"]={282,0,2}
	CC.Person_S["暗器成长"]={284,0,2}
	CC.Person_S["招式方针"]={286,0,2}
	CC.Person_S["行动方针"]={288,0,2}
	CC.Person_S["施毒方针"]={290,0,2}
	CC.Person_S["暗器方针"]={292,0,2}
	CC.Person_S["吃红药方针"]={294,0,2}
	CC.Person_S["吃蓝药方针"]={296,0,2}
	CC.Person_S["吃黄药方针"]={298,0,2}
	CC.Person_S["复活方针"]={300,0,2}
	CC.Person_S["喝酒方针"]={302,0,2}
	CC.Person_S["备用方针1"]={304,0,2}
	CC.Person_S["备用方针2"]={306,0,2}
	CC.Person_S["备用方针3"]={308,0,2}

	for i = 1,6 do
		CC.Person_S["手厥阴"..i]={310+2*(i-1),0,2};
	end		
	for i = 1,6 do
		CC.Person_S["手少阳"..i]={322+2*(i-1),0,2};
	end	
	for i = 1,6 do
		CC.Person_S["手太阳"..i]={334+2*(i-1),0,2};
	end	
	for i = 1,6 do
		CC.Person_S["手阳明"..i]={346+2*(i-1),0,2};
	end				
	for i = 1,6 do
		CC.Person_S["足少阴"..i]={358+2*(i-1),0,2};
	end					
	for i = 1,6 do
		CC.Person_S["足太阴"..i]={370+2*(i-1),0,2};
	end			
	for i = 1,6 do
		CC.Person_S["足阴厥"..i]={382+2*(i-1),0,2};
	end					
	for i = 1,6 do
		CC.Person_S["足少阳"..i]={394+2*(i-1),0,2};
	end				
	for i = 1,6 do
		CC.Person_S["足太阳"..i]={406+2*(i-1),0,2};
	end			
	for i = 1,6 do
		CC.Person_S["足阳明"..i]={418+2*(i-1),0,2};
	end		
	for i = 1,6 do
		CC.Person_S["任脉"..i]={440+2*(i-1),0,2};
	end				
	for i = 1,6 do
		CC.Person_S["督脉"..i]={452+2*(i-1),0,2};
	end			


	for i = 1,17 do
		CC.Person_S["御剑奇穴等级"..i]={474+2*(i-1),0,2};
	end	
	CC.Person_S["基础生命"]={508,0,2}
	CC.Person_S["基础内力"]={510,0,2}
	CC.Person_S["喜好"]={512,0,2}
	CC.Person_S["天书"]={514,0,2} --0传1飞2雪3连4天5射6白7鹿8笑9书10神11侠12倚13碧14鸳
	CC.Person_S["精通武功"]={516,0,2}
	CC.Person_S["天赋1"]={518,0,2}
	CC.Person_S["天赋2"]={520,0,2}
	CC.Person_S["天赋3"]={522,0,2}
	CC.Person_S["天赋4"]={524,0,2}
	CC.Person_S["天赋5"]={526,0,2}
	CC.Person_S["掌门"]={528,0,2}
	CC.Person_S["健康"]={530,0,2}
	CC.Person_S["游历次数"]={532,0,2}
	CC.Person_S["游历"]={534,0,2}

	for i = 22,25 do
		CC.Person_S["御剑奇穴等级"..i]={536+2*(i-21),0,2};
	end	
	for i = 21,25 do
		CC.Person_S["耍刀奇穴等级"..i]={544+2*(i-21),0,2};
	end	
	for i = 21,25 do
		CC.Person_S["奇门奇穴等级"..i]={554+2*(i-21),0,2};
	end			
	for i = 21,25 do
		CC.Person_S["内功奇穴等级"..i]={564+2*(i-21),0,2};
	end	
	for i = 1,150 do
		CC.Person_S["武功招式"..i]={574+2*(i-1),0,2};
	end	
	for i = 1,10 do
		CC.Person_S["秘技"..i]={874+2*(i-1),0,2};
	end
	CC.Person_S["手少阴经顺通"]={894,0,2}
	CC.Person_S["手太阴经顺通"]={896,0,2}
	CC.Person_S["手厥阴经顺通"]={898,0,2}
	CC.Person_S["手少阳经顺通"]={900,0,2}
	CC.Person_S["手太阳经顺通"]={902,0,2}
	CC.Person_S["手阳明经顺通"]={904,0,2}
	CC.Person_S["足少阴经顺通"]={906,0,2}
	CC.Person_S["足太阴经顺通"]={908,0,2}
	CC.Person_S["足厥阴经顺通"]={910,0,2}
	CC.Person_S["足少阳经顺通"]={912,0,2}
	CC.Person_S["足太阳经顺通"]={914,0,2}
	CC.Person_S["足阳明经顺通"]={916,0,2}
	CC.Person_S["任脉顺通"]={918,0,2}
	CC.Person_S["督脉顺通"]={920,0,2}	
	CC.Person_S["手少阴经逆通"]={922,0,2}
	CC.Person_S["手太阴经逆通"]={924,0,2}
	CC.Person_S["手厥阴经逆通"]={926,0,2}
	CC.Person_S["手少阳经逆通"]={928,0,2}
	CC.Person_S["手太阳经逆通"]={930,0,2}
	CC.Person_S["手阳明经逆通"]={932,0,2}
	CC.Person_S["足少阴经逆通"]={934,0,2}
	CC.Person_S["足太阴经逆通"]={936,0,2}
	CC.Person_S["足厥阴经逆通"]={938,0,2}
	CC.Person_S["足少阳经逆通"]={940,0,2}
	CC.Person_S["足太阳经逆通"]={942,0,2}
	CC.Person_S["足阳明经逆通"]={944,0,2}	
	CC.Person_S["任脉逆通"]={946,0,2}
	CC.Person_S["督脉逆通"]={948,0,2}	
	for i = 1,164 do
		CC.Person_S["奇穴"..i]={950+(i-1)*2,0,2}
	end	
	
	--物品
    CC.ThingSize=206;   --每个物品数据占用字节
    CC.Thing_S={};
    CC.Thing_S["代号"]={0,0,2}
    CC.Thing_S["名称"]={2,2,20}
    CC.Thing_S["名称2"]={22,2,20}
    CC.Thing_S["物品说明"]={42,2,30}
    CC.Thing_S["练出武功"]={72,0,2}
    CC.Thing_S["暗器动画编号"]={74,0,2}
    CC.Thing_S["使用人"]={76,0,2}
    CC.Thing_S["装备位置"]={78,0,2}
    CC.Thing_S["显示物品说明"]={80,0,2}
    CC.Thing_S["类型"]={82,0,2}
    CC.Thing_S["礼物类型"]={84,0,2}
    CC.Thing_S["加命中"]={86,0,2}
    CC.Thing_S["加格档"]={88,0,2}
    CC.Thing_S["加生命"]={90,0,2}
    CC.Thing_S["加生命最大值"]={92,0,2}
    CC.Thing_S["加中毒解毒"]={94,0,2}
    CC.Thing_S["加体力"]={96,0,2}
    CC.Thing_S["改变内力性质"]={98,0,2}
    CC.Thing_S["加内力"]={100,0,2}
    CC.Thing_S["加内力最大值"]={102,0,2}
    CC.Thing_S["加攻击力"]={104,0,2}
    CC.Thing_S["加轻功"]={106,0,2}
    CC.Thing_S["加防御力"]={108,0,2}
    CC.Thing_S["加医疗能力"]={110,0,2}
    CC.Thing_S["加用毒能力"]={112,0,2}
    CC.Thing_S["加解毒能力"]={114,0,2}
    CC.Thing_S["加抗毒能力"]={116,0,2}
    CC.Thing_S["加拳掌功夫"]={118,0,2}
	CC.Thing_S["加指法技巧"]={120,0,2}	
    CC.Thing_S["加御剑能力"]={122,0,2}
    CC.Thing_S["加耍刀技巧"]={124,0,2}
    CC.Thing_S["加特殊兵器"]={126,0,2}
    CC.Thing_S["加暗器技巧"]={128,0,2}
    CC.Thing_S["加武学常识"]={130,0,2}
    CC.Thing_S["加品德"]={132,0,2}

    CC.Thing_S["加攻击次数"]={134,0,2}
    CC.Thing_S["加攻击带毒"]={136,0,2}
    CC.Thing_S["仅修炼人物"]={138,0,2}
    CC.Thing_S["需内力性质"]={140,0,2}
    CC.Thing_S["需内力"]={142,0,2}
    CC.Thing_S["需攻击力"]={144,0,2}
    CC.Thing_S["需轻功"]={146,0,2}
    CC.Thing_S["需用毒能力"]={148,0,2}
    CC.Thing_S["需医疗能力"]={150,0,2}
    CC.Thing_S["加体质"]={152,0,2}
    CC.Thing_S["需拳掌功夫"]={154,0,2}	
	CC.Thing_S["需指法技巧"]={156,0,2}	
    CC.Thing_S["需御剑能力"]={158,0,2}
    CC.Thing_S["需耍刀技巧"]={160,0,2}
    CC.Thing_S["需特殊兵器"]={162,0,2}
    CC.Thing_S["需暗器技巧"]={164,0,2}

    CC.Thing_S["需资质"]={166,0,2}
    CC.Thing_S["需经验"]={168,0,2}
    CC.Thing_S["练出物品需经验"]={170,0,2}
    CC.Thing_S["需材料"]={172,0,2}

    for i=1,5 do
		CC.Thing_S["练出物品" .. i]={174+2*(i-1),0,2};
		CC.Thing_S["需要物品数量" .. i]={184+2*(i-1),0,2};
	end
	 
	CC.Thing_S["是否特效"]={194,0,2}
	CC.Thing_S["装备经验"]={196,0,2}
	CC.Thing_S["装备等级"]={198,0,2}
	CC.Thing_S["装备系别"]={200,0,2}
	CC.Thing_S["加招架"]={202,0,2}
	CC.Thing_S["练出秘技"]={204,0,2}



    CC.SceneSize=54;   --每个场景数据占用字节
    CC.Scene_S={};
    CC.Scene_S["代号"]={0,0,2}
    CC.Scene_S["名称"]={2,2,10}
    CC.Scene_S["出门音乐"]={12,0,2}
    CC.Scene_S["进门音乐"]={14,0,2}
    CC.Scene_S["跳转场景"]={16,0,2}
    CC.Scene_S["进入条件"]={18,0,2}
    CC.Scene_S["外景入口X1"]={20,0,2}
    CC.Scene_S["外景入口Y1"]={22,0,2}
    CC.Scene_S["外景入口X2"]={24,0,2}
    CC.Scene_S["外景入口Y2"]={26,0,2}
    CC.Scene_S["入口X"]={28,0,2}
    CC.Scene_S["入口Y"]={30,0,2}
    CC.Scene_S["出口X1"]={32,0,2}
    CC.Scene_S["出口X2"]={34,0,2}
    CC.Scene_S["出口X3"]={36,0,2}
    CC.Scene_S["出口Y1"]={38,0,2}
    CC.Scene_S["出口Y2"]={40,0,2}
    CC.Scene_S["出口Y3"]={42,0,2}
    CC.Scene_S["跳转口X1"]={44,0,2}
    CC.Scene_S["跳转口Y1"]={46,0,2}
    CC.Scene_S["跳转口X2"]={48,0,2}
    CC.Scene_S["跳转口Y2"]={50,0,2}
	CC.Scene_S["场景类型"]={52,0,2}

    CC.WugongSize=190;   --每个武功数据占用字节
    CC.Wugong_S={};
    CC.Wugong_S["代号"]={0,0,2}
    CC.Wugong_S["名称"]={2,2,10}
    CC.Wugong_S["未知1"]={12,0,2}
    CC.Wugong_S["未知2"]={14,0,2}
    CC.Wugong_S["未知3"]={16,0,2}
    CC.Wugong_S["未知4"]={18,0,2}
    CC.Wugong_S["未知5"]={20,0,2}
    CC.Wugong_S["出招音效"]={22,0,2}
    CC.Wugong_S["武功类型"]={24,0,2}
    CC.Wugong_S["武功动画&音效"]={26,0,2}
    CC.Wugong_S["伤害类型"]={28,0,2}
    CC.Wugong_S["攻击范围"]={30,0,2}
    CC.Wugong_S["消耗内力点数"]={32,0,2}
    CC.Wugong_S["敌人中毒点数"]={34,0,2}
    for i=1,10 do
		CC.Wugong_S["攻击力" .. i]={36+2*(i-1),0,2};
		CC.Wugong_S["移动范围" .. i]={56+2*(i-1),0,2};
		CC.Wugong_S["杀伤范围" .. i]={76+2*(i-1),0,2};
		CC.Wugong_S["加内力" .. i]={96+2*(i-1),0,2};
		CC.Wugong_S["杀内力" .. i]={116+2*(i-1),0,2};
    end	 
	CC.Wugong_S["冰封系数"]={136,0,2}
	CC.Wugong_S["灼烧系数"]={138,0,2}
    CC.Wugong_S["门派"]={140,0,2}
    CC.Wugong_S["加格档"]={142,0,2}
	CC.Wugong_S["加闪避"]={144,0,2}	
	CC.Wugong_S["加命中"]={146,0,2}
	CC.Wugong_S["层级"]={148,0,2}
	CC.Wugong_S["特效1"]={150,0,2}
	CC.Wugong_S["特效2"]={152,0,2}
	CC.Wugong_S["特效3"]={154,0,2}
	CC.Wugong_S["特效4"]={156,0,2}
	CC.Wugong_S["特效5"]={158,0,2}
	CC.Wugong_S["特效6"]={160,0,2}
	CC.Wugong_S["特效7"]={162,0,2}
	CC.Wugong_S["特效8"]={164,0,2}
	CC.Wugong_S["特效9"]={166,0,2}
	CC.Wugong_S["特效10"]={168,0,2}
	CC.Wugong_S["招式1"]={170,0,2}
	CC.Wugong_S["招式2"]={172,0,2}	
	CC.Wugong_S["招式3"]={174,0,2}	
	CC.Wugong_S["招式4"]={176,0,2}	
	CC.Wugong_S["招式5"]={178,0,2}	
	CC.Wugong_S["招式6"]={180,0,2}	
	CC.Wugong_S["招式7"]={182,0,2}	
	CC.Wugong_S["招式8"]={184,0,2}	
	CC.Wugong_S["招式9"]={186,0,2}	
	CC.Wugong_S["招式10"]={188,0,2}		

	CC.ShopSize=36;   --每个小宝商店数据占用字节
	CC.Shop_S={};
	for i=1,6 do
		CC.Shop_S["物品" .. i]={0+2*(i-1),0,2};
		CC.Shop_S["物品数量" .. i]={12+2*(i-1),0,2};
		CC.Shop_S["物品价格" .. i]={24+2*(i-1),0,2};
	end

	CC.TejiSize = 36 --每个特技占用数据占用字节
	CC.Teji_S = {};
    CC.Teji_S["代号"]={0,0,2}
    CC.Teji_S["名称"]={2,2,10}
    CC.Teji_S["武功数量"]={12,0,2}
	CC.Teji_S["秘技组合"]={14,0,2}
	CC.Teji_S["备用2"]={16,0,2}
	CC.Teji_S["备用3"]={18,0,2}
	CC.Teji_S["备用4"]={20,0,2}
	CC.Teji_S["备用5"]={22,0,2}
	CC.Teji_S["备用6"]={24,0,2}
	CC.Teji_S["组合武功1"]={26,0,2}
	CC.Teji_S["组合武功2"]={28,0,2}
	CC.Teji_S["组合武功3"]={30,0,2}
	CC.Teji_S["组合武功4"]={32,0,2}
	CC.Teji_S["组合武功5"]={34,0,2}




	CC.ShopScene={};       --小宝商店场景数据，sceneid 场景id，d_shop 小宝位置D*, d_leave 小宝离开D*，一般在场景出口，路过触发
	CC.ShopScene[0]={sceneid=153,d_shop=16,d_leave={17,18}, };
	CC.ShopScene[1]={sceneid=3,d_shop=14,d_leave={15,16}, };
	CC.ShopScene[2]={sceneid=40,d_shop=20,d_leave={21,22}, };
	CC.ShopScene[3]={sceneid=60,d_shop=16,d_leave={17,18}, };
	CC.ShopScene[4]={sceneid=159,d_shop=9,d_leave={10,11,12}, };

	--其他常量
	CC.MWidth=480;       --主地图宽
	CC.MHeight=480;      --主地图高

	CC.SWidth=64;     --子场景地图大小
	CC.SHeight=64;

	CC.DNum=200;       --D*每个场景的事件数


	if CONFIG.Zoom > 100 then
		CC.XScale = math.modf(CONFIG.XScale*CONFIG.Zoom/100)    -- 贴图宽度的一半
		CC.YScale = math.modf(CONFIG.YScale*CONFIG.Zoom/100)     -- 贴图高度的一半
	else
		CC.XScale=CONFIG.XScale;    --贴图一半的宽高
		CC.YScale=CONFIG.YScale;   
	end

	CC.Frame=CONFIG.FrameRate;     --每帧毫秒数
	CC.BattleDelay=CONFIG.BattleDelay;     --战斗点数显示的延迟（毫秒）

	CC.Bj = CONFIG.Bj;
	CC.SceneMoveFrame=100;           --场景移动帧速，用于场景移动事件
	CC.PersonMoveFrame=100;          --主角移动速度，用于主角移动事件
	CC.AnimationFrame=150;           --动画显示帧速，用于显示动画事件

	CC.WarAutoDelay=300;                   --自动战斗时显示头像的延时

	CC.DirectX={0,1,-1,0};  --不同方向x，y的加减值，用于走路改变坐标值
	CC.DirectY={-1,0,0,1};
	
	CC.MyStartPicM=2501;      --男主角走路起始贴图
	CC.MyStartPicF=5001;      --女主角走路起始贴图
	CC.MyStartPicCG=5201;      --春哥走路起始贴图
	CC.MyStartPicLG =5346;   --顾惜朝行走起始贴图
	CC.BoatStartPic=3715;    --船起始贴图

	CC.Level=30;                  ---人物等级和每等级经验
	CC.Exp={   50,    150,     300 ,500   , 750 ,
               1050,  1400,   1800 ,2250  , 2750 ,
               3850,  5050,   6350 ,7750  , 9250 ,
               10850, 12550, 14350 ,16750 , 18250 ,
               21400, 24700, 28150 ,31750 , 35500 ,
	           39400, 43450, 47650 ,52000 , 60000 , [0] = 0 };

    CC.MMapBoat={};    --主地图船可以进入的贴图
	local tmpBoat={ {0x166,0x16a},{0x176,0x17c},{0x1ca,0x1d0},{0x1fa,0x262},{0x3f8,0x3fe},};
    for i,v in ipairs(tmpBoat) do      --把这些数据变换成数组，其中有值就是可以进入
        for j=v[1],v[2],2 do
            CC.MMapBoat[j]=1;
        end
    end
	--Alungky 解决船开到深海区时，显示为人的问题
	local tmpForbid={{0x264,0x29E}}
    for i,v in ipairs(tmpForbid) do    
        for j=v[1],v[2],2 do
			CC.MMapBoat[j]=1;
        end
    end

    CC.SceneWater={};    --场景人不能进入的贴图
    local tmpWater={ {0x166,0x16a},{0x176,0x17c},{0x1ca,0x1d0},{0x1fa,0x262},{0x332,0x338},
                     {0x346,0x346},{0x3a6,0x3a8},{0x3f8,0x3fe},{0x52c,0x544},};
    for i,v in ipairs(tmpWater) do      --把这些数据变换成数组，其中空项就是可以进入的贴图
        for j=v[1],v[2],2 do
            CC.SceneWater[j]=1;
        end
    end

    CC.WarWater={};    --战斗地图人不能进入的贴图
    local tmpWater={ {0x166,0x16a},{0x176,0x17c},{0x1ca,0x1d0},{0x1fa,0x262},{0x332,0x338},
                     {0x346,0x346},{0x3a6,0x3a8},{0x3f8,0x3fe},{0x52c,0x544},};
    for i,v in ipairs(tmpWater) do      --把这些数据变换成数组，其中空项就是可以进入的贴图
        for j=v[1],v[2],2 do
            CC.WarWater[j]=1;
        end
	end
	--江陵奖励
	CC.biwujl = 0
	--武功招式
	CC.WUGONGZS = {}

	--武功招式存档
	for i = 1,15 do
		CC.WUGONGZS[i] = {1+10*(i-1),2+10*(i-1),3+10*(i-1),4+10*(i-1),5+10*(i-1),6+10*(i-1),7+10*(i-1),8+10*(i-1),9+10*(i-1),10+10*(i-1)}
	end


	--武功招式
	CC.KFMove={}  --招式名称，威力，耗气，特效代码
		--密宗刀法
		CC.KFMove[427]={
			{'宝瓶式',400,1},
			{'银鱼式',40000,2},
			}
		--密宗心法
		CC.KFMove[426]={
			{'密宗心法',400,1},
			}
		--天机身法
		CC.KFMove[425]={
			{'天机身法',400,1},
			}			
		--草上飞
		CC.KFMove[424]={
			{'草上飞',400,1},
			}			
		--古墓身法
		CC.KFMove[423]={
			{'古墓身法',400,1},
			}			
		--五毒身法
		CC.KFMove[422]={
			{'五毒身法',400,1},
			}			
		--泰山身法
		CC.KFMove[421]={
			{'泰山身法',400,1},
			}			
		--全真身法
		CC.KFMove[420]={
			{'全真身法',400,1},
			}			
		--玉泉鱼跃
		CC.KFMove[419]={
			{'玉泉鱼跃',400,1},
			}		
		--藏剑身法
		CC.KFMove[418]={
			{'藏剑身法',400,1},
			}				
		--金刚幻相
		CC.KFMove[417]={
			{'金刚幻相',400,1},
			}		
		--密宗身法
		CC.KFMove[416]={
			{'密宗身法',400,1},
			}			
		--摘星揽月
		CC.KFMove[415]={
			{'摘星揽月',400,1},
			}			
		--星宿身法
		CC.KFMove[414]={
			{'星宿身法',400,1},
			}			
		--龙行虎步
		CC.KFMove[413]={
			{'龙行虎步',400,1},
			}		
		--天龙身法
		CC.KFMove[412]={
			{'天龙身法',400,1},
			}			
		--燕子三抄水
		CC.KFMove[411]={
			{'燕子三抄水',400,1},
			}		
		--慕容身法
		CC.KFMove[410]={
			{'慕容身法',400,1},
			}			
		--玄机步
		CC.KFMove[409]={
			{'玄机步',400,1},
			}			
		--八卦身法
		CC.KFMove[408]={
			{'八卦身法',400,1},
			}		
		--流星赶月
		CC.KFMove[407]={
			{'流星赶月',400,1},
			}			
		--横行身法
		CC.KFMove[406]={
			{'横行身法',400,1},
			}			
		--白驼身法
		CC.KFMove[405]={
			{'白驼身法',400,1},
			}			
		--登萍渡水
		CC.KFMove[404]={
			{'登萍渡水',400,1},
			}			
		--桃花身法
		CC.KFMove[403]={
			{'桃花身法',400,1},
			}			
		--雷光疾影
		CC.KFMove[402]={
			{'雷光疾影',400,1},
			}			
		--昆仑身法
		CC.KFMove[401]={
			{'昆仑身法',400,1},
			}			
		--移形换影
		CC.KFMove[400]={
			{'移形换影',400,1},
			}			
		--崆峒身法
		CC.KFMove[399]={
			{'崆峒身法',400,1},
			}			
		--云龙三现
		CC.KFMove[398]={
			{'云龙三现',400,1},
			}				
		--梅花桩
		CC.KFMove[397]={
			{'梅花桩',400,1},
			}			
		--飞鸿雪泥
		CC.KFMove[396]={
			{'飞鸿雪泥',400,1},
			}			
		--雪山身法
		CC.KFMove[395]={
			{'雪山身法',400,1},
			}			
		--踏雪无痕
		CC.KFMove[394]={
			{'踏雪无痕',400,1},
			}			
		--血刀身法
		CC.KFMove[393]={
			{'血刀身法',400,1},
			}			
		--云龙三现
		CC.KFMove[392]={
			{'云龙三现',400,1},
			}			
		--嵩山身法
		CC.KFMove[391]={
			{'嵩山身法',400,1},
			}		
		--华山身法
		CC.KFMove[390]={
			{'华山身法',400,1},
			}			
		--莲花身法
		CC.KFMove[389]={
			{'莲花身法',400,1},
			}			
		--全真身法
		CC.KFMove[388]={
			{'全真身法',400,1},
			}		
		--圣火身法
		CC.KFMove[387]={
			{'圣火身法',400,1},
			}			
		--日月身法
		CC.KFMove[386]={
			{'日月身法',400,1},
			}			
		--逍遥身法
		CC.KFMove[385]={
			{'逍遥身法',400,1},
			}			
		--少林身法
		CC.KFMove[384]={
			{'少林身法',400,1},
			}		
		--武当身法
		CC.KFMove[383]={
			{'武当身法',400,1},
			}					
		--屠龙刀法
		CC.KFMove[382]={
			{'叶公好龙',1200,2},
			{'鱼龙曼衍',1200,2},
			{'鳌愤龙愁',1200,3},
			{'烹龙炮凤',1200,4},
			}
		--武当剑法
		CC.KFMove[381]={
			{'松沉自然',300,1},
			{'松腰沉跨',300,2},
			}	
		--天剑
		CC.KFMove[380]={
			{'天剑',1300,1},
			}		
		--十步方
		CC.KFMove[379]={
			{'十方步',1200,2},
			}
		--玉碎掌
		CC.KFMove[378]={
			{'抛砖引玉',1200,2},
			{'碎琼乱玉',1200,2},
			{'金声玉振',1200,3},
			{'鼎铛玉石',1200,3},
			{'兰摧玉折',1400,4},
			{'玉石俱焚',1400,4},
			}
		--灵枢定玄指
		CC.KFMove[377]={
			{'虚怀若无',1200,2},
			{'静若处子',1200,3},
			{'瞻忽在前',1200,3},
			{'微尘不惊',1200,3},
			{'瞻忽在后',1400,4},
			{'姑射仙人',1400,4},
			}
		--太清剑法
		CC.KFMove[376]={
			{'察君神静',700,1},
			{'一夕药成',700,2},
			{'相与太清',700,3},
			}		
		--穿花蝶影手
		CC.KFMove[375]={
			{'庄周梦蝶',800,1},
			{'花须蝶芒',800,2},
			{'镜花水月',800,2},
			}
		--北岳神剑
		CC.KFMove[374]={
			{'小楼听夜雨',400,1},
			{'独自依阑干',400,2},
			{'黑云欲摧城',400,2},
			{'雷公行疾电',400,2},
			{'鸿雁正回归',400,2},
			{'冰河入梦来',400,2},
			}	
		--东岳神剑
		CC.KFMove[373]={
			{'望天门',400,1},
			{'上天梯',400,2},
			{'踏虹桥',400,2},
			{'伐桂树',400,2},
			{'破九重',400,2},
			{'射金鸟',400,2},

			}	
		--南岳神剑
		CC.KFMove[372]={
			{'金雁横空',400,1},
			{'望牛折尾',400,2},
			{'风雷不及',400,2},
			{'竹林初虹',400,3},
			{'峰回路转',400,4},
			{'神女补天',400,5},
			}	
		--中岳神剑
		CC.KFMove[371]={
			{'却步抽剑',400,1},
			{'拨云射日',400,2},
			{'大鹏展翅',400,2},
			{'野马跳涧',400,3},
			{'临溪观渔',400,4},
			{'长空雷隐',400,5},
			}	
		--西岳神剑
		CC.KFMove[370]={
			{'白云出岫',400,1},
			{'有凤来仪',400,2},
			{'天绅倒悬',400,2},
			{'苍松迎客',400,3},
			{'浪子回头',400,4},
			{'白虹贯日',400,5},
			}											
		--韦陀棍法
		CC.KFMove[369]={
			{'伏虎听风',750,1},
			{'红霞贯日',750,2},
			{'黄石纳履',750,2},
			}		
		--普渡棍法
		CC.KFMove[368]={
			{'沙弥拜山',250,1},
			{'罗汉睡梦',250,2},
			}		
		--东鳞西爪功
		CC.KFMove[367]={
			{'一鳞半爪',1000,1},
			{'鳞次栉比',1000,2},
			{'鸟集鳞萃',1000,2},
			{'鸿爪春泥',1000,3},
			}		
		--圣火令法
		CC.KFMove[365]={
			{'石火电光',900,1},
			{'火中取栗',950,2},
			{'明火执仗',1000,2},
			{'星火不息',1000,2},
			{'烽火连天',1100,3},
			{'圣火长明',1100,3},
			}	
		--恒山身法
		CC.KFMove[364]={
			{'恒山身法',900,1},
			}				
		--太乙分光剑
		CC.KFMove[363]={
			{'一元复始',1400,2},
			{'二曰归藏',1400,2},
			{'三曰周易',1400,3},
			{'四象连山',1400,3},
			{'五行为卦',1400,4},
			{'万象天引',1800,5},
			}		
		--灵犀分水功
		CC.KFMove[362]={
			{'灵犀分水功',1200,1},
			}	
		--笑傲江湖曲
		CC.KFMove[361]={
			{'沧海一声笑',800,1},
			{'滔滔两岸潮',800,2},
			{'浮沉随浪只记今朝',800,2},
			}					
		--笑傲江湖曲
		CC.KFMove[360]={
			{'沧海一声笑',800,1},
			{'滔滔两岸潮',800,2},
			{'浮沉随浪只记今朝',800,2},
			}
		--蓝砂手
		CC.KFMove[359]={
			{'蓝砂石',600,1},
			{'蓝砂雾',600,2},
			{'蓝砂毒',600,2},
			}	
		--天王刀法
		CC.KFMove[358]={
			{'天大地大',1000,2},
			{'托塔天王',1000,3},
			{'天王老子',1000,3},
			{'天无二日',1000,4},
			}	
		--释迦掷象功
		CC.KFMove[357]={
			{'蛮牛势',700,1},
			{'伏虎势',700,2},
			{'掷象势',700,2},
			}
		--剑华皈壹 
		CC.KFMove[356]={
			{'剑芒出鞘',700,1},
			}
		--天龙心法
		CC.KFMove[355]={
			{'天龙心法',500,1},
			}
		--通幽诀
		CC.KFMove[354]={
			{'幽径通幽',500,1},
			}
		--天机心法
		CC.KFMove[353]={
			{'天机心法',500,1},
			}
		--碧针清掌
		CC.KFMove[352]={
			{'松针细叶',700,1},
			{'鼓荡松针',700,2},
			{'随风而舞',700,2},
			}
		--金龙鞭法
		CC.KFMove[351]={
			{'裂石式',400,1},
			{'断川式',400,2},
			}	
		--阿难破戒刀
		CC.KFMove[350]={
			{'断清净',500,1},
			{'落红尘',750,2},
			{'积业力',1000,3},
			{'引外魔',1250,3},
			{'粘因果',1500,4},
			}
		--屠龙刀法
		CC.KFMove[349]={
			{'诛龙斩',1000,2},
			{'灭龙斩',1000,3},
			{'屠龙斩',1000,3},
			}
		--大阴阳手
		CC.KFMove[348]={
			{'嵩阳大悲赋',400,1},
			{'嵩寒大悲赋',400,2},
			{'阴阳大悲赋',400,2},
			}
		--韦陀掌
		CC.KFMove[347]={
			{'灵山礼佛',300,1},
			{'山门护法',300,2},
			{'只为韦陀',300,2},
			}
		--大慈大悲手
		CC.KFMove[346]={
			{'培元固本',800,1},
			{'天王托塔',800,2},
			{'四象合一',800,2},
			}
		--千金术
		CC.KFMove[345]={
			{'治疗',500,1},
			}
		--血刀刀法
		CC.KFMove[344]={
			{'血气上涌',500,1},
			{'气血十足',500,2},
			{'见血封喉',500,2},
			}
		--血饮魔刀
		CC.KFMove[343]={
			{'孽海茫茫',1400,2},
			{'饮恨滔天',1400,3},
			{'离经叛道',1400,3},
			{'舍神弃佛',1400,4},
			{'横行无忌',1400,4},
			{'血刃魔心',1400,5},
			}
		--大伏魔拳
		CC.KFMove[342]={
			{'道高一尺',1200,2},
			{'魔高一丈',1200,2},
			{'群魔乱舞',1200,3},
			{'伏魔卫道',1200,4},
			}
		--狂风迅雷扇
		CC.KFMove[341]={
			{'狂风急雷',700,1},
			{'狂风疾速',700,2},
			{'狂风迅雨',700,2},
			}
		--大九天手
		CC.KFMove[340]={
			{'中天手',700,1},
			{'从天手',700,2},
			{'碎天手',700,2},
			}
		--华岳三神峰
		CC.KFMove[339]={
			{'粉石碎玉',900,1},
			{'混沌一破',900,2},
			{'两拳一刀',900,2},
			}
		--雁行刀
		CC.KFMove[338]={
			{'云中寄书',500,1},
			{'片影相失',500,2},
			{'木落南渡',500,2},
			}
		--六合刀法
		CC.KFMove[337]={
			{'大圣劈卦',700,1},
			{'二郎举卦',700,2},
			{'周公推卦',700,2},
			}
		--上清快剑
		CC.KFMove[336]={
			{'无尘剑势',500,1},
			{'无影剑势',500,2},
			{'无意剑势',500,2},
			{'无动剑势',500,2},
			}
		--天刀九问
		CC.KFMove[335]={
			{'上下未形',1333,2},
			{'阴阳三合',1333,2},
			{'地方九则',1333,2},
			{'增城九重',1333,3},
			{'焉有蛅龙',1333,4},
			{'天命反侧',1444,5},
			}
		--千蛛万毒手
		CC.KFMove[334]={
			{'百毒侵',700,1},
			{'千蛛劫',700,2},
			{'万蛊流',700,2},
			}
		--自创武功
		CC.KFMove[333]={
			{'一式',1500,1},
			{'二式',1500,2},
			{'三式',1500,3},
			{'四式',1500,3},
			{'五式',1500,4},
			{'六式',1500,5},		
			}		
		--三蜈五蟆烟
		CC.KFMove[332]={
			{'血矮栗',500,1},
			{'鬼蝙蝠',500,2},
			{'赤蝎粉',500,2},
			}
		--天机掌法
		CC.KFMove[331]={
			{'廉贞式',300,1},
			{'天府式',300,2},
			{'七杀式',300,2},
			}
		--黑沙掌
		CC.KFMove[330]={
			{'黑沙式',300,1},
			{'黑掌式',300,2},
			{'毒沙式',300,2},
			}		
		--黑沙掌
		CC.KFMove[329]={
			{'黑沙式',300,1},
			{'黑掌式',300,2},
			{'毒沙式',300,2},
			}
		--摧心掌
		CC.KFMove[328]={
			{'心力交瘁',1000,2},
			{'撕心裂肺',1000,2},
			{'呕心沥血',1000,3},
			}

		--天遁剑法
		CC.KFMove[327]={
			{'一剑相传',1000,2},
			{'天地山河',1000,3},
			{'六天成尘',1000,3},
			{'星辰月遁',1000,4},
			}
		--八仙剑法
		CC.KFMove[326]={
			{'钟离扇风',600,1},
			{'铁拐洞玄',600,2},
			{'纯阳舞剑',600,3},
			}
		--逍遥心法
		CC.KFMove[325]={
			{'逍遥心法',700,1},
			}			
		--袖里乾坤
		CC.KFMove[324]={
			{'春雷乍动',700,1},
			{'霹雷坠地',700,2},
			{'地雷母纲',700,2},
			}		
		--雷公轰
		CC.KFMove[323]={
			{'春雷乍动',700,1},
			{'霹雷坠地',700,2},
			{'地雷母纲',700,2},
			}
		--十八连环破
		CC.KFMove[322]={
			{'青字九打',400,1},
			{'城字九破',400,2},
			{'打破连环',400,2},
			}
		--一字电剑
		CC.KFMove[321]={
			{'如电',300,1},
			{'如雷',300,2},
			}
		--落英剑法
		CC.KFMove[320]={
			{'催银箭',500,1},
			{'玉漏银壶',500,2},
			{'铁关金锁',500,2},
			}
		--碧波掌
		CC.KFMove[319]={
			{'掌势如波',300,1},
			{'重重递进',300,2},
			}
		--劈空掌
		CC.KFMove[318]={
			{'醋手浸空',500,1},
			{'歪斜不称',500,2},
			{'疏疏落落',500,2},
			}
		--奇门五转
		CC.KFMove[317]={
			{'奇门五转',800,1},
			}		
		--碧海潮生曲
		CC.KFMove[316]={
			{'碧海无量',800,1},
			{'滔滔不绝',800,2},
			{'潮起潮落',800,2},
			}
		--五罗轻烟掌
		CC.KFMove[315]={
			{'烟散',400,1},
			{'烟起',400,2},
			{'烟尽',400,2},
			}
		--段家指法
		CC.KFMove[314]={
			{'大理段氏',300,1},
			{'思平皇室',300,2},
			{'俭魏南诏',300,2},
			}
		--葵花神针
		CC.KFMove[313]={
			{'葵花神针',300,1},
			}
		--黑血神针
		CC.KFMove[312]={
			{'黑血神针',300,1},
			}				
		--丹青破穴
		CC.KFMove[311]={
			{'截脉点穴',600,1},
			{'凌空打穴',600,2},
			{'百击破穴',600,2},
			}
		--无影脚
		CC.KFMove[310]={
			{'声东击西',900,1},
			{'扑朔迷离',900,2},
			{'眼花缭乱',900,2},
			{'虚无飘渺',900,3},
			}
		--泼墨披麻剑法
		CC.KFMove[309]={
			{'点墨剑式',400,1},
			{'泼墨剑式',400,2},
			{'沾墨剑式',400,2},
			{'游墨剑式',400,2},
			}
		--鹰蛇生死搏
		CC.KFMove[308]={
			{'鹰抓',900,1},
			{'蛇缠',900,2},
			{'鹰叼蛇咬',900,2},
			}
		--伏虎拳
		CC.KFMove[307]={
			{'倒扭金钟',600,1},
			{'深入虎穴',600,2},
			{'左伏右击',600,2},
			}
		--混元掌
		CC.KFMove[306]={
			{'引元归田',700,1},
			{'灵元归天',800,2},
			{'抱元归一',900,2},
			{'元元融金',900,2},
			}
		--劈石破玉拳
		CC.KFMove[305]={
			{'一叶扁舟',1000,2},
			{'天外飞龙',1000,3},
			{'劈石破玉',1000,3},
			}
		--夺命连环三仙剑
		CC.KFMove[304]={
			{'苍松迎客',1100,2},
			{'有凤来仪',1100,3},
			{'白虹贯日',1100,3},
			}
		--玉女十九式
		CC.KFMove[303]={
			{'玉女穿针',700,1},
			{'银光飞舞',700,2},
			{'青山隐隐',700,2},
			}
		--宁式一剑
		CC.KFMove[302]={
			{'巾帼须眉',700,1},
			{'铿锵玫瑰',700,2},
			{'无双无对',700,2},
			{'宁式一剑',700,2},
			}
		--冰魄银针
		CC.KFMove[301]={
			{'冰魄银针',700,1},
			}	
		--玉蜂针
		CC.KFMove[300]={
			{'玉蜂针',700,1},
			}				
		--银拂尘功
		CC.KFMove[299]={
			{'拂尘扫天',700,1},
			{'拂尘扫地',700,2},
			{'拂尘扫人',700,2},
			}
		--三无三不手
		CC.KFMove[298]={
			{'无孔不入',800,1},
			{'无所不为',800,2},
			{'无处不至',800,2},
			}
		--三笑逍遥散
		CC.KFMove[297]={
			{'似笑非笑',1400,2},
			{'宜笑宜颦',1400,3},
			{'先笑后号',1400,4},
			}	
		--星宿心法
		CC.KFMove[296]={
			{'星宿心法',700,1},
			}				
		--连环腐尸毒
		CC.KFMove[295]={
			{'腐尸毒',1100,2},
			{'炼心弹',1100,2},
			{'碧焰滔天',1100,3},
			{'摧枯折腐',1100,4},
			}
		
		--抽髓掌
		CC.KFMove[294]={
			{'抽骨髓',700,1},
			{'抽脑髓',700,2},
			{'抽血髓',700,2},
			}
		--霹雳雷火弹
		CC.KFMove[293]={
			{'雷火侵身',1200,1},
			{'天雷地火',1200,2},
			{'霹雳雷火',1200,2},
			}		
		--截手九式
		CC.KFMove[292]={
			{'侧截三式',800,1},
			{'反截三式',800,2},
			{'正截三式',800,2},
			}
		--金顶九式
		CC.KFMove[291]={
			{'金三式',700,1},
			{'顶三式',700,2},
			{'后三式',700,2},
			}
		--佛光普照
		CC.KFMove[290]={
			{'云开月明',700,1},
			{'光芒普照',700,2},
			{'佛光盛世',700,2},
			}
		--四象掌
		CC.KFMove[289]={
			{'太极生两仪',1000,2},
			{'两仪生四象',1000,2},
			{'四象生八卦',1000,3},
			}
		--金顶绵掌
		CC.KFMove[288]={
			{'金顶佛光',500,1},
			{'逆流捧沙',500,2},
			{'一拍金散',500,2},
			}
		--飘雪穿云掌
		CC.KFMove[287]={
			{'水拍云崖',400,1},
			{'云海明灯',400,2},
			{'罡风推云',400,2},
			}
		--昊天掌
		CC.KFMove[286]={
			{'肇化荒宇',1400,2},
			{'阴阳相克',1400,2},
			{'玄德乾坤',1400,3},
			{'其羽可用',1400,3},
			{'昊天罔极',1400,4},
			{'皇极生玄',1400,5},
			}
		--履霜破冰拳
		CC.KFMove[285]={
			{'如履薄冰',1000,1},
			{'履霜坚冰',1000,2},
			{'破冰而行',1000,2},
			}
		--一气化三清
		CC.KFMove[284]={
			{'元始',1000,1},
			{'灵宝',1000,2},
			{'太上',1000,2},
			}
		--同归剑法
		CC.KFMove[283]={
			{'同归于尽',800,1},
			{'生死两茫',800,2},
			{'天地同寿',800,2},
			}
		--喂毒丧门钉
		CC.KFMove[282]={
			{'如丧考妣',600,1},
			{'丧魂失魄',600,2},
			{'丧天害理',600,2},
			}		
		--蝎尾钩
		CC.KFMove[281]={
			{'蝎尾钩',600,1},

			}					
		--红砂掌
		CC.KFMove[280]={
			{'朱笔红砂',600,1},
			{'处子红砂',600,2},
			{'铸铁红砂',600,2},
			}
		--落雁掌
		CC.KFMove[279]={
			{'雁纵如烟',400,1},
			{'雁影若墨',400,2},
			{'雁翼似刀',400,2},
			}
		--三阴手
		CC.KFMove[278]={
			{'手三阴',400,1},
			{'足三阴',400,2},
			{'体三阴',400,2},
			}
		--雨打飞花剑
		CC.KFMove[277]={
			{'泛舟听雨',400,1},
			{'落雨散花',400,2},
			{'乱花覆剑',400,2},
			}
		--迅雷剑法
		CC.KFMove[276]={
			{'一字狂雷',900,1},
			{'风雷雨急',900,2},
			{'心雷万丈',900,2},
			}
		--子午十二剑
		CC.KFMove[275]={
			{'开门见嵩',900,1},
			{'千古人龙',900,2},
			{'游剑子午',900,2},
			}
		--快慢十八路
		CC.KFMove[274]={
			{'快剑式',400,1},
			{'慢剑式',400,2},
			{'拖剑式',400,2},
			{'突剑式',400,2},
			}
		--寒冰神掌
		CC.KFMove[273]={
			{'冰封千里',800,1},
			{'天寒地冻',800,2},
			{'连绵冰山',800,2},
			}
		--大嵩阳掌
		CC.KFMove[272]={
			{'破山斧',800,1},
			{'千掌环',800,2},
			{'无影掌',800,2},
			{'万丈烈阳',800,3},
			}
		--周公剑法
		CC.KFMove[271]={
			{'天如穹庐',900,2},
			{'白雾茫茫',900,3},
			{'斜风细雨',1000,3},
			{'暮短夜长',800,3},
			}
		--金刚伏虎刀
		CC.KFMove[270]={
			{'虎踞龙蟠',700,1},
			{'游龙出水',700,2},
			{'云起龙骧',700,2},
			}
		--八卦游龙掌
		CC.KFMove[269]={
			{'猛虎伏桩',800,1},
			{'游空探爪',800,2},
			{'龙盘八卦',800,2},
			}

		--回风拂柳刀
		CC.KFMove[268]={
			{'回风剑拂柳',500,1},
			{'狂风剑破空',500,2},
			{'神风剑卷地',500,2},
			}
		--降魔刀法
		CC.KFMove[267]={
			{'戒杀',800,1},
			{'破邪',800,2},
			{'去妄',800,2},
			{'除嗔',800,3},
			}
		--北斗剑法
		CC.KFMove[266]={
			{'天枢',350,1},
			{'天璇',350,2},
			}
		--参合剑气
		CC.KFMove[265]={
			{'北斗移辰',1500,2},
			{'参商永合',1500,3},
			{'陨石星浪',1500,3},
			{'天幻星辰',1500,4},
			{'日月星光',1500,4},
			{'乾坤星阵',1500,5},
			}
		--磐石法诀
		CC.KFMove[264]={
			{'不动明王',700,1},
			{'八方不倒',700,2},
			{'坚若磐石',700,2},
			}
		--开山掌
		CC.KFMove[263]={
			{'愚公移山',500,1},
			{'泰山压顶',500,2},
			{'三山五岳',500,2},
			}
		--磐罡掌
		CC.KFMove[262]={
			{'造化神秀',800,1},
			{'一览众山',800,2},
			{'会当绝顶',800,2},
			{'齐鲁青未',800,3},
			}
		--七星落长空
		CC.KFMove[261]={
			{'来鹤清泉',800,1},
			{'石关回马',800,2},
			{'长空星落',800,2},
			}
		--五大夫剑
		CC.KFMove[260]={
			{'苍翠相掩',600,1},
			{'虬枝斜出',600,2},
			{'五大夫松',600,2},
			}
		--古针禅功
		CC.KFMove[259]={
			{'古针渡劫',800,2},
			}
		--静心守剑
		CC.KFMove[258]={
			{'以静制动',800,1},
			{'心静则凉',800,2},
			{'静由心生',700,2},
			}
		--乞儿两式
		CC.KFMove[257]={
			{'伸手',400,1},
			{'要饭',400,2},
			}
		--春蚕掌法
		CC.KFMove[256]={
			{'春蚕结丝',900,1},
			{'春蚕破茧',900,2},
			{'千丝万绕',900,2},
			}
		--天长掌法
		CC.KFMove[255]={
			{'敬捧宝经',500,1},
			{'春去秋来',500,2},
			{'天长地久',500,2},
			}
		--伏魔剑法
		CC.KFMove[254]={
			{'韦陀宝杵',600,1},
			{'霞光神兽',600,2},
			{'神魔辟易',600,2},
			}

		--大长和诀
		CC.KFMove[253]={
			{'莫说狂',900,1},
			{'莫笑痴',900,2},
			{'莫怕醉',800,2},
			}
		--无妄神咒
		CC.KFMove[252]={
			{'天雷无妄',700,2},
			{'无妄而得',700,2},
			}

		--镇岳诀
		CC.KFMove[251]={
			{'镇岳尚方',800,2},
			}
		--衡山五神剑
		CC.KFMove[250]={
			{'祝融剑',800,1},
			{'紫盖剑',800,2},
			{'石禀剑',900,2},
			{'天柱剑',900,2},
			{'芙蓉剑',900,2},
			}
		--回风落雁剑
		CC.KFMove[249]={
			{'一剑落九雁',400,1},
			{'回风破长空',500,2},
			{'神风划天翔',600,2},
			}
		--铜锤手
		CC.KFMove[248]={
			{'剥肤锤髓',800,1},
			{'棉裹秤锤',900,2},
			{'击鞭锤镫',900,2},
			}

		--莲花落
		CC.KFMove[247]={
			{'借花献佛',500,1},
			{'莲藕同根',500,2},
			{'步步莲花',600,2},
			}
		--芙蓉金针
		CC.KFMove[246]={
			{'芙蓉金针',500,1},
		}
		--绕指柔剑
		CC.KFMove[245]={
			{'鱼跃龙门',600,1},
			{'白猿献果',600,2},
			{'柔月穿空',600,2},
		}
		--虎爪绝户手
		CC.KFMove[244]={
			{'猛虎出涧',900,2},
			{'虎头铁尾',900,2},
			{'饿虎扑食',900,3},
			{'虎啸生风',900,3},
			}		
		--少林九阳功
		CC.KFMove[243]={
			{'少林九阳功',900,2},
			}		
		--峨眉九阳功
		CC.KFMove[242]={
			{'峨眉九阳功',900,2},
			}		
		--武当九阳功
		CC.KFMove[241]={
			{'武当九阳功',900,2},
			}		
		--流云飞袖
		CC.KFMove[240]={
			{'流水击石',1200,1},
			{'白云出岫',1200,2},
			{'云淡风轻',1200,2},
			{'流云四散',1200,3},
		}	
		--扶摇九天
		CC.KFMove[239]={
			{'扶摇九天',500,2},
			}		
		--浮游功
		CC.KFMove[238]={
			{'浮游功',1300,2},
			}	
		--灵鳌步
		CC.KFMove[237]={
			{'灵鳌步',500,2},
			}	
		--神门十三剑
		CC.KFMove[236]={
			{'似攻非攻',1000,1},
			{'张弛有度',1000,2},
			{'剑断长川',1000,2},
			{'华光流转',1000,3},
			}
		--八卦心法
		CC.KFMove[235]={
			{'八卦心法',500,2},
			}
		--五行六合掌
		CC.KFMove[234]={
			{'利金',1000,2},
			{'清水',1000,2},
			{'玄木',1000,3},
			{'烈火',1000,4},
		}
		--神足经
		CC.KFMove[233]={
			{'神足功',1200,2},
			}
		--五虎棍法
		CC.KFMove[232]={
			{'猛虎下山',500,1},
			{'饿虎扑食',500,2},
			{'虎啸山林',500,2},
			}
		--八卦刀法
		CC.KFMove[231]={
			{'叶底藏花',500,1},
			{'凤凰回窝',500,2},
			{'夹马势按刀',500,3},
			}
		--八卦掌法
		CC.KFMove[230]={
			{'倚马文路',500,1},
			{'鸿雁出群',500,2},
			{'闭门推月',500,3},
			}
		--金蛇缠丝手
		CC.KFMove[229]={
			{'杯弓蛇影',900,1},
			{'灵蛇之珠',900,2},
			{'引蛇出洞',900,2},
			{'龙蛇飞动',900,3},
			}
		--疯魔棍法
		CC.KFMove[228]={
			{'托枪上阵',900,1},
			{'提膝托棍',900,2},
			{'仆步摔棍',900,2},
			{'摘心挖眉',900,3},
			}
		--龟息功
		CC.KFMove[227]={
			{'龟息功',1000,2},
			}
		--葵花点穴手
		CC.KFMove[226]={
			{'势如疾风',1200,2},
			{'快如闪电',1200,3},
			{'葵藿倾阳',1200,3},
			{'拔葵去织',1200,4},
			{'葵花向日',1200,5},
			}
		--小周天功
		CC.KFMove[225]={
			{'小周天功',900,2},
			}
		--蛇行狸翻
		CC.KFMove[224]={
			{'蛇行狸翻',1200,2},
			}			
		--金雁功
		CC.KFMove[223]={
			{'金雁功',1200,2},
			}		
		--天道剑势
		CC.KFMove[222]={
			{'道亦不变',1500,2},
			{'天道恢恢',1500,2},
			{'天地无极',1500,3},
			{'道不相谋',1500,4},
			{'无我无剑',1500,4},
			{'八荒归元',1500,5},
		}
		--阴阳无极功
		CC.KFMove[221]={
			{'阴阳无极功',1200,2},
			}
		--五毒神功
		CC.KFMove[220]={
			{'五毒神功',900,2},
			}
		--小星罗功
		CC.KFMove[219]={
			{'小星罗功',800,2},
			}
		--峨眉心法
		CC.KFMove[218]={
			{'峨眉心法',500,2},
			}
		--地火功
		CC.KFMove[217]={
			{'地火功',500,2},
			}
		--寒冰真气
		CC.KFMove[216]={
			{'寒冰真气',1000,2},
			}		
		--莲花功
		CC.KFMove[215]={
			{'莲花功',500,2},
			}			
		--血刀心法
		CC.KFMove[214]={
			{'血刀心法',500,2},
			}		
		--嵩山心法
		CC.KFMove[213]={
			{'嵩山心法',500,2},
			}			
		--华山心法
		CC.KFMove[212]={
			{'华山心法',500,2},
			}		
		--古墓心法
		CC.KFMove[211]={
			{'古墓心法',500,2},
			}			
		--全真心法
		CC.KFMove[210]={
			{'全真心法',500,2},
			}					
		--武当心法
		CC.KFMove[209]={
			{'武当心法',500,2},
			}		
		--少林心法
		CC.KFMove[208]={
			{'少林心法',500,2},
			}			
		--枯荣禅功
		CC.KFMove[207]={
			{'枯荣禅功',1000,2},
			}			
		-- 呼延十八鞭
		CC.KFMove[206]={
			{'毒龙出洞',400,1},
			{'行步蹬虎',400,2},
			}
		--震天铁掌
		CC.KFMove[205]={
			{'震响十里',800,1},
			{'隔山打牛',800,2},
			{'熔金碎石',800,2},
			{'如雷贯耳',800,3},
			}
		--擒龙功
		CC.KFMove[204]={
			{'擒龙功',1250,2},
			}			
		--长生诀
		CC.KFMove[203]={
			{'长生诀',1350,2},
			}		
		--白虹掌力4招
		CC.KFMove[202]={
		{'隐若白虹起',1200,2},
		{'呼气成白虹',1200,2},
		{'白虹为贯日',1200,3},
		{'薄暮垂虹去',1200,3},
		}
		--寒袖拂穴4招
		CC.KFMove[201]={
		{'春寒乍暖',1200,2},
		{'寒泉滞骨',1200,3},
		{'独立寒秋',1200,3},
		{'寒月笼纱',1200,4},
		}
		--岳家枪法4招
		CC.KFMove[200]={
		{'锁喉枪',1400,2},
		{'一夫当关',1400,3},
		{'枕戈待旦',1400,3},
		{'烽火连城',1400,4},
		{'满江红',1400,4},
		{'踏破龙城',1400,4},
		}
		--武墓遗书
		CC.KFMove[199]={
			{'武墓遗书',1000,2},
			}
		--岳王散手4招
		CC.KFMove[198]={
		{'黑虎剪尾',1100,2},
		{'上动不停',1100,3},
		{'饱虎登山',1200,3},
		{'黑虎剪',1200,3},
		}
		
		--无极玄功拳3招
		CC.KFMove[197]={
		{'冲天炮',1100,2},
		{'铁牛耕地',1100,2},
		{'仙鹤亮翅',1200,3},
		}
		--铁布衫
		CC.KFMove[196]={
			{'铁布衫',1000,2},
			}	
		--连环迷踪腿
		CC.KFMove[195]={
			{'灭景追风',800,2},
			{'驷马不追',800,3},
			{'穷追不舍',800,3},
			{'追云逐电',800,3},
			}
		--袈裟伏魔功8招
		CC.KFMove[194]={
		{'菩提上首',1200,2},
		{'处众人天',1200,3},
		{'龙披免难',1200,3},
		{'得成佛道',1200,4},
		}
		--解牛刀法3招
		CC.KFMove[193]={
		{'族庖月更刀',1400,2},
		{'良庖岁更刀',1400,3},
		{'无厚入有间',1400,3},
		{'游刃必有馀',1400,4},
		}
		--追魂夺命剑招式
		CC.KFMove[192]={
		{'孟婆灌汤',1300,2},
		{'一剑封喉',1300,2},
		{'神驼骏足',1300,3},
		{'勾魂摄魄',1300,3},
		{'目断魂销',1300,4},
		{'追魂夺命',1400,5},
		}
		--奔雷手3招
		CC.KFMove[191]={
		{'轰雷贯耳',1100,2},
		{'雷鸣瓦釜',1100,2},
		{'平地风雷',1100,3},
		{'电闪雷鸣',1100,3},
		}
		--大周天功
		CC.KFMove[190]={
			{'大周天功',1200,2},
			}		
		--般若掌法4招
		CC.KFMove[189]={
		{'童子拜佛',1400,2},
		{'礼戒四参',1400,3},
		{'一拍两散',1400,3},
		{'观照般若',1400,3},
		{'妄想皆无',1400,4},
		{'大梵般若',1400,5},
		}
		--猿公剑法4招
		CC.KFMove[188]={
		{'剑气长空',1200,2},
		{'剑灵寰宇',1200,2},
		{'剑主天地',1200,3},
		{'剑破苍穹',1200,4},
		}
		--擒龙手3招
		CC.KFMove[187]={
		{'羚羊挂角',1100,2},
		{'倏然而至',1100,2},
		{'手到擒来',1100,3},
		{'徒手擒龙',1200,3},
		}
		--一苇渡江
		CC.KFMove[186]={
			{'一苇渡江',0,0},
			}		
		--阳春白雪曲5招
		CC.KFMove[185]={
			{'宫',1200,2},
			{'商',1300,3},
			{'角',1400,3},
			{'徵',1400,3},
			{'羽',1400,4},
			}
		--不老长春功
		CC.KFMove[184]={
			{'九宵仙息',1300,2},
			}	
		--不老长春功
		CC.KFMove[183]={
			{'不老长春功',1300,2},
			}	
		--不老长春功
		CC.KFMove[182]={
			{'小李飞刀',1300,2},
			}				
		--井月八法
		CC.KFMove[181]={
		{'不攻',1300,2},
		{'击奇',1300,2},
		{'兵诈',1300,3},
		{'方圆',1400,4},
		}
		--鲸息功
		CC.KFMove[180]={
			{'鲸息功',1350,2},
			}		
		--碧海惊涛掌6招
		CC.KFMove[179]={
		{'长风破浪',1200,2},
		{'碧波汹涌',1300,3},
		{'惊涛骇浪',1400,3},
		{'白浪滔天',1400,3},
		{'波谲云诡',1400,4},
		{'碧海长空',1600,4}
		}
		--浣花剑法
		CC.KFMove[178]={
			{'浣花剑法',1250,2},
			}		
		--忘情天书
		CC.KFMove[177]={
			{'忘情天书',1250,2},
			}		
		--归藏八剑
		CC.KFMove[176]={
		{'乾剑道',2000,2},
		{'坤剑道',2000,2},
		{'离剑道',2000,3},
		{'艮剑道',2000,3},
		{'同人剑',2000,3},
		{'小畜剑',2000,3},
		{'大有剑',2000,3},
		{'明夷剑',2000,4},
		}
		--五岳剑诀
		CC.KFMove[175]={
			{'五岳剑诀',1250,2},
			}	
		--阴风刀2招
		CC.KFMove[174]={
		{'鬼魅魍魉',1200,2},
		{'尸鬼封尽',1200,2},
		{'阴风阵阵',1200,3},
		{'利刃寒锋',1200,3},
		}
		--千手如来掌
		CC.KFMove[173]={
		{'清风拂桂',1250,3},
		{'仰月承霖',1250,3},
		{'风满长空',1250,4},
		{'四方散花',1250,4},
		}
		--潮汐神功
		CC.KFMove[172]={
			{'潮汐神功',1300,2},
			}		
		--太神神功
		CC.KFMove[171]={
			{'太神神功',1300,2},
			}	
		--三阴腐尸掌
		CC.KFMove[170]={
		{'行尸走肉',1100,2},
		{'尸居余气',1100,3},
		{'尸山血海',1100,3},
		{'三尸五鬼',1100,4},
			}	
		--瑜伽密乘
		CC.KFMove[169]={
			{'瑜伽密乘',1100,2},
			}		
		--逍遥神剑2招
		CC.KFMove[168]={
		{'既不回头',1600,2},
		{'何必不忘',1600,3},
		{'既然无缘',1600,3},
		{'何需誓言',1600,3},
		{'今日种种',1600,3},
		{'似水无痕',1600,4},
		{'明夕何夕',1600,4},
		{'君已陌路',1600,5},
		}
			--青莲剑法10招
		CC.KFMove[167]={
		{'长风万里',1400,2},
		{'对酣高楼',1400,3},
		{'蓬莱文章',1400,3},
		{'小谢清发',1400,4},
		{'青天览月',1400,4},
		{'对酒当歌',1400,5},
		}
		--天池心法
		CC.KFMove[166]={
			{'天池心法',900,2},
			}
		--呼延枪法
		CC.KFMove[165]={
		{'呼颈举踵',400,1},
		{'冲锋陷阵',400,3},
			}
		--白蟒鞭法1招
		CC.KFMove[164]={
		{'残烛引月',1200,2},
		{'杯弓蛇影',1200,3},
		{'白璧微瑕',1200,3},
		{'晦蟒否塞',1200,4},

		}
		--血海魔功
		CC.KFMove[163]={
			{'血海魔功',800,2},
			}		
		--狂风快剑
		CC.KFMove[162]={
		{'一叶扁舟',1300,2},
		{'天外飞龙',1300,3},
		{'风驰云卷',1300,3},
		{'长风破浪',1300,3},

		}
		--玄女剑法1招
		CC.KFMove[161]={
		{'碧落穹苍',1200,2},
		{'飞花逐蝶',1200,3},
		{'月下花前',1200,3},
		{'玄裳缟衣',1200,4},
		}
		--天魔功
		CC.KFMove[160]={
			{'天魔功',1200,2},
			}		
		--苍狼战戟2招
		CC.KFMove[159]={
		{'苍髯如戟',2000,2},
		{'染苍染黄',2000,3},
		{'鬼哭狼嚎',2000,3},
		{'狼烟四起',2000,3},
		{'魔澜惊炽',2000,4},
		{'罗摩沌灭',2000,4},
		}
		--五轮大转2招
		CC.KFMove[158]={
		{'天高云淡',1300,2},
		{'天灾人祸',1300,3},
		{'天魔降伏',1300,3},
		{'天移日易',1300,3},
		{'天罡震烈',1300,4},
		{'天舞宝轮',1300,4},
		}
		--枣核钉1招
		CC.KFMove[157]={
		{'囫囵吞枣',1000,2},
		{'付之梨枣',1000,3},
		{'透骨腐肉',1000,3},
		{'瞬狱一杀',1000,4},
		}

		--越女剑法4招
		CC.KFMove[156]={
		{'电照长空',1500,2},
		{'仙猿剑舞',1500,3},
		{'越畔之思',1500,3},
		{'天女散花',1500,3},
		{'诛天凌神',1500,4},
		{'天仙剑影',1500,4},
		}
		--火枪
		CC.KFMove[155]={
		{'射击',1500,2},
		{'齐射',1500,3},
		{'钓瓶击',1500,3},
		{'三段击',1500,3},
		{'飞鸟击',1500,4},
		{'乱射',1500,4},
		}
		--玉女心经
		CC.KFMove[154]={
			{'玉女心经',1100,2},
			}
		--沧溟刀法2招
		CC.KFMove[153]={
		{'冷月分辉',1200,2},
		{'银河共影',1200,3},
		{'沧海遗珠',1200,3},
		{'陵谷沧桑',1200,3},
		{'溟思苦想',1200,4},
		{'溟顽不灵',1200,4},
		}
		--太虚剑意
		CC.KFMove[152]={
			{'太虚剑意',1450,2},
			}		
		--斩流剑术招
		CC.KFMove[151]={
		{'一念无量',1400,2},
		{'现世执妄',1400,3}, 
		{'悟入幻想',1400,3},
		{'草木成佛',1400,3}, 
		{'天人五衰',1400,4},
		{'六根清净',1400,4}, 
		}

		--瞬息千里
		CC.KFMove[150]={
			{'瞬息千里',1000,2},
			}		
		--梯云纵
		CC.KFMove[149]={
			{'梯云纵',1000,2},
			}	
		--天罗地网
		CC.KFMove[148]={
			{'天罗地网',1000,2},
			}	
		--凌波微步
		CC.KFMove[147]={
			{'凌波微步',1000,2},
			}		
		--凌波微步
		CC.KFMove[147]={
			{'凌波微步',1000,2},
			}		
		--神行百变
		CC.KFMove[146]={
			{'神行百变',1000,2},
			}	
		--飞天神行
		CC.KFMove[145]={
			{'飞天神行',1000,2},
			}	
		--金刚不坏体
		CC.KFMove[144]={
			{'金刚不坏体',1000,2},
			}	
		--铁剑
		CC.KFMove[143]={
		{'铁面无私',1000,2},
		{'铁树开花',1000,3},
		{'铁证如山',1000,3},
		{'铁杵磨针',1000,4},
		}
		--妙笔丹青1招
		CC.KFMove[142]={
		{'妙笔生花',1200,2},
		{'神笔马良',1200,3},
		{'神封太渊',1200,3},
		{'铁血丹心',1200,4},
		}
		--百胜刀法2招
		CC.KFMove[141]={
		{'却月天戈',1000,2},
		{'孤月寒江',1000,3},
		{'寒光百刃',1000,3},
		{'百战百胜',1000,4},
		}

		--达摩剑法1招
		CC.KFMove[140]={
		{'万事随缘往',1000,2},
		{'来去若梦行',1000,3},
		{'浮世沧桑远',1000,3},
		{'轮回法舟轻',1000,4},
		}
		--玉女素心剑6招
		CC.KFMove[139]={
		{'清饮小酌',1400,2},
		{'浪迹天涯',1400,3},
		{'举案齐眉',1400,3},
		{'皓腕玉镯',1400,3},
		{'冷月窥人',1400,4},
		{'竹帘临池',1400,4},
		}
		--参合指6招
		CC.KFMove[138]={
		{'国破山河在',1500,2},
		{'感时花溅泪',1500,3},
		{'锋火连三月',1500,3},
		{'兵败参合陂',1500,3},
		{'顾盼子孙贤',1500,3},
		{'铭记复国志',1500,4},
		}
		--拈花指
		CC.KFMove[137]={
		{'花供佛残',1500,2},
		{'折花修佛',1500,3},
		{'拈花一笑',1500,3},
		{'佛拜昙花',1500,4},
			}
		--无相劫指2招
		CC.KFMove[136]={
		{'天保九如',1300,2},
		{'天马行空',1300,3},
		{'天地玄黄',1300,3},
		{'千劫不动',1300,4},
		{'金刚无相',1300,4},
		{'天火焚城',1500,5},
		}
		--大力金刚指2招
		CC.KFMove[135]={
		{'金刚揭谛',1400,2},
		{'正骨松筋',1400,2},
		{'金刚菩提',1400,3},
		{'铁指拔钉',1400,3},
		{'金刚震脉',1400,4},
		{'金刚般若',1400,5},
		}
		--凝血神爪2招
		CC.KFMove[134]={
		{'风驰电掣',1000,2},
		{'阴凝坚冰',1000,3},
		{'黄石纳履',1000,3},
		{'逆挽天华',1000,3},
		}
		--大智无定指
		CC.KFMove[133]={
			{'三体顶天',1000,2},
			{'托佛珈蓝',1000,3},
			{'无踪无定',1000,3},
			{'大智若愚',1000,3},
			}
		--多罗叶指
		CC.KFMove[132]={
			{'佛陀问路',900,1},
			{'雷音佛声',900,2},
			{'五丁开山',900,2},
			}
		--黑风指
		CC.KFMove[131]={
			{'阴风愁肠',800,1},
			{'捕风捉影',800,2},
			{'凄风苦雨',800,2},
			}
		--玄天指
		CC.KFMove[130]={
			{'剖玄析微',800,1},
			{'钩玄提要',800,2},
			{'玄裳缟衣',800,2},
			}
		--旋风招叶腿
		CC.KFMove[129]={
			{'风起涟漪',800,1},
			{'落叶知秋',800,2},
			{'天旋地转',800,2},
			}
		--一指禅
		CC.KFMove[128]={
			{'一指头禅',700,1},
			{'一指破天',700,2},
			{'一指圆寂',700,3},
			}
		--透骨打穴
		CC.KFMove[127]={
			{'封穴结脉',600,1},
			{'透骨打穴',600,2},
			{'戳穴截血',600,2},
			}
		--兰花拂穴
		CC.KFMove[126]={
			{'春深芳草尽',500,1},
			{'夏闲独兰馨',500,2},
			{'秋酣菊霜清',500,2},
			}
		--袖中指
		CC.KFMove[125]={
			{'斫头谢天',400,1},
			{'临溪观鱼',400,2},
			{'井底之蛙',400,2},
			}
		--去烦恼指
		CC.KFMove[124]={
			{'烦心倦目',600,1},
			{'灰身泯智',600,2},
			{'牛山下涕',600,2},
			}
		--夺魄指
		CC.KFMove[123]={
			{'迷魂夺魄',400,1},
			{'惊魂夺魄',400,2},
			}
		--天竺佛指
		CC.KFMove[122]={
			{'戟指怒目',400,1},
			{'指天画地',400,2},
			}
		--铁指诀
		CC.KFMove[121]={
			{'长风染指',250,1},
			{'指东话西',250,2},
			}
		--冰蚕毒掌1招
		CC.KFMove[120]={
		{'冰消瓦解',1100,2},
		{'鲸吞蚕食',1100,2},
		{'如履薄冰',1100,3},
		{'冰毒缭绕',1100,3},
		}
		--满州摔跤
		CC.KFMove[119]={
			{'拿臂踹',600,1},
			{'倒臂踹',600,2},
			{'背負投',600,2},
			}
		--化骨绵掌1招
		CC.KFMove[118]={
		{'积毁销骨',1000,2},
		{'挫骨扬灰',1000,3},
		{'敲骨吸髓',1000,3},
		{'百鬼恸哭',1000,4},
		}
		--分筋错骨手
		CC.KFMove[117]={
		{'腋底偷桃',700,1},
		{'截肘扣带',700,2},
		{'分筋错骨',700,2},
		}
		--妙手空空
		CC.KFMove[116]={
		{'探云手',400,1},
		{'揽月手',400,2},
		}
		--三花聚顶掌1招
		CC.KFMove[115]={
		{'炼精化气',700,1},
		{'炼气化神',700,2},
		{'炼神还虚',700,2},
		}
		--连城剑法4招
		CC.KFMove[114]={
		{'西辞黄鹤楼',900,1},
		{'三月下扬州',900,2},
		{'远影碧空尽',900,2},
		{'长江天际流',900,3},
		}
		--闪电貂
		CC.KFMove[113]={
			{'闪电貂',600,1},
			}	
		--犽月流空2招
		CC.KFMove[112]={
		{'月樱流',1200,1},
		{'月犽流',1200,1},
		{'月骁流',1200,1},
		}
		--西瓜刀法3招
		CC.KFMove[111]={
		{'切瓜',1200,1},
		{'剁瓜',1200,1},
		{'砍瓜',1200,1},
		}
		--神山剑法3招
		CC.KFMove[110]={
		{'神洲移山剑',1200,1},
		{'神洲镇山剑',1200,1},
		{'神洲擎山剑',1200,1},
		}
		--野球拳3招
		CC.KFMove[109]={
		{'石头',1200,1},
		{'剪子',1200,1},
		{'布',1200,1},
		}
		--九阴神功
		CC.KFMove[108]={
			{'易筋神功',1400,2},
			}	
		--九阴神功
		CC.KFMove[107]={
			{'九阴神功',1400,2},
			}	
		--九阳神功3招
		CC.KFMove[106]={
		{'清风拂山冈',1500,2},
		{'他恶任他恶',1400,2},
		{'一口真气足',1500,4},
		{'他强任他强',1500,4},
		{'明月照大江',1500,4},
		}
		
		--葵花神功
		CC.KFMove[105]={
			{'葵花神功',1300,2},
			}	
		--逆运神功
		CC.KFMove[104]={
		{'逆运神功',1200,2},
		}		
		--龙象般若功
		CC.KFMove[103]={
		{'龙象般若功',1350,2},
		}	
		--太玄神功5招
		CC.KFMove[102]={
		{'赵客缦胡缨',1200,2},
		{'银鞍照白马',1200,2},
		{'三杯吐然诺',1200,2},
		{'纵死侠骨香',1200,2},
		{'白首太玄经',1200,2},
		}
		--八荒六合功
		CC.KFMove[101]={
		{'八荒六合功',1000,2},
		}		
		--先天功
		CC.KFMove[100]={
		{'先天功',1000,2},
		}		
		--纯阳无极功
		CC.KFMove[99]={
		{'纯阳无极功',900,2},
		}		
		--小无相功
		CC.KFMove[98]={
		{'小无相功',1000,2},
		}		
		--乾坤大挪移
		CC.KFMove[97]={
		{'乾坤大挪移',850,2},
		}	
		--罗汉伏魔功
		CC.KFMove[96]={
		{'罗汉伏魔功',900,2},
		}
		--蛤蟆功
		CC.KFMove[95]={
		{'蛤蟆功',900,2},
		}
		--神照功
		CC.KFMove[94]={
		{'神照功',850,2},
		}	
		--圣火神功
		CC.KFMove[93]={
		{'圣火神功',900,1},	
		}
		--狮子吼
		CC.KFMove[92]={
			{'狮子吼神功',1000,2},
			}		
		--金刚狮子吼
		CC.KFMove[91]={
			{'金刚狮子吼',1200,2},
			}	
		--混元功
		CC.KFMove[90]={
			{'混元功',1200,2},
			}	
		--紫霞神功
		CC.KFMove[89]={
			{'紫霞神功',1200,2},
			}		
		--伏魔	
		--吸星大法
		CC.KFMove[88]={
			{'吸星大法',1000,2},
			}			
		--化功大法
		CC.KFMove[87]={
			{'化功大法',1000,2},
			}		
		--伏魔杖法2招
		CC.KFMove[86]={
		{'天魔降伏',1400,2},
		{'佛怒唐莲',1400,3},
		{'祸福倚伏',1400,3},
		{'摩诃无量',1400,3},
		{'佛高一尺',1400,3},
		{'佛魔摄道',1400,4},
		}
		
		--北冥神功
		CC.KFMove[85]={
			{'北冥神功',1200,2},
			}	
		--倚天屠龙功6招
		CC.KFMove[84]={
		{'武林至尊',1400,2},
		{'宝刀屠龙',1400,3},
		{'号令天下',1400,3},
		{'莫敢不从',1400,3},
		{'倚天不出',1400,3},
		{'谁与争锋',1400,4},
		}
		--无上大力杵3招
		CC.KFMove[83]={
		{'力战千钧',1200,2},
		{'拔山填海',1200,3},
		{'千钧压顶',1200,3},
		{'推象伏虎',1200,4},
		}
		--金刚伏魔圈4招
		CC.KFMove[82]={
		{'祗园精舍',1400,2},
		{'诸行无常',1400,2},
		{'娑罗双树',1400,3}, 
		{'幻梦一场',1400,4},
		{'佛陀割肉',1400,4},
		{'金刚伏魔',1400,5},
		}
		--灵蛇杖法2招
		CC.KFMove[81]={
		{'怪蟒翻身',1400,2},
		{'毒蛇吐信',1400,2},
		{'蛇己旧人',1400,3},
		{'打草惊蛇',1400,3},
		{'蛇蝎心肠',1400,4},
		{'灵蛇之珠',1400,5},
		}
		--打狗棒法4招
		CC.KFMove[80]={
		{'棒打狗头',1400,2},
		{'反截狗臀',1400,2},
		{'獒口夺杖',1400,3},
		{'棒打双犬',1400,3},
		{'恶狗拦路',1400,4},
		{'天下无狗',1400,5},
		}
		--银索金铃2招
		CC.KFMove[79]={
		{"水银泻地",1100,2},
		{"金枝玉叶",1100,2},
		{"银索缠身",1100,3},
		{"锁穴金铃",1100,3},
		}
		--黄沙万里鞭2招
		CC.KFMove[78]={
		{"血染黄沙",900,1},
		{"飞沙万里",900,2},
		{"黄粱一梦",900,2},
		{"海市蜃楼",900,3},
		}
		--阴阳倒乱刃2招
		CC.KFMove[77]={
		{"假刀非刀",1000,2},
		{"假剑非剑",1000,3},
		{"白马非马",1000,3},
		{"坤悬倒刺",1000,4},
		}
		--海叟钓法
		CC.KFMove[76]={
		{'寒江垂钓',400,1},
		{'江枫渔火',400,2},
		}
		--大剪刀2招
		CC.KFMove[75]={
		{'我咔',800,1},
		{'我嚓',800,2},
		{'我剪',800,2},
		}
		--鹤蛇八打2招
		CC.KFMove[74]={
		{'冲天一鹤',700,1},
		{'仙鹤穿云',700,2},
		{'鹤啸九天',700,2},
		}
		--持瑶琴
		CC.KFMove[73]={
		{'素手摘星',800,1},
		{'歌尽影生',800,2},
		{'高山流水',800,2},

		}
		--棋盘招式3招
		CC.KFMove[72]={
		{'紧气',800,1},
		{'提子',800,2},
		{'大飞',800,2},

		}
		--裴将军帖2招
		CC.KFMove[71]={
		{'大君制六合',700,1},
		{'猛将清九垓',700,2},
		{'战马若龙虎',700,2},
		}
		--中平枪法2招
		CC.KFMove[70]={
		{'吊四平枪势',400,1},
		{'中四平枪势',400,2},
		}
		--毒龙鞭法3招
		CC.KFMove[69]={
		{'毒龙出洞',500,1},
		{'毒龙钻风',500,2},
		}
		--杨家枪法3招
		CC.KFMove[68]={
		{'回马枪',500,1},
		{'春雷震怒',500,2},
		}
		--胡家刀法2招
		CC.KFMove[67]={
		{'参拜北斗式',1200,2},
		{'沙鸥掠波式',1200,2},
		{'闭门铁扇刀',1200,3},
		{'缠身摘心刀',1200,3},
		{'拜佛听经式',1200,3},
		{'八方藏刀式',1200,4},
		}
		--火焰刀法2招
		CC.KFMove[66]={
		{'炽炎破军',1200,2},
		{'昊火焚天',1200,2},
		{'五内如焚',1200,3},
		{'烟焱张天',1200,3},
		{'炉火纯青',1200,3},
		{'星火燎原',1200,4},
		}
		--燃木刀法2招
		CC.KFMove[65]={
		{'钻木取火',900,1},
		{'无名孽火',900,2},
		{'飞蛾扑火',900,2},
		{'无明业火',900,3},
		}
		--玄虚刀法2招
		CC.KFMove[64]={
		{'莫测高深',900,1},
		{'故弄玄虚',900,2},
		{'神而明之',900,2},
		{'玄天虚若',900,3},
		}
		--血刀大法3招
		CC.KFMove[63]={
		{'呕心沥血',800,1},
		{'批纸削腐',800,2},
		{'流星经天',800,2},
		{'血海刀风',800,3},
		}
		--夫妻刀法4招
		CC.KFMove[62]={
		{'女貌郎才',1200,1},
		{'丽质眷属',1200,2}, 
		{'清风引佩',1200,2}, 
		{'明月照妆',1200,3},
		}
		--金乌刀法2招
		CC.KFMove[61]={
		{'梅雪逢夏',700,1},
		{'赤日炎炎',700,2},
		{'锄禾当午',700,2},
		}
		--反两仪刀法2招
		CC.KFMove[60]={
		{'辗转反复',900,1},
		{'两小无猜',900,2},
		{'万劫不复',900,2},
		{'两仪转承',900,2},
		}
		--五虎断门刀2招
		CC.KFMove[59]={
		{'白虎跳涧',600,1},
		{'剪扑自如',600,2},
		{'生龙活虎',600,2},
		}
		--修罗刀1招
		CC.KFMove[58]={
		{'恨意绵绵',600,1},
		{'饮恨而终',600,2},
		{'含恨九泉',600,2},
		}
		--慈悲刀法2招
		CC.KFMove[57]={
		{'放下屠刀',600,1},
		{'立地成佛',600,2},
		}
		--奇门三才刀2招
		CC.KFMove[56]={
		{'带醉脱靴式',400,1},
		{'摇头摆尾式',400,2},
		}
		--狂风刀法2招
		CC.KFMove[55]={
		{'狂风大作',700,1},
		{'飞沙走石',700,2},
		{'风卷残云',700,2},
		}
		--鸳鸯刀法2招
		CC.KFMove[54]={
		{'云蕾花开',700,1},
		{'玲珑偃月',800,2},
		{'只羡鸳鸯',800,2},
		}

		--南山刀法2招
		CC.KFMove[53]={
		{'燕子入巢',600,1},
		{'采菊东篱',600,2},
		}
		--鬼头刀法1招
		CC.KFMove[52]={
		{'鬼见愁',600,1},
		{'鬼见忧',600,2},
		{'鬼见糗',600,2},
		}
		--万劫刀法
		CC.KFMove[51]={
		{'百劫式',500,1},
		{'肆劫式',500,2},
		}
		--柴刀十八路2招
		CC.KFMove[50]={
		{'砍',300,1},
		{'劈',300,2},
		}
		--六脉神剑
		CC.KFMove[49]={
		{'少商剑',1600,2},
		{'商阳剑',1600,2},
		{'中冲剑',1600,3},
		{'关冲剑',1600,3},
		{'少冲剑',1600,3},
		{'少泽剑',1600,4}
		}
		--辟邪剑法6招
		CC.KFMove[48]={
		{'指打奸邪',800,2},
		{'飞燕穿柳',1000,3},
		{'花开见佛',1300,3}, 
		{'锺馗抉目',1300,3}, 
		{'扫荡群魔',1400,4},
		{'紫气东来',1300,5},
		}
		--独孤九剑9招
		CC.KFMove[47]={
		{'破掌式',1600,2},
		{'破气式',1600,2},
		{'破剑式',1600,2},
		{'破刀式',1600,2},
		{'破枪式',1600,2},
		{'朝天阙',1600,3},
		{'木马流',1600,3},
		{'无剑取',1600,3},
		{'总决式',1600,3},
		}
		--太极剑法3招
		CC.KFMove[46]={
		{'钟馗仗剑',1300,2},
		{'青龙出水',1300,3},
		{'白蛇吐信',1300,3},
		{'野马跳涧',1300,3},
		{'仙人指路',1300,4},
		{'三环套月',1300,4},
		}
		--玄铁剑法4招
		CC.KFMove[45]={
		{'逆击',1500,2},
		{'倒劈',1500,3},
		{'顺刺',1500,3},
		{'横削',1500,3},
		{'重剑无锋',1500,4},
		{'大巧不工',1500,5},
		}
		--苗家剑法6招
		CC.KFMove[44]={
		{'苏秦背剑式',1000,2},
		{'黄龙吐须式',1000,2},
		{'反劈华山式',1000,2},
		{'怀中抱月式',1000,2},

		}
		--斗转星移
		CC.KFMove[43]={
			{'斗转星移',1200,2},
			}	
		--玉女剑法
		CC.KFMove[42]={
			{'清饮小酌',800,1},
			{'举案齐眉',850,1},
			{'冷月窥人',900,2},
			}	
		--倚天剑法3招
		CC.KFMove[41]={
		{'玉碎昙香',1000,2},
		{'天劫俱灭',1050,2}, 
		{'倚天照海',1100,2},
		{'天外飞仙',1200,3},
		}
		--金蛇剑法3招
		CC.KFMove[40]={
		{'金光蛇影',900,1},
		{'金蛇化龙',950,2},
		{'蛇困愁城',1000,3},
		}
		--全真剑法
		CC.KFMove[39]={
			{'素月分辉',600,1},
			{'疏星淡月',700,1},
			{'星河欲转',800,2},
		}
		--玉萧剑法5招
		CC.KFMove[38]={
		{'山外清音',800,1},
		{'金声玉振',800,1},
		{'凤曲长鸣',800,2},
		{'响隔楼台',800,2},
		}
		--两仪剑法2招
		CC.KFMove[37]={
		{'金针渡劫',800,1},
		{'峭壁断云',800,2},
		{'仪静体闲',800,2},
		}
		--柔云剑法3招
		CC.KFMove[36]={
		{'杏花春雨',700,1},
		{'满天花雨',700,2},
		{'玉带围腰',700,2}
		}
		--雪山剑法3招
		CC.KFMove[35]={
		{'雪泥鸿爪',600,1},
		{'梅雪争春',600,1},
		{'雪山六出',600,2}
		}
		--华山剑法3招
		CC.KFMove[34]={
		{'苍松迎客',600,1},
		{'金雁横空',600,1},
		{'天坤倒悬',600,2}
		}
		--嵩山剑法3招
		CC.KFMove[33]={
		{'叠翠浮青',600,1},
		{'玉进天池',600,1},
		{'天外玉龙',600,2}
		}
		--衡山剑法3招
		CC.KFMove[32]={
		{'泉鸣芙蓉',600,1},
		{'鹤翔紫盖',600,1},
		{'天柱云气',600,2}
		}
		--泰山剑法3招
		CC.KFMove[31]={
		{'五大夫剑',500,1},
		{'岱宗如何',500,1},
		{'七星落长空',500,2}
		}
		--万花剑法3招
		CC.KFMove[30]={
		{'万花齐放',500,1},
		{'万卉争艳',500,1},
		{'清澈梅花',500,2}
		}
		--三分剑术3招
		CC.KFMove[29]={
		{'冰河倒泻',400,1},
		{'雪中奇莲',400,1},
		{'千岩竞秀',400,2}
		}
		--雷震剑术2招
		CC.KFMove[28]={
		{'轰雷掣电',300,1},
		{'雷霆万钧',300,1}
		}
		--松风剑法3招
		CC.KFMove[27]={
		{'平沙落雁',300,1},
		{'碧渊腾蛟',300,2}
		}
		--降龙十八掌
		CC.KFMove[26]={
		{'亢龙有悔',1500,2},
		{'见龙在田',1500,2},
		{'飞龙在天',1500,2},
		{'双龙出水',1500,3},
		{'神龙摆尾',1500,4},
		{'潜龙勿用',1500,4},
		{'时乘六龙',1500,5},
		}
		--黯然销魂掌6招
		CC.KFMove[25]={  
		{'想入非非',1500,2},
		{'饮恨吞声',1500,3},
		{'行尸走肉',1500,3},
		{'穷途末路',1500,3},
		{'六神不安',1500,4},
		{'倒行逆施',1500,4},
		{'无中生有',1500,5},
		}
		--须弥山神掌3招
		CC.KFMove[24]={
		{'色空四显',1400,2},
		{'无色无相',1400,2},
		{'慑伏外道',1400,2},
		{'众佛参禅',1400,3},
		{'莲花佛相',1400,4},
		{'须弥芥子',1400,5},
		}
		--七伤拳2招
		CC.KFMove[23]={
		{'五行阴阳',1000,2},
		{'损心催肝',1000,2},
		{'藏离精失',1000,3},
		{'三焦齐逆',1000,4},
		{'意恍惚诀',1000,4},
		}
		--大金刚掌3招
		CC.KFMove[22]={
		{'大梵炼狱',1000,2},
		{'九仪崩乱',1000,2},
		{'地火燃穹',1000,3},
		{'金诚所至',1000,3},
		}
		--玄冥神掌2招
		CC.KFMove[21]={
		{'玄冥侵体',1400,2},
		{'天地幽冥',1410,2},
		{'天梦冥蒙',1450,3},
		{'冰毒缭绕',1460,3},
		{'飞鸿冥冥',1470,4},
		{'通幽洞明',1480,5},
		}
		--龙爪手1招
		CC.KFMove[20]={
		{'捉影式',1000,2},
		{'捕风式',1000,3},
		{'鼓瑟式',1000,3},
		{'抱残式',1000,4},
		}
		--幻阴指1招
		CC.KFMove[19]={
		{'魔幻天阴',1000,2},
		{'梦幻泡影',1000,2},
		{'诪张为幻',1000,3},
		{'冥狱幻影',1000,3},
		}
		--弹指神通2招
		CC.KFMove[18]={
		{'弹指一瞬',1200,2},
		{'踏月香华',1200,2},
		{'弹冠相庆',1200,3},
		{'日月如梭',1200,3},
		}
		--一阳指3招
		CC.KFMove[17]={
		{'颐指气使',1200,2},
		{'梵指南天',1200,2},
		{'指矢天日',1200,3},
		{'紫微伏龙',1200,3},
		}
		--太极拳3招
		CC.KFMove[16]={
		{'野马分鬃',1000,2},
		{'提步探马',1000,2},
		{'双峰贯耳',1000,3},
		{'揽雀尾',1000,3},
		{'白鹤晾翅',1000,4},
		}
		--空明拳3招
		CC.KFMove[15]={
		{'深藏若虚',1200,2},
		{'天马行空',1200,2},
		{'空穴来风',1200,2},
		{'空空如也',1200,3},
		}
		--天山折梅手2招
		CC.KFMove[14]={
		{'踏雪折梅',1200,2},
		{'望梅止渴',1200,2},
		{'别有洞天',1300,3},
		{'天山灵鹫',1300,3},
		{'平淡无奇',1400,4},
		}
		--铁掌1招
		CC.KFMove[13]={
		{'壁立千仞',900,1},
		{'斩钉截铁',900,2},
		{'铁掌莲花',900,3},
		{'一掌镇魂',900,3},
		}
		--落英神剑掌3招
		CC.KFMove[12]={
		{'珞樱缤纷',900,1},
		{'雨急风狂',900,2},
		{'江城飞花',900,2},
		}
		--九阴白骨爪1招
		CC.KFMove[11]={
		{'探微索隐',1100,2},
		{'摧敌首脑',1100,3},
		{'如穿腐土',1100,3},
		{'六阴已极',1100,4},
		{'冥华幻灭',1100,4},
		{'犹鬼神幽',1100,5},
		}
		--百花错拳2招
		CC.KFMove[10]={
		{'红花天梦',800,1},
		{'天池缭乱',800,2},
		{'走马观花',800,2},
		}
		--白驼雪山掌1招
		CC.KFMove[9]={
		{'雪山白驼',800,1},
		{'飞鸿踏雪',800,2},
		{'雪上加霜',800,2},
		}
		--天山六阳掌3招
		CC.KFMove[8]={
		{'阳歌天钧',900,1},
		{'阳春白雪',900,2},
		{'阳关三叠',900,2},
		{'阳煦山立',900,3},
		}
		--绵掌1招
		CC.KFMove[7]={
		{'连绵不绝',700,1},
		{'连绵不断',700,2},
		{'连绵不休',700,2},
		}
		--美女拳法3招
		CC.KFMove[6]={
		{'红玉击鼓',700,1},
		{'文姬归汉',700,2},
		{'木兰弯弓',700,2},
		}
		--寒冰绵掌1招
		CC.KFMove[5]={
		{'寒冰封体',700,1},
		{'冰雪严寒',700,2},
		{'冰厚三尺',700,2},
		{'冰销蚀骨',700,2},
		}
		--鹰爪功2招
		CC.KFMove[4]={
		{'锁喉',700,1},
		{'探目',700,2},
		{'撩阴',700,2},
		}
		--五毒神掌1招
		CC.KFMove[3]={
		{'五毒摧心',700,1},
		{'五毒俱全',700,2},
		{'五毒不丈夫',700,2},
		}
		--逍遥游
		CC.KFMove[2]={
			{'逍遥游',250,1},
			}	
		--罗汉拳
		CC.KFMove[1]={
		{'童子摘葱',250,0},
		{'童子拜佛',250,2},
		}


		CC.InTeam_ID = {}
		--离队人员列表: {人员id，离队调用函数}      ----如果有新的离队人员加入，直接在这里增加
		CC.PersonExit = {
			[1]=100, 
			[2]=102,
			[4]=104,
			[9]=106,
			[16]=108,
			[17]=110,
			[25]=112,
			[28]=114,
			[29]=116,
			[30]=118,
			[35]=120,
			[36]=122,
			[37]=124,
			[38]=126,
			[44]=128,
			[45]=130,
			[47]=132,
			[48]=134,
			[49]=136,
			[51]=138,
			[52]=140,
			[53]=142,
			[54]=144,
			[55]=146,
			[56]=148,
			[58]=150,
			[59]=152,
			[63]=154,
			[66]=156,
			[72]=158,
			[73]=160,
			[74]=162,
			[75]=164,
			[76]=166,
			[77]=168,
			[78]=170,
			[79]=172,
			[80]=174,
			[81]=176,
			[82]=178,
			[83]=180,
			[84]=182,
			[85]=184,
			[86]=186,
			[87]=188,
			[88]=190,
			[89]=192,
			[90]=194,
			[91]=196,
			[92]=198,
			[104]=80011,
			[105]=80012, 
			[171]=11009, --孩子
			[172]=11009, -- 孩子

			[151]=11004, --文泰来
			[154]=11002, --骆冰
			[161]=4183,  --李莫愁
			[539]=80013,  --备用(原乔峰)		
			[545]=11008,--苗若兰
			[566]=11006, --袁冠南
			[569]=11003, --李沅芷
			[574]=11005,  --萧铃
			[581]=80014,  --丁当
			[582]=80015,  --白绣		
			[587]=11007,  --袁紫衣
			[589]=8005,  --水笙
			[590]=8650,  --李文秀
			[601]=4138,  --韦小宝
			[604]=11001, --阿青
			[607]=4202,	--焦万尔
			[609]=4250,	--赵敏
			[626]=4184,	--郭襄
			[629]=4200,	--阿九
			[631]=4209,	--周芷若
			[646]=4249,	--殷离
			[738]=11010,--胡夫人
			
			
		}

		--所有可加入人员离队需要清除的D*事件，清除后这些人就找不到了。得到神杖时使用
		--1酒食材 2食物食材 3药品药材 4装备 5暗器 6拳法 7指法 8剑法 9刀法 10奇门 11内功 12轻功 13杂学 14 宝物
		CC.AllPersonExit={ 
			{1, 5,0,0},--胡斐
			{2, 6,3,0},--程灵素
			{4, 21,0,0},--閻基
			{9, 17,0,0},--張無忌
			{16, 31,0,0},--胡青牛
			{17, 32,3,0},--王難姑
			{25, 28,1,0},--藍鳳凰
			{28, 29,0,0},--平一指
			{29, 26,0,0},--田伯光
			{30, 13,0,0},--t备用
			{35, 15,0,0},--令狐沖
			{36, 25,0,0},--林平之
			{37, {7,8},0,0},--狄雲
			{38, {16,58},0,0},--石破天
			{44, 33,0,0},--嶽老三
			{45, 12,0,0},--薛慕華
			{47, 23,5,0},--阿紫
			{48, 24,0,0},--遊坦之
			{49, {10,11},0,0},--虛竹
			{51, 22,0,0},--慕容複
			{52, 41,0,0},--花鐵幹
			{53, 9,0,0},--段譽
			{54, 18,0,0},--袁承志
			{55, 13,0,0},--郭靖
			{56, 14,0,0},--黃蓉
			{58, 19,0,0},--楊過
			{59, 20,8,0},--小龍女
			{63, 30,13,0},--程英
			{66, 38,11,0},--小昭
			{72, 40,0,0},--田歸農
			{73, 35,10,0},--任盈盈
			{74, 36,8,0},--霍青桐
			{75, 37,0,0},--陳家洛
			{76, 27,13,0},--王語嫣
			{77, 39,9,0},--蕭中慧
			{78, 59,7,0},--梅超風
			{79, 42,8,0},--嶽靈珊
			{80, 52,0,0},--張召重
			{81, 46,7,0},--朱九真
			{82, 54,0,0},--宋青書
			{83, 55,5,0},--何鐵手
			{84, 34,0,0},--霍都
			{85, 47,0,0},--貝海石
			{86, 49,2,0},--阿珂
			{87, 50,1,0},--蘇荃
			{88, 43,0,0},--祖千秋
			{89, 44,0,0},--人廚子
			{90, 53,6,0},--鐘靈
			{91, 51,4,0},--溫青青
			{92, 1,11,0},   --喵太極
			{104, 51,3,0},	--阿朱
			{105, 51,2,0},	--阿碧
			{151, 115,0,0},	--文泰来
			{154, 112,4,0},	--骆冰
			{161, 99,5,0},	--李莫愁
			{171, 128,4,0},	--孩子
			{172, 128,4,0},	--孩子
			{539, 51,0,0},--备用（原乔峰）
			{566, 117,0,0},--袁冠南
			{569, 113,5,0},	--李沅芷
			{574, 110,6,0},	--李清露
			{581, 51,9,0},--丁當
			{582, 51,8,0},--白繡
			{587, 124,10,0},	--袁紫衣
			{545, 125,8,0},	--苗若兰
			{589, 80,13,0},--水笙
			{590, 86,4,0},--李文秀
			{601, 48,0,0},	--韦小宝
			{604, 100,8,0},	--阿青
			{607, 126,2,0},	--焦婉儿607	
			{609, 105,4,0},	--赵敏
			{626, 120,6,0},	--郭襄
			{629, 51,8,0},	--阿九
			{631, 105,4,0},	--芷若			
			{646, 106,3,0},	--殷离	
			{738, 127,3,0},			--胡夫人738							
				};

		CC.BookNum=14;               --天书个数
		CC.BookStart=144;            --14天书起始物品id

		CC.MoneyID=174;              --金钱物品id
		CC.MJCZID=550;              --金钱物品id
		CC.Shemale = {[93] = 1}
		CC.Shemale2 = {[370] = 1}
		CC.BBH= 198045761

		--特效帧数 特效贴图
		--特效帧数
		CC.Effect = {
		14, 	--特效1 Blue puff
		17, 	--特效2 Water drop
		9, 		--特效3 Thin yellow line with tiny pink circle at bottom
		13, 	--特效4 Tiny yellow splashing
		17, 	--特效5 Water drop with thunder like effect
		17, 	--特效6 Water drop with thunder like effect + yellow flames rising
		17, 	--特效7 Vertical red flame fading
		18, 	--特效8	Ice falling then breaking
		19, 	--特效9 Bright yellow explotion smoke
		19, 	--特效10 yellow flames rising
		15, 	--特效11 Small blood spilling
		13, 	--特效12 Small blood spilling (fewer frames)
		10, 	--特效13 Black half circle splashing
		10, 	--特效14 Red half circle splashing
		15, 	--特效15 Tiny tornado exploding
		21, 	--特效16 blood spilling with tiny yellow explotion
		16, 	--特效17
		9, 		--特效18
		11, 	--特效19
		8, 		--特效20
		9, 		--特效21
		8, 		--特效22
		8, 		--特效23
		7, 		--特效24
		8, 		--特效25
		8, 		--特效26
		9, 		--特效27
		12, 	--特效28
		19, 	--特效29
		11, 	--特效30
		14, 	--特效31 Yellow puff
		12, 	--特效32
		17, 	--特效33
		8, 		--特效34
		11, 	--特效35
		10, 	--特效36
		13, 	--特效37
		10, 	--特效38 
		19, 	--特效39 Bright yellow mushroom cloud
		14, 	--特效40
		17, 	--特效41
		19, 	--特效42
		14, 	--特效43
		21, 	--特效44
		16, 	--特效45
		13, 	--特效46
		18, 	--特效47
		14, 	--特效48
		17, 	--特效49
		17, 	--特效50
		16, 	--特效51
		7, 		--特效52 Tiny mushroom cloud
		12, 	--特效53 Yellow dragon rising(badly drawn)
		40, 	--特效54 Beige ghost like smoke
		16, 	--特效55
		9, 		--特效56
		15, 	--特效57
		15, 	--特效58 Classic explotion flame
		31, 	--特效59
		38, 	--特效60 Swords falling
		24, 	--特效61
		26, 	--特效62 Swords falling(fewer and faded)
		24, 	--特效63 北冥
		20, 	--特效64 化功
		12, 	--特效65
		17, 	--特效66
		14, 	--特效67
		14, 	--特效68
		10, 	--特效69
		10, 	--特效70
		18, 	--特效71 吸星
		31, 	--特效72
		12, 	--特效73
		7, 		--特效74
		6, 		--特效75
		7, 		--特效76
		28, 	--特效77
		16, 	--特效78
		7, 		--特效79
		16, 	--特效80
		20, 	--特效81
		15, 	--特效82
		13, 	--特效83
		15, 	--特效84
		11, 	--特效85
		11, 	--特效86
		11, 	--特效87
		20, 	--特效88
		20, 	--特效89
		20, 	--特效90
		17, 	--特效91
		17, 	--特效92
		17, 	--特效93
		9, 		--特效94
		8, 		--特效95
		8, 		--特效96
		17, 	--特效97
		10, 	--特效98
		11, 	--特效99
		8, 		--特效100
		29, 	--特效101
		6, 		--特效102
		13, 	--特效103
		31, 	--特效104
		14, 	--特效105
		4, 		--特效106
		13, 	--特效107 two blades
		13, 	--特效108
		15,		--特效109
		24; 	--特效110 打狗
		20; 	--特效111 降龙
		12; 	--特效112 
		16; 	--特效113 blue serpent
		18; 	--特效114 yellow tornado
		17; 	--特效115 red lights flailing
		14; 	--特效116 ice breaking
		12; 	--特效117 dark serpent
		19; 	--特效118 Old school explotion
		16; 	--特效119 Yellow cross explotion
		12; 	--特效120 Red light rising
		14; 	--特效121 Light green explotion
		14; 	--特效122 Fire arrow
		6; 		--特效123 Devil face
		8; 		--特效124 Fire explosion
		24; 	--特效125 Light slashing
		19; 	--特效126 Yellow cosmic explosion
		16; 	--特效127 Small burning explotion
		14; 	--特效128 Heart shaped explotion
		20; 	--特效129 Violet halo
		18;		--特效130 五轮
		16;		--特效131 lightning
		13;		--特效132 bright light swords surrounding
		25;		--特效133 Flame ring
		20;		--特效134 连珠腐尸毒
		13;		--特效135 blizzard shield
		22;		--特效136 blue spiral
		35;		--特效137 Pink saber
		11;		--特效138 进阶太岳
		17;		--特效139 进阶云雾
		25;		--特效140 进阶万岳
		23;		--特效141 进阶万花
		16;		--特效142 进阶闪光的佛
		11;		--特效143 thin orange flame
		13;		--特效144 thin blue flame
		7;		--特效145 口才
		14;		--特效146 破军
		27;		--特效147 yellow halo
		16;		--特效148 poison
		14;		--特效149 倾国
		44;		--特效150 nuclear explosion
		12;		--特效151 集中
		16;		--特效152 ice entangle
		14;		--特效153 梯云纵
		18;		--特效154 fire bird
		11;		--特效155 万字
		17;		--特效156 金钟
		12;		--特效157 血骷髅
		12;		--特效158 莲花	
		17;     --特效159 太极
		14;      --特效160 --
		11;      --特效161 --
		12;      --特效162 --	剑1
		17;      --特效163 --	剑2	
		11;      --特效164 --	大剑
		9;      --特效165 --	文字
		24;      --特效166 --	八卦
		3;      --特效167 --	八卦1	
		19;      --特效168 --	酒神
		28;      --特效169 --	万佛朝宗	
		9;      --特效170 --	开太极	
		15;      --特效171 --	暴炸
		17;      --特效172 --	龙拳风	
		22;      --特效173 --	世尊降魔
		17;      --特效174 --	冰爆
		19;      --特效175 --	护盾1  	
		25;      --特效176 --	不屈战魂
		3;      --特效177 --	蓝雾
		10;      --特效178 --	红雾
		9;      --特效179 --	紫雾
		19;      --特效180 --	蓝	
		8;      --特效181 --	风
		42;      --特效182 --	如来	
		10;      --特效183 --	万字
		12;      --特效184 --	黑洞龙	
		10;      --特效185 --	剑忍风暴
		10;      --特效186 --	惊雷咒
		7;      --特效187 --	九阴白骨	
		3;      --特效188 --	开天辟地
		12;      --特效189 --	光盾	
		17;      --特效190 --	乾元
		30;      --特效191 --	降龙
		27;      --特效192 --	降龙1
		10;      --特效193 --	尸鬼封尽蓝
		10;      --特效194 --	尸鬼封尽红
		18;      --特效195 --	金蛇
		10;      --特效196 --	格档盾	
		19;      --特效197 --	般若掌特效
		20;      --特效198 --	霸王卸甲
		20;      --特效199 --	火焰刀
		22;      --特效200--	春风化雨
		[0] = 9,	--特效0	Tiny heart(when heal) --治疗
		}
	--特效帧数1
	CC.Effect1 = {		
		[0] ={9,0,9},--特效0	Tiny heart(when heal) --治疗	
		[1]={14,10,23},	--特效1 10~23 Blue puff
		[2]={17,24,40},	--特效2 24~40 Water drop
		[3]={9,41,50},	--特效3 41~50 Thin yellow line with tiny pink circle at bottom
		[4]={12,51,62}, 	--特效4 51~62 Tiny yellow splashing
		[5]={17,63,79},	--特效5 63~79 Water drop with thunder like effect
		[6]={17,80,96},	--特效6 80~96 Water drop with thunder like effect + yellow flames rising
		[7]={17,97,113},	--特效7 97~ Vertical red flame fading
		[8]={18,114,131}, --特效8	Ice falling then breaking
		[9]={19,132,150}, --特效9 Bright yellow explotion smoke
		[10]={19,151,169}, 	--特效10 yellow flames rising
		[11]={15,170,184},	--特效11 Small blood spilling
		[12]={13,185,197}, 	--特效12 Small blood spilling (fewer frames)
		[13]={10,198,207},	--特效13 Black half circle splashing
		[14]={10,208,217}, 	--特效14 Red half circle splashing
		[15]={15,218,232},	--特效15 Tiny tornado exploding
		[16]={21,233,253}, 	--特效16 blood spilling with tiny yellow explotion
		[17]={16,254,269}, 	--特效17
		[18]={9,270,278}, --特效18
		[19]={11,279,289}, --特效19
		[20]={8,290,297},--特效20
		[21]={9,298,306}, --特效21
		[22]={8,307,314},  --特效22
		[23]={8,315,322,},--特效23
		[24]={7,323,329,},--特效24
		[25]={8,330,337,},--特效25
		[26]={8,338,345,},--特效26
		[27]={9,346,354,},--特效27
		[28]={12,355,366,},--特效28
		[29]={19,367,385,},--特效29
		[30]={11,386,396,},--特效30
		[31]={14,397,410,},--特效31Yellowpuff
		[32]={12,411,422,},--特效32
		[33]={17,423,439,},--特效33
		[34]={8,440,447,},--特效34
		[35]={11,448,458,},--特效35
		[36]={10,459,468,},--特效36
		[37]={13,469,481,},--特效37
		[38]={10,482,491,},--特效38
		[39]={19,492,510,},--特效39Brightyellowmushroomcloud
		[40]={14,511,524,},--特效40
		[41]={17,525,541,},--特效41
		[42]={19,542,560,},--特效42
		[43]={14,561,574,},--特效43
		[44]={21,575,595,},--特效44
		[45]={16,596,611,},--特效45
		[46]={13,612,624,},--特效46
		[47]={18,625,642,},--特效47
		[48]={14,643,656,},--特效48
		[49]={17,657,673,},--特效49
		[50]={17,674,690,},--特效50
		[51]={16,691,706,},--特效51
		[52]={7,707,713,},--特效52Tinymushroomcloud
		[53]={12,714,725,},--特效53Yellowdragonrising(badlydrawn)
		[54]={40,726,765,},--特效54Beigeghostlikesmoke
		[55]={16,766,781,},--特效55
		[56]={9,782,790,},--特效56
		[57]={15,791,805,},--特效57
		[58]={15,806,820,},--特效58Classicexplotionflame
		[59]={31,821,851,},--特效59
		[60]={38,852,889,},--特效60Swordsfalling
		[61]={24,890,913,},--特效61
		[62]={26,914,939,},--特效62Swordsfalling(fewerandfaded)
		[63]={24,940,963,},--特效63北冥
		[64]={20,964,983,},--特效64化功
		[65]={12,984,995,},--特效65
		[66]={17,996,1012,},--特效66
		[67]={14,1013,1026,},--特效67
		[68]={14,1027,1040,},--特效68
		[69]={10,1041,1050,},--特效69
		[70]={10,1051,1060,},--特效70
		[71]={18,1061,1078,},--特效71吸星
		[72]={31,1079,1109,},--特效72
		[73]={12,1110,1121,},--特效73
		[74]={7,1122,1128,},--特效74
		[75]={6,1129,1134,},--特效75
		[76]={7,1135,1141,},--特效76
		[77]={28,1142,1169,},--特效77
		[78]={16,1170,1185,},--特效78
		[79]={7,1186,1192,},--特效79
		[80]={16,1193,1208,},--特效80
		[81]={20,1209,1228,},--特效81
		[82]={15,1229,1243,},--特效82
		[83]={13,1244,1256,},--特效83
		[84]={15,1257,1271,},--特效84
		[85]={11,1272,1282,},--特效85
		[86]={11,1283,1293,},--特效86
		[87]={11,1294,1304,},--特效87红
		[88]={20,1305,1324,},--特效88黄罩 阳内护体
		[89]={20,1325,1344,},--特效89红罩 调和内护体
		[90]={20,1345,1364,},--特效90蓝罩 阴内护体
		[91]={17,1365,1381,},--特效91黄圈 金阳内加力 
		[92]={17,1382,1398,},--特效92红圈 调和内加力
		[93]={17,1399,1415,},--特效93蓝圈 阴内加力
		[94]={9,1416,1424,},--特效94
		[95]={8,1425,1432,},--特效95
		[96]={8,1433,1440,},--特效96
		[97]={17,1441,1457,},--特效97
		[98]={10,1458,1467,},--特效98
		[99]={11,1468,1478,},--特效99
		[100]={8,1479,1486,},--特效100
		[101]={29,1487,1515,},--特效101
		[102]={6,1516,1521,},--特效102
		[103]={13,1522,1534,},--特效103
		[104]={31,1535,1565,},--特效104
		[105]={14,1566,1579,},--特效105
		[106]={4,1580,1583,},--特效106
		[107]={13,1584,1596,},--特效107twoblades
		[108]={13,1597,1609,},--特效108
		[109]={15,1610,1624,},--特效109
		[110]={24,1625,1648,},--特效110打狗
		[111]={20,1649,1668,},--特效111降龙
		[112]={12,1669,1680,},--特效112
		[113]={16,1681,1696,},--特效113blueserpent
		[114]={18,1697,1714,},--特效114yellowtornado
		[115]={17,1715,1731,},--特效115redlightsflailing
		[116]={14,1732,1745,},--特效116icebreaking
		[117]={12,1746,1757,},--特效117darkserpent
		[118]={19,1758,1776,},--特效118Oldschoolexplotion霸体
		[119]={16,1777,1792,},--特效119Yellowcrossexplotion
		[120]={12,1793,1804,},--特效120Redlightrising
		[121]={14,1805,1818,},--特效121Lightgreenexplotion
		[122]={14,1819,1832,},--特效122Firearrow
		[123]={6,1833,1838,},--特效123Devilface
		[124]={8,1839,1846,},--特效124Fireexplosion
		[125]={24,1847,1870,},--特效125Lightslashing
		[126]={19,1871,1889,},--特效126Yellowcosmicexplosion
		[127]={16,1890,1905,},--特效127Smallburningexplotion
		[128]={14,1906,1919,},--特效128Heartshapedexplotion
		[129]={20,1920,1939,},--特效129Violethalo
		[130]={18,1940,1957,},--特效130五轮
		[131]={16,1958,1973,},--特效131lightning
		[132]={13,1974,1986,},--特效132brightlightswordssurrounding
		[133]={25,1987,2011,},--特效133Flamering
		[134]={20,2012,2031,},--特效134连珠腐尸毒
		[135]={13,2032,2044,},--特效135blizzardshield
		[136]={22,2045,2066,},--特效136bluespiral
		[137]={35,2067,2101,},--特效137Pinksaber
		[138]={11,2102,2112,},--特效138进阶太岳
		[139]={17,2113,2129,},--特效139进阶云雾
		[140]={25,2130,2154,},--特效140进阶万岳
		[141]={23,2155,2177,},--特效141进阶万花
		[142]={16,2178,2193,},--特效142进阶闪光的佛
		[143]={11,2194,2204,},--特效143thinorangeflame
		[144]={13,2205,2217,},--特效144thinblueflame
		[145]={7,2218,2224,},--特效145口才
		[146]={14,2225,2238,},--特效146破军
		[147]={27,2239,2265,},--特效147yellowhalo
		[148]={16,2266,2281,},--特效148poison
		[149]={14,2282,2295,},--特效149倾国
		[150]={44,2296,2339,},--特效150nuclearexplosion
		[151]={12,2340,2351,},--特效151集中
		[152]={16,2352,2367,},--特效152iceentangle
		[153]={14,2368,2381,},--特效153梯云纵
		[154]={18,2382,2399,},--特效154firebird
		[155]={11,2400,2410,},--特效155万字
		[156]={17,2411,2427,},--特效156金钟
		[157]={12,2428,2439,},--特效157血骷髅
		[158]={12,2440,2451,},--特效158莲花
		[159]={17,2452,2468,},--特效159太极
		[160]={14,2469,2482,},--特效160
		[161]={11,2483,2493,},--特效161
		[162]={12,2494,2505,},--特效162剑1
		[163]={17,2506,2522,},--特效163剑2
		[164]={11,2523,2533,},--特效164大剑
		[165]={9,2534,2542,},--特效165文字
		[166]={24,2543,2566,},--特效166八卦
		[167]={3,2567,2569,},--特效167八卦1
		[168]={19,2570,2588,},--特效168酒神
		[169]={28,2589,2616,},--特效169万佛朝宗
		[170]={9,2617,2625,},--特效170开太极
		[171]={15,2626,2640,},--特效171暴炸
		[172]={17,2641,2657,},--特效172龙拳风
		[173]={22,2658,2679,},--特效173世尊降魔
		[174]={17,2680,2696,},--特效174冰爆
		[175]={19,2697,2715,},--特效175护盾1
		[176]={25,2716,2740,},--特效176不屈战魂
		[177]={3,2741,2743,},--特效177蓝雾
		[178]={10,2744,2753,},--特效178红雾
		[179]={9,2754,2762,},--特效179紫雾
		[180]={19,2763,2781,},--特效180蓝
		[181]={8,2782,2789,},--特效181风
		[182]={42,2790,2831,},--特效182如来
		[183]={10,2832,2841,},--特效183万字
		[184]={12,2842,2853,},--特效184黑洞龙
		[185]={10,2854,2863,},--特效185剑忍风暴
		[186]={10,2864,2873,},--特效186惊雷咒
		[187]={7,2874,2880,},--特效187九阴白骨
		[188]={3,2881,2883,},--特效188开天辟地
		[189]={12,2884,2895,},--特效189光盾
		[190]={17,2896,2912,},--特效190乾元
		[191]={30,2913,2942,},--特效191降龙
		[192]={27,2943,2969,},--特效192降龙1
		[193]={10,2970,2979,},--特效193尸鬼封尽蓝
		[194]={10,2980,2989,},--特效194尸鬼封尽红
		[195]={18,2990,3007,},--特效195金蛇
		[196]={10,3008,3017,},--特效196格档盾
		[197]={19,3018,3036,},--特效197般若掌特效
		[198]={20,3037,3056,},--特效198霸王卸甲
		[199]={20,3057,3076,},--特效199火焰刀
		[200]={22,3077,3098,},--特效200春风化雨
		}	
		
	--装备对威力的加成
	CC.ExtraOffense = {
				{52, 75, 100},		--鳄嘴剪+大剪刀
				{45, 67, 100},		--冷月宝刀+胡刀
				{43, 382, 500},		--屠龙刀+屠龙刀法
				{202, 67, 100},		--闯王军刀+胡刀
				{37, 41, 100},		--倚天剑+灭剑
				{49, 80, 200},		--打狗棒+打狗棒法
				{44, 63, 200},		--血刀+血刀
				{40, 40, 200},		--金蛇剑+金蛇
				{36, 45, 100},		--玄铁剑+玄铁
				{276, 155, 3000},	--火枪+火枪
				{51, 78, 200},		--金龙鞭+黄沙万里鞭法
				{50, 86, 100},		--伏魔杵+伏魔杖法
				{241, 39, 100},		--君子剑+全真剑法
				{242, 42, 100},		--淑女剑+玉女剑法
				{244, 81, 200},		--西毒蛇杖+灵蛇杖法
				{55, 110, 100},		--神山剑+神山剑法
				{56, 111, 100},		--玄铁菜刀+西瓜刀法
				{57, 112, 100},		--犽月+犽月流空
				{243, 77, 200},		--金刀黑剑+阴阳倒乱刃
				{39, 44, 100},		--白龙剑+苗家剑法
				{236, 46, 100},		--真武剑+太极剑法
				{326,156,200},
				{326,188,200},
	}

    CC.NewPersonName=CONFIG.PlayName;                --新游戏的数据
	
    CC.NewGameSceneID = 70
	CC.NewGameSceneX = 16
	CC.NewGameSceneY = 31
	CC.NewGameEvent = 691
	CC.NewPersonPicM = 2515
	CC.NewPersonPicF = 5015

	CC.PersonAttribMax = {}
	CC.PersonAttribMax["经验"] = 60000
	CC.PersonAttribMax["物品修炼点数"] = 60000
	CC.PersonAttribMax["修炼点数"] = 30000
	CC.PersonAttribMax["生命最大值"] = 9999
	CC.PersonAttribMax["受伤程度"] = 100
	CC.PersonAttribMax["中毒程度"] = 200
	CC.PersonAttribMax["内力最大值"] = 9999
	CC.PersonAttribMax["体质"] = 20
	CC.PersonAttribMax["体力"] = 100
	CC.PersonAttribMax["攻击力"] = 999
	CC.PersonAttribMax["防御力"] = 999
	CC.PersonAttribMax["轻功"] = 999
	CC.PersonAttribMax["医疗能力"] = 200
	CC.PersonAttribMax["用毒能力"] = 200
	CC.PersonAttribMax["解毒能力"] = 200
	CC.PersonAttribMax["抗毒能力"] = 200
	CC.PersonAttribMax["拳掌功夫"] = 500
	CC.PersonAttribMax["指法技巧"] = 500
	CC.PersonAttribMax["御剑能力"] = 500
	CC.PersonAttribMax["耍刀技巧"] = 500
	CC.PersonAttribMax["特殊兵器"] = 500
	CC.PersonAttribMax["暗器技巧"] = 200
	CC.PersonAttribMax["武学常识"] = 200
	CC.PersonAttribMax["品德"] = 120
	CC.PersonAttribMax["资质"] = 100
	CC.PersonAttribMax["攻击带毒"] = 200
	CC.PersonAttribMax["冰封程度"] = 100
	CC.PersonAttribMax["灼烧程度"] = 50
    CC.PersonAttribMax["实战"] = 500
	CC.PersonAttribMax["门派贡献"] = 1999
	CC.PersonAttribMax["能量"] = 999
	CC.PersonAttribMax["武学点数"] = 5000
	CC.PersonAttribMax["基础生命"] = 999
    
    CC.WarDataSize=186;         --战斗数据大小  war.sta数据结构
    CC.WarData_S={};        --战斗数据结构
    CC.WarData_S["代号"]={0,0,2};
    CC.WarData_S["名称"]={2,2,10};
    CC.WarData_S["地图"]={12,0,2};
    CC.WarData_S["经验"]={14,0,2};
    CC.WarData_S["音乐"]={16,0,2};
    for i=1,6 do
        CC.WarData_S["手动选择参战人"  .. i]={18+(i-1)*2,0,2}; --队友
        CC.WarData_S["自动选择参战人"  .. i]={30+(i-1)*2,0,2}; -- 自动队友
        CC.WarData_S["我方X"  .. i]={42+(i-1)*2,0,2}; 
        CC.WarData_S["我方Y"  .. i]={54+(i-1)*2,0,2};
    end
    for i=1,20 do
        CC.WarData_S["敌人"  .. i]={66+(i-1)*2,0,2};
        CC.WarData_S["敌方X"  .. i]={106+(i-1)*2,0,2};
        CC.WarData_S["敌方Y"  .. i]={146+(i-1)*2,0,2};
    end

    CC.WarWidth=64;        --战斗地图大小
    CC.WarHeight=64;

	--显示主地图和场景地图坐标
	--如果显示坐标，则会增加cpu占用。机器速度慢的话可能会卡。这个在调试时有用。
	CC.ShowXY=1      --0 不显示 1 显示


	--以下为控制显示方式的参数
	CC.MenuBorderPixel=5  -- 菜单四周边框留的像素数，也用于绘制字符串的box四周留得像素

	CC.DefaultFont=math.modf(math.min(CC.ScreenW,CC.ScreenH) / 320 * 14);
	CC.SmallFont = CC.DefaultFont*3/4;
	CC.FontBIG = math.modf(CC.DefaultFont*1.45)
	CC.FontBig = math.modf(CC.DefaultFont*1.3)
	CC.Fontbig = math.modf(CC.DefaultFont*1.15)
	CC.Fontsmall = math.modf(CC.DefaultFont*0.85)
	CC.FontSmall = math.modf(CC.DefaultFont*0.7)
	CC.FontSmall2 = math.modf(CC.DefaultFont*0.65)
	CC.FontSmall3 = math.modf(CC.DefaultFont*0.635)
	CC.FontSmall4 = math.modf(CC.DefaultFont*0.9)
	CC.FontSmall5 = math.modf(CC.DefaultFont*0.92)
	CC.FontSMALL = math.modf(CC.DefaultFont*0.55)
	CC.RowPixel = math.modf(math.min(CC.ScreenW, CC.ScreenH) / 100)

	--CC.StartMenuY= 160       --开始菜单Y坐标
	CC.StartMenuFontSize=CC.DefaultFont  --开始菜单字号

	--CC.NewGameY= 160         --新游戏属性显示Y坐标
	CC.NewGameFontSize =CC.DefaultFont   --新游戏属性选择字号


	CC.MainMenuX=10;         --主菜单开始坐标
	CC.MainMenuY=10;

	CC.GameOverX=90;
	CC.GameOverY=65;

    CC.PersonStateRowPixel= 5;    --显示人物状态行间距像素
    
    --物品显示定义
    CC.ThingFontSize = CC.Fontsmall;
		
	--CC.ThingPicWidth=math.modf(100*CONFIG.Zoom/100);    --物品图片宽高
	CC.ThingPicWidth=100	--物品图片固定尺寸
	CC.ThingPicHeight=CC.ThingPicWidth;

	local n = math.modf(CC.ScreenW/CC.ThingPicWidth-2);			--一行显示几个物品
	if n < 10 then	
		CC.MenuThingXnum = 9;				
	else
		CC.MenuThingXnum = 9
	end
	--周目商店一行显示物品
	if n < 6 then
		CC.MXZM = 5
	else
		CC.MXZM = 5
	end	
	local m = math.modf(CC.ScreenH/CC.ThingPicHeight-2);		--物品显示几列
	if m < 5 then	
		CC.MenuThingYnum = 5;
	else
		CC.MenuThingYnum = 5;
	end

	CC.ThingGapOut=4;		--物品图像显示四周留白
	CC.ThingGapIn=4;		--物品图像显示中间间隔	

    CC.StartMenuY=CC.ScreenH-3*(CC.StartMenuFontSize+CC.RowPixel)-20;
	CC.NewGameY=CC.ScreenH-4*(CC.NewGameFontSize+CC.RowPixel)-10;

	--子菜单的开始坐标
	CC.MainSubMenuX=CC.MainMenuX+2*CC.MenuBorderPixel+2*CC.DefaultFont+5;       --主菜单为两个汉字
	CC.MainSubMenuY=CC.MainMenuY;

	--二级子菜单开始坐标
	CC.MainSubMenuX2=CC.MainSubMenuX+2*CC.MenuBorderPixel+4*CC.DefaultFont+5;   --子菜单为四个字符

	CC.SingleLineHeight=CC.DefaultFont+2*CC.MenuBorderPixel+5;  --带框的单行字符高

	CC.StartThingPic = 0
	
	CC.AutoMoveEvent = {[0]=0};		--鼠标操作时是否触发事件， 第一个位置0未触发， 1触发， 2触发并且能够走到面前， 第二和第三个位置为XY坐标
	CC.MMapAdress = {};				--大地图地址
	XL18JY = {"极意--亢龙·鸿渐於陆", "极意--飞龙·或跃在渊", "极意--潜龙·密雨不云", "极意--神龙·震惊百里", "极意--见龙·利涉大川", "极意--双龙·突如其来", "极意--六龙·履霜冰至", "极意--龙战·损则有孚"}
	TFSSJ = {"·『天道惊雷憾』", "·『点墨山河』", "·『一剑镇神洲』", "·『羽葬煌炎斩』", "·『千机龙绝闪』", "·『化气御九天』", "·『仁者无敌』", "·『八门聚万象』", "·『天人五衰』"}
	ZJTF = {"盖世神拳", "灵犀一指", "剑神一笑", "傲世狂刀", "奇门无双", "绝世天罡", "仁者无敌", "回天圣手", "欲天摩罗"}
	TFE = {"拳", "指", "剑", "刀", "特", "罡", "仁", "医", "毒"}
	SJHBJFZS = {"双剑合璧--清饮小酌", "双剑合璧--浪迹天涯", "双剑合璧--举案齐眉", "双剑合璧--皓腕玉镯", "双剑合璧--冷月窥人", 
	"双剑合璧--竹帘临池","双剑合璧--大江似练", "双剑合璧--斜风细雨", "双剑合璧--星河欲转", "双剑合璧--桃花流水"}
	TSTF = {nil, "影帝"}
	ZHEN = {"真武七截阵","十八罗汉阵","天罡北斗阵","九宫八卦阵","五行光明阵","两仪剑阵","打狗大阵"}
	--实战经验
	WARSZJY = {3, 2, 5, 2, 20, 15, 5, 5, 5, 5, 5, 5, 5, 5, 3, 2, 2,
	10, 5, 4, 4, 5, 4, 2, 2, 10, 20, 2, 3, 3, 3, 3, 3, 3, 5, 3, 4, 4,
	8, 8, 4, 4, 4, 4, 2, 5, 3, 4, 3, 15, 4, 2, 3, 3, 4, 4, 15, 5, 5,
	15, 3, 15, 3, 15, 10, 2, 8, 3, 15, 7, 8, 3, 3, 3, 4, 2, 2, 2, 2,
	4, 2, 2, 2, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 7, 7, 4, 4, 2,
	2, 12, 2, 2, 2, 3, 3, 3, 3, 3, 7, 7, 25, 3, 3, 5, 6, 3, 3, 3, 3,
	3, 3, 3, 3, 3, 3, 10, 3, 3, 3, 3, 3, 3, 3, 2, 3, 2, 35, 2, 2, 2,
	2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
	3, 3, 3, 3, 3, 4, 3, 4, 4, 4, 2, 2, 2, 2, 2, 2, 2, 3, 7, 7, 4, 3, 5, 5, 3}
	CC.BOY = 0
	CC.JISHI = 0
	--称号
	RWWH = {}
	RWWH[1] = "雪山飞狐"
	RWWH[2] = "灵枢素问"
	RWWH[3] = "金面佛"
	RWWH[4] = "雁过拨毛"
	RWWH[5] = "太极宗师"
	RWWH[6] = "灭绝师太"
	RWWH[7] = "铁琴先生"	--何太冲
	RWWH[8] = "崆峒掌门"	--唐文亮
	RWWH[9] = "九阳明尊"
	RWWH[10] = "光明右使"
	RWWH[11] = "光明左使"
	RWWH[12] = "白眉鹰王"
	RWWH[13] = "金毛狮王"
	RWWH[14] = "青翼蝠王"
	RWWH[15] = "紫衫龙王"
	RWWH[16] = "蝶谷医仙"
	RWWH[17] = "蝶谷毒仙"
	RWWH[18] = "混元霹雳手"
	RWWH[19] = "君子剑"
	RWWH[20] = "潇湘夜雨"
	RWWH[21] = "恒山掌门"
	RWWH[22] = "嵩山掌门"
	RWWH[23] = "泰山掌门"
	RWWH[24] = "青城掌门"
	RWWH[25] = "五毒教主"
	RWWH[26] = "日月魔帝"
	RWWH[27] = "风云再起"
	RWWH[28] = "杀人名医"
	RWWH[29] = "万里独行"
	RWWH[30] = "傻小子"
	RWWH[31] = "梅庄四友"
	RWWH[32] = "梅庄四友"
	RWWH[33] = "梅庄四友"
	RWWH[34] = "梅庄四友"
	RWWH[35] = "九剑传人"
	RWWH["35"] = "剑魔再临"
	RWWH[36] = "辟邪剑客"
	RWWH[37] = "真名神照"
	RWWH["38"] = "混沦太玄"
	RWWH[39] = "侠客岛主"
	RWWH[40] = "侠客岛主"
	RWWH[41] = "赏善使者"
	RWWH[42] = "罚恶使者"
	RWWH[43] = "雪山掌门"
	RWWH[44] = "凶神恶煞"
	RWWH[45] = "阎王敌"
	RWWH[46] = "星宿老怪"
	RWWH[47] = "曼珠沙华"
	RWWH[48] = "冰毒怪客"
	RWWH[49] = "小和尚"
	RWWH["49"] = "逍遥掌门"
	RWWH[50] = "狂龙天征"
	RWWH[539] = "狂龙天征"
	RWWH[51] = "姑苏慕容"
	RWWH[52] = "中平神枪"
	RWWH[53] = "六脉真传"
	RWWH[54] = "碧血长风"
	RWWH[55] = "侠之大者"
	RWWH[56] = "兰质蕙心"
	RWWH[57] = "桃花岛主"
	RWWH[58] = "西狂"
	RWWH[59] = "冷若天仙"
	RWWH[60] = "西毒"
	RWWH[62] = "元蒙帝师"
	RWWH[63] = "青箫落瑛"
	RWWH[64] = "顽童武痴"
	RWWH[65] = "南僧"
	RWWH[66] = "波斯圣女"
	RWWH[67] = "铁掌帮主"
	RWWH[68] = "长春子"
	RWWH[69] = "北丐"
	RWWH[71] = "神龙教主"
	RWWH[72] = "天龙掌门"
	RWWH[73] = "日月圣姑"
	RWWH[74] = "翠羽黄衫"
 	RWWH[75] = "天池红花"
	RWWH[76] = "琅嬛仙子"
	RWWH[77] = "秀外慧中"
	RWWH[78] = "铁尸魔煞"
	RWWH[79] = "慧中灵剑"
	RWWH[80] = "火手判官"
	RWWH[81] = "雪岭双姝"
	RWWH[82] = "玉面孟尝"
	RWWH[83] = "五毒教主"
	RWWH[84] = "小王爷"
	RWWH[85] = "老谋深算"
	RWWH[86] = "金枝玉叶"
	RWWH[87] = "媚眼如丝"
	RWWH[88] = "酒神"
	RWWH[89] = "食神"
	RWWH[90] = "毓秀灵姝"	
	RWWH[91] = "青青子衿"
	RWWH[92] = "扑朔迷离"
	RWWH[94] = "仁义刀"
	RWWH[95] = "柔云剑"
	RWWH[96] = "冷月剑"
	RWWH[97] = "血刀老祖"
	RWWH[98] = "恶贯满盈"
	RWWH[101] = "笔砚生"
	RWWH[102] = "天龙禅师"
	RWWH[103] = "大轮明王"
	RWWH[104] = "珠落玉盘"
	RWWH[105] = "吴侬软语"
	RWWH[106] = "金刀无敌"
	RWWH[112] = "震天魔狼"
	RWWH[113] = "参合潜龙"
	RWWH[114] = "达摩再世"
	RWWH[115] = "聪辩先生"
	RWWH[116] = "风月无间"
	RWWH[117] = "不老长春"
	RWWH[118] = "秋水无尘"
	RWWH[129] = "中神通"
	RWWH[131] = "妙手书生"
	RWWH[138] = "一指震江南"	--瓦尔拉齐
	RWWH[140] = "剑术通神"		--风清扬
	RWWH[142] = "狂风快剑"
	RWWH[149] = "少林掌门"
	RWWH[153] = "暗器之王"
	RWWH[154] = "鸳鸯刀"
	RWWH[157] = "湘西尸王"
	RWWH[158] = "波斯大贾"
	RWWH[159] = "瑜伽鬼王"
	RWWH[160] = "尊师重道"		--达尔巴
	RWWH[161] = "赤练仙子"
	RWWH[164] = "摩天居士"
	RWWH[171] = "武当儒侠"
	RWWH[185] = "神剑仙猿"
	RWWH[186] = "神拳无敌"
	RWWH[311] = "天山双鹰"
    RWWH[510] = '曲夕烟隙'
	RWWH[511] = '盗圣'
	RWWH[532] = '武当七侠'
	RWWH[533] = '武当七侠'
	RWWH[534] = '武当七侠'
	RWWH[535] = '武当七侠'
	RWWH[536] = '武当七侠'
	RWWH[537] = '武当七侠'
	RWWH[538] = '武当七侠'
	RWWH[553] = "真田一之兵"
	RWWH[589] = "铃剑侠女"		--水笙
	RWWH[590] = "古道西风"		--李文秀
	RWWH[592] = "无我无剑"		--独孤求败
	RWWH[597] = "金刚伏魔"		--渡厄
	RWWH[598] = "金刚伏魔"		--渡劫
	RWWH[599] = "金刚伏魔"		--渡难
	RWWH[594] = "铁索横江"		--戚长发
	RWWH[601] = "天魁地宝"		--韦小宝
	RWWH[602] = "阴阳怪气"		--海大富
	RWWH[603] = "满洲勇士"		--鳌拜
	RWWH[604] = "越女剑仙"		--阿青
	RWWH[605] = "姑射仙姿"		--林朝英
	RWWH[606] = "西域战神"		--阿凡提
	RWWH[607] = "乱世浮萍"		--焦宛儿
	RWWH[609] = "绍敏郡主"		--赵敏
	RWWH[616] = "绝情谷主"		--公孙止
	RWWH[617] = "铁掌莲花"		--裘千尺
	RWWH[626] = "小东邪"		--郭襄
	RWWH["626"] = "峨眉祖师"
	RWWH[627] = "王霸之气"		--蒙哥
	RWWH[628] = "雕兄"			--神雕
	RWWH[629] = "长平公主"		--阿九
	RWWH[631] = "谁与争锋"		--周芷若
	RWWH[642] = "精心打磨"		--四大山
	RWWH[646] = "绝色佳人"		--殷离
	RWWH[647] = "玄冥二老"		--鹤笔翁
	RWWH[648] = "玄冥二老"		--鹿杖客
	RWWH[649] = "华山玉女"		--宁中则
	RWWH[650] = "小王爷"		--杨康
	RWWH[651] = "影帝"			--张家辉
	RWWH[636] = "青莲剑仙"	    --李白
	RWWH[652] = "神州大侠"	    --萧秋水
	RWWH[635] = "西昆仑"	    --梁萧
	RWWH[497] = "金刚门人"	    --陆渐
	RWWH[498] = "小李探花"	    --李寻欢
	RWWH[638] = "九阳至尊"	    --斗酒僧
	RWWH[640] = "古墓后人"	    --黄衫女
	RWWH[189] = "晋阳大侠"	    --萧半和
	RWWH[633] = "辽东大侠"	    --胡一刀
	RWWH[500] = "剑神"	    --西门吹雪	
	RWWH[588] = "岛主夫人"	--冯蘅	
	RWWH[587] = "紫衣银鞭"	--袁紫衣		
	RWWH[586] = "昆仑三圣"	    --何足道
	RWWH[584] = "不哭死神"	    --
	RWWH[583] = "小尼姑"		--
	RWWH[582] = "冰川天女"		--	
	RWWH[581] = "丁丁当当"		--
	RWWH[580] = "银弧刀"		--	
	RWWH[579] = "盗王之王"	  --司空摘星	
	RWWH[637] = "九阴至尊"	  --黄赏
	RWWH[578] = "大唐双龙"	  --寇仲
	RWWH[634] = "逍遥祖师"	  --	逍遥子
	RWWH[577] = "禅宗始祖"	  --	达摩
	RWWH[569] = "小魔女"	  --	李沅芷
	RWWH[151] = "奔雷手"	  --	文泰来
	RWWH[574] = "寒露清梦"	  --萧玲
	RWWH[613] = "铁掌神鞭"	  
	RWWH[612] = "铁鞭震八方"
	RWWH[614] = "荒野游龙"	
	RWWH[615] = "玉堂飞燕"	
	RWWH[566] = "白衣书生"	
	RWWH[639] = "金蛇郎君"	--	
	RWWH[499] = "大理太祖"	--
	RWWH[313] = "天佛降世"	--	
	RWWH[658] = "天池怪侠"
	RWWH[657] = "悲天佛怜"	
	RWWH[656] = "天怒红颜"
	RWWH[655] = "红粉骷髅"
	RWWH[567] = "千秋侠烈"	
	RWWH[570] = "棉里针"	
	RWWH[571] = "总舵主"	
	RWWH[573] = "仁阳佛光"	
	RWWH[575] = "神剑仙猿"	
	RWWH[576] = "佛门无双"	
	RWWH[641] = "圣火明尊"		
	RWWH[568] = "精忠报国"	
	RWWH[567] = "千秋侠烈"	
	RWWH[650] = "小王爷"	
	RWWH[505] = "大唐双龙"
	RWWH[504] = "太虚剑主"
	RWWH[507] = "琅琊公子"
    RWWH[508] = "琅琊公子"	
    RWWH[513] = "长风万里"	
	RWWH[721] = "黄河老祖"	
	RWWH[546] = "风中之神"
	RWWH[610] = "妙手仁心"
	RWWH[545] = "望雪颦愁"
	RWWH[722] = "八卦高手"
	RWWH[737] = "八卦高手"
	RWWH[724] = "丐帮帮主"
	RWWH[731] = "汤大侠"		--标记修改
	RWWH[737] = "八卦高手"
	RWWH[738] = "冰肌玉骨"
	RWWH[739] = "商家堡主"		--标记修改
	RWWH[740] = "隔壁大王"		--标记修改
	RWWH[741] = "隔壁二王"		--标记修改
	RWWH[752] = "连云七略"
	RWWH[514] = "最强发型师"	--标记修改
	RWWH[757] = "怡红公子"
	RWWH[516] = "雪羽宗主"
							  
	--天赋
	RWTFLB = {}
	RWTFLB[516] = "不归三境"
	RWTFLB[757] = "春哥的自信"
	RWTFLB[752] = "逆水寒"
	RWTFLB[311] = "秃鹰"
	RWTFLB[610] = "流云飞袖"	
	RWTFLB[546] = "入魔"
	RWTFLB[508] = "亘天赤焰"	
	RWTFLB[507] = "江左梅郎"		
	RWTFLB[505] = "九字真言"	
	RWTFLB[650] = "无妄无我"	
	RWTFLB[567] = "傲世神罡"	
	RWTFLB[568] = "决胜千里"		
	RWTFLB[641] = "魔道天行"		
	RWTFLB[576] = "无量禅震"	
	RWTFLB[575] = "闪电惊鸿"			
	RWTFLB[573] = "天域幻音"		
	RWTFLB[657] = "诸法无我"		
	RWTFLB[658] = "博通百家"	
	RWTFLB[313] = "诸行无常"		
	RWTFLB[140] = "无我无剑"		
	RWTFLB[499] = "文韬武略"	
	RWTFLB[27] = "化凰为凤"	  --萧玲		
	RWTFLB[574] = "天仙锁魂"	  --萧玲		
	RWTFLB[151] = "否极泰来"	  --文泰来	
	RWTFLB[68] = "一言止杀"	  --丘处机	
	RWTFLB[5] = "通微显化"	  --张三丰
	RWTFLB[577] = "一苇渡江"	  --达摩	
	RWTFLB[634] = "长春不老"	  --逍遥子
	RWTFLB[578] = "兵法入刀"	  --寇仲	
	RWTFLB[637] = "大道归藏"		 --黄赏
	RWTFLB[579] = "千变万幻"		 --司空摘星
	RWTFLB[629] = "浴火凤凰"		--
	RWTFLB[580] = "古墓无双"		--
	RWTFLB[581] = "机灵古怪"		--
	RWTFLB[649] = "娇美人妻"		--宁中则
	RWTFLB[583] = "普善圣心"		--仪琳
	RWTFLB[582] = "雪花神剑"		--白绣		
	RWTFLB[1] = "魂系一刀"
	RWTFLB[4] = "跌打医生"
	RWTFLB[9] = "运转乾坤"
    RWTFLB[20] = "七弦无形剑"
	RWTFLB[35] = "灵奇洒脱"
	RWTFLB[37] = "赤心连城"
	RWTFLB[38] = "名相皆无"	
	RWTFLB[48] = "心无所住"
	RWTFLB[49] = "福缘深厚"
	RWTFLB[50] = "奋英雄怒"
	RWTFLB[539] = "奋英雄怒"
	RWTFLB[51] = "离合参商"
	RWTFLB[53] = "磊落仁心"
	RWTFLB[54] = "志垂日月"
	RWTFLB[55] = "大器晚成"
	RWTFLB[56] = "奇门遁甲"
	RWTFLB[58] = "逆流勇进"
	RWTFLB[59] = "一片冰心"
	RWTFLB[60] = "倒行逆施"
	RWTFLB[63] = "外和内刚"
	RWTFLB[64] = "返璞归真"
	RWTFLB[73] = "琴铮盈盈"
	RWTFLB[74] = "巾帼之才"
	RWTFLB[76] = "武中无相"
	RWTFLB[77] = "珠联璧合"
	RWTFLB[80] = "勇猛精进"
	RWTFLB[83] = "纤纤铁手"
	RWTFLB[84] = "龙象之姿"
	RWTFLB[92] = "指挥若定"
	RWTFLB[97] = "借刀杀人"
	RWTFLB[102] = "双树枯荣"
	RWTFLB[112] = "天威奋烈"
	RWTFLB[116] = "北冥极渊"
	RWTFLB[117] = "转瞬红颜"
	RWTFLB[118] = "无相转身"
	RWTFLB[129] = "仙风道骨"	
	RWTFLB[153] = "千臂如来"
	RWTFLB[458] = "入木三分"
	RWTFLB[553] = "赤胆忠魂"
	RWTFLB[565] = "十里坡剑神"	--卓不凡
	RWTFLB[589] = "似水柔情"	--水笙
	RWTFLB[590] = "心秀天铃"		--李文秀
	RWTFLB[592] = "料敌先机"	--独孤求败
	RWTFLB[595] = "一龙一象"	--宝象
	RWTFLB[601] = "机敏无双"	--韦小宝
	RWTFLB[605] = "惊才绝艳"	--林朝英
	RWTFLB[606] = "踏沙无痕"	--阿凡提
	RWTFLB[609] = "机智多谋"	--赵敏
	RWTFLB[631] = "秀若芝兰"	--周芷若
	RWTFLB[642] = "亿万小时"	--四大山
	RWTFLB[636] = "侠客行"	--李白	
	RWTFLB[652] = "惊天一剑"	--萧秋水
	RWTFLB[635] = "天机神算"	--梁萧
	RWTFLB[497] = "补天劫奴"	--陆渐
	RWTFLB[498] = "惊才绝艳"	--李寻欢	
	RWTFLB[638] = "氤氲紫气"	--斗酒僧
	RWTFLB[640] = "翩若惊鸿"	--黄衫女		
	RWTFLB[189] = "仁者无敌"	--萧半和	
	RWTFLB[633] = "刀剑归真"	--胡一刀	
	RWTFLB[500] = "剑道化身"	--西门吹雪	
	RWTFLB[588] = "过目不忘"	--冯蘅
	RWTFLB[586] = "何足道哉"	--何足道	
	RWTFLB[584] = "麒麟臂"	    --
	RWTFLB[569] = "沅芷澧兰"	--
	RWTFLB[639] = "意假情真"	--	
	

	--天赋介绍
    TFJS = {}
	--拳王
	TFJS['拳'] = {"Ｌ盖世神拳",
	"Ｗ每修炼一个拳法到极，受伤害降低5%（上限7个）",
	"Ｎ",
	"Ｄ降龙极意",
	"Ｗ使用降龙十八掌，40%几率发动极意",
	"Ｎ",
	"Ｄ黯然极意",
	"Ｗ血量低于70%或内伤大于30时，使用黯然销魂掌有几率触发极意",
	"Ｗ血量越低，内伤越高，几率越高，满足条件时暴怒必定触发",
	"Ｗ触发黯然极意必定连击",
	"Ｎ",
	"Ｚ绝技：天道惊雷撼",
	"Ｗ华山后山觉醒后领悟",
	"Ｗ至少修炼9个武功，拳掌系数>=120，使用拳掌武功攻击几率触发",
	"Ｗ资质越高，触发几率越高",
	"Ｗ攻击无误伤，攻击效果提升33.3%，大幅提高封穴几率，追加1200气攻",
	"Ｎ",
	"Ｇ福缘际遇",
	"Ｗ觉醒后可以花一万银两在云岭洞学习\"迷踪步\""
	}
	TFJS['指'] = {"Ｌ灵犀一指",
	"Ｗ每修炼一个指法武功到极，破防几率提高5%（上限7个）",
	"Ｗ使用六脉神剑的内力消耗减半",
	"Ｎ",
	"Ｚ绝技：点墨山河",
	"Ｗ华山后山觉醒后领悟",
	"Ｗ至少修炼9个武功，指法系数>=120，使用指法武功攻击几率触发",
	"Ｗ资质越高，触发几率越高",
	"Ｗ攻击无误伤，不造成怒气，同时清除敌方一半怒气，追加1100气攻",
	"Ｎ",
	"Ｇ福缘际遇",
	"Ｗ觉醒后可以花一万银两在云岭洞学习\"迷踪步\""
	}
	TFJS['剑'] = {"Ｌ剑神一笑", 
	"Ｗ每修炼一个剑法到极，集气速度+2（上限7个）",
	"Ｗ使用玄铁剑法时，有几率发动重剑真传",
	"Ｗ可无视自宫需求修炼葵花宝典、辟邪剑法",
	"Ｎ",
	"Ｚ绝技：一剑镇神州",
	"Ｗ华山后山觉醒后领悟",
	"Ｗ至少修炼9个武功，御剑系数>=120，使用剑系武功攻击几率触发",
	"Ｗ资质越高，触发几率越高",
	"Ｗ攻击无误伤，锁定攻击战场上大范围敌方目标，追加1500气攻",
	"Ｎ",
	"Ｇ福缘际遇",
	"Ｗ觉醒后可以花一万银两在云岭洞学习\"迷踪步\""
	}
	TFJS['刀'] = {"Ｌ傲世狂刀", 
	"Ｗ每修炼一个刀法到极，伤害增加5%（上限7个）",
	"Ｗ使用胡家刀法有40%几率触发极意，暴怒必触发",
	"Ｗ使用火焰刀法和沧溟刀法时，特效触发几率追加二次判定",
	"Ｎ",
	"Ｚ绝技：羽葬煌炎斩",
	"Ｗ华山后山觉醒后领悟",
	"Ｗ至少修炼9个武功，耍刀系数>=120，使用刀系武功攻击几率触发",
	"Ｗ资质越高，触发几率越高",
	"Ｗ攻击无误伤，无视绝对气防，追加1500气攻，行动后自身怒气恢复25点（可叠加）",
	"Ｎ",
	"Ｇ福缘际遇",
	"Ｗ觉醒后可以花一万银两在云岭洞学习\"迷踪步\""
	}
	TFJS['奇'] = {"Ｌ奇门无双", 
	"Ｗ初始自带15%闪避",
	"Ｗ每修炼一个奇门武功到极，闪避率提高5%（上限7个）",
	"Ｗ打狗棒法『天下无狗』的触发几率提高，追加二次判定",
	"Ｎ",
	"Ｚ绝技：千机龙绝闪",
	"Ｗ华山后山觉醒后领悟",
	"Ｗ至少修炼9个武功，奇门系数>=120，使用奇门武功攻击几率触发",
	"Ｗ资质越高，触发几率越高",
	"Ｗ攻击无误伤，必定造成流血及封穴，追加1000气攻",
	"Ｎ",
	"Ｇ福缘际遇",
	"Ｗ觉醒后可以花一万银两在云岭洞学习\"迷踪步\""
	}

	TFJS['罡'] = {"Ｌ绝世天罡", 
	"Ｗ内力属性为天罡，同时拥有阴、阳、调和三种内力属性的特性",
	"Ｗ可使用内功攻击，内功可修炼至极",
	"Ｗ斗转反击时，无视兵器值需求必定发动离合参商",
	"Ｎ",
	"Ｄ天罡真气",
	"Ｗ使用内功攻击时50%几率触发天罡真气，提升气攻",
	"Ｎ",
	"Ｚ天赋内功",
	"Ｗ学会天赋内功后，进入战斗会自动运行",
	"Ｗ天赋内功不影响正常运功，即可同时运行两种内功",
	"Ｗ手动选择运功时，无法选择九阴/九阳/易筋",
	"Ｗ三神功真气只能触发天赋内功选择的",	
	"Ｎ",
	"Ｚ绝技：化气御九天",
	"Ｗ华山后山觉醒后领悟",
	"Ｗ至少修炼9个武功，任意武功攻击40%几率触发————【化气御九天】",
    "Ｗ攻击无误伤，伤害提高30%，兵器值判定必定优势，无视绝对气防，追加1300气攻；",
	"Ｎ",
	"Ｇ福缘际遇",
	"Ｗ觉醒后可以花一万银两在云岭洞学习\"迷踪步\""
    }
    
	TFJS['仁'] = {"Ｌ仁者无敌", 
	"Ｗ特效机率+10",
	"Ｗ道德值大于100增加（道德-100）/100伤害",
	"Ｗ道德值大于100减少（道德-100）/100伤害",
	"Ｎ",
	"Ｄ善恶有报	",
    "Ｗ攻击（道德-40）概率1.5倍伤害或（道德-100）%概率0.5倍伤害",
	"Ｎ",
	"Ｇ福缘际遇",
	"Ｗ觉醒后可以花一万银两在云岭洞学习\"迷踪步\""
	}	
	TFJS['医'] = {"Ｌ回天圣手", 
	"Ｗ初始医疗200，解毒200，用毒200；医疗上限400，用毒上限400，解毒上限400",
	"Ｗ医疗范围提升至7×7方阵",
	"Ｗ每时序随机恢复自身生命、内力、中毒、内伤",
	"Ｎ",
	"Ｚ绝技：八门聚万象",
	"Ｗ华山后山觉醒后领悟",
	"Ｗ至少修炼9个武功，体力大于50点，行动结束后几率触发",
	"Ｗ资质越高，触发几率越高",
	"Ｗ发动之后立即获得再次行动机会，需消耗10点体力",
	"Ｎ",
	"Ｇ福缘际遇",
	"Ｗ觉醒后可以花一万银两在云岭洞学习\"迷踪步\""
	}
	TFJS['毒'] = {"Ｌ欲天摩罗",
	"Ｗ初始解毒300，用毒300；用毒上限500，解毒上限500",
	"Ｗ上毒范围提升至7×7方阵，可以给自己上毒",
	"Ｗ每时序随机增加自身中毒程度",
	"Ｗ自身中毒越深，能力反而越强",
    "Ｎ",
	"Ｚ绝技：天人五衰",
	"Ｗ华山后山觉醒后领悟",
	"Ｗ至少修炼9个武功，自身中毒100点，攻击时几率触发",
	"Ｗ资质越高，触发几率越高",
	"Ｗ攻击无误伤，本次攻击必定附加五种异常状态",
	"Ｎ",
	"Ｇ福缘际遇",
	"Ｗ觉醒后可以花一万银两在云岭洞学习\"迷踪步\""
	}
	--张家辉
	TFJS[651] = {"Ｒ人物介绍",
	"Ｗ大扎好，我系渣渣辉，探挽懒月，介四里没有挽过的船新版本，挤需体验三番钟，",
	"Ｗ里造会干我一样，爱象节款游戏。",
	"Ｎ",
	"Ｌ人物特性",
	"Ｗ自带四件传奇饰品，拥有极强大的特效"
	}
	TFJS["少林弟子"] = {
	"Ｌ少林弟子",
	"Ｗ完成师门任务可以激活三个天赋",	
	}  
	--主角专属介绍
	ZJZSJS = {"Ｒ天赋外功",
	"Ｄ获得方式：拿到七本天书后，场景【华山后山】对话谢无悠",
	"Ｄ可选择一个武功作为天赋外功",
	"Ｎ",
	"Ｒ天赋内功",
	"Ｄ获得方式：拿到十本天书后，场景【华山后山】挑战谢无悠胜利",
	"Ｄ可选择一个内功作为天赋内功",
	}
	
	WPTX2 = {}
    WPTX2[0] = "时序恢复1点内伤，持续50时序"
    WPTX2[1] = "时序恢复2点生命，满实战翻倍，持续100时序"
    WPTX2[3] = "时序恢复8点内力，持续200时序"
    WPTX2[9] = "时序恢复1点中毒，持续50时序"
    WPTX2[10] = "时序恢复1点中毒，持续50时序"
    WPTX2[11] = "提升战场抗毒100点，持续至战斗结束"
    WPTX2[22] = "解除冰封50点并时序恢复1点冰封，持续50时序"
    WPTX2[23] = "解除灼烧20点并时序恢复1点灼烧，持续50时序"
    WPTX2[24] = "解除流血50点并时序恢复1点流血，持续100时序"
    WPTX2[25] = "清除所有基础异常"


	--门派名称
	MPname = {"江湖","少林寺","武当派","逍遥派","日月神教","明教","天机宫","全真教","丐帮","华山派","嵩山派","青城派","衡山派","恒山派","泰山派","五毒教","古墓派","血刀门",
	"灵霄城","峨眉派","崆峒派","昆仑派","桃花岛","白驼山庄","六扇门","八卦门","慕容世家","天龙寺","星宿派","密宗","藏剑山庄"}
	--门派职务
	MPzw = {"长老","护法","堂主","执事","内门弟子","外门弟子"}

	--物品特效说明
	WPTX = {}

	--绣花针
	WPTX[349] = {"必破气防，破防10%",
	"破防20%",
	"破防30%",
	"破防40%",
	"破防50%",
	"破防60%，进战集气增加900。"
	}
	--青冥剑
	WPTX[335] = {"根据御剑能力提升剑法范围",
	"根据御剑能力提升剑法攻击范围",
	"根据御剑能力提升剑法攻击范围",
	"根据御剑能力提升剑法攻击范围",
	"根据御剑能力提升剑法攻击范围",
	"根据御剑能力提升剑法攻击范围"
	}
	--白猿
	WPTX[326] = {"猿公剑法/越女剑法威力+200",
	"猿公剑法/越女剑法威力+200",
	"猿公剑法/越女剑法威力+200",
	"猿公剑法/越女剑法威力+200",
	"猿公剑法/越女剑法威力+200",
	"猿公剑法/越女剑法威力+200"
	}
	--伏魔禅杖
	WPTX[323] = {"伏魔杖法威力+200",
	"攻击时60%几率造成内伤5~15点",
	"攻击时70%几率造成内伤5~15点",
	"攻击时80%几率造成内伤5~15点",
	"攻击时90%几率造成内伤5~15点",
	"攻击时必造成内伤，增加“世尊降魔”发动机率10%"
	}
	--狼牙
	WPTX[320] = {"攻击时50%几率造成流血",
	"攻击时60%几率造成流血",
	"攻击时70%几率造成流血",
	"攻击时80%几率造成流血",
	"攻击时90%几率造成流血",
	"攻击时必造成流血，50%机率发动“天狼啸月”"
	}	
	--七宝指环
	WPTX[200] = {"逍遥派武学威力+100",
	"60%概率追加封穴5点",
	"70%概率追加封穴5点",
	"80%概率追加封穴5点",
	"90%概率追加封穴5点",
	"必封穴，50%机率发动“七宝琉璃”特效"
	}	
	
	--玄铁剑
	WPTX[36] = {"使用玄铁剑法时，增加50%暴击率",
	"使用玄铁剑法时，增加60%暴击率",
	"使用玄铁剑法时，增加70%暴击率",
	"使用玄铁剑法时，增加80%暴击率",
	"使用玄铁剑法时，增加90%暴击率",
	"使用玄铁剑法时，必定暴击，并可发动“破尽天下”"
	}
	--倚天剑
	WPTX[37] = {"攻击时70%几率造成流血效果",
	"攻击时80%几率造成流血效果",
	"攻击时90%几率造成流血效果",
	"攻击时必定造成流血效果",
	"攻击时必定造成流血效果",
	"使用剑法攻击时，有几率触发“谁于争锋”特效"
	}
	--流星剑
	WPTX[38] = {"连击率+10%",
	"连击率+11%",
	"连击率+12%",
	"连击率+13%",
	"连击率+14%",
	"连击率+15%"
	}
	--屠龙刀
	WPTX[43] = {"使用刀法攻击时，有几率触发两种特效",
	"使用刀法攻击时，有几率触发两种特效",
	"使用刀法攻击时，有几率触发两种特效",
	"使用刀法攻击时，有几率触发两种特效",
	"使用刀法攻击时，有几率触发两种特效",
	"使用刀法攻击时，有几率触发两种特效"
	}
	--血刀
	WPTX[44] = {"看起来不错，实际上没什么用",
	"看起来不错，实际上没什么用",
	"看起来不错，实际上没什么用",
	"看起来不错，实际上没什么用",
	"看起来不错，实际上没什么用",
	"解锁"
	}
	--判官笔
	WPTX[53] = {"5%概率造成封穴2~8点",
	"10%概率造成封穴2~8点",
	"15%概率造成封穴2~8点",
	"20%概率造成封穴2~8点",
	"25%概率造成封穴2~8点",
	"30%概率造成封穴2~8点"
	}	
	--软猬甲
	WPTX[58] = {"减伤20点，被拳指系武功攻击时，使攻击方流血10点",
	"减伤22点，被拳指系武功攻击时，使攻击方流血10点",
	"减伤24点，被拳指系武功攻击时，使攻击方流血10点",
	"减伤26点，被拳指系武功攻击时，使攻击方流血10点",
	"减伤28点，被拳指系武功攻击时，使攻击方流血10点",
	"减伤30点，被拳指系武功攻击时，使攻击方流血10点"
	}
	--乌蚕衣
	WPTX[59] = {"被攻击时，受到的内伤减少5点",
	"被攻击时，受到的内伤减少6点",
	"被攻击时，受到的内伤减少7点",
	"被攻击时，受到的内伤减少8点",
	"被攻击时，受到的内伤减少9点",
	"被攻击时，受到的内伤减少10点"
	}
	--金丝背心
	WPTX[60] = {"被攻击时，受到的封穴减少5点",
	"被攻击时，受到的封穴减少6点",
	"被攻击时，受到的封穴减少7点",
	"被攻击时，受到的封穴减少8点",
	"被攻击时，受到的封穴减少9点",
	"被攻击时，受到的封穴减少10点"
	}
	--鳄皮护甲
	WPTX[61] = {"每次行动结束后解毒25点",
	"每次行动结束后解毒35点",
	"每次行动结束后解毒45点",
	"每次行动结束后解毒55点",
	"每次行动结束后解毒65点",
	"每次行动结束后解毒75点"
	}
	--佛心甲
	WPTX[62] = {"被攻击时，受到的灼烧减少50%",
	"被攻击时，受到的灼烧减少60%",
	"被攻击时，受到的灼烧减少70%",
	"被攻击时，受到的灼烧减少80%",
	"被攻击时，受到的灼烧减少90%",
	"被攻击时，免疫灼烧状态"
	}
	--皮衣
	WPTX[63] = {"被攻击时，受到的冰封减少50%",
	"被攻击时，受到的冰封减少60%",
	"被攻击时，受到的冰封减少70%",
	"被攻击时，受到的冰封减少80%",
	"被攻击时，受到的冰封减少90%",
	"被攻击时，免疫冰封状态"
	}
	--白马
	WPTX[230] = {"集气速度增加2点",
	"集气速度增加2点",
	"集气速度增加3点",
	"集气速度增加3点",
	"集气速度增加4点",
	"集气速度增加4点"
	}	

	--真武剑
	WPTX[236] = {"使用太极剑法时，必定连击",
	"使用太极剑法时，必定连击",
	"使用太极剑法时，必定连击",
	"使用太极剑法时，必定连击",
	"使用太极剑法???，必定连击",
	"使用太极剑法时，必定连击"
	}
	--鸳鸯刀
	WPTX[217] = {"需男性，使用夫妻刀法时，必定连击",
	"使用夫妻刀法时，必定连击",
	"使用夫妻刀法时，必定连击",
	"使用夫妻刀法时，必定连击",
	"使用夫妻刀法时，必定连击，追加500气攻",
	"使用夫妻刀法时，必定连击，追加500气攻，伤害提高20%"
	}
	WPTX[218] = {"需女性，使用夫妻刀法时，必定连击",
	"使用夫妻刀法时，必定连击",
	"使用夫妻刀法时，必定连击",
	"使用夫妻刀法时，必定连击",
	"使用夫妻刀法时，必定连击，追加500气攻",
	"使用夫妻刀法时，必定连击，追加500气攻，伤害提高20%"
	}
	--毛驴
	WPTX[279] = {"集气速度增加10点",
	"集气速度增加10点",
	"集气速度增加10点",
	"集气速度增加10点",
	"集气速度增加10点",
	"集气速度增加10点"
	}
	--青驴
	WPTX[339] = {"集气速度增加5点，体力消耗减2点",
	"集气速度增加5点，体力消耗减2点",
	"集气速度增加5点，体力消耗减2点",
	"集气速度增加5点，体力消耗减2点",
	"集气速度增加5点，体力消耗减2点",
	"集气速度增加5点，体力消耗减2点"
	}
	--飞云骓
	WPTX[264] = {"集气速度增加12点",
	"集气速度增加12点",
	"集气速度增加12点",
	"集气速度增加12点",
	"集气速度增加12点",
	"集气速度增加12点"
	}	
	--汗血宝马
	WPTX[262] = {"集气速度增加8点，时序回复流血2点",
	"集气速度增加8点，时序回复流血2点",
	"集气速度增加8点，时序回复流血2点",
	"集气速度增加8点，时序回复流血2点",
	"集气速度增加8点，时序回复流血2点",
	"集气速度增加8点，时序回复流血2点"
	}		
	--西毒蛇杖
	WPTX[244] = {"攻击时无视敌方毒抗强制上毒10点",
	"攻击时无视敌方毒抗强制上毒15点",
	"攻击时无视敌方毒抗强制上毒20点",
	"攻击时无视敌方毒抗强制上毒25点",
	"攻击时无视敌方毒抗强制上毒30点",
	"攻击时无视敌方毒抗强制上毒35点"
	}
	--瘦黄马
	WPTX[284] = {nil,
	nil,
	nil,
	nil,
	nil,
	"血量越低，集气速度越快"
	}
	
	--金丝手套
	WPTX[239] = {"提高自身拳/指系数10点",
	"提高自身拳/指系数15点",
	"提高自身拳/指系数20点",
	"提高自身拳/指系数25点",
	"提高自身拳/指系数30点",
	"提高自身拳/指系数30点，免疫流血"
	}
	
	--音箱
	WPTX[300] = {"降龙三叠浪几率提高5%，暴怒时有几率触发四叠浪",
	"降龙三叠浪几率提高10%，暴怒时有几率触发四叠浪",
	"降龙三叠浪几率提高15%，暴怒时有几率触发四叠???",
	"降龙三叠浪几率提高20%，暴怒时有几率触发四叠浪",
	"降龙三叠浪几率提高25%，暴怒时有几率触发四叠浪",
	"降龙三叠浪几率提高30%，暴怒时有几率触发四叠浪"
	}
	
	--麻痹戒指
	WPTX[301] = {"令击中的敌方进入麻痹状态，下回合移动能力-1",
	"令击中的敌方进入麻痹状态，下回合移动能力-1",
	"令击中的敌方进入麻痹状态，下回合移动能力-2",
	"令击中的敌方进入麻痹状态，下回合移动能力-2",
	"令击中的敌方进入麻痹状态，下回合移动能力-3",
	"令击中的敌方进入麻痹状态，下回合移动能力-3"
	}
	--护身戒指
	WPTX[302] = {"用内力抵消一半伤害，抵消比例为3内力=1伤害",
	"用内力抵消一半伤害，抵消比例为3内力=1伤害",
	"用内力抵消一半伤害，抵消比例为2内力=1伤害",
	"用内力抵消一半伤害，抵消比例为2内力=1伤害",
	"用内力抵消一半伤害，抵消比例为1内力=1伤害",
	"用内力抵消一半伤害，抵消比例为1内力=1伤害"
	}
	--复活戒指
	WPTX[303] = {"被击退时，满状态复活，复活6次之后物品损坏",
	"被击退时，满状态复活，复活6次之后物品损坏",
	"被击退时，满状态复活，复活6次之后物品损坏",
	"被击退时，满状态复活，复活6次之后物品损坏",
	"被击退时，满状态复活，复活6次之后物品损坏",
	"被击退时，满状态复活，复活6次之后物品损坏"
	}
	--隐身戒指
	WPTX[304] = {"敌方无法察觉你的存在，攻击后现形40时序",
	"敌方无法察觉你的存在，攻击后现形40时序",
	"敌方无法察觉你的存在，攻击后现形30时序",
	"敌方无法察觉你的存在，攻击后现形30时序",
	"敌方无法察觉你的存在，攻击后现形20时序",
	"敌方无法察觉你的存在，攻击后现形20时序"
	}
	--天书
	WPTX[312] = {"神秘强大的力量",
	"神秘强大的力量",
	"神秘强大的力量",
	"神秘强大的力量",
	"神秘强大的力量",
	"神秘强大的力量",
	}	
	--千年人参
	WPTX[14] = "可增加人物体质1点"	
	--独孤九剑
	WPTX[114] = "在一定机缘下可领悟九剑真传"
	--六脉神剑
	WPTX[113] = "连击时，伤害、气攻不会减少"
	--夫妻刀法
	WPTX[140] = "连击时，伤害、气攻不会减少"
	--北冥神功
	WPTX[64] = "主角修炼机率吸怒20点"
 	--九阴功
	WPTX[83] = "主角修炼可习得飞絮劲机率+100真实伤害且无视闪避"
 	--九阳功
	WPTX[84] = "主角修炼可习得“抱元守一”，行动前清除所有异常状态"	
	--武学残章
	WPTX[550] = "可用来换取武功秘籍"

	--难度文字
	MODEXZ2 = {"简单", "普通", "困难","地狱"}
	--标主选天赋文字
	TFXZSAY1 = " 天下风云出我辈 * 一入江湖岁月催 * 皇图霸业谈笑中 * 不胜人生一场醉 "
	
	--特色指令
	GRTS = {}
	GRTSSAY = {}
	
	--段誉
	GRTS[53] = "凌波"
	GRTSSAY[53] = "效果：至该角色下次行动为止*      被攻击有50%几率闪避*消耗：体力10点"
	
	--虚竹
	GRTS[49] = "催符"
	GRTSSAY[49] = "效果：催动敌人身上的生死符*      使其封穴25时序*消耗：体力5点 内力500点"
	
	--人厨子
	GRTS[89] = "气补"
	GRTSSAY[89] = "效果：回复指定邻接队友体力50点**消耗：体力25点 内力300点"
	
	--张无忌
	GRTS[9] = "挪移"
	GRTSSAY[9] = "效果：将八格范围内的我方任一队友*      挪移到指定位置*消耗：体力10点 内力500点"
	
	--祖千秋
	GRTS[88] = "传功"
	GRTSSAY[88] = "效果：将五格范围内我方任一队友*      当前集气提升500点*消耗：体力10点 内力700点"
  
	--霍青桐
	GRTS[74] = "指挥"
	GRTSSAY[74] = "效果：我方获得号令三军50时序。*效果为我方存活人数*5%。*消耗：体力10点 内力150点"
	
	--王难姑
	GRTS[17] = "施毒"
	GRTSSAY[17] = "效果：周围五格范围内的敌人时序中毒*      持续50时序*消耗：体力15点 内力300点"
	
	--胡青牛
	GRTS[16] = "群疗"
	GRTSSAY[16] = "效果：周围五格范围内的队友时序回内伤*      并按比例回血，持续20时序*消耗：体力15点 内力300点"
	
	
	--慕容复
	GRTS[51] = "幻梦"
	GRTSSAY[51] = "效果：至该角色下次行动为止*      被攻击必定发动幻梦星辰反击*消耗：体力10点"
	
	--小昭
	GRTS[66] = "影步"
	GRTSSAY[66] = "效果：标记自身周围一点*      被攻击则移动至该处*消耗：体力20点 内力1000点"
	
	--钟灵
	GRTS[90] = "灵貂"
	GRTSSAY[90] = "效果：偷窃敌方携带的物品*      并对其强制上毒50点*消耗：体力5点"
	
	--郭襄
	GRTS[626] = "玲珑"
	GRTSSAY[626] = "效果：可自由切换第一格武功为*      弹指神通/玉萧剑法/落英神剑掌*      不消耗回合"
	--李清露
	GRTS[574] = "云梦"
	GRTSSAY[574] = "效果：可自由切换第一格武功为*      寒袖拂穴/白虹掌力*      不消耗回合"	
	--胡斐
	GRTS[1] = "飞狐"
	GRTSSAY[1] = "效果：无视障碍物移动*      在战场上来去自如*消耗：体力10点"
	
	--鸠摩智
	GRTS[103] = "幻化"
	GRTSSAY[103] = "效果：使用小无相功模拟天下武学*      必须要拥有对应的秘籍*消耗：体力10点 内力500点"
	
	--阿朱
	GRTS[104] = "易容"
	GRTSSAY[104] = "效果：易容成敌方50时序，只受到误伤的伤害。*消耗：体力10点 内力500点"

	--达尔巴取消
	GRTS[160] = "死战"
	GRTSSAY[160] = "效果：锁定一名敌人，至其死亡之前，达尔巴*      对其的攻击效果提高50%，且必定命中*      在目标死亡之前无法更换目标*消耗：体力10点 内力500点"
	
	--金轮取消
	GRTS[62] = "龙象"
	GRTSSAY[62] = "效果：使用后自动执行蓄力*      并使下一次的攻击附加昏迷效果*      昏迷的敌人将丧失一次行动机会*消耗：体力30点 内力3000点"
	
	--黄蓉
	GRTS[56] = "遁甲"
	GRTSSAY[56] = "效果：使用奇门遁甲*      重新布置战场地形效果*消耗：体力10点 内力500点"
	
	--阿紫取消
	GRTS[47] = "禁药"
	GRTSSAY[47] = "效果：使用禁药刺激神经*      自身每时序损失1%最大血量*      此状态下自身血量越低，伤害/集气越高*      不消耗回合"
	
	--韦小宝
	GRTS[601] = "口才"
	GRTSSAY[601] = "效果：使一名敌方进入沉睡状态*      此状态无法集气，不会自行解除*      受到攻击会醒来*消耗：体力15点"
	
	--苗人凤取消
	GRTS[3] = "破军"
	GRTSSAY[3] = "效果：攻击敌方*      并使其内功停运50时序*消耗：体力10点 内力300点"
	
	--灭绝
	GRTS[6] = "俱焚"
	GRTSSAY[6] = "效果：开启后100时序*      自身造成和受到的伤害皆提高50% *      不消耗回合"
	
	--谢逊
	GRTS[13] = "咆哮"
	GRTSSAY[13] = "效果：使全场敌人进入混乱状态20时序*      此状态下敌人行动时的敌我关系为随机*      不会全部随机到我方，以免出现直接获胜的情况*消耗：体力10点 2000内力"

	--丘处机取消
	GRTS[68] = "止杀"
	GRTSSAY[68] = "效果：自身十格范围内敌人不会攻击一回合    *     *消耗：体力15点 "	
	
	--何太冲取消
	GRTS[7] = "铁琴"
	GRTSSAY[7] = "效果：使全场敌人受到其身上琴音层数×50点伤害*      并清除其身上的琴音状态*消耗：体力10点 内力500点"
	
	--阎基取消
	GRTS[4] = "虚弱"
	GRTSSAY[4] = "效果：用毒药侵蚀一名敌人的神经*      使其在40时序内造成的伤害杀气减半*消耗：体力10点"
	
	--黛绮丝取消
	GRTS[15] = "倾国"
	GRTSSAY[15] = "效果：开启后，接下来受到的前6次攻击*      将折射给在场随机第三方人物*消耗：体力10点"
	
	--猫姐取消
	GRTS[92] = "换装"
	GRTSSAY[92] = "效果：使用后改变自身外形*      并将获得不同的内功*消耗：体力10点"
		
	GRTS[507] = "麒麟"
	GRTSSAY[507] = "效果1：使用后改变自身形象*效果2：每本天赋可复制敌方一个武功*消耗：体力10点"
		
	GRTS[508] = "麒麟"
	GRTSSAY[508] = "效果1：使用后改变自身形象*      无消耗消耗"
		
	--李寻欢
	GRTS[498] = "飞刀"
	GRTSSAY[498] = "效果：开启100时序后，自身伤害提升50%*    小李飞刀例无需发 攻击无视闪避必命中；*  暗器造成更高伤害，消耗：-10体，-500内"
	--萧秋水
	GRTS[652] = "天剑"
	GRTSSAY[652] = "效果：满怒后可使用，开启开50时序内*    任何剑系武功附加【惊天一剑】*  造成无视一切防御无视闪避的伤害*        消耗：-10体，-500内"	
	
	--不戒和尚
	GRTS[593] = "不戒"
	GRTSSAY[593] = "效果：帮助队友自宫*消耗：体力10点，内力1000点"
	
	--张中
	GRTS[308] = "天变"
	GRTSSAY[308] = "效果：可改变天气*消耗：体力20点，内力1000点"
	
	CC.Kungfunum = 15;	--人物武功数量
	CC.Mijinum = 10;	--人物武功数量
	
--队友攻击加成
CC.AddAtk = {
{10, 15, 50}, 		--金花给范遥加攻
{11, 15, 50}, 		--金花给杨逍加攻
{12, 15, 50}, 		--金花给殷天正加攻
{13, 15, 50}, 		--金花给谢逊加攻
{14, 15, 50}, 		--金花给韦一笑加攻
{48, 47, 100}, 		--阿紫给游坦之加攻
{47, 50, 100}, 		--乔峰给阿紫加攻
{53, 76, 100}, 		--王语嫣给段誉加攻
{79, 36, 60}, 		--林平之给岳灵珊加攻
{74, 75, 50}, 		--陈家洛给霍青桐加攻
{59, 58, 100}, 		--杨过给小龙女加攻
{54, 91, 100}, 		--温青青给袁承志加攻
{629, 54, 100}, 	--袁承志给阿九加攻
{99, 70, 100}, 		--玄慈给叶二娘加攻
{119, 65, 50}, 		--一灯给渔加攻
{120, 65, 50}, 		--一灯给樵加攻
{121, 65, 50}, 		--一灯给耕加攻
{122, 65, 50}, 		--一灯给读加攻
{68, 129, 50}, 		--王重阳给全真七子加攻
{123, 129, 50}, 
{124, 129, 50}, 
{125, 129, 50}, 
{126, 129, 50}, 
{127, 129, 50}, 
{128, 129, 50},
{37, 589, 50},		--狄云、水笙在场，攻各加50
{589, 37, 50},
{88, 89, 50},		--人厨子给祖千秋加攻
{311, 312, 100}, 		--天山
{604, 592, 100}, 	--独孤求败给阿青加攻
{566, 77, 100},
{614,615, 50},
{505,578, 100},    --大唐双龙
}

--队友防御加成
CC.AddDef = {	
{76, 51, 100}, 		--慕容复给王语嫣加防
{311, 312, 100}, 		--天山
{55, 56, 50}, 		--黄蓉给郭靖加防
{56, 55, 100}, 		--郭靖给黄蓉加防
{35, 73, 100}, 		--任盈盈给令狐冲加防
{79, 36, 60}, 		--岳灵珊给林平之加防
{73, 35, 50}, 		--令狐冲给任盈盈加防
{74, 75, 50}, 		--陈家洛给霍青桐加防
{58, 59, 50}, 		--小龙女给杨过加防
{59, 58, 50}, 		--杨过给小龙女加防	
{66, 9, 50}, 		--张无忌给小昭加防
{91, 54, 100}, 		--袁承志给温青青加防
{119, 65, 50}, 		--一灯给渔加防
{120, 65, 50}, 		--一灯给樵加防
{121, 65, 50}, 		--一灯给耕加防
{122, 65, 50}, 		--一灯给读加防
{68, 129, 50}, 		--王重阳给全真七子加防
{123, 129, 50}, 
{124, 129, 50}, 
{125, 129, 50}, 
{126, 129, 50}, 
{127, 129, 50}, 
{128, 129, 50},
{37, 589, 50},		--狄云、水笙在场，防各加50
{589, 37, 50},
{566, 77, 100},
{614,615, 50},
{578,505, 100},    --大唐双龙
}

--队友速度加成
CC.AddSpd = {
{25, 35, 50}, 		--令狐冲给蓝凤凰加轻
{90, 53, 50}, 		--段誉给钟灵加轻
{55, 56, 100}, 		--黄蓉给郭靖加轻
{56, 55, 50}, 		--郭靖给黄蓉加轻
{35, 79, 100}, 		--小师妹给令狐加轻
{73, 35, 50}, 		--令狐给盈盈加轻
{74, 75, 50}, 		--陈家洛给霍青桐加轻
{58, 59, 100}, 		--小龙女给杨过加轻
{63, 58, 60}, 		--杨过给程英加轻
{83, 54, 50},		--袁承志给何铁手加轻
{54, 629, 100}, 	--阿九给袁承志加轻
{37, 589, 50},		--狄云、水笙在场，轻各加50
{589, 37, 50},
{311, 312, 100}, 		--天山
{89, 88, 50},		--祖千秋给人厨子加轻
{592, 604, 100},	--阿青给独孤求败加轻
{614,615, 50},
{505,578, 50},    --大唐双龙
{578,505,50},    --大唐双龙
}

CC.AddDoc = {
{2, 1, 120}, 		--胡斐给程灵素加医疗
{16, 17, 50}}		--王难姑给胡青牛加医疗

CC.AddPoi = {
{17, 16, 50}}		--胡青牛给王难姑加用毒

--组合名称
CC.COMBO = {
	{506,651,'天地双尊'},
	{1, 2, "海棠烛泪"},
	--{4, 72, "狼狈为奸"},
      {311, 312, "天山双鹰"}, 		--天山	
	--{37, 38, "赤诚仁心"},
	--{47, 48, "铁怪毒娇"},
	{51, 76, "姑苏表亲"},
	{53, 76, "仙洞眷侣"},
	--{90, 582, "灵婉双娇"},
	{55, 56, "铁血丹心"},
	--{87, 86, "鹿鼎双妹"},
	{35, 73, "剑胆琴心"},
	{36, 79, "苦命鸳鸯"},
	{75, 74, "巾帼红花"},
	{58, 59, "神雕侠侣"},
	{9, 66, "倚天奇情"},
	{16, 17, "蝶谷怪医"},
	{54, 91, "碧血情侠"},
	{54, 629, "情天长恨"},
	{88, 89, "酒食为天"},
	--{35, 58, "独孤传人"},
	--{83, 25, "五毒五仙"},
	--{35, 29, "酒肉冤家"},
	--{0, 92, "前尘如梦"},
	{37, 589, "雪山隐士"},
	--{38, 661, "金乌玉兔"},
	--{29, 591, "风流浪荡"},
	--{10, 11, "逍遥二仙"},
	--{162, 163, "不三不四"},
	--{60, 61, "雪山白驼"},
	--{620, 61, "雪山白驼"},
	--{51, 113, "燕国遗脉"},
	--{50, 112, "大辽战神"},
	--{3, 621, "刀剑双绝"},
	--{632, 633, "人淡如菊"},
	--{616, 635, "情义无解"},	
	--{77, 625, "女貌郎才"},		
	--{643, 644, "玄冥二老"},	
	--{663, 664, "义重情深"},	
	--{9, 638, "情深不寿"},
	--{9, 639, "张郎画眉"},
	{592, 604, "剑试天宵"},
	{566, 77, "珠联璧合"},
	{615, 614, "欢喜冤家"},	
	{505, 578, "大唐双龙"},	
}

CC.HTG = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,311,312,313,314,315,316,317,318,319,451,452,453,454,458,459,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,545,546,565,566,567,568,569,570,571,573,574,575,576,577,578,579,580,581,582,583,584,586,587,588,589,590,592,593,594,595,596,597,598,599,601,602,603,604,605,606,607,609,610,611,612,613,614,615,616,617,626,627,628,629,630,631,632,633,634,635,636,637,638,639,640,641,642,643,644,645,646,647,648,649,650,651,652,653,655,656,657,658,722,731,732,737,739,740,741,742,748,752}
CC.QG1 = {145,146,148,149,150,237}	--标记修改
CC.QG2 = {2,147,223,224,186}	--标记修改
CC.NG1 = {225,90,96,95,93,94,216,227,199,169,207}	--标记修改
CC.NG2 = {190,203,100,97,160,103,144,101,104,105,233,144}	--标记修改

	CC.CoupleDisplay = 0;
	
	--显示组合动画开关
	if CONFIG.CoupleDisplay == 1 then
		CC.CoupleDisplay = 1;
	end
	--适配，走路添加
	CC.WalkSkip = CONFIG.WalkSkip or 200 --跳过步数
	CC.WalkTime = 0 --跳过步数
	CC.PrevKeypress = -1
	
	--无酒不欢：人物换装设定
	Avatar = {}
	
	--杨过
	Avatar[58] = {{},{}}
	Avatar[58][1].name = "神雕大侠"
	Avatar[58][1].num = 58
	Avatar[58][1].num2 = 58
	Avatar[58][1].frameNum = {0,13,12,0,0}
	Avatar[58][1].frameDelay = {0,6,5,0,0}
	Avatar[58][1].soundDelay = {0,4,3,0,0}
	
	Avatar[58][2].name = "重剑无锋"
	Avatar[58][2].num = 376
	Avatar[58][2].num2 = 58
	Avatar[58][2].frameNum = {0,13,12,0,0}
	Avatar[58][2].frameDelay = {0,11,11,0,0}
	Avatar[58][2].soundDelay = {0,11,11,0,0}
	
	--黛绮丝
	Avatar[15] = {{},{}}
	Avatar[15][1].name = "金花婆婆"
	Avatar[15][1].num = 15
	Avatar[15][1].num2 = 15
	Avatar[15][1].frameNum = {0,0,0,0,14}
	Avatar[15][1].frameDelay = {0,0,0,0,12}
	Avatar[15][1].soundDelay = {0,0,0,0,10}
	
	Avatar[15][2].name = "紫衫龙王"
	Avatar[15][2].num = 377
	Avatar[15][2].num2 = 15
	Avatar[15][2].frameNum = {0,0,0,0,12}
	Avatar[15][2].frameDelay = {0,0,0,0,10}
	Avatar[15][2].soundDelay = {0,0,0,0,10}

	--韦小宝
	Avatar[601] = {{},{}}
	Avatar[601][1].name = "游手好闲"
	Avatar[601][1].num = 225
	Avatar[601][1].num2 = 601
	Avatar[601][1].frameNum = {0,8,0,7,0}
	Avatar[601][1].frameDelay = {0,6,0,5,0}
	Avatar[601][1].soundDelay = {0,6,0,5,0}
	
	Avatar[601][2].name = "一人之下"
	Avatar[601][2].num = 378
	Avatar[601][2].num2 = 601
	Avatar[601][2].frameNum = {0,0,0,14,0}
	Avatar[601][2].frameDelay = {0,0,0,12,0}
	Avatar[601][2].soundDelay = {0,0,0,10,0}
	
	--鹤笔翁
	Avatar[647] = {{},{}}
	Avatar[647][1].name = "炸屎狂魔"
	Avatar[647][1].num = 16
	Avatar[647][1].num2 = 16
	Avatar[647][1].frameNum = {0,13,0,0,0}
	Avatar[647][1].frameDelay = {0,11,0,0,0}
	Avatar[647][1].soundDelay = {0,9,0,0,0}
	
	Avatar[647][2].name = "专业解说"
	Avatar[647][2].num = 17
	Avatar[647][2].num2 = 17
	Avatar[647][2].frameNum = {10,7,0,0,0}
	Avatar[647][2].frameDelay = {7,7,0,0,0}
	Avatar[647][2].soundDelay = {0,2,0,0,0}
	
	--鹿杖客
	Avatar[648] = {{},{}}
	Avatar[648][1].name = "带头大哥"
	Avatar[648][1].num = 358
	Avatar[648][1].num2 = 633
	Avatar[648][1].frameNum = {0,0,10,0,0}
	Avatar[648][1].frameDelay = {0,0,8,0,0}
	Avatar[648][1].soundDelay = {0,0,7,0,0}
	
	Avatar[648][2].name = "国民老婆"
	Avatar[648][2].num = 515
	Avatar[648][2].num2 = 738
	Avatar[648][2].frameNum = {0,0,0,0,20}
	Avatar[648][2].frameDelay = {0,0,0,0,18}
	Avatar[648][2].soundDelay = {0,0,0,0,18}
	
	--乔峰
	Avatar[50] = {{},{}}
	Avatar[50][1].name = "奋英雄怒"
	Avatar[50][1].num = 50
	Avatar[50][2].num = 50
	Avatar[50][1].frameNum = {0,14,0,0,0}
	Avatar[50][1].frameDelay = {0,8,0,0,0}
	Avatar[50][1].soundDelay = {0,5,0,0,0}
	
	Avatar[50][2].name = "狂龙天征"
	Avatar[50][2].num = 388
	Avatar[50][2].num = 50
	Avatar[50][2].frameNum = {0,14,0,0,0}
	Avatar[50][2].frameDelay = {0,8,0,0,0}
	Avatar[50][2].soundDelay = {0,5,0,0,0}
	
	--文字颜色定义
	CC.Color = {["R"]=C_RED, ["G"]=M_Green, ["B"]=M_Blue}
  
	--是否显示滚动提醒，1打开，0关闭
	CC.OpenTimmerRemind = 1;
	
	--windows版本默认是打开
	if CONFIG.Operation == 0 then
		CC.OpenTimmerRemind = 1;
	end


	CC.ZTSM = {} --状态说明
	--1名称，2说明，3增益为1减益为2 ，4 5 效果或持续时间说明
	CC.ZTSM[1] = {"慧中灵剑","攻击时概率触发，增加下回合初始集气位置300点/队友100点，东方不败触发疾如风概率直接再次行动。",1,"","","慧中"}
	CC.ZTSM[2] = {"破甲状态","防御力减少25%。",2,"CD:","回合","虚弱"}
	CC.ZTSM[3] = {"七略连击","增加连击次数。",1,"连击增加：","次","连击"}
	CC.ZTSM[4] = {"入魔","免疫封穴和杀气，如果连击次数少于3，则必然三连击。吸取造成伤害20%的生命，最大值200点。",1,"","","入魔"}
	CC.ZTSM[5] = {"六阳正气","伤害恢复20~50%，气攻减少20~50%。",1,"CD:","回合","六阳"}
	CC.ZTSM[6] = {"牛黄血蝎","时序恢复1点中毒。",1,"CD:","回合","牛黄"}
	CC.ZTSM[7] = {"黄连解毒","时序恢复1点中毒。",1,"CD:","回合","黄连"}
	CC.ZTSM[8] = {"小还丹","时序恢复内伤值。",1,"CD:","回合","小还丹"}
	CC.ZTSM[9] = {"天王护命","根据实战时序恢复2~4点生命，使用【天王护命丹】后的10时序不会死亡。",1,"CD:","回合","天王"}
	CC.ZTSM[10] = {"白云熊胆","时序回复8点内力。",1,"CD:","回合","白云"}
	CC.ZTSM[11] = {"即墨老酒","时序减少1点流血。",1,"CD:","回合","即墨"}
	CC.ZTSM[12] = {"五宝花蜜酒","免疫中毒。",1,"CD:","回合","五宝"}
	CC.ZTSM[13] = {"玉露酒","灼烧程度时序减1。",1,"CD:","回合","玉露"}
	CC.ZTSM[14] = {"梨花酒","冰封程度时序减1。",1,"CD:","回合","梨花"}
	CC.ZTSM[15] = {"诸法无我","自身每行动一个回合，伤害和减伤都上升，最多六层。",1,"CD:","回合","诸法"}
	CC.ZTSM[16] = {"皆","免疫破绽。",1,"CD:","回合","皆"}
	CC.ZTSM[17] = {"前","增加1000气攻，攻击范围扩大。",1,"CD:","回合","前"}
	CC.ZTSM[18] = {"在","必灼烧。",1,"CD:","回合","在"}
	CC.ZTSM[19] = {"阵","攻击造成目标内力损失200点。",1,"CD:","回合","阵"}
	CC.ZTSM[20] = {"列","攻击造成麻痹效果。",1,"CD:","回合","列"}
	CC.ZTSM[21] = {"者","为自身增加气防800点一回合。",1,"CD:","回合","者"}
	CC.ZTSM[22] = {"斗","增加气攻800点。",1,"CD:","回合","斗"}
	CC.ZTSM[23] = {"兵","攻击破防20%。",1,"CD:","回合","兵"}
	CC.ZTSM[24] = {"临","增加伤害15%。",1,"CD:","回合","临"}
	CC.ZTSM[25] = {"西瓜刀·天人","免疫杀气。",1,"CD:","回合","天人"}
	CC.ZTSM[26] = {"西瓜刀·残刀","伤害增加500点。",1,"CD:","回合","残刀"}
	CC.ZTSM[26] = {"西瓜刀","触发下列特效之一：回气/点燃/冻结/攻击不加怒/造成昏迷。",1,"CD:","回合","残刀"}
	CC.ZTSM[27] = {"血战八方","每击杀一个敌人，自身伤害、气攻、攻击范围提升，每攻击一次减少一层。",1,"CD:","回合","血战"}
	CC.ZTSM[28] = {"吸星真气","护盾。",1,"CD:","回合","吸星"}
	CC.ZTSM[29] = {"恐惧状态","随机移动且无法执行其他操作。",2,"CD:","回合","恐惧"}
	CC.ZTSM[30] = {"逆水寒CD","触发【逆寒水】后进入冷却状态，冷却状态清除，可再次触发【逆水寒】。",2,"CD:","回合","逆水寒"}
	CC.ZTSM[31] = {"否极泰来","触发【否极泰来】状态后进入冷却状态。",1,"CD:","回合","否极"}
	CC.ZTSM[32] = {"复活","已触发复活，一场战斗最多只可触发一次复活。",2,"CD:","回合","复活"}
	CC.ZTSM[33] = {"降临","每次行动前增加一层【降临】，【降临】达到五层时，必触发【万佛朝宗】。",1,"CD:","回合","降临"}
	CC.ZTSM[34] = {"曲风状态","曲风30层触发【百鸟朝凤】。",2,"CD:","回合","曲风"}
	CC.ZTSM[35] = {"无名业火","根据使用武功消耗的内力减少生命值。",2,"CD:","回合","业火"}
	CC.ZTSM[36] = {"同归状态","主动攻击造成伤害时，受到100%反伤。",2,"CD:","回合","同归"}
	CC.ZTSM[37] = {"走火入魔","集气增加，怒气增加，伤害增加，气攻增加。",1,"CD:","回合","走火"}
	CC.ZTSM[38] = {"十龙十象","攻击时造成目标昏迷。",1,"CD:","回合","龙象"}
	CC.ZTSM[39] = {"昏迷状态","无法行动。",2,"CD:","回合","昏迷"}
	CC.ZTSM[40] = {"太极蓄力","跟据蓄力值，攻击时可触发开太极。",1,"CD:","回合","太极"}
	CC.ZTSM[41] = {"蛤蟆蓄力","根据蓄力值增加伤害和气攻、气防。",1,"CD:","回合","蛤蟆"}
	CC.ZTSM[42] = {"鲸息蓄力","根据蓄力值增加伤害和气攻、气防。",1,"CD:","回合","鲸息"}
	CC.ZTSM[43] = {"金刚护盾","伤害减少20~50%，气攻减少20~50%。",1,"CD:","回合","护盾"} --备用无效
	CC.ZTSM[44] = {"神足护盾","伤害减少20~50%，气攻减少20~50%。",1,"CD:","回合","护盾"} --备用无效
	CC.ZTSM[45] = {"禁药状态","血量越低集气越快，100%血无加成，1血99%加成。",1,"CD:","回合","禁药"}
	CC.ZTSM[46] = {"沉睡状态","无法行动，受到攻击会马上解除状态。",2,"CD:","回合","沉睡"}
	CC.ZTSM[47] = {"玉石俱焚","伤害减少20~50%，气攻减少20~50%。",1,"CD:","回合","俱焚"}  --暂无效果
	CC.ZTSM[48] = {"混乱状态","行动混乱，不可操控。",2,"CD:","回合","混乱"}
	CC.ZTSM[49] = {"散功状态","每时序损失1%当前内力,无法触发内功和轻功特效。",2,"CD:","回合","散功"}
	CC.ZTSM[50] = {"雷音状态","三层雷音状态时攻击将使目标昏迷。",1,"CD:","回合","雷音"}
	CC.ZTSM[51] = {"参合状态","攻击造成的伤害在70%~90%之间浮动，受到的伤害在110%~130%之间浮动。",2,"CD:","回合","参合"}
	CC.ZTSM[52] = {"号令三军","伤害减少20~50%，气攻减少20~50%。",1,"CD:","回合","号令"} --暂无效果
	CC.ZTSM[53] = {"偷天换日","【偷天换日达到】100层回复满状态。",1,"CD:","回合","偷天"}
	CC.ZTSM[54] = {"长生回天","时序回复0.5%生命、5%内力、1点体力;时序恢复1点冰封、灼烧、中毒、内伤。",1,"CD:","回合","回天"}
	CC.ZTSM[55] = {"虚弱状态","攻击力减少25%。",2,"CD:","回合","虚弱"}
	CC.ZTSM[56] = {"放下屠刀","无法行动一回合。",2,"CD:","回合","屠刀"}
	CC.ZTSM[57] = {"金刚咒","伤害减少20~50%，气攻减少20~50%。",1,"CD:","回合","金刚咒"} --暂无效果
	CC.ZTSM[58] = {"度化状态","战场上变成敌方阵营。",2,"CD:","回合","度化"}
	CC.ZTSM[59] = {"魅惑状态","战场上变成敌方阵营。",2,"CD:","回合","魅惑"}
	CC.ZTSM[60] = {"倾国倾城","由战场敌方承担全部伤害。",1,"CD:","回合","倾国"}
	CC.ZTSM[61] = {"三十二身像","减伤15%，攻击或被攻击触发：*【雀母相】：强制受到的伤害为50点，*【白毫相】：免疫杀气，*【大自在相】：受到攻击集气+200，*【神鱼相】：33%增加一次攻击。",1,"CD:","回合","身像"}
	CC.ZTSM[62] = {"金刚法相","增加800点气攻，忽视绝对气防。",1,"CD:","回合","法相"}
	CC.ZTSM[63] = {"小李飞刀","攻击必中，暗器攻击倍数3~10倍。",1,"CD:","回合","飞刀"}
	CC.ZTSM[64] = {"天剑","攻击必中，追加伤害1200点。",1,"CD:","回合","天剑"}
	CC.ZTSM[65] = {"十八盘","30时序内闪避攻击。",1,"CD:","回合","十八盘"}
	CC.ZTSM[66] = {"万毒蚀体CD","时序让五格内的目标中毒。",1,"CD:","回合","蚀体CD"} 
	CC.ZTSM[67] = {"长生诀","时序回复1%生命、内力、体力。",1,"CD:","回合","长生"}
	CC.ZTSM[68] = {"麻痹状态","减少移动步数。",2,"CD:","回合","麻痹"}
	CC.ZTSM[69] = {"锁足状态","无法移动、闪避、挪移。",2,"CD:","回合","锁足"}
	CC.ZTSM[70] = {"迟缓状态","一层减少1%集气值。",2,"CD:","回合","迟缓"}
	CC.ZTSM[71] = {"疾风劲","一层增加1.25%集气值。",1,"CD:","回合","疾风"}
	CC.ZTSM[72] = {"霸体","免疫伤害和异常状态。",1,"CD:","回合","霸体"}
	CC.ZTSM[73] = {"逍遥御风闪避","闪避伤害。",1,"CD:","回合","御风"}
	CC.ZTSM[74] = {"中庸","立即行动。",1,"CD:","回合","中庸"}
	CC.ZTSM[75] = {"盲目状态","命中值减少85%。",2,"CD:","回合","盲目"}
	CC.ZTSM[76] = {"刺目","造成目标盲目。",1,"CD:","回合","刺目"}
	CC.ZTSM[77] = {"杀破狼","气攻增加2000，满怒暴气不减怒气。",1,"CD:","回合","杀破狼"}
	CC.ZTSM[78] = {"杀破狼计时","【杀破狼】特效的计时。",1,"CD:","回合","杀破狼"}
	CC.ZTSM[79] = {"内伤状态","受到的伤害增加，并影响一些特效的触发。",2,"CD:","回合","内伤"}
	CC.ZTSM[80] = {"流血","时序减少生命值，并影响一些特效的触发。",2,"CD:","回合","流血"}
	CC.ZTSM[81] = {"封穴","封穴中无法行动。",2,"CD:","回合","封穴"}
	CC.ZTSM[82] = {"冰封","时序减少内力，减少移动步数，100点冰封会造成冻结效果。",2,"CD:","回合","冰封"}
	CC.ZTSM[83] = {"灼烧","受到伤害时，追加灼烧值的伤害，灼烧值大于25追加伤害翻倍。",2,"CD:","回合","灼烧"}
	CC.ZTSM[84] = {"点燃","时序减少生命。",2,"CD:","回合","点燃"}
	CC.ZTSM[85] = {"护盾值","可以抵消伤害。",1,"CD:","回合","护盾"} 
	CC.ZTSM[86] = {"中毒","时序减少生命值和内力值，减少属性。",2,"CD:","回合","中毒"}
	CC.ZTSM[87] = {"剧毒","每回合损失中毒程度X2倍的生命。",2,"CD:","回合","剧毒"}
	CC.ZTSM[88] = {"玄铁令","令一：天下人负我,自身受到的伤害增加20%。令二:我负天下人，免疫一次伤害且回复所受伤害的血量。令三:行止由心，两次行动。",1,"CD:","回合","玄铁令"}
	CC.ZTSM[89] = {"激昂","每行动一次增加5%伤害，最多增加30%。",1,"CD:","回合","激昂"}
	CC.ZTSM[90] = {"血魔","攻击吸血超过500点变为护盾，行动前吸收七格内敌方目标的流血化为护盾。",1,"CD:","回合","血魔"}
	CC.ZTSM[91] = {"卸甲状态","不计算当前额外附加的防御。",2,"CD:","回合","卸甲"}
	CC.ZTSM[92] = {"密宗印记","连续被密宗攻击，受到的伤害会越来越高。",1,"CD:","回合","印记"}
	CC.ZTSM[93] = {"神罗天征","反弹50%伤害。",1,"CD:","回合","神罗"}
	CC.ZTSM[94] = {"真武七截阵","格档+200，格档伤害50%。",1,"CD:","回合","七截阵"}
	CC.ZTSM[95] = {"十八罗汉阵","防御+100，气防+500，己方所有人平摊伤害。",1,"CD:","回合","罗汉阵"}
	CC.ZTSM[96] = {"天罡北斗阵","己方有人行动时，集气位置+50，被击败后队友行动时5%概率返回战场。",1,"CD:","回合","北斗阵"}
	CC.ZTSM[97] = {"九宫八卦阵","闪避+200，敌方命中-100，闪避概率二次判定。",1,"CD:","回合","八卦阵"}
	CC.ZTSM[98] = {"五行光明阵","敌方移动-5，集气-5，造成灼烧必点燃。",1,"CD:","回合","光明阵"}
	CC.ZTSM[99] = {"正反两仪阵","命中+100，发生合击时，伤害增加50%。",1,"CD:","回合","两仪阵"}
	CC.ZTSM[100] = {"打狗大阵","我方伤害+10%，攻击概率造成目标锁足一回合。",1,"CD:","回合","打狗阵"}
	CC.ZTSM[101] = {"集中状态","下回合攻击伤害和气攻减少50%，必中。",1,"CD:","回合","集中"}
	CC.ZTSM[102] = {"九歌","概率增加最多三次连次，九歌存在期间每回合结束回复气攻值生命。",1,"CD:","回合","九歌"}
	CC.ZTSM[103] = {"冻结","冻结目标，停止集气。",2,"CD:","回合","冻结"}
	CC.ZTSM[104] = {"备用","点燃目标，时序失去生命值。",1,"CD:","回合","备用"}   ---------------备用
	CC.ZTSM[105] = {"玄冰界","受到致命伤害时，免疫本次伤害并冻结自己30时序，冰冻其间免疫一切伤害并时序回复1%最大生命值。",1,"CD:","回合","玄冰界"}
	CC.ZTSM[106] = {"玄阴煞气","主运九阴神功每100时序触发一次【玄阴煞气】给自身五格范围内的敌人概率增加虚弱状态1回合，攻击对敌方造成10时序冻结。",1,"CD:","回合","玄阴"}
	CC.ZTSM[107] = {"天人合一","攻击和被功击获得2层【天人】效果，回合开始时按【天人】点数回复生命内力，增加【天人】点数真实伤害和真实减伤，上限49层。",1,"CD:","回合","天人"}
	CC.ZTSM[108] = {"浩然正气","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","浩然"}
	CC.ZTSM[109] = {"太极之形","每个“太极之形”可提高自身集气1点，每个5太极之形增加一次连击。。",1,"CD:","回合","太极"}
	CC.ZTSM[110] = {"无招胜有招","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","无招"}
	CC.ZTSM[111] = {"定乾坤","免疫伤害且停止行动100时序。",1,"CD:","回合","定乾坤"}
	CC.ZTSM[112] = {"魔神降临","怒气不减。",1,"CD:","回合","魔神"}
	CC.ZTSM[113] = {"天子观气","敌方全体集气减半,命中减少20%。。",1,"CD:","回合","天子"}
	CC.ZTSM[114] = {"撕裂","每时序损失0.5%最大值生命值。",1,"CD:","回合","撕裂"}
	CC.ZTSM[115] = {"柔网势","概率减少敌人移动步数。",1,"CD:","回合","柔网势"}
	CC.ZTSM[116] = {"紊乱状态","集气不受控制前后跳跃。",2,"CD:","回合","紊乱"}
	CC.ZTSM[117] = {"醉意","每层醉意伤害+10%/闪避+5%/命中减-5%。拥有醉意时概率击中目标破绽。醉意每回合自动减少1层，不可清除。。",1,"CD:","回合","醉意"}
	CC.ZTSM[118] = {"六道轮回","进入战斗开始只有N%三围,每回合+30%，每六个回合一轮回，轮回结束时生命/内力/体力恢复到100%'，清除所有异常状态。。",1,"CD:","回合","六道"}
	CC.ZTSM[119] = {"无妄","无视必中概率闪避。",1,"CD:","回合","无妄"}
	CC.ZTSM[120] = {"气血相生","每99时序判定当前内力和生命剩余比例来回复生命或者内力。",1,"CD:","回合","相生"}
	CC.ZTSM[121] = {"天机秘术","概率闪避，反弹，挪移，霸体。",1,"CD:","回合","天机"}
	CC.ZTSM[122] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[123] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[124] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[124] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[125] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[126] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[127] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[128] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[129] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[130] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[131] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[132] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[133] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[133] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[134] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[135] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[136] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[137] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[138] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[139] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[140] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[141] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[142] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[143] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[143] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[144] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[145] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[146] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[147] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[148] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[149] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[150] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[151] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[152] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}
	CC.ZTSM[153] = {"备用","攻击力+5%，攻击概率造成目标锁足一回合。",1,"CD:","回合","九歌"}




	CC.ZTCZSM = {"操作说明","鼠标左键点击装备栏：*无装备时可以执行装备操作，如果有装备点击显示装备说明。*按A键执行武器切换。*按B键执行防具切换。*按C键执行坐骑切换。*按J键/或鼠标点【可分配点数】执行加点。*按上下键切换队友。"}
	CC.TFCZSM = {"操作说明","up上翻天赋说明，down下翻天赋说明。"}
	CC.WGCZSM = {"操作说明","PgDn上翻武功说明，PgUp下翻武功说明。"}
	CC.QXCZSM = {"操作说明","每个人可以从战斗获取的武学点数上限为500，还可以通过稀有药物提升武学点数。*武学点数有限，请谨慎使用，一经使用概不返还。"}
	CC.SZCZSM = {"操作说明","无。"}
	--require("MyOEvent");

	--特殊经脉
	CC.TSJM_SSYIN = {}
		--指法
		CC.TSJM_SSYIN[1] = {'裂石','指法武功伤害5%，指法武功威力+200。',3,'指法系数>=100'}
		CC.TSJM_SSYIN[2] = {'穿云劲','指法武功无伤目标防御20%，指法武功封穴点数额外增加5点。',6,'指法系数>=200'}
		CC.TSJM_SSYIN[3] = {'灵犀一指','指法攻击必破气防，受到攻击必格档，[彩凤鸣岐]20%固定概率忽略目标此次伤害。',9,'指法系数>=400'}
		--剑法
		CC.TSJM_SSYIN[4] = {'剑气','剑法武功附加气攻值20%的伤害。',12,'剑法系数>=100'}
		CC.TSJM_SSYIN[5] = {'御剑术','主运五岳剑诀每2点御剑能力增加1点伤害，触发以剑御气减少（御剑能力/1000））%的伤害。',15,'剑法系数>=200'}
		CC.TSJM_SSYIN[6] = {'一剑镇神州','辟邪剑法/玄铁剑法招式移动距离增加4格，使用剑法时10%固定概率触发【无我无剑】先手反击。',19,'剑法系数>=400'}
		--毒系
		CC.TSJM_SSYIN[7] = {'炼毒','攻击带毒+20点，用毒能力和用毒上限+20点。',22,'用毒能力>=100'}
		CC.TSJM_SSYIN[8] = {'盅毒降','用毒能力和用毒上限+30点。学会秘技毒布武林和紫气天罗用毒增加80点；击中敌方目标时，敌方目标损失中毒点数100%的伤害。',25,'用毒能力>=200'}
		CC.TSJM_SSYIN[9] = {'万毒蚀体','用毒能力和用毒上限+100点，自身免疫中毒；被攻击时给攻击方上毒10~20点；每100时序给我方五格内所有敌人施毒。',28,'用毒能力>=400'}


	CC.TSJM_SSYANG = {}
		--拳法
		CC.TSJM_SSYANG[1] = {'开碑','增加拳掌武功伤害20%。',32,'拳法系数>=100'}
		CC.TSJM_SSYANG[2] = {'通臂拳','拳法追加5点内伤。须弥山神掌触发绝招如来神掌/如来神掌.灭,提升概率10%；降龙十八掌/黯然销魂掌极意概率增加15%；般若掌造成的最终伤害不会低于武功威力。',36,'拳法系数>=200'}
		CC.TSJM_SSYANG[3] = {'盖世神拳','使用拳法时行动前蓄力，随攻击范围内目标目标数量增减伤害-20%~50%。',40,'拳法系数>=400'}
		--刀法
		CC.TSJM_SSYANG[4] = {'拔刀','刀法爆击伤害增加30%。',44,'刀法系数>=100'}
		CC.TSJM_SSYANG[5] = {'九寒焰','攻击时会对周身7格范围内的敌人：【九寒焰.沧溟】沧溟刀法冰封20点，20%概率冻结10时序；【九寒焰.九歌】天刀九问流血20~40点，触发【九歌】概率增加10%，；【九寒焰.烈焰】火焰刀法灼烧，20%概率点燃10时序。',48,'刀法系数>=200'}
		CC.TSJM_SSYANG[6] = {'傲世狂刀','胡刀极意必触发且范围+1，战场上每多一个敌人，自身伤害增加5%，使用刀法攻击+30暴击率，无视敌方30%防御，攻击增加自身怒气值5点。',51,'刀法系数>=400'}
		--阳内
		CC.TSJM_SSYANG[7] = {'浴火','攻击时灼烧值增加100%。受到伤害时，30%概率使攻击方灼烧。',54,'阳内且少林九阳功/峨眉九阳功/武当九阳功到极'}
		CC.TSJM_SSYANG[8] = {'火神君','主运主九阳神功/圣火神功/纯阳无极功/龙象般若功攻击时主攻动攻击时直接30%概率点燃目标10时序。',57,'阳内且内力最大值 >= 5000'}
		CC.TSJM_SSYANG[9] = {'至阳之体','防御+10%；【九阳护体】主运内功九阳神功后50%概率减伤30%，吸收20%受到的伤害化为护盾，每次行动后增加一个防御值50%的护盾。',61,'阳内且（天赋内功）九阳神功'}

	CC.TSJM_ZSYIN = {} 
		--奇门
		CC.TSJM_ZSYIN[1] = {'碎甲','特系武功无视目标防御40%,依特殊兵器武功数量概率无视目标防御100%',65,'特殊兵器系数>=100'}
		CC.TSJM_ZSYIN[2] = {'兵器谱','背包里的可以装备的所有奇门兵器都计算装备状态，增加的属性值只有一半。',69,'特殊兵器系数>=200'}
		CC.TSJM_ZSYIN[3] = {'奇门无双','特系武功几率附加剧毒，使用灵蛇杖法必出【大蛇无双】；打狗棒法奥义几率增加20%；攻击时必破气防且100%概率造成锁足。',72,'特殊兵器系数>=400'}
		--阴内
		CC.TSJM_ZSYIN[4] = {'凌冽','攻击时冰封值增加100%。受到伤害时，30%概率使攻击方冰封。',76,'阴内且紫霞神功/寒冰真气到极'}
		CC.TSJM_ZSYIN[5] = {'玄冰界','主运九阴神功/寒冰真气/逆运神功/灵犀分水功攻击时30%概率使目标冻结10时序；受到致命伤害时，触发【玄冰结界】使自己冰冻，并时序回复生命到30%，其间免疫任何伤害。',80,'阴内且内力最大值>=5000'}
		CC.TSJM_ZSYIN[6] = {'至阴之体','攻击+10%；免疫冰封；【玄阴煞气】主运九阴神功每100时序触发一次【玄阴煞气】给自身五格范围内的敌人概率增加虚弱状态1回合；攻击时冻结攻击目标和自身周围五格内的目标10时序。',83,'阴内且（天赋内功）九阴神功'}
		--低资
		CC.TSJM_ZSYIN[7] = {'象形','攻击后进入防御状态；主运鲸息功会触发六大奇劲。',87,'鲸息功/龙象般若功/蛤蟆功/龟息功/狮吼功到极'}
		CC.TSJM_ZSYIN[8] = {'修罗道','主运血海魔功/天魔功/血河神鉴吸血上限增加100。溢出的吸血会转化为护盾值。',91,'内力>7000'}
		CC.TSJM_ZSYIN[9] = {'太玄真解','生命上限+300，太玄神功解锁主运特效【混沌太玄】的两种特效,增加固定触发概率5%。',95,'学会左右互搏'}

	CC.TSJM_ZSYANG = {}
		--轻功
		CC.TSJM_ZSYANG[1] = {'梅花','闪避+20%，命中+20%。',99,'轻功>=200'}
		CC.TSJM_ZSYANG[2] = {'鱼龙跃','闪避后自身集气位置+100。',103,'轻功>=300'}
		CC.TSJM_ZSYANG[3] = {'凌空虚渡','轻功+10%，30%免疫反击,反弹。',106,'轻功>=400'}
		--回复
		CC.TSJM_ZSYANG[4] = {'祝由','每时序回复3点生命/10点内力，6时序回复1点体力。',110,'学会罗汉伏魔功/紫霞神功/混元功/枯荣禅功且到极'}
		CC.TSJM_ZSYANG[5] = {'归元境','神照经/先天功/长生诀到极主运复活变为被动复活,复活后获得500点护盾，先天功翻倍；复活后气防增加25%。',114,'内力>5000'}
		CC.TSJM_ZSYANG[6] = {'离经易道','体质+2，主运长生诀/大长和诀/枯荣禅功，任何人行动后回复自5%生命值、200点内力值、1点体力值、5点怒气值。',117,'精通（天赋内功）长生诀/大长和诀/枯荣禅功'}
		--调和内
		CC.TSJM_ZSYANG[7] = {'炼气','气防增加10%，气攻增加10%，10%免疫杀气。',121,'调和内且太虚剑意/忘情天书/小无相功到极'}
		CC.TSJM_ZSYANG[8] = {'步亦趋','主运葵花神功回合结束时50%增加300点集气值；主运擒龙功必锁足。',125,'调和内且内力最大值>=5000'}
		CC.TSJM_ZSYANG[9] = {'天人合一','内力最大值+500；主运易筋神功/阴阳无极功时，攻击和被功击获得2层【天人】效果，回合开始时按【天人】点数回复生命内力，增加【天人】点数真实伤害和真实减伤，上限49层。',129,'调和内且精通（天赋内功）易筋神功/阴阳无极功'}

	CC.TSJM_RENDU = {}
		--中资
		CC.TSJM_RENDU[1] = {'乾坤','乾坤大挪移反弹伤害增加50%。',132,'乾坤大挪移到极'}
		CC.TSJM_RENDU[2] = {'逍遥游','主运浑天气功行动前每回合随机获得一种酒效果,同一种酒不会叠加持续效果时间；学会北冥神功不需运功被动挨打吸内；大周天功到极【养生主】效果翻倍。',135,'内力>5000'}
		CC.TSJM_RENDU[3] = {'浩然正气','攻击+5%，防御+5%；【浩然正气】：行动前发动，统计全员的状态（特殊状态不计算）每一个状态增加1点【浩然】，并清除己方所有减益状态，每点【浩然】增强自身伤害+5%，下回自己集气位置+20。',139,'学会中庸之道'}
		--高资
		CC.TSJM_RENDU[4] = {'观星','奇门五转特效概率+5%，学会吸星大法/化功大学化内/吸体不需运功被动挨打吸内。',142,'奇门五转/吸星大法/化功大法到极'}
		CC.TSJM_RENDU[5] = {'太极图','主运太极神功时太极蓄力只清除50%，真太奥触发后减伤50%，且概率最多只受到99点伤害。',145,'内力>5000'}
		CC.TSJM_RENDU[6] = {'物转星移','攻击+5%，防防御+5%；全抗性+20%；斗转到极自动运功，斗转伤害+20%； 武功消耗降内力和真气（能量）降低50%。',149,'学会斗转星移秘技'}




	--十二正经 -- 
	--1：名称 ， 2：效果， 3：值，4:说明文字，5：耗点, 6：x坐标，7：y坐标 ,8：奇穴编号
	--手三阴经
	--手少阴--学会阴性二阶/调和内功 1~9
	CC.Sshaoyin = {}
	CC.Sshaoyin[1] = {"极泉","攻击力",4,"心主血脉，手少阴心经起于极泉，喻手少阴脉气由此如泉中之水急流而出。",10,634,399,1}
	CC.Sshaoyin[2] = {"清灵","轻功",4,"手少阴心经的常用腧穴之一，出自于《太平圣惠方》。",10,658,363,2}
	CC.Sshaoyin[3] = {"少海","防御力",4,"少，阴也，水也。海，大也，百川所归之处也。",100,681,392,3} --特殊
	CC.Sshaoyin[4] = {"灵道","攻击力",4,"手太阴心经的常用腧穴之一。",10,714,359,4}
	CC.Sshaoyin[5] = {"通里","轻功",4,"在尺侧腕曲肌与指浅曲肌之间，深层为指伸曲肌，有尺动脉通过。",10,743,387,5}
	CC.Sshaoyin[6] = {"阴希","防御力",4,"阴郄。阴，水也。郄，空隙也。心经经水由本穴回流体内经脉。",150,760,354,6}  --特殊
	CC.Sshaoyin[7] = {"神门","攻击力",4,"神门。神，与鬼相对，气也。门，出入的门户也。",10,790,374,7}
	CC.Sshaoyin[8] = {"少府","轻功",4,"少府。少，阴也。府，府宅也。该穴名意指本心经气血在此聚集。",10,795,308,8}
	CC.Sshaoyin[9] = {"少冲","攻击力",4,"少冲。少，阴也。冲，突也。少冲名意指本穴的气血物质由体内冲出。",200,815,261,9} --特殊
	--18点
	--手太阴经--学会三阶阳性/调和内功 10~19
	CC.Staiyin = {}
	CC.Staiyin[1] = {"中府","攻击力",4,"人体腧穴之一，出自《脉经》，属于手太阴肺经的募穴。",10,756,404,10}
	CC.Staiyin[2] = {"云门","轻功",4,"出自《素问·水热穴论》。属手太阴肺经。",10,719,426,11}
	CC.Staiyin[3] = {"天府","防御力",4,"天，天空，指上而言。府，聚集处。鼻通天气，聚处为府为库。",100,697,373,12} --特殊
	CC.Staiyin[4] = {"侠白","攻击力",4,"侠与夹通。白，肺色也。出自《针灸甲乙经》 。属手太阴肺经。",10,671,409,13}
	CC.Staiyin[5] = {"尺泽","轻功",4,"出自《灵枢·本输》。别名鬼受、鬼堂。属手太阴肺经。",10,638,381,14}
	CC.Staiyin[6] = {"列缺","防御力",4,"列缺是人体腧穴之一，亦是八脉交会穴（通于任脉），出自《灵枢·经脉》。",150,616,426,15}  --特殊
	CC.Staiyin[7] = {"经渠","攻击力",4,"经，动而不居；渠，沟渠。此穴为手太阴肺经穴，其脉气流行不止。",10,580,419,16}
	CC.Staiyin[8] = {"太渊","轻功",4,"出自《灵枢·本输》。别名鬼心、太泉、大泉、天泉、大渊。",10,560,462,17}
	CC.Staiyin[9] = {"鱼际","攻击力",4,"出自《灵枢·本输》。属手太阴肺经。位于手外侧。",10,542,472,18}
	CC.Staiyin[10] = {"少商","攻击力",4,"此穴为肺经井穴，所出为井，是说手太阴肺经脉气外发似浅小水流。",200,516,509,19} --特殊
	--30
	--手厥阴经--学会四阶阴性/调和内功 20~28
	CC.Sjueyin = {}
	CC.Sjueyin[1] = {"天池","攻击力",4,"天池名意指心包外输的高温水气在此冷凝为地部经水。",10,740,393,20}
	CC.Sjueyin[2] = {"天泉","轻功",4,"出自《针灸甲乙经》。别名天温。属手厥阴心包经。",10,719,425,21}
	CC.Sjueyin[3] = {"曲泽","防御力",4,"手厥阴心包经的常用腧穴之一。位于肘横纹中。",100,683,417,22} --特殊
	CC.Sjueyin[4] = {"希门","攻击力",4,"手厥阴心包经的常用腧穴之一，出自于《针灸甲乙经》，位于在前臂掌侧。",10,667,377,23}
	CC.Sjueyin[5] = {"间使","轻功",4,"出自《灵枢·本输》。别名鬼路。属手厥阴心包经。",10,637,404,24}
	CC.Sjueyin[6] = {"内关","防御力",4,"手厥阴心包经的常用腧穴之一，出自于《灵枢·经脉》，位于前臂掌侧。",150,599,428,25}  --特殊
	CC.Sjueyin[7] = {"大陵","轻功",4,"出自《灵枢·本输》。《针灸甲乙经》作太陵。别名鬼心。",10,567,455,26}
	CC.Sjueyin[8] = {"劳宫","攻击力",4,"出自于《灵枢·本输》，位于手掌心。",10,537,487,27}
	CC.Sjueyin[9] = {"中冲","攻击力",4,"出自《灵枢·本输》。别名手心主。位于手指，中指末端最高点。",200,508,505,28} --特殊


	--手三阳经
	--36
	--手少阳--学会二阶阳性/调和内功 29~40
	CC.Sshaoyang = {}
	CC.Sshaoyang[1] =  {"丝竹空","攻击力",4,"位于眉梢凹陷处；在眼轮匝肌处；布有颞浅动、静脉的颞支；有眶上神经、颞面神经、面神经颞支和颧支分布。",10,577,267,29}
	CC.Sshaoyang[2] =  {"角孙","轻功",4,"出自《黄帝内经灵枢·寒热病》。属手少阳三焦经。角孙是手太阳小肠经、手足少阳三焦经的交会穴。",10,605,310,30}
	CC.Sshaoyang[3] =  {"颅息","防御力",4,"出自于《针灸甲乙经》，位于耳后，当角孙穴至翳风穴之间，沿耳轮连线的上、中半寸的交点处。",10,609,362,31}
	CC.Sshaoyang[4] =  {"翳风","轻功",4,"在耳垂后，当乳突与下颌骨之间凹陷处。",100,653,365,32} --特殊
	CC.Sshaoyang[5] =  {"天井","攻击力",4,"出自《灵枢·本输》。属手少阳三焦经。合（土）穴。在臂外侧，屈肘时，当肘尖直上一寸凹陷处。 ",10,671,414,33}
	CC.Sshaoyang[6] =  {"会宗","防御力",4,"出自《针灸甲乙经》。属手少阳三焦经。手少阳之郄穴。在前臂背侧，当腕背横纹上三寸。)篇说：尺动脉在五里。",10,702,391,34}
	CC.Sshaoyang[7] =  {"支沟","轻功",4,"位于前臂背侧，当阳池与肘尖的连线上，腕背横纹上三寸，尺骨与桡骨之间。",10,718,451,35}
	CC.Sshaoyang[8] =  {"外关","攻击力",4,"位于前臂背侧，在前臂后区，当阳池与肘尖的连线上。",150,748,418,36} --特殊
	CC.Sshaoyang[9] =  {"阳池","防御力",4,"阳池穴，是手少阳三焦经腧穴，在腕后区，腕背侧远端横纹上，指伸肌腱的尺侧缘凹陷中。",10,764,465,37}
	CC.Sshaoyang[10] =  {"中渚","轻功",4,"位于手背部，当第四掌指关节的后方，第四、五掌骨间凹陷处，",10,791,434,38}	
	CC.Sshaoyang[11] =  {"液门","防御力",4,"于第四、五指间缝纹端，有清头目，利三焦，通络止痛等功效。",10,823,451,39}	
	CC.Sshaoyang[12] =  {"关冲","防御力",4,"出自《灵枢·本输》。属手少阳三焦经。井(金)穴。在手无名指末节尺侧，距指甲角0.1寸处。",200,844,425,40}	 --特殊

	--手太阳 --学会三阶阳性/调和内功 41~51
	CC.Staiyang = {} 
	CC.Staiyang[1] =  {"听宫","攻击力",4,"听宫。听，闻声也。宫，宫殿也。位于面部，耳屏正中与下颌骨髁突之间的凹陷中。",10,850,399,41}
	CC.Staiyang[2] =  {"天容","防御力",4,"天，天部也。容，容纳、包容也。在下颌角后方，胸锁乳突肌停止部前缘，二腹肌腱的下缘。",10,812,393,42}
	CC.Staiyang[3] =  {"天窗","轻功",4,"该穴位于人体的颈外侧部，胸锁乳突肌的后缘，扶突穴后，与喉结相平，在斜方肌前缘，胸锁乳突肌后缘。",10,786,364,43}	
	CC.Staiyang[4] =  {"曲垣","攻击力",4,"出自于《针灸甲乙经》。在肩胛部，冈上窝内侧端，当臑俞与第二胸椎棘突连线的中点处。",100,758,392,44} --特殊
	CC.Staiyang[5] =  {"秉风","防御力",4,"出自《针灸甲乙经》。别名肩解。四阳交会之处。在肩胛部冈上窝中央，天宗直上，举臂有凹陷处。",10,721,353,45}	
	CC.Staiyang[6] =  {"天宗","轻功",4,"在肩胛部，大致在肩胛骨的正中，冈下窝中央凹陷处，与第四胸椎相平。",10,689,388,46}
	CC.Staiyang[7] =  {"肩贞","攻击力",4,"出自《素问·气穴论》。属手太阳小肠经。在肩关节后下方，臂内收时，腋后纹头上一寸。 ",10,653,352,47}
	CC.Staiyang[8] =  {"阳谷","防御力",4,"位于腕背横纹尺侧端，当尺骨茎突与三角骨之间的凹陷处，当尺侧腕伸肌腱的尺侧缘。",150,621,376,48} --特殊
	CC.Staiyang[9] =  {"后溪","轻功",4,"出自《灵枢·本输》。属手太阳小肠经。输(木)穴。八脉交会穴之一，通督脉。",10,563,350,49}
	CC.Staiyang[10] =  {"前谷","攻击力",4,"出自于《灵枢·本输》。在小指尺侧，第五掌指关节前方，掌指横纹端凹陷处，赤白肉际，握拳取穴。",10,520,346,50}
	CC.Staiyang[11] =  {"少泽","防御力",4,"位于手指，小指末节尺侧，指甲跟角侧上方0.1寸，有指掌侧固有动、静脉，指背动脉形成的动、静脉网。",200,487,357,51} --特殊
	
	--手阳明 --学会四阶阳性/调和内功 52~61
	--x=223 y=155
	CC.Syangming = {}
	CC.Syangming[1] =  {"迎香","攻击力",4,"出自《针灸甲乙经》。此腧穴在鼻翼外缘中点旁，当鼻唇沟中。",10,572,340,52}		
	CC.Syangming[2] =  {"扶突","轻功",4,"出自《灵枢·本输》，别名水穴。在颈外侧部，结喉旁，当胸锁乳突肌的前、后缘之间。",10,602,369,53}
	CC.Syangming[3] =  {"天鼎","防御力",4,"出自《针灸甲乙经》。在缺盆上，直扶突，气舍后一寸五分。",100,626,390,54} --特殊
	CC.Syangming[4] =  {"巨骨","攻击力",4,"出自《素问·气府论》，此穴在锁骨肩峰端与肩胛冈之间凹陷处。",10,678,400,55}
	CC.Syangming[5] =  {"手五里","轻功",4,"出自《针灸甲乙经》。别名大禁、五里、臂五里、尺之五里。《灵枢·本输》篇说：尺动脉在五里。",10,685,369,56}
	CC.Syangming[6] =  {"温留","防御力",4,"出自《针灸甲乙经》 。别名逆注、蛇头。乃气血深聚之处。",150,720,400,57} --特殊
	CC.Syangming[7] =  {"曲池","攻击力",4,"出自《灵枢·本输》。此腧穴在肘横纹外侧端，屈肘，当尺泽与肱骨外上髁连线中点；",10,737,442,58}
	CC.Syangming[8] =  {"阳溪","轻功",4,"出自《灵枢·本输》。别名中魁，在手腕上侧，两筋间陷中，溪为水所行，此则阳脉所经之溪也。",10,778,407,59}
	CC.Syangming[9] =  {"合谷","防御力",4,"出自《灵枢·本输》。别名虎口。气血在本穴处汇聚，汇聚之气形成强大的水湿云气场。",10,814,447,60}
	CC.Syangming[10] =  {"商阳","攻击力",4,"手阳明大肠经起于商阳穴，别名绝阳，为手阳明大肠经的井穴，出自于《灵枢·本输》。",200,849,405,61} --特殊
	
	--足三阴经
	--足少阴 --学会二阶阴内/调和内功 62~72
	CC.Zshaoyin = {}
	CC.Zshaoyin[1] =  {"俞府","轻功",4,"出自《灵枢·经脉》。足少阴肾经的常用腧穴之一。",10,485,308,62}
	CC.Zshaoyin[2] =  {"神藏","防御力",4,"中医针灸穴位之一，隶属足少阴肾经。",10,528,358,63}
	CC.Zshaoyin[3] =  {"灵墟","轻功",4,"出自于《针灸甲乙经》，是足少阴肾经的常用腧穴之一。",10,548,376,64}
	CC.Zshaoyin[4] =  {"神封","攻击力",4,"神，与鬼相对，指该穴内的物质为天部之气。封，封堵也。",100,585,398,65} --特殊
	CC.Zshaoyin[5] =  {"幽门","防御力",4,"胃与十二指肠相通的部分，又名上门穴，上关穴，幽关穴。",10,637,399,66}
	CC.Zshaoyin[6] =  {"阴谷","轻功",4,"阴谷。阴，阴性水湿也。谷，肉之大会也，两山所夹空隙也。",10,685,367,67}
	CC.Zshaoyin[7] =  {"照海","攻击力",4,"照海，照，照射也，海，大水也，是八脉交会穴，通阴蹻。",10,720,329,68}
	CC.Zshaoyin[8] =  {"大钟","防御力",4,"出《灵枢·经脉》。属足少阴肾经。足少阴之络穴。",150,732,279,69} --特殊
	CC.Zshaoyin[9] =  {"太溪","轻功",4,"太溪穴是足少阴肾经的常用腧穴之一，出自《针灸甲乙经》。",10,773,274,70}
	CC.Zshaoyin[10] =  {"然谷","攻击力",4,"足少阴肾经的常用腧穴之一，出自于《灵枢·本输》，别名龙渊，然骨。位于在内踝前下方。",10,808,260,71}
	CC.Zshaoyin[11] =  {"涌泉","防御力",4,"涌泉穴是足少阴肾经的常用腧穴之一，位于足底部,涌，外涌而出也。泉，泉水也。",200,846,237,72} --特殊
		
	--足太阴 --学会三阴内/调和内功 63~83
	CC.Ztaiyin = {}
	CC.Ztaiyin[1] =  {"大包","轻功",4,"出自《灵枢·经脉》。属足太阴脾经。脾之大络。右侧胸部，腋中线上，当第六肋间隙处。",10,496,456,73}	
	CC.Ztaiyin[2] =  {"天溪","防御力",4,"属足太阴脾经，位于胸部，第四肋间隙，前正中线旁。",10,549,449,74}
	CC.Ztaiyin[3] =  {"府舍","攻击力",4,"出自《针灸甲乙经》。属足太阴脾经。在下腹部，当脐中下四寸。",10,596,471,75}
	CC.Ztaiyin[4] =  {"冲门","轻功",4,"出自《针灸甲乙经》。别名慈宫、上慈宫。在腹股沟外侧。",100,654,484,76} --特殊
	CC.Ztaiyin[5] =  {"箕门","防御力",4,"箕，土箕也，担物之器也。门，出入的门户也。出《针灸甲乙经》。属足太阴脾经。",10,682,450,77}
	CC.Ztaiyin[6] =  {"血海","攻击力",4,"足太阴脾经的一个普通腧穴，出自《针灸甲乙经》。",10,699,400,78}
	CC.Ztaiyin[7] =  {"漏谷","轻功",4,"属于足太阴脾经的穴位，漏谷。漏，漏落也。谷，五谷也、细小之物也。",10,730,365,79}
	CC.Ztaiyin[8] =  {"公孙","防御力",4,"出《灵枢·本输》。属足太阴脾经。八脉交会穴之一，通冲脉。",150,735,322,80} --特殊
	CC.Ztaiyin[9] =  {"太白","攻击力",4,"出《灵枢·本输》。属足太阴脾经。输（土）、原穴。",10,763,276,81}
	CC.Ztaiyin[10] =  {"大都","轻功",4,"出《灵枢·本输》，隶属足太阴脾经荥穴。",10,811,263,82}
	CC.Ztaiyin[11] =  {"隐白","防御力",4,"隐白。隐，隐秘、隐藏也。白，肺之色也，气也。出自《针灸甲乙经》。",200,851,251,83} --特殊

	
	--足厥阴 --学会四阶阴内/调和内功 84~95
	CC.Zjueyin = {}
	CC.Zjueyin[1] =  {"大敦","防御力",4,"出《灵枢·本输》。大敦别名水泉、三毛、大顺、太敦、足大趾丛毛。",10,854,263,84}
	CC.Zjueyin[2] =  {"太冲","攻击力",4,"出自《庄子·应帝王》，吾乡示之以太冲莫胜，是殆见吾衡气机也。",10,791,262,85}
	CC.Zjueyin[3] =  {"中封","轻功",4,"出《灵枢·本输》，商丘与解溪连线之间。",10,769,305,86}
	CC.Zjueyin[4] =  {"中都","防御力",4,"中都穴位于内踝上七寸，胫骨内侧面的中点或胫骨后缘处。",100,726,307,87} --特殊
	CC.Zjueyin[5] =  {"膝关","攻击力",4,"隶属足厥阴肝经。位于在小腿内侧，当胫骨内髁的后下方。",10,728,368,88}
	CC.Zjueyin[6] =  {"曲泉","轻功",4,"《灵枢·本输》：“肝入于曲泉。曲泉，辅骨之下，大筋之上也，屈膝而得之，为合，足厥阴也。",10,663,363,89}
	CC.Zjueyin[7] =  {"阴包","防御力",4,"出自《针灸甲乙经》，为肝经上重要腧穴之一",10,648,440,90}
	CC.Zjueyin[8] =  {"足五里","攻击力",4,"位于人体的大腿内侧，当气冲穴直下三寸。",150,607,411,91} --特殊
	CC.Zjueyin[9] =  {"阴廉","轻功",4,"阴，指阴性水湿。廉，收廉之意。本穴如同肝经水湿的收廉之处，故名。",10,568,384,92}
	CC.Zjueyin[10] =  {"急脉","防御力",4,"又名羊矢穴，意指穴内气血如羊屎般饱满坚实。",10,547,337,93}
	CC.Zjueyin[11] =  {"章门","攻击力",4,"章门，出入的门户也。意指肝经的强劲风气在此风停气息。",10,505,337,94}	
	CC.Zjueyin[12] =  {"期门","轻功",4,"别名，肝募穴。期门。期，期望、约会之意。门，出入的门户。",200,477,365,95} --特殊

	--足三阳经
	--足少阳 --学会阳内二阶内功/调和内功 96~106
	CC.Zshaoyang = {}
	CC.Zshaoyang[1] =  {"听会","轻功",4,"出自《???灸甲乙经》。别名听呵、听河、后关。属足少阳胆经。",10,466,238,96}
	CC.Zshaoyang[2] =  {"上关","攻击力",4,"出自于《灵枢·本输》，别名客主人、客主、容主。位于耳前。",10,492,270,97}
	CC.Zshaoyang[3] =  {"完骨","防御力",4,"出自《素问·气穴论》。属足少阳胆经。在头部，当耳后乳突的后下方凹陷处。",10,511,293,98}
	CC.Zshaoyang[4] =  {"中都","轻功",4,"。出《针灸甲乙经》。足厥阴肝经穴，别名中郄、太阴。在小腿内侧。",100,546,314,99} --特殊
	CC.Zshaoyang[5] =  {"阳白","攻击力",4,"阳白，人体的一个穴位。足少阳胆经穴。在前额部，当瞳孔直上，眉上一寸。",10,578,346,100}
	CC.Zshaoyang[6] =  {"风池","防御力",4,"出自《灵枢·热病》。属足少阳胆经。足少阳、阳维之会。，与风府相平。",10,624,365,101}
	CC.Zshaoyang[7] =  {"环跳","轻功",4,"出自《针灸甲乙经》。别名枢中，髀枢，髌骨，髋骨，分中，髀厌。",10,676,410,102}
	CC.Zshaoyang[8] =  {"阳交","攻击力",4,"出自《千金方》，在小腿外侧，当外踝尖上7寸，腓骨后缘。",150,718,371,103} --特殊
	CC.Zshaoyang[9] =  {"光明","防御力",4,"出《针灸甲乙经》。属足太阴脾经。在下腹部，当脐中下四寸。",10,776,377,104}
	CC.Zshaoyang[10] =  {"悬钟","轻功",4,"属足太阴脾经，位于胸部，第四肋间隙，前正中线旁。",10,789,316,105}
	CC.Zshaoyang[11] =  {"侠溪","防御力",4,"出《灵枢·经脉》。属足太阴脾经。脾之大络。",200,810,281,106}	 --特殊

	--足太阳 --学会阳内三阶内功/调和内功 107~117
	CC.Ztaiyang = {}
	CC.Ztaiyang[1] =  {"晴明","轻功",4,"睛明是足太阳膀胱经俞穴，位于目内眦外，在鼻梁两侧距内眼角半分的地方。穴主目视不明，故名睛明。",10,477,230,107}
	CC.Ztaiyang[2] =  {"眉冲","防御力",4,"眉冲是足太阳膀胱经的常用腧穴之一，出自《脉经》，别名小竹。",10,505,284,108}
	CC.Ztaiyang[3] =  {"承光","攻击力",4,"承光，经穴名。出《针灸甲乙经》。属足太阳膀胱经。在头部，当前发际正中直上三寸，旁开二寸。",10,528,330,109}
	CC.Ztaiyang[4] =  {"玉枕","轻功",4,"位于人体的后头部，当后发际正中直上三寸，旁开一寸半平枕外隆凸上缘的凹陷处。",100,576,319,110} --特殊
	CC.Ztaiyang[5] =  {"天柱","防御力",4,"天柱穴是足太阳膀胱经上的常用腧穴之一，位于颈后区，横平第二颈椎棘突上际。",10,593,376,111}
	CC.Ztaiyang[6] =  {"风门","攻击力",4,"风门亦称风门热府。出《针灸甲乙经》。别名热府。督脉、足太阳之会。",10,640,402,112}
	CC.Ztaiyang[7] =  {"会阳","轻功",4,"会阳，经穴名。出《针灸甲乙经》。别名利机。属足太阳膀胱经。在骶部，尾骨端旁开半寸。",10,695,437,113}
	CC.Ztaiyang[8] =  {"魄户","防御力",4,"魄户穴是足太阳膀胱经的常用腧穴之一，出自于《针灸甲乙经》，位于第三胸椎棘突下，旁开三寸。",150,748,416,114} --特殊
	CC.Ztaiyang[9] =  {"合阳","攻击力",4,"合阳穴，是足太阳膀胱经的常用腧穴之一，位于小腿后面，当委中穴与承山穴的连线上，委中穴直下二寸。",10,785,384,115}
	CC.Ztaiyang[10] =  {"昆仑","轻功",4,"昆仑，出《灵枢·本输》。别名下昆仑。属足太阳膀胱经。经(火)穴。在足部外踝后方。",10,820,352,116}
	CC.Ztaiyang[11] =  {"至阴","防御力",4,"至阴穴是足太阳膀胱经的常用腧穴之一，位于足小趾趾甲角旁半分处。",200,782,317,117} --特殊

	--足阳明   学会阳内四阶内功/调和内功  118~129
	CC.Zyangming = {}
	CC.Zyangming[1] =  {"迎香","轻功",4,"迎香是人体腧穴之一，属于手阳明大肠经，出自《针灸甲乙经》。此腧穴在鼻翼外缘中点旁，当鼻唇沟中。",10,470,231,118}
	CC.Zyangming[2] =  {"承浆","防御力",4,"别称下唇、天池、鬼市、悬浆，出《甲乙经》中。在口轮匝肌和颏唇沟之间。",10,525,270,119}
	CC.Zyangming[3] =  {"大迎","攻击力",4,"大迎，经穴名。出《素问·气穴论》。别名髓孔。在面部，下颌角前方咬肌附着部前缘。",10,534,314,120}
	CC.Zyangming[4] =  {"下关","轻功",4,"下关穴，人体穴位之一，在面部，在颧骨下缘中央与下颌切迹之间的凹陷中。出自《灵枢·本输》",100,582,335,121} --特殊
	CC.Zyangming[5] =  {"人迎","防御力",4,"人迎穴是足阳明胃经的常用腧穴之一，出自于《灵枢·本输》，别名天五会，五会。",10,606,382,122}
	CC.Zyangming[6] =  {"乳中","攻击力",4,"乳，乳头；中，中央；穴当乳头之正中，故名。本穴归属于足阳明胃经，临床不针不灸。",10,655,383,123}
	CC.Zyangming[7] =  {"关门","轻功",4,"关门，出《针灸甲乙经》。在上腹部，当脐中上三寸，距前正中线二寸。",10,700,388,124}
	CC.Zyangming[8] =  {"太乙","防御力",4,"太乙穴，属足阳明胃经，位于上腹部，脐中上两寸，前正中线旁开两寸，当腹直肌及其鞘处。",150,730,364,125} --特殊
	CC.Zyangming[9] =  {"天枢","攻击力",4,"天枢，经穴名。出自《灵枢·骨度》。别名长溪、长谷、补元。位于腹部，横平脐中，前正中线旁开二寸。",10,753,331,126}
	CC.Zyangming[10] =  {"气冲","轻功",4,"出自于《针灸甲乙经》，别名气街。在腹股沟稍上方，当脐中下五寸，距前正中线二寸。",10,784,318,127}
	CC.Zyangming[11] =  {"伏兔","防御力",4,"伏兔，出《灵枢·经脉》。别名外沟。在大腿前面，当髂前上棘与髌底外侧端的连线上，髌底上六寸。",10,824,308,128}
	CC.Zyangming[12] =  {"冲阳","防御力",4,"冲阳，出《灵枢·本输》。别名会原、会骨、趺阳。在足背最高处，当拇长伸肌腱与趾长伸肌腱之间。",200,840,275,129} --特殊


	--任脉   130~139
	CC.Renmai = {}
	CC.Renmai[1] =  {"会阴","防御力",4,"会阴，出自《针灸甲乙经》。会阴别名屏翳、下极、金门。属任脉。",10,650,554,130}
	CC.Renmai[2] =  {"关元","攻击力",4,"出自《灵枢·寒热病》。别名三结交、下纪、次门、丹田、大中极。小肠募穴。在下腹部，前正中线上，当脐中下三寸。",10,650,501,131}
	CC.Renmai[3] =  {"气海","轻功",4,"气海，经穴名。出《针灸甲乙经》。气海别名脖胦、下盲、下气海。在下腹部前正中线上，当脐中下一寸半处。",100,650,470,132} --特殊
	CC.Renmai[4] =  {"神阙","攻击力",4,"太乙穴，属足阳明胃经，位于上腹部，脐中上两寸，前正中线旁开两寸，当腹直肌及其鞘处。",10,650,432,133}
	CC.Renmai[5] =  {"巨阙","防御力",4,"出自于《针灸甲乙经》，别名气街。在腹股沟稍上方，当脐中下五寸，距前正中线二寸。",10,650,404,134}
	CC.Renmai[6] =  {"中庭","轻功",4,"冲阳，出《灵枢·本输》。别名会原、会骨、趺阳。在足背最高处，当拇长伸肌腱与趾长伸肌腱之间，足背动脉搏动处。",150,650,376,135} --特殊
	CC.Renmai[7] =  {"玉堂","防御力",4,"冲阳，出《灵枢·本输》。别名会原、会骨、趺阳。在足背最高处，当拇长伸肌腱与趾长伸肌腱之间，足背动脉搏动处。",10,650,348,136}
	CC.Renmai[8] =  {"华盖","攻击力",4,"冲阳，出《灵枢·本输》。别名会原、会骨、趺阳。在足背最高处，当拇长伸肌腱与趾长伸肌腱之间，足背动脉搏动处。",10,650,310,137}
	CC.Renmai[9] =  {"天突","轻功",4,"冲阳，出《灵枢·本输》。别名会原、会骨、趺阳。在足背最高处，当拇长伸肌腱与趾长伸肌腱之间，足背动脉搏动处。",10,650,282,138}
	CC.Renmai[10] =  {"承浆","攻击力",4,"冲阳，出《灵枢·本输》。别名会原、会骨、趺阳。在足背最高处，当拇长伸肌腱与趾长伸肌腱之间，足背动脉搏动处。",200,650,254,139} --特殊


	--督脉 140~149
	CC.Dumai = {}
	CC.Dumai[1] =  {"长强","攻击力",4,"出《灵枢·经脉》。别名气之阴郄、橛骨、气郄、为之、骨骶。",10,650,560,140}
	CC.Dumai[2] =  {"命门","防御力",4,"出《针灸甲乙经》。属督脉。别称属累。位于第二、三腰椎棘突间。",10,650,535,141}
	CC.Dumai[3] =  {"悬枢","轻功",4,"出《针灸甲乙经》。属督脉。在腰部，当后正中线上。",100,650,510,142} --特殊
	CC.Dumai[4] =  {"至阳","攻击力",4,"出《针灸甲乙经》。属督脉。别名肺底。在背部，当后正中线上。",10,650,460,143}
	CC.Dumai[5] =  {"灵台","防御力",4,"出《黄帝内经素问·气府论》王冰注。属督脉。灵：神灵；台：亭台。",10,650,410,144}
	CC.Dumai[6] =  {"神道","轻功",4,"出《针灸甲乙经》。别名冲道。属督脉。在背部，当后正中线上",150,650,360,145} --特殊
	CC.Dumai[7] =  {"大椎","攻击力",4,"大椎。大，多也。椎，锤击之器也。",10,650,310,146}
	CC.Dumai[8] =  {"风府","防御力",4,"出《素问·气府论》。别名本穴、鬼穴。属督脉。",10,650,290,147}
	CC.Dumai[9] =  {"百会","轻功",4,"出《针灸甲乙经》。别名“三阳五会”。属督脉。位于头部。",10,650,260,148}
	CC.Dumai[10] =  {"印堂","攻击力",4,"出自《扁鹊神应针灸玉龙经》，属于经外奇穴。此腧穴位于人体额部，在两眉头的中间。",200,650,240,149} --特殊


	CC.s1 = #CC.Sshaoyin  -- 9
	CC.s2 = CC.s1 + #CC.Staiyin -- 19
	CC.s3 = CC.s2 + #CC.Sjueyin -- 28 
	CC.s4 = CC.s3 + #CC.Sshaoyang
	CC.s5 = CC.s4 +  #CC.Staiyang
	CC.s6 = CC.s5 +  #CC.Syangming
	CC.z1 = CC.s6 + #CC.Zshaoyin
	CC.z2 = CC.z1 + #CC.Ztaiyin
	CC.z3 = CC.z2 + #CC.Zjueyin
	CC.z4 = CC.z3 + #CC.Zshaoyang
	CC.z5 = CC.z4 + #CC.Ztaiyang
	CC.z6 = CC.z5 + #CC.Zyangming
	CC.rd1 = CC.z6 + #CC.Renmai
	CC.rd2 = CC.rd1 + #CC.Dumai
	CC.qxnum = {CC.s1,CC.s2,CC.s3,CC.s4,CC.s5,CC.s6,CC.z1,CC.z2,CC.z3,CC.z4,CC.z5,CC.z6,CC.rd1,CC.rd2}



	CC.JMQX = {}
	CC.JMQX[1] = {[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0,}


	CC.Tiangtf1 = {9849,9848,9896,9926,9895,9915,9824,9825,9867,9819,9835,9834,9791,9837,9810}	

	--护盾
    CC.HD = {}
    CC.HD[1] = {name = '坐忘无我',tt = 2032,tt1 = 2042,sm = '周身释放一个吸收（武功等级+基础内功）*0.8点伤害的真气防护罩，防护罩消失前，所受初始伤害降低伤害３０％'}
    CC.HD[2] = {name = '菩提金身',tt = 2411,tt1 = 2422,sm = '受到的连击暴击伤害减少70%'}
    CC.HD[3] =  {name = '先天护盾',tt = 1305,tt1 = 1324,sm = '以护盾抵消伤害'}
    CC.HD[4] =  {name = '破剑八刀',tt = 1974,tt1 = 1986,sm = '反弹双倍伤害'}
	CC.HD[5] =  {name = '吸星真气',tt = 1345,tt1 = 1364,sm = '以护盾抵消伤害'}
	CC.HD[6] =  {name = '立地成佛',tt = 2697,tt1 = 2715,sm = '以护盾抵消伤害'}
	CC.HD[7] =  {name = '御气纵横',tt = 1920,tt1 = 1939,sm = '时序触发攻击'}
	CC.HD[8] =  {name = '不屈战魂',tt = 2760,tt1 = 2778,sm = '低于半血触发'}
	CC.HD[9] =  {name = '567',tt = 2741,tt1 = 2750,sm = '低于半血触发'}
	CC.HD[10] =  {name = '567',tt = 2751,tt1 = 2760,sm = '低于半血触发'}
	CC.HD[11] =  {name = '逆水寒',tt = 2970,tt1 = 2979,sm = '低于半血触发'} --光盾
	CC.HD[12] =  {name = '尸鬼封尽-蓝',tt = 2970,tt1 = 2979,sm = '免受死亡伤害'}
	CC.HD[13] =  {name = '尸鬼封尽-红',tt = 2980,tt1 = 2989,sm = '免受死亡伤害'}
	CC.HD[14] =  {name = '血魔',tt = 2428,tt1 = 2439,sm = '部分伤害'} --
	CC.HD[15] =  {name = '玄冰界',tt = 1732,tt1 = 1739,sm = '冰冻自己，回复生命，且不受任何伤害。'}
	--CC.HD[16] =  {name = '金身霸体',tt = 1758,tt1 = 1776,sm = '免疫伤害。'}  --	
    --半身像手动偏移
    CC.Png = {}

    --复制队友
    CC.Copy = {}
	--[[
    CC.Copy[93]=609
    --CC.Copy[610]=35
    CC.Copy[662]=1
    CC.Copy[663]=2
    CC.Copy[664]=9
    CC.Copy[665]=16
    CC.Copy[666]=17
    CC.Copy[667]=25
    CC.Copy[668]=28
    CC.Copy[669]=29
    CC.Copy[670]=35
    CC.Copy[671]=36
    CC.Copy[672]=37
    CC.Copy[673]=38
    CC.Copy[674]=44
    CC.Copy[675]=45
    CC.Copy[676]=47
    CC.Copy[677]=48
    CC.Copy[678]=49
    CC.Copy[679]=51
    CC.Copy[680]=52
    CC.Copy[681]=53
    CC.Copy[682]=54
    CC.Copy[683]=30
    CC.Copy[683]=55
    CC.Copy[684]=56
    CC.Copy[685]=58
    CC.Copy[686]=59
    CC.Copy[687]=63
    CC.Copy[688]=66
    CC.Copy[689]=72
    CC.Copy[690]=73
    CC.Copy[690]=611
    CC.Copy[691]=74
    CC.Copy[692]=75
    CC.Copy[693]=76
    CC.Copy[694]=77
    CC.Copy[695]=78
    CC.Copy[696]=79
    CC.Copy[697]=80
    CC.Copy[698]=81
    CC.Copy[699]=82
    CC.Copy[700]=83
    CC.Copy[701]=84
    CC.Copy[702]=85
    CC.Copy[703]=86
    CC.Copy[704]=87
    CC.Copy[705]=88
    CC.Copy[706]=89
    CC.Copy[707]=90
    CC.Copy[708]=91
    CC.Copy[709]=92
    CC.Copy[710]=151
    CC.Copy[711]=154
    CC.Copy[712]=502
    CC.Copy[712]=566
    CC.Copy[713]=569
    CC.Copy[714]=574
    CC.Copy[715]=589
    CC.Copy[716]=590
    CC.Copy[717]=601
    CC.Copy[718]=604
    CC.Copy[719]=4
	CC.Copy[720]=161
	CC.Copy[756]=587
	--CC.Copy[512]=0
	]]
end

function rest()
	--银两
	CC.Gold = 0
	CC.MJCZ = 0
	--天关残章奖励
	CC.Sp = 0
	--天关残章奖励判定是否触发，防止重复刷
	CC.Jl = 0
	--特效开启判定
	CC.TXM = {	'逆转乾坤',
				'迷踪步',
				'四神阵',
				'诛仙剑阵',
				'天关',	
				'杨过剑魔',
				'笑傲邪线',
				'胡苗战5',
				'龙门血案',
				--老顾1209
				'忘情天书',
				'花晓霜',
				'心魔',
				'达摩院',
				'般若堂',
				'少林初阶',
				'少林中阶',
				'少林高阶',
				'少林执事',
				'少林任务',
				'天刀九问',
				'袁紫衣',
				'苗若兰',
				'程灵素',
				'迷踪步',
				'林朝英奖励',
				'周伯通奖励',
				'王重阳奖励',
				'东方不败奖励',
				'风清扬奖励',
				'阿凡提奖励',
				'天剑开启',
				'西域奇商',
				'门派任务',
				'夜幕',
				'我方阵法',
				'敌方阵法',
				'武当太极',
				'太玄觉醒',
				'昆仑蟠桃',
				'马车',
				'飞',
				'雪',
				'连',
				'天',
				'射',
				'白',
				'鹿',
				'笑',
				'书',
				'神',
				'侠',
				'倚',
				'碧',
				'鸳',
				'谭公',
				'北冥神功',
				'小和尚历险记',
				'六脉神剑',
				'黑级浮屠',
				'扫地的考验',
				'一苇渡江',
				'易筋经',
				'慕容绝学',
				'不老长春',
				'初始天赋',
				'扫地奖励',
				'颜色',
				'传送',	
				'怀旧音乐',
				'战斗天气',
				'比武奖励',
				'战斗速度',
				'战斗显血',
				'备用6',
				'备用7',
				'备用8',
				'备用9',
				'备用10',
				'备用11',
				'备用12',
				'备用13',
				'备用14',
				'备用15',
				'备用16',
				'备用17',
				'备用18',
				'备用19',
				'备用20',
				'备用21',
				'备用22',
				'备用23',
				'备用24',
				'备用25',
				'备用26',
				'备用27',
				'备用28',
				'备用29',
				'备用30',
				'备用31',
				
											

} 

	--特效开启判定
	CC.TX = {   ['逆转乾坤'] = 0,
				['迷踪步'] = 0,
				['四神阵'] = 0,
				['诛仙剑阵'] = 0,
				['天关'] = 0,
				['杨过剑魔'] = 0,
				['笑傲邪线'] = 0,
				['胡苗战5'] = 0,
				['龙门血案'] = 0,
				--老顾1209
				['忘情天书'] = 0,
				['花晓霜'] = 0,
				['心魔'] = 0,
				['达摩院'] = 0,
				['般若堂'] = 0,
				['少林初阶'] = 0,
				['少林中阶'] = 0,
				['少林高阶'] = 0,
				['少林执事'] = 0,
				['少林任务'] = 0,
				['天刀九问'] = 0,
				['袁紫衣'] = 0,
				['苗若兰'] = 0,
				['程灵素'] = 0,
				['林朝英奖励'] = 0,
				['王重阳奖励'] = 0,
				['周伯通奖励'] = 0,
				['东方不败奖励'] = 0,
				['阿凡提奖励'] = 0,
				['风清扬奖励'] = 0,
				['天剑开启'] = 0,
				['西域奇商'] = 0,
				['门派任务'] = 0,
				['夜幕'] = 0,
				['我方阵法'] = 0,
				['敌方阵法'] = 0,
				['武当太极'] = 0,
				['太玄觉醒'] = 0,
				['昆仑蟠桃'] = 0,
				['马车'] = 0,
				['飞'] = 0,
				['雪'] = 0,
				['连'] = 0,
				['天'] = 0,
				['射'] = 0,
				['白'] = 0,
				['鹿'] = 0,
				['笑'] = 0,
				['书'] = 0,	
				['神'] = 0,
				['侠'] = 0,
				['倚'] = 0,
				['碧'] = 0,
				['鸳'] = 0,
				['谭公'] = 0,
				['北冥神功'] = 0,
				['小和尚历险记'] = 0,
				['六脉神剑'] = 0,
				['黑级浮屠'] = 0,			
				['扫地的考验'] = 0,
				['一苇渡江'] = 0,
				['易筋经'] = 0,
				['慕容绝学'] = 0,
				['不老长春'] = 0,
				['初始天赋'] = 0,
				['扫地奖励'] = 0,
				['颜色'] = 0,
				['传送'] = 0,
				['怀旧音乐'] = 0,	
				['战斗天气'] = 0,
				['比武奖励'] = 0,
				['战斗速度'] = 0,
				['战斗显血'] = 0,
				['备用6'] = 0,
				['备用7'] = 0,
				['备用8'] = 0,
				['备用9'] = 0,
				['备用10'] = 0,
				['备用11'] = 0,
				['备用12'] = 0,
				['备用13'] = 0,
				['备用14'] = 0,
				['备用15'] = 0,
				['备用16'] = 0,
				['备用17'] = 0,
				['备用18'] = 0,
				['备用19'] = 0,
				['备用20'] = 0,
				['备用21'] = 0,
				['备用22'] = 0,
				['备用23'] = 0,
				['备用24'] = 0,
				['备用25'] = 0,
				['备用26'] = 0,
				['备用27'] = 0,
				['备用28'] = 0,
				['备用29'] = 0,
				['备用30'] = 0,
				['备用31'] = 0,
												
				
} 

--天关
CC.TG = {}
	--CC.SB = {1,1,1,2,3,4,5,2,3}
	--天关奖励
    CC.TGJL = {}
    CC.JLWP = {}
	CC.JLWPNUM = {}
	CC.Shoping = 1
	CC.commodity = {
		{346,600,1,'可使用四大山战斗模型',0,},
		{348,2000,1,'可使用四大山战斗模型',0},
		{114,2000,1,'可使用四大山战斗模型',0},
		{86,2000,1,'可使用四大山战斗模型',0},
		{113,2000,1,'可使用四大山战斗模型',0},
		{136,2000,1,'可使用四大山战斗模型',0},
		{167,2000,1,'可使用四大山战斗模型',0},
	}
	CC.TGJLEW = {}

--地图
--江南地图表1地图编号，表2是x坐标，表3是y坐标
	CC.JNDT	=  {{157,570,20}, --嘉兴
				{154,689,38}, --苏州
				{133,782,58}, --杭州	 
				{95,673,85},  --金陵
				{101,508,118}, --江陵 
				{59,739,134},  --金龙帮		 												
				{153,840,207},	--扬州
				{70,750,220},	--小村			
			   	{56,739,284},   --福州
			   	{65,607,318},   --唐诗山洞
			  	{135,705,330},  --南少林
			   	{48,130,318},   --铁掌山
			   	{21,125,348},   --黑龙潭
				{45,10,438},    --程英居
			   	{47,88,391},    --一灯居
			   	{112,310,411},  --万兽山庄
				{163,470,351},  --藏剑山庄 				   			   
			   	{128,201,497},  --衡阳 
				{50,319,574},   --阎基居
			   	{94,356,485},	--长乐帮			   
			   	{158,580,517},	--佛山 
			   	{74,845,581},   --侠客岛
				} 

	--中原地图表1地图编号，表2是x坐标，表3是y坐标
	--地图名称显示位置
	CC.ZYDT ={	{31,150,16},
				{29,841,53},	
				{19,323,118},
				{18,223,125},
				{151,833,127},														
				{23,452,125},	
				{22,49,163},
				{53,452,175},
			   	{20,95,255},
			   	{24,833,234},
			   	{54,323,307},
			   	{127,703,339},
			   	{25,150,392},
			  	{152,86,415},--华山下
			   	{100,44,484},--天台山				   			   
			   	{51,497,392},
			   	{40,323,447},				   
			   	{103,249,508},	
			   	{27,420,508},
			   	{93,387,542},
			   	{43,86,590},
			   	{160,498,577},
			   	{129,150,642},			   			   
				} 	
				
	--西部地图表1地图编号，表2是x坐标，表3是y坐标
	--地图名称显示位置
	CC.XBDT   ={{105,291,46},
				{8,888,65},
				{34,900,193},--崆峒
				{68,47,161},
				{4,47,195},
				{66,50,223},--冲宵洞														
				{11,217,181},	
				{92,140,249},
				{60,479,195},
			   	{17,704,179},
			   	{120,385,249},
			   	{35,443,354},
			   	{159,385,424},
			   	{99,498,456},
			   	{39,620,423},				   			   
			   	{41,583,480},
			   	{124,630,512},				   
			   	{36,857,384},	
			   	{33,834,536},
			   	{156,684,650},
			   	{96,888,620},
			   	{37,888,650},	
			   	{166,550,311},	--血刀门
			   	{30,400,322},	--白驼山
			   	{167,420,280},	--大轮寺	   			   			   
				} 
				
	--北部地图表1地图编号，表2是x坐标，表3是y坐标
	--地图名称显示位置
	CC.BBDT={	{9,45,443},
				{62,184,339},
				{12,173,501},
				{10,248,564},														
				{87,345,548},	
				{136,237,663},
				{107,467,339},
			   	{7,467,423},
			   	{90,658,122},
			   	{6,667,245},
			   	{121,748,339},			   
			   	{3,653,381},
			   	{26,630,548},				   			   
			   	{139,677,621},
			   	{2,892,24},				   
			   	{125,892,289},				   			   			   
				}	
				
	--海外地图表1地图编号，表2是x坐标，表3是y坐标
	--地图名称显示位置
	CC.HWDT ={ 	{73,116,82},	
				{72,339,48},
				{71,47,277},			
				{97,202,229},														
				{78,410,163},	
				{75,295,435},
				{98,339,582},
			   	{76,269,687},
			   	{77,639,570},
			   	{79,890,407},   			   			   
				} 
--物品特效	
WPTX2 = {}
	WPTX2[0] = "回复最大生命值15%"
	WPTX2[1] = "回复最大生命值30%"
	WPTX2[2] = "回复最大生命值50%"	
	WPTX2[3] = "时序恢复8点内力，持续200时序"
	WPTX2[7] = "回复最大生命值30%"
	WPTX2[8] = "回复最大生命值50%,增加【天王护命】状态100时序。"
	WPTX2[9] = "时序恢复1点中毒，持续50时序"
	WPTX2[10] = "时序恢复1点中毒，持续50时序"
	WPTX2[11] = "提升战场抗毒100点，持续至战斗结束"
	WPTX2[22] = "解除冰封50点并时序恢复1点冰封，持续50时序"
	WPTX2[23] = "解除灼烧20点并时序恢复1点灼烧，持续50时序"
	WPTX2[24] = "解除流血50点并时序恢复1点流血，持续100时序"
	WPTX2[25] = "清除所有基础异常"
	ZSTX = {}
	ZSTX[1] = {{1,'流血'},{2,'封穴'},{3,'灼烧'},{4,'冰封'},{5,'内伤'},{6,'中毒'}}
	ZSTX[2] = {{23,'加连击'},{24,'加暴击'},{25,'加暴伤'},{28,'回气'},{31,'加格档'},{32,'加命中'}}
	ZSTX[3] = {{9,'剧毒'},{12,'虚弱'},{22,'加速'},{27,'防御'},{33,'散功'},{34,'外伤'}}
	ZSTX[4] = {{13,'破防'},{14,'无视系数'},{15,'固定伤害'},{16,'吸血'},{17,'减防'},{18,'减攻'}}
	ZSTX[5] = {{7,'冻结'},{8,'点燃'},{19,'破气防'},{20,'范围伤害'},{26,'必中'},{29,'锁足'}}
	ZSTX[6] = {{11,'撕裂'},{21,'再次行动'},{30,'反击'},{10,'眩晕'},{35,'混乱'},{36,'恐惧'}}

--判定学功夫的NPC
CC.MPSF = {1,70,80,117,27,11,749,129,459,19,22,24,20,21,23,25,59,97,43,6,8,7,57,60,498,739,51,102,46,103,152}
CC.XKF = 0  --=1 学武功 =2game_sm控制
--门派武功分类
CC.MpKf = {}
	--0江湖 1少林 2武当 3逍遥 4日月 5明教 6天机 7全真 8丐帮 9华山 10嵩山 11青城 12衡山 13恒山 14泰山 15五毒 16古墓 17血刀 
	--18灵霄 19峨眉 20崆峒 21昆仑 22桃花 23白驼 24六扇门 25八卦 26慕容 27天龙寺 28星宿 29密宗 30藏剑
	CC.MpKf[1] = {1,20,22,24,57,82,86,91,92,96,108,122,124,128,132,133,135,136,137,140,144,173,186,189,194,196,208,233,243,267,346,347,368,369,384}
	CC.MpKf[2] = {7,16,36,46,56,64,84,99,149,171,195,197,205,209,227,236,241,244,245,246,381,383}
	CC.MpKf[3] = {8,14,85,98,101,117,123,134,147,168,183,185,201,202,325,329,385}
	CC.MpKf[4] = {48,71,72,73,88,105,219,226,309,310,311,312,313,321,358,386}
	CC.MpKf[5] = {4,5,55,58,59,93,97,141,153,174,217,335,337,340,348,349,365,387}
	CC.MpKf[6] = {10,29,161,176,179,180,188,190,193,225,234,240,331,353,362,363,367,375,377,379,425}
	CC.MpKf[7] = {15,39,100,115,203,210,223,283,284,285,286,388,420}
	CC.MpKf[8] = {2,26,70,80,116,165,187,204,215,228,229,247,248,257,264,389}
	CC.MpKf[9] = {34,47,89,90,146,162,175,212,302,303,304,305,306,307,308,339,374,378,390}
	CC.MpKf[10] = {33,213,216,272,273,274,275,373,391,392}
	CC.MpKf[11] = {27,178,322,323,327,328,336,354,380,424}
	CC.MpKf[12] = {32,239,249,250,251,277,366,372}
	CC.MpKf[13] = {30,255,258,364,370,404}
	CC.MpKf[14] = {31,260,261,263,361,371,421}
	CC.MpKf[15] = {3,40,220,278,279,280,281,282,332,333,360,422}
	CC.MpKf[16] = {6,25,42,45,79,139,148,154,211,238,298,299,300,301,423}
	CC.MpKf[17] = {51,52,63,163,214,343,344,345,393,394}
	CC.MpKf[18] = {35,61,252,395,396}
	CC.MpKf[19] = {41,218,242,254,287,288,289,290,291,292,342,397,398}
	CC.MpKf[20] = {23,60,118,399,400}
	CC.MpKf[21] = {37,152,166,276,356,376,401,402}
	CC.MpKf[22] = {12,18,38,126,129,172,237,316,317,318,319,320,326,403}
	CC.MpKf[23] = {9,69,74,81,95,104,127,150,405}
	CC.MpKf[24] = {293,324,330,406,407}
	CC.MpKf[25] = {230,231,235,269,408,409}
	CC.MpKf[26] = {19,43,138,192,265,266,271,410,411}
	CC.MpKf[27] = {17,49,121,130,142,207,253,259,314,315,355,412,413}
	CC.MpKf[28] = {87,120,131,170,294,295,296,297,334,414,415}
	CC.MpKf[29] = {21,54,65,66,78,83,103,158,159,169,270,341,350,357,416,417,426,427}
	CC.MpKf[30] = {68,155,177,199,200,222,351,418,419}
	CC.MpKf[0] = {11,13,28,44,50,53,62,67,75,76,77,94,102,106,107,109,110,111,112,113,114,119,125,143,145,151,156,157,160,164,167,181,182,184,191,198,206,221,224,232,256,262,268,338,352,359,382}
	
	
CC.MpRw = {}
--门派人物
	CC.MpRw[1] = {18,70,94,114,149,169,170,313,400,401,402,403,404,405,406,407,408,409,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,509,516,573,576,577,597,598,599,638,653,655,656,657,668,678}
	CC.MpRw[2] = {5,80,82,92,95,96,153,320,321,322,323,324,325,326,327,328,329,503,517,532,533,534,535,536,537,538,569,570,589,652,697,699,709,715}
	CC.MpRw[3] = {45,115,116,117,118,524,574,634,662,663,664,665,666,667,675,714}
	CC.MpRw[4] = {26,27,28,31,32,33,34,73,88,89,231,232,233,234,235,236,237,238,239,240,510,611,690,705,706}
	CC.MpRw[5] = {9,10,11,12,13,14,15,16,17,66,173,174,175,301,302,303,304,305,306,307,308,309,310,641,646,688}
	CC.MpRw[6] = {30,74,171,172,311,312,522,635,691,749,750,751,754,755}
	CC.MpRw[7] = {49,64,68,123,124,125,126,127,128,129,291,292,293,294,295,296,297,298,299,300,501,566,596,650}
	CC.MpRw[8] = {48,50,55,69,271,272,273,274,275,276,277,278,279,280,458,459,519,539,643,677}
	CC.MpRw[9] = {19,35,36,54,79,107,108,109,140,141,142,183,184,185,186,187,188,360,361,362,363,364,365,366,367,368,369,525,629,649,670,671,682,696}
	CC.MpRw[10] = {22,191,192,193,194,195,196,197,198,199}
	CC.MpRw[11] = {24,211,212,213,214,215,216,217,218,219,220}
	CC.MpRw[12] = {20,370,371,372,373,374,375,376,377,378,379}
	CC.MpRw[13] = {21,380,381,382,383,384,385,386,387,388,389,583}
	CC.MpRw[14] = {23,201,202,203,204,205,206,207,208,209,210}
	CC.MpRw[15] = {25,83,176,221,222,223,224,225,226,227,228,229,230,639,700}
	CC.MpRw[16] = {58,59,161,580,605,640,685,686,738}
	CC.MpRw[17] = {97,518,595,727,728,729,730,753}
	CC.MpRw[18] = {43,241,242,243,244,245,246,247,248,249,250}
	CC.MpRw[19] = {6,330,331,332,333,334,335,336,337,338,339,585,587,626,631,632,756}
	CC.MpRw[20] = {8,167,168,350,351,352,353,354,355,356,357,358,359}
	CC.MpRw[21] = {7,166,340,341,342,343,344,345,346,347,348,349,586}
	CC.MpRw[22] = {56,57,63,78,588,684,687,695}
	CC.MpRw[23] = {60,61}
	CC.MpRw[24] = {441,442,443,444,445,446,447,448,449,450,498,602,720,732,733,734,735,736}
	CC.MpRw[25] = {106,722,723,737,739,740,741}
	CC.MpRw[26] = {51,76,104,105,113,679,693}
	CC.MpRw[27] = {53,65,81,90,98,101,102,119,120,121,122,165,499,520,540,541,542,543,544,681,698,707}
	CC.MpRw[28] = {46,47,261,262,263,264,265,266,267,268,269,270,521,676}
	CC.MpRw[29] = {62,84,103,160,251,252,253,254,255,256,257,258,259,260,523,603,644,645,647,648,701}
	CC.MpRw[30] = {152,500,504,565,752}
	CC.MpRw[0] = {0,1,2,3,4,29,37,38,39,40,41,42,44,52,67,71,72,75,77,85,86,87,91,93,99,100,110,111,112,130,131,132,133,134,135,136,137,138,139,143,144,145,146,147,148,150,151,154,155,156,157,158,159,162,163,164,177,178,179,180,181,182,189,190,200,281,282,283,284,285,286,287,288,289,290,314,315,316,317,318,319,390,391,392,393,394,395,396,397,398,399,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,451,452,453,454,455,456,457,460,502,505,506,507,508,511,512,513,514,515,526,527,528,529,530,531,545,546,547,548,549,550,551,552,553,554,555,556,557,558,559,560,561,562,563,564,567,568,571,572,575,578,579,581,582,584,590,591,592,593,594,600,601,604,606,607,608,609,610,612,613,614,615,616,617,618,619,620,621,622,623,624,625,627,628,630,633,636,637,642,651,654,658,659,660,661,669,672,673,674,680,683,689,692,694,702,703,704,708,710,711,712,713,716,717,718,719,721,724,725,726,731,742,743,744,745,746,747,748,757}

	CC.ZCNUM = 0
	CC.Save = 0
	CC.NGTX = {}
	--                            11~14时序回血   15~19回合回血    21~24时序回内    25~29回合回内   31~34时序回体      35~39回合回体   41~45时序回气  45~49回合回气     
	--  51~54回春      54~59调息      61~64聚神      65~69气归        71~74奋怒        75~79活血       81~84包扎       85~89复苏      91~94阳春      95~99冰穴
	--101~104冰心      105~109冰敷    111~114祛毒    115~119化毒      121~124疗伤      125~129通脉     131~134痊愈     135~139化冰    141~144奋起    145~149移穴   
	--151~154不侵      155~159不侵    161~164净化    165~169勇猛      171~174连击      175~179连伤     181~184暴击     185~189暴伤    191~194大力    195~199健体			
    --201~204轻身      205~209气攻    211~214气防    215~219愤怒      221~224川流      225~229神行     231~234先发     235~239迅捷    241~244拳罡    245~249指劲   
	--251~254剑气      255~259刀风    261~264器械    265~269拳掌精通  271~274指法精通   275~279剑法精通 281~284刀法精通 285~289奇门精通 291~294破体   295~299破甲
	--301~304神力      305~309金汤    311~314矫健    315~319凤雏      321~324卧龙       325~329洛神    331~334防暴     335~339火抗     341~344冰控   345~349闭穴
	--351~354血抗      355~359毒抗    361~364蓄气    
	--401~404免疫反伤  405~409免疫流血 411~414免疫中毒 415~419免疫内伤 421~424免疫冰封  425~429免疫灼烧  431~434免疫虚弱 435~439免疫锁足 441~444免疫暴击 445~449免疫必中
	--451~454免疫破绽  455~459免疫散功 461~464天地独尊 465~469免疫破防 471~474免疫缴械  475~479逆水寒    481~484霸体     485~489免疫冰结 491~494免疫点燃 


	--1001浑天    1002普渡     1003慈航   1004北冥    1005化功   1006吸星    1007狮子吼   1008易趋易步   1009重生   1010挪移   1011无相  1012纯阳  1013一气  1014独尊  1015侠客行  1016逆转  1017              
	--CC.NGTX[48] = {}


--防坑指南
CC.NewGame_fkwz = {
	'一，金书群侠1.07新手防坑指南',
	'  1.新增门派角色和全武功招式独立系统，所有外功都有各自的招式和特效，招式需要通过使用进行领悟，只能获得1级的武功，武功升级需要战斗（空挥有效）和使用修炼点进行升级，修炼点在每场战斗后获得',    
    '  2.初玩新手请到各大门派的守门小兵（不减道德）打磨武功。',    
    '  3.可以刷修炼点的地方，前期丐帮的小打狗阵（可败），后期全真，少林，武当有阵法挑战（会死）',
     
    '  4.关于天关天赋，每周目打完20大后进入上方的天关进行挑战，战胜后可以随机获得天赋，该天赋可以在下周目开局时选择，每个新周目只能使用上周目刷出来的天赋。',
	'  5.天关前7层可以存档，8层打完达摩之后，进入无尽天关模式，每层的敌人随机出现，不能存档，战斗失败直接结束游戏，',
   	'  6.取消了内功的被动效果和部分的内外功的组合效果，还有很多新系统，一切以游戏内为准，',
   	'  7.只要不在天关的北丑处点“结束游戏”，残章就不会消耗，直接重新开档即可。',
	'  8.奇穴升级所需武学点的获得：实战杀敌5000+称号挑战及天书奖励2500+杀心魔每个100点。',
	'  9.关于心魔，武功到极时会在战斗中随机出现心魔，打败心魔该武功才能到极。',
	'  10.外功可以空挥但打人比较快，内功轻功需要主运后挨打。',
	'  11.心魔的强度非常高，打不过的建议直接关闭，实战满了以后，心魔就不会再出现。',
	'  12.击败心魔还是有丰厚的奖励（100武学点，10000修炼点)',
	'  13.心魔可以在小村的搜刮少女那里关闭，关了以后不会出现心魔（再次打开需要花费20000两）',
	'  14，由于105的马车改革和拆迁问题，很多剧情点已经变换了位置，这里标注部分剧情点的,',
	'  15.云岭洞的冰蚕，冰火岛的红蛙，无量山的绿蛙集齐3个后,对小村的药炉使用打死丁春秋获得的神木王鼎（剧情物品），可以练出一个地灵丹（可遗忘一个武功）',
	'  16.每一条经脉打通后有额外属性加成：',
	'	手少阴经、手少阳经、足少阴经、足少阳经各+50攻',
	'	手太阴经、手太阳经、足太阴经、足太阳经各+50防',
	'	手厥阴经、手阳明经、足厥阴经、足阳明经各+50轻',
	'	任脉、督脉各+50攻+50防+50轻',
	'二.剧情相关转移：',
	'  笑傲：开局剧情在福州客栈>福州的抚慰镖局>衡阳>华山， 正线分支后去衡阳找莫大触发剧情，梅庄在杭州 ,',
	'  射雕：开局蒙古包收郭靖>北京找黄蓉，牛家村在江南地区的嘉兴,',
	'  神雕：16年剧情在江陵的客栈触发,',
	'  天龙：燕子坞在苏州,',
	'  连城：天宁寺在江陵,',
	'  碧血：温青青在大理，大功坊在金陵,',
	'  倚天：蝴蝶谷在凤阳，龙门血案：武当对话宋远桥—杭州龙门镖局（要打秃驴）—武当宋远桥，获得武当9阳，道德+2,',
	'  飞雪双线在沧洲触发,',
	'  其他，激活灵鳌岛坐标需要拿到鸡山图找扬州船边的npc激活,',

	'三，关于千年灵芝的数量',
	'  1.射雕桃花岛招亲打赢郭靖 ,',
	'  2.倚天剧情明教密道100时序打赢成昆,', 
	'  3.开局，明霞岛的宝箱有一个（搜刮前去拿）,',
	'  4.鸳鸯岛宝箱 ,',
	'  5.鹿鼎山宝箱.',
	'  6.天龙正邪双线的少林大战后都有专属剧情可以拿到一个（下边有介绍）,',
	'  7.河洛商店有两个（2W一个）,',
	'  8.畅想角色福利，畅想的第一个武功如果是内功，可以直接攻击,',
	'  9.面板武功的上限是15个，满了之后不能一脉相承,',

	'四，开局流程应为为明霞岛宝箱>搜刮>拜师>迷之宝箱，家里的箱子开了之后前边的一切都会卡住,',
	'  1.介绍信的用途：',
	'  2.目前畅想可以送信给到',
	'  3.拜师丘处机给金雁功',
	'  4.拜师余沧海给摧心掌',
	'  5.拜师玄慈给阿难破戒刀（105）/降魔刀法（106）',
	'  6.云岭洞喵姐处可以学迷踪步',
	'  7.介绍信可拜师福利8选1（少林玄慈的燃木刀法必要打开村里的初始宝箱之后才能获得）',

	'五，关于游戏全程的额外兵器值',
	'  1.达到神话称号（即打赢一个神话级的敌人），全系+30（包括之前的称号叠加）',
	'  2.倚天剧情完结后可以在光明顶进行挑战，胜利后全系+10（正邪不限）',
	'  3.天龙正线剧情完结后挑战扫地，胜利后全系+10。邪线剧情完结后直接获得',
	'  4.射雕一灯居对对子，任选单系+10',
	'  5.射雕邪，剧情初期挑战洪七，胜利后任选单系+10',
	'  6.倚天正，剧情初期在龙门客栈挑战灭绝，胜利后任选单系+10',
	'  7.华山论剑时选择挑战张三丰，胜利获得三围+30和兵器值全系+20',

	'六，一些剧情问题',
	'  天龙邪线的虚竹去向问题，在燕子坞选择天龙邪线的时候虚竹会直接离队，',
	'  有两个方法，可在剧情点卡住虚竹：',
	'  第一种方法.擂鼓山对话苏星河后直接离开，不要进屋，直接离开。',
	'  第二种方法.打完丁春秋，对话苏星河后，前往恒山山麓群P一场，这时候虚竹会出现在凉州皇宫。',
	'  如果要走天龙邪线，这两个方法选其一就可以卡住虚竹，拿了斗转再回来加虚竹即可',

	'  射雕邪线，牛家村剧情后梅超风就会出现在云岭洞，打完一灯居之后会消失。',

	'  无量山第一次接触段誉时，钟灵必须在队，否则无法触发凌波微步的挑战。',

	'  天龙寺鸠摩智战的胜利奖励改成了火焰刀（灵芝取消），邪线少林大战后主角面板有火刀，觉醒奥义。',
	'  天龙正线主线主线剧情完成后可以去燕子坞打boss 形态的慕容复，胜利后萧峰阿朱加入',

	'  天龙邪线，由于新增了慕容复的觉醒剧情，所以少林大战之前不能提前拿一苇渡江和易筋经，',
	'  否则会触发不到后续的慕容复觉醒和天龙寺剧情',

	'  沧州的两次苗人凤单挑其实不用打赢，拖够200时序也算胜利',

	'  天刀九问，药王庙挖坟后去晋阳的后山',
	}
end

--物品出处
--CC.WPCC = {}
	--CC.WPCC[0] = {'',}


	