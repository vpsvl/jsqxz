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
    <template #condition="{row}">
      <div class="td-block">
        <template v-if="row.cheatList.length === 1">修炼</template>
        <template v-for="(item, index) of row.cheatList" :key="item.id">
          <template v-if="item.isCheat">
            <template v-if="index > 0">{{ item.symbol }}</template>
            <span>{{ item.name }}</span>
          </template>
          <template v-if="!item.isCheat">
            <template v-if="index > 0">{{ item.symbol }}</template>
            <a
              href="javascript: void 0;"
              :class="`level-${item.level}`"
              @click="showArt(item)"
            >
              {{ item.name }}
            </a>
          </template>
        </template>
        <span>{{ row.condition }}</span>
      </div>
    </template>
    <template #effect="{row}">
      <div class="td-block">
        <div class="td-effect-item" v-for="(item, index) of row.effect" :key="index">
          {{ item }}
        </div>
      </div>
    </template>
  </v-table>
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
import {ref, onBeforeMount, useTemplateRef, inject} from 'vue';
import secretData from '@/v107/data/art/secret';
import artAll from '@/v107/data/art/list';
import itmAll from '@/v107/data/itm/list';
import VDialog from '@/components/dialog';
import ArtItem from '@/v107/views/art/item';

const state = inject('state');
const dialogRef = useTemplateRef('dialogRef');
const activeArt = ref({});

function showArt(item) {
  activeArt.value = item;
  dialogRef.value.show();
}

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
    if (type === 0) {
      continue;
    }
    if (typeof condition === 'string') {
      data.value.push({
        id,
        name,
        condition,
        cheatList: [],
        effect,
        type,
      });
      continue;
    }
    const arr = [];
    let other = '';
    for (let k in cheat) {
      if (k === 'other') {
        other = cheat[k];
        continue;
      }
      const isArrCheat = Array.isArray(cheat[k]);
      const artId = itmAll[k].art;
      if (artId) {
        arr.push({
          ...artAll[artId],
          isCheat: false,
          symbol: '+',
        });
        if (isArrCheat) {
          for (let j of cheat[k]) {
            const artId = itmAll[j].art;
            arr.push({
              ...artAll[artId],
              isCheat: false,
              symbol: '/',
            });
          }
        }
      } else {
        arr.push({
          ...itmAll[k],
          isCheat: true,
          symbol: '+',
        });
        if (isArrCheat) {
          for (let j of cheat[k]) {
            arr.push({
              ...itmAll[j],
              isCheat: true,
              symbol: '/',
            });
          }
        }
      }
    }
    if (other && arr.length > 0) {
      other = `，${other}`;
    }
    if (type === 2) {
      other += '（非秘技，需在武功面板）';
    }
    data.value.push({
      id,
      name,
      condition: other,
      cheatList: arr,
      effect,
      type,
    });
  }
  tbody.value = [...data.value];
}

function search() {
  params.value.keyword = (params.value.keyword + '').replace(/[\[\]{}"', ]/g, '');
  if (!params.value.keyword) {
    tbody.value = [...data.value];
    return;
  }
  tbody.value = data.value.filter(item => {
    let {name, condition, cheatList, effect} = item;
    const reg = new RegExp(params.value.keyword, 'i');
    for (let i of cheatList) {
      condition += ` ${i.name}`;
    }
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
