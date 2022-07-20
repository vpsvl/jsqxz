export default {
  name: '刀',
  list: [
    {
      name: '雁翎刀',
      get: '沧州商店出售',
      condition: '耍刀20',
      addition: '攻击+10',
      effect: [],
    },
    {
      name: '金刀 ',
      get: '洛阳击败王元霸',
      condition: '耍刀30',
      addition: '攻击+10',
      effect: [],
    },
    {
      name: '绿波香露刀',
      get: '冯铁匠出售',
      condition: '耍刀40',
      addition: '攻击+20',
      effect: [],
    },
    {
      name: '冷月宝刀',
      get: '1.冯铁匠出售 2.收袁紫衣获得',
      condition: '耍刀50',
      addition: '攻击+30',
      effect: ['胡家刀法威力+100'],
    },
    {
      name: '闯王军刀',
      get: '收袁紫衣获得',
      condition: '耍刀50',
      addition: '攻击+30',
      effect: ['胡家刀法威力+100'],
    },
    {
      name: '血刀',
      get: '连城邪击败血刀老祖',
      condition: '耍刀60',
      addition: '攻击+30',
      effect: ['血刀大法威力+200'],
    },
    {
      name: '鸳刀',
      get: '萧中慧加入获得',
      condition: '女性',
      addition: '攻击+20，防御+10，轻功+10',
      effect: [
        'LV.1：使用夫妻刀法时，必定连击',
        'LV.5：使用夫妻刀法时，必定连击，追加500气攻',
        'LV.6（MAX）：使用夫妻刀法时，必定连击，追加500气攻，伤害提高20%',
      ],
    },
    {
      name: '鸯刀',
      get: '袁冠南加入获得',
      condition: '男性',
      addition: '攻击+10，防御+20，轻功+10',
      effect: [
        'LV.1：使用夫妻刀法时，必定连击',
        'LV.5：使用夫妻刀法时，必定连击，追加500气攻',
        'LV.6（MAX）：使用夫妻刀法时，必定连击，追加500气攻，伤害提高20%',
      ],
    },
    {
      name: '屠龙刀',
      get: '倚天灵蛇岛剧情后，邪线修复断裂的屠龙刀',
      condition: '耍刀100',
      addition: '攻击+50，防御+20，轻功-10',
      effect: [
        '屠龙刀法威力+500',
        '【武林至尊.宝刀屠龙】：',
        '装备屠龙刀使用任意刀法攻击几率触发',
        '必定造成流血且追加气攻',
        '（追加的气攻数值等于所使用刀法的威力）',
        '【号令天下.莫敢不从】：',
        '装备屠龙刀使用任意刀法攻击几率触发',
        '必定造成暴击',
      ],
    },
    // {
    //   name: '玄铁菜刀',
    //   get: '小村洗西瓜刀法后获得',
    //   condition: '耍刀140',
    //   addition: '攻击+70',
    //   effect: ['西瓜刀法威力+100'],
    // },
  ],
};
