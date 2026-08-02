import {bookMap} from '@/v107/data/map';

const bookChildren = [];
for (let key in bookMap) {
  bookChildren.push({
    path: key,
    component: () => import('@/v107/views/chr/book.vue'),
    name: 'chrBook' + key.replace(key[0], key[0].toUpperCase()) + 107,
    meta: {
      title: bookMap[key],
      type: key,
    },
  });
}

export default {
  path: 'chr',
  component: () => import('@/views/layout/layout.vue'),
  name: 'chr107',
  redirect: {name: 'chrSect107'},
  meta: {
    title: '人物',
  },
  children: [
    {
      path: 'sect',
      component: () => import('@/v107/views/chr/sect.vue'),
      name: 'chrSect107',
      meta: {
        title: '门派',
      },
    },
    {
      path: 'search',
      component: () => import('@/v107/views/chr/search.vue'),
      name: 'chrSearch107',
      meta: {
        title: '人物查询',
      },
    },
    {
      path: 'book',
      component: () => import('@/views/layout/router-view.vue'),
      name: 'chrBook107',
      redirect: {name: 'chrBookFei107'},
      meta: {
        title: '畅想',
      },
      children: bookChildren,
    },
    {
      path: 'special',
      component: () => import('@/v107/views/chr/book.vue'),
      name: 'chrSpecial107',
      meta: {
        title: '特殊',
        type: 'special',
      },
    },
    {
      path: 'talent',
      component: () => import('@/v107/views/chr/talent.vue'),
      name: 'chrTalent107',
      meta: {
        title: '天赋',
      },
    },
  ],
};
