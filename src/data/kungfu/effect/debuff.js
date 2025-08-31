/**
 * debuff类
 */

function qiangHuaRangeNum(lv) {
  let max = lv + 4;
  let min = lv * 2;
  let range = `${min}~${max}`;
  if (max === min) {
    range = max;
  }
  return range;
}

export function liuXue1(lv) {
  return {
    id: 500,
    name: `流血Ⅰ Lv${lv}`,
    effect: [`攻击${lv * 25}%概率必造成目标流血`],
  };
}

export function zhongDu1(lv) {
  return {
    id: 501,
    name: `中毒Ⅰ Lv${lv}`,
    effect: [`攻击${lv * 25}%概率必造成目标中毒`],
  };
}

export function bingFeng1(lv) {
  return {
    id: 502,
    name: `冰封Ⅰ Lv${lv}`,
    effect: [`攻击${lv * 25}%概率必造成目标冰封`],
  };
}

export function zhuoShao1(lv) {
  return {
    id: 503,
    name: `灼烧Ⅰ Lv${lv}`,
    effect: [`攻击${lv * 25}%概率必造成目标灼烧`],
  };
}

export function neiShang1(lv) {
  return {
    id: 504,
    name: `内伤Ⅰ Lv${lv}`,
    effect: [`攻击${lv * 25}%概率必造成目标内伤`],
  };
}

export function dianRan(lv) {
  return {
    id: 505,
    name: `点燃 Lv${lv}`,
    effect: [`攻击${lv * 15}%概率造成目标点燃${lv * 3}时序`],
  };
}

export function dongJie(lv) {
  return {
    id: 506,
    name: `冻结 Lv${lv}`,
    effect: [`攻击${lv * 15}%概率造成目标冻结${lv * 3}时序`],
  };
}

export function siLie(lv) {
  return {
    id: 507,
    name: `撕裂 Lv${lv}`,
    effect: [`攻击${lv * 15}%概率造成目标撕裂${lv * 3}时序`],
  };
}

export function sanGong(lv) {
  return {
    id: 508,
    name: `散功 Lv${lv}`,
    effect: [`攻击${lv * 15}%概率造成目标散功${lv * 3}时序`],
  };
}

export function xuRuo(lv) {
  return {
    id: 509,
    name: `虚弱 Lv${lv}`,
    effect: [`攻击${lv * 15}%概率造成目标虚弱${lv}回合`],
  };
}

export function poJia(lv) {
  return {
    id: 510,
    name: `破甲 Lv${lv}`,
    effect: [`攻击${lv * 15}%概率造成目标破甲${lv}回合`],
  };
}

export function juDu(lv) {
  return {
    id: 511,
    name: `剧毒 Lv${lv}`,
    effect: [`攻击${lv * 15}%概率造成目标剧毒${lv}回合`],
  };
}

export function poZhan(lv) {
  return {
    id: 512,
    name: `破绽 Lv${lv}`,
    effect: [`攻击${lv * 15}%概率造成目标破绽${lv * 4}时序`],
  };
}

export function qiangHuaFengXue(lv) {
  return {
    id: 513,
    name: `强化封穴 Lv${lv}`,
    effect: [`攻击追加封穴点数${qiangHuaRangeNum(lv)}点`],
  };
}

export function qiangHuaBingFeng(lv) {
  return {
    id: 514,
    name: `强化冰封 Lv${lv}`,
    effect: [`攻击追加冰封点数${qiangHuaRangeNum(lv)}点`],
  };
}

export function qiangHuaZhuoShao(lv) {
  return {
    id: 515,
    name: `强化灼烧 Lv${lv}`,
    effect: [`攻击追加灼烧点数${qiangHuaRangeNum(lv)}点`],
  };
}

export function qiangHuaZhongDu(lv) {
  return {
    id: 516,
    name: `强化中毒 Lv${lv}`,
    effect: [`攻击追加中毒点数${qiangHuaRangeNum(lv)}点`],
  };
}

export function qiangHuaLiuXue(lv) {
  return {
    id: 517,
    name: `强化流血 Lv${lv}`,
    effect: [`攻击追加流血点数${qiangHuaRangeNum(lv)}点`],
  };
}

export function qiangHuaNeiShang(lv) {
  return {
    id: 518,
    name: `强化内伤 Lv${lv}`,
    effect: [`攻击追加内伤点数${qiangHuaRangeNum(lv)}点`],
  };
}

export function hunLuan(lv) {
  return {
    id: 519,
    name: `混乱 Lv${lv}`,
    effect: [`攻击时${lv * 20}%概率造成目标混乱1回合`],
  };
}

export function mangMu(lv) {
  return {
    id: 520,
    name: `肓目 Lv${lv}`,
    effect: [`攻击时${lv * 20}%概率造成目标肓目1回合`],
  };
}

export function wenLuan(lv) {
  return {
    id: 521,
    name: `紊乱 Lv${lv}`,
    effect: [`攻击时${lv * 15}%概率造成目标集气紊乱${lv * 2}时序`],
  };
}

export function suoZu(lv) {
  return {
    id: 522,
    name: `锁足 Lv${lv}`,
    effect: [`攻击时${lv * 20}%概率造成目标锁足1回合`],
  };
}

export function rouWangShi(lv) {
  return {
    id: 523,
    name: `柔网势 Lv${lv}`,
    effect: [`攻击时${lv * 25}%概率减少目标移动步数${lv + 1}步`],
  };
}
