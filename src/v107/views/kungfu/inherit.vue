<template>
  <v-table class="v-table-vertical" :cols="thead" :data="tbody">
    <template #kungfu="{row}">
      {{ kungfuTypeMap[row.kungfu] }}
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
import {computed} from 'vue';
import {inheritAscMap} from '@/v107/data/kungfu/inherit';
import kungfuAll from '@/v107/data/kungfu/list';
import {kungfuTypeMap} from '@/v107/data/map';

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
  for (let id in inheritAscMap) {
    const fromKungfu = kungfuAll[id];
    const {type, name} = fromKungfu;
    if (!Reflect.has(obj, type)) {
      obj[type] = {
        id,
        kungfu: type,
        list: [],
      };
    }
    if (Array.isArray(inheritAscMap[id])) {
      for (let key of inheritAscMap[id]) {
        obj[type].list.push(`${name} → ${kungfuAll[key].name}`);
      }
      continue;
    }
    const toKungfu = kungfuAll[inheritAscMap[id]];
    obj[type].list.push(`${name} → ${toKungfu.name}`);
  }
  return Object.values(obj);
});
</script>
