export default {
  name: '轻功',
  exclusive: '',
  list: [
    {
      id: 'feiTianShenXing',
      name: '飞天神行',
      level: 4,
      cheat: '四象步法',
      get: '闯王藏宝洞开启宝箱获得',
      power: '命中300 闪避450 移动1 集气10',
      condition: '',
      addition: '轻功+2',
      sect: '',
      internal: '',
      initiative: ['无视ZOC限制移动，且移动格数+1', '集气速度+10', '行动结束后，下回合集气+200（可与其他效果叠加）'],
      passive: [],
      peculiar: [],
    },
    {
      id: 'shenXingBaiBian',
      name: '神行百变',
      level: 4,
      cheat: '神行百变',
      get: '鹿鼎记鳌拜家抄家获得',
      power: '命中450 闪避300 移动2',
      condition: '',
      addition: '轻功+2',
      sect: '',
      internal: '',
      initiative: [
        '无视ZOC限制移动，且移动格数+2',
        '被攻击12%的概率完全闪避攻击，成功闪避后5时序内闪避概率翻倍',
        '没闪避时，有25%的概率触发神行百变减伤，降低30%的伤害及杀气',
      ],
      passive: [],
      peculiar: [],
    },
    {
      id: 'lingBoWeiBu',
      name: '凌波微步',
      level: 4,
      cheat: '凌波微步',
      get: '带钟灵遇见段誉剧情后，调查无量山洞石像，战胜逍遥派三老后获得',
      power: '命中250 闪避550 移动1',
      condition: '',
      addition: '轻功+2',
      sect: '',
      internal: '',
      initiative: ['无视ZOC限制移动，且移动格数+1', '被攻击20%的概率完全闪避攻击', '每次被击中后增加闪避200点，闪避后清除'],
      passive: [],
      peculiar: [],
    },
    {
      id: 'tianLuoDiWang',
      name: '天罗地网',
      level: 4,
      cheat: '天罗地网势',
      get: '神雕正绝情谷底剧情后获得',
      power: '命中550 闪避250 移动1',
      condition: '',
      addition: '轻功+2',
      sect: '',
      internal: '',
      initiative: [
        '无视ZOC限制移动，且移动格数+1',
        '攻击时25%概率无视敌方的闪避效果强制命中，且自身攻击范围+1，被击中的敌方下回合移动格数-1',
        '*强制命中可针对敌方真葵花移行、凌波微步、神行百变等特效，无视我方被刺目等debuff',
      ],
      passive: [],
      peculiar: [],
    },
    {
      id: 'tiYunZongHeng',
      name: '梯云纵横',
      level: 4,
      cheat: '梯云纵横',
      get: '武当宝箱获取，需战斗和减道德',
      power: '命中350 闪避350 移动1',
      condition: '',
      addition: '轻功+2',
      sect: '',
      internal: '',
      initiative: ['无视ZOC限制移动，且移动格数+1', '攻击伤害不随距离递减', '被攻击时，有50%的概率触发梯云纵横，降低50%的杀气'],
      passive: [],
      peculiar: [],
    },
    {
      id: 'shunXiQianLi',
      name: '瞬息千里',
      level: 4,
      cheat: '瞬息千里',
      get: '射雕正重阳宫大战后获得，邪洪七公居剧情后获得',
      power: '命中250 闪避250 移动2',
      condition: '',
      addition: '轻功+2',
      sect: '',
      internal: '',
      initiative: ['无视ZOC限制移动，且移动格数+2', '暴怒时集气速度提升至3倍且免疫封穴'],
      passive: [],
      peculiar: [],
    },
    {
      id: 'yiWeiDuJiang',
      name: '一苇渡江',
      level: 4,
      cheat: '一苇渡江',
      get: '扫地左边的书架空格触发与达摩的战斗，胜利后获得',
      power: '命中400 闪避400 移动2',
      condition: '',
      addition: '轻功+2',
      sect: '',
      internal: '',
      initiative: [
        '无视ZOC限制移动，且移动格数+2',
        '受到封穴减少50%',
        '初始集气位置+500',
        '被攻击时30%概率减伤30%',
        '集气速度不受异常影响',
      ],
      passive: [],
      peculiar: [],
    },
    {
      id: 'jinYanGong',
      name: '金雁功',
      level: 4,
      cheat: '金雁功',
      get: '1.介绍信交给丘处机赠与 2.神雕邪带李莫愁到古墓密室',
      power: '命中300 闪避350 移动2',
      condition: '',
      addition: '轻功+2',
      sect: '',
      internal: '',
      initiative: ['无视ZOC限制移动，且移动格数+2', '气防+800', '暴击率增加20%，暴击伤害增加10%'],
      passive: [],
      peculiar: [],
    },
    {
      id: 'sheHangLiFan',
      name: '蛇行狸翻',
      level: 4,
      cheat: '蛇行狸翻',
      get: '射雕正挑战王重阳胜利后获得，邪重阳宫天书第四战不选化干戈为玉帛胜后获得',
      power: '命中450 闪避300 移动2',
      condition: '',
      addition: '轻功+2',
      sect: '',
      internal: '',
      initiative: [
        '无视ZOC限制移动，且移动格数+2',
        '轻功+20%',
        '每20时序(轻功值/1000)%概率集气往前随机跳跃轻功值*0.05~轻功值*0.10位置（封穴状态下无效）',
        '15%概率闪避攻击',
      ],
      passive: [],
      peculiar: [],
    },
    {
      id: 'xiaoYaoYou',
      name: '逍遥游',
      level: 4,
      cheat: '逍遥游',
      get: '天龙邪丐帮剧情后触发第二次打狗阵胜利后获得',
      power: '命中360 闪避380',
      condition: '',
      addition: '攻击+1 轻功+1 暗器+1',
      sect: '',
      internal: '',
      initiative: ['减伤10%', '闪避10%', '轻功+20', '被击中怒气值增加'],
      passive: [],
      peculiar: [],
    },
    {
      id: 'lingBieBu',
      name: '灵鳖步',
      level: 4,
      cheat: '灵鳖步',
      get: '射雕正桃花岛招亲后获得',
      power: '命中220 闪避380',
      condition: '',
      addition: '轻功+2',
      sect: '',
      internal: '',
      initiative: ['被攻击概率触发：移动到以自身为中心的九宫格中的一点', '移出攻击范围则不受伤害'],
      passive: [],
      peculiar: [],
    },
    {
      id: 'shiFangBu',
      name: '十方步',
      level: 4,
      cheat: '十方步',
      get: '秘籍暂无获取方式，只能加入天机宫后习得',
      power: '命中300 闪避500',
      condition: '',
      addition: '轻功+2',
      sect: '',
      internal: '',
      initiative: ['被攻击概率触发：移动到以自身为中心的九宫格中的一点，并且进行反击', '移出攻击范围则不受伤害'],
      passive: [],
      peculiar: [],
    },
  ],
};
