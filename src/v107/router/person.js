import {bookMap} from '@/v107/data/map';

const bookChildren = [];
for (let key in bookMap) {
  bookChildren.push({
    path: key,
    component: () => import('@/v107/views/person/book.vue'),
    name: 'personBook' + key.replace(key[0], key[0].toUpperCase()) + 107,
    meta: {
      title: bookMap[key],
      type: key,
    },
  });
}

export default {
  path: 'person',
  component: () => import('@/views/layout/layout.vue'),
  name: 'person107',
  redirect: {name: 'personSect107'},
  meta: {
    title: '人物',
  },
  children: [
    {
      path: 'sect',
      component: () => import('@/v107/views/person/sect.vue'),
      name: 'personSect107',
      meta: {
        title: '门派',
      },
    },
    {
      path: 'book',
      component: () => import('@/views/layout/router-view.vue'),
      name: 'personBook107',
      redirect: {name: 'personBookFei107'},
      meta: {
        title: '畅想',
      },
      children: bookChildren,
    },
    {
      path: 'special',
      component: () => import('@/v107/views/person/book.vue'),
      name: 'personSpecial107',
      meta: {
        title: '特殊',
        type: 'special',
      },
    },
    {
      path: 'talent',
      component: () => import('@/v107/views/person/talent.vue'),
      name: 'personTalent107',
      meta: {
        title: '天赋',
      },
    },
  ],
};
