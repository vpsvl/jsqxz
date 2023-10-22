export default {
  name: '华山论剑',
  normal: [
    {
      map: '华山下-华山后山（中原）',
      event: [
        {
          list: ['对话场景中间的羊，剧情后选择『是』开启论剑', '*选择『否』则事件关闭，不可再次触发'],
          reward: [],
        },
        {
          list: [
            '论剑分为初赛、复赛和决赛三场，输掉任意一场均失去夺冠资格',
            '论剑参赛NPC：周伯通、阿青、王重阳、林朝英、阿凡提、风清扬、东方不败、扫地老僧、张三丰',
            '每场战斗选取一位NPC为对手，已战胜的NPC不可再次挑战',
          ],
          reward: [
            '挑战奖励：',
            '阿青-气防永久提高800点',
            '周伯通-使用武功体内消耗减少50%',
            '王重阳-伤害固定提高20%',
            '林朝英-连击率暴击率+50%',
            '阿凡提-绝对的先手能力：进战满集气，如果自己最先出手（多人进战满集气，集气速度最快的先出手），使全场敌方的初始集气位置减少500',
            '张三丰-三围+30，五系兵器值+20',
            '扫地老僧-武学常识+100点',
            '东方不败-集气速度+8点',
            '风清扬-气攻永久提高1000点',
          ],
        },
      ],
    },
    {
      map: '江陵（江南）',
      event: [
        {
          list: [
            '每月的初九日，将在江陵城举行比武，对话比武场处的白展堂开启',
            '战胜参赛选选手将获得巨额修炼点数和武学点，还有稀有药品等大奖，且有概率洗一次第一格武功（限一次，洗的武功是比赛对手的武功之一，可选择）',
          ],
          reward: ['修炼点数和武学点', '稀有药品', '有概率洗一次第一格武功（限一次，洗的武功是比赛对手的武功之一，可选择）'],
        },
      ],
    },
  ],
};