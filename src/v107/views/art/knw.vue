<template>
  <v-table
    class="v-table-art-other"
    :cols="thead"
    :data="tbody"
  >
    <template #get="{row}">
      <div class="td-block">
        <div
          class="td-effect-item effect-icon-rhombus"
          v-for="(item, index) of row.get"
          :key="index"
        >
          {{ item }}
        </div>
      </div>
    </template>
    <template #effect="{row}">
      <div
        class="td-block"
        v-for="(
          item, index
        ) of row.tra"
        :key="index"
      >
        <div v-if="item.name">
          [
          <span class="color-error">
            {{ item.name }}
          </span>
          ]:
          <span class="color-success">
            {{ item.condition }}
          </span>
        </div>
        <div
          class="td-effect-item"
          v-for="(text, i) of item.effect"
          :key="i"
        >
          {{ text }}
        </div>
      </div>
    </template>
  </v-table>
</template>

<script setup>
import {
  ref,
  inject,
  onBeforeMount,
  computed,
} from 'vue';
import itmAll from '@/v107/data/itm/list';
import {getTra} from '@/v107/data/art/effect/attr';

const state = inject('state');
const thead = ref([
  {
    key: 'name',
    name: '名称',
  },
  {
    key: 'get',
    name: '获取',
  },
  {
    key: 'condition',
    name: '条件',
    hidden: state.lessWindow,
  },
  {
    key: 'addition',
    name: '加成',
    hidden: state.lessWindow,
  },
  {
    key: 'effect',
    name: '效果',
  },
]);

const params = ref({
  keyword: '',
});
const all = computed(() => {
  const list = [];
  for (let id in itmAll) {
    const item = itmAll[id];
    if (item.type === 8) {
      item.tra = getTra({id, isCheat: true});
      list.push(item);
    }
  }
  return list;
});
const tbody = ref([]);

function search() {
  if (!params.value.keyword) {
    tbody.value = [...all.value];
    return;
  }
  tbody.value = all.value.filter(item => {
    const reg = new RegExp(params.value.keyword, 'i');
    if (reg.test(item.name)) {
      return true;
    }
    const traStr = JSON.stringify(item.tra);
    return reg.test(traStr);
  });
}

onBeforeMount(() => {
  search();
});
</script>

<style lang="less">
.v-table-art-other {
  .td:last-child {
    flex-grow: 3;
  }
}
</style>
