<template>
  <div class="v-search">
    <div class="v-search-item">
      <span class="item-label">名称:</span>
      <v-input class="item-value" v-model="params.name"></v-input>
    </div>
    <div class="v-search-item">
      <v-button type="primary" @click="search">查询</v-button>
    </div>
  </div>
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
import {onBeforeMount, ref} from 'vue';
import data from '@/data/other/state';

const thead = ref([
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
]);

const params = ref({
  name: '',
});
const tbody = ref([]);

function search() {
  if (!params.value.name) {
    tbody.value = data.list;
    return;
  }
  tbody.value = data.list.filter((item) => {
    return new RegExp(params.value.name, 'i').test(item.name);
  });
}

onBeforeMount(() => {
  search();
});
</script>

<style lang="less">
.v-table-other-state {
  --height-slide: 130px;

  .td {
    &:nth-child(1) {
      flex: 0 0 100px;
    }
    &:nth-child(3) {
      flex: 0 0 60px;
    }
  }
}
</style>
