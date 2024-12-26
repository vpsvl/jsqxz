export default {
  name: '经脉',
  list: [
    {
      name: '手三阴经',
      list: [
        {
          name: '手少阴经',
          list: [
            {
              name: '裂石',
              condition: '指法系数≥100，100武学点数',
              effect: ['指法武功威力+200，伤害+5%'],
            },
            {
              name: '穿云劲',
              condition: '指法系数≥200，150武学点数',
              effect: ['指法武功无视目标防御20%，额外增加5点封穴'],
            },
            {
              name: '灵犀一指',
              condition: '指法系数≥400，200武学点数',
              effect: ['指法攻击必破气防，受到攻击必格挡', '20%固定概率忽略目标此次伤害'],
            },
          ],
        },
        {
          name: '手太阴经',
          list: [
            {
              name: '剑气',
              condition: '御剑系数≥100，100武学点数',
              effect: ['剑法武功附加气功值20%的伤害'],
            },
            {
              name: '御剑术',
              condition: '御剑系数≥200，150武学点数',
              effect: ['主运五岳剑诀每2点御剑能力增加1点伤害，触发以剑御气减少(御剑能力/1000)%的伤害'],
            },
            {
              name: '一剑镇神州',
              condition: '御剑系数≥400，200武学点数',
              effect: ['辟邪剑法/玄铁剑法招式移动距离增加4格', '使用剑法时10%固定概率触发[无我无剑]先手反击'],
            },
          ],
        },
        {
          name: '手厥阴经',
          list: [
            {
              name: '炼毒',
              condition: '用毒能力≥100，100武学点数',
              effect: ['攻击带毒+20点，用毒能力和用毒上限+20点'],
            },
            {
              name: '蛊毒阵',
              condition: '用毒能力≥200，150武学点数',
              effect: ['用毒能力和用毒上限+30点，学会秘技毒布武林和紫气天罗时用毒上限额外提高80点', '击中敌方目标损失中毒点数100%的伤害'],
            },
            {
              name: '万毒蚀体',
              condition: '用毒能力≥300，200武学点数',
              effect: ['用毒能力和用毒上限+100点，自身免疫中毒', '被攻击时给对方上毒10~20点', '每100时序给我方五格内所有敌人施毒'],
            },
          ],
        },
      ],
    },
    {
      name: '手三阳经',
      list: [
        {
          name: '手少阳经',
          list: [
            {
              name: '开碑',
              condition: '拳掌系数≥100，100武学点数',
              effect: ['拳掌武功伤害+20%'],
            },
            {
              name: '通臂拳',
              condition: '拳掌系数≥200，150武学点数',
              effect: [
                '拳掌攻击追加5点内伤',
                '须弥山神掌触发绝招如来神掌和如来神掌灭的概率+10%',
                '降龙十八掌/黯然销魂掌极意概率+15%',
                '般若掌造成的最终伤害不会低于武功威力',
              ],
            },
            {
              name: '盖世神拳',
              condition: '拳掌系数≥400，200武学点数',
              effect: ['使用拳掌时行动前蓄力，随攻击范围内目标数量增减伤害-20%~50%'],
            },
          ],
        },
        {
          name: '手太阳经',
          list: [
            {
              name: '拔刀',
              condition: '耍刀系数≥100，100武学点数',
              effect: ['刀法暴击伤害+30%'],
            },
            {
              name: '九寒焰',
              condition: '耍刀系数≥200，150武学点数',
              effect: [
                '沧溟刀法攻击时对周围7格敌人冰封20点，20%概率冻结10时序',
                '火焰刀法攻击时对周围7格敌人灼烧10点，20%概率点燃5时序',
                '天刀九问攻击时对周围7格敌人流血20~40点，触发九歌概率+10%',
              ],
            },
            {
              name: '傲世狂刀',
              condition: '耍刀系数≥400，200武学点数',
              effect: ['胡家刀法极意必触发且范围+1', '战场上每多一个敌人，自身伤害+5%', '刀法攻击暴击率+10%，怒气值+5'],
            },
          ],
        },
        {
          name: '手阳明经',
          list: [
            {
              name: '浴火',
              condition: '阳内且少林九阳功/峨眉九阳功/武当九阳功10级以上，100武学点数',
              effect: ['攻击时灼烧值+100%', '受到伤害时30%概率使用对方灼烧'],
            },
            {
              name: '火神君',
              condition: '阳内且内力最大值≥5000，150武学点数',
              effect: ['主运九阳神功/圣火神功/纯阳无极功/龙象般若功时，攻击有30%概率直接点燃目标10时序'],
            },
            {
              name: '至阳之体',
              condition: '阳内且天赋内功为九阳神功，200武学点数',
              effect: ['防御+10%', '主运九阳神功时50%概率减伤30%，吸收受到伤害的20%转化为护盾，每次行动后增加一个防御值的护盾'],
            },
          ],
        },
      ],
    },
    {
      name: '足三阴经',
      list: [
        {
          name: '足少阴经',
          list: [
            {
              name: '碎甲',
              condition: '奇门系数≥100，100武学点数',
              effect: ['奇门武功无视目标防御20%'],
            },
            {
              name: '兵器谱',
              condition: '奇门系数≥200，150武学点数',
              effect: ['背包里的可以装备的所有奇门兵器都计算装备状态，增加的属性值只有一半（实际是计算的游戏中所有奇门兵器）'],
            },
            {
              name: '奇门无双',
              condition: '奇门系数≥400，200武学点数',
              effect: ['奇门武功概率附加剧毒', '使用灵蛇杖法必出[大蛇无双]', '打狗棒法奥义概率+20%', '攻击时必破气防且必造成锁足'],
            },
          ],
        },
        {
          name: '足太阴经',
          list: [
            {
              name: '凌冽',
              condition: '阴内且紫霞神功/寒冰真气10级以上，100武学点数',
              effect: ['攻击时冰封值+100%', '受到伤害时30%概率使对方冰封'],
            },
            {
              name: '玄冰界',
              condition: '阴内且内力最大值≥5000，150武学点数',
              effect: [
                '主运九阴神功/寒冰真气/逆运真经/灵犀分水功时，攻击有30%概率使目标冻结10时序',
                '受到致命伤害时，优先触发[玄冰结界]使自己冰冻，并时序恢复生命到30%，期间免疫任何伤害',
              ],
            },
            {
              name: '至阴之体',
              condition: '阴内且天赋内功为九阴神功，200武学点数',
              effect: [
                '攻击+10%',
                '免疫冰封',
                '主运九阴神功每100时序触发一次[玄阴煞气]给自身五格范围内的敌人概率增加虚弱状态1回合',
                '攻击时冻结攻击目标和自身周围五格内的目标10时序（自身五格内有目标存活即使杀死攻击目标，也不会中断连击）',
              ],
            },
          ],
        },
        {
          name: '足厥阴经',
          list: [
            {
              name: '象形',
              condition: '鲸息功/龙象般若功/蛤蟆功/龟息功/狮吼功10级以上，100武学点数',
              effect: ['攻击后进入防御状态', '主运鲸息功使用拳法会触发六大奇劲'],
            },
            {
              name: '修罗道',
              condition: '内力最大值≥7000，150武学点数',
              effect: ['主运学海魔攻/天魔功/血河神鉴吸血上限+100，溢出的吸血会转化为护盾值'],
            },
            {
              name: '太玄真解',
              condition: '学会左右互搏，200武学点数',
              effect: ['生命最大值+300', '太玄神功解锁主运特效[混沌太玄]的两种特效，增加固定触发概率5%'],
            },
          ],
        },
      ],
    },
    {
      name: '足三阳经',
      list: [
        {
          name: '足少阳经',
          list: [
            {
              name: '梅花',
              condition: '轻功≥200，100武学点数',
              effect: ['闪避+20%，命中+20%'],
            },
            {
              name: '鱼龙跃',
              condition: '轻功≥300，150武学点数',
              effect: ['闪避后自身集气位置+100'],
            },
            {
              name: '凌空虚渡',
              condition: '轻功≥400，200武学点数',
              effect: ['轻功+10%', '30%概率免疫反击和反伤'],
            },
          ],
        },
        {
          name: '足太阳经',
          list: [
            {
              name: '祝由',
              condition: '罗汉伏魔攻/紫霞神功/混元功/枯荣禅功10级以上，100武学点数',
              effect: ['每时序恢复3点生命、10点内力，每6时序恢复1点体力'],
            },
            {
              name: '归元境',
              condition: '内力最大值≥5000，150武学点数',
              effect: ['神照经/先天功/长生诀到10级以上主运复活变为被动复活，复活后获得500点护盾，先天功翻倍', '复活后气防+25%'],
            },
            {
              name: '离经易道',
              condition: '天赋内功为长生诀/大长和诀/枯荣禅功，200武学点数',
              effect: ['体质+2', '主运长生诀/大长和诀/枯荣禅功，任何人行动后恢复自身5%生命、200点内力、1点体力、5点怒气'],
            },
          ],
        },
        {
          name: '足阳明经',
          list: [
            {
              name: '炼气',
              condition: '调和内且太虚剑意/忘情天书/小无相功10级以上，100武学点数',
              effect: ['气防+10%，气功+10%，10%概率免疫杀气'],
            },
            {
              name: '步亦趋',
              condition: '调和内且内力最大值≥5000，150武学点数',
              effect: ['主运葵花神功回合结束时50%概率增加300点集气值', '主运擒龙功必锁足'],
            },
            {
              name: '天人合一',
              condition: '调和内且天赋内功为易筋神功/阴阳无极功，200武学点数',
              effect: [
                '内力最大值+500',
                '主运易筋神功/阴阳无极功时，攻击和被攻击获得2层[天人]效果，回合开始时按[天人]点数恢复生命和内力，增加[天人]点数的真实伤害和真实减伤，上限49层',
              ],
            },
          ],
        },
      ],
    },
    {
      name: '任督二脉',
      list: [
        {
          name: '任脉',
          list: [
            {
              name: '乾坤',
              condition: '乾坤大挪移10级以上，100武学点数',
              effect: ['乾坤大挪移反弹伤害+50%'],
            },
            {
              name: '逍遥游',
              condition: '内力最大值≥5000，150武学点数',
              effect: [
                '主运浑天气功行动前每回合随机获得一种酒效果，同一种酒不会叠加持续时间',
                '学会北冥神功不需运功即可被动挨打吸内',
                '大周天功到极[养生主]效果翻倍',
              ],
            },
            {
              name: '浩然正气',
              condition: '学会中庸之道，200武学点数',
              effect: [
                '攻击+5%，防御+5%',
                '行动前发动[浩然正气]，统计全员的状态（特殊状态不计算），每一个状态增加1点[浩然]，并清除己方所有减益状态，每点[浩然]增加自身伤害5%、下回合集气位置20',
              ],
            },
          ],
        },
        {
          name: '督脉',
          list: [
            {
              name: '观星',
              condition: '奇门五转/吸星大法/化功大法10级以上，100武学点数',
              effect: ['奇门五转特效概率+5%', '学会吸星大法/化功大法不需运功即可被打挨打吸内、吸体/化内'],
            },
            {
              name: '太极图',
              condition: '内力最大值≥5000，150武学点数',
              effect: ['主运太极神功时太极蓄力只清除50%', '真太奥触发后减伤50%，且概率最多只受到99点伤害'],
            },
            {
              name: '物移星转',
              condition: '学会斗转星移，200武学点数',
              effect: ['攻击+5%，防御+5%', '全抗性+20%', '武功消耗内力和真气降低50%', '斗转星移到极自动主运，斗转伤害+20%'],
            },
          ],
        },
      ],
    },
  ],
};
