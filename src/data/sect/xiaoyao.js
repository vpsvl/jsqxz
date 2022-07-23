export default {
  name: '逍遥派',
  effect: [
    '天山折梅手和天山六阳掌几率追加【生死符】',
    '被生死符击中的目标攻击时，几率命中减伤一半；行动时小概率混乱（休息/防御/蓄力/集中/等待）',
  ],
  talent: [
    {
      name: '逍遥弟子',
      effect: ['逍遥派武功连击率+10%，暴击率+10%，可额外选择两个天赋'],
    },
  ],
  martial: [
    {
      name: '指腿',
      list: ['初阶：夺魄指', '中阶：分筋错骨手', '高阶：寒袖拂穴  凝血神爪', '绝学：天山折梅手'],
    },
    {
      name: '拳掌',
      list: ['中阶：黑沙掌', '高阶：白虹掌力', '绝学：天山六阳掌'],
    },
    {
      name: '内功',
      list: ['初阶：逍遥心法', '高阶：八荒六合功  小无相功', '绝学：不老长春功  北冥神功'],
    },
    {
      name: '轻功',
      list: ['初阶：逍遥身法', '绝学：淩波微步'],
    },
  ],
};
