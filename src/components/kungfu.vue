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
import * as internalMap from '@/data/kungfu/effect/internal';
import * as outMap from '@/data/kungfu/effect/out';
import stuntMap from '@/data/kungfu/stunt';
import inheritMap from '@/data/kungfu/inherit';
import {getAttr, getCondition, getLearn, getPower, getRange} from '@/data/kungfu/effect/attr';
import {useRoute} from 'vue-router';

const props = defineProps({
  list: {
    type: Array,
  },
  exclusive: {
    type: String,
  },
});

const route = useRoute();
const active = ref(0);
const info = computed(() => {
  const item = {...props.list[active.value]};
  const {
    initiative,
    level,
    peculiar,
    inherit,
    attack,
    ultimate,
    addition,
    internal,
    condition,
    power,
    range,
    get: learn,
    sect,
  } = item;
  const {type} = route.meta;
  item.get = getLearn({
    sect,
    level,
    other: learn,
  });
  // 获取属性加成
  item.addition = getAttr({
    type,
    level,
    internal,
    other: addition,
  });
  // 获取学习条件
  item.condition = getCondition({
    type,
    level,
    internal,
    other: condition,
  });
  // 威力
  item.power = getPower({
    type,
    level,
    internal,
    other: power,
  });
  // 攻击范围
  item.range = getRange({
    type,
    level,
    other: range,
  });
  // 内功主运特效
  if (Array.isArray(initiative)) {
    const arr = [];
    for (let key of initiative) {
      if (typeof internalMap[key] === 'function') {
        arr.push(internalMap[key](level));
      }
    }
    item.initiative = arr;
  }
  // 秘技
  if (Array.isArray(peculiar)) {
    const arr = [];
    for (let key of peculiar) {
      if (typeof key === 'string') {
        if (stuntMap[key]) {
          arr.push(stuntMap[key]);
        }
        continue;
      }
      arr.push(key);
    }
    item.peculiar = arr;
  }
  // 一脉相承
  if (Array.isArray(inherit)) {
    const arr = [];
    for (let key of inherit) {
      if (inheritMap[key]) {
        arr.push(inheritMap[key]);
      }
    }
    item.inherit = arr;
  }
  // 外功招式特效
  if (Array.isArray(attack)) {
    const arr = [];
    const typeKey = `${type}Base`;
    if (outMap[typeKey]) {
      arr.push(outMap[typeKey](level));
    }
    for (let key of attack) {
      if (typeof outMap[key] === 'function') {
        arr.push(outMap[key](level));
      }
    }
    item.attack = arr;
  }
  // 外功奥义特效
  if (Array.isArray(ultimate)) {
    const arr = [];
    for (let key of ultimate) {
      if (typeof outMap[key] === 'function') {
        arr.push(outMap[key](level));
      }
    }
    item.ultimate = arr;
  }
  return item;
});
watch(
  () => props.list,
  () => {
    active.value = 0;
  },
  {immediate: true},
);
</script>
