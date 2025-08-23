/**
 * 恢复类
 */

// 各等级时序
const timeSequence = {
  1: 9,
  2: 6,
  3: 5,
  4: 3,
};

export function huiMing(lv) {
  return {
    id: 100,
    name: `回命 Lv${lv}`,
    effect: [`每回合恢复${lv * 100}点生命值`],
  };
}

export function huiNei(lv) {
  return {
    id: 101,
    name: `回内 Lv${lv}`,
    effect: [`每回合恢复${lv * 100}点内力值`],
  };
}

export function huiTi(lv) {
  return {
    id: 102,
    name: `回体 Lv${lv}`,
    effect: [`每回合恢复${lv}点体力值`],
  };
}

export function huiQi(lv) {
  return {
    id: 103,
    name: `回气 Lv${lv}`,
    effect: [`每回合恢复${lv}点气力值`],
  };
}

export function mingGui(lv) {
  return {
    id: 104,
    name: `命归 Lv${lv}`,
    effect: [`每回合恢复最大生命值${lv * 2}%点生命值`],
  };
}

export function neiGui(lv) {
  return {
    id: 105,
    name: `气归 Lv${lv}`,
    effect: [`每回合恢复最大内力值${lv * 2}%点内力值`],
  };
}

export function shiXuHuiMing(lv) {
  return {
    id: 106,
    name: `时序回命 Lv${lv}`,
    effect: [`每${timeSequence[lv]}时序恢复${lv * 2}点生命值`],
  };
}

export function shiXuHuiNei(lv) {
  return {
    id: 107,
    name: `时序回内 Lv${lv}`,
    effect: [`每${timeSequence[lv]}时序恢复${lv * 2}点内力值`],
  };
}

export function shiXuHuiTi(lv) {
  return {
    id: 108,
    name: `时序回体 Lv${lv}`,
    effect: [`每${timeSequence[lv]}时序恢复1点体力值`],
  };
}

export function huiChun(lv) {
  return {
    id: 109,
    name: `回春 Lv${lv}`,
    effect: [`每回合恢复损失生命值的${lv * 5}%`],
  };
}

export function qiXueXiangSheng1(lv) {
  return {
    id: 110,
    name: `气血相生Ⅰ Lv${lv}`,
    effect: [
      `如果(生命/生命最大值)百分比大于(内力值/内力最大值)百分比，则${timeSequence[lv]}时序恢复${lv}%最大内力值`,
    ],
  };
}

export function qiXueXiangSheng2(lv) {
  return {
    id: 111,
    name: `气血相生Ⅱ Lv${lv}`,
    effect: [
      `如果(生命/生命最大值)百分比小于(内力值/内力最大值)百分比，则${timeSequence[lv]}时序恢复${lv}%最大生命值`,
    ],
  };
}

export function neiRuQuanYong(lv) {
  return {
    id: 112,
    name: `内如泉涌 Lv${lv}`,
    effect: [`回合结束回复损失内力的${lv * 5}%`],
  };
}

export function shiXuHuiNu(lv) {
  return {
    id: 200,
    name: `时序回怒 Lv${lv}`,
    effect: [`每${timeSequence[lv]}时序恢复${lv}点怒气值`],
  };
}

export function huiNu(lv) {
  return {
    id: 201,
    name: `回怒 Lv${lv}`,
    effect: [`每回合行动后恢复${lv * 2}点怒气值`],
  };
}

export function quDu(lv) {
  return {
    id: 202,
    name: `袪毒 Lv${lv}`,
    effect: [`每回合清除${lv * 5}点中毒`],
  };
}

export function shangYao(lv) {
  return {
    id: 203,
    name: `伤药 Lv${lv}`,
    effect: [`每回合清除${lv * 5}点灼烧`],
  };
}

export function zhiXue(lv) {
  return {
    id: 204,
    name: `止血 Lv${lv}`,
    effect: [`每回合清除${lv * 5}点流血`],
  };
}

export function quHan(lv) {
  return {
    id: 205,
    name: `驱寒 Lv${lv}`,
    effect: [`每回合清除${lv * 5}点冰封`],
  };
}

export function liaoShang(lv) {
  return {
    id: 206,
    name: `疗伤 Lv${lv}`,
    effect: [`每回合清除${lv * 5}点内伤`],
  };
}

export function juLi(lv) {
  return {
    id: 207,
    name: `聚力 Lv${lv}`,
    effect: [`每回合清除虚弱状态`],
  };
}

export function juQi(lv) {
  return {
    id: 208,
    name: `聚气 Lv${lv}`,
    effect: [`每回合清除散功状态`],
  };
}

export function huJia(lv) {
  return {
    id: 209,
    name: `护甲 Lv${lv}`,
    effect: [`每回合清除破甲状态`],
  };
}

export function mieHuo(lv) {
  return {
    id: 210,
    name: `灭火 Lv${lv}`,
    effect: [`每回合清除点燃状态`],
  };
}

export function yuHe(lv) {
  return {
    id: 211,
    name: `愈合 Lv${lv}`,
    effect: [`每回合清除撕裂状态`],
  };
}

export function jieDu(lv) {
  return {
    id: 212,
    name: `解毒 Lv${lv}`,
    effect: [`每回合清除剧毒状态`],
  };
}

export function shiXuQuDu(lv) {
  return {
    id: 213,
    name: `时序祛毒 Lv${lv}`,
    effect: [`每${timeSequence[lv]}时序清除1点中毒`],
  };
}

export function shiXuShangYao(lv) {
  return {
    id: 214,
    name: `时序伤药 Lv${lv}`,
    effect: [`每${timeSequence[lv]}时序清除1点灼烧`],
  };
}

export function shiXuZhiXue(lv) {
  return {
    id: 215,
    name: `时序止血 Lv${lv}`,
    effect: [`每${timeSequence[lv]}时序清除1点流血`],
  };
}

export function shiXuQuHan(lv) {
  return {
    id: 216,
    name: `时序驱寒 Lv${lv}`,
    effect: [`每${timeSequence[lv]}时序清除1点冰封`],
  };
}

export function shiXuLiaoShang(lv) {
  return {
    id: 217,
    name: `时序疗伤 Lv${lv}`,
    effect: [`每${timeSequence[lv]}时序清除1点内伤`],
  };
}

export function chongXue(lv) {
  return {
     id: 218,
    name: `冲穴 Lv${lv}`,
    effect: [`每${timeSequence[lv]}时序清除1点封穴`],
  };
}
