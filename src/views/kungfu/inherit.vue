<template>
  <v-table class="v-table-vertical" :cols="thead" :data="tbody">
    <template #kungfu="{row}">
      {{ kungfuMap[row.kungfu] }}
    </template>
    <template #list="{row}">
      <div class="td-block">
        <div class="td-effect-item" v-for="(item, index) of row.list" :key="index">
          {{ item }}
        </div>
      </div>
    </template>
  </v-table>
</template>

<script setup>
import {computed, ref} from 'vue';
import inheritData from '@/data/kungfu/inherit';
import {kungfuMap} from '@/data/map';

const thead = [
  {
    key: 'kungfu',
    name: '类别',
  },
  {
    key: 'list',
    name: '武功',
  },
];
const tbody = computed(() => {
  const obj = {};
  for (let key in inheritData) {
    const {name, kungfu} = inheritData[key];
    if (!Reflect.has(obj, kungfu)) {
      obj[kungfu] = {
        id: kungfu,
        kungfu,
        list: [],
      };
    }
    obj[kungfu].list.push(name);
  }
  return Object.values(obj);
});
</script>
