<template>
  <div class="v-tabs">
    <div class="tabs">
      <label class="tab" v-for="item of kungfu" :key="item.id">
        <input type="radio" name="cheat" :value="item.id" v-model="active" />
        <span
          :class="{
            [`level-${item.level}`]: item.level,
            [`internal-${item.internal}`]: item.internal === 1 || item.internal === 2,
          }"
        >
          {{ item.name }}
        </span>
      </label>
    </div>
    <kungfu-item :item="info"></kungfu-item>
  </div>
</template>

<script setup>
import {computed, ref, watchEffect} from 'vue';
import {useRoute} from 'vue-router';
import kungfuAll from '@/data/kungfu/list';
import KungfuItem from './item';

const route = useRoute();
const kungfu = ref([]);
const active = ref(-1);
watchEffect(() => {
  kungfu.value = [];
  const {type} = route.meta;
  kungfu.value = Object.values(kungfuAll).filter((item) => item.type === type);
  kungfu.value.sort((a, b) => {
    let aIn = a.internal === '' ? 9 : a.internal;
    let bIn = b.internal === '' ? 9 : b.internal;
    if (a.level === b.level) {
      if (aIn === bIn) {
        return a.sect - b.sect;
      }
      return aIn - bIn;
    }
    return b.level - a.level;
  });
  active.value = kungfu.value[0]?.id ?? -1;
});

const info = computed(() => {
  if (kungfuAll[active.value]) {
    return kungfuAll[active.value];
  }
  return {};
});
</script>
