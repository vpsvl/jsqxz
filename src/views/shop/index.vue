<template>
  <v-table class="v-table-shop" :cols="thead" :data="tbody"></v-table>
</template>

<script setup>
import {ref, watchEffect} from 'vue';
import {useRoute} from 'vue-router';
import shopData from '@/data/shop/index';

const route = useRoute();

const thead = [
  {
    key: 'name',
    name: '名称',
  },
  {
    key: 'intro',
    name: '说明',
  },
  {
    key: 'num',
    name: '数量',
  },
  {
    key: 'price',
    name: '价格',
  },
  {
    key: 'remark',
    name: '备注',
  },
];
const tbody = ref([]);
watchEffect(() => {
   tbody.value = [];
  const {type} = route.meta;
  const data = shopData[type] ? shopData[type] : {list: []};
  tbody.value = data.list;
});
</script>

<style lang="less">
.v-table-shop {
  .td {
    &:nth-child(2) {
      flex: 2 0 0;
    }
  }
}
</style>
