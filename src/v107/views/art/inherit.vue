<template>
  <v-table class="v-table-vertical" :cols="thead" :data="tbody">
    <template #art="{row}">
      {{ artTypeMap[row.art] }}
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
import {inheritAscMap} from '@/v107/data/art/inherit';
import artAll from '@/v107/data/art/list';
import {artTypeMap} from '@/v107/data/map';

const thead = [
  {
    key: 'art',
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
    const fromArt = artAll[id];
    const {type, name} = fromArt;
    if (!Reflect.has(obj, type)) {
      obj[type] = {
        id,
        art: type,
        list: [],
      };
    }
    if (Array.isArray(inheritAscMap[id])) {
      for (let key of inheritAscMap[id]) {
        obj[type].list.push(`${name} → ${artAll[key].name}`);
      }
      continue;
    }
    const toArt = artAll[inheritAscMap[id]];
    obj[type].list.push(`${name} → ${toArt.name}`);
  }
  return Object.values(obj);
});
</script>
