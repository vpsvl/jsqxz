<template>
  <div class="v-search">
    <div class="v-search-item">
      <v-input
        class="item-value"
        v-model="params.keyword"
        placeholder="名称/条件/效果查询"
      ></v-input>
    </div>
    <div class="v-search-item">
      <v-button type="primary" @click="search">查询</v-button>
    </div>
  </div>
  <v-table class="v-table-art-secret" :cols="thead" :data="tbody">
    <template #effect="{row}">
      <div class="td-block">
        <div class="td-effect-item" v-for="(item, index) of row.effect" :key="index">
          {{ item }}
        </div>
      </div>
    </template>
  </v-table>
</template>

<script setup>
import {ref, onBeforeMount} from 'vue';
import secretData from '@/v107/data/art/secret';
import artAll from '@/v107/data/art/list';
import itmAll from '@/v107/data/itm/list';

const thead = [
  {
    key: 'name',
    name: '名称',
  },
  {
    key: 'condition',
    name: '条件',
  },
  {
    key: 'effect',
    name: '效果',
  },
];
const params = ref({
  keyword: '',
});
const data = ref([]);
const tbody = ref([]);

function init() {
  data.value = [];
  for (let key in secretData) {
    let {id, name, type, condition, effect, cheat} = secretData[key];
    if (type === 0 || condition) {
      continue;
    }
    const arr = [];
    let other = '';
    for (let k in cheat) {
      if (k === 'other') {
        other = cheat[k];
        continue;
      }
      let item = '';
      const isArrCheat = Array.isArray(cheat[k]);
      const artId = itmAll[k].art;
      if (!artId) {
        item += itmAll[k].name;
        if (isArrCheat) {
          for (let j of cheat[k]) {
            item += `/${itmAll[j].name}`;
          }
        }
      } else {
        item += artAll[artId].name;
        if (isArrCheat) {
          for (let j of cheat[k]) {
            const artId = itmAll[j].art;
            item += `/${artAll[artId].name}`;
          }
        }
      }
      arr.push(item);
    }
    condition = (arr.length > 1 ? '' : '修炼') + arr.join('+');
    if (other) {
      condition += (arr.length > 0 ? '，' : '') + other;
    }
    if (type === 2) {
      condition += '（非秘技，需在武功面板）';
    }
    data.value.push({
      id,
      name,
      condition,
      effect,
      type,
    });
  }
  tbody.value = [...data.value];
}

function search() {
  tbody.value = data.value.filter(item => {
    const {name, condition, effect} = item;
    const reg = new RegExp(params.value.keyword, 'i');
    if (reg.test(name) || reg.test(condition)) {
      return true;
    }
    for (let item of effect) {
      if (reg.test(item)) {
        return true;
      }
    }
    return false;
  });
}

onBeforeMount(() => {
  init();
});
</script>
<style lang="less">
.v-table-art-secret {
  --height-slide: 130px;

  .td {
    &:nth-child(1) {
      flex: 0 0 110px;
    }

    &:nth-child(3) {
      flex-grow: 2;
    }
  }
}
</style>
