import {equipmentMap} from '@/data/map/index';
const equipmentChildren = [];

for (let key in equipmentMap) {
  equipmentChildren.push({
    path: key,
    component: () => import('@/views/goods/equipment.vue'),
    name: 'goodsEquipment' + key.replace(key[0], key[0].toUpperCase()),
    meta: {
      title: equipmentMap[key],
      type: key,
    },
  });
}

export default {
  path: '/goods',
  component: () => import('@/views/layout/layout.vue'),
  redirect: {name: 'goodsEquipmentFist'},
  name: 'goods',
  meta: {
    title: '物品',
  },
  children: [
    {
      path: 'equipment',
      component: () => import('@/views/layout/router-view.vue'),
      name: 'goodsEquipment',
      redirect: {name: 'goodsEquipmentFist'},
      meta: {
        title: '装备',
      },
      children: equipmentChildren,
    },
    {
      path: 'drug',
      component: () => import('@/views/goods/drug.vue'),
      name: 'goodsDrug',
      meta: {
        title: '丹药',
      },
    },
  ],
};
