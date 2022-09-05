export default {
  name: '拳掌',
  exclusive: '',
  list: [
    {
      name: '罗汉拳',
      cheat: '',
      get: '开局宝箱获得',
      power: 250,
      gasPower: 0,
      range: '米 3格',
      condition: '拳掌20',
      addition: '攻击+1 拳掌+2',
      level: '1',
      internal: '',
      sect: '',
      peculiar: [
        {
          name: '伏虎罗汉拳',
          condition: '易筋神功+罗汉拳',
          effect: ['使用罗汉拳60%几率伤害提高50点'],
        },
        {
          name: '一脉相承',
          condition: '',
          effect: ['可洗为大力金刚掌'],
        },
      ],
    },
    {
      name: '美女拳法',
      cheat: '',
      get: '开局搜刮获得',
      power: 300,
      gasPower: 700,
      range: '■ 4+7×7',
      condition: '拳掌20',
      addition: '攻击+1 轻功+1 拳掌+2',
      level: '1',
      internal: '',
      sect: '',
      peculiar: [],
    },
    {
      name: '混元掌',
      cheat: '',
      get: '碧正救温青青获得',
      power: 750,
      gasPower: 800,
      range: '■ 10+5×5',
      condition: '拳掌30',
      addition: '攻击+1 轻功+1 拳掌+3',
      internal: '',
      level: '3',
      sect: '',
      peculiar: [
        {
          name: '混元一气',
          condition: '混元掌+混元功',
          effect: ['攻击时追加5~15点内伤和5~15时序集气混乱'],
        },
      ],
    },
    {
      name: '五毒神掌',
      cheat: '五毒秘传',
      get: '收祖千秋后获得',
      power: 350,
      gasPower: 700,
      range: '米 4格',
      condition: '拳掌30',
      addition: '攻击+1 拳掌+2 带毒+1',
      internal: '0',
      level: '1',
      sect: '',
      peculiar: [
        {
          name: '毒布武林',
          condition: '同时修炼五毒神掌+五毒神功+千蛛万毒手+连环腐尸毒+冰蚕毒掌',
          effect: ['五毒神掌/五毒神功/千蛛万毒手/连环腐尸毒/冰蚕毒掌威力提升500', '行动前对全场敌人用毒，并几率叠加负面状态'],
        },
      ],
    },
    {
      name: '绵掌',
      cheat: '',
      get: '倚天邪收宋青书获得',
      power: 400,
      gasPower: 700,
      range: '米 4格',
      condition: '拳掌35',
      addition: '攻击+1 防御+1 拳掌+2',
      level: '1',
      internal: '',
      sect: '',
      peculiar: [],
    },
    {
      name: '千蛛万毒手',
      level: '2',
      get: '倚天正收殷离获得',
      power: 600,
      gasPower: 700,
      range: '米 4格',
      condition: '拳掌40 指法20 用毒40',
      internal: '0',
      addition: '轻功+1 指法+2 用毒+1',
      sect: '',
      peculiar: [
        {
          name: '毒布武林',
          condition: '同时修炼五毒神掌+五毒神功+千蛛万毒手+连环腐尸毒+冰蚕毒掌',
          effect: ['五毒神掌/五毒神功/千蛛万毒手/连环腐尸毒/冰蚕毒掌威力提升500', '行动前对全场敌人用毒，并几率叠加负面状态'],
        },
      ],
    },
    {
      name: '摧心掌',
      cheat: '',
      get: '对余沧海使用介绍信获得',
      power: 600,
      gasPower: 600,
      range: '米 4格',
      condition: '拳掌40',
      addition: '攻击+2 拳掌+2 带毒+4',
      level: '3',
      internal: '0',
      sect: '',
      peculiar: [
        {
          effect: ['学会九阴神功后威力翻倍'],
        },
      ],
    },
    {
      name: '灵蛇拳',
      cheat: '白驼雪山掌',
      get: '射雕邪线明霞岛获得',
      power: 900,
      gasPower: 800,
      range: '米 4格',
      condition: '拳掌40',
      addition: '攻击+1 拳掌+3 带毒+1',
      level: '2',
      internal: '0',
      sect: '',
      peculiar: [
        {
          name: '紫气天罗',
          condition: '同时修炼灵蛇拳+寒冰绵掌+玄冥神掌+化骨绵掌到极',
          effect: [
            '灵蛇拳/寒冰绵掌/化骨绵掌/玄冥神掌威力提升300点',
            '攻击随机附加1~3层“冰冻状态”，每层减缓1%集气速度，上限50层',
            '被攻击时冻结敌人5时序',
          ],
        },
      ],
    },
    {
      name: '百花错拳',
      cheat: '',
      get: '书剑六和塔胜后获得',
      power: 600,
      gasPower: 800,
      range: '■ 5+7×7',
      condition: '拳掌50',
      addition: '攻击+1 拳掌+2',
      level: '2',
      internal: '',
      sect: '',
      peculiar: [],
    },
    {
      name: '七伤拳',
      cheat: '',
      get: '倚天正万安寺解救崆峒派后获得，邪昆仑之战',
      power: 1077,
      gasPower: 1000,
      range: '■ 5+5×5',
      condition: '拳掌60',
      addition: '攻击+2 拳掌+4',
      level: '4',
      internal: '0',
      sect: '',
      peculiar: [
        {
          name: '一震七伤',
          condition: '使用七伤拳攻击，几率触发（暴怒必触发）',
          effect: ['无视敌方气防追加17点内伤', '内力<5000时每个目标都会反伤自己内伤+7'],
        },
      ],
    },
    {
      name: '大慈大悲手',
      cheat: '',
      get: '沧州商店出售',
      power: 800,
      gasPower: 800,
      range: '■ 3格',
      condition: '拳掌70',
      addition: '攻击+2 拳掌+3',
      level: '2',
      internal: '1',
      sect: '',
      peculiar: [
        {
          name: '慈悲为怀',
          condition: '慈悲刀法+大慈大悲手',
          effect: ['道德高于60时，如所受伤害大于120，减伤（道德-60）点'],
        },
      ],
    },
    {
      name: '五行六合拳',
      cheat: '',
      get: '扬州商店出售',
      power: 900,
      gasPower: 900,
      range: '米 4格',
      condition: '拳掌70',
      addition: '轻功+2 拳掌+3',
      level: '3',
      internal: '',
      sect: '',
      peculiar: [],
    },
    {
      name: '无极玄功拳',
      cheat: '',
      get: '书剑李沅芷线龙门客栈击败张召重后获得',
      power: 800,
      gasPower: 800,
      range: '米 4格',
      condition: '拳掌70',
      addition: '拳掌+3',
      level: '2',
      internal: '',
      sect: '',
      peculiar: [],
    },
    {
      name: '三花聚顶掌',
      cheat: '',
      get: '全真派宝箱，需战斗和减道德',
      power: 700,
      gasPower: 700,
      range: '米 6格',
      condition: '拳掌70',
      addition: '攻击+1 防御+1 拳掌+3',
      level: '2',
      internal: '',
      sect: '',
      peculiar: [
        {
          effect: ['必连击但不会暴击'],
        },
      ],
    },
    {
      name: '落英神剑掌',
      cheat: '',
      get: '射雕桃花岛剧情',
      power: 700,
      gasPower: 900,
      range: '十 5格',
      condition: '拳掌70',
      addition: '攻击+1 拳掌+3 御剑+1',
      level: '2',
      internal: '',
      sect: '',
      peculiar: [
        {
          name: '桃花绝技',
          condition: '同时修炼弹指神通+落英神剑掌+玉玉箫剑法到极',
          effect: [
            '三种武功威力均+200，有40%几率三连击，暴怒必出',
            '弹指神通：必暴击，气攻+1500',
            '落英神剑掌：攻击范围变为可移动，并根据敌方内力耗损量增加伤害',
            '玉箫剑法：攻击距离提升至8格，有60%几率冰封',
          ],
        },
      ],
    },
    {
      name: '寒冰绵掌',
      cheat: '',
      get: '倚天正龙门客栈收殷离',
      power: 700,
      gasPower: 700,
      range: '米 5格',
      condition: '拳掌70',
      addition: '攻击+1 拳掌+3 带毒+2',
      level: '3',
      internal: '0',
      sect: '',
      peculiar: [
        {
          name: '紫气天罗',
          condition: '同时修炼灵蛇拳+寒冰绵掌+玄冥神掌+化骨绵掌到极',
          effect: [
            '灵蛇拳/寒冰绵掌/化骨绵掌/玄冥神掌威力提升300点',
            '攻击随机附加1~3层“冰冻状态”，每层减缓1%集气速度，上限50层',
            '被攻击时冻结敌人5时序',
          ],
        },
      ],
    },
    {
      name: '空明拳',
      cheat: '',
      get: '蜘蛛山洞救周伯通',
      power: 900,
      gasPower: 1200,
      range: '米 4格',
      condition: '拳掌70',
      addition: '攻击+1 拳掌+3',
      level: '3',
      internal: '',
      sect: '',
      peculiar: [
        // {
        //   name: '太空卸劲',
        //   condition: '同时修炼太极拳+空明拳到极',
        //   effect: ['被攻击时35%几率减伤1/3，同时降低攻击方行动后的集气位置120'],
        // },
      ],
    },
    {
      name: '铁掌',
      cheat: '',
      get: '射雕邪线裘千仞给',
      power: 900,
      gasPower: 900,
      range: '米 5格',
      condition: '拳掌70',
      addition: '攻击+1 轻功+1 拳掌+3',
      level: '2',
      internal: '1',
      sect: '',
      peculiar: [
        {
          name: '强上内伤',
          condition: '使用铁掌攻击，几率触发',
          effect: ['无视对方气防追加12-15点内伤'],
        },
        {
          name: '铁甲',
          condition: '同时修炼铁掌+铁剑+铁布衫，主运铁布衫',
          effect: ['护甲提升20%，被攻击时20%几率抵挡生命最大值2%伤害'],
        },
      ],
    },
    {
      name: '太极拳',
      cheat: '',
      get: '道德≥65 对话张三丰获得',
      power: 1099,
      gasPower: 1000,
      range: '十 4格',
      condition: '拳掌80',
      addition: '攻击+1 拳掌+3',
      level: '4',
      internal: '',
      sect: '',
      peculiar: [
        {
          name: '借力打力',
          condition: '主运太极神功，根据太极神功蓄力值提升威力与气攻，使用太极拳攻击后恢复正常',
          effect: ['蓄力值300～600，攻击范围+2，蓄力', '蓄力值超过600，攻击范围变为可移动面攻，且必定连击', '威力和气攻最多可以提升1080点'],
        },
        {
          name: '开太极',
          condition: '主运太极神功，怒气值=100，太极蓄力值>=500，使用太极拳或太极剑法',
          effect: ['消耗自身10%体力，10%内力对九格范围目标造成大量伤害'],
        },
        {
          name: '太极奥义',
          condition: '同时修炼太极拳+太极剑法到极',
          effect: [
            '太极奥义：',
            '被攻击几率（资质/4+35%）触发，降低25%所受到的杀气',
            '真·太极奥义 四两拨千斤：',
            '触发太极奥义时有25%的几率，完全免疫杀气',
          ],
        },
        // {
        //   name: '太空卸劲',
        //   condition: '同时修炼太极拳+空明拳到极',
        //   effect: ['被攻击时35%几率减伤1/3，同时降低攻击方行动后的集气位置120'],
        // },
      ],
    },
    {
      name: '大力金刚掌',
      cheat: '',
      get: '南少林挑战天虹半血即可获得',
      power: 1000,
      gasPower: 1000,
      range: '米 5格',
      condition: '拳掌100',
      addition: '攻击+2 拳掌+4',
      level: '3',
      internal: '1',
      sect: '',
      peculiar: [
        {
          name: '一脉相承',
          condition: '',
          effect: ['可由罗汉拳一脉相承'],
        },
        {
          name: '达摩掌',
          condition: '易筋神功+大金刚掌',
          effect: ['使用大力金刚掌40%几率提高100点伤害'],
        },
        {
          name: '般若金刚',
          condition: '大力金刚掌+般若掌+龙象般若功',
          effect: ['破防目标30%', '金刚掌：必暴击', '般若掌：变为点攻，威力双倍', '十龙十象：主运龙象般若功，概率击晕目标'],
        },
      ],
    },
    {
      name: '天山六阳掌',
      cheat: '',
      get: '带虚竹去擂鼓山获得',
      power: 1000,
      gasPower: 900,
      range: '米 4格',
      condition: '拳掌100',
      addition: '攻击+2 拳掌+4',
      level: '4',
      internal: '',
      sect: '',
      peculiar: [],
    },
    {
      name: '玄冥神掌',
      cheat: '',
      get: '万安寺顶左边房间左边书架',
      power: 1400,
      gasPower: 1100,
      range: '米 5格',
      condition: '拳掌100',
      addition: '攻击+3 轻功+1 拳掌+5',
      level: '4',
      internal: '0',
      sect: '',
      peculiar: [
        {
          name: '玄冥极意',
          condition: '攻击时几率触发，暴怒必触发',
          effect: ['攻击无误伤', '攻击范围变为面攻，并且追加1500气攻'],
        },
        {
          name: '紫气天罗',
          condition: '同时修炼灵蛇拳+寒冰绵掌+玄冥神掌+化骨绵掌到极',
          effect: [
            '灵蛇拳/寒冰绵掌/化骨绵掌/玄冥神掌威力提升300点',
            '攻击随机附加1~3层“冰冻状态”，每层减缓1%集气速度，上限50层',
            '被攻击时冻结敌人5时序',
          ],
        },
      ],
    },
    {
      name: '化骨绵掌',
      cheat: '',
      get: '沧州客栈赢海大富后获得',
      power: 700,
      gasPower: 0,
      range: '米 5格',
      condition: '拳掌100',
      addition: '攻击+2 拳掌+4 带毒+2',
      level: '3',
      internal: '0',
      sect: '',
      peculiar: [
        {
          name: '紫气天罗',
          condition: '同时修炼灵蛇拳+寒冰绵掌+玄冥神掌+化骨绵掌到极',
          effect: [
            '灵蛇拳/寒冰绵掌/化骨绵掌/玄冥神掌威力提升300点',
            '攻击随机附加1~3层“冰冻状态”，每层减缓1%集气速度，上限50层',
            '被攻击时冻结敌人5时序',
          ],
        },
      ],
    },
    {
      name: '须弥山神掌',
      cheat: '',
      get: '少林寺木人巷胜十八木人',
      power: 1400,
      gasPower: 1200,
      range: '米 4格',
      condition: '拳掌100',
      addition: '攻击+2 拳掌+4 暗器+3',
      level: '4',
      internal: '',
      sect: '',
      peculiar: [
        {
          name: '如来神掌',
          condition: '攻击时几率触发',
          effect: ['对生命值低于50%的目标概率附加目标最大生命值8%的伤害', '对生命值低于10%的目标概率直接斩杀'],
        },
      ],
    },
    {
      name: '冰蚕毒掌',
      cheat: '',
      get: '1.云岭洞战胜游坦之 2.天龙邪丐帮战胜游坦之',
      power: 1100,
      gasPower: 1100,
      range: '米 4格',
      condition: '拳掌100',
      addition: '攻击+3 拳掌+4 带毒+1',
      internal: '0',
      level: '3',
      sect: '',
      peculiar: [
        {
          name: '毒布武林',
          condition: '同时修炼五毒神掌+五毒神功+千蛛万毒手+连环腐尸毒+冰蚕毒掌',
          effect: ['五毒神掌/五毒神功/千蛛万毒手/连环腐尸毒/冰蚕毒掌威力提升500', '行动前对全场敌人用毒，并几率叠加负面状态'],
        },
      ],
    },
    {
      name: '奔雷手',
      cheat: '',
      get: '书剑霍青桐线收文泰来获得',
      power: 1100,
      gasPower: 1100,
      range: '米 5格',
      condition: '拳掌120',
      addition: '攻击+3 拳掌+4',
      level: '3',
      internal: '1',
      sect: '',
      peculiar: [
        {
          name: '雷动九天',
          condition: '暴怒攻击',
          effect: ['暴怒攻击时，有50%几率击晕目标1回合'],
        },
      ],
    },
    {
      name: '白虹掌力',
      cheat: '',
      get: '',
      power: 1100,
      gasPower: 1300,
      range: '米 5格',
      condition: '拳掌120',
      addition: '攻击+2 轻功+1 拳掌+4',
      level: '3',
      internal: '',
      sect: '',
      peculiar: [],
    },
    {
      name: '大伏魔拳',
      cheat: '',
      get: '百花谷战老顽童后获得',
      power: 1100,
      gasPower: 1200,
      range: '米 4格',
      condition: '拳掌140',
      addition: '攻击+2 防御+2 拳掌+4',
      level: '3',
      internal: '',
      sect: '',
      peculiar: [
        {
          name: '天之道',
          condition: '攻击时几率触发',
          effect: ['附加生命最大值5%~10%的伤害', '主运九阴真经时效果翻倍'],
        },
      ],
    },
    {
      name: '般若掌',
      cheat: '',
      get: '挑战少林铜人巷战胜方证',
      power: 1300,
      gasPower: 1300,
      range: '米 4格',
      condition: '拳掌140',
      addition: '攻击+3 防御+1 拳掌+5',
      level: '4',
      internal: '1',
      sect: '',
      peculiar: [
        {
          name: '般若金刚',
          condition: '大力金刚掌+般若掌+龙象般若功',
          effect: ['破防目标30%', '金刚掌：必暴击', '般若掌：变为点攻，威力双倍', '十龙十象：主运龙象般若功，概率击晕目标'],
        },
      ],
    },
    {
      name: '黯然销魂掌',
      cheat: '',
      get: '神雕正线百花谷杨过击败周伯通后获得',
      power: 1500,
      gasPower: 1300,
      range: '米 5格',
      condition: '拳掌200',
      addition: '攻击+4 拳掌+5',
      level: '4',
      internal: '',
      sect: '',
      peculiar: [
        {
          name: '黯然极意',
          condition: '血量低于70%或者内伤大于30时，几率触发（血量越低，内伤越高，几率越高），满足条件时暴怒必定触发',
          effect: ['攻击范围变成面攻，无误伤，必破气防'],
        },
      ],
    },
    {
      name: '降龙十八掌',
      cheat: '',
      get: '天龙正少林五连后乔峰送',
      power: 1500,
      gasPower: 1500,
      range: '米 5格',
      condition: '拳掌200',
      addition: '攻击+5 拳掌+6',
      level: '4',
      internal: '1',
      sect: '',
      peculiar: [
        {
          name: '盖世无双',
          condition: '同时修炼降龙十八掌+打狗棒法到极',
          effect: ['被攻击时50%几率触发，完全免疫杀气和内伤', '*已经学有其中之一，则学习另一个的系数需求-40点'],
        },
        {
          name: '降龙极意',
          condition: '乔峰必定触发，主角、洪七公和郭靖40%几率触发',
          effect: ['攻击范围变成面攻，无误伤，气攻提升至2300'],
        },
        {
          name: '降龙三叠浪',
          condition: '乔峰有40%几率触发，暴怒必定触发',
          effect: ['降龙十八掌三连击'],
        },
      ],
    },
  ],
};
