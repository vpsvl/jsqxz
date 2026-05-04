<template>
  <div class="v-tabs">
    <div class="tabs-exclusive" v-if="!!exclusive">
      {{ exclusive }}
    </div>
    <div class="tabs">
      <label class="tab" v-for="(item, index) of list" :key="index">
        <input type="radio" name="cheat" :value="index" v-model="active" />
        <slot name="tab" :tab="item">
          <span>{{ item.name }}</span>
        </slot>
      </label>
    </div>
    <h5 class="tabs-content-title" v-if="info.name">
      <slot name="title" :info="info">
        <span>{{ info.name }}</span>
      </slot>
    </h5>
    <slot :info="info"></slot>
  </div>
</template>

<script setup>
import {computed, ref, watch} from 'vue';

const props = defineProps({
  list: {
    type: Array,
  },
  exclusive: {
    type: String,
  },
  type: {
    type: String,
    default: '',
  },
});

const active = ref(0);
const info = computed(() => {
  return {...props.list[active.value]};
});
watch(
  () => props.list,
  () => {
    active.value = 0;
  },
  {immediate: true},
);
</script>
