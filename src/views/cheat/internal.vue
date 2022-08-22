<template>
  <v-tabs :list="cheat.list" :exclusive="cheat.exclusive">
    <template #tab="{tab}">
      <span :class="{[`level-${tab.level}`]: tab.level, [`internal-${tab.internal}`]: tab.internal}">
        {{ tab.name }}
      </span>
    </template>
    <template #title="{info}">
      <span :class="[`level-${info.level}`, {[`internal-${info.internal}`]: info.internal}]">
        {{ info.name }}
      </span>
    </template>
    <template #default="{info}">
      <div class="v-table v-table-vertical">
        <div class="tr" v-for="(name, val) in thead" :key="val">
          <div class="td">{{ name }}</div>
          <div class="td">{{ info[val] }}</div>
        </div>
        <div class="tr">
          <div class="td">主运效果</div>
          <div class="td">
            <div class="td-block">
              <div class="td-effect-item" v-for="(item, index) of info.initiative" :key="index" v-text="item"></div>
            </div>
          </div>
        </div>
        <div class="tr">
          <div class="td">其他</div>
          <div class="td">
            <div class="td-block" v-for="(item, index) of info.peculiar" :key="index">
              <div v-if="item.name">
                [
                <span class="color-error">{{ item.name }}</span>
                ]:
                <span class="color-success">{{ item.condition }}</span>
              </div>
              <div class="td-effect-item" v-for="(text, i) of item.effect" :key="i" v-text="text"></div>
            </div>
          </div>
        </div>
      </div>
    </template>
  </v-tabs>
</template>

<script setup>
import {ref, watchEffect} from 'vue';
import {useRoute} from 'vue-router';
import internal from '@/data/cheat/internal';
import fly from '@/data/cheat/fly';

const route = useRoute();

const all = {internal, fly};
const thead = {
  get: '获取方式',
  power: '威力',
  condition: '修炼条件',
  addition: '修炼加成',
};
const cheat = ref({});
watchEffect(() => {
  cheat.value = {list: []};
  const {type} = route.meta;
  const data = all[type] ? all[type] : {list: []};
  cheat.value = data;
});
</script>
