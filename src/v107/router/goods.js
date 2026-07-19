import {equipmentMap, shopMap} from '@/v107/data/map';
const equipmentChildren = [];

for (let key in equipmentMap) {
  equipmentChildren.push({
    path: key,
    component: () => import('@/v107/views/goods/equipment.vue'),
    name: 'goodsEquipment' + key.replace(key[0], key[0].toUpperCase()) + 107,
    meta: {
      title: equipmentMap[key],
      type: key,
    },
  });
}

const shopChildren = [];
for (let key in shopMap) {
  shopChildren.push({
    path: key,
    component: () => import('@/v107/views/goods/shop.vue'),
    name: 'goodsShop' + key.replace(key[0], key[0].toUpperCase()) + 107,
    meta: {
      title: shopMap[key],
      type: key,
    },
  });
}

export default {
  path: 'goods',
  component: () => import('@/views/layout/layout.vue'),
  redirect: {name: 'goodsDrug107'},
  name: 'goods107',
  meta: {
    title: '物品',
  },
  children: [
    {
      path: 'drug',
      component: () => import('@/v107/views/goods/drug.vue'),
      name: 'goodsDrug107',
      meta: {
        title: '丹药',
      },
    },
    {
      path: 'equipment',
      component: () => import('@/views/layout/router-view.vue'),
      name: 'goodsEquipment107',
      redirect: {name: 'goodsEquipmentFist107'},
      meta: {
        title: '装备',
      },
      children: equipmentChildren,
    },
    {
      path: 'shop',
      component: () => import('@/views/layout/router-view.vue'),
      name: 'goodsShop107',
      redirect: {name: 'goodsShopXiaocun107'},
      meta: {
        title: '商店',
      },
      children: shopChildren,
    },
  ],
};
