/**
 * 增加自身效果类
 */

export function fenLi(lv) {
  return {
    name: `奋力 Lv${lv}`,
    effect: [`增加伤害${(lv + 1) * 6}%`],
  };
}

export function lianJi(lv) {
  return {
    name: `连击 Lv${lv}`,
    effect: [`攻击时${lv * 10}%概率增加${lv > 2 ? 2 : 1}次连击`],
  };
}

export function lianShang(lv) {
  return {
    name: `连伤 Lv${lv}`,
    effect: [`增加连击伤害${lv * 10}%`],
  };
}

export function baoShang(lv) {
  return {
    name: `暴伤 Lv${lv}`,
    effect: [`增加暴击伤害${lv * 10}%`],
  };
}

export function houFaXianZhi(lv) {
  return {
    name: `后发先至 Lv${lv}`,
    effect: [`初始集气位置-500，每有一个人行动，则自身${lv * 10}%概率集气+${lv * 50}`],
  };
}

export function jiFeng(lv) {
  return {
    name: `疾风 Lv${lv}`,
    effect: [`增加集气速度${lv * 2}`],
  };
}

export function gangTi(lv) {
  return {
    name: `罡体 Lv${lv}`,
    effect: [`增加气防${lv * 250}点`],
  };
}

export function gangTiQiangHua(lv) {
  return {
    name: `强化罡体 Lv${lv}`,
    effect: [`增加气防${lv * 10}%`],
  };
}

export function gangQi(lv) {
  return {
    name: `罡气 Lv${lv}`,
    effect: [`增加气攻${lv * 250}点`],
  };
}

export function gangQiQiangHua(lv) {
  return {
    name: `强化罡气 Lv${lv}`,
    effect: [`增加气攻${lv * 25}%`],
  };
}

export function xuQiShiXu(lv) {
  return {
    name: `时序蓄气 Lv${lv}`,
    effect: [`时序增加蓄气值${lv * 2}点`],
  };
}

export function siShenZhiWen(lv) {
  return {
    name: `死神之吻 Lv${lv}`,
    effect: [`附加冰封值+燃烧值+流血+中毒值+内伤值${lv * 30}点`],
  };
}

export function bingShang(lv) {
  return {
    name: `冰伤 Lv${lv}`,
    effect: [`附加冰封值${lv * 50}%真实伤害`],
  };
}

export function huoShang(lv) {
  return {
    name: `火伤 Lv${lv}`,
    effect: [`附加灼烧值${lv * 50}%真实伤害`],
  };
}

export function xueShang(lv) {
  return {
    name: `血伤 Lv${lv}`,
    effect: [`附加流血值${lv * 50}%真实伤害`],
  };
}

export function duShang(lv) {
  return {
    name: `毒伤 Lv${lv}`,
    effect: [`附加中毒值${lv * 50}%真实伤害`],
  };
}

export function neiShang(lv) {
  return {
    name: `内伤 Lv${lv}`,
    effect: [`附加内伤值${lv * 50}%真实伤害`],
  };
}

export function biXian(lv) {
  return {
    name: `避险 Lv${lv}`,
    effect: [`增加七格内我方被攻击时的闪避${lv * 2}%`],
  };
}

export function miaoZhun(lv) {
  return {
    name: `瞄准 Lv${lv}`,
    effect: [`增加七格内我方被攻击时的命中${lv * 5}%`],
  };
}

export function guWu(lv) {
  return {
    name: `鼓舞 Lv${lv}`,
    effect: [`增加七格内我方攻击时的伤害${lv * 5}%`],
  };
}

export function xieFang(lv) {
  return {
    name: `协防 Lv${lv}`,
    effect: [`减少七格内我方受攻击时的伤害${lv * 5}%`],
  };
}

export function lianDong(lv) {
  return {
    name: `连动 Lv${lv}`,
    effect: [`增加七格内我方集气速度${lv * 2}点`],
  };
}

export function xueZhanBaFang(lv) {
  return {
    name: `血战八方 Lv${lv}`,
    effect: [`击败敌方后增加1点血战，每1点血战增加${lv * 10}%伤害，并在攻击时造成大范围伤害、追加800气攻、附加卸甲状态`],
  };
}

export function weiLiZengQiang(lv) {
  return {
    name: `威力增强 Lv${lv}`,
    effect: [`增加自身全部武功威力${lv * 100}点`],
  };
}

export function fengMei(lv) {
  return {
    name: `风媒 Lv${lv}`,
    effect: [`增加自身集气值${lv * 2}点`],
  };
}

export function shenLi(lv) {
  return {
    name: `神力 Lv${lv}`,
    effect: [`增加攻击力${lv * 60}点`],
  };
}

export function lianTi(lv) {
  return {
    name: `炼体 Lv${lv}`,
    effect: [`增加防御力${lv * 60}点`],
  };
}

export function qingShen(lv) {
  return {
    name: `轻身 Lv${lv}`,
    effect: [`增加轻功${lv * 60}点`],
  };
}

export function shenLiJiaQiang(lv) {
  return {
    name: `强·神力 Lv${lv}`,
    effect: [`增加攻击力${lv * 10}%`],
  };
}

export function lianTiJiaQiang(lv) {
  return {
    name: `强·炼体 Lv${lv}`,
    effect: [`增加防御力${lv * 10}%`],
  };
}

export function qingShenJiaQiang(lv) {
  return {
    name: `强·轻身 Lv${lv}`,
    effect: [`增加轻功${lv * 10}%`],
  };
}

export function shanBiZengQiang(lv) {
  return {
    name: `闪避增强 Lv${lv}`,
    effect: [`增加闪避${lv * 50}点`],
  };
}

export function geDangZengQiang(lv) {
  return {
    name: `格挡增强 Lv${lv}`,
    effect: [`增加格挡${lv * 50}点`],
  };
}

export function mingZhongZengQiang(lv) {
  return {
    name: `命中增强 Lv${lv}`,
    effect: [`增加命中${lv * 50}点`],
  };
}

export function fengShenZhiLi(lv) {
  return {
    name: `风神之力 Lv${lv}`,
    effect: [`增加命中、格挡、闪避${lv * 30}点`],
  };
}

export function shanBiZengQiang1(lv) {
  return {
    name: `闪避增强Ⅰ Lv${lv}`,
    effect: [`增加闪避${lv * 8}%`],
  };
}

export function geDangZengQiang1(lv) {
  return {
    name: `格挡增强Ⅰ Lv${lv}`,
    effect: [`增加格挡${lv * 8}%`],
  };
}

export function mingZhongZengQiang1(lv) {
  return {
    name: `命中增强Ⅰ Lv${lv}`,
    effect: [`增加命中${lv * 8}%`],
  };
}

export function fengShenZhiLi1(lv) {
  return {
    name: `风神之力Ⅰ Lv${lv}`,
    effect: [`增加命中、格挡、闪避${lv * 5}%`],
  };
}

export function lianZhan(lv) {
  return {
    name: `连战 Lv${lv}`,
    effect: [`增加连击率${lv * 10}%`],
  };
}

export function zhongJi(lv) {
  return {
    name: `重击 Lv${lv}`,
    effect: [`增加暴击率${lv * 10}%`],
  };
}

export function yongDu(lv) {
  return {
    name: `用毒 Lv${lv}`,
    effect: [`增加战场加用毒能力${lv * 15}点`],
  };
}

export function jiBu(lv) {
  return {
    name: `积步 Lv${lv}`,
    effect: [`增加移动距离${lv}`],
  };
}

export function shenQuan(lv) {
  return {
    name: `神拳 Lv${lv}`,
    effect: [`增加拳掌系数${lv * 10}%`],
  };
}

export function shenZhi(lv) {
  return {
    name: `神指 Lv${lv}`,
    effect: [`增加指腿系数${lv * 10}%`],
  };
}

export function shenJian(lv) {
  return {
    name: `神剑 Lv${lv}`,
    effect: [`增加御剑系数${lv * 10}%`],
  };
}

export function shenDao(lv) {
  return {
    name: `神刀 Lv${lv}`,
    effect: [`增加刀法系数${lv * 10}%`],
  };
}

export function shenBing(lv) {
  return {
    name: `神兵 Lv${lv}`,
    effect: [`增加奇门系数${lv * 10}%`],
  };
}

export function baiQi(lv) {
  return {
    name: `百器 Lv${lv}`,
    effect: [`增加全系数${(lv + 1) * 6}%`],
  };
}
