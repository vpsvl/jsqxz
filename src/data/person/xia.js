export default {
  name: '侠客行',
  list: [
    {
      id: 'shiPoTian',
      name: '石破天',
      talent: [
        {
          name: '混沌太玄',
          effect: [
            '可使用太玄神功攻击，太玄神功耗内降低50%（与天赋外功效果叠加，降低75%内力消耗）',
            '被攻击时，有50%几率触发太玄反震，对攻击方造成10点封穴',
            '被攻击时，有30%几率将受到伤害的50%转化为回血',
          ],
        },
        {name: '石破天惊', effect: ['觉醒后太玄消耗减半', '学有罗汉伏魔功，攻击时必出“罗汉伏魔”特效, 且效果额外增强10%']},
        {name: '名相皆无', effect: ['内力上限9999', '计算加力/护体/出招几率时必定开启二次判定']},
      ],
      fortune: ['侠客行正线-侠客岛挑战岛主剧情，第二格武功洗太玄神功，天赋内功洗为太玄神功'],
    },
    {
      id: 'dingDang',
      name: '丁当',
      talent: [
        {name: '丁丁当当', effect: ['敌方全体集气-5', '击必灼烧', '击败丁不三丁不四，金乌刀法威力+300，只学金乌刀法可触发举火燎原']},
        {name: '井月八法', effect: ['每个刀法到极领悟一招，每一招加暴击伤害/暴击概率/加气攻(上限8个)']},
      ],
      fortune: [],
    },
    {
      id: 'baiXiu',
      name: '白绣',
      talent: [
        {name: '冰川天女', effect: ['敌方全体集气-5', '攻击必冰封，冰封超过50机率冻结目标', '追加冰封值的真实伤害，自身免疫冰封']},
        {name: '雪花神剑', effect: ['雪山剑法威力翻倍', '攻击时概率触发“雪花神剑”，增加杀气，暴怒必触发']},
      ],
      fortune: [],
    },
    {
      id: 'longDaoZhu',
      name: '龙岛主',
      talent: [{name: '侠客岛主', effect: ['攻击效果提升20%', '使用任何武功高几率造成封穴', '主运太玄神功不会触发太玄之重']}],
      fortune: [],
    },
    {
      id: 'muDaoZhu',
      name: '木岛主',
      talent: [{name: '侠客岛主', effect: ['防御效果提升20%', '使用任何武功高几率造成封穴', '主运太玄神功不会触发太玄之轻']}],
      fortune: [],
    },
    {
      id: 'zhangSan',
      name: '张三',
      talent: [{name: '赏善使者', effect: ['道德高于59行动后对周身五格范围内队友进行治疗', '攻击时高几率附带灼烧']}],
      fortune: [],
    },
    {
      id: 'liSi',
      name: '李四',
      talent: [{name: '罚恶使者', effect: ['道德低于61，行动后对周身五格范围内敌人施毒', '攻击时高几率附带冰封']}],
      fortune: [],
    },
    {
      id: 'baiWanJian',
      name: '白万剑',
      talent: [
        {name: '雪山掌门', effect: ['雪山派武功连击率+40%，暴击率+40%，武功威力+400']},
        {name: '气寒西北', effect: ['攻击必冰封，冰封超过50冻结目标', '追加冰封值的真实伤害，自身免疫冰封']},
      ],
      fortune: [],
    },
    {
      id: 'beiHaiShi',
      name: '贝海石',
      talent: [
        {name: '老谋深算', effect: ['每过999时序，自动回满血内体并清除自身异常状态']},
        {name: '妙手回春', effect: ['被攻击时，10%几率将受到的伤害转化为回血']},
      ],
      fortune: [],
    },
    {
      id: 'xieYanKe',
      name: '谢烟客',
      talent: [
        {
          name: '摩天居士',
          effect: [
            '自带三枚玄铁令',
            '令一:天下人负我,自身受到的伤害增加20%',
            '令二：我负天下人，免疫一次伤害且恢复所受伤害的血量',
            '令三：行止由心，两次行动',
            '行动时给自身添加一枚玄铁令效果',
          ],
        },
        {name: '碧针清掌', effect: ['行动后使用碧针清掌攻击周身七格敌人，造成100点伤害']},
      ],
      fortune: [],
    },
    {
      id: 'dingBuSan',
      name: '丁不三',
      talent: [{name: '一日不过三', effect: ['敌方全体集气-3', '丁不三丁不四同时在场，敌方全体集气-4']}],
      fortune: [],
    },
    {
      id: 'dingBuSi',
      name: '丁不四',
      talent: [{name: '一日不过四', effect: ['敌方全体集气-4', '丁不三丁不四同时在场，敌方全体集气-3']}],
      fortune: [],
    },
  ],
};
