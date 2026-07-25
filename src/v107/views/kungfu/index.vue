<template>
  <v-tabs :list="kungfu" key-name="id" v-model="active">
    <template #tab="{tab}">
      <span
        :class="{
            [`level-${tab.level}`]: tab.level,
            [`internal-${tab.internal}`]: tab.internal === 1 || tab.internal === 2,
          }"
      >
          {{ tab.name }}
        </span>
    </template>
    <template #title="{info}">
      <span
        :class="[
          `level-${info.level}`,
          {[`internal-${info.internal}`]: info.internal === 1 || info.internal === 2},
        ]"
      >
        {{ info.name }}
      </span>
    </template>
    <kungfu-item :item="info"></kungfu-item>
  </v-tabs>
</template>

<script setup>
import {computed, ref, watch} from 'vue';
import {useRoute} from 'vue-router';
import kungfuAll from '@/v107/data/kungfu/list';
import KungfuItem from './item';

const route = useRoute();
const kungfu = ref([]);
const active = ref(-1);
watch(() => route.name, () => {
  kungfu.value = [];
  const {type} = route.meta;
  kungfu.value = Object.values(kungfuAll).filter(item => item.type === type);
  kungfu.value.sort((a, b) => {
    let aIn = a.internal ? a.internal : 9;
    let bIn = b.internal ? b.internal : 9;
    if (a.level === b.level) {
      if (aIn === bIn) {
        return a.sect - b.sect;
      }
      return aIn - bIn;
    }
    return b.level - a.level;
  });
  active.value = kungfu.value[0]?.id ?? -1;
}, {immediate: true});

const info = computed(() => {
  if (kungfuAll[active.value]) {
    return kungfuAll[active.value];
  }
  return {};
});
</script>
