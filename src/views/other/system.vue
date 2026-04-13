<template>
  <v-table class="v-table-system" :cols="thead" :data="tbody">
    <template #info="{row}">
      <div class="td-block">
        <div class="td-effect-item" v-for="(text, i) of row.info" :key="i">
          {{ text }}
        </div>
      </div>
    </template>
  </v-table>
</template>

<script setup>
import {ref} from 'vue';
import data from '@/data/other/system';

const thead = [
  {
    key: 'name',
    name: '名称',
  },
  {
    key: 'info',
    name: '说明',
  },
];
const tbody = ref(data.list);
</script>

<style lang="less">
.v-table-system {
  .td:first-child {
    flex: 0 0 120px;
  }
}
</style>
