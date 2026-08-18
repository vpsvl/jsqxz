<template>
  <div class="v-search">
    <div class="v-search-item">
      <v-input
        class="item-value"
        placeholder="关键词"
        v-model="params.keyword"
        @keydown.enter="search"
      ></v-input>
    </div>
    <div class="v-search-item">
      <v-button type="primary" @click="search">查询</v-button>
    </div>
  </div>
  <v-tabs :list="art" key-name="id" v-model="active">
    <template #tab="{tab}">
      <span
        :class="{
            [`level-${tab.level}`]: tab.level,
            [`inner-${tab.inner}`]: tab.inner === 1 || tab.inner === 2,
          }"
      >
          {{ tab.name }}
        </span>
    </template>
    <template #title="{info}">
      <span
        :class="[
          `level-${info.level}`,
          {[`inner-${info.inner}`]: info.inner === 1 || info.inner === 2},
        ]"
      >
        {{ info.name }}
      </span>
    </template>
    <art-item v-if="info.id" :item="info" :key="info.id"></art-item>
  </v-tabs>
  <v-loading :loading="state.loading"></v-loading>
</template>
<script setup>
import {computed, ref, inject, onBeforeMount} from 'vue';
import artMap from '@/v107/data/art/list';
import ArtItem from './item';
import VLoading from '@/components/loading';
import {sessionStorage} from '@/utils/storage';
import {formatArt} from '@/v107/data/art/effect/attr';


const state = inject('state');
const artAll = ref([]);
const art = ref([]);
const active = ref(1);

const info = computed(() => {
  if (artMap[active.value]) {
    return artMap[active.value];
  }
  return {};
});

// 初始化武功列表
function init() {
  state.loading = true;
  artAll.value = [];
  for (let id in artMap) {
    artAll.value.push(handleArtInfo(artMap[id]));
  }
  if (artAll.value.length > 0) {
    active.value = artAll.value[0].id;
  }
  art.value = [...artAll.value];
  state.loading = false;
}

function handleArtInfo(info = {}) {
  const cacheKey = `${state.version}_art_${info.id}`;
  const cacheInfo = sessionStorage.get(cacheKey);
  if (cacheInfo) {
    return cacheInfo;
  }
  const item = formatArt(info);
  sessionStorage.set(cacheKey, item, {day: 1});
  return item;
}

const params = ref({
  keyword: '',
});

function search() {
  params.value.keyword = (params.value.keyword + '').replace(/[\[\]{}"', ]/g, '');
  if (params.value.keyword) {
    const reg = new RegExp(params.value.keyword, 'i');
    art.value = artAll.value.filter(item => {
      const keyType = {
        name: 'string',
        sectName: 'string',
        inherit: 'object',
        tra: 'object',
        move: 'object',
        initiative: 'object',
      };
      let itemStr = '';
      for (let key in keyType) {
        itemStr += keyType[key] === 'object' ? JSON.stringify(item[key]) : item[key];
      }
      return reg.test(itemStr);
    });
  } else {
    art.value = [...artAll.value];
  }
  active.value = art.value.length > 0 ? art.value[0].id : -1;
}

onBeforeMount(() => {
  init();
});
</script>
<style lang="less">

</style>