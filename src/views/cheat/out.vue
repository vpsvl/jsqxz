<template>
  <v-table class="v-table-cheat-out" :cols="thead" :data="tbody">
    <template #td-name="{row}">
      <span :class="{[`level-${row.level}`]: row.level, [`internal-${row.internal}`]: row.internal}">
        {{ row.name }}
      </span>
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
    console.log(tbody.value)
  } catch (e) {
    tbody.value = [];
  }
});
</script>

<style lang="less">
.v-table-cheat-out {
  .td {
    &:nth-child(1) {
      flex: 0 0 120px;
    }
    &:nth-child(2) {
      flex: 0 0 150px;
    }
    &:nth-child(3) {
      flex: 0 0 80px;
    }
    &:nth-child(4) {
      flex: 0 0 80px;
    }
    &:nth-child(5) {
      flex: 0 0 100px;
    }
    &:nth-child(6) {
      flex: 0 0 100px;
    }
    &:nth-child(7) {
      flex: 0 0 130px;
    }
  }
}
</style>
