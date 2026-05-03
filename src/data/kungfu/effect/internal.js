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
/**
 * 增加自身效果类
 */

export function fenLi(lv) {
  return {
    id: 300,
    name: `奋力 Lv${lv}`,
    effect: [`增加伤害${(lv + 1) * 6}%`],
  };
}

export function lianJi(lv) {
  return {
    id: 301,
    name: `连击 Lv${lv}`,
    effect: [`攻击时${lv * 10}%概率增加${lv > 2 ? 2 : 1}次连击`],
  };
}

export function lianShang(lv) {
  return {
    id: 302,
    name: `连伤 Lv${lv}`,
    effect: [`增加连击伤害${lv * 10}%`],
  };
}

export function baoShang(lv) {
  return {
    id: 303,
    name: `暴伤 Lv${lv}`,
    effect: [`增加暴击伤害${lv * 10}%`],
  };
}

export function houFaXianZhi(lv) {
  return {
    id: 304,
    name: `后发先至 Lv${lv}`,
    effect: [`初始集气位置-500，每有一个人行动，则自身${lv * 10}%概率集气+${lv * 50}`],
  };
}

export function jiFeng(lv) {
  return {
    id: 305,
    name: `疾风 Lv${lv}`,
    effect: [`增加集气速度${lv * 2}`],
  };
}

export function gangTi(lv) {
  return {
    id: 306,
    name: `罡体 Lv${lv}`,
    effect: [`增加气防${lv * 250}点`],
  };
}

export function qiangHuaGangTi(lv) {
  return {
    id: 307,
    name: `强化罡体 Lv${lv}`,
    effect: [`增加气防${lv * 10}%`],
  };
}

export function gangQi(lv) {
  return {
    id: 308,
    name: `罡气 Lv${lv}`,
    effect: [`增加气攻${lv * 250}点`],
  };
}

export function qiangHuaGangQi(lv) {
  return {
    id: 309,
    name: `强化罡气 Lv${lv}`,
    effect: [`增加气攻${lv * 25}%`],
  };
}

export function shiXuXuQi(lv) {
  return {
    id: 310,
    name: `时序蓄气 Lv${lv}`,
    effect: [`时序增加蓄气值${lv * 2}点`],
  };
}

export function siShenZhiWen(lv) {
  return {
    id: 311,
    name: `死神之吻 Lv${lv}`,
    effect: [`追加(冰封值+燃烧值+流血+中毒值+内伤值)${lv * 50}%的伤害`],
  };
}

export function bingShang(lv) {
  return {
    id: 312,
    name: `冰伤 Lv${lv}`,
    effect: [`附加冰封值${lv * 50}%真实伤害`],
  };
}

export function huoShang(lv) {
  return {
    id: 313,
    name: `火伤 Lv${lv}`,
    effect: [`附加灼烧值${lv * 50}%真实伤害`],
  };
}

export function xueShang(lv) {
  return {
    id: 314,
    name: `血伤 Lv${lv}`,
    effect: [`附加流血值${lv * 50}%真实伤害`],
  };
}

export function duShang(lv) {
  return {
    id: 315,
    name: `毒伤 Lv${lv}`,
    effect: [`附加中毒值${lv * 50}%真实伤害`],
  };
}

export function neiShang(lv) {
  return {
    id: 316,
    name: `内伤 Lv${lv}`,
    effect: [`附加内伤值${lv * 50}%真实伤害`],
  };
}

export function miaoZhun(lv) {
  return {
    id: 317,
    name: `瞄准 Lv${lv}`,
    effect: [`增加七格内我方被攻击时的命中${lv * 5}%`],
  };
}

export function guWu(lv) {
  return {
    id: 318,
    name: `鼓舞 Lv${lv}`,
    effect: [`增加七格内我方攻击时的伤害${lv * 5}%`],
  };
}

export function xieFang(lv) {
  return {
    id: 319,
    name: `协防 Lv${lv}`,
    effect: [`减少七格内我方受攻击时的伤害${lv * 5}%`],
  };
}

export function lianDong(lv) {
  return {
    id: 320,
    name: `连动 Lv${lv}`,
    effect: [`增加七格内我方集气速度${lv * 2}点`],
  };
}

export function xueZhanBaFang(lv) {
  return {
    id: 321,
    name: `血战八方 Lv${lv}`,
    effect: [
      `击败敌方后增加1点血战，每1点血战增加${lv * 10}%伤害，并在攻击时造成大范围伤害、追加800气攻、附加卸甲状态`,
    ],
  };
}

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
    effect: [`减少受到的暴击概率${lv * 10}%`],
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

/**
 * 免疫类
 */

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
    effect: [`当被封穴后每${14 - lv * 2}时序自动清除封穴`],
  };
}

export function yunQiJieDu(lv) {
  return {
    id: 613,
    name: `运气解毒 Lv${lv}`,
    effect: [`当有中毒状态时${20 - lv * 2}时序自动清除中毒`],
  };
}

export function yunQiChuBing(lv) {
  return {
    id: 614,
    name: `运气除冰 Lv${lv}`,
    effect: [`当有冰封状态时每${20 - lv * 2}时序自动清除冰封`],
  };
}

export function yunQiZhiXue(lv) {
  return {
    id: 615,
    name: `运气止血 Lv${lv}`,
    effect: [`当有流血状态时每${20 - lv * 2}时序自动清除流血`],
  };
}

export function yunQiLiaoShang(lv) {
  return {
    id: 616,
    name: `运气疗伤 Lv${lv}`,
    effect: [`当有内伤状态时每${20 - lv * 2}时序自动清除内伤`],
  };
}

export function yunQiBiHuo(lv) {
  return {
    id: 617,
    name: `运气辟火 Lv${lv}`,
    effect: [`当有灼烧状态时${20 - lv * 2}时序自动清除灼烧`],
  };
}

/**
 * 增加属性类
 */

export function weiLiZengQiang(lv) {
  return {
    id: 700,
    name: `威力增强 Lv${lv}`,
    effect: [`增加自身全部武功威力${lv * 100}点`],
  };
}

export function fengMei(lv) {
  return {
    id: 701,
    name: `风媒 Lv${lv}`,
    effect: [`增加自身集气值${lv * 2}点`],
  };
}

export function shenLi(lv) {
  return {
    id: 702,
    name: `神力 Lv${lv}`,
    effect: [`增加攻击力${lv * 60}点`],
  };
}

export function lianTi(lv) {
  return {
    id: 703,
    name: `炼体 Lv${lv}`,
    effect: [`增加防御力${lv * 60}点`],
  };
}

export function qingShen(lv) {
  return {
    id: 704,
    name: `轻身 Lv${lv}`,
    effect: [`增加轻功${lv * 60}点`],
  };
}

export function lianZhan(lv) {
  return {
    id: 705,
    name: `连战 Lv${lv}`,
    effect: [`增加连击率${lv * 10}%`],
  };
}

export function zhongJi(lv) {
  return {
    id: 706,
    name: `重击 Lv${lv}`,
    effect: [`增加暴击率${lv * 10}%`],
  };
}

export function yongDu(lv) {
  return {
    id: 707,
    name: `用毒 Lv${lv}`,
    effect: [`增加战场加用毒能力${lv * 15}点`],
  };
}

export function jiBu(lv) {
  return {
    id: 708,
    name: `积步 Lv${lv}`,
    effect: [`增加移动距离${lv}`],
  };
}

export function shenQuan(lv) {
  return {
    id: 709,
    name: `神拳 Lv${lv}`,
    effect: [`增加拳掌系数${lv * 10}%`],
  };
}

export function shenZhi(lv) {
  return {
    id: 710,
    name: `神指 Lv${lv}`,
    effect: [`增加指腿系数${lv * 10}%`],
  };
}

export function shenJian(lv) {
  return {
    id: 711,
    name: `神剑 Lv${lv}`,
    effect: [`增加御剑系数${lv * 10}%`],
  };
}

export function shenDao(lv) {
  return {
    id: 712,
    name: `神刀 Lv${lv}`,
    effect: [`增加刀法系数${lv * 10}%`],
  };
}

export function shenBing(lv) {
  return {
    id: 713,
    name: `神兵 Lv${lv}`,
    effect: [`增加奇门系数${lv * 10}%`],
  };
}

export function baiQi(lv) {
  return {
    id: 714,
    name: `百器 Lv${lv}`,
    effect: [`增加全系数${(lv + 1) * 6}%`],
  };
}

export function qiangShenLi(lv) {
  return {
    id: 715,
    name: `强·神力 Lv${lv}`,
    effect: [`增加攻击力${lv * 10}%`],
  };
}

export function qiangLianLi(lv) {
  return {
    id: 716,
    name: `强·炼体 Lv${lv}`,
    effect: [`增加防御力${lv * 10}%`],
  };
}

export function qiangQingShen(lv) {
  return {
    id: 717,
    name: `强·轻身 Lv${lv}`,
    effect: [`增加轻功${lv * 10}%`],
  };
}

export function shanBiZengQiang(lv) {
  return {
    id: 718,
    name: `闪避增强 Lv${lv}`,
    effect: [`增加闪避${lv * 50}点`],
  };
}

export function geDangZengQiang(lv) {
  return {
    id: 719,
    name: `格挡增强 Lv${lv}`,
    effect: [`增加格挡${lv * 50}点`],
  };
}

export function mingZhongZengQiang(lv) {
  return {
    id: 720,
    name: `命中增强 Lv${lv}`,
    effect: [`增加命中${lv * 50}点`],
  };
}

export function fengShenZhiLi(lv) {
  return {
    id: 721,
    name: `风神之力 Lv${lv}`,
    effect: [`增加命中、格挡、闪避${lv * 30}点`],
  };
}

export function shanBiZengQiang1(lv) {
  return {
    id: 722,
    name: `闪避增强Ⅰ Lv${lv}`,
    effect: [`增加闪避${lv * 8}%`],
  };
}

export function geDangZengQiang1(lv) {
  return {
    id: 723,
    name: `格挡增强Ⅰ Lv${lv}`,
    effect: [`增加格挡${lv * 8}%`],
  };
}

export function mingZhongZengQiang1(lv) {
  return {
    id: 724,
    name: `命中增强Ⅰ Lv${lv}`,
    effect: [`增加命中${lv * 8}%`],
  };
}

export function fengShenZhiLi1(lv) {
  return {
    id: 725,
    name: `风神之力Ⅰ Lv${lv}`,
    effect: [`增加命中、格挡、闪避${lv * 5}%`],
  };
}
/**
 * 受击类
 */

export function yiQiSuNiSheng(lv) {
  return {
    id: 800,
    name: `意气素霓生 Lv${lv}`,
    effect: [
      '攻击概率触发【太玄之重】，此次造成的伤害不加怒气',
      `攻击时${lv * 15}%概率判定敌方生命百分比，高于75%/50%/25%，此次伤害必附加敌方最大生命值的5%/6%/7%的伤害`,
    ],
  };
}

export function hunDunTaiXuan(lv) {
  return {
    id: 801,
    name: `混沌太玄 Lv${lv}`,
    effect: [
      `受到伤害时触发：（需激活）`,
      `└五岳倒为轻：${(lv + 1) * 6}%概率触发，将杀气的${(lv + 1) * 15}%转化为自身的集气，将所受伤害的${(lv + 1) * 15}%转化为生命恢复`,
      `└救赵挥金锤：不触发【五岳倒为轻】${(lv + 1) * 6}%概率打断敌方攻击，并增加自身集气位置${lv * 50}点`,
    ],
  };
}

export function jieLi(lv) {
  return {
    id: 802,
    name: `借力 Lv${lv}`,
    effect: [`受到伤害时将受到的伤害的${lv * 6}%转化为蓄气值，攻击时根据蓄气值增加气攻和真实伤害`],
  };
}

export function zhuanYinYang(lv) {
  return {
    id: 803,
    name: `转阴阳 Lv${lv}`,
    effect: [`受到伤害时${lv * 8}%概率将受到的异常状态转移给攻击方`],
  };
}

export function nuoYi(lv) {
  return {
    id: 804,
    name: `挪移 Lv${lv}`,
    effect: [`受到伤害时${lv * 5}%概率挪移到${lv + 3}格内其他位置躲避伤害`],
  };
}

export function guiXing(lv) {
  return {
    id: 805,
    name: `龟形 Lv${lv}`,
    effect: [`受到伤害时${lv * 20}%概率进入防御状态`],
  };
}

export function fanTan(lv) {
  return {
    id: 806,
    name: `反弹 Lv${lv}`,
    effect: [`受到伤害时${lv * 25}%概率反弹50%的伤害`],
  };
}

export function fanZhen(lv) {
  return {
    id: 807,
    name: `反震 Lv${lv}`,
    effect: [`受到伤害时${lv * 25}%概率反震伤害，使敌方也受到此次伤害的一半`],
  };
}

export function yaZi(lv) {
  return {
    id: 808,
    name: `睚眦 Lv${lv}`,
    effect: [`受到伤害时${lv * 25}%概率反弹杀气给随机敌方`],
  };
}

export function duanGu(lv) {
  return {
    id: 809,
    name: `锻骨 Lv${lv}`,
    effect: [`受到伤害时${lv * 25}%概率减少体质百分比的伤害`],
  };
}

export function xiNeiBeiDong(lv) {
  return {
    id: 810,
    name: `吸内·被动 Lv${lv}`,
    effect: [`受到伤害时${lv * 25}%概率吸取敌方的内力值${lv * 100}点`],
  };
}

export function xiTiBeiDong(lv) {
  return {
    id: 811,
    name: `吸体·被动 Lv${lv}`,
    effect: [`受到伤害时${lv * 25}%概率吸取敌方的体力值${lv}点`],
  };
}

export function xiNuBeiDong(lv) {
  return {
    id: 812,
    name: `吸怒·被动 Lv${lv}`,
    effect: [`受到伤害时${lv * 25}%概率吸取敌方的怒气值${lv * 2}点`],
  };
}

export function daZongShi(lv) {
  return {
    id: 813,
    name: `大宗师 Lv${lv}`,
    effect: [`受到伤害时${lv * 6}%概率时序恢复1%生命值、1%内力值、1点体力，效果持续${lv * 2}时序`],
  };
}

export function duanRen2(lv) {
  return {
    id: 814,
    name: `断刃Ⅱ Lv${lv}`,
    effect: [`受到攻击时${lv * 15}%概率无视敌方附加攻击力`],
  };
}

export function duanRen1(lv) {
  return {
    id: 815,
    name: `断刃Ⅰ Lv${lv}`,
    effect: [`受到攻击时${lv * 15}%概率无视敌方基础攻击力`],
  };
}

export function buMieJinShen(lv) {
  return {
    id: 816,
    name: `不灭金身 Lv${lv}`,
    effect: [`当生命值少于最大生命值50%时，受到攻击时免疫伤害${lv * 3}时序，冷却100时序`],
  };
}

export function qingQuanYangZhi(lv) {
  return {
    id: 817,
    name: `擎拳仰止 Lv${lv}`,
    effect: [
      `受到拳掌武功攻击时或使用拳掌武功主动攻击时${lv * 20}%概率敌方拳掌系数为0`,
      `受到拳掌武功的伤害减少${lv * 10}%`,
    ],
  };
}

export function zhiYinJiangHu(lv) {
  return {
    id: 818,
    name: `指引江湖 Lv${lv}`,
    effect: [
      `受到指腿武功攻击时或使用指腿武功主动攻击时${lv * 20}%概率敌方指腿系数为0`,
      `受到指腿武功的伤害减少${lv * 10}%`,
    ],
  };
}

export function wanJianGuiZong(lv) {
  return {
    id: 819,
    name: `万剑归宗 Lv${lv}`,
    effect: [
      `受到剑法武功攻击时或使用剑法武功主动攻击时${lv * 20}%概率敌方剑法系数为0`,
      `受到剑法武功的伤害减少${lv * 10}%`,
    ],
  };
}

export function danShanWeiRen(lv) {
  return {
    id: 820,
    name: `刀山为韧 Lv${lv}`,
    effect: [
      `受到刀法武功攻击时或使用刀法武功主动攻击时${lv * 20}%概率敌方刀法系数为0`,
      `受到刀法武功的伤害减少${lv * 10}%`,
    ],
  };
}

export function qiMenBaiJie(lv) {
  return {
    id: 821,
    name: `奇门百解 Lv${lv}`,
    effect: [
      `受到奇门武功攻击时或使用奇门武功主动攻击时${lv * 20}%概率敌方奇门系数为0`,
      `受到奇门武功的伤害减少${lv * 10}%`,
    ],
  };
}

export function tianJiMiShu(lv) {
  return {
    id: 822,
    name: `天机秘术 Lv${lv}`,
    effect: [
      `受到攻击时${lv * 5}%概率触发天机秘术中的一种：`,
      '└将伤害反弹给敌方随机目标',
      '└挪移位置躲避伤害',
      '└闪避伤害',
      '└自身获得霸体状态一回合',
    ],
  };
}

export function lingBo(lv) {
  return {
    id: 823,
    name: `凌波 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%增加闪避${lv * 50}点，闪避后清除`],
  };
}

export function wuWang(lv) {
  return {
    id: 824,
    name: `无妄 Lv${lv}`,
    effect: [`受到攻击时${lv * 5}%概率无视必中，独立概率闪避攻击`],
  };
}

export function yiRong(lv) {
  return {
    id: 825,
    name: `易容 Lv${lv}`,
    effect: [`受到攻击时${lv * 10}%概率只受到误伤伤害`],
  };
}

export function poZhao(lv) {
  return {
    id: 826,
    name: `破招 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%增加格挡${lv * 50}点，格挡后清除`],
  };
}

export function geDang(lv) {
  return {
    id: 827,
    name: `格挡 Lv${lv}`,
    effect: [`受到攻击时二次判定${lv * 5}%概率触发格挡`],
  };
}

export function beiDongHuaGong(lv) {
  return {
    id: 828,
    name: `被动化功 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率减少攻击方内力${lv * 100}点`],
  };
}

export function rongHuiGuanTong(lv) {
  return {
    id: 829,
    name: `融会贯通 Lv${lv}`,
    effect: [`攻击与被攻击时，敌方系数为${100 - lv * 20}%`],
  };
}

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
    effect: [`攻击时${lv * 10}%概率三连击`],
  };
}

export function fanTan2(lv) {
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
    effect: [`攻击时提高(攻击消耗内力×2)点伤害，追加(当前内力×攻击消耗内力/2000)点气攻`],
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

/**
 * 特殊效果类
 */

export function wuWoWuXiang2(lv) {
  return {
    id: 1000,
    name: `无我无相Ⅱ Lv${lv}`,
    effect: [`攻击与防御时${lv * 25}%概率兵器值不低于敌方`],
  };
}

export function congHui(lv) {
  return {
    id: 1001,
    name: `聪慧 Lv${lv}`,
    effect: [`修炼武功或装备武器时系数要求减少${lv * 2}`],
  };
}

export function zaiDong(lv) {
  return {
    id: 1002,
    name: `再动 Lv${lv}`,
    effect: [`攻击或移动后如有未使用完移动步数可再次移动`],
  };
}

export function tiaoXi(lv) {
  return {
    id: 1003,
    name: `调息 Lv${lv}`,
    effect: [`行动后${lv * 25}%概率获得休息效果`],
  };
}

export function gangQiHuTi(lv) {
  return {
    id: 1004,
    name: `罡气护体 Lv${lv}`,
    effect: [`进入战场获得${lv * 125}点护盾，每${8 - lv}回合重新获得护盾`],
  };
}

export function chongSheng(lv) {
  return {
    id: 1005,
    name: `重生 Lv${lv}`,
    effect: [`被击败时${lv * 25}%概率重生，并恢复${lv * 25}已损失生命、内力和体力，并清除基础状态`],
  };
}

export function puTiShu(lv) {
  return {
    id: 1006,
    name: `菩提树 Lv${lv}`,
    effect: [`被攻击时${lv * 15}%概率降低攻击方${lv * 10}%的命中和闪避`],
  };
}

export function xuLiQiangHua(lv) {
  return {
    id: 1007,
    name: `蓄力强化 Lv${lv}`,
    effect: [`蓄力时必成功，蓄力后的攻击效果增加${lv * 18.75}%`],
  };
}

export function lingXiFenShui(lv) {
  return {
    id: 1008,
    name: `灵犀分水 Lv${lv}`,
    effect: [`受到攻击时${lv * 15}%概率由全部参战人数一起分担伤害`],
  };
}

export function zhiXiGanGe(lv) {
  return {
    id: 1009,
    name: `止息干戈 Lv${lv}`,
    effect: [`受到连击或暴击攻击时${lv * 20}%概率打断敌人攻击`],
  };
}

export function chiBo(lv) {
  return {
    id: 1010,
    name: `赤膊 Lv${lv}`,
    effect: [`未装备防具时，防御增加${lv * 50}点`],
  };
}

export function buZhan(lv) {
  return {
    id: 1011,
    name: `步战 Lv${lv}`,
    effect: [`未装备坐骑时，轻功增加${lv * 50}点`],
  };
}

export function kongShou(lv) {
  return {
    id: 1012,
    name: `空手 Lv${lv}`,
    effect: [`未装备武器时，攻击增加${lv * 50}点`],
  };
}

export function xianShou(lv) {
  return {
    id: 1013,
    name: `先手 Lv${lv}`,
    effect: [`战斗初始集气位置增加${lv * 100}`],
  };
}

export function buXi(lv) {
  return {
    id: 1014,
    name: `不息 Lv${lv}`,
    effect: [`杀气被杀到-100，清除全部内伤，并恢复${lv * 5}%生命`],
  };
}

export function guiXi(lv) {
  return {
    id: 1015,
    name: `龟息 Lv${lv}`,
    effect: [`受到第一击的伤害减少${lv * 15}%`],
  };
}

export function kuRong(lv) {
  return {
    id: 1016,
    name: `枯荣 Lv${lv}`,
    effect: [`行动后消耗${lv * 3}%内力最大值，恢复${lv * 3}%生命最大值`],
  };
}

export function tianXingJianGong(lv) {
  return {
    id: 1017,
    name: `天行健·攻 Lv${lv}`,
    effect: [`每次行动后增加${lv}%伤害`],
  };
}

export function tianXingJianShou(lv) {
  return {
    id: 1018,
    name: `天行健·守 Lv${lv}`,
    effect: [`每次行动后减少${lv}%受到的伤害`],
  };
}

export function buQu(lv) {
  return {
    id: 1019,
    name: `不屈 Lv${lv}`,
    effect: [`集气位置小于0时，减少受到的伤害${lv * 25}%`],
  };
}

export function bingHuoChongRong(lv) {
  return {
    id: 1020,
    name: `冰火重融 Lv${lv}`,
    effect: [`造成冰封/灼烧时${lv * 25}%概率造成灼烧/冰封`],
  };
}

export function baoYuLiHua(lv) {
  return {
    id: 1021,
    name: `暴雨梨花 Lv${lv}`,
    effect: [`行动前${lv * 25}%概率给自身五格内目标附加一个随机DEBUFF`],
  };
}

export function foGuangPuDu(lv) {
  return {
    id: 1022,
    name: `佛光普渡 Lv${lv}`,
    effect: [`每${5 - lv}回合${lv * 25}%概率清除流血、中毒、冰封、燃烧、内伤状态`],
  };
}

export function baoYuanShouYi(lv) {
  return {
    id: 1023,
    name: `抱元守一 Lv${lv}`,
    effect: [`每${5 - lv}回合${lv * 25}%概率清除大部分异常状态`],
  };
}

export function fuYuanJiaShen(lv) {
  return {
    id: 1024,
    name: `福缘加身 Lv${lv}`,
    effect: [`增加特效${lv * 2}点(非固定概率)`],
  };
}

export function wuShenZhiLi(lv) {
  return {
    id: 1025,
    name: `武神之力 Lv${lv}`,
    effect: [`增加三围${lv * 50}`],
  };
}

export function wuShenZhiLi2(lv) {
  return {
    id: 1026,
    name: `武神之力Ⅱ Lv${lv}`,
    effect: [`增加三围${lv * 5}%`],
  };
}

export function puDuCiHang(lv) {
  return {
    id: 1027,
    name: `普渡慈航 Lv${lv}`,
    effect: [`每回合恢复生命值、内力值、体力值的${lv + 1}%`],
  };
}

export function yiNianChengMo(lv) {
  return {
    id: 1028,
    name: `一念成魔 Lv${lv}`,
    effect: [`攻击时${lv * 8}%概率进入【魔神】状态：免疫杀气封穴，额外吸血20%`],
  };
}

export function taiJiZhiXing(lv) {
  return {
    id: 1029,
    name: `太极之形 Lv${lv}`,
    effect: [
      `被攻击时${lv * 15}%概率获得太极之形，每个太极之形增加1点集气，每5个太极之形增加一次连击`,
    ],
  };
}

export function ziDongFangYu(lv) {
  return {
    id: 1030,
    name: `自动防御 Lv${lv}`,
    effect: [`行动后${lv * 25}%概率自动防御，且减少受到的伤害${lv * 10}%`],
  };
}

export function weiWoDuZun(lv) {
  return {
    id: 1031,
    name: `唯我独尊 Lv${lv}`,
    effect: [`受到伤害时以伤害值${lv * 25}%内力抵消${lv * 25}%的伤害`],
  };
}

export function liuDaoLunHui(lv) {
  return {
    id: 1032,
    name: `六道轮回 Lv${lv}`,
    effect: [
      `进入战斗开始只有${lv * 20}%三围和五系，每回合+30%，每六个回合一轮回，轮回结束时全属性恢复到${lv * 20}%，并恢复${lv * 10}%的状态，清除所有异常状态`,
    ],
  };
}

export function kuiHuaBaiJie(lv) {
  return {
    id: 1033,
    name: `葵花百劫 Lv${lv}`,
    effect: [
      `每次闪避和挪移自身集气增加${lv}点，集气位置增加${lv * 100}，并给攻击方增加虚弱状态一回合`,
      `如果攻击方有盲目状态，则攻击方盲目状态增加一回合，行动前清除`,
    ],
  };
}

export function zhouLiuLiuXu(lv) {
  return {
    id: 1034,
    name: `周流六虚 Lv${lv}`,
    effect: [
      `攻击时${lv * 15}%概率触发：`,
      '└陷空力：伤害+50%一回合',
      '└生灭道：攻击后霸体一回合',
      '└旋涡击：增加一次连击',
      '└阴阳流：必冰封必灼烧',
      '└滴水劲：破防+50%',
      '└霹雳木：附加气攻值5%的伤害',
    ],
  };
}

export function jiuShenZhiLi(lv) {
  return {
    id: 1035,
    name: `酒神之力 Lv${lv}`,
    effect: [
      `行动前${lv * 25}%为自己增加即墨老酒/玉露酒/梨花酒/五宝花蜜酒之一效果，每种酒状态增加2层醉意，每层醉意伤害+10%/闪避+5%/命中减-5%`,
      `拥有醉意时${lv * 25}%概率击中目标破绽`,
      `醉意每回合自动减少1层，不可清除`,
    ],
  };
}

export function qiGuanWuYue(lv) {
  return {
    id: 1036,
    name: `气贯五岳 Lv${lv}`,
    effect: [
      `攻击时${lv * 25}%概率无视目标内功附加的防御力，伤害在${lv * 5 + 100}%~${lv * 15 + 100}%之间浮动`,
    ],
  };
}

export function yinDuNveYan(lv) {
  return {
    id: 1037,
    name: `引毒虐焰 Lv${lv}`,
    effect: [
      `攻击时追加目标中毒程度的真实伤害`,
      `如果敌方中毒大于100引爆全部中毒，造成中毒程度${lv + 1}倍的真实伤害`,
    ],
  };
}

export function shuShiDaiFa(lv) {
  return {
    name: `蓄势待发 Lv${lv}`,
    effect: [
      `蓄力必成功，同时执行防御和等待指令，且蓄力效果增加到50%。${lv * 25}%概率在行动自动执行蓄力`,
    ],
  };
}

export function qiYueRuShi(lv) {
  return {
    id: 1038,
    name: `气跃如逝 Lv${lv}`,
    effect: [`集气${lv * 5}%概率向前跳跃${lv * 10}时序`],
  };
}

export function taiShangWangQing(lv) {
  return {
    id: 1039,
    name: `太上忘情 Lv${lv}`,
    effect: [
      `攻击时${lv * 15}%概率触发风流/火延/云翳之一：`,
      `└风流：${lv * 5}%概率魅惑同性敌方，${lv * 15}%概率魅惑异性敌方`,
      `└火延：给全体敌方追加灼烧值`,
      `└云翳：攻击后10时序免疫伤害，冷却40时序`,
      `受到攻击时${lv * 15}%概率触发君王/师教/我无之一：`,
      `└君王：敌全体恐惧一回合`,
      `└师教：敌全体集气-200`,
      `└我无：免疫伤害一次`,
    ],
  };
}

export function shunXiQianLi(lv) {
  return {
    id: 1040,
    name: `瞬息千里 Lv${lv}`,
    effect: [`暴怒时集气速度增加${lv * 50}%，且集气不受异常状态影响`],
  };
}

export function taiXuanFanZhen(lv) {
  return {
    id: 1041,
    name: `太玄反震 Lv${lv}`,
    effect: [
      '太玄反震：（需激活）',
      `50%几率反震${lv * 15}%的伤害，并增加攻击方封穴值，${lv * 5}%概率下回合眩晕`,
      `免疫封穴`,
    ],
  };
}

export function xueMoZhiDun(lv) {
  return {
    id: 1042,
    name: `血魔之盾 Lv${lv}`,
    effect: [
      `每次行动前吸取七格内敌人的流血点数转化为自身的生命恢复，如恢复满生命则溢出部分转化为护盾，护盾不会超过自身生命的10%`,
    ],
  };
}

export function xianRenFuDing(lv) {
  return {
    id: 1043,
    name: `仙人抚顶 Lv${lv}`,
    effect: [
      `复活后增加一个最大生命${lv * 25}%的护盾，暴击率+${lv * 10}%，连击率+${lv * 10}%，伤害+${lv * 7.5}%，减伤+${lv * 7.5}%，气攻+${lv * 250}，气防+${lv * 250}`,
    ],
  };
}

export function zhiYangZhiGang(lv) {
  return {
    id: 1044,
    name: `至阳至刚 Lv${lv}`,
    effect: [
      `受到攻击将所受伤害的${lv * 5}%转化为护盾，受到伤害时，用一半护盾抵消伤害，每次护盾被击碎会对攻击方造成被击碎前护盾量2倍的伤害，当护盾被击碎三次后，护盾再次被击碎会马上恢复生命上限${lv * 5}%的护盾（上限5000点）且获得霸体${lv + 1}时序`,
    ],
  };
}

export function sanYuanGuiYi(lv) {
  return {
    id: 1045,
    name: `三元归一 Lv${lv}`,
    effect: [
      `三元流转：满足条件时触发天霜劲/虚云劲/神风劲之一`,
      `└天霜劲：行动前获得1层天霜劲，对五格范围内的敌方附加10~15点冰封值，攻击有冰封状态的敌人伤害+20%`,
      `└虚云劲：受到攻击时概率触发1层虚云劲，将敌方的气攻10%转化成自身的气防直到战斗结束`,
      `└神风劲：每六时序概率触发跟集气位置超过自己且最靠前的敌方更换集气位置，每更换一次增加一点神风劲，每点神风劲增加自己一点集气值`,
      `天霜劲+虚云劲+神风劲之和大于10层，则消耗所有三元状态且清空虚云劲增加的气防，回复自身状态50%，并且当前回合免疫伤害`,
    ],
  };
}

export function jiuYouXiuLuo(lv) {
  return {
    id: 1046,
    name: `九幽修罗 Lv${lv}`,
    effect: [
      `化功同时减少敌人的生命，攻击冻结的目标伤害增加20%，概率击碎的敌人冻结效果，造成目标最大生命值20%的伤害`,
    ],
  };
}

export function yinShaLianYu(lv) {
  return {
    id: 1047,
    name: `阴煞炼狱 Lv${lv}`,
    effect: [
      `周围九格内的敌人每1时序增加2点冰封，冰封值达到100点时概率冻结一回合`,
      `收集战场所有的冰封值转化为阴煞之力，阴煞之力转化为攻击力，防御力，集气值`,
    ],
  };
}

export function riZhaoYueMu(lv) {
  return {
    id: 1048,
    name: `日朝月暮 Lv${lv}`,
    effect: [`白天自身攻击力和集气大副提升，夜晚敌方防御和集气值大副降低`],
  };
}

export function riYueTongHui(lv) {
  return {
    id: 1049,
    name: `日月同辉 Lv${lv}`,
    effect: [
      `攻击时触发日之神威，吸取敌方的攻击力和防御力为已用`,
      `被攻击时触发月之神威，闪避和格挡随着月之神威的触发的次数大副提升`,
    ],
  };
}

export function tianDiDuZun(lv) {
  return {
    id: 1050,
    name: `天地独尊 Lv${lv}`,
    effect: [
      `攻击或受到攻击时30%概率触发【天地失色】，让敌方的天赋不生效`,
      `（获得易筋经后，挑战并战胜达摩可激活）`,
    ],
  };
}

export function xuanZhiTaiYi(lv) {
  return {
    id: 1051,
    name: `玄之太一 Lv${lv}`,
    effect: [`攻击或受到攻击时30%概率触发【玄之太一】，让敌方的奇穴不生效`, `（需激活）`],
  };
}

export function taiYanShiFa(lv) {
  return {
    id: 1052,
    name: `太衍噬法 Lv${lv}`,
    effect: [
      `攻击或受到攻击时30%概率触发【太衍噬法】，让敌方的秘技不生效`,
      `（挑战张三丰，张三丰血量降低50%或坚持200时序后可激活）`,
    ],
  };
}

export function fenJingNiMai(lv) {
  return {
    id: 1053,
    name: `焚经逆脉 Lv${lv}`,
    effect: [
      `攻击或受到攻击时触发【焚经逆脉】，免疫封经脉奇穴，怒气值>=50免疫控制`,
      '暴怒后概率触发【疯怒不息】怒气值保留20~50点',
      `（华山之巅帮欧阳锋战胜洪七公后可激活）`,
    ],
  };
}

/**
 * 轻功类
 */
export function taYunZhuiFeng(lv) {
  return {
    id: 1101,
    name: `踏云追风 Lv${lv}`,
    effect: [`每次行动有${lv * 10}概率再行动一次，下回合自动执行等待`],
  };
}

export function quanFaMingZhong(lv) {
  return {
    id: 1102,
    name: `拳法命中 Lv${lv}`,
    effect: [`拳法攻击时${lv * 20}%概率无视敌方闪避`],
  };
}

export function zhiFaMingZhong(lv) {
  return {
    id: 1103,
    name: `指法命中 Lv${lv}`,
    effect: [`指法攻击时${lv * 20}%概率无视敌方闪避`],
  };
}

export function jianFaMingZhong(lv) {
  return {
    id: 1104,
    name: `剑法命中 Lv${lv}`,
    effect: [`剑法攻击时${lv * 20}%概率无视敌方闪避`],
  };
}

export function daoFaMingZhong(lv) {
  return {
    id: 1105,
    name: `刀法命中 Lv${lv}`,
    effect: [`刀法攻击时${lv * 20}%概率无视敌方闪避`],
  };
}

export function qiMenMingZhong(lv) {
  return {
    id: 1106,
    name: `奇门命中 Lv${lv}`,
    effect: [`奇门攻击时${lv * 20}%概率无视敌方闪避`],
  };
}

export function miZong(lv) {
  return {
    id: 1107,
    name: `迷踪 Lv${lv}`,
    effect: [`受到攻击时${lv * 5}%概率自动移动躲避攻击`],
  };
}
