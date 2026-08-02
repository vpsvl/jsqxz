import {itmTypeMap} from '@/v107/data/map';
import shopMap from '@/v107/data/itm/shop';

const typeList = [
  {id: 22, key: 'pot'},
  {id: 23, key: 'thr'},
  {id: 11, key: 'eqp'},
  {id: 12, key: 'arm'},
  {id: 13, key: 'mnt'},
];
const children = [];

for (let item of typeList) {
  const {id, key} = item;
  children.push({
    path: key,
    component: () => import('@/v107/views/itm/list.vue'),
    name: 'itm' + key.replace(key[0], key[0].toUpperCase()) + 107,
    meta: {
      title: itmTypeMap[id],
      type: id,
    },
  });
}

const shopChildren = [];
for (let key in shopMap) {
  shopChildren.push({
    path: key,
    component: () => import('@/v107/views/itm/shop.vue'),
    name: 'itmShop' + key.replace(key[0], key[0].toUpperCase()) + 107,
    meta: {
      title: shopMap[key].name,
      type: key,
    },
  });
}

export default {
  path: 'itm',
  component: () => import('@/views/layout/layout.vue'),
  redirect: {name: 'itmPot107'},
  name: 'itm107',
  meta: {
    title: '物品',
  },
  children: [
    ...children,
    {
      path: 'shop',
      component: () => import('@/views/layout/router-view.vue'),
      name: 'itmShop107',
      redirect: {name: 'itmShopXiaocun107'},
      meta: {
        title: '商店',
      },
      children: shopChildren,
    },
  ],
};
