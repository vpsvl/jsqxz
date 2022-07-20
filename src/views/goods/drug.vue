<template>
  <v-table class="v-table-drug" :cols="thead" :data="tbody"></v-table>
</template>

<script setup>
import {ref} from 'vue';
import drugData from '@/data/goods/drug';

const thead = [
  {
    key: 'name',
    name: '名称',
  },
  {
    key: 'effect',
    name: '效果',
  },
  {
    key: 'get',
    name: '获取',
  },
];
const tbody = ref(drugData.list);
</script>

<style lang="less">
.v-table-drug {
  .td:last-child {
    flex-grow: 2;
  }
}
</style>
