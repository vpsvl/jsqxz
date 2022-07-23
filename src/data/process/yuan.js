export default {
  name: '鸳鸯刀',
  normal: [
    {
      map: '乌鞘岭（西部）',
      event: [
        {
          list: ['与剧情人物对话，触发战斗：', 'VS 周威信', '胜后获得【呼延鞭法】'],
          reward: ['呼延鞭法[奇门秘籍]'],
        },
      ],
    },
    {
      map: '凉州（北部）',
      event: [
        {
          list: ['进入客栈二楼触发剧情'],
          reward: [],
        },
        {
          list: ['出客栈后，与萧中慧对话，触发战斗：', 'VS 林玉龙+任飞燕', '胜后获得【鸳鸯刀法】'],
          reward: ['鸳鸯刀法[刀法秘籍]'],
        },
        {
          list: ['凉州左上出口进入小树林，触发战斗：', 'VS 卓天雄', '胜后，袁冠南加入，获得[鸯刀]'],
          reward: ['鸯刀[武器]', '袁冠南[队友] 加入'],
        },
        {
          list: ['小树林左上出口进入紫竹庵，对话尼姑触发剧情', '萧中慧加入，获得[鸳刀]【夫妻刀法】'],
          reward: ['夫妻刀法[刀法秘籍]', '鸳刀[武器]', '萧中慧[队友] 加入'],
        },
        {
          list: [
            '出紫竹庵大门，触发战斗：',
            'VS 卓天雄+周威信+大内高手*4',
            '胜后，获得[天王保命丹]*2',
          ],
          reward: ['天王保命丹[丹药]*2'],
        },
      ],
    },
    {
      map: '晋阳 （北部）',
      event: [
        {
          list: ['进入萧半和家，剧情后触发战斗：', 'VS 卓天雄+周威信+大内高手*4+精锐骑兵*4', '萧中慧、袁冠南离队'],
          reward: ['袁冠南[队友] 离队', '萧中慧[队友] 离队'],
        },
        {
          list: ['晋阳右上角出口进入中条山，与袁冠南、萧中慧对话可收2人入队'],
          reward: ['袁冠南[队友] 加入', '萧中慧[队友] 加入'],
        },
      ],
    },
    {
      map: '鸳鸯岛（海外）',
      event: [
        {
          list: [
            '对话萧半和，触发战斗：',
            'VS 萧半和',
            '胜利后获得《鸳鸯刀》【葵花点穴手】【中庸之道】',
            '开启宝箱获得[银两]*2000、[千年灵芝]*1',
          ],
          reward: [
            '道德+1',
            '中庸之道[杂学秘籍]',
            '葵花点穴手[指法秘籍]',
            '鸳鸯刀[十四天书之一]',
            '银两*2000',
            '千年灵芝[丹药]*1',
            '萧中慧：',
            '第一格武功洗夫妻刀法1级',
          ],
        },
      ],
    },
  ],
};