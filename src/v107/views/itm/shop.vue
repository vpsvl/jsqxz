<template>
  <v-table class="v-table-shop" :cols="thead" :data="tbody"></v-table>
</template>

<script setup>
import {inject, ref, watch} from 'vue';
import {useRoute} from 'vue-router';
import shopData from '@/v107/data/itm/shop';
import itmAll from '@/v107/data/itm/list';
import artAll from '@/v107/data/art/list';
import {itmTypeMap} from '@/v107/data/map';

const route = useRoute();
const state = inject('state');

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
    hidden: state.lessWindow,
  },
  {
    key: 'price',
    name: '价格',
  },
  {
    key: 'remark',
    name: '备注',
    hidden: state.lessWindow,
  },
];
const tbody = ref([]);
watch(() => route.name, () => {
  tbody.value = [];
  const {type} = route.meta;
  const data = shopData[type] ? shopData[type] : {list: []};
  tbody.value = data.list.map(item => {
    const {name, art, type, addition, effect} = itmAll[item.id];
    item.name = name;
    switch (type) {
      case 0:
        const artInfo = artAll[art];
        item.intro = `【${itmTypeMap[artInfo.type]}${itmTypeMap[type]}】可修炼${artInfo.name}`;
        break;
      case 11:
      case 12:
      case 13:
        item.intro = `【${itmTypeMap[type]}】${addition}`;
        break;
      case 22:
      case 23:
        item.intro = `【${itmTypeMap[type]}】${effect.join('；')}`;
        break;
      default:
        break;
    }
    return item;
  });
}, {immediate: true});
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
