import {sectMap} from '@/data/map';

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
  0: {atk: 2, def: -1, spd: 0},
  1: {atk: -1, def: 2, spd: 0},
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
const internalTypeCondition = {1: '非阳内', 2: '非阴内'};
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
  4: 400,
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
    const outConditionMap = {1: 20, 2: 50, 3: 100, 4: 150};
    const outConditionGap = {1: 0, 2: 30, 3: 60, 4: 170};
    let outCondition = 20;
    if (level > 1) {
      outCondition = `(${outConditionMap[level]}+${outConditionGap[level]}×周目数÷100)`;
    }
    condition += `${outTypeMap[type]}${outCondition} `;
  } else if (type === 'internal') {
    // 内功学习条件
    condition += `内力${internalConditionMap[level]} `;
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
const outPowerMap = {1: 440, 2: 880, 3: 1320, 4: 1760};

// 获取武功威力
export function getPower({type, level, internal, other = ''}) {
  // 内功/轻功不做处理
  if (!outTypeMap[type]) {
    return other;
  }
  other = Number.parseInt(other);
  if (Number.isNaN(other)) {
    other = 0;
  }
  if (outPowerMap[level]) {
    return outPowerMap[level] + other;
  }
  return '';
}

// 攻击范围
const rangeMap = {
  fist: {
    1: {shape: 'X', move: 2, width: 5, height: 5},
    2: {shape: 'X', move: 2, width: 5, height: 5},
    3: {shape: 'X', move: 3, width: 5, height: 5},
    4: {shape: 'X', move: 4, width: 5, height: 5},
  },
  finger: {
    1: {shape: '«', move: 2, width: 3, height: 6},
    2: {shape: '«', move: 2, width: 3, height: 6},
    3: {shape: '«', move: 3, width: 3, height: 7},
    4: {shape: '«', move: 4, width: 3, height: 8},
  },
  sword: {
    1: {shape: '米', move: 2, width: 5, height: 5},
    2: {shape: '米', move: 2, width: 5, height: 5},
    3: {shape: '米', move: 3, width: 5, height: 5},
    4: {shape: '米', move: 4, width: 5, height: 5},
  },
  knife: {
    1: {shape: '△', move: 4, width: 3, height: 2},
    2: {shape: '△', move: 4, width: 3, height: 2},
    3: {shape: '△', move: 4, width: 5, height: 3},
    4: {shape: '△', move: 4, width: 7, height: 4},
  },
  special: {
    1: {shape: '十', move: 2, width: 9, height: 9},
    2: {shape: '十', move: 2, width: 9, height: 9},
    3: {shape: '十', move: 3, width: 9, height: 9},
    4: {shape: '十', move: 4, width: 9, height: 9},
  },
  internal: {
    1: {shape: '■', move: 2, width: 3, height: 3},
    2: {shape: '■', move: 2, width: 3, height: 3},
    3: {shape: '■', move: 3, width: 5, height: 5},
    4: {shape: '■', move: 4, width: 5, height: 5},
  },
};

// 获取攻击范围
export function getRange({type, level, other = ''}) {
  if (other) {
    return other;
  }
  if (rangeMap[type]?.[level]) {
    const {shape, move, width, height} = rangeMap[type][level];
    return `${shape} ${move}+${width}×${height}`;
  }
  return '';
}

// 获取学习方式
export function getLearn({sect, level, other = []}) {
  if (!Array.isArray(other)) {
    return [other];
  }
  if(level > 2) {
    other.push(`挑战每月随机事件中携带此秘籍的人物，战胜后概率获得`);
  }
  if (sectMap[sect]) {
    other.push(`加入${sectMap[sect]}可学习`);
  } else if (sect === 0 && level < 4) {
    other.push(`江湖散人可在扬州武馆学习`);
  }
  return other;
}
