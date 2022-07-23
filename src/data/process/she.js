export default {
  name: '射雕英雄传',
  normal: [
    {
      map: '蒙古包（北部）',
      event: [
        {
          list: ['与郭靖对话，可收郭靖入队'],
          reward: ['郭靖[队友] 加入'],
        },
      ],
    },
    {
      map: '北京（北部）',
      event: [
        {
          list: ['郭靖在队时，与客栈门口的黄蓉对话，触发剧情，正邪分支'],
          reward: [],
        },
      ],
    },
  ],
  good: [
    {
      map: '北京（北部）',
      event: [
        {
          list: [
            '郭靖在队时，与客栈门口的黄蓉对话，触发剧情，选『是』',
            '进入正线，触发战斗：',
            'VS欧阳克',
            '胜后，郭靖离队，获得【兰花拂穴手】',
          ],
          reward: ['道德+2', '兰花拂穴手[指法秘籍]'],
        },
      ],
    },
    {
      map: '洪七公居（中原）',
      event: [
        {
          list: ['进入场景触发剧情'],
          reward: [],
        },
      ],
    },
    {
      map: '桃花岛（海外）',
      event: [
        {
          list: [
            '进入场景触发剧情，欧阳克、郭靖与主角比试：',
            '1、VS 欧阳克（可败）',
            '2、VS 郭靖（可败）',
            '剧情后，众人离开，获得【落英神剑掌】【旋风扫叶腿】【灵鳖步】',
            '*剧情后记得去看下左上房间墙壁上的对联',
          ],
          reward: ['神雕侠侣绝情谷剧情开启', '千年灵芝[丹药] 胜郭靖奖励', '落英神剑掌[拳掌秘籍]', '旋风扫叶腿[指法秘籍]'],
        },
      ],
    },
    {
      map: '明霞岛（海外）',
      event: [
        {
          list: ['进入场景，剧情后触发战斗：', 'VS 欧阳锋'],
          reward: ['道德+1'],
        },
      ],
    },
    {
      map: '嘉兴-牛家村（江南）',
      event: [
        {
          list: [
            '剧情后触发战斗：',
            '1、VS 欧阳克',
            '2、VS 欧阳锋（可败）胜利后获得【蛤蟆功】',
            '3、VS 欧阳锋（可败）胜利后获得天山雪莲*2',
            '4、VS 欧阳锋',
            '战斗结束剧情后获得【弹指神通】',
          ],
          reward: [
            '道德+4',
            '张旭率意帖[剧情道具]剧情后开宝箱获得',
            '蛤蟆功法[内功秘籍]',
            '天山雪莲[丹药]*2',
            '弹指神通[指法秘籍]',
            '程英：',
            '第二格武功洗弹指神通1级',
            '第三格武功洗落英神剑掌1级',
          ],
        },
      ],
    },
    {
      map: '铁掌峰（江南）',
      event: [
        {
          list: ['剧情后触发战斗：', 'VS 裘千仞+铁掌帮众*10'],
          reward: ['道德+1'],
        },
      ],
    },
    {
      map: '一灯居（江南）',
      event: [
        {
          list: ['渔：给他[金娃娃](开局搜刮)可通过，道德+1', '如果没有[金娃娃]，可以选择与其交手杀过去，道德-1'],
          reward: [],
        },
        {
          list: ['耕：西部农村选择教过小孩武功后可通过，道德+1', '若没教过武功则需要杀过去，道德-1'],
          reward: [],
        },
        {
          list: ['樵，道德≥75，攻击≥100直接通过，道德+1', '道德<75可选择与其交手杀过去，道德-1'],
          reward: [],
        },
        {
          list: [
            '读，桃花岛看过对联，可以通过，道德+1',
            '奖励主角：拳指剑刀特五系兵器值可选其中一项+10',
            '没看过对联可选择与其交手杀过去，道德-1',
          ],
          reward: ['五系兵器值任选其一+10点'],
        },
        {
          list: ['进入房间，剧情后触发战斗：', 'VS 欧阳锋+裘千仞', '胜后，一灯送主角【先天功秘籍】【一阳指法】'],
          reward: ['道德+8', '先天功秘籍[内功秘籍]', '一阳指法[指法秘籍]'],
        },
      ],
    },
    {
      map: '桃花岛（海外）',
      event: [
        {
          list: ['道德≥80，与郭靖、黄蓉对话，回小村后可收郭靖、黄蓉入队', '*可选择郭靖内力属性'],
          reward: ['道德+1', '汗血宝马[坐骑]', '软猬甲[防具]收黄蓉获得', '郭靖[队友]加入', '黄蓉[队友]加入'],
        },
      ],
    },
    {
      map: '洪七公居（中原）',
      event: [
        {
          list: ['与洪七公对话，得知天书在重阳宫'],
          reward: [],
        },
      ],
    },
    {
      map: '重阳宫（中原）',
      event: [
        {
          list: ['与丘处机对话，触发剧情，欧阳锋出现：', 'VS 欧阳锋+裘千仞+蛇群', '获得【瞬息千里】', '战斗胜利后，王重阳出现吓跑欧阳锋'],
          reward: ['道德+8', '瞬息千里[轻功秘籍]'],
        },
        {
          list: ['与王重阳对话，选『是』：', '主角VS王重阳（可败，可重复挑战）', '胜后获得《射雕英雄传》'],
          reward: ['射雕英雄传[十四天书之一]'],
        },
        {
          list: ['道德≥90时与丘处机对话，王重阳送【先天功秘籍】', '道德≥99时与丘处机对话，王重阳送[九阴真经上卷]【蛇行狸翻】'],
          reward: ['先天功秘籍[内功秘籍]', '九阴真经上卷[剧情道具]', '蛇行狸翻[轻功秘籍]'],
        },
      ],
    },
    {
      map: '一灯居（江南）',
      event: [
        {
          list: ['与读对话猜谜，若程英在队伍，再次与其对话即可解谜', '获得【妙笔丹青】'],
          reward: ['妙笔丹青[奇门秘籍] '],
        },
      ],
    },
    {
      map: '华山下-华山后山（中原）',
      event: [
        {
          list: [
            '拿到《射雕英雄传》后，华山后山旁的阶梯上去，一直往右，走过石碑，进入华山绝顶，触发剧情进入战斗：',
            'VS 洪七公+欧阳锋',
            '战后出现分支：',
            '选择帮北丐则 VS 欧阳锋，胜利后得[打狗棒]、【打狗棒法】',
            '选择帮西毒则 VS 洪七公，胜利后得[西毒蛇杖]、【灵蛇杖法】',
          ],
          reward: ['道德+2', '帮助北丐：', '打狗棒[武器]', '打狗棒法[奇门秘籍]', '帮助西毒：', '西毒蛇杖[武器]', '灵蛇杖法[奇门秘籍]'],
        },
      ],
    },
  ],
  evil: [
    {
      map: '北京（北部）',
      event: [
        {
          list: ['郭靖在队时，与客栈门口的黄蓉对话，触发剧情，选『否』获得【透骨打穴】，进入邪线'],
          reward: ['道德-2', '透骨打穴[指法秘籍]'],
        },
      ],
    },
    {
      map: '洪七公居（中原）',
      event: [
        {
          list: ['进入场景触发战斗：', 'VS 洪七公（可败）'],
          reward: ['胜洪七公奖励', '五系兵器值任选其一+10点', '瞬息千里[轻功秘籍]'],
        },
      ],
    },
    {
      map: '桃花岛（海外）',
      event: [
        {
          list: [
            '进入场景触发剧情，欧阳克、郭靖与主角比试：',
            '1、VS 欧阳克（可败）',
            '2、VS 郭靖（可败）',
            '剧情后，众人离开，获得【落英神剑掌】、【旋风扫叶腿】',
            '*剧情后记得去看下左上房间墙壁上的对联',
          ],
          reward: ['神雕侠侣绝情谷剧情开启', '千年灵芝[丹药] 胜郭靖奖励', '落英神剑掌[拳掌秘籍]', '旋风扫叶腿[指法秘籍]'],
        },
      ],
    },
    {
      map: '明霞岛（海外）',
      event: [
        {
          list: ['对话欧阳锋，剧情后，获得【白驼雪山掌】【蛤蟆功】'],
          reward: ['道德-1', '白驼雪山掌[拳掌秘籍]', '蛤蟆功[内功秘籍]'],
        },
      ],
    },
    {
      map: '嘉兴-牛家村（江南）',
      event: [
        {
          list: ['剧情后触发战斗：', 'VS 欧阳克'],
          reward: ['道德-3', '张旭率意帖[剧情道具]剧情后开宝箱获得'],
        },
      ],
    },
    {
      map: '云岭洞（中原）',
      event: [
        {
          list: ['与梅超风对话，选『是』收其入队', '*此支线在剧情进行到牛家村开启，一灯居后关闭'],
          reward: [],
        },
      ],
    },
    {
      map: '蒙古包（北部）',
      event: [
        {
          list: ['与柯镇恶对话，选择 『是』 与其交手', 'VS 江南七怪 ', '胜后获得 [汗血宝马]【九阴白骨爪】'],
          reward: ['道德-5', '汗血宝马[坐骑]', '九阴白骨爪[指法秘籍]'],
        },
      ],
    },
    {
      map: '铁掌峰（江南）',
      event: [
        {
          list: ['VS 看门喽啰', '进屋与裘千仞对话，获得【铁掌掌谱】'],
          reward: ['铁掌掌谱[拳掌秘籍]'],
        },
      ],
    },
    {
      map: '一灯居（江南）',
      event: [
        {
          list: ['渔：给他[金娃娃](开局搜刮)可通过，道德+1', '如果没有[金娃娃]，可以选择与其交手杀过去，道德-1'],
          reward: [],
        },
        {
          list: ['耕：西部农村选择教过小孩武功后可通过，道德+1', '若没教过武功则需要杀过去，道德-1'],
          reward: [],
        },
        {
          list: ['樵，道德≥75，攻击≥100直接通过，道德+1', '道德<75可选择与其交手杀过去，道德-1'],
          reward: [],
        },
        {
          list: [
            '读，桃花岛看过对联，可以通过，道德+1',
            '奖励主角：拳指剑刀特五系兵器值可选其中一项+10',
            '没看过对联可选择与其交手杀过去，道德-1',
          ],
          reward: ['五系兵器值任选其一+10点'],
        },
        {
          list: ['进入房间，剧情后触发战斗：', 'VS 一灯+渔樵耕读', '胜后，获得[软猬甲]【一阳指法】'],
          reward: ['道德-10', '一阳指法[指法秘籍]', '妙笔丹青[奇门秘籍]（朱子柳身上偷取）', '软猬甲[防具]'],
        },
      ],
    },
    {
      map: '重阳宫（中原）',
      event: [
        {
          list: [
            '与丘处机洪七公等人对话，触发战斗：',
            '1、VS 全真七子+全真教徒',
            '2、VS 周伯通+全真七子+全真教徒',
            '3、VS 周伯通+东邪+北丐+全真七子+全真教徒',
            '第4战前出现是否化干戈为玉帛选项',
          ],
          reward: ['道德-3'],
        },
        {
          list: ['化干戈为玉帛：', '4、VS 王重阳+林朝英', '胜后获得《射雕英雄传》[九阴真经上卷]'],
          reward: ['道德+3', '《射雕英雄传》十四天书之一', '九阴真经上卷[剧情道具]'],
        },
        {
          list: [
            '不化干戈为玉帛：',
            '4、VS 王重阳+林朝英+周伯通+东邪+北丐+全真七子+全真教徒',
            '胜后获得《射雕英雄传》[九阴真经上卷][蛇行狸翻]',
          ],
          reward: ['《射雕英雄传》十四天书之一', '九阴真经上卷[剧情道具]', '蛇行狸翻[轻功秘籍]'],
        },
      ],
    },
    {
      map: '嘉兴-牛家村（江南）',
      event: [
        {
          list: ['一灯居战斗过后，与欧阳锋对话，选『是』获得【逆运真经】'],
          reward: ['道德-1', '逆运真经[内功秘籍]'],
        },
      ],
    },
    {
      map: '华山下-华山后山（中原）',
      event: [
        {
          list: [
            '拿到《射雕英雄传》后，华山后山旁的阶梯上去，一直往右，走过石碑，进入华山绝顶，触发剧情进入战斗：',
            'VS 洪七公+欧阳锋',
            '战后出现分支：',
            '选择帮北丐则 VS 欧阳锋，胜利后得[打狗棒]、【打狗棒法】',
            '选择帮西毒则 VS 洪七公，胜利后得[西毒蛇杖]、【灵蛇杖法】',
          ],
          reward: ['道德+2', '帮助北丐：', '打狗棒[武器]', '打狗棒法[奇门秘籍]', '帮助西毒：', '西毒蛇杖[武器]', '灵蛇杖法[奇门秘籍]'],
        },
      ],
    },
  ],
};