<template>
  <div class="layout">
    <v-menu :menu="menus"></v-menu>
    <div class="main">
      <bread-nav :nav="breads"></bread-nav>
      <v-scroll class="main-scroll" view-class="main-scroll-view">
        <router-view></router-view>
      </v-scroll>
    </div>
  </div>
</template>

<script setup>
import {watchEffect, ref} from 'vue';
import {useRoute} from 'vue-router';
import {routes} from '@/router';
import VMenu from './menu.vue';
import BreadNav from './bread-nav.vue';

const route = useRoute();
const menus = ref([]);
const breads = ref([]);
watchEffect(() => {
  const {matched} = route;
  const routeRootName = breads.value[0] ? breads.value[0].name : '';
  breads.value = matched;
  if (routeRootName === matched[0].name) {
    return;
  }
  const currentRoute = routes.find((item) => item.name === matched[0].name);
  if (currentRoute) {
    menus.value = currentRoute.children ? currentRoute.children : [];
  }
});
</script>

<style lang="less">
.layout {
  display: flex;
  .main {
    flex: 1;
    background: #fff;
  }
  .main-scroll {
    height: calc(100% - 50px);
    min-width: 500px;
  }
  .main-scroll-view {
    padding: 0 20px 20px;
  }
}
</style>
