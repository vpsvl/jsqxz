export default {
  name: '神雕侠侣',
  normal: [
    {
      map: '古墓（中原）',
      event: [
        {
          list: ['与小龙女对话，选『是』小龙女加入'],
          reward: ['金丝手套[武器]', '古墓心法[内功秘籍]', '小龙女[队友] 加入'],
        },
      ],
    },
    {
      map: '程英居（江南）',
      event: [
        {
          list: ['小龙女在队，进入场景触发战斗：', 'VS 李莫愁', '胜利后获得 【银索金铃】'],
          reward: ['银索金铃[奇门秘籍]'],
        },
        {
          list: ['与程英对话，小龙女离开队伍，程英入队，获得【玉箫剑法】'],
          reward: ['玉箫剑法[剑法秘籍]', '程英[队友] 加入'],
        },
        {
          list: ['与冯铁匠对话，可收其去小村', '在小村可以向冯铁匠购买一些装备或强化装备'],
          reward: [],
        },
      ],
    },
    {
      map: '绝情谷（中原）射雕桃花岛剧情后开启',
      event: [
        {
          list: ['进入大厅触发剧情，剧情后，主角被关起来', '调查房间里的兵器架，获得[君子剑]、[淑女剑]', '调查房间大门，触发剧情'],
          reward: ['君子剑[武器]', '淑女剑[武器]'],
        },
        {
          list: ['剧情后进入大厅，触发战斗：', 'VS公孙止+绝情谷众', '胜后获得【阴阳倒乱刃】'],
          reward: ['阴阳倒乱刃[奇门秘籍]'],
        },
      ],
    },
    {
      map: '蜘蛛洞（北部）',
      event: [
        {
          list: [
            '打几场蜘蛛，进入最里面触发剧情， 剧情后获得：',
            '【玉女剑法】【玉女心经】【空明拳谱】【左右互搏术】',
            '蜘蛛洞宝箱可用6000两银两打开，可提升主角五系1点和三围1点',
          ],
          reward: ['道德+2', '玉女剑法[剑法秘籍]', '玉女心经[内功秘籍]', '空明拳谱[拳掌秘籍]', '左右互搏术[特技]'],
        },
      ],
    },
    {
      map: '独孤剑冢（北部）',
      event: [
        {
          list: ['进入山洞，触发战斗：', 'VS 大蛇', '拔起神雕旁边的剑获得【玄铁剑】', '阅读神雕旁边的墙壁获得【玄铁剑法】'],
          reward: ['道德+2', '玄铁剑[武器]', '玄铁剑法[剑法秘籍]'],
        },
      ],
    },
    {
      map: '重阳宫（中原）',
      event: [
        {
          list: ['剧情后触发正邪分支'],
          reward: [],
        },
      ],
    },
  ],
  good: [
    {
      map: '重阳宫（中原）',
      event: [
        {
          list: ['剧情后选择『否』，触发战斗：', 'VS 金轮法王+霍都+达尔巴+西域三魔'],
          reward: ['道德+5'],
        },
      ],
    },
    {
      map: '古墓（中原）',
      event: [
        {
          list: ['对话杨龙夫妇'],
          reward: [],
        },
      ],
    },
    {
      map: '绝情谷（中原）',
      event: [
        {
          list: ['程英在队时，进入大厅剧情后触发战斗：', '1、VS 裘千尺+绝情谷众', '2、VS 公孙止', '剧情后小龙女定下十六年之约，杨过离去'],
          reward: ['道德+5'],
        },
        {
          list: ['调查后面花园里的断肠草，获得[断肠草]'],
          reward: ['断肠草[剧情道具]'],
        },
      ],
    },
    {
      map: '独孤剑冢（北部）',
      event: [
        {
          list: ['对杨过使用[断肠草]，剧情后获得[瘦黄马]'],
          reward: ['道德+2', '瘦黄马[坐骑]'],
        },
      ],
    },
    {
      map: '江陵（江南）',
      event: [
        {
          list: ['进入客栈触发剧情，剧情后郭襄随队行动', '*开启万兽山庄'],
          reward: [],
        },
      ],
    },
    {
      map: '黑龙潭（江南）',
      event: [
        {
          list: ['与杨过对话，杨过入队', '进屋与瑛姑对话，答应帮其找周伯通'],
          reward: ['杨过[队友] 加入'],
        },
      ],
    },
    {
      map: '百花谷（中原）',
      event: [
        {
          list: ['与周伯通对话，触发战斗：', '杨过 VS 周伯通', '胜后杨过送【黯然销魂掌】【大伏魔拳】'],
          reward: ['道德+3', '黯然销魂掌[拳掌秘籍]', '大伏魔拳[拳掌秘籍]'],
        },
      ],
    },
    {
      map: '黑龙潭（江南）',
      event: [
        {
          list: ['对话老顽童，触发剧情'],
          reward: [],
        },
      ],
    },
    {
      map: '百花谷（中原）',
      event: [
        {
          list: ['对话周伯通，获得【左右互搏之术】，如之前学有左右互搏则触发概率永久增加20%', '对话瑛姑，主角轻功+20'],
          reward: ['左右互搏之术[杂学秘籍]'],
        },
      ],
    },
    {
      map: '绝情谷（中原）',
      event: [
        {
          list: ['杨过在队，右上断崖触发剧情，前往绝情谷底'],
          reward: [],
        },
        {
          list: ['来到谷底触发剧情，杨过、小龙女入队'],
          reward: ['玉女心经[内功秘籍]', '天罗地网[轻功秘籍]', '杨过[队友]加入', '小龙女[队友]加入'],
        },
        {
          list: ['从断崖上来，触发剧情'],
          reward: [],
        },
      ],
    },
    {
      map: '襄阳（中原）',
      event: [
        {
          list: [
            '进入襄阳城外，触发剧情进入战斗：',
            '杨过 VS 金轮法王',
            '胜后获得《神雕侠侣》【龙象般若功】【玉女素心剑】 青驴[坐骑]',
          ],
          reward: ['道德+5', '神雕侠侣[十四天书之一]', '玉女素心剑[剑法秘籍]', '龙象般若功[内功秘籍]', '青驴[坐骑]'],
        },
      ],
    },
  ],
  evil: [
    {
      map: '重阳宫（中原）',
      event: [
        {
          list: ['剧情后选择『是』，触发战斗：', 'VS 全真七子+全真教徒', '战斗结束后，获得【无上大力杵】【龙象般若功】'],
          reward: ['道德-10', '无上大力杵[奇门秘籍]', '龙象般若功[内功秘籍]'],
        },
      ],
    },
    {
      map: '绝情谷（中原）',
      event: [
        {
          list: ['进入绝情谷，触发剧情进入战斗：', 'VS 公孙止', '胜后获得[金刀黑剑]，李莫愁入队', ''],
          reward: ['李莫愁[队友] 加入', '金刀黑剑[武器]'],
        },
        {
          list: ['进入大厅触发剧情战斗：', 'VS 杨过+小龙女'],
          reward: ['道德-5'],
        },
        {
          list: ['剧情后来到右上角调查石碑触发剧情'],
          reward: [],
        },
      ],
    },
    {
      map: '古墓（中原）',
      event: [
        {
          list: ['左下方房间，对话第二个棺材，选择『是』进入密道'],
          reward: [],
        },
        {
          list: ['进入左上石屋触发剧情，获得【金雁功】'],
          reward: ['金雁功[轻功秘籍]', '李莫愁奖励：', '第二格武功洗玉女心经1级', '第三格武功洗九阴神功1级', '天赋内功洗为玉女心经'],
        },
      ],
    },
    {
      map: '江陵（江南）',
      event: [
        {
          list: ['进入客栈，触发剧情', '剧情后金轮法王出现，带走郭襄', '*开启万兽山庄'],
          reward: [],
        },
      ],
    },
    {
      map: '黑龙潭（江南）',
      event: [
        {
          list: ['进屋与瑛姑对话，答应帮其找周伯通'],
          reward: [],
        },
      ],
    },
    {
      map: '百花谷（中原）',
      event: [
        {
          list: ['与周伯通对话'],
          reward: ['道德+3'],
        },
      ],
    },
    {
      map: '黑龙潭（江南）',
      event: [
        {
          list: ['对话老顽童，触发剧情'],
          reward: [],
        },
      ],
    },
    {
      map: '百花谷（中原）',
      event: [
        {
          list: ['对话周伯通，获得【左右互搏之术】，如之前学有左右互搏则触发概率永久增加20%', '对话瑛姑，主角轻功+20'],
          reward: ['左右互搏之术[特技]'],
        },
      ],
    },
    {
      map: '绝情谷（中原） ',
      event: [
        {
          list: ['李莫愁在队时，右上断崖触发剧情，进入战斗：', 'VS 周伯通+黄药师+一灯', '胜后获得【五轮大转】'],
          reward: ['五轮大转[奇门秘籍]'],
        },
        {
          list: ['进入绝情谷底触发剧情', '剧情后，郭襄进队'],
          reward: ['郭襄[队友] 加入', '瑜伽密乘[内功秘籍]'],
        },
      ],
    },
    {
      map: '襄阳（中原）',
      event: [
        {
          list: ['由襄阳进入襄阳城外，触发剧情进入战斗：', 'VS 蒙哥+一群蒙古兵', '胜后获得[飞云骓]《神雕侠侣》【天魔策】'],
          reward: ['道德+5', '飞云骓[坐骑]', '天魔策[内功秘籍]', '神雕侠侣[十四天书之一]'],
        },
      ],
    },
    {
      map: '峨眉派-峨眉金顶（西部）',
      event: [
        {
          list: ['绝情谷底剧情完结，郭襄在队，可触发郭襄觉醒剧情'],
          reward: ['郭襄奖励', '攻、防、轻+30', '五系兵器值+10', '领悟称号【峨眉祖师】'],
        },
      ],
    },
  ],
};
