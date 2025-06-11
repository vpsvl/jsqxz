/**
 * 免疫类
 */

// 各等级时序
const timeSequence = {
  1: 8,
  2: 6,
  3: 4,
  4: 2,
};

export function mianYiZhuoShao(lv) {
  return {
    name: `免疫灼烧 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率免疫灼烧`],
  };
}

export function mianYiBingFeng(lv) {
  return {
    name: `免疫冰封 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率免疫冰封`],
  };
}

export function mianYiLiuXie(lv) {
  return {
    name: `免疫流血 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率免疫流血`],
  };
}

export function mianYiFengXue(lv) {
  return {
    name: `免疫封穴 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率免疫封穴`],
  };
}

export function mianYiNeiShang(lv) {
  return {
    name: `免疫内伤 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率免疫内伤`],
  };
}

export function mianYiZhongDu(lv) {
  return {
    name: `免疫中毒 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率免疫中毒`],
  };
}

export function mianYiFanShang(lv) {
  return {
    name: `免疫反伤 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率免疫反弹、斗转、反击`],
  };
}

export function mianYiShaQi(lv) {
  return {
    name: `免疫杀气 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率免疫杀气`],
  };
}

export function mianYiPoZhan(lv) {
  return {
    name: `免疫破绽 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率免疫破绽`],
  };
}

export function baTi(lv) {
  return {
    name: `霸体 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率免疫伤害`],
  };
}

export function buQuShaQi(lv) {
  return {
    name: `不屈 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%杀气不会低于${(lv - 1) * 80}`],
  };
}

export function qingXin(lv) {
  return {
    name: `清心`,
    effect: [`集气不受异常状态影响`],
  };
}

export function yunQiJieXue(lv) {
  return {
    name: `运气解穴 Lv${lv}`,
    effect: [`当被封穴后每${timeSequence[lv] + 4}时序自动清除封穴`],
  };
}

export function yunQiJieDu(lv) {
  return {
    name: `运气解毒 Lv${lv}`,
    effect: [`当有中毒状态时${timeSequence[lv] + 10}时序自动清除中毒`],
  };
}

export function yunQiChuBing(lv) {
  return {
    name: `运气除冰 Lv${lv}`,
    effect: [`当有冰封状态时每${timeSequence[lv] + 10}时序自动清除冰封`],
  };
}

export function yunQiBiHuo(lv) {
  return {
    name: `运气辟火 Lv${lv}`,
    effect: [`当有灼烧状态时${timeSequence[lv] + 10}时序自动清除灼烧`],
  };
}

export function yunQiZhiXue(lv) {
  return {
    name: `运气止血 Lv${lv}`,
    effect: [`当有流血状态时每${timeSequence[lv] + 10}时序自动清除流血`],
  };
}

export function yunQiLiaoShang(lv) {
  return {
    name: `运气疗伤 Lv${lv}`,
    effect: [`当有内伤状态时每${timeSequence[lv] + 10}时序自动清除内伤`],
  };
}
