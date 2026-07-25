<template>
  <div class="v-search">
    <div class="v-search-item">
      <span class="item-label">名称:</span>
      <v-input class="item-value" placeholder="名称/效果" v-model="params.keyword"></v-input>
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
import data from '@/v107/data/other/state';

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
  keyword: '',
});
const tbody = ref([]);

function search() {
  if (!params.value.keyword) {
    tbody.value = data.list;
    return;
  }
  const reg = new RegExp(params.value.keyword, 'i');
  tbody.value = data.list.filter(item => {
    if (reg.test(item.name)) {
      return true;
    }
    for (let text of item.effect) {
      if (reg.test(text)) {
        return true;
      }
    }
    return false;
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
