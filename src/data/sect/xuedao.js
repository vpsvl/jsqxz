export default {
  name: '血刀门',
  effect: ['吸血后的血量超过最大生命值的部分会恢复自身内力和体力', '伤害和防御随善恶值变化', '杀血刀老祖后，将直升血刀门掌门'],
  talent: [
    {
      name: '血刀弟子',
      effect: ['血刀门武功连击率+10%，暴击率+10%，可额外选择两个天关天赋'],
    },
  ],
  martial: [
    {
      name: '刀法',
      list: ['初阶：血刀刀法', '中阶：鬼头刀法', '高阶：血刀大法', '绝学：血饮魔刀'],
    },
    {
      name: '内功',
      list: ['初阶：血刀心法', '中阶：血河神鉴', '绝学：血海魔功'],
    },
    {
      name: '轻功',
      list: ['初阶：血刀身法', '绝学：踏雪无痕'],
    },
  ],
};
