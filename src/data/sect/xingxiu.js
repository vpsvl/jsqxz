export default {
  name: '星宿派',
  effect: ['攻击带毒增加100点，自身免疫中毒', '行动后几率对周围六格内目标上毒40-80点'],
  talent: [
    {
      name: '星宿弟子',
      effect: ['星宿派武功连击率+10%，暴击率+10%，可额外选择两个天赋'],
    },
  ],
  martial: [
    {
      name: '拳掌',
      list: ['初阶：抽髓掌', '中阶：千蛛万毒手', '高阶：冰蚕毒掌  连环腐尸毒', '绝学：三阴腐尸掌'],
    },
    {
      name: '内功',

      list: ['初阶：星宿心法', '高阶：化功大法'],
    },
    {
      name: '轻功',
      list: ['初阶：星宿身法', '绝学：摘星揽月'],
    },
  ],
};
