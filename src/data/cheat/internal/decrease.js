/**
 * 减少受到的效果类
 */

export function jianShang(lv) {
  return {
    name: `减伤 Lv${lv}`,
    effect: [`减少受到的伤害${lv * 50}点`],
  };
}

export function jianShangJiaQiang(lv) {
  return {
    name: `加强减伤 Lv${lv}`,
    effect: [`减少受到的伤害${lv * 10}%`],
  };
}

export function jianLian(lv) {
  return {
    name: `减连 Lv${lv}`,
    effect: [`减少受到的连击概率${lv * 10}%`],
  };
}

export function jianBao(lv) {
  return {
    name: `减暴 Lv${lv}`,
    effect: [`减少受到的连击概率${lv * 10}%`],
  };
}

export function lianJiJianShang(lv) {
  return {
    name: `连击减伤 Lv${lv}`,
    effect: [`被连击时减少${lv * 15}%受到的伤害`],
  };
}

export function baoJiJianShang(lv) {
  return {
    name: `暴击减伤 Lv${lv}`,
    effect: [`被暴击时减少${lv * 15}%受到的伤害`],
  };
}

export function jianShaoFengXue(lv) {
  return {
    name: `减少封穴 Lv${lv}`,
    effect: [`减少受到的封穴点数${lv * 2}`],
  };
}

export function quHan(lv) {
  return {
    name: `祛寒 Lv${lv}`,
    effect: [`减少受到的冰封点数${lv * 2}`],
  };
}

export function yuHe(lv) {
  return {
    name: `愈合 Lv${lv}`,
    effect: [`减少受到的内伤点数${lv * 2}`],
  };
}

export function huaDu(lv) {
  return {
    name: `化毒 Lv${lv}`,
    effect: [`减少受到的中毒点数${lv * 2}`],
  };
}

export function bingXin(lv) {
  return {
    name: `冰心 Lv${lv}`,
    effect: [`减少受到的灼烧点数${lv * 2}`],
  };
}

export function baoZha(lv) {
  return {
    name: `包扎 Lv${lv}`,
    effect: [`减少受到的流血点数${lv * 2}`],
  };
}

export function huaJin(lv) {
  return {
    name: `化劲 Lv${lv}`,
    effect: [`减少受到的气攻点数${lv * 200}`],
  };
}

export function poQuanJue(lv) {
  return {
    name: `破拳诀 Lv${lv}`,
    effect: [`减少受到的拳掌武功伤害${lv * 15}%`],
  };
}

export function poZhiJue(lv) {
  return {
    name: `破指诀 Lv${lv}`,
    effect: [`减少受到的指腿武功伤害${lv * 15}%`],
  };
}

export function poJianJue(lv) {
  return {
    name: `破剑诀 Lv${lv}`,
    effect: [`减少受到的剑法武功伤害${lv * 15}%`],
  };
}

export function poDaoJue(lv) {
  return {
    name: `破刀诀 Lv${lv}`,
    effect: [`减少受到的刀法武功伤害${lv * 15}%`],
  };
}

export function poQiJue(lv) {
  return {
    name: `破奇诀 Lv${lv}`,
    effect: [`减少受到的奇门武功伤害${lv * 15}%`],
  };
}

export function poNeiJue(lv) {
  return {
    name: `破气诀Ⅰ Lv${lv}`,
    effect: [`减少受到的内功武功伤害${lv * 15}%`],
  };
}
