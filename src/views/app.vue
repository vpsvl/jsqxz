<template>
  <div class="app">
    <header-nav></header-nav>
    <router-view class="app-view"></router-view>
    <v-loading :loading="loading"></v-loading>
  </div>
</template>

<script setup>
import {provide, ref} from 'vue';
import HeaderNav from '@/views/layout/header.vue';
import VLoading from '@/components/loading.vue';

const loading = ref(false);
provide('loading', loading);

// function toArr(str) {
//   let arr = str
//     .replace(/ |◎/g, '')
//     .replace(/^\r|\n\r|\n$/g, '')
//     .split('\n');
//   console.log(JSON.stringify(arr));
// }

// toArr(``);
</script>

<style lang="less">
.app {
  height: 100vh;
  background: #f6f5f1;
  .app-view {
    height: calc(100% - var(--header-height) - 10px);
  }
}
</style>
