// 拳掌基础效果
export function fistBase(lv) {
  return {
    id: 'fist',
    effect: [`造成目标内伤${lv * 5}点`],
  };
}
// 指腿基础效果
export function fingerBase(lv) {
  return {
    id: 'finger',
    effect: [`造成目标封穴${lv}~${lv * 2 + 2}点`],
  };
}
// 剑法基础效果
export function swordBase(lv) {
  return {
    id: 'sword',
    effect: [`造成目标流血${lv * 10}点`],
  };
}
// 刀法基础效果
export function knifeBase(lv) {
  return {
    id: 'knife',
    effect: [`造成目标外伤${lv * 10}点`],
  };
}
// 奇门基础效果
export function specialBase(lv) {
  return {
    id: 'special',
    effect: [`造成目标内伤${lv * 2}点/封穴${lv}~${lv * 2 + 2}点/流血${lv * 10}点/灼烧${lv * 10}点`],
  };
}

// 概率冰封
export function bingFengBase(lv) {
  return {
    id: 'bingFeng',
    effect: ['概率冰封'],
  };
}
// 概率灼烧
export function zhuoShaoBase(lv) {
  return {
    id: 'zhuoShao',
    effect: ['概率灼烧'],
  };
}
// 中毒
export function zhongDuBase(lv) {
  // 4: 30
  return {
    id: 'zhongDu',
    effect: ['使目标中毒'],
  };
}

export function liuXue(lv) {
  return {
    id: 1,
    effect: [`额外造成目标流血${lv * 10}点`],
  };
}
export function fengXue(lv) {
  return {
    id: 2,
    effect: [`额外造成目标封穴${lv}~${lv * 2 + 1}点`],
  };
}
export function zhuoShao(lv) {
  return {
    id: 3,
    effect: [`额外造成目标灼烧${lv * 5}点`],
  };
}
export function bingFeng(lv) {
  return {
    id: 4,
    effect: [`额外造成目标冰封${lv * 10}点`],
  };
}
export function neiShang(lv) {
  return {
    id: 5,
    effect: [`额外造成目标内伤${lv * 10}点`],
  };
}
export function zhongDu(lv) {
  return {
    id: 6,
    effect: [`额外造成目标中毒${lv * 10}点`],
  };
}
export function dongJie(lv) {
  return {
    id: 7,
    effect: [`额外造成目标冻结${lv * 5}时序`],
  };
}
export function dianRan(lv) {
  return {
    id: 8,
    effect: [`额外造成目标点燃${lv * 2 + 3}时序`],
  };
}
export function juDu(lv) {
  return {
    id: 9,
    effect: [`造成目标巨毒${lv}回合，毒性发作效果双倍`],
  };
}
export function xuanYun(lv) {
  return {
    id: 10,
    effect: [`${lv * 10}%概率造成目标眩晕一回合`],
  };
}
export function siLie(lv) {
  return {
    id: 11,
    effect: [`${lv * 10}%概率造成目标撕裂10时序`],
  };
}
export function xuRuo(lv) {
  return {
    id: 12,
    effect: [`${lv * 10 + 10}%概率造成目标虚弱一回合，减少伤害和气攻`],
  };
}
export function jianFangYu(lv) {
  return {
    id: 13,
    effect: [`减少目标防御${lv * 10}%`],
  };
}
export function jianXiShu(lv) {
  return {
    id: 14,
    effect: [`减少目标本武功对应系数${lv * 10}%`],
  };
}
export function eWaiShangHai(lv) {
  return {
    id: 15,
    effect: [`附加额外伤害${lv * 50}点`],
  };
}
export function xiXue(lv) {
  return {
    id: 16,
    effect: [`附加伤害20%吸血，上限${lv * 100}点`],
  };
}
export function jianFangYu3(lv) {
  return {
    id: 17,
    effect: [`三回合内减少目标防御${lv * 5}%`],
  };
}
export function jianGongJi3(lv) {
  return {
    id: 18,
    effect: [`三回合内减少目标攻击${lv * 5}%`],
  };
}
export function wuShiQiFang(lv) {
  return {
    id: 19,
    effect: [`${lv * 10}%概率无视气防`],
  };
}
export function daFanWei(lv) {
  return {
    id: 20,
    effect: [`${lv * 10}%概率造成大范围伤害`],
  };
}
export function zaiDong(lv) {
  return {
    id: 21,
    effect: [`${lv * 4}%概率再次行动`],
  };
}
export function jiQiJiaSu(lv) {
  return {
    id: 22,
    effect: [`下回合集气加速${lv * 10}%`],
  };
}
export function jiaLianJi(lv) {
  return {
    id: 23,
    effect: [`${lv * 10}%概率增加连击1次`],
  };
}
export function baoJi(lv) {
  return {
    id: 24,
    effect: [`${lv * 20 + 20}%概率暴击`],
  };
}
export function baoJiShangHai(lv) {
  return {
    id: 25,
    effect: [`增加暴击伤害${lv * 10}%`],
  };
}
export function biZhong(lv) {
  return {
    id: 26,
    effect: [`${lv * 4}%概率必中`],
  };
}
export function fangYu(lv) {
  return {
    id: 27,
    effect: [`${lv * 20 + 20}%概率下回合防御`],
  };
}
export function huiQi(lv) {
  let qi = lv > 1 ? `${lv - 1}~${lv}` : '1';
  return {
    id: 28,
    effect: [`回气${qi}点`],
  };
}
export function suoZu(lv) {
  return {
    id: 29,
    effect: [`${lv * 15}%概率造成目标锁足一回合，无法挪移`],
  };
}
export function fanJi(lv) {
  return {
    id: 30,
    effect: [`${lv * 10}%概率反击`],
  };
}
export function jiaGeDang(lv) {
  return {
    id: 31,
    effect: [`增加格档${lv * 100}点`],
  };
}
export function jiaMingZhong(lv) {
  return {
    id: 32,
    effect: [`命中增加${lv * 100}点`],
  };
}
export function sanGong(lv) {
  return {
    id: 33,
    effect: [`散功${lv * 5}时序`],
  };
}
export function zhongShang(lv) {
  return {
    id: 34,
    effect: [`重伤三回合，目标三围降低${lv * 5 + 5}%`],
  };
}
export function jiQiWenLuan(lv) {
  return {
    id: 35,
    effect: [`集气紊乱${lv * 5}时序`],
  };
}
export function kongJu(lv) {
  return {
    id: 36,
    effect: [`${lv * 10 + 30}%概率造成目标恐惧一回合`],
  };
}
export function zhiMingYiJi(lv) {
  return {
    id: 37,
    effect: [`造成目标生命最大值${lv + 1}%伤害`],
  };
}
export function mangMu(lv) {
  return {
    id: 38,
    effect: [`${lv * 10}%概率造成目标盲目一回合`],
  };
}
export function jianJiQi(lv) {
  return {
    id: 39,
    effect: [`目标集气速度减少${lv * 3}点`],
  };
}
export function hunLuan(lv) {
  return {
    id: 40,
    effect: [`${lv * 15}%概率造成目标混乱一回合`],
  };
}
export function maBi(lv) {
  return {
    id: 41,
    effect: [`${lv * 10}%概率造成目标麻痹一回合`],
  };
}

/**
 * 奥义
 */
export function lvShuangBingZhi(lv) {
  return {
    id: 1,
    name: '履霜冰至',
    effect: [`${lv * 10}%概率造成目标冻结10时序`],
  };
}
export function liSheDaChuan(lv) {
  return {
    id: 2,
    name: '利涉大川',
    effect: [`${lv * 10}%概率使目标下回合伤害降低${lv * 20}%`],
  };
}
export function miYunBuYu(lv) {
  return {
    id: 3,
    name: '密云布雨',
    effect: [`${lv * 10}%概率使目标减少一半的集气20时序`],
  };
}
export function hongJianYuLu(lv) {
  return {
    id: 4,
    name: '鸿渐于陆',
    effect: [`${lv * 5}%概率再次行动`],
  };
}
export function jianNiTianGuang(lv) {
  return {
    id: 5,
    name: '剑逆天光',
    effect: [`无视目标气防且必破防${lv * 10}%`],
  };
}
export function jianHuangJingYing(lv) {
  return {
    id: 6,
    name: '剑煌镜影',
    effect: [`必暴击，且暴击伤害增加${(lv + 1) * 10}%`],
  };
}
export function huangXiJianYin(lv) {
  return {
    id: 7,
    name: '皇玺剑印',
    effect: [`${(lv + 1) * 10}%概率对目标随机造成锁足/昏迷/破甲效果`],
  };
}
export function nanKeWanJian(lv) {
  return {
    id: 8,
    name: '南柯万剑',
    effect: [`${lv * 5}%概率增加一次连击，最多六连击`],
  };
}
