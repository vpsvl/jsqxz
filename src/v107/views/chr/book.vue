<template>
  <v-table class="v-table-chr" :cols="thead" :data="tbody">
    <template #talent="{row}">
      <div class="td-block" v-for="(item, index) of row.talent" :key="index">
        <div>
          [
          <span :class="`level-${item.level}`">
            {{ item.name }}
          </span>
          ]:
          <span class="color-error" v-if="row.id === item.id">（血脉）</span>
        </div>
        <div class="td-effect-item effect-icon-star" v-for="(text, i) of item.effect" :key="i">
          {{ text }}
        </div>
      </div>
      <div class="td-block" v-if="state.lessWindow && row.fortune.length > 0">
        <div class="color-error">[福缘际遇]</div>
        <div class="td-effect-item effect-icon-rhombus" v-for="(text, i) of row.fortune" :key="i">
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
import {ref, watch, inject, computed} from 'vue';
import {useRoute} from 'vue-router';
import talentMap from '@/v107/data/chr/talent';
import chrAll from '@/v107/data/chr';
import {sessionStorage} from '@/utils/storage';

const route = useRoute();
const state = inject('state');

const allData = computed(() => Object.values(chrAll));
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
    hidden: state.lessWindow,
  },
];
const tbody = ref([]);
watch(() => route.name, () => {
  const {
    name,
    meta: {type},
  } = route;
  if (!/chr/i.test(name)) {
    return;
  }
  const cacheKey = `${state.version}_chr_${type}`;
  const cacheInfo = sessionStorage.get(cacheKey);
  if (cacheInfo) {
    tbody.value = cacheInfo;
    return;
  }
  try {
    state.loading = true;
    tbody.value = [];
    for (let chr of allData.value) {
      const item = JSON.parse(JSON.stringify(chr));
      if (item.type !== type) {
        continue;
      }
      const talentArr = [];
      const fortuneArr = [];
      for (let key of item.talent) {
        const {id, name, effect, level, fortune} = talentMap[key];
        talentArr.push({
          id,
          name,
          effect: effect.filter(i => import.meta.env.DEV || !/#hidden#$/.test(i)),
          level,
        });
        fortuneArr.push(...fortune);
      }
      item.talent = talentArr;
      item.fortune = fortuneArr;
      tbody.value.push(item);
    }
    sessionStorage.set(cacheKey, tbody.value, {day: 1});
    state.loading = false;
  } catch (e) {
    tbody.value = [];
    state.loading = false;
  }
}, {immediate: true});
</script>
<style lang="less">
.v-table-chr {
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
