/**
 * 特殊效果类
 */

export function wuWoWuXiang2(lv) {
  return {
    name: `无我无相Ⅱ Lv${lv}`,
    effect: [`攻击与防御时${lv * 25}%概率兵器值不低于敌方`],
  };
}

export function congHui(lv) {
  return {
    name: `聪慧 Lv${lv}`,
    effect: [`修炼武功或装备武器时系数要求减少${lv * 2}`],
  };
}

export function zaiDong(lv) {
  return {
    name: `再动 Lv${lv}`,
    effect: [`攻击或移动后如有未使用完移动步数可再次移动`],
  };
}

export function tiaoXi(lv) {
  return {
    name: `调息 Lv${lv}`,
    effect: [`行动后${lv * 25}%概率获得休息效果`],
  };
}

export function gangQiHuTi(lv) {
  return {
    name: `罡气护体 Lv${lv}`,
    effect: [`进入战场获得${lv * 125}点护盾，每${8 - lv}回合重新获得护盾`],
  };
}

export function chongSheng(lv) {
  return {
    name: `重生 Lv${lv}`,
    effect: [`被击败时${lv * 25}%概率重生，并恢复${lv * 25}已损失生命、内力和体力，并清除基础状态`],
  };
}

export function yuQi(lv) {
  return {
    name: `御气 Lv${lv}`,
    effect: [`防御时${lv * 25}%概率无法被杀气，且反震内伤${lv * 125}点内伤`],
  };
}

export function puTiShu(lv) {
  return {
    name: `菩提树 Lv${lv}`,
    effect: [`被攻击时${lv * 15}%概率降低攻击方${lv * 10}%的命中和闪避`],
  };
}

export function xuLiQiangHua(lv) {
  return {
    name: `蓄力强化 Lv${lv}`,
    effect: [`蓄力时必成功，蓄力后的攻击效果增加${lv * 18.75}%`],
  };
}

export function lingXiFenShui(lv) {
  return {
    name: `灵犀分水 Lv${lv}`,
    effect: [`受到攻击时${lv * 15}%概率由全部参战人数一起分担伤害`],
  };
}

export function zhiXiGanGe(lv) {
  return {
    name: `止息干戈 Lv${lv}`,
    effect: [`受到连击或暴击攻击时${lv * 20}%概率打断敌人攻击`],
  };
}

export function kongShou(lv) {
  return {
    name: `空手 Lv${lv}`,
    effect: [`未装备武器时，攻击增加${lv * 50}点`],
  };
}

export function chiBo(lv) {
  return {
    name: `赤膊 Lv${lv}`,
    effect: [`未装备防具时，防御增加${lv * 50}点`],
  };
}

export function buZhan(lv) {
  return {
    name: `步战 Lv${lv}`,
    effect: [`未装备坐骑时，轻功增加${lv * 50}点`],
  };
}

export function xianShou(lv) {
  return {
    name: `先手 Lv${lv}`,
    effect: [`战斗初始集气位置增加${lv * 100}`],
  };
}

export function buXi(lv) {
  return {
    name: `不息 Lv${lv}`,
    effect: [`杀气被杀到-100，清除全部内伤，并恢复${lv * 5}%生命`],
  };
}

export function guiXi(lv) {
  return {
    name: `龟息 Lv${lv}`,
    effect: [`受到第一击的伤害减少${lv * 15}%`],
  };
}

export function kuRong(lv) {
  return {
    name: `枯荣 Lv${lv}`,
    effect: [`行动后消耗${lv * 3}%内力最大值，恢复${lv * 3}%生命最大值`],
  };
}

export function tianXingJianGong(lv) {
  return {
    name: `天行健·攻 Lv${lv}`,
    effect: [`每次行动后增加${lv}%伤害`],
  };
}

export function tianXingJianShou(lv) {
  return {
    name: `天行健·守 Lv${lv}`,
    effect: [`每次行动后减少${lv}%受到的伤害`],
  };
}

export function buQu(lv) {
  return {
    name: `不屈 Lv${lv}`,
    effect: [`集气位置小于0时，减少受到的伤害${lv * 25}%`],
  };
}

export function bingHuoChongRong(lv) {
  return {
    name: `冰火重融 Lv${lv}`,
    effect: [`造成冰封/灼烧时${lv * 25}%概率造成灼烧/冰封`],
  };
}

export function baoYuLiHua(lv) {
  return {
    name: `暴雨梨花 Lv${lv}`,
    effect: [`行动前${lv * 25}%概率给自身五格内目标附加一个随机DEBUFF`],
  };
}

export function foGuangPuDu(lv) {
  return {
    name: `佛光普渡 Lv${lv}`,
    effect: [`每${5 - lv}回合${lv * 25}%概率清除流血、中毒、冰封、燃烧、内伤状态`],
  };
}

export function baoYuanShouYi(lv) {
  return {
    name: `抱元守一 Lv${lv}`,
    effect: [`每${5 - lv}回合${lv * 25}%概率清除大部分异常状态`],
  };
}

export function fuYuanJiaShen(lv) {
  return {
    name: `福缘加身 Lv${lv}`,
    effect: [`增加特效${lv * 2}点(非固定概率)`],
  };
}

export function wuShenZhiLi(lv) {
  return {
    name: `武神之力 Lv${lv}`,
    effect: [`增加三围${lv * 50}`],
  };
}

export function wuShenZhiLi2(lv) {
  return {
    name: `武神之力Ⅱ Lv${lv}`,
    effect: [`增加三围${lv * 5}%`],
  };
}

export function puDuCiHang(lv) {
  return {
    name: `普渡慈航 Lv${lv}`,
    effect: [`每回合恢复生命值、内力值、体力值的${lv + 1}%`],
  };
}

export function yiNianChengMo(lv) {
  return {
    name: `一念成魔 Lv${lv}`,
    effect: [`攻击时${lv * 8}%概率进入【魔神】状态：免疫杀气封穴，额外吸血20%`],
  };
}

export function taiJiZhiXing(lv) {
  return {
    name: `太极之形 Lv${lv}`,
    effect: [
      `被攻击时${lv * 15}%概率获得太极之形，每个太极之形增加1点集气，每5个太极之形增加一次连击`,
    ],
  };
}

export function ziDongFangYu(lv) {
  return {
    name: `自动防御 Lv${lv}`,
    effect: [`行动后${lv * 25}%概率自动防御，且减少受到的伤害${lv * 10}%`],
  };
}

export function weiWoDuZun(lv) {
  return {
    name: `唯我独尊 Lv${lv}`,
    effect: [`受到伤害时以伤害值${lv * 25}%内力抵消${lv * 25}%的伤害`],
  };
}

export function liuDaoLunHui(lv) {
  return {
    name: `六道轮回 Lv${lv}`,
    effect: [
      `进入战斗开始只有${lv * 20}%三围和五系,每回合+30%，每六个回合一轮回，轮回结束时全属性恢复到${
        lv * 20
      }%，并恢复${lv * 10}%的状态，清除所有异常状态`,
    ],
  };
}

export function kuiHuaBaiJie(lv) {
  return {
    name: `葵花百劫 Lv${lv}`,
    effect: [
      `每次闪避和挪移自身集气增加${lv}点，集气位置增加${
        lv * 100
      }，并给攻击方增加虚弱状态一回合，如果攻击方有盲目状态，则攻击方盲目状态增加一回合，行动前清除`,
    ],
  };
}

export function zhouLiuLiuXu(lv) {
  return {
    name: `周流六虚 Lv${lv}`,
    effect: [
      `攻击时${lv * 10}%概率触发：`,
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
    name: `酒神之力 Lv${lv}`,
    effect: [
      `行动前${
        lv * 25
      }%为自己增加即墨老酒/玉露酒/梨花酒/五宝花蜜酒之一效果，每种酒状态增加2层醉意，每层醉意伤害+10%/闪避+5%/命中减-5%`,
      `拥有醉意时${lv * 25}%概率击中目标破绽`,
      `醉意每回合自动减少1层，不可清除`,
    ],
  };
}

export function qiGuanWuYue(lv) {
  return {
    name: `气贯五岳 Lv${lv}`,
    effect: [
      `攻击时${lv * 25}%概率无视目标内功附加的防御力，伤害在${lv * 5 + 100}%~${
        lv * 15 + 100
      }%之间浮动`,
    ],
  };
}

export function yinDuNveYan(lv) {
  return {
    name: `引毒虐焰 Lv${lv}`,
    effect: [
      `攻击时追加目标中毒程度的真实伤害，如果敌方中毒大于100引爆全部中毒，造成中毒程度${
        lv + 1
      }倍的真实伤害`,
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
    name: `气跃如逝 Lv${lv}`,
    effect: [`集气${lv * 5}%概率向前跳跃${lv * 10}时序`],
  };
}

export function taiShangWangQing(lv) {
  return {
    name: `太上忘情 Lv${lv}`,
    effect: [
      `攻击时${lv * 15}%概率触发风流/火延/云翳之一：`,
      `└风流：${lv * 5}%概率魅惑同性敌方，${lv * 15}%概率魅惑异性敌方`,
      `└火延：给全体敌方追加灼烧值`,
      `└云翳：攻击后10时序免疫伤害，冷却40时序`,
      `受到攻击时${lv * 15}%概率触发君王/我无/师教之一：`,
      `└君王：敌全体恐惧一回合`,
      `└师教：敌全体集气-200`,
      `└我无：免疫伤害一次。`,
    ],
  };
}

export function shunXiQianLi(lv) {
  return {
    name: `瞬息千里 Lv${lv}`,
    effect: [`暴怒时集气速度增加${lv * 50}%，且集气不受异常状态影响`],
  };
}

export function taiXuanFanZhen(lv) {
  return {
    name: `太玄反震 Lv${lv}`,
    effect: [`让攻击方受到${lv * 15}%的伤害，并增加攻击方封穴值，${lv * 5}%概率下回合眩晕（需激活）`],
  };
}

export function xueMoZhiDun(lv) {
  return {
    name: `血魔之盾 Lv${lv}`,
    effect: [
      `每次行动前吸取七格内敌人的流血点数转化为自身的生命恢复，如恢复满生命则溢出部分转化为护盾，护盾不会超过自身生命的10%`,
    ],
  };
}

export function xianRenFuDing(lv) {
  return {
    name: `仙人抚顶 Lv${lv}`,
    effect: [
      `复活后增加一个最大生命${lv * 25}%的护盾，暴击率+${lv * 10}%，连击率+${
        lv * 10
      }%，伤害+${lv * 7.5}%，减伤+${lv * 7.5}%，气攻+${lv * 250}，气防+${lv * 250}`,
    ],
  };
}

export function zhiYangZhiGang(lv) {
  return {
    name: `至阳至刚 Lv${lv}`,
    effect: [
      `受到攻击将所受伤害的${
        lv * 5
      }%转化为护盾，受到伤害时，用一半护盾抵消伤害，每次护盾被击碎会对攻击方造成被击碎前护盾量2倍的伤害，当护盾被击碎三次后，护盾再次被击碎会马上恢复生命上限${
        lv * 5
      }%的护盾（上限5000点）且获得霸体${lv + 1}时序`,
    ],
  };
}
