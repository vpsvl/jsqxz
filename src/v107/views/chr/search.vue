<template>
  <div class="v-search">
    <div class="v-search-item">
      <v-input class="item-value" placeholder="关键词" v-model="params.keyword"></v-input>
    </div>
    <div class="v-search-item">
      <v-button type="primary" @click="search">查询</v-button>
    </div>
  </div>
  <v-table class="v-table-chr" :cols="thead" :data="tbody">
    <template #talent="{row}">
      <div class="td-block" v-for="item of row.talent" :key="item.id">
        <div>
          [
          <span :class="`level-${item.level}`">
            {{ item.name }}
          </span>
          ]:
          <span class="color-error" v-if="row.id === item.id">（血脉）</span>
        </div>
        <div class="td-effect-item effect-icon-star" v-for="(text, i) of item.effect" :key="i">
          {{ text }}
        </div>
      </div>
      <div class="td-block" v-if="state.lessWindow && row.fortune.length > 0">
        <div class="color-error">[福缘际遇]</div>
        <div class="td-effect-item effect-icon-rhombus" v-for="(text, i) of row.fortune" :key="i">
          {{ text }}
        </div>
      </div>
    </template>
    <template #fortune="{row}">
      <div class="td-block">
        <div class="td-effect-item effect-icon-rhombus" v-for="(text, i) of row.fortune" :key="i">
          {{ text }}
        </div>
      </div>
    </template>
  </v-table>
</template>

<script setup>
import {ref, inject, onBeforeMount} from 'vue';
import talentMap from '@/v107/data/chr/talent';
import chrAll from '@/v107/data/chr';

const state = inject('state');

const thead = [
  {
    key: 'name',
    name: '名称',
  },
  {
    key: 'talent',
    name: '天赋',
  },
  {
    key: 'fortune',
    name: '福缘际遇',
    hidden: state.lessWindow,
  },
];
const tbody = ref([]);
const allData = ref([]);

function init() {
  allData.value = [];
  for (let id in chrAll) {
    const item = JSON.parse(JSON.stringify(chrAll[id]));
    const talentArr = [];
    const fortuneArr = [];
    for (let key of item.talent) {
      const {id, name, effect, level, fortune} = talentMap[key];
      talentArr.push({
        id,
        name,
        effect: effect.filter(i => import.meta.env.DEV || !/#hidden#$/.test(i)),
        level,
      });
      fortuneArr.push(...fortune);
    }
    item.talent = talentArr;
    item.fortune = fortuneArr;
    allData.value.push(item);
  }
  tbody.value = [...allData.value];
}

const params = ref({
  keyword: '',
});

function search() {
  params.value.keyword = (params.value.keyword + '').replace(/[\[\]{}"', ]/g, '');
  if (!params.value.keyword) {
    tbody.value = [...allData.value];
    return;
  }
  const reg = new RegExp(params.value.keyword, 'i');
  tbody.value = allData.value.filter(item => {
    const keyType = {
      name: 'string',
      talent: 'object',
      fortune: 'object',
    };
    let itemStr = '';
    for (let key in keyType) {
      itemStr += keyType[key] === 'object' ? JSON.stringify(item[key]) : item[key];
    }
    return reg.test(itemStr);
  });
}

onBeforeMount(() => {
  init();
});
</script>
<style lang="less">
.v-table-chr {
  --height-slide: 130px;

  .td {
    &:nth-child(1) {
      flex: 0 0 100px;
    }

    &:nth-child(2) {
      flex: 2 0 0;
    }
  }
}
</style>
