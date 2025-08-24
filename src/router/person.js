import {sectMap, bookMap} from '@/data/map/index';

const sectChildren = [];
for (let key in sectMap) {
  sectChildren.push({
    path: key,
    component: () => import('@/views/person/sect.vue'),
    name: 'personSect' + key.replace(key[0], key[0].toUpperCase()),
    meta: {
      title: sectMap[key],
      type: key,
    },
  });
}

const bookChildren = [];
for (let key in bookMap) {
  bookChildren.push({
    path: key,
    component: () => import('@/views/person/book.vue'),
    name: 'personBook' + key.replace(key[0], key[0].toUpperCase()),
    meta: {
      title: bookMap[key],
      type: key,
    },
  });
}

export default {
  path: '/person',
  component: () => import('@/views/layout/layout.vue'),
  redirect: {name: 'personTalent'},
  name: 'person',
  meta: {
    title: '人物',
  },
  children: [
    {
      path: 'talent',
      component: () => import('@/views/person/talent.vue'),
      name: 'personTalent',
      meta: {
        title: '天赋',
      },
    },
    {
      path: 'sect',
      component: () => import('@/views/layout/router-view.vue'),
      name: 'personSect',
      redirect: {name: 'personSectJianghu'},
      meta: {
        title: '门派',
      },
      children: sectChildren,
    },
    {
      path: 'book',
      component: () => import('@/views/layout/router-view.vue'),
      name: 'personBook',
      redirect: {name: 'personBookFei'},
      meta: {
        title: '畅想',
      },
      children: bookChildren,
    },
    {
      path: 'special',
      component: () => import('@/views/person/book.vue'),
      name: 'personSpecial',
      meta: {
        title: '特殊',
        type: 'special',
      },
    },
  ],
};
