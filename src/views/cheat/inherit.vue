<template>
  <v-table class="v-table-vertical" :cols="thead" :data="tbody">
    <template #td-martial="{row}">
      <div class="td-block">
        <div class="td-effect-item" v-for="(item, index) of row.list" :key="index">{{ item }}</div>
      </div>
    </template>
  </v-table>
</template>

<script setup>
import {ref} from 'vue';
import inheritData from '@/data/cheat/inherit';

const thead = [
  {
    key: 'name',
    name: '类别',
  },
  {
    key: 'martial',
    name: '武功',
  },
];
const tbody = ref(inheritData.list);
</script>
