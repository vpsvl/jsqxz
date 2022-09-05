export default {
  name: '神雕侠侣',
  list: [
    {
      name: '杨过',
      talent: [
        {
          name: '西狂',
          effect: [
            '使用玄铁剑法时，有几率发动【重剑真传】',
            '攻击时附带“西狂之怒啸”，敌方全体集气倒退100点',
            '战斗中，当小龙女被击退时，杨过立即出手并发动【西狂之震怒.雷霆狂啸】，黯然极意几率提升',
          ],
        },
        {
          name: '剑魔再临',
          effect: ['玄铁剑法攻击时50%概率发动两种特效之一：天极剑渊：破防30%，破尽天下：无视气防，气攻+800'],
        },
        {
          name: '逆流勇进',
          effect: ['生命值低于50%时暴击率两倍，生命值低于25%时暴击率3倍', '当生命值50%时，生命值每再降低1%，下回合集气值+10点'],
        },
      ],
      fortune: [
        '独孤剑冢拿玄铁剑法时，洗第一格武功，解锁剑魔再临',
        '重阳宫大战后洗第三格武功洗玉女心经，可选择是否将天赋内功洗为玉女心经',
        '百花谷战在周伯通后，第二格武功洗黯然销魂掌',
        '射雕邪线牛家村支线剧情，可选择洗第三格武功和天赋内功洗为逆运经脉',
        '华山绝顶西毒北丐支线，可选择洗第五格武功',
      ],
    },
    {
      name: '小龙女',
      talent: [
        {
          name: '冰心玉骨',
          effect: ['左右互搏发动几率70%', '使用玉女素心剑法高几率连击'],
        },
      ],
      fortune: ['神雕正小龙女重新入队后玉女剑法洗玉女素心剑'],
    },
    {
      name: '程英',
      talent: [
        {
          name: '青箫落瑛',
          effect: ['使用玉箫剑法攻击，可杀敌内力300点'],
        },
        {
          name: '外和内刚',
          effect: ['生命值低于50%时，攻击效果提升20%'],
        },
      ],
      fortune: ['射雕正线牛家村剧情后，洗第二三格武功'],
    },
    {
      name: '郭襄',
      talent: [
        {
          name: '碧海潮生',
          effect: ['攻击时发动碧海潮生曲,第一击100%概率杀全体敌人内力500，连击时发动概率40%'],
        },
        {
          name: '小东邪',
          effect: ['特色指令【玲珑】：可自由切换第一格武功为弹指神通/玉萧剑法/落英神剑掌，不消耗回合', '峨眉金顶觉醒后，内力变为天罡'],
        },
        {
          name: '井月八法',
          effect: ['每个刀法到极领悟一招，每一招加暴击伤害/暴击概率/加气攻(上限8个)'],
        },
      ],
      fortune: [],
    },
    {
      name: '金轮法王',
      talent: [
        {
          name: '般若无相',
          effect: ['蓄力状态下被攻击，集气+100'],
        },
        {
          name: '元蒙帝师',
          effect: ['任何攻击追加2000点气攻'],
        },
        {
          name: '十龙十象',
          effect: ['行动前几率触发十龙十象，并使下一次的攻击附加昏迷效果'],
        },
      ],
      fortune: ['神雕重阳宫大战领悟龙象般若功', '神正最终战领悟十龙十象'],
    },
    {
      name: '霍都',
      talent: [
        {
          name: '小王爷',
          effect: ['每个武功到极，减少受到的5%伤害和杀气（上限25%）'],
        },
        {
          name: '扑朔迷离',
          effect: ['与主角同时在场时，主角集气速度+2', '战斗开始后的前三次攻击不受伤害（需主角7书觉醒后）'],
        },
      ],
      fortune: [],
    },
    {
      name: '人厨子',
      talent: [
        {
          name: '食神',
          effect: ['攻击不消耗体力'],
        },
      ],
      fortune: [],
    },
    {
      name: '陆无双',
      talent: [
        {
          name: '银弧刀',
          effect: ['攻击必造成流血"', '暴击率+30', '程英居击败李莫愁后免疫中毒'],
        },
      ],
      fortune: [
        '蝴蝴谷帮胡青牛治好腿伤轻功+50',
        '获得玉女剑法第2格洗玉女剑法1级',
        '获得玉女心经第3格洗玉女心经1级，天内洗玉女心经',
        '获得天罗地网第5格洗天罗地网1级，天轻洗天罗地网',
      ],
    },
    {
      name: '李莫愁',
      talent: [
        {
          name: '赤练仙子',
          effect: ['使用五毒神掌时，有70%几率变为赤练神掌，追加70点伤害，并强制上毒20点，引爆目标身上的毒素'],
        },
        {
          name: '情为何物',
          effect: ['每隔50时序，随机向敌人发射3枚冰魄银针'],
        },
      ],
      fortune: ['神雕邪线古墓密道剧情后，洗第二三格武功，天赋内功洗为玉女心经'],
    },
    {
      name: '公孙止',
      talent: [
        {
          name: '绝情谷主',
          effect: ['本方每阵亡一名队友，集气速度增加2点', '受到的封穴降低50%'],
        },
        {
          name: '刀剑双绝',
          effect: ['耍刀技巧的50%加成到御剑能力', '御剑能力的50%加成到耍刀技巧', '刀法与剑法武功威力+200'],
        },
      ],
      fortune: [],
    },
    {
      name: '裘千尺',
      talent: [
        {
          name: '铁掌莲花',
          effect: ['使用枣核钉攻击必定造成内伤', '使用铁掌攻击几率追加一枚枣核钉'],
        },
      ],
      fortune: [],
    },
    {
      name: '达尔巴',
      talent: [
        {
          name: '蒙古力士',
          effect: ['特色指令【死战】：锁定一名敌人，至其死亡之前，达尔巴对其的攻击效果提高50%，且必定命中，在目标死亡之前无法更换目标'],
        },
      ],
      fortune: [],
    },
    {
      name: '潇湘子',
      talent: [
        {
          name: '湘西尸王',
          effect: ['战场上每一个死亡的成员都将恢复尸王200点气血'],
        },
      ],
      fortune: [],
    },
    {
      name: '尹克西',
      talent: [
        {
          name: '波斯大贾',
          effect: ['为畅想主角时开局获得一万银两', '行动时几率金钱镖对随机敌人造成伤害'],
        },
      ],
      fortune: [],
    },
    {
      name: '尼摩星',
      talent: [
        {
          name: '瑜伽鬼王',
          effect: ['必定单击，伤害永久提高1.5倍（天赋外功与如雷的额外连击有效）'],
        },
      ],
      fortune: [],
    },
    {
      name: '独孤求败',
      talent: [
        {
          name: '九剑真传',
          effect: [
            '独孤九剑攻击时50%概率发动四种特效',
            '荡剑式：集气+200',
            '撩剑式：伤害+30%',
            '倒剑式：强制杀气150',
            '离剑式：伤害不随距离递减',
            '被攻击时发动破X式：减少受到伤害20%，攻击下回合集气位置-200',
          ],
        },
        {
          name: '剑魔再临',
          effect: ['剑法攻击时50%概率发动两种特效之一：天极剑渊：破防50%，破尽天下：无视气防，气攻+800'],
        },
        {
          name: '料敌机先',
          effect: ['先手反击必中', '进入战斗的初始集气位置为1000，自身移动步数锁定为10格，免疫暗器'],
        },
        {
          name: '无我无剑',
          effect: ['被攻击前先手反击，独孤求败先手反击后几率打断对方攻击'],
        },
      ],
      fortune: [],
    },
    {
      name: '神雕',
      talent: [
        {
          name: '雕兄',
          effect: ['使用玄铁剑法时，有几率发动【重剑真传】'],
        },
        {
          name: '大鹏展翅',
          effect: ['移动格数+3', '使用玄铁剑法时，攻击范围变为可移动'],
        },
      ],
      fortune: [],
    },
    {
      name: '蒙哥',
      talent: [
        {
          name: '漠北天狼',
          effect: ['我方轻功+10%，命中+10%'],
        },
        {
          name: '天子观气',
          effect: ['敌方全体集气减半，命中减少20%'],
        },
      ],
      fortune: [],
    },
  ],
};