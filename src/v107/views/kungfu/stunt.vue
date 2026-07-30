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
  <v-table class="v-table-kungfu-stunt" :cols="thead" :data="tbody">
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
import stuntData from '@/v107/data/kungfu/stunt';
import kungfuAll from '@/v107/data/kungfu/list';
import goodsAll from '@/v107/data/map/goods';

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
  for (let key in stuntData) {
    let {id, name, type, condition, effect, kungfu, cheat} = stuntData[key];
    if (type === 0) {
      continue;
    }
    if (!condition) {
      const kungfuLength = Object.keys(kungfu).length;
      const arr = [];
      let other = '';
      if (kungfuLength > 0) {
        for (let id in kungfu) {
          if (id === 'other') {
            other = kungfu[id];
            continue;
          }
          if (Array.isArray(kungfu[id])) {
            let item = kungfuAll[id].name;
            for (let j of kungfu[id]) {
              item += `/${kungfuAll[j].name}`;
            }
            arr.push(item);
          } else {
            arr.push(kungfuAll[id].name);
          }
        }
      } else {
        for (let id in cheat) {
          if (id === 'other') {
            other = cheat[id];
            continue;
          }
          if (Array.isArray(cheat[id])) {
            let item = goodsAll[id];
            for (let j of cheat[id]) {
              item += `/${goodsAll[j]}`;
            }
            arr.push(item);
          } else {
            arr.push(goodsAll[id]);
          }
        }
      }
      condition = (arr.length > 1 ? '' : '修炼') + arr.join('+');
      if (other) {
        condition += (arr.length > 0 ? '，' : '') + other;
      }
      if (type === 2) {
        condition += '（非秘技，需都在武功面板）';
      }
      data.value.push({
        id,
        name,
        condition,
        effect,
        type,
      });
    }
  }
  tbody.value = [...data.value];
}

function search() {
  tbody.value = data.value.filter(item => {
    const {name, condition, effect} = item;
    const reg = new RegExp(params.value.keyword, 'i');
    let flag = reg.test(name) || reg.test(condition);
    if (!flag) {
      for (let item of effect) {
        if (reg.test(item)) {
          flag = true;
          break;
        }
      }
    }
    if (flag) {
      tbody.value.push(stuntData[key]);
    }
  });
}

onBeforeMount(() => {
  init();
});
</script>
<style lang="less">
.v-table-kungfu-stunt {
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
