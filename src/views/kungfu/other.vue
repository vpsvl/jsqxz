<template>
  <v-table class="v-table-kungfu-other" :cols="thead" :data="tbody">
    <template #effect="{row}">
      <div class="td-block" v-for="(item, index) of row.peculiar" :key="index">
        <div v-if="item.name">
          [
          <span class="color-error">{{ item.name }}</span>
          ]:
          <span class="color-success">{{ item.condition }}</span>
        </div>
        <div class="td-effect-item" v-for="(text, i) of item.effect" :key="i">{{ text }}</div>
      </div>
    </template>
  </v-table>
</template>

<script setup>
import {ref} from 'vue';
import otherData from '@/data/kungfu/other';

const thead = [
  {
    key: 'name',
    name: '名称',
  },
  {
    key: 'get',
    name: '获取',
  },
  {
    key: 'condition',
    name: '条件',
  },
  {
    key: 'addition',
    name: '加成',
  },
  {
    key: 'effect',
    name: '效果',
  },
];
const tbody = ref(otherData.list);
</script>

<style lang="less">
.v-table-kungfu-other {
  .td:last-child {
    flex-grow: 3;
  }
}
</style>
