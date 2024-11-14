export default {
  name: '华山派',
  effect: ['使用剑法概率三连击，且连击伤害不减，连击时命中提升20%', '杀岳不群后，将直升华山派掌门'],
  talent: [
    {
      name: '华山弟子',
      effect: ['华山派武功连击率+10%，暴击率+10%，可额外选择两个天关天赋'],
    },
  ],
  martial: [
    {
      name: '拳掌',
      list: [
        '中阶：伏虎拳',
        '高阶：劈石破玉拳  混元掌  玉碎掌',
      ],
    },
    {
      name: '指腿',
      list: [ '高阶：鹰蛇生死搏'],
    },
    {
      name: '剑法',
      list: [
        '中阶：太岳三清峰  宁氏一剑   玉女十九剑',
        '高阶：狂风快剑  夺命三仙剑  华岳三神峰',
        '绝学：独孤九剑  西岳神剑',
      ],
    },
    {
      name: '内功',
      list: [
        '初阶：华山心法',
        '中阶：紫霞神功 (NPC处可直接一脉五岳剑诀)',
        '高阶：混元功',
        '绝学：五岳剑诀',
      ],
    },
    {
      name: '轻功',
      list: [
        '初阶：华山身法',
        '绝学：神行百变',
      ],
    },
  ],
};
