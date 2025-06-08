import affected from './affected';
import attack from './attack';
import debuff from './debuff';
import decrease from './decrease';
import immunity from './immunity';
import increase from './increase';
import recovery from './recovery';
import special from './special';

export default {
  ...affected,
  ...attack,
  ...debuff,
  ...decrease,
  ...immunity,
  ...increase,
  ...recovery,
  ...special,
};
