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

// import data from '@/data/kungfu/fly';
// import {sectMap} from '@/data/map';

// function toArr() {
//   const arr = data.list;
//   arr.sort((a, b) => b.level - a.level);
//   arr.sort((a, b) => {
//     if (a.level === b.level) {
//       const aitem = a.power.replace(/命中(\d+) 闪避(\d+) /, '$1,$2');
//       const bitem = b.power.replace(/命中(\d+) 闪避(\d+) /, '$1,$2');
//       const [ahp, aqf] = aitem.split(',');
//       const [bhp, bqf] = bitem.split(',');
//       return ahp === bhp ? bqf - aqf : bhp - ahp;
//     }
//     return 1;
//   });
//   console.log(arr);
// }

// toArr();

// import data from '@/data/kungfu/internal';
//
// function toArr() {
//   const arr = data.list;
//   arr.sort((a, b) => b.level - a.level);
//   arr.sort((a, b) => {
//     let aIn = a.internal === '' ? 2 : a.internal;
//     let bIn = b.internal === '' ? 2 : b.internal;
//     if (a.level === b.level) {
//       if (aIn === bIn) {
//         return a.sect - b.sect;
//       }
//       return aIn - bIn;
//     }
//     return 1;
//   });
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

// import fist from '@/data/kungfu/fist';
// import finger from '@/data/kungfu/finger';
// import sword from '@/data/kungfu/sword';
// import knife from '@/data/kungfu/knife';
// import special from '@/data/kungfu/special';
// import internal from '@/data/kungfu/internal';
// import fly from '@/data/kungfu/fly';
// import kungfu from '@/data/map/kungfu';
//
// const all = [
//   ...fist.list,
//   ...finger.list,
//   ...sword.list,
//   ...knife.list,
//   ...special.list,
//   ...internal.list,
//   ...fly.list,
// ];
//
// function toArr() {
//   for (let item of all) {
//     const {id, level, internal} = item;
//     if (kungfu[id]) {
//       kungfu[id].level = level;
//       kungfu[id].internal = internal;
//     }
//   }
//   console.log(kungfu);
// }
//
// toArr();
</script>

<style lang="less">
.app {
  min-width: 400px;
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
