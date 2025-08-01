--底层所需api

C_ESCDOWN = 1

function LoadFight(hid,flag)
	if flag == nil then flag = hid + 101 end
	if	existFile(string.format(CONFIG.DataPath .. "fight/fight%03d.zip", hid)) then
		lib.LoadPNGPath(string.format(CONFIG.DataPath .. "fight/fight%03d", hid), flag, -1, 100, "png");
	elseif	existFile(string.format(CC.FightPicFile[1], hid)) then
		lib.PicLoadFile(string.format(CC.FightPicFile[1], hid), string.format(CC.FightPicFile[2], hid), flag);
	end
end

function LoadFights(pid,flag)
	local hid = JY.Person[pid]["头像代号"]
	LoadFight(hid,4+flag)
	LoadFight(hid)
end

--适配新fight，重写SetWarMap
function SetWarMap(x, y, level, v)
	if x > 63 or x < 0 or y > 63 or y < 0 then
		return 
	end
	lib.SetWarMap(x, y, level, v)
	if level == 2 then
		local tt = v
		if v ~= -1 then
			tt = JY.Person[WAR.Person[v]["人物编号"]]["头像代号"]
		end
		lib.SetWarMap(x, y, 10, tt)
	end
end

function WarSetPerson()
  CleanWarMap(2, -1)
  CleanWarMap(5, -1)
  CleanWarMap(10, -1)
  WAR.TF = {}
  WAR.TF1 = {}
  for i = 0, WAR.PersonNum - 1 do
	savetf(i)
    if WAR.Person[i]["死亡"] == false then
      SetWarMap(WAR.Person[i]["坐标X"], WAR.Person[i]["坐标Y"], 2, i)
      SetWarMap(WAR.Person[i]["坐标X"], WAR.Person[i]["坐标Y"], 5, WAR.Person[i]["贴图"])
	  LoadFights(WAR.Person[i]["人物编号"],i)
    end
  end
end

function WarCalPersonPic(id)--适配新fight
  local pid = WAR.Person[id]["人物编号"]
  local fx = WAR.Person[id]["人方向"]
  local t = 0
  local n = 0
  for i = 1, 5 do
    if 0 < JY.Person[pid]["出招动画帧数" .. i] then
      t = JY.Person[pid]["出招动画帧数" .. i]
      break
    end
  end
  if fx == nil then fx = 1 end
  n = n + fx * t * 2
  return n
end

--C++和lua交互部分
function JOYESCDOWN()      --ESC按下，快速对话所需，需在
	C_ESCDOWN = 1
end

function JOYESCUP()      --ESC离开
	C_ESCDOWN = 0
end

function ChangeMouseMode()      --切换触控鼠标模式
	if CONFIG.MouseMode == 2 then
		MouseMode(0)
	elseif CONFIG.MouseMode == 0 then
		MouseMode(2)
	end
end

function MouseMode(flag)
	CONFIG.MouseMode = flag;
	lib.MouseMode(flag)
	if flag == 2 then
		ButtonMode()
	end
end

function ButtonMode(flag) --按钮样式随场景变化，需要在切换大地图、场景地图、战斗地图时添加lib.ButtonMode()进行进一步切换
	if CONFIG.MouseMode == 2 then
		if flag == nil then
			if JY.Status==GAME_SMAP then
				lib.ButtonMode(0)
			else
				lib.ButtonMode(1)
			end
		else
			lib.ButtonMode(flag)
		end
	end
end



function LoadSMAP()
	ButtonMode(0)
	if	existFile1(CONFIG.DataPath..'smap.zip') then
		lib.LoadPNGPath(CONFIG.DataPath..'smap', 94, -1, 100, "png");
	elseif	existFile1(CC.SMAPPicFile[1]) then
		lib.PicLoadFile(CC.SMAPPicFile[1], CC.SMAPPicFile[2], 94)	--子场景贴图，内存区域
	end
end

function LoadMMAP()
	ButtonMode(1)
	if	existFile1(CONFIG.DataPath..'mmap.zip') then
		lib.LoadPNGPath(CONFIG.DataPath..'mmap', 93, -1, 100, "png");
	elseif	existFile1(CC.MMAPPicFile[1]) then
		lib.PicLoadFile(CC.MMAPPicFile[1], CC.MMAPPicFile[2], 93)	--子场景贴图，内存区域
	end
end

function LoadWMAP()
	ButtonMode(2)
	if existFile1(CONFIG.DataPath..'wmap.zip') then
		lib.LoadPNGPath(CONFIG.DataPath..'wmap', 0, -1, 100, "png");
	elseif existFile1(CC.WMAPPicFile[1]) then
		lib.PicLoadFile(CC.WMAPPicFile[1], CC.WMAPPicFile[2], 0)	--子场景贴图，内存区域	
	end
	--lib.LoadPNGPath(CONFIG.DataPath..'eft', 3, -1, 100, "png");
end

function existFile(filename)
    local f = io.open(filename)
    if f == nil then
        return false
    end
    io.close(f)
    return true
end

function existFile1(filename) --使用SDL的API判定文件是否存在，可以判定手机私有目录的内容
	--local fname = utf8gbk(filename, true)
	local f = lib.ExistFile(filename)
	if f == 0 then
		return false
	end
	return true
end

function QZXS(s,color,size,boxcolor)
	if JY.Restart == 1 then
		return
	end
    lib.GetKey();
    Cls();
	if color == nil then
		color = C_GOLD
	end
	if size == nil then size = CC.DefaultFont end
	if boxcolor ~= nil then 
		DrawStrBox(-1,-1,s,color,size)
	else
		DrawStrBox(-1,-1,s,color,size,boxcolor)
	end
	ShowScreen();
	if not (JY.Status==GAME_SMAP and C_ESCDOWN == 1) then
		WaitKey();
	end
end

function InputNum(str, minNum, maxNum, isEsc, default)
	local size = CC.DefaultFont;
	local b_space = size+CC.RowPixel
	local x=(CC.ScreenW-size*9-2*CC.MenuBorderPixel)/2;
	local y=(CC.ScreenH-size*9-2*CC.MenuBorderPixel)/2;
	local w=size*9+2*CC.MenuBorderPixel;
	local h=(b_space+CC.RowPixel*2)*6;
	local functional_button = {{name="确认"},{name="最大"},{name="清空"},{name="删除"},{name=0},{name=1},{name=2},{name=3},{name=4},{name=5},{name=6},{name=7},{name=8},{name=9}};
	local starting_y = 5;
	local starting_x = 1;

	for i = 1, #functional_button do
		functional_button[i].x1 = CC.ScreenW/2+(b_space+CC.RowPixel*2)*starting_x-11
		functional_button[i].y1 = y+(b_space+CC.RowPixel*2)*starting_y
		if i <= 4 then
			functional_button[i].x2 = CC.ScreenW/2+(b_space+CC.RowPixel*2)*starting_x-11+b_space*2
			functional_button[i].y2 = y+(b_space+CC.RowPixel*2)*starting_y+b_space
		else
			functional_button[i].x2 = CC.ScreenW/2+(b_space+CC.RowPixel*2)*starting_x-11+b_space
			functional_button[i].y2 = y+(b_space+CC.RowPixel*2)*starting_y+b_space
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
	if default ~= nil then
		num = default;
	elseif minNum ~= nil then
		num = minNum;
	end
	
	local selected_content = 0
	
	DrawBox(x,y,x+w-1,y+h-1,C_WHITE);
	DrawString(x+CC.MenuBorderPixel*2,y+CC.MenuBorderPixel,str.." "..minNum.." - "..maxNum,C_WHITE,size);
  
	local sid = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH);
    JY.WalkTime = 0; --连按设置重置为初始状态
	while true do
		if JY.Restart == 1 then
			break
		end
		DrawShades(CC.ScreenW/2-b_space*3,y+b_space+CC.RowPixel*2,CC.ScreenW/2+b_space*3,y+b_space+CC.RowPixel*2+b_space)
		DrawString(CC.ScreenW/2,y+b_space+CC.RowPixel*2,string.format("%d",num),C_WHITE,size);
		
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
			DrawShades(functional_button[i].x1,functional_button[i].y1,functional_button[i].x2,functional_button[i].y2,shade_color)
			DrawString(functional_button[i].x1+x_indent,functional_button[i].y1+y_indent,functional_button[i].name,C_GOLD,size);
		end
		
		ShowScreen()
		local key, ktype, mx, my = lib.GetKey();
		if ktype < 2 then key = RepeatKey(key,20) end
		
		if (key == VK_ESCAPE or ktype == 4) and isEsc ~= nil then
			num = nil;
			break;
		elseif key >= 49 and key <= 57 then
			num = num * 10
			num = num + key - 48
			if num > maxNum then
				num = maxNum
			end
		elseif key == 48 then
			num = num * 10
			if num > maxNum then
				num = maxNum
			end
		elseif key == VK_S then
			num = minNum
		elseif key == VK_L then
			num = maxNum
		elseif key == VK_UP then
			num = limitX(num + 1,minNum,maxNum)
		elseif key == VK_DOWN then
			num = limitX(num - 1,minNum,maxNum)
		elseif key == VK_LEFT then
			num = limitX(num - 10,minNum,maxNum)
		elseif key == VK_RIGHT then
			num = limitX(num + 10,minNum,maxNum)			
		elseif key == VK_BACKSPACE then
			num = math.modf(num/10)
		elseif key == VK_RETURN then
			if num >= minNum and num <= maxNum then
				break;
			end
		elseif ktype == 2 or ktype == 3 then
			selected_content = 0
			if mx >= x and mx <= x + w-1 and my >= y and my <= y + h-1 then
				for k = 1, #functional_button do 
					if mx >= functional_button[k].x1 and mx <= functional_button[k].x2 and my >= functional_button[k].y1 and my <= functional_button[k].y2 then
						selected_content = k;
						break;
					end
				end
			end
			if ktype == 3 then
				if selected_content == 1 then
					if num >= minNum and num <= maxNum then
						break;
					end
				elseif selected_content == 2 then
					num = maxNum
				elseif selected_content == 3 then
					num = 0
				elseif selected_content == 4 then
					num = math.modf(num/10)
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
		lib.LoadSur(sid,0,0)
	end
	lib.FreeSur(sid);
	JY.WalkTime = 0; --连按设置重置为初始状态
	return num;
end

function RepeatKey(key,delay,flag)
	
	local firstdelay = 500
	local repeatkey = false
	
	if JY.WalkTime == 0 then
		CC.WalkTime = socket.gettime() * 1000 + firstdelay 
		CC.RepeatKey = false
	else
		JY.WalkTime = socket.gettime() * 1000
	end
	
	if CC.RepeatKey and delay then
		lib.Delay(delay)
	elseif flag == 1 then
		lib.Delay(CC.Frame)
	end
	local RepeatState = {}
	for i = VK_RIGHT,VK_UP do --没表格存储按键状态，减少与C++底层的交互
		RepeatState[i] = lib.GetKeyState(i)
	end 
	
	--先检测跟上次不同的方向是否被按下
	if (JY.WalkTime == 0 or JY.WalkTime < CC.WalkTime) and firstdelay ~= 0 then
		if key==VK_UP then
			JY.WalkTime = 0
		elseif key==VK_DOWN then
			JY.WalkTime = 0
		elseif key==VK_LEFT then
			JY.WalkTime = 0
		elseif key==VK_RIGHT then
			JY.WalkTime = 0
		elseif RepeatState[VK_UP] ==0 and RepeatState[VK_DOWN] ==0 and RepeatState[VK_LEFT] ==0 and RepeatState[VK_RIGHT] ==0 then
			JY.WalkTime = 0
		elseif JY.WalkTime < CC.WalkSkip then
			JY.WalkTime = 1
		end
	else

		for i = VK_RIGHT,VK_UP do
			if i ~= CC.PrevKeypress and RepeatState[i] ~=0 then
				key = i
				repeatkey = true
			end
		end 
		--如果与上次不同的方向未被按下，则检测与上次相同的方向是否被按下
		if key==-1 and RepeatState[CC.PrevKeypress] and RepeatState[CC.PrevKeypress] ~=0 then
			key = CC.PrevKeypress
			repeatkey = true
		elseif repeatkey == false then
			for i = VK_RIGHT,VK_UP do
				if RepeatState[i] ~=0 then
					key = i
					repeatkey = true
					break
				end
			end
		end
		CC.PrevKeypress = key
		
		if repeatkey == false then
			JY.WalkTime = 0
		end
	end
	if repeatkey then CC.RepeatKey = true end
	return key
end