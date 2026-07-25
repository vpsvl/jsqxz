<template>
  <div class="v-search">
    <div class="v-search-item">
      <span class="item-label">名称:</span>
      <v-input class="item-value" placeholder="关键词" v-model="params.keyword"></v-input>
    </div>
    <div class="v-search-item">
      <v-button type="primary" @click="search">查询</v-button>
    </div>
  </div>
  <v-tabs :list="kungfu" key-name="id" v-model="active">
    <template #tab="{tab}">
      <span
        :class="{
            [`level-${tab.level}`]: tab.level,
            [`internal-${tab.internal}`]: tab.internal === 1 || tab.internal === 2,
          }"
      >
          {{ tab.name }}
        </span>
    </template>
    <template #title="{info}">
      <span
        :class="[
          `level-${info.level}`,
          {[`internal-${info.internal}`]: info.internal === 1 || info.internal === 2},
        ]"
      >
        {{ info.name }}
      </span>
    </template>
    <kungfu-item v-if="info.id" :item="info"></kungfu-item>
  </v-tabs>
  <v-loading :loading="state.loading"></v-loading>
</template>
<script setup>
import {computed, ref, inject, onBeforeMount} from 'vue';
import kungfuMap from '@/v107/data/kungfu/list';
import KungfuItem from './item';
import VLoading from '@/components/loading';
import {sessionStorage} from '@/utils/storage';
import {formatKungfu} from '@/v107/data/kungfu/effect/attr';


const state = inject('state');
const kungfuAll = ref([]);
const kungfu = ref([]);
const active = ref(1);

const info = computed(() => {
  if (kungfuMap[active.value]) {
    return kungfuMap[active.value];
  }
  return {};
});

// 初始化武功列表
function init() {
  state.loading = true;
  kungfuAll.value = [];
  for (let id in kungfuMap) {
    kungfuAll.value.push(handleKungfuInfo(kungfuMap[id]));
  }
  if (kungfuAll.value.length > 0) {
    active.value = kungfuAll.value[0].id;
  }
  kungfu.value = [...kungfuAll.value];
  state.loading = false;
}

function handleKungfuInfo(info = {}) {
  const cacheKey = `${state.version}_kungfu_${info.id}`;
  const cacheInfo = sessionStorage.get(cacheKey);
  if (cacheInfo) {
    return cacheInfo;
  }
  const item = formatKungfu(info);
  sessionStorage.set(cacheKey, item);
  return item;
}

const params = ref({
  keyword: '',
});

function search() {
  params.value.keyword = (params.value.keyword + '').replace(/[\[\]{}"', ]/g, '');
  if (params.value.keyword) {
    const reg = new RegExp(params.value.keyword, 'i');
    kungfu.value = kungfuAll.value.filter(item => {
      const keyType = {
        name: 'string',
        sectName: 'string',
        inherit: 'object',
        peculiar: 'object',
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
    kungfu.value = [...kungfuAll.value];
  }
  active.value = kungfu.value.length > 0 ? kungfu.value[0].id : -1;
}

onBeforeMount(() => {
  init();
});
</script>
<style lang="less">

</style>