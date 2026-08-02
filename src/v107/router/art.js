import {artTypeMap} from '@/v107/data/map';

const artList = [
  {id: 6, key: 'inn'},
  {id: 7, key: 'dod'},
  {id: 1, key: 'una'},
  {id: 2, key: 'fin'},
  {id: 3, key: 'swd'},
  {id: 4, key: 'bld'},
  {id: 5, key: 'spc'},
];
const children = [];

for (let item of artList) {
  const {id, key} = item;
  const child = {
    path: key,
    name: 'art' + key.replace(key[0], key[0].toUpperCase()) + 107,
    meta: {
      title: artTypeMap[id],
      type: id,
    },
  };
  children.push({
    ...child,
    component: () => import('@/v107/views/art/index.vue'),
  });
}

export default {
  path: 'art',
  component: () => import('@/views/layout/layout.vue'),
  name: 'art107',
  redirect: {name: 'artInn107'},
  meta: {
    title: '武功',
  },
  children: [
    {
      path: 'search',
      component: () => import('@/v107/views/art/search.vue'),
      name: 'artSearch107',
      meta: {
        title: '武功查询',
        type: 'search',
      },
    },
    ...children,
    {
      path: 'knw',
      component: () => import('@/v107/views/art/knw.vue'),
      name: 'artKnw107',
      meta: {
        title: '杂学',
        type: 8,
      },
    },
    {
      path: 'inherit',
      component: () => import('@/v107/views/art/inherit.vue'),
      name: 'artInherit107',
      meta: {
        title: '一脉相承',
        type: 'inherit',
      },
    },
    {
      path: 'secret',
      component: () => import('@/v107/views/art/secret.vue'),
      name: 'artSecret107',
      meta: {
        title: '秘技',
        type: 'secret',
      },
    },
  ],
};
