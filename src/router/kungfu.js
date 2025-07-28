import {kungfuMap} from '@/data/map/index';
const children = [];

for (let key in kungfuMap) {
  children.push({
    path: key,
    component: () => {
      if(key === 'other'){
        return import('@/views/kungfu/other.vue');
      }
      return import('@/views/kungfu/index.vue')
    },
    name: 'kungfu' + key.replace(key[0], key[0].toUpperCase()),
    meta: {
      title: kungfuMap[key],
      type: key,
    },
  });
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
