import {kungfuTypeMap} from '@/data/map';

const kungfuList = [
  {id: 6, key: 'internal'},
  {id: 7, key: 'fly'},
  {id: 1, key: 'fist'},
  {id: 2, key: 'finger'},
  {id: 3, key: 'sword'},
  {id: 4, key: 'knife'},
  {id: 5, key: 'special'},
  {id: 8, key: 'other'},
];
const children = [];

for (let item of kungfuList) {
  const {id, key} = item;
  const child = {
    path: key,
    name: 'kungfu' + key.replace(key[0], key[0].toUpperCase()),
    meta: {
      title: kungfuTypeMap[id],
      type: id,
    },
  };
  if (id === 8) {
    children.push({
      ...child,
      component: () => import('@/views/kungfu/other.vue'),
    });
  } else {
    children.push({
      ...child,
      component: () => import('@/views/kungfu/index.vue'),
    });
  }
}

export default {
  path: '/kungfu',
  component: () => import('@/views/layout/layout.vue'),
  name: 'kungfu',
  redirect: {name: 'kungfuInternal'},
  meta: {
    title: '武功',
  },
  children: [
    ...children,
    {
      path: 'inherit',
      component: () => import('@/views/kungfu/inherit.vue'),
      name: 'kungfuInherit',
      meta: {
        title: '一脉相承',
        type: 'inherit',
      },
    },
    {
      path: 'stunt',
      component: () => import('@/views/kungfu/stunt.vue'),
      name: 'kungfuStunt',
      meta: {
        title: '秘技',
        type: 'stunt',
      },
    },
  ],
};
