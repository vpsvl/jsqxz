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
    name: `回命 Lv${lv}`,
    effect: [`每回合恢复${lv * 100}点生命值`],
  };
}

export function huiNei(lv) {
  return {
    name: `回内 Lv${lv}`,
    effect: [`每回合恢复${lv * 100}点内力值`],
  };
}

export function huiTi(lv) {
  return {
    [`回体 Lv${lv}`]: `每回合恢复${lv}点体力值`,
    name: `回体 Lv${lv}`,
    effect: [`每回合恢复${lv}点体力值`],
  };
}

export function huiQi(lv) {
  return {
    name: `回气 Lv${lv}`,
    effect: [`每回合恢复${lv}点气力值`],
  };
}

export function huiNu(lv) {
  return {
    name: `回怒 Lv${lv}`,
    effect: [`每回合行动后恢复${lv * 2}点怒气值`],
  };
}

export function mingGui(lv) {
  return {
    name: `命归 Lv${lv}`,
    effect: [`每回合恢复最大生命值${lv * 2}%点生命值`],
  };
}

export function neiGui(lv) {
  return {
    name: `气归 Lv${lv}`,
    effect: [`每回合恢复最大内力值${lv * 2}%点内力值`],
  };
}

export function huiMingShiXu(lv) {
  return {
    name: `时序回命 Lv${lv}`,
    effect: [`每${timeSequence[lv]}时序恢复${lv * 2}点生命值`],
  };
}

export function huiNeiShiXu(lv) {
  return {
    name: `时序回内 Lv${lv}`,
    effect: [`每${timeSequence[lv]}时序恢复${lv * 2}点内力值`],
  };
}

export function huiTiShiXu(lv) {
  return {
    name: `时序回体 Lv${lv}`,
    effect: [`每${timeSequence[lv]}时序恢复1点体力值`],
  };
}

export function huiNuShiXu(lv) {
  return {
    name: `时序回怒 Lv${lv}`,
    effect: [`每${timeSequence[lv]}时序恢复${lv}点怒气值`],
  };
}

export function huiChun(lv) {
  return {
    name: `回春 Lv${lv}`,
    effect: [`每回合回复损失生命值的${lv * 5}%`],
  };
}

export function qiXueXiangSheng1(lv) {
  return {
    name: `气血相生Ⅰ Lv${lv}`,
    effect: [`如果(生命/生命最大值)百分比大于(内力值/内力最大值)百分比，则${timeSequence[lv]}时序回复${lv}%最大内力值`],
  };
}

export function qiXueXiangSheng2(lv) {
  return {
    name: `气血相生Ⅱ Lv${lv}`,
    effect: [`如果(生命/生命最大值)百分比小于(内力值/内力最大值)百分比，则${timeSequence[lv]}时序回复${lv}%最大生命值`],
  };
}

export function quDu(lv) {
  return {
    name: `袪毒 Lv${lv}`,
    effect: [`每回合清除${lv * 5}点中毒`],
  };
}

export function shangYao(lv) {
  return {
    name: `伤药 Lv${lv}`,
    effect: [`每回合清除${lv * 5}点灼烧`],
  };
}

export function quHan(lv) {
  return {
    name: `驱寒 Lv${lv}`,
    effect: [`每回合清除${lv * 5}点冰封`],
  };
}

export function zhiXue(lv) {
  return {
    name: `止血 Lv${lv}`,
    effect: [`每回合清除${lv * 5}点流血`],
  };
}

export function liaoShang(lv) {
  return {
    name: `疗伤 Lv${lv}`,
    effect: [`每回合清除${lv * 5}点内伤`],
  };
}

export function quDuShiXu(lv) {
  return {
    name: `时序祛毒 Lv${lv}`,
    effect: [`每${timeSequence[lv]}时序清除1点中毒`],
  };
}

export function shangYaoShiXu(lv) {
  return {
    name: `时序伤药 Lv${lv}`,
    effect: [`每${timeSequence[lv]}时序清除1点灼烧`],
  };
}

export function zhiXueShiXu(lv) {
  return {
    name: `时序止血 Lv${lv}`,
    effect: [`每${timeSequence[lv]}时序清除1点流血`],
  };
}

export function quHanShiXu(lv) {
  return {
    name: `时序驱寒 Lv${lv}`,
    effect: [`每${timeSequence[lv]}时序清除1点冰封`],
  };
}

export function liaoShangShiXu(lv) {
  return {
    name: `时序疗伤 Lv${lv}`,
    effect: [`每${timeSequence[lv]}时序清除1点内伤`],
  };
}

export function jieXueShiXu(lv) {
  return {
    name: `时序解穴 Lv${lv}`,
    effect: [`每${timeSequence[lv]}时序清除1点封穴`],
  };
}

export function juLi(lv) {
  return {
    name: `聚力 Lv${lv}`,
    effect: [`每回合清除虚弱状态`],
  };
}

export function juQi(lv) {
  return {
    name: `聚气 Lv${lv}`,
    effect: [`每回合清除散功状态`],
  };
}

export function huJia(lv) {
  return {
    name: `护甲 Lv${lv}`,
    effect: [`每回合清除破甲状态`],
  };
}

export function mieHuo(lv) {
  return {
    name: `灭火 Lv${lv}`,
    effect: [`每回合清除点燃状态`],
  };
}

export function yuHe(lv) {
  return {
    name: `愈合 Lv${lv}`,
    effect: [`每回合清除撕裂状态`],
  };
}

export function jieDu(lv) {
  return {
    name: `解毒 Lv${lv}`,
    effect: [`每回合清除剧毒状态`],
  };
}
