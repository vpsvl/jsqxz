export default {
  path: '/other',
  component: () => import('@/views/layout/layout.vue'),
  name: 'other',
  redirect: {name: 'otherKeymap'},
  meta: {
    title: '其他',
  },
  children: [
    {
      path: 'keymap',
      component: () => import('@/views/keymap/index.vue'),
      name: 'otherKeymap',
      meta: {
        title: '快捷键',
      },
    },
    // {
    //   path: 'meridian',
    //   component: () => import('@/views/meridian/index.vue'),
    //   name: 'otherMeridian',
    //   meta: {
    //     title: '经脉',
    //   },
    // },
  ],
};
