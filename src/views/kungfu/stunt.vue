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
  <v-table class="v-table-kungfu-stunt" :cols="thead" :data="tbody">
    <template #effect="{row}">
      <div class="td-block">
        <div class="td-effect-item" v-for="(item, index) of row.effect" :key="index">
          {{ item }}
        </div>
      </div>
    </template>
  </v-table>
</template>

<script setup>
import {ref, onBeforeMount} from 'vue';
import stuntData from '@/data/kungfu/stunt';

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
const params = ref({
  name: '',
});
const tbody = ref([]);

function search() {
  tbody.value = [];
  for (let key in stuntData) {
    const {name, type} = stuntData[key];
    if (type === 1 && new RegExp(params.value.name, 'i').test(name)) {
      tbody.value.push(stuntData[key]);
    }
  }
}

onBeforeMount(() => {
  search();
});
</script>
<style lang="less">
.v-table-kungfu-stunt {
  --height-slide: 130px;

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
