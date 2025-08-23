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

export function biXian(lv) {
  return {
    name: `避险 Lv${lv}`,
    effect: [`增加七格内我方被攻击时的闪避${lv * 2}%`],
  };
}

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
