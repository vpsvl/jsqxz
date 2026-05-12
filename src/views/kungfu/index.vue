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
          {{ sectMap[info.sect]?.name ?? '' }}
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
            <template v-for="(item, index) of info.move" :key="index">
              <div class="is-block td-effect-item" v-for="(text, i) of item.effect" :key="i">
                {{ text }}
              </div>
            </template>
            <div class="td-block" v-for="(item, index) of info.move" :key="index">
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
import {computed, ref, watchEffect} from 'vue';
import {useRoute} from 'vue-router';
import kungfuAll from '@/data/kungfu/list';
import sectMap from '@/data/person/sect';
import {getAttr, getCondition, getLearn, getPower, getRange} from '@/data/kungfu/effect/attr';
import * as internalMap from '@/data/kungfu/effect/internal';
import * as outMap from '@/data/kungfu/effect/out';
import stuntMap from '@/data/kungfu/stunt';
import inheritMap from '@/data/kungfu/inherit';

const route = useRoute();
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
watchEffect(() => {
  kungfu.value = [];
  const {type} = route.meta;
  kungfuType.value = kungfuTypeMap[type];
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
  if (kungfu.value.length < 1) {
    return {};
  }
  const current = kungfu.value.find((item) => item.id === active.value);
  return handleKungfuInfo(current);
});

function handleKungfuInfo(info = {}) {
  const item = JSON.parse(JSON.stringify(info));
  const {
    level,
    sect,
    internal,
    initiative,
    peculiar,
    inherit,
    move,
    moveNum,
    ultimate,
    addition,
    condition,
    power,
    range,
    get: learn,
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
  if (moveNum > 1) {
    // 所有特效
    const arr = [];
    // 基础特效
    const arrBase = [];
    const typeKey = `${type}Base`;
    if (outMap[typeKey]) {
      const moveItem = outMap[typeKey](level);
      arrBase.push(moveItem.effect);
    }
    if (move && Array.isArray(move[0])) {
      const base = move.shift();
      for (let key of base) {
        const moveItem = outMap[key](level);
        arrBase.push(moveItem.effect);
      }
    }
    let moveList = [];
    // 有配招式就使用配置的
    if (move && move.length > 0) {
      moveList = move;
    } else if (sectMap[sect]) {
      // 没有配置招式使用门派默认的
      const {move: sectMove} = sectMap[sect];
      const total = sectMove.length;
      for (let i = 0; i < moveNum - 1; i++) {
        moveList.push(sectMove[i]);
      }
      // 只有8招, 第7招使用第8个效果
      if (moveNum === 8) {
        moveList[6] = sectMove[7];
      }
      // 最后一招怒气大招默认门派最后一招
      moveList.push(sectMove[total - 1]);
    }
    for (let key of moveList) {
      const item = [...arrBase];
      if (typeof outMap[key] === 'function') {
        const moveItem = outMap[key](level);
        item.push(moveItem.effect);
      }
      arr.push([item.join('；')]);
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
    }
    item.move = arr;
  }
  return item;
}
</script>
