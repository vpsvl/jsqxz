<template>
  <v-table class="v-table-keymap" :cols="thead" :data="tbody">
    <template #keys="{row}">
      <div class="td-block">
        <p v-for="(name, val) of row.keys" :key="val">
          <span class="keymap-key">{{ val }}：</span>
          <span class="color-success">{{ name }}</span>
        </p>
      </div>
    </template>
  </v-table>
</template>

<script setup>
import {ref} from 'vue';
import data from '@/data/keymap/index';

const thead = [
  {
    key: 'name',
    name: '场景',
  },
  {
    key: 'keys',
    name: '快捷键',
  },
];
const tbody = ref(data.list);
</script>

<style lang="less">
.v-table-keymap {
  .td:first-child {
    flex: 0 0 150px;
  }

  .keymap-key {
    display: inline-block;
    width: 60px;
    text-align: right;
    color: var(--color-error);
  }
}
</style>
