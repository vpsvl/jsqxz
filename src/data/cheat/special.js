export default {
  name: '奇门',
  exclusive: '',
  list: [
    {
      id: 'yangJiaQiangFa',
      name: '杨家枪法',
      cheat: '',
      level: 1,
      get: '开局宝箱获得',
      power: 250,
      gasPower: 500,
      range: '田 6格',
      condition: '奇门20',
      addition: '攻击+1 防御+1 奇门+2',
      internal: '',
      sect: '',
      peculiar: [{name: '一脉相承', condition: '', effect: ['可洗为岳家枪法']}],
    },
    {
      id: 'duLongBianFa',
      name: '毒龙鞭法',
      cheat: '',
      level: 1,
      get: '龙门客栈帮叮当',
      power: 300,
      gasPower: 0,
      range: '米 4格',
      condition: '奇门20',
      addition: '攻击+1 2奇门+2',
      internal: '',
      sect: '',
      peculiar: [],
    },
    {
      id: 'sanWuWuMaYan',
      name: '三蜈五蟆烟',
      cheat: '',
      level: 1,
      get: '暂无',
      power: 300,
      gasPower: 500,
      range: '■ 10格',
      condition: '奇门20',
      addition: '奇门+2 暗器+3 带毒+5',
      internal: '0',
      sect: '',
      peculiar: [],
    },
    {
      id: 'haiSouDiaoFa',
      name: '海叟钓法',
      cheat: '',
      level: 1,
      get: '冲霄洞不让谭婆与赵钱孙相见',
      power: 300,
      gasPower: 0,
      range: '田 6格',
      condition: '奇门30',
      addition: '攻击+1 轻功+1 奇门+2',
      internal: '',
      sect: '',
      peculiar: [{name: '绝处逢生', condition: '海叟钓法+银锁金玲', effect: ['被攻击15%概率不受伤害']}],
    },
    {
      id: 'huYanQiangFa',
      name: '呼延枪法',
      cheat: '',
      level: 1,
      get: '洛阳客栈出售',
      power: 440,
      gasPower: 0,
      range: '米 4格',
      condition: '奇门30',
      addition: '攻击+1 轻功+1 奇门+2',
      internal: '',
      sect: '',
      peculiar: [{name: '寸长寸强', condition: '呼延枪法+呼延十八鞭', effect: ['使用奇门武功伤害不随距离降低，距离每远一格伤害增加1%']}],
    },
    {
      id: 'huYanShiBaBian',
      name: '呼延十八鞭',
      cheat: '呼延鞭法',
      level: 1,
      get: '鸳鸯刀乌鞘岭战胜周威信',
      power: 440,
      gasPower: 0,
      range: '米 3格',
      condition: '奇门40',
      addition: '攻击+1 防御+1 奇门+2',
      internal: '',
      sect: '',
      peculiar: [{name: '寸长寸强', condition: '呼延枪法+呼延十八鞭', effect: ['使用奇门武功伤害不随距离降低，距离每远一格伤害增加1%']}],
    },
    {
      id: 'zhongPingQiangFa ',
      name: '中平枪法 ',
      cheat: '',
      level: 2,
      get: '连邪偷花铁干/收花铁干',
      power: 330,
      gasPower: 600,
      range: '田 4格',
      condition: '奇门30',
      addition: '攻击+1 防御+1 轻功+1 奇门+2',
      internal: '',
      sect: '',
      peculiar: [],
    },
    {
      id: 'heSheBaDa ',
      name: '鹤蛇八打 ',
      cheat: '',
      level: 2,
      get: '无量山击败四大恶人',
      power: 550,
      gasPower: 700,
      range: '米 4格',
      condition: '奇门40',
      addition: '攻击+1 轻功+1 奇门+2',
      internal: '0',
      sect: '',
      peculiar: [],
    },
    {
      id: 'daJianDao',
      name: '大剪刀',
      cheat: '',
      level: 2,
      get: '天龙偷岳老三',
      power: 660,
      gasPower: 800,
      range: '田 3格',
      condition: '奇门50',
      addition: '攻击+1 轻功+1 奇门+2',
      internal: '',
      sect: '',
      peculiar: [],
    },
    {
      id: 'wuHuGunFa',
      name: '五虎棍法',
      cheat: '',
      level: 2,
      get: '龙门客栈商店出售',
      power: 660,
      gasPower: 600,
      range: '田 4格',
      condition: '奇门60',
      addition: '攻击+1 防御+1 奇门+3',
      internal: '',
      sect: '',
      peculiar: [
        {
          name: '五虎',
          condition: '五虎断门刀+五虎棍法',
          effect: [
            '赞天虎：一虎在场，攻击时30%概率提升全队100集气',
            '彻地虎：二虎在场，被攻击时30%概率提高1000点气防',
            '穿山虎：三虎在场，攻击时30%概率增加100点伤害',
            '翻江虎：四虎在场，集气条30%概率跳跃10点集气速度',
            '锦毛虎：五虎在场，被攻击时30%概率弹10%伤害',
          ],
        },
      ],
    },
    {
      id: 'chiYaoQin',
      name: '持摇琴',
      cheat: '',
      level: 2,
      get: '洛阳城令狐冲再次入队获得（简易线令狐冲入队后获得）',
      power: 732,
      gasPower: 0,
      range: '■ 5+9×9',
      condition: '奇门20',
      addition: '攻击+1 轻功+1 奇门+3',
      internal: '',
      sect: '',
      peculiar: [
        {
          name: '琴棋书画-琴',
          condition: '同时修炼琴棋书画',
          effect: ['威力+300', '琴音悦耳：攻击不造成怒气，100%发动', '菩提清心：使敌方怒气减半，概率发动'],
        },
        {
          name: '剑胆琴心',
          condition: '独孤九剑+持瑶琴',
          effect: [
            '攻击时距离敌人越近，增加的命中越多',
            '受到攻击时距离敌人越近，减少敌人的命中越多',
            // '自身受到的伤害会转化为战斗中临时的御剑系数提高（持续整场战斗有效，加成上限不会超过320）',
            '使用持瑶琴攻击时，自身恢复5%当前血量并减少10点内伤',
            '学有其中之一，则学习另一武功的兵器值需求-40',
          ],
        },
      ],
    },
    {
      id: 'peiJiangJunTie ',
      name: '裴将军帖 ',
      cheat: '',
      level: 2,
      get: '梅庄击败秃笔翁',
      power: 770,
      gasPower: 700,
      range: '米 4格',
      condition: '奇门70',
      addition: '攻击+2 奇门+3',
      internal: '',
      sect: '',
      peculiar: [],
    },
    {
      id: 'qiPanZhaoShi',
      name: '棋盘招式',
      cheat: '',
      level: 2,
      get: '擂鼓山苏星河给予',
      power: 777,
      gasPower: 800,
      range: '田 3格',
      condition: '奇门20',
      addition: '攻击+1 轻功+1 奇门+2',
      internal: '',
      sect: '',
      peculiar: [
        {
          name: '琴棋书画-棋',
          condition: '同时修炼琴棋书画',
          effect: ['威力+300', '棋高一着：追加1200气攻，100%发动', '星罗棋布：额外提升1000气攻，概率发动'],
        },
      ],
    },
    {
      id: 'huangShaWanLiBian',
      name: '黄沙万里鞭',
      cheat: '',
      level: 2,
      get: '1.白马邪破庙打败陈达海后获得 2.笑傲正收蓝凤凰',
      power: 990,
      gasPower: 600,
      range: '田 6格',
      condition: '奇门70',
      addition: '攻击+1 轻功+1 奇门+3',
      internal: '0',
      sect: '',
      peculiar: [],
    },
    {
      id: 'baiMangBianFa',
      name: '白蟒鞭法',
      cheat: '',
      level: 3,
      get: '倚天邪线少林寺剧情，正线带袁紫衣战胜灭绝获得',
      power: 1100,
      gasPower: 0,
      range: '田 5格',
      condition: '奇门60',
      addition: '攻击+1 轻功+1 奇门+4',
      internal: '0',
      sect: '',
      peculiar: [],
    },
    {
      id: 'fengMoGunFa',
      name: '疯魔棍法',
      cheat: '',
      level: 3,
      get: '',
      power: 1210,
      gasPower: 1100,
      range: '田 5格',
      condition: '奇门70',
      addition: '攻击+2 奇门+3',
      internal: '',
      sect: '',
      peculiar: [],
    },
    {
      id: 'miaoBiDanQing',
      name: '妙笔丹青',
      cheat: '',
      level: 3,
      get: '射雕正带程英找朱子柳，邪一灯居战斗偷朱子柳',
      power: 976,
      gasPower: 1200,
      range: '◇ 4格',
      condition: '奇门70',
      addition: '攻击+1 轻功+1 奇门+3',
      internal: '',
      sect: '',
      peculiar: [
        {
          name: '琴棋书画-画',
          condition: '同时修炼琴棋书画',
          effect: ['威力+300', '画地为牢：使妙笔丹青攻击附带冰封，高概率发动', '江山如画：大幅提升妙笔丹青冰封效果，概率发动'],
        },
      ],
    },
    {
      id: 'yinYangDaoLuanRen',
      name: '阴阳倒乱刃',
      cheat: '',
      level: 3,
      get: '神雕绝情谷战胜公孙止获',
      power: 1100,
      gasPower: 600,
      range: '田 5格',
      condition: '奇门70',
      addition: '攻击+1 轻功+1 剑法+2 刀法+2 奇门+1',
      internal: '',
      sect: '',
      peculiar: [
        {
          name: '定神门',
          condition: '神门十三剑+五行六合掌+阴阳倒乱刃+灵枢定玄指',
          effect: ['刀剑连击概率+10%，拳指暴击概率+10%', '攻击时锁足概率+100%，封穴+5点'],
        },
      ],
    },
    {
      id: 'yinSuoJinLing',
      name: '银索金铃',
      cheat: '',
      level: 3,
      get: '程英居击败李莫愁获得',
      power: 1100,
      gasPower: 900,
      range: '■ 4+5×5',
      condition: '奇门100',
      addition: '攻击+1 轻功+1 奇门+4',
      internal: '0',
      sect: '',
      peculiar: [{name: '绝处逢生', condition: '海叟钓法+银锁金玲', effect: ['被攻击15%概率不受伤害']}],
    },
    {
      id: 'wuShangDaLiChu',
      name: '无上大力杵',
      cheat: '',
      level: 3,
      get: '神雕邪线重阳宫达尔巴送',
      power: 1210,
      gasPower: 1200,
      range: '■ 5+5×5',
      condition: '奇门100',
      addition: '攻击+2 轻功+1 奇门+4',
      internal: '1',
      sect: '',
      peculiar: [
        {
          name: '世尊降魔',
          condition: '伏魔杖法+无上大力杵+金刚伏魔圈+罗汉伏魔功',
          effect: [
            '暴击率增加50%',
            '如果造成的伤害<300，则伤害等于300，暴怒追加一定气功伤害',
            '如果造成的伤害>300，则伤害等于300，则追加一定气功值伤害，暴怒则追加大量气功值伤害',
          ],
        },
      ],
    },
    {
      id: 'liuYunFeiXiu',
      name: '流云飞袖',
      cheat: '',
      level: 3,
      get: '暂无',
      power: 1200,
      gasPower: 1200,
      range: '■ 3+3×3',
      condition: '奇门100',
      addition: '攻击+1 轻功+1 防御+1 奇门+4',
      internal: '',
      sect: '',
      peculiar: [],
    },
    {
      id: 'jiaShaFuMoGong',
      name: '袈裟伏魔功',
      cheat: '',
      level: 3,
      get: '书剑南少林调查书架',
      power: 1200,
      gasPower: 1200,
      range: '■ 5+5×5',
      condition: '奇门140',
      addition: '攻击+2 防御+1 奇门+5',
      internal: '1',
      sect: '',
      peculiar: [],
    },
    {
      id: 'fuMoZhangFa',
      name: '伏魔杖法',
      cheat: '',
      level: 4,
      get: '少林寺达摩院左边宝箱，需战斗和减道德',
      power: 1510,
      gasPower: 1100,
      range: '田 5格',
      condition: '奇门100',
      addition: '攻击+1 轻功+1 奇门+4',
      internal: '',
      sect: '',
      peculiar: [
        {
          name: '世尊降魔',
          condition: '伏魔杖法+无上大力杵+金刚伏魔圈+罗汉伏魔功',
          effect: [
            '暴击率增加50%',
            '如果造成的伤害<300，则伤害等于300，暴怒追加一定气功伤害',
            '如果造成的伤害>300，则伤害等于300，则追加一定气功值伤害，暴怒则追加大量气功值伤害',
          ],
        },
      ],
    },
    {
      id: 'yueJiaQiangFa',
      name: '岳家枪法',
      cheat: '',
      level: 4,
      get: '铁掌山拿玉玺处山洞中，调查书架战胜岳云和上官剑南后获得',
      power: 1650,
      gasPower: 700,
      range: '■ 5格',
      condition: '奇门100',
      addition: '攻击+3 奇门+4',
      internal: '',
      sect: '',
      peculiar: [
        {name: '一脉相承', condition: '', effect: ['可由杨家枪法一脉相承']},
        {
          name: '血战沙场',
          condition: '岳家枪法+岳王散手+武穆遗书',
          effect: [
            '使用岳家枪法/岳王散手对七格范围内敌人造成10~20点伤害2次，根据击杀数和怒气值增加次数',
            '学习岳家枪法/岳王散手，另一门需求减40',
          ],
        },
      ],
    },
    {
      id: 'yangChunBaiXueQu',
      name: '阳春白雪曲',
      cheat: '',
      level: 4,
      get: '不老长春谷战胜逍遥子获得',
      power: 1430,
      gasPower: 1100,
      range: '■ 5+7×7',
      condition: '奇门100',
      addition: '攻击+2 防御+1 奇门+5 带毒+2',
      internal: '',
      sect: '',
      peculiar: [],
    },
    {
      id: 'yiTianTuLongGong',
      name: '倚天屠龙功',
      cheat: '',
      level: 4,
      get: '倚天正武当山击退蒙古众人后获得',
      power: 1500,
      gasPower: 1100,
      range: '米 5格',
      condition: '奇门100',
      addition: '攻击+1 轻功+1 奇门+4',
      internal: '',
      sect: '',
      peculiar: [
        {name: '琴棋书画-书', condition: '同时修炼琴棋书画', effect: ['威力+300', '秉笔直书：攻击必定造成封穴，且伤害提升20%，概率发动']},
      ],
    },
    {
      id: 'jinGangFuMoQuan',
      name: '金刚伏魔圈',
      cheat: '',
      level: 4,
      get: '倚天邪线打三渡后获得',
      power: 1490,
      gasPower: 1100,
      range: '田 3格',
      condition: '奇门100',
      addition: '攻击+1 轻功+1 奇门+4',
      internal: '',
      sect: '',
      peculiar: [
        {
          name: '金刚伏魔阵',
          condition: '战场上队伍里同时修炼金刚伏魔圈2人以上',
          effect: ['金刚伏魔圈护体：2人，提升15%防御且气防+500', '真·金刚伏魔圈护体： 2+人，提升30%防御且气防+1000'],
        },
        {
          name: '世尊降魔',
          condition: '伏魔杖法+无上大力杵+金刚伏魔圈+罗汉伏魔功',
          effect: [
            '暴击率增加50%',
            '如果造成的伤害<300，则伤害等于300，暴怒追加一定气功伤害',
            '如果造成的伤害>300，则伤害等于300，则追加一定气功值伤害，暴怒则追加大量气功值伤害',
          ],
        },
      ],
    },
    {
      id: 'wuLunDaZhuan',
      name: '五轮大转',
      cheat: '',
      level: 4,
      get: '神雕邪线金轮法王送',
      power: 1430,
      gasPower: 1300,
      range: '田 6格',
      condition: '奇门140',
      addition: '攻击+2 奇门+5',
      internal: '',
      sect: '',
      peculiar: [],
    },
    {
      id: 'lingSheZhangFa',
      name: '灵蛇杖法',
      cheat: '',
      level: 4,
      get: '华山绝顶帮欧阳锋获得',
      power: 1540,
      gasPower: 1400,
      range: '田 5格',
      condition: '奇门140',
      addition: '攻击+2 防御+1 奇门+5 带毒+2',
      internal: '0',
      sect: '',
      peculiar: [],
    },
    {
      id: 'daGouBangFa',
      name: '打狗棒法',
      cheat: '',
      level: 4,
      get: '华山绝顶帮洪七公获得',
      power: 1540,
      gasPower: 1400,
      range: '米 3格',
      condition: '奇门140',
      addition: '攻击+2 轻功+1 奇门+6',
      internal: '',
      sect: '',
      peculiar: [
        {name: '天下无狗', condition: '使用打狗棒法40%概率发动，暴怒必定发动', effect: ['攻击无误伤，攻击范围变为面攻，气攻提升至2400']},
        {
          name: '盖世无双',
          condition: '同时修炼降龙十八掌+打狗棒法到极',
          effect: ['被攻击时50%概率触发，完全免疫杀气和内伤', '*已经学有其中之一，则学习另一个的系数需求-40点'],
        },
      ],
    },
  ],
};
