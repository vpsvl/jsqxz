<template>
  <v-tabs :list="art" key-name="id" v-model="active">
    <template #tab="{tab}">
      <span
        :class="{
            [`level-${tab.level}`]: tab.level,
            [`inner-${tab.inner}`]: tab.inner === 1 || tab.inner === 2,
          }"
      >
          {{ tab.name }}
        </span>
    </template>
    <template #title="{info}">
      <span
        :class="[
          `level-${info.level}`,
          {[`inner-${info.inner}`]: info.inner === 1 || info.inner === 2},
        ]"
      >
        {{ info.name }}
      </span>
    </template>
    <art-item :item="info" :key="info.id"></art-item>
  </v-tabs>
</template>

<script setup>
import {computed, ref, watch} from 'vue';
import {useRoute} from 'vue-router';
import artAll from '@/v107/data/art/list';
import ArtItem from './item';

const route = useRoute();
const art = ref([]);
const active = ref(-1);
watch(() => route.name, () => {
  art.value = [];
  const {type} = route.meta;
  art.value = Object.values(artAll).filter(item => item.type === type);
  art.value.sort((a, b) => {
    let aIn = a.inner ? a.inner : 9;
    let bIn = b.inner ? b.inner : 9;
    if (a.level === b.level) {
      if (aIn === bIn) {
        return a.sect - b.sect;
      }
      return aIn - bIn;
    }
    return b.level - a.level;
  });
  active.value = art.value[0]?.id ?? -1;
}, {immediate: true});

const info = computed(() => {
  if (artAll[active.value]) {
    return artAll[active.value];
  }
  return {};
});
</script>
