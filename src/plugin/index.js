import Tabs from '@/components/tabs.vue';
import Scroll from '@/components/scroll.vue';
import Table from '@/components/table.vue';

export default {
  install(app) {
    app.component('VTabs', Tabs);
    app.component('VScroll', Scroll);
    app.component('VTable', Table);
  },
};
