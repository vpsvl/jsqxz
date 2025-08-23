/**
 * debuff类
 */

export function liuXue1(lv) {
  return {
    id: 500,
    name: `流血Ⅰ Lv${lv}`,
    effect: [`攻击${lv * 25}%概率必造成目标流血`],
  };
}

export function zhongDu1(lv) {
  return {
    name: `中毒Ⅰ Lv${lv}`,
    effect: [`攻击${lv * 25}%概率必造成目标中毒`],
  };
}

export function bingFeng1(lv) {
  return {
    name: `冰封Ⅰ Lv${lv}`,
    effect: [`攻击${lv * 25}%概率必造成目标冰封`],
  };
}

export function zhuoShao1(lv) {
  return {
    name: `灼烧Ⅰ Lv${lv}`,
    effect: [`攻击${lv * 25}%概率必造成目标灼烧`],
  };
}

export function neiShang1(lv) {
  return {
    name: `内伤Ⅰ Lv${lv}`,
    effect: [`攻击${lv * 25}%概率必造成目标内伤`],
  };
}

export function dianRan(lv) {
  return {
    name: `点燃 Lv${lv}`,
    effect: [`攻击${lv * 15}%概率造成目标点燃${lv * 3}时序`],
  };
}

export function dongJie(lv) {
  return {
    name: `冻结 Lv${lv}`,
    effect: [`攻击${lv * 15}%概率造成目标冻结${lv * 3}时序`],
  };
}

export function siLie(lv) {
  return {
    name: `撕裂 Lv${lv}`,
    effect: [`攻击${lv * 15}%概率造成目标撕裂${lv * 3}时序`],
  };
}

export function sanGong(lv) {
  return {
    name: `散功 Lv${lv}`,
    effect: [`攻击${lv * 15}%概率造成目标散功${lv * 3}时序`],
  };
}

export function poZhan(lv) {
  return {
    name: `破绽 Lv${lv}`,
    effect: [`攻击${lv * 15}%概率造成目标破绽${lv * 4}时序`],
  };
}

export function xuRuo(lv) {
  return {
    name: `虚弱 Lv${lv}`,
    effect: [`攻击${lv * 15}%概率造成目标虚弱${lv}回合`],
  };
}

export function poJia(lv) {
  return {
    name: `破甲 Lv${lv}`,
    effect: [`攻击${lv * 15}%概率造成目标破甲${lv}回合`],
  };
}

export function juDu(lv) {
  return {
    name: `剧毒 Lv${lv}`,
    effect: [`攻击${lv * 15}%概率造成目标剧毒${lv}回合`],
  };
}

export function fengXueQiangHua(lv) {
  let max = lv + 4;
  let min = lv * 2;
  return {
    name: `强化封穴 Lv${lv}`,
    effect: [`攻击追加封穴点数${min}~${max}点`],
  };
}

export function bingFengQiangHua(lv) {
  let max = lv + 4;
  let min = lv * 2;
  return {
    name: `强化冰封 Lv${lv}`,
    effect: [`攻击追加冰封点数${min}~${max}点`],
  };
}

export function zhuoShaoQiangHua(lv) {
  let max = lv + 4;
  let min = lv * 2;
  return {
    name: `强化灼烧 Lv${lv}`,
    effect: [`攻击追加灼烧点数${min}~${max}点`],
  };
}

export function zhongDuQiangHua(lv) {
  let max = lv + 4;
  let min = lv * 2;
  return {
    name: `强化中毒 Lv${lv}`,
    effect: [`攻击追加中毒点数${min}~${max}点`],
  };
}

export function liuXueQiangHua(lv) {
  let max = lv + 4;
  let min = lv * 2;
  return {
    name: `强化流血 Lv${lv}`,
    effect: [`攻击追加流血点数${min}~${max}点`],
  };
}

export function neiShangQiangHua(lv) {
  let max = lv + 4;
  let min = lv * 2;
  return {
    name: `强化内伤 Lv${lv}`,
    effect: [`攻击追加内伤点数${min}~${max}点`],
  };
}

export function hunLuan(lv) {
  return {
    name: `混乱 Lv${lv}`,
    effect: [`攻击时${lv * 20}%概率造成目标混乱1回合`],
  };
}

export function mangMu(lv) {
  return {
    name: `肓目 Lv${lv}`,
    effect: [`攻击时${lv * 20}%概率造成目标肓目1回合`],
  };
}

export function suoZu(lv) {
  return {
    name: `锁足 Lv${lv}`,
    effect: [`攻击时${lv * 20}%概率造成目标锁足1回合`],
  };
}

export function wenLuan(lv) {
  return {
    name: `紊乱 Lv${lv}`,
    effect: [`攻击时${lv * 15}%概率造成目标集气紊乱${lv * 2}时序`],
  };
}

export function rouWangShi(lv) {
  return {
    name: `柔网势 Lv${lv}`,
    effect: [`攻击时${lv * 25}%概率减少目标移动步数${lv + 1}步`],
  };
}
