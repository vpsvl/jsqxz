import processRoute from './process';
import itmRoute from './itm';
import artRoute from './art';
import chrRoute from './chr';
import otherRoute from './other';

export const routes107 = [
  {
    path: '',
    component: () => import('@/v107/views/home/index.vue'),
    name: 'index107',
  },
  processRoute,
  itmRoute,
  artRoute,
  chrRoute,
  otherRoute,
];

export const nav107 = {
  [processRoute.name]: processRoute.meta.title,
  [artRoute.name]: artRoute.meta.title,
  [itmRoute.name]: itmRoute.meta.title,
  [chrRoute.name]: chrRoute.meta.title,
  [otherRoute.name]: otherRoute.meta.title,
};
