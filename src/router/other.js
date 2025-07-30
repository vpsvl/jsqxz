export default {
  path: '/other',
  component: () => import('@/views/layout/layout.vue'),
  name: 'other',
  redirect: {name: 'otherState'},
  meta: {
    title: '其他',
  },
  children: [
    {
      path: 'state',
      component: () => import('@/views/other/state.vue'),
      name: 'otherState',
      meta: {
        title: '状态',
      },
    },
    {
      path: 'keymap',
      component: () => import('@/views/other/keymap.vue'),
      name: 'otherKeymap',
      meta: {
        title: '快捷键',
      },
    },
    {
      path: 'meridian',
      component: () => import('@/views/other/meridian.vue'),
      name: 'otherMeridian',
      meta: {
        title: '经脉',
      },
    },
  ],
};
