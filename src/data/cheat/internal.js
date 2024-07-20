export default {
  name: '内功',
  exclusive: '',
  list: [
    {
      id: 'jiuYinShenGong',
      name: '九阴神功',
      cheat: '九阴真经',
      level: 4,
      get: '射雕剧情获得[九阴真经上卷]，倚天剧情获得[九阴真经下卷]，任意点击一个使用获得',
      power: '生命2725 气防1550 格挡44 回气2',
      attack: {},
      condition: '内力≥2000',
      addition: '攻击+3 防御+1 内力上限+40',
      sect: '',
      internal: '0',
      initiative: [
        '每3时序恢复1点内伤（内伤大于50时，效果加倍）',
        '每6时序回复1点体力',
        '每时序额外回复1点灼烧',
        '【阴内专属】每时序额外回复5点生命值',
        '【阴内专属】连击率提高50%',
        '【阴内专属】高优先级提高20%伤害，降低10%所受到的伤害',
        '【阴内专属】第一击必定触发，连击30%概率触发“九阴破体”无视目标20%防御',
        '【阴内专属】冰封系武功必出冰封',
        '【阴内专属】击中时50%概率，发动“飞絮劲”附加100点真实伤害，必命中',
        '【阴内专属】被攻击有(20+天书数*3)%概率，发动“九阴真气”提升650点气防（可叠加）',
      ],
      peculiar: [
        {
          name: '九阴神爪',
          condition: '九阴神功+九阴白骨爪，主运九阴神功',
          effect: ['主运九阴神功，使用九阴白骨爪必触发九阴神爪极意', '九阴神爪极意：必连击，增加1500点伤害杀气，范围为7*7'],
        },
        {name: '森罗万象', condition: '九阴神功+九阳神功', effect: ['免疫敌方暴击的额外伤害和额外气攻']},
        {
          name: '九阴先天',
          condition: '九阴神功+先天功，主运九阴神功',
          effect: ['主运九阴神功，被杀气到-500，清除全部内伤，并回复10%最大生命值'],
        },
        {name: '逆运九阴', condition: '九阴神功+逆运经脉', effect: ['被攻击时暴击伤害减少20%', '主运九阴神功逆运经脉一同视为主运']},
      ],
    },
    {
      id: 'shenZuJing',
      name: '神足经',
      cheat: '',
      level: 3,
      get: '天龙邪丐帮打赢游坦之后获得',
      power: '生命2145 气防1230 格挡33 回气1~2',
      attack: {},
      condition: '资质≤50',
      addition: '攻击+1 防御+1 轻功+1 内力上限+30',
      sect: '',
      internal: '0',
      initiative: [
        '未装备武器时，攻击后根据拳掌系数追加伤害',
        '未装备防具时，攻击后根据指法系数追加护盾',
        '未装备坐骑时，攻击后根据奇门系数提升下回合集气位置',
        '每点体质增加1%伤害',
        '每点体质增加1%减伤',
      ],
      peculiar: [{name: '梵我合一', condition: '神足经+瑜伽密乘，主运其中一个', effect: ['受到会暴击或连击的攻击时，20%概率终止敌方行动']}],
    },
    {
      id: 'niYunJingMai',
      name: '逆运经脉',
      cheat: '逆运真经',
      level: 3,
      get: '射雕邪线一灯居杀死一灯后，去牛家村叫欧阳锋“爸爸”给予',
      power: '生命2100 气防1200 格挡33 回气1~2',
      attack: {},
      condition: '内力≥1600',
      addition: '攻击+2',
      sect: '',
      internal: '0',
      initiative: [
        '每3时序恢复1点内伤',
        '每6时序回复1点体力',
        '每时序恢复1点中毒',
        '被攻击，降低30%本次攻击所造成的内伤',
        '人物暴击率提高50%，暴击的攻击效果提高20%',
        '同时学有九阴神功被攻击时暴击伤害减少20%',
        '免疫封穴10点',
        '集气概率向前跳跃25时序（学会九阴后可提高至150）',
        '暴击率提高50%',
      ],
      peculiar: [
        {name: '逆运九阴', condition: '九阴神功+逆运经脉', effect: ['被攻击时暴击伤害减少20%', '主运九阴神功逆运经脉一同视为主运']},
      ],
    },
    {
      id: 'hanBingZhenQi',
      name: '寒冰真气',
      cheat: '',
      level: 3,
      get: '挑战左冷禅，胜利后获得',
      power: '生命1800 气防1000 格挡33 回气1~2',
      attack: {},
      condition: '',
      addition: '攻击+1',
      sect: '',
      internal: '0',
      initiative: ['每5时序恢复1点内伤', '对冰封值超过80的人概率冻结', '拳法出招概率+20%', '免疫冰封', '攻击必冰封'],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可由嵩山心法一脉相承']}],
    },
    {
      id: 'wuDuShenGong',
      name: '五毒神功',
      cheat: '五毒宝典',
      level: 2,
      get: '调查五毒教左上房间衣柜，战斗胜利后获得',
      power: '生命1550 气防900 格挡22 回气1',
      attack: {},
      condition: '',
      addition: '用毒+10 解毒+10 抗毒+10 内力上限+30',
      sect: '',
      internal: '0',
      initiative: [
        '攻击强制上毒20点',
        '攻击时根据目标中毒值追加伤害',
        '五毒神掌威力提升350点，战斗中基础威力随机提升1-3倍',
        '五毒神掌变为赤练神掌，追加70点伤害，引爆目标身上毒素',
      ],
      peculiar: [
        {
          name: '毒布武林',
          condition: '五毒神功+五毒神掌+千蛛万毒手+连环腐尸毒+冰蚕毒掌',
          effect: ['五毒神掌/五毒神功/千蛛万毒手/连环腐尸毒/冰蚕毒掌威力提升500', '行动前对全场敌人用毒，并概率叠加负面状态'],
        },
      ],
    },
    {
      id: 'ziXiaShenGong',
      name: '紫霞神功',
      cheat: '紫霞秘籍',
      level: 2,
      get: '笑傲完整线令狐冲首次入队后华山派与陆大有对话获得，简易线令狐冲入队后获得',
      power: '生命1400 气防800 格挡22 回气1',
      attack: {},
      condition: '内力≥300',
      addition: '防御+1 内力上限+10',
      sect: '',
      internal: '0',
      initiative: [
        '每3时序恢复1点内伤',
        '行动结束后回复20%已消耗的内力',
        '使用剑系武功有50%的概率触发“紫霞剑气”追加1000气攻',
        '剑法出招概率+20%',
        '蓄力必成功，且蓄力效果持续3回合',
      ],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可由华山心法一脉相承', '可洗为五岳剑诀']}],
    },
    {
      id: 'jiuYangShenGong',
      name: '九阳神功',
      cheat: '九阳真经',
      level: 4,
      get: '倚天昆仑仙境获得楞伽经，少林寺达摩堂佛像前研读并战胜斗酒僧',
      power: '生命2725 气防1550 格挡44 回气2',
      attack: {},
      condition: '内力≥2000',
      addition: '攻击+1 防御+3 内力上限+40',
      sect: '',
      internal: '1',
      initiative: [
        '每3时序恢复1点内伤（内伤大于50时，效果加倍）',
        '每时序恢复1点中毒',
        '时序额外解除1点冰封',
        '免疫流血',
        '【阳内专属】高优先级降低30%所承受伤害',
        '【阳内专属】内力消耗降低75%',
        '【阳内专属】每时序回复6点内力',
        '【阳内专属】每7时序自动解除自身封穴',
        '【阳内专属】使用灼烧系武功必出灼烧',
        '【阳内专属】被攻击有(20+天书数*3)%概率，发动“九阳真气”提升650点气防（可叠加）',
        '【阳内专属】每次行动前发动“九阳.抱元守一”清除自身不利状态',
        '【阳内专属】受到伤害>199时，高概率触发“氤氲紫气”：',
        '└气防增加600；',
        '└受到的气功减半；',
        '└承受伤害减少99；',
        '└承受气攻减少599；',
      ],
      peculiar: [
        {name: '一脉相承', condition: '', effect: ['可由少林九阳功、武当九阳功、峨眉九阳功一脉相承']},
        {name: '森罗万象', condition: '九阴神功+九阳神功', effect: ['免疫敌方暴击的额外伤害和额外气攻']},
      ],
    },
    {
      id: 'longXiangBanRuoGong',
      name: '龙象般若功',
      cheat: '',
      level: 4,
      get: '神雕正线襄阳城外战金轮后获得，邪线重阳宫大战后获得',
      power: '生命2425 气防1350 格挡44 回气2',
      attack: {},
      condition: '内力≥1350',
      addition: '攻击+2 防御+1 内力上限+30',
      sect: '',
      internal: '1',
      initiative: [
        '每5时序恢复1点内伤',
        '高优先级提升10%伤害，降低10%所承受伤害',
        '人物每次行动前自动进行蓄力',
        '攻击时有60%概率发动“龙象之力”，追加1000气攻',
        '“龙之蓄力·象之防御”，蓄力必成功，并同时执行防御指令',
        '“龙象之力”的追加气攻随自身怒气值提高而提高；暴怒时，无视敌方绝对气防',
      ],
      peculiar: [
        {
          name: '般若金刚',
          condition: '大力金刚掌+般若掌+龙象般若功',
          effect: ['破防目标30%', '金刚掌：必暴击', '般若掌：变为点攻，威力双倍', '十龙十象：主运龙象般若功，概率击晕目标'],
        },
      ],
    },
    {
      id: 'qinLongGong',
      name: '擒龙功',
      cheat: '',
      level: 3,
      get: '丐帮对话解风挑战真打狗阵',
      power: '生命2175 气防1250 格挡33 回气1~2',
      attack: {},
      condition: '内力≥2000',
      addition: '攻击+2',
      sect: '',
      internal: '1',
      initiative: [
        '每时序恢复2点流血',
        '免疫反弹、反击、斗转',
        '降龙打狗招式概率增加5%',
        '增加降龙十八掌极意概率15%',
        '降龙极意概率≥40%时增加概率10%',
        '降龙极意概率<40%时增加概率20%',
        '增加打狗极意触发概率20%',
        '增加丐世无双触发概率10%',
        '丐世无双学会其中一种另一种要求再降低20（即降低60）',
      ],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可由莲花功一脉相承']}],
    },
    {
      id: 'tieBuShan',
      name: '铁布衫',
      cheat: '',
      level: 3,
      get: '碧邪灭华山获得',
      power: '生命2025 气防1150 格挡33 回气1~2',
      attack: {},
      condition: '内力≥100',
      addition: '防御+2 内力上限+20',
      sect: '',
      internal: '1',
      initiative: ['行动后扣除5%最大内力', '护甲提升20%', '承受伤害大于100时，减伤60点'],
      peculiar: [
        {
          name: '铁甲',
          condition: '铁掌+铁剑诀+铁布衫，主运铁布衫',
          effect: ['主运铁布衫，护甲提升20%，被攻击时20%概率抵挡生命最大值2%伤害'],
        },
      ],
    },
    {
      id: 'yuQieMiCheng',
      name: '瑜伽密乘',
      cheat: '',
      level: 3,
      get: '神雕邪线绝情谷底收郭襄后获得',
      power: '生命1950 气防1100 格挡33 回气1~2',
      attack: {},
      condition: '内力≥1350 资质≤50 ',
      addition: '攻击+1 防御+2 内力上限+30',
      sect: '',
      internal: '1',
      initiative: [
        '每3时序恢复1点内伤',
        '被攻击时，集气不会被杀至300以下',
        '被连击时，受到的攻击效果/气攻降低40%',
        '免疫破绽',
        '被攻击时，集气不会被杀至300以下',
      ],
      peculiar: [{name: '梵我合一', condition: '神足经+瑜伽密乘，主运其中一个', effect: ['受到会暴击或连击的攻击时，20%概率终止敌方行动']}],
    },
    {
      id: 'chunYangWuJiGong',
      name: '纯阳无极功',
      cheat: '',
      level: 3,
      get: '书剑霍青桐线清兵大营战胜张召重后获得，李沅芷线龙门客栈战胜张召重',
      power: '生命1950 气防1100 格挡33 回气1~2',
      attack: {},
      condition: '内力≥950',
      addition: '防御+1 内力上限+20',
      sect: '',
      internal: '1',
      initiative: [
        '每时序恢复1点中毒',
        '降低武功内力消耗50%',
        '每时序额外回复1点冰封',
        '被攻击时，降低50%本次攻击所造成的冰封',
        '攻击时追加灼烧值两倍的真实伤害，每2点灼烧值减少敌方防御1%',
        '限男性，气防减伤增加20%',
      ],
      peculiar: [],
    },
    {
      id: 'jinGangBuHuaiTi',
      name: '金刚不坏体',
      cheat: '',
      level: 3,
      get: '鹿鼎记京城打败鳌拜后，去鳌拜家抄家获得',
      power: '生命1800 气防1000 格挡33 回气1~2',
      attack: {},
      condition: '内力≥1350',
      addition: '防御+2 内力上限+20',
      sect: '',
      internal: '1',
      initiative: ['每3时序恢复1点内伤', '被攻击时60%概率发动“金刚不坏”，高优先级降低30%所承受伤害及杀气'],
      peculiar: [
        {
          name: '金刚不坏',
          condition: '金刚不坏体+易筋神功，主运易筋神功',
          effect: ['主运易筋神功，被攻击必出“金刚不坏”特效，高优先级降低30%所承受伤害与杀气'],
        },
        {
          name: '罗汉金身',
          condition: '罗汉伏魔功+金刚不坏体，主运罗汉伏魔功、金刚不坏体或易筋神功',
          effect: ['主运罗汉伏魔功、金刚不坏体或易筋神功，被攻击时30%概率第一击伤害降低50%'],
        },
      ],
    },
    {
      id: 'wuDangJiuYangGong',
      name: '武当九阳功',
      cheat: '',
      level: 2,
      get: '破解龙门镖局血案获得',
      power: '生命1550 气防900 格挡22 回气1',
      attack: {},
      condition: '',
      addition: '防御+2 内力上限+20',
      sect: '',
      internal: '1',
      initiative: ['拳掌武功招式概率+20%', '增加伤害10%，减伤10%'],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可洗为九阳神功']}],
    },
    {
      id: 'eMeiJiuYangGong',
      name: '峨眉九阳功',
      cheat: '',
      level: 2,
      get: '倚天线战胜灭绝',
      power: '生命1550 气防900 格挡22 回气1',
      attack: {},
      condition: '',
      addition: '防御+2 轻功+1',
      sect: '',
      internal: '1',
      initiative: ['剑法武功招式概率+20%', '行动后概率触发“佛光普照”清除自身灼烧/中毒/冰封/流血/内伤'],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可洗为九阳神功']}],
    },
    {
      id: 'shaoLinJiuYangGong',
      name: '少林九阳功',
      cheat: '',
      level: 2,
      get: '送虚竹回少林后获得',
      power: '生命1550 气防900 格挡22 回气1',
      attack: {},
      condition: '',
      addition: '防御+2 内力上限+20 ',
      sect: '',
      internal: '1',
      initiative: ['奇门武功招式概率+20%', '被攻击概率减伤20%并进入防御状态'],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可洗为九阳神功']}],
    },
    {
      id: 'yiJinShenGong',
      name: '易筋神功',
      cheat: '易筋经',
      level: 4,
      get: '获得一苇渡江后，查看扫地僧右侧书架，达摩半血或300时序后获得',
      power: '生命2650 气防1500 格挡44 回气2',
      attack: {},
      condition: '内力≥2000',
      addition: '攻击+2 防御+2 内力上限+50 调和内力属性',
      sect: '',
      internal: '2',
      initiative: [
        '每3时序回复1点内伤（内伤大于50时，效果加倍）',
        '每时序回复1点中毒',
        '每时序回复6点内力值',
        '战场三围属性提升30%',
        '每时序额外回复1点封穴',
        '免疫内伤',
        '少林武学威力+200',
        '被攻击时，40%概率触发“易筋真谛”完全免疫杀气和内伤',
        '使用大力金刚掌，40%概率触发“达摩掌”伤害+100',
        '使用罗汉掌，60%概率触发“般若掌”伤害+50',
        '被攻击有(20+天书数*3)%概率，发动“易筋真气”提升650点气防（可叠加）',
      ],
      peculiar: [
        {name: '一脉相承', condition: '', effect: ['可由少林心法一脉相承']},
        {
          name: '罗汉伏魔',
          condition: '罗汉伏魔功+易筋神功，主运易筋神功',
          effect: ['主运易筋神功，攻击时必出“罗汉伏魔”特效 （加成1.1倍）'],
        },
        {
          name: '金刚不坏',
          condition: '金刚不坏体+易筋神功，主运易筋神功',
          effect: ['主运易筋神功，被攻击必出“金刚不坏”特效，高优先级降低30%所承受伤害与杀气'],
        },
      ],
    },
    {
      id: 'daZhouTianGong',
      name: '大周天功',
      cheat: '庄子',
      level: 3,
      get: '书剑沙漠废墟下楼兰遗迹调查尸骨',
      power: '生命2100 气防1200 格挡33 回气1~2',
      attack: {},
      condition: '内力≥1600',
      addition: '攻击+2 轻功+1 防御+1  调和内力属性',
      sect: '',
      internal: '2',
      initiative: [
        '每5时序恢复1点内伤',
        '封穴减少50%',
        '至人无己：攻击10%概率触发，目标集气倒走1~3时序',
        '神人无功：攻击30%概率触发，提升我方100点集气位置',
        '圣人无名：攻击50%概率触发，无视敌方80%的武常',
      ],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可由小周天功一脉相承']}],
    },
    {
      id: 'xiXingDaFa',
      name: '吸星大法',
      cheat: '',
      level: 3,
      get: '笑傲江湖 梅庄地牢剧情获得',
      power: '生命1800 气防1000 格挡33 回气1~2',
      attack: {},
      condition: '',
      addition: '内力硬上限+300（无法与北冥神功叠加） 调和内力属性',
      sect: '',
      internal: '2',
      initiative: [
        '每3时序恢复1点内伤',
        '攻击时50%概率发动“吸星大法”吸取敌方7%当前内力（上限300）与少量体力',
        '被攻击时50%概率发动“万物相吸.吸星大法”吸取敌方200点内力并转移到自身100点',
      ],
      peculiar: [
        {
          name: '万象天引',
          condition: '北冥神功+吸星大法+乾坤大挪移',
          effect: [
            '万象天引：反弹50%所受伤害和一切状态',
            '神罗天征：每三回合触发一次，将自身3~10格范围的目标拉到身前三格内的一个点重叠，并锁足一回合',
          ],
        },
      ],
    },
    {
      id: 'xiaoZhouTianGong',
      name: '小周天功',
      cheat: '',
      level: 2,
      get: '大理商店出售',
      power: '生命1550 气防900 格挡22 回气1',
      attack: {},
      condition: '内力≥100',
      addition: '攻击+1 轻功+1 防御+1 内力上限+50 调和内力属性',
      sect: '',
      internal: '2',
      initiative: ['增加攻击伤害15%，减少受到的伤害15%', '每5时序回复1点内伤'],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可洗为大周天功']}],
    },
    {
      id: 'taiXuJianYi',
      name: '太虚剑意',
      cheat: '',
      level: 4,
      get: '西门吹雪华山后山击败谢云流获得（目前只有西门吹雪可以获得）',
      power: '生命2800 气防1600 格挡44 回气2',
      attack: {},
      condition: '',
      addition: '攻击+1 防御+1 轻功+1 御剑+2',
      sect: '',
      internal: '',
      initiative: [
        '每3时序恢复1点内伤',
        '每时序回2点气血',
        '“坐忘无我韬光养晦”：被攻击时，受到气攻大于1500发动，吸收气攻值为自身的气防',
        '“三环套月”：使用剑法时太虚剑意加力使50%概率三连击',
        '“万剑归宗”：使用剑法时太虚剑意加力必造成封穴，追加气攻值1500点',
      ],
      peculiar: [],
    },
    {
      id: 'wangQingTianShu',
      name: '忘情天书',
      cheat: '',
      level: 4,
      get: '峨眉金顶战胜萧秋水获得',
      power: '生命2725 气防1550 格挡44 回气2',
      attack: {},
      condition: '',
      addition: '攻击+2 防御+2 轻功+2',
      sect: '',
      internal: '',
      initiative: [
        '每时序恢复1点流血',
        '每时序回2点生命，4点内力',
        '1书领悟：“天意”死亡时必触发“天意”复活一次"',
        '2书领悟：“水逝”增加冰封，冰封过50点概率发动“月映”冰冻5时序"',
        '3书领悟：“火延”增加燃烧，燃烧过50点概率发动“日明”点燃目标"',
        '4书领悟：“土掩”减伤30点，概率发动“风流”完全闪避攻击"',
        '5书领悟：“云翳”必杀集气200，20%（暴怒50%）概率“忘情无我”反弹全部伤害',
      ],
      peculiar: [],
    },
    {
      id: 'taiXuanShenGong',
      name: '太玄神功',
      cheat: '太玄经',
      level: 4,
      get: '侠客行正线侠客岛胜龙木二岛主后获得，邪线胜谢烟客后获得',
      power: '生命2650 气防1500 格挡44 回气2',
      attack: {},
      condition: '资质≤30',
      addition: '攻击+1 防御+2 轻功+1 内力上限+30',
      sect: '',
      internal: '',
      initiative: [
        '每3时序恢复1点内伤',
        '免疫中毒',
        '攻击时，体力消耗减少2点',
        '高优先级提升战场五系系数40%',
        '防御时触发“防御开始.太玄蓄力”防御的同时执行蓄力指令',
        '攻击时敌方产生怒气减半',
        '攻击时50%+(天书数*2+实战/25)%的概率发动“太玄之重”，攻击不会让敌方产生怒气',
        '└发动太玄之重时，若敌方为暴怒状态，则有50+(天书数*2+实战/25)%的概率发动：“救赵挥金锤.邯郸先震惊”，使敌方怒气值降低20点',
        '被攻击时，有40%的概率发动“太玄之轻”，免疫杀气，并将被杀气值转换成提升集气值，同时免疫内伤和普通中毒',
        '正线胜李白后，解锁“混沌太玄”：被攻击时，有30%概率将受到伤害的50%转化为回血',
        '邪线胜石破天后，解锁“太玄反震”：被攻击时，有50%概率对攻击方造成10点封穴（可叠加）',
      ],
      peculiar: [],
    },
    {
      id: 'douZhuanXingYi',
      name: '斗转星移',
      cheat: '',
      level: 4,
      get: '天龙邪燕子坞收慕容复',
      power: '生命2650 气防1200 格挡44 回气2',
      attack: {},
      condition: '总兵器值≥120 资质≥80',
      addition: '攻击+1 拳掌+1 指法+1 御剑+1 耍刀+1 特殊+1',
      sect: '',
      internal: '',
      initiative: [
        '斗转星移不需要主运即可生效',
        '高资(80-100)，斗转概率+10%，且斗转可控为高资专属',
        '爆怒时，如会斗转星移则概率增加20%',
        '【北斗移辰】：',
        '总兵器值<240，被攻击时25+(资质-30)/2概率触发',
        '以50%的威力斗转反击，并追加300点气攻',
        '【斗转星移】：',
        '240≤总兵器值<360，被攻击时25+(资质-30)/2概率触发',
        '以60%的威力斗转反击，并追加600点气攻',
        '【离合参商】：',
        '360≤总兵器值<520，被攻击时25+(资质-30)/2概率触发',
        '以70%的威力斗转反击，并追加1200点气攻',
        '【幻梦星辰】：',
        '总兵器值≥520，发动离合参商反击时有(五系兵器值之和-520)%的概率变为幻梦星辰反击',
        '反击伤害和气攻提高到80%',
      ],
      peculiar: [],
    },
    {
      id: 'wuMuYiShu',
      name: '武穆遗书',
      cheat: '',
      level: 4,
      get: '铁掌山拿玉玺处山洞中，调查书架战胜岳云和上官剑南后获得',
      power: '生命2575 气防1450 格挡44 回气2',
      attack: {},
      condition: '仅限主角',
      addition: '拳掌+1 指法+1 御剑+1 耍刀+1 特殊+1 暗器+1 武常+5',
      sect: '',
      internal: '',
      initiative: [
        '根据（实战数值/2）增加战场攻击力',
        '根据（实战数值/2）增加战场防御力',
        '我方全体攻击增加(实战数值/25)%',
        '威力等于750+实战最高1250',
      ],
      peculiar: [
        {
          name: '血战沙场',
          condition: '岳家枪法+岳王散手+武穆遗书',
          effect: ['使用岳家枪法/岳王散手对七格范围内敌人造成10~20点伤害2次，根据击杀数和怒气值增加次数'],
        },
      ],
    },
    {
      id: 'changShengJue',
      name: '长生诀',
      cheat: '',
      level: 4,
      get: '药王庙挖坟战斗后有神照经对话寇仲，以神照经换长生诀（需战胜寇仲+徐子陵）',
      power: '生命2425 气防1350 格挡44 回气2',
      attack: {},
      condition: '',
      addition: '防御+2',
      sect: '',
      internal: '',
      initiative: [
        '每时序回3点气血',
        '被攻击时减少30%受到的气攻',
        '免疫内伤',
        '复活时回复满血并立即行动',
        '顾道长生：被攻击25%概率触发，5时序内每时序恢复最大生命&内力1%',
        '阴阳相生：攻击造成灼烧时必定造成冰封，造成冰封时必定造成灼烧',
      ],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可由神照功一脉相承']}],
    },
    {
      id: 'jingXiGong',
      name: '鲸息功',
      cheat: '',
      level: 4,
      get: '灵鳖岛战胜梁萧后获得',
      power: '生命2425 气防1350 格挡44 回气2',
      attack: {},
      condition: '内力≥100',
      addition: '攻击+2 轻功+1 防御+1  内力上限+20',
      sect: '',
      internal: '',
      initiative: [
        '每时序增加2点怒气',
        '每3时序恢复1点内伤',
        '每时序恢复1点中毒',
        '每时序恢复3点生命，6点内力',
        '命中目标30%概率造成目标集气紊乱',
        '被攻击根据伤害值蓄力，蓄力值超过1000自身攻击必暴击',
        '根据蓄力值增加气防值',
        '根据蓄力值提升气攻值',
        '免疫冰封',
        '使用碧海惊涛掌可以触发六大奇劲',
        '└陷空力：忽视绝对气防+破防50%',
        '└滔天炁：触发大范围伤害',
        '└生灭道：攻击后触发霸体一回合',
        '└漩涡劲：增加一次连击，最多增加两次',
        '└阳流：必冰封必灼烧',
        '└滴水劲：附加气攻值5%伤害',
      ],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可由蛤蟆功一脉相承']}],
    },
    {
      id: 'tianMoGong',
      name: '天魔功',
      cheat: '天魔策',
      level: 4,
      get: '神雕邪击败蒙哥获得',
      power: '生命2425 气防1200 格挡44 回气2',
      attack: {},
      condition: '',
      addition: '攻击+2 轻功+1',
      sect: '',
      internal: '',
      initiative: [
        '“天魔大法”：暴怒时30%概率进入入魔状态，暴怒结束入魔结束。',
        '└免疫封穴杀气',
        '└吸血20%（上限200）',
        '└必连击概率三连击。',
        '受攻击时如自身生命值低于一半，免疫攻击10时序，CD200时序',
        '无视敌方30%防御',
        '行动后增加10点怒气值',
        '必暴击',
      ],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可由血河神鉴一脉相承']}],
    },
    {
      id: 'taiJiShenGong',
      name: '太极神功',
      cheat: '',
      level: 4,
      get: '拿完太极三宝之后可挑战张三丰，张三丰血量降低50%后获得《太极神功》',
      power: '生命2350 气防1300 格挡44 回气2',
      attack: {},
      condition: '内力≥1350 资质≥80',
      addition: '攻击+1 防御+2 内力上限+30',
      sect: '',
      internal: '',
      initiative: [
        '太极拳、太极剑威力+200',
        '被攻击时，有60%概率获得"太极之形"（可累积，上限10个）',
        '└每个"太极之形"可提高自身集气1点',
        '└主动攻击时，可释放累积的"太极之形"，增加连击数（每个5太极之形增加一次连击）',
        '被攻击储存蓄力值，使用太极拳/剑跟据蓄力值增加效果:',
        '└太极拳/剑蓄力值300～600，攻击范围+2',
        '└太极拳/剑蓄力值超过600，攻击范围变为可移动面攻，且必定连击',
        '└根据蓄力值增加防御跟减伤',
        '被攻击时，有30%概率触发【转阴阳】反弹自身所有异常状态',
        '开太极：',
        '└主运太极神功，使用太极拳法或太极剑法',
        '└蓄力值超过500、且暴怒触发',
        '└根据当前生命值跟内力值追加大范围伤害，生命比例越低、内力比例越高伤害越高',
        '真太奥：直到下次行动前，被攻击时将25%所受到的伤害转化为自身内力',
        '触发太极奥义时，必定触发"太极真义·四两拨千斤"，受到的伤害降低10%',
        '行动后自动执行防御指令',
      ],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可由武当心法一脉相承']}],
    },
    {
      id: 'buLaoChangChunGong',
      name: '不老长春功',
      cheat: '',
      level: 4,
      get: '不老长春谷击败逍遥子获得',
      power: '生命2350 气防1300 格挡44 回气2',
      attack: {},
      condition: '',
      addition: '防御+2内力最值+50',
      sect: '',
      internal: '',
      initiative: [
        '血量百分比高于内力百分比时，时序回复1%内力',
        '血量百分比低于内力百分比时，时序回复1%生命',
        '时序回复(5+天书数量)的生命值',
        '时序回复(5+天书数量)的生命值',
      ],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可由龟息功一脉相承']}],
    },
    {
      id: 'jinGangShiZiGong',
      name: '金刚狮子功',
      cheat: '',
      level: 4,
      get: '倚天邪战三渡后出现分支，选择战汝阳王府众，胜利后获得',
      power: '生命2350 气防1300 格挡44 回气2',
      attack: {},
      condition: '内力≥400',
      addition: '攻击+2 防御+2 内力上限+100',
      sect: '',
      internal: '',
      initiative: [
        '行动前诵念“金刚咒”',
        '└七格范围内我方获得200点护盾',
        '└七格范围内敌方伤害降低20%，受到伤害增加20%',
        '└20%概率度化敌方一回合',
      ],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可由狮子吼一脉相承']}],
    },
    {
      id: 'kuiHuaShenGong',
      name: '葵花神功',
      cheat: '葵花宝典',
      level: 4,
      get: '笑傲邪线黑木崖击败东方不败后获得',
      power: '生命2350 气防1300 格挡44 回气2',
      attack: {},
      condition: '限男性需自宫（自宫惩罚：攻击-25，防御-35，进入战斗后初始集气从-150处开始）或笑傲邪线打赢葵花尊者后可无视条件修炼',
      addition: '攻击+1  防御+1  轻功+5  内力上限+30',
      sect: '',
      internal: '',
      initiative: [
        '每5时序恢复1点内伤',
        '基础集气速度提升20%',
        '被攻击，30%概率触发“葵花移形”，降低30%的所受伤害和杀气',
        '被攻击，15%概率触发“真·葵花移形”，完全闪避一次攻击',
        '攻击时，50%概率触发“葵花诀·六合”：给敌增加1~2层减速BUFF",每层减敌集气2%，上限10层',
        '攻击时，20%概率触发“葵花刺目”：给敌方附加盲目DEBUFF，20%概率攻击MISS',
        '攻击时，60%概率触发“葵花点穴手”:增加气攻1000，必封穴',
        '天人化生：回合开始时，清除部分异常，并回复生命150-250,内力200-300，体力1-5',
      ],
      peculiar: [
        {
          name: '真辟邪剑法·葵花刺目',
          condition: '辟邪剑法+葵花神功',
          effect: [
            '主运葵花神功使用辟邪剑法攻击，概率触发特效“真辟邪剑法·葵花刺目”',
            '被刺目的敌人，本场战斗伤害和杀气均下降15%，攻击时有50%概率落空',
            '习得葵花神功后，辟邪剑法威力+1000',
          ],
        },
      ],
    },
    {
      id: 'wuYueJianJue',
      name: '五岳剑决',
      cheat: '',
      level: 4,
      get: '笑傲正华山秘洞内调查墙上文字可获得',
      power: '生命2275 气防1250 格挡44 回气2',
      attack: {},
      condition: '御剑≥140 内力≥1350',
      addition: '攻击+1 御剑+2 内力上限+30',
      sect: '',
      internal: '',
      initiative: [
        '被攻击时如未触发真气护体时，触发"以剑御气"，降低50%所受气攻',
        '五岳剑法威力+200，使用五岳剑法必出“气贯五岳”，追加气攻提高至1500，且无视绝对气防',
        '强化五岳剑法效果：',
        '太岳三青峰：连击时变为三连击',
        '云雾十三式：对于血量低于一半的敌人伤害加倍',
        '万花剑法：杀伤范围+1格',
        '泰山十八盘：攻击后30时序内有20%概率闪避',
        '万岳朝宗：对敌方造成伤害同时扣除对其伤害量相当的内力',
      ],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可由紫霞神功一脉相承']}],
    },
    {
      id: 'beiMingShenGong',
      name: '北冥神功',
      cheat: '',
      level: 4,
      get: '1.天龙正线燕子坞拒绝慕容复后段誉送 2.天龙正线收段誉后获得 3.天龙邪线带黑鸡慕容复天龙寺战斗后获取',
      power: '生命2200 气防1200 格挡44 回气2',
      attack: {},
      condition: '资质≥50',
      addition: '内力硬上限+300（无法与吸星大法叠加）',
      sect: '',
      internal: '',
      initiative: [
        '每3时序恢复1点内伤',
        '攻击时，50%概率吸取敌方7%当前内力（上限300）',
        '被攻击时，50%概率发动“北冥神功·百川入海”吸取敌方200点内力左右并转移到自身',
        '被攻击时，50%的概率触发“北冥真气”护体，+800气防（可叠加）',
        '攻击时(15+实战/20)%概率发动“北冥·气吞山河”吸取敌方20点怒气',
      ],
      peculiar: [
        {
          name: '自在逍遥',
          condition: '小无相功+北冥神功+八荒六合功',
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
          condition: '北冥神功+吸星大法+乾坤大挪移',
          effect: [
            '万象天引：反弹50%所受伤害和一切状态',
            '神罗天征：每三回合触发一次，将自身3~10格范围的目标拉到身前三格内的一个点重叠，并锁足一回合',
          ],
        },
      ],
    },
    {
      id: 'xianTianGong',
      name: '先天功',
      cheat: '',
      level: 3,
      get: '1.射雕正线一灯居击败欧阳锋 2.射雕正线重阳宫战斗后，道德≥90时与丘处机对话',
      power: '生命2100 气防1200 格挡33 回气1~2',
      attack: {},
      condition: '内力≥1100',
      addition: '防御+2 内力上限+20',
      sect: '',
      internal: '',
      initiative: [
        '每5时序恢复1点内伤',
        '被攻击，降低30%本次攻击所造成的内伤',
        '行动前有60%概率发动“先天调息”，获得一次休息效果',
        '被杀气到-500位置的时候，身上所有内伤清零，回复15%当前生命值，集气位置归零',
        '先天罡气：',
        '└攻击时清除目标蓄力效果',
        '└进战行动触发先天罡气护盾，抵消500点伤害。',
        '└护盾被击破后5回合后概率再次生成',
      ],
      peculiar: [
        {name: '一脉相承', condition: '', effect: ['可由全真心法一脉相承']},
        {name: '组合', condition: '先天功+玉女心经', effect: ['每时序额外恢复封穴1点']},
        {
          name: '组合',
          condition: '九阴神功+先天功，主运九阴神功',
          effect: ['主运九阴神功，被杀气到-500，清除全部内伤，并回复10%最大生命值'],
        },
      ],
    },
    {
      id: 'baHuangLiuHeGong',
      name: '八荒六合功',
      cheat: '',
      level: 3,
      get: '灵鹫宫看完壁画后获得',
      power: '生命2100 气防1200 格挡33 回气1~2',
      attack: {},
      condition: '内力≥1150',
      addition: '防御+2 内力上限+20',
      sect: '',
      internal: '',
      initiative: [
        '每5时序恢复1点内伤',
        '被攻击时，20%概率触发护体气盾吸收33.3%所受伤害，并回复等量内力',
        '防御效果加成由25%提升至40%，且防御时的气防由500提升至1000',
        '免疫难5以上NPC根据伤害高低所追加的杀气及龙象的追加杀气',
        '被攻击时，10%概率触发护体气盾吸收33.3%所受的伤害，并回复等量内力',
        '*触发八荒六合功护体时，必定发动护体气盾减伤',
      ],
      peculiar: [
        {
          name: '自在逍遥',
          condition: '小无相功+北冥神功+八荒六合功',
          effect: [
            '灵鹫宫对话石像战胜无崖子后，学会“逍遥御风”：',
            '攻击与被攻击均有概率触发特效"逍遥御风"，累积点数。',
            '当累积点数达到9点时，从下次开始受到攻击开始计算，闪避15时序并清空封穴',
            '此状态不会被杀气或封穴，直到人物下次行动时累积归零',
            '单次攻击累积“逍遥御风”上限为3次',
          ],
        },
      ],
    },
    {
      id: 'shengHuoShenGong',
      name: '圣火神功',
      cheat: '',
      level: 3,
      get: '灵蛇岛击败圣火三使后获得',
      power: '生命2025 气防1150 格挡33 回气1~2',
      attack: {},
      condition: '内力≥450 资质≥50',
      addition: '防御+1 轻功+1 内力上限+10',
      sect: '',
      internal: '',
      initiative: [
        '奇门招式+30%，奇门武功破防+10%',
        '每5时序回复1点内伤',
        '被攻击，降低50%本次攻击所造成的封穴（可与其他同类效果叠加，乘法叠加）',
        '攻击时60%概率，无视对方集气条位置击中其破绽or重大破绽',
        '进入战斗时的初始集气值+200~300',
        '奇门大于200，攻击可造成“观火”状态：伤害-10%，移动-2',
        '如行动前未移动或者移动格数未消耗完，可在行动后获得一次移动机会',
      ],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可由地火功一脉相承']}],
    },
    {
      id: 'xiaoWuXiangGong',
      name: '小无相功',
      cheat: '',
      level: 3,
      get: '带虚竹去擂鼓山，剧情后获得',
      power: '生命1800 气防1000 格挡33 回气1~2',
      attack: {},
      condition: '内力≥900',
      addition: '防御+1 内力上限+20',
      sect: '',
      internal: '',
      initiative: [
        '每5时序恢复1点内伤',
        '总气防提升30%',
        '无我无相，攻击和被攻击时时兵器值判定必定不低于敌方',
        '降低修炼武功兵器值需求10点、降低兵器装备需求兵器值10点',
        '小无相功加力时，必定发动武功招式（降龙、六脉无效）',
      ],
      peculiar: [
        {
          name: '自在逍遥',
          condition: '小无相功+北冥神功+八荒六合功',
          effect: [
            '灵鹫宫对话石像战胜无崖子后，学会“逍遥御风”：',
            '攻击与被攻击均有概率触发特效"逍遥御风"，累积点数。',
            '当累积点数达到9点时，从下次开始受到攻击开始计算，闪避15时序并清空封穴',
            '此状态不会被杀气或封穴，直到人物下次行动时累积归零',
            '单次攻击累积“逍遥御风”上限为3次',
          ],
        },
      ],
    },
    {
      id: 'shiZiHou',
      name: '狮子吼',
      cheat: '',
      level: 3,
      get: '倚天正线打败圣火三使后，光明顶狮王给予，邪线崆峒三连战后狮王给予',
      power: '生命1800 气防1000 格挡33 回气1~2',
      attack: {},
      condition: '内力≥400',
      addition: '攻击+1 防御+1 内力上限+10',
      sect: '',
      internal: '',
      initiative: [
        '攻击时必定发动“狮子吼”，对全场内力低于自身1000点的敌人杀退100点集气，且追加造成5-9点内伤',
        '女性角色触发狮子吼变为"河东狮吼"效果翻倍，扣除自身内力180',
      ],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可洗为金刚狮子吼']}],
    },
    {
      id: 'hunYuanGong',
      name: '混元功',
      cheat: '',
      level: 3,
      get: '碧血正大功坊宝箱获得',
      power: '生命1800 气防1000 格挡33 回气1~2',
      attack: {},
      condition: '内力≥300',
      addition: '防御+1 内力上限+10',
      sect: '',
      internal: '',
      initiative: [
        '每3时序恢复1点内伤',
        '每3时序回复1点体力',
        '造成的封穴效果提高20%',
        '攻击时50%追加"混元一气"特效：对攻击目标追加5~15时序混乱',
      ],
      peculiar: [],
    },
    {
      id: 'huaGongDaFa',
      name: '化功大法',
      cheat: '',
      level: 3,
      get: '星宿派击败丁春秋后获得',
      power: '生命1800 气防1000 格挡33 回气1~2',
      attack: {},
      condition: '内力≥100',
      addition: '防御+2 内力上限+20',
      sect: '',
      internal: '',
      initiative: [
        '每3时序恢复1点内伤',
        '攻击时，50%概率化去敌方5%当前内力（上限300，下限100），并强制上毒16~20点',
        '被攻击时，50%概率发动“化功大法”化去敌方200点内力，并强制上毒10~15点',
      ],
      peculiar: [],
    },
    {
      id: 'kuRongChanGong',
      name: '枯荣禅功',
      cheat: '',
      level: 3,
      get: '天龙鸠摩智剧情后对话天龙寺枯荣获得',
      power: '生命1800 气防1000 格挡33 回气1~2',
      attack: {},
      condition: '',
      addition: '防御+1',
      sect: '',
      internal: '',
      initiative: [
        '每时序回3点内力',
        '免疫流血',
        '指法出招概率+20%',
        '一阳指威力增加200',
        '六脉神剑“剑气碧烟横”出招增加10%',
        '指法出招概率+10%',
        '亦枯亦荣：每回合消耗内力最大值的5%回复生命值',
      ],
      peculiar: [],
    },
    {
      id: 'luoHanFuMoGong',
      name: '罗汉伏魔功',
      cheat: '十八泥偶',
      level: 3,
      get: '侠客行去长乐帮送玄冰碧火酒时，长乐帮桌子上获得（道德-1）',
      power: '生命1650 气防900 格挡33 回气1~2',
      attack: {},
      condition: '内力≥500',
      addition: '防御+1 内力上限+20',
      sect: '',
      internal: '',
      initiative: [
        '行动结束后恢复10%已损失的生命值（血量翻倍的角色需除以血量倍数）',
        '每时序额外回复1点流血',
        '本内功加力时发动“罗汉伏魔”，根据以下公式提升伤害与杀气[高优先级]',
        '└罗汉伏魔提升伤害和杀气效果为：[(当前内力/30000)+(武功耗内/2000)]%',
        '被攻击，降低60%本次攻击所造成的内伤',
      ],
      peculiar: [
        {
          name: '世尊降魔',
          condition: '伏魔杖法+无上大力杵+金刚伏魔圈+罗汉伏魔功',
          effect: [
            '暴击率增加50%',
            '如果造成的伤害<300，则伤害等于300，暴怒追加一定气功伤害',
            '如果造成的伤害>300，则追加一定气功值伤害，暴怒则追加大量气功值伤害',
          ],
        },
        {
          name: '罗汉伏魔',
          condition: '罗汉伏魔功+易筋神功，主运易筋神功',
          effect: ['主运易筋神功，攻击时必出“罗汉伏魔”特效 （加成1.1倍）'],
        },
        {
          name: '罗汉金身',
          condition: '罗汉伏魔功+金刚不坏体，主运罗汉伏魔功、金刚不坏体或易筋神功',
          effect: ['主运罗汉伏魔功、金刚不坏体或易筋神功，被攻击时30%概率第一击伤害降低50%'],
        },
      ],
    },
    {
      id: 'yuNvXinJing',
      name: '玉女心经',
      cheat: '',
      level: 2,
      get: '蜘蛛洞剧情后获得',
      power: '生命1850 气防1100 格挡22 回气1 ',
      attack: {},
      condition: '内力≥1200',
      addition: '轻功+1 防御+1 内力上限+20',
      sect: '',
      internal: '',
      initiative: [
        '每3时序回复1点内伤',
        '连击时有(30+天书数*2)%的概率触发夭矫空碧特效，此次连击伤害、杀气不减',
        '人物攻击的第一击，有(天书数×2)%概率触发进趋如风特效，额外增加一次攻击（主角使用时概率增加5%，且暴怒时在每回合的第一次出手必发动）',
        '限女性，攻击与气攻增加20%',
        '受到的灼烧降低50%',
      ],
      peculiar: [{name: '组合', condition: '先天功+玉女心经', effect: ['每时序额外恢复封穴1点']}],
    },
    {
      id: 'qiMenWuZhuan',
      name: '奇门五转',
      cheat: '',
      level: 2,
      get: '暂无',
      power: '生命1700 气防1000 格挡22 回气1',
      attack: {},
      condition: '资质≥80',
      addition: '轻功+1 御剑+1 内力上限+50',
      sect: '',
      internal: '',
      initiative: [
        '被攻击时5%概率将一半伤害转化为自身护盾',
        '被攻击时5%概率将一半伤害转化为对方掉血',
        '被攻击时5%概率将一半伤害转化为内力回复',
        '被攻击时5%概率攻击转给随机地方承受',
        '被攻击时5%概率转移自身位置',
        '被攻击时25%概率将杀气效果转由对方承受',
        '武功威力提升5%',
        '加力/护体/出招概率提升5%',
        '气攻/气防提升5%',
      ],
      peculiar: [],
    },
    {
      id: 'guiXiGong',
      name: '龟息功',
      cheat: '',
      level: 2,
      get: '1.75道德对话张三丰送 2.洛阳客栈战胜白展堂后花20000两购买（战斗失败无法获得且损失30000两）',
      power: '生命1700 气防1000 格挡22 回气1',
      attack: {},
      condition: '资质≤50',
      addition: '防御+2 内力上限+20',
      sect: '',
      internal: '',
      initiative: [
        '每时序回复2点生命',
        '每5时序回复1点内伤',
        '回合开始自动防御',
        '蓄力状态下集气速度增加30%',
        '防御状态下无法被杀气，被攻击35%概率触发“伺机而动”集气位置+100',
        '防御状态下被攻击时反震目标内伤15点',
        '免疫破绽',
        '被攻击进入防御状态，初始概率25%，生命越低概率越高',
      ],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可洗为长春不老功']}],
    },
    {
      id: 'shenZhaoGong',
      name: '神照功',
      cheat: '神照经',
      level: 2,
      get: '连城诀正线雪山剧情后狄云在队伍且道德≥80，天宁寺佛像背后获得',
      power: '生命1700 气防1000 格挡22 回气1',
      attack: {},
      condition: '内力≥500',
      addition: '防御+2 内力上限+20',
      sect: '',
      internal: '',
      initiative: [
        '首次被击退时，100%发动“神照功起死回生”复活，之后有6%的概率发动',
        '复活时恢复(70+天书数量×2)%的生命/耗损内力/耗损体力以及异常状态，集气值+500',
      ],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可洗为长生诀']}],
    },
    {
      id: 'haMaGong',
      name: '蛤蟆功',
      cheat: '',
      level: 2,
      get: '射雕正线牛家村第一战单挑胜欧阳锋的获胜奖励，邪线明霞岛剧情后获得',
      power: '生命1550 气防900 格挡22 回气1',
      attack: {},
      condition: '内力≥700',
      addition: '攻击+1防御+1 内力上限+20',
      sect: '',
      internal: '',
      initiative: [
        '每5时序恢复1点内伤，被攻击时受内伤减少30%',
        '蓄力必成功，同时进入防御状态，且下回合集气+321',
        '强化蓄力效果，伤害加成从25%提升至50%，气攻加成从600提升至1200',
        '时序增加1点怒气',
        '无其他内功护体时，必定触发蛤蟆功护体气防提升900点',
        '受攻击时概率触发“蛤蟆功.蓄力”，累计蓄力值（被一阳指攻击会降低蓄力值）',
        '蓄力值满100后，下次攻击时可发动“蟾震九天”，根据蓄力值高低追加大量气攻（1500-？）',
        '(蓄力值可以增加蛤蟆功的气防值)',
      ],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可洗为鲸息功']}],
    },
    {
      id: 'qianKunDaNuoYi',
      name: '乾坤大挪移',
      cheat: '',
      level: 2,
      get: '倚天光明顶地道，与成昆战斗后在阳顶天尸骨上获得',
      power: '生命1475 气防850 格挡22 回气1',
      attack: {},
      condition: '内力≥2000 资质≥50',
      addition: '防御+2 内力上限+20',
      sect: '',
      internal: '',
      initiative: [
        '内力高于对方时，被攻击50%概率触发“乾坤大挪移反弹”，反弹30%伤害',
        '被攻击，降低50%本次攻击所造成的封穴（可与其他同类效果乘法叠加）',
        '每时序额外回复1点流血',
        '被攻击，降低40%本次攻击所造成的内伤',
      ],
      peculiar: [
        {
          name: '万象天引',
          condition: '北冥神功+吸星大法+乾坤大挪移',
          effect: [
            '万象天引：反弹50%所受伤害和一切状态',
            '神罗天征：每三回合触发一次，将自身3~10格范围的目标拉到身前三格内的一个点重叠，并锁足一回合',
          ],
        },
      ],
    },
    {
      id: 'jianHuaGuiYi',
      name: '剑华皈壹',
      cheat: '',
      level: 2,
      get: '灵鹫宫战卓不凡后获得',
      power: '生命1475 气防850 格挡22 回气1',
      attack: {},
      condition: '内力≥400 御剑100 ',
      addition: '攻击+2 御剑+2 内力上限+40',
      sect: '',
      internal: '',
      initiative: ['行动后扣除5%最大内力', '使用剑法攻击时追加10%当前内力值伤害'],
      peculiar: [],
    },
    {
      id: 'xieHeShenJian',
      name: '血河神鉴',
      cheat: '',
      level: 2,
      get: '连城邪线雪山杀血刀老祖后获得',
      power: '生命1400 气防800 格挡22 回气1',
      attack: {},
      condition: '内力≥1100',
      addition: '攻击+1 防御+1 内力上限+20',
      sect: '',
      internal: '',
      initiative: ['高优先级提升10%伤害', '每5时序回1点内伤', '攻击时必定造成流血', '攻击时，恢复造成伤害10%的血量（单次攻击上限100点）'],
      peculiar: [{name: '一脉相承', condition: '', effect: ['可由血刀心法一脉相承', '可洗为天魔功']}],
    },
    {
      id: 'chuJieNeiGong',
      name: '初阶内功',
      cheat: '',
      level: 1,
      get: '',
      power: '  ',
      attack: {},
      condition: '',
      addition: '初阶内功对应门派高阶内功一脉相承',
      sect: '',
      internal: '',
      initiative: [],
      peculiar: [
        {name: '古墓心法', condition: '古墓收小龙女获得', effect: ['一脉相承 玉女心经']},
        {name: '全真心法', condition: '重阳宫挑战右下角全真弟子后获得', effect: ['一脉相承 先天功']},
        {name: '少林心法', condition: '少林寺挑战少林弟子后获得', effect: ['一脉相承 易筋经']},
        {name: '莲花功', condition: '丐帮挑战守门弟子后获得', effect: ['一脉相承 擒龙功']},
        {name: '华山心法', condition: '笑傲线高升客栈剧情后获得', effect: ['一脉相承 紫霞神功']},
        {name: '嵩山心法', condition: '嵩山派挑战守门弟子后获得', effect: ['一脉相承 寒冰真气']},
        {name: '血刀心法', condition: '连城线破庙挑战宝象后获得', effect: ['一脉相承 血河神鉴']},
        {name: '地火功', condition: '光明顶开宝箱获得', effect: ['一脉相承 圣火神功']},
        {name: '武当心法', condition: '武当派挑战右上练武弟子后获得', effect: ['一脉相承 太极神功']},
        {name: '小星罗功', condition: '击败凉州客栈的日月神教弟子获得', effect: []},
        {name: '八卦心法', condition: '商家堡', effect: []},
      ],
    },
  ],
};
