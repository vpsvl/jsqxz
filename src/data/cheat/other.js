export default {
  name: '杂学',
  exclusive: '',
  list: [
    {
      name: '左右互搏术',
      level: '',
      get: '蜘蛛洞救周伯通',
      condition: '资质≤30',
      addition: '激活左右互搏',
      sect: '',
      peculiar: [
        {
          effect: ['左右互搏几率：25+(71-资质)/2 %', '低资（1-30）左右概率+10%', '爆怒时，如会左右互博则概率增加20%'],
        },
      ],
    },
    {
      name: '斗转星移',
      level: '',
      get: '天龙邪燕子坞收慕容复',
      condition: '总兵器值≥120 资质≥80',
      addition: '攻击+1 拳掌+1 指法+1 御剑+1 耍刀+1 特殊+1',
      sect: '',
      peculiar: [
        {
          effect: [
            '高资(80-100)，斗转概率+10%，且斗转可控为高资专属',
            '爆怒时，如会斗转星移则概率增加20%',
            '【北斗移辰】：',
            '总兵器值＜240，被攻击时25+(资质-30)/2概率触发',
            '以50%的威力斗转反击,并追加300点气攻',
            '【斗转星移】：',
            '240≤总兵器值＜360，被攻击时25+（资质-30）/2概率触发',
            '以60%的威力斗转反击,并追加600点气攻',
            '【离合参商】：',
            '360≤总兵器值＜520，被攻击时25+（资质-30）/2概率触发',
            '以70%的威力斗转反击,并追加1200点气攻',
            '【幻梦星辰】：',
            '总兵器值≥520，发动离合参商反击时有（五系兵器值之和-520）%的几率变为幻梦星辰反击',
            '反击伤害和气攻提高到80%，且可连击',
            // '*被攻击时25+（资质-30）/2概率触发',
          ],
        },
      ],
    },
    {
      name: '中庸之道',
      level: '',
      get: '鸳鸯刀战胜萧半和',
      condition: '资质31~79',
      addition: '激活中庸之道',
      sect: '',
      peculiar: [
        {
          effect: [
            '修炼时进行分支选择：',
            '1.天命之谓性：每(资质-1)时序行动一次（<30时序按30时序计算）',
            '2.率性之谓道：受到攻击后如果满怒，(资质-29)%几率结束对手攻击并反击',
          ],
        },
      ],
    },
  ],
};