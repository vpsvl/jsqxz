export default {
  name: '连城诀',
  list: [
    {
      id: 'diYun',
      name: '狄云',
      talent: [
        {
          name: '赤心连城',
          effect: [
            '使用连城剑法必连击，如本次攻击造成伤害低于150，则追加一次连击（一轮追加上限3次）',
            '修炼血刀大法无惩罚，不会降低生命上限，使用血刀大法必暴击',
          ],
        },
        {
          name: '真名神照',
          effect: [
            '主运神照功/长生诀时拥有绝对气防',
            '神照功/长生诀复活无需运功，复活效果强化，恢复100%血量，并且立即行动',
            '神照功修炼至极，轻功+20',
            '使用武功绝招只需要60点怒气',
          ],
        },
      ],
      fortune: ['雪山剧情洗第二三格武功'],
    },
    {
      id: 'shuiSheng',
      name: '水笙',
      talent: [
        {name: '铃剑侠女', effect: ['使用连城剑法高连击']},
        {name: '似水柔情', effect: ['误伤队友时恢复其血量']},
      ],
      fortune: [],
    },
    {
      id: 'luTianShu',
      name: '陆天枢',
      talent: [
        {name: '仁义刀', effect: ['使用刀法必定单击，刀法威力1.5倍']},
        {name: '南四奇', effect: ['南四奇在场时，我方格挡和命中提升400']},
      ],
      fortune: [],
    },
    {
      id: 'liuChengFeng',
      name: '刘乘风',
      talent: [
        {name: '柔云剑', effect: ['被攻击时，将一半杀气转化为回血']},
        {name: '南四奇', effect: ['南四奇在场时，我方格挡和命中提升400']},
      ],
      fortune: [],
    },
    {
      id: 'shuiDai',
      name: '水岱',
      talent: [
        {name: '冷月剑', effect: ['增加64点防御，被攻击时降低640气攻']},
        {name: '南四奇', effect: ['南四奇在场时，我方格挡和命中提升400']},
      ],
      fortune: [],
    },
    {
      id: 'huaTieGan',
      name: '花铁干',
      talent: [
        {
          name: '中平神枪',
          effect: ['使用中平枪法时，气攻+1000', '行动前随机变化一个形象，获得相应天赋的第一格武功', '行动后集气速度提高一点，上限八十一点'],
        },
      ],
      fortune: [],
    },
    {
      id: 'xieDaoLaoZu',
      name: '血刀老祖',
      talent: [
        {name: '血刀老祖', effect: ['基础暴击率大幅度提高', '初始集气位置900，且移动+3格']},
        {name: '血海魅影', effect: ['击杀敌方后，被击杀者满状态复活，行动后获得魅惑状态9999时序']},
      ],
      fortune: [],
    },
    {
      id: 'qiChangFa',
      name: '戚长发',
      talent: [
        {name: '铁索横江', effect: ['基础连击率大幅提高', '【闭气离墙.起死回生】，战斗中可以复活一次']},
        {name: '绝处逢生', effect: ['自身范围内一格25%概率免受攻击']},
      ],
      fortune: [],
    },
    {
      id: 'baoXiang',
      name: '宝象',
      talent: [
        {name: '血刀高手', effect: ['血刀门武功连击率+20%，暴击率+20%']},
        {name: '一龙一象', effect: ['提升10%伤害，降低10%受到的伤害']},
      ],
      fortune: [],
    },
  ],
};
