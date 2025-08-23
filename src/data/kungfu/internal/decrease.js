/**
 * 减少受到的效果类
 */

export function jianShang(lv) {
  return {
    id: 400,
    name: `减伤 Lv${lv}`,
    effect: [`减少受到的伤害${lv * 50}点`],
  };
}

export function jiaQiangJianShang(lv) {
  return {
    id: 401,
    name: `加强减伤 Lv${lv}`,
    effect: [`减少受到的伤害${lv * 10}%`],
  };
}

export function jianLian(lv) {
  return {
    id: 402,
    name: `减连 Lv${lv}`,
    effect: [`减少受到的连击概率${lv * 10}%`],
  };
}

export function jianBao(lv) {
  return {
    id: 403,
    name: `减暴 Lv${lv}`,
    effect: [`减少受到的连击概率${lv * 10}%`],
  };
}

export function lianJiJianShang(lv) {
  return {
    id: 404,
    name: `连击减伤 Lv${lv}`,
    effect: [`被连击时减少${lv * 15}%受到的伤害`],
  };
}

export function baoJiJianShang(lv) {
  return {
    id: 405,
    name: `暴击减伤 Lv${lv}`,
    effect: [`被暴击时减少${lv * 15}%受到的伤害`],
  };
}

export function jianShaoFengXue(lv) {
  return {
    id: 406,
    name: `减少封穴 Lv${lv}`,
    effect: [`减少受到的封穴点数${lv * 2}`],
  };
}

export function quHanJianShao(lv) {
  return {
    id: 407,
    name: `祛寒 Lv${lv}`,
    effect: [`减少受到的冰封点数${lv * 2}`],
  };
}

export function yuHeJianShao(lv) {
  return {
    id: 408,
    name: `愈合 Lv${lv}`,
    effect: [`减少受到的内伤点数${lv * 2}`],
  };
}

export function huaDuJianShao(lv) {
  return {
    id: 409,
    name: `化毒 Lv${lv}`,
    effect: [`减少受到的中毒点数${lv * 2}`],
  };
}

export function bingXinJianshao(lv) {
  return {
    id: 410,
    name: `冰心 Lv${lv}`,
    effect: [`减少受到的灼烧点数${lv * 2}`],
  };
}

export function baoZhaJianShao(lv) {
  return {
    id: 411,
    name: `包扎 Lv${lv}`,
    effect: [`减少受到的流血点数${lv * 2}`],
  };
}

export function huaJinJianShao(lv) {
  return {
    id: 412,
    name: `化劲 Lv${lv}`,
    effect: [`减少受到的气攻点数${lv * 200}`],
  };
}

export function poQuanJue(lv) {
  return {
    id: 413,
    name: `破拳诀 Lv${lv}`,
    effect: [`减少受到的拳掌武功伤害${lv * 15}%`],
  };
}

export function poZhiJue(lv) {
  return {
    id: 414,
    name: `破指诀 Lv${lv}`,
    effect: [`减少受到的指腿武功伤害${lv * 15}%`],
  };
}

export function poJianJue(lv) {
  return {
    id: 415,
    name: `破剑诀 Lv${lv}`,
    effect: [`减少受到的剑法武功伤害${lv * 15}%`],
  };
}

export function poDaoJue(lv) {
  return {
    id: 416,
    name: `破刀诀 Lv${lv}`,
    effect: [`减少受到的刀法武功伤害${lv * 15}%`],
  };
}

export function poQiJue(lv) {
  return {
    id: 417,
    name: `破奇诀 Lv${lv}`,
    effect: [`减少受到的奇门武功伤害${lv * 15}%`],
  };
}

export function poQiJue1(lv) {
  return {
    id: 418,
    name: `破气诀Ⅰ Lv${lv}`,
    effect: [`减少受到的内功武功伤害${lv * 15}%`],
  };
}
