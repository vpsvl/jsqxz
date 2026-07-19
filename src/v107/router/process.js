import {bookMap} from '@/v107/data/map';
const bookChildren = [];

for (let key in bookMap) {
  bookChildren.push({
    path: key,
    component: () => import('@/v107/views/process/table.vue'),
    name: 'processBook' + key.replace(key[0], key[0].toUpperCase()) + 107,
    meta: {
      title: bookMap[key],
      type: key,
    },
  });
}

export default {
  path: 'process',
  component: () => import('@/views/layout/layout.vue'),
  name: 'process107',
  redirect: {name: 'processStart107'},
  meta: {
    title: '流程',
  },
  children: [
    {
      path: 'record',
      component: () => import('@/v107/views/process/record.vue'),
      name: 'processRecord107',
      meta: {
        title: '战报',
        type: 'record',
      },
    },
    {
      path: 'start',
      component: () => import('@/v107/views/process/table.vue'),
      name: 'processStart107',
      meta: {
        title: '开局搜刮',
        type: 'start',
      },
    },
    {
      path: 'fortune',
      component: () => import('@/v107/views/process/table.vue'),
      name: 'processFortune107',
      meta: {
        title: '江湖轶事',
        type: 'fortune',
      },
    },
    {
      path: 'book',
      component: () => import('@/views/layout/router-view.vue'),
      name: 'processBook107',
      redirect: {name: 'processBookFei107'},
      meta: {
        title: '天书流程',
      },
      children: bookChildren,
    },
    {
      path: 'huashan',
      component: () => import('@/v107/views/process/table.vue'),
      name: 'processHuashan107',
      meta: {
        title: '华山论剑',
        type: 'huashan',
      },
    },
    {
      path: 'wudao',
      component: () => import('@/v107/views/process/table.vue'),
      name: 'processWudao107',
      meta: {
        title: '武道大会',
        type: 'wudao',
      },
    },
  ],
};
