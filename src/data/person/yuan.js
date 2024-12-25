export default {
  name: '鸳鸯刀',
  list: [
    {
      id: 'xiaoZhongHui',
      name: '萧中慧',
      talent: [
        {name: '鸳鸯刀客', effect: ['使用夫妻刀法无误伤', '可装备专属武器鸯刀']},
        {name: '兰心蕙质', effect: ['修炼武功秘籍时，兵器值成长翻倍']},
      ],
      fortune: [],
    },
    {
      id: 'yuanGuanNan',
      name: '袁冠南',
      talent: [
        {name: '白衣书生', effect: ['萧中慧在场时，攻防提升100', '夫妻刀法威力+300，闪避+300']},
        {name: '白驹过隙', effect: ['15%概率闪避攻击并反击，生命越低，闪避率越高，最高35%闪避率']},
      ],
      fortune: ['获得夫妻刀法后，第二格武功洗夫妻刀法'],
    },
    {
      id: 'xiaoBanHe',
      name: '萧半和',
      talent: [
        {
          name: '晋阳大侠',
          effect: [
            '连击率与暴击率+50%',
            '攻击时必触发“混元一气”造成敌全体内伤。增加1000气功',
            '修炼葵花宝典无惩罚，可以使用葵花神功攻击',
            '笑傲邪战胜葵花尊者天内洗葵花神功',
          ],
        },
        {name: '混元炁', effect: ['自带“混元功”主运效果，混元功范围+1']},
        {name: '仁者无敌', effect: ['特效概率二次判定', '道德高于100时，免疫暴击、连击伤害']},
      ],
      fortune: ['笑傲邪战胜葵花尊者天内洗葵花神功'],
    },
    {
      id: 'renFeiYan',
      name: '任飞燕',
      talent: [
        {name: '欢喜冤家', effect: ['与林玉龙同时在场，攻防轻增加50']},
        {
          name: '玉堂飞燕',
          effect: ['攻击时附带轻功值2倍的杀气值', '被攻击时增加轻功值2倍的气防值', '使用夫妻刀法攻击时，附加（轻功值/2）的固定伤害'],
        },
      ],
      fortune: [],
    },
    {
      id: 'linYuLong',
      name: '林玉龙',
      talent: [
        {name: '欢喜冤家', effect: ['与任飞燕同时在场，攻防轻增加50']},
        {name: '诸法无我', effect: ['每行动一次，减伤增加5%，受到伤害减少5%（上限30%）']},
      ],
      fortune: [],
    },
    {
      id: 'zhuoTianXiong',
      name: '卓天雄',
      talent: [
        {name: '铁掌神鞭', effect: ['震天铁掌威力翻倍，呼延鞭法威力三倍', '使用震天铁掌10%概率击晕目标', '使用呼延鞭法大概率造成封穴']},
      ],
      fortune: [],
    },
    {
      id: 'zhouWeiXin',
      name: '周威信',
      talent: [{name: '铁鞭震八方', effect: ['呼延十八鞭2~5倍威力']}],
      fortune: [],
    },
  ],
};
