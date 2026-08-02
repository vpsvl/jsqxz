// 低级:高级
const inheritAscMap = {
  1: 22,
  17: 49,
  42: 139,
  50: 193,
  68: 200,
  89: 175,
  94: 203,
  95: 180,
  122: 136,
  163: 160,
  208: 108,
  209: 171,
  210: 100,
  211: 154,
  212: 89,
  213: 216,
  214: 163,
  215: 204,
  217: 93,
  225: 190,
  227: 183,
  241: 106,
  242: 106,
  243: 106,
  245: 36,
  266: 265,
  321: 271,
  364: 404,
  366: 239,
  380: 424,
  383: 149,
  384: 186,
  385: 147,
  386: 429,
  387: 349,
  388: 223,
  389: 2,
  390: 146,
  391: 392,
  393: 394,
  395: 396,
  399: 400,
  401: 402,
  403: 237,
  405: 150,
  406: 407,
  408: 409,
  410: 411,
  412: 413,
  414: 415,
  416: 417,
  418: 419,
  421: 361,
  422: 360,
  423: 148,
  425: 379,
  428: 397,
  441: [145, 224, 262],
};
// 高级:低级
const inheritDescMap = {};

for (let aId in inheritAscMap) {
  const bId = inheritAscMap[aId];
  if (Array.isArray(bId)) {
    for (let child of bId) {
      if (Array.isArray(inheritDescMap[child])) {
        inheritDescMap[child].push(Number(aId));
        continue;
      }
      if (inheritDescMap[child]) {
        inheritDescMap[child] = [inheritDescMap[child], Number(aId)];
        continue;
      }
      inheritDescMap[child] = Number(aId);
    }
    continue;
  }
  if (Array.isArray(inheritDescMap[bId])) {
    inheritDescMap[bId].push(Number(aId));
    continue;
  }
  if (inheritDescMap[bId]) {
    inheritDescMap[bId] = [inheritDescMap[bId], Number(aId)];
    continue;
  }
  inheritDescMap[bId] = Number(aId);
}

export {
  inheritAscMap,
  inheritDescMap,
};
