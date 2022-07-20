import {createApp} from 'vue';
import App from './views/app.vue';
import router from '@/router/index';
import plugin from '@/plugin'
import '@/styles/index.less'

const app = createApp(App);
app.use(router);
app.use(plugin);
app.mount('#app');
