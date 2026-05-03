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
import {getAttr, getCondition, getPower, getRange} from '@/data/kungfu/effect/attr';
import {useRoute} from 'vue-router';

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

const route = useRoute();
const active = ref(0);
const info = computed(() => {
  const item = {...props.list[active.value]};
  if (props.type === 'kungfu') {
    const {
      initiative,
      level,
      peculiar,
      inherit,
      attack,
      addition,
      internal,
      condition,
      power,
      range,
    } = item;
    const {type} = route.meta;
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
      const initiativeArr = [];
      for (let key of initiative) {
        if (typeof internalMap[key] === 'function') {
          initiativeArr.push(internalMap[key](level));
        }
      }
      item.initiative = initiativeArr;
    }
    // 秘技
    if (Array.isArray(peculiar)) {
      const peculiarArr = [];
      for (let key of peculiar) {
        if (typeof key === 'string') {
          if (stuntMap[key]) {
            peculiarArr.push(stuntMap[key]);
          }
          continue;
        }
        peculiarArr.push(key);
      }
      item.peculiar = peculiarArr;
    }
    // 一脉相承
    if (Array.isArray(inherit)) {
      const inheritArr = [];
      for (let key of inherit) {
        if (inheritMap[key]) {
          inheritArr.push(inheritMap[key]);
        }
      }
      item.inherit = inheritArr;
    }
    // 外功攻击特效
    if (Array.isArray(attack)) {
      const attackArr = [];
      // for (let key of attack) {
      //   if (outMap[key]) {
      //     attackArr.push(outMap[key].name);
      //   }
      // }
      item.attack = attackArr;
    }
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

<style lang="less">
.v-tabs {
  .tabs-exclusive {
    padding: 10px 0;
    color: var(--color-content);
  }

  .tabs {
    position: relative;
    display: flex;
    flex-wrap: wrap;
    margin-bottom: 10px;
    background: var(--color-bg);
  }

  .tab {
    width: 100px;
    height: 25px;
    cursor: pointer;

    input[type='radio'] {
      display: none;

      &:checked ~ span {
        background: var(--color-success-lighter);
      }
    }

    span {
      display: block;
      width: 100%;
      height: 100%;
      line-height: 24px;
      text-align: center;
      transition: background 0.2s;

      &:hover {
        opacity: 0.6;
      }
    }
  }

  .tabs-content-title {
    padding: 10px;
    font-weight: normal;

    span {
      display: inline-block;
      padding: 2px 5px;
      font-size: 18px;
    }
  }

  .tabs-content-subtitle {
    padding: 0 20px 10px;
    color: var(--color-info);
  }
}
</style>
