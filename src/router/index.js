import {createRouter, createWebHistory, createWebHashHistory} from 'vue-router';
import {routes107, nav107} from '@/v107/router';

export const routes = [
  {
    path: '/',
    name: 'v107',
    meta: {title: 'v1.07'},
    redirect: {name: 'index107'},
    children: routes107,
  },
  {
    path: '/:catchAll(.*)',
    redirect: '/',
  },
];

export default createRouter({
  history: import.meta.env.PROD
    ? createWebHashHistory(import.meta.env.BASE_URL)
    : createWebHistory(),
  routes,
});

export const headerNav = {
  107: nav107,
};
