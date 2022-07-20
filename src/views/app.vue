<template>
  <div class="app">
    <header-nav></header-nav>
    <router-view class="app-view"></router-view>
  </div>
</template>

<script setup>
import HeaderNav from '@/views/layout/header.vue';

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
