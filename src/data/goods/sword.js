export default {
  name: '剑',
  list: [
    {
      name: '白虹剑',
      get: '冯铁匠出售',
      condition: '御剑30',
      addition: '攻击+10',
      effect: [],
    },
    {
      name: '流星剑',
      get: '扬州商店出售',
      condition: '御剑40',
      addition: '攻击+10，轻功+10',
      effect: [
        'LV.1：连击率+10%',
        'LV.2：连击率+11%',
        'LV.3：连击率+12%',
        'LV.4：连击率+13%',
        'LV.5：连击率+14%',
        'LV.6（MAX）：连击率+15%',
      ],
    },
    {
      name: '青冥剑',
      get: '书剑李沅芷线龙门客栈击败张召重后获得',
      condition: '御剑50',
      addition: '攻击+10，防御+10，轻功+10',
      effect: ['根据御剑能力提高剑法范围（最高2）'],
    },
    {
      name: '白龙剑',
      get: '冯铁匠出售',
      condition: '御剑50',
      addition: '攻击+20',
      effect: ['苗家剑法威力+200'],
    },
    {
      name: '金蛇剑',
      get: '碧血剑正线剧情，邪线偷袁承志',
      condition: '御剑50',
      addition: '攻击+10，轻功+10',
      effect: ['金蛇剑法威力+200'],
    },
    {
      name: '凝碧剑',
      get: '书剑邪线收张召重，正线偷张召重',
      condition: '御剑60',
      addition: '攻击+30',
      effect: [],
    },
    {
      name: '君子剑',
      get: '绝情谷房间武器架上',
      condition: '御剑70',
      addition: '攻击+40',
      effect: ['全真剑法威力+100'],
    },
    {
      name: '淑女剑',
      get: '绝情谷房间武器架上',
      condition: '御剑70',
      addition: '攻击+40',
      effect: ['玉女剑法威力+100'],
    },
    {
      name: '玄铁剑',
      get: '独孤剑冢拔剑',
      condition: '御剑100',
      addition: '攻击+30，防御+30，轻功-10',
      effect: [
        '玄铁剑法威力+100',
        'LV.1：使用玄铁剑法时，增加50%暴击率',
        'LV.2：使用玄铁剑法时，增加60%暴击率',
        'LV.3：使用玄铁剑法时，增加70%暴击率',
        'LV.4：使用玄铁剑法时，增加80%暴击率',
        'LV.5：使用玄铁剑法时，增加90%暴击率',
        'LV.6（MAX）：使用玄铁剑法时，必定暴击，并可发动“破尽天下”',
      ],
    },
    {
      name: '真武剑',
      get: '黑木崖宝箱',
      condition: '御剑100',
      addition: '攻击+50',
      effect: ['太极剑法威力+100', '使用太极剑法时，必定连击'],
    },
    {
      name: '倚天剑',
      get: '倚天正线龙门客栈收赵敏，邪线修复断裂的倚天剑',
      condition: '御剑200',
      addition: '攻击+50',
      effect: [
        '倚天剑法威力+100',
        'LV.1：攻击时50%概率造成流血效果',
        'LV.2：攻击时60%概率造成流血效果',
        'LV.3：攻击时70%概率造成流血效果',
        'LV.4：攻击时80%概率造成流血效果',
        'LV.5：攻击时90%概率造成流血效果',
        'LV.6（MAX）：攻击时必定造成流血效果',
        '【倚天一出.谁与争锋】：',
        '御剑≥200，(御剑系数*0.1)%概率增加一次连击',
      ],
    },
  ],
};
