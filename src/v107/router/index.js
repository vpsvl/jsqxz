import processRoute from './process';
import goodsRoute from './goods';
import kungfuRoute from './kungfu';
import personRoute from './person';
import otherRoute from './other';

export const routes107 = [
  {
    path: '',
    component: () => import('@/v107/views/home/index.vue'),
    name: 'index107',
  },
  processRoute,
  goodsRoute,
  kungfuRoute,
  personRoute,
  otherRoute,
];

export const nav107 = {
  [processRoute.name]: processRoute.meta.title,
  [kungfuRoute.name]: kungfuRoute.meta.title,
  [goodsRoute.name]: goodsRoute.meta.title,
  [personRoute.name]: personRoute.meta.title,
  [otherRoute.name]: otherRoute.meta.title,
};
