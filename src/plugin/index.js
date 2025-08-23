import Tabs from '@/components/tabs.vue';
import Scroll from '@/components/scroll.vue';
import Table from '@/components/table.vue';
import Input from '@/components/input.vue';
import Button from '@/components/button.vue';

export default {
  install(app) {
    app.component('VTabs', Tabs);
    app.component('VScroll', Scroll);
    app.component('VTable', Table);
    app.component('VInput', Input);
    app.component('VButton', Button);
  },
};
