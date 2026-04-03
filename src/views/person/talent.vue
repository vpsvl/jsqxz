<template>
  <div class="v-search">
    <div class="v-search-item">
      <span class="item-label">名称:</span>
      <v-input class="item-value" v-model="params.name"></v-input>
    </div>
    <div class="v-search-item">
      <v-button type="primary" @click="search">查询</v-button>
    </div>
  </div>
  <v-table class="v-table-kungfu-talent" :cols="thead" :data="totalList" :y="scrollY">
    <template #effect="{row}">
      <div class="td-block">
        <div class="td-effect-item" v-for="(item, index) of row.effect" :key="index">
          {{ item }}
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
  <!-- <v-pages
    v-model:page="pageConfig.page"
    :page-size="pageConfig.pageSize"
    :total="pageConfig.total"
    @update:page="changePage"
  ></v-pages> -->
</template>

<script setup>
import {ref, onBeforeMount, inject} from 'vue';
import data from '@/data/person/talent';
// import VPages from '@/components/pages.vue';

const state = inject('state');
const thead = [
  {
    key: 'name',
    name: '名称',
  },
  {
    key: 'effect',
    name: '效果',
  },
  {
    key: 'fortune',
    name: '福缘际遇',
    hidden: state.lessWindow,
  },
  {
    key: 'score',
    name: '分数',
    hidden: true,
  },
];
const params = ref({
  name: '',
});
const scrollY = ref(0);
const talentList = Object.values(data);
const totalList = ref([]);
// const tbody = computed(() => {
//   return totalList.value.slice(
//     pageConfig.pageSize * (pageConfig.page - 1),
//     pageConfig.pageSize * pageConfig.page,
//   );
// });

function search() {
  if (!params.value.name) {
    totalList.value = [...talentList];
    return;
  }
  totalList.value = talentList.filter((item) => {
    return new RegExp(params.value.name, 'i').test(item.name);
  });
}

function changePage() {
  scrollY.value = scrollY.value === 0 ? 1 : 0;
}

onBeforeMount(() => {
  search();
});
</script>
<style lang="less">
.v-table-kungfu-talent {
  --height-slide: 166px;

  .td {
    &:nth-child(1) {
      flex: 0 0 100px;
    }

    &:nth-child(2) {
      flex: 2 0 0;
    }

    // &:last-child {
    //   flex: 0 0 50px;
    // }
  }
}
</style>
