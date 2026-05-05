<template>
  <div class="v-tabs">
    <div class="tabs">
      <label class="tab" v-for="(item, index) of kungfu" :key="index">
        <input type="radio" name="cheat" :value="index" v-model="active" />
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
    <h5 class="tabs-content-title" v-show="info.name">
      <span
        :class="[
          `level-${info.level}`,
          {[`internal-${info.internal}`]: info.internal === 1 || info.internal === 2},
        ]"
      >
        {{ info.name }}
      </span>
    </h5>
    <div class="v-table v-table-vertical">
      <div class="tr">
        <div class="td">秘籍</div>
        <div class="td">
          <span :class="`level-icon level-icon-${info.level}`"></span>
          <span>{{ info.cheat ? info.cheat : info.name }}</span>
        </div>
      </div>
      <div class="tr">
        <div class="td">获取方式</div>
        <div class="td">
          <div
            class="is-block td-effect-item effect-icon-rhombus"
            v-for="(item, index) of info.get"
            :key="index"
          >
            {{ item }}
          </div>
        </div>
      </div>
      <div class="tr">
        <div class="td">所属门派</div>
        <div class="td">
          {{ kungfuSectMap[info.sect] ?? '' }}
        </div>
      </div>
      <div class="tr">
        <div class="td">修炼条件</div>
        <div class="td">
          <span>{{ info.condition }}</span>
        </div>
      </div>
      <div class="tr">
        <div class="td">每级加成</div>
        <div class="td">
          <span>{{ info.addition }}</span>
        </div>
      </div>
      <div class="tr">
        <div class="td">威力</div>
        <div class="td">{{ info.power }}</div>
      </div>
      <div class="tr" v-if="kungfuType === 'out'">
        <div class="td">气功</div>
        <div class="td">{{ info.power }}</div>
      </div>
      <div class="tr" v-if="kungfuType !== 'fly'">
        <div class="td">攻击范围</div>
        <div class="td">{{ info.range }}</div>
      </div>
      <div class="tr" v-if="kungfuType === 'in' || kungfuType === 'fly'">
        <div class="td">主运效果</div>
        <div class="td">
          <div class="td-block" v-for="item of info.initiative" :key="item.id">
            <div v-if="item.name">
              [
              <span :class="`level-${info.level}`">{{ item.name }}</span>
              ]:
            </div>
            <div class="td-effect-item" v-for="(text, i) of item.effect" :key="i">
              {{ text }}
            </div>
          </div>
        </div>
      </div>
      <template v-if="kungfuType === 'out'">
        <div class="tr">
          <div class="td">招式效果</div>
          <div class="td">
            <template v-for="(item, index) of info.attack" :key="index">
              <div class="is-block td-effect-item" v-for="(text, i) of item.effect" :key="i">
                {{ text }}
              </div>
            </template>
            <div class="td-block" v-for="(item, index) of info.attack" :key="index">
              <div>
                [
                <span :class="`level-${info.level}`">第{{ index + 1 }}招</span>
                ]:
              </div>
              <div class="td-effect-item" v-for="(text, i) of item" :key="i">
                {{ text }}
              </div>
            </div>
          </div>
        </div>
      </template>
      <div class="tr">
        <div class="td">一脉相承</div>
        <div class="td">
          <div class="td-block" v-for="item of info.inherit" :key="item.id">
            {{ item.name }}
          </div>
        </div>
      </div>
      <div class="tr">
        <div class="td">其他</div>
        <div class="td">
          <div class="td-block" v-for="item of info.peculiar" :key="item.id">
            <div v-if="item.name">
              [
              <span class="color-error">{{ item.name }}</span>
              ]:
              <span class="color-success">{{ item.condition }}</span>
            </div>
            <div class="td-effect-item" v-for="(text, i) of item.effect" :key="i">
              {{ text }}
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import {computed, ref, watch} from 'vue';
import {useRoute} from 'vue-router';
import fist from '@/data/kungfu/fist';
import finger from '@/data/kungfu/finger';
import sword from '@/data/kungfu/sword';
import knife from '@/data/kungfu/knife';
import special from '@/data/kungfu/special';
import internal from '@/data/kungfu/internal';
import fly from '@/data/kungfu/fly';
import {kungfuSectMap} from '@/data/map/index';
import {getAttr, getCondition, getLearn, getPower, getRange} from '@/data/kungfu/effect/attr';
import * as internalMap from '@/data/kungfu/effect/internal';
import * as outMap from '@/data/kungfu/effect/out';
import stuntMap from '@/data/kungfu/stunt';
import inheritMap from '@/data/kungfu/inherit';

const route = useRoute();
const all = {fist, finger, sword, knife, special, internal, fly};
const kungfuTypeMap = {
  fist: 'out',
  finger: 'out',
  sword: 'out',
  knife: 'out',
  special: 'out',
  internal: 'in',
  fly: 'fly',
};
const kungfu = ref([]);
const kungfuType = ref('in');
const active = ref(-1);
watch(
  () => route,
  () => {
    kungfu.value = [];
    const {type} = route.meta;
    kungfuType.value = kungfuTypeMap[type];
    if (all[type]?.list) {
      kungfu.value = all[type].list;
    }
    active.value = 0;
  },
  {immediate: true},
);

const info = computed(() => handleInfo());

function handleInfo() {
  if (kungfu.value.length < 1) {
    return {};
  }
  const item = JSON.parse(JSON.stringify(kungfu.value[active.value]));
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
    // 所有特效
    const arr = [];
    // 基础特效
    const arrBase = [];
    const typeKey = `${type}Base`;
    if (outMap[typeKey]) {
      const attackItem = outMap[typeKey](level);
      arrBase.push(attackItem.effect);
    }
    if (Array.isArray(attack[0])) {
      const base = attack.shift();
      for (let key of base) {
        const attackItem = outMap[key](level);
        arrBase.push(attackItem.effect);
      }
    }
    for (let key of attack) {
      const item = [...arrBase];
      if (typeof outMap[key] === 'function') {
        const attackItem = outMap[key](level);
        item.push(attackItem.effect);
      }
      arr.push(item);
    }
    // 外功奥义特效
    if (Array.isArray(ultimate)) {
      for (let [index, key] of ultimate.entries()) {
        if (!Array.isArray(arr[index])) {
          arr[index] = [];
        }
        if (typeof outMap[key] === 'function') {
          const ultimateItem = outMap[key](level);
          const {name, effect} = ultimateItem;
          arr[index].push(`${name}(奥义)：${effect}`);
        }
      }
      item.ultimate = arr;
    }
    item.attack = arr;
  }
  return item;
}
</script>
