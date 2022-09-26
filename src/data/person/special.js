export default {
  name: '特殊',
  list: [
    {
      id: 'luJian',
      name: '陆渐',
      talent: [
        {name: '金刚门人', effect: ['攻击时为自己添加一个100时序“金刚法相”增益BUFF：攻击概率触发大金刚神力，无视绝对气防+1000气攻']},
        {
          name: '三十二身相',
          effect: [
            '攻击时或被攻击时概率触发持续100时序“一合相”：减伤15%',
            '“一合相”存在期间，会发动以下身相：',
            '[神鱼相]：攻击时概率追加一次连击，暴怒必连',
            '[白毫相] ：被攻击时概率只受到100点气攻',
            '[雀母相]：被攻击时概率减伤50点',
            '[大自在相]：被攻击时概率+200集气',
          ],
        },
      ],
      fortune: [],
    },
    {
      id: 'kouZhong',
      name: '寇仲',
      talent: [
        {name: '井月八法', effect: ['每个刀法到极领悟一招，每一招加暴击伤害/暴击概率/加气攻(上限8个)']},
        {name: '大唐双龙', effect: ['阳内攻击必灼伤，概率点燃', '无视内属修炼刀法']},
        {name: '傲世狂刀', effect: ['刀法威力+200，增加自身20%耍刀系数的攻击和防御']},
      ],
      fortune: [],
    },
    {
      id: 'xuZiLing',
      name: '徐子陵',
      talent: [
        {name: '佛道双修', effect: ['少林武当的武功可无视条件修炼']},
        {name: '大唐双龙·冰', effect: ['免疫冰封，攻击必冰封']},
        {
          name: '九字真言',
          effect: [
            '行动前概率触发九字真言其中的一种或多种，随天书跟实战的增加而增加触发最大数量',
            '※临-「不动根本印」：减伤50点',
            '※兵-「大金刚轮印」：破防40%',
            '※斗-「外狮子印」：气攻提升800',
            '※者-「内狮子印」：气防提升800',
            '※列-「外缚印」：击中移动减3',
            '※阵-「内缚印」：击中目标内力-200',
            '※皆-「智拳印」：必击中破绽',
            '※在-「日轮印」：攻击必灼烧',
            '※前-「宝瓶印」：攻击范围扩大',
          ],
        },
      ],
      fortune: [],
    },
    {
      id: 'xiaoQiuShui',
      name: '萧秋水',
      talent: [
        {
          name: '神州大侠',
          effect: [
            '修炼辟邪剑法与葵花宝典没有惩罚，自带“忘情天书”特效',
            '绝技【惊天一剑】：战胜三名剑术名家，暴怒时可使用“天剑”绝技，剑法攻击无视敌方防御30%，无视闪避，追加200点伤害',
          ],
        },
        {name: '剑气飞纵', effect: ['连击不减伤害，攻击范围+1', '攻击时不随距离减伤害，目标距离越远，伤害越高']},
        {name: '剑术通神', effect: ['剑法威力+200，增加自身20%御剑系数的攻击和防御']},
      ],
      fortune: [],
    },
    {
      id: 'siKongZhaiXing',
      name: '司空摘星',
      talent: [
        {name: '盗王之王', effect: ['攻击偷取敌方身上的物品', '增加敌方存活人数*5的集气速度', '行动后可再次移动']},
        {name: '千变万幻', effect: ['挨打增加集气速度，集气上限80，集气不受基础异常状态影响']},
      ],
      fortune: [],
    },
    {
      id: 'xiMenChuiXue',
      name: '西门吹雪',
      talent: [
        {name: '剑道巅峰', effect: ['击败谢云流领悟“剑道巅峰·五方行尽”，概率再行动一次']},
        {name: '破苍穹', effect: ['攻击时发动“剑道化身·破苍穹”，无视敌方防御50%']},
        {name: '剑神', effect: ['进战满集气位置+1000，每个剑法到极减伤3% 增伤3%']},
      ],
      fortune: [
        '华山后山对话谢无悠后，上台阶左走对话谢云流，战胜后第一格洗为斩流剑术，第二格洗为太虚剑意，并获得对应秘籍'
      ],
    },
    {
      id: 'liXunHuan',
      name: '李寻欢',
      talent: [
        {
          name: '小李探花',
          effect: [
            '敌人移动-1，自身移动+2，30%躲避攻击',
            '战斗胜利获得暗器，7书领悟暗器为范围攻击',
            '特色指令【飞刀】：100时序暗器攻击暴击5~8倍，华山觉醒后20%暴击5倍~10倍，攻击必中，每次开启消耗体力20，内力1000',
          ],
        },
        {name: '惊才绝艳', effect: ['特效触发概率+8点，被攻击集气不会少于300']},
      ],
      fortune: [],
    },
    {
      id: 'huangChang',
      name: '黄裳',
      talent: [
        {name: '千手神通', effect: ['指法威力+200，增加自身20%指法系数的攻击和防御']},
        {
          name: '九阴至尊',
          effect: [
            '九阴神功自动运功',
            '【易筋锻骨】”：免疫封穴，免疫暴击伤害',
            '【天之道】：攻击时概率触发“天之道”附加目标生命最大值5%的伤害',
            '【大道归藏】(畅想专属)：无视条件修炼武功，所有武功都可以到极',
          ],
        },
        {name: '九阴神爪', effect: ['九阴神爪极意必两连，40%概率三连，暴怒必三连']},
      ],
      fortune: [],
    },
    {
      id: 'daMo',
      name: '达摩',
      talent: [
        {name: '菩提金身', effect: ['受到的连击和暴击伤害减少20%']},
        {name: '万佛朝宗', effect: ['拥有绝对气防', '每五回合攻击时触发万佛朝宗，造成目标当前生命值10%伤害，并减少内力20%']},
        {
          name: '毗婆舍那',
          effect: [
            '达摩受到攻击不会产生怒气，但每时序增加一点怒气',
            '攻击会减少目标最大生命值，每次攻击减少2%',
            '达摩每回合行动前，内力，体力，怒气，生命只要一项恢复到满状态，生命，内力，体力随机一项回复到满状态',
          ],
        },
        {name: '一苇渡江', effect: ['一苇渡江轻功自动运功']},
        {
          name: '五蕴皆空',
          effect: [
            'BOSS状态时亦复如是：被攻击时概率触发，把受到的伤害完全反弹给对方（包括暗器伤害）',
            '受想行识：行动前概率触发，敌方会随机获得debuff',
          ],
        },
      ],
      fortune: [],
    },
    {
      id: 'liangXiao',
      name: '梁萧',
      talent: [
        {name: '谐之道', effect: ['自身不会有破绽，暴怒时发动必中破绽，击中敌方破绽高概率造成敌方5时序集气暂停']},
        {
          name: '西昆仑',
          effect: [
            '灵鳖步和十方步加强',
            '主运鲸息功或使用碧海惊涛掌攻击时可以触发六大奇劲之一：',
            '陷空力：忽视绝对气防+破防40%',
            '滔天炁：触发大范围伤害',
            '生灭道：攻击后触发霸体一回合',
            '漩涡劲：增加一次连击，最多增加两次',
            '阳流：必冰封必灼烧',
            '滴水劲：必暴击',
          ],
        },
        {name: '星罗散手', effect: ['用拳掌攻击时，必触发“星罗散手”给对方造成封穴']},
      ],
      fortune: ['灵鳖岛领悟鲸息功与碧海惊涛掌，第一格洗碧海惊涛掌，第二格洗鲸息功，第三格洗十方步十级'],
    },
    {
      id: 'xieYunLiu',
      name: '谢云流',
      talent: [
        {name: '剑术通神', effect: ['剑法威力+200，增加自身20%御剑系数的攻击和防御']},
        {name: '东瀛剑魔', effect: ['被攻击的目标不会增加怒气']},
        {name: '剑魔再临', effect: ['玄铁剑法攻击时50%概率发动两种特效之一：', '天极剑渊：破防50%', '破尽天下：无视气防，气攻+800']},
      ],
      fortune: [],
    },
    {
      id: 'xieWuYou',
      name: '谢无悠',
      talent: [
        {name: '天元剑气', effect: ['使用剑系武功攻击时，敌方防御减少75%']},
        {name: '无悠水镜', effect: ['受伤害时的一半伤害转化为自身生命、内力、体力']},
        {name: '剑心通明', effect: ['剑法攻击必中']},
      ],
      fortune: [],
    },
    {
      id: 'guiJian',
      name: '诡剑',
      talent: [
        {name: '剑法无极', effect: ['剑法攻击无视目标10%防御，每学会一门剑法至极，剑法破防效果增加2%']},
        {name: '神游太虚', effect: ['免疫正面90度攻击，90~180度角30%免疫攻击（暴怒必定免疫）', '移动独特动画']},
        {name: '秘剑诡姬', effect: ['剑术攻击概率不消耗能量']},
      ],
      fortune: [],
    },
    {
      id: 'meiChangSu',
      name: '梅长苏',
      talent: [
        {name: '琅琊公子', effect: ['战斗中可以自由切换林殊/梅长苏两个身份']},
        {
          name: '冠绝江左',
          effect: [
            '敌方每5点冰封值减少攻击伤害1%',
            '自带“麒麟不动”：每本天书可以幻化敌方一门武功',
            '进战斗100点冰封值和灼烧值，每次行动后自身增加10点冰封值，5点灼烧值',
            '当冰封值与灼烧值为0时“寒火毒发作”，发动“偷天换日”：恢复生命/内力到最大值，冰封值增加100，灼烧值增加50，其他状态清零。每100时序发动一次',
          ],
        },
      ],
      fortune: [],
    },
    {
      id: 'jiuShen',
      name: '酒神',
      talent: [
        {name: '酒神迷踪', effect: ['被攻击时有30%概率发动“酒神迷踪步”闪避']},
        {name: '酒神', effect: ['初始暗器200，暗器必定1倍伤害', '喝酒buff有特殊攻击特效', '休息时必定蓄力防御']},
        {
          name: '酒神八杯',
          effect: [
            '羊脂白玉杯：此杯极其珍贵，可卖出2万两',
            '犀角杯：战斗中每次喝酒集气+4点，下回合集气位置提升',
            '古藤杯：战斗结束随机获得一颗药（灵芝、地灵除外）',
            '青铜爵：战斗结束随机获得一坛酒',
            '夜光杯：连击率大幅降低，暴怒必定连击',
            '琉璃杯：5%概率触发“酒神迷踪步”闪避,喝酒后概率增加30%',
            '古瓷杯：被攻击时免疫破绽，暴怒必中破绽；攻击时无法出破绽，暴怒必中',
            '翡翠杯：免疫冰冻和灼烧',
          ],
        },
      ],
      fortune: [
        '获得辟邪剑谱，第一格洗辟邪剑法 一 ，并洗天外',
        '笑傲正邪打败东方不败，第二个洗葵花宝神功 一 ，并洗天内',
        '可装备绣花针（必须接受惩罚）',
      ],
    },
    {
      id: 'nieFeng',
      name: '聂风',
      talent: [
        {name: '风中之神', effect: ['轻功成长加倍，装备附加的轻功和集气加成双倍']},
        {name: '傲寒六诀', effect: ['使用刀法时周身10格范围敌人冰封20点，概率触发傲寒六诀冻结10时序', '被敌人攻击概率冻结敌人']},
        {name: '入魔', effect: ['暴怒时有一定概率进入入魔状态，免疫封穴杀气，吸血20%（上限200），且必连击概率三连击。暴怒结束入魔结束。']},
      ],
      fortune: [],
    },
    {
      id: 'huaManLou',
      name: '花满楼',
      talent: [
        {name: '妙手仁心', effect: ['只有暴怒状态才能攻击，药物使用效果双倍']},
        {name: '流云飞袖', effect: ['被攻击30%概率抵挡伤害，且进行反击，伤害为120%，不可与斗转同时触发']},
        {name: '听声辩位', effect: ['命中+500']},
      ],
      fortune: [],
    },
    {
      id: 'wuLuQi',
      name: '五陆柒',
      talent: [
        {name: '以气运剪', effect: ['以大剪刀对目标追加部分气攻值的伤害']},
        {
          name: '魔刀千刃',
          effect: [
            '战斗中首次被击退可复活一次，变身首席暗影刺客，立即行动',
            '第一格武功变为魔刀千刃，无视敌方50%防御和系数',
            '如击退至少一名敌人，可再次行动',
          ],
        },
        {name: '最强发型师', effect: ['大剪刀威力提升567，追加气攻567']},
      ],
      fortune: [],
    },
    {
      id: 'dianFanGuo',
      name: '电饭锅',
      talent: [
        {
          name: '锅王之王',
          effect: [
            '被攻击时，25%概率免疫攻击',
            '被攻击时，25%概率由其他目标承受伤害',
            '攻击时，25%概率由电饭锅替目标承受伤害',
            '烹饪料理可获得双倍食物',
          ],
        },
      ],
      fortune: [],
    },
  ],
};
