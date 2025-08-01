local Menu = {}
Menu.__index = Menu

function Menu:new(options)
    local obj = setmetatable({
        options = options or {},
        page = 1,
        selectedRow = 1,
        selectedCol = 1,
        rowsPerPage = 15,
        colsPerRow = 5
    }, self)
    return obj
end

function Menu:draw()
    local startIdx = (self.page - 1) * self.rowsPerPage * self.colsPerRow + 1
    local totalOptions = #self.options
    local totalPages = math.ceil(totalOptions / (self.rowsPerPage * self.colsPerRow))
    
    print("\n=== 菜单（第 " .. self.page .. "/" .. totalPages .. " 页）===")
    
    for row = 1, self.rowsPerPage do
        local line = ""
        for col = 1, self.colsPerRow do
            local idx = startIdx + (row - 1) * self.colsPerRow + (col - 1)
            local option = self.options[idx] or ""
            local isSelected = (row == self.selectedRow and col == self.selectedCol)
            local prefix = isSelected and "?" or " "
            line = line .. string.format("%s %-10s", prefix, option)
        end
        print(line)
    end
    
    print("\n操作：↑↓←→ 移动，PageUp/PageDown 翻页，Enter 选择，Q 退出")
end

function Menu:update(dir)
    local maxCol = self.colsPerRow
    local maxRow = self.rowsPerPage
    local maxPage = math.ceil(#self.options / (self.rowsPerPage * self.colsPerRow))
    
    if dir == "up" then
        self.selectedRow = math.max(1, self.selectedRow - 1)
    elseif dir == "down" then
        self.selectedRow = math.min(maxRow, self.selectedRow + 1)
    elseif dir == "left" then
        if self.selectedCol == 1 then
            if self.page > 1 then
                self.page = self.page - 1
                self.selectedCol = maxCol
            end
        else
            self.selectedCol = self.selectedCol - 1
        end
    elseif dir == "right" then
        if self.selectedCol == maxCol then
            if self.page < maxPage then
                self.page = self.page + 1
                self.selectedCol = 1
            end
        else
            self.selectedCol = self.selectedCol + 1
        end
    elseif dir == "pageup" then
        self.page = math.max(1, self.page - 1)
    elseif dir == "pagedown" then
        self.page = math.min(maxPage, self.page + 1)
    end
end

function Menu:getSelectedOption()
    local idx = (self.page - 1) * self.rowsPerPage * self.colsPerRow + 
                (self.selectedRow - 1) * self.colsPerRow + 
                self.selectedCol
    return self.options[idx]
end

-- 使用示例
local options = {}
for i = 1, 100 do
    table.insert(options, "选项" .. i)
end

local menu = Menu:new(options)
local running = true

while running do
    menu:draw()
    local input = io.read()
    
    if input == "q" then
        running = false
    elseif input == "up" then
        menu:update("up")
    elseif input == "down" then
        menu:update("down")
    elseif input == "left" then
        menu:update("left")
    elseif input == "right" then
        menu:update("right")
    elseif input == "pageup" then
        menu:update("pageup")
    elseif input == "pagedown" then
        menu:update("pagedown")
    elseif input == "enter" then
        local selected = menu:getSelectedOption()
        if selected then
            print("\n已选择：" .. selected)
            running = false
        end
    end
end