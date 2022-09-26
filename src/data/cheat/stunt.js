export default {
  name: '秘技',
  list: [
    {
      name: '绝处逢生',
      condition: '海叟钓法+银锁金玲',
      effect: ['被攻击15%概率不受伤害'],
    },
    {
      name: '毒布武林',
      condition: '同时修炼五毒神掌+五毒神功+千蛛万毒手+连环腐尸毒+冰蚕毒掌',
      effect: ['五毒神掌/五毒神功/千蛛万毒手/连环腐尸毒/冰蚕毒掌威力提升500', '行动前对全场敌人用毒，并概率叠加负面状态'],
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
    {
      name: '慈悲为怀',
      condition: '慈悲刀法+大慈大悲手',
      effect: ['道德高于60时，如所受伤害大于120，减伤（道德-60）点'],
    },
    {
      name: '桃花绝技',
      condition: '同时修炼弹指神通+落英神剑掌+玉玉箫剑法到极',
      effect: [
        '三种武功威力均+200，有40%概率三连击，暴怒必出',
        '弹指神通：必暴击，气攻+1500',
        '落英神剑掌：攻击范围变为可移动，并根据敌方内力耗损量增加伤害',
        '玉箫剑法：攻击距离提升至8格，有60%概率冰封',
      ],
    },

    {
      name: '铁甲',
      condition: '同时修炼铁掌+铁剑+铁布衫，主运铁布衫',
      effect: ['护甲提升20%，被攻击时20%概率抵挡生命最大值2%伤害'],
    },
    {
      name: '太极奥义',
      condition: '同时修炼太极拳+太极剑法到极',
      effect: [
        '太极奥义：',
        '被攻击概率（资质/4+35%）触发，降低25%所受到的杀气',
        '真·太极奥义 四两拨千斤：',
        '触发太极奥义时有25%的概率，完全免疫杀气',
      ],
    },
    {
      name: '盖世无双',
      condition: '同时修炼降龙十八掌+打狗棒法到极',
      effect: ['被攻击时50%概率触发，完全免疫杀气和内伤', '*已经学有其中之一，则学习另一个的系数需求-40点'],
    },
    {
      name: '除却四相',
      condition: '同时修炼多罗叶指+大智无定指+无相劫指+拈花指到极',
      effect: [
        '被攻击时50%概率触发：',
        '无我相：免疫本次攻击造成的内伤/封穴/冰封/灼烧',
        '无人相：集气条前进100',
        '无众生相：无视敌方武常',
        '无寿者相：恢复100点生命',
      ],
    },
    {
      name: '般若金刚',
      condition: '大力金刚掌+般若掌+龙象般若功',
      effect: ['破防目标30%', '金刚掌：必暴击', '般若掌：变为点攻，威力双倍', '十龙十象：主运龙象般若功，概率击晕目标'],
    },
    {
      name: '罗汉金身',
      condition: '金刚不坏体+罗汉伏魔功，主运罗汉伏魔功、金刚不坏体或易筋神功',
      effect: ['主运罗汉伏魔功、金刚不坏体或易筋神功，被攻击时30%概率第一击伤害降低50%'],
    },
    {
      name: '少林绝学',
      condition: '易筋神功+罗汉伏魔功，主运易筋神功',
      effect: ['主运易筋神功，攻击时必出“罗汉伏魔”特效 （加成1.1倍）'],
    },
    {
      name: '少林绝学',
      condition: '易筋神功+金刚不坏体，主运易筋神功',
      effect: ['主运易筋神功，被攻击必出“金刚不坏”特效，高优先级降低30%所承受伤害与杀气'],
    },
    {
      name: '虎啸龙吟',
      condition: '同时修炼擒龙手+虎爪绝户手到极',
      effect: [
        '攻击时概率触发“虎啸”“龙吟”（擒龙手/虎爪绝户手概率+20，暴怒概率翻倍）：',
        '虎啸：被击中的目标概率混乱',
        '龙吟：被击中的目标集气位置倒退300',
      ],
    },
    {
      name: '血战沙场',
      condition: '岳家枪法+岳王散手+武穆遗书',
      effect: [
        '使用岳家枪法/岳王散手对七格范围内敌人造成10~20点伤害2次，根据击杀数和怒气值增加次数',
        '学习岳家枪法/岳王散手，另一门需求减40',
      ],
    },
    {
      name: '素质三连',
      condition: '同时修炼三分剑法+连城剑法到极',
      effect: ['暴怒时使用三分/连城剑法必定三连击'],
    },
    {
      name: '五岳剑法',
      condition: '修炼五岳剑法(太岳+云雾+泰山+万花+万岳)',
      effect: [
        '每修炼一门，五岳剑法武功威力+100，御剑+20 连击率+5%（集齐五岳剑法时，该效果以7门剑法计算）',
        '使用五岳剑法攻击概率发动气贯五岳提升1000气攻，暴怒必定发动 ',
      ],
    },
    {
      name: '两仪守护',
      condition: '同时修炼两仪剑法+反两仪刀法到极',
      effect: ['两仪守护：被攻击时64%概率减伤32点，并降低敌方320气攻', '两仪守护·极：被攻击时32%概率减伤64点，并降低敌方640气攻'],
    },
    {
      name: '双剑合璧',
      condition: '全真剑法+玉女剑法+左右互搏',
      effect: [
        '连击率+30%',
        '使用全真/玉女剑法：',
        '└攻击范围增大',
        '└攻击时触发双剑合璧·攻：必击中对方破绽，40%概率集气停止5时序',
        '└防御时触发双剑合璧·守：免疫破绽，免疫被杀气到-100',
      ],
    },
    {
      name: '以柔克刚',
      condition: '同时修炼太极剑法+柔云剑法到极',
      effect: ['被攻击时，有50%概率将被杀气量的一半转化为回血'],
    },
    {
      name: '洞虚玄门',
      condition: '神门十三剑+玄虚刀法',
      effect: ['玄虚刀法必封穴，神门十三剑必冰封灼烧', '受到攻击30%概率使用双倍内力抵消一半伤害'],
    },
    {
      name: '剑胆琴心',
      condition: '同时修炼独孤九剑+持瑶琴到极',
      effect: [
        '自身受到的伤害会转化为战斗中临时的御剑系数提高（持续整场战斗有效，加成上限不会超过320）',
        '使用持瑶琴攻击时，自身恢复5%当前血量并减少10点内伤',
        '学有其中之一，则学习另一武功的兵器值需求-40',
      ],
    },
    {
      name: '五虎',
      condition: '五虎断门刀+五虎棍法',
      effect: [
        '赞天虎：一虎在场，攻击时30%概率提升全队100集气',
        '彻地虎：二虎在场，被攻击时30%概率提高1000点气防',
        '穿山虎：三虎在场，攻击时30%概率增加100点伤害',
        '翻江虎：四虎在场，集气条30%概率跳跃10点集气速度',
        '锦毛虎：五虎在场，被攻击时30%概率弹10%伤害',
      ],
    },
    {
      name: '利刃寒锋',
      condition: '同时修炼修罗刀法+阴风刀法+沧溟刀法到极',
      effect: ['攻击时有50%概率、暴怒攻击必定触发，追加10时序的“冻结”效果', '冻结：无法集气和时序回复状态'],
    },
    {
      name: '天衣无缝',
      condition: '同时修炼鸳鸯刀法+夫妻刀法到极',
      effect: ['使用任何刀系武功增加30%连击率'],
    },
    {
      name: '举火燎原',
      condition: '同时修炼金乌刀法+燃木刀法+火焰刀法到极',
      effect: ['攻击时有50%概率、暴怒攻击必定触发，追加10时序的“引燃”效果', '引燃：每时序损失2%当前血量'],
    },
    {
      name: '金乌映雪',
      condition: '同时修炼金乌刀法+雪山剑法极',
      effect: ['金乌刀法攻击时若造成灼烧则附加同等的冰封', '雪山剑法攻击时若造成冰封则附加同等的灼烧'],
    },
    {
      name: '寸长寸强',
      condition: '呼延枪法+呼延十八鞭',
      effect: ['使用奇门武功伤害不随距离降低，距离每远一格伤害增加1%'],
    },
    {
      name: '琴棋书画',
      condition: '同时修炼琴棋书画',
      effect: [
        '持摇琴：威力+300',
        '└琴音悦耳：攻击不造成怒气，100%发动',
        '└菩提清心：使敌方怒气减半，概率发动',
        '棋盘招式：威力+300',
        '└棋高一着：追加1200气攻，100%发动',
        '└星罗棋布：额外提升1000气攻，概率发动',
        '妙笔丹青：威力+300',
        '└画地为牢：使妙笔丹青攻击附带冰封，高概率发动',
        '└江山如画：大幅提升妙笔丹青冰封效果，概率发动',
        '倚天屠龙功：威力+300',
        '└秉笔直书：攻击必定造成封穴，且伤害提升20%，概率发动',
      ],
    },
    {
      name: '世尊伏魔',
      condition: '伏魔杖法+无上大力杵+金刚伏魔圈+罗汉伏魔功',
      effect: ['暴击率增加50%', '40%概率触发，暴怒必触发：', '└攻击增加气攻/20的伤害（暴怒为气攻/15），造成伤害如小于100则额外加100 '],
    },
    {
      name: '森罗万象',
      condition: '九阴神功+九阳神功',
      effect: ['免疫敌方暴击的额外伤害和额外气攻'],
    },
    {
      name: '自在逍遥',
      condition: '小无相功+北冥神功+八荒六合功（bug：最后学北冥无法领悟）',
      effect: [
        '灵鹫宫对话石像战胜无崖子后，学会“逍遥御风”：',
        '攻击与被攻击均有概率触发特效"逍遥御风"，累积点数。',
        '当累积点数达到9点时，从下次开始受到攻击开始计算，闪避15时序并清空封穴',
        '此状态不会被杀气或封穴，直到人物下次行动时累积归零',
        '单次攻击累积“逍遥御风”上限为3次',
      ],
    },
    {
      name: '万象天引',
      condition: '北冥神功+吸星大法+乾坤大挪移（bug：最后学北冥无法领悟）',
      effect: [
        '万象天引：反弹50%所受伤害和一切状态',
        '神罗天征：每三回合触发一次，将自身3~10格范围的目标拉到身前三格内的一个点重叠，并锁足一回合',
      ],
    },
    {
      name: '梵我合一',
      condition: '神足经+瑜伽密乘，主运神足经或瑜伽密乘',
      effect: ['受到会暴击或连击的攻击时，20%概率终止敌方行动'],
    },
    {
      name: '伏虎罗汉拳',
      condition: '易筋神功+罗汉拳',
      effect: ['使用罗汉拳60%概率伤害提高50点'],
    },
    {
      name: '达摩掌',
      condition: '易筋神功+大金刚掌',
      effect: ['使用大力金刚掌40%概率提高100点伤害'],
    },
    {
      name: '真辟邪剑法·葵花刺目',
      condition: '辟邪剑法+葵花神功',
      effect: [
        '主运葵花神功使用辟邪剑法攻击，概率触发特效“真辟邪剑法·葵花刺目”',
        '被刺目的敌人，本场战斗伤害和杀气均下降15%，攻击时有50%概率落空',
        '习得葵花神功后，辟邪剑法威力+1000',
      ],
    },
    {
      name: '混元一气',
      condition: '混元掌+混元功',
      effect: ['攻击时追加5~15点内伤和5~15时序集气混乱'],
    },
    // {
    //   name: '太空卸劲',
    //   condition: '同时修炼太极拳+空明拳到极',
    //   effect: ['被攻击时35%概率减伤1/3，同时降低攻击方行动后的集气位置120'],
    // },
    {
      name: '九阴神爪',
      condition: '九阴神功+九阴白骨爪，主运九阴神功',
      effect: ['主运九阴神功，使用九阴白骨爪必触发九阴神爪极意', '九阴神爪极意：必连击，增加1500点伤害杀气，范围为7*7'],
    },
    {
      name: '刀剑归真',
      condition: '同时修炼胡家刀法+苗家剑法到极',
      effect: ['用其中一种武功攻击时概率触发：真气攻+1500，爆怒归真必三连,攻击伤害+50%', '学有其中之一，则学习另一武功的兵器值需求-40'],
    },
  ],
};
