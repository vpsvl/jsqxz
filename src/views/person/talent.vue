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
    <template #fortune="{row}">
      <div class="td-block">
        <div class="td-effect-item effect-icon-rhombus" v-for="(text, i) of row.fortune" :key="i">
          {{ text }}
        </div>
      </div>
    </template>
  </v-table>
</template>

<script setup>
import {ref, onBeforeMount} from 'vue';
import data from '@/data/person/talent';

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
    key: 'fortune',
    name: '福缘际遇',
  },
];
const params = ref({
  name: '',
});
const talentList = Object.values(data);
const tbody = ref([]);

function search() {
  if (!params.value.name) {
    tbody.value = talentList;
    return;
  }
  tbody.value = talentList.filter((item) => {
    return new RegExp(params.value.name, 'i').test(item.name);
  });
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
      flex: 0 0 120px;
    }
  }
}
</style>
