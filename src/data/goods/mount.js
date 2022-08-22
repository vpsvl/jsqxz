export default {
  name: '坐骑',
  list: [
    {
      name: '白马',
      get: '白马啸西风剧情获得',
      condition: '-',
      addition: '轻功+20',
      effect: ['LV.1：集气速度增加2点', 'LV.3：集气速度增加3点', 'LV.5：集气速度增加4点'],
    },
    {
      name: '瘦黄马',
      get: '神雕正线杨过送',
      condition: '-',
      addition: '轻功+10',
      effect: ['血量越低，集气速度越快'],
    },
    {
      name: '飞云骓',
      get: '神雕邪线胜蒙哥后获得',
      condition: '-',
      addition: '轻功+50',
      effect: ['集气速度增加12点'],
    },
    {
      name: '毛驴',
      get: '书剑李沅芷线凉州城门口击败阿凡提',
      condition: '-',
      addition: '轻功+50',
      effect: ['集气速度增加10点', '血量越低，集气速度越快'],
    },
    {
      name: '白猿',
      get: '倚天昆仑仙境收阿青后获得',
      condition: '阿青',
      addition: '轻功+40，御剑+20',
      effect: ['越女剑法/猿公剑法威力+200'],
    },
    {
      name: '青驴',
      get: '神雕正线江陵客栈剧情后获得，邪线收郭襄获得',
      condition: '-',
      addition: '防御+10，轻功+10',
      effect: ['集气速度增加4点', '体力消耗减少2点'],
    },
    {
      name: '汗血宝马',
      get: '射雕正收郭靖后获得，邪杀江南七怪后获得',
      condition: '-',
      addition: '防御+10，轻功+30',
      effect: ['集气速度增加8点', '时序回复流血值2点'],
    },
  ],
};
