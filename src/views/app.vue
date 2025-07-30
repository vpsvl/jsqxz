<template>
  <div class="app">
    <header-nav></header-nav>
    <router-view class="app-view"></router-view>
    <v-loading :loading="state.loading"></v-loading>
  </div>
</template>

<script setup>
import {onMounted, provide, reactive, ref, watch} from 'vue';
import HeaderNav from '@/views/layout/header.vue';
import VLoading from '@/components/loading.vue';
import {useRoute} from 'vue-router';

const route = useRoute();
const state = reactive({
  loading: false,
  menuVisible: true,
  lessWindow: false,
});

onMounted(() => {
  const media = window.matchMedia('screen and (max-width: 600px)');
  state.lessWindow = media.matches;
  state.menuVisible = !media.matches;
  media.onchange = (e) => {
    state.lessWindow = e.matches;
    state.menuVisible = !e.matches;
  };
});

watch(
  () => route.name,
  (val) => {
    if (state.lessWindow) {
      state.menuVisible = false;
    }
  },
);

provide('state', state);

// import data from '@/data/person/talent/aa';

// function toArr() {
//   const arr = [];
//
//   for (let key in data) {
//     //--1名称，2说明，3增为1减益为2 ，4 5 效果或持续时间说明
//     const [name, effect, type, cd, time, shortname] = data[key];
//     arr.push({
//       id: Number(key),
//       name,
//       effect,
//       type,
//       cd,
//       time,
//       shortname,
//     });
//   }
//   console.log(arr);
// }
//
// toArr();

// import pinyin from 'pinyin';
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
  min-width: 450px;
  height: 100vh;
  background: #f6f5f1;

  .app-view {
    height: calc(100% - var(--header-height) - 10px);
  }
}

@media screen and (max-width: 600px) {
  .app {
    .menu {
      position: absolute;
    }
  }
}
</style>
