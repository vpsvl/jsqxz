<template>
  <v-table class="v-table-other-state" :cols="thead" :data="tbody">
    <template #effect="{row}">
      <div class="td-block">
        <div class="td-effect-item effect-icon-rhombus" v-for="(text, i) of row.effect" :key="i">
          {{ text }}
        </div>
      </div>
    </template>
    <template #type="{row}">
      {{ row.type === 1 ? '增益' : '减益' }}
    </template>
  </v-table>
</template>

<script setup>
import {computed, inject, ref} from 'vue';
import data from '@/data/other/state';

const state = inject('state');
const defaultCols = [
  {
    key: 'name',
    name: '名称',
  },
  {
    key: 'effect',
    name: '效果',
  },
  {
    key: 'type',
    name: '类型',
  },
];
const thead = computed(() => {
  if (state.lessWindow) {
    return [...defaultCols];
  }
  return [
    ...defaultCols,
    {
      key: 'shortname',
      name: '显示名称',
    },
  ];
});
const tbody = ref(data.list);
</script>

<style lang="less">
.v-table-other-state {
  .td {
    &:nth-child(1) {
      flex: 0 0 130px;
    }

    &:nth-child(3) {
      flex: 0 0 80px;
    }

    &:nth-child(4) {
      flex: 0 0 120px;
    }
  }
}
</style>
