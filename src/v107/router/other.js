export default {
  path: 'other',
  component: () => import('@/views/layout/layout.vue'),
  name: 'other107',
  redirect: {name: 'otherSystem107'},
  meta: {
    title: '说明',
  },
  children: [
    {
      path: 'system',
      component: () => import('@/v107/views/other/system.vue'),
      name: 'otherSystem107',
      meta: {
        title: '系统说明',
      },
    },
    {
      path: 'meridian',
      component: () => import('@/v107/views/other/meridian.vue'),
      name: 'otherMeridian107',
      meta: {
        title: '经脉',
      },
    },
    {
      path: 'state',
      component: () => import('@/v107/views/other/state.vue'),
      name: 'otherState107',
      meta: {
        title: '状态',
      },
    },
    {
      path: 'keymap',
      component: () => import('@/v107/views/other/keymap.vue'),
      name: 'otherKeymap107',
      meta: {
        title: '快捷键',
      },
    },
  ],
};
