<template>
  <v-table class="v-table-person" :cols="thead" :data="tbody">
    <template #td-talent="{row}">
      <div class="td-block" v-for="(item, index) of row.talent" :key="index">
        <div>
          [
          <span class="color-error">{{ item.name }}</span>
          ]:
        </div>
        <div class="td-effect-item effect-icon-star" v-for="(text, i) of item.effect" :key="i">{{ text }}</div>
      </div>
    </template>
    <template #td-fortune="{row}">
      <div class="td-block">
        <div class="td-effect-item effect-icon-heart" v-for="(text, i) of row.fortune" :key="i">{{ text }}</div>
      </div>
    </template>
  </v-table>
</template>

<script setup>
import {ref, watchEffect, inject} from 'vue';
import {useRoute} from 'vue-router';

const route = useRoute();
const loading = inject('loading');

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
    loading.value = true;
    const data = await import(`../../data/person/${type}.js`);
    tbody.value = data.default.list;
    loading.value = false;
  } catch (e) {
    tbody.value = [];
    loading.value = false;
  }
});
</script>
<style lang="less">
.v-table-person {
  .td {
    &:nth-child(1) {
      flex: 0 0 120px;
    }
    &:nth-child(2) {
      flex: 3 0 0;
    }
  }
}
</style>
