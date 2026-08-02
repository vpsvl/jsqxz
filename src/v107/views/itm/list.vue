<template>
  <div class="v-search">
    <div class="v-search-item">
      <v-input class="item-value" placeholder="名称/效果" v-model="params.keyword"></v-input>
    </div>
    <div class="v-search-item">
      <v-button type="primary" @click="search">查询</v-button>
    </div>
  </div>
  <v-table class="v-table-itm" :cols="thead" :data="tbody">
    <template #get="{row}">
      <div class="td-block">
        <div
          class="td-effect-item effect-icon-rhombus"
          v-for="(item, index) of row.get"
          :key="index"
        >
          {{ item }}
        </div>
      </div>
    </template>
    <template #effect="{row}">
      <div class="td-block">
        <div class="td-effect-item" v-if="state.lessWindow">
          {{ row.addition }}
        </div>
        <div
          class="td-effect-item"
          v-for="(item, index) of row.effect"
          :key="index"
        >
          {{ item }}
        </div>
      </div>
    </template>
  </v-table>
</template>

<script setup>
import {ref, inject, watch} from 'vue';
import {useRoute} from 'vue-router';
import itmAll from '@/v107/data/itm/list';

const route = useRoute();
const state = inject('state');

const theadEqp = [
  {
    key: 'name',
    name: '名称',
  },
  {
    key: 'get',
    name: '获取方式',
  },
  {
    key: 'condition',
    name: '装备需求',
    hidden: state.lessWindow,
  },
  {
    key: 'addition',
    name: '加成',
    hidden: state.lessWindow,
  },
  {
    key: 'effect',
    name: '特效',
  },
];
const theadDrug = [
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
const eqpMap = {
  11: true,
  12: true,
  13: true,
};
const params = ref({
  keyword: '',
});
const thead = ref([]);
const tbody = ref([]);
const all = ref([]);
watch(() => route.name, () => {
  const {
    name,
    meta: {type},
  } = route;
  if (!/itm/i.test(name)) {
    return;
  }
  try {
    const isEqp = eqpMap[type];
    thead.value = isEqp ? theadEqp : theadDrug;
    all.value = [];
    for (let id in itmAll) {
      const item = itmAll[id];
      if (item.type === type && (!isEqp || Array.isArray(item.get) && item.get.length > 0)) {
        all.value.push(item);
      }
    }
  } catch (e) {
    all.value = [];
    state.loading = false;
  }
  params.value = {
    keyword: '',
  };
  search();
}, {immediate: true});

function search() {
  if (!params.value.keyword) {
    tbody.value = [...all.value];
    return;
  }
  tbody.value = all.value.filter(item => {
    const reg = new RegExp(params.value.keyword, 'i');
    if (reg.test(item.name)) {
      return true;
    }
    const effectStr = JSON.stringify(item.effect);
    return reg.test(effectStr);
  });
}
</script>

<style lang="less">
.v-table-itm {
  --height-slide: 130px;

  .td:last-child {
    flex-grow: 3;
  }
}
</style>
