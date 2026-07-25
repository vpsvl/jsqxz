import talentAll from '@/v107/data/person/talent';
import talentStr from './talent';
import stateStr from './state';

/**
 * 根据lua天赋列表字符串修改天赋列表
 * @returns
 */
export function formatTalent() {
  let str = talentStr.replace(/--.*/g, '');
  // 表1天赋名称，表2天赋说明，表3 1非专属 2为专属，表4为1是非门天赋为2是门派天赋，表5为天赋等级(1蓝2紫3金4红)
  str = str.replace(/\{([^,]+),[^,]*,[^,]*,[^,]*,([^,]+),([^,]+)}/g, '$1,$2,$3,');
  str = str.replace(/CC\.PTFSM\[(\d+?)] ?=/gi, '$1,');

  const list = str.split('\n');
  const rst = {};
  for (let item of list) {
    if (!item) {
      continue;
    }
    const info = item.split(/, */);
    if (info.length < 4) {
      continue;
    }
    let [id, name, level, score] = info;
    rst[id] = {
      name: name.replace(/["' ]/g, ''),
      level: Number(level),
      score: Number(score),
    };
  }
  for (let id in talentAll) {
    const item = talentAll[id];
    item.name = rst[id].name;
    item.level = rst[id].level;
    item.score = rst[id].score;
  }
  console.log(talentAll);
}

/**
 * 根据lua状态列表字符串修改状态
 * @returns
 */
export function formatState() {
  let str = stateStr.replace(/--.*/g, '');
  str = str.replace(/["' ]/g, '');
  str = str.replace(/\{([^,]+),([^,]+),([^,]+),[^,]*,[^,]*,([^,]+)}/g, '$1,$2,$3,$4');
  str = str.replace(/CC\.ZTSM\[(\d+?)] ?=/gi, '$1,');
  const list = str.split('\n');
  const rst = {};
  for (let item of list) {
    if (!item) {
      continue;
    }
    const info = item.split(/, */);
    if (info.length < 5) {
      continue;
    }
    let [id, name, effect, type, shortName] = info;
    rst[id] = {id: Number(id), name, effect: [effect], type: Number(type), shortName};
  }
  console.log(Object.values(rst));
}

// function toArr() {
//   const arr = [];
//   for (let id in kungfuAll) {
//     const {name, move} = kungfuAll[id];
//     let moveStr = '';
//     for (let item of move) {
//       moveStr += `  {"${item}"},\n`;
//     }
//     const str = `-- ${name}
// CC.KFMove[${id}] = {\n${moveStr}}`;
//     arr.push(str);
//   }
//   console.log(arr.join('\n'));
// }
