<template>
  <v-table class="v-table-meridian" :cols="thead" :data="tbody">
    <template #td-list="{row}">
      <div class="td-block" v-for="(item, index) of row.list" :key="index">
        <div v-if="item.name">
          [
          <span class="color-error">{{ item.name }}</span>
          ]:
        </div>
        <div class="td-effect-item">{{ item.attr }}</div>
      </div>
    </template>
  </v-table>
</template>

<script setup>
import {ref} from 'vue';
import meridianData from '@/data/meridian/index';

const thead = [
  {
    key: 'name',
    name: '名称',
  },
  {
    key: 'list',
    name: '属性加成',
  },
];
const tbody = ref(meridianData.list);
</script>

<style lang="less">
.v-table-meridian {
  .td:first-child {
    flex: 0 0 150px;
  }
}
</style>
