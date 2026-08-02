import itmAll from '@/v107/data/itm/list';

const artCheatMap = {};

for (let id in itmAll) {
  const {art} = itmAll[id];
  if (typeof art === 'number') {
    artCheatMap[art] = Number(id);
  }
}

export default artCheatMap;
