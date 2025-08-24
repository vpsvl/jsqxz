<template>
  <v-table class="v-table-person" :cols="thead" :data="tbody">
    <template #talent="{row}">
      <div class="td-block" v-for="(item, index) of row.talent" :key="index">
        <div>
          [
          <span :class="`level-${item.level}`">{{ item.name }}</span>
          ]:
        </div>
        <div class="td-effect-item effect-icon-star" v-for="(text, i) of item.effect" :key="i">
          {{ text }}
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
import {ref, watchEffect, inject} from 'vue';
import {useRoute} from 'vue-router';
import talentMap from '@/data/person/talent';

const route = useRoute();
const state = inject('state');

const thead = [
  {
    key: 'name',
    name: '名称',
  },
  {
    key: 'talent',
    name: '天赋',
  },
  {
    key: 'fortune',
    name: '福缘际遇',
  },
];
const tbody = ref([]);
watchEffect(async () => {
  const {
    name,
    meta: {type},
  } = route;
  if (!/person/i.test(name)) {
    return;
  }
  try {
    tbody.value = [];
    state.loading = true;
    const data = await import(`../../data/person/${type}.js`);
    tbody.value = data.default.list.map(item => {
      const talentArr = [];
      const fortuneArr = [];
      for (let key of item.talent) {
        const {id, name, effect, level, fortune} = talentMap[key];
        talentArr.push({id, name, effect, level});
        fortuneArr.push(...fortune);
      }
      item.talent = talentArr;
      item.fortune = fortuneArr;
      return item;
    });
    state.loading = false;
  } catch (e) {
    tbody.value = [];
    state.loading = false;
  }
});
</script>
<style lang="less">
.v-table-person {
  .td {
    &:nth-child(1) {
      flex: 0 0 100px;
    }

    &:nth-child(2) {
      flex: 2 0 0;
    }
  }
}
</style>
