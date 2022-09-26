export default {
  name: '杂学',
  exclusive: '',
  list: [
    {
      id: 'zuoYouHuBoShu',
      name: '左右互搏术',
      level: 4,
      get: '神雕蜘蛛洞救周伯通',
      condition: '资质≤30',
      addition: '激活左右互搏',
      sect: '',
      peculiar: [{effect: ['左右互搏概率：(25+(71-资质)/2)%', '低资（1-30）左右概率+10%', '爆怒时，如会左右互博则概率增加20%']}],
    },
    {
      id: 'douZhuanXingYi',
      name: '斗转星移',
      level: 4,
      get: '天龙邪燕子坞收慕容复',
      condition: '总兵器值≥120 资质≥80',
      addition: '攻击+1 拳掌+1 指法+1 御剑+1 耍刀+1 特殊+1',
      sect: '',
      peculiar: [
        {
          effect: [
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
        },
      ],
    },
    {
      id: 'zhongYongZhiDao',
      name: '中庸之道',
      level: 4,
      get: '鸳鸯刀战胜萧半和',
      condition: '资质31~79',
      addition: '激活中庸之道',
      sect: '',
      peculiar: [
        {
          effect: [
            '修炼时进行分支选择：',
            '1.天命之谓性：每(资质-1)时序行动一次（<30时序按30时序计算）',
            '2.率性之谓道：受到攻击后如果满怒，(资质-29)%概率结束对手攻击并反击',
          ],
        },
      ],
    },
    {
      id: 'huQingNiuYiShu',
      name: '胡青牛医术',
      level: 4,
      get: '收胡青牛入队',
      condition: '',
      addition: '习得秘技群疗',
      sect: '',
      peculiar: [
        {
          effect: ['对四格范围内己方目标进行一次治疗'],
        },
      ],
    },
    {
      id: 'duJing',
      name: '毒经',
      level: 4,
      get: '收王难姑入队',
      condition: '',
      addition: '习得秘技施毒',
      sect: '',
      peculiar: [
        {
          effect: ['对范围内敌方目标施毒'],
        },
      ],
    },
    {
      id: 'ziWuZhenJiuJing',
      name: '子午针灸经',
      level: 4,
      get: '笑傲收平一指入队',
      condition: '',
      addition: '习得秘技子午针灸',
      sect: '',
      peculiar: [
        {
          effect: ['对己方目标使用刺激目标，使目标获得一回合的六层【激昂】状态'],
        },
      ],
    },
    {
      id: 'qianJinFang',
      name: '千金方',
      level: 4,
      get: '飞狐偷阎基',
      condition: '',
      addition: '习得秘技千金术',
      sect: '',
      peculiar: [
        {
          effect: ['清除范围内己方的基础异常状态，并恢复少量气血'],
        },
      ],
    },
    {
      id: 'huangDiNeiJing',
      name: '黄帝内经',
      level: 4,
      get: '侠客邪收贝海石入队',
      condition: '',
      addition: '习得秘技黄帝内经',
      sect: '',
      peculiar: [
        {
          effect: ['治疗己方单体目标，并持续恢复气血'],
        },
      ],
    },
    {
      id: 'huaTuoNeiShaoTu',
      name: '华佗内昭图',
      level: 4,
      get: '天龙收薛慕华入队',
      condition: '',
      addition: '习得秘技华佗医术',
      sect: '',
      peculiar: [],
    },
    {
      id: 'yaoWangShenPian',
      name: '药王神篇',
      level: 4,
      get: '飞狐程灵素线收程灵素入队',
      condition: '',
      addition: '提升用毒和解毒属性',
      sect: '',
      peculiar: [],
    },
  ],
};
