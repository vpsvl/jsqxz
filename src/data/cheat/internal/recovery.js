/**
 * 恢复类
 */

// 各等级时序
const levelSequence = {
  1: 9,
  2: 6,
  3: 5,
  4: 3,
};

function huiMing(lv) {
  return {
    name: `回命 Lv${lv}`,
    effect: `每回合恢复${lv * 100}点生命值`,
  };
}

function huiNei(lv) {
  return {
    name: `回内 Lv${lv}`,
    effect: `每回合恢复${lv * 100}点内力值`,
  };
}

function huiTi(lv) {
  return {
    [`回体 Lv${lv}`]: `每回合恢复${lv}点体力值`,
    name: `回体 Lv${lv}`,
    effect: `每回合恢复${lv}点体力值`,
  };
}

function huiQi(lv) {
  return {
    name: `回气 Lv${lv}`,
    effect: `每回合恢复${lv}点气力值`,
  };
}

function huiNu(lv) {
  return {
    name: `回怒 Lv${lv}`,
    effect: `每回合行动后恢复${lv * 2}点怒气值`,
  };
}

function mingGui(lv) {
  return {
    name: `命归 Lv${lv}`,
    effect: `每回合恢复最大生命值${lv * 2}%点生命值`,
  };
}

function neiGui(lv) {
  return {
    name: `内归 Lv${lv}`,
    effect: `每回合恢复最大内力值${lv * 2}%点内力值`,
  };
}

function shiXuHuiMing(lv) {
  return {
    name: `时序回命 Lv${lv}`,
    effect: `每${levelSequence[lv]}时序恢复${lv * 2}点生命值`,
  };
}

function shiXuHuiNei(lv) {
  return {
    name: `时序回内 Lv${lv}`,
    effect: `每${levelSequence[lv]}时序恢复${lv * 2}点内力值`,
  };
}

function shiXuHuiTi(lv) {
  return {
    name: `时序回体 Lv${lv}`,
    effect: `每${levelSequence[lv]}时序恢复1点体力值`,
  };
}

function shiXuHuiNu(lv) {
  return {
    name: `时序回怒 Lv${lv}`,
    effect: `每${levelSequence[lv]}时序恢复${lv}点怒气值`,
  };
}

function huiChun(lv) {
  return {
    name: `回春 Lv${lv}`,
    effect: `每回合回复损失生命值的${lv * 5}%`,
  };
}

function qiXueXiangSheng1(lv) {
  return {
    name: `气血相生Ⅰ Lv${lv}`,
    effect: `如果(生命/生命最大值)百分比大于(内力值/内力最大值)百分比，则${levelSequence[lv]}时序回复${lv}%最大内力值`,
  };
}

function qiXueXiangSheng2(lv) {
  return {
    name: `气血相生Ⅱ Lv${lv}`,
    effect: `如果(生命/生命最大值)百分比小于(内力值/内力最大值)百分比，则${levelSequence[lv]}时序回复${lv}%最大生命值`,
  };
}


export default {}