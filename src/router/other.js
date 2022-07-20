export default {
  path: '/other',
  component: () => import('@/views/layout/layout.vue'),
  name: 'other',
  redirect: {name: 'otherMeridian'},
  meta: {
    title: '其他',
  },
  children: [
    {
      path: 'meridian',
      component: () => import('@/views/meridian/index.vue'),
      name: 'otherMeridian',
      meta: {
        title: '经脉',
      },
    },
  ],
};
