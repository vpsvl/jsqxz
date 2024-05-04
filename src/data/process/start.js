export default {
  name: '开局搜刮',
  normal: [
    {
      map: '明霞岛（海外）',
      event: [
        {
          list: ['对话神秘少女搜刮前，开启明霞岛左下角宝箱可获得[千年灵芝]', '*神秘少女搜刮该宝箱会变为[天山雪莲]*2'],
          reward: ['千年灵芝[丹药]'],
        },
      ],
    },
    {
      map: '送信（只能选一）',
      event: [
        {
          list: [
            '畅想和特殊人物将介绍信送给各门派NPC可加入门派：',
            '1. 天机宫(西部)、密宗(西部大轮寺)、丐帮(中原)、星宿派(西部)（杀死丁春秋后无法加入和学习武功），送给传功NPC',
            '2. 华山派(中原)、逍遥派(北部灵鹫宫)、天龙寺(西部大理)，需在剧情推进到看门弟子消失之前，送给看门弟子',
            '3. 武当派(中原)需在跟张三丰对话前送给张三丰',
            '4. 血刀门(西部)送给血刀老祖，血刀老祖在人物模型偏左一格的位置',
            '5. 少林派(中原)送给大雄宝殿的方证，可选择入达摩院或般若堂，但是不能获得少林派对应的天赋',
          ],
          reward: [],
        },
        {
          list: ['打开主角房间中的宝箱之前，将介绍信送给青城派(西部)余沧海获得【摧心掌】'],
          reward: [],
        },
        {
          list: ['打开主角房间中的宝箱之前，将介绍信送给重阳宫(中原)丘处机获得【金雁功】'],
          reward: [],
        },
        {
          list: ['打开主角房间中的宝箱之前，将介绍信送给少林寺(中原)大雄宝殿的玄慈获得【降魔刀法】'],
          reward: [],
        },
      ],
    },
    {
      map: '小村（江南）',
      event: [
        {
          list: [
            '与迷之少女对话可选择是否开局搜刮',
            '1、『全搜刮』搜刮后道德-10（多搜刮台湾的一个宝箱，自己开启道德-1）',
            '2、『部分搜刮』 搜刮后不减道德',
            '3、『放弃』 放弃开局搜刮',
            '搜刮之后可以在神秘少女处关闭心魔，关闭夜幕',
          ],
          reward: [],
        },
        {
          list: ['打开主角房间中的宝箱', '获得[银两]*10000、【松风剑法】【罗汉拳】【杨家枪法】【柴刀十八路】【天竺佛指】'],
          reward: [],
        },
        {
          list: ['与北丑对话后使用银两', '获得[铁铲]'],
          reward: [],
        },
      ],
    },
    {
      map: '江陵-天宁寺（江南）',
      event: [
        {
          list: ['点击功德箱'],
          reward: [],
        },
        {
          list: ['选择‘捐赠’，[银两] -100，道德+1，道德最高提高到100'],
          reward: [],
        },
        {
          list: ['选择‘慈悲’，[银两] -2000，道德提高到100'],
          reward: [],
        },
        {
          list: ['选择‘偷窃’，[银两] +100，道德-5'],
          reward: [],
        },
        {
          list: ['选择‘抢劫’，触发战斗：', 'VS 扫地神僧+少林高僧+少林弟子', '胜后[银两]+(道德*200)，道德变0'],
          reward: [],
        },
      ],
    },
    {
      map: '台湾（海外）',
      event: [
        {
          list: [
            '左边房间，靠上的箱子开启会获得飞蝗石*10、银两*500、【夺魄指法】，但道德-1',
            '*迷之少女搜刮时选择全搜刮会自动搜刮这个箱子',
          ],
          reward: ['道德-1', '夺魄指法[指法秘籍]'],
        },
      ],
    },
    {
      map: '修炼点',
      event: [
        {
          list: [
            '青城派(西部)左上房间弟子，可刷修炼经验和门派贡献',
            '重阳宫(中原)右边弟子，可刷修炼经验和门派贡献',
            '少林寺(中原)左上打桩弟子，可刷修炼经验和门派贡献',
            '丐帮(中原)右边弟子，可刷修炼经验和门派贡献',
            '百花谷(中原)老顽童，可刷修炼经验和门派贡献',
            '南少林(江南)大痴和尚，可刷武学点数、修炼经验和门派贡献',
            '蜘蛛洞(北部)开启后，可进出场景刷武学点数、修炼经验和门派贡献',
            '可直接挑战的看门弟子：笑傲剧情福州和衡阳的青城弟子、凌霄城、泰山、恒山、嵩山、衡山、崆峒、铁掌峰、丐帮、无量山神龙岛教徒、神龙岛',
          ],
          reward: [],
        },
      ],
    },
  ],
};
