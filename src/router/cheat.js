import {cheatMap} from '@/data/map/index';
const children = [];

for (let key in cheatMap) {
  children.push({
    path: key,
    component: () => import('@/views/cheat/index.vue'),
    name: 'cheat' + key.replace(key[0], key[0].toUpperCase()),
    meta: {
      title: cheatMap[key],
      type: key,
    },
  });
}

export default {
  path: '/cheat',
  component: () => import('@/views/layout/layout.vue'),
  name: 'cheat',
  redirect: {name: 'cheatInternal'},
  meta: {
    title: '秘籍',
  },
  children: [
    ...children,
    {
      path: 'other',
      component: () => import('@/views/cheat/other.vue'),
      name: 'cheatOther',
      meta: {
        title: '杂学',
        type: 'other',
      },
    },
    {
      path: 'inherit',
      component: () => import('@/views/cheat/inherit.vue'),
      name: 'cheatInherit',
      meta: {
        title: '一脉相承',
        type: 'inherit',
      },
    },
    {
      path: 'stunt',
      component: () => import('@/views/cheat/stunt.vue'),
      name: 'cheatStunt',
      meta: {
        title: '秘技',
        type: 'stunt',
      },
    },
  ],
};
