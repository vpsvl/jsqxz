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
    1: {atk: 0, def: 0, spd: 2},
    2: {atk: 0, def: 0, spd: 0},
    3: {atk: 0, def: 0, spd: 0},
    4: {atk: 0, def: 0, spd: 7},
  },
};

// 阴/阳武功属性修正
const attrInternalCorrect = {
  0: {atk: 2, def: -1, spd: 0},
  1: {atk: -1, def: 2, spd: 0},
};

// 需要加系数的武功类型
const kungfuTypeMap = {
  fist: '拳掌',
  finger: '指腿',
  sword: '剑法',
  knife: '刀法',
  special: '奇门',
};

// 获取武功修炼加成
export function getAttr({type, level, internal = '', other = ''}) {
  // 直接设置三维
  if (/攻击|防御|轻功/.test(other)) {
    return other;
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
  if (kungfuTypeMap[type]) {
    const num = Math.max(2 * level - 1, 2);
    attr += `${kungfuTypeMap[type]}+${num} `;
  }
  // 其他属性
  if (other) {
    attr += other;
  }
  return attr;
}
