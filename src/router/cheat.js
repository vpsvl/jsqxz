import {outMap} from '@/data/map/index';
const outChildren = [];

for (let key in outMap) {
  outChildren.push({
    path: key,
    component: () => import('@/views/cheat/out.vue'),
    name: 'cheat' + key.replace(key[0], key[0].toUpperCase()),
    meta: {
      title: outMap[key],
      type: key,
    },
  });
}

export default {
  path: '/cheat',
  component: () => import('@/views/layout/layout.vue'),
  name: 'cheat',
  redirect: {name: 'cheatFist'},
  meta: {
    title: '秘籍',
  },
  children: [
    ...outChildren,
    {
      path: 'internal',
      component: () => import('@/views/cheat/internal.vue'),
      name: 'cheatInternal',
      meta: {
        title: '内功',
        type: 'internal',
      },
    },
    {
      path: 'fly',
      component: () => import('@/views/cheat/internal.vue'),
      name: 'cheatFly',
      meta: {
        title: '轻功',
        type: 'fly',
      },
    },
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
        title: '组合技',
        type: 'stunt',
      },
    },
  ],
};
