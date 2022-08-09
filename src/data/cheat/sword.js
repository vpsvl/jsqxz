export default {
  name: '剑法',
  exclusive: '',
  list: [
    {
      name: '松风剑法',
      level: '1',
      get: '开局宝箱获得',
      power: 250,
      gasPower: 300,
      range: '« 7格',
      condition: '御剑20',
      internal: '',
      addition: '攻击+2 御剑+2',
      sect: '',
      peculiar: [],
    },
    {
      name: '雷震剑法',
      level: '1',
      get: '收温青青获得',
      power: 220,
      gasPower: 300,
      range: '« 6格',
      condition: '御剑20',
      internal: '',
      addition: '攻击+1 御剑+2',
      sect: '',
      peculiar: [],
    },
    {
      name: '辟邪剑法',
      level: '4',
      get: '笑邪收林平之',
      power: 1600,
      gasPower: 0,
      range: '米 4+4格',
      condition: '御剑20',
      internal: '0',
      addition: '轻功+2 御剑+2',
      sect: '',
      peculiar: [
        {
          name: '真辟邪剑法·葵花刺目',
          condition: '辟邪剑法+葵花神功',
          effect: [
            '主运葵花神功使用辟邪剑法攻击，几率触发特效“真辟邪剑法·葵花刺目”',
            '被刺目的敌人，本场战斗伤害和杀气均下降15%，攻击时有50%几率落空',
            '习得葵花神功后，辟邪剑法威力+1000',
          ],
        },
      ],
    },
    {
      name: '雪山剑法',
      level: '1',
      get: '凌霄城宝箱',
      power: 330,
      gasPower: 600,
      range: '米 7格',
      condition: '御剑30',
      internal: '0',
      addition: '攻击+1 御剑+2',
      sect: '',
      peculiar: [
        {
          name: '金乌映雪',
          condition: '同时修炼金乌刀法+雪山剑法极',
          effect: ['金乌刀法攻击时若造成灼烧则附加同等的冰封', '雪山剑法攻击时若造成冰封则附加同等的灼烧'],
        },
      ],
    },
    {
      name: '三分剑法',
      level: '2',
      get: '1.书剑六合塔战后获得 2.书剑收霍青桐获得',
      power: 770,
      gasPower: 400,
      range: '« 7格',
      condition: '御剑30',
      internal: '0',
      addition: '攻击+1 轻功+1 御剑+2',
      sect: '',
      peculiar: [
        {
          name: '素质三连',
          condition: '同时练有三分剑法+连城剑法到极',
          effect: ['暴怒时使用三分/连城剑法必定三连击'],
        },
      ],
    },
    {
      name: '一字电剑',
      level: '1',
      get: '恒山山麓战卓不凡后获得',
      power: 350,
      gasPower: 330,
      range: '« 7格',
      condition: '御剑30',
      internal: '1',
      addition: '攻击+1 轻功+1 御剑+2',
      sect: '',
      peculiar: [
        {
          name: '一脉相承',
          condition: '',
          effect: ['可洗为周公剑法'],
        },
      ],
    },
    {
      name: '绕指柔剑',
      level: '2',
      get: '武当张三丰赠予',
      power: 550,
      gasPower: 600,
      range: '米 4格',
      condition: '御剑30',
      internal: '0',
      addition: '攻击+1 防御+1 御剑+2',
      sect: '',
      peculiar: [],
    },
    {
      name: '太岳三青峰',
      level: '2',
      get: '笑傲衡阳救林平之，岳不群送',
      power: 760,
      gasPower: 600,
      range: '« 6格',
      condition: '御剑30',
      internal: '',
      addition: '攻击+1 轻功+1 御剑+2',
      sect: '',
      peculiar: [
        {
          name: '五岳剑法',
          condition: '修炼五岳剑法(太岳+云雾+泰山+万花+万岳)',
          effect: [
            '每修炼一门，五岳剑法武功威力+100，御剑+20 连击率+5%（集齐五岳剑法时，该效果以7门剑法计算）',
            '使用五岳剑法攻击几率发动气贯五岳提升1000气攻，暴怒必定发动 ',
          ],
        },
      ],
    },
    {
      name: '泰山十八盘',
      level: '2',
      get: '五岳大会前击败天门',
      power: 760,
      gasPower: 500,
      range: '米 7格',
      condition: '御剑30',
      internal: '',
      addition: '攻击+1 防御+1 御剑+2',
      sect: '',
      peculiar: [
        {
          name: '五岳剑法',
          condition: '修炼五岳剑法(太岳+云雾+泰山+万花+万岳)',
          effect: [
            '每修炼一门，五岳剑法武功威力+100，御剑+20 连击率+5%（集齐五岳剑法时，该效果以7门剑法计算）',
            '使用五岳剑法攻击几率发动气贯五岳提升1000气攻，暴怒必定发动 ',
          ],
        },
      ],
    },
    {
      name: '万花剑法',
      level: '2',
      get: '五岳大会前击败定闲',
      power: 760,
      gasPower: 500,
      range: '■ 6+7×7',
      condition: '御剑30',
      internal: '',
      addition: '攻击+1 防御+1 御剑+2',
      sect: '',
      peculiar: [
        {
          name: '五岳剑法',
          condition: '修炼五岳剑法(太岳+云雾+泰山+万花+万岳)',
          effect: [
            '每修炼一门，五岳剑法武功威力+100，御剑+20 连击率+5%（集齐五岳剑法时，该效果以7门剑法计算）',
            '使用五岳剑法攻击几率发动气贯五岳提升1000气攻，暴怒必定发动 ',
          ],
        },
      ],
    },
    {
      name: '云雾十三式',
      level: '2',
      get: '五岳大会之前击败莫大',
      power: 760,
      gasPower: 600,
      range: '« 5格',
      condition: '御剑40',
      internal: '',
      addition: '攻击+1 轻功+1 御剑+2',
      sect: '',
      peculiar: [
        {
          name: '五岳剑法',
          condition: '修炼五岳剑法(太岳+云雾+泰山+万花+万岳)',
          effect: [
            '每修炼一门，五岳剑法武功威力+100，御剑+20 连击率+5%（集齐五岳剑法时，该效果以7门剑法计算）',
            '使用五岳剑法攻击几率发动气贯五岳提升1000气攻，暴怒必定发动 ',
          ],
        },
      ],
    },
    {
      name: '万岳朝宗',
      level: '2',
      get: '五岳大会前击败左冷禅',
      power: 870,
      gasPower: 600,
      range: '« 6格',
      condition: '御剑50',
      internal: '',
      addition: '攻击+1 御剑+2',
      sect: '',
      peculiar: [
        {
          name: '五岳剑法',
          condition: '修炼五岳剑法(太岳+云雾+泰山+万花+万岳)',
          effect: [
            '每修炼一门，五岳剑法武功威力+100，御剑+20 连击率+5%（集齐五岳剑法时，该效果以7门剑法计算）',
            '使用五岳剑法攻击几率发动气贯五岳提升1000气攻，暴怒必定发动 ',
          ],
        },
      ],
    },
    {
      name: '北斗剑法',
      level: '1',
      get: '龙门客栈商店出售',
      power: 440,
      gasPower: 400,
      range: '米 5格',
      condition: '御剑40',
      internal: '',
      addition: '攻击+1 轻功+1 御剑+2',
      sect: '',
      peculiar: [
        {
          name: '一脉相承',
          condition: '',
          effect: ['可洗为参合剑气'],
        },
      ],
    },
    {
      name: '两仪剑法',
      level: '3',
      get: '倚天邪灭昆仑派',
      power: 1100,
      gasPower: 0,
      range: '米 5格',
      condition: '御剑60',
      internal: '',
      addition: '攻击+1 御剑+4',
      sect: '',
      peculiar: [
        {
          name: '两仪守护',
          condition: '同时修炼两仪剑法+反两仪刀法到极',
          effect: ['两仪守护：被攻击时64%几率减伤32点，并降低敌方320气攻', '两仪守护·极：被攻击时32%几率减伤64点，并降低敌方640气攻'],
        },
      ],
    },
    {
      name: '全真剑法',
      level: '2',
      get: '重阳宫宝箱，需战斗和减道德',
      power: 770,
      gasPower: 800,
      range: '« 7格',
      condition: '御剑70',
      internal: '',
      addition: '攻击+1 防御+1 御剑+3',
      sect: '',
      peculiar: [
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
      ],
    },
    {
      name: '玉女剑法',
      level: '2',
      get: '神雕蜘蛛洞周伯通给',
      power: 880,
      gasPower: 800,
      range: '« 5格',
      condition: '御剑70',
      internal: '',
      addition: '攻击+1 轻功+1 御剑+3',
      sect: '',
      peculiar: [
        {
          name: '一脉相承',
          condition: '',
          effect: ['可洗为玉女素心剑'],
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
      ],
    },
    {
      name: '柔云剑术',
      level: '2',
      get: '书剑清兵大营战胜张召重',
      power: 770,
      gasPower: 700,
      range: '« 7格',
      condition: '御剑70',
      internal: '0',
      addition: '攻击+1 御剑+3',
      sect: '',
      peculiar: [
        {
          name: '以柔克刚',
          condition: '同时修炼太极剑法+柔云剑法到极',
          effect: ['被攻击时，有50%几率将被杀气量的一半转化为回血'],
        },
      ],
    },
    {
      name: '玉箫剑法',
      level: '3',
      get: '神雕收程英后获得',
      power: 990,
      gasPower: 800,
      range: '« 5格',
      condition: '御剑70',
      internal: '',
      addition: '攻击+1 御剑+3 拳掌+1',
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
      name: '金蛇剑法',
      level: '2',
      get: '金蛇山洞拔出金蛇剑后获得',
      power: 880,
      gasPower: 900,
      range: '米 6格',
      condition: '御剑70',
      internal: '',
      addition: '攻击+1 轻功+1 御剑+3',
      sect: '',
      peculiar: [],
    },
    {
      name: '宁氏一剑',
      level: '2',
      get: '沧州商店出售',
      power: 770,
      gasPower: 700,
      range: '« 6格',
      condition: '御剑70',
      internal: '',
      addition: '攻击+1 御剑+3',
      sect: '',
      peculiar: [
        {
          name: '',
          condition: '',
          effect: ['攻击时50%几率给敌人添加虚弱状态，暴怒必触发'],
        },
      ],
    },
    {
      name: '玄女剑法',
      level: '2',
      get: '碧正不救温青青获得',
      power: 880,
      gasPower: 1300,
      range: '« 5格',
      condition: '御剑100',
      internal: '',
      addition: '攻击+1 防御+1 轻功+1 御剑+4',
      sect: '',
      peculiar: [
        {
          name: '女性专属',
          condition: '',
          effect: ['攻击&气攻提升20%'],
        },
      ],
    },
    {
      name: '周公剑法 ',
      level: '3',
      get: '灵鹫宫战卓不凡后获得',
      power: 990,
      gasPower: 1000,
      range: '« 7格',
      condition: '御剑100',
      internal: '1',
      addition: '轻功+1 防御+1 御剑+4',
      sect: '',
      peculiar: [
        {
          name: '一脉相承',
          effect: ['可由一字电剑一脉相承'],
        },
      ],
    },
    {
      name: '铁剑诀',
      level: '3',
      get: '碧邪灭华山派获得',
      power: 1320,
      gasPower: 1300,
      range: '« 8格',
      condition: '御剑100',
      internal: '1',
      addition: '攻击+2 防御+2 御剑+4 ',
      sect: '',
      peculiar: [
        {
          name: '铁甲',
          condition: '铁掌+铁剑诀+铁布衫，主运铁布衫',
          effect: ['主运铁布衫，护甲提升20%，被攻击时20%几率抵挡生命最大值2%伤害'],
        },
      ],
    },
    {
      name: '猿公剑法',
      level: '3',
      get: '倚天正线昆仑仙境战胜金轮众人，邪线昆仑仙境挖坟战胜阿青+白猿',
      power: 1320,
      gasPower: 1200,
      range: '« 8格',
      condition: '御剑140',
      internal: '',
      addition: '攻击+1 轻功+1 御剑+4 ',
      sect: '',
      peculiar: [],
    },
    {
      name: '神门十三剑',
      level: '3',
      get: '武当山宝箱',
      power: 1100,
      gasPower: 1000,
      range: '« 6格',
      condition: '御剑100',
      internal: '',
      addition: '攻击+1 防御+1 御剑+4',
      sect: '',
      peculiar: [
        {
          name: '洞虚玄门',
          condition: '神门十三剑+玄虚刀法',
          effect: ['玄虚刀法必封穴，神门十三剑必冰封灼烧', '受到攻击30%几率使用双倍内力抵消一半伤害'],
        },
      ],
    },
    {
      name: '倚天剑谱',
      level: '3',
      get: '倚天邪线收周芷若后获得',
      power: 1100,
      gasPower: 1000,
      range: '« 7格',
      condition: '御剑100',
      internal: '',
      addition: '攻击+1 防御+1 御剑+4',
      sect: '',
      peculiar: [],
    },
    {
      name: '连城剑法',
      level: '3',
      get: '连城雪山用水浸唐诗选辑',
      power: 1100,
      gasPower: 900,
      range: '« 6格',
      condition: '御剑100',
      internal: '',
      addition: '攻击+1 轻功+1 御剑+4',
      sect: '',
      peculiar: [
        {
          name: '素质三连',
          condition: '同时练有三分剑法+连城剑法到极',
          effect: ['暴怒时使用三分/连城剑法必定三连击'],
        },
      ],
    },
    {
      name: '达摩剑法',
      level: '3',
      get: '南少林战胜大痴和尚',
      power: 1100,
      gasPower: 1000,
      range: '« 5格',
      condition: '御剑100',
      internal: '',
      addition: '攻击+2 御剑+4',
      sect: '',
      peculiar: [],
    },
    {
      name: '苗家剑法',
      level: '3',
      get: '飞狐程灵素线沧州胡一刀坟对话苗人凤送和天书战打败苗人凤',
      power: 1210,
      gasPower: 1000,
      range: '« 6格',
      condition: '御剑100',
      internal: '',
      addition: '攻击+2 御剑+4',
      sect: '',
      peculiar: [
        {
          name: '刀剑归真',
          condition: '同时修炼胡家刀法+苗家剑法到极',
          effect: ['用其中一种武功攻击时几率触发：真气攻+1500，爆怒归真必三连,攻击伤害+50%', '学有其中之一，则学习另一武功的兵器值需求-40'],
        },
      ],
    },
    {
      name: '太极剑法',
      level: '4',
      get: '道德≥85张三丰送',
      power: 1540,
      gasPower: 1300,
      range: '米 5格',
      condition: '御剑100',
      internal: '',
      addition: '攻击+2 防御+2 御剑+4',
      sect: '',
      peculiar: [
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
        {
          name: '以柔克刚',
          condition: '同时修炼太极剑法+柔云剑法到极',
          effect: ['被攻击时，有50%几率将被杀气量的一半转化为回血'],
        },
      ],
    },
    {
      name: '玄铁剑法',
      level: '4',
      get: '独孤剑冢调查神雕旁边的墙壁',
      power: 1200,
      gasPower: 1500,
      range: '米 4格',
      condition: '御剑100',
      internal: '1',
      addition: '攻击+4 御剑+5',
      sect: '',
      peculiar: [
        {
          name: '玄铁极意',
          condition: '限定主角、杨过和神雕',
          effect: ['玄铁极意：攻击范围变为面攻，气攻1800', '使用玄铁剑法攻击不出招式时几率发动，暴怒时必定发动'],
        },
        {
          name: '重剑真传.浪如山涌剑如虹',
          condition: '暴怒',
          effect: ['暴怒触发大范围伤害'],
        },
        {
          name: '破尽天下',
          condition: '需装备玄铁剑才能触发',
          effect: ['重剑无锋.破尽天下：', '无视一切必定破气防，且追加1000气攻', '暴击概率为40+装备等级*10'],
        },
        {
          name: '剑魔再临',
          condition: '包里有【玄铁剑法】或【独孤九剑】，且主角御剑≥320时，华山后山对话独孤求败，战胜可选择习得九剑真传或剑魔再临',
          effect: ['使用玄铁剑法攻击时50%概率发动两种特效之一：天极剑渊：破防50%，破尽天下：无视气防，气攻+800'],
        },
      ],
    },
    {
      name: '追魂夺命剑',
      level: '4',
      get: '书剑双线最终战获得',
      power: 1540,
      gasPower: 1200,
      range: '« 8格',
      condition: '御剑120',
      internal: '',
      addition: '攻击+3 御剑+5',
      sect: '',
      peculiar: [],
    },
    {
      name: '玉女素心剑',
      level: '4',
      get: '神正获得天书时获得',
      power: 1300,
      gasPower: 1100,
      range: '« 7格',
      condition: '御剑120',
      internal: '0',
      addition: '攻击+2 轻功+2 御剑+4',
      sect: '',
      peculiar: [
        {
          name: '一脉相承',
          condition: '',
          effect: ['可由玉女剑法一脉相承'],
        },
      ],
    },
    {
      name: '独孤九剑',
      level: '4',
      get: '笑正少林大战后令狐冲给',
      power: 1540,
      gasPower: 1600,
      range: '米 7格',
      condition: '御剑140',
      internal: '',
      addition: '攻击+3 御剑+6',
      sect: '',
      peculiar: [
        {
          name: '九剑真传',
          condition: '包里有【玄铁剑法】或【独孤九剑】，且主角御剑≥320时，华山后山对话独孤求败，战胜可选择习得九剑真传或剑魔再临',
          effect: [
            '被攻击时，有70%几率减伤20%，并降低攻击方下回合集气位置200',
            '用独孤九剑攻击70%几率触发四种招式：',
            '离剑式：伤害不随距离递减',
            '倒剑式：敌方集气强制倒退200点',
            '撩剑式：伤害提高30%',
            '荡剑式：攻击后回气+200点',
          ],
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
      ],
    },
    {
      name: '参合剑气',
      level: '4',
      get: '天邪燕子坞还施水阁书架获得',
      power: 1400,
      gasPower: 1400,
      range: '米 7格',
      condition: '御剑140',
      internal: '',
      addition: '攻击+2 轻功+1 防御+1 御剑+5',
      sect: '',
      peculiar: [
        {
          name: '一脉相承',
          condition: '',
          effect: ['可由北斗剑法一脉相承'],
        },
        {
          name: '辰宿列张',
          condition: '学会参合剑气或参合指',
          effect: ['攻击时会给敌人添加“参合”状态：', '攻击时伤害降低10%~20%', '被攻击时受到的伤害增加15%~30%'],
        },
      ],
    },
    {
      name: '斩流剑术',
      level: '4',
      get: '西门吹雪华山后山战胜谢云流后获得',
      power: 1400,
      gasPower: 1200,
      range: '« 7格',
      condition: '御剑140',
      internal: '',
      addition: '攻击+2 轻功+2 御剑+5',
      sect: '',
      peculiar: [],
    },
    {
      name: '越女剑法',
      level: '4',
      get: '昆仑仙境战胜阿青',
      power: 1400,
      gasPower: 1200,
      range: '■ 5+5X5',
      condition: '御剑140',
      internal: '',
      addition: '攻击+2 轻功+1 御剑+5',
      sect: '',
      peculiar: [],
    },
  ],
};
