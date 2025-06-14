/**
 * 受击类
 */

export function niZhuanYinYang(lv) {
  return {
    name: `逆转阴阳 Lv${lv}`,
    effect: [`受到伤害时将杀气的${lv * 15}%转化为自身的集气`],
  };
}

export function hunDunTaiXuan(lv) {
  return {
    name: `混沌太玄 Lv${lv}`,
    effect: [
      `受到伤害时将杀气的${(lv + 1) * 15}%转化为自身的集气。将所受伤害的${
        (lv + 1) * 15
      }%转化为生命回复。【需挑战解锁】`,
    ],
  };
}

export function jieLi(lv) {
  return {
    name: `借力 Lv${lv}`,
    effect: [`受到伤害时将受到的伤害的${lv * 6}%转化为蓄气值，攻击时根据蓄气值增加气攻和伤害`],
  };
}

export function zhuanYinYang(lv) {
  return {
    name: `转阴阳 Lv${lv}`,
    effect: [`受到伤害时${lv * 8}%概率将受到的异常状态转移给攻击方`],
  };
}

export function nuoYi(lv) {
  return {
    name: `挪移 Lv${lv}`,
    effect: [`受到伤害时${lv * 5}%概率挪移到${lv + 3}格内其他位置躲避伤害`],
  };
}

export function guiXing(lv) {
  return {
    name: `龟形 Lv${lv}`,
    effect: [`受到伤害时${lv * 20}%概率进入防御状态`],
  };
}

export function fanTan(lv) {
  return {
    name: `反弹 Lv${lv}`,
    effect: [`受到伤害时${lv * 25}%概率反弹50%的伤害`],
  };
}

export function fanZhen(lv) {
  return {
    name: `反震 Lv${lv}`,
    effect: [`受到伤害时${lv * 25}%概率反震伤害，使敌方也受到此次伤害的一半`],
  };
}

export function yaZi(lv) {
  return {
    name: `睚眦 Lv${lv}`,
    effect: [`受到伤害时${lv * 25}%概率反弹杀气给随机敌方`],
  };
}

export function duanGu(lv) {
  return {
    name: `锻骨 Lv${lv}`,
    effect: [`受到伤害时${lv * 25}%概率减少体质百分比的伤害`],
  };
}

export function xiNeiBeiDong(lv) {
  return {
    name: `吸内·被动 Lv${lv}`,
    effect: [`受到伤害时${lv * 25}%概率吸取敌方的内力值${lv * 100}点`],
  };
}

export function xiTiBeiDong(lv) {
  return {
    name: `吸体·被动 Lv${lv}`,
    effect: [`受到伤害时${lv * 25}%概率吸取敌方的体力值${lv}点`],
  };
}

export function xiNuBeiDong(lv) {
  return {
    name: `吸怒·被动 Lv${lv}`,
    effect: [`受到伤害时${lv * 25}%概率吸取敌方的怒气值${lv * 2}点`],
  };
}

export function daZongShi(lv) {
  return {
    name: `大宗师 Lv${lv}`,
    effect: [`受到伤害时${lv * 25}%概率${lv}时序恢复生命值2点、内力值4点`],
  };
}

export function duanRen1(lv) {
  return {
    name: `断刃Ⅰ Lv${lv}`,
    effect: [`受到攻击时${lv * 15}%概率无视敌方基础攻击力`],
  };
}

export function duanRen2(lv) {
  return {
    name: `断刃Ⅱ Lv${lv}`,
    effect: [`受到攻击时${lv * 15}%概率无视敌方附加攻击力`],
  };
}

export function buMieJinShen(lv) {
  return {
    name: `不灭金身 Lv${lv}`,
    effect: [`当生命值少于最大生命值50%时，受到攻击时免疫伤害${lv * 3}时序，冷却100时序`],
  };
}

export function qingQuanYangZhi(lv) {
  return {
    name: `擎拳仰止 Lv${lv}`,
    effect: [
      `受到拳掌武功攻击时或使用拳掌武功主动攻击时${
        lv * 20
      }概率敌方拳掌系数为0，受到拳掌武功的伤害减少${lv * 10}%`,
    ],
  };
}

export function zhiYinJiangHu(lv) {
  return {
    name: `指引江湖 Lv${lv}`,
    effect: [
      `受到指腿武功攻击时或使用指腿武功主动攻击时${
        lv * 20
      }概率敌方指腿系数为0，受到指腿武功的伤害减少${lv * 10}%`,
    ],
  };
}

export function wanJianGuiZong(lv) {
  return {
    name: `万剑归宗 Lv${lv}`,
    effect: [
      `受到剑法武功攻击时或使用剑法武功主动攻击时${
        lv * 20
      }概率敌方剑法系数为0，受到剑法武功的伤害减少${lv * 10}%`,
    ],
  };
}

export function danShanWeiRen(lv) {
  return {
    name: `刀山为韧 Lv${lv}`,
    effect: [
      `受到刀法武功攻击时或使用刀法武功主动攻击时${
        lv * 20
      }概率敌方刀法系数为0，受到刀法武功的伤害减少${lv * 10}%`,
    ],
  };
}

export function qiMenBaiJie(lv) {
  return {
    name: `奇门百解 Lv${lv}`,
    effect: [
      `受到奇门武功攻击时或使用奇门武功主动攻击时${
        lv * 20
      }概率敌方奇门系数为0，受到奇门武功的伤害减少${lv * 10}%`,
    ],
  };
}

export function tianJiMiShu(lv) {
  return {
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
    name: `凌波 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%增加闪避${lv * 50}点，闪避后清除`],
  };
}

export function shanBi(lv) {
  return {
    name: `闪避 Lv${lv}`,
    effect: [`受到攻击时${lv * 5}%概率无视必中，独立概率闪避攻击`],
  };
}

export function yiRong(lv) {
  return {
    name: `易容 Lv${lv}`,
    effect: [`受到攻击时${lv * 10}%概率只受到误伤伤害`],
  };
}

export function poZhao(lv) {
  return {
    name: `破招 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%增加格挡${lv * 50}点，格挡后清除`],
  };
}

export function geDang(lv) {
  return {
    name: `格挡 Lv${lv}`,
    effect: [`受到攻击时二次判定${lv * 5}%概率触发格挡`],
  };
}

export function beiDongHuaGong(lv) {
  return {
    name: `被动化功 Lv${lv}`,
    effect: [`受到攻击时${lv * 25}%概率减少攻击方内力${lv * 100}点`],
  };
}
