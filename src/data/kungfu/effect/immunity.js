/**
 * 免疫类
 */

// 各等级时序
const immunityTimeSequence = {
  1: 8,
  2: 6,
  3: 4,
  4: 2,
};

export function mianYiZhuoShao(lv) {
  return {
    id: 600,
    name: `免疫灼烧 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率免疫灼烧`],
  };
}

export function mianYiLiuXie(lv) {
  return {
    id: 601,
    name: `免疫流血 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率免疫流血`],
  };
}

export function mianYiShaQi(lv) {
  return {
    id: 602,
    name: `免疫杀气 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率免疫杀气`],
  };
}

export function mianYiFengXue(lv) {
  return {
    id: 603,
    name: `免疫封穴 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率免疫封穴`],
  };
}

export function mianYiBingFeng(lv) {
  return {
    id: 604,
    name: `免疫冰封 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率免疫冰封`],
  };
}

export function mianYiNeiShang(lv) {
  return {
    id: 605,
    name: `免疫内伤 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率免疫内伤`],
  };
}

export function mianYiZhongDu(lv) {
  return {
    id: 606,
    name: `免疫中毒 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率免疫中毒`],
  };
}

export function mianYiFanShang(lv) {
  return {
    id: 607,
    name: `免疫反伤 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率免疫反弹、斗转、反击`],
  };
}

export function baTi(lv) {
  return {
    id: 608,
    name: `霸体 Lv${lv}`,
    effect: [`受到攻击时${lv * 5}%概率免疫伤害`],
  };
}

export function mianYiPoZhan(lv) {
  return {
    id: 609,
    name: `免疫破绽 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率免疫破绽`],
  };
}

export function buQuShaQi(lv) {
  return {
    id: 610,
    name: `不屈 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%杀气不会低于${(lv - 1) * 80}`],
  };
}

export function qingXin(lv) {
  return {
    id: 611,
    name: `清心 Lv${lv}`,
    effect: [`集气不受异常状态影响`],
  };
}

export function yunQiJieXue(lv) {
  return {
    id: 612,
    name: `运气解穴 Lv${lv}`,
    effect: [`当被封穴后每${immunityTimeSequence[lv] + 4}时序自动清除封穴`],
  };
}

export function yunQiJieDu(lv) {
  return {
    id: 613,
    name: `运气解毒 Lv${lv}`,
    effect: [`当有中毒状态时${immunityTimeSequence[lv] + 10}时序自动清除中毒`],
  };
}

export function yunQiChuBing(lv) {
  return {
    id: 614,
    name: `运气除冰 Lv${lv}`,
    effect: [`当有冰封状态时每${immunityTimeSequence[lv] + 10}时序自动清除冰封`],
  };
}

export function yunQiZhiXue(lv) {
  return {
    id: 615,
    name: `运气止血 Lv${lv}`,
    effect: [`当有流血状态时每${immunityTimeSequence[lv] + 10}时序自动清除流血`],
  };
}

export function yunQiLiaoShang(lv) {
  return {
    id: 616,
    name: `运气疗伤 Lv${lv}`,
    effect: [`当有内伤状态时每${immunityTimeSequence[lv] + 10}时序自动清除内伤`],
  };
}

export function yunQiBiHuo(lv) {
  return {
    id: 617,
    name: `运气辟火 Lv${lv}`,
    effect: [`当有灼烧状态时${immunityTimeSequence[lv] + 10}时序自动清除灼烧`],
  };
}
