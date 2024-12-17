export default {
  name: '天龙八部',
  normal: [
    {
      map: '无量山（西部）',
      event: [
        {
          list: [
            '进入场景触发战斗：',
            'VS 神龙高手+神龙教徒',
            '胜后可收钟灵入队，获得【万劫刀法】',
            '带钟灵去云岭洞找到闪电貂',
            '钟灵领悟“灵貂”指令（偷窃敌方携带的物品并对其强制上毒50点）',
            '*如果钟灵不在队伍，调查闪电貂后，闪电貂会消失不见',
          ],
          reward: ['道德+1 ', '万劫刀法[刀法秘籍]', '大蟠桃[丹药] 调查树', '钟灵[队友] 加入 ', '钟灵奖励：', '领悟“灵貂”指令'],
        },
        {
          list: [
            '进入左上的无量山洞',
            '找到段誉（不带钟灵则无法获得凌波微步），剧情后出来在山洞出口处触发战斗：',
            'VS 莽牯朱蛤',
            '胜后获得[莽牯朱蛤]',
          ],
          reward: ['莽牯朱蛤[丹药]'],
        },
        {
          list: ['从无量山洞出来发现段誉正被四大恶人围住，触发战斗:', 'VS四大恶人', '胜后获得【鹤蛇八打】 [鳄皮护甲]'],
          reward: ['道德+1', '鹤蛇八打[奇门秘籍]', '鳄皮护甲[防具]', '大剪刀刀谱[奇门秘籍]偷岳老三', '大剪刀[武器]偷岳老三'],
        },
      ],
    },
    {
      map: '大理-天龙寺（西部）',
      event: [
        {
          list: [
            '进入天龙寺，遇见鸠摩智来抢六脉神剑，触发战斗：',
            'VS 鸠摩智（可败）',
            '战斗后对话枯荣大师，获得【枯荣禅功】',
            '两次对话左上房间僧人，可得到“长春不老谷”的信息',
          ],
          reward: ['道德+1', '溪山行旅图[剧情道具] 房间宝箱', '火焰刀[刀法秘籍] 胜鸠摩智', '枯荣禅功[内功秘籍] 对话枯荣大师'],
        },
      ],
    },
    {
      map: '苏州-燕子坞（江南）',
      event: [
        {
          list: [
            '进入燕子坞右边房间，剧情后与慕容复对话',
            '先给慕容复[玉玺](开局搜刮)',
            '再给[大燕皇帝世袭图表](铁掌山宝箱)',
            '触发正邪分支',
          ],
          reward: [],
        },
      ],
    },
  ],
  good: [
    {
      map: '苏州-燕子坞（江南）',
      event: [
        {
          list: ['选『否』进入正线，临走时段誉送主角【北冥神功】', '*需在去丐帮前到天台山和冲霄洞拿秘籍'],
          reward: ['道德+2', '北冥神功[内功秘籍]'],
        },
      ],
    },
    {
      map: '丐帮（中原）',
      event: [
        {
          list: ['与看门弟子对话，触发战斗：', 'VS 丐帮打狗阵', '胜后获得【莲花功】'],
          reward: ['莲花功[内功秘籍]'],
        },
        {
          list: [
            '进入丐帮触发剧情，慕容复揭发乔峰身世，乔峰离开丐帮',
            '*此时会提示是否体验翔实剧情，选择『否』则进入简易线，剧情跳至第七步：与丐帮弟子对话开启少林大战',
          ],
          reward: [],
        },
      ],
    },
    {
      map: '天台山（中原）',
      event: [
        {
          list: ['点击调查智光大师的尸体'],
          reward: [],
        },
      ],
    },
    {
      map: '冲霄洞（西部）',
      event: [
        {
          list: ['点击调查赵钱孙、谭公谭婆的尸体'],
          reward: [],
        },
      ],
    },
    {
      map: '洛阳城（中原）',
      event: [
        {
          list: ['进入洛阳城商店接到聚贤庄的英雄贴'],
          reward: [],
        },
      ],
    },
    {
      map: '聚贤庄（中原）',
      event: [
        {
          list: [
            '与乔峰一起对战天下群雄（其实就是一群喽罗）：',
            '1、VS 游氏双雄',
            '2、VS 游氏双雄+薛慕华',
            '3、VS 游氏双雄+薛慕华+丐帮弟子',
            '4、VS 游氏双雄+薛慕华+各派弟子',
            '5、VS 游氏双雄+薛慕华+各派弟子',
          ],
          reward: ['道德+5'],
        },
        {
          list: ['五连战后主角被乔峰打出聚贤庄，再次进入聚贤庄与阿朱对话', '若身上有[七宝指环]可收薛慕华入队'],
          reward: [],
        },
      ],
    },
    {
      map: '丐帮（中原）',
      event: [
        {
          list: ['与看门弟子对话，得知新帮主去了少林'],
          reward: ['道德+5（简易线）'],
        },
      ],
    },
    {
      map: '少室山下（中原）',
      event: [
        {
          list: ['右上树下对话乔峰', '获得【擒龙手】'],
          reward: ['擒龙手[指法秘籍]'],
        },
        {
          list: [
            '由少室山进入少林寺，剧情后触发战斗：',
            '1、VS 游坦之',
            '2、VS 慕容复',
            '3、VS 游坦之+慕容复',
            '4、VS 游坦之+慕容复+鸠摩智，得【无相劫指法】',
            '5、VS 游坦之+慕容复+鸠摩智+慕容博+四大恶人+丐帮弟子',
          ],
          reward: ['道德+3', '无相劫指[指法秘籍]'],
        },
        {
          list: ['剧情之后，乔峰给予【降龙十八掌】《天龙八部》'],
          reward: ['天龙八部[十四天书之一]', '降龙十八掌[拳掌秘籍]'],
        },
        {
          list: ['与段誉、王语嫣对话，剧情后段誉、王语嫣离开'],
          reward: [],
        },
      ],
    },
    {
      map: '无量山（西部）',
      event: [
        {
          list: ['进入无量山洞，与段誉、王语嫣对话，可邀请2人入队', '回小村可收王语嫣、段誉入队'],
          reward: ['道德+2', '段誉[队友]加入', '王语嫣[队友]加入'],
        },
      ],
    },
    {
      map: '大理-天龙寺（西部）',
      event: [
        {
          list: [
            '不带段誉，左上房间调查书架，触发战斗',
            'VS 段思平+枯荣',
            '挑战胜利可获得【六脉神剑】【地灵丹】【千年灵芝】',
            '挑战失败只可获得【六脉神剑】',
          ],
          reward: [
            '六脉神剑[指法秘籍]',
            '地灵丹[丹药]需挑战胜利',
            '千年灵芝[丹药]需挑战胜利',
            '段思平奖励：需挑战胜利',
            '第一格武功洗六脉神剑一级',
          ],
        },
      ],
    },
    {
      map: '苏州-燕子坞（江南）',
      event: [
        {
          list: ['带段誉和虚竹进屋触发战斗', ' VS 慕容复（黑级浮屠）', '战胜后乔峰、阿朱回小村'],
          reward: ['阿朱[队友] 加入'],
        },
      ],
    },
  ],
  evil: [
    {
      map: '苏州-燕子坞（江南）',
      event: [
        {
          list: [
            '选『是』接受慕容复的请求，获得[带头大哥的书信]',
            '慕容复、王语嫣入队，虚竹在队则会永久离队',
            '获得【斗转星移】',
            '*邪线开启后将不可收虚竹入队，需要天山六阳掌、小无相功、七宝指环的要提前去做完虚竹支线',
            '*邪线不要提前去少林寺拿【一苇渡江】，否则慕容复无法领悟黑级浮屠',
          ],
          reward: ['道德-8', '带头大哥的书信[剧情道具]', '斗转星移[特技]慕容复加入获得', '慕容复[队友]加入', '王语嫣[队友]加入'],
        },
      ],
    },
    {
      map: '丐帮（中原）',
      event: [
        {
          list: ['与看门弟子对话，触发战斗：', 'VS 丐帮打狗阵', '胜后获得【莲花功】'],
          reward: ['莲花功[内功秘籍]'],
        },
        {
          list: ['进入丐帮剧情后触发战斗（慕容复、王语嫣需在队伍）：', 'VS 丐帮打狗阵', '胜利后获得【逍遥游】'],
          reward: ['道德-5', '逍遥游[轻功秘籍]'],
        },
      ],
    },
    {
      map: '聚贤庄（中原）',
      event: [
        {
          list: ['剧情后触发战斗：', 'VS 萧远山', '胜利后获得【拈花指法】', '若身上有[七宝指环]可收薛慕华入队'],
          reward: ['道德-3', '拈花指法[指法秘籍]'],
        },
      ],
    },
    {
      map: '丐帮（中原）',
      event: [
        {
          list: [
            '进入丐帮触发剧情，剧情后',
            '主角VS游坦之',
            '战斗胜利后，获得【冰蚕毒掌】【神足经】，明王送【无相劫指法】',
            '与阿紫对话，回小村可收游坦之和阿紫入队',
          ],
          reward: ['道德-3', '冰蚕毒掌[拳掌秘籍]', '神足经[内功秘籍]', '无相劫指法[指法秘籍]', '阿紫[队友]加入', '游坦之[队友]加入'],
        },
      ],
    },
    {
      map: '少室山下-少林寺',
      event: [
        {
          list: [
            '进入少林寺(慕容复、游坦之、王语嫣必须在队)，乔峰抗着音响出场，剧情后触发战斗',
            '1、VS 乔峰',
            '2、VS 乔峰+段誉',
            '3、VS 乔峰+段誉+虚竹+萧远山',
            '战斗结束后鸠摩智送【火焰刀法】，获得《天龙八部》',
          ],
          reward: ['道德-8', '主角五系兵器值+10', '天龙八部[十四天书之一]', '火焰刀法[刀法秘籍]', '天狼爪[武器]'],
        },
        {
          list: [
            '若此时仍未获取【一苇渡江】，慕容复在队，可对话扫地神僧左侧书架，挑战扫地神僧，获取【一苇渡江】',
            'VS 扫地神僧',
            '获胜后获得【一苇渡江】，慕容复领悟黑级浮屠，天赋内功洗易筋经，第二格洗易筋经',
          ],
          reward: ['一苇渡江[轻功秘籍]'],
        },
      ],
    },
    {
      map: '大理-天龙寺（西部）',
      event: [
        {
          list: [
            '进入天龙寺慕容复（需领悟黑级浮屠）在队，触发剧情',
            'VS 乔峰+段誉+虚竹+天龙寺众僧',
            '战斗结束获得【北冥神功】，千年灵芝，地灵丹',
            '*天龙门派屠寺后无法学习武功',
          ],
          reward: ['道德-10', '北冥神功[内功秘籍]', '地灵丹[丹药]', '千年灵芝[丹药]'],
        },
        {
          list: [
            '左上房间调查书架，触发战斗',
            'VS 段思平+枯荣',
            '挑战胜利可获得【六脉神剑】【地灵丹】【千年灵芝】',
            '挑战失败只可获得【六脉神剑】',
          ],
          reward: ['六脉神剑[指法秘籍]', '地灵丹[丹药]需挑战胜利', '千年灵芝[丹药]需挑战胜利'],
        },
      ],
    },
  ],
  branch: [
    {
      map: '龙门客栈（西部）',
      event: [
        {
          list: [
            '在进入天龙邪线之前，道德≥75时，与虚竹对话，收虚竹入队',
            '*直接带虚竹去少林寺，虚竹会永久离队，道德+10，获得【少林九阳功】',
            '*虚竹可随意修炼，邪线少林寺大战时的虚竹为固定属性和武功',
          ],
          reward: ['虚竹[队友] 加入'],
        },
      ],
    },
    {
      map: '擂鼓山（中原）',
      event: [
        {
          list: ['虚竹在队，与苏星河对话，剧情后无崖子传功虚竹', '与虚竹对话，再次收虚竹入队'],
          reward: [
            '天山六阳掌[拳掌秘籍]',
            '小无相功[内功秘籍]',
            '棋盘招式[奇门秘籍]',
            '虚竹[队友]加入',
            '虚竹奖励：',
            '资质+10，属性提高',
            '第一格武功洗天山六阳掌4级',
            '第二格武功洗小无相功4级',
            '天赋增加：自带北冥真气',
          ],
        },
      ],
    },
    {
      map: '星宿海（西部）',
      event: [
        {
          list: ['虚竹在队伍，触发战斗：', 'VS丁春秋+星宿门人', '胜后得【化功大法】【神木王鼎】【连环腐尸毒】'],
          reward: ['道德+5', '化功大法[内功秘籍]', '连环腐尸毒[指法秘籍]', '神木王鼎[剧情道具]'],
        },
      ],
    },
    {
      map: '擂鼓山（中原）',
      event: [
        {
          list: ['击败丁春秋后与苏星河对话获得【七宝指环】'],
          reward: ['七宝指环[武器]'],
        },
      ],
    },
    {
      map: '恒山-恒山山麓（中原）',
      event: [
        {
          list: [
            '进入场景，触发战斗：',
            'VS 卓不凡等人',
            '胜后虚竹离队',
            '*因为有铁手和冷血乱入，前期难度较高，打不过可以直接去灵鹫宫触发VS李秋水的战斗，胜利后就可以进入灵鹫宫学武功',
          ],
          reward: ['虚竹[队友] 离队', '七宝指环[武器] -1'],
        },
      ],
    },
    {
      map: '凉州-西夏皇宫（北部）',
      event: [
        {
          list: ['从凉州进入西夏皇宫，进入左侧房间触发战斗：', '主角+虚竹VS李秋水（坚持300时序即可）'],
          reward: [],
        },
        {
          list: [
            '进入西夏皇宫右上角房间对话李清露，收李清露入队',
            '获得【寒袖拂穴】【白虹掌力】'
          ],
          reward: [
            '李清露[队友]加入',
            '寒袖拂穴[指法秘籍]', '白虹掌力[拳掌秘籍]'
          ],
        },
      ],
    },
    {
      map: '灵鹫宫（北部）',
      event: [
        {
          list: ['收李清露入队后，进入场景触发战斗：', 'VS 卓不凡', '胜后获得【剑华皈壹】【周公剑法】', '虚竹加入获得【七宝指环】'],
          reward: ['剑华皈壹[内功秘籍]', '周公剑法[剑法秘籍]', '七宝指环[武器] ', '虚竹[队友]加入'],
        },
        {
          list: [
            '进入灵鹫宫',
            '练功房观看最后一张壁画，获得【八荒六合功】',
            '右下房间调查书架可获得【天山折梅手】',
            '*不想虚竹洗武功、加资质可以把虚竹踢出队伍',
          ],
          reward: [
            '山折梅手[拳掌秘籍]',
            '八荒六合功[内功秘籍]',
            '虚竹奖励：（获得八荒时）',
            '资质+10',
            '第三格武功八荒六合功1级',
            '虚竹奖励：（获得天山折梅手时）',
            '第五格武功洗天山折梅手1级',
            '天山折梅手修炼到极后资质变为50',
          ],
        },
        {
          list: ['学会【八荒六合功】 【北冥神功】【小无相功】', '中间房子进去对雕像空格触发对战无崖子解锁【逍遥御风】'],
          reward: ['解锁【逍遥御风】'],
        },
      ],
    },
    {
      map: '无量山-无量山洞（西部）',
      event: [
        {
          list: [
            '无量山洞带钟灵见段誉后，山洞里点击雕像，剧情后触发战斗：',
            'VS 逍遥三老（无崖子+天山童姥+李秋水）',
            '胜后获得【凌波微步】',
          ],
          reward: ['凌波微步[轻功秘籍]', '王语嫣奖励：', '天赋轻功洗为凌波微步'],
        },
      ],
    },
    {
      map: '少室山下-少林寺（中原）',
      event: [
        {
          list: [
            '天龙正线拿到天书后与扫地僧对话，触发战斗',
            'VS 扫地僧+玄慈+空闻+空性+少林弟子（此战可败）',
            '畅想乔峰战胜后获得专属装备[音箱]',
          ],
          reward: ['胜利后奖励：', '主角五系兵器值+10', '音箱[武器]'],
        },
        {
          list: ['与扫地僧对话，扫地左边书架空格触发战斗', 'VS 扫地僧'],
          reward: ['胜利后奖励：', '一苇渡江[轻功秘籍]'],
        },
        {
          list: ['拿到一苇渡江，扫地右边书架空格触发战斗', 'VS 达摩（达摩50%血或撑过300时序即可）'],
          reward: ['胜利后奖励：', '易筋经[内功秘籍]'],
        },
      ],
    },
    {
      map: '苏州-燕子坞（江南）',
      event: [
        {
          list: [
            '丐帮游坦之、阿紫剧情后，慕容复在队，去左下角房间书架上调查可获得【参合指法】【参合剑气】',
            '对着关闭的房门点击空格支付6000两即可进入"还施水阁"',
          ],
          reward: ['参合指法[指系秘籍]', '参合剑气[剑法秘籍]'],
        },
      ],
    },
    {
      map: '长春不老谷（西部）',
      event: [
        {
          list: [
            '对话天龙寺左上房间僧人，得到“长春不老谷”的信息',
            '持有七宝指，调查墓碑，逍遥子出现',
            'VS 逍遥子（坚持2000时序亦可获胜）',
            '战胜后获得秘籍【不老长春功】【阳春白雪曲】',
          ],
          reward: ['不老长春功[内功秘籍]', '阳春白雪曲[奇门秘籍]'],
        },
      ],
    },
  ],
};
