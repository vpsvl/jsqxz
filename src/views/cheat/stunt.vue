<template>
  <v-table class="v-table-cheat-stunt" :cols="thead" :data="tbody">
    <template #effect="{row}">
      <div class="td-block">
        <div class="td-effect-item" v-for="(item, index) of row.effect" :key="index">{{ item }}</div>
      </div>
    </template>
  </v-table>
</template>

<script setup>
import {ref} from 'vue';
import stuntData from '@/data/cheat/stunt';

const thead = [
  {
    key: 'name',
    name: '名称',
  },
  {
    key: 'condition',
    name: '条件',
  },
  {
    key: 'effect',
    name: '效果',
  },
];
const tbody = ref(stuntData.list);
</script>
<style lang="less">
.v-table-cheat-stunt {
  .td {
    &:nth-child(1) {
      flex: 0 0 180px;
    }
    &:nth-child(3) {
      flex-grow: 2;
    }
  }
}
</style>
