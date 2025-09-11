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

// import data from '@/data/other/aa';
//
// function toArr() {
//   const arr = [];
//   for (let key in data) {
//     const [name, effect, type, cd, time, shortname] = data[key];
//     arr.push({
//       id: Number(key),
//       name,
//       effect: [effect],
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
// import data from '@/data/kungfu/stunt';
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
//   console.log(list);
// }
// function toPinyin(obj) {
//   try {
//     const rst = {};
//     for (let key in obj) {
//       const item = obj[key];
//       const py = pinyin(item.name, {style: 'normal'}).flat();
//       for (let [index, pinyinItem] of py.entries()) {
//         if (index > 0) {
//           const pyArr = pinyinItem.split('');
//           pyArr[0] = pyArr[0].toUpperCase();
//           py[index] = pyArr.join('');
//         }
//       }
//       rst[py.join('')] = item;
//     }
//     console.log(rst);
//   } catch (e) {
//     console.log(e);
//   }
// }
//
// toPinyin(data);
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
