export default {
  name: '倚天屠龙记',
  normal: [
    {
      map: '朱府（西部）',
      event: [
        {
          list: ['与朱氏父女对话，然后到下方房间窗户处触发剧情，正邪分支'],
          reward: [],
        },
      ],
    },
  ],
  good: [
    {
      map: '朱府（西部）',
      event: [
        {
          list: ['选择『是』，进入正线'],
          reward: ['道德+1'],
        },
        {
          list: ['与上面房间张无忌对话，剧情后触发战斗：', 'VS 朱长龄+朱九真'],
          reward: ['道德+1'],
        },
      ],
    },
    {
      map: '昆仑派（西部）',
      event: [
        {
          list: ['与守门弟子对话'],
          reward: [],
        },
      ],
    },
    {
      map: '龙门客栈（西部）',
      event: [
        {
          list: [
            '客栈前对话触发剧情：',
            'VS 灭绝 （可败，胜利则任选一系+10点兵器值）',
            '战后殷离入队，得【峨眉九阳功】【寒冰绵掌】【千蛛万毒手】',
          ],
          reward: ['五系兵器值任选其一+10点', '峨眉九阳功[内功秘籍]', '寒冰绵掌[拳掌秘籍]', '千蛛万毒手[指法秘籍]', '殷离[队友]加入'],
        },
      ],
    },
    {
      map: '光明顶（西部）',
      event: [
        {
          list: ['剧情后，得【鹰爪功法】', '上房间小昭旁边的蒲团，开启密道'],
          reward: ['道德+1', '鹰爪功法[拳掌秘籍]', '地火功[内功秘籍]房间内宝箱获得'],
        },
        {
          list: ['进入光明顶密道，走到最里面房间，触发战斗：', 'VS 成昆（坚持到100时序不团灭即可）', '100时序击败成昆奖励 千年灵芝*1'],
          reward: ['千年灵芝[丹药] *1胜成昆奖励'],
        },
        {
          list: ['调查房间里的尸骨，获得【乾坤大挪移】', '之后再点击旁边石门离开'],
          reward: ['乾坤大挪移[内功秘籍]'],
        },
        {
          list: [
            '再次进入光明顶，剧情后，触发战斗：',
            '1、VS 昆仑派，胜利后得天王保命丹',
            '2、VS 华山派，胜利后得天王保命丹',
            '3、VS 崆峒派，胜利后得天王保命丹',
            '4、VS 空性，胜利后得【龙爪手】 天王保命丹',
            '5、VS 灭绝',
          ],
          reward: ['道德+5', '天王保命丹[丹药]*4', '龙爪手[指法秘籍]'],
        },
      ],
    },
    {
      map: '冰火岛（海外）',
      event: [
        {
          list: ['左下房间调查床上的金毛，获得[一撮金毛]'],
          reward: ['一撮金毛[剧情道具] '],
        },
      ],
    },
    {
      map: '光明顶（西部）',
      event: [
        {
          list: ['对张无忌使用[一撮金毛]，剧情后张无忌加入', '*昆仑仙境开启'],
          reward: ['道德+1', '张无忌[队友] 加入'],
        },
      ],
    },
    {
      map: '绿柳山庄（西部）',
      event: [
        {
          list: ['对话门口侍女，触发剧情：', 'VS 赵敏', '*此战主角内力值为0'],
          reward: [],
        },
      ],
    },
    {
      map: '武当派（中原）',
      event: [
        {
          list: [
            '进入屋子触发剧情：',
            '1、张无忌 VS 阿三',
            '2、张无忌 VS 阿二',
            '3、张无忌 VS 阿大',
            '剧情后，获得【倚天屠龙功】【大力金刚指】，如果已经拿到太极神功，获得【太极拳】【太极剑】',
            '出门得到消息要去万安寺',
          ],
          reward: [
            '大力金刚指[指法秘籍]',
            '倚天屠龙功[奇门秘籍]',
            '太极拳[拳掌秘籍]（需已经拿到太极神功）',
            '太极剑[剑法秘籍]（需已经拿到太极神功）',
            '张无忌奖励：',
            '第三格武功洗太极拳一',
            '第四格武功洗太极剑法一',
          ],
        },
      ],
    },
    {
      map: '万安寺（北部）',
      event: [
        {
          list: [
            '剧情后 VS 一堆番僧',
            '解救各派掌门，获得：',
            '【七伤拳谱】【两仪剑谱】【反两仪刀法】【虎爪绝户手】，如有学龙爪手变为必中',
            '最后一个房间开启剧情，然后从铁门处上到万安寺顶',
          ],
          reward: ['道德+5', '七伤拳谱[拳掌秘籍]', '两仪剑谱[剑法秘籍]', '反两仪刀法[刀法秘籍]', '虎爪绝户手[指法秘籍]', '龙爪手变为必中'],
        },
        {
          list: ['万安寺顶，剧情后进入战斗：', 'VS 玄冥二老', '*左边房间调查左边书架可以获得【玄冥神掌】'],
          reward: ['玄冥神掌[拳掌秘籍]'],
        },
        {
          list: ['从万安寺顶下来，门口对话张无忌'],
          reward: [],
        },
      ],
    },
    {
      map: '龙门客栈（西部）',
      event: [
        {
          list: ['客栈对话赵敏，收赵敏入队，得[倚天剑]'],
          reward: ['倚天剑[武器]', '赵敏[队友] 入队'],
        },
      ],
    },
    {
      map: '灵蛇岛（海外）',
      event: [
        {
          list: ['张无忌在队剧情后触发战斗：', 'VS 圣火三使', '得【阴风刀】【圣火神功】[屠龙刀]，小昭加入'],
          reward: ['道德+1', '阴风刀[刀法秘籍]', '圣火神功[内功秘籍]', '屠龙刀[武器]', '小昭[队友]加入'],
        },
      ],
    },
    {
      map: '光明顶（西部）',
      event: [
        {
          list: ['与谢逊对话，获得【狮吼功法】'],
          reward: ['狮吼功法[内功秘籍]'],
        },
      ],
    },
    {
      map: '成昆居（北部）',
      event: [
        {
          list: ['剧情后，触发战斗：', 'VS 成昆+一群喽啰', '胜后，获得[一颗头颅]'],
          reward: ['道德+2', '一颗头颅[剧情道具]'],
        },
      ],
    },
    {
      map: '光明顶（西部）',
      event: [
        {
          list: ['对着谢逊使用[一颗头颅]，获得《倚天屠龙记》和[九阴真经下卷]'],
          reward: ['倚天屠龙记[十四天书之一]', '九阴真经下卷[剧情道具]'],
        },
        {
          list: ['再次与谢逊对话，可以选择是否挑战光明之试炼，选『是』：', 'VS逍遥二仙+四大法王', '胜利后主角五系兵器值+10'],
          reward: ['主角五系兵器值+10'],
        },
      ],
    },
  ],
  evil: [
    {
      map: '朱府（西部）',
      event: [
        {
          list: ['选择『否』，进入邪线，剧情后朱九真加入'],
          reward: ['道德-2', '朱九真[队友] 加入'],
        },
      ],
    },
    {
      map: '昆仑派（西部）',
      event: [
        {
          list: ['与守门弟子对话'],
          reward: [],
        },
      ],
    },
    {
      map: '光明顶（西部）',
      event: [
        {
          list: ['剧情后，调查左上房间小昭旁边的蒲团，开启密道'],
          reward: [],
        },
        {
          list: ['进入光明顶密道，走到最里面房间，触发战斗：', 'VS 成昆（坚持100时序不团灭即可）'],
          reward: [],
        },
        {
          list: ['调查房间里的尸骨，获得【乾坤大挪移】', '之后再点击旁边石门离开'],
          reward: ['乾坤大挪移[内功秘籍]'],
        },
      ],
    },
    {
      map: '成昆居（北部）',
      event: [
        {
          list: ['与成昆对话，得【幻阴指法】'],
          reward: ['道德-3', '幻阴指法[指法秘籍]'],
        },
      ],
    },
    {
      map: '光明顶（西部）',
      event: [
        {
          list: ['与范遥对话'],
          reward: [],
        },
      ],
    },
    {
      map: '灵蛇岛（海外）',
      event: [
        {
          list: ['剧情后触发战斗：', 'VS 圣火三使', '得【阴风刀】【圣火神功】'],
          reward: ['阴风刀[刀法秘籍]', '圣火神功[内功秘籍]'],
        },
      ],
    },
    {
      map: '光明顶（西部）',
      event: [
        {
          list: ['与谢逊/范遥对话'],
          reward: [],
        },
      ],
    },
    {
      map: '昆仑派（西部）',
      event: [
        {
          list: ['剧情后触发战斗：', 'VS 昆仑派', '胜后获得【两仪剑谱】、【七伤拳谱】'],
          reward: ['道德-3', '七伤拳谱[拳掌秘籍]', '两仪剑谱[剑法秘籍]'],
        },
      ],
    },
    {
      map: '崆峒派（西部）',
      event: [
        {
          list: [
            'VS 看门弟子',
            '剧情后触发战斗：',
            '1、VS 崆峒派',
            '2、VS 崆峒派+华山派，胜后得【反两仪刀法】',
            '3、VS 崆峒派+华山派+峨眉派，胜后获得[倚天剑]',
            '剧情后谢逊送【狮吼功法】',
            '*昆仑仙境开启',
          ],
          reward: ['道德-9', '反两仪刀法[刀法秘籍]', '倚天剑[武器]', '狮吼功法[内功秘籍]'],
        },
      ],
    },
    {
      map: '峨嵋派（西部）',
      event: [
        {
          list: ['进入房间触发剧情，剧情后对话周芷若', '选『是』，周芷若入队，获得【倚天剑谱】'],
          reward: ['倚天剑谱[剑法秘籍]', '周芷若[队友] 加入'],
        },
      ],
    },
    {
      map: '少室山下-少林寺（中原）',
      event: [
        {
          list: [
            '周芷若在队，进入少林，触发剧情，获得[屠龙刀]',
            '剧情后刀剑互砍，得到[断裂的倚天剑]、[断裂的屠龙刀]',
            '获得[九阴真经下卷]【白蟒鞭法】',
            '周芷若可选是否洗第一格武功为九阴白骨爪或白蟒鞭法',
            '第一格武功洗九阴白骨爪可获得【九阴白骨爪】',
            '*在招冯铁匠且神雕剧情获得天外陨铁后，可在冯铁匠处修复刀剑',
          ],
          reward: [
            '断裂的倚天剑[剧情物品]',
            '断裂的屠龙刀[剧情物品]',
            '九阴真经下卷[剧情物品]',
            '白蟒鞭法[奇门秘籍]',
            '九阴白骨爪[奇门秘籍] 第一格武功洗九阴白骨爪',
            '周芷若奖励：',
            '五系兵器值+10',
            '第一格武功洗九阴白骨爪或白蟒鞭法一',
            '第二格武功洗九阴神功一',
            '天赋外功增加九阴白骨爪',
            '天赋内功洗为九阴神功',
          ],
        },
        {
          list: ['与右上角和尚对话，进入少林后山', '*进去后不打赢出不去'],
          reward: ['道德+1'],
        },
        {
          list: [
            '走到里面触发战斗',
            '1.VS 渡劫+渡难+渡厄',
            '选择是否揭发成昆',
            '选择否',
            '获得《倚天屠龙记》【金刚伏魔圈】',
            '选择是',
            '2.VS 成昆+汝阳王府高手',
            '获得《倚天屠龙记》【金刚狮子吼】',
          ],
          reward: ['道德+5', '金刚伏魔圈[奇门秘籍]', '倚天屠龙记[十四天书之一]', '金刚狮子吼[内功秘籍]'],
        },
      ],
    },
    {
      map: '光明顶（西部）',
      event: [
        {
          list: ['到天书以后，与范遥对话，挑战光明之试炼奖励战', 'VS 摩尼'],
          reward: ['主角五系兵器值+10'],
        },
      ],
    },
  ],
  branch: [
    {
      map: '凤阳-蝴蝶谷（中原）',
      event: [
        {
          list: [
            '与胡青牛对话，剧情后触发战斗：',
            'VS 金花婆婆',
            '胜后，回小村可收胡青牛、王难姑入队',
            '*此剧情在剧情进行到灵蛇岛战圣火三使后便无法进行',
          ],
          reward: ['道德+1', '胡青牛医书[医书]收胡青牛获得', '毒经[医书]收王难姑获得', '胡青牛[队友]加入', '王难姑[队友]加入'],
        },
      ],
    },
    {
      map: '武当派（中原）',
      event: [
        {
          list: [
            '与张三丰对话，再次与其对话：',
            '获得【绕指柔剑法】',
            '主角道德≥65时，获得【无极玄功拳】',
            '主角道德≥75时，获得【龟息功】',
            '主角道德≥85时，获得【神门剑谱】',
          ],
          reward: ['绕指柔剑法[剑法秘籍]', '无极玄功拳[拳掌秘籍]', '龟息功[内功秘籍]', '神门剑谱[剑法秘籍]', ''],
        },
        {
          list: ['获得武当三宝后，对话张三丰，可以选择挑战', '张三丰血量降低50%或坚持200时序后获得【太极神功】'],
          reward: ['太极神功[内功秘籍]'],
        },
      ],
    },
    {
      map: '冰火岛（海外）',
      event: [
        {
          list: ['正线开启冰火岛，进入最里面，遇见火蟾，触发战斗：', 'VS 火蟾', '胜后获得[火蟾]'],
          reward: ['火蟾[剧情道具]'],
        },
        {
          list: ['光明顶，对蝠王使用[火蟾]'],
          reward: ['道德+1'],
        },
      ],
    },
    {
      map: '峨眉派（西部）',
      event: [
        {
          list: ['正邪分支后，左侧小路触发剧情，剧情分支'],
          reward: [],
        },
        {
          list: ['选择『是』，触发战斗：', 'VS 莫声谷', '胜后，宋青书加入，获得【绵掌掌谱】'],
          reward: ['道德-8', '绵掌掌谱[拳掌秘籍]', '宋青书[队友] 加入'],
        },
        {
          list: ['选择『否』，触发战斗：', 'VS 宋青书+陈友谅', '胜后获得【神门剑谱】'],
          reward: ['道德+1', '神门剑谱[剑法秘籍]'],
        },
      ],
    },
    {
      map: '昆仑仙境（西部）',
      event: [
        {
          list: [
            '正线张无忌入队后开启',
            '1. 进入触发剧情：',
            'VS 金轮众人',
            '胜后，获得【猿公剑谱】【楞伽经】',
            '*少林寺达摩堂佛像前使用楞伽经可选择研读[楞伽经]，选『是』则：VS斗酒僧，胜利后获得【九阳真经】',
            '2. 与屋子里的阿青对话，触发战斗：',
            'VS 阿青',
            '胜后，道德>100',
            '阿青加入，获得【越女剑法】【白猿】',
          ],
          reward: ['猿公剑谱[剑法秘籍]', '越女剑法[剑法秘籍]', '楞伽经[剧情道具]', '白猿[坐骑]', '阿青[队友]加入'],
        },
        {
          list: [
            '邪线崆峒三连战后开启',
            '1. 右上角落石碑处使用[铁铲]',
            'VS 阿青+白猿',
            '胜利后获得【楞伽经】【猿公剑谱】',
            '*少林寺达摩堂佛像前使用楞伽经可选择研读[楞伽经]，选『是』则：VS斗酒僧，胜利后获得【九阳真经】',
            '2. 与屋子里的阿青对话，触发战斗：',
            'VS 阿青',
            '胜后，道德>100',
            '阿青加入，获得【越女剑法】【白猿】',
          ],
          reward: ['猿公剑谱[剑法秘籍]', '越女剑法[剑法秘籍]', '楞伽经[剧情道具]', '白猿[坐骑]', '阿青[队友]加入'],
        },
      ],
    },
  ],
};
