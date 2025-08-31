/**
 * 攻击类
 */

export function xiXue(lv) {
  return {
    id: 900,
    name: `吸血 Lv${lv}`,
    effect: [
      `攻击时造成伤害时${lv * 25}%概率将伤害的${lv * 10}%转化为恢复自身生命，最多恢复身最大生命值的10%`,
    ],
  };
}

export function xueMo(lv) {
  return {
    id: 901,
    name: `血魔 Lv${lv}`,
    effect: [
      `攻击时造成伤害时${lv * 25}%概率将伤害的${lv * 10}%转化为恢复自身生命，最多恢复身最大生命值的5%，溢出部分转化为护盾`,
    ],
  };
}

export function fengHou(lv) {
  return {
    id: 902,
    name: `封喉 Lv${lv}`,
    effect: [`攻击时必单击，但是造成${lv * 25 + 100}%的伤害`],
  };
}

export function shuangJi(lv) {
  return {
    id: 903,
    name: `双击 Lv${lv}`,
    effect: [`攻击时${lv * 25}%概率二连击`],
  };
}

export function sanJi(lv) {
  return {
    id: 904,
    name: `三击 Lv${lv}`,
    effect: [`攻击时${lv * 20}%概率三连击`],
  };
}

export function fanTan(lv) {
  return {
    id: 905,
    name: `反弹 Lv${lv}`,
    effect: [`被攻击时${lv * 25}%概率反弹${lv * 25}%的伤害给攻击方`],
  };
}

export function quanZhangZhiLi(lv) {
  return {
    id: 906,
    name: `拳掌之力 Lv${lv}`,
    effect: [`增加拳掌武功的威力${lv * 200}`],
  };
}

export function zhiTuiZhiLi(lv) {
  return {
    id: 907,
    name: `指腿之力 Lv${lv}`,
    effect: [`增加指腿武功的威力${lv * 200}`],
  };
}

export function jianFaZhiLi(lv) {
  return {
    id: 908,
    name: `剑法之力 Lv${lv}`,
    effect: [`增加剑法武功的威力${lv * 200}`],
  };
}

export function daoFaZhiLi(lv) {
  return {
    id: 909,
    name: `刀法之力 Lv${lv}`,
    effect: [`增加刀法武功的威力${lv * 200}`],
  };
}

export function qiMenZhiLi(lv) {
  return {
    id: 910,
    name: `奇门之力 Lv${lv}`,
    effect: [`增加奇门武功的威力${lv * 200}`],
  };
}

export function yaoJiaoKongBi(lv) {
  return {
    id: 911,
    name: `夭矫空碧 Lv${lv}`,
    effect: [`攻击时${lv * 25}%概率触发连击伤害、气攻、命中不减`],
  };
}

export function quanGang(lv) {
  return {
    id: 912,
    name: `拳罡 Lv${lv}`,
    effect: [`攻击时使用拳掌武功破防+${lv * 10}%`],
  };
}

export function zhiJin(lv) {
  return {
    id: 913,
    name: `指劲 Lv${lv}`,
    effect: [`攻击时使用指腿武功破防+${lv * 10}%`],
  };
}

export function jianQi(lv) {
  return {
    id: 914,
    name: `剑气 Lv${lv}`,
    effect: [`攻击时使用剑法武功破防+${lv * 10}%`],
  };
}

export function daoFeng(lv) {
  return {
    id: 915,
    name: `刀风 Lv${lv}`,
    effect: [`攻击时使用刀法武功破防+${lv * 10}%`],
  };
}

export function qiMen(lv) {
  return {
    id: 916,
    name: `奇门 Lv${lv}`,
    effect: [`攻击时使用奇门武功破防+${lv * 10}%`],
  };
}

export function qiGongBo(lv) {
  return {
    id: 917,
    name: `气功波 Lv${lv}`,
    effect: [`攻击时使用内功破防+${lv * 10}%`],
  };
}

export function wuJianBuCui(lv) {
  return {
    id: 918,
    name: `无坚不摧 Lv${lv}`,
    effect: [`攻击时使用任何武功破防+${lv * 6}%`],
  };
}

export function xieJia2(lv) {
  return {
    id: 919,
    name: `卸甲Ⅱ Lv${lv}`,
    effect: [`攻击时${lv * 15}%概率无视敌方附加防御力`],
  };
}

export function xieJia1(lv) {
  return {
    id: 920,
    name: `卸甲Ⅰ Lv${lv}`,
    effect: [`攻击时${lv * 15}%概率无视敌方基础防御力`],
  };
}

export function shiZiHou(lv) {
  return {
    id: 921,
    name: `狮子吼 Lv${lv}`,
    effect: [`攻击时${lv * 25}%概率对低于自身内力的敌方造成集气位置-100，且追加${lv * 5}点内伤`],
  };
}

export function poFang(lv) {
  return {
    id: 922,
    name: `破防 Lv${lv}`,
    effect: [`攻击时对防御目标额外造成${lv * 25}%的伤害`],
  };
}

export function poDun(lv) {
  return {
    id: 923,
    name: `破盾 Lv${lv}`,
    effect: [`攻击时对护盾目标额外造成${lv * 25}%的伤害`],
  };
}

export function poLi(lv) {
  return {
    id: 924,
    name: `破力 Lv${lv}`,
    effect: [`攻击时对蓄力目标额外造成${lv * 25}%的伤害`],
  };
}

export function poLi2(lv) {
  return {
    id: 925,
    name: `破力 Lv${lv}`,
    effect: [`攻击时${lv * 25}%概率清除目标的蓄力`],
  };
}

export function xiNeiZhuDong(lv) {
  return {
    id: 926,
    name: `吸内·主动 Lv${lv}`,
    effect: [`攻击时造成伤害时${lv * 25}%概率吸取目标内力${lv * 100}点`],
  };
}

export function xiTiZhuDong(lv) {
  return {
    id: 927,
    name: `吸体·主动 Lv${lv}`,
    effect: [`攻击时造成伤害时${lv * 25}%概率吸取目标体力${lv * 2}点`],
  };
}

export function xiNuZhuDong(lv) {
  return {
    id: 928,
    name: `吸怒·主动 Lv${lv}`,
    effect: [`攻击时造成伤害时${lv * 25}%概率吸取目标怒气${lv * 2}点`],
  };
}

export function poGang(lv) {
  return {
    id: 929,
    name: `破罡 Lv${lv}`,
    effect: [`攻击时造成伤害时${lv * 25}%概率使目标无法触发内功护体`],
  };
}

export function yiJinDuanGu(lv) {
  return {
    id: 930,
    name: `罗汉伏魔 Lv${lv}`,
    effect: [`攻击时根据消耗的内力值${lv * 50}%增加气攻和伤害`],
  };
}

export function hongXiuShanWu(lv) {
  return {
    id: 931,
    name: `红袖善舞 Lv${lv}`,
    effect: [`对男性攻击伤害增加${lv * 8}%伤害，受到男性的攻击伤害减少${lv * 8}%`],
  };
}

export function huaGong(lv) {
  return {
    id: 932,
    name: `化功 Lv${lv}`,
    effect: [`攻击时${lv * 25}%概率减少目标内力${lv * 100}点`],
  };
}

export function longXiangZhiLi(lv) {
  return {
    id: 933,
    name: `龙象之力 Lv${lv}`,
    effect: [
      `攻击时${lv * 25}%概率随自身怒气值增加伤害，最多增加${lv * 25}%，最多增加气攻${lv * 500}点`,
    ],
  };
}

export function tianLuo(lv) {
  return {
    id: 934,
    name: `天罗 Lv${lv}`,
    effect: [`攻击时${lv * 15}%概率无视敌方闪避`],
  };
}

export function diWang(lv) {
  return {
    id: 935,
    name: `地网 Lv${lv}`,
    effect: [`武功攻击范围+1`],
  };
}
