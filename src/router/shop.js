import {shopMap} from '@/data/map/index';
const children = [];

for (let key in shopMap) {
  children.push({
    path: key,
    component: () => import('@/views/shop/index.vue'),
    name: 'shop' + key.replace(key[0], key[0].toUpperCase()),
    meta: {
      title: shopMap[key],
      type: key,
    },
  });
}

export default {
  path: '/shop',
  component: () => import('@/views/layout/layout.vue'),
  name: 'shop',
  redirect: {name: 'shopXiaocun'},
  meta: {
    title: '商店',
  },
  children,
};
