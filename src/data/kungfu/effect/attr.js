// 属性加成类型
const attrTypeMap = {
  fist: {
    1: {atk: 2, def: 0, spd: 0},
    2: {atk: 3, def: 0, spd: 0},
    3: {atk: 3, def: 1, spd: 0},
    4: {atk: 5, def: 1, spd: 1},
  },
  finger: {
    1: {atk: 1, def: 0, spd: 1},
    2: {atk: 2, def: 0, spd: 1},
    3: {atk: 3, def: 0, spd: 2},
    4: {atk: 4, def: 1, spd: 2},
  },
  sword: {
    1: {atk: 1, def: 0, spd: 1},
    2: {atk: 1, def: 1, spd: 1},
    3: {atk: 2, def: 1, spd: 2},
    4: {atk: 3, def: 1, spd: 3},
  },
  knife: {
    1: {atk: 1, def: 1, spd: 0},
    2: {atk: 2, def: 1, spd: 0},
    3: {atk: 3, def: 1, spd: 1},
    4: {atk: 4, def: 2, spd: 1},
  },
  special: {
    1: {atk: 1, def: 1, spd: 0},
    2: {atk: 2, def: 1, spd: 0},
    3: {atk: 3, def: 1, spd: 1},
    4: {atk: 3, def: 2, spd: 2},
  },
  internal: {
    1: {atk: 1, def: 1, spd: 0},
    2: {atk: 1, def: 2, spd: 0},
    3: {atk: 2, def: 2, spd: 1},
    4: {atk: 2, def: 4, spd: 1},
  },
  fly: {
    1: {atk: 0, def: 0, spd: 5},
    2: {atk: 0, def: 0, spd: 0},
    3: {atk: 0, def: 0, spd: 0},
    4: {atk: 0, def: 0, spd: 10},
  },
};

// 阴/阳武功属性修正
const attrInternalCorrect = {
  0: {atk: 1, def: 0, spd: 0},
  1: {atk: 0, def: 1, spd: 0},
};

// 外功需要加系数
const outTypeMap = {
  fist: '拳掌',
  finger: '指腿',
  sword: '剑法',
  knife: '刀法',
  special: '奇门',
};

// 获取武功修炼加成
export function getAttr({type, level, internal = '', other = ''}) {
  // 直接设置属性
  if (/^#/.test(other)) {
    return other.replace(/^#/, '');
  }
  let attr = '';
  // 获取各类型武功基础属性
  if (attrTypeMap[type]?.[level]) {
    let {atk, def, spd} = attrTypeMap[type][level];
    // 内力阴阳修正属性
    if (attrInternalCorrect[internal]) {
      const {atk: atkCorrect, def: defCorrect, spd: spdCorrect} = attrInternalCorrect[internal];
      atk += atkCorrect;
      def += defCorrect;
      spd += spdCorrect;
    }
    if (atk > 0) {
      attr += `攻击+${atk} `;
    }
    if (def > 0) {
      attr += `防御+${def} `;
    }
    if (spd > 0) {
      attr += `轻功+${spd} `;
    }
  }
  // 系数加成
  if (outTypeMap[type]) {
    const num = Math.max(2 * level - 1, 2);
    attr += `${outTypeMap[type]}+${num} `;
  }
  // 其他属性
  if (other) {
    attr += other;
  }
  return attr;
}

// 阴阳内力限制
const internalTypeCondition = {0: '非阳内', 1: '非阴内'};
// 外功学习系数
const outConditionMap = {
  1: 20,
  2: 50,
  3: 100,
  4: 150,
};
// 内功学习条件
const internalConditionMap = {
  1: 1000,
  2: 2000,
  3: 3000,
  4: 5000,
};
// 轻功学习条件
const flyConditionMap = {
  1: 100,
  2: 200,
  3: 300,
  4: 500,
};

// 获取学习秘籍条件
export function getCondition({type, level, internal = '', other = ''}) {
  // 直接设置学习条件
  if (/^#/.test(other)) {
    return other.replace(/^#/, '');
  }
  let condition = '';
  // 阴阳限制
  if (internalTypeCondition[internal]) {
    condition += `${internalTypeCondition[internal]} `;
  }
  if (outTypeMap[type]) {
    // 外功学习系数
    condition += `${outTypeMap[type]}${outConditionMap[level]} `;
  } else if (type === 'internal') {
    // 内功学习条件
    condition += `内力≥${internalConditionMap[level]} `;
  } else if (type === 'fly') {
    // 轻功学习条件
    condition += `轻功${flyConditionMap[level]} `;
  }
  // 其他条件
  if (other) {
    condition += other;
  }
  return condition;
}

// 外功威力
const outPowerMap = {
  // 初阶
  1: {
    1: {power: 100, moveRange: 1, hurtRange: 1},
    2: {power: 133, moveRange: 1, hurtRange: 1},
    3: {power: 166, moveRange: 2, hurtRange: 1},
    4: {power: 200, moveRange: 2, hurtRange: 1},
    5: {power: 233, moveRange: 2, hurtRange: 1},
    6: {power: 266, moveRange: 2, hurtRange: 1},
    7: {power: 300, moveRange: 2, hurtRange: 2},
    8: {power: 333, moveRange: 2, hurtRange: 2},
    9: {power: 366, moveRange: 2, hurtRange: 2},
    10: {power: 400, moveRange: 2, hurtRange: 2},
  },
  // 中阶
  2: {
    1: {power: 200, moveRange: 1, hurtRange: 1},
    2: {power: 266, moveRange: 1, hurtRange: 1},
    3: {power: 333, moveRange: 2, hurtRange: 1},
    4: {power: 400, moveRange: 2, hurtRange: 1},
    5: {power: 466, moveRange: 2, hurtRange: 1},
    6: {power: 533, moveRange: 2, hurtRange: 1},
    7: {power: 600, moveRange: 2, hurtRange: 2},
    8: {power: 666, moveRange: 2, hurtRange: 2},
    9: {power: 733, moveRange: 2, hurtRange: 2},
    10: {power: 800, moveRange: 2, hurtRange: 2},
  },
  // 高阶
  3: {
    1: {power: 300, moveRange: 1, hurtRange: 1},
    2: {power: 400, moveRange: 1, hurtRange: 1},
    3: {power: 500, moveRange: 2, hurtRange: 1},
    4: {power: 600, moveRange: 2, hurtRange: 1},
    5: {power: 700, moveRange: 2, hurtRange: 2},
    6: {power: 800, moveRange: 3, hurtRange: 2},
    7: {power: 900, moveRange: 3, hurtRange: 2},
    8: {power: 1000, moveRange: 3, hurtRange: 2},
    9: {power: 1100, moveRange: 3, hurtRange: 3},
    10: {power: 1200, moveRange: 3, hurtRange: 3},
  },
  // 绝学
  4: {
    1: {power: 400, moveRange: 1, hurtRange: 1},
    2: {power: 533, moveRange: 1, hurtRange: 1},
    3: {power: 666, moveRange: 2, hurtRange: 1},
    4: {power: 800, moveRange: 2, hurtRange: 1},
    5: {power: 933, moveRange: 2, hurtRange: 2},
    6: {power: 1066, moveRange: 3, hurtRange: 2},
    7: {power: 1200, moveRange: 3, hurtRange: 2},
    8: {power: 1333, moveRange: 4, hurtRange: 2},
    9: {power: 1466, moveRange: 4, hurtRange: 3},
    10: {power: 1600, moveRange: 4, hurtRange: 3},
  },
};

// 获取外功威力
export function getOutPower({type, level}) {
  if (!outTypeMap[type]) {
    return 0;
  }
  if (outPowerMap[level]) {
    return outPowerMap[level][10].power;
  }
  return 0;
}
