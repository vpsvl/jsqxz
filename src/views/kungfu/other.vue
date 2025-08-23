<template>
  <v-table class="v-table-kungfu-other" :cols="thead" :data="tbody">
    <template #effect="{row}">
      <div class="td-block" v-for="(item, index) of row.peculiar" :key="index">
        <div v-if="item.name">
          [
          <span class="color-error">{{ item.name }}</span>
          ]:
          <span class="color-success">{{ item.condition }}</span>
        </div>
        <div class="td-effect-item" v-for="(text, i) of item.effect" :key="i">{{ text }}</div>
      </div>
    </template>
  </v-table>
</template>

<script setup>
import {ref, inject, onBeforeMount} from 'vue';
import otherData from '@/data/kungfu/other';
import stuntMap from '@/data/kungfu/stunt';

const state = inject('state');
const thead = ref([
  {
    key: 'name',
    name: '名称',
  },
  {
    key: 'get',
    name: '获取',
  },
  {
    key: 'condition',
    name: '条件',
    hidden: state.lessWindow,
  },
  {
    key: 'addition',
    name: '加成',
    hidden: state.lessWindow,
  },
  {
    key: 'effect',
    name: '效果',
  },
]);

const params = ref({
  name: '',
});
const tbody = ref([]);

function search() {
  tbody.value = otherData.list.filter((item) => {
    const peculiarArr = [];
    for (let key of item.peculiar) {
      if (typeof key === 'string') {
        if (stuntMap[key]) {
          peculiarArr.push(stuntMap[key]);
        }
        continue;
      }
      peculiarArr.push(key);
    }
    item.peculiar = peculiarArr;
    return new RegExp(params.value.name, 'i').test(item.name);
  });
}

onBeforeMount(() => {
  search();
});
</script>

<style lang="less">
.v-table-kungfu-other {
  .td:last-child {
    flex-grow: 3;
  }
}
</style>
