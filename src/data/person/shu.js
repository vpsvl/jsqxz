export default {
  name: '书剑恩仇录',
  list: [
    {
      id: 'huoQingTong',
      name: '霍青桐',
      talent: [
        {name: '翠羽黄衫', effect: ['在场时，我方全体基础防御+20%']},
        {name: '巾帼之才', effect: ['每二个回合行动前，体力大于15内力大于500时，使我方全体集气+200']},
      ],
      fortune: [],
    },
    {
      id: 'chenJiaLuo',
      name: '陈家洛',
      talent: [
        {name: '天池红花', effect: ['攻击时有30%概率直接击中破绽，20%概率击中敌人后减少对方一格气力']},
        {name: '庖丁解牛', effect: ['攻击时有50%概率无视敌方30%防御']},
      ],
      fortune: [],
    },
    {
      id: 'zhangZhaoZhong',
      name: '张召重',
      talent: [
        {name: '火手判官', effect: ['攻击必定内伤，所造成内伤效果加倍']},
        {name: '勇猛精进', effect: ['我方全体攻击效果提高10%']},
      ],
      fortune: [],
    },
    {
      id: 'wenTaiLai',
      name: '文泰来',
      talent: [
        {
          name: '奔雷手',
          effect: [
            '时序增加1点怒气，半血时序增加2点怒气',
            '暴怒攻击触发雷动九天，为目标添加一层雷音buff，对大于三层雷音buff目标击晕一回合',
          ],
        },
        {name: '否极泰来', effect: ['每过100时序激活一次【否极泰来】，免疫死亡伤害10时序']},
      ],
      fortune: [],
    },
    {
      id: 'wuChen',
      name: '无尘',
      talent: [
        {name: '追魂夺命剑', effect: ['生命值低于50%时连击率两倍，生命值低于25%时连击率三倍']},
        {name: '连环迷踪腿', effect: ['行动后50%概率使用“连环迷踪腿”攻击周身三格敌人，造成100点伤害']},
        {name: '剑术通神', effect: ['剑法威力+200，增加自身20%御剑系数的攻击和防御']},
      ],
      fortune: [],
    },
    {
      id: 'zhaoBanShan',
      name: '赵半山',
      talent: [{name: '千臂如来', effect: ['初始暗器值200点', '战斗胜利后随机获得暗器']}],
      fortune: [],
    },
    {
      id: 'luoBing',
      name: '骆冰',
      talent: [{name: '鸳鸯刀客', effect: ['使用夫妻刀法无误伤', '我方全体命中+200']}],
      fortune: [],
    },
    {
      id: 'changHeZhi',
      name: '常赫志',
      talent: [{name: '黑无常', effect: ['敌方格挡-200，命中-100']}],
      fortune: [],
    },
    {
      id: 'changBoZhi',
      name: '常伯志',
      talent: [{name: '白无常', effect: ['我方格挡+200，命中+100']}],
      fortune: [],
    },
    {
      id: 'chenZhengDe',
      name: '陈正德',
      talent: [
        {name: '天山双鹰', effect: ['三分剑法必定三连，连击伤害降低15%', '三分剑法威力+500']},
        {name: '鹰飞九天', effect: ['鹰爪功必定内伤', '轻功+100']},
      ],
      fortune: [],
    },
    {
      id: 'tianJing',
      name: '天镜',
      talent: [
        {name: '诸行无常', effect: ['可使用内功攻击，武功范围+1']},
        {name: '佛笑伽蓝', effect: ['袈裟伏魔功攻击连击率+50%，暴击率+50%']},
        {name: '天佛降世', effect: ['战斗中可以复活一次，复活后免疫内伤，免疫暴击伤害']},
      ],
      fortune: [],
    },
    {
      id: 'luQingFei',
      name: '陆青菲',
      talent: [
        {name: '武当高手', effect: ['武当派武功连击率+10%，暴击率+10%']},
        {name: '绵里针', effect: ['被攻击时20%概率通关四两拨千斤化解，并用暗器反击敌人']},
      ],
      fortune: [],
    },
    {
      id: 'yuWanTing',
      name: '于万亭',
      talent: [
        {name: '总舵主', effect: ['我方每存活一个人，攻击+5%']},
        {name: '血海魅影', effect: ['击杀敌方后，被击杀者满状态复活，行动后获得魅惑状态9999时序']},
      ],
      fortune: [],
    },
    {
      id: 'liYuanZhi',
      name: '李沅芷',
      talent: [
        {name: '小魔女', effect: ['敌方气攻伤害减少20%', '敌方命中减10%']},
        {name: '芙蓉金针', effect: ['攻击附带暗器系数的真实伤害']},
      ],
      fortune: ['获得柔云剑法/无极玄功拳，第一/二格洗对应武功', '获得纯阳无极功第三格洗梯云纵，天轻洗梯云纵'],
    },
    {
      id: 'tianHong',
      name: '天虹',
      talent: [
        {name: '少林长老', effect: ['少林武学连击率+40%，暴击率+40%，威力+400']},
        {name: '诸法无我', effect: ['每行动一次，自身伤害+5%，受到的伤害-5%（上限30%）']},
        {name: '悲天佛怜', effect: ['般若掌攻击范围变为点，威力翻倍', '生命值低于50%拥有绝对气防']},
      ],
      fortune: [],
    },
    {
      id: 'yuanShiXiao',
      name: '袁士宵',
      talent: [
        {name: '玉面孟尝', effect: ['战场上我方女性角色越多，其伤害效果越高']},
        {name: '天池怪侠', effect: ['被攻击概率转移杀气值给攻击者', '百花错拳威力+600']},
        {name: '博通百家', effect: ['修炼所有武功需求-20，修炼所有武功无视内力属性 ']},
      ],
      fortune: [],
    },
    {
      id: 'yuanShang',
      name: '元伤',
      talent: [{name: '少林高僧', effect: ['少林武学连击率+30%，暴击率+30%']}],
      fortune: [],
    },
    {
      id: 'yuanBei',
      name: '元悲',
      talent: [{name: '少林堂主', effect: ['少林武学连击率+30%，暴击率+30%']}],
      fortune: [],
    },
    {
      id: 'aFanTi',
      name: '阿凡提',
      talent: [
        {name: '西域战神', effect: ['拥有专属坐骑毛驴', '休息时自带蓄力兼防御效果']},
        {name: '隔空点穴', effect: ['造成封穴时，封穴增加10点', '被攻击时对目标造成10点封穴']},
        {name: '悬权而动', effect: ['移动格数+3，攻击后可以再次移动']},
      ],
      fortune: [],
    },
  ],
};
