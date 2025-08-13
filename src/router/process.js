import {bookMap} from '@/data/map/index';
const bookChildren = [];

for (let key in bookMap) {
  bookChildren.push({
    path: key,
    component: () => import('@/views/process/table.vue'),
    name: 'processBook' + key.replace(key[0], key[0].toUpperCase()),
    meta: {
      title: bookMap[key],
      type: key,
    },
  });
}

export default {
  path: '/process',
  component: () => import('@/views/layout/layout.vue'),
  name: 'process',
  redirect: {name: 'processStrategy'},
  meta: {
    title: '流程',
  },
  children: [
    {
      path: 'strategy',
      component: () => import('@/views/process/strategy.vue'),
      name: 'processStrategy',
      meta: {
        title: '群员攻略',
        type: 'strategy',
      },
    },
    {
      path: 'start',
      component: () => import('@/views/process/table.vue'),
      name: 'processStart',
      meta: {
        title: '开局搜刮',
        type: 'start',
      },
    },
    {
      path: 'fortune',
      component: () => import('@/views/process/table.vue'),
      name: 'processFortune',
      meta: {
        title: '江湖轶事',
        type: 'fortune',
      },
    },
    {
      path: 'book',
      component: () => import('@/views/layout/router-view.vue'),
      name: 'processBook',
      redirect: {name: 'processBookFei'},
      meta: {
        title: '天书流程',
      },
      children: bookChildren,
    },
    {
      path: 'huashan',
      component: () => import('@/views/process/table.vue'),
      name: 'processHuashan',
      meta: {
        title: '华山论剑',
        type: 'huashan',
      },
    },
    {
      path: 'wudao',
      component: () => import('@/views/process/table.vue'),
      name: 'processWudao',
      meta: {
        title: '武道大会',
        type: 'wudao',
      },
    },
  ],
};
