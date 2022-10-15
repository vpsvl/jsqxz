import {createRouter, createWebHistory, createWebHashHistory} from 'vue-router';
import processRoute from './process';
import goodsRoute from './goods';
import cheatRoute from './cheat';
import shopRoute from './shop';
import personRoute from './person';
import otherRoute from './other';

export const routes = [
  {
    path: '/',
    component: () => import('@/views/home/index.vue'),
    name: 'index',
  },
  processRoute,
  goodsRoute,
  cheatRoute,
  shopRoute,
  personRoute,
  otherRoute,
  {
    path: '/:catchAll(.*)',
    redirect: '/',
  },
];

export default createRouter({
  history: import.meta.env.PROD ? createWebHashHistory(import.meta.env.BASE_URL) : createWebHistory(),
  routes,
});

export const headerNav = {
  [processRoute.name]: processRoute.meta.title,
  [cheatRoute.name]: cheatRoute.meta.title,
  [goodsRoute.name]: goodsRoute.meta.title,
  [shopRoute.name]: shopRoute.meta.title,
  [personRoute.name]: personRoute.meta.title,
  [otherRoute.name]: otherRoute.meta.title,
};
