export default {
  name: '天龙八部',
  list: [
    {
      id: 'qiaoFeng',
      name: '乔峰',
      talent: [
        {
          name: '狂龙天征',
          effect: [
            '使用降龙十八掌，必定发动【降龙·极意】',
            '使用降龙十八掌，40%概率发动【降龙·三叠浪】，暴怒时必定发动',
            '使用降龙十八掌攻击无误伤',
            '降龙十八掌耗内降低50%（与天赋外功效果叠加，降低75%内力消耗）',
          ],
        },
        {name: '越战越勇', effect: ['增加伤害和减少受到的伤害，气血越少增加的越多，最少15%，最多35%']},
        {name: '奋英雄怒', effect: ['攻击时必定造成暴击并有红字特效', '集气速度+8']},
      ],
      fortune: ['天龙正线挑战扫地僧获胜后，可获得专属武器[音箱]'],
    },
    {
      id: 'xuZhu',
      name: '虚竹',
      talent: [
        {name: '逍遥掌门', effect: ['有特色指令：生死符', '擂鼓山剧情后，自带北冥真气护体', '天山折梅手修炼到极，资质变为50']},
        {name: '折梅手', effect: ['面板上每多一个武功到极，天山折梅手威力+50']},
      ],
      fortune: ['擂鼓山支线剧情，洗第一二格武功', '灵鹫宫观看壁画后，资质+10，第三格武功洗八荒六合功，可选择是否将天赋内功洗为八荒六合功'],
    },
    {
      id: 'duanYu',
      name: '段誉',
      talent: [
        {name: '六脉真传', effect: ['使用六脉神剑时出绝招概率+20%', '六脉神剑耗内降低50%（与天赋外功效果叠加，降低75%内力消耗）']},
        {name: '磊落仁心', effect: ['内力上限9999']},
        {name: '六脉玄机', effect: ['使用六脉神剑概率触发四招绝招，概率随实战增加，每100实战增加5%概率']},
      ],
      fortune: ['无量山洞剧情，第一格武功洗北冥神功，第二格洗凌波微步', '天龙寺剧情后，第三格武功洗六脉神剑'],
    },
    {
      id: 'muRongFu',
      name: '慕容复',
      talent: [
        {name: '姑苏慕容', effect: ['修炼斗转星移无需兵器值条件', '斗转星移触发概率+10%']},
        {name: '离合参商', effect: ['斗转星移发动概率100%', '斗转反击时，无视兵器值需求必定发动【离合参商】']},
      ],
      fortune: ['天龙八部邪线挑战扫地僧胜利后第二格以及天赋内功洗易筋经，领悟黑级浮屠'],
    },
    {
      id: 'wangYuYan',
      name: '王语嫣',
      talent: [
        {name: '武中无相', effect: ['无视限制条件修炼武学秘籍（自宫除外）']},
        {name: '琅嬛仙子', effect: ['在场时，我方全体攻击范围增加一格']},
        {name: '御法绝尘', effect: ['在场时，敌方非必触发特效概率降低5%，我方概率提高5%']},
      ],
      fortune: ['获得凌波微步后，天赋轻功洗为凌波微步'],
    },
    {
      id: 'aZi',
      name: '阿紫',
      talent: [
        {name: '曼珠沙华', effect: ['每击退一个敌方，自身气攻气防提高200点']},
        {name: '引蛊', effect: ['行动前50%概率使用蛊毒刺激自身，自身每时序损失1%最大血量，此状态下自身血量越低，伤害、集气越高']},
      ],
      fortune: [],
    },
    {
      id: 'dingChunQiu',
      name: '丁春秋',
      talent: [
        {
          name: '星宿老怪',
          effect: ['攻击时，追加等同敌方中毒量的伤害', '回合结束时按中毒量扣除敌方生命', '连环腐尸毒必出极意，引爆目标身上毒素'],
        },
      ],
      fortune: [],
    },
    {
      id: 'youTanZhi',
      name: '游坦之',
      talent: [
        {
          name: '冰毒怪客',
          effect: [
            '攻击带毒340点',
            '冰蚕毒掌随机附加1~3层冰冻状态，每层减缓1%集气速度，上限50层',
            '攻击时，如敌方身上的冰封大于50，则有60%概率将其冻结10时序',
          ],
        },
      ],
      fortune: [],
    },
    {
      id: 'jiuMoZhi',
      name: '鸠摩智',
      talent: [
        {
          name: '大轮明王',
          effect: ['学会小无相功后，再学任何武功系数需求降低20', '特色指令【幻化】，使用小无相功模拟天下武学，必须要拥有对应的秘籍'],
        },
        {name: '大轮密宗', effect: ['火焰刀法【大轮密宗.火焰刀】发动概率100%']},
      ],
      fortune: [],
    },
    {
      id: 'muRongBo',
      name: '慕容博',
      talent: [
        {name: '龙城血脉', effect: ['斗转必命中']},
        {name: '离合参商', effect: ['斗转星移发动概率100%', '斗转反击时，无视兵器值需求必定发动【离合参商】']},
        {name: '梦幻星辰', effect: ['斗转反击时，无视兵器值需求必定发动离合参商反击两次']},
      ],
      fortune: [],
    },
    {
      id: 'xiaoYuanShan',
      name: '萧远山',
      talent: [
        {name: '杀破狼', effect: ['开场进入杀破狼状态：三回合内保持满怒，基础攻轻防提升50%，杀气提高2000']},
        {name: '魔神降临', effect: ['每3回合进入魔神降临状态50时序，怒气值不减少']},
      ],
      fortune: [],
    },
    {
      id: 'saoDiLaoSeng',
      name: '扫地老僧',
      talent: [
        {name: '天佛化生', effect: ['内力上限9999，攻击无误伤', '被攻击100%触发“天地独尊”，完全免疫杀气']},
        {name: '无形气墙', effect: ['被攻击时概率触发不动如山，触发不动如山时，额外的伤害将转化为护盾']},
        {name: '放下屠刀', effect: ['攻击时30%的概率触发【放下屠刀】降低目标伤害30%，持续一回合，无法叠加']},
      ],
      fortune: [],
    },
    {id: 'suXingHe', name: '苏星河', talent: [{name: '聪辩先生', effect: ['命中率+20%']}], fortune: []},
    {
      id: 'wuYaZi',
      name: '无崖子',
      talent: [
        {name: '逍遥掌门', effect: ['内力上限9999', '被攻击时必定发动北冥真气护体']},
        {name: '折梅手', effect: ['面板上每多一个武功到极，天山折梅手威力+50']},
        {name: '北冥极渊', effect: ['主动攻击触发北冥神功吸内时，概率吸取生命值']},
      ],
      fortune: [],
    },
    {
      id: 'tianShanTongMu',
      name: '天山童姥',
      talent: [
        {name: '唯我独尊', effect: ['八荒六合功特效必触发']},
        {name: '不老长春', effect: ['被攻击时恢复80点生命']},
        {name: '转瞬红颜', effect: ['每过199时序，自动回满血、体、内，并解除自身异常状态']},
      ],
      fortune: [],
    },
    {
      id: 'liQiuShui',
      name: '李秋水',
      talent: [
        {name: '秋水无尘', effect: ['自身集气速度不受基础异常状态的影响']},
        {name: '虎爪绝户', effect: ['暴怒时使用虎爪绝户手触发奥义，对男性造成毁灭性创伤']},
      ],
      fortune: [],
    },
    {
      id: 'duanYanQing',
      name: '段延庆',
      talent: [
        {name: '恶贯满盈', effect: ['加力/护体/出招概率大幅提高', '无法休息']},
        {name: '四大恶人', effect: ['暴击伤害提升50%']},
      ],
      fortune: [],
    },
    {
      id: 'yeErNiang',
      name: '叶二娘',
      talent: [
        {name: '无恶不作', effect: ['使用黄沙万里鞭必双击']},
        {name: '四大恶人', effect: ['暴击伤害提升50%']},
      ],
      fortune: [],
    },
    {
      id: 'yueLaoSan',
      name: '岳老三',
      talent: [
        {name: '南海鳄神 ', effect: ['暴怒时大剪刀附带撕裂效果']},
        {name: '四大恶人', effect: ['暴击伤害提升50%']},
      ],
      fortune: [],
    },
    {
      id: 'yunZhongHe',
      name: '云中鹤',
      talent: [{name: '穷凶极恶', effect: ['攻击女性时，回复造成伤害10%的血量（单次吸血上限100点）']}],
      fortune: [],
    },
    {
      id: 'aZhu',
      name: '阿朱',
      talent: [
        {name: '千面玲珑', effect: ['使用【易容】指令，只受到误伤']},
        {name: '珠落玉盘', effect: ['行动后提升我方全体100点集气']},
      ],
      fortune: [],
    },
    {
      id: 'aBi',
      name: '阿碧',
      talent: [
        {name: '碧落情天', effect: ['与慕容复同队，替慕容复承担所有伤害']},
        {name: '吴侬软语', effect: ['行动前提升我方全体100点集气']},
      ],
      fortune: [],
    },
    {
      id: 'zhongLing',
      name: '钟灵',
      talent: [{name: '毓秀灵姝', effect: ['攻击时必定造成流血', '闪电貂攻击时概率偷窃敌方携带的物品并对其强制上毒50点']}],
      fortune: ['云岭洞找到闪电貂，第一格武功洗闪电貂', '天龙正线，无量山洞收段誉，第一格武功洗六脉神剑，天赋外功洗为六脉神剑'],
    },
    {
      id: 'kuRong',
      name: '枯荣',
      talent: [{name: '天龙禅师', effect: ['使用一阳指高概率连击', '灼烧恢复能力加倍（时序恢复2点灼烧）']}],
      fortune: [],
    },
    {
      id: 'xuanCi',
      name: '玄慈',
      talent: [
        {name: '伏虎罗汉', effect: ['阳内时防御力+20%', '阴内时攻击力+20%', '调和内时轻功+20%']},
        {name: '一空到底', effect: ['暴怒时使用掌法攻击使敌我双方集气倒退10时序']},
      ],
      fortune: [],
    },
    {
      id: 'xiaoYaoZi',
      name: '逍遥子',
      talent: [
        {
          name: '逍遥祖师',
          effect: [
            '必发动“梅花三弄”特效之一',
            '梅花一弄：造成散功30时序，不可主运内功',
            '梅花二弄：减少敌方当前内力值的5%',
            '梅花三弄：忽视绝对气防',
          ],
        },
        {name: '不老长春', effect: ['减伤30%伤害并用双倍内力抵消伤害值']},
      ],
      fortune: ['击败无崖子直接激活“逍遥御风”(不需学小无相/八荒/北冥)'],
    },
    {
      id: 'xueMuHua',
      name: '薛慕华',
      talent: [{name: '阎王敌', effect: ['医疗上限500点', '战斗中满血复活自己或者同伴一次']}],
      fortune: [],
    },
    {
      id: 'liQingLu',
      name: '李清露',
      talent: [
        {name: '清露寒梦', effect: ['攻击无视敌方防御15%']},
        {name: '寒露清梦', effect: ['特色指令【云梦】，可自由切换第一格武功为寒袖拂穴/白虹掌力']},
        {name: '天仙锁魂', effect: ['敌方每回合30%概率附加虚弱状态2回合']},
      ],
      fortune: ['擂鼓山获得小无相功第三格洗小无相功，天内洗小无相功', '灵鹫宫获得八荒第四个洗八荒六合功，可以选择天内是否洗八荒六合功'],
    },
    {
      id: 'zhuoBuFan',
      name: '卓不凡',
      talent: [{name: '十里坡剑神', effect: ['每行动一次，攻击效果提升1%']}],
      fortune: [],
    },
    {
      id: 'xuanCheng',
      name: '玄澄',
      talent: [
        {name: '十三绝神僧', effect: ['少林寺武学无条件修炼']},
        {name: '佛门无双', effect: ['少林寺所有武功威力+300']},
        {name: '菩提金身', effect: ['受到的连击和暴击伤害减少20%']},
        {name: '无量禅震', effect: ['使用伏魔杖法必定暴击', '攻击如被闪避则追加一次攻击', '伏魔杖法必暴击，追加内伤，并追加内伤值伤害']},
      ],
      fortune: [],
    },
    {
      id: 'duanSiPing',
      name: '段思平',
      talent: [
        {
          name: '婆娑双树',
          effect: [
            '被攻击概率吸收80%的伤害，附加在下回合攻击中，攻击时概率吸收伤害的80%为自身增加护盾',
            '暴怒后触发【金毗罗陀】清除范围所有敌人身上的怒气',
          ],
        },
        {name: '六脉玄机', effect: ['使用六脉神剑概率触发四招绝招，概率随实战增加，每100实战增加5%概率']},
      ],
      fortune: [],
    },
  ],
};
