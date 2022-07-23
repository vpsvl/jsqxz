<template>
  <v-table class="v-table-cheat-out" :cols="thead" :data="tbody">
    <template #td-name="{row}">
      <span :class="{[`level-${row.level}`]: row.level, [`internal-${row.internal}`]: row.internal}">
        {{ row.name }}
      </span>
    </template>
    <template #td-condition="{row}">
      <p>{{row.condition}} {{internalTypeMap[parseInt(row.internal)]}}</p>
    </template>
    <template #td-peculiar="{row}">
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
import {ref, watchEffect} from 'vue';
import {useRoute} from 'vue-router';
import {internalTypeMap} from '@/data/map/index'

const route = useRoute();

const thead = [
  {
    key: 'name',
    name: '名称',
  },
  {
    key: 'get',
    name: '获取',
  },
  {
    key: 'power',
    name: '威力',
  },
  {
    key: 'gasPower',
    name: '气功',
  },
  {
    key: 'range',
    name: '范围',
  },
  {
    key: 'condition',
    name: '条件',
  },
  {
    key: 'addition',
    name: '每级加成',
  },
  {
    key: 'peculiar',
    name: '特性',
  },
];
const tbody = ref([]);
watchEffect(async () => {
  const {
    name,
    meta: {type},
  } = route;
  if (!/cheat/i.test(name)) {
    return;
  }
  try {
    const data = await import(`../../data/cheat/${type}.js`);
    tbody.value = data.default.list;
  } catch (e) {
    tbody.value = [];
  }
});
</script>

<style lang="less">
.v-table-cheat-out {
  .td {
    &:nth-child(3),
    &:nth-child(4) {
      flex: 0.3 0 0;
    }
    &:nth-child(5) {
      flex: 0.5 0 0;
    }
    &:nth-child(8) {
      flex: 2 0 0;
    }
  }
}
</style>
