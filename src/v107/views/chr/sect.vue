<template>
  <v-tabs :list="list" key-name="id" v-model="active">
    <template #tab="{tab}">
      <span class="level-4">
        {{ tab.name }}
      </span>
    </template>
    <template #title="{info}">
      <span class="level-4">
        {{ info.name }}
      </span>
    </template>
    <div class="v-table v-table-vertical v-table-sect">
      <div class="tr">
        <div class="td">加入方式</div>
        <div class="td">{{ info.join }}</div>
      </div>
      <div class="tr">
        <div class="td">特技</div>
        <div class="td">
          <div class="td-block">
            <div
              class="td-effect-item effect-icon-star"
              v-for="(item, index) of info.effect"
              :key="index"
            >
              {{ item }}
            </div>
          </div>
          <div class="td-block color-warn" v-if="active !== 0">
            *成为掌门人有更高的门派武功连爆和威力加成，获得掌门印记，战场上敌方的本门弟子自动反水
          </div>
        </div>
      </div>
      <div class="tr">
        <div class="td">天赋</div>
        <div class="td">
          <div class="td-block color-warn">*仅选择门派开局的可以获得</div>
          <div class="td-block" v-for="(condition, id) in info.tal" :key="id">
            <div>
              [
              <span class="color-error">{{ talAll[id].name }}</span>
              ]:
              <span v-show="condition" class="color-success">{{ condition }}</span>
            </div>
            <div
              class="td-effect-item effect-icon-rhombus"
              v-for="(text, i) of talAll[id].effect"
              :key="i"
            >
              {{ text }}
            </div>
          </div>
        </div>
      </div>
      <div class="tr">
        <div class="td">
          <div class="td-block">武功</div>
        </div>
        <div class="td">
          <div class="td-block color-warn">
            *NPC处学习武功：中阶200贡献，高级400贡献+豪侠，绝学600贡献+宗师（需挑战门派掌门）
          </div>
          <div class="td-block color-warn">
            <span v-if="active === 0">
              *江湖武功不能学习绝学，除秘籍本身能一脉相承的，都不能一脉相承
            </span>
            <span v-else>
              *NPC处或者本门武功秘籍可以初阶→中阶→高阶→绝学，由低到高一脉相承，其中绝学需要挑战后才可一脉相承
            </span>
          </div>
          <div class="td-block" v-for="(item, type) of info.art" :key="type">
            <div v-if="type">
              [
              <span class="color-error">{{ itmTypeMap[type] }}</span>
              ]:
            </div>
            <div
              class="td-effect-item"
              v-for="(artList, level) of item"
              :key="level"
            >
              <span>{{ levelMap[level] }}：</span>
              <a
                href="javascript: void 0;"
                v-for="art of artList"
                :key="art.id"
                class="sect-art"
                :class="`level-${level}`"
                @click="showArt(art)"
              >
                {{ art.name }}
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </v-tabs>
  <v-dialog ref="dialogRef" :width="state.lessWindow ? '80vw' : undefined">
    <template #header>
      <span
        :class="[
          `level-${activeArt.level}`,
          {[`inner-${activeArt.inner}`]: activeArt.inner === 1 || activeArt.inner === 2},
        ]"
      >
        {{ activeArt.name }}
      </span>
    </template>
    <art-item v-if="activeArt.id" :item="activeArt" :key="activeArt.id"></art-item>
  </v-dialog>
</template>

<script setup>
import {computed, inject, ref, useTemplateRef} from 'vue';
import sectAll from '@/v107/data/art/sect';
import artAll from '@/v107/data/art/list';
import talAll from '@/v107/data/chr/talent';
import {itmTypeMap, levelMap} from '@/v107/data/map';
import {sessionStorage} from '@/utils/storage';
import ArtItem from '@/v107/views/art/item';
import VDialog from '@/components/dialog.vue';

const state = inject('state');
const list = computed(() => Object.values(sectAll));
const active = ref(0);

const dialogRef = useTemplateRef('dialogRef');
const activeArt = ref({});

function showArt(item) {
  activeArt.value = item;
  dialogRef.value.show();
}

const info = computed(() => {
  const cacheKey = `${state.version}_sect_${active.value}`;
  const cacheInfo = sessionStorage.get(cacheKey);
  if (cacheInfo) {
    return cacheInfo;
  }
  const current = JSON.parse(JSON.stringify(sectAll[active.value]));
  const sectArt = {};
  for (let id in artAll) {
    const item = artAll[id];
    if (item.sect !== active.value) {
      continue;
    }
    const {type, level} = item;
    if (!type) {
      continue;
    }
    if (!Reflect.has(sectArt, type)) {
      sectArt[type] = {};
    }
    if (!Reflect.has(sectArt[type], level)) {
      sectArt[type][level] = [];
    }
    sectArt[type][level].push(item);
  }
  current.art = sectArt;
  current.effect.push(...[
    '主运本门轻功，使用本门外功时命中+200',
    '本门武功威力增加50，每200门派贡献额外增加50；主运本门内功，本门武功威力增加：初阶内功50，中阶内功100，高阶内功150，绝学内功200，主运非本门内功此处威力加成减半',
    '修炼本门派武功，增加伤害5%；修炼本门派武功大于3个，增加伤害10%；修炼本门派武功大于7个，增加伤害20%，减少受到的伤害20%（取最大值）',
  ]);
  sessionStorage.set(cacheKey, current, {day: 1});
  return current;
});
</script>
<style lang="less">
.v-table-sect {
  .sect-art {
    margin-right: 8px;
  }
}
</style>
