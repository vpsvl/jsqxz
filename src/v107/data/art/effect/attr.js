import {artTypeMap} from '@/v107/data/map';
import {
  inheritAscMap,
  inheritDescMap,
} from '@/v107/data/art/inherit';
import artAll from '@/v107/data/art/list';
import itmAll from '@/v107/data/itm/list';
import sectAll from '@/v107/data/art/sect';
import secretData, {
  jiaBaoJiMap,
  jiaLianJiMap,
} from '@/v107/data/art/secret';
import * as innerMap from '@/v107/data/art/effect/inner';
import * as outMap from '@/v107/data/art/effect/out';
import {artCheatMap} from '@/v107/data/art/map';

// 属性加成类型
const attrTypeMap = {
  1: {
    1: {atk: 2, def: 0, spd: 0},
    2: {atk: 3, def: 0, spd: 0},
    3: {atk: 3, def: 1, spd: 0},
    4: {atk: 5, def: 1, spd: 1},
  },
  2: {
    1: {atk: 1, def: 0, spd: 1},
    2: {atk: 2, def: 0, spd: 1},
    3: {atk: 3, def: 0, spd: 2},
    4: {atk: 4, def: 1, spd: 2},
  },
  3: {
    1: {atk: 1, def: 0, spd: 1},
    2: {atk: 1, def: 1, spd: 1},
    3: {atk: 2, def: 1, spd: 2},
    4: {atk: 3, def: 1, spd: 3},
  },
  4: {
    1: {atk: 1, def: 1, spd: 0},
    2: {atk: 2, def: 1, spd: 0},
    3: {atk: 3, def: 1, spd: 1},
    4: {atk: 4, def: 2, spd: 1},
  },
  5: {
    1: {atk: 1, def: 1, spd: 0},
    2: {atk: 2, def: 1, spd: 0},
    3: {atk: 3, def: 1, spd: 1},
    4: {atk: 3, def: 2, spd: 2},
  },
  6: {
    1: {atk: 1, def: 1, spd: 0},
    2: {atk: 1, def: 2, spd: 0},
    3: {atk: 2, def: 2, spd: 1},
    4: {atk: 2, def: 4, spd: 1},
  },
  7: {
    1: {atk: 0, def: 0, spd: 5},
    2: {atk: 0, def: 0, spd: 0},
    3: {atk: 0, def: 0, spd: 0},
    4: {atk: 0, def: 0, spd: 10},
  },
};

// 阴/阳武功属性修正
const attrInternalCorrect = {
  1: {atk: 2, def: -1, spd: 0},
  2: {atk: -1, def: 2, spd: 0},
};

// 获取武功修炼加成
export function getAttr({
  type,
  level,
  inner = '',
  other = '',
}) {
  // 直接设置属性
  if (/^#/.test(other)) {
    return other.replace(/^#/, '');
  }
  let attr = '';
  // 获取各类型武功基础属性
  if (attrTypeMap[type]?.[level]) {
    let {atk, def, spd} = attrTypeMap[type][level];
    // 内力阴阳修正属性
    if (attrInternalCorrect[inner]) {
      const {
        atk: atkCorrect,
        def: defCorrect,
        spd: spdCorrect,
      } = attrInternalCorrect[inner];
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
  if (type < 6) {
    const num = Math.max(2 * level - 1, 2);
    attr += `${artTypeMap[type]}+${num} `;
  }
  // 其他属性
  if (other) {
    attr += other;
  }
  return attr;
}

// 阴阳内力限制
const innerTypeCondition = {1: '非阳内', 2: '非阴内'};
// 外功学习系数
const outConditionMap = {1: 20, 2: 50, 3: 100, 4: 150};
// 外功学习系数百周增加
const outConditionGap = {1: 0, 2: 30, 3: 60, 4: 170};
// 内功学习条件
const innerConditionMap = {
  1: 1000,
  2: 2000,
  3: 3000,
  4: 5000,
};
// 轻功学习条件
const flyConditionMap = {1: 100, 2: 200, 3: 300, 4: 400};

// 获取学习秘籍条件
export function getCondition({
  type,
  level,
  inner = '',
  other = '',
}) {
  // 直接设置学习条件
  if (/^#/.test(other)) {
    return other.replace(/^#/, '');
  }
  let condition = '';
  // 阴阳限制
  if (innerTypeCondition[inner]) {
    condition += `${innerTypeCondition[inner]} `;
  }
  if (type < 6) {
    // 外功学习系数
    let outCondition = 20;
    if (level > 1) {
      outCondition = `(${outConditionMap[level]}+${outConditionGap[level]}×周目数÷100)`;
    }
    condition += `${artTypeMap[type]}≥${outCondition} `;
  } else if (type === 6) {
    // 内功学习条件
    condition += `内力最大值≥${innerConditionMap[level]} `;
  } else if (type === 7) {
    // 轻功学习条件
    condition += `轻功≥${flyConditionMap[level]} `;
  }
  // 其他条件
  if (other) {
    condition += other;
  }
  return condition;
}

// 获取武功威力
export function getPower({
  type,
  level,
  other = '',
}) {
  if (other || typeof other === 'number') {
    return other;
  }
  // 外功
  if (type < 6) {
    return 440 * level;
  }
  // 内功
  if (type === 6) {
    let qi = level / 2;
    if (/\./.test(qi + '')) {
      qi = `${qi - 0.5}~${qi + 0.5}`;
    }
    return `生命${540 * level} 气防${440 * level} 格挡${11 * level} 回气${qi}`;
  }
  // 轻功
  if (type === 7) {
    return `命中${110 * level} 闪避${110 * level}`;
  }
  return '';
}

// 攻击范围
const rangeMap = {
  1: {
    1: {shape: 'X', move: 2, width: 5, height: 5},
    2: {shape: 'X', move: 2, width: 5, height: 5},
    3: {shape: 'X', move: 3, width: 5, height: 5},
    4: {shape: 'X', move: 4, width: 5, height: 5},
  },
  2: {
    1: {shape: '«', move: 1, width: 3, height: 6},
    2: {shape: '«', move: 1, width: 3, height: 6},
    3: {shape: '«', move: 1, width: 3, height: 7},
    4: {shape: '«', move: 1, width: 3, height: 8},
  },
  3: {
    1: {shape: '米', move: 2, width: 5, height: 5},
    2: {shape: '米', move: 2, width: 5, height: 5},
    3: {shape: '米', move: 3, width: 5, height: 5},
    4: {shape: '米', move: 4, width: 5, height: 5},
  },
  4: {
    1: {shape: '△', move: 2, width: 5, height: 3},
    2: {shape: '△', move: 2, width: 5, height: 3},
    3: {shape: '△', move: 3, width: 7, height: 5},
    4: {shape: '△', move: 4, width: 9, height: 5},
  },
  5: {
    1: {shape: '十', move: 2, width: 11, height: 11},
    2: {shape: '十', move: 2, width: 11, height: 11},
    3: {shape: '十', move: 3, width: 11, height: 11},
    4: {shape: '十', move: 4, width: 11, height: 11},
  },
  6: {
    1: {shape: '■', move: 2, width: 7, height: 7},
    2: {shape: '■', move: 2, width: 7, height: 7},
    3: {shape: '■', move: 3, width: 7, height: 7},
    4: {shape: '■', move: 4, width: 7, height: 7},
  },
};

// 获取攻击范围
export function getRange({type, level, other = ''}) {
  if (other) {
    return other;
  }
  if (rangeMap[type]?.[level]) {
    const {shape, move, width, height} =
      rangeMap[type][level];
    return `${shape} ${move}+${width}×${height}`;
  }
  return '';
}

const sectClosedMap = {
  7: '全真教',
  10: '嵩山派',
  11: '青城派',
  12: '衡山派',
  13: '恒山派',
  14: '泰山派',
  15: '五毒教',
  16: '古墓派',
  18: '凌霄城',
  19: '峨眉派',
  20: '崆峒派',
  21: '昆仑派',
  22: '桃花岛',
  23: '白驼山庄',
  24: '六扇门',
  25: '八卦门',
  26: '慕容世家',
  30: '藏剑山庄',
};

// 获取学习方式
export function getLearn({sect, level, other = []}) {
  if (!other) {
    other = [];
  }
  if (!Array.isArray(other)) {
    return [other];
  }
  if (level > 2) {
    other.push(
      `挑战每月随机传闻事件中携带此秘籍的人物，战胜后概率获得`,
    );
  }
  if (sect > 0 && sectAll[sect]) {
    other.push(
      `加入${sectAll[sect].name}${sectClosedMap[sect] ? '（未开放）' : ''}可学习`,
    );
  } else if (level < 4) {
    other.push(`江湖散人可在扬州武馆学习`);
  }
  return other;
}

// 获取一脉
export function getInherit(id) {
  const toId = inheritAscMap[id];
  if (!artAll[id]) {
    return [];
  }
  const {name} = artAll[id];
  let rst = [];
  if (toId) {
    if (Array.isArray(toId)) {
      for (let key of toId) {
        rst.push(`${name} → ${artAll[key].name}`);
      }
    } else {
      rst.push(`${name} → ${artAll[toId].name}`);
    }
  }
  const fromId = inheritDescMap[id];
  if (fromId) {
    if (Array.isArray(fromId)) {
      for (let key of fromId) {
        rst.push(`${artAll[key].name} → ${name}`);
      }
    } else {
      rst.push(`${artAll[fromId].name} → ${name}`);
    }
  }
  return rst;
}

const moveNumMap = {1: 2, 2: 3, 3: 5, 4: 7};

/**
 * 获取招式说明
 * @param id
 */
export function getMove(id) {
  let {type, level, sect, move, moveNum, ultimate} =
    artAll[id];
  if (typeof moveNum !== 'number') {
    moveNum = type < 6 ? moveNumMap[level] : 1;
  }
  // 外功招式特效
  // 所有特效
  const arr = [];
  if (moveNum > 1) {
    // 基础特效
    const arrBase = [];
    const typeKey = `base${type}`;
    if (outMap[typeKey]) {
      const moveItem = outMap[typeKey](level);
      arrBase.push(moveItem.effect);
    }
    if (move && Array.isArray(move[0])) {
      const base = move.shift();
      for (let key of base) {
        const moveItem = outMap[key](level);
        arrBase.push(moveItem.effect);
      }
    }
    let moveList = [];
    // 有配招式就使用配置的
    if (move && move.length > 0) {
      moveList = move;
    } else if (sectAll[sect]) {
      // 没有配置招式使用门派默认的
      const {move: sectMove} = sectAll[sect];
      const total = sectMove.length;
      for (let i = 0; i < moveNum - 1; i++) {
        moveList.push(sectMove[i]);
      }
      // 只有8招, 第7招使用第8个效果
      if (moveNum === 8) {
        moveList[6] = sectMove[7];
      }
      // 最后一招怒气大招默认门派最后一招
      moveList.push(sectMove[total - 1]);
    }
    for (let key of moveList) {
      const item = [...arrBase];
      if (typeof outMap[key] === 'function') {
        const moveItem = outMap[key](level);
        item.push(moveItem.effect);
      }
      arr.push([item.join('；')]);
    }

    // 外功奥义特效
    if (Array.isArray(ultimate)) {
      for (let [index, key] of ultimate.entries()) {
        if (!Array.isArray(arr[index])) {
          arr[index] = [];
        }
        if (typeof outMap[key] === 'function') {
          const ultimateItem = outMap[key](level);
          const {name, effect} = ultimateItem;
          arr[index].push(`${name}(奥义)：${effect}`);
        }
      }
    }
  }
  return arr;
}

/**
 * 获取专属效果
 * @param id
 * @param tra
 * @param isCheat
 */
export function getTra({id, tra, isCheat = false}) {
  if (!artCheatMap[id] && !itmAll[id]) {
    return [];
  }
  // 秘技
  let traArr = [];
  const cheatId = !isCheat && artCheatMap[id] ? artCheatMap[id] : id;
  const artId = isCheat && itmAll[id] ? itmAll[id].art : id;
  for (let key in secretData) {
    let {name, condition, effect, cheat, type} = secretData[key];
    if (condition || !cheat) {
      continue;
    }
    if (!cheat[cheatId]) {
      let flag = false;
      for (let k in cheat) {
        if (Array.isArray(cheat[k])) {
          if (cheat[k].includes(cheatId)) {
            flag = true;
            break;
          }
        }
      }
      if (!flag) {
        continue;
      }
    }
    const arr = [];
    let other = '';
    for (let k in cheat) {
      if (k === 'other') {
        other = cheat[k];
        continue;
      }
      let item = '';
      const isArrCheat = Array.isArray(cheat[k]);
      const artCurrentId = itmAll[k].art;
      if (isCheat || !artCurrentId) {
        item += itmAll[k].name;
        if (isArrCheat) {
          for (let j of cheat[k]) {
            item += `/${itmAll[j].name}`;
          }
        }
      } else {
        item += artAll[artCurrentId].name;
        if (isArrCheat) {
          for (let j of cheat[k]) {
            const artChildId = itmAll[j].art;
            item += `/${artAll[artChildId].name}`;
          }
        }
      }
      arr.push(item);
    }
    condition = (arr.length > 1 ? '' : '修炼') + arr.join('+');
    if (other) {
      condition += (arr.length > 0 ? '，' : '') + other;
    }
    if (type === 2) {
      condition += '（需在武功面板）';
    }
    traArr.push({
      id: key,
      name,
      condition,
      effect,
    });
  }
  // 其他效果
  if (Array.isArray(tra)) {
    for (let item of tra) {
      if (typeof item !== 'object') {
        continue;
      }
      traArr.push(item);
    }
  }
  // 加连击
  if (jiaLianJiMap[artId]) {
    traArr.push({
      name: '加连击',
      condition: '在武功面板上',
      effect: [`连击率+${jiaLianJiMap[artId]}%`],
    });
  }
  // 加暴击
  if (jiaBaoJiMap[artId]) {
    traArr.push({
      name: '加暴击',
      condition: '在武功面板上',
      effect: [`暴击率+${jiaBaoJiMap[artId]}%`],
    });
  }
  return traArr;
}

/**
 * 格式化武功说明
 * @param info
 * @returns {any}
 */
export function formatArt(info = {}) {
  const item = JSON.parse(JSON.stringify(info));
  const {
    id,
    name,
    level,
    sect,
    type,
    inner,
    initiative,
    tra,
    addition,
    condition,
    power,
    range,
    get: learn,
  } = item;
  const cheat = artCheatMap[id];
  item.cheat = cheat ? itmAll[cheat].name : name;
  item.sectName = sectAll[sect]?.name ?? '';
  item.get = getLearn({
    sect,
    level,
    other: learn,
  });
  // 获取属性加成
  item.addition = getAttr({
    type,
    level,
    inner,
    other: addition,
  });
  // 获取学习条件
  item.condition = getCondition({
    type,
    level,
    inner,
    other: condition,
  });
  // 威力
  item.power = getPower({
    type,
    level,
    inner,
    other: power,
  });
  // 攻击范围
  item.range = getRange({
    type,
    level,
    other: range,
  });
  // 一脉相承
  item.inherit = getInherit(id);
  // 武功招式
  item.move = getMove(id);
  // 专属效果
  item.tra = getTra({id, tra, isCheat: false});
  // 内功主运特效
  if (Array.isArray(initiative)) {
    const arr = [];
    for (let key of initiative) {
      if (typeof innerMap[key] === 'function') {
        arr.push(innerMap[key](level));
      }
    }
    item.initiative = arr;
  }
  return item;
}
