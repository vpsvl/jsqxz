import talentAll from '@/data/person/talent';
import talentStr from './talent';
import kungfuAll from '@/data/kungfu/effect/move';

/**
 * 根据lua天赋列表字符串修改天赋列表
 * @param {*} str
 * @returns
 */
export function formatTalent() {
  let str = talentStr.replace(/\-\-.*/g, '');
  // 表1天赋名称，表2天赋说明，表3 1非专属 2为专属，表4为1是非门天赋为2是门派天赋，表5为天赋等级(1蓝2紫3金4红)
  str = str.replace(/\{([^,]+),[^,]*,[^,]*,[^,]*,([^,]+),([^,]+)\}/g, '$1,$2,$3,');
  str = str.replace(/CC\.PTFSM\[(\d+?)\] ?\=/gi, '$1,');

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
      name: name.replace(/"|'| /g, ''),
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
 * 根据分数修改等级
 */
export function editTalentLevel() {
  const talentArr = talentStr.split('\n');
  const arr = [];
  for (let item of talentArr) {
    const itemArr = item.split(',');
    let rst = '';
    if (itemArr.length === 6) {
      for (let i of itemArr) {
        i = i.replace(/"/g, '');
        let num = Number.parseInt(i);
        if (!Number.isNaN(num)) {
          i = num;
        }
      }
      const score = itemArr[5].replace(/(\d+)\}.*/, '$1');
      if (score >= 40) {
        itemArr[4] = 4;
      } else if (score == 10) {
        itemArr[4] = 2;
      } else if (score == 0) {
        itemArr[4] = Number(itemArr[4]);
      } else {
        itemArr[4] = Math.ceil(score / 10);
      }
      rst = itemArr.join(',');
    } else {
      rst = item;
    }
    arr.push(rst);
  }
  console.log(arr.join('\n'));
}

function toArr() {
  const arr = [];
  for (let id in kungfuAll) {
    const {name, move} = kungfuAll[id];
    let moveStr = '';
    for (let item of move) {
      moveStr += `  {"${item}"},\n`;
    }
    const str = `-- ${name}
CC.KFMove[${id}] = {\n${moveStr}}`;
    arr.push(str);
  }
  console.log(arr.join('\n'));
}