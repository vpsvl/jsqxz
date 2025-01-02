<template>
  <div class="layout">
    <transition name="fade">
      <div class="menu-mask" @click="closeMenu" v-show="state.lessWindow && state.menuVisible"></div>
    </transition>
    <transition name="fade">
      <v-menu :menu="menus" v-show="state.menuVisible"></v-menu>
    </transition>
    <div class="main">
      <bread-nav :nav="breads"></bread-nav>
      <v-scroll class="main-scroll" view-class="main-scroll-view">
        <router-view></router-view>
      </v-scroll>
    </div>
  </div>
</template>

<script setup>
import {watchEffect, ref, inject} from 'vue';
import {useRoute} from 'vue-router';
import {routes} from '@/router';
import VMenu from './menu.vue';
import BreadNav from './bread-nav.vue';

const route = useRoute();
const state = inject('state');
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

function closeMenu() {
  state.menuVisible = false;
}
</script>

<style lang="less">
.layout {
  position: relative;
  display: flex;

  .main {
    flex: 1;
    background: #fff;
  }

  .main-scroll {
    height: calc(100% - 50px);
    width: 100%;
  }

  .main-scroll-view {
    padding: 0 20px 20px;
  }

  .menu-mask {
    position: absolute;
    top: 0;
    left: 0;
    z-index: 2;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, .2);
  }
}
</style>
