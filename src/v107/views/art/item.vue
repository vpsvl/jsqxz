<template>
  <h5 class="tabs-content-title" v-if="titleVisible">
    <span
      :class="[
        `level-${info.level}`,
        {[`inner-${info.inner}`]: info.inner === 1 || info.inner === 2},
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
        <span>{{ info.cheat }}</span>
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
        {{ info.sectName }}
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
    <div class="tr" v-if="info.type < 6">
      <div class="td">气功</div>
      <div class="td">{{ info.power }}</div>
    </div>
    <div class="tr" v-if="info.type < 7">
      <div class="td">攻击范围</div>
      <div class="td">{{ info.range }}</div>
    </div>
    <div class="tr" v-if="info.type > 5">
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
    <template v-if="info.type < 6">
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
        <div class="td-block" v-for="(item, index) of info.inherit" :key="index">
          {{ item }}
        </div>
      </div>
    </div>
    <div class="tr">
      <div class="td">其他</div>
      <div class="td">
        <div class="td-block" v-for="item of info.tra" :key="item.id">
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
</template>
<script setup>
import {computed, inject} from 'vue';
import {sessionStorage} from '@/utils/storage';
import {formatArt} from '@/v107/data/art/effect/attr';

const props = defineProps({
  item: {
    type: Object,
    required: true,
  },
  titleVisible: {
    type: Boolean,
    default: false,
  },
});
const state = inject('state');
const info = computed(() => handleArtInfo(props.item));

function handleArtInfo(info = {}) {
  const cacheKey = `${state.version}_art_${info.id}`;
  const cacheInfo = sessionStorage.get(cacheKey);
  if (cacheInfo) {
    return cacheInfo;
  }
  const item = formatArt(info);
  sessionStorage.set(cacheKey, item);
  return item;
}
</script>
