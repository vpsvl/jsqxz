export default {
  name: '灵药',
  list: [
    {
      name: '千年灵芝',
      get: `
        1.找神秘少女搜刮前到明霞岛开启左上角宝箱 
        2.扬州商店出售2个（商店有bug，每次重新打开都可购买2个）
        3.射雕桃花岛打败郭靖 
        4.天龙邪带黑鸡慕容天龙寺战胜三兄弟 
        5.天龙拿到天书后不带段誉调查天龙寺左上房间书架战胜段思平
        6.倚天正光明顶地道战胜成昆
        7.鸳鸯岛宝箱
        8.鹿鼎山宝箱
        9.闯王宝藏宝箱
      `,
      effect: '体质+1',
    },
    {
      name: '大蟠桃',
      get: '',
      effect: '武学点数+2',
    },
    {
      name: '天山雪莲',
      get: '',
      effect: '武学点数+2，实战+2',
    },
    {
      name: '千年人参',
      get: '',
      effect: '属性+1(无效)',
    },
    {
      name: '莽牯朱蛤',
      get: '天龙无量山洞见段誉后',
      effect: '毒抗+100',
    },
    {
      name: '千年冰蚕',
      get: '云岭洞右上捡起冰蚕战胜游坦之',
      effect: '毒抗+100',
    },
    {
      name: '通犀地龙丸',
      get: '大理商店出售',
      effect: '毒抗+100',
    },
    {
      name: '天内丹',
      get: '龙门客栈商店出售',
      effect: '可重新选择天赋内功',
    },
    {
      name: '天轻丹',
      get: '洛阳商店出售',
      effect: '可重新选择天赋轻功',
    },
    {
      name: '天外丹',
      get: '大理商店出售',
      effect: '可重新选择天赋外功',
    },
    {
      name: '地灵丹',
      get: '龙门客栈出售',
      effect: '武常+50(已取消)',
    },
    // {
    //   name: '商会令牌',
    //   get: '小村商店10000银子兑换',
    //   effect: '兑换10000银子',
    // },
  ],
};
