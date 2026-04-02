import talentAll from '@/data/person/talent';

/**
 * 根据lua天赋列表字符串修改天赋列表
 * @param {*} str
 * @returns
 */
export function formatTalent(str = '') {
  str = str.replace(/\-\-.*/g, '');
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
  return talentAll;
}
