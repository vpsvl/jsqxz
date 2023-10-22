export default {
  name: '密宗',
  effect: ['不装备武器，攻击+20%；不装备防具，防御+20%；不装备坐骑，轻功+20%', '对同一个目标不间断的攻击，伤害和命中会随着攻击次数而增加'],
  talent: [
    {
      name: '密宗弟子',
      effect: ['密宗武功连击率+10%，暴击率+10%，可额外选择两个天关天赋'],
    },
  ],
  martial: [
    {
      name: '刀法',
      list: ['初阶：密宗刀法', '中阶：阿难破戒刀', '高阶：燃木刀法', '绝学：火焰刀法'],
    },
    {
      name: '奇门',
      list: ['中阶：黄沙万里鞭  狂风迅雷扇', '高阶：无上大力杵', '绝学：五轮大转'],
    },
    {
      name: '内功',
      list: ['初阶：密宗心法', '中阶：释迦掷象功', '高阶：瑜伽密乘', '绝学：龙象般若功'],
    },
    {
      name: '轻功',
      list: ['初阶：密宗身法', '绝学：金刚幻相'],
    },
  ],
};