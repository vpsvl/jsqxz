<template>
  <v-table class="v-table-equipment" :cols="thead" :data="tbody">
    <template #effect="{row}">
      <div class="td-block" v-for="(item, index) of row.effect" :key="index">{{ item }}</div>
    </template>
  </v-table>
</template>

<script setup>
import {ref, inject, watchEffect} from 'vue';
import {useRoute} from 'vue-router';

const route = useRoute();
const state = inject('state');

const thead = [
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
  },
  {
    key: 'addition',
    name: '加成',
  },
  {
    key: 'effect',
    name: '特效',
  },
];
const tbody = ref([]);
watchEffect(async () => {
  const {
    name,
    meta: {type},
  } = route;
  if (!/goods/i.test(name)) {
    return;
  }
  try {
    tbody.value = [];
    state.loading = true;
    const data = await import(`../../data/goods/${type}.js`);
    tbody.value = data.default.list;
    state.loading = false;
  } catch (e) {
    tbody.value = [];
    state.loading = false;
  }
});
</script>

<style lang="less">
.v-table-equipment {
  .td:last-child {
    flex-grow: 3;
  }
}
</style>
