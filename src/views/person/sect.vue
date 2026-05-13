<template>
  <div class="v-tabs">
    <div class="tabs">
      <label class="tab" v-for="item of list" :key="item.id">
        <input type="radio" name="cheat" :value="item.id" v-model="active" />
        <span class="level-4">
          {{ item.name }}
        </span>
      </label>
    </div>
    <h5 class="tabs-content-title" v-show="info.name">
      <span class="level-4">
        {{ info.name }}
      </span>
    </h5>
    <div class="v-table v-table-vertical">
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
            <div class="td-effect-item effect-icon-star">主运本门轻功，使用本门外功时命中+200</div>
            <div class="td-effect-item effect-icon-star">修炼本门派武功大于5个，增加伤害10%</div>
            <div class="td-effect-item effect-icon-star">
              修炼本门派武功大于8个，增加伤害20%，减少受到的伤害20%
            </div>
          </div>
          <div class="td-block color-success" v-if="active !== 0">
            *成为掌门人有更高的门派武功连爆和威力加成，获得掌门印记，战场上敌方的本门弟子自动反水
          </div>
        </div>
      </div>
      <div class="tr">
        <div class="td">天赋</div>
        <div class="td">
          <div class="td-block" v-for="(item, index) of info.talent" :key="index">
            <div v-if="item.name">
              [
              <span class="color-error">{{ item.name }}</span>
              ]:
              <span class="color-success">{{ item.condition }}</span>
            </div>
            <div
              class="td-effect-item effect-icon-rhombus"
              v-for="(text, i) of item.effect"
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
          <div class="td-block color-success">
            *NPC处学习武功：中阶200贡献，高级400贡献+豪侠，绝学600贡献+宗师
          </div>
          <div class="td-block color-success">
            <span v-if="active === 0">*江湖武功除秘籍本身能一脉相承的，都不能一脉相承</span>
            <span v-else>
              *NPC处初阶中阶高阶可以一脉相承，绝学除轻功外都不能一脉相承，初阶轻功也可以使用本门的绝学轻功秘籍一脉相承
            </span>
          </div>
          <div class="td-block" v-for="(item, index) of info.kungfu" :key="index">
            <div v-if="item.name">
              [
              <span class="color-error">{{ item.name }}</span>
              ]:
            </div>
            <div class="td-effect-item" v-for="(text, i) of item.list" :key="i">{{ text }}</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import {computed, ref} from 'vue';
import sectAll from '@/data/person/sect';

const list = computed(() => Object.values(sectAll));
const active = ref(0);

const info = computed(() => sectAll[active.value]);
</script>
