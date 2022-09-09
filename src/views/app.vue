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
// import pinyin from 'pinyin';
// import data from '@/data/person/yuan';

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

// function toPinyin(arr) {
//   const list = arr.map((item) => {
//     const py = pinyin(item.name, {style: 'normal'}).flat();
//     for (let [index, pinyinItem] of py.entries()) {
//       if (index > 0) {
//         const pyArr = pinyinItem.split('');
//         pyArr[0] = pyArr[0].toUpperCase();
//         py[index] = pyArr.join('');
//       }
//     }
//     let itemStr = JSON.stringify(item);
//     itemStr = itemStr.replace(/^\{/, `{"id":"${py.join('')}",`);
//     return JSON.parse(itemStr);
//   });
//   console.log(JSON.stringify(list));
// }
// toPinyin(data.list);
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
